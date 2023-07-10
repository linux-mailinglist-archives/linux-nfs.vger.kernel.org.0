Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B2474D9A2
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGJPPE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 11:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjGJPPD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 11:15:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A929FA0
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 08:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42F6A6106E
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 15:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5E7C433C8;
        Mon, 10 Jul 2023 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689002101;
        bh=zYIQ1S0HwQ5FZatezUEirGawEw6kHdklUJVJR5DG6bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e94fqIfl+qPmcus4HS6rV7hhx35I2e9JYo5rTk3+ThBIuak0rCAhDpluz551zuqum
         6pDp7CnY3d6YGFZySdv7YCjHY5lqAjN/9J4VhA2Oejua4zDPvqjXntIGaNJQvDWn/r
         V1S3bFxgdRsye/zNoMScDhhWfXaRVbHXtG3KhSJWBEIcWv5hqkEbfv5aBPwWSK4Mi3
         vMB+XRvoh+F8oVQ+IIx4Tto1kL7uU0HdWfREXxQAGYSSJERxtSNLrV4FB1Wsx9Q0hc
         XPuVNAbJjaUJrFxDsMz0Zx1RHtj6m0p/9fTLW04MTs4+TeJw/ZIiGjLiYZ7VF9fMK+
         BqnuEFRZ9KHuw==
Date:   Mon, 10 Jul 2023 17:14:57 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        chuck.lever@oracle.com
Subject: Re: [RFC] NFSD: add rpc_status entry in nfsd debug filesystem
Message-ID: <ZKwgcRuZLQ4qLzlr@lore-desk>
References: <bac972c22c5acfa43969bb1bf164341b16ea045c.1688032742.git.lorenzo@kernel.org>
 <ba88166cb8a891fdb62ddd2bd8b7605f06aea0a6.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EM/hrf9zFaTagsLR"
Content-Disposition: inline
In-Reply-To: <ba88166cb8a891fdb62ddd2bd8b7605f06aea0a6.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--EM/hrf9zFaTagsLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 2023-06-29 at 12:17 +0200, Lorenzo Bianconi wrote:
> > Introduce rpc_status entry in nfsd debug filesystem in order to dump
> > pending RPC requests debugging information.
> >=20
> > Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  fs/nfsd/nfs4proc.c |  4 +--
> >  fs/nfsd/nfsctl.c   | 18 ++++++++++++++
> >  fs/nfsd/nfsd.h     |  2 ++
> >  fs/nfsd/nfssvc.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++++
> >  net/sunrpc/svc.c   |  2 +-
> >  5 files changed, 83 insertions(+), 4 deletions(-)
> >=20
>=20
> This looks good, Lorenzo. Nice work! Comments below.

Hi Jeff,

thx for the review.

