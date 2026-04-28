Return-Path: <linux-nfs+bounces-21237-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKPHOtNf8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21237-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:20:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E1747EB27
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 972753105513
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C243BFE50;
	Tue, 28 Apr 2026 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDZoE0p6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD483AC0F8;
	Tue, 28 Apr 2026 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360339; cv=none; b=Vxc8rpFmnSPMZzJSIuW6mkU8+WDKEXbh2q7qCd+7hTrvAZjQXqegwrwKKlaqc2wK4y71Nfa3EJnYKjaTZRFNA1HetfOESo4U0zvc87DwulhoARw1ZvRG6zrbZYf/khahNDOuU9WTMdhlRwarU38NjT1y9kMzV1o+0dtpX9WaMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360339; c=relaxed/simple;
	bh=Jm3k7OpyC+6NC37VcuzrDFowtqEqqGHoYyna1syh+u0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mg/GidiIYtZvSAmwppfX8FvqNP8QVh5EIRz8OZW1rLIBhZ/gGGS48i5Yilcq8aYhoLjNAKFjvM0W1KAo7P2JSB4JPXFlVwy87mBGvRok6bb5ZsGj37N02acBD7ApCIe4hjgIS9voOshCSFFguHu0Qs14qsbQqVoLAPY8k0rSiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDZoE0p6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCB1C4AF0E;
	Tue, 28 Apr 2026 07:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360339;
	bh=Jm3k7OpyC+6NC37VcuzrDFowtqEqqGHoYyna1syh+u0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EDZoE0p6FUkL4gJTiJYzC+Q3IvzDnguNIp6pwJN67wa5c+qJ29O6363kXcjKZ8JEu
	 LrkStlRhJpMnYDER2KGNiZz0kkGkRFYJbSdL1pmPJN/3vWCpLB522Eoy4JzjSUqf7A
	 kJnk0YKJaEoMSvpGqvYP4C68uvopjv35njmob9WEsmRIsSgVbCKYbV3PXpsgAVRkKR
	 vHkHAEjS45qoRQaEKNaKRgJUUVWMSlG/dsNaIwPNJb77CB3AU2a0zuU3Bm3mdvZkxI
	 7tlKmfQAo/HyqOLQoroVOUd4eV9wXXmS062KEqqOrz67yWuZ2K/CiBad2ieBOw1vVS
	 3ZbLEdelfPBEQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:10:09 +0100
Subject: [PATCH v3 25/28] nfsd: add the filehandle to returned attributes
 in CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-25-5a0780ba9def@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2618; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Jm3k7OpyC+6NC37VcuzrDFowtqEqqGHoYyna1syh+u0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1UcLQOPqSSoUJIS9PK1MHYBNxfqH2xRHC0s
 LgJq3wzFYWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdVAAKCRAADmhBGVaC
 FdauD/4/BFq2cEBOn8Hnskmtz+fpIR7Vwbt1qHn+7H6nDxGV9/bQE0FD3q9VDb3wxVilFKIf4ES
 k7hN+V8hKoufE9R4VjIDaM3wdWkDKSdHhsBi5sSmvKlWDUSSr5WKjkPSbEKAT/QzGh0Wp/v2nd6
 LqFvvSStfhh7M/WYbhNS0oOSmr0tQmV4xcjhy8uqrSrq3xasms14ewX7jGPlAkLWfCV6JtSINq8
 1GzAfdQuwiGrAbLGLtYgSi0PwGv3aoyIysH2cHxny+NYwIpIyqAiGaV5+GtVuE4Y/n1uef2UGNb
 ARwea12vsp0hQJ3UHsAVSi6dKXHB9+vxyNQ2CLkh8wGAJQPfdaWkA54ZE6PohHjS5xyiuv8iCIA
 8lGzWLp5/Ju1zbV9DBicwVZ598uu3Gx9EX+lk7ksUeRDR6dcXvMdPEE0dffo5izakM6LW+cnXQv
 sVDfQ6R1E0QN3+CbR0tj3q9zd0wIHwxe/YoIAriNfxcdb99irt3iF3DzAuS+KDsQ0Q2oLYSZj+d
 kMLwnCqbS+INTE+VSQ2c9689OUfFZtBrBmAyxtUwNvjZ317kxa8Mt5TxAn7ymwgsS8BqpXwRBOr
 wb6ZMIrpbuzedyDpGLRz9Q543JOGPHYw6mdyA1P2HqQv+CK+j7Ja63tTFXQLhB1DvV83wsodXHq
 ZUn4pslLC0oq9VQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: B1E1747EB27
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
	TAGGED_FROM(0.00)[bounces-21237-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
index a9cdf7a3f8b3..5d7d8545c904 100644
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
2.54.0


