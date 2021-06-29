Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F003B763B
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 18:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhF2QKU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 12:10:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232301AbhF2QIL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 12:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624982702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jPo7Zi5FmBECpYBIqUfrz1T3JgVzlEIG1jHt2GCIjvg=;
        b=P9AED9o+XrA+zUjTnsR2/LO68WVqMfWV7V3ScWtLlaQ3qrLQfuaClRNNsiwV8vMKeIDQ7r
        Vcp4Vj8c6H96P91a6p0+/MMxtRPRcZ8z8/+RbPkFxrKthRNNI7y8M2keat3mJy9ZOPAQBI
        yMJBbDHhnZR8rB3oZSYsEVnWdia1T/s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-roGFYPmOMA6qk_ivcZ_MmQ-1; Tue, 29 Jun 2021 12:05:00 -0400
X-MC-Unique: roGFYPmOMA6qk_ivcZ_MmQ-1
Received: by mail-ed1-f69.google.com with SMTP id p19-20020aa7c4d30000b0290394bdda6d9cso11644319edr.21
        for <linux-nfs@vger.kernel.org>; Tue, 29 Jun 2021 09:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jPo7Zi5FmBECpYBIqUfrz1T3JgVzlEIG1jHt2GCIjvg=;
        b=ihvQYpG9f3kyQ8lFzLX4XA2BNfndEdk7Pyc2I+wkqjDW4kjhLR6POoPf/LgPxhqoYh
         9qrtVAIYY4d+Zh7P2FZIFa/4EGRv9DjQYMsIvpvTc9iIzJOi3s47ZfCQnNUl2GA0Tj1R
         sWLTGvnN91U+U7GSGi/Gqvk08Ahpg6I/5sOueW/D57yqIOQoB7Jb7tddd8qBzHV3nCyR
         7OPvr4b8DdwIsXXoIvO6PoYfC1F0CK8LnIN28BuXuYPkaDQH9ImhuirKMU9RxXd7WhYK
         68GZADb3GrFbImKSqzIaC7kHSc4MvbKD5rebKBc9CSlwb39Y6BDegM5T0SlaoTwPkJgU
         itNg==
X-Gm-Message-State: AOAM530cjV8SVAfnk/LCulvHGf7oN6K0D1X4g2jf/im927ccMf/X3NQp
        5ZXjuxZNwCgfh+qq7vjHX9zsBh3LTVkFg3IqJevBBfQg7Jz5olFR9KgHMBh/DosgRtoi2eucIHB
        H3b4f1st7Pw+TGsSO19LX
X-Received: by 2002:a17:906:ce4f:: with SMTP id se15mr31507152ejb.232.1624982699466;
        Tue, 29 Jun 2021 09:04:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdqcA8oR0whtpagOajeaVnQl2znUUn/4oZw3mN5BmiJLX/jJLSXjbnFLWZCri9kjKOa+L1rQ==
X-Received: by 2002:a17:906:ce4f:: with SMTP id se15mr31507140ejb.232.1624982699360;
        Tue, 29 Jun 2021 09:04:59 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id z26sm472318eja.26.2021.06.29.09.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 09:04:59 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH v3] mm/page_alloc: Further fix __alloc_pages_bulk() return
 value
To:     Mel Gorman <mgorman@techsingularity.net>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org, brouer@redhat.com
References: <162497449506.16614.7781489905877008435.stgit@klimt.1015granger.net>
 <20210629153349.GG3840@techsingularity.net>
Message-ID: <a61e8076-a505-8021-26a3-3a962fb34773@redhat.com>
Date:   Tue, 29 Jun 2021 18:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629153349.GG3840@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 29/06/2021 17.33, Mel Gorman wrote:
> On Tue, Jun 29, 2021 at 09:48:15AM -0400, Chuck Lever wrote:
>> The author of commit b3b64ebd3822 ("mm/page_alloc: do bulk array
>> bounds check after checking populated elements") was possibly
>> confused by the mixture of return values throughout the function.
>>
>> The API contract is clear that the function "Returns the number of
>> pages on the list or array." It does not list zero as a unique
>> return value with a special meaning. Therefore zero is a plausible
>> return value only if @nr_pages is zero or less.
>>
>> Clean up the return logic to make it clear that the returned value
>> is always the total number of pages in the array/list, not the
>> number of pages that were allocated during this call.
>>
>> The only change in behavior with this patch is the value returned
>> if prepare_alloc_pages() fails. To match the API contract, the
>> number of pages currently in the array/list is returned in this
>> case.
>>
>> The call site in __page_pool_alloc_pages_slow() also seems to be
>> confused on this matter. It should be attended to by someone who
>> is familiar with that code.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
>

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

