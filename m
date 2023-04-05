Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8276D87F4
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Apr 2023 22:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjDEUNE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Apr 2023 16:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbjDEUMx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Apr 2023 16:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6C57A9A
        for <linux-nfs@vger.kernel.org>; Wed,  5 Apr 2023 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680725402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HzD0To6Db7sUiL5rG2eHkS7TPqNWenK7Bcv6boGqr+M=;
        b=JGgtfIHqO5CML2/MA1cG6479k5so0tIh5Twlc3TA5Lbnhe7AIJAAjhfyI9e6Lhe5WEo5jx
        qTLWV2cE4Dm9Cpdr2zUQQsmQZJxh0sKVBBvoQj9hOt8aSA38Mmf8sBN/nCmlgdvKcbtfN9
        8qlKdosnHc2hPHvwN+UGV6qHZVUACKQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-G65Vjdj0NRikqW4SmUKb6Q-1; Wed, 05 Apr 2023 16:10:01 -0400
X-MC-Unique: G65Vjdj0NRikqW4SmUKb6Q-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-5bb2d463855so1738096d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 05 Apr 2023 13:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680725400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HzD0To6Db7sUiL5rG2eHkS7TPqNWenK7Bcv6boGqr+M=;
        b=cTZNhIRbBc8RTicplzLZwRqZ3iz1jH3ifocgWgptmsgUqrZ/tmCih6qjsl7DFqH3vA
         c9oVfLHEMk2bpw5Oow15RiVsPV6emKMUbbDGaLbzuclgexLeyyCDkJ+HoM4X9u2VJLw3
         ZYBL/BCYq0zEm5mDkYKriOw1UODGCYB4FbaGsc6R/Z6genWu+n21V7ciuiarvNHqaBS+
         1lrJ93bBySmFm3K+rn1LVQpp5C2K9XHkntpkOIo5ySOsiqXl8dxGslx7DFs8Lne2GAsV
         6XA7FSCsFljcFe6AowrDeUZHmExtwS/kew8RAkIoKDcFwE9TxqLboGjZYc4/KNXJl7Ih
         BnIw==
X-Gm-Message-State: AAQBX9fkzt4imzbaZNcsRWIcCYaI4bBqCpRA70VZpWsQA7nlvIsVoSKr
        RE8AVABUyHJGO36ArTDNWZUuTAHEjNEJxvBvsWNZ6GgL9X9NmQHhQ2tLc+ZeY1g7/rc+ax6Sj6l
        IofjwYIYXpjYQeIUDuRpP
X-Received: by 2002:a05:6214:4001:b0:56c:d9e:c9a0 with SMTP id kd1-20020a056214400100b0056c0d9ec9a0mr5548426qvb.1.1680725399744;
        Wed, 05 Apr 2023 13:09:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350YgvcDUnLyLth7HzQkm2vM4oB3iDETod491J6r0QuKQCtdlBIcPOfuyPrSftlSR34CNd/NObA==
X-Received: by 2002:a05:6214:4001:b0:56c:d9e:c9a0 with SMTP id kd1-20020a056214400100b0056c0d9ec9a0mr5548394qvb.1.1680725399418;
        Wed, 05 Apr 2023 13:09:59 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.174.217])
        by smtp.gmail.com with ESMTPSA id k7-20020a0cc787000000b005e5afa32743sm1225608qvj.33.2023.04.05.13.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 13:09:59 -0700 (PDT)
Message-ID: <7c3b9f3e-e40a-1389-d03a-eb9f9a505c17@redhat.com>
Date:   Wed, 5 Apr 2023 16:09:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/4] nfs-utils changes for RPC-with-TLS
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Rick Macklem <rick.macklem@gmail.com>,
        "kernel-tls-handshake@lists.linux.dev" 
        <kernel-tls-handshake@lists.linux.dev>
References: <168009806320.2522.10415374334827613451.stgit@manet.1015granger.net>
 <1c59beaf-63b6-ee39-b339-339a0c7e72b9@redhat.com>
 <AC76C4AB-F5DE-40B2-8A0D-4BADC7EFD918@oracle.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <AC76C4AB-F5DE-40B2-8A0D-4BADC7EFD918@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/5/23 12:45 PM, Chuck Lever III wrote:
> 
> 
>> On Apr 5, 2023, at 12:40 PM, Steve Dickson <steved@redhat.com> wrote:
>>
>> Hey Chuck,
>>
>> On 3/29/23 10:08 AM, Chuck Lever wrote:
>>> Hi Steve-
>>> This is client- and server-side nfs-utils support for RPC-with-TLS.
>>> The client side support at this point is only a man page update
>>> since the kernel handles mount option processing itself.
>>> The server implementation can support both the opportunistic use of
>>> transport layer security (it will be used if the client cares to),
>>> and the required use of transport layer security (the server
>>> requires the client to use it to access a particular export).
>>> Without any other user space componentry, this implementation is
>>> able to handle clients that request the use of RPC-with-TLS. To
>>> support security policies that restrict access to exports based on
>>> the client's use of TLS, modifications to exportfs and mountd are
>>> needed. These are contained in this post, and can also be found
>>> here:
>>> git://git.linux-nfs.org/projects/cel/nfs-utils.git
>>> The kernel patches, along with the handshake upcall, are carried in
>>> the topic-rpc-with-tls-upcall branch available from:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>
>> Just wondering if these patch should wait until the kernel
>> patches reach mainline (aka rawhide)?
> 
> The kernel changes do not require these, they add more
> features. Thus I don't think it's harmful to let them
> wait for the kernel patches.
> 
> For testing, Jeff has set up a Fedora COPR with these,
> the ktls-utils package, and an updated kernel.
> 
> What could be checked now is whether these nfs-utils
> changes will break something on pre-TLS kernels.
Fair enough... I'll have a release ready for the
up coming Bakeathon...

steved.
> 
> 
>> steved.
>>
>>> Soon I hope to compose a new man page in Section 7 that will provide
>>> an overview and quick set-up guidance for NFS's use of RPC-with-TLS.
>>> Changes since v1:
>>> - Addressed Jeff's review comments
>>> - Updated nfs.man as well
>>> ---
>>> Chuck Lever (4):
>>>        libexports: Fix whitespace damage in support/nfs/exports.c
>>>        exports: Add an xprtsec= export option
>>>        exports(5): Describe the xprtsec= export option
>>>        nfs(5): Document the new "xprtsec=" mount option
>>>   support/export/cache.c       |  15 ++++++
>>>   support/include/nfs/export.h |  14 +++++
>>>   support/include/nfslib.h     |  14 +++++
>>>   support/nfs/exports.c        | 100 ++++++++++++++++++++++++++++++++---
>>>   utils/exportfs/exportfs.c    |   1 +
>>>   utils/exportfs/exports.man   |  51 +++++++++++++++++-
>>>   utils/mount/nfs.man          |  34 +++++++++++-
>>>   7 files changed, 219 insertions(+), 10 deletions(-)
>>> --
>>> Chuck Lever
> 
> 
> --
> Chuck Lever
> 
> 

