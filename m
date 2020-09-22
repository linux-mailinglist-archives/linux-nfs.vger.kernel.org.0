Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC2B274C33
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Sep 2020 00:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIVWi1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 18:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbgIVWi1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Sep 2020 18:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600814305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yoBt3Zlizt3jkCWd7ZrtZzUJUwffDhRTU35AUiJAwpQ=;
        b=SNUOR7yYSS3B3SdMKUK2sNGmAd7iMaimCEh4S4gxND3DCuHQkerZgmD50Rtes9HdlVBNp9
        5UFVFoiJs/YEoE302WhdOwDtLQVIf1PajgIKk49y++HV0sE0gR28/ZYYkd7myFpprna5Y+
        fbAvYSGV0fbMckpl0TQ1bcPf6gqnvKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-aQBF04O7MEShijfob9TMIw-1; Tue, 22 Sep 2020 18:38:23 -0400
X-MC-Unique: aQBF04O7MEShijfob9TMIw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A9371005E6D;
        Tue, 22 Sep 2020 22:38:22 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0093D60BF4;
        Tue, 22 Sep 2020 22:38:21 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, anna.schumaker@netapp.com
Subject: Re: [PATCH 1/2 v2] NFSv4: Fix a livelock when CLOSE pre-emptively
 bumps state sequence
Date:   Tue, 22 Sep 2020 18:38:20 -0400
Message-ID: <5A0929F2-2420-4834-BC83-F7A97297C1B3@redhat.com>
In-Reply-To: <d975b3c99a0cda36140b6ac828cd9abc2b03b18d.camel@hammerspace.com>
References: <cover.1600801124.git.bcodding@redhat.com>
 <a641f9a42786d4699ec99cafa14ab5272a9362bf.1600801124.git.bcodding@redhat.com>
 <d6c2ce2b4c0517bd430b4005c4c96d118fba6f3a.camel@hammerspace.com>
 <75089C5A-31C2-4BF2-AD01-BC9D923FCE4B@redhat.com>
 <ad2189f161a657118868fe1c2897b2e661e04261.camel@hammerspace.com>
 <d975b3c99a0cda36140b6ac828cd9abc2b03b18d.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 22 Sep 2020, at 17:46, Trond Myklebust wrote:

