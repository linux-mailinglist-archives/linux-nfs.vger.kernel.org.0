Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF5B2B50EE
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Nov 2020 20:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgKPTVx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Nov 2020 14:21:53 -0500
Received: from natter.dneg.com ([193.203.89.68]:46042 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgKPTVx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 16 Nov 2020 14:21:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id 8B5537E12CF8;
        Mon, 16 Nov 2020 19:21:51 +0000 (GMT)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id sLdL-rdGJHSw; Mon, 16 Nov 2020 19:21:51 +0000 (GMT)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id 6FD6E7E12CE7;
        Mon, 16 Nov 2020 19:21:51 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 60D158150D4F;
        Mon, 16 Nov 2020 19:21:51 +0000 (GMT)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Qn-EqBm74RJx; Mon, 16 Nov 2020 19:21:51 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 469B88150D5F;
        Mon, 16 Nov 2020 19:21:51 +0000 (GMT)
X-Virus-Scanned: amavisd-new at zimbra-dneg
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X_ohQm0wFXkB; Mon, 16 Nov 2020 19:21:51 +0000 (GMT)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id EF4F2814E1B7;
        Mon, 16 Nov 2020 19:21:47 +0000 (GMT)
Date:   Mon, 16 Nov 2020 19:21:47 +0000 (GMT)
From:   Daire Byrne <daire@dneg.com>
To:     bfields <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1688437957.87985749.1605554507783.JavaMail.zimbra@dneg.com>
In-Reply-To: <20201116155329.GE898@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com> <444227972.86442677.1605206025305.JavaMail.zimbra@dneg.com> <20201112205524.GI9243@fieldses.org> <883314904.86570901.1605222357023.JavaMail.zimbra@dneg.com> <20201113145050.GB1299@fieldses.org> <20201113222600.GC1299@fieldses.org> <217712894.87456370.1605358643862.JavaMail.zimbra@dneg.com> <20201116155329.GE898@fieldses.org>
Subject: Re: Adventures in NFS re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - GC78 (Linux)/8.7.11_GA_1854)
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: 8LqwOtJALJh7qY93Jll76WzyFc0fTw==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


----- On 16 Nov, 2020, at 15:53, bfields bfields@fieldses.org wrote:
> On Sat, Nov 14, 2020 at 12:57:24PM +0000, Daire Byrne wrote:
>> Now if anyone has any ideas why all the read calls to the originating
>> server are limited to a maximum of 128k (with rsize=1M) when coming
>> via the re-export server's nfsd threads, I see that as the next
>> biggest performance issue. Reading directly on the re-export server
>> with a userspace process issues 1MB reads as expected. It doesn't
>> happen for writes (wsize=1MB all the way through) but I'm not sure if
>> that has more to do with async and write back caching helping to build
>> up the size before commit?
> 
> I'm not sure where to start with this one....
> 
> Is this behavior independent of protocol version and backend server?

It seems to the case for all combinations of backend versions and re-export versions.

But it does look like it is related to readahead somehow. The default for a client mount is 128k ....

I just increased it to 1024 on the client mount of the originating server on the re-export server and now it's doing the expected 1MB (rsize) read requests back to onprem from the clients all the way through. i.e.

echo 1024 > /sys/class/bdi/0:52/read_ahead_kb

So, there is a difference in behaviour when reading from the client mount with user space processes or the knfsd threads on the re-export server.

Daire


