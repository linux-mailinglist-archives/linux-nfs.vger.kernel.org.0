Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39C442D3B1
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Oct 2021 09:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhJNHda (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 03:33:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45598 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJNHd3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 03:33:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC8092027F;
        Thu, 14 Oct 2021 07:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634196683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h8RqeVLpeOfKQUqTektCIXhEptpbud8TNjp9pK1dnv4=;
        b=1Z1Av9ihyJP9/iahH+83xIOstRF+ELRyXUGZUn/4m6afq52G5MjLiSJXdo4VN2jnn5BTci
        Ib8nyklboFn2xQ0Iy+Kl9H0qjxnzPF+oulEQkN9cGFYvKdqK9q6vMdevLqjdlolvrv1Xbz
        eox0DI7YvZ74LHQQktK5Jy01NHnSzAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634196683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h8RqeVLpeOfKQUqTektCIXhEptpbud8TNjp9pK1dnv4=;
        b=URsuoYRDZcBTtyMqDkDJ8LaY8K0mVQceRV8EGwM1y3j5OQnk6MKeQVxtBDuM6ONWE6eDp5
        Zt+Gy8Ct8vh6RgBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF87513D3F;
        Thu, 14 Oct 2021 07:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PL4QLsvcZ2FeHQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 14 Oct 2021 07:31:23 +0000
Subject: Re: [PATCH 1/7] block: add a ->get_unique_id method
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20211012120445.861860-1-hch@lst.de>
 <20211012120445.861860-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <437deafa-e0b9-8a84-1f2f-381b1c9865b8@suse.de>
Date:   Thu, 14 Oct 2021 09:31:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211012120445.861860-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/12/21 2:04 PM, Christoph Hellwig wrote:
> Add a method to query query uniqueue IDs from block devices.  It will be

Maybe engage a spell checker here ...

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
>   
> 
Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
