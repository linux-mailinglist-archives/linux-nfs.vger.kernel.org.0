Return-Path: <linux-nfs+bounces-9899-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D72A2A371
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 09:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8948A7A1DC7
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 08:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7B916CD1D;
	Thu,  6 Feb 2025 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLH91XXU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB6B163
	for <linux-nfs@vger.kernel.org>; Thu,  6 Feb 2025 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831549; cv=none; b=YjUmmrGjNkLv15iTc4gtH7+Tzoww4NmFTh5Sx7mzzjBHFNIQQuXqSdrOWYuKGgEeUJhIL+9R7ZTvRZTGD9vCAa6MikZM8/9oulUzXZ4qSHlX2dkkBX3x82lEwO3rpc3jA7VKgGi8RPQlhwKkPLQtYTVLHhIMJYjCqT631qKTVwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831549; c=relaxed/simple;
	bh=SS1IVKzS4MF7XAsLJlHC7iIrB1Il+6UHnOD4QOZt5BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GsD+3SbnZfexQLmitqx8y9LfhNMIuc+6/jVSdTruC530vM/PQs8AVWxONn8akMt2lXO4t+3Hd1Vp521ZOf+HQshyqL4o0WLcM7hBxo1z3DgBURUAKcCjJ7917hR4IjQT8yotuFozd8e5MBAkLeVdUc9do0ZbpgEZYXknGXDmjQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLH91XXU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso971760a91.0
        for <linux-nfs@vger.kernel.org>; Thu, 06 Feb 2025 00:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738831547; x=1739436347; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4STdj3UJNFJcnuFe4+jt5RdTZnfO8fVkpIPHScirFXY=;
        b=ZLH91XXUpSYchX6ISLq29CpF1qcgjWshr6oKESCx/EihoIeqOdiqDS2wALZZJr76ey
         GJWLKACS3I5ub0hs0KTU7vZ2qszytgjaVUfWQ39qrAWi0r1Nf2zolmj9lqhx40X5ycCi
         xddgDmpC5K/6LJCnJ1uN3e45MN5giBaw6UKaG6A0xDuJY5vUPLCfNLJBwdozR3/Oemrn
         5mxjwXURxkSQgbZX1pRuak6LdXbr1Ovu1iplSm9VVn9kk05IkSVSxWyur0QbglHii6ss
         cfZF3w7TMBpdtGC1DDtE0Sp6kf7p3qCLKsGK9psvjijd8ufcNCMgdciLFPykCpF+URD+
         bx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738831547; x=1739436347;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4STdj3UJNFJcnuFe4+jt5RdTZnfO8fVkpIPHScirFXY=;
        b=VnUuS2J0BlFhohVtP0m+6hvx2D/fD+kzGqTdV/HPzXok8ILfMDYRftAc9wttIqq3HM
         qBi5Ls1Snax6hda6YEIHooAGBJv460yhlzOtCu4f18aCSR3r9Qwbm8OVwwsXsEmRHiRL
         99B23c4ioRW0BzEPnDUDJAb3SEUrJ3WlVnMOWyZXjpRVWcf0Sm2ZO3T7evy+hGvmrvrE
         MeHV99+pPl0Qkviayrsr+y79JNn2Zt42yLzLnqubD8HBuV6EyMaGNJsAXUdaGbc2h66Y
         yObk2hPFW7THhGtXy45adxhWmx52XSYcLFNqBHVjaarU4UjtzdMi+H9wrPE5onHpVlAf
         /AqQ==
X-Gm-Message-State: AOJu0Ywdq6yTNsipJr738xvujnU284PP3w27cG33U23fFxSCZY58mBjD
	ko1RBhacBo+OPq468pSXgnQzGlUVHD4YRvzEFINq59irImoqfYkHqWXD+haee/pbLxQ5wu10dzQ
	8sQw1C/Gtrsb2iGDwrFwk0dJi56/qiA==
X-Gm-Gg: ASbGnctxxRZkMKDjQDvGKHznKFOOqStdpjmJlDB3kWZ/+HU9r2zwmO/I6Ul825yw8pG
	iyF2c+YaVmbyv9wyVYkck3JllizWV+hisMALAs8YIDcB54OCTRqVdQcsrPwS0b/+4XibeM3K1tw
	==
