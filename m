Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A4FFFD
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2019 20:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfD3S6x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Apr 2019 14:58:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfD3S6x (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 30 Apr 2019 14:58:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F1213084266;
        Tue, 30 Apr 2019 18:58:52 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-85.rdu2.redhat.com [10.10.122.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68B466248E;
        Tue, 30 Apr 2019 18:58:52 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id CC74721BE8; Tue, 30 Apr 2019 14:58:45 -0400 (EDT)
Date:   Tue, 30 Apr 2019 14:58:45 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: CB_RECALL can race with FREE_STATEID
Message-ID: <20190430185845.GG15226@coeurl.usersys.redhat.com>
References: <20190418132400.24161-1-smayhew@redhat.com>
 <20190418151312.GB29274@fieldses.org>
 <20190418205024.GB15226@coeurl.usersys.redhat.com>
 <20190418213730.GA1891@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418213730.GA1891@fieldses.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 30 Apr 2019 18:58:52 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 18 Apr 2019, J. Bruce Fields wrote:

> On Thu, Apr 18, 2019 at 04:50:24PM -0400, Scott Mayhew wrote:
> > On Thu, 18 Apr 2019, J. Bruce Fields wrote:
> > 
> > > On Thu, Apr 18, 2019 at 09:24:00AM -0400, Scott Mayhew wrote:
> > > > While trying to track down some issues involving large numbers of
> > > > delegations being recalled/revoked, I caught the server setting
> > > > SEQ4_STATUS_CB_PATH_DOWN while the client was actively responding to
> > > > CB_RECALLs.  It turns out that the client had already done a
> > > > TEST_STATEID and FREE_STATEID for a delegation being recalled by the
> > > > time it received the CB_RECALL.
> > > 
> > > That's interesting, thanks!
> > > 
> > > This exception seems awfully narrow, though.
> > > 
> > > If we get back any NFS-level error at all, then I think the callback
> > > channel is working (am I wrong?)
> > 
> > Correct, if the client replies with either NFS4ERR_DELAY or
> > NFS4ERR_BAD_STATEID, the server will retry 1 time (see dl_retries).
> > After that, we fall thru and nfsd4_cb_recall_done() returns -1 which
> > causes the SEQ4_STATUS_CB_PATH_DOWN flag to be set.
> > 
> > > and telling the client to set up a new
> > > one is probably not going to help.  The best we can do is probably just
> > > give up
> > 
> > That's what the patch is essentially doing.  Or are you saying don't
> > even bother with the checks but still return 1 so we don't set the
> > SEQ4_STATUS_CB_PATH_DOWN flag?
> 
> Right, I don't see any point returning -1 (which ends up setting
> CB_PATH_DOWN) in any case where we get an nfs-level error.  If the
> client got so far as returning an error, then the callback path is
> working.
> 
> I'm not sure exactly what errors *should* result in CB_PATH_DOWN,
> though.  ETIMEDOUT, ENOTCONN, EIO?

I'm not sure either.  Looking at
call_status/call_timeout/rpc_check_timeout, it looks to me like ENOTCONN
will be translated to ETIMEDOUT because nfsd4_run_cb_work sets the 
RPC_TASK_SOFTCONN flag in the call to rpc_call_async.

It looks like call_status can return EHOSTDOWN, ENETDOWN, EHOSTUNREACH,
ENETUNREACH, and EPERM... should those be handled as well?

-Scott

> And maybe we should be checking for
> those in nfsd4_cb_done, and do away with the convention that -1 means
> CB_PATH_DOWN.  I don't think there's a reason individual callback ops
> would need different rules for when to mark the callback channel down.
> 
> --b.
> 
> > 
> > > and let the client deal with the ensuing
> > > RECALLABLE_STATE_REVOKED flag.
> > 
> > The client's already dealing with the RECALLABLE_STATE_REVOKED flag,
> > that's why it sent a TEST_STATEID and FREE_STATEID before it got this
> > particular CB_RECALL.  The idea behind the patch is to not give the
> > state manager on the client additional work by setting CB_PATH_DOWN when
> > the callback channel is clearly working...
> > 
> > -Scott
> > > 
> > > --b.
> > > 
> > > > 
> > > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > > ---
> > > >  fs/nfsd/nfs4state.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index 6a45fb00c5fc..e88e429133a8 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -3958,6 +3958,14 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
> > > >  			rpc_delay(task, 2 * HZ);
> > > >  			return 0;
> > > >  		}
> > > > +		/*
> > > > +		 * Race: client may have done a FREE_STATEID before
> > > > +		 * receiving the CB_RECALL.
> > > > +		 */
> > > > +		if (dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID &&
> > > > +				refcount_read(&dp->dl_stid.sc_count) == 1 &&
> > > > +				list_empty(&dp->dl_recall_lru))
> > > > +			return 1;
> > > >  		/*FALLTHRU*/
> > > >  	default:
> > > >  		return -1;
> > > > -- 
> > > > 2.17.2
