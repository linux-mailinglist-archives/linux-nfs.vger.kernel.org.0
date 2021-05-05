Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0AC373BBE
	for <lists+linux-nfs@lfdr.de>; Wed,  5 May 2021 14:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhEEMyp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 May 2021 08:54:45 -0400
Received: from natter.dneg.com ([193.203.89.68]:48026 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232096AbhEEMyp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 May 2021 08:54:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id 6285E69BE8D4;
        Wed,  5 May 2021 13:53:47 +0100 (BST)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 4-Mb-AWc5PNP; Wed,  5 May 2021 13:53:47 +0100 (BST)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id 3F45369BE8A8;
        Wed,  5 May 2021 13:53:47 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 2A51981B6553;
        Wed,  5 May 2021 13:53:47 +0100 (BST)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FrnSPM67V2YN; Wed,  5 May 2021 13:53:47 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 01F5B81B655B;
        Wed,  5 May 2021 13:53:47 +0100 (BST)
X-Virus-Scanned: amavisd-new at zrozimbrai.dneg.com
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S4RnFVbwWAFW; Wed,  5 May 2021 13:53:46 +0100 (BST)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id CE97C81B6553;
        Wed,  5 May 2021 13:53:46 +0100 (BST)
Date:   Wed, 5 May 2021 13:53:46 +0100 (BST)
From:   Daire Byrne <daire@dneg.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     bfields <bfields@fieldses.org>, fsorenso <fsorenso@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>, aglo <aglo@umich.edu>,
        neilb <neilb@suse.de>, bcodding <bcodding@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        jshivers <jshivers@redhat.com>
Message-ID: <1454713846.12225482.1620219226547.JavaMail.zimbra@dneg.com>
In-Reply-To: <5bd2516e41f7a6b35ea9772a56a7dfdec52b83a9.camel@hammerspace.com>
References: <20201007140502.GC23452@fieldses.org> <20210120150737.GA17548@fieldses.org> <20210503200952.GB18779@fieldses.org> <162009412979.28954.17703105649506010394@noble.neil.brown.name> <4033e1e8b52c27503abe5855f81b7d12b2e46eec.camel@hammerspace.com> <20210504165120.GA18746@fieldses.org> <1449034832.11389942.1620163955863.JavaMail.zimbra@dneg.com> <5bd2516e41f7a6b35ea9772a56a7dfdec52b83a9.camel@hammerspace.com>
Subject: Re: unsharing tcp connections from different NFS mounts
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_3990 (ZimbraWebClient - GC78 (Linux)/9.0.0_GA_3990)
Thread-Topic: unsharing tcp connections from different NFS mounts
Thread-Index: AQHXQS0DWZUx7XJl40Wa7JAyuJnZ3KrT3CAA2EP82N0=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond,

----- On 4 May, 2021, at 22:48, Trond Myklebust trondmy@hammerspace.com wrote:
>> I'd really love to see any kind of improvement to this behaviour as
>> it's a real shame we can't serve cached data quickly when all the
>> cache re-validations (getattrs) are stuck behind bulk IO that just
>> seems to plow through everything else.
> 
> If you use statx() instead of the regular stat call, and you
> specifically don't request the ctime and mtime, then the current kernel
> should skip the writeback.
> 
> Otherwise, you're going to have to wait for the NFSv4.2 protocol
> changes that we're trying to push through the IETF to allow the client
> to be authoritative for the ctime/mtime when it holds a write
> delegation.

In my case, it's less about skipping avoidable getattrs if we have the files open and delegated for read/write or are still within the attribute cache timeout, and it has nothing to do with the re-export specific cache optimisations that went into v5.11 (which really helped us out!).

It's more the fact that we can read a terabyte of data (say) into the client's pagecache or (more likely) fscache/cachefiles, but obviously can't use it again days later (say) until some validation getattrs are sent and replied to. If that mountpoint also happens to be very busy with reads or writes at the time, then all that locally cached data sits idle until we can squeeze through the necessary lookups. This is especially painful if you are also using NFS over the WAN.

When I did some basic benchmarking, metadata ops from one process could be x100 slower when the pipe is full of reads or writes from other processes on the same client. Actually, another detail I just read in my previous notes - the more parallel client processes you have reading data, the slower your metadata ops will get replied to.

So if you have 1 process filling the client's network pipe with reads and another walking the filesystem, the walk will be ~x5 slower than if the pipe wasn't full of reads. If you have 20 processes simultaneously reading and again are filling the client's network pipe with reads, then the filesystem walking process is x100 slower. In both cases, the physical network is being maxed out, but the metadata intensive filesystem walking process is getting even less and less opportunity to have it's requests answered.

And this is exactly the scenario we see with our NFS re-export case, where lots of knfsd threads are doing reads from a mountpoint while others are just trying to have lookup requests answered so they can then serve the locally cached data (it helps that our remote files never get overwritten or updated).

So, similar to the original behaviour described in this thread, we also find that even when one client's NFSv4.2 mount is eating up all the network bandwidth and metadata ops are slowed to a crawl, another independent server (or multi-homed with same filesystem) mounted on the same client still shows very good (barely degraded) metadata performance. Presumably due to the independent slot table (which is good news if you are using a single server to re-export multiple servers).

I think for us, some kind of priority for these small metadata ops would be ideal (assuming you can get enough of them into the slot queue in the first place). I'm not sure a slot limit per client process would help that much? I also wonder if readahead (or async writes) could be gobbling up too many available slots leaving little for the sequential metadata intensive processes?

Daire
