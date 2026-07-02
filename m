Return-Path: <linux-nfs+bounces-22936-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X7SMDunCRWo+EwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22936-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:46:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9293D6F2D98
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:46:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=SHjXbTyz;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=PdpBOCgE;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22936-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22936-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C19D93048175
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 01:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6C9282F1C;
	Thu,  2 Jul 2026 01:41:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B772C08BB
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 01:40:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956460; cv=none; b=l3n//S42poyBf9cHDRqsGt9NzIgYwsZeyVTv+GgKN4UXPboav0StKaN6XcXCJWPJm3/OIGPTYAsOyWR8r3gUPjecyeywGeVj7q6OPcBKIELTq7jwZ0sLGP3xHn82gGLQyR56eB94mNMtjfw/dFYzMmlSE0F+wjRWDMqgVDY/BWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956460; c=relaxed/simple;
	bh=BDruZbnqLN83CA4Cag/hRE9pANOTDt+yvVhCc89COdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syBt0NKwl6LzN7BZb3zH7wKGlqDA5BgrnYL/cBRivwm3VGOW1nfEWo4+OHRARRocZyFK1+tsg4SGJLSDzkGMrsfHnewPfOi498i9os22WZr6QIUGM+WlEoiZQvO11H8vHP+I63lVEf1vOqMYH19aYKo/F5J31FG99ZCyjS+Ic60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=SHjXbTyz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PdpBOCgE; arc=none smtp.client-ip=103.168.172.155
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D442140014D;
	Wed,  1 Jul 2026 21:40:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 01 Jul 2026 21:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1782956458;
	 x=1783042858; bh=jRK3PihBUTPjhctBVRomM9UR3mfAbrAApyv4dbPrNfs=; b=
	SHjXbTyzPf0ZV8m3flM/hnehNSfywM3IMGQQoVAh1FvX5Q80HopzmE8xnJDkyuEK
	8mxTdbljITRsmLl9SzMkKU+nTtrDTAwGUvDzf+QILReuMS0rdj4FzSdxJL77M7TG
	ae/gyi7GTOAzhMoxPiY57pXXOwmkci8lD3zpXVbtpvqlpFejwRB9B6F3gNvJSFaI
	QOG45WPxoI1pT1vSu8t2db2UQ/Dh9UztEnS7nQIBGB641lFQqdnnGE4/1ZNdtQyt
	58EeVkK/5k+FOf370V7Z6UrKkMQ5VTxksdxJHl9LO42guLHSZ5zqJviYEdSQVTJZ
	I6I+5WXq27bB7icnDYd7/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782956458; x=1783042858; bh=j
	RK3PihBUTPjhctBVRomM9UR3mfAbrAApyv4dbPrNfs=; b=PdpBOCgE3jdoHy7jK
	jwzXyC3K4kHaoCfmau3bGvrOYvH9fwbMrmfDfRWR7PTqCGpyKBxlPlML22nUAAfa
	tDI0rY7Kc8eSi3zxRjGt++YWUh+9GCODwbwMnj3SE4MRfeowHA64nV9CiivCr7bJ
	7uNC2umhgwyAGSlHFf5qZuAisqFfUqkuEQYRhfKF/aoVb4Bfu8E7kWayjpPhSpFu
	dRx20KnqKmq4YmVnxw+tBp8gNJcXGICEhV6gVUdSB7fGHdsEWxQEM6nwzWCZXuN5
	Ij7CuXQXpQJ/PDzKZSmjMO9DxiMlz0uL4IhSXoaaj00AVJjAliWYpmVhOscUGuq3
	S0HGw==
X-ME-Sender: <xms:qsFFahw6wFM_p1fngC2E2v-8LxooXtSoykGzN0Ici5BCvjSXu4EYdw>
    <xme:qsFFak8nTy5yArYIKkWjAs_sXfCHFxUpqujQsX-HG_-jAAA0QrD5-Ltf7_hryKZ01
    KDdDgm81EYpSL3HlGEOfDN1XKU45JR8iB_ZF9bGn5C4jKCzNQ>
