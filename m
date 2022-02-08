Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9765A4ADE1F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 17:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiBHQSR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 11:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiBHQSQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 11:18:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AAFFC061578
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 08:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644337095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AYDXkNvRzvNYsBXx1z551aTKIN6Gewpo3KNhjfalPFk=;
        b=DrUrdVN7WiGP+JwZj7zdRO6hB+wm3gWlCT+4eQvezITHzSCxDuDf/yVMVw3tLJ0glAHWda
        rJMTbr63gGT9w1Em8yN5ke64hIuuaRym/JOjrJHGLA3SxtGcCZqD5f3cO758WD9lmaqrPq
        +kaR6NaxRA4GitEDk/ziKtlyt/qU8Gs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-OOgw9qdAMi6F9-106S7VPA-1; Tue, 08 Feb 2022 11:18:12 -0500
X-MC-Unique: OOgw9qdAMi6F9-106S7VPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 373F884BA42;
        Tue,  8 Feb 2022 16:18:11 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5C28879D3;
        Tue,  8 Feb 2022 16:18:10 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Date:   Tue, 08 Feb 2022 11:18:09 -0500
Message-ID: <CC22859B-A1D4-404A-9746-AF43325B5515@redhat.com>
In-Reply-To: <6c34f6721a11c426ac6f732aba37eb67c5b9dae1.camel@hammerspace.com>
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
 <6AB99AB0-A9A5-4000-BABD-8EFC34FC31D5@redhat.com>
 <50d04869ff78e2f59b78804f100f9127e3352496.camel@hammerspace.com>
 <6c34f6721a11c426ac6f732aba37eb67c5b9dae1.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On 8 Feb 2022, at 10:47, Trond Myklebust wrote:

>> peernet2id_alloc() is not designed for this. It appears to use
>> idr_alloc(), which means it will reuse values frequently.

I did not think of that.

> Furthermore, that would introduce a dependency on the init namespace
> identifier being unique, which precludes its use for initialising said
> init namespace.

That's what the udev rule will fix! :)

I think I was still on the deterministic bus, but it seems to make the most
sense to simply use a random value as a default, then.  And if a container
wants to be the same client it must run udev, or write to sysfs itselt.

Ben

