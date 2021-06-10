Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B973A2D0B
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 15:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhFJNcQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 09:32:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58020 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230413AbhFJNcP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 09:32:15 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15ADD9oU004592;
        Thu, 10 Jun 2021 13:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1maaiTqKKfCLaSQknDZIiiJgJUD1iHfzBJ/gw8VoGXA=;
 b=j2GTaH0E6WVFoESEOAb8iW8gFJccXLwK4x7bHNMeooDC6yiaGSVa2k+0Szgu0dU65Yry
 gH+gR3IDxt2csQuI9y2c/m5B30COP7SqWAhiTT70p6WqK5UpvVppTd8e8mfuFwqW9q2G
 9kRKLx6z0M2kZriv7qj2jzxeSr1G5U5mfh8gb8LLnm+AXL+DqliL9BYNlNVqAl8Tz4Rd
 4RxZYGAd9wORI1i1W8m3e0Hnts4G4hz74KkA87HmmP8JzqApmm2VwhwsAz47QweEYoAo
 Udc7fl9d462glE4TsOu9lsiiErSv7XzitM2W5fF90kmI6Fx8LUwNYZxnQRoWd1YsXyc8 GQ== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3926dh8xtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 13:30:15 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15ADT4Lv034608;
        Thu, 10 Jun 2021 13:30:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3030.oracle.com with ESMTP id 38yxcwn5my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 13:30:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOujWnfX6sSrJOgNYsGn0+msdqPOnyjsQ5N/BoChmQC7nRoCU6Ov3hCKhIhVaemNENV8JG0VeauXNTHMFFPsnQPX9UQt/3Ft6BD7aWIYgcTye2nSaQWlM9gvVtnrjkMPfWl5KtWIHeYhktOJ+NGWdv8JZfLGG16nJNSYgLrUh2Z2i54lUokdj1MUmom1K59P3QA0Nzw+wsqDq63Diobxx33J/StjscOYwg8gfdZC+JdrOMuQ0lPK7XgueEykk/Y/HK2prMqF2acLF9NLj2jQD4L7BPhsA8iOmrIfGOd0k4ZxhmpgW0hdLS16KFYnPKMLR/KhExM5aL67q4xS/1r7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1maaiTqKKfCLaSQknDZIiiJgJUD1iHfzBJ/gw8VoGXA=;
 b=M/C3nelTrkRJBgaddZ5+uQk2MP4DLt3kZ8jY3h+pS7F0Kyy6kpbPMmN0nka/ZdVeUZDUyCnm7cXOF4VB0BjFCMFVjbZRZPnqZECtu84nZIZxw82OIYC8PHZvExeMUUhUCK2llSIkpH6D4JkGsZ5XuGC2s89I9k04WYyEEYTwg6YvI6c33Z5Pqosr4hx0pSmm9C4xn6JkFpIP+y9GJ9XxNEzzGQ3RwFXUfAjR+eVAIgkD4qnQaSvOXyc2fdH8NXc/MOdLGA4OyIO7M1f/0NNQb7hKjCXu5hAU4XbZdPLPlojaPy6qgrJGONF4Mc7a3DhwIFuNQvuki6WzD/g/SeXRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1maaiTqKKfCLaSQknDZIiiJgJUD1iHfzBJ/gw8VoGXA=;
 b=lXo7NLpTORW479ZhYC7hgVwvH4nddEIVkfX2qy3X0/tLcmKq5olEKXndC9BIjDUekjWGQ3TDKRv2/KIg/AmB5sGZmwHaiAtT8zNJxqzQdwntuKrElGOx36bYbIR0nXBdCIyxUpSx+rtqGJBH2e0Ad1fASgJdPdn+518+rzC+ehY=
