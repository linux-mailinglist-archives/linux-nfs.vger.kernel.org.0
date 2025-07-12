Return-Path: <linux-nfs+bounces-13002-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0818BB02AE9
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Jul 2025 15:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A23417EBBB
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Jul 2025 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43369275B01;
	Sat, 12 Jul 2025 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRle6EtP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F6E201034
	for <linux-nfs@vger.kernel.org>; Sat, 12 Jul 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752325609; cv=none; b=HNWPnbDnFai4J/k4I6cRhhWPtwvYSqZ8TFNAy3Brgy6FuCGBdh4cS4qtNAyYbt7rsqyMAELufCKuoqZSUOV+d2xOvNYDjm5ATGsclvNU53gy5JjzSE2MvxzydSlcUsWXGWj4GGgOLgFaWXr5zhv7rzFN/LXgJJ0aFkr9EVdMRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752325609; c=relaxed/simple;
	bh=RorJifEy9RbunZOJTBO5pKbMEukvEb+fsgfyWfRx/IA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUKZe9ArYA0BAkLPg21b66B7hYVlx6d7tJcI6E2RexGgM2ctlmg8Idu/TKI64wS7XQuJ/rHiKjRBbyW/PWN86rGk3+hCcwmAJopS5r0GrYzGLDGYz+bMQ4z/YCBJhNCN4bxmA+NXHwc+5Oc4sPVTvDX4ZjUxbsnCcmUjS1ECbvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRle6EtP; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2ef60dbaefbso1860197fac.1
        for <linux-nfs@vger.kernel.org>; Sat, 12 Jul 2025 06:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752325607; x=1752930407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQMCIiCDI4VLxxHf3lVW7SfVSDXEFfpx7oC4UW+fRuM=;
        b=WRle6EtPqy0v/MdR8NmZ1cL5xy3GcHkODk5mC3VhzlfPbmaMPsumnqmyzz1K4gDiS2
         tasr2MR/o991fxPuD7LITgpZam9FPFVz1j0XfM0EMvQoCTBt5+QJLE03lOZduMKvvSzX
         aDi63V2+iZ+Y9q4BNcUYCekeuEkXmGrsuur6bN+Up2uVg7ha85l+21ENJIs1hOm4mwqR
         AmgUh7gLmrDCB6btM08ueXzY+p7y6kUUdKx+uvSxAMZf3FiQ2A73yUR4WCr7Y2tiIx5C
         lLe3gi5BGmlm7aPPPokPjurhk5kxoAFLi4L17Va3Lz6BfkcgWx4WAKsjooPKrPxj/tVB
         boQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752325607; x=1752930407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQMCIiCDI4VLxxHf3lVW7SfVSDXEFfpx7oC4UW+fRuM=;
        b=RlUHgRgl0qMsQTLc6kzMV3kq0GFwz4BUPGDLz4rrvk+EhBBR1tevEqSzhHpP/jCJM1
         YBQAHYgPAVWkg4xsQJq4VWeQkuewfskSUnOkKp+OfzVgrV/CiU7T70uGDCs094SuXDm+
         9hVmso2YtHLv+h+HsrbUPssor1cECYF5b/kgIFys5U7irtlfIgPkPVIF/c6Vz5L0CChh
         wLpwE8MTfBQVRc7S+nS4Se/qN09B1PORN6rsKMFGpcVR55hvl86s2OOHiTGjC5UJMJu+
         3h1odTMNeaAaUuXKXd0OmoHPChIgnJbNNloJgJQmQHU6qtzeZQwFe65XV9YsvK5NxSXl
         Ws6g==
X-Forwarded-Encrypted: i=1; AJvYcCXKH+mu74xV8Il6Dh0lcj+fVcbJJxVIJpiuKALsq/D2Jx0dOw4wfXZfU75dNksLH9IqMfHKo460X9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9iPed8q1znCjnTtukC12cKuCOeevnVgs33d5e5BkNRzu12tiD
	+ZbRK5bYJitt2y9EoWg6k0Cam6h+d419n8sqWSGas4Ac+L0Qz6CCF1tdFcp6yAUy0LF8d4JWahg
	ROVHBu+QIDuCY3VqYP1KcmL8wL/WupxU=
X-Gm-Gg: ASbGnctlMcI07uiT5hFmGHMYJtjLVlrJeRkVHVYF3gBlW0HW4Lb9EjDXEcfzbtUQsFf
	7Uu90tQJ0xApboLTnJjAEEae/keYoVTRA3J2kj2p5eImFs5PZbzou5/RJv4ielhQAhTBqJCSQlW
	gjBCb4ItkDpI/R4tzyKW7gL3OxXeYTktLv0044+7XzdGI11agGinDVYdLfkBRXD6JXZ1gJ2DWgS
	GpuGMZw9FVHO2Cy2A==
X-Google-Smtp-Source: AGHT+IERFQuwoUZ2QF/COWFnfHxgD0eR6F51i9iAFCsqZxn6S050bRQx3+p81CDvzVOb1Aoom2O4czs+gZuUPUnxp5k=
X-Received: by 2002:a05:6870:9722:b0:2c1:51f7:e648 with SMTP id
 586e51a60fabf-2ff269c8b0amr5175325fac.35.1752325606772; Sat, 12 Jul 2025
 06:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618125803.1131150-1-cel@kernel.org> <CA+1jF5pJQePnFWWT7G5T3RXwcmwNyfo=phaXaUB0v7Br6yrgdw@mail.gmail.com>
In-Reply-To: <CA+1jF5pJQePnFWWT7G5T3RXwcmwNyfo=phaXaUB0v7Br6yrgdw@mail.gmail.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Sat, 12 Jul 2025 15:06:10 +0200
X-Gm-Features: Ac12FXxY58oQDoZhGTmxTZjD71YvAreZvMVOKS0kvohquGEWlQw4VV1clMuPmGA
Message-ID: <CA+1jF5pP3MJQ6L8TBzfuBNRr-YZxefBpBrQSxRR2kJWSqjgYxQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Revert "NFSD: Force all NFSv4.2 COPY requests to be synchronous"
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

?

On Wed, Jun 18, 2025 at 9:22=E2=80=AFPM Aur=C3=A9lien Couderc
<aurelien.couderc2002@gmail.com> wrote:
>
> On Wed, Jun 18, 2025 at 2:58=E2=80=AFPM Chuck Lever <cel@kernel.org> wrot=
e:
> >
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > In the past several kernel releases, we've made NFSv4.2 async copy
> > reliable:
> >  - The Linux NFS client and server now both implement and use the
> >    NFSv4.2 OFFLOAD_STATUS operation
> >  - The Linux NFS server keeps copy stateids around longer
> >  - The Linux NFS client and server now both implement referring call
> >    lists
> >
> > And resilient against DoS:
> >  - The Linux NFS server limits the number of concurrent async copy
> >    operations
>
> And how does an amin change that limit? There is zero documentation
> for admins, and zero training or reference material for COPY, CLONE,
> ALLOCATE, ...
>
> Aur=C3=A9lien
> --
> Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
> Big Data/Data mining expert, chess enthusiast



--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

