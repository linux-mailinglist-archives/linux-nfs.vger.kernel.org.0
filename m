Return-Path: <linux-nfs+bounces-13436-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09960B1B98A
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 19:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D3F6254DB
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 17:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D3223ABB2;
	Tue,  5 Aug 2025 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWABkrNy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680A1F8EEC
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754415697; cv=none; b=goZZ8EBdMjBKp9azZogsunXXVIgwWGvHJTkxDYA8mck9wecXDSu6x1+4OsC5KfOhd1VYZFHSvHH+t7gTvFBHkwPH9QDmqEHB9Y64psWsNHi1XCghK9lpe1F/v95/rRU154cjBx2kugOxes7rM9e8H+TAJniSxIa/vdnnau6nQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754415697; c=relaxed/simple;
	bh=UBf22MgeGwUv7rO/BCkB9u+FFhe3WKc6GTbLdtJbxgs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Abero3Nx0DQCW3q50vw8QTpzbQ8mSpY4T1Qfqg6VbmJxtWwBXByjy6CQlf2NLLuVZeOwu1g8OgSSoQYnUnjzaoAl7gtsI+3m2aednLNhQ4rZ8pEK24kuAjtiY6rwacLCzPrJH2Xpz/eN8dq7dUU+Na/Oxz2Kuog0tE8TlmCj/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWABkrNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7D8C4CEF0;
	Tue,  5 Aug 2025 17:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754415697;
	bh=UBf22MgeGwUv7rO/BCkB9u+FFhe3WKc6GTbLdtJbxgs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dWABkrNy6jDh4YgguX+AXLRt4nki4tXlvT8Z3D3nAsWU11D2wWc5/KIigQJH2EFK4
	 Wpx3qaeWEe6pLz7CYIpClMpj9kxFjiRAZBAVXcfclrJTH6jk2EALCpX2H5sCw/TjhQ
	 h2X7KTnbDa6K0gdzzF59yITSGHhFHKjC9CYEIOUHYoOrlI6uzcQ6CpdDWIqwAPANFu
	 VCJniEYyIs3Xqy3uR+ewogpICHL0GttrpTWR/MW11TkzLE5C5Z+zYsCOnm1FkexTba
	 SoAE0S48dZb7lxCyYT252J6+lPCc56s/HJ/uNHp7vOqo7Xe6NWSkgnEAxYApmU8KYq
	 ZQ/gufpo5KHLw==
Message-ID: <5fde3098a1ae24966def603f127986d6a417e5c4.camel@kernel.org>
Subject: Re: [PATCH 1/1] SUNRPC: call_connect_status needs to destroy
 transport on ETIMEDOUT before retry
From: Trond Myklebust <trondmy@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Tue, 05 Aug 2025 10:41:35 -0700
In-Reply-To: <14935b2e-8124-4f46-a63e-331328d49d12@oracle.com>
References: <1754334505-65027-1-git-send-email-dai.ngo@oracle.com>
	 <48287a80e639d61eb507175ceb44d216e8032510.camel@kernel.org>
	 <72e387a8-b800-431b-89c3-0104fbfe6273@oracle.com>
	 <23fbff6b80f0c7c4b963f214c4c1e5d7b31c1d23.camel@kernel.org>
	 <de62d42e-5e85-45d5-825b-369938a4a24c@oracle.com>
	 <3978e03aa1638621bced96738ef210ed389e2afb.camel@kernel.org>
	 <14935b2e-8124-4f46-a63e-331328d49d12@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-05 at 10:07 -0700, Dai Ngo wrote:
>=20
> On 8/5/25 9:41 AM, Trond Myklebust wrote:
> > On Tue, 2025-08-05 at 08:46 -0700, Dai Ngo wrote:
> > > On 8/4/25 4:55 PM, Trond Myklebust wrote:
> > > > On Mon, 2025-08-04 at 13:13 -0700, Dai Ngo wrote:
> > > > > On 8/4/25 12:21 PM, Trond Myklebust wrote:
> > > > > > On Mon, 2025-08-04 at 12:08 -0700, Dai Ngo wrote:
> > > > > > > Currently, when an RPC connection times out during the
> > > > > > > connect
> > > > > > > phase,
> > > > > > > the task is retried by placing it back on the pending
> > > > > > > queue
> > > > > > > and
> > > > > > > waiting
> > > > > > > again. In some cases, the timeout occurs because TCP is
> > > > > > > unable to
> > > > > > > send
> > > > > > > the SYN packet. This situation most often arises on bare
> > > > > > > metal
> > > > > > > systems
> > > > > > > at boot time, when the NFS mount is attempted while the
> > > > > > > network
> > > > > > > link
> > > > > > > appears to be up but is not yet stable.
> > > > > > >=20
> > > > > > > This patch addresses the issue by updating
> > > > > > > call_connect_status to
> > > > > > > destroy
> > > > > > > the transport on ETIMEDOUT error before retrying the
> > > > > > > connection.
> > > > > > > This
> > > > > > > ensures that subsequent connection attempts use a fresh
> > > > > > > transport,
> > > > > > > reducing the likelihood of repeated failures due to
> > > > > > > lingering
> > > > > > > network
> > > > > > > issues.
> > > > > > >=20
> > > > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > > > ---
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0net/sunrpc/clnt.c | 2 +-
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A01 file changed, 1 insertion(+), 1 del=
etion(-)
> > > > > > >=20
> > > > > > > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > > > > > > index 21426c3049d3..701b742750c5 100644
> > > > > > > --- a/net/sunrpc/clnt.c
> > > > > > > +++ b/net/sunrpc/clnt.c
> > > > > > > @@ -2215,6 +2215,7 @@ call_connect_status(struct rpc_task
> > > > > > > *task)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	case -EHOSTUNREACH:
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	case -EPIPE:
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	case -EPROTO:
> > > > > > > +	case -ETIMEDOUT:
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0		xprt_conditional_disconnect(task-
> > > > > > > >tk_rqstp-
> > > > > > > > rq_xprt,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0					=C2=A0=C2=A0=C2=A0 task-
> > > > > > > >tk_rqstp-
> > > > > > > > rq_connect_cookie);
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0		if (RPC_IS_SOFTCONN(task))
> > > > > > > @@ -2225,7 +2226,6 @@ call_connect_status(struct rpc_task
> > > > > > > *task)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	case -EADDRINUSE:
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	case -ENOTCONN:
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	case -EAGAIN:
> > > > > > > -	case -ETIMEDOUT:
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0		if (!(task->tk_flags &
> > > > > > > RPC_TASK_NO_ROUND_ROBIN)
> > > > > > > &&
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0 (task->tk_flags =
& RPC_TASK_MOVEABLE)
> > > > > > > &&
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0 test_bit(XPRT_RE=
MOVE, &xprt->state))
> > > > > > > {
> > > > > > Why is this needed? The ETIMEDOUT is supposed to be a task
> > > > > > level
> > > > > > error,
> > > > > > not a connection level thing.
> > > > > If TCP was not able to sent the SYN out on due to the
> > > > > transient
> > > > > error
> > > > > with the link status and the task just turns around a wait
> > > > > again,
> > > > > since
> > > > > TCP does not retry the SYN, eventually systemd times out and
> > > > > stops
> > > > > the
> > > > > mount.
> > > > >=20
> > > > >=20
> > > > > Below is the snippet from the system log with rpcdebug
> > > > > enabled:
> > > > >=20
> > > > >=20
> > > > > Jun 20 10:23:01 qa-i360-odi03 kernel: i40e 0000:98:00.0 eth1:
> > > > > NIC
> > > > > Link is Up, 10 Gbps Full Duplex, Flow Control: None
> > > > > Jun 20 10:23:09 qa-i360-odi03 NetworkManager[1511]: <info>
> > > > > [1750414989.6033] manager: startup complete
> > > > >=20
> > > > > ... <NFS mount starts>
> > > > > Jun 20 10:23:09 qa-i360-odi03 systemd[1]: Mounting /odi...
> > > > > ...
> > > > > Jun 20 10:23:09 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=
=A0 1 added to
> > > > > queue
> > > > > 0000000093f481cd "xprt_pending"
> > > > > Jun 20 10:23:09 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=
=A0 1 setting
> > > > > alarm
> > > > > for
> > > > > 60000 ms
> > > > >=20
> > > > > ... <link status down & up>
> > > > > Jun 20 10:23:10 qa-i360-odi03 kernel: tg3 0000:04:00.0 em1:
> > > > > Link
> > > > > is
> > > > > up at 1000 Mbps, full duplex
> > > > > Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
> > > > > [1750414990.6359] device (em1): state change: disconnected ->
> > > > > prepare
> > > > > (reason 'none', sys-iface-state: 'managed')
> > > > > Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
> > > > > [1750414990.6361] device (em1): state change: prepare ->
> > > > > config
> > > > > (reason 'none', sys-iface-state: 'managed')
> > > > > Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
> > > > > [1750414990.6364] device (em1): state change: config -> ip-
> > > > > config
> > > > > (reason 'none', sys-iface-state: 'managed')
> > > > > Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>
> > > > > [1750414990.6383] device (em1): Activation: successful,
> > > > > device
> > > > > activated.
> > > > >=20
> > > > > ... <connect timed out>
> > > > > Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=
=A0 1 timeout
> > > > > Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=
=A0 1
> > > > > __rpc_wake_up_task
> > > > > (now 4294742016)
> > > > > Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=
=A0 1 disabling
> > > > > timer
> > > > > Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=
=A0 1 removed from
> > > > > queue
> > > > > 0000000093f481cd "xprt_pending"
> > > > > Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=
=A0 1
> > > > > call_connect_status
> > > > > (status -110)
> > > > >=20
> > > > > ... <wait again>
> > > > > Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=
=A0 1
> > > > > sleep_on(queue
> > > > > "xprt_pending" time 4294742016)
> > > > > Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=
=A0 1 added to
> > > > > queue
> > > > > 0000000093f481cd "xprt_pending"
> > > > >=20
> > > > > ... <systemd timed out>
> > > > > Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mounting
> > > > > timed
> > > > > out. Terminating.
> > > > >=20
> > > > > Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=
=A0 1 got signal
> > > > > Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=
=A0 1
> > > > > __rpc_wake_up_task
> > > > > (now 4294770229)
> > > > > Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=
=A0 1 disabling
> > > > > timer
> > > > > Jun 20 10:24:39 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=
=A0 1 removed from
> > > > > queue
> > > > > 0000000093f481cd "xprt_pending"
> > > > >=20
> > > > > Jun 20 10:24:39 qa-i360-odi03 kernel: <-- nfs4_try_mount() =3D
> > > > > -512
> > > > > [error]
> > > > > Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mount
> > > > > process
> > > > > exited, code=3Dkilled status=3D15
> > > > > Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Failed
> > > > > with
> > > > > result 'timeout'.
> > > > >=20
> > > > > This patch forces TCP to send the SYN on ETIMEDOUT error.
> > > > >=20
> > > > Something is very wrong here...
> > > >=20
> > > > If this patch is correct, and the call to
> > > > xprt_conditional_disconnect()
> > > > does indeed cause the socket to close, then something must have
> > > > bumped
> > > > xprt->connect_cookie.
> > > I'm a little confused here, xprt_conditional_disconnect only
> > > closes
> > > the
> > > socket if the connect cookie is still the same:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cookie !=
=3D xprt->connect_cookie)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > >=20
> > > So in this case the xprt->connect_cookie has not been bumped.
> > You're right... Sorry...
> >=20
> > So does this mean that the socket is still in the SYN-SENT state?
> > It is
> > normally supposed to remain in that state for 60 seconds, and
> > resend
> > SYN using an exponential back off.
>=20
> Apparently this was not done by TCP in this scenario:
>=20
> ... mount starts
> Jun 20 10:23:09 qa-i360-odi03 systemd[1]: Mounting /odi...
> Jun 20 10:23:09 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=A0 1 adde=
d to queue
> 0000000093f481cd "xprt_pending"
>=20
> Jun 20 10:23:10 qa-i360-odi03 NetworkManager[1511]: <info>=C2=A0
> [1750414990.6383] device (em1): Activation: successful, device
> activated.
>=20
> ... RPC task timed out on connect after 62 secs.=C2=A0 Note that at this
> time the network link status was already up for more than 60 secs
> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=A0 1 time=
out
> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=A0 1 __rp=
c_wake_up_task
> (now 4294742016)
>=20
> ... RPC task goes back and wait again.
> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=A0 1 slee=
p_on(queue
> "xprt_pending" time 4294742016)
> Jun 20 10:24:11 qa-i360-odi03 kernel: RPC:=C2=A0=C2=A0=C2=A0=C2=A0 1 adde=
d to queue
> 0000000093f481cd "xprt_pending"
>=20
> ... nothing happened and systemd timed out after 90 secs and kill the
> mount
> Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mounting timed
> out. Terminating.
> Jun 20 10:24:39 qa-i360-odi03 kernel: <-- nfs4_try_mount() =3D -512
> [error]
> Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Mount process
> exited, code=3Dkilled status=3D15
> Jun 20 10:24:39 qa-i360-odi03 systemd[1]: odi.mount: Failed with
> result 'timeout'.
>=20
> I don't know why TCP does not retry the SYN after the networkk link
> is
> up again but I though instead of trying to figure out and fix the
> problem
> at TCP layer, we can make the RPC connect process a bit more robust
> by using
> a new socket for retry.
>=20

We should never be using individual RPC message timeouts as a measure
for whether or not the TCP connection is down.

For the initial connection attempt, we use the TCP_SYNCNT socket option
to decide when to give up. Once the connection is established, we set
TCP_USER_TIMEOUT as well as socket keepalive to ensure that the
connection is still alive.

I'm willing to consider further socket-specific timers, but not if the
reason is to work around bugs (assuming that is indeed the case here).

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

