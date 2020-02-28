Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0DD11737F5
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 14:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgB1NJg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Feb 2020 08:09:36 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37979 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgB1NJg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Feb 2020 08:09:36 -0500
Received: by mail-yw1-f67.google.com with SMTP id 10so3209184ywv.5
        for <linux-nfs@vger.kernel.org>; Fri, 28 Feb 2020 05:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aSdAmGvQ4X6dHlEIeVlLY1A3hf1FnC9He4UCG6KmM/k=;
        b=FHqNQPgulQZFScABd3xLMd9U5E/YcEgPdp+gKrFeG14hMBMOGZZAi9qoKq0IcNH0bV
         YS9Iyu3IMzjFnO89vkhL6HqrMkfAzR/i8dsMz7J9EBSGF8Jith7d15lDkALUMXfA+tpg
         tzIrIjUM7oLb7eemh5/kxBfutNWhhTkvfVXJXYsPSnS2R5sROyDkIz+DeoatxU8EelEP
         lhzMlAENqHXFL9/NSrGO/fbQ8P79CvRs3JcHHCJFEOh15+AcirTFdDpgxarmhwz7+DZR
         GO47tUZ0OwOFMh5D+oGv77Wht19XH7Zff8qe+XIXmH7tqOJmoJpwlgYovWyq7wGca9bB
         iWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSdAmGvQ4X6dHlEIeVlLY1A3hf1FnC9He4UCG6KmM/k=;
        b=kOJqILiX/GqTIJI+PZDA+AS1kyJEVqDbEWs+nvE2aBr4cs06lT2kfZPNf+U1iucqgl
         pKiWMTYKyqEQQcTdUeQCS2BDKOzfL2STIW36JPhS/u9aa3zG9u9FkMSkT3vZ33YLzTVZ
         v4vLyQGDBd7hkiYUW4qZqwYetBVempCTQLVJO0jzWS1S3oLh4mIQ97j/4Svq1Nb1ffmA
         n6wcVW0xhFfkuGOoB07HtNh13Qeg00TxAEM3yGJ91BR+tZE0B/RC0fJfFck9iQNpHOXo
         Ajepd1mk+hnclVt4CpVh81ML4pMSX8J7p6jrabjKq0A7NHWxZyIo9cyGl/oBUbTWCfhe
         SJyg==
X-Gm-Message-State: APjAAAXA6f+hRp1vRxVZvHsVizuN6vq6D66MryaP5pNrnI5hvNdfuDgh
        9xsfDZt7Q2SrMFH9T/HaahV+g9iiPg==
X-Google-Smtp-Source: APXvYqwBfHDnRdVsQfgBp7ZsFYesIM9/xnXSnFfpdwBwmlBUKhOwnVJiZ0kVswMOjKbOtQHA6h/Mvg==
X-Received: by 2002:a25:abef:: with SMTP id v102mr3661062ybi.269.1582895375290;
        Fri, 28 Feb 2020 05:09:35 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id j23sm3925150ywb.93.2020.02.28.05.09.34
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 05:09:34 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/7] NFSv4/pnfs: Clean up nfs_layout_find_inode()
Date:   Fri, 28 Feb 2020 08:07:20 -0500
Message-Id: <20200228130725.1330705-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200228130725.1330705-1-trond.myklebust@hammerspace.com>
References: <20200228130725.1330705-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that we can rely on just the rcu_read_lock(), remove the
clp->cl_lock and clean up.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/callback_proc.c | 52 +++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index eb9d035451a2..97084804a953 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -121,33 +121,31 @@ __be32 nfs4_callback_recall(void *argp, void *resp,
  */
 static struct inode *nfs_layout_find_inode_by_stateid(struct nfs_client *clp,
 		const nfs4_stateid *stateid)
+	__must_hold(RCU)
 {
 	struct nfs_server *server;
 	struct inode *inode;
 	struct pnfs_layout_hdr *lo;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
-		list_for_each_entry(lo, &server->layouts, plh_layouts) {
+		list_for_each_entry_rcu(lo, &server->layouts, plh_layouts) {
 			if (!pnfs_layout_is_valid(lo))
 				continue;
 			if (stateid != NULL &&
 			    !nfs4_stateid_match_other(stateid, &lo->plh_stateid))
 				continue;
+			if (!nfs_sb_active(server->super))
+				continue;
 			inode = igrab(lo->plh_inode);
-			if (!inode)
-				return ERR_PTR(-EAGAIN);
-			if (!nfs_sb_active(inode->i_sb)) {
-				rcu_read_unlock();
-				spin_unlock(&clp->cl_lock);
-				iput(inode);
-				spin_lock(&clp->cl_lock);
-				rcu_read_lock();
-				return ERR_PTR(-EAGAIN);
-			}
-			return inode;
+			rcu_read_unlock();
+			if (inode)
+				return inode;
+			nfs_sb_deactive(server->super);
+			return ERR_PTR(-EAGAIN);
 		}
 	}
-
+	rcu_read_unlock();
 	return ERR_PTR(-ENOENT);
 }
 
@@ -165,28 +163,25 @@ static struct inode *nfs_layout_find_inode_by_fh(struct nfs_client *clp,
 	struct inode *inode;
 	struct pnfs_layout_hdr *lo;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
-		list_for_each_entry(lo, &server->layouts, plh_layouts) {
+		list_for_each_entry_rcu(lo, &server->layouts, plh_layouts) {
 			nfsi = NFS_I(lo->plh_inode);
 			if (nfs_compare_fh(fh, &nfsi->fh))
 				continue;
 			if (nfsi->layout != lo)
 				continue;
+			if (!nfs_sb_active(server->super))
+				continue;
 			inode = igrab(lo->plh_inode);
-			if (!inode)
-				return ERR_PTR(-EAGAIN);
-			if (!nfs_sb_active(inode->i_sb)) {
-				rcu_read_unlock();
-				spin_unlock(&clp->cl_lock);
-				iput(inode);
-				spin_lock(&clp->cl_lock);
-				rcu_read_lock();
-				return ERR_PTR(-EAGAIN);
-			}
-			return inode;
+			rcu_read_unlock();
+			if (inode)
+				return inode;
+			nfs_sb_deactive(server->super);
+			return ERR_PTR(-EAGAIN);
 		}
 	}
-
+	rcu_read_unlock();
 	return ERR_PTR(-ENOENT);
 }
 
@@ -196,14 +191,9 @@ static struct inode *nfs_layout_find_inode(struct nfs_client *clp,
 {
 	struct inode *inode;
 
-	spin_lock(&clp->cl_lock);
-	rcu_read_lock();
 	inode = nfs_layout_find_inode_by_stateid(clp, stateid);
 	if (inode == ERR_PTR(-ENOENT))
 		inode = nfs_layout_find_inode_by_fh(clp, fh);
-	rcu_read_unlock();
-	spin_unlock(&clp->cl_lock);
-
 	return inode;
 }
 
-- 
2.24.1

