Return-Path: <linux-nfs+bounces-5708-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD6995E44F
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Aug 2024 18:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77661F214BC
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Aug 2024 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E0B224DC;
	Sun, 25 Aug 2024 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/Vgo3/S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12719B640;
	Sun, 25 Aug 2024 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724602913; cv=none; b=uEN5FA0fslB7bYvuKK0+uWoQwEfRRR8+YKMF9rPZlDRkzGqhFIhSKopeCCsO3qPxq+kKMD6EcZrHS7IpYjlPvUsIn/8KNx5L3UqvmrgkWJiOdJFhNMKGyniBWWpHpxQdJO5aY/OZmRv4Zyc7LuUrnpmGbdJwTOQh/6xANgbhZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724602913; c=relaxed/simple;
	bh=dWB2f/oL7+pEVHKGY7Tsr/C7Wkcs7H5vxCPM5F9D6JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icDPJwKSUogm0MH1cEqu7tWw0+hfoQUJeQkV0lWaJGvaXWCG9C2PJd4/VN/FJcCBWXeG1ukWvtE+Z8XUDvFiBGGP4ZaakJBclBP1Q2VrGi0vrayJVFi9mV157Vn7KyANDXQwyPXRBY0YT37NAJzOUxCyQF57K0a/rVIcxkCYNIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/Vgo3/S; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2705d31a35cso3253992fac.0;
        Sun, 25 Aug 2024 09:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724602911; x=1725207711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3MYbKUNBkklBtjfHinAe6ZFvBjUzpMm2egDh20Y7Rk=;
        b=C/Vgo3/SXGmII+NH6kaNHIUuDuT3MHWEY7lTxIPuQTX80wDS1BDo4IbMIs+x1F24pW
         906GNQeC8qmJkWyNi7g+K1olJTj06GcU6wDGwcPQtrH/udj5ApIyMWiuFrN/TCWr3tMK
         2sVAl503r/DQAPh1H/AgtsrYoYVZu3uoAOg206QYhioHvtZs2LzgJeQuk8UkEdD7168/
         uYxzqiQczbrQyhPDQ1rVjoqlOUPaBoKh7xZcUStyMDeLyd36O1sUjgFlW0RBB7BMDuiN
         yKTqfjI0FJ4wUKd+LiLm26nvTYuRAFfCfi2IOS3ktDgk9Qxvlz32Q8svEU6+z4sgbNgo
         k91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724602911; x=1725207711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3MYbKUNBkklBtjfHinAe6ZFvBjUzpMm2egDh20Y7Rk=;
        b=ZKkMddgzliOtD36LqAry6ftcHwOIdZvLp5Xdcrsvrx0SDnJcUItx/4yYHMYxenNls7
         BpmlEYDkEpzoiqPJPZgxZziz5KFH7ccLleCDgOe0f8pM6KnKl9i+rGhaK56Sp+IWEWln
         saFhcwZ++ewDQlyFl3AjkzOO8eu7O9eLm4HP172GhFXrOiRgb7Eoter6FJ6wUQxqHiY+
         zhcCcXQiciJ3XJjR/ZwBAwYzWu46IJ6kwuiGxNz45ndPYJyVb9a8BlzHGNOlEkX3hCzn
         uQsebZeMFCT2lEBocKopTqp54p8gCsWxbkjzee0LvUr8qxryKoIwzjDsrwxqqddNADTu
         n+6A==
