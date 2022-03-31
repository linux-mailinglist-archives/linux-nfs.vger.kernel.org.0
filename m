Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5534EE371
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 23:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbiCaVtQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 17:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241948AbiCaVtP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 17:49:15 -0400
Received: from cc-smtpout1.netcologne.de (cc-smtpout1.netcologne.de [89.1.8.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BB623F3F2
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 14:47:27 -0700 (PDT)
Received: from cc-smtpin3.netcologne.de (cc-smtpin3.netcologne.de [89.1.8.203])
        by cc-smtpout1.netcologne.de (Postfix) with ESMTP id 77B9412644;
        Thu, 31 Mar 2022 23:47:25 +0200 (CEST)
Received: from nas2.garloff.de (xdsl-213-196-192-4.nc.de [213.196.192.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin3.netcologne.de (Postfix) with ESMTPSA id D024211DE3;
        Thu, 31 Mar 2022 23:47:17 +0200 (CEST)
Received: from [192.168.155.202] (unknown [192.168.155.10])
        by nas2.garloff.de (Postfix) with ESMTPSA id 310EEB3B131A;
        Thu, 31 Mar 2022 23:47:02 +0200 (CEST)
Message-ID: <23c59973-6c08-6132-607b-0f949501e0a5@garloff.de>
Date:   Thu, 31 Mar 2022 23:47:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20220223174041.77887-1-olga.kornievskaia@gmail.com>
 <CAN-5tyHy_+tBfv3PuD0CBwHbppHo3pRNwo0O9xRGjZxK0-rOjw@mail.gmail.com>
 <a494ba2b-7e2c-bcad-bac9-12804b113383@garloff.de>
 <B476B883-D5D4-4112-BB08-6D9172C5D335@garloff.de>
 <8849D8CD-0720-40E2-A752-1C9AADC93C55@redhat.com>
 <40CC442E-C228-4C66-A2F0-DB850DBC5EC5@oracle.com>
 <CAN-5tyHZ-7=V=CGT+Ni6DWZYbvXgpGoBn_sXeTg54YqhPZsufg@mail.gmail.com>
From:   Kurt Garloff <kurt@garloff.de>
Subject: Re: [PATCH v1] NFSv4.1 provide mount option to toggle trunking
 discovery
In-Reply-To: <CAN-5tyHZ-7=V=CGT+Ni6DWZYbvXgpGoBn_sXeTg54YqhPZsufg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-NetCologne-Spam: L
X-Rspamd-Queue-Id: D024211DE3
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga, Chuck,

On 16/03/2022 17:09, Olga Kornievskaia wrote:
> On Wed, Mar 16, 2022 at 11:14 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>>> On Mar 16, 2022, at 8:39 AM, Benjamin Coddington <bcodding@redhat.com> wrote:
>>>
>>> On 25 Feb 2022, at 17:48, Kurt Garloff wrote:
>>>
>>>> Hi,
>>>>
>>>> Am 24. Februar 2022 14:42:41 MEZ schrieb Kurt Garloff <kurt@garloff.de>:
>>>>> Hi Olga,
>>>>> [...]
>>>>>
>>>>> I see a number of possibilities to resolve this:
>>>>> (0) We pretend it's not a problem that's serious enough to take
>>>>>      action (and ensure that we do document this new option well).
>>>>> (1) We revert the patch that does FS_LOCATIONS discovery.
>>>>>      Assuming that FS_LOCATIONS does provide a useful feature, this
>>>>>      would not be our preferred solution, I guess ...
>>>>> (2) We prevent NFS v4.1 servers to use FS_LOCATIONS (like my patch
>>>>>      implements) and additionally allow for the opt-out with
>>>>>      notrunkdiscovery mount option. This fixes the known regression
>>>>>      with Qnap knfsd (without requiring user intervention) and still
>>>>>      allows for FS_LOCATIONS to be useful with NFSv4.2 servers that
>>>>>      support this. The disadvantage is that we won't use the feature
>>>>>      on NFSv4.1 servers which might support this feature perfectly
>>>>>      (and there's no opt-in possibility). And the risk is that there
>>>>>      might be NFSv4.2 servers out there that also misreport
>>>>>      FS_LOCATIONS support and still need manual intervention (which
>>>>>      at least is possible with notrunkdiscovery).
>>>>> (3) We make this feature an opt-in thing and require users to
>>>>>      pass trunkdiscovery to take advantage of the feature.
>>>>>      This has zero risk of breakage (unless we screw up the patch),
>>>>>      but always requires user intervention to take advantage of
>>>>>      the FS_LOCATIONS feature.
>>>>> (4) Identify a way to recover from the mount with FS_LOCATIONS
>>>>>      against the broken server, so instead of hanging we do just
>>>>>      turn this off if we find it not to work. Disadavantage is that
>>>>>      this adds complexity and might stall the mounting for a while
>>>>>      until the recovery worked. The complexity bears the risk for
>>>>>      us screwing up.
>>>>>
>>>>> I personally find solutions 2 -- 4 acceptable.
>>>>>
>>>>> If the experts see (4) as simple enough, it might be worth a try.
>>>>> Otherwise (2) or (3) would seem the way to go from my perspective.
>>>> Any thought ls?
>>> I think (3) is the best way, and perhaps using sysfs to toggle it would
>>> be a solution to the problems presented by a mount option.
>>>
>>> I'm worried that this issue is being ignored because that's usually what
>>> happens when requests/patches are proposed that violate the policy of "we do
>>> not fix the client for server bugs".  In this case that policy conficts with
>>> "no user visible regressions".
>>>
>>> Can anyone declare which policy takes precedent?
>> "No regressions" probably takes precedent. IMO 1) should be done
>> immediately.
>>
>> This is not a server bug, necessarily. The server is responding
>> within the realm of what is allowed by specification and I can
>> see cases where a server might have a good reason to DELAY an
>> fs_locations request for a while.
>>
>> So I think once 1) has been done and backported to stable, the
>> client functionality should be restored via 4) to ensure that a
>> server can't delay a client mount indefinitely. (Although I think
>> I've stated that preference before).
> Reverting the patch is equivalent to introducing a mount option (with
> what I'm hearing a preference of notrunking being the default) but
> possibly better. It solves the problems of the broken servers and it
> allows servers that want this functionality to use it.

I agree with reverting and then introducing and opt-in setting instead.

I have not seen this submitted yet (though I have to admit that
I may have missed it).

So who is going to code this. If there is noone who has capacity
to do so, I can certainly jump in, though I am probably the least
skilled person in this conversation.

>> I don't see any need to involve a human in making the decision
>> to try fs_locations. The client should try fs_locations and if
>> it doesn't work, just move on as quickly as it can. As always,
>> I don't relish adding more administrative controls if we can
>> avoid it. Such controls add to our test matrix and our long
>> term technical debt. Easy to add, but very difficult to change
>> or remove once merged. I can't see an upside here.

That would be the better approach, but it also certainly is less
straight-forward to implement.
I'm happy to test, if we get some patch to look at short-term.

Otherwise, I'd suggest to go for reversion first and keep this
plan in the back of our minds for later execution.

Thanks.

-- 
Kurt Garloff <kurt@garloff.de>
Cologne, Germany




>>
>> --
>> Chuck Lever
>>
>>
>>
