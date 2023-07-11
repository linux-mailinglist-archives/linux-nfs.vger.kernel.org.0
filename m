Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E597F74EC24
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 13:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGKLAw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jul 2023 07:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjGKLAv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jul 2023 07:00:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4149B
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 04:00:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3350C61477
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 11:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3315BC433C7;
        Tue, 11 Jul 2023 11:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689073246;
        bh=1Do99TDPIGsMSwgTo4HN6F+5We0z33yznFX4fJjABCM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o9CeUvgUQ98DdbYUT+HulR2lh4MztZ9qtiDu5mNtfnBXL16XSGU5/JXjRw1tgX3nc
         tR7Cq8Ueo91XrFDUSFFWrvBIiqugy2HqETQwsXUQ61u1uk8cyxm/rLKFnZ+kClmC1u
         lzCTiuZKLax+aGuQAFTyHZGM0GhgFK9M8JnOkAKPKc1IteVwWGuwBXwmm1Ew6MnqVo
         F3I2RT3Pioc+bC6jqEDtLA8Ay8HqfKo/7BELkQcpzA8VZUZoKDQQ/q4qtyNwWlPn/E
         HZ4PtKXbHt6AnXg+Aw7LJVTtAkPdw3/j+tr+K6WYQIRY4QiWevWa011RrX9yAkECZx
         EfQ+AlzRRiyMA==
Message-ID: <592848bfbf755da0b04f00f4045b2079977730ff.camel@kernel.org>
Subject: Re: [PATCH] NFSD: add rpc_status entry in nfsd debug filesystem
From:   Jeff Layton <jlayton@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        chuck.lever@oracle.com
Date:   Tue, 11 Jul 2023 07:00:44 -0400
In-Reply-To: <ZK0wEZytW0TGfflW@lore-desk>
References: <9495cf3f3674351579b5fd13d5ccacd7a6336088.1689005402.git.lorenzo@kernel.org>
         <1034ac186c7df01611052e743fded11d6a4fc179.camel@kernel.org>
         <ZK0wEZytW0TGfflW@lore-desk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-07-11 at 12:33 +0200, Lorenzo Bianconi wrote:
> > On Mon, 2023-07-10 at 18:16 +0200, Lorenzo Bianconi wrote:
> > > Introduce rpc_status entry in nfsd debug filesystem in order to dump
> > > pending RPC requests debugging information.
> > >=20
> > > Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > > Changes since RFCv1:
> > > - riduce time holding nfsd_mutex bumping svc_serv refcoung in
> > > =A0=A0nfsd_rpc_status_open()
> > > - dump rqstp->rq_stime
> > > - add missing kdoc for nfsd_rpc_status_open()
> > > ---
> > > =A0fs/nfsd/nfs4proc.c |  4 +--
> > > =A0fs/nfsd/nfsctl.c   | 10 ++++++
> > > =A0fs/nfsd/nfsd.h     |  2 ++
> > > =A0fs/nfsd/nfssvc.c   | 88 ++++++++++++++++++++++++++++++++++++++++++=
++++
> > > =A0net/sunrpc/svc.c   |  2 +-
> > > =A05 files changed, 102 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index 5ae670807449..a4dd1ef104c3 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -2452,8 +2452,6 @@ static inline void nfsd4_increment_op_stats(u32=
 opnum)
