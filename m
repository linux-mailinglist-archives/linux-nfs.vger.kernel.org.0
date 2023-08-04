Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9510D770C01
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Aug 2023 00:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjHDWlP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 18:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjHDWlO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 18:41:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E6F4EF1
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 15:41:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6461F21870;
        Fri,  4 Aug 2023 22:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691188861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ri2HtbMNX/cfg1bqzV7wKt7Ow3IG6pa6TB8r09cc4jk=;
        b=F0BReGofcTzkRh79ph9QOvXbZYBeu6Z5NEItPV8i6qwqz05ki3214nN26BTZvhoCyPIW5U
        hRkex7n7BuVN4SSSG2ymYhAJ00Ywe6M+7uTji9HiEmT2UhcpWVMUHlDnWwmKznRM7t549U
        9QiFQ5W2lfgR7nk8lAISn8MzPpyLw1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691188861;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ri2HtbMNX/cfg1bqzV7wKt7Ow3IG6pa6TB8r09cc4jk=;
        b=90CT9MvCUAujQ2MTZlWNUuWBeagqsF3aRzHCQsmMGFTss1vdLXlADrBuk13dwGzudm4s7f
        oQvgkWeKit8rAxBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 871D2133B5;
        Fri,  4 Aug 2023 22:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hObTDnt+zWSQdQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 04 Aug 2023 22:40:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Lorenzo Bianconi" <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: Re: [PATCH v5 2/2] NFSD: add rpc_status entry in nfsd debug filesystem
In-reply-to: <d0b6183a4fda5b333711caee73cbb06ba0147057.1691169103.git.lorenzo@kernel.org>
References: <cover.1691169103.git.lorenzo@kernel.org>,
 <d0b6183a4fda5b333711caee73cbb06ba0147057.1691169103.git.lorenzo@kernel.org>
