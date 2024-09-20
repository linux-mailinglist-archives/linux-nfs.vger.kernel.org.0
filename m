Return-Path: <linux-nfs+bounces-6572-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECA597D87C
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 18:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC06284849
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BFA282F7;
	Fri, 20 Sep 2024 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="NEKtuD0Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66591BF37
	for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726850664; cv=none; b=TuDYjIa85cgNU8TStjn2AEyjPK7wqm++xnil6UtCXyvdq4n3n8y6mJhFc9C7xFisTC2MDkZD3Tnfjd4ldX1DLg98dAmvst3uW9v2sMzCJuwU64NkdXbA+5kDoouqWjTeyiI5/GPvEg8Qoz0PcbSKZrgIkIK69E9uGBr8zIbR/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726850664; c=relaxed/simple;
	bh=xQQt2zvyPe3h3nWnUctwwSKlmG8ZZw9E6Q2VnzRDeQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5j/tNtQlxOzxh0cSVPIkJZci1H2FqTxIFeE1CpLaaVDzir9MAR9k462mJMGNuz5thRwk1phE7p8e7DfvltWAPaAKcrRMSAOyFqAXmzaRxt9+Z6u7nQKfX1j6sBPSI1Iv2yAobHpCc3XOin92D9M99kdfIThoNkEqHJG3q5SE7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=NEKtuD0Y; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75c6ed397so25657581fa.2
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2024 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1726850661; x=1727455461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3FcY2TZu+dDLGdwDOFcmZCtV7zybX3lUfu7lr1SklQ=;
        b=NEKtuD0YblSwSys9DVxr2Mc4ywg3IuopuvEZ2IRAzGjqBjdeCjnT/PnMgu13MXQ303
         E+g4cVhZXg3ETHu+JkiOlieMr/F6LKfePnyVuNuyfArNCvAbqEzjFGjtEl2xYh31KqrN
         VouOJ3qKzFr6K3jtU2oir+W8dpVN7b0MyKXEmCp03MSkLnR2jlv6vJ7vC/niakVHaS/Q
         SG/eqKN3B0NQNEISxkdOwm6Y9E7KrlW6xgClReRK46V6j+qdgmrhj9Ry9LP8gKS8MIX2
         6akMqWGjmimWhZzvEG39z9fTg5GOoXM+7mLEjRwx12FF2OograrA2JzDJnP4JRgDzpgX
         aMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726850661; x=1727455461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3FcY2TZu+dDLGdwDOFcmZCtV7zybX3lUfu7lr1SklQ=;
        b=NuPB8PRJfmeIQCxQyUjW2tNt9mTsN0dm9rjeTB3eBSYYvsc2TuTTWsqLlvr7FZ/bzW
         9fSpnyiUXZj5BmjHo8XAfe2R3KUMbGwbeLjbObFrVwWzt5KptwQ48rWSr2jVN3DQwvTW
         vWwK3BpSbGXO8+dvPRB1eGwyhYzr4O2SqxcPMEzhvaQxJhtLnKrjYiQu6uPpPaOcHJ+C
         Sqb46TVJNDj+Fm6y98sLakS+dz+jNBCbwh1lkGA8A4btqfZkv8/WaWrTmtVuPRRIfsJ8
         TmkjrHPXCdRm0PUTDXmgsiIBBSShJJw/jgq9XxA6hnglK4l2NExTI7EoXHW+NF/sQAji
         JjsA==
X-Forwarded-Encrypted: i=1; AJvYcCVoPXaNKEVPZLQsPX6BGVsEv/KX1NchMB9dzF7YyCxZTZmgPjkNOOArttNF0jHia53gGo2zeQs5rbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1/B4NIa6WLt2W2eVn7yh/2W7h9+WeBzcP4p7r2VeysVHPMNn
	au9hL0EgT8qdLDj9hNqbXIE0IU88VTBsZuzmjMLyCCsE9mErk3zysFF/F7B5GfKE8vD6UXFcifg
	Te2K2iQHYBVwhn5zpjXEFKb0q9HQ=
