Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF7F32DB1E
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 21:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbhCDUVm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 15:21:42 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37206 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbhCDUVV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 15:21:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 124KIw0R181612;
        Thu, 4 Mar 2021 20:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=90rU2pFjnOcJSVdt7PIxUHUr7QFXbStukzjpu+FCbiA=;
 b=BWslVWsbWwWK55kDwQQ2eUTdUz5laWz/M7heEfq1N13iXzrwldSFRMchvCRnuvMlkSBf
 TTtKAuHurITvUgTdEs72T3ZVJvlYys9I6J9o8bMG2fmSI2x0k8yLnGeXxA0LqkStnYns
 SgOCZbMZhoybGmrVbgF5D3gefTacrws/xsdul9x53P0ngNW/202sjOgU4IS9WGHtfs1y
 XoxKKIOXfTpA9MGk7ZeMlmsExjzLONAKEJ9YhaFsvrRP64ST3UXpSDoJ3+FZf9ciRGKd
 jMJIM7/06x2LyB655UXpcZEjvq8c2QmEhOyMMLZU+S9hE7j0qhdfrILCyTAN4ON5j+or sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36yeqn8bu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Mar 2021 20:20:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 124KB8rP007597;
        Thu, 4 Mar 2021 20:20:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3030.oracle.com with ESMTP id 36yynsc0e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Mar 2021 20:20:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6GqkO5UzPF0EsLAthgUjW2gmfd2dm3mkiZ8gptXkaf/ag2S63dLCs9d4IdnaqaqQEGEP5tGvnMdamtJhskwQEbDCqaVRZeAXZQ1Q4YF7+Cv9Cu38AjFUB50FAMWaNl06ZjhMSiW2OdB7+6TE9MK8oo1tbmsO6h1vw7cUJIJitY3jdF1YIiPuSrKvc2oYkT02+Ihfyk7LqZK4xMJJqBzQWyvtAFeb70fkGOQ8Sqw2Kgjtgd16npYFwhFWoyS26mHcxOG10OT+O8sIwhd2KEQSEevj7bHMBiiXyMZJsKeZKKCVF4wlXFBh2Ou7DpcIk/dTLa5YZhHg/8u5hePHGQDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90rU2pFjnOcJSVdt7PIxUHUr7QFXbStukzjpu+FCbiA=;
 b=EdHSvtcdiFJL0deLyBCo04oSpQcu7iFMz0eUFpsP7elzPWj0WcMjtkvgdnzOnY4Y8QSrJOG0c80MDJnJCKnMhlNOupRNCj3RM5N2FFC2wTq5gMgXlLId5aGUaYmwd7wdWbnm/9e2lTyFTXOpE0T44c/iwL0Y+kp0tZY8uUfARiNF2ij0ozOIt/PDnytCoLccHlqtCk2kEc/8Y3BHBkQomTXnQxYvyI4wWi5NbYNnKoI64Jat1BIx1w1QHBQRHoWXlRTa3M1MrRa02qc+jIA3RaO3dfUODREzHWJ/NvGZIKGwWvt4Ub0bNLPU0/ZlcAFTzHHF+JVofhWe3XoO4N72Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90rU2pFjnOcJSVdt7PIxUHUr7QFXbStukzjpu+FCbiA=;
 b=B+cSh0qysUMv1/VPkvWtz2T/0YsxhWEFJCRjFGOkikXiM84GsEp7L7iBw1yYxWhXD3WvCfho+znn7sICyggNW5ZeDJs2uLkxldVJm3XYlhryH30OTNLLT/u6+S/x19PTRfwmypICqirRJecAjSUEYBTc/0OQ4y/7qyuAKOPIfiA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3110.namprd10.prod.outlook.com (2603:10b6:a03:152::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 4 Mar
 2021 20:20:29 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.023; Thu, 4 Mar 2021
 20:20:29 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Roberto Bergantinos Corpas <rbergant@redhat.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] pNFS: make DS availability problems visible in log
