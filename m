Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCBF2B0FA8
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 21:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgKLUzZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 15:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgKLUzZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 15:55:25 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E938C0613D1
        for <linux-nfs@vger.kernel.org>; Thu, 12 Nov 2020 12:55:25 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9F67940B5; Thu, 12 Nov 2020 15:55:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9F67940B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1605214524;
        bh=V5U9txh62l3KLTPgdR5X5Jzi53wShHNFYJrkNfUm3vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZyiChE0vzcp4qLOuRsHh1zKubrXzp6B3xG2fUW+64GeLxs4VaQNi1qFbITR7zNEVz
         07ttI0OcIznmwCYl5d/WupyfhcrKIpn2gggh0IVHHvwXDnmm1n3i0MP9v7Y1he7xNk
         uITx/36PPe0RSntmWA7AXoSMd0hLyDxMabsQAzwY=
Date:   Thu, 12 Nov 2020 15:55:24 -0500
From:   bfields <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201112205524.GI9243@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
 <4d1d7cd0076d98973a56e89c92e4ff0474aa0e14.camel@hammerspace.com>
 <1188023047.38703514.1600272094778.JavaMail.zimbra@dneg.com>
 <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
 <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com>
 <20201109160256.GB11144@fieldses.org>
 <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
 <20201112135733.GA9243@fieldses.org>
 <444227972.86442677.1605206025305.JavaMail.zimbra@dneg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444227972.86442677.1605206025305.JavaMail.zimbra@dneg.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 12, 2020 at 06:33:45PM +0000, Daire Byrne wrote:
> Well, yes NFSv4.2 all the way through works well for us but it's re-exporting a NFSv4.0 server (Linux OR Netapp) that seems to still show the input/output errors when dropping caches. Every other possible combination now seems to be working without ESTALE or input/errors with the lookupp emulation patches.
> 
> So this is still not working when dropping caches on the re-export server:
> 
> 		NFSv3/4.x			  NFSv4.0
> 	client --------> re-export server -------> original server
> 
> The bit specific to the Netapp is simply that our 7-mode only supports NFSv4.0 so I can't actually test NFSv4.1/4.2 on a more modern Netapp firmware release. So I have to use NFSv3 to mount the Netapp and can then happily re-export that using NFSv4.x or NFSv3 (if the filehandles fit in 63 bytes).

Oh, got it, thanks, so it's just the minor-version difference (probably
the open-by-filehandle stuff that went into 4.1).

> There was some discussion about NFS4_CHANGE_TYPE_IS_MONOTONIC_INCR
> allowing for the hack/optimisation but I guess that is only for the
> case when re-exporting NFSv4 to the eventual clients. It would not
> help if you were re-exporting an NFSv3 server with NFSv3 to the
> clients? I lack the deeper understanding to say anything more than
> that.

Oh, right, thanks for the reminder.  The CHANGE_TYPE_IS_MONOTONIC_INCR
optimization still looks doable to me.

How does that help, anyway?  I guess it avoids false positives of some
kind when rpc's are processed out of order?

Looking back at

	https://lore.kernel.org/linux-nfs/1155061727.42788071.1600777874179.JavaMail.zimbra@dneg.com/

this bothers me: "I'm not exactly sure why, but the iversion of the
inode gets changed locally (due to atime modification?) most likely via
invocation of method inode_inc_iversion_raw. Each time it gets
incremented the following call to validate attributes detects changes
causing it to be reloaded from the originating server."

The only call to that function outside afs or ceph code is in
fs/nfs/write.c, in the write delegation case.  The Linux server doesn't
support write delegations, Netapp does but this shouldn't be causing
cache invalidations.

--b.
