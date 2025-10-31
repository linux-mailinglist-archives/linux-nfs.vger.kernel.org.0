Return-Path: <linux-nfs+bounces-15845-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1577BC25406
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 14:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EFEC4F79C6
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA35E2900A8;
	Fri, 31 Oct 2025 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2Uam0kS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62531B142D
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916889; cv=none; b=BHWxakOIkM7yOi0zpWuEGtNz5zGwAK9uTCx/EIWuteu+tDkl4VBt7a2IdL+9kKdpjFY3DCu7lR94SZ0pm9SKtI0umghvdxmEHV/NRNu1CT3aBNVVbk5ocpUxawzX+srNa4whU1FxcOz+io+Vc9YBcxgakKLQ2rEMblrW+pHIjrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916889; c=relaxed/simple;
	bh=4oYSYv2ulUIDrlBN88QVr0qwJd15Og0+O6CV+bq4Cjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEyX9DhWmM3rQ2o8nVcXI/7CZEtkDB0/kZ32P4e0DVb80l7OvHDxdQ0DBwE+5ZkcePpqf2zeY/6JzFPrf1S1qwTXwot5tIHnxwdumnjfIDiUYyx3H/TR1EAlYh7Qe9JP14WzrOXBcovh1t0cA5YZf3Z4cnyA8EqXJP5MvH/eRts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2Uam0kS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5875CC4CEE7;
	Fri, 31 Oct 2025 13:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761916889;
	bh=4oYSYv2ulUIDrlBN88QVr0qwJd15Og0+O6CV+bq4Cjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M2Uam0kS2Xj8r9sTr9NHc8syWzMG/hy5hXmwZAA5vvpU+g5ov3FhiSjgSnT8YNatT
	 YXnG05FfyWIoUYj71CklxMZ74aNZn02OriKlTMXSq4oQ7uLiMJkCsPv9j4ffuwxd6K
	 SBaKIIrZYq/5MSDcJhuBKiNCLUitH0XrPWHQTT2Onm701xFOMAHyhg/A7jnCUhBHjp
	 V6oWcEM1UmCV+SKKebAxdUGXPh9CVSxMXzguhAyq/4TowKnPmxkM0IBmv8XWqAok/X
	 OZ2W1UChZQhjQq/huLWfIOqzzv3iBu0MVTZuqL0AL6yI6zo2GC9ETsBxmtAJioL2yT
	 1Gal8vkgCLJUQ==
Message-ID: <88535f7a-abc7-4649-a2b4-ba520e9aae0b@kernel.org>
Date: Fri, 31 Oct 2025 09:21:27 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/12] NFSD: Handle both offset and memory alignment
 for direct I/O
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>
References: <20251027154630.1774-1-cel@kernel.org>
 <20251027154630.1774-10-cel@kernel.org> <aQS3U0bfw6X3J7J2@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQS3U0bfw6X3J7J2@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/25 9:19 AM, Christoph Hellwig wrote:
> On Mon, Oct 27, 2025 at 11:46:27AM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Currently, nfsd_is_write_dio_possible() only considers file offset
>> alignment (nf_dio_offset_align) when splitting an NFS WRITE request
>> into segments. This leaves accounting for memory buffer alignment
>> (nf_dio_mem_align) until nfsd_setup_write_dio_iters(). If this
>> second check fails, the code falls back to cached I/O entirely,
>> wasting the opportunity to use direct I/O for the bulk of the
>> request.
>>
>> Enhance the logic to find a beginning segment size that satisfies
>> both alignment constraints simultaneously. The search algorithm
>> starts with the file offset alignment requirement and steps through
>> multiples of offset_align, checking memory alignment at each step.
>> The search is bounded by lcm(offset_align, mem_align) to ensure that
>> it always terminates.
> 
> How likely is that going to happen?  After the first bvec the
> alignment constrains won't change, so how are we going to succeed
> then?
> 

I was hoping that this algorithm would improve the likelihood of
finding a middle segment alignment for NFS WRITE on TCP. I'm not
entirely sure it has been effective.

Given the complexity, I'm wondering if I want to keep this one.


-- 
Chuck Lever

