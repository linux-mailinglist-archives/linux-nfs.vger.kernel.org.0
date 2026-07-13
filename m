Return-Path: <linux-nfs+bounces-23297-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WaRxKnOEVGpvmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23297-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC19747827
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=EsEmkaM5;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=Y8cdFlWZ;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23297-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23297-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C26BD3009893
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B7735FF6C;
	Mon, 13 Jul 2026 06:23:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9361835F165
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:23:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923825; cv=none; b=kqW5PvZaiMClCq1AAuLiGA5ZJrFlvSxGsE72eP0fbJrCoJnIwupIkkzAkY/vYP9WzSxnFuBFf6C4roZDdzQv6RpVVSI4/xt/xNCSE6jjCjebgmsSWTaNTtL2QYyqM8Is4yAKuwo72B1YTwvbZCg/QDWFkmQOkmtnmp5UsrwLOHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923825; c=relaxed/simple;
	bh=hDKeomlMc6l0TC1aP9vPIR5wV0sfuEF9KzC0+96fRBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+i9HCOCi+QWxcZ9xjJGsp1VedYBud9INHkZAtGyHei4qVJITUD+p6Pq07Iy6oDVsXxZI2zP/8qiEhV8zxHkhqm7k3MkLgQ0JPtZgk7+A5q4EMybG0VDeljTx+BvCGPKrfIzPwN4giZFJ+kpmxSYtlOsxbDGmkSUIl/lGNleE4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=EsEmkaM5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y8cdFlWZ; arc=none smtp.client-ip=202.12.124.157
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0DCB37A0055;
	Mon, 13 Jul 2026 02:23:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 13 Jul 2026 02:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783923823;
	 x=1784010223; bh=28Z6GgjacEqmptbDFw8ZJMnKD27HfJXPEoXDqUvgGcw=; b=
	EsEmkaM5qv0sbEZo5PPvDCWcC2fTk2m12PqAz4XWRMuJMIfjaU1T2V0XaeMaBTNz
	RKqBKU0oqV21d3zmJwK1lzU4blPfTJfNsTjR1KlNW83ofIwYA0cq0Z4PYLzXoX2z
	iCXzol1ouytPZfbfWM5xu7WPfQiG6pcEJwkJmTHsazTf1Qhja75e3k+r/wybqauj
	jY/LjQf8xOjleAkCNEazjAds/204NaWWTLi5gj2WY/Hbpxk/RzJsn/PH8Z+CSpcu
	9YXiR3uteVL19V7ZT4RVvi9cOy5Rt+SKDJkbsMWRMWyXEuMfJccYz35+csmf+uAT
	xay+whfV5mI6+kaHk5ZlNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783923823; x=1784010223; bh=2
	8Z6GgjacEqmptbDFw8ZJMnKD27HfJXPEoXDqUvgGcw=; b=Y8cdFlWZGm8Y5Qg6H
	vJ07602bDeFh/3goeE8IuzneynuJFkQ1szK/QWiyBfb5uMd2P7U5ERHArIsRtrxr
	PHZPVxDBOUV5KEdrt3DaHmUlj8mHGnxt/Lst/LS5FRATOXmbtQFyyAYVL2y5ZXhV
	TsOY69u7ySdeU7msux60I/q/pZKH/RFmDd3YOyiobRpJA85VLz0JmsGG4EqeTSYI
	trxs0WNKmtWxYyWXn3k8ZAsCe+qMnNyfvtrSPsUluz4Lvur1uZb9OcC9oVCiZ4X2
	rD4hyICfSYYovc4Xf0WPr2hGqaiAcx0gy71dCryyGVJFzX6Ub6d2MKc+jBxXptOi
	dhF+A==
X-ME-Sender: <xms:b4RUaiUe5cwgWhaF-UPzcj7A95mY5w3wWY5VQfkDk3E_nblcwUIutA>
    <xme:b4RUaiRVMO4yQu-RkO80PUEuukTImEyWfjlHYPE9oi_0OnZBcxRN9kysFpNbY2VHS
    qmfTlFbIYhuBgXkftpKH-CsM207Q7xvKbqgHHh7b1T7888GtA>
