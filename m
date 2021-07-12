Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47393C5DF2
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jul 2021 16:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhGLOJg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jul 2021 10:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhGLOJg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jul 2021 10:09:36 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E5C0613DD
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jul 2021 07:06:47 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so18961359otp.8
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jul 2021 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CDl7OvUwISJhIrvFtfoErlsb4VJZ0IUvlPV+f00MwV0=;
        b=AFKnFkkYSye0Oz7hvHqyD96j9s35YpWhKPg4YKox0PVP83vc69WtXrGWNulhd76YiG
         t0M8JOiUJjnpoFW4pUMH2UlH2fB2Q6UMfeb5Jp17/I+fOOt+HcdARwmZkNz+dhwHmsah
         Aa/kU8dByeMVMLTiwPf48nUrJZGpL4GgpPr8TAIqItEUyGBbt8wX++9b8/2mCE1rplLb
         Tfgu5u52/sr3mLQlK7NnE/sb4jhNQ7xDM/nIKnVqJhDcm/UR31OOlGhB+N25EU3LlGgu
         w29QjNvrUcHQLjbAJ9R4aCXStfuBKjeRujWsntyj+cnxm8zStzKOUJFzlY1jAvgssfd8
         eT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CDl7OvUwISJhIrvFtfoErlsb4VJZ0IUvlPV+f00MwV0=;
        b=doYlFv6ttP2VwwQc/iLUISA1Rr3KdEy0Dsv0pZCG7Xn7R59Cqf2fb40xRKIw5PV3UJ
         NTJ/HOmdXtUqEpb9nMthK5lE/i3SxSs/4W1rAXDAs6Zla0bhrXa60+49dfRzhVzGJlCr
         /p5g2V7m/JTfozkeJXLbi5n8kv79iqGoPsC8JCoAGBzBA3sUBmsOXWxirtbbXHNc4t9q
         J1zvIP1SL7GldeumWQbBJAal3JnwZpflWpMRI3I+PhgRIDNa9EGLjzfxqA+1ywQRDJI2
         BMokMODJ57OGPuwKh/CT6g89jI2k29svyufF8czWfAFQ4j5BbJMiZtGfeC+9wgGbxpa9
         CHkg==
X-Gm-Message-State: AOAM530OUWjHyAkSj4UCmgEvTqmGrVUx2Lhc4PRDACo80fKs9DoxwMi+
        x/N3YkZaSukur+vkkYMhnUQV1vSrC30=
X-Google-Smtp-Source: ABdhPJyEyJlg52ufM9y413rbUdJ+o6/2vL5eRrnjk9YcsvfSLwY94wI8x06OV/Orl3lp7OjEdvI4+A==
X-Received: by 2002:a9d:5e15:: with SMTP id d21mr39335092oti.280.1626098806207;
        Mon, 12 Jul 2021 07:06:46 -0700 (PDT)
Received: from james-x399.localdomain (97-118-178-184.hlrn.qwest.net. [97.118.178.184])
        by smtp.gmail.com with ESMTPSA id e17sm1951634oiw.33.2021.07.12.07.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 07:06:45 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 1/1] Fix non-default statedir paths.
Date:   Mon, 12 Jul 2021 08:06:34 -0600
Message-Id: <20210712140634.4151943-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 configure.ac                                  | 19 +++++++++++++++++++
 systemd/Makefile.am                           |  5 ++++-
 systemd/rpc-pipefs-generator.c                |  2 +-
 systemd/rpc_pipefs.target                     |  3 ---
 systemd/rpc_pipefs.target.in                  |  3 +++
 ....mount => var-lib-nfs-rpc_pipefs.mount.in} |  2 +-
 utils/blkmapd/device-discovery.c              |  2 +-
 utils/gssd/gssd.h                             |  2 +-
 utils/idmapd/idmapd.c                         |  2 +-
 9 files changed, 31 insertions(+), 9 deletions(-)
 delete mode 100644 systemd/rpc_pipefs.target
 create mode 100644 systemd/rpc_pipefs.target.in
 rename systemd/{var-lib-nfs-rpc_pipefs.mount => var-lib-nfs-rpc_pipefs.mount.in} (84%)

diff --git a/configure.ac b/configure.ac
index 93520a80..bc2d0f02 100644
--- a/configure.ac
+++ b/configure.ac
@@ -688,9 +688,28 @@ AC_SUBST([ACLOCAL_AMFLAGS], ["-I $ac_macro_dir \$(ACLOCAL_FLAGS)"])
 AC_SUBST([_sysconfdir])
 AC_CONFIG_COMMANDS_PRE([eval eval _sysconfdir=$sysconfdir])
 
