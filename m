Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE9C7EC338
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Nov 2023 14:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbjKONEN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Nov 2023 08:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjKONEM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Nov 2023 08:04:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EDBCE
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 05:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700053448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pr8NpsOMIWoyxbrZ06FUm/LGBngldfoFEWe1o99nokk=;
        b=ftdlH/HjMs9JkZeZvWrQZLa6IjN9T3ZRxftLrG7giKfgo8tkzgumCEQzkUmnLtZR9W8x2s
        wRGjpQCsgFS627mprAIDHePDAQ208ZuSvxlckq0QC79JTsdK3TT+qVkw4ouqrk6b2q76jq
        o+u+NvcJdnKpZxT4xObZXYSxuWWG8zI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455--xopn-H1Pg6Li07s4lTgDA-1; Wed,
 15 Nov 2023 08:04:06 -0500
X-MC-Unique: -xopn-H1Pg6Li07s4lTgDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32B801C06E10;
        Wed, 15 Nov 2023 13:04:06 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C6C81121306;
        Wed, 15 Nov 2023 13:04:05 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, anna.schumaker@netapp.com
Subject: Re: [PATCH v2 1/5] NFS: Fix error handling for O_DIRECT write
 scheduling
Date:   Wed, 15 Nov 2023 08:04:04 -0500
Message-ID: <EA084F46-9E51-4A9E-AEE4-018499819F12@redhat.com>
In-Reply-To: <4EBFA030-C144-4017-842F-B8D6B2ADC19A@redhat.com>
References: <20230904163441.11950-1-trondmy@kernel.org>
 <20230904163441.11950-2-trondmy@kernel.org>
 <02FDFFF6-8512-4BBA-845D-72C21864E621@redhat.com>
 <44d134dd65a4c7194f5200a390e5229003ba4016.camel@hammerspace.com>
 <4EBFA030-C144-4017-842F-B8D6B2ADC19A@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9 Nov 2023, at 12:25, Benjamin Coddington wrote:

> On 9 Nov 2023, at 11:53, Trond Myklebust wrote:
>>
>> Hi Ben,
>>
>> Relying on the value of dreq->bytes_left is just not a good idea, given
>> that the layoutget request could end up returning NFS4ERR_DELAY.
>>
>> How about something like the following patch?
>
> That looks promising!  I think ->bytes_left could get dropped after this.
>
> I'll send it through some testing and report back, thanks!

This definitely fixes it, sorry for the delay getting back.

Fixes: 954998b60caa ("NFS: Fix error handling for O_DIRECT write scheduling")
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>

It creates some clear additional work to remove nfs_direct_req->bytes_left
(I don't think its needed anymore) and fixup the nfs_direct_req_class
tracepoint, which could be a follow-up patch or get folded in.

Ben

