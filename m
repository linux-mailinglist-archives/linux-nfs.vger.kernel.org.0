Return-Path: <linux-nfs+bounces-5275-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 214ED94D334
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Aug 2024 17:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13171F23A7C
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Aug 2024 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA07198A05;
	Fri,  9 Aug 2024 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="g7fxYmux"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F93198A0F
	for <linux-nfs@vger.kernel.org>; Fri,  9 Aug 2024 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216542; cv=none; b=r/GUwWVj/pTR0kvOSfGMLPXIMOz1uwuV6gjz6Sbq9bUi7h6xYWOvObg97Lch5B6uSJBfepQuDcHdvht8Jh2SxCOPf7sBY+l6wP7y+5ywIo0Ud3IrkR7yeI5AoKHBo3kL5TgA7bonQfYUCwXKWPSu/jJ5UrpJ1mdbWVROu7gyjX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216542; c=relaxed/simple;
	bh=wxDCxilExPTcktWIrRmergV1SdwF43goNswbBVK3be8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqDlPAdNS70kRX1XsF7MvmeBJ/SvgQ7P/hWkZSdUsC1sQ+W08u0PU0tfwJXp9Y2ySAwcmzQqaK1RyFC7/bio91L9OEyblT3OFL4icFb8kUaosi3OMgkfoy5vvkXfCO07emP1JrUtc/mAWOuoeA81z0n3JQnUIYL59tsnzrBYBdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=g7fxYmux; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef2c0f35f2so2452131fa.1
        for <linux-nfs@vger.kernel.org>; Fri, 09 Aug 2024 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1723216539; x=1723821339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTQY4IctFJcAwO1VU1TM90Xg7jp5wLISAdudT1URC+c=;
        b=g7fxYmuxCBpU/5dvqWrzoHIMSCCcTXc9m7Wg74fhnz2kGIgZS/gr+KaWVyq7ZG78CA
         Bb07igZflU0xvd5pYfMz1FIqZGCvrHWVzMgTTdY/CEERaXWGpNzdv6xVL3g26X6HGGin
         5zm7zkfLsTXWs0DLY8zCDHPLCdxSJ/aCq6R1SX1o942mFMZaQx4K068JyjNkHd4EG9AT
         iY7yTQ+YfokS91iWgjz/72VIAbkiWW8ipDH9BbLxq6ZdyglkA34oNj5Op/y10VR/WRoJ
         3R2rBwRrTnTzQNNehs3mu5B295AqHd7lfdYJXWwNLBm7twcQ/br5K4Kj9f/Xh8Pt5Hin
         MpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723216539; x=1723821339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTQY4IctFJcAwO1VU1TM90Xg7jp5wLISAdudT1URC+c=;
        b=Z6L/8lb/yBc0Mi/mm/z3We2QRJaqPAZ638dojF1Zz+4FUXLOkJYqqYztth7b+9Eny2
         7sJztP4pjEh96Qxsmu7u2dFBh6ap7dBwlphR2UsVYPMudPCn2iyO9vYNJqMkpcMBJlbv
         2/rBsBbvbGlBvaJYmG8BprOhSf+nwmevRInmOM0m8K6ZLxIod39703YugLw11XJT0w64
         asSefyVNIVA6HCIu92DXeMUqDdg3jiMzLxQ2w/Aosu1Uky3s92cQyoOq6pjvfYQ2lzWe
         lWI35aS7n1Ohevy/Yr2YF6fMo6twcxDmDEUNH9A/VPFs3Y3JWk/GSBHEiQYyC94HingW
         EURg==
X-Forwarded-Encrypted: i=1; AJvYcCUwDtVNnK9zI5doJ2bp+j7jp1vCG5R/f1Clpjtvaswsqe/BLgXsmM0jezJMFvpl57j/6HSMl818lTd3EA/3yxpCibwVJKCEUzCA
X-Gm-Message-State: AOJu0YzZN22vMP+n0lbNJ0CvrNQpYHs2iVlmHT+wTHF+7gLqSgn+sQ47
	tTV0+lmW+fzVca41N4r6Q2NNrZAwKBlhZPrQj+YUog5Px+mK3/73Htabew8f7QfI4lx1ysy2I8g
	lWjiSQa/1/dBGV/a2tedIuoFDI/qz0Q==
