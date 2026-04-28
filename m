Return-Path: <linux-nfs+bounces-21204-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HkEA1D+72l9NAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21204-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 02:24:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A599947C1E5
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 02:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18824302B772
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 00:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2C0207DF7;
	Tue, 28 Apr 2026 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="aaP0wG51";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d61f4ZKX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6C1E9B35;
	Tue, 28 Apr 2026 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335883; cv=none; b=W14w61g5zoCf3gsZdUNUlIgWzaBRyB/Q0fhCBDeMgqXLvtYNte2H/Sj+DBHvv8PDCp470dh3ueSpArc1nRv729dAM0rXiRDko+BY6yb3kiu9h86XPaBsjGNu/FJXKgBcHFSXjAkaj4LG1bMGDGr37BZt2hwDaedZizkMYP3ysNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335883; c=relaxed/simple;
	bh=REv3CDVyau96mJCCHO0ASpVwwxehWFoaz66wrjUNGNg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=j0bTtwIsxugmFnhzQKtBPov4+aR5JsZDQWc7N8JHFKTywuIr0MJ186HgWZCw/fCDrFRDEsvJvbtQwPmNdLdEMbCHzNMVetFaH5p7i47x8lCJ8Glw40HDKTFjSMnxXt488wq7h/NZiYhayhsxzb3KSTRnblONusaKxmr4zFs9d3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=aaP0wG51; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d61f4ZKX; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 8A3C81D001A8;
	Mon, 27 Apr 2026 20:24:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 27 Apr 2026 20:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1777335880; x=1777422280; bh=lw20G/Xq3f+4QmdtDcYNKNeP+/uFuFD+PMI
	kxiuWaQw=; b=aaP0wG51gQS9HOjOp0WH3V5jIyQqDBtSc3+/4bR35hxeLm8+z0r
	C5NmHx+DeYh8dbhnHE5dy8Q1JawceKlzuLmvsO7BB8ensCnWPtd65jWmdHpEKT8u
	PxIsCiCEy6u+EW5vOptuzk90OTxYD0aOg2Wl2F8RENarSFKgO6phkCKP3sc+3qfS
	ZTIfZpyGNAWwxd+mfki60+L4g8fEPCjFqH2EWw2hBGf631U7z2kq107z+n8cpnyu
	rCvwDGXS1XEAoJ7hGK+rzXLtAMXyvS21b+y7hgaBtUbBe7Y31Sfw4E70jhYvciLc
	Qms4XYGHgNRXui5VckzMlrfiFFQ3b2J2OdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777335880; x=
	1777422280; bh=lw20G/Xq3f+4QmdtDcYNKNeP+/uFuFD+PMIkxiuWaQw=; b=d
	61f4ZKX37OKkF16uUiqu2Qf3HJZ+4k+WTUfY7NzxDC8BdQhOmWtbWHyOqO5IVNUr
	EsCJMDd5MRuj80C/iaWVo0gxWTTYtZz4IQQhTAmPnpgRRh3HrpKfQwQxVhMtdKBT
	fdfAEAmLZpAG4d49ZEyN6u5TiwQIdYdKSqeTcaqlv1s3fwgiDkE4x7wIXtAaITDM
	nzEAQiqkYYGNfqc30ONSjA3vBnmga0KG2K28ykGhc50snUltGbizNcJbn7cqWr8N
	VIokladTvKN0m+/i6xfZLotc2MYOWoGOKYw1O45N5iXlOg2dFhWl8z143L8lZ3e1
	5c1oaP+5QdYk+LYA4khEw==
X-ME-Sender: <xms:R_7vaY3pi-DgdhUVNwsELaQPTjATMQeQME_nWP2Ky8W-20Un5fI_kg>
    <xme:R_7vaXPBWJ1Ju-I9X4pQFBW_paGsUEXh-GRerAyRcyl78luExPRxERYlWNBnTXLvd
    oDfHigBtvmlUzSG3eUq5jk78MvhdB89QVR61x7VAAzf9dio4g>
