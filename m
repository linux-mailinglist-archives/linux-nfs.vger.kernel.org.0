Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B082C3206
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 21:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbgKXUfK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 15:35:10 -0500
Received: from natter.dneg.com ([193.203.89.68]:40152 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731196AbgKXUfI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Nov 2020 15:35:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id 5DBE3229E852;
        Tue, 24 Nov 2020 20:35:07 +0000 (GMT)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id kiKvSMcil7f9; Tue, 24 Nov 2020 20:35:07 +0000 (GMT)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id 383EA229C259;
        Tue, 24 Nov 2020 20:35:07 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 281E4814E188;
        Tue, 24 Nov 2020 20:35:07 +0000 (GMT)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yaUb_Cremsgs; Tue, 24 Nov 2020 20:35:07 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 092F381B5F3E;
        Tue, 24 Nov 2020 20:35:07 +0000 (GMT)
X-Virus-Scanned: amavisd-new at zimbra-dneg
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HDBJAHCC8Cd4; Tue, 24 Nov 2020 20:35:06 +0000 (GMT)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id D5A04814E188;
        Tue, 24 Nov 2020 20:35:06 +0000 (GMT)
Date:   Tue, 24 Nov 2020 20:35:06 +0000 (GMT)
From:   Daire Byrne <daire@dneg.com>
To:     bfields <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
In-Reply-To: <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com> <20200915172140.GA32632@fieldses.org> <4d1d7cd0076d98973a56e89c92e4ff0474aa0e14.camel@hammerspace.com> <1188023047.38703514.1600272094778.JavaMail.zimbra@dneg.com> <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com> <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com> <20201109160256.GB11144@fieldses.org> <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
Subject: Re: Adventures in NFS re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - GC78 (Linux)/8.7.11_GA_1854)
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: 9doLxBH184R2kXPXNb1Z3BB0W3rboMbE7ZOs
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- On 12 Nov, 2020, at 13:01, Daire Byrne daire@dneg.com wrote:
> 
> Having just completed a bunch of fresh cloud rendering with v5.9.1 and Trond's
> NFSv3 lookupp emulation patches, I can now revise my original list of issues
> that others will likely experience if they ever try to do this craziness:
> 
> 1) Don't re-export NFSv4.0 unless you set vfs_cache_presure=0 otherwise you will
> see random input/output errors on your clients when things are dropped out of
> the cache. In the end we gave up on using NFSv4.0 with our Netapps because the
> 7-mode implementation seemed a bit flakey with modern Linux clients (Linux
> NFSv4.2 servers on the other hand have been rock solid). We now use NFSv3 with
> Trond's lookupp emulation patches instead.
> 
> 2) In order to better utilise the re-export server's client cache when
> re-exporting an NFSv3 server (using either NFSv3 or NFSv4), we still need to
> use the horrible inode_peek_iversion_raw hack to maintain good metadata
> performance for large numbers of clients. Otherwise each re-export server's
> clients can cause invalidation of the re-export server client cache. Once you
> have hundreds of clients they all combine to constantly invalidate the cache
> resulting in an order of magnitude slower metadata performance. If you are
> re-exporting an NFSv4.x server (with either NFSv3 or NFSv4.x) this hack is not
> required.
> 
> 3) For some reason, when a 1MB read call arrives at the re-export server from a
> client, it gets chopped up into 128k read calls that are issued back to the
> originating server despite rsize/wsize=1MB on all mounts. This results in a
> noticeable increase in rpc chatter for large reads. Writes on the other hand
> retain their 1MB size from client to re-export server and back to the
> originating server. I am using nconnect but I doubt that is related.
> 
> 4) After some random time, the cachefilesd userspace daemon stops culling old
> data from an fscache disk storage. I thought it was to do with setting
> vfs_cache_pressure=0 but even with it set to the default 100 it just randomly
> decides to stop culling and never comes back to life until restarted or
> rebooted. Perhaps the fscache/cachefilesd rewrite that David Howells & David
> Wysochanski have been working on will improve matters.
> 
> 5) It's still really hard to cache nfs client metadata for any definitive time
> (actimeo,nocto) due to the pagecache churn that reads cause. If all required
> metadata (i.e. directory contents) could either be locally cached to disk or
> the inode cache rather than pagecache then maybe we would have more control
> over the actual cache times we are comfortable with for our workloads. This has
> little to do with re-exporting and is just a general NFS performance over the
> WAN thing. I'm very interested to see how Trond's recent patches to improve
> readdir performance might at least help re-populate the dropped cached metadata
> more efficiently over the WAN.
> 
> I just want to finish with one more crazy thing we have been doing - a re-export
> server of a re-export server! Again, a locking and consistency nightmare so
> only possible for very specific workloads (like ours). The advantage of this
> topology is that you can pull all your data over the WAN once (e.g. on-premise
> to cloud) and then fan-out that data to multiple other NFS re-export servers in
> the cloud to improve the aggregate performance to many clients. This avoids
> having multiple re-export servers all needing to pull the same data across the
> WAN.

I will officially add another point to the wishlist that I mentioned in Bruce's recent patches thread (for dealing with the iversion change on NFS re-export). I had held off mentioning this one because I wasn't really sure if it was just a normal production workload and expected behaviour for NFS, but the more I look into it, the more it seems like maybe it could be optimised for the re-export case. But then I also might be too overly sensitive about metadata ops over the WAN at this point....

6) I see many fast repeating COMMITs & GETATTRs from the NFS re-export server to the originating server for the same file while writing through it from a client. If I do a write from userspace on the re-export server directly to the client mountpoint (i.e. no re-exporting) I do not see the GETATTRs or COMMITs.

