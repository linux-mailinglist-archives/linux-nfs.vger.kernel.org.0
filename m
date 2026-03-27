Return-Path: <linux-nfs+bounces-20477-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPeUInzdxmkoPQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20477-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 20:41:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE2C34A4BE
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 20:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DD5130071D0
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 19:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC98138C428;
	Fri, 27 Mar 2026 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="IFVEr1No"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676137F73E
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640194; cv=pass; b=efrbYGozrIFjjgePRC1W404QOjNPvOyv1tFi56Cg3e4Q+8qR3oc/WLUDwDlwZnq2oUj0MHmN8Iu9uJw4yXKKDJcUaIcsVbU5OIycVIR8K5IocGK4XwuzA31W1zlCR8SWx0y3AE4HGcnHJL8uEVyL6lMrhDnumL3lPGyTthlfmXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640194; c=relaxed/simple;
	bh=yteAyHsA5zSguEZN4/4WcPm/6xtCAUKkdDGunOCF4Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWHiO47W88lHMYTwd9KM/PWBs6nAVDTwInYYt/MKj5/yyrpw5/EQhJuofWu/3MU9/Aw3oFJcIS1rJ5iikSbSEZVBunDLZkWdK3Oir4eC7QWRkGWGuY8ud8T1rQt9sLw/3k+wMq6KzjO63JG0bQRK6ZE87dAR/pt9gRHAWXZy4uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=IFVEr1No; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38a01c80c34so22742801fa.0
        for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 12:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774640184; cv=none;
        d=google.com; s=arc-20240605;
        b=JInD+/GjRW02/408g8P7jcGOGwm4WjXgo0PN5vw3d5P6qbqtzZ14GYw/m9rk2Aop2I
         QfohHWb5H7pusneG4FCm9eUcsV4rJmke5UES8Buf4z/a59DMPhgm6ro2bNplAZynQ8Un
         iHp+JnejhHD/6X8PyjbvHD0XfUPVimOBI81xHWuLknNi4iPCfe6K0JE7VB5yJ3XLvLIa
         DP0+6FpFkJ7S4Ss3IIUPfjjSsIuI1fh+VZjagsqNQR/fKFTBxvgNL0wPn5qRwLItxTn9
         TLO3azw3CYNI4kwdHfCRzsVlO78+sOo335uhB22kKdybkXdNrPegRHG/BS/jo2bUbtAW
         NBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=05MorGjsfO+HnncjyXt2q04hu4pnbeOWhA6z8gVhqe8=;
        fh=U7NtncoTYnB9oeCkGZI1NnDUXgvSOAiGKA6FFzDdKuQ=;
        b=N7NShxC5JM1rLPLNUeL43aH2LkjPoZAYYPzPOt/wtkX79HNb+7Q65FF7NCok3yeCts
         quYZFx/Gv0u+bXnaIXXEAF89eKBgyTLdoQdxBhfcoUYIKiv5Cigk37bkR4149Rnch/Om
         pD9VKiZVDngyODbvZsxhbObS6Yg1sCskxmfNTMa5M/BGXPrjNCiyQSfBYO3GYecWC6Vj
         TLmuJei6b1hPL7D3jC4EGbm4H37IX3vo8wPMOvbEz5kkkv5gbwYHEk+d3v3PHnUAg/JZ
         /WNbBfvbKG+/Kg+kcwNr/R5tbBlY7lyaRRX7ItGK9ZF9OWGQRokwOsKBc1jK7tF4BwpT
         iStA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1774640184; x=1775244984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05MorGjsfO+HnncjyXt2q04hu4pnbeOWhA6z8gVhqe8=;
        b=IFVEr1No+icchIKl8IJE0NGXWtTR/MMWO6br/a3H3fiKhzQz6yLcLXjJ/h7pHeJ2Zp
         F66HifHwmFTo97728qChQ4RyOaQMG5exMRImjnhJNoUO4CDX8Nmpwk98Log8rHbBoTE4
         9Fwv5kuGPy5tWGLfA29I0UnBYEUuOIEEofurrt6+DFDhEBeCaQnbNmR1Qm05iHWOOxY3
         ++n2KwJjsG38nep7QCcBWDY6yhWcMHbj9bHeC1AylT+hbzPE0tjyIEbjRsOQGlLTm2ws
         Ih/EdCAgvr+Wa9cQAjnDEDRiKepyDhzry8jT+52MS1IEEqoriiCFGYqTpXsTuDc+Tmu0
         lgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774640184; x=1775244984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=05MorGjsfO+HnncjyXt2q04hu4pnbeOWhA6z8gVhqe8=;
        b=j0xLc6n/GI5ZMB6DKoh/j11t3+Oq7X63K/9HlBYEHVePQERVZstcFuiNuy0p2YsoWU
         beSWISdFWUpineSTXNfXnXLDbNA615O3VXYotaUEPrXQgRb8xyroB0wM57U5yZz4zoRG
         rd/oX3t5bJPpztDKOPgD5zpRlllsg9mwMqMar8BC6PCYSQLOJ0FQCl09syGbyQXpejh1
         vbb6fRwtVjDvOLrdotuoAQzapMiEqTLJfJ4NTNjk8v6miQ/2sScXQF1Jbw3eOE+5DM89
         1Cn2XTNgZaIq/B8Qecw4Djlhi6Vi9MbYqClKoZe+L0Pb45X3VrOXZEzbaaiV0i3xeAZV
         gLZA==
