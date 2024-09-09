Return-Path: <linux-nfs+bounces-6343-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C01971C49
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 16:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9BC1C21A4E
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 14:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DF41B582D;
	Mon,  9 Sep 2024 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INyZA4qu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68B1BA26D
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891478; cv=none; b=YbdtqtBBWlR/1GHpVmElj+C1m4XgfKHeRKpV1EqaUcboXkMJvGrXBE2x/gonT8tGJvnPckD5G1BHvC7b0QnODr9Qj1lCEPgX+vb4oyXPbp5JhH6Emq5PYqxQ53R3zzU6JwHMHVj2+NmBIGtd7pOYu10/lrNgX2a6sQNLQ+0kdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891478; c=relaxed/simple;
	bh=hgb4P8rMk4LONlediDaLNb9YiGkTQ7Zo10No55YYTe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yeg2+LdAr/0NQFvUJM/5J41h0hd+8ai7KvEwRZFT9FMSUCG1JNi/q4oNL7cDUMgZ/0Mr2e4e5TCJTZyjk9nVyT9nuSY3Hf71gSqipq8PBs/O93SmB1IbfCbI7OpaVph+O38EDP8HiekaG21WsVxShwFG1W1iaZSrOODI+PCGSrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INyZA4qu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725891476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2ELdgTpBeSeGcqEPJeGqv0laCURtzIMOFd+sK4gIKo=;
	b=INyZA4qu8TnMJEgqbjv8REQ4L4j+cfYQDrd/8D+OaV6i1RpcSAnEIEVUELclFEn6tA2Q5+
	6ti7gBj3vuyOXtYI9QsNo8/cw9X7UMVWJVajoHkwi3RUKSl41B31/LEUeiv0IpbX93c3I6
	cfaUs7lKcPROMl4lJirZlM2vszzGRzE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-y9g59cOiNg2hn0EbySfwfw-1; Mon, 09 Sep 2024 10:17:54 -0400
X-MC-Unique: y9g59cOiNg2hn0EbySfwfw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c247f815b3so3225273a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2024 07:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725891473; x=1726496273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2ELdgTpBeSeGcqEPJeGqv0laCURtzIMOFd+sK4gIKo=;
        b=UpisE33t89hpHsBTUoaGYNJQeY8eS2YoZtT32G4z7U6DLV4TWFIUa7Xak21iKaS7Vw
         BVH4Rg0vsXh6KjBhWAk/0bJ+BQE1tfD6qxDrMTd3eIOa90EzBjC7X6y795Y6ygIxu3st
         A1HswU9Ct+dATZrq1cNZZFow1y4p7Kj2qS9/UcljZJUWqU7B0ZxN3S79G7cshsvnpyXU
         HBgO116/m/xTOFVmnEt470rX2ONZReXmy2TAsq8CIY06fbO2WbN+k2Ce4ZKmqXOirNmW
         ptIaPEMv5dGN4WFnR08YxgYEYcy+HV+6G+w1dJ+mzmyrxFEHfg1Jxa0JHPxG8oua7l/F
         xV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHcV5Hj/LrDL9Lss1NVgPLgTrhVVKSR1ubVlrSTkgDMj76M0Vi2Ny1bmjzz4RJtH7QAoUzcTn+rnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrwkCli1kfhlralm6KTA6pKIkwantXMdGe2MvheO4W2oP9FQFS
	RQeC6rg6DicQGFgRwwxG/7lTeqw5Jt5Gs4Rlv+vuQv5bEdKRjyMVJpGoauS6cRH5m2a3HeBH5G9
	zPBefntJ8I1hIph2bty7kNCK3ZDBo1V2hFnC9yOvYlBP5OcO5Y3lKuCVX6sWwUqF/aMaXSL77aV
	6hXWQDErr4YrsSXkoWXZmRSXSSzj0M/bIu
