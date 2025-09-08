Return-Path: <linux-nfs+bounces-14119-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6F7B4823D
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 03:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D1B3A1BDC
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 01:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E0D1A3167;
	Mon,  8 Sep 2025 01:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="djJiYl0v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Msrn4TOm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA615667D
	for <linux-nfs@vger.kernel.org>; Mon,  8 Sep 2025 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757295459; cv=none; b=SwoluYdkueYSaZyYK5opcOPjJW67hpNnM1D+ZAFnoSujWDS5VLQfZM2eoQoNE7hkkf3NmMDhNne1MadnyzCSSfJb2MEC91SaBheuRsGeRFLjtjuCM0iW25YtFJ4Ob3wOtSvMcrYlbT/vi8xMDCXVN5zbEKkGWb+ek4er8CPfWVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757295459; c=relaxed/simple;
	bh=o1rX0RHanDoUdxievtqHKdJlXK0U9vej9tCHjeNLLpA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=g2GcfMTj2S5WDFAeFL6Y/nRhFHeWPUgYa/11wZk4VuYQOflFsDicpTtJYV3C/WmW2IRGWGU3YLRsXxnZZk3XARzKXjdzBG0UMjVUwLtN84zZ+LsAkNUzXr3TMVJldFJ+xXQAMV8V1ZvZH6ovZXQDBRBzUxti/hkaRyALomVZ9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=djJiYl0v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Msrn4TOm; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0123F14000C8;
	Sun,  7 Sep 2025 21:37:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 07 Sep 2025 21:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1757295455; x=1757381855; bh=SR
	zhswgRwDZnnlqx367qlIO9ygY+0q2SZghVWNWG40M=; b=djJiYl0vyRwSXGheKc
	OPRqAwl0hGa1m0jBpLxRU5xxZU7JpweiAV63Jp9f4cTsixjqiRlxqSE/vu2bkQsd
	lfL5vZTm9R+sImYaQfJxPPGAdcEO4p2kFR519hTdIUwi0NmozIIIA1K37siQSLkA
	x+Yp181iTki3pIaD1aIrTHvQiQrC1OfkKrqmOHy/W30J6N1pjenE+GAuugl9enYV
	8PpQ3kBVfTkfXI1wZOpDR49cfULCph+65hrKdV0MB423amyBGIGVpbKMD2jtnn0Y
	FNYzgdrFVy1LFWW0zjQbtsB+ChlvEExbxo5iGYxW57PYB/1xlu0y+r+Obyclb0/8
	Qu2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1757295455; x=1757381855; bh=SRzhswgRwDZnnlqx367qlIO9ygY+
	0q2SZghVWNWG40M=; b=Msrn4TOmUHfWEVPI9+vv4CNYauaKbJLWW9Zc0S3aPRRS
	BJAI3XggCw8j8bCisMF3JLy3QtyoZuzNwePVN8GAjsG92pD+l1tI8DEwvfdcVGjg
	8YEOc3yobfiPibp0jXgmskTj+A3EP2jBM6C0WbeafEPGpvLVeJjvBp2Xsd0oHbqe
	spIY9lA1mmxrGXIm0KwSqeg8uODgI/iss1UstAF5Z7k3tRdfn39P5/efqYAztHSN
	RMxUom/NPP1OBMTurIDXVXTgz9Wul4B/JxkX0eqyEKSTxH60hAYr2PeX3LLNAMLJ
	DUQ4FhdKAMgoWG/tUXnPa/mb7OnOaR2VVLclONadMA==
X-ME-Sender: <xms:XzO-aGOtbhRci1GbTmfhassmK5vBu-EhNBgSMWbGffHa9lT4z8z2aw>
    <xme:XzO-aNYf7hxHl7Ddfy35NglRuqGc6HnX-0nD_fzK22WwCQ1g04Zp3y435TvaqaI9z
    K9pflzY5q3DbQ>
X-ME-Received: <xmr:XzO-aNtBMxPljWLzHt8EDG1FsyjHVRg3SsDoGWmt6eR0evDl22pEFOgVmmkBnPfnBGSvlLFVA3HqM5ugdVUZOQr8pDdeCUy5sWggGKwj2Cb8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefufffksehtqhertddttdejnecuhfhrohhmpefpvghilheurhhofihn
    uceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepieeiud
    ffheejkeetleefkeevfeejgfdugfdttdeljeelgeegheduudegteekieeunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnh
    hmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhnihgvvhes
    rhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghp
    thhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XzO-aHObV0B4CTeC62nk1ylAsCpKyG1rG9HmL-nBYFS_agbkObglZw>
    <xmx:XzO-aM6gKrJVIWsx8SvQlh73nM-uA4DMfkXemGjL3ZbkCzL4e4rcRQ>
    <xmx:XzO-aFQCkBhRczoRw3c-P4_wGtmdq3BImOAXfnpF4ekWDrh_I_AioQ>
    <xmx:XzO-aBB6ptMe1r3Kr6_yLOOlEO60E7xKFjUIFsKSdWjFmFjsfuP9LQ>
    <xmx:XzO-aHaaxsRfDvX7UTXXoJ1rlfw-y4fzGZoojHphICwQ84P-fhCLPuoq>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:37:33 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: discard nfserr_dropit
Date: Mon, 08 Sep 2025 11:37:25 +1000
Message-id: <175729544562.2850467.751680410529802310@noble.neil.brown.name>


From: NeilBrown <neil@brown.name>

nfserr_dropit hasn't been used for over a decade, since rq_dropme and
the RQ_DROPME were introduced.

Time to get rid of it completely.

Signed-off-by: NeilBrown <neil@brown.name>
---

This version updated fo recent changes to fs/nfsd/lockd.c

 fs/nfsd/lockd.c | 2 --
 fs/nfsd/nfsd.h  | 8 +-------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 6b042218668b..c774ce9aa296 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -71,8 +71,6 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct =
file **filp,
 		 * to callback when the delegation is returned but might
 		 * not have a proper lock request to block on.
 		 */
-		fallthrough;
-	case nfserr_dropit:
 		return nlm_drop_reply;
 	case nfserr_stale:
 		return nlm_stale_fh;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 1cd0bed57bc2..06e8327255f8 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -335,14 +335,8 @@ void		nfsd_lockd_shutdown(void);
  * cannot conflict with any existing be32 nfserr value.
  */
 enum {
-	NFSERR_DROPIT =3D NFS4ERR_FIRST_FREE,
-/* if a request fails due to kmalloc failure, it gets dropped.
- *  Client should resend eventually
- */
-#define	nfserr_dropit		cpu_to_be32(NFSERR_DROPIT)
-
 /* end-of-file indicator in readdir */
-	NFSERR_EOF,
+	NFSERR_EOF =3D NFS4ERR_FIRST_FREE,
 #define	nfserr_eof		cpu_to_be32(NFSERR_EOF)
=20
 /* replay detected */

base-commit: b8cf39957931982091e6446a98f151a79aeea07b
--=20
2.50.0.107.gf914562f5916.dirty


