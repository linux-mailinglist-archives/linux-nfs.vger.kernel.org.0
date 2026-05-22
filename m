Return-Path: <linux-nfs+bounces-21796-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABgxDHZQEGq5VwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21796-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:47:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DFF5B4691
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D45630944D4
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1743A719C;
	Fri, 22 May 2026 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eblgCfZZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1FD3A6B94;
	Fri, 22 May 2026 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452976; cv=none; b=MNzM6S50DudP2ZH7KDayDe7OyMVFFAhP6WwcqaocGEuTmotolE7iVWwe0EfNgM0aYCnxW8zZMK0tju/bnEkmR1BdLKx4OZdU/0bpRVRggE9+egSSTNmPk4w1P2kHXlMf52yOC+Zq9cG9znHNzoccHBAWiya7cR16u5zkpJz8qzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452976; c=relaxed/simple;
	bh=JWk/qJly9oa5aSU4/ANb1Pj0gnrjFN99OCHUHA/X9VU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AU/zAg+2Wa7Y9LwL8Kp8kSnFHJA0S6O6JMmsNV0/4Y8EQx24o3t8vuSyYQwH5aaupFQ1Lt2qVDMnaq+AxXdO6lwav8WHYRpTgsj3kYczxxlnJRlAl8OSdT98Puc7gmZlrAvUDgcYYjlQlID9kt7Rk2OGY7qfW7+N2Dslfu6VrDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eblgCfZZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E52D1F00A3E;
	Fri, 22 May 2026 12:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452975;
	bh=MK6ljeFsXZ3jOZigE4+tZvoHGJwTrFzkGpt7U+sHsGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eblgCfZZ/ebBoWp6USPj+LYCKW363/DXns/TNW61OvUep096rkzWCpoqoBPCdBvyp
	 2DdE1pP0dVK3vtcY8x3VfQdwGSyviqEgG3nPIzjTA/PxZyxwIrynkXsb9Uc010tat2
	 syMqy1kKvgYzZ7SSRKovxDHdJ5DP8mCrdZ0Bi3VV0kr1PoWPJqR9xSJinl7DPOqIS1
	 dCbpnhsKbK8lIwTCcBm3128lqSwpfakw4ABqjA7DjLQ2Nw/jZ8izf13f49RiB4XpIm
	 Q2bicBBfyQt74CHRUeN6Y5hDTjoA9FyhmoRrMb31xTXuCV3kmOToudp9WmbicD0vbm
	 BO569AXYZli9A==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:29:04 -0400
Subject: [PATCH v4 15/21] nfsd: send basic file attributes in CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-15-2acb883ac6bc@kernel.org>
References: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
In-Reply-To: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JWk/qJly9oa5aSU4/ANb1Pj0gnrjFN99OCHUHA/X9VU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwRiJW3cB99VH2cQKa0gszLGXbJxQSliMcgH
 JwIZQbAFqaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMEQAKCRAADmhBGVaC
 FcEREAC9sL7KvM/yk8Z0d6fas28a2AtGDJycpV/Kxv2oTtW3NtGZZo5FhXABbt4FqTA2zy1PxRZ
 7mw1XOWjXZ5OpriXuMX7t3LPpRy24iLoisgSXD4MkP1aNk4Ie3cDS4OAs8Dr58Avdn8oC3cwuFn
 ne56EIxCOA/Gnkzf0YSrTPjvZqvg/+gfdn9gbb3Q7QTXxEuwANqXG8Zcc0tjCiIfJN1JrpVc127
 UgtIeCZVNXm10QtvZLpox9uQAvNpeWK5vcIV4IBvMc9XpTBWXPrsxw0bEGNVpMhNoOt7RT+rL5O
 8of37tKB1CSCrcw0EQPXeop4UywYT8Wy19LHDdVeCEfsqlWALv5DjiEIMVA2ySMVSi5GGqad4gG
 R7XMiWnGiPtbsaOzJhLbAN7cv+gr6nE56qBEaKWMhxdaSbuQNPWXiAasvvA7ks83AdHR606kpBs
 YmKFpBWhZseR3WMGhzFfz8i4ppvzvwot8FKNVuV6EImkzBE7TESMU3NgqCjDGuH1HBNvx0ovMfj
 NY91gURQzf4QkYik72i2jFz7xURUPoP0Z0FjDTnGlGEwfltpOe3vswZGkLHIo7WpNaYS0QT6xCY
 uqzcb1jnshCpstaoxwV/jCP1iAZd2jQ5bg8pU7tibMI+plqeMHVRBGXzeRKgHSlw3ozHAD+afEm
 vQZXCj4Dba4Z8xQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21796-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 68DFF5B4691
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
index 1fc4ce2357c0..61c555446f63 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4178,12 +4178,21 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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
@@ -4194,6 +4203,41 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
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
2.54.0


