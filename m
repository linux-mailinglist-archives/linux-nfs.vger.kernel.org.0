Return-Path: <linux-nfs+bounces-13812-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA11B2EDBD
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 08:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D306C1898B32
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 06:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D2E376F1;
	Thu, 21 Aug 2025 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEHnG64X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D91400E
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756029; cv=none; b=hXTOchyvxGs068SzJkPqQTgwWqbZVy6/Rsu1v/Ba0xS3rKSOZwK0DwkHA/YcXI2y7RPK2aw7AVaWfB/+alZZOjTb4op4iBrW6O4MfvupIjDyylRx+gOx2sLG2OxtyRja7LTP7LrNLyX/3CLWjueXp3vTetRiUAhZ4qfUGipy81Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756029; c=relaxed/simple;
	bh=6XDjqxbB/8/mtXrQqydn2jzeNVhTb3zCWHlhxKOM2Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6zUNhV2oFgPc90Uf+LQXBp+jVBK1D2XMDLEdQ+xGCK08bMYvYxifC7pIoaPOHfCRflkWfeWiRxvPZQN3im+WUgv9FfUDm54Csk3D9TyEy3Md1pm8rfEF5wu+AQHKrxqr1t83kGzK2z7jgdm+CPkuHdthL35udfkABeYo9q1UIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEHnG64X; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b0faa6601cso21690791cf.1
        for <linux-nfs@vger.kernel.org>; Wed, 20 Aug 2025 23:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755756026; x=1756360826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOEu788v/EL0O5TL3t65Z+R+bxkXhp7RlNTVXlWQCwo=;
        b=eEHnG64XLVj5/+8ky6jmYUiRKAoKnpJZz/GqUwQhwF0Qm4F4WxI43xN44L5tSHBl5C
         yhi/4njyezYWUP2oWMHdNdsZwfqMhpRA0ddN5o8twUJntP3z25tW+65qaUmv1IHQTsOC
         ejcd18RsKlTP7WoYZT5QHWih/dkmvL6mSavuT+QSq30W3Em5OTBtYUAPbVO6n3DLfZaR
         47ChshG5vP2+koa8ZeHk3o6BItfIb1Ghx/0Fad1KAHn3Ul1L/mQWBMgqJhVeIBo7nRI9
         UlXKmxaHLj3LaoyLRL0E7GfF1qFW8qYdqO+CI6Lgpwpg7PTbfE28IjK7Fl3GhBT2v7kJ
         nYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755756026; x=1756360826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOEu788v/EL0O5TL3t65Z+R+bxkXhp7RlNTVXlWQCwo=;
        b=Eu8Ii2DoU2di0zU4uAVaOXqd4gFCcX0NEcytBSg6ZE66zNy5eCEjHAglHlGiMs9NRy
         gnsZdB3n1C7RkHrWmrSO2ib3mlUtqS/dz7YqFNCIxJimAlt2vmJYi8Tf9otJcNJxiBzr
         JxdA26uQ6OZWmEUj600UYKY4RQqBsbADAbenbGXFzTbfoEEzUTQl8ZX5mFNi8bVCDyrv
         4YiuWTEqXMtJhrHZA4R/0vJIci/jSV74UKzwagaqixS1Iq5nMQNIk3d4BPezkJptoLjq
         WXdNvFFuLgEpeNLOEurKHSH5IKUuMEZ7KGfvttLinuD5klZ5dRcQQou9Lxt/j+9gKs34
         VMfw==
X-Gm-Message-State: AOJu0YzqzpT6w96KK1INRTMtHtHvhC8veh/2FeeSKYVBCaRbAh8NWqNL
	XRisYiUfoEmtfeD3oyDtID4lqz8vEkKQ/IDTRbk+a/44FR/YR786tE4jP2OTH2dO2RG2NLBKmC3
	cepYbVoNcVuvhj9NETb6qSPZkKzITT6Q=
X-Gm-Gg: ASbGncs/6x5fp4m+E0jvMqg0RPwqXpoUiLCgptECXRbUzEePk5OYW3285RJKTFSO85u
	nkWTlsM7TdpNPB2r1ftDsrd8LccP6qh1Qe5KZ6Cq/edOIig7WKj3dEcCJ4OMDWOugBIG/uccSGp
	Oi1o3Y3oIMFJADloFW7vNsZlJ6fvKAXUkZRZCjzvpiLlm3DLsM8RvlZuuR201/J2nWgyYWJzzi1
	XWAYs9UrnvuRyV/LIw=
X-Google-Smtp-Source: AGHT+IG4RbkqBeSThf2OwDRXZhsLjrB2uJZgGxHrwV0/53Zul/CaWejexhykK/DBYCLfsXPwo4N3DoQ9xcla4FzbuyY=
X-Received: by 2002:a05:622a:4247:b0:4b2:8ac5:2590 with SMTP id
 d75a77b69052e-4b2a04313b1mr12160231cf.35.1755756026279; Wed, 20 Aug 2025
 23:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALzt5Pk81rdgaBhk=s+cHEeSAP3rFrrsD3Q3Sx5rCsi_jkWuqQ@mail.gmail.com>
 <1473033738.919249.1754584380847.JavaMail.zimbra@desy.de> <CALzt5P=Ls6AcBEvEFtCqw7==ZnR21tRJGDeDe+3V1jxArh2beA@mail.gmail.com>
