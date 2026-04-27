Return-Path: <linux-nfs+bounces-21162-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HcnGfgi72lV7gAAu9opvQ
	(envelope-from <linux-nfs+bounces-21162-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 10:48:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AA746F5FC
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 10:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B62130074B5
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A121A3A1A38;
	Mon, 27 Apr 2026 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="jvzSoaDH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SjzO1SWv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22E73A1D0C;
	Mon, 27 Apr 2026 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777279720; cv=none; b=ec06rArszXuYRp3nMJYrsgAE2g/A3yOl/V/Ok5rAd5skbsAFKQgKdStTBWv1wTzfnmDic/ww+FiHe2grxyvZkLVJbrXIdLkJvgPGaQVFPrspFXqJcAEaG/YG5ITXgCpR4Z+hhP2BjdK9R605tmBQji3rWFHPCfCeSwJWMkUFaW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777279720; c=relaxed/simple;
	bh=ZZy3goWvQZKJbWxanHAU6h0Cwakj3Txs6mY/tAZiR5o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hl5dszmDSCQjllGpi99Bb5Ac0oZzlKKRi21fzm/RK98h153quUfZv9RiryAwQBDA41JCxhY++jz0gI26gnp9WKhTlHM6WSaB50QQXLT0wChuefDQqbzMKkzgz+7EnEGXrwRYBTs/pw2N2wubh2P7u5VHzi47bSyvzZqpXphU4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=jvzSoaDH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SjzO1SWv; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D55D1400140;
	Mon, 27 Apr 2026 04:48:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 27 Apr 2026 04:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1777279718; x=1777366118; bh=pk61hD0NnOCKy0YNmA3ypPzAQICF3Vxg/72
	EQt/R/hM=; b=jvzSoaDH4TwFj9xler4KwGiCyuqaOJCTRlRl+FiQskLaddwUSvo
	yMIlKnuaxfdtEOA+JUY/GfIVjj9BWEOlswHa6LZCdH/GKnUUmtFDqte14UmTrBk3
	6zAMt8OsinSbyTvS7iVUFsvsciGX7ZS5Hl8I8xj6abzo3yHRR7bCJktI/iZBAzTC
	vMXGk04B6TM/uf7RipsvqS/LKFg43HA6vdaYD8a9i+TiIabDLSMsMq1DFOfQKtm6
	CVdcoRe6Mrl1Ha8ygzkTFH7ukDSKMvwKBvqJ+0EqrSK9+j9vqVqrqqSM5rQWR7KP
	JqwFwk/+HfXU6lv4acD0DyB464r5RGAtmjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777279718; x=
	1777366118; bh=pk61hD0NnOCKy0YNmA3ypPzAQICF3Vxg/72EQt/R/hM=; b=S
	jzO1SWvt0HY2eFvP8jrINGd60LeLwVu/QvMZo2OB5EJuYm1XHkiuUZl/+5k62p28
	c11Pg6mASW8YC/wG9KboTTKhJjeTIlW2CbRKhVfYFmYsV7btlhJAfeN0FTCQo1ho
	M2dGU1eynWxvWDXOivdbZBSjAvlFHRSZ3dirQZGoGzLNc8/lq5gr40IAfCtEtxeB
	hUnyazIDmillkakytn4Nsuer1Sp/mGWWiuV8UFlzPYWHsoY0nbDP/EZ/vXa1FTn8
	6grdcf1XpHfyQEgrWgqf4Qw9LeEe9L2PP8rchP1W9IVoysIDuFRKURUI5IE1dWo8
	gmeGJ5OZ25MBIZ065v0Hg==
X-ME-Sender: <xms:5SLvaSu7sOUNu--XQHG6puhLNhyNEwzi4NDCutwDpK7R0EXyk1isiA>
    <xme:5SLvaTwdjhdAmjrX0jseg948tCTE8VXLg7oGJuM1dBOhAhoi3dUTL_KUH8vqBtjli
    Qf0FOyLBwxb1ITbHpfkKdDG-oEtLR0lNE6NUxTR9-0uRkcjAQ>
X-ME-Received: <xmr:5SLvafb8C2uwaNoVDNFDerulqnIXi52ofQBXnnPojVWUAxM3q0INoik78r4ii52XAAsAd9mDaOvpub1AixVAFLoVkjGiDqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkedvhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:5SLvaaV3bCkRwX-IHLlvW01Nhr9iwUVst7sasWGXe2sEwoj0IWK5ww>
    <xmx:5SLvaYHLqjv0iXuBRZWu0TT9oHF9sF2H4GnsaKaDYubaxVMG2nCPhg>
    <xmx:5SLvacBkIHbYk1O3H6JoYTaWVnhzA3bVAVK7IOqh2NxIGXwdTDp-nQ>
    <xmx:5SLvaYwYD9TRErxSdoTZF9TSAVGKNfC_z_ICh5WN2sUAOF7cwVXjsA>
    <xmx:5iLvaad4WfvTjAwFcPyoSui_ZZTjK28K_27I37TD22R2opa2RFhoU6bU>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 04:48:33 -0400 (EDT)
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
Subject: Re: [PATCH v3 08/19] VFS/xfs/ntfs: drop parent lock across
 d_alloc_parallel() in d_add_ci()
In-reply-to:
 <CAOQ4uxjj6iJNnwUqV+cRtqo4qRD4v-f-ct92=ofCZWPDATXM7g@mail.gmail.com>
References: <20260427040517.828226-1-neilb@ownmail.net>
  <20260427040517.828226-9-neilb@ownmail.net>
  <CAOQ4uxjj6iJNnwUqV+cRtqo4qRD4v-f-ct92=ofCZWPDATXM7g@mail.gmail.com>
Date: Mon, 27 Apr 2026 18:48:31 +1000
Message-id: <177727971181.1474915.16652480895948480305@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: F3AA746F5FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21162-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[16];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,brown.name:replyto,brown.name:email,noble.neil.brown.name:mid,dname.name:url,nls_name.name:url,messagingengine.com:dkim]

