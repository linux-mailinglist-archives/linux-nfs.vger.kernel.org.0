Return-Path: <linux-nfs+bounces-11531-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B70FAACB04
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 18:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29794E496C
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E828E283FD9;
	Tue,  6 May 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3jmDrOy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E3283FC1;
	Tue,  6 May 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746549099; cv=none; b=CnYh1hJ8LdDKG5zADQ0bkEnfUECoQGh3ZBa3O7uTnedxrEv6PnUch+fnBwpGR96JxVz9qbc0ok9vvjmDlyxkmUlTjKIONELZJiy8C/jDcY0ou4ZCTFQVjDUhPvRM1hMDbh0WZtkdDA2+FWp5JKbSNdnfdImjZjRwnK9KMdUJ9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746549099; c=relaxed/simple;
	bh=1dGYzvBw9oRCTRES9061WLFdpXTjRbqLsnyPGArAtxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIQ/awISbD0TMRROtl5vL2jRYLCxj3SOf6xVNqUo6IEeYkW0ppGOemDP+ZmNb3GafqklcV+PrwjDJmlreL4jjHGDPCl+nM53AxuOLg1aVmjadtdrEi2ogZYbKHJtQkGprtNMOqyzSXAMutwCxAxEBK0BAy0smpY0PiYwatnNx3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3jmDrOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA7EC4CEE4;
	Tue,  6 May 2025 16:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746549099;
	bh=1dGYzvBw9oRCTRES9061WLFdpXTjRbqLsnyPGArAtxc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S3jmDrOy32rz5li5E03f8VvYwwj6jKFALlK2ZfUOd4paFOjYuhPWNClZPlodVwovH
	 vtCO3HayVXCgcXTYCdAjeJkTKmrsVDRjhB1lEI0WZYqudrfjucJ+Mmu/Ud/87SohCE
	 Qk/GToGt4PTa1s5QCxxUm4HhPyeRj80CevB8C7pTOSEHxGBpmtcu3isiP3K8e9tMU1
	 3eiJYe4f2wIusnlhw7OoUEQbowWyomJ+qVxsjNDMti5iWak4VxlwBQl+oeURiT5KsM
	 rPcfmAxZj19nRoDRetDo7RbYNLmL0g9WDVaIA5qc+6wDI0HAkR8MMLq6thgGQtt/vR
	 g2WyA+l1Q1qXA==
Message-ID: <1ad45c3b-8882-4583-9cb2-afbc232e08d7@kernel.org>
Date: Tue, 6 May 2025 12:31:37 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/14] sunrpc: Replace the rq_vec array with
 dynamically-allocated memory
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-6-cel@kernel.org> <aBoOr0wZ5rqE6Erl@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aBoOr0wZ5rqE6Erl@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 9:29 AM, Christoph Hellwig wrote:
> On Mon, Apr 28, 2025 at 03:36:53PM -0400, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> As a step towards making NFSD's maximum rsize and wsize variable at
>> run-time, replace the fixed-size rq_vec[] array in struct svc_rqst
>> with a chunk of dynamically-allocated memory.
>>
>> The rq_vec array is sized assuming request processing will need at
>> most one kvec per page in a maximum-sized RPC message.
>>
>> On a system with 8-byte pointers and 4KB pages, pahole reports that
>> the rq_vec[] array is 4144 bytes. This patch replaces that array
>> with a single 8-byte pointer field.
> 
> The right thing to do here is to kill this array.  There is no
> reason to use kvecs in the VFS read/write APIs these days, we can
> use bio_vecs just fine, for which we have another allocation.

Fair enough. That's a little more churn than I wanted to do in this
patch series, but maybe it's easier than I expect.


> And given that both are only used by the server and never the client
> maybe they should both only be conditionally allocated?

Not sure I follow you here. The client certainly does make extensive use
of xdr_buf::bvec.

-- 
Chuck Lever

