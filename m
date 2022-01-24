Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52288499269
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 21:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355719AbiAXUTd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 15:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379939AbiAXUPT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 15:15:19 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42980C0617BA
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jan 2022 11:38:02 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 007CF1512; Mon, 24 Jan 2022 14:37:59 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 007CF1512
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643053080;
        bh=6PeLbLfC8f7vy9xDnkSQg2xUZW5ZaFXumpgwRhMTwEI=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=bF4STIosQxCQPJzhoES6Yz7r4Q7rNK0xAkXHUlmnHktK0RdF//8y8scSmoLrR9NQx
         Ak01Mr9gfLQmlH9yWYBT5BB4Y9zJ/YN7YJHdgUAAACh+l46gW7QJLZpxo+ULkKry03
         H7ub9VgaRvIduSrlZMgv0Uv+EbeDZhA9EZlSCzxE=
Date:   Mon, 24 Jan 2022 14:37:59 -0500
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: parallel file create rates (+high latency)
Message-ID: <20220124193759.GA4975@fieldses.org>
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jan 23, 2022 at 11:53:08PM +0000, Daire Byrne wrote:
> I've been experimenting a bit more with high latency NFSv4.2 (200ms).
> I've noticed a difference between the file creation rates when you
> have parallel processes running against a single client mount creating
> files in multiple directories compared to in one shared directory.

The Linux VFS requires an exclusive lock on the directory while you're
creating a file.

So, if L is the time in seconds required to create a single file, you're
never going to be able to create more than 1/L files per second, because
there's no parallelism.

So, it's not surprising you'd get a higher rate when creating in
multiple directories.

Also, that lock's taken on both client and server.  So it makes sense
that you might get a little more parallelism from multiple clients.

So the usual advice is just to try to get that latency number as low as
possible, by using a low-latency network and storage that can commit
very quickly.  (An NFS server isn't permitted to reply to the RPC
creating the new file until the new file actually hits stable storage.)

Are you really seeing 200ms in production?

--b.

> 
> If I start 100 processes on the same client creating unique files in a
> single shared directory (with 200ms latency), the rate of new file
> creates is limited to around 3 files per second. Something like this:
> 
> # add latency to the client
> sudo tc qdisc replace dev eth0 root netem delay 200ms
> 
> sudo mount -o vers=4.2,nocto,actimeo=3600 server:/data /tmp/data
> for x in {1..10000}; do
>     echo /tmp/data/dir1/touch.$x
> done | xargs -n1 -P 100 -iX -t touch X 2>&1 | pv -l -a > /dev/null
> 
> It's a similar (slow) result for NFSv3. If we run it again just to
> update the existing files, it's a lot faster because of the
> nocto,actimeo and open file caching (32 files/s).
> 
> Then if I switch it so that each process on the client creates
> hundreds of files in a unique directory per process, the aggregate
> file create rate increases to 32 per second. For NFSv3 it's 162
> aggregate new files per second. So much better parallelism is possible
> when the creates are spread across multiple remote directories on the
> same client.
> 
> If I then take the slow 3 creates per second example again and instead
> use 10 client hosts (all with 200ms latency) and set them all creating
> in the same remote server directory, then we get 3 x 10 = 30 creates
> per second.
> 
> So we can achieve some parallel file create performance in the same
> remote directory but just not from a single client running multiple
> processes. Which makes me think it's more of a client limitation
> rather than a server locking issue?
> 
> My interest in this (as always) is because while having hundreds of
> processes creating files in the same directory might not be a common
> workload, it is if you are re-exporting a filesystem and multiple
> clients are creating new files for writing. For example a batch job
> creating files in a common output directory.
> 
> Re-exporting is a useful way of caching mostly read heavy workloads
> but then performance suffers for these metadata heavy or writing
> workloads. The parallel performance (nfsd threads) with a single
> client mountpoint just can't compete with directly connected clients
> to the originating server.
> 
> Does anyone have any idea what the specific bottlenecks are here for
> parallel file creates from a single client to a single directory?
> 
> Cheers,
> 
> Daire
