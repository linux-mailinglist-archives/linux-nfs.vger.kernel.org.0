Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254683FC9CE
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 16:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbhHaOeH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 10:34:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44984 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232774AbhHaOeG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Aug 2021 10:34:06 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VDEVH2013124;
        Tue, 31 Aug 2021 14:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=S2IFnayQ2aAhuPLZw21T7A2QjRX0j708aALAORE4Hs0=;
 b=Pz3GQkeorKEFLgJWPg7GPcIT9k+qz8x8fFP4wwAWtemWjnuPz4BE89ueWdSdS619+mKw
 nZKsEuM2j73ie9hn2PaFCj4cjVWw4z1YZ0tbsY4Eekrd3yVhkT+0R7Oeppd5FQidyLAA
 kbNY793cb7kCBoDjzkdBaZMxNx9JNtl28yTV7z+H/7npzVILKzZ6+KZLLXjvYgr4oFd2
 jtER9JitD15Eh4RhzhyjFFDU8mbVVMYeEHmTXPdPvUeR1XmzFB5HKwufs5dk4v76yBvU
 JBVvPRT+QjjVwvmzMHVJRaCY4c1KzMiVFgz6TpSDRakzQ5AhQi2lsYUi4VLlpDvRG1/q oA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=S2IFnayQ2aAhuPLZw21T7A2QjRX0j708aALAORE4Hs0=;
 b=yERwK7utblqYkmbWd6ahZqfPy7Oum+lvczPKXGdwis/ATkxBdGqW9TKLkZz2c9KPAvTl
 mskYfo9FtUlsoNNyWNzIoJpMYbPXNjHsd4SDpxGhhezrjGBFq76mVGJnLN26JzzH9CRI
 WfDB7PrY8idhGhE+pAvi0PL34T2BZKHbANPscWPzl3BCtRgsQtVW7h2q+7MYMx7INBA+
 Wo5t9ppmBd/ID4q/8EBk3IhXzJqDYumbjR9vKvNoqEMqDx6HMYTCHUCX71rXFX3/xpfF
 M9XgDCBIDUKNGjmUISkR5bXQav3569vsVNBXQSEJZ6kVoJ+DEk+2YMy8VNQQd7jmuwdC Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ase029ate-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 14:33:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17VELej8025359;
        Tue, 31 Aug 2021 14:33:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 3aqcy4u5k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 14:33:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EonHCC86rtDNrsB2xC4fLnAFrFYlhm5we0Wu0iBojcJnPA1JFiuxabkOgbRM0E+E8QdMO+Si++Nxrw88cD1832ehzlk4ljc6lBji5sDAZrVz/B1VXF+jH8Hu5r7RPIsAPTfPTPK/X+vVso0fCf11J/nvR5qzZj0GFv28m4iWD2OkuHGdbyISERNjaz7lq52TQR3jN3SRTdEU6r6U8ZszLe7yl461bjHjqlJkR20Tdwl54mVoq6XkOh/NIlPWUX/wWZoKFaSBUJ+TIPiFOjZ6gOYeMHOVfYLxnbMyqeTh+ELgCIeDK8DZ4Qh9i/HZttbphdkpcjw+syPy2/hdaj5n7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2IFnayQ2aAhuPLZw21T7A2QjRX0j708aALAORE4Hs0=;
 b=FzsQEZ8Jp5SSuwv+1IBKsPNag8ja4w2bwLnwa2qKT5LhqlPE2p2pISlA5EYkluqu+9VvwyJuz360tWPdFjUPRGg/gVbHc7Oe+6Rqs6+ltzMhwgEA7TE8VtcCnHJtAxZbJUY8AlJT+6Ud/OZY+tWGcJll3C9gIXtxd/F9gOdjMUg6wEcUcFlkdARB4wxPufUPSHmJLOHjOKpRA0IihgwqDy40iDQ+OWX2fUyNxE+ElP/wY6mHkeeVlbl/EWxTKQzIRIEzUgcqobkSCno5tDq62DOdN68p3dj8rndTkgH6jOuMe9GnunmQXbIkPHxsW/9IWCHUjzfP1xtNlCuSuf8l+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2IFnayQ2aAhuPLZw21T7A2QjRX0j708aALAORE4Hs0=;
 b=XyGNSLUw9TjMVkBFJOcZqQMS561QK9Gr4KfYNRPVI2Eh+MZb9uH5Q/7aShUugVX7i6Apoxz/4D76k38g66wlN1pclYXCwMzpXVk5KLEQgBVyQLEI1axROWqJDH9rxu7kpWRaoG4UfK3S13FVxUu/tmbtKFLrvn9TYv0WMpkrJI4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4260.namprd10.prod.outlook.com (2603:10b6:a03:202::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Tue, 31 Aug
 2021 14:33:03 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%7]) with mapi id 15.20.4478.017; Tue, 31 Aug 2021
 14:33:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>
