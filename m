Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E622A03F5
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 16:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfH1OAq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 10:00:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1OAq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 10:00:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B29758980EA;
        Wed, 28 Aug 2019 14:00:45 +0000 (UTC)
Received: from parsley.fieldses.org (ovpn-125-160.rdu2.redhat.com [10.10.125.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C6736012C;
        Wed, 28 Aug 2019 14:00:45 +0000 (UTC)
Received: by parsley.fieldses.org (Postfix, from userid 2815)
        id 370F518046C; Wed, 28 Aug 2019 10:00:44 -0400 (EDT)
Date:   Wed, 28 Aug 2019 10:00:44 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Message-ID: <20190828140044.GA14249@parsley.fieldses.org>
References: <20190826205156.GA27834@fieldses.org>
 <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
 <61F77AD6-BD02-4322-B944-0DC263EB9BD8@oracle.com>
 <ec7a06f8e74867e65c26580e8504e2879f4cd595.camel@hammerspace.com>
 <20190827145819.GB9804@fieldses.org>
 <20190827145912.GC9804@fieldses.org>
 <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
 <20190828134839.GA26492@fieldses.org>
 <ed2a86da204cbf644ef2dada4bda2b899da48764.camel@redhat.com>
 <45582F32-69C7-4DC8-A608-E45038A44D42@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45582F32-69C7-4DC8-A608-E45038A44D42@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Wed, 28 Aug 2019 14:00:45 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 28, 2019 at 09:57:25AM -0400, Chuck Lever wrote:
> 
> 
> > On Aug 28, 2019, at 9:51 AM, Jeff Layton <jlayton@redhat.com> wrote:
> > 
> > On Wed, 2019-08-28 at 09:48 -0400, bfields@fieldses.org wrote:
> >> On Tue, Aug 27, 2019 at 03:15:35PM +0000, Trond Myklebust wrote:
> >>> I'm open to other suggestions, but I'm having trouble finding one that
> >>> can scale correctly (i.e. not require per-client tracking), prevent
> >>> silent corruption (by causing clients to miss errors), while not
> >>> relying on optional features that may not be implemented by all NFSv3
> >>> clients (e.g. per-file write verifiers are not implemented by *BSD).
> >>> 
> >>> That said, it seems to me that to do nothing should not be an option,
> >>> as that would imply tolerating silent corruption of file data.
> >> 
> >> So should we increment the boot verifier every time we discover an error
> >> on an asynchronous write?
> >> 
> > 
> > I think so. Otherwise, only one client will ever see that error.
> 
> +1
> 
> I'm not familiar with the details of how the Linux NFS server
> implements the boot verifier: Will a verifier bump be effective
> for all file systems that server exports?

Yes.  It will be per network namespace, but that's the only limit.

> If so, is that an acceptable cost?

It means clients will resend all their uncommitted writes.  That could
certainly make write errors more expensive.  But maybe you've already
got bigger problems if you've got a full or failing disk?

--b.
