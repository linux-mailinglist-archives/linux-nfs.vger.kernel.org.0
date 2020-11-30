Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553422C84D3
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 14:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgK3NMs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 08:12:48 -0500
Received: from btbn.de ([5.9.118.179]:34412 "EHLO btbn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgK3NMq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Nov 2020 08:12:46 -0500
X-Greylist: delayed 1130 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Nov 2020 08:12:45 EST
Received: from [IPv6:2001:16b8:64b8:ea00:8985:359a:bb0c:c985] (200116b864b8ea008985359abb0cc985.dip.versatel-1u1.de [IPv6:2001:16b8:64b8:ea00:8985:359a:bb0c:c985])
        by btbn.de (Postfix) with ESMTPSA id C9E0224FE28
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:12:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothenpieler.org;
        s=mail; t=1606741924;
        bh=z7JbJvPbaP9DuxXwjrZgtJVAa6cd8EIASlf43c00tzM=;
        h=Subject:From:To:References:Date:In-Reply-To;
        b=rKE/yJb1PkR7jYYpPmwwg0MLOaaBLnvUy4DcXPD4EYGuju98//99Fqc10zTsDjauW
         pCd8ykdMrCg/FVgZmfThhuCtE1hsvOV9TxhZqPNLcqdEEX+wYP/10khWvX+yC81BiZ
         f7ldKTYMc5hkY/49y2qVLhmGMzKS23f9k6C94WHlcMxwkBLvkDfrqFUOvTj/79wEZC
         xmTUwpf1Qc8X6oer4q49BobC7N+ZOM7QcN2t9aWTERXCMrrptNFQByOQmTcWrMua26
         Hs+WIihAgfFngBAqgHd6nIMuBOVXF6gLoXhA74b86gtE2eF5w4NsausEzZrbtHMzqZ
         ZGm+Y/HdVnUmw==
Subject: Re: linux-5.4.80: "refcount_t: underflow; use-after-free" in
 rpc_async_schedule->rpc_free_task->nfs4_put_copy
From:   Timo Rothenpieler <timo@rothenpieler.org>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <f310cd4d-c36e-ee14-2296-aa13b12cb438@rothenpieler.org>
Message-ID: <81fa8f5a-5ebf-07cb-f9a9-8b3da63f330f@rothenpieler.org>
Date:   Mon, 30 Nov 2020 14:12:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <f310cd4d-c36e-ee14-2296-aa13b12cb438@rothenpieler.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 30.11.2020 13:53, Timo Rothenpieler wrote:
> I don't know for sure if changes to the 5.4 kernel have triggered this, 
> or changes in singularity which now make use of copy_file_range.
> But restarting the nfs server, and then doing a "singularity pull" 
> reliably triggers that dmesg message.
> 
> I found commit 49a361327332c9221438397059067f9b205f690d, but it seems 
> related to the inter ssc stuff, which isn't even present in 5.4.

Quick update: I applied that commit on top of the 5.4.80 Kernel, and 
have not been able to reproduce the issue anymore in a quick test.
Will leave it running like this for a bit and see if it's fixed.

I don't know if this is in any way correct though.
