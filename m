Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91782491036
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jan 2022 19:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiAQSXG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jan 2022 13:23:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30934 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238284AbiAQSXF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jan 2022 13:23:05 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20HHms4f007910;
        Mon, 17 Jan 2022 18:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MJzlNDxHKWkH3jSZtgYVZDvwd1htsjQMs/q6iBccHug=;
 b=m+vieQ87eprJeO3MWYrUC5LqSDs1F1KX3YXpyEbXaVIhDC+t8tpYn2n7gB46OPUWdxxW
 1JiTrFPkOzrtj2qZl9raP3Kfw05Zy5vnY8Be6yXLL/4S9iltPHGhZKm2q0A1IF7nvIGi
 f1/B6fEx5afUwjLW/pEvBDJrpFJFcopSjV0jc1HqnF7VcbLRM24X/7IJz9MhryeVY9Ub
 SSVLl4l37fBVlyqDgtWP4/EV8VwxlpVYRlJCGEx8laFVR1VPru55bf7Miu3QENlq+dkn
 n2520YJMztPlSbZJvbrDOa7Mx2qim/iqvWLTvok5x2idYzt4vUwxlWA8LOO8Fxyt+tq0 Mg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnbrnr7ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 18:22:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20HIAVDt077032;
        Mon, 17 Jan 2022 18:22:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3030.oracle.com with ESMTP id 3dkkcvy37p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 18:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnNqCu/qxKXGP37EiPIAkYmDac+FcZxBqALU7CQF2BvWAwU9Y3OtnH5OXLBl7SX+bs9f2U8K7nnptjjf7/bV+caEi3tdvuiqf8WENW2xPY9JLHSNuF/ryP9B4412myR+/0d11uFxHYHWLcTrWNuexQFdAiAT4Lq2OzKvUxRD98ljotaENPEUFqTEkNdoJbDe3SC0bnnuHWB3zSwrKIh0JJxqU8q5yULDe6ws/Nop8ZB6E7sdYaan1+TDrCl5YmCZvUhdVmm7T+lFWfIgopxKJJc7Q3ppiN2Qrjy0mjWntZ+kViErIh5CWrk978tEcR7QdYdHCb2agLiUp+IplJDM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJzlNDxHKWkH3jSZtgYVZDvwd1htsjQMs/q6iBccHug=;
 b=S1lzF5sTyI+48xxYN56gC6ioHOKmFRjKz3IZk4k57uTsxLJBeg86ORz1u1vlqlpKuYL0dp9yJu/aj/pAl5ZLeRZ0djIWsZPYqBGYH+cv5I3R3H0K9r2k0Qjmsdr/wKLJLaI776UfgijO4j1PCtMMa3Bu2mqJtognaDt6MxxaS5jfsSVCvsZxbFMUO3V9AuF3gHuC2po7vAF0dleSdEOQvqRW3PgcXnOMqJpmi/zGw4V0iMC3jbDnYyoRO5mBop1fF710eP0hY/0ucRDc8f3wo5gxIOeNnR9KESvYGiHjeAPDaUsPMeaiE/nlxQlvX2MN+efQSHos/fZtcCtDIKkwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJzlNDxHKWkH3jSZtgYVZDvwd1htsjQMs/q6iBccHug=;
 b=YutImUnt2e9Jc4tdnhZ9Gk2l/OWocFyfjsC09RvJAMUPfO78eA/Di9UU8Lnq2Klzxvfx0b/SjlcFu8ePpEKuAmMQ8Mqi1o3zBfEyPZbHyvFaJusRYcT69/6giiFzP0hqw/gZtEOyYaiWKSBfQbfZKcRyIXxi7FJYxkn6SpdtLwA=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BLAPR10MB4946.namprd10.prod.outlook.com (2603:10b6:208:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 18:22:15 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 18:22:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Jonathan Woithe <jwoithe@just42.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Bug report] Recurring oops, 5.15.x, possibly during or soon
 after client mount
