Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191AD30B38E
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 00:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhBAX2S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Feb 2021 18:28:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:57734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhBAX2N (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Feb 2021 18:28:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37B0EABD6;
        Mon,  1 Feb 2021 23:27:30 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>
Date:   Tue, 02 Feb 2021 10:27:25 +1100
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: releasing result pages in svc_xprt_release()
In-Reply-To: <700333BB-0928-4772-ADFB-77D92CCE169C@oracle.com>
References: <811BE98B-F196-4EC1-899F-6B62F313640C@oracle.com>
 <87im7ffjp0.fsf@notabene.neil.brown.name>
 <597824E7-3942-4F11-958F-A6E247330A9E@oracle.com>
 <878s88fz6s.fsf@notabene.neil.brown.name>
 <700333BB-0928-4772-ADFB-77D92CCE169C@oracle.com>
Message-ID: <87wnvre5cy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01 2021, Chuck Lever wrote:

>> On Jan 31, 2021, at 6:45 PM, NeilBrown <neilb@suse.de> wrote:
>>=20
>> On Fri, Jan 29 2021, Chuck Lever wrote:
>>>=20
>>> What's your opinion?
>>=20
>> To form a coherent opinion, I would need to know what that problem is.
>> I certainly accept that there could be performance problems in releasing
>> and re-allocating pages which might be resolved by batching, or by copyi=
ng,
>> or by better tracking.  But without knowing what hot-spot you want to
>> cool down, I cannot think about how that fits into the big picture.
>> So: what exactly is the problem that you see?
>
> The problem is that each 1MB NFS READ, for example, hands 257 pages
> back to the page allocator, then allocates another 257 pages. One page
> is not terrible, but 510+ allocator calls for every RPC begins to get
> costly.
>
> Also, remember that both allocating and freeing a page means an irqsave
> spin lock -- that will serialize all other page allocations, including
> allocation done by other nfsd threads.
>
> So I'd like to lower page allocator contention and the rate at which
> IRQs are disabled and enabled when the NFS server becomes busy, as it
> might with several 25 GbE NICs, for instance.
>
> Holding onto the same pages means we can make better use of TLB
> entries -- fewer TLB flushes is always a good thing.
>
> I know that the network folks at Red Hat have been staring hard at
> reducing memory allocation in the stack for several years. I recall
> that Matthew Wilcox recently made similar improvements to the block
> layer.
>
> With the advent of 100GbE and Optane-like durable storage, the balance
> of memory allocation cost to device latency has shifted so that
> superfluous memory allocation is noticeable.
>
>
> At first I thought of creating a page allocator API that could grab
> or free an array of pages while taking the allocator locks once. But
> now I wonder if there are opportunities to reduce the amount of page
> allocator traffic.

Thanks.  This helps me a lot.

I wonder if there is some low-hanging fruit here.

If I read the code correctly (which is not certain, but what I see does
seem to agree with vague memories of how it all works), we currently do
a lot of wasted alloc/frees for zero-copy reads.

We allocate lots of pages and store the pointers in ->rq_respages
(i.e. ->rq_pages)
Then nfsd_splice_actor frees many of those pages and
replaces the pointers with pointers to page-cache pages.  Then we release
those page-cache pages.

We need to have allocated them, but we don't need to free them.
We can add some new array for storing them, have nfsd_splice_actor move
them to that array, and have svc_alloc_arg() move pages back from the
store rather than re-allocating them.

Or maybe something even more sophisticated where we only move them out
of the store when we actually need them.

Having the RDMA layer return pages when they are finished with might
help.  You might even be able to use atomics (cmpxchg) to handle the
contention.  But I'm not convinced it would be worth it.

I *really* like your idea of a batch-API for page-alloc and page-free.
This would likely be useful for other users, and it would be worth
writing more code to get peak performance - things such as per-cpu
queues of returned pages and so-forth (which presumably already exist).

I cannot be sure that the batch-API would be better than a focused API
just for RDMA -> NFSD.  But my guess is that it would be at least nearly
as good, and would likely get a lot more eyes on the code.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmAYjl0OHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmqDg/+In9IsLvTZAsUYhm1umxTifpLOiPov1ubUvs4
ycCRb+HYCNFJCLuKsa0StKPjDKEKWISahtJSp1J0see6zdBspm/T+1R9oQbLT/5y
I3pD88LOx9GkjMiPUzkm7JZsYpSsuNAlvyfShUkykK3l5W/eamiaCtsRwhNWISnP
ZKHwzwH2lQL3cAW9PHg/ZsWWJfmqcR93yTnVOOQKt4hPRUE60vUk5Y5MTTD6COcb
XyaWt9SLHU9X2wCmPeZhqr/7stAdk30X1e9+bJ3++m+UZ1x34fJ/MvjZBZfSLIdt
BeZHHg800hCSY8hHMhMQYaUcwg59rwIggWmc0h0XW7QFhijb0L6i5YCbJsK+odVj
l2eUKp6lcb5t2EYx5NSazJb3Hnq/8fF7igrgOt5GcbVPk5IbPbibpxNtuD3ip9vh
OF7T1dSp47/YNCn/XNTrsTbT8wjkFtRDo7rOhm4SA9aXyM3vkz+uMMCP/YfIfxyi
WpxZMqeGFAywIiP8qde9yX+qfWMdXsrnfcv8+4SS2K7n1aQh+J/uWdj7UGandtad
DFVkGkHHc+EMC6R7ufph0KQ1o7kdEDOl1/LEOnZscXT0M6OI3R14bSOpWRqmykzM
r8vqR5jbKQ3lKrtQrNszKf65ZhUC0j76kt/te6v5wBG9tnVElBBhfBXHecpLm7u9
McsbYyg=
=ovuK
-----END PGP SIGNATURE-----
--=-=-=--
