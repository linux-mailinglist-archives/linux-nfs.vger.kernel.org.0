Return-Path: <linux-nfs+bounces-17007-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 896B2CB0562
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Dec 2025 15:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25938304D4BD
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Dec 2025 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C56B27AC21;
	Tue,  9 Dec 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVQyKobD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AEA22A4E1
	for <linux-nfs@vger.kernel.org>; Tue,  9 Dec 2025 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765292030; cv=none; b=KXkBNHRYRZ4sH2oJY0Scz3ReBBFwv2LAaNRBjN2fmoia67oFHl5NHLHfP7dvx2lfeZmqExCtgntnLZrdzirBoOvxwa3Hvp9N8LTWlqmZD9Svh50HtvkfPdSiILvViwZqIkAd9uUKvL0EauzcgkD17W+cN2xCKVqlEokK/xxVAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765292030; c=relaxed/simple;
	bh=uFGT0ZEj2AbeXqKs6lrV70ytSZm59Gcxf7iBVJ+4WX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZzd/Ssj4jkvmgOGgoM2/UeezzFSmqg8bHbOLEXBRb8auHbbbU44xW0ZCQvBpGzCAzTCHyf5h3MkNXPk0r0huixtgvX/l3bBrevpmT7w6DJ5FrD2q8qittv3rPK92YMuILSEzkE+snOumWmgVFC3TTKYvos3w9wPpQSCGlEHZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVQyKobD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779c9109ceso5431675e9.1
        for <linux-nfs@vger.kernel.org>; Tue, 09 Dec 2025 06:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765292027; x=1765896827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XUh5sg5yqFLSqapLy+vXru3lVWHscnLIsYFdEarvyS0=;
        b=fVQyKobD8CtsfVvpoMvQs79Vm6Pa0GqlXMIsGA+ogKpcMqvLYC4TDM7sUEnyDDABfx
         ZAEF3T9IbpxybylTwUHviCHiFcTOYXwoa4W/5sihEMcocsb2MDatisYb26XQ8G8geRCz
         ypKyitD0y9Keub2QmgCvVR0UF4r63KANkFotw0ezKQXUFQgKo/+dilojh8w4Uo3z+JTV
         rtfqLwC9WsYLjvHfyJezNrjqj6FUHTo3NtJAHHEgkmItgFByWMciICSnwjWjg2h1DKmZ
         SivvPWoLQHP0w5fEhc3YksAmT1NZrcCV67/ypb0VH5GpCv8pgkkvzShzsfw+A/BhEtmD
         VDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765292027; x=1765896827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUh5sg5yqFLSqapLy+vXru3lVWHscnLIsYFdEarvyS0=;
        b=dd6bYdT2ZPMbDJl6SicBW/Rm6tl2NGDxQHLvNZEsP4vGnseGH9rH7G5hUOcEsRk7Wx
         qes9K9JpxRtLauk1qUoZKaib7PsgCLTZsXhY32SAs/UIU2QKBRVo747XqVjG1oQWF2TM
         aivyqJoxxK3TuYOz1RYlvHYH2zTVp6/1T6Ld0PhxWbF66Rn8vo8uzcrLKg80WsiwYi7F
         k4LFhX+ZLqJ2CDuCpDirAal51sn3RotPpn7J8XsW7zQ99byIqLVX8Rjar8xcRYaeUqPG
         amt/lhK0661AMabs2Yuyr5iArbSJ+Fm2u5Qd4VjTMj3qBNnwxnmh2AM46NhLj8emz6h2
         LvIw==
X-Forwarded-Encrypted: i=1; AJvYcCWhYfo/kd+LEEfrKgq5KBs/GScW1tQ1Aq323z9RC3T18Y6wSIe9Lkq6dN3rq7ayai1tBhMwQxUmW3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyflFDka6j2MITLYZZ//UdvZCEyCBz4vvhSdxF0lw81gbQuxG6a
	x3FP30RUduzv4jtj21VBZVyAGypT3dXaSkouwcwsp9Ei38P9xuv9T32o
