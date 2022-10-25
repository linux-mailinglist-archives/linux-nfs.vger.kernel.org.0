Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0FC60C888
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 11:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiJYJjZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Oct 2022 05:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiJYJjD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Oct 2022 05:39:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8208B173592
        for <linux-nfs@vger.kernel.org>; Tue, 25 Oct 2022 02:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B33861842
        for <linux-nfs@vger.kernel.org>; Tue, 25 Oct 2022 09:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3F5C433C1;
        Tue, 25 Oct 2022 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666690651;
        bh=+47gKKb4WH0dmyNAyIw2qkM4i9mSnBN30S0nfTR1fM8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KLsxwbbTNxXgaZ5lSJcrvXUNRlKzPEJqy1aYc8weMJ1IeZiBWs+Rv2Y8RpnQ4ewuu
         XoJjNIHSLaiNJX38JC2+9/f27RH3cli97REiYHSoNxQLCkXxZcC2Llb9l/P6erwFbX
         w7UPbR1I5csh31hSrqkQhV8BlYFbFrdh0CHGlWxLa1HFfVcwMY5xoe+QwpibIM70qE
         ZyCaTlry9M5L6MLfB956JGpMd5pmDtOZDuAYz7V6SdUCZcZkOTsgldhupsUMr+2+ld
         C5u+PReIzjvR8whgUNczyjrvUOiVBbTUCwmz+/rZ+/BdrPlnQOQX6sVp5ODzcvcZoM
         GQksY/5xJUsug==
Message-ID: <fdfb20c4217f235d1754d3bf792e32811a760f32.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] NFSD: add support for sending CB_RECALL_ANY
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 25 Oct 2022 05:37:29 -0400
In-Reply-To: <df4ee39e5cda843416e7a88addabcba25594d618.camel@kernel.org>
References: <1666462150-11736-1-git-send-email-dai.ngo@oracle.com>
         <1666462150-11736-2-git-send-email-dai.ngo@oracle.com>
         <d43a3dac01f8c4211ec7634a0d78dae70468f39b.camel@kernel.org>
         <efbea8dd-1998-fe2a-1a94-6becc5ea691f@oracle.com>
         <342dd03eea9a1eccf1848c1e2f5f92791c4c42f2.camel@kernel.org>
         <ffcf7b71-8afd-bea1-9757-e7e0dc36f187@oracle.com>
         <df4ee39e5cda843416e7a88addabcba25594d618.camel@kernel.org>
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

