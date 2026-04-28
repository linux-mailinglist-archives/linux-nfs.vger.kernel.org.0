Return-Path: <linux-nfs+bounces-21205-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPOMO+IA8GnYNAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21205-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 02:35:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F8047C2BE
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 02:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A78363008D2F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 00:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA8724EAB1;
	Tue, 28 Apr 2026 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="GNo3PpR0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sGZIV63w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974A92367D9;
	Tue, 28 Apr 2026 00:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777336500; cv=none; b=GiLsPQoIJkoSO2+LVb/mRGkwar+Zez4/NYocaQKZRbnDShknDe5QJgcTXevRPyBQTOF7zvhO8If/txFrsina8juwSVE8/LEqdV/wbPqR1W365dIDC1ovyH1XZi3hhDEkFVr4xVA1cr2t14Qh/+N0b0f0oFupIPpJlvBcnSZD8RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777336500; c=relaxed/simple;
	bh=0wavXdz5t43aNG4o5hGA6jj+uFexGoTNJYG/VRyBMcs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=MEnURBZ9QzTMFXlIG/VttOo3tGpOsR2UONHTxhbchSJYa/EnkYDhtJSILbeU4ajUp8XqeyJbzgMHU/simpWLREITjYNidouBlfmTCSo3mUHUgm5v6+WCip1OMKuAgf+CGJfC2eptT75HdBJNYvS8g+rDAVAA43f3ayOfhjtKfpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=GNo3PpR0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sGZIV63w; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 82B491D001C3;
	Mon, 27 Apr 2026 20:34:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 27 Apr 2026 20:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1777336497; x=1777422897; bh=AZzIxgsQ2d6c4+T6GDoabCOc5LUEUqiVBOo
	GDHBYH48=; b=GNo3PpR0kKJ91nIZRwyedPdhv3FgYTrGg3PN7vEJQaYEkbq6wxu
	yXX1Y4ykKQN3Xbov0s+9E5goMb7kZDIQ4SQRP6freq8+ixsnsn38aBu1dzZDlXZ4
	xVIP+ZkBJUR+udxWUzdDOBNuHU7g2EMxXHFLNS6K1wuhJp+yW5qUlpd3pZGKAFMx
	Srx5Y29fYU3yIxsr7LMQH4CCVRlqJRBH5R3doU/1xjSZMnrUSYvq6YYzbqVReNVK
	+6VR7Z+LO7Lr/US8RhEZRO4G+rxJQt2/iB6Xej3fBhY3TQUvZq4eRrtSJ4JZzMpx
	GCyfL83rJgRsEKTFJT3KXTqpOZFzWZpCpJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777336497; x=
	1777422897; bh=AZzIxgsQ2d6c4+T6GDoabCOc5LUEUqiVBOoGDHBYH48=; b=s
	GZIV63wSoa9mtxwAysURW0JxQ9Khho+fzXxYFQbL3FQ4ul5mEhcl9XJtidJ8McQ6
	OGyVDh7mRNOO6+Y1Etf1naGJRSbf7zkYinFE3W+rAAH3M0VoTAn+xcVITM6sDGvT
	aKRq6/Fqm4b0o6b1jrr/e/YcTHpPrSj8Mqu6OIwk8yEVNEy1+k81lykwuDIbdDJI
	2imevb2OlHlJdKTSYxtjHsXHM+8cMbZ/qCqoHjXgfxaoYMvPazKqFy0LoyMi8hMy
	PECuVTvigsdAp6BehrJV94VDTZSzKZJrS7bGCq18DARrua2F6A2akjVMR1HJefAK
	w6K+EARC/E7GgqvGbj6ZA==
X-ME-Sender: <xms:sADwacs3bBui6X9O6oB9mxyeWsCDRiW4ZMsa7YQ5dlqWLuQNjrJ8ig>
    <xme:sADwaVzt2Q0_gvf7gi-eeEwpHNKBCb8iLgaFGqRmp7DTpGjOnx4Y39CWCCOX7zhe6
    X6Um7xHFmBD6egkLm4NQ0xiiqTFR3fHEdd6h1QT4BU23pHj>
