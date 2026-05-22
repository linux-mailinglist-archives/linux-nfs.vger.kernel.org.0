Return-Path: <linux-nfs+bounces-21822-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ej/KNmxEGpWcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21822-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:43:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A385B989A
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13B2A300EDA0
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D073822A9;
	Fri, 22 May 2026 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPhCAhyY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5B3803D3;
	Fri, 22 May 2026 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478967; cv=none; b=uAox20P9Lc4/NJHicigavvQ2tec7+CLeVAdYp0ABuIRJZ0+2a8sQ94gscM210V/B/yL956s3jHyMdXq3cEh0Doleq5WStXkJcbquqfDiIT8Li2ls2Y6Kj5cjUUM/Le6F0PC/mQtcCsv+9ZGj6UbCb83Kx2+zGGzPwAZ8TpgumgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478967; c=relaxed/simple;
	bh=b1rU6ZAGMx709xUdqTWwkbd1Zwx96RNeV+LNlMCfsIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oKa2hNJFul0qi+53h/KDJiKNwpSOk/qWM+IVLICfE0f4bmrKjpVTwzfsvOEY/c7aLh2xwKjbM7e9pX9KVtdhflEziE7VOWk681iq0SV50wBeG6Lc59bYdlEGJ2VnDj7qJZMiiD+guLrKeKEZVsbpsG2DZ9xecmkXkBAR8IvPz1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPhCAhyY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26FE1F00A3D;
	Fri, 22 May 2026 19:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478963;
	bh=4LN8CBPtlSu0h1hjRMQR5ihtJ8gQEm1OuiggHng7lj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gPhCAhyYDH4dmcyEn5tJrdgyPr/4VkQtzVMqhSy1EBMkhyt6Ql+F/fAnF4zBC1SQ3
	 BlmcU0Ko6YQ2deUhAcje+7qUekkMLa/n1NE0dsyNGhE+yZ539sf3Ga/UPAYigBR470
	 Wr2QnNaLTP/LSvAgIbxBsXkM9SAKsYrLZ1Jv2pq/wnJQzYnZTEpS99cBBEl5BcEM0F
	 p6cmz8r5jmj2WvPxIJzJSvM5n4J0YNufzBDvtHZlvf62OhKTFUKq+M6mhsxa9lSni9
	 Jej0TL4fjveAh3FFBZQKaMC9BmXWQrFKpPpOdx/GEPfqkRjXZA0deZ8ByACy9NBn1N
	 QQJmRaCn5nC1g==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 15:42:12 -0400
Subject: [PATCH v5 07/21] nfsd: add callback encoding and decoding linkages
 for CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v5-7-542cddfad576@kernel.org>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
In-Reply-To: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3990; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=b1rU6ZAGMx709xUdqTWwkbd1Zwx96RNeV+LNlMCfsIs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqELGeZ404nPoGDydU6cP9mtCSwKD0rYnoDQu05
 DKsMbnvnH2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCxngAKCRAADmhBGVaC
 FTKUD/944yseFE8rQqTsizSRKDSWgPwbYMR9cZ5sEIwIm1l2ajOWUEf99Uub5Kk/TwPNBJIQktq
 AD2uvPOVWOHyaoe/4lIw3AotrU9D1ZHDPE1vH3DejJEg/Vj8GjqrmfI7MsB+8USfq7aRnSj10df
 faM/ARtMe3rgKQ1XKkNa44Pou+tb+QyIIjS6ZXc971QEw4Ddyj2te5rmMiytI0fJRXFedhGY4Do
 gLJuqfS/nvbr2GHGUbuGxkovkZYVh2fBBqzMRhQfpThhjE59/+obY1FksQ2QySIlJV2/fZpHn+p
 uHZfBNybzKrs1mp6JEi/PD+ReHKPLJP36DxI86+hmP3skH5svEsXTCkt+GNDJ7ZGfiiwKlnXIQd
 tax6nBQi3nunU+w0fONp6XLKHbLS2UouqAMMkgL9ap8559Hk1zj78tme9xgs0Y9FK7InkZHf5Yo
 miYwHPIFkVZnwiPxA4oIIEtk8zGAEDkoE7vsldDBJkcjmEfNdO2wHFl1neGdIsGUXTWeCjzyVw4
 w44GO0PnR9GICXlqHtwfIeKwudKk6acfGCAUgcKvtJMu9IXuPOgyEczyvt6FFTFNaTpLupxDMHi
 Xv0WpZazCxldJyVVFQDabLS5wOW+pvY9j7DiRpcgAcAzO5M6zyUv55RcA13P5zgSgkEWqxT7T9M
 zcsM+AeKUE+vLmQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21822-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 85A385B989A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add routines for encoding and decoding CB_NOTIFY messages. These call
