Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A209660A7DE
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiJXNAX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 09:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiJXM7L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 08:59:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE999A2A7
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 05:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCEEE6126B
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 12:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1D4C433C1;
        Mon, 24 Oct 2022 12:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666613815;
        bh=0rEIHx70j0+On4cph0cTnYin+nsRkELB1WOkrKTXQEM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TP+lqbLsXY12ADbjGMr6FJSgiEN1akpWAgTexORgGvOKuPviSekKaOMaoE7H2+ATF
         Qh6I9I8GhPoJOm6Z2VP0PVbFBQNKk6PnMD7zn8EuJ8Zw7GgozuCE6KJq8dVG35LgqJ
         Er1SXD8Flttu83DjCxPbC1CrMZWZHx/PHhaCat8B+vheZvB4kAGJAfQ3i0fbBuO0Gu
         kw/0DTywB5+99h0Ony2OUfhc6reI7t7uzqZm7jrMl4i3le8gAPehTTx3mCWjRD4gM/
         2wj0pPdRlkFqOO0PFlsV4P09r79PV7n0Hr/bR5fZkSblo0fz4gyxEbcnI4AxZLx6cH
         OUoEW/tVVbr7w==
Message-ID: <d43a3dac01f8c4211ec7634a0d78dae70468f39b.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] NFSD: add support for sending CB_RECALL_ANY
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 24 Oct 2022 08:16:53 -0400
In-Reply-To: <1666462150-11736-2-git-send-email-dai.ngo@oracle.com>
References: <1666462150-11736-1-git-send-email-dai.ngo@oracle.com>
         <1666462150-11736-2-git-send-email-dai.ngo@oracle.com>
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

