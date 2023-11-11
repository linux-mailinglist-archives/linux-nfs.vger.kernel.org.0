Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7407E8B43
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Nov 2023 15:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjKKOpv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 11 Nov 2023 09:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjKKOpo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 11 Nov 2023 09:45:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3679A2D77
        for <linux-nfs@vger.kernel.org>; Sat, 11 Nov 2023 06:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699713896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H1+QWv0taU3DlnjiU99C50KNhYe+9Z36NkG4LiMoYS4=;
        b=hpNk+Jamr/Zvz9wMiTtUSeHBzbSynPBJc+i7Rmr/KWVKsYrKr0LImAB1YN4oWRwxpmUgLP
        Lr2hVu4YCaL9D5NLdvaTXc/XPny8z893m1s3S7WapCqc9BSbhsGYWVmvst1vsuLUb1tWfX
        Tj2L0AJDoUJnew5jj2S2DJh0kQXMung=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-IULgl1d6NUiF2hbVeqcmkg-1; Sat, 11 Nov 2023 09:44:54 -0500
X-MC-Unique: IULgl1d6NUiF2hbVeqcmkg-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6d64ebf7f73so180424a34.0
        for <linux-nfs@vger.kernel.org>; Sat, 11 Nov 2023 06:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699713893; x=1700318693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1+QWv0taU3DlnjiU99C50KNhYe+9Z36NkG4LiMoYS4=;
        b=J41pUDYnRTnoWfTwAvLnbKWELgPqvOw6IfdgN0PY5bbJ8CFDRhZDExniOQ9Gprnh36
         lw+cdts7RYlWlcLGn06L2YJqL4FAv7NNwltGPhPRVAqWrRmeNDFJhlDnDK6g5hMfRNtu
         Hv7uDs1kpSHfFpq26OnW0MSF/mNKls+9kfonPihKI00cJ2ubyNspTKN3vQX5XEPVfNpi
         GUh+eKQVqNR1aepWTlWpRx4x+07K0eR0ggy6b8YfOom9Wbf5MaeANp+q7AFU5s/W4HTr
         5uVzz5ZbBcBHZg6LP1OiagOK5uTJXU6AsxpLEkPFg/MWPN1Nn2FCOaLaznxzdl9Xcm4/
         fxzQ==
X-Gm-Message-State: AOJu0YyCBvRvlyJu5QV0joKoghkl1f6mX4TW3+F4Wt/Zp3qfC98fI2Fj
        Lhopl4mlIGQWQqgdSiuhLSWomR01C4emqDHeoQNqjb1JDphxwApyJ7YFstP5+qt6T9zzukL9NWF
        /hOsFJyAUcnqbynYCc0760dJZKEku
X-Received: by 2002:a05:6830:33e3:b0:6d3:3332:fbfb with SMTP id i3-20020a05683033e300b006d33332fbfbmr2068464otu.0.1699713893511;
        Sat, 11 Nov 2023 06:44:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrf3vAQ+SVz7QXdU1J7GloWpCmk3lirUh4O9heNKa9z3n83Yd+dyAvES8dad7/D65LvwHjLg==
X-Received: by 2002:a05:6830:33e3:b0:6d3:3332:fbfb with SMTP id i3-20020a05683033e300b006d33332fbfbmr2068456otu.0.1699713893181;
        Sat, 11 Nov 2023 06:44:53 -0800 (PST)
Received: from [172.31.1.12] ([70.105.251.235])
        by smtp.gmail.com with ESMTPSA id x15-20020a0ce78f000000b00668eb252523sm618617qvn.63.2023.11.11.06.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 06:44:52 -0800 (PST)
Message-ID: <cf245bf9-0674-4ee4-8b9d-044dd656977c@redhat.com>
Date:   Sat, 11 Nov 2023 09:44:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nfs(5): adding new mount option 'fasc'
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chengen.du@canonical.com" <chengen.du@canonical.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20230828055324.21408-1-chengen.du@canonical.com>
 <6b4e6cd5-5711-4033-b813-2f8048c35921@redhat.com>
 <4bbbb46c1d2311143f590e57c04c7692e95c04ce.camel@hammerspace.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <4bbbb46c1d2311143f590e57c04c7692e95c04ce.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/10/23 2:08 PM, Trond Myklebust wrote:
> On Fri, 2023-11-10 at 11:54 -0500, Steve Dickson wrote:
>> Hello,
>>
>> My apologies on this delay...
>>
>> On 8/28/23 1:53 AM, Chengen Du wrote:
>>> Add an option that triggers the clearing of the file
>>> access cache as soon as the cache timestamp becomes
>>> older than the user's login time.
>>>
>>> Signed-off-by: Chengen Du <chengen.du@canonical.com>
>> On a 6.7-rc0 kernel I'm getting "nfs: Unknown parameter 'fasc'"
>> error... was this never implemented?
>>
> 
> No. There are no plans to add any mount parameters for this
> functionality.
Thank you!

steved.

> 

