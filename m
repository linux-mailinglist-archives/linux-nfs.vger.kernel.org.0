Return-Path: <linux-nfs+bounces-10615-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FA3A60F3D
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 11:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206711B61F18
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 10:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401F72E3364;
	Fri, 14 Mar 2025 10:43:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B8D1FBC8A
	for <linux-nfs@vger.kernel.org>; Fri, 14 Mar 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948997; cv=none; b=l0UXGC/C/lY5zltV7uwn+4iNnSRPLtA5xwSvAjfXyAftd5f0eDXf6WOoBr/wkm9oFbUhTTGd0UlcWX2Kvl5rsUF+XXMfDqYtYSTA0YYs7pvwC5RJDnAmr0C3Rg1CDSRnXbVgxkLezer/Rr2DfGNRisEc3vxAQvkycMSJMQzZEvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948997; c=relaxed/simple;
	bh=VcIPwp5lERSTIW2BwVVjVL3PRsBnqOcTV57V/Jdp3OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zakv5Nu97B/s1IdEd9CIR0KcKNIqBmmt8HwkJhuYpKhKDgUaCtL84vM91uvfPYMosBYXbd61YlNbPxTNM86y4kl3ITno/UJ+sOoG9/FZTCJt42XWTaIc6Li34OPF1lYGNMWRfD5DF6EG2svWI3yYhFV7D6Aaqwnvan7BIWj04MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 947161424;
	Fri, 14 Mar 2025 03:43:24 -0700 (PDT)
Received: from [10.57.39.196] (unknown [10.57.39.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 680173F5A1;
	Fri, 14 Mar 2025 03:43:13 -0700 (PDT)
Message-ID: <e59f75ea-9b50-45dc-aa89-f0e02aa4e787@arm.com>
Date: Fri, 14 Mar 2025 10:43:11 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFS Server Issues with RDMA in Kernel 6.13.6
To: Lucas via Bugspray Bot <bugbot@kernel.org>, jlayton@kernel.org,
 chuck.lever@oracle.com, linux-nfs@vger.kernel.org, iommu@lists.linux.dev,
 cel@kernel.org, trondmy@kernel.org, anna@kernel.org
References: <7285c885-f998-410a-b6a6-f743328bf0b8@oracle.com>
 <20250313-b219865c2-ff4305a1f238@bugzilla.kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250313-b219865c2-ff4305a1f238@bugzilla.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-13 7:20 pm, Lucas via Bugspray Bot wrote:
[...]
> system: Suermicro AS-4124GS-TNR
> cpu: AMD EPYC 7H12 64-Core Processor
> ram: 512G
> rdma nic: Mellanox Technologies MT2910 Family [ConnectX-7]
> 
> 
>>> [  976.677373]  __dma_map_sg_attrs+0x139/0x1b0
>>> [  976.677380]  dma_map_sgtable+0x21/0x50
>>
>> So, here (and above) is where we leave the NFS server and venture into
>> the IOMMU layer. Adding the I/O folks for additional eyes.
>>
>> Can you give us the output of:
>>
>>    $ scripts/faddr2line drivers/iommu/iova.o alloc_iova+0x92
>>
> 
> 
> root@test:/usr/src/linux-6.13.6# scripts/faddr2line drivers/iommu/iova.o alloc_iova+0x92
> alloc_iova+0x92/0x290:
> __alloc_and_insert_iova_range at /usr/src/linux-6.13.6/drivers/iommu/iova.c:180
> (inlined by) alloc_iova at /usr/src/linux-6.13.6/drivers/iommu/iova.c:263
> root@test:/usr/src/linux-6.13.6#

OK so this is waiting for iova_rbtree_lock to get into the allocation 
slowpath since there was nothing suitable in the IOVA caches. Said 
slowpath under the lock is unfortunately prone to being quite slow, 
especially as the rbtree fills up with massive numbers of relatively 
small allocations (which I'm guessing I/O with a 4KB block size would 
tend towards). If you have 256 threads all contending the same path then 
they could certainly end up waiting a while, although they shouldn't be 
*permanently* stuck...

Thanks,
Robin.

