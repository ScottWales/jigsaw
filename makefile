#==================================================
# Target list (Rules below)
#==================================================
.PHONY:all clean check doc
all:$(BIN) check doc

#==================================================
# What to build
#==================================================
SRCDIR=src
BINSRC:=$(wildcard $(SRCDIR)/bin/*.c)
TESTSRC:=$(wildcard $(SRCDIR)/test/*.c)
BIN=$(patsubst $(SRCDIR)/bin/%.c,$(BINDIR)/%,$(BINSRC))
TEST=$(patsubst $(SRCDIR)/test/%.c,$(TESTDIR)/%,$(TESTSRC))

#==================================================
# Where to put it
#==================================================
# ALL THESE DIRECTORIES ARE SCRATCH!!!
# make clean will remove them, do not put into source
# control
BINDIR =bin
TESTDIR=test
OBJDIR =obj
LIBDIR =lib
DOCDIR =doc

#==================================================
# Rules
#==================================================
RM=rm -rvf
clean:
	$(RM) $(BINDIR) $(TESTDIR) $(OBJDIR) $(LIBDIR) $(DOCDIR)

# Run each test, reporting failures (nonzero exits)
# Return an error code with the number of failed tests
check:$(TEST)
	@failed=0;\
	for test in $^; do\
	    $$test;\
	    if [ $$? != 0 ]; then \
		echo "$$test failed";\
		failed=$$(( $$failed + 1 )); \
	    fi;\
	    done;\
	    exit $$failed

doc:

#==================================================
# Default rules
#==================================================
$(BINDIR)/%:$(OBJDIR)/bin/%.o
	@mkdir -pv $(dir $@)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
$(TESTDIR)/%:$(OBJDIR)/test/%.o
	@mkdir -pv $(dir $@)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
$(OBJDIR)/%.o:$(SRCDIR)/%.c
	@mkdir -pv $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<
$(LIBDIR)/%.a:
	@mkdir -pv $(dir $@)
	ar rcs $@ $^

