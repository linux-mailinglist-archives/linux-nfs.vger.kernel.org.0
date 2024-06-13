Return-Path: <linux-nfs+bounces-3733-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F7C906343
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 07:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28764283016
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 05:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B525136647;
	Thu, 13 Jun 2024 05:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT0z9qhm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0C131E33
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 05:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255229; cv=none; b=GWr5042emFMq6OoDedznOLXQA+YHMXK71dw6taLstRuiRyj3MaEqU8PX2apcegDS0GoRUpjhmFxUfk6cbyg3166sHKM1DpOGZKJtxnf/4d8UXgPmeoVUQ48Y0QN6NNm2azwaWEdRnuVvCKWwImvYjAPG0LF10YeVbAB1XyeZJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255229; c=relaxed/simple;
	bh=SHJGL2LLldrprrV2HH/Loa0SAXdAhcU15rnhOwaZPtg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxacMb/UEC7khb++tgsK7OYQc4aqVDtMjpWyYqR0+O23BU3YGmKazgY15itEolhRWRfe0nb26oLuZuMVPqqQsouGReoZcFvYBWJNFPQ8UBUJD88vlQKdbnN4/Uf30EBIlhwDHyHch13ZeKtYysySNcUnGE3AgBkohvf/UL3L5PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT0z9qhm; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62fffd5d36bso7255747b3.2
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 22:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718255226; x=1718860026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZCB+D9naYo0Z2ERgDE24DcBCSvH0W2aKyk9RZMcA7c=;
        b=jT0z9qhmIUY6UB8WLTz+elI3YJey37G0JxPUeW1KpaJen50O6gkn00Y/5IrAww/H/t
         5vN9gqy42vjiCRMYITJygY24i0VQJOM5oLXAi/fI5b4jti6H5+4yszg9PeKtWwdOGYxh
         +LdqgmTTHkqOu1TJXMrtrNkFkdIXCpP4Lj16+5iNmuScQhTTdiXchrCalKCEmwoRSah4
         hq/KKVBRTsn5FgMkYmqZoN7rdv25FFUmvoByD4WOZPZBgvM65hSQ73y66a3S2t8Xy64a
         2qtPyqLqy5i2wG2FrP8mn+7IQFBWzZVQIQVpfpO55nX16zVq0uqLDMrd+WsTP5agv+vT
         JwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718255226; x=1718860026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZCB+D9naYo0Z2ERgDE24DcBCSvH0W2aKyk9RZMcA7c=;
        b=ZVYliMVkiNDOZfgHIDWHZ8e8MMm8wjCY5pGMOMPT7t6j/VNVk/kPP7lv3wT4LZAZXQ
         pw5gRdkq7KdmtkJPgs4T6RKcUXyOb9s69XG6xiuvbC3mb7EHABE3p+4GA+nGjAxdXW+m
         wnkDl1KejfDR4+ZgHJcKew6j4YUGse7JfSc3YzdkiJB1NGipNvLUKio95us+FO3ck1SB
         2HxBpqg3Li51aYyzngDAVjuzDoVaBBZS9rCxz3QZXidzsBjaTbuwREURaDUPbNFabQJR
         jq3amRmpG1bpwX2b8vX2KQYrgJK3i6UNs8Q21pzFlh3WW5C08exd2PE1e6O3HjbYiJ8n
         togg==
X-Gm-Message-State: AOJu0YzrY5eAMNTL32FEkjIH5UQJAXP9WfG97+6npH/OVh8c4+Tl1+XG
	oira8cZY9MgxpQeIlCYwI3GyLkuSSE5B1z65Gd2pwhQVLO7vaz0Gef2m
X-Google-Smtp-Source: AGHT+IHOE1de4p1DVWmxjSY3gJMeo8tZ5NjueaSO71qgSJOXEsCgQkBt8K7S8p/SY0CPx3SJ8pdx0w==
X-Received: by 2002:a81:b641:0:b0:627:89be:397f with SMTP id 00721157ae682-62fbb8edcb6mr37396407b3.4.1718255226243;
        Wed, 12 Jun 2024 22:07:06 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ed4527sm3079036d6.101.2024.06.12.22.07.05
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 22:07:05 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 04/11] pNFS: Add a flag argument to pnfs_destroy_layouts_byclid()
Date: Thu, 13 Jun 2024 01:00:48 -0400
Message-ID: <20240613050055.854323-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613050055.854323-4-trond.myklebust@hammerspace.com>
References: <20240613050055.854323-1-trond.myklebust@hammerspace.com>
 <20240613050055.854323-2-trond.myklebust@hammerspace.com>
 <20240613050055.854323-3-trond.myklebust@hammerspace.com>
 <20240613050055.854323-4-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Change the bool argument to a flag so that we can add different modes
