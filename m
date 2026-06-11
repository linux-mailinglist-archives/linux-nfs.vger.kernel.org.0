Return-Path: <linux-nfs+bounces-22488-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kIawIF75Kmo40QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22488-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:07:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAC96744FB
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:07:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KJwZwnJ3;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22488-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22488-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DCB5352414A
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFD44D90AD;
	Thu, 11 Jun 2026 17:51:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0844D2ECD;
	Thu, 11 Jun 2026 17:51:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200263; cv=none; b=i7bhslP8+4C6EhyaDzjU9ASvNhAXu7CguXOu7pCho0ggaICI8mK39bMzJNLPMsxPTHKKkIWZM8yyNKehg1Zocl7ct4j2l3X37i/zDO0bIIJXJhjWqGIAuYSUzk7jIaWYHfZoP9MaPqmObiLh/BzJHFvp3zIR436vSGKrLB0WinM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200263; c=relaxed/simple;
	bh=jP15zhVMi8mCWtQnGto4m9iO8nFpaLdftVTZCij2eh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L4wiGo1EiTZBaXuL4aIAvv6xCNcWAWQl4BEaEu+TjV9WZYXvzL9zXSmR7v3J8pZiLp5xq3pnigEQSJQEMWBYEVSNsw+Hf2VkVwarLyFgvHm+pkOx66pMZYVG1X4shu4N4rsheAV61CZauwrFZeZ+gOlSWQddJ7nSCHA0i4XZB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJwZwnJ3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A6F1F0089B;
	Thu, 11 Jun 2026 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200260;
	bh=WZDiq9wPHdi9pMWWiupF+UqYu+18kC5+B5IXngIVzlI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KJwZwnJ3veRChY0Ib6w5m+W5beeexLj40phtltx12aq+6sQHo5zb+RDQOSZr5w3FL
	 4LE+1zcUoLQMOLRg3Y1Y2lbkjLsfpdZl/+Sqp1AJmTLN8/Gsfge8x3xLuD/qyusN7m
	 0QyGn+XRyxyZHoBFnuwiS7SuLyvHN6ByswIi/niamC+Pab5s8I1Ujbbd+QZSTaSXy2
	 tgBdpszSHcUFuE3qcNrCm14S/DhATOybIDa7IkEWJKDwlIzkmm4deKVkVImMboINut
	 2Vua416LktB3v9hqRrn2rMBPa6ypPeSWA7t6tlN0Qgjl7ikQuU64ZsEqs6E9MLZmj0
	 wrkvsx+Ejes8w==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 13:50:21 -0400
Subject: [PATCH v6 15/20] nfsd: allow encoding a filehandle into fattr4
 without a svc_fh
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-dir-deleg-v6-15-4c45080e5f3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5033; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jP15zhVMi8mCWtQnGto4m9iO8nFpaLdftVTZCij2eh8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKvVjuS+M+6WauRBR5medt60YM0onlYiVTgztt
 VZFA7/mmMWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCair1YwAKCRAADmhBGVaC
 FaH1EACT3681Kr9ni8JG0ISAGJulorWwJWppQGShrjhIHPxVuOaXs8NQqINRmdXXWbbrT+DT7G9
 abcHohi9Nn3gWr3B1Dxnd1juahqw7QPMrC6NobzpkeRg3tV53upBJIkz2DnEBxWIPV+I+IcBp+Y
 ADafd4XJTYG8DOJwvIED928y6FtSgbMQBXAJSK0BZCYDJ6//Z6bmCiljZ+TWTZDu+Md9HVvkLzv
 uZK35zZbWJ4IobAvlL3pzQ+dCJE0kvKyCc/Fcx/+hzr8Hx3IqLl6Seh+KD9r68iTRTiX5If0AN7
 DcpHCyv3kWtMgtu7Wey9gy+LuAZNJUSVGW6Lre/OMufzLMgu56ah2renNTulWpUYnJsgkXn2UBH
 MqVq6nBbw5huCtIWNp/hwVoWsuviwYjP2UWXzExapPRiKIt+BLkXAhbsQ93DGpeuYBZ18nMsrfW
 XE3uSMIBhYaJWR5eZ/6EBhnPLSq9g/VQvHq3pJ/ggZ+O3stUzm/+CZ0smDnjssg7j3J4bFZBcJt
 tAFxfaLEk+Vzlb151dpgGwOXOHUk3ys15suCJEtFIlVBiXXv/DNpRwM/WyYetuFgwCBkB3F9Kxf
 l4duPBuMUMSgcBF4KsGRWKyq/4M0xBrvDoq3zlykzdBtheyyCkrs5SuKOLfRGMahWO5VRC/NPLZ
 CMAVQYJzJlN6Npw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22488-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AAC96744FB