X-Gm-Gg: ASbGncsZx5AC43Epm1XN2xH+YCYweETLq+lg5U0RPyLGdIXThpdk6RczZFryII6GMY0
	UEfl/TRHLQokI6lpLQCl73tlooEZjWG45BBNbvJKMX0POIC/KGJWSQyw7tGGq6s4IKLTExqc590
	xTGwHPiUCTOjLcG/ocjBVf3df8Soc9cXP6zZiRfAqQiAK4g6+c6cMzvpOH4RXT1OdssI65Vc1j1
	hJl8wAjFfS+QvGeVAkhuAwu4rwqiTAfSGi+EgYCVfaARg2hjYdW0xBWbcnIEfnIatVjSU4vl5/B
	U/hUByAu6Q3C67zt7tPiDhnEJZfLJL9LWIiEjuUlEua+rgeApqf4GUSgcCGR/jMppPIA8JkXh7e
	y0Tf5Xx4FQVrXZFEPcFd3hKqLlKrYgh7F0u9y+rpnSsAAbzZHmr6RbYJOxjHVEkDdEqilf8xy92
	qKIOYeieMRPKATMaDYLWV5gu+lAWT2qjhAvTHYD+JKMO0SpmjXSaDCEr4d5Yedz2uJJRo4/5pDG
	vodxHjPord8b6c2utQd3VtU9NM=
X-Google-Smtp-Source: AGHT+IHabqNeZqOUTcq+z8LIxjUsvRnmjcY/N9ehDS8dYrqi79lPjDJzf39zxVgHptPGsmn2IqraJA==
X-Received: by 2002:a05:600c:46c9:b0:477:a450:7aa2 with SMTP id 5b1f17b1804b1-47939deffb2mr74716815e9.1.1765292026551;
        Tue, 09 Dec 2025 06:53:46 -0800 (PST)
