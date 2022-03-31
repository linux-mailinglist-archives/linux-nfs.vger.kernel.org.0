Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD2B4EDBD3
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 16:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbiCaOkc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 10:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiCaOkb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 10:40:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9049193C9
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 07:38:42 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VEVZlg032352;
        Thu, 31 Mar 2022 14:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8sggvckge60Geo2hWmoI5DUbNMjskeB4bZ5gMTqOLBQ=;
 b=DGI9+8C/3zOOcjJkFaVBT44pO+YG/GS3PQ6eA8zyixaaBY0FqwQIf8Vn/u9RnXZwqrhj
 ilT9J2KgRMACUueKkzv72rOK5PnCOgTAdZi52UTpjVb0N5GkR++FJAKoMH/6/dkXGJI8
 Mo4Ef4i/jIiQDLXvC2cTETMqCd569C8oVOsQGXwIzxbk4ea+dde9INjp1jHHFttt/GCD
 9i/5rcoqLTGQoEF/figgf8W64HCf2LeVpWSWwryaq+jz0gcwwto53Rvz5hckp16i2To5
 L2MFrppkkvO128fXrRTM4bYghsE3JngHGQn3vNnlnLIfgt0m8HzIRYY1vsWfUCQbUO5P Wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctvs2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 14:38:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VEaYFn025555;
        Thu, 31 Mar 2022 14:38:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s95f7hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 14:38:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9uuJoQgK8AuvXXYtLbcRhuxtsNzsJiO318TlyrSF6B74SyZNkYNuAxZrG096+I5xNK6k08jAI1PBVAKJH7c2a0X5sahN+DoG6bDhc8lTQBFKzAmn8jAhiZSHdoKUhSMMqyGtWQuDqmmATOVF2Ql3arOAA9detcVlHox/wQqxknE6rBbwgqDCpJqKfBOcV7gfXqWXP02mYoaPr06AFmjQ2K/+A4l+R/hqEHwEDbRUZ+k7DKf3wPACeOkMoZR2HvcgTw9AxJzGeKPrPCY+lGrF3PXBi1n2sRgevTH3PIy1rKRH8PhV0fafMUDJhx6v4/mbqvyFyYb8cXLO16/oYJlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sggvckge60Geo2hWmoI5DUbNMjskeB4bZ5gMTqOLBQ=;
 b=PoRu01MocsVyRO/9tZmCTSvX2YuMBBxe+8j73I7ng+E46ATWz9PzmBCkgoZ3+oXOlt8QIli/JCwp0Ni8XQUa0SebhgN/Y98dygtAsW9M3Exa3L/VMUcUmKa2bU+d7awJTmOiplaxtytxmdJkVwRDZYLVKi/2dfnM4NedHFjuxnsKF/4Myr5QISDkFbuGx9mPt3dlM7VSXIMyiqfLLtMjCTm6ESTwOxO5jGhIjl+s1/sqPHIt5eEQxvg74xRFwX1Wz+pvEeK5nxJnn6ksE4D7suwxBd6Dx/Ywag2YmMbfIl7NLTxMaKjbqLuy4yeWNpJXZH/LhcXc5wpgIbLkFCueYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sggvckge60Geo2hWmoI5DUbNMjskeB4bZ5gMTqOLBQ=;
 b=rlyih/6eEANxdUD5nRjyBO7M2NFNcR7Xq0iSHPuQiek3OjoFkfF4Wwa/L2pOfc+0RZdjuku6X6It6G+o3itrCnIZco5gTzHldJtLOL3/SJu9VWHBf0lpM7T0ol+CUYl9X9h7rmjO7Y0MOQxjt/HMDY5Kki1RswSabjNQM5jyfq0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR10MB1798.namprd10.prod.outlook.com (2603:10b6:903:126::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 31 Mar
 2022 14:38:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%6]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 14:38:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jan Kara <jack@suse.cz>