The current fattr4 encoder requires a svc_fh in order to encode the
filehandle. This is not available in a CB_NOTIFY callback. Add a a new
"fhandle" field to struct nfsd4_fattr_args and copy the filehandle into
there from the svc_fh. CB_NOTIFY will populate it via other means.

A filehandle composed this way may still need a MAC appended on signed
exports, so generalize fh_append_mac() to operate on a bare knfsd_fh
(plus its maximum size and net) rather than a svc_fh.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 36 +++++++++++++++++++++---------------
 fs/nfsd/nfsfh.c   | 10 +++++-----
 fs/nfsd/nfsfh.h   |  1 +
 3 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 4fb61d05a4a7..7b19248b1503 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2715,7 +2715,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 }
 
 static __be32 nfsd4_encode_nfs_fh4(struct xdr_stream *xdr,
-				   struct knfsd_fh *fh_handle)
+				   const struct knfsd_fh *fh_handle)
 {
 	return nfsd4_encode_opaque(xdr, fh_handle->fh_raw, fh_handle->fh_size);
 }
@@ -3158,6 +3158,7 @@ struct nfsd4_fattr_args {
 	struct svc_fh		*fhp;
 	struct svc_export	*exp;
 	struct dentry		*dentry;
+	struct knfsd_fh		fhandle;
 	struct kstat		stat;
 	struct kstatfs		statfs;
 	struct nfs4_acl		*acl;
@@ -3402,7 +3403,7 @@ static __be32 nfsd4_encode_fattr4_homogeneous(struct xdr_stream *xdr,
 static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
 					     const struct nfsd4_fattr_args *args)
 {
-	return nfsd4_encode_nfs_fh4(xdr, &args->fhp->fh_handle);
+	return nfsd4_encode_nfs_fh4(xdr, &args->fhandle);
 }
 
 static __be32 nfsd4_encode_fattr4_fileid(struct xdr_stream *xdr,
@@ -4015,19 +4016,24 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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
+
 	if (attrmask[0] & (FATTR4_WORD0_CASE_INSENSITIVE |
 			   FATTR4_WORD0_CASE_PRESERVING)) {
 		/*
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index b36915401758..3b29cd70d4a1 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -144,16 +144,15 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
 /* Size of a file handle MAC, in 4-octet words */
 #define FH_MAC_WORDS (sizeof(__le64) / 4)
 
-static bool fh_append_mac(struct svc_fh *fhp, struct net *net)
+bool fh_append_mac(struct knfsd_fh *fh, int fh_maxsize, struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-	struct knfsd_fh *fh = &fhp->fh_handle;
 	siphash_key_t *fh_key = nn->fh_key;
 	__le64 hash;
 
 	if (!fh_key)
 		goto out_no_key;
-	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize)
+	if (fh->fh_size + sizeof(hash) > fh_maxsize)
 		goto out_no_space;
 
 	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size, fh_key));
@@ -167,7 +166,7 @@ static bool fh_append_mac(struct svc_fh *fhp, struct net *net)
 
 out_no_space:
 	pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %zu would be greater than fh_maxsize %d.\n",
-			    fh->fh_size + sizeof(hash), fhp->fh_maxsize);
+			    fh->fh_size + sizeof(hash), fh_maxsize);
 	return false;
 }
 
@@ -566,7 +565,8 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
 		fhp->fh_handle.fh_size += maxsize * 4;
 
 		if (exp->ex_flags & NFSEXP_SIGN_FH)
-			if (!fh_append_mac(fhp, exp->cd->net))
+			if (!fh_append_mac(&fhp->fh_handle, fhp->fh_maxsize,
+					   exp->cd->net))
 				fhp->fh_handle.fh_fileid_type = FILEID_INVALID;
 	} else {
 		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 5ef7191f8ad8..5dc10b442d6c 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -226,6 +226,7 @@ __be32	fh_getattr(const struct svc_fh *fhp, struct kstat *stat);
 __be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *, struct svc_fh *);
 __be32	fh_update(struct svc_fh *);
 void	fh_put(struct svc_fh *);
+bool	fh_append_mac(struct knfsd_fh *fh, int fh_maxsize, struct net *net);
 
 static __inline__ struct svc_fh *
 fh_copy(struct svc_fh *dst, const struct svc_fh *src)

-- 
2.54.0


