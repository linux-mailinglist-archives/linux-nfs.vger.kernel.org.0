Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E7357D4DB
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jul 2022 22:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiGUUh5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 16:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUUh4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 16:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4395E2CDD7
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 13:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658435874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2OZ3+S9VT9Iku9WAAuuN6DyLbhdnBdDLcNWo0xsAJ0=;
        b=YJOM0mIx/4+QrJ572J2hV7r6ymSRC7oJsk4qOVky/a0Tto/+Q1ppWh69oFo+RLbHdPoNsy
        udSeGYnuBsmgCxa265Cnh8aIDoHGwEvkACSLLog3kjV5a3adK0zpmAvhqi1faN2fVepf5+
        RbHetqW7Ltf1fOyDpbvP6iFPqXf05ww=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-IT_XJaNkPRaW-TN5kUHz2g-1; Thu, 21 Jul 2022 16:37:53 -0400
X-MC-Unique: IT_XJaNkPRaW-TN5kUHz2g-1
Received: by mail-qk1-f197.google.com with SMTP id n15-20020a05620a294f00b006b5768a0ed0so2150395qkp.7
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 13:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x2OZ3+S9VT9Iku9WAAuuN6DyLbhdnBdDLcNWo0xsAJ0=;
        b=PVJLNgxIcSr0WdsBfOZHALIhX7iizrs0WWqXyvFjpjULM7E1o2f/7x2YuCOjC5RIUb
         84We9TQp5BiiXkaJyHhExdPYesDwJnG60pOl8u3VMCfnOMObGhX+/Bq7QNR76rbiyF8l
         ZNF/mJqeGfd7MeYHcZ8Inp8d6l4ab6rV+/GAKpqV//95YP/JM4uXlvxlVyhzrJcPFfj5
         FgVDpg6CnBYxJn8IJuWz/9XEHOIAaEAz+R89PdRJvFe2qmXxcTnhLAJQeZhsPg+12vPf
         ULDk1uY1h8vIoYJVHKUTV39IPeY4isxWWb8pAGCZX2I3OPApxKGcMNpABDTAwqLBdM8w
         LbBw==
X-Gm-Message-State: AJIora9zVqN7sm9V25hkAL7VnvkuZHsbaN24ADv82shhojcj1TZYqLmQ
        uOwm3w1gWCXvyAsfAS+Wfv726CxTkUU01RAB0mpjCZfC2Tw6bUM9bhTPe5ts3r50TF9RZXV5XCu
        OAOxS0PvzGV4hcQgvkert
X-Received: by 2002:ac8:5f4d:0:b0:31f:c32:1b35 with SMTP id y13-20020ac85f4d000000b0031f0c321b35mr314311qta.623.1658435872505;
        Thu, 21 Jul 2022 13:37:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v/nIKWD8Xjsb76Lcr6eFB6Qw/LcIxDbV2y1p35aXmad23X1YR4ZMEWOaxYpHlPs1bBMHU2UA==
X-Received: by 2002:ac8:5f4d:0:b0:31f:c32:1b35 with SMTP id y13-20020ac85f4d000000b0031f0c321b35mr314293qta.623.1658435872235;
        Thu, 21 Jul 2022 13:37:52 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.98.133])
        by smtp.gmail.com with ESMTPSA id cc25-20020a05622a411900b0031ea95094dcsm1884060qtb.72.2022.07.21.13.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 13:37:51 -0700 (PDT)
Message-ID: <78f2a7c3-e298-9b32-b1a6-20854e0de41b@redhat.com>
Date:   Thu, 21 Jul 2022 16:37:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Thread safe client destruction
Content-Language: en-US
To:     Attila Kovacs <attila.kovacs@cfa.harvard.edu>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     libtirpc List <libtirpc-devel@lists.sourceforge.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <53af8ec6-4ece-09b2-9499-d46d0fdfaa15@cfa.harvard.edu>
 <4D490A86-E873-40E7-A30E-9189B127C65C@oracle.com>
 <9241d8a5-d341-aa84-9aee-6e84377dbe9d@cfa.harvard.edu>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <9241d8a5-d341-aa84-9aee-6e84377dbe9d@cfa.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

On 7/21/22 3:19 PM, Attila Kovacs wrote:
> Hi Chuck,
> 
> 
> I'm not adding any new functionality here. I'm merely trying to fix 
> what's already there but broken (in my opinion). :-)
I agree with this.... And I will be more that willing
to reformat the patches make it easier to review

I don't want nits like that to get in the way this good work,
but it would be good if you could added the
     Signed-off-by: Attila Kovacs <attila.kovacs@cfa.harvard.edu>

line, which is described in [1]

steved.

[1] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
> 
> -- A.
> 
> 
> On 7/21/22 14:45, Chuck Lever III wrote:
>>
>>
>>> On Jul 21, 2022, at 2:41 PM, Attila Kovacs 
>>> <attila.kovacs@cfa.harvard.edu> wrote:
>>>
>>> Hi again,
>>>
>>>
>>> I found yet more potential MT flaws in clnt_dg.c and clnt_vg.c.
>>
>> IIRC libtirpc is not MT-enabled because it was forked from the
>> Solaris libtirpc before MT-enablement was completed. I could
>> be remembering incorrectly.
>>
>> Therefore I think we would need some unit tests along with the
>> improvements you propose. There's a test suite somewhere, but
>> someone else will need to provide details.
>>
>> (and also, please inline your patch submissions rather than
>> attaching them, to make it easier for us to review. thanks!)
>>
>>
>>> 1. In clnt_dg.c in clnt_dg_freeres(), cu_fd_lock->active is set to 
>>> TRUE, with no corresponding clearing when the operation (*xdr_res() 
>>> call) is completed. This would leave other waiting operations blocked 
>>> indefinitely, effectively deadlocked. For comparison, 
>>> clnt_vd_freeres() in clnt_vc.c does not set the active state to TRUE. 
>>> I believe the vc behavior is correct, while the dg behavior is a bug.
>>>
>>> 2. If clnt_dg_destroy() or clnt_vc_destroy() is awoken with other 
>>> blocked operations pending (such as clnt_*_call(), clnt_*_control(), 
>>> or clnt_*_freeres()) but no active operation currently being 
>>> executed, then the client gets destroyed. Then, as the other blocked 
>>> operations get subsequently awoken, they will try operate on an 
>>> invalid client handle, potentially causing unpredictable behavior and 
>>> stack corruption.
>>>
>>> The proposed fix is to introduce a simple mutexed counting variable 
>>> into the client lock structure, which keeps track of the number of 
>>> pending blocking operations on the client. This way, clnt_*_destroy() 
>>> can check if there are any operations pending on a client, and keep 
>>> waiting until all pending operations are completed, before the client 
>>> is destroyed safely and its resources are freed.
>>>
>>> Attached is a patch with the above fixes.
>>>
>>> -- A.<clnt_mt_safe_destroy.patch>
>>
>> -- 
>> Chuck Lever
>>
>>
>>
> 

