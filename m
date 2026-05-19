Return-Path: <linux-nfs+bounces-21702-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO38BbpoDGpXggUAu9opvQ
	(envelope-from <linux-nfs+bounces-21702-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 15:42:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3CE57FE05
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 15:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B65C43098CA9
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 13:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A662348C74;
	Tue, 19 May 2026 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBz4LnZf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7755D348C65
	for <linux-nfs@vger.kernel.org>; Tue, 19 May 2026 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197674; cv=none; b=Vd19bjNWEQkDmLrG8auvk53x5xWY+MHqJGPZOwp/Z9Q179CBW3c7DxFn0yrmtlXjlKHH2unT4QulCPtNVhttR6tiZYC2xy9YqZeiL5YVhk28bqeG++Cr+pDL2rXkmx9EERhBI1JVAr32R6z3b6jpXmzBFN4vYbEiSYSknRAD/II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197674; c=relaxed/simple;
	bh=ljdbDG6oVsb8HxPcd1nNvmeCZwHlRGUgq9GY+LiwZzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dkWXjYVKYIlIG9LWteH3tLVWijBWnZH9vKRKi5/QwIOOJS2x32Wi4oUBce/A7f6ppGw4i3FE47JYK6s5NeJkFzfT8PKn2ShPD9sXDZlIk96JeSFCHVl6k7vyHEWIuI/k5FNwndw5lgrQ99nLalDUmioEba0mvozmo5rS66LOk5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBz4LnZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C59AC2BCF6;
	Tue, 19 May 2026 13:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779197674;
	bh=ljdbDG6oVsb8HxPcd1nNvmeCZwHlRGUgq9GY+LiwZzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iBz4LnZfRAB1rpNewaql4xPoppNfNb5lB6xl2Ik7wuYEDfygqoV12hDEa6gGFHtOy
	 EEEDzFHTrS+6BmFRRfTQQ9UrdlkrcvBREIm3bprUknSnEc3WpaUG3A80OMfumZ13L/
	 J0r6STUAVrr1evk5iLO+Owh9mFtXUs0ZSiBpihc3BjqmZyeiv2fqCbArZUR4K8GrD6
	 X3FZ6G7rGmXLe8lmeqDNjZnwLSED7EzcFAdjd++LHwbDlV8zLrcjLxk3GO0QA/e8nQ
	 6RUNwAFkDRRV2nY81DsqVWw0RKSrv5BUitciNZMZ9YVxUBzR18IvUw/+YjWcvYQxFe
	 U18AysrQSRUkA==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 19 May 2026 09:34:22 -0400
Subject: [PATCH 2/2] SUNRPC: Return an error from xdr_buf_to_bvec() on
 overflow
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-xdr-buf-to-bvec-fix-v1-2-1c9decbd4466@oracle.com>
References: <20260519-xdr-buf-to-bvec-fix-v1-0-1c9decbd4466@oracle.com>
In-Reply-To: <20260519-xdr-buf-to-bvec-fix-v1-0-1c9decbd4466@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5832;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=/WZXhUUgIS72G9oP4iEvgzAKNCpjCnrt9NGcOPSRn1I=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDGbnjxjVjs1/QWkq/rx0QnbSE10HCzPwaponu
 U7DqqOSyl6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagxm5wAKCRAzarMzb2Z/
 l3/7D/4mzHhL0Z3iVUThijrjKgM8g4YpOA9M3acdrr/MUjPLoPnSnVMrphnXbSe1zufkDSR4dUs
 E0Zu1yzEEje3sKZAIiP6Wf13ct3H4wvjg6knAG0mtE5YEqNMur8FG2xSCW2RklO2y3RoCao6sIv
 /C2ZhtrTdI91/G+uvERIUuTTizkQ8vcYPairehgMQlfxnPmOgkiCrg6dHBRqD46RZoIwc3s8hue
 9HkpTjfWf3O+L7ZRrxX999ABaoe2sOGxcq0ns+6x6RfC1yiIacTCaxXXAaLFXGUNJJnq57UGDnd
 2JC3Pddgn36CxPc1hyfP0I8xDFfsb64ASWJNxIkhsv3vPORJ8qkdW3o+1V5tDuP3SEot5onl3YZ
 yjVFrHBliJv3FT+xDuvFQ7bFzCFqwPzPEMe8kWJ1FvxaWGMubIVnj+hPxUGDjZZsjOVFKbQGsOj
 PZpT0dVTJYjDrkshes2ygt0THFXwcbqD/snzwmvm+u0xeB3ad1xVCW/bpZHAO3+8t/ExquavA8A
 udoU0RyvUF5f2jfqfruBHmcl0oqXi8dg/NqHF9PTIUo23WyQhYTklzxMFnEdGS3xplQSknSvgbw
 oD7MN6B2wmu9d+5dN7mK3dHkC1Eg/d3HNMYgDbgtaXM/GYu0iyCr7R9nfWTmk3dRgDM992drGd6
 y/qLMPwEf99cD2w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21702-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 6E3CE57FE05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

xdr_buf_to_bvec() returns a slot count even when the caller's bvec
budget is exhausted partway through the xdr_buf. Callers feed that
count into iov_iter_bvec() and continue as if the conversion had
succeeded, silently sending or writing fewer bytes than the data
length declares. For an NFS WRITE the server reports the truncated
transfer to the client as full success.

The overflow represents an internal invariant violation: a higher
layer reserved a bvec budget too small for the xdr_buf it then
asked the encoder to convert. That is a server-side fault, not a
media I/O failure and not a malformed client argument.

Change xdr_buf_to_bvec() to return a signed int and have the
overflow label return -ESERVERFAULT. Update the three callers to
detect the negative return and fail the request: nfsd_vfs_write()
folds the error into host_err, which nfserrno() translates to
nfserr_serverfault for the WRITE reply; svc_udp_sendto() and
svc_tcp_sendmsg() propagate the error out of the send path.

Reported-by: Chris Mason <clm@meta.com>
Fixes: 2eb2b9358181 ("SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c              |  6 +++++-
 include/linux/sunrpc/xdr.h |  4 ++--
 net/sunrpc/svcsock.c       | 14 ++++++++++++--
 net/sunrpc/xdr.c           | 11 ++++++-----
 4 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index eafdf7b7890f..83324cf472ef 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1439,7 +1439,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	unsigned long		exp_op_flags = 0;
 	unsigned int		pflags = current->flags;
 	bool			restore_flags = false;
-	unsigned int		nvecs;
+	int			nvecs;
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
@@ -1479,6 +1479,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
+	if (nvecs < 0) {
+		host_err = nvecs;
+		goto out_nfserr;
+	}
 
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 31971b01d962..b102b4f21e6b 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -138,8 +138,8 @@ void	xdr_terminate_string(const struct xdr_buf *, const u32);
 size_t	xdr_buf_pagecount(const struct xdr_buf *buf);
 int	xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp);
 void	xdr_free_bvec(struct xdr_buf *buf);
-unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
-			     const struct xdr_buf *xdr);
+int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
+		    const struct xdr_buf *xdr);
 int xdr_buf_to_sg(const struct xdr_buf *buf, unsigned int offset,
 		  unsigned int len, struct scatterlist *sg, unsigned int nsg);
 int xdr_buf_to_sg_alloc(const struct xdr_buf *buf, unsigned int offset,
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 7be3de1a1aed..c434b6a6637d 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -732,7 +732,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 		.msg_flags	= MSG_SPLICE_PAGES,
 		.msg_controllen	= sizeof(buffer),
 	};
