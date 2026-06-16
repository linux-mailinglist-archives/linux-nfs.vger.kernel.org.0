Return-Path: <linux-nfs+bounces-22618-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KawAC4Q8MWrUegUAu9opvQ
	(envelope-from <linux-nfs+bounces-22618-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:07:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3E168F1C3
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:07:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cZXFLRbV;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22618-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22618-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18F16304D2AD
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52973450902;
	Tue, 16 Jun 2026 11:59:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3619146AEC6;
	Tue, 16 Jun 2026 11:59:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611178; cv=none; b=fioU41SPc0oxunj9rDgsvyntRaG31dUXpU8Kks5xatggaZ0TfNtN+fAij7iYvFbH+AZUJUClR9WU6fmxfTLNy4PALm2TgVX4Etz9vB75Lp0pyugm9tv08j3qqmsx4IMXez5TaynZfXntxJBP2jmTENQKcfPqEAFSKlcYhlUKMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611178; c=relaxed/simple;
	bh=sjBeKLwwMVBt95EWDZuoobez3iTRREsuTu8CGbrkfO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NXbZ0aHP5PSGnK0RdrQ9rw0WgeK9POAPpqSKClBijZK30MLYZu7L5s88iIZbAW4mLCyH3bZ4C8nyEoLGr5MNO68hJKPD82/kv0H3M+emNdap+sIr7SAqdBPxd9/lnYzD1L8iwcg2OZ1QorkP8cXRhEBcT5jiK7g0DYEcDp4CPcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZXFLRbV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FAF1F000E9;
	Tue, 16 Jun 2026 11:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781611177;
	bh=mk7UKcsYzQoxWaDAHF92QSGJAq/OUCHzPv0kiSqe1Gw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cZXFLRbVW5uHaJcJcMpQ4sRBX8y9wZDYNXt7lM6WmX/WI6VF8yH1NaK8yUjVFEjie
	 qduBeoglPbOGxDQXeFj4zVCCsqOtEz49um5r9tn2UbNKTIELa6+W/qVHBfJlBTFB7O
	 Zd02ofdbvrKZL5CddQz+fkIc3ghXABvqFoJrQZMJ6AAmxyGxrkDA4acCu8esgcb1eS
	 CIOaJvUv58tN56I0atQUQbnnE6XuNhQy4rOV2z5dfmGeFgHzVR30ho6/ZpBuwEhjUV
	 ucKIAQi89y77vQbrgOTzPfrsGvxjrQ88GHABOb54Mg/lbGhgqBt+OMUu6Kxmri0dhc
	 ChEeFgb0idPDw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 07:58:59 -0400
Subject: [PATCH v7 16/20] nfsd: add the filehandle to returned attributes
 in CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dir-deleg-v7-16-6cbc7eac0ade@kernel.org>
References: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
In-Reply-To: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sjBeKLwwMVBt95EWDZuoobez3iTRREsuTu8CGbrkfO4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMTqHii0Uc3pHHxzPfTkBzC5JjcOEJ3XeinK5M
 H/t5CVcIWWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajE6hwAKCRAADmhBGVaC
 FTIvEADLYFgKOKE1DzwUm0tgcFAsBdHWaDZIFyQ33NkrBlnUks9nAdb8xhOsbIXm/zccvbqab/o
 DVCVzPJY9I7nWe2Y878dnRqYJzQK7EXiAI7swJlZ8HqIbeXY5IzDSfZJnt4p8Nn7pxaQ4ByTuRw
 hXE1iEjJcIwvXv1nw67BMkyo+d5EPlMOtU7Kd6mW393uSGLPb2UdP2jRwlZKqHopqmEfOy/D+5x
 0g8y9EjHCFPfoxLf9ZNwnb+9ohX4D2qvBTmvsc5694yYElmy3/tkz1Gx/v/yTc04w6hYc3cbEvj
 DojHnOcR7No4RexfDi2rtjRMUgp6jYXP4TOsVdKAJgXr4LK6rZ3kNUYSK51qHuzR5P/M5QBKqPa
 8DOHjB3V8QyrvbmVBI2ccDsTasxpRyoqhWlAWpRuXa0BNIrzZX5bFwBEorc2XR1ltZFYxZOnawl
 OeoIjcPvVOkUFYdxWCqVV8Um0ZYcjI++svUcNRWWd1t2Telj4XsoKxCOmmimQ2FqzxncA9uo0rV
 wqSS68agEhDzftBszUn0wXZNJDpr+jvoy+ezkQDGn52PXFuG8KmM2l/8jHOMfzPE7oZljXxWTS0
 bYz9RZ56yYVklbvUyb08E2N5rrNL7pglC5K1UzkAFLfNTIohwjmn6b7gEcW/SWnr6OWy3MJTPO+
 0rcWqBUO0HFSofg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22618-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB3E168F1C3

nfsd's usual fh_compose routine requires a svc_export and fills out a
svc_fh, which is more machinery than a CB_NOTIFY callback needs.

Add a new routine that composes a filehandle from just the parent
filehandle in the nfs4_file and the child dentry, and use it to fill out
the fhandle field in the nfsd4_fattr_args.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 48de0922c6dd..b3a4b134d309 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4198,6 +4198,52 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	goto out;
 }
 
+static bool
+setup_notify_fhandle(struct dentry *dentry, struct nfs4_delegation *dp,
+		     struct nfsd_file *nf, struct nfsd4_fattr_args *args)
+{
+	struct nfs4_file *fi = dp->dl_stid.sc_file;
+	struct svc_export *exp = dp->dl_stid.sc_export;
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
+	/*
+	 * Subtree-checking exports need a connectable filehandle so the
+	 * parent can be resolved at decode time. Derive this from the
+	 * delegation's export rather than the shared nfs4_file, which may
+	 * have been initialized under a different export.
+	 */
+	if (!(exp->ex_flags & NFSEXP_NOSUBTREECHECK) && !S_ISDIR(inode->i_mode)) {
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
+
+	if (exp && (exp->ex_flags & NFSEXP_SIGN_FH))
+		if (!fh_append_mac(fhp, NFS4_FHSIZE, exp->cd->net))
+			return false;
+
+	return true;
+}
+
 #define CB_NOTIFY_STATX_REQUEST_MASK (STATX_BASIC_STATS   | \
 				      STATX_BTIME	  | \
 				      STATX_CHANGE_COOKIE)
@@ -4245,6 +4291,9 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 		      FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY;
 	attrmask[2] = 0;
 
+	if (setup_notify_fhandle(dentry, dp, nf, &args))
+		attrmask[0] |= FATTR4_WORD0_FILEHANDLE;
+
 	if (args.stat.result_mask & STATX_BTIME)
 		attrmask[1] |= FATTR4_WORD1_TIME_CREATE;
 

-- 
2.54.0


