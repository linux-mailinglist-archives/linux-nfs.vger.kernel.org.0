Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F66B2CDE07
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 19:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgLCSvv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 13:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgLCSvu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 13:51:50 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B590FC061A4E
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 10:51:10 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0289C6F5E; Thu,  3 Dec 2020 13:51:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0289C6F5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1607021470;
        bh=On0cocyPm5XBAlbAfaHwqvtq06p6jvVhxIbij+bxQu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zror/5wohwl8C4kaHqmUv1AI/WDS32NK0BTlVzvWBJbOXMV42KL45SqeSNZtVkY/I
         cs5YNu5Ryj79qv8MSMLYZxSBxdVquFUKRt+UDUJLespgfsc0YMPGD+2yamagUA1coS
         Chxvvv9cEmnKmhF5xkmYeXQ71CkKphVhJneicg54=
Date:   Thu, 3 Dec 2020 13:51:09 -0500
From:   bfields <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201203185109.GB27931@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
 <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
 <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com>
 <20201109160256.GB11144@fieldses.org>
 <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
 <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
 <20201124211522.GC7173@fieldses.org>
 <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
 <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 03, 2020 at 12:20:35PM +0000, Daire Byrne wrote:
> Just a small update based on the most recent patchsets from Trond &
> Bruce:
> 
> https://patchwork.kernel.org/project/linux-nfs/list/?series=393567
> https://patchwork.kernel.org/project/linux-nfs/list/?series=393561
> 
> For the write-through tests, the NFSv3 re-export of a NFSv4.2 server
> has trimmed an extra GETATTR:
> 
> Before: originating server <- (vers=4.2) <- reexport server - (vers=3)
> <- client writing = WRITE,COMMIT,GETATTR .... repeating
>  
> After: originating server <- (vers=4.2) <- reexport server - (vers=3)
> <- client writing = WRITE,COMMIT .... repeating
> 
> I'm assuming this is specifically due to the "EXPORT_OP_NOWCC" patch?

Probably so, thanks for the update.

> All other combinations look the same as before (for write-through). An
> NFSv4.2 re-export of a NFSv3 server is still the best/ideal in terms
> of not incurring extra metadata roundtrips when writing.
> 
> It's great to see this re-export scenario becoming a better supported
> (and performing) topology; many thanks all.

I've been scratching my head over how to handle reboot of a re-exporting
server.  I think one way to fix it might be just to allow the re-export
server to pass along reclaims to the original server as it receives them
from its own clients.  It might require some protocol tweaks, I'm not
sure.  I'll try to get my thoughts in order and propose something.

--b.
