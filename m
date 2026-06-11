Return-Path: <linux-nfs+bounces-22490-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dl0dBDn2KmpT0AMAu9opvQ
	(envelope-from <linux-nfs+bounces-22490-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:54:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D5C6742F3
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:54:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nLHmydyL;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22490-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22490-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5CC03063277
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4D5481FDC;
	Thu, 11 Jun 2026 17:51:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3BC4DA52C;
	Thu, 11 Jun 2026 17:51:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200265; cv=none; b=Zii67888zMmh5B60ACpDqOBxa9MiJAj76CwilwpjWtTlD1Z28QeuKqR4HHLuqLJE+b0syiuv4/xyio4GZnO09Y79V9ccXrC14b9VdVEfbEYCsYQp8uvDJi9G7ITB8i1Z2YQRVYqDdXlYIQkY9CloW5pIzpJqq38TRDgW1C6AdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200265; c=relaxed/simple;
	bh=fPJUVDwF+zuWTm/fTVKoRtFQ3BS17pB3bnUhzV3tirc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phNXpZliGggzsj0VzQC9f1OaeV7pcUthjg7IF7A+Vt920i/rMdW2xmw9LUtklb+a0FIcL7EH7rdC9upV+1Q02+bORQdmYK8UJarlugM0uaycpNR8oXtgpWKmw6wwmrOC7G6rFeiX2JQ25mfEX7jDLgIJ0F+xLvkQC2/27UekBRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLHmydyL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45E31F00893;
	Thu, 11 Jun 2026 17:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200264;
	bh=m+NmgJmH4CWmdHTj5eOO5l9fzqp+r26lhK4EXfyhFsg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nLHmydyL806rSensVx27jsPRdTk/pRioTOsha1Kt6t75C19gMRyHaJIu80sJgmCms
	 dfWO2uVU5pQCiuACy6PJxA00529pJOfznHbpRiEFvKZrj4GIMMPUEuWm4U7i89jR4M
	 JG9rbGmGEask1j4ud+sVHYqK0xj6JdvBPiczVNBQEt41J7/0FvjrqsoGRUXO6j48xi
	 qNZQXYFFl9ChxHy5up6dpKu9xokZSfIJawp4/1wJnj+rFA7J/loBDvbWoCKmD0MRkd
	 fpwHYt2NedMzxBWT4IsKBS0cC8GKqF9E55N/psneOnEw9Xcr3NZdI8wkzGvQjQE9Gu
	 ZaxZMN5GZJ0eA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 13:50:23 -0400
Subject: [PATCH v6 17/20] nfsd: add the filehandle to returned attributes
 in CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-dir-deleg-v6-17-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
In-Reply-To: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2651; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fPJUVDwF+zuWTm/fTVKoRtFQ3BS17pB3bnUhzV3tirc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKvVk8jAKehX4yj38Z8JTHtt78eGDBUE0ZtU8I
 srAElTilAKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCair1ZAAKCRAADmhBGVaC
 FdICEACLFSwmvCSTp/9Z0dhZOjkKvrdz7NnCMmaAgrLUArWqkyivMhcvOSIy1QrnhtW5o5BHrBK
 gkUpTcfenTJlixFF6cYZ4RTR/QjpXv1Ufy4Aa26ar86HLKwLuf9ucZo/K70vdJt5ebvSSSeciHb
 iGs8NolVKtzRAF36Z6DK075ig/6sTSzGm0D5hWmoiP8n2x2m7nRAZ5eL9tzAwSa8dJPA212AOH8
 PksCxJL2thU2DMEPuwQjNmYDqrh0wbQ2V2PTliA0DC7wrPzaOlMd/BN3CWNs0zRyxou4jW+88ku
 GCNJVmE4rYTYovD1TlR6RrbvGhjCfBxxAxEoAb+Uz+e79qDHFcHzP/JaRd7HCsb6H6twhA73w38
 MmR9wr4VwZxqKx/fhF7xjYzggbCLgwXK2EBGDGptzk6zFWut9GNaB1/AmH+a4JoSy3oJzOUDMk7
 ap08aiMyYe05Ki5jyzIYLNIvQZNlO4gWttuj3KmYsnqbMfWdvIAA40ihGgSks4wIxZzl6wEEFWq
 Q9lUczYnZMQmpNJh/32AoRuhJpbxSgVL3m0ZuzdRHv7hgfh8muga8c/tgjv8BHBhLrMYGX3+mpH
 JkxYbZKZ/AyoG5EzFqUts8pD1VYSObY2lLH4Jd1C59C4t2X770+vfnO/GJeFLYkHHZYJMdOMBwn
 ELbMqBVZ3inN/xg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22490-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3D5C6742F3

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
index 7b19248b1503..15ccd54ffdb6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4197,6 +4197,39 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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
+	if (fileid_type < 0 || fileid_type == FILEID_INVALID)
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
@@ -4206,6 +4239,7 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 			  struct dentry *dentry, struct nfs4_delegation *dp,
 			  struct nfsd_file *nf, char *name, u32 namelen)
 {
+	struct nfs4_file *fi = dp->dl_stid.sc_file;
 	struct path path =  { .mnt = nf->nf_file->f_path.mnt,
 			      .dentry = dentry };
 	struct nfsd4_fattr_args args = { };
@@ -4244,6 +4278,9 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 		      FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY;
 	attrmask[2] = 0;
 
+	if (setup_notify_fhandle(dentry, fi, nf, &args))
+		attrmask[0] |= FATTR4_WORD0_FILEHANDLE;
+
 	if (args.stat.result_mask & STATX_BTIME)
 		attrmask[1] |= FATTR4_WORD1_TIME_CREATE;
 

-- 
2.54.0


