Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817C649BE11
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 22:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiAYV6T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 16:58:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8888 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233434AbiAYV6T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 16:58:19 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PJQ3Ls031613;
        Tue, 25 Jan 2022 21:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rTVvxuVxcc94E1MjiqzulJxwT+K0Nsrbkma0FOKouBE=;
 b=eKdYqmXhI8vUepHGaX3OIDRE+1NqGuhqThjC0vGxD16pLF/znrJwBVOPtfD1vJQPW/sD
 IRjqXje0ikfx8vmSwclII1o4jOQIx+tk19qOta9X59V4ApkypUGg0QP1Gqamt1aG1JqS
 jBQBCJt/TEBsEY3UTwU1+tVwEVzGXhXBkkCXsNW4dqvMxpkYt85c3R9pZv8xbH4s7lwT
 c4XaGgm2tuNVvZ4TgTObFsRQr8I5+Swzu+nwlgQZpxBWpkjtxQobm73Ji1y+zeyICDiR
 Shw/QorJypEzdOcLzH0iY0d8ZIO1qRUjarqQWkoTEjMEXfWTcgTOVoSGLaFGS6Lhafrt CA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s4dv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 21:58:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PLoSNq181727;
        Tue, 25 Jan 2022 21:58:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3020.oracle.com with ESMTP id 3drbcpthyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 21:58:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIrrYF5mRHybQYUkEXzfQPROBWocfyLfMe5inoGfkBPded6GnSwGuxfi4L2HBShcn1eD1rbLQ6+ugXoA9f/OuECqeNUehhej7IpwRkI+YCpxjdG/yRx/EZKRnqMEtbc4WP8nBH0ThFMf8CXNcc1Sbej+U69+kM93gt6zY/loV9tW5Ts+Nmh6z9Ve+mLouT2Fken+QWtAGQddQ+HwoicMLQMIlgULTFohGDu0DrhkLm8rubtstOptj1kqYwqIF/8zEsuqnVso7o0PGOEN9da5eBmkh1Qm7N9m1TBQp/hbUweIatphylwz100/Ery5FF7OcYbyFW114bbz6c1mmJINeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTVvxuVxcc94E1MjiqzulJxwT+K0Nsrbkma0FOKouBE=;
 b=D/zEDj0sB3AF6Wq/znECakIHnBLyG4wr8kETjrp0TD7uyfXWA7Eo2gdeHsYESY5e0wpxbXhSjR4RyUm1IRiEm5kwTV5aYiEw3GFGnO6ls4GqiA6mV1WHbOt89SlXtZrzeU4cpZ95sCLIG9BjgsuZieFUKzKpRZfdFMljSFsI37Cy+PuimwzPkpAKh3LdsCM/1imjBwMHzYv17dJzdU2Td8REQObfdRf/rhLFJBPGdb3sTBDSZPe0XmACu5Qm8vYq67hvtA6IN5fiiZLxpReEDFfjUdcdON+pivRw4qEhAFfyGDN+UKLsf8Vpv3EC/SfyU4fSb85l5SrMG/wJbh2FpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTVvxuVxcc94E1MjiqzulJxwT+K0Nsrbkma0FOKouBE=;
 b=la284ZD35SHgX+uk90K9+ACnd5F4d/+ZJTPSDreUlpFpZhQUVNYl7t8zEAVI9VnkfZ2SV4ybccezHwMjV/bDgquFxy/yKZkESbMzN7zOPbhYPzJISRiBEheh3pXYBXa4GBldQ+A14TlNmObcVTbEgjCcSvZDjVp8wiWu70fWhvM=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by SN6PR10MB2432.namprd10.prod.outlook.com (2603:10b6:805:46::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 21:58:11 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 21:58:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Patrick Goetz <pgoetz@math.utexas.edu>
CC:     Bruce Fields <bfields@fieldses.org>, Daire Byrne <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: parallel file create rates (+high latency)
Thread-Topic: parallel file create rates (+high latency)
Thread-Index: AQHYELR6RkgsqUSQAkGSQQ83MPCBH6xykl+AgAAI+4CAAAtagIABDMkAgAASyICAABlKAIAAag6AgAACQ4A=
Date:   Tue, 25 Jan 2022 21:58:11 +0000
Message-ID: <8BF65541-6AE3-45EA-A582-5773C0AAB399@oracle.com>
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org>
 <CAPt2mGOCn5OaeZm24+zh92qRcWTF8h-H2WXqScz9RMfo4r_-Qw@mail.gmail.com>
 <20220124205045.GB4975@fieldses.org>
 <CAPt2mGPTGgXztawDJfAKsiYqnm6P_mn1rtquSDKjpnSgvJH1YA@mail.gmail.com>
 <20220125135959.GA15537@fieldses.org>
 <F7C721F7-D906-426F-814F-4D3F34AD6FB1@oracle.com>
 <42867c2c-1ab3-9bb6-0e5a-57d13d667bc6@math.utexas.edu>
In-Reply-To: <42867c2c-1ab3-9bb6-0e5a-57d13d667bc6@math.utexas.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4083d223-42cc-4c44-257a-08d9e04dc7a0
x-ms-traffictypediagnostic: SN6PR10MB2432:EE_
x-microsoft-antispam-prvs: <SN6PR10MB24323835644721D946EAF616935F9@SN6PR10MB2432.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ovKYEqy4wnj/kerwcScqoERBAZ46BklOgQx2ARO4KltwNnrruwet+NEme9sfVVLyvjJrGYShgCgfd9fjD9v6uNjaOIZmk3QYK87WXgzxJskxIs9X0rduzKxkUvAKqgngZh+mG68ptaNp6J1NZDnFCrb30OZS8LHrY87AibijaGSkpr6S3daYdTPszf9aeOnO3x4XbxdpMdZ3MiKx9X5GStJncboYunYmTPy/ku0Bhhoyrb5RNsZLvdIpF8WAywxpZGZk/XbJaqUKA3niTt28KMcLxXPPBCoPZUiciyqXtgUT+dBZnqvMgPDdFJ1pj+LUU+WuBAJHj0xJG7qmcgqSFUV0io8mpLPnEjD+Jc/4mAIwgDZVYPURhSAiRzZ5qJDwJZFxeVJTPi+6Ilpwytcwmt3IwJIXPiO6rDPlR0NPpukMGQrUELeyJEu01xu2CvSSu9H3GT7b/97b6T7t4hYfvlU1BzpQPHdg7EU9QZ0hKwtqFiOTfQHXm9k++xqYHcJ3+P0SREV/ZIAXeWBIH50BB7QuiEdIW3UmUhrgJtYXgTnEJxsw6IndCFK3v9cpfNV94Nv3gNZwdt43sGvJWwq1rlVJu5LK0T4fNIqvFiSUEB0s0wrougzU+9qospl7AVW+hjC+qOjSPQ4ojpd0aFSj8cnu0dl9JtFwh+SCeQo4z+M4gRfHlkhMC4yRRIoIZORCo++OKTSQdN3vonBp/lHLXg2LuMtUY8Xzw27B+cD1CdTO+DWxgB413bdp9LKheJ1m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(8936002)(6916009)(83380400001)(38070700005)(508600001)(8676002)(122000001)(4326008)(86362001)(36756003)(6512007)(5660300002)(316002)(54906003)(2616005)(76116006)(186003)(66946007)(66556008)(66446008)(53546011)(6506007)(26005)(6486002)(38100700002)(33656002)(66476007)(64756008)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wZ/Q44UjaoR/rDqMCTtvVKKp7zqVI97/NUadLCNEAkIrnyTenCOQfe+JlMaz?=
 =?us-ascii?Q?YZcWT1M6A6WuevlMGA2EdYr/RFUOFs532muhWS1fi9KXDlKEqb7WkoAYREn4?=
 =?us-ascii?Q?93gi9fjxgK711/jDNYJf7nFk/SeermgYoO9JjUtiai65sfUPXW8MtkPSxqsN?=
 =?us-ascii?Q?XPKSbx2fQW1DwTRJlALHWF+nN5CE8GZMjI/7sy3VZvdu+l09m4SNAtBMTbMs?=
 =?us-ascii?Q?S8DyovbpZ2LaS2k5mWw5Uj7Ekcq6vJZTF37tud+ZDViqo98fNJtu6czchT2U?=
 =?us-ascii?Q?EEctO/MFvjTnZOe0kxsUotzpKG0WK5yX0rngDdf4qgGG2TYv0R8fjXtLZUjV?=
 =?us-ascii?Q?VpkJZOAp6dA6yZJd47ONf/ZcWd7w4sVizc9FMlOciPDzJBeHW3Y6sQo2BY5P?=
 =?us-ascii?Q?to2rlL5RGJ3bgxIZ30FZyccJah797I+ClimGREzXz8FpVxMJxEFyBnlNO4se?=
 =?us-ascii?Q?iq/EQJ53yXYI0Iqqk5sjAAJPdnvp+uapu+AZv3edav/g7ov+uh+C9JE80h2e?=
 =?us-ascii?Q?olv/fjlxzH6OwIh+UpCYbZ+44vkcLTUIjItktiANS8qiPm3kssosI8Bd+TjV?=
 =?us-ascii?Q?ZjNQfuT7bMOv5vOlVB1zy6j8PTTCD0PzkwhNQviBri984DwQunoDRTnjimzu?=
 =?us-ascii?Q?qBynQEoWFYvv68XF86G7CDMOiSqpMa0CXJ2De8Lfd3ORVh8LlxY5GSlkrH46?=
 =?us-ascii?Q?Nzf+52U1BIEBnX8eoopEqaMtewYrEEMC+9FdRChVA5G58EsgrbIYYbgN8uJO?=
 =?us-ascii?Q?EcFhy76NnloLICIqcHug7woa/sUo5ltbV6IQh2QTsZZt2BOE4JBDrfE1tnbg?=
 =?us-ascii?Q?HImg5e00b7rsQcfv129YXOnnwcUt+Wwf9Vn90miFIGS7kbh/rwDqRNi8UHTW?=
 =?us-ascii?Q?GXH63QapU6Se2oMrevIbunu2kBGzu7B0OVnyZ5u+743sZjxfC1/S+R8RKCGF?=
 =?us-ascii?Q?ZygOieLJdomGbvtbTUhhS1KrQvGR+OWMryN4ddNDt0JKDo4Y3Foka405/TR1?=
 =?us-ascii?Q?B5u44a3/6r9S4zXe6b3V9NUDcNXuSEmWCglv+7sJrvlRzm26l9aot9m4hIJP?=
 =?us-ascii?Q?XQqwscLWs9fDdp8dCjHMg06U3/QlD/l6Orx3mm02qZAJPaUEMWGn0hsMSw3+?=
 =?us-ascii?Q?QfZir6ElH4xKyZzJeWgl8/3iUa1iXqfLBRFC9UDfkY4p/hDbXE6A3TtKiaC/?=
 =?us-ascii?Q?3a+ahJVqMkuiodvnMy/tt3zZyskz4Hksk70tlJ7AdV7ew6snPCuEeAaAx/uO?=
 =?us-ascii?Q?+WRtWmuwkkLeUtObM9HPgswd1/GyuHnfqr8TKMXE7xArd1LgBUDGKyakt4XZ?=
 =?us-ascii?Q?eSd+xMefRVw3+sDrDkNRBPkzztTgqManLm6J4BekBljURKan5HvfmMznf1CE?=
 =?us-ascii?Q?lEd+ARg44ogtWNRlh/0n8pFhCz3NzDhuoEGMGCo4tITGPudp4AMslmbJ+av5?=
 =?us-ascii?Q?kaVqxsjD767UJkpxALfMyrLpObUv/F6vXB6OrEkWLxnL+mFVykZbgh19DuDs?=
 =?us-ascii?Q?PGufqOQYje+x+zapK255MyBa87s4vk2bagGXlkkAqzNDBogCwB8INweqLC91?=
 =?us-ascii?Q?hsWIb5n8z87PU0SSG49TMVaNDzpJY+0gcYszHILnMxbOjZr1BmYtYdh2D2tR?=
 =?us-ascii?Q?yv6S7rMqsQxB2qEwn7OFSP8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F961F86E1D3A144C990A42A4302AD6EA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4083d223-42cc-4c44-257a-08d9e04dc7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 21:58:11.5432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nUBlCSJn6ravX0KCvSYgH90izGIHP6e6oHh0463pXGUKxdH7nSRWWntDeJX4Et437N9XqcedGe8AzolSbxlIQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2432
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250131
X-Proofpoint-GUID: 4tr4s87QifYbjXWp02tQZru5jf6KrIZI
X-Proofpoint-ORIG-GUID: 4tr4s87QifYbjXWp02tQZru5jf6KrIZI
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 25, 2022, at 4:50 PM, Patrick Goetz <pgoetz@math.utexas.edu> wrote=
:
>=20
>=20
>=20
> On 1/25/22 09:30, Chuck Lever III wrote:
>>> On Jan 25, 2022, at 8:59 AM, J. Bruce Fields <bfields@fieldses.org> wro=
te:
>>>=20
>>> On Tue, Jan 25, 2022 at 12:52:46PM +0000, Daire Byrne wrote:
>>>> Yea, it does seem like the server is the ultimate arbitrar and the
>>>> fact that multiple clients can achieve much higher rates of
>>>> parallelism does suggest that the VFS locking per client is somewhat
>>>> redundant and limiting (in this super niche case).
>>>=20
>>> It doesn't seem *so* weird to have a server with fast storage a long
>>> round-trip time away, in which case the client-side operation could tak=
e
>>> several orders of magnitude longer than the server.
>>>=20
>>> Though even if the client locking wasn't a factor, you might still have
>>> to do some work to take advantage of that.  (E.g. if your workload is
>>> just a single "untar"--it still waits for one create before doing the
>>> next one).
>> Note that this is also an issue for data center area filesystems, where
>> back-end replication of metadata updates makes creates and deletes as
>> slow as if they were being done on storage hundreds of miles away.
>> The solution of choice appears to be to replace tar/rsync and such
>> tools with versions that are smarter about parallelizing file creation
>> and deletion.
>=20
> Are these tools available to mere mortals?  If so, what are they called. =
 This is a problem I'm currently dealing with; trying to back up hundreds o=
f terabytes of image data.

They are available to cloud customers (like Oracle and Amazon) I believe,
and possibly for Azure folks too. Try Google, I'm sorry I don't have a
link handy.

parcp? Something like that.

--
Chuck Lever



