Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4800942D3E5
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Oct 2021 09:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhJNHkx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 03:40:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47454 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhJNHkw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 03:40:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2DE522028A;
        Thu, 14 Oct 2021 07:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634197127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z5XxL3qi/gR2OfvAm1+qER5gofhDXBb22QVDWPURgd0=;
        b=AlhouwFN7+Q4dJrn22v9xdATFbk2wy7uszT32zBaioXK+GQAbdwUZVlcatdY+xiDqNjK8u
        oRuFkxdie54FbLt/0qK+76OdQeHPPN9PE448Gv4MojnoqqKoVup1DFgdiX8ofTOmEfCqW2
        mUpKINe6tPA+Bn9vHBLW4FJecu/CJpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634197127;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z5XxL3qi/gR2OfvAm1+qER5gofhDXBb22QVDWPURgd0=;
        b=3pzc8Q7fDxQO3trhwNiSaFYp+b+GtcJ3Q6r+njfyAiennXj1stX7Bh3RGruHADb3iI+Qf+
        Lmnn6WoetstgXQBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 061AD13D3F;
        Thu, 14 Oct 2021 07:38:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QWYIOIbeZ2HhIAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 14 Oct 2021 07:38:46 +0000
Subject: Re: [PATCH 7/7] block: remove QUEUE_FLAG_SCSI_PASSTHROUGH
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20211012120445.861860-1-hch@lst.de>
 <20211012120445.861860-8-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <4e155b66-77ad-660a-217f-30e0b82b81cd@suse.de>
Date:   Thu, 14 Oct 2021 09:38:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211012120445.861860-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/12/21 2:04 PM, Christoph Hellwig wrote:
> Export scsi_device_from_queue for use with pktcdvd and use that instead
> of the otherwise unused QUEUE_FLAG_SCSI_PASSTHROUGH queue flag.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq-debugfs.c   | 1 -
>   drivers/block/pktcdvd.c  | 5 ++++-
>   drivers/scsi/scsi_lib.c  | 8 ++++++++
>   drivers/scsi/scsi_scan.c | 1 -
>   include/linux/blkdev.h   | 3 ---
>   5 files changed, 12 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
