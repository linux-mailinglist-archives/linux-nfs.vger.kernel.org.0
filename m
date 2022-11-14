Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C1E628899
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Nov 2022 19:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKNSwc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Nov 2022 13:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNSwb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Nov 2022 13:52:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6F59FDC
        for <linux-nfs@vger.kernel.org>; Mon, 14 Nov 2022 10:52:30 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEHPnpu006597;
        Mon, 14 Nov 2022 18:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ah9mQpKdQVs2hC8hP2pU6keCAN/8P/UVqWLO70sRLIc=;
 b=Qqv2EbS1zkm+EIElk2Z1+ow/uWus5fg/EXzlxjKI94cP/FlQPzMmSUq3ma+mJT0N8ZX3
 StpohSKCzhKpbm89I8VS4aSJa7JrLO3fk2EvuNbSQZSDVo8mf2tdgjiZ4pOgrudsDpZn
 4kdDWSFwoHiKu2Ch5x9eZFnLJXUlJXFSCx7XYv939Rf38yyEgCCbi55fg4JCsSxx4N2t
 pEIz8zRW2peicKUopzN6UMG8IDmtfZCEOYurYDgUmQdczUTDcQB20p3DtByG3GoL4Xnk
 bBd2Z2zWIYMRjJYqgOVUNllobBZeYRijUrqTUaGsYWk4+OyfFXcGZSoWuw0wBKIrIrVU hQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kut2d8aat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 18:52:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AEHt9tl031835;
        Mon, 14 Nov 2022 18:52:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xam43f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 18:52:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuCUe/VLpTipeJQmEF3wyrzgrp8mYzlQZk5Zv9xCJxicagNYETwGObKXLeiRMAeP/iRJv3WPnwVSFVC6+vlpbgd735QUe7yrlVQHf7Zplzf6pP1eF3jpSPadf+eI+StD+bIU0NddC9L5WI/EodL9YdIYuTW0xjgEUhEETQH8SJoxcMLZFdSu6iIaeDMk8D7UXXdVw9r2CDAkWOGu2GPz+40RPxqhHhTCOjqcyw083Ii4qOEqAbeinprRm4hqMe06GbaXmvKJq9PQ0QXid6CxHnOKmMzQAO19YC5WMMsjKx0V4BZBaBbR8OjfLBlhd1gBHPzjk1Bf9ySWBEftPydj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah9mQpKdQVs2hC8hP2pU6keCAN/8P/UVqWLO70sRLIc=;
 b=RnPVVGgIWtzIMu32saNcE5+Q0iVmAKc7xIEMEPNQYDs1tHHknVU1OJxqRaOODH0z3iOJj6Q9Cisbs4VfMj2Rq1kpI/l/5hinYMZqiMDPNp5WCQ6jWro8/TI7uUVmOp9X8HxzBZ1kxUL5TFOoWYwWy6XPMZOoMNGclH/MWvnCfrx2noX/NoNvL00Ezt1RPCBsX4kW4xBivsBJF6p/sJfQqzMsRlmCl09sP1Phyg2Tt32o7SieKJO3blRe+oY0JrLNvnrQktbYo2SMtV6ks6cgMHpAvd/AtGCxW+jUpxZ/qLJxjRgsjqj6SOT3SOGnkMrPrWwdNVkRzECDE2aNtqaB2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah9mQpKdQVs2hC8hP2pU6keCAN/8P/UVqWLO70sRLIc=;
 b=AB81zBo/Q9Ti/zJDvs4WPvbtUzWA48n/KCVeNWjXjHBj10BhczLd7L6AcL4XfRH8L3VN6TwFn8rZHJD3VeSkobZJS8eua+PlYuxVaWu1jJAFwX+GCP4zKTlXFsxaAgpBKqgG7A9029uZbECUMWOPf8RuQKnjirhWB41deRsZBVs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6327.namprd10.prod.outlook.com (2603:10b6:a03:44d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 18:52:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 18:52:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] lockd: fix file selection in nlmsvc_cancel_blocked