X-Forwarded-Encrypted: i=1; AJvYcCUDtz9OOlM8gHCen5P6yp701QTG2v1L9/rpPnuQOIfmFbSw4nMQ5/45xnbURQLzkTE4dwrViQgP1Egm@vger.kernel.org, AJvYcCVuucZHoNIqUQk/ZAFKGEg+YbLOI/QQ0I0naHKMSl//Cb8sCjTCL5PH0Frc/fYF21h2C3N653NP3p1kof9GnHo3@vger.kernel.org, AJvYcCW6AnHZboEjMHEA3d66icpGaz7ruMu9Zth8lojWssHqorkCrTqxpTjpaVvmbSgDNos3R9D6XWsnO1rM@vger.kernel.org, AJvYcCWsHONvmnvrlrDKUstssb5RT20+aQbU8dklto4mrRAtBLKC7WBDkP9CS4DFg7WAA641bF+QO1Kx@vger.kernel.org
X-Gm-Message-State: AOJu0YzF4/dHmYByGbQ0YZZmWpD+KLr3nrf50Uf56Ts2NjatuA0mkFvc
	rpR2Ur0o1HnWPjYksUFc04UwIdFG36iITNVFo8ov07Qy0gvr8xgO8irzErPTehPVumiwZpeYE4/
	N/QArfO8dQfkRtnfRHFqzozv2+eQ=
X-Google-Smtp-Source: AGHT+IFJ1RD5dDjMQQRiar8HJ7qdHi6IpI1gPYQoCTKg0oJn7Cj2gFNVkJIC9ojaLBUStkUleMxty6SOP948bmoHP9A=
X-Received: by 2002:a05:6870:2051:b0:270:1884:9db1 with SMTP id
 586e51a60fabf-273e63f0a0bmr8312619fac.7.1724602910950; Sun, 25 Aug 2024
 09:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822133908.1042240-1-lizetao1@huawei.com> <20240822133908.1042240-5-lizetao1@huawei.com>
 <20240824181209.GR2164@kernel.org>
In-Reply-To: <20240824181209.GR2164@kernel.org>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Sun, 25 Aug 2024 18:21:38 +0200
Message-ID: <CAOi1vP98rmMKKH-ik4dshO1A9chrfsPqiWDY6Wk4EfQNTeNe8Q@mail.gmail.com>
Subject: Re: [PATCH net-next 4/8] libceph: use min() to simplify the code
To: Simon Horman <horms@kernel.org>
Cc: Li Zetao <lizetao1@huawei.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, marcel@holtmann.org, 
	johan.hedberg@gmail.com, luiz.dentz@gmail.com, xiubli@redhat.com, 
	dsahern@kernel.org, trondmy@kernel.org, anna@kernel.org, 
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, jmaloy@redhat.com, 
	ying.xue@windriver.com, linux@treblig.org, jacob.e.keller@intel.com, 
	willemb@google.com, kuniyu@amazon.com, wuyun.abel@bytedance.com, 
	quic_abchauha@quicinc.com, gouhao@uniontech.com, netdev@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 8:12=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Aug 22, 2024 at 09:39:04PM +0800, Li Zetao wrote:
> > When resolving name in ceph_dns_resolve_name(), the end address of name
> > is determined by the minimum value of delim_p and colon_p. So using min=
()
> > here is more in line with the context.
> >
> > Signed-off-by: Li Zetao <lizetao1@huawei.com>
> > ---
> >  net/ceph/messenger.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> > index 3c8b78d9c4d1..d1b5705dc0c6 100644
> > --- a/net/ceph/messenger.c
> > +++ b/net/ceph/messenger.c
> > @@ -1254,7 +1254,7 @@ static int ceph_dns_resolve_name(const char *name=
, size_t namelen,
> >       colon_p =3D memchr(name, ':', namelen);
> >
> >       if (delim_p && colon_p)
> > -             end =3D delim_p < colon_p ? delim_p : colon_p;
> > +             end =3D min(delim_p, colon_p);
>
> Both delim_p, and colon_p are char *, so this seems correct to me.
>
> And the code being replaced does appear to be a min() operation in
> both form and function.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> However, I don't believe libceph changes usually don't go through next-ne=
xt.
> So I think this either needs to be reposted or get some acks from
> one of the maintainers.
>
> Ilya, Xiubo, perhaps you can offer some guidance here?

Hi Simon,

I'm OK with this being taken through net-next.

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya

