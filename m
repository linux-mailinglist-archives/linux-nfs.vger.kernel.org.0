Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784DB6B66BA
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Mar 2023 14:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCLNcO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Mar 2023 09:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCLNcM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Mar 2023 09:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77BC4BE9A
        for <linux-nfs@vger.kernel.org>; Sun, 12 Mar 2023 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678627887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pyGug90bDbFhf8m3stIAuhgaeILtK6POMwxJmnqcn2o=;
        b=WrXGBxREf4TBGkk0LSwNfwOZpT33H5exJS4JZjBi7ZD3XWde/wB4SVPJDg/KA+j6f5n5mV
        vrbXYRtCR0uSseIwtZSUVavP53xUkJDCV94W/D0eOIoqv/kMaymAYZSHwHOzKt1hXIoQdj
        Izsm1VgU11Eh0mBvq8H+jMaqz6OAez4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-x37ajsETNjGO4rRZrdgjZA-1; Sun, 12 Mar 2023 09:31:26 -0400
X-MC-Unique: x37ajsETNjGO4rRZrdgjZA-1
Received: by mail-qk1-f197.google.com with SMTP id ou5-20020a05620a620500b007423e532628so5271167qkn.5
        for <linux-nfs@vger.kernel.org>; Sun, 12 Mar 2023 06:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678627885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pyGug90bDbFhf8m3stIAuhgaeILtK6POMwxJmnqcn2o=;
        b=WwS1RprsnfyToyFQ0p0wY87uIPKq6cBreXcFobGJwFIqDSG+DlYd3X0e+f6pbG7rsp
         Y60pPHYCuhzOLcw0tPD/LwL/OM8l+XVZ0npvOyOTOubkgAakh/Izt0TUumCXYE2vXEbx
         2V6NhFlLDDrnSNwITPuKYbS7UMSaIfQ5jwJdVPFSuPZ3Qp8mN42E54NqSp5txp3fc4Xt
         nV/N9N8qJP5ybekLUWPtlY8icl7gONVQHbG6diC/4rHgPuhqrB/aJZ13OxiOozfYYrmZ
         saVZgxN8DmxFjir9yY6BZZ5TOefXK0yudSIKK8wO8m51zMLslOJu/HJCN10UfojCLxKm
         LV3g==
X-Gm-Message-State: AO0yUKWfmjrVeJTCqUSMzldsSlPCBQmP3CqL5hpBXcOxRyvIuEr0uFow
        VcIWyirQVAaHEmTwRZrdMRUIVJESWuX5l/fJrLbXYJmT3dusQlxMZWTD3yezYF2ZvvIErr56Bwf
        1QJ4OgSmFuhg8cmsI8GbADITa0+Za
X-Received: by 2002:ac8:5c09:0:b0:3bf:be4b:8094 with SMTP id i9-20020ac85c09000000b003bfbe4b8094mr15603809qti.0.1678627884883;
        Sun, 12 Mar 2023 06:31:24 -0700 (PDT)
X-Google-Smtp-Source: AK7set+J7UNcYuZE4LaaQs/XCnTV5lRfY8goa2tj2GvPgH5HdjcGrIJl7QwuzGG3rmtOG0SXq6Se0g==
X-Received: by 2002:ac8:5c09:0:b0:3bf:be4b:8094 with SMTP id i9-20020ac85c09000000b003bfbe4b8094mr15603776qti.0.1678627884577;
        Sun, 12 Mar 2023 06:31:24 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.81])
        by smtp.gmail.com with ESMTPSA id x77-20020a376350000000b007458608f3a7sm68732qkb.86.2023.03.12.06.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 06:31:24 -0700 (PDT)
Message-ID: <31643f88-26ec-515c-d1d6-fad951248a8c@redhat.com>
Date:   Sun, 12 Mar 2023 09:31:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: mountd: Possible bug in next_mnt()
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
References: <1497292229.221220.1678287959937.JavaMail.zimbra@nod.at>
 <655a8ee6-dd94-effd-738a-9ce8db8ebed7@redhat.com>
 <156604342.233758.1678553565027.JavaMail.zimbra@nod.at>
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <156604342.233758.1678553565027.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/11/23 11:52 AM, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>>> next_mnt() finds submounts below a given path p.
>>> While investigating into an issue in my crossmount patches for nfs-utils I
>>> noticed
>>> that it does not work when fsid=root, rootdir=/some/path/ and then "/" is being
>>> exported.
>>> In this case next_mnt() is asked to find submounts of "/" but returns none.
>> I'm not clear as what you are saying... "rootdir=/some/path/" is not an
>> export option.
> 
> Sorry for being imprecise.
> rootdir= is an nfs.conf exports option.Point. But I still need the patch in the correct
format with the Signed-off-by...

steved.

>   
> Thanks,
> //richard
> 

