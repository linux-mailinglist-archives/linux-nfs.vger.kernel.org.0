Return-Path: <linux-nfs+bounces-9043-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C4BA083C1
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 01:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4D8188BDD2
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 00:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA0038DE1;
	Fri, 10 Jan 2025 00:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhBOGj0I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEFC14286
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736467297; cv=none; b=oL/HLrbMgO86/LLvxkLrmqr9wnJsC/Gjmj4Rz7b4ShrWlg6BfUp5Os+tq/jArCvxAe2nS0OsgAbmKnBAo2lTuGcX2Lsd60xlOyf7IFVi/TeBTv9X/N65qRUCIADH/voK2FmG6J+nWJWcIpc0pudIK/RouEvCtnWWVct9O7pP+Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736467297; c=relaxed/simple;
	bh=J9pqbGdn6h9iFXO7zIpcPLhCgKAT45zgaiRQ7OtZCyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OV8xNdAivyWnHmHxiwumnb5axDkkvTjtbfWQAn5EMf8VjomD9ZzkrVOVu2MvmBjMjhOYdpT9ZpziEHMD2sq59WGUuaQrOBLZbyx8lPKsiE6znvqPA/tcsOK1YvgykNI+4Bdig2a+EbROPfFmM5N5YZPNOS9QDPYBoql8KiUCyL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhBOGj0I; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ebadbb14dcso604617b6e.3
        for <linux-nfs@vger.kernel.org>; Thu, 09 Jan 2025 16:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736467294; x=1737072094; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9pqbGdn6h9iFXO7zIpcPLhCgKAT45zgaiRQ7OtZCyk=;
        b=EhBOGj0IclKOyZD6eoUh3BzcFfx1sE1wIsgVJca2GJ/hndq0FmCNygzzNEjtXDLQZ9
         GIOqHTn6RsV2tu1m81P+IYS6LYXZ91tpgCBN+NsK65tT9NvS17FdEB38mrOgdOJXZrt/
         6KF62yKTGLPHKwWRDLYzYyhxcTDfuik7Cvgp2Db2snAgWzdqEJtcHN+1AzeP4Ze+Jmsp
         zAEuUqJn0NXgtg+KHFC4OQ1ZxM8u6k9fRu0I4lCQ+WdNeZpXUpeeHfnVLUS2zoiyKP7j
         ypf9bVgEdovA1swltZ0Y//qzuczwXbqc4rbREjqztIXwvUEGGO37h39JpoZKXbrmUY/q
         NJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736467294; x=1737072094;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9pqbGdn6h9iFXO7zIpcPLhCgKAT45zgaiRQ7OtZCyk=;
        b=jvL/HcxPdJzUpsD9YadBESoCnUNOzwe4Q6xomgOfJWPay8CIoIx21HNZxiuP/FswLE
         rHy0eBs5gEC7N1CwMUe977+rz0GIo/mCU/dB/PlfEqeXGSvhGFRfD98nRH37HfR5sq+t
         V6P01XepDU0W2/RBfSUqw+T9dNvW7UbWW8q2BTjJ4V3WrJWTjb0RuxrFr2SG7FAZTFRq
         l4DaVqpTRYWHGEHs7cdiAvBZ1btIfybQPSo5n5s9yWStSQoVm4XztAOF7fMBV/1ASlMI
         K2acttNn0Z10gekZLu2nu3BobWtoDGqmHNpTu+IZ5s14gJWxixjERXcupqD5QXsXmQeW
         t2oQ==
X-Gm-Message-State: AOJu0Yz2wm9+gmVrGYFNH4uaf8fV5zzrYzRIC8S8c7crBkY/BlxHCrD0
	ddBJituBanh+IgjHQ4kTfwTXpQj+tYYreXolLtsE/oRhOyfTaSe1hoShgF1FhF3q0FMOXTrMtNJ
	0AEcNX9eOGyFpi+yVS4Y1ZjOEO74i4hQo
X-Gm-Gg: ASbGncsNARL9+VQHgO7mfWgd32pVgQdaeN7o/doGlVn8FYn/u6NWPwCwAli3ph29B8e
	Oe1omto2hiDmnmwxVU4Ll4smxGkJodGRsgB+Xrfw=
X-Google-Smtp-Source: AGHT+IEzVVHNAYL+qtZh9nFX4svZ1rLLmVBLgIXeRtplKBy+hgsBCbzRpqz80vtbCEYd0dGFAHGobEXtAstTcq2wWTY=
X-Received: by 2002:a05:6871:7882:b0:29f:de75:d178 with SMTP id
 586e51a60fabf-2aa0675551amr4608760fac.19.1736467294507; Thu, 09 Jan 2025
 16:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALWcw=Gg33HWRLCrj9QLXMPME=pnuZx_tE4+Pw8gwutQM4M=vw@mail.gmail.com>
 <e3d4839b-0aa0-42f5-b3d1-4fd2d150da75@oracle.com> <CALWcw=G-TV19UPmL=oy-HE9wc0q-VpHBVyuYcVQ8b9OQq-8Lqg@mail.gmail.com>
 <5c928bae-38e4-490a-a9e7-f52b27a462c9@oracle.com>
