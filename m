Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B1B6C8536
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Mar 2023 19:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjCXSg1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Mar 2023 14:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjCXSgZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Mar 2023 14:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5582D41
        for <linux-nfs@vger.kernel.org>; Fri, 24 Mar 2023 11:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679682931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R7TI+Oiejs6FmxrbX9LeYOQu7x25DMdRpUEhrsC0iQI=;
        b=Wf7HX0Lg6Om/WLnW28xXKZUydmQFrA2Pd7FKlbfmRL0RcPO5k1ZoYKQcARX6WYDtrt5b2n
        M0gsbDeD09zAlZXhpv/Sc13u6pP5iod9QVD4lFOV40K6ln78BaoYDHpE9pXFVKSTyDG1pN
        1oO7xl6JYcH4x1XjHWZQ3HBt3+HY1yA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-X0_-OYswPD-2zuZmNrV1Cw-1; Fri, 24 Mar 2023 14:35:29 -0400
X-MC-Unique: X0_-OYswPD-2zuZmNrV1Cw-1
Received: by mail-qk1-f199.google.com with SMTP id d72-20020ae9ef4b000000b007467a30076fso1206614qkg.18
        for <linux-nfs@vger.kernel.org>; Fri, 24 Mar 2023 11:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679682929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7TI+Oiejs6FmxrbX9LeYOQu7x25DMdRpUEhrsC0iQI=;
        b=EoWYsJKhjkp237x84TcxAe1X2gPJfCaMnE+hHXahmtfU727fAnDh0kjuGb8M/FrwVV
         faM668nnRbhrqnLaUoIevh19IubNy1/UJ5M+I60LvTrJhd/+iAXGgO82yFP0CiCL3c3v
         E9lelFsKmrhRAKB9s3krDTt94aOo1vJaeNfZhzstkhr62tTosMSnFBCR4CRaaNoXpkFB
         Af1QEcXulPEd/mQBwq2vq6BS3UbWfIHuO7Exv1lg1oQ8nF35iAod8BvL590+n1YHDFPs
         XnGejrviDcsD622W9RyXVii9CVgediPJejoV35AEPm1cqu/y86hmWhQPPsAS+EA9ykaO
         7VVg==
X-Gm-Message-State: AAQBX9e8H0n6n2IHzczguXKFKbVO7vkQJDdZCEh4TIG6JRhQngbEsS5f
        yw5PqjGmcK5nXKWQs/dNFpiDsLcE9xQ/kzBpqC4dFqJH6tIsgJIuuRBWbOMGH/tkTMe6H8jFV2I
        IzGfBVKkDlP3UVwzilITM
X-Received: by 2002:a05:6214:27c6:b0:5ac:463b:a992 with SMTP id ge6-20020a05621427c600b005ac463ba992mr5814903qvb.0.1679682928874;
        Fri, 24 Mar 2023 11:35:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350ajiqiPorBeR3ZJvZFwkQ00wUQV1BbYRsb7nKnJNoZxR4AeMfyz299H9U2XxEc53Liv/dd1vA==
X-Received: by 2002:a05:6214:27c6:b0:5ac:463b:a992 with SMTP id ge6-20020a05621427c600b005ac463ba992mr5814876qvb.0.1679682928583;
        Fri, 24 Mar 2023 11:35:28 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.66])
        by smtp.gmail.com with ESMTPSA id u19-20020a0ced33000000b005dd8b9345c0sm877035qvq.88.2023.03.24.11.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 11:35:27 -0700 (PDT)
Message-ID: <89a49550-d7f2-22df-5f6d-b9b8c66604de@redhat.com>
Date:   Fri, 24 Mar 2023 14:35:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 0/4] nfs-utils changes for RPC-with-TLS server
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
 <d5c93e97f10a8ae803efaad02559dd118e9b9b6f.camel@kernel.org>
 <da936d7d-a864-a2ff-64a4-a295653a6aa7@redhat.com>
 <7AC1BDBB-B6E3-49A8-A468-C045F0218495@oracle.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <7AC1BDBB-B6E3-49A8-A468-C045F0218495@oracle.com>
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



On 3/23/23 2:01 PM, Chuck Lever III wrote:
> 
> 
>> On Mar 23, 2023, at 1:57 PM, Steve Dickson <steved@redhat.com> wrote:
>>
>>
>>
>> On 3/21/23 7:52 AM, Jeff Layton wrote:
>>> On Mon, 2023-03-20 at 10:35 -0400, Chuck Lever wrote:
>>>> Hi Steve-
>>>>
>>>> This is server-side support for RPC-with-TLS, to accompany similar
>>>> support in the Linux NFS client. This implementation can support
>>>> both the opportunistic use of transport layer security (it will be
>>>> used if the client cares to) and the required use of transport
>>>> layer security (the server requires the client to use it to access
>>>> a particular export).
>>>>
>>>> Without any other user space componentry, this implementation will
>>>> be able to handle clients that request the use of RPC-with-TLS. To
>>>> support security policies that restrict access to exports based on
>>>> the client's use of TLS, modifications to exportfs and mountd are
>>>> needed. These can be found here:
>>>>
>>>> git://git.linux-nfs.org/projects/cel/nfs-utils.git
>>>>
>>>> They include an update to exports(5) explaining how to use the new
>>>> "xprtsec=" export option.
>>>>
>>>> The kernel patches, along with the the handshake upcall, are carried
>>>> in the topic-rpc-with-tls-upcall branch available from:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>>>
>>>> This was posted under separate cover.
>>>>
>>>> ---
>>>>
>>>> Chuck Lever (4):
>>>>        libexports: Fix whitespace damage in support/nfs/exports.c
>>>>        exports: Add an xprtsec= export option
>>>>        exportfs: Push xprtsec settings to the kernel
>>>>        exports.man: Add description of xprtsec= to exports(5)
>>>>
>>>>
>>>>   support/export/cache.c       |  15 ++++++
>>>>   support/include/nfs/export.h |   6 +++
>>>>   support/include/nfslib.h     |  14 +++++
>>>>   support/nfs/exports.c        | 100 ++++++++++++++++++++++++++++++++---
>>>>   utils/exportfs/exportfs.c    |   1 +
>>>>   utils/exportfs/exports.man   |  45 +++++++++++++++-
>>>>   6 files changed, 172 insertions(+), 9 deletions(-)
>>>>
>>> Nice work, Chuck! This all looks pretty straightforward. I have a
>>> (minor) concern about potentially blocking nfsd threads for up to 20s in
>>> a handshake, but this seems like a good place to start.
>> Yes! But Will here be a V2 with the suggested changes?
> 
> I've done the suggested updates in my private tree already, so I can post a refresh soon.
Fair enough.
> 
> 
>> It would be good to get a new release with these patches
>> in before the upcoming Bakeathon.
> 
> The concept and operation of xprtsec= is pretty new... would there be a problem if all this were to change significantly after community review?
Not a problem at all! I was just thinking about get the patches into
Fedora rawhide to get some testing...

steved.

> 
> --
> Chuck Lever
> 
> 

