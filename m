Return-Path: <linux-nfs+bounces-13984-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293DBB40D27
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 20:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D3C3BD69E
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 18:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C2732F76E;
	Tue,  2 Sep 2025 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miqs095t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428DB32F75B
	for <linux-nfs@vger.kernel.org>; Tue,  2 Sep 2025 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837841; cv=none; b=pEV9fPhfPELulJtE+KtyOumIJXULd4G4nNm7ghtjnv5s5y/ynr+79/DVW8CaoKhqh3yWLXK2X/z+8aKpGJdayOqvN7cOdsp06cDNysTEdK9zW3VB8VAWPVnVlckDK7jmFF3Gqx/dV7mVb3v1Sk0fEOYYYXvCdjBuZ+H85ZW5zdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837841; c=relaxed/simple;
	bh=QKzhaX2PN9i4IlcQJ0PtsfP9p8HyQULC54vCCnC3yrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QKnW2+Zb8r2Th15TqE7OfXv/iAnjFsDruiea30zm6FS9ogmFUfnwumsdD6TndZp/cjUIdoHlj4aQTIiwdejZOp8Ehg/jFOYKkpKnX8/nlcqySi+63i/Gt/IJM0dGqCg7PIcVoqb96ADNZOGucsq5r9Xwbu87MtpDP+xSdd7Ie18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miqs095t; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-248ff68356aso1246695ad.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 Sep 2025 11:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756837839; x=1757442639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHIYK7hLN7bIozX5S0xYH2PivhZYET3nyB/jzBAOP1g=;
        b=miqs095tHbHI/9DkWoNZKGDZIpZCjo1h9SE9disB2RlLMYXR6dt30pW68pPOyAiam1
         +Fkm2Ss207lgHPu5B9Rg6nlY3F+rTyBlmdX1fLOo459feph8s94sNBJgI5Imna3k0CnI
         IRMdG7CFIUdQ7ZD1uOR1S1vMT1pLcU6f/bN0HoC9XVMWyiz0fplFqAJ9gXSydc/YyP6w
         IaE5N+X05ZPcqZcojEu2YH6eAmVlGxjMxEwtIttHw7I7QfwKmL3QXFXWnrXhET1U4ZVl
         E7+9lTWK0CuoMgvi142s5e8UuFOrJWxlDiSuAXgtSq1HKW7I0BYuXvXEF59NaS3CliaW
         pejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837839; x=1757442639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHIYK7hLN7bIozX5S0xYH2PivhZYET3nyB/jzBAOP1g=;
        b=Da5xqOTXHJybtC2egYlX17r4o6G+skOBwcCyuhFWcUnFJDGpxXZQwr/9L6Yaa0KoSE
         o+3gCT9ocV2Fh4TUT10o25+42cyjueqUsBXH4//IOSJBLkt8M6aWir6ftr9j7B//pIec
         lP78UMgcOQwis0PtAlUz5eCveHDEQE6Xn03dXfCxQn85+JnGMZI/KRplaKpHxY8vLWPI
         yev8Jbow9vxgSFpl1hJkFPfw5nXn6PoqB3zGrS0haRnyhE/Huq1J1s6wO1To2EvM6IIi
         jvHOtEqxc+dyXe+6Zg8aO57vi7MtLF1YREj+GQVm54LiUnpVTcQl+1Xd4v9fZRJ4X+EO
         iIwA==
X-Gm-Message-State: AOJu0YzscC+nGLQZ3lL6IBsTnTD1JgU3bB6Si+Ulbo3oTHR4oQoo2F25
	lkL6iJzP2t3N0VCZNZtiBj48+u5Caw5k6GVLUKe3c4fkrjwfvyQwHMZhzt3jWkvJ
X-Gm-Gg: ASbGnctUlaL9zo1tmFvIB8MFw81dhvr3f/f6ABKr6OQ+xEQg0ZErZljReul9vCNulIS
	dNqlZXG/5Hbc5WbECLXa1eHPZ+LSnWMvmQcy4DMF5YlJ+2mWuiSL8Ou27+mlbk5WBxT9KCUQwp9
	DGi2GFbsna1c9DhNvAgzqrqlIMKXsy+7kUrXLZw8cT0j0SJLMMfj5+f0bp/wIA0DsGtXC5sMo1o
	1I+/Gw5el2s4TqVvlgC//NFnZzUIaomj1bOrymgiO9g5gsKYZ2AwNJZaODGFITPfM2DikPeTULB
	3IaqfWf8oMxqthI+5qB1ddHjkVKmv1fjPS1kDJKFm99FonoNMEaZKLCmjzu4GhQW3NbGd8GxgsT
	sujIOlHvhGr09L8VTn6g9IK1dwxyz7OyiBxNuf8coh4cXsMC6sdkQSM7h
