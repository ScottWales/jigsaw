.PHONY:all clean check
all:$(BIN) check
clean:
check:$(TESTBIN)

# Default rules
$(BINDIR)/%:$(OBJDIR)/%.o
	@mkdir -pv $(dir $@)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
$(OBJDIR)/%.o:$(SRCDIR)/%.c
	@mkdir -pv $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c -<
$(LIBDIR)/%.a:
	ar rcs $@ $^