>=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 5ae670807449..a4dd1ef104c3 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2452,8 +2452,6 @@ static inline void nfsd4_increment_op_stats(u32 o=
pnum)
> > =20
> >  static const struct nfsd4_operation nfsd4_ops[];
> > =20
> > -static const char *nfsd4_op_name(unsigned opnum);
> > -
> >  /*
> >   * Enforce NFSv4.1 COMPOUND ordering rules:
> >   *
> > @@ -3583,7 +3581,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)
> >  	}
> >  }
> > =20
> > -static const char *nfsd4_op_name(unsigned opnum)
> > +const char *nfsd4_op_name(unsigned opnum)
> >  {
> >  	if (opnum < ARRAY_SIZE(nfsd4_ops))
> >  		return nfsd4_ops[opnum].op_name;
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 1489e0b703b4..9d0b0a53510b 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -57,6 +57,8 @@ enum {
> >  	NFSD_RecoveryDir,
> >  	NFSD_V4EndGrace,
> >  #endif
> > +	NFSD_Rpc_Status,
> > +
> >  	NFSD_MaxReserved
> >  };
> > =20
> > @@ -195,6 +197,21 @@ static inline struct net *netns(struct file *file)
> >  	return file_inode(file)->i_sb->s_fs_info;
> >  }
> > =20
> > +static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(file_inode(m->file)->i_sb->s_fs_i=
nfo,
> > +					  nfsd_net_id);
> > +
> > +	mutex_lock(&nfsd_mutex);
> > +	if (nn->nfsd_serv)
> > +		nsfd_rpc_status(m, nn->nfsd_serv);
> > +	mutex_unlock(&nfsd_mutex);
> > +
> > +	return 0;
> > +}
> > +
> > +DEFINE_SHOW_ATTRIBUTE(nfsd_rpc_status);
> > +
> >  /*
> >   * write_unlock_ip - Release all locks used by a client
> >   *
> > @@ -1400,6 +1417,7 @@ static int nfsd_fill_super(struct super_block *sb=
, struct fs_context *fc)
> >  		[NFSD_RecoveryDir] =3D {"nfsv4recoverydir", &transaction_ops, S_IWUS=
R|S_IRUSR},
> >  		[NFSD_V4EndGrace] =3D {"v4_end_grace", &transaction_ops, S_IWUSR|S_I=
RUGO},
> >  #endif
> > +		[NFSD_Rpc_Status] =3D {"rpc_status", &nfsd_rpc_status_fops, S_IRUGO},
> >  		/* last one */ {""}
> >  	};
> > =20
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index d88498f8b275..a149157ec243 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -87,6 +87,7 @@ bool		nfssvc_encode_voidres(struct svc_rqst *rqstp,
> >   */
> >  int		nfsd_svc(int nrservs, struct net *net, const struct cred *cred);
> >  int		nfsd_dispatch(struct svc_rqst *rqstp);
> > +void		nsfd_rpc_status(struct seq_file *m, struct svc_serv *serv);
>=20
> nit: please rename this to nfsd_rpc_status

ack, I will fix it.

>=20
> > =20
> >  int		nfsd_nrthreads(struct net *);
> >  int		nfsd_nrpools(struct net *);
> > @@ -506,6 +507,7 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_=
net *nn);
> > =20
> >  extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> > =20
> > +const char *nfsd4_op_name(unsigned opnum);
> >  #else /* CONFIG_NFSD_V4 */
> >  static inline int nfsd4_is_junction(struct dentry *dentry)
> >  {
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 9c7b1ef5be40..7a881f9a3a13 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -1142,3 +1142,64 @@ int nfsd_pool_stats_release(struct inode *inode,=
 struct file *file)
> >  	mutex_unlock(&nfsd_mutex);
> >  	return ret;
> >  }
> > +
> > +void nsfd_rpc_status(struct seq_file *m, struct svc_serv *serv)
> > +{
> > +	int i;
> > +
> > +	lockdep_assert_held(&nfsd_mutex);
> > +
> > +	rcu_read_lock();
>=20
> Both sv_nrpools and the sp_all_threads list are protected by the
> nfsd_mutex, so I don't think you need the rcu_read_lock here too.
>=20
> It would be nice if we could do this with only the rcu_read_lock. I
> think accessing all of the svc_rqst fields under the rcu_read_lock is
> safe, and sv_nrpools is only set when the service is created, so I think
> that would be safe.

ack, I will fix it.

Regards,
Lorenzo

>=20
>=20
> > +
> > +	for (i =3D 0; i < serv->sv_nrpools; i++) {
> > +		struct svc_rqst *rqstp;
> > +
> > +		seq_puts(m, "XID        | FLAGS      | PROG       |");
> > +		seq_puts(m, " VERS       | PROC\t|");
> > +		seq_puts(m, " REMOTE - LOCAL IP ADDR");
> > +		seq_puts(m, "\t\t\t\t\t\t\t\t   | NFS4 COMPOUND OPS\n");
> > +		list_for_each_entry_rcu(rqstp,
> > +					&serv->sv_pools[i].sp_all_threads,
> > +					rq_all) {
> > +			if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
> > +				continue;
> > +
> > +			seq_printf(m,
> > +				   "0x%08x | 0x%08lx | 0x%08x | NFSv%d      | %s\t|",
> > +				   be32_to_cpu(rqstp->rq_xid), rqstp->rq_flags,
> > +				   rqstp->rq_prog, rqstp->rq_vers,
> > +				   svc_proc_name(rqstp));
> > +
> > +			if (rqstp->rq_addr.ss_family =3D=3D AF_INET) {
> > +				seq_printf(m, " %pI4 - %pI4\t\t\t\t\t\t\t   |",
> > +					   &((struct sockaddr_in *)&rqstp->rq_addr)->sin_addr,
> > +					   &((struct sockaddr_in *)&rqstp->rq_daddr)->sin_addr);
> > +			} else if (rqstp->rq_addr.ss_family =3D=3D AF_INET6) {
> > +				seq_printf(m, " %pI6 - %pI6 |",
> > +					   &((struct sockaddr_in6 *)&rqstp->rq_addr)->sin6_addr,
> > +					   &((struct sockaddr_in6 *)&rqstp->rq_daddr)->sin6_addr);
> > +			} else {
> > +				seq_printf(m, " Unknown address family: %hu\n",
> > +					   rqstp->rq_addr.ss_family);
> > +				continue;
> > +			}
> > +#ifdef CONFIG_NFSD_V4
> > +			if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
> > +			    rqstp->rq_proc =3D=3D NFSPROC4_COMPOUND) {
> > +				/* NFSv4 compund */
> > +				struct nfsd4_compoundargs *args =3D rqstp->rq_argp;
> > +				struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
> > +
> > +				while (resp->opcnt < args->opcnt) {
> > +					struct nfsd4_op *op =3D &args->ops[resp->opcnt++];
> > +
> > +					seq_printf(m, " %s", nfsd4_op_name(op->opnum));
> > +				}
> > +			}
> > +#endif /* CONFIG_NFSD_V4 */
> > +			seq_puts(m, "\n");
> > +		}
> > +	}
> > +
> > +	rcu_read_unlock();
> > +}
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index e6d4cec61e47..f99cad92e9f4 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -1625,7 +1625,7 @@ const char *svc_proc_name(const struct svc_rqst *=
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
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--EM/hrf9zFaTagsLR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZKwgcQAKCRA6cBh0uS2t
rMbdAQCROlVKX6+pkLpFmU9/jxmX1+iGI5zCvxkZiu+go07sTgEAsY3cS6LW086u
WMJ8diDpk1AJJbWM/DIpjp4wL6qDMAM=
=NtWg
-----END PGP SIGNATURE-----

--EM/hrf9zFaTagsLR--
