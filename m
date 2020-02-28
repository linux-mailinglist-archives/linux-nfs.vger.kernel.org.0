Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 281E41737F4
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 14:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgB1NJg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Feb 2020 08:09:36 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35858 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgB1NJf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Feb 2020 08:09:35 -0500
Received: by mail-yw1-f68.google.com with SMTP id y72so3220857ywg.3
        for <linux-nfs@vger.kernel.org>; Fri, 28 Feb 2020 05:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yjpn2eZ+qdVL730VhJKSpkgisG4rut0xZaWVnztngvs=;
        b=HEbENzLY8ume3OGgOBi00c20+FCIBhbRSYu+VuMaKNP18E9Vcxbyy4H9PfHHE7thdT
         Cr7vwJMULquNdaN11vi62EH8KkN0ULD9G9+I5PE7jiDtLGPDD5myVUw/dK1tFJj4qUwP
         oa9RQLSu9UP06OPhNo1hXOlJUxdwrOYx5OuFGykMIQXunWCCI5+aBUiZgRfn1fqtkULj
         UZ468p1AXmm1N9Uc8eMtBKf1hJGDVD5PCbEhAKcmznniZO0dzRu3UNMwOC/5TBdyBYtD
         g5tOFRvdngGQBZhOaIBf1NKRI90J0RPQOA1YhfoafZsFq84w9w72rdzFXQQh+f/Z1Bn0
         lKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yjpn2eZ+qdVL730VhJKSpkgisG4rut0xZaWVnztngvs=;
        b=M6d/3myl4rJd4IuTSZ/Tfc0mZRF2Ldiv+dNUXnnMYrWKSLPExaAimvxbfafTWQ4T1B
         JHe49jdbkh9RBQSiWSuqWbgLpjqcnXqw/a6i5014DfjTlX3hO5Gk6Gz4yQeCOKqd4fRq
         hszWe+O28PHm240IXupMJ53F1IaEv/0Pz/l+y3oDvwMedskowkN2+LQufXr8s7EVEo4w
         14cvs3J6EdJY55nbqdgh4PSvCh8atXLKGYpDrwb+WJlcxR5J5L2FgMXpOyJiwZQMjfDr
         omBvM+KW/S+/NNrinBqNnkciQfAY1OBmshXqlryryy5bKbibC3powY1FZUqc2ZDTOTTf
         IiDw==
X-Gm-Message-State: APjAAAV7DIa2j9HeYop4R6IxBhFLauZLfYygEC/T8YB4lMrQ+2+gmSOb
        w0zxZfqPPXDtzItgu1MvUBaepkAMPQ==
X-Google-Smtp-Source: APXvYqyrnz9f7Vj7XIi9rSXGm6+kbHcyP/mgot62QgYoAmbWrZtbBKwwvwtDE0IsGsLCUrgQb8jYuQ==
X-Received: by 2002:a25:cf95:: with SMTP id f143mr3480602ybg.350.1582895374063;
        Fri, 28 Feb 2020 05:09:34 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id j23sm3925150ywb.93.2020.02.28.05.09.33
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 05:09:33 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/7] NFSv4: Ensure layout headers are RCU safe
Date:   Fri, 28 Feb 2020 08:07:19 -0500
Message-Id: <20200228130725.1330705-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/blocklayout/blocklayout.c       |  2 +-
 fs/nfs/filelayout/filelayout.c         |  2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c |  6 +++---
 fs/nfs/pnfs.c                          | 12 ++++++------
 fs/nfs/pnfs.h                          |  2 ++
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 690221747b47..d1a0e2c8b1b4 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -476,7 +476,7 @@ static void bl_free_layout_hdr(struct pnfs_layout_hdr *lo)
 	err = ext_tree_remove(bl, true, 0, LLONG_MAX);
 	WARN_ON(err);
 