Received: from CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8)
 by MWHPR1001MB2190.namprd10.prod.outlook.com (2603:10b6:301:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 10 Jun
 2021 13:30:12 +0000
Received: from CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1]) by CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1%7]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 13:30:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Topic: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Index: AQHXXXoN9xSEM+vT7E6aMlyo/90m26sNPoWA
Date:   Thu, 10 Jun 2021 13:30:12 +0000
Message-ID: <6C64456A-931F-4CAD-A559-412A12F0F741@oracle.com>
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
 <20210609215319.5518-3-olga.kornievskaia@gmail.com>
In-Reply-To: <20210609215319.5518-3-olga.kornievskaia@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d37f7439-b2da-416f-5dcc-08d92c13e006
x-ms-traffictypediagnostic: MWHPR1001MB2190:
x-microsoft-antispam-prvs: <MWHPR1001MB2190AE2E01FB3CE1373B083C93359@MWHPR1001MB2190.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hnk5Co8oVMO/32CchqggYvQcHTT+AFk3l17yseeBVGVh+8/qguCPwRt13/mVvcLk9uRT3SvKCBQWRNkESgYBv10SfgGhFSpmBlfAnVqak7cEjXp9P2B//9T5f5tiP7pKoeVviPxI9SlgBdFpiPB18LKD/9oWJjUZ3ARC0QWjGrQ8xt3u7Vzzpk0Hy/xOLzEc7EyE+C3PvaQlwHSkdKsasVHX7HeObU0OTMzUSPjdXqrMXMYsKdteKN82RQkRr6cjtkt78zV5APVGlhaprDoBm6QUxWL+yrS6Gv0xbu+uYv94pZAvPVsyFH/5jiKBBt2xvq0wkfoZnuxMHcaT5M5F1a2JOYNQ8pvzHQjGadW8D68fEqlG1w10qu5RlzqkgcSUQNCryWd8a9Fq5wkq4yr/0x5Sp7QH3t54IexPff46UHAsSvUCsUUD7mHt0o1w5pQl6OY2QAL3XS1Zf29CMhGgEKAE2rtmGmXATIe8Ypn6ivvbvjbI608ar6/WdYuSUKBl7AzcYul9YL3W6+CoS8kZfNxS/EKajh/6RVBro0ixE8E5KtJDdG4+Pr177D8KZByFQGvAiWNj+2XteqOmzlWuRetiHw4/U1CP7VjKQPMoR2duST4jIBqmP1hhB8r/4Y6+7BKZZld5nx4dXNVflb0yP4wZID8XSl131m5UF92fujw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4673.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(396003)(376002)(346002)(6512007)(66446008)(66476007)(66556008)(86362001)(2616005)(8936002)(316002)(76116006)(6486002)(91956017)(478600001)(53546011)(83380400001)(38100700002)(36756003)(26005)(66946007)(71200400001)(6916009)(186003)(5660300002)(33656002)(4326008)(122000001)(64756008)(6506007)(2906002)(8676002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xqkHOE92S6I3IrE8v77uenbdcc74ijRoSZvMmli8Az5IY8iDwgmMH7d2yQGr?=
 =?us-ascii?Q?g5uXdsdWx74BVDN2MrX++4MIp7Z3PMSM61VSdVU5S+XWZFNaRVEZ5HBRmz3g?=
 =?us-ascii?Q?t3rOeOs6FUN3qP5Qxwcty+8TK+4u16IGza14bztOX/IA3tSs9VzFjns4y9Ft?=
 =?us-ascii?Q?sUVgrzvAHzFLeykQq50yHXs4EbjizhkrH/wSr9o65xGWYkk3KHHcIljYSaAb?=
 =?us-ascii?Q?VWFXO1jkRxS8kYC0bfVpX8ndvkMNe0iywhQBe+Byu5x3kOoNo9TV4YJSli0l?=
 =?us-ascii?Q?O7Cjrqp4cFlaFrZ4VxRIYciXtatwPk4OlwftcAZYKbJub0ry7eX5t65ZxXRc?=
 =?us-ascii?Q?y75ABX4a+0ZPghYUCaILjA8kNdgOTz7B5mnw3MhRNewAiAfxuJl4Zp4qYzhg?=
 =?us-ascii?Q?LlB5qB7f4hDIczOq6qFWvrVSLGq8nCAZErgCXiMaEphlolVvjWBMprmWiUfC?=
 =?us-ascii?Q?lHAZj/KpShEl9tJ+gsPZUoIheKVtZcvn0hlnRH4NgQwDHT/liAwe2HkH4xEF?=
 =?us-ascii?Q?yzB8iP5kS6CKSQgGAp/HLdtrmn/wHIO9TGqtUaJX9RDbE9QMrItrgSF5B74j?=
 =?us-ascii?Q?zgZ4gl2WkCxBPy1IZdGjHYLf3QSqI7uHmVsCOldodvXivhVJNaEdEcZ9p8EN?=
 =?us-ascii?Q?DSS97Cb6+wr6X00+2ZYY4E4eSUcdFQaFl4kqUbyXpyQlOqrWdO678k+XEqwW?=
 =?us-ascii?Q?HyDReJ/c/LBQNgLe+JVN5wVZBG0F9aOxhRsukG8uXYvnXBbsjma0xjxjS8eZ?=
 =?us-ascii?Q?w05pFLsaGWxDyL+T/si/N1vhrquwftFyiMrTx5ZzERlaPCA4i7U+hV1cdaIy?=
 =?us-ascii?Q?NMCKIZjGCTR+3H32GhP5QuOFllAAs8dorEN0nmEXJ1Gb83EWSYhwKinN3Adb?=
 =?us-ascii?Q?8W3Cb1bHsbCMFSxlCiX8puEH4yfy+qRmAiJscRo+Eg+LyUnVNpxIKEg6f+Vs?=
 =?us-ascii?Q?ubLRJXImU0RyyWV/wWR600tf9E23d/+HjXySrDbJWCIkDLY7FfC3MpB580Am?=
 =?us-ascii?Q?Us5GmVKQ4tRMDdE5AB6ifpEYupnCWsRTULnFz3TuIOOAgBecLivumQS6sv1k?=
 =?us-ascii?Q?8mwZXF4d6XFG/H2bKzNVXEnRl3jm14SCNZBfrnfPbCfeV1DEmrddPpe7nfMW?=
 =?us-ascii?Q?9cmYRBFUgzSSDDDNECDkBaaAI3Jo/kFOoafPnRhtm6yg8wPQZWpogPls4Wo6?=
 =?us-ascii?Q?GvovP5h9xi6IVvByedc0qIj6jrEDRz1RoauNV2NL9KGG5fu5AM1Njken6xtV?=
 =?us-ascii?Q?EV+hprlvarylRteLuXUhlsGVRQMEN+0l5x52KWBqTkhWcSYM15mbnqKkCcfQ?=
 =?us-ascii?Q?iKaq+PdfeZZHibdEVpGhxCJF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD28205B14DDBE40BA004F0D362B503A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4673.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37f7439-b2da-416f-5dcc-08d92c13e006
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 13:30:12.2547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4gEJ1+uiZOuvTvXCQG+kJ4+nmgnDt/w7lmJhGg3xDoJA+Qq9SEHBfHyRK0ICM4gBciPk2BWdrag+8vAl5HNqFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2190
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100086
X-Proofpoint-ORIG-GUID: tAaE-zcA1D67tXNhS1GCDt0ifRloAB5P
X-Proofpoint-GUID: tAaE-zcA1D67tXNhS1GCDt0ifRloAB5P
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 9, 2021, at 5:53 PM, Olga Kornievskaia <olga.kornievskaia@gmail.co=
m> wrote:
>=20
> From: Olga Kornievskaia <kolga@netapp.com>
>=20
> This option will control up to how many xprts can the client
> establish to the server. This patch parses the value and sets
> up structures that keep track of max_connect.
>=20
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
> fs/nfs/client.c           |  1 +
> fs/nfs/fs_context.c       |  8 ++++++++
> fs/nfs/internal.h         |  2 ++
> fs/nfs/nfs4client.c       | 12 ++++++++++--
> fs/nfs/super.c            |  2 ++
> include/linux/nfs_fs_sb.h |  1 +
> 6 files changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 330f65727c45..486dec59972b 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -179,6 +179,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_=
client_initdata *cl_init)
>=20
> 	clp->cl_proto =3D cl_init->proto;
> 	clp->cl_nconnect =3D cl_init->nconnect;
> +	clp->cl_max_connect =3D cl_init->max_connect ? cl_init->max_connect : 1=
;

