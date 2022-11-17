Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758A962E4B6
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 19:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbiKQSpK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 13:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbiKQSo5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 13:44:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA2D88F95
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 10:44:51 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHGxVdP019571;
        Thu, 17 Nov 2022 18:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9TeTrr6uzDM0Wv8yyT/2sdN6wnmyhNYCyArz+oJe5Sc=;
 b=R2mM+EQCOVP+mmki+FvcdS3uAkFGNB2MU9ORZPwbK/z5ljx7AchJstr9WVjX5ik99Izl
 4lsaqr/m4kQZHUMK1AXuz1WbskGdf4uPoVs3C02QW40++4AJSw3Xpsyz8rUpa/vRGG1M
 FPR1PwMOTMx6AitxAl6CcQhSDJIDu/dVX8tMi3veMvp4ZxMU60/UwTkUQuXk6c3MHz1Q
 EKLHOfQVH+wN8ChNBX4/drurYpEQGguHzU66JF2K9gi23NqC3ujlvgxqkw8Z+oCONbLe
 Qde4o5shCWNWOb+yPTcXMTfC5TbrBQz8NCektwGOLW4Pw9r3GYtleF+UcGmd3FViqKv+ Yw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kwryb8ar3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:44:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHHDdWu004484;
        Thu, 17 Nov 2022 18:44:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x9fkgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:44:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp5p0sHTXIIXG9yme87us31drRBP2PUR8Xf+SXRPoGnmuXa8O5eR4EeIrFHALQ0fijl+jtVtcgjEHVBJ62xEk2zb0bgVXCLkHeeC44WlOh+pBEdsZiqnN20mOW8+B5LHcVH8lTuNYDi4iTJ7SRzpM0Wc17CjKtLzzridzQhRk4hpxLk+sL8naTqVowaxkL6m1vDl0k/nEPAUMFZ1wkzpbuz4NW5j/vO6IeDASRq+exo4HVcK2hkQRHBMzDRhh470kpeugRerMiA33AQZUzdUzdqjFS2DEmg4dbTUl33QxczR64Ph+NGajQWVuIZ2BYUME4LnnH8N0lc95Ow/nD9sPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TeTrr6uzDM0Wv8yyT/2sdN6wnmyhNYCyArz+oJe5Sc=;
 b=IMfjoV9IQb2p9JJ/XbM1x1Tvv/ZqaInqvYVwW9/ah0/XpQPaYObdPmbTN9Catfs3ZGRFwyLQ5IwEJ+9yR2gIS0QsC69LCvMdTTIrfzD5Q8kByhqTUBZeZBWsTQ0ommQwJgwYb15SEEbbJSirARMDolhur63vQBxsFuRrf3j5GWra4Dwom+V06Rpp3+Ddh+21uDz7AhFBhfX7mS00/cuQYgtshisGvbVSYAd+P2/xySDVUnSqXe9aCmghYJ4/CXdMAYfuHiZreb7yfRPzDzpjOGcQ8YrHy0I+Wy0pFq0v7SAlqRzcZLUokiJtnOjBK94oNuocupQw53qrEuIQSLiriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TeTrr6uzDM0Wv8yyT/2sdN6wnmyhNYCyArz+oJe5Sc=;
 b=ffg2xEWxQLKQUIQ7usUqCvNSY7iqlb1FsWw0Bfhfcn62olWo9qyuaXtwpT+1+66ANipxNJ1PBDWtGxUxeKLP0l2zTiGLd/J8Q1FDcWxRMzpMVf5sGNydfzTts8Py1XrDOHrIL6CN+5oDz7d/eZHdUzQ1jRPGDZGfTAUJBLuUsCc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6281.namprd10.prod.outlook.com (2603:10b6:510:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 18:44:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 18:44:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] add support for CB_RECALL_ANY and the delegation
 reaper
Thread-Topic: [PATCH v5 0/4] add support for CB_RECALL_ANY and the delegation
 reaper
Thread-Index: AQHY+jb3b6PpTwE2G0+HfmxJhBZEiK5DMdoAgAAj2wCAAAMyAIAAG6qAgAAAUAA=
Date:   Thu, 17 Nov 2022 18:44:44 +0000
Message-ID: <E38D4674-543E-4117-B445-6094CCEA90EB@oracle.com>
References: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
 <8517F18C-9207-4DE4-A217-2A0EA4C4484C@oracle.com>
 <7ee9c36b-b3d8-bb84-36bb-393eaa2369f2@oracle.com>
 <A5796183-BE7E-4B05-A620-4BC76A2608D1@oracle.com>
 <7834d4f4-47a1-f503-902f-fe33f35a10c6@oracle.com>
