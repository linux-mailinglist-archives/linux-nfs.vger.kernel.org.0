Return-Path: <linux-nfs+bounces-6104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E80967523
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Sep 2024 07:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4721C20F30
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Sep 2024 05:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E712837D;
	Sun,  1 Sep 2024 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3Q4A8rM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CACF4A01
	for <linux-nfs@vger.kernel.org>; Sun,  1 Sep 2024 05:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725169998; cv=none; b=pt+Nl2XnyvkpYBn85e+GYQd/S5AK5OHhxn06Lur1nMWnWvq0oZD6oRQ4YYKPRymuxHRMkHsrIbtgLYQl4PE1wAv92zXgLu8scVlkvnz4Fg88JEK93Ook48+zB6eRfABm8gxtJfUzFKTf/Yb0GTBSuN/NHE2Or4+PxS85FyvxzNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725169998; c=relaxed/simple;
	bh=gnX3SEVgg0H1+Eun0YFZHnO3q58bzPpHpC8bspxo7B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxjcWHkUAbS+Ugjg5xqdluL2kDQdmjkfBdVaFrDL5IO9VlNiKF0pthabZONdIWR7FNPIX1RK1+uGRHX1Y7wQ7KyF/vBH2lYtVFLdfqNV2ymKG6VqDJFZE3emAqWQhsWUZxek3q/pcjB/FmpDA0MyBlrlpxXSYC7EfieaaOFmjsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3Q4A8rM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6bf92f96f83so16887426d6.3
        for <linux-nfs@vger.kernel.org>; Sat, 31 Aug 2024 22:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725169995; x=1725774795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDHXPFtyASnKqG4EN2AQ9N3kHn70urcD/Ag9CUhQEoc=;
        b=e3Q4A8rMpuIiQDg8aRXRUwIuFdIxXZjDnuzKmqpm8U3H9da3iB1ZULBQRIdTNzk3N0
         n/yDf60wZsjEuSmjW7PMvCNSFRSHVU3GSyEV+tCvrwggOSh6pTaszmB0eeMzsUlmEJ33
         KLpk1zEuVLjzXbZb7SAVAdRAo3+VWiffcrfrv4mIONZMd7oZozAMewKjYOvipElabpon
         teN8xfVVUeZj27XbzRI2mMCq4Oa0X+EFjQJ/rHwlfKc7z5KlEirHTgfkI0iwZZb89rlo
         Grp3lsoAAZicc4oUXGqXxc8AiDQg1c6dqbb6M8oqQkKRUG+USc2IvwPCddn2ffvDqQd7
         mYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725169995; x=1725774795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDHXPFtyASnKqG4EN2AQ9N3kHn70urcD/Ag9CUhQEoc=;
        b=DHganh+Kx15tFBl4AIQgHtBcmt51xPYz6eUsuBskf0gC8zLw9fZppL0QZGFOO+v4OB
         ptqayGM0pxNlKw3BeI2TuEv/CyZrwMI58RsLkCuagWKSwVXC5DXSg2RnNJiPrPfsk214
         ly1Yu4B0F/LrE/FVv1OZEQUIub4jzXvb3TuArLclQF4MfLqjveLCJPbtp3Kb2ZmL7Dnz
         WEkbiplvs5Bfv6z8nDWAMUXWmANIj4WA+rFtDZQWgQoHvBsPfjzIGulsKYp0a9kBWcWF
         qYrqGWryN9Phxm/EzSi1H+6LY747DBRwkzuTDEh4CFXQ1CnDk5UhXGiSzJWbrx+z9RWM
         yfnA==
X-Forwarded-Encrypted: i=1; AJvYcCXr3tGQ3Rv0Sa1IoR37NY6lxB8hVM1B4nGoI2jQINaWIiU0NyDhbTXvrznc6u23iycX3H93DO/IbH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAK2azhoqttIQwSP0+vLl9KlXtie72DuwoELwGFWPps9AehMce
	iJdF42A+BcJVZhxA6CslYVGC7ivlDqInye99qx1wTPbm5XMnF34ZiUIiYxGjHKoqx92nxdqx2pY
	VXYpCNQ3Gh7xL0PrgYWDSbk/VcPR1ppvGrlM=