CC:     "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] nfsd: Fix a write performance regression
Thread-Topic: [PATCH 1/2] nfsd: Fix a write performance regression
Thread-Index: AQHYRQfA4Ba04UEqhUqOOocs3qn+IazZjzmAgAAAqAA=
Date:   Thu, 31 Mar 2022 14:38:23 +0000
Message-ID: <CF6A09BF-CB8D-4E83-A1F6-2D42A051AA25@oracle.com>
References: <20220331135402.7187-1-trondmy@kernel.org>
 <20220331143601.3dz56btaa5h63tu3@quack3.lan>
In-Reply-To: <20220331143601.3dz56btaa5h63tu3@quack3.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23abde57-8d22-44eb-9524-08da13241bde
x-ms-traffictypediagnostic: CY4PR10MB1798:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1798FB716BAD3C8072565DE093E19@CY4PR10MB1798.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0uXG6bnjEKMAtbQnEUN63Se7fNS1wFysX2VIViZ+gss9vhfnMeV6Fs6HQ3TEw8+VTLrLETGuxDX7/OE9u3JP/j/dxQ/1/TtC0Dda7hjPjgUXJ8xw+RHkQnnwsS2foxXTnwDEBLau/Z+UGs+8MEG39xVQIJ4nMobgsOgW8vcH0kdFzzX6hwL1l3F9QiLWsaWVZjqQctqIKufgRGafkTYTL1Qlhj//QlKgEOu3VqUfT0HwgPZnnZjjUXHyTf4pdzr8M0n9SC/Wy6pX7H4p1YpaCkm3dBe6lTVRTbqL7J/1Z+AlUceqElJVKBQ+uGQum/g4vQGar/43zIO1lj7NaOcrr+1mnFKlDQoD/DVtR1avgPatYS42sw9vQ9pMYZNHg/6K6QEtimCfh2cVe9WhoSBIdFtClGjCVBAy+lhbIHmA+4FnVZCL9g5ftr0IAFBWhktUr0G/HFYsosfs6Gsc7+wIypGLUUFvB4j4s2oTODcCPXiN1slz/TW0i3Bk5c7scn8JN7Lp04McuI9q51crAqC7qahPq/MJpEXv6uKKdoFJcp4fnn1veOIof1DNLHzioD8FNHJiuCpuTgQK8v9LZ6sWPjXt6bokEJZGbmOOQ2wsR66bw3DOdp330MBqJDZVEfbPCvBIYm2a9DjcnRsl5Oh2+AJ+ZmZXArLxHiNtAGEBVOBcJSAsJz/19ThDKvpc/5PpkrRC7fCQb56C+EaLk2DGx6xMHoZpArSJ6MwzRLPKCN7QlrthLp3HbYDmjVMWsE7VZ8gbziBbSiS/PbMXYETh4F/AvtuE12rYEUtYwtpsAjCk+uCCvgeTF4cuQizjqLjR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(26005)(6916009)(83380400001)(6512007)(91956017)(76116006)(64756008)(2616005)(33656002)(66446008)(38070700005)(4326008)(53546011)(8936002)(8676002)(54906003)(6506007)(66556008)(122000001)(66476007)(186003)(5660300002)(71200400001)(2906002)(86362001)(36756003)(38100700002)(316002)(6486002)(966005)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DTg7SW9TIIGKbWo8+dTeXN8w7K0sNl/kMd/7VsCMUlfRysLdmkWkOsXnKHw0?=
 =?us-ascii?Q?Bakqin7xlpbpOU3NQczGaFB+aVVXEf26Scu047Zdjvk0b5KxQ6mmXppG8nKn?=
 =?us-ascii?Q?zGGVeEjdDAOMmEqDkdB7Bl2SR56JXc7G6a60u0z7jjPGP3OYYpEYc5nm8H04?=
 =?us-ascii?Q?leBE/BnOsizQ8vk39kgaP+BqtvnSRzveTHod7NXa91PtoQrfJCWllVee2uat?=
 =?us-ascii?Q?KIFG7Wyepts6wtXzq5w6K+kSHFpVtVp4ILx7bTp+ha7Y+zFYikhd6o8bWjbB?=
 =?us-ascii?Q?lfLwpEFE3M+u7CSojuHmsoWdkv7MYOSijLl4LeuwpSX0Ch7MUOQCQiidsvFf?=
 =?us-ascii?Q?z3CI6IDhUp95N3fKcR21uSP9NireQwRBsM7QaQaA+SrUyUUyZ4tI3821mV8m?=
 =?us-ascii?Q?L/Q70SJ+POjS/eFl1pE9MK4Q75ujZeiiwlpK1YvMNgjdVt2UWF1uiULw/tz5?=
 =?us-ascii?Q?Chc2BdPeWJdqA/6TCituI2Fv19C9LjXVlTz1D+UuPAaVyA4ZPHXRVX5LzY9I?=
 =?us-ascii?Q?2Y/WvgzyqcJ0c0bCgKe3DBBi/tyJ8upunzLBcZIW+vAv+MH5+J+Yrk7/sJxo?=
 =?us-ascii?Q?MTVZo538neaDpqqNx2F62VejW6PuNhHN9+PvcIwNUUTpcNw9dHQT8WdXOqyt?=
 =?us-ascii?Q?0vl/qq0ty9UTuXGASgLShKEEF1Z0Ylmf2NznGy0RBYNxd4VibzJNp4du4e6I?=
 =?us-ascii?Q?2vXnrcvvNVkE0PqBNNJgiu/ZaXjArLhHXxQknMTpG2NkXwVBctrWCb9ZQaao?=
 =?us-ascii?Q?Dgl1hIQwS74pAWSHMNUsI3mCC3YIrg6yB9qmzy+gfPPi0QDEj+oDBJd+uHic?=
 =?us-ascii?Q?Cs5gahWXUwky27REPHCIOAfoBBGOG/QlWRBuvjd7WKpHlQPB3W6DD/TdFX81?=
 =?us-ascii?Q?E9KpTZc6YqMwKc3KvIm95jlYQYhBHWKg3MwRlFf6EofZimX9kGXac5Vo+NSq?=
 =?us-ascii?Q?zhsg35jsBDuqYmsMtL3bxCPapjD8K9st0zyVSea+rYhm4BV1x+SU3Co0AV21?=
 =?us-ascii?Q?sNyPKEjwtBK+BdKCi9xmjG+3sA1vS1P5RrmuCwFwh0upZts2fmzLrXMW2t1F?=
 =?us-ascii?Q?lmDG5EF2qpNr2emm2DVi0S6FQjNm6MHWAomeHS0A6rMUW5e8JUc8g3KJC3Q8?=
 =?us-ascii?Q?KGGKOU4bbPSVvrbM1e/KeU2ALzpQ3v7zPAhXhSGwfqhI4bXXaOBu2SF3rMH5?=
 =?us-ascii?Q?jp/857HCT++HhRAaFtWLEa0gjTYPyUqKFIELis09+rqETuQEFR5M26PrwgaG?=
 =?us-ascii?Q?1Holy4k/Syyh3SZQurxpQOfBxD5c3G28H60GYWEOv6POH9dPOReZ0dRJGobq?=
 =?us-ascii?Q?4lr6YCRX2AfryNMoqWT+UZW9hdu6vZAq/0AR8sBlEFPG343QZlNURjAqGiIl?=
 =?us-ascii?Q?8op2ho6Y5ejUqqX/PKFRFGwDuE3XDK+h2Y44dD1/P4ODtZ2QAgBOOQl8NDl6?=
 =?us-ascii?Q?jq1JsT70I+VmMFIoDhXn2ZJ/JYcj/rigQ6KIrTR3jE5EJoSR3z5dZ9eE/0E9?=
 =?us-ascii?Q?lmW0bhZ0Y7LThOueGg2485hva5jGC55qWc+QgX3Z8AU3zsA3ZkZ7Q6Z2W/Za?=
 =?us-ascii?Q?VYW7gVy4rCnIkbVHuGwSCfRNFJQSvjrGsjqd2JNvvjt6I2ACBWp0EqxtzqvL?=
 =?us-ascii?Q?R13Q4n0wlzLk3/9q+63o02pY4q/YB2A2DgIq2dfR2DhmdxEfLiBvy0J8Okid?=
 =?us-ascii?Q?TK2WTJFJf5IZEpW5eSMecE7lVRjJFmjznt2bUtspr1izV483ofH8uXJCTfXQ?=
 =?us-ascii?Q?szADJWLbVEoVnYkTbfeaHq4MFIEEU8Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F76F9B5269738244B33CD76EFCCBA2DD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23abde57-8d22-44eb-9524-08da13241bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 14:38:23.2731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uK0HzV1g9bUWJzFuAWG9pf3JCo8rOuq/lGIaRzIsB2Dq2++OwZWMAGZ9gwMKJT0Z+YbJ8CWaHz+dMMyELx55QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1798
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310081
X-Proofpoint-ORIG-GUID: LWS8Sz0kkkAJr-A0jd7-uhmxPPjpM0-R
X-Proofpoint-GUID: LWS8Sz0kkkAJr-A0jd7-uhmxPPjpM0-R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 31, 2022, at 10:36 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> On Thu 31-03-22 09:54:01, trondmy@kernel.org wrote:
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>=20
>> The call to filemap_flush() in nfsd_file_put() is there to ensure that
>> we clear out any writes belonging to a NFSv3 client relatively quickly
>> and avoid situations where the file can't be evicted by the garbage
>> collector. It also ensures that we detect write errors quickly.
>>=20
>> The problem is this causes a regression in performance for some
>> workloads.
>>=20
>> So try to improve matters by deferring writeback until we're ready to
>> close the file, and need to detect errors so that we can force the
>> client to resend.
>>=20
>> Tested-by: Jan Kara <jack@suse.cz>
>> Fixes: b6669305d35a ("nfsd: Reduce the number of calls to nfsd_file_gc()=
")
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Perphaps you could add:
>=20
> Link: https://lore.kernel.org/all/20220330103457.r4xrhy2d6nhtouzk@quack3.=
lan
>=20
> To make life of Thorsten Leemhuis doing regression tracking simpler :) (I
> think his automation will close the regression once it sees a patch like
> that merged).

