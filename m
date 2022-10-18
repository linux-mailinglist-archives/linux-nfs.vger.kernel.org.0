Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B24602A87
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 13:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJRLsC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 07:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJRLsB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 07:48:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABB366A4A
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 04:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1728861500
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 11:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CA1C433D7;
        Tue, 18 Oct 2022 11:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666093679;
        bh=FfsSVlPrH2TcBzSsTWCOr8rajYOFPeh5IshXhO5BkEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GS/yxqfRRJHhlGL5ZsbCJ0vzxqG+5RMEBjs3Zb6LQzIU/lg73ewX1sv2KrwAAKNVL
         exzpqmvbHBdl9U7GAVy0Y8e7QUP1j4vo8wsiidEzPGkEOJT0I+sxK7NR3bVIVhtMSW
         4+4tKgVvMx4plUNwwHJkYbT4HhaX/KiRWPobe6jZ6z3QfcuBeZ6qYc0MzqAbVQjbmd
         VB44gxsraVf7ugV5SKf7CyaXIsTnxOeBDY5T/8LxrZgnDzz0BB2kLb3dspwvw/akTS
         kYextrJdPiN3p9XabPwtXrjqmRAsTwW7NjVL+C6CqmSsBsmQRLfH3rLQzBFNCILJlq
         wuhoNHKZKWv3w==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     tom@talpey.com, linux-nfs@vger.kernel.org
Subject: [PATCH v3 3/3] nfsd: allow disabling NFSv2 at compile time
Date:   Tue, 18 Oct 2022 07:47:56 -0400
Message-Id: <20221018114756.23679-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221018114756.23679-1-jlayton@kernel.org>
References: <20221018114756.23679-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

rpc.nfsd stopped supporting NFSv2 a year ago. Take the next logical
step toward deprecating it and allow NFSv2 support to be compiled out.

Add a new CONFIG_NFSD_V2 option that can be turned off and rework the
CONFIG_NFSD_V?_ACL option dependencies. Add a description that
discourages enabling it.

Also, change the description of CONFIG_NFSD to state that the always-on
version is now 3 instead of 2.

Finally, add an #ifdef around "case 2:" in __write_versions. When NFSv2
is disabled at compile time, this should make the kernel ignore attempts
to disable it at runtime, but still error out when trying to enable it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/Kconfig  | 19 +++++++++++++++----
 fs/nfsd/Makefile |  5 +++--
 fs/nfsd/nfsctl.c |  2 ++
 fs/nfsd/nfsd.h   |  3 +--
 fs/nfsd/nfssvc.c |  6 ++++++
 5 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index f6a2fd3015e7..7c441f2bd444 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -8,6 +8,7 @@ config NFSD
 	select SUNRPC
 	select EXPORTFS
 	select NFS_ACL_SUPPORT if NFSD_V2_ACL
+	select NFS_ACL_SUPPORT if NFSD_V3_ACL
 	depends on MULTIUSER
 	help
 	  Choose Y here if you want to allow other computers to access
@@ -26,19 +27,29 @@ config NFSD
 
 	  Below you can choose which versions of the NFS protocol are
 	  available to clients mounting the NFS server on this system.
-	  Support for NFS version 2 (RFC 1094) is always available when
+	  Support for NFS version 3 (RFC 1813) is always available when
 	  CONFIG_NFSD is selected.
 
 	  If unsure, say N.
 
-config NFSD_V2_ACL
-	bool
+config NFSD_V2
+	bool "NFS server support for NFS version 2 (DEPRECATED)"
 	depends on NFSD
+	default n
+	help
+	  NFSv2 (RFC 1094) was the first publicly-released version of NFS.
+	  Unless you are hosting ancient (1990's era) NFS clients, you don't
+	  need this.
+
+	  If unsure, say N.
+
+config NFSD_V2_ACL
+	bool "NFS server support for the NFSv2 ACL protocol extension"
+	depends on NFSD_V2
 
 config NFSD_V3_ACL
 	bool "NFS server support for the NFSv3 ACL protocol extension"
 	depends on NFSD
-	select NFSD_V2_ACL
 	help
 	  Solaris NFS servers support an auxiliary NFSv3 ACL protocol that
 	  never became an official part of the NFS version 3 protocol.
diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index 805c06d5f1b4..6fffc8f03f74 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -10,9 +10,10 @@ obj-$(CONFIG_NFSD)	+= nfsd.o
 # this one should be compiled first, as the tracing macros can easily blow up
 nfsd-y			+= trace.o
 
-nfsd-y 			+= nfssvc.o nfsctl.o nfsproc.o nfsfh.o vfs.o \
-			   export.o auth.o lockd.o nfscache.o nfsxdr.o \
+nfsd-y 			+= nfssvc.o nfsctl.o nfsfh.o vfs.o \
+			   export.o auth.o lockd.o nfscache.o \
 			   stats.o filecache.o nfs3proc.o nfs3xdr.o
+nfsd-$(CONFIG_NFSD_V2) += nfsproc.o nfsxdr.o
 nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
 nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
 nfsd-$(CONFIG_NFSD_V4)	+= nfs4proc.o nfs4xdr.o nfs4state.o nfs4idmap.o \
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 68ed42fd29fc..d1e581a60480 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -581,7 +581,9 @@ static ssize_t __write_versions(struct file *file, char *buf, size_t size)
 
 			cmd = sign == '-' ? NFSD_CLEAR : NFSD_SET;
 			switch(num) {
+#ifdef CONFIG_NFSD_V2
 			case 2:
+#endif
 			case 3:
 				nfsd_vers(nn, num, cmd);
 				break;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 09726c5b9a31..93b42ef9ed91 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -64,8 +64,7 @@ struct readdir_cd {
 
 
 extern struct svc_program	nfsd_program;
-extern const struct svc_version	nfsd_version2, nfsd_version3,
-				nfsd_version4;
+extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
 extern struct mutex		nfsd_mutex;
 extern spinlock_t		nfsd_drc_lock;
 extern unsigned long		nfsd_drc_max_mem;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index bfbd9f672f59..62e473b0ca52 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -91,8 +91,12 @@ unsigned long	nfsd_drc_mem_used;
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static struct svc_stat	nfsd_acl_svcstats;
 static const struct svc_version *nfsd_acl_version[] = {
+# if defined(CONFIG_NFSD_V2_ACL)
 	[2] = &nfsd_acl_version2,
+# endif
+# if defined(CONFIG_NFSD_V3_ACL)
 	[3] = &nfsd_acl_version3,
+# endif
 };
 
 #define NFSD_ACL_MINVERS            2
@@ -116,7 +120,9 @@ static struct svc_stat	nfsd_acl_svcstats = {
 #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
 
 static const struct svc_version *nfsd_version[] = {
+#if defined(CONFIG_NFSD_V2)
 	[2] = &nfsd_version2,
+#endif
 	[3] = &nfsd_version3,
 #if defined(CONFIG_NFSD_V4)
 	[4] = &nfsd_version4,
-- 
2.37.3

