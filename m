Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA12751FE1
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jul 2023 13:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjGML2Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jul 2023 07:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjGML2A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jul 2023 07:28:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512C62710
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 04:27:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E41EB60F33
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 11:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA23DC433C8;
        Thu, 13 Jul 2023 11:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689247674;
        bh=5fd4G7Hk+f3l+e8Bz0OUYdIK1UnlYNd1uzM42F0Lfus=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=URay993yU/4wDBILmkHvioqRV653N3+XMqJyU4JB2enfKu9OtJW7NDkvadX7J48K6
         QldNz41KoOc6xw3JTBQ/Df8zMszNl5dEDcmrPABypvDVxfPHNp2IBy6Ng5AkB3snZp
         fNvwmBsgWoWDSEvyfGRobpAfmPYyD51TftRU8vLkykoeQ1hlsy6XjZfY1tEkF3NI0A
         Gowb7RVvsECWrSVwrMAHtSc+sFPc6Hw0ICheRajAFBT0XSORJc+0bsm7DZ4tVbDvys
         A0ZP59/gW8wkeRvNW/hQBhzZGostOI997m/XemdJdJ9YNDPbjH+XGedIyHGmttZA/t
         oEJbFY9lgi0Bg==
Message-ID: <d0b5e760aebaff9a587a83c7d69f71a5d71f01e6.camel@kernel.org>
Subject: Re: [PATCH v2] NFSD: add rpc_status entry in nfsd debug filesystem
From:   Jeff Layton <jlayton@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com
Date:   Thu, 13 Jul 2023 07:27:52 -0400
In-Reply-To: <c86b81f1d63f4105a2772c83746a3e5a88300bbd.1689198106.git.lorenzo@kernel.org>
References: <c86b81f1d63f4105a2772c83746a3e5a88300bbd.1689198106.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-07-12 at 23:44 +0200, Lorenzo Bianconi wrote:
> Introduce rpc_status entry in nfsd debug filesystem in order to dump
> pending RPC requests debugging information.
>=20
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes since v1:
> - rework nfsd_rpc_status_show output
>=20
> Changes since RFCv1:
> - riduce time holding nfsd_mutex bumping svc_serv refcoung in
>   nfsd_rpc_status_open()
> - dump rqstp->rq_stime
> - add missing kdoc for nfsd_rpc_status_open()
> ---
>  fs/nfsd/nfs4proc.c |  4 +--
>  fs/nfsd/nfsctl.c   | 10 ++++++
>  fs/nfsd/nfsd.h     |  2 ++
>  fs/nfsd/nfssvc.c   | 81 ++++++++++++++++++++++++++++++++++++++++++++++
>  net/sunrpc/svc.c   |  2 +-
>  5 files changed, 95 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index d8e7a533f9d2..a7f522390a66 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2463,8 +2463,6 @@ static inline void nfsd4_increment_op_stats(u32 opn=
um)
> =20
>  static const struct nfsd4_operation nfsd4_ops[];
> =20
> -static const char *nfsd4_op_name(unsigned opnum);
> -
>  /*
>   * Enforce NFSv4.1 COMPOUND ordering rules:
>   *
> @@ -3594,7 +3592,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)
>  	}
>  }
> =20
> -static const char *nfsd4_op_name(unsigned opnum)
> +const char *nfsd4_op_name(unsigned opnum)
>  {
>  	if (opnum < ARRAY_SIZE(nfsd4_ops))
>  		return nfsd4_ops[opnum].op_name;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 1b8b1aab9a15..629b4296e7c6 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -57,6 +57,8 @@ enum {
>  	NFSD_RecoveryDir,
>  	NFSD_V4EndGrace,
>  #endif
> +	NFSD_Rpc_Status,
> +
>  	NFSD_MaxReserved
>  };
> =20
> @@ -195,6 +197,13 @@ static inline struct net *netns(struct file *file)
>  	return file_inode(file)->i_sb->s_fs_info;
>  }
> =20
> +static const struct file_operations nfsd_rpc_status_operations =3D {
> +	.open		=3D nfsd_rpc_status_open,
> +	.read		=3D seq_read,
> +	.llseek		=3D seq_lseek,
> +	.release	=3D nfsd_pool_stats_release,
> +};
> +
>  /*
>   * write_unlock_ip - Release all locks used by a client
>   *
> @@ -1400,6 +1409,7 @@ static int nfsd_fill_super(struct super_block *sb, =
struct fs_context *fc)
>  		[NFSD_RecoveryDir] =3D {"nfsv4recoverydir", &transaction_ops, S_IWUSR|=
S_IRUSR},
>  		[NFSD_V4EndGrace] =3D {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRU=
GO},
>  #endif
> +		[NFSD_Rpc_Status] =3D {"rpc_status", &nfsd_rpc_status_operations, S_IR=
UGO},
>  		/* last one */ {""}
>  	};
> =20
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index d88498f8b275..75a3e1d55bc8 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -94,6 +94,7 @@ int		nfsd_get_nrthreads(int n, int *, struct net *);
>  int		nfsd_set_nrthreads(int n, int *, struct net *);
>  int		nfsd_pool_stats_open(struct inode *, struct file *);
>  int		nfsd_pool_stats_release(struct inode *, struct file *);
> +int		nfsd_rpc_status_open(struct inode *inode, struct file *file);
>  void		nfsd_shutdown_threads(struct net *net);
> =20
>  void		nfsd_put(struct net *net);
> @@ -506,6 +507,7 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_ne=
t *nn);
> =20
>  extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> =20
> +const char *nfsd4_op_name(unsigned opnum);
>  #else /* CONFIG_NFSD_V4 */
>  static inline int nfsd4_is_junction(struct dentry *dentry)
>  {
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 97830e28c140..2daa1e7c33e1 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1149,3 +1149,84 @@ int nfsd_pool_stats_release(struct inode *inode, s=
truct file *file)
>  	mutex_unlock(&nfsd_mutex);
>  	return ret;
>  }
> +
> +static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> +{
> +	struct inode *inode =3D file_inode(m->file);
> +	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_id=
);
> +	int i;
> +
> +	rcu_read_lock();
> +
> +	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> +		struct svc_rqst *rqstp;
> +
> +		list_for_each_entry_rcu(rqstp,
> +				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> +				rq_all) {
> +			if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
> +				continue;
> +
> +			seq_printf(m,
> +				   "0x%08x 0x%08lx 0x%08x NFSv%d %s %016lld",
> +				   be32_to_cpu(rqstp->rq_xid), rqstp->rq_flags,
> +				   rqstp->rq_prog, rqstp->rq_vers,
> +				   svc_proc_name(rqstp),
> +				   ktime_to_us(rqstp->rq_stime));
> +
> +			if (rqstp->rq_addr.ss_family =3D=3D AF_INET)
> +				seq_printf(m, " %pI4 %pI4 ",
> +					   &((struct sockaddr_in *)&rqstp->rq_addr)->sin_addr,
> +					   &((struct sockaddr_in *)&rqstp->rq_daddr)->sin_addr);
> +			else if (rqstp->rq_addr.ss_family =3D=3D AF_INET6)
> +				seq_printf(m, " %pI6 %pI6 ",
> +					   &((struct sockaddr_in6 *)&rqstp->rq_addr)->sin6_addr,
> +					   &((struct sockaddr_in6 *)&rqstp->rq_daddr)->sin6_addr);
> +			else
> +				seq_printf(m, " unknown:%hu",

I think you'll need to add a second "unknown:%hu" here to keep the
fields aligned. In the ipv4/6 case there are 2 addresses, so you need 2
addresses here as well.

> +					   rqstp->rq_addr.ss_family);
> +#ifdef CONFIG_NFSD_V4
> +			if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
> +			    rqstp->rq_proc =3D=3D NFSPROC4_COMPOUND) {
> +				/* NFSv4 compund */
> +				struct nfsd4_compoundargs *args =3D rqstp->rq_argp;
> +				struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
> +
> +				while (resp->opcnt < args->opcnt) {
> +					struct nfsd4_op *op =3D &args->ops[resp->opcnt++];
> +
> +					seq_printf(m, " %s", nfsd4_op_name(op->opnum));

Given that this is going to be a variable-length field, we should have a
different delimiter between the different operations here. Maybe
something like a ':' or '|' character? That way the script could parse
the different operations, but we'd still be able to add new fields to
the end of the line later if we decide it's worthwhile.
=20
> +				}
> +			}
> +#endif /* CONFIG_NFSD_V4 */
> +			seq_puts(m, "\n");
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return 0;
> +}
> +
> +/**
> + * nfsd_rpc_status_open - Atomically copy a write verifier
> + * @inode: entry inode pointer.
> + * @file: entry file pointer.
> + *
> + * This routine dumps pending RPC requests info queued into nfs server.
> + */
> +int nfsd_rpc_status_open(struct inode *inode, struct file *file)
> +{
> +	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_id=
);
> +
> +	mutex_lock(&nfsd_mutex);
> +	if (!nn->nfsd_serv) {
> +		mutex_unlock(&nfsd_mutex);
> +		return -ENODEV;
> +	}
> +
> +	svc_get(nn->nfsd_serv);
> +	mutex_unlock(&nfsd_mutex);
> +
> +	return single_open(file, nfsd_rpc_status_show, inode->i_private);
> +}
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 587811a002c9..44eac83b35a1 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1629,7 +1629,7 @@ const char *svc_proc_name(const struct svc_rqst *rq=
stp)
>  		return rqstp->rq_procinfo->pc_name;
>  	return "unknown";
>  }
> -
> +EXPORT_SYMBOL_GPL(svc_proc_name);
> =20
>  /**
>   * svc_encode_result_payload - mark a range of bytes as a result payload

Other than the nits above, this is looking good!
--=20
Jeff Layton <jlayton@kernel.org>
