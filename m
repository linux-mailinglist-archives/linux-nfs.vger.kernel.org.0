Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBE94B764F
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Feb 2022 21:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbiBOQ5z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Feb 2022 11:57:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbiBOQ5y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Feb 2022 11:57:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C1F5F11B2
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 08:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644944263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LohrFwYvTb/xT6+qLm2NGwQdkxVjgCb4gCZTWrX3OH0=;
        b=NuO0c61bx6/BWc6zck7FHATdFTjcltUXexmM+aLuj1RTSWnW9x7qhbuCXlRZaocX/5RyTc
        i9LTGFBLf1d5myuRp3pI6uQbO/BlHER83SeCFaxpJjkc/qNAKr/mARU+FHUYoNLq5OE1qN
        i1oYGrqS7zwJIMTH9Xt1lAvNPTRqcm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-c0MbiPhTME2Olhl7-58H8Q-1; Tue, 15 Feb 2022 11:57:39 -0500
X-MC-Unique: c0MbiPhTME2Olhl7-58H8Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9FCF1006AA5;
        Tue, 15 Feb 2022 16:57:38 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A47E7D721;
        Tue, 15 Feb 2022 16:57:38 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Date:   Tue, 15 Feb 2022 11:57:37 -0500
Message-ID: <40A1C333-66AD-4866-90EF-B8A90AA58C82@redhat.com>
In-Reply-To: <06e2a692e587d1ffcccd14d465136df228149e4c.camel@hammerspace.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
 <164428557862.27779.17375354328525752842@noble.neil.brown.name>
 <A677D8A9-FD0B-43E5-82D6-E660CCB8B185@redhat.com>
 <164435376000.27779.4059629372785561121@noble.neil.brown.name>
 <06e2a692e587d1ffcccd14d465136df228149e4c.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8 Feb 2022, at 18:34, Trond Myklebust wrote:

> On Wed, 2022-02-09 at 07:56 +1100, NeilBrown wrote:

>> So I still STRONGLY think that the identity should be set by
>> mount.nfs
>> reading (and writing) some file in /etc or /etc/netnfs/NAME, and I
>> weakly think that the file should be in /etc/nfs.conf.d/ so that the
>> reading is automagic.
>>
>
> No. It's not a per-mount setting, so it has no business being in the
> mount protocol.

Trond,

We still have the issue that udev handling the event to set the uniquifier
for the init namespace races with the first SETCLIENTID/EXCHANGE_ID.

Now that network namespaces uniqify by default, would you prefer we try to
solve this with the userspace tools setting the module parameter instead of
depending on udev for the init namespace?

Alternatively, we could grow another module parameter:
nfs4_unique_id_timeout:int Seconds to wait for a uniquifier

A non-zero default also gives network namespaces the chance to set a
persistent value that differs from the random value the kernel generated.

Ben

