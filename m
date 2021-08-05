Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21A03E0B0F
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Aug 2021 02:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhHEAEb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Aug 2021 20:04:31 -0400
Received: from mail.rptsys.com ([23.155.224.45]:27245 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhHEAEb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Aug 2021 20:04:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id C0D5137B2A7AFA
        for <linux-nfs@vger.kernel.org>; Wed,  4 Aug 2021 19:04:17 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uaqiag-U_SUI for <linux-nfs@vger.kernel.org>;
        Wed,  4 Aug 2021 19:04:16 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 3F47037B2A7AF6
        for <linux-nfs@vger.kernel.org>; Wed,  4 Aug 2021 19:04:16 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 3F47037B2A7AF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1628121856; bh=mTcmHV4HCbf5nFg8GpbOGPhqRUg+mbbK6mzQ8C0h6mg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=inmYCdCf50WwHBXH5oU7j3SLCGybu+bG5/0EYlXnmcPfsXdu2bW7kqoncc2W42bZJ
         bhsB1FlDkyPisQ4S/Koy8d9DysKgu99PBb/pQZhLIzDUxDjS2s+BSO7rV7JmEyeFo8
         lU68o4WjLyOicp9znqzcBp/bc4TF+mrLrIydWplE=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xnsqnshjfY7V for <linux-nfs@vger.kernel.org>;
        Wed,  4 Aug 2021 19:04:16 -0500 (CDT)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id 14D3A37B2A7AF3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Aug 2021 19:04:16 -0500 (CDT)
Date:   Wed, 4 Aug 2021 19:04:16 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1851673341.49012.1628121856011.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <985631970.48634.1628121620017.JavaMail.zimbra@raptorengineeringinc.com>
References: <985631970.48634.1628121620017.JavaMail.zimbra@raptorengineeringinc.com>
Subject: Re: Callback slot table overflowed
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC83 (Linux)/8.5.0_GA_3042)
Thread-Topic: Callback slot table overflowed
Thread-Index: pWASFVTGcuTitVsqm6vgvEReZrSGHqraViLp
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Other information that may be helpful:

All clients are using TCP
arm64 clients are unaffected by the bug
The armel clients use very small (4k) rsize/wsize buffers
Prior to the upgrade from Debian Stretch, everything was working perfectly

----- Original Message -----
> From: "Timothy Pearson" <tpearson@raptorengineering.com>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Wednesday, August 4, 2021 7:00:20 PM
> Subject: Callback slot table overflowed

> All,
> 
> We've hit an odd issue after upgrading a main NFS server from Debian Stretch to
> Debian Buster.  In both cases the 5.13.4 kernel was used, however after the
> upgrade none of our ARM thin clients can mount their root filesystems -- early
> in the boot process I/O errors are returned immediately following "Callback
> slot table overflowed" in the client dmesg.
> 
> I am unable to find any useful information on this "Callback slot table
> overflowed" message, and have no idea why it is only impacting our ARM (armel)
> clients.  Both 4.14 and 5.3 on the client side show the issue, other client
> kernel versions were not tested.
> 
> Curiously, increasing the rsize/wsize values to 65536 or higher reduces (but
> does not eliminate) the number of callback overflow messages.
> 
> The server is a ppc64el 64k page host, and none of our pcc64el or amd64 thin
> clients are experiencing any problems.  Nothing of interest appears in the
> server message log.
> 
> Any troubleshooting hints would be most welcome.
> 
> Thank you!
