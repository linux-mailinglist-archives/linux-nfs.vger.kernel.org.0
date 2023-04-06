Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414E36D9F8C
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 20:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbjDFSLA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 14:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDFSK7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 14:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6274C7ED3
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 11:10:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F02C864002
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 18:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99D7C433EF;
        Thu,  6 Apr 2023 18:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680804657;
        bh=DWRudFioG8dvQjQniWG+xMud25zU+F4Hkjb4Fj/4a7k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=p4qrYo2fGZTmP8ojXQxXxWIynJE0LWd2ecxth39aKRbu442V+U6sZ6o2nYgJyT2TI
         sU4VLUzpvrRDZqyGbXplIsZqjel6gAcc2m9wHn6jzr2Nt6yJhlklriV5ydY/QIc57C
         KmvaQRzkeanOMkMi3lrFOpkFtERQsTxhpIkuan/tCfhfM/GZoQkK2eYfW74ZRi0Msi
         Yb9PbAyxNXrr5SHaPeV6NUwpjXuDv2bkQfIz0j6oSrw7BhQ4y7vDDA9CKnoyeMrzoP
         arVbXLxfR2X7sbeCpRh+A2HSgDvUOtGCfYNDq9rt0mra2vZoDauxpM7brPSZ65bzyV
         LydsIL8BuDsbQ==
Message-ID: <f6c0553c49efd9e2f643240aacdea8dd1f728443.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Helen Chao <helen.chao@oracle.com>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Thu, 06 Apr 2023 14:10:55 -0400
In-Reply-To: <64c4e5c4e61962fd828bcbef79db1df6466a875d.camel@kernel.org>
References: <1678301132-24496-1-git-send-email-dai.ngo@oracle.com>
         <9D5A190A-333A-4470-8572-CF85EE9A8086@oracle.com>
         <182842b2-3de4-d64b-d729-f4f6c9c576d6@oracle.com>
         <ed870a33-0809-3cfd-2d5a-b97409568b97@oracle.com>
         <64c4e5c4e61962fd828bcbef79db1df6466a875d.camel@kernel.org>
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

On Thu, 2023-04-06 at 13:33 -0400, Jeff Layton wrote:
> On Tue, 2023-03-14 at 09:19 -0700, dai.ngo@oracle.com wrote:
> > On 3/8/23 11:03 AM, dai.ngo@oracle.com wrote:
> > > On 3/8/23 10:50 AM, Chuck Lever III wrote:
> > > >=20
> > > > > On Mar 8, 2023, at 1:45 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > > > >=20
> > > > > Currently call_bind_status places a hard limit of 3 to the number=
 of
> > > > > retries on EACCES error. This limit was done to accommodate the=
=20
> > > > > behavior
> > > > > of a buggy server that keeps returning garbage when the NLM daemo=
n is
> > > > > killed on the NFS server. However this change causes problem for =
other
> > > > > servers that take a little longer than 9 seconds for the port map=
per to
> > > > >=20
> > > > >=20


Actually, the EACCES error means that the host doesn't have the port
registered. That could happen if (e.g.) the host had a NFSv3 mount up
with an NLM connection and then crashed and rebooted and didn't remount
it.
=20
> > > > > become ready when the NFS server is restarted.
> > > > >=20
> > > > > This patch removes this hard coded limit and let the RPC handles
> > > > > the retry according to whether the export is soft or hard mounted=
.
> > > > >=20
> > > > > To avoid the hang with buggy server, the client can use soft moun=
t for
> > > > > the export.
> > > > >=20
> > > > > Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock reque=
sts")
> > > > > Reported-by: Helen Chao <helen.chao@oracle.com>
> > > > > Tested-by: Helen Chao <helen.chao@oracle.com>
> > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > Helen is the royal queen of ^C=A0 ;-)
> > > >=20
> > > > Did you try ^C on a mount while it waits for a rebind?
> > >=20
> > > She uses a test script that restarts the NFS server while NLM lock te=
st
> > > is running. The failure is random, sometimes it fails and sometimes i=
t
> > > passes depending on when the LOCK/UNLOCK requests come in so I think
> > > it's hard to time it to do the ^C, but I will ask.
> >=20
> > We did the test with ^C and here is what we found.
> >=20
> > For synchronous RPC task the signal was delivered to the RPC task and
> > the task exit with -ERESTARTSYS from __rpc_execute as expected.
> >=20
> > For asynchronous RPC task the process that invokes the RPC task to send
> > the request detected the signal in rpc_wait_for_completion_task and exi=
ts
> > with -ERESTARTSYS. However the async RPC was allowed to continue to run
> > to completion. So if the async RPC task was retrying an operation and
> > the NFS server was down, it will retry forever if this is a hard mount
> > or until the NFS server comes back up.
> >=20
> > The question for the list is should we propagate the signal to the asyn=
c
> > task via rpc_signal_task to stop its execution or just leave it alone a=
s is.
> >=20
> >=20
>=20
> That is a good question.
>=20
> I like the patch overall, as it gets rid of a special one-off retry
> counter, but I too share some concerns about retrying indefinitely when
> an server goes missing.
>=20
> >=20
> Propagating a signal seems like the right thing to do. Looks like
> rpcb_getport_done would also need to grow a check for RPC_SIGNALLED ?
>=20
> It sounds pretty straightforward otherwise.

Erm, except that some of these xprts are in the context of the server.

For instance: server-side lockd sometimes has to send messages to the
clients (e.g. GRANTED callbacks). Suppose we're trying to send a message
to the client, but it has crashed and rebooted...or maybe the client's
address got handed to another host that isn't doing NFS at all so the
NLM service will never come back.

This will mean that those RPCs will retry forever now in this situation.
I'm not sure that's what we want. Maybe we need some way to distinguish
between "user-driven" RPCs and those that aren't?

As a simpler workaround, would it work to just increase the number of
retries here? There's nothing magical about 3 tries. ISTM that having it
retry enough times to cover at least a minute or two would be
acceptable.
--=20
Jeff Layton <jlayton@kernel.org>
