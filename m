Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D4032D987
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 19:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbhCDSkT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 13:40:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36846 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbhCDSkC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 13:40:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 124IZD4Q020564;
        Thu, 4 Mar 2021 18:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rvZ29iisIaphxk65Pp6LqSmZ8gOVD7PTSXrSNoHo8Y0=;
 b=Lofo8vCPCggo7zzIgkjpenbQWAHM86r2MnNFulWs9W8KIkOT8w/b5bUFjqdPpxgYkdo5
 51w9ejk2S0NTYy6F7l9gqdgKvAAlP740hzDSdHfgD97tVfvH87XIBPuegR7e8hB3XnIi
 Xc2XH1yPmVOBCrdpOTw/BQaSpvCi68t7PURStUmotVL2rNhyng4RfLKRZgzlH/3qgwfG
 3NagURRWB0KrllnkdZTqpy4yVrGRpNSnDkugWd64ypX0of8pcX5h0dgeOyxe2JKPT0RD
 gadjT32ShOeNPa0CQFq6ppHHS71d7u1mCJZfkmL8hnVZodKsfM00SkKVWERY7HzByveL vA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3726v7dkkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Mar 2021 18:39:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 124IZ8Ue119746;
        Thu, 4 Mar 2021 18:39:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3030.oracle.com with ESMTP id 3700116ver-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Mar 2021 18:39:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/SWvLVsp+14wx8CxnZ9bviNXW+aaeD/+F501mdYTdvljJGiWN+6bYkcf6Z2hsK/3wnO6VNCFDtiFdcmkwkjzp8keJT59HDV/N/KUkGs3u4g0XrdrfcJIR5MksaJmxN7mDngY6uSyqWgQJIRuFyCRkrq4qwmk480SK7vygAaCqMiZFIzHZXvgXZPlKuKkcHXC91BQDg9tfVqAmNKl3kvCH6dMGxU1l9jotCyLqeAl1/ejdueXV/4nqic3J1oEPK2vW8TZEKuewIBYHu7Kafp7mSBU3APRH/teMx0ehhTgKxP64l2DE/ZXY4fixaefoKNTrxL9X0MAz9ENSS3wONBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvZ29iisIaphxk65Pp6LqSmZ8gOVD7PTSXrSNoHo8Y0=;
 b=gMaE4izmV5IMsOCKLOzHkoHIi5Qb4FDyeYdmKRo44NPgfZhQvJK3aqV8HLo+GDdm7uXEtTBnocgsLtDjbTXR0mDKbZel6DIm+ZtRsEomuLwgReh6grvd0+GROUTxy90NeEfwiV5U206VVnyS+QAgAK8cPXUn249Ljr8Oa0neSWkLS1iqMFEbKpcJKS8mzgBCMH1thKY8QnoxOAh6095L4d5jHUo+Ex0zVaTOejAIthnoEa+A4MbyV+BSa0MIjbE+nEoK9qSkPKCClIN3tUNVdF3vxu69K80KfWgxKwnwhLvYFKEXBOTMz8TNkf005Pw6Bmijo4iGU6biKC4dyLpmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvZ29iisIaphxk65Pp6LqSmZ8gOVD7PTSXrSNoHo8Y0=;
 b=VIVj5H+La9Y2J3USdd5i4rBf/8SlEvIZdoHhl+x95txtGPIYRXC1QcymDwF3k6UXd5aWtLpHkfpZ4FnhMNyTs7lkU4gb54jLUQRWlu+jPWezwJFQlvo55JsK09RKwv2JBomeyQq+CXPC3+vEwvtSzEgyFMSzX6wJC8+VRzpHrdg=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3031.namprd10.prod.outlook.com (2603:10b6:a03:8a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 4 Mar
 2021 18:39:10 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.023; Thu, 4 Mar 2021
 18:39:10 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Dan Aloni <dan@kernelim.com>, Olga Kornievskaia <aglo@umich.edu>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: [PATCH v1 0/8] sysfs files for multipath transport control
Thread-Topic: [PATCH v1 0/8] sysfs files for multipath transport control
Thread-Index: AQHXA8HF/Q0BfS8EzUGtVa8pd9CwgqpwKIAAgAOrQgCAAHANgA==
Date:   Thu, 4 Mar 2021 18:39:10 +0000
Message-ID: <E076EDFC-A53B-40A5-A62E-422995FAC8A4@oracle.com>
References: <20210215174002.2376333-1-dan@kernelim.com>
 <CAN-5tyGw3D-+emeQhu31agom9yuZ9=PL6YUVyEKiR-n2q9uE3A@mail.gmail.com>
 <20210304115806.rvoeju7gmqyd3v6i@gmail.com>
In-Reply-To: <20210304115806.rvoeju7gmqyd3v6i@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernelim.com; dkim=none (message not signed)
 header.d=none;kernelim.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a2e0cff-b891-453f-9615-08d8df3ccced
x-ms-traffictypediagnostic: BYAPR10MB3031:
x-microsoft-antispam-prvs: <BYAPR10MB3031E13EB7175588A7E5D64F93979@BYAPR10MB3031.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqUJt2s8jTE2kQDsZVOfywhf5isubPLp0bNQOtLMO1UfE/enxKLMT304lfJg9Q7aS/LWtEuYGkzbIgkR+h7Q1USntDtvYVczvo376LfyGaOK1/8a5N6Nb0Oo9wl8Y7B+GPEGmUDaTucL5C4voiD3RXvEzJ19NSq2j+Pnlt0XIefI4ExTZIgqKg5+aPXxzG+BtZm2qTnoV8stRWoy5v0jaMlGH4HLyf+b95oBVTLaw3eSr/ugVqhoiLki8JGPzTp8lBQlKF5kpjhvXtsfrTbtH/KZVt0DlaMfVCL5fWz8BpqWnw+nOB566xWvtOBhPRCialvCXKijHTOC9u3alxUyTh+qtgpuDadyl0ywZ0mGsmWPGSREWKLHsaWx0KOOdrTK5iDw9VjL2kaorsc1TMvN/TQGpmRiH4G1e77Lvv/MsIgDGSlECJ2Tb+od2VuSjAlKB0jdA/rirzZkoAmltE7RUhYdLwXYjCjtx3tluHOgw2v/K6DY3d3ylgxW3joSNMzkyVikvJ4MDDb98xejqZbBUVc0fpvBLSta5l9U4qC0+P+TwvOKY0MjA1GYn7FNy1PxCVTQVE0gq4RjWW5a7sU3LK0OsXDTk5E5xeNhYyrNxtdyDkmUHOGCpNr1WV2f0M+CYt/F3CA8iHVW7G+LTdtj0dh+EcxG7BNaiSixPHimWSQ5N7+NuEgBcAVhA7iYwm2c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(39860400002)(396003)(8676002)(76116006)(33656002)(66946007)(64756008)(66446008)(6512007)(66556008)(6486002)(110136005)(5660300002)(86362001)(54906003)(53546011)(83380400001)(316002)(71200400001)(66476007)(6506007)(4326008)(2906002)(2616005)(966005)(478600001)(91956017)(26005)(36756003)(8936002)(44832011)(186003)(45980500001)(6606295002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FBdvXOufmWYVjwqOSOxvlQLt9iHuMvgasDY7O8ZKIscMdU9QmHpK9s9dZuDB?=
 =?us-ascii?Q?74sJstXXtP5hDcVTyQ1P8HqcJ/AZvTwbcYjDDU0+gKC6juOhiSqLYnqT8MGe?=
 =?us-ascii?Q?4meKkj+hFTjqIAekoSgC3XjzsiwY68YhqOfGwtkkX9f6B8lvjf8LEFZqFSZb?=
 =?us-ascii?Q?qRl8v/X3n7MaG7m5uDuiiEuzaTjVruGGAvj8X4PaHGX0viPDzPxgMlYUpkmZ?=
 =?us-ascii?Q?6kY5stiEtWzOeI3zXIgGJE+/GkkSQVjQi7mWxUacokf/g639ydCUhWvNchXb?=
 =?us-ascii?Q?jlzpqSGBB0lTq+uVswYWeYz32mGiEThbOwOwTKn1vraVJNTDGuZbTFIW9taU?=
 =?us-ascii?Q?k9XuQA7/kglNL01wFDv9Y+6+FIjez5ibRdWT6JnoZ9a1yTjU9WBoer06428B?=
 =?us-ascii?Q?YDsIGl3rhAcWi2n0jss3M0Udk2ct/CBHgLUIAUF6MBmNh4tMM8RBjeUsuW8c?=
 =?us-ascii?Q?4VHvpKOus6OLYSuk17IVwrEPcRA1MigNOCfKtAUiKDbaRqi++STvThh6a3nA?=
 =?us-ascii?Q?gZWlAv7+fk7rdgOUbfXkHwpQ/H6AsnLQuqllLKVeiY7oaBRC89f9JvySlPtO?=
 =?us-ascii?Q?mqUWD1+2FZAYmyT0wOV9Q/zB323B2DjognbR1MO00cNxtaXIJg3BfP3lblH3?=
 =?us-ascii?Q?bXiflVsbE7nZz7VGaG2CDQQ2f5SnFPV9VkORYvGCWzO86IgyQdgg17fypjQG?=
 =?us-ascii?Q?PicesUgGdORePcHKun9BMgBPsvG8o25zhq04zkNLQYkhngagnJKx5AfP8m7z?=
 =?us-ascii?Q?oAzdVGDuxPYyDkPjmZossHhPUeZzFCV4LGhY0u0EoyH4qdILu8vFyQFkxrv6?=
 =?us-ascii?Q?8pu10ztMiudYLIoFypgMpHxtdKE7cnmlu9t5M1WHc+ffP+GOByFY9xm1mZmT?=
 =?us-ascii?Q?WZwvtJBtF+NQapy4+3PJboAkU36uH+6VXcnfhowgyp8X+50TY5kMWgB+l5rL?=
 =?us-ascii?Q?r37N2QvXeWVzcaxIe00K94nwBKczi+veV5lJZh2EYOCNlysEraKcc8KiJRgz?=
 =?us-ascii?Q?HiNuTZPTu9an4smhoj36hcd12lwgVS9hhxbc8JPrghUCRhNN7vAs/Kime7L5?=
 =?us-ascii?Q?PQlRCT+kyG8npM+8sDN5+qf61g8K/nuBhjdmJXK7DO9hWUI/CQe/yqbpkqg6?=
 =?us-ascii?Q?ta8KfYpjjZHRlJeCLjChPP3DIjETA2ReOOSVYgcjFnO9LdeJQEBiD1mHOG7Z?=
 =?us-ascii?Q?se4RxPA8c5vku0ubtwvmzHsE+ZJnfqqJbXZEI4buQsXLwFQmgJvc2n0HmU0Y?=
 =?us-ascii?Q?4fZO4t95p+legmStG6yjELpqKiHZ/GTnwXB3Gx7JsVmaH5726uCXCMomtC3W?=
 =?us-ascii?Q?b5iHvQh+IByXvP8kAgjWoII3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7BC223CBADF3164693ECDFAA038E82F3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2e0cff-b891-453f-9615-08d8df3ccced
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 18:39:10.0486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MaCd4RBgmwMuOyRR8Af/EOztrnsxG8AWdI1YUHVvFo8zf24ki5fINB902Iv4NuVugaLo0o6SoBLUGVR47P4lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3031
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040088
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040088
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 4, 2021, at 6:58 AM, Dan Aloni <dan@kernelim.com> wrote:
>=20
> On Mon, Mar 01, 2021 at 10:56:22PM -0500, Olga Kornievskaia wrote:
>> Hi Dan,
>>=20
>> On Mon, Feb 15, 2021 at 12:43 PM Dan Aloni <dan@kernelim.com> wrote:
>>>=20
>>> Hi Anna,
>>>=20
>>> This patchset builds ontop v2 of your 'sysfs files for changing IP' cha=
ngeset.
>>>=20
>>> - The patchset adds two more sysfs objects, for one for transport and a=
nother
>>>  for multipath.
>>> - Also, `net` renamed to `client`, and `client` now has symlink to its =
principal
>>>  transport. A client also has a symlink to its `multipath` object.
>>> - The transport interface lets you change `dstaddr` of individual trans=
ports,
>>>  when `nconnect` is used (or if it wasn't used and these were added wit=
h the
>>>  new interface).
>>> - The interface to add a transport is using a single string written to =
'add',
>>>  for example:
>>>=20
>>>       echo 'dstaddr 192.168.40.8 kind rdma' \
>>>> /sys/kernel/sunrpc/client/0/multipath/add
>>>=20
>>> These changes are independent of the method used to obtain a sunrpc ID =
for a
>>> mountpoint. For that I've sent a concept patch showing an fspick-based
>>> implementation: https://marc.info/?l=3Dlinux-nfs&m=3D161332454821849&w=
=3D4
>>=20
>> I'm confused: does this allow adding arbitrary connections between a
>> client and some server IP to an existing RPC client? Given the above
>> description, that's how it reads to me, can you clarify please. I
>> thought it was something specifically for v3 (because it has no
>> concept of trunking). As for NFSv4 there is a notion of getting server
>> locations via FS_LOCATION and doing trunking (ie multipathing)? I
>> don't see how this code restricts the addition of transports to v3.
>=20
> Indeed, there's no restriction to NFSv3.
>=20
> There can be potential uses for this for NFSv4 too. FS_LOCATIONS serving
> as recommendation to which hosts the client can connect, while smart
> load-balancing logic in userspace can determine to which subset of these
> servers each client in a cluster should actually connect (a full mesh
> is not always desired).
>=20
> At any case, if this restriction is desired, we can add a new sunrpc
> client flag for that and pass it only in NFSv3 client init.

IMO an NFSv3-only policy should not be built into this API.

This is a user-space / kernel API, not something that is an administrative
interface. The administrative interface, which is the place to apply an
NFSv3-only policy, would use this sysfs API. So would smart load-
balancing logic based on fs_locations.

If the API is under /sys/kernel/sunrpc/client, then including NFS-specific
controls is a layering violation. Consider that the kernel can send
multiple protocols over the same connection (NFSv3 and NFSACL, eg).


--
Chuck Lever



