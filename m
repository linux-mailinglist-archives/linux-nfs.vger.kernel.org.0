Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E61F65F5E6
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 22:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjAEVhD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 16:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjAEVhC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 16:37:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B362631B9
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 13:37:01 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305LSxhx007109;
        Thu, 5 Jan 2023 21:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9zDkF8yoSjXhKTq9n2x4rqK9GgFdT6yDUCOdLKI+dQw=;
 b=0be795umK6SPhlIdRIAzeQx/vmAZqYGSnmUlbhAqfsGdByM33tb7W4OcbDiilALW/rMk
 Sq1WOm3C0GYFOZ8NxlCj1cCjOQ6P0dING6PAs1dusEUHhFpckSTvNaPaa30tJ8Iy8NKh
 P5G2su53aP0uEWNMpGvYASzaTxa53fMY/E635NyLPD05z3CumK5j4IBKxbWgtdGyGMqT
 NXiZbsa+JO3XVikNw05Nh6PV7gQuyog/+yIYRnPqsk5/wF+lQ6aWbwER0W/GxoT4jlQ3
 0qFInYmRwp2rZxojKvA3Mx6GXh6veTvVN3uCqG9WRkFztTkqeqdC7Bxv14dFW88aQ6zj Kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbv31ymg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 21:36:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305JuUKX040159;
        Thu, 5 Jan 2023 21:36:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwevk33cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 21:36:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvLAZsdpcChAQYqbXB8mHAPgCaJny7YcmRWvZ4t9KJV5pW8i9R1v2J7Q/n0qIrMFa1KAX/AG0afaggZ70J4UpEiedsLsoPs5RgPyyq4aD7zLImukE7fXSMrbR/vWoE3IYWAl6RT4DOD5afjXcLZS3yKDKA2tEJfLGeQtrFKEd/zvpg32k3aaFhHeXfD5sWQUiI/6M0ZAzEC9i2tczB+mWywXCxcjl8nvTrBsWrHqIlwMNQFxFmJ2ccQq4+5K5AMnoTKNHWkoxhz7lqTq2C1un7XRh4QDstJ/qQ8q112innsM9m9kouoVXl6yez0I3DsNhWPJtTXwTZ7O2x+wEHQ1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zDkF8yoSjXhKTq9n2x4rqK9GgFdT6yDUCOdLKI+dQw=;
 b=oaGMwF95jVLg6D7wkbmSg4pmrypCEOGTLrlbzTSIzkTK/XEmXJ/uic/tvnRYrOQOtTIiZma5ErwQ6ci1Wo9/NEZAYhahyaBUUfqEPLOtWGx71sfBiSBXXJrj86ARNDfHCTmxrvl7yZImsjX9h5KJiH2zSWOaK58NgEpSQ7fTFT5dVp6XqVr6/qmuWZXuhMvbzao/ynepRp3SZLqj6EQpoC69bScg+KDKoQe9W3z5DG3kQIprKNOpK7OlMJHOnZcOh2PKiZ9fWm2U00YNgFnAd8g6v0bQsrXY5jkPbN28NDrlQq/pMfolUjpvf6oy08164Jd8IrW0a9X34royxSIK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zDkF8yoSjXhKTq9n2x4rqK9GgFdT6yDUCOdLKI+dQw=;
 b=cysdxHvgraoyD/nzw40wcVayFW6N4dvlxP3rE1Wta3KJQgqLSF9ipKwxzz0ki65hwlT/0A11EQXG/Smxap+feKOe+4Pdb9ojLtEuKW6Z6bv0FI6yoy14KML7EMeP3BS2k57uF4KRI13Oy/v7p6Try5oZG3VQb1iXWAQ55kGaKOw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7128.namprd10.prod.outlook.com (2603:10b6:8:dd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Thu, 5 Jan 2023 21:36:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 21:36:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix potential race in nfs4_find_file
Thread-Topic: [PATCH] nfsd: fix potential race in nfs4_find_file
Thread-Index: AQHZIP/Rwx38OblB2USniwBo+ML6lq6P5v+AgABj3wCAAA7JgA==
Date:   Thu, 5 Jan 2023 21:36:54 +0000
Message-ID: <EFE95BAD-4C57-4287-992C-B53143FE4DCF@oracle.com>
References: <20230105121823.21935-1-jlayton@kernel.org>
 <4255172A-EFB5-48B4-B2EF-700C10862427@oracle.com>
 <6ef7caa1b21f7fc2edf2722e504c1b18ff3a6023.camel@kernel.org>
In-Reply-To: <6ef7caa1b21f7fc2edf2722e504c1b18ff3a6023.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7128:EE_
x-ms-office365-filtering-correlation-id: ea8aa63a-7ba7-4694-b507-08daef64f721
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HCI1OzyrBMithWxXfWsUvsgacKPT+P5UMs8tCgk3AKsqxE2U7sr6WGF9ShNv0FN+wXcvCKO6Sk8yUgVVKFwmESx7wUsRq137vdISir2B6eBtP86kyn3LL96dUENyrzGDt0qkqw44eyYVkUOVkIjYhI/dehesjRAKcIpofx30kK5NCAz/engLX839XA8eq24yDm9abal9BWpx+6pzKym0h4u44tVCd9i6l/+G8uf8tNRjX6Huz6MLqcFYzCje8qwEBlOmA2+w1JNyQNyzt1LrwFpD6ibq2aQEBSpfbIQEwu/5uREyOVfNDnGoc++6ub1rkGIe6fkQOT4yhsjVlBTMgCc+BuyWmRYj2XhJYIbauUNqDvgowj8q9Lx7G18sYXHM09/RKnKb/xoN5FekGxKJG+MQNlV7ZcVz9ml8phwD/3IocGXgXYvrUZ8iWzgYaaHtuziIZXCsMrvCo/9b1D0SZ32cbl/K5m1xI/kgeAioen0zq/FToJAO0oLwaEfoTLu74WbdI/k2eiANJZglqdJssCYIdnzSBomXXkdUD4kRMgTstkHBCLiAZE94p4TXcKWULMJEHx3nzwNOvyTYIHQ3Sq/v+/Tjd/zvr79yPXRvzZ1IdH2M5RzqofcXyEtTFTXZ0gLhEdj5x339gXJajV8/6cZhhaNY+m1IOuy8CCWI9Y2pXdyrotfYQP5qJoU+QAzQatzzNKO7s2EFMB+Ee3q4cdzR/tGxBU8quLVqJyxpDsyK4C2xfo1sRJjP5wSirs5D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(2616005)(26005)(6512007)(186003)(83380400001)(33656002)(6506007)(38070700005)(86362001)(36756003)(122000001)(53546011)(38100700002)(4326008)(8676002)(66899015)(5660300002)(2906002)(8936002)(41300700001)(966005)(71200400001)(316002)(66556008)(76116006)(6486002)(478600001)(66946007)(66476007)(6916009)(91956017)(64756008)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I4/JBIaYxftRf+JWoRvO1RKH6CB8gxhrWKj6zYQuY2wtZv/3GlvpCfhlbT32?=
 =?us-ascii?Q?0O0pMvc9mZzLMXN3OoBZrVrVx7zg5xwxLS6R4zeBtmPjZj7Vyl35myeXa18U?=
 =?us-ascii?Q?r6Leracp/uQpMu4EHkEgbSypijY6dojS6JTAxF7Q96r2WA03AKeCe+v8BGfC?=
 =?us-ascii?Q?aC0XaVKJP4iVSdYblXtNqR6EaN44x6luais8vXyNSKLPfJmVUkzkn8DsvSZV?=
 =?us-ascii?Q?N+lTZNvW82W5DYtVZPmUMuqygAEmY0iEQfrMV6y3qIeSmoEfsw9Kvc7fY00b?=
 =?us-ascii?Q?Gc+YIDP0hcR85dnmwfctvfFz5P24if3U2ARR6tfkqBIzOEaKARxy8pIupIwT?=
 =?us-ascii?Q?/zvPMK9mPqzBJZVAQJZheSU4xoZYiD7F6o/RGwqmOSZ/XZwCkU2UN2MpfqGA?=
 =?us-ascii?Q?MTBB9i3fazC3W5KO9VNUYXiz4ojIBTsvFNErjIHWOGshLffzLvMyjtoLbh0M?=
 =?us-ascii?Q?9ufvWgv9H0b7tWW+7CUPdGy1GnHQS5eR7yN11diTGK9EkcHnUVtQOM1scrIi?=
 =?us-ascii?Q?l7Wz8wBzfRdUQc2Wu0yOTRo8WIVEljCA9phzNBpG3q1exs54nRk6aHAG8wQ2?=
 =?us-ascii?Q?nLnD54pvtbTLCwDIcpQGzBojJwarHCQ88FA6HCNRT/+3WlQ/UJY3IEXLuqAc?=
 =?us-ascii?Q?d7Y2hVliefXTle3klAsb+Ds9HobItQwzZc1Sge2x+qzr8dPhL9tUGE72c5Dt?=
 =?us-ascii?Q?IwXxhwjDLQiUgPb5bIwIeLH4plP/wwP24xqwIE+3o1s8Y3M0oupPN6ecW+Un?=
 =?us-ascii?Q?ZCrwwRljdwQSMi3IdJIZ/hwVMfL3XDcti2B02aiNF/3Zoi6Du/5che/ogB6c?=
 =?us-ascii?Q?l7K5ofcJ09F0Sj2+PgPANqm2jtfUsyw028aFnpRUoTkj/fW0gojffDWxilh8?=
 =?us-ascii?Q?y/piWj/42+3V1PHejHVUKV/z/KQbO8GY8BfzGxQSLL4TkX86BkEFE80PVizb?=
 =?us-ascii?Q?by1+Qz+3CSeTbQAyUqkSPCWgT0//1n8JemCeNpZPnUpGKWcg9oRZhw9TQHOk?=
 =?us-ascii?Q?AWVsbwgclzFv4sEez644eIlivUAJE40/RhxD89ZkEXN+55zj8OtuVUBTTwML?=
 =?us-ascii?Q?XspDSqsP7IsxtWivisQyY0prGsIjXcv9RIvqiczR7vjaqE9nDU1YmAH7tV8m?=
 =?us-ascii?Q?dP0+5oXv1JZBA6DvXeOd2ud3GWsCXJQ054KTk0eA4n4U39WiZI7ielelgz4k?=
 =?us-ascii?Q?dNaAsKwbDgvM6i5jSAvX/ejCbCKU4tbHNLXeuPUg1ouS7qk01Kcvx61XNKl+?=
 =?us-ascii?Q?KgSJ9o5JxOdoowX8dbaMWHOLYVqEbdDPEh7GdSPckmcxH+U3jLIXvusEtGsG?=
 =?us-ascii?Q?wnNsBVB3gXr51M8I+hCcmSF2kPepPLtdi2TcaGNWvlD0Zvea5B00j58x9zTM?=
 =?us-ascii?Q?WdRMc46gDn1D0jc89XfGktroHrTM1Ey1RL8O4eS8KsPbL4H9otW8eUU3kHkX?=
 =?us-ascii?Q?ADCYEBmZOJNjB+meTektHzp3D5o4Eh1h/VrKpKBqjREH/A8bjRB1lDA0iyMA?=
 =?us-ascii?Q?HVN5gJ93bmcBq8BNJvYzFsv/LPVc1Nt386EteBEOMxZISKyQ7wR1K4UF2Rwf?=
 =?us-ascii?Q?CFXi3uphy6uMsbQwYBXGOjrHQZsjliVsMEotDuwWkxcHasPd070WsTNe0DXw?=
 =?us-ascii?Q?jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F25C70101210104B9FB28A3E60C8514C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iWhx3/jsym9P4SmY8Mv4mOBMT4u0lqAnhNZeQZNt4U5vzyL2bbWOTgq2gm0OnXBwvtqJIk94wD7T3u9TaSI8mUllqb/PBd7xEDGunYKx++sQW8u+tRxAGLU0Kpzp4ZzFzgT81XiccJJzsFYa83Yn1Ix/rmZnOxXZJGMhJiI/Qzcdf50/UBg/lsk7TZtdZwO9WwOh8NJKJ7p9nVsPpIYzsRUdruE0BX+jMR3qsyiOW57B20gtQrBStrTTHwe2AXBVFCvZxXAiX+mVc1qiCiNnkHTydzE96a210+pFFK/51Um3XdwCsvpea6lbWKIHDEbRmcdKJrOWi6ZCO6+pD26XFonk9GiD06ejJtJw7mDluO5By0Ftgp7MmtLvA9rsWi3SSFtUeZtZDiBhZxmicd60PMcjIod0T55Rfz6nwtwVGPsbsqheMW+IfWrKOOC59lIGFGXl8iVWiK/RrTJQrYqvj20+V9tAo4/sqZhBf+L3Hrg3A11gRVA2FZSmh7/P4jFtgwgMSE9K0pE5hZ1flRHEA5sfhl30UAU7tBILh1Rvo+F1AtJg1Z8eIa7eGoEWS+y0b8w79xFd9aMuyNI4Hu3CR+d6wfen5qKnKbAkJkPBmmZaa+hO9cRWFLQezZFm0OH8k9xPoasJuWJe0EYpNkBPzBkk05Y/w8Q3K0Vvh5wRFc5p4t2cuaBLdRDIWFFreeFfCOCg1SayYlL/ajOPoXjWMm3D7Tzpges//yELjvkca5cMtAG/DMzNJvi+eBD2o0bx7Y14pWq1AiOtmEgQKpTnMWjxrie3jxLWIWrXUd0WREI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8aa63a-7ba7-4694-b507-08daef64f721
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 21:36:54.8139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PK6R2oZfN2P1Rpmle+jDdHciiDk6LnrgCqb6UHz1jOCGdfatgFDypKf8H8/q8GgPYL4qfKl4poYlcNWEV6pCsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_12,2023-01-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=967 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050170
X-Proofpoint-GUID: nk29VPsUJ7A8jn4r_SsOLEWijImU_5hD
X-Proofpoint-ORIG-GUID: nk29VPsUJ7A8jn4r_SsOLEWijImU_5hD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 5, 2023, at 3:43 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Thu, 2023-01-05 at 14:46 +0000, Chuck Lever III wrote:
>>=20
>>> On Jan 5, 2023, at 7:18 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> Even though there is a WARN_ON_ONCE check, it seems possible for
>>> nfs4_find_file to race with the destruction of an fi_deleg_file while
>>> trying to take a reference to it.
>>>=20
>>> put_deleg_file is done while holding the fi_lock. Take and hold it
>>> when dealing with the fi_deleg_file in nfs4_find_file.
>>>=20
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/nfs4state.c | 16 ++++++++++------
>>> 1 file changed, 10 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index b68238024e49..3df3ae84bd07 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -6417,23 +6417,27 @@ nfsd4_lookup_stateid(struct nfsd4_compound_stat=
e *cstate,
>>> static struct nfsd_file *
>>> nfs4_find_file(struct nfs4_stid *s, int flags)
>>> {
>>> +	struct nfsd_file *ret =3D NULL;
>>> +
>>> 	if (!s)
>>> 		return NULL;
>>>=20
>>> 	switch (s->sc_type) {
>>> 	case NFS4_DELEG_STID:
>>> -		if (WARN_ON_ONCE(!s->sc_file->fi_deleg_file))
>>> -			return NULL;
>>> -		return nfsd_file_get(s->sc_file->fi_deleg_file);
>>> +		spin_lock(&s->sc_file->fi_lock);
>>> +		if (!WARN_ON_ONCE(!s->sc_file->fi_deleg_file))
>>=20
>> You'd think this would be a really really hard race to hit.
>>=20
>> What I'm wondering, though, is whether the WARN_ON_ONCE should
>> be dropped by this patch. I've never seen it fire.
>>=20
>>=20
>=20
> I have:
>=20
>    https://bugzilla.redhat.com/show_bug.cgi?id=3D1997177

> It's possible though that those WARNs are fallout from other bugs in the
> delegation handling, but it's hard to know for sure.

Before 2015 there were a bunch of BUG_ON's in this code that
were converted to WARN after Linus complained. Before that,
I think these were all debugging sentinels. (in which case
I would argue they might be better recast as tracepoints,
but that's for another day).


> I think we ought to keep it there for now.

The question is whether the WARN_ON is adding value for customers.
Can they do something about it? If they give us this information,
can we do something about it?

I can't tell from the warning whether the problem is due to a
server bug or valid client behavior. Both the server and the
client workload appear to survive.

So, I just don't feel like it's adding value, and firing a WARN
while holding a spinlock makes me squidgy.


>>> +			ret =3D nfsd_file_get(s->sc_file->fi_deleg_file);
>>> +		spin_unlock(&s->sc_file->fi_lock);
>>> +		break;
>>> 	case NFS4_OPEN_STID:
>>> 	case NFS4_LOCK_STID:
>>> 		if (flags & RD_STATE)
>>> -			return find_readable_file(s->sc_file);
>>> +			ret =3D find_readable_file(s->sc_file);
>>> 		else
>>> -			return find_writeable_file(s->sc_file);
>>> +			ret =3D find_writeable_file(s->sc_file);
>>> 	}
>>>=20
>>> -	return NULL;
>>> +	return ret;
>>> }
>>>=20
>>> static __be32
>>> --=20
>>> 2.39.0
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



