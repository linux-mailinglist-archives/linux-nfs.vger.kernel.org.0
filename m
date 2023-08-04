Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B86876FB81
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Aug 2023 09:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjHDH6B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 03:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjHDH55 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 03:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DE213E
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691135827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9y/WEvJUQLER/SR2By7ncrYB4Lb558VVZ77ulNojvFc=;
        b=cf30HxdjwzlrIiG4uAtSVgR34DG8Rv+O7UD7a6M2nhDYO1Wq13rQFlF76q+GD5fGBZP9Yu
        Iuy6rz1ZBsaG6sd+RPFDz8fYYLI7ftrV8IFy2oyp3FfJTXR4qS9hQbg8FQa/j5fg+b/6tR
        zJr787v33ZeQc0rwn1uXNODuzdDmhfo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-Eg_1ZLMpMdOqsn1EqsTv1g-1; Fri, 04 Aug 2023 03:57:05 -0400
X-MC-Unique: Eg_1ZLMpMdOqsn1EqsTv1g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-763c36d4748so194483985a.0
        for <linux-nfs@vger.kernel.org>; Fri, 04 Aug 2023 00:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691135825; x=1691740625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9y/WEvJUQLER/SR2By7ncrYB4Lb558VVZ77ulNojvFc=;
        b=SLZVP2g1avTze+jLDNygLMlVQ2uTZUScfEi5eDxeHYvXjK2U9TVVFnsncQ9QcrgLBC
         eJUyN0Dhpyipc7pB5/ZE+GPdXdGnPEkRPDAhgEFe/DCm7yOWadnyKDpI/U0u58IiGJoK
         oUf2K+qpN/flwjjsVhiyJa82StblvuHuZmWMiwK6faYYj0AiXi+fyZphVUisGSkE37ma
         xas6bwZlDq2iHMhAIyu38HWIKlPeBq3EhRbx4rVlM3uuiwMej+u5pk4Jdxi3NadKuzzf
         SGqeT1EnrACfuvrLZF/S62tiMzu4mVDA6Xas4jfvqjKcqFVQjaxAnGe6669UdRPHfpPg
         /RcQ==
X-Gm-Message-State: AOJu0YxuS6TWDgFeadqq1QzBZsH5BfcHeNUzQjzdFLqDam8wAtvTgi3d
        kt+gvTyoSArL7aZ4JClDW0jB+R3QybuUBGfEa1nGTpuTAVSCtHtnIzi9/d7bKvPZjJvHCu2bh9e
        +fGrR+4ZpWS4a5aZ2FnEt
X-Received: by 2002:a05:620a:24d6:b0:76c:9ac2:4e63 with SMTP id m22-20020a05620a24d600b0076c9ac24e63mr1394498qkn.77.1691135824956;
        Fri, 04 Aug 2023 00:57:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgsrmQQVfG/kImrLhUMeeHAp3x/v6tMcPm76T9DfjQvW96OD1Xdb8IpBUl2YPfCstXbt6RWQ==
X-Received: by 2002:a05:620a:24d6:b0:76c:9ac2:4e63 with SMTP id m22-20020a05620a24d600b0076c9ac24e63mr1394481qkn.77.1691135824676;
        Fri, 04 Aug 2023 00:57:04 -0700 (PDT)
Received: from localhost (mob-176-247-93-114.net.vodafone.it. [176.247.93.114])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a110400b0076ccce0a41bsm478919qkk.60.2023.08.04.00.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 00:57:04 -0700 (PDT)
Date:   Fri, 4 Aug 2023 09:56:59 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        jlayton@kernel.org, neilb@suse.de
Subject: Re: [PATCH v4 2/2] NFSD: add rpc_status entry in nfsd debug
 filesystem
Message-ID: <ZMyvSxMhvH4elsBR@lore-rh-laptop>
References: <cover.1690569488.git.lorenzo@kernel.org>
 <a23a0482a465299ac06d07d191e0c9377a11a4d1.1690569488.git.lorenzo@kernel.org>
 <ZMQVX5RlQaWt5wkn@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jz93DVLGwkBSvggU"