Subject: Re: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Topic: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Index: AQHXnb+EPQ6bfsCh/km34j6ENph6pKuMRqKAgAAFyYCAAALCgIAAB7UAgAAEWwCAACcYgIABLGAA
Date:   Tue, 31 Aug 2021 14:33:03 +0000
Message-ID: <AA0A4E98-482C-4276-B8C8-96AF08550320@oracle.com>
References: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
 <20210830165302.60225-2-olga.kornievskaia@gmail.com>
 <F7F9A947-B282-416F-BC65-796BF325054F@oracle.com>
 <CAN-5tyEB9nv576uJijBtyhv2pqAHGNB4yeKo=F21btOkVQuaDQ@mail.gmail.com>
 <04f975f95126921f3d239a7a9d80ced2d88b05ff.camel@hammerspace.com>
 <C73DE4AF-9C1D-4694-839B-D88EABAA6DAC@oracle.com>
 <9448f294a39775734212083cbe329642b9e15d09.camel@hammerspace.com>
 <B5C7A8A1-E810-4616-9E1A-265BADEC5432@oracle.com>
In-Reply-To: <B5C7A8A1-E810-4616-9E1A-265BADEC5432@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ad945ef-4555-4a07-6019-08d96c8c3db1
x-ms-traffictypediagnostic: BY5PR10MB4260:
x-microsoft-antispam-prvs: <BY5PR10MB4260975BE225AA47917E976593CC9@BY5PR10MB4260.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6TiNXun/4oo8Uq+2ss2LAPQ6HlgLBCu1nAL+zX8yHMNPiRoyPWVrJ9Y4TtE9/zrMwpuDHDfcldiwHCYB3tfOurc1FwO7exVfXwDJmxA3crvdfSE9dTetkg/8PvKSt3kcR2gUGjqmUhxy5w+ncK9kUkVto99JnCwzE6EuUJd0DV45Z39kYhVIaJXEZG+IbQ5U1rz4sc+xtuj8EvUo33szOKuz5wvvEuDhN75Bpcxr6hJPQLK6jCePHyvQXrkbVGGuM/gwWQQu2TJCWPKPhWbAMCPlha5tTTEFadn5yVpuCOoujIm5ukuUJl5OMtOEzpnqPLrYxllLvYVZdFcLrHbQZXXqNmpcsfNUFBReRTOWYpO684OvqB9bbSkW+RiIwduEFcUEW80Gw2xx1AOpNjU26NSxwrnnw3JLPHLfJIvf8Cmo12rFnVE6vOnApDPlRpco0iz4TZzq7ZVgn/fL84MtX9xEhwjnU3EOG2AdztWBQSp62BrLbLEzOWVOMJ1hWQXU7S6TRt7f95j82FTgTjSrGjrbT01Kgmj8H6onSpZsdoPpxnS5t2gSOsl1FsASRc7Gt+dIHW27nq9ffZ0y17O8zuajI3Bi1UXGR0BgXF9CI6upgG+0usmlDzdOW2gn/vkuuGCdwj+JbpUaFgn3ucmurzlgeCS7ufpWlAzxjlOc7W8G6bZFdYTGSJen9v9PrO7zUrVOvEaqZYcJe5Mq+ZfEGYukZNfr2jDeagQNrCR/EMdvZXTW0IsgI0tzmfPR4NVo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(376002)(346002)(136003)(38070700005)(6506007)(33656002)(478600001)(53546011)(66446008)(2616005)(83380400001)(54906003)(26005)(66556008)(5660300002)(64756008)(66476007)(8676002)(91956017)(6916009)(122000001)(186003)(36756003)(66946007)(316002)(86362001)(71200400001)(38100700002)(6486002)(6512007)(2906002)(4326008)(8936002)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zqSb9ZKnO7sw5wSLGF9+AlzMQquOaYceQr7ICp0bCiorCwcV0yy+GkSAA0iy?=
 =?us-ascii?Q?sEa6KFlMx/kYkAoV61ex6l5j8L/VBiAL5v6Ox0CDsmFIQNRG3Mg3UPyo9gH+?=
 =?us-ascii?Q?2+Gb8X1sqI4X4viaUsQbtDvpiW5af7bx4cFQb7/vXMRdK+T9oNqkCXLXsP0s?=
 =?us-ascii?Q?JGARbDErbveqPP+AyWsM+5LRTpaadxJmAo42PlhKRbfabce6f2EWYsCJIh2+?=
 =?us-ascii?Q?3qf1qG4LSsGPFq4vh+Brg6pdSSAziMy7xWaXFipja+/Itb5OenQ2ecF8LsLS?=
 =?us-ascii?Q?BK4tGUQ7g4PQNZ9cz6WMV2ww7UH9F8JW6Guvcvp4DyjTXYLLYoNKLFalNHHv?=
 =?us-ascii?Q?8S4ttKTcO8r90K/lFoqWdu430mQZD3qF35lmK3pvtq9V6MLVHEzEaSVz5oIv?=
 =?us-ascii?Q?KvsgfYiu7do11hGtsr7Vh/blhawQ5LPs/9qQlLjfVvOZ/PEvW7tgSsl1cTMi?=
 =?us-ascii?Q?u7c6FQzICUCdLahrypau4K6QFwCYYUJKwVm0YJSk1gjGvTi7BvLriEjmsnE1?=
 =?us-ascii?Q?+iTNW5yfguoaTfbAT5NWRphXAgSO4F4KRfGfpH2uGZks3pXlpd2rfpeRkYVK?=
 =?us-ascii?Q?GNGHr8iwNxK6CiCIVNyztYJ+1XwHwWp/KzOEABB6Q4ODuN5+GDMzrTSXxqc7?=
 =?us-ascii?Q?th+GsQWUsY4/Rjqa9fMfGLAlUlRU/FBKPqL0pahI/MOI2kWhuAs0lrTiO1vu?=
 =?us-ascii?Q?1CoOdTc02KDIrwOqmiIZDcDzSZUxqLQMJcwvF9QlQ/vGmzHyt6SK6xrKXwgd?=
 =?us-ascii?Q?/LPmaK4Yp4Pcdl+opYvPQGUFNewBd5YAgR+3b6Z0JkGSa0fTShQBg/587VhO?=
 =?us-ascii?Q?QRkBlExYZwXP4b/F6T3dsomPK3kIqCKhqfaN5hWTg3TWdxxq8bwRb+b84HQp?=
 =?us-ascii?Q?zD/kDsB/RCRpykLBOjbYYBgGWomlq7B9a6mLCYYMwf+VxzsjCaNBbCaMU5VC?=
 =?us-ascii?Q?ERnOJcD85s2TFuu3AeFyZHIMSrKhvWfWw4g4LpjjRu+2AzI4YXo9Y0fOhSgQ?=
 =?us-ascii?Q?Lear4XpSBCGPlrojggN0/JVrEbWLEAUMvrYvFLL0tpZCKIIy0ihCQ/pq66Lw?=
 =?us-ascii?Q?L4aNhqfLme2oHCs4tk7Wi70zevGXwVxC6Z95iFh+H+q6A3FWxVIG8kDqp4d+?=
 =?us-ascii?Q?e2cKe8MWF2FXZvs13weutGOvcrJ/XiZpOTLEdypzwODqV4QTRlsfOivkoUVR?=
 =?us-ascii?Q?BMH1yvZN7rXWjYL1Hzp2NBLZCwvu8qvKdXh/ed6G3APeFknzg6zORtX/VGml?=
 =?us-ascii?Q?dR+bQ81BYdZK15+P46qW7L3ERMrTS4SGj79jX17pzbU0pDKRpyVJk1+4EjRh?=
 =?us-ascii?Q?F5mdM3VSYCup0JUZqfoqnMDx?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82D1884ADDEE494797713AE37CDDF347@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad945ef-4555-4a07-6019-08d96c8c3db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 14:33:03.3163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SodEZwbvrNAwAzvitDALy7mqXkBZvZm1GXsCLxnDDHcq6FW6dGhcjFf2ADQwHxw1GcL7dkIyAJHjEzDS7Uq4Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4260
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310079
X-Proofpoint-GUID: 1zc2VZQVRq2o_q5cKtCbCcaeGS6AZs66
X-Proofpoint-ORIG-GUID: 1zc2VZQVRq2o_q5cKtCbCcaeGS6AZs66
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Aug 30, 2021, at 4:37 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>> On Aug 30, 2021, at 2:18 PM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>>=20
>> On Mon, 2021-08-30 at 18:02 +0000, Chuck Lever III wrote:
>>>=20
>>>> On Aug 30, 2021, at 1:34 PM, Trond Myklebust
>>>> <trondmy@hammerspace.com> wrote:
>>>>=20
>>>> On Mon, 2021-08-30 at 13:24 -0400, Olga Kornievskaia wrote:
>>>>> On Mon, Aug 30, 2021 at 1:04 PM Chuck Lever III
>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>=20
>>>>>> Hi Olga-
>>>>>>=20
>>>>>>> On Aug 30, 2021, at 12:53 PM, Olga Kornievskaia
>>>>>>> <olga.kornievskaia@gmail.com> wrote:
>>>>>>>=20
>>>>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>>>>=20
>>>>>>> Given the patch "Always provide aligned buffers to the RPC
>>>>>>> read
>>>>>>> layers",
>>>>>>> RPC over RDMA doesn't need to look at the tail page and add
>>>>>>> that
>>>>>>> space
>>>>>>> to the write chunk.
>>>>>>>=20
>>>>>>> For the RFC 8166 compliant server, it must not write an XDR
>>>>>>> padding
>>>>>>> into the write chunk (even if space was provided).
>>>>>>> Historically
>>>>>>> (before RFC 8166) Solaris RDMA server has been requiring the
>>>>>>> client
>>>>>>> to provide space for the XDR padding and thus this client
>>>>>>> code
>>>>>>> has
>>>>>>> existed.
>>>>>>=20
>>>>>> I don't understand this change.
>>>>>>=20
>>>>>> So, the upper layer doesn't provide XDR padding any more. That
>>>>>> doesn't
>>>>>> mean Solaris servers still aren't going to want to write into
>>>>>> it.
>>>>>> The
>>>>>> client still has to provide this padding from somewhere.
>>>>>>=20
>>>>>> This suggests that "Always provide aligned buffers to the RPC
>>>>>> read
>>>>>> layers" breaks our interop with Solaris servers. Does it?
>>>>>=20
>>>>> No, I don't believe "Always provide aligned buffers to the RPC
>>>>> read
>>>>> layers" breaks the interoperability. THIS patch would break the
>>>>> interop.
>>>>>=20
>>>>> If we are not willing to break the interoperability and support
>>>>> only
>>>>> servers that comply with RFC 8166, this patch is not needed.
>>>>=20
>>>> Why? The intention of the first patch is to ensure that we do not
>>>> have
>>>> buffers that are not word aligned. If Solaris wants to write
>>>> padding
>>>> after the end of the file, then there is space in the page buffer
>>>> for
>>>> it to do so. There should be no need for an extra tail in which to
>>>> write the padding.
>>>=20
>>> The RPC/RDMA protocol is designed for hardware-offloaded direct data
>>> placement. That means the padding, which isn't data, must be directed
>>> to another buffer.
>>>=20
>>> This is a problem with RPC/RDMA v1 implementations. RFC 5666 was
>>> ambiguous, so there are implementations that write XDR padding into
>>> Write chunks. This is why RFC 8166 says SHOULD NOT instead of MUST
>>> NOT.
>>>=20
>>> I believe rpcrdma-version-two makes it a requirement not to use XDR
>>> padding in either Read or Write data payload chunks.
>>>=20
>>>=20
>> Correct, but in order to satisfy the needs of the Solaris server,
>> you've hijacked the tail for use as a data buffer. AFAICS it is not
>> being used as a SEND buffer target, but is instead being turned into a
>> write chunk target. That is not acceptable!
>=20
> The buffer is being used as both. Proper function depends on the
> order of RDMA Writes and Receives on the client.

