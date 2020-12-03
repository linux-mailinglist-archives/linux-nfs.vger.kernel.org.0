Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF982CE06A
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 22:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgLCVOJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 16:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLCVOJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 16:14:09 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28980C061A4F
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 13:13:29 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 188DB6F73; Thu,  3 Dec 2020 16:13:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 188DB6F73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1607030008;
        bh=dhCqrDQGCXVveAjoZSmWUxwLC8Ur7tGpwNup7lk16hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WD++3/275yEjGx1bvg/IxpebIIQMl2kPjYdGT7tP55XqYzedtA8KqhBcGAn00tWCd
         UMwys374YJInShstH4w4fUvJu7xl2AyRTeE3pFBkmBo9svy3h1xkbiQie9mwX3AcaU
         SC+awKefAtRCOjGKqPqABuKajey7qsgp7v6lGFlk=
Date:   Thu, 3 Dec 2020 16:13:28 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "daire@dneg.com" <daire@dneg.com>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201203211328.GC27931@fieldses.org>
References: <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
 <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com>
 <20201109160256.GB11144@fieldses.org>
 <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
 <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
 <20201124211522.GC7173@fieldses.org>
 <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
 <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
 <20201203185109.GB27931@fieldses.org>
 <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 03, 2020 at 08:27:39PM +0000, Trond Myklebust wrote:
> On Thu, 2020-12-03 at 13:51 -0500, bfields wrote:
> > I've been scratching my head over how to handle reboot of a re-
> > exporting
> > server.  I think one way to fix it might be just to allow the re-
> > export
> > server to pass along reclaims to the original server as it receives
> > them
> > from its own clients.  It might require some protocol tweaks, I'm not
> > sure.  I'll try to get my thoughts in order and propose something.
> > 
> 
> It's more complicated than that. If the re-exporting server reboots,
> but the original server does not, then unless that re-exporting server
> persisted its lease and a full set of stateids somewhere, it will not
> be able to atomically reclaim delegation and lock state on the server
> on behalf of its clients.

By sending reclaims to the original server, I mean literally sending new
open and lock requests with the RECLAIM bit set, which would get brand
new stateids.

So, the original server would invalidate the existing client's previous
clientid and stateids--just as it normally would on reboot--but it would
optionally remember the underlying locks held by the client and allow
compatible lock reclaims.

Rough attempt:

	https://wiki.linux-nfs.org/wiki/index.php/Reboot_recovery_for_re-export_servers

Think it would fly?

--b.
