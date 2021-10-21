Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8A843631B
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 15:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJUNgq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 09:36:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36044 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhJUNgp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Oct 2021 09:36:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 597272199D;
        Thu, 21 Oct 2021 13:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634823268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWF3N189nqk9QfOozLtyL2wMdRZFQPA2LrP487Lut3s=;
        b=BwjBm5b1r6VpqNvegMrdEUegHzhMAI9RKeLHgh+cHQN34DTUVyd2vFKpDTs0QF2sq5sLY3
        hfoBK5fJo78y+cql5bGhGZJ3evrIWdOpwv+VH85gDn3b6KH4tYFkK0qYXi9Q7x1XYAErWR
        7FZ6RJnNLFl/sNjUnTHD7crGEUl0MmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634823268;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWF3N189nqk9QfOozLtyL2wMdRZFQPA2LrP487Lut3s=;
        b=esUjDTh4UdlNHPVJNS18Y38yCdgCykCb9qK4+wjgKPmbPHLnGbwAFNYh9tcXyaXkuLW+nX
        RaLEhy9Q/AEn7oAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BC2F13BA5;
        Thu, 21 Oct 2021 13:34:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ADC7BWRscWFYJgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 21 Oct 2021 13:34:28 +0000
Subject: Re: [PATCH 1/7] block: add a ->get_unique_id method
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20211021060607.264371-1-hch@lst.de>
 <20211021060607.264371-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0acbd09c-6c31-3413-2fb1-9d15f2ee6201@suse.de>
Date:   Thu, 21 Oct 2021 15:34:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211021060607.264371-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/21/21 8:06 AM, Christoph Hellwig wrote:
> Add a method to query unique IDs from block devices.  It will be used to
> remove code that deeply pokes into SCSI internals in the NFS server.
> The implementation in the sd driver itself is also much nicer as it can
> use the cached VPD page instead of always sending a command as the
> current NFS code does.
> 
> For now the interface is kept very minimal but could be easily
> extended when other users like a block-layer sysfs interface for
> uniquue IDs shows up.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/blkdev.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
