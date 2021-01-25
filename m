Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70BF30212F
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jan 2021 05:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbhAYEhD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Jan 2021 23:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbhAYEhA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Jan 2021 23:37:00 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA1FC061786
        for <linux-nfs@vger.kernel.org>; Sun, 24 Jan 2021 20:36:20 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r38so2177875pgk.13
        for <linux-nfs@vger.kernel.org>; Sun, 24 Jan 2021 20:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FijkUVA4wtqEzKdrwPNqr5BszwjDE0ObYH72kW/p/Qc=;
        b=ba/PQSHzp1XMXEYfaF8IHUMMLul1kjomGVtf+iR7PS5f0N91qzg13X0RZJ97PPA0Vh
         2RdglhLdiBxokgZLrklGFKw5elkOv9IMkxXL0wir8HcRac0waGN3dSgDWP5u3/F7/Cgi
         zYenYmfFAphreQtQ6crnNkJJn2bJDNx+iWqrZ9M/3gKEPnNx6sQ/UjR6GyJB8zRxqnDY
         8AoCDP3zaCxdj45M0aZ0vmEL3zsal3fLpbCh9fg8FUjTPIm99GyHz5AH1S6u4wgID8kS
         qSTr2uI9gX38rFZ2+qHIncgSSpsuO7n+wVQHBnvHeHyyCbF6tB6X6fJpGBFJ/5ws39Hs
         f7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FijkUVA4wtqEzKdrwPNqr5BszwjDE0ObYH72kW/p/Qc=;
        b=hW4RwOcgDYDdUFHFTsvMtykMwX3V7UWMYC9tBjfbbcBniyvFQdh229HrFhxDoDJXVp
         qQ8RIp79k9noMKB9gQOoXksTTxQUr1mK1+AcelmPq10YVdbmUdlp2K8R1XKmksp8xx2x
         9jQsiReBric2aKa3f9MUwZbc6s3hTLxx3s1JewzHBAlmWNE+gcVfaBaAi1zoFRI+qns3
         VND5n62VIG7fEhZe/p3qe6YyjWqQ5GlUwdqMfpHxIb80B9VMeKcBFsf9K7I0efWToC62
         ExLUrQ2YNVjP4WVdjgyrSdJPtIA6/hiv0h1l3crlzleUrDyHSWS8ItSGS5ckYnVg4a32
         FcnA==
X-Gm-Message-State: AOAM532et5jEfwVWQ0o8SkKXqSSpoQzC+HrcmyKWh96nUVQvEOwr2gYN
        5sF0NanLBvVgSTJlVMyKxACOhg==
X-Google-Smtp-Source: ABdhPJwqMLqKBZAD9FxC+3lNxtWNGWUkaLysCeumNlPXimZYcundbTEt00KrsFB9Hb+bWilXVtUrpA==
X-Received: by 2002:a63:d917:: with SMTP id r23mr1043183pgg.126.1611549378270;
        Sun, 24 Jan 2021 20:36:18 -0800 (PST)
Received: from [10.8.2.15] ([185.125.207.232])
        by smtp.gmail.com with ESMTPSA id k64sm14947157pfd.75.2021.01.24.20.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 20:36:17 -0800 (PST)
Subject: Re: [PATCH V2 2/2] block: remove unnecessary argument from
 blk_execute_rq
To:     Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ide@vger.kernel.org, target-devel@vger.kernel.org
References: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
 <20210122092824.20971-3-guoqing.jiang@cloud.ionos.com>
 <CAPDyKFoPL4drfh3efKXyhXLp6Ce+j=oHwNd9VnVP4aaKQ0zmDQ@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <439d415f-6aed-7092-a593-0d2d490652d2@cloud.ionos.com>
Date:   Mon, 25 Jan 2021 05:35:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoPL4drfh3efKXyhXLp6Ce+j=oHwNd9VnVP4aaKQ0zmDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/22/21 10:50, Ulf Hansson wrote:
> On Fri, 22 Jan 2021 at 10:28, Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:
>>
>> We can remove 'q' from blk_execute_rq as well after the previous change
>> in blk_execute_rq_nowait.
>>
>> And more importantly it never really was needed to start with given
>> that we can trivial derive it from struct request.
>>
>> Cc: linux-scsi@vger.kernel.org
>> Cc: virtualization@lists.linux-foundation.org
>> Cc: linux-ide@vger.kernel.org
>> Cc: linux-mmc@vger.kernel.org
>> Cc: linux-nvme@lists.infradead.org
>> Cc: linux-nfs@vger.kernel.org
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> 
> [...]
> 
>>   drivers/mmc/core/block.c          | 10 +++++-----
> 
> [...]
> 
>  From mmc point of view, please add:
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> At the moment I don't think this will conflict with any changes to
> mmc, but if that happens let's sort it then...
> 

Thank you! Will resend and add your acked-by.

Guoqing
