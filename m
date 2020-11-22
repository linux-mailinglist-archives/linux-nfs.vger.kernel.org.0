Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F77E2BC311
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Nov 2020 02:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgKVBzy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Sat, 21 Nov 2020 20:55:54 -0500
Received: from natter.dneg.com ([193.203.89.68]:55118 "EHLO natter.dneg.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbgKVBzy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 21 Nov 2020 20:55:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by natter.dneg.com (Postfix) with ESMTP id 2F05B139CA27;
        Sun, 22 Nov 2020 01:55:52 +0000 (GMT)
X-Virus-Scanned: amavisd-new at mx-dneg
Received: from natter.dneg.com ([127.0.0.1])
        by localhost (natter.dneg.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id T1ZL0CZIe0M5; Sun, 22 Nov 2020 01:55:52 +0000 (GMT)
Received: from zrozimbrai.dneg.com (zrozimbrai.dneg.com [10.11.20.12])
        by natter.dneg.com (Postfix) with ESMTPS id 1115D139AE13;
        Sun, 22 Nov 2020 01:55:52 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 00FF98157437;
        Sun, 22 Nov 2020 01:55:52 +0000 (GMT)
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xdYNyvzCm7tI; Sun, 22 Nov 2020 01:55:51 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id D8252815743A;
        Sun, 22 Nov 2020 01:55:51 +0000 (GMT)
X-Virus-Scanned: amavisd-new at zimbra-dneg
Received: from zrozimbrai.dneg.com ([127.0.0.1])
        by localhost (zrozimbrai.dneg.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z9y5VpeJQ9xI; Sun, 22 Nov 2020 01:55:51 +0000 (GMT)
Received: from zrozimbra1.dneg.com (zrozimbra1.dneg.com [10.11.16.16])
        by zrozimbrai.dneg.com (Postfix) with ESMTP id 9666B8157437;
        Sun, 22 Nov 2020 01:55:51 +0000 (GMT)
Date:   Sun, 22 Nov 2020 01:55:50 +0000 (GMT)
From:   Daire Byrne <daire@dneg.com>
To:     bfields <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1480128642.91427046.1606010150674.JavaMail.zimbra@dneg.com>
In-Reply-To: <20201122000216.GE3476@fieldses.org>
References: <20201117031601.GB10526@fieldses.org> <20201117152636.GC4556@fieldses.org> <725499c144317aac1a03f0334a22005588dbdefc.camel@kernel.org> <20201120223831.GB7705@fieldses.org> <20201120224438.GC7705@fieldses.org> <5f8e9e0cb53c89a7d1c156a6799c6dbc6db96dae.camel@kernel.org> <1758069641.91412432.1605995069116.JavaMail.zimbra@dneg.com> <20201122000216.GE3476@fieldses.org>
Subject: Re: [PATCH 2/4] nfsd: pre/post attr is using wrong change attribute
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - GC78 (Linux)/8.7.11_GA_1854)
Thread-Topic: nfsd: pre/post attr is using wrong change attribute
Thread-Index: tRxeNdT08Q5kqHGP2s+VopzNe3y5pA==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


----- On 22 Nov, 2020, at 00:02, bfields bfields@fieldses.org wrote:
>> I should also mention that I still see a lot of unexpected repeat
>> lookups even with the iversion optimisation patches with certain
>> workloads. For example, looking at a network capture on the re-export
>> server I might see 100s of getattr calls to the originating server for
>> the same filehandle within 30 seconds which I would have expected the
>> client cache to serve. But it could also be that the client cache is
>> under memory pressure and not holding that data for very long.
> 
> That sounds weird.  Is the filehandle for a file or a directory?  Is the
> file or directory actually changing at the time, and if so, is it the
> client that's changing it?
> 
> Remind me what the setup is--a v3 re-export of a v4 mount?

Maybe this discussion should go back into the "Advenvetures in re-exporting" thread? But to give a quick answer here anyway...

The workload I have been looking at recently is a NFSv3 re-export of a NFSv4.2 mount. I can also say that it is generally when new files are being written to a directory. So yes, the files and dir are changing at the time but I still didn't expect to see so many repeated getattr neatly bundled together in short bursts, e.g. (re-export server = 10.156.12.1, originating server 10.21.22.117).

54544  88.147927  10.156.12.1 → 10.21.22.117 NFS 326 V4 Call SETATTR FH: 0x4dbdfb01
54547  88.160469  10.156.12.1 → 10.21.22.117 NFS 350 V4 Call SETATTR FH: 0x4dbdfb01
54556  88.185592  10.156.12.1 → 10.21.22.117 NFS 330 V4 Call SETATTR FH: 0x4dbdfb01
54559  88.198350  10.156.12.1 → 10.21.22.117 NFS 350 V4 Call SETATTR FH: 0x4dbdfb01
54562  88.211670  10.156.12.1 → 10.21.22.117 NFS 326 V4 Call SETATTR FH: 0x4dbdfb01
54565  88.243251  10.156.12.1 → 10.21.22.117 NFS 350 V4 Call OPEN DH: 0x4dbdfb01/
54637  88.269587  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
55078  88.277138  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call COMMIT FH: 0x4dbdfb01 Offset: 0 Len: 0
57747  88.390197  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
57748  88.390212  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
57749  88.390215  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
57750  88.390218  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
57751  88.390220  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
57752  88.390222  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
57753  88.390231  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
57754  88.390261  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call COMMIT FH: 0x4dbdfb01 Offset: 0 Len: 0
57755  88.390292  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
57852  88.415541  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call COMMIT FH: 0x4dbdfb01 Offset: 0 Len: 0
57853  88.415551  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
58965  88.442004  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
60201  88.486231  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
60615  88.505453  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
60616  88.505473  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
60617  88.505477  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
60618  88.505480  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0x4dbdfb01
60619  88.505482  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call COMMIT FH: 0x4dbdfb01 Offset: 0 Len: 0

Often I only capture an open dh followed by a flurry of getattr:

 3068  24.603153  10.156.12.1 → 10.21.22.117 NFS 350 V4 Call OPEN DH: 0xb63a98ec/
 3089  24.641542  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 3093  24.642172  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 3140  24.719930  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 3360  24.769423  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 3376  24.771353  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 3436  24.782817  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 3569  24.798207  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 3753  24.855233  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 3777  24.856130  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 3824  24.862919  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 3873  24.873890  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 4001  24.898289  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 4070  24.925970  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 4127  24.940616  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 4174  24.985160  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 4343  25.007565  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 4344  25.008343  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec
 4358  25.036177  10.156.12.1 → 10.21.22.117 NFS 282 V4 Call GETATTR FH: 0xb63a98ec

The common workload is that we will have multiple clients of the re-export server all writing different (frame) files into the same directory at the same time. But on the re-export server it is ultimately 16 threads of nfsd making those calls to the originating server.

The re-export server's client should be the only one making most of the changes, although there are other NFSv3 clients of the originating servers that could conceivably be updating files too.

Like I said, it might be interesting to see if we see the same behaviour with a NFSv3 re-export of an NFSv3 server.

Daire
