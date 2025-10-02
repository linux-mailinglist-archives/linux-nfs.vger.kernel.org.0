Return-Path: <linux-nfs+bounces-14904-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1299FBB34A0
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 10:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484F438815F
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Oct 2025 08:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1342F3619;
	Thu,  2 Oct 2025 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7yqICd5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF17533F6
	for <linux-nfs@vger.kernel.org>; Thu,  2 Oct 2025 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393650; cv=none; b=qsdPhQ3wvtXJhe2zs0FhSpLFOJMh6wj8P/mefkWsqaMUTDbcLvqMvBRgDDrjWOCwS7XD1B7IfTwh0asPoVwiO1RhDjc5DH16KFL7gV2x0mCT3Va+XA0N3JVc69pKzhGgo7JqXYez+toDDV3EG6eKTSfDY6pMUDNldJfnNDBwoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393650; c=relaxed/simple;
	bh=+1qX25Mfe9rX2+ARH+VX4aG7yOVE6FKN1gPxA3Bud+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ojSdNdoSui2wZ/Xpt32hbFuNY5W2qONC+ynYYX3cj+6picOMeQWL4fkSNZG/9a90YOCdKSfO9QlaCRSiIbPhg7JL5gAjaHFxsKcMT2bELjNn/NU5XO58ZuqqeWASuKF4gG+YoZwPri9gqf7k46b+2QsHSJ7XbgfSPVp3QeNeOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7yqICd5; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso1643139a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 02 Oct 2025 01:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759393647; x=1759998447; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZVj3pumt6+6tINltTA3cgcubn5aCLTSl+fYTeDcKPU=;
        b=O7yqICd5A4WG8iYwW9YhS0SxB6hglpn1Fq6JCIxS6ipQDeHhZQaweD8AwwkR+e8631
         Z7ZSWxe3hglRVnOLtIOLInVzNLk24aqu+FczOpLTmddBXXYPKrUVvyAwhdA32/a52EPF
         A+Xc7e8btlByuNmuLEoy3Ns0riTzTwK5DWhk/J5zMfgnef1ApmmeKL3DuUIoP0RfJ4rs
         D+0CTNHeOQNkmC6EorpXgNbiMwFe8sy07dqu+RWQAW8haVrwZZ/K+7xkPEIQMGnSRJKL
         +LKlIgUEAmFlBsz8DoBXLHFkCkB8Ryv5JkGQtvKizFQuIu3ywGRkPV1eRG/e7BZEDXlt
         g4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759393647; x=1759998447;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZVj3pumt6+6tINltTA3cgcubn5aCLTSl+fYTeDcKPU=;
        b=uPo3splBghb7P9Q4gNvmkVpaKQyywj1/ku22E1MrLgKVslMf0m1+DD2u4BAa7Lc6qP
         83bvcnObPl6uf0NnwptLSal1tbNMzbTkYO/2tZ6GkUDEMXkJgvRfQ4kbhbzjxMAPYpgT
         /SmUPGEvqf32vB+rdo6aLg5L98Fnwj2KCnR0mMJkKYn0mQ3SAK5kFw+8fph/P87wftPG
         1i+TC8kiw7JSi32y54+DlqT2wwLYcL1PNrpo32LE383d59supTWZtZw809JCriYaRbxb
         BNB3twas7JGVSmDwBJbljKB51/hIleFADu1aaXlJ5NDy7HBZ/A2SGS0KEcdAr+FnoG6y
         20IA==
X-Gm-Message-State: AOJu0YxdPz/wE5JQsSV5M1hOv/YzZiAE4OIDb1w7TKIyKs8meGJCKsgc
	y+Y8JvbIXTlwmllw0tgvJH+wqJAhDKyVOu/Qh+x9SHadZLuQwL1YKwBehDxBdoDtSHsfNu45ZWv
	u+os464lnQFu8BGvh0W1+aipQtNV96hdcWD9H
X-Gm-Gg: ASbGncuuB/055wjN9pApvWV02Boz+ew0O/YrNpKWMcz/BAQ0du1APHTUyWOlcCaC/7j
	wU6wSH+tl8uT8pXKTH7ui93Loa4vfKWeDyvAcLUyjJdX5XLHgA8F60LlSf1pq8C8RiLlT6d12Mw
	nZwf6oTXXFc2HPzr7xiwVvgp+uE2H7NReyK+UTajjgDxP3u9yq02Ugh+xWiYtQtU8SzQyxxWsSc
	aIL/1qYxxNPcw0IjTmn8zmH+TeFdGY=
X-Google-Smtp-Source: AGHT+IE1IdBQgc8C9wCZriBlU8yoUCIP4I+F5WwXTm/h3f4FMOHhUqVI3NrY5vxF7crJEeJertoi74GxA3x+zSaCdUI=
X-Received: by 2002:a05:6402:518c:b0:634:bdb3:e63f with SMTP id
 4fb4d7f45d1cf-63678ce70c6mr7137955a12.20.1759393646791; Thu, 02 Oct 2025
 01:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230901083421.2139-1-chenhx.fnst@fujitsu.com>
 <3461ADBE-EAD4-4EEF-B7B0-45348BCDB92C@redhat.com> <CA+1jF5pHpXHMOv_gRf_en2uX9jfwcCNhoDhYoq5butAFiiMsxg@mail.gmail.com>
 <CA+1jF5pWue5xoRWWecTa95Fuk-qTtBCsTSrVqp6D=_6YSO8+rw@mail.gmail.com> <E0D9CF60-9BC4-4C04-A28F-844296EC61D5@redhat.com>
In-Reply-To: <E0D9CF60-9BC4-4C04-A28F-844296EC61D5@redhat.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Thu, 2 Oct 2025 10:26:50 +0200
X-Gm-Features: AS18NWBYzUdUGaH7xYypbSXPQnyEo-r6PcA62Dp6ZODDR_sKXKl64cVKjTvp0eQ
Message-ID: <CA+1jF5rnz+VQS9CeEcXcTHoSdG275KAAROzcsb31bpe2kkJsKg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] nfsv4: Add support for the birth time attribute
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:47=E2=80=AFPM Benjamin Coddington <bcodding@redhat=
.com> wrote:
>
> On 1 Oct 2025, at 11:42, Aur=C3=A9lien Couderc wrote:
>
> > What is the status of this patch? did it ever made it into the Linus
> > mainline kernel?
>
> Hi Aur=C3=A9lien,
>
> It turns out that there was already posted (much earlier) work to impleme=
nt
> btime in the NFS client.  That work was refreshed:
> https://lore.kernel.org/linux-nfs/cover.1748515333.git.bcodding@redhat.co=
m/
>
> and has been accepted into v6.17.

Thanks.

Where is the commit in Linus's git tree?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