On Mon, 27 Apr 2026, Amir Goldstein wrote:
> On Mon, Apr 27, 2026 at 6:07=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > A proposed change will invert the lock ordering between
> > d_alloc_parallel() and inode_lock() on the parent.
> > When that happens it will not be safe to call d_alloc_parallel() while
> > holding the parent lock - even shared.
> >
> > We don't need to keep the parent lock held when d_add_ci() is run - the
> > VFS doesn't need it as dentry is exclusively held due to
> > DCACHE_PAR_LOOKUP and the filesystem has finished its work.
> >
> > So drop and reclaim the lock (shared or exclusive as determined by
> > LOOKUP_SHARED) to avoid future deadlock.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/dcache.c            | 18 +++++++++++++++++-
> >  fs/ntfs/namei.c        |  4 +++-
> >  fs/xfs/xfs_iops.c      |  3 ++-
> >  include/linux/dcache.h |  3 ++-
> >  4 files changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index 569a8ddf4c0d..a2ddfe811df3 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -2294,6 +2294,7 @@ EXPORT_SYMBOL(d_obtain_root);
> >   * @dentry: the negative dentry that was passed to the parent's lookup f=
unc
> >   * @inode:  the inode case-insensitive lookup has found
> >   * @name:   the case-exact name to be associated with the returned dentry
> > + * @bool:   %true if lookup was performed with LOOKUP_SHARED
>=20
> I do not understand the choice of API.
> Seems better to pass the lookup flags and avoid exposing this very internal
> logic in the call sites...

That is an excellent suggestion, thank.  As you say, it cleans up much
messiness.  I will definitely do that.

Thanks,
NeilBrown



>=20
> >   *
> >   * This is to avoid filling the dcache with case-insensitive names to the
> >   * same inode, only the actual correct case is stored in the dcache for
> > @@ -2306,7 +2307,7 @@ EXPORT_SYMBOL(d_obtain_root);
> >   * the exact case, and return the spliced entry.
> >   */
> >  struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
> > -                       struct qstr *name)
> > +                       struct qstr *name, bool shared)
> >  {
> >         struct dentry *found, *res;
> >
> > @@ -2319,6 +2320,17 @@ struct dentry *d_add_ci(struct dentry *dentry, str=
uct inode *inode,
> >                 iput(inode);
> >                 return found;
> >         }
> > +       /*
> > +        * We are holding parent lock and so don't want to wait for a
> > +        * d_in_lookup() dentry.  We can safely drop the parent lock and
> > +        * reclaim it as we have exclusive access to dentry as it is
> > +        * d_in_lookup() (so ->d_parent is stable) and we are near the
> > +        * end ->lookup() and will shortly drop the lock anyway.
> > +        */
> > +       if (shared)
> > +               inode_unlock_shared(d_inode(dentry->d_parent));
> > +       else
> > +               inode_unlock(d_inode(dentry->d_parent));
> >         if (d_in_lookup(dentry)) {
> >                 found =3D d_alloc_parallel(dentry->d_parent, name);
> >                 if (IS_ERR(found) || !d_in_lookup(found)) {
> > @@ -2332,6 +2344,10 @@ struct dentry *d_add_ci(struct dentry *dentry, str=
uct inode *inode,
> >                         return ERR_PTR(-ENOMEM);
> >                 }
> >         }
> > +       if (shared)
> > +               inode_lock_shared(d_inode(dentry->d_parent));
> > +       else
> > +               inode_lock_nested(d_inode(dentry->d_parent), I_MUTEX_PARE=
NT);
> >         res =3D d_splice_alias(inode, found);
> >         if (res) {
> >                 d_lookup_done(found);
> > diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> > index 10894de519c3..30dddef43300 100644
> > --- a/fs/ntfs/namei.c
> > +++ b/fs/ntfs/namei.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/exportfs.h>
> >  #include <linux/iversion.h>
> > +#include <linux/namei.h> // for LOOKUP_SHARED
>=20
> ... this won't be needed
>=20
> >
> >  #include "ntfs.h"
> >  #include "time.h"
> > @@ -310,7 +311,8 @@ static struct dentry *ntfs_lookup(struct inode *dir_i=
no, struct dentry *dent,
> >                 }
> >                 nls_name.hash =3D full_name_hash(dent, nls_name.name, nls=
_name.len);
> >
> > -               dent =3D d_add_ci(dent, dent_inode, &nls_name);
> > +               dent =3D d_add_ci(dent, dent_inode, &nls_name,
> > +                               !!(flags & LOOKUP_SHARED));
> >                 kfree(nls_name.name);
> >                 return dent;
> >
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index 325c2200c501..f03d832f1468 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/security.h>
> >  #include <linux/iversion.h>
> >  #include <linux/fiemap.h>
> > +#include <linux/namei.h> // for LOOKUP_SHARED
> >
> >  /*
> >   * Directories have different lock order w.r.t. mmap_lock compared to re=
gular
> > @@ -369,7 +370,7 @@ xfs_vn_ci_lookup(
> >         /* else case-insensitive match... */
> >         dname.name =3D ci_name.name;
> >         dname.len =3D ci_name.len;
> > -       dentry =3D d_add_ci(dentry, VFS_I(ip), &dname);
> > +       dentry =3D d_add_ci(dentry, VFS_I(ip), &dname, !!(flags & LOOKUP_=
SHARED));
>=20
>=20
> ... and this ugliness could be avoided.
>=20
> Thanks,
> Amir.
>=20


