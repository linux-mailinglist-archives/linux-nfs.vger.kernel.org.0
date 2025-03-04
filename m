Return-Path: <linux-nfs+bounces-10446-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07998A4D405
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 07:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272CF170FDE
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 06:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFBF1F419E;
	Tue,  4 Mar 2025 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv0RIPBl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320711F4607
	for <linux-nfs@vger.kernel.org>; Tue,  4 Mar 2025 06:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070612; cv=none; b=EHi+H9CUDrEdqYucJEIqaz2L/oLq29gfiYWCLUUmaVJb9+ZaRVIpapPKsHN4THZg3BAde7p+DWYoH/hQ/FzLSCc7zzAhtj/VVSCl3c3MvugpMf6qQSH9wZNpC8d0whYForeqPu5dpjeOmjcoAAlJMnUYe+WcMoMDxBCjVMv2o2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070612; c=relaxed/simple;
	bh=h5oegr+UH9vAa7Mnku+9Wj3uODxrDhAVsqiAbj0YQhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XAhGLIUTtVf0YIB42NImFM5EUEOSGh6TxQW+OdwT/lKKC7yQ2ORsPCO8kIcDO+QUoLgnTgABP1r7A8IvBUivEU6JRiMnZLL2kJg2nfOC26H7n242t/K77m81Ym66oj8+zfwFmXzhXHAjCxIGTdJONhERIhHtGY+3+kr7+pno67Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv0RIPBl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so8427898a91.2
        for <linux-nfs@vger.kernel.org>; Mon, 03 Mar 2025 22:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741070610; x=1741675410; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fgenKi5W6ksDlrYvZQctqfdFfa06NnSO3K7WxnSJq6I=;
        b=Cv0RIPBlr0noYens3g9JViomDMjOSDJ2B2V1o7Bn7lqbfvlf3VupMO2KKQKmSQiICC
         WfT74T/eG14zbORNykWVP8QpBPFWk+D3fL87YSaNcILVtNxdbcbPqLOYqUPcWFIiD3yZ
         smgO2z+YhATb7wFjrtcAk5aaLpAdzK7cSkElxtIki4pFi8C8T3WmJcHDR3PjaET3qvvk
         4XGmBkaIlcJ5ZDk5gRcdoBp+XWzY7TxQD8yc27NrDmEsdjkH5p8boocgDIxAGXPwsIN8
         t6yyTQFbwmym7HjJQ1O+iHBSZ0ZfyDYZc0NmJrpDuR0r2b2oLhYIWI9ooPEafJgxNsPL
         yaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741070610; x=1741675410;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgenKi5W6ksDlrYvZQctqfdFfa06NnSO3K7WxnSJq6I=;
        b=Qu11QYuCXbbPqQqnEdW1QJT3ib94jyMqgYDTZM2fdY0Rucl0xf3H0KNx2NCG8R3IZS
         HDQbQhzyKtQB15CG4qsJGtwhIXnOfc6lPFBrq7AhJqriG/IqaZsX9gyhkBzhe+ydu7P+
         YQRtop4eIR1DbPJQDTZ1Mds4kfrNmYlzhvWqWhWa02b0Vjnp3d89mf01gl+yoD4cN/Cz
         Sessevnfneq22HAw1IFS19llR6VpbOQD4igt6DqbWdzKxDsgHx4PNP13f5nCcKV/C7Ba
         q4j8NamETFETVf4+NoNV1QgLvqVQrTjUNuT9udL7Llws2i7DgcbS3XQbgymFQsnSQFib
         PXRA==
X-Gm-Message-State: AOJu0YynkBKypdUGyUOmK0Fhq76+IzJWFUDphGHAJuvC5tfB3DefAAb/
	bT9xzkeRo5rpfWQxgi1cBlFfAblgogClzLieAJwj2qWj5Ui2B0pnKgbvEADeCo4Vj21EcyHydPf
	wAL2NBeyRRDm/s5EzhgXB9hzQzToM5A==
X-Gm-Gg: ASbGnctKLFwOtcFxORgFFqNBVRRudcbNOEBHSFVj5sQDaZGj4qa6GKVe0oIKa6twNr/
	u/4c8QTqaYQAbOZODCrTSEEmowH/0Gt6d+gBwobxyL3075erytNFcBQZLt4kXHl61U8wvqxoi/t
	9Gw+bejojNsKED01zaOPZjOFnGHQ==
X-Google-Smtp-Source: AGHT+IHIHgYojwb2fB4KmWDKk7iQuhHdPbmhSwbiKAzhfbaHyoX/bnTd9ijX+ByCEsaazH2wwM2POfGgOTwUh0qEaUY=
X-Received: by 2002:a17:90b:1d81:b0:2ee:d7d3:3019 with SMTP id
 98e67ed59e1d1-2febab5ba82mr29391695a91.12.1741070609502; Mon, 03 Mar 2025
 22:43:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdddwbzGUUzKdbxpb-yC-FVMhbdcd-P+OLSDNvjZeByGw@mail.gmail.com>
 <CALXu0Ue+w_P6P_yyVR1y85bKXxkorGrctJ4jiTBctQd8ei1_kw@mail.gmail.com>
 <9138cbb9-b373-477e-bcc4-5a7cc4e16ed5@oracle.com> <CALXu0Uew5qUxvH7wum7xC1TBaP43tmrYAbU6iS6yuwJVF6rBrg@mail.gmail.com>
 <db677cf9-6979-4247-a195-5761c27ef2ab@oracle.com>
