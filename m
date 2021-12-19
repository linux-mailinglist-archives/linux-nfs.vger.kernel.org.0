Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D45147A1B5
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 19:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbhLSSPW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Dec 2021 13:15:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37074 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236260AbhLSSPV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Dec 2021 13:15:21 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BJBCCh8031795;
        Sun, 19 Dec 2021 18:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SLjgP9d/6D7nTa8S3fZVgpuqWYlggwXBT5z+91h+mf8=;
 b=CZJHS5Zfo+0ZPqH0hJQmO8k4/O+BRb8R+HckEEttpbKu3jBpETyDDOwUjLipaDFwJQAy
 InY6/zUMWKvZZybZz+6EC1G3dHVeELia8cJRdS3zN1xHMUzUXCtJ8BZeEO1R1TLaakw+
 hVTVA0OjVJUmHAj3F1TOS91m6xa5ZCaQP+2NkmQfB+q9ZWSLB0jSpocsCmvQNAnQTaKh
 41CuMbCh19M6CG0yFuxZ1HiDye1dQai53n2q7NhT4UrJUbypi0raA47VuczfUi2o2cIi
 GaiyTVi3GhEOrJrVHRK1injelfKKylB8dUO/MX5f/vSjcstNnuPdMjbOomqJbLC9zGj/ tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d186ssw5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Dec 2021 18:15:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BJIApnX078148;
        Sun, 19 Dec 2021 18:15:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 3d17f1t6d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Dec 2021 18:15:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtPD+sH0ASKrXlzzo5N5bM3mRptUy/t5WhGraEFCSQ/q6nywuleGr+jYzAPWVx+dWF6zKYO87IwGrEcI4/R3iEd6fziKh8/mWh/gawT2GoCl/EbmOyxYxTwFZtq1FV96SKDR30F9jH3B4qBBDHxrbbrvnVfc0A7GAcLH9byPgqoy9fyxZJOVFfRTTJTpsDV4bk8TrhBy1nTtA3RYp0ngRDJV0wLj/B6VNrJh11+THQv86sRfsTdsqNzDlpm2LFJlpidte8yA4V9Noe0X5pGTniJ6Y4HR4eqRs+BsLkBy1fZyDbnjLDa84YyM9/kI9g8TePK2P6LzXJuqdrXTGXEZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLjgP9d/6D7nTa8S3fZVgpuqWYlggwXBT5z+91h+mf8=;
 b=WuM+AaIv6tgJcoI6AT7FZjwLxGfUh0RR2ErHnz3ip9gIs9/F5Oy+RQTIdiYJmSZzO96jdrvPQDAyV1LmfNg8RVVeWXsx3wcvlhuEinmV44CVqiDGFRZUVG8ZXXT7yqU4d1F7X+6txrvwIDmzWz4CNuYjYG+Hx032vXpapu1Cj5gZqjGDcho8acCZcKJgtPKxztqckbYn4TNrGFQpbgOBo2TudhgiyfBYNcrGUpbHGyhXxLdWUzRBNs+vd0zC9Y3uu19+aEGGKZTm6cUE96o8Cj8pji+VoAzzls5QAeRcOQzWzQ7JwALtacQlJHevBZe35pIGKO2h9oVS6kauynCrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLjgP9d/6D7nTa8S3fZVgpuqWYlggwXBT5z+91h+mf8=;
 b=YLRO2p89bnJxOiA3N4onDkHQ5FydE05hyw37sYCV/BMryPNJHrseXallwhjpVbO/z8RTK3giPeE9tJvEXerHTLtMp2hbrGttzAZfGZ5Cb9V/p+B0PVFzxeqF0t70IeD7s6AZUv/wMKoTMctCKNP+hT05X4PND4eTKAn/x+kTNRs=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB3784.namprd10.prod.outlook.com (2603:10b6:610:3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Sun, 19 Dec
 2021 18:15:07 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4801.020; Sun, 19 Dec 2021
 18:15:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 10/10] nfsd: Ignore rpcbind errors on nfsd startup
