Return-Path: <linux-nfs+bounces-15782-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07617C1DDE9
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 01:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB373A88F5
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 00:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7122554918;
	Thu, 30 Oct 2025 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="UEmIhiRO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wiX5r4Ki"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6204369A
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783045; cv=none; b=YMCj7HDyHjWiBSK2ww+NyUkzfdeizVAA7mZErIGfZ3Xrklrf1zDjzqzwKxSTHja1sSYb9b3R3O7Q2CUMF/jo8Sc1plO5mITZRATkFXCGhzdDMmzmEos9ZYHHUmFT8Nu4UGodfu7lNxrf71bRUfXnolDVs07naIeSUil+daj1wqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783045; c=relaxed/simple;
	bh=YLLO9S+LZYIwvGjJaSMUdyzCzQ7EZ6hyhPkdUETk8ho=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=mPMZUN0GYC4aQDMOjesOLlnuXJ+C3gtc3ma/j51HCkL8Nn4gwm/ths32H7mYzda+fDfRHzWnVUqdkQ914kdg4ZitDDVpAcUbO0FJcqiggWI1RiaHBTL1EhOq6qg+P9E0tlqzGllXf1XkHY2dO0ah8gIkcv1DEASBfMimw96JMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=UEmIhiRO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wiX5r4Ki; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 04841EC0207;
	Wed, 29 Oct 2025 20:10:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 29 Oct 2025 20:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1761783042; x=1761869442; bh=3fcpKFlCQ4f54sD31iCBE2wp5rMyrZYDNre
	hyU4Fml4=; b=UEmIhiROKEX5l27KszeGHH7KgT6loxCAYqZQxm6ar1+/MjKL9HO
	STprpxSJ8ahIX7enR+/lH9p3rFw1qc0UtOhKL7+kPdBBOebjJcnIK0Y2MkyyC1z8
	I0Go3OpJLJhNEfPxBjmDVhck8sxEkMX2iAaLijOexCBBBaWemGK9SRpZCV6t2JSh
	83uwOKaewYuVHXEDfjsnSBwTPbAFkZO1LUzLoSlt4St9wEqOeM705ChXIFHBxNC/
	Tn5L5Uo0lGBC4xtUhQhi1aS3MeKfCNo6IF75ymV324zt9BpO++yDXL7KvXRX8FnX
	/6R7NAwqVbQ6xnsaIJ4723uphH0eXTo8zWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761783042; x=
	1761869442; bh=3fcpKFlCQ4f54sD31iCBE2wp5rMyrZYDNrehyU4Fml4=; b=w
	iX5r4Ki88IKlxdxVvYtQLZZG2jn9viWBWwxvLsMz3uXQAW29i87jkYU/aOeI+qhH
	J2Q8xnO+5thgqk9e79iisEETlqfJBIM61dORAz/LgDVTFdHxq+e8XsQTZ/VCB4A9
	OJETHeN3NxCsNBP4lpHcOCHhf8dlayCeBE55yssXTRsM3QsSYZ62OO/ncIftd83/
	EKvgh9+f+xbsZqiwHyCWl3f4L+PlpQXm9iNFPfrtZifxF669g8qL0mCVYGgZGxC5
	rL+IyDNTeVo8noCSyTF6PnoUdmiMgSES7+jrCw3fsPrM2u5Jomdb2yfMUkw0Z4Ry
	WL4XQFhD99IY+oErXgVjg==
X-ME-Sender: <xms:Aa0CacUo5G5lf3Ngui0C3HB2xB8lhPoDA8B0d0XKZBEAt8fg2Oa4BA>
    <xme:Aa0CaXkakQKaXHqA0pmcIGVV_pV5CsHpdzTAPH8rTTkeNiCvuqQ5uDq-eP_c8GIqM
    3QsWIga7h-kLWhrvQhaS4YcowCnZcAkkvJ7zg96DHxwdfgF2ls>
X-ME-Received: <xmr:Aa0CaVYJBznGKzH3XMP66zq762KO38mf5m0Q3BfvzRe0BVCAmM_-Oz2eDdw4gi18mS5qVkIQDCtiCMW_k9j_5xzpdLXT9HPqYqbKZeaAbfdY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtkeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdfhgfehkeekiedtleefhefhkeevvdegfffhgfduffeiveelffehlefhfeehveetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    nhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrsggsvghnvgekjeesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:Aa0CaaNLyqLY89ofdhZLB_Rjg0Y9rdcIVzodgs_0Ch4WukWqef_6mg>
    <xmx:Aa0CaSbcm9H6uUd19opiLELlJ4sI62Azt5wWstt2NRrRq3FOldWJjQ>
    <xmx:Aa0CaQ0uxXycHJpFNIrmquLDgINoAqr1pfrGTwYn2T4zvp-nONrxzg>
    <xmx:Aa0CaQddO4n5vt4_fXLGlrzPNraJp5MP7-oYUKdzGdizL9r7lY_duQ>
    <xmx:Aa0CaWLaEnqluvogDCOi197EwGPb9jlF5gDe6LahS00psFtnn4_zw8WX>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 20:10:40 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Trond Myklebust" <trondmy@kernel.org>
