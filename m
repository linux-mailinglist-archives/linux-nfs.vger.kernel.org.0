Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3755457D3FF
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jul 2022 21:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiGUTTa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 15:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiGUTT3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 15:19:29 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212E3E4
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 12:19:27 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id w29so2010205qtv.9
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cfa.harvard.edu; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=STUwAba5KowMsr/sM8XuB7pVt9FfJQIJ9gIbt1IRYbQ=;
        b=parYqZAlsTxDpU+khdH6gpq15hxDEORvuWYDDjXhefjIxpVhuruPJiInHBAp0pfmlM
         /3IT2liJRkMFW2ncSM0jZC4L5qAyCo+Me6L/fGtvdrMy0xK4LBiTU76ZluPies5Mli4t
         zLSUN4W9OY5ZAacyufF2yvHOWtDCSRuCYiWGedJ12aPLOIC3SrkFL7b2mQNx7nC70R/1
         Jff4gXQdp14qU9vdJNdcnIeCOJMN5sxzgYhwoXLCIq5iH+afoWEKapIGoDtQt0VpXvF9
         rrcT22BSS7YHKMsnKWS4i5jFZMeC7iqJ1X0EeiUr20rZ0LN5pKHmdiBA305rW2/xpaKe
         ecFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=STUwAba5KowMsr/sM8XuB7pVt9FfJQIJ9gIbt1IRYbQ=;
        b=jL75NWAqRz7etoMsPVGCYAU0Pwq1OU0jqEsBVpYlraCm4njmmQvq/xieH9XVi/dY+i
         wrkDOEMLiOUEjW9oASK1KDtUQmurIPx1K8LlzKXzdFF/NP7N/OYee4cUmvB3Eig7V4yd
         PzVn+hgotCq+6+5p9q3PXYDbU1JcwSeFX4XT27TGy70hgZ+pdwjKM7M8YHZ7iexie2BI
         nzfoDXXLMykt3nSt1LCAfmxmPgmoFx0KTnWAZ36yPksutzWHKc/SCtR1Z59wYxNvIteK
         zUV9XdUV6GypUTD3v/afz0oXA3tG2HLoWSFTO1LaYOh2tqYKtiwgQNegemNM7A+G2NZv
         +XGA==
X-Gm-Message-State: AJIora9MAqxeHA59WiNv2UaIBC6ds3IT4WAj6lRK6aFNvvUtxQuYRIRo
        gNBfeU510ORnqtsW8RNQEV5XQQ==
X-Google-Smtp-Source: AGRyM1vAx1vdC+LrIsRzPXhFGycQKdQUYTFacuwG0w9lo7IcXr4edr3Il/dt86SEPMsDTFNTi3fcpA==
X-Received: by 2002:ac8:5f09:0:b0:31e:9704:dfab with SMTP id x9-20020ac85f09000000b0031e9704dfabmr29742qta.375.1658431166052;
        Thu, 21 Jul 2022 12:19:26 -0700 (PDT)
Received: from [192.168.0.156] (pool-72-70-58-62.bstnma.fios.verizon.net. [72.70.58.62])
        by smtp.gmail.com with ESMTPSA id k21-20020a05620a415500b006b5ed1eccc5sm2199317qko.44.2022.07.21.12.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 12:19:25 -0700 (PDT)
Message-ID: <9241d8a5-d341-aa84-9aee-6e84377dbe9d@cfa.harvard.edu>
Date:   Thu, 21 Jul 2022 15:19:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Thread safe client destruction
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     libtirpc List <libtirpc-devel@lists.sourceforge.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <53af8ec6-4ece-09b2-9499-d46d0fdfaa15@cfa.harvard.edu>
 <4D490A86-E873-40E7-A30E-9189B127C65C@oracle.com>
From:   Attila Kovacs <attila.kovacs@cfa.harvard.edu>
In-Reply-To: <4D490A86-E873-40E7-A30E-9189B127C65C@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,


I'm not adding any new functionality here. I'm merely trying to fix 
what's already there but broken (in my opinion). :-)

-- A.


On 7/21/22 14:45, Chuck Lever III wrote:
> 
> 
>> On Jul 21, 2022, at 2:41 PM, Attila Kovacs <attila.kovacs@cfa.harvard.edu> wrote:
>>
>> Hi again,
>>
>>
>> I found yet more potential MT flaws in clnt_dg.c and clnt_vg.c.
> 
> IIRC libtirpc is not MT-enabled because it was forked from the
> Solaris libtirpc before MT-enablement was completed. I could
> be remembering incorrectly.
> 
> Therefore I think we would need some unit tests along with the
> improvements you propose. There's a test suite somewhere, but
> someone else will need to provide details.
> 
> (and also, please inline your patch submissions rather than
> attaching them, to make it easier for us to review. thanks!)
> 
> 
>> 1. In clnt_dg.c in clnt_dg_freeres(), cu_fd_lock->active is set to TRUE, with no corresponding clearing when the operation (*xdr_res() call) is completed. This would leave other waiting operations blocked indefinitely, effectively deadlocked. For comparison, clnt_vd_freeres() in clnt_vc.c does not set the active state to TRUE. I believe the vc behavior is correct, while the dg behavior is a bug.
>>
>> 2. If clnt_dg_destroy() or clnt_vc_destroy() is awoken with other blocked operations pending (such as clnt_*_call(), clnt_*_control(), or clnt_*_freeres()) but no active operation currently being executed, then the client gets destroyed. Then, as the other blocked operations get subsequently awoken, they will try operate on an invalid client handle, potentially causing unpredictable behavior and stack corruption.
>>
>> The proposed fix is to introduce a simple mutexed counting variable into the client lock structure, which keeps track of the number of pending blocking operations on the client. This way, clnt_*_destroy() can check if there are any operations pending on a client, and keep waiting until all pending operations are completed, before the client is destroyed safely and its resources are freed.
>>
>> Attached is a patch with the above fixes.
>>
>> -- A.<clnt_mt_safe_destroy.patch>
> 
> --
> Chuck Lever
> 
> 
> 
