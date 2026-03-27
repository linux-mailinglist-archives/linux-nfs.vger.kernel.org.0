Return-Path: <linux-nfs+bounces-20468-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENUMDiSwxmmiNgUAu9opvQ
	(envelope-from <linux-nfs+bounces-20468-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 17:28:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0783476D7
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 17:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA7130EB22B
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653CD344DBE;
	Fri, 27 Mar 2026 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="FbrU5BMR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D732939C
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628441; cv=pass; b=fgxvsrJa1mJCqDo436iPp7wGP2Uqkz1tw2mJ0lxPnsoMuKfKGtMj8DGzOjELr2QtEV6WrB3TfYsnH59yTHiD74/pR1K019BDzPEKjlh3BuSzHMIhz4bRijoIk/36y15iYLs5d09Dkh1OhrG75521pFjLvbvQGvenbwfFOpV+q8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628441; c=relaxed/simple;
	bh=0Udt9cSYWN5fjglbCHzAiPpRuW8C0BkRBUQccLBJh+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYOMUyGiuTSnqoadGDQOFGejaCO2fxId/+eKWzvK9iZVMiOevl2mqUzds0IApmqijJk6Ow7WrnWx0LJN6/DisD5AezMW0N56gZJuFm6WS/T4dyi5BojRjYFMUGeH1bIIIxU3ANMlqkR5atO+QhvlybsmPcRz5w2Tf8iFlFUd2Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=FbrU5BMR; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a27b5ad832so2614398e87.2
        for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 09:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774628437; cv=none;
        d=google.com; s=arc-20240605;
        b=BBGvqMtnvVnfn1HS5Y4g1lw/AOWv5k6vDtSLKbtKhGC+jxQ//5w1B04+oCrKj1l19q
         ndNP7e79IKRLO2E52xB//L3pYARHZ6iyIuFaZM90cwuZJc+g79bCOBku+I1lmKaLPZmi
         flvG+MBBiUk1DEJypdhRcPg6qp+bzOvuWtwc0W17tVo9VqRS0ulvSTH+SVkKJOWa3NJ2
         +0yF8mxqG7HWcyRryAiabkIm/F1IVW1i/X8z/qa9IAVyxgmg0bVUcmPtZx+tD9yEwVjI
         2GK0VnUc67uX76FAh0fIc1faOPxwGSwfzsDH9fPbmV0OG6dzNES99qtPnPYEcbf3BkyC
         nHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=87dX1bZ6+DXddJddcp1fE78yB+81rdPpKK7Bw8jyptk=;
        fh=UyddtK0fibs9EHfTfMnhCXoEBcd6Euj8MS9ezKgJzlM=;
        b=CAP5L5bquhvxqyNnnmrGmy/l07C1/up3Mj9MTRsxnT958gmbxkmvDxaBG/stgwcxhw
         OAGMlToiNq7xpay1BYZqlYgtqi1crYA9kQy0j92B1pMwjCQAHVY7fo/U3jfW1mcTt7Y/
         Hh9th7HMC6legKg4i6fkgxL0lfFG6ddt2AtvWOdMzVgTB8yaqp7auxO7FzHpspexu5X0
         z9lXAuqcn7k22//avmEtm/tCGEsT+QccLDPVi4MUW089tesU7ZLlvRYwXTy0ZnZ/sOTZ
         P1p5whP9JTwPgTjq+3g6bc9nbE0bZzLG5CsamufGueVijitTwv8CjjshtJX9UGAeBoXs
         rKZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1774628437; x=1775233237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87dX1bZ6+DXddJddcp1fE78yB+81rdPpKK7Bw8jyptk=;
        b=FbrU5BMRMom67m7jhF+lvu65mBSZHtPIYCsFMaCnSyvCsuggilrZBlkLXEwUM6FKMT
         kkzEviQHFr6XoOuSDs8BHINd3vlGkgQVkgQfz5mO8fFUDgqUUG/vhSaTh8UpIq/IwwzM
         6/yGAygc0Trf+8q0yDntQzw66HW+9aGpBNuHn7vq/7Hjv770P7YihpQcEl97CMW1M3aj
         SatZQc230GjjZtEI8SSY4Eg0oQ/8hVibl3HgNb+wY4lFwLedNz6dn9m9cBCiaoECZ9UW
         BgcWEDbmaURmVi/4IFyunePXydOSx0GoF71q6IHqC9/R9hWsl412O1HCLsPtmIkI02fk
         G7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774628437; x=1775233237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=87dX1bZ6+DXddJddcp1fE78yB+81rdPpKK7Bw8jyptk=;
        b=rIPJHK+OwZbPE/E2iPg0Ewp6qV7WtCa0yvtOYhJz98P37xr0Hb42/KtJk3LShgBZVK
         CeqTfs6TP9OCTHqcTqgibVOIO+80eHPkSib2xeiQIWx6+VgaxsZkwxFx1JucKGbNcI1w
         VZfdJfCS5gQidhBG+pWmvyyO+PZQR+Lz331IJnbbQ/CUv9v0YUpTlobvKJEauHHS27wm
         7QGhYssX9XCpr6CdQUfGrFMw/gAA7rs3SvMkd0AfuOvEJuzEtyTTgyCy6xgZXiSGAK2L
         lZlZcKsUbxzSpYLiag91pjwbb2cHAUfyrXXEPiKQde+mnlvkwoW0/YFMa6m6F6yvQ6bS
         maYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC9eA5/Mfr0XZ1wjmt1x3z9ZA7eVCGKOiqvuHfUTkLd4WIgFaIOe1KUts2YgEjez8xApl3sxRZ9mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2m6VzWqv4az3OnzAh8Fm4Zyib9v55Nx7TidJx6dVuzfGPpsn
	ErAUrp9eeZOt7bjXDDJ3Fpm8R1+f4199z0rQQ7M42iESELsDaMN+GndPw509g8gp33zF5Soqz55
	WiNTbTP58AF2PFi+2t85ACkHVz+eRVud9Ug==
X-Gm-Gg: ATEYQzxUoasMWYQ7hWsdpIag21BoGx3oJYb4N5GGo4PUaauygkZs1PFSlJ//mFcyEXB
	nBhCiYbWJSHj5Cj88ye/FXagqoUPp9zoinYw76rZar2+BLOlQZJjQ1OX83E18Mta+8Z+jN9m6nM
	wIB5OWFbQXQdslhxIAWMxUHd5WwnQEUDN8rN82YfjwE5RQaIpgWI4FUWsKyLsscqE9QFbc0x/VY
	8CUabD5aT/5hzTAzqCldrTOnxBpRvXoMFKOHlGiEbFV9D0PUqeXWZT/S8Ah6Lyyc1LLgJ+287Et
	OS0AzQNxCp1Xncmt4/j90fK0xKt9Wxpx8Hjc8Oh1DA==
X-Received: by 2002:a05:6512:33cc:b0:5a1:3134:9bac with SMTP id
 2adb3069b0e04-5a2ab91d3cemr956785e87.28.1774628436584; Fri, 27 Mar 2026
 09:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
 <20260324-nfs-7-1-v2-2-d110da3c0036@kernel.org> <CAN-5tyFpsuE9+5ZvAASwvTYKtcN5jNpAxi8ejde90e-vpUzFKg@mail.gmail.com>
 <284ca17e74af8c4f5942b2952f2bf75490dd17c0.camel@kernel.org>
In-Reply-To: <284ca17e74af8c4f5942b2952f2bf75490dd17c0.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 27 Mar 2026 12:20:25 -0400
X-Gm-Features: AQROBzAicZn5a9nHeOeGYy9n6NOWVJZYPQt8IDNFbrtgS7aXCgxpU7JW2jIdgfM
Message-ID: <CAN-5tyFsEUcSUycb4JjxH5v754SefwOH=zt24KtxEC_Ow4OjMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nfs: update inode ctime after removexattr operation
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20468-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[umich.edu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,umich.edu:dkim,umich.edu:email]
X-Rspamd-Queue-Id: 8E0783476D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 11:50=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Fri, 2026-03-27 at 11:11 -0400, Olga Kornievskaia wrote:
> > On Tue, Mar 24, 2026 at 1:32=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > xfstest generic/728 fails with delegated timestamps. The client does =
a
> > > removexattr and then a stat to test the ctime, which doesn't change. =
The
> > > stat() doesn't trigger a GETATTR because of the delegated timestamps,=
 so
> > > it relies on the cached ctime, which is wrong.
> > >
> > > The setxattr compound has a trailing GETATTR, which ensures that its
> > > ctime gets updated. Follow the same strategy with removexattr.
> >
> > This approach relies on the fact that the server the serves delegated
> > attributes would update change_attr on operations which might now
> > necessarily happen (ie, linux server does not update change_attribute
> > on writes or clone). I propose an alternative fix for the failing
> > generic/728.
> >
> > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > index 7b3ca68fb4bb..ede1835a45b3 100644
> > --- a/fs/nfs/nfs42proc.c
> > +++ b/fs/nfs/nfs42proc.c
> > @@ -1389,7 +1389,13 @@ static int _nfs42_proc_removexattr(struct inode
> > *inode, const char *name)
> >             &res.seq_res, 1);
> >         trace_nfs4_removexattr(inode, name, ret);
> >         if (!ret)
> > -               nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0)=
;
> > +               if (nfs_have_delegated_attributes(inode)) {
> > +                       nfs_update_delegated_mtime(inode);
> > +                       spin_lock(&inode->i_lock);
> > +                       nfs_set_cache_invalid(inode, NFS_INO_INVALID_BL=
OCKS);
> > +                       spin_unlock(&inode->i_lock);
> > +               } else
> > +                       nfs4_update_changeattr(inode, &res.cinfo, times=
tamp, 0);
> >
> >         return ret;
> >  }
> >
>
> What's the advantage of doing it this way?
>
> You just sent a REMOVEXATTR operation to the server that will change
> the mtime there. The server has the most up-to-date version of the
> mtime and ctime at that point.