> On Tue, 2020-09-22 at 17:15 -0400, Trond Myklebust wrote:
>> On Tue, 2020-09-22 at 17:08 -0400, Benjamin Coddington wrote:
>>> On 22 Sep 2020, at 15:48, Trond Myklebust wrote:
>>>
>>>> On Tue, 2020-09-22 at 15:15 -0400, Benjamin Coddington wrote:
>>>>> Since commit 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID
>>>>> in
>>>>> CLOSE/OPEN_DOWNGRADE") the following livelock may occur if a
>>>>> CLOSE
>>>>> races
>>>>> with the update of the nfs_state:
>>>>>
>>>>> Process 1           Process 2           Server
>>>>> =========           =========           ========
>>>>>  OPEN file
>>>>>                     OPEN file
>>>>>                                         Reply OPEN (1)
>>>>>                                         Reply OPEN (2)
>>>>>  Update state (1)
>>>>>  CLOSE file (1)
>>>>>                                         Reply OLD_STATEID (1)
>>>>>  CLOSE file (2)
>>>>>                                         Reply CLOSE (-1)
>>>>>                     Update state (2)
>>>>>                     wait for state change
>>>>>  OPEN file
>>>>>                     wake
>>>>>  CLOSE file
>>>>>  OPEN file
>>>>>                     wake
>>>>>  CLOSE file
>>>>>  ...
>>>>>                     ...
>>>>>
>>>>> As long as the first process continues updating state, the
>>>>> second
>>>>> process
>>>>> will fail to exit the loop in
>>>>> nfs_set_open_stateid_locked().  This
>>>>> livelock
>>>>> has been observed in generic/168.
>>>>>
>>>>> Fix this by detecting the case in
>>>>> nfs_need_update_open_stateid()
>>>>> and
>>>>> then exit the loop if:
>>>>>  - the state is NFS_OPEN_STATE, and
>>>>>  - the stateid sequence is > 1, and
>>>>>  - the stateid doesn't match the current open stateid
>>>>>
>>>>> Fixes: 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in
>>>>> CLOSE/OPEN_DOWNGRADE")
>>>>> Cc: stable@vger.kernel.org # v5.4+
>>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>>> ---
>>>>>  fs/nfs/nfs4proc.c | 27 +++++++++++++++++----------
>>>>>  1 file changed, 17 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>>> index 6e95c85fe395..9db29a438540 100644
>>>>> --- a/fs/nfs/nfs4proc.c
>>>>> +++ b/fs/nfs/nfs4proc.c
>>>>> @@ -1588,18 +1588,25 @@ static void
>>>>> nfs_test_and_clear_all_open_stateid(struct nfs4_state *state)
>>>>>  static bool nfs_need_update_open_stateid(struct nfs4_state
>>>>> *state,
>>>>>  		const nfs4_stateid *stateid)
>>>>>  {
>>>>> -	if (test_bit(NFS_OPEN_STATE, &state->flags) == 0 ||
>>>>> -	    !nfs4_stateid_match_other(stateid, &state-
>>>>>> open_stateid)) {
>>>>> -		if (stateid->seqid == cpu_to_be32(1))
>>>>> +	bool state_matches_other =
>>>>> nfs4_stateid_match_other(stateid,
>>>>> &state->open_stateid);
>>>>> +	bool seqid_one = stateid->seqid == cpu_to_be32(1);
>>>>> +
>>>>> +	if (test_bit(NFS_OPEN_STATE, &state->flags)) {
>>>>> +		/* The common case - we're updating to a new
>>>>> sequence
>>>>> number */
>>>>> +		if (state_matches_other &&
>>>>> nfs4_stateid_is_newer(stateid, &state->open_stateid)) {
>>>>> +			nfs_state_log_out_of_order_open_stateid
>>>>> (state,
>>>>> stateid);
>>>>> +			return true;
>>>>> +		}
>>>>> +	} else {
>>>>> +		/* This is the first OPEN */
>>>>> +		if (!state_matches_other && seqid_one) {
>>>>
>>>> Why are we looking at the value of state_matches_other here? If
>>>> the
>>>> NFS_OPEN_STATE flags is not set, then the state->open_stateid is
>>>> not
>>>> initialised, so how does it make sense to look at a comparison
>>>> with
>>>> the
>>>> incoming stateid?
>>>
>>> You're right - it doesn't make sense. I failed to clean it up out
>>> of
>>> my
>>> decision matrix.  I'll send a v3 after it gets tested overnight.
>>>
>>> Thanks for the look, and if you have another moment - what do you
>>> think
>>> about not bumping the seqid in the CLOSE/OPEN_DOWNGRADE path on
>>> OLD_STATEID
>>> if the state's refcount > 1?  This would optimize away a lot of
>>> recovery
>>> for
>>> races like this, but I wonder if it would be possible to end up
>>> with
>>> two
>>> OPEN_DOWNGRADEs dueling that would never recover.
>>>
>>
>> It would lead to a return of the infinite loop in cases where the
>> client misses a reply to an OPEN or CLOSE due to a soft timeout
>> (which
>> is an important use case for us).

I hadn't thought about that, but doesn't the task return and decrement the
refcount on nfs4_state?

> In principle, RFC5661 says that the client is supposed to process all
> stateid operations in the order dictated by the seqid. The one problem
> with that mandate is that open-by-filename doesn't allow us to know
> whether or not a seqid bump is outstanding. This is why we have the 5
> second timeout wait in nfs_set_open_stateid_locked().
>
> We could do something similar to that for CLOSE by setting the seqid to
> 0, and then ensuring we process the CLOSE in the order the server ends
> up processing it. Unfortunately, that would require us to replay any
> OPEN calls that got shut down because we used seqid 0 (it would also
> not work for NFSv4.0)... So perhaps the best solution would be to
> instead allow CLOSE to wait for outstanding OPENs to complete, just
> like we do in nfs_set_open_stateid_locked()? Thoughts?

How can you know if there are outstanding OPENs?  I thought that was the
whole intention of the CLOSE -> OLD_STATEID retry bump -- you cannot know if
the server was able to process an interrupted OPEN.

I had a dumb patch that just caused CLOSE to delay a bit before retrying if
it received OLD_STATEID, but I figured that was vulnerable to another
livelock where another process could just keep doing open(), close() as
well.

Ben

