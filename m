Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8090F517A2E
	for <lists+linux-nfs@lfdr.de>; Tue,  3 May 2022 00:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiEBWul (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 18:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiEBWuj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 18:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 244B3FD1F
        for <linux-nfs@vger.kernel.org>; Mon,  2 May 2022 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651531625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZefZSRR7jtNKy9agW1JpXFTVya9dxOu2aS0VzOmv0wU=;
        b=SDq2VzhHkwo9Tdqftr8POuzqrF4lMgGQrAqpyPyFQvdKEl5vghOUoIrxKYS9xYjBJvnuBM
        U7h28ZojDFiQyZAp2NkaHYFDlgB9VI+24W58FXkt2OJ9bqcPMDlcs8DPXbMERj8Y9awovb
        iAaQDGeliwidguObimPSVI0YJx6dNZw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-wn6ULDjDOxuXveKqGvNxQQ-1; Mon, 02 May 2022 18:47:02 -0400
X-MC-Unique: wn6ULDjDOxuXveKqGvNxQQ-1
Received: by mail-oo1-f70.google.com with SMTP id t19-20020a4a96d3000000b003295d7ce159so9032545ooi.11
        for <linux-nfs@vger.kernel.org>; Mon, 02 May 2022 15:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZefZSRR7jtNKy9agW1JpXFTVya9dxOu2aS0VzOmv0wU=;
        b=AjezLvbPzpwyHR4yC6rPVg4LCctXQoe0WM47fK/maH0KWWYIlL1xBrqCk0hxrCCazn
         lfQ7yqs1NIDGu/mAqQElsQTKMn6q1RwUQkrI1/km2A9w9VrAtaqP/BOwa2+YZWGbRWUX
         cFjQ/J4nRLcJZtF8b34FHrGbAzUDbNvjWl3Jt+I58J86NqlT60bMXvlEiJ3rxgKitsRf
         GX9/JFldDMAReiTVun0WrPAGlTdiE3wVaWNRr1oPTTqBtz6VkTORBfl+rX1+0jjm1Ueq
         AL2CT5zuT4iwE7Tasl+n53DkhHTiUI0po7zkV0UuiAX7lDXKjBlnCALBYM19YmqzjtB2
         H2Ng==
X-Gm-Message-State: AOAM5315PwnRCmnTAK8jKvOECGm0iot3g5M1vuYlXgg/Wk64EGGxH7dg
        hSaJZFGVuNgJLD5ucoAIa4GtMq0UJpk6/9zDyWujAtLtji2a6N7fr8bvEx4aLP0z+az95f1uClw
        fQCN8OAoutwkHlB68SeOL
X-Received: by 2002:a05:6830:19da:b0:606:b04:6dfb with SMTP id p26-20020a05683019da00b006060b046dfbmr4102469otp.51.1651531621649;
        Mon, 02 May 2022 15:47:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHG/q3wdb4rpvVqXywavFI/DhSDKWJNoQRcXezzOJNDExlkdFNwR3GBn8x5QnVV1D5IST44Q==
X-Received: by 2002:a05:6830:19da:b0:606:b04:6dfb with SMTP id p26-20020a05683019da00b006060b046dfbmr4102464otp.51.1651531621338;
        Mon, 02 May 2022 15:47:01 -0700 (PDT)
Received: from [10.10.70.149] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id w5-20020a9d70c5000000b0060603221268sm3314066otj.56.2022.05.02.15.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 15:47:01 -0700 (PDT)
Message-ID: <929b0a83-7a10-8a26-941f-3819c957ba7a@redhat.com>
Date:   Mon, 2 May 2022 18:46:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/5] nfs-utils: Improving NFS re-exports
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-nfs@vger.kernel.org, david@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, chris.chilvers@appsbroker.com
References: <20220502085045.13038-1-richard@nod.at>
 <20220502161713.GI30550@fieldses.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220502161713.GI30550@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/2/22 12:17 PM, J. Bruce Fields wrote:
