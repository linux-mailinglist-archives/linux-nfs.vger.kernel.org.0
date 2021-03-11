Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F3133764E
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Mar 2021 15:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhCKO6l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Mar 2021 09:58:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233958AbhCKO6d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Mar 2021 09:58:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615474712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dnOkybMhuFH3yNEufwmFGOEIUcqakUYVWHwF79JbOIA=;
        b=M+dkLKeGB4Y+0v578iB94SV2F6bEzJoleb3n9D2E931YmtsPRjLg6R4GYb+hCl1S468b9d
        pBiSPHLBG/R9u3XdgpBVkrJ21as3WfYOcwur0Brk52M6zs/wuvsdSCaAoDxShhXxEYNqmO
        AwQOk4hY6OGRy4iH8k9NK73xitkXD9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-vmE4r3_ENwa9LRzR_lZjLQ-1; Thu, 11 Mar 2021 09:58:27 -0500
X-MC-Unique: vmE4r3_ENwa9LRzR_lZjLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92523107ACCA;
        Thu, 11 Mar 2021 14:58:26 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-114-209.rdu2.redhat.com [10.10.114.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02ADC60C03;
        Thu, 11 Mar 2021 14:58:26 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 2669412077D; Thu, 11 Mar 2021 09:58:25 -0500 (EST)
Date:   Thu, 11 Mar 2021 09:58:25 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/1] NFSD: fix error handling in callbacks
Message-ID: <YEowERpnfmBd9HpH@pick.fieldses.org>
References: <20210309144127.57833-1-olga.kornievskaia@gmail.com>
 <YEeWK+gs4c8O7k0u@pick.fieldses.org>
 <4ca27c770577376b0a39f0cfcfb529b96d6d5aae.camel@hammerspace.com>
 <CAN-5tyFttTHRdnELORJwCER_KPGBNk4W3eLwG0Z=QkwmPQh1UQ@mail.gmail.com>
 <d205a6a77273534666b3c33065934b9f66e7b103.camel@hammerspace.com>
 <YEjb9ZadFqa9Vu9O@pick.fieldses.org>
 <CAN-5tyFZ8fS6fjOJEu2NkRYUX6HrA5XNKPWyWN+UVtQT6Gp4kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyFZ8fS6fjOJEu2NkRYUX6HrA5XNKPWyWN+UVtQT6Gp4kQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 10, 2021 at 05:09:20PM -0500, Olga Kornievskaia wrote:
> On Wed, Mar 10, 2021 at 9:47 AM J. Bruce Fields <bfields@redhat.com> wrote:
> >
> > On Tue, Mar 09, 2021 at 08:59:51PM +0000, Trond Myklebust wrote:
> > > On Tue, 2021-03-09 at 15:41 -0500, Olga Kornievskaia wrote:
> > > > On Tue, Mar 9, 2021 at 3:22 PM Trond Myklebust <
> > > > trondmy@hammerspace.com> wrote:
> > > > >
> > > > > On Tue, 2021-03-09 at 10:37 -0500, J. Bruce Fields wrote:
> > > > > > On Tue, Mar 09, 2021 at 09:41:27AM -0500, Olga Kornievskaia
> > > > > > wrote:
> > > > > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > > > > >
> > > > > > > When the server tries to do a callback and a client fails it
> > > > > > > due to
> > > > > > > authentication problems, we need the server to set callback
> > > > > > > down
> > > > > > > flag in RENEW so that client can recover.
> > > > > >
> > > > > > I was looking at this.  It looks to me like this should really be
> > > > > > just:
> > > > > >
> > > > > >         case 1:
> > > > > >                 if (task->tk_status)
> > > > > >                         nfsd4_mark_cb_down(clp, task->tk_status);
> > > > > >
> > > > > > If tk_status showed an error, and the ->done method doesn't
> > > > > > return 0
> > > > > > to
> > > > > > tell us it something worth retrying, then the callback failed
> > > > > > permanently, so we should mark the callback path down, regardless
> > > > > > of
> > > > > > the
> > > > > > exact error.
> > > > >
> > > > > I disagree. task->tk_status could be an unhandled NFSv4 error (see
> > > > > nfsd4_cb_recall_done()). The client might, for instance, be in the
> > > > > process of returning the delegation being recalled. Why should that
> > > > > result in the callback channel being marked as down?
> > > > >
> > > >
> > > > Are you talking about say the connection going down and server should
> > > > just reconnect instead of recovering the callback channel. I assumed
> > > > that connection break is something that's not  recoverable by the
> > > > callback but perhaps I'm wrong.
> > >
> > > No. I'm saying that nfsd4_cb_recall_done() will return a value of '1'
> > > for both task->tk_status == -EBADHANDLE and -NFS4ERR_BAD_STATEID. I'm
> > > not seeing why either of those errors should be handled by marking the
> > > callback channel as being down.
> > >
> > > Looking further, it seems that the same function will also return '1'
> > > without checking the value of task->tk_status if the delegation has
> > > been revoked or returned. So that would mean that even NFS4ERR_DELAY
> > > could trigger the call to nfsd4_mark_cb_down() with the above change.
> >
> > Yeah, OK, that's wrong, apologies.
> >
> > I'm just a little worried about the attempt to enumerate transport level
> > errors in nfsd4_cb_done().  Are we sure that EIO, ETIMEDOUT, EACCESS is
> > the right list?
> 
> Looking at call_transmit_status error handling, I don't think
> connection errors are returned. Instead the code tries to fix the
> connection by retrying unless the rpc_timeout is reached and then only
> EIO,TIMEDOUT is returned.
> 
> Can then my original patch be considered without resubmission?

Sure, thanks for checking that.

--b.

> 
> >
> > --b.
> >
> > >
> > > >
> > > > > >
> > > > > > --b.
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > > > ---
> > > > > > >  fs/nfsd/nfs4callback.c | 1 +
> > > > > > >  1 file changed, 1 insertion(+)
> > > > > > >
> > > > > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > > > > > index 052be5bf9ef5..7325592b456e 100644
> > > > > > > --- a/fs/nfsd/nfs4callback.c
> > > > > > > +++ b/fs/nfsd/nfs4callback.c
> > > > > > > @@ -1189,6 +1189,7 @@ static void nfsd4_cb_done(struct rpc_task
> > > > > > > *task, void *calldata)
> > > > > > >                 switch (task->tk_status) {
> > > > > > >                 case -EIO:
> > > > > > >                 case -ETIMEDOUT:
> > > > > > > +               case -EACCES:
> > > > > > >                         nfsd4_mark_cb_down(clp, task-
> > > > > > > >tk_status);
> > > > > > >                 }
> > > > > > >                 break;
> > > > > > > --
> > > > > > > 2.27.0
> > > > > > >
> > > > > >
> > > > >
> > > > > --
> > > > > Trond Myklebust
> > > > > Linux NFS client maintainer, Hammerspace
> > > > > trond.myklebust@hammerspace.com
> > > > >
> > > > >
> > >
> > > --
> > > Trond Myklebust
> > > Linux NFS client maintainer, Hammerspace
> > > trond.myklebust@hammerspace.com
> > >
> > >
> >
> 

