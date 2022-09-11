Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7EB5B50A3
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Sep 2022 20:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiIKSgo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Sep 2022 14:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIKSgn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Sep 2022 14:36:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C731275C9
        for <linux-nfs@vger.kernel.org>; Sun, 11 Sep 2022 11:36:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28BD0jai028194;
        Sun, 11 Sep 2022 18:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=F0/jPcbQWsT9IMQMKc6AcCNlRlJl6W09D1EfcToZ2q0=;
 b=E4hc58KXs2Uq6HlTemLp0tSoMjFTUd+A2WRvTnIuQ5X5WJfL0HFs7GsyMDLuvMlxpm6Y
 rtCkVAmcv6vkA/GLyr7KodRnYVxdc1t9uRza2p041W4acQdOXVvLqoRbekDNU4WwZL5t
 46iElFMzq42CJNiFRQKE6kAD6g6CPL33WN4G7l3+xEqjNwedj2V3FIeXT1XMvOE5UCdB
 RO2QQHxcywL2nJ9Xu3WrMRE8N+iixgd1MkeLm3/muylb+rVMjiJI5lZr+gdXqLcbZ3v9
 RUKEDL9p/d51XoLBlMMwgH6kD5ZAteIO3nmlAhYcO39A6y3fdQezZuvZ2OjB+7L4tVwz 7Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgh61hyed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Sep 2022 18:36:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28BFktXH036335;
        Sun, 11 Sep 2022 18:36:25 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jgh11ynj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Sep 2022 18:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBk76R6jiU0B4ms3eKBkYh/5ZX5/NV9FnaLzwwbARtVfP+hZvjhidiWOwD/W63ZlCw9KtMfQcF/FU/VbheVt8HAljTWP+sW6doLlbzCkol9PRMOOjXLlM7W0lCJRpZlVoINizSSO4L/6Zw2XVqN8VKa8g0rqEHGg5gO/PJsiLFRB/KBX57ShPKWiOXFk8NJgbILUDei5mZ09dG/ROkVVVlpd2lQA9dEca/EtNj0MmSQcMk5ij/2JSHZu9RU9BvPhohbyp8BNkZzlNm50Mt5wasoVR1bnZzr48ja4EFJwblXQGnF+hYKMOcsFak7XAkGIkk2oNohbBvqf27iego2SmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0/jPcbQWsT9IMQMKc6AcCNlRlJl6W09D1EfcToZ2q0=;
 b=L0IyDTknJsl3AQU3Teb6OvucarWWYafPoSx/f8Q8/KNndhXER0g1Um18a1G3YG8B0fyiMPb5Q8OWi4cgKsdXpgxnKJTMoMGTgWE5BOJ6IX5s+mQEWvw1Xx+RC9oRuiXBDFmMVwG3e7J5VuR9UQgEkgqCa6j/kdlIQxlMDS/bEVHLQbSvs/n3mnBA9RooGLElfoC8ChfcbUz1ZpEIpw8CwZvzUvpkmeAklrfaSDrNC5gIxElAYcIJC78QbdKWUkVKnGRUaXyy7lSQpuvW3+QOMVx2L6LterJ8pZe/KgizCG88+woDyERHVgn5OG3PoyfgXaQUcBDwkW+GxkhebgrzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0/jPcbQWsT9IMQMKc6AcCNlRlJl6W09D1EfcToZ2q0=;
 b=JvlUHTg9KvIxkpNXKaXxTtrBjJipPQ01dM+FK8CEQN1+uqc4sdx3zftR8WFfPfsrMWgVl0yKWuFKgejUNtJIgdqRk6avyGkwZmVrmYKozoKOk4CKHkMzjtnip7UCkqPMZr6L2HfwkHJBT/beSn4+3XXjYKcolNYzS0gdgtE5XrE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4597.namprd10.prod.outlook.com (2603:10b6:510:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Sun, 11 Sep
 2022 18:36:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.022; Sun, 11 Sep 2022
 18:36:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Thread-Topic: Is this nfsd kernel oops known?
Thread-Index: AQHYvJP9R6JamLcYaUyLf/owehh7vq3HuG2AgALiPACAAGl2gIAAWREAgAdmpICAAAw8AIAAo8KAgACEegCABUMMAIABZkAA
Date:   Sun, 11 Sep 2022 18:36:22 +0000
Message-ID: <8B4DBE66-960F-473C-8636-8159B397FFC0@oracle.com>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
 <CAN-5tyHYH7ODzmTK=Maa3NZOSxfcE0mfaWY11+n2htQpya869g@mail.gmail.com>
 <EE9C1D1C-AA5B-48BC-9E3A-8A4523456AEE@oracle.com>
 <25AF9743-A2A2-4AFE-9123-BAD3C8F17655@redhat.com> <Yxz+GhK7nWKcBLcI@ZenIV>
In-Reply-To: <Yxz+GhK7nWKcBLcI@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4597:EE_
x-ms-office365-filtering-correlation-id: 86e568fd-1c22-4ac9-2d35-08da942486c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D+U455hmhO2Q6kdsKhfIB0mGRFL9g14gx3wXoYdohcCk4nXCvAM+RPkf4apc0ANz5OUI3u67Gx1368yMCvl0qXV9QpoTFauvoDc3aEP6wg+CWKNcT/bN/XoXhzM/bPygBaZaVWA/WbmHgGbc8u2l5Gt4rrbkfzcMPSMBRhnHx7M91Sz9gV/phuZQ0F0+si5y9KjcHnkkhIxtPXB2HiCxzId7UHlYV4nmWXwIU3Pxa5v7GX4o/7vc3YMQpuiWJkjvlZbmZNWAMWGpFVhw43ygiKxtGXpQqYPkq0dBLkJiBz1W+FcwzR+VumCWb2jv3/+g/JSYcoihB+yRuUn0mvBsAdFBGPmfTuM8qObXOP4gMN0XNnojuFZl6SmsDBOQWjzMBdFYknVOc4HGoQ6fyt9Iri3zL3OzyD1CyB1riObNr3jn+D5zb4qnV87Nx0zC08feIHP192riYf+voffN4a+eznItajlCf7SGoV0WDkSwTTqMNsVJ6UHFZWLT+i+9kUlCdSC3DSJtONSvp35V5VnhEOieEQt+M9UgEWSmqHU0DMkOi3BqP4aGaHqzOag3hn2spiwJcZKHXyusb3ue8UG87YOUi2kerrXw+SoLD8c77UueBaswy9bFklv1+J3ZugCfVlpxLIQR5cPJmpzyA0PanfsXZT5FMGFu1NZl5QIdZFfxnMKCpOcow90qwk+DexbjCv3p3GtyadxffWhnqWTfPZiuezqF1EJsh9MVDszqbTE25O995SW3Gsdqa/rg5M/qAFpongGSe6q0qkixsxiG1ft/SL3HffTXJo2tgQT6XB0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(396003)(366004)(376002)(76116006)(5660300002)(71200400001)(478600001)(4326008)(26005)(66476007)(66556008)(91956017)(8676002)(64756008)(41300700001)(6506007)(8936002)(66946007)(2616005)(6512007)(186003)(83380400001)(6916009)(53546011)(6486002)(54906003)(2906002)(316002)(38070700005)(66446008)(33656002)(86362001)(122000001)(36756003)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mv8wlsHE2cgmFY9BMSOu1rOZbIF/FPWsWnJLsMdei/rhvd+EUWfIS1B7b5k9?=
 =?us-ascii?Q?PllbR56FotT4lrgzVO0QMTHB3ctRiirga7CXE0Q7YHqbyCJjHcnd7UtokvnN?=
 =?us-ascii?Q?+mzo5hn1vD7dwoaeL44nRjeYlMPWE+5Y8e0bP0drraJ80qM5eoF4woWZhv+f?=
 =?us-ascii?Q?8AUWLvo6il8BVbE5OeJqSLieaU63vBggwUcvY8YSlEcF+JCialUEsVt3EbIo?=
 =?us-ascii?Q?6yfcZvCXSWhhW3yIZATvQiH5p16XfFRpCP84OEaF5cF5WREoEX5Nhyuen1pN?=
 =?us-ascii?Q?XMi2OF5G42seSh9/3yupdkqrutWHTRbXUWesg6xonjmRCyI9w8TEa1YNiBaS?=
 =?us-ascii?Q?U8s1QVq1qXCWRU/HqBL16Lbbtv6HZ/OCB0OdCcwC3ZSX013DiA1t8+emSHGp?=
 =?us-ascii?Q?MMIMHNKWo9xhnjjv5LHq46Nenp9enSPkwNbAtWnWz46Ak6hBZp+b/m24qU5D?=
 =?us-ascii?Q?rfmbnUnigXvMKHTPlXeXFFsjUejXB9WtHny2THHpbBD79joaLC73wf6QrC3P?=
 =?us-ascii?Q?wKMmFyJVXBsg48lt8hF3Olvb3Zy6mKHWLRl5PxI5708wHBQgUAX19mIJNdTx?=
 =?us-ascii?Q?lTLM0+1KfgYegVmURL4vD3IL+14Hy9qypmloczYKe6I8WxKXuaB189OcnbCd?=
 =?us-ascii?Q?CN4knuyU/SVsmSKbdrOlu2UUzi1xPWW6a1TgVbKeyO/qPD8esoNPjsk3TuP1?=
 =?us-ascii?Q?oKbpzZF7n3kisW0EzvypkZDWNMHtRl7v3XmZS8EXbKtheJDtn77H2LSB9D7L?=
 =?us-ascii?Q?zklNWvicPjnZHc2ST0Blsn0k01Gq2eJVfZVCXyY6kUQJ9amM4q9zS7yzPBR1?=
 =?us-ascii?Q?TOwfzo/JPr10tb6vVjTbiXxU3r8cKRW2rs67z4cOyBLi15S6k0bDytPrauIe?=
 =?us-ascii?Q?6WUx/+ClO+yStkKF4Fi0i/OnXCC9NCCDFLSwEG2+bonC25S0qx5ZU9POTLkz?=
 =?us-ascii?Q?eS+HaYVAGjJwWhAntWBqkxG3iA2FT/BEETeEW4HNMBaGXRJUtqvyTbDfsi+B?=
 =?us-ascii?Q?mzUadLeHnEEfowyfQLLHG5Ob+v694cxYtkSIgmeK7lNsk7J8Owm0jfEZhRw7?=
 =?us-ascii?Q?w+M1rm5hfiYKdGEzJJ+M31dmM6rD15mqrPVfqOrLs5+GcZJbnGactpr07rj9?=
 =?us-ascii?Q?YovLhx0/gnSauGDc+s+tnt2q4s/sZjJbuWmepO5bLVyQOe6vx7zTgxuoIXpL?=
 =?us-ascii?Q?QWOsMzgwm6qKTJT8/PbxDckE2/pi2qEfOFW1ompQOpuJG6+fMLIR1Bx/Lzsu?=
 =?us-ascii?Q?4ISx4pGpljop6cNUrfg/loaSUYQwZTStJLqnP2dLyJQPsyfwglUkB5NaMA4G?=
 =?us-ascii?Q?SVrisek9YbOlum/38Oyg1zWMmObHMzo4GqgPY1bwmgloCY9jx+beiwBm+yrJ?=
 =?us-ascii?Q?Uj81bxL/doNvtXcgloMaFRS1FoAKYzALuyKw0S1HczRSkU7KtG6o3oZmm8/B?=
 =?us-ascii?Q?vGYqDajg3CaK1ZBnzHr5SmOKSUl8vmT0Vo1C1XIAeHIBiN2GNVxyX5hyK+pN?=
 =?us-ascii?Q?60ztDv4rovkbUcvwkjoQeh5jqOtdJ8GhuqjpyJyoYpBOeXLpSJ5G9WOcWyyy?=
 =?us-ascii?Q?sPooB5O1k8heztWys0pjb+vPqqx28LRTYaRpRFAhtUqaN6USbyrWLyD+RdTQ?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9B5C9566E07DC348860262BF13312BAA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e568fd-1c22-4ac9-2d35-08da942486c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2022 18:36:22.6640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZPuy1SDYqdD934Py4+6aBELL7Qavg3M4tBp+i22JHZxm58gdypt6l6DwBzP5sAtIfuqU3tc9llqHngXK48PGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-11_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209110071
X-Proofpoint-ORIG-GUID: mnXzXCx8FMpTZhYrcdd5_qI_Rx3T0yyN
X-Proofpoint-GUID: mnXzXCx8FMpTZhYrcdd5_qI_Rx3T0yyN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 10, 2022, at 5:14 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> On Wed, Sep 07, 2022 at 08:52:46AM -0400, Benjamin Coddington wrote:
>> On 7 Sep 2022, at 0:58, Chuck Lever III wrote:
>>=20
>>>> On Sep 6, 2022, at 3:12 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>=20
>>>> On Tue, Sep 6, 2022 at 2:28 PM Benjamin Coddington
>>>> <bcodding@redhat.com> wrote:
>>>>>=20
>>>>> On 1 Sep 2022, at 21:27, Olga Kornievskaia wrote:
>>>>>=20
>>>>>> Thanks Chuck. I first, based on a hunch, narrowed down that it's
>>>>>> coming from Al Viro's merge commit. Then I git bisected his
>>>>>> 32patches
>>>>>> to the following commit f0f6b614f83dbae99d283b7b12ab5dd2e04df979
>>>>>=20
>>>>> No crash for me after reverting
>>>>> f0f6b614f83dbae99d283b7b12ab5dd2e04df979.
>>>>=20
>>>> I second that. No crash after a revert here.
>>>=20
>>> I bisected the new xfstests failures to the same commit:
>>>=20
>>> f0f6b614f83dbae99d283b7b12ab5dd2e04df979 is the first bad commit
>>> commit f0f6b614f83dbae99d283b7b12ab5dd2e04df979
>>> Author: Al Viro <viro@zeniv.linux.org.uk>
>>> Date:   Thu Jun 23 17:21:37 2022 -0400
>>>=20
>>>    copy_page_to_iter(): don't split high-order page in case of
>>> ITER_PIPE
>>>=20
>>>    ... just shove it into one pipe_buffer.
>>>=20
>>>    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>>>=20
>>> lib/iov_iter.c | 21 ++++++---------------
>>> 1 file changed, 6 insertions(+), 15 deletions(-)
>>>=20
>>=20
>> I've been reliably reproducing this on generic/551 on xfs.  In the case
>> where it crashes, rqstp->rq_res.page_base is positive multiple of PAGE_S=
IZE
>> after getting set in nfsd_splice_actor(), and that with page_len overrun=
s
>> the 256 pages we have.
>>=20
>> With f0f6b614f83d reverted, rqstp->rq_res.page_base is always zero.
>>=20
>> After 47b7fcae419dc and f0f6b614f83d, buf->offset in nfsd_splice_actor c=
an
>> be a positive multiple of PAGE_SIZE, whereas before it was always just t=
he
>> offset into the page.
>>=20
>> Something like this might fix it up:
>>=20
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 9f486b788ed0..d62963f36f03 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -849,7 +849,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, stru=
ct
>> pipe_buffer *buf,
>>=20
>>        svc_rqst_replace_page(rqstp, buf->page);
>>        if (rqstp->rq_res.page_len =3D=3D 0)
>> -               rqstp->rq_res.page_base =3D buf->offset;
>> +               rqstp->rq_res.page_base =3D buf->offset % PAGE_SIZE;
>>        rqstp->rq_res.page_len +=3D sd->len;
>>        return sd->len;
>> }
>>=20
>> .. but we should check with Al about whether this needs to be fixed over=
 in
