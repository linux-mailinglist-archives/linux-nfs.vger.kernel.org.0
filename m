Return-Path: <linux-nfs+bounces-14577-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16977B866EF
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 20:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F7858876A
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 18:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FDE2D3EF5;
	Thu, 18 Sep 2025 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3U2DZIv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CB12D3ED0
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758220925; cv=none; b=Pj/y0oW2/xKxq14nxPdtb57g6RFqgenCq3GDP3E0lAOwwRpOA3gjIQ9S8Ag2FHopibbXDw5g0eBMrv3sKOmVpNUaYLeafRqcXYGhK9OufaEFSu/KIDxqAtjII4X4n5aDM2IPJ2pUH+/TkKUnBRwsGvqprvDZPZQticy8gI10yEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758220925; c=relaxed/simple;
	bh=7oyLMBEoOq8MvKYThQ+e+qaV2Yj1wtMBS/HDKasZbrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8vtlpTu6cTjWT330sDChqBc3HyASxr233p7qbRSgmB0HtK/0FCt+bL5IW4rNKL2wYJ5gh7akUnMqjwyF75WQUQhbTohabUlzGpPQmYAunwoBJDMdutWC7gC1ckzYSLy1E3xE6mbo6VDdN5uYQjnXu/FKTD670O/DfP/9gP9hHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3U2DZIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D53C4CEF0;
	Thu, 18 Sep 2025 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758220925;
	bh=7oyLMBEoOq8MvKYThQ+e+qaV2Yj1wtMBS/HDKasZbrc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n3U2DZIvhrN2YnoVt3Zo30rmYH9sc2BliYsHCgD4pKRUlYTU5Qa5Bh/Y0hVJAVZBt
	 BBrmN8v8Q+W6yTbwe3sSS3sn9Ccovl9IqQ8/d1ccbLCmmjP2dGzT7l8+lslj27li7+
	 x/K/fPe3dN+Ma2qfrVz9cAMEvCY8RKZHisXUpPs0V+zbX6/NuyrMNKT1uBPktjwwAQ
	 ybLuYkf4/zKdeZDliyrHbIMW7rLJ0AhyBGdtMvqYQVORHEvwh30dNWuY3eubpjE0ss
	 M5Edmzj8rDY3+mARbkiR+TPi2O9Yli0/D1OV1NHOdZ96tHRNnO9rUQL77C2k4iG8Ut
	 oQKOw7/cwqBTQ==
Message-ID: <0ab1138f-9085-444a-9e8a-822c29e404bd@kernel.org>
Date: Thu, 18 Sep 2025 11:42:03 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] NFSD: Implement NFSD_IO_DIRECT for NFS READ
To: NeilBrown <neil@brown.name>
Cc: jlayton@kernel.org, okorniev@redhat.com, dai.ngo@oracle.com,
 tom@talpey.com, linux-nfs@vger.kernel.org
References: <175811882632.19474.8126763744508709520.stgit@91.116.238.104.host.secureserver.net>
 <175811952039.19474.5813875056701985362.stgit@91.116.238.104.host.secureserver.net>
 <175815178827.1696783.10535533600809037950@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <175815178827.1696783.10535533600809037950@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/25 4:29 PM, NeilBrown wrote:
>> +/*
>> + * The byte range of the client's READ request is expanded on both
>> + * ends until it meets the underlying file system's direct I/O
>> + * alignment requirements. After the internal read is complete, the
>> + * byte range of the NFS READ payload is reduced to the byte range
>> + * that was originally requested.
>> + *
>> + * Note that a direct read can be done only when the xdr_buf
>> + * containing the NFS READ reply does not already have contents in
>> + * its .pages array. This is due to potentially restrictive
>> + * alignment requirements on the read buffer. When .page_len and
>> + * @base are zero, the .pages array is guaranteed to be page-
>> + * aligned.
> This para is confusing.
> It starts talking about the xdr_buf not having any contents.  Then it
> transitions to a guarantee of page alignment.
> 
> If the start of the read requests isn't sufficiently aligned then a gap
> will be created in the xdr_buf and that can only be handled at the start
> (using page_base).
> 
> So as you say we need page_len to be zero.  But nowhere in the code is
> this condition tested.

Despite what the comment claims, I had thought that things would work if
the payload started at a page boundary in xdr_buf.pages. But I can see
that page_offset applies only to the first entry in xdr_buf.pages.

So xdr_buf.page_len does need to be zero. That check can be added in
nfsd_iter_read().

I prefer this approach over more elaborate checking against the
dio_mem_alignment parameter because for the overwhelmingly common cases
of both NFSv3 READ and NFSv4 COMPOUND with one READ operation, page_len
will be zero. The extra complication is hard to unit-test and will
almost never be used.


> The closest is "!base" before the call to nfsd_direct_read() but when
> called from nfsd4_encode_readv()
> 
>    base = xdr->buf->page_len & ~PAGE_MASK;
> 
> so ->page_len could be non-zero despite base being zero.


-- 
Chuck Lever

