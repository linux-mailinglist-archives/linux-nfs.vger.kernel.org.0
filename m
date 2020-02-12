Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C54C415ACA0
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 17:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBLQDa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Feb 2020 11:03:30 -0500
Received: from mail1.ugh.no ([178.79.162.34]:49078 "EHLO mail1.ugh.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLQDa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Feb 2020 11:03:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.ugh.no (Postfix) with ESMTP id ADC6424EAC9;
        Wed, 12 Feb 2020 17:03:28 +0100 (CET)
Received: from mail1.ugh.no ([127.0.0.1])
        by localhost (catastrophix.ugh.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uPMdJS4zdReN; Wed, 12 Feb 2020 17:03:27 +0100 (CET)
Received: from [10.255.64.11] (unknown [185.176.245.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: andre@tomt.net)
        by mail.ugh.no (Postfix) with ESMTPSA id B710324EAB0;
        Wed, 12 Feb 2020 17:03:27 +0100 (CET)
Subject: Re: [PATCH v2] xprtrdma: Fix DMA scatter-gather list mapping
 imbalance
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        iommu@lists.linux-foundation.org
References: <158151473332.515306.1111360128438553868.stgit@morisot.1015granger.net>
 <869DC73D-190E-46AB-B8F8-1A394F92AF41@oracle.com>
From:   Andre Tomt <andre@tomt.net>
Message-ID: <1d2693b1-b37f-c611-91c3-55b567be5274@tomt.net>
Date:   Wed, 12 Feb 2020 17:03:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <869DC73D-190E-46AB-B8F8-1A394F92AF41@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 12.02.2020 14:48, Chuck Lever wrote:
>> On Feb 12, 2020, at 8:43 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> The @nents value that was passed to ib_dma_map_sg() has to be passed
>> to the matching ib_dma_unmap_sg() call. If ib_dma_map_sg() choses to
>> concatenate sg entries, it will return a different nents value than
>> it was passed.
>>
>> The bug was exposed by recent changes to the AMD IOMMU driver, which
>> enabled sg entry concatenation.
>>
>> Looking all the way back to 4143f34e01e9 ("xprtrdma: Port to new
>> memory registration API") and reviewing other kernel ULPs, it's not
>> clear that the frwr_map() logic was ever correct for this case.
>>
>> Reported-by: Andre Tomt <andre@tomt.net>
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/trace/events/rpcrdma.h |    6 ++++--
>> net/sunrpc/xprtrdma/frwr_ops.c |   13 +++++++------
>> 2 files changed, 11 insertions(+), 8 deletions(-)
>>
>> Hi Andre, here's take 2, based on the trace data you sent me.
>> Please let me know if this one fares any better.
>>
>> Changes since v1:
>> - Ensure the correct nents value is passed to ib_map_mr_sg
>> - Record the mr_nents value in the MR trace points
Verified working (with the patch correction) in my environment, with 
some quick testing (mount + some random and bulk I/O)

client, 5.5.3 + patch + amd iommu on = OK
client, 5.5.3 + patch + amd iommu off = OK
client, 5.6-rc1 + patch + amd iommu on = OK

server, 5.5.3 + patch + intel iommu on = OK

Thanks!

