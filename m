Return-Path: <linux-nfs+bounces-11372-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 069ECAA4B7D
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 14:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BD41B688EF
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 12:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E57235067;
	Wed, 30 Apr 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw+2KF/S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885D8F77;
	Wed, 30 Apr 2025 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017151; cv=none; b=OcaqPew+M9ids5XjekvmvmVWky/0uE4GWWJovtHnvdGOeiWmI0bEvVaC50azuAlpMYsDZdXuJdH/SFpZ499VHrR94SElZFEtjVgONgxiywAwrvLSGXku2WSEYOowiND3TZGVXLrFKvWkLJBU/T7SF8g0RranXhZDmFra6Wy/WSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017151; c=relaxed/simple;
	bh=hxWmDRJ6zacHxGYu1D9aleHyYR4RsOR4ShqLTbLmDC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9/JcE0mekKl9jeDYj/bUuSplJAPgOfPxa/nNPsQzwqQAf+wAbXUNs+8doYkS+eSorl+QBI/vouM2RchNk/DwysK9N/cvZ0T5SZqX4J1Tg41cFRD1Qgp95FiR4sBRVGbT7CEctJCoPbmkqCK78vPZ8pq+5YGXv9UqFVeIZllJ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw+2KF/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90899C4CEE9;
	Wed, 30 Apr 2025 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746017151;
	bh=hxWmDRJ6zacHxGYu1D9aleHyYR4RsOR4ShqLTbLmDC0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aw+2KF/S/ikKGuM8tkndcZ8S1dd4qiAO5alkpbtTgjINRn50ixNqLJrtvpWMhrn4J
	 vDGm5vgWSJhDM0+oUaot+6QIo0+KN6x8oW4OJbh7fI6eDg2TtHPLBR0b0B5JMXXDWn
	 7GGQwFPCDyuBi8EK2oknqN5+Kd//nK2q1SW77tCybq2Dfm94I8Y3IOURAI1TsVYAG1
	 wzGPJo/JjqRgLBVNiGmYShARHqJH2wxf+Pme9NHErA7/oHycHFvLHFpKkD2ad2MJuX
	 RfY/STAbbqUve4H/1cKtNzuIX0AJCJyWcZXW3ST2befZMSlVvB3FInQm3Rr7nwELTL
	 Pdtp80HT3ndOA==
Message-ID: <d523b381-1343-472b-b913-80b942aa9d7f@kernel.org>
Date: Wed, 30 Apr 2025 08:45:49 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] Allocate payload arrays dynamically
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250428193702.5186-1-cel@kernel.org>
 <174598987938.500591.3903811314689386843@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <174598987938.500591.3903811314689386843@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/25 1:11 AM, NeilBrown wrote:
> On Tue, 29 Apr 2025, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> In order to make RPCSVC_MAXPAYLOAD larger (or variable in size), we
>> need to do something clever with the payload arrays embedded in
>> struct svc_rqst and elsewhere.
>>
>> My preference is to keep these arrays allocated all the time because
>> allocating them on demand increases the risk of a memory allocation
>> failure during a large I/O. This is a quick-and-dirty approach that
>> might be replaced once NFSD is converted to use large folios.
>>
>> The downside of this design choice is that it pins a few pages per
>> NFSD thread (and that's the current situation already). But note
>> that because RPCSVC_MAXPAGES is 259, each array is just over a page
>> in size, making the allocation waste quite a bit of memory beyond
>> the end of the array due to power-of-2 allocator round up. This gets
>> worse as the MAXPAGES value is doubled or quadrupled.
> 
> I wonder if we should special-case those 3 extra.
> We don't need any for rq_vec and only need 2 (I think) for rq_bvec.

For rq_vec, I believe we need one extra entry in case part of the
payload is in the xdr_buf's head iovec.

For rq_bvec, we need one for the transport header, and one each for
the xdr_buf's head and tail iovecs.

But, I agree, the rationales for the size of each of these arrays are
slightly different.


> We could use the arrays only for payload and have dedicated
> page/vec/bvec for request, reply, read-padding.

I might not fully understand what you are suggesting, but it has
occurred to me that for NFSv4, both Call and Reply can be large for
one RPC transaction (though that is going to be quite infrequent). A
separate rq_pages[] array each for receive and send is possibly in
NFSD's future.


> Or maybe we could not allow read requests that result in the extra page
> due to alignment needs.  Would that be much cost?
> 
> Apart from the one issue I noted separately, I think the series looks
> good.
> 
> Reviewed-by: NeilBrown <neil@brown.name>

Thanks for having a look.


-- 
Chuck Lever