> > > =A0
> > >=20
> > > =A0static const struct nfsd4_operation nfsd4_ops[];
> > > =A0
> > >=20
> > > -static const char *nfsd4_op_name(unsigned opnum);
> > > -
> > > =A0/*
> > > =A0=A0* Enforce NFSv4.1 COMPOUND ordering rules:
> > > =A0=A0*
> > > @@ -3583,7 +3581,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *=
op)
> > > =A0	}
> > > =A0}
> > > =A0
> > >=20
> > > -static const char *nfsd4_op_name(unsigned opnum)
> > > +const char *nfsd4_op_name(unsigned opnum)
> > > =A0{
> > > =A0	if (opnum < ARRAY_SIZE(nfsd4_ops))
> > > =A0		return nfsd4_ops[opnum].op_name;
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 1b8b1aab9a15..629b4296e7c6 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -57,6 +57,8 @@ enum {
> > > =A0	NFSD_RecoveryDir,
> > > =A0	NFSD_V4EndGrace,
> > > =A0#endif
> > > +	NFSD_Rpc_Status,
> > > +
> > > =A0	NFSD_MaxReserved
> > > =A0};
> > > =A0
> > >=20
> > > @@ -195,6 +197,13 @@ static inline struct net *netns(struct file *fil=
e)
> > > =A0	return file_inode(file)->i_sb->s_fs_info;
> > > =A0}
> > > =A0
> > >=20
> > > +static const struct file_operations nfsd_rpc_status_operations =3D {
> > > +	.open		=3D nfsd_rpc_status_open,
> > > +	.read		=3D seq_read,
> > > +	.llseek		=3D seq_lseek,
> > > +	.release	=3D nfsd_pool_stats_release,
> > > +};
> > > +
> > > =A0/*
> > > =A0=A0* write_unlock_ip - Release all locks used by a client
> > > =A0=A0*
> > > @@ -1400,6 +1409,7 @@ static int nfsd_fill_super(struct super_block *=
sb, struct fs_context *fc)
> > > =A0		[NFSD_RecoveryDir] =3D {"nfsv4recoverydir", &transaction_ops, S_=
IWUSR|S_IRUSR},
> > > =A0		[NFSD_V4EndGrace] =3D {"v4_end_grace", &transaction_ops, S_IWUSR=
|S_IRUGO},
> > > =A0#endif
> > > +		[NFSD_Rpc_Status] =3D {"rpc_status", &nfsd_rpc_status_operations, =
S_IRUGO},
> > > =A0		/* last one */ {""}
> > > =A0	};
> > > =A0
> > >=20
> > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > index d88498f8b275..75a3e1d55bc8 100644
> > > --- a/fs/nfsd/nfsd.h
> > > +++ b/fs/nfsd/nfsd.h
> > > @@ -94,6 +94,7 @@ int		nfsd_get_nrthreads(int n, int *, struct net *)=
;
> > > =A0int		nfsd_set_nrthreads(int n, int *, struct net *);
> > > =A0int		nfsd_pool_stats_open(struct inode *, struct file *);
> > > =A0int		nfsd_pool_stats_release(struct inode *, struct file *);
> > > +int		nfsd_rpc_status_open(struct inode *inode, struct file *file);
> > > =A0void		nfsd_shutdown_threads(struct net *net);
> > > =A0
> > >=20
> > > =A0void		nfsd_put(struct net *net);
> > > @@ -506,6 +507,7 @@ extern void nfsd4_ssc_init_umount_work(struct nfs=
d_net *nn);
> > > =A0
> > >=20
> > > =A0extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> > > =A0
> > >=20
> > > +const char *nfsd4_op_name(unsigned opnum);
> > > =A0#else /* CONFIG_NFSD_V4 */
> > > =A0static inline int nfsd4_is_junction(struct dentry *dentry)
> > > =A0{
> > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > index 2154fa63c5f2..ef1eb8b1c5bf 100644
> > > --- a/fs/nfsd/nfssvc.c
> > > +++ b/fs/nfsd/nfssvc.c
> > > @@ -1147,3 +1147,91 @@ int nfsd_pool_stats_release(struct inode *inod=
e, struct file *file)
> > > =A0	mutex_unlock(&nfsd_mutex);
> > > =A0	return ret;
> > > =A0}
> > > +
> > > +static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> > > +{
> > > +	struct inode *inode =3D file_inode(m->file);
> > > +	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_ne=
t_id);
> > > +	int i;
> > > +
> > > +	rcu_read_lock();
> > > +
> >=20
> > Much nicer without all of the heavyweight locking, I think!
> >=20
> > > +	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> > > +		struct svc_rqst *rqstp;
> > > +
> > > +		seq_puts(m, "XID        | FLAGS      | PROG       |");
> > > +		seq_puts(m, " VERS       | PROC\t| TS(us)\t   |");
> > > +		seq_puts(m, " REMOTE - LOCAL IP ADDR");
> > > +		seq_puts(m, "\t\t\t\t\t\t\t\t   | NFS4 COMPOUND OPS\n");
> >=20
> > It may be best to just eliminate the header, or at the very least, only
> > print it once by moving it outside of the for loop.
> >=20
> > > +		list_for_each_entry_rcu(rqstp,
> > > +				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> > > +				rq_all) {
> > > +			if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
> > > +				continue;
> > > +
> > > +			seq_printf(m,
> > > +				   "0x%08x | 0x%08lx | 0x%08x | NFSv%d      |"
> > > +				   " %s\t| %016lld |",
> >=20
> > I'd definitely get rid of the '|' delimiters. I think that it'd be best
> > to just separate the fields by single spaces, as that will be simpler
> > for scripts to parse. There are plenty of examples in the kernel that d=
o
> > that (/proc/locks, /proc/self/mountstats, etc.).
> >=20
> > We can always write a simple shell or python script for nfs-utils that
> > parses and pretty-prints the fields.
>=20
> Hi Jeff,
>=20
> based on your comments above, I wrote the following simple python parser:
>=20
> #!/usr/bin/env python3
>=20
> if __name__ =3D=3D '__main__':
> =A0=A0=A0=A0with open('/proc/fs/nfsd/rpc_status', 'r') as f:
> =A0=A0=A0=A0=A0=A0=A0=A0for l in f.readlines():
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0e =3D l.split()
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if len(e) < 8:
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0continue
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0print('connection\t: ' + e[6] + ' -> =
' + e[7])
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0print('   xid\t\t: ' + e[0])
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0print('   flags\t: ' + e[1])
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0print('   program\t: ' + e[2])
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0print('   version\t: ' + e[3])
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0print('   proc\t\t: ' + e[4])
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0print('   time (us)\t: ' + e[5])
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if len(e) > 8:
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0print('   compound ops\t:=
 ' + " ".join(e[8:]))
>=20
>=20
> The output would be the following:
>=20
> connection	: 192.168.122.1 -> 192.168.122.76
> =A0=A0=A0xid		: 0x00000000
> =A0=A0=A0flags	: 0x00000015
> =A0=A0=A0program	: 0x000186a3
> =A0=A0=A0version	: NFSv4
> =A0=A0=A0proc		: COMPOUND
> =A0=A0=A0time (us)	: 0000000449790533
>=20
>=20
> Is it something similar to what you mean?
>=20
> Regards,
> Lorenzo
>=20
>=20

Yeah, something like that would be fine. Probably you'd want to spin
this up as a patch that adds this to the nfs-utils project. Most
userland nfs-related utilities are part of that package.
--=20
Jeff Layton <jlayton@kernel.org>
