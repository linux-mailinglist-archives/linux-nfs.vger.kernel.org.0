Return-Path: <linux-nfs+bounces-1037-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7302582B1EE
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 16:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195C01F21EDB
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 15:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DAC433D8;
	Thu, 11 Jan 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZXLHSmq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ABD15ADE
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 15:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EC6C433C7
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704987624;
	bh=ULm8EjU+KoV6KwpmCHtIG3NltGubglIart3jHJmmH+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WZXLHSmqxpTIIhhPBzMrYcKxv9ONRqhl5EJJCCCIJ6xXNF+t4baCvHolLrM42QagE
	 nLwULLB7ttSnT47AZe0Ed0TmBq73AFGx5gkUW3J8KP50iLyqONGcp5HlwrVcu188Y4
	 bNEnyHQvDYznJZFl50/fCiTeIl+NVqsSfexqS5wlKVo7V0cgVpmx5tMHQSYyseZjJa
	 8qjhjQO5zvnT1oI65FS1nO0uYZJ1hmtI7/nXPZekswsPjqYqp/Bra0FoWyDVUNiPVz
	 zKnho+4iIczI/wcprYgfBV1P6OYYaSjpOJDIetcZ+XlzarWYhimntbIiOEgD5L1vFG
	 6h6WQzEdaAi4A==
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67ff241c2bcso35137716d6.1
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 07:40:24 -0800 (PST)
X-Gm-Message-State: AOJu0YwQ90eUmaqShaievFNCHfbVzwn5c+6mC6X0E7PUm1PYzR7nRP68
	aSydzQqAAuJ6Gx3SIenQ2NuUByHAVVxrk2VyrIg=
X-Google-Smtp-Source: AGHT+IFHi3VWsGbig04UpxfmykHpOca1mWAgLeHoQDGrFwRC5KfijVYq6O2qU+WhzDSUkixlIzlCnNumTnj0kh5qdhA=
X-Received: by 2002:ad4:5ba4:0:b0:680:ff1b:9481 with SMTP id
 4-20020ad45ba4000000b00680ff1b9481mr1358213qvq.108.1704987623555; Thu, 11 Jan
 2024 07:40:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110214314.36822-1-anna@kernel.org> <CAHk-=whbDyOVyNKKhq44PZx0fDA61mHuk=QMc0-mRD2XHp1Zaw@mail.gmail.com>
In-Reply-To: <CAHk-=whbDyOVyNKKhq44PZx0fDA61mHuk=QMc0-mRD2XHp1Zaw@mail.gmail.com>
From: Anna Schumaker <anna@kernel.org>
Date: Thu, 11 Jan 2024 10:40:07 -0500
X-Gmail-Original-Message-ID: <CAFX2Jfmk=9LhNaCZqsXaBTqsS866q_zCzozjsdDPmhg_xxzUgw@mail.gmail.com>
Message-ID: <CAFX2Jfmk=9LhNaCZqsXaBTqsS866q_zCzozjsdDPmhg_xxzUgw@mail.gmail.com>
Subject: Re: [GIT PULL] Please Pull NFS Client Updates for Linux 6.8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Wed, Jan 10, 2024 at 7:22=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 10 Jan 2024 at 13:43, Anna Schumaker <anna@kernel.org> wrote:
> >
> >   git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.8-=
1
>
> .. side note: the key I have for you has expired, and it doesn't look
> like it's been updated in the kernel.org key repo.
>
> And doing a naive "gpg --refresh" doesn't get any updates either,
> because the pgp key server infrastructure has been so broken for so
> many years now.
>
> Can I ask you to refresh your key, maybe send it to Konstantin, and
> please don't make it expire (or at least move the expiration far into
> the future).

Thanks for the heads up about this! Looks like I updated the key
locally in November, but I guess the MIT keyserver choked on it. I've
emailed the updated key to Konstantin like you requested, so that
should be updated now too.

Anna

>
> You aren't the only one with expired keys, I am just randomly picking
> on you because I noticed, and your expiry seems to be fairly recent
> (and I thus have some hope that you'll fix it - I've given up on some
> people)
>
>                 Linus

