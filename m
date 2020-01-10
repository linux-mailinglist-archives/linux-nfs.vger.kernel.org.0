Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F14891379CC
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 23:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgAJWle (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 17:41:34 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46272 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgAJWle (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jan 2020 17:41:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00AMc8Dt066837;
        Fri, 10 Jan 2020 22:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=6mjsn2IsZ7KxhmyGJzhUtGC5i1SK/hanT6H6jSBoQQg=;
 b=MjoeQYtMj6+/RSiyTLwGg0Vk7mRfcmyjMiDA8018eOT1ekb/SIXr59a63tnr7+x1O+O6
 2n6yVr8V3AxjNzXRATAxpixhiJhg02W/+gkm/INCzz9OZ+HQvuyr1djtC+BC1nUEWz+y
 07IonXe+43lrmb/N1sClfGtJOF1bRlPq6GAgyTPx0kFr/PbnK5BB/fddce1dRl6oWcWx
 jmkvMdRSrmZvcoWnvbzOI1wSD8Vnsq9j93iIBDHq7hTTder36MW0je2Qb1BBRjA6EKVh
 1LfxSzSAdUTEVTvt8y09JqM3KieqRs23VVFuVZ3YOckFcLKYtNjzWXsuovugQOp1MHhU Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xajnqmyr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 22:41:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00AMcsOx055738;
        Fri, 10 Jan 2020 22:41:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xedj01jkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 22:41:29 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00AMfQ70023604;
        Fri, 10 Jan 2020 22:41:28 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Jan 2020 14:41:25 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 7/7] NFS: Add a mount option for READ_PLUS
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200110223455.528471-8-Anna.Schumaker@Netapp.com>
Date:   Fri, 10 Jan 2020 17:41:24 -0500
Cc:     Trond.Myklebust@hammerspace.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <41391995-F61E-4CA4-80C5-542A8B2A3947@oracle.com>
References: <20200110223455.528471-1-Anna.Schumaker@Netapp.com>
 <20200110223455.528471-8-Anna.Schumaker@Netapp.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9496 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001100188
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9496 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001100188
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

> On Jan 10, 2020, at 5:34 PM, schumaker.anna@gmail.com wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> There are some workloads where READ_PLUS might end up hurting
> performance,

Can you say more about this? Have you seen workloads that are
hurt by READ_PLUS? Nothing jumps out at me from the tables in
the cover letter.


> so let's be nice to users and provide a way to disable this
> operation similar to how READDIR_PLUS can be disabled.

Does it make sense to hold off on a mount option until there
is evidence that there is no other way to work around such a
performance regression?

- Attempt to address the regression directly
- Improve the heuristics about when READ_PLUS is used
- Document that dropping back to vers=3D4.1 will disable it

Any experience with NFS/RDMA?


> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
> fs/nfs/fs_context.c       | 14 ++++++++++++++
> fs/nfs/nfs4client.c       |  3 +++
> include/linux/nfs_fs_sb.h |  1 +
> 3 files changed, 18 insertions(+)
>=20
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 0247dcb7b316..82ba07c7c1ce 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -64,6 +64,7 @@ enum nfs_param {
> 	Opt_proto,
> 	Opt_rdirplus,
> 	Opt_rdma,
> +	Opt_readplus,
> 	Opt_resvport,
> 	Opt_retrans,
> 	Opt_retry,
> @@ -120,6 +121,7 @@ static const struct fs_parameter_spec =
nfs_param_specs[] =3D {
> 	fsparam_string("proto",		Opt_proto),
> 	fsparam_flag_no("rdirplus",	Opt_rdirplus),
> 	fsparam_flag  ("rdma",		Opt_rdma),
> +	fsparam_flag_no("readplus",	Opt_readplus),
> 	fsparam_flag_no("resvport",	Opt_resvport),
> 	fsparam_u32   ("retrans",	Opt_retrans),
> 	fsparam_string("retry",		Opt_retry),
> @@ -555,6 +557,12 @@ static int nfs_fs_context_parse_param(struct =
fs_context *fc,
> 		else
> 			ctx->options |=3D NFS_OPTION_MIGRATION;
> 		break;
> +	case Opt_readplus:
> +		if (result.negated)
> +			ctx->options |=3D NFS_OPTION_NO_READ_PLUS;
> +		else
> +			ctx->options &=3D ~NFS_OPTION_NO_READ_PLUS;
> +		break;
>=20
> 		/*
> 		 * options that take numeric values
> @@ -1176,6 +1184,10 @@ static int nfs_fs_context_validate(struct =
fs_context *fc)
> 	    (ctx->version !=3D 4 || ctx->minorversion !=3D 0))
> 		goto out_migration_misuse;
>=20
> +	if (ctx->options & NFS_OPTION_NO_READ_PLUS &&
> +	    (ctx->version !=3D 4 || ctx->minorversion < 2))
> +		goto out_noreadplus_misuse;
> +
> 	/* Verify that any proto=3D/mountproto=3D options match the =
address
> 	 * families in the addr=3D/mountaddr=3D options.
> 	 */
> @@ -1254,6 +1266,8 @@ static int nfs_fs_context_validate(struct =
fs_context *fc)
> 			  ctx->version, ctx->minorversion);
> out_migration_misuse:
> 	return nfs_invalf(fc, "NFS: 'Migration' not supported for this =
NFS version");
> +out_noreadplus_misuse:
> +	return nfs_invalf(fc, "NFS: 'noreadplus' not supported for this =
NFS version\n");
> out_version_unavailable:
> 	nfs_errorf(fc, "NFS: Version unavailable");
> 	return ret;
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 0cd767e5c977..868dc3c36ba1 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -1016,6 +1016,9 @@ static int nfs4_server_common_setup(struct =
nfs_server *server,
> 	server->caps |=3D server->nfs_client->cl_mvops->init_caps;
> 	if (server->flags & NFS_MOUNT_NORDIRPLUS)
> 			server->caps &=3D ~NFS_CAP_READDIRPLUS;
> +	if (server->options & NFS_OPTION_NO_READ_PLUS)
> +		server->caps &=3D ~NFS_CAP_READ_PLUS;
> +
> 	/*
> 	 * Don't use NFS uid/gid mapping if we're using AUTH_SYS or =
lower
> 	 * authentication.
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 11248c5a7b24..360e70c7bbb6 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -172,6 +172,7 @@ struct nfs_server {
> 	unsigned int		clone_blksize;	/* granularity of a =
CLONE operation */
> #define NFS_OPTION_FSCACHE	0x00000001	/* - local caching =
enabled */
> #define NFS_OPTION_MIGRATION	0x00000002	/* - NFSv4 migration =
enabled */
> +#define NFS_OPTION_NO_READ_PLUS	0x00000004	/* - NFSv4.2 =
READ_PLUS enabled */
>=20
> 	struct nfs_fsid		fsid;
> 	__u64			maxfilesize;	/* maximum file size */
> --=20
> 2.24.1
>=20

--
Chuck Lever



