Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8CB75A3CB
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 03:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGTBOc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 21:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTBOb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 21:14:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10D72101
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 18:14:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fc04692e20so2045865e9.0
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 18:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689815669; x=1692407669;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TCe0gH4dDhiehFm+t1WrXMf8ys860dDqa7Yq88y9FlU=;
        b=RAt1/laYkcpZNNOIlSGK4RZawEy587s4E5gxRc2pz9XI76C8IoU4ig/BY9J7tU8QNu
         bK93DKR5fqgD9PHyZL75WHZUILGGsTk0GwDeqe//kFxXOlG0OFlaXMBDdx2DqmawowFf
         aE/UDnrng8TIS3FUd/Tikx3LuhjCyPaQ0AM8IGrOTlpnCkn3Wl63MM1AZlWBozf/dEKd
         AowuCoTiNkwkSAZm8CaF/xubWZ86r9l8+yDKSw2LimQ++/r/asN6HroQri1yRry2SsEr
         oueFGASh7VlX2RVe1SmgI6GJ8vHt0d422/0VLusZoRcMZS+z1PVoF1EKnVZCPIF1rFd4
         Hcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689815669; x=1692407669;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCe0gH4dDhiehFm+t1WrXMf8ys860dDqa7Yq88y9FlU=;
        b=g5k/oYYqH4rsf19EEv1KQjkex0j+7DmKPQmP/YM5o6LtWjPG3QzUa60Fk8lMIIWuvP
         5wLuQ7G+26dJtoAfDvcJXSMlaLoQmf1gTcWPgcvmOtRGZN2CBbewx9r6/HQ+8xjN6EPG
         1ofAizke3UIVY/sdggvB3ARcY7Z1z7ekBRuzXstJxmv5dej3c0AvPf92z7cC3vuBKEFd
         bVn/63jphZguP8OuaKygAntFXjM97LuUgEVgXFNjEJ+3R1X4LAdYjSmp+B/IjjKK0kvc
         GlIAD5dStA4cu1GGyjMnEdutPlX58HYESRDtg+k5pwxdSIpRr1UBcLW/a+fU0MXNMAm3
         JOkg==
X-Gm-Message-State: ABy/qLZCjaAUyoy/6ehi6slwg1q2bi0kuzyTBvDukHnFoQJ0bQh2yuyk
        OjVXCf35IrrXcoUuKGZxBv2yQCCVPOckKg==
X-Google-Smtp-Source: APBJJlFdkV0BPIBLIPy8ohZq3QYmk4h5UPrj4uI75bf72hoDjGtQWnpkSxc1BySnl0OZHFKiYke0sA==
X-Received: by 2002:a1c:7915:0:b0:3fc:d5:dc14 with SMTP id l21-20020a1c7915000000b003fc00d5dc14mr5414854wme.5.1689815669034;
        Wed, 19 Jul 2023 18:14:29 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b003fbe561f6a3sm2758940wmq.37.2023.07.19.18.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 18:14:28 -0700 (PDT)
Message-ID: <6901cae4-a257-62dd-64fa-b4f201fc1b07@gmail.com>
Date:   Thu, 20 Jul 2023 09:14:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH v2] nfs: fix redundant readdir request after get eof
To:     Anna Schumaker <anna@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
References: <CAB6yy374gQmrAjtLmFWGDVq9GBfxFoA-L95oELo=k+W9TF7cyg@mail.gmail.com>
 <ECE48590-218F-4304-A043-B9AEB04CD3DA@redhat.com>
Content-Language: en-US
In-Reply-To: <ECE48590-218F-4304-A043-B9AEB04CD3DA@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2023/7/19 9:24 PM, Benjamin Coddington wrote:
> On 18 Jul 2023, at 8:44, Kinglong Mee wrote:
> 
>> When a directory contains 17 files (except . and ..), nfs client sends
>> a redundant readdir request after get eof.
>>
>> A simple reproduce,
>> At NFS server, create a directory with 17 files under exported directory.
>>  # mkdir test
>>  # cd test
>>  # for i in {0..16}  ; do touch $i; done
>>
>> At NFS client, no matter mounting through nfsv3 or nfsv4,
>> does ls (or ll) at the created test directory.
>>
>> A tshark output likes following (for nfsv4),
>>
>>  # tshark -i eth0 tcp port 2049 -Tfields -e ip.src -e ip.dst -e nfs -e
>> nfs.cookie4
>>
>> srcip   dstip   SEQUENCE, PUTFH, READDIR        0
>> dstip   srcip   SEQUENCE PUTFH READDIR
>> 909539109313539306,2108391201987888856,2305312124304486544,2566335452463141496,2978225129081509984,4263037479923412583,4304697173036510679,4666703455469210097,4759208201298769007,4776701232145978803,5338408478512081262,5949498658935544804,5971526429894832903,6294060338267709855,6528840566229532529,8600463293536422524,9223372036854775807
>> srcip   dstip
>> srcip   dstip   SEQUENCE, PUTFH, READDIR        9223372036854775807
>> dstip   srcip   SEQUENCE PUTFH READDIR
>>
>> The READDIR with cookie 9223372036854775807(0x7FFFFFFFFFFFFFFF) is
>> redundant.
>>
>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> 
> Weird, I never got a copy from linux-nfs.   The plain-text version of this
> is whitespace damaged, but the HTML version looks right.
> 
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Anna,

Sometimes my email client cannot send email correctly,
so I send this path at web gmail.

Are you OK for this HTML version?
If not, I will resend it through my email client. 

thanks,
Kinglong Mee
