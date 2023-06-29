Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB53E742FBF
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 23:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjF2VxE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 17:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjF2VxD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 17:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A381930C5
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 14:53:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FD1561636
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 21:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34229C433C8;
        Thu, 29 Jun 2023 21:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688075580;
        bh=xyS11HIec1IhNq9BVA/Pm4w4SgRBjzPDQ/q8OjIcm9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sGbvVm9XXbfjNFrSmxuwYqh9A60KxTzcLBGEuTSOSy2xg2SOwv5HT2UTcfX36DqNO
         rw2ecFygYmwWOIVa9WNmfEmtVhe4Ckum2pC6J9sjndBE40iUQlvd7Kagrf7u7w1cwR
         3g8B5N8QucrRP7b9JWWL2v1Ec+hflbiQ3GmOd7IcCP9wPAzlR0c2ZmxZuXWqs+GG1A
         WNChHGOsurq2HiY2JUfOX7rE4Ak2nNU/QgD6eu7PGRlI9xgDYD6iMBdJc+hlVEsRw+
         j6QbhTOUT3sOaKydovh4UbLa0h9rK8e/RYvny3hPdtV4O1sUQfaMOG3eWkchmqm1El
         +81odmCqeXFyA==
Date:   Thu, 29 Jun 2023 17:52:58 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: Re: [RFC] NFSD: add rpc_status entry in nfsd debug filesystem
Message-ID: <ZJ39OqQJZQw8vsXh@manet.1015granger.net>
References: <bac972c22c5acfa43969bb1bf164341b16ea045c.1688032742.git.lorenzo@kernel.org>
 <ZJ2NUPdX0KqvaUlr@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJ2NUPdX0KqvaUlr@manet.1015granger.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 29, 2023 at 09:55:28AM -0400, Chuck Lever wrote:
