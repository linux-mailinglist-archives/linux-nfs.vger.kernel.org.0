Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2823A48EA
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jun 2021 20:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhFKTAU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Jun 2021 15:00:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:2682 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhFKTAU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Jun 2021 15:00:20 -0400
IronPort-SDR: 5Oy9vgq2YUxSCZZJxqGzi4geMp5FPx0GPX4d7hU7Nl3CntbeL+hdSiLe5AINZCZIIDbzRe9tfC
 tPjXTbJXhZTw==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="205406049"
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="205406049"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 11:58:22 -0700
IronPort-SDR: gN+ja3pIT4cBtaf0tiBQcX6OD8Gvmeaz2XJHtJrXwuIJOy4mO5Y3vTvjlt+g8UQrh2yom0hXcS
 noEH2TAvuU9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="414544379"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jun 2021 11:58:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6CF78E7; Fri, 11 Jun 2021 21:58:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 1/1] kernel.h: Split out kstrtox() and simple_strtox() to a separate header
Date:   Fri, 11 Jun 2021 21:58:15 +0300
Message-Id: <20210611185815.44103-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

kernel.h is being used as a dump for all kinds of stuff for a long time.
Here is the attempt to start cleaning it up by splitting out kstrtox()
and simple_strtox() helpers.

At the same time convert users in header and lib folders to use new header.
Though for time being include new header back to kernel.h to avoid twisted
indirected includes for existing users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kernel.h       | 143 +-------------------------------
 include/linux/kstrtox.h      | 155 +++++++++++++++++++++++++++++++++++
 include/linux/string.h       |   7 --
 include/linux/sunrpc/cache.h |   1 +
 lib/kstrtox.c                |   5 +-
 lib/parser.c                 |   1 +
 6 files changed, 161 insertions(+), 151 deletions(-)
 create mode 100644 include/linux/kstrtox.h

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index baea2eb763d0..7bb0a5cb7d57 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/bitops.h>
+#include <linux/kstrtox.h>
 #include <linux/log2.h>
 #include <linux/math.h>
 #include <linux/minmax.h>
@@ -180,148 +181,6 @@ static inline void might_fault(void) { }
 void do_exit(long error_code) __noreturn;
 void complete_and_exit(struct completion *, long) __noreturn;
 
-/* Internal, do not use. */
-int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
-int __must_check _kstrtol(const char *s, unsigned int base, long *res);
-
-int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
-int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
-
-/**
- * kstrtoul - convert a string to an unsigned long
- * @s: The start of the string. The string must be null-terminated, and may also
- *  include a single newline before its terminating null. The first character
- *  may also be a plus sign, but not a minus sign.
- * @base: The number base to use. The maximum supported base is 16. If base is
- *  given as 0, then the base of the string is automatically detected with the
- *  conventional semantics - If it begins with 0x the number will be parsed as a
- *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
- *  parsed as an octal number. Otherwise it will be parsed as a decimal.
- * @res: Where to write the result of the conversion on success.
- *
- * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Preferred over simple_strtoul(). Return code must be checked.
-*/
-static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
-{
-	/*
-	 * We want to shortcut function call, but
-	 * __builtin_types_compatible_p(unsigned long, unsigned long long) = 0.
-	 */
-	if (sizeof(unsigned long) == sizeof(unsigned long long) &&
-	    __alignof__(unsigned long) == __alignof__(unsigned long long))
-		return kstrtoull(s, base, (unsigned long long *)res);
-	else
-		return _kstrtoul(s, base, res);
-}
-
-/**
- * kstrtol - convert a string to a long
- * @s: The start of the string. The string must be null-terminated, and may also
- *  include a single newline before its terminating null. The first character
- *  may also be a plus sign or a minus sign.
- * @base: The number base to use. The maximum supported base is 16. If base is
- *  given as 0, then the base of the string is automatically detected with the
- *  conventional semantics - If it begins with 0x the number will be parsed as a
- *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
- *  parsed as an octal number. Otherwise it will be parsed as a decimal.
- * @res: Where to write the result of the conversion on success.
- *
- * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Preferred over simple_strtol(). Return code must be checked.
- */
-static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
-{
-	/*
-	 * We want to shortcut function call, but
-	 * __builtin_types_compatible_p(long, long long) = 0.
-	 */
-	if (sizeof(long) == sizeof(long long) &&
-	    __alignof__(long) == __alignof__(long long))
-		return kstrtoll(s, base, (long long *)res);
-	else
-		return _kstrtol(s, base, res);
-}
-
-int __must_check kstrtouint(const char *s, unsigned int base, unsigned int *res);
-int __must_check kstrtoint(const char *s, unsigned int base, int *res);
-
-static inline int __must_check kstrtou64(const char *s, unsigned int base, u64 *res)
-{
-	return kstrtoull(s, base, res);
-}
-
-static inline int __must_check kstrtos64(const char *s, unsigned int base, s64 *res)
-{
-	return kstrtoll(s, base, res);
-}
-
-static inline int __must_check kstrtou32(const char *s, unsigned int base, u32 *res)
-{
-	return kstrtouint(s, base, res);
-}
-
-static inline int __must_check kstrtos32(const char *s, unsigned int base, s32 *res)
-{
-	return kstrtoint(s, base, res);
-}
-
-int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
-int __must_check kstrtos16(const char *s, unsigned int base, s16 *res);
-int __must_check kstrtou8(const char *s, unsigned int base, u8 *res);
-int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
-int __must_check kstrtobool(const char *s, bool *res);
-
-int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
-int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
-int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
-int __must_check kstrtol_from_user(const char __user *s, size_t count, unsigned int base, long *res);
-int __must_check kstrtouint_from_user(const char __user *s, size_t count, unsigned int base, unsigned int *res);
-int __must_check kstrtoint_from_user(const char __user *s, size_t count, unsigned int base, int *res);
-int __must_check kstrtou16_from_user(const char __user *s, size_t count, unsigned int base, u16 *res);
-int __must_check kstrtos16_from_user(const char __user *s, size_t count, unsigned int base, s16 *res);
-int __must_check kstrtou8_from_user(const char __user *s, size_t count, unsigned int base, u8 *res);
-int __must_check kstrtos8_from_user(const char __user *s, size_t count, unsigned int base, s8 *res);
-int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *res);
-
-static inline int __must_check kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)
-{
-	return kstrtoull_from_user(s, count, base, res);
-}
-
-static inline int __must_check kstrtos64_from_user(const char __user *s, size_t count, unsigned int base, s64 *res)
-{
-	return kstrtoll_from_user(s, count, base, res);
-}
-
-static inline int __must_check kstrtou32_from_user(const char __user *s, size_t count, unsigned int base, u32 *res)
-{
-	return kstrtouint_from_user(s, count, base, res);
-}
-
-static inline int __must_check kstrtos32_from_user(const char __user *s, size_t count, unsigned int base, s32 *res)
-{
-	return kstrtoint_from_user(s, count, base, res);
-}
-
-/*
- * Use kstrto<foo> instead.
- *
- * NOTE: simple_strto<foo> does not check for the range overflow and,
- *	 depending on the input, may give interesting results.
- *
- * Use these functions if and only if you cannot use kstrto<foo>, because
- * the conversion ends on the first non-digit character, which may be far
- * beyond the supported range. It might be useful to parse the strings like
- * 10x50 or 12:21 without altering original string or temporary buffer in use.
- * Keep in mind above caveat.
- */
-
-extern unsigned long simple_strtoul(const char *,char **,unsigned int);
-extern long simple_strtol(const char *,char **,unsigned int);
-extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
-extern long long simple_strtoll(const char *,char **,unsigned int);
-
 extern int num_to_str(char *buf, int size,
 		      unsigned long long num, unsigned int width);
 
diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
new file mode 100644
index 000000000000..529974e22ea7
--- /dev/null
+++ b/include/linux/kstrtox.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KSTRTOX_H
+#define _LINUX_KSTRTOX_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/* Internal, do not use. */
+int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
+int __must_check _kstrtol(const char *s, unsigned int base, long *res);
+
+int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
+int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
+
+/**
+ * kstrtoul - convert a string to an unsigned long
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null. The first character
+ *  may also be a plus sign, but not a minus sign.
+ * @base: The number base to use. The maximum supported base is 16. If base is
+ *  given as 0, then the base of the string is automatically detected with the
+ *  conventional semantics - If it begins with 0x the number will be parsed as a
+ *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
+ *  parsed as an octal number. Otherwise it will be parsed as a decimal.
+ * @res: Where to write the result of the conversion on success.
+ *
+ * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
+ * Preferred over simple_strtoul(). Return code must be checked.
+*/
+static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
+{
+	/*
+	 * We want to shortcut function call, but
+	 * __builtin_types_compatible_p(unsigned long, unsigned long long) = 0.
+	 */
+	if (sizeof(unsigned long) == sizeof(unsigned long long) &&
+	    __alignof__(unsigned long) == __alignof__(unsigned long long))
+		return kstrtoull(s, base, (unsigned long long *)res);
+	else
+		return _kstrtoul(s, base, res);
+}
+
+/**
+ * kstrtol - convert a string to a long
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null. The first character
+ *  may also be a plus sign or a minus sign.
+ * @base: The number base to use. The maximum supported base is 16. If base is
+ *  given as 0, then the base of the string is automatically detected with the
+ *  conventional semantics - If it begins with 0x the number will be parsed as a
+ *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
+ *  parsed as an octal number. Otherwise it will be parsed as a decimal.
+ * @res: Where to write the result of the conversion on success.
+ *
+ * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
+ * Preferred over simple_strtol(). Return code must be checked.
+ */
+static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
+{
+	/*
+	 * We want to shortcut function call, but
+	 * __builtin_types_compatible_p(long, long long) = 0.
+	 */
+	if (sizeof(long) == sizeof(long long) &&
+	    __alignof__(long) == __alignof__(long long))
+		return kstrtoll(s, base, (long long *)res);
+	else
+		return _kstrtol(s, base, res);
+}
+
+int __must_check kstrtouint(const char *s, unsigned int base, unsigned int *res);
+int __must_check kstrtoint(const char *s, unsigned int base, int *res);
+
+static inline int __must_check kstrtou64(const char *s, unsigned int base, u64 *res)
+{
+	return kstrtoull(s, base, res);
+}
+
+static inline int __must_check kstrtos64(const char *s, unsigned int base, s64 *res)
+{
+	return kstrtoll(s, base, res);
+}
+
+static inline int __must_check kstrtou32(const char *s, unsigned int base, u32 *res)
+{
+	return kstrtouint(s, base, res);
+}
+
+static inline int __must_check kstrtos32(const char *s, unsigned int base, s32 *res)
+{
+	return kstrtoint(s, base, res);
+}
+
+int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
+int __must_check kstrtos16(const char *s, unsigned int base, s16 *res);
+int __must_check kstrtou8(const char *s, unsigned int base, u8 *res);
+int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
+int __must_check kstrtobool(const char *s, bool *res);
+
+int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
+int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
+int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
+int __must_check kstrtol_from_user(const char __user *s, size_t count, unsigned int base, long *res);
+int __must_check kstrtouint_from_user(const char __user *s, size_t count, unsigned int base, unsigned int *res);
+int __must_check kstrtoint_from_user(const char __user *s, size_t count, unsigned int base, int *res);
+int __must_check kstrtou16_from_user(const char __user *s, size_t count, unsigned int base, u16 *res);
+int __must_check kstrtos16_from_user(const char __user *s, size_t count, unsigned int base, s16 *res);
+int __must_check kstrtou8_from_user(const char __user *s, size_t count, unsigned int base, u8 *res);
+int __must_check kstrtos8_from_user(const char __user *s, size_t count, unsigned int base, s8 *res);
+int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *res);
+
+static inline int __must_check kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)
+{
+	return kstrtoull_from_user(s, count, base, res);
+}
+
+static inline int __must_check kstrtos64_from_user(const char __user *s, size_t count, unsigned int base, s64 *res)
+{
+	return kstrtoll_from_user(s, count, base, res);
+}
+
+static inline int __must_check kstrtou32_from_user(const char __user *s, size_t count, unsigned int base, u32 *res)
+{
+	return kstrtouint_from_user(s, count, base, res);
+}
+
+static inline int __must_check kstrtos32_from_user(const char __user *s, size_t count, unsigned int base, s32 *res)
+{
+	return kstrtoint_from_user(s, count, base, res);
+}
+
+/*
+ * Use kstrto<foo> instead.
+ *
+ * NOTE: simple_strto<foo> does not check for the range overflow and,
+ *	 depending on the input, may give interesting results.
+ *
+ * Use these functions if and only if you cannot use kstrto<foo>, because
+ * the conversion ends on the first non-digit character, which may be far
+ * beyond the supported range. It might be useful to parse the strings like
+ * 10x50 or 12:21 without altering original string or temporary buffer in use.
+ * Keep in mind above caveat.
+ */
+
+extern unsigned long simple_strtoul(const char *,char **,unsigned int);
+extern long simple_strtol(const char *,char **,unsigned int);
+extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
+extern long long simple_strtoll(const char *,char **,unsigned int);
+
+static inline int strtobool(const char *s, bool *res)
+{
+	return kstrtobool(s, res);
+}
+
+#endif	/* _LINUX_KSTRTOX_H */
diff --git a/include/linux/string.h b/include/linux/string.h
index 9521d8cab18e..b48d2d28e0b1 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -2,7 +2,6 @@
 #ifndef _LINUX_STRING_H_
 #define _LINUX_STRING_H_
 
