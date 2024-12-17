Return-Path: <linux-nfs+bounces-8634-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44139F56E0
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 20:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D1C1884843
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 19:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197E11F9411;
	Tue, 17 Dec 2024 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idc/VNhx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA1158DD1
	for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2024 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463671; cv=none; b=SubGnheDEAvAd8P00yA+xh5otP1PNghilA07YWHYcxR7Thsm5EgClhr8HHAzxsX54qlLlodp1KEj3J0MhL1I+hHygt7wE8s0H8avYSqUkPUWh8T523V9TSA73k0CNBeSopGOsWFbLEYTYlXmaNVfz4Dydqx0/324bnrlYUXky80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463671; c=relaxed/simple;
	bh=d7WanNGvQ6XQ74kGDGvnkUS34xmAUz5mQffwL0/oEbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kM4agQffC/S/NJ/rb47b9kkaL0qqlMdxyp0mkYgQdzotV5ARJM8y5xbdDR9gZpTD9QkowPbI2ar0zVbN+9kOeumCYiwVIDzxn0VaDZnp9T+N904htJ8pGSlSwQRQdGXSHdF+vOkqq/AqMZm987fUfHb30zafGH6mFyeKNy3FztY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=idc/VNhx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734463668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NpITz8PI70KmVQu3IX1MJZMMEvCNCRS6kszzJh/121I=;
	b=idc/VNhxMzoL5u+TMy/keltADxoiA4fQfWnP5DI65LKe4a5VuFssV/IE8QRV2PL+0Ql6eV
	7+gJHys6m+YUo5BH0bxJZMQbZe6+i6jQb5OeTCPGv7kRYLNtQchgaBDG9TnvtyBVrFILTU
	bSHajmqNdsGZNcMPOkqu/pxHmc6qYXQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-U7LKsjr1N8CCgryJB0xyDg-1; Tue,
 17 Dec 2024 14:27:47 -0500
X-MC-Unique: U7LKsjr1N8CCgryJB0xyDg-1
X-Mimecast-MFC-AGG-ID: U7LKsjr1N8CCgryJB0xyDg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C20F6195608B;
	Tue, 17 Dec 2024 19:27:45 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.171])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95E3D19560A2;
	Tue, 17 Dec 2024 19:27:44 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/1] NFSD: fix management of pending async copies
Date: Tue, 17 Dec 2024 14:27:42 -0500
Message-Id: <20241217192742.97306-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Consider async copy done once it's done processing the copy work.

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