I see something similar with both a re-export of a NFSv3 originating server and a re-export of a NFSv4.2 originating server (using either NFSv3 or NFSv4). Bruce mentioned an extra GETATTR in the NFSv4.2 re-export case for a COMMIT (pre/post).

For simplicity let's look at the NFSv3 re-export of an NFSv3 originating server. But first let's write a file from userspace directly on the re-export server back to the originating server mount point (ie no re-export):

    3   0.772902  V3 GETATTR Call, FH: 0x6791bc70
    6   0.781239  V3 SETATTR Call, FH: 0x6791bc70
 3286   0.919601  V3 WRITE Call, FH: 0x6791bc70 Offset: 1048576 Len: 1048576 UNSTABLE [TCP segment of a reassembled PDU]
 3494   0.921351  V3 WRITE Call, FH: 0x6791bc70 Offset: 8388608 Len: 1048576 UNSTABLE [TCP segment of a reassembled PDU]
...
...
48178   1.462670  V3 WRITE Call, FH: 0x6791bc70 Offset: 102760448 Len: 1048576 UNSTABLE
48210   1.472400  V3 COMMIT Call, FH: 0x6791bc70

So lots of uninterrupted 1MB write calls back to the originating server as expected with a final COMMIT (good). We can also set nconnect=16 back to the originating server and get the same trace but with the write packets going down different ports (also good).

Now let's do the same write through the re-export server from a client (NFSv4.2 or NFSv3, it doesn't matter much):

    7   0.034411  V3 SETATTR Call, FH: 0x364ced2c
  286   0.148066  V3 WRITE Call, FH: 0x364ced2c Offset: 0 Len: 1048576 UNSTABLE [TCP segment of a reassembled PDU]
  343   0.152644  V3 WRITE Call, FH: 0x364ced2c Offset: 1048576 Len: 196608 UNSTABLEV3 WRITE Call, FH: 0x364ced2c Offset: 1245184 Len: 8192 FILE_SYNC
  580   0.168159  V3 WRITE Call, FH: 0x364ced2c Offset: 1253376 Len: 843776 UNSTABLE
  671   0.174668  V3 COMMIT Call, FH: 0x364ced2c
 1105   0.193805  V3 COMMIT Call, FH: 0x364ced2c
 1123   0.201570  V3 WRITE Call, FH: 0x364ced2c Offset: 2097152 Len: 1048576 UNSTABLE [TCP segment of a reassembled PDU]
 1592   0.242259  V3 WRITE Call, FH: 0x364ced2c Offset: 3145728 Len: 1048576 UNSTABLE
...
...
54571   3.668028  V3 WRITE Call, FH: 0x364ced2c Offset: 102760448 Len: 1048576 FILE_SYNC [TCP segment of a reassembled PDU]
54940   3.713392  V3 WRITE Call, FH: 0x364ced2c Offset: 103809024 Len: 1048576 UNSTABLE
55706   3.733284  V3 COMMIT Call, FH: 0x364ced2c

So now we have lots of pairs of COMMIT calls inbetween the WRITE calls. We also see sporadic FILE_SYNC write calls which we don't when we just write direct to the originating server from userspace (all UNSTABLE).

Finally, if we add nconnect=16 when mounting the originating server (useful for increasing WAN throughput) and again write through from the client, we start to see lots of GETATTRs mixed with the WRITEs & COMMITs:

   84   0.075830  V3 SETATTR Call, FH: 0x0e9698e8
  608   0.201944  V3 WRITE Call, FH: 0x0e9698e8 Offset: 0 Len: 1048576 UNSTABLE
  857   0.218760  V3 COMMIT Call, FH: 0x0e9698e8
  968   0.231706  V3 WRITE Call, FH: 0x0e9698e8 Offset: 1048576 Len: 1048576 UNSTABLE
 1042   0.246934  V3 COMMIT Call, FH: 0x0e9698e8
...
...
43754   3.033689  V3 WRITE Call, FH: 0x0e9698e8 Offset: 100663296 Len: 1048576 UNSTABLE
44085   3.044767  V3 COMMIT Call, FH: 0x0e9698e8
44086   3.044959  V3 GETATTR Call, FH: 0x0e9698e8
44087   3.044964  V3 GETATTR Call, FH: 0x0e9698e8
44088   3.044983  V3 COMMIT Call, FH: 0x0e9698e8
44615   3.079491  V3 WRITE Call, FH: 0x0e9698e8 Offset: 102760448 Len: 1048576 UNSTABLE
44700   3.082909  V3 WRITE Call, FH: 0x0e9698e8 Offset: 103809024 Len: 1048576 UNSTABLE
44978   3.092010  V3 COMMIT Call, FH: 0x0e9698e8
44982   3.092943  V3 COMMIT Call, FH: 0x0e9698e8

Sometimes I have seen clusters of 16 GETATTRs for the same file on the wire with nothing else inbetween. So if the re-export server is the only "client" writing these files to the originating server, why do we need to do so many repeat GETATTR calls when using nconnect>1? And why are the COMMIT calls required when the writes are coming via nfsd but not from userspace on the re-export server? Is that due to some sort of memory pressure or locking?

I picked the NFSv3 originating server case because my head starts to hurt tracking the equivalent packets, stateids and compound calls with NFSv4. But I think it's mostly the same for NFSv4. The writes through the re-export server lead to lots of COMMITs and (double) GETATTRs but using nconnect>1 at least doesn't seem to make it any worse like it does for NFSv3.

But maybe you actually want all the extra COMMITs to help better guarantee your writes when putting a re-export server in the way? Perhaps all of this is by design...

Daire
