Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9033F34074D
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Mar 2021 14:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhCRN5d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 09:57:33 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46730 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhCRN5L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Mar 2021 09:57:11 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IDs0T0104729;
        Thu, 18 Mar 2021 13:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=g1COjFycEQjQg6IxY6xWB5EipCAcxx9mS3ocNGEA0WE=;
 b=0d9m5KXAUPg+Y7O7usTAEvuvXzr3JKdXuIvAgLx5CHo5NEDaxxfuN62QQXEDDk2VDdDp
 cmmaHH3IVWpvpyuGXGhNsaMrMt/qJdMi+YV+B/Td87Za7BST9yXdnMjOupkzUUEqoczE
 BF5jrFw8cXidPt73g0pV968KbPJHlalkjGeUIfuOTy3/u/J2gsV22Q2aNdLYkq4EHAQ6
 r6WCKImTMeLbeQSBW2xnlFwVL6O0nDRzT/D6SYEr4u4m9VsCtgyEqX++09iNThs+JRjL
 v1fZizdRYbCWtGbo+wwnCWbUTf976r5Mq8q7XRvwJ1koSBaQ9ZbeiZ8wOHkekzsUwedo ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 378jwbqmy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 13:57:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IDu6jF015662;
        Thu, 18 Mar 2021 13:57:04 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by userp3030.oracle.com with ESMTP id 3797b2y6en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 13:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npu7DAhzyfeyOBf3qg1G7CNfEDgiD55ASbydl+CvDrg3pGLOdGzfJxO1MAqEBAm0AVrfn4sPDsEvPUEEc0RXo2x+wVxwzT+1yYOaNFQE09Tu7cOm3hzDg+BNe9gzTSMpa2dqtMMJjP4nguHis9k8DxCrFMPFQniE1vL09pZ8wHGMRiH3Y1+d/tYVyRVy/CUMjU8wU7f81krQKcXZqe3uMObEV04euhfWzaAsPPKMBAaPjYpSndznI0hQ0tzkhQ8e5k92+Xd6jrKgFskwBOUQVh4ChGLV5jlcBwhIgGGT5rrr9IGXDZOIxat1Gxe0Jp44CbP2Mz58znZHlzbRTDt6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1COjFycEQjQg6IxY6xWB5EipCAcxx9mS3ocNGEA0WE=;
 b=MLNA4ctJn7LCKGRu6S4PF/qyCR6hF1O/OamQxAbmlD7F8DnzHmRa6YRACeBt6Ge3asDpsK4SV8IGx4yqqxUUeAlgjp368krvrpugUXbpMxHRQ0EBJRgoPwLaF9bRb2FqISPPMCpVH4PztCa56ObLtCWKgBvilQhXX9YWScLIM3v80eCqHAQi+B/IWCxEtxf+0vHaNZjCZuq8AOfi4l5N3hiFX7WFXcPc8TicRPH7suTYROMLbEZqs/e3I6DjKAxhBosiaj89QdBQVggt8McmjlCW1ggnYR8BtBRMUBDxRTOH72ilOCWkHC4PW7BMiDQ45u+pBCBkeQkKtyUU+Z9GvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1COjFycEQjQg6IxY6xWB5EipCAcxx9mS3ocNGEA0WE=;
 b=EkvbyX8jtLkc3neW5KdUpZwNTv+y9UzKgLnPzA44QhrxyZwUoS1Dgo9pYUWUrF+kpCYtf94G9aCf5N/WDXAybbQ8RgM8kACpHUYCNqOyrgIjMSA0mqpfKv+RoJtdPNRaZ1ppA7WpzgBY6OBdn02M7jQu11RaQ7tLOUJIqBSYKTY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2440.namprd10.prod.outlook.com (2603:10b6:a02:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 13:57:01 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 13:57:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Nagendra Tomar <Nagendra.Tomar@microsoft.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: [RFC] nconnect xprt stickiness for a file
Thread-Topic: [RFC] nconnect xprt stickiness for a file
Thread-Index: AdcbmG3Wy+rLrgPySr2+3WoogOFJygAZiM4A
Date:   Thu, 18 Mar 2021 13:57:01 +0000
Message-ID: <FFBB2134-E8A6-46A7-ADA0-5E222DC11620@oracle.com>
References: <KU1P153MB01977184017092050048033F9E699@KU1P153MB0197.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KU1P153MB01977184017092050048033F9E699@KU1P153MB0197.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3181c432-7cd1-4fa3-c423-08d8ea15b486
x-ms-traffictypediagnostic: BYAPR10MB2440:
x-microsoft-antispam-prvs: <BYAPR10MB2440B2CCEFB9F7534283294493699@BYAPR10MB2440.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6J4Oiy7N0Nk8UIaI843hPKb38rROBJrBmCdnj9PNuY6WAtK/KtJn+5qFetusvHZLPsxuVvTtBVq+K5v/86ErzcHZ3BTlKlRs/8L1HjcpifsNX3839GlaoJzgOzEG7sGxbnQ1bo1CrWML4yS7MJfq2eX2PDBheXkzH8PBwFNHmaNo9lgwtsrlMVW2LxOtAlfikptG0A3Caef+nvPLR3EOLw2TcWoepoRiZf0fVOmIqPGfPKFhNvD2zcTwLnY+pvQvU6pzVP85ejofbggLWeh8K+dziQtWp0z306L7ki6Xz0+GBS6kj3F8IJZvaT34Jcv5uJv+efBakVBFil0MgkntGa/5UfPDbzbWcMsqWAXAs5GMEgjff2HVED6fk2bfOhQpZeucZb/aLbLVuAz+xVMsnwCJPlrC2bNKjuSMfb5jxrRu/cVgbWPcAR9eiAJB2HXLdlTQkWwtgCzZSX9rvg2RJ0CmXJ1RjREdCSw1YW0/nI3lWuohdWlcP/fjtghzoLGGKLff+m+CjRUh3MHAn3INyk+slrxEAn+TisEfQPu7BB1aPsJHIPHkklnIRiLkVoPqkYuXNaS06tXxWOCOFrZkGXrIR045pRhxUvntrW8s4o4WG/45/j4QgX5BSX9ifT8BHPX52lABPhSzUvolJuq7KQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(136003)(376002)(346002)(30864003)(53546011)(64756008)(71200400001)(6486002)(26005)(54906003)(66556008)(2616005)(66446008)(6916009)(86362001)(76116006)(66476007)(66946007)(83380400001)(6512007)(186003)(8676002)(8936002)(33656002)(6506007)(38100700001)(91956017)(36756003)(5660300002)(478600001)(2906002)(4326008)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+wEKSpE1f4mnFDtcdypSuVFfENEv9KiwAyt8qxwkERAYr+3ZugvFRF4c1LzX?=
 =?us-ascii?Q?XOz+tg/tDpx2/G818uoZ+CvLX4H6Ktrj1kRt08aV2ckuNMvkKcQLc1WX8se2?=
 =?us-ascii?Q?2jBwps/HUrYyzqD5ealFSA96xsAKnvAeeEPtFX9aYvm/NL/MZudFkKVUeLtz?=
 =?us-ascii?Q?4xmBd7P0kPiNmw9eJ7Nm9zcsgeip3gnCDjgZmfdNh6+efEFlFvI4pEzHoooq?=
 =?us-ascii?Q?1BxrDf31XkEUcUgwQ3Aq6b0XLPn9JbOBVcKM9esByiGN60zOjLp3jldmLXVs?=
 =?us-ascii?Q?FZEy7UCxo6mNNeTMW339Z9gZEFBjF4BLahex3fFqbKykHq0LezcN7BVMknYs?=
 =?us-ascii?Q?IthRqHEk2EMulXJkqvidUehz87PKD7MFQZwmv1cts8EkyY5udSUEXm2fEGt8?=
 =?us-ascii?Q?hXm78vybtQ76U91aDD7bHtSxzb651Sm66YTRa6JD+2bfual8bTp9U0SzyzxH?=
 =?us-ascii?Q?w1kwrBo3Q4aVHUs49doisMhbU75oayt89zImtxBUiA09KZ13nokYRnKsPPTn?=
 =?us-ascii?Q?4rZtAR9JtAKP12FyZZ3kSXbtY5WrdgMLHRgyHYvK5WM1+g3vqWeMpUoTP42o?=
 =?us-ascii?Q?6XUlx9ppRdP8h1WX3cmUfg+tY2o3MBEuDEVE/mB/SHmQLEvFog4m8U2/F1Z0?=
 =?us-ascii?Q?ca9+6Wx3IwHkIXx9NFUKx6LqDswa2pzwDKX4f+is6C85Qgz4T7MS3fkLIUTD?=
 =?us-ascii?Q?IYdWAAD04W5WfUlyVDUSWb0EA4tqO78V2hfIWPxLTB+U3LLoO9Tm2bKhLdnI?=
 =?us-ascii?Q?HtnKhVQVZYhPykCeWEJQ1OVjpI9/g+L3JXrK0XGsiyDjDStBIjVaTWsBc+oF?=
 =?us-ascii?Q?6ZwuLR1bb0U4JaZ60OlFY80ddIwvb0EJciFxJmPzISjVNTXNlW000gw6Zn4a?=
 =?us-ascii?Q?ksm/BxFoWj2WPK6QVDd8jPqafwhCgDNo8pnnTtJ7sNqjsuW6iHuX5NJn8eMm?=
 =?us-ascii?Q?JwD6J7O9Ocbdp+BJBnP48BQHtVctm43EAiTrCAyK3/arMCvNd5KpU/03Hp+V?=
 =?us-ascii?Q?7lQuNNtt0uBSwB/1kRPA2g+iXCSzqdeV7/oVAAGRxzWVaR+eXQE7fAu6o2ad?=
 =?us-ascii?Q?aEVQ+dwTZ+ug3kCbxWxrNSudpXD1+b5Q9x+NdLzxNePgyxxrzkhSAqJbwn26?=
 =?us-ascii?Q?2zcxqYeK3JOo24haKB7idmKHsCG0CCI+aOM0uFepUh141m0e+t8/EseGFhsM?=
 =?us-ascii?Q?RGcF+JDjWjElHkolkQrQCZ6NKwkvlfNql3L9d3lg8coj6/9TRJg9fzocG6Ob?=
 =?us-ascii?Q?4FrwkP0xe1ZCFOCKGfyA/MGsMG1UGzbsWkZfrkRxDEP7nNNJi0yd8zZwYlht?=
 =?us-ascii?Q?L6pA1LvJLFE4Tc/CNjFCzwN9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C70446C44A84234EAADEFED1E3834974@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3181c432-7cd1-4fa3-c423-08d8ea15b486
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 13:57:01.6460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kOY6LJ2Lf7nLeNB/n18woQvfVLY2xzHNtWZ4e/ddP4WrzUU/kDGRA+h2O9sCK6ahzqRoY1k2b4ZzCUWc7nYZxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2440
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180103
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180103
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 17, 2021, at 9:56 PM, Nagendra Tomar <Nagendra.Tomar@microsoft.com=
> wrote:
>=20
> We have a clustered NFS server behind a L4 load-balancer with the followi=
ng
> Characteristics (relevant to this discussion):
>=20
> 1. RPC requests for the same file issued to different cluster nodes are n=
ot efficient.
>    One file one cluster node is efficient. This is particularly true for =
WRITEs.
> 2. Multiple nconnect xprts land on different cluster nodes due to the sou=
rce=20
>    port being different for all.
>=20
> Due to this, the default nconnect roundrobin policy does not work very we=
ll as
> it results in RPCs targeted to the same file to be serviced by different =
cluster nodes.
>=20
> To solve this, we tweaked the nfs multipath code to always choose the sam=
e xprt=20
> for the same file. We do that by adding a new integer field to rpc_messag=
e,
> rpc_xprt_hint, which is set by NFS layer and used by RPC layer to pick a =
xprt.
> NFS layer sets it to the hash of the target file's filehandle, thus ensur=
ing same file
> requests always use the same xprt. This works well.
>=20
> I am interested in knowing your thoughts on this, has anyone else also co=
me across
> similar issue, is there any other way of solving this, etc.

Would a pNFS file layout work? The MDS could direct I/O for
a particular file to a specific DS.


> Following  patch is just to demonstrate the idea. It works but covers onl=
y what I
> needed for the experiment. Based on the feedback, I can follow it up with=
 a formal=20
> patch if needed.
>=20
> Thanks,
> Tomar
>=20
> ---
> diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
> index 5c4e23abc..8f1cf03dc 100644
> --- a/fs/nfs/nfs3proc.c
> +++ b/fs/nfs/nfs3proc.c
> @@ -108,6 +108,7 @@ nfs3_proc_getattr(struct nfs_server *server, struct n=
fs_fh *fhandle,
> 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_GETATTR],
> 		.rpc_argp	=3D fhandle,
> 		.rpc_resp	=3D fattr,
> +		.rpc_xprt_hint	=3D nfs_fh_hash(fhandle),
> 	};
> 	int	status;
> 	unsigned short task_flags =3D 0;
> @@ -136,6 +137,7 @@ nfs3_proc_setattr(struct dentry *dentry, struct nfs_f=
attr *fattr,
> 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_SETATTR],
> 		.rpc_argp	=3D &arg,
> 		.rpc_resp	=3D fattr,
> +		.rpc_xprt_hint	=3D nfs_fh_hash(arg.fh),
> 	};
> 	int	status;
>=20
> @@ -171,6 +173,7 @@ __nfs3_proc_lookup(struct inode *dir, const char *nam=
e, size_t len,
> 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_LOOKUP],
> 		.rpc_argp	=3D &arg,
> 		.rpc_resp	=3D &res,
> +		.rpc_xprt_hint	=3D nfs_fh_hash(arg.fh),
> 	};
> 	int			status;
>=20
> @@ -235,6 +238,7 @@ static int nfs3_proc_access(struct inode *inode, stru=
ct nfs_access_entry *entry)
> 		.rpc_argp	=3D &arg,
> 		.rpc_resp	=3D &res,
> 		.rpc_cred	=3D entry->cred,
> +		.rpc_xprt_hint	=3D nfs_fh_hash(arg.fh),
> 	};
> 	int status =3D -ENOMEM;
>=20
> @@ -266,6 +270,7 @@ static int nfs3_proc_readlink(struct inode *inode, st=
ruct page *page,
> 	struct rpc_message msg =3D {
> 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_READLINK],
> 		.rpc_argp	=3D &args,
> +		.rpc_xprt_hint	=3D nfs_fh_hash(args.fh),
> 	};
> 	int status =3D -ENOMEM;
>=20
> @@ -355,6 +360,7 @@ nfs3_proc_create(struct inode *dir, struct dentry *de=
ntry, struct iattr *sattr,
> 	data->arg.create.name =3D dentry->d_name.name;
> 	data->arg.create.len =3D dentry->d_name.len;
> 	data->arg.create.sattr =3D sattr;
> +	data->msg.rpc_xprt_hint =3D nfs_fh_hash(data->arg.create.fh);
>=20
> 	data->arg.create.createmode =3D NFS3_CREATE_UNCHECKED;
> 	if (flags & O_EXCL) {
> @@ -442,6 +448,7 @@ nfs3_proc_remove(struct inode *dir, struct dentry *de=
ntry)
> 		.rpc_proc =3D &nfs3_procedures[NFS3PROC_REMOVE],
> 		.rpc_argp =3D &arg,
> 		.rpc_resp =3D &res,
> +		.rpc_xprt_hint =3D nfs_fh_hash(arg.fh),
> 	};
> 	int status =3D -ENOMEM;
>=20
> @@ -524,6 +531,7 @@ nfs3_proc_link(struct inode *inode, struct inode *dir=
, const struct qstr *name)
> 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_LINK],
> 		.rpc_argp	=3D &arg,
> 		.rpc_resp	=3D &res,
> +		.rpc_xprt_hint	=3D nfs_fh_hash(arg.tofh),
> 	};
> 	int status =3D -ENOMEM;
>=20
> @@ -566,6 +574,7 @@ nfs3_proc_symlink(struct inode *dir, struct dentry *d=
entry, struct page *page,
> 	data->arg.symlink.pages =3D &page;
> 	data->arg.symlink.pathlen =3D len;
> 	data->arg.symlink.sattr =3D sattr;
> +	data->msg.rpc_xprt_hint =3D nfs_fh_hash(data->arg.symlink.fromfh);
>=20
> 	d_alias =3D nfs3_do_create(dir, dentry, data);
> 	status =3D PTR_ERR_OR_ZERO(d_alias);
> @@ -602,6 +611,7 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *den=
try, struct iattr *sattr)
> 	data->arg.mkdir.name =3D dentry->d_name.name;
> 	data->arg.mkdir.len =3D dentry->d_name.len;
> 	data->arg.mkdir.sattr =3D sattr;
> +	data->msg.rpc_xprt_hint =3D nfs_fh_hash(data->arg.mkdir.fh);
>=20
> 	d_alias =3D nfs3_do_create(dir, dentry, data);
> 	status =3D PTR_ERR_OR_ZERO(d_alias);
> @@ -636,6 +646,7 @@ nfs3_proc_rmdir(struct inode *dir, const struct qstr =
*name)
> 	struct rpc_message msg =3D {
> 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_RMDIR],
> 		.rpc_argp	=3D &arg,
> +		.rpc_xprt_hint	=3D nfs_fh_hash(arg.fh),
> 	};
> 	int status =3D -ENOMEM;
>=20
> @@ -682,6 +693,7 @@ static int nfs3_proc_readdir(struct nfs_readdir_arg *=
nr_arg,
> 		.rpc_argp	=3D &arg,
> 		.rpc_resp	=3D &res,
> 		.rpc_cred	=3D nr_arg->cred,
> +		.rpc_xprt_hint	=3D nfs_fh_hash(arg.fh),
> 	};
> 	int status =3D -ENOMEM;
>=20
> @@ -735,6 +747,7 @@ nfs3_proc_mknod(struct inode *dir, struct dentry *den=
try, struct iattr *sattr,
> 	data->arg.mknod.len =3D dentry->d_name.len;
> 	data->arg.mknod.sattr =3D sattr;
> 	data->arg.mknod.rdev =3D rdev;
> +	data->msg.rpc_xprt_hint =3D nfs_fh_hash(data->arg.mknod.fh);
>=20
> 	switch (sattr->ia_mode & S_IFMT) {
> 	case S_IFBLK:
> @@ -782,6 +795,7 @@ nfs3_proc_statfs(struct nfs_server *server, struct nf=
s_fh *fhandle,
> 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_FSSTAT],
> 		.rpc_argp	=3D fhandle,
> 		.rpc_resp	=3D stat,
> +		.rpc_xprt_hint	=3D nfs_fh_hash(fhandle),
> 	};
> 	int	status;
>=20
> @@ -800,6 +814,7 @@ do_proc_fsinfo(struct rpc_clnt *client, struct nfs_fh=
 *fhandle,
> 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_FSINFO],
> 		.rpc_argp	=3D fhandle,
> 		.rpc_resp	=3D info,
> +		.rpc_xprt_hint	=3D nfs_fh_hash(fhandle),
> 	};
> 	int	status;
>=20
> @@ -834,6 +849,7 @@ nfs3_proc_pathconf(struct nfs_server *server, struct =
nfs_fh *fhandle,
> 		.rpc_proc	=3D &nfs3_procedures[NFS3PROC_PATHCONF],
> 		.rpc_argp	=3D fhandle,
> 		.rpc_resp	=3D info,
> +		.rpc_xprt_hint	=3D nfs_fh_hash(fhandle),
> 	};
> 	int	status;
>=20
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index 78c9c4bde..60578e9fd 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -762,6 +762,7 @@ int nfs_initiate_pgio(struct rpc_clnt *clnt, struct n=
fs_pgio_header *hdr,
> 		.rpc_argp =3D &hdr->args,
> 		.rpc_resp =3D &hdr->res,
> 		.rpc_cred =3D cred,
> +		.rpc_xprt_hint =3D nfs_fh_hash(hdr->args.fh),
> 	};
> 	struct rpc_task_setup task_setup_data =3D {
> 		.rpc_client =3D clnt,
> diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
> index b27ebdcce..b1713d6fb 100644
> --- a/fs/nfs/unlink.c
> +++ b/fs/nfs/unlink.c
> @@ -355,6 +355,12 @@ nfs_async_rename(struct inode *old_dir, struct inode=
 *new_dir,
> 	msg.rpc_resp =3D &data->res;
> 	msg.rpc_cred =3D data->cred;
>=20
> +	if (data->args.new_dir)
> +		msg.rpc_xprt_hint =3D nfs_fh_hash(data->args.new_dir);
> +	else
> +		msg.rpc_xprt_hint =3D nfs_fh_hash(data->args.old_dir);
> +
> +
> 	/* set up nfs_renamedata */
> 	data->old_dir =3D old_dir;
> 	ihold(old_dir);
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 639c34fec..284b364a6 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1687,6 +1687,7 @@ int nfs_initiate_commit(struct rpc_clnt *clnt, stru=
ct nfs_commit_data *data,
> 		.rpc_argp =3D &data->args,
> 		.rpc_resp =3D &data->res,
> 		.rpc_cred =3D data->cred,
> +		.rpc_xprt_hint =3D nfs_fh_hash(data->args.fh),
> 	};
> 	struct rpc_task_setup task_setup_data =3D {
> 		.task =3D &data->task,
> diff --git a/include/linux/nfs.h b/include/linux/nfs.h
> index 0dc7ad38a..5d5b2d20b 100644
> --- a/include/linux/nfs.h
> +++ b/include/linux/nfs.h
> @@ -10,6 +10,7 @@
>=20
> #include <linux/sunrpc/msg_prot.h>
> #include <linux/string.h>
> +#include <linux/jhash.h>
> #include <uapi/linux/nfs.h>
>=20
> /*
> @@ -36,6 +37,10 @@ static inline void nfs_copy_fh(struct nfs_fh *target, =
const struct nfs_fh *sourc
> 	memcpy(target->data, source->data, source->size);
> }
>=20
> +static inline u32 nfs_fh_hash(const struct nfs_fh *fh)
> +{
> +	return (fh ? jhash(fh->data, fh->size, 0) : 0);
> +}
>=20
> /*
>  * This is really a general kernel constant, but since nothing like
> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
> index df696efdd..8f365280c 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -27,6 +27,7 @@ struct rpc_message {
> 	void *			rpc_argp;	/* Arguments */
> 	void *			rpc_resp;	/* Result */
> 	const struct cred *	rpc_cred;	/* Credentials */
> +	u32			rpc_xprt_hint;
> };
>=20
> struct rpc_call_ops;
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 612f0a641..fcf8e7962 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -1058,6 +1058,53 @@ rpc_task_get_next_xprt(struct rpc_clnt *clnt)
> 	return rpc_task_get_xprt(clnt, xprt_iter_get_next(&clnt->cl_xpi));
> }
>=20
> +static
> +bool xprt_is_active(const struct rpc_xprt *xprt)
> +{
> +	return kref_read(&xprt->kref) !=3D 0;
> +}
> +
> +static struct rpc_xprt *
> +rpc_task_get_hashed_xprt(struct rpc_clnt *clnt, const struct rpc_task *t=
ask)
> +{
> +	const struct rpc_xprt_switch *xps =3D NULL;
> +	struct rpc_xprt *xprt =3D NULL;
> +	const struct rpc_message *rpc_message =3D &task->tk_msg;
> +	const u32 hash =3D rpc_message->rpc_xprt_hint;
> +
> +	if (!hash)
> +		return rpc_task_get_next_xprt(clnt);
> +
> +	rcu_read_lock();
> +	xps =3D rcu_dereference(clnt->cl_xpi.xpi_xpswitch);
> +
> +	if (xps && hash) {
> +		const struct list_head *head =3D &xps->xps_xprt_list;
> +		struct rpc_xprt *pos;
> +		const u32 nactive =3D READ_ONCE(xps->xps_nactive);
> +		const u32 xprt_idx =3D (hash % nactive);
> +		u32 idx =3D 0;
> +
> +		list_for_each_entry_rcu(pos, head, xprt_switch) {
> +			if (xprt_idx > idx++)
> +				continue;
> +			if (xprt_is_active(pos)) {
> +				xprt =3D xprt_get(pos);
> +				break;
> +			}
> +		}
> +	}
> +
> +	/*
> +	 * Use first transport, if not found any.
> +	 */
> +	if (!xprt)
> +		xprt =3D xprt_get(rcu_dereference(clnt->cl_xprt));
> +	rcu_read_unlock();
> +
> +	return rpc_task_get_xprt(clnt, xprt);
> +}
> +
> static
> void rpc_task_set_transport(struct rpc_task *task, struct rpc_clnt *clnt)
> {
> @@ -1066,7 +1113,7 @@ void rpc_task_set_transport(struct rpc_task *task, =
struct rpc_clnt *clnt)
> 	if (task->tk_flags & RPC_TASK_NO_ROUND_ROBIN)
> 		task->tk_xprt =3D rpc_task_get_first_xprt(clnt);
> 	else
> -		task->tk_xprt =3D rpc_task_get_next_xprt(clnt);
> +		task->tk_xprt =3D rpc_task_get_hashed_xprt(clnt, task);
> }
>=20
> static
> @@ -1100,6 +1147,7 @@ rpc_task_set_rpc_message(struct rpc_task *task, con=
st struct rpc_message *msg)
> 		task->tk_msg.rpc_argp =3D msg->rpc_argp;
> 		task->tk_msg.rpc_resp =3D msg->rpc_resp;
> 		task->tk_msg.rpc_cred =3D msg->rpc_cred;
> +		task->tk_msg.rpc_xprt_hint =3D msg->rpc_xprt_hint;
> 		if (!(task->tk_flags & RPC_TASK_CRED_NOREF))
> 			get_cred(task->tk_msg.rpc_cred);
> 	}
> @@ -1130,8 +1178,8 @@ struct rpc_task *rpc_run_task(const struct rpc_task=
_setup *task_setup_data)
> 	if (!RPC_IS_ASYNC(task))
> 		task->tk_flags |=3D RPC_TASK_CRED_NOREF;
>=20
> -	rpc_task_set_client(task, task_setup_data->rpc_client);
> 	rpc_task_set_rpc_message(task, task_setup_data->rpc_message);
> +	rpc_task_set_client(task, task_setup_data->rpc_client);
>=20
> 	if (task->tk_action =3D=3D NULL)
> 		rpc_call_start(task);

--
Chuck Lever



