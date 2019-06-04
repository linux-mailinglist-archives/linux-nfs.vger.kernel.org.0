Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4EC34AB2
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2019 16:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfFDOpg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jun 2019 10:45:36 -0400
Received: from fieldses.org ([173.255.197.46]:47386 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfFDOpf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Jun 2019 10:45:35 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 509F21C9D; Tue,  4 Jun 2019 10:45:35 -0400 (EDT)
Date:   Tue, 4 Jun 2019 10:45:35 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] SUNRPC: Count ops completing with tk_status < 0
Message-ID: <20190604144535.GA19422@fieldses.org>
References: <20190523201351.12232-1-dwysocha@redhat.com>
 <20190523201351.12232-3-dwysocha@redhat.com>
 <20190530213857.GA24802@fieldses.org>
 <9B9F0C9B-C493-44F5-ABD1-6B2B4BAA2F08@oracle.com>
 <20190530223314.GA25368@fieldses.org>
 <CD3B0503-ABA0-4670-9A76-0B9DF0AE5B5C@oracle.com>
 <f7976bde9979e8b763c0009b523331ab5ce6b6ed.camel@redhat.com>
 <5CE8A68E-F5C2-4321-8F57-451F5E5AF789@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CE8A68E-F5C2-4321-8F57-451F5E5AF789@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 03, 2019 at 02:56:29PM -0400, Chuck Lever wrote:
> > On Jun 3, 2019, at 2:53 PM, Dave Wysochanski <dwysocha@redhat.com> wrote:
> > On Fri, 2019-05-31 at 09:25 -0400, Chuck Lever wrote:
> >>> On May 30, 2019, at 6:33 PM, Bruce Fields <bfields@fieldses.org>
> >>> wrote:
> >>> On Thu, May 30, 2019 at 06:19:54PM -0400, Chuck Lever wrote:
> >>>> We now have trace points that can do that too.
> >>> 
> >>> You mean, that can report every error (and its value)?
> >> 
> >> Yes, the nfs_xdr_status trace point reports the error by value and
> >> symbolic name.
> > 
> > The tracepoint is very useful I agree.  I don't think it will show:
> > a) the mount
> > b) the opcode
> > 
> > Or am I mistaken and there's a way to get those with a filter or
> > another tracepoint?
> 
> The opcode can be exposed by another trace point, but the link between
> the two trace points is tenuous and could be improved.
> 
> I don't believe any of the NFS trace points expose the mount. My testing
> is largely on a single mount so my imagination stopped there.

Dumb question: is it possible to add more fields to tracepoints without
breaking some kind of backwards compatibility?

I wonder if adding, say, an xid and an xprt pointer to tracepoints when
available would help with this kind of thing.

In any case, I think Dave's stats will still be handy if only because
they're on all the time.

--b.
