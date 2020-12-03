Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EBF2CE280
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Dec 2020 00:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgLCXRh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 18:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgLCXRh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 18:17:37 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A2EC061A4F
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 15:16:57 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9353A6F73; Thu,  3 Dec 2020 18:16:55 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9353A6F73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1607037415;
        bh=bRzgyJX+mw3fZ2rQDnyS5pzj8lBJX8VmWyQ/SVhPMVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uLzGNFyi4yUFnzfNGOkoJJBUHlt1FjT4GiUFAzZeoKbsi9EDcy0tDTCa55e+5KdoK
         fTAZVuHtp4NLOVUuf/NqjitqopDi1nQ9DnkCfNLxi1Vt279Jg6OnqdoGer3QjoA85p
         x+qZ9MRNXM4XKF9iwIqakWSTc1A5r/B3ixHtj9IM=
Date:   Thu, 3 Dec 2020 18:16:55 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201203231655.GH27931@fieldses.org>
References: <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
 <20201124211522.GC7173@fieldses.org>
 <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
 <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
 <20201203185109.GB27931@fieldses.org>
 <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>
 <20201203211328.GC27931@fieldses.org>
 <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>
 <20201203224520.GG27931@fieldses.org>
 <d88c69f90820bf631908cbe3d3ce34343ec672f1.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d88c69f90820bf631908cbe3d3ce34343ec672f1.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 03, 2020 at 10:53:26PM +0000, Trond Myklebust wrote:
> On Thu, 2020-12-03 at 17:45 -0500, bfields@fieldses.org wrote:
> > On Thu, Dec 03, 2020 at 09:34:26PM +0000, Trond Myklebust wrote:
> > > I've been wanting such a function for quite a while anyway in
> > > order to allow the client to detect state leaks (either due to
> > > soft timeouts, or due to reordered close/open operations).
> > 
> > One sure way to fix any state leaks is to reboot the server.  The
> > server throws everything away, the clients reclaim, all that's left
> > is stuff they still actually care about.
> > 
> > It's very disruptive.
> > 
> > But you could do a limited version of that: the server throws away
> > the state from one client (keeping the underlying locks on the
> > exported filesystem), lets the client go through its normal reclaim
> > process, at the end of that throws away anything that wasn't
> > reclaimed.  The only delay is to anyone trying to acquire new locks
> > that conflict with that set of locks, and only for as long as it
> > takes for the one client to reclaim.
> 
> One could do that, but that requires the existence of a quiescent
> period where the client holds no state at all on the server.

No, as I said, the client performs reboot recovery for any state that it
holds when we do this.

--b.
