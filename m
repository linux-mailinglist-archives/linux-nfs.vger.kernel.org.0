Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F86242FE5
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Aug 2020 22:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHLULE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Aug 2020 16:11:04 -0400
Received: from busy-byte.org ([176.10.100.20]:18116 "EHLO mail.busy-byte.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgHLULE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Aug 2020 16:11:04 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2020 16:11:03 EDT
Received: from webmail.busy-byte.org (localhost [127.0.0.1])
        by mail.busy-byte.org (Postfix) with ESMTP id BDF5E85A699
        for <linux-nfs@vger.kernel.org>; Wed, 12 Aug 2020 22:05:08 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 Aug 2020 22:05:08 +0200
From:   NFS Traumatized Linux User <nfstrauma@busy-byte.org>
To:     linux-nfs@vger.kernel.org
Subject: CentOS 8 + Kerberized NFS homes / AutoFS -> can't get this to run
 properly, many actions heavily delayed, freq. mouse/kbd freezes -> NFS issue?
Message-ID: <f68660cb18742f7dfdd8a796a610329d@webmail.busy-byte.org>
X-Sender: nfstrauma@busy-byte.org
User-Agent: Roundcube Webmail/1.1.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi there,

sorry for bothering here, but I did not fing anything useful on 
Google... occasianally searching for serveral months.

I'm running a CentOs 8.2.2004 file server on KVM, kernel version 
4.18.0-193.6.3.el8_2. That file server VM is part of a FreeeIPA domain. 
Domain users (=extended family) can log in via SSH: this works very 
reliable.

At home, I have set up some CentOS 8 clients, two for my kids and one 
for myself. I'll focus on my own client for now the kids one's are the 
same/similar. My personal client is a HP z420 with 12 cores and 64GB of 
RAM, so pleanty of resources. Kernel 4.18.0-193.14-2. This machine has a 
1GBit link to the file server.

I registered the client machine in the domain: id <domainuser> works 
just fine: the userid and the associated groups are returned as would be 
expected.

There is no clock skew between the client and the NFS & Kerberos 
servers: I have a Stratum 1 Meinberg NTP appliance providing accurate 
GPS time to the entire network.

I export the home directories on the NFS server to the local network 
(rw,sec=krb5p,root_squash,async,subtree_check) and configured autofs on 
the clients to mount the respective user home directory when a user logs 
into a client:

/etc/auto.master:
/home /etc/auto.home --timeout=600

/etc/auto.home
* -rw,nfs4,nfsvers=4.1,soft fileserver:/home/&

When a user logs into a client, the user automatically gets a 24h 
Kerberos ticket that can be displayed with klist.

Upon login, AutoFS does its thing by mounting the user's home directory 
in the expected location. ID mappiung works as expected: ls -l therefore 
shows usernames/groupnames instead of numeric UIDs/GIDs. Write access to 
the exported FS works: For instance

   touch test
   rm test

in the user's home all just work fine.

BUT starting a normal GNOME session after accepting the login 
credentials takes VERY long (2-3 minutes). Opening a simple GNOME 
terminal takes long (~1 minute), starting Nautilus takes ages (firing it 
up from the terminal until an empty window appear takes ~1 minute, then 
I get a spinning wheel in the lower right corner saying "Loading" for 
another couple of minutes before the home directory contents is 
displayed in the window). Lauching programs in GNOME frequently makes 
the mouse&keyboard freeze for several minutes.

SELinux does not seem to be the culprit: I tried with "setenforce 0" on 
both the server and the client without success.

My feeling is that something with NFS is wrong here, but I don't see 
what it might be. Both, the client and the server run on quite powerful 
hardware, so I would expect sec=krb5p not to be an issue.

I have a few questions:

   * What is the right approach to debug this?
   * Are there any known issues with kerberized NFS and exported home 
directories similar to what I described above?

Any pointers / help would be greatly appreciated.

--
Cheers,
Ray
