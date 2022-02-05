Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46A34AAC5C
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Feb 2022 20:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiBETvE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Feb 2022 14:51:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241415AbiBETvC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Feb 2022 14:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644090661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iqhdPBrGJMzfcGa86Tjdx0q1TgnB8rdKF3/FSnu8UTs=;
        b=FdU0jeVsY+t4fHYk4yGJbvigvmDWGntA4ZOgpZz0N0dbcdE1HRpKB1VjNDG89Bs1ZSYEB5
        n42gOElN4zO8LnXP41EiUJk0yVcn4r8I/hxUYoZynF3qswOl+I3p6I9ENjxscGyIuXGViA
        hxlNvISE5VhlgDoUHOU6x5+oxOso1AI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-uXZmtSD5PBS_p8DZJmCyrQ-1; Sat, 05 Feb 2022 14:50:58 -0500
X-MC-Unique: uXZmtSD5PBS_p8DZJmCyrQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62EC08519E0;
        Sat,  5 Feb 2022 19:50:57 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 111E09329;
        Sat,  5 Feb 2022 19:50:56 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Date:   Sat, 05 Feb 2022 14:50:55 -0500
Message-ID: <439C77F9-D5AD-4388-B954-3B413C1DF0E2@redhat.com>
In-Reply-To: <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
 <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5 Feb 2022, at 13:24, Trond Myklebust wrote:

> On Sat, 2022-02-05 at 10:03 -0500, Benjamin Coddington wrote:
>> Hi all,
>>
>> Is anyone using a udev(-like) implementation with
>> NETLINK_LISTEN_ALL_NSID?
>> It looks like that is at least necessary to allow the init namespaced
>> udev
>> to receive notifications on /sys/fs/nfs/net/nfs_client/identifier,
>> which
>> would be a pre-req to automatically uniquify in containers.
>>
>> I'md interested since it will inform whether I need to send patches
>> to
>> systemd's udev, and potentially open the can of worms over there. 
>> Yet its
>> not yet clear to me how an init namespaced udev process can write to
>> a netns
>> sysfs path.
>>
>> Another option might be to create yet another daemon/tool that would
>> listen
>> specifically for these notifications.  Ugh.
>>
>> Ben
>>
>
> I don't understand. Why do you need a new daemon/tool?
>
> I have the following entry in /etc/udev/rules.d:
>
> [trondmy@leira ~]$ cat /etc/udev/rules.d/50-nfs4.rules
> ACTION=="add" KERNEL=="nfs_client" ATTR{identifier}=="(null)" 
> PROGRAM="/usr/sbin/nfs4_uuid" ATTR{identifier}="%c"
>
>
> ...and a very simple script /usr/sbin/nfs4_uuid that reads as follows:
>
> #!/bin/bash
> #
> if [ ! -f /etc/nfs4_uuid ]
> then
>         uuid="$(uuidgen -r)"
>         echo -n ${uuid} > /etc/nfs4_uuid
> else
>         uuid="$(cat /etc/nfs4_uuid)"
> fi
> echo ${uuid}


We're in the same place, but what I see is that when I create a new 
network
namespace with:

ip netns add testnamespace

Everything in the kernel works up to the point where the userspace udevd
never gets a notification.  I suspect thats because it hasn't used
NETLINK_LISTEN_ALL_NSID, so the kernel's skipping the notification in
do_one_broadcast().

If your udev is getting notified of new network namespaces and firing 
that
rule each time, something's different between our setups, and I'd like 
to
figure out what it might be.

Ben