X-Google-Smtp-Source: AGHT+IGSx2o5IUv7fvFTHa85tXQN4HgNb9thhAEMuN7HcyYCra2fK133vROGks++Qv2HIO8uNeREJNAGcoavoBY3pds=
X-Received: by 2002:a05:651c:210f:b0:2ef:27fa:1fbe with SMTP id
 38308e7fff4ca-2f1a6cfc9d1mr8787821fa.2.1723216538481; Fri, 09 Aug 2024
 08:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c4f1d8bf-745b-4a98-9d38-2da4c355d691@gmail.com>
 <66be75a6-2d3f-4f5b-96da-327556170c4a@gmail.com> <e39131ce-1816-49e1-8319-820472892a38@gmail.com>
 <CAN-5tyEx=j2OiRZVd+18x-2Y36SGGsJxAVApudT+mWjiNGDyxA@mail.gmail.com>
 <CAFX2Jf=k0SC4iFzj+24HbR-4MPkk0bkGCvnnOiv0OYgqO4QOBw@mail.gmail.com> <8ab0fd49-0c90-42bd-a34e-9dcf63a99bd5@gmail.com>
In-Reply-To: <8ab0fd49-0c90-42bd-a34e-9dcf63a99bd5@gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 9 Aug 2024 11:15:26 -0400
Message-ID: <CAN-5tyHMAWmnwgfR7ih_7ygUUfOdGfE7ntf2nxRTFY+USy2HYQ@mail.gmail.com>
Subject: Re: NFS client to pNFS DS
To: marc eshel <eshel.marc@gmail.com>
Cc: Anna Schumaker <schumaker.anna@gmail.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 10:09=E2=80=AFAM marc eshel <eshel.marc@gmail.com> w=
rote:
>
> Thanks for the replies, I am a little rusty with debugging NFS but this w=
hat I see when the NFS client tried to create a session with the DS.
>
> Ganesha was configured for sec=3Dsys and the client mount had the option =
sec=3Dsys, I assume flavor 390004 means it was trying to use krb5i.

For 4.1, the client will always try to do state operations with krb5i
even when sec=3Dsys when the client detects that it's configured to do
Kerberos (ie., gssd is running). This context creation is triggered
regardless of whether the rpc client is used for MDS or DS.

My question to you: is the MDS configured with Kerberos but the DS
isn't? And also, does this lead to a failure?

> Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC:       Couldn't create
> auth handle (flavor 390004)
>
> Marc.
>
> On 8/9/24 6:06 AM, Anna Schumaker wrote:
>
> On Thu, Aug 8, 2024 at 6:07=E2=80=AFPM Olga Kornievskaia <aglo@umich.edu>=
 wrote:
>
> On Mon, Aug 5, 2024 at 5:51=E2=80=AFPM marc eshel <eshel.marc@gmail.com> =
wrote:
>
> Hi Trond,
>
> Will the Linux NFS client try to us krb5i regardless of the MDS
> configuration?
>
> Is there any option to avoid it?
>
> I was under the impression the linux client has no way of choosing a
> different auth_gss security flavor for the DS than the MDS. Meaning
>
> That's a good point, I completely missed that this is specifically for th=
e DS.
>
> that if mount command has say sec=3Dkrb5i then both MDS and DS
> connections have to do krb5i and if say the DS isn't configured for
> Kerberos, then IO would fallback to MDS. I no longer have a pnfs
>
> That's what I would expect, too.
>
> server to verify whether or not what I say is true but that is what my
> memory tells me is the case.
>
>
> Thanks, Marc.
>
> ul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
> stripe count  1
> Jul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
> ds_num 1
> Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC:       Couldn't create
> auth handle (flavor 390004)
>
>

