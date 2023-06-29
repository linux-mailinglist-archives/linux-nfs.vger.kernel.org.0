Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AB57424CB
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 13:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjF2LKY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 07:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjF2LKI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 07:10:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E63358A
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 04:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3BFF6152C
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 11:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2199C433C8;
        Thu, 29 Jun 2023 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688037006;
        bh=oF/kM0CMXA31PshfnrPtdYM3GGjPf6ahj2eONsOHMX0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZPt6mZdnsxEHhy/WHJ6WN7KkeYBj+dVqZNIkG22T7Me3rzLpCh/KWRuYV10wwuvUV
         4HwEPmQLWlpuF/vLqhmY35HcpXZTJwfQAgmsoUXyPe1hMhHQJ6FOlQTzf4/2iESzzn
         I9bfvjy5LP25x8SHHiHCEsQLlKn6jowYApjWqvMJmkSXDqNsrOoTVI6zsr47EGiBYw
         EiZhJDBAsb32jGkoH4C0pX3lfOZnL16hAr7HBJS58xDO9ysj6iTK4GkijhQY7tuNIi
         xLzxpKVXWsea6YVkxkC9PwoLHimGupT/jkYWt1o324N6OmOW4Xb72wLsR7I6OZU1iI
         Yk+UYS3CUUEtQ==
Message-ID: <ba88166cb8a891fdb62ddd2bd8b7605f06aea0a6.camel@kernel.org>
Subject: Re: [RFC] NFSD: add rpc_status entry in nfsd debug filesystem
From:   Jeff Layton <jlayton@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com
Date:   Thu, 29 Jun 2023 07:10:04 -0400
In-Reply-To: <bac972c22c5acfa43969bb1bf164341b16ea045c.1688032742.git.lorenzo@kernel.org>
References: <bac972c22c5acfa43969bb1bf164341b16ea045c.1688032742.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-06-29 at 12:17 +0200, Lorenzo Bianconi wrote:
> Introduce rpc_status entry in nfsd debug filesystem in order to dump
> pending RPC requests debugging information.
>=20
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c |  4 +--
>  fs/nfsd/nfsctl.c   | 18 ++++++++++++++
>  fs/nfsd/nfsd.h     |  2 ++
>  fs/nfsd/nfssvc.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  net/sunrpc/svc.c   |  2 +-
>  5 files changed, 83 insertions(+), 4 deletions(-)
>=20

This looks good, Lorenzo. Nice work! Comments below.

> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 5ae670807449..a4dd1ef104c3 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2452,8 +2452,6 @@ static inline void nfsd4_increment_op_stats(u32 opn=
um)
> =20
>  static const struct nfsd4_operation nfsd4_ops[];
> =20
> -static const char *nfsd4_op_name(unsigned opnum);
> -
>  /*
>   * Enforce NFSv4.1 COMPOUND ordering rules:
>   *
> @@ -3583,7 +3581,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)
>  	}
>  }
> =20
> -static const char *nfsd4_op_name(unsigned opnum)
> +const char *nfsd4_op_name(unsigned opnum)
>  {
>  	if (opnum < ARRAY_SIZE(nfsd4_ops))
>  		return nfsd4_ops[opnum].op_name;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 1489e0b703b4..9d0b0a53510b 100644
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
> @@ -195,6 +197,21 @@ static inline struct net *netns(struct file *file)
>  	return file_inode(file)->i_sb->s_fs_info;
>  }
> =20
> +static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> +{
> +	struct nfsd_net *nn =3D net_generic(file_inode(m->file)->i_sb->s_fs_inf=
o,
> +					  nfsd_net_id);
> +
> +	mutex_lock(&nfsd_mutex);
> +	if (nn->nfsd_serv)
> +		nsfd_rpc_status(m, nn->nfsd_serv);
> +	mutex_unlock(&nfsd_mutex);
> +
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(nfsd_rpc_status);
> +
>  /*
>   * write_unlock_ip - Release all locks used by a client
>   *
> @@ -1400,6 +1417,7 @@ static int nfsd_fill_super(struct super_block *sb, =
struct fs_context *fc)
>  		[NFSD_RecoveryDir] =3D {"nfsv4recoverydir", &transaction_ops, S_IWUSR|=
S_IRUSR},
>  		[NFSD_V4EndGrace] =3D {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRU=
GO},
>  #endif
> +		[NFSD_Rpc_Status] =3D {"rpc_status", &nfsd_rpc_status_fops, S_IRUGO},
>  		/* last one */ {""}
>  	};
> =20
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index d88498f8b275..a149157ec243 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -87,6 +87,7 @@ bool		nfssvc_encode_voidres(struct svc_rqst *rqstp,
>   */
>  int		nfsd_svc(int nrservs, struct net *net, const struct cred *cred);
>  int		nfsd_dispatch(struct svc_rqst *rqstp);
> +void		nsfd_rpc_status(struct seq_file *m, struct svc_serv *serv);

nit: please rename this to nfsd_rpc_status

> =20
>  int		nfsd_nrthreads(struct net *);
>  int		nfsd_nrpools(struct net *);
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
> index 9c7b1ef5be40..7a881f9a3a13 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1142,3 +1142,64 @@ int nfsd_pool_stats_release(struct inode *inode, s=
truct file *file)
>  	mutex_unlock(&nfsd_mutex);
>  	return ret;
>  }
> +
> +void nsfd_rpc_status(struct seq_file *m, struct svc_serv *serv)
> +{
> +	int i;
> +
> +	lockdep_assert_held(&nfsd_mutex);
> +
> +	rcu_read_lock();

Both sv_nrpools and the sp_all_threads list are protected by the
nfsd_mutex, so I don't think you need the rcu_read_lock here too.

It would be nice if we could do this with only the rcu_read_lock. I
think accessing all of the svc_rqst fields under the rcu_read_lock is
safe, and sv_nrpools is only set when the service is created, so I think
that would be safe.


> +
> +	for (i =3D 0; i < serv->sv_nrpools; i++) {
> +		struct svc_rqst *rqstp;
> +
> +		seq_puts(m, "XID        | FLAGS      | PROG       |");
> +		seq_puts(m, " VERS       | PROC\t|");
> +		seq_puts(m, " REMOTE - LOCAL IP ADDR");
> +		seq_puts(m, "\t\t\t\t\t\t\t\t   | NFS4 COMPOUND OPS\n");
> +		list_for_each_entry_rcu(rqstp,
> +					&serv->sv_pools[i].sp_all_threads,
> +					rq_all) {
> +			if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
> +				continue;
> +
> +			seq_printf(m,
> +				   "0x%08x | 0x%08lx | 0x%08x | NFSv%d      | %s\t|",
> +				   be32_to_cpu(rqstp->rq_xid), rqstp->rq_flags,
> +				   rqstp->rq_prog, rqstp->rq_vers,
> +				   svc_proc_name(rqstp));
> +
> +			if (rqstp->rq_addr.ss_family =3D=3D AF_INET) {
> +				seq_printf(m, " %pI4 - %pI4\t\t\t\t\t\t\t   |",
> +					   &((struct sockaddr_in *)&rqstp->rq_addr)->sin_addr,
> +					   &((struct sockaddr_in *)&rqstp->rq_daddr)->sin_addr);
> +			} else if (rqstp->rq_addr.ss_family =3D=3D AF_INET6) {
> +				seq_printf(m, " %pI6 - %pI6 |",
> +					   &((struct sockaddr_in6 *)&rqstp->rq_addr)->sin6_addr,
> +					   &((struct sockaddr_in6 *)&rqstp->rq_daddr)->sin6_addr);
> +			} else {
> +				seq_printf(m, " Unknown address family: %hu\n",
> +					   rqstp->rq_addr.ss_family);
> +				continue;
> +			}
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
> +				}
> +			}
> +#endif /* CONFIG_NFSD_V4 */
> +			seq_puts(m, "\n");
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +}
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index e6d4cec61e47..f99cad92e9f4 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1625,7 +1625,7 @@ const char *svc_proc_name(const struct svc_rqst *rq=
stp)
>  		return rqstp->rq_procinfo->pc_name;
>  	return "unknown";
>  }
> -
> +EXPORT_SYMBOL_GPL(svc_proc_name);
> =20
>  /**
>   * svc_encode_result_payload - mark a range of bytes as a result payload

--=20
Jeff Layton <jlayton@kernel.org>
