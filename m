Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE52573771
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 15:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiGMNci (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiGMNch (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 09:32:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100921B2
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 06:32:36 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DDDsek011701;
        Wed, 13 Jul 2022 13:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FZUHFUM+l98Xsf+McjLw3mrGSE2XzEKOGFfN5XPS/RM=;
 b=p9yArQDJAsUQjpy7/e5ElEhdYdAuKTsmLOoIfY/evnDrEB5KDQHV7cJikZcVhsfxoPCZ
 SY2BUaAtxqryLikgm9xs54dlDRTCCUWuAE3o1NMPndIu9QSMUoUo6R1vjE05Jab+X6D9
 o/db/7peiPFM9wQAb87+kG96zDfg78/WAfVN1TWjM/S0OcMKJiYoXhhhXsF+GMCLtXZ5
 i15RW3sJBoTWIfXxja448JzGlWf5Y1Ug+UrGqg03fAnz3YTC3wNP/8h7GLTDou9Pecs4
 pyvMxwu/+yuYj0jd5uhu0k+O0m9mgq1Cu+WeUKUoUoS94z6JvxiZ1x6h25MOJN+191dM kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r19vdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 13:32:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DDUpej038904;
        Wed, 13 Jul 2022 13:32:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70449ja1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 13:32:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbWILisMgOY2fZ8cYwxV60iVWqXpEJTDavUM7GKUPZjOWQs8qBlLFmi4ogbEU/HCg4D/LJL1HfRk0d2AO7ZmD2/V687QB1Srbuy4iNRonEZd51mdMxyFHoZV5dGjTBo3LDWieAXfGyQ3ON49J6YvrC2VEz4JiMx/gWkVff2Crdqt7wsJbUtHo5o+6xLI++6WwG/dEyyl3no82LhtKDkfLuhOwsEoLlko1DEEb/rIcPoGsuAwSNfMowIUvnUqsVO/q/40Ct1IFAku2ZwBQ0iwgpu8RGVr9PAlRCUnSsZM5zoAA71RLYBi2TkifZwl3eiBeJJS7IBlGYi2HGHZKsOLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZUHFUM+l98Xsf+McjLw3mrGSE2XzEKOGFfN5XPS/RM=;
 b=P0ezZ9d8LUYUvPH4yjPsPndxIvK5T/qwQzh94iFcpILuwIZwEFVGRGtlVu4AvSslIQE0ETaXUH6Im3JYSjo3JaxhxHF7a2ykt6seJSEqiawp5CO7FvnLLoyC+8Qn31JT+9aaPzzm8LgAgqhF+2JZCs+ljc5U9ic3DlfTlTY67QJ2i8LWzwbpBqGEpedKDVexjDpNdoj6lfIgiTCxw6E05KKfvwKDg6UJngWW4mqfoCxF/WRfRrUVtvixgo5Ff8DUS8E5DmIA0fbr2d9lU4aPVylB6vSVJ5I7L3l3cRabRgB1Zti9/W9z7W0xp32aGx9zEPqGavjTNtudwv1PHV4QbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZUHFUM+l98Xsf+McjLw3mrGSE2XzEKOGFfN5XPS/RM=;
 b=ZJTyVJya/RRKHd9KEs0b3OcUdds6Rmb1wnm1x+zakpgWfmvXdo4CHjrkBpbYXIqwUC5ntKNEDw/wqh5u37Vm3BE5X2ZRJk+az+P4FPbBWIViZCSfmW33paYgiSAE9S8/lJyFcIX/z6n4+0gbn6rXGaMhgv3Z8tqWG4VNecqaugc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR1001MB2393.namprd10.prod.outlook.com (2603:10b6:4:2f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 13 Jul
 2022 13:32:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 13:32:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Rick Macklem <rmacklem@uoguelph.ca>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>
Subject: Re: [PATCH v2 00/15] RPC-with-TLS client side
Thread-Topic: [PATCH v2 00/15] RPC-with-TLS client side
Thread-Index: AQHYebVuZqvrXSpmmEGc/2a/uQZ/m6165IuAgAAUJ4CAALlYgIAA0cqAgAACuQA=
Date:   Wed, 13 Jul 2022 13:32:24 +0000
Message-ID: <053211E0-E588-49B0-B884-CA4E98C66882@oracle.com>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
 <c9b6787ba9154d1f4c2bf25387a35453ad20badb.camel@kernel.org>
 <F713FAF6-8910-4BA2-86C6-C5B09223AC0F@oracle.com>
 <YQBPR0101MB9742D7F0D54EB37CE9B476C4DD899@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
 <1FDB511A-646F-4E37-B95F-F83E1ED26796@redhat.com>
In-Reply-To: <1FDB511A-646F-4E37-B95F-F83E1ED26796@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ebaa42d-2106-4fd5-f919-08da64d41f3d
x-ms-traffictypediagnostic: DM5PR1001MB2393:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PV0sfH5O1PFnhVqBl+GXE5vGPM1eSKNMgJxPV2Cm/5g9XJRSzEqVaHKdCfkn23+s5k707/IgsI2drW57+So9YqXNzv+/AeqNcFVHaoLx+O4ut/tFUNhj+MMs+nARGBS5LUxTFkF2LmjHHOVm1m9RLb6bgmEhp0A/mtXgJnTR3Sn7AtIPKTCz90pHE7zL/UokY3d7nSUEekPKNzRS324/y8gfPD7qxi9r7HgKfym1WOX1OwX77lYL8bmARcI0mRk6tdIuNfWq9rA/lwFpmIaE4u8cwV+DrFsh9dTsLzZtofSLdM3tvJPtVWhjrY1rB9eCgJvp5hPFl65BLlHZ0ySeZliZ4mEBja2rok8rz6MYQ925s/fbwV+qReaBpvQwro1Ei97rk47qFjZBj4ZrVHdF5JtB4xuzRoD55WWI8aM0ChTHeJGZV9+QZ0ybDAJhSIkG/DweAyzX5TebShAIp+goW2w59mLkCprJvV4WPIi9YLjw/aZRNmJxv5E1TNmKKiG5jPj9EYVl2Y10V2LWA5FrGy8wrf7LOEuZu1Q4MwDI+uk80pViurXDkR5u7aFPu/vQjL7GTt4T9uwjyBhvzEqMIaIJ9CqAXa7exkThKZCOm8aG8XTYc5tVcXo1sTkhRya/cbnhtpBUsdqIqEPq5ZoytTKzQp14p9bi6SH0PodUqs+yVdCa0YDbRzc1N7tVmZJ0C6yhQmvuG77eBo2PMUKF3PoDtt3el6H0PP78Elfxc14JBnuyl+toa6w7jGYZ5ox+gw+AkCsGDVuXM8V/8guPftlh7yoiiPZRprtPG2LucXPpaB4A5aZfem4K5arkcl6riMYtn1Tmr0c6habQqW5DHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(376002)(366004)(8936002)(4744005)(5660300002)(122000001)(2906002)(86362001)(38070700005)(33656002)(36756003)(38100700002)(71200400001)(6486002)(478600001)(91956017)(66446008)(66946007)(76116006)(6916009)(64756008)(66556008)(66476007)(54906003)(316002)(8676002)(2616005)(186003)(4326008)(6506007)(53546011)(41300700001)(26005)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/bdm7tjbzJGLqwj9LoOzHJMKcWrIo/dfGj3Pr9+PMFJ2wR8y7Z72pgr8Qyq9?=
 =?us-ascii?Q?sMTd3yZfFe0tqhJ7iNFBr5HusnMnXGcKf4nCdINOCvRUyIwe7ZA5Sg52G8ga?=
 =?us-ascii?Q?xO0nbCALnrsUyWYvpPjSvN4I1DmFut0jV3zdkwLoCyH3jux//IzDbw/ccPwh?=
 =?us-ascii?Q?LbAcUnayzEJyMKsD3S0be236PTNAiR37QtftQoI7J/7QwrixeiL3i8mi+MKz?=
 =?us-ascii?Q?Dwif3Ye75Sevrnx39XqpPys4tlvEcu/KrkbBOWG1iLoZ8gt6xycFDhSScpDN?=
 =?us-ascii?Q?t4gSPnj+qTkgMrKrKQfMJFrmhydJZRes/mvhLUVtZbY51casiW8do1ROtFP2?=
 =?us-ascii?Q?Y9TmUfUUz61GLr381lrx5VOydUIUvNKfy77ICujoWVJcHDXCFcTDy6hap71e?=
 =?us-ascii?Q?1a8I/FokIvYu7Tj0eTdvMnMZ8ANSpFQLP9kZw4ia4h+4CTDrTUYIJs5RUfOS?=
 =?us-ascii?Q?x5V3hfDNYbSyUxnVjHvHcoxYRebfuWVVZfRbsuLB5OkviIOq9VQe7WvFYIVO?=
 =?us-ascii?Q?xtNUsnCrWrYFwBK21bMxplpqKCgr/4YiaCw+IeLB1NoHhGB+iVB1bHHDyChN?=
 =?us-ascii?Q?0LAhN9nn5Y3tEBTRAebKAh93Gw+eyj+Q4oRDKpewbF49fbUv5tZaQfkaZzQi?=
 =?us-ascii?Q?Z/+0fIqc0uiEuASutyu4XqBPLCu0TqOkkb+n42WPNJKsDo/gP41pp50Bz9nE?=
 =?us-ascii?Q?uffkDIrIKmdbE4njRDh4gsg+U9UOtjv+qSe7fMd6mVenaiEJw3bdrsbmjism?=
 =?us-ascii?Q?lwL5EoLxE3uxWa6pwfwYHjioYs1Hksm0nIIUAc6Rr3DwM+CKxQSjWtmuEdPp?=
 =?us-ascii?Q?dibxZagl0X44CXAmp3TlTedxrA3GpxwxhxB8lPeDafHOBkd3AUJF3Qsw4R0Q?=
 =?us-ascii?Q?g78kNJ5CNO5t2ZG6HdHodjTnNY7C3XFVIzzZ8FK0t1mzpfvbkV9fZxvzKzzp?=
 =?us-ascii?Q?wujL5QJiTPBZ1f1XLVB4f9C8VM1xalRY9O4hyomkUMc7+2F3Vz3z7syVfl52?=
 =?us-ascii?Q?sDhlb9OrLH4Bxxh0pH4R6cF9MXXYt3xjrTEvCVeyhv/LorQOQ6T6g0gD3OW5?=
 =?us-ascii?Q?P4j1Git1kguRuUgEY1OMEfH7necLz7jLyJMFE6uZfyqg8GD0laSqPmW0/cvt?=
 =?us-ascii?Q?Pyzi2nrvfS5ISEII7Cnwnzg7DA/IY3N4fBDZkdsn+XS0c4x04JCJa4EicnRn?=
 =?us-ascii?Q?MbrkkXIhHFaU1YSnVZLhMAhrGVZ/W+H/IT7mm7Z4rdeepA1VazJZoeqP9u27?=
 =?us-ascii?Q?SqMuHwJpakMYek6eNgTgSUW7UKgz0XRXqj1tynPBv3YnQDYMcu9cLhYcaBid?=
 =?us-ascii?Q?xN5V2wx/iD8PTufAVoH0ZTFDokXA+RMVpXmFtRXcg0a9iVkW8DxcNVC5bddT?=
 =?us-ascii?Q?+ahOCbGs5xgUlJXBx7my86OicqUG9FZnGp9MO6co/E1WPsgKgDw6AJK+AlN+?=
 =?us-ascii?Q?qLr/vOxnA0Qtri2ynYQ73vQtfgcYSp5H60PHAE9oWz3OO/N/HlT6Cx1iUGUM?=
 =?us-ascii?Q?O9db5+bP0gVbbx40Oj0j2fN+1VUwLYc8p7rnx/zfHNo+zbZ9QCVXC4vJ95Tc?=
 =?us-ascii?Q?wtSgvXG+985yGfG9vJcv7fTW48hMxLncEhVqzpUlcgIVdn+FQxck4TCr8IFx?=
 =?us-ascii?Q?yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE2998C8A526D442B883D32791225219@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebaa42d-2106-4fd5-f919-08da64d41f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 13:32:24.6033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 735Q4zAgdJv/GXmMXVfPO4dgswLIz2HNgp8ZuBznnr11YbXWoI5G/pSGvSTKwzjankB44hMnKyiTYJ7udeAyug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2393
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_03:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=770 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130054
X-Proofpoint-ORIG-GUID: t2E1qJe1igI2ZU78YEZhv8DjfgvyPjRR
X-Proofpoint-GUID: t2E1qJe1igI2ZU78YEZhv8DjfgvyPjRR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jul 13, 2022, at 9:22 AM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> On 12 Jul 2022, at 20:51, Rick Macklem wrote:
>=20
>> As I already posted to Jeff, I can put the server up for
>> a day or two at any time anyone would like to test
>> against it.
>>=20
>> It now does TLS1.3 and I'll note the one thing the
>> server did that caught the FreeBSD client "off guard"
>> was it sends a couple of post handshake handshake
>> records. (The FreeBSD client now just tosses these away.)
>>=20
>> Just email if/when you'd like to test, rick
>=20
> Hey Chuck, is the bakeathon root or intermediate certificate published
> somewhere so we can add them to our trust stores?

oracle-102:/export has the bundle and instructions, some of them in English=
! :-D

--
Chuck Lever



