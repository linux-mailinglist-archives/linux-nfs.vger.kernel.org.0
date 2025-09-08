Return-Path: <linux-nfs+bounces-14135-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB7EB49B21
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 22:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161F116DBF9
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 20:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA17277CA1;
	Mon,  8 Sep 2025 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg4P+vab"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B8230BF8
	for <linux-nfs@vger.kernel.org>; Mon,  8 Sep 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757363610; cv=none; b=GVASk84X0E+V0KXKTkg0pWYK8ln0PUGD5/L1Rcireko+CFL0aoCDGnI6cc+PbudZaLNTarysJY+Fiy4PuXMGyUjF8RWT0yZESNd7wd/9s8NdEywEr7Xw1UGah/PF/tDk6LhtyE4iOrOLvlgJGez3XxEUKpVjXn0VLWHCNWxE5PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757363610; c=relaxed/simple;
	bh=26BvfW5M1usQ9kY+2XGMdC4H5d5i0+eJkX9Rgfofses=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oy04ZNd79aEQm4gXCYUC8FkPW1XCqxl2MRtag6r5yKwx0z/buB5wkmTK5OIggbn/cYrQ7bp9c26MaP4BC7+GV7QhSD7qtk3JUvSnh7hodavTE2WSY45qeeN7Bk1RoIs42svIcMieYDSI8IG0x+Cd0K4Pdj3HRVgo8eJ3ybPBwMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg4P+vab; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-772679eb358so4459775b3a.1
        for <linux-nfs@vger.kernel.org>; Mon, 08 Sep 2025 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757363608; x=1757968408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hqrV0XeVJ5gbbHMdd4n1hW61EXLWw9K7I2JGlinMMU=;
        b=fg4P+vab5X5/4MAMrO9InqRjDpMTGt3Z02WQQY2M0JrWRAgdbmEpfSLtbR7eaXcxde
         YdLDLiYdRrBiOK+cy6ClqdwAz2Gb5hr5D+7XIME7wg1fS0QQP/ENx9pC+Nps4xZk1PKd
         DaWXm//HsjTOcSwFzEqk0mdlxTcfwBPFUbnLX7hoyJAAYxfq0Nu2sYEHnq2gOxFBNHmL
         io7NtOU5wccqRl3BdczbjeFJ4qOFS7REN8TEGZelerKEdgmotbG4uihRC1EV+JvwGdsN
         Hu0pOgW9t6XHi+cMur5dwLZFcavI+suHLJesPqT49tTDAjLX7HBKfKI4nKEvUj0qs76D
         SWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757363608; x=1757968408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hqrV0XeVJ5gbbHMdd4n1hW61EXLWw9K7I2JGlinMMU=;
        b=Grxg3b81uwUKRBMCPnyXSMpwmpO6WboMFKduuaMKhz73cvIA/k9xncwCgVO7tWO6UX
         Z/xnvMYXltAJ5GgHPJ5l15XM0Ki4xaBPzsXDTOyQHy/OyOxclOVhHlYHMVTgyl+yI/U5
         UL/vLZkK9StVBfCOe+JJ5L2TrO1D15Bfl0Qvc3fmSuVJpZlEDiYZfpaWOOw9BrTo7VPF
         AIL8AXK/igF/KuwnHc3lbhcIsjYSzp+JMi3jxmGUNFmMxtVqR0KN88pEwRvTjFxOr3ll
         tC4Ky0M8LST76irP9eoVqrN5IUhUCMQN+k0W4PZbCqwAeGIgb7XcbNAkJN1f/zOyn5og
         w14g==
X-Gm-Message-State: AOJu0Yy+e9THK08RIG6Ar7c/ozwnPb6bUF5AY/uD2J8R2msdsAMzdaMu
	pbhcpm9ApGptLRI7FLdaV3+5WhXnHCCLNIqSnaDlWAqHb4KoDlyEH1aA
