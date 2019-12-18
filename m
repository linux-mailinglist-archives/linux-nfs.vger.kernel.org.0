Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40324123CB8
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 02:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfLRByd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Dec 2019 20:54:33 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53189 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfLRByd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Dec 2019 20:54:33 -0500
Received: by mail-pj1-f66.google.com with SMTP id w23so111905pjd.2;
        Tue, 17 Dec 2019 17:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qrqBSnq1cq8FS5gawrphSxwLBseLRAGwGCvmjz1Q1II=;
        b=FbBCTikclCYR4cGrWNezWC1nVX5NuYX5aIza+PuEwNpeGE8C5QT3qX442Bm1dvsjKJ
         WZWeIgt+HEjkZSKhB7ZrHDR9zUw0IfGSUXrlwYAHm7ixZ3SePqGpOyv2Akhy9mv8W74k
         92KTUCBD0UcpMFqUURAANkl4weuwBxFXouZJPn7K3JIvyUcXDHmTY+mY0e/r8deJQ/tg
         3dFffEP+xmEk2OgPy0vx4+k3uGA7N8tl5n9YRvbAxdE1jra0J6aIvsbHwtduA20qvHI9
         hhwNiBNhUS9nNhyItjjBjQ2rIagyUdrWtVRqBquDySWVVnejp73oj7bxG3dkG7RkKMmP
         0/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qrqBSnq1cq8FS5gawrphSxwLBseLRAGwGCvmjz1Q1II=;
        b=YijV5ssOojkH8KjR8B0tdLQtSm4ZX3/7XDJZ9f+v5HFBVeN2ElcLPv8Ec0BBxwIEux
         8o9bdrsAQKxp6ZfS6HqsWdp/UU/f0S9n1Vuec54VThrXuFJRJ73SLq3SsByDCIBeQd0t
         0ikWO3u8I4uISDCNeBag/2e4fYiH6uL/eGu51pjmm+H9EsZFlmCsVunZPv939cZFMGGJ
         fGEczjcHedolfGd2aV4Hhr1dwxOGB6kJRAP2mpxhVkFJ7OrO710mX4Lr1cL7OWIL2a6Y
         F5sL7Qzh50e/TGNBLleiMXHbtxgxDQqo61Mzy8zt3CKXqPk2dhe9chOvy44oKT443Crg
         Q6WQ==
X-Gm-Message-State: APjAAAVsCs1swVGCFr7v9r2U0jnRhUmrl+PxNUQHknF8DERtZBKskEiq
        SL7nyQImj087A0soyRa6tw9CuAVI4Ts=
X-Google-Smtp-Source: APXvYqyQmq42D3Yr/fYY2dOEs2JTAP3hi2oL2Ai7adn8rGpQCh9Q4RYh+SaQ+exSlON18SVq5BaayA==
X-Received: by 2002:a17:902:9f83:: with SMTP id g3mr1395025plq.234.1576634072250;
        Tue, 17 Dec 2019 17:54:32 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.139.103? ([2402:f000:1:1501:200:5efe:a66f:8b67])
        by smtp.gmail.com with ESMTPSA id z4sm393935pfn.42.2019.12.17.17.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 17:54:31 -0800 (PST)
Subject: Re: [PATCH] fs: nfs: fix a possible sleep-in-atomic-context bug in
 _pnfs_grab_empty_layout()
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191217133319.11861-1-baijiaju1990@gmail.com>
 <ff4e1443d70acc88bba68f87650c7b5118c63f2b.camel@hammerspace.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <665af671-63fc-2aeb-8deb-e1d3324a19f7@gmail.com>
Date:   Wed, 18 Dec 2019 09:54:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <ff4e1443d70acc88bba68f87650c7b5118c63f2b.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2019/12/17 22:37, Trond Myklebust wrote:
> On Tue, 2019-12-17 at 21:33 +0800, Jia-Ju Bai wrote:
>> The filesystem may sleep while holding a spinlock.
>> The function call path (from bottom to top) in Linux 4.19 is:
>>
>> fs/nfs/pnfs.c, 2052:
>> 	pnfs_find_alloc_layout(GFP_KERNEL) in _pnfs_grab_empty_layout
>> fs/nfs/pnfs.c, 2051:
>> 	spin_lock in _pnfs_grab_empty_layout
>>
>> pnfs_find_alloc_layout(GFP_KERNEL) can sleep at runtime.
>>
>> To fix this possible bug, GFP_KERNEL is replaced with GFP_ATOMIC for
>> pnfs_find_alloc_layout().
>>
>> This bug is found by a static analysis tool STCheck written by
>> myself.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   fs/nfs/pnfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
>> index cec3070ab577..cfbe170f0651 100644
>> --- a/fs/nfs/pnfs.c
>> +++ b/fs/nfs/pnfs.c
>> @@ -2138,7 +2138,7 @@ _pnfs_grab_empty_layout(struct inode *ino,
>> struct nfs_open_context *ctx)
>>   	struct pnfs_layout_hdr *lo;
>>   
>>   	spin_lock(&ino->i_lock);
>> -	lo = pnfs_find_alloc_layout(ino, ctx, GFP_KERNEL);
>> +	lo = pnfs_find_alloc_layout(ino, ctx, GFP_ATOMIC);
>>   	if (!lo)
>>   		goto out_unlock;
>>   	if (!test_bit(NFS_LAYOUT_INVALID_STID, &lo->plh_flags))
> I'm not seeing why this is necessary. As far as I can see,
> pnfs_find_alloc_layout() will release the ino->i_lock before sleeping.
>
> False positive?
>

Thanks for the reply.
You are right, my report is false...
I did not check the definition of pnfs_find_alloc_layout(), sorry...


Best wishes,
Jia-Ju Bai
