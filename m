Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377954656ED
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Dec 2021 21:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352813AbhLAUTN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Dec 2021 15:19:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352880AbhLAURJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Dec 2021 15:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638389615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b8oCfvKO1SGkkFJdXAgsT57IJiHNSI2HLT9XIRNi5YQ=;
        b=Uk6/mO1cJFUqilCtFtr9knIZZi7h5Btf/8jkFPq+WL1kpyJa6aqmEwKXZNefdpB/w5++ZU
        5/KBH7+XWt/uBfMWRL1g4c88pSpwQErThwkAO1z29KNJAPqW4Rr4cU1st46uY1JUxb7HrH
        R9jYO5BG9DfSQHqFulh7GyHgtx3BCW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-hl0CGCbPMOiLkOf1bK_25w-1; Wed, 01 Dec 2021 15:13:34 -0500
X-MC-Unique: hl0CGCbPMOiLkOf1bK_25w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD9C2835E22;
        Wed,  1 Dec 2021 20:13:32 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.16.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24C2460622;
        Wed,  1 Dec 2021 20:13:32 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 578DF1A0032; Wed,  1 Dec 2021 15:13:31 -0500 (EST)
Date:   Wed, 1 Dec 2021 15:13:31 -0500
From:   Scott Mayhew <smayhew@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tpearson@raptorengineering.com" <tpearson@raptorengineering.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Message-ID: <YafXa0hSxfOLhPDp@aion.usersys.redhat.com>
References: <589AFA4F-DF8E-45A3-8299-54E820E33169@oracle.com>
 <20211011143028.GB22387@fieldses.org>
 <34A4C7EB-2798-4482-A786-90161F5F9E34@oracle.com>
 <163398946770.17149.14605560717849885454@noble.neil.brown.name>
 <d795d4d7caaeebbf2f2260b7e739e9dc2f8a1de0.camel@hammerspace.com>
 <163425187213.17149.4082212844733494965@noble.neil.brown.name>
 <f2ebce6afe1d01b529a9373ecfba1dc8b3009b4c.camel@hammerspace.com>
 <8bc8cad158234aca0448ab1c8410880daff3c278.camel@hammerspace.com>
 <YafAyS/0AQS1QBKy@aion.usersys.redhat.com>
 <f9b305425209e99aa73417823e82cf7ce56b0141.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f9b305425209e99aa73417823e82cf7ce56b0141.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 01 Dec 2021, Trond Myklebust wrote:

> On Wed, 2021-12-01 at 13:36 -0500, Scott Mayhew wrote:
> > On Fri, 15 Oct 2021, Trond Myklebust wrote:
> >=20
> > > On Fri, 2021-10-15 at 08:03 +0000, Trond Myklebust wrote:
> > > > On Fri, 2021-10-15 at 09:51 +1100, NeilBrown wrote:
> > > > > On Fri, 15 Oct 2021, Trond Myklebust wrote:
> > > > > > On Tue, 2021-10-12 at 08:57 +1100, NeilBrown wrote:
> > > > > > > On Tue, 12 Oct 2021, Chuck Lever III wrote:
> > > > > > > >=20
> > > > > > > > Scott seems well positioned to identify a reproducer.
> > > > > > > > Maybe
> > > > > > > > we
> > > > > > > > can give him some likely candidates for possible bugs to
> > > > > > > > explore
> > > > > > > > first.
> > > > > > >=20
> > > > > > > Has this patch been tried?
> > > > > > >=20
> > > > > > > NeilBrown
> > > > > > >=20
> > > > > > >=20
> > > > > > > diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> > > > > > > index c045f63d11fa..308f5961cb78 100644
> > > > > > > --- a/net/sunrpc/sched.c
> > > > > > > +++ b/net/sunrpc/sched.c
> > > > > > > @@ -814,6 +814,7 @@ rpc_reset_task_statistics(struct
> > > > > > > rpc_task
> > > > > > > *task)
> > > > > > > =C2=A0{
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0task->tk_time=
outs =3D 0;
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0task->tk_flag=
s &=3D
> > > > > > > ~(RPC_CALL_MAJORSEEN|RPC_TASK_SENT);
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clear_bit(RPC_TASK=
_SIGNALLED, &task->tk_runstate);
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rpc_init_task=
_st
> > > > > >=20
> > > > > > We shouldn't automatically "unsignal" a task once it has been
> > > > > > told
> > > > > > to
> > > > > > die. The correct thing to do here should rather be to change
> > > > > > rpc_restart_call() to exit early if the task was signalled.
> > > > > >=20
> > > > >=20
> > > > > Maybe.=C2=A0 It depends on exactly what the signal meant
> > > > > (rpc_killall_tasks()
> > > > > is a bit different from getting a SIGKILL), and exactly what
> > > > > the
> > > > > task
> > > > > is
> > > > > trying to achieve.
> > > > >=20
> > > > > Before Commit ae67bd3821bb ("SUNRPC: Fix up task signalling")
> > > > > that is exactly what we did.
> > > > > If we want to change the behaviour of a task responding to
> > > > > rpc_killall_tasks(), we should clearly justify it in a patch
> > > > > doing
> > > > > exactly that.
> > > > >=20
> > > >=20
> > > > The intention behind rpc_killall_tasks() never changed, which is
> > > > why
> > > > it
> > >=20
> > > ("it" being the error ERESTARTSYS)
> > >=20
> > > > is listed in nfs_error_is_fatal(). I'm not aware of any case
> > > > where we
> > > > deliberately override in order to restart the RPC call on an
> > > > ERESTARTSYS error.
> > > >=20
> > Update: I'm not able to reproduce this with an upstream kernel.=C2=A0 I
> > bisected it down to commit 2ba5acfb3495 "SUNRPC: fix sign error
> > causing
> > rpcsec_gss drops" as the commit that "fixed" the issue (but really
> > just
> > makes the issue less likely to occur, I think).
> >=20
> > I also tested commit 10b9d99a3dbb "SUNRPC: Augment server-side rpcgss
> > tracepoints" (the commit in the Fixes: tag of 2ba5acfb3495) as well
> > as
> > commit 0e885e846d96 "nfsd: add fattr support for user extended
> > attributes"
> > (the parent of commit 10b9d99a3dbb) and verified that commit
> > 10b9d99a3dbb is where the issue started occurring.
> >=20
> > I think what is happening is that the NFS server gets a request that
> > it
> > thinks is outside of the GSS sequence window and drops the request,
> > closes the connection and calls nfsd4_conn_lost(), which calls
> > nfsd4_probe_callback() which sets NFSD4_CLIENT_CB_UPDATE in
> > clp->cl_flags.=C2=A0 Then the client reestablishes the connection on th=
at
> > port, sends another request which receives
> > NFS4ERR_CONN_NOT_BOUND_TO_SESSION.=C2=A0 The client runs the state mana=
ger
> > which calls nfs4_bind_conn_to_session(), which calls
> > nfs4_begin_drain_session(), which sets NFS4_SLOT_TBL_DRAINING in
> > tbl->slot_tbl_state.=C2=A0 Meanwhile a conflicting request comes in that
> > causes the server to recall the delegation.=C2=A0 Since
> > NFS4_SLOT_TBL_DRAINING is set, the client responds to the CB_SEQUENCE
> > with NFS4ERR_DELAY.=C2=A0 At the same time, the BIND_CONN_TO_SESSION
> > requests
> > from the client are causing the server to call
> > nfsd4_process_cb_update(), since NFSD4_CLIENT_CB_UPDATE flag is set.
> > nfsd4_process_cb_update() calls rpc_shutdown_client() which signals
> > the
> > CB_RECALL task, which the server is trying re-send due to the
> > NFS4ERR_DELAY, and we get into the soft-lockup.
> >=20
>=20
> I'm a little lost with the above explantion. How can the server send a
> callback on a connection that isn't bound? If it isn't bound, then it
> can't be used as a back channel.

The callback is on port 787 and the client sent a BIND_CONN_TO_SESSION
on port 787 right before that:

$ tshark -2 -r nfstest_delegation_20211123_154510_001.cap -Y '(nfs||nfs.cb|=
|tcp.flags.fin=3D=3D1) && (frame.number >=3D 447 && frame.number <=3D 491)'
  447   2.146535 10.16.225.113 =E2=86=92 10.16.225.28 NFS 877 2049 V4 Call =
(Reply In 448) OPEN DH: 0x7c6b0f9b/nfstest_delegation_20211123_154510_f_001
  448   2.162160 10.16.225.28 =E2=86=92 10.16.225.113 NFS 2049 877 V4 Reply=
 (Call In 447) OPEN StateID: 0xcb0c
  455   2.180240 10.16.225.113 =E2=86=92 10.16.225.28 NFS 850 2049 V4 Call =
(Reply In 461) READ StateID: 0xa0f6 Offset: 0 Len: 4096
  456   2.180301 10.16.225.113 =E2=86=92 10.16.225.28 NFS 846 2049 V4 Call =
(Reply In 466) READ StateID: 0xa0f6 Offset: 8192 Len: 4096
  457   2.180357 10.16.225.113 =E2=86=92 10.16.225.28 NFS 775 2049 V4 Call =
READ StateID: 0xa0f6 Offset: 4096 Len: 4096
  458   2.180382 10.16.225.113 =E2=86=92 10.16.225.28 NFS 879 2049 V4 Call =
(Reply In 470) READ StateID: 0xa0f6 Offset: 12288 Len: 4096
  461   2.195961 10.16.225.28 =E2=86=92 10.16.225.113 NFS 2049 850 V4 Reply=
 (Call In 455) READ
  463   2.195989 10.16.225.28 =E2=86=92 10.16.225.113 TCP 2049 775 2049 =E2=
=86=92 775 [FIN, ACK] Seq=3D557 Ack=3D689 Win=3D32256 Len=3D0 TSval=3D34148=
32656 TSecr=3D3469334230
  466   2.196039 10.16.225.28 =E2=86=92 10.16.225.113 NFS 2049 846 V4 Reply=
 (Call In 456) READ
  470   2.196088 10.16.225.28 =E2=86=92 10.16.225.113 NFS 2049 879 V4 Reply=
 (Call In 458) READ
  472   2.196171 10.16.225.113 =E2=86=92 10.16.225.28 TCP 775 2049 775 =E2=
=86=92 2049 [FIN, ACK] Seq=3D689 Ack=3D558 Win=3D31104 Len=3D0 TSval=3D3469=
334246 TSecr=3D3414832656
  479   2.227386 10.16.225.113 =E2=86=92 10.16.225.28 NFS 775 2049 V4 Call =
(Reply In 482) READ StateID: 0xa0f6 Offset: 4096 Len: 4096
  482   2.242931 10.16.225.28 =E2=86=92 10.16.225.113 NFS 2049 775 V4 Reply=
 (Call In 479) SEQUENCE Status: NFS4ERR_CONN_NOT_BOUND_TO_SESSION
  484   2.243537 10.16.225.113 =E2=86=92 10.16.225.28 NFS 787 2049 V4 Call =
(Reply In 486) BIND_CONN_TO_SESSION
  486   2.259358 10.16.225.28 =E2=86=92 10.16.225.113 NFS 2049 787 V4 Reply=
 (Call In 484) BIND_CONN_TO_SESSION
  488   2.259755 10.16.225.113 =E2=86=92 10.16.225.28 NFS 802 2049 V4 Call =
(Reply In 492) BIND_CONN_TO_SESSION
  489   2.260037 10.16.225.28 =E2=86=92 10.16.225.113 NFS CB 2049 787 V1 CB=
_COMPOUND Call (Reply In 491) <EMPTY> CB_SEQUENCE;CB_RECALL
  491   2.260139 10.16.225.113 =E2=86=92 10.16.225.28 NFS CB 787 2049 V1 CB=
_COMPOUND Reply (Call In 489) <EMPTY> CB_SEQUENCE

Come to think of it though, I'm not sure I understand why the CB_RECALL
is happening because I don't see the conflicting open until later in the
capture.

>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20

