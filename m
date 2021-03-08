Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EF13312D0
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Mar 2021 17:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCHQEJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Mar 2021 11:04:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41596 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhCHQDi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Mar 2021 11:03:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 128FxPeS104552;
        Mon, 8 Mar 2021 16:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=0c5NDgUt6KwSAzmEi7Voi/eTfHplgUp5FozjoRzLAYc=;
 b=rk7z5n5igewCdsR9sY7Irs9dav/n56dZxT6lb47qZMbfyxVFeG5Xkv7AcPM13KwnQoTl
 miOozTzCVa1cArju87CuUFcVoJTBKvPZLU9Hhs/DNesYdC/234ybf/9Anmw78/kAXULR
 agZx//j6imA0uEzfuftVHFwXIf0Cvx3lXf57d3S9QBKWRdpn3OBpUQWTYaRx4103+of5
 Tm3HVZ3Rk+cEo5mELcxOMKw0WoKHITzcg1LR7ZE+ZIx07Se8zgYR78TC0XE47TMeVG1k
 zz+93czQ9uN+wVvYJffPDWsqHb7mK8zCMBWUM23G3yUROogRmgyrz2Fe3BopcQHsLdaS mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 3742cn41r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Mar 2021 16:03:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 128G0wJL171929;
        Mon, 8 Mar 2021 16:03:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3020.oracle.com with ESMTP id 374kgqfqtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Mar 2021 16:03:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpSCg3l/jCkEIUMM3ofUcNBJxWwL2PAOF8jxhOa4Q0ZGR3gGN561QSVfzS2gsasdstnGN/HYYsV2XJEty7XjrWyIsA27dOQda/K7VK3HXFMxoGBvbjRSBp3RBLFYBMuscCgH8w4d8DJyiQhzho6We5+O5m1m41YuhQt9kAZkQRRVJ5gsCw8XytYgC4cYUhEgFXu6oLT33yinODPiA0Bej1eOYFAQ5R9ea3eBod6+WYEPyGfSyG4VDJ5Dxw5Ysl34pwt6SOCUtMVQURD1ye70iYrfem22FbhekuHDeIIDNrxPEoOUqoMBjU/lOiSuj0T22N6vGyHhQSh0XxGoCuMWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c5NDgUt6KwSAzmEi7Voi/eTfHplgUp5FozjoRzLAYc=;
 b=N7LZ+IUsJ0KcpqyH8C2M6X4KijQnMDz2NxoU38EUpFvrGYD5JURiCf3mIWkTnZ6eTbIAL643IJqQCTEQUwO4Mnlz1yFjlex/3SHxoEcTz1mnLFMls+xUsLWAe37aRPj+z2F5Q2lBs1YC0Xd0f8boMvUyKCMiYDiJpVuY0YKTNVIVVO3q0F2RfQjE6OJ9w72s736xmXbn5qUK9gGz0ndzBUDm5lROr0cI8OiK5SKkFW/GKhjzyeYYm03rV+mCLVeJWTAACGVYRC4phyICUJ9D9xUSXHi78pqSEskRmSfZu6zu/kaonfGIYETvEpvKRH5yWjLPSTk/HZMndXNYXLRAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c5NDgUt6KwSAzmEi7Voi/eTfHplgUp5FozjoRzLAYc=;
 b=u1NH+vMdByxmahNaq8JMQ/XXkQVNaKRzUs6GK+jAOUG8qBdTgMC+NdNZIy7rEq6Fn1PV0W1REi6YUH8HbPD+aohBrWiwzGgS5lb1//oqJOAh5aYMyQeBs/MSdYh5FlNflVtDylE/hrmp2evdDFx/PkAwoR1PFDsUsQVFWDqR5VU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2565.namprd10.prod.outlook.com (2603:10b6:a02:b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Mon, 8 Mar
 2021 16:03:31 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 16:03:31 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: dst server needs to unmount src server's export
 after copy is done.
Thread-Topic: [PATCH] NFSD: dst server needs to unmount src server's export
 after copy is done.