In-Reply-To: <db677cf9-6979-4247-a195-5761c27ef2ab@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 4 Mar 2025 07:43:00 +0100
X-Gm-Features: AQ5f1JoAUUrOUfYAJdC1lPrmB-I4eSHtMHRuOWfjYRFJ6z9_f9b_d1yxpDV_Aks
Message-ID: <CALXu0UfxxuZm_fFwG9h=+MKhRVfuwXUwhxxnGWV74KtEFt6mgw@mail.gmail.com>
Subject: Re: Increase RPCSVC_MAXPAYLOAD to 8M?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Feb 2025 at 15:25, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> On 2/6/25 3:45 AM, Cedric Blancher wrote:
> > On Wed, 29 Jan 2025 at 16:02, Chuck Lever <chuck.lever@oracle.com> wrote:
> >>
> >> On 1/29/25 2:32 AM, Cedric Blancher wrote:
> >>> On Wed, 22 Jan 2025 at 11:07, Cedric Blancher <cedric.blancher@gmail.com> wrote:
> >>>>
> >>>> Good morning!
> >>>>
> >>>> IMO it might be good to increase RPCSVC_MAXPAYLOAD to at least 8M,
> >>>> giving the NFSv4.1 session mechanism some headroom for negotiation.
> >>>> For over a decade the default value is 1M (1*1024*1024u), which IMO
> >>>> causes problems with anything faster than 2500baseT.
> >>>
> >>> The 1MB limit was defined when 10base5/10baseT was the norm, and
> >>> 100baseT (100mbit) was "fast".
> >>>
> >>> Nowadays 1000baseT is the norm, 2500baseT is in premium *laptops*, and
> >>> 10000baseT is fast.
> >>> Just the 1MB limit is now in the way of EVERYTHING, including "large
> >>> send offload" and other acceleration features.
> >>>
> >>> So my suggestion is to increase the buffer to 4MB by default (2*2MB
> >>> hugepages on x86), and allow a tuneable to select up to 16MB.
> >>
> >> TL;DR: This has been on the long-term to-do list for NFSD for quite some
> >> time.
> >>
> >> We certainly want to support larger COMPOUNDs, but increasing
> >> RPCSVC_MAXPAYLOAD is only the first step.
> >>
> >> The biggest obstacle is the rq_pages[] array in struct svc_rqst. Today
> >> it has 259 entries. Quadrupling that would make the array itself
> >> multiple pages in size, and there's one of these for each nfsd thread.
> >>
> >> We are working on replacing the use of page arrays with folios, which
> >> would make this infrastructure significantly smaller and faster, but it
> >> depends on folio support in all the kernel APIs that NFSD makes use of.
> >> That situation continues to evolve.
> >>
> >> An equivalent issue exists in the Linux NFS client.
> >>
> >> Increasing this capability on the server without having a client that
> >> can make use of it doesn't seem wise.
> >>
> >> You can try increasing the value of RPCSVC_MAXPAYLOAD yourself and try
> >> some measurements to help make the case (and analyze the operational
> >> costs). I think we need some confidence that increasing the maximum
> >> payload size will not unduly impact small I/O.
> >>
> >> Re: a tunable: I'm not sure why someone would want to tune this number
> >> down from the maximum. You can control how much total memory the server
> >> consumes by reducing the number of nfsd threads.
> >>
> >
> > I want a tuneable for TESTING, i.e. lower default (for now), but allow
> > people to grab a stock Linux kernel, increase tunable, and do testing.
> > Not everyone is happy with doing the voodoo of self-build testing,
> > even more so in the (dark) "Age Of SecureBoot", where a signed kernel
> > is mandatory. Therefore: Tuneable.
>
> That's appropriate for experimentation, but not a good long-term
> solution that should go into the upstream source code.

I disagree. How should - in the age of "secureboot enforcement", which
implies that only kernels with cryptographic signatures can be loaded
on servers - data be collected?

>
> A tuneable in the upstream source base means the upstream community and
> distributors have to support it for a very long time, and these are hard
> to get rid of once they become irrelevant.

No, this tunable is very likely to stay. It defines the DEFAULT for the kernel

>
> We have to provide documentation. That documentation might contain
> recommended values, and those change over time. They spread out over
> the internet and the stale recommended values become a liability.
>
> Admins and users frequently set tuneables incorrectly and that results
> in bugs and support calls.
>
> It increases the size of test matrices.
>
> Adding only one of these might not result in a significant increase in
> maintenance cost, but if we allow one tuneable, then we have to allow
> all of them, and that becomes a living nightmare.

That never ever was a problem for any of the UNIX System V
derivatives, which all have kernel tunables loaded from /etc/system.
No one ever complained, and Linux has the same concept with sysctl

>
> So, not as simple and low-cost as you might think to just "add a
> tuneable" in upstream. And not a sensible choice when all you need is a
> temporary adjustment for testing.
>
> Do you have a reason why, after we agree on an increase, this should
> be a setting that admins will need to lower the value from a default of,
> say, 4MB or more? If so, then it makes sense to consider a tuneable (or
> better, a self-tuning mechanism). For a temporary setting for the
> purpose of experimentation, writing your own patch is the better and
> less costly approach.

Testing, profiling, performance measurements, and a 4M default might
be a problem for embedded machines with only 16MB.

So yes, I think Linux either needs a tunable, or just GIVE UP thinking
about a bigger TCP buffer size. People can always RDMA or other
platforms if they want decent transport performance.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

