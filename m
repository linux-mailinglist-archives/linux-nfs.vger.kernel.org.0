Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56EF742CDB
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 21:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjF2TDk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 15:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjF2TCE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 15:02:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AAF358A
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 12:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688065272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IsegDidghFBgcEvXWwvO9nCR7OZlaU20ZrCBSuf4vY8=;
        b=NEeWwZnKHTX1a3JSjYt+M3a3aeSjIi+FMXtrdSFUgtzTW3v/IBgocvTqRHsaUBaFMFDQqZ
        Ov4+auiCcryJXqr72uT0Yns7+rlBJvfRrFZ4qzimbAnRmE3MoQw+6l+cwdI6SN9sJz8vjP
        WamaLkjK3n6nwk+j8WpU3IEWlYAp5PQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-4o4z2VSNP5OD4sJT0FogaA-1; Thu, 29 Jun 2023 15:01:08 -0400
X-MC-Unique: 4o4z2VSNP5OD4sJT0FogaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A4388EA664;
        Thu, 29 Jun 2023 19:01:08 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4207E40C6F5A;
        Thu, 29 Jun 2023 19:01:06 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        Olga.Kornievskaia@netapp.com
Subject: Re: [PATCH 2/2] NFSv4: Fix dropped lock for racing OPEN and
 delegation return
Date:   Thu, 29 Jun 2023 15:01:05 -0400
Message-ID: <F6ACFFCC-CDBD-4DEA-B137-6CE96468FBB7@redhat.com>
In-Reply-To: <c7db01fb8e1dae2148c3d3fe4e61d8a74f92522e.camel@hammerspace.com>
References: <5577791deaa898578c8e8f86336eaca053d9efdd.1687890438.git.bcodding@redhat.com>
 <01047e4baa85ca541a5a43f88f588b15163292dc.1687890438.git.bcodding@redhat.com>
 <c7db01fb8e1dae2148c3d3fe4e61d8a74f92522e.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 29 Jun 2023, at 14:33, Trond Myklebust wrote:

> On Tue, 2023-06-27 at 14:31 -0400, Benjamin Coddington wrote:
>> Commmit f5ea16137a3f ("NFSv4: Retry LOCK on OLD_STATEID during
>> delegation
>> return") attempted to solve this problem by using nfs4's generic
>> async error
>> handling, but introduced a regression where v4.0 lock recovery would
>> hang.
>> The additional complexity introduced by overloading that error
>> handling is
>> not necessary for this case.
>>
>> The problem as originally explained in the above commit is:
>>
>> =C2=A0=C2=A0=C2=A0 There's a small window where a LOCK sent during a d=
elegation
>> return can
>> =C2=A0=C2=A0=C2=A0 race with another OPEN on client, but the open stat=
eid has not
>> yet been
>> =C2=A0=C2=A0=C2=A0 updated.=C2=A0 In this case, the client doesn't han=
dle the OLD_STATEID
>> error
>> =C2=A0=C2=A0=C2=A0 from the server and will lose this lock, emitting:
>> =C2=A0=C2=A0=C2=A0 "NFS: nfs4_handle_delegation_recall_error: unhandle=
d error -
>> 10024".
>>
>> We want a fix that is much more focused to the original problem.=C2=A0=
 Fix
>> this
>> issue by returning -EAGAIN from the
>> nfs4_handle_delegation_recall_error() on
>> OLD_STATEID, and use that as a signal for the delegation return code
>> to
>> retry the LOCK operation.=C2=A0 We should at this point be able to sen=
d
>> along
>> the updated stateid.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>> =C2=A0fs/nfs/delegation.c | 4 +++-
>> =C2=A0fs/nfs/nfs4proc.c=C2=A0=C2=A0 | 1 +
>> =C2=A02 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
>> index cf7365581031..23aeb02319a5 100644
>> --- a/fs/nfs/delegation.c
>> +++ b/fs/nfs/delegation.c
>> @@ -160,7 +160,9 @@ static int nfs_delegation_claim_locks(struct
>> nfs4_state *state, const nfs4_state
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (nfs_file_open_context(fl->fl_file)->state !=3D=

>> state)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c=
ontinue;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock(&flctx->flc_lock);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0status =3D nfs4_lock_delegation_recall(fl, state,
>> stateid);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0do {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stat=
us =3D nfs4_lock_delegation_recall(fl,
>> state, stateid);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0} while (status =3D=3D -EAGAIN);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (status < 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g=
oto out;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0spin_lock(&flctx->flc_lock);
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index 6bb14f6cfbc0..399db73a57f4 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -2262,6 +2262,7 @@ static int
>> nfs4_handle_delegation_recall_error(struct nfs_server *server, struct
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_BAD_HIGH_SLOT:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_DEADSESSION:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_OLD_STATEID:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
eturn -EAGAIN;
>
> Hmm... Rather than issuing a blanket EAGAIN, we really should be
> looking at using either nfs4_refresh_lock_old_stateid() or
> nfs4_refresh_open_old_stateid(), depending on whether the stateid that
> saw the NFS4ERR_OLD_STATEID was a lock stateid or an open stateid.

I figured if there was client race that would trigger the OLD_STATEID on
open, we'd have heard from the "unhandled error" printk by now, so I rush=
ed
this out..  But I also don't like the overloading for open error handling=

here.  I'll work it up as you suggest.

The revert can go without a fix (IMO).  The fix is worse than original bu=
g
which was really hard to hit.  I couldn't reproduce it without artificial=

delays.

Ben

