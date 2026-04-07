Return-Path: <linux-nfs+bounces-20708-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qALhLekH1WnMzgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20708-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:34:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 199C33AF38C
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9CC43081330
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588923C1403;
	Tue,  7 Apr 2026 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQCn8Sri"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1C3B9DBC;
	Tue,  7 Apr 2026 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568191; cv=none; b=XOtexA45rOXsuQ3S5SkcNdV/+TaWI8VB8vj0gTnjg6Jb3dguP0NQLtlkSW5evY5cWCKETwec0XfhV5R0d3AWn7fhnCVHsaXr9KXiY5Vbt2D3GSlNwlhvA7CT17tkXe27/Ms0TVB6oxP9V5TLMYjiW5f1mn8eOf/hXx/K6SUXE1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568191; c=relaxed/simple;
	bh=69Who8r5Sb8ThckXkfsHphQ4S1KXUACGaFrCg+dMFxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhFtJyqLei1whGLAE1ulc2amc9sKQZBrBjipXTANQ+KmT2wsDSfw3kARM9HKVK8nspQMkhQEnSizD4FW+F/FCcIJt39QPyabsJg1Tgfjzd/NiNKJPk4gn158kQwI2AJWLJ6NpmMugm5KCPopMgWcrXsNWvOirWsdMKOGK8oEEGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQCn8Sri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C458BC2BCB0;
	Tue,  7 Apr 2026 13:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568190;
	bh=69Who8r5Sb8ThckXkfsHphQ4S1KXUACGaFrCg+dMFxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pQCn8SriFyUaCC55mz/T9SHS8N8HSBwTYXdETLJTHvXmWFZSEBiUBNaS8cQay6YAi
	 nBCy1S0vBW4IIdX8VqLRJQca2lXU9VKyOLaCEe9giulQ4+Pxw7amHUVV3nNYbI8Vy7
	 2J7tJS9dWxb2TsK4IbR/NyXKFDuOqNTxibHJqorkC6Z4d4jDOgD/JkK+/Qg+TWELiv
	 J9V+1jjYhZebp/rIUTsxSbeSLjhXV/0+SQHPmDhxIvjyrC+BCKF9ustFirZlD97Nxe
	 GIIutwB+GNzT8AhPupmLGDQzkQZLbUmJJRdX0Bh2pRvO3hFq82BH6smYppkTWV3Sq+
	 buzclgy3cSFzg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:34 -0400
Subject: [PATCH 21/24] nfsd: add the filehandle to returned attributes in
 CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-21-aaf68c478abd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2618; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=69Who8r5Sb8ThckXkfsHphQ4S1KXUACGaFrCg+dMFxY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUKO/c2Fj+9LQlaR9SOd8t4Jad4jMfKnIzeZ
 yvlBkjx2QKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFCgAKCRAADmhBGVaC
 FVJREACrBV8KbB6vVL2Pfa3c+TGp+SLR+yfe6S+72xf0mRBc5DwE3SYRDVs1yB8OC5YlIWUiAOV
 kGeHjkMhOPEzFtgt13ZqZDsTn75zlr41bXyVWuH4ZwrTkT/GFqh33IVIDv8gjOmB7aKEe2SPpRz
 AnAGAMR0IAF9PAxT2fFhQ3rpmXUD7QgPUN5dmNdHSMBKKW5UHAtfTTOEPmKTnkJgvpvqu1TUmuw
 APkbtns7NurbZ6xhxwgLTZXsqvmLbSc5cuGRrCn2gal1fDLt6fz95celDWKhTIRqceaU/+TMSDH
 TEHtS0tivkfNit33c6HrLv/zZNmzRyRaVVf5i2UQ6TF3E9pD9CyyykpC/Ox/446kdgPAkvmEY9g
 zfD3MzmSFIv6ff6kbGvnla8qJTfUs5aKOBBd3TyZkTp2EK2BtpLa37uXblFJ6kHi4YevXmduLep
 L9vjarB7rU1ynoIRUOiUm9TGTV1QSjaGghB7n2eS9iRJ0pUptHIw7iGT4T0yUJ4euGv4BLTkSGm
 NHRH7UsZ+k7V/3lj9vJgstUvci2C/p7wHU5h29MpH2RRi6/YSqetcJDSlg2tFfqBif/frMTCAny
 Xn6TAetDMqell2Xp944sCabRvEtWMCRRwQsYZco2PnYFjZJvwNCSY53f2rvYThE99/flkQF4Fnq
 qECfEqGy1yA7KIQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20708-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 199C33AF38C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd's usual fh_compose routine requires a svc_export and fills out a
svc_fh. In the context of a CB_NOTIFY there is no such export to
consult.

Add a new routine that composes a filehandle with only a parent
filehandle and nfs4_file. Use that to fill out the fhandle field in the
nfsd4_fattr_args.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index faf0c3d35dee..e468cbc087ad 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4109,6 +4109,39 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	goto out;
 }
 
+static bool
+setup_notify_fhandle(struct dentry *dentry, struct nfs4_file *fi,
+		     struct nfsd_file *nf, struct nfsd4_fattr_args *args)
+{
+	int fileid_type, fsid_len, maxsize, flags = 0;
+	struct knfsd_fh *fhp = &args->fhandle;
+	struct inode *inode = d_inode(dentry);
+	struct inode *parent = NULL;
+	struct fid *fid;
+
+	fsid_len = key_len(fi->fi_fhandle.fh_fsid_type);
+	fhp->fh_size = 4 + fsid_len;
+
+	/* Copy first 4 bytes + fsid */
+	memcpy(&fhp->fh_raw, &fi->fi_fhandle.fh_raw, fhp->fh_size);
+
+	fid = (struct fid *)(fh_fsid(fhp) + fsid_len/4);
+	maxsize = (NFS4_FHSIZE - fhp->fh_size)/4;
+
+	if (fi->fi_connectable && !S_ISDIR(inode->i_mode)) {
+		parent = d_inode(nf->nf_file->f_path.dentry);
+		flags = EXPORT_FH_CONNECTABLE;
+	}
+
+	fileid_type = exportfs_encode_inode_fh(inode, fid, &maxsize, parent, flags);
+	if (fileid_type < 0)
+		return false;
+
+	fhp->fh_fileid_type = fileid_type;
+	fhp->fh_size += maxsize * 4;
+	return true;
+}
+
 #define CB_NOTIFY_STATX_REQUEST_MASK (STATX_BASIC_STATS   | \
 				      STATX_BTIME	  | \
 				      STATX_CHANGE_COOKIE)
@@ -4118,6 +4151,7 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 			  struct dentry *dentry, struct nfs4_delegation *dp,
 			  struct nfsd_file *nf, char *name, u32 namelen)
 {
+	struct nfs4_file *fi = dp->dl_stid.sc_file;
 	struct path path =  { .mnt = nf->nf_file->f_path.mnt,
 			      .dentry = dentry };
 	struct nfsd4_fattr_args args = { };
@@ -4156,6 +4190,9 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 		      FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY;
 	attrmask[2] = 0;
 
+	if (setup_notify_fhandle(dentry, fi, nf, &args))
+		attrmask[0] |= FATTR4_WORD0_FILEHANDLE;
+
 	if (args.stat.result_mask & STATX_BTIME)
 		attrmask[1] |= FATTR4_WORD1_TIME_CREATE;
 

-- 
2.53.0


