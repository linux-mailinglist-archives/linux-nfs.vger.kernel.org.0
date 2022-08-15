Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E2B593636
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Aug 2022 21:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiHOSbd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Aug 2022 14:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243420AbiHOSbE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Aug 2022 14:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A7F332B90
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660587610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=14T/FRfxxDhhPT152UDm6TPLMfuhHh/WTvay4b7USlQ=;
        b=drmcOHWzOL6oGvBp7ztOIAxSV+Kjlz/FfOnXZsVaFCB1puaZ23vXxpe6PoXTeoUMdd3boj
        eU/TzrG9kmOm2h8cJe9ANwgerhAZSMRUGDT61pyE9TETAh2daHDU0BNSaFXa8faaCpz3aB
        wzJWMR8fZf47VrysaET7uk87PKN/fnI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-R8Xsew6iOh2WzvwTR5AEHg-1; Mon, 15 Aug 2022 14:20:09 -0400
X-MC-Unique: R8Xsew6iOh2WzvwTR5AEHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F05785A584;
        Mon, 15 Aug 2022 18:20:08 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 031A61121315;
        Mon, 15 Aug 2022 18:20:07 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "DANIEL K FORREST" <dforrest@wisc.edu>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: Strange NFS file glob behavior
Date:   Mon, 15 Aug 2022 13:57:31 -0400
Message-ID: <55BB3764-5182-4310-8F7C-F652AB293FF7@redhat.com>
In-Reply-To: <20220809171148.om46ypyfnorjys2m@cosmos.ssec.wisc.edu>
References: <20220809011700.bdiikqngwmxp3abf@cosmos.ssec.wisc.edu>
 <b5d62b32edcd3c0df17382a3442c5580ad2c9196.camel@kernel.org>
 <20220809171148.om46ypyfnorjys2m@cosmos.ssec.wisc.edu>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9 Aug 2022, at 13:11, DANIEL K FORREST wrote:

> Jeff,
>
> Thanks for your comments.  More in-line...
>
> On Tue, Aug 09, 2022 at 09:49:59AM -0400, Jeff Layton wrote:
>> On Tue, 2022-08-09 at 01:17 +0000, DANIEL K FORREST wrote:
>>> I am seeing a strange glob behavior on NFS that I can't explain.
>>>
>>> The server has 16 files, foo/bar{01..16}.
>>>
>>> There are other files in foo/, and there are many other processes on
>>> the client accessing files in the directory, but the mount is readonly
>>> so the only create/delete activity is on the server, and it's all
>>> rsync, so create file and rename file, but no file deletions.
>>>
>>>
>>> When the 16th file is created (random order) processing is triggered
>>> by a message from a different host that is running the rsyncs.
>>>
>>> On the client, I run this command:
>>>
>>> $ stat -c'%z %n' foo/bar{01..16}
>>>
>>> And I see all 16 files.
>>>
>>> However, if I immediately follow that command with:
>>>
>>> $ stat -c'%z %n' foo/bar*
>>>
>>
>> You may want to look at an strace of the shell, and see if it's doing
>> anything different at the syscall level in these two cases.
>>
>
> I had the same question, so I did that already.  The shell is indeed
> calling readdir.
>
>>> On rare occasions I see fewer than 16 files.
>>>
>>> The missing files are the ones most recently created, they can be seen
>>> by stat when explicitly enumerated, but the shell glob does not see
>>> all of the files.  This test is for verifying a problem with a program
>>> that is also sometimes not seeing files using readdir/glob.
>>>
>>>
>>> How can all 16 files be seen by stat, but not by readdir/glob?
>>>
>>>
>>> OS is CentOS 7.9.2009, 3.10.0-1127.19.1.el7.x86_64
>>> NFS mount is version 3, readonly, nordirplus, lookupcache=pos
>>>
>>>
>>
>> It'd be hard to say without doing deeper analysis, but in order to
>> process a glob, the shell has to issue one or more readdir() calls.
>> Those calls can be split into more than one READDIR RPC on the network
>> as well.
>>
>> There is no guarantee that between each READDIR you issue that the
>> directory remains constant. It's easily possible to issue a readdir for
>> the first chunk of dentries, and then have a file that's in a later
>> chunk get renamed so that it's in that chunk.
>>
>
> In this case, the files are created and then the directory is dormant
> for a number of minutes.  Repeated glob operations continue to not see
> all of the files until the next set of files are created.
>
>> You're also using v3. The timestamps on most Linux servers have a
>> granularity of a jiffy (~1ms). If multiple directory operations happen
>> within the same jiffy then the timestamp on the directory might not
>> appear to have changed even though some of its children had been
>> renamed. You may want to consider using v4 just to get the benefit of
>> its better cache coherency.
>>
>
> I think this is getting to the heart of the problem.  The underlying
> filesystem has a granularity of 1s and it is becoming clear what you
> are suggesting is the root cause.
>
> I have tried v4 without success, the symptoms persist.
>
>> Given that you know what the files are named, you're probably better off
>> not using shell globs at all here. Just provide all of the file names on
>> the command line (like in your first example) and you avoid READDIR
>> activity altogether.
>
> For test purposes, I know the files names.  In general, the names have
> a known prefix, but are otherwise unknown.  A glob is required.
>
> What I need is a way to invalidate the lookup cache, but that seems to
> require there be a change in the directory timestamp.  I tried setting
> lookupcache=none, but the performance made it unusable.

I think you should try setting a low value for acdirmax= instead.

> It still seems odd that stat-ing the files individually doesn't get
> them into the lookup cache.  It seems to be only when a readdir is
> issued and the directory timestamp is seen to have changed.

The contents of the directory are cached separately from the dentry cache,
and may not always be in perfect sync.

Even with a 1 second granularity, the behavior you're describing still hints
at a revalidation bug that may exist on that era kernel.  There have been a
number of subtle bugs in this area fixed over the years, and a newer client
might not exhibit this issue.

Ben

