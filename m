Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329B32B05C0
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 14:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgKLNCM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 08:02:12 -0500
Received: from natter.dneg.com ([193.203.89.68]:56946 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgKLNCL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Nov 2020 08:02:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id 4CB6E69D097D;
        Thu, 12 Nov 2020 13:02:10 +0000 (GMT)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id HxadmVT4_sQN; Thu, 12 Nov 2020 13:02:10 +0000 (GMT)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id 2C7C069DB6F5;
        Thu, 12 Nov 2020 13:02:10 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 1D46A8102E07;
        Thu, 12 Nov 2020 13:02:10 +0000 (GMT)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mN9mhnrtnpXF; Thu, 12 Nov 2020 13:02:10 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 104E8826D69E;
        Thu, 12 Nov 2020 13:01:52 +0000 (GMT)
X-Virus-Scanned: amavisd-new at zimbra-dneg
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id baDDNzVZDloS; Thu, 12 Nov 2020 13:01:51 +0000 (GMT)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 6FE08826C9D7;
        Thu, 12 Nov 2020 13:01:24 +0000 (GMT)
Date:   Thu, 12 Nov 2020 13:01:24 +0000 (GMT)
From:   Daire Byrne <daire@dneg.com>
To:     bfields <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
In-Reply-To: <20201109160256.GB11144@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com> <20200915172140.GA32632@fieldses.org> <4d1d7cd0076d98973a56e89c92e4ff0474aa0e14.camel@hammerspace.com> <1188023047.38703514.1600272094778.JavaMail.zimbra@dneg.com> <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com> <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com> <20201109160256.GB11144@fieldses.org>
Subject: Re: Adventures in NFS re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - GC78 (Linux)/8.7.11_GA_1854)
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: 9doLxBH184R2kXPXNb1Z3BB0W3rboA==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


----- On 9 Nov, 2020, at 16:02, bfields bfields@fieldses.org wrote:
> On Wed, Oct 21, 2020 at 10:33:52AM +0100, Daire Byrne wrote:
>> Trond has posted some (v3) patches to emulate lookupp for NFSv3 (a million
>> thanks!) so I applied them to v5.9.1 and ran some more tests using that on the
>> re-export server. Again, I just pathologically dropped inode & dentry caches
>> every second on the re-export server (vfs_cache_pressure=100) while a client
>> looped through some application loading tests.
>> 
>> Now for every combination of re-export (NFSv3 -> NFSv4.x or NFSv4.x -> NFSv3), I
>> no longer see any stale file handles (/proc/net/rpc/nfsd) when dropping inode &
>> dentry caches (yay!).
>> 
>> However, my assumption that some of the input/output errors I was seeing were
>> related to the estales seems to have been misguided. After running these tests
>> again without any estales, it now looks like a different issue that is unique
>> to re-exporting NFSv3 from an NFSv4.0 originating server (either Linux or
>> Netapp). The lookups are all fine (no estale) but reading some files eventually
>> gives an input/output error on multiple clients which remain consistent until
>> the re-export nfs-server is restarted. Again, this only occurs while dropping
>> inode + dentry caches.
>> 
>> So in summary, while continuously dropping inode/dentry caches on the re-export
>> server:
> 
> How continuously, exactly?
> 
> I recall that there are some situations where the best the client can do
> to handle an ESTALE is just retry.  And that our code generally just
> retries once and then gives up.
> 
> I wonder if it's possible that the client or re-export server can get
> stuck in a situation where they can't guarantee forward progress in the
> face of repeated ESTALEs.  I don't have a specific case in mind, though.

I was dropping caches every second in a loop on the NFS re-export server. Meanwhile a large python application that takes ~15 seconds to complete was also looping on a client of the re-export server. So we are clearing out the cache many times such that the same python paths are being re-populated many times.

Having just completed a bunch of fresh cloud rendering with v5.9.1 and Trond's NFSv3 lookupp emulation patches, I can now revise my original list of issues that others will likely experience if they ever try to do this craziness:

1) Don't re-export NFSv4.0 unless you set vfs_cache_presure=0 otherwise you will see random input/output errors on your clients when things are dropped out of the cache. In the end we gave up on using NFSv4.0 with our Netapps because the 7-mode implementation seemed a bit flakey with modern Linux clients (Linux NFSv4.2 servers on the other hand have been rock solid). We now use NFSv3 with Trond's lookupp emulation patches instead.

2) In order to better utilise the re-export server's client cache when re-exporting an NFSv3 server (using either NFSv3 or NFSv4), we still need to use the horrible inode_peek_iversion_raw hack to maintain good metadata performance for large numbers of clients. Otherwise each re-export server's clients can cause invalidation of the re-export server client cache. Once you have hundreds of clients they all combine to constantly invalidate the cache resulting in an order of magnitude slower metadata performance. If you are re-exporting an NFSv4.x server (with either NFSv3 or NFSv4.x) this hack is not required.

3) For some reason, when a 1MB read call arrives at the re-export server from a client, it gets chopped up into 128k read calls that are issued back to the originating server despite rsize/wsize=1MB on all mounts. This results in a noticeable increase in rpc chatter for large reads. Writes on the other hand retain their 1MB size from client to re-export server and back to the originating server. I am using nconnect but I doubt that is related.

4) After some random time, the cachefilesd userspace daemon stops culling old data from an fscache disk storage. I thought it was to do with setting vfs_cache_pressure=0 but even with it set to the default 100 it just randomly decides to stop culling and never comes back to life until restarted or rebooted. Perhaps the fscache/cachefilesd rewrite that David Howells & David Wysochanski have been working on will improve matters.

5) It's still really hard to cache nfs client metadata for any definitive time (actimeo,nocto) due to the pagecache churn that reads cause. If all required metadata (i.e. directory contents) could either be locally cached to disk or the inode cache rather than pagecache then maybe we would have more control over the actual cache times we are comfortable with for our workloads. This has little to do with re-exporting and is just a general NFS performance over the WAN thing. I'm very interested to see how Trond's recent patches to improve readdir performance might at least help re-populate the dropped cached metadata more efficiently over the WAN.

I just want to finish with one more crazy thing we have been doing - a re-export server of a re-export server! Again, a locking and consistency nightmare so only possible for very specific workloads (like ours). The advantage of this topology is that you can pull all your data over the WAN once (e.g. on-premise to cloud) and then fan-out that data to multiple other NFS re-export servers in the cloud to improve the aggregate performance to many clients. This avoids having multiple re-export servers all needing to pull the same data across the WAN.

Daire
