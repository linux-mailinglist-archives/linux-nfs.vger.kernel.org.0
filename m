Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EF6274ACF
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 23:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIVVIr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 17:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbgIVVIq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Sep 2020 17:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600808925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W6eOwF47fWvzUPZGEFHYE1OBrSB5kkMEZaDhxBXTiZE=;
        b=OGpi1pufAZSAzHWMSWgr+JYOuJVOSNEjlu8E9bMUXM9hmp3FAvY+4SKerdAz8bn5tly/yB
        AvfejlP/WWoGLnlKIOOKqKGdptXpFomLAjUw/G24xeXL98fu/ydxv2qeWbB1dE2GMaF1WA
        HbeqrNtl9+XxAqgghyyXIFwWQBYgjys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-3oSpRrZGMtq3Dj6_pVWJfw-1; Tue, 22 Sep 2020 17:08:43 -0400
X-MC-Unique: 3oSpRrZGMtq3Dj6_pVWJfw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1BCB801FDD;
        Tue, 22 Sep 2020 21:08:41 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5775F60C04;
        Tue, 22 Sep 2020 21:08:41 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] NFSv4: Fix a livelock when CLOSE pre-emptively
 bumps state sequence
Date:   Tue, 22 Sep 2020 17:08:40 -0400
Message-ID: <75089C5A-31C2-4BF2-AD01-BC9D923FCE4B@redhat.com>
In-Reply-To: <d6c2ce2b4c0517bd430b4005c4c96d118fba6f3a.camel@hammerspace.com>
References: <cover.1600801124.git.bcodding@redhat.com>
 <a641f9a42786d4699ec99cafa14ab5272a9362bf.1600801124.git.bcodding@redhat.com>
 <d6c2ce2b4c0517bd430b4005c4c96d118fba6f3a.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 22 Sep 2020, at 15:48, Trond Myklebust wrote:

> On Tue, 2020-09-22 at 15:15 -0400, Benjamin Coddington wrote:
>> Since commit 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in
>> CLOSE/OPEN_DOWNGRADE") the following livelock may occur if a CLOSE
>> races
>> with the update of the nfs_state:
>>
>> Process 1           Process 2           Server
>> =========           =========           ========
>>  OPEN file
>>                     OPEN file
>>                                         Reply OPEN (1)
>>                                         Reply OPEN (2)
>>  Update state (1)
>>  CLOSE file (1)
>>                                         Reply OLD_STATEID (1)
>>  CLOSE file (2)
>>                                         Reply CLOSE (-1)
>>                     Update state (2)
>>                     wait for state change
>>  OPEN file
>>                     wake
>>  CLOSE file
>>  OPEN file
>>                     wake
>>  CLOSE file
>>  ...
>>                     ...
>>
>> As long as the first process continues updating state, the second
>> process
>> will fail to exit the loop in nfs_set_open_stateid_locked().  This
>> livelock
>> has been observed in generic/168.
>>
>> Fix this by detecting the case in nfs_need_update_open_stateid() and
>> then exit the loop if:
>>  - the state is NFS_OPEN_STATE, and
>>  - the stateid sequence is > 1, and
>>  - the stateid doesn't match the current open stateid
>>
>> Fixes: 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in
>> CLOSE/OPEN_DOWNGRADE")
>> Cc: stable@vger.kernel.org # v5.4+
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>>  fs/nfs/nfs4proc.c | 27 +++++++++++++++++----------
>>  1 file changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index 6e95c85fe395..9db29a438540 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -1588,18 +1588,25 @@ static void
>> nfs_test_and_clear_all_open_stateid(struct nfs4_state *state)
>>  static bool nfs_need_update_open_stateid(struct nfs4_state *state,
>>  		const nfs4_stateid *stateid)
>>  {
>> -	if (test_bit(NFS_OPEN_STATE, &state->flags) == 0 ||
>> -	    !nfs4_stateid_match_other(stateid, &state->open_stateid)) {
>> -		if (stateid->seqid == cpu_to_be32(1))
>> +	bool state_matches_other = nfs4_stateid_match_other(stateid,
>> &state->open_stateid);
>> +	bool seqid_one = stateid->seqid == cpu_to_be32(1);
>> +
>> +	if (test_bit(NFS_OPEN_STATE, &state->flags)) {
>> +		/* The common case - we're updating to a new sequence
>> number */
>> +		if (state_matches_other &&
>> nfs4_stateid_is_newer(stateid, &state->open_stateid)) {
>> +			nfs_state_log_out_of_order_open_stateid(state,
>> stateid);
>> +			return true;
>> +		}
>> +	} else {
>> +		/* This is the first OPEN */
>> +		if (!state_matches_other && seqid_one) {
>
> Why are we looking at the value of state_matches_other here? If the
> NFS_OPEN_STATE flags is not set, then the state->open_stateid is not
> initialised, so how does it make sense to look at a comparison with 
> the
> incoming stateid?

You're right - it doesn't make sense. I failed to clean it up out of my
decision matrix.  I'll send a v3 after it gets tested overnight.

Thanks for the look, and if you have another moment - what do you think
about not bumping the seqid in the CLOSE/OPEN_DOWNGRADE path on 
OLD_STATEID
if the state's refcount > 1?  This would optimize away a lot of recovery 
for
races like this, but I wonder if it would be possible to end up with two
OPEN_DOWNGRADEs dueling that would never recover.

If you don't have the moment, no problem.  Thanks again for looking at 
my patch.

Ben

