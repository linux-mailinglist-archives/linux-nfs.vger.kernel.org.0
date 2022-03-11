Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB12B4D5D3D
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Mar 2022 09:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiCKI0B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Mar 2022 03:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiCKI0B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Mar 2022 03:26:01 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104881B8FDA
        for <linux-nfs@vger.kernel.org>; Fri, 11 Mar 2022 00:24:58 -0800 (PST)
Received: from kwepemi500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KFJpW28ljzBrgN;
        Fri, 11 Mar 2022 16:22:59 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi500001.china.huawei.com (7.221.188.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 16:24:56 +0800
Received: from [10.174.179.176] (10.174.179.176) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 16:24:55 +0800
Subject: Re: [PATCH] blkmapd: fix coredump in bl_add_disk
From:   lixiaokeng <lixiaokeng@huawei.com>
To:     <steved@redhat.com>, <linux-nfs@vger.kernel.org>
CC:     "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
References: <77a09978-a5aa-ea7f-04b8-a8d398ee325f@huawei.com>
Message-ID: <a0926064-ea58-079f-9269-61f2a54ad7dd@huawei.com>
Date:   Fri, 11 Mar 2022 16:24:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <77a09978-a5aa-ea7f-04b8-a8d398ee325f@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.176]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

ping

On 2021/12/1 16:21, lixiaokeng wrote:
> The serial->data is not malloced separately (just part of
> the serial), so it can't be freed. The bl_serial has its
> own free function. Use it.
> 
> Signed-off-by: Lixiaokeng <lixiaokeng@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  utils/blkmapd/device-discovery.c | 15 +++------------
>  utils/blkmapd/device-discovery.h |  2 ++
>  utils/blkmapd/device-inq.c       |  4 ++--
>  3 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/utils/blkmapd/device-discovery.c b/utils/blkmapd/device-discovery.c
> index 2736ac89..cea33496 100644
> --- a/utils/blkmapd/device-discovery.c
> +++ b/utils/blkmapd/device-discovery.c
> @@ -187,10 +187,7 @@ static void bl_add_disk(char *filepath)
>  	}
> 
>  	if (disk && diskpath) {
> -		if (serial) {
> -			free(serial->data);
> -			free(serial);
> -		}
> +		bl_free_scsi_string(serial);
>  		return;
>  	}
> 
> @@ -228,10 +225,7 @@ static void bl_add_disk(char *filepath)
>  			disk->size = size;
>  			disk->valid_path = path;
>  		}
> -		if (serial) {
> -			free(serial->data);
> -			free(serial);
> -		}
> +		bl_free_scsi_string(serial);
>  	}
>  	return;
> 
> @@ -241,10 +235,7 @@ static void bl_add_disk(char *filepath)
>  			free(path->full_path);
>  		free(path);
>  	}
> -	if (serial) {
> -		free(serial->data);
> -		free(serial);
> -	}
> +	bl_free_scsi_string(serial);
>  	return;
>  }
> 
> diff --git a/utils/blkmapd/device-discovery.h b/utils/blkmapd/device-discovery.h
> index a86eed99..462aa943 100644
> --- a/utils/blkmapd/device-discovery.h
> +++ b/utils/blkmapd/device-discovery.h
> @@ -151,6 +151,8 @@ uint64_t process_deviceinfo(const char *dev_addr_buf,
> 
>  extern ssize_t atomicio(ssize_t(*f) (int, void *, size_t),
>  			int fd, void *_s, size_t n);
> +extern struct bl_serial *bl_create_scsi_string(int len, const char *bytes);
> +extern void bl_free_scsi_string(struct bl_serial *str);
>  extern struct bl_serial *bldev_read_serial(int fd, const char *filename);
>  extern enum bl_path_state_e bldev_read_ap_state(int fd);
>  extern int bl_discover_devices(void);
> diff --git a/utils/blkmapd/device-inq.c b/utils/blkmapd/device-inq.c
> index c7952c3e..9e5749ef 100644
> --- a/utils/blkmapd/device-inq.c
> +++ b/utils/blkmapd/device-inq.c
> @@ -53,7 +53,7 @@
>  #define DEF_ALLOC_LEN	255
>  #define MX_ALLOC_LEN	(0xc000 + 0x80)
> 
> -static struct bl_serial *bl_create_scsi_string(int len, const char *bytes)
> +struct bl_serial *bl_create_scsi_string(int len, const char *bytes)
>  {
>  	struct bl_serial *s;
> 
> @@ -66,7 +66,7 @@ static struct bl_serial *bl_create_scsi_string(int len, const char *bytes)
>  	return s;
>  }
> 
> -static void bl_free_scsi_string(struct bl_serial *str)
> +void bl_free_scsi_string(struct bl_serial *str)
>  {
>  	if (str)
>  		free(str);
> 
