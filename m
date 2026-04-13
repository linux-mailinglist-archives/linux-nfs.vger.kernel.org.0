Return-Path: <linux-nfs+bounces-20828-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AFuFXpt3WlNeAkAu9opvQ
	(envelope-from <linux-nfs+bounces-20828-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 00:26:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E28BB3F3D24
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 00:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C2423006B78
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 22:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECB33947B0;
	Mon, 13 Apr 2026 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbV0QbDg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A76395260
	for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2026 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119071; cv=none; b=HPor2RLoKclwUqlhUxvdLvc3eM/YZI7wW0vZWMXJwPXjOShi0u8g+Bhgoka08Z8pbnNEpTZX0KPhUy7tj+EX7H/V4HEbUYPWLnPs/TsZ9u7xBkPqji7A5+/EGghdtgs6s/HymUNFACkTKgQVUd3F70pCU2fJa/ndU7c1/iicQsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119071; c=relaxed/simple;
	bh=/kk+kpyXrGVqmvOov0VTz9SDsQomJ63AV3nRmwlw7mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Amsm699E7cou9JJ3rrs81LTwFJnMejrTFtGoMpeBHRJ8bBhC6A3aaxdHWI6qliPKo8QJLqdTbiA/W3IwIJr1d50Frg6xVFnwlkHipyMCHfdaATLIIYKuJVBvozQAdZb5fNsbrX+j/r+ufkZeV9VPzPWM71V48UxrgssJBl3GW2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbV0QbDg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776119069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KqdHWWt8Z+qMJRWJNIvZVs+qPNXEdWXN74hjdXJolJA=;
	b=IbV0QbDgx6v7cLi95pRJnqFjkLFKyCG7x5nwEsK6f6vtthB5O81xLEUa7xREaeVz29y2LY
	dWCd0hu8utGTHTrwjd5/rLjSPFQCAHP7TEo42xSMp8T3/N+OEpakgUhOi9a8PnYJ+/2cNW
	L30HYkyhNN3QTQeXEYj8zTf7h++WcqE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-j3YN4EXZNquY_0mV6Bft4w-1; Mon,
 13 Apr 2026 18:24:25 -0400
X-MC-Unique: j3YN4EXZNquY_0mV6Bft4w-1
X-Mimecast-MFC-AGG-ID: j3YN4EXZNquY_0mV6Bft4w_1776119064
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE8F3195608B;
	Mon, 13 Apr 2026 22:24:24 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.64.155])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F244A195608E;
	Mon, 13 Apr 2026 22:24:23 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/1] NFS: fix writeback in presence of errors
Date: Mon, 13 Apr 2026 18:24:23 -0400
Message-ID: <20260413222423.90089-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
	TAGGED_FROM(0.00)[bounces-20828-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E28BB3F3D24
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
 fs/nfs/localio.c       | 15 ++++++++++++++-
 fs/nfs/pagelist.c      |  3 +++
 fs/nfs/write.c         |  9 +++++++++
 include/linux/nfs_fs.h |  1 +
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 4c7d16a99ed6..e55c5977fcc3 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -865,6 +865,8 @@ static void nfs_local_call_write(struct work_struct *work)
 	file_start_write(filp);
 	n_iters = atomic_read(&iocb->n_iters);
 	for (int i = 0; i < n_iters ; i++) {
+		size_t icount;
+
 		if (iocb->iter_is_dio_aligned[i]) {
 			iocb->kiocb.ki_flags |= IOCB_DIRECT;
 			/* Only use AIO completion if DIO-aligned segment is last */
@@ -881,8 +883,16 @@ static void nfs_local_call_write(struct work_struct *work)
 		if (status == -EIOCBQUEUED)
 			continue;
 		/* Break on completion, errors, or short writes */
+		icount = iov_iter_count(&iocb->iters[i]);
 		if (nfs_local_pgio_done(iocb, status) || status < 0 ||
-		    (size_t)status < iov_iter_count(&iocb->iters[i])) {
+		    (size_t)status < icount) {
+			if ((size_t)status < icount) {
+				struct nfs_lock_context *ctx =
+					iocb->hdr->req->wb_lock_context;
+
+				set_bit(NFS_CONTEXT_WRITE_SYNC,
+					&ctx->open_context->flags);
+			}
 			nfs_local_write_iocb_done(iocb);
 			break;
 		}
@@ -901,6 +911,9 @@ static void nfs_local_do_write(struct nfs_local_kiocb *iocb,
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


