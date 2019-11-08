Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B040F52F7
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2019 18:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfKHRvK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Nov 2019 12:51:10 -0500
Received: from fieldses.org ([173.255.197.46]:36434 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbfKHRvK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 8 Nov 2019 12:51:10 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id D27101C15; Fri,  8 Nov 2019 12:51:09 -0500 (EST)
Date:   Fri, 8 Nov 2019 12:51:09 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: Fix races between nfsd4_cb_release() and
 nfsd4_shutdown_callback()
Message-ID: <20191108175109.GA758@fieldses.org>
References: <20191023214318.9350-1-trond.myklebust@hammerspace.com>
 <20191025145147.GA16053@pick.fieldses.org>
 <97f56de86f0aeafb56998023d0561bb4a6233eb8.camel@hammerspace.com>
 <20191025152119.GC16053@pick.fieldses.org>
 <20191025153336.GA20283@fieldses.org>
 <20191029214705.GA29280@fieldses.org>
 <20191107222712.GB10806@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107222712.GB10806@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 07, 2019 at 05:27:12PM -0500, J. Bruce Fields wrote:
> On Tue, Oct 29, 2019 at 05:47:05PM -0400, J. Bruce Fields wrote:
> > On Fri, Oct 25, 2019 at 11:33:36AM -0400, bfields wrote:
> > > On Fri, Oct 25, 2019 at 11:21:19AM -0400, J. Bruce Fields wrote:
> > > > I thought I was running v2, let me double-check....
> > > 
> > > Yes, with v2 I'm getting a hang on generic/013.
> > > 
> > > I checked quickly and didn't see anything interesting in the logs,
> > > otherwise I haven't done any digging.
> > 
> > Reproduceable just with ./check -nfs generic/013.  The last thing I see
> > in wireshark is an asynchronous COPY call and reply.  Which means it's
> > probably trying to do a CB_OFFLOAD.  Hm.
> 
> Oh, I think it just needs the following.

Applying as follows, with part of the change split out into a separate
patch (since that's how I noticed the bug).

--b.
