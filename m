Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BE13340A9
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Mar 2021 15:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhCJOrX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Mar 2021 09:47:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230504AbhCJOrW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Mar 2021 09:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615387642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1yse06IDXDdTdrFItsyDXeTzizLR4KmSFj4+ybwtom4=;
        b=Dg4gktJhHMJi2AhJRbJ5aYPv3hO2SttFMp0Jn9HxyztalitZT4xp7XryZlfkU0/zr6PUX1
        14sV+q1EGC/l4YBwVtFR7TXQqiHKyVt68kShOJCs9ifiu7kaxed8VPjsOHcnRd/uSiCM+y
        27izNkdnTVyGvwC0/CPpCEhHN7Oftcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-Qdev7vN6MmSJvbDkV9z7mg-1; Wed, 10 Mar 2021 09:47:20 -0500
X-MC-Unique: Qdev7vN6MmSJvbDkV9z7mg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D352284BA59;
        Wed, 10 Mar 2021 14:47:18 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-114-124.rdu2.redhat.com [10.10.114.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 676D95B6A8;
        Wed, 10 Mar 2021 14:47:18 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 9D6A6120769; Wed, 10 Mar 2021 09:47:17 -0500 (EST)
Date:   Wed, 10 Mar 2021 09:47:17 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/1] NFSD: fix error handling in callbacks
Message-ID: <YEjb9ZadFqa9Vu9O@pick.fieldses.org>
References: <20210309144127.57833-1-olga.kornievskaia@gmail.com>
 <YEeWK+gs4c8O7k0u@pick.fieldses.org>
 <4ca27c770577376b0a39f0cfcfb529b96d6d5aae.camel@hammerspace.com>
 <CAN-5tyFttTHRdnELORJwCER_KPGBNk4W3eLwG0Z=QkwmPQh1UQ@mail.gmail.com>
 <d205a6a77273534666b3c33065934b9f66e7b103.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d205a6a77273534666b3c33065934b9f66e7b103.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 09, 2021 at 08:59:51PM +0000, Trond Myklebust wrote:
> On Tue, 2021-03-09 at 15:41 -0500, Olga Kornievskaia wrote:
> > On Tue, Mar 9, 2021 at 3:22 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > > 
> > > On Tue, 2021-03-09 at 10:37 -0500, J. Bruce Fields wrote:
> > > > On Tue, Mar 09, 2021 at 09:41:27AM -0500, Olga Kornievskaia
> > > > wrote:
> > > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > > > 
> > > > > When the server tries to do a callback and a client fails it
> > > > > due to
> > > > > authentication problems, we need the server to set callback
> > > > > down
> > > > > flag in RENEW so that client can recover.
> > > > 
> > > > I was looking at this.  It looks to me like this should really be
> > > > just:
> > > > 
> > > >         case 1:
> > > >                 if (task->tk_status)
> > > >                         nfsd4_mark_cb_down(clp, task->tk_status);
> > > > 
> > > > If tk_status showed an error, and the ->done method doesn't
> > > > return 0
> > > > to
> > > > tell us it something worth retrying, then the callback failed
> > > > permanently, so we should mark the callback path down, regardless
> > > > of
> > > > the
> > > > exact error.
> > > 
> > > I disagree. task->tk_status could be an unhandled NFSv4 error (see
> > > nfsd4_cb_recall_done()). The client might, for instance, be in the
> > > process of returning the delegation being recalled. Why should that
> > > result in the callback channel being marked as down?
> > > 
> > 
> > Are you talking about say the connection going down and server should
> > just reconnect instead of recovering the callback channel. I assumed
> > that connection break is something that's not  recoverable by the
> > callback but perhaps I'm wrong.
> 
> No. I'm saying that nfsd4_cb_recall_done() will return a value of '1'
> for both task->tk_status == -EBADHANDLE and -NFS4ERR_BAD_STATEID. I'm
> not seeing why either of those errors should be handled by marking the
> callback channel as being down.
> 
> Looking further, it seems that the same function will also return '1'
> without checking the value of task->tk_status if the delegation has
> been revoked or returned. So that would mean that even NFS4ERR_DELAY
> could trigger the call to nfsd4_mark_cb_down() with the above change.

Yeah, OK, that's wrong, apologies.

I'm just a little worried about the attempt to enumerate transport level
errors in nfsd4_cb_done().  Are we sure that EIO, ETIMEDOUT, EACCESS is
the right list?

--b.

> 
> > 
> > > > 
> > > > --b.
> > > > 
> > > > > 
> > > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > ---
> > > > >  fs/nfsd/nfs4callback.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > > > index 052be5bf9ef5..7325592b456e 100644
> > > > > --- a/fs/nfsd/nfs4callback.c
> > > > > +++ b/fs/nfsd/nfs4callback.c
> > > > > @@ -1189,6 +1189,7 @@ static void nfsd4_cb_done(struct rpc_task
> > > > > *task, void *calldata)
> > > > >                 switch (task->tk_status) {
> > > > >                 case -EIO:
> > > > >                 case -ETIMEDOUT:
> > > > > +               case -EACCES:
> > > > >                         nfsd4_mark_cb_down(clp, task-
> > > > > >tk_status);
> > > > >                 }
> > > > >                 break;
> > > > > --
> > > > > 2.27.0
> > > > > 
> > > > 
> > > 
> > > --
> > > Trond Myklebust
> > > Linux NFS client maintainer, Hammerspace
> > > trond.myklebust@hammerspace.com
> > > 
> > > 
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 

