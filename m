Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD0847C285
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 16:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbhLUPNu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 10:13:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51482 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239196AbhLUPNt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 10:13:49 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLCP12O031036;
        Tue, 21 Dec 2021 15:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jPUr6bKQoNUomqhZyYHDYv+s22e6YIUfM/X98Xc/AOc=;
 b=RsXeC1iR/LIa1FYwkGIHYA3idkHQbJPc8QSprhAOLveIojPc1OSNZgrdj8nnF20swSVh
 VlgyOW8otqIKZB00f5LCNwHPstj5V7pZ02ID7xID035ukcnxdlXbmxxDmE422A1KsddJ
 wKAf3DTvKTWY6e3ZRFa/8WyqfMt95LzxjJW0tB7xoX2jYssDGQ/qOubK8PFvmmEHAh28
 uXsCDCyt31K0K2EaQ+atXRiR4ZNfLKUbzXjx+peUfIWasub6cNCV/csBKAtGhOB6wYBd
 f+bcGPAcWONaVnTINjktNkIQBdIcvbYFtAwAklO8ikQgpAoZj9F8kRu9/bGDmgYhSDe0 Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d2udcb1wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 15:13:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BLFAqd8043106;
        Tue, 21 Dec 2021 15:13:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by aserp3030.oracle.com with ESMTP id 3d15pdbhqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 15:13:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTr7Tf6xljPkBaoSMKu8Juq0rNDczHbyKSaTW+st+xfEvGM5F10navocFE1hkSz3131LwMU0G0kCKUGKMUXLpza6rDYLw+V7cqyu2A3r8APpu89ETKysSzUoAIfVwfMYsAyDNzOuNxwB6o7sjnNO5VyVWqDkigwIbMDQ6rnxAqfcv1zAC3AlG0kLG0GlB3VGIPlQLgYqo5/+kAywBHpQcBtDI3sXaszl+ntqyW26lHXu6GMIYCG5RalyXEuj3CWPwXI3mirCqioR4rCqKgCjKMFeP82M+WDdE/Eu7SpM8ld4kDM30/0Wn0QNGeTl8AUJC+ZffWqN30kWyVsiSgC4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPUr6bKQoNUomqhZyYHDYv+s22e6YIUfM/X98Xc/AOc=;
 b=kq/lflLYGKPjbvr+ARbi4Vf9V+iU5iNb0nTyV/BW02Uz2Xsjy+NASzIjFiBApbQl8Eh5UQSt75hex/Q9Ewb19ESUuN65vbE7RTlG5vblW6aB+Tw/i2RxxqhPkx+QGgZ2cihKJJHIRF/zB3Wm6ozcZ5H7K5dnMv9pAMnIxhBjrJYrWiEDzCgrFQ9eTUMzVjQRMXW08mVtxkncEXT8l4sOolTl4NYY4lOMk4F9P0h93hkwt4Uf3XdmvTAS04ZFkZ9EqZqMgR50rgwcYnLLirIZwwNmAtdE7YnvYKcZQQ4tSfzVI1T2ZA+56+4qRVhmE5bK/XSftyNOCzaL8LzfSHVTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPUr6bKQoNUomqhZyYHDYv+s22e6YIUfM/X98Xc/AOc=;
 b=vowmowqrFMTD5j3elUVtxSsFUpvVVE3GDDoxDHGDSXkh6PNE5716eNJ9QT89ESV+OdjTZnjJGmJMMvSaXbLKMW/9lfhIJunnT+HQByPjSEiF0IxxDzw72gp7K0LYymgwHS43XN6/5ph9ol9GkEYHaRd4xTz+pLH9LF2cVhbMLno=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB4006.namprd10.prod.outlook.com (2603:10b6:610:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Tue, 21 Dec
 2021 15:13:42 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4823.017; Tue, 21 Dec 2021
 15:13:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     Vasily Averin <vvs@virtuozzo.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        "Denis V. Lunev" <den@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH] nfs: block notification on fs with its own ->lock
