Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7DF4C383D
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 22:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiBXVyc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 16:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiBXVya (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 16:54:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C4B20E593
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 13:54:00 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OKTfWI002527;
        Thu, 24 Feb 2022 21:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MfY69cqqEmzmy0k5m+MlQV9fTtBa8YE6tgmcjIZQYbM=;
 b=0ZrQPUJxwRbM5y0z3oxX0sAZvWPG8XQ8yAgqSZEmlbwdKOWFLLFl2YQumpYXhIJtitmN
 D9E3vRQ95t0udtuEOR152oBRXYa7+eW58KzimsD6YcUv37bM/X6G3tONLENEu0NSWiP+
 Nw2ygOu5e+6v57lcZ4Alg30sjhwYGpBb+bvMza25tBhyDfRy8zrf6mQhTZNEG0scemFn
 rUXbSWAtx27QgZ99I7M6ikzkZuyv34EpsuN4OmcCtIxrA8SRZT9C/5OJX4pwx5DJjBek
 Z+HzpXHkeTB0DVx1Lbe81RE+xJm5FDrWFtCYSEaz+19VvmTXUSqhwD5KjmmE+mR+FUYG oQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect3crfhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 21:53:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OLf3iJ053419;
        Thu, 24 Feb 2022 21:53:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3020.oracle.com with ESMTP id 3eat0rbhas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 21:53:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3R38Mmun+6nxpHu7mkGrNpq2hbjHm8U6HSR2nYOeoHyaAyI2DvGr1a2/GIQFu0q4b+qGnBNquzi31oPz31pzxG5w9FX1N2lerf68DKW0ko61+wrwg73w9cv2IEgnq1venOJtPkEUHAnsJsDwluivuN6mtG9kPHCo/53wFwRf+8Hpj7gJEeU2pqoOHItu0LS/q8V6W9DoXTJ/qY+tGhBVEd7SUfni61PkfiN7MN8+zCMroFqNicgi4ZJ/zukDL09JXNn5yaV4mow81boRg46R/c5sQbjt1jCAHobyp013CcrisjbyTeZTMVo6pFIa8ifpQ5F1H3Z66WsVXv97Gzwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfY69cqqEmzmy0k5m+MlQV9fTtBa8YE6tgmcjIZQYbM=;
 b=CAqw0d6gmNb8zaWCWpikhlyIXm/u9Y+8o69GVbs7PUcJ3/CpX8P9lyQc5W8YTS7XXRIltUhwbqtIE/7zZ1HjxZ54MVNgHdq44BIvemiGJgZZbwNkmepKu9eejNtd+PnO0TvqIOhbMpuCVDkeZ8KqVA+QnfiUdr9NeMXTbtdNeXNsfwrGYH+dx1nw1XjkEeFesupDqAZK3l7l01maZR+GjbOLrmpbf0SFJ4/MtSzaSaeW4w1tzCxczSkuexickSqXaSvgw7AAi9yYqyI6d5S3bmK+57Cw3oYjDwQleLzJqVXBCQ/nPUQJWCRWjoFL4SSqaf25CWvHJemIp/bX9oDYoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfY69cqqEmzmy0k5m+MlQV9fTtBa8YE6tgmcjIZQYbM=;
 b=ABsi5X5ONGgSoDiWg5qvKEp/j3G7+qm8tAQcAXUcyhg0WtND9+ctd69wMCrRIM0ygXB1rM2exkM2OLvS/LqY2lEMDlbmTzuj3Vx9KT/Da/E+GG0K7e7A/Ma9V06c+Vose1OcP6+nn8t6Zn+D83zKcSVzMD2Q0lQcyY85We9VwdQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2960.namprd10.prod.outlook.com (2603:10b6:805:d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 21:53:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 21:53:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] NFSv4.1 provide mount option to toggle trunking
 discovery
Thread-Topic: [PATCH v1] NFSv4.1 provide mount option to toggle trunking
 discovery
Thread-Index: AQHYKNyvQiH+fo5gFUC0apKHyPss06yi1UiAgAAojACAAAa3AIAAM8gAgAAH9YA=
Date:   Thu, 24 Feb 2022 21:53:49 +0000
Message-ID: <8A1E6FE8-AD07-40B4-8765-3FFF75B465DC@oracle.com>
References: <20220223174041.77887-1-olga.kornievskaia@gmail.com>
 <77E34F86-FC2E-4CBF-AFCA-272BAA7C4040@oracle.com>
 <CAN-5tyEWWbxCtWQPaMhYdP3OW-XKbCANZKx4mk9Fz=cwbQBU6g@mail.gmail.com>
 <BA1B54FF-FAD5-40FB-80CF-65424535C5F6@oracle.com>
 <CAN-5tyEkT_LNPoPErW5OFU8oRoBm=E2czC-bLysqw4R26UsT8A@mail.gmail.com>
In-Reply-To: <CAN-5tyEkT_LNPoPErW5OFU8oRoBm=E2czC-bLysqw4R26UsT8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a991a538-7707-4bc0-4afa-08d9f7e023e3
x-ms-traffictypediagnostic: SN6PR10MB2960:EE_
x-microsoft-antispam-prvs: <SN6PR10MB296032D8CE2125363C9E660A933D9@SN6PR10MB2960.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BIQxvLuOGZe7wutt7Jyzw0x+UnpNYCKRCib71MJcODmeuJ03zc+PAZH7/qv4o4uCoikpS88I/zH0DYuRypEuAieWR6E68k8Zel3mgzxFUxX95tao7v4/hXlDEToOiFzajViJ0CADgmJhejKQSgdgUg6g63PTWh34P7gEW/JYt3zu2HJV6FNrqrq0yMmmkdLpoaOBcQeCVEyGH5Qr/QVlv4Wk911rt4y2yLVePWY0UBbrwgTDN9QrFr5+u+40NExduQp74h3jiPrRmJJQ7wNQ8vHn2GxSDXUPxsjzAP+WBXoRRwj+0ijLQvNlssdpzwH6348T7+ML3AQevz1zQB5h5Z1b5+qekeNPV0a6oxSizrjQUTC1URdXO/mvjJVYqipEnhy28K/4zM2JgGRC9p86hU4ShoEAcG4iY1GmwyZNWe5pAWFzz8gg87d/56OWZQVSl8Gy+yRBBy7/MTqvUnjIQBwLRh4anx9x/MifDFS58byjn51YzQma1jE4GoEr/MNup31xaDXpLLZ+xz9Gr9elK30XoBq8MVFMj9lgPp4uL+K+Hhlb5GUPiu+z7Ay8uc7rNc2rycbFfZXBIY7KsbZCBewEd5PEsN0TA48MUYMhOndWONfgT2awl7wEz9tm6mnSM+ljjCx0whmqzsFxPlnGEgGZhHLPDrRBZfQfNnB8XbanF3hl/MVzdU/wEMWNGi09fIn8LgO8M97Jv1JfQcfdM1iutm+pZdpCMagcYJOhmEE9FF2JAq7oVi3jnCwSTQMd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6916009)(91956017)(33656002)(4326008)(6512007)(53546011)(6486002)(508600001)(316002)(54906003)(26005)(186003)(6506007)(83380400001)(36756003)(2616005)(122000001)(86362001)(5660300002)(8936002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(71200400001)(8676002)(38070700005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5XWKW1099m3ldO/FEJNht7atyJ8cVA9S7ylsxhtQ5hJuKVqm/OYaH+yoqQHM?=
 =?us-ascii?Q?ydFDUUEYBib0s48oxvZNN9H5j+QBD9wanhYzT0cGW4gylkHYuZjXjM2yE/r3?=
 =?us-ascii?Q?5k3BFUeWzrz1izFn+MWjkT2/et5zEsS72bZL2tcb/ZqrZDtOQ6xVMyoSUZcn?=
 =?us-ascii?Q?+JsjrUwoCvlRxU0aZtQeDs/F7Z8CAfWscEOlysx1Ckh8AUSwUcdcVA6JQ4lK?=
 =?us-ascii?Q?hHavymyb1RZr9oas9tg7WYJhwcWbqznw44441EB7W29i+MGQRu99Vbigg+2t?=
 =?us-ascii?Q?L7uoRbjeHnCzRp1F7IpqPkILYDSl3ep3Pwvgnz0eqvLcLuWsw0iSMt582NHU?=
 =?us-ascii?Q?3/MdagX4HVB+BTl/eYt6UxhbTg0BUrW4K4AUqafFMRXv9DE5A80iO/ktfa/I?=
 =?us-ascii?Q?YCnO1UwzgKPWaJMxnf54N63dIvHPm0Cb4wOhqAc2UIJxPtEUoG3sC67nxFdc?=
 =?us-ascii?Q?SxZeDJrQWeO0BSns2mr+tcacv/uA2u1N6ncMJp5njeDVCkmNeuDw/RyfPMNE?=
 =?us-ascii?Q?JGkD3a2CD6SjzXcUWmHbbxEJtEPvb3JXMK8+CxwlqYG3Ac7GpV8yZ33q/Fkv?=
 =?us-ascii?Q?HHsl0LrNQ4Edi+DlyXLTOgIh6gduY+9zjOxfwRdcwkXJaKEr9t+woxTnBUFb?=
 =?us-ascii?Q?TGMqjVqj1Es2QnVpUeYT3V7dwu1YhQtJirpY4z4CrqP4QQff5LCmOnFfCFHL?=
 =?us-ascii?Q?lq3jmB7JD/UZ1Q8OylY2VxzkiW5ZrygoSoAi07Ec3+Hte50tAKxd3djYN/73?=
 =?us-ascii?Q?+U25Cs5C5N1tK4agm1yfPgtafmLnFBzOddLXtrCYAiEkq64cyd9kHb0EKfe1?=
 =?us-ascii?Q?tWFmSQjh9zY4mECqePawH8qeXh8VRWbazJfO0CI9e4xeFRkCNVkOOsyuchdW?=
 =?us-ascii?Q?BumWVSxbaoo1VJ0ckXTIICV8po8T2g2oT3ODOyXztN12Js786A2Ic/Up7SFJ?=
 =?us-ascii?Q?Op8tn1SSAMiTVBtthm6Uy1D3Jsx8bszalHCLNrOlnVXGK1Now6I7lyKCTigp?=
 =?us-ascii?Q?czJDzwDG4LkXQpS9hDjZ9WHl3De95LFCDO+HmYcthm9ZGtayCTl8kq9coQAn?=
 =?us-ascii?Q?s+QLsxjPBrqC2Rm6bS93UejA4FcUdJdjCfgfu9kpzopLf22EsKbU9dCrflUt?=
 =?us-ascii?Q?wmbnCrBiznPxiLkEPJLez5iiFZK68qDcKLXzXSYW735mk48nWO8VhxVmc+cY?=
 =?us-ascii?Q?tt3dB0ySMVd7sEXtBwb8RhjFPxc060E3RxzvlkZ8GE9txb7HhO3z6G8WmKIL?=
 =?us-ascii?Q?uFhhQ/MsIw7iHG+O2Ejr+I7Y79M5hvFGxu8rvCfQeURjII/ReSvJup0T5NyH?=
 =?us-ascii?Q?y4ZCRfno3xj2wzvU1lGJVbJMA7lB4zlzljIdRAmVDce11T6yEm6sD2BC5u/E?=
 =?us-ascii?Q?0zW8jB9Q7LnMWK00I5jKwIEhJJmK5Vb3csLu/gQz+hqd6kqqBoEAtsxhlyCy?=
 =?us-ascii?Q?tRkC5lxDynO9a4Ut3p1o/qRo1o9BT0XvAnfmQBm4e3I4ybDNQXy6haotB7Qa?=
 =?us-ascii?Q?Ro5xabPJ6cmRantw5GN1w2lLgaWQcVRplSo8OoQh+5UQcOvdJg3GKMSt4+j6?=
 =?us-ascii?Q?sA9J7aioktPr1orZ1lHx8NlQI0ciaWfg2Wo6ubLtOxNnllwd15do09+awbmB?=
 =?us-ascii?Q?tAiaS0C+wnLQRj2266DuGCM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4E4B5FC92EEF24FB8FFACD4103DE665@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a991a538-7707-4bc0-4afa-08d9f7e023e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 21:53:49.5531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/V3gVK8g/AGvgWgcDojx1wElZTzDSevbGQLg8FIJ3z121pR9z4GUJTdw9AsL4zxxUYgyrO6PeJu/VLZy0/QeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2960
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240120
X-Proofpoint-ORIG-GUID: 4ydLV1zWNLHsUhGbSWblEuHK__gXS7Rg
X-Proofpoint-GUID: 4ydLV1zWNLHsUhGbSWblEuHK__gXS7Rg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 24, 2022, at 4:25 PM, Olga Kornievskaia <olga.kornievskaia@gmail.c=
om> wrote:
>=20
> On Thu, Feb 24, 2022 at 1:20 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>> On Feb 24, 2022, at 12:55 PM, Olga Kornievskaia <olga.kornievskaia@gmai=
l.com> wrote:
>>>=20
>>> On Thu, Feb 24, 2022 at 10:30 AM Chuck Lever III <chuck.lever@oracle.co=
m> wrote:
>>>>=20
>>>>> On Feb 23, 2022, at 12:40 PM, Olga Kornievskaia <olga.kornievskaia@gm=
ail.com> wrote:
>>>>>=20
>>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>>=20
>>>>> Introduce a new mount option -- trunkdiscovery,notrunkdiscovery -- to
>>>>> toggle whether or not the client will engage in actively discovery
>>>>> of trunking locations.
>>>>=20
>>>> An alternative solution might be to change the client's
>>>> probe to treat NFS4ERR_DELAY as "no trunking information
>>>> available" and then allow operation to proceed on the
>>>> known good transport.
>>>=20
>>> I'm not sure what you mean about "the known good transport".
>>=20
>> The transport on which the client sent the
>> GETATTR(fs_locations).
>>=20
>> The NFS4ERR_DELAY response means the server has no other
>> trunks available "at this time."
>=20
> But GETATTR(fs_locations) isn't only used for trunking query, it's
> used for filesystem location (migration) as well. Are we redefining
> what ERR_DELAY means in the context of trunking vs migration?

I don't think I'm redefining what is described in RFC 8881
Section 15.1.1.3. The meaning of that status code is still
the same; it's the client's recovery action that can be
made to be different.

During migration, NFS4ERR_DELAY holds off the client until
open and lock state has been transitioned to the destination
server. In that case DELAY has to serialize further operations
from the client, and waiting and retrying is the correct
response.

I mean, the client won't know the hostname of the destination
until the GETATTR(fs_locations) returns a successful result.

For trunking discovery, DELAY still means roughly -EAGAIN.
But it's up to the caller whether and when to try the
operation again. I'm suggesting that in the context of
trunking discovery, there's no need to halt progress
until trunking discovery succeeds. The discovery probe
can be dropped or retried in the background.


>>> I do object to treating a single ERR_DELAY during discovery as a
>>> permanent error as there are legitimate reasons to a delay in looking
>>> up the information that can be resolved in time by the server.
>>> However, I don't object to putting a time limit or number of tries on
>>> ERR_DELAY as safety wheels.
>>=20
>> In the past, some have objected to /any/ delay added to
>> the NFS mount process.
>=20
> I again would like to note that fs_locations is a file system
> attribute thus I would argue has to be treated as other file system
> attributes.

True, fs_locations, as it was originally defined, is a
per-filesystem attribute.

But I don't see how that is relevant to this issue. The
client doesn't have to wait for trunking information to
start its operation using the main transport.


>>> Lastly, I think perhaps we can do both have a mount option to toggle
>>> discovery as well as safeguard the discovery from broken servers?
>>=20
>> I'd really rather not add a mount option for this
>> purpose unless you know of another reason why trunking
>> discovery needs to be disabled.
>=20
> I don't offhand. I thought it is the simplest and most appropriate
> solution and perhaps inline with "migration/nomigration" option but I
> must be mistaken there.

The "migration" option was a last resort. There were
really no other options to deal with servers that depend
on non-uniform client IDs.

There is an argument to be made that we shouldn't have
added that mount option because it controls the behavior
of all the mounts on that client.

IMO you shouldn't use "migration" as any kind of
precedent.


--
Chuck Lever



