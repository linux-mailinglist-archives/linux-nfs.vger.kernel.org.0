Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C856B4E6B8D
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Mar 2022 01:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354093AbiCYAhN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 20:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351430AbiCYAhL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 20:37:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53F1BB0B4
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 17:35:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22P0209b031945;
        Fri, 25 Mar 2022 00:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PvoKZeO6DqDlYZSTGCjEGMU9O371ux6aTFAi0g6PX3M=;
 b=O7CeLFxXs9kX03dxBP9971g+n8hKvjTDzpGwEk3HHft7ZsxIBaPminnq/az/3FlLBJ1A
 NAC8vrEByT2/4TbxPHK7XPDSPM+tQmG1Xc4Z2hdqWxWAyFL4oYG3CpE2XVgHtutwOGef
 C3Zq/xn1HcIzOxKJJxh635NlLCuDWjdiLvVsWG3qj3paXk9PaZFeMLqMRoz7LTK614yy
 1nifdpNsNjnTtQilxvQoQGa1R4ekg7gDE6EbzUKkGbB8VtHT0T9K/aDGWm+xTbEuvKQQ
 p2HCgmnrBYAQnPuZnADgoKB/+te9h5kJS1998Qkfq0EiBlmdacy6ZsBurYiQPu2LjrZM XQ== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5y2640r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 00:35:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22P0WdOk138993;
        Fri, 25 Mar 2022 00:35:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 3ew57922ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 00:35:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocCQxqo+Yzh4CK/iXbHDGujoSAbuJY+qs4qh2MXxijQXNo3e75jkAAA53BzxxNY0USd1zEhPfzlA9r08tdYSM+z5AhbZNvlv2ne/oCDfrnFwUBpLgoVk7IXtABSxRnMJALJ+qzucinUqA2uo5k/N2CKRZanGBs0FGrOJhh18GtlMjR0DBcq76hQeFgny9+R4SqY4hsQ0NLNJzioX8HNOmg5jIE3Hov88Le6SeZ0ZJ6RovbjDJ6s/X9WSdyl9ZbxUcrs/Y7XTeTbnCqQuyKP6vbBhR9PGML88xDN1eQtFSVrxGO+Ly5tDwgJCm0Ujr+PhEpuztsIaP51Miq5QjYER8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvoKZeO6DqDlYZSTGCjEGMU9O371ux6aTFAi0g6PX3M=;
 b=MbemmrUtAwNhKJoNwJm2sNuZz/x9QAYCuvspLi443mTipEiffLUBzrQD3Yntm4SJo30/izdcBDv8KOYbCPRgBrrrYIIoQHEBaJEo/t8dMAKpVpmlIu8wEcJwTBPS57fd7c6av9OiT2kDMYt2XfAQfSoJ5FZz6sEkUBE2IVYskdOKUpbF+mV3qJoBfekf2gbvSo2bzC9Ns+Ke+WbgN83hz1HSTrJb9POkVEzGSoV1HrHdAmCjpspoJLt9ikQJK+Atkb6yR9cwOuSkYdC0+0QE8erMYihhAjQvSghTQOoI2Z/lfLiA2CQDdRRH+3odVXJAIQ7sD1B3KviSiALctEXebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvoKZeO6DqDlYZSTGCjEGMU9O371ux6aTFAi0g6PX3M=;
 b=i9r5E0+5kQji+WxzhzDmt0dToIrsTFMaqqRJSEMoBlveHp9QDaMwxPZu7Tmg7uCK4tADiB9Aw2jX06LE3ygPNqfibBmtrB9m4Qyec3mKKpKadhP5BPm2nIDuPNf/8H2RKXmkunP5oZfnbl1txIvRi7U6MkfKqACC6LqsyYvWb8Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR10MB1437.namprd10.prod.outlook.com (2603:10b6:300:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 00:35:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%7]) with mapi id 15.20.5102.017; Fri, 25 Mar 2022
 00:35:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH RFC] NFSD: Instantiate a filecache entry when creating a
 file
Thread-Topic: [PATCH RFC] NFSD: Instantiate a filecache entry when creating a
 file
