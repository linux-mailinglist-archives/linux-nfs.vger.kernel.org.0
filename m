Return-Path: <linux-nfs+bounces-6209-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE6696C837
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 22:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2A31F23E55
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 20:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA3A84A35;
	Wed,  4 Sep 2024 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1iVsWb0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE76BFA3;
	Wed,  4 Sep 2024 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480967; cv=none; b=qLgcJewrp3FLTjY7Uj4jwHRL78N0whmtekS93GnpvSd8i+5pjUga7EchyVnkkxDWT9vx4yHp9WgzS2XcGJgoYOXAez208bu3ZxQDnXbjV19kTcgEXdphbzDyHKX0D4TAxX9o9f4imsjEyxwKuu4PLl7dFJjGMuJXXQ75fxhmtp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480967; c=relaxed/simple;
	bh=N9pEA7Omn6xP3UqC/M2aQeukxkjLg/8s7NVCzR4woc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8e+eY45mCaVNKyM1KBxw+9U5V2P2aJ4fwyc0AxQIXQZ+jy5mhXRXoBnrKol7hd1di1lrnX75Fi/g/fQD8w11RSK04eGaNXbBrscru/3qhGMl3T9DwSyMFfYaPgKPhj/strQvlqae+XULv01s4l/7hUlnz7Vup+BzNK3bsm2SHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1iVsWb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51F3C4CEC2;
	Wed,  4 Sep 2024 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725480966;
	bh=N9pEA7Omn6xP3UqC/M2aQeukxkjLg/8s7NVCzR4woc4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s1iVsWb03xy1SzhXsCEyZ3YniDoDs+DCJItrTdsq22KQqmDkdvzw9OTRyoTjMJoPl
	 aXh+vCsVxxFhFQGr3l8xkvoePP7jD7D9uio69m02OcpLuZs82xDqAb5Fgo2WyUHEao
	 OKTfEsq81xAtJStJVPkOBrXDP7hFfm8L/Ml7X4w2oZ44SThQeBuFHo2b4TeDlgQ4iC
	 M+ZM41fBMaAPoZTJkReTKhoAnCwTw4OdCOKehT5d6LXyMlhqhY2k3CHEKsWGmFvg1j
	 iMayOlZWdygbNZDA4YNn4jHGiTfTYhrdcamIbGs0/eXXtb8vKJwuy5oqsP2UBpYfqZ
	 fiRmageTeoZAA==
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45681098bbdso239501cf.1;
        Wed, 04 Sep 2024 13:16:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYc0nDvykesBLgo6C/upl5D1jYlGOGBIFV6JxH436izZOYvxJ3Aqp6/iWwbZq0WAjbSuUWIRt749jA@vger.kernel.org, AJvYcCWNJhm4HaT/54L4MDPzE/QyNNlK600ahANML/8RM87GYuBUCt8M66cpe76t8QU2u1e33ZdW7VeDRsAGoCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp987cJ+cVuNgm8tNMawDwcqAN3PabXwUDGadGmqU5nIFuGwo8
	aHFZP+CB7ZrFFhlUeHQG28i6wC9nATTWguuPzgsi14SLDJiaeEdzE23W75fq3zGp18osc60NIMj
	SzoZ0q9KD0dMgBLTvy07tXnWaT+g=
X-Google-Smtp-Source: AGHT+IHr9Y6Dg9eP7sZxeH4HR9kNRElZ+3rzRfHghMYSGXfaAS6jENfgVVWuG+czF9mVb9LPkv13YNhOLMpns0EWjXI=
X-Received: by 2002:a05:622a:4c05:b0:457:d550:db86 with SMTP id
 d75a77b69052e-457f8c589b3mr64256671cf.26.1725480966267; Wed, 04 Sep 2024
 13:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904123457.3027627-1-lilingfeng3@huawei.com> <8ee4ce7c4eb56ec80365492407b76ee3dc4b6347.camel@kernel.org>
In-Reply-To: <8ee4ce7c4eb56ec80365492407b76ee3dc4b6347.camel@kernel.org>
From: Anna Schumaker <anna@kernel.org>
Date: Wed, 4 Sep 2024 16:15:49 -0400
X-Gmail-Original-Message-ID: <CAFX2Jf=H=ia5Cq6nk3zK_Z22H=5ehDC+NPE8TRyAB1QY4eKV9g@mail.gmail.com>
Message-ID: <CAFX2Jf=H=ia5Cq6nk3zK_Z22H=5ehDC+NPE8TRyAB1QY4eKV9g@mail.gmail.com>
Subject: Re: [PATCH] nfs: fix memory leak in error path of nfs4_do_reclaim
To: Trond Myklebust <trondmy@kernel.org>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, jlayton@kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:39=E2=80=AFAM Trond Myklebust <trondmy@kernel.org=
> wrote:
>
> On Wed, 2024-09-04 at 20:34 +0800, Li Lingfeng wrote:
> > Commit c77e22834ae9 ("NFSv4: Fix a potential sleep while atomic in
> > nfs4_do_reclaim()") separate out the freeing of the state owners from
> > nfs4_purge_state_owners() and finish it outside the rcu lock.
> > However, the error path is omitted. As a result, the state owners in
> > "freeme" will not be released.
> > Fix it by adding freeing in the error path.
> >
> > Fixes: c77e22834ae9 ("NFSv4: Fix a potential sleep while atomic in
> > nfs4_do_reclaim()")
> > Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> > ---
> >  fs/nfs/nfs4state.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> > index 877f682b45f2..30aba1dedaba 100644
> > --- a/fs/nfs/nfs4state.c
> > +++ b/fs/nfs/nfs4state.c
> > @@ -1957,6 +1957,7 @@ static int nfs4_do_reclaim(struct nfs_client
> > *clp, const struct nfs4_state_recov
> >                               set_bit(ops->owner_flag_bit, &sp-
> > >so_flags);
> >                               nfs4_put_state_owner(sp);
> >                               status =3D
> > nfs4_recovery_handle_error(clp, status);
> > +                             nfs4_free_state_owners(&freeme);
> >                               return (status !=3D 0) ? status : -
> > EAGAIN;
> >                       }
> >
>
> Nice catch! Yes, that leak has been there for quite a while. Thanks for
> finding it.

Looks good to me, too. I've applied this for v6.12 (with a cc stable
so it gets backported)

Anna

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

