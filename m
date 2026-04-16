Return-Path: <linux-nfs+bounces-20895-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC5iLDsh4WnMpQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20895-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:49:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F394134AC
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A2B1314B2C5
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0C33ED120;
	Thu, 16 Apr 2026 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGltAJYJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2973ECBF0;
	Thu, 16 Apr 2026 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360956; cv=none; b=Sobr8BJ5ujsLMSl0avezrvwbtIUNYa6toq8dNeWok6FoaXfoR688pqI91TL8HdPs1k+0cqS8Qm1eg1XWqqXVVzTImxZxqN760kOz5EnhorflQm29CQ9mvwfHYLqbIOQmUNW8xa0GzTcfQmgTkd8EZpEy3NtWI7mLHMbcV+v55oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360956; c=relaxed/simple;
	bh=Cr8l3NRbAfL4bnhBk5fPjSzCUeBfLwA6eSyNdpf5w1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XHi3c52Jp2XppEJCqB2I0/8oE1JWY3M5wHqiI1Hb79bQ8Bb/PkSQ9/6MZUvwUGGaJ2sGUfzkKFEXtxwU9M5zY3pZC1M9yxUcTHMCGXU/ol8WdbXsEncX2+l72Bwuo95YgMF5dYrosUidqO3/UCb8nCEhQb+WbJsBuxzKqihOzCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGltAJYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A777C2BCB0;
	Thu, 16 Apr 2026 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360956;
	bh=Cr8l3NRbAfL4bnhBk5fPjSzCUeBfLwA6eSyNdpf5w1g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NGltAJYJqKD0MEfrl3gGHGtuyMRyK4TcRUooIxZGzk+1UIwgFGIq/PrD0XMf84Glf
	 H9hwtnr92bkZjqtaHmBHPAbOFBXBi3pmnBVgWKuSe61mAPszziV0rcMS3zvNCOre5P
	 3o8lmII7gA5kyqIj1MVtdoPGikA8C3haixzKRcQlWPVUvslzDil7G64dbYQKods/6B
	 xgcI2+XlHM1ggaL8D4sVEnbQRvPiy1cNHo5cfzTihOqQ1ZcqiUPon7JL/tc5udiyJp
	 OFvG6jpIpfHbTuLvGu9MLNf+dD7xOPAHUA3LuTcu6oe5ZjoM1qB2+TWY1XStNqCWhA
	 3EwhbbAf9t+hw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:24 -0700
Subject: [PATCH v2 23/28] nfsd: allow encoding a filehandle into fattr4
 without a svc_fh
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-23-851426a550f6@kernel.org>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Cr8l3NRbAfL4bnhBk5fPjSzCUeBfLwA6eSyNdpf5w1g=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3nMjZLGyUC+0LxUuVwpn/7N+VXYFy6Ccfxg
 XDQ5voA4/mJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd5wAKCRAADmhBGVaC
 FaPDEADB7iNJj8kq8xgwc2Y3YRu2wd8N0hpPUtiuKwlMT0jKCVHkbg4TzMLbBREcivM33N496II
 K2ACOVrdkI2GntM4afMYhhE2mpe/780O7wMZBsND4IEBlezarFXJg+yhSAh3QQewKvBddm9wr7c
 s1pA0e/vu7w4in4tF2Jg5R862JBTogcdStV3fnYCOEXIwXI3XE49BzB0m73bXJsxLbmcyXlIx4x
 LJtnPFDKLF0vkszV9NOevYiVc6Ko/9zD761QcFZntrnt1XTl5betyIl4sLsU9xRNiw8jLxfT5mc
 exObwbytLtD1v++4t6WHnPnbAuc40v8+xX2u5OzcIdUzg4y8FGmtZq7oY8f/DRF0l7owh3zVeMh
 hOvVFeKBBtADbUbHYAjmVjlhxQvDASfeX3AFDKjBlRvLT3kNy5lvMK5VpC7Lo63ofZeEnAsyHWN
 vGQDes9sLcTF1WsH9VmylpMgTcUnx4/ZOXx/95TE5pQBuCO5rR7TpOx0MeFjf8h2/wlWCjri5MG
 +Owa/9cDmV+Ilt3OGitQjH3dr1jtTb4kMf/n1UTUdixfZPa4JNLnf4kqtYAjgEkO6PJzAFYvWLY
 fi6OuGhvJZxKbpBRA/ueWCqYSjvb41Y+eL82UDigM+cnx1Z5pvEpoFMlZvQN8OxkOqGtSrSgzoy
 1//OxqLlKepP/kQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20895-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20F394134AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current fattr4 encoder requires a svc_fh in order to encode the
filehandle. This is not available in a CB_NOTIFY callback. Add a a new
"fhandle" field to struct nfsd4_fattr_args and copy the filehandle into
there from the svc_fh. CB_NOTIFY will populate it via other means.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f85581ebbd10..a9cdf7a3f8b3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2701,7 +2701,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 }
 
 static __be32 nfsd4_encode_nfs_fh4(struct xdr_stream *xdr,
-				   struct knfsd_fh *fh_handle)
+				   const struct knfsd_fh *fh_handle)
 {
 	return nfsd4_encode_opaque(xdr, fh_handle->fh_raw, fh_handle->fh_size);
 }
@@ -3144,6 +3144,7 @@ struct nfsd4_fattr_args {
 	struct svc_fh		*fhp;
 	struct svc_export	*exp;
 	struct dentry		*dentry;
+	struct knfsd_fh		fhandle;
 	struct kstat		stat;
 	struct kstatfs		statfs;
 	struct nfs4_acl		*acl;
@@ -3359,7 +3360,7 @@ static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
 static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
 					     const struct nfsd4_fattr_args *args)
 {
-	return nfsd4_encode_nfs_fh4(xdr, &args->fhp->fh_handle);
+	return nfsd4_encode_nfs_fh4(xdr, &args->fhandle);
 }
 
 static __be32 nfsd4_encode_fattr4_fileid(struct xdr_stream *xdr,
@@ -3969,19 +3970,23 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		if (err)
 			goto out_nfserr;
 	}
-	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
-	    !fhp) {
-		tempfh = kmalloc_obj(struct svc_fh);
-		status = nfserr_jukebox;
-		if (!tempfh)
-			goto out;
-		fh_init(tempfh, NFS4_FHSIZE);
-		status = fh_compose(tempfh, exp, dentry, NULL);
-		if (status)
-			goto out;
-		args.fhp = tempfh;
-	} else
-		args.fhp = fhp;
+
+	args.fhp = fhp;
+	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID))) {
+		if (!args.fhp) {
+			tempfh = kmalloc_obj(struct svc_fh);
+			status = nfserr_jukebox;
+			if (!tempfh)
+				goto out;
+			fh_init(tempfh, NFS4_FHSIZE);
+			status = fh_compose(tempfh, exp, dentry, NULL);
+			if (status)
+				goto out;
+			args.fhp = tempfh;
+		}
+		if (args.fhp)
+			fh_copy_shallow(&args.fhandle, &args.fhp->fh_handle);
+	}
 
 	if (attrmask[0] & FATTR4_WORD0_ACL) {
 		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);

-- 
2.53.0