X-ME-Received: <xmr:R_7vad5u4BUn4iRT-jN_cJs4tvEynt2996aFfoG_sPzZiv3McrMGswH9tetfWIr1HkqycBjoEISu0INRRHvERtIQg9cKoWk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektdduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:R_7vacZEtG8QoZG5PRoaM6cBhoVEIbhg9rYuKE9YOUFhLFw0KVYhBg>
    <xmx:R_7vaSEFucJXrpw5grQRXWzHhOESwgJAvfevhksHDoffLj1bRZccKQ>
    <xmx:R_7vadmHjogBUoTikuVsjz5-Z-oF4XTTzxr5sz6uiZf0q2JQJx2B9w>
    <xmx:R_7vaRlp8TlzPDpVQzE2iqggIZzbSjsLuErbn17BB8dNadstrR8lgA>
    <xmx:SP7vaZLWRIRxAplg7fpxcTvRVXljectY5Vn0Ok49E2tqOsqjZfe4Phnb>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 20:24:35 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Jeremy Kerr" <jk@ozlabs.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/19] ovl: stop using lookup_one() in iterate_shared()
 handling.
In-reply-to:
 <CAOQ4uxidCcGpABkCtkn94i3U_u3OWK16zeAVDG2xuhh5e+ws9g@mail.gmail.com>
References: <20260427040517.828226-1-neilb@ownmail.net>
  <20260427040517.828226-10-neilb@ownmail.net>
  <CAOQ4uxidCcGpABkCtkn94i3U_u3OWK16zeAVDG2xuhh5e+ws9g@mail.gmail.com>
Date: Tue, 28 Apr 2026 10:24:32 +1000
Message-id: <177733587210.1474915.5770075726707338974@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: A599947C1E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21204-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,ownmail.net:dkim,ownmail.net:email,brown.name:replyto,brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 27 Apr 2026, Amir Goldstein wrote:
> On Mon, Apr 27, 2026 at 6:07=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > lookup_one() is expected to be removed as it does not fit well with
> > proposed changes to directory locking.
> > Specifically d_alloc_parallel() will be ordered outside of i_rwsem
> > and as iterate_shared() is called with i_rwsem held it is not safe
> > to call d_alloc_parallel().
> >
> > We can instead call d_alloc_noblock() and then call the ->lookup, but
> > that can fail if there is a lookup attempt concurrent with the
> > readdir().
> >
> > ovl cannot afford for the lookup to fail as that could produce incorrect
> > results, and it cannot safely drop i_rwsem temporarily and that could
> > introduce races with handling of the directory cache.
> >
> > Instead we rely on the fact that ovl_iterate() has an exclusive lock on
> > the directory, so any concurrent lookup will wait for the ovl_iterate()
> > call to complete.  We allocate a separate dentry and if the lookup is
> > successful, it is hashed with the result.
> >
> > When the concurrent lookup gets i_rwsem it mustn't do its own lookup -
> > it must use the existing dentry.  This is found, if it exists, using
> > try_lookup_noperm().
>=20
> Hi Niel,
>=20
> One nit about the subject -
> Please change it to "ovl: stop using lookup_one() in ovl_iterate()"

That's reasonable.  And that for providing Claude's reflections.  All
fixed.

Thanks,
NeilBrown


>=20
> Apart from that, I let Claude do the review, because it has surpassed
> my abilities in reviewing such subtle api changes.
>=20
> I will copy its output verbatim, if for nothing else, to encourage you
> to start applying Claude review before sending out your patches...
>=20
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/namei.c   | 12 ++++++++++++
> >  fs/overlayfs/readdir.c | 24 ++++++++++++++++++++++--
> >  2 files changed, 34 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> > index ca899fdfaafd..69032eb2b1e2 100644
> > --- a/fs/overlayfs/namei.c
> > +++ b/fs/overlayfs/namei.c
> > @@ -1385,6 +1385,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct=
 dentry *dentry,
