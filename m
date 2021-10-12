Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7356842AA42
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Oct 2021 19:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhJLRGE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Oct 2021 13:06:04 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:53895 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhJLRGD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Oct 2021 13:06:03 -0400
Received: by mail-pj1-f46.google.com with SMTP id ls18so104002pjb.3;
        Tue, 12 Oct 2021 10:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2RcSeUsktuetoQBEZpsEvSsK23QGJITn0bTBxOQUvyM=;
        b=od26oBs9lRTeVROr24UaOvp9yOGD/l+LFhfmRgT0H9bNQSaUnEtmO21mMOFbuB96tJ
         DIQdeUggfRKwBIK5NUzGJEx7g78PUwVYIRgfEWFF1c1SG9uOUl5dQB5v2NVmu/VJ16x7
         /c5DO0iIxv53BIFBM1CKruaTBnWw78/y8YaUu/eC9z6nFiT/e7NETBvNrHW5wt7o9v+y
         P93GBqN3NsV682yxwlDAiv4RknkKihqiGWzDNqLiOQEVzkUmxgSolP1cGdZvUYYrWMil
         gN5APlfPoGsxmnZTxrBmY7sAEdXBACdvu0YYwhZhszqP8Yufb8M/BBPe4iWANt1t63RE
         XX8A==
X-Gm-Message-State: AOAM531PDwhOFKB5F/h3C8vgwcucxPM+d7KSaM4Eps4pdtyT6zKHjNei
        KtBgwX5rFlimKZGrihBGQBX3He7pjVk=
X-Google-Smtp-Source: ABdhPJx7w0h+NGW01JNSzoWwdrkTtZ24JTOq90hDFYfVE5Nb8/Qrjlu33OND/CQt0Nv/VUfkNfCUYQ==
X-Received: by 2002:a17:902:e801:b0:13f:2212:d641 with SMTP id u1-20020a170902e80100b0013f2212d641mr19598028plg.87.1634058241085;
        Tue, 12 Oct 2021 10:04:01 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8c1a:acb2:4eff:5d13])
        by smtp.gmail.com with ESMTPSA id i13sm7691052pgn.69.2021.10.12.10.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 10:04:00 -0700 (PDT)
Subject: Re: [PATCH 1/7] block: add a ->get_unique_id method
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20211012120445.861860-1-hch@lst.de>
 <20211012120445.861860-2-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <981907d6-2763-1a53-abb5-a265bb02f386@acm.org>
Date:   Tue, 12 Oct 2021 10:03:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211012120445.861860-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/12/21 5:04 AM, Christoph Hellwig wrote:
> Add a method to query query uniqueue IDs from block devices.  It will be
> used to remove code that deeply pokes into SCSI internals in the NFS
> server.  The implementation in the sd driver itself can also be much
> nicer as it can use the cached VPD page instead of always sending a
> command as the current NFS code does.
> 
> For now the interface is kept very minimal but could be easily
> extended when other users like a block-layer sysfs interface for
> uniquue IDs shows up.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/blkdev.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 17705c970d7e1..81f94a7c54521 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1188,6 +1188,7 @@ struct block_device_operations {
>   	int (*report_zones)(struct gendisk *, sector_t sector,
>   			unsigned int nr_zones, report_zones_cb cb, void *data);
>   	char *(*devnode)(struct gendisk *disk, umode_t *mode);
> +	int (*get_unique_id)(struct gendisk *disk, u8 id[16], u8 id_type);
>   	struct module *owner;
>   	const struct pr_ops *pr_ops;

Please document the meaning of the 'u8 id_type' argument, how callers 
can determine the length of the unique ID and what the meaning of the 
return value is.

Thanks,

Bart.