I've refreshed my memory. The above statement oversimplifies
a bit.

- The memory pointed to by rqst->rq_buffer is persistently
  registered to allow RDMA Send from it. It can also be
  registered on the fly for use in Read chunks.

- The memory pointed to by rqst->rq_rbuffer is NOT
  persistently registered and is never used for RDMA Send
  or Receive. It can be registered on the fly for use in a
  Write or Reply chunk. This is when the tail portion of
  rq_rcv_buf might be used to receive a pad.

- A third set of persistently registered buffers is used
  ONLY to catch RDMA Receive completions.

When a Receive completes, the reply handler decides how to
construct the received RPC message. If there was a Reply
chunk, it leaves rq_rcv_buf pointing to rq_rbuffer, as that's
where the server wrote the Reply chunk. If there wasn't a
Reply chunk, the handler points rq_rcv_buf to the RDMA
Receive buffer.

The only case where there might be overlap is when the client
has provisioned both a Write chunk and a Reply chunk. In that
case, yes, I can see that there might be an opportunity for
the server to RDMA Write the Write chunk's pad and the Reply
chunk into the same client memory buffer. However:

- Most servers don't write a pad. Modern Solaris servers
  behave "correctly" in this regard, I'm now told. Linux
  never writes the pad, and I'm told OnTAP also does not.