Content-Disposition: inline
In-Reply-To: <ZMQVX5RlQaWt5wkn@tissot.1015granger.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--jz93DVLGwkBSvggU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> > +	atomic_inc(&rqstp->rq_status_counter);
> > +
>=20
> Does this really have to be an atomic_t ? Seems like nfsd_dispatch
> is the only function updating it. You might need release semantics
> here and acquire semantics in nfsd_rpc_status_show(). I'd rather
> avoid a full-on atomic op in nfsd_dispatch() unless it's absolutely
> needed.

ack, I agree. I will work on it.

>=20
> Also, do you need to bump the rq_status_counter in the other RPC
> dispatch routines (lockd and nfs callback) too?

the only consumer at the moment is nfsd, do you think we should add them in
advance for lockd as well?

>=20
>=20
> >  	rp =3D NULL;
> >  	switch (nfsd_cache_lookup(rqstp, &rp)) {
> >  	case RC_DOIT:
> > @@ -1074,6 +1076,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
> >  	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
> >  		goto out_encode_err;
> > =20
> > +	atomic_inc(&rqstp->rq_status_counter);
> > +
> >  	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
> >  out_cached_reply:
> >  	return 1;
> > @@ -1149,3 +1153,121 @@ int nfsd_pool_stats_release(struct inode *inode=
, struct file *file)
> >  	mutex_unlock(&nfsd_mutex);
> >  	return ret;
> >  }
> > +
> > +static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> > +{
> > +	struct inode *inode =3D file_inode(m->file);
> > +	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_=
id);
> > +	int i;
> > +
> > +	rcu_read_lock();
> > +
> > +	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> > +		struct svc_rqst *rqstp;
> > +
> > +		list_for_each_entry_rcu(rqstp,
> > +				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> > +				rq_all) {
> > +			struct nfsd_rpc_status_info {
> > +				struct sockaddr daddr;
> > +				struct sockaddr saddr;
> > +				unsigned long rq_flags;
> > +				__be32 rq_xid;
> > +				u32 rq_prog;
> > +				u32 rq_vers;
> > +				const char *pc_name;
> > +				ktime_t rq_stime;
> > +				u32 opnum[NFSD_MAX_OPS_PER_COMPOUND]; /* NFSv4 compund */
> > +			} rqstp_info;
> > +			unsigned int status_counter;
> > +			char buf[RPC_MAX_ADDRBUFLEN];
> > +			int j, opcnt =3D 0;
> > +
> > +			if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
> > +				continue;
> > +
> > +			status_counter =3D atomic_read(&rqstp->rq_status_counter);
>=20
> Neil said:
>=20
> > I suggest you add add a counter to the rqstp which is incremented from
> > even to odd after parsing a request - including he v4 parsing needed to
> > have a sable ->opcnt - and then incremented from odd to even when the
> > request is complete.
> > Then this code samples the counter, skips the rqst if the counter is
> > even, and resamples the counter after collecting the data.  If it has
> > changed, the drop the record.
>=20
> I don't see a check if the status counter is even.
>=20
> Also, as above, I'm not sure atomic_read() is necessary here. Maybe
> just READ_ONCE() ? Neil, any thoughts?


I used the RQ_BUSY check instead of checking if the counter is even, but I =
can
see the point now. I will fix it.

>=20
>=20
> > +
> > +			rqstp_info.rq_xid =3D rqstp->rq_xid;
> > +			rqstp_info.rq_flags =3D rqstp->rq_flags;
> > +			rqstp_info.rq_prog =3D rqstp->rq_prog;
> > +			rqstp_info.rq_vers =3D rqstp->rq_vers;
> > +			rqstp_info.pc_name =3D svc_proc_name(rqstp);
> > +			rqstp_info.rq_stime =3D rqstp->rq_stime;
> > +			memcpy(&rqstp_info.daddr, svc_daddr(rqstp),
> > +			       sizeof(struct sockaddr));
> > +			memcpy(&rqstp_info.saddr, svc_addr(rqstp),
> > +			       sizeof(struct sockaddr));
> > +
> > +#ifdef CONFIG_NFSD_V4
> > +			if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
> > +			    rqstp->rq_proc =3D=3D NFSPROC4_COMPOUND) {
> > +				/* NFSv4 compund */
> > +				struct nfsd4_compoundargs *args =3D rqstp->rq_argp;
> > +
> > +				opcnt =3D args->opcnt;
> > +				for (j =3D 0; j < opcnt; j++) {
> > +					struct nfsd4_op *op =3D &args->ops[j];
> > +
> > +					rqstp_info.opnum[j] =3D op->opnum;
> > +				}
> > +			}
> > +#endif /* CONFIG_NFSD_V4 */
> > +
> > +			/* In order to detect if the RPC request is pending and
> > +			 * RPC info are stable we check if rq_status_counter
> > +			 * has been incremented during the handler processing.
> > +			 */
> > +			if (status_counter !=3D atomic_read(&rqstp->rq_status_counter))
> > +				continue;
> > +
> > +			seq_printf(m,
> > +				   "0x%08x, 0x%08lx, 0x%08x, NFSv%d, %s, %016lld,",
> > +				   be32_to_cpu(rqstp_info.rq_xid),
> > +				   rqstp_info.rq_flags,
> > +				   rqstp_info.rq_prog,
> > +				   rqstp_info.rq_vers,
> > +				   rqstp_info.pc_name,
> > +				   ktime_to_us(rqstp_info.rq_stime));
> > +
> > +			seq_printf(m, " %s,",
> > +				   __svc_print_addr(&rqstp_info.saddr, buf,
> > +						    sizeof(buf), false));
> > +			seq_printf(m, " %s,",
> > +				   __svc_print_addr(&rqstp_info.daddr, buf,
> > +						    sizeof(buf), false));
> > +			for (j =3D 0; j < opcnt; j++)
> > +				seq_printf(m, " %s%s",
> > +					   nfsd4_op_name(rqstp_info.opnum[j]),
> > +					   j =3D=3D opcnt - 1 ? "," : "");
> > +			seq_puts(m, "\n");
> > +		}
> > +	}
> > +
> > +	rcu_read_unlock();
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * nfsd_rpc_status_open - Atomically copy a write verifier
>=20
> The kdoc comment maybe was copied, pasted, and then not updated?

