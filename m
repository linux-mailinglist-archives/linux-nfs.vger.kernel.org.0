Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4C3E0B0C
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Aug 2021 02:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhHEAAe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Aug 2021 20:00:34 -0400
Received: from mail.rptsys.com ([23.155.224.45]:43695 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhHEAAe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Aug 2021 20:00:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id DD55A37B2A7AB3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Aug 2021 19:00:20 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sGRSBKbmb8wV for <linux-nfs@vger.kernel.org>;
        Wed,  4 Aug 2021 19:00:20 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 44C1B37B2A7AAF
        for <linux-nfs@vger.kernel.org>; Wed,  4 Aug 2021 19:00:20 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 44C1B37B2A7AAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1628121620; bh=tGovMBm85IvDU8LaObR+eSrzxLVJP8ixpeBBAlWEdJs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=U9daUbUR5aZ9L7vDZ3vp982nnvK4x2iLUwrf8746uGTo98OpV3yMkY7vgm+V+Fr0a
         NeGkLHnfTOBfc/j+/3P0abvUwcqCEoIITpnOqoJaSEF2I5D64av7s8ow7zVPfJXtWA
         bgTE7R57dfTu2NcaL8HAUXlOdiBmx6pJ7gldSSrg=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9Si816jfNJz1 for <linux-nfs@vger.kernel.org>;
        Wed,  4 Aug 2021 19:00:20 -0500 (CDT)
Received: from vali.starlink.edu (vali.starlink.edu [192.168.3.21])
        by mail.rptsys.com (Postfix) with ESMTP id 26FDB37B2A7AAC
        for <linux-nfs@vger.kernel.org>; Wed,  4 Aug 2021 19:00:20 -0500 (CDT)
Date:   Wed, 4 Aug 2021 19:00:20 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <985631970.48634.1628121620017.JavaMail.zimbra@raptorengineeringinc.com>
Subject: Callback slot table overflowed
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC83 (Linux)/8.5.0_GA_3042)
Thread-Index: pWASFVTGcuTitVsqm6vgvEReZrSGHg==
Thread-Topic: Callback slot table overflowed
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

All,

We've hit an odd issue after upgrading a main NFS server from Debian Stretch to Debian Buster.  In both cases the 5.13.4 kernel was used, however after the upgrade none of our ARM thin clients can mount their root filesystems -- early in the boot process I/O errors are returned immediately following "Callback slot table overflowed" in the client dmesg.

I am unable to find any useful information on this "Callback slot table overflowed" message, and have no idea why it is only impacting our ARM (armel) clients.  Both 4.14 and 5.3 on the client side show the issue, other client kernel versions were not tested.

Curiously, increasing the rsize/wsize values to 65536 or higher reduces (but does not eliminate) the number of callback overflow messages.

The server is a ppc64el 64k page host, and none of our pcc64el or amd64 thin clients are experiencing any problems.  Nothing of interest appears in the server message log.

Any troubleshooting hints would be most welcome.

Thank you!
