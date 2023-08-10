Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089AA7778E8
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Aug 2023 14:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjHJM6b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Aug 2023 08:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjHJM6b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Aug 2023 08:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275269C
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 05:58:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC50F65BF7
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 12:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D398C433C7;
        Thu, 10 Aug 2023 12:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691672309;
        bh=eO1KV7tE2hi6cZl/7YBj4L4BN+kgqMAFC45FkYMRyHA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UcrSexvrPJpR+fYjDIqYSustLh7CIdJgNEwG7OO7dvuhMuIA7fJLmI7dBiYn69/db
         2P9JOyvmq6p33Di42oY8Iik4ae2xIgPqjEaqEq/nvoDvIpi7fJVBttLohb06mPevcI
         oy0KqPzmS67shxsZ/rcVd8hB43gAIrwZdfl7LHIciI8o4dg+0/Uh5mf0+0zI5/KuLC
         DB1ptUyaKGUyZ3+pxqWuFrC77fzlKlrUAlV7sLtx49MSPY6hE5R4RsGJ4kH24J6ChR
         BpxCkGY213DGzNcGVYcCvwseYz/+9WTcVsw+INswEP8NAoxQjA4bVm3qdz1zbC7eqr
         F3xjSHGCy4oqw==
Message-ID: <84282fdda69a2eb9e884417a9fe02d1210bc14af.camel@kernel.org>
Subject: Re: [PATCH v6 3/3] NFSD: add rpc_status entry in nfsd debug
 filesystem
From:   Jeff Layton <jlayton@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com, neilb@suse.de
Date:   Thu, 10 Aug 2023 08:58:27 -0400
In-Reply-To: <177cfd4fc640d9b406101761be24da07990ca81e.1691656474.git.lorenzo@kernel.org>
References: <cover.1691656474.git.lorenzo@kernel.org>
         <177cfd4fc640d9b406101761be24da07990ca81e.1691656474.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-08-10 at 10:39 +0200, Lorenzo Bianconi wrote:
