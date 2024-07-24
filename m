Return-Path: <linux-nfs+bounces-5027-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B6093ADFE
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 10:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB13E1C2104D
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E60814B968;
	Wed, 24 Jul 2024 08:43:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352B14B09C;
	Wed, 24 Jul 2024 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810581; cv=none; b=E3jFWc0BD0kbABbb4f1Y3JwpfM87ZdXTVZ3mvo/lZSK1OVOgBvlKicOkUh1fItH9XmR9UxYAmexBg0NxzbiefqGsT7ZBjHxM4tErwPBD6DQBOHvmG4eyzEFxu1CWSBxDrglblZojtSgc4Z+rUk11zyOyQeF1QOxF0ZSorQgzCZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810581; c=relaxed/simple;
	bh=Z86dQd3vX+Y2kxN2TvdGxeGpDjidQKCQBr7nL9xiyX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwB9wskZLuTC8xPGDfr/whniZpcm6f+ztRDEHdQrRSTnj3ct65iGFO0SezeosSwiQt2sbkJdbT0asBw8wfqZiqorBiIWOOZ13mrGeTeuET0xxVJJPZVOBZwYrmwXLslUfbQsJ5tJQXlZ/wrXXqV3YxoiKDJeglV/BcJz+MQZ0kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: bizesmtp79t1721810562tfa0kc6s
X-QQ-Originating-IP: gw4d1VNivo+vc5T0fnV2Jn2kiKLeZ1vB79uyeFTpADQ=
Received: from [192.168.3.231] ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jul 2024 16:42:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7577359922609514277
Message-ID: <E451DDFB80BCF897+13507b89-1597-4a34-931a-6c881a4f4205@chenxiaosong.com>
Date: Wed, 24 Jul 2024 16:42:39 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd: radix tree warning in nfs4_put_stid and kernel panic
To: Alex Lyakas <alex@zadara.com>, "J. Bruce Fields" <bfields@fieldses.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Chuck Lever III <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>,
 Benjamin Coddington <bcodding@redhat.com>,
 Olga Kornievskaia <kolga@netapp.com>, Josef Bacik <josef@toxicpanda.com>,
 Jeff Layton <jlayton@kernel.org>, neilb@suse.de,
 Olga Kornievskaia <kolga@netapp.com>, Dai.Ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "liuzhengyuan@kylinos.cn" <liuzhengyuan@kylinos.cn>,
 "huhai@kylinos.cn" <huhai@kylinos.cn>,
 "chenxiaosong@kylinos.cn" <chenxiaosong@kylinos.cn>, liuzhucai@kylinos.cn
References: <76C32636621C40EC87811F625761F2AF@alyakaslap>
 <20200617143113.GB13815@fieldses.org>
 <CAOcd+r2ivBO+S=YKAA_G2xSdeXx9d6T5f7VATm23E+TkuMtmTQ@mail.gmail.com>
Content-Language: en-US
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <CAOcd+r2ivBO+S=YKAA_G2xSdeXx9d6T5f7VATm23E+TkuMtmTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0

Greetings,

Have you fixed this issue [1]? The identical issue on Ubuntu [2] seems 
to have been fixed in tag v5.3-rc5, and patch [3] was committed in 
v5.5-rc1, so does patch [4](was committed in v5.1-rc7) seem more likely 
to fix the issue? Or is there other patch that can fix it?

Thanks,
ChenXiaoSong.

[1] https://lore.kernel.org/all/76C32636621C40EC87811F625761F2AF@alyakaslap/

[2] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1840650

[3] 2bbfed98a4d8 nfsd: Fix races between nfsd4_cb_release() and 
nfsd4_shutdown_callback()

[4] e6abc8caa6de nfsd: Don't release the callback slot unless it was 
actually held

在 2020/6/28 17:07, Alex Lyakas 写道:

> I checked the git log, and found 2 commits that might be relevant [1]
> and [2], [2] seems more relevant. However, I don't have any evidence
> that in my case client was actually being destroyed, causing double
> free of a stateid.
> 
> Thanks,
> Alex.
> 
> [1]
> commit e6abc8caa6deb14be2a206253f7e1c5e37e9515b
> Author: Trond Myklebust <trondmy@gmail.com>
> Date:   Fri Apr 5 08:54:37 2019 -0700
> 
>      nfsd: Don't release the callback slot unless it was actually held
> 
>      If there are multiple callbacks queued, waiting for the callback
>      slot when the callback gets shut down, then they all currently
>      end up acting as if they hold the slot, and call
>      nfsd4_cb_sequence_done() resulting in interesting side-effects.
> 
>      In addition, the 'retry_nowait' path in nfsd4_cb_sequence_done()
>      causes a loop back to nfsd4_cb_prepare() without first freeing the
>      slot, which causes a deadlock when nfsd41_cb_get_slot() gets called
>      a second time.
> 
>      This patch therefore adds a boolean to track whether or not the
>      callback did pick up the slot, so that it can do the right thing
>      in these 2 cases.
> 
>      Cc: stable@vger.kernel.org
>      Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>      Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> 
> 
> [2]
> commit 2bbfed98a4d82ac4e7abfcd4eba40bddfc670b1d
> Author: Trond Myklebust <trondmy@gmail.com>
> Date:   Wed Oct 23 17:43:18 2019 -0400
> 
>      nfsd: Fix races between nfsd4_cb_release() and nfsd4_shutdown_callback()
> 
>      When we're destroying the client lease, and we call
>      nfsd4_shutdown_callback(), we must ensure that we do not return
>      before all outstanding callbacks have terminated and have
>      released their payloads.
> 
>      Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>      Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> 