> On Thu, Jun 29, 2023 at 12:17:33PM +0200, Lorenzo Bianconi wrote:
> > Introduce rpc_status entry in nfsd debug filesystem in order to dump
> > pending RPC requests debugging information.
> > 
> > Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=366
> 
> Nice to see progress on this.
> 
> Do you have a user space tool to monitor this file?
> 
> 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  fs/nfsd/nfs4proc.c |  4 +--
> >  fs/nfsd/nfsctl.c   | 18 ++++++++++++++
> >  fs/nfsd/nfsd.h     |  2 ++
> >  fs/nfsd/nfssvc.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++++
> >  net/sunrpc/svc.c   |  2 +-
> >  5 files changed, 83 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 5ae670807449..a4dd1ef104c3 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2452,8 +2452,6 @@ static inline void nfsd4_increment_op_stats(u32 opnum)
> >  
> >  static const struct nfsd4_operation nfsd4_ops[];
> >  
> > -static const char *nfsd4_op_name(unsigned opnum);
> > -
> >  /*
> >   * Enforce NFSv4.1 COMPOUND ordering rules:
> >   *
> > @@ -3583,7 +3581,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)
> >  	}
> >  }
> >  
> > -static const char *nfsd4_op_name(unsigned opnum)
> > +const char *nfsd4_op_name(unsigned opnum)
> >  {
> >  	if (opnum < ARRAY_SIZE(nfsd4_ops))
> >  		return nfsd4_ops[opnum].op_name;
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 1489e0b703b4..9d0b0a53510b 100644
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
> >  
> > @@ -195,6 +197,21 @@ static inline struct net *netns(struct file *file)
> >  	return file_inode(file)->i_sb->s_fs_info;
> >  }
> >  
> > +static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> > +{
> > +	struct nfsd_net *nn = net_generic(file_inode(m->file)->i_sb->s_fs_info,
> > +					  nfsd_net_id);
> > +
> > +	mutex_lock(&nfsd_mutex);
> > +	if (nn->nfsd_serv)
> > +		nsfd_rpc_status(m, nn->nfsd_serv);
> > +	mutex_unlock(&nfsd_mutex);
> > +
> > +	return 0;
> > +}
> > +
> > +DEFINE_SHOW_ATTRIBUTE(nfsd_rpc_status);
> > +
> >  /*
> >   * write_unlock_ip - Release all locks used by a client
> >   *
> > @@ -1400,6 +1417,7 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
> >  		[NFSD_RecoveryDir] = {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_IRUSR},
> >  		[NFSD_V4EndGrace] = {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRUGO},
> >  #endif
> > +		[NFSD_Rpc_Status] = {"rpc_status", &nfsd_rpc_status_fops, S_IRUGO},
> >  		/* last one */ {""}
> >  	};
> >  
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index d88498f8b275..a149157ec243 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -87,6 +87,7 @@ bool		nfssvc_encode_voidres(struct svc_rqst *rqstp,
> >   */
> >  int		nfsd_svc(int nrservs, struct net *net, const struct cred *cred);
> >  int		nfsd_dispatch(struct svc_rqst *rqstp);
> > +void		nsfd_rpc_status(struct seq_file *m, struct svc_serv *serv);
> >  
> >  int		nfsd_nrthreads(struct net *);
> >  int		nfsd_nrpools(struct net *);
> > @@ -506,6 +507,7 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
> >  
> >  extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> >  
> > +const char *nfsd4_op_name(unsigned opnum);
> >  #else /* CONFIG_NFSD_V4 */
> >  static inline int nfsd4_is_junction(struct dentry *dentry)
> >  {
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 9c7b1ef5be40..7a881f9a3a13 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -1142,3 +1142,64 @@ int nfsd_pool_stats_release(struct inode *inode, struct file *file)
> >  	mutex_unlock(&nfsd_mutex);
> >  	return ret;
> >  }
> > +
> 
> Please add a kdoc comment here that describes the purpose of this
> function, its API contract, and any non-obvious assumptions.
> 
> 
> > +void nsfd_rpc_status(struct seq_file *m, struct svc_serv *serv)
> > +{
> > +	int i;
> > +
> > +	lockdep_assert_held(&nfsd_mutex);
> 
> The nfsd_mutex is held, I assume, to serialize with service
> shutdown. IMO you should add a comment to that effect.
> 
> > +
> > +	rcu_read_lock();
> 
> The RCU read lock protects the sp_all_threads list. OK.
> 
> > +
> > +	for (i = 0; i < serv->sv_nrpools; i++) {
> > +		struct svc_rqst *rqstp;
> > +
> > +		seq_puts(m, "XID        | FLAGS      | PROG       |");
> > +		seq_puts(m, " VERS       | PROC\t|");
> > +		seq_puts(m, " REMOTE - LOCAL IP ADDR");
> > +		seq_puts(m, "\t\t\t\t\t\t\t\t   | NFS4 COMPOUND OPS\n");
> > +		list_for_each_entry_rcu(rqstp,
> > +					&serv->sv_pools[i].sp_all_threads,
> > +					rq_all) {
> > +			if (!test_bit(RQ_BUSY, &rqstp->rq_flags))
> > +				continue;
> > +
> > +			seq_printf(m,
> > +				   "0x%08x | 0x%08lx | 0x%08x | NFSv%d      | %s\t|",
> > +				   be32_to_cpu(rqstp->rq_xid), rqstp->rq_flags,
> > +				   rqstp->rq_prog, rqstp->rq_vers,
> > +				   svc_proc_name(rqstp));

Had another thought on this. svc_rqst::rq_stime should be included here
because if both the XID and stime don't change between peeks into this
file, that's a sure sign that the transaction is not making progress.


> > +			if (rqstp->rq_addr.ss_family == AF_INET) {
> > +				seq_printf(m, " %pI4 - %pI4\t\t\t\t\t\t\t   |",
> > +					   &((struct sockaddr_in *)&rqstp->rq_addr)->sin_addr,
> > +					   &((struct sockaddr_in *)&rqstp->rq_daddr)->sin_addr);
> > +			} else if (rqstp->rq_addr.ss_family == AF_INET6) {
> > +				seq_printf(m, " %pI6 - %pI6 |",
> > +					   &((struct sockaddr_in6 *)&rqstp->rq_addr)->sin6_addr,
> > +					   &((struct sockaddr_in6 *)&rqstp->rq_daddr)->sin6_addr);
> > +			} else {
> > +				seq_printf(m, " Unknown address family: %hu\n",
> > +					   rqstp->rq_addr.ss_family);
> > +				continue;
> > +			}
> > +#ifdef CONFIG_NFSD_V4
> > +			if (rqstp->rq_vers == NFS4_VERSION &&
> > +			    rqstp->rq_proc == NFSPROC4_COMPOUND) {
> > +				/* NFSv4 compund */
> > +				struct nfsd4_compoundargs *args = rqstp->rq_argp;
> > +				struct nfsd4_compoundres *resp = rqstp->rq_resp;
> > +
> > +				while (resp->opcnt < args->opcnt) {
> > +					struct nfsd4_op *op = &args->ops[resp->opcnt++];
> > +
> > +					seq_printf(m, " %s", nfsd4_op_name(op->opnum));
> > +				}
> > +			}
> > +#endif /* CONFIG_NFSD_V4 */
> > +			seq_puts(m, "\n");
> 
> My only quibble here is that the file format needs to be parsable
> by scripts as well as readable by humans. I'm not sure I have a
> specific comment, but it's something that needs some attention and
> verification (with, say, a sample user space tool, hint hint).
> 
> 
> > +		}
> > +	}
> > +
> > +	rcu_read_unlock();
> > +}
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index e6d4cec61e47..f99cad92e9f4 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -1625,7 +1625,7 @@ const char *svc_proc_name(const struct svc_rqst *rqstp)
> >  		return rqstp->rq_procinfo->pc_name;
> >  	return "unknown";
> >  }
> > -
> > +EXPORT_SYMBOL_GPL(svc_proc_name);
> >  
> >  /**
> >   * svc_encode_result_payload - mark a range of bytes as a result payload
> > -- 
> > 2.41.0
> > 
