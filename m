Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6FC2CE537
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Dec 2020 02:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgLDBll (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 20:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgLDBll (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 20:41:41 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A60EC061A4F
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 17:41:01 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2E9BB6F73; Thu,  3 Dec 2020 20:41:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2E9BB6F73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1607046060;
        bh=mwHv+ljtucNWrcqtnAws4GBCt58NbcD3UY3D4DsoaY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYJAMlrI7Z/vB0ZEFo7/iiTBLsCn+04nkVr62Mfk4pnv/UHcl+26z8+2GEM5A78/6
         sRtTgyeKSkwmulPOfwmiGntc3cvR1w6pofe+wCfdlHhQ8czGF8nD+huuvtxwF57Mp3
         dyik/9Z1DwWAf1/ZIAIn7VbaxaYw04us5EnE3UrQ=
Date:   Thu, 3 Dec 2020 20:41:00 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201204014100.GI27931@fieldses.org>
References: <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
 <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
 <20201203185109.GB27931@fieldses.org>
 <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>
 <20201203211328.GC27931@fieldses.org>
 <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>
 <20201203224520.GG27931@fieldses.org>
 <d88c69f90820bf631908cbe3d3ce34343ec672f1.camel@hammerspace.com>
 <20201203231655.GH27931@fieldses.org>
 <136e9c309ad962cb247b9e696633484db76d1f3b.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <136e9c309ad962cb247b9e696633484db76d1f3b.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 04, 2020 at 01:02:20AM +0000, Trond Myklebust wrote:
> On Thu, 2020-12-03 at 18:16 -0500, bfields@fieldses.org wrote:
> > On Thu, Dec 03, 2020 at 10:53:26PM +0000, Trond Myklebust wrote:
> > > On Thu, 2020-12-03 at 17:45 -0500, bfields@fieldses.org wrote:
> > > > On Thu, Dec 03, 2020 at 09:34:26PM +0000, Trond Myklebust wrote:
> > > > > I've been wanting such a function for quite a while anyway in
> > > > > order to allow the client to detect state leaks (either due to
> > > > > soft timeouts, or due to reordered close/open operations).
> > > > 
> > > > One sure way to fix any state leaks is to reboot the server.  The
> > > > server throws everything away, the clients reclaim, all that's
> > > > left
> > > > is stuff they still actually care about.
> > > > 
> > > > It's very disruptive.
> > > > 
> > > > But you could do a limited version of that: the server throws
> > > > away
> > > > the state from one client (keeping the underlying locks on the
> > > > exported filesystem), lets the client go through its normal
> > > > reclaim
> > > > process, at the end of that throws away anything that wasn't
> > > > reclaimed.  The only delay is to anyone trying to acquire new
> > > > locks
> > > > that conflict with that set of locks, and only for as long as it
> > > > takes for the one client to reclaim.
> > > 
> > > One could do that, but that requires the existence of a quiescent
> > > period where the client holds no state at all on the server.
> > 
> > No, as I said, the client performs reboot recovery for any state that
> > it
> > holds when we do this.
> > 
> 
> Hmm... So how do the client and server coordinate what can and cannot
> be reclaimed? The issue is that races can work both ways, with the
> client sometimes believing that it holds a layout or a delegation that
> the server thinks it has returned. If the server allows a reclaim of
> such a delegation, then that could be problematic (because it breaks
> lock atomicity on the client and because it may cause conflicts).

The server's not actually forgetting anything, it's just pretending to,
in order to trigger the client's reboot recovery.  It can turn down the
client's attempt to reclaim something it doesn't have.

Though isn't it already game over by the time the client thinks it holds
some lock/open/delegation that the server doesn't?  I guess I'd need to
see these cases written out in detail to understand.

--b.

> By the way, the other thing that I'd like to add to my wishlist is a
> callback that allows the server to ask the client if it still holds a
> given open or lock stateid. A server can recall a delegation or a
> layout, so it can fix up leaks of those, however it has no remedy if
> the client loses an open or lock stateid other than to possibly
> forcibly revoke state. That could cause application crashes if the
> server makes a mistake and revokes a lock that is actually in use.
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