Date:   Sat, 05 Aug 2023 08:40:54 +1000
Message-id: <169118885443.32308.7901509987301611166@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 05 Aug 2023, Lorenzo Bianconi wrote:
> Introduce rpc_status entry in nfsd debug filesystem in order to dump
> pending RPC requests debugging information.
>=20
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366
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
> index f0f318e78630..b7ad3081bc36 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2497,8 +2497,6 @@ static inline void nfsd4_increment_op_stats(u32 opnum)
> =20
>  static const struct nfsd4_operation nfsd4_ops[];
> =20
> -static const char *nfsd4_op_name(unsigned opnum);
> -
>  /*
>   * Enforce NFSv4.1 COMPOUND ordering rules:
>   *
> @@ -3628,7 +3626,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)
>  	}
>  }
> =20
> -static const char *nfsd4_op_name(unsigned opnum)
> +const char *nfsd4_op_name(unsigned opnum)
>  {
>  	if (opnum < ARRAY_SIZE(nfsd4_ops))
>  		return nfsd4_ops[opnum].op_name;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 35d2e2cde1eb..d47b98bad96e 100644
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
> +	.release	=3D nfsd_pool_stats_release,
                          ^^^^^^^^^^^^^^^^^^^^^^^
This looks a bit strange, and nfsd_rpc_status_open is very similar to
nfsd_pool_stats_open.
I wonder we could unify some code a bit?
Maybe change nfsd_pool_stats_operations to nfsd_stats_operations,
with an "open" operation that inspects file_inode(file)->i_ino and=20
does either nfsd_pool_stats_open or
    single_open(file, nfsd_rpc_status_show, inode->i_private);
??

Or at least rename nfsd_pool_stats_release to something more generic?

But that can be added later - it doesn't need to stop this patch
landing.

For this patch and the previous one;

 Reviewed-by: NeilBrown <neilb@suse.de>


> +};
> +
>  /*
>   * write_unlock_ip - Release all locks used by a client
>   *
> @@ -1400,6 +1408,7 @@ static int nfsd_fill_super(struct super_block *sb, st=
ruct fs_context *fc)
>  		[NFSD_RecoveryDir] =3D {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_=
IRUSR},
>  		[NFSD_V4EndGrace] =3D {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRUGO=
},
>  #endif
> +		[NFSD_Rpc_Status] =3D {"rpc_status", &nfsd_rpc_status_operations, S_IRUG=
O},

If this could go earlier so that the array entries are in the same order
as the enum declaration, that would make me happy ....

NeilBrown


>  		/* last one */ {""}
>  	};
> =20
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index d88498f8b275..50c82bb42e88 100644
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
> @@ -506,12 +507,18 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_ne=
t *nn);
> =20
>  extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> =20
> +const char *nfsd4_op_name(unsigned opnum);
>  #else /* CONFIG_NFSD_V4 */
>  static inline int nfsd4_is_junction(struct dentry *dentry)
>  {
>  	return 0;
>  }
> =20
> +static inline const char *nfsd4_op_name(unsigned opnum)
> +{
> +	return "unknown_operation";
> +}
> +
>  static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
> =20
>  #define register_cld_notifier() 0
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 97830e28c140..5e115dbbe9dc 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1057,6 +1057,15 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
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
> +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter | 1=
);
> +
>  	rp =3D NULL;
>  	switch (nfsd_cache_lookup(rqstp, &rp)) {
>  	case RC_DOIT:
> @@ -1074,6 +1083,12 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
>  		goto out_encode_err;
> =20
> +	/*
> +	 * Release rq_status_counter setting it to an even value after the rpc
> +	 * request has been properly processed.
> +	 */
> +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter + 1=
);
> +
>  	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
>  out_cached_reply:
>  	return 1;
> @@ -1149,3 +1164,128 @@ int nfsd_pool_stats_release(struct inode *inode, st=
ruct file *file)
>  	mutex_unlock(&nfsd_mutex);
>  	return ret;
>  }
> +
> +static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> +{
> +	struct inode *inode =3D file_inode(m->file);
> +	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
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
> +			struct {
> +				struct sockaddr daddr;
> +				struct sockaddr saddr;
> +				unsigned long rq_flags;
> +				const char *pc_name;
> +				ktime_t rq_stime;
> +				__be32 rq_xid;
> +				u32 rq_prog;
> +				u32 rq_vers;
> +				/* NFSv4 compund */
> +				u32 opnum[NFSD_MAX_OPS_PER_COMPOUND];
> +				u8 opcnt;
> +			} rqstp_info;
> +			unsigned int status_counter;
> +			char buf[RPC_MAX_ADDRBUFLEN];
> +			int j;
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
> +			rqstp_info.rq_prog =3D rqstp->rq_prog;
> +			rqstp_info.rq_vers =3D rqstp->rq_vers;
> +			rqstp_info.pc_name =3D svc_proc_name(rqstp);
> +			rqstp_info.rq_stime =3D rqstp->rq_stime;
> +			rqstp_info.opcnt =3D 0;
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
> +
> +				rqstp_info.opcnt =3D args->opcnt;
> +				for (j =3D 0; j < rqstp_info.opcnt; j++) {
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
> +				   "0x%08x 0x%08lx 0x%08x NFSv%d %s %016lld",
> +				   be32_to_cpu(rqstp_info.rq_xid),
> +				   rqstp_info.rq_flags,
> +				   rqstp_info.rq_prog,
> +				   rqstp_info.rq_vers,
> +				   rqstp_info.pc_name,
> +				   ktime_to_us(rqstp_info.rq_stime));
> +			seq_printf(m, " %s",
> +				   __svc_print_addr(&rqstp_info.saddr, buf,
> +						    sizeof(buf), false));
> +			seq_printf(m, " %s",
> +				   __svc_print_addr(&rqstp_info.daddr, buf,
> +						    sizeof(buf), false));
> +			for (j =3D 0; j < rqstp_info.opcnt; j++)
> +				seq_printf(m, " %s",
> +					   nfsd4_op_name(rqstp_info.opnum[j]));
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
> + * nfsd_rpc_status_open is the open routine for nfsd_rpc_status procfs han=
dler.
> + * nfsd_rpc_status dumps pending RPC requests info queued into nfs server.
> + */
> +int nfsd_rpc_status_open(struct inode *inode, struct file *file)
> +{
> +	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
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
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index fe1394cc1371..542a60b78bab 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -270,6 +270,7 @@ struct svc_rqst {
>  						 * net namespace
>  						 */
>  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> +	unsigned int		rq_status_counter; /* RPC processing counter */
>  };
> =20
>  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_b=
c_net)
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 587811a002c9..44eac83b35a1 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1629,7 +1629,7 @@ const char *svc_proc_name(const struct svc_rqst *rqst=
p)
>  		return rqstp->rq_procinfo->pc_name;
>  	return "unknown";
>  }
> -
> +EXPORT_SYMBOL_GPL(svc_proc_name);
> =20
>  /**
>   * svc_encode_result_payload - mark a range of bytes as a result payload
> --=20
> 2.41.0
>=20
>=20

