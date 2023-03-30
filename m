Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7176D0DC3
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Mar 2023 20:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjC3Sbk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Mar 2023 14:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjC3Sbj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Mar 2023 14:31:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3ABD517
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 11:31:37 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UHNv8B002915;
        Thu, 30 Mar 2023 18:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=WP59a9zz1QDaipt1jLbxglwaN0M5PR0LixaXc1WIES0=;
 b=zyLqy15FG4BHKMB1GBxOmpKM8jJHP1NXFlp+RH6WLiYhpCa1ZoIXsDU61YfNASibGoV7
 MCeqt+mPsSyb313aXcHiT1lcDP5w6PbND90XwKsP6dFjHBGaCnZZNJKMGyI3MpUI7Dnz
 VSKRX8r2St4jvqvyB+qChndEfqWeZcVsiF7b+bIbu/p4Thhbyuv7jEUTuWPmC+qn+O2u
 V4x9qB1hhzNtT2JYQZeZ1fusgcofbsri+m09oMuGnKiYJoQ28O453W5DkQp3HQUy4KZp
 k8GM7h2lZ+p+d+SPFMvPWomAFV0qsGap8AW8kSp83XaSDdPV+uVyMI4NXXgW4IrFWwB4 Aw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmq56ufk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 18:31:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UHDful010887;
        Thu, 30 Mar 2023 18:31:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdgcyma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 18:31:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ife/LIZkevJXk05Hmtb3Vpcx0ZwyssIzpKmhiYqgxSe3FZgLxbY2+WPmDoz59VM1ajHBPrj79V4Y6ZbFrjKcjVm2QbKZqLRzhpuhKgOYstCzg9XsZ/fG7tZmCaz4y3M9KZaLKN8gcKPpfaQZy/NaZn1AvadXvQe3hMqiqlj27kKhTgponNZOsab7I0vHzn5E0EmObgSfTRHoymqMLlRFhX2NLXcfqGo2dNChtgoYUl5xCrkGB2xzB+y24owtNdm9RAatapxYYC1kMfySK3NLq19UhMvsrjGgFa8t271ZoRugWqNu+LosiiRaFQbMkLAU7NZERlmPjXEtqh5Hefsqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP59a9zz1QDaipt1jLbxglwaN0M5PR0LixaXc1WIES0=;
 b=Yt2HflJX+gTmC7YUr9OLg9yaNFURFfMArNYQqvK8LKktQvlJmfjskCWaadCCLPeR22259qf5d7xVL6uEHoGwarzXaNgw55iJp17WDQFVzIfEECtyh89Jx8bN5nWFeZyuYghFSKWgrOGdPRvh044Ef79rdI1f0EBDD2/PUbusBwIyazyN63CHO5wF09/Mn7s9hw2PvNYEy4s7iaSYsZhL95ttnMCQCvkI6zn5t2Tu9EnYGHlKh0uDfcXdQx2QIHsOFyLUbjzn5axEx2iQo8WyAMAlO+enNoSnyvE+MhVGS58e2dN0+oOH/cR29A9LmXX4bfVhJIK640wnpyrwUEAXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP59a9zz1QDaipt1jLbxglwaN0M5PR0LixaXc1WIES0=;
 b=Nk7bdT9JWrzCy2wZ1uSlrhz6JeW4FmHNL9AhasRgMBtb9kESWfQ+9lG4z4IELTNwxvsQguOMKvSxrCEXVwdMrkIBk+TWTC8aNEwMeuB3Ni0RdguTBMG8lyVjRQnDCqJKDdoxGetuFWdrbTqJUk+qoI4+CekkOCQDABZTrAxsKCM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7656.namprd10.prod.outlook.com (2603:10b6:a03:53e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 18:31:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 18:31:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Zhi Li <yieli@redhat.com>
Subject: Re: [PATCH] sunrpc: only free unix grouplist after RCU settles
Thread-Topic: [PATCH] sunrpc: only free unix grouplist after RCU settles
Thread-Index: AQHZYzThgQcpowfBWk2wTdI98B7Wjq8TpTyA
Date:   Thu, 30 Mar 2023 18:31:22 +0000
Message-ID: <49AC9CF4-71A8-48D7-BF21-41FFFEFBE4C8@oracle.com>
References: <20230330182427.19013-1-jlayton@kernel.org>
In-Reply-To: <20230330182427.19013-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7656:EE_
x-ms-office365-filtering-correlation-id: 47995f15-0929-43b6-5b0d-08db314cf660
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6m5WRVcdGYgJ0NrjMQAhUj6hce4605Xd2xaO6THgyo1swHrsmzzMYoq2GTt8Pd4gpcSnNj/g9oco9cu54RJIBiN5DqP6v9GK66I7o6MAIFK3VcZNHKUGslnJ7yRzCnI8ZwIQOcO/I6cdqKQLMjetf/wQAA+ukqV3SAI4gK0z6ouK5Ck2BFTotBk28AHYmgdrDYkNZF9LaI9vL8UtDlKOYlsdJxQQ6Vnduq1hgoLuhRp3w14iSa2P/seNqEZrVW/l7xuIvocVWIoTmjYKaFGpZ00STLCyULbXBPCPpnHGnIIlvJANPD68BmSsYeF7ZXwGkYOgX4lmHi2VWT+37/AomV887L/vSK2FHX2SAmmoUitt+mTlOUaS2QJqdB9st4mCoqz5twr03DC8WXI/YcWvx4qcnm7seBVjqcsZkqQx0ZT/uHypSucJMAojMbcPXhmNX6I5ERKVCIZGcdvELxXFfiv+ODhyBg0LxdmLJn0EalcRBr2P17LbJghNLoT5rufjqCATiBgOo8jjLd2r7r0Nun1DfReTn/yYHiUtOIjvDFbvTsDx6JAYdPSqrFK2YM8c8ZE0Hy5J8hVoPMFTDQkaoLPYyDk7by6iAr1zLIcCDW9zG86SPkJkBO0+31/nZwvnfD9/VYJ90XjZiuCd+YgABg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(38070700005)(86362001)(36756003)(83380400001)(53546011)(33656002)(5660300002)(2616005)(186003)(122000001)(8936002)(2906002)(6512007)(26005)(966005)(6506007)(6486002)(71200400001)(91956017)(41300700001)(4326008)(6916009)(38100700002)(54906003)(66946007)(316002)(76116006)(66556008)(64756008)(8676002)(66446008)(478600001)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/cuqsSm/wxCpIJUjS/818CNpWtCQjGrt8hGthKBej1cZSMG6jRqMRzI0PeDv?=
 =?us-ascii?Q?gdli4H88yiH694/zJ92tstQ7RNWAcWzn3vAzK8VQUbs+qlYr86kk/N078JuM?=
 =?us-ascii?Q?8sg63dMKFJMA5qLci/reDWQxx2gyV88dnCGnoxZq2ubJ+M3ecaSCAyazU7hk?=
 =?us-ascii?Q?eEGt/utIkBHwOPtzRXrkC8UgI7OcYGq602i2eaSojNv8JPPtIxg7CCVCM85a?=
 =?us-ascii?Q?HTqB56+9bbKgS2Yoop4gMaVq6utV9jwjYZyXlkQkmV+Iz2oQNB/wrsEtBwrp?=
 =?us-ascii?Q?jsoMB/9y4h0Y+Vn+gpeqN/OWd7I+4Q0OuszKXN2L6ATUIUs8JV6OLQC8B/BS?=
 =?us-ascii?Q?QGnk7lvXrdKGb7silKQLq33JahLtH8UaJ00Mv4ti0Ut5XXVGPqL13RtsP3Hp?=
 =?us-ascii?Q?Copr4DgtcEznqJfWZ8S4iVoJfv3u57L6WIdJzT8SPvnl086w6hCP0abX+LvF?=
 =?us-ascii?Q?bKKRd/AOFq249WqO2aItvsQJ540iDqUnnKPBiPE32K4NdSTUV9IzUbWJa3PO?=
 =?us-ascii?Q?61p1d75IEsScndG9gBSuM+aEo4cVOoLxgdx1e2SljcrGMdv6NYBBhHU69pTm?=
 =?us-ascii?Q?TFU33drjX2yY+COtC69Yt6VJ/fWVYLVldFv8+PLp74w1kSi9TiMAizjFBCtN?=
 =?us-ascii?Q?b8rHB/xR4Yl48VV5eM2C/YfhV2f739eG/OEF+KINmCp/LAEWU5GLqOtadO97?=
 =?us-ascii?Q?40qKngSDDdV0VqNVXHXjtTdjWSdukCZeQTFAPwJP2NzzNjMoAV7rUsNEcn6z?=
 =?us-ascii?Q?c7bLOsL3pzx/GtE6j59cf718adUDKBchXwWocr44EFgbXR6EGr7oMDs4/x2I?=
 =?us-ascii?Q?CiJaAMmJPniCVhDReULsniDlyMEdAzJe3/HMivEAZA6b/yHNR4T3wiec2LW1?=
 =?us-ascii?Q?h5yhsn3mt2EE2NdCFyg2sqrIqa8wzuvvcNHK06OhanwBX6QjlH9mRxvG7MBz?=
 =?us-ascii?Q?giAUA/lS3gLpiveQRtGEijYoZl4VvkVS78OC22hw5IIrLPqP9T//YyCOqE+S?=
 =?us-ascii?Q?+4Lh6Bri3vZNuItKTHZXVFjmyuwhX14YVrrR/x0LfzvSQAqgwlTbtPJr/3jv?=
 =?us-ascii?Q?4vby4EBwE5JTrY3QlTTcSfdrNDQz1GaWDvcEwLAeBYWQ9IzlRIUnB3mFRxu9?=
 =?us-ascii?Q?meolzIphH5DYG1r+35jeuVIextqx/D+wOteij8E8Th6EVhDUIaI+EkAO/+K/?=
 =?us-ascii?Q?2b0HW2ZOXY5iELFxAV/3Q1XppBAX4q8Nz2M0I22S5Y66gAyFsD2Tz5/e7mDQ?=
 =?us-ascii?Q?1e1gAwoVkrCYjNXGuhN63/hl4rcVRi44ZuuwQesSRGePhcljt20Vl2UM9pfp?=
 =?us-ascii?Q?wt1LK3MvEzgs+IJ08GiOXjQZ1jGRItYWnJy2GEXsw8bxrU5/mQNE6Uf1zeiU?=
 =?us-ascii?Q?C9lQlpDjANtPF95O7gvBsFkJAXV2itLw3UKu2VlfAOt2uFQhBJRhAgwsmeDt?=
 =?us-ascii?Q?Kni3lwaR8rmZZoGXwX8b1O7svmP/XtR1iGf68EBcNMw2SiECltVi9wR0SYeN?=
 =?us-ascii?Q?4U4+485mmrRE3dBkuoPb7EtccaGXhgT4CR0XDf5eGOpDYMm40ZMJfZvq/3PN?=
 =?us-ascii?Q?hWyGNx/RRF9HmBe1Wjn2zZWM832WgIYqS0oHMO/VBy4uJftoRjgTZCSeKub4?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <795E7B06851CB2449CCF48C47AA7C7B5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F8PpCbuOGyd8GGMlILU5PJMcZzcdHYS/nJrVcyIzNOpM1eGuP+OpXQT6xjhArkdQKgarweIOR3JNw8mwGAQrf17dDCi5uqEqV5R8vUD95DwlkOv8bPaSIZ6ePf4LIA6+EjQ7DyhBtZZfeqJNlku7gAw39HX6qUYCSB76pdY6lqawe8tHAsA9Cm4Zd/LyRfS6/o50YhZ5A+D2jY+Fom/hEq7uiBBl8M2DQQiOrQstfizHkiC2eAjqn3T0D9Vfkr7Nv1bP/XJlz9X5wI+pX9O7ase/1Y7xHQhUi7gAC+A1AVVFiNgI8eOcyb7NJvEEYXoM1K194LRoPwctl8Bom8SxhBOf9rVSNFCh9L0q/yEVGvoVsEiLVCd17X4fbr5KK2YI9oFXWIuKXlj77okuZbZv6CkwKfK/Gd6Atm1gL8b5KV+hCujh/2mt/6/OGhPPWyn+BY1EyLSS2Z31Y2ooWUxtA3g5UfGnDbdI8h04khErEju5jkBhKGZmwuAv+kjvIBe1rnFZF8rJXy/gP1QIK/gURQl8j7wzhIiACbbp/0TE3h6XA0XGBk157VyWc5nFtB4itztg6+VfgkV8PQEmgK2WtslZvfL0mkz7o1FUHAKcyom5RhgLm8dDgHkigU14sPsA6XGWMniPx+Lj+z5S2cAXGDEK+oMgR8zKs5ne7d7yVMGCQnY9RXh3OfJJmlaEbkNEmVkjDdaYyrbLaLRJBTLM0hOpLQFOe+gciC8MNLmOVzFdx2Yw1dwbAPIvP9bu0H+/JUrXy9qJnQ6v+nUyXd7S24sHEUtSCFDrJmnbXlLYW59yKftzsKf6+/ZHsoqhzlY3
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47995f15-0929-43b6-5b0d-08db314cf660
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 18:31:22.3415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jKSY9K2ydRRYmKN9v30cHg/lKRwXKV3+lm2YXhcnbOTUqu5GUkkjP3rSy/3Y1Guj0LWXG2BDBw7agVBdr5APOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_11,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300146
X-Proofpoint-GUID: UI7cpQ5WXRp_zWMcwoZ50y-Y4GXl4ftF
X-Proofpoint-ORIG-GUID: UI7cpQ5WXRp_zWMcwoZ50y-Y4GXl4ftF
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff-

> On Mar 30, 2023, at 2:24 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> While the unix_gid object is rcu-freed, the group_info list that it
> contains is not. Ensure that we only put the group list reference once
> we are really freeing the unix_gid object.
>=20
> Reported-by: Zhi Li <yieli@redhat.com>

Should we also add

Fixes: fd5d2f78261b ("SUNRPC: Make server side AUTH_UNIX use lockless looku=
ps") ?


> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2183056

This bug isn't publicly accessible, fwiw.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> net/sunrpc/svcauth_unix.c | 17 +++++++++++++----
> 1 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
> index 50e2eb579194..4485088ce27b 100644
> --- a/net/sunrpc/svcauth_unix.c
> +++ b/net/sunrpc/svcauth_unix.c
> @@ -416,14 +416,23 @@ static int unix_gid_hash(kuid_t uid)
> 	return hash_long(from_kuid(&init_user_ns, uid), GID_HASHBITS);
> }
>=20
> -static void unix_gid_put(struct kref *kref)
> +static void unix_gid_free(struct rcu_head *rcu)
> {
> -	struct cache_head *item =3D container_of(kref, struct cache_head, ref);
> -	struct unix_gid *ug =3D container_of(item, struct unix_gid, h);
> +	struct unix_gid *ug =3D container_of(rcu, struct unix_gid, rcu);
> +	struct cache_head *item =3D &ug->h;
> +
> 	if (test_bit(CACHE_VALID, &item->flags) &&
> 	    !test_bit(CACHE_NEGATIVE, &item->flags))
> 		put_group_info(ug->gi);
> -	kfree_rcu(ug, rcu);
> +	kfree(ug);
> +}
> +
> +static void unix_gid_put(struct kref *kref)
> +{
> +	struct cache_head *item =3D container_of(kref, struct cache_head, ref);
> +	struct unix_gid *ug =3D container_of(item, struct unix_gid, h);
> +
> +	call_rcu(&ug->rcu, unix_gid_free);
> }
>=20
> static int unix_gid_match(struct cache_head *corig, struct cache_head *cn=
ew)
> --=20
> 2.39.2
>=20

--
Chuck Lever