ack, I will fix it.

Regards,
Lorenzo

>=20
> > + * @inode: entry inode pointer.
> > + * @file: entry file pointer.
> > + *
> > + * This routine dumps pending RPC requests info queued into nfs server.
> > + */
> > +int nfsd_rpc_status_open(struct inode *inode, struct file *file)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_=
id);
> > +
> > +	mutex_lock(&nfsd_mutex);
> > +	if (!nn->nfsd_serv) {
> > +		mutex_unlock(&nfsd_mutex);
> > +		return -ENODEV;
> > +	}
> > +
> > +	svc_get(nn->nfsd_serv);
> > +	mutex_unlock(&nfsd_mutex);
> > +
> > +	return single_open(file, nfsd_rpc_status_show, inode->i_private);
> > +}
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index fe1394cc1371..cb516da9e270 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -270,6 +270,7 @@ struct svc_rqst {
> >  						 * net namespace
> >  						 */
> >  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> > +	atomic_t		rq_status_counter; /* RPC processing counter */
> >  };
> > =20
> >  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->=
rq_bc_net)
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 587811a002c9..44eac83b35a1 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -1629,7 +1629,7 @@ const char *svc_proc_name(const struct svc_rqst *=
rqstp)
> >  		return rqstp->rq_procinfo->pc_name;
> >  	return "unknown";
> >  }
> > -
> > +EXPORT_SYMBOL_GPL(svc_proc_name);
> > =20
> >  /**
> >   * svc_encode_result_payload - mark a range of bytes as a result paylo=
ad
> > --=20
> > 2.41.0
> >=20
>=20
> --=20
> Chuck Lever
>=20

--jz93DVLGwkBSvggU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZMyvSAAKCRA6cBh0uS2t
rOiIAQCBdEvfx2SZ04JPNVp+PUucttpf8XLpIiLM3DtLXsoFvAD/VSlUjg7MmWzX
36h7ErpKoUgH1FRbJz6aXiTKD6Tf5AI=
=Kf6Y
-----END PGP SIGNATURE-----

--jz93DVLGwkBSvggU--

