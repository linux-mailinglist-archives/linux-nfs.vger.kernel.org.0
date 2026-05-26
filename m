Return-Path: <linux-nfs+bounces-21957-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJqNEv6iFWprWwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21957-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:41:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CD15D6B1A
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27C703012E45
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBA23F8ED8;
	Tue, 26 May 2026 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/EvV/0a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB4184524;
	Tue, 26 May 2026 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802573; cv=none; b=KHMHtKSTa1uuyPy86VkkGvifugnkBhrQ2HuWau+osdM4IQVhCsr3bPihhTChrGSiM88OY1lhHvhExqRFOlqnUI0iGZnr/2KCeb+1yNyxOEO5EhQaV5PEeSdLPAXhl8MFaCHwbYL4DhI//oBZKPS0oUyAvEnEHE/VCooc85xiixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802573; c=relaxed/simple;
	bh=pLa2MyfRraYgeNdVitwfUO9zWGwRhhXlWoeeHTz2poQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/NWtQ0R5UvEPjYBMIfUXHa399TeX873+gMv/8Qlx2L8z0MmQPWCd0pZBTTjXb4jnoQioQ3jqCwLza2QVd3kmh6TH/waEs+PrDa/QaaPLHnsGYHpXWIOJ6NNTcuh8kmXZmNNL4qKHJIvOv/4vvCCrZ9NxZ34IWn8sBk6hEGRABM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/EvV/0a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E781F00A3A;
	Tue, 26 May 2026 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802571;
	bh=l046ecS6LCoGFnCJ2dVi35gUFerFmi02XVMgavMzQNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E/EvV/0aJwbfIpnaynitsAlA5fDJlAyxHbFV1wrG3eZD9zAY3T95dfd7OS+9BYMIu
	 Q135FvKFsLTDWJpdU8qMCoyT9r5GK+ZE+YR717qLweqWwhplSwtkho5VgybsepnPxt
	 cegDmM9pvXerWJO25z7PVH8LPNOZn6/L8qqZpT0TJkDLkYG6fOaaWr9tJ6EQRHOIXC
	 BXw5gDzQlwgDF94rzZx2FsIC4oH8gVlXw9jSCnTEyEG8N1QrDO+aPS7jq2dNPEumR2
	 OlzInn0aPkvK/JDmwXne9zdPtqasRNNvaS1y6D7Pl6BwzNWcA5zYSc8+nLt/vQTwiN
	 tSJuhtIVWvEbg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 26 May 2026 09:35:55 -0400
Subject: [PATCH 1/6] svcrdma: validate Read chunk positions before
 reconstruction
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-rpc-kernel-bugs-v1-1-e251306ccca9@oracle.com>
References: <20260526-rpc-kernel-bugs-v1-0-e251306ccca9@oracle.com>
In-Reply-To: <20260526-rpc-kernel-bugs-v1-0-e251306ccca9@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5747;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=fRYNep1d95XmyKWWsX5LvwdDp1GnhdJib7EiG0nD06Q=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFaHJIzlkoSkLJbAmBQjcpdgDrPyKxG5yFUgRJ
 j+x2rLBScWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahWhyQAKCRAzarMzb2Z/
 lzCbD/9TyJgsbU3jxDtwHn5aIejWu4H2E99I8cZgU/CLREx9jEBdiS0q7+Xbkf/ryPQ0a2HAh7/
 EJkPiKW7wQChwTF2W1hI/5YpCxWsSvnIhf3C9cNLVCAxtQbokDHoCqwX32xiRO97JfjojDU4foF
 jDZMTPw1K4n99YREEcE1a6/LP21h7LrYtgY9qU6N7XXuO2TidtKWJSSB+A5krkSByNQqDSuKORU
 u3klxtfLIyQ9V8F/556eIi/SBmj/MuNgPEJCIytXCi/11JTzB7AhGjs+rRMa3lR3nzjXPe63vAl
 LzAB039zPWIks90yWxBF/G5S8hDd8goH8QcrpAQtMncSekob8H2o51t3V3PuiQtMaJJ679d+cQO
 rGe9rxKhSMWpe1nFwuhN244vXmNqZ3k7lP+oyU9rxpEfyneS/PNcG+cmxHthWoGwpJD5/32xxZ6
 ue1xbASyAYAxOXdnLRYqg1wUiSq1sC01dbfPaewhZXLSL4E1voJ0Rs0NWZ0qgdPVMO4dTWqHu6d
 Z6Os1eHqfyLeVfW3o+K2dhQQcyf9rqXnTG9FIRrhVUqGbd5SUvMqCtzL4M00x+wPXMVvvNp2G6M
 PTG8ZQCpfLLlfs9H3/mG4jKhhC8jXndRS+xvCUNP5ACj6YgQsITbxJWjMBvZHW52SAJCvs36d/G
 2sn3UZ0wvdO5nog==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21957-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 35CD15D6B1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

The RPC/RDMA Read chunk position field is supplied by the remote
client and stored verbatim in the parsed chunk list.
xdr_count_read_segments() checks only 4-byte alignment; it never
compares the position against the received inline body length.

In the single-chunk path, svc_rdma_read_complete_one() splits the
head and tail kvecs at ch_position.  A position past the inline
body underflows the tail length, exposing adjacent slab memory to
the upper XDR decoder.

