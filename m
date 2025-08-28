Return-Path: <linux-nfs+bounces-13925-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318D6B38F91
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 02:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2FA981BCD
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 00:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3068B676;
	Thu, 28 Aug 2025 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHsBmf21"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFFF79EA
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339450; cv=none; b=bJJsetMGqlupgYl1LsgTwebuaq9qxQ5XznOMyx3+epPKnKBnjAWIaAOEekxvLp4QArWTf6I+qrct5zwArNwZuY9i+MHowbzJq+acOSMJct/DoDI53gnwsoQg3M+tRWCNCyr3weii0QN+8XPzrsj5jD2wmNLPjYQ96vusth0nLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339450; c=relaxed/simple;
	bh=CRcD13kPlOeA0pyJSkvdAXquDnRsFjdxaqpb36zIZ30=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AbQl5re3bmY3qqRgtXjL34R6P9+FGlA/uqOwmUgKLe3kRP3O6tb6k9wUrt0f2X2v+M91u/02rimihdG+U9vd1RFsT18oomEtlX5FyORrKt8wY5YBmAMYchdJa2XV4fByWRcF9h+X5+mRhgDHN8/VqJh5viaRX85RnQjX3IRFh2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHsBmf21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18464C4CEEB;
	Thu, 28 Aug 2025 00:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756339450;
	bh=CRcD13kPlOeA0pyJSkvdAXquDnRsFjdxaqpb36zIZ30=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=sHsBmf21NKRIRcJhF0W4ZVImBZ8KcBJ4XSbemBJb6IO2fjBpmcD0My7KYS5Y8cxg9
	 /tNnshe8qXbTTdKme04rM/iXsKy65hhMA7dsSYs1acJWEpqDXKScS267D5rkBRgW3M
	 Hd9+k0wbuKSH5d4gSjZP625fhp2Y3J6Ja9VOzTzItNrduAtJJHQWX1foq2AYK4qYkt
	 rQxjhMAa79YiE4j7LcK5juvmeX4HjAso5u1C8sjjnaqdBKTqpievJc6hJ6GxLRam35
	 e9fmKGVFxkXg3REZKiMr7kU091Grl4pL/dUW2sWWnt5QzRWhZ5OcGReHIxjFmMl6zP
	 GW5vA/EadEzRw==
Message-ID: <31c40217b2bbbf5367c3a7d7ea0021e6d7879460.camel@kernel.org>
Subject: Re: [PATCH] sunrpc: hold RPC client while gss_auth has a link to it
From: Trond Myklebust <trondmy@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>, anna.schumaker@oracle.com
Cc: linux-nfs@vger.kernel.org
Date: Wed, 27 Aug 2025 17:04:08 -0700
In-Reply-To: <b18de932-cffd-4d56-851d-e4aeca73e08e@oracle.com>
References: <20250827223831.47513-1-calum.mackay@oracle.com>
	 <6813623b0780828d7e2a6dced04f74f803423f20.camel@kernel.org>
	 <b18de932-cffd-4d56-851d-e4aeca73e08e@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-28 at 00:48 +0100, Calum Mackay wrote:
