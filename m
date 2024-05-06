Return-Path: <linux-nfs+bounces-3185-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218AB8BD795
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 00:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE48CB23F00
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024D04CB58;
	Mon,  6 May 2024 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFbI8poQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C234438F
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715034632; cv=none; b=bYE/226bWUi3+Tv0O4fhTzz/sK2Itycc+2d/nkRWALSPSg65YXBrplbbVqdNkYfFygghkMx7L3qQShi8J8DXWvpu2ofMEcaOWLIVyyy0byrNDcEs6KAxH6UAqvYaKigPUEiFl4gRi2P0O2Zfi0/BFNQHGnERhnjIQIRCZ5L29RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715034632; c=relaxed/simple;
	bh=bRWOsZwo04z6zRLIKWHN6QzI5yyn79spskI7WUDs56o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvwxuBjGH6HJu2WE0NIKO+2MzhNHsfPGOCMQ1LLJC5tJC4HTO9H4kcK6giY+xcqs12JCvsBKttPMkHgvi9JSuo6seaBmMt8hwFWD1fsj81Kg7u8eJvQeC4EvCfrAZTgvgTYywDPcWnJlO8HP1UuzTLDkOChw6vA0SIed/PN8rVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFbI8poQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so1995280a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 06 May 2024 15:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715034630; x=1715639430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SL8mhv2osU3THN541lB0ZFFcRSmEBSefnLk6zp3NcHY=;
        b=SFbI8poQXxND7tD19Ho2gZATOi1Q5xOokDRqmVZZRmQe4GtcZxH5lvNYDOlkykt07j
         nGu/NZiRhWIRZSrSQRo9sZuPlkkDNxW9X5wA4XzjRwlWtSJkTBLiP3ak6ad12TVAnp/M
         upddMuE72aQl12Ean/CVQohEU/+FQxRsUBS+S5VUNK1w8Kt46kRgb+LRVzNRtlIV5lwn
         ni+rg4KWHfL7iqMciC5I1F0xcuGehhbJMR/YWmvuDnbpmX+FcgEJrUNz6jrTlJcPkha3
         1NGu5tPOiPScht/6KiWQyEaTKMgtpaolaYifv+lMUfsfQvS64aNR3ELzx+znVV2oeA2H
         4raA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715034630; x=1715639430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SL8mhv2osU3THN541lB0ZFFcRSmEBSefnLk6zp3NcHY=;
        b=RAHtYtlYQbqQKhzvrdtRRxF07VC+NxnWG02gFc25py/AuxwzMwQgx/Q+c4QYadkXU5
         IWWKCK/ZYDfFTXTRgSTgh0+wWO4qXp7z0B1HsGvA+hbgGM/2+zMAvspmqVRv6M/HGrDh
         C0JIYEfcw7cM41N//LsCeLReabmuXL7MZ91UWGv4Cbu45yKl4sW1bDbEtcZAWSRMN17S
         w2r9cRJApIzH0KU+ybCuM2a5WS1RPBwaY44nt+3VXcDug2ai8Pp2dMO39Cr1KuoXDhBj
         /rLT4ZobCECFS3SzHLi7wohiqeH+hYjklvE7OYQGfhkwnArxJ8R1LUrrxZwhcnRL2Ge5
         oKaA==
X-Gm-Message-State: AOJu0Yzg0AkTtuTgAyiGQPuMBbJn36iqFPqcuiDFdanYGFpISQ5wrAA7
	CE2t+QSThl0Xe60W327Iote6nqaProUGDlQEvZmMz7tfdNs6OwwsNoVZIMU19yHTYuJxPWDXqf7
	k4Ce+ul8605OODg1oIG9kFUaVI403
X-Google-Smtp-Source: AGHT+IE/P8VehiW/ZHV3nRNG1LplvI8SsMFtMeZRBVSYDE6QwNPVo3/8TMjsvSO6Qge/8rA9SCfLYmZAIGok9eMNC+I=
X-Received: by 2002:a17:90a:8b81:b0:2ad:f278:77b4 with SMTP id
 z1-20020a17090a8b8100b002adf27877b4mr11282090pjn.23.1715034629750; Mon, 06
 May 2024 15:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506210408.4760-1-cel@kernel.org>
In-Reply-To: <20240506210408.4760-1-cel@kernel.org>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 6 May 2024 15:30:18 -0700
Message-ID: <CAM5tNy4nceCa7k+E1sKEAi5GYJvMwYDuApspFJvSdVdXBuHjmw@mail.gmail.com>
Subject: Re: [RFC PATCH] NFSD: Force all NFSv4.2 COPY requests to be synchronous
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 2:04=E2=80=AFPM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> We've discovered that delivering a CB_OFFLOAD operation can be
> unreliable in some pretty unremarkable situations, and the Linux
> NFS client does not yet support sending an OFFLOAD_STATUS
> operation to probe whether an asynchronous COPY operation has
> finished. On Linux NFS clients, COPY can hang until manually
> interrupted.
>
> I've tried a couple of remedies, but so far the side-effects are
> worse than the disease. For now, force COPY operations to be
> synchronous so that the use of CB_OFFLOAD is avoided entirely.
Just a yellow warning light from my experience with the FreeBSD server
(which always does synchronous Copy's).
A large synchronous Copy can take a long time, resulting in a slow RPC
response time. A user reported 25sec.
The 25sec case turned out to be a ZFS specific issue that could be avoided
via a ZFS tunable.

I do not have a good generic solution, but I do have a tunable that can
be used to clip the Copy len, which is a rather blunt and ugly workaround.
(The generic copy routine internal to FreeBSD can accept a flag that indica=
tes
"return after 1sec with a partial copy done", but that is not implemented f=
or
file systems like ZFS.)

Although there is no hard limit in the RFCs for RPC response times,
I've typically
assumed a max of 1-2sec is desirable.

rick

>
> I have some patches that add an OFFLOAD_STATUS implementation to the
> Linux NFS client, but that is not likely to fix older clients.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index ea3cc3e870a7..12722c709cc6 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1807,6 +1807,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>         __be32 status;
>         struct nfsd4_copy *async_copy =3D NULL;
>
> +       /*
> +        * Currently, async COPY is not reliable. Force all COPY
> +        * requests to be synchronous to avoid client application
> +        * hangs waiting for completion.
> +        */
> +       nfsd4_copy_set_sync(copy, true);
> +
>         copy->cp_clp =3D cstate->clp;
>         if (nfsd4_ssc_is_inter(copy)) {
>                 trace_nfsd_copy_inter(copy);
>
> base-commit: 939cb14d51a150e3c12ef7a8ce0ba04ce6131bd2
> --
> 2.44.0
>
>

