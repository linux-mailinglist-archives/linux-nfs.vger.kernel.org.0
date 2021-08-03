Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53693DEEBD
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Aug 2021 15:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbhHCNH4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 09:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbhHCNHz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Aug 2021 09:07:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FEEC061757
        for <linux-nfs@vger.kernel.org>; Tue,  3 Aug 2021 06:07:44 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so4583789pjh.3
        for <linux-nfs@vger.kernel.org>; Tue, 03 Aug 2021 06:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vqnq+GqGCT2QlWvo/tK1RbZnXqzSqrUcMYm54/QCzqM=;
        b=qjpU282BxxpW6lg61Z+zifFhjt3+SE9Q/cNcXQibVrOBQCXfkNy4dq+UC6Tu661/xJ
         pJ+yDLuDv7xDn5WctSUis5dDfLXcK0FyABWuo2rElX5jv/Ej/CmdVuSe5X9z9CXJJcSy
         qdmem3ls0fZI6TfAr8GP0KeqSy9Z3R9T8SmHGMo1aiYoHbXI59f11rfxVy1Ibt3hRkk8
         fShxSNsgYGm2PYFyMGKeqsa4kiGLTsC1ADNho1k9PR2fHCJxH0nyQYn1kgJoSoXmMrTJ
         PnS5Bzz1J9df9c9Ugomz6EdKQ9+qUToQTrvaL85tUc3AiJmsMxEsVSWkbDdp18Wde5ok
         QeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vqnq+GqGCT2QlWvo/tK1RbZnXqzSqrUcMYm54/QCzqM=;
        b=esNKlyh3zlxEab9KmvthZ1lWr3PDxnprya+A8+CfO5VfZPQkW0kivAIQ8X4pCw4b0j
         7FxOvSfht6bBmqPjkxxfcbp9JTc+ik7KNPRgRRm0+tf2Y1BDwf4RCMBcPHCocLnnVTR/
         o9Kq8w4hj2DVNxRW86iMlJwf7//n1VGoK4Oxu1eAD3siSxqNruWfEFrQrehjoKE9C/5s
         YUQcuFwqn9++FpnIPQLbXW8dp5udJhMJsc1+BAzwCFyD1ioEWiTGsxkS8GDXUINFV6+x
         oY/QHgASiMmIoKL7zQ32na90u/WAmV08KYc+WVgy8xO2VmEzdTLbbNVSxsMOhyp3Keb5
         4aeQ==
X-Gm-Message-State: AOAM532de7eiQJn3jkMP2trMIkRRRSZTm8j3SXN9PSjwFKzEjLJSPTuc
        gUVxh1EYPSzvqay0lDiV8zw=
X-Google-Smtp-Source: ABdhPJzh+i1u48l9910EahR3NHTaHmwa8du3WAYbCY8EKmwWcDC0eTRPkk7jShsTlHnhQGQZBJWuvg==
X-Received: by 2002:a17:90b:3905:: with SMTP id ob5mr23200432pjb.211.1627996063673;
        Tue, 03 Aug 2021 06:07:43 -0700 (PDT)
Received: from nyarly.redhat.com ([179.233.244.167])
        by smtp.gmail.com with ESMTPSA id p2sm7516539pfn.141.2021.08.03.06.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 06:07:43 -0700 (PDT)
From:   Thiago Rafael Becker <trbecker@gmail.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Thiago Becker <tbecker@redhat.com>,
        Thiago Rafael Becker <trbecker@gmail.com>
Subject: [RFC PATCH] mount.nfs: Add readahead option
Date:   Tue,  3 Aug 2021 10:07:17 -0300
Message-Id: <20210803130717.2890565-1-trbecker@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Linux kernel defined the default read ahead to 128KiB, and this is
making read perform poorly. To mitigate it, add readahead as a mount
option that is handled by userspace, with some refactoring included.

Signed-off-by: Thiago Rafael Becker <trbecker@gmail.com>
---
 utils/mount/mount.c | 114 ++++++++++++++++++++++++++++++++++++++++----
 utils/mount/nfs.man |   3 ++
 2 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/utils/mount/mount.c b/utils/mount/mount.c
index b98f9e00..15076ca8 100644
--- a/utils/mount/mount.c
+++ b/utils/mount/mount.c
@@ -56,9 +56,11 @@ int nomtab;
 int verbose;
 int sloppy;
 int string;
+static int readahead_kb = 0;
 
 #define FOREGROUND	(0)
 #define BACKGROUND	(1)
+#define READAHEAD_VALUE_LEN 24
 
 static struct option longopts[] = {
   { "fake", 0, 0, 'f' },
@@ -292,6 +294,16 @@ static int add_mtab(char *spec, char *mount_point, char *fstype,
 	return result;
 }
 
+static void append_extra_opt(const char *opt, char *extra_opts, size_t len) {
+	len -= strlen(extra_opts);
+
+	if (*extra_opts && --len > 0)
+		strcat(extra_opts, ",");
+
+	if ((len -= strlen(opt)) > 0)
+		strcat(extra_opts, opt);
+}
+
 static void parse_opt(const char *opt, int *mask, char *extra_opts, size_t len)
 {
 	const struct opt_map *om;
@@ -306,13 +318,37 @@ static void parse_opt(const char *opt, int *mask, char *extra_opts, size_t len)
 		}
 	}
 