> On Mon, May 02, 2022 at 10:50:40AM +0200, Richard Weinberger wrote:
>> This is the first non-RFC iteration of the NFS re-export
>> improvement series for nfs-utils.
>> While the kernel side[0] didn't change at all and is still small,
>> the userspace side saw much more changes.
>>
>> The core idea is adding new export option: reeport=
>> Using reexport= it is possible to mark an export entry in the exports
>> file explicitly as NFS re-export and select a strategy how unique
>> identifiers should be provided.
>> Currently two strategies are supported, "auto-fsidnum" and
>> "predefined-fsidnum", both use a SQLite database as backend to keep
>> track of generated ids.
>> For a more detailed description see patch "exports: Implement new export option reexport=".
>> I choose SQLite because nfs-utils already uses it and using SQL ids can nicely
>> generated and maintained. It will also scale for large setups where the amount
>> of subvolumes is high.
>>
>> Beside of id generation this series also addresses the reboot problem.
>> If the re-exporting NFS server reboots, uncovered NFS subvolumes are not yet
>> mounted and file handles become stale.
>> Now mountd/exportd keeps track of uncovered subvolumes and makes sure they get
>> uncovered while nfsd starts.
>>
>> The whole set of features is currently opt-in via --enable-reexport.
> 
> Can we remove that option before upstreaming?
> 
> For testing purposes it may makes sense to be able to turn the new code
> on and off quickly.  But for something we're really going to support,
> it's just another hurdle for users to jump through, and another case we
> probably won't remember to test.  The export options themselves should
> be enough configuration.
> 
> Anyway, basically sounds reasonable to me.  I'll try to give it a proper
> review sometime, feel free to bug me if I don't get to it in a week or
> so.
How about --disable-reexport? So it is on by default to help testing
but if there are issues we can turn it off...

steved.

> 
> --b.
> 
> 
>> I'm also not sure about the rearrangement of the reexport code,
>> currently it is a helper library.
>>
>> A typical export entry on a re-exporting server looks like:
>> 	/nfs *(rw,no_root_squash,no_subtree_check,crossmnt,reexport=auto-fsidnum)
>> reexport=auto-fsidnum will automatically assign an fsid= to /nfs and all
>> uncovered subvolumes.
>>
>> Richard Weinberger (5):
>>    Implement reexport helper library
>>    exports: Implement new export option reexport=
>>    export: Implement logic behind reexport=
>>    export: Avoid fsid= conflicts
>>    reexport: Make state database location configurable
>>
>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/rw/misc.git/log/?h=nfs_reexport_clean
>>
>>   configure.ac                   |  12 ++
>>   nfs.conf                       |   3 +
>>   support/Makefile.am            |   4 +
>>   support/export/Makefile.am     |   2 +
>>   support/export/cache.c         |  71 ++++++-
>>   support/export/export.c        |  27 ++-
>>   support/include/nfslib.h       |   1 +
>>   support/nfs/Makefile.am        |   1 +
>>   support/nfs/exports.c          |  68 +++++++
>>   support/reexport/Makefile.am   |   6 +
>>   support/reexport/reexport.c    | 354 +++++++++++++++++++++++++++++++++
>>   support/reexport/reexport.h    |  39 ++++
>>   systemd/Makefile.am            |   4 +
>>   systemd/nfs-server-generator.c |  14 +-
>>   systemd/nfs.conf.man           |   6 +
>>   utils/exportd/Makefile.am      |   8 +-
>>   utils/exportd/exportd.c        |   5 +
>>   utils/exportfs/Makefile.am     |   6 +
>>   utils/exportfs/exportfs.c      |  21 +-
>>   utils/exportfs/exports.man     |  31 +++
>>   utils/mount/Makefile.am        |   7 +
>>   utils/mountd/Makefile.am       |   6 +
>>   utils/mountd/mountd.c          |   1 +
>>   utils/mountd/svc_run.c         |   6 +
>>   24 files changed, 690 insertions(+), 13 deletions(-)
>>   create mode 100644 support/reexport/Makefile.am
>>   create mode 100644 support/reexport/reexport.c
>>   create mode 100644 support/reexport/reexport.h
>>
>> -- 
>> 2.31.1
> 

