Return-Path: <linux-nfs+bounces-3740-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B86E790634B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 07:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E461C22983
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 05:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BBA135A4B;
	Thu, 13 Jun 2024 05:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7R8zD3z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8569413210A
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 05:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255235; cv=none; b=dIdk9dZQGrT1E7JjlCoGEm9Xg23N9v8AG+HtJRtabXQKKmavpCohbjQ4C2nhncRneu8Fyw1nqg+9oF4PYjzfX2j513xOpb/DDL8uedh8NUcgcM8Snj+Ry1yFxfcytnVPH2teTUd9pw9v4sBiEi2V9mEcbV9LhTediv7TIbIPjiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255235; c=relaxed/simple;
	bh=+kbrTHhQLVgOVah+qw0vntNsDDb4fLOQUEfdN8pZThM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvWg37E1SWXzraM3c3C3zb8VfCeaP+LL4Uist3iD8xNzwu5RD6qPZUQWfBOaUyFm/WtxkxZ5Gb/RfX3OAUIaLBdFUDwP+voR7sFx64rx5Oui8v6RN8hd5cZCfOtjV3hZ3uKmAwqPMtpQV/qNf/ffilx6GHTmcb76mXe/XQKxVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7R8zD3z; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-797f1287aa3so37083685a.2
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 22:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718255232; x=1718860032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jxvFBjQjt1vBoNL/YgO6suiNciopobLtS98D6qMJ64=;
        b=F7R8zD3z33jX1HbZh9zwF00gg85tAP3ZVMG+UPRqS6yofScKCbY15SIkTu9zA4X5wT
         IOaT6g+oySBc1yF1gX6l7kTqJiND2GkVXCo03XNA8FYUSf6LCY1HdzItrIrnvNH7KxvO
         tPGmzFOikC33xynoSWEEJlzsiEWtyEwbtqAlbG9SIVeelRe7X5QPK6kbYCcDBgmTiOW7
         CdwUu2HSkLtwzsf7l6AVNuN6G6g3rmxziNpuhLpW1oN4fbmJfbbi+xScJYqLYK+f6aNl
         H0DktdykbmZsBUvamkg6hC4ndFiExkbfpM3rU8l/4V0NuaYm1Q+8w8UiJiv1Kd16UNeD
         +r1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718255232; x=1718860032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jxvFBjQjt1vBoNL/YgO6suiNciopobLtS98D6qMJ64=;
        b=ETY2pdS2wZI9zOy5QNpMB47WlNRJDdC1vDC6qolsG05CIfboXTnibaI2mRXvyVxtnM
         fKQOTXGemlI0G7gNY1oSeFyw3F+cuqS7tFPhGU7WpzmT9jdVxyyPtvIb2dowkgh4VPIz
         wABm+Ye213AjTcUcnILO2m90TRiUWIA6u/4qHwH1TLK0pDc0ZPHrCGUR3RTwbC5VUaPV
         mQ6zH/u/A8hTlkRsIciXaN7cub+S43NkzdFmtrxGxx3wNjdEI/3TP/SD0eVjmPX3FJ/E
         9pPiCjMk81Pkv8jkbMoaw/0wdqQy6A9CR7LaBIaOuNI3OUXw7I1p/pztBVpBzp6TDSY2
         HgOQ==
X-Gm-Message-State: AOJu0YwK/ihfhPWm/Y9iJxmM8L8ScwRs6jSdaAosu98cABuWk/SLcaaE
	lyTWYT963LZV+5YjGJm18GrO/XWvq7WB9vxSpc+2JGlo547AtWRRWblK
X-Google-Smtp-Source: AGHT+IHuCWjb25GltIYUC4BCRFWS9cuZ85ZUMIMYcjfJjiHcqXo4KHgSQHpY/xamwk5mMtx51+jAqg==
X-Received: by 2002:a05:6214:5d8d:b0:6b0:88e1:3093 with SMTP id 6a1803df08f44-6b1910c274emr41527096d6.1.1718255232013;
        Wed, 12 Jun 2024 22:07:12 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ed4527sm3079036d6.101.2024.06.12.22.07.11
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 22:07:11 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 11/11] NFSv4/pNFS: Do layout state recovery upon reboot
Date: Thu, 13 Jun 2024 01:00:55 -0400
Message-ID: <20240613050055.854323-12-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613050055.854323-11-trond.myklebust@hammerspace.com>
References: <20240613050055.854323-1-trond.myklebust@hammerspace.com>
 <20240613050055.854323-2-trond.myklebust@hammerspace.com>
 <20240613050055.854323-3-trond.myklebust@hammerspace.com>
 <20240613050055.854323-4-trond.myklebust@hammerspace.com>
 <20240613050055.854323-5-trond.myklebust@hammerspace.com>
 <20240613050055.854323-6-trond.myklebust@hammerspace.com>
 <20240613050055.854323-7-trond.myklebust@hammerspace.com>
 <20240613050055.854323-8-trond.myklebust@hammerspace.com>
 <20240613050055.854323-9-trond.myklebust@hammerspace.com>
 <20240613050055.854323-10-trond.myklebust@hammerspace.com>
 <20240613050055.854323-11-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Some pNFS implementations, such as flexible files, want the client to