-
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
@@ -184,12 +183,6 @@ extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
 
 extern bool sysfs_streq(const char *s1, const char *s2);
-extern int kstrtobool(const char *s, bool *res);
-static inline int strtobool(const char *s, bool *res)
-{
-	return kstrtobool(s, res);
-}
-
 int match_string(const char * const *array, size_t n, const char *string);
 int __sysfs_match_string(const char * const *array, size_t n, const char *s);
 
diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index d0965e2997b0..b134b2b3371c 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -14,6 +14,7 @@
 #include <linux/kref.h>
 #include <linux/slab.h>
 #include <linux/atomic.h>
+#include <linux/kstrtox.h>
 #include <linux/proc_fs.h>
 
 /*
diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 0b5fe8b41173..059b8b00dc53 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -14,11 +14,12 @@
  */
 #include <linux/ctype.h>
 #include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/math64.h>
 #include <linux/export.h>
+#include <linux/kstrtox.h>
+#include <linux/math64.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+
 #include "kstrtox.h"
 
 const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
diff --git a/lib/parser.c b/lib/parser.c
index f1a6d90b8c34..bcb23484100e 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -6,6 +6,7 @@
 #include <linux/ctype.h>
 #include <linux/types.h>
 #include <linux/export.h>
+#include <linux/kstrtox.h>
 #include <linux/parser.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-- 
2.30.2

