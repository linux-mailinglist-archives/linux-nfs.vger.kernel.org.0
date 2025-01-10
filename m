Return-Path: <linux-nfs+bounces-9078-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C563BA0866D
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 06:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B4F67A2465
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 05:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7EB19ABCE;
	Fri, 10 Jan 2025 05:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQAWPs2n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454E1E0DF6
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 05:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736486121; cv=none; b=leyoDlLkJ95UVzQwPLBy2bIvV28nqUKZ9B7iBbQYyBId11FM+d5FcTcWMkYuiox2nkDpZYV77uBu3Wjx0teNBtwkg3eboK6uiG9g4qECPUDP7muN92QpWM1N5Ij/aAzXTO6QA4/DEWPklDZycynoiiwbWqVS5j+fpbTvTbRXWPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736486121; c=relaxed/simple;
	bh=87qerZcHsM6scQCXkBvumsJW7E+1xKvVYLNOsrNPZUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SpwwkqlpM7+BxG6rshQSZxhQqWVl6ktXhI0h5Z5E1dQmBSV/Y5FrvZyxURwsAgMY/uqmrxLjUMWHkYyYTLg3/Tse3QCsz1osZtsWKOnFd4MkPJMEv3T1W28P5Ug1CiS0KEfJ7K0R7rzEeq5jBgyg4KndtugHzUwCZbOHh8Bu3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQAWPs2n; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa679ad4265so510824966b.0
        for <linux-nfs@vger.kernel.org>; Thu, 09 Jan 2025 21:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736486118; x=1737090918; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87qerZcHsM6scQCXkBvumsJW7E+1xKvVYLNOsrNPZUw=;
        b=YQAWPs2nnmAKaTmmPRKdmg6LozKp3IK9lA8LgktG/F16Ab7aT4lv6C6dTBfOLM/G2o
         S2xD6OJhRFhIMzOvGawajJo8JvLbWilQW+1/iW62HJDk7FzfUktvb5XP87T/VGPo8/wR
         NJEZhntzpYoqDo/r8qtfO7qjUlDIo+U7iJ6SQW4QIhRWDoVha6RcrgLOCMiHwuP+EX4k
         FFGwDRS4DEfLau0s3Pc8kgPH0KmkSqMd/J8XGs5g2Vp/h+fOi7mJTxiW3dk+3cAJJgVc
         cXAT12FGDlu903GUzNwCqLqm0zW936itl3bijfxGWtRlqEZfo4edDAheytf/kfTk0txD
         YaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736486118; x=1737090918;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87qerZcHsM6scQCXkBvumsJW7E+1xKvVYLNOsrNPZUw=;
        b=oS9XU/I4ETmKtqPNlL9YYVmakgwn4E/g0KJxb9kRLmrL0aJwXKeLU2WCoUt1Q1BIDO
         mbeL2VojcAW3yM2/KWrDbfveWWTclY7X0wAynNcmlcqXAEF8uRYu+pSw1LVs+DYiNtjZ
         w8lduRGtcTIwr5QcDRXL/aTfazjziBaa0jzuMfWeVeuGvjH0J+rBnWe08o66Ok5SKLAt
         vxLl0GW58tqczThbHzvhTeF4zjQ1GxNoFR1RvxtZhVzIloej6JZmcRdAKQjiu3NoSAkF
         ZgHOac/QlEMuMb29rEssskdvcBDbhpqtyeH/HuTmi5FzbwGSdMM8PoGozPM+xIAPHfZ2
         pGzA==
X-Gm-Message-State: AOJu0Yw2b12KSA6+ck2GD5eS/G8TpVpX/dqdarIB2BehzJULkuzxmRGV
	pkL+syidcVuQeq4Z94NEWxIfIXoAg71PdwdBwmLQ34hvGv/Yv9hRS37yFnPHy6pEZ1R0kpT7ctd
	ttLLdwqKYaNMaKMbFw6AX5X++bR7pGA==
X-Gm-Gg: ASbGnctguH7BFXwUO4Wk0FEsvUmFbldGWhLnUSWIezWGZqnLZBzd5ifKnm5TEjilfqP
	U/rHHh3fF7A0ExzAhfb1BmUIF4oQb8CioSRD2V4Y=
X-Google-Smtp-Source: AGHT+IEW722oWeivUv/UI1d5EyRh+xBaPcRNG94GMOo6M6dK8xizCWbt4H96W7EwiGkFq3AQ6p9uvaswPFGFTGKD5J8=
X-Received: by 2002:a17:907:a088:b0:ab2:bd80:4519 with SMTP id
 a640c23a62f3a-ab2c3c79997mr478279766b.16.1736486117409; Thu, 09 Jan 2025
 21:15:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=Gg33HWRLCrj9QLXMPME=pnuZx_tE4+Pw8gwutQM4M=vw@mail.gmail.com>
 <e3d4839b-0aa0-42f5-b3d1-4fd2d150da75@oracle.com> <CALWcw=G-TV19UPmL=oy-HE9wc0q-VpHBVyuYcVQ8b9OQq-8Lqg@mail.gmail.com>
 <5c928bae-38e4-490a-a9e7-f52b27a462c9@oracle.com> <978d12deaa44ee896d0f1cf42f6745c2b9c9ee6e.camel@hammerspace.com>
