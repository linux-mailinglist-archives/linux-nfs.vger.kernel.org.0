Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4734AD7B6
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 12:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbiBHLnH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 06:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239267AbiBHLmi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 06:42:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76CB3C0048ED
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 03:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644319936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9jC9+GYSPVfq+Ywa/kJQh041R3s3Vv/VpETwC7fkEJ0=;
        b=Nw9UlDeeA1qhcBt5Clk91mCv4vSBWquigBKIzO1QIvgdm1Xc6F02m8Aplz4xfXhc/Yh+Gr
        J4QsXRfTK1PPH3gx6AXlgbCaj1wu+K2/q31YmAqU685+aM7Sm7iW8Sj9e1fyxzZhrRR70N
        lZF+5tqSlBwWMtMjMqq17JSjVdHW7MA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-bGXpQ_AGMpSpsnYKUM2-Vg-1; Tue, 08 Feb 2022 06:32:12 -0500
X-MC-Unique: bGXpQ_AGMpSpsnYKUM2-Vg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 871A92E69;
        Tue,  8 Feb 2022 11:32:11 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E58687B022;
        Tue,  8 Feb 2022 11:32:10 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Date:   Tue, 08 Feb 2022 06:32:09 -0500
Message-ID: <8CCCD806-A467-432C-B7FF-9E83981533EF@redhat.com>
In-Reply-To: <43990B9C-013C-4E77-AADA-F274ACBE4757@oracle.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
 <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
 <439C77F9-D5AD-4388-B954-3B413C1DF0E2@redhat.com>
 <596C2475-76AA-4616-919C-9C22B6658CA7@redhat.com>
 <DB8B60C8-B772-4604-A841-47F789723D5D@oracle.com>
 <b192022ce73ea690a117d7710b492e83be99df31.camel@hammerspace.com>
 <43990B9C-013C-4E77-AADA-F274ACBE4757@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7 Feb 2022, at 18:59, Chuck Lever III wrote:

>> On Feb 7, 2022, at 2:38 PM, Trond Myklebust <trondmy@hammerspace.com> 
>> wrote:
>>
>> On Mon, 2022-02-07 at 15:49 +0000, Chuck Lever III wrote:
>>>
>>>
>>>> On Feb 7, 2022, at 9:05 AM, Benjamin Coddington
>>>> <bcodding@redhat.com> wrote:
>>>>
>>>> On 5 Feb 2022, at 14:50, Benjamin Coddington wrote:
>>>>
>>>>> On 5 Feb 2022, at 13:24, Trond Myklebust wrote:
>>>>>
>>>>>> On Sat, 2022-02-05 at 10:03 -0500, Benjamin Coddington wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> Is anyone using a udev(-like) implementation with
>>>>>>> NETLINK_LISTEN_ALL_NSID?
>>>>>>> It looks like that is at least necessary to allow the init
>>>>>>> namespaced
>>>>>>> udev
>>>>>>> to receive notifications on
>>>>>>> /sys/fs/nfs/net/nfs_client/identifier,
>>>>>>> which
>>>>>>> would be a pre-req to automatically uniquify in containers.
>>>>>>>
>>>>>>> I'md interested since it will inform whether I need to send
>>>>>>> patches
>>>>>>> to
>>>>>>> systemd's udev, and potentially open the can of worms over
>>>>>>> there.
>>>>>>> Yet its
>>>>>>> not yet clear to me how an init namespaced udev process can
>>>>>>> write to
>>>>>>> a netns
>>>>>>> sysfs path.
>>>>>>>
>>>>>>> Another option might be to create yet another daemon/tool
>>>>>>> that would
>>>>>>> listen
>>>>>>> specifically for these notifications.  Ugh.
>>>>>>>
>>>>>>> Ben
>>>>>>>
>>>>>>
>>>>>> I don't understand. Why do you need a new daemon/tool?
>>>>
>>>> Because what we've got only works for the init namespace.
>>>>
>>>> Udev won't get kobject notifications because its not using
>>>> NETLINK_LISTEN_ALL_NSIDs.
>>>>
>>>> We need to figure out if we want:
>>>>
>>>> 1) the init namespace udevd to handle all client_id uniquifiers
>>>> 2) we expect network namespaces to run their own udevd
>>>> 3) or both.
>>>>
>>>> I think 2 violates "least surprise", and 3 might not be something
>>>> anyone
>>>> ever wants.  If they do, we can fix it at that point.
>>>>
>>>> So to make 1 work, we can try to change udevd, or maybe just
>>>> hacking about
>>>> with nfs_netns_object_child_ns_type will be sufficient.
>>>
>>> I agree that 1 seems like the preferred approach, though
>>> I don't have a technical suggestion at this point.
>>>
>>
>> I strongly disagree. (1) requires the init namespace to have intimate
>> knowledge of container internals.

Not really, we're just distinguishing NFS clients in containers from NFS
clients on the host.  That doesn't require intimate knowledge, only a
mechanism to create a unique value per-container.

>> Why do we need to make that a requirement? That violates the 
>> expectation
>> that containers are stateless by default, and also the expectation 
>> that
>> they operate independently of the environment.

I'm not familiar with the expectation that containers are stateless by
default, or that they operate independently of the environment.

>> If you really do want external control over the uuid that is set, 
>> then
>> it should be pretty trivial to do so by using the standard container
>> tools for manipulating the namespace (e.g. to mount a file that is
>> under control of the parent as /etc/nfs4-uuid.conf or whatever).

We're not looking for external control, just automation.  The NFS 
community
has decided that udev is the way to go here, so as long as we can get 
the
notifications to /some/ udev process, I feel confident we can make all 
of
this transparent.

The less we have to teach all the container tooling folks, the better 
for us.

>> However in most cases that I can think of, if the container is doing
>> its own NFS mounting, then it is going to have to be set up with its
>> own nfs-utils, etc, so there is no reason why we can't also require
>> udev.

I'm not as confident about this as you are.  Network namespaces are 
pretty
useful on their own to create independent network configurations or to
isolate hardware interfaces.  We've had a few surprising cases of 
customers
using them in creative ways.

There's a bit of a chicken and egg problem with 2, though.  If the nfs
module is loaded, the kernel notification gets sent as soon as you 
create
the namespace.  Its not going to wait for you to move or exec udev into 
that
network namespace, and the notification is lost.

Can't we just uniquify the namespaced NFS client ourselves, while still
exposing /sys/fs/nfs/net/nfs_client/identifier within the namespace?  
That
way if someone want to run udev or use their own method of persistent id
its available to them within the container so they can.  Then we can 
move
forward because the problem of distinguishing clients between the host 
and
netns is automagically solved.

Where we are today is the host NFS client is uniquified, and all the 
netns
clients are distinguished from the host, but not eachother.

Ben

