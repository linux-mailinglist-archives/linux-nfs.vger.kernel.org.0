Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24BA6F4FA5
	for <lists+linux-nfs@lfdr.de>; Wed,  3 May 2023 07:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjECFHG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 May 2023 01:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjECFHG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 May 2023 01:07:06 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4102D4E
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 22:07:05 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so2909054a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 May 2023 22:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683090423; x=1685682423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sqshf33Iww6QPGAizpUKNDbXiPGE6mIC6LykVBeKLxw=;
        b=Q+EElk+QZ0/hZL+q09MLoCEyDkpJE5UEtAoSzepHNg2jeM3is2y7rHBdr+t5ZNa6IL
         UvGREvuJLUH77TE+mMo7f2S69sXOorFwgdfHguCqXZ+gaN6tmmvF3YLQnKbqitgcukKt
         5S668JVz4o0B5C+n+YSgnkza6rDp9NNRfUt1/15Wwj2aa13whDcxteQBEE5uISBbsl6f
         TvKK30BfHd+c7fhcFsh6jzbZyGgs85Hd0MrAWu7uEXCthNKlDJ0BE1M1VHl+kUYj4rkD
         6v+KBfkaQCCJXdrdQbUAsUjInkIia5pIT5Sxgc9tyLd7dL33hYiMoMTk762R6FC8muLY
         cDDQ==
X-Gm-Message-State: AC+VfDzdbp25I3HcVh95MnIySE3nleWJw5+MbX19qNYJDZSJrOz013gp
        KFx1ao6qroWLUyLCtS4Ro64=
X-Google-Smtp-Source: ACHHUZ5X1Ik3BTRd4Z9ytOwMgVLb5YwKIogU3fLMPtbLOtBv7bhp7hg55oGVsoWhsWBPyUhB93C2Kg==
X-Received: by 2002:aa7:d4c7:0:b0:504:8a0f:13ca with SMTP id t7-20020aa7d4c7000000b005048a0f13camr684305edr.10.1683090423327;
        Tue, 02 May 2023 22:07:03 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id w6-20020aa7d286000000b0050be0b14672sm294806edq.3.2023.05.02.22.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 22:07:02 -0700 (PDT)
Message-ID: <8cd5d041-77c3-51dd-a960-7fd8ce1d1271@kernel.org>
Date:   Wed, 3 May 2023 07:07:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] SUNRPC: Fix encoding of rejected RPCs
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org
References: <168305395091.2266.16355121702708383278.stgit@bazille.1015granger.net>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <168305395091.2266.16355121702708383278.stgit@bazille.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 02. 05. 23, 20:59, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Jiri Slaby says:
>> I bisected to this ... as it breaks nfs3-only servers in 6.3.
>> I.e. /etc/nfs.conf containing:
>> [nfsd]
>> vers4=no
>>
>> The client sees:
>>   mount("10.0.2.15:/tmp", "/mnt", "nfs", 0, "vers=4.2,addr=10.0.2.15,clientad"...) = -1 EIO (Input/output error)
>>   write(2, "mount.nfs: mount system call fai"..., 45
>>   mount.nfs: mount system call failed for /mnt
>>
>> And the kernel says:
>>   nfs4_discover_server_trunking unhandled error -5. Exiting with error EIO
> 
> Reported-by: Jiri Slaby <jirislaby@kernel.org>

Tested-by: Jiri Slaby <jirislaby@kernel.org>

-- 
js
suse labs

