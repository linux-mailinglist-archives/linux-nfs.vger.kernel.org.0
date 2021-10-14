Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C9242D3D6
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Oct 2021 09:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhJNHjw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 03:39:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47362 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhJNHjv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 03:39:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F04120286;
        Thu, 14 Oct 2021 07:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634197066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vc6k1LW6+P7JIUbPAN5DAvg8nAR+IqMh7t9qU2NYaCY=;
        b=R/c8xngRvX6e3D3q3mdt6P9Accv9lrbY/1Vf/cQsDoSgFHFYTHCJbZXMeNL3mZpkWT7iXw
        ozUNS5HlrZ2nR3WvWvlBKhAZepZfC1LFA43ZtpuE8O1l1nE+v8QtCofYhv0IgnMzaoQZLq
        JXxaRgmrru57drOof5vL4dppQZODwGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634197066;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vc6k1LW6+P7JIUbPAN5DAvg8nAR+IqMh7t9qU2NYaCY=;
        b=/LpmFZWYnyN3KLJrI3KqiPijypyFv3X5R0qNMbtAMlr6STQ91p7pbu3M/6W/jUut4TeZvs
        qiY+cmSc8aiBjFCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28B4513D3F;
        Thu, 14 Oct 2021 07:37:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HusJCUreZ2FkIAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 14 Oct 2021 07:37:46 +0000
Subject: Re: [PATCH 5/7] scsi: add a scsi_alloc_request helper
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20211012120445.861860-1-hch@lst.de>
 <20211012120445.861860-6-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ac0b2dad-6077-f738-fa0a-0340c435e08b@suse.de>
Date:   Thu, 14 Oct 2021 09:37:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211012120445.861860-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/12/21 2:04 PM, Christoph Hellwig wrote:
> Add a new helper that calls blk_get_request and initializes the
> scsi_request to avoid the indirect call through ->.initialize_rq_fn.
> 
> Note that this makes the pktcdvd driver depend on the SCSI core, but
> given that only SCSI devices support SCSI passthrough requests that
> is not a functional change.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/Kconfig              |  2 +-
>   drivers/block/pktcdvd.c            |  2 +-
>   drivers/scsi/scsi_bsg.c            |  4 ++--
>   drivers/scsi/scsi_error.c          |  2 +-
>   drivers/scsi/scsi_ioctl.c          |  4 ++--
>   drivers/scsi/scsi_lib.c            | 19 +++++++++++++------
>   drivers/scsi/sg.c                  |  4 ++--
>   drivers/scsi/sr.c                  |  2 +-
>   drivers/scsi/st.c                  |  2 +-
>   drivers/target/target_core_pscsi.c |  3 +--
>   include/scsi/scsi_cmnd.h           |  3 +++
>   11 files changed, 28 insertions(+), 19 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
