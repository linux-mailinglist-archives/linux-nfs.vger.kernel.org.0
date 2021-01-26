Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A214B3041ED
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jan 2021 16:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391686AbhAZPE7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jan 2021 10:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406061AbhAZPCT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jan 2021 10:02:19 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E391FC0698C0
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jan 2021 07:01:38 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id dj6so7955987qvb.1
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jan 2021 07:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dHYhIJF3/5XU6YJf87js06xMy71uM3p96Vow3DtEX9o=;
        b=WdWUmiJC+8UYJRTvh/5UIitEcjh/T2145UmBmoaEWnGQ/iLavq64t6tRlvb//BGAQq
         3VCUG37Nar51k+dPiNF3CzPvHK3JYiJMW85otOgYWbeCX8vxizRUbZSXeXuWWIFycBGr
         fjqPj8+dHcL6KrbrlAi0FZAluWAKHuAaVSWDnScYSZ0p7yKyiHcHTUW3cqp+KZfgaCw9
         l/BFmjP/bpcNjnwBO+KhBHjChy/Tbk4sRM98bPFs+rrmeqOQ8iSzM6+HYZ1M0z/ww7C4
         WfRtB8FMyXiifrNQasVAdg6AbxCHsU54Unw0rZbDzO556nGQA5ZP7DBCURAC4mHWVVQI
         +Uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dHYhIJF3/5XU6YJf87js06xMy71uM3p96Vow3DtEX9o=;
        b=FV5NMBXzbCDcQEM1cg/oOLyAUGFD6YG8tZDAMFivt0wKTjRfsy1ExZsnSinZo/Eg0l
         Ar3Na9106veQV3+gK6DGAFIlOYe9+rIQBwfhgUvGlHVAKTg0H8Ws5wKWOBcwSjSNpkIR
         rhFwx6BZjwhV0+ftq+4XQ03ESNBXj88VTnI1wNN4P+/VzzBKY/FYTqp91/+nePd20ql2
         ZSexKF9JY7FuDxjzLpahTcqu7A9BSrG4VupsYjOYnBJ0MQOpLfJbLr0U1HYF6dSobbaD
         8KsQe6Qmj4E6QfNmbak4/rfb61ie//Eer9t3vOdwG8wyzH2Q2KpSOs0ffauE30fqI7tD
         G8RA==
X-Gm-Message-State: AOAM531mTEZEGeWaJLN0EtJ4tODuG4h55ccLvcwQ14EriVmswqDC2LWV
        j9N6x+MNOn7k0t/FojwnJ3cSyQ==
X-Google-Smtp-Source: ABdhPJy3NpFp+R6tlPWp0jY9EiL4vU+Cs/B3eEjfsSBgMM797jtRUTY+hlBsCIlFeHp5zjWk+0XbYg==
X-Received: by 2002:a0c:fdc4:: with SMTP id g4mr5783824qvs.18.1611673298035;
        Tue, 26 Jan 2021 07:01:38 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m190sm14220105qkb.42.2021.01.26.07.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 07:01:36 -0800 (PST)
Subject: Re: [PATCH 02/17] btrfs: use bio_kmalloc in __alloc_device
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, dm-devel@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
References: <20210126145247.1964410-1-hch@lst.de>
 <20210126145247.1964410-3-hch@lst.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d3717e48-9e42-fa7a-12c2-a6c97eaf4a7b@toxicpanda.com>
Date:   Tue, 26 Jan 2021 10:01:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126145247.1964410-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1/26/21 9:52 AM, Christoph Hellwig wrote:
> Use bio_kmalloc instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

yay I contributed,

Josef