X-Google-Smtp-Source: AGHT+IFi1yWdXiF9CT4EMnf/Bn7Q2a1l4hTqm5cuWKPcaX/YBvIpmCTONxP3ePF1wZhMN0PhW5h2X5BBKrzlbybSdFc=
X-Received: by 2002:a17:90b:2243:b0:2f2:e905:d5ff with SMTP id
 98e67ed59e1d1-2f9ff8b47c7mr4518272a91.6.1738831546836; Thu, 06 Feb 2025
 00:45:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdddwbzGUUzKdbxpb-yC-FVMhbdcd-P+OLSDNvjZeByGw@mail.gmail.com>
 <CALXu0Ue+w_P6P_yyVR1y85bKXxkorGrctJ4jiTBctQd8ei1_kw@mail.gmail.com> <9138cbb9-b373-477e-bcc4-5a7cc4e16ed5@oracle.com>
In-Reply-To: <9138cbb9-b373-477e-bcc4-5a7cc4e16ed5@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 6 Feb 2025 09:45:10 +0100
X-Gm-Features: AWEUYZkA00nWQsh8vSmXJy6okFbQ26dL6g37Ki1sxeIxUheBNvH2KEXTuiQn9zk
Message-ID: <CALXu0Uew5qUxvH7wum7xC1TBaP43tmrYAbU6iS6yuwJVF6rBrg@mail.gmail.com>
Subject: Re: Increase RPCSVC_MAXPAYLOAD to 8M?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 16:02, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> On 1/29/25 2:32 AM, Cedric Blancher wrote:
> > On Wed, 22 Jan 2025 at 11:07, Cedric Blancher <cedric.blancher@gmail.com> wrote:
> >>
> >> Good morning!
> >>
> >> IMO it might be good to increase RPCSVC_MAXPAYLOAD to at least 8M,
> >> giving the NFSv4.1 session mechanism some headroom for negotiation.
> >> For over a decade the default value is 1M (1*1024*1024u), which IMO
> >> causes problems with anything faster than 2500baseT.
> >
> > The 1MB limit was defined when 10base5/10baseT was the norm, and
> > 100baseT (100mbit) was "fast".
> >
> > Nowadays 1000baseT is the norm, 2500baseT is in premium *laptops*, and
> > 10000baseT is fast.
> > Just the 1MB limit is now in the way of EVERYTHING, including "large
> > send offload" and other acceleration features.
> >
> > So my suggestion is to increase the buffer to 4MB by default (2*2MB
> > hugepages on x86), and allow a tuneable to select up to 16MB.
>
> TL;DR: This has been on the long-term to-do list for NFSD for quite some
> time.
>
> We certainly want to support larger COMPOUNDs, but increasing
> RPCSVC_MAXPAYLOAD is only the first step.
>
> The biggest obstacle is the rq_pages[] array in struct svc_rqst. Today
> it has 259 entries. Quadrupling that would make the array itself
> multiple pages in size, and there's one of these for each nfsd thread.
>
> We are working on replacing the use of page arrays with folios, which
> would make this infrastructure significantly smaller and faster, but it
> depends on folio support in all the kernel APIs that NFSD makes use of.
> That situation continues to evolve.
>
> An equivalent issue exists in the Linux NFS client.
>
> Increasing this capability on the server without having a client that
> can make use of it doesn't seem wise.
>
> You can try increasing the value of RPCSVC_MAXPAYLOAD yourself and try
> some measurements to help make the case (and analyze the operational
> costs). I think we need some confidence that increasing the maximum
> payload size will not unduly impact small I/O.
>
> Re: a tunable: I'm not sure why someone would want to tune this number
> down from the maximum. You can control how much total memory the server
> consumes by reducing the number of nfsd threads.
>

I want a tuneable for TESTING, i.e. lower default (for now), but allow
people to grab a stock Linux kernel, increase tunable, and do testing.
Not everyone is happy with doing the voodoo of self-build testing,
even more so in the (dark) "Age Of SecureBoot", where a signed kernel
is mandatory. Therefore: Tuneable.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

