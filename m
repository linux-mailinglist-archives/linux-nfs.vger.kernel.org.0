Return-Path: <linux-nfs+bounces-3609-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D23900697
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00B53B287BA
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C2B196C85;
	Fri,  7 Jun 2024 14:27:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC74319753B
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770448; cv=none; b=SJs5LhCfG+1goDrguyMRFw751wRbPB8UPSLzbNwaNkZu84Kco6rQKhQprX9Bp0JTxMkCCNUG4mYYAHSRC9HSNNCLTm3beX7soErcP++7Q9Hs3rNwS92OsAgobWFuFHUhpoe+a7ZlEZTM3UF1wJZXnD/qFhgkJXYQpu8WOMNIUE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770448; c=relaxed/simple;
	bh=A+2fLiFo76+gMsxFLYRpGESaYePUS5G/Z+9XAHeuJl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nra1cpBXMKJFN55ghqUY0UORz5KZMzKnC1/2iXSevZoW00C2sdcFGVOdWwLwT5tABOltQqDoTbtFWR2a6Ityxrwu+bGI3Q6vz0kX6p0JmLI2h8udPmLm2OOeMUtjY72ZbC1HIjKQH3NmjRYbBtKj9WhNlaWSE0LB7mZlKSRZR3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f855b2499cso1146643a34.1
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770446; x=1718375246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NRbkZ5uCSN86k7AZcUYb5sa0Jh+0xT3jrO2n1YDlEs=;
        b=J1ti7nw+n9+c5lpC/dZmpg8P9EtIimxvq0DhvqgKrdmXOmNtig6Jnf+aZBJODkYSqt
         2N0QgOyodnlPAo7LtIdSPwjVnfR9lkKN7BIms5xcwHVMleGNzP4XclOeI4SKtEob8AHl
         C2EyFDGNpoxKheQ9o2cK8yx04DBfExHASXDWJT2qUELdXzwe574/UhDtNRnfuYWoiRvJ
         YC5gnTCLwwTmc0vs1TWjO3bwF+Ua3zoPYy+r8nIra7zKaiE2uCrrnrmNBpI9ogSVgYf4
         QlDat4/7/X+0ug1oGFAha2FhhXU7mdayJt03q/aNQ98iREIzthbWJb41vmohhMWLu2Vo
         iD2Q==
X-Gm-Message-State: AOJu0Yy7NfLdxqdaoKxhI8g/+cXTNhVet35YaGEsKUE1HOh4tKC64qE3
	8nZLEYlvg5HF5/+a10p3WShH4E3h60+NhSw6blZ+dDyCf9eZy3fQesURESYXJQlhkpc7zei0CJZ
	CmaU=
X-Google-Smtp-Source: AGHT+IEIUtB3gjpIQG+pT40Kg/vrEnKhMnwzF9mVaviMfgDZg9cIY+pqXmWLMDo7N7279B7S3faJ8w==
X-Received: by 2002:a05:6830:84:b0:6f9:3c49:b115 with SMTP id 46e09a7af769-6f957222331mr2382797a34.9.1717770445715;
        Fri, 07 Jun 2024 07:27:25 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7954850e6aesm46049685a.55.2024.06.07.07.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:25 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 24/29] nfs_common: add NFS v4 LOCALIO protocol extension enablement
Date: Fri,  7 Jun 2024 10:26:41 -0400
Message-ID: <20240607142646.20924-25-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CONFIG_NFS_V4_LOCALIO and CONFIG_NFSD_V4_LOCALIO to Kconfig.
Extend nfs_common's nfsd_uuids list infrastructure to NFS v4.

Also, nfs and nfsd will only build their respective localio.c if
either NFS_V{3,4}_LOCALIO and/or either NFSD_V{3,4}_LOCALIO are
enabled.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/Kconfig   | 14 +++++++++++++-
 fs/nfs/Makefile  |  1 +
 fs/nfsd/Kconfig  | 14 +++++++++++++-
 fs/nfsd/Makefile |  1 +
 fs/nfsd/netns.h  |  2 +-
 fs/nfsd/nfssvc.c |  6 +++---
 6 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index db8c9d6edcea..453ec4903086 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -5,7 +5,7 @@ config NFS_FS
 	select LOCKD
 	select SUNRPC
 	select NFS_ACL_SUPPORT if NFS_V3_ACL