Thread-Topic: [PATCH 3/4] lockd: fix file selection in nlmsvc_cancel_blocked
Thread-Index: AQHY9gTwwKmHpOWzOECaqHw1tBDcK646LKuAgAAXKwCABICXgIAAA/yA
Date:   Mon, 14 Nov 2022 18:52:22 +0000
Message-ID: <9BD6A469-DE43-4D10-838E-807CA83C8761@oracle.com>
References: <20221111193639.346992-1-jlayton@kernel.org>
 <20221111193639.346992-4-jlayton@kernel.org>
 <1AE4E7CF-F76B-42E8-90D7-5DA52AFDE66E@oracle.com>
 <55593a438387aca9187a8a8ea1e0d3c2cc4efb9b.camel@kernel.org>
 <1e2722cee7cc03f0da0623a7d45b9531973c0906.camel@kernel.org>
In-Reply-To: <1e2722cee7cc03f0da0623a7d45b9531973c0906.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6327:EE_
x-ms-office365-filtering-correlation-id: 92d522e1-f9d8-488f-74fd-08dac6715d4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vnRSmXNDt91SvyrGUTjDRSinw2CEK8kbwFiCulEHhWmfLfefHCLSrzvfPVY+gMqxhF58uGTjjh9eHLytiiy2Tk2WsPtQcamxmxcbW8Cj++WnmXbUsOkYqe3SiRPQ7Ov91CMfculXaDH3f+A6Rk1C+j4GqItnuuCl8xg9z1/FgJonDqFLhUIkXylKudgBMhbuIaBGh94e0bGfTqF1VBfTQvmHXPX1bA8mkdFLQhosDwR5grv7mL04IUSTHDp67CIdu9CML+wYTaiW+UJEb1jCwQu4fK6ZmspWSoqPw1Oc1k1ktRJOwESGBdc/qFcpjtumIrIw33n24PSuGwWpLemIpbpiTjpDT+8wLRR2zxm34kxRMFbXdlNDW1a9mTENaVczI8jMDhl/DrJrsn/hZOiS/sw8zmIGN8w5lOtkxNb/pSHubOb57LePvBgqzZQRcfu1iCjzpoxzBBdynUep1bGFjxMlnOILkL35tPtyjmXvztvEPZGCfj92I01cEy1lCXepnVz5g/R2iKUtKq5lRLz6qsQ9PEekxdu+OikFETlgCFzlbcBdlRAxCAF0JLGBfm84X9HUugP4kSoezGRWe/bYLfiyNyUKkD+u/+ulXMywfFbKElqhWrBeSuKIMHLwQ4H5Dq/RNgTyQ+U4cw4VUACSSA3UltIchKy0m/Kr1a6JjcONhiQxALiUL33ns8RGV0DvTxR2X6GrzWePFiaHN8vUeaZ1bOBECiCs97KoxJkCoVtutlZRCjpyJENpw8PMVyE2y+WrD9BGgD+bVE74Ao2OeC4Hp5wsGh6z5KLhR3kC9DU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(4001150100001)(2906002)(4326008)(76116006)(6512007)(66946007)(8676002)(64756008)(66476007)(91956017)(26005)(53546011)(66556008)(316002)(66446008)(6506007)(8936002)(2616005)(41300700001)(36756003)(86362001)(5660300002)(38100700002)(122000001)(186003)(38070700005)(33656002)(83380400001)(71200400001)(478600001)(6486002)(54906003)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ipg+VbDIhMZkkjvkkDod2laVH9PCTTND3a7jLGABTfaTIGOKOUUMaErJ4mnb?=
 =?us-ascii?Q?CJA8NrtIQ7oZEfslZrZa/jKyo7rHLsZfaT2ZCOgRHeYumks2m1tZPoUTDoT3?=
 =?us-ascii?Q?xuEKE1zrp3WQWxyyG8rs7bXQnC8jnU5M0ef2m6Sbawyk4FdvFzUQfLc7EZYG?=
 =?us-ascii?Q?dJQmze3PDVjT4qk+yjwJbxpKEsVKMjc4dWkm1CvqGavg2I12RMUvZIh4H9Oc?=
 =?us-ascii?Q?b5Ek9ltBG5dvIwnB1Wc7NDDX5G7Kl6JzaGnTAMnpAa1UO/bI1pjgEBF5xg1T?=
 =?us-ascii?Q?68F7VNzVlNTok95sYsIJC+RCUKrM1cZszAron0DE3d5pKoyvOr2bRkgEsP81?=
 =?us-ascii?Q?n1mcqeDvQkdmhGgyvtS3fM37suxX/tpoZ75tLtfLt3hqBp2UaZVBMVjFhB9X?=
 =?us-ascii?Q?RIbsQbhm5tfTkdBw5a0csN8E4kzVMLnkCroSFbf33ZQenHV/R7NiUUTeuzQW?=
 =?us-ascii?Q?MLTEf5Tip/nkyyWqS+GgQLhHDkteq66kJ48rKgch/5eykRGL4LzrxOxWBRs2?=
 =?us-ascii?Q?hWCTws3b1HEzegfaQWEPS9OymwAXcHcmHA52zbGKLYysH4onHqvzNFZLc0dN?=
 =?us-ascii?Q?1SGKYZTeROPe/2bu0Lva/vvNzTp6RS2SqqZKZ80g6wPn8hSDrRRLe9Li4Jjg?=
 =?us-ascii?Q?OKIAE3urUcVAAHHx0thsaJarQ7hs1kj2Ky/2mNiy0V5KRTVg0fINHD7j5fGd?=
 =?us-ascii?Q?7ujwaLhKa7HruEaekiEkDVVwXljNEuh9H7JU5GOmszgfdjemS2L7zz4k8TKk?=
 =?us-ascii?Q?EzCG/YLyBWmqAOPcLqvrZ2UN22y2odMgcB7NsuWmnKs7DI6ks7eNekDYRFvO?=
 =?us-ascii?Q?7bXZaJ1NYpy3C4RAsoQM4hTeXeYs7+vn7oxKz+FYqiLSr/hzdvzPR/ZWxywG?=
 =?us-ascii?Q?7hkcB5prvCSdwRyf7xxkxZ3qVP4lrBLN52wVO7JwvcywR8tRfAlBLuGIGEZh?=
 =?us-ascii?Q?WSaDPSYnRQtm3PNTyYWYawnE6TypWqi9B3o8Rc9af8AAje2wRjx7USyK7H0r?=
 =?us-ascii?Q?+cdkcwm/CBxZZ6YvpJimQ2qvQnM/YcV22oe4R64O6IV+g982pLJYJIrDqtzO?=
 =?us-ascii?Q?6BDBE3T6HwVgW7vuJShprjVXeAlbpM8XslfCz+/FE3D1Z/ToSENKquErOCeo?=
 =?us-ascii?Q?Duj0U4K43o2UNoStl9xjIakmbaLzZDUJJNwp9FanzoXuJesNsm89GCw6INsW?=
 =?us-ascii?Q?0JZtfgD48mXTb1/deYnAC0wg9EtG2sJ3yPXGQzloJZQ1dj0FQslv0rdyJIli?=
 =?us-ascii?Q?Nr8lguUQ+BL3P+/HwN8Li6DaGA3TfEOzVLJ8YvZ1dMe2431VkUS2cm6y5x8j?=
 =?us-ascii?Q?5dV2AQYVLOAs0ijo0RavUWaVMjXREnCbS5zPvmanA5KIApM6PgCQ/iCxCxzZ?=
 =?us-ascii?Q?6esiWyKyagEbsZfnyqkumYcKikWMZUbOh/nRJzze9mNq5WLamMKgxsxfuCFR?=
 =?us-ascii?Q?uUDlm9g3yCHQO1qclPnRhQTw9hHNE5hoJXkK9IRnffWRrSTq4KifvBZ1rjMu?=
 =?us-ascii?Q?yHBHBe+KENssyi00skOdroF2p3KEYmxy8EKwp+zKZDggMMn31VsF3s5Xkta+?=
 =?us-ascii?Q?m85bnSxvlJcQmmOjJudCSQjkT8x3Aw72e0fUPeUxNGXdmWoeIQJKVWwGITB6?=
 =?us-ascii?Q?/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EEDA60B4BB7C4D4FB331AEECF3A1FAA7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SpxE0qmou56PZ1odBNpkaUab22E0klLLegA41gMQGw8AAsbHjq8ReC6nLhEkt/eUeV6+n4anROiklmRfUxfFxSdVJZ+FxsY3p07x+Z8iUnzvZDSMLb2gZkRynrhamBpH5hRFIEcek1p5KBAiRbxz2eZIsgSn7gtB9rhUoR01XIBGKtK6XK7Wh8TqYQdajRI9rreWOEeNGoqLXioq46vW2udgpAV5brPA7EyV6YyQdHqmsmFuQq7YgbGxJV4dAsOQJtJK4X4N3MWfEEAXKDb5fkVUtRUVnx3JXNgKKrEbRaQGx6Rp4TEeIAhkyHTbBr4NZjVGqcTvvvadLvj3aj/91laHaulu3C6890lUzzq6yWFxzwC0N6rGpA1cMBM+m69MCmSqsFjEKxCNfV/OiIfLYXE6OP24J4AtmpZxB4HPzczNtAp9gHA3NRlPO1GQ/I58bpgGbBj8UKgSyHqCBigbi0d2ZxFavxsKkz7i7rkiOHRVQFa2sfSXjlxHeSF2CWyYPqHOyQIKoQP12IwhLea3lxddziCbqWNEeNmu9Z+xyHou3QzG2B37sQX8ZqhESNocPPgfxK7c2Vo9cBjSHpl5+yMs/QxVXzxIIpbNXYwOIolh4AgXpBzknQNDY5Iu9dMNH9aI2NJH2Z72Ly273E4F0qbt96dsODEerQAiKiLLSkwkzrc/bVm7uXXgB3cj5uustviHeJrI6AmKByZJ5AYX9rLAqocSgHdc5G5zB1yUgCm8ORey+1NGurj6nuIMlssNhf5DhL7+S3cRglHAuoUTGFpkEv7FYjwnmH5LXrLSh/CZaUxbqMBCIZ5S1CNzEZtfQwfVlqouxBgWP2SioeFhLA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d522e1-f9d8-488f-74fd-08dac6715d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 18:52:22.4814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /oBU59XbU2w9MrE78McxaEK5KceSqpzZ2MCFyOg5XxE0u9wGjdOgKPsx96SGNl9rK0mYXLu5Bdf5rTgpzuTqWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140133