Thread-Topic: [PATCH] pNFS: make DS availability problems visible in log
Thread-Index: AQHXEJDleBWe0KC7fkOoSFm+lqhgjKp0RoAA
Date:   Thu, 4 Mar 2021 20:20:29 +0000
Message-ID: <FBBBDFDD-6819-450C-879D-0B11B917BD10@oracle.com>
References: <20210303153307.3147-1-rbergant@redhat.com>
In-Reply-To: <20210303153307.3147-1-rbergant@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73602955-68ae-41f3-08dc-08d8df4af488
x-ms-traffictypediagnostic: BYAPR10MB3110:
x-microsoft-antispam-prvs: <BYAPR10MB3110EDCC3D43670C2155815B93979@BYAPR10MB3110.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VeW5t9IDGQLt1SstplqvI86Ak0MYjvmIBxYFaVumtvtj00KX/WRxtPDsgpF6hrIZOYTh/E3rjtKyIcMSxbfucXu1OOluln/x5+yvxT4yEVMTLmRE3yTLXKD2dTaBqtQWTrOL5jy7kIu44pAbe0WaS/1uVGkgs8ZSSCc72a8IoMWf7h6Of/WtxVDVxQ2tDIgr1jsvCD0a16J0Pm66dRl5GpT3yTj8xPucOQYxa4lCp+kVbYan/EVCgzt6UfVvlJm5JL2+McZu/hWlvG78HKY2MUboXAo1Gujiob93tJZNd4Ww1GHOUB8GRIt4S9vMMdiECzB1XC7m282JuOe6dgnwsQALjcMJr/xhE/OhF80IOn8JvrGkUuQkQstxZsMsWUi3vjJRbGVNvgLby2wqFVl9oAAkvMY9rL9jJpBjx5gIXvyM3gjFZH95VQqgzlPZbrQhiMvotS7kcUiJlKK6TEu5RsOmeWrk8HM++TNIG+3BZqhMo01LgJCLbjJNjg5N/bEVPrLH0MqdhAwBREVAUS47VHIrG1LYo583onGYha0Csd9npUW++hRwcmYunQ17gcsWiPH/MgAjQpJTBV6Lqzy60Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(39860400002)(396003)(186003)(83380400001)(66476007)(66946007)(66446008)(66556008)(44832011)(64756008)(5660300002)(2906002)(33656002)(6512007)(86362001)(26005)(8676002)(2616005)(54906003)(316002)(6916009)(6486002)(71200400001)(478600001)(53546011)(36756003)(4326008)(91956017)(76116006)(6506007)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WPmwX5Gq0YwQctf3OYqStDjrEDJFN/IfQqgRF0LuPt7N3YbQjqebNLf2f/3j?=
 =?us-ascii?Q?7uN94mp1C5bUhvwBhJhdRJC20BfK/MSgmbBJB40Tn1u+gC2q06vhF3wdK9N9?=
 =?us-ascii?Q?CjV1P6fnaDIgm/frrUXCJifEfcTZuocwqRVC3jv6y2FgVGw6mLekw6r//MFF?=
 =?us-ascii?Q?X9jrlF8BnDOYZ+ERMRJ0YFaX2K2ab7bW6K2E/XrzduNCxccv8Ww0oLUUUUbd?=
 =?us-ascii?Q?b1aWuhc8R0EhO5uffdIvAUB7V7HGSLstNfOheMG5crsVeeISdkPbr0lAmM9Z?=
 =?us-ascii?Q?7ZYaYXyp5pxtarbMCW4+Lt6ALqNqCwgz8k87xPJktip/3UUkRhOcGbxo5yUT?=
 =?us-ascii?Q?izjbqdPpNAAR2wdDX93UkgSzIOvNvY8hH14GiHc+QX9+bX33HfsWhrOAmOFY?=
 =?us-ascii?Q?e0U/vNYbxk8KVYs+VCUxLtfX+xFiOfcK/jaMKMzh+t1R3iUEiLd7SylrrsZ0?=
 =?us-ascii?Q?bHXyHiVSMtfcn+Y9lWDZM8f1y1rb8yRqSIJ+47basSGtX2MHP8ahuovQNhaG?=
 =?us-ascii?Q?zOzlhWuVdGMoCAd6LcRCBFHqr7EUT4aD6rXg7qHGgrkxxxThxKm4m9+n84Vc?=
 =?us-ascii?Q?fhcI8KnzHKoxWb9lNQv/4w266TUgv64Ols4jInx6yG/GBP43mrNBHPkVnCMU?=
 =?us-ascii?Q?9XIYKh2g3hxb1+ZMyzarifaGsXPEhodIVjsZ45Ly7u/2uSvhMNKVJE5Ij6XH?=
 =?us-ascii?Q?AqAPJ14zsn8KV4iJDlLaxRmtdh2NQcDUyBGNMBk383/6keX5L/ECxJOxzksL?=
 =?us-ascii?Q?LH0Jan4R2pASr7IjpXL7O7PHdRqDZ/W4oda/p94hcND+Prj0VvEXhd6Z0w7V?=
 =?us-ascii?Q?CgY02+dyjntxxn7myFOQadKWVUYfnmTMtIBK4csm8lB93fGLRrskBZI+A13D?=
 =?us-ascii?Q?169U696IKuGwSRd9Deb+MrgU3sxRM9VsQyEg0SZmKn1uNVQ5iunv5tdpotNC?=
 =?us-ascii?Q?hsn1v5lYU6NombaqrknQ2a+noubUw7AOAMb9KTotzGVZwl8xSvQwarU/wJJ5?=
 =?us-ascii?Q?Ra927hyUYWafO/U5YEof8t4HvYlA70oZ1plyFEl7Xxk03FPoRW7AKdq103zl?=
 =?us-ascii?Q?HIwbs5g2YLw1Ru1ildoxhFM1ImWwgAcU+o96lX3buHQr6nOsazXJD8M3x2RH?=
 =?us-ascii?Q?Xy28cuWzCSi0HxaICsgjlEq8xCjziBjhNA2TPXU+OR7NdLqOB56/B6yW/N0/?=
 =?us-ascii?Q?SzfBtJfVKjEmk6r4HiN12yu/Ik7a1RkApB5tqYKWTR7n4lZWlpI3uip3PaUu?=
 =?us-ascii?Q?+5EWIKpZZ/yH1cY+lusiBcVUoYlqJ6lEhWhKE/+B8IaOZnyX7XnkGkK0q1B7?=
 =?us-ascii?Q?V5WcfI4sQ4dHcZDLJL8mFmlW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E49196300D6B69488EA1E2F3C958A3AA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73602955-68ae-41f3-08dc-08d8df4af488
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 20:20:29.4830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ljnvd2kAdk54mIt7X3XnE0fRpziZndqCu1z18MTMR72v0/PIkVNode6w6p8XCHSI+IfyU/bA0y/lqK6dVdQaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3110
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040098
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040099
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Roberto!

