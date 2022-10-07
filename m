Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEA25F799B
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Oct 2022 16:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJGOUK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Oct 2022 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJGOUI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Oct 2022 10:20:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F62E3C8C6
        for <linux-nfs@vger.kernel.org>; Fri,  7 Oct 2022 07:20:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297Bx3L7031958;
        Fri, 7 Oct 2022 14:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2hIFSh/cst75T2q4TH1slxs5uWSBUUBVePbOxJZ875A=;
 b=aIw156Rlymj4vHPp9C58f39bLwzpOzB9jZ+Dgk7KuSDrJQ5ZKIoCdXaqnicyEVBUFwFg
 Lrmt2sA5MXHwvi/QYGaTR/5q7Q2uY9bOiAi0lid7rofm3FUPiBOIO1uB4aSYPJrhRwWO
 EdbqhdRa2LtM5VeJZ6pkEyJdLqUlAEccETjjcBWhpkD2TFn08O6Tn+bHAMdVd7gvf+XU
 Q381N0syLp6VqpGAgvD0We/zLFQHIyHBTx3g+AfnhvvNNzsqj9eGoLWa8RUe25Uzf/e/
 aaO0rkYDi4XCxM2ocbv0VOho2ZEo5gt6/vZhCV9Fo/VRn+g77s6QLv1abcmasJeo/9Ez ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxd5tq4vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 14:19:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 297DfRI9020617;
        Fri, 7 Oct 2022 14:19:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc077mr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 14:19:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie23pJthZgLA9zZrCurasnqTt9CxzQltUhyQ25mBQuXybW6pI9jvt+kCcIOMNH5p1oMjxp82fn4wrroYZfOpcker8mInWvoNuagnamqox/sizC6ptdIms3yQyNTp3rqNnyM1g/ttManYL9dL2t16/zoXzdV/di25+9LR96P9ab7vM9CWuyIhJ6Lr8yKFjgFEjXiUOyMPNofHM1RtI7wDqpmoFCDSGFpxDMte8fSdmp66lzCWbKiUALS6q98obXBzb/0DsaCxMv6m49yIL5AMzTWun9TAaEMDq6cWfb3xm2k2wrd9mSrhgKQSw8FLNDIuC/oRNYtIJOffv6QqdcUoxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hIFSh/cst75T2q4TH1slxs5uWSBUUBVePbOxJZ875A=;
 b=mM0dJLEVaQcuh3CVP7vBpbvg113DVxvuajBnB1qIrZF+mp6YGxaTg/ItXa/X4rBhQ3AGhdgq9jTijV3J4I8RbPEJrCzKtGoLjojYMqVcxVMfcXT8/JAwAQjZ3HTPjpxjJUiGGW5/CR95GWn2FF8eJi2LqBz7E/DOm3cK0FxgR2EtJCVuPlxdybzcKJIvZ5xwYMd3PFv8eWVEqd0jtF8gqQvu4egt7aOAjFYpI0DRRc4eYrnfuAZnhIvFTLiBVa4e4XiDHeDTvl2H+ZTutW6u0OY0JpWwRoWzxosG0+csSrMLUyIkuTc+Prn1CB0B4XA6JQKAnPaU+3YPWLnrs5Lleg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hIFSh/cst75T2q4TH1slxs5uWSBUUBVePbOxJZ875A=;
 b=cY5ASwiA84+Et+tu/2u0lIYx7vGeLYvf+3/lSN2VX2fh0DX2PA6Ap0AVKJj9eLaxRp7pfwkWEBLOAu0BK59MN1jbWXjGFDllSyn4E6ZPuznvfYb1Ws8jssmvNmJLCfAn0lERlRHj8GcHD1a0kUfGaAAmLWvtD/Lob8daZzjs1PQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4294.namprd10.prod.outlook.com (2603:10b6:610:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 14:19:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5709.015; Fri, 7 Oct 2022
 14:19:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] A course adjustment, maybe...
Thread-Topic: [PATCH v2 0/9] A course adjustment, maybe...
Thread-Index: AQHY2Z+emh3eGVVXIU6EG1P3HL0hLK4C648AgAAQ7YA=
Date:   Fri, 7 Oct 2022 14:19:54 +0000
Message-ID: <0392D2DB-B0D3-46BC-BAE9-259A2EEDFD4A@oracle.com>
References: <166507275951.1802.13184584115155050247.stgit@manet.1015granger.net>
 <3376ba7410b6211899c12872195a97219230823c.camel@kernel.org>
