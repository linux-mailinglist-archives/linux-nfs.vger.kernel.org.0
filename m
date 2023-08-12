Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2FF779E63
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Aug 2023 11:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjHLI7h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 12 Aug 2023 04:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbjHLI7g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 12 Aug 2023 04:59:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B465930DA
        for <linux-nfs@vger.kernel.org>; Sat, 12 Aug 2023 01:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 339CD6371F
        for <linux-nfs@vger.kernel.org>; Sat, 12 Aug 2023 08:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7260C433C8;
        Sat, 12 Aug 2023 08:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691830765;
        bh=m08jXPhRdK8/B+F/ZxjmI0X/V5+8vZb0N6qeR2tMuxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+4pxWdLqMLH4b8JpnmqYCAXqzKlZc27eMtQ9pUMbklqM4AOl0e+W6oXIMIPs0nVi
         Tjumv3e2vMMjDpanundNVEDp98cZVQpcQ/Ml5pPrtgwAt+AW+oJ2u8QtVkEcZETQJn
         zmWQIcCR85oxvFtDv5egD2h9wn6mAEviMsRtEWK6Wtw38MhX9GNgYtijkLT446Syj6
         hyAdqAvbwF1HzAWo4X2saP98PJJ7HhJy+C3R7KcWwVjzSCtS0QDZHlWv9L9zYVVdeB
         mUGMaOX8J2yU4WT6oQ5XLKyqpWHqJuSIFVu7BHQGfJdQu2X9e1kSVOxuJ38CULFgrv
         MJFwlgbwpbJXg==
Date:   Sat, 12 Aug 2023 10:59:19 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v6 3/3] NFSD: add rpc_status entry in nfsd debug
 filesystem
Message-ID: <ZNdJ5/PePo1aQz0I@lore-rh-laptop>
References: <cover.1691656474.git.lorenzo@kernel.org>
 <177cfd4fc640d9b406101761be24da07990ca81e.1691656474.git.lorenzo@kernel.org>
 <ZNT7wdG8SYfDRkDg@tissot.1015granger.net>
 <169169907976.11073.6029761322750936330@noble.neil.brown.name>
 <2D7CA2D5-EE53-412E-9F64-DB88B4938475@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VoFy/Yiikhh2v8CM"
Content-Disposition: inline
In-Reply-To: <2D7CA2D5-EE53-412E-9F64-DB88B4938475@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--VoFy/Yiikhh2v8CM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> > On Aug 10, 2023, at 4:24 PM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Fri, 11 Aug 2023, Chuck Lever wrote:
> >> On Thu, Aug 10, 2023 at 10:39:21AM +0200, Lorenzo Bianconi wrote:
> >>> Introduce rpc_status entry in nfsd debug filesystem in order to dump
> >>> pending RPC requests debugging information.
> >>>=20
> >>> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366
> >>> Reviewed-by: NeilBrown <neilb@suse.de>
> >>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>> ---
> >>> fs/nfsd/nfs4proc.c         |   4 +-
> >>> fs/nfsd/nfsctl.c           |   9 +++
> >>> fs/nfsd/nfsd.h             |   7 ++
> >>> fs/nfsd/nfssvc.c           | 140 +++++++++++++++++++++++++++++++++++++
> >>> include/linux/sunrpc/svc.h |   1 +
> >>> net/sunrpc/svc.c           |   2 +-
> >>> 6 files changed, 159 insertions(+), 4 deletions(-)
> >>>=20
> >>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> >>> index aa4f21f92deb..ff5a1dddc0ed 100644
> >>> --- a/fs/nfsd/nfs4proc.c
> >>> +++ b/fs/nfsd/nfs4proc.c
> >>> @@ -2496,8 +2496,6 @@ static inline void nfsd4_increment_op_stats(u32=
 opnum)