X-Forwarded-Encrypted: i=1; AJvYcCXEJN7GwLFrBsRyG3ml1Wf1VR/gp40XB0xAKuh41GesBRH7Q5QiQnuyLG9ceiV1zZ71wuiUDPFi9Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzevf18/b9dlTKxhOMUhiFvI1gI4SILLWOOkgSkjgYnd23V9G1g
	zY5Fm487len/KZHhfzsIT9KklCiFMBhY55HfFlSEnXbEOIuR3FWPv32Dzb6fIXhcLb1BDM9z7mK
	9kXCpVdweuYLgC9bLuO9TNOE3RSs4/mE=
X-Gm-Gg: ATEYQzxBAwCH6lPl/qZRWMwZpvlquEeK5L3n5GxfsdAcN8w5n63s+3Nnj4rtUbFLL7i
	zQQmQiPTW8dbs0dxgGshSqaU/XF7X9NWYwcqHaJE63SRJxtZedDJbx7X1Ge7IlMGRWGQM5Urw1S
	ou2atxAXtHXE+nFHuld+sFGb/dkZH60dH0XmexlD2eCkz2LkqskS7l4h/d7bjVnE8+GyD/p7Rh1
	RlvZnylqpqWJh05kGFXNdLCyhN2sc3h29L6qX3Y16AJXcA9oouUEhjXX7KCsY5LXmNWc2hUHR76
	3k6jpTpQGaPOu7uMWnxB8OjQPig5VxiGp16I3eIoLq7m4r9EfgZK
X-Received: by 2002:a05:651c:b24:b0:38b:f0f0:e3a8 with SMTP id
 38308e7fff4ca-38c7308685amr13172861fa.3.1774640184040; Fri, 27 Mar 2026
 12:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
 <20260324-nfs-7-1-v2-2-d110da3c0036@kernel.org> <CAN-5tyFpsuE9+5ZvAASwvTYKtcN5jNpAxi8ejde90e-vpUzFKg@mail.gmail.com>
 <284ca17e74af8c4f5942b2952f2bf75490dd17c0.camel@kernel.org>
 <CAN-5tyFsEUcSUycb4JjxH5v754SefwOH=zt24KtxEC_Ow4OjMw@mail.gmail.com>
 <80b423c66dba84b46be1084307d2c66b935065bc.camel@kernel.org> <acbJsryTMYCMlE_o@mana>
In-Reply-To: <acbJsryTMYCMlE_o@mana>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 27 Mar 2026 15:36:12 -0400
X-Gm-Features: AQROBzAUlUxbv5eX73qoQtO7P6uuWCzXr7EoalqZFwqIyzTxo6DYF3oIk69TUVs
Message-ID: <CAN-5tyFQrt7WyW4=qLodKS2-eckAetKjs15A6U1OOdGPSL58XQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nfs: update inode ctime after removexattr operation
To: Thomas Haynes <loghyr@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20477-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[umich.edu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,umich.edu:dkim,umich.edu:email]
X-Rspamd-Queue-Id: DCE2C34A4BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 2:22=E2=80=AFPM Thomas Haynes <loghyr@gmail.com> wr=
ote:
>
> On Fri, Mar 27, 2026 at 12:59:54PM -0800, Jeff Layton wrote:
> > On Fri, 2026-03-27 at 12:20 -0400, Olga Kornievskaia wrote:
> > > On Fri, Mar 27, 2026 at 11:50=E2=80=AFAM Jeff Layton <jlayton@kernel.=
org> wrote:
> > > >
> > > > On Fri, 2026-03-27 at 11:11 -0400, Olga Kornievskaia wrote:
> > > > > On Tue, Mar 24, 2026 at 1:32=E2=80=AFPM Jeff Layton <jlayton@kern=
el.org> wrote:
> > > > > >
> > > > > > xfstest generic/728 fails with delegated timestamps. The client=
 does a
