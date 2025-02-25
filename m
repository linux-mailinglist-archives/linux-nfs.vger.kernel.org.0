Return-Path: <linux-nfs+bounces-10339-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7629BA44649
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 17:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3D14269E3
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 16:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB2014A60A;
	Tue, 25 Feb 2025 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuTJgcqj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE16A4430
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501325; cv=none; b=aBYvdNE7bIyqt/bq24pWZ4zAG+/0UOXD1cTISR2rx6Xa74Zj/xijdYY/+9vtvHNDpX8VcdS/fmOeiH0OL31YWgWsPXiQbalI2lMEVyg2QkwRSbXPboH83EsTx+oXfctH6K0D3RBQsKWB/TqGu4h7XX58TPjZ7+rCkPPGGAaPR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501325; c=relaxed/simple;
	bh=wVKC544N0bnvWqc8y8kKYI9u86S4vdZmt4I+WM0WbWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=t6hjpRCm6t7w+kEmBqI2RIbyI4EHqxHiafQM9OBeFGhsRicwXLlvmh1nw11UdrYiL/0Du7MoETVR5tVjnlQBqjyor6aLUecdy2Wqi+zWIFI2/teg8aKLqNXmZUD7vW/sB2AvkBz4rswwcPbhMz2omSY9xkhRmpV3RLsoLl+2JUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuTJgcqj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb79af88afso1071301866b.1
        for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 08:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740501322; x=1741106122; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVKC544N0bnvWqc8y8kKYI9u86S4vdZmt4I+WM0WbWk=;
        b=CuTJgcqjTd/6NvpihMAvvq7CeLTfZbbFAcfCbNGo2AtAdsnd+xOHjSH9ddHIvYuQxx
         H8nNEq57IM2tssV7H02qbMBS3h17/uyydR71f21XJMGkofzWHStmzSMfsJnH4RZVEIYY
         mBVBQf12vbhjEkXE11jgZElmzSR0PxT6Vx2c6G1eoehZmFFTtsCi0JBFw0WpTRRmGW28
         A4SJiAQfBejwkbPZPFiFgKd5hbpE82mweXTsATJRz5NOL68cMcyAKKr0mjCfiqW5Fv3d
         mnvPTr5ZWrzgqlJQtjGRlvgds7afLYI7xGafN1K3vjUhkWmgfTG9E3y4UI1hWAXd6/7M
         HA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501322; x=1741106122;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVKC544N0bnvWqc8y8kKYI9u86S4vdZmt4I+WM0WbWk=;
        b=lTMbfcPIl4jdc8X4wvzNytBrvzbWWwMQaWwfzWJM96ricXOGKtyA+o3gnEitgrZf8V
         qMyPgYlmKX2NrCqi+X+Kw8AZml0uwP7p/fkKlYvu/XWWhrU7jhA+Az+Gf+SdbFx98mcu
         c2+lX89hbCmLFYU5ocKll9yHOfbTKJK9DumK1tFzgx8jpdNWGdkgWaWGcDiWk/vYqS52
         ytJ9wBSr9/ff5m/yWproFV5InJgEOMSFz32UphIIWKJG2oQ8O+8tyRjsOIFUVnERDdey
         8ln6i/TWIvVzJlyjPgSOjzgruJM6z+Klu5/Ux9U82VxHlpxmCdxOBCj+8anYPWYmKCkC
         PyhA==
X-Gm-Message-State: AOJu0YxTZvRGoAoUHCJ1vqmr7sKntz/PEclhB2PIxR3rB3wEU/SrD24L
	163QVnUeMt63A351nceHvnCPejBEu4i1EL+eaIWj1Ulru0rom7VIovQn/hKH1NzAmYCq2GZCTB+
	rrGi/r+PoisMoxQoXNL8KaM+kxfWP4hheeSw=
X-Gm-Gg: ASbGncvaOcTPyrEplGZ3L0/yb0n274lZTvN4RD8Vbpt/gV79za9j2ObUVDOfo2WKbyH
	T90oLWgoMeczf/1/UEED0hXaanCYYMq3JOHaRM4LhGIMsCGWRE9J+CM806gX+4yxvMFUgfvXwtV
	+GOK/3MOEZ
X-Google-Smtp-Source: AGHT+IFRhbpccfdxSCE3k6UwcByY3c68AyjjhM5M9FLEIqknQ/77GBrCqq0t1Iqrvy5oUGrtjjzoEblUrLGhAcLCQaA=
X-Received: by 2002:a17:907:96a0:b0:ab7:f0fb:3110 with SMTP id
 a640c23a62f3a-abc099b380emr1945188166b.5.1740501321483; Tue, 25 Feb 2025
 08:35:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=Gscd+3dHU81hhU0maH_v1R2ws5ND3bYR1WkdEESs4Cjw@mail.gmail.com>
 <8fe1273c-ca34-48cb-ab24-848f81648f9a@oracle.com>
In-Reply-To: <8fe1273c-ca34-48cb-ab24-848f81648f9a@oracle.com>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Tue, 25 Feb 2025 17:34:44 +0100
X-Gm-Features: AQ5f1JrpynDhN5XZgbfU3ZYKtOVoZhje0mmiqJmybCy5acJWWNU4ov1JPoePh9I
Message-ID: <CALWcw=Gyq7m4X0dUKScn+b3Q7_QXz82p_Dck_eCGaC3ESMi=nQ@mail.gmail.com>
Subject: Re: Run 4 separate NFSv4.0/.1/.2 servers on 4 separate TCP ports on
 one Linux machine?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:17=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 2/25/25 11:04 AM, Takeshi Nishimura wrote:
> > how can I run 4 separate NFSv4.0/4.1/4.2 servers on 4 separate TCP
> > ports, say 2049, 12049, 22049, 32049, on the same Linux kernel, and
> > have a separate exports file for each of them?
>
> This question has been asked in the past. We've explored implementing it
> with a single NFSD instance, but it looks difficult to impossible
> without massive code changes.
>
> The solution we recommend is to run separate NFSD instances in guests
> (containers or qemu). The host system might provide a NAT routing
> service that makes the guests appear on the same IP address but
> different ports.

Running in QEmu is not acceptable for performance, and it adds at
least a 1GB RAM usage for nothing. A container is also not a really
preferred option, because the OS files in the container must be
maintained and CVEs handled.

Why is it so hard to run more than one instance of a nfsd server?

>
> This has the benefit of providing administrative isolation between the
> NFS services. It would work well with NFSv4, but would be somewhat
> awkward for NFSv2/3 due to the required use of auxiliary protocols such
> as MNT and NLM (and of course rpcbind).

I am NOT interested in NFSv2/3, because we are no longer allowed to
use these obsoleted protocols in our local network. Only
NFSv4.0/4.1/4.2 are of interest

Is there a cookbook or howto which documents how to set up a MINIMUM
container for this?
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>

