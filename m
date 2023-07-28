Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1069D767862
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jul 2023 00:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjG1WLl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jul 2023 18:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjG1WLl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jul 2023 18:11:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FD635A9
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 15:11:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8258218E3;
        Fri, 28 Jul 2023 22:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690582297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QX6ov/bZuTafb5i8DLcBVVjRWaNMQyzRFe6EEPoDPEk=;
        b=LvrRjyc0CVZrZLVvMnZNjGh3kEEUjTDbXekS/NVIs9kpNai3YA2GBMC7JOeIX/H0AXhQTt
        orEDcgZlc09OmgWNQdCZ0406coBSJEFXvah7O23kcvRnXX8beJ0/J6ukDt0YBkgr3Zbpci
        j+vYmQDaPGDK3wcjzjJ0uCkGWpfvLeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690582297;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QX6ov/bZuTafb5i8DLcBVVjRWaNMQyzRFe6EEPoDPEk=;
        b=dgORWv+jmIYwuPErOx3irbQU5QQlzLum46ChoRaiXnXAmezGESbPelivTMWZkN9e1FgiFg
        6Xf3wt84A3xMlkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D58A133F7;
        Fri, 28 Jul 2023 22:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ui58LBc9xGTnWwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 28 Jul 2023 22:11:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Lorenzo Bianconi" <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com, jlayton@kernel.org
Subject: Re: [PATCH v4 2/2] NFSD: add rpc_status entry in nfsd debug filesystem
In-reply-to: <ZMQVX5RlQaWt5wkn@tissot.1015granger.net>
References: <cover.1690569488.git.lorenzo@kernel.org>,
 <a23a0482a465299ac06d07d191e0c9377a11a4d1.1690569488.git.lorenzo@kernel.org>,
 <ZMQVX5RlQaWt5wkn@tissot.1015granger.net>