into the code generated by xdrgen to do the actual encoding and
decoding.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h        |  8 ++++++++
 fs/nfsd/xdr4cb.h       | 12 ++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 25bbf5b8814d..ea3e7deb06fa 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -865,6 +865,51 @@ static void encode_stateowner(struct xdr_stream *xdr, struct nfs4_stateowner *so
 	xdr_encode_opaque(p, so->so_owner.data, so->so_owner.len);
 }
 
+static void nfs4_xdr_enc_cb_notify(struct rpc_rqst *req,
+				   struct xdr_stream *xdr,
+				   const void *data)
+{
+	const struct nfsd4_callback *cb = data;
+	struct nfs4_cb_compound_hdr hdr = {
+		.ident = 0,
+		.minorversion = cb->cb_clp->cl_minorversion,
+	};
+	struct CB_NOTIFY4args args = { };
+
+	WARN_ON_ONCE(hdr.minorversion == 0);
+
+	encode_cb_compound4args(xdr, &hdr);
+	encode_cb_sequence4args(xdr, cb, &hdr);
+
+	/*
+	 * FIXME: get stateid and fh from delegation. Inline the cna_changes
+	 * buffer, and zero it.
+	 */
+	WARN_ON_ONCE(!xdrgen_encode_CB_NOTIFY4args(xdr, &args));
+
+	hdr.nops++;
+	encode_cb_nops(&hdr);
+}
+
+static int nfs4_xdr_dec_cb_notify(struct rpc_rqst *rqstp,
+				  struct xdr_stream *xdr,
+				  void *data)
+{
+	struct nfsd4_callback *cb = data;
+	struct nfs4_cb_compound_hdr hdr;
+	int status;
+
+	status = decode_cb_compound4res(xdr, &hdr);
+	if (unlikely(status))
+		return status;
+
+	status = decode_cb_sequence4res(xdr, cb);
+	if (unlikely(status || cb->cb_seq_status))
+		return status;
+
+	return decode_cb_op_status(xdr, OP_CB_NOTIFY, &cb->cb_status);
+}
+
 static void nfs4_xdr_enc_cb_notify_lock(struct rpc_rqst *req,
 					struct xdr_stream *xdr,
 					const void *data)
@@ -1026,6 +1071,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
 #ifdef CONFIG_NFSD_PNFS
 	PROC(CB_LAYOUT,	COMPOUND,	cb_layout,	cb_layout),
 #endif
+	PROC(CB_NOTIFY,		COMPOUND,	cb_notify,	cb_notify),
 	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
 	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
 	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e1c40f8b5d01..790282781243 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -190,6 +190,13 @@ struct nfs4_cb_fattr {
 	u64 ncf_cur_fsize;
 };
 
+/*
+ * FIXME: the current backchannel encoder can't handle a send buffer longer
+ *        than a single page (see bc_alloc/bc_free).
+ */
+#define NOTIFY4_EVENT_QUEUE_SIZE	3
+#define NOTIFY4_PAGE_ARRAY_SIZE		1
+
 /*
  * Represents a delegation stateid. The nfs4_client holds references to these
  * and they are put when it is being destroyed or when the delegation is
@@ -774,6 +781,7 @@ enum nfsd4_cb_op {
 	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
 	NFSPROC4_CLNT_CB_RECALL_ANY,
 	NFSPROC4_CLNT_CB_GETATTR,
+	NFSPROC4_CLNT_CB_NOTIFY,
 };
 
 /* Returns true iff a is later than b: */
diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
index f4e29c0c701c..b06d0170d7c4 100644
--- a/fs/nfsd/xdr4cb.h
+++ b/fs/nfsd/xdr4cb.h
@@ -33,6 +33,18 @@
 					cb_sequence_dec_sz +            \
 					op_dec_sz)
 
+#define NFS4_enc_cb_notify_sz		(cb_compound_enc_hdr_sz +       \
+					cb_sequence_enc_sz +            \
+					1 + enc_stateid_sz +            \
+					enc_nfs4_fh_sz +		\
+					1 +				\
+					NOTIFY4_EVENT_QUEUE_SIZE *	\
+					(2 + (NFS4_OPAQUE_LIMIT >> 2)))
+
+#define NFS4_dec_cb_notify_sz		(cb_compound_dec_hdr_sz  +      \
+					cb_sequence_dec_sz +            \
+					op_dec_sz)
+
 #define NFS4_enc_cb_notify_lock_sz	(cb_compound_enc_hdr_sz +        \
 					cb_sequence_enc_sz +             \
 					2 + 1 +				 \

-- 
2.54.0


