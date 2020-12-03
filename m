Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0372CD564
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 13:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgLCMVS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 07:21:18 -0500
Received: from natter.dneg.com ([193.203.89.68]:53374 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgLCMVR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Dec 2020 07:21:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id EF967866BA85;
        Thu,  3 Dec 2020 12:20:35 +0000 (GMT)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 885gxeYjaaLv; Thu,  3 Dec 2020 12:20:35 +0000 (GMT)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id C5CD88400B11;
        Thu,  3 Dec 2020 12:20:35 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id B6710813EE05;
        Thu,  3 Dec 2020 12:20:35 +0000 (GMT)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nTypsDlxzc6F; Thu,  3 Dec 2020 12:20:35 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 8F4EC813EE2B;
        Thu,  3 Dec 2020 12:20:35 +0000 (GMT)
X-Virus-Scanned: amavisd-new at zimbra-dneg
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wmNepQXAIpL4; Thu,  3 Dec 2020 12:20:35 +0000 (GMT)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 77175813EE0E;
        Thu,  3 Dec 2020 12:20:35 +0000 (GMT)
Date:   Thu, 3 Dec 2020 12:20:35 +0000 (GMT)
From:   Daire Byrne <daire@dneg.com>
To:     bfields <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
In-Reply-To: <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com> <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com> <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com> <20201109160256.GB11144@fieldses.org> <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com> <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com> <20201124211522.GC7173@fieldses.org> <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
Subject: Re: Adventures in NFS re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - GC78 (Linux)/8.7.11_GA_1854)
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: jRr/eG2N4Ts+gxyP7atxT3VAnkSniXilDtDp
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


----- On 25 Nov, 2020, at 17:14, Daire Byrne daire@dneg.com wrote:
> First off, writing direct to the originating server mount on the re-export
> server from userspace shows the ideal behaviour for all combinations:
> 
> originating server <- (vers=X,actimeo=1800,nconnect=X) <- reexport server
> writing = WRITE,WRITE .... repeating (good!)
> 
> Then re-exporting a NFSv4.2 server:
> 
> originating server <- (vers=4.2) <- reexport server - (vers=3) <- client writing
> = GETATTR,COMMIT,WRITE .... repeating
> originating server <- (vers=4.2) <- reexport server - (vers=4.2) <- client
> writing = GETATTR,WRITE .... repeating
> 
> And re-exporting a NFSv3 server:
> 
> originating server <- (vers=3) <- reexport server - (vers=4.2) <- client writing
> = WRITE,WRITE .... repeating (good!)
> originating server <- (vers=3) <- reexport server - (vers=3) <- client writing =
> WRITE,COMMIT .... repeating
>  
> So of all the combinations, a NFSv4.2 re-export of an NFSv3 server is the only
> one that matches the "ideal" case where we WRITE continuously without all the
> extra chatter.
> 
> And for completeness, taking that "good" case and making it bad with nconnect:
> 
> originating server <- (vers=3,nconnect=16) <- reexport server - (vers=4.2) <-
> client writing = WRITE,WRITE .... repeating (good!)
> originating server <- (vers=3) <- reexport server <- (vers=4.2,nconnect=16) <-
> client writing = WRITE,COMMIT,GETATTR .... randomly repeating
> 
> So using nconnect on the re-export's client causes lots more metadata ops. There
> are reasons for doing that for increasing throughput but it could be that the
> gain is offset by the extra metadata roundtrips.
> 
> Similarly, we have mostly been using a NFSv4.2 re-export of a NFSV4.2 server
> over the WAN because of reduced metadata ops for reading, but it looks like we
> incur extra metadata ops for writing.

Just a small update based on the most recent patchsets from Trond & Bruce:

https://patchwork.kernel.org/project/linux-nfs/list/?series=393567
https://patchwork.kernel.org/project/linux-nfs/list/?series=393561

For the write-through tests, the NFSv3 re-export of a NFSv4.2 server has trimmed an extra GETATTR:

Before:
originating server <- (vers=4.2) <- reexport server - (vers=3) <- client writing = WRITE,COMMIT,GETATTR .... repeating
 
After:
originating server <- (vers=4.2) <- reexport server - (vers=3) <- client writing = WRITE,COMMIT .... repeating

I'm assuming this is specifically due to the "EXPORT_OP_NOWCC" patch? All other combinations look the same as before (for write-through). An NFSv4.2 re-export of a NFSv3 server is still the best/ideal in terms of not incurring extra metadata roundtrips when writing.

It's great to see this re-export scenario becoming a better supported (and performing) topology; many thanks all.

Daire
