Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA409EB9D
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 16:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbfH0Oy7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Aug 2019 10:54:59 -0400
Received: from fieldses.org ([173.255.197.46]:47754 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfH0Oy5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Aug 2019 10:54:57 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 9AC7684A; Tue, 27 Aug 2019 10:54:56 -0400 (EDT)
Date:   Tue, 27 Aug 2019 10:54:56 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Jeff Layton <jlayton@poochiereds.net>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Message-ID: <20190827145456.GA9804@fieldses.org>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
 <20190826205156.GA27834@fieldses.org>
 <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
 <61F77AD6-BD02-4322-B944-0DC263EB9BD8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61F77AD6-BD02-4322-B944-0DC263EB9BD8@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 27, 2019 at 09:59:25AM -0400, Chuck Lever wrote:
> The strategy of handling these errors more carefully seems good.
> Bumping the write/commit verifier so the client writes again to
> retrieve the latent error is clever!
> 
> It's not clear to me though that the NFSv3 protocol can deal with
> the multi-client write scenario, since it is stateless. We are now
> making it stateful in some sense by preserving error state on the
> server across NFS requests, without having any sense of an open
> file in the protocol itself.
> 
> Would an "approximation" without open state be good enough?

I figure there's a correct-but-slow approach which is to increment the
write verifier every time there's a write error.  Does that work?  If
write errors are rare enough, maybe it doesn't matter that that's slow?

Then there's various approximations you could use (IP address?) to guess
when only one client's accessing the file.  You save forcing all the
clients to resend writes at the expense of some complexity and
correctness--e.g., multiple clients behind NAT might not all get write
errors.

Am I thinking aobut this right?

--b.