In-Reply-To: <CALzt5P=Ls6AcBEvEFtCqw7==ZnR21tRJGDeDe+3V1jxArh2beA@mail.gmail.com>
From: Haihua Yang <yanghh@gmail.com>
Date: Wed, 20 Aug 2025 23:00:16 -0700
X-Gm-Features: Ac12FXxzQ1ddtapopPpA02wPtw7QpYOneepGs2KU3U7tJB-OvY7XRxmk4wF5V0I
Message-ID: <CALzt5PkOrqOeRg7UR7kZjx-a4cfyjH98Qo8ysxs0zaa2fPq5Dw@mail.gmail.com>
Subject: Re: LAYOUTCOMMIT Failure After CB_LAYOUTRECALL in pNFS Filelayout Scenario
To: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>, Trond Myklebust <trondmy@gmail.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tigran and Trond,

The Linux client calls nfs4_layout_refresh_old_stateid when the server
returns NFS4ERR_OLD_STATEID in response to a LAYOUTRETURN, but it
doesn=E2=80=99t do the same for LAYOUTCOMMIT. Is there a specific reason fo=
r
this difference?
Thanks
Haihua Yang

On Thu, Aug 7, 2025 at 10:22=E2=80=AFAM Haihua Yang <yanghh@gmail.com> wrot=
e:
>
> Tigran,
> I forgot to mention in the previous email, after step 4, client also
> sends a reply to the CB_LAYOUTRECALL. But when retrying the
> LAYOUTCOMMIT afterword, it still uses seqid 1.
> From what I observed in the Linux implementation, the retry logic
> doesn=E2=80=99t update the request arguments, so the client ends up resen=
ding
> the same LAYOUTCOMMIT with the old seqid.
>
> Regards,
> Haihua Yang
>
>
> On Thu, Aug 7, 2025 at 9:33=E2=80=AFAM Mkrtchyan, Tigran
> <tigran.mkrtchyan@desy.de> wrote:
> >
> >
> >
> > ----- Original Message -----
> > > From: "Haihua Yang" <yanghh@gmail.com>
> > > To: "linux-nfs" <linux-nfs@vger.kernel.org>
> > > Sent: Thursday, 7 August, 2025 18:14:57
> > > Subject: LAYOUTCOMMIT Failure After CB_LAYOUTRECALL in pNFS Filelayou=
t Scenario
> >
> > > I'm observing a consistent failure of LAYOUTCOMMIT when the NFS clien=
t
> > > accesses a pNFS share using filelayout. Below is the sequence of
> > > events:
> > >  1, The client opens a file for writing and successfully receives a
> > > layout (stateid with seqid =3D 1).
> > >  2, The client writes data to the data server (DS) successfully.
> > >  3, The NFS server sends a CB_LAYOUTRECALL (stateid with seqid =3D 2)
> > > due to some change on the server side.
> > >  4, The client sends a LAYOUTCOMMIT (still with seqid =3D 1), followe=
d
> > > by a LAYOUTRETURN (with seqid =3D 2).
> > >  5, The server responds to LAYOUTCOMMIT with NFS4ERR_OLD_STATEID.
> > >  6, The server responds to LAYOUTRETURN with NFS4ERR_OK.
> > >  7, The client retries LAYOUTCOMMIT (still using seqid =3D 1).
> > >  8, The server replies with NFS4ERR_BAD_STATEID because the state was
> > > already removed when processing the LAYOUTRETURN.
> > >
> > > It seems there may be two issues with the Linux NFS client=E2=80=99s =
behavior:
> > >  1, The client should not send LAYOUTRETURN before receiving a
> > > non-retryable response to LAYOUTCOMMIT.
> > >  2, After receiving a CB_LAYOUTRECALL, the client should not continue
> > > using the old seqid.
> >
> > I think this question should go to NFSv4 IETF working group list.
> > Noetheless, rfc8881 says:
> >
> >    For CB_LAYOUTRECALL arguments, the client MUST send a response to th=
e recall before using the seqid.
> >
> > So, it sounds, as long as the client hasn't responded to CB_LAYOUTRECAL=
L, the 'valid' seqid is 1. Thus,
> > LAYOUTCOMMIT seqid=3D1, LAYOUTRETURN seqid=3D2 looks correct.
> >
> > See: https://datatracker.ietf.org/doc/html/rfc8881#layout_stateid
> >
> > Best regards,
> >    Tigran.
> >
> > >
> > > Would you consider this a bug in the client? Or is there something I
> > > may have misunderstood in the protocol behavior?
> > >
> > > Thanks,
> > > Haihua Yang

