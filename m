Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7291F7ED611
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Nov 2023 22:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbjKOVad (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Nov 2023 16:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjKOVad (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Nov 2023 16:30:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C57A92
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 13:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700083828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k56wC+pGLOwt4XbshGoji6Hvi02WpE56/rAAKXV/DRo=;
        b=JWUN/vmU9krD1slgGr1++mrfVRQtVk+Fs49+7vABlTgbedN687EMS4jBcyPUnj6Iv8fdj5
        m+bEWkTK2SqF/0Ij3AoRkG56boccxm7vZvKKWC3XJ8o70DG5ClbyxVngx0nvGLEjkQWL3H
        Khns8VIIlHPhvfQz14Fk0EKwCayP7Z0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-tzhh5i-4PWmAzYuLRWmMFw-1; Wed, 15 Nov 2023 16:30:27 -0500
X-MC-Unique: tzhh5i-4PWmAzYuLRWmMFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBA67185A780;
        Wed, 15 Nov 2023 21:30:26 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 296061C060AE;
        Wed, 15 Nov 2023 21:30:25 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, anna.schumaker@netapp.com
Subject: Re: [PATCH v2 1/5] NFS: Fix error handling for O_DIRECT write
 scheduling
Date:   Wed, 15 Nov 2023 16:30:24 -0500
Message-ID: <C9BC9AC4-DD95-4CC4-AB1F-D38856DB394E@redhat.com>
In-Reply-To: <73e48b3b4e835231a1c2a79613baf6bb01d3f6a3.camel@hammerspace.com>
References: <20230904163441.11950-1-trondmy@kernel.org>
 <20230904163441.11950-2-trondmy@kernel.org>
 <02FDFFF6-8512-4BBA-845D-72C21864E621@redhat.com>
 <44d134dd65a4c7194f5200a390e5229003ba4016.camel@hammerspace.com>
 <4EBFA030-C144-4017-842F-B8D6B2ADC19A@redhat.com>
 <EA084F46-9E51-4A9E-AEE4-018499819F12@redhat.com>
 <73e48b3b4e835231a1c2a79613baf6bb01d3f6a3.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 15 Nov 2023, at 12:16, Trond Myklebust wrote:

> On Wed, 2023-11-15 at 08:04 -0500, Benjamin Coddington wrote:
>> On 9 Nov 2023, at 12:25, Benjamin Coddington wrote:
>>
>>> On 9 Nov 2023, at 11:53, Trond Myklebust wrote:
>>>>
>>>> Hi Ben,
>>>>
>>>> Relying on the value of dreq->bytes_left is just not a good idea,
>>>> given
>>>> that the layoutget request could end up returning NFS4ERR_DELAY.
>>>>
>>>> How about something like the following patch?
>>>
>>> That looks promising!  I think ->bytes_left could get dropped after
>>> this.
>>>
>>> I'll send it through some testing and report back, thanks!
>>
>> This definitely fixes it, sorry for the delay getting back.
>>
>> Fixes: 954998b60caa ("NFS: Fix error handling for O_DIRECT write
>> scheduling")
>> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>> Tested-by: Benjamin Coddington <bcodding@redhat.com>
>>
>> It creates some clear additional work to remove nfs_direct_req-
>>> bytes_left
>> (I don't think its needed anymore) and fixup the nfs_direct_req_class
>> tracepoint, which could be a follow-up patch or get folded in.
>>
>
> Thank you! I'll queue that patch up so it gets included in the next
> bugfix pull request.

Thank you for the fix.

> I agree that we should get rid of the bytes_left field. We can queue
> something up for that in the next merge window.

I have it tested already with yours, I'll send it along.

Ben