X-Google-Smtp-Source: AGHT+IFF2JPoEVV0gmUzTKVyBPnngJZVs5dbkmbfhTSdr7DFjooAcn1oGG5e5lva5LsIS01cvWahg1iigIqH6PQySGk=
X-Received: by 2002:a2e:515a:0:b0:2f6:1d35:1491 with SMTP id
 38308e7fff4ca-2f7cc365c02mr14521541fa.15.1726850660691; Fri, 20 Sep 2024
 09:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920160551.52759-1-okorniev@redhat.com> <995712d148b21cd238c9604c58f42fe7a4b1581a.camel@kernel.org>
 <FA97862C-82C5-4879-B9AE-F5F5B813150B@oracle.com> <1b1135a9a2388df5aa9eabe85b85a8a624b87fe6.camel@kernel.org>
In-Reply-To: <1b1135a9a2388df5aa9eabe85b85a8a624b87fe6.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 20 Sep 2024 12:44:09 -0400
Message-ID: <CAN-5tyEKP=zctiCmcwHMshYQb1jrnk-5fq2iZo4vdJx9ajwJKw@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: fix handling of WANT_DELEG_TIMESTAMPS on open
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 12:34=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Fri, 2024-09-20 at 16:30 +0000, Chuck Lever III wrote:
> >
> > > On Sep 20, 2024, at 12:24=E2=80=AFPM, Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Fri, 2024-09-20 at 12:05 -0400, Olga Kornievskaia wrote:
> > > > Current, the server returns that it supports NFS4_SHARE_WANT_DELEG_=
TIMESTAMPS
> > > > but when the client sends that on the open, knfsd returns back with
> > > > bad_xdr error.
> > > >
> > > > Fixes: d0eab73d48a0 ("nfsd: add support for delegated timestamps")
> > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > ---
> > > > fs/nfsd/nfs4xdr.c | 1 +
> > > > 1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > > index c0bad580ab6d..adda8b489175 100644
> > > > --- a/fs/nfsd/nfs4xdr.c
> > > > +++ b/fs/nfsd/nfs4xdr.c
> > > > @@ -1109,6 +1109,7 @@ static __be32 nfsd4_decode_share_access(struc=
t nfsd4_compoundargs *argp, u32 *sh
> > > > case NFS4_SHARE_PUSH_DELEG_WHEN_UNCONTENDED:
> > > > case (NFS4_SHARE_SIGNAL_DELEG_WHEN_RESRC_AVAIL |
> > > >       NFS4_SHARE_PUSH_DELEG_WHEN_UNCONTENDED):
> > > > + case NFS4_SHARE_WANT_DELEG_TIMESTAMPS:
> > > > return nfs_ok;
> > > > }
> > > > return nfserr_bad_xdr;
> > >
> > > Ouch.
> > >
> > > The problem here is that we had to drop the patch that added
> > > OPEN_XOR_DELEGATION support. That patch reworked the flag handling in
> > > this function in a way that allowed the new delstid flags to be
> > > properly supported.
> > >
> > > I think we probably want to resurrect the parts of this patch that
> > > alter nfsd4_decode_share_access:
> > >
> > > https://lore.kernel.org/linux-nfs/20240905-delstid-v4-8-d3e5fd34d107@=
kernel.org/
> > >
> > > Olga, would you be OK with that approach instead?
> >
> > At this point, I'd like to consider postponing the delstid patches
> > until v6.13. They haven't gotten enough testing in their current
> > form...
> >
>
> It's your call, but that seems like an extreme reaction to a flag
> handling fix, given that we have several weeks of -rc's ahead of us.

I'm OK with whatever fix/approach it's going to go (Jeff if you have a
patch to test that would go on top of what's in Chuck's nfsd-next and
fixes the issue do post it) . I'm not ok with the code that's at the
moment in nfsd-next :).

> --
> Jeff Layton <jlayton@kernel.org>
>

