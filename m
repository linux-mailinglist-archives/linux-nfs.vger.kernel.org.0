Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3F13E0B57
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Aug 2021 02:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhHEAhf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Aug 2021 20:37:35 -0400
Received: from mail.rptsys.com ([23.155.224.45]:56306 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234461AbhHEAhe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Aug 2021 20:37:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 3206737B2A7E7E
        for <linux-nfs@vger.kernel.org>; Wed,  4 Aug 2021 19:37:21 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cUZq-OHaIERh for <linux-nfs@vger.kernel.org>;
        Wed,  4 Aug 2021 19:37:20 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id A5E4E37B2A7E7B
        for <linux-nfs@vger.kernel.org>; Wed,  4 Aug 2021 19:37:20 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com A5E4E37B2A7E7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1628123840; bh=rFTMcCQq9VbQc0T/27T13QByavd3E0ghZ+HhXYiz1b4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=skOUg6ooFP10WKvFSx+mmDTtktBmv63xYUwuFpYaJQeg8JoCUZBuZ0IAcohDPLs2e
         LQoN/NVUiGUDQPBQG+zSE1AFAP3VdgtU1WPM4Ty//dDJ7NOhC4IDVd9lE7ez1MHwMB
         ks+jQqvAsJ3T7FlK32qA1J5KuQhODRcP32nht3rk=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1r29NYEvDsCS for <linux-nfs@vger.kernel.org>;
        Wed,  4 Aug 2021 19:37:20 -0500 (CDT)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id 82DA937B2A7E78
        for <linux-nfs@vger.kernel.org>; Wed,  4 Aug 2021 19:37:20 -0500 (CDT)
Date:   Wed, 4 Aug 2021 19:37:19 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <361337129.54635.1628123839436.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <1851673341.49012.1628121856011.JavaMail.zimbra@raptorengineeringinc.com>
References: <985631970.48634.1628121620017.JavaMail.zimbra@raptorengineeringinc.com> <1851673341.49012.1628121856011.JavaMail.zimbra@raptorengineeringinc.com>
Subject: Re: Callback slot table overflowed
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC83 (Linux)/8.5.0_GA_3042)
Thread-Topic: Callback slot table overflowed
Thread-Index: pWASFVTGcuTitVsqm6vgvEReZrSGHqraViLp7esZBoM=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On further investigation, the working server had already been rolled back to 4.19.0.  Apparently the issue was insurmountable in 5.x.

It should be simple enough to set up a test environment out of production for 5.x, if you have any debug tips / would like to see any debug options compiled in.

Thanks!

----- Original Message -----
> From: "Timothy Pearson" <tpearson@raptorengineering.com>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Wednesday, August 4, 2021 7:04:16 PM
> Subject: Re: Callback slot table overflowed

> Other information that may be helpful:
> 
> All clients are using TCP
> arm64 clients are unaffected by the bug
> The armel clients use very small (4k) rsize/wsize buffers
> Prior to the upgrade from Debian Stretch, everything was working perfectly
> 
> ----- Original Message -----
>> From: "Timothy Pearson" <tpearson@raptorengineering.com>
>> To: "linux-nfs" <linux-nfs@vger.kernel.org>
>> Sent: Wednesday, August 4, 2021 7:00:20 PM
>> Subject: Callback slot table overflowed
> 
>> All,
>> 
>> We've hit an odd issue after upgrading a main NFS server from Debian Stretch to
>> Debian Buster.  In both cases the 5.13.4 kernel was used, however after the
>> upgrade none of our ARM thin clients can mount their root filesystems -- early
>> in the boot process I/O errors are returned immediately following "Callback
>> slot table overflowed" in the client dmesg.
>> 
>> I am unable to find any useful information on this "Callback slot table
>> overflowed" message, and have no idea why it is only impacting our ARM (armel)
>> clients.  Both 4.14 and 5.3 on the client side show the issue, other client
>> kernel versions were not tested.
>> 
>> Curiously, increasing the rsize/wsize values to 65536 or higher reduces (but
>> does not eliminate) the number of callback overflow messages.
>> 
>> The server is a ppc64el 64k page host, and none of our pcc64el or amd64 thin
>> clients are experiencing any problems.  Nothing of interest appears in the
>> server message log.
>> 
>> Any troubleshooting hints would be most welcome.
>> 
> > Thank you!
