Return-Path: <linux-nfs+bounces-2576-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAD9893B21
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 14:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B526E281E8C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C21219F9;
	Mon,  1 Apr 2024 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzTF6HoR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B81E888
	for <linux-nfs@vger.kernel.org>; Mon,  1 Apr 2024 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711975792; cv=none; b=W3KheZztHcqTtUx+PykuiDNk+QoyT18YW8GJ6O+6yMyiZPffLY91Z33G0xQC0SkXORaBZmApsMHSzi+qcLc7WQKhf4G0LS1LHxyTD+8yP9O6wVMw8mLTD99wI6Ufkw9sGrquttHROg5ZN7lNiv+6q0UG6bRNg1oDb4YwMMps8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711975792; c=relaxed/simple;
	bh=lgz5YepQvaONK8JCHBTP8InjXGMT4xe42+ZcpcQ2oRA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N41g6SXzqIWCHUrNja2ySEEIB2uYOGYq7F4uLe/sR7dF9IFsowtCoqMVV3mEG0JqofSK1N51WYoyM707wA6nL/7TyzeLgfH9hgZ6y9+9Y8EH1DQzXu6wpnPKrgeUnCQGbqtTlvVD1hi4NPcmdtB5bV3QamrmXMFNZKcN1cOiygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzTF6HoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C20C433F1;
	Mon,  1 Apr 2024 12:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711975791;
	bh=lgz5YepQvaONK8JCHBTP8InjXGMT4xe42+ZcpcQ2oRA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SzTF6HoRh8DNJYPtifxiTkoPUVnAfwhp4m/7Sx+nMJ2PZlbilj0Zl9ZYnRlKMAjgX
	 IbRA4po4NntWv0j/aKIbs1n/FaGZzgS363h5wEt6UZ85pti/Chb28bZg8aOILsct21
	 SdusGwaD6lDKvWWMGr5d2Cm2fVRog1hTHeGREEO9MVgCz6wVpfdL912EAfV3AKrk3Z
	 W9kgxscDt23gAfmd3+URhQAS02FOkw0jNByEl0mVWEuFvbRRXML/h2etGrqoO0G2Ez
	 Cwx+hisSflKbskfhWI6DiRNYLViWmwmCXNvcF8pC7vFywbICegbZPWufXntFdbC912
	 z+dp1dV27L5XQ==
Message-ID: <039c7e38b70287541849ab03d92818740fdf5d43.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
From: Jeff Layton <jlayton@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Date: Mon, 01 Apr 2024 08:49:49 -0400
In-Reply-To: <84d6311e-a0a3-4fc6-a87e-e09857c765b3@oracle.com>
References: <1711476809-26248-1-git-send-email-dai.ngo@oracle.com>
	 <ZgMToHNkkGEHNb/y@tissot.1015granger.net>
	 <69914825-e9d5-4859-a5a8-60d17e8e8bf6@oracle.com>
	 <ZgV5zwR0q/vjBAtI@tissot.1015granger.net>
	 <88fac8af-c194-452b-94eb-7658b9056246@oracle.com>
	 <c97be8b9-c0ba-4f2d-9340-78368008ba4b@oracle.com>
	 <ZgbWevtNp8Vust4A@tissot.1015granger.net>
	 <97387ec5-bcb4-4c5e-81af-a0038f7fc311@oracle.com>
	 <ZgdR48dhdSoUj+VM@tissot.1015granger.net>
	 <09da882f-4bad-4398-a2d0-ef8daefce374@oracle.com>
	 <ZghZzfIi5RkWDh9K@tissot.1015granger.net>
	 <84d6311e-a0a3-4fc6-a87e-e09857c765b3@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-30 at 16:30 -0700, Dai Ngo wrote:
> On 3/30/24 11:28 AM, Chuck Lever wrote:
> > On Sat, Mar 30, 2024 at 10:46:08AM -0700, Dai Ngo wrote:
> > > On 3/29/24 4:42 PM, Chuck Lever wrote:
> > > > On Fri, Mar 29, 2024 at 10:57:22AM -0700, Dai Ngo wrote:
> > > > > On 3/29/24 7:55 AM, Chuck Lever wrote:
> > > > > > On Thu, Mar 28, 2024 at 05:31:02PM -0700, Dai Ngo wrote:
> > > > > > > On 3/28/24 11:14 AM, Dai Ngo wrote:
> > > > > > > > On 3/28/24 7:08 AM, Chuck Lever wrote:
> > > > > > > > > On Wed, Mar 27, 2024 at 06:09:28PM -0700, Dai Ngo wrote:
> > > > > > > > > > On 3/26/24 11:27 AM, Chuck Lever wrote:
> > > > > > > > > > > On Tue, Mar 26, 2024 at 11:13:29AM -0700, Dai Ngo wro=
te:
> > > > > > > > > > > > Currently when a nfs4_client is destroyed we wait f=
or
> > > > > > > > > > > > the cb_recall_any
> > > > > > > > > > > > callback to complete before proceed. This adds
> > > > > > > > > > > > unnecessary delay to the
> > > > > > > > > > > > __destroy_client call if there is problem communica=
ting
> > > > > > > > > > > > with the client.
> > > > > > > > > > > By "unnecessary delay" do you mean only the seven-sec=
ond RPC
> > > > > > > > > > > retransmit timeout, or is there something else?
> > > > > > > > > > when the client network interface is down, the RPC task=
 takes ~9s to
