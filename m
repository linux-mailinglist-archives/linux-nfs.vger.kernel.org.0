Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17C452D50F
	for <lists+linux-nfs@lfdr.de>; Thu, 19 May 2022 15:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbiESNuG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 May 2022 09:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239281AbiESNuA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 May 2022 09:50:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BF1246149
        for <linux-nfs@vger.kernel.org>; Thu, 19 May 2022 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652968065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=si9842vVCuVIrOxKZ0R/QNt4gmyAqTSzVYoQtFaFkXM=;
        b=eMm/yIVsvZ18D8ojYfiaV8xF+eXGpWz7vgJ0EZtR53JJK2YMXJvje19jnLKM9BSp4iFr6k
        4gSBHGLuU/fprUrszl01WJ3akJOzGoeUVmfz8wD2Tctfax+0D1U87mCUzMPF2rULpvW1bZ
        FJHaNf/RI72qD9W+3xvC7ZBkUJeu1QI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-X_TDf4oCNfGWHYIsS4jIcw-1; Thu, 19 May 2022 09:47:43 -0400
X-MC-Unique: X_TDf4oCNfGWHYIsS4jIcw-1
Received: by mail-qt1-f197.google.com with SMTP id g1-20020ac85801000000b002f3b281f745so4253221qtg.22
        for <linux-nfs@vger.kernel.org>; Thu, 19 May 2022 06:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=si9842vVCuVIrOxKZ0R/QNt4gmyAqTSzVYoQtFaFkXM=;
        b=rSuDoJ89f7brWzxWjFp2fhqHJEb4OugGR2YNABYHFVMUGP/9aeWrjDcZZ0E5jawvUm
         auDTOPoYDggwCp2AXBu8cKz8ptRp29uZ3hYqMrQRcuvHTSVygqGv8An5g7evDMn/SFF5
         C7bSra4h95jpVGafUU27RBFr/HDECMQz028iKK7b2WNYqaOxCW4O9buXp0XNvyhehqUd
         /zH2UVWU1S3sCztQbVSNiJMDNTfREdtC1UHIxZsaih6jRsHFGTx9Sb8XjvfMVmv4eX7B
         dXPlTX18sj++pqaTHmIKC5YG/ltlHKVbSsystZojSKj8U7nokkL3burOsGH8NnI8ubTq
         hNDw==
X-Gm-Message-State: AOAM533Elkof5yGLATCpBsi10WTuhsBsDO9EWhrdWv9L3Fmx03mOrwoJ
        HI+eUxjTtZCCL45/w2RT8HLn/iRi2VEuviuEW9r+HMQjTnDPG8AuMUL2PiQv6RH9kid7paoxwsN
        BXCPlqpkmelmxXO+qEjlE
X-Received: by 2002:a05:620a:f03:b0:67e:1e38:4a0 with SMTP id v3-20020a05620a0f0300b0067e1e3804a0mr3055887qkl.86.1652968063048;
        Thu, 19 May 2022 06:47:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3bnWXUbEKDqVHB0bKlTdp91BEBUM62kjsKZACxU905aZE8epClQ3u4MuzRda6Rj7ns+7ciA==
X-Received: by 2002:a05:620a:f03:b0:67e:1e38:4a0 with SMTP id v3-20020a05620a0f0300b0067e1e3804a0mr3055872qkl.86.1652968062772;
        Thu, 19 May 2022 06:47:42 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.96.106])
        by smtp.gmail.com with ESMTPSA id x4-20020a37ae04000000b006a0462eb091sm1246814qke.80.2022.05.19.06.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 06:47:42 -0700 (PDT)
Message-ID: <627133c7-dab9-db0b-5fdf-ecb95820e76a@redhat.com>
Date:   Thu, 19 May 2022 09:47:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/6] Allow nfs4-acl-tools to access 'dacl' and 'sacl'
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20220514144436.4298-1-trondmy@kernel.org>
 <20220515015946.GB30004@fieldses.org>
 <15c4602658aff025b6d84e2b9461378930cbd802.camel@hammerspace.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <15c4602658aff025b6d84e2b9461378930cbd802.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/14/22 11:23 PM, Trond Myklebust wrote:
> On Sat, 2022-05-14 at 21:59 -0400, J.Bruce Fields wrote:
>> On Sat, May 14, 2022 at 10:44:30AM -0400, trondmy@kernel.org wrote:
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> The following patch set matches the kernel patches to allow access
>>> to
>>> the NFSv4.1 'dacl' and 'sacl' attributes. The current patches are
>>> very
>>> basic, adding support for encoding/decoding the new attributes only
>>> when
>>> the user specifies the '--dacl' or '--sacl' flags on the command
>>> line.
>>
>> Seems like a reasonable thing to do.
>>
>> I'd rather not be responsible for nfs4-acl-tools any longer, though.
>>
>> --b.
> 
> I suspected that might be the case, but since you haven't made any
> announcements about anybody else taking over, I figured I'd start by
> sending these to you.
> 
> So who should take over the nfs4-acl-tools maintainer role? Is that
> something Red Hat might be interested in doing, or should I volunteer
> to do it while we wait for somebody to get so fed up that they decide
> to step in?
> 
Yeah... it probably something we should take over....

I'll add these to my todo list... Where does the upstream repo
live today?

steved.

