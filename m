Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C197666930
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jan 2023 04:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjALDFM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 22:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjALDFL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 22:05:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9461E48802
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 19:05:10 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BLE7bj017420;
        Thu, 12 Jan 2023 03:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ih1Yeopa3dRXyJNC7cIBaySbdB2GwdTqgKSIP/Fgvdc=;
 b=u56LK6phS7aL2dWTC0hzGbG821B3osT8n7f3oQ+N9h2FIQaiDpSTERa4yruXN+Rj9xGV
 5TKcX1fTrXckyHX2ZB2ZxzgAJmeiwmuRI7qzdtRgQRsa5yZC+JfS8C/skd+HPVeD5PJ3
 FxaA9BvRWAvaV7gKI/ELcseEs9jlFt6zKhe5BwZW8ye9AlSRiKGcTLSwTAW2oeiTdi4D
 d6LWM5nYCgj/I62jUhoc5Pj7f4tjufIMc6VpXm/E+K2Iz3SpHfkYVpm+xZitRTAHraRc
 DsO0Ma8+/Di5Laefg+Sl7Q5ZQZBscFZxQGbE8tbE9rWy0iYig3UqeJ6qgfiH5eGxlgBX IQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n22x00ugh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 03:05:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30BNuF5C007676;
        Thu, 12 Jan 2023 03:05:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4bku95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 03:05:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3Sv6jJjVz+toh8ZDyMujXTFjYYbtiBC17OtHzmfCv169Jz6nDkKXOtM4joLkSw1GSwrYmuEJupTSTbm/fJH12PSLJQqBuCbFC7YZeRMi5yAgu29e18rAN9HyQjgnf2EGsRx1aNkKKvMZtjDmGHOEkYXS+0DiPXsmXNqfsgvCUtyaD1VnqpKF4qPNMpnibkx4Vp01ydvYTNa0/5/xcUxyFNwN+ZXqosVcmyRF8+6rf4l2kWp5ntrOixjGAXu65Zh1mVwjt18JRRzVtNn/hslmIPxvfYlImHRGzQ0AtKLFElEgpJPNy218iPZecH++b1NxX2k7YkzyqiLnai8N60BYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ih1Yeopa3dRXyJNC7cIBaySbdB2GwdTqgKSIP/Fgvdc=;
 b=OSmPxQJRiThqS2Kc7XG2QiNggvNjqjQQttkaIUnF5uFOWYDm/1569fQwe/AavcuVvdcJve027HIx4jrp9ChYY5glnkSCjIcSNWttC1Dja67c+B5N8ALQ+csZr9GX7EgCujk/ou6pG+p7NdjZUdMNN1aSeY+AqGplwXjCQFC2Lw9B5RinA9STpw4LmvkC2zMHwqba0clDinakpTWiNlqFnDIXucCr+FG+m6429yyq+DvnmCSMK0NVYzM6rzzd5+zxRUbsSjhLfPWgu0EZKzfBhZmJn6lJzZAFhexHYOJAm6OlWWYO7ph9Yv0ZN6oXLmJOnXiNHRaf/NYNBImASVifMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ih1Yeopa3dRXyJNC7cIBaySbdB2GwdTqgKSIP/Fgvdc=;
 b=RFKukj6P9l+jPengvbuJnCn7AIV8U3/Xtz2odFHoPS7JETwQss+B1Vh2lgrf+KYzbHFhUMZOtONE6V6Acn8ZaH2C7HwazBljqp8giTz3O7paSEbnDEsYfLeCg3fIL9X9FqGuo7dRsfWd3T3gRniCw+NLP/sV/H6+UJm6Qu98L1k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4856.namprd10.prod.outlook.com (2603:10b6:408:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 03:05:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 03:05:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH] nfsd: move reply cache initialization into nfsd startup
