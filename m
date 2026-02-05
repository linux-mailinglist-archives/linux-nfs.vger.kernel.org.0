Return-Path: <linux-nfs+bounces-18753-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A/0IUmWhGmS3gMAu9opvQ
	(envelope-from <linux-nfs+bounces-18753-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 14:08:25 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED27F2FDE
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 14:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 323FF30177AF
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Feb 2026 13:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211073D5251;
	Thu,  5 Feb 2026 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFj/Wgov"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC312D47E4
	for <linux-nfs@vger.kernel.org>; Thu,  5 Feb 2026 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296696; cv=pass; b=aOP/kmbC7t6ALgc9K6JTQhlbquOseE2PnkVcY8VZLm6hz8tOPZAqpWKaLf8IDs8ONrMpAOAbfSOtbdL8pLm8uibM+AN4mhzHGnpJYi9rt2M+uXlaGsOCyHf1QWaQ8PEpj7gwlB/uNJjyaKKEiXi7X5buuv9x898tFUj6LKLPjKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296696; c=relaxed/simple;
	bh=N2c1RM0b4ERNHu8Wc50fN3R9BsKRWCfa11p9n8FFco4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eok5C+7ffALHn+vK+LUNGzMJRcGbFUsSdo8UJSz/5WlLjcetqaE39uZ2E8AjMbOUSW36BYagf0Tp7/ckuc6BjOTKz9NnXc4kpJJ36qwDziz0PgMXD8f6DPkaWCTdiYDU3u4dlsRRg+M6hksM/7RcLsV7WhE3FujonheQYhSOjSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFj/Wgov; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-436263e31abso386009f8f.1
        for <linux-nfs@vger.kernel.org>; Thu, 05 Feb 2026 05:04:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770296694; cv=none;
        d=google.com; s=arc-20240605;
        b=ULKVjloCLK0LE/TB/8jy0MfiIQgijjgUn1jRAjZVBJMh9WDJa1Y8ugmphjrbOOMJOv
         /10SKcBzGc3Ie7s//MdaeoxYgv/V+DcmY1HDxxFbCIAj/PLOKuGMEQIgaYGPWzZgbiZA
         Cz98Pgl7jXGyqjojUQbcGr64dWQx9f/cnNL39W9YHl+3Dm+bot2jywITuKvgsbHghaXC
         wra8NVLfZugpx0F5gZpFlzAiImpaCx6ZdYPDKV/HLu0GBlDj106KglyyH7o76/xlNHhH
         zHy33unDSW+JPrzx++VWGu4iQaUjc5/puz+GeBxkCXSaNhOS3sk/cOgnuDlYd9cpOKoW
         Anvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5QIFMxkl9qDrU626LjrUWWxNqKmOaBddIPVVlA8pXoo=;
        fh=x+b0bXQ7/rL6u9aPw0W02OvlB3Cv3KtBdQCDOKOFvgM=;
        b=JbtXq5HE2heI5HPFArCZT0nALcDpjSFOE4Cdwnj+x8SQrKCqP3hnqSHN4D6bQwObeH
         3Sd7RzF/jsBc/s1UwkZZC2Hq+YJmgUtXH/CTzpscJCmvcTTxnsTxlFzQWrpTLll7g8j7
         7JGwLAV9Z7AY4Kg0j9lYNGXQwWx1woa1HTCei91tbeTZWWXxJTnmTzVbVm1Gs9dsb0f7
         uYO1r/jRWTxupTttwbtWZSziXVdpgSlh7eZy9/CdhiJhxk3Rri55IVAe9SNgLo8RRTOM
         AUeW8PDV7/2RcgM0dtXaXEEBEP8e96tkLCszdUXZJOqlbrqvKj0hpy1CU5M57H1g3Yta
         Ti3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770296694; x=1770901494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QIFMxkl9qDrU626LjrUWWxNqKmOaBddIPVVlA8pXoo=;
        b=eFj/Wgovw5nx28AuntEcmYhTLWrcShD+FEPlxv8t7bORKwNp4fZgpa1A8jYpx19B7V
         zpkQAXJ4K4F1Rv7pM72BhwnMUSRonxs65fpBhDO4SGuX0qAlWPM8t4D5sePSeStUIeFr
         q/hMmt72lMyU9ipFKtciig6U6q4SzUh9UN7CUoRKLW2gH8q1i1KthFAMEUcimBVmwnkX
         fbv53HjAq8YAWe/nohi9dOQlYvBcBwPjRxIto8GV/ST/gaM13N9HphSRgAZAg+w0Rq6K
         YgOePfLA4Z3vgrxDj4Z5paCLoAaxyEGqvGJgUxqAYNThBSY9LBmewV+08tHdpfqS5uF6
         B8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770296694; x=1770901494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5QIFMxkl9qDrU626LjrUWWxNqKmOaBddIPVVlA8pXoo=;
        b=B3dg0QypZyUCxz9Odhrf8D6uDP92+4sVoKQWXiyP607bkIm+r8E9bNrBkLm7vHGF39
         MSRar+VLgbcshdK4WXbt9yNWnkyTX+lJzFltEDgaGzmX205ufiShpxAtm3EtFvZIeYWQ
         +Ea2CtPOG3Z+KXy4teyGJmAfBhL+JV4dlASwJCstI1tbxljeMND+TaV0ZslU3veMF2Gc
         oRKAVfR2M2gR7p8mqcsKGPDxDhBYGCwt2czZj2Hq1w271Vc21QJvskNTHxdf0QMIZUiU
         doP6iNpOcZLC834/kZX90m4OQ5a4tC3FGAHPPHAomesQVkedi0SPXPHyV4XyUUGx5YDw
         uhJA==
X-Forwarded-Encrypted: i=1; AJvYcCX1IheEkaUjbj9eC0BdrBNRx+4260jeUYfojJ2SKrSkeHuuflZsHzMBf5jZYMdRcSVyOaoJulseucI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzjNCY2J/JdB9YyGf+e4uH32NzAueMzX1ysB5eLgR60v6SAqo
	Gdlsbgg1R+lIWigEOL+Bbz9rT+WzaDHyZBaelMpbtUBGUqw7H73O2PeHp8EVodSbjHMc0Jnx/XS
	BjGJZxVlRbmRAbygk7ypPxX2Y+cyOlaY=
X-Gm-Gg: AZuq6aIc4KoqhFLbVC1RlARnqkJcessrU+FX7V3OOEDbo6rBV8Kkqux6eNRSO6CJbpu
	URqZaPqQD+fnwmulGpFCQ0ccOixd+l6h0/KACtMMPQYYq5+KRN+FfcpFGh8s/7ChXybv8woy9DU
	AAzvkLaVp8oUYNVpWZ5b4X8ZXqIfPL/iEuvUAe4DNzU1xP8VgzV5najMWBZs1ZvucPo2G82KWdW
	Y0boWpVGPgPJgb4zU+7Jj/qpmx0WR5b23XjltFxT1Wfaat1v5yF0OilJ9noyVZbCp2ApbCCVrVz
	NSAqlkE8IQFdp/Flqo1d9/RK4RJBCg==
X-Received: by 2002:a05:6000:1acb:b0:432:5bac:3915 with SMTP id
 ffacd0b85a97d-43618053bc4mr9962281f8f.39.1770296693827; Thu, 05 Feb 2026
 05:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-9-neilb@ownmail.net>
 <5d273a008fc51a2fded785efbe30e5bd2a89b985.camel@kernel.org>
In-Reply-To: <5d273a008fc51a2fded785efbe30e5bd2a89b985.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 14:04:42 +0100
X-Gm-Features: AZwV_QhEkTNuUX-zP-udJB3TTtiGdaNYEr11QFKjoqWXaHOUCtxdu5bQUZv0f1A
Message-ID: <CAOQ4uxh_Ugyy9=Vx_XOzWMTdhqVx6kAu43q+F+afhNF_Zv_9TA@mail.gmail.com>
Subject: Re: [PATCH 08/13] ovl: Simplify ovl_lookup_real_one()
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18753-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[brown.name,kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,canonical.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:email]
X-Rspamd-Queue-Id: 0ED27F2FDE
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 1:38=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Wed, 2026-02-04 at 15:57 +1100, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >
> > The primary purpose of this patch is to remove the locking from
> > ovl_lookup_real_one() as part of centralising all locking of directorie=
s
> > for name operations.
> >
> > The locking here isn't needed.  By performing consistency tests after
> > the lookup we can be sure that the result of the lookup was valid at
> > least for a moment, which is all the original code promised.
> >
> > lookup_noperm_unlocked() is used for the lookup and it will take the
> > lock if needed only where it is needed.
> >
> > Also:
> >  - don't take a reference to real->d_parent.  The parent is
> >    only use for a pointer comparison, and no reference is needed for
> >    that.
> >  - Several "if" statements have a "goto" followed by "else" - the
> >    else isn't needed: the following statement can directly follow
> >    the "if" as a new statement
> >  - Use a consistent pattern of setting "err" before performing a test
> >    and possibly going to "fail".
> >  - remove the "out" label (now that we don't need to dput(parent) or
> >    unlock) and simply return from fail:.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/export.c | 61 ++++++++++++++++++-------------------------
> >  1 file changed, 26 insertions(+), 35 deletions(-)
> >
> > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > index 83f80fdb1567..dcd28ffc4705 100644
> > --- a/fs/overlayfs/export.c
> > +++ b/fs/overlayfs/export.c
> > @@ -359,59 +359,50 @@ static struct dentry *ovl_lookup_real_one(struct =
dentry *connected,
> >                                         struct dentry *real,
> >                                         const struct ovl_layer *layer)
> >  {
> > -     struct inode *dir =3D d_inode(connected);
> > -     struct dentry *this, *parent =3D NULL;
> > +     struct dentry *this;
> >       struct name_snapshot name;
> >       int err;
> >
> >       /*
> > -      * Lookup child overlay dentry by real name. The dir mutex protec=
ts us
> > -      * from racing with overlay rename. If the overlay dentry that is=
 above
> > -      * real has already been moved to a parent that is not under the
> > -      * connected overlay dir, we return -ECHILD and restart the looku=
p of
> > -      * connected real path from the top.
> > +      * @connected is a directory in the overlay and @real is an objec=
t
> > +      * on @layer which is expected to be a child of @connected.
> > +      * The goal is to return a dentry from the overlay which correspo=
nds

As the header comment already says:
"...return a connected overlay dentry whose real dentry is @real"

The wording "corresponds to @real" reduces clarity IMO.

> > +      * to @real.  This is done by looking up the name from @real in
> > +      * @connected and checking that the result meets expectations.
> > +      *
> > +      * Return %-ECHILD if the parent of @real no-longer corresponds t=
o
> > +      * @connected, and %-ESTALE if the dentry found by lookup doesn't
> > +      * correspond to @real.
> >        */

I dislike kernel-doc inside code comments.
I think this is actively discouraged and I haven't found a single example
of this style in fs code.

If you want to keep this format, please lift the comment to function
header comment - it is anyway a very generic comment that explains the
function in general.

> > -     inode_lock_nested(dir, I_MUTEX_PARENT);
> > -     err =3D -ECHILD;
> > -     parent =3D dget_parent(real);
> > -     if (ovl_dentry_real_at(connected, layer->idx) !=3D parent)
> > -             goto fail;
> >
> > -     /*
> > -      * We also need to take a snapshot of real dentry name to protect=
 us
> > -      * from racing with underlying layer rename. In this case, we don=
't
> > -      * care about returning ESTALE, only from dereferencing a free na=
me
> > -      * pointer because we hold no lock on the real dentry.
> > -      */
> >       take_dentry_name_snapshot(&name, real);
> > -     /*
> > -      * No idmap handling here: it's an internal lookup.
> > -      */
> > -     this =3D lookup_noperm(&name.name, connected);
> > +     this =3D lookup_noperm_unlocked(&name.name, connected);
> >       release_dentry_name_snapshot(&name);
> > +
> > +     err =3D -ECHILD;
> > +     if (ovl_dentry_real_at(connected, layer->idx) !=3D real->d_parent=
)
> > +             goto fail;
> > +
> >       err =3D PTR_ERR(this);
> > -     if (IS_ERR(this)) {
> > +     if (IS_ERR(this))
> >               goto fail;
> > -     } else if (!this || !this->d_inode) {
> > -             dput(this);
> > -             err =3D -ENOENT;
> > +
> > +     err =3D -ENOENT;
> > +     if (!this || !this->d_inode)
> >               goto fail;
> > -     } else if (ovl_dentry_real_at(this, layer->idx) !=3D real) {
> > -             dput(this);
> > -             err =3D -ESTALE;
> > +
> > +     err =3D -ESTALE;
> > +     if (ovl_dentry_real_at(this, layer->idx) !=3D real)
> >               goto fail;
> > -     }
> >
> > -out:
> > -     dput(parent);
> > -     inode_unlock(dir);
> >       return this;
> >
> >  fail:
> >       pr_warn_ratelimited("failed to lookup one by real (%pd2, layer=3D=
%d, connected=3D%pd2, err=3D%i)\n",
> >                           real, layer->idx, connected, err);
> > -     this =3D ERR_PTR(err);
> > -     goto out;
> > +     if (!IS_ERR(this))
> > +             dput(this);
> > +     return ERR_PTR(err);
> >  }
> >
> >  static struct dentry *ovl_lookup_real(struct super_block *sb,
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Otherwise, it looks fine.

Thanks,
Amir.

