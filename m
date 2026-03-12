Return-Path: <linux-nfs+bounces-20073-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNcWJen0smmLRAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20073-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 18:16:25 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CB627674A
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 18:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 539F63028B38
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 17:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A9A3EE1FB;
	Thu, 12 Mar 2026 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/MZ4nRW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9723A6B79
	for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335737; cv=none; b=lWmJifeQ5V8KugBWpT+fEKUVPfxSHm0+FcvGSZmhtBbOVLo8si+eSs7psEEs7a1NsvwVceYsan1QsD6012/Z9YihspgQ7B+BguV8AYXF69U18uKrL1n9dgHdrjymwxzCuuCSPwOktKytC7oLH0dAG5geqF+NNWPIl1qx+yOsWN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335737; c=relaxed/simple;
	bh=iE5P1RQx/CdeE6W7PL88sQCi/JoH1+vzmYFuR/LWryY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9O3h0TNAZ93kYJNd6SpEyUJrtVAVGZCxLfdYjvFRrZcFH6nxjppzR04eNSQsaYzmqL5ouhbwWYkAjAgiaOrl8O/dh1oAhFc+G78ZQNfz/rPTFCoh9gz5aHc3EZ+sLIDROqfXJ3CmbqsA+zlm1vMqOd8W4Qpx+a9+TAecq4lXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/MZ4nRW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773335733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ftwAQkQJq//C+nFF6LOnuD+WBhMT8EHQknCoDTo8eBo=;
	b=X/MZ4nRWjB2AqTWWw0Vn/X4zytS2vt1k1mJJw4BE8N4x2HMA6KcwR7pkf/LtWiJPgGqTzR
	skcmv5odIef8QH06wq3jqkk9KJrePrtLkbYoMkPEbC3dWQrTI3GoJa9yuWo3TzhH5EVtI4
	SKW0oCA7pIQS6lCStECCFWDBfD+ihnA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613--qA9DtUGMvq-nqlnGmwVUA-1; Thu,
 12 Mar 2026 13:15:29 -0400
X-MC-Unique: -qA9DtUGMvq-nqlnGmwVUA-1
X-Mimecast-MFC-AGG-ID: -qA9DtUGMvq-nqlnGmwVUA_1773335728
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 405EC197768B;
	Thu, 12 Mar 2026 17:15:28 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.226])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 872CA19540C2;
	Thu, 12 Mar 2026 17:15:27 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna.schumaker@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH 1/1] NFS: fix writeback in presence of errors
Date: Thu, 12 Mar 2026 13:15:26 -0400
Message-ID: <20260312171526.85759-1-okorniev@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20073-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31CB627674A
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
requests to be done synchronously instead.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfs/pagelist.c        | 2 ++
 fs/nfs/write.c           | 2 ++
 include/linux/nfs_page.h | 1 +
 3 files changed, 5 insertions(+)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index a9373de891c9..b835b197a223 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1186,6 +1186,8 @@ static int __nfs_pageio_add_request(struct nfs_pageio_descriptor *desc,
 
 	nfs_page_group_lock(req);
 
+	if (test_bit(PG_SYNC, &req->wb_flags))
+		desc->pg_ioflags |= FLUSH_STABLE;
 	subreq = req;
 	subreq_size = subreq->wb_bytes;
 	for(;;) {
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 1ed4b3590b1a..78f412851d59 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1554,6 +1554,7 @@ static void nfs_writeback_result(struct rpc_task *task,
 	if (resp->count < argp->count) {
 		static unsigned long    complain;
 
+		set_bit(PG_SYNC, &hdr->req->wb_flags);
 		/* This a short write! */
 		nfs_inc_stats(hdr->inode, NFSIOS_SHORTWRITE);
 
@@ -1837,6 +1838,7 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 		/* We have a mismatch. Write the page again */
 		dprintk(" mismatch\n");
 		nfs_mark_request_dirty(req);
+		set_bit(PG_SYNC, &req->wb_flags);
 		atomic_long_inc(&NFS_I(data->inode)->redirtied_pages);
 	next:
 		nfs_unlock_and_release_request(req);
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index afe1d8f09d89..e28599bebd44 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -37,6 +37,7 @@ enum {
 	PG_REMOVE,		/* page group sync bit in write path */
 	PG_CONTENDED1,		/* Is someone waiting for a lock? */
 	PG_CONTENDED2,		/* Is someone waiting for a lock? */
+	PG_SYNC,		/* writeback must write stable */
 };
 
 struct nfs_inode;
-- 
2.52.0