Received: from Mac.localdomain.com (walt-26-b2-v4wan-170690-cust332.vm13.cable.virginm.net. [82.19.157.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbff320sm32173433f8f.18.2025.12.09.06.53.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Dec 2025 06:53:46 -0800 (PST)
From: Robert Milkowski <rmilkowski@gmail.com>
To: trondmy@kernel.org
Cc: anna@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Robert Milkowski <rmilkowski@gmail.com>
Subject: [PATCH] nfs: pnfs: handle early layoutreturn failures gracefully
Date: Tue,  9 Dec 2025 14:53:30 +0000
Message-ID: <20251209145330.28053-1-rmilkowski@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pnfs_layoutreturn_before_put_layout_hdr() bumps the layout header refcount
and sets NFS_LAYOUT_RETURN before prepare or rpc_run_task dispatch. If the
layout driver fails prepare or rpc_run_task() fails to queue the call, we
currently leak refs and leave waiters stuck on
pnfs_prepare_to_retry_layoutget().

Mirror the normal completion path for these early failures: warn and
schedule pnfs_layoutreturn_retry_later(), free any reserved slot, drop
refs/creds/inode, and clear the wait bit.

Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
---
 fs/nfs/nfs4proc.c | 37 +++++++++++++++++++++++++------------
 fs/nfs/pnfs.c     | 21 +++++++++++++++++++--
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 93c6ce04332b..6066a1c7227d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10132,25 +10132,34 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
 	rpc_restart_call_prepare(task);
 }
 
-static void nfs4_layoutreturn_release(void *calldata)
+static void nfs4_layoutreturn_cleanup(struct nfs4_layoutreturn *lrp, int status)
 {
-	struct nfs4_layoutreturn *lrp = calldata;
 	struct pnfs_layout_hdr *lo = lrp->args.layout;
 
-	if (lrp->rpc_status == 0 || !lrp->inode)
-		pnfs_layoutreturn_free_lsegs(
-			lo, &lrp->args.stateid, &lrp->args.range,
-			lrp->res.lrs_present ? &lrp->res.stateid : NULL);
+	if (status == 0 || !lrp->inode)
+		pnfs_layoutreturn_free_lsegs(lo, &lrp->args.stateid,
+					     &lrp->args.range,
+					     lrp->res.lrs_present ?
+					     &lrp->res.stateid : NULL);
 	else
 		pnfs_layoutreturn_retry_later(lo, &lrp->args.stateid,
 					      &lrp->args.range);
-	nfs4_sequence_free_slot(&lrp->res.seq_res);
+	if (lrp->res.seq_res.sr_slot)
+		nfs4_sequence_free_slot(&lrp->res.seq_res);
 	if (lrp->ld_private.ops && lrp->ld_private.ops->free)
 		lrp->ld_private.ops->free(&lrp->ld_private);
-	pnfs_put_layout_hdr(lrp->args.layout);
-	nfs_iput_and_deactive(lrp->inode);
+	pnfs_put_layout_hdr(lo);
+	if (lrp->inode)
+		nfs_iput_and_deactive(lrp->inode);
 	put_cred(lrp->cred);
-	kfree(calldata);
+	kfree(lrp);
+}
+
+static void nfs4_layoutreturn_release(void *calldata)
+{
+	struct nfs4_layoutreturn *lrp = calldata;
+
+	nfs4_layoutreturn_cleanup(lrp, lrp->rpc_status);
 }
 
 static const struct rpc_call_ops nfs4_layoutreturn_call_ops = {
@@ -10198,8 +10207,12 @@ int nfs4_proc_layoutreturn(struct nfs4_layoutreturn *lrp, unsigned int flags)
 		nfs4_init_sequence(&lrp->args.seq_args, &lrp->res.seq_res, 1,
 				   0);
 	task = rpc_run_task(&task_setup_data);
-	if (IS_ERR(task))
-		return PTR_ERR(task);
+	if (IS_ERR(task)) {
+		status = PTR_ERR(task);
+		trace_nfs4_layoutreturn(lrp->args.inode, &lrp->args.stateid, status);
+		nfs4_layoutreturn_cleanup(lrp, status);
+		return status;
+	}
 	if (!(flags & PNFS_FL_LAYOUTRETURN_ASYNC))
 		status = task->tk_status;
 	trace_nfs4_layoutreturn(lrp->args.inode, &lrp->args.stateid, status);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index f157d43d1312..a489f43344b8 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1370,13 +1370,30 @@ pnfs_send_layoutreturn(struct pnfs_layout_hdr *lo,
 	lrp->args.ld_private = &lrp->ld_private;
 	lrp->clp = NFS_SERVER(ino)->nfs_client;
 	lrp->cred = cred;
-	if (ld->prepare_layoutreturn)
-		ld->prepare_layoutreturn(&lrp->args);
+	if (ld->prepare_layoutreturn) {
+		status = ld->prepare_layoutreturn(&lrp->args);
+		if (status) {
+			pr_warn_ratelimited("NFS: pNFS layoutreturn prepare failed (%d) for layout driver %s\n",
+				status, ld->name ? ld->name : "unknown");
+			goto out_prepare_fail;
+		}
+	}
 
 	status = nfs4_proc_layoutreturn(lrp, flags);
 out:
 	dprintk("<-- %s status: %d\n", __func__, status);
 	return status;
+
+out_prepare_fail:
+	pnfs_layoutreturn_retry_later(lo, &lrp->args.stateid, &lrp->args.range);
+	if (lrp->ld_private.ops && lrp->ld_private.ops->free)
+		lrp->ld_private.ops->free(&lrp->ld_private);
+	if (lrp->inode)
+		nfs_iput_and_deactive(lrp->inode);
+	put_cred(cred);
+	kfree(lrp);
+	pnfs_put_layout_hdr(lo);
+	return status;
 }
 
 /* Return true if layoutreturn is needed */

base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821
-- 
2.47.1


