Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E966645B1
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2019 13:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfGJLUw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Jul 2019 07:20:52 -0400
Received: from smtp-o-2.desy.de ([131.169.56.155]:51796 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJLUw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 10 Jul 2019 07:20:52 -0400
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-2.desy.de (Postfix) with ESMTP id 2C5361608ED
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2019 13:20:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 2C5361608ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1562757650; bh=t4feWG50La/zeR/aO+pQ2pQ6kyErloQ2Pafx5IuybUY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pjHaIXeFoFHUS8eK52B6N+f0Sx4WIFIJ2R/h4Fu/AFarH7o17uSpVKSieqaTN8DcX
         0rKCKb7Ip2fjW13xuQdjKvg36sA67+7d2hE4lt16f8ofE7oJveBmpRtvLKq1xq64p4
         6kIvCgPwWQiyICphoU3Dmwi+5cm5KZVUhd97ZYas=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [131.169.56.131])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 27C2FA0040;
        Wed, 10 Jul 2019 13:20:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id EE62AC003B;
        Wed, 10 Jul 2019 13:20:49 +0200 (CEST)
Date:   Wed, 10 Jul 2019 13:20:49 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     John Dorminy <jdorminy@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <676688269.16845251.1562757649858.JavaMail.zimbra@desy.de>
In-Reply-To: <CAMeeMh9xmfwo9gY_h_9DMQeobzjXOMnC9iH=Whz=UkJeUSVq6w@mail.gmail.com>
References: <CAMeeMh9xmfwo9gY_h_9DMQeobzjXOMnC9iH=Whz=UkJeUSVq6w@mail.gmail.com>
Subject: Re: Request for help debugging readdirplus malfunction on NFS v3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF67 (Linux)/8.8.10_GA_3786)
Thread-Topic: Request for help debugging readdirplus malfunction on NFS v3
Thread-Index: qO4xER9Em8npJi12+ReEqiSvozW5Xg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dorminy,

there are fixes form Trond that possibly address your issues. Did you
have tried them?

https://www.spinics.net/lists/linux-nfs/msg73754.html

Regards,
   Tigran.

----- Original Message -----
> From: "John Dorminy" <jdorminy@redhat.com>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Wednesday, July 10, 2019 12:11:46 PM
> Subject: Request for help debugging readdirplus malfunction on NFS v3

> Greetings;
> 
> In the lab for the group I'm in, we have three NFS servers each
> serving different parts of our shared filesystem. However, as of
> kernel 5.1 or so on the clients, the clients have ceased working: a
> 'ls' on any directory within one mountpoint (the only one hosted on
> one server) fails to show any files.
> 
> The mount is:
> nfs-02:/nbu1 on /p/not-backed-up type nfs
> (rw,noatime,vers=3,rsize=65536,wsize=65536,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.19.119.4,mountvers=3,mountport=4048,mountproto=udp,local_lock=none,addr=10.19.119.4)
> 
> Bisection on the client side indicates
> be4c2d4723a4a637f0d1b4f7c66447141a4b3564 is the commit at which this
> mountpoint ceases to work. `rpcdebug -m nfs -s all` results in the
> following going to dmesg:
> [10146.723030] NFS call  readdirplus 162
> [10146.724908] NFS reply readdirplus: -2
> [10146.725429] NFS: readdir(/) returns -2
> 
> I'm somewhat out of ideas; are there other tools I should be using to
> hunt this down, short of adding print statements? and is this a known
> bug already?
> 
> Thanks in advance!
> 
> John Dorminy
