Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3769F74EBC0
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 12:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGKKeE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jul 2023 06:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGKKeD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jul 2023 06:34:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607CCE56
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 03:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAA3361461
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 10:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD99C433C8;
        Tue, 11 Jul 2023 10:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689071637;
        bh=yvQy67s98cCk7vUyXAyFd9dHavhpJcmGG5FTVId59zQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RIqCjSx6E18qoY+c+nae/sMOr7mNerpCcAx+T7bfclI3hoUdCfIWEz+lVvqz/IKG0
         WzYif72yUi0i3iYIAhzcCx89KrcwihnehZ4757lDW6nHzjQJy4QA41yZt/yEy6vpEW
         iFm+FElfAxpXFUXI90otfA48LtxpEgjdVmMMpfU+TRftk16lB8bRZNX5TyrLYc5eVJ
         nFuz+xtUYoBaTi/ADGPca622+A/u4Dtfw8Tow0/+WkRPaAqWbx+LRhcWK1gwgsQTIQ
         iqjCtnDwg4lkmGs4nAuHFtYggkxGHjN2OnArE35N4PeRdvHHGYaP5fGyOS3U+e1gRQ
         GDNAui5C1o3ag==
Date:   Tue, 11 Jul 2023 12:33:53 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        chuck.lever@oracle.com
Subject: Re: [PATCH] NFSD: add rpc_status entry in nfsd debug filesystem
Message-ID: <ZK0wEZytW0TGfflW@lore-desk>
References: <9495cf3f3674351579b5fd13d5ccacd7a6336088.1689005402.git.lorenzo@kernel.org>
 <1034ac186c7df01611052e743fded11d6a4fc179.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jcgeSkBQke8HJP20"