X-Gm-Gg: ASbGncupvnjDHvDjBzrcPzd68JVvyPNL4jL6v9CZ/M5KQa7FZ6CF7fbD6v7B3jowWA/
	/G5PPK001GpBeBviL1A5k+Fxwou2mLA1BrgOoVQ0Roz9EQWoYvQQONInwi++hD6BjrJL3fQUWgm
	ulYSZqVDmeAn03FZEtRgEnShDzciqpusaXk++gSDgFw7kBdKWNGMMp7h6co51TzMmXDh54kNBPb
	n1Msrdh2NhTN6e9tU1RuQkLapack188gN4V3UYN5CZ2GClgWNvWfH8qJNYafa91UEYIrdyXczjW
	slmUs2wyj1523U5kVruV6LzFG+4HZAhWnAkD2+7umi+Jj5YDemVt9VrgP/2gHifsnmsmWaWeexI
	QoCozqDeJey94czcrONAWfyKEZoHBs+8ZcRa0cvQZ7VKQWkAMXgvyjy8E
X-Google-Smtp-Source: AGHT+IE4F5GJqq0iWpF0IXUDsmEv0M881qUsqnhu91vGeaiyGQYYplQtRiD8BzZ4aY8QxCaqkbFGHg==
X-Received: by 2002:a05:6a21:6d9e:b0:248:ace6:7577 with SMTP id adf61e73a8af0-2533e18c2e2mr11263721637.9.1757363608461;
        Mon, 08 Sep 2025 13:33:28 -0700 (PDT)
Received: from haihua-yang.r8.ubvm.nutanix.com ([192.146.154.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2dbcsm28354490b3a.50.2025.09.08.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 13:33:27 -0700 (PDT)
From: Haihua Yang <yanghh@gmail.com>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org,
	yanghh@gmail.com
Subject: [PATCH] draft patches to fixes LAYOUTCOMMIT related issues
Date: Mon,  8 Sep 2025 20:33:24 +0000
Message-ID: <20250908203324.408461-1-yanghh@gmail.com>
X-Mailer: git-send-email 2.51.0.87.g1fa68948c3.dirty
In-Reply-To: <536a67e83ef5b89217c9eaf315e5f24eb6a8b59e.camel@kernel.org>
References: <536a67e83ef5b89217c9eaf315e5f24eb6a8b59e.camel@kernel.org>
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
 fs/nfs/nfs4proc.c | 19 ++++++++++++++++++-
 fs/nfs/pnfs.c     | 15 ++++++++++++---
 fs/nfs/pnfs.h     |  6 ++++--
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7d2b67e06cc3..448a13f2537b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10081,7 +10081,8 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
 	case -NFS4ERR_OLD_STATEID:
 		if (nfs4_layout_refresh_old_stateid(&lrp->args.stateid,
 					&lrp->args.range,
-					lrp->args.inode))
+					lrp->args.inode,
+					false))
 			goto out_restart;
 		fallthrough;
 	default:
@@ -10255,6 +10256,7 @@ nfs4_layoutcommit_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs4_layoutcommit_data *data = calldata;
 	struct nfs_server *server = NFS_SERVER(data->args.inode);
+	struct pnfs_layout_range dst_range;
 
 	if (!nfs41_sequence_done(task, &data->res.seq_res))
 		return;
@@ -10268,6 +10270,14 @@ nfs4_layoutcommit_done(struct rpc_task *task, void *calldata)
 		break;
 	case 0:
 		break;