Thread-Topic: [PATCH] nfs: block notification on fs with its own ->lock
Thread-Index: AQHX8qE3BtED6z/nR0SluAIrWY7pQaw2PNyAgACfSgCABfs7gIAAPgmA
Date:   Tue, 21 Dec 2021 15:13:42 +0000
Message-ID: <DB085542-1ADB-470D-A76F-980C595AC393@oracle.com>
References: <20211216172013.GA13418@fieldses.org>
 <bb7b5a71-6ddf-5e22-e555-8ae22e5930fe@virtuozzo.com>
 <0C441CAE-06B6-4CC0-8A52-88957DCF76EF@oracle.com>
 <20211221113139.6to2hact5qfa2sbd@ti.com>
In-Reply-To: <20211221113139.6to2hact5qfa2sbd@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2ae9e40-fd8e-466f-1117-08d9c4947981
x-ms-traffictypediagnostic: CH2PR10MB4006:EE_
x-microsoft-antispam-prvs: <CH2PR10MB40068AB53A501CD09EFA2290937C9@CH2PR10MB4006.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UQ7H8N6rOq1V05wlJOjFVTSNSR7nohn8KXOMcUaXORq0OflMeWEtufLqYe0h7A3FP1tG3Zrm3N5EgMcqfwWakSSVarCHGWnYBlBJN8hV5d/kko6f6djOtHkO9k4KRPz9+uDc4JEj6jrCFEuTMbUxKds4IxeoCnyIp2N0IGz7Txl9TPtNBnc8QOBhieIMiwzUq5QAER7TCPvtyQWGLXHFlXx3XnsAh1HXC5ypLZr78iYjjzX2z1JDikwq4lY/VRwLVFBQCjO9W+meu64hryP2WKwt5OqNTTNTX7qyR1MVSuPUmxddPuBmYyWRUbycXWyLbzWICteUrDjw/tTOAnchJz3HJRwzT6orZX685tTx+HoFXfrVkTK97MvoeTJ78acDUkNhX98zCe857Nt2KDpc9zTS1VtZZ83nKWjlPnqMw5EaCH6KHAmiFDnJdTHatb6z91cKhPUU/wdm1u4KctxH2kLENWtNg7b6yrfesy4/dXukFjLINeLy9ygBad+SLnJS/5kxpDe7/eFaaZ0M8snbt65sXROjqJYmUBHoOrNOUIx3TJGOj1sBawTelKPy9OizKoETtoqugw+mI709vnJ86uP4qGt/vGEJHX+FvHJYErDTUDNhX7Px4wiFbNywuZiCbiljxD29kX4+Z024akH3Y23pF0VaSFcXdRWq3hZgruPxl8Gv/EDqDbzM4zLK9YHRB4LNgmZS6bOhe6M/1Bb83wBnBDBt+VaqIaI5FfYAL6B4I+osu5jnWUb1Egr/FDZ3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(5660300002)(86362001)(6916009)(38070700005)(316002)(38100700002)(2616005)(36756003)(508600001)(6506007)(4326008)(8676002)(186003)(71200400001)(83380400001)(53546011)(76116006)(15650500001)(54906003)(6512007)(66556008)(2906002)(26005)(33656002)(66946007)(6486002)(64756008)(8936002)(66446008)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CKv2OZD90avBVkx0Tccd98qYz4gRnNAFVxjdaLL0jv+ZZcMa7AhKwG7rexZ9?=
 =?us-ascii?Q?Hd26IzufeOiG5sxexYuIJ/WjQpfSWSnWx4qB6ctIcv0KNAuLtSgplPcpklqa?=
 =?us-ascii?Q?NdHwQLYDm001uB4GrKMcpKZrWExUE+M6SKwpUFT7N6gLnOGNY4ljF70gbLmN?=
 =?us-ascii?Q?E83DdmLZwSVJSG1bvfezo2pHPcrh4eaDx1QFUPZ1UXNRdK8BSk0E+/j/OQRC?=
 =?us-ascii?Q?eBQT/jeaMwIzon0gT8gk7Sab9b71keK9Kq39+DyYAgOFpJwW3NLn9Ir+qO+w?=
 =?us-ascii?Q?QvPnD26wtp0jClCz4pYhw65OHy3jdqyGD5+KNU1afhRv4LN8pvixb0N+5od/?=
 =?us-ascii?Q?6ZZUBWNnlTLBa7j0KfcIgPjws+4zgAUntzFmuhmADyJHOm65OQLMPI/Wo3QH?=
 =?us-ascii?Q?oRvuIOkyFymjzatsDQoO9FrPX7X86sqtpaIFNaJZ4UvbMPS38gidJ9gZ0GgS?=
 =?us-ascii?Q?S27mdSBVKNMrhmhL9yFHw33eAZfDp+0BRQpLiwme4w8Jmb17nOBTgtiK2AOf?=
 =?us-ascii?Q?Ke5SybeOPmt2j4+k77w2waLcA/VJNJEVm9k5TXElu3voEh758jGOtzeYq/mk?=
 =?us-ascii?Q?0e6ivyrJyhDu8nEaZ3KX2AhdC6TawvNlL8hRUY2fPhghvdem8hf5bYSmUtsu?=
 =?us-ascii?Q?rfSDxoEIJQwfy2g1kxqLTlnjvgHQcoQ/LexGA2uziizfiEPCYmEMfp0Iisb4?=
 =?us-ascii?Q?UmrrO9AqK5Xfac0iCf00MEvcRSmsdRLNVzcidfoUxcVjdPhHkz8d5WAkIz0t?=
 =?us-ascii?Q?nGmS9zj9JdsS6WVzPIaddWvYql7Qi5L/zTr9+fz9PFdwEJlq6O23JLPk0CAV?=
 =?us-ascii?Q?lfBDdFukKIgA+sG9dNovRmyzcd2dmvWfIczPgqdy4blLPmqPcvh/Xk/4qT5f?=
 =?us-ascii?Q?ierHrrdKaHas6WnUYAaKwet+L/F65ikdW5sysC5z/uIPePnklwjF0b2+RLkf?=
 =?us-ascii?Q?j9PV9OP+HIbapWK/2yTY/VupPk2KtXtSCCKN/oOTuIJ8uzhVOFZuy2cwtIYJ?=
 =?us-ascii?Q?a44wbvbUYmj/DYRL5DSNmfDKgU/9VXytKTJyG3xVFATRagEuXNmHk74za07o?=
 =?us-ascii?Q?4V+IPGZH0l95MOriXO5obtu7bzap/bszRf2NrT+2uRwCe2H3eGGuYBnRVWeD?=
 =?us-ascii?Q?umE8FUXjsVn1BO7qWogGo9CQNCqKOILY94jc2JMspxrurSt1PmzcLs9Hutnt?=
 =?us-ascii?Q?hmxNxj6ZJ++d+mfSzNkqXb9TRaYvgz7OOghYC+g/e11J5UCXV2jHqiTibCdh?=
 =?us-ascii?Q?6+fpwyJWes1XLNMtQrgV8XhK69kg7qTuLzshYRnL+M7dxhaCkeKKhTyr7opL?=
 =?us-ascii?Q?tAK+PqkUUer8B9HS1ctr2iAMZnjxwElaA71RHzmMIWCjVWym0GpB5rjDJfjB?=
 =?us-ascii?Q?z7LZww+Prn7C7N1VXxzNs16eF9Pj7timUyZX5jywJ6Bd+5Tae87kOwfFPZpT?=
 =?us-ascii?Q?dtdbcUpkMoLJ9gP43n8Rv/Iawhw1MD4JYa975YCUYsxLufoaxvXUyQ97ralK?=
 =?us-ascii?Q?WLvdPR6OXQS1m60rmbsGXUZzv67pV5/854Bk1R6XY3Wi8I4eoGVel+d88Xpq?=
 =?us-ascii?Q?iu+9piWbBUf1M3MdmUtlKgftGqbjV5wLsn4wSWn8zlJLc6DGOR6azHdB9kZK?=
 =?us-ascii?Q?EpbggCCx/PxowjJGYyiIOc0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07D47E99B5DBEA4A99489CE5BCE4A7FA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ae9e40-fd8e-466f-1117-08d9c4947981
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 15:13:42.1872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6mH7amwtLdzQkBV5sixIiR3DH0bP77QFTJ+VNAoQhYnYoHQxkPf40SB3gUoErux4cCb42eIt72OpyKhGOrgHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4006
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10204 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210072
X-Proofpoint-ORIG-GUID: uiRLUdvgu7F2eIiTQ9gYalhDhEU-mDlb
X-Proofpoint-GUID: uiRLUdvgu7F2eIiTQ9gYalhDhEU-mDlb
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 21, 2021, at 6:31 AM, Pratyush Yadav <p.yadav@ti.com> wrote:
>=20
> Hi,
>=20
> On 17/12/21 04:11PM, Chuck Lever III wrote:
>>=20
>>> On Dec 17, 2021, at 1:41 AM, Vasily Averin <vvs@virtuozzo.com> wrote:
>>>=20
>>> On 16.12.2021 20:20, J. Bruce Fields wrote:
>>>> From: "J. Bruce Fields" <bfields@redhat.com>
>>>>=20
>>>> NFSv4.1 supports an optional lock notification feature which notifies
>>>> the client when a lock comes available.  (Normally NFSv4 clients just
>>>> poll for locks if necessary.)  To make that work, we need to request a
>>>> blocking lock from the filesystem.
>>>>=20
>>>> We turned that off for NFS in f657f8eef3ff "nfs: don't atempt blocking
>>>> locks on nfs reexports" because it actually blocks the nfsd thread whi=
le
>>>> waiting for the lock.
>>>>=20
>>>> Thanks to Vasily Averin for pointing out that NFS isn't the only
>>>> filesystem with that problem.
>>>>=20
>>>> Any filesystem that leaves ->lock NULL will use posix_lock_file(), whi=
ch
>>>> does the right thing.  Simplest is just to assume that any filesystem
>>>> that defines its own ->lock is not safe to request a blocking lock fro=
m.
>>>>=20
>>>> So, this patch mostly reverts f657f8eef3ff and b840be2f00c0, and inste=
ad
>>>> uses a check of ->lock (Vasily's suggestion) to decide whether to
>>>> support blocking lock notifications on a given filesystem.  Also add a
>>>> little documentation.
>>>>=20
>>>> Perhaps someday we could add back an export flag later to allow
>>>> filesystems with "good" ->lock methods to support blocking lock
>>>> notifications.
>>>>=20
>>>> Reported-by: Vasily Averin <vvs@virtuozzo.com>
>>>> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>>>=20
>>> Reviewed-by: Vasily  Averin <vvs@virtuozzo.com>
>>=20
>> I've applied this with Vasily's R-b to for-next at
>>=20
>> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>=20
>> I also cleaned up some checkpatch nits in the patch description.
>>=20
>> It might be good for subsequent work in this area to be based
>> on the for-next branch so we can track what is done and what
>> is left to do.
>=20
> This patch breaks LLVM build on linux-next for me:
>=20
> fs/lockd/svclock.c:474:17: error: unused variable 'inode' [-Werror,-Wunus=
ed-variable]
>        struct inode            *inode =3D nlmsvc_file_inode(file);
>=20
> This is because now the only user of inode is the dprintk() call, and=20
> this is probably a noop when debug is disabled. I think you should wrap=20
> the declaration of inode under the same debug symbol used to select=20
> dprintk(). My LSP (ccls) is getting confused and can't point out where=20
> exactly this macro is declared, so I am not sure which symbol controls=20
> it (CONFIG_DEBUG? CONFIG_NFS_DEBUG?).

I updated this patch in my for-next tree yesterday to take care of
the issue. The change has been merged into today's linux-next.

--
Chuck Lever



