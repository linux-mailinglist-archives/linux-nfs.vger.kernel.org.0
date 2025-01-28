Return-Path: <linux-nfs+bounces-9714-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCAAA20797
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 10:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDAA3A71A8
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 09:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C0F19A288;
	Tue, 28 Jan 2025 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="CvwD9NT4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8652F199385;
	Tue, 28 Jan 2025 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738057407; cv=none; b=iEEGMp/j3YzRSiSTKgLYjjvfovmz95fuoUYiU1dsGnzTEUGZtP+MvR9Gf4zS/jSQsYjXBv6f38GBR3TlHnxcSGa4uV8BY5hziiECYopHVYnRY0SRBYXvXBRxV+jK/T5358NTQ3BTtp3txqnWgSGUR87PIcMhefGLj3r7IAXiB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738057407; c=relaxed/simple;
	bh=dENO/oSZL4YN1E2GWU4YlF70onT5q7LmAVAl1FRWQMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N6Ky+MmZpUz/Fru1IoatQdDi1CujYA67YwPsosJeUsQuDB4yzWsqNUsSK7SKohxjRnKSCORFCzDUchsjSm6y3mjuDFRq1yF1dje9pbXT2vtoAFgFUG8kpEXOTzAGSYT3FwPFOkio7APOwKF3mlzzHvJl5E2fDWkX+uG59+HHIaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=CvwD9NT4; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE34DFF807;
	Tue, 28 Jan 2025 09:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1738057396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eaz9YOMv0cC2o84WWZHZqF4Zkm0uRbALe+GHZz7OYhQ=;
	b=CvwD9NT4j+WIHpH7BHuA5lGxqGUk1QYZ7fTaDY8yoEdZ5mbATIGUxT/1MN9/uP4z/ZMsev
	hBb4updQGuMtVZ1VUJQY3lwuHaTaAaYFNGLlb6PWP3aIZg9yWN6Jmx6F6nmnkPV8TZVrQO
	VJvVea89Wgo9XUG/fNJIJEtPT0i0QEGqvkodT1O5+iJ2z4mxL06Vuef40FWoAOHitI2oZl
	zbSgoHE22Yc8KSp8BxbVtM5sh6I6GQsVLiJXMEc52i4KKMK/d1ILcvKu2aLb8CE157C//5
	ojysacr84i3YBNB+80BXgABya35ROLupWE9fdr5TPY39V/QUDufiRcm0j3Gpag==
Message-ID: <3b7a4fb3-9c88-47ca-afc3-a1bb7913fc3d@clip-os.org>
Date: Tue, 28 Jan 2025 10:43:13 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] Fixes multiple sysctl bound checks
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
 codalist@coda.cs.cmu.edu, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
 Joel Granados <j.granados@samsung.com>, Bart Van Assche
 <bvanassche@acm.org>, Leon Romanovsky <leon@kernel.org>,
 Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
References: <20250127142014.37834-1-nicolas.bouchinet@clip-os.org>
 <Z5fK6jnrjMBDrDJg@LQ3V64L9R2>
Content-Language: en-US
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
In-Reply-To: <Z5fK6jnrjMBDrDJg@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org

Hi,

Thank's for your reply.

On 1/27/25 19:05, Joe Damato wrote:
> On Mon, Jan 27, 2025 at 03:19:57PM +0100, nicolas.bouchinet@clip-os.org wrote:
>> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>
>> Hi,
>>
>> This patchset adds some bound checks to sysctls to avoid negative
>> value writes.
>>
>> The patched sysctls were storing the result of the proc_dointvec
>> proc_handler into an unsigned int data. proc_dointvec being able to
>> parse negative value, and it return value being a signed int, this could
>> lead to undefined behaviors.
>> This has led to kernel crash in the past as described in commit
>> 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
>>
>> Most of them are now bounded between SYSCTL_ZERO and SYSCTL_INT_MAX.
>> nf_conntrack_expect_max is bounded between SYSCTL_ONE and SYSCTL_INT_MAX
>> as defined by its documentation.
> I noticed that none of the patches have a Fixes tags. Do any of
> these fix existing crashes or is this just cleanup?

I've just saw that xfrm{4,6}_gc_thresh sysctls where obsolete since 4.14 
in the documentation...

Also, ipv4_dst_ops.gc_thresh is set to `~0` since commit 4ff3885262d0 
("ipv4: Delete routing cache.").

Wich will be printed as -1 when this syctl is read.

```
$ cat /proc/sys/net/ipv4/route/gc_thresh
-1
```

IIUC, it seems to be used in order to disable the garbage collection, 
hence, this patch would make it impossible
to a user to disable it this way.
It should thus be bounded it between SYSCTL_NEG_ONE and SYSCTL_INT_MAX.


Your right, it's only cleanup, I'll push patch 3 separately only on 
netdev, with extended impact analyses, sorry for that.


>
> I am asking because if this is cleanup then it would be "net-next"
> material instead of "net" and would need to be resubmit when then
> merge window has passed [1].
>
> FWIW, I submit a similar change some time ago and it was submit to
> net-next as cleanup [2].
>
> [1]: https://lore.kernel.org/netdev/20250117182059.7ce1196f@kernel.org/
> [2]: https://lore.kernel.org/netdev/CANn89i+=HiffVo9iv2NKMC2LFT15xFLG16h7wN3MCrTiKT3zQQ@mail.gmail.com/T/
>

