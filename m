Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75AD6D9ECE
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 19:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbjDFRdp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 13:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbjDFRdl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 13:33:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E738689
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 10:33:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6CBC64A86
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 17:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C393C4339C;
        Thu,  6 Apr 2023 17:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680802412;
        bh=SHAclvqA9FQmn+Xz5tfN+mPOCXwVJczyJRoCWo9ikyI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YPVyiSA1tKnhX9mdV07LcLdLNDmTSyA4dCBMgzjzQ/dIBYAanU3HXFrWUZoYvZpyT
         gJ+nVkFaXyBQZ/UlJEyOVkpuLeu2jZeySdzs4X0RmbXv4+bp82sHy58wtoGLqJzZKa
         LZyCFplOxRoVmNb9yV2TscLzGSF9MPObCjfEIWTiaeJu2mlNclO5uhqQVyNXuh7R16
         ZxJ1bRiUcyTJoWmgFu2o3KI8UlhjyiW+aZaxSEUzerOXHb3UzmXoLmxskfVEX/uSM/
         c9NQZktw9XA5NLNT4aP9rPOKE+Nq6RYjidT3XxFp5wzjGAMZVJLQskbsbqGHBKNgU+
         rS5dE3cxvEjOA==
Message-ID: <64c4e5c4e61962fd828bcbef79db1df6466a875d.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Helen Chao <helen.chao@oracle.com>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Thu, 06 Apr 2023 13:33:30 -0400
In-Reply-To: <ed870a33-0809-3cfd-2d5a-b97409568b97@oracle.com>
References: <1678301132-24496-1-git-send-email-dai.ngo@oracle.com>
         <9D5A190A-333A-4470-8572-CF85EE9A8086@oracle.com>
         <182842b2-3de4-d64b-d729-f4f6c9c576d6@oracle.com>
         <ed870a33-0809-3cfd-2d5a-b97409568b97@oracle.com>
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

On Tue, 2023-03-14 at 09:19 -0700, dai.ngo@oracle.com wrote:
> On 3/8/23 11:03 AM, dai.ngo@oracle.com wrote:
> > On 3/8/23 10:50 AM, Chuck Lever III wrote:
> > >=20
> > > > On Mar 8, 2023, at 1:45 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > > >=20
> > > > Currently call_bind_status places a hard limit of 3 to the number o=
f
> > > > retries on EACCES error. This limit was done to accommodate the=20
> > > > behavior
> > > > of a buggy server that keeps returning garbage when the NLM daemon =
is
> > > > killed on the NFS server. However this change causes problem for ot=
her
> > > > servers that take a little longer than 9 seconds for the port mappe=
r to
> > > > become ready when the NFS server is restarted.
> > > >=20
> > > > This patch removes this hard coded limit and let the RPC handles
> > > > the retry according to whether the export is soft or hard mounted.
> > > >=20
> > > > To avoid the hang with buggy server, the client can use soft mount =
for
> > > > the export.
> > > >=20
> > > > Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock request=
s")
> > > > Reported-by: Helen Chao <helen.chao@oracle.com>
> > > > Tested-by: Helen Chao <helen.chao@oracle.com>
> > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > Helen is the royal queen of ^C=A0 ;-)
> > >=20
> > > Did you try ^C on a mount while it waits for a rebind?
> >=20
> > She uses a test script that restarts the NFS server while NLM lock test
> > is running. The failure is random, sometimes it fails and sometimes it
> > passes depending on when the LOCK/UNLOCK requests come in so I think
> > it's hard to time it to do the ^C, but I will ask.
>=20
> We did the test with ^C and here is what we found.
>=20
> For synchronous RPC task the signal was delivered to the RPC task and
> the task exit with -ERESTARTSYS from __rpc_execute as expected.
>=20
> For asynchronous RPC task the process that invokes the RPC task to send
> the request detected the signal in rpc_wait_for_completion_task and exits
> with -ERESTARTSYS. However the async RPC was allowed to continue to run
> to completion. So if the async RPC task was retrying an operation and
> the NFS server was down, it will retry forever if this is a hard mount
> or until the NFS server comes back up.
>=20
> The question for the list is should we propagate the signal to the async
> task via rpc_signal_task to stop its execution or just leave it alone as =
is.
>=20
>=20

That is a good question.

I like the patch overall, as it gets rid of a special one-off retry
counter, but I too share some concerns about retrying indefinitely when
an server goes missing.

>=20
Propagating a signal seems like the right thing to do. Looks like
rpcb_getport_done would also need to grow a check for RPC_SIGNALLED ?

It sounds pretty straightforward otherwise.
--=20
Jeff Layton <jlayton@kernel.org>
