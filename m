Return-Path: <linux-nfs+bounces-23293-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 46RJLGKEVGpnmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23293-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A41747817
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=RvnDyoRz;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=NN8B3KLT;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23293-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23293-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B7A7300D69C
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105ED37F75B;
	Mon, 13 Jul 2026 06:23:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99075361DC3
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:23:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923807; cv=none; b=aLPKozooKUQpPRopHdsWz95t4oEjniXGk9VjcXWoJs5U65hMCq4SpioyBQ0HBLLOb3Eayc1GUqqrbB7RFdFvSg2gbrUToM+Ha9PJq5201ASjo/4Y4FJ8seSM4pdBmD2UUpbv9KjTe1rGoizQIiP1x4iqzvpzdGeNAdxbJYsrqb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923807; c=relaxed/simple;
	bh=arEh3C7bbOMJ/zOZnuXOmYxcyT+1JhfiNkxxbpil2gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcJL3DMydT+WhzAE4NYJvxhWjyhN39fdNXpbBdJQ63JMl0V2fmm8rvqk6A46dfjsnqSlVwjNwaLvTv+cFp/7Cexh10dLHuEVvs6rYMTZOIEobwPGctKLJrMrd5Y8DRjNbTK+shgiI/+S7Hj1tZyGSvqL3NPpjFpEzXY6aPU44iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=RvnDyoRz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NN8B3KLT; arc=none smtp.client-ip=202.12.124.157
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DCA307A005D;
	Mon, 13 Jul 2026 02:23:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 13 Jul 2026 02:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783923804;
	 x=1784010204; bh=Lq9SASk7pRQDcMh2L8mxigwR7uheNOx6IbE3zJ3Vnd8=; b=
	RvnDyoRzhXNuBRfzq0JHnKn52JJyRWJd5hf6PLx+N5NPhJpdD7KirjWSOwrWKIJv
	EpMqj2jr6sNzOkwmSYiMLPiLB08s45Z5gnvHTHF4CTJL3hrwOtgy8w7fScSk2yFK
	apBhppJFPxqZlOxDJvJrAwZ+19YQvKOdwiKP7kpUJYLrlXun/+CeZNXSD0RIvr8w
	KCnU4oHo22qnp9yNa7Xfu+bQgQyNmsnnoMQT+S1JhD+HfsTXo5m9walCjk38ARRH
	41IYHrFFcAi6t5sZP1azv7fb/VoeZSNrsiDoMTKQ18+pY/HHeLJM3zsguIoIvWzT
	5e2i4SHwDZ6TFLw5JPy8aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783923804; x=1784010204; bh=L
	q9SASk7pRQDcMh2L8mxigwR7uheNOx6IbE3zJ3Vnd8=; b=NN8B3KLTy6M5OND0z
	9rUeRn3mFe/zZ2lBjWlt+5yGdZywUGmve/Paq+SFsE9xBKehZgW+bVABkEjoyc+s
	sJWe47uRzrV1H1nbcN9bYwfHjyrpCICGI1h56f0XxYym5y6+P8X1dPtGwS7a6AEh
	G3vsZxXm3aS5d555dDIaHMATKHfJK+KjbsD+q0ynoHlMLcJUjD3lgnywtQKYFYk8
	NJdCnR9pIywkB8ICBTJJsKhLpYjkRt/QG/3C9XM+oQ8SsLOJJ0l9HBfD0ie1DCWz
	pyqEFhXmTwyTlkguHgoPpPon3JnKzneyUOJ9HkIfdUsIlhMCpRAfSkBcd76NuDxU
	HK3Fg==
X-ME-Sender: <xms:XIRUapEW6eClUFJUK1v2PR65IGJ55exsPiG5Ykln2gOKt0gbrdLxZQ>
    <xme:XIRUaiAjorBzbZ8apQnQK2NV9xJq2lNt1wNC4HT6BfB6kkcD9keEzZEheonZincaI
    LT3ay2x4VLk7vFNFVC_aEUVNNs38y-8sviPtGFcdP7oWtnXbA>
