Return-Path: <linux-nfs+bounces-21834-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3AaGJsKyEGrRcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21834-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:47:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B275B9993
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66E0F305694A
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C52138B7A1;
	Fri, 22 May 2026 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IShTygvS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA0B3806A7;
	Fri, 22 May 2026 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478992; cv=none; b=chXcgfRPnHPIOB2VJ1Xl6+eUL1u8dHXL8QjXjmOTsXqnkytnUmkNtOHePHUb52Hg0xbWa8qntd7dlr8HsMpb92AbMnx8/QJ1s9cavrU1ifExSAHr9nq/2MLJ6YmHG5Y1xhnI2fyZELF5WaNRko4fBP23qGvSOWSPJ4NzLxFBmE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478992; c=relaxed/simple;
	bh=k0EtO5J541KFdHLWERfs+iU6uk2lKGkM05ic+nH1Mbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HmSoJ8/U/dOXfbApNntUPJel39/MMxbEql+eJgPYuZXMNP3wWamMro+lKLr2A8RooB3NQYC61AVSPWeHql4D5YlWnzm+gRK1Mr33QaQ2VcYV6v9kZmQHH1vWttuxKTnbk6ohQHrzQJqpd12+ixB5EBz1NLcUrSLpZJ8WceoOkX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IShTygvS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A581F000E9;
	Fri, 22 May 2026 19:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478986;
	bh=r3WM/Rdns4JIssJHNi4RJwCbBYDGOlePNgzlUCVXveo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IShTygvSD+iAtelMs153sfTBe6XXA6QSA5FdRvp/KLFck9Um9ilSZtBsqitqXOY0c
	 qRAus16vLLrEd2nTKdtXTShXNhX3THJrgsziJb6WzHwRQjrXAu2n7o38OCqTpaz9i8
	 7wZm/sYcR43Ums3nKwlk7+VrzVYqDKL/fPA7lXFKVWfclBCfyOohzOght2DBR8+jzm
	 tVC8izhDlh0kCio/1isEt0pTG2NJpSTKs8Dks5WBZdJmDFwaTSgiFyxiDUVbz2kTxi
	 mHnYWlxsxQaC71ZPfGYkGJdfb63kXzf/S3SvcAkVNax20BkuQknpxAE0R4/3YKVWE8
	 WWj6RF+3SXcZA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 15:42:24 -0400
Subject: [PATCH v5 19/21] nfsd: properly track requested child attributes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v5-19-542cddfad576@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3821; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=k0EtO5J541KFdHLWERfs+iU6uk2lKGkM05ic+nH1Mbc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqELGjWI/vpG1tp4TpPxewLW5DaO2gshFL+An0T
 3xzmDljecOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCxowAKCRAADmhBGVaC
 FUBoD/90XvP70zECGDaA9LYaUePYXo36GbkrvxUCyhunMN93wKzB82ZY3T/OiwsPD4xxayV4LKa
 oSklYCAWJ0Yk2WILu4otvgddwxaSsgxP0HoYOQAzm0rwnufKb3P0m4wlofQxGpgHWumX8/KdNY8
 Qh2LPkhGWCOhG7v1pWDkeCGiQ2tbcUbblNeGOOgcozRDWRsvn1ahxKtv3fZZG5n1EDYmtdtkaCX
 IE/GZvHUMMlU5zJQmmeO/oix9GXykZYsUcYhj+Hz4uvACuKiXsb3VRrek9fITYS9SVwuhdlCSRH
 lAMwVnNcO+JKhEea0NFpsyGn+65L6hk8M9zcC5XkjesD7lP6+BdlqLYtx7o5/DQoCqX0x34UmaD
 iM1glSx/BevK8iEwJQKVS1/zhsAvwCp932DoVS8mc06JZmjvKLyOOW5hIjS0U1wm+MLcWIsFV3g
 VYALuqjvb6T9iuKEi9IOHwgiFkQ/Lgf9Rv9pM9afwpuKdsphj0saWnWxqA3soqK6oNypCNeci4C
 HtN1vd1ld4Y9NiMGP4/XuDni1+W25QNx7KkzG5FjcKzrd/CpxwNU+N6HrbhaZVfzdSHzSIQVlkk
 6WijB0d/dZvz7Ze2Mmy8wU5WCDpT6cDYnLWqbZsNtrei8R5Z3O4fWvhKKSIIU0DC9xukt9z0fn4
 hlw2CVEdVPz1dIg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21834-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 46B275B9993
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Track the union of requested and supported child attributes in the
delegation, and only encode the attributes in that union when sending
add/remove/rename updates.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  2 ++
 fs/nfsd/nfs4state.c | 18 ++++++++++++++++++
 fs/nfsd/nfs4xdr.c   | 15 ++++++---------
 fs/nfsd/state.h     |  3 +++
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 30f338f90acd..1eed8f23551d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2568,6 +2568,8 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 
 	gdd->gddrnf_status = GDD4_OK;
 	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->gddr_stateid));