X-ME-Received: <xmr:b4RUagPzBdV5UdhQ2M4GrRngqtJVkjGhzKQwY3h6kS_iV_lIHg9RNPXpyTtEMuuRsR419kxVuUsICDn4C43dpdsl0erIECM>
X-ME-Proxy-Cause: dmFkZTGCQLlV7rkBD/d/I31+FnWtoJqihf/xdHHsD1TT1SXgkZmv6s4HWqyOhFnVY9n5MU
    BOJtfUQyVpUKpBykWA7VcVygcWfF57rWMRxVOWH1WLSaRWqIdVkOkFztYwGNBEJqYCGdER
    lIjYSwxT52xjXFVZpJf8rJpvaK2n+rZveXXBjrP8wYzN/FLD3xS33T1EHtom553cqC8fjn
    PrLIVOrVJtl+mjvVoS1EqhD6Dvk80GmCtdpbSpYdhpfrTqNe15e9hEbxs6wUV0rVyj4+GV
    nLsskUnL0p4PWJePiP27X7oGhT/Dg2xDgvflUJ5tmToCi4jiK9SzoT7k7idnqqIq2oUzj5
    h1EeuyapeVrxrhO6EingakkRnKpcckLU+89K4O9vli72M9y+TIrf5f67GkKCMFjng/AfRK
    FQha3zyIR8ouCbrxgzU34kzjg0msjN1cMN3WNs0ht0VKjN3l86q+Mam8nyZxf2lDD8gWj8
    8J1c++MQgMQD1gxnIFzBp+C6CxolL7OLUYVXD+B2mjusl/mkDyoe0r6NaQ0QDZ8z49xlJj
    UZ0bII9Z/x+cZSjoefdbd9Cx2BxPVgM/Rm6vawrrIUWegjcV1fbKy+vRM8uayq5Ou/CI1B
    ZEpckftkcBLfX5cqWWXa9GE0fN22ttXadkvXAlFrRwEg9d58ME3gjD8PEqlg
X-ME-Proxy: <xmx:b4RUagSajpDN3VpexK9t-bGxSWPDHOwp631Rpf0S34F0k2AbDIqdzA>
    <xmx:b4RUauj6PIUW3WXpgJ2q0m4oEgaM5Kdo9IRaWmXfkA6joPgw3cUBbQ>
    <xmx:b4RUap9jc5Gp07JUqY3nRKx1z_0XP7EPvVDNaUQjq1Ou6kljlYshtg>
    <xmx:b4RUalG7PmCqYkEur1xr3WnjhX-AsrrDHk-YZnEJom0spKoMUGVGsw>
    <xmx:b4RUan0vTVO6UWcsXOg272pMrvjr7j4sTGNVIAD5Wxk5NFiS6xNS2Cq_>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:23:41 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 14/17] nfsd: reduce want-write range in nfsd4_create_file()
Date: Mon, 13 Jul 2026 16:15:37 +1000
Message-ID: <20260713062219.6399-15-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23297-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,messagingengine.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EC19747827

From: NeilBrown <neil@brown.name>

nfsd4_create_file() needs write access to the mount for two purposes:

1/ to create/open the file.
2/ to set attributes on the newly created (or pre-existing) file.

Currently this is all handled by holding the write access across the
open and the setattr.  A subsequent patch will necessarily change how
write access is gained for the open.  So we reduce the range for the
first want_write, and add another one to cover setattr.  If we failed to
get write access, it is only fatal if there were attrs to set.

We call nfsd_create_setattr() if at all possible, even when no attrs, as
it also calls commit_metadata and we need to be certain that the file
creation has been synced.  If the mount became read-only since the
creation happened, we can safely assume that the sync happened as part
of that.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index adfc1f5ccd98..0d1bcb12ecbc 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -344,6 +344,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
 	if (IS_ERR(child)) {
 		status = nfserrno(PTR_ERR(child));
+		if (!want_write_err)
+			fh_drop_write(fhp);
 		goto out;
 	}
 	path.dentry = child;
@@ -378,6 +380,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		}
 	}
 	end_creating(child);
+	if (!want_write_err)
+		fh_drop_write(fhp);
 	if (status != nfs_ok)
 		goto out;
 
@@ -421,7 +425,16 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
 		iap->ia_valid &= ~ATTR_SIZE;
 
-	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
+	/* We will need write access to set the attrs */
+	want_write_err = fh_want_write(fhp);
+	if (!want_write_err) {
+		status = nfsd_create_setattr(rqstp, fhp,
+					     resfhp, &attrs);
+		fh_drop_write(fhp);
+	} else if (nfsd_attrs_valid(&attrs)) {
+		/* Needed write access */
+		status = nfserrno(want_write_err);
+	}
 
 	if (attrs.na_labelerr)
 		open->op_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
@@ -432,8 +445,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (attrs.na_paclerr)
 		open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
 out:
-	if (!want_write_err)
-		fh_drop_write(fhp);
 	nfsd_attrs_free(&attrs);
 	return status;
 }
-- 
2.50.0.107.gf914562f5916.dirty


