Return-Path: <linux-nfs+bounces-10908-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92F5A71892
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 15:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FFD17375D
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C011F3BB3;
	Wed, 26 Mar 2025 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q34tgw1W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D987D1F3BA8
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999641; cv=none; b=EucGsRxSWozKloKJCtUMB15JHJJrg6an8q0QhrW6iktS52OGNNIA/q83Ig949o7ddkINFQW6LOuOhdhZmdPM6eeR8fV9Df4nhLhxKLBNomIZSP1B5SW+gA0ZKjlknSC8yd3zA6yJCz1qUw1GOaRz5VbCJIKs8cC+9zP5u5LTncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999641; c=relaxed/simple;
	bh=teUH/rYW7rxE4XutLiHoQQt4OVEH7CkHPjTyWsxWMr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Qh3wXp1Dq8hcHQSWVOFWKw7ASb0LsukxLI/R/upX3d7OeB6DMpaYDgPrNgUA1VAjoRU6nx+9bRZRott5ZBjXPexGe7S2dAeWeQw7qcNiKudbaHtP2ESqNjXFUSGyh+v6XVEL3dfTZlZJXDjKKlksq4icEwQsjvIEaBYC4gIkhlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q34tgw1W; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2aeada833so193017866b.0
        for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 07:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742999638; x=1743604438; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teUH/rYW7rxE4XutLiHoQQt4OVEH7CkHPjTyWsxWMr8=;
        b=Q34tgw1W7nxbxH6eHDCF2NPHB9ctTzNMbl+CC2Nk6fA2Yalw19dxO3ld+4BPfWPoTg
         q6TGzPa7IO/H0Sv38WB+uzMzL0IrEllrWaUpWaiSEE2RqsOTkXqpEQpavMEywJ3o9Cv5
         9t8fP5nvsWUz9ujERH3QtQkMbQJ9IoFySoFtB1GRcG5RwtahlNSrzKxki4fwy6GlkUj0
         S26VrSioJny/q6IJzkGRRHOgj7hDTgVH4t1MChsisCL9md/rG8DQXMXZY5IJjyA/TAtz
         phX2Hd4vhlWJmnBmUBDVf12lJD0ypJW0/VQxqG0XVmbGlg9e19a9O2/NTQo1KQPG5kxl
         v3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742999638; x=1743604438;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teUH/rYW7rxE4XutLiHoQQt4OVEH7CkHPjTyWsxWMr8=;
        b=FwTEPGwE44gJaBPA0ctCBu6UoOv81QjVv5fUnfjIYL7qe78ghOkHylTNvldm1iS7y8
         5O9zWgdwiDXLwzCaOMESs2ODykfYxXsfNbKLT0Rujiu53shzQynXUfbZ1f0kJsnTW/5f
         2DpjBKXddPhh24PUXdZb5iIwJ6QNVAutbNY3Rr6haHDxNdG2Da8//R0a03cWtn5EHNrh
         QRLL3LLMmQgcBcjG2DePfGOgb+WfJG3GOu5s93eug2uuQN5YIARMEH/MiP3fwIaXwiRe
         rZQfPofrVS835+BwecrANH2iXKbZ2XaUrjAl8BcBB1xuDALt7m4ZZSMVKG2WhJ4bEU4B
         YWHw==
X-Gm-Message-State: AOJu0YwsAXJnMLOPN2/mXQs9H1KIOs7PU1ELlD954bvavOwJjuMOXk7D
	0zPJgYhnfnIqGZ0iDsQRJZbR3f01Mh03CE+MrkIQEyPBKy/MjmHzWZv6Y1O4EdCHyeqgkJeUoou
	VDJzcb0gFGPLvu4dvBKZWyGlG9pBqATzhtW0=
X-Gm-Gg: ASbGncuq/3FpYsWh4owkKE9Z1MkNnKJhAcuwTYYWZ7bWB2o52MmfLtsW2FMIWct9vGh
	z0BNdtZUxIql7YUtHlYmYSmDSCaFyXrwY9LdNO2yHoI0XAy/iJiAWMSbD4R7hXib3j8SckPSELA
	1MZI3FfQBs3EEJaeUUObzqCLw7KA==
X-Google-Smtp-Source: AGHT+IFRKtog1aegLSZGq1LW1yTh4GqmRqtWK5h1lcyfR8AyExRJsOc6Mn6Lf6zIMap6UZJ6qfoK8B/KwEAI41o3mkc=
X-Received: by 2002:a17:907:3f98:b0:abf:6a8d:76b8 with SMTP id
 a640c23a62f3a-ac6e0a0bbfdmr412984466b.11.1742999637638; Wed, 26 Mar 2025
 07:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6P5mXTR6dpKCKHHrF4jcAL=wWoy3AWK6vateUHphSPvqg@mail.gmail.com>
 <e0930049-e97c-4cda-8cbc-8ad02cd5438a@oracle.com>
In-Reply-To: <e0930049-e97c-4cda-8cbc-8ad02cd5438a@oracle.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Wed, 26 Mar 2025 15:33:19 +0100
X-Gm-Features: AQ5f1JrYD3JDW1SP0ynmWOiIOt4XzK8hpZb-yNFzaa6INkM7UV2-47CLd9POC9Y
Message-ID: <CANH4o6M-gG+e5saZO7LGPU66X8f5azRh78S6ECF-K=zw=J7wxQ@mail.gmail.com>
Subject: Re: The (sorry?) state of pNFS documentation?! Abandonware?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 3:00=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 2/11/25 7:54 AM, Martin Wege wrote:
> > Is there any up to date documentation for pNFS server support in the
> > Linux 6.6 kernel?
>
> There isn't up-to-date documentation for NFSD's pNFS support. There are
> various efforts going on to improve it, but as we are swamped with other
> more pressing issues, there hasn't been good progress.
>
> pNFS block is supported, but it's not straightforward to set up.
>
> pNFS flexfiles is supported, but the implementation supports only the
> case where the DS and MDS are the same server.
>
> NFSD does not implement the other layout types.

More questions:
1. Clarification, please:
Which layout types are and are not supported:
LAYOUT4_NFSV4_1_FILES
LAYOUT4_OSD2_OBJECTS
LAYOUT4_BLOCK_VOLUME

2. Is Flexfiles also part of enum layouttype4, or something different?

3. dCache supports pNFS MetaDataServer (MDS), and NFSv3 Data Servers
(DS). Where is the spec for this? And why, WHY NFSv3 DS? Why not
NFSv4.1 DS=3D

Thanks,
Martin

