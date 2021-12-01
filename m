Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A844655A1
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Dec 2021 19:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbhLASkc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Dec 2021 13:40:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20820 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238768AbhLASk0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Dec 2021 13:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638383821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qdlXIL1oxqSEL+ebyFN2jLlKbWWYDq0EPV7e1T8jiiY=;
        b=DjWmyGr8+wrSJWKX+EhYeMvtLwIuKyt0sC+z7kBA49syOjFEM5uUMgJkpQ15jlpxvCSIFJ
        wmnHvQeysm7mTdUW545Ay+J68DlwWUFDEqaulYCSEM1GPavVEEFc90iIyIxpGvYxFYD42q
        f/PTWZ+l8YZ2JKol2KngOVHacnz6vB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-xS6-1ofzO7ykuBMgx6GhKA-1; Wed, 01 Dec 2021 13:37:00 -0500
X-MC-Unique: xS6-1ofzO7ykuBMgx6GhKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A453E801B00;
        Wed,  1 Dec 2021 18:36:58 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.16.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B6B35C22B;
        Wed,  1 Dec 2021 18:36:57 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 18D141A0032; Wed,  1 Dec 2021 13:36:57 -0500 (EST)
Date:   Wed, 1 Dec 2021 13:36:57 -0500
From:   Scott Mayhew <smayhew@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "neilb@suse.de" <neilb@suse.de>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "tpearson@raptorengineering.com" <tpearson@raptorengineering.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Message-ID: <YafAyS/0AQS1QBKy@aion.usersys.redhat.com>
References: <162880418532.15074.7140645794203395299@noble.neil.brown.name>
 <YWCpnsdVqssFaLrf@aion.usersys.redhat.com>
 <589AFA4F-DF8E-45A3-8299-54E820E33169@oracle.com>
 <20211011143028.GB22387@fieldses.org>
 <34A4C7EB-2798-4482-A786-90161F5F9E34@oracle.com>
 <163398946770.17149.14605560717849885454@noble.neil.brown.name>
 <d795d4d7caaeebbf2f2260b7e739e9dc2f8a1de0.camel@hammerspace.com>
 <163425187213.17149.4082212844733494965@noble.neil.brown.name>
 <f2ebce6afe1d01b529a9373ecfba1dc8b3009b4c.camel@hammerspace.com>
 <8bc8cad158234aca0448ab1c8410880daff3c278.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8bc8cad158234aca0448ab1c8410880daff3c278.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 15 Oct 2021, Trond Myklebust wrote:

> On Fri, 2021-10-15 at 08:03 +0000, Trond Myklebust wrote:
> > On Fri, 2021-10-15 at 09:51 +1100, NeilBrown wrote:
> > > On Fri, 15 Oct 2021, Trond Myklebust wrote:
> > > > On Tue, 2021-10-12 at 08:57 +1100, NeilBrown wrote:
> > > > > On Tue, 12 Oct 2021, Chuck Lever III wrote:
> > > > > >=20
> > > > > > Scott seems well positioned to identify a reproducer. Maybe
> > > > > > we
> > > > > > can give him some likely candidates for possible bugs to
> > > > > > explore
> > > > > > first.
> > > > >=20
> > > > > Has this patch been tried?
> > > > >=20
> > > > > NeilBrown
> > > > >=20
> > > > >=20
> > > > > diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> > > > > index c045f63d11fa..308f5961cb78 100644
> > > > > --- a/net/sunrpc/sched.c
> > > > > +++ b/net/sunrpc/sched.c
> > > > > @@ -814,6 +814,7 @@ rpc_reset_task_statistics(struct rpc_task
> > > > > *task)
> > > > > =A0{
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0task->tk_timeouts =3D 0;
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0task->tk_flags &=3D ~(RPC_CALL_MAJORSEEN|=
RPC_TASK_SENT);
> > > > > +=A0=A0=A0=A0=A0=A0=A0clear_bit(RPC_TASK_SIGNALLED, &task->tk_run=
state);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0rpc_init_task_st
> > > >=20
> > > > We shouldn't automatically "unsignal" a task once it has been
> > > > told
> > > > to
> > > > die. The correct thing to do here should rather be to change
> > > > rpc_restart_call() to exit early if the task was signalled.
> > > >=20
> > >=20
> > > Maybe.=A0 It depends on exactly what the signal meant
> > > (rpc_killall_tasks()
> > > is a bit different from getting a SIGKILL), and exactly what the
> > > task
> > > is
> > > trying to achieve.
> > >=20
> > > Before Commit ae67bd3821bb ("SUNRPC: Fix up task signalling")
> > > that is exactly what we did.
> > > If we want to change the behaviour of a task responding to
> > > rpc_killall_tasks(), we should clearly justify it in a patch doing
> > > exactly that.
> > >=20
> >=20
> > The intention behind rpc_killall_tasks() never changed, which is why
> > it
>=20
> ("it" being the error ERESTARTSYS)
>=20
> > is listed in nfs_error_is_fatal(). I'm not aware of any case where we
> > deliberately override in order to restart the RPC call on an
> > ERESTARTSYS error.
> >=20
Update: I'm not able to reproduce this with an upstream kernel.  I
bisected it down to commit 2ba5acfb3495 "SUNRPC: fix sign error causing
rpcsec_gss drops" as the commit that "fixed" the issue (but really just
makes the issue less likely to occur, I think).

