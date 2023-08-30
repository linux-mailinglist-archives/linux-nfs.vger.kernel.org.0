Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2837178D817
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 20:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjH3S3W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 14:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245478AbjH3PRn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 11:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A771AE8
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693408612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7hsIBPkyYHcqUeTnPITGjCg9BBLT2UjnH9yjjX+dCQ=;
        b=CPdd7IM0itn2535Z0wVoFuDp2mry0X2hxJZQFHHjCdzG5GuTtrbaOKFybwt+cuYWL3NlBi
        5pVOXaFLjrmXaiXnw5c32MYSYxgf4B5rH8lIwFmG+KNTU0vX3i5LIziHEktlf5t0RQib+M
        eLlsBFxMBNHkJKNiznU3MhWtLHZnYpo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-fnhewD4IO1SyB1USnl1GjA-1; Wed, 30 Aug 2023 11:16:50 -0400
X-MC-Unique: fnhewD4IO1SyB1USnl1GjA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31c470305cfso3427996f8f.3
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 08:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408609; x=1694013409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7hsIBPkyYHcqUeTnPITGjCg9BBLT2UjnH9yjjX+dCQ=;
        b=WY+smsDxoWJ72aQ7joyQJMRBgStn6LebtaqBiEkaJEckRvZYhEkVN5/B9S1UlB255T
         uwptcRSl3Z6dwvZCksJ6nkmeKE7ncc4sWdure3UHIiKV5uNUF/oqTMgSWdF+qvVHdKcf
         8ybLJ5FozFj+vRBKBE2jVOVKcvdjT/3zrhp8cWk+uwX0QM2m5sr00K0t1PcPQfHWsHAY
         s+yznh1hwX36NGwn+9ClyJblzYk06et/iqFibJm5Lcm3g5zdn3svWwdWI4mFqLLJ9GXQ
         ejOdrFhr0JiQ9+jDf2ZEzfYwYXb6kFTcUyUNfWi3lZho+CfSTA2P/cdw9Eud5WLcai9E
         cQ/w==
X-Gm-Message-State: AOJu0YxCPAbnUz5IbqcZayDxO3BOCo7jHarr7vRX1aLxV7z2rntJlXvG
        gIm97BRDzXDCBz8v9HJ6v8lyAMwQrR5oaJ9inRwcDyv39W3kN3UyIpMC6gRj7X5gTeiU7GNPYv5
        Qqvv5pANPZa4OZjRm+1dH
X-Received: by 2002:a5d:4e8e:0:b0:31a:e3ad:f30e with SMTP id e14-20020a5d4e8e000000b0031ae3adf30emr1811319wru.68.1693408609384;
        Wed, 30 Aug 2023 08:16:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHdjoYuasucpBLeu6XWHbhWwgnGpAgFG+ePsB8/NfbLi6XuHvZCmXqOSHxdB3lTatA0+icgw==
X-Received: by 2002:a5d:4e8e:0:b0:31a:e3ad:f30e with SMTP id e14-20020a5d4e8e000000b0031ae3adf30emr1811295wru.68.1693408608974;
        Wed, 30 Aug 2023 08:16:48 -0700 (PDT)
Received: from localhost (net-2-34-76-254.cust.vodafonedsl.it. [2.34.76.254])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d684f000000b003180027d67asm16900102wrw.19.2023.08.30.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:16:48 -0700 (PDT)
Date:   Wed, 30 Aug 2023 17:16:46 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        jlayton@kernel.org, neilb@suse.de
Subject: Re: [PATCH v7 3/3] NFSD: add rpc_status netlink support
Message-ID: <ZO9dXruY4GLq8wTS@lore-desk>
References: <cover.1693400242.git.lorenzo@kernel.org>
 <b750dd468dd3fe4af8febf3a0bf8bc278ca7c05e.1693400242.git.lorenzo@kernel.org>
 <ZO9M27f3+KGQ0/TJ@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QHp+ZtR/AUTlsaD4"
