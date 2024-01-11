Return-Path: <linux-nfs+bounces-1025-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D753A82A537
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 01:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7901DB25EBB
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 00:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8FF19B;
	Thu, 11 Jan 2024 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JxJbvbVI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE03190
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 00:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e461c1f5bso43530555e9.3
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jan 2024 16:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704932539; x=1705537339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XGEe2j+zWvnt/cW6XGUgcVn+9OQn7tO3K0aiS8QcXP0=;
        b=JxJbvbVIprUuJsMw7nBOcC1KTsV/ms8mNZpvnKcLFCeLqmQL3IEH2coKWEGoqB2bZ0
         ZnTQbTGT8w4DxWfHPwOHQMvuhTnnSKMgReDouP+Ply8R4BjSJ4yfhWTf2QOENtTjQhJf
         Gb4RhLwxIPPJJQTA/oH4gksUvA51oTejbA8Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704932539; x=1705537339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGEe2j+zWvnt/cW6XGUgcVn+9OQn7tO3K0aiS8QcXP0=;
        b=eP+ZhP5Z9wVHGRYs+hU7cRbzrtFGbxEH0EmfMnwBPtzwZkC+Rt+QQiUxV0OGpn/IKI
         jSCnWxzEe+TDdVtwKvk5Tfa6tHbUDaS6pxQn2NlNG0lvRaU6FyMwZC3fq2ERXbEl/w7l
         keqlCkfZhxBnxPjtTqfvEkMbuZdaZ9n4vxnL+biBbuItoy9eRRa+eO6NnB/fH3x8wyxB
         OBE182zHgkH/kPi42N8a+DoR/6Q+txTNefQP7F32LFDxdr6q6P1Pi+rZfHes1cMGpw5X
         lDqfh4Uq4SjlIrYyJpVT/ZZEAB84jkb3XZirp3i7TyXu/VGZzsLqq9sPCQlXzhVuPtni
         yHeA==
X-Gm-Message-State: AOJu0YzNOjLCmjfKjSp6IWtwlNCoqJ9doBsm1shzaSqy1FgIv5fWrdUR
	8it0qSkz/XQcdlMA/pisHfvcgWEnNZhZQLQgR6m+bxDEKsLDH3GS
X-Google-Smtp-Source: AGHT+IE0Q3kY3kVle4w3vYkRGi3n+qOV+Qr+AQGp7tHIUF9Ykb/4DzhlTFlY7bJnnkrva3HFO+FmBg==
X-Received: by 2002:a05:600c:4ecf:b0:40d:3b88:4516 with SMTP id g15-20020a05600c4ecf00b0040d3b884516mr113893wmq.95.1704932539056;
        Wed, 10 Jan 2024 16:22:19 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id m18-20020a1709060d9200b00a26aea4942dsm2524019eji.123.2024.01.10.16.22.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 16:22:18 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a29a4f610b1so509010066b.3
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jan 2024 16:22:18 -0800 (PST)
X-Received: by 2002:a17:906:b1d4:b0:a2b:c70e:c194 with SMTP id
 bv20-20020a170906b1d400b00a2bc70ec194mr128665ejb.95.1704932538096; Wed, 10
 Jan 2024 16:22:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110214314.36822-1-anna@kernel.org>
In-Reply-To: <20240110214314.36822-1-anna@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 16:22:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=whbDyOVyNKKhq44PZx0fDA61mHuk=QMc0-mRD2XHp1Zaw@mail.gmail.com>
Message-ID: <CAHk-=whbDyOVyNKKhq44PZx0fDA61mHuk=QMc0-mRD2XHp1Zaw@mail.gmail.com>
Subject: Re: [GIT PULL] Please Pull NFS Client Updates for Linux 6.8
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 13:43, Anna Schumaker <anna@kernel.org> wrote:
>
>   git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.8-1

.. side note: the key I have for you has expired, and it doesn't look
like it's been updated in the kernel.org key repo.

And doing a naive "gpg --refresh" doesn't get any updates either,
because the pgp key server infrastructure has been so broken for so
many years now.

Can I ask you to refresh your key, maybe send it to Konstantin, and
please don't make it expire (or at least move the expiration far into
the future).

You aren't the only one with expired keys, I am just randomly picking
on you because I noticed, and your expiry seems to be fairly recent
(and I thus have some hope that you'll fix it - I've given up on some
people)

                Linus