> > > > > > removexattr and then a stat to test the ctime, which doesn't ch=
ange. The
> > > > > > stat() doesn't trigger a GETATTR because of the delegated times=
tamps, so
> > > > > > it relies on the cached ctime, which is wrong.
> > > > > >
> > > > > > The setxattr compound has a trailing GETATTR, which ensures tha=
t its
> > > > > > ctime gets updated. Follow the same strategy with removexattr.
> > > > >
> > > > > This approach relies on the fact that the server the serves deleg=
ated
> > > > > attributes would update change_attr on operations which might now
> > > > > necessarily happen (ie, linux server does not update change_attri=
bute
> > > > > on writes or clone). I propose an alternative fix for the failing
> > > > > generic/728.
> > > > >
> > > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > > index 7b3ca68fb4bb..ede1835a45b3 100644
> > > > > --- a/fs/nfs/nfs42proc.c
> > > > > +++ b/fs/nfs/nfs42proc.c
> > > > > @@ -1389,7 +1389,13 @@ static int _nfs42_proc_removexattr(struct =
inode
> > > > > *inode, const char *name)
> > > > >             &res.seq_res, 1);
> > > > >         trace_nfs4_removexattr(inode, name, ret);
> > > > >         if (!ret)
> > > > > -               nfs4_update_changeattr(inode, &res.cinfo, timesta=
mp, 0);
> > > > > +               if (nfs_have_delegated_attributes(inode)) {
> > > > > +                       nfs_update_delegated_mtime(inode);
> > > > > +                       spin_lock(&inode->i_lock);
> > > > > +                       nfs_set_cache_invalid(inode, NFS_INO_INVA=
LID_BLOCKS);
> > > > > +                       spin_unlock(&inode->i_lock);
> > > > > +               } else
> > > > > +                       nfs4_update_changeattr(inode, &res.cinfo,=
 timestamp, 0);
