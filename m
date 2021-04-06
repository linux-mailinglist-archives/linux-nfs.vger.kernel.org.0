Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E3F355869
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Apr 2021 17:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345956AbhDFPrA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Apr 2021 11:47:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40912 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345945AbhDFPq6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Apr 2021 11:46:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136Fi8Zx096862;
        Tue, 6 Apr 2021 15:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=g7Wu9P7fbtti3x7xmbrh0KM/fyDLHOndw5tGTcJzysU=;
 b=D5mlgBVehadBeJa47C9BG2otCMj3ScXIKpwtoG6IPKMhtT53TcvJ0V8wQxDt+BZt/w1G
 4Y+2Hyn1lpCZ4UQ7Ccm6JNkDqxHy1HWT5g9H8PZWWdPaDSoBc8qnuOaqaSrr43kC3Apc
 V0MuIJT0o3QV+E0cWwmdA4jBG6XR7XfqU5ic3jGqy6wv7zNsCR0/3Q1UA7JroHfD4vD4
 9b//k0MLFlrzZqNjMqxuiSEsHJpauVmbacblIck37Ce5QQR5pJFlwxNPW6JwgFj1wyrN
 9jbb8cI8etZ1R0wshy+ujoaMD6h4ALU2m+rHp/3VbxO+zwl1iTElJXjz3eV5Yhg7yq3Q bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37q3bwp0r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 15:46:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136Fj10L115978;
        Tue, 6 Apr 2021 15:46:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3020.oracle.com with ESMTP id 37q2puerug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 15:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb3RWDrzANfrOoFqEQX9bxIcOW5SMfokOO2A+puZBr9BJb/J34Vd/0hkaQ0/Z6B8KupCHarBLR9QaAa3+b8WNaSftGlvB2yGqv4JMZf21JnpawqXCUaVf09HGcnjqgjP57lIDt8FQCTuyYqQ2EjzyY7THm/a7LArHQQ819Jb4wNvsylKjK2Wx5k8v2j/WvVVo79UOq7BUKdDCSSbQxxmtjoIM0CLDZNna1BcZVDB1SKUFIRSBpia5O9qmTMCWTG+W3oLgepdg2f6rI9dNfZ0kyEnc24m/W4tE8oN/YeEm6AqXO+oVmedOdMCP/rUMOKc5MyZ/i/wlBztXVwjS+0mTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7Wu9P7fbtti3x7xmbrh0KM/fyDLHOndw5tGTcJzysU=;
 b=HZN9mZr3c15c2t40iNk38itpXWawFk7Wq7c4qRKbiR1uMulDOq9Tl08VWCkI2MtxGlS8edYApXqnzd6G/XJRxWOrUZmfpEzq6Ra+G34VgtCx3DgxHTatsQPITZvw9/AwSImDF659skf1XjvkflBIJy8BMhVpk/2YHiX+QtBLg2IbZSnmezd27lM78V81DiwXYGvD4tAoWsb7b2kxLn7fcaji8TFGiRrsICbCNaGuNrZ2dZjaRZbM7l8kNhphxCDKI0xnCE+izUzDtovKAOKSs3LswwaagUYn+hm7LzUotBLH8DPRovpwiAs+z4BXPF17isZ6pdLnGEjjrWdia/XpYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7Wu9P7fbtti3x7xmbrh0KM/fyDLHOndw5tGTcJzysU=;
 b=gQzcDC6RFpjsbu2raMYgnQLYX6JeaXMwJhrhmiSNqC1FdMluGAqYfwys4VZFzlDg0UYP2qTjmThIbuU/FAnzYPOMHjILHFVZovSGdv3IK3MDnihUerWVu4PmGQlx60af1//RhBjO7WMm1aFRlNU90gW4VPwEDOdplObyiA4T9p8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3110.namprd10.prod.outlook.com (2603:10b6:a03:152::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 15:46:34 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 15:46:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Huang Guobin <huangguobin4@huawei.com>,
        Bruce Fields <bfields@fieldses.org>
