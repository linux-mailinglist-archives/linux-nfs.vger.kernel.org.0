Return-Path: <linux-nfs+bounces-14641-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E5BB9A29E
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 16:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B001B26589
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFAE305946;
	Wed, 24 Sep 2025 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjcB5pZT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC653054F8
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722837; cv=none; b=l58u93GoPA+Wg60LHlfhQrvncsNe2PwtJuK8rd5/UK6mkxuSt06fIk3Pqh4jLfm5VAcNDmuoqTVrJvhj8QGCk6E2FN8OQb/9aL3NuAkzwoWWPvR1mSE8cDKK1EfMiXgS85zEDxeHtUtKr2sogMU9XEnNJXkj7Svje4S8sfkVm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722837; c=relaxed/simple;
	bh=7vXuZjZglsXJsxNV99CIDeh56WgxELF9/JCzP4+dOa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tg/6AbvGa/ceJrZflMhnvP9Gc2TXNLL5J6T5AfowWiDteYWVdTBvp6Bh0XGy++O8cw9GsjVnpvCVyZs0pkYdhViacnE28laU+A5Yo2FvG8Fyk5NLG/mZE97f0bHz130iQ4S1cT0EuiKupzXzRSBWF0o/c//w/8S/VrUu82HaefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjcB5pZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18064C4CEF0;
	Wed, 24 Sep 2025 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758722836;
	bh=7vXuZjZglsXJsxNV99CIDeh56WgxELF9/JCzP4+dOa4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gjcB5pZTimL/azOAtuBN8KdyKxT4csR1MocxhZmDmYXI2qzK1kGo1o9/jZYvQS9Va
	 IqduoT5xLuie+MyBTnD7toUJLJ9pRCWky2aLtJOLazG4vXMa8AsKzFVpjbKq0TdYIO
	 8SV+r+doBG+Hwv3OxCHAhXKjnIGDa5wnQvdEG0+yXzNHjX+Lk14vryGDC+h7kZO7dj
	 wRTv3ACG7Z6mCLlvxeiAZOa6sTnC3QKBsABDlfUi+bGuYTEVqWIYfuu7I30f7yclbU
	 rNbJRlyA1Egco+KQLCqA1+F/t3BYGNu5ekoZ9OKi5LYuk7RXtsayHTBJj6Gssmiy2C
	 eU/WMuFHC3JdA==
Message-ID: <20d9c387-c914-4e03-9410-f2f4a2d73cea@kernel.org>
Date: Wed, 24 Sep 2025 10:07:15 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFSD: Add a subsystem policy document
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20250921194353.66095-1-cel@kernel.org>
 <175851511014.1696783.3027085648108996983@noble.neil.brown.name>
 <0fbaef6f-80ad-4885-ba2b-6a9567f01042@kernel.org>
 <175870373332.1696783.10824173167180857471@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <175870373332.1696783.10824173167180857471@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/25 1:48 AM, NeilBrown wrote:
> On Tue, 23 Sep 2025, Chuck Lever wrote:
>> Hi Neil -
>>
>> On 9/21/25 9:25 PM, NeilBrown wrote:
>>>> +Patch preparation
>>>> +~~~~~~~~~~~~~~~~~
>>>> +Like all kernel submissions, please use tagging to identify all
>>>> +patch authors. Reviewers and testers can be added by replying to
>>>> +the email patch submission. Email is extensively used in order to
>>>> +publicly archive review and testing attributions, and will be
>>>> +automatically inserted into your patches when they are applied.
>>>> +
>>>> +The patch description must contain information that does not appear
>>>> +in the body of the diff. The code should be good enough to tell a
>>>> +story -- self-documenting -- but the patch description needs to
>>>> +provide rationale ("why does NFSD benefit from this change?") or
>>>> +a clear problem statement ("what is this patch trying to fix?").
>>
>>> These paras look to be completely generic - not at all nfsd-specific.
>>> Do they belong here?
>>
>> Can you clarify which paragraphs you mean, exactly? Maybe the whole
>> section?
> 
> I specifically meant the previous two paragraphs.
> 
> The "Describe your changes" section of submitting-patches.rst seems to
> cover the same ground.  It even says:
> 
>> Once the problem is established, describe what you are actually doing
>> about it in technical detail.  It's important to describe the change
>> in plain English for the reviewer to verify that the code is behaving
>> as you intend it to.
> 
> which is close enough to the addition that I suggested.

Hi Neil,

Based on your previous remarks, I've already restructured this section.
I'll post a refreshed version of this document and we can go from there.


>> For context:
>>
>> IMHO these comments aren't necessarily generic because I haven't seen
>> them in other documents, and we seem to get a lot of patches where the
>> description is just "Make this change".
>>
>> The comments about tagging: I think other subsystems might not mind
>> seeing Cc: stable in the initial submission. NFS maintainers (even on
>> the client side) like to add those themselves.
> 
> If you don't want "cc: stable" then certainly include that.
> submitting-patches.rst encourages it to be included - for "a severe
> bug"....  but it has been a long time since stable was for "severe" bugs
> only.

Right... I can't think of a reason to copy stable@ on a patch that is
first headed to Linus' kernel.

We could remind folks about stable@kernel.org, which is equivalent in
meaning to stable@vger.kernel.org but is a dead email address...?


>> I'd like to encourage contributors to get the Fixes: tag right before
>> submitting, too. It saves me a little incremental time per patch.
> 
> submitting-patches.rst encourages a Fixes: tag.

And still people forget. A little more encouragement can't hurt. Unless
you believe this addition is actively harmful, I'd like to keep the
gentle encouragement here.


-- 
Chuck Lever

