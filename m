Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84743A081F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfH1RHg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 13:07:36 -0400
Received: from fieldses.org ([173.255.197.46]:49180 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1RHg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 13:07:36 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id D91F81E29; Wed, 28 Aug 2019 13:07:35 -0400 (EDT)
Date:   Wed, 28 Aug 2019 13:07:35 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Message-ID: <20190828170735.GD26284@fieldses.org>
References: <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
 <20190828134839.GA26492@fieldses.org>
 <ed2a86da204cbf644ef2dada4bda2b899da48764.camel@redhat.com>
 <45582F32-69C7-4DC8-A608-E45038A44D42@oracle.com>
 <20190828140044.GA14249@parsley.fieldses.org>
 <990B7B57-53B8-4ECB-A08B-1AFD2FCE13A6@oracle.com>
 <31658faabfbe3b4c2925bd899e264adf501fbc75.camel@redhat.com>
 <20190828144031.GB14249@parsley.fieldses.org>
 <20190828144839.GA26284@fieldses.org>
 <AAF793DB-25B7-42A5-9795-5317B5052F44@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAF793DB-25B7-42A5-9795-5317B5052F44@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 28, 2019 at 10:50:30AM -0400, Chuck Lever wrote:
> 
> 
> > On Aug 28, 2019, at 10:48 AM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Wed, Aug 28, 2019 at 10:40:31AM -0400, J. Bruce Fields wrote:
> >> On Wed, Aug 28, 2019 at 10:16:09AM -0400, Jeff Layton wrote:
> >>> For the most part, these sorts of errors tend to be rare. If it turns
> >>> out to be a problem we could consider moving the verifier into
> >>> svc_export or something?
> >> 
> >> As Trond says, this isn't really a server implementation issue, it's a
> >> protocol issue.  If a client detects when to resend writes by storing a
> >> single verifier per server, then returning different verifiers from
> >> writes to different exports will have it resending every time it writes
> >> to one export then another.
> > 
> > The other way to limit this is by trying to detect the single-writer
> > case, since it's probably also rare for multiple clients to write to the
> > same file.
> > 
> > Are there any common cases where two clients share the same TCP
> > connection?  Maybe that would be a conservative enough test?
> 
> What happens if a client reconnects? Does that bump the verifier?
> 
> If it reconnects from the same source port, can the server tell
> that the connection is different?

I assume it creates a new socket structure.

So, you could key off either that or the (address, port) depending on
whether you'd rather risk unnecessarily incrementing the verifier after
a reconnection and write error, or risk failing to increment due to port
reuse.

There's some precedent to taking the latter choice in the DRC.  But the
DRC also includes some other stuff (xid, hash) to minimize the chance of
a collision.

If you took the former choice you wouldn't literally want to key off a
pointer to the socket as it'd cause complications when freeing the
socket.  But maybe you could add some kind of birth time or generation
number to struct svc_sock to help differentiate?

--b.

> 
> 
> > And you wouldn't have to track every connection that's ever sent a WRITE
> > to a given file.  Just remember the first one, with a flag to track
> > whether anyone else has ever written to it.
> > 
> > ??
> > 
> > --b.
> 
> --
> Chuck Lever
> 
> 
