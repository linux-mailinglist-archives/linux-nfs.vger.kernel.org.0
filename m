Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC14B2747
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Feb 2022 14:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiBKNfc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Feb 2022 08:35:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiBKNfb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Feb 2022 08:35:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1701195
        for <linux-nfs@vger.kernel.org>; Fri, 11 Feb 2022 05:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644586529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rqeu3eThxTPmeQzAZMXsDvnBJB6+wwYnSvqyBSvG8us=;
        b=ZugT43Gh6qIl40bTjDgJcu1bMI1pSFwoOJrUKgsG/jruGCsbvFU72pZgHmcuqWPAHYYaBA
        y1Awa1Y703DwslUlJ4JRh2hPKof2mT0OzBW7Z4j1to8Asdo7BF5H0uN50IvX4wfBOUKpR/
        IEvnsqwVJOimYegWx57R6bNYqTuonIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-KonA7kfhOT2Hm3AybxysAQ-1; Fri, 11 Feb 2022 08:35:26 -0500
X-MC-Unique: KonA7kfhOT2Hm3AybxysAQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0159190B2D6;
        Fri, 11 Feb 2022 13:35:23 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C0B17901B;
        Fri, 11 Feb 2022 13:35:23 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>, steved@redhat.com,
        linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Date:   Fri, 11 Feb 2022 08:35:22 -0500
Message-ID: <299337F3-E83F-49EC-BB24-C9B859C9FB6D@redhat.com>
In-Reply-To: <164453369792.27779.10668875903268728405@noble.neil.brown.name>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
 <0AB20C82-6200-46E0-A76C-62345DAF8A3A@redhat.com>
 <6cfb516d-0747-a749-b310-1368a2186307@redhat.com>
 <164444169523.27779.10904328736784652852@noble.neil.brown.name>
 <39e7bba4243eb2f16d99fefb43fef6b3ff741f87.camel@hammerspace.com>
 <164445109064.27779.13269022853115063257@noble.neil.brown.name>
 <6BAAA0D0-7212-480F-9C33-DA1F656FF09F@redhat.com>
 <164453369792.27779.10668875903268728405@noble.neil.brown.name>
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

On 10 Feb 2022, at 17:54, NeilBrown wrote:

> On Thu, 10 Feb 2022, Benjamin Coddington wrote:
>>
>> Yes, but even better than having the tool do the writing is to have 
>> udev do
>> it, because udev makes the problem of when and who will execute this 
>> tool go
>> away, and the entire process is configurable for anyone that needs to 
>> change
>> any part of it or use their own methods of generating/storing ids.
>
> I really don't understand the focus on udev.
>
> Something, somewhere, deliberately creates the new network namespace.
> It then deliberately configures that namespace - creating a virtual
> device maybe, adding an IP address, setting a default route or 
> whatever.
> None of that is done by udev rules (is it)?
> Setting the NFS identity is just another part of configuring the new
> network namespace.
>
> udev is great when we don't know exactly when an event will happen, 
> but
> we want to respond when it does.
> That doesn't match the case of creating a new network namespace.  Some
> code deliberately creates it and is perfectly positioned to then
> configure it.

I think there's so many ways to create a new network namespace that we 
can't
reasonably be expected to try to insert out problem into all of them.
Handling the event from the kernel allows us to make a best-effort 
default
attempt.

> udev is async.  How certain can we be that the udev event will be 
> fully
> handled before the first mount attempt?

Good point.  We can't at all be certain.

We can start over completely from here..

We can have mount.nfs /also/ try to configure the id.. this is more 
robust.

We can have mount.nfs do a round of udev settle..

Are there other options?

Ben