> On 28/08/2025 12:33 am, Trond Myklebust wrote:
> > On Wed, 2025-08-27 at 23:38 +0100, Calum Mackay wrote:
> > > We have seen crashes where the RPC client has been freed, while a
> > > gss_auth
> > > still has a pointer to it. Subsequently, GSS attempts to send a
> > > NULL
> > > call,
> > > resulting in a use-after-free in xprt_iter_get_next.
> > >=20
> > > Fix that by having GSS take a reference on the RPC client, in
> > > gss_create_new, and release it in gss_free.
> > >=20
> > > The crashes we've seen have been on a v5.4-based kernel. They are
> > > not
> > > reproducible on demand, happening once every few months under
> > > heavy
> > > load.
> > >=20
> > > The crashing thread is an rpc_async_release worker:
> > >=20
> > > xprt_iter_ops (net/sunrpc/xprtmultipath.c:184:43)
> > > xprt_iter_get_next (net/sunrpc/xprtmultipath.c:527:35)
> > > rpc_task_get_next_xprt (net/sunrpc/clnt.c:1062:9)
> > > rpc_task_set_transport (net/sunrpc/clnt.c:1073:19)
> > > rpc_task_set_transport (net/sunrpc/clnt.c:1066:6)
> > > rpc_task_set_client (net/sunrpc/clnt.c:1081:3)
> > > rpc_run_task (net/sunrpc/clnt.c:1133:2)
> > > rpc_call_null_helper (net/sunrpc/clnt.c:2766:9)
> > > rpc_call_null (net/sunrpc/clnt.c:2771:9)
> > > gss_send_destroy_context (net/sunrpc/auth_gss/auth_gss.c:1274:10)
> > > gss_destroy_cred (net/sunrpc/auth_gss/auth_gss.c:1341:3)
> > > put_rpccred (net/sunrpc/auth.c:758:2)
> > > put_rpccred (net/sunrpc/auth.c:733:1)
> > > __put_nfs_open_context (fs/nfs/inode.c:1010:2)
> > > put_nfs_open_context (fs/nfs/inode.c:1017:2)
> > > nfs_pgio_data_destroy (fs/nfs/pagelist.c:562:3)
> > > nfs_pgio_header_free (fs/nfs/pagelist.c:573:2)
> > > nfs_read_completion (fs/nfs/read.c:200:2)
> > > nfs_pgio_release (fs/nfs/pagelist.c:699:2)
> > > rpc_release_calldata (net/sunrpc/sched.c:890:3)
> > > rpc_free_task (net/sunrpc/sched.c:1171:2)
> > > rpc_async_release (net/sunrpc/sched.c:1183:2)
> > > process_one_work (kernel/workqueue.c:2295:2)
> > > worker_thread (kernel/workqueue.c:2448:4)
> > > kthread (kernel/kthread.c:296:9)
> > > ret_from_fork+0x2b/0x36 (arch/x86/entry/entry_64.S:358)
> > >=20
> > > Immediately before __put_nfs_open_context calls put_rpccred,
> > > above,
> > > it calls nfs_sb_deactive, which frees the RPC client:
> > >=20
> > > rpc_free_client+189 [sunrpc]
> > > rpc_release_client+98 [sunrpc]
> > > rpc_shutdown_client+98 [sunrpc]
> > > nfs_free_client+123 [nfs]
> > > nfs_put_client+217 [nfs]
> > > nfs_free_server+81 [nfs]
> > > nfs_kill_super+49 [nfs]
> > > deactivate_locked_super+58
> > > deactivate_super+89
> > > nfs_sb_deactive+36 [nfs]
> > >=20
> > > After the RPC client is freed here, __put_nfs_open_context calls
> > > put_rpccred, which wants to destroy the cred, since its refcnt is
> > > now
> > > zero. Since the cred is not marked as UPTODATE,
> > > gss_send_destroy_context
> > > needs to send a NULL call to the server, to get it to release all
> > > state
> > > for this context.=C2=A0 For this NULL call, we need an RPC client wit=
h
> > > an
> > > associated xprt; whilst looking for one, we trip over the freed
> > > xpi,
> > > that we freed earlier from nfs_sb_deactive.
> > >=20
> > > Ensuring that the RPC client refcnt is incremented whilst
> > > gss_auth
> > > has a
> > > pointer to it would ensure that the client can't be freed until
> > > gss_auth
> > > has been freed.
> > >=20
> > > Whilst the above occurred on a v5.4 kernel, I don't see anything
> > > obvious
> > > that would stop this happening to current code.
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Calum Mackay <calum.mackay@oracle.com>
> > > ---
> > > =C2=A0=C2=A0net/sunrpc/auth_gss/auth_gss.c | 16 +++++++++++++++-
> > > =C2=A0=C2=A01 file changed, 15 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/net/sunrpc/auth_gss/auth_gss.c
> > > b/net/sunrpc/auth_gss/auth_gss.c
> > > index 5c095cb8cb20..8c2cc92c6cd6 100644
> > > --- a/net/sunrpc/auth_gss/auth_gss.c
> > > +++ b/net/sunrpc/auth_gss/auth_gss.c
> > > @@ -1026,6 +1026,13 @@ gss_create_new(const struct
> > > rpc_auth_create_args *args, struct rpc_clnt *clnt)
> > > =C2=A0=20
> > > =C2=A0=C2=A0	if (!try_module_get(THIS_MODULE))
> > > =C2=A0=C2=A0		return ERR_PTR(err);
> > > +
> > > +	/*
> > > +	 * Make sure the RPC client can't be freed while
> > > gss_auth
> > > has
> > > +	 * a link to it
> > > +	 */
> > > +	refcount_inc(&clnt->cl_count);
> > > +
> >=20
> > NACK. We can't have the client hold a reference to the auth_gss
> > struct
> > and then have the same auth_gss hold a reference back to the
> > client.
> > That's a guaranteed leak of both objects.
>=20
> Thanks Trond.
>=20
> Would an acceptable alternative be for gss_send_destroy_context to=20
> simply not attempt the NULL RPC call if gss_auth->client has already=20
> been freed?
>=20

The expectation is normally that if something depends on the gss_auth,
then it should be holding a reference to the gss_auth->client (and not
necessarily to the gss_auth itself). Normally, this happens through the
rpc_clone_client() mechanism.

If there are corner cases where we're currently failing to grab a
reference to the gss_auth->client, then we want to understand how that
is falling through the cracks, so that we can fix it up.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