Content-Disposition: inline
In-Reply-To: <ZO9M27f3+KGQ0/TJ@tissot.1015granger.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--QHp+ZtR/AUTlsaD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Aug 30, 2023 at 03:05:46PM +0200, Lorenzo Bianconi wrote:
> > Introduce rpc_status netlink support for NFSD in order to dump pending
> > RPC requests debugging information from userspace.
>=20
> Very good to see this update!
>=20
> netdev has asked that all new netlink protocols start from a yaml
> spec that resides under Documentation/netlink/specs/  That spec is
> then used to generate netlink parser code for the kernel and for
> user space tooling. You can find this all described here:
>=20
> https://docs.kernel.org/next/userspace-api/netlink/specs.html
>=20
> and here is a weak example of how this might be done:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/net/=
handshake?id=3D3b3009ea8abb713b022d94fba95ec270cf6e7eae
>=20
> I say weak because I did that work while the yaml spec tools were
> still under development. It might not completely reflect how this
> needs to be done today.
>=20
> So the yaml file would be named something like:
>=20
> Documentation/netlink/specs/nfsd.yaml
>=20
> and it would generate files "fs/nfsd/netlink.[ch]". It should
> generate a lot of the parser boiler plate you've written below
> by hand, so just replace that code with calls to the generated
> code.

ack, I will look into it for v8

>=20
> When you post the next revision of the series, cc: netdev.

ack, will do.

Regards,
Lorenzo

