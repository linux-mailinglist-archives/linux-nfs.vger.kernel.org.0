Return-Path: <linux-nfs+bounces-21126-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKvcIYba7mkPygAAu9opvQ
	(envelope-from <linux-nfs+bounces-21126-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:39:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F03D646C7E3
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2AB7301F192
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 03:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C29B35E95A;
	Mon, 27 Apr 2026 03:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="LCsmTDrF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RhtU6zx2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04035E92B;
	Mon, 27 Apr 2026 03:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261063; cv=none; b=IViSKUt5Ge/NReCAbdq7twG+rmOer5rVFJ/BkTe3jqiQbaOgQ0gZyMlPg2NNs5Gmti48beJWYG8k0LXFyIgBLKeh5owPsf9U46mURWeS4zqWgSqOgFZXBPCAab4T1hFriyECOFaQzdrGQASpqA5OfEDK9IPewZAansVUmB5sTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261063; c=relaxed/simple;
	bh=DFrp9NHxbOh7DcW+macG4cAgQAoWvIrKkUHLuu82auc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoC6og61RYgI/Nw210h0bLj9HeN3xnky62i+bgDLRNEjlk6SdtKGaaPToyB3STJMhFBsb8boxBhhuK9yMpjpUzd3eVh5VSFBW5BZRdmD8N6TwGR+UVdCcVdArUiHWnN/efGTDkZ/mdzHMSQb/L/64POAUzSZwRl3DZaLGFAE6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=LCsmTDrF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RhtU6zx2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6366E14000E4;
	Sun, 26 Apr 2026 23:37:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 26 Apr 2026 23:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777261061;
	 x=1777347461; bh=/lh7HUK0TKvg2/UYrerSNegrbJ1j2gtRpk+NrmqwPSE=; b=
	LCsmTDrFxdUWMXRL4kyDcxXMHU5cnuIewJE8/mPtqFISayX0WwERaPrSIIWvObur
	Yy3tzMX8Lf/bXsWMCf6qC/UYjktT/iWJx8NRfqZ7gX/0AjOsNbKPZNb89BShIHLY
	bZUtTLZ3kdt+xUdGf8k1ohsaINMxJrrftJgyUeQmds6YAdCulcPFHcK+lumGf7Qz
	KX6OpNuqgo6QewpGGBBdGja5urVYwZG/qayRDZjtRzjBWTbWWony24lGV2VJb3tY
	yqJ8Z9nd7/qMmi3tnsHSMMS4ffEGeAiSdRTtGmEGkk29I8WPNsi1B6FFQ7LGctll
	C5Evyb3u4r4rQ2rVgOeeDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777261061; x=1777347461; bh=/
	lh7HUK0TKvg2/UYrerSNegrbJ1j2gtRpk+NrmqwPSE=; b=RhtU6zx20cUI/BE/A
	KSWkmcLAJdSkGVsHXtyR1yPChuyUeHCDbYBg9C8XaK/tsTBFO2y1hKBMP6c2ELMJ
	teKefEzFYhG+3u2tf2cebUIiS92ZalwR3k9UsxZh7NWRpldeOLW84v0/u0sA/E1y
	RQPaOttBs65bvicLGGkeeg9gU6mK7roPdFg+Q2qu0jeEjKt3JUwGgmKn8RnpB5mA
	c2U7h3TuuFKs50uaGR5YeJdzISIqXbb6yNXo5/Lll1/31M7rdXgZNwR5wb8gKNq/
	HfCgUiCH5cffEH0WO/MAMA1UnKGlUZsYKQqFHX8e/vSPmYnHogzm+Pdw5/mJqDvZ
	C5p9w==
X-ME-Sender: <xms:BdruaeL2mwBbdYGxIOYeFll14MBuzhkBDMgIgciJUw_JWaybAWpdGA>
    <xme:BdruaQ0DNRkc9Z2XHjB5-31tkEjOMwIKZ00HfBsABJI4rHGsvj1ktFR0s1H_jj1cM
    _jUZBa1ci2QbuKAUwkd5kQXs7Qs339bE8duPXkoEVpVLyQA9Q>
X-ME-Received: <xmr:BdruaVWtC3_5Q-a7YVci7adwGnpPzHxu8qjkOIkUZP77XrxdZREGtaE8FSAai4QpGmDrTEAuvJJQ03Bgk4d5KNEm960W7ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdprhgtphht
    thhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtghksehsuh
    hsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:BdruaeXGN7P-W5nXt0zxF_NhocNvdoAv4HOWDHSRT3RDXVxP3silFQ>
    <xmx:BdruaQGNLKd8mmwJyy2gHbXFppG3qt_yMUcb3xASGO1WQbS0SXhEWA>
    <xmx:BdruaauGrXFNaNmrxIcs3OA4NX1vu8S7v9h3kjplBCy3vO4K8JK7mw>
    <xmx:BdruaTa4OlnQRF4F-fLwNR1H9seKhLBDUsiFYJRMuTydR6Bu-mG6BA>
    <xmx:BdruaeIAfrjkoqg8idBDUR3usMf9OGVa1pkEKS3-EKvMq4jX7uYj2tgi>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 23:37:36 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel
Subject: [PATCH v2 12/19] shmem: use d_duplicate()
Date: Mon, 27 Apr 2026 13:29:45 +1000
Message-ID: <20260427033527.773006-13-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260427033527.773006-1-neilb@ownmail.net>
References: <20260427033527.773006-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F03D646C7E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21126-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:dkim,ownmail.net:mid,brown.name:replyto,brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]

From: NeilBrown <neil@brown.name>

To prepare for d_alloc_parallel() being permitted without a directory
lock, use d_duplicate() when duplicating a dentry in order to create a
whiteout.

Signed-off-by: NeilBrown <neil@brown.name>
---
 mm/shmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 3b5dc21b323c..8b0d2340dee7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4006,11 +4006,12 @@ static int shmem_whiteout(struct mnt_idmap *idmap,
 	struct dentry *whiteout;
 	int error;
 
-	whiteout = d_alloc(old_dentry->d_parent, &old_dentry->d_name);
+	whiteout = d_duplicate(old_dentry);
 	if (!whiteout)
 		return -ENOMEM;
 	error = shmem_mknod(idmap, old_dir, whiteout,
 			    S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
+	d_lookup_done(whiteout);
 	dput(whiteout);
 	return error;
 }
-- 
2.50.0.107.gf914562f5916.dirty


