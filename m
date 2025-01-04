Return-Path: <linux-nfs+bounces-8911-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA2CA01640
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 19:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6DA3A2187
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 18:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737681CCEDB;
	Sat,  4 Jan 2025 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU5o0QCK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9228E433B3
	for <linux-nfs@vger.kernel.org>; Sat,  4 Jan 2025 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736014621; cv=none; b=U9NIua13cj7nIuV+Wn82K3Hf5MDV6ZEC53+ZKFCjkz2Fq9puNtQ0v7+9OhE2RhUcdPgzLXRqkun2flqvDdEfbCmy62CF+hP0455oP/evwP9i3xR256YvshTKS3I6W83D1Tr62GrS2R1KaL/uUroG8VgwdgreyMg5odhj5HzpDBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736014621; c=relaxed/simple;
	bh=kD6OlRUi436UaoDuXJvIvxc7e18O4c+fyyAite1uLdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=L1uwJfKcj8mULCAhMqRzFoqiByyc2ve1zt/6ecftBbJ3nH2n0jWHVBxDmFNvG3q4Y58fEImwSkQhsDjwuKDbimQ8FQRFbd/Le02gNQ7rh+NWs+w5SBoxl0yboYyqa/Lag7VgezQ59+a+O6liYSkCqGBPlhKjTBWus0q6cmk8CBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU5o0QCK; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so3398973a12.3
        for <linux-nfs@vger.kernel.org>; Sat, 04 Jan 2025 10:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736014618; x=1736619418; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqbdjpj3i1eek3Kc59KhI23RLoC49naq/N/HOBHQQF0=;
        b=RU5o0QCKV2otLavrrsQ/6qzLRw0+v0o+7lQTaFfmS2YHSDB8yZsS75JwyWjXeKCnFo
         w669trQ6O0k98Tg7OI/LP8phfEnAHw1uNSf4MpOWD8zJ0p99xs5AdgJhTh3YHhhMhS2s
         zdOPcwFNeesmiB413vbcu7w3z2u8dDZ/2IaLQFchx/0KTjMNKpNkw10Cy38S1+RMAUkt
         ul9YVaFvraI+8rWF0nW3X7z8cF2zkYS0dbKVVWm8YADI/eiRAs/RDGTNRTAZrdHZs7zS
         z1slQ9bPjh6fw5Oy//f8T1+91yspLI2kU9BstvcMWeL9vY0i7H5ZtbGk0bMxZ8RHDucL
         wqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736014618; x=1736619418;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqbdjpj3i1eek3Kc59KhI23RLoC49naq/N/HOBHQQF0=;
        b=HOfIhH92EHPQNEa4fZdVvMra1sH16jdwLRtIbsXv6cu+wNhWoaIwUMd+KsOTK5RgG6
         Qxm04GIeRyD/rU0+cR2lti8EmbaZDKsd6rifSJO42Mzyx76P38QJp+Tow0KQ/0pXr++S
         Y/9yBMDTErHfPw5C73o4NpH7Ge7/CgXtz8sQnU44krnbA6UwJTod6iyqFnlSjf8jWiAL
         hrlJilUtZQPmGd+Jjagwq6cdeJ9aSVo/imLCBITRtNvnQ9x8MfarszYq2qH33F17UM1t
         sglhOwkFnroDLHAG4hwjypUuRYvcY1je5u4ZlLOZ60CQsEfEW9XLQc+1t/KlpLjRkCy6
         KCwQ==
X-Gm-Message-State: AOJu0Yyp/0YGCCO+5E7arQH5QH929q8/HCgjkrCPn0pk10MA3y+7M6Tb
	W6xTF6Fp/NI2t3AB1Qeh/2xYIr1zlatCsLvWmBN7G+nRS/oY+IySb5PkgQw45Mh4TYNq3Zr13US
	kRLRISbJvrOUVhHnOP4RxKqHiExuY4w==
X-Gm-Gg: ASbGncs/xOnKXpqK+obo6MBprJxrFtfSIx8LEJlYh2hGdMlWfxKbKucf4lOf5wo21un
	tpaZuhWcDIn0aaCAYU93ivLXWVCUyqeit5vYiYg==
X-Google-Smtp-Source: AGHT+IHYxeL10yk0H74oCLy3k3kOO2qGmI3oeynp1SwRiDDtEQfyWrox7t12n7DZvMYn0+LiA1M0dZqhPSxVtyho0Kg=
X-Received: by 2002:a17:907:7f92:b0:aa6:a87e:f2e1 with SMTP id
 a640c23a62f3a-aac3378ef88mr4661527366b.56.1736014617536; Sat, 04 Jan 2025
 10:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=HDd06aQi5TXZjVgYDD7+fiheErCqDt2_6cd_c5iieCZw@mail.gmail.com>
 <5A440646-9BA0-4EE1-9AF3-D9C7DDAA1DA4@redhat.com> <CALWcw=Fh+YsQ94tG62qTU4Lv2367YajzvmgAjTfdJcbTr=hE2A@mail.gmail.com>
 <D1DFB17F-4EC6-4DE2-8E5B-93264BAC9B72@redhat.com>
In-Reply-To: <D1DFB17F-4EC6-4DE2-8E5B-93264BAC9B72@redhat.com>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Sat, 4 Jan 2025 19:15:00 +0100
Message-ID: <CALWcw=HxURVr7=kYM3XyrxQJ82wNfurWb4i_hJ77jpydd6D2oQ@mail.gmail.com>
Subject: Re: Linux NFSv4.1/4.2 client source code structure?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 4:40=E2=80=AFPM Benjamin Coddington <bcodding@redhat=
.com> wrote:
>
> On 3 Jan 2025, at 18:07, Takeshi Nishimura wrote:
>
> > On Thu, Jan 2, 2025 at 4:38=E2=80=AFPM Benjamin Coddington <bcodding@re=
dhat.com> wrote:
> >>
> >> On 26 Dec 2024, at 19:45, Takeshi Nishimura wrote:
> >>
> >>> Dear list,
> >>>
> >>> Is there a document which explains the structure of the Linux
> >>> NFSv4.1/4.2 client source code?
> >>
> >> No, I don't believe there is any such document.
> >>
> >>> And where can I find the code which negotiates between NFSv4.1 and
> >>> NFSv4.2 versions, and a potential NFSv4.3?
> >>
> >> For the client, that code is in the nfs-utils tree in the mount.nfs bi=
nary,
> >> source in utils/mount/stropts.c - look for "nfs_autonegotiate()".  If =
the
> >> mount command does not specify exactly the minor version, then a mount=
 is
> >> tried with decreasing minor versions.
> >
> > So mount.nfs adds vers=3D4.2, if that fails it retries with vers=3D4.1,=
 vers=3D4.0?
> >
> > Where in the kernel is the minor version from the parsed vers=3D4.2 opt=
ion used?
>
> Start looking around in fs/nfs/fs_context.c for "minorversion"..

Thanks

Another question about NFS 4.1 / 4.2 client implementation: Is the
NFSv4. minor version per session? Could a NFS client implemenation
send both NFSv4.1 and NFSv4.2 compound requests, if they are in
different NFS sessions?
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>

