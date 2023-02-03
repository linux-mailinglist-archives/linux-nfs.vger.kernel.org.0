Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E0B689DFE
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Feb 2023 16:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjBCPSH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Feb 2023 10:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbjBCPRA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Feb 2023 10:17:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D9C2594F
        for <linux-nfs@vger.kernel.org>; Fri,  3 Feb 2023 07:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675437191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x360pnd4Kw30rMO/NoxmH0c6n9srul/TO9o/LEP2+A8=;
        b=Xyrtq+x4zZ93DxeQ0H1W0jGk12HmdRGEe/i+sxu1Hu15EdY2y7+b66A8361NIX2lPJkrjV
        W+FbSVQBxbH+SEuKa1htiQhmSh3CPWjU7N0CpgcyynXmHPcac7LZUReko7O0FHO111svHL
        W809kHRmoAdHCEJvRgaR28NeSkGzwZc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-zLcUkMdcOVCU3jKihokClA-1; Fri, 03 Feb 2023 10:13:08 -0500
X-MC-Unique: zLcUkMdcOVCU3jKihokClA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E123A181B7D3;
        Fri,  3 Feb 2023 15:13:06 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E19D112132C;
        Fri,  3 Feb 2023 15:13:06 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: Re: git regression failures with v6.2-rc NFS client
Date:   Fri, 03 Feb 2023 10:13:04 -0500
Message-ID: <44CB1E86-60E0-4CF0-9FD4-BB7E446542B7@redhat.com>
In-Reply-To: <B90C62F2-1D3A-40E0-8E33-8C349C6FFD3D@oracle.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
 <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
 <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com>
 <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com>
 <B90C62F2-1D3A-40E0-8E33-8C349C6FFD3D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3 Feb 2023, at 9:38, Chuck Lever III wrote:

>> On Feb 1, 2023, at 10:53 AM, Benjamin Coddington <bcodding@redhat.com>=
 wrote:
>>
>> On 1 Feb 2023, at 9:10, Benjamin Coddington wrote:
>>>
>>> Working on a fix..
>>
>> .. actually, I have no idea how to fix this - if tmpfs is going to mod=
ify
>> the position of its dentries, I can't think of a way for the client to=
 loop
>> through getdents() and remove every file reliably.
>>
>> The patch you bisected into just makes this happen on directories with=
 18
>> entries instead of 127 which can be verified by changing COUNT in the
>> reproducer.
>>
>> As Trond pointed out in:
>> https://lore.kernel.org/all/eb2a551096bb3537a9de7091d203e0cbff8dc6be.c=
amel@hammerspace.com/
>>
>>    POSIX states very explicitly that if you're making changes to the
>>    directory after the call to opendir() or rewinddir(), then the
>>    behaviour w.r.t. whether that file appears in the readdir() call is=

>>    unspecified. See
>>    https://pubs.opengroup.org/onlinepubs/9699919799/functions/readdir.=
html
>>
>> The issue here is not quite the same though, we unlink the first batch=
 of
>> entries, then do a second getdents(), which returns zero entries even =
though
>> some still exist.  I don't think POSIX talks about this case directly.=

>>
>> I guess the question now is if we need to drop the "ls -l" improvement=

>> because after it we are going to see this behavior on directories with=
 >17
>> entiries instead of >127 entries.
>
> I don't have any suggestions about how to fix your optimization.

I wasn't trying to fix it.  I was trying to fix your testing setup.

> Technically I think this counts as a regression; Thorsten seems
> to agree with that opinion. It's late in the cycle, so it is
> appropriate to consider reverting 85aa8ddc3818 and trying again
> in v6.3 or v6.4.

Thorsten's bot is just scraping your regression report email, I doubt
they've carefully read this thread.

>> It should be possible to make tmpfs (and friends) generate reliable co=
okies
>> by doing something like hashing out the cursor->d_child into the cooki=
e
>> space.. (waving hands)
>
> Sure, but what if there are non-Linux NFS-exported filesystems
> that behave this way?

Then they would display this same behavior, and claiming it is a server b=
ug
might be defensible position.

The reality as I understand it is that if the server is going to change t=
he
cookie or offset of the dentries in between calls to READDIR, you're neve=
r
going to reliably be able to list the directory completely.  Or maybe we
can, but at least I can't think of any way it can be done.

You can ask Trond/Anna to revert this, but that's only going to fix your
test setup.  The behavior you're claiming is a regression is still there =
-
just at a later offset.

Or we can modify the server to make tmpfs and friends generate stable
cookies/offsets.

Or we can patch git so that it doesn't assume it can walk a directory
completely while simultaneously modifying it.

What do you think?

Ben

