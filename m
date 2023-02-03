Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF43968A013
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Feb 2023 18:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjBCRPM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Feb 2023 12:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjBCRPC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Feb 2023 12:15:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4FE1420B
        for <linux-nfs@vger.kernel.org>; Fri,  3 Feb 2023 09:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675444451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KK80aqkXw+0O7Kx5PPM7DwANDocHssLSWrn46OIJzE0=;
        b=gaGe2nDbc8HnMs2VEeTKZdLbnb0KNXvTZpbcvMNPzYTu1wnERCNNAHiUOH9nf6iBiDg8gi
        9ONOqpaYGi7aQnJ6LD1pQbZqNW0CzArbLF9VB9FJW/9TCTZ2liE0jfXoVrfPzw7n5t4fQj
        gEwEI1164GtyqqYjli3Y/gxvNktrbbk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-Etbr-iHgMzO9K9x3rRmceQ-1; Fri, 03 Feb 2023 12:14:08 -0500
X-MC-Unique: Etbr-iHgMzO9K9x3rRmceQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D7F329AB44A;
        Fri,  3 Feb 2023 17:14:07 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2BAF404CD80;
        Fri,  3 Feb 2023 17:14:06 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: Re: git regression failures with v6.2-rc NFS client
Date:   Fri, 03 Feb 2023 12:14:05 -0500
Message-ID: <41813D21-95C8-44E3-BB97-1E9C03CE7FE5@redhat.com>
In-Reply-To: <1AAC6854-2591-4B21-952A-BC58180B4091@oracle.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
 <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
 <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com>
 <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com>
 <B90C62F2-1D3A-40E0-8E33-8C349C6FFD3D@oracle.com>
 <44CB1E86-60E0-4CF0-9FD4-BB7E446542B7@redhat.com>
 <1AAC6854-2591-4B21-952A-BC58180B4091@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3 Feb 2023, at 10:35, Chuck Lever III wrote:

>> On Feb 3, 2023, at 10:13 AM, Benjamin Coddington <bcodding@redhat.com>=
 wrote:
>>
>> On 3 Feb 2023, at 9:38, Chuck Lever III wrote:
>>
>>>> On Feb 1, 2023, at 10:53 AM, Benjamin Coddington <bcodding@redhat.co=
m> wrote:
>>>>
>>>> On 1 Feb 2023, at 9:10, Benjamin Coddington wrote:
>>>>>
>>>>> Working on a fix..
>>>>
>>>> .. actually, I have no idea how to fix this - if tmpfs is going to m=
odify
>>>> the position of its dentries, I can't think of a way for the client =
to loop
>>>> through getdents() and remove every file reliably.
>>>>
>>>> The patch you bisected into just makes this happen on directories wi=
th 18
>>>> entries instead of 127 which can be verified by changing COUNT in th=
e
>>>> reproducer.
>>>>
>>>> As Trond pointed out in:
>>>> https://lore.kernel.org/all/eb2a551096bb3537a9de7091d203e0cbff8dc6be=
=2Ecamel@hammerspace.com/
>>>>
>>>>   POSIX states very explicitly that if you're making changes to the
>>>>   directory after the call to opendir() or rewinddir(), then the
>>>>   behaviour w.r.t. whether that file appears in the readdir() call i=
s
>>>>   unspecified. See
>>>>   https://pubs.opengroup.org/onlinepubs/9699919799/functions/readdir=
=2Ehtml
>>>>
>>>> The issue here is not quite the same though, we unlink the first bat=
ch of
>>>> entries, then do a second getdents(), which returns zero entries eve=
n though
>>>> some still exist.  I don't think POSIX talks about this case directl=
y.
>>>>
>>>> I guess the question now is if we need to drop the "ls -l" improveme=
nt
>>>> because after it we are going to see this behavior on directories wi=
th >17
>>>> entiries instead of >127 entries.
>>>
>>> I don't have any suggestions about how to fix your optimization.
>>
>> I wasn't trying to fix it.  I was trying to fix your testing setup.
>>
>>> Technically I think this counts as a regression; Thorsten seems
>>> to agree with that opinion. It's late in the cycle, so it is
>>> appropriate to consider reverting 85aa8ddc3818 and trying again
>>> in v6.3 or v6.4.
>>
>> Thorsten's bot is just scraping your regression report email, I doubt
>> they've carefully read this thread.
>>
>>>> It should be possible to make tmpfs (and friends) generate reliable =
cookies
>>>> by doing something like hashing out the cursor->d_child into the coo=
kie
>>>> space.. (waving hands)
>>>
>>> Sure, but what if there are non-Linux NFS-exported filesystems
>>> that behave this way?
>>
>> Then they would display this same behavior, and claiming it is a serve=
r bug
>> might be defensible position.
>
> It's a server bug if we can cite something (perhaps less confusing
> and more on-point than the POSIX specification) that says READDIR
> cookies aren't supposed to behave this way. I bet the tmpfs folks
> are going to want to see that kind of mandate before allowing a
> code change.

