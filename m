Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D8A57F09E
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Jul 2022 19:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiGWR3Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 23 Jul 2022 13:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237980AbiGWR3Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 23 Jul 2022 13:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 302A818E3D
        for <linux-nfs@vger.kernel.org>; Sat, 23 Jul 2022 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658597362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u+klncQTfx026CmOqOx3EggB1n2iopTP/IL6mMWs8RI=;
        b=fTTLZnF8l8NRMjE0rYwaYioj6L5lkVmj+UFCZd0R13wC7vLHHNMvOXKEnn1tAKaTY2Fvuv
        np/gaHsTpu9pGwLMTTgyiu3LTkW8NekpWMVFR6DAZWYzrZZ525DhArA3xkA8F2aMp07EMX
        XBCDyj9IdlRnJ0ZWr389Jskclz2sYJI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-mVcvrwUEPTyxqqjMAuAxkQ-1; Sat, 23 Jul 2022 13:29:20 -0400
X-MC-Unique: mVcvrwUEPTyxqqjMAuAxkQ-1
Received: by mail-qv1-f72.google.com with SMTP id q3-20020ad45743000000b004735457f428so5073255qvx.23
        for <linux-nfs@vger.kernel.org>; Sat, 23 Jul 2022 10:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u+klncQTfx026CmOqOx3EggB1n2iopTP/IL6mMWs8RI=;
        b=tf6J8s3oS99rYtpNhaQbcEsPNg/8tI1m3/RCU46svObHC3La+IDXPAKJKqsj2iGLfK
         j20PwyRI/yPHIeBC5YbEhZ/2rcrIJOXrI3E6eqFIMnWCOATN1pkjT0OFsJiUoXMFzE4H
         QF2eizMFRSsI+E5vybCJmKfY8MzRVSmWRsDBWIYvqp25x/nBcwoOh/aZSCvxGhMnNfkg
         yiBPiuG/9fBOB2/L6i52UMM/rmKRqgbW6qVa14CIAtsjCE2W5ROhsawvwjZv0sUC6G+n
         CBiQnn040QWCaZRq8rPelT+eEcV0KzA1FcM1lT1RG2hSKeuDcBb4uZ/8ds4G54RSUdZD
         /gHg==
X-Gm-Message-State: AJIora9j50z3xpCZPWHklnzmgUqCW8LYBm2vCSM4Lr6KGrB9t0SM4jcv
        kWe9BKe+KUDtEqTFFkyaUXZuKk4cKkF5akPeVqFu8niFdNMSBQc6xbDs4qRqKvSIKmeYFhONBZW
        t/WeI/Y7wfmFKUURDJDrR
X-Received: by 2002:a05:620a:1904:b0:6b5:be58:ab22 with SMTP id bj4-20020a05620a190400b006b5be58ab22mr4031972qkb.673.1658597359365;
        Sat, 23 Jul 2022 10:29:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQXbj/XOsEtZUytKxfFEyqzS03ejBDY4TiXaJjevUKn8bvZ7hn7zrCwwf1PmW0hqfkReCPCw==
X-Received: by 2002:a05:620a:1904:b0:6b5:be58:ab22 with SMTP id bj4-20020a05620a190400b006b5be58ab22mr4031962qkb.673.1658597359105;
        Sat, 23 Jul 2022 10:29:19 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.98.133])
        by smtp.gmail.com with ESMTPSA id ec5-20020a05620a484500b006b61bf3153bsm3803735qkb.112.2022.07.23.10.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 10:29:18 -0700 (PDT)
Message-ID: <7bfafe56-0c13-a32d-093b-4d3684c4f2c7@redhat.com>
Date:   Sat, 23 Jul 2022 13:29:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Why keep var-lib-nfs-rpc_pipefs.mount around?
Content-Language: en-US
To:     Benjamin Coddington <bcodding@redhat.com>,
        Andreas Hasenack <andreas@canonical.com>
Cc:     linux-nfs@vger.kernel.org
References: <CANYNYEFSdBua3Ay6jGk2cacossVJ8_CzDgDBnFCjXfk5XSoGEQ@mail.gmail.com>
 <EE39279C-4E40-48C8-ABC9-707EB1AD6D79@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <EE39279C-4E40-48C8-ABC9-707EB1AD6D79@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

My apologies delayed response... extended PTO

On 7/11/22 9:13 AM, Benjamin Coddington wrote:
> On 8 Jul 2022, at 12:50, Andreas Hasenack wrote:
> 
>> Hi,
>>
>> I was tracking down a Debian/Ubuntu bug with nfs-utils 2.6.1 where in
>> one case, after installing the packages, you would end up with
>> rpc_pipefs mounted at the same time in two locations: /run/rpc_pipefs
>> and /var/lib/nfs/rpc_pipefs. The /run location is what debian/ubuntu
>> default to.
>>
>> After poking around a bit, I think I found out why that is
>> happening[1], but it led me to ask this question: why is
>> var-lib-nfs-rpc_pipefs.mount (and its corresponding rpc_pipefs.target
>> unit) still shipped, given that nfs-utils now has a generator?
> 
> Could just be an oversight, or perhaps a better reason exists.  The
> nfs-utils userspace has to handle a lot of different cases and legacy
> setups.
> 
> Steve D, do you know?
Its not clear to me, if the read from nfs.conf does not
happen how changing the rpc_pipefs directory could happen.

When the read from nfs.conf happens and the rpc_pipefs directory
is not defined, the compiled in default rpc_pipefs directory
will be used and the generator will exit and not
generating the systemd files (using the installed ones).

If the rpc_pipefs directory is defined in nfs.conf, the
generator will set up that directory as the
rpc_pipefs directory and systemd files will be
generated.

So by taking out the nfs.conf read, the only way to change
the default rpc_pipefs directory is to recompile nfs-utils.

steved.
> 
> Ben
> 
>> Shouldn't the generator be enough for all cases, where rpc_pipefs is
>> mounted in the default compile-time location, or changed via a config
>> change to nfs.conf? I know currently it checks[2] whether the config
>> points at the default location, but that check could just be skipped
>> and then the generator would always produce the correct mount and
>> target units.
>>
>>
>> 1. 
>> https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/1971935/comments/22 
>>
>> 2. 
>> https://salsa.debian.org/kernel-team/nfs-utils/-/blob/master/systemd/rpc-pipefs-generator.c#L138 
>>
> 

