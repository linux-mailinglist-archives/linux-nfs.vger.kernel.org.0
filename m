Return-Path: <linux-nfs+bounces-6557-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3AF97CB62
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 17:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2821F27897
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 15:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DE41A256C;
	Thu, 19 Sep 2024 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="VWc5dKzE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F161A286D
	for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2024 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726758672; cv=none; b=EFrr5eD7trQYdqyni+3V9XcCX8zv7vR/iqN3vHffdw813Jj651Wl0KB7b79ZYDkm4xBDBg4z6IonXZA03seem1XlzT7f+tAy49jtrt7Hk4dGKYj5abR9f5On+ZqKPccgpjw9O9LQjurTJKY0p3uEPJamkJx+EO5Vps9AxlY8z04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726758672; c=relaxed/simple;
	bh=X9gSmsKJ/fusKmXc8SA0fTXefuPiHV9nYRpBPmDJTP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ThJ06cnClDP/jaxdkB1HJYCSw/PKUyqUaEnLackno2YJjSdiOqRcDnctdZOdQ4BzNaC8EOchshoFCiLmoonnZ0YV8dc5KnK4V7KmX0V8Y/9LjWYm/OWX/WIzZJ3ZxzzmfJqEdhFhRS9Bm4Sr2yi7gyMvCH5yCBM1aSlsF3FoNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=VWc5dKzE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb2191107so7831045e9.1
        for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2024 08:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1726758619; x=1727363419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CjlgF2xmJoIF9XScTq5TmINqj5rhq6DzsZNldDLx9vY=;
        b=VWc5dKzE/trCT50Mabivx/otAxFGc4q4GmxsUKoZUUZRYF9uDCxkgyUhkezQ4X+a19
         3hzyQGFzXrXSQGqZHEl7npGK989Z7impVnNfM8AjwaFfl9ZG4CozQOq1MxrBUS5ZaXLu
         8Glgs/JhJc44wHeG4FFV+vsCqe/97jBFiQCJEFnCQvIHvrb6sgJwnemPLXL7bnT8Ldq1
         7rZZfxIKXHPiVIPCQBBQ6y9sek81OdPYqT4IyVW8Z1iSz2tD44RwybtPCwtLLuxJm81t
         gwMupodfPy2WqZf+obDguyImpajHPnxBxJyP4NpunYbsrcQjGrR40Np+ecT+U3l5aF+M
         5Q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726758619; x=1727363419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjlgF2xmJoIF9XScTq5TmINqj5rhq6DzsZNldDLx9vY=;
        b=agda3ib1bvNU5NTeg0O8PBFrphs8V8wM9o24m0jL73QooEutfTJjiNdhyXTVzYdH19
         gQ5+cqWy8P9Rnl3ceyJ2GcUIZlgy/SpzHzox9ASgQ1cK1meOnwLxvWLUF3d3GZgVhgtz
         xLDTsemhDD9NMo/u7uv2Bvp8TP9PoPytS88C42Ehpi3M89dxpLikA0+HCRpPSgtBOktC
         ++gVSjMIY4W+WHp5BLE84kxLTYDc5dkSpeHUgU8io3uRDewx2dbQOPxS+o9/YDzeZYiC
         oXae2jgzDOcXsOI9poN6H6TeySUQ7RGYTEqLKYUI5o2CJQQDlcFPTT/u7WRWOPEOgAFo
         fuuw==
X-Gm-Message-State: AOJu0YzTIp6VX3fM0Ilg9C5EtbF9B0CSqeISzEG1t7j+HiibONJW9N7G
	Q7IkgcnOpwnN6IKAbowDQCtJ0Pr1QMvQ7lH23SoB5b+1I9qe3/y2m/4MNYxcwNoC3M164lZfXYt
	O
X-Google-Smtp-Source: AGHT+IFgLvWMRnCLABK9zfCMJSem32dn2tJRkHsoTs85RbQeGBPVW5fOzIPqZjH+59QqOAGEueOWdw==
X-Received: by 2002:a05:600c:1550:b0:42c:a8cb:6a96 with SMTP id 5b1f17b1804b1-42cdb5721eamr177973485e9.31.1726758618943;
        Thu, 19 Sep 2024 08:10:18 -0700 (PDT)
