Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C811838
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2019 13:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfEBLfC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 May 2019 07:35:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfEBLfC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 May 2019 07:35:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1A993078A1F;
        Thu,  2 May 2019 11:35:01 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-85.rdu2.redhat.com [10.10.122.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 795245DA34;
        Thu,  2 May 2019 11:35:01 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id CC5E9211FD; Thu,  2 May 2019 07:35:00 -0400 (EDT)
Date:   Thu, 2 May 2019 07:35:00 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: CB_RECALL can race with FREE_STATEID
Message-ID: <20190502113500.GH15226@coeurl.usersys.redhat.com>
References: <20190418132400.24161-1-smayhew@redhat.com>
 <20190418151312.GB29274@fieldses.org>
 <20190418205024.GB15226@coeurl.usersys.redhat.com>
 <20190418213730.GA1891@fieldses.org>
 <20190430185845.GG15226@coeurl.usersys.redhat.com>
 <5ef90bd5ac79236458ffa04b7eb1d7812431859f.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ef90bd5ac79236458ffa04b7eb1d7812431859f.camel@hammerspace.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 02 May 2019 11:35:01 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 30 Apr 2019, Trond Myklebust wrote:

> On Tue, 2019-04-30 at 14:58 -0400, Scott Mayhew wrote:
> > On Thu, 18 Apr 2019, J. Bruce Fields wrote:
> > 
> > > On Thu, Apr 18, 2019 at 04:50:24PM -0400, Scott Mayhew wrote:
> > > > On Thu, 18 Apr 2019, J. Bruce Fields wrote:
> > > > 
> > > > > On Thu, Apr 18, 2019 at 09:24:00AM -0400, Scott Mayhew wrote:
> > > > > > While trying to track down some issues involving large
> > > > > > numbers of
> > > > > > delegations being recalled/revoked, I caught the server
> > > > > > setting
> > > > > > SEQ4_STATUS_CB_PATH_DOWN while the client was actively
> > > > > > responding to
> > > > > > CB_RECALLs.  It turns out that the client had already done a
> > > > > > TEST_STATEID and FREE_STATEID for a delegation being recalled
> > > > > > by the
> > > > > > time it received the CB_RECALL.
> > > > > 
> > > > > That's interesting, thanks!
> > > > > 
> > > > > This exception seems awfully narrow, though.
> > > > > 
> > > > > If we get back any NFS-level error at all, then I think the
> > > > > callback
> > > > > channel is working (am I wrong?)
> > > > 
> > > > Correct, if the client replies with either NFS4ERR_DELAY or
> > > > NFS4ERR_BAD_STATEID, the server will retry 1 time (see
> > > > dl_retries).
> > > > After that, we fall thru and nfsd4_cb_recall_done() returns -1
> > > > which
> > > > causes the SEQ4_STATUS_CB_PATH_DOWN flag to be set.
> > > > 
> > > > > and telling the client to set up a new
> > > > > one is probably not going to help.  The best we can do is
> > > > > probably just
> > > > > give up
> > > > 
> > > > That's what the patch is essentially doing.  Or are you saying
> > > > don't
> > > > even bother with the checks but still return 1 so we don't set
> > > > the
> > > > SEQ4_STATUS_CB_PATH_DOWN flag?
> > > 
> > > Right, I don't see any point returning -1 (which ends up setting
> > > CB_PATH_DOWN) in any case where we get an nfs-level error.  If the
> > > client got so far as returning an error, then the callback path is
> > > working.
> > > 
> > > I'm not sure exactly what errors *should* result in CB_PATH_DOWN,
> > > though.  ETIMEDOUT, ENOTCONN, EIO?
> > 
> > I'm not sure either.  Looking at
> > call_status/call_timeout/rpc_check_timeout, it looks to me like
> > ENOTCONN
> > will be translated to ETIMEDOUT because nfsd4_run_cb_work sets the 
> > RPC_TASK_SOFTCONN flag in the call to rpc_call_async.
> > 
> > It looks like call_status can return EHOSTDOWN, ENETDOWN,
> > EHOSTUNREACH,
> > ENETUNREACH, and EPERM... should those be handled as well?
> 
> Those errors should never be passed back to applications.

I'm confused.  If call_status passes any of those errors to rpc_exit,
then I'll see them in rpc_call_done/nfsd4_cb_done, won't I?

-Scott

> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
