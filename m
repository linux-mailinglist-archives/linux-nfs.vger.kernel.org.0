Return-Path: <linux-nfs+bounces-22935-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +w6kHOPCRWo9EwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22935-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:46:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C62A46F2D95
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:46:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=QnmMGs6t;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=j5TxtlyF;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22935-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22935-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 818BB302C6ED
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 01:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFEB282F1C;
	Thu,  2 Jul 2026 01:40:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802CD1A3166
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 01:40:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956455; cv=none; b=nlpm0gtkJod3XUTEqONIfkRbLU1gjG8HdvbW1SbWlu4kY6XMbdUDryjSUnsS52LfzH2WmfurUbBUNLy//IhNCoYV5skFojNsIMm7KgdcKulFjZ2qoBLPj/AsbQJQ8dDOP4rLBzOaDobrGce2J1tAqGN7FFC17CwGd3hHKfxrRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956455; c=relaxed/simple;
	bh=CTkNS52eN/lUaxgmzWi7ZRpMGUuMMjjl5plcusr6/Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSaEAKfMj9X9xdTi8+jhRf8vdLbDks6XiGcvheMh+a+hGkq5CDPCFdhoe0HkjtnmF371v+cvNlyPfxcBXOCgt6KuyuDxP6y7Ni50lj/o7XSZcZmbJ4ek9PEyGCYd5KLnNATX0ttvIyVUT7rFYb4PuUAgGC2hK0Gc9k59UjP98Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=QnmMGs6t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j5TxtlyF; arc=none smtp.client-ip=103.168.172.155
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3C6D1400133;
	Wed,  1 Jul 2026 21:40:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 01 Jul 2026 21:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1782956453;
	 x=1783042853; bh=IYQzl1RHoDl5Js7kru5zoAE43Pa4Hz2EdSuYSPYbXRo=; b=
	QnmMGs6t7pcusfCrT42s7YfQRH6DwGsaBu/LKjUe0p6v3Q9Hmno752w4OLzGW6B5
	vB1Eaibb0BojZPXO4AGa9IPHNc7992JU5JsSInDcmWeVVYw+2IQy9V5fTl2/4KQF
	ga4Ad7Cx5BzcLHTOU/5z+sAFvAJB8Or7QozDVycnwy8DURSXH45DQUh5KR4mvS0b
	oiAgg/B1VkWVukcw4O9ewawP3QNbrK2TjCRxnxaub0zgN66BXLn6UuMTjgDMfPVk
	oSuLfGxX06OaTnZOHSi9Ix3a+FZMZ+FSSeo3kcVC8CtAJC1AOGxwIyUcP3ppVipG
	1mDHxmHMuO2DHv95Hy5bQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782956453; x=1783042853; bh=I
	YQzl1RHoDl5Js7kru5zoAE43Pa4Hz2EdSuYSPYbXRo=; b=j5TxtlyF9KJnhPFkG
	qKeGEnSWAgsA3HFiWGBtTH69ZTrE6wzRhl+oKd3a0e0dVNf4NGpMDSBRN/ZUnWXC
	ZA3eqAjKPYqp0VDL1l2D8XznXlwlnnqrZe3qdbPOtP23T9ZraWHCNIAn6s+pC7Gi
	0hjvvQQAOTmOZ1uRpXxjua90qAHMttH+B519IepNuCi5aUpRKxn5KTbrsXM/ZVV4
	JxgVsoaMWf7olstXfDUst2mzmqKXnj9D1QAHHfKUurOhykCqVE6tD9roDggks0/V
	iJ7e+2ATZbt+2SV/5Tn4Ah7PAbVWrWEUUJKlR8Q5pcEXg3F2R4S/3sMWTLPC20y/
	+262Q==
X-ME-Sender: <xms:pcFFangCrsPIY0AZMHNXITp2e6_4FPSxIkfxi9z-6wg2eiZx5gGMcQ>
    <xme:pcFFanseYPWpNzTLvyZ4ULbIAdjs_UzfFhA-1EiZbAISpFThNtQ0k64NcnmE5rUap
    6FIrB2GBxBbo3ETi5xrruS_bZyCoMgR8gMFzY39ES0h7RuMvA>
