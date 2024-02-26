Return-Path: <linux-nfs+bounces-2086-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19904866E15
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 10:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9084285E1C
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A95253393;
	Mon, 26 Feb 2024 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9RcqYty"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5321353392
	for <linux-nfs@vger.kernel.org>; Mon, 26 Feb 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936781; cv=none; b=N+cUIZHOckuQDZoqnhbjMr6NfIO2MxqqU1o0DKuDdVwnagqZZlx6jgt3DczRDOoRWRjvjWz0wu8IPf0Fg96V2WNxIpW+iHtWyrIWD8rwU3cR47MSd+4gyKZLEzYeXEtf4fRV5ENLx/VtUPr7uBQrLkmyz9hoQsGX8ySbhZRJUTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936781; c=relaxed/simple;
	bh=9MzM/EfUjg6Q2/7K2j8SB8iHqM0nd1jWYatIjQwvVXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=C2Wt4dZedFkt/GOsxDVoCutdjoh0gjuRB7hjauRpGngwx2GwxtlEd1WXyLye1ZBp2y0F2En+fKzOz5TS1Vu9VRXNBmdx9r2uLsOLK/mx4DWCT3vEVaDcLbASUI/EjiPUUtvbLFa9Y9GsGv4w6PrjNKemdr2Aa59bxo6Zxx0NIXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9RcqYty; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so3987897a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 26 Feb 2024 00:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708936777; x=1709541577; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJkjXTBzXY+2D9xPxXL1fp+CqJ2v05a2sL5VHAnqrUM=;
        b=c9RcqYtynRgdn+MZr/4Qw7UwS5ut1SLNpeecWmGUbSyp75a/BdXetbisV9FT72KmfC
         MS1dXYrG3q1fu+efGNHmsu1Vq/axNZt2yjZADic22opNzOv5XcyjoALc/Wqpicre5lLn
         7mSKjesxk947f/OeJ5F3m7JWc7ZEnV5FJoPPdo+c+X/9rYQrjgGe1GCz2O6J3PEiEDn0
         gA2NdZedL4bfpDuvhp1ONPxHiFhgKw0RNjSfg4L1lAKPS+eKu0TQKVnznM8lhMvwXwfx
         PQezmye7YrUJHdtJXszj4ha3AoMlhYns+Dgc0KmQ16TgSSg42uBTUvt8QqqjVH4uT6hu
         QIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936777; x=1709541577;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJkjXTBzXY+2D9xPxXL1fp+CqJ2v05a2sL5VHAnqrUM=;
        b=nb/A4KpEWrhxPjxwewumRa6XjNmTdyyU6wbfGZC4zcuAtsYq+58OqqHinG9ept57IH
         yIkdty/qxkLGre1W/a06WLR3mDduQjGyBQq+OHW4PX0ikO1ItICCQPy13Xo5FiCJYSmZ
         Ro4KCXS6kOM+qC1jnEzYR/3d5gCO50B+U0zMBepp5hW2+0lqxwy7WvN9YfHbChT1Sb2R
         7dWHAndyMDF/QOno12K2KoGF7ecBTWecVtUakZ7hSp2QyAcCUlS9ODotP7aPK/yxfBPI
         dgAvWzhVBOg/0FfIm0QLI+PDgVtWFJ2vpGRspiKnuoa+fmjWcF5betZish4NffsSwQhq
         8HMw==
X-Forwarded-Encrypted: i=1; AJvYcCU3QoHg5xD7ssKDZXaxM/RZTuXeZMgAJRRvc1x4pbuTn4gb/i0F3BB4ibLajLFW8UojrCf/J5cKMTKwqsGxqij5FkAEY54dAetJ
X-Gm-Message-State: AOJu0YwzhwNZSBddQiwbZH7WMF0JGJT0sF5BE55WD2l0OGJt698b8hMM
	CSV9UQqo8rGibmuyOr3ShdvbjMmTZhWes9vNzRuIMB9skwmP487RVjWKv2Zc79n9D842GHiGVY2
	YT8yEOpcZENKP5UbPq/Sfzf3kbtc=
X-Google-Smtp-Source: AGHT+IH1DCvXN8DfZCfrhZRBZHdPB/nPtU2ilNdh8acIw2z90Wq7I37fMc26Gv0YgDszc4w9cYBd3w1RnAFwu2xcfTI=
X-Received: by 2002:a05:6402:e9a:b0:565:af1d:7416 with SMTP id
 h26-20020a0564020e9a00b00565af1d7416mr3415808eda.5.1708936777279; Mon, 26 Feb
 2024 00:39:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ujvntmhlfharduyanjob@tgqn> <170890214013.24797.3257981274610636720@noble.neil.brown.name>
 <170890314859.24797.16728369357798855399@noble.neil.brown.name>
In-Reply-To: <170890314859.24797.16728369357798855399@noble.neil.brown.name>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Mon, 26 Feb 2024 09:39:00 +0100
Message-ID: <CALXu0UddUL-inP3LO_LEVPbAqQuWNkwYDDcD05DCfJZDiiOd7A@mail.gmail.com>
Subject: Re: NFS data corruption on congested network
To: NeilBrown <neilb@suse.de>, Jacek Tomaka <jacek.tomaka@poczta.fm>, 
	trond.myklebust@hammerspace.com, anna.schumaker@netapp.com, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Feb 2024 at 00:19, NeilBrown <neilb@suse.de> wrote:
>
> On Mon, 26 Feb 2024, NeilBrown wrote:
> > On Fri, 23 Feb 2024, Jacek Tomaka wrote:
> > > Hello,
> > > I ran into an issue where the NFS file ends up being corrupted on disk. We started noticing it on certain, quite old hardware after upgrading OS from Centos 6 to Rocky 9.2. We do see it on Rocky 9.3 but not on 9.1.
> > >
> > > After some investigation we have reasons to believe that the change was introduced by the following commit:
> > > https://github.com/torvalds/linux/commit/6df25e58532be7a4cd6fb15bcd85805947402d91
> >
> > Thanks for the report.
> > Can you try a change to your kernel?
> >
> > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > index bb79d3a886ae..08a787147bd2 100644
> > --- a/fs/nfs/write.c
> > +++ b/fs/nfs/write.c
> > @@ -668,8 +668,10 @@ static int nfs_writepage_locked(struct folio *folio,
> >       int err;
> >
> >       if (wbc->sync_mode == WB_SYNC_NONE &&
> > -         NFS_SERVER(inode)->write_congested)
> > +         NFS_SERVER(inode)->write_congested) {
> > +             folio_redirty_for_writepage(wbc, folio);
> >               return AOP_WRITEPAGE_ACTIVATE;
> > +     }
> >
> >       nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGE);
> >       nfs_pageio_init_write(&pgio, inode, 0, false,
>
> Actually this is only needed before linux 6.8 as only nfs_writepage()
> can call nfs_writepage_locked() with sync_mode of WB_SYNC_NONE.
> So v5.18 through v6.7 might need fixing.

Please do not forget the Linux 6.6-stable branch!!

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