In presence of delegated attributes, Is the server required to update
its mtime/ctime on an operation? As I mentioned, the linux server does
not update its ctime/mtime for WRITE, CLONE, COPY. Is possible that
some implementations might be different and also do not update the
ctime/mtime on REMOVEXATTR? Therefore I was suggesting that the patch
relies on the fact that it would receive an updated value. Of course
perhaps all implementations are done the same as the linux server and
my point is moot. I didn't see anything in the spec that clarifies
what the server supposed to do (and client rely on).

> It's certainly possible that the REMOVEXATTR is the only change that
> occurred. With what I'm proposing, we don't even need to do a SETATTR
> at all if nothing else changed. With your version, you would.
>
> > >
> > > Fixes: 3e1f02123fba ("NFSv4.2: add client side XDR handling for exten=
ded attributes")
> > > Reported-by: Olga Kornievskaia <aglo@umich.edu>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfs/nfs42proc.c      | 18 ++++++++++++++++--
> > >  fs/nfs/nfs42xdr.c       | 10 ++++++++--
> > >  include/linux/nfs_xdr.h |  3 +++
> > >  3 files changed, 27 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > index 7b3ca68fb4bb3bee293f8621e5ed5fa596f5da3f..7e5c1172fc11c9d5a55b3=
621977ac83bb98f7c20 100644
> > > --- a/fs/nfs/nfs42proc.c
> > > +++ b/fs/nfs/nfs42proc.c
> > > @@ -1372,11 +1372,15 @@ int nfs42_proc_clone(struct file *src_f, stru=
ct file *dst_f,
> > >  static int _nfs42_proc_removexattr(struct inode *inode, const char *=
name)
> > >  {
> > >         struct nfs_server *server =3D NFS_SERVER(inode);
> > > +       __u32 bitmask[NFS_BITMASK_SZ];
> > >         struct nfs42_removexattrargs args =3D {
> > >                 .fh =3D NFS_FH(inode),
> > > +               .bitmask =3D bitmask,
> > >                 .xattr_name =3D name,
> > >         };
> > > -       struct nfs42_removexattrres res;
> > > +       struct nfs42_removexattrres res =3D {
> > > +               .server =3D server,
> > > +       };
> > >         struct rpc_message msg =3D {
> > >                 .rpc_proc =3D &nfs4_procedures[NFSPROC4_CLNT_REMOVEXA=
TTR],
> > >                 .rpc_argp =3D &args,
> > > @@ -1385,12 +1389,22 @@ static int _nfs42_proc_removexattr(struct ino=
de *inode, const char *name)
> > >         int ret;
> > >         unsigned long timestamp =3D jiffies;
> > >
> > > +       res.fattr =3D nfs_alloc_fattr();
> > > +       if (!res.fattr)
> > > +               return -ENOMEM;
> > > +
> > > +       nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask,
> > > +                        inode, NFS_INO_INVALID_CHANGE);
> > > +
> > >         ret =3D nfs4_call_sync(server->client, server, &msg, &args.se=
q_args,
> > >             &res.seq_res, 1);
> > >         trace_nfs4_removexattr(inode, name, ret);
> > > -       if (!ret)
> > > +       if (!ret) {
> > >                 nfs4_update_changeattr(inode, &res.cinfo, timestamp, =
0);
> > > +               ret =3D nfs_post_op_update_inode(inode, res.fattr);
> > > +       }
> > >
> > > +       kfree(res.fattr);
> > >         return ret;
> > >  }
> > >
> > > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > > index 5c7452ce6e8ac94bd24bc3a33d4479d458a29907..ec105c62f721cfe01bfc6=
0f5981396958084d627 100644
> > > --- a/fs/nfs/nfs42xdr.c
> > > +++ b/fs/nfs/nfs42xdr.c
> > > @@ -263,11 +263,13 @@
> > >  #define NFS4_enc_removexattr_sz                (compound_encode_hdr_=
maxsz + \
> > >                                          encode_sequence_maxsz + \
> > >                                          encode_putfh_maxsz + \
> > > -                                        encode_removexattr_maxsz)
> > > +                                        encode_removexattr_maxsz + \
> > > +                                        encode_getattr_maxsz)
> > >  #define NFS4_dec_removexattr_sz                (compound_decode_hdr_=
maxsz + \
> > >                                          decode_sequence_maxsz + \
> > >                                          decode_putfh_maxsz + \
> > > -                                        decode_removexattr_maxsz)
> > > +                                        decode_removexattr_maxsz + \
> > > +                                        decode_getattr_maxsz)
> > >
> > >  /*
> > >   * These values specify the maximum amount of data that is not
> > > @@ -869,6 +871,7 @@ static void nfs4_xdr_enc_removexattr(struct rpc_r=
qst *req,
> > >         encode_sequence(xdr, &args->seq_args, &hdr);
> > >         encode_putfh(xdr, args->fh, &hdr);
> > >         encode_removexattr(xdr, args->xattr_name, &hdr);
> > > +       encode_getfattr(xdr, args->bitmask, &hdr);
> > >         encode_nops(&hdr);
> > >  }
> > >
> > > @@ -1818,6 +1821,9 @@ static int nfs4_xdr_dec_removexattr(struct rpc_=
rqst *req,
> > >                 goto out;
> > >
> > >         status =3D decode_removexattr(xdr, &res->cinfo);
> > > +       if (status)
> > > +               goto out;
> > > +       status =3D decode_getfattr(xdr, res->fattr, res->server);
> > >  out:
> > >         return status;
> > >  }
> > > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > > index ff1f12aa73d27b6fd874baf7019dd03195fc36e5..fcbd21b5685f46136a210=
c8e11c20a54d6ed9dad 100644
> > > --- a/include/linux/nfs_xdr.h
> > > +++ b/include/linux/nfs_xdr.h
> > > @@ -1611,12 +1611,15 @@ struct nfs42_listxattrsres {
> > >  struct nfs42_removexattrargs {
> > >         struct nfs4_sequence_args       seq_args;
> > >         struct nfs_fh                   *fh;
> > > +       const u32                       *bitmask;
> > >         const char                      *xattr_name;
> > >  };
> > >
> > >  struct nfs42_removexattrres {
> > >         struct nfs4_sequence_res        seq_res;
> > >         struct nfs4_change_info         cinfo;
> > > +       struct nfs_fattr                *fattr;
> > > +       const struct nfs_server         *server;
> > >  };
> > >
> > >  #endif /* CONFIG_NFS_V4_2 */
> > >
> > > --
> > > 2.53.0
> > >
>
> --
> Jeff Layton <jlayton@kernel.org>

