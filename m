Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD086C6FCB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Mar 2023 18:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjCWR5x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Mar 2023 13:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCWR5t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Mar 2023 13:57:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F0A144B8
        for <linux-nfs@vger.kernel.org>; Thu, 23 Mar 2023 10:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679594232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrPrULih14KTqmObCZmcGWhIGsS5PrRxURWVJYjga3Q=;
        b=PV2G91qWa0f6Jlk1jjPG+gd5O3dYDBgbheWg8m/MBAnjEy+TBDMgzlvo5AfyyAZt3aGJHf
        6WC4NA0IsuWgT6T+4wkVlHh58tmnPHvLxjWr8APVSTZzA8QXG8P/sQx9BLaBD0MR+xAmvv
        o99R1LSmUXGoII6R8mxJ6jjLZf/7pWw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-o6-cPbhdP2agIciPIDELVQ-1; Thu, 23 Mar 2023 13:57:10 -0400
X-MC-Unique: o6-cPbhdP2agIciPIDELVQ-1
Received: by mail-qt1-f200.google.com with SMTP id w13-20020ac857cd000000b003e37d3e6de2so6789760qta.16
        for <linux-nfs@vger.kernel.org>; Thu, 23 Mar 2023 10:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679594230; x=1682186230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DrPrULih14KTqmObCZmcGWhIGsS5PrRxURWVJYjga3Q=;
        b=jpxInoZhA+j0v+zocQdEC+fP98EKHdohqMmSn6MOUx7F/SF+ph+9wCc4lLEKuqMQ0M
         yk94urj4O2u8apNf0xXHxxocAe8eG8ZGdCm10B0yuNdVfzkz1ka2wiwGRGi6yrtIZehS
         nj3vpz3eopGa2r6kiWPiq1WtizfbmL/XCOL6AAoJR8hmddr5ljQsvv9Kqyirk4OpQQ22
         iG2CWi6UYFFzTQohjOONlcgGsevGiGKjLwyM0lU4VqpL1tR4X/PoPcr2EXyUe/ndrY81
         /bKsqD7Q/hM1vcgqxX3NTUpHRAFLvHYFgZ4p7Oi3jneKjXXZAf/yuFo717gkWzwt6a+I
         66AA==
X-Gm-Message-State: AO0yUKWc68uImaES852IbOe/HfIKoIyyR2DdDsDwb9w4olpxptMBQwiJ
        2KvWKravOEyCcHH7ehTw2umZkcuhJI+Ozn6ub2JXNS8pxJs3UPKf5AXSNkHKu73tLvPE/lDLDRu
        PSB6Nr8b9Qrz81cE8GpQ1
X-Received: by 2002:a05:622a:1829:b0:3e3:8f8c:b92f with SMTP id t41-20020a05622a182900b003e38f8cb92fmr382423qtc.5.1679594230360;
        Thu, 23 Mar 2023 10:57:10 -0700 (PDT)
X-Google-Smtp-Source: AK7set8X9f2f81r8EicSk6uO7oLM7Q3poqe7NaMh90t0ogAkSYWjPre47diweA8EJpWjpquYqXeUNw==
X-Received: by 2002:a05:622a:1829:b0:3e3:8f8c:b92f with SMTP id t41-20020a05622a182900b003e38f8cb92fmr382392qtc.5.1679594230038;
        Thu, 23 Mar 2023 10:57:10 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y15-20020ac8524f000000b003e3910db4f1sm1646412qtn.35.2023.03.23.10.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 10:57:09 -0700 (PDT)
Message-ID: <da936d7d-a864-a2ff-64a4-a295653a6aa7@redhat.com>
Date:   Thu, 23 Mar 2023 13:57:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 0/4] nfs-utils changes for RPC-with-TLS server
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org
References: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
 <d5c93e97f10a8ae803efaad02559dd118e9b9b6f.camel@kernel.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <d5c93e97f10a8ae803efaad02559dd118e9b9b6f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/21/23 7:52 AM, Jeff Layton wrote:
> On Mon, 2023-03-20 at 10:35 -0400, Chuck Lever wrote:
>> Hi Steve-
>>
>> This is server-side support for RPC-with-TLS, to accompany similar
>> support in the Linux NFS client. This implementation can support
>> both the opportunistic use of transport layer security (it will be
>> used if the client cares to) and the required use of transport
>> layer security (the server requires the client to use it to access
>> a particular export).
>>
>> Without any other user space componentry, this implementation will
>> be able to handle clients that request the use of RPC-with-TLS. To
>> support security policies that restrict access to exports based on
>> the client's use of TLS, modifications to exportfs and mountd are
>> needed. These can be found here:
>>
>> git://git.linux-nfs.org/projects/cel/nfs-utils.git
>>
>> They include an update to exports(5) explaining how to use the new
>> "xprtsec=" export option.
>>
>> The kernel patches, along with the the handshake upcall, are carried
>> in the topic-rpc-with-tls-upcall branch available from:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>
>> This was posted under separate cover.
>>
>> ---
>>
>> Chuck Lever (4):
>>        libexports: Fix whitespace damage in support/nfs/exports.c
>>        exports: Add an xprtsec= export option
>>        exportfs: Push xprtsec settings to the kernel
>>        exports.man: Add description of xprtsec= to exports(5)
>>
>>
>>   support/export/cache.c       |  15 ++++++
>>   support/include/nfs/export.h |   6 +++
>>   support/include/nfslib.h     |  14 +++++
>>   support/nfs/exports.c        | 100 ++++++++++++++++++++++++++++++++---
>>   utils/exportfs/exportfs.c    |   1 +
>>   utils/exportfs/exports.man   |  45 +++++++++++++++-
>>   6 files changed, 172 insertions(+), 9 deletions(-)
>>
> 
> Nice work, Chuck! This all looks pretty straightforward. I have a
> (minor) concern about potentially blocking nfsd threads for up to 20s in
> a handshake, but this seems like a good place to start.
Yes! But Will here be a V2 with the suggested changes?

It would be good to get a new release with these patches
in before the upcoming Bakeathon.

steved.