-	kfree(bl);
+	kfree_rcu(bl, bl_layout.plh_rcu);
 }
 
 static struct pnfs_layout_hdr *__bl_alloc_layout_hdr(struct inode *inode,
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index c9b605f6c9cb..bd234394a87c 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -1146,7 +1146,7 @@ filelayout_alloc_layout_hdr(struct inode *inode, gfp_t gfp_flags)
 static void
 filelayout_free_layout_hdr(struct pnfs_layout_hdr *lo)
 {
-	kfree(FILELAYOUT_FROM_HDR(lo));
+	kfree_rcu(FILELAYOUT_FROM_HDR(lo), generic_hdr.plh_rcu);
 }
 
 static struct pnfs_ds_commit_info *
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 8b8171b48893..e7d8ae4d0cc5 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -59,14 +59,14 @@ ff_layout_alloc_layout_hdr(struct inode *inode, gfp_t gfp_flags)
 static void
 ff_layout_free_layout_hdr(struct pnfs_layout_hdr *lo)
 {
+	struct nfs4_flexfile_layout *ffl = FF_LAYOUT_FROM_HDR(lo);
 	struct nfs4_ff_layout_ds_err *err, *n;
 
-	list_for_each_entry_safe(err, n, &FF_LAYOUT_FROM_HDR(lo)->error_list,
-				 list) {
+	list_for_each_entry_safe(err, n, &ffl->error_list, list) {
 		list_del(&err->list);
 		kfree(err);
 	}
-	kfree(FF_LAYOUT_FROM_HDR(lo));
+	kfree_rcu(ffl, generic_hdr.plh_rcu);
 }
 
 static int decode_pnfs_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index cb99ac954688..268e7b9ff54e 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -268,11 +268,11 @@ pnfs_free_layout_hdr(struct pnfs_layout_hdr *lo)
 	struct nfs_server *server = NFS_SERVER(lo->plh_inode);
 	struct pnfs_layoutdriver_type *ld = server->pnfs_curr_ld;
 
-	if (!list_empty(&lo->plh_layouts)) {
+	if (test_and_clear_bit(NFS_LAYOUT_HASHED, &lo->plh_flags)) {
 		struct nfs_client *clp = server->nfs_client;
 
 		spin_lock(&clp->cl_lock);
-		list_del_init(&lo->plh_layouts);
+		list_del_rcu(&lo->plh_layouts);
 		spin_unlock(&clp->cl_lock);
 	}
 	put_cred(lo->plh_lc_cred);
@@ -784,7 +784,8 @@ pnfs_layout_bulk_destroy_byserver_locked(struct nfs_client *clp,
 			break;
 		inode = igrab(lo->plh_inode);
 		if (inode != NULL) {
-			list_del_init(&lo->plh_layouts);
+			if (test_and_clear_bit(NFS_LAYOUT_HASHED, &lo->plh_flags))
+				list_del_rcu(&lo->plh_layouts);
 			if (pnfs_layout_add_bulk_destroy_list(inode,
 						layout_list))
 				continue;
@@ -1870,15 +1871,14 @@ static void pnfs_clear_first_layoutget(struct pnfs_layout_hdr *lo)
 static void _add_to_server_list(struct pnfs_layout_hdr *lo,
 				struct nfs_server *server)
 {
-	if (list_empty(&lo->plh_layouts)) {
+	if (!test_and_set_bit(NFS_LAYOUT_HASHED, &lo->plh_flags)) {
 		struct nfs_client *clp = server->nfs_client;
 
 		/* The lo must be on the clp list if there is any
 		 * chance of a CB_LAYOUTRECALL(FILE) coming in.
 		 */
 		spin_lock(&clp->cl_lock);
-		if (list_empty(&lo->plh_layouts))
-			list_add_tail(&lo->plh_layouts, &server->layouts);
+		list_add_tail_rcu(&lo->plh_layouts, &server->layouts);
 		spin_unlock(&clp->cl_lock);
 	}
 }
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index cfb89d47c79d..8df9aa02d336 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -105,6 +105,7 @@ enum {
 	NFS_LAYOUT_INVALID_STID,	/* layout stateid id is invalid */
 	NFS_LAYOUT_FIRST_LAYOUTGET,	/* Serialize first layoutget */
 	NFS_LAYOUT_INODE_FREEING,	/* The inode is being freed */
+	NFS_LAYOUT_HASHED,		/* The layout visible */
 };
 
 enum layoutdriver_policy_flags {
@@ -203,6 +204,7 @@ struct pnfs_layout_hdr {
 	loff_t			plh_lwb; /* last write byte for layoutcommit */
 	const struct cred	*plh_lc_cred; /* layoutcommit cred */
 	struct inode		*plh_inode;
+	struct rcu_head		plh_rcu;
 };
 
 struct pnfs_device {
-- 
2.24.1