Thread-Index: AQHYP8uq2f68inC7SkKq9UfIdDsXqKzPI6sAgAAdL4A=
Date:   Fri, 25 Mar 2022 00:35:28 +0000
Message-ID: <E31250AB-636B-4AE6-8A31-69A3C26223EF@oracle.com>
References: <164815968129.1809.12154191330176123202.stgit@manet.1015granger.net>
 <83b0b0292bda06ffa56487ea1a019ea142107fa3.camel@hammerspace.com>
In-Reply-To: <83b0b0292bda06ffa56487ea1a019ea142107fa3.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1200958c-b82c-4d33-de40-08da0df75c36
x-ms-traffictypediagnostic: MWHPR10MB1437:EE_
x-microsoft-antispam-prvs: <MWHPR10MB14371F990D64784311B85021931A9@MWHPR10MB1437.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bLfulK8/1w+iJfA550aw8b6VDot1J1kVIOm5Pa5cRnFy1YgASN/QDUPWO2iEWDfoBRibbi8ODrWytGz3E9mlIPW/hYqTYW0+/bDS+zWQFhb68bLHtTYEcnTpx9CB0A8F/UOUqqmPtc6olU/d9rFn7W449LlkD56P1KTzzP5LccJ7hJb7QY2Ul7ZCpQJc0W51eBWc9edHNsmZN3HebJbknIN3OCQpLqz3yK3z/2Dx0a98H/qXMocE+0LYHpxzGy2mwzZeuiBzZMJccv64iFuHjyEmNgeVUD2FT+kG8/0XLLWMw/Xeg/XynNQHHhcJyo+FXFppWmsSv6Y3iYX8Nf8XdZNpWMC1ePc2kgHD+hbHwDd/uCwZxZuSz77iGGk4U1gR9EBQehk0GhZ3sxLxvv025ISF4GqfvI9Psg/dw2w3eRetJaoRx3qn/cmHalx7EVz8a0H2oidO451xsBM1UhaetewKITZRY4fAVJhnKYC+7wgOiYoHzsDqvNSifLENeHVLSUB7nAIoNIm7yVvo082SXUlHRRAki6j14wD+26tJXlYceVZGzK8NIEigjSjnvGtljtho5NwrY8XFqTB5wD5FPTSH+CSlwPupWOfXWAMp9z39RrZDJJ/wLTWUrFF967D8zmI01e60uQYmoZeMcHhOaU+GhbmOxTdLChDofpEqeLPSU/9zDN6kX8GqP0dDZczx2VxW5Ooimqn2MRpcNgMS3Kys9QOSmPVNGLFufYFm+tRnkJSkHZw5FebdFXUusaA68axD1UtXzHFXf2yowbFdE3m2GNOP1754D7SLx46bAOYKcDcDtAW8nLQzC/fT86uz4GNPYHHhC5P85JNG8/fwW8BZ3U8dW6xjIYUX4IVhC2M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(966005)(36756003)(66446008)(66556008)(33656002)(508600001)(6506007)(91956017)(53546011)(54906003)(316002)(71200400001)(6512007)(2616005)(6916009)(76116006)(4326008)(66946007)(8676002)(186003)(26005)(83380400001)(2906002)(64756008)(66476007)(38070700005)(86362001)(38100700002)(8936002)(5660300002)(122000001)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SXtlOF6rj+H1a3aeInE6XPE9dYN38y8X7Tu/biK3Hx0KLzDDFGGFDK4z/f1x?=
 =?us-ascii?Q?zstxNlPoM6X6HP3wO+hRfR18edQpQj9fS44WAocmr6KpZv8BAlpnuyExnALq?=
 =?us-ascii?Q?HOz+9arGCH7kjecUBgN7Z2lYzOWQF+UpHaIkj5LcAuXtI936MfGl53eFGcZi?=
 =?us-ascii?Q?bqq52JrbzTcACkxgonBudxNlSoHUlLF2mD52B/rqAF5ZNaxCh7Ssjr6h+eBW?=
 =?us-ascii?Q?gaIuQ2C7vTrLPZ6JQwN8V2Cx3Z0Lkd4LcnjQDuI6Vs+z1mvNMJ/dbArGkLRT?=
 =?us-ascii?Q?G7zerXVi94DqAwjJpPlTMWPtJ4TlbgidVxzuAkZrltZ14mn/BH3oWmb+gso8?=
 =?us-ascii?Q?wZFVhsrwSmdB5B92z3dDcBbUNcXLZwIO9KJzLad8c5ZSr1X1bQwdDvdfNUM3?=
 =?us-ascii?Q?my/cR3Z7h6pP69Tu2Rn4WkypXgNVOlDlDvFfN2t7R37UEE7MGJIIpwZxSYKG?=
 =?us-ascii?Q?vMLvWUQdLuwkfd/sZzJRqpLNdzZlcJljHzEctLkdeUOMeC/uuNBTwUZsQ9KU?=
 =?us-ascii?Q?xkCnd0PpICxs4zUdp3R2ZaMJD8hiZby9yDQUePEedA1yyUZs3u0kIxcwHx6C?=
 =?us-ascii?Q?G0coIok6SvTbKtDmaQcuMfpbbmAn8GC2+NP7QJ8fUwnmy+CUjmDkwin/Gyw4?=
 =?us-ascii?Q?RMQMCub+YxRAxp3Az+koz7xH1GtDVYjZ4vOJr9OXs3Z5q9SvxsY4KTigY3rR?=
 =?us-ascii?Q?fYTxwPKZMtCV/foUH8600hxqbQ557QwbowFE+qdtnXWifh95uoEt7zJDrPIw?=
 =?us-ascii?Q?LBbbMhv/F5e0SHCLLYVCJuflarRWdhb1t6bBnbLhL9InYFRzqtzsF9pk96Rj?=
 =?us-ascii?Q?p3+Dn85YCBDOvGMmdstN0Xh2AZ/U8dHYWU3VyPjn5GywpHAKfgfWkj44xT2S?=
 =?us-ascii?Q?+pKkVOM7fzNfYUaxPgPi2kK4lo51XBI21wB62XwUUm5wphzRgUbL3WpndBnn?=
 =?us-ascii?Q?/ODXwkLVMb0GiO2RLEWY03mA+NsPYD5W5VXI04cqEY05tfVa/WmX1xqbrTf0?=
 =?us-ascii?Q?Bqldry2iUvEWQmErKIOmCcTje8TPDtNNxi5K0jckmSQovGcr8V8ZiebuutHa?=
 =?us-ascii?Q?aLdJLZ9dW6OuqMCLP0U47cr13f3VZ+fT5xchO7Vh9mebRjQrvGkllG8ggX0P?=
 =?us-ascii?Q?PO+aaI9A5A6luUawjg1/GOVLM1jpzYsINppZ2O4WDxBFM3j/QszSuS5ktnPn?=
 =?us-ascii?Q?GajJojWZohsoa5iIi1HsTit36w5laVVpuq03bEUOwrV06xl7y/51yFcK1+GG?=
 =?us-ascii?Q?ivw2E5c0Y9dxAiLihcFGzohvJSB28qZ1fvkNNTZQqD5y/yAl/LWOzZDc+c+F?=
 =?us-ascii?Q?emR+KhA9+hP3cMuwatEPRHxhr18MzQhiPLXNof7+BEqCnLXezNJH6UbYdWrc?=
 =?us-ascii?Q?v/ERPqP3JG3MbzRUcnhTrxbg7y0Z70Gj0VavPjKUoaWoYArK4J3ovHufaIB/?=
 =?us-ascii?Q?sUzuv965xmC0ILMU9+Cti1H7AtGgt9bWEN45rhTDBBpDy+c5Wg2bqVJC1HPX?=
 =?us-ascii?Q?rMvE6KbZeLjJTYbVY882/65H33M5lq9R3c7jhCpCVEr12dk2Q0g5d++3iygS?=
 =?us-ascii?Q?CNCCFwyz0UaQcnYl4weBkt8fn3waz9EhswfYianuSvQds/Ge7PTGQI20MK74?=
 =?us-ascii?Q?++DtTgQweohVCZAs6pQ8qINZMeSP6McBbVXMlrKhR4WuNb7tksHO8DOR7+pt?=
 =?us-ascii?Q?Rzu8Y02VdW3QHmTko7FvvCKQCtBQ97fGLOK3y+MwxLYanEzOdz6eGllUsFz1?=
 =?us-ascii?Q?0sAwftClWs3eUu60jpIKTN36YkDH+Nk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9580544501A9D941A43FD4C4C1634CC5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1200958c-b82c-4d33-de40-08da0df75c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 00:35:28.0592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pte53HVOuj2taoW53bJzRsmO2wAAQ4hunZRsho3vi4+X0TbNKcdIoTYzsJtG0bJME5VPN2ioFts9409fqFZTZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1437
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10296 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203250000
X-Proofpoint-GUID: STcTKYe8j2nhVP5ukei-yjE1MX4KktYf
X-Proofpoint-ORIG-GUID: STcTKYe8j2nhVP5ukei-yjE1MX4KktYf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 24, 2022, at 6:51 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Thu, 2022-03-24 at 18:08 -0400, Chuck Lever wrote:
>> There have been reports of races that cause NFSv4 OPEN(CREATE) to
>> return an error even though the requested file was created. NFSv4
>> does not seem to provide a status code for this case.
>>=20
>> There are plenty of things that can go wrong between the
>> vfs_create() call in do_nfsd_create() and nfs4_vfs_get_file(), but
>> one of them is another client looking up and modifying the file's
>> mode bits in that window. If that happens, the creator might lose
>> access to the file before it can be opened.
>>=20
>> Instead of opening the newly created file in nfsd4_process_open2(),
>> open it as soon as the file is created, and leave it sitting in the
>> file cache.
>>=20
>> This patch is not optimal, of course - we should replace the
>> vfs_create() call in do_nfsd_create() with a call that creates the
>> file and returns a "struct file *" that can be planted immediately
>> in nf->nf_file.
>>=20
>> But first, I would like to hear opinions about the approach
>> suggested above.
>>=20
>> BugLink: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D382
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/vfs.c |    9 +++++++++
>>  1 file changed, 9 insertions(+)
>>=20
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 02a544645b52..80b568fa12f1 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1410,6 +1410,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct
>> svc_fh *fhp,
>>         __be32          err;
>>         int             host_err;
>>         __u32           v_mtime=3D0, v_atime=3D0;
>> +       struct nfsd_file *nf;
>> =20
>>         /* XXX: Shouldn't this be nfserr_inval? */
>>         err =3D nfserr_perm;
>> @@ -1535,6 +1536,14 @@ do_nfsd_create(struct svc_rqst *rqstp, struct
>> svc_fh *fhp,
>>                 iap->ia_atime.tv_nsec =3D 0;
>>         }
>> =20
>> +       /* Attempt to instantiate a filecache entry while we still
>> hold
>> +        * the parent's inode mutex. */
>> +       err =3D nfsd_file_acquire(rqstp, resfhp, NFSD_MAY_WRITE, &nf);
>> +       if (err)
>> +               /* This would be bad */
>> +               goto out;
>> +       nfsd_file_put(nf);
>=20
> Why rely on the file cache to carry the nfsd_file? Isn't it much easier
> just to pass it back directly to the caller?

My thought was that the "struct file *" has to end up in the
filecache anyway, even in the NFSv3 case. If I do this right,
I can avoid the subsequent call to nfsd_open_verified(), which
seems to be the source of the racy chmod behavior I mentioned
above. That might help NFSv3 too, which would need to recreate
the "struct file *" in nfsd_read() or nfsd_write() anyway.


> There are only 2 callers of do_nfsd_create(), so you'd have
> nfsd3_proc_create() that will just call nfsd_file_put() as per above,
> whereas the NFSv4 specific do_open_lookup() could just stash it in the
> struct nfsd4_open so that it can get passed into do_open_permission()
> and eventually nfsd4_process_open2().

Neither nfsd4_process_open2() or do_open_permission() seem
directly interested in the nfsd_file --- it's all under the
covers, in nfs4_get_vfs_file(). But yes, a "struct nfsd4_open"
is passed to and visible in nfs4_get_vfs_file(), as is the
open->op_created boolean.


>> +
>>   set_attr:
>>         err =3D nfsd_create_setattr(rqstp, resfhp, iap);
>> =20
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



