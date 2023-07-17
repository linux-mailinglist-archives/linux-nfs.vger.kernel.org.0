Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19026756F1F
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jul 2023 23:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjGQVtg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jul 2023 17:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGQVtg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jul 2023 17:49:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FC318D
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 14:49:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0FBF821906;
        Mon, 17 Jul 2023 21:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689630572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NEiuhFpDJt41CxMn8KqZ/C5pngD46ngqNY25fo3jtko=;
        b=CBn5iSbjV1O7UHcT09R0TDDjLIruBdFU3XQpxw/4sckAJbVHbuPEHDzM+x16O49YSPNq8P
        7x5+/syUV6cYLMgu0Qa+sNl+QD/WXNNZX8ES92WbuHx3Fj1lpMkCCSs2brI6uB0Fe8dHLR
        Na9o4ID7URLUiX9d24l6LOZBtJDaEWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689630572;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NEiuhFpDJt41CxMn8KqZ/C5pngD46ngqNY25fo3jtko=;
        b=fD1T+H9VoNuiEpUDkBJyGz4wnLV89ZxvlYe9V+v4kYoOUO51zjDHgOwrgMt9vO2zyl0C+0
        RyzdgA5ZkFZRU2Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2968213276;
        Mon, 17 Jul 2023 21:49:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3N4oM2m3tWTDKQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 17 Jul 2023 21:49:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Lorenzo Bianconi" <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: Re: [PATCH v3] NFSD: add rpc_status entry in nfsd debug filesystem
In-reply-to: <4aa3c87872031ca42d411ed60169c6daa951620b.1689610081.git.lorenzo@kernel.org>
References: <4aa3c87872031ca42d411ed60169c6daa951620b.1689610081.git.lorenzo@kernel.org>
Date:   Tue, 18 Jul 2023 07:49:24 +1000
Message-id: <168963056470.1518.10737362406173956339@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 18 Jul 2023, Lorenzo Bianconi wrote:
> Introduce rpc_status entry in nfsd debug filesystem in order to dump
> pending RPC requests debugging information.
>=20
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes since v2:
> - minor changes in nfsd_rpc_status_show output
>=20
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
>  fs/nfsd/nfssvc.c   | 83 ++++++++++++++++++++++++++++++++++++++++++++++
>  net/sunrpc/svc.c   |  2 +-
>  5 files changed, 97 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index d8e7a533f9d2..a7f522390a66 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2463,8 +2463,6 @@ static inline void nfsd4_increment_op_stats(u32 opnum)
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
> @@ -1400,6 +1409,7 @@ static int nfsd_fill_super(struct super_block *sb, st=
ruct fs_context *fc)
>  		[NFSD_RecoveryDir] =3D {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_=
IRUSR},
>  		[NFSD_V4EndGrace] =3D {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRUGO=
},
>  #endif
> +		[NFSD_Rpc_Status] =3D {"rpc_status", &nfsd_rpc_status_operations, S_IRUG=
O},
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
> @@ -506,6 +507,7 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_net =
*nn);
> =20
>  extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> =20
> +const char *nfsd4_op_name(unsigned opnum);
>  #else /* CONFIG_NFSD_V4 */
>  static inline int nfsd4_is_junction(struct dentry *dentry)
>  {
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 97830e28c140..3f6d53e5f579 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1149,3 +1149,86 @@ int nfsd_pool_stats_release(struct inode *inode, str=
uct file *file)
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
> +			if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
> +				continue;

The fact that RQ_BUSY is set doesn't mean that the various fields you
are sampling are valid or stable.

I suggest you add add a counter to the rqstp which is incremented from
even to odd after parsing a request - including he v4 parsing needed to
have a sable ->opcnt - and then incremented from odd to even when the
request is complete.
Then this code samples the counter, skips the rqst if the counter is
even, and resamples the counter after collecting the data.  If it has
changed, the drop the record.

> +
> +			seq_printf(m,
> +				   "0x%08x 0x%08lx 0x%08x NFSv%d %s %016lld",
> +				   be32_to_cpu(rqstp->rq_xid), rqstp->rq_flags,
> +				   rqstp->rq_prog, rqstp->rq_vers,
> +				   svc_proc_name(rqstp),
> +				   ktime_to_us(rqstp->rq_stime));
> +
> +			if (rqstp->rq_addr.ss_family =3D=3D AF_INET)
> +				seq_printf(m, " %pI4 %pI4",
> +					   &((struct sockaddr_in *)&rqstp->rq_addr)->sin_addr,
> +					   &((struct sockaddr_in *)&rqstp->rq_daddr)->sin_addr);
> +			else if (rqstp->rq_addr.ss_family =3D=3D AF_INET6)
> +				seq_printf(m, " %pI6 %pI6",
> +					   &((struct sockaddr_in6 *)&rqstp->rq_addr)->sin6_addr,
> +					   &((struct sockaddr_in6 *)&rqstp->rq_daddr)->sin6_addr);
> +			else
> +				seq_printf(m, " unknown:%hu unknown:%hu",
> +					   rqstp->rq_addr.ss_family,
> +					   rqstp->rq_daddr.ss_family);

The above code looks a lot like svc_print_addr().  Can we use the same
code?  Do they need to be different.

NeilBrown


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
> +					seq_printf(m, " %s%s", nfsd4_op_name(op->opnum),
> +						   resp->opcnt < args->opcnt ? ":" : "");
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

