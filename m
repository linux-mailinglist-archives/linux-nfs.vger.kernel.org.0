Return-Path: <linux-nfs+bounces-22609-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ddiAOrA9MWrMewUAu9opvQ
	(envelope-from <linux-nfs+bounces-22609-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:12:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD6968F2B2
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:12:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Dt+qZHsw;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22609-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22609-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B899A30ACA1B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3B644D014;
	Tue, 16 Jun 2026 11:59:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D044CAEC;
	Tue, 16 Jun 2026 11:59:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611161; cv=none; b=HfFbVBgSrhQRAkie7v/FxpqOy7XHJ3Bg1Y/cj7wXAY0baJugwLF++NpPUG6hRAip85Wt6L5xjfMJqlEEwToo/VQP/Qc9QXaW3YxJ3dekccyOqIqmLwYaWuKwM/ITJkF02fPvIlQ/lpAWzyTfLmB7tJztloeVAaqSKhaXJSUdKnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611161; c=relaxed/simple;
	bh=bOsb1pdf7KioAQ9RetJpCwU05nRf/YZNOAZbR1whsxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kx2BmgsEPV7fpQ3weUTP+l/zXAy2qd0NJ2m+fRkIMkwnwc/vl6InaJRnLkugz86fK715SommLZxysvGBMHrqWshOlN5HsPxRT++3x566TooXbfyyB/vUF7qLvzqHBn8P4VxPN+08mNnFn6dGxF7Pw20nWhx18tPMmbLRRe/nN04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt+qZHsw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616A91F00A3A;
	Tue, 16 Jun 2026 11:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781611160;
	bh=502RzCgnnIYsRMykZdLQSp6ZP0qp6gl9w2Ok/9E8y24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Dt+qZHswI7vo5+NnD7SS8qvGXP7uB8kEWYoqQHTDoIf7jxKESkdGE8g6KZyiG5kSs
	 yP0pNGTlyd1f58j8AUqVOaw7IHKra04/goKojABr2PvnR56PTNXh8w/9yognyFeEbF
	 6XzX25iD8pvVPNKycBmvrMVUcgc/bky25udmo3a2WFpnbmEvNTd1pAAtm6851FMBUh
	 HSVUT+5960BtlLMnkXNBNJfoylVuQH2qqM4yd+1OZVMe/rWiBGQtXFgLSC2k/36WIJ
	 aVvbGNfPvGw91cm9QjvNj3EembJ47xQzs3o8xeFVllSFMrVv8wK3WHe0hjK8W+6MZU
	 hTRzluRGvZzSA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 07:58:50 -0400
Subject: [PATCH v7 07/20] nfsd: add callback encoding and decoding linkages
 for CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dir-deleg-v7-7-6cbc7eac0ade@kernel.org>
References: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
In-Reply-To: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Chuck Lever <cel@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5994; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bOsb1pdf7KioAQ9RetJpCwU05nRf/YZNOAZbR1whsxM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMTqFDAZMfieYMRGkLIVSyKVIg4lmDQJ8UNzEE
 MjDsgY11Y6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajE6hQAKCRAADmhBGVaC
 FQOHD/9gZgcclynNonoXW5kKkTh8MIeQGpXDREWr70uhAOvCH0F1Q/2hLQWplqtpZdJnaEUiEHQ
 npNfcPDsDU+y9bvbZPr8iGEytDkBHOEHZfR5O4zkhNDk6jMNQuVhDRikA8oeq7ahdgjU98x0CJn
 HNSUwKie5iIhVoKi8vaLRRociUaP4CmY6o7XfIvRShmtDToB1HGnoP/sjN5RwRSwxntWD++iBxQ
 wMiEfwT/h/M4PLRq5mUNJI7XXBHELokwObr9xCk+apgiMZPP5G8I3vpLGSPyDALbckudDx2UqDk
 YPtq8kNikHHtdcUOLEdJafg9/ZKvKZYZ+G/4TVcx5wZTnf5VkKQVo7DmL+/00XKpXvgBNZBiajA
 uLxzYfTmcWiv55P7sdH78nVqTlKgQOLc/Cs2pMXOuWP5IO6eRS4VqM+BaqghEr74oEp1Al+3wH3
 /hHCe/+8pmM6UijLz9yQwshVChv/xhdj8WpIQFFkeRapD7ilWpmKWPr5aND0w+74ilgAZIl+6cs
 ktVaIgpbMznNL3wCeBmSdA8AO+CFL9K4KMlmbX+Jhxsd7BUw6JVYuDwDzempmWK+Ut4gdwRCXP0
 +etGmpg2Vbnt26W0RtfOQxr8ld8R4ItJsg0LAS+nny60XjO8vA1Fo4Vz2Vi0Ac0DOsc6/Uc19Lc
 tNDKaFu07qA2HEQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22609-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AD6968F2B2

Add routines for encoding and decoding CB_NOTIFY messages. These call
into the code generated by xdrgen to do the actual encoding and
decoding.

For now, the encoder is a stub. Later patches will flesh out the payload
encoding.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/sunrpc/xdr/nfs4_1.x |  1 +
 fs/nfsd/nfs4callback.c            | 46 +++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr_gen.c             |  4 ++--
 fs/nfsd/nfs4xdr_gen.h             |  3 +++
 fs/nfsd/state.h                   |  8 +++++++
 fs/nfsd/xdr4cb.h                  | 12 ++++++++++
 6 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/Documentation/sunrpc/xdr/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
index 4c3842e23859..99a831d68da8 100644
--- a/Documentation/sunrpc/xdr/nfs4_1.x
+++ b/Documentation/sunrpc/xdr/nfs4_1.x
@@ -490,6 +490,7 @@ struct CB_NOTIFY4args {
         nfs_fh4     cna_fh;
         notify4     cna_changes<>;
 };
+pragma public CB_NOTIFY4args;
 
 struct CB_NOTIFY4res {
         nfsstat4    cnr_status;
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index c7f914eab3b0..2df281554abf 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -891,6 +891,51 @@ static void encode_stateowner(struct xdr_stream *xdr, struct nfs4_stateowner *so
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
+	xdrgen_encode_CB_NOTIFY4args(xdr, &args);
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
@@ -1052,6 +1097,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
 #ifdef CONFIG_NFSD_PNFS
 	PROC(CB_LAYOUT,	COMPOUND,	cb_layout,	cb_layout),
 #endif
+	PROC(CB_NOTIFY,		COMPOUND,	cb_notify,	cb_notify),
 	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
 	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
 	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
index 61346d9e6833..b1a583a6dfa1 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -713,7 +713,7 @@ xdrgen_decode_notify4(struct xdr_stream *xdr, struct notify4 *ptr)
 	return true;
 }
 
-static bool __maybe_unused
+bool
 xdrgen_decode_CB_NOTIFY4args(struct xdr_stream *xdr, struct CB_NOTIFY4args *ptr)
 {
 	if (!xdrgen_decode_stateid4(xdr, &ptr->cna_stateid))
@@ -1135,7 +1135,7 @@ xdrgen_encode_notify4(struct xdr_stream *xdr, const struct notify4 *value)
 	return true;
 }
 
-static bool __maybe_unused
+bool
 xdrgen_encode_CB_NOTIFY4args(struct xdr_stream *xdr, const struct CB_NOTIFY4args *value)
 {
 	if (!xdrgen_encode_stateid4(xdr, &value->cna_stateid))
diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
index b989f37cdee8..0e11cd537a98 100644
--- a/fs/nfsd/nfs4xdr_gen.h
+++ b/fs/nfsd/nfs4xdr_gen.h
@@ -32,4 +32,7 @@ bool xdrgen_decode_posixaceperm4(struct xdr_stream *xdr, posixaceperm4 *ptr);
 bool xdrgen_encode_posixaceperm4(struct xdr_stream *xdr, const posixaceperm4 value);
 
 
+bool xdrgen_decode_CB_NOTIFY4args(struct xdr_stream *xdr, struct CB_NOTIFY4args *ptr);
+bool xdrgen_encode_CB_NOTIFY4args(struct xdr_stream *xdr, const struct CB_NOTIFY4args *value);
+
 #endif /* _LINUX_XDRGEN_NFS4_1_DECL_H */
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 4c6765a4cf22..9f321e9ed76d 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -190,6 +190,13 @@ struct nfs4_cb_fattr {
 	u64 ncf_cur_fsize;
 };
 
+/*
+ * FIXME: the current backchannel encoder can't handle a send buffer longer
+ *        than a single page (see bc_malloc/bc_free).
+ */
+#define NOTIFY4_EVENT_QUEUE_SIZE	3
+#define NOTIFY4_PAGE_ARRAY_SIZE		1
+
 /*
  * Represents a delegation stateid. The nfs4_client holds references to these
  * and they are put when it is being destroyed or when the delegation is
@@ -776,6 +783,7 @@ enum nfsd4_cb_op {
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


