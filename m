Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7C3696ECC
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 22:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjBNVB3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 16:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjBNVB2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 16:01:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B208C2823C
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 13:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676408444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hkET2jBHGlpYgNReiuTBx75lqQOJ0QeAMBTWfdbDQrE=;
        b=dB25PmshvUD33M2ppoC1zugzNvJHQogbSky+H1qy9IuoqzDbbPg5cx5jYEFs25F7zKum2x
        daLZ2c74OnpQBgBwdb3NNr+1AStgxsVOZ8ToKK5xoRa6mzivvtD+b/+0L2pik72ktdINoY
        SETvUn1AMgX57MkFgNey5NRIxXnBfCA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-janu78DpN0ONKOoEnClaAw-1; Tue, 14 Feb 2023 16:00:33 -0500
X-MC-Unique: janu78DpN0ONKOoEnClaAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BD2C3C0DDBF;
        Tue, 14 Feb 2023 21:00:33 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 927B1140EBF6;
        Tue, 14 Feb 2023 21:00:32 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@kernel.org>
Cc:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4: Ensure we revalidate data after OPEN expired
Date:   Tue, 14 Feb 2023 16:00:29 -0500
Message-ID: <EF0BC155-418B-4047-B162-6A829C693974@redhat.com>
In-Reply-To: <a44dfa9367526593f1be28dad281e2b6d50aaa2e.camel@kernel.org>
References: <7e97897a29878a56236ef8e15bce7a295d5e8a41.1676403514.git.bcodding@redhat.com>
 <a44dfa9367526593f1be28dad281e2b6d50aaa2e.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 14 Feb 2023, at 15:30, Trond Myklebust wrote:

> On Tue, 2023-02-14 at 14:39 -0500, Benjamin Coddington wrote:
>> We've observed that if the NFS client experiences a network partition
>> and
>> the server revokes the client's state, the client may not revalidate
>> cached
>> data for an open file during recovery.  If the file is extended by a
>> second
>> client during this network partition, the first client will correctly
>> update the file's size and attributes during recovery, but another
>> extending write will discard the second client's data.
>
> I'm having trouble fully understanding your problem description. Is the
> issue that both clients are opening the same file with something like
> O_WRONLY|O_DSYNC|O_APPEND?

Yes.

> If so, what if the network partition happens during the write() system
> call of client 1, so that the page cache is updated but the flush of
> the write data ends up being delayed by the partition?
> In that case, client 2 doesn't know that client 1 has writes
> outstanding so it may write its data to where the server thinks the eof
> offset is. However once client 1 is able to recover its open state, it
> will still have dirty page cache data that is going to overwrite that
> same offset.

Ah, yes.  :(   In this case we might be safe saying that close-to-open
consistency is preserved, though, if the second client has closed the file.
At least client 1 will have the data laid out in the file the way it
expected.

>> In the case where another client opened the file during the network
>> partition and the server revoked the first client's state, the
>> recovery can
>> forego optimizations and instead attempt to avoid corruption.
>>
>> It's a little tricky to solve this in a per-file way during recovery
>> without plumbing arguments or introducing new flags.  This patch
>> side-steps
>> the per-file complexity by simply checking if the client is within a
>> NOGRACE recovery window, and if so, invalidates data during the open
>> recovery.
>>
>
> I don't see how this scenario can ever be made fully safe. If people
> care, then we should probably have the open recovery of client 1 fail
> altogether in this case (subject to some switch similar to the existing
> 'recover_lost_locks' kernel option).

Its quite a corner case.

I actually don't have a broken setup yet.  We noticed this behavior appear
in a regression test now that knfsd will both: 1) give a read delegation for
RW open and 2) forget client state if a delegation callback times out.
Otherwise, without the delegation, the server doesn't send the client back
through recovery and the appending open/write happens at the correct eof.

Maybe that server behavior will trigger some real problem reports, and I
should look into making the server a little nicer to the client for a short
partition.

Ben

