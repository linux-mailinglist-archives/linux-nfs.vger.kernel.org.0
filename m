Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BFF47493A
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Dec 2021 18:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbhLNRYy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Dec 2021 12:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbhLNRYy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Dec 2021 12:24:54 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0600DC061574
        for <linux-nfs@vger.kernel.org>; Tue, 14 Dec 2021 09:24:54 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2BDC22218; Tue, 14 Dec 2021 12:24:53 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2BDC22218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1639502693;
        bh=Q2UZo6NdBNvf/3X79Lk/krkN8EEIvrQWpNpcb9laU8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GzR5qdteEnVMz34YMKJDllqDvoCdJ8eIEITs1qK1rTo7Vr7PD3VbNsCDP0YTIGb7a
         Rq8NQx53NPaqpmk0DQlG6JRgNUP8OgtLBQxxvsXgDLt6xJQc86kIohBjsWR+x73Qrx
         EPj9hAZ3U+11vDWuxfcuz0vhsRFhcfWLe8SZvJf8=
Date:   Tue, 14 Dec 2021 12:24:53 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [bug report] nfs clients fail to get read delegations after file
 open with O_RDWR
Message-ID: <20211214172453.GA13957@fieldses.org>
References: <OS3PR01MB7705959736BA3A5BDF9C0AFD89749@OS3PR01MB7705.jpnprd01.prod.outlook.com>
 <20211213215550.GA2230@fieldses.org>
 <OS3PR01MB770504D572DE88FD1E51BD3689759@OS3PR01MB7705.jpnprd01.prod.outlook.com>
 <20211214164507.GC12078@fieldses.org>
 <03f509d6889856869058e1bfb4d480524489354b.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f509d6889856869058e1bfb4d480524489354b.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 14, 2021 at 12:19:54PM -0500, Jeff Layton wrote:
> On Tue, 2021-12-14 at 11:45 -0500, J. Bruce Fields wrote:
> > On Tue, Dec 14, 2021 at 12:50:53AM +0000, suy.fnst@fujitsu.com wrote:
> > > If I understand the case correctly, the most common workload it influences like:
> > > 
> > > One nfs client opens a file with flag O_WRONLY/O_RDWR, close it.
> > > Then some nfs clients open the file with O_RDONLY right now then it will prevent
> > > server to give any delegation to other clients.  It may cause many unnecessary
> > > requests from clients because lack of delegations.
...
> Is that really desirable behavior? There is the bloom filter in
> nfs4state.c too that prevents it from handing out a delegation too soon
> after a delegrecall.
> 
> The situation above doesn't involve a recall, but it _could_ have if the
> timing had been a little different. It's probably worth thinking about
> how the rules for this ought to work in all cases.
> 
> Should we be treating inodes that experience real delegation recalls
> differently from this case?

It's not hard to imagine common cases where clients would want to read a
file soon after it's written.  E.g. a distributed compile or processing
pipeline where clients are sitting there waiting for new files to appear
and then doing further processing on them when they do.  I guess the
creator would do something in that case to indicate when the writing was
done--maybe rename the file to a common directory, or send some kind of
signal outside of NFS.

--b.
