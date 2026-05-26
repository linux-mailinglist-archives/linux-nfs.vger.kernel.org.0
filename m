Return-Path: <linux-nfs+bounces-21962-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOPeFmSiFWprWwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21962-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:38:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C49095D6A5A
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2C863013847
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85633FAE10;
	Tue, 26 May 2026 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX9KGCRB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DF33FB055;
	Tue, 26 May 2026 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802576; cv=none; b=SO6DMdqOVyICyabC3c6JZTrjXC4LRd9TD6noAo/GMJELCkvlDJ+fybDrmYh422LRhQCn3zvYY0nNcpbFaABX+ijapEBQuAoWH2A4NEy5Ecdk7L8h38f5Tkaou6ehcpNSMXAgvdGRKL/Y/ph2uyXdD/P/2rRfOP0MPQq0TaoLez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802576; c=relaxed/simple;
	bh=MtDeusiagA+X3jRoE7DdhCGzZ/GjrSPAj7u2Ply7JJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pH3nnNFSdGJQrLe9CICn0dNxw5oGX4oLYIy0ydEB8nLwIQrZJcP1xS2LyuXe53SU/79/oxRhjTQEzb3WCTYO+ltK8DBGc/Y4YeVVkrxjfrGubyb2WEiGERHySa0qq6Gj/mhD933rG4H9S8MWmcuDPyeb6NKYKjDjjft2pyFEMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX9KGCRB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5451F000E9;
	Tue, 26 May 2026 13:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802575;
	bh=JfEcSrERzRVNaYwI5nugXfBfKpkG3xQlxLo5iwMnl/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SX9KGCRB00IcGK3KxyV9rMUZlVsPqBMu7yAg5DbZOv/Q9hMQb7sHNwYzLNoMxJPvo
	 gyNw1A2ejA+Pb2KWvEQQv3oxTDgozBLloWKgyYbRJNHpaWOSnAb5fuvnGDtlvdKw+5
	 8K0f2JWnOKcAX3ZVIJp0rWBkb5+gkb+VwS1PGdnBB9dAHniJw6zBAc85tN0HCFqEG6
	 b7WpA6l04xPoQDiD4qtUVx9DOYCR9NQINckXoivIaiLtg9V1L6QaLB9fxK2GZsKiQw
	 r8jM3rSj+P/oYOruazxf3hXfRmlU4aIwupFAmYe7yBckO5GpTgnnzR1BWxdPxY+7RD
	 vLCSmzAiPfNJg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 26 May 2026 09:36:00 -0400
Subject: [PATCH 6/6] svcrdma: Validate Read chunk positions at decode time
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-rpc-kernel-bugs-v1-6-e251306ccca9@oracle.com>
References: <20260526-rpc-kernel-bugs-v1-0-e251306ccca9@oracle.com>
In-Reply-To: <20260526-rpc-kernel-bugs-v1-0-e251306ccca9@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5729;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=btxNslOv5ALJmWJZpkmzlxHkTUyTS1TxMa23AKk7NO0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFaHJk5LKhthyMp9u0djcbfLqgC4L9rHG5oF7U
 EZdUFByPouJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahWhyQAKCRAzarMzb2Z/
 l1+pD/4i8OS5ew2M/E/c5u2o+uqZgAHcgEBNaoMSDGMghMvp83xu4KeRAWWR4aP+aFwGrPERHVx
 BRDe9Iz67dX4/kEORlWGNMIxCfEEjFPSpJqoQ/Jl/2fYAZVoRhO826AaQBplQtmj0FErGBI4a4T
 SO17GhyetaSGT/JNCV5Cgy0hk1BvzborZxZWFplYRtNmjdgKtCiNRKicHsa78HPWLFsGa66JPEr
 jzK0i2OCCCkH6l+CeiH8ffKeYnsI2L2Kc75T/RTFdthC0RhRlHwIwKJgoAcXt2chm/lcaAwpGIH
 EEur7OUwGjXzYckHT2ejSAlDx3Jeaud154r2wCds8+i7w0utIasB+7ULBNgsao24751iw+A60l7
 HWyH3ekmKC0q/pr7QhQkjR2VihvPyZw+mOn/6cnOCW6tsqvM1F1jCc3fASpw5s17hLy5ZejP4vA
 EzvDg+mJiucKNI1IBmcUMsGY4F3jW737HNHd1ZAiI9qTdYcz8Aer8WSsriFFQ62JofYMThG6yOp
 OIcsxSgaIG7gjwkKP8gO3s2Aiv8VNXtJuoFQoz3LXRqFHJu9DdSqIcu+Ep2vcImt904ngPPqkBi
 nPkQc+sfTyDBiOsvLrrmaugtNlJVkfhXwZjCHkA9iioymSrioViouRcy0vXzzsnuhQA8fEJP7Uv
 V54gJbsBMtKNLHA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21962-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C49095D6A5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Read chunk position and length validation is currently scattered
across three consumer functions: svc_rdma_read_data_item(),
svc_rdma_read_multiple_chunks(), and svc_rdma_read_call_chunk().
Each independently guards against the same class of unsigned
arithmetic underflow from untrusted wire values. Any new consumer
of the parsed Read chunk list must replicate these checks or risk
re-introducing the defects fixed by earlier patches in this series.

