Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A86249ECA
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Aug 2020 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgHSM5n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Aug 2020 08:57:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54772 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgHSM4J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Aug 2020 08:56:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07JCrE0J124926;
        Wed, 19 Aug 2020 12:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=W9lap1N/Jds8RNF4MIs+LgbSZ1pftaB01UAB5jMjH44=;
 b=Ro3l0+FTGmgCDLJt6e4ObkHJk5wqrbxguI+rDzRXeWSAZOGGZkvUpJHqUbMAavxAwej0
 8EFStkpz8Sqa1VA+7iOS+3CKeYtNjec7X5l2CX2X0yeCl6uslirGz9nNm78MLmCu/h3D
 YGf+zUugivMqz6BqjPMTYM1/TUP2fMAdcGzGnwFPbMa3myaY8EKNaq35ck7Ako7aJw6N
 axgzRiOdpnzjXqiRZNGo0n+t0uFp5Mj1L5MBgFf/y1pADk+rZsfLSfy9Qt2UQPM0kKRD
 R3fSBwKYPR5UYjfgT9VVvoyALSktZ/rOFP3FcZkjne0rXYKyNPy9wA6hBiobENixSPGC 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32x8bnabm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Aug 2020 12:55:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07JCqxk0044842;
        Wed, 19 Aug 2020 12:53:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32xsmyn17b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Aug 2020 12:53:44 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07JCrftM027744;
        Wed, 19 Aug 2020 12:53:41 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Aug 2020 05:53:41 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] nfsd: Convert to use the preferred fallthrough macro
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200819092658.35504-1-linmiaohe@huawei.com>
Date:   Wed, 19 Aug 2020 08:53:40 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3CDBC253-B211-48BC-B78C-E99DC45B4B03@oracle.com>
References: <20200819092658.35504-1-linmiaohe@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9717 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008190113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9717 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008190113
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 19, 2020, at 5:26 AM, Miaohe Lin <linmiaohe@huawei.com> wrote:
>=20
> Convert the uses of fallthrough comments to fallthrough macro.

The patch description would be more helpful if it referenced the
commit that added the fallthrough macro to the kernel, or a
permanent mailing list link that described its appropriate usage.

Thanks!

> Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> fs/nfsd/nfs4callback.c | 2 +-
> fs/nfsd/nfs4proc.c     | 2 +-
> fs/nfsd/nfs4state.c    | 2 +-
> fs/nfsd/nfsfh.c        | 2 +-
> fs/nfsd/vfs.c          | 4 ++--
> 5 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 7fbe9840a03e..052be5bf9ef5 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1119,7 +1119,7 @@ static bool nfsd4_cb_sequence_done(struct =
rpc_task *task, struct nfsd4_callback
> 		break;
> 	case -ESERVERFAULT:
> 		++session->se_cb_seq_nr;
> -		/* Fall through */
> +		fallthrough;
> 	case 1:
> 	case -NFS4ERR_BADSESSION:
> 		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index a527da3d8052..eaf50eafa935 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -428,7 +428,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> 				goto out;
> 			open->op_openowner->oo_flags |=3D =
NFS4_OO_CONFIRMED;
> 			reclaim =3D true;
> -			/* fall through */
> +			fallthrough;
> 		case NFS4_OPEN_CLAIM_FH:
> 		case NFS4_OPEN_CLAIM_DELEG_CUR_FH:
> 			status =3D do_open_fhandle(rqstp, cstate, open);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 81ed8e8bab3f..2f77f4b66cbc 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3117,7 +3117,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> 		break;
> 	default:				/* checked by xdr code =
*/
> 		WARN_ON_ONCE(1);
> -		/* fall through */
> +		fallthrough;
> 	case SP4_SSV:
> 		status =3D nfserr_encr_alg_unsupp;
> 		goto out_nolock;
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 37bc8f5f4514..a0a8d27539ae 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -469,7 +469,7 @@ static bool fsid_type_ok_for_exp(u8 fsid_type, =
struct svc_export *exp)
> 	case FSID_UUID16:
> 		if (!is_root_export(exp))
> 			return false;
> -		/* fall through */
> +		fallthrough;
> 	case FSID_UUID4_INUM:
> 	case FSID_UUID16_INUM:
> 		return exp->ex_uuid !=3D NULL;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 7d2933b85b65..aba5af9df328 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1456,7 +1456,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> 					*created =3D true;
> 				break;
> 			}
> -			/* fall through */
> +			fallthrough;
> 		case NFS4_CREATE_EXCLUSIVE4_1:
> 			if (   d_inode(dchild)->i_mtime.tv_sec =3D=3D =
v_mtime
> 			    && d_inode(dchild)->i_atime.tv_sec =3D=3D =
v_atime
> @@ -1465,7 +1465,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> 					*created =3D true;
> 				goto set_attr;
> 			}
> -			/* fall through */
> +			fallthrough;
> 		case NFS3_CREATE_GUARDED:
> 			err =3D nfserr_exist;
> 		}
> --=20
> 2.19.1
>=20

--
Chuck Lever



