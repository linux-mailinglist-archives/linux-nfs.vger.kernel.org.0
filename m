Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54CAEFFE3
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2019 20:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfD3SoQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Apr 2019 14:44:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfD3SoQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 30 Apr 2019 14:44:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E827D356E7;
        Tue, 30 Apr 2019 18:44:15 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-85.rdu2.redhat.com [10.10.122.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF65C438A;
        Tue, 30 Apr 2019 18:44:14 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 1FE1D21BE8; Tue, 30 Apr 2019 14:44:14 -0400 (EDT)
Date:   Tue, 30 Apr 2019 14:44:14 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Question about open(CLAIM_FH)
Message-ID: <20190430184414.GE15226@coeurl.usersys.redhat.com>
References: <20190418133728.GS3773@coeurl.usersys.redhat.com>
 <213d4ead8a7ae890dadc7785d59117e798f94748.camel@hammerspace.com>
 <20190418204356.GA15226@coeurl.usersys.redhat.com>
 <4751d341a626cf26e60e0b8c3564171c115c1335.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4751d341a626cf26e60e0b8c3564171c115c1335.camel@hammerspace.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 30 Apr 2019 18:44:16 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 18 Apr 2019, Trond Myklebust wrote:

> On Thu, 2019-04-18 at 16:43 -0400, Scott Mayhew wrote:
> > On Thu, 18 Apr 2019, Trond Myklebust wrote:
> > 
> > > Hi Scott,
> > > 
> > > On Thu, 2019-04-18 at 09:37 -0400, Scott Mayhew wrote:
> > > > When the client does an open(CLAIM_FH) and the server already has
> > > > open
> > > > state for that open owner and file, what's supposed to happen?
> > > > Currently the server returns the existing stateid with the seqid
> > > > bumped,
> > > > but it looks like the client is expecting a new stateid (I'm
> > > > seeing
> > > > the
> > > > state manager spending a lot of time waiting in
> > > > nfs_set_open_stateid_locked() due to NFS_STATE_CHANGE_WAIT being
> > > > set
> > > > in
> > > > the state flags by nfs_need_update_open_stateid()).
> > > > 
> > > > Looking at rfc5661 section 18.16.3, I see:
> > > > 
> > > >    | CLAIM_NULL, CLAIM_FH | For the client, this is a new OPEN
> > > > request |
> > > >    |                      | and there is no previous state
> > > > associated  |
> > > >    |                      | with the file for the
> > > > client.  With        |
> > > >    |                      | CLAIM_NULL, the file is identified by
> > > > the  |
> > > >    |                      | current filehandle and the
> > > > specified       |
> > > >    |                      | component name.  With CLAIM_FH (new
> > > > to     |
> > > >    |                      | NFSv4.1), the file is identified by
> > > > just   |
> > > >    |                      | the current filehandle.  
> > > > 
> > > > So it seems like maybe the server should be tossing the old state
> > > > and
> > > > returning a new stateid?
> > > > 
> > > 
> > > No. As far as the protocol is concerned, the only difference
> > > between
> > > CLAIM_NULL and CLAIM_FH is through how the client identifies the
> > > file
> > > (in the first case, through an implicit lookup, and in the second
> > > case
> > > through a file handle). The client should be free to intermix the
> > > two
> > > types of OPEN, and it should expect the resulting stateids to
> > > depend
> > > only on whether or not the open_owner matches. If the open_owner
> > > matches an existing stateid, then that stateid is bumped and
> > > returned.
> > > 
> > > I'm not aware of any expectation in the client that this should not
> > > be
> > > the case, so if you are seeing different behaviour, then something
> > > else
> > > must be at work here. Is the client perhaps mounting the same
> > > filesystem in two different places in such a way that the super
> > > block
> > > is not being shared?
> > 
> > No, it's just a single 4.1 mount w/ the default mount options.
> > 
> > For a bit of background, I've been trying to track down a problem in
> > RHEL where the SEQ4_STATUS_RECALLABLE_STATE_REVOKED flags is getting
> > permanently set because the nfs4_client->cl_revoked list on the
> > server
> > is non-empty... yet there's no longer open state on the client. 
> > 
> > I can reproduce it pretty easily in RHEL using 2 VMs, each with 2-4
> > CPUs
> > and 4-8G of memory.  The server has 64 nfsd threads and a 15 second
> > lease time.
> > 
> > On the client I'm running the following to add a 10ms delay to
> > CB_RECALL
> > replies:
> > # stap -gve 'global count = 0; probe
> > module("nfsv4").function("nfs4_callback_recall") { printf("%s: %d\n",
> > ppfunc(), ++count); mdelay(10); }'
> > 
> > then in another window I open a bunch of files:
> > # for i in `seq -w 1 5000`; do sleep 2m </mnt/t/dir1/file.$i & done
> > 
> > (Note: I already created the files ahead of time)
> > 
> > As soon as the bash prompt returns on the client, I run the following
> > on
> > the server:
> > # for i in `seq -w 1 5000`; do date >/export/dir1/file.$i & done
> > 
> > At that point, any further SEQUENCE ops will have the recallable
> > state
> > revoked flag set on the client until the fs is unmounted.
> > 
> > If I run the same steps on Fedora clients with recent kernels, I
> > don't
> > have the problem with the recallable state revoked flag, but I'm
> > getting
> > some other strangeness.  Everything starts out fine with
> > nfs_reap_expired_delegations() doing TEST_STATEID and FREE_STATEID,
> > but
> > once the state manager starts callings nfs41_open_expired(), things
> > sort
> > of grind to a halt and I see 1 OPEN and 1 or 2 TEST_STATEID ops every
> > 5
> > seconds in wireshark.  It stays that way until the files are closed
> > on
> > the client, when I see a slew of DELEGRETURNs and FREE_STATEIDs...
> > but
> > I'm only seeing 3 or 4 CLOSE ops.  If I poke around in crash on the
> > server, I see a ton of open stateids:
> > 
> > crash> epython fs/nfsd/print-client-state-info.py
> > nfsd_net = 0xffff93e473511000
> >         nfs4_client = 0xffff93e3f7954980
> >                 nfs4_stateowner = 0xffff93e4058cc360 num_stateids =
> > 4997 <---- only 3 CLOSE ops were received
> >                 num_openowners = 1
> >                 num_layouts = 0
> >                 num_delegations = 0
> >                 num_sessions = 1
> >                 num_copies = 0
> >                 num_revoked = 0
> >                 cl_cb_waitq_qlen = 0
> > 
> > Those stateids stick around until the fs is unmounted (and the
> > DESTROY_STATEID ops return NFS4ERR_CLIENTID_BUSY while doing so).
> > 
> > Both VMs are running 5.0.6-200.fc29.x86_64, but the server also has
> > the
> > "nfsd: Don't release the callback slot unless it was actually held"
> > patch you sent a few weeks ago as well as the "nfsd: CB_RECALL can
> > race
> > with FREE_STATEID" patch I sent today.
> 
> Are the calls to nfs41_open_expired() succeeding? It sounds like they
> might not be.

They're succeeding, they're just taking 5 seconds each. 

To make matters worse, due to the aggressive lease time on the server,
the client was doing a SEQUENCE op periodically while the OPENs were
occurring.  The SEQUENCE replies also had the RECALLABLE_STATE_REVOKED
flag set, and since they weren't coming from the state manager the
nfs4_slot->privileged field was unset, so we'd wind up calling
nfs41_handle_recallable_state_revoked() again, undoing what little
progress was made.  Bumping the lease time to 20 seconds made that go
away, but the overall problem is still there.

Is it really necessary for nfs41_handle_recallable_state_revoked() to
mark all open state as needing recovery?  After all, the only state that
can be revoked are layouts and delegations.  If I change
nfs41_handle_recallable_state_revoked(), so that instead of calling
nfs41_handle_some_state_revoked() we instead call
nfs_mark_test_expired_all_delegations() and
nfs4_schedule_state_manager(), then the problem seems to go away.

-Scott

> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
