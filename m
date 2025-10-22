Return-Path: <linux-nfs+bounces-15545-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66319BFE5F5
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 00:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02213A8274
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 22:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4549430595A;
	Wed, 22 Oct 2025 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="rltFbIAm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wxf+kp9I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1CC2D0601
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170830; cv=none; b=lLp7nF/gUeSibBHHAHCumHDHv9XiHNdMirYN659APxhDPWVLEeonBnTOtNZ8bBq3WYAa5exBf6Mb/ZbzH8jykGjPgtS5hMSDruY6TC6dwIkENXUoWOcKwoqq+F//p3w3392F6wGXVx3bfWpKLTqB4YGO3ZaohTmbGnWaUVr5Oww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170830; c=relaxed/simple;
	bh=7iDaYVh/4vb3nl6I+l/Y2Vhv9qEQWW+FRAy/1zYeStg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jmY7VQrUKoD/jdcclMEPK38qYI0PV4nNbzMADGW8IuJP4m35JJOvSz90+aR8712KryrPa2PeqbMbjY1fHwQ4yTaESGaMBvqVNH1imsWlmHdz1h59TZUdqXAr7WBaDs2Mz9UZQrrD92044zGuvawBn+CeAh4KAOvSx9+a8qat/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=rltFbIAm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wxf+kp9I; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3ED48EC01F4;
	Wed, 22 Oct 2025 18:07:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 22 Oct 2025 18:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1761170827; x=1761257227; bh=uwSyQGFZkJVUZtGxRIUh4iVPLbJ6JTOoPkG
	igsBxWfo=; b=rltFbIAmHxTeSYJW1QfkxPaVl9KongKwUquMsO8d6yJaedSnKjh
	a/OqHlBtvPX0NMqZo1zy9TKYxp5PfcRfFW75Pf+X+93tXBU7xNiI5Bj/NjRW04W6
	eRi3fR4i3Cndxo64UO2SaO0IuNh5IvW8V1rBn2DHGBLrdaWmboza0ZWheHHZQoPR
	LLEKByQMXrx+L6+fsC+cekChn5+IZdx7U0YnFi7VQJCICI0YreYpAcv7ILfzjSId
	pWy0tp8mHi8jHPID7hsNoPURRD6W2Ye/GT4/mH2SkMCg2+WzkO4tzfyvVtESrvdu
	7G+s3zaJv3yqyqYx9kyQaLMGjv/FhFFYh9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761170827; x=
	1761257227; bh=uwSyQGFZkJVUZtGxRIUh4iVPLbJ6JTOoPkGigsBxWfo=; b=W
	xf+kp9IXqlHiNKtT7jjzcPtHoQySUrp55J1H4XOrLfaBkBAHAVd8LbXJMYfx6SmT
	WoyRd2angFX3fmYU7S+jPrgfA+peIwgnOqGNaPTPV3bVnLg5B3KkAwXjMcmNdQGM
	Q0rHggIQzUgC7qXM/pUMCMvEPTr+vo5Bocj5gvx7LWWKioxpoNY+a9FtNfk9DKzU
	9qvz8z2wBWx85JZiD7XCbycgV4mfeeAxJBXBgoxSVR4f9bvTrD85NlazamRyAUtZ
	IG7r+1h5sM5EQ2uUF51ufGe0pYB9sWQrwPir9zRbJa8pTgOcFyMnQkzXs5RP5IMu
	RW78x/KLMcqZG3XQzPm6g==
X-ME-Sender: <xms:ilX5aIzueLAcHkmIKYZ3oyeKrVEyRTUtDneWyWp18xyVnGs-cQhzNA>
    <xme:ilX5aLVUSKkhfhl92841885fj4Km6qw1NEmyibmzf57w6QygwkFyLcctrEKNFAXdG
    acfn51S3UXabkObthuskKLdbTnY4jI2bmmpKRk7I4pk0kn-Jw>
X-ME-Received: <xmr:ilX5aAhtT7AKVLF2uGCA-rqbj_qZgmpXEa_FExuy5HE8SeEAP90ItZTP4V333a7pKo4Z22x5sONbZpMcNuM_WynLkCvBbjul-oZp1vahmz5i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrghhlohesuhhmihgthhdrvgguuhdprhgtphhtthhopehtohhmseht
    rghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghp
    thhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihth
    honheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvihhlsgessghrohifnhdrnhgr
    mhgv