>> copy_page_to_iter_pipe(),  since I don't think pipe_buffer offset should=
 be
>> greater than PAGE_SIZE.
>>=20
>> Al, any thoughts?
>=20
> pipe_buffer offsets in general can be greater than PAGE_SIZE.  What's mor=
e,
> buffer *size* can be greater than PAGE_SIZE - it really can contain more
> than PAGE_SIZE worth of data.  In that case the page is a compound one, o=
f
> course.
>=20
> Regression is the combination of "splice from regular file to pipe hadn't
> produced that earlier, now it does" and "nfsd never needed to handle that=
".
>=20
> I don't believe that fix is correct.  *IF* you can't deal with compound
> page in sunrpc, you need a loop going by subpages in nfsd_splice_actor(),
> similar to one that used to be in copy_page_to_iter().  Could you try
> the following:
>=20
> nfsd_splice_actor(): handle compound pages
>=20
> pipe_buffer might refer to a compound page (and contain more than a PAGE_=
SIZE
> worth of data).  Theoretically it had been possible since way back, but
> nfsd_splice_actor() hadn't run into that until copy_page_to_iter() change=
.
> Fortunately, the only thing that changes for compound pages is that we
> need to stuff each relevant subpage in and convert the offset into offset
> in the first subpage.
>=20
> Hopefully-fixes: f0f6b614f83d "copy_page_to_iter(): don't split high-orde=
r page in case of ITER_PIPE"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

