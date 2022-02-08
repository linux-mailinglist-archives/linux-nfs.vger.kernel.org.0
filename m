Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C044ADB24
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 15:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351137AbiBHO3b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 09:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiBHO3a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 09:29:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C3FBC03FECE
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 06:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644330568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDzGuYRYGhc7Fww18iJs/PDOkjuSuQqtODqQF0jZe1M=;
        b=YFaf0cTGvKNchhpU1sHArGMcNyQ4C1Nf1/8shmH7ovy0tp/9R5RzUz+Qe4hpdhtJGsGjtL
        JNF+veBehuimqMnla9bo524I6UnWl65eqQdlZwWNVrFegyNzLI6WqjzPrgVsHcDtp1EAve
        OGTEplmvTs2JtqEO+mcORekEJE/CRSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-PiAsMJauPi-v5QdY3dApNQ-1; Tue, 08 Feb 2022 09:29:24 -0500
X-MC-Unique: PiAsMJauPi-v5QdY3dApNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C187D1091DA0;
        Tue,  8 Feb 2022 14:29:23 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4674B7C141;
        Tue,  8 Feb 2022 14:29:22 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Date:   Tue, 08 Feb 2022 09:29:21 -0500
Message-ID: <CEC36879-0474-44A1-984B-BAE69C168274@redhat.com>
In-Reply-To: <c9948f895e91abb76a21609bf629b88bbfcf4d9a.camel@hammerspace.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
 <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
 <439C77F9-D5AD-4388-B954-3B413C1DF0E2@redhat.com>
 <596C2475-76AA-4616-919C-9C22B6658CA7@redhat.com>
 <DB8B60C8-B772-4604-A841-47F789723D5D@oracle.com>
 <b192022ce73ea690a117d7710b492e83be99df31.camel@hammerspace.com>
 <43990B9C-013C-4E77-AADA-F274ACBE4757@oracle.com>
 <8CCCD806-A467-432C-B7FF-9E83981533EF@redhat.com>
 <c9948f895e91abb76a21609bf629b88bbfcf4d9a.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8 Feb 2022, at 8:45, Trond Myklebust wrote:

