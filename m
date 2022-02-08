Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ECF4AD7E0
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 12:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356994AbiBHLvF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 06:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356912AbiBHLuY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 06:50:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA7E8C033249
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 03:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644320640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=42sOIqw3jJVRTqH7VTl5wP1SVhu7QK5dVzzNtPFS6Vg=;
        b=RYdh982aEYxBXCSyyEZcOwDz6qtEtqJ7WtZRxgrtmpMgaSzD6N42zAlpehFk8HFc2JAgpb
        0tUHEXm/hbKZMjnCzZt0BKxzUTf/ArfkE9HInBdmO+UVWsYNgx9J6bVhXEE/izRdexXv0v
        l9V/FqpaxNnQPHXaJ7A06XXn5g9UQHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-GJeCiZWSP-WhQTnb9NY37A-1; Tue, 08 Feb 2022 06:43:56 -0500
X-MC-Unique: GJeCiZWSP-WhQTnb9NY37A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C17F11926DA0;
        Tue,  8 Feb 2022 11:43:55 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54CD210589D5;
        Tue,  8 Feb 2022 11:43:55 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Steve Dickson" <steved@redhat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Date:   Tue, 08 Feb 2022 06:43:54 -0500
Message-ID: <0BDE59B8-C1FE-4B04-AB89-F65AD37AA8AC@redhat.com>
In-Reply-To: <164429006120.27779.2597672223372340780@noble.neil.brown.name>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <87EAC6F6-C450-4642-A11A-55247C791D66@oracle.com>
 <32889B9A-1293-4050-8131-726042D1EAD9@redhat.com>
 <26803BBB-4F2C-4EFD-BC8D-A50A5C361E5C@oracle.com>
 <164429006120.27779.2597672223372340780@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7 Feb 2022, at 22:14, NeilBrown wrote:

> On Sat, 05 Feb 2022, Chuck Lever III wrote:
>>
>> The problem is that a network namespace (to which the persistent
>> uniquifier is attached) and an FS namespace (in which the persistent
>> uniquifier is stored) are created and managed independently.
>
> Not necessarily ....  at least: network namespaces do have visibility in
> the filesystem and you can have files that associate with a specific
> network namespace - without depending on FS namespaces.
>
> "man ip-netns" tells us that when a tool (e.g.  mount.nfs) is
> network-namespace aware, it should first look in /etc/netns/NAME/
> before looking in /etc/ for any config file.
> The tool can determine "NAME" by running "ip netns identify", but there
> is bound to library code to achieve the same effect.
> You stat /proc/self/ns/net, then readdir /run/netns and stat everything
> in there until you find something that matches /proc/self/ns/net
>
> If a container management system wants to put /etc/ elsewhere, it can
> doubtlessly install a symlink in /etc/netns/NAME, and as this is an
> established standard, it seems likely that they already do.
>
> So: enhance nfs-utils config code to (optionally) look in
> /etc/netns/NAME first (or maybe last if they are to override) , and
> store the identity in /etc/{netns/NAME/}nfs.conf.d/identity.conf
>
> Whatever tool creates the identity, writes it to
>   /etc/netns/NAME/nfs.conf.d/identity.conf
>
> While we are at it, we should get exportfs to look there too, and
> establish some convention so /var/lib/nfs can use a different path in
> different network namespaces.

Thanks! This is extremely helpful.

I can modify nfs4id to check if it has been invoked within a network
namespace, then then check and store uuids in /etc/netns/NAME first.

Ben