> > > > >
> > > > >         return ret;
> > > > >  }
> > > > >
> > > >
> > > > What's the advantage of doing it this way?
> > > >
> > > > You just sent a REMOVEXATTR operation to the server that will chang=
e
> > > > the mtime there. The server has the most up-to-date version of the
> > > > mtime and ctime at that point.
> > >
> > > In presence of delegated attributes, Is the server required to update
> > > its mtime/ctime on an operation? As I mentioned, the linux server doe=
s
> > > not update its ctime/mtime for WRITE, CLONE, COPY.
> > >
> > > Is possible that
> > > some implementations might be different and also do not update the
> > > ctime/mtime on REMOVEXATTR?
> > >
> > > Therefore I was suggesting that the patch
> > > relies on the fact that it would receive an updated value. Of course
> > > perhaps all implementations are done the same as the linux server and
> > > my point is moot. I didn't see anything in the spec that clarifies
> > > what the server supposed to do (and client rely on).
> > >
> >
> > (cc'ing Tom)
> >
> > That is a very good point.
> >
> > My interpretation was that delegated timestamps generally covered
> > writes, but SETATTR style operations that do anything beyond only
> > changing the mtime can't be cached.
> >
> > We probably need some delstid spec clarification: for what operations
> > is the server required to disable timestamp updates when a write
> > delegation is outstanding?
> >
> > In the case of nfsd, we disable timestamp updates for WRITE/COPY/CLONE
> > but not SETATTR/SETXATTR/REMOVEXATTR.
> >
> > How does the Hammerspace anvil behave? Does it disable c/mtime updates
> > for writes when there is an outstanding timestamp delegation like we're
> > doing in nfsd? If so, does it do the same for
> > SETATTR/SETXATTR/REMOVEXATTR operations as well?
>
> Jeff,
>
> I think the right way to look at this is closer to how size is
> handled under delegation in RFC8881, rather than as a per-op rule.
>
> In our implementation, because we are acting as an MDS and data I/O
> goes to DSes, we already treat size as effectively delegated when
> a write layout is outstanding. The MDS does not maintain authoritative
> size locally in that case. We may refresh size/timestamps internally
> (e.g., on GETATTR by querying DSes), but we don=E2=80=99t treat that as
> overriding the delegated authority.
>
> For timestamps, our behavior is effectively the same model. When
> the client holds the relevant delegation, the server does not
> consider itself authoritative for ctime/mtime. If current values
> are needed, we can obtain them from the client (e.g., via CB_GETATTR),
> and the client must present the delegation stateid to demonstrate
> that authority. So the authority follows the delegation, not the
> specific operation.

What happens when the client holding the attribute delegation (it's
the authority) is doing the query? Is it the server's responsibility
to query the client before replying. Example, client sends a CLONE
operation which has a GETATTR attached. (1) is the server supposed to
issue a CB_GETATTR before replying to the compound? (2) is the client
not supposed to send any GETATTRs while holding an attribute
delegation? CLONE is a modifying operation but client hasn't done any
actual modifications to the opened file so a CB_GETATTR would return
that file hasn't been modified. Is the server then not going to
express that the file has indeed been modified when replying to
GETATTR?

> That said, I don=E2=80=99t think we=E2=80=99ve fully resolved the semanti=
cs for all
> metadata-style ops either. WRITE and SETATTR are clear in our model,
> but for things like CLONE/COPY/SETXATTR/REMOVEXATTR, we=E2=80=99ve likely
> been relying on assumptions rather than a fully consistent rule.
> I.e., CLONE and COPY we just pass through to the DS and we don't
> implement SETXATTR/REMOVEXATTR.
>
> So the spec question, as I see it, is not whether REMOVEXATTR (or
> any particular op) should update ctime/mtime, but whether delegated
> timestamps are meant to follow the same attribute-authority model
> as delegated size in RFC8881. If so, then we expect that the server
> should query the client via CB_GETATTR to return updated ctime/mtime
> after such operations while the delegation is outstanding.
>
> Thanks,
> Tom
>
>
> >
> >
> >
> > > > It's certainly possible that the REMOVEXATTR is the only change tha=
t
> > > > occurred. With what I'm proposing, we don't even need to do a SETAT=
TR
> > > > at all if nothing else changed. With your version, you would.
> > > >
> > > > > >
> > > > > > Fixes: 3e1f02123fba ("NFSv4.2: add client side XDR handling for=
 extended attributes")
> > > > > > Reported-by: Olga Kornievskaia <aglo@umich.edu>
> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > ---
> > > > > >  fs/nfs/nfs42proc.c      | 18 ++++++++++++++++--
> > > > > >  fs/nfs/nfs42xdr.c       | 10 ++++++++--
> > > > > >  include/linux/nfs_xdr.h |  3 +++
> > > > > >  3 files changed, 27 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > > > index 7b3ca68fb4bb3bee293f8621e5ed5fa596f5da3f..7e5c1172fc11c9d=
5a55b3621977ac83bb98f7c20 100644
> > > > > > --- a/fs/nfs/nfs42proc.c
> > > > > > +++ b/fs/nfs/nfs42proc.c
> > > > > > @@ -1372,11 +1372,15 @@ int nfs42_proc_clone(struct file *src_f=
, struct file *dst_f,
> > > > > >  static int _nfs42_proc_removexattr(struct inode *inode, const =
char *name)
> > > > > >  {
> > > > > >         struct nfs_server *server =3D NFS_SERVER(inode);
> > > > > > +       __u32 bitmask[NFS_BITMASK_SZ];
> > > > > >         struct nfs42_removexattrargs args =3D {
> > > > > >                 .fh =3D NFS_FH(inode),
> > > > > > +               .bitmask =3D bitmask,
> > > > > >                 .xattr_name =3D name,
> > > > > >         };
> > > > > > -       struct nfs42_removexattrres res;
> > > > > > +       struct nfs42_removexattrres res =3D {
> > > > > > +               .server =3D server,
> > > > > > +       };
> > > > > >         struct rpc_message msg =3D {
> > > > > >                 .rpc_proc =3D &nfs4_procedures[NFSPROC4_CLNT_RE=
MOVEXATTR],
> > > > > >                 .rpc_argp =3D &args,
> > > > > > @@ -1385,12 +1389,22 @@ static int _nfs42_proc_removexattr(stru=
ct inode *inode, const char *name)
> > > > > >         int ret;
> > > > > >         unsigned long timestamp =3D jiffies;
> > > > > >
> > > > > > +       res.fattr =3D nfs_alloc_fattr();
> > > > > > +       if (!res.fattr)
> > > > > > +               return -ENOMEM;
> > > > > > +
> > > > > > +       nfs4_bitmask_set(bitmask, server->cache_consistency_bit=
mask,
> > > > > > +                        inode, NFS_INO_INVALID_CHANGE);
> > > > > > +
> > > > > >         ret =3D nfs4_call_sync(server->client, server, &msg, &a=
rgs.seq_args,
> > > > > >             &res.seq_res, 1);
> > > > > >         trace_nfs4_removexattr(inode, name, ret);
> > > > > > -       if (!ret)
> > > > > > +       if (!ret) {
> > > > > >                 nfs4_update_changeattr(inode, &res.cinfo, times=
tamp, 0);
> > > > > > +               ret =3D nfs_post_op_update_inode(inode, res.fat=
tr);
> > > > > > +       }
> > > > > >
> > > > > > +       kfree(res.fattr);
> > > > > >         return ret;
> > > > > >  }
> > > > > >
> > > > > > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > > > > > index 5c7452ce6e8ac94bd24bc3a33d4479d458a29907..ec105c62f721cfe=
01bfc60f5981396958084d627 100644
> > > > > > --- a/fs/nfs/nfs42xdr.c
> > > > > > +++ b/fs/nfs/nfs42xdr.c
> > > > > > @@ -263,11 +263,13 @@
> > > > > >  #define NFS4_enc_removexattr_sz                (compound_encod=
e_hdr_maxsz + \
> > > > > >                                          encode_sequence_maxsz =
+ \
> > > > > >                                          encode_putfh_maxsz + \
> > > > > > -                                        encode_removexattr_max=
sz)
> > > > > > +                                        encode_removexattr_max=
sz + \
> > > > > > +                                        encode_getattr_maxsz)
> > > > > >  #define NFS4_dec_removexattr_sz                (compound_decod=
e_hdr_maxsz + \
> > > > > >                                          decode_sequence_maxsz =
+ \
> > > > > >                                          decode_putfh_maxsz + \
> > > > > > -                                        decode_removexattr_max=
sz)
> > > > > > +                                        decode_removexattr_max=
sz + \
> > > > > > +                                        decode_getattr_maxsz)
> > > > > >
> > > > > >  /*
> > > > > >   * These values specify the maximum amount of data that is not
> > > > > > @@ -869,6 +871,7 @@ static void nfs4_xdr_enc_removexattr(struct=
 rpc_rqst *req,
> > > > > >         encode_sequence(xdr, &args->seq_args, &hdr);
> > > > > >         encode_putfh(xdr, args->fh, &hdr);
> > > > > >         encode_removexattr(xdr, args->xattr_name, &hdr);
> > > > > > +       encode_getfattr(xdr, args->bitmask, &hdr);
> > > > > >         encode_nops(&hdr);
> > > > > >  }
> > > > > >
> > > > > > @@ -1818,6 +1821,9 @@ static int nfs4_xdr_dec_removexattr(struc=
t rpc_rqst *req,
> > > > > >                 goto out;
> > > > > >
> > > > > >         status =3D decode_removexattr(xdr, &res->cinfo);
> > > > > > +       if (status)
> > > > > > +               goto out;
> > > > > > +       status =3D decode_getfattr(xdr, res->fattr, res->server=
);
> > > > > >  out:
> > > > > >         return status;
> > > > > >  }
> > > > > > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > > > > > index ff1f12aa73d27b6fd874baf7019dd03195fc36e5..fcbd21b5685f461=
36a210c8e11c20a54d6ed9dad 100644
> > > > > > --- a/include/linux/nfs_xdr.h
> > > > > > +++ b/include/linux/nfs_xdr.h
> > > > > > @@ -1611,12 +1611,15 @@ struct nfs42_listxattrsres {
> > > > > >  struct nfs42_removexattrargs {
> > > > > >         struct nfs4_sequence_args       seq_args;
> > > > > >         struct nfs_fh                   *fh;
> > > > > > +       const u32                       *bitmask;
> > > > > >         const char                      *xattr_name;
> > > > > >  };
> > > > > >
> > > > > >  struct nfs42_removexattrres {
> > > > > >         struct nfs4_sequence_res        seq_res;
> > > > > >         struct nfs4_change_info         cinfo;
> > > > > > +       struct nfs_fattr                *fattr;
> > > > > > +       const struct nfs_server         *server;
> > > > > >  };
> > > > > >
> > > > > >  #endif /* CONFIG_NFS_V4_2 */
> > > > > >
> > > > > > --
> > > > > > 2.53.0
> > > > > >
> > > >
> > > > --
> > > > Jeff Layton <jlayton@kernel.org>
> >
> > --
> > Jeff Layton <jlayton@kernel.org>
>