Thread-Index: AQHXEEhPoGFYV6g8wE+zCNesw4ToFap6SJqA
Date:   Mon, 8 Mar 2021 16:03:31 +0000
Message-ID: <5018A43B-8132-4882-9F16-37CFD475807D@oracle.com>
References: <20210302194843.98612-1-dai.ngo@oracle.com>
In-Reply-To: <20210302194843.98612-1-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad88421b-24dc-4749-f2a8-08d8e24bb881
x-ms-traffictypediagnostic: BYAPR10MB2565:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB2565BF31B4D8517EE0C67C2B93939@BYAPR10MB2565.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hU77O31MvE0tAjLSyqgrRVAlhHRCykwNGZQgLdyi7N6h0Hs4o9ut4IQ77EEidv6qESRtEGDIIuFcMidGqj0eiIW1edTyJKtU6J85e9vNMPQ06lfQmHa8t3e852SlKsJMOx/y8OFKznqbQfFwz/AB4/9xPw3NRC0D0/6bph6iaZN5zp9ypj+WJ+LSWn1yi/MVt1w7ynGNta2CgkZaZaCh8DpE8/4mV/JIacsT1X8k3Es5rF8yKUp/3fpZ4gpmaRmYSBruHhONwSia3TkO4AYZMRRqQK8r/0uVx8Qs/xVZRoPgiYBnjMtf47gbHzSUkat4/mVV78YXuWYSns6kS6puXhnoC9RWVbqRqAEYkeKi1J4S+LUpc/98ZTv/eCyd5gSP3+DaL03DJ9IcxgSWaG90h+si0k3fDmdQcTICAFkMaTNopLGzTIUfH/d2aZdl+H37FJoGgHlVrdNlm4Lh93CwoPoa25nrSKbf3+cCKSynlNhGa9HdfrjAnLIlGaVS8EDgKyXBrZbEf4/J508YyXoIPdGf2UO9zvBxlN+uwZGDaQyQACHGXxTGb1yJLbAwxnItS78FsMjTGNhRM/T6IRfJYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(396003)(136003)(376002)(8936002)(6512007)(33656002)(53546011)(44832011)(6506007)(71200400001)(478600001)(5660300002)(54906003)(66556008)(66476007)(66446008)(66946007)(64756008)(6636002)(76116006)(91956017)(316002)(6862004)(8676002)(4326008)(86362001)(6486002)(37006003)(2616005)(83380400001)(186003)(2906002)(36756003)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FO7Hyx6KP2OYgkkCbHwBiRINNxWKHJqJsUl6//sQAWWjdZIuJgVp256l+YDZ?=
 =?us-ascii?Q?d6TY66zAc7Ml6/3CvxA8cjqOSJFDCo/dWFMLCWNd0dEj18B+M4xmzPlPid3F?=
 =?us-ascii?Q?lE7loJCB9+8Oe42QRJyC3pJd2QtIIeDgzNEyV2Ll3gHE6tdqXLf7BiBbTgvb?=
 =?us-ascii?Q?qSQ9zOAmwtWhDLunCsZnGdfDZhf3/eYAUj9HM7Qzygbox05NQbiK78PunRln?=
 =?us-ascii?Q?TmOsUUOzPuuHTA+cR9syHTxK/GnbQr0uVjiXSFc3YUQInP76MqSRXWvOtrtH?=
 =?us-ascii?Q?V5hjYM2dgm2XOEBSiPyFgcCxVlkWcdfq9aRbr/rRzg4YDasLvDCrATbU3z1B?=
 =?us-ascii?Q?zSrq1LuYGspJ2ai0Rgxc1dRrntzf/h7oq6QcIc3BNutlPS948ENDzAUYaCT6?=
 =?us-ascii?Q?bZp1lxERvBkLhlgB1JT/yzQy3S83/bNwGR+Xo2c1gN7297nqaUB2/1WfcOXN?=
 =?us-ascii?Q?Yz+dzsLybnLgri7hrjWhTBaWED8UwUdnZCgtliu7/DIOKOZ1ayXzz22xABVj?=
 =?us-ascii?Q?h+6i/2yrAuEBNBXdddceZnyqKfWCxYsGFIoaiM5XllWBBy2qg1MTNbRIwnzs?=
 =?us-ascii?Q?Wgn5RyWybBSXTEuTf1fve+a5WY1TH0qnifm9phWwHl9l1Hrq6cnYVJl7CcUm?=
 =?us-ascii?Q?qWhUvy0nj2QAxPtYTixadhfH2e0h/3ZNNWAwrvVEbqKu1WdJb/bcuDykanKC?=
 =?us-ascii?Q?/SYOfogQOBe/oA7VNKUAAELDyvB0w3zi8CmSMUikCJN6d70wf8DQn7x9Uo2h?=
 =?us-ascii?Q?voES8Bad1CPLrpf5hBk6XwIqcgHhAPPpJ8Z1DRzwIl30wdXhW1TlHJsDjfOl?=
 =?us-ascii?Q?YFwoWsRlk261OEz2/c86x6JqweWwI0PKUCPYKvso7W+ONHpWYnuNlGHA40Bm?=
 =?us-ascii?Q?NgJvadY3ln8OJ957T/ojim+ucr2kkwUl2I3jdn7l4z6hMuf2kB1AvTk1q560?=
 =?us-ascii?Q?Gif3Wbkt7EfmE+MrvYERsoegyI5XJ5rT/yIRIljRtlnYt7ubXR7UjBVxgLok?=
 =?us-ascii?Q?ltMnZrfv0dopT2PNYhshjNxwk/7amgx+Uv4PLsYcvHO58Vg9mIqUDn22MEIG?=
 =?us-ascii?Q?E4lfOUVq9R9lXFtOuoGbim4SV9tY+4NmdfYiWciLApM4cGdWGOUQQE9HlvKe?=
 =?us-ascii?Q?0hrrdvrdnTzWZ7+JZnBWo5nsOXth5+yrUy+EgVc66tZNIw6nEWytnY0hPYMO?=
 =?us-ascii?Q?QmdpgZ3q7rTRJ18bj6hHI08eqhxeAogG4ai7AM2pQYZ+RFX+o3VaYYblSKwQ?=
 =?us-ascii?Q?fxE8hc4v6dko4N/qbSo8uCbPG7pIRUUZ0mP3GV33pIsmP/BWR5IaNWXrQQD9?=
 =?us-ascii?Q?7UnvUhNoZ3Sx2RwJMvhfdnoO?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D3E5E9B657BCE48A0E28FE3A2C3A070@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad88421b-24dc-4749-f2a8-08d8e24bb881
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 16:03:31.7300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCR/QBULv9RofVY2LP15mkhUATi1Pxj5BIZdX00UWXkk4SK7ToZnnYjY6L/MOn/wx6e2fx6F/b390QmxsyUuVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2565
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080087
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1011 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080087
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 2, 2021, at 2:48 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently the destination server leaves the source server's export
> intact on the destination after copy is done. This patch fixes this
> by doing ssc disconnect from nfsd4_do_async_copy after copy is done.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

