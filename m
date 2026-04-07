Return-Path: <linux-nfs+bounces-20705-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBu8IT4H1WnMzgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20705-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:31:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB00B3AF2AC
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C9130CD486
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BF13BF671;
	Tue,  7 Apr 2026 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1OIgklK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04D3BF664;
	Tue,  7 Apr 2026 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568184; cv=none; b=RnaUyWBry+DZyC2Ie5R22r8uUWu6Z7LKXdQst4GpqFr6i93uu0yvN9eRIGOPSTXlEgb9Tdh0LsKYAEzz/ys5k99pK9W12TOBIDTucfe+J3MwrEOCptMF3X5GDAf/ns1hnHYF2xmXFBxxM2JncyuCfHJbTmdeKXEwgvyAA5XSS5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568184; c=relaxed/simple;
	bh=j3wX8gQVlfaixCiAFgl9DGooV7QaUz5OrbnHAIp6G6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ija2t4HpnlPlmSMgA3n1J3OUje6kbC7Q7FwduGxU1l7zad7j8CVojB2mAjUkhSsWIuJ4sKoRTutzKzLdsfdHiLI+kz/ExKLUHCpoCFu4MuNKkaq8px5j3HeGJgFkp54umvHbp2hWphUseziUgHY3DRb6RSEbWS+r2Gbb7MksHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1OIgklK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D908BC19424;
	Tue,  7 Apr 2026 13:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568183;
	bh=j3wX8gQVlfaixCiAFgl9DGooV7QaUz5OrbnHAIp6G6U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D1OIgklKAvq2Y+hO8PViXMnm2w2ec1IAQKrWfx5C6dfYruxh4f4UMTAh2I6pJD3Sx
	 PL37h9U8pIOSs4d/8/tJRAOFZGm8kLvzqkakps5b4hjuL0ZE61XxsQKN2UfjkEotVo
	 7q8jrPi4XscX4T/M4NZPKFMDKMkrbcYFElz6rvKvAyaSVcCd69eTTNdbVwCEsH2odZ
	 jmxZTRvCjeWiq8gR0KTYBEBbWXuP5AGeXtbv+rxEsdXuYeRnxsRbvQbX+ys8t+u7JP
	 fIqn5RZXgrBrRN01eFPjoeE1PVzMOlPJgGa95rwEu+Mc2IYRg9BqLpxCSZrr0U/7Vc
	 b3+gcesjUTMKA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:31 -0400
Subject: [PATCH 18/24] nfsd: send basic file attributes in CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-18-aaf68c478abd@kernel.org>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
In-Reply-To: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=j3wX8gQVlfaixCiAFgl9DGooV7QaUz5OrbnHAIp6G6U=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUJ1mbRF1hs5NtRa30vG3RBHyATuGdwZzbpq
 qTrcoRZm6qJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFCQAKCRAADmhBGVaC
 FSRFEADRIftXFX3DjXgwVMEBaLL3Mc6P+9JYI2Muqc6JYl4vvuHK3pHD2OsGWyvZS+KIi4Bb5Po
 M4TQsvLcbvudQTcNksptJlr+fF4QFu/+AGaJqSPJHGFvTybMBUQtv0jF3S+Bc4uETcRUMMiZtV6
 IblaLw0zuJnOfmA3SLTlEAhxSmVSsMbBxjeyUm57BTx1pDV/U6xH1/XP4jraCPF19sIhT2jALTo
 Fc2GCZlvLfyJn06+qLcy2IjkWp8prFx+8Q9jE1z1DYhxZ3rhCCLt3RIKIqCv+7XGoaCCyCqppr4
 DDbogQOj32+FQMkFRs1UMoq2U5vzqa2B+o+A1yywslZB6iAWeJbpVUyOpb8DmtHBnlwuKI2+2zq
 bRxlabF4o2L37K8iN9QHHQapNNojrVZ+YI7kg9rXpZEMdeORmU3pLthF2f+5lzG6T2KXL/ooej6
 ggAiC8zHiin1yy3gMCCjTo1fDuZTNljqTxjqH0uXOc8UDvVS6rScv7yAr4MB7Xms3qn64n7RMIA
 GEsA/H4/PWFT3aMI2Jo8uFy/zpcjszrenv0HfZABDevbw/X2aqDQhTn1kqHzi3uS0S0mL/5zQ9T
 SNxygjFd5xXlEDtDtlQgsXOgmgCfdrBgNGWKDXcfa2F0RcVshpwpJHiACFyx1NujwEXWdboZa24
 tsief2qJ1iwQGGg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20705-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
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
X-Rspamd-Queue-Id: DB00B3AF2AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In addition to the filename, send attributes about the inode in a
CB_NOTIFY event. This patch just adds a the basic inode information that
can be acquired via GETATTR.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 49ca24851707..0cdce460f9c8 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4104,12 +4104,21 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	goto out;
 }
 
+#define CB_NOTIFY_STATX_REQUEST_MASK (STATX_BASIC_STATS   | \
+				      STATX_BTIME	  | \
+				      STATX_CHANGE_COOKIE)
+
 static bool
 nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 			  struct dentry *dentry, struct nfs4_delegation *dp,
 			  struct nfsd_file *nf, char *name, u32 namelen)
 {
+	struct path path =  { .mnt = nf->nf_file->f_path.mnt,
+			      .dentry = dentry };
+	struct nfsd4_fattr_args args = { };
 	uint32_t *attrmask;
+	__be32 status;
+	int ret;
 
 	/* Reserve space for attrmask */
 	attrmask = xdr_reserve_space(xdr, 3 * sizeof(uint32_t));
@@ -4120,6 +4129,41 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 	ne->ne_file.len = namelen;
 	ne->ne_attrs.attrmask.element = attrmask;
 
+	/* FIXME: d_find_alias for inode ? */
+	if (!path.dentry || !d_inode(path.dentry))
+		goto noattrs;
+
+	/*
+	 * It is possible that the client was granted a delegation when a file
+	 * was created. Note that we don't issue a CB_GETATTR here since stale
+	 * attributes are presumably ok.
+	 */
+	ret = vfs_getattr(&path, &args.stat, CB_NOTIFY_STATX_REQUEST_MASK, AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		goto noattrs;
+
+	args.change_attr = nfsd4_change_attribute(&args.stat);
+
+	attrmask[0] = FATTR4_WORD0_TYPE | FATTR4_WORD0_CHANGE |
+		      FATTR4_WORD0_SIZE | FATTR4_WORD0_FILEID;
+	attrmask[1] = FATTR4_WORD1_MODE | FATTR4_WORD1_NUMLINKS | FATTR4_WORD1_RAWDEV |
+		      FATTR4_WORD1_SPACE_USED | FATTR4_WORD1_TIME_ACCESS |
+		      FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY;
+	attrmask[2] = 0;
+
+	if (args.stat.result_mask & STATX_BTIME)
+		attrmask[1] |= FATTR4_WORD1_TIME_CREATE;
+
+	ne->ne_attrs.attrmask.count = 2;
+	ne->ne_attrs.attr_vals.data = (u8 *)xdr->p;
+
+	status = nfsd4_encode_attr_vals(xdr, attrmask, &args);
+	if (status != nfs_ok)
+		goto noattrs;
+
+	ne->ne_attrs.attr_vals.len = (u8 *)xdr->p - ne->ne_attrs.attr_vals.data;
+	return true;
+noattrs:
 	attrmask[0] = 0;
 	attrmask[1] = 0;
 	attrmask[2] = 0;

-- 
2.53.0


