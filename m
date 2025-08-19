Return-Path: <linux-nfs+bounces-13780-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE73B2CA55
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 19:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 883DF4E154F
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 17:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FA22FE057;
	Tue, 19 Aug 2025 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfUpQhEE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9F02FD7DF;
	Tue, 19 Aug 2025 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623762; cv=none; b=Lq273lbN3QSEeXL9DrWuqFYcGdV7aBPzkk01qeV7A4HW3uACNndg3ilJ/UleCM2nmFeva624qY9iL8o6/WlddNFbEZcbssvVn1WgtPzBltVQ4Y0yMtAIehYmBayDSV0Ua88xlrNB/UeXw2NV+Kfelno5kchBcaj+6rLoWNXeZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623762; c=relaxed/simple;
	bh=cj679SK9vTlkyrFEOPH5FGNtoofnpMAS/kpOWucfrbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyaBARL3G1ryEZl7U04fp44qkHv1D5c6RlzZGtJe1unLGbsPM5tmaLWnOraaF4pimbwZd+t5MxfBB59/kV2c1GB2ZVMjzZg+ghBFYZtwxflQm2eALECVMWOMxZwUU0t82Xnf8iJpjRiHxk3C4bJ5MNHw1HLFsFHnkBHRVlsaoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfUpQhEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94516C4CEF1;
	Tue, 19 Aug 2025 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755623761;
	bh=cj679SK9vTlkyrFEOPH5FGNtoofnpMAS/kpOWucfrbI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TfUpQhEEfdf9UTv5m+D62yLyXLdpZH3wj4TGKK5fxwOEUnGkBNd3mUl4dGJ89iiCP
	 3WROJvH/IW1092EIkIcTjgk1m8C0unwmz0zifBIpfO734KIfLCT0KXE7zvIfDrExF/
	 8aAdyUM/evw9onw5KXzbcH4ttnBXTxXsgzTxSx7cs7irA2TxaOsJW1VUpmSVS51Jmo
	 ZxujTB4rLSLsl4YyIYbZv3MfMf/zIhmm66Y4D7ajrIXydmX82RAe7ZjFNHjJYd7ahe
	 9g0PBf3IZsp+qeoi7HlYpoQmsXm0rlNokBswAx2Z5HElUKFiSgeBUQCwhmaKHjZWUC
	 yQGKHDTkgtKmw==
Message-ID: <ee20aca3-8c32-48f4-8a90-5e4cd4e05aab@kernel.org>
Date: Tue, 19 Aug 2025 13:16:00 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] svcrdma: Introduce Receive buffer arenas
To: Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
References: <20250811203539.1702-1-cel@kernel.org>
 <a1ce98e1-83b6-45c4-bde0-c4b71be67868@talpey.com>
 <1cea814e-8be3-4bf9-ae3b-5bf21eae0a3c@kernel.org>
 <383ea66a-8b0e-4b90-98c7-69a737c23f82@talpey.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <383ea66a-8b0e-4b90-98c7-69a737c23f82@talpey.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/25 12:58 PM, Tom Talpey wrote:
> On 8/19/2025 12:08 PM, Chuck Lever wrote:
>> On 8/19/25 12:03 PM, Tom Talpey wrote:
>>> On 8/11/2025 4:35 PM, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> Reduce the per-connection footprint in the host's and RNIC's memory
>>>> management TLBs by combining groups of a connection's Receive
>>>> buffers into fewer IOVAs.
>>>
>>> This is an interesting and potentially useful approach. Keeping
>>> the iova count (==1) reduces the size of work requests and greatly
>>> simplifies processing.
>>>
>>> But how large are the iova's currently? RPCRDMA_DEF_INLINE_THRESH
>>> is just 4096, which would mean typically <= 2 iova's. The max is
>>> arbitrarily but consistently 64KB, is this complexity worth it?
>>
>> The pool's shard size is RPCRDMA_MAX_INLINE_THRESH, or 64KB. That's the
>> largest inline threshold this implementation allows.
>>
>> The default inline threshold is 4KB, so one shared can hold up to
>> sixteen 4KB Receive buffers. The default credit limit is 64, plus 8
>> batch overflow, so 72 Receive buffers total per connection.
>>
>>
>>> And, allocating large contiguous buffers would seem to shift the
>>> burden to kmalloc and/or the IOMMU, so it's not free, right?
>>
>> Can you elaborate on what you mean by "burden" ?
> 
> Sure, it's that somebody has to manage the iova scatter/gather
> segments.
> 
> Using kmalloc or its moral equivalent offers a contract that the
> memory returned is physically contiguous, 1 segment. That's
> gonna scale badly.

I'm still not sure what's not going to scale. We're already using
kmalloc today, one per Receive buffer. I'm making it one kmalloc per
shard (which can contain more than a dozen Receive buffers).


> Using the IOMMU, when available, stuffs the s/g list into its
> hardware. Simple at the verb layer (again 1 segment) but uses
> the shared hardware resource to provide it.
> 
> Another approach might be to use fast-register for the receive
> buffers, instead of ib_register_mr on the privileged lmr. This
> would be a page list with first-byte-offset and length, which
> would put it the adapter's TPT instead of the PCI-facing IOMMU.
> The fmr's would registerd only once, unlike the fmr's used for
> remote transfers, so the cost would remain low. And fmr's typically
> support 16 segments minimum, so no restriction there.

I can experiment with fast registration. The goal of this work is to
reduce the per-connection hardware footprint.


> My point is that it seems unnecessary somehow in the RPCRDMA
> layer.

Well, if this effort is intriguing to others, it can certainly be moved
into the RDMA core. I already intend to convert the RPC/RDMA client
Receive code to use it too.


> But, that's just my intuition. Finding some way to measure
> any benefit (performance, setup overhead, scalbility, ...) would
> be certainly be useful.

That is a primary purpose of me posting this RFC. As stated in the patch
description, I would like some help quantifying the improvement (if
there is any).


-- 
Chuck Lever

