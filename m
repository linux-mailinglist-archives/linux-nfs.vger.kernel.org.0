Return-Path: <linux-nfs+bounces-20392-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH6cCb4kxGmZwgQAu9opvQ
	(envelope-from <linux-nfs+bounces-20392-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 19:09:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE7132A4E3
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 19:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9718A3037D59
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 18:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6947D1CF8B;
	Wed, 25 Mar 2026 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5bM1PMI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0E3A6B99
	for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2026 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461676; cv=none; b=FocmoDpz0gXqk+DDctRuNKzCdG+imVO1VtbQ/14NPyFC8Mh2Y1JibPUIvxQ6llPNGTKQZ8s3g3ZIMfiWx0Yyge9bTi55x4A752amnBN/dudKK4KrLQUhes0iXXt2e/JGHf1dfib/wOYF4e8sLP3an3tkvKgCThbafwea1KFZzOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461676; c=relaxed/simple;
	bh=At+4KAROLFn553bVjbM7nchRD2uHhKThefpaiCx/Yp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kyoOVLhHLEIvcWMz2cg0OTHmCD+Tw7z1kuMwUql186EaQfBBrb2SRR6YuxAltlY0SJs1EgBD+Jl4CiUuHv0OFzy7cNlGJOqvewn7+aJtsnMnzVvsYy33AcNd8ErfBCMzb5PswvuD9M7kqjUn+u/mCKUSGtEhXz8/7yTXh/6LIkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5bM1PMI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774461669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ensWMldkgtYqv+9NCGAS4ItQwizFY0DwpM8o0aK/AWc=;
	b=P5bM1PMI8Y8B/AwFCpanjv+9UPoSkSj09uxNY6XqXfZMExgZDV88nLrF5DOU178OEkRGCh
	9a9z4HKcA5UteY+XjnqkBlNhoAD1OIytJ2PiMNk0zt28cEBA2/D0iW5DxkHkdJDcObZt7a
	BDDllZgD9ZiVEZdz++JWv8ysPCqOGyk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-LGfymtjpP--uONl7xjioYQ-1; Wed,
 25 Mar 2026 14:01:04 -0400
X-MC-Unique: LGfymtjpP--uONl7xjioYQ-1
X-Mimecast-MFC-AGG-ID: LGfymtjpP--uONl7xjioYQ_1774461662
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B79C71828BA7;
	Wed, 25 Mar 2026 18:00:51 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.64.84])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 100C31800351;
	Wed, 25 Mar 2026 18:00:50 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFS: fix writeback in presence of errors
Date: Wed, 25 Mar 2026 14:00:50 -0400
Message-ID: <20260325180050.55186-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20392-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CE7132A4E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After running xfstest generic/751, in certain conditions, can have
a writeback IO stuck while experiencing one of the two patterns.

Pattern#1: writeback IO experiences ENOSPC on an offset smaller
than the filesize. Example,
write offset=0 len=4096 how=unstable OK
write offset=8192 len=4096 how=unstable OK
write offset=12288 len=4096 how=unstable ENOSPC
write offset=4096 len=4096 how=unstable ENOSPC
client sends a commit and receives a verifier which is different
from the last successful write. It marks pages dirty and writeback
retries. But it again send writes unstable and gets into the same
pattern, running into the ENOSPC error and sending a commit because
writes were sent at unstable.

Pattern#2: an unstable write followed by a short write and ENOSPC.
write offset=0 len=4096 how=unstable OK
write offset=4096 len=4096 how=unstable returns OK but count=100
write offset=4197 len=3996 how=stable returns ENOSPC
client send a commit and receives a verifier different from
the last unstable write. The same behaviour is retried in a loop.

Instead, this patch proposes to identify those conditions and mark
requests to be done synchronously instead. Previous solution tried
to mark it in the nfs_page, however that's not persistent thus
instead mark it in the nfs_open_context.

