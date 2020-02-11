Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27312159745
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2020 18:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgBKRxd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Feb 2020 12:53:33 -0500
Received: from mail1.ugh.no ([178.79.162.34]:45520 "EHLO mail1.ugh.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbgBKRxd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 Feb 2020 12:53:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.ugh.no (Postfix) with ESMTP id ACA8924EA8B;
        Tue, 11 Feb 2020 18:53:31 +0100 (CET)
Received: from mail1.ugh.no ([127.0.0.1])
        by localhost (catastrophix.ugh.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mBelwyQ0Zr-a; Tue, 11 Feb 2020 18:53:31 +0100 (CET)
Received: from [10.255.64.11] (unknown [185.176.245.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: andre@tomt.net)
        by mail.ugh.no (Postfix) with ESMTPSA id 3319D24EA6B;
        Tue, 11 Feb 2020 18:53:31 +0100 (CET)
Subject: Re: AMD IOMMU stops RDMA NFS from working since kernel 5.5 (bisected)
To:     Robin Murphy <robin.murphy@arm.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Tom Murphy <tmurphy@arista.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
References: <7ee099af-e6bb-18fe-eb93-2a8abd401570@tomt.net>
 <20200211072537.GD23114@suse.de>
 <2CE039F4-3519-4481-B0E2-840D24EE4428@oracle.com>
 <ac758665-9127-9a52-4f03-49fecc5289a2@arm.com>
 <3507674A-F860-4B65-BD46-93431DD268AC@oracle.com>
 <21c801a6-9a8b-1ebb-7e41-76e8385116ea@arm.com>
 <A411A8A6-ECEF-4EAD-84A1-99A30A213D8E@oracle.com>
 <35961bac-2f1e-3fbc-9661-031b9d5acee3@arm.com>
From:   Andre Tomt <andre@tomt.net>
Message-ID: <55784ee1-f221-85e2-d811-b0c5821161a5@tomt.net>
Date:   Tue, 11 Feb 2020 18:53:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <35961bac-2f1e-3fbc-9661-031b9d5acee3@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11.02.2020 17:36, Robin Murphy wrote:
> On 11/02/2020 4:03 pm, Chuck Lever wrote:
>> Robin, your explanation makes sense to me. I can post a fix for this 
>> imbalance later today for Andre to try.
> 
> FWIW here's a quick hack which *should* suppress the concatenation 
> behaviour - if it makes Andre's system any happier then that would 
> indeed point towards dma_map_sg() handling being the culprit.
> 
> Robin.

This hack do indeed make things work again.

> ----->8-----
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index a2e96a5fd9a7..a6b71bad518e 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -779,7 +779,7 @@ static int __finalise_sg(struct device *dev, struct 
> scatterlist *sg, int nents,
>            * - but doesn't fall at a segment boundary
>            * - and wouldn't make the resulting output segment too long
>            */
> -        if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
> +        if (0 && cur_len && !s_iova_off && (dma_addr & seg_mask) &&
>               (max_len - cur_len >= s_length)) {
>               /* ...then concatenate it with the previous one */
>               cur_len += s_length;
> @@ -799,6 +799,7 @@ static int __finalise_sg(struct device *dev, struct 
> scatterlist *sg, int nents,
>           if (s_length + s_iova_off < s_iova_len)
>               cur_len = 0;
>       }
> +    WARN_ON(count < nents);
>       return count;
>   }
> 

