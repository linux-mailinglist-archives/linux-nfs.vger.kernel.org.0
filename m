Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCC342D3C1
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Oct 2021 09:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhJNHfo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 03:35:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44668 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJNHfn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 03:35:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0ED5C21A74;
        Thu, 14 Oct 2021 07:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634196818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fu5eeDC920Nzc5wr0R5a7rHo9oLV/Zk0UfQ2EHldTks=;
        b=LQHGUjjynxARnZ/mpbzmGcsbjlJ5arapBr83JQHJbTEptCoBDiG9/ZXZOTZgthYRawQfyL
        3ExP9wtjYmJYYaumrIbNIF4jvpqwO5VyL25a1eH81gGDqcTtet2aygHddwxzXtxZeRW8af
        A7ULC68NvpfxYW7ckRretjSzgG5N4Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634196818;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fu5eeDC920Nzc5wr0R5a7rHo9oLV/Zk0UfQ2EHldTks=;
        b=6T9tAjxdVneKMEPqdke+uSMtfQTjVsLaVjRfKACoASOM67IlhMowHwc7zfKLVaj64pQXtU
        Q+1Sw82WRq35mICA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDEEA13D3F;
        Thu, 14 Oct 2021 07:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hBs4NVHdZ2EpHgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 14 Oct 2021 07:33:37 +0000
Subject: Re: [PATCH 4/7] bsg-lib: initialize the bsg_job in
 bsg_transport_sg_io_fn
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20211012120445.861860-1-hch@lst.de>
 <20211012120445.861860-5-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <a35c2a47-42b3-c89b-e798-e6726efd23a1@suse.de>
Date:   Thu, 14 Oct 2021 09:33:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211012120445.861860-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/12/21 2:04 PM, Christoph Hellwig wrote:
> Directly initialize the bsg_job structure instead of relying on the
> ->.initialize_rq_fn indirection.  This also removes the superflous
> initialization of the second request used for BIDI requests.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/bsg-lib.c | 32 +++++++++++++-------------------
>   1 file changed, 13 insertions(+), 19 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