send the layout stats and layout errors that may have incurred while the
metadata server was booting. To do so, the client sends a layoutreturn
with an all-zero stateid while the server is in grace during reboot
recovery.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c |   2 +-
 fs/nfs/nfs4state.c                     |   4 +-
 fs/nfs/pnfs.c                          | 106 +++++++++++++++++++++++--
 fs/nfs/pnfs.h                          |   6 ++
 include/linux/nfs_fs_sb.h              |   1 +
 5 files changed, 110 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 24188af56d5b..39ba9f4208aa 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2548,7 +2548,7 @@ ff_layout_set_layoutdriver(struct nfs_server *server,
 		const struct nfs_fh *dummy)
 {
 #if IS_ENABLED(CONFIG_NFS_V4_2)
-	server->caps |= NFS_CAP_LAYOUTSTATS;
+	server->caps |= NFS_CAP_LAYOUTSTATS | NFS_CAP_REBOOT_LAYOUTRETURN;
 #endif
 	return 0;
 }
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 5b452411e8fd..877f682b45f2 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1863,6 +1863,7 @@ static void nfs4_state_end_reclaim_reboot(struct nfs_client *clp)
 
 	if (!nfs4_state_clear_reclaim_reboot(clp))
 		return;
+	pnfs_destroy_all_layouts(clp);
 	ops = clp->cl_mvops->reboot_recovery_ops;
 	cred = nfs4_get_clid_cred(clp);
 	err = nfs4_reclaim_complete(clp, ops, cred);
@@ -2068,7 +2069,6 @@ static int nfs4_establish_lease(struct nfs_client *clp)
 	put_cred(cred);
 	if (status != 0)
 		return status;
-	pnfs_destroy_all_layouts(clp);
 	return 0;
 }
 
@@ -2680,6 +2680,8 @@ static void nfs4_state_manager(struct nfs_client *clp)
 			section = "reclaim reboot";
 			status = nfs4_do_reclaim(clp,
 				clp->cl_mvops->reboot_recovery_ops);
+			if (status == 0)
+				status = pnfs_layout_handle_reboot(clp);
 			if (status == -EAGAIN)
 				continue;
 			if (status < 0)
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 31df5fae7acb..aa698481bec8 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -61,6 +61,7 @@ static void pnfs_free_returned_lsegs(struct pnfs_layout_hdr *lo,
 		u32 seq);
 static bool pnfs_lseg_dec_and_remove_zero(struct pnfs_layout_segment *lseg,
 		                struct list_head *tmp_list);
+static int pnfs_layout_return_on_reboot(struct pnfs_layout_hdr *lo);
 
 /* Return the registered pnfs layout driver module matching given id */
 static struct pnfs_layoutdriver_type *
@@ -937,25 +938,37 @@ int pnfs_layout_destroy_byfsid(struct nfs_client *clp, struct nfs_fsid *fsid,
 	return pnfs_layout_free_bulk_destroy_list(&layout_list, mode);
 }
 
-int pnfs_layout_destroy_byclid(struct nfs_client *clp,
-			       enum pnfs_layout_destroy_mode mode)
+static void pnfs_layout_build_destroy_list_byclient(struct nfs_client *clp,
+						    struct list_head *list)
 {
 	struct nfs_server *server;
-	LIST_HEAD(layout_list);
 
 	spin_lock(&clp->cl_lock);
 	rcu_read_lock();
 restart:
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
-		if (pnfs_layout_bulk_destroy_byserver_locked(clp,
-					server,
-					&layout_list) != 0)
+		if (pnfs_layout_bulk_destroy_byserver_locked(clp, server,
+							     list) != 0)
 			goto restart;
 	}
 	rcu_read_unlock();
 	spin_unlock(&clp->cl_lock);
+}
 
