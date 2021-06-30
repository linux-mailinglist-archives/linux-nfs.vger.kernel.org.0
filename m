Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771553B8687
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 17:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbhF3P4E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 11:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbhF3P4E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 11:56:04 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769EDC061756
        for <linux-nfs@vger.kernel.org>; Wed, 30 Jun 2021 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2jHs7Ru5+EkYrkp1jqvwT3xN5zCHuV6MKRoPuRur57w=; b=BbbhvwbkeoB6nWX2iXhtHDpRd
        pU5EB+iktYIujGGTieFZ05ywbx1GLT8D5C5WYT3cuV4+gKZsl90vHzfZr7T/09Dv0cq33AeDD17Jd
        Z1iDeLeIlYuRXJz4aq9CTTq123gcuM7Bzu6ETZYsR6RkZigBajyH6VOrX2R6St4t8TbiWghWgaAQj
        ImlA9XqcWvM0pCe6xb+yoPR1b8Lexe1xu+gAehNcCgpppmwVngLG2Ibl2gZEoNit2eNzraK3ip/fB
        MkBv1abrVWOeY/Fg8Q/AfbQdhmp+NPfNgpAFcwNKIgZezSVl6++sMM32+86UkqBfo4Uh4K0LfYmEk
        /KVoqffqw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45522)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lycWl-0000Nj-QW; Wed, 30 Jun 2021 16:53:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lycWk-0003DK-5K; Wed, 30 Jun 2021 16:53:26 +0100
Date:   Wed, 30 Jun 2021 16:53:26 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: 5.13 NFSD: completely broken?
Message-ID: <20210630155325.GD22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I've just upgraded my ARM32 VMs to 5.13, and I'm seeing some really odd
behaviour with NFS exports that are mounted on a debian stable x86
machine.  Here's an example packet dump:

16:39:55.172494 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6:c8:5054:ff:fe00:341.2049: Flags [P.], seq 1027945732:1027945880, ack 3477555770, win 506, options [nop,nop,TS val 3337720655 ecr 372042622], length 148: NFS request xid 822450515 144 getattr fh Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
16:39:55.172904 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6:c8:5054:ff:fe00:341.2049: Flags [P.], seq 148:296, ack 1, win 506, options [nop,nop,TS val 3337720656 ecr 372042622], length 148: NFS request xid 856004947 144 getattr fh
Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
16:39:55.173365 52:54:00:00:00:11 > 00:22:68:15:37:dd, ethertype IPv6 (0x86dd), length 86: fd8f:7570:feb6:c8:5054:ff:fe00:341.2049 > fd8f:7570:feb6:1:222:68ff:fe15:37dd.932: Flags [.], ack 148, win 449, options [nop,nop,TS val 372047356 ecr 3337720655], length 0

16:39:55.173383 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6:c8:5054:ff:fe00:341.2049: Flags [P.], seq 296:444, ack 1, win 506, options [nop,nop,TS val 3337720656 ecr 372042622], length 148: NFS request xid 872782163 144 getattr fh Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
16:39:55.173474 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6:c8:5054:ff:fe00:341.2049: Flags [P.], seq 444:592, ack 1, win 506, options [nop,nop,TS val 3337720656 ecr 372047356], length 148: NFS request xid 889559379 144 getattr fh Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
16:39:55.173649 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6:c8:5054:ff:fe00:341.2049: Flags [P.], seq 592:740, ack 1, win 506, options [nop,nop,TS val 3337720656 ecr 372047356], length 148: NFS request xid 839227731 144 getattr fh Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
16:39:55.173708 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x86dd), length 382: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6:c8:5054:ff:fe00:341.2049: Flags [P.], seq 740:1036, ack 1, win 506, options [nop,nop,TS val 3337720656 ecr 372047356], length 296: NFS request xid 805673299 144 getattr fh Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
16:39:55.173830 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6:c8:5054:ff:fe00:341.2049: Flags [P.], seq 1036:1184, ack 1, win 506, options [nop,nop,TS val 3337720657 ecr 372047356], length 148: NFS request xid 788896083 144 getattr fh Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
16:39:55.173921 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6:c8:5054:ff:fe00:341.2049: Flags [P.], seq 1184:1332, ack 1, win 506, options [nop,nop,TS val 3337720657 ecr 372047356], length 148: NFS request xid 755341651 144 getattr fh Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
16:39:55.196354 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6:c8:5054:ff:fe00:341.2049: Flags [P.], seq 1184:1332, ack 1, win 506, options [nop,nop,TS val 3337720679 ecr 372047356], length 148: NFS request xid 755341651 144 getattr fh Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
16:39:55.214728 52:54:00:00:00:11 > 00:22:68:15:37:dd, ethertype IPv6 (0x86dd), length 98: fd8f:7570:feb6:c8:5054:ff:fe00:341.2049 > fd8f:7570:feb6:1:222:68ff:fe15:37dd.932: Flags [.], ack 1332, win 440, options [nop,nop,TS val 372047398 ecr 3337720656,nop,nop,sack 1 {1184:1332}], length 0
16:40:25.892493 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x86dd), length 246: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6:c8:5054:ff:fe00:341.2049: Flags [P.], seq 1332:1492, ack 1, win 506, options [nop,nop,TS val 3337751375 ecr 372047398], length 160: NFS request xid 671455571 156 access fh Unknown/010006012246F4529A1C41AD9C321B1BF54BA2DD01000200D0F60B4E NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS_ACCESS_DELETE
16:40:25.893365 52:54:00:00:00:11 > 00:22:68:15:37:dd, ethertype IPv6 (0x86dd), length 86: fd8f:7570:feb6:c8:5054:ff:fe00:341.2049 > fd8f:7570:feb6:1:222:68ff:fe15:37dd.932: Flags [.], ack 1492, win 439, options [nop,nop,TS val 372078076 ecr 3337751375], length 0

As can be seen, the TCP packets are being acked by the remote host, so the
TCP connection is alive and intact. However, the NFS server itself is
ignoring the requests. On the server, the nfsd processes are all sitting
idle:

...
root      1155  0.0  2.7  32208 27820 ?        Ss   15:43   0:00 /usr/sbin/rpc.mountd --manage-gids
root      1165  0.0  0.0      0     0 ?        S    15:43   0:00 [lockd]
root      1173  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
root      1174  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
root      1175  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
root      1176  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
root      1177  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
root      1178  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
root      1179  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
root      1180  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
statd     1195  0.0  5.1  57012 52528 ?        Ss   15:43   0:00 /sbin/rpc.statd

So it looks like they're basically ignoring everything.

The mount options on the client are:
(rw,relatime,vers=3,rsize=131072,wsize=131072,namlen=255,hard,proto=tcp6,timeo=600,retrans=2,sec=sys,mountaddr=fd8f:7570:feb6:c8:5054:ff:fe00:341,mountvers=3,mountport=42927,mountproto=udp6,local_lock=none,addr=fd8f:7570:feb6:c8:5054:ff:fe00:341)

Has 5.13 been tested with nfsv3 ?

Any ideas what's going on?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
