Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DB2523655
	for <lists+linux-nfs@lfdr.de>; Wed, 11 May 2022 16:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiEKO5Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 May 2022 10:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiEKO5S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 May 2022 10:57:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5133567D3D
        for <linux-nfs@vger.kernel.org>; Wed, 11 May 2022 07:57:15 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BEgK33010429;
        Wed, 11 May 2022 14:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=L47f1KvFt3AbaZrZI3wvETt2wGMsOYaLldlpXaK6YNo=;
 b=vOcoeIxCtKlTdGZL1w8cCqJ0WlWWvWe+4UeuTaou3Ytbd/lpv8MCcAIn827joXiT4DwI
 d1OGgUCyZM7EzjOznw5hjZTuo1gncvPNskOTSUxzLgkPJBJOEvDB8tTJYJHIAuoih7FO
 Bv5mWwt4DYubs780foqeRrK5tIhXGLpk357L42mFg32f2mX8C1kNa9lE3ETLWRc8XrO8
 HYG8ccsVKdrordd/g+lYLfggP+nteXltlK6687TUXwCuzDjdciTuZSmPkQ+kKvTwOfx6
 +cQS2HlKulOz87/LcMvUmr9SmmFVd/mB1rrymBgdLblIR22O3xlZfQD/FoK4gXZJFcU3 /A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6c9u16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 14:57:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BEpB21009261;
        Wed, 11 May 2022 14:57:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6evqvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 14:57:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6JzkON9zbZULVd3GJcjGCPAPLV+/Dvs6LX0ni5Lu829m+WYvhNf/AJjGpyX12AP+CcLJzDHRcOl73T5DcxJYRW/ZG3jC2pTETCCWBDoT1GmD+xFuc3luCkJ2TRrsd+r70mtlbMhe/u071P9hFN6FbW9WeASC1jK6QKjZoT8jQ0z93rNyePd9/2gWfzViyfx1lhlZ2kNMtLRJwJDT25DIVd6oVw7JnEkSK3ul9ZojDiaNelzoDutEO471X51VF8NRTrt9IVNJVTZkPHwgpxKiR+GvrnUshE6GXz9QrjlOZsy5h72gszu2QrGGNVdO/cA6pOvO7q0GQzLzV0IRrumZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L47f1KvFt3AbaZrZI3wvETt2wGMsOYaLldlpXaK6YNo=;
 b=n/56bh8+6FCiMWWV7ApBR/CS1e9s0/jNCMheg34mp7+OaMgpVNHUhJg/NXrwFIMMu8KrY/UYFj0Iai9krnB6pkGWsKAc8RrCNm0v4GjU54hW1PSd9bKoVvYtFJZwujCnBEzbkJHBHBpXdzNAzU8XKoLraGgo7TMlPYeqJYaY1gPTwIUpX79b2iqlFPYI4VJhhT49ppKHnfgn7r96tUr/rNa/GydPCxS+2Z8hZrk6YlrcchfAtF3p90jPJc1giaijXMl2RjlwSrlep6xm7h5KE5tl8UJttFrgm8oodpN9JluDFWAFkuREggVBG5UWRx/soviTQwcJpgkLwFZj6HrArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L47f1KvFt3AbaZrZI3wvETt2wGMsOYaLldlpXaK6YNo=;
 b=Ya4pm8G7Gi29OBB3/lTLnRdBVK3AU2M0HpaiiackvWKwi293i/fLtsZri6Z0kSnlMyuXj1ERUyYLRSX7x2eNcNZocSpud60Kh2EglteMTIgJvyntRgeuPNh9lj3QLxXogSfn62xxMyfl46lFfiqmpD95AwH/NG2kTkTtc+fiTyw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4640.namprd10.prod.outlook.com (2603:10b6:a03:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 14:57:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 14:57:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [bug report] kernel 5.18.0-rc4 oops with invalid wait context
Thread-Topic: [bug report] kernel 5.18.0-rc4 oops with invalid wait context
Thread-Index: AQHYXyGPzdf4A6mimkmk/DpMpv4nPq0YNS4AgAGbVYA=
Date:   Wed, 11 May 2022 14:57:10 +0000
Message-ID: <2BC5058C-FFEE-4741-9E51-4CC66E7F6306@oracle.com>
References: <313fcd93-c3dd-35f2-ab59-2f1e913d015f@oracle.com>
 <ED29F5B7-9839-4BCB-AE97-AAF776D95B28@oracle.com>
In-Reply-To: <ED29F5B7-9839-4BCB-AE97-AAF776D95B28@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a715d1c-976d-4c0f-c238-08da335e8698
x-ms-traffictypediagnostic: SJ0PR10MB4640:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB46402326C5710A59171DD3BF93C89@SJ0PR10MB4640.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9YmlZRKWZF2/NKVOvYkvwlM1sCBxx5Q9gjNqlJYlcPsqg7hJHMYKhOzoF6smEn/jejO1/K+OAwhhktyUUbT+GE+F9ioaj74qXtq42c38N7Y5ieOAR/mXwxvyIhAqPGfxVWvNPyV7EldbrpHeNXsRplu4SIrUnrr2GGC6cNyA4OR8zlDNP82rfH8ofcnv6F1yC42Jh/1O/hJx2XCcl7fhfVsHkJRiF53j/wEHSElEqS94X7EOJILlavxWw9BOdxGiBvOvBqQXxvbi8O1Gc9DXoA0JrU2FBIwKT4Gfq54jtd2fFuXbgUcDVBW8FkCFHI5hN7gCOObKemQE1Ym3RLFEtvqdCCguvoRR3AKUpeQ1FCujVUrGIlmhNqSF2ZMo2++KJnJKG1tGTOOxdU5sTxms/xYeG76bE/Su8qOowewzqLwXFawEdFvFP+cncZmuYaMPsYLR+3BzkpWEBswlxDdJpaF0z+3TYDZklcOzlKDS4qOBCKVB3DH0rDep7ngvdWlNcUid5MTeXQAhFu3hTB4kEhBxOQubcjfCzsc8whVx6wFI5HtIbqfIn1Wyn5DZvGmyRhCG97nOrAuDVAmL/Ac4YVmWHOhN69tCSjXxFH7lH4j444Pnh1XGREMzLZL8O/UXGxecyrepGi1eUYDAH55u45Tx8Lw0Xdg266jftcS+EFLCH/Am/upjlf4/euaLCT7o/bhdr8eIQY3JVDkUrLmvcna8JuHTKlGS/L5xJka0sE7Hbf+/RVo/M/9C0fRoassa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(6506007)(2906002)(83380400001)(6916009)(54906003)(122000001)(316002)(107886003)(5660300002)(38100700002)(38070700005)(6512007)(53546011)(26005)(45080400002)(6486002)(8936002)(76116006)(186003)(91956017)(508600001)(66946007)(2616005)(66446008)(64756008)(66476007)(8676002)(4326008)(33656002)(66556008)(71200400001)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xhe+0O3DGdOnoD/8ZeekoulGYu71Xm7Hq/TiN7/petyJx81qvTEyTGaayPXi?=
 =?us-ascii?Q?TLUap4LSWngwxJ6zsRQ/EiUXLhZDwOnyFdGHrDhXMas7gD1FD7jSjaZzFKsS?=
 =?us-ascii?Q?DnOV23o9JNBpM7+ff9LMkoUNKCi5v6toIUNlZDnLIVXgXKU/224RMzg1yVs+?=
 =?us-ascii?Q?V0ph9FuVU3NIp2di3KkW981TPKPQsv60xbV7AhSSlN52Qju4uQYFN/En69ZA?=
 =?us-ascii?Q?MwfBZEfT4d/d7geiuRKQeDa1A2LybVoHzedGrm9Zitnlqzb880iTgPt8u96l?=
 =?us-ascii?Q?FDFW9Ap00MwLYEsHYK0rrfZpT8ITZo43HzWLvPyyLJuR/9izkelCMHGDhuqS?=
 =?us-ascii?Q?YL3s+/FPiOJOwAETSnspkiA/eqd4M8Ui3JWaNqoT/RiWKQTAdcfqyq4Q5Rrv?=
 =?us-ascii?Q?FZk7Pok44Gky8S6D9qvm2LUmqjN5V9COllLccgZ6u3hl6hVaCHFVElRPyUt3?=
 =?us-ascii?Q?/Pbj/RWX2PyWQDXPag4MOa15+0etxWnMShDB9E7ckYxwAY/iacxvISUypf/Q?=
 =?us-ascii?Q?ICgNXCadJGu75hRF4UpWoJ7s1qd8hGrh6VuLT5byfwJaxVji/IzQ6iwyVtPR?=
 =?us-ascii?Q?lATcc8tRdnvSfct5klfWBm1fsqfA4OkHyhRDwJKfzYWW7VgsAjlWjBOzFBqt?=
 =?us-ascii?Q?yFoBnsz+2OSSrk55iNCY3zsAHHDgBO9vWxtK6Sp13TsRblDnI2Tqx0fIRBbx?=
 =?us-ascii?Q?Mk0Hc0RZQ0t2mW5WGrGjBWgvHXfXsO/detBus+bU26Ui8KXUfBf6eHz1uNG1?=
 =?us-ascii?Q?d8IcAHwN6+T5eUQiVtyzKnOmrbGdirSi20AKA0r6q6wg6miLP+4toppF36d+?=
 =?us-ascii?Q?czLE1D0YWS3IJbJ9EJtcfVHoe6SIsLkol7olITZpmHr1GcYkgqKm1R1/awJx?=
 =?us-ascii?Q?61QJFhH7NW/RPvItZO2J1gGX3cSj4oTGrL5Sbdob9G0xrI0nvHOBat9dRlUE?=
 =?us-ascii?Q?J2D+TWvtGZZkezdM7QK5JRL9eybBkskvNT5yL++VKhDwTNv3WRKh6BYyc8Mh?=
 =?us-ascii?Q?Lp4qwxOF+qIwDeZIpOTneyb2WI8PAdU5t15cTcO8lIHoEbpHVHQthGqRWD25?=
 =?us-ascii?Q?2kFvBohldVCpCKTNnxVfTO9Afn/tASBSBaG2sCunOECFbJYTZYaOIqJG+vEf?=
 =?us-ascii?Q?phxw05yHzdDhKPiux16pBemNK5F/Sn83E+OfEnpAYmVkBqjWl4gLaUk0yhoR?=
 =?us-ascii?Q?yaKalNaNSwt9M7oYcbsbwLREHB7E6mfpYU8S+EZR1zZqdH1itPAsfBKcAyTd?=
 =?us-ascii?Q?6xxrPN1fNKK8Q9r4TJ7S3JIO7FaSrhJWg5NF6nlr4VSjfkF2DbCxxlqt22A7?=
 =?us-ascii?Q?ndygeGiDMyeaqOHF2rUSvJEpQyJiw4a1XV1BlnIxqONkNZAHC3dA8smsYLJY?=
 =?us-ascii?Q?KzDf5scKIYAhTq980RQo2wBTDAPpI+FpB9y84b/eT5XsDPyD8n9tavqmnoDl?=
 =?us-ascii?Q?Fpqv0BF/Yk4aNmX0iFExb69RmTk856uNqyritndfeKux673e7iJ39WtfB7rd?=
 =?us-ascii?Q?ruLIKNIi+fk1a/qkvXhNn74b6DF0vrOjglcN6XlWjSc8iFRpuI/ZYWLb6M9H?=
 =?us-ascii?Q?YZUzQTbxqgh5gDX4tSojCGr25QSZSbl/cvTmKEcZmBwgj3jRIoIx0RCldoYi?=
 =?us-ascii?Q?+Zn6b4r88labCbA6PKdskfBJy60BdN3TEtDZotjSLUVtP6cvDmf4bpEF+asV?=
 =?us-ascii?Q?BbweGYEKfj/eDmwU0WG+n06y/+ep4gXK5Q1dRC4l1lgzB18Ff1GJE8IWYE/X?=
 =?us-ascii?Q?fQ5XX/sDFYAv4+sNDf4t+zbG+hr+uxs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0716B6D6A75414995F726719F0D033F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a715d1c-976d-4c0f-c238-08da335e8698
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 14:57:10.3822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0r1qIJ8Vt59H7RqLohF3Wut833WHxVWEA87f3wYC0jhE8fANVazxKR0IWkW8nR2i7QAVUmnbas0DuDIWRZZPMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4640
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110070
X-Proofpoint-ORIG-GUID: qAODJAMF_mH1-syln1_3-BYUpnY5j04T
X-Proofpoint-GUID: qAODJAMF_mH1-syln1_3-BYUpnY5j04T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 10, 2022, at 10:24 AM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
>=20
>=20
>> On May 3, 2022, at 3:11 PM, dai.ngo@oracle.com wrote:
>>=20
>> Hi,
>>=20
>> I just noticed there were couple of oops in my Oracle6 in nfs4.dev netwo=
rk.
>> I'm not sure who ran which tests (be useful to know) that caused these o=
ops.
>>=20
>> Here is the stack traces:
>>=20
>> [286123.154006] BUG: sleeping function called from invalid context at ke=
rnel/locking/rwsem.c:1585
>> [286123.155126] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3=
983, name: nfsd
>> [286123.155872] preempt_count: 1, expected: 0
>> [286123.156443] RCU nest depth: 0, expected: 0
>> [286123.156771] 1 lock held by nfsd/3983:
>> [286123.156786]  #0: ffff888006762520 (&clp->cl_lock){+.+.}-{2:2}, at: n=
fsd4_release_lockowner+0x306/0x850 [nfsd]
>> [286123.156949] Preemption disabled at:
>> [286123.156961] [<0000000000000000>] 0x0
>> [286123.157520] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded Not tainted 5.=
18.0-rc4+ #1
>> [286123.157539] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS =
VirtualBox 12/01/2006
>> [286123.157552] Call Trace:
>> [286123.157565]  <TASK>
>> [286123.157581]  dump_stack_lvl+0x57/0x7d
>> [286123.157609]  __might_resched.cold+0x222/0x26b
>> [286123.157644]  down_read_nested+0x68/0x420
>> [286123.157671]  ? down_write_nested+0x130/0x130
>> [286123.157686]  ? rwlock_bug.part.0+0x90/0x90
>> [286123.157705]  ? rcu_read_lock_sched_held+0x81/0xb0
>> [286123.157749]  xfs_file_fsync+0x3b9/0x820
>> [286123.157776]  ? lock_downgrade+0x680/0x680
>> [286123.157798]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
>> [286123.157823]  ? nfsd_file_put+0x100/0x100 [nfsd]
>> [286123.157921]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>> [286123.158007]  nfsd_file_put+0x79/0x100 [nfsd]
>> [286123.158088]  check_for_locks+0x152/0x200 [nfsd]
>> [286123.158191]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
>> [286123.158393]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
>> [286123.158488]  ? rcu_read_lock_bh_held+0x90/0x90
>> [286123.158525]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
>> [286123.158699]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
>> [286123.158974]  ? rcu_read_lock_bh_held+0x90/0x90
>> [286123.159010]  svc_process_common+0xd8e/0x1b20 [sunrpc]
>> [286123.159043]  ? svc_generic_rpcbind_set+0x450/0x450 [sunrpc]
>> [286123.159043]  ? nfsd_svc+0xc50/0xc50 [nfsd]
>> [286123.159043]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
>> [286123.159043]  ? svc_recv+0x1100/0x2390 [sunrpc]
>> [286123.159043]  svc_process+0x361/0x4f0 [sunrpc]
>> [286123.159043]  nfsd+0x2d6/0x570 [nfsd]
>> [286123.159043]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
>> [286123.159043]  kthread+0x29f/0x340
>> [286123.159043]  ? kthread_complete_and_exit+0x20/0x20
>> [286123.159043]  ret_from_fork+0x22/0x30
>> [286123.159043]  </TASK>
>> [286123.187052] BUG: scheduling while atomic: nfsd/3983/0x00000002
>> [286123.187551] INFO: lockdep is turned off.
>> [286123.187918] Modules linked in: nfsd auth_rpcgss nfs_acl lockd grace =
sunrpc
>> [286123.188527] Preemption disabled at:
>> [286123.188535] [<0000000000000000>] 0x0
>> [286123.189255] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded Tainted: G    =
    W         5.18.0-rc4+ #1
>> [286123.190233] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS =
VirtualBox 12/01/2006
>> [286123.190910] Call Trace:
>> [286123.190910]  <TASK>
>> [286123.190910]  dump_stack_lvl+0x57/0x7d
>> [286123.190910]  __schedule_bug.cold+0x133/0x143
>> [286123.190910]  __schedule+0x16c9/0x20a0
>> [286123.190910]  ? schedule_timeout+0x314/0x510
>> [286123.190910]  ? __sched_text_start+0x8/0x8
>> [286123.190910]  ? internal_add_timer+0xa4/0xe0
>> [286123.190910]  schedule+0xd7/0x1f0
>> [286123.190910]  schedule_timeout+0x319/0x510
>> [286123.190910]  ? rcu_read_lock_held_common+0xe/0xa0
>> [286123.190910]  ? usleep_range_state+0x150/0x150
>> [286123.190910]  ? lock_acquire+0x331/0x490
>> [286123.190910]  ? init_timer_on_stack_key+0x50/0x50
>> [286123.190910]  ? do_raw_spin_lock+0x116/0x260
>> [286123.190910]  ? rwlock_bug.part.0+0x90/0x90
>> [286123.190910]  io_schedule_timeout+0x26/0x80
>> [286123.190910]  wait_for_completion_io_timeout+0x16a/0x340
>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>> [286123.190910]  ? wait_for_completion+0x330/0x330
>> [286123.190910]  submit_bio_wait+0x135/0x1d0
>> [286123.190910]  ? submit_bio_wait_endio+0x40/0x40
>> [286123.190910]  ? xfs_iunlock+0xd5/0x300
>> [286123.190910]  ? bio_init+0x295/0x470
>> [286123.190910]  blkdev_issue_flush+0x69/0x80
>> [286123.190910]  ? blk_unregister_queue+0x1e0/0x1e0
>> [286123.190910]  ? bio_kmalloc+0x90/0x90
>> [286123.190910]  ? xfs_iunlock+0x1b4/0x300
>> [286123.190910]  xfs_file_fsync+0x354/0x820
>> [286123.190910]  ? lock_downgrade+0x680/0x680
>> [286123.190910]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
>> [286123.190910]  ? nfsd_file_put+0x100/0x100 [nfsd]
>> [286123.190910]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>> [286123.190910]  nfsd_file_put+0x79/0x100 [nfsd]
>> [286123.190910]  check_for_locks+0x152/0x200 [nfsd]
>> [286123.190910]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
>> [286123.190910]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>> [286123.190910]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
>> [286123.190910]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>> [286123.190910]  svc_process_common+0xd8e/0x1b20 [sunrpc]
>> [286123.190910]  ? svc_generic_rpcbind_set+0x450/0x450 [sunrpc]
>> [286123.190910]  ? nfsd_svc+0xc50/0xc50 [nfsd]
>> [286123.190910]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
>> [286123.190910]  ? svc_recv+0x1100/0x2390 [sunrpc]
>> [286123.190910]  svc_process+0x361/0x4f0 [sunrpc]
>> [286123.190910]  nfsd+0x2d6/0x570 [nfsd]
>> [286123.190910]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
>> [286123.190910]  kthread+0x29f/0x340
>> [286123.190910]  ? kthread_complete_and_exit+0x20/0x20
>> [286123.190910]  ret_from_fork+0x22/0x30
>> [286123.190910]  </TASK>
>>=20
>> The problem is the process tries to sleep while holding the
>> cl_lock by nfsd4_release_lockowner. I think the problem was
>> introduced with the filemap_flush in nfsd_file_put since
>> 'b6669305d35a nfsd: Reduce the number of calls to nfsd_file_gc()'.
>> The filemap_flush is later replaced by nfsd_file_flush by
>> '6b8a94332ee4f nfsd: Fix a write performance regression'.
>=20
> That seems plausible, given the traces above.
>=20
> But it begs the question: why was a vfs_fsync() needed by
> RELEASE_LOCKOWNER in this case? I've tried to reproduce the
> problem, and even added a might_sleep() call in nfsd_file_flush()
> but haven't been able to reproduce.

Trond, I'm assuming you switched to a synchronous flush here to
capture writeback errors. There's no other requirement for
waiting for the flush to complete, right?

To enable nfsd_file_put() to be invoked in atomic contexts again,
would the following be a reasonable short term fix:

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2c1b027774d4..96c8d07788f4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -304,7 +304,7 @@ nfsd_file_put(struct nfsd_file *nf)
 {
        set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
        if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0) {
-               nfsd_file_flush(nf);
+               filemap_flush(nf->nf_file->f_mapping);
                nfsd_file_put_noref(nf);
        } else {
                nfsd_file_put_noref(nf);

--
Chuck Lever



