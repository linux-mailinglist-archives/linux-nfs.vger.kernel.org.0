Return-Path: <linux-nfs+bounces-7910-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE28A9C60DC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 19:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F8C283DD0
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 18:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CB1205E24;
	Tue, 12 Nov 2024 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf4YihvL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72A217455
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437641; cv=none; b=HHHmSXQV5a+8/yJOEfldvQ8U/4qiK+xm45DYQCRdoxUKh9OZt9M/kg9YAF3jY1OMIJieSkwYP92fwb8V8sl5OqcPS/0H7xoanQXpedderuPNUqP/OVf9F4wrVliPo7ugqnmXvMZr40LKcpxRI5V69fpZvsJbnB2Gn4jZgUWuQbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437641; c=relaxed/simple;
	bh=lFlxFcxUSwTCSYw4Eqr812WUL6cAAkuj1iMYhb3/BFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=gwxSDltiGzxbLuZ32McDkC2GXwKDbWU1ZE2IRDKdkGxr1vjaFg/hDcE5PtViSV2jaX5bt+HI12VTBXbKBhjRYXd+tS+o+JkyXHJoR0Xw5b66Fd2z04xjRLo0iIBb6UdS/32/mFqir3hOULAKisx+G2WdxZjCdfK44CPT8IizLdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kf4YihvL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ceccffadfdso8274642a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 10:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731437636; x=1732042436; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nOnCddqFyPz7c1FwLHlHgkYJE0DASs40HG6lK01v0B4=;
        b=kf4YihvLZUNcldOqqCDQZ/QlRd+3tpd1yo3EmGGw7iyaKTHVEVFzHZLSxrUCZqND+g
         8o1/N+F/vMbNCvFUASoG8G2XvH29fIKUrEjZeRCmKXvj8T7yS+S/XyQd+Tdia1FTNvlF
         lGLyWypcRP9MRDRerehvFESA7CB1F63TdRG7jnUDZUopfCW9mIRuNvoD8mQmSF2+0d/F
         qixgFLRJKyoIj2rfLKTf41kT0tL8Z+Yecquu4MIE0SWLPTe0enuBGe9Utcw1Rd/GQA4f
         6tQ/LJvuv2hM8J+Pd25PQBtB7esw6GkNId6lxy/yFkInQBewRsuHQPzRhGaRjhtc33E9
         70yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437636; x=1732042436;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOnCddqFyPz7c1FwLHlHgkYJE0DASs40HG6lK01v0B4=;
        b=itDSQIbO1ZZw7hGiRi33MHNQvOtMyYmqLqprRfHOcizUkhXvFYaNNuiy28hM/Tu6Gk
         gZ3VIT4vtGITvXVQHenFmOAdF6DtE7fyAIZzAQ0vvtQ5Zz5BiVWpaSuibUbX0QZ2zBY8
         OI4WBblP+gu75E74/7r2stTS1NZdWxeCbSZbhvdxRwFTjXvKeJuA8MzFAonrWnk/nn+x
         2u9Vs0n4l/YOvk8yUqDHhOg65ofGwCprlBritCFmKP9bXRNgZC5lF1LJDp+AbOxSSgER
         cKELM+St3g9/NHT4t68rMxgW+RiRhr6YRUJF+xFGYu+GWzARdPCM+CM9xA+VdfS5TRrF
         dLtw==
X-Gm-Message-State: AOJu0YwZ3ymIvEu2aSbjuvnTllJVmi18+5rgv380/ZUGQYn4XJDxoeNe
	oBZzkRzoAxBaV5KMUQkLHeZ7y6vaHs3kLh7drd4A9es7MD0ouTrrQKRnohVm6/hb/Z15ZAuhDNO
	uxa4gcRG43R5kzz9nLa5fAK5l5Kmdiw==
X-Google-Smtp-Source: AGHT+IEh8bDqFL0WuIz3TxKVfzHA2SWkJ8ZaEZiQz3r3Y1C//QdN5RazBisBRkmo4EkDGT5c1QPzrEmyzYrlei65bKg=
X-Received: by 2002:a05:6402:1ecd:b0:5ce:c9d3:9fdc with SMTP id
 4fb4d7f45d1cf-5cf630c4941mr260554a12.16.1731437635673; Tue, 12 Nov 2024
 10:53:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <OSZPR01MB7772841F20140ACC90AA433B88582@OSZPR01MB7772.jpnprd01.prod.outlook.com>
 <CAHnbEGKJ+=gn4F5tuy+2dY58VS7wOyhyxEqsBQ5xdzXMs-C7cw@mail.gmail.com>
 <B74B2995-94D8-4E45-B2D7-3F7361D1A386@redhat.com> <CAHnbEGL_WD1M2FSQbNkCuZyUSMo8ktUsWRLYFjZ-NKKe1aoLAw@mail.gmail.com>
 <8F936203-8576-4309-B089-E8F38B477E7B@redhat.com> <CAHnbEGL1FVT+dfeSK=UUohNzRpvUZFnrM4dD1mwiYHCHeQUHLw@mail.gmail.com>
 <E358D8BB-3DCB-4784-A05F-35BF43A2CA6C@redhat.com>
In-Reply-To: <E358D8BB-3DCB-4784-A05F-35BF43A2CA6C@redhat.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 12 Nov 2024 19:52:00 +0100
Message-ID: <CALXu0UdpPpM2GHX6cWr+YbYqCqb8eEuLhPJa+oKVr6GfuZGKsA@mail.gmail.com>
Subject: Re: rsize/wsize chaos in heterogeneous environments Re: [PATCH]
 nfs(5): Update rsize/wsize options
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 15:40, Benjamin Coddington <bcodding@redhat.com> wrote:
>
> On 12 Nov 2024, at 9:25, Sebastian Feld wrote:
>
> > Because "pagesize" is a non-portable per-platform value?
>
> ah.  The code we're talking about is the linux kernel which is compiled for
> the architecture and yes - not portable anyway.

It has to be portable for an Administrator. NFS rsize and wsize should
not depend on a machine's page size.

Otherwise you cannot have such entries in /etc/fstab, instead an
Administrator has to rely on /usr/bin/pagesize, /bin/bc and manual
mount script just to pass the rsize+wsize in a portable manner. 100%
not compatible to puppet and common cluster software, and even less
portable for people using nfsroot.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

