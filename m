Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7861C436324
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 15:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhJUNhM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 09:37:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49484 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhJUNhL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Oct 2021 09:37:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6712D1FDB2;
        Thu, 21 Oct 2021 13:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634823294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mzsMoFjrIe9rEFNrvGJko7LHu+ho/OZZuj6DzAf83vI=;
        b=H+9IdCABfIYLMl9vH5vxhkLzhCQqJvx/jv40DH3m9iIGOKjLTK87s9N5dgc9Fxmv9kp4PH
        BeQme7TNr7Gr3rx32AOF0iHCG0D4gJI2LpLC+PJTcVFhDMlzwg5RRpY6n5ZRxGcK2bAMAn
        Ov83sqgBWbl8dgn0CdHApn/9hJrPciQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634823294;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mzsMoFjrIe9rEFNrvGJko7LHu+ho/OZZuj6DzAf83vI=;
        b=heSI6UI+Uq3Ur0tICFoy21TGqnXgYWOpYdPazHPB2TgLnAduGJP37HeTVFaKxVnke/++tU
        oQAQn92D6K1cEgCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 018CB13BA5;
        Thu, 21 Oct 2021 13:34:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dA7pOn1scWGKJgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 21 Oct 2021 13:34:53 +0000
Subject: Re: [PATCH 2/7] sd: implement ->get_unique_id
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20211021060607.264371-1-hch@lst.de>
 <20211021060607.264371-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5cd0647b-eb95-1a8e-55e3-77d9f0965f20@suse.de>
Date:   Thu, 21 Oct 2021 15:34:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211021060607.264371-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/21/21 8:06 AM, Christoph Hellwig wrote:
> Add the method to query for a uniqueue ID of a given type by looking
> it up in the cached device identification VPD page.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/sd.c | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
