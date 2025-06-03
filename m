Return-Path: <linux-nfs+bounces-12074-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81930ACC78C
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 15:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC66D7A3849
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C922D9ED;
	Tue,  3 Jun 2025 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WBSQ6lK9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A48423024D
	for <linux-nfs@vger.kernel.org>; Tue,  3 Jun 2025 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956751; cv=none; b=Ry4tXVaNP4IkcUu3K6PSqNz7AAiQjIFDoFZXtQGhiKzjzejSsRGZaxUCBWFUL7Ddejv6J2v4vqe6o2g6oQjLffCPC2SpyTMVYxZ7hVuFzNExnipwptcKZy4awHwUyYy8zh6njfUgJ2Zn24M9j3XnfzVogz1D6k+khwhkieUur34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956751; c=relaxed/simple;
	bh=U6ppXNYUZiUNW8rzaToCHZVTK/Lsx7lg99NAwR5IA/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=WqiGyqdmO7BgtJo2WAEbm72lQ5foLdVQMuP5ycIrJuYynGpk+YiBb3deq2aNhhu3Vk+xAlpsB1oxePwIQ331xKfjRC5E9uOPL9clOEpitPMk2iJOF0gIXseLxBLVzWoZtfNk6F6n5hLoCLFjyn0zC/aFXsIpGhPz+Ss6uPqlIio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WBSQ6lK9; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250603131900epoutp01a809ed3498c8aa0481ac86d7bc2fd39d~FiuO1G0eT1255612556epoutp01O
	for <linux-nfs@vger.kernel.org>; Tue,  3 Jun 2025 13:19:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250603131900epoutp01a809ed3498c8aa0481ac86d7bc2fd39d~FiuO1G0eT1255612556epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748956740;
	bh=lhg+yoxzmSUI95r9m4I7c09Wc8JZvBjC2Fu14XUQZiQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WBSQ6lK9EWDgjnVk2UCtHoWdiBqZlqtb8XsrOvFf6dvZb1mPriE1FWBFdCTIU+Omt
	 sfXwfjHouTr1qc88PlriEG7dT8fdI458jv1zxM7KNQWgvhbWmx/vMIisreunoFO5cx
	 LXs0VIUkGSuE72lyDrDiyTlCYGseOg1a61E2t5IQ=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250603131859epcas5p3adb125b08bbc9f901dde4353e77a8e0a~FiuNydMNP1272412724epcas5p3Q;
	Tue,  3 Jun 2025 13:18:59 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.178]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bBWWQ3Z6rz6B9m9; Tue,  3 Jun
	2025 13:18:58 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250603091626epcas5p3c6680e3a112b654ee64a2a45ee05c29c~Ffab6u3oY3154931549epcas5p3V;
	Tue,  3 Jun 2025 09:16:26 +0000 (GMT)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250603091621epsmtip1b17ae68149000f4e610433391a5ab9c2~FfaXdde6I1152711527epsmtip1N;
	Tue,  3 Jun 2025 09:16:21 +0000 (GMT)
Message-ID: <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com>
Date: Tue, 3 Jun 2025 14:46:20 +0530
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
To: Christoph Hellwig <hch@lst.de>, Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, p.raghav@samsung.com,
	da.gomez@samsung.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	anuj1072538@gmail.com, kundanthebest@gmail.com
Content-Language: en-US
From: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <20250602141904.GA21996@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250603091626epcas5p3c6680e3a112b654ee64a2a45ee05c29c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529113215epcas5p2edd67e7b129621f386be005fdba53378
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
	<20250529111504.89912-1-kundan.kumar@samsung.com>
	<20250602141904.GA21996@lst.de>

On 6/2/2025 7:49 PM, Christoph Hellwig wrote:
> On Thu, May 29, 2025 at 04:44:51PM +0530, Kundan Kumar wrote:
> Well, the proper thing would be to figure out a good default and not
> just keep things as-is, no?

We observed that some filesystems, such as Btrfs, don't benefit from
this infra due to their distinct writeback architecture. To preserve
current behavior and avoid unintended changes for such filesystems,
we have kept nr_wb_ctx=1 as the default. Filesystems that can take
advantage of parallel writeback (xfs, ext4) can opt-in via a mount
option. Also we wanted to reduce risk during initial integration and
hence kept it as opt-in.

> 
>> IOPS and throughput
>> ===================
>> We see significant improvement in IOPS across several filesystem on both
>> PMEM and NVMe devices.
>>
>> Performance gains:
>>    - On PMEM:
>> 	Base XFS		: 544 MiB/s
>> 	Parallel Writeback XFS	: 1015 MiB/s  (+86%)
>> 	Base EXT4		: 536 MiB/s
>> 	Parallel Writeback EXT4	: 1047 MiB/s  (+95%)
>>
>>    - On NVMe:
>> 	Base XFS		: 651 MiB/s
>> 	Parallel Writeback XFS	: 808 MiB/s  (+24%)
>> 	Base EXT4		: 494 MiB/s
>> 	Parallel Writeback EXT4	: 797 MiB/s  (+61%)
> 
> What worksload was this?

Number of CPUs = 12
System RAM = 16G
For XFS number of AGs = 4
For EXT4 BG count = 28616
Used PMEM of 6G and NVMe SSD of 3.84 TB

fio command line :
fio --directory=/mnt --name=test --bs=4k --iodepth=1024 --rw=randwrite 
--ioengine=io_uring --time_based=1 -runtime=60 --numjobs=12 --size=450M 
--direct=0  --eta-interval=1 --eta-newline=1 --group_reporting

Will measure the write-amp and share.

> 
> How many CPU cores did the system have, how many AGs/BGs did the file
> systems have?   What SSD/Pmem was this?  Did this change the write
> amp as measure by the media writes on the NVMe SSD?
> 
> Also I'd be really curious to see numbers on hard drives.
> 
>> We also see that there is no increase in filesystem fragmentation
>> # of extents:
>>    - On XFS (on PMEM):
>> 	Base XFS		: 1964
>> 	Parallel Writeback XFS	: 1384
>>
>>    - On EXT4 (on PMEM):
>> 	Base EXT4		: 21
>> 	Parallel Writeback EXT4	: 11
> 
> How were the number of extents counts given that they look so wildly
> different?
> 
> 

Issued random write of 1G using fio with fallocate=none and then
measured the number of extents, after a delay of 30 secs :
fio --filename=/mnt/testfile --name=test --bs=4k --iodepth=1024 
--rw=randwrite --ioengine=io_uring  --fallocate=none --numjobs=1 
--size=1G --direct=0 --eta-interval=1 --eta-newline=1 --group_reporting

For xfs used this command:
xfs_io -c "stat" /mnt/testfile

And for ext4 used this:
filefrag /mnt/testfile