for doing bulk destroy of a layout. In particular, we will want the
ability to schedule return of all the layouts associated with a given
NFS server when it reboots.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/callback_proc.c |  5 +++--
 fs/nfs/pnfs.c          | 21 +++++++++------------
 fs/nfs/pnfs.h          | 14 +++++++++-----
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 199c52788640..7832fb0369a1 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -323,9 +323,10 @@ static u32 initiate_bulk_draining(struct nfs_client *clp,
 	int stat;
 
 	if (args->cbl_recall_type == RETURN_FSID)
-		stat = pnfs_destroy_layouts_byfsid(clp, &args->cbl_fsid, true);
+		stat = pnfs_layout_destroy_byfsid(clp, &args->cbl_fsid,
+						  PNFS_LAYOUT_BULK_RETURN);
 	else
-		stat = pnfs_destroy_layouts_byclid(clp, true);
+		stat = pnfs_layout_destroy_byclid(clp, PNFS_LAYOUT_BULK_RETURN);
 	if (stat != 0)
 		return NFS4ERR_DELAY;
 	return NFS4ERR_NOMATCHING_LAYOUT;
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index bbbb692b2a47..0e188bc303ee 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -868,7 +868,7 @@ pnfs_layout_bulk_destroy_byserver_locked(struct nfs_client *clp,
 
 static int
 pnfs_layout_free_bulk_destroy_list(struct list_head *layout_list,
-		bool is_bulk_recall)
+				   enum pnfs_layout_destroy_mode mode)
 {
 	struct pnfs_layout_hdr *lo;
 	struct inode *inode;
@@ -887,7 +887,7 @@ pnfs_layout_free_bulk_destroy_list(struct list_head *layout_list,
 		spin_lock(&inode->i_lock);
 		list_del_init(&lo->plh_bulk_destroy);
 		if (pnfs_mark_layout_stateid_invalid(lo, &lseg_list)) {
-			if (is_bulk_recall)
+			if (mode == PNFS_LAYOUT_BULK_RETURN)
 				set_bit(NFS_LAYOUT_BULK_RECALL, &lo->plh_flags);
 			ret = -EAGAIN;
 		}
@@ -901,10 +901,8 @@ pnfs_layout_free_bulk_destroy_list(struct list_head *layout_list,
 	return ret;
 }
 
-int
-pnfs_destroy_layouts_byfsid(struct nfs_client *clp,
-		struct nfs_fsid *fsid,
-		bool is_recall)
+int pnfs_layout_destroy_byfsid(struct nfs_client *clp, struct nfs_fsid *fsid,
+			       enum pnfs_layout_destroy_mode mode)
 {
 	struct nfs_server *server;
 	LIST_HEAD(layout_list);
@@ -923,12 +921,11 @@ pnfs_destroy_layouts_byfsid(struct nfs_client *clp,
 	rcu_read_unlock();
 	spin_unlock(&clp->cl_lock);
 
-	return pnfs_layout_free_bulk_destroy_list(&layout_list, is_recall);
+	return pnfs_layout_free_bulk_destroy_list(&layout_list, mode);
 }
 
-int
-pnfs_destroy_layouts_byclid(struct nfs_client *clp,
-		bool is_recall)
+int pnfs_layout_destroy_byclid(struct nfs_client *clp,
+			       enum pnfs_layout_destroy_mode mode)
 {
 	struct nfs_server *server;
 	LIST_HEAD(layout_list);
@@ -945,7 +942,7 @@ pnfs_destroy_layouts_byclid(struct nfs_client *clp,
 	rcu_read_unlock();
 	spin_unlock(&clp->cl_lock);
 
-	return pnfs_layout_free_bulk_destroy_list(&layout_list, is_recall);
+	return pnfs_layout_free_bulk_destroy_list(&layout_list, mode);
 }
 
 /*
@@ -958,7 +955,7 @@ pnfs_destroy_all_layouts(struct nfs_client *clp)
 	nfs4_deviceid_mark_client_invalid(clp);
 	nfs4_deviceid_purge_client(clp);
 
-	pnfs_destroy_layouts_byclid(clp, false);
+	pnfs_layout_destroy_byclid(clp, PNFS_LAYOUT_INVALIDATE);
 }
 
 static void
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index fa5beeaaf5da..a6f9427782c2 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -118,6 +118,11 @@ enum layoutdriver_policy_flags {
 	PNFS_LAYOUTGET_ON_OPEN		= 1 << 3,
 };
 
+enum pnfs_layout_destroy_mode {
+	PNFS_LAYOUT_INVALIDATE = 0,
+	PNFS_LAYOUT_BULK_RETURN,
+};
+
 struct nfs4_deviceid_node;
 
 /* Per-layout driver specific registration structure */
@@ -273,11 +278,10 @@ void pnfs_free_lseg_list(struct list_head *tmp_list);
 void pnfs_destroy_layout(struct nfs_inode *);
 void pnfs_destroy_layout_final(struct nfs_inode *);
 void pnfs_destroy_all_layouts(struct nfs_client *);
-int pnfs_destroy_layouts_byfsid(struct nfs_client *clp,
-		struct nfs_fsid *fsid,
-		bool is_recall);
-int pnfs_destroy_layouts_byclid(struct nfs_client *clp,
-		bool is_recall);
+int pnfs_layout_destroy_byfsid(struct nfs_client *clp, struct nfs_fsid *fsid,
+			       enum pnfs_layout_destroy_mode mode);
+int pnfs_layout_destroy_byclid(struct nfs_client *clp,
+			       enum pnfs_layout_destroy_mode mode);
 bool nfs4_layout_refresh_old_stateid(nfs4_stateid *dst,
 		struct pnfs_layout_range *dst_range,
 		struct inode *inode);
-- 
2.45.2