X-ME-Proxy: <xmx:ilX5aDC6D1YjsqTk1fdZYAPLDZrlCJQdSpb7wjOdCh4-FyEpHYb37g>
    <xmx:ilX5aOv0dzKmQgxd61DYr1iAWe2nZlB1HhAIPR7QeHfm2IyyHneBAw>
    <xmx:ilX5aPdnerYIxr2Djhu6SEbSzOTNRXv3BDWhS0y-ud2bsbbn2Xdqpg>
    <xmx:ilX5aL9-_TdT7u0zlXhAwGagyYeHknJIwtZopY7apqzwL9r5LhPPgQ>
    <xmx:i1X5aPjuK5rn2PVNvvb8pK9RYSHerlL-pgKgpmkTd3cVfUv5uhln6Fl6>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 18:07:04 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Olga Kornievskaia" <aglo@umich.edu>,
 "Olga Kornievskaia" <okorniev@redhat.com>, chuck.lever@oracle.com,
 linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com,
 tom@talpey.com
Subject:
 Re: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in reexport NLM
In-reply-to: <176116947850.1793333.1787478761707441526@noble.neil.brown.name>
References: <20251021130506.45065-1-okorniev@redhat.com>, <>,
 <33ba39d2ff01eb0e52c80aa7015d27e34dde7fd2.camel@kernel.org>, <>,
 <CAN-5tyEuV2UO17w97b8weJUQR7hgqX=jz-kvGR9Sr_m3NZp8ww@mail.gmail.com>, <>,
 <d0a1a1ccec73ee56e614b91c4a75941f557398b8.camel@kernel.org>, <>,
 <CAN-5tyGK4MHgYaN1SqpygtvWM8BFrapT-rXY_y9msVfnRjN1Jw@mail.gmail.com>, <>,
 <ff353db93ca47b8fae530695ea44c0a34cd40af8.camel@kernel.org>, <>,
 <fe1489b3c55bdb32cd7ad460a2403bc23abdde81.camel@kernel.org>, <>,
 <f61025a96df19c64ba372cdcab8b12f3fa2fff9e.camel@kernel.org>, <>,
 <CAN-5tyFWvP2ZTeYFN6ybGoxvsAw=TKFJAo0dVLU_=s_5t=LCGg@mail.gmail.com>, <>,
 <f5073caf3e3db05702ed196042053fc864645750.camel@kernel.org>,
 <176116947850.1793333.1787478761707441526@noble.neil.brown.name>
Date: Thu, 23 Oct 2025 09:07:02 +1100
Message-id: <176117082245.1793333.17674071855376444924@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 23 Oct 2025, NeilBrown wrote:
> On Thu, 23 Oct 2025, Jeff Layton wrote:
> >=20
> > Longer term, I think Neil is right and we probably need to fix
> > vfs_test_lock and the lock inode_operation to take a separate conflock
> > for testlock purposes. That's a bigger change though (particularly the
> > ->lock operations).
>=20
> Thanks.  But in the shorter term I'd like to suggest this.

Then again ..  I'm less convinced about the separate conflock for
vfs_test_lock() and friends.  However adding this to my previous patch
would be good I think.

diff --git a/fs/locks.c b/fs/locks.c
index 04a3f0e20724..200a31e3c4b8 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2188,10 +2188,12 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int=
, cmd)
  * @fl: The lock to test; also used to hold result
  *
  * Returns -ERRNO on failure.  Indicates presence of conflicting lock by
- * setting conf->fl_type to something other than F_UNLCK.
+ * setting fl->fl_type to something other than F_UNLCK.
+ * Both fl_lmops and fl_ops in @fl must be NULL.
  */
 int vfs_test_lock(struct file *filp, struct file_lock *fl)
 {
+	WARN_ON_ONCE(fl->fl_ops || fl->fl_lmops);
 	WARN_ON_ONCE(filp !=3D fl->c.flc_file);
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, F_GETLK, fl);

Also I think it would clean code a lot if we splice the "lock"
file_operation into set_lock, get_lock, and remove_lock (or similar).
It would make grepping easier too.

NeilBrown