-	len -= strlen(extra_opts);
+	append_extra_opt(opt, extra_opts, len);
+}
 
-	if (*extra_opts && --len > 0)
-		strcat(extra_opts, ",");
+static void parse_opt_val(const char *opt, const char *val, char *extra_opts, size_t len)
+{
+	size_t ov_len;
+	char *opt_val;
 
-	if ((len -= strlen(opt)) > 0)
-		strcat(extra_opts, opt);
+	/* readahead is a special value that is handled by userspace */
+	if (!strcmp(opt,  "readahead")) {
+		char *endptr = NULL;
+		const char *expected_endptr = val + strlen(val);
+
+		readahead_kb = strtol(val, &endptr, 10);
+
+		if (endptr != expected_endptr) {
+			nfs_error(_("%s: invalid readahead value %s"),
+				       progname, val);
+			readahead_kb = 0;
+		}
+		return;
+	}
+
+	/* Send the option to the kernel. */
+	ov_len = strlen(opt) + strlen(val) + 3;
+	opt_val = malloc(sizeof(char) * ov_len);
+	snprintf(opt_val, ov_len, ",%s=%s", opt, val);
+
+	append_extra_opt(opt_val, extra_opts, len);
+
+	free(opt_val);
 }
 
 /*
@@ -325,7 +361,7 @@ static void parse_opts(const char *options, int *flags, char **extra_opts)
 {
 	if (options != NULL) {
 		char *opts = xstrdup(options);
-		char *opt, *p;
+		char *opt, *p, *val = NULL;
 		size_t len = strlen(opts) + 1;	/* include room for a null */
 		int open_quote = 0;
 
@@ -341,17 +377,75 @@ static void parse_opts(const char *options, int *flags, char **extra_opts)
 				continue;	/* still in a quoted block */
 			if (*p == ',')
 				*p = '\0';	/* terminate the option item */
+			if (*p == '=') {        /* key=val option */
+				if (!val) {
+					*p = '\0';      /* terminate key */
+					val = ++p;      /* start the value */
+				}
+			}
 
 			/* end of option item or last item */
 			if (*p == '\0' || *(p + 1) == '\0') {
-				parse_opt(opt, flags, *extra_opts, len);
-				opt = NULL;
+				if (val) {
+					parse_opt_val(opt, val, *extra_opts, len);
+				} else
+					parse_opt(opt, flags, *extra_opts, len);
+				opt = val = NULL;
 			}
 		}
 		free(opts);
 	}
 }
 
+/*
+ * Set the read ahead value for the mount point. On failure, uses the default kernel
+ * read ahead value (for new mounts) or the current value (for remounts).
+ */
+static void set_readahead(const char *mount_point) {
+	int error;
+	struct statx mp_stat;
+	char *mount_point_readahead_file, value[READAHEAD_VALUE_LEN];
+	size_t len;
+	int fp;
+
+	/* If readahead_kb is unset, or set to 0, do not change the value */
+	if (!readahead_kb)
+		return;
+
+	if ((error = statx(0, mount_point, 0, 0, &mp_stat)) != 0) {
+		goto out_error;
+	}
+
+	if (!(mount_point_readahead_file = malloc(PATH_MAX))) {
+		error = -ENOMEM;
+		goto out_error;
+	}
+
+	snprintf(mount_point_readahead_file, PATH_MAX, "/sys/class/bdi/%d:%d/read_ahead_kb",
+			mp_stat.stx_dev_major, mp_stat.stx_dev_minor);
+
+	len = snprintf(value, READAHEAD_VALUE_LEN, "%d", readahead_kb);
+
+	if ((fp = open(mount_point_readahead_file, O_WRONLY)) < 0) {
+		error = errno;
+		goto out_free;
+	}
+
+	if ((error = write(fp, value, len)) < 0)
+		goto out_close;
+
+	close(fp);
+	return;
+
+out_close:
+	close(fp);
+out_free:
+	free(mount_point_readahead_file);
+out_error:
+	nfs_error(_("%s: unable to set readahead value, using default kernel value (error = %d)\n"),
+			progname, error);
+}
+
 static int try_mount(char *spec, char *mount_point, int flags,
 			char *fs_type, char **extra_opts, char *mount_opts,
 			int fake, int bg)
@@ -373,8 +467,10 @@ static int try_mount(char *spec, char *mount_point, int flags,
 	if (ret)
 		return ret;
 
-	if (!fake)
+	if (!fake) {
+		set_readahead(mount_point);
 		print_one(spec, mount_point, fs_type, mount_opts);
+	}
 
 	return add_mtab(spec, mount_point, fs_type, flags, *extra_opts);
 }
diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index f1b76936..9832a377 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -561,6 +561,9 @@ The
 .B sloppy
 option is an alternative to specifying
 .BR mount.nfs " -s " option.
+.TP 1.5i
+.B readahead=n
+Set the read ahead of the mount to n KiB. This is handled entirely in userspace and will not appear on mountinfo. If unset or set to 0, it will not set the a value, using the current value (for a remount) or the kernel default for a new mount.
 
 .SS "Options for NFS versions 2 and 3 only"
 Use these options, along with the options in the above subsection,
-- 
2.31.1