-	select NFS_LOCALIO_SUPPORT if NFS_V3_LOCALIO
+	select NFS_LOCALIO_SUPPORT if NFS_V3_LOCALIO || NFS_V4_LOCALIO
 	help
 	  Choose Y here if you want to access files residing on other
 	  computers using Sun's Network File System protocol.  To compile
@@ -99,6 +99,18 @@ config NFS_V4
 
 	  If unsure, say Y.
 
+config NFS_V4_LOCALIO
+	bool "NFS client support for the NFSv4 LOCALIO protocol extension"
+	depends on NFS_V4
+	help
+	  Some NFS servers support an auxiliary NFSv4 LOCALIO protocol
+	  that is not an official part of the NFS version 4 protocol.
+
+	  This option enables support for version 4 of the LOCALIO
+	  protocol in the kernel's NFS client.
+
+	  If unsure, say N.
+
 config NFS_SWAP
 	bool "Provide swap over NFS support"
 	default n
diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 7fed1ce375da..ad9923fb0f03 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -14,6 +14,7 @@ nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o
 nfs-$(CONFIG_SYSCTL)	+= sysctl.o
 nfs-$(CONFIG_NFS_FSCACHE) += fscache.o
 nfs-$(CONFIG_NFS_V3_LOCALIO) += localio.o
+nfs-$(CONFIG_NFS_V4_LOCALIO) += localio.o
 
 obj-$(CONFIG_NFS_V2) += nfsv2.o
 nfsv2-y := nfs2super.o proc.o nfs2xdr.o
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index c8eb7e2d4006..34d540324dfa 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -9,7 +9,7 @@ config NFSD
 	select EXPORTFS
 	select NFS_ACL_SUPPORT if NFSD_V2_ACL
 	select NFS_ACL_SUPPORT if NFSD_V3_ACL
-	select NFS_LOCALIO_SUPPORT if NFSD_V3_LOCALIO
+	select NFS_LOCALIO_SUPPORT if NFSD_V3_LOCALIO || NFSD_V4_LOCALIO
 	depends on MULTIUSER
 	help
 	  Choose Y here if you want to allow other computers to access
@@ -102,6 +102,18 @@ config NFSD_V4
 
 	  If unsure, say N.
 
+config NFSD_V4_LOCALIO
+	bool "NFS server support for the NFSv4 LOCALIO protocol extension"
+	depends on NFSD_V4
+	help
+	  Some NFS servers support an auxiliary NFSv4 LOCALIO protocol
+	  that is not an official part of the NFS version 4 protocol.
+
+	  This option enables support for version 4 of the LOCALIO
+	  protocol in the kernel's NFS server.
+
+	  If unsure, say N.
+
 config NFSD_PNFS
 	bool
 
diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index 0e01749f6153..51d52fb0cd04 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -24,3 +24,4 @@ nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
 nfsd-$(CONFIG_NFSD_V3_LOCALIO) += localio.o
+nfsd-$(CONFIG_NFSD_V4_LOCALIO) += localio.o
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 5c5f7030ad87..afeabe5c7613 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -214,7 +214,7 @@ struct nfsd_net {
 	/* last time an admin-revoke happened for NFSv4.0 */
 	time64_t		nfs40_last_revoke;
 
-#if defined(CONFIG_NFSD_V3_LOCALIO)
+#if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
 	nfsd_uuid_t		nfsd_uuid;
 #endif
 };
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c18ee0f56da4..fab699699869 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -466,7 +466,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	nfsd4_ssc_init_umount_work(nn);
 #endif
-#if defined(CONFIG_NFSD_V3_LOCALIO)
+#if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
 	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
 	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
 #endif
@@ -499,7 +499,7 @@ static void nfsd_shutdown_net(struct net *net)
 		nn->lockd_up = false;
 	}
 	nn->nfsd_net_up = false;
-#if defined(CONFIG_NFSD_V3_LOCALIO)
+#if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
 	list_del_rcu(&nn->nfsd_uuid.list);
 #endif
 	nfsd_shutdown_generic();
@@ -832,7 +832,7 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scop
 
 	strscpy(nn->nfsd_name, scope ? scope : utsname()->nodename,
 		sizeof(nn->nfsd_name));
-#if defined(CONFIG_NFSD_V3_LOCALIO)
+#if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
 	uuid_gen(&nn->nfsd_uuid.uuid);
 #endif
 
-- 
2.44.0