-	return pnfs_layout_free_bulk_destroy_list(&layout_list, mode);
+static int pnfs_layout_do_destroy_byclid(struct nfs_client *clp,
+					 struct list_head *list,
+					 enum pnfs_layout_destroy_mode mode)
+{
+	pnfs_layout_build_destroy_list_byclient(clp, list);
+	return pnfs_layout_free_bulk_destroy_list(list, mode);
+}
+
+int pnfs_layout_destroy_byclid(struct nfs_client *clp,
+			       enum pnfs_layout_destroy_mode mode)
+{
+	LIST_HEAD(layout_list);
+
+	return pnfs_layout_do_destroy_byclid(clp, &layout_list, mode);
 }
 
 /*
@@ -971,6 +984,67 @@ pnfs_destroy_all_layouts(struct nfs_client *clp)
 	pnfs_layout_destroy_byclid(clp, PNFS_LAYOUT_INVALIDATE);
 }
 
+static void pnfs_layout_build_recover_list_byclient(struct nfs_client *clp,
+						    struct list_head *list)
+{
+	struct nfs_server *server;
+
+	spin_lock(&clp->cl_lock);
+	rcu_read_lock();
+restart:
+	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
+		if (!(server->caps & NFS_CAP_REBOOT_LAYOUTRETURN))
+			continue;
+		if (pnfs_layout_bulk_destroy_byserver_locked(clp, server,
+							     list) != 0)
+			goto restart;
+	}
+	rcu_read_unlock();
+	spin_unlock(&clp->cl_lock);
+}
+
+static int pnfs_layout_bulk_list_reboot(struct list_head *list)
+{
+	struct pnfs_layout_hdr *lo;
+	struct nfs_server *server;
+	int ret;
+
+	list_for_each_entry(lo, list, plh_bulk_destroy) {
+		server = NFS_SERVER(lo->plh_inode);
+		ret = pnfs_layout_return_on_reboot(lo);
+		switch (ret) {
+		case 0:
+			continue;
+		case -NFS4ERR_BAD_STATEID:
+			server->caps &= ~NFS_CAP_REBOOT_LAYOUTRETURN;
+			break;
+		case -NFS4ERR_NO_GRACE:
+			break;
+		default:
+			goto err;
+		}
+		break;
+	}
+	return 0;
+err:
+	return ret;
+}
+
+int pnfs_layout_handle_reboot(struct nfs_client *clp)
+{
+	LIST_HEAD(list);
+	int ret = 0, ret2;
+
+	pnfs_layout_build_recover_list_byclient(clp, &list);
+	if (!list_empty(&list))
+		ret = pnfs_layout_bulk_list_reboot(&list);
+	ret2 = pnfs_layout_do_destroy_byclid(clp, &list,
+					     PNFS_LAYOUT_INVALIDATE);
+	if (!ret)
+		ret = ret2;
+	return (ret == 0) ?  0 : -EAGAIN;
+}
+
 static void
 pnfs_set_layout_cred(struct pnfs_layout_hdr *lo, const struct cred *cred)
 {
@@ -1445,6 +1519,24 @@ pnfs_commit_and_return_layout(struct inode *inode)
 	return ret;
 }
 
+static int pnfs_layout_return_on_reboot(struct pnfs_layout_hdr *lo)
+{
+	struct inode *inode = lo->plh_inode;
+	const struct cred *cred;
+
+	spin_lock(&inode->i_lock);
+	if (!pnfs_layout_is_valid(lo)) {
+		spin_unlock(&inode->i_lock);
+		return 0;
+	}
+	cred = get_cred(lo->plh_lc_cred);
+	pnfs_get_layout_hdr(lo);
+	spin_unlock(&inode->i_lock);
+
+	return pnfs_send_layoutreturn(lo, &zero_stateid, &cred, IOMODE_ANY,
+				      PNFS_FL_LAYOUTRETURN_PRIVILEGED);
+}
+
 bool pnfs_roc(struct inode *ino,
 		struct nfs4_layoutreturn_args *args,
 		struct nfs4_layoutreturn_res *res,
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index d192feb346b4..bb5142b4e67a 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -356,6 +356,7 @@ void pnfs_error_mark_layout_for_return(struct inode *inode,
 				       struct pnfs_layout_segment *lseg);
 void pnfs_layout_return_unused_byclid(struct nfs_client *clp,
 				      enum pnfs_iomode iomode);
+int pnfs_layout_handle_reboot(struct nfs_client *clp);
 
 /* nfs4_deviceid_flags */
 enum {
@@ -737,6 +738,11 @@ static inline void pnfs_destroy_layout_final(struct nfs_inode *nfsi)
 {
 }
 
+static inline int pnfs_layout_handle_reboot(struct nfs_client *clp)
+{
+	return 0;
+}
+
 static inline struct pnfs_layout_segment *
 pnfs_get_lseg(struct pnfs_layout_segment *lseg)
 {
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index fe5b1a8bd723..ba9df1848b35 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -278,6 +278,7 @@ struct nfs_server {
 #define NFS_CAP_LGOPEN		(1U << 5)
 #define NFS_CAP_CASE_INSENSITIVE	(1U << 6)
 #define NFS_CAP_CASE_PRESERVING	(1U << 7)
+#define NFS_CAP_REBOOT_LAYOUTRETURN	(1U << 8)
 #define NFS_CAP_OPEN_XOR	(1U << 12)
 #define NFS_CAP_DELEGTIME	(1U << 13)
 #define NFS_CAP_POSIX_LOCK	(1U << 14)
-- 
2.45.2


