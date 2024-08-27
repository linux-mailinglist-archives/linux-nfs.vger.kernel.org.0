Return-Path: <linux-nfs+bounces-5797-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F70960314
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 09:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0001F21B31
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 07:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5AF13C8F0;
	Tue, 27 Aug 2024 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGTeefnm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1D7747F;
	Tue, 27 Aug 2024 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743908; cv=none; b=tK6XwNr5kl1l6YMa0FU4B2iLnERLUEGuEbSeFBYE/8cKHv5UBxgFfV5pRmEHKmu/kNJT7t59dK86jOVwKamu6sxhrWPx/blmFPd9Wj87QcfpGQ/Gv5tdTqGfChgQgnnlZVez5OdbMCs7DmPW1PftdUUDaLP/taHnkXjVClsbvzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743908; c=relaxed/simple;
	bh=mDJuyJqY7HxSUpYyQsIPkYxF6N1t9wLoCXzdOlBN48A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VF4nOyMo48LHq7AVnFBR4oL0Uh7zjKE8zARVy+ZqrEIfRyXJEa0GBpo9VP3+3yoMbiqpmM5CZYe4UAx5ZqC7JdljnJIA3a1Ch+2QzPkuaH4ubzu4f5blmQVTQfNd2U9oJlRYcuI10HTEo4FNXlq69hIP192P7BaGTavocqQruLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGTeefnm; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-270420e231aso3474662fac.2;
        Tue, 27 Aug 2024 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724743905; x=1725348705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1lD5NsHrENDzakDwTmISjEXVDogNpfvH/RKxNRH+uM=;
        b=kGTeefnmo40otANZZA1wQC/jCOKifpdKFozNXJeiD0GkPQ8nGbZkyxT6HuegAebdvY
         OnfUDhO9QDqVP8KY5c4nOkccMmddn4gatLEhtV0H3sunCl2/IbUnOKKDDttIz7C6gYoc
         lCjPRuPhuhXfHvywPKVeZTrkU8ZlmhzvVm2PKbXnGicfqAZScdWnJdktuoHRQdlOyjWn
         PG1/cxUuaF8qOsTrH6+YsDBVu4JfHicb0vlaz9e+nFVXSv0OLzDZrzKeFOgrCW/M7MFo
         7zuibkFq3x00F0MHwBLforQ9QyLNN7Gpjgg7Jsp/9GWv4IH502UJ3fxeV1jDNV0jEFpX
         3m8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724743905; x=1725348705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1lD5NsHrENDzakDwTmISjEXVDogNpfvH/RKxNRH+uM=;
        b=R15zw/kcDnDV+P4xBAK48gos24np/M7LM5r0vbDMosxmHsxOvxVfV+v88zAkxoey4m
         uKh1jvi7pfOQ9CdBBzf6+OvDRoDC6HUDpfUILZuB4BCIn6Tl2QhhkaXnCt+WH9+VTZow
         smWxrkHYXmHseO94iaGEuM0GteCb8jW5EBwnrORw0N/T+o4YG/NikwW6tx9K17S7wuYR
         2p3aevj/b0oUj2csoNbRMAjf7g+yDkEY+WH6yfkVe1EY40Vb7PoXoL1A/mBpiBpv/Yuh
         xwjJWL51+nE+WxtjyGmOy7kJdVhSUkQ1kSM1KbTuR7zNCgPfOgWp9aVCIV7tUCC5ZdVl
         F+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMQQmB3u8Y1wTMr5VbU34SQDgORXfseeR+OspaZ3vPA+usGXMLSdE57hIi63VK73/rJuOU40zCK7YnkHuVBQDP@vger.kernel.org, AJvYcCVUUICxnwao70NPBw7tH+v2gcqeKAVkgJZjFGHYeVA0FdUXFl+xoxZd1FQZIAO9a+gNt0Xjb9t3m/IM@vger.kernel.org, AJvYcCVq32NyPCgawS8C7uk8uBDgUzm1ARB0kOsz16qNRGzfolqZ3UDG6YrdMEOVl/Lkcvzg7aey20Vw@vger.kernel.org, AJvYcCWeeCRviZU5LhqwbNyZi2H35jSPd4Zvyefxs26qZ2XWCPdU5r2+DhETHd1jDjRIlfxb5gyzOrn3RpR0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3JUa5DH/UXektWt5h39mWxLlBnnkj0YevPNvS2zwEcQJRBE7g
	CakENjOzPsHleQ0n8OhJlAXRYWyFxOfqg9KfMYTo9up80VGCMiRTlq3WMDWP09J2P7Mch3asmRA
	aKwoDgLGLaqaTatVFA0R9+9jRsPw=
X-Google-Smtp-Source: AGHT+IGmpmLBeTAPXPIRwiUfzbOE2eGaYU4f2bM4AiH6RqrYHO9Xxr86yvTVC9mVJ9J5ccdXs8Q9/sfsLUHxQxRc7WI=
X-Received: by 2002:a05:6871:299:b0:25e:c013:a7fb with SMTP id
 586e51a60fabf-2775a0ad385mr2070533fac.43.1724743905038; Tue, 27 Aug 2024
 00:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822133908.1042240-1-lizetao1@huawei.com> <20240822133908.1042240-5-lizetao1@huawei.com>
 <20240824181209.GR2164@kernel.org> <CAOi1vP98rmMKKH-ik4dshO1A9chrfsPqiWDY6Wk4EfQNTeNe8Q@mail.gmail.com>
In-Reply-To: <CAOi1vP98rmMKKH-ik4dshO1A9chrfsPqiWDY6Wk4EfQNTeNe8Q@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 27 Aug 2024 09:31:33 +0200
Message-ID: <CAOi1vP8TaPmxj7Bx4jRubS7rr0+BOmFdJyZx-X6nwivei=sACw@mail.gmail.com>
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

On Sun, Aug 25, 2024 at 6:21=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> w=
rote:
>
> On Sat, Aug 24, 2024 at 8:12=E2=80=AFPM Simon Horman <horms@kernel.org> w=
rote:
> >
> > On Thu, Aug 22, 2024 at 09:39:04PM +0800, Li Zetao wrote:
> > > When resolving name in ceph_dns_resolve_name(), the end address of na=
me
> > > is determined by the minimum value of delim_p and colon_p. So using m=
in()
> > > here is more in line with the context.
> > >
> > > Signed-off-by: Li Zetao <lizetao1@huawei.com>
> > > ---
> > >  net/ceph/messenger.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> > > index 3c8b78d9c4d1..d1b5705dc0c6 100644
> > > --- a/net/ceph/messenger.c
> > > +++ b/net/ceph/messenger.c
> > > @@ -1254,7 +1254,7 @@ static int ceph_dns_resolve_name(const char *na=
me, size_t namelen,
> > >       colon_p =3D memchr(name, ':', namelen);
> > >
> > >       if (delim_p && colon_p)
> > > -             end =3D delim_p < colon_p ? delim_p : colon_p;
> > > +             end =3D min(delim_p, colon_p);
> >
> > Both delim_p, and colon_p are char *, so this seems correct to me.
> >
> > And the code being replaced does appear to be a min() operation in
> > both form and function.
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
> >
> > However, I don't believe libceph changes usually don't go through next-=
next.
> > So I think this either needs to be reposted or get some acks from
> > one of the maintainers.
> >
> > Ilya, Xiubo, perhaps you can offer some guidance here?
>
> Hi Simon,
>
> I'm OK with this being taken through net-next.

I see that Jakub picked up some patches from this series, but not this
one.  I'll go ahead and apply to the Ceph tree.

Thanks,

                Ilya

