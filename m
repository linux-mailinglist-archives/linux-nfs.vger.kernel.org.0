Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A011A666062
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 17:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjAKQ0E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 11:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjAKQZk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 11:25:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4633726E
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 08:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673454087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mtl9eXGbwOzPo68Erw/BrWcaAo83U4Q2meP2dkBuoBA=;
        b=c+QMbtJryIHOhRAPSr7qc2shEL3hWnuZGr/eRNjnyx6cG1VdQPO+4/fumhyg0Gzlz+VidG
        a42cG/4xqVun5l44/hokHSnB/OPTweLVL7nKPll1RuzeI4elCqiDBJfIyIBEeJ0JAHmgLC
        SItSSv4NjNZQpkg0ZlqyBhymbx6VC1Q=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-550-cQGsHgUOOyamVygBJNmAzQ-1; Wed, 11 Jan 2023 11:21:26 -0500
X-MC-Unique: cQGsHgUOOyamVygBJNmAzQ-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-4bdeb1bbeafso165003257b3.4
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 08:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mtl9eXGbwOzPo68Erw/BrWcaAo83U4Q2meP2dkBuoBA=;
        b=z8Al0N8mi2xdmXloy/iOrzePDTOuQ1A62UumtfRx4qOUJ5d5B+e3mYkRUxceJlRe/l
         kLPghpAJdElkdKu0/BVrQ4uiAIsgfKB3vHokhLuqSu0ysxk/cvr9isz+fNdHRf9IeoaP
         hsksgaC86N8WjDcKwFkG4zWiTt1eOORsl9qxA5tn+ng036F7K2+c/VCslI7VF2biVd9A
         njtPwuIGUXKvw9brBbOdLaTYXdi1SxnL5EhRXltBvwzgfUW7JViEbK7NEi7ovGaMGS2r
         Vm2umgXejGQL4h8A4aGc33bUYJK6acjxEvUnoT0zpgQRdcEzgXSPWU/Q3ITJscx6t2bJ
         B/Ww==
X-Gm-Message-State: AFqh2kqlY4c3iWBAa02BUYdAN6MtWx1KbgfGxK3AWaYn14BAX49LBnL8
        Um9dB0jvboyKGOL4FzMDmvzuDtd3+xKCPFfCK0JVI9Vx7/kyUNMT8Ybv48FGq/dcpLUp20TIfyQ
        M4iVhOFlW4jBm1EU++hdG
X-Received: by 2002:a81:4c12:0:b0:4a4:d75d:770 with SMTP id z18-20020a814c12000000b004a4d75d0770mr31487722ywa.21.1673454085178;
        Wed, 11 Jan 2023 08:21:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuyMMa6Tn38sgMXfLanQ49qQh6yYpBOJG1FmgzKLpRS/hMTzrU9951GBQn7G41T68u60byR3w==
X-Received: by 2002:a81:4c12:0:b0:4a4:d75d:770 with SMTP id z18-20020a814c12000000b004a4d75d0770mr31487707ywa.21.1673454084878;
        Wed, 11 Jan 2023 08:21:24 -0800 (PST)
Received: from [172.31.1.6] ([70.109.130.165])
        by smtp.gmail.com with ESMTPSA id y10-20020a05620a25ca00b006fa4cac54a5sm9206480qko.72.2023.01.11.08.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 08:21:24 -0800 (PST)
Message-ID: <00f27d16-2c5e-10f0-047c-63e904b3237b@redhat.com>
Date:   Wed, 11 Jan 2023 11:21:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] [nfs/nfs-utils/libtirpc] getnetconfigent: avoid potential
 DoS issue by removing unnecessary sleep
Content-Language: en-US
To:     Zhi Li <yieli@redhat.com>, linux-nfs@vger.kernel.org
References: <20221216051132.2569403-1-yieli@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20221216051132.2569403-1-yieli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12/16/22 12:11 AM, Zhi Li wrote:
> Subject:
> [PATCH] [nfs/nfs-utils/libtirpc] getnetconfigent: avoid potential DoS 
> issue by removing unnecessary sleep
> From:
> Zhi Li <yieli@redhat.com>
> Date:
> 12/16/22, 12:11 AM
> 
> To:
> linux-nfs@vger.kernel.org
> CC:
> steved@redhat.com, Zhi Li <yieli@redhat.com>
> 
> 
> Signed-off-by: Zhi Li<yieli@redhat.com>
Committed...

steved.
> ---
>   src/getnetconfig.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/src/getnetconfig.c b/src/getnetconfig.c
> index cfd33c2..9acd8c7 100644
> --- a/src/getnetconfig.c
> +++ b/src/getnetconfig.c
> @@ -439,7 +439,6 @@ getnetconfigent(netid)
>   	fprintf(stderr, "See UPDATING entry 20021216 for details.\n");
>   	fprintf(stderr, "Continuing in 10 seconds\n\n");
>   	fprintf(stderr, "This warning will be removed 20030301\n");
> -	sleep(10);
>   
>       }
>   
> -- 2.38.1
> 

