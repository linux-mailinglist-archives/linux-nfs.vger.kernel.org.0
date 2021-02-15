Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C601D31BABF
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 15:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhBOOJI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 09:09:08 -0500
Received: from natter.dneg.com ([193.203.89.68]:43316 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhBOOJB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 15 Feb 2021 09:09:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id 0D8BC2871536;
        Mon, 15 Feb 2021 14:08:19 +0000 (GMT)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id pFg_rmG3bJxT; Mon, 15 Feb 2021 14:08:18 +0000 (GMT)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id D8CC02871533;
        Mon, 15 Feb 2021 14:08:18 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id CA97F81B32AB;
        Mon, 15 Feb 2021 14:08:18 +0000 (GMT)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kvjJ2Fr7hUuJ; Mon, 15 Feb 2021 14:08:18 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 8C2DD81B2F6C;
        Mon, 15 Feb 2021 14:08:18 +0000 (GMT)
X-Virus-Scanned: amavisd-new at zrozimbrai.dneg.com
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GHOa8PlelrOH; Mon, 15 Feb 2021 14:08:18 +0000 (GMT)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 6D60781B32D9;
        Mon, 15 Feb 2021 14:08:18 +0000 (GMT)
Date:   Mon, 15 Feb 2021 14:08:18 +0000 (GMT)
From:   Daire Byrne <daire@dneg.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Message-ID: <608881118.10473767.1613398098205.JavaMail.zimbra@dneg.com>
In-Reply-To: <E39E6630-91A9-48DA-A6CF-6AE5BF6CEDD1@oracle.com>
References: <20210213202532.23146-1-trondmy@kernel.org> <952C605B-C072-4C6B-B9C0-88C25A3B891E@oracle.com> <f025fa709f923255b9cb8e76a9b5ad4cca9355c4.camel@hammerspace.com> <4CD2739A-D39B-48C9-BCCF-A9DF1047D507@oracle.com> <285652682.9476664.1613312016960.JavaMail.zimbra@dneg.com> <E39E6630-91A9-48DA-A6CF-6AE5BF6CEDD1@oracle.com>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on
 the server
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_3990 (ZimbraWebClient - GC78 (Linux)/9.0.0_GA_3990)
Thread-Topic: SUNRPC: Use TCP_CORK to optimise send performance on the server
Thread-Index: AQHXAkZmunoZe40LXUmxO15yQAmlIKpWoMoAgAAEs4CAABZCgMgY7/PBt+g1IgC0y9QTNg==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


----- On 14 Feb, 2021, at 16:59, Chuck Lever chuck.lever@oracle.com wrote:

>>>> I don't have a performance system to measure the improvement
>>>> accurately.
>>> 
>>> Then let's have Daire try it out, if possible.
>> 
>> I'm happy to test it out on one of our 2 x 40G NFS servers with 100 x 1G clients
>> (but it's trickier to patch the clients too atm).
> 
> Yes, that's exactly what we need. Thank you!
> 
>> Just so I'm clear, this is in addition to Chuck's "Handle TCP socket sends with
>> kernel_sendpage() again" patch from bz #209439 (which I think is now in 5.11
>> rc)? Or you want to see what this patch looks like on it's own without that
>> (e.g. v5.10)?
> 
> Please include the "Handle TCP socket sends with kernel_sendpage() again" fix.
> Or, you can pull a recent stable kernel, I think that fix is already in there.

I took v5.10.16 and used a ~100Gbit capable server with ~150 x 1 gbit clients all reading the same file from the server's pagecache as the test. Both with and without the patch, I consistently see around 90gbit worth of sends from the server for sustained periods. Any differences between them are well within margins of error for repeat runs of the benchmark.

The only noticeable difference is in the output of perf top where svc_xprt_do_enqueue goes from ~0.9% without the patch to ~3% with the patch. It now takes up second place (up from 17th place) behind native_queued_spin_lock_slowpath:

   3.57%  [kernel]                     [k] native_queued_spin_lock_slowpath
   3.07%  [kernel]                     [k] svc_xprt_do_enqueue

I also don't really see much difference in the softirq cpu usage.

So there doesn't seem to be any negative impacts of the patch but because I'm already pushing the server to it's network hardware limit (without the patch), it's also not clear if it is improving performance for this benchmark either.

I also tried with 50 clients and sustained the expected 50gbit sends from the server in both with and without the patch.

Daire
