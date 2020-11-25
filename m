Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092102C4685
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 18:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgKYROy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Nov 2020 12:14:54 -0500
Received: from natter.dneg.com ([193.203.89.68]:40520 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730196AbgKYROx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 25 Nov 2020 12:14:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id 1F49A39616D;
        Wed, 25 Nov 2020 17:14:52 +0000 (GMT)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id KOu2BXi-Eo2H; Wed, 25 Nov 2020 17:14:52 +0000 (GMT)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id F3F8A39616B;
        Wed, 25 Nov 2020 17:14:51 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id E0D688237816;
        Wed, 25 Nov 2020 17:14:51 +0000 (GMT)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kWBnEEtUyp-l; Wed, 25 Nov 2020 17:14:51 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id C1074826D259;
        Wed, 25 Nov 2020 17:14:51 +0000 (GMT)
X-Virus-Scanned: amavisd-new at zimbra-dneg
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J1MMs1WOxq3A; Wed, 25 Nov 2020 17:14:51 +0000 (GMT)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id A144C8237816;
        Wed, 25 Nov 2020 17:14:51 +0000 (GMT)
Date:   Wed, 25 Nov 2020 17:14:51 +0000 (GMT)
From:   Daire Byrne <daire@dneg.com>
To:     bfields <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
In-Reply-To: <20201124211522.GC7173@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com> <1188023047.38703514.1600272094778.JavaMail.zimbra@dneg.com> <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com> <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com> <20201109160256.GB11144@fieldses.org> <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com> <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com> <20201124211522.GC7173@fieldses.org>
Subject: Re: Adventures in NFS re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - GC78 (Linux)/8.7.11_GA_1854)
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: jRr/eG2N4Ts+gxyP7atxT3VAnkSniQ==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


----- On 24 Nov, 2020, at 21:15, bfields bfields@fieldses.org wrote:
> On Tue, Nov 24, 2020 at 08:35:06PM +0000, Daire Byrne wrote:
>> Sometimes I have seen clusters of 16 GETATTRs for the same file on the
>> wire with nothing else inbetween. So if the re-export server is the
>> only "client" writing these files to the originating server, why do we
>> need to do so many repeat GETATTR calls when using nconnect>1? And why
>> are the COMMIT calls required when the writes are coming via nfsd but
>> not from userspace on the re-export server? Is that due to some sort
>> of memory pressure or locking?
>> 
>> I picked the NFSv3 originating server case because my head starts to
>> hurt tracking the equivalent packets, stateids and compound calls with
>> NFSv4. But I think it's mostly the same for NFSv4. The writes through
>> the re-export server lead to lots of COMMITs and (double) GETATTRs but
>> using nconnect>1 at least doesn't seem to make it any worse like it
>> does for NFSv3.
>> 
>> But maybe you actually want all the extra COMMITs to help better
>> guarantee your writes when putting a re-export server in the way?
>> Perhaps all of this is by design...
> 
> Maybe that's close-to-open combined with the server's tendency to
> open/close on every IO operation?  (Though the file cache should have
> helped with that, I thought; as would using version >=4.0 on the final
> client.)
> 
> Might be interesting to know whether the nocto mount option makes a
> difference.  (So, add "nocto" to the mount options for the NFS mount
> that you're re-exporting on the re-export server.)

The nocto didn't really seem to help but the NFSv4.2 re-export of a NFSv3 server did. I also realised I had done some tests with nconnect on the re-export server's client and consequently mixed things up a bit in my head. So I did some more tests and tried to make the results clear and simple. In all cases I'm just writing a big file with "dd" and capturing the traffic between the originating server and re-export server.

First off, writing direct to the originating server mount on the re-export server from userspace shows the ideal behaviour for all combinations:

 originating server <- (vers=X,actimeo=1800,nconnect=X) <- reexport server writing = WRITE,WRITE .... repeating (good!)

Then re-exporting a NFSv4.2 server:

 originating server <- (vers=4.2) <- reexport server - (vers=3) <- client writing = GETATTR,COMMIT,WRITE .... repeating
 originating server <- (vers=4.2) <- reexport server - (vers=4.2) <- client writing = GETATTR,WRITE .... repeating

And re-exporting a NFSv3 server:

 originating server <- (vers=3) <- reexport server - (vers=4.2) <- client writing = WRITE,WRITE .... repeating (good!)
 originating server <- (vers=3) <- reexport server - (vers=3) <- client writing = WRITE,COMMIT .... repeating
  
So of all the combinations, a NFSv4.2 re-export of an NFSv3 server is the only one that matches the "ideal" case where we WRITE continuously without all the extra chatter.

And for completeness, taking that "good" case and making it bad with nconnect:

 originating server <- (vers=3,nconnect=16) <- reexport server - (vers=4.2) <- client writing = WRITE,WRITE .... repeating (good!)
 originating server <- (vers=3) <- reexport server <- (vers=4.2,nconnect=16) <- client writing = WRITE,COMMIT,GETATTR .... randomly repeating

So using nconnect on the re-export's client causes lots more metadata ops. There are reasons for doing that for increasing throughput but it could be that the gain is offset by the extra metadata roundtrips. 

Similarly, we have mostly been using a NFSv4.2 re-export of a NFSV4.2 server over the WAN because of reduced metadata ops for reading, but it looks like we incur extra metadata ops for writing.

Side note: it's hard to decode nconnect enabled packet captures because wireshark doesn't seem to like those extra port streams.

> By the way I made a start at a list of issues at
> 
>	http://wiki.linux-nfs.org/wiki/index.php/NFS_re-export
> 
> but I was a little vague on which of your issues remained and didn't
> take much time over it.

Cool. I'm glad there are some notes for others to reference - this thread is now too long for any human to read. The only things I'd consider adding are:

* re-export of NFSv4.0 filesystem can give input/output errors when the cache is dropped
* a weird interaction with nfs client readahead such that all reads are limited to the default 128k unless you manually increase it to match rsize.

The only other thing I can offer are tips & tricks for doing this kind of thing over the WAN (vfs_cache_pressure, actimeo, nocto) and using fscache.

Daire