I haven't seen any negative comments on this patch, so I've added it
to the for-rc topic branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> fs/nfsd/nfs4proc.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 8d6d2678abad..d3d864b8ee4f 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1306,7 +1306,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, st=
ruct nfsd_file *src,
> 	nfs42_ssc_close(src->nf_file);
> 	/* 'src' is freed by nfsd4_do_async_copy */
> 	nfsd_file_put(dst);
> -	mntput(ss_mnt);
> }
>=20
> #else /* CONFIG_NFSD_V4_2_INTER_SSC */
> @@ -1472,14 +1471,12 @@ static int nfsd4_do_async_copy(void *data)
> 		copy->nf_src =3D kzalloc(sizeof(struct nfsd_file), GFP_KERNEL);
> 		if (!copy->nf_src) {
> 			copy->nfserr =3D nfserr_serverfault;
> -			nfsd4_interssc_disconnect(copy->ss_mnt);
> 			goto do_callback;
> 		}
> 		copy->nf_src->nf_file =3D nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
> 					      &copy->stateid);
> 		if (IS_ERR(copy->nf_src->nf_file)) {
> 			copy->nfserr =3D nfserr_offload_denied;
> -			nfsd4_interssc_disconnect(copy->ss_mnt);
> 			goto do_callback;
> 		}
> 	}
> @@ -1498,8 +1495,10 @@ static int nfsd4_do_async_copy(void *data)
> 			&nfsd4_cb_offload_ops, NFSPROC4_CLNT_CB_OFFLOAD);
> 	nfsd4_run_cb(&cb_copy->cp_cb);
> out:
> -	if (!copy->cp_intra)
> +	if (!copy->cp_intra) {
> +		nfsd4_interssc_disconnect(copy->ss_mnt);
> 		kfree(copy->nf_src);
> +	}
> 	cleanup_async_copy(copy);
> 	return 0;
> }
> --=20
> 2.9.5
>=20

--
Chuck Lever



