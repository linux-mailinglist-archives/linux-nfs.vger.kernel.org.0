Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FC02CE203
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 23:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgLCWqC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 17:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbgLCWqB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 17:46:01 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BD3C061A51
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 14:45:21 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id EFBFC6F4C; Thu,  3 Dec 2020 17:45:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EFBFC6F4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1607035520;
        bh=Wgp5iLi7J60c/nEBHuQcrbKwvhRwc9Cl/uyZlZdjNHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asSzefJdpgM0fovV+xt3OYtnZ9Is1TPetqAcbKWmkpzbvSCmop1uWqgyxI3P0NYda
         lTDOTh/JSmQBaMcng4Pf4FBzpmZKen4ZB7Md6XbBc8+4BXkKl1RIzH7LeRtR7nesp6
         m4Y4EpJ8groDrP2lPIVi6D5AguJW7foHMm1TAkH4=
Date:   Thu, 3 Dec 2020 17:45:20 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201203224520.GG27931@fieldses.org>
References: <20201109160256.GB11144@fieldses.org>
 <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
 <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
 <20201124211522.GC7173@fieldses.org>
 <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
 <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
 <20201203185109.GB27931@fieldses.org>
 <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>
 <20201203211328.GC27931@fieldses.org>
 <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 03, 2020 at 09:34:26PM +0000, Trond Myklebust wrote:
> I've been wanting such a function for quite a while anyway in order to
> allow the client to detect state leaks (either due to soft timeouts, or
> due to reordered close/open operations).

One sure way to fix any state leaks is to reboot the server.  The server
throws everything away, the clients reclaim, all that's left is stuff
they still actually care about.

It's very disruptive.

But you could do a limited version of that: the server throws away the
state from one client (keeping the underlying locks on the exported
filesystem), lets the client go through its normal reclaim process, at
the end of that throws away anything that wasn't reclaimed.  The only
delay is to anyone trying to acquire new locks that conflict with that
set of locks, and only for as long as it takes for the one client to
reclaim.

?

--b.