> >>>=20
> >>> static const struct nfsd4_operation nfsd4_ops[];
> >>>=20
> >>> -static const char *nfsd4_op_name(unsigned opnum);
> >>> -
> >>> /*
> >>>  * Enforce NFSv4.1 COMPOUND ordering rules:
> >>>  *
> >>> @@ -3627,7 +3625,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *=
op)
> >>> }
> >>> }
> >>>=20
> >>> -static const char *nfsd4_op_name(unsigned opnum)
> >>> +const char *nfsd4_op_name(unsigned int opnum)
> >>> {
> >>> if (opnum < ARRAY_SIZE(nfsd4_ops))
> >>> return nfsd4_ops[opnum].op_name;
> >>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> >>> index dad88bff3b9e..83eb5c6d894e 100644
> >>> --- a/fs/nfsd/nfsctl.c
> >>> +++ b/fs/nfsd/nfsctl.c
> >>> @@ -47,6 +47,7 @@ enum {
> >>> NFSD_MaxBlkSize,
> >>> NFSD_MaxConnections,
> >>> NFSD_Filecache,
> >>> + NFSD_Rpc_Status,
> >>> /*
> >>> * The below MUST come last.  Otherwise we leave a hole in nfsd_files[]
> >>> * with !CONFIG_NFSD_V4 and simple_fill_super() goes oops
> >>> @@ -195,6 +196,13 @@ static inline struct net *netns(struct file *fil=
e)
> >>> return file_inode(file)->i_sb->s_fs_info;
> >>> }
> >>>=20
> >>> +static const struct file_operations nfsd_rpc_status_operations =3D {
> >>> + .open =3D nfsd_rpc_status_open,
> >>> + .read =3D seq_read,
> >>> + .llseek =3D seq_lseek,
> >>> + .release =3D nfsd_stats_release,
> >>> +};
> >>> +
> >>> /*
> >>>  * write_unlock_ip - Release all locks used by a client
> >>>  *
> >>> @@ -1394,6 +1402,7 @@ static int nfsd_fill_super(struct super_block *=
sb, struct fs_context *fc)
> >>> [NFSD_MaxBlkSize] =3D {"max_block_size", &transaction_ops, S_IWUSR|S_=
IRUGO},
> >>> [NFSD_MaxConnections] =3D {"max_connections", &transaction_ops, S_IWU=
SR|S_IRUGO},
> >>> [NFSD_Filecache] =3D {"filecache", &nfsd_file_cache_stats_fops, S_IRU=
GO},
> >>> + [NFSD_Rpc_Status] =3D {"rpc_status", &nfsd_rpc_status_operations, S=
_IRUGO},
> >>> #ifdef CONFIG_NFSD_V4
> >>> [NFSD_Leasetime] =3D {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_I=
RUSR},
> >>> [NFSD_Gracetime] =3D {"nfsv4gracetime", &transaction_ops, S_IWUSR|S_I=
RUSR},
> >>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> >>> index 55b9d85ed71b..3e8a47b93fd4 100644
> >>> --- a/fs/nfsd/nfsd.h
> >>> +++ b/fs/nfsd/nfsd.h
> >>> @@ -94,6 +94,7 @@ int nfsd_get_nrthreads(int n, int *, struct net *);
> >>> int nfsd_set_nrthreads(int n, int *, struct net *);
> >>> int nfsd_pool_stats_open(struct inode *, struct file *);
> >>> int nfsd_stats_release(struct inode *, struct file *);
> >>> +int nfsd_rpc_status_open(struct inode *inode, struct file *file);
> >>> void nfsd_shutdown_threads(struct net *net);
> >>>=20
> >>> static inline void nfsd_put(struct net *net)
> >>> @@ -511,12 +512,18 @@ extern void nfsd4_ssc_init_umount_work(struct n=
fsd_net *nn);
> >>>=20
> >>> extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> >>>=20
> >>> +const char *nfsd4_op_name(unsigned int opnum);
> >>> #else /* CONFIG_NFSD_V4 */
> >>> static inline int nfsd4_is_junction(struct dentry *dentry)
> >>> {
> >>> return 0;
> >>> }
> >>>=20
> >>> +static inline const char *nfsd4_op_name(unsigned int opnum)
> >>> +{
> >>> + return "unknown_operation";
> >>> +}
> >>> +
> >>> static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
> >>>=20
> >>> #define register_cld_notifier() 0
> >>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> >>> index 460219030ce1..237be14d3a11 100644
> >>> --- a/fs/nfsd/nfssvc.c
> >>> +++ b/fs/nfsd/nfssvc.c
> >>> @@ -998,6 +998,15 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
> >>> if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
> >>> goto out_decode_err;
> >>>=20
> >>> + /*
> >>> + * Release rq_status_counter setting it to an odd value after the rpc
> >>> + * request has been properly parsed. rq_status_counter is used to
> >>> + * notify the consumers if the rqstp fields are stable
> >>> + * (rq_status_counter is odd) or not meaningful (rq_status_counter
> >>> + * is even).
> >>> + */
> >>> + smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_count=
er | 1);
> >>> +
> >>> rp =3D NULL;
> >>> switch (nfsd_cache_lookup(rqstp, &rp)) {
> >>> case RC_DOIT:
> >>> @@ -1015,6 +1024,12 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
> >>> if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
> >>> goto out_encode_err;
> >>>=20
> >>> + /*
> >>> + * Release rq_status_counter setting it to an even value after the r=
pc
> >>> + * request has been properly processed.
> >>> + */
> >>> + smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_count=
er + 1);
> >>> +
> >>> nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
> >>> out_cached_reply:
> >>> return 1;
> >>> @@ -1101,3 +1116,128 @@ int nfsd_stats_release(struct inode *inode, s=
truct file *file)
> >>> mutex_unlock(&nfsd_mutex);
> >>> return ret;
> >>> }
> >>> +
> >>> +static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> >>> +{
> >>> + struct inode *inode =3D file_inode(m->file);
> >>> + struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_ne=
t_id);
> >>> + int i;
> >>> +
> >>> + seq_puts(m, "# XID FLAGS VERS PROC TIMESTAMP SADDR SPORT DADDR DPOR=
T COMPOUND_OPS\n");
> >>> +
> >>> + rcu_read_lock();
> >>> +
> >>> + for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> >>> + struct svc_rqst *rqstp;
> >>> +
> >>> + list_for_each_entry_rcu(rqstp,
> >>> + &nn->nfsd_serv->sv_pools[i].sp_all_threads,
> >>> + rq_all) {
> >>> + struct {
> >>> + struct sockaddr daddr;
> >>> + struct sockaddr saddr;
> >>> + unsigned long rq_flags;
> >>> + const char *pc_name;
> >>> + ktime_t rq_stime;
> >>> + __be32 rq_xid;
> >>> + u32 rq_vers;
> >>> + /* NFSv4 compund */
> >>> + u32 opnum[NFSD_MAX_OPS_PER_COMPOUND];
> >>> + } rqstp_info;
> >>> + unsigned int status_counter;
> >>> + char buf[RPC_MAX_ADDRBUFLEN];
> >>> + int opcnt =3D 0;
> >>> +
> >>> + /*
> >>> + * Acquire rq_status_counter before parsing the rqst
> >>> + * fields. rq_status_counter is set to an odd value in
> >>> + * order to notify the consumers the rqstp fields are
> >>> + * meaningful.
> >>> + */
> >>> + status_counter =3D smp_load_acquire(&rqstp->rq_status_counter);
> >>> + if (!(status_counter & 1))
> >>> + continue;
> >>> +
> >>> + rqstp_info.rq_xid =3D rqstp->rq_xid;
> >>> + rqstp_info.rq_flags =3D rqstp->rq_flags;
> >>> + rqstp_info.rq_vers =3D rqstp->rq_vers;
> >>> + rqstp_info.pc_name =3D svc_proc_name(rqstp);
> >>> + rqstp_info.rq_stime =3D rqstp->rq_stime;
> >>> + memcpy(&rqstp_info.daddr, svc_daddr(rqstp),
> >>> +       sizeof(struct sockaddr));
> >>> + memcpy(&rqstp_info.saddr, svc_addr(rqstp),
> >>> +       sizeof(struct sockaddr));
> >>> +
> >>> +#ifdef CONFIG_NFSD_V4
> >>> + if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
> >>> +    rqstp->rq_proc =3D=3D NFSPROC4_COMPOUND) {
> >>> + /* NFSv4 compund */
> >>> + struct nfsd4_compoundargs *args =3D rqstp->rq_argp;
> >>> + int j;
> >>> +
> >>> + opcnt =3D args->opcnt;
> >>> + for (j =3D 0; j < opcnt; j++) {
> >>> + struct nfsd4_op *op =3D &args->ops[j];
> >>> +
> >>> + rqstp_info.opnum[j] =3D op->opnum;
> >>> + }
> >>> + }
> >>> +#endif /* CONFIG_NFSD_V4 */
> >>> +
> >>> + /*
> >>> + * Acquire rq_status_counter before reporting the rqst
> >>> + * fields to the user.
> >>> + */
> >>> + if (smp_load_acquire(&rqstp->rq_status_counter) !=3D status_counter)
> >>> + continue;
> >>> +
> >>> + seq_printf(m,
> >>> +   "%04u %04ld NFSv%d %s %016lld",
> >>> +   be32_to_cpu(rqstp_info.rq_xid),
> >>=20
> >> It's proper to display XIDs as 8-hexit hexadecimal values, as you
> >> did before. "0x%08x" is the correct format, as that matches the
> >> XID display format used by Wireshark and our tracepoints.
> >>=20
> >>=20
> >>> +   rqstp_info.rq_flags,
> >>=20
> >> I didn't mean for you to change the flags format to decimal. I was
> >> trying to point out that the content of this field will need to be
> >> displayed symbolically if we care about an easy user experience.
> >>=20
> >> Let's stick with hex here. A clever user can read the bits directly
> >> from that. All others should have a tool that parses this field and
> >> prints the list of bits in it symbolically.
> >>=20
> >>=20
> >>> +   rqstp_info.rq_vers,
> >>> +   rqstp_info.pc_name,
> >>> +   ktime_to_us(rqstp_info.rq_stime));
> >>> + seq_printf(m, " %s",
> >>> +   __svc_print_addr(&rqstp_info.saddr, buf,
> >>> +    sizeof(buf), false));
> >>> + seq_printf(m, " %s",
> >>> +   __svc_print_addr(&rqstp_info.daddr, buf,
> >>> +    sizeof(buf), false));
> >>> + if (opcnt) {
> >>> + int j;
> >>> +
> >>> + seq_puts(m, " ");
> >>> + for (j =3D 0; j < opcnt; j++)
> >>> + seq_printf(m, "%s%s",
> >>> +   nfsd4_op_name(rqstp_info.opnum[j]),
> >>> +   j =3D=3D opcnt - 1 ? "" : ":");
> >>> + } else {
> >>> + seq_puts(m, " -");
> >>> + }
> >>=20
> >> This looks correct to me.
> >>=20
> >> I'm leaning towards moving this to a netlink API that can be
> >> extended over time to handle other stats and also act as an NFSD
> >> control plane, similar to other network subsystems.
> >>=20
> >> Any comments, complaints or rotten fruit from anyone?
> >=20
> > I think netlink is the best way forward.  'cat' is nice, but not
> > necessary.  We have an established path for distributing tools for
> > working with nfsd so we get easily get a suitable tool into the hands of
> > our users.
> >=20
> > The only fruit I have relates to the name "rpc_status", and it probably
> > over-ripe rather than rotten :-)
> > In the context of RPC, "status" means the success/failure result of a
> > request.  That is not what this file provides.  It is a list of active
> > requests.  So maybe "active_rpc".
> > One advantage of netlink is that the API is based on numbers, not names!
>=20
> There won't be a file name with netlink, so right, it won't be an
> issue.
>=20
> Lorenzo, can you proceed with netlink instead of /proc/fs/nfsd?=20
> Maybe start with a yaml spec file?