Content-Disposition: inline
In-Reply-To: <1034ac186c7df01611052e743fded11d6a4fc179.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--jcgeSkBQke8HJP20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 2023-07-10 at 18:16 +0200, Lorenzo Bianconi wrote:
> > Introduce rpc_status entry in nfsd debug filesystem in order to dump
> > pending RPC requests debugging information.
> >=20
> > Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes since RFCv1:
> > - riduce time holding nfsd_mutex bumping svc_serv refcoung in
> >   nfsd_rpc_status_open()
> > - dump rqstp->rq_stime
> > - add missing kdoc for nfsd_rpc_status_open()
> > ---
> >  fs/nfsd/nfs4proc.c |  4 +--
> >  fs/nfsd/nfsctl.c   | 10 ++++++
> >  fs/nfsd/nfsd.h     |  2 ++
> >  fs/nfsd/nfssvc.c   | 88 ++++++++++++++++++++++++++++++++++++++++++++++
> >  net/sunrpc/svc.c   |  2 +-
> >  5 files changed, 102 insertions(+), 4 deletions(-)
> >=20
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
> > index 1b8b1aab9a15..629b4296e7c6 100644
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
> > @@ -195,6 +197,13 @@ static inline struct net *netns(struct file *file)
> >  	return file_inode(file)->i_sb->s_fs_info;
> >  }
> > =20
> > +static const struct file_operations nfsd_rpc_status_operations =3D {
> > +	.open		=3D nfsd_rpc_status_open,
> > +	.read		=3D seq_read,
> > +	.llseek		=3D seq_lseek,
> > +	.release	=3D nfsd_pool_stats_release,
> > +};
> > +
> >  /*
> >   * write_unlock_ip - Release all locks used by a client
> >   *
> > @@ -1400,6 +1409,7 @@ static int nfsd_fill_super(struct super_block *sb=
, struct fs_context *fc)
> >  		[NFSD_RecoveryDir] =3D {"nfsv4recoverydir", &transaction_ops, S_IWUS=
R|S_IRUSR},
> >  		[NFSD_V4EndGrace] =3D {"v4_end_grace", &transaction_ops, S_IWUSR|S_I=
RUGO},
> >  #endif
> > +		[NFSD_Rpc_Status] =3D {"rpc_status", &nfsd_rpc_status_operations, S_=
IRUGO},
> >  		/* last one */ {""}
> >  	};
> > =20
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index d88498f8b275..75a3e1d55bc8 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -94,6 +94,7 @@ int		nfsd_get_nrthreads(int n, int *, struct net *);
> >  int		nfsd_set_nrthreads(int n, int *, struct net *);
> >  int		nfsd_pool_stats_open(struct inode *, struct file *);
> >  int		nfsd_pool_stats_release(struct inode *, struct file *);
> > +int		nfsd_rpc_status_open(struct inode *inode, struct file *file);
> >  void		nfsd_shutdown_threads(struct net *net);
> > =20
> >  void		nfsd_put(struct net *net);
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
> > index 2154fa63c5f2..ef1eb8b1c5bf 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -1147,3 +1147,91 @@ int nfsd_pool_stats_release(struct inode *inode,=
 struct file *file)
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
>=20
> Much nicer without all of the heavyweight locking, I think!
>=20
> > +	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> > +		struct svc_rqst *rqstp;
> > +
> > +		seq_puts(m, "XID        | FLAGS      | PROG       |");
> > +		seq_puts(m, " VERS       | PROC\t| TS(us)\t   |");
> > +		seq_puts(m, " REMOTE - LOCAL IP ADDR");
> > +		seq_puts(m, "\t\t\t\t\t\t\t\t   | NFS4 COMPOUND OPS\n");
>=20
> It may be best to just eliminate the header, or at the very least, only
> print it once by moving it outside of the for loop.
>=20
> > +		list_for_each_entry_rcu(rqstp,
> > +				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> > +				rq_all) {
> > +			if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
> > +				continue;
> > +
> > +			seq_printf(m,
> > +				   "0x%08x | 0x%08lx | 0x%08x | NFSv%d      |"
> > +				   " %s\t| %016lld |",
>=20
> I'd definitely get rid of the '|' delimiters. I think that it'd be best
> to just separate the fields by single spaces, as that will be simpler
> for scripts to parse. There are plenty of examples in the kernel that do
> that (/proc/locks, /proc/self/mountstats, etc.).
>=20
> We can always write a simple shell or python script for nfs-utils that
> parses and pretty-prints the fields.

Hi Jeff,

based on your comments above, I wrote the following simple python parser:

#!/usr/bin/env python3

if __name__ =3D=3D '__main__':
    with open('/proc/fs/nfsd/rpc_status', 'r') as f:
        for l in f.readlines():
            e =3D l.split()

            if len(e) < 8:
                continue

            print('connection\t: ' + e[6] + ' -> ' + e[7])
            print('   xid\t\t: ' + e[0])
            print('   flags\t: ' + e[1])
            print('   program\t: ' + e[2])
            print('   version\t: ' + e[3])
            print('   proc\t\t: ' + e[4])
            print('   time (us)\t: ' + e[5])

            if len(e) > 8:
                print('   compound ops\t: ' + " ".join(e[8:]))


The output would be the following:

connection	: 192.168.122.1 -> 192.168.122.76
   xid		: 0x00000000
   flags	: 0x00000015
   program	: 0x000186a3
   version	: NFSv4
   proc		: COMPOUND
   time (us)	: 0000000449790533


Is it something similar to what you mean?

Regards,
Lorenzo

>=20
> > +				   be32_to_cpu(rqstp->rq_xid), rqstp->rq_flags,
> > +				   rqstp->rq_prog, rqstp->rq_vers,
> > +				   svc_proc_name(rqstp),
> > +				   ktime_to_us(rqstp->rq_stime));
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
>=20
> ...and if we're going to go for something machine-parseable, maybe just
> print this as "unknown:%hu". Also, I don't think you want the extra
> newline here.
>=20
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
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * nfsd_rpc_status_open - Atomically copy a write verifier
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
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--jcgeSkBQke8HJP20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZK0wEQAKCRA6cBh0uS2t
rF49AP9AuH1RtrFgdFDTNe0atEEjcQRGr0n7hkiQ+1Icg+CuKwD+NnB6ftaampnA
q5GQlE4bf1n9tcNLKpWIoE4PTiPI/Qw=
=4PHw
-----END PGP SIGNATURE-----

--jcgeSkBQke8HJP20--