In-Reply-To: <7834d4f4-47a1-f503-902f-fe33f35a10c6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6281:EE_
x-ms-office365-filtering-correlation-id: bb982ee6-a069-4cc1-5c58-08dac8cbcb57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ltFS9M2PhBBQZLVOvDZkWALwpPpULvh5aAF6d7VBCovBVPrZsuGeYkSARg41WGGBuaI5SP8JRdnRWqtSzocreoCHMi+w1+Tm0/3nZJfWoToQdaph4KyVnnaIFICYxCLY1s7QUmBC7xGwijo9yeSZu80wHeRB09ZpC20WhMah7GAJg+wVg/ihz1LBsp+slKQV0KrS/G2eMQsxtwX+Wr009PpmXA+zikV+fN5l46C8pEPpKZbWgK8/CHpmhDkWpf52K8HPT7N3el169/zyRg0zvZSvXv4qVBoMD5pdSF++3WNU2eP6tXLXN6vl2I6NmyzXvolG8KQjcnAmDgXFWuem0UfXbEHEaYSXDY6xiMTEtEh1UCp0uEeSPBRdl+sGKh4jPB8Gq88c6uDVJF02I7c5psDydi47ti++b5llVN/IjDtvu1KjtDcR0tELCymZcQZVfJI1oO4kwUIqk2yFyhFPW/hsakg17b8Lci9PDtl69bmt3TtFkpk/kJrJxIcw9ycWanlaF8I1oCAl26QFGd18K2dO2Vt49ndbsamAvTiBBh6i8v4bkieWaPmh4KvbXvyo+SrwPbqEdGQCBvqQ8xSqPnFZxRoXCz3EunwY0/asj/8u5A69fl+um2W9dl5DOQH1hRIklCX2WmTDWIuDvsXAmRJNvHc9Bf+q6S7HaqZjmUhgETjXH9LRtHKskktOiTz9yBM0qWHjfzhIVTIYQ6DMIebyq2RoDnB7ilsX49PqXUA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199015)(66446008)(33656002)(91956017)(4326008)(66556008)(66946007)(38100700002)(66476007)(316002)(64756008)(8676002)(2616005)(76116006)(5660300002)(36756003)(6636002)(86362001)(41300700001)(186003)(71200400001)(122000001)(6512007)(26005)(8936002)(83380400001)(38070700005)(6862004)(6506007)(53546011)(478600001)(37006003)(54906003)(2906002)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YTPtveDqIcKG24oaJvKBomWYGBXxFD2oUwxfN/3CY8C7zfARLBAMf38Rnb52?=
 =?us-ascii?Q?g6HKTkaIVwCVXUg91k+CqgNjfCvtJzyl7prvw82Y3VLl11isNaD15dfiIjbW?=
 =?us-ascii?Q?vqG5sU59YwSLdDV43gE0L9vC9mSrXqj8Og4nhIsZf4gC2yTfSNLC8tymBhK1?=
 =?us-ascii?Q?qwFJzgDW+Juhmq+anjV3B6ThMpwrOP6T6DXZFMm4+WUSxymld5oFNsqfIJtf?=
 =?us-ascii?Q?3ILCi/nY84SXS/xdrH3Yk8kXW6a1+KQFHXOQGStIhCYrneRU9xd4x/2hKIFu?=
 =?us-ascii?Q?sWt/yuajxZ81dWt7SjqOz4xHJsr9gdzTPb/pVXKjsUbgjb+e+E4SaADIgUoR?=
 =?us-ascii?Q?RDv7Gg7FkHg7sJakO9DPRhmW1EtPawe4oV1ylUW83vg8BfFkRpEIgMy2uJWV?=
 =?us-ascii?Q?WYQyV/mld1VgecBhGRxeS7KCL96lrJ+VQvlBzMPuITE/jQ7i/3prhe9m5NoE?=
 =?us-ascii?Q?EiGqh17dFYe/3nCKbv431u8ggu1ZGblkqDkwE6Erz5HifHEL/XiNwAMkitNn?=
 =?us-ascii?Q?wdGqKAFtvK8xmPnrIwnFg8zcftBl1aTiXpN4pVyK/GgrAzG0vA6uDbOGDmiu?=
 =?us-ascii?Q?UsgsRm2aTdQz2KrTO1mHS/lrEopIah1Z0OcPFzTAcK5ed7zMv1z5E+4v56/6?=
 =?us-ascii?Q?t4F3qcdmip8qrjNwuD2/iXd4X5OQx6hK+C7NCsBJ2rzRQxuv3K8vXkfS9/UW?=
 =?us-ascii?Q?MVY9Taez9R5Yf4+7SOAbxR/zDKg9KoNrsAOVvplveJUtxXOG/a3wQarVFZxr?=
 =?us-ascii?Q?qcC/4HUrQjj37DEXxTv2DnG6LQZGOEc7WkNEsUIM1NH7SQZGAa+HCqyrE+AQ?=
 =?us-ascii?Q?i3oD+MI4DzRMyoDegOGuc88QpMBqW+BRXZMLtkHfor1Mbteh5KxzTsoUpdSO?=
 =?us-ascii?Q?07hRt7GvSb6JVTB1cJL87CFofaWUVYn3J+1lkGjBqro1/JII/d4lu9W74xES?=
 =?us-ascii?Q?SV6VKfGaTgHyB5sUnlDXWHYsa0DANtSUeMMZczq267OkGkhjoNYRMT28x/fD?=
 =?us-ascii?Q?Rq0M9tFxc+8obYZOaNl1sYSWduEDNY7OeoBl6V5T5denrcy0OD/IFHrtNI1Z?=
 =?us-ascii?Q?DqUeP4zPQpMADXaCZ39rg2eSnKzsG5AiqhQLLu2dwkT2chHrL0r+ilXwRQsJ?=
 =?us-ascii?Q?NfqSv9iRyLcyBeLBCY1rvgigbxhpJMQ8fx0aveZL6LJ9x6vPGbM0Gc0KJ43E?=
 =?us-ascii?Q?+qzHQHEnL7S+In/4AiH56t5n3k++GGz2aJ0sa5zSL8eFNsZKvB3Cj8Yx+kym?=
 =?us-ascii?Q?vJglKwiZrK345X4dhY4rviLX4o2r6vdWqj/yURWvV/rmls+7XAaF0xdzvAeC?=
 =?us-ascii?Q?53vIPRGQqOB5cL5SWNJFATJx9j9Pi1y/A9TXhvh3RPHEJglCuTmoZyDEeeBC?=
 =?us-ascii?Q?IYy9I461830NkDAta3KO/JP0iL/PiTo37to5FZuTc7AfkpN5mp5+o4JSexKr?=
 =?us-ascii?Q?3nOfSfziYUQmgmxlO2f/sJp+vdp8Kr4p3vi07AfHCv5c54k+JMIIuAixyH/7?=
 =?us-ascii?Q?B13ZNTSkPX6cRNAaXFEfv4DgSHS4wZhGH7nZ3/jivEwMttMCd0QKdNgqIWYE?=
 =?us-ascii?Q?xwh7jbPbOxJ51t24LiEGrPA7HuX2X0y5tQPc+bXPWVtJnu7eb88yPHuUINts?=
 =?us-ascii?Q?LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ADB1723026605C4A8372B02BD5E338FE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hLNSAYjvZWyuyxc7819GexNAliTm3t5PXEAlQJIZhsrUZCeR66P/YabrpJY8Bg3lIlHnc5pUOAlsJfwjBGCfiMV2gCMd+X1prTiYNOwY+nGHn/0UVsifgEihzbYG3/NjKpAdKgVbwJtxTpZwBfFuZumJB7Q355Nvp4sZq0Sk71iBq3vUEx1NPglfj8+bXMhoSIL/ieXC4C3xVEHJ2eCIPYX+vuDmCkYqvZIfZCeCmt9Ek4VH5zHY/cI4rTDEVOH61mvwUusXw46LSvQKZzcRfFCW3/EREEl/19xJzQjqeagcxmfNZ6JhM3vcVpNP6xBenT87OEIrP/OtySyilTjnv+fyVPJaXJtVdG1kjcWyNpBMiC+9MmatRXjPnU8WTSyIer6/9yaLiHm920B1QVAPyTWRlktJOOv7LSWPjeV56zVjq8JevIglQU25QNirzBesy4kE0Nl13PHzeb+Ymfz1QJ5m1/0NSQRRJ4Psyfp89JJyFEsAPr1su+Je5xwMMOVbnZNG4VHs36Nby36AxocnnXfeGYLPv1QJt07HM1ku/T0kUZT6FaMVPZQ+E3VzfyjAGpT0iU1cnrxI+zJiNY6pAtcy8a6523EWEKk2BkiQmQNs4IAUF/VQ03eKSLEx3xDMvYkmqFv4rQAr28hOcBznuZgSvXCfD3+0kO1JXfYXD1WcPMYqsLXm2cJeuEIVraGCN/+1B1YzDfhRBhCrFYSJ6+hialEPQnthDC+BK2UBZXPvONzOvU3eec4DUCZPY7BBZD/z3SRrM+VU6nf84vdROx6/7b8maCN00xjrq4cIW+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb982ee6-a069-4cc1-5c58-08dac8cbcb57
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 18:44:44.1450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZVGGJsinqnRT+tqPlFFT+dfZhEqEQEFeyHO/QA5dT/vJfACblqMv6uk4NDQk40Uzrv5TW4A2IuwepL0cYotKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170135
X-Proofpoint-ORIG-GUID: xL8rJ39g-VeIfkjtyPbn4PFIqwa7L6yV
X-Proofpoint-GUID: xL8rJ39g-VeIfkjtyPbn4PFIqwa7L6yV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 17, 2022, at 1:43 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 11/17/22 9:04 AM, Chuck Lever III wrote:
>>=20
>>> On Nov 17, 2022, at 11:53 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>>=20
>>> On 11/17/22 6:44 AM, Chuck Lever III wrote:
>>>>> On Nov 16, 2022, at 10:44 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>=20
>>>>> This patch series adds:
>>>>>=20
>>>>>    . refactor courtesy_client_reaper to a generic low memory
>>>>>      shrinker.
>>>>>=20
>>>>>    . XDR encode and decode function for CB_RECALL_ANY op.
>>>>>=20
>>>>>    . the delegation reaper that sends the advisory CB_RECALL_ANY
>>>>>      to the clients to release unused delegations.
>>>>>      There is only one nfsd4_callback added for each nfs4_cleint.
>>>>>      Access to it must be serialized via the client flag
>>>>>      NFSD4_CLIENT_CB_RECALL_ANY.
>>>>>=20
>>>>>    . Add CB_RECALL_ANY tracepoints.
>>>>>=20
>>>>> v2:
>>>>>    . modify deleg_reaper to check and send CB_RECALL_ANY to client
>>>>>      only once per 5 secs.
>>>>> v3:
>>>>>    . modify nfsd4_cb_recall_any_release to use nn->client_lock to
>>>>>      protect cl_recall_any_busy and call put_client_renew_locked
>>>>>      to decrement cl_rpc_users.
>>>>>=20
>>>>> v4:
>>>>>    . move changes in nfs4state.c from patch (1/2) to patch(2/2).
>>>>>    . use xdr_stream_encode_u32 and xdr_stream_encode_uint32_array
>>>>>      to encode CB_RECALL_ANY arguments.
>>>>>    . add struct nfsd4_cb_recall_any with embedded nfs4_callback
>>>>>      and params for CB_RECALL_ANY op.
>>>>>    . replace cl_recall_any_busy boolean with client flag
>>>>>      NFSD4_CLIENT_CB_RECALL_ANY
>>>>>    . add tracepoints for CB_RECALL_ANY
>>>>>=20
>>>>> v5:
>>>>>    . refactor courtesy_client_reaper to a generic low memory
>>>>>      shrinker
>>>>>    . merge courtesy client shrinker and delegtion shrinker into
>>>>>      one.
>>>>>    . reposition nfsd_cb_recall_any and nfsd_cb_recall_any_done
>>>>>      in nfsd/trace.h
>>>>>    . use __get_sockaddr to display server IP address in
>>>>>      tracepoints.
>>>>>    . modify encode_cb_recallany4args to replace sizeof with
>>>>>      ARRAY_SIZE.
>>>> Hi-
>>>>=20
>>>> I'm going to apply this version of the series with some minor
>>>> changes. I'll reply to the individual patches where we can
>>>> discuss those.
>>> Thank you Chuck!
>> Changes folded in and pushed to nfsd's for-next. For the trace
>> point patch, I've rebased your series on top of the patch that
>> relocates include/trace/events/nfs.h so that the new
>> show_rca_mask() macro can go in the common nfs.h instead of
>> the NFSD-specific fs/nfsd/trace.h.
>>=20
>> Feel free to pull and test to make sure I didn't do anything
>> bone-headed.
>=20
> I removed the get_sockaddr temporarily to test show_rca_mask.
> It works fine:
>=20
> [root@nfsvmf24 ~]# trace-cmd report
> trace-cmd: No such file or directory
>  Error: expected type 4 but read 5
> cpus=3D1
>    kworker/u2:6-2297  [000]  1349.863391: nfsd_cb_recall_any:   client 63=
767ac9:adb1a3fb keep=3D0 bmval0=3DRDATA_DLG
>    kworker/u2:0-8698  [000]  1349.869652: nfsd_cb_recall_any_done: client=
 63767ac9:adb1a3fb status=3D0

Perfect, thank you!


--
Chuck Lever