X-Received: by 2002:a05:6402:90d:b0:5bf:2577:32b8 with SMTP id 4fb4d7f45d1cf-5c3dc78d21emr9013919a12.9.1725891473561;
        Mon, 09 Sep 2024 07:17:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl9u7TJK2ngZix1Lvb9i7CGe2+vit/sLzy76sjpmZeKKbnJi5aJ0N0/h9fXzLnfSvLSCKMq8Gtwx4PyCgxm1c=
X-Received: by 2002:a05:6402:90d:b0:5bf:2577:32b8 with SMTP id
 4fb4d7f45d1cf-5c3dc78d21emr9013889a12.9.1725891472980; Mon, 09 Sep 2024
 07:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172585839640.4433.13337900639103448371@noble.neil.brown.name> <adadfa97e30bc4d827df194814e4e05aa26b8266.camel@kernel.org>
In-Reply-To: <adadfa97e30bc4d827df194814e4e05aa26b8266.camel@kernel.org>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Mon, 9 Sep 2024 10:17:42 -0400
Message-ID: <CACSpFtBYpQpAKVOmHLPUOr5LvoYq0-ea_NFMctqhMYSamUL_ZQ@mail.gmail.com>
Subject: Re: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 8:24=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Mon, 2024-09-09 at 15:06 +1000, NeilBrown wrote:
> > The pair of bloom filtered used by delegation_blocked() was intended to
> > block delegations on given filehandles for between 30 and 60 seconds.  =
A
> > new filehandle would be recorded in the "new" bit set.  That would then
> > be switch to the "old" bit set between 0 and 30 seconds later, and it
> > would remain as the "old" bit set for 30 seconds.
> >
>
> Since we're on the subject...
>
> 60s seems like an awfully long time to block delegations on an inode.
> Recalls generally don't take more than a few seconds when things are
> functioning properly.
>
> Should we swap the bloom filters more often?

I was also thinking that perhaps we can do 15-30s perhaps? Another
thought was should this be a configurable value (with some
non-negotiable min and max)?

> > Unfortunately the code intended to clear the old bit set once it reache=
d
> > 30 seconds old, preparing it to be the next new bit set, instead cleare=
d
> > the *new* bit set before switching it to be the old bit set.  This mean=
s
> > that the "old" bit set is always empty and delegations are blocked
> > between 0 and 30 seconds.
> >
> > This patch updates bd->new before clearing the set with that index,
> > instead of afterwards.
> >
> > Reported-by: Olga Kornievskaia <okorniev@redhat.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 6282cd565553 ("NFSD: Don't hand out delegations for 30 seconds a=
fter recalling them.")
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 4313addbe756..6f18c1a7af2e 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1078,7 +1078,8 @@ static void nfs4_free_deleg(struct nfs4_stid *sti=
d)
> >   * When a delegation is recalled, the filehandle is stored in the "new=
"
> >   * filter.
> >   * Every 30 seconds we swap the filters and clear the "new" one,
> > - * unless both are empty of course.
> > + * unless both are empty of course.  This results in delegations for a
> > + * given filehandle being blocked for between 30 and 60 seconds.
> >   *
> >   * Each filter is 256 bits.  We hash the filehandle to 32bit and use t=
he
> >   * low 3 bytes as hash-table indices.
> > @@ -1107,9 +1108,9 @@ static int delegation_blocked(struct knfsd_fh *fh=
)
> >               if (ktime_get_seconds() - bd->swap_time > 30) {
> >                       bd->entries -=3D bd->old_entries;
> >                       bd->old_entries =3D bd->entries;
> > +                     bd->new =3D 1-bd->new;
> >                       memset(bd->set[bd->new], 0,
> >                              sizeof(bd->set[0]));
> > -                     bd->new =3D 1-bd->new;
> >                       bd->swap_time =3D ktime_get_seconds();
> >               }
> >               spin_unlock(&blocked_delegations_lock);
>
> --
> Jeff Layton <jlayton@kernel.org>
>


