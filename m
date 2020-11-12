Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714A22B0CB1
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 19:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgKLSdr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 13:33:47 -0500
Received: from natter.dneg.com ([193.203.89.68]:33140 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgKLSdr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Nov 2020 13:33:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id D58DE6B6E303;
        Thu, 12 Nov 2020 18:33:45 +0000 (GMT)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ki2VSpan4u8R; Thu, 12 Nov 2020 18:33:45 +0000 (GMT)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id B3A106B3B65B;
        Thu, 12 Nov 2020 18:33:45 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id A35868156A16;
        Thu, 12 Nov 2020 18:33:45 +0000 (GMT)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xChTnRKdZWYi; Thu, 12 Nov 2020 18:33:45 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 848FB8154F70;
        Thu, 12 Nov 2020 18:33:45 +0000 (GMT)
X-Virus-Scanned: amavisd-new at zimbra-dneg
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aw3arRsvUCfv; Thu, 12 Nov 2020 18:33:45 +0000 (GMT)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 6A9888156A16;
        Thu, 12 Nov 2020 18:33:45 +0000 (GMT)
Date:   Thu, 12 Nov 2020 18:33:45 +0000 (GMT)
From:   Daire Byrne <daire@dneg.com>
To:     bfields <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <444227972.86442677.1605206025305.JavaMail.zimbra@dneg.com>
In-Reply-To: <20201112135733.GA9243@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com> <4d1d7cd0076d98973a56e89c92e4ff0474aa0e14.camel@hammerspace.com> <1188023047.38703514.1600272094778.JavaMail.zimbra@dneg.com> <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com> <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com> <20201109160256.GB11144@fieldses.org> <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com> <20201112135733.GA9243@fieldses.org>
Subject: Re: Adventures in NFS re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - GC78 (Linux)/8.7.11_GA_1854)
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: Tx3z7h88VbP/wqegmXaDTPRSGXosjg==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


----- On 12 Nov, 2020, at 13:57, bfields bfields@fieldses.org wrote:
> On Thu, Nov 12, 2020 at 01:01:24PM +0000, Daire Byrne wrote:
>> 
>> Having just completed a bunch of fresh cloud rendering with v5.9.1 and Trond's
>> NFSv3 lookupp emulation patches, I can now revise my original list of issues
>> that others will likely experience if they ever try to do this craziness:
>> 
>> 1) Don't re-export NFSv4.0 unless you set vfs_cache_presure=0 otherwise you will
>> see random input/output errors on your clients when things are dropped out of
>> the cache. In the end we gave up on using NFSv4.0 with our Netapps because the
>> 7-mode implementation seemed a bit flakey with modern Linux clients (Linux
>> NFSv4.2 servers on the other hand have been rock solid). We now use NFSv3 with
>> Trond's lookupp emulation patches instead.
> 
> So,
> 
>		NFSv4.2			  NFSv4.2
>	client --------> re-export server -------> original server
> 
> works as long as both servers are recent Linux, but when the original
> server is Netapp, you need the protocol used in both places to be v3, is
> that right?

Well, yes NFSv4.2 all the way through works well for us but it's re-exporting a NFSv4.0 server (Linux OR Netapp) that seems to still show the input/output errors when dropping caches. Every other possible combination now seems to be working without ESTALE or input/errors with the lookupp emulation patches.

So this is still not working when dropping caches on the re-export server:

		NFSv3/4.x			  NFSv4.0
	client --------> re-export server -------> original server

The bit specific to the Netapp is simply that our 7-mode only supports NFSv4.0 so I can't actually test NFSv4.1/4.2 on a more modern Netapp firmware release. So I have to use NFSv3 to mount the Netapp and can then happily re-export that using NFSv4.x or NFSv3 (if the filehandles fit in 63 bytes).

>> 2) In order to better utilise the re-export server's client cache when
>> re-exporting an NFSv3 server (using either NFSv3 or NFSv4), we still need to
>> use the horrible inode_peek_iversion_raw hack to maintain good metadata
>> performance for large numbers of clients. Otherwise each re-export server's
>> clients can cause invalidation of the re-export server client cache. Once you
>> have hundreds of clients they all combine to constantly invalidate the cache
>> resulting in an order of magnitude slower metadata performance. If you are
>> re-exporting an NFSv4.x server (with either NFSv3 or NFSv4.x) this hack is not
>> required.
> 
> Have we figured out why that's required, or found a longer-term
> solution?  (Apologies, the memory of the earlier conversation is
> fading....)

There was some discussion about NFS4_CHANGE_TYPE_IS_MONOTONIC_INCR allowing for the hack/optimisation but I guess that is only for the case when re-exporting NFSv4 to the eventual clients. It would not help if you were re-exporting an NFSv3 server with NFSv3 to the clients? I lack the deeper understanding to say anything more than that.

In our case we re-export everything to the clients using NFSv4.2 whether the originating server is NFSv3 (e.g our Netapp) or NFSv4.2 (our RHEL7 storage servers).

With NFSv4.2 as the originating server, we found that either this hack/optimsation was not required or the incidence rate of invalidating the re-export server's client cache was much less as to not cause significant performance problems when many clients requested the same metadata.

Daire
