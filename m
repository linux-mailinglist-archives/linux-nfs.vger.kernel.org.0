Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAF12BB2F2
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 19:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbgKTS2E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 13:28:04 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37646 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbgKTS2E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 13:28:04 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AKIOcBK106375;
        Fri, 20 Nov 2020 18:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=qvBE1SJNT/wZHcsLMI3PMAlfbCkt7erxtPgt3PiLBvA=;
 b=QXq6usQw0U9HQH2H2JMwu/okYOUocTNxYPPWMtf0mQ1ljRJmoaNOHDFLWQh15A5w0Z5T
 zGxem7cBaS1xcehqG4+loIW72SIeBZ1xjci8cUgbiRK+s/fJ2dy/h+DCD3xFZ1OAv24w
 GmizLALc1vw4uOalbST+56GPEOUMMgSRqRd6v4NUoI15z9xvlPSkGOY1CQNyG4aa4lEW
 Ve0YMy6akItPEL0Uhfi/x/kLT+XzYQzvmrEJyEcY/alAPwlaeEP8hoskJovRBbuPhb++
 /KUWvb6bXJGFLnCGVhnfjxR5HnKKx5vgHyemuIQ0JjEF/bjWudM6OimYS1HEep4vUOHN bQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34t4rbc44u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Nov 2020 18:27:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AKIPhFs070245;
        Fri, 20 Nov 2020 18:27:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34umd3sp7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Nov 2020 18:27:54 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AKIRrst004103;
        Fri, 20 Nov 2020 18:27:53 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Nov 2020 10:27:53 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 016/141] nfsd: Fix fall-through warnings for Clang
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <0669408377bdc6ee87b214b2756465a6edc354fc.1605896059.git.gustavoars@kernel.org>
Date:   Fri, 20 Nov 2020 13:27:51 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF1128CE-4339-4145-9766-4EE7A5F58B5F@oracle.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <0669408377bdc6ee87b214b2756465a6edc354fc.1605896059.git.gustavoars@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9811 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011200126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9811 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200126
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 20, 2020, at 1:26 PM, Gustavo A. R. Silva =
<gustavoars@kernel.org> wrote:
>=20
> In preparation to enable -Wimplicit-fallthrough for Clang, fix =
multiple
> warnings by explicitly adding a couple of break statements instead of
> just letting the code fall through to the next case.
>=20
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> fs/nfsd/nfs4state.c | 1 +
> fs/nfsd/nfsctl.c    | 1 +
> 2 files changed, 2 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d7f27ed6b794..cdab0d5be186 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3113,6 +3113,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> 			goto out_nolock;
> 		}
> 		new->cl_mach_cred =3D true;
> +		break;
> 	case SP4_NONE:
> 		break;
> 	default:				/* checked by xdr code =
*/
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index f6d5d783f4a4..9a3bb1e217f9 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1165,6 +1165,7 @@ static struct inode *nfsd_get_inode(struct =
super_block *sb, umode_t mode)
> 		inode->i_fop =3D &simple_dir_operations;
> 		inode->i_op =3D &simple_dir_inode_operations;
> 		inc_nlink(inode);
> +		break;
> 	default:
> 		break;
> 	}
> --=20
> 2.27.0
>=20

Acked-by: Chuck Lever <chuck.lever@oracle.com>

--
Chuck Lever



