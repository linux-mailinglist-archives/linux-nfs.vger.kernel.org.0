Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596AF60BDC5
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 00:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiJXWso (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 18:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJXWsZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 18:48:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7B8100BED
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 14:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77A27B811A3
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 21:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BE8C433D6;
        Mon, 24 Oct 2022 21:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666645762;
        bh=Fhc6WVdvTKCAeZkB+csqkVj5CU6cDlBHjInTRyGms4U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PCDOscAPGHkxK/zCWlpddWeJ/IpcrDKWLzHoFWMxe5qKZmHkttVROSK3HVhMMn0RD
         Rr4rE9yYP1rB+5aERCpn8Ceu5NE+684u8PZ2rgdEVmESAhqn9arfY0T+S1w3BIEoxn
         rttujgP9Zfgr8gU6eI6mmfLE6UgbqnJ83eo0M+osHZ2nRa2yL8s/TEp85bofAv1LIw
         JrVl09HWWyEmzR070VC3alBzPPCAkJ6/iKErxjhrEs0ZUYu//owAOofsUYdfrIcq/N
         tEJLzEuz5QtWklyA3ac0SlPyD2XbVa2U3pE3iR5emHExQaUGizRIfL6urLy2V6dCsy
         ps3u4b4opGksA==
Message-ID: <342dd03eea9a1eccf1848c1e2f5f92791c4c42f2.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] NFSD: add support for sending CB_RECALL_ANY
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 24 Oct 2022 17:09:20 -0400
In-Reply-To: <efbea8dd-1998-fe2a-1a94-6becc5ea691f@oracle.com>
References: <1666462150-11736-1-git-send-email-dai.ngo@oracle.com>
         <1666462150-11736-2-git-send-email-dai.ngo@oracle.com>
         <d43a3dac01f8c4211ec7634a0d78dae70468f39b.camel@kernel.org>
         <efbea8dd-1998-fe2a-1a94-6becc5ea691f@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-24 at 12:44 -0700, dai.ngo@oracle.com wrote:
