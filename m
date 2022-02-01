Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38124A5525
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Feb 2022 03:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbiBACK5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jan 2022 21:10:57 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43900 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232077AbiBACK4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jan 2022 21:10:56 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VM8kAk006228;
        Tue, 1 Feb 2022 02:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VqpoaR2/i7P0j2lftiLC6/XgVVFtsMUMBRDxajkANDg=;
 b=nyVUdwAaJLjpM9ay06RKRluYP1hLml03Ovy0/Cy/9cJbmCw3qRDA0eGBx6lfTfyxP5YF
 nJlre77GKhNGgGFxuXZ3YZzYSgiJTcWwm8zj3yKirR56qmKKnqwkR6pgBtAyatKVW1xp
 +sBVKpURiYYmzUBwNwnVLc9Rv2yv1zIUYcQ9R26gYQ0lUQE63dHQzSu+pnXCPhkPpl3Q
 19ZglQjgFR/tQjR2f6Lg/p0X1HpTMc5izxv7kGebqL44Z8BRhs+Wym0hXuevkLSNt6cH
 oGBVc5WVNhyGmWj1huJvAIiP/znvFkWjxK05u8YIzaAekPrvAK9OIPFSs1VI5TDnLIov dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9w9ewk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 02:10:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21125KG1107254;
        Tue, 1 Feb 2022 02:10:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3030.oracle.com with ESMTP id 3dvtpy79e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 02:10:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8Ll1dNZbB4VmT9xnCylGxMsjDHP9z3Q4RA6VagwNqXkDoM3xVrVJE1ErVKxnX4lFI1pyF1Y+0Gc8CYCHlXYf0UyTC0BuSPbgCti+d59R2N/F9Y60BxrFjnYZEZYky68MIRTsCuSggzYsGb33NhMjzTCu/Co+U8NeflndGaTotVSIzoee1J/hpj3gMAWN3KL0B7FbfussK2+ghFjDHwUT9nM6rR8ekey9r9/Am1fKsMV5S49nFKoHdgymjx8iUORQtFxEKftTZ5bF+drD4a//yQzO9okrZDhQF8TMw+PZwGANOVVJcjAsWRO24wBQ0CpmHlum0Dc0zvA6P6vqGWNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqpoaR2/i7P0j2lftiLC6/XgVVFtsMUMBRDxajkANDg=;
 b=kDf9JSLBFlYUYVuW4umQEWqQ6TGzXqBqh5KVQG2h37iOMdjC5fqTsreELZPNd0As5lo5/DGBAbcueElaWKbPbNLlPwRTUzSeNRSK94DQ+2Pi4fG+p+9FBDx17mrBN31mrFdhJaZX1WAo+zn1TdU8p+QJ5XcKDi5sFd4toPBt6IVocyk2yfltVoDPK38P2CN/roFVnMdSVv13GJqeGnuqy8izV+AVSGxEFhOnF64t+fVIJ2hK2YCD4kLS7/mty5L7px8oWryjxTsdVMkXpFNPzVYm+8ldxFq+CcuxZeF2TbEYydZD6aW8RnshV6syDGQ4IgkbwP6g5Vm4+uFYTw3vyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqpoaR2/i7P0j2lftiLC6/XgVVFtsMUMBRDxajkANDg=;
 b=Y7v8Kraz2/1BgZCAlxoKALd2Xf2ADknNMImfuzjwTL2GifX6zYttWBnqtHUVnXJAiNO/AMSsyZ0TUFtHtNqXE/Q4fa7S/BFkHZgricbjUj22PACt763dm2Bk2FeQKNmb5u531oBoB+mE85IrTrVNopZLN1wEhIZD+neNJhcqQPM=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by SN6PR10MB2752.namprd10.prod.outlook.com (2603:10b6:805:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Tue, 1 Feb
 2022 02:10:06 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 02:10:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jonathan Woithe <jwoithe@just42.net>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] lockd: fix server crash on reboot of client holding
 lock
Thread-Topic: [PATCH 1/2] lockd: fix server crash on reboot of client holding
 lock
Thread-Index: AQHYDLbN5l3eHxKrf0S5rkJdvCtsdaxqht8AgBNBKgCAAEAyAA==
Date:   Tue, 1 Feb 2022 02:10:06 +0000
Message-ID: <2B5F63F2-3B58-4F0E-976F-47EC7317B14A@oracle.com>
References: <20220115081420.GB8808@marvin.atrad.com.au>
 <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
 <20220115212336.GB30050@marvin.atrad.com.au>
 <20220116220627.GA19813@marvin.atrad.com.au>
 <1E71316C-9EE8-4C71-ADA1-71E2910CA070@oracle.com>
 <20220117074430.GA22026@marvin.atrad.com.au>
 <20220117220851.GA8494@marvin.atrad.com.au>
 <20220117221156.GB3090@fieldses.org> <20220118220016.GB16108@fieldses.org>
 <6349BB98-FB18-4ABC-A893-1CCB1E5CA3E5@oracle.com>
 <20220131222020.GB12905@marvin.atrad.com.au>