In-Reply-To: <3376ba7410b6211899c12872195a97219230823c.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4294:EE_
x-ms-office365-filtering-correlation-id: cb584895-211e-408f-3596-08daa86f0142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZgOSENY9L0SzCTlSab5nK3Vp+Kut7cK7SMYP190BU4LhlnUs+2VgVnUVHkomew2c2+LJFcF/NVA7rameGY9z6/BdFJryKsGWdxC7zru+kKzJ2aCzb2+w6MFUl3q6pPI5J8bjLNtqW5WFAs2f89BdmF+JztcKPuYcxTZzOlja9hV2JKag174ePyvljeaAxzqpkBmRSU3XBoPFrHnuHy29lS5XnxXDQA/PmDn6KWvHqnZFo/8KLn6e+9WHQfTSt79jKe7lXxPCBWOfNdP37vL67fiTGy4ZK3g5Vh53sNwtf8Z7InjXjrTGm8Ydv5GgMx2nfRfaW4d99rH19BkOZiG/mslujv6R2AsvfZA1nVptyoONJV/YAIyHqIaLgksySrQnFDlrY0X2QWEqFLZdVpA+Z/j6fqxLDey3OVKWNdgltuCZBA2/VO4bgSddy9d/JeLWXoVXnpmiJ0L7aHfen94tlo5fkorfA2DCbD1gJJ4AqWJH8FhntuxBZ7Z9/rAgmQqEZmKzxIbU+ImNUMH849Ulj0GntLm40oLBH89F3jC/1NlrK2TRjJ0PBEz3Ggugjt77fwVd7gFEuXOgbuw2yDO1hUch6ft8EAiuH/QG8hXdr06IS1JyTE5fmL4X9mZzSP+sjXMDtmXNNG2Tgz4sNtKcWHACNVa5OXojh0ToRMol/ChDWiBIMXMMSp1qE4A37X2g+MF3qLnjYLzehzspXoDz+DaJ7nnrnJjWE5JH5Z7a9z8O7UIozqmiL3YsryTXuumgHoBqAquo0B2VTOjgVQWpTFTD8gpnXJxDH7UQWAJM9Hw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199015)(33656002)(38070700005)(38100700002)(186003)(86362001)(83380400001)(122000001)(66446008)(5660300002)(8936002)(41300700001)(4326008)(71200400001)(316002)(53546011)(6916009)(91956017)(8676002)(76116006)(66946007)(64756008)(66556008)(66476007)(2616005)(26005)(6512007)(478600001)(2906002)(6486002)(6506007)(36756003)(66899015)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cDzG5ZBccrVz7VmTJnXSryQacTA3qgY4Stzrb+C9Q9Ym0P0IaSJRLxIrcVTS?=
 =?us-ascii?Q?JLPQ2Gho89c6j4w2JpRLbUgOhl8jtL2rlLCvo+ytV48kqmUWF63l0hrRSNEw?=
 =?us-ascii?Q?r6kA44jBAVPu+oPYzVNOiJZmAP3o0UT6jyerG1/3iE9KP29ddXJm2e+3sbPx?=
 =?us-ascii?Q?AgDxNO5GBQTLaiCh9onOXduFxvIjnaSr01ySicFOi1QbpUEeWZn/RCuYqLMe?=
 =?us-ascii?Q?HboVQ6ZKQXrJJ9bcqvSgR9c/pgJ/6iA/g1A5t+HIvXHaB1+lXxKp7DANycJX?=
 =?us-ascii?Q?BF0Tbgr8yBuBhTf8fu84htKV9Km2MMQzm3CNTgePbhwExNPOrL0Did7EfUwe?=
 =?us-ascii?Q?JOiHfximbYsGc92nmQ2rsTJJOtmP9GvOSUYQzDVl7mzop5c63F9ODY5Siney?=
 =?us-ascii?Q?LRJcyn9hIFGxTnp0FWSVx+ZxGiOydMcUDrPQbZ1Gjl58tbYwoYEUWYMKBy8V?=
 =?us-ascii?Q?8nixHJsxcVMj8uocj2lhtfiZdWSvUxgMxqIbbdfWwIv0KKu9J4KeIiuVMyeR?=
 =?us-ascii?Q?1hkJF1kcchWtsHWvUENxaGL75cFV7eSy+VcyJQOSs2zpBPK0w+I+IElY820J?=
 =?us-ascii?Q?J0uKtRA+tono7oDiZrYzxWDXAbwTijqTZX24X3RzmfVSAb+0XQE+jZ+uwtTW?=
 =?us-ascii?Q?G1NNRcTHG5ru7X7Af655mEaDqBVGi3c4FxnJ/O1t0OM1xP+ct6/rfSJHg0nc?=
 =?us-ascii?Q?qv7+nwqZve4M/JXp43q+TV1N7cqW7J+69BCWPGvIF2Z2Hn1kxiy/c1p2TIMw?=
 =?us-ascii?Q?D07X7nb2O1FQK2HBVdlcVPO2Gr1mcFwDehoOKLnUfxvkkT+ZdAlk32L0qnIa?=
 =?us-ascii?Q?d3kAJPobe5N6K1Fhu+tdpwytk6uBDmlhMP2a5H43p569JYu4diloH1dZ3E5B?=
 =?us-ascii?Q?XJGtlWnlT0QN69EIEUO4ReCpeC4RXdg8feGGCxmqGYtlaNUmYnM5b3Z9gfEZ?=
 =?us-ascii?Q?QdUgR6SwwuXOiBP8Q5mYROjN8A0TbyP96m9v91JN83HUIFOS8/rt/xIcrHRW?=
 =?us-ascii?Q?PCtKP+9svTFbCXSnMkxqqMAf3lZufwD5MdPrUgZDfqEyVd5rvZDkS2ccTgh/?=
 =?us-ascii?Q?rg3FcQtJUKVZrClSSRlqbRX2whoqax84kr7MjY/iaQ63QwLXw/iTnkVMSONd?=
 =?us-ascii?Q?2N0pPBH2xT8T9m91Z16AsEcK8bjnpUO0IQGrNqdek6EXh0K8X3QL1bZnv4W6?=
 =?us-ascii?Q?j4yMNTj7rx/6/C8V7kQH1qNvmUsz8avnq9tBBqpgeVbp0EqyLZJ/CuWmeZXK?=
 =?us-ascii?Q?bWjWVGmDLfrNz5KMzM4J1l2aoOiSHgmTjZfCdF8BTJrtZoegd21qYkaBcaF+?=
 =?us-ascii?Q?bhb2t+NTYUPycKMElDSprSaqMIE9kjoK5mZvpnFL9vy2s9id73IiKV2prp11?=
 =?us-ascii?Q?4x3trrmh28/TMUwDnKh5pTayfSAgorXO6X0PtpEtaJhyOQRq3GOmHV7lVmEP?=
 =?us-ascii?Q?9O9N71aquqYRd0JBO+tSDuSKIOU8SjjKYp6vgE5sWEh9/i1x7EnCatX578R/?=
 =?us-ascii?Q?cAKuqjuh+pvm2kLfElrotl8zvAhsZDR53hwrax+FoqoCzmRK7MBoosH1i4oG?=
 =?us-ascii?Q?ALytNWKkb8O8OkB+Pt27OhTdEpZQmX5Xt7RbNLG4RQBy3ZZSvapfDW+hnjD3?=
 =?us-ascii?Q?kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D4F0BD15998474C9421F65AA8DD0E30@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb584895-211e-408f-3596-08daa86f0142
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 14:19:54.1986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2feyxnI2Uvbgj2riM76+Cvh61WZuxf3MHO38BfZnx3SWqpVJbT2/I5Sz7bN+sbc3FztNsI3j32XT/LUVeIFE3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210070086
X-Proofpoint-ORIG-GUID: n7k2CIJWT8u8Mqzzc31WjhnaJEF5gzrj
X-Proofpoint-GUID: n7k2CIJWT8u8Mqzzc31WjhnaJEF5gzrj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 7, 2022, at 9:19 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Thu, 2022-10-06 at 12:20 -0400, Chuck Lever wrote:
>> I'm proposing this series as the first NFSD-related patchset to go
>> into v6.2 (for-next), though I haven't opened that yet.
>>=20
>> For quite some time, we've been encouraged to disable filecache
>> garbage collection for NFSv4 files, and I think I found a surgical
>> way to do just that. That is presented in "NFSD: Add an NFSD_FILE_GC
>> flag to enable nfsd_file garbage collection".
>>=20
>> Comments and opinions are welcome.
>>=20
>> Changes since RFC:
>> - checking nfs4_files for inode aliases is now done only on hash
>>  insertion
>> - the nfs4_file reference count is now bumped only while the RCU
>>  read lock is held
>> - comments and function names have been revised and clarified
>>=20
>> I haven't updated the new @want_gc parameter... jury is still out.
>>=20
>=20
> It was just a nit I noticed since it looked like it was being used as a
> bool. If you think it needs to be an int, then so be it.