Received: from jupiter.vstd.int ([176.230.79.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7544506asm24118715e9.27.2024.09.19.08.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 08:10:17 -0700 (PDT)
From: Dan Aloni <dan.aloni@vastdata.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] mount.nfs: improve EPROTO error message for RDMA mounts
Date: Thu, 19 Sep 2024 18:10:15 +0300
Message-ID: <20240919151015.536917-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mounting NFS shares using RDMA, users may encounter this rather
unclear error message:

    mount.nfs: Protocol error

Often there are either no RDMA interfaces existing, or that routing is
being done via other interfaces. This patch enhances the `mount_error`
function to provide a more informative message in such cases.

Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 utils/mount/error.c     | 12 +++++++++++-
 utils/mount/error.h     |  4 +++-
 utils/mount/network.c   |  2 +-
 utils/mount/network.h   |  2 ++
 utils/mount/nfs4mount.c |  2 +-
 utils/mount/nfsmount.c  |  2 +-
 utils/mount/stropts.c   |  8 ++++----
 utils/mount/utils.c     |  6 +++---
 8 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/utils/mount/error.c b/utils/mount/error.c
index 9ddbcc096f72..d6cbdea1933b 100644
--- a/utils/mount/error.c
+++ b/utils/mount/error.c
@@ -40,6 +40,7 @@
 #include "nls.h"
 #include "mount.h"
 #include "error.h"
+#include "network.h"
 
 #ifdef HAVE_RPCSVC_NFS_PROT_H
 #include <rpcsvc/nfs_prot.h>
@@ -199,7 +200,8 @@ void sys_mount_errors(char *server, int error, int will_retry, int bg)
  * @error: errno value to report
  *
  */
-void mount_error(const char *spec, const char *mount_point, int error)
+void mount_error(const char *spec, const char *mount_point, int error,
+		 struct mount_options *options)
 {
 	switch(error) {
 	case EACCES:
@@ -250,6 +252,14 @@ void mount_error(const char *spec, const char *mount_point, int error)
 	case EALREADY:
 		/* Error message has already been provided */
 		break;
+	case EPROTO:
+		if (options && po_rightmost(options, nfs_transport_opttbl) == 2)
+			nfs_error(_("%s: %s: is routing being done via an interface supporting RDMA?"),
+				  progname, strerror(error));
+		else
+			nfs_error(_("%s: %s"),
+				  progname, strerror(error));
+		break;
 	default:
 		nfs_error(_("%s: %s for %s on %s"),
 			  progname, strerror(error), spec, mount_point);
diff --git a/utils/mount/error.h b/utils/mount/error.h
index ef80fd079b48..f9f282233563 100644
--- a/utils/mount/error.h
+++ b/utils/mount/error.h
@@ -24,9 +24,11 @@
 #ifndef _NFS_UTILS_MOUNT_ERROR_H
 #define _NFS_UTILS_MOUNT_ERROR_H
 
+#include "parse_opt.h"
+
 char *nfs_strerror(unsigned int);
 
-void mount_error(const char *, const char *, int);
+void mount_error(const char *, const char *, int, struct mount_options *);
 void rpc_mount_errors(char *, int, int);
 void sys_mount_errors(char *, int, int, int);
 
diff --git a/utils/mount/network.c b/utils/mount/network.c
index 01ead49f0008..64293f6f8d51 100644
--- a/utils/mount/network.c
+++ b/utils/mount/network.c
@@ -88,7 +88,7 @@ static const char *nfs_nfs_pgmtbl[] = {
 	NULL,
 };
 
-static const char *nfs_transport_opttbl[] = {
+const char *nfs_transport_opttbl[] = {
 	"udp",
 	"tcp",
 	"rdma",
diff --git a/utils/mount/network.h b/utils/mount/network.h
index 0fc98acd4bcb..26f4eec775df 100644
--- a/utils/mount/network.h
+++ b/utils/mount/network.h
@@ -93,4 +93,6 @@ void mnt_closeclnt(CLIENT *, int);
 int nfs_umount_do_umnt(struct mount_options *options,
 		       char **hostname, char **dirname);
 
+extern const char *nfs_transport_opttbl[];
+
 #endif	/* _NFS_UTILS_MOUNT_NETWORK_H */
diff --git a/utils/mount/nfs4mount.c b/utils/mount/nfs4mount.c
index 3e4f1e255ca7..0fe142a7843e 100644
--- a/utils/mount/nfs4mount.c
+++ b/utils/mount/nfs4mount.c
@@ -469,7 +469,7 @@ int nfs4mount(const char *spec, const char *node, int flags,
 	if (!fake) {
 		if (mount(spec, node, "nfs4",
 				flags & ~(MS_USER|MS_USERS), &data)) {
-			mount_error(spec, node, errno);
+			mount_error(spec, node, errno, NULL);
 			goto fail;
 		}
 	}
diff --git a/utils/mount/nfsmount.c b/utils/mount/nfsmount.c
index 3d95da9456de..a1c92fe83fa0 100644
--- a/utils/mount/nfsmount.c
+++ b/utils/mount/nfsmount.c
@@ -858,7 +858,7 @@ noauth_flavors:
 	if (!fake) {
 		if (mount(spec, node, "nfs",
 				flags & ~(MS_USER|MS_USERS), &data)) {
-			mount_error(spec, node, errno);
+			mount_error(spec, node, errno, NULL);
 			goto fail;
 		}
 	}
diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index a92c420011a4..2d5fa1f2e86e 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -1143,7 +1143,7 @@ static int nfsmount_fg(struct nfsmount_info *mi)
 		}
 	}
 
-	mount_error(mi->spec, mi->node, errno);
+	mount_error(mi->spec, mi->node, errno, mi->options);
 	return EX_FAIL;
 }
 
@@ -1160,7 +1160,7 @@ static int nfsmount_parent(struct nfsmount_info *mi)
 		return EX_SUCCESS;
 
 	if (nfs_is_permanent_error(errno)) {
-		mount_error(mi->spec, mi->node, errno);
+		mount_error(mi->spec, mi->node, errno, mi->options);
 		return EX_FAIL;
 	}
 
@@ -1237,7 +1237,7 @@ static int nfs_remount(struct nfsmount_info *mi)
 {
 	if (nfs_sys_mount(mi, mi->options))
 		return EX_SUCCESS;
-	mount_error(mi->spec, mi->node, errno);
+	mount_error(mi->spec, mi->node, errno, mi->options);
 	return EX_FAIL;
 }
 
@@ -1261,7 +1261,7 @@ static int nfsmount_start(struct nfsmount_info *mi)
 	 * NFS v2 has been deprecated
 	 */
 	if (mi->version.major == 2) {
-		mount_error(mi->spec, mi->node, EOPNOTSUPP);
+		mount_error(mi->spec, mi->node, EOPNOTSUPP, mi->options);
 		return EX_FAIL;
 	}
 
diff --git a/utils/mount/utils.c b/utils/mount/utils.c
index 865a4a05f3fc..b7562a474f88 100644
--- a/utils/mount/utils.c
+++ b/utils/mount/utils.c
@@ -123,15 +123,15 @@ int chk_mountpoint(const char *mount_point)
 	struct stat sb;
 
 	if (stat(mount_point, &sb) < 0){
-		mount_error(NULL, mount_point, errno);
+		mount_error(NULL, mount_point, errno, NULL);
 		return 1;
 	}
 	if (S_ISDIR(sb.st_mode) == 0){
-		mount_error(NULL, mount_point, ENOTDIR);
+		mount_error(NULL, mount_point, ENOTDIR, NULL);
 		return 1;
 	}
 	if (getuid() != 0 && geteuid() != 0 && access(mount_point, X_OK) < 0) {
-		mount_error(NULL, mount_point, errno);
+		mount_error(NULL, mount_point, errno, NULL);
 		return 1;
 	}
 
-- 
2.43.5


