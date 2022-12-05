Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BED643591
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Dec 2022 21:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiLEUXu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Dec 2022 15:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLEUXt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Dec 2022 15:23:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B18AE4F
        for <linux-nfs@vger.kernel.org>; Mon,  5 Dec 2022 12:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670271767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zM6eRziPf1S/nALSIShdPIVq07eY7oGeZtwOGe3fpNM=;
        b=GM1toCgTvc3WZ3vaFOjrO3jpCGz4CoBFA4Zf0gvnefhR2DohZ08kSzq1IwL+tNV1o4TbDF
        UNUy9do2PZUseYnDcMcbLcX/GFFrsgi+g0MEAdE3EELYfpdWd6gzmR8eEbE9VBGm1xpmue
        OPMGLGZeP1xD4zcNsiiDK3i1t8BF+S0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-318-7VBCbngyNRKRWJXxvrGECw-1; Mon, 05 Dec 2022 15:22:38 -0500
X-MC-Unique: 7VBCbngyNRKRWJXxvrGECw-1
Received: by mail-qt1-f197.google.com with SMTP id g3-20020ac84b63000000b003a529c62a92so34038705qts.23
        for <linux-nfs@vger.kernel.org>; Mon, 05 Dec 2022 12:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zM6eRziPf1S/nALSIShdPIVq07eY7oGeZtwOGe3fpNM=;
        b=ywoYJIeo9XcYFMdsyvOGWuL11RJP+9shX44ATxlJm9bXcUQS7WpTDZ+b6pGQqXNcge
         2BJ+7kMaud6qmCczSxrQSu/B0vCFPItVYencJE1oNXP6t7XJg7ZO0ZwQyulcPg9xipGX
         O+1Cj/R4qb+5DzSgpqwrlB7pJOktKfAd2lMxe6ttfSwDHDEgo5g9U40VpzvBTKdS3p2F
         U9+F/mwFpoOoSzXc+c17ycHjyHWQSMi4GtedHCDbpOc9+pB8QPH9jfw4hcNwwE3snfEE
         MbhvfYxy09EkmfLbVqrTJ0kPfzro2NPKfhFOnOX7v0czqRbojMZa2M/02cxpVTjTKSnD
         BVOA==
X-Gm-Message-State: ANoB5pkmN/O9+3WYsqj1hNc3ViPdXv6HUhkZyBvNd3XaNE5O7v/fwFyD
        rGEPteZNryGHCb4c//BNdsZ/ojWqoiwjykyAMYzfnmmTpch6EBkB51zRNmNKhKjyYg222pwzjM4
        2t7EdViUymdIBrF3JPF8p
X-Received: by 2002:ac8:4d1b:0:b0:3a5:7f82:8248 with SMTP id w27-20020ac84d1b000000b003a57f828248mr226481qtv.63.1670271757529;
        Mon, 05 Dec 2022 12:22:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf69t/kxnpYqwRz8X7i93/FSiJDJneqhy7w5uaaRg6o+GAoyvCYXC/I9Jmdam584MZlUS0t3Yw==
X-Received: by 2002:ac8:4d1b:0:b0:3a5:7f82:8248 with SMTP id w27-20020ac84d1b000000b003a57f828248mr226480qtv.63.1670271757265;
        Mon, 05 Dec 2022 12:22:37 -0800 (PST)
Received: from [172.31.1.6] ([70.105.255.216])
        by smtp.gmail.com with ESMTPSA id bq38-20020a05620a46a600b006fc40dafaa2sm13503768qkb.8.2022.12.05.12.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 12:22:36 -0800 (PST)
Message-ID: <a4b15b1c-a638-936e-47aa-46bad41b4e2d@redhat.com>
Date:   Mon, 5 Dec 2022 15:22:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] nfs4_setfacl: man page example should use the new option
 index
To:     Yongcheng Yang <yongcheng.yang@gmail.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20221123014550.525927-1-yongcheng.yang@gmail.com>
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20221123014550.525927-1-yongcheng.yang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/22/22 8:45 PM, Yongcheng Yang wrote:
> Subject:
> [PATCH] nfs4_setfacl: man page example should use the new option index
> From:
> Yongcheng Yang <yongcheng.yang@gmail.com>
> Date:
> 11/22/22, 8:45 PM
> 
> To:
> Steve Dickson <steved@redhat.com>
> CC:
> Linux NFS Mailing list <linux-nfs@vger.kernel.org>, Yongcheng Yang 
> <yongcheng.yang@gmail.com>
> 
> 
> Signed-off-by: Yongcheng Yang<yongcheng.yang@gmail.com>
Committed... a while ago! :-)

steved.

> ---
>   man/man1/nfs4_setfacl.1 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/man/man1/nfs4_setfacl.1 b/man/man1/nfs4_setfacl.1
> index 61699ae..c4b4dbb 100644
> --- a/man/man1/nfs4_setfacl.1
> +++ b/man/man1/nfs4_setfacl.1
> @@ -210,7 +210,7 @@ named `newacl.txt':
>   .IP - 2
>   delete the first ACE, but only print the resulting ACL (does not save changes):
>   .br
> -	$ nfs4_setfacl --test -x 1 foo
> +	$ nfs4_setfacl --test -x -i 1 foo
>   .IP - 2
>   delete the last two ACEs above:
>   .br
> -- 2.31.1
> 

