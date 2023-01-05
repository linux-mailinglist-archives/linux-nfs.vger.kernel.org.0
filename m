Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7061665EF22
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 15:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjAEOrG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 09:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjAEOqu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 09:46:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB225B148
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 06:46:38 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E3ksT015833;
        Thu, 5 Jan 2023 14:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=e3wejTJZXY0FgLpMRrJpHGmfvySCXmENRKjpoWag6tM=;
 b=cnZPfzdTpr6En4kreL4kY/lkGFeTP6KCaDvpJcDCbzW/IRCIa+GsrgS1W1aqF13YMGst
 2DTOfjcqOyPcs079E7P+tyhj4xPPxfnRL3Yzd6GF7DJR3ieIYcegCLogp09yXJqQdpOE
 xiFik8Rb+bJHTxHEfRgBGmH6vOmi44lHB8Frgn9WuNPmJn7woZhJsL1RmneQ22LVzWRW
 zbtKTMVj0OYKdjIy8WY+yHdu8yvR1JQiuug/LNmRbUroKzG5f+DzY3fYCrC7AFQdSJMn
 fMFV60AxXCBn4JhZ7tBdXPWHrZJUMv5rz/lEP3DmbJV1baAGUwOgszzjg2nM0KFifikL HA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbgqryph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 14:46:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305EPxlF023288;
        Thu, 5 Jan 2023 14:46:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwepsv79v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 14:46:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFLZGQhGm1ZBEwjyE1eqZjd/2b3hWMN1FbcV0nBPN1pfAvO7QeaTd2ceaLSB3kfK/ZkXn7oZUay9xhFSBr2C/2ye+0FPw0+IvoG6NAGEmAvu5TeYVHlraUdNxWH37Kw6kkSxbpw1krH7N7Qefd1lvHff9Jrev4BofExYlEGyPU1UfpFMEAWadbLGAHw1YOcnIOxgY1loM3RWKRE5LxDSEArVfKd3FScwUFzGNv1v8cvKjuzfa5DgJPucL8CPZZvzJyBoHAipA6Yr0HLoY7SV3f0e21mi9SGx71fAkUbJnUYZngK/kP4AFfgAmNM9wvffyLlTZJJh4V0DLuwETg+C3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3wejTJZXY0FgLpMRrJpHGmfvySCXmENRKjpoWag6tM=;
 b=HUoPkYPWVZWaLRrfBvyRkWnY0WJuHj6HujqW6KrZfechoN9mlCUxJzd2wX34ViIZRjkPjNXAigKt2YAnIYQLZeX3jvqruEctZ7p8WLcquv24ABKDlOBZ2Ra0b2CxCC/8Ubrm+8HzSze86y2SKzLR9YLtUwYsxWea50cBj9tWU0PFk+t/PqUZyvLeI8dEuTLtiksJuBfKeZIAHG6rRMQwWggIYC5AuQSFUz4AmiZ1ccn2jGfOhEXeFmRor2IwUR9ClIOPlOxvjx/iG8qLiO5mUWKcEoa2rVlERvgIvFVyfiKuaA8LuSxT7F7JoMzBRQQ4SEQi0k82RRSN0+a/wKbM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3wejTJZXY0FgLpMRrJpHGmfvySCXmENRKjpoWag6tM=;
 b=reNzN5bZbaMXpRFTD8uZWBvH8BU41hMpan+IB3Eb5hKCO3XHImcg/jB91QZDR3m77zfhWS8RUGfekId4xA2B+G05/7gknZgELvoG21+VA7nDJXLN3LVNSldpHNMN1nE+rZdfLu+9HVKKvk7aICTE6+9wii5IHt4vXR65p7bSxxQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6368.namprd10.prod.outlook.com (2603:10b6:806:258::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 14:46:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 14:46:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix potential race in nfs4_find_file
Thread-Topic: [PATCH] nfsd: fix potential race in nfs4_find_file
Thread-Index: AQHZIP/Rwx38OblB2USniwBo+ML6lq6P5v+A
Date:   Thu, 5 Jan 2023 14:46:31 +0000
Message-ID: <4255172A-EFB5-48B4-B2EF-700C10862427@oracle.com>
References: <20230105121823.21935-1-jlayton@kernel.org>
In-Reply-To: <20230105121823.21935-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6368:EE_
x-ms-office365-filtering-correlation-id: 6100ef84-2db7-4bc1-c437-08daef2ba28e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +uGKq0qCPj96njy65q/O9K5vT46e89Cl4YHor/v4ShFt5t4SjCNY+n1lCXQEeU5qo/XntseXNLZestDcikPXtzUiQ8nBPSQZcgQ/C+ZKI4z8EB0YiHrf/V3OsWw5Ofeb8GamSTUul6OgvmtEItGMEI/kJekCbNKvkGeo3njcPksdcXABkAKGmZW/eN+FhMSwzxySWuLqwrLolKKA8Qb2dHWD8my3bIkuJJ9M+/njK9TWbcuF++NBNbvCaLPEPaacLvzPdOpaKNrihWsmMyhRtafzYI7QPeThvOLLfDE+IwXl/0qsH1Nb5jImCFvigukNHiRtG8SyMOs/njSAbzYPwRzFI3rOoKXDJiO49xBSW5yT3Ty7EJ/gOjigTI4A1S0xa2qdMKXdIdppXbjMShkeAiu1NpFvFsQu4v/YRRofOQZ+JQ1LHDxiJ/PwzkhZVgFsSk/THsTit3FtjC3RB3TOblxXMfBP2l5d1MhKMtRfpnSk+ArbIF4ReyjcOAvi6rVui4pN4Jn2iGVsPlHRyqhCmuW9J1mGjGNJTbd7hth4GEld8aBQigh3LmEvj5hs73v7zpU35SzWssoueWimskgsgEfCJZ3lKcHMb6aYd7MQxhFyfiOpluRuPwWkbBeUKCPQvpKiGgZN2yW5eWoSRsmMeAeC8EUjitoTG6KxhhKiXybthLiHANNTpxzAk57v7d8iSrWBf+uxWrZdC0NsO20mBOaBiuuU4Zcus15+S3Fc048=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199015)(83380400001)(6506007)(53546011)(36756003)(478600001)(71200400001)(186003)(86362001)(38070700005)(122000001)(38100700002)(6512007)(26005)(33656002)(6486002)(2616005)(8936002)(76116006)(91956017)(5660300002)(66899015)(66946007)(41300700001)(66446008)(4326008)(64756008)(8676002)(66476007)(66556008)(316002)(2906002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wX8KMFBX//PX9d5OrdiwIaBFja2orpDZtg1/N7cYQGsL241ublB5r6xk12O5?=
 =?us-ascii?Q?GdMfexxlnuwlPp3zeFRLUU38Fm1/JCkWoIhcjUqU/VF/fwSMBnx17kgQJQme?=
 =?us-ascii?Q?tfb3b0gAy/lqrs9tPz9ThSQGks8kZ/PvBB9A9jv/2iEitBKHotLS/5YXGg7Y?=
 =?us-ascii?Q?5ehSHOc80M25EQEwAqCdHqbvDXJf2dpBrReyY7ozLzsGmn4ZiCL7SKRZwkDh?=
 =?us-ascii?Q?mwnY7ietLBGA3B5GEobwB7Zej91HEasoq/ZrqZJfwuO+zSGVPehEZ/d1xGgj?=
 =?us-ascii?Q?LaDvHBHHZmY8TUfdBaFrRvzwk1L+Etlt1tl3ywNBHJ+9lzGNqEbRUHfy+kqI?=
 =?us-ascii?Q?SZWRmQjYykq4uQDTZCqgFQj/IoZRUS+p2kpUzQ0X/rSQvnwidYr68kmdU1b4?=
 =?us-ascii?Q?Tq4BVbdys5v9TPM5Hj3jjeW3FMTaSZJRj/WjU74uEjMeHjf9JbeEe5Tmdz+U?=
 =?us-ascii?Q?9bHOKGzaVKFGFXDz23NqI5fZOtgOFUdkzUQkkKpYZXbEdD5IVPcJ3YjOY9fX?=
 =?us-ascii?Q?dGlHYqYpTS4gqxKb3pv5V+BSXu7lM8SqK4E4++MpHyKSzf8oJR3R8ozeJA4z?=
 =?us-ascii?Q?6X3d0TNPJ4HNBdw/wZUMaIQ2ZI074cMLliOVoCW7VsV7ISTLJ5DK4M7Lx51I?=
 =?us-ascii?Q?3jMNoKHaIc/EJLolunhEqSXKB13iFDWeQJ7ZNnjHNkqjJYllaH0mQ9a2XgQa?=
 =?us-ascii?Q?gwnvJwQ89tSfvnEGeNXkjvHgZs36X2cL173wvsgaJu/51otZpC7ER+UT/KPB?=
 =?us-ascii?Q?Y/VYwlnuP+f6SU3v2Plu0P1nhga4XpPeZamSAJUJkiZ8i1mEpeRqKkfw8Wd/?=
 =?us-ascii?Q?TKLnlldNfJpBb/mzAVKILjiGgC+kdrlSH15F6Xh6orJk5iyCcBvfAW3EvDyL?=
 =?us-ascii?Q?3S2ereagIVwiHWaYbnsSZtiT9rfk0CGfQ01NbfJHeJfWVwACPup+1d2JhCih?=
 =?us-ascii?Q?RDcgChQ8Nkgvdv67UV45cosbp4mT2Prhq1RbPgllIJE1cvCmEyp3fUa9Rmy9?=
 =?us-ascii?Q?KzxNu7JHukwNIiezP/mN9R5CxHbyTvsp5AdKbYMcckWHi2PIkjCV1JmuqUIr?=
 =?us-ascii?Q?ed/iOm/6BYUP01gmycbzxl4F1QJ49MQSVthdfakaIlWlO7jEsBb519tX2czy?=
 =?us-ascii?Q?l1fCDYahyEtCFuQ7CTe0X8BnllpG3FlYz3VGVl89Vbbj6bRN2O88xuLSBsV1?=
 =?us-ascii?Q?H5/F62w4oxYoBRnUMmV8Xzrqr2a+6CUeEEhbj6I2AOIOqIA6QsybA09Xup2h?=
 =?us-ascii?Q?aNrSk2lTiN9VWdK6i35T6Zoln9anFTLkKjwK15WQcUdatei6xjQeVCxNm21N?=
 =?us-ascii?Q?gFJcmJf5LYxub3X1gG3clreORd1a/XKAj1Iz5RVfKkq1lIoMiFrSOALILENP?=
 =?us-ascii?Q?HIJxTYGAlr7MYptjHSBBEtavOJINx49cuNGmETeJ6NrtVluBm/LZ9tASxXs5?=
 =?us-ascii?Q?ntwj/a1lxQsOKOw72sHfLZgBrLsl7JW9MpVWZzqs5EC8VyFpjSzENmez4xtZ?=
 =?us-ascii?Q?3hF0ky63pn0TIBW8mqEuPuMieToWSCg7XYQfZx3RMBTcz5n+Q2d3tgXDX+o5?=
 =?us-ascii?Q?3BKr2HmLzgBBcu15opemCtaOpyjVWB4DcKQAdgAQl3gzXsdHjCm7aKbekA+/?=
 =?us-ascii?Q?sQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <707BC82D96C3C0499C4B062B4588832A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8mncUECC5T3pacTeCauBkvrESxfh74EHn2+KXm3Jv4lNDYMEVyKpHZNz8cDadrY+ywDMbtjIqGK3H3Wi+DOkNveS7rmz3mURMRaFIPFjAoZnomdN+5iNq1Kr7YcgeTYP4aq7HzSYQck9txlUTulzrLQf8mSVZC+xeHG1pdT94+KRBCRY1MMBQYyfcdk5CexHB74QL/Is+1FgWTnnYOx1Oe4gZ4ZjPKVd/fMe6tlEOv53HbY1WKbDg6iXgbhuOPrbSPbhzGse46osxHwEcCTn2FCgSut0UGIGg4eqwKCGQCOxdk1W7P8uDwF/t3pYlkSdyITP1iW9dQ2wqrS7lkYx/x+ia+1kNRKKxJcUUswPZm29ytmmP4Jbzeu5qnB0InIi7oodtVL5DyVDp0DutacMtMUdQOKH6wWvmBlEaN+AYmU/QCdXlCShOcmJJrvhS+g1HFvJpVXavicwDTPK1Z7OmABx9J7V3g66ZhxER3EBDdeeeyYNP0h17tBAOkgHE2om+G7m2FI16+gEi5Mmhd8tEP4yu7CLkl4VlGuXW4XTDbw5xbWzFBvjJyYSjiSqFavr1VMbrcgU7THOMMX5mjDtDMJRZNLlHHlTg9ght2uvxNQPi/HMqpqsHHzVSJwRPUgjRrgIrwjOiCEF2LldYvjli1CHUpZasDSczUZAWHDCEck2ajzRXi1Y2jDwJHf2BOR+13MpuFlOdTbIHCq6dLUG87EZJCWv1LNdgfmv2itWLeg696jyfejwdMtlEE/8B1q3GiPRPOSH5S1Q3fMWMRMG2/IkJAD9PjwmkHRfs7uqzJc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6100ef84-2db7-4bc1-c437-08daef2ba28e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 14:46:31.5619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJsMDfEjgGVT2gSkQ6850un1L6CV6WmLHAP/YXilpzvuMGYDwZzGdeHwQteGp6sthqfXPr6xbWN0c71WcGMXDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6368
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_06,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050115
X-Proofpoint-GUID: wCg3BsyezU_7gpvwF9fopMs_p0kPIiHp
X-Proofpoint-ORIG-GUID: wCg3BsyezU_7gpvwF9fopMs_p0kPIiHp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 5, 2023, at 7:18 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Even though there is a WARN_ON_ONCE check, it seems possible for
> nfs4_find_file to race with the destruction of an fi_deleg_file while
> trying to take a reference to it.
>=20
> put_deleg_file is done while holding the fi_lock. Take and hold it
> when dealing with the fi_deleg_file in nfs4_find_file.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/nfs4state.c | 16 ++++++++++------
> 1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b68238024e49..3df3ae84bd07 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6417,23 +6417,27 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state =
*cstate,
> static struct nfsd_file *
> nfs4_find_file(struct nfs4_stid *s, int flags)
> {
> +	struct nfsd_file *ret =3D NULL;
> +
> 	if (!s)
> 		return NULL;
>=20
> 	switch (s->sc_type) {
> 	case NFS4_DELEG_STID:
> -		if (WARN_ON_ONCE(!s->sc_file->fi_deleg_file))
> -			return NULL;
> -		return nfsd_file_get(s->sc_file->fi_deleg_file);
> +		spin_lock(&s->sc_file->fi_lock);
> +		if (!WARN_ON_ONCE(!s->sc_file->fi_deleg_file))

You'd think this would be a really really hard race to hit.

What I'm wondering, though, is whether the WARN_ON_ONCE should
be dropped by this patch. I've never seen it fire.


> +			ret =3D nfsd_file_get(s->sc_file->fi_deleg_file);
> +		spin_unlock(&s->sc_file->fi_lock);
> +		break;
> 	case NFS4_OPEN_STID:
> 	case NFS4_LOCK_STID:
> 		if (flags & RD_STATE)
> -			return find_readable_file(s->sc_file);
> +			ret =3D find_readable_file(s->sc_file);
> 		else
> -			return find_writeable_file(s->sc_file);
> +			ret =3D find_writeable_file(s->sc_file);
> 	}
>=20
> -	return NULL;
> +	return ret;
> }
>=20
> static __be32
> --=20
> 2.39.0
>=20

--
Chuck Lever