> > > > > > > > > > send the callback, waits for the reply and gets ETIMEDO=
UT. This process
> > > > > > > > > > repeats in a loop with the same RPC task before being s=
topped by
> > > > > > > > > > rpc_shutdown_client after client lease expires.
> > > > > > > > > I'll have to review this code again, but rpc_shutdown_cli=
ent
> > > > > > > > > should cause these RPCs to terminate immediately and safe=
ly. Can't
> > > > > > > > > we use that?
> > > > > > > > rpc_shutdown_client works, it terminated the RPC call to st=
op the loop.
> > > > > > > >=20
> > > > > > > > > > It takes a total of about 1m20s before the CB_RECALL is=
 terminated.
> > > > > > > > > > For CB_RECALL_ANY and CB_OFFLOAD, this process gets in =
to a infinite
> > > > > > > > > > loop since there is no delegation conflict and the clie=
nt is allowed
> > > > > > > > > > to stay in courtesy state.
> > > > > > > > > >=20
> > > > > > > > > > The loop happens because in nfsd4_cb_sequence_done if c=
b_seq_status
> > > > > > > > > > is 1 (an RPC Reply was never received) it calls nfsd4_m=
ark_cb_fault
> > > > > > > > > > to set the NFSD4_CB_FAULT bit. It then sets cb_need_res=
tart to true.
> > > > > > > > > > When nfsd4_cb_release is called, it checks cb_need_rest=
art bit and
> > > > > > > > > > re-queues the work again.
> > > > > > > > > Something in the sequence_done path should check if the s=
erver is
> > > > > > > > > tearing down this callback connection. If it doesn't, tha=
t is a bug
> > > > > > > > > IMO.
> > > > > > > TCP terminated the connection after retrying for 16 minutes a=
nd
> > > > > > > notified the RPC layer which deleted the nfsd4_conn.
> > > > > > The server should have closed this connection already.
> > > > > Since there is no delegation conflict, the client remains in cour=
tesy
> > > > > state.
> > > > >=20
> > > > > >     Is it stuck
> > > > > > waiting for the client to respond to a FIN or something?
> > > > > No, in this case since the client network interface was down serv=
er
> > > > > TCP did not even receive ACK for the transmit so the server TCP
> > > > > kept retrying.
> > > > It sounds like the server attempts to maintain the client's
> > > > transport while the client is in courtesy state?
> > > Yes, TCP keeps retryingwhile the client is in courtesy state.
> > So the client hasn't sent a lease-renewing operation recently, but
> > the connection is still there. It then makes sense for the server to
> > forcibly close the connection when a client transitions to the
> > courtesy state, since that connection instance is suspect.
>=20
> yes, this makes sense. This would make the RPC to stop within a
> lease period.
>=20
> I'll submit a patch to kill the back channel connection if there
> is RPC pending and the client is about to enter courtesy state.
>=20
> >=20
> > The server would then recognize immediately that it shouldn't post
> > any new backchannel operations to that client until it gets a fresh
> > connection attempt from it.
>=20
> Currently deleg_reaper does not issue CB_RECALL_ANY for courtesy clients.
>=20
> >=20
> >=20
> > > > I thought the
> > > > purpose of courteous server was to more gracefully handle network
> > > > partitions, in which case, the transport is not reliable.
> > > >=20
> > > > If a courtesy client hasn't re-established a connection with a
> > > > backchannel by the time a conflicting open/lock request arrives,
> > > > the server has no choice but to expire that client's courtesy
> > > > state immediately. Right?
> > > Yes, that is the case for CB_RECALL but not for CB_RECALL_ANY.
> > CB_RECALL_ANY is done by a shrinker, yes?
>=20
> CB_RECALL_ANY is done by the memory shrinker or when
> num_delegations >=3D max_delegations.
>=20
> >=20
> > Instead of attempting to send a CB_RECALL_ANY to a courtesy client
> > which is likely to be unresponsive, why not just expire the oldest
> > courtesy client the server has? Or... if NFSD /already/ expires the
> > oldest courtesy client as a result of memory pressure, then just
> > don't ever send CB_RECALL_ANY to courtesy clients.
>=20
> Currently deleg_reaper does not issue CB_RECALL_ANY for courtesy clients.
>=20
> >=20
> > As soon as a courtesy client reconnects, it will send a lease-
> > renewing operation, transition back to an active state, and at that
> > point it re-qualifies for getting CB_RECALL_ANY.
> >=20
> >=20
> > > > But maybe that's a side-bar.
> > > >=20
> > > >=20
> > > > > > > But when nfsd4_run_cb_work ran again, it got into the infinit=
e
> > > > > > > loop caused by:
> > > > > > >         /*
> > > > > > >          * XXX: Ideally, we could wait for the client to
> > > > > > >          *      reconnect, but I haven't figured out how
> > > > > > >          *      to do that yet.
> > > > > > >          */
> > > > > > >          nfsd4_queue_cb_delayed(cb, 25);
> > > > > > >=20
> > > > > > > which was introduced by c1ccfcf1a9bf. Note that I'm using 6.9=
-rc1.
> > > > > > The whole paragraph is:
> > > > > >=20
> > > > > > 1503         clnt =3D clp->cl_cb_client;
> > > > > > 1504         if (!clnt) {
> > > > > > 1505                 if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->c=
l_flags))
> > > > > > 1506                         nfsd41_destroy_cb(cb);
> > > > > > 1507                 else {
> > > > > > 1508                         /*
> > > > > > 1509                          * XXX: Ideally, we could wait for=
 the client to
> > > > > > 1510                          *      reconnect, but I haven't f=
igured out how
> > > > > > 1511                          *      to do that yet.
> > > > > > 1512                          */
> > > > > > 1513                         nfsd4_queue_cb_delayed(cb, 25);
> > > > > > 1514                 }
> > > > > > 1515                 return;
> > > > > > 1516         }
> > > > > >=20
> > > > > > When there's no rpc_clnt and CB_KILL is set, the callback
> > > > > > operation should be destroyed immediately. CB_KILL is set by
> > > > > > nfsd4_shutdown_callback. It's only caller is
> > > > > > __destroy_client().
> > > > > >=20
> > > > > > Why isn't NFSD4_CLIENT_CB_KILL set?
> > > > > Since __destroy_client was not called, for the reason mentioned a=
bove,
> > > > > nfsd4_shutdown_callback was not called so NFSD4_CLIENT_CB_KILL wa=
s not
> > > > > set.
> > > > Well, then I'm missing something. You said, above:
> > > >=20
> > > > > Currently when a nfs4_client is destroyed we wait for
> > > > And __destroy_client() invokes nfsd4_shutdown_callback(). Can you
> > > > explain the usage scenario(s) to me again?
> > > __destroy_client is not called in the case of CB_RECALL_ANY since
> > > there is no open/lock conflict associated the the client.
> > > > > Since the nfsd callback_wq was created with alloc_ordered_workque=
ue,
> > > > > once this loop happens the nfsd callback_wq is stuck since this w=
orkqueue
> > > > > executes at most one work item at any given time.
> > > > >=20
> > > > > This means that if a nfs client is shutdown and the server is in =
this
> > > > > state then all other clients are effected; all callbacks to other
> > > > > clients are stuck in the workqueue. And if a callback for a clien=
t is
> > > > > stuck in the workqueue then that client can not unmount its share=
s.
> > > > >=20
> > > > > This is the symptom that was reported recently on this list. I th=
ink
> > > > > the nfsd callback_wq should be created as a normal workqueue that=
 allows
