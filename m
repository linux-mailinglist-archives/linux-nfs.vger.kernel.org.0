Return-Path: <linux-nfs+bounces-5935-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA62A963B22
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 08:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F3628540D
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 06:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D16F145341;
	Thu, 29 Aug 2024 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHWJ/27z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0674437F;
	Thu, 29 Aug 2024 06:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912318; cv=none; b=ddYFQFADoum7Zh8iOhXqsfP8SoJCMCaQKAnVYh9dIoQan58PfRWIcuw0WT+/0GBh5yz7gR9J6e15wMVoL4j61pMPMCDDhKWANEq/QLSbig3mSMaWPoAcVw30xKF8pt3kAeHsfwJ5LuDzhKdgQo0NCe/yAcl+4HK7HCs4SjnQCl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912318; c=relaxed/simple;
	bh=nX0HdDC/uQiK0Vp22kqAwQTn65WiarvUFMKVqY5Qk38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6Fq0JzVsM7n8pLjEOuVFZ6JEDGSD3z+4Xh9kUPkCHkOVm97+iPaoIaFaRE52XOVdLR7HwVDCG8G06ftOBvjP7buVLZIGGk1BxTIULYmxAFiX/biF2cGP8j1wrjgGgLNnGJ1fs1WxWlglNtTzmuautdvRz0WpWUW4Y7e3EshLNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHWJ/27z; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f402830d19so505721fa.0;
        Wed, 28 Aug 2024 23:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724912314; x=1725517114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nHJ6TD3Hkojd6/sQ9pUfWKbBCkq1P2BzxNIm4ViVAw=;
        b=hHWJ/27zz1pPDOgsy3RsIWeV4C0P4zKwljFd7mXwWgVCJELYGw5UfUlSbkfMmccgdY
         CpAkWZQJEd0xX/XL+aIdVCgN49s8QTa2XPzU0ZHKiGZZF2o9yvejtcM1QRkjHRnNkd5T
         WJL0S0D88nJ4Yg0RW+CcbSCQZ/AQflWCqst3k5+KK1wwaMh0+1RUAnCvVoNyos8bBiY2
         txSgrXporMWcNinsywegyQ1BluF++olE7EVXp68jTbtZo5DPFn8XGQEcRgBrJ/0dvYyE
         Z9Gs5sMjzCo65DM9gai1L+c4DDiqFl8jt64V61zfMkb1U7ZK3BD94/aJBYgd8Qgld8CF
         wVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724912314; x=1725517114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nHJ6TD3Hkojd6/sQ9pUfWKbBCkq1P2BzxNIm4ViVAw=;
        b=vtk6/OEGVTekKWa8MaHLCm80b5e92txzq9sUoaa/28ur9sTx5rk2l/SzcKGvD0ilq0
         j+BcdFTsLcSCliHA3Tzoet9grKr2s4FMS2woDWmQIUwOnDWHvLehWl9g+xCKBT1tKezx
         lLLYeXdmKRNLoIkL4WMdRYo9ZnJFUES+yGMUbtifnGeixuncoWMnTbTHQPaRzOiKvse9
         bG4SNxNb94qh2dFU08Pgj+JojWk5zclOVa8G3cJII3rHG2UekqmweK1/zwguL/4nh/mM
         sQEDG9CDAPBFIY7UPrG9aSgLXUB9j6RIrUwnH1A0S83S976v96eX/btN0IAitLYr2has
         ZI3A==
X-Forwarded-Encrypted: i=1; AJvYcCUNaR4zhcU1tRrEvXJ9UYK9Og9gHBzNY3zvTgwjcxlDLiDbx2O5l22WEuRnw2QxiVGxnsdzm0yhUhpfOwk=@vger.kernel.org, AJvYcCVepKl15CcotcEo6B2e4K+NsVQZ8fj6WgY3wBp2A8N4vztaI+6enjqiQ9W8GIajTbgZcIvq9+6HUykf@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVi+4PbYphFGuysKoqNIDdpmBE2cAebnJOUFjTLSC7yldnncE
	2jPmGQKQthDb/GVHDjzUZz0YXckIZIo439D4SD5W/MeyCaDK4bUH24sQ06vacsLG//ADvgxaiZ7
	SihPsMqv63C9fBqwqCZAMNqlyEu0=
X-Google-Smtp-Source: AGHT+IF62ZTjqKm/rwssN6sSk7oumea/sPsrzyuCuz60SNaoq70+NJL/sZth5fGoRfUTkBdGlwNDnIVkTcndlJ9k8yE=
X-Received: by 2002:a05:651c:220a:b0:2ef:17df:6314 with SMTP id
 38308e7fff4ca-2f610889e07mr7364661fa.4.1724912313252; Wed, 28 Aug 2024
 23:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828072901.1017792-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240828072901.1017792-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 29 Aug 2024 14:18:22 +0800
Message-ID: <CAGWkznEcqq-ZU6AuCZvyscdCpvR47L_9t+Z8Bb=QrxyL4VAaKg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] fs: nfs: replace folio_set_private by folio_attach_private
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Christoph Hellwig <hch@infradead.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

loop more

On Wed, Aug 28, 2024 at 3:29=E2=80=AFPM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> This patch is inspired by a code review of fs codes which aims at
> folio's extra refcnt that could introduce unwanted behavious when
> judging refcnt, such as[1]. The change relys on the policy as the
> LRU page with private data should take one corresponding refcnt.
>
> [1]
> long mapping_evict_folio(struct address_space *mapping, struct folio *fol=
io)
> {
> ...
> //current code will misjudge here if there is one pte on the folio which
> is be deemed as the one as folio's private
>         if (folio_ref_count(folio) >
>                         folio_nr_pages(folio) + folio_has_private(folio) =
+ 1)
>                 return 0;
>         if (!filemap_release_folio(folio, 0))
>                 return 0;
>
>         return remove_mapping(mapping, folio);
> }
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  fs/nfs/write.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index d074d0ceb4f0..80c6ded5f74c 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -772,8 +772,7 @@ static void nfs_inode_add_request(struct nfs_page *re=
q)
>         nfs_lock_request(req);
>         spin_lock(&mapping->i_private_lock);
>         set_bit(PG_MAPPED, &req->wb_flags);
> -       folio_set_private(folio);
> -       folio->private =3D req;
> +       folio_attach_private(folio, req);
>         spin_unlock(&mapping->i_private_lock);
>         atomic_long_inc(&nfsi->nrequests);
>         /* this a head request for a page group - mark it as having an
> @@ -797,8 +796,7 @@ static void nfs_inode_remove_request(struct nfs_page =
*req)
>
>                 spin_lock(&mapping->i_private_lock);
>                 if (likely(folio)) {
> -                       folio->private =3D NULL;
> -                       folio_clear_private(folio);
> +                       folio_detach_private(folio);
>                         clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
>                 }
>                 spin_unlock(&mapping->i_private_lock);
> --
> 2.25.1
>

