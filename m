Return-Path: <linux-nfs+bounces-5019-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA74693A38F
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 17:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9470E2845A7
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09AD156C52;
	Tue, 23 Jul 2024 15:13:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6EE15445E;
	Tue, 23 Jul 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747615; cv=none; b=Wv67X7x6L4G5ss5NxDNZzpWP3SEZ6XTr+hyICpMz8WgAgP8O5CZSujQQhfQNY073Nzq9TCZG5O7jxN0o6QsqUNZNUeeTBmKr1IGWDi048Odz+mZeS3jG+YW8SAWc/rEojnN/t03KKkVs4FXM+53cTSrQIoiTEWRQ53p1gKDu5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747615; c=relaxed/simple;
	bh=Za5OmoIPnwYq3WL7lttx6A0b9aUoBbyxeW7yzzYMZEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBAMgY2r5HCpkTGc1Y5Clsy0UezrNONt1TLHVTfu0MaSSaQicaPfgao3774+xgfBOCOYLMbXWvwfbWUc0C0Ypi61dyXeMQuXMBL/+Hxw8uS7RjkqoHUfLeS3lQECoePRxV+DnJlFl5nCBPBqMQExwyq/NmwLStnx/6/XRRnSvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3B68961E5FE01;
	Tue, 23 Jul 2024 17:13:22 +0200 (CEST)
Message-ID: <e49eb11d-bd62-434a-9480-7d7a6f20e946@molgen.mpg.de>
Date: Tue, 23 Jul 2024 17:13:21 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to debug intermittent increasing md/inflight but no disk
 activity?
To: Andre Noll <maan@tuebingen.mpg.de>, Dave Chinner <david@fromorbit.com>
Cc: linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 it+linux-raid@molgen.mpg.de
References: <4a706b9c-5c47-4e51-87fc-9a1c012d89ba@molgen.mpg.de>
 <Zo8VXAy5jTavSIO8@dread.disaster.area> <Zo_AoEPrCl0SfK1Z@tuebingen.mpg.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <Zo_AoEPrCl0SfK1Z@tuebingen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andre, dear Dave,


Thank you for your replies.


Am 11.07.24 um 13:23 schrieb Andre Noll:
> On Thu, Jul 11, 09:12, Dave Chinner wrote
> 
>>> Of course it’s not reproducible, but any insight how to debug this next time
>>> is much welcomed.
>>
>> Probably not a lot you can do short of reconfiguring your RAID6
>> storage devices to handle small IOs better. However, in general,
>> RAID6 /always sucks/ for small IOs, and the only way to fix this
>> problem is to use high performance SSDs to give you a massive excess
>> of write bandwidth to burn on write amplification....
> 
> FWIW, our approach to mitigate the write amplification suckage of large
> HDD-backed raid6 arrays for small I/Os is to set up a bcache device
> by combining such arrays with two small SSDs (configured as raid1).

Now that file servers with software RAID proliferate in our institute 
due to old systems with battery backed hardware RAID controllers are 
taken offline, we noticed performance problems. (We still have not found 
the silver bullet yet.) My colleague Donald was testing bcache in March, 
but due to the slightly more complex setup, a colleague is currently 
experimenting with a write journal for the software RAID.


Kind regards,

Paul


PS: *bcache* performance test:

     time bash -c '(cd /jbod/MG002/scratch/x && for i in $(seq -w 1000); 
do echo a >  data.$i; done)'

| setting                                | time/s  | time/s  | time/s |
|----------------------------------------|---------|---------|--------|
| xfs/raid6                              | 40.826 | 41.638 | 44.685 |
| bcache/xfs/raid6 mode none             | 32.642 | 29.274 | 27.491 |
| bcache/xfs/raid6 mode writethrough     | 27.028 | 31.754 | 28.884 |
| bache/xfs/raid6 mode writearound       | 24.526 | 30.808 | 28.940 |
| bcache/xfs/raid6 mode writeback        |  5.795 |  6.456 |  7.230 |
| bcachefs 10+2                          | 10,321 | 11,832 | 12,671 |
| bcachefs 10+2+nvme (writeback)         |  9.026 |  8.676 |  8.619 |
| xfs/raid6 (12*100GB)                   | 32.446 | 25.583 | 24.007 |
| xfs/raid5 (12*100GB)                   | 27.934 | 23.705 | 22.558 |
| xfs/bcache(10*raid6,2*raid1 cache) writethrough | 56.240 | 47.997 | 
45.321 |
| xfs/bcache(10*raid6,2*raid1 cache) writeback  | 82.230 | 85.779 | 85.814 |
| xfs/bcache(10*raid6,2*raid1 cache(ssd)) writethrough | 26.459 | 23.631 
| 23.586 |
| xfs/bcache(10*raid6,2*raid1 cache(ssd)) writeback  |  7.729 |  7.073 | 
  6.958 |
| as above with sequential_cutoff=0      |  6.397 |  6.826 |  6.759 |

`sequential_cutoff=0` significantly speeds up the `tar xf 
node-v20.11.0.tar.gz` from 13m45.108s to 5m31.379s ! Maybe the 
sequential cutoff thing doesn't work well over nfs.

1.  Build kernel over NFS with the usual setup: 27m38s
2.  Build kernel over NFS with xfs+bcache with two (raid1) SSDs: 10m27s