+# make _statedir available for substituion in config files
+# 2 "evals" needed late to expand variable names.
+AC_SUBST([_statedir])
+AC_CONFIG_COMMANDS_PRE([eval eval _statedir=$statedir])
+
+if test "$statedir" = "/var/lib/nfs"; then
+	rpc_pipefsmount="var-lib-nfs-rpc_pipefs.mount"
+else
+	rpc_pipefsmount="$(systemd-escape -p "$statedir/rpc_pipefs").mount"
+fi
+AC_SUBST(rpc_pipefsmount)
+
+# make _rpc_pipefsmount available for substituion in config files
+# 2 "evals" needed late to expand variable names.
+AC_SUBST([_rpc_pipefsmount])
+AC_CONFIG_COMMANDS_PRE([eval eval _rpc_pipefsmount=$rpc_pipefsmount])
+
 AC_CONFIG_FILES([
 	Makefile
 	systemd/rpc-gssd.service
+	systemd/rpc_pipefs.target
+	systemd/var-lib-nfs-rpc_pipefs.mount
 	linux-nfs/Makefile
 	support/Makefile
 	support/export/Makefile
diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index 650ad25c..8c7b676f 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -12,7 +12,9 @@ unit_files =  \
     rpc-statd-notify.service \
     rpc-statd.service \
     \
-    proc-fs-nfsd.mount \
+    proc-fs-nfsd.mount
+
+rpc_pipefs_mount_file = \
     var-lib-nfs-rpc_pipefs.mount
 
 if CONFIG_NFSV4
@@ -75,4 +77,5 @@ genexec_PROGRAMS = nfs-server-generator rpc-pipefs-generator
 install-data-hook: $(unit_files)
 	mkdir -p $(DESTDIR)/$(unitdir)
 	cp $(unit_files) $(DESTDIR)/$(unitdir)
+	cp $(rpc_pipefs_mount_file) $(DESTDIR)/$(unitdir)/$(rpc_pipefsmount)
 endif
diff --git a/systemd/rpc-pipefs-generator.c b/systemd/rpc-pipefs-generator.c
index 8e218aa7..c24db567 100644
--- a/systemd/rpc-pipefs-generator.c
+++ b/systemd/rpc-pipefs-generator.c
@@ -21,7 +21,7 @@
 #include "conffile.h"
 #include "systemd.h"
 
-#define RPC_PIPEFS_DEFAULT "/var/lib/nfs/rpc_pipefs"
+#define RPC_PIPEFS_DEFAULT NFS_STATEDIR "/rpc_pipefs"
 
 static int generate_mount_unit(const char *pipefs_path, const char *pipefs_unit,
 			       const char *dirname)
diff --git a/systemd/rpc_pipefs.target b/systemd/rpc_pipefs.target
deleted file mode 100644
index 01d4d278..00000000
--- a/systemd/rpc_pipefs.target
+++ /dev/null
@@ -1,3 +0,0 @@
-[Unit]
-Requires=var-lib-nfs-rpc_pipefs.mount
-After=var-lib-nfs-rpc_pipefs.mount
diff --git a/systemd/rpc_pipefs.target.in b/systemd/rpc_pipefs.target.in
new file mode 100644
index 00000000..332f62b6
--- /dev/null
+++ b/systemd/rpc_pipefs.target.in
@@ -0,0 +1,3 @@
+[Unit]
+Requires=@_rpc_pipefsmount@
+After=@_rpc_pipefsmount@
diff --git a/systemd/var-lib-nfs-rpc_pipefs.mount b/systemd/var-lib-nfs-rpc_pipefs.mount.in
similarity index 84%
rename from systemd/var-lib-nfs-rpc_pipefs.mount
rename to systemd/var-lib-nfs-rpc_pipefs.mount.in
index 26d1c763..4c5d6ce4 100644
--- a/systemd/var-lib-nfs-rpc_pipefs.mount
+++ b/systemd/var-lib-nfs-rpc_pipefs.mount.in
@@ -6,5 +6,5 @@ Conflicts=umount.target
 
 [Mount]
 What=sunrpc
-Where=/var/lib/nfs/rpc_pipefs
+Where=@_statedir@/rpc_pipefs
 Type=rpc_pipefs
diff --git a/utils/blkmapd/device-discovery.c b/utils/blkmapd/device-discovery.c
index 77ebe736..2736ac89 100644
--- a/utils/blkmapd/device-discovery.c
+++ b/utils/blkmapd/device-discovery.c
@@ -63,7 +63,7 @@
 #define EVENT_SIZE (sizeof(struct inotify_event))
 #define EVENT_BUFSIZE (1024 * EVENT_SIZE)
 
-#define RPCPIPE_DIR	"/var/lib/nfs/rpc_pipefs"
+#define RPCPIPE_DIR	NFS_STATEDIR "/rpc_pipefs"
 #define PID_FILE	"/run/blkmapd.pid"
 
 #define CONF_SAVE(w, f) do {			\
diff --git a/utils/gssd/gssd.h b/utils/gssd/gssd.h
index c52c5b48..519dc431 100644
--- a/utils/gssd/gssd.h
+++ b/utils/gssd/gssd.h
@@ -39,7 +39,7 @@
 #include <pthread.h>
 
 #ifndef GSSD_PIPEFS_DIR
-#define GSSD_PIPEFS_DIR		"/var/lib/nfs/rpc_pipefs"
+#define GSSD_PIPEFS_DIR		NFS_STATEDIR "/rpc_pipefs"
 #endif
 #define DNOTIFY_SIGNAL		(SIGRTMIN + 3)
 
diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index 51c71fbb..e2c160e8 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -73,7 +73,7 @@
 #include "nfslib.h"
 
 #ifndef PIPEFS_DIR
-#define PIPEFS_DIR  "/var/lib/nfs/rpc_pipefs/"
+#define PIPEFS_DIR  NFS_STATEDIR "/rpc_pipefs/"
 #endif
 
 #ifndef NFSD_DIR
-- 
2.25.1