> > > > > multiple work items to be executed at the same time so a problem =
with
> > > > > one client does not effect other clients.
> > > > My impression is that the callback_wq is single-threaded to avoid
> > > > locking complexity. I'm not yet convinced it would be safe to simpl=
y
> > > > change that workqueue to permit multiple concurrent work items.
> > > Do you have any specific concern about lock complexity related to
> > > callback operation?
> > If there needs to be a fix, I'd like something for v6.9-rc, so it
> > needs to be a narrow change. Larger infrastructural changes have to
> > go via a full merge window.
> >=20
> >=20
> > > > It could be straightforward, however, to move the callback_wq into
> > > > struct nfs4_client so that each client can have its own workqueue.
> > > > Then we can take some time and design something less brittle and
> > > > more scalable (and maybe come up with some test infrastructure so
> > > > this stuff doesn't break as often).
> > > IMHO I don't see why the callback workqueue has to be different
> > > from the laundry_wq or nfsd_filecache_wq used by nfsd.
> > You mean, you don't see why callback_wq has to be ordered, while
> > the others are not so constrained? Quite possibly it does not have
> > to be ordered.
>=20
> Yes, I looked at the all the nfsd4_callback_ops on nfsd and they
> seems to take into account of concurrency and use locks appropriately.
> For each type of work I don't see why one work has to wait for
> the previous work to complete before proceed.
>=20
> >=20
> > But we might have lost the bit of history that explains why, so
> > let's be cautious about making broad changes here until we have a
> > good operational understanding of the code and some robust test
> > cases to check any changes we make.
>=20
> Understand, you make the call.
>=20

commit 88382036674770173128417e4c09e9e549f82d54
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Nov 14 11:13:43 2016 -0500

    nfsd: update workqueue creation
   =20
    No real change in functionality, but the old interface seems to be
    deprecated.
   =20
    We don't actually care about ordering necessarily, but we do depend on
    running at most one work item at a time: nfsd4_process_cb_update()
    assumes that no other thread is running it, and that no new callbacks
    are starting while it's running.
   =20
    Reviewed-by: Jeff Layton <jlayton@redhat.com>
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>


...so it may be as simple as just fixing up nfsd4_process_cb_update().
Allowing parallel recalls would certainly be a good thing.

That said, a workqueue per client would be a great place to start. I
don't see any reason to serialize callbacks to different clients.
--
Jeff Layton <jlayton@kernel.org>