I don't have other stuff to cite for you.  All I have is POSIX, and the m=
any
discussions we've had on the linux-nfs list in the past.

> I'm wondering if you can trigger the same behavior when running
> directly on tmpfs?

Not in the same way, because libfs keeps a cursor in the open directory
context, but knfsd has to do a seekdir between replies to READDIR.  So, i=
f
you do what the git test is doing locally, it works locally.

The git test is doing:

opendir
while (getdents)
    unlink(dentries)
close dir
rmdir <- ENOTEMPTY on NFS

If you have NFS in the middle of that, knfsd tries to do a seekdir to a
position (the cookie/offset sent in the /last/ READDIR results).  In that=

case, yes - tmpfs would display the same behavior, but locally to tmpfs t=
hat
looks like:

opendir
getdents
closedir
unlink,unlink,unlink
opendir
seekdir to next batch
getdents <- no dentries (they all shifted positions)
rmdir <- ENOTEMPTY

The other way to think about this is that on a local system, there's stat=
e
saved in the open dir file structure between calls to getdents().  With
knfsd in the middle, you lose that state when you close the directory and=

have to do seekdir instead, which means you're not guaranteed to be in th=
e
same place in the directory stream.

>> The reality as I understand it is that if the server is going to chang=
e the
>> cookie or offset of the dentries in between calls to READDIR, you're n=
ever
>> going to reliably be able to list the directory completely.  Or maybe =
we
>> can, but at least I can't think of any way it can be done.
>>
>> You can ask Trond/Anna to revert this, but that's only going to fix yo=
ur
>> test setup.  The behavior you're claiming is a regression is still the=
re -
>> just at a later offset.
>
> No-one is complaining about the existing situation, which
> suggests this is currently only a latent bug, and harmless in
> practice. This is a regression because your optimization exposes
> the misbehavior to more common workloads.

Its not a latent bug - the incorrect readdir behavior of tmpfs has been
analyzed and discussed on this list, have a look.

> Even if this is a server bug, the guidelines about not
> introducing behavior regressions mean we have to stick with
> the current client side behavior until the server side part
> of the issue has been corrected.
>
>
>> Or we can modify the server to make tmpfs and friends generate stable
>> cookies/offsets.
>>
>> Or we can patch git so that it doesn't assume it can walk a directory
>> completely while simultaneously modifying it.
>
> I'm guessing that is something that other workloads might
> do, so fixing git is not going to solve the issue. And also,
> the test works fine on other filesystem types, so it's not
> git that is the problem.
>
>
>> What do you think?
>
> IMO, since the situation is not easy or not possible to fix,
> you should revert 85aa8ddc3818 for v6.2 and work on fixing
> tmpfs first.
>
> It's going to have to be a backportable fix because your
> optimization will break with any Linux server exporting an
> unfixed tmpfs.

Exports of tmpfs on linux are already broken and seem to always have been=
=2E
I spent a great deal of time making points about it and arguing that the
client should try to work around them, and ultimately was told exactly th=
is:
https://lore.kernel.org/linux-nfs/a9411640329ed06dd7306bbdbdf251097c5e341=
1.camel@hammerspace.com/

The optimization you'd like to revert fixes a performance regression on
workloads across exports of all filesystems.  This is a fix we've had man=
y
folks asking for repeatedly.  I hope the maintainers decide not to revert=

it, and that we can also find a way to make readdir work reliably on tmpf=
s.

Ben

