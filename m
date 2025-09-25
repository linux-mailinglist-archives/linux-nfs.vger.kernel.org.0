Return-Path: <linux-nfs+bounces-14701-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24774B9D02F
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 03:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB151BC36CC
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 01:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979411922F6;
	Thu, 25 Sep 2025 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="P5wpAlDB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q2Ou4Z7R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB010A1E
	for <linux-nfs@vger.kernel.org>; Thu, 25 Sep 2025 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763675; cv=none; b=aFLp0YO9BDDctqqA7wv/qI/9BnNdJwIZXtbO7h1ZczhvRgi1UWkqiizxtubYfD5Z7umrGIlqkue3RiisCvWRHVB5c+D7YWJpGjy1U6KZu2nxV+kDb2jM357rHpZW+wWlNNuiOcyBroiF9epkEp4zRSI0BPiy0JRhAlridgTBAIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763675; c=relaxed/simple;
	bh=mHMPOIL0GzlWmRPjkNkgepBSTlmkDKGEn/bLZA+w57Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=ro8KEJHjyCNpg5GWjdXFnP8Sqv9hAbOB3EMEzl5g+/0WQFltYAKZk2hG/OHGT18ZAqZwTCPoNP1OEcHARdwWA6JdXrIF+SlK2RtRS8DrLhHkA2c3TG/MRPIWdO0j+K8brACZpxkZvMB+8M0bqLVXgwKbX8uIQR7VYc2xMvHBoms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=P5wpAlDB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q2Ou4Z7R; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 31857EC01B1;
	Wed, 24 Sep 2025 21:27:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 24 Sep 2025 21:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1758763673; x=
	1758850073; bh=bM2CwQsobxLEqNCVMdKphbx4PMqREG9CD94oZ0XlVg4=; b=P
	5wpAlDBjC2WVAB8jvfe1GPabkebkYU2ERe8AFyKts8OjtEKb4URErQgkqRc85kwJ
	dg1YnzremEL6/2+DRWe+K8FA/0MGC35H8vgsPsE95jmTSeDdVp0rQoEdGLA+TBed
	I+sr9+4lGdIi/84GrYf2xBBhL2Tz8IVArf8sH1Fq9C98ePJCO2eP0o/jDF6F1nmJ
	7E6NEGXx0H6qVVy+xqrqEvHyidAufeEY2A0rl6O6rsVoTHMNy5g7nDdTagIOUdVO
	/m5RRm4NCPTOjuj43D5PtMqWXs/0hqS5mkM+WwZ5+p+aJ5716Hsy99vPWxcg3tn5
	OSYzZbYegmKQaIspvoMFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1758763673; x=1758850073; bh=bM2CwQsobxLEq
	NCVMdKphbx4PMqREG9CD94oZ0XlVg4=; b=Q2Ou4Z7RSNJRCW4AYPyFXqGPuSSbe
	32jN8+d/Dj1Qihy1cTa5LCmrrLqu1apKjuSZUbRLhWDhRVuPIBnwbNGAjoGMeIf+
	R5XstwPR+P8vd8Zs8ZGs27yvNqbeENiTjBlOlQZmO27fzJig3Fmlff6d+Qs/yN21
	9Eqthdk98L/zodddRX+KBW5w926ETgCjMC+7XgdGVbJHFyoAgJB/I1pNAmYXjGc5
	YpN26can0IPWtnjZiGG6y4KvG20aP2FZYE4g/sRtIj+zjxNReCookFTlFDVZSfna
	mQvi/gzUKJEAB0vOv60lCF9i1oDUg0vCdy3BoZCFnyjuwWrRu/KWi/iRg==
X-ME-Sender: <xms:mJrUaOb2nBuhnFaPX1WMY7GWjTZxUQzNDhYKtcPUOJ4HF9YsiWSi2A>
    <xme:mJrUaDrIfdbYl6RIF-hC9pGcfAq5UO0n_huHNha_jD5SY4ShWiCWzy7xjo9hkeK8n
    f_1IuvJ8VpPjqEZ-KoMkgffhv5aRDgIgc97D95vSCpOwgsOpQ>
X-ME-Received: <xmr:mJrUaLM4LiIeUyaR6VaNzEjKwPMTV6XPvpR5ymdv3-WJsObngG1qtJfsQ04qCtJxU6AoWCHyl1rrbCvlTjnfKOlQa8XoOkMekD840HgsLNJx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeihedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefufffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehrohif
    nhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeffhe
    efteettdeiteeutdegveffhffftdehleelffffueejvdelvefgvdfgleelueenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofi
    hnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghv
    sehrvgguhhgrthdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtg
    hlvgdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgt
    phhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghnth
    hirghnshhhuhhovdeffeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mJrUaGpkUiKMvEDNkSnFPuiMxgpaxptFCl2ZhVC91Ru2_GvJB-t1aQ>
    <xmx:mJrUaIfRuGgzu6K-L-sAiTNABmK6eUPsOv_8WYLCECnVl8EQAsAuyg>
    <xmx:mJrUaETgsS9KOnJkMnq3kFlsMddonyKvnbW2EbW72ZiBI9oVPS4hWg>
    <xmx:mJrUaJbww0jcZ2pgw5rxvbKmNA1y7OqElT2Q5kUtUQG5SPELMNUd1w>
    <xmx:mZrUaJbpB2LWEGCPRInJkw0s-dR4J1DYZqBMsRMQEp-MU86QWm2SNX2S>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 21:27:50 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 tianshuo han <hantianshuo233@gmail.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
 Tom Talpey <tom@talpey.com>, Dai Ngo <Dai.Ngo@oracle.com>
Subject: [PATCH] nfsd: fix refcount leak in nfsd_set_fh_dentry()
Date: Thu, 25 Sep 2025 11:27:49 +1000
Message-id: <175876366905.1696783.15284382788363472723@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


From: NeilBrown <neil@brown.name>

nfsd exports a "pseudo root filesystem" which is used by NFSv4 to find
the various exported filesystems using LOOKUP requests from a known root
filehandle.  NFSv3 uses the MOUNT protocol to find those exported
filesystems and so is not given access to the pseudo root filesystem.

If a v3 (or v2) client uses a filehandle from that filesystem,
nfsd_set_fh_dentry() will report an error, but still stores the export
in "struct svc_fh" even though it also drops the reference (exp_put()).
This means that when fh_put() is called an extra reference will be dropped
which can lead to use-after-free and possible denial of service.

Normal NFS usage will not provide a pseudo-root filehandle to a v3
client.  This bug can only be triggered by the client synthesising an
incorrect filehandle.

To fix this we move the assignments to the svc_fh later, after all
possible error cases have been detected.

Reported-and-tested-by: tianshuo han <hantianshuo233@gmail.com>
Fixes: ef7f6c4904d0 ("nfsd: move V4ROOT version check to nfsd_set_fh_dentry()=
")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfsfh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 74cf1f4de174..ed94abdf4f84 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -269,9 +269,6 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, =
struct net *net,
 				dentry);
 	}
=20
-	fhp->fh_dentry =3D dentry;
-	fhp->fh_export =3D exp;
-
 	switch (fhp->fh_maxsize) {
 	case NFS4_FHSIZE:
 		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOATOMIC_ATTR)
@@ -293,6 +290,9 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, =
struct net *net,
 			goto out;
 	}
=20
+	fhp->fh_dentry =3D dentry;
+	fhp->fh_export =3D exp;
+
 	return 0;
 out:
 	exp_put(exp);

base-commit: d0ca0df179c4b21e2a6c4a4fb637aa8fa14575cb
--=20
2.50.0.107.gf914562f5916.dirty