I'll add that (no need to resend).


>=20
> 								Honza
>=20
>> ---
>> fs/nfsd/filecache.c | 18 +++++++++++++++---
>> 1 file changed, 15 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index 8bc807c5fea4..9578a6317709 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -235,6 +235,13 @@ nfsd_file_check_write_error(struct nfsd_file *nf)
>> 	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err))=
;
>> }
>>=20
>> +static void
>> +nfsd_file_flush(struct nfsd_file *nf)
>> +{
>> +	if (nf->nf_file && vfs_fsync(nf->nf_file, 1) !=3D 0)
>> +		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
>> +}
>> +
>> static void
>> nfsd_file_do_unhash(struct nfsd_file *nf)
>> {
>> @@ -302,11 +309,14 @@ nfsd_file_put(struct nfsd_file *nf)
>> 		return;
>> 	}
>>=20
>> -	filemap_flush(nf->nf_file->f_mapping);
>> 	is_hashed =3D test_bit(NFSD_FILE_HASHED, &nf->nf_flags) !=3D 0;
>> -	nfsd_file_put_noref(nf);
>> -	if (is_hashed)
>> +	if (!is_hashed) {
>> +		nfsd_file_flush(nf);
>> +		nfsd_file_put_noref(nf);
>> +	} else {
>> +		nfsd_file_put_noref(nf);
>> 		nfsd_file_schedule_laundrette();
>> +	}
>> 	if (atomic_long_read(&nfsd_filecache_count) >=3D NFSD_FILE_LRU_LIMIT)
>> 		nfsd_file_gc();
>> }
>> @@ -327,6 +337,7 @@ nfsd_file_dispose_list(struct list_head *dispose)
>> 	while(!list_empty(dispose)) {
>> 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>> 		list_del(&nf->nf_lru);
>> +		nfsd_file_flush(nf);
>> 		nfsd_file_put_noref(nf);
>> 	}
>> }
>> @@ -340,6 +351,7 @@ nfsd_file_dispose_list_sync(struct list_head *dispos=
e)
>> 	while(!list_empty(dispose)) {
>> 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>> 		list_del(&nf->nf_lru);
>> +		nfsd_file_flush(nf);
>> 		if (!refcount_dec_and_test(&nf->nf_ref))
>> 			continue;
>> 		if (nfsd_file_free(nf))
>> --=20
>> 2.35.1
>>=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

--
Chuck Lever



