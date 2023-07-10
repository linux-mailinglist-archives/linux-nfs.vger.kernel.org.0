Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2174DBE6
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 19:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjGJRGo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 13:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGJRGn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 13:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B62C0
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 10:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1336061127
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 17:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1A0C433C7;
        Mon, 10 Jul 2023 17:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689008801;
        bh=ux94v9ls5sWM8u6LUwAuZZckBelZWZsflyDU89J9TZc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sxHTVmgBTK0SSgS/GPeLioBZ/nMuegjIfddOKOW/i1fYt416W53sgHb4qVI62ei1v
         uJbz1YypYf2wrBwn0d8Yw/LNMnOwYqskyIr/+XyxtNoIy4c6FAtzlNEoQjIpLZeCBW
         r0awphbV+dHQHqLaebcohPQn7DG4bni6/cPqypHR3qiO05tA9wEvQ/dubMFie51VpF
         RkAkocVw1gCyyoLO/1tat8LvFtCj5ZSidQJZOllJvQdo9KltMZ8/Ep3h1jnMI+PHIi
         6rtizCnUT6Rfw3FQsOiwZRCTfAd409U0Ev7t6KPJvRy6jiFbPzxX4d6N96tdMQJe29
         5bN/7zCtmjdWw==
Message-ID: <a83049f5185b75dc5dfbf6e0b199b4b9f65ef3d9.camel@kernel.org>
Subject: Re: [PATCH] NFSD: add rpc_status entry in nfsd debug filesystem
From:   Jeff Layton <jlayton@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com
Date:   Mon, 10 Jul 2023 13:06:39 -0400
In-Reply-To: <1034ac186c7df01611052e743fded11d6a4fc179.camel@kernel.org>
References: <9495cf3f3674351579b5fd13d5ccacd7a6336088.1689005402.git.lorenzo@kernel.org>
         <1034ac186c7df01611052e743fded11d6a4fc179.camel@kernel.org>
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

On Mon, 2023-07-10 at 12:56 -0400, Jeff Layton wrote:
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
> > @@ -3583,7 +3581,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op=
)
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
>=20

Yeah, in fact if you want to print a header, this is still not the right
thing to do. Check out svc_pool_stats_show, which shows a header. For
that you need to test for and emit it iff v =3D=3D SEQ_START_TOKEN.

--=20
Jeff Layton <jlayton@kernel.org>