X-ME-Received: <xmr:pcFFag7XduGWSOPQUP9PWD6HJm57_TsLv45OBUh8ODp-p2densw4dMXEUfuPBeHGiJX-Kaqti4NwzXEubL1TPXirh-KeyBM>
X-ME-Proxy-Cause: dmFkZTGxxG3WYOxUHoAfQ/lPCCBtpuI/S7RhXZdDZo5R/zg8oB5VVkJeqNXv4+5JHOpq5a
    +KGMHLUceWZQbXPkcZMChswAkz7oDBNzn2AAW712K9zA+2pVUC0R25sTJVNA5GxxGZFPf1
    pbUOYpi4dQLmAi8WqifnbcWGv9caFABP7KC0vD8MdlGlpjn5roAZxmnOAYWdGQbArFc5Hb
    UEMPfmUhw7JKuGB/UeLW6QzhMn9rUFgblOXzq7GYDHlxGkjfNMCQ4PJDU4+12b6NAKgXbl
    Rg1mGujmSEJHxyDH3iqFB1G6ofNBMwYgggnhxc3EKZatNVAxTrXJlSKPeBcpJnvqZuoCSy
    r3bpuQoEb3ThpoW1ryyxj0KJpvkY4zQ4BYcRi9CdCEUeL2wWtU+czoSzRCFbZ1keFiEuOg
    mgaoSneA+CtQw1s1mTMgbHGRgQxZYe+aliAijESY8plTwJ66yhVvrl1Yie8AtEj900BMFZ
    i5jftcrU9Q55dLKK4fgbhwOfPyVF/3A3z0xmxJULDc83yyy0iyVKVBYQP4wA5wPdUqW02h
    6AbiljTWJoDaOg+ag4paYDaMlWgjnytbu1UiZfmKgQuVyvxL2AFeSimbuEcvlCG3/zQlsU
    5IypLf5FED/FOh3GMsSyPhF+mq2hqh6tnFCrI86i75trMd88TKzaCzcGdbvA
X-ME-Proxy: <xmx:pcFFarOUpQ2xr2sogqWle3QAKTna2yzbGUSU7X3kxGg89JPn8UNLgQ>
    <xmx:pcFFamvxkkicWKNC_etmfSKrYRm5pFl_oTUMvDBSjyFq_dqunE82ZQ>
    <xmx:pcFFamYLS9O1pd0mhibMPe_plncq94qW9j-O3EaKTuidMh4GJJL3zA>
    <xmx:pcFFagz1QWcupGrVp7xPjgjgRWqhPB1owUCO3Aeq1RYmsrW41vWYjQ>
    <xmx:pcFFapCZTOq4giBBOUEu2GIX5W3ogtCFTd4jkV3m8J0Hh8iwiaNj7OLb>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 21:40:51 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 09/10] nfsd: move some code out of the d_really_is_negative() branch in nfsd4_create_file()
Date: Thu,  2 Jul 2026 11:34:28 +1000
Message-ID: <20260702014000.3397240-10-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260702014000.3397240-1-neilb@ownmail.net>
References: <20260702014000.3397240-1-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22935-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,messagingengine.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ownmail.net:dkim,ownmail.net:mid,ownmail.net:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C62A46F2D95

From: NeilBrown <neil@brown.name>

The benefit of this code movement isn't immediately obvious, but it will
make it easier to switch to using vfs_lookup_open().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 49 ++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6e94f88d79da..961e0c26e9a2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -218,7 +218,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		.na_iattr	= iap,
 		.na_seclabel	= &open->op_label,
 	};
+	int oflags = O_CREAT | O_LARGEFILE;
 	struct dentry *parent, *child = ERR_PTR(-EINVAL);
+	struct path path = {
+		.mnt = fhp->fh_export->ex_path.mnt,
+	};
 	__u32 v_mtime, v_atime;
 	struct inode *inode;
 	__be32 status;
@@ -279,6 +283,19 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		iap->ia_atime.tv_sec = v_atime;
 		iap->ia_mtime.tv_nsec = 0;
 		iap->ia_atime.tv_nsec = 0;
+
+		oflags |= O_EXCL;
+	}
+
+	switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
+	case NFS4_SHARE_ACCESS_WRITE:
+		oflags |= O_WRONLY;
+		break;
+	case NFS4_SHARE_ACCESS_BOTH:
+		oflags |= O_RDWR;
+		break;
+	default:
+		oflags |= O_RDONLY;
 	}
 
 	host_err = fh_want_write(fhp);
@@ -293,40 +310,20 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		status = nfserrno(PTR_ERR(child));
 		goto out;
 	}
+	path.dentry = child;
 
 	if (d_really_is_negative(child)) {
-		struct file *filp;
-		struct path path;
-		int oflags;
-
-		oflags = O_CREAT | O_LARGEFILE;
-		if (nfsd4_create_is_exclusive(open->op_createmode))
-			oflags |= O_EXCL;
-
-		switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
-		case NFS4_SHARE_ACCESS_WRITE:
-			oflags |= O_WRONLY;
-			break;
-		case NFS4_SHARE_ACCESS_BOTH:
-			oflags |= O_RDWR;
-			break;
-		default:
-			oflags |= O_RDONLY;
-		}
-
-		path.mnt = fhp->fh_export->ex_path.mnt;
-		path.dentry = child;
-		filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
-				     current_cred());
+		open->op_filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
+					      current_cred());
 		child = path.dentry;
 
-		if (IS_ERR(filp)) {
+		if (IS_ERR(open->op_filp)) {
 			end_creating(child);
-			status = nfserrno(PTR_ERR(filp));
+			status = nfserrno(PTR_ERR(open->op_filp));
+			open->op_filp = NULL;
 			goto out;
 		}
 
-		open->op_filp = filp;
 		open->op_created = open->op_filp->f_mode & FMODE_CREATED;
 	}
 	end_creating(child);
-- 
2.50.0.107.gf914562f5916.dirty


