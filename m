Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BDE4351D6
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 19:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhJTRsz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 13:48:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44432 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231232AbhJTRs2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Oct 2021 13:48:28 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KHZ050029734;
        Wed, 20 Oct 2021 17:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Zc3FG1b3GQL72RxDkrwl7HJE5NqZDH0z4/oN97aeuaM=;
 b=LPXANr3M3PMs80vB8Bi5nNM/hltnA0euoTxpyQWvxCc1CCAlzRaIxYaFE8OzqurGeSY8
 iE3Y6FYYZf7POe0ktLUHGJASka8FtXSLTjvEkTaQccN2CasSa2yLac2j3VXLkomLm6sr
 zX2O1BDwDDn5Cgmon/vbdeMm1uo0SWNYx/BOv9JmrH7dQA3+J3E1ohV7gmI6iDgemRae
 jfHDfnTfIRcUuFnCDpzsO7yy8T/H3JeTmAZscvvZxcse0ESaXxEMBOghVQmGjGoBzYWp
 Ns4muh6jyeGxehce8RXtRhFa57S882w+GT84EcHlyJFHSPnL19kEUR8i6ahvJgJeHT1v zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkwj1jv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 17:46:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19KHjZwJ170497;
        Wed, 20 Oct 2021 17:46:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3030.oracle.com with ESMTP id 3bqkv0en57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 17:46:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jehDFisjRkd4yntITU254GAxz26qhYm9adAAovtuYS65ksHgvuoydLDQTLfUOBXDas03JgBCm2mQor552JSLfXjL3ZWlkSqKaAMTSksom9UO65ux6iNMxHvn1om87fiIbM19Oh3w6K0TZVZezy5buGC1hp56DFYSbFLxsva+MlV9AsFp8rvlk1P+1dWneOy9UFlciCB+oze1L7T8c25z3pwOGKLQNL6mJdAWzdn4IV/C6J65BZmg5ClqRCYg3+X8RIM2AwhtOv0AVieVxz75MXiOEGz1q3X+ZPu/driPR4YtZ8FzHCuzHfzxSa4zaMe+mPry1l+64R2ut4Ye0YuU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zc3FG1b3GQL72RxDkrwl7HJE5NqZDH0z4/oN97aeuaM=;
 b=FKEHnuRPdvuuF1+GmHbKcsrrX2fX1WITh5jiFxa/2Qf6NXZz1WASM6DlJ0W98BrbZi5BThxrt75qn7utmNAdKUYkL4LhpideNttmRWmKQYTvaB4/NIc4JyzXXc4ry3KZIVXuTzc8tuln6jEAPuh4gOggmJoRjz0t8IzvKCNm+mdYYS0WPeIOytFUXN7qmc+NAAiMXwnCR9RP+vzw+Ct7Q314xa//sPCbcgd9eLo38TQkN6JHC1fA6u5U+I6HBWnhonxWFXJ5ys5za6kx5YJXThos1N9vw7ArzZ/Omb1wycASurLRbZiA2ObxqaJZ/tYByg6weiJq1gQfFqzG0XamAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zc3FG1b3GQL72RxDkrwl7HJE5NqZDH0z4/oN97aeuaM=;
 b=SOgwgpg8MM/fBVDmIb6KV+Pgy9ktBfFpKqm6nVmROhXkX4S1cMzcSnWvcKy9Hz7LwMqVmHMjdhN2qdQKYMXnS1VwdDDZtDjGVqpBp8s8aggCAaYhODHuXzBA1Sl2I7SAVVqb2yujatWcvWf0voP4X4jkUhJMRxjg4JskzTBhCBI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3860.namprd10.prod.outlook.com (2603:10b6:a03:1fe::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 17:45:58 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4608.019; Wed, 20 Oct 2021
 17:45:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>, Steve Dickson <steved@redhat.com>
Subject: Re: server-to-server copy by default
Thread-Topic: server-to-server copy by default
Thread-Index: AQHXxcrDI0R5Oq8J10KODCEElXm6xqvcFdwAgAATOoA=
Date:   Wed, 20 Oct 2021 17:45:58 +0000
Message-ID: <0492823C-5F90-494E-8770-D0EC14130846@oracle.com>
References: <20211020155421.GC597@fieldses.org>
 <CAN-5tyHuq3wmU1EThrfqv7Mq+F5o0BXXdkAnGXch_sYakv=eqA@mail.gmail.com>
In-Reply-To: <CAN-5tyHuq3wmU1EThrfqv7Mq+F5o0BXXdkAnGXch_sYakv=eqA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7390e24-6842-4e81-4dda-08d993f1795c
x-ms-traffictypediagnostic: BY5PR10MB3860:
x-microsoft-antispam-prvs: <BY5PR10MB38600DEBD268300A358D8CE593BE9@BY5PR10MB3860.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ASuv2twfoGIBEGbDWTMyq2zZf/89KQsiv8jrZqfyKFUWYNnsvdwM37xX3I40WsVt41TQ5Ej21tFdC0hlm1z48XWoVYbtbAPolGObqb2cpWaflOOYSYaxlIHt2E2VkSDtoXL+jOiT8a0NqaQJZ/nzds6wFdXgby1G/Fk3UKUg3yMJxvQIteu5DdbyECMy63a3oR1oRuwsCQrl9dlPK14QJcYDCVCZz2e3gw8wPzCutbtnbC4C7g+bYRdJuX8PlifrbpxYru6koO0c02qEclzsyyS5KAk1dOZMJAMiG/xHvqkBKHDm6fMV1QyoRDc/plIt4V3gqBa6w3yas8SAbC91f/EkNDcmq/lmdVcfAbQgMp4vhD2DzteS0J87GAjrMxjJALM/CeTjQF8MfjyGmd6qJmFR3BBwoE73wOQaBicuIjntdPki6zineY7IuyJh8IjEXCPRnvcgN5sgu6fqyV94OXI6ELnHPQwS+OEgyL7F3Fx6m10Wu21wNoQOtWgjY1so8EJqgUlAqOs78uu37kKQ/9YLcPBKUNnkrdAQbzQoKi8OsjzLZkLhBqq1aUlwYc9wEZlVJwp3Zl6QtTY1PaBAyoQazYZxLUnkIV/3+FV7MT46bD27LkAiVdueScGnn5aSnwu1tEyXH54Pmf5AW7r0gueH1zDgqexXOmy0f6lyEp0nNo+cro2MW5wv8cHpWc+sBqFFQ299aUTMiROSEE1sfaRL1978B391unldVcedIATPaSy7pqyYOpGFRjkjgP4J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(186003)(26005)(2616005)(66446008)(122000001)(71200400001)(66476007)(53546011)(316002)(38070700005)(38100700002)(36756003)(2906002)(6506007)(4326008)(6512007)(33656002)(86362001)(8936002)(66946007)(76116006)(91956017)(508600001)(83380400001)(8676002)(6916009)(5660300002)(64756008)(66556008)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?elFaDXmBCvVqelKH6S5VW1y4UqAlsCUuWoNTatA7cuJz5N7fIR5xbN6NFDOG?=
 =?us-ascii?Q?Jnlaer//MNdsU1qsGGGQpDuDwB0mEHS6xRYYILC7KxAYI/ccO14Kx4dY0fvn?=
 =?us-ascii?Q?Ar+YYwYK4OzkFupRfTs0SmOx0y7p+GRgxC98LCXw3v5I2DVOj0/OLHt8jP9a?=
 =?us-ascii?Q?04JeeEeQlZZPju7Be0Dd1nRSgn5JDVGCklQ2gz1tXncYdtgclf99yEZxrU6W?=
 =?us-ascii?Q?1kCew0pNkZA7Z5UmU7cfsduub85O84WHjlsTh0WYke+/pG1Ks6KUCWm0i8pk?=
 =?us-ascii?Q?rfrTSeXNh17UkrRFXRoALKZAuICFSE+KK4fiN+DC3C0THRjuaaZCFXTxEb1Z?=
 =?us-ascii?Q?r04Hyv7d60SDo8QfzZxmE6NPjDnWHtN9XpS6VnWh0MunoCqFAqyGbqkjiwyN?=
 =?us-ascii?Q?186568RwcYiXPVINRBv+6H5zuOaeFrrEhS5v4M+/hPiR+KYMiyFA/V841kay?=
 =?us-ascii?Q?xYzUiZEJk81gQMUERGqZoDLlCS5wvKkYwJQEPjL995BC6YQgWteCE7uaLW6p?=
 =?us-ascii?Q?huxBLLuxCctPZXWt9hq8kvOnzvPlOazDP9BYPxZ8j9ZX0/96aR3P4BV+OoJ5?=
 =?us-ascii?Q?TKWAhvfdxKI31yOxqvB4pM2HSvNcfJvhwDpZ/uM8TMH36BExihZx7GNkEzUw?=
 =?us-ascii?Q?y/uVv/W41IxcK7aKCJ6IgKUhDtgtbPF55OSczj0eJZGcnaf4Nvi+8Z2uF+HQ?=
 =?us-ascii?Q?/RfM6oNuoEH4OZIbfwTRQFlhkP/loA40kAlJXPN4LiB9vWyKA0LyRImHChLm?=
 =?us-ascii?Q?H651L44Mo/g3yHogSsQq2luBfJTwEU+3UynD0S+HI6Yut573WctZB9AOJaFK?=
 =?us-ascii?Q?hOv9nGAo91YphHcP5K8lKIKFMG2kh4bl2lQTKY0N+IqYYOcjGGJ+NbiO1HK0?=
 =?us-ascii?Q?QN2oH4AtkOdomCukHEnkBjC4U99SfZfeXn29b5FthrnYVj2HB/IN0wdH8aAA?=
 =?us-ascii?Q?iysZ3Mc7sP9U5awe+BWmssdv+BiRICfhY+oR8fOQ2KmBb7iJjIgpqa8BNBq+?=
 =?us-ascii?Q?Rap7pfbjE2OTTfah3Mn6g6RE2rmt5yQLLwtiPLRCqhz/7GkXqHWpQnIHheI3?=
 =?us-ascii?Q?hpMQNkfBpk6vcjbYHXSqjP38tDjZRs8+GGbliv37+2zO0SG5HTUlAsUWigRZ?=
 =?us-ascii?Q?SPbsP+FIqrOEfUohWF2fKWVRSX72/a7d0g749cPBCJuTKVjLoVE09g0FzqJs?=
 =?us-ascii?Q?mDQag3F3MG+VoMzrgFKdAK8D/c3K/nBt9hsL/Gr+KwtV7/UAEE7Yfj6Hv6V3?=
 =?us-ascii?Q?shh3pLkecl5wbjI7Cqvbh2C5DNZkaWOqemxwkI+kgFnXhY7UUmPbpDqxDxna?=
 =?us-ascii?Q?rPnJ4rAmE3LLzt4Qc3Yj8wd0ybKyRNH4BhCa71hfk3td27OITZtyg0GOSVdn?=
 =?us-ascii?Q?32JhzoGTu6ZI8hyvi21bMke08wn7xMaG4WShzKcqgT3S8cTQgSpVDuc7rjoC?=
 =?us-ascii?Q?LowUGod04QWIMs1/fyLRaCkE1YZVtoXhEPMeKtK7sBtZoGpKK4dKUCVGtX4f?=
 =?us-ascii?Q?v5ZykQcjoWJxL5Hqu71glFyIdOu3QFFwWS/3A6CfMap9jvpe4HhsubjH7X0b?=
 =?us-ascii?Q?m+IX6bMbBE0WMAzdlTHtZkUVngg3vViGbogehs/6Dy6bwvQuoGamIkSzBVxl?=
 =?us-ascii?Q?kqttnAh3K6CGbhuaQBF/KwY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C71F46403E376C49A9A4C3C4AF64A9FD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7390e24-6842-4e81-4dda-08d993f1795c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 17:45:58.1591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWtB9cfQ3IK0rhoGVHvDnts2npFRTHUlHrtmPLHXC4yDak4+08mTirPG5pS5PE0akuBLYrN+NOfir33YF2Zptw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3860
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200100
X-Proofpoint-ORIG-GUID: sgHsLxrSJh1prKccv_uJhn2rkWAPdPQ3
X-Proofpoint-GUID: sgHsLxrSJh1prKccv_uJhn2rkWAPdPQ3
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 20, 2021, at 12:37 PM, Olga Kornievskaia <olga.kornievskaia@gmail.=
com> wrote:
>=20
> On Wed, Oct 20, 2021 at 11:54 AM J. Bruce Fields <bfields@fieldses.org> w=
rote:
>>=20
>> knfsd has supported server-to-server copy for a couple years (since
>> 5.5).  You have set a module parameter to enable it.  I'm getting asked
>> when we could turn that parameter on by default.
>>=20
>> I've got a couple vague criteria: one just general maturity, the other a
>> security question:
>>=20
>> 1. General maturity: the only reports I recall seeing are from testers.
>> Is anyone using this?  Does it work for them?  Do they find a benefit?
>> Maybe we could turn it on by default in one distro (Fedora?) and promote
>> it a little and see what that turns up?
>>=20
>> 2. Security question: with server-to-server copy enabled, you can send
>> the server a COPY call with any random address, and the server will
>> mount that address, open a file, and read from it.  Is that safe?
>=20
> How about adding a piece then on the server (a policy) that would only
> control that? The concept behind the server-to-server was that servers
> might have a private/fast network between them that they would want to
> utilize. A more restrictive policy could be to only allow predefined
> network space to do the COPY? I know that more work. But sound like
> perhaps it might be something that provides more control to the
> server.
>=20
> But as Chuck pointed out perhaps the kerberos piece would make this
> concern irrelevant.

I like the idea of having a server-side policy setting that
controls whether s2sc is permitted, and maybe establishes a
range of IP addresses allowed to be destination servers.


--
Chuck Lever