ack, I will start working on it soon.

Regards,
Lorenzo

>=20
>=20
> > NeilBrown
> >=20
> >=20
> >>=20
> >>=20
> >>> + seq_puts(m, "\n");
> >>> + }
> >>> + }
> >>> +
> >>> + rcu_read_unlock();
> >>> +
> >>> + return 0;
> >>> +}
> >>> +
> >>> +/**
> >>> + * nfsd_rpc_status_open - open routine for nfsd_rpc_status handler
> >>> + * @inode: entry inode pointer.
> >>> + * @file: entry file pointer.
> >>> + *
> >>> + * nfsd_rpc_status_open is the open routine for nfsd_rpc_status proc=
fs handler.
> >>> + * nfsd_rpc_status dumps pending RPC requests info queued into nfs s=
erver.
> >>> + */
> >>> +int nfsd_rpc_status_open(struct inode *inode, struct file *file)
> >>> +{
> >>> + int ret =3D nfsd_stats_open(inode);
> >>> +
> >>> + if (ret)
> >>> + return ret;
> >>> +
> >>> + return single_open(file, nfsd_rpc_status_show, inode->i_private);
> >>> +}
> >>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> >>> index 7838b37bcfa8..b49c0470b4fe 100644
> >>> --- a/include/linux/sunrpc/svc.h
> >>> +++ b/include/linux/sunrpc/svc.h
> >>> @@ -251,6 +251,7 @@ struct svc_rqst {
> >>> * net namespace
> >>> */
> >>> void ** rq_lease_breaker; /* The v4 client breaking a lease */
> >>> + unsigned int rq_status_counter; /* RPC processing counter */
> >>> };
> >>>=20
> >>> /* bits for rq_flags */
> >>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> >>> index af692bff44ab..83bee19df104 100644
> >>> --- a/net/sunrpc/svc.c
> >>> +++ b/net/sunrpc/svc.c
> >>> @@ -1656,7 +1656,7 @@ const char *svc_proc_name(const struct svc_rqst=
 *rqstp)
> >>> return rqstp->rq_procinfo->pc_name;
> >>> return "unknown";
> >>> }
> >>> -
> >>> +EXPORT_SYMBOL_GPL(svc_proc_name);
> >>>=20
> >>> /**
> >>>  * svc_encode_result_payload - mark a range of bytes as a result payl=
oad
> >>> --=20
> >>> 2.41.0
> >>>=20
> >>=20
> >> --=20
> >> Chuck Lever
> >>=20
> >=20
>=20
> --
> Chuck Lever
>=20
>=20

--VoFy/Yiikhh2v8CM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZNdJ5AAKCRA6cBh0uS2t
rJDMAQCqPfPJlJ2gfy1KEJ4B5fXyQnwJpLexj93kkAfbjw/lSwD3cZcVjaHe0q2/
jZ5ZVhRj8Y9yvT53pHVU3cF3Kih3AQ==
=AfNg
-----END PGP SIGNATURE-----

--VoFy/Yiikhh2v8CM--
