Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336A64AC110
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 15:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357412AbiBGOVN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 09:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390891AbiBGOFQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 09:05:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D4E2C0401C0
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 06:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644242714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A2/fmerVPt7y2ERI1So+E+crT6TP6+7VOIkGaD46kU4=;
        b=QltT3wq/0rLrwwhB6I6fQEdnP0PVaq7CO6zDP9LZO75DblDzYnaGsQxmb083MobQeywQkR
        u5LG47iA0i92SjKJyYEV9CPg/FHVYBhH/kgxAoS/5YOVhvFiVj5QU4E8v412jIw1t8DRN9
        gpM4trLliVS63SEO2RW7gWA2l3Rw9/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-gKD3qXVYMLSCEaPZmyKpAA-1; Mon, 07 Feb 2022 09:05:13 -0500
X-MC-Unique: gKD3qXVYMLSCEaPZmyKpAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12F3A18A083B;
        Mon,  7 Feb 2022 14:05:12 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8F1F5BC47;
        Mon,  7 Feb 2022 14:05:11 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Date:   Mon, 07 Feb 2022 09:05:10 -0500
Message-ID: <596C2475-76AA-4616-919C-9C22B6658CA7@redhat.com>
In-Reply-To: <439C77F9-D5AD-4388-B954-3B413C1DF0E2@redhat.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
 <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
 <439C77F9-D5AD-4388-B954-3B413C1DF0E2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

On 5 Feb 2022, at 14:50, Benjamin Coddington wrote:

> On 5 Feb 2022, at 13:24, Trond Myklebust wrote:
>
>> On Sat, 2022-02-05 at 10:03 -0500, Benjamin Coddington wrote:
>>> Hi all,
>>>
>>> Is anyone using a udev(-like) implementation with
>>> NETLINK_LISTEN_ALL_NSID?
>>> It looks like that is at least necessary to allow the init namespaced
>>> udev
>>> to receive notifications on /sys/fs/nfs/net/nfs_client/identifier,
>>> which
>>> would be a pre-req to automatically uniquify in containers.
>>>
>>> I'md interested since it will inform whether I need to send patches
>>> to
>>> systemd's udev, and potentially open the can of worms over there. 
>>> Yet its
>>> not yet clear to me how an init namespaced udev process can write to
>>> a netns
>>> sysfs path.
>>>
>>> Another option might be to create yet another daemon/tool that would
>>> listen
>>> specifically for these notifications.  Ugh.
>>>
>>> Ben
>>>
>>
>> I don't understand. Why do you need a new daemon/tool?

Because what we've got only works for the init namespace.

Udev won't get kobject notifications because its not using
NETLINK_LISTEN_ALL_NSIDs.

We need to figure out if we want:

 1) the init namespace udevd to handle all client_id uniquifiers
 2) we expect network namespaces to run their own udevd
 3) or both.

I think 2 violates "least surprise", and 3 might not be something anyone
ever wants.  If they do, we can fix it at that point.

So to make 1 work, we can try to change udevd, or maybe just hacking about
with nfs_netns_object_child_ns_type will be sufficient.

Ben