On Tue, 2022-10-25 at 05:33 -0400, Jeff Layton wrote:
> On Mon, 2022-10-24 at 18:30 -0700, dai.ngo@oracle.com wrote:
> > On 10/24/22 2:09 PM, Jeff Layton wrote:
> > > On Mon, 2022-10-24 at 12:44 -0700, dai.ngo@oracle.com wrote:
> > > > On 10/24/22 5:16 AM, Jeff Layton wrote:
> > > > > On Sat, 2022-10-22 at 11:09 -0700, Dai Ngo wrote:
> > > > > > There is only one nfsd4_callback, cl_recall_any, added for each
> > > > > > nfs4_client. Access to it must be serialized. For now it's done
> > > > > > by the cl_recall_any_busy flag since it's used only by the
> > > > > > delegation shrinker. If there is another consumer of CB_RECALL_=
ANY
> > > > > > then a spinlock must be used.
> > > > > >=20
> > > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > > ---
> > > > > >    fs/nfsd/nfs4callback.c | 64 ++++++++++++++++++++++++++++++++=
++++++++++++++++++
> > > > > >    fs/nfsd/nfs4state.c    | 27 +++++++++++++++++++++
> > > > > >    fs/nfsd/state.h        |  8 +++++++
> > > > > >    fs/nfsd/xdr4cb.h       |  6 +++++
> > > > > >    4 files changed, 105 insertions(+)
> > > > > >=20
> > > > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > > > > index f0e69edf5f0f..03587e1397f4 100644
> > > > > > --- a/fs/nfsd/nfs4callback.c
> > > > > > +++ b/fs/nfsd/nfs4callback.c
> > > > > > @@ -329,6 +329,29 @@ static void encode_cb_recall4args(struct x=
dr_stream *xdr,
> > > > > >    }
> > > > > >   =20
> > > > > >    /*
> > > > > > + * CB_RECALLANY4args
> > > > > > + *
> > > > > > + *	struct CB_RECALLANY4args {
> > > > > > + *		uint32_t	craa_objects_to_keep;
> > > > > > + *		bitmap4		craa_type_mask;
> > > > > > + *	};
> > > > > > + */
> > > > > > +static void
> > > > > > +encode_cb_recallany4args(struct xdr_stream *xdr,
> > > > > > +			struct nfs4_cb_compound_hdr *hdr, uint32_t bmval)
> > > > > > +{
> > > > > > +	__be32 *p;
> > > > > > +
> > > > > > +	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
> > > > > > +	p =3D xdr_reserve_space(xdr, 4);
> > > > > > +	*p++ =3D xdr_zero;	/* craa_objects_to_keep */
> > > > > > +	p =3D xdr_reserve_space(xdr, 8);
> > > > > > +	*p++ =3D cpu_to_be32(1);
> > > > > > +	*p++ =3D cpu_to_be32(bmval);
> > > > > > +	hdr->nops++;
> > > > > > +}
> > > > > > +
> > > > > > +/*
> > > > > >     * CB_SEQUENCE4args
> > > > > >     *
> > > > > >     *	struct CB_SEQUENCE4args {
> > > > > > @@ -482,6 +505,24 @@ static void nfs4_xdr_enc_cb_recall(struct =
rpc_rqst *req, struct xdr_stream *xdr,
> > > > > >    	encode_cb_nops(&hdr);
> > > > > >    }
> > > > > >   =20
> > > > > > +/*
> > > > > > + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Ob=
jects
> > > > > > + */
> > > > > > +static void
> > > > > > +nfs4_xdr_enc_cb_recall_any(struct rpc_rqst *req,
> > > > > > +		struct xdr_stream *xdr, const void *data)
> > > > > > +{
> > > > > > +	const struct nfsd4_callback *cb =3D data;
> > > > > > +	struct nfs4_cb_compound_hdr hdr =3D {
> > > > > > +		.ident =3D cb->cb_clp->cl_cb_ident,
> > > > > > +		.minorversion =3D cb->cb_clp->cl_minorversion,
> > > > > > +	};
> > > > > > +
> > > > > > +	encode_cb_compound4args(xdr, &hdr);
> > > > > > +	encode_cb_sequence4args(xdr, cb, &hdr);
> > > > > > +	encode_cb_recallany4args(xdr, &hdr, cb->cb_clp->cl_recall_any=
_bm);
> > > > > > +	encode_cb_nops(&hdr);
> > > > > > +}
> > > > > >   =20
> > > > > >    /*
> > > > > >     * NFSv4.0 and NFSv4.1 XDR decode functions
> > > > > > @@ -520,6 +561,28 @@ static int nfs4_xdr_dec_cb_recall(struct r=
pc_rqst *rqstp,
> > > > > >    	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_statu=
s);
> > > > > >    }
> > > > > >   =20
> > > > > > +/*
> > > > > > + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Ob=
jects
> > > > > > + */
> > > > > > +static int
> > > > > > +nfs4_xdr_dec_cb_recall_any(struct rpc_rqst *rqstp,
> > > > > > +				  struct xdr_stream *xdr,
> > > > > > +				  void *data)
> > > > > > +{
> > > > > > +	struct nfsd4_callback *cb =3D data;
> > > > > > +	struct nfs4_cb_compound_hdr hdr;
> > > > > > +	int status;
> > > > > > +
> > > > > > +	status =3D decode_cb_compound4res(xdr, &hdr);
> > > > > > +	if (unlikely(status))
> > > > > > +		return status;
> > > > > > +	status =3D decode_cb_sequence4res(xdr, cb);
> > > > > > +	if (unlikely(status || cb->cb_seq_status))
> > > > > > +		return status;
> > > > > > +	status =3D  decode_cb_op_status(xdr, OP_CB_RECALL_ANY, &cb->c=
b_status);
> > > > > > +	return status;
> > > > > > +}
> > > > > > +
> > > > > >    #ifdef CONFIG_NFSD_PNFS
> > > > > >    /*
> > > > > >     * CB_LAYOUTRECALL4args
> > > > > > @@ -783,6 +846,7 @@ static const struct rpc_procinfo nfs4_cb_pr=
ocedures[] =3D {
> > > > > >    #endif
> > > > > >    	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lo=
ck),
> > > > > >    	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
> > > > > > +	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
> > > > > >    };
> > > > > >   =20
> > > > > >    static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_proced=
ures)];
> > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > index 4e718500a00c..c60c937dece6 100644
> > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > @@ -2854,6 +2854,31 @@ static const struct tree_descr client_fi=
les[] =3D {
> > > > > >    	[3] =3D {""},
> > > > > >    };
> > > > > >   =20
> > > > > > +static int
> > > > > > +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
> > > > > > +			struct rpc_task *task)
> > > > > > +{
> > > > > > +	switch (task->tk_status) {
> > > > > > +	case -NFS4ERR_DELAY:
> > > > > > +		rpc_delay(task, 2 * HZ);
> > > > > > +		return 0;
> > > > > > +	default:
> > > > > > +		return 1;
> > > > > > +	}
> > > > > > +}
> > > > > > +
> > > > > > +static void
> > > > > > +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
> > > > > > +{
> > > > > > +	cb->cb_clp->cl_recall_any_busy =3D false;
> > > > > > +	atomic_dec(&cb->cb_clp->cl_rpc_users);
> > > > > > +}
> > > > > This series probably ought to be one big patch. The problem is th=
at
> > > > > you're adding a bunch of code to do CB_RECALL_ANY, but there is n=
o way
> > > > > to call it without patch #2.
> > > > The reason I separated these patches is that the 1st patch, adding =
support
> > > > CB_RECALL_ANY can be called for other purposes than just for delega=
tion such
> > > > as to recall pnfs layouts, or when the max number of delegation is =
reached.
> > > > So that was why I did not combined this patches. However, I underst=
and your
> > > > concern about not being able to test individual patch. So as Chuck =
suggested,
> > > > perhaps we can leave these as separate patches for easier review an=
d when it's
> > > > finalized we can decide to combine them in to one big patch.  BTW, =
I plan to
> > > > add a third patch to this series to send CB_RECALL_ANY to clients w=
hen the
> > > > max number of delegations is reached.
> > > >=20
> > > I think we should get this bit sorted out first,
> >=20
> > ok
> >=20
> > >   but that sounds
> > > reasonable eventually.
> > >=20
> > > > > That makes it hard to judge whether there could be races and lock=
ing
> > > > > issues around the handling of cb_recall_any_busy, in particular. =
From
> > > > > patch #2, it looks like cb_recall_any_busy is protected by the
> > > > > nn->client_lock, but I don't think ->release is called with that =
held.
> > > > I don't intended to use the nn->client_lock, I think the scope of t=
his
> > > > lock is too big for what's needed to serialize access to struct nfs=
d4_callback.
> > > > As I mentioned in the cover email, since the cb_recall_any_busy is =
only
> > > > used by the deleg_reaper we do not need a lock to protect this flag=
.
> > > > But if there is another of consumer, other than deleg_reaper, of th=
is
> > > > nfsd4_callback then we can add a simple spinlock for it.
> > > >=20
> > > > My question is do you think we need to add the spinlock now instead=
 of
> > > > delaying it until there is real need?
> > > >=20
> > > I don't see the need for a dedicated spinlock here. You said above th=
at
> > > there is only one of these per client, so you could use the
> > > client->cl_lock.
> > >=20
> > > But...I don't see the problem with doing just using the nn->client_lo=
ck
> > > here. It's not like we're likely to be calling this that often, and i=
f
> > > we do then the contention for the nn->client_lock is probably the lea=
st
> > > of our worries.
> >=20
> > If the contention on nn->client_lock is not a concern then I just
> > leave the patch to use the nn->client_lock as it current does.
> >=20
>=20
> Except you aren't taking the client_lock in ->release. That's what needs
> to be added if you want to keep this boolean.
>=20
> > >=20
> > > Honestly, do we need this boolean at all? The only place it's checked=
 is
> > > in deleg_reaper. Why not just try to submit the work and if it's alre=
ady
> > > queued, let it fail?
> >=20
> > There is nothing in the existing code to prevent the nfs4_callback from
> > being used again before the current CB_RECALL_ANY request completes. Th=
is
> > resulted in se_cb_seq_nr becomes out of sync with the client and server
> > starts getting NFS4ERR_SEQ_MISORDERED then eventually NFS4ERR_BADSESSIO=
N
> > from the client.
> >=20
> > nfsd4_recall_file_layout has similar usage of nfs4_callback and it uses
> > the ls_lock to make sure the current request is done before allowing ne=
w
> > one to proceed.
> >=20
>=20
> That's a little different. The ls_lock protects ls_recalled, which is
> set when a recall is issued. We only want to issue a recall for a
> delegation once and that's what ensures that it's only issued once.
>=20
> CB_RECALL_ANY could be called more than once per client. We don't need
> to ensure "exactly once" semantics there. All of the callbacks are run
> out of workqueues.
>=20
> If a workqueue job is already scheduled then queue_work will return
> false when called. Could you just do away with this boolean and rely on
> the return code from queue_work to ensure that it doesn't get scheduled
> too often?
>=20
> > >=20
> > > > > Also, cl_rpc_users is a refcount (though we don't necessarily fre=
e the
> > > > > object when it goes to zero). I think you need to call
> > > > > put_client_renew_locked here instead of just decrementing the cou=
nter.
> > > > Since put_client_renew_locked() also renews the client lease, I don=
't
> > > > think it's right nfsd4_cb_recall_any_release to renew the lease bec=
ause
> > > > because this is a callback so the client is not actually sending an=
y
> > > > request that causes the lease to renewed, and nfsd4_cb_recall_any_r=
elease
> > > > is also alled even if the client is completely dead and did not rep=
ly, or
> > > > reply with some errors.
> > > >=20
> > > What happens when this atomic_inc makes the cl_rpc_count go to zero?
> >=20
> > Do you mean atomic_dec of cl_rpc_users?
> >=20
>=20
> Yes, sorry.
>=20
> > > What actually triggers the cleanup activities in put_client_renew /
> > > put_client_renew_locked in that situation?
> >=20
> > maybe I'm missing something, but I don't see any client cleanup
> > in put_client_renew/put_client_renew_locked other than renewing
> > the lease?
> >=20
> >=20
>=20
>         if (!is_client_expired(clp))
>                 renew_client_locked(clp);
>         else                                        =20
>                 wake_up_all(&expiry_wq);
>=20
>=20
> ...unless the client has already expired, in which case you need to wake
> up the waitqueue. My guess is that if the atomic_dec you're calling here
> goes to zero then any tasks on the expiry_wq will hang indefinitely.
>=20

I'm not sure you need to take a reference to the client here at all. Can
the client go away while a callback job is still running? You may be
able to assume that it will stick around for the life of the callback
(though you should verify this before assuming it).

> > >=20
> > > > > > +
> > > > > > +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops=
 =3D {
> > > > > > +	.done		=3D nfsd4_cb_recall_any_done,
> > > > > > +	.release	=3D nfsd4_cb_recall_any_release,
> > > > > > +};
> > > > > > +
> > > > > >    static struct nfs4_client *create_client(struct xdr_netobj n=
ame,
> > > > > >    		struct svc_rqst *rqstp, nfs4_verifier *verf)
> > > > > >    {
> > > > > > @@ -2891,6 +2916,8 @@ static struct nfs4_client *create_client(=
struct xdr_netobj name,
> > > > > >    		free_client(clp);
> > > > > >    		return NULL;
> > > > > >    	}
> > > > > > +	nfsd4_init_cb(&clp->cl_recall_any, clp, &nfsd4_cb_recall_any_=
ops,
> > > > > > +			NFSPROC4_CLNT_CB_RECALL_ANY);
> > > > > >    	return clp;
> > > > > >    }
> > > > > >   =20
> > > > > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > > > > index e2daef3cc003..49ca06169642 100644
> > > > > > --- a/fs/nfsd/state.h
> > > > > > +++ b/fs/nfsd/state.h
> > > > > > @@ -411,6 +411,10 @@ struct nfs4_client {
> > > > > >   =20
> > > > > >    	unsigned int		cl_state;
> > > > > >    	atomic_t		cl_delegs_in_recall;
> > > > > > +
> > > > > > +	bool			cl_recall_any_busy;
> > > > > > +	uint32_t		cl_recall_any_bm;
> > > > > > +	struct nfsd4_callback	cl_recall_any;
> > > > > >    };
> > > > > >   =20
> > > > > >    /* struct nfs4_client_reset
> > > > > > @@ -639,8 +643,12 @@ enum nfsd4_cb_op {
> > > > > >    	NFSPROC4_CLNT_CB_OFFLOAD,
> > > > > >    	NFSPROC4_CLNT_CB_SEQUENCE,
> > > > > >    	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
> > > > > > +	NFSPROC4_CLNT_CB_RECALL_ANY,
> > > > > >    };
> > > > > >   =20
> > > > > > +#define RCA4_TYPE_MASK_RDATA_DLG	0
> > > > > > +#define RCA4_TYPE_MASK_WDATA_DLG	1
> > > > > > +
> > > > > >    /* Returns true iff a is later than b: */
> > > > > >    static inline bool nfsd4_stateid_generation_after(stateid_t =
*a, stateid_t *b)
> > > > > >    {
> > > > > > diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
> > > > > > index 547cf07cf4e0..0d39af1b00a0 100644
> > > > > > --- a/fs/nfsd/xdr4cb.h
> > > > > > +++ b/fs/nfsd/xdr4cb.h
> > > > > > @@ -48,3 +48,9 @@
> > > > > >    #define NFS4_dec_cb_offload_sz		(cb_compound_dec_hdr_sz  +  =
    \
> > > > > >    					cb_sequence_dec_sz +            \
> > > > > >    					op_dec_sz)
> > > > > > +#define NFS4_enc_cb_recall_any_sz	(cb_compound_enc_hdr_sz +   =
    \
> > > > > > +					cb_sequence_enc_sz +            \
> > > > > > +					1 + 1 + 1)
> > > > > > +#define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +  =
    \
> > > > > > +					cb_sequence_dec_sz +            \
> > > > > > +					op_dec_sz)
>=20

--=20
Jeff Layton <jlayton@kernel.org>