Thread-Topic: [PATCH v2 10/10] nfsd: Ignore rpcbind errors on nfsd startup
Thread-Index: AQHX9HoJf0UrhpbILEawWnDLCGoAp6w6H74A
Date:   Sun, 19 Dec 2021 18:15:07 +0000
Message-ID: <831659F6-3005-459B-92ED-933BBCEE6FE9@oracle.com>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org>
 <20211219013803.324724-6-trondmy@kernel.org>
 <20211219013803.324724-7-trondmy@kernel.org>
 <20211219013803.324724-8-trondmy@kernel.org>
 <20211219013803.324724-9-trondmy@kernel.org>
 <20211219013803.324724-10-trondmy@kernel.org>
 <20211219013803.324724-11-trondmy@kernel.org>
In-Reply-To: <20211219013803.324724-11-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 863b112d-6a0b-47f0-ff56-08d9c31b7cbd
x-ms-traffictypediagnostic: CH2PR10MB3784:EE_
x-microsoft-antispam-prvs: <CH2PR10MB3784519D5F50C94EACBB4117937A9@CH2PR10MB3784.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JUwuMhsHbR5eeWecM3oPwjhvNDZ2O1/u/33nS7LObPyTyO7AVMse4BHX+zH7v/2+K+A60oahJvdOL5s7gUrxxSgu+Gwn8WJV9/Hn1vVs0YIweCXlwS3hWVwYAvcYlpwkwWHjaC6N1hMZTb9BXY8wt5t14RM1Dfe1H9cx6ujeYY7Cchn25HuerPQYlt3HFe6h+aoU1DF6fBPRddF/yAlpJWfl//AxISKKS2+pUlZzHlKBKY7tX/T4CWCcVabJzuMZvAAxhxxnjLbE6O0BpBBzOR60kVgudfD5nCd7SfP8ONgv2Qi6+Z45gWsJAiHXkHmLcuOjjYA3lDS1zYrSSibhsPsmpqnLnzew5R3AC8ArfR6qne9u97iO0TEKrQntpEocxJ0dJmwbPMTIPeLLysRiQmCX6+j1luwCzvauPkwOKHIKpXLuRV97SE6+c+xBgtP1PtfmqnL0beBs5b8VU7uQCnkxzlyNGRYjcfQFB8s6PiFMVcupcPKyQc/K/b8DQvccnTEYCneMGm5w3NM1bX9GWLtbJNBseHAu+3b8EHdVkTZr1jxK0XaXbU76ethBNMP7ZTXP/1FpXULHs076AV7Urypi1JfFYOR/v5kiYbIrz8Rqes0F0J/rQUDV+HJM3ixgiw/6IiJ6Y+l/N41nMmGYZpfG3IJKZHhZu6MNCkqiMZtdaF3W6p+aJ7javu3MfnjCX9m8ahBVsYKyeTB+OKwL64+aaaFnEgejdRrxPQRKNaMZgIazlpo6QCnR8+5YfP5i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(71200400001)(86362001)(38070700005)(4326008)(64756008)(66556008)(66446008)(66946007)(6512007)(66476007)(6486002)(36756003)(2906002)(2616005)(83380400001)(33656002)(508600001)(8676002)(8936002)(186003)(26005)(122000001)(316002)(6916009)(38100700002)(5660300002)(53546011)(6506007)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rTPn3jAnKxF4+Ry3Yu5y5cBCpjuu3iv/8TpG1ys0WWMFIduaXU4KN6Rznm0z?=
 =?us-ascii?Q?mmwpd63qD1f9eP6NhYiGHXcijrq4xce7XBbXGLMWt75LbO5kJjVOoZRnSUP5?=
 =?us-ascii?Q?aPJPKxnk6vdaYL5GDducejxzzSnZm6OT24wrbpQWUksT5Bx2svByySaaBegG?=
 =?us-ascii?Q?Zv/SQnzEx+Qmd39vsJoN3VW2CWjOLChl7rDee/xpjBkjJR5ddUTHDtbKuaG9?=
 =?us-ascii?Q?6h5J7CBOwXr0fP+0ClZbGhZnopA8uHgHI6LuYZ6h2Ani/5zC+EEx0LVUqr+k?=
 =?us-ascii?Q?+5yZjTfLrSnFzrd30oQIeiQGhXUgqw/kZR6eqXNhE/IZKX4q3KXDHI5e9yGs?=
 =?us-ascii?Q?Wma4kLkwX4QMqvIlWKlCoz9fP2cliDMOcAS3wFEosgDtNk1ZBF8y6x3xiBtZ?=
 =?us-ascii?Q?XRJqpFtm6PYstwKwt2X5RD027Ez0l1NIR9KYpnGATxi7SuADj2cSDEa8e+tP?=
 =?us-ascii?Q?G8sxLbg6uc3IBn5pzywZLuyxYUN5o1RO2ahMjmkgosxEjdC7HG07SQdH8yt3?=
 =?us-ascii?Q?itAP+prDBI7GhvLnP/nqD2F0ByhvLV/rpY6mz5HhFHFjwB4mntkMXdZJvt0D?=
 =?us-ascii?Q?9Niu8vLFCVtzBTyzvgNJvfy8/K2YaMJBhrWLOqoaolPQU9TQOacvhMSYgfu2?=
 =?us-ascii?Q?buypAh7RSAOH31PNZfU/2usTkkdV0z/2A1G/J2CRr+efFK30hhAYLOPYZxAJ?=
 =?us-ascii?Q?iEXACeMtZ5AOsg0O8nDSoC9j18FnCwvGSmI7IVuX4JSjncthQXb21EKfeZhn?=
 =?us-ascii?Q?ryO3+iMnX55EtQesEmw3kIkIQJsgFumVm3iDeU5ZH3ehF9vCvCw4vl+/bTrM?=
 =?us-ascii?Q?6XuFOn/WkLJMln39VXy6+VbGeTEoj/mcfPptTEP5EPegx+11Jo3WWAEEDXOy?=
 =?us-ascii?Q?VJhYE07w/xdLfYJ/TLIhBEWelAccHYlRjCBxv1au6uCpraOMM1oRClMRGqZa?=
 =?us-ascii?Q?em7/tlYyJvmaITB+vyoZBuVkbHFlagJ1TZy9LyKrVjjg+bpfqAAfw3v5V202?=
 =?us-ascii?Q?eT+ZAskxVOlx8zneEMrhAib9rrYwh29Boa6JhQqPmkQPVKriUdN4P8iIMNf6?=
 =?us-ascii?Q?EaWDlRMooF7C4QNSt1ZZLBTYb+KxQPfMelSl3D2q5dEQlBH4vHplNJmR5PKt?=
 =?us-ascii?Q?zULjsKzsCXLv90U5Y92ipQQ1CpK+lBbh1WAt3U7R3S212Z58lHqlaawVqAKv?=
 =?us-ascii?Q?lUBhQ1iSPj7IUIZZFAheStceolRVrqbOq2oGiE3rl2lKRAJ+nZQvLvmH/1L1?=
 =?us-ascii?Q?03xTDp8BxLZE1NZK2V5uQ3BlQdk5qWrgqf011J4Sfcw2AkzstAd0aJQ5DP7y?=
 =?us-ascii?Q?brb6Y8dT4CiXE2hCmG32LSXU3t/Gc/boMJ2eXRDa7rvqhuSsjI1inX9cuWSm?=
 =?us-ascii?Q?ymKGb5Jix1bOHtK1JTt4PoO/feMn2SbTrUlgBREsJWyl7B/7PIFASlfZVs4A?=
 =?us-ascii?Q?lBqC1598IMrTkImjBbNfF7BLDzMLABW+nM4isP0Qhy147cRCLoUtLkFc8K18?=
 =?us-ascii?Q?SlCB0lC/b5IOMVwusLEaU/qCvP3EBzcqbI0Pe7QZF8kiDEyMDHeNTZWqjdoc?=
 =?us-ascii?Q?KTTsa4cEpahdg4ZTyv+oi1i58uQwFwSld3AcqAW1O0rdHwX4s1BNnyVps9MK?=
 =?us-ascii?Q?lAHVICYUZlkGgNmZ/tGuCHQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C73087796AEA3E4F8AEDB6868ABF16ED@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863b112d-6a0b-47f0-ff56-08d9c31b7cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2021 18:15:07.3058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oWNsdYuQyKYolwC3DnbU1NslvulH4PY/TTMNBdazlehnXhJBAkk1AflhmTC7NNDpfbkVi1/tgIbb+sY73a1IOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3784
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10203 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112190114
X-Proofpoint-GUID: -BcKmiIgBLi5biAWIimiV_cTXVlD0Ob8
X-Proofpoint-ORIG-GUID: -BcKmiIgBLi5biAWIimiV_cTXVlD0Ob8
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Dec 18, 2021, at 8:38 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> NFSv4 doesn't need rpcbind, so let's not refuse to start up just because
> the rpcbind registration failed.

