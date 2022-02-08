Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD8F4ADC86
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 16:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380046AbiBHPXw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 10:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380052AbiBHPXu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 10:23:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEC95C0613CB
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 07:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644333827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iy9+FlDxB75s6AWQ1M9tZTRge9saKUetz1MODBbMmow=;
        b=Shi1dfV3KG/n/vpBEY9xrs7ENVmtukv/y4lt1p/5/zrF2S4E+yZJCmOvitMb/jJ8jcv1hk
        evJIIKJq17LQ5JXgZKxEdYfoC2DXRcvdH0iVw/xG/sk9lAssEkA1aowzNeKBdqKJtvJXKH
        SbTkXHZdwfHgxZDaXA1bCOkn4xzAeC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-pORhA34xOWyGnHhbiPmNSg-1; Tue, 08 Feb 2022 10:23:42 -0500
X-MC-Unique: pORhA34xOWyGnHhbiPmNSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 962F21B18BC6;
        Tue,  8 Feb 2022 15:23:22 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D25884D02;
        Tue,  8 Feb 2022 15:23:22 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Date:   Tue, 08 Feb 2022 10:23:21 -0500
Message-ID: <6AB99AB0-A9A5-4000-BABD-8EFC34FC31D5@redhat.com>
In-Reply-To: <6211BF2A-2A00-4E00-8647-57D829D41E8D@oracle.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
 <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
 <439C77F9-D5AD-4388-B954-3B413C1DF0E2@redhat.com>
 <596C2475-76AA-4616-919C-9C22B6658CA7@redhat.com>
 <DB8B60C8-B772-4604-A841-47F789723D5D@oracle.com>
 <b192022ce73ea690a117d7710b492e83be99df31.camel@hammerspace.com>
 <43990B9C-013C-4E77-AADA-F274ACBE4757@oracle.com>
 <8CCCD806-A467-432C-B7FF-9E83981533EF@redhat.com>
 <c9948f895e91abb76a21609bf629b88bbfcf4d9a.camel@hammerspace.com>
 <CEC36879-0474-44A1-984B-BAE69C168274@redhat.com>
 <6211BF2A-2A00-4E00-8647-57D829D41E8D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8 Feb 2022, at 9:42, Chuck Lever III wrote:

>> On Feb 8, 2022, at 9:29 AM, Benjamin Coddington <bcodding@redhat.com> 
>> wrote:
>>
>> On 8 Feb 2022, at 8:45, Trond Myklebust wrote:
>>
>>>> Can't we just uniquify the namespaced NFS client ourselves, while
>>>> still
>>>> exposing /sys/fs/nfs/net/nfs_client/identifier within the 
>>>> namespace?
>>>> That
>>>> way if someone want to run udev or use their own method of 
>>>> persistent
>>>> id
>>>> its available to them within the container so they can.  Then we 
>>>> can
>>>> move
>>>> forward because the problem of distinguishing clients between the
>>>> host
>>>> and
>>>> netns is automagically solved.
>>>
>>> That could be done.
>>
>> Ok, I'm eyeballing a sha1 of the init namespace uniquifier and
>> peernet2id_alloc(new_net, init_net).. but means the NFS client would 
>> grow a
>> dependency on CRYPTO and CRYPTO_SHA1.
>
> Or you could use siphash instead of SHA-1.
>
> I don't think we should be adding any more SHA-1 to the kernel --
> it's deprecated for good reasons.

Thanks! Siphash is nicer too.  :)

Ben