Add pcl_check_read_chunk_positions() to consolidate position and
length validation into a single post-decode pass, called from
svc_rdma_xdr_decode_req() after all three chunk lists have been
parsed and the inline body length is known. The pass verifies
three properties:

 - Each Read chunk's inline-body offset (its unreduced-stream
   position minus the cumulative length of preceding Read chunks)
   falls within the inline body length, or within the Call chunk
   length for interleaved reads.

 - Adjacent Read chunk positions do not overlap: cumulative read
   bytes at each transition do not exceed the next position.

 - Each chunk length does not exceed the receive context's page
   budget.

Malformed frames are rejected before reaching any consumer. The
existing consumer-side guards remain as defense in depth.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma_pcl.h     |  2 ++
 net/sunrpc/xprtrdma/svc_rdma_pcl.c      | 61 +++++++++++++++++++++++++++++++--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  3 ++
 3 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma_pcl.h b/include/linux/sunrpc/svc_rdma_pcl.h
index 655681cf8fed..6346d8cf2587 100644
--- a/include/linux/sunrpc/svc_rdma_pcl.h
+++ b/include/linux/sunrpc/svc_rdma_pcl.h
@@ -119,6 +119,8 @@ extern bool pcl_alloc_call(struct svc_rdma_recv_ctxt *rctxt, __be32 *p);
 extern bool pcl_alloc_read(struct svc_rdma_recv_ctxt *rctxt, __be32 *p);
 extern bool pcl_alloc_write(struct svc_rdma_recv_ctxt *rctxt,
 			    struct svc_rdma_pcl *pcl, __be32 *p);
+extern bool pcl_check_read_chunk_positions(struct svc_rdma_recv_ctxt *rctxt,
+					   unsigned int inline_len);
 extern int pcl_process_nonpayloads(const struct svc_rdma_pcl *pcl,
 				   const struct xdr_buf *xdr,
 				   int (*actor)(const struct xdr_buf *,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_pcl.c b/net/sunrpc/xprtrdma/svc_rdma_pcl.c
index 18d1045799ce..8623722790f2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_pcl.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_pcl.c
@@ -149,9 +149,6 @@ bool pcl_alloc_call(struct svc_rdma_recv_ctxt *rctxt, __be32 *p)
  *              cl_count is updated to be the number of chunks (ie.
  *              unique position values) in the Read list.
  *      %false: Memory allocation failed.
- *
- * TODO:
- * - Check for chunk range overlaps
  */
 bool pcl_alloc_read(struct svc_rdma_recv_ctxt *rctxt, __be32 *p)
 {
@@ -229,6 +226,64 @@ bool pcl_alloc_write(struct svc_rdma_recv_ctxt *rctxt,
 	return true;
 }
 
+/**
+ * pcl_check_read_chunk_positions - Validate Read chunk positions
+ * @rctxt: Ingress receive context with populated chunk lists
+ * @inline_len: Length of the inline RPC body after the transport header
+ *
+ * Read chunk positions are offsets in the unreduced XDR stream
+ * (RFC 8166 Section 3.4.4), so each position includes the
+ * cumulative length of preceding Read chunks. This function
+ * subtracts those lengths to recover the inline-body offset
+ * before comparing against @inline_len or the Call chunk length.
+ *
+ * Rejects frames where a Read chunk's inline-body offset exceeds
+ * the bound, where adjacent Read chunks overlap, or where any
+ * single chunk length exceeds the page budget.
+ *
+ * Return values:
+ *       %true: Read chunk positions and lengths are valid
+ *      %false: Malformed chunk list detected
+ */
+bool pcl_check_read_chunk_positions(struct svc_rdma_recv_ctxt *rctxt,
+				    unsigned int inline_len)
+{
+	unsigned int max_len, bound, total_read;
+	struct svc_rdma_chunk *chunk, *next;
+
+	max_len = rctxt->rc_maxpages << PAGE_SHIFT;
+
+	if (!pcl_is_empty(&rctxt->rc_call_pcl)) {
+		chunk = pcl_first_chunk(&rctxt->rc_call_pcl);
+		if (chunk->ch_length > max_len)
+			return false;
+		bound = chunk->ch_length;
+	} else {
+		bound = inline_len;
+	}
+
+	if (pcl_is_empty(&rctxt->rc_read_pcl))
+		return true;
+
+	total_read = 0;
+	pcl_for_each_chunk(chunk, &rctxt->rc_read_pcl) {
+		if (chunk->ch_position - total_read > bound)
+			return false;
+		if (chunk->ch_length > max_len)
+			return false;
+
+		next = pcl_next_chunk(&rctxt->rc_read_pcl, chunk);
+		if (!next)
+			break;
+
+		if (chunk->ch_position + chunk->ch_length > next->ch_position)
+			return false;
+		total_read += chunk->ch_length;
+	}
+
+	return true;
+}
+
 static int pcl_process_region(const struct xdr_buf *xdr,
 			      unsigned int offset, unsigned int length,
 			      int (*actor)(const struct xdr_buf *, void *),
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index f6a7533a7555..d64b5f78ce8a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -724,6 +724,9 @@ static int svc_rdma_xdr_decode_req(struct xdr_buf *rq_arg,
 
 	rq_arg->head[0].iov_base = rctxt->rc_stream.p;
 	hdr_len = xdr_stream_pos(&rctxt->rc_stream);
+	if (!pcl_check_read_chunk_positions(rctxt,
+					    rq_arg->head[0].iov_len - hdr_len))
+		goto out_inval;
 	rq_arg->head[0].iov_len -= hdr_len;
 	rq_arg->len -= hdr_len;
 	trace_svcrdma_decode_rqst(rctxt, rdma_argp, hdr_len);

-- 
2.54.0