Date:   Sat, 29 Jul 2023 08:11:31 +1000
Message-id: <169058229140.32308.9984914710358617790@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 29 Jul 2023, Chuck Lever wrote:
> On Fri, Jul 28, 2023 at 08:44:04PM +0200, Lorenzo Bianconi wrote:
> > Introduce rpc_status entry in nfsd debug filesystem in order to dump
> > pending RPC requests debugging information.
> >=20
> > Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  fs/nfsd/nfs4proc.c         |   4 +-
> >  fs/nfsd/nfsctl.c           |  10 +++
> >  fs/nfsd/nfsd.h             |   2 +
> >  fs/nfsd/nfssvc.c           | 122 +++++++++++++++++++++++++++++++++++++
> >  include/linux/sunrpc/svc.h |   1 +
> >  net/sunrpc/svc.c           |   2 +-
> >  6 files changed, 137 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index f0f318e78630..b7ad3081bc36 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2497,8 +2497,6 @@ static inline void nfsd4_increment_op_stats(u32 opn=
um)
> > =20
> >  static const struct nfsd4_operation nfsd4_ops[];
> > =20
> > -static const char *nfsd4_op_name(unsigned opnum);
> > -
> >  /*
> >   * Enforce NFSv4.1 COMPOUND ordering rules:
> >   *
> > @@ -3628,7 +3626,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)
> >  	}
> >  }
> > =20
> > -static const char *nfsd4_op_name(unsigned opnum)
> > +const char *nfsd4_op_name(unsigned opnum)
> >  {
> >  	if (opnum < ARRAY_SIZE(nfsd4_ops))
> >  		return nfsd4_ops[opnum].op_name;
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 35d2e2cde1eb..f2e4f4b1e4d1 100644
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
> > @@ -1400,6 +1409,7 @@ static int nfsd_fill_super(struct super_block *sb, =
struct fs_context *fc)
> >  		[NFSD_RecoveryDir] =3D {"nfsv4recoverydir", &transaction_ops, S_IWUSR|=
S_IRUSR},
> >  		[NFSD_V4EndGrace] =3D {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRU=
GO},
> >  #endif
> > +		[NFSD_Rpc_Status] =3D {"rpc_status", &nfsd_rpc_status_operations, S_IR=
UGO},
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
> > @@ -506,6 +507,7 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_ne=
t *nn);
> > =20
> >  extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> > =20
> > +const char *nfsd4_op_name(unsigned opnum);
> >  #else /* CONFIG_NFSD_V4 */
> >  static inline int nfsd4_is_junction(struct dentry *dentry)
> >  {
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 97830e28c140..e9e954b5ae47 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -1057,6 +1057,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
> >  	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
> >  		goto out_decode_err;
> > =20
> > +	atomic_inc(&rqstp->rq_status_counter);
> > +
>=20
> Does this really have to be an atomic_t ? Seems like nfsd_dispatch
> is the only function updating it. You might need release semantics
> here and acquire semantics in nfsd_rpc_status_show(). I'd rather
> avoid a full-on atomic op in nfsd_dispatch() unless it's absolutely
> needed.
>=20
> Also, do you need to bump the rq_status_counter in the other RPC
> dispatch routines (lockd and nfs callback) too?
>=20
>=20
> >  	rp =3D NULL;
> >  	switch (nfsd_cache_lookup(rqstp, &rp)) {
> >  	case RC_DOIT:
> > @@ -1074,6 +1076,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
> >  	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
> >  		goto out_encode_err;
> > =20
> > +	atomic_inc(&rqstp->rq_status_counter);
> > +
> >  	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
> >  out_cached_reply:
> >  	return 1;
> > @@ -1149,3 +1153,121 @@ int nfsd_pool_stats_release(struct inode *inode, =
struct file *file)
> >  	mutex_unlock(&nfsd_mutex);
> >  	return ret;
> >  }
> > +
> > +static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> > +{
> > +	struct inode *inode =3D file_inode(m->file);
> > +	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_id=
);
> > +	int i;
> > +
> > +	rcu_read_lock();
> > +
> > +	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> > +		struct svc_rqst *rqstp;
> > +
> > +		list_for_each_entry_rcu(rqstp,
> > +				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> > +				rq_all) {
> > +			struct nfsd_rpc_status_info {
> > +				struct sockaddr daddr;
> > +				struct sockaddr saddr;
> > +				unsigned long rq_flags;
> > +				__be32 rq_xid;
> > +				u32 rq_prog;
> > +				u32 rq_vers;
> > +				const char *pc_name;
> > +				ktime_t rq_stime;
> > +				u32 opnum[NFSD_MAX_OPS_PER_COMPOUND]; /* NFSv4 compund */
> > +			} rqstp_info;
> > +			unsigned int status_counter;
> > +			char buf[RPC_MAX_ADDRBUFLEN];
> > +			int j, opcnt =3D 0;
> > +
> > +			if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
> > +				continue;
> > +
> > +			status_counter =3D atomic_read(&rqstp->rq_status_counter);
>=20
> Neil said:
>=20
> > I suggest you add add a counter to the rqstp which is incremented from
> > even to odd after parsing a request - including he v4 parsing needed to
> > have a sable ->opcnt - and then incremented from odd to even when the
> > request is complete.
> > Then this code samples the counter, skips the rqst if the counter is
> > even, and resamples the counter after collecting the data.  If it has
> > changed, the drop the record.
>=20
> I don't see a check if the status counter is even.

...and there does need to be one.  If the counter is even, then the
fields are meaningless and unstable.  The RQ_BUSY check is, I think,
meant to check if the fields are meaningful, but they aren't meaningful
until some time after RQ_BUSY is clear.

I would replace the "RQ_BUSY not set" test with "counter is even"

>=20
> Also, as above, I'm not sure atomic_read() is necessary here. Maybe
> just READ_ONCE() ? Neil, any thoughts?

Agree - we don't need an atomic as there is a single writer.
I think
  smp_store_release(rqstp->counter, rqstp->counter|1)
to increment it after parsing the request.  This makes it abundantly
clear the value will be odd, and ensures that if another thread sees the
'odd' value, then it can also see the results of the parse.

To increment after processing the request,
   smp_store_release(rqstp->counter, rqstp->counter + 1)

Then
  counter =3D smp_load_acquire(rqstp->counter);
  if ((counter & 1) =3D=3D 0)
to test if it is even before reading the state.  This ensure that if it
sees "odd' it will see the results of the parse.

and
  if ((smp_load_acquire(counter) =3D=3D counter)  continue;

before trusting that the data we read was consistent.

Note that we "release" *after* something and "acquire" *before"
something.
I think it helps to always think about what the access is "before" or
"after" when reasoning about barriers.
checkpatch will want a comment before these acquire and release
operation.  I recommend using the corresponding word "before" or "after"
in that comment.

NeilBrown