Commit 7e55b59b2f32 ("SUNRPC/NFSD: Support a new option for ignoring
the result of svc_register") added vs_rpcb_optnl, which is already
set for nfsd4_version4. Is that not adequate?


> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfsd/nfsctl.c               |  7 ++++++-
> fs/nfsd/nfsd.h                 |  1 +
> fs/nfsd/nfssvc.c               | 18 ++++++++++++++++--
> include/linux/sunrpc/svcsock.h |  5 +++--
> net/sunrpc/svcsock.c           | 14 ++++++++------
> 5 files changed, 34 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 51a49e0cfe37..da9760479acd 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -727,6 +727,7 @@ static ssize_t __write_ports_addfd(char *buf, struct =
net *net, const struct cred
> 	char *mesg =3D buf;
> 	int fd, err;
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	int flags =3D SVC_SOCK_DEFAULTS;
>=20
> 	err =3D get_int(&mesg, &fd);
> 	if (err !=3D 0 || fd < 0)
> @@ -741,7 +742,11 @@ static ssize_t __write_ports_addfd(char *buf, struct=
 net *net, const struct cred
> 	if (err !=3D 0)
> 		return err;
>=20
> -	err =3D svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT, c=
red);
> +	if (!nfsd_rpcbind_error_is_fatal())
> +		flags |=3D SVC_SOCK_RPCBIND_NOERR;
> +
> +	err =3D svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT,
> +			  flags, cred);
> 	if (err < 0) {
> 		nfsd_destroy(net);
> 		return err;
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 498e5a489826..e0356d3ecf65 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -134,6 +134,7 @@ int nfsd_vers(struct nfsd_net *nn, int vers, enum ver=
s_op change);
> int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op=
 change);
> void nfsd_reset_versions(struct nfsd_net *nn);
> int nfsd_create_serv(struct net *net);
> +extern bool nfsd_rpcbind_error_is_fatal(void);
>=20
> extern int nfsd_max_blksize;
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 6815c70b06af..6f22c72f340d 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -289,17 +289,21 @@ static int nfsd_init_socks(struct net *net, const s=
truct cred *cred)
> {
> 	int error;
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	int flags =3D SVC_SOCK_DEFAULTS;
>=20
> 	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
> 		return 0;
>=20
> +	if (!nfsd_rpcbind_error_is_fatal())
> +		flags |=3D SVC_SOCK_RPCBIND_NOERR;
> +
> 	error =3D svc_create_xprt(nn->nfsd_serv, "udp", net, PF_INET, NFS_PORT,
> -					SVC_SOCK_DEFAULTS, cred);
> +				flags, cred);
> 	if (error < 0)
> 		return error;
>=20
> 	error =3D svc_create_xprt(nn->nfsd_serv, "tcp", net, PF_INET, NFS_PORT,
> -					SVC_SOCK_DEFAULTS, cred);
> +				flags, cred);
> 	if (error < 0)
> 		return error;
>=20
> @@ -340,6 +344,16 @@ static void nfsd_shutdown_generic(void)
> 	nfsd_file_cache_shutdown();
> }
>=20
> +static bool nfsd_rpcbind_error_fatal =3D false;
> +module_param(nfsd_rpcbind_error_fatal, bool, 0644);
> +MODULE_PARM_DESC(nfsd_rpcbind_error_fatal,
> +		 "rpcbind errors are fatal when starting nfsd.");
> +
> +bool nfsd_rpcbind_error_is_fatal(void)
> +{
> +	return nfsd_rpcbind_error_fatal;
> +}
> +
> /*
>  * Allow admin to disable lockd. This would typically be used to allow (e=
.g.)
>  * a userspace NLM server of some sort to be used.
> diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsoc=
k.h
> index bcc555c7ae9c..f34c222cee9d 100644
> --- a/include/linux/sunrpc/svcsock.h
> +++ b/include/linux/sunrpc/svcsock.h
> @@ -61,8 +61,8 @@ void		svc_drop(struct svc_rqst *);
> void		svc_sock_update_bufs(struct svc_serv *serv);
> bool		svc_alien_sock(struct net *net, int fd);
> int		svc_addsock(struct svc_serv *serv, const int fd,
> -					char *name_return, const size_t len,
> -					const struct cred *cred);
> +			    char *name_return, const size_t len, int flags,
> +			    const struct cred *cred);
> void		svc_init_xprt_sock(void);
> void		svc_cleanup_xprt_sock(void);
> struct svc_xprt *svc_sock_create(struct svc_serv *serv, int prot);
> @@ -74,5 +74,6 @@ void		svc_sock_destroy(struct svc_xprt *);
> #define SVC_SOCK_DEFAULTS	(0U)
> #define SVC_SOCK_ANONYMOUS	(1U << 0)	/* don't register with pmap */
> #define SVC_SOCK_TEMPORARY	(1U << 1)	/* flag socket as temporary */
> +#define SVC_SOCK_RPCBIND_NOERR	(1U << 2)	/* Ignore pmap errors */
>=20
> #endif /* SUNRPC_SVCSOCK_H */
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 478f857cdaed..7f5b12a50bf9 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1309,14 +1309,15 @@ static struct svc_sock *svc_setup_socket(struct s=
vc_serv *serv,
> 	inet =3D sock->sk;
>=20
> 	/* Register socket with portmapper */
> -	if (pmap_register)
> +	if (pmap_register) {
> 		err =3D svc_register(serv, sock_net(sock->sk), inet->sk_family,
> 				     inet->sk_protocol,
> 				     ntohs(inet_sk(inet)->inet_sport));
>=20
> -	if (err < 0) {
> -		kfree(svsk);
> -		return ERR_PTR(err);
> +		if (err < 0 && !(flags & SVC_SOCK_RPCBIND_NOERR)) {
> +			kfree(svsk);
> +			return ERR_PTR(err);
> +		}
> 	}
>=20
> 	svsk->sk_sock =3D sock;
> @@ -1364,6 +1365,7 @@ EXPORT_SYMBOL_GPL(svc_alien_sock);
>  * @fd: file descriptor of the new listener
>  * @name_return: pointer to buffer to fill in with name of listener
>  * @len: size of the buffer
> + * @flags: flags argument for svc_setup_socket()
>  * @cred: credential
>  *
>  * Fills in socket name and returns positive length of name if successful=
.
> @@ -1371,7 +1373,7 @@ EXPORT_SYMBOL_GPL(svc_alien_sock);
>  * value.
>  */
> int svc_addsock(struct svc_serv *serv, const int fd, char *name_return,
> -		const size_t len, const struct cred *cred)
> +		const size_t len, int flags, const struct cred *cred)
> {
> 	int err =3D 0;
> 	struct socket *so =3D sockfd_lookup(fd, &err);
> @@ -1395,7 +1397,7 @@ int svc_addsock(struct svc_serv *serv, const int fd=
, char *name_return,
> 	err =3D -ENOENT;
> 	if (!try_module_get(THIS_MODULE))
> 		goto out;
> -	svsk =3D svc_setup_socket(serv, so, SVC_SOCK_DEFAULTS);
> +	svsk =3D svc_setup_socket(serv, so, flags);
> 	if (IS_ERR(svsk)) {
> 		module_put(THIS_MODULE);
> 		err =3D PTR_ERR(svsk);
> --=20
> 2.33.1
>=20

--
Chuck Lever



