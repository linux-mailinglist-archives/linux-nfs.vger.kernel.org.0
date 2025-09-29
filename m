Return-Path: <linux-nfs+bounces-14792-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BD0BAA94C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 22:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7DA192456F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6E423BF8F;
	Mon, 29 Sep 2025 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsxeU1W3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2F1F5820
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176536; cv=none; b=Gz5U4qfIXL8qw18Aoq0cfa23k1FGEaRCli6GFbCpzwOD1AKxd7fa0ltzU3cX1fypiDH7fpmrlHhyDrFfybCWIlsvtDb/fK/XsQe9Fc8XMp1kd3wyCX3aOP+E3W6MujCTuGa+WOzlx5rGlZCVxgLkBjeGw3+1ug4Oh4v2DCjIgow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176536; c=relaxed/simple;
	bh=SuZ/A2JjPxArTky3IIZuhbNOiNPxX616YsRonnXhU/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtDETcsezNsqvEGJpBfYE2WkzgPcTGPxFl3gruHOmHMm2P5dvEvadDFwrQHm+YRAZKBXgWEbtDCPN3nacj3X8C9dMrW5TjqWx+Z9Fgf8V51egsIrSw5DMVejblBD+VzFJazTW9kn7TgWmTVsse84kApdeHst3hYaYuEZnqaNT9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsxeU1W3; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7835321bc98so2146067b3a.2
        for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 13:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759176534; x=1759781334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWch4Fjm0sXHfMoXSG8aqTROoGbIm0xveCm6pUnfOmE=;
        b=RsxeU1W3sA9vM7RpPEOtupiqU7VoCp9qH1Et0a9GMizhUO6IEx2/V0udjWjuJWigaa
         iQHwb+a7bvHP0dgLoQKssEeN5nTwnqZyw6CYt5wVKnZoPXit6vI23NHbwvhTeiwzXG7P
         GfiQWdwjFrIuOAnVg5NqmzKkIPkU4bBP4KLgN/O7JW8OHXgv0fS5+VWjwN13L6MQHl2w
         Je9w224x/o3LvMAEqgy2Uaq2B5yk4+JQfzGOD3rcvNbWVT48wcpP1LV9OlN6KvmvF0gp
         Tz033rCvNlZtJNCeKZrjFeGoC8cDT4RQTdGCei0OCpJGBwApXBxdj1ugiwPBPKeKrP0o
         cAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759176534; x=1759781334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWch4Fjm0sXHfMoXSG8aqTROoGbIm0xveCm6pUnfOmE=;
        b=AyNPQt1EdWxsl7HcH/23FBqBZCOz0lFURmtwP5hxwL9qV6yQoAXNlQX9v+1d2sF0x5
         ZD5F4QEbd6lnKU1j6j1G4R0AwKZMN//eYBoLEB5FCs6awvyHD45jbvT5hlDLikr5Xfjb
         TLrLLQkGS+HzwzUa3YCUi3G0ZKYx0YoN8ZSQIvFowmWsNbHpR//m821VrM7MgHcMYV2U
         jB25PEMNZk+rmSoNTAcKbcWDSeQ5efAT0E9wXXr0HmUp06zfVuGcXGydn1xOYfeLg5Ym
         onJV08yHMlS/yRoTbNeLKNlvITCwOzqVDdq7E8LcfbRrpziuxpQwshFmCC9UegxFNr9A
         R8dA==
X-Gm-Message-State: AOJu0YzuvqwM0xuXsFiLW8mOKZgRuOZG9pp07dBrYixiE3ii5zXLF/OD
	zzsTsTqXmIKn0Fdhs2OLyrGkQVjy/60X/TWo8nMbzkAqjBzWpb3GeKWN
X-Gm-Gg: ASbGncttec5DOfK2mjO4ovtJnw2thHKBcUpLMYl/wJ2xuMBG9bS0dzLaXO02CQj8swK
	uAQcVnVS1D6/rFzkoBJFvg7VXrYxXGdYES2fADEDBIS66VzJvEbnDyS2Dq8SrUNo70sdYmkf7tU
	NsQrJGxsT8RnKlwKZCwG/Nw76M9VS+ztKDB5bs6iGPOqJ22NStpWOmJsR+tl2YOJ/zwsbPtdK0h
	1Vn3oY5XFuOaAUlFzlHLj+HRXskU3O1GXjritfjrjElU/x5FTd6MZUehSiabfvyJwfmWaGH3RYs
	QUUgWVDjoaTMpcMuP/Y5g0g/g0NF0vuCfE/rQhHeYdj2qCLSGumWiU3hG7bYI50FUnrmzaL/1XQ
	E6XevJrISuZ7wAzmvwQMIsRCUWC0aEJcjifImlcDau1Lga/ndmvN8DK4cVCMUV/7WT0s=
X-Google-Smtp-Source: AGHT+IHQZOraXxKOCPudH1R8UpcHD7+sXzB44veJ/0UJyxN4C4QnFqY2xMUSyaU5YctjsqnKPl0CfQ==
X-Received: by 2002:a05:6a00:813:b0:781:17ba:ad76 with SMTP id d2e1a72fcca58-78117baaf03mr15171778b3a.24.1759176533567;
        Mon, 29 Sep 2025 13:08:53 -0700 (PDT)
Received: from haihua-yang.r8.ubvm.nutanix.com ([192.146.154.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c1873sm11818642b3a.23.2025.09.29.13.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 13:08:52 -0700 (PDT)
From: Haihua Yang <yanghh@gmail.com>
To: yanghh@gmail.com
Cc: linux-nfs@vger.kernel.org,
	trondmy@kernel.org
Subject: [PATCH] draft patches to fixes LAYOUTCOMMIT related issues
Date: Mon, 29 Sep 2025 20:08:47 +0000
Message-ID: <20250929200847.69837-1-yanghh@gmail.com>
X-Mailer: git-send-email 2.51.0.87.g1fa68948c3.dirty
In-Reply-To: <20250908203324.408461-1-yanghh@gmail.com>
References: <20250908203324.408461-1-yanghh@gmail.com>
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
 fs/nfs/nfs4proc.c | 20 +++++++++++++++++++-
 fs/nfs/pnfs.c     | 15 ++++++++++++---
 fs/nfs/pnfs.h     |  6 ++++--
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7d2b67e06cc3..d1607b4606c7 100644
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
@@ -10263,11 +10265,20 @@ nfs4_layoutcommit_done(struct rpc_task *task, void *calldata)
 	case -NFS4ERR_DELEG_REVOKED: /* layout was recalled */
 	case -NFS4ERR_BADIOMODE:     /* no IOMODE_RW layout for range */
 	case -NFS4ERR_BADLAYOUT:     /* no layout */
+	case -NFS4ERR_STALE_STATEID: /* stale layout */
 	case -NFS4ERR_GRACE:	    /* loca_recalim always false */
 		task->tk_status = 0;
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
@@ -10279,10 +10290,17 @@ nfs4_layoutcommit_done(struct rpc_task *task, void *calldata)
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


