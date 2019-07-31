Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E5D7C0C0
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jul 2019 14:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfGaMHz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Jul 2019 08:07:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22311 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfGaMHz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 31 Jul 2019 08:07:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA89630BA078;
        Wed, 31 Jul 2019 12:07:54 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-120-110.rdu2.redhat.com [10.10.120.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 409DD5D6B2;
        Wed, 31 Jul 2019 12:07:53 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 8E7FE20BD0; Wed, 31 Jul 2019 08:07:53 -0400 (EDT)
Date:   Wed, 31 Jul 2019 08:07:53 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] nfsd: add principal to the data being tracked by
 nfsdcld
Message-ID: <20190731120753.GP4131@coeurl.usersys.redhat.com>
References: <20190730210847.9804-1-smayhew@redhat.com>
 <20190730215428.GB3544@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730215428.GB3544@fieldses.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 31 Jul 2019 12:07:54 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 30 Jul 2019, J. Bruce Fields wrote:

> On Tue, Jul 30, 2019 at 05:08:45PM -0400, Scott Mayhew wrote:
> > At the spring bakeathon, Chuck suggested that we should store the
> > kerberos principal in addition to the client id string in nfsdcld.  The
> > idea is to prevent an illegitimate client from reclaiming another
> > client's opens by supplying that client's id string.  This is an initial
> > attempt at doing that.
> 
> Great to see this, thanks!
> 
> > Initially I had played with the idea of hanging a version number off
> > either the cld_net or nfsd_net structure, exposing that via a proc file,
> > and having the userspace daemon write the desired version number to the
> > proc file prior to opening the rpc_pipefs file.  That was potentially
> > problematic if nfsd was already trying to queue an upcall using a
> > version that nfscld didn't support... so I like the GetVersion upcall
> > idea better.
> 
> Sounds OK to me.
> 
> It queries the version once on nfsd startup and sticks with that
> version.  We allow rpc.mountd to be restarted while nfsd is running.  So
> the one case I think it wouldn't handle is the case where somebody
> downgrades mountd while nfsd is running.

I'm assuming you meant nfsdcld rather than mountd here... currently if
someone were to downgrade nfsdcld while nfsd is running then that case
wouldn't be handled, so a restart of nfsd would also be necessary.

> 
> My feeling is that handling that case would be way too much trouble, so
> actually I'm going to consider that a plus.  But it might be worth
> documenting (if only in a patch changelog).
> 
To handle that scenario, We'd need to change the database schema.  I'd
really rather do that in an external script than stick downgrade logic
into nfsdcld... mainly because I'd want to check if there was any data
in the columns being eliminated and warn the user & ask for
confirmation.  

We'd also need to change how nfsdcld reacts when it gets a message
version it doesn't support.  Currently it just reopens the pipe file,
which causes the upcall to fail with -EAGAIN, which causes nfsd to retry
the upcall, and it just goes into a loop.  I could implement a "version
not supported" downcall.  I'm not sure what error number to use... maybe
-EPROTONOSUPP?  Also even if we implemented a "version not supported"
downcall now, that wouldn't handle the problem with existing nfsdcld's.
The only thing I can think of there is to add a counter to
cld_pipe_upcall() and exit the loop after a certain number of iterations
(10? 100? 1000?).

> > The second patch actually adds the v2 message, which adds the principal
> > (actually just the first 1024 bytes) to the Cld_Create upcall and to the 
> > Cld_GraceStart downcall (which is what loads the data in the
> > reclaim_str_hashtbl). I couldn't really figure out what the maximum length
> > of a kerberos principal actually is (looking at krb5.h the length field in
> > the struct krb5_data is an unsigned int, so I guess it can be pretty big).
> > I don't think the principal will be that large in practice, and even if
> > it is the first 1024 bytes should be sufficient for our purposes.
> 
> How does it fail when principals are longer?  Does it error out, or
> treat two principals as equal if they agree in the first 1024 bytes?

It treats them as equal.

> 
> --b.