Furthermore, the same problem occurs during localio code path so
recognize that IO needs to be done sync in that case as well.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfs/localio.c       | 10 ++++++++++
 fs/nfs/pagelist.c      |  3 +++
 fs/nfs/write.c         |  9 +++++++++
 include/linux/nfs_fs.h |  1 +
 4 files changed, 23 insertions(+)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 4c7d16a99ed6..d4f04534966a 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -883,6 +883,13 @@ static void nfs_local_call_write(struct work_struct *work)
 		/* Break on completion, errors, or short writes */
 		if (nfs_local_pgio_done(iocb, status) || status < 0 ||
 		    (size_t)status < iov_iter_count(&iocb->iters[i])) {
+			if ((size_t)status < iov_iter_count(&iocb->iters[i])) {
+				struct nfs_lock_context *ctx =
+					iocb->hdr->req->wb_lock_context;
+
+				set_bit(NFS_CONTEXT_WRITE_SYNC,
+					&ctx->open_context->flags);
+			}
 			nfs_local_write_iocb_done(iocb);
 			break;
 		}
@@ -901,6 +908,9 @@ static void nfs_local_do_write(struct nfs_local_kiocb *iocb,
 		__func__, hdr->args.count, hdr->args.offset,
 		(hdr->args.stable == NFS_UNSTABLE) ?  "unstable" : "stable");
 
+	if (test_bit(NFS_CONTEXT_WRITE_SYNC,
+		     &hdr->req->wb_lock_context->open_context->flags))
+		hdr->args.stable = NFS_FILE_SYNC;
 	switch (hdr->args.stable) {
 	default:
 		break;
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index a9373de891c9..4a87b2fdb2e6 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1186,6 +1186,9 @@ static int __nfs_pageio_add_request(struct nfs_pageio_descriptor *desc,
 
 	nfs_page_group_lock(req);
 
+	if (test_bit(NFS_CONTEXT_WRITE_SYNC,
+		     &req->wb_lock_context->open_context->flags))
+		desc->pg_ioflags |= FLUSH_STABLE;
 	subreq = req;
 	subreq_size = subreq->wb_bytes;
 	for(;;) {
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 1ed4b3590b1a..ddae197d2d3f 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -927,9 +927,13 @@ static void nfs_write_completion(struct nfs_pgio_header *hdr)
 			goto remove_req;
 		}
 		if (nfs_write_need_commit(hdr)) {
+			struct nfs_open_context *ctx =
+				hdr->req->wb_lock_context->open_context;
+
 			/* Reset wb_nio, since the write was successful. */
 			req->wb_nio = 0;
 			memcpy(&req->wb_verf, &hdr->verf.verifier, sizeof(req->wb_verf));
+			clear_bit(NFS_CONTEXT_WRITE_SYNC, &ctx->flags);
 			nfs_mark_request_commit(req, hdr->lseg, &cinfo,
 				hdr->ds_commit_idx);
 			goto next;
@@ -1553,7 +1557,10 @@ static void nfs_writeback_result(struct rpc_task *task,
 
 	if (resp->count < argp->count) {
 		static unsigned long    complain;
+		struct nfs_open_context *ctx =
+			hdr->req->wb_lock_context->open_context;
 
+		set_bit(NFS_CONTEXT_WRITE_SYNC, &ctx->flags);
 		/* This a short write! */
 		nfs_inc_stats(hdr->inode, NFSIOS_SHORTWRITE);
 
@@ -1837,6 +1844,8 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 		/* We have a mismatch. Write the page again */
 		dprintk(" mismatch\n");
 		nfs_mark_request_dirty(req);
+		set_bit(NFS_CONTEXT_WRITE_SYNC,
+			&req->wb_lock_context->open_context->flags);
 		atomic_long_inc(&NFS_I(data->inode)->redirtied_pages);
 	next:
 		nfs_unlock_and_release_request(req);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 8dd79a3f3d66..4623262da3c0 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -109,6 +109,7 @@ struct nfs_open_context {
 #define NFS_CONTEXT_BAD			(2)
 #define NFS_CONTEXT_UNLOCK	(3)
 #define NFS_CONTEXT_FILE_OPEN		(4)
+#define NFS_CONTEXT_WRITE_SYNC		(5)
 
 	struct nfs4_threshold	*mdsthreshold;
 	struct list_head list;
-- 
2.52.0


