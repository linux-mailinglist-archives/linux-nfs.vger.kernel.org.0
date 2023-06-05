Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEFB7228C0
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jun 2023 16:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjFEOYl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Jun 2023 10:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFEOYk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Jun 2023 10:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82E4ED
        for <linux-nfs@vger.kernel.org>; Mon,  5 Jun 2023 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685975038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mRmCEwfgM7dUyofZYXPpiULBCR97a5O8a2lLz80kQEI=;
        b=daNkKfVBjdFvYklPkWJpTrrVeip6HUrCvI7m71ebf/5Mykmb44uGk6rQfZAM9sQDz0WvHB
        EHXmnUw9d/j/qdm7tjkF5DMmu8rsD6Bs6zZj5tXDDit12V0CQ4lnOjE2AwVhGxXFdh5ZlM
        4ZrxKJ/0OSJDfplw8/AkcoVu/AeBTBE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-nUq3nTilPGK3usvClyQL0g-1; Mon, 05 Jun 2023 10:23:54 -0400
X-MC-Unique: nUq3nTilPGK3usvClyQL0g-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f8b055287fso2282701cf.0
        for <linux-nfs@vger.kernel.org>; Mon, 05 Jun 2023 07:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685975034; x=1688567034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRmCEwfgM7dUyofZYXPpiULBCR97a5O8a2lLz80kQEI=;
        b=g7QApfPp+Xec1xyH7we1w/m8t2zz0RoD5AWwMSNYFO7+0kdgE+/BEOan12c+LxoZpu
         jYo86BnqM6anKgXfHHQKS7HCC8gv7+kNFY1zacB0TreaU4dLzdW4ny695zldnR/p2YZV
         DyCW5zqlBDQPk5fYRv6Qb1HNQ4ede9QymvZFasVzUFYIsSsdwVLUeX4SZjqpBH9CMGGh
         7hmFRZ4qOVSoD9gTRRp6L3HwhhrpbTZb/JA2gag1cwPZGxfDtTgheiBe8BWPO2FBCmUU
         Vja8ligD6peXRZx1u0GZ8J7Be7SgZ7pz0OCOJls7ZdSydfDJMbuRVZ/i3GWtY5ecTEdY
         qoDA==
X-Gm-Message-State: AC+VfDwM9h36rZjUQ1oB6uM/rQM4EsQllg2bhmlWmxpMsgMzV86sIdk0
        ZfTLrA6xeAnhu7qeNDO5nUpbOxm/VpF+2xsx3InGGxysMK0mw88a19N2rYNTiA1p+7TWUpcPCiP
        tlqQHzh3cxqYf/5NHBler
X-Received: by 2002:a05:622a:14cd:b0:3f7:fab0:6308 with SMTP id u13-20020a05622a14cd00b003f7fab06308mr23121061qtx.6.1685975034280;
        Mon, 05 Jun 2023 07:23:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66hm4p0GpR/gwmVZmzK9KkHg4RJNeUnME1D8YDnKBko9JSU3L9V4MTEebYXADObqRh2Sd79g==
X-Received: by 2002:a05:622a:14cd:b0:3f7:fab0:6308 with SMTP id u13-20020a05622a14cd00b003f7fab06308mr23121044qtx.6.1685975033996;
        Mon, 05 Jun 2023 07:23:53 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.188.174])
        by smtp.gmail.com with ESMTPSA id s19-20020ac87593000000b003f38b4167e5sm474263qtq.2.2023.06.05.07.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 07:23:53 -0700 (PDT)
Message-ID: <8338619a-3609-0c82-0ef2-196127504850@redhat.com>
Date:   Mon, 5 Jun 2023 10:23:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [nfs-utils PATCH 0/3] Add docs for some mount options missing
 from nfs(5)
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <20230601194617.2174639-1-smayhew@redhat.com>
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20230601194617.2174639-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/1/23 3:46 PM, Scott Mayhew wrote:
> Scott Mayhew (3):
>    nfs(5): Document the softerr mount option.
My only thought about this one, is do we want document
an option we do people using since it will cause data
corruption?

Personally I would be for ripping out all of the soft doc
from the man page.

steved.

>    nfs(5): Document the write=lazy|eager|wait mount option.
>    nfs(5): Document the trunkdiscovery/notrunkdiscovery mount option.
> 
>   utils/mount/nfs.man | 84 +++++++++++++++++++++++++++++++++------------
>   1 file changed, 63 insertions(+), 21 deletions(-)
> 

