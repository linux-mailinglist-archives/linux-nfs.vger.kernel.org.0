Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7612B6DA214
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 21:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbjDFT7Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 15:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbjDFT7V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 15:59:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756328A63
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 12:59:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6975646A5
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 19:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAA4C433EF;
        Thu,  6 Apr 2023 19:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680811159;
        bh=6RqKo6tQ7bzDK4JjH3Zvhzz6BQlXkur4rl0oi02Wm0k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jpi+bthfzOzDJWtFet5F0TDzt9MAkPqh+12eD56KkRmjDdz2sE/joX+zcyQxxY/o0
         +zwhlYfYRC/N0zXOf9jFirpvugWhs1HiaQY/iFLHq2rZZDRRNSnG8C40fOc9MOHfVD
         6L0P5X8j3yNlg0Q2JjeWARmUeQ8CgBiSnxi8PFb7/slxP/zUdTUs9YndV4zgwAldzP
         spWN1YnfXdMUsTDvolkbtI8dYdT3piyecKwUWICkWIC3QX6Z8SwbDNX9b48O9+cyLe
         jZdRYr36ig1DN/tDQNwvfB65ImF0eGVGEITrQ8rTr0vFaJgigJflgHOJrIHrFVQY+3
         3svJ7hG/Dw9iw==
Message-ID: <c659b24274539086c3adad8af4c7d30cf87ee83a.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Helen Chao <helen.chao@oracle.com>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Thu, 06 Apr 2023 15:59:17 -0400
In-Reply-To: <F925BB7E-4E1C-48CD-A0C0-A058058E55BD@oracle.com>
References: <1678301132-24496-1-git-send-email-dai.ngo@oracle.com>
         <9D5A190A-333A-4470-8572-CF85EE9A8086@oracle.com>
         <182842b2-3de4-d64b-d729-f4f6c9c576d6@oracle.com>
         <ed870a33-0809-3cfd-2d5a-b97409568b97@oracle.com>
         <64c4e5c4e61962fd828bcbef79db1df6466a875d.camel@kernel.org>
         <f6c0553c49efd9e2f643240aacdea8dd1f728443.camel@kernel.org>
         <07d8f93d-c8f3-5ede-66a3-219eea0fdfe6@oracle.com>
         <F925BB7E-4E1C-48CD-A0C0-A058058E55BD@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-04-06 at 19:43 +0000, Chuck Lever III wrote:
>=20
> > On Apr 6, 2023, at 3:36 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >=20
> > Hi Jeff,
> >=20
> > Thank you for taking a look at the patch.
> >=20
> > On 4/6/23 11:10 AM, Jeff Layton wrote:
> > > On Thu, 2023-04-06 at 13:33 -0400, Jeff Layton wrote:
> > > > On Tue, 2023-03-14 at 09:19 -0700, dai.ngo@oracle.com wrote:
> > > > > On 3/8/23 11:03 AM, dai.ngo@oracle.com wrote:
> > > > > > On 3/8/23 10:50 AM, Chuck Lever III wrote:
> > > > > > > > On Mar 8, 2023, at 1:45 PM, Dai Ngo <dai.ngo@oracle.com> wr=
ote:
> > > > > > > >=20
> > > > > > > > Currently call_bind_status places a hard limit of 3 to the =
number of
> > > > > > > > retries on EACCES error. This limit was done to accommodate=
 the
> > > > > > > > behavior
> > > > > > > > of a buggy server that keeps returning garbage when the NLM=
 daemon is
> > > > > > > > killed on the NFS server. However this change causes proble=
m for other
> > > > > > > > servers that take a little longer than 9 seconds for the po=
rt mapper to
> > > > > > > >=20
> > > > > > > >=20
> > >=20
> > > Actually, the EACCES error means that the host doesn't have the port
> > > registered.
> >=20
> > Yes, our SQA team runs stress lock test and restart the NFS server.
> > Sometimes the NFS server starts up and register to the port mapper in
> > time and there is no problem but occasionally it's late coming up causi=
ng
> > this EACCES error.
> >=20
> > >  That could happen if (e.g.) the host had a NFSv3 mount up
> > > with an NLM connection and then crashed and rebooted and didn't remou=
nt
> > > it.
> >=20
> > can you please explain this scenario I don't quite follow it. If the v3
> > client crashed and did not remount the export then how can the client t=
ry
> > to access/lock anything on the server? I must have missing something he=
re.
> >=20
> > > =20

Suppose you have a client with an admin that mounts a NFSv3 mount "by
hand" (and doesn't set up statd to run at boot time). Client requests an
NLM lock and then reboots.