+	case -NFS4ERR_OLD_STATEID:
+		if (data->inode) {
+			nfs4_layout_refresh_old_stateid(&data->args.stateid,
+					&dst_range,
+					data->args.inode,
+					true);
+		}
+		fallthrough;
 	default:
 		if (nfs4_async_handle_error(task, server, NULL, NULL) == -EAGAIN) {
 			rpc_restart_call_prepare(task);
@@ -10279,10 +10289,17 @@ nfs4_layoutcommit_done(struct rpc_task *task, void *calldata)
 static void nfs4_layoutcommit_release(void *calldata)
 {
 	struct nfs4_layoutcommit_data *data = calldata;
+	struct inode *inode = data->args.inode;
 
 	pnfs_cleanup_layoutcommit(data);
 	nfs_post_op_update_inode_force_wcc(data->args.inode,
 					   data->res.fattr);
+	struct pnfs_layout_hdr *lo;
+	spin_lock(&inode->i_lock);
+	lo = NFS_I(inode)->layout;
+	spin_unlock(&inode->i_lock);
+	pnfs_put_layout_hdr(lo);
+
 	put_cred(data->cred);
 	nfs_iput_and_deactive(data->inode);
 	kfree(data);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a3135b5af7ee..defc0a84e6c7 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -409,7 +409,8 @@ pnfs_clear_lseg_state(struct pnfs_layout_segment *lseg,
  */
 bool nfs4_layout_refresh_old_stateid(nfs4_stateid *dst,
 		struct pnfs_layout_range *dst_range,
-		struct inode *inode)
+		struct inode *inode,
+		bool force_update)
 {
 	struct pnfs_layout_hdr *lo;
 	struct pnfs_layout_range range = {
@@ -433,7 +434,7 @@ bool nfs4_layout_refresh_old_stateid(nfs4_stateid *dst,
 		}
 		/* Try to update the seqid to the most recent */
 		err = pnfs_mark_matching_lsegs_return(lo, &head, &range, 0);
-		if (err != -EBUSY) {
+		if (force_update || err != -EBUSY) {
 			dst->seqid = lo->plh_stateid.seqid;
 			*dst_range = range;
 			ret = true;
@@ -1306,6 +1307,9 @@ pnfs_prepare_layoutreturn(struct pnfs_layout_hdr *lo,
 	/* Serialise LAYOUTGET/LAYOUTRETURN */
 	if (atomic_read(&lo->plh_outstanding) != 0 && lo->plh_return_seq == 0)
 		return false;
+	/* Serialise LAYOUTCOMMIT/LAYOUTRETURN */
+	if (pnfs_layoutcommit_outstanding(lo->plh_inode))
+		return false;
 	if (test_and_set_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags))
 		return false;
 	set_bit(NFS_LAYOUT_RETURN, &lo->plh_flags);
@@ -1686,7 +1690,8 @@ int pnfs_roc_done(struct rpc_task *task, struct nfs4_layoutreturn_args **argpp,
 		return 0;
 	case -NFS4ERR_OLD_STATEID:
 		if (!nfs4_layout_refresh_old_stateid(&arg->stateid,
-						     &arg->range, arg->inode))
+						     &arg->range, arg->inode,
+						     false))
 			break;
 		*ret = -NFS4ERR_NOMATCHING_LAYOUT;
 		return -EAGAIN;
@@ -3397,6 +3402,10 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 		}
 	}
 
+	/* the ref will be free on nfs4_layoutcommit_release, and trigger
+	 * LAYOUTRETURN
+	 */
+	pnfs_get_layout_hdr(nfsi->layout);
 
 	status = nfs4_proc_layoutcommit(data, sync);
 out:
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 91ff877185c8..c6788f1423a3 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -287,7 +287,8 @@ int pnfs_layout_destroy_byclid(struct nfs_client *clp,
 			       enum pnfs_layout_destroy_mode mode);
 bool nfs4_layout_refresh_old_stateid(nfs4_stateid *dst,
 		struct pnfs_layout_range *dst_range,
-		struct inode *inode);
+		struct inode *inode,
+		bool force_update);
 void pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo);
 void pnfs_set_layout_stateid(struct pnfs_layout_hdr *lo,
 			     const nfs4_stateid *new,
@@ -891,7 +892,8 @@ static inline void nfs4_pnfs_v3_ds_connect_unload(void)
 
 static inline bool nfs4_layout_refresh_old_stateid(nfs4_stateid *dst,
 		struct pnfs_layout_range *dst_range,
-		struct inode *inode)
+		struct inode *inode,
+		bool force_update)
 {
 	return false;
 }
-- 
2.51.0.87.g1fa68948c3.dirty


