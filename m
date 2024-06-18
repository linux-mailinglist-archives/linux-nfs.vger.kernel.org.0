Return-Path: <linux-nfs+bounces-3971-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CBB90C350
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 08:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE751F2383E
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 06:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749ECD29E;
	Tue, 18 Jun 2024 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXNbcJhy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65DA81E;
	Tue, 18 Jun 2024 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718690747; cv=none; b=PbXz95nh64q1L8ouBzEDFHsHUk3o/SydttCJXZSHg+ZiCiFUqazbjfKte+XWIsOQuHd5Nkk1JFSCZ4RUT546QkPqZwXA1nvMn9rclZL+rw5Zr9o2fg6La0z7zOFI9uCi6uaZnTI7Dzr6R8l2ig3hcSc6ZJRfetzYjA7g9Y7iExg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718690747; c=relaxed/simple;
	bh=X3Q8ObGzij+dSG86Z8PK2tJ3mq5QnKxsXUU6s1/w4HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QU69HD7vZE0gAmn0mdhxI+RaqQLaAjEEI5Ms1Y+vHV1b/OaU48FzSG/4v9avbT1VhpvlhSry25kns+G1Az2V8bM0qSOoY3+Gm88LFf7RoPlCZvu+H0eCnNLaPEiVeI656zi56yepbB41H8C6U4LoWu/gj2sUVHjB91iEdK3s8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXNbcJhy; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48d7a81a594so2024068137.2;
        Mon, 17 Jun 2024 23:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718690745; x=1719295545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3Q8ObGzij+dSG86Z8PK2tJ3mq5QnKxsXUU6s1/w4HI=;
        b=HXNbcJhyzClhJ9brMxPLqAwNmnfYLulLZJ6dz1MC9KYLl3NupvfGxrjOQW15BcRsGO
         RyxFpKvXeNsoaAUtm5Lp9abkM4fhtEp4Lall2obSew8zrpiRd9ZX2Tkoe7rbEMBzPe2x
         BOgXUcd5NiQusef1YdbtPPhnF4FdJ9cBNz2Y5kgb9Vp9leNkCKx1W/jWOv1qAJOGXlDy
         wNWR6egjcSbdkXxnVNj9IxKMNRYMPL+azrknDKt5fhJ2/Ml65yBwkDxMWwqu+XJF+J3y
         0kghXdFCnaiVcKkMh8Src3TKxc8B46EdQhS02RE4agGbpSW3q9cE20eAczRtAKsEBn8Q
         tI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718690745; x=1719295545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3Q8ObGzij+dSG86Z8PK2tJ3mq5QnKxsXUU6s1/w4HI=;
        b=sp8Rjf9wGUj01upmYKJ7NcUQyFtK0jd+/J1vgKaNh+HXT632RLtV0zx2GdAzVFtART
         aZAQ7ra+eR+i91ro0XPX36zxto0FJz7XTTXKSTZjDDGBk//ety/9TmtKVdYTjHKeuLNF
         dY8OnWEQ+eHYF5WqFjRBEHxsMslGqrBSZglZJTcTMktr9Gko/I3IE1+GFFaglHePAd+u
         RdYuJftt0ODuFrmsM1wrnaPEbpHjnckBYix36BkPP2hKbpmmdg3j+muVqKzQiEegm1Qk
         dq80zNX2++iTRRz9mOaYG+HOCUr4fG/VyuM+oGnPblezltZNGTK7twEocWqJQrAYyrRy
         VymQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+mLRVR8xO5ZigaeuKkWZtDpOqKFB8IjYUC4Z3ibFXnDBRAYTevHAifxu9FvW6w7xAMRQTf91PPT4bIfjisYC+EtzokyVSfTXbQEXWqSyl5GgSyuANREeHmadUxgfdLeh7RB0dtA==
X-Gm-Message-State: AOJu0YyYIngpex0VJa/eEPnAXoufU2VOsfZZqv1ICBUs11YRH1y3UUdq
	rHem9faQHCFjCpC+r+WSB9cRsHlWxhsLfrKBVN9dmfEf7ZXy8L/+UY44ZGTDCr8V8BCm7iV1TfT
	V0cTwc4zfBzekvgFHcGiBtwwjlTE=
X-Google-Smtp-Source: AGHT+IHBlKj1p/6YAG4PEUMl2WFpNXmPgZkujfmPlp3m5fILb2qTogaanfMgBh8OxzmUUNvjWkx03BYKP6OXP/RZMdY=
X-Received: by 2002:a67:e3c3:0:b0:48c:47c3:7857 with SMTP id
 ada2fe7eead31-48dae3e67c2mr11674131137.29.1718690744439; Mon, 17 Jun 2024
 23:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614100329.1203579-1-hch@lst.de> <20240614100329.1203579-2-hch@lst.de>
 <20240614112148.cd1961e84b736060c54bdf26@linux-foundation.org>
 <CAGsJ_4wnWzoScqO9_NddHcDPbe_GbAiRFVm4w_H+QDmH=e=Rsw@mail.gmail.com>
 <20240616085436.GA28058@lst.de> <CAGsJ_4ytrnXJbfVi=PpTw34iBDqEoAm3b16oZr2VQpVWLmh5zA@mail.gmail.com>
 <20240617053201.GA16852@lst.de> <CAGsJ_4xQgY4kn46NO2=OWh2oDUj2F1-oYCRnKG4KCPJFfBT=Ng@mail.gmail.com>
 <20240618055253.GA27945@lst.de>
In-Reply-To: <20240618055253.GA27945@lst.de>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 18 Jun 2024 18:05:33 +1200
Message-ID: <CAGsJ_4xMzU2N=c-vtLv+vJwSJFcADjdaUONc=8yDTm52QabOXw@mail.gmail.com>
Subject: Re: [PATCH] nfs: fix nfs_swap_rw for large-folio swap
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 5:52=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Jun 17, 2024 at 08:02:47PM +1200, Barry Song wrote:
> > I did everything the same as above,
> > but always got failure at the last step to swapon:
> > /mnt/test # swapon swapfile
> > swapon: /mnt/test/swapfile: swapon failed: Invalid argument
>
> You are probably missing
>
> CONFIG_NFS_SWAP=3Dy
>
> in your .config.

Yes, that was exactly what I missed. I then figured it out, reproduced
the issue,
and discovered that the root cause was unrelated to large folios. It
was actually
due to a batched bio plugging optimization from 2022. You can find the new =
patch
here:

https://lore.kernel.org/linux-mm/20240617220135.43563-1-21cnbao@gmail.com/


>