When it comes up, there's no notification to the server that the client
rebooted. Later, the lock becomes free and the server tries to grant it
to the client. It talks to rpcbind but lockd is never started and the
server keeps querying the client's rpcbind forever.

Maybe more likely situation: the client crashes and loses its DHCP
address when it comes back up, and the old addr gets reassigned to
another host that has rpcbind running but no NFS.

Either way, it'd keep trying to call the client back indefinitely that
way.

> > > > > > > > become ready when the NFS server is restarted.
> > > > > > > >=20
> > > > > > > > This patch removes this hard coded limit and let the RPC ha=
ndles
> > > > > > > > the retry according to whether the export is soft or hard m=
ounted.
> > > > > > > >=20
> > > > > > > > To avoid the hang with buggy server, the client can use sof=
t mount for
> > > > > > > > the export.
> > > > > > > >=20
> > > > > > > > Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock=
 requests")
> > > > > > > > Reported-by: Helen Chao <helen.chao@oracle.com>
> > > > > > > > Tested-by: Helen Chao <helen.chao@oracle.com>
> > > > > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > > > Helen is the royal queen of ^C  ;-)
> > > > > > >=20
> > > > > > > Did you try ^C on a mount while it waits for a rebind?
> > > > > > She uses a test script that restarts the NFS server while NLM l=
ock test
> > > > > > is running. The failure is random, sometimes it fails and somet=
imes it
> > > > > > passes depending on when the LOCK/UNLOCK requests come in so I =
think
> > > > > > it's hard to time it to do the ^C, but I will ask.
> > > > > We did the test with ^C and here is what we found.
> > > > >=20
> > > > > For synchronous RPC task the signal was delivered to the RPC task=
 and
> > > > > the task exit with -ERESTARTSYS from __rpc_execute as expected.
> > > > >=20
> > > > > For asynchronous RPC task the process that invokes the RPC task t=
o send
> > > > > the request detected the signal in rpc_wait_for_completion_task a=
nd exits
> > > > > with -ERESTARTSYS. However the async RPC was allowed to continue =
to run
> > > > > to completion. So if the async RPC task was retrying an operation=
 and
> > > > > the NFS server was down, it will retry forever if this is a hard =
mount
> > > > > or until the NFS server comes back up.
> > > > >=20
> > > > > The question for the list is should we propagate the signal to th=
e async
> > > > > task via rpc_signal_task to stop its execution or just leave it a=
lone as is.
> > > > >=20
> > > > >=20
> > > > That is a good question.
> >=20
> > Maybe we should defer the propagation of the signal for later. Chuck ha=
s
> > some concern since this can change the existing behavior of async task
> > for other v4 operations.
> >=20

Fair enough.

> > > >=20
> > > > I like the patch overall, as it gets rid of a special one-off retry
> > > > counter, but I too share some concerns about retrying indefinitely =
when
> > > > an server goes missing.
> > > >=20
> > > > Propagating a signal seems like the right thing to do. Looks like
> > > > rpcb_getport_done would also need to grow a check for RPC_SIGNALLED=
 ?
> > > >=20
> > > > It sounds pretty straightforward otherwise.
> > > Erm, except that some of these xprts are in the context of the server=
.
> > >=20
> > > For instance: server-side lockd sometimes has to send messages to the
> > > clients (e.g. GRANTED callbacks). Suppose we're trying to send a mess=
age
> > > to the client, but it has crashed and rebooted...or maybe the client'=
s
> > > address got handed to another host that isn't doing NFS at all so the
> > > NLM service will never come back.
> > >=20
> > > This will mean that those RPCs will retry forever now in this situati=
on.
> > > I'm not sure that's what we want. Maybe we need some way to distingui=
sh
> > > between "user-driven" RPCs and those that aren't?
> > >=20
> > > As a simpler workaround, would it work to just increase the number of
> > > retries here? There's nothing magical about 3 tries. ISTM that having=
 it
> > > retry enough times to cover at least a minute or two would be
> > > acceptable.
> >=20
> > I'm happy with the simple workaround by just increasing the number of
> > retries. This would fix the immediate problem that we're facing without
> > potential of breaking things in other areas. If you agree then I will
> > prepare the simpler patch for this.
>=20
> A longer retry period is a short-term solution. I can get behind
> that as long as the patch description makes clear some of the
> concerns that have been brought up in this email thread.
>=20

Sounds good to me too -- 9s is an very short amount of time, IMO. We
generally wait on the order of minutes for RPC timeouts and this seems
like a similar situation.
--=20
Jeff Layton <jlayton@kernel.org>