>=20
>=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  fs/nfsd/nfsctl.c           | 275 +++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/nfsd.h             |  19 +++
> >  fs/nfsd/nfssvc.c           |  15 ++
> >  fs/nfsd/state.h            |   2 -
> >  include/linux/sunrpc/svc.h |   1 +
> >  include/uapi/linux/nfs.h   |  54 ++++++++
> >  6 files changed, 364 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 33f80d289d63..4626a0002ceb 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -17,6 +17,9 @@
> >  #include <linux/sunrpc/rpc_pipe_fs.h>
> >  #include <linux/module.h>
> >  #include <linux/fsnotify.h>
> > +#include <net/genetlink.h>
> > +#include <net/ip.h>
> > +#include <net/ipv6.h>
> > =20
> >  #include "idmap.h"
> >  #include "nfsd.h"
> > @@ -1495,6 +1498,273 @@ static int create_proc_exports_entry(void)
> > =20
> >  unsigned int nfsd_net_id;
> > =20
> > +/* the netlink family */
> > +static struct genl_family nfsd_genl;
> > +
> > +static const struct nla_policy
> > +nfsd_rpc_status_compound_policy[NFS_ATTR_RPC_STATUS_COMPOUND_MAX + 1] =
=3D {
> > +	[NFS_ATTR_RPC_STATUS_COMPOUND_OP] =3D { .type =3D NLA_STRING },
> > +};
> > +
> > +static const struct nla_policy
> > +nfsd_rpc_status_policy[NFS_ATTR_RPC_STATUS_MAX + 1] =3D {
> > +	[NFS_ATTR_RPC_STATUS_XID] =3D { .type =3D NLA_U32 },
> > +	[NFS_ATTR_RPC_STATUS_FLAGS] =3D { .type =3D NLA_U32 },
> > +	[NFS_ATTR_RPC_STATUS_PC_NAME] =3D { .type =3D NLA_STRING },
> > +	[NFS_ATTR_RPC_STATUS_VERSION] =3D { .type =3D NLA_U8 },
> > +	[NFS_ATTR_RPC_STATUS_STIME] =3D { .type =3D NLA_S64 },
> > +	[NFS_ATTR_RPC_STATUS_SADDR4] =3D { .len =3D sizeof_field(struct iphdr=
, saddr) },
> > +	[NFS_ATTR_RPC_STATUS_DADDR4] =3D { .len =3D sizeof_field(struct iphdr=
, daddr) },
> > +	[NFS_ATTR_RPC_STATUS_SADDR6] =3D { .len =3D sizeof_field(struct ipv6h=
dr, saddr) },
> > +	[NFS_ATTR_RPC_STATUS_DADDR6] =3D { .len =3D sizeof_field(struct ipv6h=
dr, daddr) },
> > +	[NFS_ATTR_RPC_STATUS_SPORT] =3D { .type =3D NLA_U16 },
> > +	[NFS_ATTR_RPC_STATUS_DPORT] =3D { .type =3D NLA_U16 },
> > +	[NFS_ATTR_RPC_STATUS_COMPOUND] =3D
> > +		NLA_POLICY_NESTED_ARRAY(nfsd_rpc_status_compound_policy),
> > +};
> > +
> > +static const struct nla_policy
> > +nfsd_genl_policy[NFS_ATTR_MAX + 1] =3D {
> > +	[NFS_ATTR_RPC_STATUS] =3D NLA_POLICY_NESTED_ARRAY(nfsd_rpc_status_pol=
icy),
> > +};
> > +
> > +static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb, int i=
ndex,
> > +					    struct nfsd_genl_rqstp *rqstp)
> > +{
> > +	struct nlattr *rq_attr, *comp_attr;
> > +	int i;
> > +
> > +	rq_attr =3D nla_nest_start(skb, index);
> > +	if (!rq_attr)
> > +		return -ENOBUFS;
> > +
> > +	if (nla_put_be32(skb, NFS_ATTR_RPC_STATUS_XID, rqstp->rq_xid) ||
> > +	    nla_put_u32(skb, NFS_ATTR_RPC_STATUS_FLAGS, rqstp->rq_flags) ||
> > +	    nla_put_string(skb, NFS_ATTR_RPC_STATUS_PC_NAME, rqstp->pc_name) =
||
> > +	    nla_put_u8(skb, NFS_ATTR_RPC_STATUS_VERSION, rqstp->rq_vers) ||
> > +	    nla_put_s64(skb, NFS_ATTR_RPC_STATUS_STIME,
> > +			ktime_to_us(rqstp->rq_stime), NFS_ATTR_RPC_STATUS_PAD))
> > +		return -ENOBUFS;
> > +
> > +	switch (rqstp->saddr.sa_family) {
> > +	case AF_INET: {
> > +		const struct sockaddr_in *s_in, *d_in;
> > +
> > +		s_in =3D (const struct sockaddr_in *)&rqstp->saddr;
> > +		d_in =3D (const struct sockaddr_in *)&rqstp->daddr;
> > +		if (nla_put_in_addr(skb, NFS_ATTR_RPC_STATUS_SADDR4,
> > +				    s_in->sin_addr.s_addr) ||
> > +		    nla_put_in_addr(skb, NFS_ATTR_RPC_STATUS_DADDR4,
> > +				    d_in->sin_addr.s_addr) ||
> > +		    nla_put_be16(skb, NFS_ATTR_RPC_STATUS_SPORT,
> > +				 s_in->sin_port) ||
> > +		    nla_put_be16(skb, NFS_ATTR_RPC_STATUS_DPORT,
> > +				 d_in->sin_port))
> > +			return -ENOBUFS;
> > +		break;
> > +	}
> > +	case AF_INET6: {
> > +		const struct sockaddr_in6 *s_in, *d_in;
> > +
> > +		s_in =3D (const struct sockaddr_in6 *)&rqstp->saddr;
> > +		d_in =3D (const struct sockaddr_in6 *)&rqstp->daddr;
> > +		if (nla_put_in6_addr(skb, NFS_ATTR_RPC_STATUS_SADDR6,
> > +				     &s_in->sin6_addr) ||
> > +		    nla_put_in6_addr(skb, NFS_ATTR_RPC_STATUS_DADDR6,
> > +				     &d_in->sin6_addr) ||
> > +		    nla_put_be16(skb, NFS_ATTR_RPC_STATUS_SPORT,
> > +				 s_in->sin6_port) ||
> > +		    nla_put_be16(skb, NFS_ATTR_RPC_STATUS_DPORT,
> > +				 d_in->sin6_port))
> > +			return -ENOBUFS;
> > +		break;
> > +	}
> > +	default:
> > +		break;
> > +	}
> > +
> > +	comp_attr =3D nla_nest_start(skb, NFS_ATTR_RPC_STATUS_COMPOUND);
> > +	if (!comp_attr)
> > +		return -ENOBUFS;
> > +
> > +	for (i =3D 0; i < rqstp->opcnt; i++) {
> > +		struct nlattr *op_attr;
> > +
> > +		op_attr =3D nla_nest_start(skb, i);
> > +		if (!op_attr)
> > +			return -ENOBUFS;
> > +
> > +		if (nla_put_string(skb, NFS_ATTR_RPC_STATUS_COMPOUND_OP,
> > +				   nfsd4_op_name(rqstp->opnum[i])))
> > +			return -ENOBUFS;
> > +
> > +		nla_nest_end(skb, op_attr);
> > +	}
> > +
> > +	nla_nest_end(skb, comp_attr);
> > +	nla_nest_end(skb, rq_attr);
> > +
> > +	return 0;
> > +}
> > +
> > +static int nfsd_genl_get_rpc_status(struct sk_buff *skb, struct genl_i=
nfo *info)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> > +	struct nlattr *rpc_attr;
> > +	int i, rqstp_index =3D 0;
> > +	struct sk_buff *msg;
> > +	void *hdr;
> > +
> > +	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > +	if (!msg)
> > +		return -ENOMEM;
> > +
> > +	hdr =3D genlmsg_put(msg, info->snd_portid, info->snd_seq, &nfsd_genl,
> > +			  0, NFS_CMD_NEW_RPC_STATUS);
> > +	if (!hdr) {
> > +		nlmsg_free(msg);
> > +		return -ENOBUFS;
> > +	}
> > +
> > +	rpc_attr =3D nla_nest_start(msg, NFS_ATTR_RPC_STATUS);
> > +	if (!rpc_attr)
> > +		goto nla_put_failure;
> > +
> > +	rcu_read_lock();
> > +
> > +	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> > +		struct svc_rqst *rqstp;
> > +
> > +		list_for_each_entry_rcu(rqstp,
> > +				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> > +				rq_all) {
> > +			struct nfsd_genl_rqstp genl_rqstp;
> > +			unsigned int status_counter;
> > +
> > +			/*
> > +			 * Acquire rq_status_counter before parsing the rqst
> > +			 * fields. rq_status_counter is set to an odd value in
> > +			 * order to notify the consumers the rqstp fields are
> > +			 * meaningful.
> > +			 */
> > +			status_counter =3D
> > +				smp_load_acquire(&rqstp->rq_status_counter);
> > +			if (!(status_counter & 1))
> > +				continue;
> > +
> > +			genl_rqstp.rq_xid =3D rqstp->rq_xid;
> > +			genl_rqstp.rq_flags =3D rqstp->rq_flags;
> > +			genl_rqstp.rq_vers =3D rqstp->rq_vers;
> > +			genl_rqstp.pc_name =3D svc_proc_name(rqstp);
> > +			genl_rqstp.rq_stime =3D rqstp->rq_stime;
> > +			genl_rqstp.opcnt =3D 0;
> > +			memcpy(&genl_rqstp.daddr, svc_daddr(rqstp),
> > +			       sizeof(struct sockaddr));
> > +			memcpy(&genl_rqstp.saddr, svc_addr(rqstp),
> > +			       sizeof(struct sockaddr));
> > +
> > +#ifdef CONFIG_NFSD_V4
> > +			if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
> > +			    rqstp->rq_proc =3D=3D NFSPROC4_COMPOUND) {
> > +				/* NFSv4 compund */
> > +				struct nfsd4_compoundargs *args;
> > +				int j;
> > +
> > +				args =3D rqstp->rq_argp;
> > +				genl_rqstp.opcnt =3D args->opcnt;
> > +				for (j =3D 0; j < genl_rqstp.opcnt; j++)
> > +					genl_rqstp.opnum[j] =3D
> > +						args->ops[j].opnum;
> > +			}
> > +#endif /* CONFIG_NFSD_V4 */
> > +
> > +			/*
> > +			 * Acquire rq_status_counter before reporting the rqst
> > +			 * fields to the user.
> > +			 */
> > +			if (smp_load_acquire(&rqstp->rq_status_counter) !=3D
> > +			    status_counter)
> > +				continue;
> > +
> > +			if (nfsd_genl_rpc_status_compose_msg(msg,
> > +							     rqstp_index++,
> > +							     &genl_rqstp))
> > +				goto nla_put_failure_rcu;
> > +		}
> > +	}
> > +
> > +	rcu_read_unlock();
> > +
> > +	nla_nest_end(msg, rpc_attr);
> > +	genlmsg_end(msg, hdr);
> > +
> > +	return genlmsg_reply(msg, info);
> > +
> > +nla_put_failure_rcu:
> > +	rcu_read_unlock();
> > +nla_put_failure:
> > +	genlmsg_cancel(msg, hdr);
> > +	nlmsg_free(msg);
> > +
> > +	return -EMSGSIZE;
> > +}
> > +
> > +static int nfsd_genl_pre_doit(const struct genl_split_ops *ops,
> > +			      struct sk_buff *skb, struct genl_info *info)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> > +
> > +	if (ops->internal_flags & NFSD_FLAG_NEED_REF_COUNT) {
> > +		int ret =3D -ENODEV;
> > +
> > +		mutex_lock(&nfsd_mutex);
> > +		if (nn->nfsd_serv) {
> > +			svc_get(nn->nfsd_serv);
> > +			ret =3D 0;
> > +		}
> > +		mutex_unlock(&nfsd_mutex);
> > +
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void nfsd_genl_post_doit(const struct genl_split_ops *ops,
> > +				struct sk_buff *skb, struct genl_info *info)
> > +{
> > +	if (ops->internal_flags & NFSD_FLAG_NEED_REF_COUNT) {
> > +		mutex_lock(&nfsd_mutex);
> > +		nfsd_put(genl_info_net(info));
> > +		mutex_unlock(&nfsd_mutex);
> > +	}
> > +}
> > +
> > +static struct genl_small_ops nfsd_genl_ops[] =3D {
> > +	{
> > +		.cmd =3D NFS_CMD_GET_RPC_STATUS,
> > +		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> > +		.doit =3D nfsd_genl_get_rpc_status,
> > +		.internal_flags =3D NFSD_FLAG_NEED_REF_COUNT,
> > +	},
> > +};
> > +
> > +static struct genl_family nfsd_genl __ro_after_init =3D {
> > +	.name =3D "nfsd_server",
> > +	.version =3D 1,
> > +	.maxattr =3D NFS_ATTR_MAX,
> > +	.module =3D THIS_MODULE,
> > +	.netnsok =3D true,
> > +	.parallel_ops =3D true,
> > +	.hdrsize =3D 0,
> > +	.pre_doit =3D nfsd_genl_pre_doit,
> > +	.post_doit =3D nfsd_genl_post_doit,
> > +	.policy =3D nfsd_genl_policy,
> > +	.small_ops =3D nfsd_genl_ops,
> > +	.n_small_ops =3D ARRAY_SIZE(nfsd_genl_ops),
> > +	.resv_start_op =3D NFS_CMD_NEW_RPC_STATUS + 1,
> > +};
> > +
> >  /**
> >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
> >   * @net: a freshly-created network namespace
> > @@ -1589,6 +1859,10 @@ static int __init init_nfsd(void)
> >  	retval =3D register_filesystem(&nfsd_fs_type);
> >  	if (retval)
> >  		goto out_free_all;
> > +	retval =3D genl_register_family(&nfsd_genl);
> > +	if (retval)
> > +		goto out_free_all;
> > +
> >  	return 0;
> >  out_free_all:
> >  	nfsd4_destroy_laundry_wq();
> > @@ -1613,6 +1887,7 @@ static int __init init_nfsd(void)
> > =20
> >  static void __exit exit_nfsd(void)
> >  {
> > +	genl_unregister_family(&nfsd_genl);
> >  	unregister_filesystem(&nfsd_fs_type);
> >  	nfsd4_destroy_laundry_wq();
> >  	unregister_cld_notifier();
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index e95c3322eb9b..749c871b3291 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -62,6 +62,25 @@ struct readdir_cd {
> >  	__be32			err;	/* 0, nfserr, or nfserr_eof */
> >  };
> > =20
> > +enum nfsd_genl_internal_flag {
> > +	NFSD_FLAG_NEED_REF_COUNT =3D BIT(0),
> > +};
> > +
> > +/* Maximum number of operations per session compound */
> > +#define NFSD_MAX_OPS_PER_COMPOUND	50
> > +
> > +struct nfsd_genl_rqstp {
> > +	struct sockaddr daddr;
> > +	struct sockaddr saddr;
> > +	unsigned long rq_flags;
> > +	const char *pc_name;
> > +	ktime_t rq_stime;
> > +	__be32 rq_xid;
> > +	u32 rq_vers;
> > +	/* NFSv4 compund */
> > +	u32 opnum[NFSD_MAX_OPS_PER_COMPOUND];
> > +	u16 opcnt;
> > +};
> > =20
> >  extern struct svc_program	nfsd_program;
> >  extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_ver=
sion4;
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 1582af33e204..fad34a7325b3 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -998,6 +998,15 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
> >  	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
> >  		goto out_decode_err;
> > =20
> > +	/*
> > +	 * Release rq_status_counter setting it to an odd value after the rpc
> > +	 * request has been properly parsed. rq_status_counter is used to
> > +	 * notify the consumers if the rqstp fields are stable
> > +	 * (rq_status_counter is odd) or not meaningful (rq_status_counter
> > +	 * is even).
> > +	 */
> > +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter=
 | 1);
