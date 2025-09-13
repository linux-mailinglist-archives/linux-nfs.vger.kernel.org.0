Return-Path: <linux-nfs+bounces-14406-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 931BDB56223
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Sep 2025 18:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A878E1B28055
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Sep 2025 16:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8EE1B3923;
	Sat, 13 Sep 2025 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFGWeWji"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F628FD
	for <linux-nfs@vger.kernel.org>; Sat, 13 Sep 2025 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757779278; cv=none; b=XwyTjjvltkH3I7ZQahatmSej2RO9A5HcyELegxzvWdfaTHe15nX28kDJUIHtXnDCetBfl+q39gPkTjMct3m32KsWukbZkXpnXC3RSil3YyXn9iOVnU3P0cEsFJJS7ZUyMS3oR9wQHM2ltFBXDa94Q03dtuNcps+mIU2zRbSPzjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757779278; c=relaxed/simple;
	bh=tQu0/KsuHiNYcZuNdiWv0phtdsaqEwPJFq/IJj75mnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tbmslbrje+P2k2udQ7q4/agV8d9KhsqWex6o8j6VKgCLA32ZCJcHo2y58e7YMP6H7vuhlNFA6a5ypUH3KJKfGumZtKUpDyNAJkcHEfPv/YanTnNX7Wzf52X6mi8Vqp+SBxMQ0EgoVnNdgqYOG4EROk2/bl2bnbdmq0ScjHyF1n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFGWeWji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F066AC4CEEB;
	Sat, 13 Sep 2025 16:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757779276;
	bh=tQu0/KsuHiNYcZuNdiWv0phtdsaqEwPJFq/IJj75mnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OFGWeWjidXeblwLVqwUymvpioRWe3n9yNjFPyN51IKlj+LyRQho5kKMB7ejRDZku0
	 YpoC7vq27dY9EH0QfhniACv3uPoMmGScsKsTlFP/SUrgXMXCoz74bJOpghjfzYlfjl
	 OCnnCS3W2e3GoJMxDl1t19Akz8/F9QtrDduTPYu9hTd7fyW7FxAM55/gKf8liyorsU
	 X3lI9IaexveQ/80cmyAfAhj7ozEUiqGSHXfDEyeQD2pq4WHgz83RzR2AQXu+eMylKi
	 +8Q5mUKEkapybH3sJJD9QFBh7sKso0o5k65q1O7xdyoYbw2P9TRpT3QjPAvoiv1P7n
	 izTczTsOymJ8Q==
Message-ID: <49025423-30cc-4ac7-a37c-2767321e5982@kernel.org>
Date: Sat, 13 Sep 2025 12:01:14 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFSD: Remove WARN_ON_ONCE in nfsd_iter_read()
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250911201858.1630-1-cel@kernel.org>
 <175774182203.1696783.2451676793107977604@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <175774182203.1696783.2451676793107977604@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/25 1:37 AM, NeilBrown wrote:
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 714777c221ed..e2f0fe3f82c0 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1120,13 +1120,13 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
>>  			      len, base);
>>  		total -= len;
>> -		++v;
>>  		base = 0;
>> +		if (++v >= rqstp->rq_maxpages)
>> +			break;
> I would have changed the head of the while loop to be
> 
>   while (total > 0 && rqstp->rq_next_page < ....)
> 
> and then realised that I don't know what to put there.
> I don't think that counting up to rq_maxpages is safe when there could
> be two READ ops in an NFSv4 Compound.
> 
> And if we are cleaning up this function I woul put the increments of v
> and rq_next_page next to each other..
> </bikeshed>
> 
> The patch is an improvement.  I wonder if it is enough.

I'm planning a second patch that adds protection against overrunning
the rq_pages array. Is there anything else you feel is needed?


-- 
Chuck Lever