I also tested commit 10b9d99a3dbb "SUNRPC: Augment server-side rpcgss
tracepoints" (the commit in the Fixes: tag of 2ba5acfb3495) as well as
commit 0e885e846d96 "nfsd: add fattr support for user extended attributes"
(the parent of commit 10b9d99a3dbb) and verified that commit
10b9d99a3dbb is where the issue started occurring.

I think what is happening is that the NFS server gets a request that it
thinks is outside of the GSS sequence window and drops the request,
closes the connection and calls nfsd4_conn_lost(), which calls
nfsd4_probe_callback() which sets NFSD4_CLIENT_CB_UPDATE in
clp->cl_flags.  Then the client reestablishes the connection on that
port, sends another request which receives
NFS4ERR_CONN_NOT_BOUND_TO_SESSION.  The client runs the state manager
which calls nfs4_bind_conn_to_session(), which calls
nfs4_begin_drain_session(), which sets NFS4_SLOT_TBL_DRAINING in
tbl->slot_tbl_state.  Meanwhile a conflicting request comes in that
causes the server to recall the delegation.  Since
NFS4_SLOT_TBL_DRAINING is set, the client responds to the CB_SEQUENCE
with NFS4ERR_DELAY.  At the same time, the BIND_CONN_TO_SESSION requests
=66rom the client are causing the server to call
nfsd4_process_cb_update(), since NFSD4_CLIENT_CB_UPDATE flag is set.
nfsd4_process_cb_update() calls rpc_shutdown_client() which signals the
CB_RECALL task, which the server is trying re-send due to the
NFS4ERR_DELAY, and we get into the soft-lockup.

I tried this patch

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 20db98679d6b..187f7f1cc02a 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -803,6 +803,7 @@ rpc_reset_task_statistics(struct rpc_task *task)
 {
        task->tk_timeouts =3D 0;
        task->tk_flags &=3D ~(RPC_CALL_MAJORSEEN|RPC_TASK_SENT);
+       clear_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
        rpc_init_task_statistics(task);
 }
=20
but instead of fixing the soft-lockup I just wind up with a hung task:

INFO: task nfsd:1367 blocked for more than 120 seconds.
[ 3195.902559]       Not tainted 4.18.0-353.el8.jsm.test.1.x86_64 #1
[ 3195.905411] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[ 3195.908076] task:nfsd            state:D stack:    0 pid: 1367 ppid:    =
 2 flags:0x80004080
[ 3195.910906] Call Trace:
[ 3195.911915]  __schedule+0x2d1/0x830
[ 3195.913211]  schedule+0x35/0xa0
[ 3195.914377]  schedule_timeout+0x274/0x300
[ 3195.915919]  ? check_preempt_wakeup+0x113/0x230
[ 3195.916907]  wait_for_completion+0x96/0x100
[ 3195.917629]  flush_workqueue+0x14d/0x440
[ 3195.918342]  nfsd4_destroy_session+0x198/0x230 [nfsd]
[ 3195.919277]  nfsd4_proc_compound+0x388/0x6d0 [nfsd]
[ 3195.920144]  nfsd_dispatch+0x108/0x210 [nfsd]
[ 3195.920922]  svc_process_common+0x2b3/0x700 [sunrpc]
[ 3195.921871]  ? svc_xprt_received+0x45/0x80 [sunrpc]
[ 3195.922722]  ? nfsd_svc+0x2e0/0x2e0 [nfsd]
[ 3195.923441]  ? nfsd_destroy+0x50/0x50 [nfsd]
[ 3195.924199]  svc_process+0xb7/0xf0 [sunrpc]
[ 3195.924971]  nfsd+0xe3/0x140 [nfsd]
[ 3195.925596]  kthread+0x10a/0x120
[ 3195.926383]  ? set_kthread_struct+0x40/0x40
[ 3195.927100]  ret_from_fork+0x35/0x40

I then tried this patch:

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 0e212ac0fe44..5667fd15f157 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1573,6 +1573,8 @@ __rpc_restart_call(struct rpc_task *task, void (*acti=
on)(struct rpc_task *))
 int
 rpc_restart_call(struct rpc_task *task)
 {
+       if (RPC_SIGNALLED(task))
+               return 0;
        return __rpc_restart_call(task, call_start);
 }
 EXPORT_SYMBOL_GPL(rpc_restart_call);

and that seems to work.

-Scott
> >=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20

