Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12A92B1272
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 00:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgKLXF7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 18:05:59 -0500
Received: from natter.dneg.com ([193.203.89.68]:53064 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgKLXF6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Nov 2020 18:05:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id 9321C6BE8442;
        Thu, 12 Nov 2020 23:05:57 +0000 (GMT)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 7gpH7tHleWOS; Thu, 12 Nov 2020 23:05:57 +0000 (GMT)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id 6FD3F6BE5A30;
        Thu, 12 Nov 2020 23:05:57 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 60AE58264C51;
        Thu, 12 Nov 2020 23:05:57 +0000 (GMT)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zA8MMN2YK7h9; Thu, 12 Nov 2020 23:05:57 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 44B358264C58;
        Thu, 12 Nov 2020 23:05:57 +0000 (GMT)
X-Virus-Scanned: amavisd-new at zimbra-dneg
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JGK68F4eRZEt; Thu, 12 Nov 2020 23:05:57 +0000 (GMT)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 26EF08264C51;
        Thu, 12 Nov 2020 23:05:57 +0000 (GMT)
Date:   Thu, 12 Nov 2020 23:05:57 +0000 (GMT)
From:   Daire Byrne <daire@dneg.com>
To:     bfields <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <883314904.86570901.1605222357023.JavaMail.zimbra@dneg.com>
In-Reply-To: <20201112205524.GI9243@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com> <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com> <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com> <20201109160256.GB11144@fieldses.org> <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com> <20201112135733.GA9243@fieldses.org> <444227972.86442677.1605206025305.JavaMail.zimbra@dneg.com> <20201112205524.GI9243@fieldses.org>
Subject: Re: Adventures in NFS re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - GC78 (Linux)/8.7.11_GA_1854)
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: PdekKxbQPoF2p68YCT8h7p3DQKp8cA==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


----- On 12 Nov, 2020, at 20:55, bfields bfields@fieldses.org wrote:
> On Thu, Nov 12, 2020 at 06:33:45PM +0000, Daire Byrne wrote:
>> There was some discussion about NFS4_CHANGE_TYPE_IS_MONOTONIC_INCR
>> allowing for the hack/optimisation but I guess that is only for the
>> case when re-exporting NFSv4 to the eventual clients. It would not
>> help if you were re-exporting an NFSv3 server with NFSv3 to the
>> clients? I lack the deeper understanding to say anything more than
>> that.
> 
> Oh, right, thanks for the reminder.  The CHANGE_TYPE_IS_MONOTONIC_INCR
> optimization still looks doable to me.
> 
> How does that help, anyway?  I guess it avoids false positives of some
> kind when rpc's are processed out of order?
> 
> Looking back at
> 
>	https://lore.kernel.org/linux-nfs/1155061727.42788071.1600777874179.JavaMail.zimbra@dneg.com/
> 
> this bothers me: "I'm not exactly sure why, but the iversion of the
> inode gets changed locally (due to atime modification?) most likely via
> invocation of method inode_inc_iversion_raw. Each time it gets
> incremented the following call to validate attributes detects changes
> causing it to be reloaded from the originating server."
> 
> The only call to that function outside afs or ceph code is in
> fs/nfs/write.c, in the write delegation case.  The Linux server doesn't
> support write delegations, Netapp does but this shouldn't be causing
> cache invalidations.

So, I can't lay claim to identifying the exact optimisation/hack that improves the retention of the re-export server's client cache when re-exporting an NFSv3 server (which is then read by many clients). We were working with an engineer at the time who showed an interest in our use case and after we supplied a reproducer he suggested modifying the nfs/inode.c

-		if (!inode_eq_iversion_raw(inode, fattr->change_attr)) {
+		if (inode_peek_iversion_raw(inode) < fattr->change_attr) {

His reasoning at the time was:

"Fixes inode invalidation caused by read access. The least
 important bit is ORed with 1 and causes the inode version to differ from the
 one seen on the NFS share. This in turn causes unnecessary re-download
 impacting the performance significantly. This fix makes it only re-fetch file
 content if inode version seen on the server is newer than the one on the
 client."

But I've always been puzzled by why this only seems to be the case when using knfsd to re-export the (NFSv3) client mount. Using multiple processes on a standard client mount never causes any similar re-validations. And this happens with a completely read-only share which is why I started to think it has something to do with atimes as that could perhaps still cause a "write" modification even when read-only?

In our case we saw this at it's most extreme when we were re-exporting a read-only NFSv3 Netapp "software" share and loading large applications with many python search paths to trawl through. Multiple clients of the re-export server just kept causing the re-export server's client to re-validate and re-download from the Netapp even though no files or dirs had changed and the actimeo=large (with nocto for good measure).

The patch made it such that the re-export server's client cache acted the same way if we ran 100 processes directly on the NFSv3 client mount (on the re-export server) or ran it on 100 clients of the re-export server - the data remained in client cache for the duration. So the re-export server fetches the data from the originating server once and then serves all those results many times over to all the clients from it's cache - exactly what we want.

Daire
