Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E63114F11B
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2020 18:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgAaRKP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jan 2020 12:10:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57038 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgAaRKP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Jan 2020 12:10:15 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VH8xP0182806;
        Fri, 31 Jan 2020 17:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=of7Mq3lISjg1xAiVHo1STj9YVrbl+fgfDpTGowrc/A0=;
 b=FuHb7cdAlW9WzupSdHi9orl8fWgyjKNorm5CWjUlvag9iJCji3NBHOyubvpZRvYznXFx
 kRDr5tSlCzVLUQbtkgNa9A5hGm3708LgfumRg/+4VnQ4sL7wY3AH9a0o679MSLx1TusI
 066F/uQyy401m7VohedOhbzExWu7ouIlIYlx2IRV3sfqyaZYnjLprhUDbrSwMNYwABB8
 +uu7dkLezYVEtG8ZceSqXWaFqI9oxYS2pCmndexe3p3Ehe1/KvQIAE8crtJoo5FsnlQw
 wxwt+8JOseYQ/w44M9Q0ERsP/1ds/V8zI5Iz4YQ6VHd17/0xTCkc5jJ/EvvM0YaCLv2Q dA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xrearuk96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 17:10:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VH8xcf031073;
        Fri, 31 Jan 2020 17:10:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xv8nrctjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 17:10:08 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00VHA04Y010877;
        Fri, 31 Jan 2020 17:10:01 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Jan 2020 09:10:00 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/1] NFSv4.0 encode nconnect-enabled client into clientid
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200131165702.1751-1-olga.kornievskaia@gmail.com>
Date:   Fri, 31 Jan 2020 12:09:58 -0500
Cc:     trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <45AE6B67-4B01-412B-8ABF-94E06BFB77D8@oracle.com>
References: <20200131165702.1751-1-olga.kornievskaia@gmail.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9517 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9517 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310142
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga-

> On Jan 31, 2020, at 11:57 AM, Olga Kornievskaia =
<olga.kornievskaia@gmail.com> wrote:
>=20
> From: Olga Kornievskaia <kolga@netapp.com>
>=20
> It helps some servers to be able to identify if the incoming client is
> doing nconnect mount or not. While creating the unique client id for
> the SETCLIENTID operation add nconnect=3DX to it.

This makes me itch uncomfortably.

The long-form client ID string is not supposed to be used to communicate
client implementation details. In fact, this string is supposed to be
opaque to the server -- it can only compare these strings for equality.

IMO you would also need to write something akin to a standard that =
describes
this convention so that servers can depend on the form of the string.

How would a server use this information?


> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
> fs/nfs/nfs4proc.c | 20 +++++++++++---------
> 1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 402410c..a90ea28 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5950,7 +5950,7 @@ static void nfs4_init_boot_verifier(const struct =
nfs_client *clp,
> 		return 0;
>=20
> 	rcu_read_lock();
> -	len =3D 14 +
> +	len =3D 14 + 12 +
> 		strlen(clp->cl_rpcclient->cl_nodename) +
> 		1 +
> 		strlen(rpc_peeraddr2str(clp->cl_rpcclient, =
RPC_DISPLAY_ADDR)) +
> @@ -5972,13 +5972,15 @@ static void nfs4_init_boot_verifier(const =
struct nfs_client *clp,
>=20
> 	rcu_read_lock();
> 	if (nfs4_client_id_uniquifier[0] !=3D '\0')
> -		scnprintf(str, len, "Linux NFSv4.0 %s/%s/%s",
> +		scnprintf(str, len, "Linux NFSv4.0 nconnect=3D%d =
%s/%s/%s",
> +			  clp->cl_nconnect,
> 			  clp->cl_rpcclient->cl_nodename,
> 			  nfs4_client_id_uniquifier,
> 			  rpc_peeraddr2str(clp->cl_rpcclient,
> 					   RPC_DISPLAY_ADDR));
> 	else
> -		scnprintf(str, len, "Linux NFSv4.0 %s/%s",
> +		scnprintf(str, len, "Linux NFSv4.0 nconnect=3D%d %s/%s",
> +			  clp->cl_nconnect,
> 			  clp->cl_rpcclient->cl_nodename,
> 			  rpc_peeraddr2str(clp->cl_rpcclient,
> 					   RPC_DISPLAY_ADDR));
> @@ -5994,7 +5996,7 @@ static void nfs4_init_boot_verifier(const struct =
nfs_client *clp,
> 	size_t len;
> 	char *str;
>=20
> -	len =3D 10 + 10 + 1 + 10 + 1 +
> +	len =3D 10 + 10 + 1 + 10 + 1 + 12 +
> 		strlen(nfs4_client_id_uniquifier) + 1 +
> 		strlen(clp->cl_rpcclient->cl_nodename) + 1;
>=20
> @@ -6010,9 +6012,9 @@ static void nfs4_init_boot_verifier(const struct =
nfs_client *clp,
> 	if (!str)
> 		return -ENOMEM;
>=20
> -	scnprintf(str, len, "Linux NFSv%u.%u %s/%s",
> +	scnprintf(str, len, "Linux NFSv%u.%u nconnect=3D%d %s/%s",
> 			clp->rpc_ops->version, clp->cl_minorversion,
> -			nfs4_client_id_uniquifier,
> +			clp->cl_nconnect, nfs4_client_id_uniquifier,
> 			clp->cl_rpcclient->cl_nodename);

Doesn't this also change the client ID string used for EXCHANGE_ID ?


> 	clp->cl_owner_id =3D str;
> 	return 0;
> @@ -6030,7 +6032,7 @@ static void nfs4_init_boot_verifier(const struct =
nfs_client *clp,
> 	if (nfs4_client_id_uniquifier[0] !=3D '\0')
> 		return nfs4_init_uniquifier_client_string(clp);
>=20
> -	len =3D 10 + 10 + 1 + 10 + 1 +
> +	len =3D 10 + 10 + 1 + 10 + 1 + 12 +
> 		strlen(clp->cl_rpcclient->cl_nodename) + 1;
>=20
> 	if (len > NFS4_OPAQUE_LIMIT + 1)
> @@ -6045,9 +6047,9 @@ static void nfs4_init_boot_verifier(const struct =
nfs_client *clp,
> 	if (!str)
> 		return -ENOMEM;
>=20
> -	scnprintf(str, len, "Linux NFSv%u.%u %s",
> +	scnprintf(str, len, "Linux NFSv%u.%u nconnect=3D%d %s",
> 			clp->rpc_ops->version, clp->cl_minorversion,
> -			clp->cl_rpcclient->cl_nodename);
> +			clp->cl_nconnect, =
clp->cl_rpcclient->cl_nodename);
> 	clp->cl_owner_id =3D str;
> 	return 0;
> }
> --=20
> 1.8.3.1
>=20

--
Chuck Lever



