Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE942D3B9
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Oct 2021 09:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhJNHek (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 03:34:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45638 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhJNHej (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 03:34:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3151620286;
        Thu, 14 Oct 2021 07:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634196754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjkNEVVjVcnP4hxfrSWte/g2gEgbpNDROzH+m+hvbno=;
        b=QpdvNs60TPbyvV1pd5g9ncCfKB+ob/5GkgR2R3wVl/O8W7CqHWXCGKnolRK5Ifj59iN+10
        ripUueOCNLNimq2k5vW9gPCDe0WptlrAQpFRkzNdbeWQVOhrYYHcJ2S8uWFQdU2Plcxz3G
        JmHsBXdiI35RbTXU6DZb8aoJkrLniNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634196754;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjkNEVVjVcnP4hxfrSWte/g2gEgbpNDROzH+m+hvbno=;
        b=7gRLpFsQzHxzzZrM5i+z3aO+cnlEWL5QbiACQUbIwmvnp8R3H17KBKdWMK29HorgDEkFdH
        /yx3MtmStEAWe4DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE12113D3F;
        Thu, 14 Oct 2021 07:32:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id piMHORHdZ2HIHQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 14 Oct 2021 07:32:33 +0000
Subject: Re: [PATCH 3/7] nfsd/blocklayout: use ->get_unique_id instead of
 sending SCSI commands
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20211012120445.861860-1-hch@lst.de>
 <20211012120445.861860-4-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <eb94c653-3fde-5415-119e-76f0076cbe56@suse.de>
Date:   Thu, 14 Oct 2021 09:32:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211012120445.861860-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/12/21 2:04 PM, Christoph Hellwig wrote:
> Call the ->get_unique_id method to query the SCSI identifiers.  This can
> use the cached VPD page in the sd driver instead of sending a command
> on every LAYOUTGET.  It will also allow to support NVMe based volumes
> if the draft for that ever takes off.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/nfsd/Kconfig       |   1 -
>   fs/nfsd/blocklayout.c | 158 +++++++++++-------------------------------
>   fs/nfsd/nfs4layouts.c |   5 +-
>   3 files changed, 44 insertions(+), 120 deletions(-)
> 
Not that I'm an NFS expert, but anyway:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