X-ME-Received: <xmr:sADwaZZa0ANQBpeS7Ttc7MKw8e2WGDY7zDltm5acdexb4jqTsllzZOheK2aSKW7AjnEP1qyJSefEyFYg15lqg0AfoziQVrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektddugecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:sADwacUUprC9EixGw9kWku3d5dybsC4fFMfaw-_gZHzOlpmYs9eb2Q>
    <xmx:sADwaSFy3SsEdG7PDEH12vs74PngWTiRS-eWEdzVdAzD8DF8dm5O_w>
    <xmx:sADwaeAW5Zilp37g9YL9UZY0uINPH4pf1x0ewHqiLW-aIvmzFjhyBQ>
    <xmx:sADwaSywV087sw7af1DfpYO09P2l0MzkLm2dOacdijYCpZ1Rd4NUeA>
    <xmx:sQDwaUfwUyCGrOP4EMFZmuoyD6ZRmBOpNimU8X6B1wsaV4_q45gnAqxe>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 20:34:52 -0400 (EDT)
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
Subject: Re: [PATCH v3 10/19] VFS/ovl: add d_alloc_noblock_return()
In-reply-to:
 <CAOQ4uxiZF0_dGtHY0x7T0oh=3jhDC7-THH_ANt-Ha5kfdRe4QQ@mail.gmail.com>
References: <20260427040517.828226-1-neilb@ownmail.net>
  <20260427040517.828226-11-neilb@ownmail.net>
  <CAOQ4uxiZF0_dGtHY0x7T0oh=3jhDC7-THH_ANt-Ha5kfdRe4QQ@mail.gmail.com>
Date: Tue, 28 Apr 2026 10:34:50 +1000
Message-id: <177733649056.1474915.2313612194633470905@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 00F8047C2BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21205-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim]