Thread-Topic: [PATCH] nfsd: move reply cache initialization into nfsd startup
Thread-Index: AQHZJdiTVnfjJCs+IUG71Af2cqKlm66aGaWA
Date:   Thu, 12 Jan 2023 03:05:05 +0000
Message-ID: <5C8C5B35-0C10-438B-9420-4B1B1ED6F489@oracle.com>
References: <20230111161959.178472-1-jlayton@kernel.org>
In-Reply-To: <20230111161959.178472-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4856:EE_
x-ms-office365-filtering-correlation-id: 45f85e4d-8114-448f-67d8-08daf449ce1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYXa5iQseIvIPPFPyXVQAshRTXoJRGuKPmP7MDk4QXst/rRFmGt0xIvEeGmNteRDh+ZFUXHWBvYRCzVRf3lp5WvxCUPU2QgvdKVsQ2b3bBUsDI0qgtU1ymwtiWxzk8CuPGUtxC21vFzsxQG7KDCEqayap7tc6rkbFJ6upK+aSTNiMW1/wog+rs++34TwCg8fKNb+SiWI9v8sLnJOsv3XQIUoEJvDRiRxbuBMsURuGW0hGViF+xeOAGBLRQrAf90lrkwlb4XYcfGtqRJTzSMsroYLZy6ebomx5ItL1bS5IIpjNpPK+tD5pFJOHTh4UAqvUSZuESfrl4Z34Xvrk40IZk7RNfqcFXTCAR0KZDOC9/L1gcLdOPS1WHlXn5hh2+gHybfW1IJunXBo1G+bsPXilogbIxoQEElyGhpqgowj2tBT8vLc5ShXfnrQwcaodtGnIh2jRPjhINEJLgksSFfybC6m30LifpIcpJTjtWKBo5Ng+jopbfR5EYDMsQauTMeGxDE+j6Sv7HNEf9ivf+EpJwS5+E0A7G3W+0K18c2yVo09yOZAaV/XO+zilcFPFK2zisPAIoraSkkpr+GbjymkR89/NSk+NsqUW5uykezHYAnpK3SqdIkGH9EVzhO2vYiEL5WkOjsuQEyWZPB4HRKzrHx8AMa99LD0zxQLMmGSGJcJ6RUaBvD1mZXdINL4BtU9Yf/gu1c7mKbeaxXTpDCCfjFilGifiqVg3Tixov92+iQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(478600001)(33656002)(6486002)(41300700001)(38070700005)(38100700002)(6512007)(71200400001)(86362001)(316002)(54906003)(2616005)(66556008)(66946007)(26005)(66476007)(186003)(76116006)(64756008)(4326008)(36756003)(53546011)(5660300002)(107886003)(6506007)(2906002)(83380400001)(66446008)(91956017)(8676002)(6916009)(8936002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AnKpcssKK5K8Qz1m/LAxlrsMhTMJoO5MzNY9TBt8rNaYo56hdUGXruHE5RcG?=
 =?us-ascii?Q?GRaapYEudWiW+LRsBgn6q2KOPReP33d9eiESASOnm7ULKQlvm0ihDSm0OOWj?=
 =?us-ascii?Q?/37QSIjb+/mjqOGTHXs5gxfusn5TZuPz1ErIO21469AJZh4WSg7Rdqn3QljF?=
 =?us-ascii?Q?O2vgiA2MqdxZvYZN6GvdUfDaowb6KgD2KixicKzla7QNZGfDI+k1JStPdXtB?=
 =?us-ascii?Q?Os4vY8/EHhMlaXLKe1dnlog6eU+NjnypGEUifX7wp6cWFfZU3O2T5X+QdH4g?=
 =?us-ascii?Q?qOCI5uHd80o3PqNuEmNtSnwlSDxTsYFIML7o1Cghg/KGxK1McHg5xSEx1ok3?=
 =?us-ascii?Q?xfY8s10tq0GNCHM3n8Qqk7LdcxxRa7tI+4q5udt41M6V1acHJEyy2lpd4HpB?=
 =?us-ascii?Q?wLQwuUHKsxgKkfKgoMQB4WRYWMNS8gMFjzSyDvFgvMs/Epoz15YjXGkWrZr0?=
 =?us-ascii?Q?Mi/iN/4HPbchIho905YTL1VYIIW0kBRGyhJgVzTfFbmfz5BCEL1vpd+Yj2Ug?=
 =?us-ascii?Q?O86j19l6ilLPLv2y57RDBSBFNy8ihcJEHD+a4BsZbUulnLTqXKNfQecPfVyA?=
 =?us-ascii?Q?CgpM3sXVCpSRIil1YZnHpu96bZ4a33w0IkbzSvUFeZcPgCRlryQBST5ok+/q?=
 =?us-ascii?Q?VMxYPgr5wrFilRthWBq+barESPxbUOW3QoMRWYZTUlXYlwr8F1/NnKWnTLlG?=
 =?us-ascii?Q?ebtZ/KC1vQ9GtpFgqUDekiu38K9uYKqeIbyMTuvnsmjTS/mpD4l/yDO82buT?=
 =?us-ascii?Q?sW+d6Y+r9LvjsQ2QDMF8xnsnvapAorJtu6golEFcyZTUT0s6rWn/Os9PCSIy?=
 =?us-ascii?Q?vxS9qTMaj4kHKQNPxCWZNumEI5p1XJyitkPXdgBbfUD4zAAHPxFqEjHBruRE?=
 =?us-ascii?Q?/Suw9/QPiobhWjMCgoqonUFYLm+t3AcRl2zgzFCaLz1OPLFC+DntRWtb1y8W?=
 =?us-ascii?Q?RfSCyl5drRjKpue1oeX7AwAPcQyxCF9V0ldeTDI3MgDeHRtv+VRc6CTOnBp7?=
 =?us-ascii?Q?SvGKJniCTuft9T9sAcEUSLOr5vY0DokqWTNoe1/A7IGQtFh8ONnQ2jZPF0Q9?=
 =?us-ascii?Q?DuMvG6cjLHkipg3mpyQmxie6PgjDmZTDGzAL7GTOGtC42ulTvb+4++WvkUjH?=
 =?us-ascii?Q?9IotdfWnSEtVOtFG6sJPkNiHa8A0ChCWIBZQoEtMqk295HVOwVuFINn7ZO3p?=
 =?us-ascii?Q?Q/C2hlRmHCQmdGfUj2gf92yLRvezAobTCS10IHkUc8Ooim+SHVJfxly3Oof5?=
 =?us-ascii?Q?VfPJEiqPmPsq9jwVLubSuJNnB5ct56IcOxUfsjOUrNyqFWCJlMiMrkhehitL?=
 =?us-ascii?Q?qgoxT2FU409wFXOqsAuularweMpEOqubN0YnRnxm3c1IQalYbzZJLyqHZlio?=
 =?us-ascii?Q?kNZAVISvdfH1BnAFMbrVCsIzTLPcPTwr2UM3JV7yQQu0IiPwZzzgrqMKYE2j?=
 =?us-ascii?Q?MjhRCHsONGndue7z3yUii0lZXAQcVfPKjhc8kbNQtmvmbwA/XX4EwNEw6t+w?=
 =?us-ascii?Q?b1kEcZ65H7GyrV8p0+2BN3cml76O5bF8U2L6x0XzhO1qj0Up0PvBlmuXKCV7?=
 =?us-ascii?Q?PUt+ZsIzBsUhufn4GsSINJ14EE2MfcTCdLt1O3HvwJkBBuFRA+1G8KJKBH9N?=
 =?us-ascii?Q?tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7290C205D824BB409BED32A519FAAB87@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0v49pSBjIEqkyeUpIOa5cfLg+P++XwJY4bu5axiqvWzxhwEYm+NcHU2oKYSed87Yf9mF4XlB3puWiabHv5yJrKcYEgO7nRnj9QZzkLcrpeOkysqGD1R0IJ6qm6pzXOPWd3je49flh3zb6bcHg1+0SvDqSsiXIg+L/cZnadQxk0fHgDoZaggK5dEdqn+vb9b0D8u4y7r8HZH7dg3ZgT9asCTRUSasU6ka638m0iLrL42ehCqZpMAMSRNVyU/EG7Qs4NrhW08FNphsSXh+zWwZDy1MyArZOl4haepY2pn4ieETqlsHqhH9cShxpyYDy/Uzfz2nwwv0aY577yVpWB42qDbLBe8PsQzGhHB85suoOOjM6r3VBMQdkPEHzHAXkve+fWDCdSUYs8o6n1n11t5DSvIuBYSAiWmI3+th/3OwUY1KxyBkUQ4Y9VlZWRTUV2IrLcUIqpV8HoaFNpS2bDQ5jXZjSOLV4DUAWXRz0PF9z2SfjOg8uEZS0tOK3TknWZLHXnbgvGcVTtnluXoR4F7XOr0zvNPGhqeqTUWdDfLkXd3GaUmzFB/cbsEkVAGQVlDREWhRaCAnHssMZzUDt0cjeF+qBeqeTRFTbi/l9ovk7XiRI8zS9LjLF1xxbNTL09cVJAqMw7MO2WMifAKoHRupWyeTV306JYTwphtMcR+CdhV/cg3P5CO6pLV+bnE5NpARQl5Bgb393aFvgRB/G9OarsPcSIIPqwVuhU3aEVi3ZOgY/hLSnlnqezlpdpArabO5WuU0JbcwEcjEH4xsPuFr5w8ykoD1dEIZC8a091WmGXs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f85e4d-8114-448f-67d8-08daf449ce1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 03:05:05.3570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EAEuc1TnDpUtRSdF9cJm+C+ZNzc+CgNsaFjAp3pGdZa2RriCCCJN6sCep17jcyV91t8hTuHMXNC8hsXm7c4z7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301120018
X-Proofpoint-ORIG-GUID: oKRZVEWa0wC-Dsg_NU-ZurFGzzMvVjfG
X-Proofpoint-GUID: oKRZVEWa0wC-Dsg_NU-ZurFGzzMvVjfG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 11, 2023, at 11:19 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> There's no need to start the reply cache before nfsd is up and running,
> and doing so means that we register a shrinker for every net namespace
> instead of just the ones where nfsd is running.
>=20
> Move it to the per-net nfsd startup instead.
>=20
> Reported-by: Dai Ngo <dai.ngo@oracle.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/nfsctl.c |  8 --------
> fs/nfsd/nfssvc.c | 10 +++++++++-
> 2 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index c2577ee7ffb2..f2a0d6ac88df 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1458,16 +1458,11 @@ static __net_init int nfsd_init_net(struct net *n=
et)
> 	nn->nfsd_versions =3D NULL;
> 	nn->nfsd4_minorversions =3D NULL;
> 	nfsd4_init_leases_net(nn);
> -	retval =3D nfsd_reply_cache_init(nn);
> -	if (retval)
> -		goto out_cache_error;
> 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
> 	seqlock_init(&nn->writeverf_lock);
>=20
> 	return 0;
>=20
> -out_cache_error:
> -	nfsd_idmap_shutdown(net);
> out_idmap_error:
> 	nfsd_export_shutdown(net);
> out_export_error:
> @@ -1476,9 +1471,6 @@ static __net_init int nfsd_init_net(struct net *net=
)
>=20
> static __net_exit void nfsd_exit_net(struct net *net)
> {
> -	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> -
> -	nfsd_reply_cache_shutdown(nn);
> 	nfsd_idmap_shutdown(net);
> 	nfsd_export_shutdown(net);
> 	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index ff10c46b62d3..fe5e4f73bb98 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -427,16 +427,23 @@ static int nfsd_startup_net(struct net *net, const =
struct cred *cred)
> 	ret =3D nfsd_file_cache_start_net(net);
> 	if (ret)
> 		goto out_lockd;
> -	ret =3D nfs4_state_start_net(net);
> +
> +	ret =3D nfsd_reply_cache_init(nn);
> 	if (ret)
> 		goto out_filecache;
>=20
> +	ret =3D nfs4_state_start_net(net);
> +	if (ret)
> +		goto out_reply_cache;
> +
> #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> 	nfsd4_ssc_init_umount_work(nn);
> #endif
> 	nn->nfsd_net_up =3D true;
> 	return 0;
>=20
> +out_reply_cache:
> +	nfsd_reply_cache_shutdown(nn);
> out_filecache:
> 	nfsd_file_cache_shutdown_net(net);
> out_lockd:
> @@ -454,6 +461,7 @@ static void nfsd_shutdown_net(struct net *net)
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>=20
> 	nfs4_state_shutdown_net(net);
> +	nfsd_reply_cache_shutdown(nn);
> 	nfsd_file_cache_shutdown_net(net);
> 	if (nn->lockd_up) {
> 		lockd_down(net);
> --=20
> 2.39.0
>=20

This was applied to nfsd's for-next. Thank you!


--
Chuck Lever