I'm getting my head around this, just a couple of comments so far.


> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 9f486b788ed0..b16aed158ba6 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -846,10 +846,14 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, str=
uct pipe_buffer *buf,
> 		  struct splice_desc *sd)
> {
> 	struct svc_rqst *rqstp =3D sd->u.data;
> -
> -	svc_rqst_replace_page(rqstp, buf->page);
> -	if (rqstp->rq_res.page_len =3D=3D 0)
> -		rqstp->rq_res.page_base =3D buf->offset;
> +	struct page *page =3D buf->page;	// may be a compound one
> +	unsigned offset =3D buf->offset;
> +
> +	page +=3D offset / PAGE_SIZE;

Nit: I see "offset / PAGE_SIZE" is used in the iter code base,
but in the NFS stack, we prefer "offset >> PAGE_SIZE" and
"offset & ~PAGE_MASK" (below).


> +	for (int i =3D sd->len; i > 0; i -=3D PAGE_SIZE)
> +		svc_rqst_replace_page(rqstp, page++);
> +	if (rqstp->rq_res.page_len =3D=3D 0)	// first call
> +		rqstp->rq_res.page_base =3D offset % PAGE_SIZE;
> 	rqstp->rq_res.page_len +=3D sd->len;
> 	return sd->len;
> }

I could take this through the nfsd for-rc tree, but that's based
on 5.19-rc7 so it doesn't have f0f6b614f83d. I don't think will
break functionality, but I'm wondering if it would be better for
you to take this through your tree to improve bisect-ability.

If you agree and Ben reports a Tested-by:, then here's my

  Acked-by: Chuck Lever <chuck.lever@oracle.com>


It might be nice one day to have a single mechanism for NFSD
to handle READs. I don't think a pipe is going to work for our
upcoming hole-detection scheme, for example.


--
Chuck Lever



