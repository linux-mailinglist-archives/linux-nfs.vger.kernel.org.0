Return-Path: <linux-nfs+bounces-21226-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDaMF9xe8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21226-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:16:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D330247E9EC
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 663FD30300D8
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACF33B5837;
	Tue, 28 Apr 2026 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoewHr58"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF7937C0F9;
	Tue, 28 Apr 2026 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360285; cv=none; b=JIWAdghBXozbRt49dsu8nQnXVZgtnOA6/HM9NPAZUvnuJ7UPS/DcJ/zag0nCWGDLIEX84FMl1IFrFwH0kO8W9wyPKiDc8lHjLrMFIv/HcGkRPp2wENtH9bMhBid5lfyJF6WzmfJqJ/0HtaBxx5MM2tmD3YK9LzXKco5Q2FfydCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360285; c=relaxed/simple;
	bh=JuG7V9GbPIeU/cBXF9lHXlK4ypwH1KxMIHluIcLHRy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hDUwo69pmppV7PKJbtdr8se+z/E6FZC3NtzyIXs0VXzhSwMizgC6GweIIqtDTnU5lfFP0R6ptKUz4Ju4leeYhbkIqeG1WfkW2LDxOHRNPCnrZzCzz6Fp3OC43oYpxtybvGsDf3Vuj4N4eae+FkdCLXydbi0NHKeelNAexsRUq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoewHr58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5B0C2BCB5;
	Tue, 28 Apr 2026 07:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360285;
	bh=JuG7V9GbPIeU/cBXF9lHXlK4ypwH1KxMIHluIcLHRy0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VoewHr58F6jBW9TvePOujkgeMHhN7BEn9EqL1F8C6vxHwRQTM7wDLBTAb1+OPjG/+
	 eVwAKGKQbEM/myCPcO94ZwkbYUiDI/pHlvRx8yxZBljUOP4dwGzTX+JUv/y69KRrKe
	 Qt0bE361H4hESGPPBVvMiNLKu4EVxiZaQwnJuMBHLeZNhxrlPYmWWhdn5xajbKYuCb
	 A2JI4cdmMBpu5GLYK5y6UtNlSvzhO2wEHPVRC9RDchNSdvo2W9khjwGmzy0y1fxYzF
	 bWWzHOUhEBfilroCNcnMqqXYg2ljeMcn42wflN7fT8LmaGHH/jPbQKInDSjGWlyrpy
	 4yxOaqrS/J5bQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:09:58 +0100
Subject: [PATCH v3 14/28] nfsd: add callback encoding and decoding linkages
 for CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-14-5a0780ba9def@kernel.org>
References: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
In-Reply-To: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
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
 h=from:subject:message-id; bh=JuG7V9GbPIeU/cBXF9lHXlK4ypwH1KxMIHluIcLHRy0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1QeyO98gmMMoZSXAH8ts1PnSzWxrk61RwVN
 BxZPXZSwrWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdUAAKCRAADmhBGVaC
 Fat0EACdSZzKf+AaRG9SBOfesrWPTTAcfuS8fCdJFHXKKWZQdZhCvN8uAhDfyJty/Rz9vjJ0mf2
 iRpqgB2c3G/LXLZ9UKgShqhr1cECj5PGHk7+J16tvenKtjzovmGvQGY40aGSUNfGEIIVxctLJ9c
 /SRKFkJ/Crv1+RIsCl5BA7vzJrxCVcUafLRogBi4dC8UMKoaWGCOxm4PxTb4aTe9rhlgJ4JWz2k
 z5nbnk1sXavEJG6Z7Fq/Se5s7Vw2OKctZBgqT74yooi+QBFv0TU6Prmrvrmgvp3vA+2R9A8+yy8
 aRXt/otRlfEoHey5ARzs1ld919Nl5ywY2yhxJyJaonTZt9lZd6qyNtE+f5t9tgAd/zDvsNNTlWz
 UoC/ymrfviHVgX9riLJe9b5QUpUzPi82ywJ2e/xXT+rpNlo/VvrNcltocr4eIvKFoagkEZcjGry
 htUXCGTvlxhaAuyuwwIeuM/fgIcw7mcZq3Xib688gKT9tDcA9nP7VVGRIzOH79AtD3KKLNAbG3W
 bUO5gRfz02T0JP6D0JmTDxWPPgsqC5AUsCHZZ9W8IoEIDV5IjrE3shNWdoU5NOLYPhLSFLO1z7x
 jlthsEWDRPAQd3QcTlC2az+CMXE3J8xHSgdea9m/vb24/rl/dG/bLeTbaSmuWlnDP6pe+YBRw8K
 UFoKyh4lHsEY9Xg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: D330247E9EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21226-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[]

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
2.54.0


