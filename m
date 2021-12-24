Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBD247EB71
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Dec 2021 05:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351297AbhLXEqd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Dec 2021 23:46:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8286 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240362AbhLXEqd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Dec 2021 23:46:33 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BO4hkGW002453;
        Fri, 24 Dec 2021 04:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=K7/7jBvKLg1ZBo1PXvwksdsrDTopfO5E2wEY71ZZsKk=;
 b=vRLt39tJ+8iqp37RerSSs/vr+TBVZISYO7ZORm0+TyYh8mE+MJ7vMQsqBcNkPpdqPKd6
 o6DhqGFFWnCOV1wH/RrKn7eC2NGlPY1mv9tj5nYLXN03ciVBySXqvaF/1JqHImgFp28I
 Yfzmc/u0iAZXIG1moWLttj+MtxdFde9nrXRa76inNd1nYygke3te0rG0Hx167cUCOyAB
 0b/qyZ2skdESTBkPzgnxBDh9PI+OQoruIDk5yHOhcEcjcsW7WUi3Tyw1Lvo5gtt7l5E2
 FpXdqLKT+bYNssjMP3olIh00p3c9wA0B8oB35Vkqt4VbjR2Ujl9IzhC6XNzRUjOScbOR mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d46qn4kh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Dec 2021 04:46:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BO4fBpH188617;
        Fri, 24 Dec 2021 04:46:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3030.oracle.com with ESMTP id 3d15pgtv1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Dec 2021 04:46:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn9ODSm/3Im1fZ2t2mGtYGtRjtD6uzvPm9/eVNbzL+M+zQY66rTxZNVBalDIFWvr3O2vgVOu2w+vpj5z5hjvn0WWLDzOwwZV5D0A8VUrXuhbgQJf5MAXagqlnjn0HVcN2rh8UrFBRY6C3QVsSDxUpaFbbA8WSS7vviEvoIEinQKCGF+lssQf5BxNbU0QGNJaQy6ThPKMCjQkAAeeFsCrmWSrBNcRPfk8XC/zMx5VZqIWNkTaE/VpH2YUSlFQ5W57ng/Cx1dPHYQVqwrw+zQLRMMuO8OeeMrtL8A8TyKk1mrltk+zxoZFJ8KikhVz8VeGounGWMkNP5TKSRFIObl3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7/7jBvKLg1ZBo1PXvwksdsrDTopfO5E2wEY71ZZsKk=;
 b=UJ0yVDJ4x5ItM8OHWoXw5hrkBR/58jPH83dTuweZRmZHd4SG4S7SRMnrirTzjt69JY44q+SQJQ+duLiLuiAevBnOsNaJ1UFIl47EJYtjqchMSO17NeUgsfYAQGF/1qFHwv0hlnZY9aYhyOvK13O8YzRQNJgdKRE+cYnYB7/svAPcDnCE0CyJpe0a54P7yzMVjlnmsl/+edFpmxgy5OJjS2vSJPkK3i3SEWBlFBnOhpAQMcaJGxeiPE/xVwbRV0eNu9MF39q2utHOq5WqW6ZKeZUWNZu6eATPHYPa6IwXlXu+18UOar3I5nAmEzrtwVFPfuEFHA/le6oYATB6WjYiJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7/7jBvKLg1ZBo1PXvwksdsrDTopfO5E2wEY71ZZsKk=;
 b=ezqWfAbnjn+bbF8FbFuwlxodADy/JhFtoDjZgerKIWmpuwQnghqgRJJ+TE9iw1OwE9sdzubEvJ5IpQ07Af8mvXpNHRSU1kkgbuO6no6iNuhJ+QjIJBhyRre+SQKRAaJ1MkCMXTb+WGVtj8Hpuqq7I1Pv+b2tlM2a7HxafddlYPI=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB3991.namprd10.prod.outlook.com (2603:10b6:610:e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 04:46:27 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 04:46:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: NFSv4 OPEN returns a zero cinfo.after on tmpfs
Thread-Topic: NFSv4 OPEN returns a zero cinfo.after on tmpfs
Thread-Index: AQHX+IE1tzJIenJvnUOCaxDdhxb2kA==
Date:   Fri, 24 Dec 2021 04:46:26 +0000
Message-ID: <49640909-A7F0-4004-AF55-859621B26D38@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53607efb-ee12-43d2-3d6d-08d9c698584f
x-ms-traffictypediagnostic: CH2PR10MB3991:EE_
x-microsoft-antispam-prvs: <CH2PR10MB39912358C287366BAB854C3F937F9@CH2PR10MB3991.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jIC4UdbvPDC4bLptopgJvcklYPV2TObC6zoPhzmixlbqPVLsIg+YX/c33Y2YfeMYcs5hRQwWwznnIGBULlsYQ1Vj3RkgzRR3vDkqqwHJFUazyol4zAKfGoFw56cFsuutB3tzIN6e2jZ7YND5SKThU6bud9hwaKeXVFSHMlrcZOcZyIjww0bZFJViGc8UcM5bCDAsitQPtnMv6P8z8jAsoQVb3uWY6qrnW4jyessg3LBYKf7wi43SlrjAQANS03Da3DKImCP2WKgr33h5DJmkrUJ+OtkemCeSXgsJgcFuFXOp3t7vB07qSOprWzREjwETSNHNt4U5LW/1VyO2fwq327V/88cX8Umj8Lwv+aDxxLaUI2RGsWtP///byyRjvuRSt992SD4primgDywhZcUcMedDe3BT2Wuyd/PR4FU4u2nWQZXn0Sf3bc0fWaxRLdbxI6db0yVLltaD/uEP+L4VgdBOxjkMrf3Iu7oij3oQ8HbEUjGD1gbZ7qcfvlKlAnsqBC3jjbJq7i4UZM4crB8yqUHPwUq/vttIhyk1m8esFuP0PFXnVu/x/6eb/p+A2xtu6r4gm40tTieMBQ1yEcxxUUK+khf421F3XVb3FScEsgOWBCGGrJIeITdektZGgZ17/qFKOb6BnFO8HBcJIn/uVqn42xz57Y+SjCt8rPtgcEELFkWXOLnh1eqp2CV230kQaP8Ppm1EfRYTPYz3eJnqI+ozV3SM1zeld34mzjfGf3RUjYhFSgQs6JlRzduP1fJlm5CI40vkTeuQerFF3c8m/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(76116006)(6916009)(26005)(2906002)(36756003)(38070700005)(64756008)(86362001)(66476007)(5660300002)(508600001)(71200400001)(66446008)(83380400001)(66946007)(4326008)(316002)(186003)(38100700002)(8676002)(6512007)(2616005)(6486002)(8936002)(33656002)(6506007)(122000001)(17423001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lPKvQ6ew8akaUZGFTPIj/Wn1wnpTqZmF1KDis5IjWhy9i78sC59ko8EwXfuX?=
 =?us-ascii?Q?KlJYdlLxB+coyva3m5KQLLJZx7oUEkjYaUetU3STjqxBT5IO2EKMzMulBM2k?=
 =?us-ascii?Q?YO2hZrfkToBCL5SR/ONfbJKRvoZEg05BNw1yqQNRaqaUf2bQgrW9ftl0cCKY?=
 =?us-ascii?Q?hzYv/fNbhB8lYsh2VqUmaRuq54/7OghqdPCpdJJG1ZJ6/Ubz8qTcDCjFvAIJ?=
 =?us-ascii?Q?Add3DxGmEQzztodFjsHmSaPW/5qK7ku5OICw3za53tz8C4VBqcWETYOSpLo1?=
 =?us-ascii?Q?7M81AkIGnyljqQlDjZfq1XJq1Uxd51cHSi9iaxgCb8bfVABPEJqd+Qesqhub?=
 =?us-ascii?Q?ZL0cHZcF6Li5WmfW2RqYmRMEappPObMokEeQ2NAbmIOdPK7Vf8/o3dBR3ZPC?=
 =?us-ascii?Q?ql02WGAVtjpSSvA54Tz/KkW0HzKywdWCCPijR46ExlaNQLkt/knWPKmkhtuH?=
 =?us-ascii?Q?pQOzejKBdUzuUpI0VVGS6TnjA1XJIqhQ9r1mZmKqXylle2zRFdfuDXAUCWSS?=
 =?us-ascii?Q?g6YWgPa4unWEmv2bXoir80qKI031vrkHUvVXJH1LeZEB65O6vM5kWD7H5ACp?=
 =?us-ascii?Q?G7/xHXbrd96s1fsLhUViaYKUCNanPOsWNC7zF6am1C5VQcxT2OIf1ivfAIV+?=
 =?us-ascii?Q?TVtRkWnfh5JPsApdMlbWOxPtd/HnM6TJdiBIRLkMdVovTy2DBJ74JdjHQ38K?=
 =?us-ascii?Q?9UdOY74byrkLvfmdq3JxASovpf8WIvrv09RU6YEnhBj6k2BY7jmGJIw76Q4x?=
 =?us-ascii?Q?xTaO/rQUp1/TchsrQnz/ETmK0K9YN7YA8vjOWZdXgIIgpTOtPj5LDfnZJ69x?=
 =?us-ascii?Q?E5H5u9fyAI9gdMp5JzyGOQWPmlPjuTrwVA5LCYpEr7aziX3TRPUPLT3PhEMJ?=
 =?us-ascii?Q?NXWOEbulLrZkdtm+Ao/mWwocy6J+xeLIBP4GtdezZ/cnb7XDDaV1yL69EU/C?=
 =?us-ascii?Q?GPZlNU7hiYKLa64jUhQFdvlselqHg2Fwy1iZcbo10zXtAoP5f6MmFKgqCpnn?=
 =?us-ascii?Q?1ecEtsEphX2v2QKB4z30TPTikf6veBEW/uSnpTKVQbYpbyh/HlfAWRHvYHJF?=
 =?us-ascii?Q?a2sL5mdP4Txq3zX8JlRYuTTV2+j6m+Wx0zWDdzrEdty4Qq9sYmmV1Rcxe0za?=
 =?us-ascii?Q?jgpsrLf2ktmgq/HVSo3dJDNZJ2IZ2TrC+K89IeJ+G3eGsF4i9Sh596+Mhby4?=
 =?us-ascii?Q?vVaNKXc+4w2vKRQwxhCx8MajWCBB+T9GufbxM8yYeUct061W9Kz0TjH2U0lQ?=
 =?us-ascii?Q?NfuohHw0gR+vhFuBQqz4/hKKrHEi4uiL/UVAYDCsnINTL08poXQGyfaZoJ2o?=
 =?us-ascii?Q?gJQHj6FH8Jw9yCXYmjWobovhUsnT+GUL2DWkIyBOsIVb7KaHWRWCf2FITt1i?=
 =?us-ascii?Q?BGue5V4iQr4hUJ7Mqv7e/9IUWznp+eLWQCvrNWaK0CebQoZX4A2ZHVzde+iQ?=
 =?us-ascii?Q?k7dOmMWCAQeKBiglRXyu5fr1ot/D5hDplaMt7LZm2RF/8K9DJNq+EoS7+KrM?=
 =?us-ascii?Q?DD6xu3FghML6cM7cdOW4lJpAtWWTOyUVxvzfRzaCkDCwZ4a+vpCDByzl5RqK?=
 =?us-ascii?Q?j4B7bFcnJvAlMULKqD8/EA/NpqW/GsagLI6l8PuebeA12oCjJmC6z6PFDuS9?=
 =?us-ascii?Q?rVnDAHjJqezoJ0Y8z/Gr2JY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FDDA501A6E5D4242821A7FC4F48A1A44@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53607efb-ee12-43d2-3d6d-08d9c698584f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 04:46:26.7927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2IqoyZ+hjDZlkKS7GX8YnjhFq9lDVt0NHjn5bdXi7DyAcf41t9mvV3Iy3I4gdcgXIl7HvY57d3s00ILMZDTBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3991
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10207 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112240021
X-Proofpoint-ORIG-GUID: 4wv8CCd-S6OStwawqlfsfDbg30f3gadw
X-Proofpoint-GUID: 4wv8CCd-S6OStwawqlfsfDbg30f3gadw
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

During some testing I noticed that OPEN frequently returns a
zero in the cinfo.after field on my test share, which is tmpfs.
Does not seem to be an issue for xfs.

For xfs, we take the 2nd arm in nfsd4_change_attribute(), and
for tmpfs, we take the 3rd arm:

309 static inline u64 nfsd4_change_attribute(struct kstat *stat,
310                                          struct inode *inode)
311 {
312         if (inode->i_sb->s_export_op->fetch_iversion)
313                 return inode->i_sb->s_export_op->fetch_iversion(inode);
314         else if (IS_I_VERSION(inode)) {
315                 u64 chattr;
316=20
317                 chattr =3D  stat->ctime.tv_sec;
318                 chattr <<=3D 30;
319                 chattr +=3D stat->ctime.tv_nsec;
320                 chattr +=3D inode_query_iversion(inode);
321                 return chattr;
322         } else
323                 return time_to_chattr(&stat->ctime);
324 }

Thus for tmpfs, ->fetch_iversion() is NULL and IS_I_VERSION is false.

Since commit 428a23d2bf0c ("nfsd: skip some unnecessary stats in
the v4 case"), fill_post_wcc() looks like this:

518 static bool fs_supports_change_attribute(struct super_block *sb)
519 {
520         return sb->s_flags & SB_I_VERSION || sb->s_export_op->fetch_ive=
rsion;
521 }

...

557 void fill_post_wcc(struct svc_fh *fhp)
558 {
559         bool v4 =3D (fhp->fh_maxsize =3D=3D NFS4_FHSIZE);
560         struct inode *inode =3D d_inode(fhp->fh_dentry);
561=20
562         if (fhp->fh_no_wcc)
563                 return;
564=20
565         if (fhp->fh_post_saved)
566                 printk("nfsd: inode locked twice during operation.\n");
567=20
568         fhp->fh_post_saved =3D true;
569=20
570         if (fs_supports_change_attribute(inode->i_sb) || !v4) {
571                 __be32 err =3D fh_getattr(fhp, &fhp->fh_post_attr);
572=20
573                 if (err) {
574                         fhp->fh_post_saved =3D false;
575                         fhp->fh_post_attr.ctime =3D inode->i_ctime;
576                 }
577         }
578         if (v4)
579                 fhp->fh_post_change =3D
580                         nfsd4_change_attribute(&fhp->fh_post_attr, inod=
e);
581 }

fs_support_change_attribute() returns false for tmpfs, and !v4
evaluates to false for OPEN operations. That means the fs_getattr()
is never invoked and nfsd4_change_attribute() is called with an
uninitialized fh_post_attr.

It appears that the same problem exists in fill_pre_wcc() but the
symptoms are different. This is because for tmpfs, the local variable
@stat is not initialized -- it contains whatever was on the stack
before fill_pre_wcc() was invoked. In other words, the on-the-wire
cinfo.before field contains old stack contents.

So both OPEN result cinfo fields are junk on tmpfs exports.

I haven't checked if "fs_supports_change_attribute(inode->i_sb) || !v4"
happens to evaluate to false for other filesystem types.

An easy way to address this would be to revert 428a23d2bf0c. But I
wonder if there are any particular regression tests in the pynfs
suite that could detect this kind of misbehavior, in case someone
would like to try to re-implement the optimization in 428a23d2bf0c.


--
Chuck Lever



