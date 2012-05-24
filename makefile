# Target list (Rules below)
.PHONY:all clean check doc
all:$(BIN) check
clean:
check:$(TESTBIN)
doc:

# What to build
BINSRC:=$(wildcard src/bin/*.c)
TESTSRC:=$(wildcard src/test/*.c)

# Where to put it
SRCDIR =src
BINDIR =bin
TESTDIR=test
OBJDIR =obj
LIBDIR =lib
DOCDIR =doc

# Rules
RM=rm -rvf
clean:
	$(RM) $(BINDIR) $(TESTDIR) $(OBJDIR) $(LIBDIR) $(DOCDIR)

# Default rules
$(BINDIR)/%:$(OBJDIR)/bin/%.o
	@mkdir -pv $(dir $@)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
$(TESTDIR)/%:$(OBJDIR)/test/%.o
	@mkdir -pv $(dir $@)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
$(OBJDIR)/%.o:$(SRCDIR)/%.c
	@mkdir -pv $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c -<
$(LIBDIR)/%.a:
	@mkdir -pv $(dir $@)
	ar rcs $@ $^

