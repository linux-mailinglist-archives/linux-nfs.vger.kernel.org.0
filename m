Return-Path: <linux-nfs+bounces-11027-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B07AA7E3BF
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 17:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A374250C6
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32B1158D80;
	Mon,  7 Apr 2025 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEm6+G8m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9F1DE3B6
	for <linux-nfs@vger.kernel.org>; Mon,  7 Apr 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038025; cv=none; b=O0w3bie5ywMZfSq6x+drHA7iNhDPSlctyL0zi/Ufo1xulkME6hvS7iQxyx9YU/+XaTQlP3pTmxjVs6Les31ScfYFPnqFumKq1oMEDKySGnDz50GRGVGvciT4lScB3lVSQP2ZUVa8InH01v8wWzG3x6WLGhBObDJ7mLJlGzBLzn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038025; c=relaxed/simple;
	bh=pA6pbQMfpnYbJgSe17YT51ERrIoEwLZjdfbgqB/wgbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OCQlvCCNRrwLhHqKi7YxFDyQ+Swol9wfNev0EcAAWCZF+G0lTRTDDZPsP91MfC3aa+xpnu5G6AV8pi7qLmywmp1CTYoQ4Rrdv2wab+OQIS4isfra5SFO9OteBgdgWNfVVqrY7x57junlsm/1Vit8hWlqQURSSnKO5YSv3KWvNMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEm6+G8m; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-700b17551cdso42541817b3.0
        for <linux-nfs@vger.kernel.org>; Mon, 07 Apr 2025 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744038023; x=1744642823; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uE9LtIPCiyietvuJiEoQwN5YbugL6IP40gSE1Y7bao=;
        b=EEm6+G8mVsVGTrswNG/4vcLJpXjKE8It4E1WuKnK/lpwCYsTA9n8UzNQkl8Yupt6gR
         y9cSUCZql7nN+PLWtxNgyMNzcOuI4MVXmfaQ3jfB23vaePl+W/8Oi9m3nRmWZjp0ExeR
         8CESVHN5ixDFSEER0HS9+D4rVxjpExVaUsyBefok61hdM+vuAv1gBPx6q+uj7ohF11LE
         dyIGDRE4MRFc1K5RW/3VZ87ZkqR8/npxsVam7BTSQ5CPszpAzFnxBxIG12X2nZGcLX2u
         GKFOI7Ap2zfR8qUUkDogn1rQEI0N1U+fbzlQaTQDLIb6la0sCfS4Jkmw0+ALqiRSC4Hj
         zt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744038023; x=1744642823;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uE9LtIPCiyietvuJiEoQwN5YbugL6IP40gSE1Y7bao=;
        b=IFUicB3d8xgiBbAMXJhFszqnjd6CEB+23S7gV//YM/tO9oY2Zh2izklCJQbA/RtZOL
         uMc4C3Sl6LUBE2uQOHkcfevEOKnlHnH7UXl5OMlbAiiDzgQD53Wrf2tGgyqwgLLosPZx
         KucE7Ud6CvXrF4J+Ks6XGhqId0b+wNZeyexnmPxQtDYNuiXJZyfCK6ekHXHkKGUk3phy
         /1TRCd5yaxtQtidRrI/ny3G+kQZbMw89P2k/2MVF+KIM63cQBKy+VFhgv7snfukGnfUC
         IhVu+I5WtxMiAi4UszhrC7pSHXWMGBZvbMvOv9/7SZBCP1/cGkgwz5OBEWvBAtJhJ3k3
         VfaA==
X-Gm-Message-State: AOJu0YxpW0dqtzXB7lDLNrlZo+tDqHRtlzdw2H3FO3Wd89wenH8q8vnV
	2rrkjJqOoPaE62n7dxbOOzDSvuoXqCkj/HY7fsILhY15ECQjHk6G9GGEaFNFoxH3VEdPTSw0YAR
	riEK+VzquClw9Hy7209GT1vEYH8I7ij0x
X-Gm-Gg: ASbGncvD5L1kRGOJ/1UkM37cPmoHmYy+EJV7hI9edetqEHdcE8XdzEOsf/lw1ggXuor
	hKXVsY++sEPrfZF+oYzZjSHlAfKPd6daihn18sDVpps2fPG3LBgM/fLV8ns+ivloSLw3Lfc+0IF
	jVonDwJ6byDA9Nj2epSv0yqh5JyxY=
X-Google-Smtp-Source: AGHT+IFAonjzvk0gEwV4oO+t/0PJQkmE/0OA1MPO/IKJLhqOrGJ9szyDyVxP61oatXH6jCqCXfaKi+KuDG1N7PT90Pc=
X-Received: by 2002:a05:690c:4b06:b0:6f9:af1f:53a4 with SMTP id
 00721157ae682-703e16636afmr232335767b3.32.1744038022601; Mon, 07 Apr 2025
 08:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAiJnjonH=+ah+f-NdWpAgZZ3mcFwGJdfLFnqydzOzG2bt_7cA@mail.gmail.com>
In-Reply-To: <CAAiJnjonH=+ah+f-NdWpAgZZ3mcFwGJdfLFnqydzOzG2bt_7cA@mail.gmail.com>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Mon, 7 Apr 2025 18:00:11 +0300
X-Gm-Features: ATxdqUF5OCZGpuhwLxMgilAWySNOB1abswxY-dtbW6vWlAyHbPTjQr367xcrW8c
Message-ID: <CAAiJnjo=3JYHmWhs1fZwNCf0SD4PbGHGhsYRS4n=KsY3aMyw4Q@mail.gmail.com>
Subject: Re: NFS client read bandwidth is not scaling up with nconnect value
 higher 4+
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update -

I have thought that TCP limitation and switched to RDMA, but the same
performance, even slightly worse than TCP.

So I can't get more 16 GiB/s per mount point with increasing nconnect=3D4+

Anton

=D1=81=D0=B1, 5 =D0=B0=D0=BF=D1=80. 2025=E2=80=AF=D0=B3. =D0=B2 19:01, Anto=
n Gavriliuk <antosha20xx@gmail.com>:
>
> There is the file I can locally read in one thread ~55 GB/s,
>
> [root@localhost anton]# fio --name=3Dtest --rw=3Dread --bs=3D128k
> --filename=3D/mnt/testfile --direct=3D1 --numjobs=3D1 --iodepth=3D64 --ex=
itall
> --group_reporting --ioengine=3Dio_uring --runtime=3D30 --time_based
> test: (g=3D0): rw=3Dread, bs=3D(R) 128KiB-128KiB, (W) 128KiB-128KiB, (T)
> 128KiB-128KiB, ioengine=3Dio_uring, iodepth=3D64
> fio-3.39-31-gc283
> Starting 1 process
> Jobs: 1 (f=3D1): [R(1)][100.0%][r=3D51.6GiB/s][r=3D422k IOPS][eta 00m:00s=
]
> test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D19114: Sat Apr  5 18:52:55=
 2025
>   read: IOPS=3D423k, BW=3D51.7GiB/s (55.5GB/s)(1551GiB/30001msec)
>
> I exported the file to the NFS client (hw exactly the same as NFS
> server), which is directly connected using 200 Gbps ConnectX-7 and 2m
> DAC cable.
>
> Without nconnect option, reading in exactly the same way as locally I got=
 4GB/s
> With nconnect=3D2, 8GB/s
> With nconnect=3D4, 15GB/s
> With nconnect=3D6, 15.5 GB/s
> With nconnect=3D8, 15.8 GB/s
>
> Why it doesn't scales up to 23-24 GB/s with increasing number of nconnect=
=3D4+ ?