> On 10/24/22 5:16 AM, Jeff Layton wrote:
> > On Sat, 2022-10-22 at 11:09 -0700, Dai Ngo wrote:
> > > There is only one nfsd4_callback, cl_recall_any, added for each
> > > nfs4_client. Access to it must be serialized. For now it's done
> > > by the cl_recall_any_busy flag since it's used only by the
> > > delegation shrinker. If there is another consumer of CB_RECALL_ANY
> > > then a spinlock must be used.
> > >=20
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > >   fs/nfsd/nfs4callback.c | 64 +++++++++++++++++++++++++++++++++++++++=
+++++++++++
> > >   fs/nfsd/nfs4state.c    | 27 +++++++++++++++++++++
> > >   fs/nfsd/state.h        |  8 +++++++
> > >   fs/nfsd/xdr4cb.h       |  6 +++++
> > >   4 files changed, 105 insertions(+)
> > >=20
> > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > index f0e69edf5f0f..03587e1397f4 100644
> > > --- a/fs/nfsd/nfs4callback.c
> > > +++ b/fs/nfsd/nfs4callback.c
> > > @@ -329,6 +329,29 @@ static void encode_cb_recall4args(struct xdr_str=
eam *xdr,
> > >   }
> > >  =20
> > >   /*
> > > + * CB_RECALLANY4args
> > > + *
> > > + *	struct CB_RECALLANY4args {
> > > + *		uint32_t	craa_objects_to_keep;
> > > + *		bitmap4		craa_type_mask;
> > > + *	};
> > > + */
> > > +static void
> > > +encode_cb_recallany4args(struct xdr_stream *xdr,
> > > +			struct nfs4_cb_compound_hdr *hdr, uint32_t bmval)
> > > +{
> > > +	__be32 *p;
> > > +
> > > +	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
> > > +	p =3D xdr_reserve_space(xdr, 4);
> > > +	*p++ =3D xdr_zero;	/* craa_objects_to_keep */
> > > +	p =3D xdr_reserve_space(xdr, 8);
> > > +	*p++ =3D cpu_to_be32(1);
> > > +	*p++ =3D cpu_to_be32(bmval);
> > > +	hdr->nops++;
> > > +}
> > > +
> > > +/*
> > >    * CB_SEQUENCE4args
> > >    *
> > >    *	struct CB_SEQUENCE4args {
> > > @@ -482,6 +505,24 @@ static void nfs4_xdr_enc_cb_recall(struct rpc_rq=
st *req, struct xdr_stream *xdr,
> > >   	encode_cb_nops(&hdr);
> > >   }
> > >  =20
> > > +/*
> > > + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
> > > + */
> > > +static void
> > > +nfs4_xdr_enc_cb_recall_any(struct rpc_rqst *req,
> > > +		struct xdr_stream *xdr, const void *data)
> > > +{
> > > +	const struct nfsd4_callback *cb =3D data;
> > > +	struct nfs4_cb_compound_hdr hdr =3D {
> > > +		.ident =3D cb->cb_clp->cl_cb_ident,
> > > +		.minorversion =3D cb->cb_clp->cl_minorversion,
> > > +	};
> > > +
> > > +	encode_cb_compound4args(xdr, &hdr);
> > > +	encode_cb_sequence4args(xdr, cb, &hdr);
> > > +	encode_cb_recallany4args(xdr, &hdr, cb->cb_clp->cl_recall_any_bm);
> > > +	encode_cb_nops(&hdr);
> > > +}
> > >  =20
> > >   /*
> > >    * NFSv4.0 and NFSv4.1 XDR decode functions
> > > @@ -520,6 +561,28 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqs=
t *rqstp,
> > >   	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
> > >   }
> > >  =20
> > > +/*
> > > + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
> > > + */
> > > +static int
> > > +nfs4_xdr_dec_cb_recall_any(struct rpc_rqst *rqstp,
> > > +				  struct xdr_stream *xdr,
> > > +				  void *data)
> > > +{
> > > +	struct nfsd4_callback *cb =3D data;
> > > +	struct nfs4_cb_compound_hdr hdr;
> > > +	int status;
> > > +
> > > +	status =3D decode_cb_compound4res(xdr, &hdr);
> > > +	if (unlikely(status))
> > > +		return status;
> > > +	status =3D decode_cb_sequence4res(xdr, cb);
> > > +	if (unlikely(status || cb->cb_seq_status))
> > > +		return status;
> > > +	status =3D  decode_cb_op_status(xdr, OP_CB_RECALL_ANY, &cb->cb_stat=
us);
> > > +	return status;
> > > +}
> > > +
> > >   #ifdef CONFIG_NFSD_PNFS
> > >   /*
> > >    * CB_LAYOUTRECALL4args
> > > @@ -783,6 +846,7 @@ static const struct rpc_procinfo nfs4_cb_procedur=
es[] =3D {
> > >   #endif
> > >   	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
> > >   	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
> > > +	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
> > >   };
> > >  =20
> > >   static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 4e718500a00c..c60c937dece6 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -2854,6 +2854,31 @@ static const struct tree_descr client_files[] =
=3D {
> > >   	[3] =3D {""},
> > >   };
> > >  =20
> > > +static int
> > > +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
> > > +			struct rpc_task *task)
> > > +{
> > > +	switch (task->tk_status) {
> > > +	case -NFS4ERR_DELAY:
> > > +		rpc_delay(task, 2 * HZ);
> > > +		return 0;
> > > +	default:
> > > +		return 1;
> > > +	}
> > > +}
> > > +
> > > +static void
> > > +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
> > > +{
> > > +	cb->cb_clp->cl_recall_any_busy =3D false;
> > > +	atomic_dec(&cb->cb_clp->cl_rpc_users);
> > > +}
> >=20
> > This series probably ought to be one big patch. The problem is that
> > you're adding a bunch of code to do CB_RECALL_ANY, but there is no way
> > to call it without patch #2.
>=20
> The reason I separated these patches is that the 1st patch, adding suppor=
t
> CB_RECALL_ANY can be called for other purposes than just for delegation s=
uch
> as to recall pnfs layouts, or when the max number of delegation is reache=
d.
> So that was why I did not combined this patches. However, I understand yo=
ur
> concern about not being able to test individual patch. So as Chuck sugges=
ted,
> perhaps we can leave these as separate patches for easier review and when=
 it's
> finalized we can decide to combine them in to one big patch.  BTW, I plan=
 to
> add a third patch to this series to send CB_RECALL_ANY to clients when th=
e
> max number of delegations is reached.
>=20

I think we should get this bit sorted out first, but that sounds
reasonable eventually.

> >=20
> > That makes it hard to judge whether there could be races and locking
> > issues around the handling of cb_recall_any_busy, in particular. From
> > patch #2, it looks like cb_recall_any_busy is protected by the
> > nn->client_lock, but I don't think ->release is called with that held.
>=20
> I don't intended to use the nn->client_lock, I think the scope of this
> lock is too big for what's needed to serialize access to struct nfsd4_cal=
lback.
> As I mentioned in the cover email, since the cb_recall_any_busy is only
> used by the deleg_reaper we do not need a lock to protect this flag.
> But if there is another of consumer, other than deleg_reaper, of this
> nfsd4_callback then we can add a simple spinlock for it.
>=20
> My question is do you think we need to add the spinlock now instead of
> delaying it until there is real need?
>=20

I don't see the need for a dedicated spinlock here. You said above that
there is only one of these per client, so you could use the
client->cl_lock.

But...I don't see the problem with doing just using the nn->client_lock
here. It's not like we're likely to be calling this that often, and if
we do then the contention for the nn->client_lock is probably the least
of our worries.

Honestly, do we need this boolean at all? The only place it's checked is
in deleg_reaper. Why not just try to submit the work and if it's already
queued, let it fail?

> >=20
> > Also, cl_rpc_users is a refcount (though we don't necessarily free the
> > object when it goes to zero). I think you need to call
> > put_client_renew_locked here instead of just decrementing the counter.
>=20
> Since put_client_renew_locked() also renews the client lease, I don't
> think it's right nfsd4_cb_recall_any_release to renew the lease because
> because this is a callback so the client is not actually sending any
> request that causes the lease to renewed, and nfsd4_cb_recall_any_release
> is also alled even if the client is completely dead and did not reply, or
> reply with some errors.
>=20

What happens when this atomic_inc makes the cl_rpc_count go to zero?
What actually triggers the cleanup activities in put_client_renew /
put_client_renew_locked in that situation?

>=20
> >=20
> > > +
> > > +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops =3D {
> > > +	.done		=3D nfsd4_cb_recall_any_done,
> > > +	.release	=3D nfsd4_cb_recall_any_release,
> > > +};
> > > +
> > >   static struct nfs4_client *create_client(struct xdr_netobj name,
> > >   		struct svc_rqst *rqstp, nfs4_verifier *verf)
> > >   {
> > > @@ -2891,6 +2916,8 @@ static struct nfs4_client *create_client(struct=
 xdr_netobj name,
> > >   		free_client(clp);
> > >   		return NULL;
> > >   	}
> > > +	nfsd4_init_cb(&clp->cl_recall_any, clp, &nfsd4_cb_recall_any_ops,
> > > +			NFSPROC4_CLNT_CB_RECALL_ANY);
> > >   	return clp;
> > >   }
> > >  =20
> > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > index e2daef3cc003..49ca06169642 100644
> > > --- a/fs/nfsd/state.h
> > > +++ b/fs/nfsd/state.h
> > > @@ -411,6 +411,10 @@ struct nfs4_client {
> > >  =20
> > >   	unsigned int		cl_state;
> > >   	atomic_t		cl_delegs_in_recall;
> > > +
> > > +	bool			cl_recall_any_busy;
> > > +	uint32_t		cl_recall_any_bm;
> > > +	struct nfsd4_callback	cl_recall_any;
> > >   };
> > >  =20
> > >   /* struct nfs4_client_reset
> > > @@ -639,8 +643,12 @@ enum nfsd4_cb_op {
> > >   	NFSPROC4_CLNT_CB_OFFLOAD,
> > >   	NFSPROC4_CLNT_CB_SEQUENCE,
> > >   	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
> > > +	NFSPROC4_CLNT_CB_RECALL_ANY,
> > >   };
> > >  =20
> > > +#define RCA4_TYPE_MASK_RDATA_DLG	0
> > > +#define RCA4_TYPE_MASK_WDATA_DLG	1
> > > +
> > >   /* Returns true iff a is later than b: */
> > >   static inline bool nfsd4_stateid_generation_after(stateid_t *a, sta=
teid_t *b)
> > >   {
> > > diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
> > > index 547cf07cf4e0..0d39af1b00a0 100644
> > > --- a/fs/nfsd/xdr4cb.h
> > > +++ b/fs/nfsd/xdr4cb.h
> > > @@ -48,3 +48,9 @@
> > >   #define NFS4_dec_cb_offload_sz		(cb_compound_dec_hdr_sz  +      \
> > >   					cb_sequence_dec_sz +            \
> > >   					op_dec_sz)
> > > +#define NFS4_enc_cb_recall_any_sz	(cb_compound_enc_hdr_sz +       \
> > > +					cb_sequence_enc_sz +            \
> > > +					1 + 1 + 1)
> > > +#define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +      \
> > > +					cb_sequence_dec_sz +            \
> > > +					op_dec_sz)

--=20
Jeff Layton <jlayton@kernel.org>