+	gdd->gddr_child_attributes[0] = dd->dl_child_attrs[0];
+	gdd->gddr_child_attributes[1] = dd->dl_child_attrs[1];
 	nfs4_put_stid(&dd->dl_stid);
 	return nfs_ok;
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index eed997d1c88f..ce740a94a634 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9820,6 +9820,21 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	return status;
 }
 
+#define GDD_WORD0_CHILD_ATTRS	(FATTR4_WORD0_TYPE |		\
+				 FATTR4_WORD0_CHANGE |		\
+				 FATTR4_WORD0_SIZE |		\
+				 FATTR4_WORD0_FILEID |		\
+				 FATTR4_WORD0_FILEHANDLE)
+
+#define GDD_WORD1_CHILD_ATTRS	(FATTR4_WORD1_MODE |		\
+				 FATTR4_WORD1_NUMLINKS |	\
+				 FATTR4_WORD1_RAWDEV |		\
+				 FATTR4_WORD1_SPACE_USED |	\
+				 FATTR4_WORD1_TIME_ACCESS |	\
+				 FATTR4_WORD1_TIME_METADATA |	\
+				 FATTR4_WORD1_TIME_MODIFY |	\
+				 FATTR4_WORD1_TIME_CREATE)
+
 /**
  * nfsd_get_dir_deleg - attempt to get a directory delegation
  * @cstate: compound state
@@ -9889,6 +9904,9 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 		dp->dl_stid.sc_export =
 			exp_get(cstate->current_fh.fh_export);
 
+	dp->dl_child_attrs[0] = gdd->gdda_child_attributes[0] & GDD_WORD0_CHILD_ATTRS;
+	dp->dl_child_attrs[1] = gdd->gdda_child_attributes[1] & GDD_WORD1_CHILD_ATTRS;
+
 	fl = nfs4_alloc_init_lease(dp, gdd->gddr_notification[0]);
 	if (!fl)
 		goto out_put_stid;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f8534288b2fc..4fe697bf34e7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4258,18 +4258,15 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 
 	args.change_attr = nfsd4_change_attribute(&args.stat);
 
-	attrmask[0] = FATTR4_WORD0_TYPE | FATTR4_WORD0_CHANGE |
-		      FATTR4_WORD0_SIZE | FATTR4_WORD0_FILEID;
-	attrmask[1] = FATTR4_WORD1_MODE | FATTR4_WORD1_NUMLINKS | FATTR4_WORD1_RAWDEV |
-		      FATTR4_WORD1_SPACE_USED | FATTR4_WORD1_TIME_ACCESS |
-		      FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY;
+	attrmask[0] = dp->dl_child_attrs[0];
+	attrmask[1] = dp->dl_child_attrs[1];
 	attrmask[2] = 0;
 
-	if (setup_notify_fhandle(dentry, fi, nf, &args))
-		attrmask[0] |= FATTR4_WORD0_FILEHANDLE;
+	if (!setup_notify_fhandle(dentry, fi, nf, &args))
+		attrmask[0] &= ~FATTR4_WORD0_FILEHANDLE;
 
-	if (args.stat.result_mask & STATX_BTIME)
-		attrmask[1] |= FATTR4_WORD1_TIME_CREATE;
+	if (!(args.stat.result_mask & STATX_BTIME))
+		attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
 
 	ne->ne_attrs.attrmask.count = 2;
 	ne->ne_attrs.attr_vals.data = (u8 *)xdr->p;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 56008234b700..461abcee9e6c 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -284,6 +284,9 @@ struct nfs4_delegation {
 	struct timespec64	dl_atime;
 	struct timespec64	dl_mtime;
 	struct timespec64	dl_ctime;
+
+	/* For dir delegations */
+	uint32_t		dl_child_attrs[2];
 };
 
 static inline bool deleg_is_read(u32 dl_type)

-- 
2.54.0


