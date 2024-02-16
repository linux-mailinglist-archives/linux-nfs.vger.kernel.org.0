Return-Path: <linux-nfs+bounces-1998-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5FC858A2C
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 00:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A73281A9E
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 23:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA7439856;
	Fri, 16 Feb 2024 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5ijPr7e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06D145B03
	for <linux-nfs@vger.kernel.org>; Fri, 16 Feb 2024 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126330; cv=none; b=p+TS85j/nIl/JyLN3G6OMFc56AvWNkCHjt3Zd0bXii78a8zKr5NErEup2MQw1OVRfi7eYQzxD14zsewfnaYurLOFjS2xoXQioLQpjL0XnSbQIkL3wWD8Krks8amTsUdA8KVEdWAe7sN11ryciugepkFX7xXtgMRAYrX0bNB4hEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126330; c=relaxed/simple;
	bh=NY3RSrFdFhicF4SqNJEaMozGki6IXOsCI2HF75U7N7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cbZuPb6/45RWHop0ftgpl2dE/F84R3JRdeae/UoMFC77raeh4hFe+40aQk3o2LLG5+qkr/VCDLjwveiRFidNONCVbCw/1DbADVOknoVlb/VEVFke/CnxnfkayqPk4YaXzC21hS8Ov0gi7127vRNrY3QgrsL3nOiFD8Hf0UmjjKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5ijPr7e; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5128812662eso1796064e87.0
        for <linux-nfs@vger.kernel.org>; Fri, 16 Feb 2024 15:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708126326; x=1708731126; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuQGv5Kx8+c1tLkFDnCI5GJ3nxpgHG7os/BwP5Rsvf8=;
        b=N5ijPr7eagDdxfRKVEUn/X2rQegXih8HioQHV6Q05KmmCM4TmzZM2YikmOS0mFPKoL
         jMfHSE+gV6KzRSkVEwz/SKRm2YAvgPD2NE90VeCvkQCWUXIY046GNW71nc6JDUPtsB4g
         yF93i6oepZczJ/2oEBN8tVqCBgoqjply0p5gCDrIJPNrARgYK6EK6xcYvHgMa9XqR5lL
         K82/gm7LgP1lFP4MKXyt6FYxHojm8oNcrOf5s/OhlDYSOOrUdRO8/C3PgeityCWPfqI6
         /yZIdGWfC41DlncyTMzw0JY0o1kSya5BsU/95krsiDTYEuaDr1IgHz6okEs8mHbWFLDe
         2NHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708126326; x=1708731126;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuQGv5Kx8+c1tLkFDnCI5GJ3nxpgHG7os/BwP5Rsvf8=;
        b=a3LzNLXmZPHnDtYqUaVVjfmpsfBTQWjkNWZO2K2Ngyxnww2J3Bo3iVDXxKOf2Ri85N
         P9/C7jGP1dvag5fE/yW3889Gep///6MxNwrKeg3fEemyN172v9EBRV6GVS9ULgXchf2D
         2LiHI5IeF/RXaWuhtQtrl3ls8jlRy47Cg6HnB9hD4tlqI6aJh+si7NO43oDp+3RO1+F2
         FBGQeKvNegTKLMEwZeJP6MbpTo63CI7v9xH0Fcx0JoE3HsEVf8FUVoInbZcrQLdF+FTf
         5uybMCiw10BFvmD2I0aiVFHQ1rxdb1Ft37KQRDVr1W8l0Jsc/LoPcb9CjuD9pNYbZRHU
         jz7w==
X-Gm-Message-State: AOJu0YwAGEfCBEj1MSjT4FryDVEwi32RibkpgkZmpNN1aCWDTo/vSMRk
	U2/oCmghDdybdTSrg6QErzUST50lewO7USWKZcBz3fmOy0KEX9EK81I452NPcbjQaUsat654w7I
	MHI96669PHeNo2jKM5mlyHJWVlzbFUjbCqGc=
