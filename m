Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D52FFE7
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2019 20:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfD3SqQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Apr 2019 14:46:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfD3SqQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 30 Apr 2019 14:46:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D77E308330B;
        Tue, 30 Apr 2019 18:46:15 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-85.rdu2.redhat.com [10.10.122.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56E2E183A9;
        Tue, 30 Apr 2019 18:46:15 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id B096321BE8; Tue, 30 Apr 2019 14:46:14 -0400 (EDT)
Date:   Tue, 30 Apr 2019 14:46:14 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: CB_RECALL can race with FREE_STATEID
Message-ID: <20190430184614.GF15226@coeurl.usersys.redhat.com>
References: <20190418132400.24161-1-smayhew@redhat.com>
 <20190418151312.GB29274@fieldses.org>
 <20190418205024.GB15226@coeurl.usersys.redhat.com>
 <15806b00f7ba569a109549eb551bb116d981226d.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15806b00f7ba569a109549eb551bb116d981226d.camel@hammerspace.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 30 Apr 2019 18:46:15 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 18 Apr 2019, Trond Myklebust wrote:

> On Thu, 2019-04-18 at 16:50 -0400, Scott Mayhew wrote:
> > On Thu, 18 Apr 2019, J. Bruce Fields wrote:
> > 
> > > On Thu, Apr 18, 2019 at 09:24:00AM -0400, Scott Mayhew wrote:
> > > > While trying to track down some issues involving large numbers of
> > > > delegations being recalled/revoked, I caught the server setting
> > > > SEQ4_STATUS_CB_PATH_DOWN while the client was actively responding
> > > > to
> > > > CB_RECALLs.  It turns out that the client had already done a
> > > > TEST_STATEID and FREE_STATEID for a delegation being recalled by
> > > > the
> > > > time it received the CB_RECALL.
> > > 
> > > That's interesting, thanks!
> > > 
> > > This exception seems awfully narrow, though.
> > > 
> > > If we get back any NFS-level error at all, then I think the
> > > callback
> > > channel is working (am I wrong?)
> > 
> > Correct, if the client replies with either NFS4ERR_DELAY or
> > NFS4ERR_BAD_STATEID, the server will retry 1 time (see dl_retries).
> > After that, we fall thru and nfsd4_cb_recall_done() returns -1 which
> > causes the SEQ4_STATUS_CB_PATH_DOWN flag to be set.
> 
> There is no handling of NFS4ERR_DELAY in nfsd4_cb_recall_done().
> 
> As far as I can see, therefore, if the client returns NFS4ERR_DELAY
> (which it usually does if it is already in the process of returning the
> delegation) then the recall will fail immediately.

You're right, I had NFS4ERR_DELAY on the brain because I was seeing
those periodically in conjunction with the BIND_CONN_TO_SESSION calls
that were occurring while handling the bogus CB_PATH_DOWN flags from the
server.

-Scott
> 
> > > and telling the client to set up a new
> > > one is probably not going to help.  The best we can do is probably
> > > just
> > > give up
> > 
> > That's what the patch is essentially doing.  Or are you saying don't
> > even bother with the checks but still return 1 so we don't set the
> > SEQ4_STATUS_CB_PATH_DOWN flag?
> > 
> > > and let the client deal with the ensuing
> > > RECALLABLE_STATE_REVOKED flag.
> > 
> > The client's already dealing with the RECALLABLE_STATE_REVOKED flag,
> > that's why it sent a TEST_STATEID and FREE_STATEID before it got this
> > particular CB_RECALL.  The idea behind the patch is to not give the
> > state manager on the client additional work by setting CB_PATH_DOWN
> > when
> > the callback channel is clearly working...
> > 
> 
> Either way, the Linux client will ignore any further sequence flags
> until it is done with the recovery of the RECALLABLE_STATE_REVOKED
> flag. The reason is that the flags are edge triggered (i.e. they don't
> clear until the state changes), and so we need to be able to perform a
> full recovery before we can check them again.
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
