Return-Path: <linux-nfs+bounces-13975-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DACB40506
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 15:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA07561661
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 13:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F9314B7A;
	Tue,  2 Sep 2025 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3ibJ0zj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C030507B;
	Tue,  2 Sep 2025 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820441; cv=none; b=XUXRuFfKSSgspawafLp06BmZ2xXDAu1VIqRJ97oWZkBx7UQyKXqQ+vvaO7qgh6SNMhRHkFEvoDZ03eDusU8aDY74+N7GpXjBDrQzwEEx97gRiKchd1Yd83H9q9I6GMkvZcjtg594lj/Tq3EH+1Uau0gru853VfWjTgC3VNg1PLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820441; c=relaxed/simple;
	bh=e6Zn8P4/mGD/2aR+Wv1kt0PRjwWwH22Kv/fMhX//tIo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W9jWFbXyTqkkjtGIQ9jdrqAIUA3RKcucbP33cKvv8GEuzxiAQjATZpT8TA9L75og4F/9Z5Tm2WvC2QU4cyHnnuh0Mhko0uJmYVqrDZQH8FNVB8HNJFCW2TWql4ph99c70UnyDVVVZXs3P/pnbtAmJo5laBDuFZQMtALDOQESt18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3ibJ0zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12315C4CEED;
	Tue,  2 Sep 2025 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756820441;
	bh=e6Zn8P4/mGD/2aR+Wv1kt0PRjwWwH22Kv/fMhX//tIo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=f3ibJ0zjaZFKBZMbfwcnbIoRUuCZyQqVlIbKb8YdKNN57ooMQCSfVskU3e6mhUHTx
	 Wfi/GkzWEvtGS23x/bJ9Y6BN16PaIN04DANdoif+EzFFuXdBii/l1Qdd0zkWd16ACN
	 jLUEU2FmBixI01v8XOFV8VNt6+XdeiRnEq1y/QK/6AnMFoaCIfKsRUVxf3jgNM+xNl
	 vC7aAOLFDPy48v9a/b/nLhyuGXzWfMZRp2KJD8s9q7VMHNZZSmIcRCgOs1PzoW5AUU
	 S9ziBv874KvVn3Yxs9YiZd0SR7x2PICmPbuomn8vObPo0RlzJ2K8E1tpLSuCfHtXaj
	 DM06gr4m8EpuQ==
Message-ID: <d12ffd7c35e84b2d09bd91644bee8d88ce08cd2d.camel@kernel.org>
Subject: Re: [PATCH] nfsd: remove long-standing revoked delegations by force
From: Jeff Layton <jlayton@kernel.org>
To: Li Lingfeng <lilingfeng3@huawei.com>, chuck.lever@oracle.com, 
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com, lilingfeng@huaweicloud.com, zhangjian496@huawei.com
Date: Tue, 02 Sep 2025 09:40:38 -0400
In-Reply-To: <1ece2978-239c-4939-bb16-0c7c64614c66@huawei.com>
References: <20250902022237.1488709-1-lilingfeng3@huawei.com>
	 <a103653bc0dd231b897ffcd074c1f15151562502.camel@kernel.org>
	 <1ece2978-239c-4939-bb16-0c7c64614c66@huawei.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-02 at 20:10 +0800, Li Lingfeng wrote:
> Hi,
>=20
> =E5=9C=A8 2025/9/2 18:21, Jeff Layton =E5=86=99=E9=81=93:
> > On Tue, 2025-09-02 at 10:22 +0800, Li Lingfeng wrote:
> > > When file access conflicts occur between clients, the server recalls
> > > delegations. If the client holding delegation fails to return it afte=
r
> > > a recall, nfs4_laundromat adds the delegation to cl_revoked list.
> > > This causes subsequent SEQUENCE operations to set the
> > > SEQ4_STATUS_RECALLABLE_STATE_REVOKED flag, forcing the client to
> > > validate all delegations and return the revoked one.
> > >=20
> > > However, if the client fails to return the delegation due to a timeou=
t
> > > after receiving the recall or a server bug, the delegation remains in=
 the