> >         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> >         struct ovl_entry *poe =3D OVL_E(dentry->d_parent);
> >         bool check_redirect =3D (ovl_redirect_follow(ofs) || ofs->numdata=
layer);
> > +       struct dentry *alias;
> >         int err;
> >         struct ovl_lookup_ctx ctx =3D {
> >                 .dentry =3D dentry,
> > @@ -1399,6 +1400,17 @@ struct dentry *ovl_lookup(struct inode *dir, struc=
t dentry *dentry,
> >         if (dentry->d_name.len > ofs->namelen)
> >                 return ERR_PTR(-ENAMETOOLONG);
> >
> > +       /*
> > +        * The existance of this in-lookup dentry might have forced
>=20
> "existance" should be "existence" in the namei.c comment
>=20
> > +        * readdir to do the lookup with a new dentry.  If so we must
> > +        * return that one.
> > +        */
> > +       alias =3D try_lookup_noperm(&QSTR_LEN(dentry->d_name.name,
> > +                                           dentry->d_name.len),
> > +                                 dentry->d_parent);
> > +       if (alias && !IS_ERR(alias))
> > +               return alias;
> > +
> >         with_ovl_creds(dentry->d_sb)
> >                 err =3D ovl_lookup_layers(&ctx, &d);
> >
> > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > index 1dcc75b3a90f..e03b32491941 100644
> > --- a/fs/overlayfs/readdir.c
> > +++ b/fs/overlayfs/readdir.c
> > @@ -574,8 +574,28 @@ static int ovl_cache_update(const struct path *path,=
 struct ovl_cache_entry *p,
> >                 }
> >         }
> >         /* This checks also for xwhiteouts */
> > -       this =3D lookup_one(mnt_idmap(path->mnt), &QSTR_LEN(p->name, p->l=
en), dir);
> > -       if (IS_ERR_OR_NULL(this) || !this->d_inode) {
> > +       this =3D d_alloc_noblock(dir, &QSTR_LEN(p->name, p->len));
> > +       if (this =3D=3D ERR_PTR(-EWOULDBLOCK)) {
> > +               /*
> > +                * Some other thead is looking up this name and will
>=20
> "thead" should be "thread" in the readdir.c comment
>=20
> > +                * block on i_rwsem before it can complete the lookup.
> > +                * We will do the lookup in a new dentry and when that
> > +                * lookup gets a turn it will find and return this
> > +                * dentry.
> > +                */
> > +               this =3D d_alloc_name(dir, p->name);
>=20
> Claude suggests this as the simplest fix to NULL deref bug below:
>                     if (!this)
>                             this =3D ERR_PTR(-ENOMEM);
>=20
> > +       }
> > +       if (!IS_ERR(this) && !d_unhashed(this)) {
> > +               /* Either we got an in-lookup or we made our own unhashed=
 */
>=20
> The condition should be d_unhashed(this) (without !), matching the comment
> which says "Either we got an in-lookup or we made our own unhashed".
>=20
> d_alloc_name() calls d_alloc() which returns NULL on allocation failure.
> The original code checked IS_ERR_OR_NULL(this), but the new code only
> checks IS_ERR(this). A NULL this would pass the !IS_ERR(this) check and
> then crash on !d_unhashed(this) (or d_unhashed(this) with the fix).
>=20
> > +               struct dentry *alias =3D ovl_lookup(dir->d_inode, this, 0=
);
> > +
> > +               if (alias) {
> > +                       d_lookup_done(this);
> > +                       dput(this);
> > +                       this =3D alias;
> > +               }
> > +       }
> > +       if (IS_ERR(this) || !this->d_inode) {
> >                 /* Mark a stale entry */
> >                 p->is_whiteout =3D true;
> >                 if (IS_ERR(this)) {
> > --
>=20
> Claude (Opus 4.6) review summary:
>=20
> The patch has a critical condition inversion (!d_unhashed vs d_unhashed)
> that would break impure readdir entirely and cause use-after-free corruption
> in the dcache. It also has a missing NULL check for d_alloc_name() failure.
>=20
> Thanks,
> Amir.
>=20


