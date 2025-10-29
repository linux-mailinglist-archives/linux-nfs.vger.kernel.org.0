Return-Path: <linux-nfs+bounces-15742-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E2DC1860A
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 07:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF0564E246D
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 06:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373DE2E8894;
	Wed, 29 Oct 2025 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vbuEe17m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96598189F3B
	for <linux-nfs@vger.kernel.org>; Wed, 29 Oct 2025 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761717959; cv=none; b=i+zHu7/ffAvu/oaOpYXRxumAQZ7SLn901dRS7NS0hPuNDU7Y/XX33eefOjW4+a7TOUnZWC+dKq9ptSN5zrK8J016edjZIfJH0KKry8Otl90LiphL84qitKrGlDAdRXcRjVQhzNeykyowuSLafWDrHe2Ug77BporwI6dNxTy2mHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761717959; c=relaxed/simple;
	bh=978piq5zOisxMplS2bYaHCSVpUMZJ8oaqG67moSy1Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Ku77f73REHXY9Eu3GAXCUqisj7aiFEeAisG+nyW90Y3PX/JoYBVeHmx6rr1CDX3F7FilPYeTHvqUY0cBzoO/h2noIchQpoG76xKx3CWwyySoDoWfPIxVOL3mxgpPQmVeyKSc/2j6jS5kafVomBHRsI9EM8QppisMxCOZ2IkgxwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vbuEe17m; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251029060548epoutp04cd017dc67d88338dd0b9e6e84a2e5665~y4SPqlo_H3246132461epoutp04O
	for <linux-nfs@vger.kernel.org>; Wed, 29 Oct 2025 06:05:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251029060548epoutp04cd017dc67d88338dd0b9e6e84a2e5665~y4SPqlo_H3246132461epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761717948;
	bh=bBJQp7PbGMd1XdhUFl5A/6fLfmccB/IWy8yXpsj4CGc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=vbuEe17mTF2terd1TQ+gi3mkaNQ+gSv01pyxt704vlOpbeMh20OJKRtvhq38wKJpB
	 EhIkFmb17+oJbYcYDLRELStbMI/9A8fc5xYMpoyix3uXeCtTFBV9Z8hbDh4jiRgzsx
	 fbXRyG0udW3HlL/1jfZBTSVcOwcrY1cBEG0kndv0=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251029060547epcas5p3b81b402ebdb14361658a0a9d1625f9a1~y4SPBxYRj0475104751epcas5p3j;
	Wed, 29 Oct 2025 06:05:47 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.88]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cxGvG5lFcz3hhT3; Wed, 29 Oct
	2025 06:05:46 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20251029060545epcas5p491529ef7b75758f4d8bc82f4da1b9976~y4SM_VznG0334003340epcas5p4Y;
	Wed, 29 Oct 2025 06:05:45 +0000 (GMT)
Received: from [107.111.86.57] (unknown [107.111.86.57]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251029060524epsmtip1c2db16f0f541ef4f1bd12a548aa4a54d~y4R5nnv-B1497914979epsmtip18;
	Wed, 29 Oct 2025 06:05:24 +0000 (GMT)
Message-ID: <e51e4fb9-01f7-4273-a363-fc1c2c61954b@samsung.com>
Date: Wed, 29 Oct 2025 11:35:21 +0530
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, amir73il@gmail.com,
	axboe@kernel.dk, ritesh.list@gmail.com, djwong@kernel.org,
	dave@stgolabs.net, wangyufei@vivo.com,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, anuj20.g@samsung.com, vishak.g@samsung.com,
	joshi.k@samsung.com
From: Kundan Kumar <kundan.kumar@samsung.com>
In-Reply-To: <20251022043930.GC2371@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251029060545epcas5p491529ef7b75758f4d8bc82f4da1b9976
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>
	<20251014120845.2361-1-kundan.kumar@samsung.com>
	<aPa7xozr7YbZX0W4@dread.disaster.area> <20251022043930.GC2371@lst.de>

On 10/22/2025 10:09 AM, Christoph Hellwig wrote:
> On Tue, Oct 21, 2025 at 09:46:30AM +1100, Dave Chinner wrote:
>> Not necessarily. The allocator can (and will) select different AGs
>> for an inode as the file grows and the AGs run low on space. Once
>> they select a different AG for an inode, they don't tend to return
>> to the original AG because allocation targets are based on
>> contiguous allocation w.r.t. existing adjacent extents, not the AG
>> the inode is located in.
> 
> Also, as pointed out in the last discussion of this for the RT
> subvolume there is zero relation between the AG the inode is in
> and the data placement.
> 
> 
I evaluated the effect of parallel writeback on realtime inodes and
observed no improvement in IOPS. We can limit writes for realtime
inodes to utilize a single default (0) writeback context. Do you
see it differently?

