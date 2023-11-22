Return-Path: <linux-nfs+bounces-28-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 706157F3DED
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 07:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62522827C3
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 06:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A76BA24;
	Wed, 22 Nov 2023 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="dl1hxa1y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A1CB9
	for <linux-nfs@vger.kernel.org>; Tue, 21 Nov 2023 22:07:50 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c6eac9c053so18590081fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 21 Nov 2023 22:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1700633268; x=1701238068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuJ+FGqFAIqsPH6/f+SFWhtOihZa8pB1zGedGnXzVdE=;
        b=dl1hxa1yGsf1Ywa0F9egrWEiNocGB+fHtmquRgC0D2iQJDOGhPVSicV0SZrc+fFH5d
         0H/5g91ENKuASFSklRXyEXgm+veKxuUP3x7FAcIoM2kogH/qhErIJMGLCcrXZVCilAup
         H81y8RV8jdm9AuBciDHmgYCS4nAtkoFQ7eKbiZFscyGu0dXL6rtCGc1y0BfJhHifvu59
         sf+QX/PvAzO4Tdp32TCfN3G0z6IrF7EeRUIJEcdfgMTaZKW9KLZKTrj8cotU2plKDmIC
         L7JHmtOOSaS/UyiY7rl2lbc/GUv6Yy1E/q0F0c0ssJEPVcq3/ylX2ggJCEHMJSBLrmnu
         vY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700633268; x=1701238068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuJ+FGqFAIqsPH6/f+SFWhtOihZa8pB1zGedGnXzVdE=;
        b=TlrzCv//AVfaueY9XLYv2I4U1UBYFjvX3Ihbbxb89oyQWdBVbI95b3M3UyADKuZNw0
         0FCZTJ9KttU9HUBWhv//9hf7PrQx30eu3F4tvaB36K68YUcljqOT3BmsXuBqbNjGNP77
         sX4CDt4wGn+Q9ZiVbr9gtAXRQ8k0/a47jKWmPjoXUlyOLHT73dbuqea3AV7tYv4cn6EG
         5cxvyx976OMjh7SLWW0BWGKPhQw9AM1B6IPwZI2TeZQ/lC92Q0ttMAHS65pTRg7B1JiA
         qc4YGkiM9msTYzVRSkpUXmcd4U323cXUh3deixAdLNTxLDIgeViEZSmFgfvzNL+FMtDN
         IUwA==
X-Gm-Message-State: AOJu0Yxy9dbSkXLZNFdt5Kq4wG8ZAr23J6Ma3HO5F0JAaF9/DbqsJJ8i
	c+3/E9iv5tyWqJEEW/2cZhmsGlT6mheG56Ou+9E=
X-Google-Smtp-Source: AGHT+IHgSONCr17pTwTgzaDVuHVUs5t0gDR+QNqpoD2yq/xxUWpps6di6e1sPoWKoB2sKvbrMKnarGWsAkMM5hqE+5Y=
X-Received: by 2002:a2e:720d:0:b0:2c8:38b2:2c33 with SMTP id
 n13-20020a2e720d000000b002c838b22c33mr772499ljc.3.1700633268205; Tue, 21 Nov
 2023 22:07:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97AE695C-8F9F-4E9C-9460-427C284FBD32@oracle.com>
In-Reply-To: <97AE695C-8F9F-4E9C-9460-427C284FBD32@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 21 Nov 2023 20:07:36 -1000
Message-ID: <CAN-5tyHxvTevgM38q94W4e+rBzYu7tWqDHVMNcFQ5GT3uNArCw@mail.gmail.com>
Subject: Re: changes to struct rpc_gss_sec
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <kolga@netapp.com>, Steve Dickson <SteveD@redhat.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chuck,

A quick reply as I'm on vacation but I can take a look when I get
back. I'm just thinking there must be a reason why gssd is using the
authgss api and not calling the rpc_gss one.

On Tue, Nov 21, 2023 at 6:59=E2=80=AFAM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
> Hey Olga-
>
> I see that f5b6e6fdb1e6 ("gss-api: expose gss major/minor error in
> authgss_refresh()") added a couple of fields in structure rpc_gss_sec.
> Later, there are some nfs-utils changes that start using those fields.
>
> That breaks building the latest upstream nfs-utils on Fedora 38, whose
> current libtirpc doesn't have those new fields.
>
> IMO struct rpc_gss_sec is part of the libtirpc API/ABI, thus we really
> shouldn't change it.
>
> Instead, if gssd needs GSS status codes, can't it call
> rpc_gss_seccreate(3), which explicitly takes a struct
> rpc_gss_options_ret_t * argument?
>
> ie, just replace the authgss_create_default() call with a call to
> rpc_gss_seccreate(3) ....
>
>
> --
> Chuck Lever
>
>
>

