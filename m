Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D292D3B7627
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 18:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhF2QGJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 12:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234031AbhF2QGB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 12:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624982599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3iRhbclAGpXROLJyUpX6Pw21XMZ1Ti2hB2Ivbm6GwU=;
        b=IqZ2a1ZxFTYkRLtz1lGWbYn2TGkYQV5U7clmlLqHRgd5e/G27c3TYi9m9lemvcqbZlW7CT
        McoE1HgGMsDf3YI6d3o8Kyna6zSZpOyXBYX0z1OCo/FCYX2g0Zn7DKLnv5OVimTSJfuayD
        5i8izSgQ30/klBa3gsDrZ5PfNCywA0g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-emjUeBIfMHCAssmS42iDjA-1; Tue, 29 Jun 2021 12:01:15 -0400
X-MC-Unique: emjUeBIfMHCAssmS42iDjA-1
Received: by mail-ed1-f69.google.com with SMTP id f20-20020a0564020054b0290395573bbc17so4534544edu.19
        for <linux-nfs@vger.kernel.org>; Tue, 29 Jun 2021 09:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Q3iRhbclAGpXROLJyUpX6Pw21XMZ1Ti2hB2Ivbm6GwU=;
        b=oxf2NVyT4IXomcW4khuuXnscjCVe5VPKG7KAgpYIf1iwuajcHXg9wkxnWVKkcGn25e
         1hxmbYPY0xatCs2uPWYdyKElpBJieuG6WiGr7DiQTh6n0dUIOZgMT1n7/93Zg5a/j+93
         x/A9McOPejM409hpPp1zkrEU+yVlwtG5jcVMRUvyaHP4CTl9bwnqF+IJ3+H74w+0x9ry
         ulWgDaq4XKcR/MT+QnlRQIuXbVF1zV/6bFR2LprQxxpAw9zmc0RNRWo8clpu7FfJz45c
         H3+S2vijVFKdksdCBW+m0w7+RvA2yM/xLn7aXOIbvy29ufBpJnCjsjEzD4SyLANnzpND
         dwaw==
X-Gm-Message-State: AOAM532O0kbNbNQjTNeobleMhq9tFgQP8ogxvtla0talPvcWMXVsgo7c
        E4kmIzsdGrlcuSBNZG81ldEyKZVpUz/SIxQ1rYA9bCX0aZ3cYfw9/vaKZZ1mz+vUzSKrTOzn03m
        4x2kxVGVQ1fhzlajvaSK2
X-Received: by 2002:aa7:d592:: with SMTP id r18mr6878645edq.269.1624982474137;
        Tue, 29 Jun 2021 09:01:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzHHBh/dOOBuzH+iLhxo7Ei4q2Sb0V9xqbsaUrEKcAK8Ljsc42TzCSKRVhFES5NkxpomEUOQ==
X-Received: by 2002:aa7:d592:: with SMTP id r18mr6878634edq.269.1624982474034;
        Tue, 29 Jun 2021 09:01:14 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id v5sm11415632edt.55.2021.06.29.09.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 09:01:13 -0700 (PDT)
Subject: Re: [PATCH v3] mm/page_alloc: Further fix __alloc_pages_bulk() return
 value
To:     Chuck Lever <chuck.lever@oracle.com>, mgorman@techsingularity.net
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org, brouer@redhat.com
References: <162497449506.16614.7781489905877008435.stgit@klimt.1015granger.net>
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
Message-ID: <be9186d9-1e8e-4d99-ab0f-84c0518025c5@redhat.com>
Date:   Tue, 29 Jun 2021 18:01:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <162497449506.16614.7781489905877008435.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 29/06/2021 15.48, Chuck Lever wrote:

> The call site in __page_pool_alloc_pages_slow() also seems to be
> confused on this matter. It should be attended to by someone who
> is familiar with that code.

I don't think we need a fix for __page_pool_alloc_pages_slow(), as the 
array is guaranteed to be empty.

But a fix would look like this:

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index c137ce308c27..1b04538a3da3 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -245,22 +245,23 @@ static struct page 
*__page_pool_alloc_pages_slow(struct page_pool *pool,
         if (unlikely(pp_order))
                 return __page_pool_alloc_page_order(pool, gfp);

         /* Unnecessary as alloc cache is empty, but guarantees zero 
count */
-       if (unlikely(pool->alloc.count > 0))
+       if (unlikely(pool->alloc.count > 0))   // ^^^^^^^^^^^^^^^^^^^^^^
                 return pool->alloc.cache[--pool->alloc.count];

         /* Mark empty alloc.cache slots "empty" for 
alloc_pages_bulk_array */
         memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);

+       /* bulk API ret value also count existing pages, but array is 
empty */
         nr_pages = alloc_pages_bulk_array(gfp, bulk, pool->alloc.cache);
         if (unlikely(!nr_pages))
                 return NULL;

         /* Pages have been filled into alloc.cache array, but count is 
zero and
          * page element have not been (possibly) DMA mapped.
          */
-       for (i = 0; i < nr_pages; i++) {
+       for (i = pool->alloc.count; i < nr_pages; i++) {
                 page = pool->alloc.cache[i];
                 if ((pp_flags & PP_FLAG_DMA_MAP) &&
                     unlikely(!page_pool_dma_map(pool, page))) {
                         put_page(page);

