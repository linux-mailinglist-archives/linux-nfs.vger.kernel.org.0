Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28974C190C
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 17:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242975AbiBWQtP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 11:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242989AbiBWQtO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 11:49:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C5D84BFE0
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 08:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645634925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M23OJolVrEJHu/64jj2/s4zz0AJFPoNbhp3zvMGl9aM=;
        b=YE7/JIZ517J9MudS/AOB/o063lYbkRfy/biRaR4wXHrz2a4pwSimgjgGW7tjTRz4X59TFu
        sbS+BidKKMIrocTcDe2RZvwCXLZeZB8qxJaqFfZHmrsEajfr0S9+8gZ6jO0RNK05ZfHBCh
        mVsdh/Q6jajLq8GW/Tn81rJdIVbnjLc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-QzM7lT4RMCuEzTj4Zwrr0A-1; Wed, 23 Feb 2022 11:48:44 -0500
X-MC-Unique: QzM7lT4RMCuEzTj4Zwrr0A-1
Received: by mail-qv1-f70.google.com with SMTP id e9-20020a0cf749000000b0042bf697ff6bso4363165qvo.5
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 08:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M23OJolVrEJHu/64jj2/s4zz0AJFPoNbhp3zvMGl9aM=;
        b=qzD9km880bwdMLIImJBhDyRVOlRWok+xwiORd3BdvhLA/PZLhbRqyPiG3wBT14B24P
         oH6FdGfNLCaUh0KnEgORpgGuYsUw5qDxTRHT7pj8GfI8XPVtHDGIWOqhN+winh0Bkqxk
         oS/fRceEKMtQL+lzZ0eWBXJMEFB5UT/af9paMPA2haWtANbMHgmUmAv6TxEVHdMJi9OH
         YPH5j7CI439giWlhNCoA4Bmfn0wklg8U8LX9ST+2DWgKtX6Oa4B5p8MUkkzL/GtZ96tm
         f009qXRG9eI5zFO3uqb9x4xcl9GkZLiNf9dmwYwZePPQx4m+dhWd24hcQjmBPko+YQCr
         iDFg==
X-Gm-Message-State: AOAM532bm9irYJWpXqPFnpBTsmrW5nyUFDSGBYRjs6em/Ctp2SOYk1kR
        1EOIN4W4O6MWZxQJZjeTRP4As2SzXsoeU6GqibPxIG21u3gC0dhR/s8z34iyzewaHH+WtU5Pplr
        UUMZC1kuTfZOWl1Qm2ZRv
X-Received: by 2002:a05:620a:11:b0:508:7199:40ef with SMTP id j17-20020a05620a001100b00508719940efmr385285qki.62.1645634923895;
        Wed, 23 Feb 2022 08:48:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoBzCRIxFVIsrHPzeOEIj+bBYoxPc1GcunL2HpNdKBzBLRjAWKA6laO1oy5WAcE/YJ3fwCfA==
X-Received: by 2002:a05:620a:11:b0:508:7199:40ef with SMTP id j17-20020a05620a001100b00508719940efmr385273qki.62.1645634923658;
        Wed, 23 Feb 2022 08:48:43 -0800 (PST)
Received: from [172.31.1.6] ([71.161.196.139])
        by smtp.gmail.com with ESMTPSA id w2sm100481qts.29.2022.02.23.08.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 08:48:43 -0800 (PST)
Message-ID: <1431b3c8-e003-c223-37a9-c2d3791705d1@redhat.com>
Date:   Wed, 23 Feb 2022 11:48:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] idmapd: Fix error status when nfs-idmapd exits
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, linux-nfs@vger.kernel.org
Cc:     Zhiqiang Liu <liuzhiqiang26@huawei.com>, linfeilong@huawei.com,
        yanglongkang@h-partners.com
References: <20220218012732.1549586-1-haowenchao@huawei.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220218012732.1549586-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/17/22 8:27 PM, Wenchao Hao wrote:
> nfs-idmapd.service would report following error when stopped:
> 
> Feb 17 07:32:05 fedora systemd[1]: Starting NFSv4 ID-name mapping service...
> Feb 17 07:32:05 fedora rpc.idmapd[1198]: Setting log level to 0
> Feb 17 07:32:05 fedora systemd[1]: Started NFSv4 ID-name mapping service.
> Feb 17 07:32:11 fedora rpc.idmapd[1198]: exiting on signal 15
> Feb 17 07:32:11 fedora systemd[1]: Stopping NFSv4 ID-name mapping service...
> Feb 17 07:32:11 fedora systemd[1]: nfs-idmapd.service: Main process exited, code=exited, status=1/FAILURE
> Feb 17 07:32:11 fedora systemd[1]: nfs-idmapd.service: Failed with result 'exit-code'.
> Feb 17 07:32:11 fedora systemd[1]: Stopped NFSv4 ID-name mapping service.
> 
> commit 93e8f092(idmapd: Add graceful exit and resource cleanup)
> redirected SIGTERM, so when executing "systemctl stop nfs-idmapd", the
> main() of idmapd would running to tail to return, while it returned 1
> which considered as error by systemd.
> 
> So here just return 0 in main().
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
Committed (tag: nfs-utils-2-6-2-rc2)

steved.
> ---
>   utils/idmapd/idmapd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
> index e2c160e8..e79c124d 100644
> --- a/utils/idmapd/idmapd.c
> +++ b/utils/idmapd/idmapd.c
> @@ -474,7 +474,7 @@ main(int argc, char **argv)
>   		event_free(svrdirev);
>   	event_base_free(evbase);
>   
> -	return 1;
> +	return 0;
>   }
>   
>   static void

