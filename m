Return-Path: <linux-nfs+bounces-21799-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLH1BsZOEGpnWAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21799-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:40:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0425B446E
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E609307786A
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864F43A9854;
	Fri, 22 May 2026 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5ixIoJQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3872A3A83A8;
	Fri, 22 May 2026 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452981; cv=none; b=ZVIQGNOR2wGftpvIRDpxOG8eeW+yPHIu9SEErlQdhpUHzDt+P/MHEuGy200HbYr7BbgcQqtTMNlnvisBvcBBXrYa/hWL46d/GflxzQfkJoyZBJaHYz3g1QsxOpNr3rIrAGz/Wsza8QUQw5qPK378n2JHXYw7YvdDxofSaSzwN0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452981; c=relaxed/simple;
	bh=Y50oSV6B/JehwRBE6ozp3wxwE6QnIRaFrxKuDBSJhao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WZk2PoE8BkqTLJp+m5UkCyumq77dJQDT/+sdm31s6VeRd3lRX1h0WBKz3rD9ZKuLNcsqMT2yoqlv8Y56PzhC3oVfiW5Hyq+XOIX4Ty7N8STl7cWKhOAkDk5ZZBHEe5YacGUSMi0CPXnQhH/pX1vx3GlO4C2ju49rMM/W807psdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5ixIoJQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BDB1F00A3E;
	Fri, 22 May 2026 12:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452980;
	bh=SNn+vri9RRR9gMRxnX7erNj8H9djqSG4aGq8GD9k76c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A5ixIoJQN3QU4DFZD1i73Hbe+o/1jaIvTkqvcNe+TDRe4Cne4pZvB2mhcYpbv77ps
	 yv5fya7qwB+P6gFGxPYtGO12+0S3fFO4Q3WoDBkTapwfYrXj3TWFodnB5g298Q6bJK
	 q7zWm5qW/lINaOLaCUr5kKAEOmkyioeZAQOzYP3bzFt54eDILiQA2Iyk+GwUjgPogS
	 GRry78RhC4x179ReqDPOzwXPRVoPJNy3taUqEyjRT7kxULHjfnWlWKgfyfYime22BB
	 LG3cFY2WWNvfFA3Y+LI+8ns803N6etv0sCPWieXDPjXhKkAwobAHM2buQxTxwJD316
	 LK4U2dtbAC5Zw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:29:07 -0400
Subject: [PATCH v4 18/21] nfsd: add the filehandle to returned attributes
 in CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-18-2acb883ac6bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2618; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Y50oSV6B/JehwRBE6ozp3wxwE6QnIRaFrxKuDBSJhao=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwSNRCRzGHOr9nAg+FtjPukeM5GHrjVMLn0R
 VImJM9a1ZqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMEgAKCRAADmhBGVaC
 FY++D/43gLaw9+PHGjAZuS5NJOHtmkYGIgeYVoKpWALgVNpcrT0Pg31VrILLAeubWO3NmwmiraK
 +F580ki7Z1y4Q/NUmTK5Sr0aWvLRBdLbTpoCgGwiC9RqgGqibGDl1CF9Bp8bkEUB8awzbspIUeQ
 PCs/wLq3XtoaK/zPSJwlDvMaYRv1E1JWHUMXwHaXJsFdKOo9PkWnadPbZGyqIZs+sD8GwRrzyNm
 sbTVze2qgi3t7uzFObETRzHQfPJQA3Ew6s5RR+6WwczpI6CbhhBZs7CgCUyvW4uiIwgfxrT6qsY
 OhkOgWgJ7b0+H7eZOiCMEujQwoRjaEJcftOPgp6cmk3sD90Ccw3rrpaWFYhpcWa/iNn0JkXWQ/1
 q7ysEYbAFhY2/DQwKZ6OLDoT58UUP5/G37rO2BAsb8lu49r/a+Vehuz3SjKAqNnPtadTSxje7Ia
 U2wsatzix/gPD79NO+lfBtB3rjT478+g9Ii5YKH9nB484KNfLxkPjMtoaoGjxmza0Xsvsvr6z5K
 ZK3OierbVewLFnMaOAnZ46YuTLBWs0WVkVxP6kK11CZJpK5jZf85MlbbcAR9cfVXc758EZlDM8q
 g+6K+ZXU30BquALpm5CHIceWGJmHyMhCutehLeqv6tE6eDoew944DVHKv8SS8Saqo7Su4d8mOiZ
 oqT2UoujiD8M2gg==
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
	TAGGED_FROM(0.00)[bounces-21799-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BA0425B446E
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
index 33b6cd492e56..f8534288b2fc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4184,6 +4184,39 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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
@@ -4193,6 +4226,7 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 			  struct dentry *dentry, struct nfs4_delegation *dp,
 			  struct nfsd_file *nf, char *name, u32 namelen)
 {
+	struct nfs4_file *fi = dp->dl_stid.sc_file;
 	struct path path =  { .mnt = nf->nf_file->f_path.mnt,
 			      .dentry = dentry };
 	struct nfsd4_fattr_args args = { };
@@ -4231,6 +4265,9 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 		      FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY;
 	attrmask[2] = 0;
 
+	if (setup_notify_fhandle(dentry, fi, nf, &args))
+		attrmask[0] |= FATTR4_WORD0_FILEHANDLE;
+
 	if (args.stat.result_mask & STATX_BTIME)
 		attrmask[1] |= FATTR4_WORD1_TIME_CREATE;
 

-- 
2.54.0