I prefer bool in these applications, but in this case, I think "int"
is the safer choice. Thanks for your review!


>> ---
>>=20
>> Chuck Lever (7):
>>      NFSD: Pass the target nfsd_file to nfsd_commit()
>>      NFSD: Revert "NFSD: NFSv4 CLOSE should release an nfsd_file immedia=
tely"
>>      NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file garbage collecti=
on
>>      NFSD: Use const pointers as parameters to fh_ helpers.
>>      NFSD: Use rhashtable for managing nfs4_file objects
>>      NFSD: Clean up nfs4_preprocess_stateid_op() call sites
>>      NFSD: Trace delegation revocations
>>=20
>> Jeff Layton (2):
>>      nfsd: fix nfsd_file_unhash_and_dispose
>>      nfsd: rework hashtable handling in nfsd_do_file_acquire
>>=20
>>=20
>> fs/nfsd/filecache.c | 165 +++++++++++++++---------------
>> fs/nfsd/filecache.h |   4 +-
>> fs/nfsd/nfs3proc.c  |  10 +-
>> fs/nfsd/nfs4proc.c  |  42 ++++----
>> fs/nfsd/nfs4state.c | 241 ++++++++++++++++++++++++++++++--------------
>> fs/nfsd/nfsfh.h     |  10 +-
>> fs/nfsd/state.h     |   5 +-
>> fs/nfsd/trace.h     |  58 ++++++++++-
>> fs/nfsd/vfs.c       |  19 ++--
>> fs/nfsd/vfs.h       |   3 +-
>> 10 files changed, 351 insertions(+), 206 deletions(-)
>=20
>=20
> I been doing some testing with this and it seems to be working well. You
> can add:
>=20
> Tested-by: Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



