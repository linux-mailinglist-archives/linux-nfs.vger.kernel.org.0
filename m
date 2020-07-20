Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E922226CB1
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jul 2020 19:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgGTRBS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jul 2020 13:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgGTRBS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jul 2020 13:01:18 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473EAC061794
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jul 2020 10:01:18 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 656C4876B; Mon, 20 Jul 2020 13:01:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 656C4876B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1595264477;
        bh=FLsy/zKNE3XfUWBna3ZW1VaGtM9nrPHT9Sx9XJtZDxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUw2qXIiw4Bv1cJPX3u9DqGQnKd6PqqiMHk3nI1GltOxIjUdQrXqPp2FA7185pV6C
         6o5iAsu+ut42sxW+V91Z7dzh7zImym3cvHm86YcokdM/UpedpzaXslPiChxHblWQJE
         pZXNxhOxhnaaj1WVHvKSneWI2QLLq16T7FzvDX24=
Date:   Mon, 20 Jul 2020 13:01:17 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "alexey.kodanev@oracle.com" <alexey.kodanev@oracle.com>,
        "yangx.jy@cn.fujitsu.com" <yangx.jy@cn.fujitsu.com>
Subject: Re: [RFC PATCH 1/1] Remove nfsv4
Message-ID: <20200720170117.GB25707@fieldses.org>
References: <20200720091449.19813-1-pvorel@suse.cz>
 <ffb5cd64d5d65b762bdc85b6044b7fdc526d27cb.camel@hammerspace.com>
 <20200720141255.GA25707@fieldses.org>
 <20200720143620.GD21201@dell5510>
 <20200720151508.GA13786@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720151508.GA13786@dell5510>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 20, 2020 at 05:15:08PM +0200, Petr Vorel wrote:
> Hi Bruce, Trond,
> 
> > > On Mon, Jul 20, 2020 at 01:32:09PM +0000, Trond Myklebust wrote:
> > > > On Mon, 2020-07-20 at 11:14 +0200, Petr Vorel wrote:
> > > > > Reasons to drop:
> > > > > * outdated tests (from 2005)
> > > > > * not used (NFS kernel maintainers use pynfs [1])
> > > > > * written in Python (we support C and shell, see [2])
> 
> > > > > [1] http://git.linux-nfs.org/?p=bfields/pynfs.git;a=summary
> > > > > [2] https://github.com/linux-test-project/ltp/issues/547
> 
> 
> > > > Unlike pynfs, these tests run on a real NFS client, and were designed
> > > > to test client implementations, as well as the servers.
> 
> > > > So if they get dropped from ltp, then we will have to figure out some
> > > > other way of continuing to maintain them.
> 
> > > Just for fun, I grepped through old mail to see if I could find any
> > > cases of these tests being used.  I found one, in which Chuck reports an
> > > nfslock01 failure.  Looks like it did find a real bug, which we fixed:
> 
> > > 	https://lore.kernel.org/r/8DF85CB6-5FEB-4A25-9715-C9808F37A4B1@oracle.com
> > > 	https://lore.kernel.org/r/20160807185024.11705.10864.stgit@klimt.1015granger.net
> 
> > Thanks for your explanation, this obviously justify these tests in LTP, unless
> > you want to move it to git.linux-nfs.org and maintain on your own.
> Actually, that fix 42691398be08 ("nfsd: Fix race between FREE_STATEID and LOCK")
> from v4.8-rc2 reported by Alexey Kodanev (LTP network maintainer) was found by
> nfslock01 test [1], which is integrated into other LTP NFS tests [2]. I'd
> definitely keep these in LTP.

Whoops, I don't know why I thought I saw nfslock01 in your patch.
Apologies.

> nfsv4 I proposed to remove as outdated and not being used are testing ACL [3]
> and fcntl locking [4]. ACL tests use rsh and aren't integrated into LTP
> framework (use their custom [5] runtest file thus I doubt anyone is using it).
> fcntl locktests are at least integrated into LTP (use fcntl-locktests runtest
> file[6], I forget to remove it in this patch).
> Both tests are written in 2005. I don't want to push for removal, if you see any
> use in it.

Looks like they may test some things (ACL enforcement, multi-client
locking), that our other test suites don't.

On the other hand, if nobody's actually running them then maybe it's on
us to adopt them if we want them.  (Not volunteering for now.)

--b.

> 
> Kind regards,
> Petr
> 
> [1] https://github.com/linux-test-project/ltp/tree/master/testcases/network/nfs/nfslock01/
> [2] https://github.com/linux-test-project/ltp/blob/master/runtest/net.nfs
> [3] https://github.com/linux-test-project/ltp/tree/master/testcases/network/nfsv4/acl
> [4] https://github.com/linux-test-project/ltp/tree/master/testcases/network/nfsv4/locks
> [5] https://github.com/linux-test-project/ltp/blob/master/testcases/network/nfsv4/acl/runtest
> [6] https://github.com/linux-test-project/ltp/blob/master/runtest/fcntl-locktests