So, 1 is the default setting, meaning the "add another transport"
facility is disabled by default. Would it be less surprising for
an admin to allow some extra connections by default?


> 	clp->cl_net =3D get_net(cl_init->net);
>=20
> 	clp->cl_principal =3D "*";
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index d95c9a39bc70..cfbff7098f8e 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -29,6 +29,7 @@
> #endif
>=20
> #define NFS_MAX_CONNECTIONS 16
> +#define NFS_MAX_TRANSPORTS 128

This maximum seems excessive... again, there are diminishing
returns to adding more connections to the same server. what's
wrong with re-using NFS_MAX_CONNECTIONS for the maximum?

As always, I'm a little queasy about adding yet another mount
option. Are there real use cases where a whole-client setting
(like a sysfs attribute) would be inadequate? Is there a way
the client could figure out a reasonable maximum without a
human intervention, say, by counting the number of NICs on
the system?


> enum nfs_param {
> 	Opt_ac,
> @@ -60,6 +61,7 @@ enum nfs_param {
> 	Opt_mountvers,
> 	Opt_namelen,
> 	Opt_nconnect,
> +	Opt_max_connect,
> 	Opt_port,
> 	Opt_posix,
> 	Opt_proto,
> @@ -158,6 +160,7 @@ static const struct fs_parameter_spec nfs_fs_paramete=
rs[] =3D {
> 	fsparam_u32   ("mountvers",	Opt_mountvers),
> 	fsparam_u32   ("namlen",	Opt_namelen),
> 	fsparam_u32   ("nconnect",	Opt_nconnect),
> +	fsparam_u32   ("max_connect",	Opt_max_connect),
> 	fsparam_string("nfsvers",	Opt_vers),
> 	fsparam_u32   ("port",		Opt_port),
> 	fsparam_flag_no("posix",	Opt_posix),
> @@ -770,6 +773,11 @@ static int nfs_fs_context_parse_param(struct fs_cont=
ext *fc,
> 			goto out_of_bounds;
> 		ctx->nfs_server.nconnect =3D result.uint_32;
> 		break;
> +	case Opt_max_connect:
> +		if (result.uint_32 < 1 || result.uint_32 > NFS_MAX_TRANSPORTS)
> +			goto out_of_bounds;
> +		ctx->nfs_server.max_connect =3D result.uint_32;
> +		break;
> 	case Opt_lookupcache:
> 		switch (result.uint_32) {
> 		case Opt_lookupcache_all:
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index a36af04188c2..66fc936834f2 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -67,6 +67,7 @@ struct nfs_client_initdata {
> 	int proto;
> 	u32 minorversion;
> 	unsigned int nconnect;
> +	unsigned int max_connect;
> 	struct net *net;
> 	const struct rpc_timeout *timeparms;
> 	const struct cred *cred;
> @@ -121,6 +122,7 @@ struct nfs_fs_context {
> 		int			port;
> 		unsigned short		protocol;
> 		unsigned short		nconnect;
> +		unsigned short		max_connect;
> 		unsigned short		export_path_len;
> 	} nfs_server;
>=20
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 42719384e25f..640c8235d817 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -863,6 +863,7 @@ static int nfs4_set_client(struct nfs_server *server,
> 		const char *ip_addr,
> 		int proto, const struct rpc_timeout *timeparms,
> 		u32 minorversion, unsigned int nconnect,
> +		unsigned int max_connect,
> 		struct net *net)
> {
> 	struct nfs_client_initdata cl_init =3D {
> @@ -881,6 +882,8 @@ static int nfs4_set_client(struct nfs_server *server,
>=20
> 	if (minorversion =3D=3D 0)
> 		__set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
> +	else
> +		cl_init.max_connect =3D max_connect;
> 	if (proto =3D=3D XPRT_TRANSPORT_TCP)
> 		cl_init.nconnect =3D nconnect;
>=20
> @@ -950,8 +953,10 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_ser=
ver *mds_srv,
> 		return ERR_PTR(-EINVAL);
> 	cl_init.hostname =3D buf;
>=20
> -	if (mds_clp->cl_nconnect > 1 && ds_proto =3D=3D XPRT_TRANSPORT_TCP)
> +	if (mds_clp->cl_nconnect > 1 && ds_proto =3D=3D XPRT_TRANSPORT_TCP) {
> 		cl_init.nconnect =3D mds_clp->cl_nconnect;
> +		cl_init.max_connect =3D mds_clp->cl_max_connect;
> +	}
>=20
> 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
> 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
> @@ -1120,6 +1125,7 @@ static int nfs4_init_server(struct nfs_server *serv=
er, struct fs_context *fc)
> 				&timeparms,
> 				ctx->minorversion,
> 				ctx->nfs_server.nconnect,
> +				ctx->nfs_server.max_connect,
> 				fc->net_ns);
> 	if (error < 0)
> 		return error;
> @@ -1209,6 +1215,7 @@ struct nfs_server *nfs4_create_referral_server(stru=
ct fs_context *fc)
> 				parent_server->client->cl_timeout,
> 				parent_client->cl_mvops->minor_version,
> 				parent_client->cl_nconnect,
> +				parent_client->cl_max_connect,
> 				parent_client->cl_net);
> 	if (!error)
> 		goto init_server;
> @@ -1224,6 +1231,7 @@ struct nfs_server *nfs4_create_referral_server(stru=
ct fs_context *fc)
> 				parent_server->client->cl_timeout,
> 				parent_client->cl_mvops->minor_version,
> 				parent_client->cl_nconnect,
> +				parent_client->cl_max_connect,
> 				parent_client->cl_net);
> 	if (error < 0)
> 		goto error;
> @@ -1321,7 +1329,7 @@ int nfs4_update_server(struct nfs_server *server, c=
onst char *hostname,
> 	error =3D nfs4_set_client(server, hostname, sap, salen, buf,
> 				clp->cl_proto, clnt->cl_timeout,
> 				clp->cl_minorversion,
> -				clp->cl_nconnect, net);
> +				clp->cl_nconnect, clp->cl_max_connect, net);
> 	clear_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status);
> 	if (error !=3D 0) {
> 		nfs_server_insert_lists(server);
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index fe58525cfed4..e65c83494c05 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -480,6 +480,8 @@ static void nfs_show_mount_options(struct seq_file *m=
, struct nfs_server *nfss,
> 	if (clp->cl_nconnect > 0)
> 		seq_printf(m, ",nconnect=3D%u", clp->cl_nconnect);
> 	if (version =3D=3D 4) {
> +		if (clp->cl_max_connect > 1)
> +			seq_printf(m, ",max_connect=3D%u", clp->cl_max_connect);
> 		if (nfss->port !=3D NFS_PORT)
> 			seq_printf(m, ",port=3D%u", nfss->port);
> 	} else
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index d71a0e90faeb..2a9acbfe00f0 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -62,6 +62,7 @@ struct nfs_client {
>=20
> 	u32			cl_minorversion;/* NFSv4 minorversion */
> 	unsigned int		cl_nconnect;	/* Number of connections */
> +	unsigned int		cl_max_connect; /* max number of xprts allowed */
> 	const char *		cl_principal;  /* used for machine cred */
>=20
> #if IS_ENABLED(CONFIG_NFS_V4)
> --=20
> 2.27.0
>=20

--
Chuck Lever



