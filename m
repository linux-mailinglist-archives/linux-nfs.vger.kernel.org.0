Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FDA320007
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 21:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhBSU4w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 15:56:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52518 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBSU4v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 15:56:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JKt32g020358;
        Fri, 19 Feb 2021 20:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=EPmxXeII2IG/Ev+Kp9H9w1Y2CZQeCn/NKtPtcQuxFJY=;
 b=TXGbp3ZnHy43A6kEKi9VF6bl6TUBn7xiCpnyZz0tJfiNrHoSmhVUL7JqypXTlZ1sNSV9
 9juZy6R79CnlP1YQ1f+GncOCtufwwgAqayWAExiBkfBEZ6eAvS/GLjmS2Eukr7/gCCkJ
 2EyFtdo3FkJNtApq0i6OyXgIoluRpdUbdrYntLw8+L8esqrFJ00Fct5iSE1DOVQNtXsQ
 /9rahFhmujAVTq/1Zpw/Iowlp+71dWM6MBCxpeIOjgB4kSWmIqLaiU8RMq97n9BQP+c+
 plWcrerR2+9sYvxPMxlFrQ9fmsEMt4gqZ0X9g2S9Vc2nMSAMW/LoQaasFY/icCI+kX+5 aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36p66rat6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 20:56:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JKkX8P010063;
        Fri, 19 Feb 2021 20:56:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3030.oracle.com with ESMTP id 36prbskabj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 20:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fowYblLVfT2bI0hibp5/WdHTGTPCyBDMKv+9OsP1toZ97yi8i+NbkJgFemfgcoHreVommWUVaJ1EcrvVyp9nN94MPupYR0+6tVc8iwu2OUW9fkq0HH5v0PW/cqNJHgEzh+fGg7dM1OJKxqUq1s6IFbpEP4b0d/viLdU0jHyJK4qAJMWKTWJyjnnD4WEyxcPWt06zrMNrAT6A9+mx050jlbZJfXj85Ib306+8t2k5K+wxO1KMzxvEsy1OPuS9dp8aBNPPOf7NqWJXbRgPzdzv1t5li1vh5wFLZJKKMcC0SyNUzX/Z2BB+C2nodRaXSfA/AlLGVG0g0ER2dJNlZSYGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPmxXeII2IG/Ev+Kp9H9w1Y2CZQeCn/NKtPtcQuxFJY=;
 b=XwNdxZpdhKr872WlW/m1KaUhuzN07+HuE3oco21v0ccCLl8i3+OFlZ95lOwEv17vvJc+dyQOapsWysIwZrxRVZ5CAUDYPia+DfQf8Ccx6AEUQpynFA+rfIs4jWoyRc45ueggAmKVejUsC7Sc92yJsepShC8ic8AyBSFOsSYimw1olMFlj9YDCl6JAceqdtvw3t2dzpzAzVedxaWl73UVL8VgFnhrV9Q5V8Q2ORu3wy1wiAVYARZ5IeE3K1SU52vKwr5COoJPIdLf7QrjywWoeJoDqEuCa4kHrGCCpZUfWMZ+B61mHlvVFRjw5JVEt9OCysp+u51HTKFXyo0KoIB9Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPmxXeII2IG/Ev+Kp9H9w1Y2CZQeCn/NKtPtcQuxFJY=;
 b=usgKSUxzGc7goOatP+4J2K/BJ5qiDrEZVslEuMyFbKUfqXJDEw6JQxwCyPFCRXowBgf8OHVU8wxDHrNvECU2u31ETOYi259rGeIbw5zhlKZr3jr5N2SDVwihuUShGOyyJNyG8LaRHBK4r5KUUXeULclLKZczhFHIkwZ3Llg8N9E=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4814.namprd10.prod.outlook.com (2603:10b6:a03:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 20:55:58 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.043; Fri, 19 Feb 2021
 20:55:58 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Timo Rothenpieler <timo@rothenpieler.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
Thread-Topic: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
Thread-Index: AQHXAoMfawdRzWrgDkSpe5/TYHEFmapbOyaAgAAHBQCAAB6ZgIABlTwAgAArPQCAACy3AIAA0KWSgAAkhACAAB9zAIABZJ0AgAACxwCAAANsgIAADTqAgAAgBICAAAOaAA==
Date:   Fri, 19 Feb 2021 20:55:58 +0000
Message-ID: <1A329051-FD97-4200-AB48-B3DAE7AA9D21@oracle.com>
References: <57f67888-160f-891c-6217-69e174d7e42b@rothenpieler.org>
 <CAN-5tyE4OyNOZRXGnyONcdGsHaRAF39LSE5416Kj964m-+_C2A@mail.gmail.com>
 <81cb9aef-c10d-f11c-42c0-5144ee2608bc@rothenpieler.org>
 <0e49471c-e640-a331-c7b4-4e0a49a7a967@rothenpieler.org>
 <CAN-5tyG9Ly9tqKxguFNhg_PGXCxE2=Zn6LQPLY59twdVkD3Auw@mail.gmail.com>
 <51a8caa7-52c2-8155-10a7-1e8d21866924@rothenpieler.org>
 <CAN-5tyFT4+kkqk6E0Jxe-vMYm7q5mHyTeq0Ht7AEYasA30ZaGw@mail.gmail.com>
 <3f946e6b-6872-641c-8828-35ddd5c8fed0@rothenpieler.org>
 <e89ab742-7984-6a2c-2f01-402283ba6e89@rothenpieler.org>
 <CAN-5tyGhyh0ZF77voaN4TNgMt+jSUG0PMp-KixfTvgUhDdhDUQ@mail.gmail.com>
 <def12560-2481-b17d-5a42-7236edbd5392@rothenpieler.org>
 <CAN-5tyHLRn4HEs9R291N6Y=boOvQ9-qvKfJzA8Khkqie2kVVWQ@mail.gmail.com>
 <6478B738-0C33-46DC-B711-B0BF7069FD82@oracle.com>
 <19c74710-bf35-6412-dd06-071331419ab5@rothenpieler.org>
 <E4BAC726-2FFA-47A8-A1B6-F0D2848ABB98@oracle.com>
 <CAN-5tyHq-1SM8o-qpeF-_UGd0a74ky8Atcam=gY9HqUrMhfp_g@mail.gmail.com>
In-Reply-To: <CAN-5tyHq-1SM8o-qpeF-_UGd0a74ky8Atcam=gY9HqUrMhfp_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3eeddc9-7bea-4f69-f843-08d8d518c244
x-ms-traffictypediagnostic: SJ0PR10MB4814:
x-microsoft-antispam-prvs: <SJ0PR10MB48145AC740AB38D52694723093849@SJ0PR10MB4814.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YfwjtDeYEn4xX0rfZfH29XQAgd9S9bzIUjS3gifbgJmQH5wBbAUOb0/7jEMPP9rPvXvn+uClLsWkYmRjqKQ9MoL/pUThzCBwkkqgKa5tzrKlBhzSApXspB10UkFO4+5vEiAwpjLoWO2Db8xSJaXJLCxfh3KZnri1HTqEV+kZVVk7x3zc+tIgedeSm+csxg2RdDny1dcE5jusvGp6GcsNGEH2usKFV9L0svRMLjQMMC0GBHb2ig4X6oZJuudgwz7qtUvytzbLWGZEb5tUbbtcAi5P7uko1v2snslLsBgStvIELzTVNz3/eT+0wxiYVhLQKnyHScN8lmmfPRMK10lNsV9DjWeZUGZ2MBiTVfpX9sTjscCokF+rFOt9QRy+RhoC2ZBLGGzcbqs7x3l8eRnUAVDehsb6WUwTdJ+fbzQ112q5rIOvEDBNLcWedgN3JbkoyuBPItRXpQBLCshRpPHLUCF7V3I8U50NXb0/Mww/uH5F9dYnAl1C7M8DniusErpfUSetTciZEbfsfhMaCRq6W9a6VLMitk1A1rzO3muWu5mR3vbM+mmpbVQOReZhZGSVyZXYYUE4HLxpwRRQRSO3cQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(396003)(39860400002)(66446008)(83380400001)(84040400003)(6512007)(8936002)(8676002)(33656002)(66556008)(64756008)(71200400001)(36756003)(66946007)(86362001)(186003)(2906002)(5660300002)(53546011)(316002)(44832011)(91956017)(66476007)(76116006)(478600001)(54906003)(6506007)(6486002)(6916009)(26005)(2616005)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3I2wU/NVzH/lFM2gc1ySNrhURvZEzOmchn0QYgyslOlYJlZmda9eSlI3HKLr?=
 =?us-ascii?Q?jOGWUjJa8Nou5AaAh8Q7DTjJ2Apb1MxCcAWVfKEJnzeDFCvuWe58yHVn9PQF?=
 =?us-ascii?Q?n158CvTtMw6ZWEQVvWlOyoKzbHe+GhLciG3RWPrHtODVLtP/K7ofCXP5XtTu?=
 =?us-ascii?Q?wKW5xIpjoOjVBOYil6bRX6IWhZdqMTS3CoTLyKjeI4n0CKdnedn1fYX9P28o?=
 =?us-ascii?Q?jPKnvXDe8msTjDcV1s3OkOgoteltNURHCZntuUROIz9aFRlT6QFmLuf9hp8A?=
 =?us-ascii?Q?0oj8qwxaeSZo62lefv3oJf6Qrq5sWB/OHaa4/mL0413xd+Bj2WVsTE2C/x3V?=
 =?us-ascii?Q?mcsLhw5z7T1oZNPaF6Z6Sni/Yfj8t5abd5vtwGfIOgHIfj6erSwI1Wc23kDq?=
 =?us-ascii?Q?ssbiKvLXw6UT9sP3YGaUXYIbVqklHQs4pJ7ILW5AoGNg22N++QwsO5OyzPmf?=
 =?us-ascii?Q?9FQjpkGll9r7E/lLSnsY+G/PDD9X8L6UbB/V7KzChBYusaLzZldL49HAh6pz?=
 =?us-ascii?Q?NbddDr8wOS1LN0a/Ng4zOXtvfevUA1V/z1eu1+MaF+76xLcCc5wUFsd2x6PI?=
 =?us-ascii?Q?MFSBOx5p686hMsYWBQcfPMs1VrATLGzM3X7iytT5Y/1L8BTzJfjgY2GUlyiX?=
 =?us-ascii?Q?4Yrbc7OEhE0iRGLemQ2eJAjwVMuWjm/VhEA6SIilqUsTm3mTWZyNRCC/Hrr2?=
 =?us-ascii?Q?NoxaV8Rtb1lAY3RXUAXbyF77uifI2sLoxKJFVmNXVSJO18j4R+QhX1eMaLBM?=
 =?us-ascii?Q?7qVaBUABNjb6WiPsw2QZ7X3h19sSKaDV7iQCeEe541CLHvVyt7vkAgFEutKr?=
 =?us-ascii?Q?s5FhFGizkACypyYsoE2EH2bpy1NAbwTKnYK3t1Kw6hPYxQ7ySd5udjXfcNk0?=
 =?us-ascii?Q?EHZFFVOJdydgECMWoi6YgUzoMYdpiVc2QAQKV6p9E7V55J2nxxjYHcJV4omK?=
 =?us-ascii?Q?0dl6BaxdlDzIrkbxO2xyhnz6wbLa4/18SzpJwl6EwTz7H/TD8Uj7t7HJTmnF?=
 =?us-ascii?Q?Wrx02MMmjp5jgq85zWo1mCg0DSfI9CxYi72oqYfwy2XU1T0QvAjKG/1DIA48?=
 =?us-ascii?Q?+V+1zp1dN9bT7cYd6G53a7Uj5b7D6WElN6twmZyi/J92SwLjszIO+SvomiqK?=
 =?us-ascii?Q?lqUoliGXZckF8qJ77+38jU/S9xZXDViXj3B0DlKmTl6q7hMSREag83nNRZGl?=
 =?us-ascii?Q?4hHYR2yEKfP9l36wyBC6Pzwj1Q5tTinUD1cOkBa5890CerOlUc4rYUr/7Vy+?=
 =?us-ascii?Q?WNC+9t6q5H7TwVmb6x/N3BDRWnKC8IW7GlWmZ363x+sDWkUs5WvWDkJ5xFYV?=
 =?us-ascii?Q?e+bVzff1HZxxRq+PgtLLAEdN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E14E7957EF5FB84A9CB1C7D576519C47@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3eeddc9-7bea-4f69-f843-08d8d518c244
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 20:55:58.6593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qslz7C/kUJnxZUdrQ/DbTR6G340my/ZzwfiV9WGu0IARVeNyWOpRp3Z5CQKapYqJ/T9KkIsXPABvyzSBkaqDyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190167
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190168
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 19, 2021, at 3:43 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Fri, Feb 19, 2021 at 1:48 PM Chuck Lever <chuck.lever@oracle.com> wrot=
e:
>>=20
>>=20
>>=20
>>> On Feb 19, 2021, at 1:01 PM, Timo Rothenpieler <timo@rothenpieler.org> =
wrote:
>>>=20
>>> On 19.02.2021 18:48, Chuck Lever wrote:
>>>>> On Feb 19, 2021, at 12:38 PM, Olga Kornievskaia <aglo@umich.edu> wrot=
e:
>>>>>=20
>>>>> On Thu, Feb 18, 2021 at 3:22 PM Timo Rothenpieler <timo@rothenpieler.=
org> wrote:
>>>>>>=20
>>>>>> On 18.02.2021 19:30, Olga Kornievskaia wrote:
>>>>>>> Thank you for getting tracepoints from a busy server but can you ge=
t
>>>>>>> more? As suspected, the server is having issues sending the callbac=
k.
>>>>>>> I'm not sure why. Any chance to turn on the server's sunrpc
>>>>>>> tracespoints, probably both sunrpc and rdmas tracepoints, I wonder =
if
>>>>>>> we can any more info about why it's failing?
>>>>>>=20
>>>>>> I isolated out two of the machines on that cluster now, one acting a=
s
>>>>>> NFS server from an ext4 mount, the other is the same client as befor=
e.
>>>>>> That way I managed to capture a trace and ibdump of an entire cycle:
>>>>>> mount + successful copy + 5 minutes later a copy that got stuck
>>>>>>=20
>>>>>> Next to no noise happened during those traces, you can find them att=
ached.
>>>>>>=20
>>>>>> Another observation made due to this: unmount and re-mounting the NF=
S
>>>>>> share also gets it back into working condition for a while, no reboo=
t
>>>>>> necessary.
>>>>>> During this trace, I got "lucky", and after just 5 minutes of waitin=
g,
>>>>>> it got stuck.
>>>>>>=20
>>>>>> Before that, I had a run of mount + trying to copy every 5 minutes w=
here
>>>>>> it ran for 45 minutes without getting stuck. At which point I decide=
d to
>>>>>> remount once more.
>>>>>=20
>>>>> Timo, thank you for gathering the debug info.
>>>>>=20
>>>>> Chuck, I need your help. Why would the server lose a callback channel=
?
>>>>>=20
>>>>>          <...>-1461944 [001] 2076465.200151: rpc_request:
>>>>> task:57752@6 nfs4_cbv1 CB_OFFLOAD (async)
>>>>>          <...>-1461944 [001] 2076465.200151: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserve
>>>>>          <...>-1461944 [001] 2076465.200154: xprt_reserve:
>>>>> task:57752@6 xid=3D0x00a0aaf9
>>>>>          <...>-1461944 [001] 2076465.200155: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserveresult
>>>>>          <...>-1461944 [001] 2076465.200156: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refresh
>>>>>          <...>-1461944 [001] 2076465.200163: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refreshresult
>>>>>          <...>-1461944 [001] 2076465.200163: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_allocate
>>>>>          <...>-1461944 [001] 2076465.200168: rpc_buf_alloc:
>>>>> task:57752@6 callsize=3D548 recvsize=3D104 status=3D0
>>>>>          <...>-1461944 [001] 2076465.200168: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_encode
>>>>>          <...>-1461944 [001] 2076465.200173: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0
>>>>> action=3Dcall_connect
>>>>>          <...>-1461944 [001] 2076465.200174: rpc_call_rpcerror:
>>>>> task:57752@6 tk_status=3D-107 rpc_status=3D-107
>>>>>          <...>-1461944 [001] 2076465.200174: rpc_task_run_action:
>>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>>> runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D-107
>>>>> action=3Drpc_exit_task
>>>>>=20
>>>>> It's reporting ENOTCON. I'm not really sure if this is related to cop=
y
>>>>> offload but more perhaps doing callbacks over RDMA/IB.
>>>> If the client is awaiting a COPY notification callback, I can see why
>>>> a lost CB channel would cause the client to wait indefinitely.
>>>> The copy mechanism has to deal with this contingency... Perhaps the
>>>> server could force a disconnect so that the client and server have an
>>>> opportunity to re-establish the callback channel. <shrug>
>>>> In any event, the trace log above shows nothing more than "hey, it's
>>>> not working." Are there any rpcrdma trace events we can look at to
>>>> determine why the backchannel is getting lost?
>>>=20
>>> The trace log attached to my previous mail has it enabled, along with n=
fsd and sunrpc.
>>> I'm attaching the two files again here.
>>=20
>> Thanks, Timo.
>>=20
>> The first CB_OFFLOAD callback succeeds:
>>=20
>> 2076155.216687: nfsd_cb_work:         addr=3D10.110.10.252:0 client 602e=
b645:daa037ae procedure=3DCB_OFFLOAD
>> 2076155.216704: rpc_request:          task:57746@6 nfs4_cbv1 CB_OFFLOAD =
(async)
>>=20
>> 2076155.216975: rpc_stats_latency:    task:57746@6 xid=3D0xff9faaf9 nfs4=
_cbv1 CB_OFFLOAD backlog=3D33 rtt=3D195 execute=3D282
>> 2076155.216977: nfsd_cb_done:         addr=3D10.110.10.252:0 client 602e=
b645:daa037ae status=3D0
>>=20
>>=20
>> About 305 seconds later, the autodisconnect timer fires. I'm not sure if=
 this is the backchannel transport, but it looks suspicious:
>>=20
>> 2076460.314954: xprt_disconnect_auto: peer=3D[10.110.10.252]:0 state=3DL=
OCKED|CONNECTED|BOUND
>> 2076460.314957: xprt_disconnect_done: peer=3D[10.110.10.252]:0 state=3DL=
OCKED|CONNECTED|BOUND
>>=20
>>=20
>> The next CB_OFFLOAD callback fails because the xprt has been marked "dis=
connected" and the request's NOCONNECT flag is set.
>>=20
>> 2076465.200136: nfsd_cb_work:         addr=3D10.110.10.252:0 client 602e=
b645:daa037ae procedure=3DCB_OFFLOAD
>> 2076465.200151: rpc_request:          task:57752@6 nfs4_cbv1 CB_OFFLOAD =
(async)
>>=20
>> 2076465.200168: rpc_task_run_action:  task:57752@6 flags=3DASYNC|DYNAMIC=
|SOFT|NOCONNECT runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_encode
>> 2076465.200173: rpc_task_run_action:  task:57752@6 flags=3DASYNC|DYNAMIC=
|SOFT|NOCONNECT runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0 ac=
tion=3Dcall_connect
>> 2076465.200174: rpc_call_rpcerror:    task:57752@6 tk_status=3D-107 rpc_=
status=3D-107
>> 2076465.200174: rpc_task_run_action:  task:57752@6 flags=3DASYNC|DYNAMIC=
|SOFT|NOCONNECT runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D-107=
 action=3Drpc_exit_task
>> 2076465.200179: nfsd_cb_done:         addr=3D10.110.10.252:0 client 602e=
b645:daa037ae status=3D-107
>> 2076465.200180: nfsd_cb_state:        addr=3D10.110.10.252:0 client 602e=
b645:daa037ae state=3DFAULT
>>=20
>>=20
>> Perhaps RPC clients for NFSv4.1+ callback should be created with
>> the RPC_CLNT_CREATE_NO_IDLE_TIMEOUT flag.
>=20
> Do you know if this callback behavior is new? The same problem would
> exist with delegation recalls.

Delegation recall would be affected, but that wouldn't cause an
indefinite hang. The server should eventually revoke the delegation
and life would continue.

Also, the server should be setting the CALLBACK_DOWN sequence status
flag in its replies. If the client isn't sending any other traffic
while waiting for the copy to complete, it probably wouldn't notice
the problem.

Is the client renewing its lease while the copy is ongoing? That
would be an opportunity for the server to signal the loss of
backchannel connectivity.

Again, in the long term, the copy mechanism needs to be prepared for
the contingency that the callback channel is lost while copy
operations are pending.

There's plenty to investigate and confirm here.


--
Chuck Lever



