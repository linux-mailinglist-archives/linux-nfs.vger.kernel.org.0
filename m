Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C9E211255
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 20:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgGASGD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 14:06:03 -0400
Received: from smtp-o-3.desy.de ([131.169.56.156]:51679 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730227AbgGASGD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Jul 2020 14:06:03 -0400
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-3.desy.de (Postfix) with ESMTP id 7BBA860494
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jul 2020 20:06:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 7BBA860494
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1593626760; bh=xmUKrZZsB+dFGspyh5ApvqZfuVDEiMxN2Xa5SgAKHuQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=tk+bBJwovLpzsFu7j26h2QzFng/RYUXNeUbqgwrcW9rUAx7b6EWAXPyR74XyqhC6+
         BYYM8xhs3VmMYtJmktFMJtHJTuNJP4EYVO5m9UFtsSmwj6a/xV2W5T2jXPC6epdrt2
         oqwi3KhEeCRcQoMr6X6Vtn3624ErrmiHXJSOmLAs=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [131.169.56.131])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 768F7A00C3;
        Wed,  1 Jul 2020 20:06:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id 53373C00AE;
        Wed,  1 Jul 2020 20:06:00 +0200 (CEST)
Date:   Wed, 1 Jul 2020 20:06:00 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Pradeep <pradeep.thomas@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1203996558.728752.1593626760216.JavaMail.zimbra@desy.de>
In-Reply-To: <CAD8zhTBCEbOkA_jFzzDXcd0jiH9ZgUh1KUJAJzhnWFMC+JGjNA@mail.gmail.com>
References: <CAD8zhTBCEbOkA_jFzzDXcd0jiH9ZgUh1KUJAJzhnWFMC+JGjNA@mail.gmail.com>
Subject: Re: File create performance between NFSv3 and NFSv4.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3895)
Thread-Topic: File create performance between NFSv3 and NFSv4.
Thread-Index: UvZRXuozbCa5XDrASGCzVpiv+PpeZg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Hi Pradeep,

When you talk performance always specify which version
client and server you use, as older kernels might have
issues and newer kernels might hare regressions.

There are couple of reasons why you can observe it. First of all,
NFS v3 is state less, thus less operations sent over the wire.
The NFS v4.1 is more efficient than v4.0.

Running your test as: ./smallfile_cli.py  --operation create --threads 24 --file-size 0 --files 1024 --top /mnt/test

I get:

v4.0: 2530
v4.1: 13191 
v3  : 14728

This is with 5.6.16-300 client, but a non linux server.


Second, if you use NFSv4.1 you should check that client have
enough session slots configured to process requests in parallel.
You can check/set the value on the client as:

cat /sys/module/nfs/parameters/max_session_slots
echo 128 > /sys/module/nfs/parameters/max_session_slots

IFAIK, server has hard coded max value of 160.


Regards,
   Tigran.

----- Original Message -----
> From: "Pradeep" <pradeep.thomas@gmail.com>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Wednesday, July 1, 2020 2:55:15 AM
> Subject: File create performance between NFSv3 and NFSv4.

> Hello,
> 
> While testing a performance issue, I noticed that the number of
> creates that an NFS client can do over NFSv4 is significantly lower
> compared to NFSv3. I'm using the test below:
> 
> https://github.com/distributed-system-analysis/smallfile
> 
> Command run:
> smallfile_cli.py  --operation create --threads 128 --file-size 1
> --files 1024 --top <nfs-dir>
> [ 128 threads, each doing 1024 file creates of 1K size]
> 
> This gives around 1169 creates/sec with NFSv4.1 and 8073 creates/sec
> with NFSv3. This is with the exact same client and server. NFS server
> is tuned to use 200 threads.
> 
> When I looked at tcpdump, I noticed that over NFSv3 multiple parallel
> requests are being sent and NFSv4 is pretty much serial. Is there
> anything that I can tune to improve NFSv4 performance w.r.t to file
> creations?
> 
> This also shows up in benchmarks like SpecFS SWBUILD's INIT phase
> where millions of files are getting created.
> 
> Thanks,
> Pradeep
