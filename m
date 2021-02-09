Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFA2315516
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Feb 2021 18:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhBIR2H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Feb 2021 12:28:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:40048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233234AbhBIR1x (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 9 Feb 2021 12:27:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 924CDAB71;
        Tue,  9 Feb 2021 17:27:11 +0000 (UTC)
Subject: Re: alloc_pages_bulk()
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     "mgorman@suse.de" <mgorman@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
 <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
 <20210209113108.1ca16cfa@carbon>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7e8efe19-94da-3f75-2380-2a54b36d5ab5@suse.cz>
Date:   Tue, 9 Feb 2021 18:27:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209113108.1ca16cfa@carbon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/9/21 11:31 AM, Jesper Dangaard Brouer wrote:
> On Mon, 8 Feb 2021 17:50:51 +0000
> Chuck Lever <chuck.lever@oracle.com> wrote:
> 
>> Sorry for resending. I misremembered the linux-mm address.
>> 
>> > Begin forwarded message:
>> > 
>> > [ please Cc: me, I'm not subscribed to linux-mm ]
>> > 
>> > We've been discussing how NFSD can more efficiently refill its
>> > receive buffers (currently alloc_page() in a loop; see
>> > net/sunrpc/svc_xprt.c::svc_alloc_arg()).
>> > 
> 
> It looks like you could also take advantage of bulk free in:
>  svc_free_res_pages()
> 
> I would like to use the page bulk alloc API here:
>  https://github.com/torvalds/linux/blob/master/net/core/page_pool.c#L201-L209
> 
> 
>> > Neil Brown pointed me to this old thread:
>> > 
>> > https://lore.kernel.org/lkml/20170109163518.6001-1-mgorman@techsingularity.net/
>> > 
>> > We see that many of the prerequisites are in v5.11-rc, but
>> > alloc_page_bulk() is not. I tried forward-porting 4/4 in that
>> > series, but enough internal APIs have changed since 2017 that
>> > the patch does not come close to applying and compiling.
> 
> I forgot that this was never merged.  It is sad as Mel showed huge
> improvement with his work.
> 
>> > I'm wondering:
>> > 
>> > a) is there a newer version of that work?
>> > 
> 
> Mel, why was this work never merged upstream?

Hmm the cover letter of that work says:

> The fourth patch introduces a bulk page allocator with no
> in-kernel users as an example for Jesper and others who want to
> build a page allocator for DMA-coherent pages.  It hopefully is
> relatively easy to modify this API and the one core function toget > the
semantics they require.

So it seems there were no immediate users to finalize the API?

>> > b) if not, does there exist a preferred API in 5.11 for bulk
>> > page allocation?
>> > 
>> > Many thanks for any guidance!
> 
> I have a kernel module that micro-bench the API alloc_pages_bulk() here:
>  https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/mm/bench/page_bench04_bulk.c#L97
> 

