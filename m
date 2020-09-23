Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7031327610C
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Sep 2020 21:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIWT3q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Sep 2020 15:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgIWT3q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Sep 2020 15:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600889384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KS4cExlaGHnvxdJAk1FNBY3AOmL3wdhBylwgDxQFtPE=;
        b=dkXgrbFw8y1lvmHhL+Jw/mHHvDauCD+/Rgfxn2oo4GV90UnRjS674gkWIuxTjjuOh5fSDg
        YtpDFUgJOUnpEdESJV7Nmm/GQPH+/0OyYohD8r2ihdz5R4azOVx5xjneSa12iLWunPwZ++
        oEJpVW4W9x1KCB6SQwEAVHyoswG0mRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-gkyD0FHSOQuS40pULEFOKA-1; Wed, 23 Sep 2020 15:29:42 -0400
X-MC-Unique: gkyD0FHSOQuS40pULEFOKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C21F11074659;
        Wed, 23 Sep 2020 19:29:40 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D1A43782;
        Wed, 23 Sep 2020 19:29:39 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2 v3] NFSv4: Fix a livelock when CLOSE pre-emptively
 bumps state sequence
Date:   Wed, 23 Sep 2020 15:29:38 -0400
Message-ID: <24324678-510B-4524-8C17-EB7365C2A3CD@redhat.com>
In-Reply-To: <69ca1c64b0e7eb205e8f53af8febf6d688f65d80.camel@hammerspace.com>
References: <cover.1600882430.git.bcodding@redhat.com>
 <787d0d4946efb286f4dc51051b048277c0dc697e.1600882430.git.bcodding@redhat.com>
 <69ca1c64b0e7eb205e8f53af8febf6d688f65d80.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 23 Sep 2020, at 14:53, Trond Myklebust wrote:

> On Wed, 2020-09-23 at 13:37 -0400, Benjamin Coddington wrote:
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
>>  fs/nfs/nfs4proc.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index 6e95c85fe395..8c2bb91127ee 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -1588,19 +1588,21 @@ static void
>> nfs_test_and_clear_all_open_stateid(struct nfs4_state *state)
>>  static bool nfs_need_update_open_stateid(struct nfs4_state *state,
>>  		const nfs4_stateid *stateid)
>>  {
>> -	if (test_bit(NFS_OPEN_STATE, &state->flags) == 0 ||
>> -	    !nfs4_stateid_match_other(stateid, &state->open_stateid)) {
>> +	if (test_bit(NFS_OPEN_STATE, &state->flags)) {
>> +		/* The common case - we're updating to a new sequence
>> number */
>> +		if (nfs4_stateid_match_other(stateid, &state-
>>> open_stateid) &&
>> +			nfs4_stateid_is_newer(stateid, &state-
>>> open_stateid)) {
>> +			nfs_state_log_out_of_order_open_stateid(state,
>> stateid);
>> +			return true;
>> +		}
>> +	} else {
>> +		/* This is the first OPEN */
>>  		if (stateid->seqid == cpu_to_be32(1))
>>  			nfs_state_log_update_open_stateid(state);
>>  		else
>>  			set_bit(NFS_STATE_CHANGE_WAIT, &state->flags);
>
> Isn't this going to cause a reopen of the file on the client if it ends
> up processing the reply to the second OPEN after it processes the
> successful CLOSE?

Yes, that's true - but that's a different bug that I haven't noticed or
considered.  This patch isn't introducing it.

> Isn't the real problem here rather that the reply to CLOSE needs to be
> processed in order too?

Not just the reply, the actual request as well.  If we have a way to
properly serialize procssing of CLOSE responses, we could just not send the
CLOSE in the first place.

I'd rather not send the CLOSE if there's another OPEN in play, and if that's
the barrier to getting this particular bug fixed, I'll work on that.  What
mechanism can be used?  What if the client kept a separate "pending" stateid
that could be updated before each operation that would attempt to predict
what the server's resulting change would be?

Maybe better would be a counter that gets incremented for each transition
to/from NFS_OPEN_STATE so we can check if the stateid is in the same
generation and a counter for outstanding operations that are expected to
bump the sequence.

