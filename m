Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D448649BDD0
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 22:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiAYVU5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 16:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiAYVU5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 16:20:57 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D287CC06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 13:20:56 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9A87C70BB; Tue, 25 Jan 2022 16:20:55 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9A87C70BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643145655;
        bh=5bn1D8a/njQZT+IflGFawccQw2z38LzxeBTYPSj2ei4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=quikO2/lzUsKE57H+qAoRYbxNkdaUBkGP+pnDXYUTEJTdEuxwnraJ44Hd+ndrzvRC
         +k2AwOBi5os6yvB4HZfZDYYk4j2LDF2ZJ9mIvFJrHsl1pzOlm+qWZbXQOU0edaocls
         fmnTHVSWZdE6VbCIdXOU5hUZa09jz1KrjMP4hwvc=
Date:   Tue, 25 Jan 2022 16:20:55 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Patrick Goetz <pgoetz@math.utexas.edu>
Cc:     Daire Byrne <daire@dneg.com>, linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: parallel file create rates (+high latency)
Message-ID: <20220125212055.GB17638@fieldses.org>
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org>
 <adce2b72-ed5c-3056-313c-caea9bad4e15@math.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adce2b72-ed5c-3056-313c-caea9bad4e15@math.utexas.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 25, 2022 at 03:15:42PM -0600, Patrick Goetz wrote:
> So the directory is locked while the inode is created, or something
> like this, which makes sense.

It accomplishes a number of things, details in
https://www.kernel.org/doc/html/latest/filesystems/directory-locking.html

> File creation means the directory
> "file" is being updated. Just to be clear, though, from your ssh
> suggestion below, this limitation does not exist if an existing file
> is being updated?

You don't need to take the exclusive i_rwsem lock on the directory to
update an existing file, no.

(But I was only suggesting that creating a bunch of files by ssh'ing
into the server first and doing the create there would be faster,
because the latency of each file create is less when you're running it
directly on the server, as opposed to over a wide-area network
connection.)

--b.

> 
> 
> >
> >So, it's not surprising you'd get a higher rate when creating in
> >multiple directories.
> >
> >Also, that lock's taken on both client and server.  So it makes sense
> >that you might get a little more parallelism from multiple clients.
> >
> >So the usual advice is just to try to get that latency number as low as
> >possible, by using a low-latency network and storage that can commit
> >very quickly.  (An NFS server isn't permitted to reply to the RPC
> >creating the new file until the new file actually hits stable storage.)
> >
> >Are you really seeing 200ms in production?
> >
> >--b.
> >
> >>
> >>If I start 100 processes on the same client creating unique files in a
> >>single shared directory (with 200ms latency), the rate of new file
> >>creates is limited to around 3 files per second. Something like this:
> >>
> >># add latency to the client
> >>sudo tc qdisc replace dev eth0 root netem delay 200ms
> >>
> >>sudo mount -o vers=4.2,nocto,actimeo=3600 server:/data /tmp/data
> >>for x in {1..10000}; do
> >>     echo /tmp/data/dir1/touch.$x
> >>done | xargs -n1 -P 100 -iX -t touch X 2>&1 | pv -l -a > /dev/null
> >>
> >>It's a similar (slow) result for NFSv3. If we run it again just to
> >>update the existing files, it's a lot faster because of the
> >>nocto,actimeo and open file caching (32 files/s).
> >>
> >>Then if I switch it so that each process on the client creates
> >>hundreds of files in a unique directory per process, the aggregate
> >>file create rate increases to 32 per second. For NFSv3 it's 162
> >>aggregate new files per second. So much better parallelism is possible
> >>when the creates are spread across multiple remote directories on the
> >>same client.
> >>
> >>If I then take the slow 3 creates per second example again and instead
> >>use 10 client hosts (all with 200ms latency) and set them all creating
> >>in the same remote server directory, then we get 3 x 10 = 30 creates
> >>per second.
> >>
> >>So we can achieve some parallel file create performance in the same
> >>remote directory but just not from a single client running multiple
> >>processes. Which makes me think it's more of a client limitation
> >>rather than a server locking issue?
> >>
> >>My interest in this (as always) is because while having hundreds of
> >>processes creating files in the same directory might not be a common
> >>workload, it is if you are re-exporting a filesystem and multiple
> >>clients are creating new files for writing. For example a batch job
> >>creating files in a common output directory.
> >>
> >>Re-exporting is a useful way of caching mostly read heavy workloads
> >>but then performance suffers for these metadata heavy or writing
> >>workloads. The parallel performance (nfsd threads) with a single
> >>client mountpoint just can't compete with directly connected clients
> >>to the originating server.
> >>
> >>Does anyone have any idea what the specific bottlenecks are here for
> >>parallel file creates from a single client to a single directory?
> >>
> >>Cheers,
> >>
> >>Daire
