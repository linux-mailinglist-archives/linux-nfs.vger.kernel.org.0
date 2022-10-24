Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A8B60BB2C
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 22:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiJXUtr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 16:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiJXUtQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 16:49:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290E02B9B8C
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 11:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666637712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/rmKpNDemUa45fqNlVRy2E3YJgxgTucalwIN0Vfva0=;
        b=BJ//3q+5SJs/oGtSVc80W8qWrUadWLEJga9URx+dZqzeWy4rYqNfSARA5lu7pvJM9TRSsN
        h+xfEF4P+Ie94NPtBkr/qmg3Y1s9qqn6HT3BGJDTIET2RIHD1g285ta3LuNA//ErHdxlmX
        kUYemTZ6ODgu6w+r2rvAhE+1TWdRs0M=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-484-X45ioqabN2m_QJJPRJAfIQ-1; Mon, 24 Oct 2022 13:38:15 -0400
X-MC-Unique: X45ioqabN2m_QJJPRJAfIQ-1
Received: by mail-qt1-f197.google.com with SMTP id f19-20020ac84713000000b00397692bdaecso7536676qtp.22
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 10:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/rmKpNDemUa45fqNlVRy2E3YJgxgTucalwIN0Vfva0=;
        b=kh9EK9FxRp/T1iNsrA5b68exnwi3Fh8O53/g5L7avT6JQDdpil6RrDbBDVqMZyqj8u
         5sU7HL75O+BhtNf/eEaTq3UILi+JQTVqQ+B6KhSgF78Vxf5dRI1SHqXedVCLkSlUY9XN
         S2fL1kwtNOF5irwuZTX1G0Do7q0ih2iXLHCKZls+L8VRUoi5N06mAS+t7P1A6sho2Rrh
         QtP6MKRogMQEcouMocpDTuGiBih6ZELorcEd6nLFa4+BDNUchkHHNUi5W5fngJ8EvEZr
         QSoXI/HSI/cKtECqGdeH9IC4t9HvKrcaBxNiXCjhcP0mSCs7xqVc/2Q5UfUfJVKdLuc5
         gGxA==
X-Gm-Message-State: ACrzQf2dxUKDno9KTEaRRwezfnyCC2G4Fr44dQlXB0KbXc+UjABpybv3
        wPKXbxYSQt8820HTPzEOu5tZoFRO7wB44qyMPNFK1FNrloImC3vhcZtZonK57UZ5urg1ZuUBGE8
        MDySClJT7XG8G5sy08Kb6
X-Received: by 2002:a05:622a:15d3:b0:39d:dd6:3a31 with SMTP id d19-20020a05622a15d300b0039d0dd63a31mr18831314qty.37.1666633094189;
        Mon, 24 Oct 2022 10:38:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7dBCwfVdE3G6x1jYfkCmylHU1iFolLnN948STXytEBdmo5QqAaOR7DrZBF6Jcik+APxkRc6w==
X-Received: by 2002:a05:622a:15d3:b0:39d:dd6:3a31 with SMTP id d19-20020a05622a15d300b0039d0dd63a31mr18831296qty.37.1666633093908;
        Mon, 24 Oct 2022 10:38:13 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:db8c:7bbd:f449:802d? (2603-6000-d605-db00-db8c-7bbd-f449-802d.res6.spectrum.com. [2603:6000:d605:db00:db8c:7bbd:f449:802d])
        by smtp.gmail.com with ESMTPSA id bq44-20020a05620a46ac00b006ee77f1ecc3sm374918qkb.31.2022.10.24.10.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 10:38:13 -0700 (PDT)
Message-ID: <6c6018bb-2d28-1bd7-1d91-fbec47373c79@redhat.com>
Date:   Mon, 24 Oct 2022 13:38:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] blkmapd: fix coredump in bl_add_disk
Content-Language: en-US
To:     lixiaokeng <lixiaokeng@huawei.com>, linux-nfs@vger.kernel.org
Cc:     "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
References: <77a09978-a5aa-ea7f-04b8-a8d398ee325f@huawei.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <77a09978-a5aa-ea7f-04b8-a8d398ee325f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12/1/21 3:21 AM, lixiaokeng wrote:
> The serial->data is not malloced separately (just part of
> the serial), so it can't be freed. The bl_serial has its
> own free function. Use it.
> 
> Signed-off-by: Lixiaokeng <lixiaokeng@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Committed...

steved.

> ---
>   utils/blkmapd/device-discovery.c | 15 +++------------
>   utils/blkmapd/device-discovery.h |  2 ++
>   utils/blkmapd/device-inq.c       |  4 ++--
>   3 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/utils/blkmapd/device-discovery.c b/utils/blkmapd/device-discovery.c
> index 2736ac89..cea33496 100644
> --- a/utils/blkmapd/device-discovery.c
> +++ b/utils/blkmapd/device-discovery.c
> @@ -187,10 +187,7 @@ static void bl_add_disk(char *filepath)
>   	}
> 
>   	if (disk && diskpath) {
> -		if (serial) {
> -			free(serial->data);
> -			free(serial);
> -		}
> +		bl_free_scsi_string(serial);
>   		return;
>   	}
> 
> @@ -228,10 +225,7 @@ static void bl_add_disk(char *filepath)
>   			disk->size = size;
>   			disk->valid_path = path;
>   		}
> -		if (serial) {
> -			free(serial->data);
> -			free(serial);
> -		}
> +		bl_free_scsi_string(serial);
>   	}
>   	return;
> 
> @@ -241,10 +235,7 @@ static void bl_add_disk(char *filepath)
>   			free(path->full_path);
>   		free(path);
>   	}
> -	if (serial) {
> -		free(serial->data);
> -		free(serial);
> -	}
> +	bl_free_scsi_string(serial);
>   	return;
>   }
> 
> diff --git a/utils/blkmapd/device-discovery.h b/utils/blkmapd/device-discovery.h
> index a86eed99..462aa943 100644
> --- a/utils/blkmapd/device-discovery.h
> +++ b/utils/blkmapd/device-discovery.h
> @@ -151,6 +151,8 @@ uint64_t process_deviceinfo(const char *dev_addr_buf,
> 
>   extern ssize_t atomicio(ssize_t(*f) (int, void *, size_t),
>   			int fd, void *_s, size_t n);
> +extern struct bl_serial *bl_create_scsi_string(int len, const char *bytes);
> +extern void bl_free_scsi_string(struct bl_serial *str);
>   extern struct bl_serial *bldev_read_serial(int fd, const char *filename);
>   extern enum bl_path_state_e bldev_read_ap_state(int fd);
>   extern int bl_discover_devices(void);
> diff --git a/utils/blkmapd/device-inq.c b/utils/blkmapd/device-inq.c
> index c7952c3e..9e5749ef 100644
> --- a/utils/blkmapd/device-inq.c
> +++ b/utils/blkmapd/device-inq.c
> @@ -53,7 +53,7 @@
>   #define DEF_ALLOC_LEN	255
>   #define MX_ALLOC_LEN	(0xc000 + 0x80)
> 
> -static struct bl_serial *bl_create_scsi_string(int len, const char *bytes)
> +struct bl_serial *bl_create_scsi_string(int len, const char *bytes)
>   {
>   	struct bl_serial *s;
> 
> @@ -66,7 +66,7 @@ static struct bl_serial *bl_create_scsi_string(int len, const char *bytes)
>   	return s;
>   }
> 
> -static void bl_free_scsi_string(struct bl_serial *str)
> +void bl_free_scsi_string(struct bl_serial *str)
>   {
>   	if (str)
>   		free(str);

