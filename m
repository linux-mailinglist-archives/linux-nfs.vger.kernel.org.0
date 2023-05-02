Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B516F489B
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 18:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjEBQuU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjEBQuT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 12:50:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520161BC7
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 09:50:18 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342GNmJS022069;
        Tue, 2 May 2023 16:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CJVNKfb0yCXpl9nWl9f/NWc0Mo9NJjmB8T8GXH4s1hk=;
 b=Z8LGPvf834UVk3ptATUwunh/BnCKym0wT8W214wcXYkT1vG6OTagUO+EmMDXL1MD3jBP
 Deaj45DP+RucH3TkKIdKYWqSgKB0SA3Ye72mzL7io+TOZ5gSkJe66qqpGdi5bX3hQYmf
 iH8aaN6svEiDb1hxRtb+XIhs8/3ZhqBXn8fgmAKLhJqqgTXMSkZM+yBkkLH/M9TdxoC3
 TF+rTOeQCIwW3wYYdkzF7fLBD5wU8xW1mKExDhyTGuUdimGQG/snFhR/C+SwJ09mkWk9
 7L/jWH7w0Ws6iKTsav4wWpo8d/xJhc+OX4gqH5RI397ONV46jKEya++USyuh+wHK9gLX EA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8tuu594g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 16:50:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 342GkDfc024996;
        Tue, 2 May 2023 16:50:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp6884q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 16:50:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv9vmJMX7Lhhcax9mtlKSGFncRqHIoz7aXr8gERlEetAQ+pd1vWrz6fK7znaplBKbSuuCPZc0MeSE44qHmZH8Z3YRot8W3R1n/HynfVoeId3Y4Ibi2eCUjzhBImuGMiE1PtgleG4VyoMFmhLVI6vr7SvPcxv8JT65awaQd2SYSNRYTwZw9C8j3uyMux8TnH8DekyW5MBXASYo9ToBnGdKeWqAYki+faXox6SM9Lk1iu/dmimmXImzce6vmJQZNPYUzHkzopg8/AWJBNKtFYqXAECGHIU4D5AJUBD0mSttUJfEHpQKg+CEyWGyN6Pexoio/bVQbTzE53iahiKHSCVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJVNKfb0yCXpl9nWl9f/NWc0Mo9NJjmB8T8GXH4s1hk=;
 b=lbvcF9//6Y5OGDb7lnHti+gJdnfOsT+uKZHS3MYM8VET7R9cK5ChKy5Smtn5YVfrnte+Qkf+xcYxVedL8TPwnCgwUyhCnD5qKVD2XYWw2HnEyT1a5Qi0t3BRxTimoVhMu7l8ZYGEckeyu7OpyfWTD/JgpjCB3nlQ0lgrcqWERSE1x6+QLj08LpBgPaRZ5zlwLH3fTlBABQNsJGPO8I7L18mReVALaFCx1nh9r/FLv04MnNqVn+gyqFmn5hpyqBPKmKdVf2RNMqVE9m8UD0d4gfUK2NEmJ+T2pd2BlIhfnrnnsb5yXTsaU6HbszJ98EB6day/fAW8DSHk6LAiY9t4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJVNKfb0yCXpl9nWl9f/NWc0Mo9NJjmB8T8GXH4s1hk=;
 b=PNAdTa+R3GpAGwwhpYYpBATR8btpPGp1a8jg+rooXpE0SnTOKBn7oMEUmi06L1dTWoylEpFwao3wGzSJYYO/CMlmfBKyAuSMLylne1miLmSPE679JjiHoOf/P6SvrP9+1aN5KHMIJPOGsawfu48+/iK1FeBggqrBh5Oi4yYn+Mc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7066.namprd10.prod.outlook.com (2603:10b6:8:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 16:50:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 16:50:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Sherry Yang <sherry.yang@oracle.com>
Subject: Re: [PATCH] nfsd: use vfs setgid helper
Thread-Topic: [PATCH] nfsd: use vfs setgid helper
Thread-Index: AQHZfPsU0hWi9leffEW/mcTC+uI3U69G/7aAgAAykoA=
Date:   Tue, 2 May 2023 16:50:05 +0000
Message-ID: <51805A56-F815-405F-8CDF-4CD04A17436C@oracle.com>
References: <20230502-agenda-regeln-04d2573bd0fd@brauner>
 <77C7061E-2316-4C73-89E5-7C8CA0AEB6FD@oracle.com>
In-Reply-To: <77C7061E-2316-4C73-89E5-7C8CA0AEB6FD@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7066:EE_
x-ms-office365-filtering-correlation-id: 57e561e1-e9bd-4680-b19e-08db4b2d47fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xN80veOoDlXBMD+GMORggICOXE8lzsfY1RskzPAbuEUx2i0Q6QOn5knb2CAQwiph0UJqtqrSnpK9lnl8ZUSZ1sO14fIGD7aOdMaWGUP0xqZPGh12fmH9v1ecGmvXxkVLT1wgYnGQI1MqgYUbFmnh3hhjyxmOhB0hYnDYvbamswusPIaevSm2hyPc2EK43wrW9F+ilRSMv+bi7+oDdcoPLfFWplPRjoX81Pm+BB1pOhmiQYh8ZKtyXOf/T6MdqUmYMgwRdPGuT1VR3RhKFvaMiuponP94fK8ZXMy8OdprPSw8N32TuE6Y7cG74hOgoIK9CfkPCIt2Ts6wPpDOlqApQrnXCX/ZhQKX2wtLthpGBSkEIoGIFIDeiK/NcX1465440HriaEoFXeS51rGdm5LbBencY8iObm4bxrlFFDC1WRY0pSlGcwmfTo2pkOSHKEL0Kfg0mcJ8lyYAjNZMfEymqfcp45fb8l6kRt8vPVJViVjer1hXMlvfQ6XbJo6FrB3DjSw/xMKJugWtqKm3zDTomKgsRLuZsi96YemfKBrMlDvOduH3P9huTSYP4c7pw+Wd54NNwdwWzxVKfHXaKhdceREvS6btHYgMnQUyrfjyu7KF/KSH7Ix+C9eWXXKll83H4EC7FMEEq1QPRHVOAXi2Ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(6506007)(54906003)(2616005)(83380400001)(478600001)(6512007)(6486002)(71200400001)(107886003)(26005)(66946007)(66556008)(76116006)(66446008)(4326008)(316002)(6916009)(64756008)(66476007)(91956017)(186003)(53546011)(41300700001)(8676002)(8936002)(122000001)(5660300002)(2906002)(38070700005)(38100700002)(33656002)(86362001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sSzb1zRKQze01fDopDUjANpP5uqeoE0BRtjHkS9VrofWhL03mVlC8TQWDmfX?=
 =?us-ascii?Q?3EPPaIvez1YBRKIKIz/TE1UsW9eeIzOVkfcMT4L2iciCAA7Ikf9Ecpf0asvR?=
 =?us-ascii?Q?GeYJXxl0x+8z2coRF9AkObHS0zLptfOlMLGEp7nwDtrjWuj7oufgBbIGbEDc?=
 =?us-ascii?Q?XpZg6hUbfvccgMsb/KTOIyOZylParUodtEq7F5Vfu6oDRc1kZQ/o3JCF7VZy?=
 =?us-ascii?Q?NdNgxB/lkiFZx8fqg9Adr561mCXf8Jabe73VZxbZk3y4VpotrS5ZPHh9FcCX?=
 =?us-ascii?Q?bTnsIy4DKYAdLFvdSgwtqqSdNKfFXKficDFD+z9be87N+vvqcJMDrG8xGzoz?=
 =?us-ascii?Q?8XZhjaqMbmJ/QXMxWUInykAJsIiscJ/VIqfIOoF17/IdHbBhrcRxIUSovrtM?=
 =?us-ascii?Q?tp0zre1gUn1wvHD19AWKPtK748vRp7EmniiWRZRW5FMZ8jVozbGuJKxL8kIE?=
 =?us-ascii?Q?5o1uqN4lbp9nSbotOMhJ0ZxIZZGQOUapTIhLvK3m02y8EUB9UYjjfP/J7sN1?=
 =?us-ascii?Q?YztVXkouZwYc7rmYd6+0IMzdM7LRktpFQHKwGeusf772GCH38k9rmsP3Kce8?=
 =?us-ascii?Q?IyyjM7BgQfeXGxIylm7W/o2LlXyHFFGqE8+mwBXqMXoR6nwbQZd5QoUuSzKT?=
 =?us-ascii?Q?8vcT+OaEHPLkuGkHqsgelG+4rC6JV9e/8UljxSuf0VeaEp9yVRMgQ352VlnQ?=
 =?us-ascii?Q?vpjAfRIvXniMY0epZwW7BZs/EIXwT4MGAPDinS9GkSK2vfLymQm1ruisQae/?=
 =?us-ascii?Q?vyKZ82OxWuf/1YVKpHcCI0s2qigKH7vpwLKNftnEi0b4wmOvB6UB0JMMVETG?=
 =?us-ascii?Q?9TBmxFEAkEfksPxsqFbEP9kRZZcCUdbuhLA35YOtxJ7bXotJ2VAINqOPa5kf?=
 =?us-ascii?Q?oNrlDS+S8T7AY+PhRAjAP/J5SnGV0a9LIQ+DZKGihqVHYwA3wobRdrjmfDjw?=
 =?us-ascii?Q?XNtYEyEJkqlBvgcFlI0T9YgXgTRviU1lDfzMDzfwePcNIQ3H2tiiIuzCl+yT?=
 =?us-ascii?Q?/AAY8DIHhFjttLTs5P890tVufbxmkpagNEYyQ6D93qGS5lERgeQnz7Wn7odX?=
 =?us-ascii?Q?WpIrYyIVdTPoZn2/6/Opko/F2/RfKI4Ugdp59X318YO+pks4RodlYkjKD3Zb?=
 =?us-ascii?Q?ruJG9+FXuh7EokW2W1/E9GgFXDHTtX3eE/nV1gIkFcmSbF6pgQ03RJJJWCl7?=
 =?us-ascii?Q?NB/VPhXIM7wxskf5srnf/gnIXvh6DidrbNfznYQlgaNRJJpf00MRklcQBWQo?=
 =?us-ascii?Q?zpDnRvMJv6Ltv7jQzg+w7trz/hSEb0ZyjTfb8L46cs9cGju4ZyTFPBYTEFr5?=
 =?us-ascii?Q?7JQye0WAeJjO2txF04IPetqG426iboEZmWLzD0uEFbf6IJLd7vJaA3/gg4OI?=
 =?us-ascii?Q?R3G/FfCet4pHKRpwK9nVuwTmTo+YdzWJT9qv/Cc6FIv63HsX5f0I/C+/V83X?=
 =?us-ascii?Q?Byk2/nof5mNXhZQVZQhxkBpUrfxkgZFLASLA9Uw249hhS4HdwaME3a0llMVN?=
 =?us-ascii?Q?GI7RZp15xpyd+IKRnNzb1W0c+SVZeu9+BvV55fkBqiwloQH2RI944butNJRP?=
 =?us-ascii?Q?i1mrWIF9Skyxz/5tO7ooSb6qctGrfqgQIXG+C06GLnfHHkRppVR3F4MHIEfW?=
 =?us-ascii?Q?Yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B98E374CB67A934B89821B7AF3EA0290@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ocxb3wKuxmkpy2dTUyxQW1PEHWUbhBccTwXmf7rbCr6C0D7kbXj+PgQI38/Jl6+Nu0H3vZoMHSse0NzPddZOL/XOWX6ff2KdJ3aC3newAEzqfnbwMvhnqechRNrBiWcbeGwVz69d/f7bNEZOaMj8asnDGYo5gb2ER8YoRfDtjAn3syTU956+ThDrSBjx9CGURs26pT7Ry28ut5XaG5uFyunFq/NSccq9LCDABdoluKdA49rMkbjam0L33o9Ec07gFXE6q7XValyiJrufLV7JVWllyd1Axssph/Zq/woryoMmErzk1FXK2ECaNrSfRuo9/i64Ez95qPHVwfgc3inyP3C+eShmD3pi3Spu5qD1zrPodN1CKY2ggOaQAIkHZoxi4GqLbDuZteiOosAruEw3OD+WlH4jU9f2DhwmTO+nQWPbmLOaJEYyvGHcD/6lzr1TAE1xOZGRYYECopT50zRxZTzOVcmjn+yDW6OWDtQgmdk/0WfQp6AANJrjSfCVgT9ObNAvF7bEhE/mMi8STX8atZMBliOc4JqlTbVnEGYcQZFNzNgHGfnQiAPeA+ozqPXOPgB3wVt2Lx47EKerO8FuhrXCAyc1BH+2ratlR2w91KIWuhRaNvR5c9+VzX4ROenN/PbPZtocyR3FjFEViNq6vm1fnx1mHj9XDIFnGpWnRa5B/HA/u1HTVWoQe7CH8HdWP1T1oz8V8GmcWtmpOgocBATOQH2q3yPLQkNnDIpzvI3xBnfqWa8xFeIpkx9S4AqA9vAkF2haBldLm+aayV+XSjUQs5ENZorGGcVks7MTZW8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e561e1-e9bd-4680-b19e-08db4b2d47fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 16:50:05.5915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcvZEMMVh29zDnt5H0oPQYhCWYDPI1bq9vj7Jlsju7789YqNQPmAeUWg4wF5iENZXifmO8rZvvM/P+p3jYMIpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_10,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020144
X-Proofpoint-GUID: 0C2GmVmS5BkLQcJjtROWFtnloivGoa1C
X-Proofpoint-ORIG-GUID: 0C2GmVmS5BkLQcJjtROWFtnloivGoa1C
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 2, 2023, at 9:49 AM, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>=20
>>=20
>> On May 2, 2023, at 9:36 AM, Christian Brauner <brauner@kernel.org> wrote=
:
>>=20
>> We've aligned setgid behavior over multiple kernel releases. The details
>> can be found in commit cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping") and
>> commit 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux").
>> Consistent setgid stripping behavior is now encapsulated in the
>> setattr_should_drop_sgid() helper which is used by all filesystems that
>> strip setgid bits outside of vfs proper. Usually ATTR_KILL_SGID is
>> raised in e.g., chown_common() and is subject to the
>> setattr_should_drop_sgid() check to determine whether the setgid bit can
>> be retained. Since nfsd is raising ATTR_KILL_SGID unconditionally it
>> will cause notify_change() to strip it even if the caller had the
>> necessary privileges to retain it. Ensure that nfsd only raises
>> ATR_KILL_SGID if the caller lacks the necessary privileges to retain the
>> setgid bit.
>>=20
>> Without this patch the setgid stripping tests in LTP will fail:
>>=20
>>> As you can see, the problem is S_ISGID (0002000) was dropped on a
>>> non-group-executable file while chown was invoked by super-user, while
>>=20
>> [...]
>>=20
>>> fchown02.c:66: TFAIL: testfile2: wrong mode permissions 0100700, expect=
ed 0102700
>>=20
>> [...]
>>=20
>>> chown02.c:57: TFAIL: testfile2: wrong mode permissions 0100700, expecte=
d 0102700
>>=20
>> With this patch all tests pass.
>>=20
>> Reported-by: Sherry Yang <sherry.yang@oracle.com>
>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>=20
> There are some similar fstests failures this fix might address.
>=20
> I've applied this patch to the nfsd-fixes tree for broader
> testing.

ERROR: modpost: "setattr_should_drop_sgid" [fs/nfsd/nfsd.ko] undefined!

Did I apply this patch to the wrong kernel?


> Thanks, Christian and Sherry!
>=20
>=20
>> ---
>> ubuntu@imp1-vm:~/ltp-install$ sudo ./runltp -d /mnt -s chown02
>> INFO: ltp-pan reported all tests PASS
>> LTP Version: 20230127-112-gf41e8a2fa
>>=20
>> ubuntu@imp1-vm:~/ltp-install$ sudo ./runltp -d /mnt -s fchown02
>> INFO: ltp-pan reported all tests PASS
>> LTP Version: 20230127-112-gf41e8a2fa
>>=20
>> ubuntu@imp1-vm:~/src/git/xfstests$ sudo ./check -g perms
>> FSTYP         -- nfs
>> PLATFORM      -- Linux/x86_64 imp1-vm 6.3.0-nfs-setgid-3a3cfe624076 #20 =
SMP PREEMPT_DYNAMIC Tue May  2 12:35:51 UTC 2023
>> MKFS_OPTIONS  -- 127.0.0.1:/nfsscratch
>> MOUNT_OPTIONS -- -o vers=3D3,noacl 127.0.0.1:/nfsscratch /mnt/scratch
>> Passed all 41 tests
>> ---
>> fs/nfsd/vfs.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index bb9d47172162..c4ef24c5ffd0 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -388,7 +388,9 @@ nfsd_sanitize_attrs(struct inode *inode, struct iatt=
r *iap)
>> iap->ia_mode &=3D ~S_ISGID;
>> } else {
>> /* set ATTR_KILL_* bits and let VFS handle it */
>> - iap->ia_valid |=3D (ATTR_KILL_SUID | ATTR_KILL_SGID);
>> + iap->ia_valid |=3D ATTR_KILL_SUID;
>> + iap->ia_valid |=3D
>> + setattr_should_drop_sgid(&nop_mnt_idmap, inode);
>> }
>> }
>> }
>> --=20
>> 2.34.1
>>=20
>=20
> --
> Chuck Lever


--
Chuck Lever


