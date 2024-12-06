Return-Path: <linux-nfs+bounces-8394-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2617B9E76D4
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 18:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7FE2824A3
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 17:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA5C1F3D30;
	Fri,  6 Dec 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCH3T65N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D71F4E36
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505232; cv=none; b=ABQpfHNYEKbrhzl/HEoZgr8HBTA8UZdCkrvL/Qb4lbAGMmmLPi5T17K7kMBgLeNQHOWaGeGNnPWaHPRpF7ddAIaNkhQ7JEAJZdQI9Be8w3S67MCCOAVpmt+u7CUasK3UkJBgpj/JehtuVXrtin+wDhlkzxlrDfCAkPUn332Lpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505232; c=relaxed/simple;
	bh=UoiqeuCsnQg7xQh8z1EYlWhHaiETXobjO8yB6gxeKqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=F7zyK/olOyqDKfgd7/tya6RK2AWZUr+OCv6h/uzZtH8Al8eQ3pIJUmohaeYbpPFC6+LH/GpmFthgsRaccqtbuhiPBmc1MhvVKjI2EUfkIEIQKFZn1Ks6DIXuBY4zYRIoC+lBzkU0IwBOlsULMnQfp+h11NprNdsjREu7xeSmefM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCH3T65N; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7258cf2975fso2097140b3a.0
        for <linux-nfs@vger.kernel.org>; Fri, 06 Dec 2024 09:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733505230; x=1734110030; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoiqeuCsnQg7xQh8z1EYlWhHaiETXobjO8yB6gxeKqg=;
        b=LCH3T65NpZ35jwrQ+CwlgpKyocPTtTjQLsiNN9t7qhhvZctnas9nb6cYURFkxgG+ie
         VHvKaYCPKmxdCxnlbrHkGx/WOeBqvIp5RRwIY10YaS0ALHJmVH1pEurjG4/xOrobAa2l
         /GO4AxAjJjPiXMuOW/O+sDWamoFtaagnRjZom6wPk/3m5GabbCgf5Pl1ihud8KB+ZMXQ
         sjUiDp8S8GcDH8q3J28TH7pGkPbOcg573YSkzVqOv4scNiQSSF/rhj5RNn6HgrlF/PRw
         B2MeEdujJTxz+0E8SwGR3aMlojU+M00QO7/hXlAYiff8yRLUQk3L+iox6inGYgTxz2pu
         xMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733505230; x=1734110030;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoiqeuCsnQg7xQh8z1EYlWhHaiETXobjO8yB6gxeKqg=;
        b=mHsn1cVc08PR9P2CPRqs5wiTbzEieAmGXm3eFigLVt3vx+YMDgyzKHGlyeNY/PDM53
         L/p/P0mU2anI1R6CS5l/fZlSgtqF5NLdUyXcQaz84iQetPjgdEU5Bg8Lf6MqRJxIQP/U
         uNZhUNgrmvce+GLLy5cWgROLbVZgK8XuEJZRA9SKwtkTexM+rnaJyI5EVbnouPxXOxj0
         F35YwQNS51I0q2DsxDxGnL7gEObjcONLaqjZTXUDU1HR4M4+spcM+A2S40e/HFoWDkUf
         qpDmwzxyHsyx4YotsbODZSovf2+Zupvg/aoD8iN8/UpDLihxQBY06qMOEfSthR+E42TU
         2lqA==
X-Gm-Message-State: AOJu0YxeYhwVE4CibBrf4uTS7bfAvxEJKZw+l8KRo71rWnJZEmV+WeaX
	O6tB4wX7NB8Sh9cIwfoLTsbfG/tUqZ44MZNYteM9bfx6wYKx/nvNBbU5GaRfrLQWcDFm/M1ndls
	Cyl2coI44MYbsl6HwoRjSe+Q3s7EtdA==
X-Gm-Gg: ASbGncuXtsdPredJ0Pc/vdOeT9R1SK5ChZUxIf4/CzkdIYbv1EAtMA7op3Znzi+OkVP
	U/w23yeRPHC1v4ejplLfiyKVT7pW+2r0=
X-Google-Smtp-Source: AGHT+IHnLrdgf6cjHnQll7a02midAXuxvxdFJvm/byd7EYokeAgDiFiD7aG9H0plFSjmeGqmvL3GmpEgquo3lXcdh3s=
X-Received: by 2002:a17:90a:d445:b0:2eb:140d:f6df with SMTP id
 98e67ed59e1d1-2ef693676demr6146711a91.1.1733505230113; Fri, 06 Dec 2024
 09:13:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com> <CAN0SSYyzWqp2CMziwQ9dGQ8X4+cL42P78oLZDZDrxbPTK_racQ@mail.gmail.com>
 <15b348d5-abfa-49cf-b605-3819feecc340@oracle.com>
In-Reply-To: <15b348d5-abfa-49cf-b605-3819feecc340@oracle.com>
From: Mark Liam Brown <brownmarkliam@gmail.com>
Date: Fri, 6 Dec 2024 18:13:14 +0100
Message-ID: <CAN0SSYwgankwnJXq_RDCr4rEG9k=iDZ=qaehwudwSd0_eOqA-g@mail.gmail.com>
Subject: Re: nfs-utils library dependency littering - fork nfs-utils for
 Debian? Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 5:58=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> On 12/6/24 11:15 AM, Mark Liam Brown wrote:
> > On Fri, Dec 6, 2024 at 4:54=E2=80=AFPM Chuck Lever <chuck.lever@oracle.=
com> wrote:
> >> IMO, using a URL parser library might be better for us in the
> >> long run (eg, more secure) than adding our own little
> >> implementation. FedFS used liburiparser.
> >
> > Yeah, another library dependency for Debian? First you try to invade
> > Debian with libxml2 via backdoor, and now you try to add liburlparser?
> > At that point I would suggest that Debian just forks nfs-utils and
> > yanks the whole libxml&liburlparser garbage out and replace it with a
> > simple line parser. Does the same job and doesn't litter Debian
>
> This is a political screed rather than a technical concern.

Nope. Stuffing the libxml2 garbage as dependiy to nfs-utils broke
dracut in Debian and thus nfsroot support, and that is a REAL WORLD
technical concern.

> For one
> thing, a fork certainly isn't needed to remove libxml2 or any other
> library dependency -- all distributors carry local patches to such
> packages.

It is a concern that nfs-utils keep adding library dependencies for
which there is no technical need. Junction support in nfs-utils
could've used a simple tag=3Dvalue format, instead a slow,
resource-hungry and upgrade-antagonistic libxml2 was chosen. Real
world users could not boot after that.

So a fork of nfs-utils would jank out libxml2 and use a plain
tag=3Dvalue format for NFS junctions.

So nay nay nay to more libraries, or keep it the liburiparser dep off
by default. People who really want it can do an
--enable-nfsurlsupportwithliburiparsergarbage.
No one really needs exports and filenames with non-American characters
anyway, the workaround is just mkdir /myjapanesefiles/, export that
dir, and keep Japanese file names within that subtree. That would
benefit people more because liburiparser.so.1630919828 would not be
pulled in.

Mark
--=20
IT Infrastructure Consultant
Windows, Linux