> Introduce rpc_status entry in nfsd debug filesystem in order to dump
> pending RPC requests debugging information.
>=20
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366
> Reviewed-by: NeilBrown <neilb@suse.de>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c         |   4 +-
>  fs/nfsd/nfsctl.c           |   9 +++
>  fs/nfsd/nfsd.h             |   7 ++
>  fs/nfsd/nfssvc.c           | 140 +++++++++++++++++++++++++++++++++++++
>  include/linux/sunrpc/svc.h |   1 +
>  net/sunrpc/svc.c           |   2 +-
>  6 files changed, 159 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index aa4f21f92deb..ff5a1dddc0ed 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2496,8 +2496,6 @@ static inline void nfsd4_increment_op_stats(u32 opn=
um)
> =20
>  static const struct nfsd4_operation nfsd4_ops[];
> =20
> -static const char *nfsd4_op_name(unsigned opnum);
> -
>  /*
>   * Enforce NFSv4.1 COMPOUND ordering rules:
>   *
> @@ -3627,7 +3625,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)
>  	}
>  }
> =20
> -static const char *nfsd4_op_name(unsigned opnum)
> +const char *nfsd4_op_name(unsigned int opnum)
>  {
>  	if (opnum < ARRAY_SIZE(nfsd4_ops))
>  		return nfsd4_ops[opnum].op_name;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index dad88bff3b9e..83eb5c6d894e 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -47,6 +47,7 @@ enum {
>  	NFSD_MaxBlkSize,
>  	NFSD_MaxConnections,
>  	NFSD_Filecache,
> +	NFSD_Rpc_Status,
>  	/*
>  	 * The below MUST come last.  Otherwise we leave a hole in nfsd_files[]
>  	 * with !CONFIG_NFSD_V4 and simple_fill_super() goes oops
> @@ -195,6 +196,13 @@ static inline struct net *netns(struct file *file)
>  	return file_inode(file)->i_sb->s_fs_info;
>  }
> =20
> +static const struct file_operations nfsd_rpc_status_operations =3D {
> +	.open		=3D nfsd_rpc_status_open,
> +	.read		=3D seq_read,
> +	.llseek		=3D seq_lseek,
> +	.release	=3D nfsd_stats_release,
> +};
> +
>  /*
>   * write_unlock_ip - Release all locks used by a client
>   *
> @@ -1394,6 +1402,7 @@ static int nfsd_fill_super(struct super_block *sb, =
struct fs_context *fc)
>  		[NFSD_MaxBlkSize] =3D {"max_block_size", &transaction_ops, S_IWUSR|S_I=
RUGO},
>  		[NFSD_MaxConnections] =3D {"max_connections", &transaction_ops, S_IWUS=
R|S_IRUGO},
>  		[NFSD_Filecache] =3D {"filecache", &nfsd_file_cache_stats_fops, S_IRUG=
O},
> +		[NFSD_Rpc_Status] =3D {"rpc_status", &nfsd_rpc_status_operations, S_IR=
UGO},
>  #ifdef CONFIG_NFSD_V4
>  		[NFSD_Leasetime] =3D {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IR=
USR},
>  		[NFSD_Gracetime] =3D {"nfsv4gracetime", &transaction_ops, S_IWUSR|S_IR=
USR},
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 55b9d85ed71b..3e8a47b93fd4 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -94,6 +94,7 @@ int		nfsd_get_nrthreads(int n, int *, struct net *);
>  int		nfsd_set_nrthreads(int n, int *, struct net *);
>  int		nfsd_pool_stats_open(struct inode *, struct file *);
>  int		nfsd_stats_release(struct inode *, struct file *);
> +int		nfsd_rpc_status_open(struct inode *inode, struct file *file);
>  void		nfsd_shutdown_threads(struct net *net);
> =20
>  static inline void nfsd_put(struct net *net)
> @@ -511,12 +512,18 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_=
net *nn);
> =20
>  extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> =20
> +const char *nfsd4_op_name(unsigned int opnum);
>  #else /* CONFIG_NFSD_V4 */
>  static inline int nfsd4_is_junction(struct dentry *dentry)
>  {
>  	return 0;
>  }
> =20
> +static inline const char *nfsd4_op_name(unsigned int opnum)
> +{
> +	return "unknown_operation";
> +}
> +
>  static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
> =20
>  #define register_cld_notifier() 0
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 460219030ce1..237be14d3a11 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -998,6 +998,15 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
>  		goto out_decode_err;
> =20
> +	/*
> +	 * Release rq_status_counter setting it to an odd value after the rpc
> +	 * request has been properly parsed. rq_status_counter is used to
> +	 * notify the consumers if the rqstp fields are stable
> +	 * (rq_status_counter is odd) or not meaningful (rq_status_counter
> +	 * is even).
> +	 */
> +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter |=
 1);
> +
>  	rp =3D NULL;
>  	switch (nfsd_cache_lookup(rqstp, &rp)) {
>  	case RC_DOIT:
> @@ -1015,6 +1024,12 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
>  		goto out_encode_err;
> =20
> +	/*
> +	 * Release rq_status_counter setting it to an even value after the rpc
> +	 * request has been properly processed.
> +	 */
> +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter +=
 1);
