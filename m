Return-Path: <linux-nfs+bounces-12722-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF50AE68BB
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 16:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BAD4E19BB
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 14:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE8F2D8781;
	Tue, 24 Jun 2025 14:22:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E9AEB2D8769;
	Tue, 24 Jun 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774927; cv=none; b=P7hURd28nWaxG5IcboDA7esNadJJ6WjpCGUHlTyKZvKswnX6hPer5i7T0LPOcNDD1d5FcMUHOTV59KV8rFT/Q+khcKe1szwsLOSkNZCZ5QgIxX8ZZFddDvbw2CJnOEp19bViUaOuW5jU+eeD2AVTjpxe319ou3E8a3xvLT+Fka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774927; c=relaxed/simple;
	bh=2fyLteoMsAeRRTTISqANfVeGfJpdi/hsp5Xg5/qyOls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=ARIBkK6DAc928aD9tpHnpQ2rlQwi7F7/v/x38zbd0xdhTaLFk1H8y+1cCvzDpbVT07qv8qm2BIm3EnF4n0/8AF0hcQoZ037cVJiLRjRnGl71bTs7dlt1yXzrf1qHc6azR+jzUyKaJyBbshU4vWWAyCLDJUYxsWK9D74wsFou3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 4DE02602EDAF9;
	Tue, 24 Jun 2025 22:21:56 +0800 (CST)
Message-ID: <99a15559-072d-4c45-b12f-b42b4884cb06@nfschina.com>
Date: Tue, 24 Jun 2025 22:21:55 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Using guard() to simplify nfsd_cache_lookup()
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>
Cc: jlayton@kernel.org, okorniev@redhat.com, Dai.Ngo@oracle.com,
 tom@talpey.com, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Su Hui <suhui@nfschina.com>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <13630a14-d1b9-4c38-80f8-33d2de2ea00c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/6/24 21:41, Chuck Lever wrote:
> On 6/23/25 9:31 PM, Su Hui wrote:
>> On 2025/6/24 08:19, NeilBrown wrote:
>>> On Mon, 23 Jun 2025, Su Hui wrote:
>>>> Using guard() to replace *unlock* label. guard() makes lock/unlock code
>>>> more clear. Change the order of the code to let all lock code in the
>>>> same scope. No functional changes.
>>> While I agree that this code could usefully be cleaned up and that you
>>> have made some improvements, I think the use of guard() is a nearly
>>> insignificant part of the change.  You could easily do exactly the same
>>> patch without using guard() but having and explicit spin_unlock() before
>>> the new return.  That doesn't mean you shouldn't use guard(), but it
>>> does mean that the comment explaining the change could be more usefully
>>> focused on the "Change the order ..." part, and maybe explain what that
>>> is important.
>> Got it. I will focus on "Change the order ..." part in the next v2 patch.
>>> I actually think there is room for other changes which would make the
>>> code even better:
>>> - Change nfsd_prune_bucket_locked() to nfsd_prune_bucket().  Have it
>>>     take the lock when needed, then drop it, then call
>>>     nfsd_cacherep_dispose() - and return the count.
>>> - change nfsd_cache_insert to also skip updating the chain length stats
>>>     when it finds a match - in that case the "entries" isn't a chain
>>>     length. So just  lru_put_end(), return.  Have it return NULL if
>>>     no match was found
>>> - after the found_entry label don't use nfsd_reply_cache_free_locked(),
>>>     just free rp.  It has never been included in any rbtree or list, so it
>>>     doesn't need to be removed.
>>> - I'd be tempted to have nfsd_cache_insert() take the spinlock itself
>>>     and call it under rcu_read_lock() - and use RCU to free the cached
>>>     items.
>>> - put the chunk of code after the found_entry label into a separate
>>>     function and instead just return RC_REPLY (and maybe rename that
>>>     RC_CACHED).  Then in nfsd_dispatch(), if RC_CACHED was returned, call
>>>     that function that has the found_entry code.
>>>
>>> I think that would make the code a lot easier to follow.  Would you like
>>> to have a go at that - I suspect it would be several patches - or shall
>>> I do it?
>>>
>>> Thanks,
>>> NeilBrown
>>>
>> Really thanks for your suggestions!
>> Yes, I'd like to do it in the next v2 patchset as soon as possible.
>> I'm always searching some things I can participate in about linux kernel
>> community, so it's happy for me to do this thing.
> Hi Su -
>
> Split the individual changes Neil suggested into separate patches. That
> makes the changes easier to review.

Hi,

Thanks for your remind. I will split these individual changes.
It won't be too long, at the latest this week I will submit this patchset.

Regards,
Su Hui