> On Tue, 2022-02-08 at 06:32 -0500, Benjamin Coddington wrote:
>> On 7 Feb 2022, at 18:59, Chuck Lever III wrote:
>>
>>>> On Feb 7, 2022, at 2:38 PM, Trond Myklebust
>>>> <trondmy@hammerspace.com>
>>>> wrote:
>>>>
>>>> On Mon, 2022-02-07 at 15:49 +0000, Chuck Lever III wrote:
>>>>>
>>>>>
>>>>>> On Feb 7, 2022, at 9:05 AM, Benjamin Coddington
>>>>>> <bcodding@redhat.com> wrote:
>>>>>>
>>>>>> On 5 Feb 2022, at 14:50, Benjamin Coddington wrote:
>>>>>>
>>>>>>> On 5 Feb 2022, at 13:24, Trond Myklebust wrote:
>>>>>>>
>>>>>>>> On Sat, 2022-02-05 at 10:03 -0500, Benjamin Coddington
>>>>>>>> wrote:
>>>>>>>>> Hi all,
>>>>>>>>>
>>>>>>>>> Is anyone using a udev(-like) implementation with
>>>>>>>>> NETLINK_LISTEN_ALL_NSID?
>>>>>>>>> It looks like that is at least necessary to allow the
>>>>>>>>> init
>>>>>>>>> namespaced
>>>>>>>>> udev
>>>>>>>>> to receive notifications on
>>>>>>>>> /sys/fs/nfs/net/nfs_client/identifier,
>>>>>>>>> which
>>>>>>>>> would be a pre-req to automatically uniquify in
>>>>>>>>> containers.
>>>>>>>>>
>>>>>>>>> I'md interested since it will inform whether I need to
>>>>>>>>> send
>>>>>>>>> patches
>>>>>>>>> to
>>>>>>>>> systemd's udev, and potentially open the can of worms
>>>>>>>>> over
>>>>>>>>> there.
>>>>>>>>> Yet its
>>>>>>>>> not yet clear to me how an init namespaced udev process
>>>>>>>>> can
>>>>>>>>> write to
>>>>>>>>> a netns
>>>>>>>>> sysfs path.
>>>>>>>>>
>>>>>>>>> Another option might be to create yet another
>>>>>>>>> daemon/tool
>>>>>>>>> that would
>>>>>>>>> listen
>>>>>>>>> specifically for these notifications.  Ugh.
>>>>>>>>>
>>>>>>>>> Ben
>>>>>>>>>
>>>>>>>>
>>>>>>>> I don't understand. Why do you need a new daemon/tool?
>>>>>>
>>>>>> Because what we've got only works for the init namespace.
>>>>>>
>>>>>> Udev won't get kobject notifications because its not using
>>>>>> NETLINK_LISTEN_ALL_NSIDs.
>>>>>>
>>>>>> We need to figure out if we want:
>>>>>>
>>>>>> 1) the init namespace udevd to handle all client_id
>>>>>> uniquifiers
>>>>>> 2) we expect network namespaces to run their own udevd
>>>>>> 3) or both.
>>>>>>
>>>>>> I think 2 violates "least surprise", and 3 might not be
>>>>>> something
>>>>>> anyone
>>>>>> ever wants.  If they do, we can fix it at that point.
>>>>>>
>>>>>> So to make 1 work, we can try to change udevd, or maybe just
>>>>>> hacking about
>>>>>> with nfs_netns_object_child_ns_type will be sufficient.
>>>>>
>>>>> I agree that 1 seems like the preferred approach, though
>>>>> I don't have a technical suggestion at this point.
>>>>>
>>>>
>>>> I strongly disagree. (1) requires the init namespace to have
>>>> intimate
>>>> knowledge of container internals.
>>
>> Not really, we're just distinguishing NFS clients in containers from
>> NFS
>> clients on the host.  That doesn't require intimate knowledge, only a
>> mechanism to create a unique value per-container.
>>
>>>> Why do we need to make that a requirement? That violates the
>>>> expectation
>>>> that containers are stateless by default, and also the
>>>> expectation
>>>> that
>>>> they operate independently of the environment.
>>
>> I'm not familiar with the expectation that containers are stateless
>> by
>> default, or that they operate independently of the environment.
>>
>
> Put differently: do you expect QEMU/KVM and VMware ESX to have to know
> a priori that a VM is going to use NFSv4, and force them to have to
> modify the VM state accordingly? No, of course not. So why do you think
> this is a good idea for containers?

Well, I don't think /that's/ a good idea, no, but I don't think the
comparison is valid.  I wouldn't equate containers with VMs when it comes to
configuration or state because VMs attempt to create a nearly isolated
processing environment, while containers or namespaces are a complete
mish-mash of objects, state, and paradigms.  A lot of what happens in a
particular set of namespaces can happen and affect objects in init too.

The immediate example is the very problem we're trying to fix: nfs clients in
netns can disrupt/reclaim state from the init namespace client.

> This is exactly the problem with the keyring upcall mechanism, and why
> it is completely useless on a modern system. It relies on the top level
> knowing what the containers are doing and how they are configured.

We're actually talking over this problem while working TLS, and I agree that
keyrings need changes to allow userspace callouts to be "routed", and that
configuration must come from within the containers.  And lacking a container
taking responsibility for it, it is up to the host to do something sane.

> Imagine if you want to nest containers (yes, people do that - just
> Google "nested docker containers"). Your top level process would have
> to know not just how the first level of containers is configured
> (network details, user mappings, ...), but also details about how the
> child containers, that it is not directly managing, are configured.
> It's just not practical.

Oh yeah, I know all about it.  Its quite a mess, and every subsystem that
has to account for all of this does it a little differently.

>> Can't we just uniquify the namespaced NFS client ourselves, while
>> still
>> exposing /sys/fs/nfs/net/nfs_client/identifier within the namespace? 
>> That
>> way if someone want to run udev or use their own method of persistent
>> id
>> its available to them within the container so they can.  Then we can
>> move
>> forward because the problem of distinguishing clients between the
>> host
>> and
>> netns is automagically solved.
>
> That could be done.

Ok, I'm eyeballing a sha1 of the init namespace uniquifier and
peernet2id_alloc(new_net, init_net).. but means the NFS client would grow a
dependency on CRYPTO and CRYPTO_SHA1.

hm.

Ben

