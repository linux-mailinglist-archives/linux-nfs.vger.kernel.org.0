Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4163A42D3AA
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Oct 2021 09:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhJNHc5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 03:32:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45564 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJNHc5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 03:32:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E529620286;
        Thu, 14 Oct 2021 07:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634196651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8tPwzw2UB082eBps5aUSU0BEvZMxko9oTtdNob0CmmA=;
        b=gOPfcUImDNEmHj8zUFdNQtolg7AVOfCcokZrXjQa+yus0f6Nae12ACN1OM+9IuyctEsmtM
        7iFkc+X8VldHj2RvSoPO7Gv8dQ2X1uzzwaK+7aHnhL1DzGI8+dCq6cc+mJIV8vGJAKWuex
        1A8yge65clSizbMezID5Wo1d9QGHeso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634196651;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8tPwzw2UB082eBps5aUSU0BEvZMxko9oTtdNob0CmmA=;
        b=QU8t4/fFBoy3guAi9UYg1f3RCgfgR0hhn6lmqUXGE71D0O3QU8COzzMLzeZcpULdiM1Nbp
        6J3oTt0up4AyALCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BDF0813D3F;
        Thu, 14 Oct 2021 07:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YOeALavcZ2EcHQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 14 Oct 2021 07:30:51 +0000
Subject: Re: [PATCH 2/7] sd: implement ->get_unique_id
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20211012120445.861860-1-hch@lst.de>
 <20211012120445.861860-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0a7d87ef-fff2-6a63-8edd-604ad8868dbd@suse.de>
Date:   Thu, 14 Oct 2021 09:30:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211012120445.861860-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/12/21 2:04 PM, Christoph Hellwig wrote:
> Add the method to query for a uniqueue ID of a given type by looking
> it up in the cached device identification VPD page.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/sd.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index d8f6add416c0a..ea1489d3e8497 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1757,6 +1757,42 @@ static void sd_rescan(struct device *dev)
>   	sd_revalidate_disk(sdkp->disk);
>   }
>   
> +static int sd_get_unique_id(struct gendisk *disk, u8 id[16], u8 type)
> +{
> +	struct scsi_device *sdev = scsi_disk(disk)->device;
> +	const struct scsi_vpd *vpd;
> +	const unsigned char *d;
> +	int len = -ENXIO;
> +
> +	rcu_read_lock();
> +	vpd = rcu_dereference(sdev->vpd_pg83);
> +	if (!vpd)
> +		goto out_unlock;
> +
> +	len = -EINVAL;
> +	for (d = vpd->data + 4; d < vpd->data + vpd->len; d += d[3] + 4) {
> +		/* we only care about designators with LU association */
> +		if (((d[1] >> 4) & 0x3) != 0x00)
> +			continue;
> +		if ((d[1] & 0xf) != type)
> +			continue;
> +
> +		/*
> +		 * Only exit early if a 16-byte descriptor was found.  Otherwise
> +		 * keep looking as one with more entropy might still show up.
> +		 */
> +		len = d[3];
> +		if (len != 8 && len != 12 && len != 16)
> +			continue;
> +		memcpy(id, d + 4, len);
> +		if (len == 16)
> +			break;
> +	}
> +out_unlock:
> +	rcu_read_unlock();
> +	return len;
> +}
> +
>   static char sd_pr_type(enum pr_type type)
>   {
>   	switch (type) {
> @@ -1861,6 +1897,7 @@ static const struct block_device_operations sd_fops = {
>   	.check_events		= sd_check_events,
>   	.unlock_native_capacity	= sd_unlock_native_capacity,
>   	.report_zones		= sd_zbc_report_zones,
> +	.get_unique_id		= sd_get_unique_id,
>   	.pr_ops			= &sd_pr_ops,
>   };
>   
> 
Errm.

What's wrong with scsi_vpd_lun_id() ?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
