Return-Path: <linux-nfs+bounces-8638-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 535879F589C
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 22:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF0B16572D
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8461F9AAE;
	Tue, 17 Dec 2024 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgqGU0Ha"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF08192D69
	for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2024 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470302; cv=none; b=BMtsjGaxLq0Uw5/H6Uz6g5zRtya4a39RBh2d6g0Z2rQQrTNEztAgJgMNHn7RW4l+gm/58BLdPHxkrmyDymTUfilub8tOl8hiezW6Ji39aNXbtZU1eV2W0MOJWVNyTDycgz3pmHJTFFJzP8/P/CrG8nS09ZAYnV/9oZzExW8gUQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470302; c=relaxed/simple;
	bh=0N20tLWmBq7m7v5/UolYuDFdyEmxqjQMAFWsON/1UaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EmaBvGqSScJiz39QW/0Ap7kEWEXJK2SqDaE1KWXbyODBri2zvdZezSqPcOBL1zn/9WLp36j7h18toQD2UxQCNGB3LAy98py8KZgj1c07rAiNnG9ern8SG4Vh8Z1uitaGFBa39kjpAyTEJq8lLKdrLD9BuNjqkDTts3g7/XJpHaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgqGU0Ha; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734470299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dp0wZR5aTijdsTc4RjllryEBPtUL3M5336HIt/G/nTA=;
	b=HgqGU0HaFtEaX3wkrTMj0CeoNBZmup54JpdhH+GmGtSU0WWr2TsCYFXfRx6Mw+tVUkbh/E
	ivb/FK1evqdzfLO55FeYLdLd9BLuoEtAbUijjFCSe5VNSPoq8rn4negvNBvgcFez4KlssF
	KRsTKnZ1D/7Ruxwoh4QhVhwSHNJ/2XA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-Sz8uYTcoMtKfi8-Ktb730Q-1; Tue,
 17 Dec 2024 16:18:16 -0500
X-MC-Unique: Sz8uYTcoMtKfi8-Ktb730Q-1
X-Mimecast-MFC-AGG-ID: Sz8uYTcoMtKfi8-Ktb730Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A7BC1955E9A;
	Tue, 17 Dec 2024 21:18:15 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.171])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A29901955F54;
	Tue, 17 Dec 2024 21:18:14 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH v2] NFSD: fix management of pending async copies
Date: Tue, 17 Dec 2024 16:18:12 -0500
Message-Id: <20241217211812.98104-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently the pending_async_copies count is decremented just
before a struct nfsd4_copy is destroyed. After commit aa0ebd21df9c
("NFSD: Add nfsd4_copy time-to-live") nfsd4_copy structures sticks
around for 10 lease periods after the COPY itself has completed,
the pending_async_copies count stays high for a long time. This
causes NFSD to avoid the use of background copy even though the
actual background copy workload might no longer be running.

In this patch, decrement pending_async_copies once async copy thread
is done processing the copy work.

Fixes: aa0ebd21df9c ("NFSD: Add nfsd4_copy time-to-live")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4proc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f8a10f90bc7a..ad44ad49274f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1347,7 +1347,6 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
 		return;
-	atomic_dec(&copy->cp_nn->pending_async_copies);
 	kfree(copy->cp_src);
 	kfree(copy);
 }
@@ -1870,6 +1869,7 @@ static int nfsd4_do_async_copy(void *data)
 	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
 	trace_nfsd_copy_async_done(copy);
 	nfsd4_send_cb_offload(copy);
+	atomic_dec(&copy->cp_nn->pending_async_copies);
 	return 0;
 }
 
@@ -1927,19 +1927,19 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		/* Arbitrary cap on number of pending async copy operations */
 		if (atomic_inc_return(&nn->pending_async_copies) >
 				(int)rqstp->rq_pool->sp_nrthreads)
-			goto out_err;
+			goto out_dec_async_copy_err;
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
 		if (!async_copy->cp_src)
-			goto out_err;
+			goto out_dec_async_copy_err;
 		if (!nfs4_init_copy_state(nn, copy))
-			goto out_err;
+			goto out_dec_async_copy_err;
 		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
 			sizeof(result->cb_stateid));
 		dup_copy_fields(copy, async_copy);
 		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
 				async_copy, "%s", "copy thread");
 		if (IS_ERR(async_copy->copy_task))
-			goto out_err;
+			goto out_dec_async_copy_err;
 		spin_lock(&async_copy->cp_clp->async_lock);
 		list_add(&async_copy->copies,
 				&async_copy->cp_clp->async_copies);
@@ -1954,6 +1954,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	trace_nfsd_copy_done(copy, status);
 	release_copy_files(copy);
 	return status;
+out_dec_async_copy_err:
+	if (async_copy)
+		atomic_dec(&nn->pending_async_copies);
 out_err:
 	if (nfsd4_ssc_is_inter(copy)) {
 		/*
-- 
2.43.5


