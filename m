Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37EE515F53
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Apr 2022 18:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383174AbiD3QrO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 Apr 2022 12:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383169AbiD3QrO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 Apr 2022 12:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 959173F8B5
        for <linux-nfs@vger.kernel.org>; Sat, 30 Apr 2022 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651337030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcjFzxhgEkp64LVsFghlYYty93oOo510lJELOJpzHhs=;
        b=ACQ0+XN8iv5bUbjvbYrFS/xmESLvSw9WmMAXNrQR3cUAAOsLcb9vTNWGT5TRpmFeWFFxUz
        aD25cH8ZQCKfFrt3t2JYL3oIWOIW9vrGib3yI3UeloiBbFUYo+B2Kd1Mh3UzSI5Cgb/x5g
        n7hnrWMOgAPUmvBNQ2smyVIFdWwbpEI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-BCCqfY_rMFiO6GDKb6GCYA-1; Sat, 30 Apr 2022 12:43:45 -0400
X-MC-Unique: BCCqfY_rMFiO6GDKb6GCYA-1
Received: by mail-qv1-f70.google.com with SMTP id 30-20020a0c80a1000000b00446218e1bcbso8020406qvb.23
        for <linux-nfs@vger.kernel.org>; Sat, 30 Apr 2022 09:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dcjFzxhgEkp64LVsFghlYYty93oOo510lJELOJpzHhs=;
        b=xZxo9iuiBDjcGe179njWAwhLoXQZhxS45gMHGZ2RJkLQrgXqx22/hnPYwBeub4T2r/
         rndmeK6IHCJTnnL+GgOmb2CdVLCqjMSRce2qCnCHJ9+Uk0qFvLAJ1VkcUmhNEHBexv8W
         RBD8S1782nWgSU84x51ZSpXs/yCoWrzW5yLLw1ze6FK7E0clMjweBNsL5Y6g6Qmosk3O
         kiKrTbwPDSRC6SiEKEGE7dLxp5ajqGRX02K6PHIkGrU6k2tyLeGEcYIR5K1sjfhRX3FG
         40tEZXj+rsXDS8ZDUoAiaKGq6W9cELjLS329NCiynM97k7OCZjj1FvaoIGRecT2hrHB1
         XYVg==
X-Gm-Message-State: AOAM530o1yxwJcXwQyYrM2zzMxBmhFddMdlm1UPe1coW0/yyjNvn1hyy
        dXxd5Fm0anEvDlrTY11KSq9sSVsO3deeUKtgIrJ08lx5VijqO+Dc9zyxeZB2GPXSztpVteUOozH
        m8JIR8DojPeCVqfIza2gl
X-Received: by 2002:a05:622a:349:b0:2f1:ffc2:821a with SMTP id r9-20020a05622a034900b002f1ffc2821amr4079342qtw.36.1651337024651;
        Sat, 30 Apr 2022 09:43:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL9vD+uLpDhnuEGZy5At3nnsGz6TucntqCuyJp+WQExQZJiOLJmUggTg5iEYDxiALZ5v73KA==
X-Received: by 2002:a05:622a:349:b0:2f1:ffc2:821a with SMTP id r9-20020a05622a034900b002f1ffc2821amr4079331qtw.36.1651337024377;
        Sat, 30 Apr 2022 09:43:44 -0700 (PDT)
Received: from [172.31.1.6] ([71.168.80.171])
        by smtp.gmail.com with ESMTPSA id r6-20020ac87946000000b002f39b99f691sm1412934qtt.43.2022.04.30.09.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 09:43:44 -0700 (PDT)
Message-ID: <2c15f117-19f4-66cb-d5a9-5b570fce19cd@redhat.com>
Date:   Sat, 30 Apr 2022 12:43:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] nfsrahead: fix oops caused by non-starndard naming
 schemes
Content-Language: en-US
To:     Thiago Becker <tbecker@redhat.com>, linux-nfs@vger.kernel.org
Cc:     trbecker@gmail.com
References: <20220425195948.2627428-1-tbecker@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220425195948.2627428-1-tbecker@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/25/22 3:59 PM, Thiago Becker wrote:
> brtfs uses a non standard naming scheme for its fs structures, which
> causes nfsrahead to take a long time scanning all the memory
> available and then crashes. This causes the udev to take forever to
> quiesce and delays the system startup.
> 
> This t=patch refactors the way the device number is obtained to handle
> this situation.
> 
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2078147
> Signed-off-by: Thiago Becker <tbecker@redhat.com>
Committed... Thanks!

steved.

> ---
>   tools/nfsrahead/main.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
> index b3af3aa8..83a389f7 100644
> --- a/tools/nfsrahead/main.c
> +++ b/tools/nfsrahead/main.c
> @@ -26,27 +26,31 @@ struct device_info {
>   };
>   
>   /* Convert a string in the format n:m to a device number */
> -static dev_t dev_from_arg(const char *device_number)
> +static int fill_device_number(struct device_info *info)
>   {
> -	char *s = strdup(device_number), *p;
> +	char *s = strdup(info->device_number), *p;
>   	char *maj_s, *min_s;
>   	unsigned int maj, min;
> -	dev_t dev;
> +	int err = -EINVAL;
>   
>   	maj_s = p = s;
> -	for ( ; *p != ':'; p++)
> +	for ( ; *p != ':' && *p != '\0'; p++)
>   		;
>   
> +	if (*p == '\0')
> +		goto out_free;
> +
> +	err = 0;
>   	*p = '\0';
>   	min_s = p + 1;
>   
>   	maj = strtol(maj_s, NULL, 10);
>   	min = strtol(min_s, NULL, 10);
>   
> -	dev = makedev(maj, min);
> -
> +	info->dev = makedev(maj, min);
> +out_free:
>   	free(s);
> -	return dev;
> +	return err;
>   }
>   
>   #define sfree(ptr) if (ptr) free(ptr)
> @@ -55,7 +59,7 @@ static dev_t dev_from_arg(const char *device_number)
>   static void init_device_info(struct device_info *di, const char *device_number)
>   {
>   	di->device_number = strdup(device_number);
> -	di->dev = dev_from_arg(device_number);
> +	di->dev = 0;
>   	di->mountpoint = NULL;
>   	di->fstype = NULL;
>   }
> @@ -76,6 +80,8 @@ static int get_mountinfo(const char *device_number, struct device_info *device_i
>   	char *target;
>   
>   	init_device_info(device_info, device_number);
> +	if ((ret = fill_device_number(device_info)) < 0)
> +		goto out_free_device_info;
>   
>   	mnttbl = mnt_new_table();
>   
> @@ -101,6 +107,7 @@ out_free_fs:
>   	mnt_free_fs(fs);
>   out_free_tbl:
>   	mnt_free_table(mnttbl);
> +out_free_device_info:
>   	free(device_info->device_number);
>   	device_info->device_number = NULL;
>   	return ret;