CC:     Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] NFSD: Use DEFINE_SPINLOCK() for spinlock
Thread-Topic: [PATCH -next] NFSD: Use DEFINE_SPINLOCK() for spinlock
Thread-Index: AQHXKt2V1gcSxm7bVkeOdiAjqSPoqaqnok6A
Date:   Tue, 6 Apr 2021 15:46:34 +0000
Message-ID: <5B67E76D-139B-4004-9DE0-A626026CAEB1@oracle.com>
References: <1617710898-49064-1-git-send-email-huangguobin4@huawei.com>
In-Reply-To: <1617710898-49064-1-git-send-email-huangguobin4@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b431d071-3a77-4669-87db-08d8f9132815
x-ms-traffictypediagnostic: BYAPR10MB3110:
x-microsoft-antispam-prvs: <BYAPR10MB311096287F00DC631209B7D593769@BYAPR10MB3110.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MAaj5XX3vgxDpq7WmJpJVJTa4j6Uc2rdmG3YeM03Zn26yd/ZBQQ82P+TVXWg9/u54PB6b31zDc5XIyt4zZ1EHyeSVGQPiOl5EQ9jy4cdL4oJuT7JiKpriVMLWGtIdzryeSuO+ud+a2sp+H82eocUNu4Afc9gZgmQTKZ5YQD1SjNhvr3UAU4ms8qb73dAlhNDKcIa4VttJb5PAcgPHApPGdIhgRXgXJBUjTnt8LqnGgY51Vr7mTkwKm6jaE2FQXrfGY3QuNJ88q1ngVnKqqrWvOp34XNa2qqvDHs1qR7AJBpvRt7Y8ez8GWyqxNmvXydtrgy9DTCOIIfU2o4TeEGReqScgabCpJ5aSxd1R1dnPtyRjgBNk/QgYE6xzG8shR9ehxTfXWVYX8+2Il77L9jIvIpCuptr23YrUVAFjaS8gMUBq109qYFoQy0NUHyhoHYTqkH4m1BmjiGx+42A9FwwK7eH2QZd6BArvTtweyFcUF93474LffC4kGvxlet6oc7w7pdXW7/+VkwNIChE5I+DR7nuycBV223dHchDGYHv/Y6CbwaFPlfg6r0XtU/fmkXud0+8wf/BX+8PaYcN/4zZTefkHn0IeCcHYnwkghQo5voXJLKael1j69A4/bO3ee5CTK9Vak0GxaZ1kLfN1oagMdfKBpOnRMV2P14j4QgJJGivau4wfXkXEUzC6rXtjIvQk3V9MBJELp5IGtK1mi9fIyFs+bGg3S0BT80infjdGUcC91gMaKfzj+l8DW60DAoQTgDXnak/fJHKMNM0L838EA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(396003)(346002)(366004)(2616005)(38100700001)(26005)(186003)(71200400001)(54906003)(110136005)(316002)(5660300002)(6512007)(4326008)(53546011)(6506007)(66476007)(8676002)(66446008)(64756008)(66556008)(478600001)(6486002)(966005)(66946007)(2906002)(8936002)(76116006)(91956017)(83380400001)(36756003)(86362001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pXJdMzzmd90iFBHbswKjJJcz4IYeq+arA/+PEqBoR/UUIwDoVDXadoWeeNT2?=
 =?us-ascii?Q?bw/BYqkbvFNGHFTdNZ246bVJngI7vbkay9g5kcREsb0qEbytSVREGswDlVhd?=
 =?us-ascii?Q?CovHXnSlyk6Il+6u201xkT9nVxkuHqmOQT61mTHMcECTEpK7kxH23Ra6zXWj?=
 =?us-ascii?Q?g2i/PH+musaE4cCWkNBR76wTmUKLdVgcj7glsfa9kWvYTL3NO5ypAaI2pFXN?=
 =?us-ascii?Q?kIuHYsyq7JH7SIcSClxBrFYYawYpDYgg8uRgeZsEXlqOnVluV9kZCjVR22nD?=
 =?us-ascii?Q?goy/fbGbBN4Z5t8fmUi4vA4GVh9zt812/iieZ0vNGM/mBfTGeDR0+NHZbS+0?=
 =?us-ascii?Q?tVa/af4sjYcmXKI3Clobb/geVoxHVB9Y+5zCXNDr40jT+DGeu2rq+p8Z4pfm?=
 =?us-ascii?Q?RQ/+sPDaK+7Otz2f920+2k8FYNObl04J6hvfhDTtJhm/SYZP41Rzx93Iabl4?=
 =?us-ascii?Q?opDloSIslzGfzpSLuA9jvInnwo0lTllIIHCeBHXUAa7q/8Rwhg2N5Tvda7ft?=
 =?us-ascii?Q?QxvSNTN7/Pbpwc18ucwwWRE3C8sPCHpXqyt+pFlJCLx9st2+s4BRb/1NyFmI?=
 =?us-ascii?Q?DTpcHewcBrdzVIA/7xeQ4YQeASfxa8qdq8dyn74/3JKnIl2NOnyVdpoKRCGm?=
 =?us-ascii?Q?xQqvYNUEg43ZjjkIYI02j2Kmz6rtW66HxBMey0z0BGp9DkgEMCC2VtB3VR2C?=
 =?us-ascii?Q?YqXr+ev7IIEvsFto5rGWHf6OSjr3Kapvdee77+xsd3sKIe9khvFndwc1+UoU?=
 =?us-ascii?Q?SO8T7epzirNNf5IbalH8vEEUgVxSGTTcAvzlniOMzD1MXxoudJmljJeRaKh3?=
 =?us-ascii?Q?heIuDSM5PJr+HjrxryQueoy4N55B/CE1qhR9mgHPdBpaOxAWWs8XdxiYRPpv?=
 =?us-ascii?Q?WvZLTvVD0LMLlLlj1s20YJ2yq5EPI++0dcE3+4n8DffvLUF+rGC1PDm/wPRK?=
 =?us-ascii?Q?5Yz0ZIbth5/XVPFjcs7HozE8EZM1h4h/hBp75Uh3HhfdYdDw9KBSrXbnsGB3?=
 =?us-ascii?Q?IVwsMyG29IhArXGuZg3ex9z28C6rT9afadacvnrditeNODsaUvbV2k1OZ7WT?=
 =?us-ascii?Q?+5ZGT6yKZG6Hql+u5TqLN0pg5JmHqR4yzVMykwBN9xvph+b6px/P5vRaL19i?=
 =?us-ascii?Q?RfaX1FpoCObaS480VAr9lEI27/U7HjOypiqWkFtkGDKxVc8LR42DZkp/gwOS?=
 =?us-ascii?Q?W+nnsV2mTYGKXB5uVCAMtmrS+8LsEHTQYYtPObnrINtszxLVGNqTYeCswqzx?=
 =?us-ascii?Q?mD+/TnPU8uTFyf05avhr1Nb1hZe350bTkTKBtqHxR8IQkNoOkCPnxsXdwwZB?=
 =?us-ascii?Q?pEItYA6SmK+GctEddRHmeb5K?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B25E53FF39A6C743AFBFDD24D508F9A5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b431d071-3a77-4669-87db-08d8f9132815
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 15:46:34.3795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PktjRrHgL5psQpOdHR3j9wZH8v2ckRtOIUg31dcXaMG3eWzwC8D2QnriNaulIIPXCLG7OdaktOrLgLSaZD4qiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3110
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060106
X-Proofpoint-GUID: udJO1lYRfYBP1ugVWXpHWbnEJkxM8ABw
X-Proofpoint-ORIG-GUID: udJO1lYRfYBP1ugVWXpHWbnEJkxM8ABw
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060106
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 6, 2021, at 8:08 AM, Huang Guobin <huangguobin4@huawei.com> wrote:
>=20
> From: Guobin Huang <huangguobin4@huawei.com>
>=20
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Guobin Huang <huangguobin4@huawei.com>

This same patch was sent last July, without the Reported-by:

https://lore.kernel.org/linux-nfs/1617710898-49064-1-git-send-email-huanggu=
obin4@huawei.com/T/#u

If I'm reading the code correctly, it appears that set_max_drc()
can be called more than once by user space API functions via
nfsd_create_serv().

It seems to me we want to guarantee that nfsd_drc_lock is
initialized exactly once, and using DEFINE_SPINLOCK() would
do just that.

Likewise, re-initializing nfsd_drc_mem_used is probably not good
to do either, but clobbering a spinlock like that might lead to
a crash.

Bruce, any further thoughts?


> ---
> fs/nfsd/nfssvc.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index b2eef4112bc2..82ba034fa579 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -84,7 +84,7 @@ DEFINE_MUTEX(nfsd_mutex);
>  * version 4.1 DRC caches.
>  * nfsd_drc_pages_used tracks the current version 4.1 DRC memory usage.
>  */
> -spinlock_t	nfsd_drc_lock;
> +DEFINE_SPINLOCK(nfsd_drc_lock);
> unsigned long	nfsd_drc_max_mem;
> unsigned long	nfsd_drc_mem_used;
>=20
> @@ -563,7 +563,6 @@ static void set_max_drc(void)
> 	nfsd_drc_max_mem =3D (nr_free_buffer_pages()
> 					>> NFSD_DRC_SIZE_SHIFT) * PAGE_SIZE;
> 	nfsd_drc_mem_used =3D 0;
> -	spin_lock_init(&nfsd_drc_lock);
> 	dprintk("%s nfsd_drc_max_mem %lu \n", __func__, nfsd_drc_max_mem);
> }
>=20
>=20

--
Chuck Lever



