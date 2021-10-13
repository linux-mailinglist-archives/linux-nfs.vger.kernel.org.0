Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA5D42C48C
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 17:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhJMPOM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 11:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhJMPOM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Oct 2021 11:14:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BA7C061570
        for <linux-nfs@vger.kernel.org>; Wed, 13 Oct 2021 08:12:08 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u21so10109555lff.8
        for <linux-nfs@vger.kernel.org>; Wed, 13 Oct 2021 08:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IEh/Vp3wgG89sElnMDDPQ7oHU5jx1LUOnsP2BSPPsqw=;
        b=G5OHlvJiGiMG/i4yLgq+lG9sYIOs1wVcxcKHbczzcuZBZQf4UQGU7lzycZXWnbMbHi
         glyunzYU+jxM8uhOjs4ZiVS0WuLu8h8O/uOtkJBt5Ywe0UWm1fXvwMDYdtMB8uQsqn5D
         5Kbcixly6AEjaDFeVUIL0sykt9R0Tet2ggpWG8GEsJ5MLEM4jkiJ7goPGkuRbrF65XwU
         tJ5kG+p6Las4cEbBBLfLKbQRewM0ufl2HybmZbSDrjv9xiOT7U4vcwTuSlCFJaa2lVXX
         25AgtXSDrIPd1xC3ZQfh4Cz/LeMv8+Qy7A1ainixCIE2He3ksDgATrdJAsxL/uOx9aUk
         /Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IEh/Vp3wgG89sElnMDDPQ7oHU5jx1LUOnsP2BSPPsqw=;
        b=tfNh99na49MlP9SaBwN5LcLjm/68QOwxaYwR2/qQZmLu+9GSAz4FCwinjQIxatgcrr
         ic022sQwXBVTQuSjdGezSoGUuiy0uS2pyk16qRN1TJpIH1JZ7gGWKtPGM84E7OchA6y3
         RDOwWmh1UEDE2ajlbGdX54RLfsYFaiPhkyifWSWBm6Ms+oyeTx7DSIl8eapaVLY2no/a
         c9UJRJIfnCwUEWAqqjMbHKBEJcXDl0YxE55r+azprWzb8tgVM892YMOu+FikX0Y8fPnX
         YUOH9NSGPeEIzXLUCBM9CxL6d4Y9qj1qRPxHgP5reSCO4M551W8FkH9O+F5Q3BwE7HJF
         2Juw==
X-Gm-Message-State: AOAM5320iootgAXxA5urKGnuKDnXkacGnqg4Pu/o3+xskYJm4QhjeJfU
        fNLxC3wwrsDhdX5n6Xfm1Sg=
X-Google-Smtp-Source: ABdhPJz3L8WvpglDarAnEcVC4jnAVC8Ko7aFEsLGASA8xvKrkMmjvSxsXRyWxwOLaeNjvNYwq+MEqA==
X-Received: by 2002:a05:651c:12c5:: with SMTP id 5mr38478355lje.130.1634137926084;
        Wed, 13 Oct 2021 08:12:06 -0700 (PDT)
Received: from [10.0.3.209] (dsl-kpobng11-58c303-5.dhcp.inet.fi. [88.195.3.5])
        by smtp.gmail.com with ESMTPSA id a19sm1503436ljb.3.2021.10.13.08.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 08:12:05 -0700 (PDT)
Subject: Re: Stalling NFS reads with "SUNRPC: refresh rq_pages using a bulk
 page allocator"
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Bruce Fields <bfields@fieldses.org>
References: <2a9bdb23-e10d-1586-7b14-ca32af1939f5@gmail.com>
 <0F6DEA40-409C-46B6-917D-1C588E0D0B8C@oracle.com>
From:   Jussi Kansanen <jussi.kansanen@gmail.com>
Message-ID: <aae9ccfc-f2ce-50c5-fdae-e6808b10c22b@gmail.com>
Date:   Wed, 13 Oct 2021 18:12:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0F6DEA40-409C-46B6-917D-1C588E0D0B8C@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/12/21 10:51 PM, Chuck Lever III wrote:
> 
> 
>> On Oct 12, 2021, at 3:44 PM, Jussi Kansanen <jussi.kansanen@gmail.com> wrote:
>>
>> Hello,
>>
>> I started to get stalling NFS reads after upgrading to 5.13 kernel (from 5.12) and the issue still persist in 5.14. Bisection lead to commit f6e70aab9dfe0c2f79cf7dbcb1e80fa71dc60b09, reverting it from 5.13.19 seems to solve the issue.
> 
> Hello Jussi-
> 
> There have been several recent fixes in this area. Try v5.14.11.
> 

Hello Chuck,

Upgrading to 5.14.12 fixed the problem, thanks.

> 
>> The problem is as follows, and seems to be reproducible:
>>
>> - Boot up system.
>>
>> - Run "tar cf - /nfsshare/somelargedir | pv > /dev/null" or just any sequential read on a large enough file.
>>
>> - Stalls start to happen usually after 2-32GB is read, though sometimes it can take up to 200GB of reads.
>>
>> When stalling starts the transfer rate drops to zero and all NFS shares come unresponsive. Stalls usually last between 5-15 seconds and there's no errors logged, though sometimes "nfs server not responding" errors are logged on the client side, but those aren't typical. After the read resumes it only lasts few seconds before stall happens again and keeps repeating ...
>>
>> Tests done with 10Gb network and kernels:
>>
>> client:
>> - 5.14.9
>>
>> server:
>> - 5.12.19 - OK
>> - 5.13.19 - stalls
>> - 5.13.19 - OK with f6e70aab9dfe0c2f79cf7dbcb1e80fa71dc60b09 reverted
>> - 5.14.7  - stalls
>>
>> Server kernel config included as attachment.
>>
>>
>> -Jussi Kansanen
>> <config.gz>
> 
> --
> Chuck Lever
> 
> 
> 

