Return-Path: <linux-nfs+bounces-112-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C587FAD72
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 23:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C49A28181E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 22:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE064596F;
	Mon, 27 Nov 2023 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="fh8FgCi5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75527D4B
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 14:26:20 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9ace45341so320481fa.0
        for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 14:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1701123979; x=1701728779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXHR+iFkNdk8OOqg7ZpMKPqXb0ziWcVCp/LPoi0m+2w=;
        b=fh8FgCi5FVDmDsfiqDYGmMWLDObMlk6LgCrBuzGo9z1oA1rf2TyXHZx5/KAC8RJYlB
         NdDHwnmXhslagi+spnR7TNxRuBO7xQCvwLeuoOJuyODiGmfA0wVDw9TNgfssHyluIef2
         k7MML+HyatwUz7QrHTymNQMLfBrc0Ckf8wyIDfvGe77XFQSxcRbslxtbrBt+DIs/MG3t
         xt2qi9iQW3IkxXpwvWLRAbS0xIK7z5zHyaB32o/cEjK7/X+NtvUw7lkvfZ4ZazfbwyhI
         LpDDIhYKBXnwjlhGBYG6uWdAR9s+2+BtbCBp4TZ/mY83UNsOHEq7a9XY8QOz6CUGCcrV
         6awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123979; x=1701728779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXHR+iFkNdk8OOqg7ZpMKPqXb0ziWcVCp/LPoi0m+2w=;
        b=sgeeq2M6qk/3euEHwiqHs210fbWcnpRmIj+33Q/T7y/wy0tvOwsRD1/gYrO9OSl0y+
         G6RvipiYt7/n6i477JAbqreiuezTjalc1IpG2o7CJRddEI1wdLtL62hT22wWx8J/Xvsy
         Pc3zyXKkMZ09pYgjabNJvXWgVsf8G3VDSxbQw9unLDDijLrmYjqvHrl34e8GCYbyHkcs
         Z6xCIYxx5DI3MZ9DL0lE2Npe2blW8JuDMQ5pTqIo4aaLFPnl1BpeEZlN+Dejbw8WBSEF
         xRbkZeRKZpjCol2l64774RhXNFt+MoYLEbXrFkIoQrmtHn9OtuzV/7R9cQUo0jzRTXKY
         UV7w==
X-Gm-Message-State: AOJu0YzqegIzbvOXmJuVKofpBSNON7gzhE6Ernn7vSXtHEVn/tXMUBCn
	jAGFWYUamZki1EH+0DjEk5s9nT2PYYctajomluA=
X-Google-Smtp-Source: AGHT+IFOrjN3YVF8/Pz5qPPM4pE3wyi2PW0PeGv90rt+n0yfviU26Om8ZCq7vnpdmOtXqLLuGu6Qf4MX0BCDLnZqI7c=
X-Received: by 2002:a2e:5404:0:b0:2c8:38b2:2c33 with SMTP id
 i4-20020a2e5404000000b002c838b22c33mr7637023ljb.3.1701123978531; Mon, 27 Nov
 2023 14:26:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127153959.2067-1-thfeathers@sina.cn> <aa9e250a966c47782f79d258ea9818ae4fcbdbc5.camel@hammerspace.com>
 <170112068218.7109.1172633879607916557@noble.neil.brown.name>
In-Reply-To: <170112068218.7109.1172633879607916557@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 27 Nov 2023 12:26:06 -1000
Message-ID: <CAN-5tyHKddhV4OKL+ZhKKTXwoPiSug6rzRtv=Fq9KsY2wH0iPw@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC: _xprt_switch_find_current_entry return xprt with
 condition find_active
To: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"thfeathers@sina.cn" <thfeathers@sina.cn>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>, 
	"tom@talpey.com" <tom@talpey.com>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, 
	"kolga@netapp.com" <kolga@netapp.com>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 11:31=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
>
> On Tue, 28 Nov 2023, Trond Myklebust wrote:
> > On Mon, 2023-11-27 at 23:39 +0800, jsq wrote:
> > > [You don't often get email from thfeathers@sina.cn. Learn why this is
> > > important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > current function always return a active xprt or NULL no matter what
> > > find_active
> >
> >
> > This patch clearly breaks xprt_switch_find_current_entry_offline().
>
> I think it actually fixes xprt_switch_find_current_entry_offline().
>
> Looking closely at _xprt_switch_find_current_entry:
>
>                 if (found && ((find_active && xprt_is_active(pos)) ||
>                               (!find_active && xprt_is_active(pos))))
>
> and comparing with similar code in xprt_switch_find_next_entry:
>
>                 if (found && ((check_active && xprt_is_active(pos)) ||
>                               (!check_active && !xprt_is_active(pos))))
>
> There is a difference in the number of '!'.  I suspect the former is
> wrong.
> If the former is correct, then "find_active" is irrelevant.

Thanks Neil for pointing it out. We need the "find_active", otherwise
as Trond pointed out it breaks the offline function. But I do believe
I missed the "!" in the logic. I believe the reason this hasn't caused
problems is because for the offline transports we never use the
xprt_iter_xprt(). We only iterate thru the get_next when we iterate
offline transports. But I should fix the function that adds the "!".

>
> NeilBrown
>
> > Furthermore, we do not accept patches without a real name on a Signed-
> > off-by: line.
> >
> > So NACK on two accounts.
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >
> >
>
>