In-Reply-To: <5c928bae-38e4-490a-a9e7-f52b27a462c9@oracle.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 10 Jan 2025 01:00:58 +0100
X-Gm-Features: AbW1kvahVW3KA4xO-_rfzLnexmtb_uqlTJEClifUkRB7TM8hRAok8VDgGUZyNZU
Message-ID: <CAAvCNcAoCJBgYBWjtvHYeE5Rk4w3JSqCSJMaHWhrUbrbB4QfLg@mail.gmail.com>
Subject: Re: Needed: ADB (WRITE_SAME) support in Linux nfsd
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Jan 2025 at 17:56, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> On 1/7/25 10:36 AM, Takeshi Nishimura wrote:
> > On Tue, Jan 7, 2025 at 4:10=E2=80=AFPM Anna Schumaker <anna.schumaker@o=
racle.com> wrote:
> >>
> >> Hi Takeshi,
> >>
> >> On 1/6/25 6:56 PM, Takeshi Nishimura wrote:
> >>> Dear list,
> >>>
> >>> how can we get ADB (WRITE_SAME) support in (Debian) Linux nfsd, and a=
n
> >>> ioct() in Linux nfsd client to use it?
> >>
> >> Thanks for the request! Just so you're aware of the process, this emai=
l list is for upstream Linux kernel development. If we decide to go ahead w=
ith adding WRITE_SAME support it'll be up to Debian later to enable it (tha=
t part is out of our hands, and isn't up to us).
> >
> > I assume WRITE_SAME will not have a separate build flag, right?
> >
> >>
> >>>
> >>> We have a set of custom "big data" applications which could greatly
> >>> benefit from such an acceleration ABI, both for implementing "zero
> >>> data" (fill blocks with 0 bytes), and fill blocks with identical data
> >>> patterns, without sending the same pattern over and over again over
> >>> the network wire.
> >>
> >> Having said that, I'm not opposed to implementing WRITE_SAME. I wonder=
 if we could somehow use it to build support for fallocate's FALLOC_FL_ZERO=
_RANGE flag at the same time.
> >
> > No, I am asking really for WRITE_SAME support to write identical data
> > to multiple locations. Like https://linux.die.net/man/8/sg_write_same
> > Writing zero bytes is just a subset, and not what we need. WRITE_SAME
> > is intended as "big data" and database accelerator function.
> >
> >>
> >> I'm also wondering if there would be any advantage to local filesystem=
s if this were to be implemented as a generic system call, rather than as a=
n NFS-specific ioctl(), since some storage devices have a WRITE_SAME operat=
ion that could be used for acceleration. But I haven't convinced myself eit=
her way yet.
> >
> > Getting a new, generic syscall in Linux takes 3-5 years on average. By
> > then our project will be finished, or renewed with new funding, but
> > all without getting a boost from WRITE_SAME support in NFS-
>
> For comparison:
>
> Adding WRITE_SAME to the Linux NFS client and server implementation is
> on the same order of time -- a year (or perhaps less), then getting it
> into Debian stable will be more than 1 year, probably 2 or 3 (at a
> guess).
>
> A better approach would be for your team to implement what they need,
> use it for your project (ie, custom build your kernels), then contribute
> it to upstream so others can use it too. That would demonstrate there is
> real user demand for this facility, and your code will have gained some
> miles in production.

How should this work? The Linux nfs subsystem has become so incredibly
complex that there are only a few people who actually can work on it.
So "implement it yourself" is basically saying "it will never happen".

>
> You could hire a consultant to implement it for you on a time frame that
> is your choosing.

Could you please send me a list of qualified people? We've tried Tech
Recruiters in NYC, but the results were not good, so absurdly
expensive that just using Windows with SMB3.1 is a cheaper option, or
just people who plainly have no idea what they are talking about

> In addition, NFSD is responsible only for the network protocol. The
> local file system implementations have to handle the heavy lifting.
> It's not clear to me what infrastructure is already available in Linux
> file systems; that will take some research. (I think that is what
> Anna was hinting at).

No, this thinking is wrong. The main bottleneck is the network, or
better, the overhead of sending repeated data (pattern fill for big
data, zero fill and 0xff/0xdd fill for databases) over the wire, which
reduces the network traffic DRAMATICALLY (factor 70 with SMB3.1).

So tacking WRITE_SAME as ioctl() on client side, and expansion as loop
over write() in nfsd would be reasonable as the first implementation
of WRITE_SAME.

What IMO is not reasonable is to say we have to add a super-API which
covers all filesystems and all use cases, and somehow even connects to
sg_write_same(8) too, and all that in a single patch.
That would really take a year, and really would involve everyone at
kernel.org, becoming a F-35-like job generator for everyone.
--=20
Dan Shelton - Cluster Specialist Win/Lin/Bsd