X-Proofpoint-GUID: Uk6xkchBFaMxZntqH2RJjBbu1wC-rErR
X-Proofpoint-ORIG-GUID: Uk6xkchBFaMxZntqH2RJjBbu1wC-rErR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 14, 2022, at 1:38 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2022-11-11 at 16:52 -0500, Jeff Layton wrote:
>> On Fri, 2022-11-11 at 20:29 +0000, Chuck Lever III wrote:
>>>=20
>>>> On Nov 11, 2022, at 2:36 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>=20
>>>> We currently do a lock_to_openmode call based on the arguments from th=
e
>>>> NLM_UNLOCK call, but that will always set the fl_type of the lock to
>>>> F_UNLCK, the the O_RDONLY descriptor is always chosen.
>>>=20
>>> Except for the above sentence, these all look sane to me.
>>> I can apply them to nfsd's for-next once they've seen some
>>> review on fsdevel, as you mentioned in the other thread.
>>>=20
>>>=20
>>=20
>> Thanks. That should say "and the O_RDONLY...". Fixed in my tree.
>>=20
>> I'll go ahead and resend with fsdevel included.
>>=20
>=20
> I reposted the series Friday afternoon.
>=20
> What might be best is for you to carry the first 3 patches in the nfsd
> tree, and I'll take the filelock: patch into the locks-next branch,
> along with the other filelock API cleanups.
>=20
> Sound OK?

1/4 through 3/4 have been applied and pushed. Thanks!

--
Chuck Lever