In-Reply-To: <20220131222020.GB12905@marvin.atrad.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8027f8a-583e-449e-7e9a-08d9e527f752
x-ms-traffictypediagnostic: SN6PR10MB2752:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2752A29B9A4B2666F334E8F493269@SN6PR10MB2752.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ub2TnuZN9hnQupqf1JbT1oYrpMYm1vvr5lC9tp7dEz92UTIzuFKTFG48TRV4D2og77pFzuzskQsALsC199UlzGy8J+m67NZyIXL/UWMRghV5qVLISLwiXzwiUwyZ/Z9QXfamIZxOICcl5vj9aOwvoSyzQbGwelMhdUqXbBbxiPUNga92cBy5jVmVSaA+XWgC6WZDrh+Y1ZnVZ6vIglspd7RkVivsemmfB1KhQmwjhOp9YdabY6a9HkgrTSw6xGS++Ol+YoKwFeZuGFjt7tNqqy2ubuUMUD5tcsfpbPzf6I7KdGLnsb7nqUXmaY/fxUubQG+Q64n5JmjSxCCEhCUVyCEfCBpH8GxsTWebMSAP2HDsuhd+u8S3RswHvXMIwFK24Oe2wsYBctgj0pum47jzk9bHwRnOMTjvRWcyI4rOB4bwvm5tFL4V5Ixk/zWWpSdMCyVuI3i+6pWLRmi2MGTCsfAqYlVNztWKF1RZg3FvKNjs4rRRyMcR5WsZu9/sQasIppSc0Q31zBMh2To0klwbIpUEq6ftkP/ogYfhm8Czw/YKarwL3hsirNGVbd1tuP/RiXANYVucqnouTDOPYLiOghrtd53KNIH7ukl2qwRdZoKgwtnEX1nFfs9dSnHosMHnJpr5bmlN1T1m4kCiYBTSOwECEj35KOfMLB4ceoa+y/uJL4MMFgUHqmnS3Pou3tqntRnittWiQpdau0YPryLZKg/bNpLITZe7pd3lHw6laaWaBeiGvDO0qRVSeV4qGGr9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(53546011)(316002)(38070700005)(8676002)(66446008)(6512007)(4326008)(76116006)(71200400001)(66476007)(8936002)(64756008)(66946007)(66556008)(54906003)(6486002)(6506007)(508600001)(83380400001)(86362001)(6916009)(36756003)(2616005)(5660300002)(186003)(2906002)(26005)(122000001)(33656002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eTh+k+/mZDWAuJ0YrbLhpacrj6aWVcVIAbxn6ErTwlrjBw7WfsTdkndjblGQ?=
 =?us-ascii?Q?SMgMMXrAjbDgJlb9VYEU4d++R/1QPdC0x7Gj3g9ofm8R7FrEGNYxme072t8v?=
 =?us-ascii?Q?5zV7kUElN7j0PLqg3uw9q8veISDhXGY6GA2E+9pkuQX0RW6Io+wa7MiUV7/q?=
 =?us-ascii?Q?sTcCaJ2L5YA5cd05+2TQWI5CMQRvMjibPaOKucTeh7rhBNi5Xpmg+PPJtjj5?=
 =?us-ascii?Q?NygKzd0fVpIObdafeg7Wu4L0IalcRm0mceq4mu0ZkhAQbXTxHtPWfphbgC8T?=
 =?us-ascii?Q?C7S1pD5fIJLPhdo4+Gh9EKIQXsRVG7Dw89YqRcObSgGsdTol4jjscZ7XSIky?=
 =?us-ascii?Q?9oeuuBe/wL4Tq3aop6spZAV8S8wrRebxJHQ+4GkbhiEQjQSx4NR46D4UHNck?=
 =?us-ascii?Q?mgGOalj6KDcwBKJ6esdJ/MmPYSq7Tcqz8E4ugQctSExbzwCQX/wBg/Oq4LjD?=
 =?us-ascii?Q?bVEl0LHxUWspZEkd8wpt90dZw+riwLRJzqgE4TYt+XC0zQ7tsM5kdx5iUUg3?=
 =?us-ascii?Q?d/nS7iepLuDWoL9KoSAqHfZBWo+wiAG8O4ciqgTpjM6KorNHQgUtXcU1LpA+?=
 =?us-ascii?Q?DqaWR4PwYPD4wqzzlkEhSilP8c6JUY5zz6evHSKvxTGFBmH0uJqHAOt6WTy8?=
 =?us-ascii?Q?lraSLhnaLDCvRX2i+RBsEuTCfaAY01stiZxJljBklhhg/a97iiMnbnI9+RU0?=
 =?us-ascii?Q?3F/syW6MTJoGmgVS4usSeTAaKnyuNp/aydm5xEsVgpk1/X+HuHx2zIl38IT3?=
 =?us-ascii?Q?iQRt38j8XALzvkbS0Gme1QTowTQpehv4Kxip9W7Y6o/Nh2gZtpbu9TxAsQUn?=
 =?us-ascii?Q?OxHmVaMJdaf78jbvN0mLOYSs8D/uXg9n5FzDYUfG5palagoR6vHh8kS5WFmM?=
 =?us-ascii?Q?jCqCFjhQ1gI32vhbHu5Zs4XqNj33D1fm9CiHbJQ29W8D61McN19qoOaF2+jP?=
 =?us-ascii?Q?3fduS9T6ZA8uGU0d8hyBp/a/alLWQ/M9U3iB0Lp6hVtLGO08Hm22/WPscdrB?=
 =?us-ascii?Q?oSLyUCTB9F2C96F3SCqVsTP8WMYGfywf0oV8DCEB/kd+gj48jYgtnLbYiA+9?=
 =?us-ascii?Q?96cfzlx8/qfFwrDKdTdHa8HnSHsl91ET9RynHVBWUHny0QRcULZERcd7H8hs?=
 =?us-ascii?Q?jnxaqzWjcjb56T7vIq0sj66lG8y/lvxw/JGK8EPq8l/6jrs6kxMFZeuSvqIy?=
 =?us-ascii?Q?FPQwJlmy8IafGBV4yirzX8UMW28cjfW/sapmxlNhCuS9i/2zOJDTK5rMVGqd?=
 =?us-ascii?Q?p7o2gYy1e5peeGF6uXwof4QjV5MWNRchjJtnlpoogJnkX2f4rcHM8gfe7abO?=
 =?us-ascii?Q?dAbDygfl7cTXCnJQrhmbxsvZizfeRuD7QCLMZnHVxF9KOrU0Xs0O7y0x1KeU?=
 =?us-ascii?Q?MVoo+6BTBJrSVQoWwE7XvoKzDjtw4EVnUKU1G4hXbkgbp224TeXvtbrETicC?=
 =?us-ascii?Q?C2SJ3S5uWHSYv6apAaEdqlioAjDHi2vNLAobCRxV24qTQ8xi8JBxWPN0BLWP?=
 =?us-ascii?Q?/VIhWmEeS3mIkNvZJZC77/e6KN3EymTc4Prjt7TS8YJ+RqDHpqhD13e2Mn7/?=
 =?us-ascii?Q?+9/dkrjjqH5DC7LwWJMlsP3gJu9ft3GSW6XDHs8bL6CmswKpeWu4MMzGD+PL?=
 =?us-ascii?Q?SBNO73K7NnmoYffnLer8khU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A4542F730E4884B94E15B4282887A0D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8027f8a-583e-449e-7e9a-08d9e527f752
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 02:10:06.5031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+6/Ju9kzzdNMWtROHHXR3KpaiJ/1G9xgXctK8MirDUv0mUH19lAuZixIoafoeXcShrDzp6rGbG+Hl75dOFQCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2752
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010011
X-Proofpoint-ORIG-GUID: w11pwL_HwP0QPUMdVOVf1wTkEC0T2iNL
X-Proofpoint-GUID: w11pwL_HwP0QPUMdVOVf1wTkEC0T2iNL
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 31, 2022, at 5:20 PM, Jonathan Woithe <jwoithe@just42.net> wrote:
>=20
> On Wed, Jan 19, 2022 at 04:18:10PM +0000, Chuck Lever III wrote:
>>> On Jan 18, 2022, at 5:00 PM, Bruce Fields <bfields@fieldses.org> wrote:
>>>=20
>>> From: "J. Bruce Fields" <bfields@redhat.com>
>>>=20
>>> I thought I was iterating over the array when actually the iteration is
>>> over the values contained in the array?
>>>=20
>>> Ugh, keep it simple.
>>>=20
>>> Symptoms were a null deference in vfs_lock_file() when an NFSv3 client
>>> that previously held a lock came back up and sent a notify.
>>>=20
>>> Reported-by: Jonathan Woithe <jwoithe@just42.net>
>>> Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
>>> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>>> ---
>>> :
>> Hi Bruce, thanks for the fixes. They've passed my basic smoke tests.
>> I've applied both patches for the very next nfsd PR. See:
>>=20
>> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git for-next
>=20
> OOI, is it expected that these fixes will appear in a 5.15.x stable branc=
h
> patch at some point?  I've looked at the 5.15.17 and 5.15.18 changelogs a=
nd
> they don't appear to be mentioned yet.

These are in linux-next right now. I intend to send a pull request this
week. I was waiting for some other fixes, but those are not going as
quickly as I hoped, so I'm going to send these two along with another
fix that are all ready now.

Once they are in v5.17-rc, they will be picked up automatically and
applied to open stable branches. If they do not apply cleanly, then
someone will have to construct and test a version of the fixes
specifically for each of the stable branches.

--
Chuck Lever