Thread-Topic: [Bug report] Recurring oops, 5.15.x, possibly during or soon
 after client mount
Thread-Index: AQHYCTZE+ENVwkeetkGrNbALtTtuGqxioWgAgAEb9gCAAMFGgIAC4sqAgAAqcgA=
Date:   Mon, 17 Jan 2022 18:22:15 +0000
Message-ID: <969927E5-96A4-4700-8AF0-2B383261A6FA@oracle.com>
References: <20220114103901.GA22009@marvin.atrad.com.au>
 <C7A57602-4DDD-4952-BA38-03F819DBD296@oracle.com>
 <20220115081420.GB8808@marvin.atrad.com.au>
 <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
 <20220117155019.GD28708@fieldses.org>
In-Reply-To: <20220117155019.GD28708@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d1cabc0-3f61-4ab1-5b32-08d9d9e649cd
x-ms-traffictypediagnostic: BLAPR10MB4946:EE_
x-microsoft-antispam-prvs: <BLAPR10MB4946F45B3252C9E7F55E715893579@BLAPR10MB4946.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZFO+qX7a2AN+3A6YwfNAbi23Vu9xFSUTkWKRM0j4IW1kB+FpJjstMmP/NuU5Taop9cxb2AyqmF72tF0Acdw91yV2EJsXkTV67ijyykiEP/7WOeLjipW5EO9d0HjjbYeV0x7ZrbUsgPuhy7gECz8BIayHnH8fRI9gxXL+afOJz7i/RkZG8ZgZArSPPWKq5GuEHx2samki68E5FKlyjx3u/4Wpfbz8Z1XVwpAj8c6kjFw/G8/2lVKneTQwRXPgMt0iarubIBDUuNLR+FabqX8+59B4rTBmwhEFIrmsiTO2paw6uXW69UHfkxYrNHhZ1TXMD/MBCn2pPyPQsdm8GkowaemJBZTxuC12MlvJ9EN3mPtDYNbvnHbchdIg2A/BOGx59z6ZPqyuxD3PhTideUzDQEuMifNY9I3Pgr9Zhj6pSDNkdI9sFCd7CHVFIoB4+1x2tmQdnRQHPBLb1xQh2Kv5NQfxKgnNzLjGXeZYKmEzhADBOmL2p4cHOr2wot7/eVLtIhJ3bvkAc2kpfL2KVETSzpeBYMofkggIiOAwEOfmbfE0HrDZLgtWMmxjuS33L5zDpR310K5hzxsFuxSx2MQO+n9RhvbMYrQ3IJ8DqYwIymziZNQFSwsQb9UHkmmFStpHo/WlKk/jZIDe7t6cVB9XOO7o4mNRqxHwz6KP/h23/jMcI8+KyXnokD+rfQTIOE7Coodf7ulMETRPzjdl/Xculojme+oaE1ut6jXV9ieHzzMf3Ike22ltr38Gxiv0NO7v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(6506007)(508600001)(8676002)(26005)(186003)(8936002)(36756003)(86362001)(53546011)(6486002)(2906002)(5660300002)(66476007)(33656002)(6916009)(64756008)(83380400001)(66446008)(76116006)(66556008)(66946007)(38100700002)(38070700005)(2616005)(54906003)(316002)(71200400001)(122000001)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OOT6BpK1iBViJLNwGR9eK9r9yNCesuOaRcn/b+C4NLecxJoMZIySvFl5qh7O?=
 =?us-ascii?Q?uzfTQBiEuaN6o0Mj609V3mHUVHXGXHzsUpppHmxGYqYlXyH4BDL+xnn+4Jxb?=
 =?us-ascii?Q?45cMgrdDGemcdUB1ZbijLYJNi32ApMTvcxF1jQbvxp0sFJSPy4iHXp+r0mZv?=
 =?us-ascii?Q?X0gXxuAUPVF6M7qmOzccbWEMvi3AsS2tiGMD1oPuN2Byvcveq65Njdt3bBv5?=
 =?us-ascii?Q?84dG4YGjex6+j75NlL+Q4YmXifPmf/FZahj4ZzWcGBZVPMq8kFAdgwmRPEaw?=
 =?us-ascii?Q?obIbch5bZVgPPA0SmKMCgbl5WW8+XqwYpgzDI9fl/wkqrysAUaRu0tFj9lME?=
 =?us-ascii?Q?bd5HUHbD4PlW0xfV4//TjDPzx7/9FVxE6vZ7n/mhnAqljCrXti20xsEjp+d0?=
 =?us-ascii?Q?iix3Qc51flVjoX3xRh20MVEp/rV9nVUnfMvjW0WIQXRfVx4bRsp43rGczyH3?=
 =?us-ascii?Q?CnVftvAa1DSk7okQiRAKT6i6JcFFyCR2yYUgc6JsLmD+nVbH4MPQ8/ll3d+S?=
 =?us-ascii?Q?mlhm+akymZVIpFhgdeZANSGZ8ZDNkmocWOPTHn+t6rDPw3LWksHMBdKfJmcU?=
 =?us-ascii?Q?6RbX9mSxb3gMw/lEAM0RGAs9n9YcjUPXLQmJd8Ar1o6djlE3E+CVDeiG1DCs?=
 =?us-ascii?Q?JSFBi/1qvNCboTQSgTBRI6x4I0qvONcM3fhNas27eNQnCw+sklJWrvOMFSkO?=
 =?us-ascii?Q?WUOzrueIVHDHU0Nms4rEbinylBDu4/K20Iu7zg1LptD24BtAGDEbYjzNtdgj?=
 =?us-ascii?Q?kRtwIXLB92vjphP4BB4bHtUIvBb0VUhfigPoxxs/y7kB/ABuWNwhfbeDAuWg?=
 =?us-ascii?Q?8VQnOF0SeW3sAXS+LN4HkuLwTbYvdnjI/ASGZuaitLDfh1COb3NJsJ2ynuKD?=
 =?us-ascii?Q?QYjSbLGMQ1KtjosMnv5v9+2paeaxIkxB90/aN5JcvIAHSlv5SjBCsjxpByhL?=
 =?us-ascii?Q?So3LxCS9NBRgEC6H56QxiQm0+vitEshmFViAMLFFmO5wMjaVgJBZePKiwtPE?=
 =?us-ascii?Q?v1dR7a5lu/7k1SRNIvPyIQYuDA+42gj+7Qkkps54lYBDq9sN12fec3alCJIs?=
 =?us-ascii?Q?C9ixUsAeuF57gs3lXLgKs3rLNV9Ppe5KyEBOuCFyd+RsMb1A3/HhP9tVW/h1?=
 =?us-ascii?Q?htjCVoyQSQDzmfxLifkL/LJOBaIqIEwV7SJp30m0Yid99a0JjfxrBax4zbxC?=
 =?us-ascii?Q?/SRjgmGUDO8SDo6OJydmJI7g1MJH6XkMplNcD8GZqG6X/2yUiZ05zW2Guy6M?=
 =?us-ascii?Q?X5ROV8QI+euI92j01kSOjyKWnzE7a/P1hLvThDYUFC5APNITa1fRjPTot9ZT?=
 =?us-ascii?Q?sVULrKeer3WhkZYdFfjcmz4hbCGWmJuMTJf6cjMEl4jMST/18r9aDHToqqlE?=
 =?us-ascii?Q?ZxjAiLEVKewNU+n56Qx+tdkQS2Kx4Wgx0eb3aunE/8L5QaN0qKg58w23fTYI?=
 =?us-ascii?Q?Bk1YvJNu7TQqXw8r9IUG9+/68nLRElRrzN/Nu1rUgBmTsRvbR5e1sXjfRHH4?=
 =?us-ascii?Q?4U1lAJhqAYVKvfM3BLJS3hS4JXC8retxHFgd1GAAqXghTAs1u001Wp8T8AY7?=
 =?us-ascii?Q?0EHiDEt4mzFWJjgwA+qCzT1L2swbUMCv8+6i0COCMgVgNSbvfLRomaG3pkX0?=
 =?us-ascii?Q?O/Zt7sFqWHZp9zaxO4jBGXM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF6AEE8EDB9DC04195FA6077E8128AFD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1cabc0-3f61-4ab1-5b32-08d9d9e649cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 18:22:15.2274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gxNdRzACS09jV4c7w4O9DmujydOeUb+ExMCvhhmlg0MOdG6RyI9/IfvVaWzeFC7b6HH2mfNzpdCADp67VQndtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4946
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201170114
X-Proofpoint-GUID: PJxgtZmf9miGF_jX-jFXLDkQhuPjuLdC
X-Proofpoint-ORIG-GUID: PJxgtZmf9miGF_jX-jFXLDkQhuPjuLdC
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 17, 2022, at 10:50 AM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Sat, Jan 15, 2022 at 07:46:06PM +0000, Chuck Lever III wrote:
>>=20
>>> On Jan 15, 2022, at 3:14 AM, Jonathan Woithe <jwoithe@just42.net> wrote=
:
>>>=20
>>> Hi Chuck
>>>=20
>>> Thanks for your response.
>>>=20
>>> On Fri, Jan 14, 2022 at 03:18:01PM +0000, Chuck Lever III wrote:
>>>>> Recently we migrated an NFS server from a 32-bit environment running=
=20
>>>>> kernel 4.14.128 to a 64-bit 5.15.x kernel.  The NFS configuration rem=
ained
>>>>> unchanged between the two systems.
>>>>>=20
>>>>> On two separate occasions since the upgrade (5 Jan under 5.15.10, 14 =
Jan
>>>>> under 5.15.12) the kernel has oopsed at around the time that an NFS c=
lient
>>>>> machine is turned on for the day.  On both occasions the call trace w=
as
>>>>> essentially identical.  The full oops sequence is at the end of this =
email.=20
>>>>> The oops was not observed when running the 4.14.128 kernel.
>>>>>=20
>>>>> Is there anything more I can provide to help track down the cause of =
the
>>>>> oops?
>>>>=20
>>>> A possible culprit is 7f024fcd5c97 ("Keep read and write fds with each
>>>> nlm_file"), which was introduced in or around v5.15.  You could try a
>>>> simple test and back the server down to v5.14.y to see if the problem
>>>> persists.
>>>=20
>>> I could do this, but only perhaps on Monday when I'm next on site.  It =
may
>>> take a while to get an answer though, since it seems we hit the fault o=
nly
>>> around once every 2 weeks.  Since it's a production server we are of co=
urse
>>> limited in the things I can do.
>>>=20
>>> I *may* be able to set up another system as an NFS server and hit that =
with
>>> repeated mount requests.  That could help reduce the time we have to wa=
it
>>> for an answer.
>>=20
>> Given the callback information you provided, I believe that the problem
>> is due to a client reboot, not a mount request. The callback shows the
>> crash occurs while your server is processing an SM_NOTIFY request from
>> one of your clients.
>>=20
>>=20
>>> Is it worth considering a revert of 7f024fcd5c97?  I guess it depends o=
n how
>>> many later patches depended on it.
>>=20
>> You can try reverting 7f024fcd5c97, but as I recall there are some
>> subsequent changes that depend on that one.
>=20
> NLM locking on reexports would stop working.  Which is a new (and
> imperfect) feature, so less important than avoiding this NULL
> dereference, if push came to shove.  But, let's see if we can just fix
> it.....

Agreed. I was suggested reverting only as an experiment.

--
Chuck Lever



