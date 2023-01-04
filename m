Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED0F65D590
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 15:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjADOZf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Jan 2023 09:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjADOZf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 09:25:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99F838A
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 06:25:33 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304EAxZo013115;
        Wed, 4 Jan 2023 14:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3SiC7sNBGqrbDBKH26V9ZKaCun7mkB7Ek+v6p1bVeQs=;
 b=G9rPDmSFYeKV8J3C0OflYJljFspr0Kqi2XoVwMNulzOEgBFc4tWhy3pCYJT5TRoAaM9m
 J19lZ2apKjWwi2wzIgTQTR4hdp3MZ0o9nCMc7Krv6iyu7jU+BMLKBjMWFljJGfG7iDhb
 1TLC/+fkghPiCrFnz0Dm4cy6/+iC+AKgRXVFqLALqW2Vt0epsu2aQGs/DQDck1FjeIqx
 Mk3Z1SYMEKm6CahEiRuDIGaT/i5nVzPz0ccJjIgjEnaeLooSa6yy8FZSVWs5d3fUfPrX
 9bDYEYnvwfBBg+UFZmOy5VwXzZGilfg4OhlXfy+AgRnBhelYbKR1BglXkef250gkudtJ hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcpt6jkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 14:25:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 304E4GjV030602;
        Wed, 4 Jan 2023 14:25:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwaw6grpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 14:25:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3TOzkX7ull/pCVzHJ8Cjf3IgQR60l71oabFfT+uMG3iZyGsWVEDgoZZDQ8w1vMjcptjKmI0gwwNEoqKhsHTTme08tO7QomQgMW1bsWArhTG/q4KjJKSiJQkz7igB3ApsbiBBWk2phVkFiGJ3aqBsTJOppoCDPUWZogaOVE9biURJcfQg/zRoUN+plRnzvi/PIipfLeWCcAESvHPqothzgL/wzzrVGOk+qVcamJ0wzaNAffqz0Tn+WoL3Mljf9u0OGVkcnarfMvwJWTyHmvmCsUzPNpm2shkVzs723tg0PxpBPRKlLxei/qFIxgWbQq+BfDZv9MRWupEWP70yx+EoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SiC7sNBGqrbDBKH26V9ZKaCun7mkB7Ek+v6p1bVeQs=;
 b=SIzr+NKy/LVRBHcqHz6uZddjxjB7zqlW8/2hh7VOGsqJoUSWkf+Seb6Qri4TUBWOY4Vtz+FkldSZh50nKJjss2kT0AYhEtd7/CWDt3bvaRhIvV58QbtELzXt4ORe67WXa/llPNv3Y83AV1Mw0woQfUd1c3yvdDzQqyFTz99DRAy2hYgaTPSITl6Cz1L5SlMP3XREX/V4MWmKn/U8IHZZ+kFNYUWrcltPPZIiAMoqGGSXxoSy5nygvydBvURw99uhiHrpT4+OL0LSfo/ExqZBHPOmRH8mPx7lAalyrrHEjeYl5lvPKy/K6+/SlueJ/Quxzf6xvghdP+n5luIl3CHakA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SiC7sNBGqrbDBKH26V9ZKaCun7mkB7Ek+v6p1bVeQs=;
 b=UzpQIBnXGWGCky8A4PeCGHuXnAbTkA/2r8HfMmPo5xfj87CelOjnXJf1+FfBidezo3SJS+5dy47k77E/FfOEOqq88HMo3vPgfUrj6OIXpyD5EhzUVnCyxAxZsYoKORKNsdmLXyl1EjLvDwv90wks4B1/pxRp2HMVyA0knt0L+hQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4433.namprd10.prod.outlook.com (2603:10b6:303:6e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 14:25:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 14:25:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@kernel.org>
CC:     Rick Macklem <rick.macklem@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RFC:Doing a NFSv4.1/4.2 Kerberized mount without a machine
 credential
Thread-Topic: RFC:Doing a NFSv4.1/4.2 Kerberized mount without a machine
 credential
Thread-Index: AQHZH9vamVQSE8pdpU+4JSLI/7+74a6NhDYAgAAR0QCAABflgIAAoyIA
Date:   Wed, 4 Jan 2023 14:25:26 +0000
Message-ID: <FBAF6EA3-D78E-4F62-ACDB-8582973B4A93@oracle.com>
References: <CAM5tNy6nfvuqM30DwUVjTFHfewL8tSEQcyEJsSBzyWMTvDkEQw@mail.gmail.com>
 <e9fea39e926486146505c385dca50c116deb22f9.camel@kernel.org>
 <CAM5tNy7GM-5m-O2GUBwXCY=psSN2LKiE4bPPFyK=ABhObMdFCg@mail.gmail.com>
 <6ed7866da1e57a46da0108e9581242cd7f1ef2ce.camel@kernel.org>
In-Reply-To: <6ed7866da1e57a46da0108e9581242cd7f1ef2ce.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4433:EE_
x-ms-office365-filtering-correlation-id: 52887d8d-bbda-4224-8236-08daee5f8650
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ThjTToAZwmMwvTe+DVqKZTQU6kaXgUBsJXgqJRiLx/9E9xTW+u0XBFGKoBlfkH/m6ewTNIOTQb/5X9mWEaSD5c1M3Os/lA6CICjARVUzkwjCMz/jxljFOuZ9EmrIaDfoGkHeaKPMWR35rytsbxwPNoxYqPiZfNlRqmD1gRBwP4+zr4IYFtM9b0b8pk55nGP3bFs5j96YeT0TzSe36HKcqAnANJkkimG0B6Qgfve0S3aG5bGzK5zonZhpkTLGlfA5vRkP+irOutxRdPUZ7gKmbwJfWvUfy0wTRb4W5W445LjRUtSw1uz2YYXTLv5Z6OCm/43OrVutG1BJbH8dygxYmA7sDBAVFmMZKTT4rPcm5xOV8EfYkoR+8xm0gSyIrTATwE8kRiMZcreu3au4diahwO8S08KsQpQskgLO9pLlT6Yw8Q/ItkYE89UwnXp+3SjwusZyyZwp4/ARWLAfCBAemi3U70tWyfWIrlNzElmj5albsS7y8btEgnyGsE1W1ZEfJVzF5vs46FBJZ+KfTIp2sD+rMpB+19lrFfqBbiG5hTtvz92Ufjhp+BHuv/ggTgq0SVkZX5auBfvjbFoYcMlqdGdzvB111MwnHubqUq0RlbBSVFQEkRAYjNVUBsW0+61lm/dsGj59oujW0+vhqvSttKtqqbl0Y8YK5oJyOI4ts8JZ6o3Rnat7rIliH07Uhm+MuJ9VZdBOrFjzJVMT8Y8fe2aCWwvcsv4o8VYn+JhSqUc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(83380400001)(6512007)(26005)(6506007)(33656002)(86362001)(38070700005)(36756003)(122000001)(53546011)(2616005)(38100700002)(186003)(4326008)(478600001)(41300700001)(66899015)(8676002)(2906002)(5660300002)(8936002)(316002)(66556008)(71200400001)(6486002)(66946007)(76116006)(66476007)(54906003)(91956017)(66446008)(64756008)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wnZYzw0V8XHP0BdV/EOwp3wpePTXxOCNRWBmc2BJQwt9btemJVxZODq7pph8?=
 =?us-ascii?Q?Ot3k1fpFdk0H1ORE9TnnpXxK04DJJrLqDmIzjR+2WKi3KbvYgeWk+gNTKRbx?=
 =?us-ascii?Q?Mb5PqBynIi7ShoJZCqKiqjFigTpPDh8//1zsDjfR/fWhacDW8dYvYBYBn3lJ?=
 =?us-ascii?Q?vYHJuhUm+kIefrBl2/p3G+DGpP2kU2f2ih21cxFMLABaGUJfM8aYSPbVuK7S?=
 =?us-ascii?Q?tHuLfpUEgHXSY6L4+Y+BjrjnbimK7hfvZKUTf+i9tabaAyegnca4RPOZ4UtW?=
 =?us-ascii?Q?OHVlAe2rOgSWgvnAF9AhVKHTmZjEC7gmKFn+zHeAtggaMXJg5QhMOcyZ3oYm?=
 =?us-ascii?Q?lXKYEYI2bmEmUCEUKhwSf5jK3YLOLHTc4gtf+KQpjpmNkkk8fB8QfXqh0NZQ?=
 =?us-ascii?Q?tRbJoOOFquFCKrIC0bghNJzpNPJEpT0vKvk5J+5ekbj001JDEA9t6p4TzwbV?=
 =?us-ascii?Q?H4qIpQ5Iyi42y/hhPtOl3P9qVi4OFlypigCH6Ke+A8piAj+abD2r7NvLX02d?=
 =?us-ascii?Q?JV5351BuM6zHI9+yk6pbdPXv6L28JcXniWv3HD1oXpIxGeucQWpSNM2HNbrq?=
 =?us-ascii?Q?wJZxBSYGyymyrnUjwzeg9r+k8YvK2ZePfojjGDmvUguSDVK1nMU0WLphqUaL?=
 =?us-ascii?Q?ppPqkq1CNP3k20p4X+1doDBTgmO3tlt3QzCCD1cm1zfDo5e++6R/Qn24qI1z?=
 =?us-ascii?Q?mC14RwVswfN4et1kbCRE1TNVJNqBCd/P7WgDp1Q7ac2scTD4UU89i1I/ETab?=
 =?us-ascii?Q?AzNkpXAcS9PkmUJ0HdUvx5hsAiW4fYPrbEcH+bulLP2Onkho/DD+pXxQWPN3?=
 =?us-ascii?Q?aVlXil4r4eXRL2AWtTwWbEGD8mI67DiUYFmoaF+2/EFctEo6WCOVnCay+Uv2?=
 =?us-ascii?Q?EIoOqwbBbK70IrGAgk02lzTZhj/w/4XAkZl4yGVuFVs33sXG/P47JFXJOCYE?=
 =?us-ascii?Q?ToeyRTftbD6QMnB1fyqiv/aCdw9B8PvdhZjWNziRbCUrtQTdDoc//O56K7hz?=
 =?us-ascii?Q?Mx2oMZuj1FdHwKX5EOv0+9dSkHpT34DMqf8WnWkQ4iw6htyOJm8cDEsBCVCa?=
 =?us-ascii?Q?Z6GMY0sKUQdBosYbDErh65FHOc5UCqN0nNhjsD/A+goOkDIQWh+2JMlpQ8LL?=
 =?us-ascii?Q?fUW1bgSxIXvxpRudcBrWOkOt7a/0ZQDZlKIJiH7ahALFyB6TjmIpv26P4FMc?=
 =?us-ascii?Q?jiRdDbKRrzfO5Y5j5qr6g0YwDms1rlGKgVsOQYuH1uCSy/7KczC6qlRjrhju?=
 =?us-ascii?Q?EhDCNY7bU/VCt0okKHCOquAV3VdT/0DiM0MULbchatNyV3KoaUH6R/AK+M+P?=
 =?us-ascii?Q?ndnrjkcvS4wHsur7MopwOXhEfJeFVc0FZPCbS6zHOET1DoOFJaLigBuGYXT5?=
 =?us-ascii?Q?fon4fPlAxhy3eOeIMMhzR9RjlbugpONNgNQvqYSXU+H2eL8iZZHZv4SMiTcL?=
 =?us-ascii?Q?LJ/A5flylnE4X4Nk+EzfZArGVXqJS15zxxqTceYzYzX72TzTm6G2AqWP7tNj?=
 =?us-ascii?Q?pB3JPQdddNksQIF87Kmz5bZNV7V4Ji06eT9pLclTW6YoKaKvCJLEQvc0SCTB?=
 =?us-ascii?Q?yz9M5KMkMttpw2VglzEJkln2rNdwm/hgCU0GIqj/feUTBEu+eWkO3OWuD+tP?=
 =?us-ascii?Q?Bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD3311104E03C145B08D3B372EDFCA42@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4Z+uyAyZoIXZGkPY/bJFa33xrJ8uy09GiEb+Oe334fdWSWbkLOpRRS9dxrH/2rsoXN/74EHRq8JRCdV0iIhCoY5R3jxXm7oDDZakRIepJD9F6H9QOWIBZ+hfkP2v85GFtCIfK0OcKJHfG+j8R65dpZvd8Uqv5QRB+j0Px87NqWKdhy3R3mrEy94o5Oaoli4wRUge0MFKBHqFn4tSUcgUExuZUZ3OIVE8j/WTp4wAgF2gNxugdd/E8mbvRwVxybXPeR0dGlwikgSwmdGNtFhHz09sxu0/GbyFDRrBodk9JOdl9zxKy+lfXWfVLv4aVcPqv2JepMfiUuKmXWuwYRukgJVqtm7gRn7HpTJtOZ0z9TSaWzvrFhZ2RrW1U2oj5DiIpH1MQ55KJDtRItVDC92+fWuFx4J1yKGzvZ2cfliZw+we9l4Ka8a0GIds0h+H6LTuNGolgozfJGoGaedRru/lbhMRH1VV6xHle8Pg/A/LH9yLp2QOIWkUxIx/ingDMVRbZN4MNpvCu6q3J2TutgYzSeRruxwEsdBmWO+XvxbIOKmPHN5RP3cW5qMf/9N5P8AaVvik8AG2r5/g5AItNx1bjlddQR39VT7WRbxq0ItiUnwliPFMwJyD9dyE43KEPTnGl1Z6xa6KH5kKK6PZAAM3P6tQhN6WAQcwo/ABRq/dtvuSC3Ag80oBzP3d2/lDdaOsrXULKAzbSATzkOGg8wd6KZL4fI3GXLJg9QW19PnSYHIaw+S5NjcT5aPUbY80JHvL3tvaA0g1RHDeQrXOAbspwqMcc6fA5u/KANg9Ia2Rgdi0/4QN/G89W86F8Bq6RVIs
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52887d8d-bbda-4224-8236-08daee5f8650
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 14:25:26.8448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCNd9ZuOvXHK/NlnVOuAfiiTkIwy66zGUH0U8Hqt7jbSMjb3i7+vrhpD12ACi55SsisqVm3PK5Z7e954P1ut0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301040122
X-Proofpoint-ORIG-GUID: Z9j2Ndt1xkKCCM1vmIYNOb1pZXS1n3xN
X-Proofpoint-GUID: Z9j2Ndt1xkKCCM1vmIYNOb1pZXS1n3xN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 3, 2023, at 11:41 PM, Trond Myklebust <trondmy@kernel.org> wrote:
>=20
> On Tue, 2023-01-03 at 19:16 -0800, Rick Macklem wrote:
>> On Tue, Jan 3, 2023 at 6:12 PM Trond Myklebust <trondmy@kernel.org>
>> wrote:
>>>=20
>>> On Tue, 2023-01-03 at 17:28 -0800, Rick Macklem wrote:
>>>> I have recently implemented a NFSv4.1/4.2 client mount
>>>> on FreeBSD that uses AUTH_SYS for ExchangeID, CreateSession
>>>> (and the other state maintenance operations)
>>>> using SP4_NONE and then it defers an RPC that does:
>>>>    PutRootFH { Lookup, Lookup,... Lookup } GetFH
>>>> until a user process/thread attempts to use the mount.
>>>> Once an attempt succeeds, the file handle for the mount
>>>> point is filled in and the mount works normally.
>>>> This works for both a FreeBSD NFSv4 server and a Linux
>>>> 5.15 one.
>>>>=20
>>>> Why do this?
>>>>=20
>>>> It allows a sec=3Dkrb5 mount to work without any
>>>> machine credential on the client. (Both installing
>>>> a keytab entry for a host/nfs-client.domain in the
>>>> client or doing the mount based on a user principal's
>>>> TGT are bothersome.) The first user with a valid TGT
>>>> that attempts to access the mount completes the mount's
>>>> setup.
>>>>=20
>>>> I envision that this will be used along with RPC-with-TLS
>>>> (which can provide both on-the-wire encryption and
>>>> peer authentication).  The seems to be a reasonable
>>>> alternative to a machine credential and a requirement
>>>> for RPCSEC_GSS integrity or privacy.
>>>>=20
>>>> Why am I posting here?
>>>>=20
>>>> I am wondering if the Linux client implementors are
>>>> interested in doing the same thing?
>>>>=20
>>>> I think it is possible to extend NFSv4.2 with a new
>>>> enum state_protect_how4 value (SP4_PEER_AUTH?) that
>>>> would allow the client to specify what operations must
>>>> use RPC-with-TLS including peer authentication and which
>>>> must be allowed for this case (similar to SP4_MECH_CRED).
>>>> However, if the server forces the client to use RPC-with-TLS
>>>> plus peer authentication, that may be sufficient and does
>>>> not require any protocol extensions.
>>>>=20
>>>> Comments?
>>>>=20
>>>=20
>>> Are there really that many use cases for this? If you are using
>>> krb5
>>> authentication, then you pretty much have to support identity
>>> mapping.
>>> Unless you are talking about a hobby setup, then that usually means
>>> backing your Kerberos server with either LDAP or Active Directory
>>> to
>>> serve up account mappings, and it usually means protecting those
>>> databases with some form of strong authentication as well.
>>>=20
>>> IOW: for most setups, I would expect the machine credential
>>> requirement
>>> to be a non-negotiable part of the total AD/Krb5+LDAP security
>>> package
>>> that is implemented in userspace. Am I wrong?
>>>=20
>> For systems in machine rooms, you are probably correct, although I
>> think many of these environments would just use AUTH_SYS, since they
>> trust the clients.
>>=20
>> What about mounts from mobile devices that do not have a fixed
>> client IP host address?
>> (I suspect that, currently, they seldom if ever use NFS, but I think
>>  trying to support them could be useful.  A mobile client can use
>>  a X.509 certificate to do a reasonable job of verifying its identity
>>  if signed by a site local CA, although it cannot have a "wired-down"
>>  DNS name in the certificate.)
>=20
> Those aren't really likely to use krb5, though.

My intuition is Rick's usage scenario would be common if we made
it possible. It's similar to how Windows/SMB works on laptops,
and is a common deployment scenario in campus environments.


> I've been thinking about how to use a public key infrastructure to
> provide stronger authentication of multiple individual users' RPC calls
> and multiplexing them across a shared TLS connection.
>=20
> Since the client trusts the server through the TLS connection
> authentication mechanism, and you have privacy guaranteed by that TLS
> connection, then  really all you want to do is for each RPC call from
> the client to be able to prove that the caller has a specific valid
> identity in the PKI chain of trust.
>=20
> So how about just defining a simple credential (AUTH_X509 ?) containing
> a timestamp, and a distinguished name, and have it be signed using the
> (trusted) private key of the user? Use the timestamp as the basis for a
> TTL for the credential so that the client+server don't have to keep
> signing a new cred for each and every RPC call for that user, and allow
> the client to reuse the cred for a while as a shared secret, once the
> signature has been verified by the server.

A laptop typically has a single user. The flexibility of identity
multiplexing isn't necessary in this particular scenario.

--
Chuck Lever



