Return-Path: <linux-nfs+bounces-20886-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGuyCtcg4WmapQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20886-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:48:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D6241342D
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53F9F309085D
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF917366558;
	Thu, 16 Apr 2026 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/wQMUsu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3243E1217;
	Thu, 16 Apr 2026 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360949; cv=none; b=QgbKh0cYh8hBmI0ktMOijHxB8kec6KROrnz/EsJpHZVfHb0KMoxYIF92Uc6rxUXok+0kRwV5/nmIPUh+zjSpsEYfrf1b54NfF6sTY6K/C3hV+jmcYRxMr0c2wTkNwpQwIlB+AAEgRzLG4WRsMNIdgDRMilMUhBbNQL+JI/FMg0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360949; c=relaxed/simple;
	bh=QsfWLs2tuIZnRN7M+rne4mPXGqyvfLmtMwoip+RYIUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lqIHGjA+rwdRSMSOvEpo35+xmmuIT1z78vrx1zE2FQ0K1VBEegN/ne/9rbHNIr9k8RcGt0W59gvtbG/spyhKGcd1nAXtDWI6LK9rTCsaZlPgMw03qQ19+kvzrsOMMvgEVLiLNfROhaoBa5yj1KVTR8i0ed03zM7KpUAO99j2D14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/wQMUsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D72C2BCC4;
	Thu, 16 Apr 2026 17:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360949;
	bh=QsfWLs2tuIZnRN7M+rne4mPXGqyvfLmtMwoip+RYIUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e/wQMUsuskXBZ98o6z2QFzNbdA3ag9Yc7Qies23QVRFtvCqtTwLajdRH9hmLWz464
	 z8YMTdk2aq3B407nOdELZCOuNHnzo5fXX6M9ZnoYEhMEzbYTQ7WzZOZQdQ5P4Lw+Ur
	 N/tsAzQG0O8wZ5ucQAy0X6GXKXN/NRrx15gjvaz3sQe7aFreWdrR9jXVJnSWMSMAn7
	 JEQAL80KJGsjkvHCIIo/Iuon+FSJiFF+rt+43chyREpSzLr9dcsFd62uqwCUimY54V
	 MryRsDsPJ/WFPfvVRmnmlqreIYgk59qF/yQ72vlARu21OQyeD16hr63Deg2SDYqSSK
	 wmhu19imjaKcA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:15 -0700
Subject: [PATCH v2 14/28] nfsd: add callback encoding and decoding linkages
 for CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-14-851426a550f6@kernel.org>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3990; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=QsfWLs2tuIZnRN7M+rne4mPXGqyvfLmtMwoip+RYIUc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3lWI50JIKNRsFVx4AGjMwire3Z5S7gS9ph3
 8YukROLAsWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd5QAKCRAADmhBGVaC
 FXacD/4hDjhdSY++v+l4oCKXP9p0GHe7MfC8JrOE8cDCVXkJjYVLrhvfAZByA5xL6OwqLiohyR3
 iKy0B//wV0vxrgKFClkwh/CNTolE5XO+v2NxKSdTeqaYFR4DlK4ysV8o4s5jilHzqVYqwubvZ6I
 ENIURQPAg+LuZ8euqCuBqa2tu4KA6Sr+OI8euvNHkTJVGENMCir5B2AqIKRowU1qUUSzFLgpare
 2g6owzSbouvriWFANBJFnVea3FlBNRIvz9P2vezywTP5OiuW1TwQl7sE+O+41aUbzhsjeW4FMpi
 QiLImxkY5gEsHOA4hG6xY/ggtcyN1sMacnbkMdlORT5Tt/YlVSriYrLfL7p18USwdnR09FeUYJf
 CWhWxK+FuzrjtI1kSos4S9zNUonCQAifBzrH8TD3qzMaLbhCmvKqmFO4YCZZi0reUrbvXiXNsb9
 l9/P451N37NYkauOava2Fc9hAMyGcziXxqedlI5TCznZ+ktBYssLLcLZHPmHCzfcKYdCJ8x+hRc
 I/57BryVe/17acFj4Lui/c1vzJVnkWVqk9X8zG/ECsOY/gTdL/WGMaF4FQu9GZN4RAQdRTQ1OV7
 lgWO6O0zm9yq0+UwQkvARkkAuSbwuDhwA3RF18tZcz0gdt5OxQGJGkWjpvAI7FCb0WoqcwTw9i8
 9HjLw7QpCrAFE8g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20886-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2D6241342D
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
index 7d2afe7dcc3e..22c9a1e7d8fd 100644
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
2.53.0