X-Google-Smtp-Source: AGHT+IG8Xj910YFVJBo2f+kW+lEdrF3EpXiwKGI/lhf+ACDvzY6Drytk0/i7abmalbrWGzqJnOkjRA==
X-Received: by 2002:a17:902:da88:b0:249:f4f:f021 with SMTP id d9443c01a7336-2493ef9ee79mr158949795ad.24.1756837839044;
        Tue, 02 Sep 2025 11:30:39 -0700 (PDT)
Received: from haihua-yang.r8.ubvm.nutanix.com ([192.146.154.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da4d5bsm140002295ad.94.2025.09.02.11.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:30:38 -0700 (PDT)
From: Haihua Yang <yanghh@gmail.com>
To: linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>
Cc: Haihua Yang <yanghh@gmail.com>
Subject: [PATCH] draft patches to fixes LAYOUTCOMMIT related issues
Date: Tue,  2 Sep 2025 18:30:16 +0000
Message-ID: <20250902183035.2059893-1-yanghh@gmail.com>
X-Mailer: git-send-email 2.51.0.87.g1fa68948c3.dirty
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1, fix an issue that client may send LAYOUTRETURN before LAYOUTCOMMIT
2, update layout stateid when layoutcommit receiving NFS4ERR_OLD_STATEID
---
 fs/nfs/callback_proc.c |  2 +-
 fs/nfs/nfs4proc.c      | 10 +++++++++-
 fs/nfs/pnfs.c          | 28 +++++++++++++++++-----------
 fs/nfs/pnfs.h          |  2 +-
 4 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 8397c43358bd..1e6e4a7a3f15 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -287,7 +287,7 @@ static u32 initiate_file_draining(struct nfs_client *clp,
 	pnfs_set_layout_stateid(lo, &args->cbl_stateid, NULL, true);
 	switch (pnfs_mark_matching_lsegs_return(lo, &free_me_list,
 				&args->cbl_range,
-				be32_to_cpu(args->cbl_stateid.seqid))) {
+				be32_to_cpu(args->cbl_stateid.seqid), true)) {
 	case 0:
 	case -EBUSY:
 		/* There are layout segments that need to be returned */
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7d2b67e06cc3..46a1bc1f31ee 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10255,6 +10255,7 @@ nfs4_layoutcommit_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs4_layoutcommit_data *data = calldata;
 	struct nfs_server *server = NFS_SERVER(data->args.inode);
+	struct pnfs_layout_range dst_range;
 
 	if (!nfs41_sequence_done(task, &data->res.seq_res))
 		return;
@@ -10268,6 +10269,13 @@ nfs4_layoutcommit_done(struct rpc_task *task, void *calldata)
 		break;
 	case 0:
 		break;
+	case -NFS4ERR_OLD_STATEID:
+		if (data->inode) {
+			nfs4_layout_refresh_old_stateid(&data->args.stateid,
+					&dst_range,
+					data->inode);
+		}
+		fallthrough;
 	default:
 		if (nfs4_async_handle_error(task, server, NULL, NULL) == -EAGAIN) {
 			rpc_restart_call_prepare(task);
@@ -10319,8 +10327,8 @@ nfs4_proc_layoutcommit(struct nfs4_layoutcommit_data *data, bool sync)
 		data->args.lastbytewritten,
 		data->args.inode->i_ino);
 
+	data->inode = nfs_igrab_and_active(data->args.inode);
 	if (!sync) {
-		data->inode = nfs_igrab_and_active(data->args.inode);
 		if (data->inode == NULL) {
 			nfs4_layoutcommit_release(data);
 			return -EAGAIN;
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a3135b5af7ee..aaa3719b1957 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -432,7 +432,7 @@ bool nfs4_layout_refresh_old_stateid(nfs4_stateid *dst,
 			goto out;
 		}
 		/* Try to update the seqid to the most recent */
-		err = pnfs_mark_matching_lsegs_return(lo, &head, &range, 0);
+		err = pnfs_mark_matching_lsegs_return(lo, &head, &range, 0, true);
 		if (err != -EBUSY) {
 			dst->seqid = lo->plh_stateid.seqid;
 			*dst_range = range;
@@ -484,7 +484,7 @@ static int pnfs_mark_layout_stateid_return(struct pnfs_layout_hdr *lo,
 		.length = NFS4_MAX_UINT64,
 	};
 
-	return pnfs_mark_matching_lsegs_return(lo, lseg_list, &range, seq);
+	return pnfs_mark_matching_lsegs_return(lo, lseg_list, &range, seq, false);
 }
 
 static int
@@ -522,7 +522,7 @@ pnfs_layout_io_set_failed(struct pnfs_layout_hdr *lo, u32 iomode)
 
 	spin_lock(&inode->i_lock);
 	pnfs_layout_set_fail_bit(lo, pnfs_iomode_to_fail_bit(iomode));
-	pnfs_mark_matching_lsegs_return(lo, &head, &range, 0);
+	pnfs_mark_matching_lsegs_return(lo, &head, &range, 0, false);
 	spin_unlock(&inode->i_lock);
 	pnfs_free_lseg_list(&head);
 	dprintk("%s Setting layout IOMODE_%s fail bit\n", __func__,
@@ -1459,7 +1459,7 @@ _pnfs_return_layout(struct inode *ino)
 	}
 	valid_layout = pnfs_layout_is_valid(lo);
 	pnfs_clear_layoutcommit(ino, &tmp_list);
-	pnfs_mark_matching_lsegs_return(lo, &tmp_list, &range, 0);
+	pnfs_mark_matching_lsegs_return(lo, &tmp_list, &range, 0, false);
 
 	if (NFS_SERVER(ino)->pnfs_curr_ld->return_range)
 		NFS_SERVER(ino)->pnfs_curr_ld->return_range(lo, &range);
@@ -2583,7 +2583,7 @@ pnfs_layout_process(struct nfs4_layoutget *lgp)
 			.iomode = IOMODE_ANY,
 			.length = NFS4_MAX_UINT64,
 		};
-		pnfs_mark_matching_lsegs_return(lo, &free_me, &range, 0);
+		pnfs_mark_matching_lsegs_return(lo, &free_me, &range, 0, false);
 		goto out_forget;
 	} else {
 		/* We have a completely new layout */
@@ -2628,7 +2628,7 @@ int
 pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
 				struct list_head *tmp_list,
 				const struct pnfs_layout_range *return_range,
-				u32 seq)
+				u32 seq, bool committing)
 {
 	struct pnfs_layout_segment *lseg, *next;
 	struct nfs_server *server = NFS_SERVER(lo->plh_inode);
@@ -2658,12 +2658,18 @@ pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
 		}
 
 	if (remaining) {
-		pnfs_set_plh_return_info(lo, return_range->iomode, seq);
-		return -EBUSY;
+		if (!committing) {
+			pnfs_set_plh_return_info(lo, return_range->iomode, seq);
+			return -EBUSY;
+		} else {
+			return 0;
+		}
 	}
 
 	if (!list_empty(&lo->plh_return_segs)) {
-		pnfs_set_plh_return_info(lo, return_range->iomode, seq);
+		if (!committing) {
+			pnfs_set_plh_return_info(lo, return_range->iomode, seq);
+		}
 		return 0;
 	}
 
@@ -2689,7 +2695,7 @@ pnfs_mark_layout_for_return(struct inode *inode,
 	 * segments at hand when sending layoutreturn. See pnfs_put_lseg()
 	 * for how it works.
 	 */
-	if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs, range, 0) != -EBUSY) {
+	if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs, range, 0, false) != -EBUSY) {
 		const struct cred *cred;
 		nfs4_stateid stateid;
 		enum pnfs_iomode iomode;
@@ -2804,7 +2810,7 @@ static int pnfs_layout_return_unused_byserver(struct nfs_server *server,
 		pnfs_get_layout_hdr(lo);
 		pnfs_set_plh_return_info(lo, range->iomode, 0);
 		if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs,
-						    range, 0) != 0 ||
+						    range, 0, false) != 0 ||
 		    !pnfs_prepare_layoutreturn(lo, &stateid, &cred, &iomode)) {
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 91ff877185c8..33a7a09477b2 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -300,7 +300,7 @@ int pnfs_mark_matching_lsegs_invalid(struct pnfs_layout_hdr *lo,
 int pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
 				struct list_head *tmp_list,
 				const struct pnfs_layout_range *recall_range,
-				u32 seq);
+				u32 seq, bool committing);
 int pnfs_mark_layout_stateid_invalid(struct pnfs_layout_hdr *lo,
 		struct list_head *lseg_list);
 bool pnfs_roc(struct inode *ino,
-- 
2.51.0.87.g1fa68948c3.dirty


