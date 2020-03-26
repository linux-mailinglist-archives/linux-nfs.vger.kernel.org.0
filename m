Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F18194953
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 21:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgCZUkC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Mar 2020 16:40:02 -0400
Received: from fieldses.org ([173.255.197.46]:56614 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgCZUkC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 26 Mar 2020 16:40:02 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id E40A5BD1; Thu, 26 Mar 2020 16:40:01 -0400 (EDT)
Date:   Thu, 26 Mar 2020 16:40:01 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH] SUNRPC/cache: Allow garbage collection of invalid cache
 entries
Message-ID: <20200326204001.GA25053@fieldses.org>
References: <20200114165738.922961-1-trond.myklebust@hammerspace.com>
 <20200206163322.GB2244@fieldses.org>
 <8dc1ed17de98e4b59fb9e408692c152456863a20.camel@hammerspace.com>
 <20200207181817.GC17036@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207181817.GC17036@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sorry, just getting back to this:

On Fri, Feb 07, 2020 at 01:18:17PM -0500, bfields@fieldses.org wrote:
> On Fri, Feb 07, 2020 at 02:25:27PM +0000, Trond Myklebust wrote:
> > On Thu, 2020-02-06 at 11:33 -0500, J. Bruce Fields wrote:
> > > On Tue, Jan 14, 2020 at 11:57:38AM -0500, Trond Myklebust wrote:
> > > > If the cache entry never gets initialised, we want the garbage
> > > > collector to be able to evict it. Otherwise if the upcall daemon
> > > > fails to initialise the entry, we end up never expiring it.
> > > 
> > > Could you tell us more about what motivated this?
> > > 
> > > It's causing failures on pynfs server-reboot tests.  I haven't pinned
> > > down the cause yet, but it looks like it could be a regression to the
> > > behavior Kinglong Mee describes in detail in his original patch.
> > > 
> > 
> > Can you point me to the tests that are failing?
> 
> I'm basically doing
> 
> 	./nfs4.1/testserver.py myserver:/path reboot
> 			--serverhelper=examples/server_helper.sh
> 			--serverhelperarg=myserver
> 
> For all I know at this point, the change could be exposing a pynfs-side
> bug.

From a trace, it's clear that the server is actually becoming
unresponsive, so it's not a pynfs bug.

> > The motivation here is to allow the garbage collector to do its job of
> > evicting cache entries after they are supposed to have timed out.
> 
> Understood.  I was curious whether this was found by code inspection or
> because you'd run across a case where the leak was causing a practical
> problem.

I'm still curious.

> > The fact that uninitialised cache entries are given an infinite
> > lifetime, and are never evicted is a de facto memory leak if, for
> > instance, the mountd daemon ignores the cache request, or the downcall
> > in expkey_parse() or svc_export_parse() fails without being able to
> > update the request.

If mountd ignores cache requests, or downcalls fail, then the server's
broken anyway.  The server can't do anything without mountd.

> > The threads that are waiting for the cache replies already have a
> > mechanism for dealing with timeouts (with cache_wait_req() and
> > deferred requests), so the question is what is so special about
> > uninitialised requests that we have to leak them in order to avoid a
> > problem with reboot?

I'm not sure I have this right yet.  I'm just staring at the code and at
Kinglong Mee's description on d6fc8821c2d2.  I think the way it works is
that a cash flush from mountd results in all cache entries (including
invalid entries that nfsd threads are waiting on) being considered
expired.  So cache_check() returns an immediate ETIMEDOUT without
waiting.

Maybe the cache_is_expired() logic should be something more like:

	if (h->expiry_time < seconds_since_boot())
		return true;
	if (!test_bit(CACHE_VALID, &h->flags))
		return false;
	return h->expiry_time < seconds_since_boot();

So invalid cache entries (which are waiting for a reply from mountd) can
expire, but they can't be flushed.  If that makes sense.

As a stopgap we may want to revert or drop the "Allow garbage
collection" patch, as the (preexisting) memory leak seems lower impact
than the server hang.

--b.
