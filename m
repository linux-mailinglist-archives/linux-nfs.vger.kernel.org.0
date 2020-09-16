Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3846F26C6A7
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Sep 2020 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgIPR6D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 13:58:03 -0400
Received: from natter.dneg.com ([193.203.89.68]:33970 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbgIPR4v (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Sep 2020 13:56:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id 14B408AEBDE9;
        Wed, 16 Sep 2020 17:01:42 +0100 (BST)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id MQHIICdJ1qzS; Wed, 16 Sep 2020 17:01:41 +0100 (BST)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id E59358AF1F5D;
        Wed, 16 Sep 2020 17:01:41 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 4EA7D81616F8;
        Wed, 16 Sep 2020 17:01:41 +0100 (BST)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4WWRnfYzjTyB; Wed, 16 Sep 2020 17:01:41 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 4C746815DD52;
        Wed, 16 Sep 2020 17:01:40 +0100 (BST)
X-Virus-Scanned: amavisd-new at zimbra-dneg
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id paTUqDKLOU8A; Wed, 16 Sep 2020 17:01:40 +0100 (BST)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 745858157E66;
        Wed, 16 Sep 2020 17:01:34 +0100 (BST)
Date:   Wed, 16 Sep 2020 17:01:34 +0100 (BST)
From:   Daire Byrne <daire@dneg.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     bfields@fieldses.org, linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1188023047.38703514.1600272094778.JavaMail.zimbra@dneg.com>
In-Reply-To: <4d1d7cd0076d98973a56e89c92e4ff0474aa0e14.camel@hammerspace.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com> <20200915172140.GA32632@fieldses.org> <4d1d7cd0076d98973a56e89c92e4ff0474aa0e14.camel@hammerspace.com>
Subject: Re: Adventures in NFS re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - GC78 (Linux)/8.7.11_GA_1854)
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: fNDm/l4o9cYx5Rz5g0S1EO4zMAtIR4tJDJwAAAWCe4BeKhpLVA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond/Bruce,

----- On 15 Sep, 2020, at 20:59, Trond Myklebust trondmy@hammerspace.com wrote:

> On Tue, 2020-09-15 at 13:21 -0400, J. Bruce Fields wrote:
>> On Mon, Sep 07, 2020 at 06:31:00PM +0100, Daire Byrne wrote:
>> > 1) The kernel can drop entries out of the NFS client inode cache
>> > (under memory cache churn) when those filehandles are still being
>> > used by the knfsd's remote clients resulting in sporadic and random
>> > stale filehandles. This seems to be mostly for directories from
>> > what I've seen. Does the NFS client not know that knfsd is still
>> > using those files/dirs? The workaround is to never drop inode &
>> > dentry caches on the re-export servers (vfs_cache_pressure=1). This
>> > also helps to ensure that we actually make the most of our
>> > actimeo=3600,nocto mount options for the full specified time.
>> 
>> I thought reexport worked by embedding the original server's
>> filehandles
>> in the filehandles given out by the reexporting server.
>> 
>> So, even if nothing's cached, when the reexporting server gets a
>> filehandle, it should be able to extract the original filehandle from
>> it
>> and use that.
>> 
>> I wonder why that's not working?
> 
> NFSv3? If so, I suspect it is because we never wrote a lookupp()
> callback for it.

So in terms of the ESTALE counter on the reexport server, we see it increase if the end client mounts the reexport using either NFSv3 or NFSv4. But there is a difference in the client experience in that with NFSv3 we quickly get input/output errors but with NFSv4 we don't. But it does seem like the performance drops significantly which makes me think that NFSv4 retries the lookups (which succeed) when an ESTALE is reported but NFSv3 does not?

This is the simplest reproducer I could come up with but it may still be specific to our workloads/applications and hard to replicate exactly.

nfs-client # sudo mount -t nfs -o vers=3,actimeo=5,ro reexport-server:/vol/software /mnt/software
nfs-client # while true; do /mnt/software/bin/application; echo 3 | sudo tee /proc/sys/vm/drop_caches; done

reexport-server # sysctl -w vm.vfs_cache_pressure=100
reexport-server # while true; do echo 3 > /proc/sys/vm/drop_caches ; done
reexport-server # while true; do awk '/fh/ {print $2}' /proc/net/rpc/nfsd; sleep 10; done

Where "application" is some big application with lots of paths to scan with libs to memory map and "/vol/software" is an NFS mount on the reexport-server from another originating NFS server. I don't know why this application loading workload shows this best, but perhaps the access patterns of memory mapped binaries and libs is particularly susceptible to estale?

With vfs_cache_pressure=100, running "echo 3 > /proc/sys/vm/drop_caches" repeatedly on the reexport server drops chunks of the dentry & nfs_inode_cache. The ESTALE count increases and the client running the application reports input/output errors with NFSv3 or the loading slows to a crawl with NFSv4.

As soon as we switch to vfs_cache_pressure=0, the repeating drop_caches on the reexport server do not cull the dentry or nfs_inode_cache, the ESTALE counter no longer increases and the client experiences no issues (NFSv3 & NFSv4).

>> > 4) With an NFSv4 re-export, lots of open/close requests (hundreds
>> > per
>> > second) quickly eat up the CPU on the re-export server and perf top
>> > shows we are mostly in native_queued_spin_lock_slowpath.
>> 
>> Any statistics on who's calling that function?

I have not managed to devise a good reproducer for this as I suspect it requires large numbers of clients. So, I will have to use some production load to replicate it and it will take me a day or two to get something back to you.

Would something from a perf report be of particular interest (e.g. the call graph) or even a /proc/X/stack of a high CPU nfsd thread?

I do recall that nfsd_file_lru_cb and __list_lru_walk_one were usually right below native_queued_spin_lock_slowpath as the next most busy functions in perf top (with NFSv4 exporting). Perhaps this is less of an NFS reexport phenomenon and would be the case for any NFSv4 export of a particularly "slow" underlying filesystem?

>> > Does NFSv4
>> > also need an open file cache like that added to NFSv3? Our
>> > workaround
>> > is to either fix the thing doing lots of repeated open/closes or
>> > use
>> > NFSv3 instead.
>> 
>> NFSv4 uses the same file cache.  It might be the file cache that's at
>> fault, in fact....

Ah, my misunderstanding. I had assumed the open file descriptor cache was of more benefit to NFSv3 and that NFSv4 did not necessarily require it for performance.

I might also be able to do a test with a kernel version from before when that feature landed to see if NFSv4 reexport performs any different. 

Cheers,

Daire
