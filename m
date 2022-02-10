Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FBF4B0D8D
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 13:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbiBJMZp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Feb 2022 07:25:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbiBJMZo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Feb 2022 07:25:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FD3E116E
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 04:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644495945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbhN5+P9dEIR4FVhVhSSgBHum1P3LKsCU/Boux+yiUs=;
        b=iKZmHbIFBj9gWX0CIVUJXHRWjLsrVchPzlR8Flih+g7sDagr8r2i1r3tEzwfcKJ3whB/UJ
        rECKdULjDrEr+7BIi8O20Ekh/hpftoC0mvQNr1eRMv8w/aHtZJ8axTjzw8W0KDVWQiPQmH
        Z7T1NwJFrUY1E7u5IV7mqslKkgVUKAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-b7Xae-jPO3OvtjRLB7k8uw-1; Thu, 10 Feb 2022 07:25:44 -0500
X-MC-Unique: b7Xae-jPO3OvtjRLB7k8uw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43C7484BA42;
        Thu, 10 Feb 2022 12:25:43 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63D4345310;
        Thu, 10 Feb 2022 12:25:42 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>, steved@redhat.com,
        linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Date:   Thu, 10 Feb 2022 07:25:41 -0500
Message-ID: <6BAAA0D0-7212-480F-9C33-DA1F656FF09F@redhat.com>
In-Reply-To: <164445109064.27779.13269022853115063257@noble.neil.brown.name>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
 <0AB20C82-6200-46E0-A76C-62345DAF8A3A@redhat.com>
 <6cfb516d-0747-a749-b310-1368a2186307@redhat.com>
 <164444169523.27779.10904328736784652852@noble.neil.brown.name>
 <39e7bba4243eb2f16d99fefb43fef6b3ff741f87.camel@hammerspace.com>
 <164445109064.27779.13269022853115063257@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9 Feb 2022, at 18:58, NeilBrown wrote:

> On Thu, 10 Feb 2022, Trond Myklebust wrote:
>> On Thu, 2022-02-10 at 08:21 +1100, NeilBrown wrote:
>>>
>>> I'm not sure if this has been explicitly answered or not, so just in
>>> case...
>>>   if "ip netns/identify" report NAME, then use /etc/netns/NAME/foo
>>>   if it fails or report nothing, use /etc/foo
>>>
>>> I think this is required whether we use nfs4-id, nfs-id, nfs-
>>> identity,
>>> nfs.conf.d/identity.conf or any other file in /etc.
>>>
>>
>> Who uses this tool, and for what? This isn't anything that the standard
>> container orchestration managers use.
>
> At a guess, I'd say it would be used by anyone who just wants to set up
> a separate network namespace, not necessarily a full "container".
>
>>
>> I'm running docker right now:
>>
>> NR_09-21:41:07 host ~ $ ls /etc/net*
>> /etc/netconfig  /etc/networks
>> NR_09-21:41:47 hosts ~ $ docker exec -it f7debc079f4e bash
>> [root@f7debc079f4e /]# ls /etc/net*
>> /etc/netconfig  /etc/networks
>> [root@f7debc079f4e /]# ip netns identify
>>
>> [root@f7debc079f4e /]#
>>
>> As you can see, neither the host nor the container have anything in
>> /etc/netns, and 'ip netns identify' is drawing a blank in both.
>>
>
> One of the original reasons given to reject the idea of using
> /etc/nfs.conf{,.d} was that is wasn't "container aware".
> I tried to find out what this might mean and discovered "ip netnfs" and
> its man page which says:
>
>    For applications that are aware of network namespaces, the convention
>    is to look for global network configuration files first in
>    /etc/netns/NAME/ then in /etc/.  For example, if you want a different
>    version of /etc/resolv.conf for a network namespace used to isolate
>    your vpn you would name it /etc/netns/myvpn/resolv.conf.
>
> Obviously containers don't *have* to follow this model.  I guess there
> is a difference between being "container aware" and being "network
> namespace aware".
>
> Presumably a full container manager (e.g.  docker) would set everything up
> so that tools don't *need* to be container aware.  When you run docker,
> do you get a separate /etc/ from the one outside of docker?  If you
> create /etc/nfs-client-identifier inside the docker container, does it
> remain private to that container?  Does it persist with the container?
>
> Possibly NFS tools don't need to check in /etc/netnfs/NAME as they could
> simply be run with "ip netns exec NAME tool args" which would set up
> /etc.  This is fine for reading config files, but doesn't necessarily
> work correctly for creating config files.
>
> Possibly the goal of having an NFS tool which automatically creates and
> persists a client identifier for the current container is not practical.
> Maybe we just document what any container-creation platform must do for
> NFS, and let them all implement that however seems best.  With the new
> random-identity-at-namespace-creation patch the cost of not doing
> anything is localised to the container

Yes, I think this is the right approach, since all the containers do it
differently.

If there's a simple way to generate and persist a uuid (a small tool to do
so), and a udev rule to move that value to the kernel, that should be
sufficient for a container to use as well as our common case with the host.
When (if?) container folks want persistent ids, We can simply say: the way
to have persistent ids is to run udev in your container with a rule just
like the one on the host.

I can't imagine a container that needs to be persistent for NFS not having
its own /etc, but if it doesn't (say only /var is writeable) the udev rule
can be modififed to send an argument to the tool to change where it stores
the id.  Another way of generating a stable uniquifier might be to just
simply specify a static value in the udev rule itself, or containers might
just come up with their own methods.

On our distro, we want to seed the client id from /etc/machine-id.

> Maybe we should just provide a tool
>    nfs-set-client-identity NAME
> The container setup code provides some "NAME" for the container which it
> is responsible for keeping persistent, and we just write it to
> /sys/fs/nfs/net/nfs_client/idenfier, possibly after hashing or whatever.

Yes, but even better than having the tool do the writing is to have udev do
it, because udev makes the problem of when and who will execute this tool go
away, and the entire process is configurable for anyone that needs to change
any part of it or use their own methods of generating/storing ids.

Ben

