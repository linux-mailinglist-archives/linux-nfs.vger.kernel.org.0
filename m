Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358412C3264
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 22:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgKXVPX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 16:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgKXVPX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 16:15:23 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B0DC0613D6
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 13:15:23 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4EBF06EA0; Tue, 24 Nov 2020 16:15:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4EBF06EA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606252522;
        bh=S8RmQ1xSHzfLzSM/Y0ufkJXE0GHo4Mf3FBByhL7HB4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EfLHfcGIDiL6EV9b4Zk4vWbKV5T3eQ7j3h5pEcgK3wGKSLAeOTXE4vEhzpFS5hNnI
         7vFRXj0nr6Q5i7ZS2Qk1zvPnOGTU/2K6Iz4UEKhD4FHworaQ3TqejJDuDs8Pe6f7CQ
         KHmfmSMgKwRtwyXzslcTDD6C1Kj0081W0rP/eJZc=
Date:   Tue, 24 Nov 2020 16:15:22 -0500
From:   bfields <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201124211522.GC7173@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
 <20200915172140.GA32632@fieldses.org>
 <4d1d7cd0076d98973a56e89c92e4ff0474aa0e14.camel@hammerspace.com>
 <1188023047.38703514.1600272094778.JavaMail.zimbra@dneg.com>
 <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
 <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com>
 <20201109160256.GB11144@fieldses.org>
 <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
 <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 24, 2020 at 08:35:06PM +0000, Daire Byrne wrote:
> Sometimes I have seen clusters of 16 GETATTRs for the same file on the
> wire with nothing else inbetween. So if the re-export server is the
> only "client" writing these files to the originating server, why do we
> need to do so many repeat GETATTR calls when using nconnect>1? And why
> are the COMMIT calls required when the writes are coming via nfsd but
> not from userspace on the re-export server? Is that due to some sort
> of memory pressure or locking?
> 
> I picked the NFSv3 originating server case because my head starts to
> hurt tracking the equivalent packets, stateids and compound calls with
> NFSv4. But I think it's mostly the same for NFSv4. The writes through
> the re-export server lead to lots of COMMITs and (double) GETATTRs but
> using nconnect>1 at least doesn't seem to make it any worse like it
> does for NFSv3.
> 
> But maybe you actually want all the extra COMMITs to help better
> guarantee your writes when putting a re-export server in the way?
> Perhaps all of this is by design...

Maybe that's close-to-open combined with the server's tendency to
open/close on every IO operation?  (Though the file cache should have
helped with that, I thought; as would using version >=4.0 on the final
client.)

Might be interesting to know whether the nocto mount option makes a
difference.  (So, add "nocto" to the mount options for the NFS mount
that you're re-exporting on the re-export server.)

By the way I made a start at a list of issues at

	http://wiki.linux-nfs.org/wiki/index.php/NFS_re-export

but I was a little vague on which of your issues remained and didn't
take much time over it.

(If you want an account on that wiki BTW I seem to recall you just have
to ask Trond (for anti-spam reasons).)

--b.
