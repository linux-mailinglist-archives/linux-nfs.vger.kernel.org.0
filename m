Return-Path: <linux-nfs+bounces-11502-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9424CAAC735
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C26E87B1E10
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD2C281374;
	Tue,  6 May 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPep8NXC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C752D281369;
	Tue,  6 May 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539976; cv=none; b=onQpu/ZUZ3JXAZXzXvpNBbsMEYTxCqtT56c4z3YDI3Wc4sq09eAAf+YPsKxDIXmhgoC3p8IPKto7QXNGSsCDyXW6lDeIqpGvQuDrI1PDEEv1BJdGmmg9O5F3okSucJHumx8G+H7MJ23qJGPWm0IzoBkWvX1ObvQrp/1ZjNU0/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539976; c=relaxed/simple;
	bh=N+Fy0SWace4VRSzZe9xJ2XWM6pLAhrdNjIc/ELtCYEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOBjhsb0RoO2ByR+j5rrUeySA/xk+fXkv8iufcJri5Uc/t9y1gq6hXydQAkMMbIcRt20OXt6FjUCppjBEgeaBWWWzHTA0ft77ou8aLQ1R2b5T83B7CgCGCfwD662LDUt4/E1VjPHbZATXnMDyvFpmh1TOuO2tzprEFcCqf6ekcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPep8NXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647A1C4CEF0;
	Tue,  6 May 2025 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746539976;
	bh=N+Fy0SWace4VRSzZe9xJ2XWM6pLAhrdNjIc/ELtCYEQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DPep8NXC/vl9nbyf+1vVek08yQM3DZi77Yu9VgIGCZ5YQx1sOB9Dv9JArkZH44feA
	 5Z2uG46abTev7aO6qIwM3WFdBe9p2uAqcfqdFtPFRGdk26I1jKRtCOafBkJ7MDA+Jp
	 xCXkIF7LVwpzY6FR+OgCv2GTXkVrzy7l4A5y3qftdhdlS8lMgWcWHAkzJ0AkWnNbZp
	 ePDWCtEyvn8DbUVlzLQkvPQjvBSObiLcC3gtRyaH8JQtfKD+y/kxJq2bD/YiI7ZB8W
	 lblMqNIKrx7YyrkJxnKOMuotBkQRCcqlY733KkwrBJT6G7IFLSVPOskedBBToAEhsb
	 RUOwn1FmpTQSQ==
Message-ID: <bae5b474-8945-4e27-ab72-432a63b8a1e0@kernel.org>
Date: Tue, 6 May 2025 09:59:34 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] SUNRPC: Bump the maximum payload size for the
 server
To: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-15-cel@kernel.org> <aBoP249KZ5G9hU81@infradead.org>
 <390ac9ce-d32d-4534-a406-52288f79ab0c@kernel.org>
 <d3cd6ed78404a5ac354ef428c2c00912de0baa33.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <d3cd6ed78404a5ac354ef428c2c00912de0baa33.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 9:54 AM, Jeff Layton wrote:
> On Tue, 2025-05-06 at 09:52 -0400, Chuck Lever wrote:
>> On 5/6/25 9:34 AM, Christoph Hellwig wrote:
>>> On Mon, Apr 28, 2025 at 03:37:02PM -0400, cel@kernel.org wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> Increase the maximum server-side RPC payload to 4MB. The default
>>>> remains at 1MB.
>>>>
>>>> To adjust the operational maximum, shut down the NFS server. Then
>>>> echo a new value into:
>>>>
>>>>   /proc/fs/nfsd/max_block_size
>>>>
>>>> And restart the NFS server.
>>>
>>> Are you going to wire this up to a config file in nfs-utils that
>>> gets set before the daemon starts?
>>
>> That's up to SteveD -- it might be added to /etc/nfs.conf.
>>
>>
> 
> Can we also add this to the netlink interface for nfsd and nfsdctl?

Sure, that's possible, however:

The purpose of this series is only to enable experimentation (aside from
the other nice clean-ups).

Once that is complete, what are the use cases for admins to increase or
decrease this value? (Not a rhetorical question: I'd like to invite some
discussion about that).

As always, these interfaces need documentation and long-term support. I
would like to get some technical rationale on the table before we
commit to the support costs.


>>> Because otherwise this is a pretty horrible user interface.
>>
>> This is an API that has existed forever.
>>
>> I don't even like that this maximum can be tuned. After a period of
>> experimentation, I was going to set the default to a higher value and
>> be done with it, because I can't think of a reason why it needs to be
>> shifted up or down after that.
>>
> 


-- 
Chuck Lever

