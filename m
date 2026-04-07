Return-Path: <linux-nfs+bounces-20706-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDjPA/AG1WnMzgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20706-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:30:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C243F3AF24D
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 950C8305E9F2
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6FA3BFE47;
	Tue,  7 Apr 2026 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cj6ObmdX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999EF3BFE3F;
	Tue,  7 Apr 2026 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568186; cv=none; b=H6BmyPHA8c/+e5nb4pMIFYqm8SqRuxeiClEFjUnA8W5uYyT0YgeO9xty2KXdDfffPgTmIOof16Ati6H53QRCY/XwTy3dVjtL5VM8GWJhR/9kIpmYBj1sg1KkAS9SpAOIn5ZTZ9VBM711TN2uqtp3KTWHpYIoH/Qo8nPs/f/Zqw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568186; c=relaxed/simple;
	bh=J40w/4AecsAWUgq0DpKUB39lTx0eXB+tjH+n1jPhzPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+bhIP28GiryW0pPDdxjrfJF5biXhxo+SwsC5YYMlyboc7QGMdWKd0C/g20jUcBQ5ASKS4qxO/SlJzddoNUbm6YyTnfAjKXJepBxD9GUhyY1KSZQ85CAADBy7MgD10zCRAnBEWk0d4UpB13qJMQ3275JwxDk9EzH6+qimf+fHp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cj6ObmdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3E8C2BCB0;
	Tue,  7 Apr 2026 13:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568186;
	bh=J40w/4AecsAWUgq0DpKUB39lTx0eXB+tjH+n1jPhzPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cj6ObmdXJNFIb6tBlsL6/nehVhTHY+yPRa3yRLgVUZIVe0QsEUMnhAbjZ2b2IBo77
	 TDEz/5tsbodyVAh3JvM2rzgus4Vl2XodZGUAPEyws5V4krM5dqetKkUw9/Jp8NeB3Z
	 8hanI+iC5fLTUtn9hhrbn3WSYmI5KegFUfc8xj/RzAe4pcRlxLCWu/km4xUomDIA1Q
	 4ldH0GpNdLc4KkRvK53Hsym6DrzQ2DRS0kAZu6wrNXQtfC1viDex9ayOG6l0woacZi
	 lgy90SFaHwO/6nDYJPsEBUPzMBeWI7KyfbLDGDl+jKfC/doVDe4N/NJXlVgejtaA45
	 GV9t3a1iGyLaA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:32 -0400
Subject: [PATCH 19/24] nfsd: allow encoding a filehandle into fattr4
 without a svc_fh
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-19-aaf68c478abd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=J40w/4AecsAWUgq0DpKUB39lTx0eXB+tjH+n1jPhzPY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUJ2y7V+VYcPHNsJgfbshtmoBxEeYXA2psMz
 JKGYkrMmXaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFCQAKCRAADmhBGVaC
 FTYDD/4tQBIa34V42fqpRCfUHuzNhog5zWCJrU7w0q7/sw3Pqy6F7Z4fTRWc15IejtHbGgf9M57
 IghwtKVgSuASVy+zReF06cIhLRnmEcHz36vOp+fCLqoMX/pjEGUPjJ3Jj9NoAj/yyS4IhUx8rsf
 QQHkD3fpgUH5sxGcqtZWUE4qkSX83CWOsdqTJzv+/3djxI4gfeiwmwZHrQ6ebNRDLGjNWN4UO8M
 FitchHKwwKsuTjsABiXbGHalOyGHqPuXPzS1/ALfoVMJzEw9AoD/44KzinukyjkD3jHFP3qvmZy
 JRin6LxFZ4/rTa5xZZjQTKhMT2F+cFYQMzu+L+Yi/3A95lrtdjhNm1AM9XBWfz1owbtqw0oV7XT
 wgLoei5abf8EBHfhqm9tXD7UyPTUXX/lKa8vpNFRTglUqnsS1gUw/xxeWCBwnW00pvKLrkwQTCe
 2idcBcy1YSMJQDEMpfn74JSL+ZW0TN7KWz4o4ixNqsbeGaEYmDMvp+mpkgMozBPJjOjk+eskBt7
 iBQzajwkk+yyS4I5AWeB/n0JE80s9gkzJpQa1Bg70vEnIDA8JF1h+hvnXIY/GVQj0e3KTlVh74T
 bejVh+rGAkRZeOtY3p28BgBhG3+INUxevb5l5MJt5WLPPY4CNyL4R36+AaxrC2rboRRNdOi6/Kw
 eP36WOGswgWCt7g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
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
	TAGGED_FROM(0.00)[bounces-20706-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: C243F3AF24D
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
index 0cdce460f9c8..faf0c3d35dee 100644
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