On Mon, 27 Apr 2026, Amir Goldstein wrote:
> On Mon, Apr 27, 2026 at 6:07=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > ovl_lookup currently needs to check if a dentry with the same name has
> > already been added to the dcache as readdir might need to do.  This
> > is an unnecessary performance cost to manage a rare race.
> >
> > If ovl could know which in-lookup dentries raced with readdir, it could
> > limit the extra lookup to just those.
> >
> > So add d_alloc_noblock_return() which provides the in-lookup dentry when
> > it returns -EWOULDBLOCK.
> >
> > ovl_readdir() can use this this and flag the dentry such that
> > ovl_lookup() and easily check if a repeat lookup is needed.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
>=20
> Very nice!
>=20
> One nit about the API
>=20
> > ---
> >  fs/dcache.c              | 50 ++++++++++++++++++++++++++++++++++++----
> >  fs/overlayfs/namei.c     | 23 ++++++++++--------
> >  fs/overlayfs/overlayfs.h |  2 ++
> >  fs/overlayfs/readdir.c   |  7 ++++--
> >  include/linux/dcache.h   |  2 ++
> >  5 files changed, 68 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index a2ddfe811df3..2f11257b725b 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -2749,7 +2749,8 @@ enum alloc_para {
> >  static inline
> >  struct dentry *__d_alloc_parallel(struct dentry *parent,
> >                                   const struct qstr *name,
> > -                                 enum alloc_para how)
> > +                                 enum alloc_para how,
> > +                                 struct dentry **dentryp)
> >  {
> >         unsigned int hash =3D name->hash;
> >         struct hlist_bl_head *b =3D in_lookup_hash(parent, hash);
> > @@ -2836,7 +2837,10 @@ struct dentry *__d_alloc_parallel(struct dentry *p=
arent,
> >                         case ALLOC_PARA_FAIL:
> >                                 spin_unlock(&dentry->d_lock);
> >                                 dput(new);
> > -                               dput(dentry);
> > +                               if (dentryp)
> > +                                       *dentryp =3D dentry;
> > +                               else
> > +                                       dput(dentry);
> >                                 return ERR_PTR(-EWOULDBLOCK);
> >                         case ALLOC_PARA_WAIT:
> >                                 wait_var_event_spinlock(&dentry->d_flags,
> > @@ -2899,7 +2903,7 @@ struct dentry *__d_alloc_parallel(struct dentry *pa=
rent,
> >  struct dentry *d_alloc_parallel(struct dentry *parent,
> >                                 const struct qstr *name)
> >  {
> > -       return __d_alloc_parallel(parent, name, ALLOC_PARA_WAIT);
> > +       return __d_alloc_parallel(parent, name, ALLOC_PARA_WAIT, NULL);
> >  }
> >  EXPORT_SYMBOL(d_alloc_parallel);
> >
> > @@ -2931,11 +2935,49 @@ struct dentry *d_alloc_noblock(struct dentry *par=
ent,
> >
> >         de =3D try_lookup_noperm(name, parent);
> >         if (!de)
> > -               de =3D __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL);
> > +               de =3D __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL, =
NULL);
> >         return de;
> >  }
> >  EXPORT_SYMBOL(d_alloc_noblock);
> >
> > +/**
> > + * d_alloc_noblock_return() - find or allocate a new dentry
> > + * @parent - dentry of the parent
> > + * @name   - name of the dentry within that parent.
> > + * @dentryp - place to store the blocking dentry
> > + *
> > + * A new dentry is allocated and, providing it is unique, added to the
> > + * relevant index.
> > + * If an existing dentry is found with the same parent/name that is
> > + * not d_in_lookup() then that is returned instead.
> > + * If the existing dentry is d_in_lookup(), d_alloc_noblock()
> > + * returns with error %-EWOULDBLOCK and the blocking dentry is passed
> > + * in @dentryp.  The dentry must be dput() by the caller.
>=20
> This contract is a bit subtle.
> We have plenty of contracts where the caller must dput() in case of success
> or in case of error, but must dput in case of a specific error that
> sounds fragile.
>=20
> How about:
> * If the existing dentry is d_in_lookup(), d_alloc_noblock()
>  * returns with error %-EWOULDBLOCK and the blocking dentry is passed
>  * in @dentryp. Regardless of the returned error, if @dentryp is set by this
>  * function, the returned dentry must be dput() by the caller.

That is sensible, though I've used slightly different words.

Thanks,
NeilBrown

>=20
> Thanks,
> Amir.
>=20
> > + *
> > + * Thus if the returned dentry is d_in_lookup() then the caller has
> > + * exclusive access until it completes the lookup.
> > + * If the returned dentry is not d_in_lookup() then a lookup has
> > + * already completed.
> > + *
> > + * The @name need not already have ->hash set.
> > + *
> > + * Returns: the dentry, whether found or allocated, or an error
> > + *    %-ENOMEM, %-EWOULDBLOCK, and anything returned by ->d_hash().
> > + */
> > +struct dentry *d_alloc_noblock_return(struct dentry *parent,
> > +                                     struct qstr *name,
> > +                                     struct dentry **dentryp)
> > +{
> > +       struct dentry *de;
> > +
> > +       de =3D try_lookup_noperm(name, parent);
> > +       if (!de)
> > +               de =3D __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL,
> > +                                       dentryp);
> > +       return de;
> > +}
> > +EXPORT_SYMBOL(d_alloc_noblock_return);
> > +
> >  /*
> >   * - Unhash the dentry
> >   * - Retrieve and clear the waitqueue head in dentry
> > diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> > index 69032eb2b1e2..524e661c3c8d 100644
> > --- a/fs/overlayfs/namei.c
> > +++ b/fs/overlayfs/namei.c
> > @@ -1400,16 +1400,19 @@ struct dentry *ovl_lookup(struct inode *dir, stru=
ct dentry *dentry,
> >         if (dentry->d_name.len > ofs->namelen)
> >                 return ERR_PTR(-ENAMETOOLONG);
> >
> > -       /*
> > -        * The existance of this in-lookup dentry might have forced
> > -        * readdir to do the lookup with a new dentry.  If so we must
> > -        * return that one.
> > -        */
> > -       alias =3D try_lookup_noperm(&QSTR_LEN(dentry->d_name.name,
> > -                                           dentry->d_name.len),
> > -                                 dentry->d_parent);
> > -       if (alias && !IS_ERR(alias))
> > -               return alias;
> > +       if (ovl_dentry_test_flag(OVL_E_RACED_READDIR, dentry)) {
> > +               ovl_dentry_clear_flag(OVL_E_RACED_READDIR, dentry);
> > +               /*
> > +                * The existance of this in-lookup dentry might have
> > +                * forced readdir to do the lookup with a new dentry.
> > +                * If so we must return that one.
> > +                */
> > +               alias =3D try_lookup_noperm(&QSTR_LEN(dentry->d_name.name,
> > +                                                   dentry->d_name.len),
> > +                                         dentry->d_parent);
> > +               if (alias && !IS_ERR(alias))
> > +                       return alias;
> > +       }
> >
> >         with_ovl_creds(dentry->d_sb)
> >                 err =3D ovl_lookup_layers(&ctx, &d);
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index b75df37f70ac..bd6f1a25aca1 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -71,6 +71,8 @@ enum ovl_entry_flag {
> >         OVL_E_CONNECTED,
> >         /* Lower stack may contain xwhiteout entries */
> >         OVL_E_XWHITEOUTS,
> > +       /* dentry was found in-lookup during readdir */
> > +       OVL_E_RACED_READDIR,
> >  };
> >
> >  enum {
> > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > index e03b32491941..e483bd939a8c 100644
> > --- a/fs/overlayfs/readdir.c
> > +++ b/fs/overlayfs/readdir.c
> > @@ -553,7 +553,7 @@ static int ovl_cache_update(const struct path *path, =
struct ovl_cache_entry *p,
> >  {
> >         struct dentry *dir =3D path->dentry;
> >         struct ovl_fs *ofs =3D OVL_FS(dir->d_sb);
> > -       struct dentry *this =3D NULL;
> > +       struct dentry *this =3D NULL, *in_lookup;
> >         enum ovl_path_type type;
> >         u64 ino =3D p->real_ino;
> >         int xinobits =3D ovl_xino_bits(ofs);
> > @@ -574,7 +574,8 @@ static int ovl_cache_update(const struct path *path, =
struct ovl_cache_entry *p,
> >                 }
> >         }
> >         /* This checks also for xwhiteouts */
> > -       this =3D d_alloc_noblock(dir, &QSTR_LEN(p->name, p->len));
> > +       this =3D d_alloc_noblock_return(dir, &QSTR_LEN(p->name, p->len),
> > +                                     &in_lookup);
> >         if (this =3D=3D ERR_PTR(-EWOULDBLOCK)) {
> >                 /*
> >                  * Some other thead is looking up this name and will
> > @@ -583,6 +584,8 @@ static int ovl_cache_update(const struct path *path, =
struct ovl_cache_entry *p,
> >                  * lookup gets a turn it will find and return this
> >                  * dentry.
> >                  */
> > +               ovl_dentry_set_flag(OVL_E_RACED_READDIR, in_lookup);
> > +               dput(in_lookup);
> >                 this =3D d_alloc_name(dir, p->name);
> >         }
> >         if (!IS_ERR(this) && !d_unhashed(this)) {
> > diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> > index 662b98185337..db7cdcbac775 100644
> > --- a/include/linux/dcache.h
> > +++ b/include/linux/dcache.h
> > @@ -258,6 +258,8 @@ extern struct dentry * d_alloc(struct dentry *, const=
 struct qstr *);
> >  extern struct dentry * d_alloc_anon(struct super_block *);
> >  extern struct dentry * d_alloc_parallel(struct dentry *, const struct qs=
tr *);
> >  extern struct dentry * d_alloc_noblock(struct dentry *, struct qstr *);
> > +extern struct dentry * d_alloc_noblock_return(struct dentry *, struct qs=
tr *,
> > +                                             struct dentry **);
> >  extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
> >  struct dentry *d_duplicate(struct dentry *dentry);
> >  /* weird procfs mess; *NOT* exported */
> > --
> > 2.50.0.107.gf914562f5916.dirty
> >
>=20


