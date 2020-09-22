Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E14274216
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 14:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIVMbT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 08:31:19 -0400
Received: from natter.dneg.com ([193.203.89.68]:33150 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgIVMbT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 22 Sep 2020 08:31:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id 148635E6ABF9;
        Tue, 22 Sep 2020 13:31:16 +0100 (BST)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 6LO8-9Iu2dk2; Tue, 22 Sep 2020 13:31:15 +0100 (BST)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id E22455E6A50C;
        Tue, 22 Sep 2020 13:31:15 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id CE969814BA89;
        Tue, 22 Sep 2020 13:31:12 +0100 (BST)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wwkA6G5Y0ZBX; Tue, 22 Sep 2020 13:31:12 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 5C830814BA9D;
        Tue, 22 Sep 2020 13:31:12 +0100 (BST)
X-Virus-Scanned: amavisd-new at zimbra-dneg
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x8peC81ZtDnG; Tue, 22 Sep 2020 13:31:12 +0100 (BST)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 4BE35814C2CB;
        Tue, 22 Sep 2020 13:31:11 +0100 (BST)
Date:   Tue, 22 Sep 2020 13:31:14 +0100 (BST)
From:   Daire Byrne <daire@dneg.com>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Cc:     linux-cachefs <linux-cachefs@redhat.com>
Message-ID: <1155061727.42788071.1600777874179.JavaMail.zimbra@dneg.com>
In-Reply-To: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
Subject: Re: Adventures in NFS re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - GC78 (Linux)/8.7.11_GA_1854)
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: fNDm/l4o9cYx5Rz5g0S1EO4zMAtIR1/IOmk+
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi, 

I just thought I'd flesh out the other two issues I have found with re-exporting that are ultimately responsible for the biggest performance bottlenecks. And both of them revolve around the caching of metadata file lookups in the NFS client.

Especially for the case where we are re-exporting a server many milliseconds away (i.e. on-premise -> cloud), we want to be able to control how much the client caches metadata and file data so that it's many LAN clients all benefit from the re-export server only having to do the WAN lookups once (within a specified coherency time).

Keeping the file data in the vfs page cache or on disk using fscache/cachefiles is fairly straightforward, but keeping the metadata cached is particularly difficult. And without the cached metadata we introduce long delays before we can serve the already present and locally cached file data to many waiting clients.

----- On 7 Sep, 2020, at 18:31, Daire Byrne daire@dneg.com wrote:
> 2) If we cache metadata on the re-export server using actimeo=3600,nocto we can
> cut the network packets back to the origin server to zero for repeated lookups.
> However, if a client of the re-export server walks paths and memory maps those
> files (i.e. loading an application), the re-export server starts issuing
> unexpected calls back to the origin server again, ignoring/invalidating the
> re-export server's NFS client cache. We worked around this this by patching an
> inode/iversion validity check in inode.c so that the NFS client cache on the
> re-export server is used. I'm not sure about the correctness of this patch but
> it works for our corner case.

If we use actimeo=3600,nocto (say) to mount a remote software volume on the re-export server, we can successfully cache the loading of applications and walking of paths directly on the re-export server such that after a couple of runs, there are practically zero packets back to the originating NFS server (great!). But, if we then do the same thing on a client which is mounting that re-export server, the re-export server now starts issuing lots of calls back to the originating server and invalidating it's client cache (bad!).

I'm not exactly sure why, but the iversion of the inode gets changed locally (due to atime modification?) most likely via invocation of method inode_inc_iversion_raw. Each time it gets incremented the following call to validate attributes detects changes causing it to be reloaded from the originating server.

This patch helps to avoid this when applied to the re-export server but there may be other places where this happens too. I accept that this patch is probably not the right/general way to do this, but it helps to highlight the issue when re-exporting and it works well for our use case:

--- linux-5.5.0-1.el7.x86_64/fs/nfs/inode.c     2020-01-27 00:23:03.000000000 +0000
+++ new/fs/nfs/inode.c  2020-02-13 16:32:09.013055074 +0000
@@ -1869,7 +1869,7 @@
 
        /* More cache consistency checks */
        if (fattr->valid & NFS_ATTR_FATTR_CHANGE) {
-               if (!inode_eq_iversion_raw(inode, fattr->change_attr)) {
+               if (inode_peek_iversion_raw(inode) < fattr->change_attr) {
                        /* Could it be a race with writeback? */
                        if (!(have_writers || have_delegation)) {
                                invalid |= NFS_INO_INVALID_DATA

With this patch, the re-export server's NFS client attribute cache is maintained and used by all the clients that then mount it. When many hundreds of clients are all doing similar things at the same time, the re-export server's NFS client cache is invaluable in accelerating the lookups (getattrs).

Perhaps a more correct approach would be to detect when it is knfsd that is accessing the client mount and change the cache consistency checks accordingly?

> 3) If we saturate an NFS client's network with reads from the server, all client
> metadata lookups become unbearably slow even if it's all cached in the NFS
> client's memory and no network RPCs should be required. This is the case for
> any NFS client regardless of re-exporting but it affects this case more because
> when we can't serve cached metadata we also can't serve the cached data. It
> feels like some sort of bottleneck in the client's ability to parallelise
> requests? We work around this by not maxing out our network.

I spent a bit more time testing this issue and it's not quite as I've written it. Again the issue is that we have very little control over preserving complete metadata caches to avoid expensive contact with the originating NFS server. Even though we can use actimeo,nocto mount options, these provide no guarantees that we can keep all the required metadata in cache when the page cache is under constant churn (e.g. NFS reads).

This has very little to do with the re-export of an NFS client mount and is more a general observation of how the NFS client works. It is probably relevant to anyone who wants to cache metadata for long periods of time (e.g. read-only, non-changing, over the WAN).

Let's consider how we might try to keep as much metadata cached in memory....

nfsclient # echo 0 >/proc/sys/vm/vfs_cache_pressure
nfsclient # mount -o vers=3,actimeo=7200,nocto,ro,nolock nfsserver:/usr /mnt/nfsserver
nfsclient # for x in {1..3}; do /usr/bin/time -f %e ls -hlR /mnt/nfsserver/share > /dev/null; sleep 5; done
53.23 <- first time so lots of network traffic
2.82 <- now cached for actimeo=7200 with almost no packets between nfsserver & nfsclient
2.85

This is ideal and as long as we don't touch the page cache then repeated walks of the remote server will all come from cache until the attribute cache times out.

We can even read from the remote server using either directio or fadvise so that we don't upset the client's page cache and we will keep the complete metadata cache intact. e.g.

nfsclient # find /mnt/nfsserver -type f -size +1M -print | shuf | xargs -n1 -P8 -iX bash -c 'dd if="X" iflag=direct of=/dev/null bs=1M &>/dev/null'
nfsclient # find /mnt/nfsserver -type f -size +1M -print | shuf | xargs -n1 -P8 -iX bash -c 'nocache dd if="X" of=/dev/null bs=1M &>/dev/null'
nfsclient # /usr/bin/time -f %e ls -hlR /mnt/nfsserver/share > /dev/null
2.82 <- still showing good complete cached metadata

But as soon as we switch to the more normal reading of file data which then populates the page cache, we lose portions of our cached metadata (readdir?) even when there is plenty of RAM available.

nfsclient # find /mnt/nfsserver -type f -size +1M -print | shuf | xargs -n1 -P8 -iX bash -c 'dd if="X" of=/dev/null bs=1M &>/dev/null'
nfsclient # /usr/bin/time -f %e ls -hlR /mnt/nfsserver/share > /dev/null
10.82 <- still mostly cached metadata but we had to do some fresh lookups

Now once our NFS client starts doing lots of sustained reads such that it maxes out the network, we end up in a situation where we are both dropping useful cached metadata (before actimeo) and we are making it harder to get the new metadata lookups back in a timely fashion because the reads are so much more dominant (and require less round trips to get more done).

So if we do the reads and try to do the filesystem walk at the same time, we get even slower performance:

nfsclient # (find /mnt/nfsserver -type f -size +1M -print | shuf | xargs -n1 -P8 -iX bash -c 'dd if="X" of=/dev/null bs=1M &>/dev/null') &
nfsclient # /usr/bin/time -f %e ls -hlR /mnt/nfsserver/share > /dev/null
30.12

As we increase the number of simultaneous threads for the reads (e.g knfsd threads), the single thread of metadata lookups gets slower and slower.

So even when setting vfs_cache_pressure=0 (to keep nfs inodes in memory), setting actimeo=large and using nocto to avoid more lookups, we still can't keep a complete metadata cache in memory for any specified time when the server is doing lots of reads and churning through the page cache.

So, while I am not able to provide many answers or solutions to any of the issues I have highlighted in this email thread, hopefully I have described in enough detail all the main performance hurdles others will likely run into if they attempt this in production as we have.

And like I said from the outset, it's already stable enough for us to use in production and it's definitely better than nothing... ;)

Regards,

Daire
