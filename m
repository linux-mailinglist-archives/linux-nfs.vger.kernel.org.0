Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD7B410DB7
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Sep 2021 01:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhISXFL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Sep 2021 19:05:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45376 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229778AbhISXFK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Sep 2021 19:05:10 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18JJxNCD028218;
        Sun, 19 Sep 2021 23:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Xuzi0vGwVh0vZCm6KNmGj98d3b9EC8rv/CqRI7O7OSY=;
 b=A17ZZXJ5B/8annHc4+X9elnWl5dB0CzvztpOrswqDbXTzZiMO+V5vD3I3pw5ZeIZprtF
 PdI36IXYEXVFXwd0PQ462zOwmNodC7smVoHwskfkt3hYR1YIYz4wziLMiBUTbW3DMUxS
 fhdoam+dwLIr3+2cGH4wYaehDmbl0ZEHGLgWasv1aV2A4M12/MDiD4rdQAjJyjL+79/B
 Dz4lGK0gJvcdfOUTwz1Fx8h/pGcdPK0mVfX8ZSkjNn5C4nN0S63ixv4HBYiWf8ZX/EMI
 EmfgyzUHUrwg0NanKeuAduUEkf3TRkNzlt2fyNnIATUAlcu9uXp6SSHRqW8YuIWasygk tw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Xuzi0vGwVh0vZCm6KNmGj98d3b9EC8rv/CqRI7O7OSY=;
 b=v2VcCzxnAlo+mm6Tya/d8+gk+DpRCDQUHCNFhDzNM79tsTAAGfiUBGPKVtW7hJlFCmwH
 +ZkKz0J3+gi6q7ARXHDf0aeMVMR1B74kv9oObte3fpRJNVpj8jkjV+DkKTiXW9H5h6ek
 oAbo7PzvvAr2pDWTd3y1YC3kfD514uUCUeXs7KjsLmxMrWrqDj9A6QzYKgo2B7tMQruR
 rWYvenZkme+NFkz5hbmDGJ8mydZPM3LfugqgbSej/hnG5TVTpBKesyjAuy7JVkZsYZmm
 Z+ZjKhwDt3Hjs+QqioZHqMzoViAPjTUG3ddg7QLP12P+pljL8cFuDi5kqexz4quSfyNo 5Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b66wn0er5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Sep 2021 23:03:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18JMxtAI043719;
        Sun, 19 Sep 2021 23:03:41 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by userp3020.oracle.com with ESMTP id 3b5svq00hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Sep 2021 23:03:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4spR6i28Dt0HTXxwKKvmPlkR4o9zLn14t9H+7T9uK+8XTbNvO88oEVDYdOBrN07zGI9Dfg43joBLWPReJFjpciu6Fp7O5KHCMyHCFfNy8i466caOrS3zycni2lQtffVS6C2sUTU4bacdaHHGocRfk2c+bR2ZJ7fYq7A0IorbEdvC6C8ZBj8npOENWegkfRsbnU1uLAu4q85fiKiAaeqZX+Bcwcq+6bPmQEXuAZbUWCXI0N76fzHIt8HICg3T+FT1ZVbrJPjebCn1eElDscSIpqeA+V61cCFhrMg0lnqpJmyNN3InNTV1ucbrb7nuxXJrQ80W2i2PBgZjhfBi6nL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Xuzi0vGwVh0vZCm6KNmGj98d3b9EC8rv/CqRI7O7OSY=;
 b=MmtjLyNs76UjztInyrwUSnXdTQ3mSeD7KBIsQ5W7MSQolJ2k8Z89H6gY8r2qgqC5/KUFIV/MwLn+Vg8Ub1yW9TUQJIYMvlcxuGu5RLFPHMdAtpU6sRAm9ee+05OI46lZSOo/oNgGd1WK6H2AOSwaF5hvldQC37208lJhY3UUQ1N+LQrdFD5c5BJeeAkcpAQ8pbpBWD3u6g4iRQ4Ldwc6fxD+keE6ZiqcuAnvxPojEGTl+u9X9fWXziQXHPWEwIOFKdtFUuki/wlwpsoEN0fEHVHf5plUJ02FcMxbSVmR9DaeMOHUJFRY2VfTV63hzKJm+vUsao9HZ/JaBb36JP1kuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xuzi0vGwVh0vZCm6KNmGj98d3b9EC8rv/CqRI7O7OSY=;
 b=uvEMeEsIvx4HnF7BmtCOE+iK1mMzz8PdgdRc3nb5qXh7F8J21M38r1KTFCpFbE/gargV3O/rQNw59i1Nuwft2LgpyHmJoPKyDPjXyMrsfJWjWlBq8z17GFBKvp1vxKoACPDc440twcfmUkZ7pXxMrL/huJF7Z5Xal0fvuqQ4GJ0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4655.namprd10.prod.outlook.com (2603:10b6:a03:2df::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sun, 19 Sep
 2021 23:03:39 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4523.018; Sun, 19 Sep 2021
 23:03:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: recent intermittent fsx-related failures
Thread-Topic: recent intermittent fsx-related failures
Thread-Index: AQHXf/8fslPfHYBEJkGXNGWvoY4o9atRAYKAgFtTqAA=
Date:   Sun, 19 Sep 2021 23:03:38 +0000
Message-ID: <680A4FB2-B90D-47E1-A390-36B3081B1464@oracle.com>
References: <67E1CF9F-61C5-4BB9-97FE-61B598EFC382@oracle.com>
 <2e8bce7bc15b02bbd1dcf740f2d993d6e3d58367.camel@hammerspace.com>
In-Reply-To: <2e8bce7bc15b02bbd1dcf740f2d993d6e3d58367.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7024fab-ba51-4389-a5ee-08d97bc1b7a2
x-ms-traffictypediagnostic: SJ0PR10MB4655:
x-microsoft-antispam-prvs: <SJ0PR10MB4655C17A52FF151890DEC83893DF9@SJ0PR10MB4655.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LxF4yYC9bdBqeo309Vw1e3Aqu7ZKsQnrReQaJaIMHmhOxrncZ7MUB/8NAvqImGOyO4fDBVqhmxCL0ph3RO0go3uKD1SGAvydX0zKRQVg6ggr0GqtwRiclLHNyhE0+4rYkVpbvDxlhsCgNB5qE8dj9XgsicGxPkHgMRjT/kRLG8kQPrX8/vwjMBWLV5oCQIaox8eTnfHSdIROVkRG6IRgoKx+e58LOTaSoW20NjNYdV/bzxxiT2aqRs+4XrZaL0F+BtTl+0BOiDoDYwQs9rXrvvae/Zn8iHFxOlsAwS4svj9dWS5Tgce4k6V1DS1Qfkwa7dE8Eiuoj9hqI7FTR4169wPH2gBhF+EBBLv8+9t74iN33SWeFb1PBU6AimNGt4iuaYCwJuf2sntEUgLjzBmojzY/MPfDBD0ho24+Xmu84FcuYjxos1kDIFaGavseNA7amY9wbGaBwxqwhzVBkLw2u7QXMt5dsk6c4HPdT5127LmeYrYW7vFX4/8Th5vTVM9Ks72JrPWRaFjVPiebkGJcmXa97s94UoMH4xOeKOeZZnvL1Vbs1V70Txd3tRWjUZBOfyhr2DgFxnOHu5dVlC+v8DMhL0UEBfNVLHUBbnigK7AozcRAo6Q8JRPY2jRN5oV59e/jZoiC/XlKwEb3C0ldpkySQ/MtxTDjawQkrRcUiLWqqmw0GH/r4hUrGpJKQSPhbVP2xi1i8vfRRSW9Uuul5Eyhs6DbWxd1POHpC6k1QmUKT3CVOhZ9Qf76C+fmmRoC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(71200400001)(8676002)(3480700007)(186003)(6506007)(8936002)(33656002)(26005)(38100700002)(36756003)(53546011)(91956017)(66446008)(2616005)(4326008)(66556008)(76116006)(6486002)(6916009)(2906002)(5660300002)(66946007)(64756008)(66476007)(83380400001)(6512007)(508600001)(316002)(86362001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?32bUGT7+tzChJ4lgIFq6uch7ozTdmh5SJuc4o6jQ002AaOGfL8/2KTbOafT0?=
 =?us-ascii?Q?pFFhjO6BoaE0T57Ll/HGClmKrix5MGXrvxOy6Mrz1Jzb/Qly0832rU5hyXqn?=
 =?us-ascii?Q?Uo6S7jNI9VnuMEcI0RIIt6ay+3AgF/61KmK+2pw7qXKy6kwak0p2cU2l+s7T?=
 =?us-ascii?Q?f6CAJnL99oHE7rzqtx8E48MykMMcx2Co2Q8VoGTM5pgRzRao/qO3K4Tf6i1O?=
 =?us-ascii?Q?OKVuQKH2tDla54MummWqwhnHsSV6cfOMSVu/lAEav/lAytzsYZFQUE3LZ4Dv?=
 =?us-ascii?Q?uJiCtRC6mEJ3aHzGbAYIizMYqSfmqeNUAMQ2Vx0haU0jbdaubq2evYKfhOub?=
 =?us-ascii?Q?B+yE3G4DQLcM71qq0nlNQ47Mtkj3UU/A6Rzt9VKRITUguHRKg92oi/NfRkC5?=
 =?us-ascii?Q?vL8QKFWeUakDfucEbrXaqdsnaJBF7JMb58ehxGIxzLQfGQvbbbE9u5zRthfa?=
 =?us-ascii?Q?Zj5JrqSDYEK9QRCU7jaE8ETTMzRp0rdN1FVs2CxP3Es8RSiqR4kjieJWAE3H?=
 =?us-ascii?Q?8zOQNNChIUrAYUjFEnIzRrE87UUUenlEjw/JFoNtTNgoAyPvg+XHV0AsPhHp?=
 =?us-ascii?Q?W9sIylMsD1lcBVEDqyCeo0xstc2v0RWmNhwsS2upDtEVE0EdPP3W7Silgmua?=
 =?us-ascii?Q?XEhl9JfoykzyYSzRCMQV7o7VQWiUXRE6ew105CAOhDicGJT430ziTOTNmFN4?=
 =?us-ascii?Q?Ns8ZfAsF26PdAmff92qTMe1041ws/MIV9Qem+eQa9eeBr4w5Dw/VrXXoPxpO?=
 =?us-ascii?Q?DFzfSjPkZEZapjjtcdSLqtzbaqTXTJoA9ksIGIlMA45vcl0VVfjvlOrHvzdH?=
 =?us-ascii?Q?aYxKtZBNXykwQTs5qETVy+RgQsk840jf2enNmZKbcS2hnRRKO8etHqTGEvb6?=
 =?us-ascii?Q?l+YhnEnq/K9tlyk3/6Y/ZO7lAZLEpT7PnOdGkjrSvpfqMtt/WjrszlUhNcFD?=
 =?us-ascii?Q?7TwjcVhV4fYTccxUxjmnGPGq6TZhRr4+h50APPWsoTLJw2XWmwr01h2f0kY2?=
 =?us-ascii?Q?mVomTQhkhMMiw6VQeFNHKb4crYK+0fBa0KEsJSgQZ4V+06TuESL49sDp0ZpP?=
 =?us-ascii?Q?tSz9aOKkjVjfZ2qzYz/0ZT6y2KKFaei4P82tC4PoPxcWVhQweujXsAYU/6sq?=
 =?us-ascii?Q?wwdcp0EVY3h+GxDWMrxGJ/xAhauuQd+GfIm4rR43aeFMaI4/Qex7vfcg8cyY?=
 =?us-ascii?Q?OI2P8eWiluMJpfdvANYAsbikyTq/3h7EQC3L6QP8r3roXmwDkKjpclo0akvr?=
 =?us-ascii?Q?q3hjlfdYmydkeedhccIFDh/i/U298MVCq05pkSAQt/vLatVSH1XiXOquoSyz?=
 =?us-ascii?Q?PtVJOi6b5XrBFf8KIrDlaCcg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DFD517F75683A2438BEA9046EF770B8E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7024fab-ba51-4389-a5ee-08d97bc1b7a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2021 23:03:38.8733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfO4aYadvpIWq5xDM3LSqiSawVSsTLiHWgM9mp7ctMt1M4H/NYB/XHJmg2g/mwr8z/GWyzHS5vTfH3BO1ejaYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4655
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10112 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109190171
X-Proofpoint-GUID: PAgpqhAOoU2a-vqiruu5FVhL6YQhb2mI
X-Proofpoint-ORIG-GUID: PAgpqhAOoU2a-vqiruu5FVhL6YQhb2mI
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 23, 2021, at 4:24 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Fri, 2021-07-23 at 20:12 +0000, Chuck Lever III wrote:
>> Hi-
>>=20
>> I noticed recently that generic/075, generic/112, and generic/127
>> were
>> failing intermittently on NFSv3 mounts. All three of these tests are
>> based on fsx.
>>=20
>> "git bisect" landed on this commit:
>>=20
>> 7b24dacf0840 ("NFS: Another inode revalidation improvement")
>>=20
>> After reverting 7b24dacf0840 on v5.14-rc1, I can no longer reproduce
>> the test failures.
>>=20
>>=20
>=20
> So you are seeing file metadata updates that end up not changing the
> ctime?

As far as I can tell, a WRITE and two SETATTRs are happening in
sequence to the same file during the same jiffy. The WRITE does
not report pre/post attributes, but the SETATTRs do. The reported
pre- and post- mtime and ctime are all the same value for both
SETATTRs, I believe due to timestamp_truncate().

My theory is that persistent-storage-backed filesystems seem to
go slow enough that it doesn't become a significant problem. But
with tmpfs, this can happen often enough that the client gets
confused. And I can make the problem unreproducable if I enable
enough debugging paraphernalia on the server to slow it down.

I'm not exactly sure how the client becomes confused by this
behavior, but fsx reports a stale size value, or it can hit a
bus error. I'm seeing at least four of the fsx-based xfs tests
fail intermittently.


--
Chuck Lever