> > > server's cl_revoked list. The client marks it revoked and won't find =
it
> > > upon detecting SEQ4_STATUS_RECALLABLE_STATE_REVOKED. This leads to a =
loop:
> > > the server persistently sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED, an=
d the
> > > client repeatedly tests all delegations, severely impacting performan=
ce
> > > when numerous delegations exist.
> > >=20
> > It is a performance impact, but I don't get the "loop" here. Are you
> > saying that this problem compounds itself? That testing all delegations
> > causes others to be revoked?
> The delegation will be removed from server->delegations in client after
> NFSPROC4_CLNT_DELEGRETURN is performed.
> nfs4_delegreturn_done
>  =C2=A0nfs_delegation_mark_returned
>  =C2=A0 nfs_detach_delegation
>  =C2=A0 =C2=A0nfs_detach_delegation_locked
>  =C2=A0 =C2=A0 list_del_rcu // remove delegation from server->delegations
>=20
>  From the client's perspective, the delegation has been returned, but on
> the server side, it is left in the cl_revoked list.[1].
>=20
> Subsequently, every sequence from the client will be flagged with
> SEQ4_STATUS_RECALLABLE_STATE_REVOKED as long as cl_revoked remains=20
> non-empty.
> nfsd4_sequence
>  =C2=A0seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOKED
>=20
> When the client detects SEQ4_STATUS_RECALLABLE_STATE_REVOKED while
> processing a sequence result, it sets NFS_DELEGATION_TEST_EXPIRED for all
> delegations and wakes up the state manager for handling.
> nfs41_sequence_done
>  =C2=A0nfs41_sequence_process
>  =C2=A0 nfs41_handle_sequence_flag_errors
>  =C2=A0 =C2=A0nfs41_handle_recallable_state_revoked
>  =C2=A0 =C2=A0 nfs_test_expired_all_delegations
>  =C2=A0 =C2=A0 =C2=A0nfs_mark_test_expired_all_delegations
>  =C2=A0 =C2=A0 =C2=A0 nfs_delegation_mark_test_expired_server
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0// set NFS_DELEGATION_TEST_EXPIRED for delega=
tions in=20
> server->delegations
>  =C2=A0 =C2=A0 =C2=A0nfs4_schedule_state_manager
>=20
> The state manager tests all delegations except the one that was returned,
> as it is no longer in server->delegations.
> nfs4_state_manager
>  =C2=A0nfs4_begin_drain_session
>  =C2=A0nfs_reap_expired_delegations
>  =C2=A0 nfs_server_reap_expired_delegations
>  =C2=A0 =C2=A0// test delegations in server->delegations
>=20
> There may be a loop:
> 1) send a sequence(client)
> 2) return SEQ4_STATUS_RECALLABLE_STATE_REVOKED(server)
> 3) set NFS_DELEGATION_TEST_EXPIRED for all delegations(client)
> 4) test all delegations by state manager(client)
> 5) send another sequence(client)
>=20
> The state manager's traversal of delegations occurs between
> nfs4_begin_drain_session and nfs4_end_drain_session. Non-privileged reque=
sts
> will be blocked because the NFS4_SLOT_TBL_DRAINING flag is set. If there =
are
> many delegations to traverse, this blocking time can be relatively long.
> > > Since abnormal delegations are removed from flc_lease via nfs4_laundr=
omat
> > > --> revoke_delegation --> destroy_unhashed_deleg -->
> > > nfs4_unlock_deleg_lease --> kernel_setlease, and do not block new ope=
n
> > > requests indefinitely, retaining such a delegation on the server is
> > > unnecessary.
> > >=20
> > > Reported-by: Zhang Jian <zhangjian496@huawei.com>
> > > Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_R=
EVOKED")
> > > Closes: https://lore.kernel.org/all/ff8debe9-6877-4cf7-ba29-fc98eae0f=
fa0@huawei.com/
> > > Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> > > ---
> > >   fs/nfsd/nfs4state.c | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 88c347957da5..aa65a685dbb9 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -4326,6 +4326,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
> > >   	int buflen;
> > >   	struct net *net =3D SVC_NET(rqstp);
> > >   	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > > +	struct list_head *pos, *next;
> > > +	struct nfs4_delegation *dp;
> > >  =20
> > >   	if (resp->opcnt !=3D 1)
> > >   		return nfserr_sequence_pos;
> > > @@ -4470,6 +4472,15 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> > >   	default:
> > >   		seq->status_flags =3D 0;
> > >   	}
> > > +	if (!list_empty(&clp->cl_revoked)) {
> > > +		list_for_each_safe(pos, next, &clp->cl_revoked) {
> > > +			dp =3D list_entry(pos, struct nfs4_delegation, dl_recall_lru);
> > > +			if (dp->dl_time < (ktime_get_boottime_seconds() - 2 * nn->nfsd4_l=
ease)) {
> > > +				list_del_init(&dp->dl_recall_lru);
> > > +				nfs4_put_stid(&dp->dl_stid);
> > > +			}
> > > +		}

FYI: this list is protected by the clp->cl_lock. You need to hold it to
do this list walk.

> > > +	}
> > >   	if (!list_empty(&clp->cl_revoked))
> > >   		seq->status_flags |=3D SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> > >   	if (atomic_read(&clp->cl_admin_revoked))
> > This seems like a violation of the spec. AIUI, the server is required
> > to hang onto a record of the delegation until the client does the
> > TEST_STATEID/FREE_STATEID dance to remove it. Just discarding them like
> > this seems wrong.
> Our expected outcome was that the client would release the abnormal
> delegation via TEST_STATEID/FREE_STATEID upon detecting its invalidity.
> However, this problematic delegation is no longer present in the
> client's server->delegations list=E2=80=94whether due to client-side time=
outs or
> the server-side bug [1].
> >=20
> > Should we instead just administratively evict the client since it's
> > clearly not behaving right in this case?
> Thanks for the suggestion. While administratively evicting the client wou=
ld
> certainly resolve the immediate delegation issue, I'm concerned that=20
> approach
> might be a bit heavy-handed.
> The problematic behavior seems isolated to a single delegation. Meanwhile=
,
> the client itself likely has numerous other open files and active state o=
n
> the server. Forcing a complete client reconnect would tear down all that
> state, which could cause significant application disruption and be percei=
ved
> as a service outage from the client's perspective.
>=20
> [1]=20
> https://lore.kernel.org/all/de669327-c93a-49e5-a53b-bda9e67d34a2@huawei.c=
om/
>=20
> Thanks,
> Lingfeng

Ok, I get the problem, but I still disagree with the solution. I don't
think we can just time these things out. Ideally we'd close the race
window, but the sc_status field is protected by the global state_lock
and I don't think we want to take it in revoke_delegation.

The best solution I can see is to have destroy_delegation()
unconditionally set SC_STATUS_CLOSED, and then you can do the list walk
above, but checking for that flag instead of testing for a timeout.

I'm still not thrilled with this solution though. It makes SEQUENCE a
bit more heavyweight than I'd like. I'm starting to think that we need
to rework the overall delegation locking, but that's an ugly problem to
tackle.=20
--=20
Jeff Layton <jlayton@kernel.org>

