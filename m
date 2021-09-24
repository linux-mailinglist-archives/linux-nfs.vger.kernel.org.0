Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8205417906
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Sep 2021 18:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245709AbhIXQqi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Sep 2021 12:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245680AbhIXQqi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Sep 2021 12:46:38 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35ECC061613;
        Fri, 24 Sep 2021 09:45:04 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7963A7034; Fri, 24 Sep 2021 12:45:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7963A7034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632501904;
        bh=OeqA0TcK9mOX1kIH/PeZkUy+Rs88FKPZodMwKeaWb2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4GoKknjRE3/0mZJQLfnppaXfXdy7Lm1K8owA8xYimncsnZlpvD4Z9LWHwdmuFb5U
         n0iVmHMRNrTvLF80i8CcDqwUGRp65/Rs1fOneuFxDB9b2prswz3FIoKW05fPtGCdq2
         ANTI/oISDZmnqQkzrvoLTew+bGm58c9QH0YnKu9Y=
Date:   Fri, 24 Sep 2021 12:45:04 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Jeremy Allison <jra@samba.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "slow@samba.org" <slow@samba.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Subject: Re: Locking issue between NFSv4 and SMB client
Message-ID: <20210924164504.GC13115@fieldses.org>
References: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
 <20210923215056.GH18334@fieldses.org>
 <48b3a41e2dbea7948b0df3fea002208a273409fd.camel@hammerspace.com>
 <f4b9eb02-73e6-f082-6657-87a007b99198@samba.org>
 <ea40f67038f822d13407becb7e4eedc31e5edbb0.camel@hammerspace.com>
 <YU3+nhUW+xSzjIhD@jeremy-acer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU3+nhUW+xSzjIhD@jeremy-acer>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 24, 2021 at 09:36:46AM -0700, Jeremy Allison wrote:
> On Fri, Sep 24, 2021 at 04:13:23AM +0000, Trond Myklebust wrote:
> >On Fri, 2021-09-24 at 05:46 +0200, Ralph Boehme wrote:
> >>Am 24.09.21 um 05:35 schrieb Trond Myklebust:
> >>> Not if you set the "kernel oplocks" parameter in the smb.conf file.
> >>> We
> >>> just added support for this in the Linux 5.14 kernel NFSv4 client.
> >>>
> >>> Now that said, "kernel oplocks" will currently only support basic
> >>> level
> >>> I oplocks, and cannot support level II or leases. According to the
> >>> smb.conf manpage, this is due to some incompleteness in the current
> >>> VFS
> >>> lease implementation.
> >>>
> >>> I'd love to get some more info from the Samba team about what is
> >>> missing from the kernel lease implementation that prevents us from
> >>> implementing these more advanced oplock/lease features. From the
> >>> description in Microsoft's docs, I'm pretty sure that NFSv4
> >>> delegations
> >>> should be able to provide all the guarantees that are required.
> >>
> >>leases can be shared among file handles. When someone requests a
> >>lease
> >>he passes a cookie. Then when he opens the same file with the same
> >>cookie the lease is not broken.
> >
> >Right, but that is easily solved in user space by having the cookie act
> >as a key that references the file descriptor that holds the lease. This
> >is how we typically implement NFSv4 delegations as well.
> 
> How does this work in multi-process situations ?
> When you say "file descriptor", if the fd was passed
> between processes would the lease state transfer ?

Yes, the lease is associated with the "file description"/struct file, so
for example you should be able to F_UNLCK it from the new process.

--b.