In the multi-chunk path, svc_rdma_read_multiple_chunks() computes
gap lengths between chunks as unsigned subtractions from
ch_position.  Overlapping Read chunks cause these subtractions to
underflow.  A final position past the inline body likewise
underflows the trailing gap length.  svc_rdma_copy_inline_range()
then copies past the receive buffer into request pages that are
returned to the client through the Reply channel.

Bound inline-range copies in svc_rdma_copy_inline_range() against
the decoded inline RPC body saved in rc_saved_arg.  Reject a
single Read chunk positioned beyond that body, and reject
multi-chunk lists where accumulated read bytes exceed the next
chunk's position.  Apply the same position and overlap checks in
the call-chunk interleaving path.

Fixes: d96962e6d0e2 ("svcrdma: Use the new parsed chunk list when pulling Read chunks")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index c535e6de9654..eb4bc56ed387 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -1065,7 +1065,7 @@ static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
  * svc_rdma_copy_inline_range - Copy part of the inline content into pages
  * @rqstp: RPC transaction context
  * @head: context for ongoing I/O
- * @offset: offset into the Receive buffer of region to copy
+ * @offset: offset into the inline content of region to copy
  * @remaining: length of region to copy
  *
  * Take a page at a time from rqstp->rq_pages and copy the inline
@@ -1082,9 +1082,13 @@ static int svc_rdma_copy_inline_range(struct svc_rqst *rqstp,
 				      unsigned int offset,
 				      unsigned int remaining)
 {
-	unsigned char *dst, *src = head->rc_recv_buf;
+	unsigned char *dst, *src = head->rc_saved_arg.head[0].iov_base;
+	unsigned int inline_len = head->rc_saved_arg.head[0].iov_len;
 	unsigned int page_no, numpages;
 
+	if (offset > inline_len || remaining > inline_len - offset)
+		return -EINVAL;
+
 	numpages = PAGE_ALIGN(head->rc_pageoff + remaining) >> PAGE_SHIFT;
 	for (page_no = 0; page_no < numpages; page_no++) {
 		unsigned int page_len;
@@ -1135,9 +1139,10 @@ svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
 {
 	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
 	struct svc_rdma_chunk *chunk, *next;
-	unsigned int start, length;
+	unsigned int inline_len, start, length;
 	int ret;
 
+	inline_len = head->rc_saved_arg.head[0].iov_len;
 	start = 0;
 	chunk = pcl_first_chunk(pcl);
 	length = chunk->ch_position;
@@ -1155,6 +1160,8 @@ svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
 			break;
 
 		start += length;
+		if (head->rc_readbytes > next->ch_position)
+			return -EINVAL;
 		length = next->ch_position - head->rc_readbytes;
 		ret = svc_rdma_copy_inline_range(rqstp, head, start, length);
 		if (ret < 0)
@@ -1162,7 +1169,9 @@ svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
 	}
 
 	start += length;
-	length = head->rc_byte_len - start;
+	if (start > inline_len)
+		return -EINVAL;
+	length = inline_len - start;
 	return svc_rdma_copy_inline_range(rqstp, head, start, length);
 }
 
@@ -1187,8 +1196,12 @@ svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
 static int svc_rdma_read_data_item(struct svc_rqst *rqstp,
 				   struct svc_rdma_recv_ctxt *head)
 {
-	return svc_rdma_build_read_chunk(rqstp, head,
-					 pcl_first_chunk(&head->rc_read_pcl));
+	struct svc_rdma_chunk *chunk = pcl_first_chunk(&head->rc_read_pcl);
+
+	if (chunk->ch_position > head->rc_saved_arg.head[0].iov_len)
+		return -EINVAL;
+
+	return svc_rdma_build_read_chunk(rqstp, head, chunk);
 }
 
 /**
@@ -1257,14 +1270,17 @@ static int svc_rdma_read_call_chunk(struct svc_rqst *rqstp,
 			pcl_first_chunk(&head->rc_call_pcl);
 	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
 	struct svc_rdma_chunk *chunk, *next;
-	unsigned int start, length;
+	unsigned int call_len, start, length;
 	int ret;
 
 	if (pcl_is_empty(pcl))
 		return svc_rdma_build_read_chunk(rqstp, head, call_chunk);
 
+	call_len = call_chunk->ch_length;
 	start = 0;
 	chunk = pcl_first_chunk(pcl);
+	if (chunk->ch_position > call_len)
+		return -EINVAL;
 	length = chunk->ch_position;
 	ret = svc_rdma_read_chunk_range(rqstp, head, call_chunk,
 					start, length);
@@ -1281,6 +1297,10 @@ static int svc_rdma_read_call_chunk(struct svc_rqst *rqstp,
 			break;
 
 		start += length;
+		if (next->ch_position > call_len)
+			return -EINVAL;
+		if (head->rc_readbytes > next->ch_position)
+			return -EINVAL;
 		length = next->ch_position - head->rc_readbytes;
 		ret = svc_rdma_read_chunk_range(rqstp, head, call_chunk,
 						start, length);
@@ -1289,7 +1309,9 @@ static int svc_rdma_read_call_chunk(struct svc_rqst *rqstp,
 	}
 
 	start += length;
-	length = call_chunk->ch_length - start;
+	if (start > call_len)
+		return -EINVAL;
+	length = call_len - start;
 	return svc_rdma_read_chunk_range(rqstp, head, call_chunk,
 					 start, length);
 }

-- 
2.54.0


