Return-Path: <linux-nfs+bounces-21830-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIs1F9+zEGrRcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21830-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:51:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6BF5B9ACC
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BC7E301A70F
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B662A37F753;
	Fri, 22 May 2026 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QveQukr6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757BF385D84;
	Fri, 22 May 2026 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478985; cv=none; b=m98aZ43G0kyywGR/t6fmfDC+x0XoUCwI5wrjGSf4kmgeWG9dlXBGa8fzCDnhfNP28nssqYUZjoCZYskhRFaqNdAIHgf+3Lg4iK15XFjFMN67BkGi3FnnfLMqwryFmyHqVhNZhfWvHmxL88kx2u8It741gytHIZqYRu1r9aD36m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478985; c=relaxed/simple;
	bh=JWk/qJly9oa5aSU4/ANb1Pj0gnrjFN99OCHUHA/X9VU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iITJfO8tkb5JZ/l+W3fLUOOuQBgjdDkUi2zXBEgJa38/8smnE0V6zwRw1IJO4iOfR7Vlq7uPx5I8hV6SXE8wzlzymZzI2IG+KnKtgSbfLCg7lJc/RmhsUXeE1oChHWR8anUHzXQemHR3A4NqvvButvutx6onVTHcbi0c3djkBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QveQukr6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734521F00A3F;
	Fri, 22 May 2026 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478979;
	bh=MK6ljeFsXZ3jOZigE4+tZvoHGJwTrFzkGpt7U+sHsGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QveQukr6082kVrlNgl9kJKz//MxUWwGV5SlhrTCRP7A/Wb3tnorS4lscSFyBYx0MX
	 urw7ZOWfhQo0RD84YEtVLcB7xUw6YDpZVTG+MiLjuS99YPMultuIimKvqizKguUIAO
	 1vewX/qA8CkxKP0Z0Ef4xbFEVOWSPAyINBlzvPsm8Y3/Jb1fFgx5YW/2Nz6psuPM95
	 L9dkX8a1PwwbSS+xR8jYLZex6RYvVqR/+U2qEolv8PX8XptgXjJ8fUaIUHv/7PTVsf
	 wa8dUl5IEP5UZz23cL9Ul6r6cgjdEVUw7PCvZuAV6s7m0/0yaZr0ev8ZZSt6gTZB1D
	 kIZf0Ji7zN6cA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 15:42:20 -0400
Subject: [PATCH v5 15/21] nfsd: send basic file attributes in CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v5-15-542cddfad576@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JWk/qJly9oa5aSU4/ANb1Pj0gnrjFN99OCHUHA/X9VU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqELGhd7m8pA5apBNOYZq8RdPE8niFKXspMO0sO
 9ive802MQmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCxoQAKCRAADmhBGVaC
 FQoGEACbe4pqKKHeYRjhNWVqNClI0adVAm9B5FhedGGdfepFOG8qoiwDwcRBpdjZ0n5U3BmqRSC
 fFDNsSn6HDQ6I2FyhtPw6XWdUO9dR2XcZF0NDU8UgZF5FjMVjXaMj5FWvZaIDyfoIapfzY7ypwb
 iSZLQrKKwnv80EktPZkHLmWTjW3yCTJvi9/NVNcr0EdUaYcIIxMsNxm6jbxAU8JJPGBD37RFtiB
 hco4Na4TWfHvwcgvJR6VjEiIagtvPtCa/LUIbT2+qJXTDEGFWDUhfnuBgxoM786NN2LFUkSvTwz
 kvuD3fEV7FDvZovB5+NRqnbgozgMHh/l19anhHXYJYMDhLOQLIfI2jHLryr+dBgow9dMpSUzI+p
 iI+hi/5LJurOxzuX2+HPcP8OmdDWyTvfNg7b8AsPC1Z47FA8rh+Kd5iIWgxAP/ysXxkZ8vHEL/u
 gsnbgsSyCT4qFrWZgxM0OMqwY1eqxaKzNKE4A0AfpSkkJXKNkbAUD+veUQZbH4vn047jEwmODXc
 diegWqpc1guLpP6krVmatj1TfdIVVFDjI8tGHORiujPwdMNNHSwTNGJ5An1Ch2YOYHtfEpyznqM
 f9S6OH2T5AayLxE5jiLgknjDO3W4yxWraZeuZ1FWmZWDpsVi3sR6Ix0DcyfHCqHC7Js0bVL+6sE
 tmOlpMLoFgDVYdQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21830-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BB6BF5B9ACC
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


