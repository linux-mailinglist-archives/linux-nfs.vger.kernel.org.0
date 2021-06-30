Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E863B813C
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 13:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhF3LY6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 07:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45199 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233706AbhF3LY6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 07:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625052149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hZe3HRwjGbdUS4a+UHy4KVxNJVUaIIhLxmWrSO/7m/4=;
        b=avhVoNmfQTlLfKc8UoFfCfCdc5a9CT2ro/SxiHqCKF3AIakEOSdVET2OTd2V7gxjNgA51E
        bBsU/9b40bFmnVZz969+a7w7DPCIvC/N7D1+V0l/I2jcPoNFrM3kyYItp+URurbBrDRsoX
        IiaEhEuEXJcIUrabj2wBgAeNrA9GtRg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-P3skFJ6UOM-IpS7DYp_k3w-1; Wed, 30 Jun 2021 07:22:27 -0400
X-MC-Unique: P3skFJ6UOM-IpS7DYp_k3w-1
Received: by mail-ed1-f71.google.com with SMTP id ds1-20020a0564021cc1b02903956bf3b50cso974785edb.8
        for <linux-nfs@vger.kernel.org>; Wed, 30 Jun 2021 04:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hZe3HRwjGbdUS4a+UHy4KVxNJVUaIIhLxmWrSO/7m/4=;
        b=TFoTU3/QMlwfcN/fWQh28nlXKARqNAI5ERlRVRFQZB7hr+Uc9P9sSW8bfkmTbs03Gn
         dAgM0aevjWCDh5JTE3GYKl2C4CDZT7uqHsbd5nNZKnNrx0ZQq4bLdbnLinWm2oZ2p3pQ
         s5jnttqkDmj+UmyAMNuDn5nFZDUrt8n5vTtGsh8UPgiBIcAWSTFYTyDL3JRkQKmd5u8I
         /YczuBcS9rbBjch2wsWIJQeuk6IGqGY6CZXYvmMX7diLjvBYNIKHbOhRyqvKylaNIfKn
         qv3uYqwrpJF7Gc8tjCR7PegBhBeBCor7lRFkWwP9vIZN+PGD8mjM73qYAug55iOnlD2w
         sFPQ==
X-Gm-Message-State: AOAM5301G93wyIOc+KQeujCXx2jkCK4Jax5EUBUyZet1YDCCWPYUYM+x
        k5fh3MYdKmpfL50ym29YBsCzhy7Xvxcw124eVYZ8Tq5K+9nlYUbfnN6Kh04PDWFpTU+jMimIAOu
        cgnA5Y023DPunyHuJt7ZS
X-Received: by 2002:aa7:cc0c:: with SMTP id q12mr6424949edt.90.1625052146485;
        Wed, 30 Jun 2021 04:22:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl846YvgPZS/i3m2UiD4wApXBXBXOk7WDMlmWd/jD2eoxyN84be9yTzU49FOsX5kva58d6gA==
X-Received: by 2002:aa7:cc0c:: with SMTP id q12mr6424939edt.90.1625052146336;
        Wed, 30 Jun 2021 04:22:26 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id b24sm9431321ejl.61.2021.06.30.04.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 04:22:25 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH v3] mm/page_alloc: Further fix __alloc_pages_bulk() return
 value
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, brouer@redhat.com
References: <162497449506.16614.7781489905877008435.stgit@klimt.1015granger.net>
 <be9186d9-1e8e-4d99-ab0f-84c0518025c5@redhat.com>
 <20210630065855.GH3840@techsingularity.net>
Message-ID: <543ef038-d50c-f035-bd9d-ae3140ca0e33@redhat.com>
Date:   Wed, 30 Jun 2021 13:22:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630065855.GH3840@techsingularity.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 30/06/2021 08.58, Mel Gorman wrote:
> On Tue, Jun 29, 2021 at 06:01:12PM +0200, Jesper Dangaard Brouer wrote:
>> On 29/06/2021 15.48, Chuck Lever wrote:
>>
>>> The call site in __page_pool_alloc_pages_slow() also seems to be
>>> confused on this matter. It should be attended to by someone who
>>> is familiar with that code.
>> I don't think we need a fix for __page_pool_alloc_pages_slow(), as the array
>> is guaranteed to be empty.
>>
>> But a fix would look like this:
>>
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index c137ce308c27..1b04538a3da3 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -245,22 +245,23 @@ static struct page
>> *__page_pool_alloc_pages_slow(struct page_pool *pool,
>>          if (unlikely(pp_order))
>>                  return __page_pool_alloc_page_order(pool, gfp);
>>
>>          /* Unnecessary as alloc cache is empty, but guarantees zero count */
>> -       if (unlikely(pool->alloc.count > 0))
>> +       if (unlikely(pool->alloc.count > 0))   // ^^^^^^^^^^^^^^^^^^^^^^
>>                  return pool->alloc.cache[--pool->alloc.count];
>>
>>          /* Mark empty alloc.cache slots "empty" for alloc_pages_bulk_array
>> */
>>          memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
>>
>> +       /* bulk API ret value also count existing pages, but array is empty
>> */
>>          nr_pages = alloc_pages_bulk_array(gfp, bulk, pool->alloc.cache);
>>          if (unlikely(!nr_pages))
>>                  return NULL;
>>
>>          /* Pages have been filled into alloc.cache array, but count is zero
>> and
>>           * page element have not been (possibly) DMA mapped.
>>           */
>> -       for (i = 0; i < nr_pages; i++) {
>> +       for (i = pool->alloc.count; i < nr_pages; i++) {
> That last part would break as the loop is updating pool->alloc_count.
The last part "i = pool->alloc.count" probably is a bad idea.
> Just setting pool->alloc_count = nr_pages would break if PP_FLAG_DMA_MAP
> was set and page_pool_dma_map failed. Right?

Yes, this loop is calling page_pool_dma_map(), and if that fails we 
don't advance pool->alloc_count.

--Jesper