On Sat, 2022-10-22 at 11:09 -0700, Dai Ngo wrote:
> There is only one nfsd4_callback, cl_recall_any, added for each
> nfs4_client. Access to it must be serialized. For now it's done
> by the cl_recall_any_busy flag since it's used only by the
> delegation shrinker. If there is another consumer of CB_RECALL_ANY
> then a spinlock must be used.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4callback.c | 64 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/nfsd/nfs4state.c    | 27 +++++++++++++++++++++
>  fs/nfsd/state.h        |  8 +++++++
>  fs/nfsd/xdr4cb.h       |  6 +++++
>  4 files changed, 105 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index f0e69edf5f0f..03587e1397f4 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -329,6 +329,29 @@ static void encode_cb_recall4args(struct xdr_stream =
*xdr,
>  }
> =20
>  /*
> + * CB_RECALLANY4args
> + *
> + *	struct CB_RECALLANY4args {
> + *		uint32_t	craa_objects_to_keep;
> + *		bitmap4		craa_type_mask;
> + *	};
> + */
> +static void
> +encode_cb_recallany4args(struct xdr_stream *xdr,
> +			struct nfs4_cb_compound_hdr *hdr, uint32_t bmval)
> +{
> +	__be32 *p;
> +
> +	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
> +	p =3D xdr_reserve_space(xdr, 4);
> +	*p++ =3D xdr_zero;	/* craa_objects_to_keep */
> +	p =3D xdr_reserve_space(xdr, 8);
> +	*p++ =3D cpu_to_be32(1);
> +	*p++ =3D cpu_to_be32(bmval);
> +	hdr->nops++;
> +}
> +
> +/*
>   * CB_SEQUENCE4args
>   *
>   *	struct CB_SEQUENCE4args {
> @@ -482,6 +505,24 @@ static void nfs4_xdr_enc_cb_recall(struct rpc_rqst *=
req, struct xdr_stream *xdr,
>  	encode_cb_nops(&hdr);
>  }
> =20
> +/*
> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
> + */
> +static void
> +nfs4_xdr_enc_cb_recall_any(struct rpc_rqst *req,
> +		struct xdr_stream *xdr, const void *data)
> +{
> +	const struct nfsd4_callback *cb =3D data;
> +	struct nfs4_cb_compound_hdr hdr =3D {
> +		.ident =3D cb->cb_clp->cl_cb_ident,
> +		.minorversion =3D cb->cb_clp->cl_minorversion,
> +	};
> +
> +	encode_cb_compound4args(xdr, &hdr);
> +	encode_cb_sequence4args(xdr, cb, &hdr);
> +	encode_cb_recallany4args(xdr, &hdr, cb->cb_clp->cl_recall_any_bm);
> +	encode_cb_nops(&hdr);
> +}
> =20
>  /*
>   * NFSv4.0 and NFSv4.1 XDR decode functions
> @@ -520,6 +561,28 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *r=
qstp,
>  	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
>  }
> =20
> +/*
> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
> + */
> +static int
> +nfs4_xdr_dec_cb_recall_any(struct rpc_rqst *rqstp,
> +				  struct xdr_stream *xdr,
> +				  void *data)
> +{
> +	struct nfsd4_callback *cb =3D data;
> +	struct nfs4_cb_compound_hdr hdr;
> +	int status;
> +
> +	status =3D decode_cb_compound4res(xdr, &hdr);
> +	if (unlikely(status))
> +		return status;
> +	status =3D decode_cb_sequence4res(xdr, cb);
> +	if (unlikely(status || cb->cb_seq_status))
> +		return status;
> +	status =3D  decode_cb_op_status(xdr, OP_CB_RECALL_ANY, &cb->cb_status);
> +	return status;
> +}
> +
>  #ifdef CONFIG_NFSD_PNFS
>  /*
>   * CB_LAYOUTRECALL4args
> @@ -783,6 +846,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[]=
 =3D {
>  #endif
>  	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
>  	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
> +	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
>  };
> =20
>  static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4e718500a00c..c60c937dece6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2854,6 +2854,31 @@ static const struct tree_descr client_files[] =3D =
{
>  	[3] =3D {""},
>  };
> =20
> +static int
> +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
> +			struct rpc_task *task)
> +{
> +	switch (task->tk_status) {
> +	case -NFS4ERR_DELAY:
> +		rpc_delay(task, 2 * HZ);
> +		return 0;
> +	default:
> +		return 1;
> +	}
> +}
> +
> +static void
> +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
> +{
> +	cb->cb_clp->cl_recall_any_busy =3D false;
> +	atomic_dec(&cb->cb_clp->cl_rpc_users);
> +}


This series probably ought to be one big patch. The problem is that
you're adding a bunch of code to do CB_RECALL_ANY, but there is no way
to call it without patch #2.

That makes it hard to judge whether there could be races and locking
issues around the handling of cb_recall_any_busy, in particular. From
patch #2, it looks like cb_recall_any_busy is protected by the
nn->client_lock, but I don't think ->release is called with that held.

Also, cl_rpc_users is a refcount (though we don't necessarily free the
object when it goes to zero). I think you need to call
put_client_renew_locked here instead of just decrementing the counter.

> +
> +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops =3D {
> +	.done		=3D nfsd4_cb_recall_any_done,
> +	.release	=3D nfsd4_cb_recall_any_release,
> +};
> +
>  static struct nfs4_client *create_client(struct xdr_netobj name,
>  		struct svc_rqst *rqstp, nfs4_verifier *verf)
>  {
> @@ -2891,6 +2916,8 @@ static struct nfs4_client *create_client(struct xdr=
_netobj name,
>  		free_client(clp);
>  		return NULL;
>  	}
> +	nfsd4_init_cb(&clp->cl_recall_any, clp, &nfsd4_cb_recall_any_ops,
> +			NFSPROC4_CLNT_CB_RECALL_ANY);
>  	return clp;
>  }
> =20
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e2daef3cc003..49ca06169642 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -411,6 +411,10 @@ struct nfs4_client {
> =20
>  	unsigned int		cl_state;
>  	atomic_t		cl_delegs_in_recall;
> +
> +	bool			cl_recall_any_busy;
> +	uint32_t		cl_recall_any_bm;
> +	struct nfsd4_callback	cl_recall_any;
>  };
> =20
>  /* struct nfs4_client_reset
> @@ -639,8 +643,12 @@ enum nfsd4_cb_op {
>  	NFSPROC4_CLNT_CB_OFFLOAD,
>  	NFSPROC4_CLNT_CB_SEQUENCE,
>  	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
> +	NFSPROC4_CLNT_CB_RECALL_ANY,
>  };
> =20
> +#define RCA4_TYPE_MASK_RDATA_DLG	0
> +#define RCA4_TYPE_MASK_WDATA_DLG	1
> +
>  /* Returns true iff a is later than b: */
>  static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_=
t *b)
>  {
> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
> index 547cf07cf4e0..0d39af1b00a0 100644
> --- a/fs/nfsd/xdr4cb.h
> +++ b/fs/nfsd/xdr4cb.h
> @@ -48,3 +48,9 @@
>  #define NFS4_dec_cb_offload_sz		(cb_compound_dec_hdr_sz  +      \
>  					cb_sequence_dec_sz +            \
>  					op_dec_sz)
> +#define NFS4_enc_cb_recall_any_sz	(cb_compound_enc_hdr_sz +       \
> +					cb_sequence_enc_sz +            \
> +					1 + 1 + 1)
> +#define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +      \
> +					cb_sequence_dec_sz +            \
> +					op_dec_sz)

--=20
Jeff Layton <jlayton@kernel.org>
