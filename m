Return-Path: <linux-nfs+bounces-16049-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE35C361F6
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 15:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA23C3B5369
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9331C32E152;
	Wed,  5 Nov 2025 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk1c7nC6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D96832E149
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353515; cv=none; b=Hyinp3pf2zp8QiO/tbQSVc7AV850Me7KX6sLWxJWTFCL7C3kGKnQmnxW+P+clzWg2XCU075k5A0RCJMKZfxvEyGh0XZV/8GyE7Yz/msmlcQG+Hb3iVUJbMeWu5NVp+HoXSvYC5B7XeZg+TeU5rW7lQ9iygiD7aB5Hwws5SZectA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353515; c=relaxed/simple;
	bh=Y/0yUYPPT14/aZcPmAB5M/Rjiz6pf19cHbrvX8yFhf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idJMeKMu+OIYD7NdQycNaM3UKEKcpPxmmB+03pWpcNrn+CZjk0gAElw2kf6BOHJ9+Q7FREe+5Cl2zvfC5T1DlTx659gLJGPVzqBMQedjUOCDBWW2BaZww0q3cxTRwDKltcT6L4s5xm7OOOk858ZteftLT5x+tPvZDeVUdYI6FJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk1c7nC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78951C4CEF5;
	Wed,  5 Nov 2025 14:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762353515;
	bh=Y/0yUYPPT14/aZcPmAB5M/Rjiz6pf19cHbrvX8yFhf4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gk1c7nC6hQQH0GnoqZRrl5ONTjAuhhVbEG2Cmr1Ns5MBX4ZV+4+bbkHJ0ebxrPXhz
	 KR3TPW1xakn6Jy4VVGP+wmGVjGNc3a2Yn2FN0CuOPL5NzUivDDUg2M1PfqyuxLdKYR
	 nnFwMc1wVkBcSzMJll5YiM+ExY6eELHFOQHRfZhTEyD0kof02ggSbQtKIBFaZoo6lO
	 5TIzt807UEH75taIeFxfHdOXcDSYnwuVWcqJNEdtO8LfiO5ZnXAR4utJPaydN0jgkI
	 ao8DzgDVRf1Otav2zQs1fEJ7Sf3dBsLoqQMGkTZ7y9LWAQ4MrMl+P0+0cKIK9NyNHx
	 GXImva4/5ve8Q==
Message-ID: <a06fd92d-0c37-4b18-8ec2-1392d587264a@kernel.org>
Date: Wed, 5 Nov 2025 09:38:33 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/12] NFSD: Remove alignment size checking
To: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-6-cel@kernel.org>
 <176220902556.1793333.10293656800242618512@noble.neil.brown.name>
 <aQnpB4mYMwW9IGM0@infradead.org>
 <35ddc8b0-2727-453e-b970-07b493e21f93@kernel.org>
 <aQtIqn28Bo2ElPqG@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQtIqn28Bo2ElPqG@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/5/25 7:52 AM, Christoph Hellwig wrote:
> On Tue, Nov 04, 2025 at 09:14:09AM -0500, Chuck Lever wrote:
>>>> It might be good to capture here *why* the check is removed.
>>>> Is it because alignments never exceed PAGE_SIZE, or because the code is
>>>> quite capable of handling larger alignments
>>>> (I haven't been following the conversation closely..)
>>>
>>> I'm still trying to understand why it was added in the first place :)
>>
>> I'm trying to understand what action you'd like me to take. Should I
>> drop this patch?
> 
> With "it" I meant the check.  І think Mike explain this was due to a
> PAGE_SIZE bound buffer originally, and in that context it makes sense.
> Without the explanation I don't understand the rationale for adding the
> check in the first place.

Agreed, Mike's original patch has no explanatory comment, and there
needs to be one. Mike, can you suggest a one or two sentence comment
and I will replace this patch with one that adds the comment.


>>> But I'm also completely lost in the maze of fixup patches.
>> Several people have asked me to collapse the fix-ups into a single
>> patch. We would lose some history and attributions doing that. Does
>> anyone have other thoughts?
> 
> The action I'd see is to collapse the series into reviewable chunks.
> I.e., fold the addition of the direct I/O writes into a single patch
> that has all the policy decisions and documents them, leaving only
> clearly separate prep patches separate.
Meaning: combine the patches from 3/12 to 12/12 into a single patch.


-- 
Chuck Lever

