Return-Path: <linux-nfs+bounces-1711-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 532DC84721C
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 15:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E741B1F2A808
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C75C14198A;
	Fri,  2 Feb 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXJ/C8B9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A820DFA
	for <linux-nfs@vger.kernel.org>; Fri,  2 Feb 2024 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884964; cv=none; b=uJyJ7r91JnSAlMV0YPNp4CL8VtaRxhLmQxaHO8uN5PRsB0W0jODiEFtPOxa3lWF6r+MrciG/LdofZbPR+f2WREhO3Re2Gi2tTKTeGHWEv92oCtD/uZ1s3vwFMeTbhqlGrC6xNbWvNac5n/jt/gBoQZ9LsGT4CEWX6iNNl/60rgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884964; c=relaxed/simple;
	bh=TRCl+YrSin8HrqhwoiBmPkcOulABphUcb4fIuj9Gwnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIlEr7DI5Pom+jEVRKISz9ohMwX4/wfTghrn65FYK0AeafG0f81XTcnXO5gudDq8d+8/MWwJyepgpfkTz5mClD0WHrAldQwdb2YuYk+JhrUW/BltYit6KJXM6iphEnTJsJjUgVBM8S3TmZuYjIPO4hAxT8G2ohvaRNQSPHR0chE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXJ/C8B9; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd3aea2621so3979961fa.1
        for <linux-nfs@vger.kernel.org>; Fri, 02 Feb 2024 06:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706884960; x=1707489760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMhwc1epTKsg2YjiSzkxPePnumev5HPpecb0kbZdC+c=;
        b=JXJ/C8B9qghPvoCz/A0DnJB/0xXN+eCX7p9aNqE/1kDvZAUYthF7/OG7SH4aq/MvSP
         0fOHDZhCDqjhKTajcaZh7Q6h+81HjIMbQhVnl6Ub72IXTsFhCEw+y+0PO+flm2g5OaL8
         cLCh2hkwurMYVNJIaiZZplLwa+OQthHgFvSXFhVmukeKFp5XwwgWwC+vvZbuKudUysDI
         SYXsHc6uyQRUu4jI6z74l+NcOVkdalECaz1DPBtm7yJ2F/5AKPXV7Z/WMXH6LObaxfh6
         areIIeOdwUqRKJvyBOGFT0IoFn5CkdDnnTT+jaf06k/Vsucy1u2ZUR5OW6jcQTzON8VF
         yacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706884960; x=1707489760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMhwc1epTKsg2YjiSzkxPePnumev5HPpecb0kbZdC+c=;
        b=UQAhD+lfCFYYuDmkVvfSY8+Cmi4o/SVSorgubY/0LTZTXCIpN46ILpLCf9UtdTeqHv
         tvMu8DPF7Zt+wB+Kfi3tufcbTag948dy7zfVy4b/B352dhcxADnumXFzQTr5omXayDhy
         yYybQumwnkkoUhR90nplXlNx5KeLCOmNd6YTIcTZJ9wRRmEGEA5Ayf3vh1LBrE1Jrkpr
         R3vIezHO0flUoKs6F7uoBVGtoTwSfbWWozQCkU1zoWpoMb0DU35ZR98EaEn9KtParlx5
         SHCCVZed+utTZ9qNLdv1rg6BjozuEuPARJcmlLpk2Evd9mokfuOZls37WS/s7QYAoJlD
         vKaQ==
X-Gm-Message-State: AOJu0YxAmAZjLLCfw1uYbHnndpGlYwywLDv0fC+eIeXgiHqyYVyA31EQ
	TzizLdBgqqpsmLThhUOouZcGzLDUvj/PatAZkggBMdlOkdqnAwyu+E7cgE5BhAQvcJGlizfnCkU
	UNLpWFqPPj1gWnbQ0H3ANswz4rpI=
X-Google-Smtp-Source: AGHT+IF/55fejmSkJdvH3iwxbSEcaWLvqrsqPti57khUudpC/vjkKipfwmhyUqsU1Y44VdE4iC1zgqbflUNYg9gX2qI=
X-Received: by 2002:a05:651c:2127:b0:2d0:8c5d:4254 with SMTP id
 a39-20020a05651c212700b002d08c5d4254mr1041052ljq.3.1706884960302; Fri, 02 Feb
 2024 06:42:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126190333.13528-1-olga.kornievskaia@gmail.com> <1DBC4AE1-E253-454F-9E7E-12DFBA14EBA6@redhat.com>
In-Reply-To: <1DBC4AE1-E253-454F-9E7E-12DFBA14EBA6@redhat.com>
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date: Fri, 2 Feb 2024 09:42:28 -0500
Message-ID: <CAN-5tyGDQaaud7emd-Sgx_0E31bLx0k6EgrONSp0SbfoMTwY9A@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1: add tracepoint to trunked nfs4_exchange_id calls
To: Benjamin Coddington <bcodding@redhat.com>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 8:01=E2=80=AFAM Benjamin Coddington <bcodding@redhat=
.com> wrote:
>
> On 26 Jan 2024, at 14:03, Olga Kornievskaia wrote:
>
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Add a tracepoint to track when the client sends EXCHANGE_ID to test
> > a new transport for session trunking.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/nfs4proc.c  |  3 +++
> >  fs/nfs/nfs4trace.h | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 23819a756508..cdda7971c945 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -8974,6 +8974,9 @@ void nfs4_test_session_trunk(struct rpc_clnt *cln=
t, struct rpc_xprt *xprt,
> >               status =3D nfs4_detect_session_trunking(adata->clp,
> >                               task->tk_msg.rpc_resp, xprt);
> >
> > +     trace_nfs4_trunked_exchange_id(adata->clp,
> > +                     xprt->address_strings[RPC_DISPLAY_ADDR], status);
> > +
>
> Any worry about the ambiguity of whether "status" comes from tk_status or
> from nfs4_detect_session_trunking() here?  The latter can return -EINVAL
> which isn't in show_nfs4_status().

Good catch, I didn't realize there wasn't an EINVAL mapping. I was
focusing on capturing the fact that exchangeid was happening and ip
info of the trunking connection that I didn't pay attention to the
status. I'll send a v2 with EINVAL added to show_nfs4_status.

> Otherwise, looks good to me.
>
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>
> Ben
>