X-Google-Smtp-Source: AGHT+IGHOTH+k26JuKPdqdH7KNKEnN5VvJkaL7dRvwoHJXoBF8q5glkBxC4LoXS2nGgJeltEhMav00gXOW3eUivu10w=
X-Received: by 2002:ac2:4a68:0:b0:512:a37a:bde2 with SMTP id
 q8-20020ac24a68000000b00512a37abde2mr322236lfp.67.1708126326025; Fri, 16 Feb
 2024 15:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH0PR14MB5493F59229B802B871407F9CAA442@PH0PR14MB5493.namprd14.prod.outlook.com>
 <1AF9A62E-55BE-4A08-95D6-26784218C940@oracle.com> <PH0PR14MB5493D4DF2877FDD93BB49AF4AA442@PH0PR14MB5493.namprd14.prod.outlook.com>
 <A14BC53D-18C7-43CB-B64E-3B215EB12D04@oracle.com>
In-Reply-To: <A14BC53D-18C7-43CB-B64E-3B215EB12D04@oracle.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Sat, 17 Feb 2024 00:31:34 +0100
Message-ID: <CAAvCNcCo1phpMqLsVz_GtrKrVb4Pgv_UfTXtokvqpSLFjVJKoA@mail.gmail.com>
Subject: Re: apparent scaling problem with delegations
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Feb 2024 at 23:06, Chuck Lever III <chuck.lever@oracle.com> wrote=
:
>
>
>
> > On Feb 8, 2024, at 4:45=E2=80=AFPM, Charles Hedrick <hedrick@rutgers.ed=
u> wrote:
> >
> >> From: Chuck Lever III <chuck.lever@oracle.com>
> >>> On Feb 8, 2024, at 3:26=E2=80=AFPM, Charles Hedrick <hedrick@rutgers.=
edu> wrote:
> >>>
> >>> We just turned delegations on for two big NFS servers. One characteri=
stic
> >>> of our site is that we have lots of small files and lots of files ope=
n.
> >>>
> >>> On one server, CPU in system state went to 30%, and NFS performance g=
round
> >>> to a halt. When I disabled delegations it came back. The other server=
 was
> >>> showing high CPU on nfsd, but not enough to disable the server, so I =
looked
> >>> around. The server where delegations are still on is spending most of=
 its time
> >>> in nfsd_file_lru_cb. That's not the case with the server where we've =
disabled
> >>> delegations. Here's a typical perf top
> >>>
> >>> Overhead  Shared Object                                 Symbol
> >>>    44.87%  [kernel]                                      [k] __list_l=
ru_walk_one
> >>>    13.18%  [kernel]                                      [k] native_q=
ueued_spin_lock_slowpath.part.0
> >>>     7.24%  [kernel]                                      [k] nfsd_fil=
e_lru_cb
> >>>     2.61%  [kernel]                                      [k] sha1_tra=
nsform
> >>>     0.99%  [kernel]                                      [k] __crypto=
_alg_lookup
> >>>     0.95%  [kernel]                                      [k] _raw_spi=
n_lock
> >>>     0.89%  [kernel]                                      [k] memcpy_e=
rms
> >>>     0.77%  [kernel]                                      [k] mutex_lo=
ck
> >>>     0.65%  [kernel]                                      [k] svc_tcp_=
recvfrom
> >>>
> >>> I looked at the code. I'm not clear whether there's a problem with GC=
'ing the
> >>> entries, or it's just being called too often (maybe a table is too sm=
all?)
> >>>
> >>> When I disabled delegations, it immediately stopped spending all that=
 time
> >>> in nfsd_file_lru_cb. The number of delegations starting going down sl=
owly.
> >>> I suspect our system needs a lot more delegations than the maximum ta=
ble
> >>> size, and it's thrashing. The sizes were about 40,000 and
> >>> 60,000 on the two machines.  Systems are 384 G and 768 G, respectivel=
y.
> >>> The maximum number of delegations is smaller than I would have expect=
ed
> >>> based on comments in the code.
> >
> >> When reporting such problems, please include the kernel version
> >> on your NFS servers. Some late 5.x kernels have known problems
> >> with the NFSD file cache.
> >
> > My apologies.Ubuntu 5.15.0-91-generic , which is 5.15.131.
>
> That kernel is likely to have file cache issues with symptoms
> very much as you described above. The issues are thought to
> be addressed by kernel release v6.2.

Is there a way to turn the file cache off for nfsd?

Dan
--=20
Dan Shelton - Cluster Specialist Win/Lin/Bsd