X-Google-Smtp-Source: AGHT+IHNdBpxD+2Ja85wmScshJIx3NYO/D9jL60uDS9+r15BNAri+Dqkc5kllKafeMZ/VkauvGMs7e48qhcqf8v00iY=
X-Received: by 2002:a05:6214:4b0b:b0:6c3:5f00:8cbc with SMTP id
 6a1803df08f44-6c35f008de5mr18975926d6.28.1725169995205; Sat, 31 Aug 2024
 22:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829091340.2043-1-laoar.shao@gmail.com> <D27B60B1-E44E-4A89-BB2E-EF01526CB432@redhat.com>
 <CALOAHbDuThEW=osQudcxGQtFQqePaHzbG3MJyzGi=fLGbUqmKg@mail.gmail.com> <6B62A228-6C9C-4CDD-8334-E26C11DB51A1@redhat.com>
In-Reply-To: <6B62A228-6C9C-4CDD-8334-E26C11DB51A1@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 1 Sep 2024 13:52:39 +0800
Message-ID: <CALOAHbDjROAvnq+Bp6P_MEWRcAM9cVVdAHivOMWrxd8VmO3gJw@mail.gmail.com>
Subject: Re: [RFC PATCH] NFS: Fix missing files in `ls` command output
To: Benjamin Coddington <bcodding@redhat.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 1:57=E2=80=AFAM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 29 Aug 2024, at 8:54, Yafang Shao wrote:
>
> > On Thu, Aug 29, 2024 at 8:44=E2=80=AFPM Benjamin Coddington <bcodding@r=
edhat.com> wrote:
> >>
> >> On 29 Aug 2024, at 5:13, Yafang Shao wrote:
> >>
> >>> In our production environment, we noticed that some files are missing=
 when
> >>> running the ls command in an NFS directory. However, we can still
> >>> successfully cd into the missing directories. This issue can be illus=
trated
> >>> as follows:
> >>>
> >>>   $ cd nfs
> >>>   $ ls
> >>>   a b c e f            <<<< 'd' is missing
> >>>   $ cd d               <<<< success
> >>>
> >>> I verified the issue with the latest upstream kernel, and it still
> >>> persists. Further analysis reveals that files go missing when the dts=
ize is
> >>> expanded. The default dtsize was reduced from 1MB to 4KB in commit
> >>> 580f236737d1 ("NFS: Adjust the amount of readahead performed by NFS r=
eaddir").
> >>> After restoring the default size to 1MB, the issue disappears. I also=
 tried
> >>> setting the default size to 8KB, and the issue similarly disappears.
> >>>
> >>> Upon further analysis, it appears that there is a bad entry being dec=
oded
> >>> in nfs_readdir_entry_decode(). When a bad entry is encountered, the
> >>> decoding process breaks without handling the error. We should revert =
the
> >>> bad entry in such cases. After implementing this change, the issue is
> >>> resolved.
> >>
> >> It seems like you're trying to handle a server bug of some sort.  Have=
 you
> >> been able to look at a wire capture to determine why there's a bad ent=
ry?
> >
> > I've used tcpdump to analyze the packets but didn't find anything
> > suspicious. Do you have any suggestions?
>
> I'd check to make sure the server isn't overrunning the READDIR request's
> dircount and maxcount (they should be the same for the linux client).  If
> the server isn't exceeding them, then there's a likely client bug.

Thank you for the suggestion. I have captured and analyzed the NFS RPC
traffic using Wireshark. I noticed that the ls command is being split
into two NFS READDIR operations. In the first READDIR request, both
the dircount and maxcount parameters are set to 4008. In the
subsequent READDIR request, both dircount and maxcount are set to
8192.

Interestingly, when I increase the value of ctx->dtsize to 8192, the
ls command now generates only a single NFS READDIR RPC call. In this
case, both the dircount and maxcount parameters are set to 8104. This
issue disappears as well.

--
Regards
Yafang