- Server implementations I'm aware of Write the Write chunk
  first and then the Reply chunk. The Reply chunk would
  overwrite the pad.

- The client hardly ever uses Write + Reply. It's most
  often one or the other.

So again, there is little to zero chance there is an existing
operational issue here. But see below.


> rpcrdma_encode_write_list() registers up to an extra 3 bytes in
> rq_rcv_buf.tail as part of the Write chunk. The R_keys for the
> segments in the Write chunk are then sent to the server as part
> of the RPC Call.
>=20
> As part of Replying, the server RDMA Writes data into the chunk,
> and possibly also RDMA Writes padding. It then does an RDMA Send
> containing the RPC Reply.
>=20
> The Send data always lands in the Receive buffer _after_ the Write
> data. The Receive completion guarantees that previous RDMA Writes
> are complete. Receive handling invalidates and unmaps the memory,
> and then it is made available to the RPC client.
>=20
>=20
>> It means that we now are limited to creating COMPOUNDs where there are
>> no more operations following the READ op because if we do so, we end up
>> with a situation where the RDMA behaviour breaks.
>=20
> I haven't heard reports of a problem like this.
>=20
> However, if there is a problem, it would be simple to create a
> persistently-registered memory region that is not part of any RPC
> buffer that can be used to catch unused Write chunk XDR padding.
>=20
>=20
>>>> This means that the RDMA and TCP cases should end up doing the same
>>>> thing for the case of the Solaris server: the padding is written
>>>> into
>>>> the page buffer. There is nothing written to the tail in either
>>>> case.
>>>=20
>>> "Always provide" can guarantee that the NFS client makes aligned
>>> requests for buffered I/O, but what about NFS direct I/O from user
>>> space? The NIC will place the data payload in the application
>>> buffer, but there's no guarantee that the NFS READ request will be
>>> aligned or that the buffer will be able to sink the extra padding
>>> bytes.
>>>=20
>>> We would definitely consider it an error if an unaligned RDMA Read
>>> leaked the link-layer's 4-byte padding into a sink buffer.
>>>=20
>>> So, "Always provide" is nice for the in-kernel NFS client, but I
>>> don't believe it allows the way xprtrdma behaves to be changed.
>>>=20
>>=20
>> If you're doing an unaligned READ from user space then you are already
>> in a situation where you're doing something that is incompatible with
>> block device requirements.
>> If there really are any applications that contain O_DIRECT code
>> specifically for use with NFS, then we can artificially force the
>> buffers to be aligned by reducing the size of the buffer to align to a
>> 4 byte boundary. NFS supports returning short reads.
>=20
> Or xprtrdma can use the scheme I describe above. I think that
> would be simpler and would avoid layering violations.
>=20
> That would also possibly address the Nvidia problem, since a
> pre-registered MR that handles Write padding would always be a
> separate RDMA segment.
>=20
> Again, I doubt this is necessary to fix any operational problem
> with _supported_ use cases, but let me know if you'd like me to
> make this change.

Since RFC 8666 says "SHOULD NOT", the spec mandates that the client
has to expect there might be a server that will RDMA Write the XDR
pad, so the Linux client really should always provide one. Having
a persistently registered spot to use for that means we have a
potential no-cost mechanism for providing that extra segment. The
whole "pad optimization" thing was because the pad segment is
currently registered on the fly, so it has a per-I/O cost.

So I'm leaning toward implementing this simple solution, at least
as proof-of-concept.


--
Chuck Lever