> > +
> >  	rp =3D NULL;
> >  	switch (nfsd_cache_lookup(rqstp, &rp)) {
> >  	case RC_DOIT:
> > @@ -1015,6 +1024,12 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
> >  	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
> >  		goto out_encode_err;
> > =20
> > +	/*
> > +	 * Release rq_status_counter setting it to an even value after the rpc
> > +	 * request has been properly processed.
> > +	 */
> > +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter=
 + 1);
> > +
> >  	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
> >  out_cached_reply:
> >  	return 1;
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index cbddcf484dba..41bdc913fa71 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -174,8 +174,6 @@ static inline struct nfs4_delegation *delegstateid(=
struct nfs4_stid *s)
> > =20
> >  /* Maximum number of slots per session. 160 is useful for long haul TC=
P */
> >  #define NFSD_MAX_SLOTS_PER_SESSION     160
> > -/* Maximum number of operations per session compound */
> > -#define NFSD_MAX_OPS_PER_COMPOUND	50
> >  /* Maximum  session per slot cache size */
> >  #define NFSD_SLOT_CACHE_SIZE		2048
> >  /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index dbf5b21feafe..caa20defd255 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -251,6 +251,7 @@ struct svc_rqst {
> >  						 * net namespace
> >  						 */
> >  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> > +	unsigned int		rq_status_counter; /* RPC processing counter */
> >  };
> > =20
> >  /* bits for rq_flags */
> > diff --git a/include/uapi/linux/nfs.h b/include/uapi/linux/nfs.h
> > index 946cb62d64b0..86a5daaaf9d9 100644
> > --- a/include/uapi/linux/nfs.h
> > +++ b/include/uapi/linux/nfs.h
> > @@ -132,4 +132,58 @@ enum nfs_ftype {
> >  	NFFIFO =3D 8
> >  };
> > =20
> > +enum nfs_commands {
> > +	NFS_CMD_UNSPEC,
> > +
> > +	NFS_CMD_GET_RPC_STATUS,
> > +	NFS_CMD_NEW_RPC_STATUS,
> > +
> > +	/* add new commands above here */
> > +
> > +	__NFS_CMD_MAX,
> > +	NFS_CMD_MAX =3D __NFS_CMD_MAX - 1,
> > +};
> > +
> > +enum nfs_rcp_status_compound_attrs {
> > +	__NFS_ATTR_RPC_STATUS_COMPOUND_UNSPEC,
> > +	NFS_ATTR_RPC_STATUS_COMPOUND_OP,
> > +
> > +	/* keep it last */
> > +	NUM_NFS_ATTR_RPC_STATUS_COMPOUND,
> > +	NFS_ATTR_RPC_STATUS_COMPOUND_MAX =3D NUM_NFS_ATTR_RPC_STATUS_COMPOUND=
 - 1,
> > +};
> > +
> > +enum nfs_rpc_status_attrs {
> > +	__NFS_ATTR_RPC_STATUS_UNSPEC,
> > +
> > +	NFS_ATTR_RPC_STATUS_XID,
> > +	NFS_ATTR_RPC_STATUS_FLAGS,
> > +	NFS_ATTR_RPC_STATUS_PC_NAME,
> > +	NFS_ATTR_RPC_STATUS_VERSION,
> > +	NFS_ATTR_RPC_STATUS_STIME,
> > +	NFS_ATTR_RPC_STATUS_SADDR4,
> > +	NFS_ATTR_RPC_STATUS_DADDR4,
> > +	NFS_ATTR_RPC_STATUS_SADDR6,
> > +	NFS_ATTR_RPC_STATUS_DADDR6,
> > +	NFS_ATTR_RPC_STATUS_SPORT,
> > +	NFS_ATTR_RPC_STATUS_DPORT,
> > +	NFS_ATTR_RPC_STATUS_PAD,
> > +	NFS_ATTR_RPC_STATUS_COMPOUND,
> > +
> > +	/* keep it last */
> > +	NUM_NFS_ATTR_RPC_STATUS,
> > +	NFS_ATTR_RPC_STATUS_MAX =3D NUM_NFS_ATTR_RPC_STATUS - 1,
> > +};
> > +
> > +enum nfs_attrs {
> > +	NFS_ATTR_UNSPEC,
> > +
> > +	NFS_ATTR_RPC_STATUS,
> > +
> > +	/* add new attributes above here */
> > +
> > +	__NFS_ATTR_MAX,
> > +	NFS_ATTR_MAX =3D __NFS_ATTR_MAX - 1
> > +};
> > +
> >  #endif /* _UAPI_LINUX_NFS_H */
> > --=20
> > 2.41.0
> >=20
>=20
> --=20
> Chuck Lever
>=20

--QHp+ZtR/AUTlsaD4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZO9dXgAKCRA6cBh0uS2t
rBU3APwPvKY2Z6xY9PUAVMgzUq/8lXc4vfIcozT0DCHmBiWqNwEAnxYaP+naBqZT
aKOxXUIPpm8GivZd4Z2zzmijk5xhzgo=
=Rmot
-----END PGP SIGNATURE-----

--QHp+ZtR/AUTlsaD4--