X-ME-Received: <xmr:qsFFalIRnNzGVgQKQGgUp1mqQrS4uQ7Mxxrt4zK_vBIhq4_7n-oUmT8eYQiwCiU3TFil6kI9Ux6TSgpfNvxZ71LmDYjzVJw>
X-ME-Proxy-Cause: dmFkZTEBVDJy6WgOC1zITKpnRUuNcLFM7G19761VI7n+OPl/n+VIkxww3h0C7czzFt+I7r
    ytkmwqa4AGn4/QjuSP2SJdWC9SgnMcizI//JMncoVj24eUV4rZkLucS0Y6dTI0LS+4OnSb
    Z7k4kwQfqKoF1gzhW6ifSW9bKWK8Cabx1rA9PolZ7jXqjUIh4GaRU0l8kVsKgFWEhFEEMu
    6V/ZRURWWPEAxk0PGk6wZ4+pi2wCCpL8a+ok+ZBU97Ge8op1UBVRcbFSPSMI1y48apX7uK
    IFXck2rHhwSCaTjGxBLqmQAEQtQUVlL6D7bYR7c/Jo+RtAs5q6gDaUQTOyu4IiskMdsNnt
    nTnyk0cX/EE6YMiBDHplhfPbrXNg7eTUcJ+qaA998XAnO59a4OCP1kEmGFStfq9njor+KW
    SvlK6ELFYbxjRloLyAATmdxkPd2SRea9nq4fDTTm0emqqgAatZTLfr75qtcah364ROELqe
    2tPoWeRz39ggMCVEEG95JCf/GYD9Eyd3WeGxyHpZnL9xPflRx52WfyApP3zOYb74sfmi/I
    zmbAXXiiJh2CcKXNOOjzjR9jMcVaHlM2wkAz7z9lKPrbRxe4JLRf0Pr3lJ5H4KuMfa4gxA
    j8j0NB9kkR8j0Rv+aFH3d7Owqm4UDyRx/txyt0SebnZtL1m+gy7+JCA/A2Rg
X-ME-Proxy: <xmx:qsFFaqd7iB1QUsu5yLBUR6qCsOlkLjIaSVO4MF-sQVuquwEdwIAprQ>
    <xmx:qsFFak9_nmgYUk3tDD60JlJRv8fhgeuCqDFScdwtPwWYmfaikz7W3A>
    <xmx:qsFFanpN4V9awM7CoGbCoaPcOJSTMyIGUhjM1M8sH2RL6t3pP637KA>
    <xmx:qsFFapAPCoXBINeJGNcHDBEkkSt1AUzpLaoukGQOzF66-F84NSZrWA>
    <xmx:qsFFajRGT6xcqU8ARFmiLKIMfg_4W5V-xqbl7kPTnChjH54y4quePSfs>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 21:40:56 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 10/10] nfsd: reduce want-write range in nfsd4_create_file(
Date: Thu,  2 Jul 2026 11:34:29 +1000
Message-ID: <20260702014000.3397240-11-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22936-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9293D6F2D98

From: NeilBrown <neil@brown.name>

nfsd4_create_file() needs write access to the mount for two purposes:

1/ to create/open the file.
2/ to set attributes on the newly created file.

Normally a file being created would be open for write, and once we have
an active open we have the write access needed for a setattr.
However if a file were created but opened read-only then the setattr
wouldn't necessarily have write access to the mount.

Currently this is all handled by holding the write access across the
open and the setattr.  A subsequent patch will necessarily change how
write access is gained for the open.  So we reduce the range for the
first want_write, and add another one only if setattr is needed on a
read-only open.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 961e0c26e9a2..08e1213de743 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -308,7 +308,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
 	if (IS_ERR(child)) {
 		status = nfserrno(PTR_ERR(child));
-		goto out;
+		goto out_write;
 	}
 	path.dentry = child;
 
@@ -321,16 +321,17 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			end_creating(child);
 			status = nfserrno(PTR_ERR(open->op_filp));
 			open->op_filp = NULL;
-			goto out;
+			goto out_write;
 		}
 
 		open->op_created = open->op_filp->f_mode & FMODE_CREATED;
 	}
 	end_creating(child);
+	fh_drop_write(fhp);
 
 	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
 	if (status != nfs_ok)
-		goto out;
+		goto out_free;
 
 	if (!open->op_created &&
 	    nfsd4_create_is_exclusive(open->op_createmode) &&
@@ -357,7 +358,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 					     !iap->ia_size);
 		} else
 			status = nfserr_exist;
-		goto out;
+		goto out_free;
 	}
 	/* file was created */
 	fh_fill_post_attrs(fhp);
@@ -367,7 +368,24 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		iap->ia_valid &= ~ATTR_SIZE;
 
 	if (is_create_with_attrs(open)) {
-		status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
+		if (((oflags & O_ACCMODE) == O_RDONLY)) {
+				/*
+				 * We will need write access to set the attrs,
+				 * but a successful open won't have provided
+				 * that.
+				 */
+				int host_err = fh_want_write(fhp);
+				if (host_err) {
+					status = nfserrno(host_err);
+				} else {
+					status = nfsd_create_setattr(rqstp, fhp,
+								     resfhp, &attrs);
+					fh_drop_write(fhp);
+				}
+			} else {
+				status = nfsd_create_setattr(rqstp, fhp,
+							     resfhp, &attrs);
+			}
 
 		if (attrs.na_labelerr)
 			open->op_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
@@ -378,11 +396,13 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		if (attrs.na_paclerr)
 			open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
 	}
-out:
-	fh_drop_write(fhp);
 out_free:
 	nfsd_attrs_free(&attrs);
 	return status;
+
+out_write:
+	fh_drop_write(fhp);
+	goto out_free;
 }
 
 /**
-- 
2.50.0.107.gf914562f5916.dirty


