Return-Path: <linux-nfs+bounces-11514-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339CFAAC7AF
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835F317DDDB
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5CF280CD5;
	Tue,  6 May 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjMKJ6Q4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B1927FD75;
	Tue,  6 May 2025 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541149; cv=none; b=qhDc/u+kn9pvys3UZl3PK8XexZsl/nRoLrQ89g3AB/HqygDnGQnm0xxFcBhZ1YVSCNp9CcndbiHuGtfAj2aVpn9yQ7WjCz6EgBHjBANnIUm7CDJeI8FS03dNIwpFCE0aaYSs0MdTGTZ8p3pxyor8fXY6UcjMOh4vDC94Sj9DL+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541149; c=relaxed/simple;
	bh=E83/hew1cOPUFGnu6c2yVhS0Ry6f9izbjoeJaooc9Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izZ23c5nPXziaz2ebMztEARjMbqp2BBEvy7jhded8hqXXxUufFSu+RbwXwvZ/g58Yxo/9oTehS8/JDx0zFvdEC3dcUXoHiBeMS6NtXf8t01poS7hKm1boIWcNxv55HV25ADjkCnFImYyDLKhXxYdNhrAkGDGLAQ7W89zA9t4x9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjMKJ6Q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7309DC4CEE4;
	Tue,  6 May 2025 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746541148;
	bh=E83/hew1cOPUFGnu6c2yVhS0Ry6f9izbjoeJaooc9Kw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gjMKJ6Q4e2ZKLC7ZY+0TRvjbzvBcxGKcfuIm0WFPUhPxQiI8mPT+2i3YU9ILcVSLt
	 udxTu4V3TlwHXwh9blDumdbeO3ceLfVJD3dv7qTAekZkXD9Pn6tI4/wK+wIMSUVaQa
	 J+gRiICmJeuwjyunDmBz3dHcZm3dNdkiKiBhnwlqPDjghq5vnD2/YowxQ90+hqA1cA
	 IjUT//DynbOglveDxW0dATqEQmwU6mvSQ0mm1Gk39SFkbp4fQIXk5z4w/PKuSQJMhI
	 J/ltVlUvuQeaNax5bFzaXNj7HD8jAMn5jwIS1lmGnhG7lbyq9WEbBd6C5xY++UbmMW
	 iZzHK5u6RRIjQ==
Message-ID: <d7115cd7-c34c-4212-b244-e5247ac68fcc@kernel.org>
Date: Tue, 6 May 2025 10:19:06 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] svcrdma: Reduce the number of rdma_rw contexts
 per-QP
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Leon Romanovsky <leon@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-2-cel@kernel.org> <aBoJ64qDSp7U3twh@infradead.org>
 <20250506131722.GG2260621@ziepe.ca> <aBoRSeERzax5lTvH@infradead.org>
 <20250506135536.GH2260621@ziepe.ca>
 <be740f28-8d68-400c-85bc-81cc4e48ccc6@kernel.org>
 <20250506141705.GI2260621@ziepe.ca>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20250506141705.GI2260621@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 10:17 AM, Jason Gunthorpe wrote:
> On Tue, May 06, 2025 at 10:13:00AM -0400, Chuck Lever wrote:
>> On 5/6/25 9:55 AM, Jason Gunthorpe wrote:
>>> On Tue, May 06, 2025 at 06:40:25AM -0700, Christoph Hellwig wrote:
>>>> On Tue, May 06, 2025 at 10:17:22AM -0300, Jason Gunthorpe wrote:
>>>>> On Tue, May 06, 2025 at 06:08:59AM -0700, Christoph Hellwig wrote:
>>>>>> On Mon, Apr 28, 2025 at 03:36:49PM -0400, cel@kernel.org wrote:
>>>>>>> qp_attr.cap.max_rdma_ctxs. The QP's actual Send Queue length is on
>>>>>>> the order of the sum of qp_attr.cap.max_send_wr and a factor times
>>>>>>> qp_attr.cap.max_rdma_ctxs. The factor can be up to three, depending
>>>>>>> on whether MR operations are required before RDMA Reads.
>>>>>>>
>>>>>>> This limit is not visible to RDMA consumers via dev->attrs. When the
>>>>>>> limit is surpassed, QP creation fails with -ENOMEM. For example:
>>>>>>
>>>>>> Can we find a way to expose this limit from the HCA drivers and the
>>>>>> RDMA core?
>>>>>
>>>>> Shouldn't it be max_qp_wr?
>>>>
>>>> Does that allow for arbitrary combination of different WRs?  
>>>
>>> I think it is supposed to be the maximum QP WR depth you can create..
>>>
>>> A QP shouldn't behave differently depending on the WR operation, each
>>> one takes one WR entry.
>>>
>>> Chuck do you know differently?
>>
>> qp_attr.cap.max_rdma_ctxs reserves a number of SQEs over and above
>> qp_attr.cap.max_send_wr. The sum of those two cannot exceed max_qp_wr,
>> of course.
> 
> Yes
> 
>> But there is a multiplier, due to whether the device wants a
>> registration and invalidation WR in addition to each RDMA Read WR.
> 
> Yes, but both of these are in the rdma rw layer
>  
>> Further, in drivers/infiniband/hw/mlx5/qp.c :: calc_sq_size
>>
>>         wq_size = roundup_pow_of_two(attr->cap.max_send_wr * wqe_size);
>>         qp->sq.wqe_cnt = wq_size / MLX5_SEND_WQE_BB;
>>         if (qp->sq.wqe_cnt > (1 << MLX5_CAP_GEN(dev->mdev,
>> log_max_qp_sz))) {
> 
> And this log_max_qp_sz should be used to derive attr.max_qp_wr
> 
>> In this patch I'm trying to include the reg/inv multiplier in the
>> calculation, but that doesn't seem to be enough to make "accept"
>> reliable, IMO due to this extra calculation in calc_sq_size().
> 
> Did ib_create_qp get called with more than max_qp_wr ?

The request was for, like, 9300 SQEs. max_qp_wr is 32K on my systems.

> Or is max_qp_wr not working?

-- 
Chuck Lever