> On Mar 3, 2021, at 10:33 AM, Roberto Bergantinos Corpas <rbergant@redhat.=
com> wrote:
>=20
> Would be interesting to promote DS availability logging outside debug
> so that we are more aware that I/O is diverted to MDS and some part
> of the infraestructure failed.
>=20
> Also added logging for failed DS connection attempts.

Given that this enables remote system behavior to generate
kernel log traffic that can fill the local root partition,
I'd like to see either:

- the explicit use of rate limiting, or

- these dprintks replaced with tracepoints


> Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> ---
> fs/nfs/filelayout/filelayout.c         | 4 ++--
> fs/nfs/flexfilelayout/flexfilelayout.c | 6 +++---
> fs/nfs/pnfs_nfs.c                      | 6 +++++-
> 3 files changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayou=
t.c
> index 7f5aa0403e16..fef2d31a501a 100644
> --- a/fs/nfs/filelayout/filelayout.c
> +++ b/fs/nfs/filelayout/filelayout.c
> @@ -181,7 +181,7 @@ static int filelayout_async_handle_error(struct rpc_t=
ask *task,
> 	case -EIO:
> 	case -ETIMEDOUT:
> 	case -EPIPE:
> -		dprintk("%s DS connection error %d\n", __func__,
> +		pr_warn("%s DS connection error %d\n", __func__,
> 			task->tk_status);
> 		nfs4_mark_deviceid_unavailable(devid);
> 		pnfs_error_mark_layout_for_return(inode, lseg);
> @@ -190,7 +190,7 @@ static int filelayout_async_handle_error(struct rpc_t=
ask *task,
> 		fallthrough;
> 	default:
> reset:
> -		dprintk("%s Retry through MDS. Error %d\n", __func__,
> +		pr_warn("%s Retry through MDS. Error %d\n", __func__,
> 			task->tk_status);
> 		return -NFS4ERR_RESET_TO_MDS;
> 	}
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayo=
ut/flexfilelayout.c
> index a163533446fa..7150d94e80e6 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -1129,7 +1129,7 @@ static int ff_layout_async_handle_error_v4(struct r=
pc_task *task,
> 	case -EIO:
> 	case -ETIMEDOUT:
> 	case -EPIPE:
> -		dprintk("%s DS connection error %d\n", __func__,
> +		pr_warn("%s DS connection error %d\n", __func__,
> 			task->tk_status);
> 		nfs4_delete_deviceid(devid->ld, devid->nfs_client,
> 				&devid->deviceid);
> @@ -1139,7 +1139,7 @@ static int ff_layout_async_handle_error_v4(struct r=
pc_task *task,
> 		if (ff_layout_avoid_mds_available_ds(lseg))
> 			return -NFS4ERR_RESET_TO_PNFS;
> reset:
> -		dprintk("%s Retry through MDS. Error %d\n", __func__,
> +		pr_warn("%s Retry through MDS. Error %d\n", __func__,
> 			task->tk_status);
> 		return -NFS4ERR_RESET_TO_MDS;
> 	}
> @@ -1167,7 +1167,7 @@ static int ff_layout_async_handle_error_v3(struct r=
pc_task *task,
> 		nfs_inc_stats(lseg->pls_layout->plh_inode, NFSIOS_DELAY);
> 		goto out_retry;
> 	default:
> -		dprintk("%s DS connection error %d\n", __func__,
> +		pr_warn("%s DS connection error %d\n", __func__,
> 			task->tk_status);
> 		nfs4_delete_deviceid(devid->ld, devid->nfs_client,
> 				&devid->deviceid);
> diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
> index 679767ac258d..322661a48348 100644
> --- a/fs/nfs/pnfs_nfs.c
> +++ b/fs/nfs/pnfs_nfs.c
> @@ -934,8 +934,11 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_serve=
r *mds_srv,
> 						(struct sockaddr *)&da->da_addr,
> 						da->da_addrlen, IPPROTO_TCP,
> 						timeo, retrans, minor_version);
> -			if (IS_ERR(clp))
> +			if (IS_ERR(clp)) {
> +				pr_warn("%s: DS: %s unable to connect with address %s, error: %ld\n"=
,
> +					__func__, ds->ds_remotestr, da->da_remotestr, PTR_ERR(clp));
> 				continue;
> +			}
>=20
> 			status =3D nfs4_init_ds_session(clp,
> 					mds_srv->nfs_client->cl_lease_time);
> @@ -949,6 +952,7 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server=
 *mds_srv,
> 	}
>=20
> 	if (IS_ERR(clp)) {
> +		pr_warn("%s: no DS available\n", __func__);
> 		status =3D PTR_ERR(clp);
> 		goto out;
> 	}
> --=20
> 2.21.0
>=20

--
Chuck Lever