-	unsigned int count;
+	int count;
 	int err;
 
 	svc_udp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
@@ -746,6 +746,10 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 		goto out_notconn;
 
 	count = xdr_buf_to_bvec(svsk->sk_bvec, SUNRPC_MAX_UDP_SENDPAGES, xdr);
+	if (count < 0) {
+		err = count;
+		goto out_trace;
+	}
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
 		      count, rqstp->rq_res.len);
@@ -757,6 +761,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 		err = sock_sendmsg(svsk->sk_sock, &msg);
 	}
 
+out_trace:
 	trace_svcsock_udp_send(xprt, err);
 
 	mutex_unlock(&xprt->xpt_mutex);
@@ -1237,7 +1242,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 	struct msghdr msg = {
 		.msg_flags	= MSG_SPLICE_PAGES,
 	};
-	unsigned int count;
+	int count;
 	void *buf;
 	int ret;
 
@@ -1253,10 +1258,15 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 
 	count = xdr_buf_to_bvec(svsk->sk_bvec + 1, rqstp->rq_maxpages,
 				&rqstp->rq_res);
+	if (count < 0) {
+		ret = count;
+		goto out;
+	}
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
 		      1 + count, sizeof(marker) + rqstp->rq_res.len);
 	ret = sock_sendmsg(svsk->sk_sock, &msg);
+out:
 	page_frag_free(buf);
 	return ret;
 }
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 8f52782d8a37..fa6a30b5f046 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -139,13 +139,14 @@ xdr_free_bvec(struct xdr_buf *buf)
 /**
  * xdr_buf_to_bvec - Copy components of an xdr_buf into a bio_vec array
  * @bvec: bio_vec array to populate
- * @bvec_size: element count of @bio_vec
+ * @bvec_size: element count of @bvec
  * @xdr: xdr_buf to be copied
  *
- * Returns the number of entries consumed in @bvec.
+ * Returns the number of entries consumed in @bvec on success, or
+ * -ESERVERFAULT when @xdr does not fit within @bvec_size entries.
  */
-unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
-			     const struct xdr_buf *xdr)
+int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
+		    const struct xdr_buf *xdr)
 {
 	const struct kvec *head = xdr->head;
 	const struct kvec *tail = xdr->tail;
@@ -187,7 +188,7 @@ unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
 
 bvec_overflow:
 	pr_warn_once("%s: bio_vec array overflow\n", __func__);
-	return count;
+	return -ESERVERFAULT;
 }
 EXPORT_SYMBOL_GPL(xdr_buf_to_bvec);
 

-- 
2.54.0