In-Reply-To: <978d12deaa44ee896d0f1cf42f6745c2b9c9ee6e.camel@hammerspace.com>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Fri, 10 Jan 2025 06:14:00 +0100
X-Gm-Features: AbW1kvYQZZfThCLxjQb2I-kmHqqTK71HNjCLe1foYyk4QS9ydk6MFTX5yKfXEYs
Message-ID: <CALWcw=F5GncgXSK9q3uTPmCVTJOUuP7E6uUVPpzz2dnKFLt9pg@mail.gmail.com>
Subject: Re: Needed: ADB (WRITE_SAME) support in Linux nfsd
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 2:04=E2=80=AFAM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Tue, 2025-01-07 at 11:55 -0500, Chuck Lever wrote:
> > On 1/7/25 10:36 AM, Takeshi Nishimura wrote:
> > > On Tue, Jan 7, 2025 at 4:10=E2=80=AFPM Anna Schumaker
> > > <anna.schumaker@oracle.com> wrote:
> > > >
> > > > Hi Takeshi,
> > > >
> > > > On 1/6/25 6:56 PM, Takeshi Nishimura wrote:
> > > > > Dear list,
> > > > >
> > > > > how can we get ADB (WRITE_SAME) support in (Debian) Linux nfsd,
> > > > > and an
> > > > > ioct() in Linux nfsd client to use it?
> > > >
> > > > Thanks for the request! Just so you're aware of the process, this
> > > > email list is for upstream Linux kernel development. If we decide
> > > > to go ahead with adding WRITE_SAME support it'll be up to Debian
> > > > later to enable it (that part is out of our hands, and isn't up
> > > > to us).
> > >
> > > I assume WRITE_SAME will not have a separate build flag, right?
> > >
> > > >
> > > > >
> > > > > We have a set of custom "big data" applications which could
> > > > > greatly
> > > > > benefit from such an acceleration ABI, both for implementing
> > > > > "zero
> > > > > data" (fill blocks with 0 bytes), and fill blocks with
> > > > > identical data
> > > > > patterns, without sending the same pattern over and over again
> > > > > over
> > > > > the network wire.
> > > >
> > > > Having said that, I'm not opposed to implementing WRITE_SAME. I
> > > > wonder if we could somehow use it to build support for
> > > > fallocate's FALLOC_FL_ZERO_RANGE flag at the same time.
> > >
> > > No, I am asking really for WRITE_SAME support to write identical
> > > data
> > > to multiple locations. Like
> > > https://linux.die.net/man/8/sg_write_same
> > > Writing zero bytes is just a subset, and not what we need.
> > > WRITE_SAME
> > > is intended as "big data" and database accelerator function.
> > >
> > > >
> > > > I'm also wondering if there would be any advantage to local
> > > > filesystems if this were to be implemented as a generic system
> > > > call, rather than as an NFS-specific ioctl(), since some storage
> > > > devices have a WRITE_SAME operation that could be used for
> > > > acceleration. But I haven't convinced myself either way yet.
> > >
> > > Getting a new, generic syscall in Linux takes 3-5 years on average.
> > > By
> > > then our project will be finished, or renewed with new funding, but
> > > all without getting a boost from WRITE_SAME support in NFS-
> >
> > For comparison:
> >
> > Adding WRITE_SAME to the Linux NFS client and server implementation
> > is
> > on the same order of time -- a year (or perhaps less), then getting
> > it
> > into Debian stable will be more than 1 year, probably 2 or 3 (at a
> > guess).
> >
> > A better approach would be for your team to implement what they need,
> > use it for your project (ie, custom build your kernels), then
> > contribute
> > it to upstream so others can use it too. That would demonstrate there
> > is
> > real user demand for this facility, and your code will have gained
> > some
> > miles in production.
> >
> > You could hire a consultant to implement it for you on a time frame
> > that
> > is your choosing.
> >
> > Upstream prioritizes economy of maintenance over code velocity;
> > meaning,
> > how quickly a feature can be prototyped and productized is less
> > important to us than how much the feature will cost us to maintain in
> > the long run.
> >
> > With my NFSD co-maintainer hat on: I would accept a WRITE_SAME
> > implementation, but it would have to come with tests -- pynfs and
> > xfstests are the usual test harnesses that can accommodate those.
> >
> > In addition, NFSD is responsible only for the network protocol. The
> > local file system implementations have to handle the heavy lifting.
> > It's not clear to me what infrastructure is already available in
> > Linux
> > file systems; that will take some research. (I think that is what
> > Anna was hinting at).
> >
>
> This functionality should be possible to implement using the
> clone_range ioctl() on the server or on the client for that matter.
>
> Yes, you'll have to use multiple clone_range calls, but you can use a
> geometric series to do it efficiently (i.e. write pattern, clone
> pattern, clone 2*pattern, clone 4*pattern, etc....).
>
> It's not hard to do, and the advantage is that it can work for all
> filesystems that implement clone_range. You'd not be limited to just
> using NFS with a special WRITE_SAME ioctl. Furthermore, doing it this
> way is space-efficent on most filesystems.
>

What will happen if someone else writes into the same location while
the geometric series is running?
Should WRITE_SAME not be atomic, or at least protect against other
writes destroying the data?
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>