Cc: "Anna Schumaker" <anna@kernel.org>, linux-nfs@vger.kernel.org,
 "Stephen Abbene" <sabbene87@gmail.com>
Subject: Re: [PATCH v2 2/2] NFSv2/v3: Fix handling of O_DIRECTORY in
 nfs_atomic_open_v23()
In-reply-to: <17d8613559d9ca7a0bccc918846b180d7e8e5626.camel@kernel.org>
References: =?utf-8?q?=3C03e3a5a82187cfc7936b87ce92ee001b27e18878=2E17616868?=
 =?utf-8?b?MzMuZ2l0LnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+LCA8PiwgPDcz?=
 =?utf-8?q?3195cf9970e6590f556548a18a57dfe6114ab9=2E1761686833=2Egit=2Etrond?=
 =?utf-8?q?=2Emyklebust=40hammerspace=2Ecom=3E=2C?=
 <176168923910.1793333.9587671564912340853@noble.neil.brown.name>,
 <17d8613559d9ca7a0bccc918846b180d7e8e5626.camel@kernel.org>
Date: Thu, 30 Oct 2025 11:10:38 +1100
Message-id: <176178303849.1793333.12994870459584817385@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 30 Oct 2025, Trond Myklebust wrote:
> On Wed, 2025-10-29 at 09:07 +1100, NeilBrown wrote:
> > On Wed, 29 Oct 2025, Trond Myklebust wrote:
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > 
> > > If the application sets the O_DIRECTORY flag, and tries to open a
> > > regular file, the correct response is to return -ENOTDIR as is done
> > > in
> > > the NFSv4 atomic open case.
> > > 
> > > Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle
> > > O_TRUNC correctly.")
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > ---
> > >  fs/nfs/dir.c | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > > index ea9f6ca8f30f..dedd12cc1fc8 100644
> > > --- a/fs/nfs/dir.c
> > > +++ b/fs/nfs/dir.c
> > > @@ -2259,6 +2259,7 @@ int nfs_atomic_open_v23(struct inode *dir,
> > > struct dentry *dentry,
> > >  			umode_t mode)
> > >  {
> > >  	struct dentry *res = NULL;
> > > +	struct inode *inode;
> > >  	/* Same as look+open from lookup_open(), but with
> > > different O_TRUNC
> > >  	 * handling.
> > >  	 */
> > > @@ -2267,7 +2268,7 @@ int nfs_atomic_open_v23(struct inode *dir,
> > > struct dentry *dentry,
> > >  	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
> > >  		return -ENAMETOOLONG;
> > >  
> > > -	if (open_flags & O_CREAT) {
> > > +	if ((open_flags & O_CREAT) && !(open_flags & O_DIRECTORY))
> > > {
> > 
> > Since 
> > Commit: 43b450632676 ("open: return EINVAL for O_DIRECTORY |
> > O_CREAT")
> > 
> > the new test is redundant.  Doesn't hurt for documentation purposes
> > though.
> > 
> > >  		error = nfs_do_create(dir, dentry, mode,
> > > open_flags);
> > >  		if (!error) {
> > >  			file->f_mode |= FMODE_CREATED;
> > > @@ -2275,12 +2276,27 @@ int nfs_atomic_open_v23(struct inode *dir,
> > > struct dentry *dentry,
> > >  		} else if (error != -EEXIST || open_flags &
> > > O_EXCL)
> > >  			return error;
> > >  	}
> > > +
> > >  	if (d_in_lookup(dentry)) {
> > >  		/* The only flags nfs_lookup considers are
> > >  		 * LOOKUP_EXCL and LOOKUP_RENAME_TARGET, and
> > >  		 * we want those to be zero so the lookup isn't
> > > skipped.
> > >  		 */
> > >  		res = nfs_lookup(dir, dentry, 0);
> > > +		if (!res) {
> > > +			inode = d_inode(dentry);
> > > +			if ((open_flags & O_DIRECTORY) && inode &&
> > > +			    !(S_ISDIR(inode->i_mode) ||
> > > S_ISLNK(inode->i_mode)))
> > > +				res = ERR_PTR(-ENOTDIR);
> > > +		} else if (!IS_ERR(res)) {
> > > +			inode = d_inode(res);
> > > +			if ((open_flags & O_DIRECTORY) && inode &&
> > > +			    !(S_ISDIR(inode->i_mode) ||
> > > +			      S_ISLNK(inode->i_mode))) {
> > > +				dput(res);
> > > +				res = ERR_PTR(-ENOTDIR);
> > > +			}
> > 
> > I think do_open() in namei.c provides these checks
> > 
> > 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd-
> > >path.dentry))
> > 		return -ENOTDIR;
> > 
> > Does this patch add something not covered there?
> 
> I was looking at the issues around CVE-2022-24448.
> After spending the night looking again at the original syzkaller
> report, I'm thinking I may have misread what was going on there.

I couldn't find any public report of the bug that lead to that CVE.
If you happen to have a link I'd be curious to see it, but don't try too
hard to find it.

> 
> In the end, I'm wondering if that issue may actually have been fixed by
> commit 17b985def2a8 ("nfs: use locks_inode_context helper").
> 
> So yes, perhaps we should just drop this patch for now.

I agree that is likely best for now.

Thanks,
NeilBrown


