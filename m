Return-Path: <linux-nfs+bounces-8946-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FA1A044D2
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 16:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF84416668A
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 15:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EDF1F1928;
	Tue,  7 Jan 2025 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVW0u8H7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624011F0E3C
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264242; cv=none; b=hBb77esKdbop/zdAtu8wunkcBAQvK5gANnUJo51keW22OW+NMXCQjJBKpMgyth/c4+MMMYKS14EwZVmLZWGEs+ix3Tz7zhgYXPbmIQmoAXWyRq4bTefXqu0BBt6mjyvj/hwjsMnVS0tMbJ+h5Bc16NZguolOzO+xlmYHHD8Uui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264242; c=relaxed/simple;
	bh=lDDtZaK/H3el8GfnXlLFzFGkLg592W6Uqf0TzYWhMz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bsh0mTIk5FrgKKF8SjhuMCc7/0xMBMvXuDTNkJLTIVt2xySBDoJkGGXM+Vv9qDlFZgYAbe7mICVbCSBoy5Yhcg8GJ7Fe2aDcjOsFXrz78gsP8sIrcRsZBerga1860oWADCzt6sHc0x3iHAXVEkmYFJ+NdFSKp8rdOuc8qecu/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVW0u8H7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf60d85238so1059860566b.0
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jan 2025 07:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736264237; x=1736869037; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDDtZaK/H3el8GfnXlLFzFGkLg592W6Uqf0TzYWhMz8=;
        b=jVW0u8H7aQ7gcd7jScjEMGfaxzTPzjK8ifdSSUoAOhHVdGzFVdlk1GsW29FaDSG+wV
         5n1OYJ2+I75ck7kTyxt2B8x6muO2ASKd8rq0nLa2hO8kTGONswA/TNfqn7yFxwZwLvpP
         vj6jyMccGljihrT7YMe+usu/ttX0IBYcGtkAiu9v5tPA3ZxDW+HXPKlXMq+MFBFf7Xi5
         dJ3ymJzRJlKADEp8Z0tiiLUASEujwX1lv/rOuDFZNCSncya9fTDBCqCXyIA/vBL7BAg2
         lf/EfImyKdtCdYbHJ+/1+PtF4XGcNHxLDBZ7Cw6PA+4ZoEQrNlWBiZZW9LFSCV0JSk7w
         McvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736264237; x=1736869037;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDDtZaK/H3el8GfnXlLFzFGkLg592W6Uqf0TzYWhMz8=;
        b=oR8QUvaTCIweuhAvdiboYabV89TDJnp+VZZPNrfSTUmAWrAvG1aCKszVrR2ApnfX3D
         nGHpDhAJlGmhk3rHw7IxoqT91h115hNw4gc69RKFGH+a34Da9RyXVQebs62/JFoM9xb5
         splbrqjP6Op6Yy9BNOjwag/fF9Xve0MqNKrKkW/8tYtegcKRIJTYsMQD/u7Ox40Alw5Z
         z6KApJErBxmU6BRvVs5IeeLWvFHMgDw2oIt3ftsE0yUuR8GAvMsahQaMuwGgAkaFfI7T
         tpwNQinLkFm6e4Fs4LvEySxsH6Fd8iGUq2c7fTNXHrcBrQTkiQvs8sYeCgg3PvfVm9m0
         b2wA==
X-Gm-Message-State: AOJu0YxsF6z0l4S7sJl/Bc0Kswc1+IgwMMud7ROOYM0yXE8sF26PvYcf
	njEvp5tyrEcXz/NeGrO23dDbT3MzJ88IzJJpPWuRLqJgEdep2QeKaBl+2X8dnLk8f6Bap1xwVi7
	fzpUKcbhxyT2v2RN/o6uqf3U138kfRG+4HDk=
X-Gm-Gg: ASbGncvBWU0DMSKkjE/On2ZVlgPFuy0aQEuVMWNlCe5J7bEm/Rxn5DNkbcoLMsIZvVi
	Qr0GDJ8OZz9wgpcQqn94i4HguJKV59UiafzbjdQ==
X-Google-Smtp-Source: AGHT+IFvSKbU/kNsIU19wZzMG7mxgTZFT1gKu1ebtRftaxyVn1LGa/mQEkaJibntHUeLrtds5pnK9pK9vgXnLB5bGBI=
X-Received: by 2002:a17:907:6eaa:b0:aac:83f:e10a with SMTP id
 a640c23a62f3a-aac334425cfmr5367160066b.19.1736264236965; Tue, 07 Jan 2025
 07:37:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=Gg33HWRLCrj9QLXMPME=pnuZx_tE4+Pw8gwutQM4M=vw@mail.gmail.com>
 <e3d4839b-0aa0-42f5-b3d1-4fd2d150da75@oracle.com>
In-Reply-To: <e3d4839b-0aa0-42f5-b3d1-4fd2d150da75@oracle.com>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Tue, 7 Jan 2025 16:36:41 +0100
Message-ID: <CALWcw=G-TV19UPmL=oy-HE9wc0q-VpHBVyuYcVQ8b9OQq-8Lqg@mail.gmail.com>
Subject: Re: Needed: ADB (WRITE_SAME) support in Linux nfsd
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 4:10=E2=80=AFPM Anna Schumaker <anna.schumaker@oracl=
e.com> wrote:
>
> Hi Takeshi,
>
> On 1/6/25 6:56 PM, Takeshi Nishimura wrote:
> > Dear list,
> >
> > how can we get ADB (WRITE_SAME) support in (Debian) Linux nfsd, and an
> > ioct() in Linux nfsd client to use it?
>
> Thanks for the request! Just so you're aware of the process, this email l=
ist is for upstream Linux kernel development. If we decide to go ahead with=
 adding WRITE_SAME support it'll be up to Debian later to enable it (that p=
art is out of our hands, and isn't up to us).

I assume WRITE_SAME will not have a separate build flag, right?

>
> >
> > We have a set of custom "big data" applications which could greatly
> > benefit from such an acceleration ABI, both for implementing "zero
> > data" (fill blocks with 0 bytes), and fill blocks with identical data
> > patterns, without sending the same pattern over and over again over
> > the network wire.
>
> Having said that, I'm not opposed to implementing WRITE_SAME. I wonder if=
 we could somehow use it to build support for fallocate's FALLOC_FL_ZERO_RA=
NGE flag at the same time.

No, I am asking really for WRITE_SAME support to write identical data
to multiple locations. Like https://linux.die.net/man/8/sg_write_same
Writing zero bytes is just a subset, and not what we need. WRITE_SAME
is intended as "big data" and database accelerator function.

>
> I'm also wondering if there would be any advantage to local filesystems i=
f this were to be implemented as a generic system call, rather than as an N=
FS-specific ioctl(), since some storage devices have a WRITE_SAME operation=
 that could be used for acceleration. But I haven't convinced myself either=
 way yet.

Getting a new, generic syscall in Linux takes 3-5 years on average. By
then our project will be finished, or renewed with new funding, but
all without getting a boost from WRITE_SAME support in NFS-
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>