> +
>  	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
>  out_cached_reply:
>  	return 1;
> @@ -1101,3 +1116,128 @@ int nfsd_stats_release(struct inode *inode, struc=
t file *file)
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
> +	seq_puts(m, "# XID FLAGS VERS PROC TIMESTAMP SADDR SPORT DADDR DPORT CO=
MPOUND_OPS\n");
> +
> +	rcu_read_lock();
> +
> +	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> +		struct svc_rqst *rqstp;
> +
> +		list_for_each_entry_rcu(rqstp,
> +				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> +				rq_all) {
> +			struct {
> +				struct sockaddr daddr;
> +				struct sockaddr saddr;
> +				unsigned long rq_flags;
> +				const char *pc_name;
> +				ktime_t rq_stime;
> +				__be32 rq_xid;
> +				u32 rq_vers;
> +				/* NFSv4 compund */
> +				u32 opnum[NFSD_MAX_OPS_PER_COMPOUND];
> +			} rqstp_info;
> +			unsigned int status_counter;
> +			char buf[RPC_MAX_ADDRBUFLEN];
> +			int opcnt =3D 0;
> +
> +			/*
> +			 * Acquire rq_status_counter before parsing the rqst
> +			 * fields. rq_status_counter is set to an odd value in
> +			 * order to notify the consumers the rqstp fields are
> +			 * meaningful.
> +			 */
> +			status_counter =3D smp_load_acquire(&rqstp->rq_status_counter);
> +			if (!(status_counter & 1))
> +				continue;
> +
> +			rqstp_info.rq_xid =3D rqstp->rq_xid;
> +			rqstp_info.rq_flags =3D rqstp->rq_flags;
> +			rqstp_info.rq_vers =3D rqstp->rq_vers;
> +			rqstp_info.pc_name =3D svc_proc_name(rqstp);
> +			rqstp_info.rq_stime =3D rqstp->rq_stime;
> +			memcpy(&rqstp_info.daddr, svc_daddr(rqstp),
> +			       sizeof(struct sockaddr));
> +			memcpy(&rqstp_info.saddr, svc_addr(rqstp),
> +			       sizeof(struct sockaddr));
> +
> +#ifdef CONFIG_NFSD_V4
> +			if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
> +			    rqstp->rq_proc =3D=3D NFSPROC4_COMPOUND) {
> +				/* NFSv4 compund */
> +				struct nfsd4_compoundargs *args =3D rqstp->rq_argp;
> +				int j;
> +
> +				opcnt =3D args->opcnt;
> +				for (j =3D 0; j < opcnt; j++) {
> +					struct nfsd4_op *op =3D &args->ops[j];
> +
> +					rqstp_info.opnum[j] =3D op->opnum;
> +				}
> +			}
> +#endif /* CONFIG_NFSD_V4 */
> +
> +			/*
> +			 * Acquire rq_status_counter before reporting the rqst
> +			 * fields to the user.
> +			 */
> +			if (smp_load_acquire(&rqstp->rq_status_counter) !=3D status_counter)
> +				continue;
> +
> +			seq_printf(m,
> +				   "%04u %04ld NFSv%d %s %016lld",
> +				   be32_to_cpu(rqstp_info.rq_xid),
> +				   rqstp_info.rq_flags,
> +				   rqstp_info.rq_vers,
> +				   rqstp_info.pc_name,
> +				   ktime_to_us(rqstp_info.rq_stime));
> +			seq_printf(m, " %s",
> +				   __svc_print_addr(&rqstp_info.saddr, buf,
> +						    sizeof(buf), false));
> +			seq_printf(m, " %s",
> +				   __svc_print_addr(&rqstp_info.daddr, buf,
> +						    sizeof(buf), false));
> +			if (opcnt) {
> +				int j;
> +
> +				seq_puts(m, " ");
> +				for (j =3D 0; j < opcnt; j++)
> +					seq_printf(m, "%s%s",
> +						   nfsd4_op_name(rqstp_info.opnum[j]),
> +						   j =3D=3D opcnt - 1 ? "" : ":");
> +			} else {
> +				seq_puts(m, " -");
> +			}
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
> + * nfsd_rpc_status_open - open routine for nfsd_rpc_status handler
> + * @inode: entry inode pointer.
> + * @file: entry file pointer.
> + *
> + * nfsd_rpc_status_open is the open routine for nfsd_rpc_status procfs h=
andler.
> + * nfsd_rpc_status dumps pending RPC requests info queued into nfs serve=
r.
> + */
> +int nfsd_rpc_status_open(struct inode *inode, struct file *file)
> +{
> +	int ret =3D nfsd_stats_open(inode);
> +
> +	if (ret)
> +		return ret;
> +
> +	return single_open(file, nfsd_rpc_status_show, inode->i_private);
> +}
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 7838b37bcfa8..b49c0470b4fe 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -251,6 +251,7 @@ struct svc_rqst {
>  						 * net namespace
>  						 */
>  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> +	unsigned int		rq_status_counter; /* RPC processing counter */
>  };
> =20
>  /* bits for rq_flags */
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index af692bff44ab..83bee19df104 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1656,7 +1656,7 @@ const char *svc_proc_name(const struct svc_rqst *rq=
stp)
>  		return rqstp->rq_procinfo->pc_name;
>  	return "unknown";
>  }
> -
> +EXPORT_SYMBOL_GPL(svc_proc_name);
> =20
>  /**
>   * svc_encode_result_payload - mark a range of bytes as a result payload

LGTM (at least until we decide the right sort of interface for this
thing).

Reviewed-by: Jeff Layton <jlayton@kernel.org>