X-ME-Received: <xmr:XIRUak8P20p10Hioito_XtqP5vhk9eemT5nD5AWed91-eIw7qSHdjoQPTohJ4i8w3UdrsqpDE0RanKEi5xC6wGl7cYexfOI>
X-ME-Proxy-Cause: dmFkZTFfIeczxMyuVCuGJGpAVwQh0zZkbaIeOkLaWK7ryTOVtlJ/6pjps0fHW8awC4AtOE
    ibA9cJp3YfD4rECMNgH3UEcFeYIV9RiwoJPXCSJPficUXiZ3kx6j+xoVOfF/pjyAazIJfq
    4qIe5Dh0SS9ayBH/GbR8unfi9PobUSUVm2+zivY/3iIyghi3JSOCnHxybSBgxtc7kv7Fv2
    6meQ6+c4fJ8plU+oi/L+xxftvyA1H7EMfGykjoiDfYJxKmmKPVJNDF/B6BNwq6jmHq1VTM
    3syOeuoJTUYvPV1MvMCVGru8xGzpu5HrLRyRj0g5ngPOJNIxiicgEEdmhQcKZa6/fp7dE8
    nn7fR4EfD1WpAHR+XiFCjhGnJUAD2Ii9ToOC7XEmNJGM3uX9tOUcBvB0f/Cw7enZz9qXbP
    9tIpTafZN2h7Q4y28nxm6QLjUle4Ny8F6HnNkiOxlZbf7wdO6e+Exc42/wRScF9WsRnKql
    GJaHntmcgMoi6YhmbthpiFzHeRXkRD1h3pIAl19j+5JfZeum15t8s8IQgZ5KAWnFW7gJYA
    C7yiim9s4N72kBKgOEwW7G1vHx/W2VVdv27IG8fSUFEFUpm6JFYWcCNRBjSEeS9RSVl2Rm
    B7NQRYmXICopVOU3+OpU1LEGFxhuGr37OCcaQKkvXaA4P17j5jRDhxY//ytA
X-ME-Proxy: <xmx:XIRUamDuxzH5kHyia53oddj_0Iu-Br-F08Gafp7bea27KHIknoNC1w>
    <xmx:XIRUahSOQDl0oIj9ufl9m7Bg9sDKUgVVOGqOYal5Fhx-unqOq24WiA>
    <xmx:XIRUaluVwkG94ZErywNWjiR-HjKfFWiY63gOz0cEn-EexjyW30Xvvw>
    <xmx:XIRUal3Q9Xm5_lZ40Sac4kDZVo9I0sE9zrc10ZBb7L0GSN3ggEiwUg>
    <xmx:XIRUaulm54IT7bzuiX_RMLnV8zDT5UhsqGutBt3eibMHJ0mNFOrZarha>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:23:22 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 10/17] nfsd: (almost) always open file in nfsd4_create_file()
Date: Mon, 13 Jul 2026 16:15:33 +1000
Message-ID: <20260713062219.6399-11-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260713062219.6399-1-neilb@ownmail.net>
References: <20260713062219.6399-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23293-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,messagingengine.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6A41747817

From: NeilBrown <neil@brown.name>

If the file is found to already exist, open it anyway.  This will
normally be needed eventually anyway, and providing a consistently valid
op_filp will simplify future changes.

To simplify this, change nfsd_check_obj_isreg() to take a dentry.

This doesn't apply in the case where the file was found in the dcache to
be mounted-on.  That takes a different path and doesn't require an early
open.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7fb63d1836ba..abe27a4841eb 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -168,9 +168,9 @@ do_open_permission(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfs
 	return fh_verify(rqstp, current_fh, S_IFREG, accmode);
 }
 
-static __be32 nfsd_check_obj_isreg(struct svc_fh *fh, u32 minor_version)
+static __be32 nfsd_check_obj_isreg(struct dentry *child, u32 minor_version)
 {
-	umode_t mode = d_inode(fh->fh_dentry)->i_mode;
+	umode_t mode = d_inode(child)->i_mode;
 
 	if (S_ISREG(mode))
 		return nfs_ok;
@@ -252,6 +252,8 @@ static __be32
 nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  struct svc_fh *resfhp, struct nfsd4_open *open)
 {
+	struct nfsd4_compoundres *resp = rqstp->rq_resp;
+	struct nfsd4_compound_state *cstate = &resp->cstate;
 	struct iattr *iap = &open->op_iattr;
 	struct nfsd_attrs attrs = {
 		.na_iattr	= iap,
@@ -364,7 +366,35 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	if (d_really_is_positive(child)) {
-		/* No creation needed */
+		/*
+		 * open the file so that we consistently have a valid
+		 * op_filp.
+		 */
+		struct path path = {.mnt = fhp->fh_export->ex_path.mnt,
+				    .dentry = child,
+		};
+		unsigned int oflags = O_LARGEFILE;
+
+		switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
+		case NFS4_SHARE_ACCESS_WRITE:
+			oflags |= O_WRONLY;
+			break;
+		case NFS4_SHARE_ACCESS_BOTH:
+			oflags |= O_RDWR;
+			break;
+		default:
+			oflags |= O_RDONLY;
+		}
+
+		status = nfsd_check_obj_isreg(child, cstate->minorversion);
+		if (status == nfs_ok) {
+			open->op_filp = dentry_open(&path, oflags,
+						    current_cred());
+			if (IS_ERR(open->op_filp)) {
+				status = nfserrno(PTR_ERR(open->op_filp));
+				open->op_filp = NULL;
+			}
+		}
 	} else if (create_status) {
 		status = create_status;
 	} else {
@@ -518,7 +548,8 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	}
 	if (status)
 		goto out;
-	status = nfsd_check_obj_isreg(*resfh, cstate->minorversion);
+	status = nfsd_check_obj_isreg((*resfh)->fh_dentry,
+				      cstate->minorversion);
 	if (status)
 		goto out;
 
-- 
2.50.0.107.gf914562f5916.dirty


