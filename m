Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3333A0535
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 22:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhFHUnq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 16:43:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63516 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234000AbhFHUnq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 16:43:46 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 158Kd9Tu029308;
        Tue, 8 Jun 2021 20:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=X+QlOmefEC+KaUGdveBK+fiZwYgrxKhb4Yb0z+6YtLU=;
 b=QM5MsVwYqwWVDK6L7vFzE37pWy4Difbz7iZD08P/TK7D1AHSOPn2hGA9uIoaDRVvTdFG
 lZl3nYjSQDb+U0QQRbfhoXjGkZph4SO49Cp0BOwPBxEH5L4gW7Ddzgpjhbwxzrg2FZJE
 NUjeSxPGrrEovX+mUF3Sse31/ZKHhiJ9m1VVKQhe3CHm4tVWn8fbrwHMRJXnmsh+4ajV
 Yw9Bk2B/JoTG7hYa4gSBARfX7NlcBGDptdzTHLTrAmZoW7QUH/9WNNjW0eW/8f51CTLo
 2FGUqtTbefuhGYmcpzveD6ItF/JQ1hsZKHKCAoMxJggsxVS/lv6YVLoRZmvhFpRav+Vu Ww== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3917pwgtdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 20:41:47 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 158Kanb4093552;
        Tue, 8 Jun 2021 20:41:47 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by aserp3020.oracle.com with ESMTP id 3922wt0ydb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 20:41:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNwaImXZIn7P1vxFJhbByrXyFDtTLpOCmEellv/ttIDUcCwmjYR5Fc73EAQd+r2D1XXajuFeJ9FH4jnnhlCGlL/8T9xu/IlXL5OeWIMdMyqOw/hZtCCeVtyDaDYEnExSSZq+4R5MudsUSRTg982CDwxAN3iqCA52g4wX6HS1Vv/qk1Uu2xjGD411jFMlFvzz8IKyQ7FBvHl/CvbSna5tzUuFLSdFCBU+MRQLkvUrFXlW1cMDTkNW4UBcH0BUNO3HE5mQaM+2VAWfKOsh+hbFGgvpZoR9glq2Hs5RSaO+HD1xrMapTJBpynJR4Uh5Shx1P6z8Y58abSbcywGGnAzuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+QlOmefEC+KaUGdveBK+fiZwYgrxKhb4Yb0z+6YtLU=;
 b=m6/FxlBd0Y5aUcy/SPGRK8pONmOsmYFlQqUR4dehPSavZPKnRSONcET1BnMIl6mwHuwPNy9D/XnhQxJMZgf2U3IVO86hYT/TFxNloRRDpRYv+UE8l3vm6ytboIoXuaSLQq5enRMowk8YuRLthSlTgX9mgZIujqV3nibbCdxsK44/uWsiYIVU62WU+A5myZfajc14aGLzo71P+x20Lynf2K0sj45h1VlVbQGQgb0ofL6ezsIbSomfK5QWGrbOmgGA+OoOXyzasSbdt4tzNDbAB/hFOir5Sj5BaXV/xCnpWL7rOxGXF3hArLq5nS1qPF/eRg1jCiPQgZgq6vlXoOLb+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+QlOmefEC+KaUGdveBK+fiZwYgrxKhb4Yb0z+6YtLU=;
 b=NgmPUI8mp06Dst9gDWg0znREdWPoYsznswm0gjXTyQTy/1JmUHAnnSKnm+FriU5sIJNDDVQ/wbGqzINZILG5oGdXbo2YHVeAni13u3WMxDA75/jBtUbF2qj/9EftpPef8pIiiNujISxXiy7mZv6/HgzVftzG1Vvee0SmsNPAfaQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3607.namprd10.prod.outlook.com (2603:10b6:a03:121::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 8 Jun
 2021 20:41:45 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 20:41:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Topic: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Index: AQHXXJcuZUvoeConRke8rYs7QSDzPasKlDQA
Date:   Tue, 8 Jun 2021 20:41:45 +0000
Message-ID: <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com>
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c5772fb-4fd8-4a12-5e16-08d92abdd483
x-ms-traffictypediagnostic: BYAPR10MB3607:
x-microsoft-antispam-prvs: <BYAPR10MB360768FA76494FF1DDE4336F93379@BYAPR10MB3607.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IoV+/653D8qpovA5+QcVp/6Rogr3U6yuIRMs1eX1Saa56piP3EQrYiddG/GEi/S9L0xcymHIBMMdnTkpJ1K+d0ZhU1DckLYTY9+vsrMJPtazv9OMQWxSL0T09Ydb3XJ04XuLhEqkO4UKXMAE51AFJeuReunuhsf7bsNkzobVYOrOCliyvKtnq/Q//VbgT7koyWJ8yG/07ZC9/k4qYmSd2zgH9nSLTgJpg5mjBAA7VK/f9wwY1zWmOBu2eD0sWZNfoCa5coPRU/oEPliFE7fFVc1rjcuFKufCFCCqhKqlZ2KVo05drAmipu0lklRDDp1kY2k2Xa3BnwdC9BPaOFZpKnaZZtC/dHEQ8P2WY7SWkOsg7ayp/cFcUXgRwqgtKE88cm7KkKzvDkd4gXphBKqj1gmtIDihS1lnz3FooWZduy4/57Ym5gAuQXQgyPXyCF0bXYDEy3W+Ze5Zq+aHuB0wVMh8JZjaPFa6RyEW9OB0xPcl3oeIFbXgIu6diZ73bd5Ql6I7U67wm59JohYyvZKRgZzHj4PJkTpOKziJSyPKDZ1reTd5KAMBLR5k33XIfFlL/T1zJNUyqNUjoR5zumvn7oTOpRBwQUUJTkzaHI6MT3rwDt4cA3Vpl0DqYJzUwQxfFXWBGnoEqXmkeNq+TdrUsceWXMwBRy0Id6vrwJBV5UA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(6916009)(2906002)(33656002)(186003)(54906003)(8936002)(86362001)(6512007)(2616005)(66946007)(5660300002)(66446008)(6506007)(66556008)(316002)(66476007)(26005)(4326008)(91956017)(8676002)(76116006)(478600001)(53546011)(64756008)(38100700002)(122000001)(71200400001)(36756003)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JSyeqPIJ04ofevP/Ui+/5SPxWuQ7YLJDYwOvJ2vKteRav72XBowOz1liij0i?=
 =?us-ascii?Q?erveH+5a3raYSrTHdEZMfmCnU3CypgjO/cdprfJRGX8v2LASwA9HsElcWNwP?=
 =?us-ascii?Q?/zK+0/b9L3d82nMs4KiU+BIGxGqALKA5zhQJOMBCyzLUgfDxedOoxUaTCz63?=
 =?us-ascii?Q?4hVe/+0G2bTY8N65q8FAf6PestU3/gdDhhlcaziqlHLaY65Im3wuD2mlJzAT?=
 =?us-ascii?Q?/HVl3mwF05am2UagB0gjvKHFGxRVdWXvtQcPvY0EONpoxidf7Aqhx6e2ADLh?=
 =?us-ascii?Q?baEN6HK1ZNMNPPpGGGhoV5sjDYzr+E874AlR/RjL7ejzwb/OS1p4FbqPOTbS?=
 =?us-ascii?Q?oQwl0CuvEO6XS8dHZakOv3S9ATVq1JoY0Is3LMlzqC4nOY4PV9wNZbPQ9WCT?=
 =?us-ascii?Q?Up4DhY64U3i4UKxsXelhRCXl6+UxEfrXAOhphrUiLmfJBjXMtbuGcFLjzklB?=
 =?us-ascii?Q?7qjRM23ybh2qW1HuQlN7NWkLnJFaYZy4VRq3vp6CbniyvRxzKX64RgFygG8r?=
 =?us-ascii?Q?27uMyb3qCzenkhBuWpLQCQCNYLxfdUytKOqZJL6m7m9PdvPkxFSQw/+aXtw8?=
 =?us-ascii?Q?LQBKFhGn4Q95hpM/ovJKbC3VVaQ1S+VQIc2EyKH7IFku/NWxZmfJzU+nsLyg?=
 =?us-ascii?Q?SzyLX7FbANeULnrFgNk7fe1cPcnmraxOSwK8tjYTEkr1gupijSo7ccbnHnSM?=
 =?us-ascii?Q?7khVlY+GC4q6E9pPlzJ6bzhIZHy+PUV5frh+pkGp9ToZUq0t1H0oWl0GwWb1?=
 =?us-ascii?Q?MZz9kK67uIrdwIgxYjR2smFVE+u8nhKh7g7Z5lS7cl1V6+YyM8R73SkuVoD4?=
 =?us-ascii?Q?4Vj4Q7TwnId/0qWWkXT/ka5J0bVCRNxSkQzgsWb9iVv4yIzNPVH2ZVDe+DqZ?=
 =?us-ascii?Q?dn9Dqmnqz3x2AqthGwNQ+ieciGrq9ya36MUynalgQ0/cDbGVAMZ6tlD+yq3Y?=
 =?us-ascii?Q?BGc7UKnOscC+B6X+9dhtIycN2UQn3HrqU2Yrp6esTXwys87LiW7jtY9edmDx?=
 =?us-ascii?Q?l4/hgAkbUOsZjiF/r1fWaD7xXCKTl/KOcRjr09pQr5icJulyZ98rOcLd8en9?=
 =?us-ascii?Q?0+pnNPBSeTzoGeEgf7gtw4BWvhgBri5RjJ/D/C/XsVXqfV9s2kfRQnDxdYLV?=
 =?us-ascii?Q?Fs32xxwQ/UrJ6vMbzWroWMQ3M1i3vIFRJbsermTJy9rH5SJ2gUEEhlRV0g5x?=
 =?us-ascii?Q?W4Gql6lTVxdEtzDrgwa2thVsaSkXZ2VObn5EU1AZ7wVAhGtuph7YkVsdH1qn?=
 =?us-ascii?Q?lTMcqVo0Bprcyq2R56DDxdsObDwqxXPhzz4eSjgFwYD3O9CqwDVN/d0TVYCk?=
 =?us-ascii?Q?AmbeUlQyz/oFF+30NbYfIohB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2B40B45B1D5E28448CB726106F65BF2E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5772fb-4fd8-4a12-5e16-08d92abdd483
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 20:41:45.1682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzTc0RZ7EriTPbffFHv0PdHBoLfyKb9VjTfffWA5dqzmvxe8MDLxFMSrSb3mjyHMgKzJbBESKQv6m2eOkhKwBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3607
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080131
X-Proofpoint-ORIG-GUID: TbiqrKZ7ryGYmg_iLRoN4YDgc6rIVJaA
X-Proofpoint-GUID: TbiqrKZ7ryGYmg_iLRoN4YDgc6rIVJaA
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 8, 2021, at 2:45 PM, Olga Kornievskaia <olga.kornievskaia@gmail.co=
m> wrote:
>=20
> From: Olga Kornievskaia <kolga@netapp.com>
>=20
> After trunking is discovered in nfs4_discover_server_trunking(),
> add the transport to the old client structure before destroying
> the new client structure (along with its transport).
>=20
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
> fs/nfs/nfs4client.c | 40 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 40 insertions(+)
>=20
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 42719384e25f..984c851844d8 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -361,6 +361,44 @@ static int nfs4_init_client_minor_version(struct nfs=
_client *clp)
> 	return nfs4_init_callback(clp);
> }
>=20
> +static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *ol=
d)
> +{
> +	struct sockaddr_storage clp_addr, old_addr;
> +	struct sockaddr *clp_sap =3D (struct sockaddr *)&clp_addr;
> +	struct sockaddr *old_sap =3D (struct sockaddr *)&old_addr;
> +	size_t clp_salen, old_salen;
> +	struct xprt_create xprt_args =3D {
> +		.ident =3D old->cl_proto,
> +		.net =3D old->cl_net,
> +		.servername =3D old->cl_hostname,
> +	};
> +	struct nfs4_add_xprt_data xprtdata =3D {
> +		.clp =3D old,
> +	};
> +	struct rpc_add_xprt_test rpcdata =3D {
> +		.add_xprt_test =3D old->cl_mvops->session_trunk,
> +		.data =3D &xprtdata,
> +	};
> +
> +	if (clp->cl_proto !=3D old->cl_proto)
> +		return;
> +	clp_salen =3D rpc_peeraddr(clp->cl_rpcclient, clp_sap, sizeof(clp_addr)=
);
> +	old_salen =3D rpc_peeraddr(old->cl_rpcclient, old_sap, sizeof(old_addr)=
);
> +
> +	if (clp_addr.ss_family !=3D old_addr.ss_family)
> +		return;
> +
> +	xprt_args.dstaddr =3D clp_sap;
> +	xprt_args.addrlen =3D clp_salen;
> +
> +	xprtdata.cred =3D nfs4_get_clid_cred(old);
> +	rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
> +			  rpc_clnt_setup_test_and_add_xprt, &rpcdata);

Is there an upper bound on the number of transports that
are added to the NFS client's switch?


> +
> +	if (xprtdata.cred)
> +		put_cred(xprtdata.cred);
> +}
> +
> /**
>  * nfs4_init_client - Initialise an NFS4 client record
>  *
> @@ -434,6 +472,8 @@ struct nfs_client *nfs4_init_client(struct nfs_client=
 *clp,
> 		 * won't try to use it.
> 		 */
> 		nfs_mark_client_ready(clp, -EPERM);
> +		if (old->cl_mvops->session_trunk)
> +			nfs4_add_trunk(clp, old);
> 	}
> 	clear_bit(NFS_CS_TSM_POSSIBLE, &clp->cl_flags);
> 	nfs_put_client(clp);
> --=20
> 2.27.0
>=20

--
Chuck Lever



