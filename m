Return-Path: <linux-nfs+bounces-4742-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C09C92AA61
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 22:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22B6280D7F
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 20:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618EA22612;
	Mon,  8 Jul 2024 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNPbPKiY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398CF7494;
	Mon,  8 Jul 2024 20:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469352; cv=none; b=secbkdL6ykS4+9ibUsG2WFx2wDs0AWWnisiG2H1YS/nY8qzZGKy8CL7vuWRK1DTAA50hCSTyupQ2Q5BpEh1hJmn5687pvgCQxwo9XOabnhJTqvH3vj6kGzm+HwTpl4qJ8MMqfhr8I2vjOJoICMfD9gJDEhvSIhnKsniG5LyhIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469352; c=relaxed/simple;
	bh=YslPtvp4tSwNqUpGxG6jtpOLN7glKal8Ubcynzy2qcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvta7nNbAshdVzDNbAK0Gt1lyR31/wRc2UYeybJONlTEnEP2B3BCvIjReIlRC0BYifPcjF/TeJXlcTuxJZ4q8SzCnOo5bnsZ6VoLsI3iW5H+mP//0vSYoBbCMa4MJGr6X1zRQBcHZD6msSKWFcfXhm7ecdxYRQZM8ypypCenYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNPbPKiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCC7C4AF0F;
	Mon,  8 Jul 2024 20:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720469351;
	bh=YslPtvp4tSwNqUpGxG6jtpOLN7glKal8Ubcynzy2qcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TNPbPKiYqrh3NdCcvGZeUCvnjjjwioq/bhbG1WL3OAq1NNRL0CvU/X+UTe/E3F7GB
	 nfg/QLNtaX0t3GjJf2j/qcF9Ho1COSEy/Dd4eR0aVaDICexkH7nJWHAiuHns4yPYmK
	 N8i+o0ud5ghLfplagtZGO6sSifdFMybV5Uzuhj0cwLtxGNGEkGmjPZEtNkjZbyWt1M
	 mMBOcpQiskz4NLazWINwxBaO/q6Eu1viZ41RiF7mND/+axrbfZiN1WxTfcP5NhFnjQ
	 +E31WULoryZ7KaN1xRoePv5Wt7n8jDD5/IBLKqoBwZMvK/9GCsUkKlYstX81wGOl9o
	 VxpvbIF+MXVsQ==
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4463b71d5b0so37537611cf.1;
        Mon, 08 Jul 2024 13:09:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvbv2ZhGPbaIwMx0UPjYWAsrW/UdDQvN1LJPHxvg12vcib9cTYirolyM4Dj8/XJL6WeSy3oVgyQe2BY/eS0frYmi98dFb2krnKKEejuBzyhX32aSGhlAthAehAo8EDeOwU
X-Gm-Message-State: AOJu0Yz4LOagjhWFImgIAa/RT3qa5EmZc9IRXQ1I853hKlLC+wacljET
	2InfEvCPqN0Qtmv9HpG4HvA4Y1rc0PJO1h1oCDzSNDd0VWLopipbNCloYXTQ+WsNAqWFLw6CrgE
	kx186cjJsuyeO+Pu3umkcjNryMJU=
X-Google-Smtp-Source: AGHT+IHojCHrMybMdjoyo2B+BTxGM2ExptalQFMohXX3lX463HtQ5G5ftiHMW7tEfFyPZMoCj/9drKeH1n3vn6V+WKg=
X-Received: by 2002:ac8:7302:0:b0:447:e9dc:77a4 with SMTP id
 d75a77b69052e-447fc447ebbmr4794361cf.29.1720469350944; Mon, 08 Jul 2024
 13:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706065008.451441-1-cuigaosheng1@huawei.com> <Zov9DIiHSUGprMK8@tissot.1015granger.net>
In-Reply-To: <Zov9DIiHSUGprMK8@tissot.1015granger.net>
From: Anna Schumaker <anna@kernel.org>
Date: Mon, 8 Jul 2024 16:08:54 -0400
X-Gmail-Original-Message-ID: <CAFX2JfkosbUmY2QTcb4eDTRpZusNUEj_OR2TMx+munSfjr7oeQ@mail.gmail.com>
Message-ID: <CAFX2JfkosbUmY2QTcb4eDTRpZusNUEj_OR2TMx+munSfjr7oeQ@mail.gmail.com>
Subject: Re: [PATCH -next] gss_krb5: Fix the error handling path for crypto_sync_skcipher_setkey
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, cuigaosheng1@huawei.com, 
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, steved@redhat.com, kwc@citi.umich.edu, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 10:52=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On Sat, Jul 06, 2024 at 02:50:08PM +0800, Gaosheng Cui wrote:
> > If we fail to call crypto_sync_skcipher_setkey, we should free the
> > memory allocation for cipher, replace err_return with err_free_cipher
> > to free the memory of cipher.
> >
> > Fixes: 4891f2d008e4 ("gss_krb5: import functionality to derive keys int=
o the kernel")
> > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> > ---
> >  net/sunrpc/auth_gss/gss_krb5_keys.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/=
gss_krb5_keys.c
> > index 06d8ee0db000..4eb19c3a54c7 100644
> > --- a/net/sunrpc/auth_gss/gss_krb5_keys.c
> > +++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
> > @@ -168,7 +168,7 @@ static int krb5_DK(const struct gss_krb5_enctype *g=
k5e,
> >               goto err_return;
> >       blocksize =3D crypto_sync_skcipher_blocksize(cipher);
> >       if (crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len))
> > -             goto err_return;
> > +             goto err_free_cipher;
> >
> >       ret =3D -ENOMEM;
> >       inblockdata =3D kmalloc(blocksize, gfp_mask);
> > --
> > 2.25.1
> >
>
> Anna, Trond, would you like me to take this through the NFSD tree?

Sure! That sounds good to me.

Anna

>
> --
> Chuck Lever

