Return-Path: <linux-nfs+bounces-11511-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A09AAC78D
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F9D98084E
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12F42820A7;
	Tue,  6 May 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1zdbJII"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C728151D;
	Tue,  6 May 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540782; cv=none; b=rnp4+TMxGcauaW5OzpFB4wjNDUuxPsMycWRrSGsK25hFI7R4VfSm1VhrI7Ix3IEv1vYaV9+e1d1u92KOzTEeZuM6lhpUJJ0+QselsGwh5RUuRyCHADX9d4eAlrH/MC8Ko6RDQggkMxYFj4MlB2JLMvxBIiaqVT9ZupyAPfK4aE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540782; c=relaxed/simple;
	bh=sHB5xB6ZlgMWavAZfAu7pxqL26cOwNdXZepJmr3qCw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjSbVGkrvcmhlQqgKl+P5c3Zi2uY3UmF8d9X9/w9GDKOHl6tZAxzevyjjBoL/LgjbbggH+3xSrKxNdGPLvk1SX2Q+qYYbh/y1yRelteogZTQEadLbQqgRlYFZuZwUK2MRvp80XF1DgNUrSccZqplYiQlZm7XnGyz5mHFRtSwdsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1zdbJII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C740C4CEE4;
	Tue,  6 May 2025 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746540782;
	bh=sHB5xB6ZlgMWavAZfAu7pxqL26cOwNdXZepJmr3qCw4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e1zdbJIIwYe4gSduQWtnBgAfpdwBH4dmlQZfxcLPNhPkdVmbLnuldAOEsNtMtT+X5
	 04976iIYzOGipfuhrdEUZWXAKw4QFfSmgOMiVtScGuFhkHtuMOUgww6p4fQ131BsqR
	 HWanQwJ7xc+BX8wbxTm32xRg/pR8pFsgE3e+HcVK66kMYayshKN6/haolDaPVzUD3Z
	 MxrG/n8kFrV7RaONbnZ1MwgMUFC/BqB2ocYEsxWTb4CwkrvqqxZdT4MzUmU2+jsloq
	 xDUSX+z/oBrlDi67mtyZOjVlVuWJkoljkLQ2jJAELXX0+QVwhYiF3RXedzwOHlFCD5
	 80Yvs+at5//4A==
Message-ID: <be740f28-8d68-400c-85bc-81cc4e48ccc6@kernel.org>
Date: Tue, 6 May 2025 10:13:00 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] svcrdma: Reduce the number of rdma_rw contexts
 per-QP
To: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Leon Romanovsky <leon@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-2-cel@kernel.org> <aBoJ64qDSp7U3twh@infradead.org>
 <20250506131722.GG2260621@ziepe.ca> <aBoRSeERzax5lTvH@infradead.org>
 <20250506135536.GH2260621@ziepe.ca>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20250506135536.GH2260621@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 9:55 AM, Jason Gunthorpe wrote:
> On Tue, May 06, 2025 at 06:40:25AM -0700, Christoph Hellwig wrote:
>> On Tue, May 06, 2025 at 10:17:22AM -0300, Jason Gunthorpe wrote:
>>> On Tue, May 06, 2025 at 06:08:59AM -0700, Christoph Hellwig wrote:
>>>> On Mon, Apr 28, 2025 at 03:36:49PM -0400, cel@kernel.org wrote:
>>>>> qp_attr.cap.max_rdma_ctxs. The QP's actual Send Queue length is on
>>>>> the order of the sum of qp_attr.cap.max_send_wr and a factor times
>>>>> qp_attr.cap.max_rdma_ctxs. The factor can be up to three, depending
>>>>> on whether MR operations are required before RDMA Reads.
>>>>>
>>>>> This limit is not visible to RDMA consumers via dev->attrs. When the
>>>>> limit is surpassed, QP creation fails with -ENOMEM. For example:
>>>>
>>>> Can we find a way to expose this limit from the HCA drivers and the
>>>> RDMA core?
>>>
>>> Shouldn't it be max_qp_wr?
>>
>> Does that allow for arbitrary combination of different WRs?  
> 
> I think it is supposed to be the maximum QP WR depth you can create..
> 
> A QP shouldn't behave differently depending on the WR operation, each
> one takes one WR entry.
> 
> Chuck do you know differently?

qp_attr.cap.max_rdma_ctxs reserves a number of SQEs over and above
qp_attr.cap.max_send_wr. The sum of those two cannot exceed max_qp_wr,
of course.

But there is a multiplier, due to whether the device wants a
registration and invalidation WR in addition to each RDMA Read WR.

Further, in drivers/infiniband/hw/mlx5/qp.c :: calc_sq_size

        wq_size = roundup_pow_of_two(attr->cap.max_send_wr * wqe_size);
        qp->sq.wqe_cnt = wq_size / MLX5_SEND_WQE_BB;
        if (qp->sq.wqe_cnt > (1 << MLX5_CAP_GEN(dev->mdev,
log_max_qp_sz))) {
                mlx5_ib_dbg(dev, "send queue size (%d * %d / %d -> %d)
exceeds limits(%d)\n",
                            attr->cap.max_send_wr, wqe_size,
MLX5_SEND_WQE_BB
                            qp->sq.wqe_cnt,

                            1 << MLX5_CAP_GEN(dev->mdev, log_max_qp_sz));
                return -ENOMEM;
        }

So when svcrdma requests a large number of ctxts on top of a Send
Queue size of 135, svc_rdma_accept() fails and the debug message above
pops out.

In this patch I'm trying to include the reg/inv multiplier in the
calculation, but that doesn't seem to be enough to make "accept"
reliable, IMO due to this extra calculation in calc_sq_size().

-- 
Chuck Lever

