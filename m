Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03F861FF98
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 21:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiKGUeO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 15:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiKGUeM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 15:34:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98CADE1
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 12:34:11 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7JOH07005176;
        Mon, 7 Nov 2022 20:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xA09AqJCQiZKl8chdmaz01pEi7FUSVLXAY2HPavpSWY=;
 b=pC7nzHDLhqlUf/y/AR+ZK+o1HxOqPAzjka0zsB0/+zxyqEMi8cAIuagpafVgaU1Y0Q/q
 RnREzrX4MWjJacjE6a6kL6dDggVgImCCQlxb1RenHRax5EiHhIT3h2yX8gMZqOJ32Tsb
 HuTMWG/M3xKExa7Sbxek+Wx7q+dshIwzgFiIPtAyfZGa291crDEmAxabiP+1ZNhEKPzj
 PakynIk8NX2WnC70A6qQdwWFnyDXelTDQ5oC1AeGQIHwUOwJaNIXUNaaCCPR/FECxFOw
 3Uvka8C/9XDwUdzxW6i9egHh5ADXKZYnV1ZpTi1SNpWez4qjLT1jSm9xUZJPqMpTVAX+ NA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngren4n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 20:34:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7IaY5s030089;
        Mon, 7 Nov 2022 20:34:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctjp731-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 20:34:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvcS//N92dNsDn+HSzPgb+QGDJVJdswPGNsBnI8EpSFnAgFdYKywNnqH3F56kHzNog/qxEZP6DMyIa7s5h8iHoUQaLToMt4gKnKepaMt1/WlmMpsj1IfKWSg+bpqyE0uZHS1cRqai4GNHhJtTALsLIBf3tP7TfrOO5GIHJugZ1w6DfDSjAkHHiN+WvDfEzFkKLfop8hZHxokvVTDxU0kwAmYt2ReVIBigIgaYUs8eg268GzD7XgmXuaHdy0RMuRc4cu+3HE6Yz58BSxeVMdFIafzUUMmQZqZ8ShlG+mGFGQ1PifEaTKwpzNwvTeIdZ+BVNtyzd0YI2NLxYkYT4gtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA09AqJCQiZKl8chdmaz01pEi7FUSVLXAY2HPavpSWY=;
 b=OPSxcHlFPLLCLs5JCE0BdknVbqvA78biygbS9Y9hsXbNy6572opCeUyf0lqfQsA/ilkfwKN83r5gMNUYd3VswIER9qjn4GmEKASsbZMu7DSP2gebX4+Fffbl0FZ/+2uzn/oBT5B5zOA2SOWQb2qEW7EyjnMJBhyMI9BtvPkZf8gtlcKzu5JRJ9n71HwUOODzI88HjW+o/izql58+J8I2hTND7cc3Up6/bcziomzfuApMc393HtOdBtakGUbwCxkUVU9jjQ3ey/l6ynFWpMHfViyZwFT/gAEpptPj10E7iisIkfv1/br8HsG87pbkTARs0nxGb3h0ArDABlWqN0HxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA09AqJCQiZKl8chdmaz01pEi7FUSVLXAY2HPavpSWY=;
 b=sFlWkRWycahBbbM48ywzdHxGwMJhgEHBJRop/Z5T60NsKCJhzv8wybZH+4cFeLWj03BOkZE9m0izsSfBa4Qe6Gw/ZjedYCFuAZTqmpcfv9dssVQS2pFBy88o348LuEvZh11RATipDwE3G/cxPq5IOKerL6qsYIXb6tVtuk90egQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6947.namprd10.prod.outlook.com (2603:10b6:8:145::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 20:34:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 20:34:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] lockd: set other missing fields when unlocking files
Thread-Topic: [PATCH] lockd: set other missing fields when unlocking files
Thread-Index: AQHY8hNC3sPhc+haY0qhdJ9lwSIMWK4zSOCAgAA5BICAAEtRgIAAG/QAgAADPIA=
Date:   Mon, 7 Nov 2022 20:34:04 +0000
Message-ID: <BA142991-D8B4-4522-86B7-BC8CEF249F87@oracle.com>
References: <20221106190239.404803-1-trondmy@kernel.org>
 <2b5cffddf1d4d5791758e267b7184f0263519335.camel@kernel.org>
 <D25AE1CE-E8D2-4BD3-83DA-A5C3222C5E03@oracle.com>
 <3E5DCADE-432D-4CAA-88E8-DD413EDE3626@hammerspace.com>
 <47eaa40205fe86ca0418a4e8bed8a6ff9755571f.camel@kernel.org>
In-Reply-To: <47eaa40205fe86ca0418a4e8bed8a6ff9755571f.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6947:EE_
x-ms-office365-filtering-correlation-id: 7cae1f51-5848-4ed6-6387-08dac0ff6989
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: doQMEfneJLv4DpBoPK6NZ6WyVnxg17hdKnkT2YQC5tQ5qq0TV9/kcEVLX1K/gh87b3rCjoiildUVhhA1okBgxigu9pjVFM6ROE0QTyeShEv6tv4Yq4mXqdE+eKQJ79quEiGwiPPF+NjWkbrRLv9kuPtXfllKAIH3hooW0wYSRq+trBVkOXHdtWIdZOucG+AFJ1rrvti02WgsC8gGmHJKVTJsV4yrKEPCZw1buESjzbrtygijMhj0UwSbYGzQcj3ii03p9iKVEnX9efbZBB0iwzQ15GjtO9QH9+8hSaxfyQ6NbN3uutOCUu4tnqRGXLFlLihP2ovNHhwIUF5p2ERQsuI0gt1h5Ow3mh59ow+IOLAU5DG3qCVS1/9Vem5WIsX9zcfs9qCHmuUo+cJcOffhF/VOljgBtKcCQnzaqjyKNYpqZOm/1C6DknP3slFockwOaG15zd6smmjcgrq3ZecOKgAGNXB1xOU+19BlTqV33VknaILjgyVE7ur5iCWA3FqDUejt0IZo47E18R2dNX4rhzDIHBF5uU8pM0NAG/AIH66LGXLTw30Qy3cjUjPRMRIOd7izcmfswVQiKXR3ex4mE4oT8WZ286WThfF3K0b6i8ERMBkOmk7eg2ADOI4UorbEs6DkQrEUBw4haPmgBZAjg1RngbL/BHDNZvBDBoyqJGC3u+fjfB7qFYJArOWtrOm2fKmDO7In8sdbx1KAT4ie+8/P5URjgYvOhqZHvHuw3BDmlJjKQr+Cp7xD++rHmsv6v5Zj9f8lfBhcCI667QteBWfE3pf/kWR9w7Xz0kkRQ7nodxNgG1qrmjtCEQf+W6gsl2tKyUdsTwzYwZ2C/CFZZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(36756003)(316002)(54906003)(33656002)(86362001)(6916009)(2906002)(38070700005)(66556008)(66446008)(91956017)(66476007)(4326008)(76116006)(64756008)(66946007)(83380400001)(966005)(6486002)(6506007)(8676002)(2616005)(186003)(478600001)(71200400001)(26005)(53546011)(6512007)(122000001)(5660300002)(8936002)(38100700002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DmXximeIWOIsIve7+uBfxcE0PLr2DBTCeBYt2QGWym7UBaFhUOExCY/neMGw?=
 =?us-ascii?Q?1MNNjh9xUTHmhyLKFhcfJfMoZp8QjwwK00OQY7MbuExg8YqWbHBd1hNa26PH?=
 =?us-ascii?Q?RXn9EdnN/Tq5xHeG+82dElBAXtQFpDijhBzC/Yv2KaG/7b3rzVycL43A7jkL?=
 =?us-ascii?Q?CJesUcVxR1o6BEB1LicwRr1Rmo5YYzSFPxJfipyT07w7f2wmW0iiRc6roANy?=
 =?us-ascii?Q?LPJ9VV+CViIEE31SsJzuy/8/rp65J4Zss0X3Uo2yfL82NEnX2E0kpJUQVqUE?=
 =?us-ascii?Q?ePp70EMifIza+fWDqXQJRTjx1VW8zWtOGkcGpvq6mNlTTsy/x0IsikNpFFTE?=
 =?us-ascii?Q?rzZpoY0JvuUYEQV1cCp8+LLaTZRFvGn+5SRZHxVSCvPExl9znEkE08wCwhqi?=
 =?us-ascii?Q?sKpdplB1B2toFa6iSW6xAV1TOFj1edFU+vsMCM/WvCOz6gS8aLSWen9PPp7o?=
 =?us-ascii?Q?iAYbiTb2ZlvPVH1KUSg8FYozFvWYWzGVTmnh2EpLoOPukduPCnrO4pdLUBFp?=
 =?us-ascii?Q?WJTxiJR+OuNk9Zfuubeua/gDEc/f80wiSwS+HNwj4CVH0qzl8UiL6C5UcIoN?=
 =?us-ascii?Q?RKX2eB4KnFSUwfp9Oiu4D20BAVJRv7d3uRRFhu+TKFvOZmrnIiraNDyqoVgQ?=
 =?us-ascii?Q?w0+V9PWQkfCo5/8p1sJALvUbCUt+MUyVkI+GUQDUfg6q0LiwAXwlR1vCmZMy?=
 =?us-ascii?Q?EZhQ0Pr/e/37t/J9QFuLu+nJFG9XOSOhTSipDnquEa5Pg5CKYB2Mh5aCpRwG?=
 =?us-ascii?Q?oMlAngNgBplu5YAF0zZ50X5WbWPmfovwzuBp4q1TLxrjGakjCy8UIdvJjepu?=
 =?us-ascii?Q?7rBhgCf5NCnoMGLHvZzOXSZ0ipoEUHtNPmWXlw7pJiBBfV8tgNaJ6JPepmw5?=
 =?us-ascii?Q?RCx2UJZStebsiWWcALN9HbZSfSprbXxRT11RK0BnF0J9Bqy+WGl0UgJDttG7?=
 =?us-ascii?Q?kDyBTxYMQgxGlBbN0Ukpurvck9freIKVRibs79rIygwFebtX7YQVU0kMHGQQ?=
 =?us-ascii?Q?A1HtbZKQ/xaP4u1knmR+1OA6neCf5L8sgt3++RG5g6oi+N3G247KtlK292zs?=
 =?us-ascii?Q?DIoh5NtQT4HukZE2O14f2MOFspvN1apkS6s7mdSbLP56eyTTqIm1Ji09A+Hy?=
 =?us-ascii?Q?luewPGmwzQnvozsQF0YH2XkCvFSB/2oKWHp4wcWDHjNx9nqDs2KbSV1R1509?=
 =?us-ascii?Q?htGSf1eSdfOzwypoo+nGBiuH3CvkoTLEmJXvRhGwdX74cN9XytBCdV5O3Sl9?=
 =?us-ascii?Q?gUtnfjwDKb5pzwC5GUhQ7E6EYDkX85zV7/57VOLyKIJ+GBHk4mRFEM+Sge3Q?=
 =?us-ascii?Q?qw6FrFAFC72P9h6+Eb6ff3NGddkGz9H6sqiJTUOiiT5pqufydKkHa/J22VEE?=
 =?us-ascii?Q?gW7BWo+l4rxBqVC90hLfXS2U31tn4OwvN3wDXXUsH4LJgQYVzfPZRoU5mmnt?=
 =?us-ascii?Q?CeG4m56pULjvKwYeVELD2Fo7BIrO2cI2U5dJXm2fg/tpywmzY/727lTjh1Tt?=
 =?us-ascii?Q?82bsWgKpOjEz08OY4KL8mIHJHRmk3Vxh/oWga8I1V3PnOrNR3KPlcTY/0hEy?=
 =?us-ascii?Q?vJta4xa8VP8Ai1JeSThf/QnAfWSu5UR2FdoTViJbRMKhQrerM9d8tWsKlbqw?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E93E8064B684E64D8C7F92A727CABE15@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cae1f51-5848-4ed6-6387-08dac0ff6989
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 20:34:04.4903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrhFB94J59B5qAXub3L5V9+n0+68PNMIa3jBl97TcoRaZ6FNVmiA0Lb289JjLJdDdzYfNa1JnVueqeKykKX0Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070161
X-Proofpoint-ORIG-GUID: w9g6zjozSDY4yWJOpq6j71RdlzFp76_z
X-Proofpoint-GUID: w9g6zjozSDY4yWJOpq6j71RdlzFp76_z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 7, 2022, at 3:22 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-11-07 at 18:42 +0000, Trond Myklebust wrote:
>>=20
>>> On Nov 7, 2022, at 09:12, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>>>=20
>>>=20
>>>=20
>>>> On Nov 7, 2022, at 5:48 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>=20
>>>> On Sun, 2022-11-06 at 14:02 -0500, trondmy@kernel.org wrote:
>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>=20
>>>>> vfs_lock_file() expects the struct file_lock to be fully initialised =
by
>>>>> the caller. Re-exported NFSv3 has been seen to Oops if the fl_file fi=
eld
>>>>> is NULL.
>>>>>=20
>>>>> Fixes: aec158242b87 ("lockd: set fl_owner when unlocking files")
>>>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>> ---
>>>>> fs/lockd/svcsubs.c | 17 ++++++++++-------
>>>>> 1 file changed, 10 insertions(+), 7 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
>>>>> index e1c4617de771..3515f17eaf3f 100644
>>>>> --- a/fs/lockd/svcsubs.c
>>>>> +++ b/fs/lockd/svcsubs.c
>>>>> @@ -176,7 +176,7 @@ nlm_delete_file(struct nlm_file *file)
>>>>> }
>>>>> }
>>>>>=20
>>>>> -static int nlm_unlock_files(struct nlm_file *file, fl_owner_t owner)
>>>>> +static int nlm_unlock_files(struct nlm_file *file, const struct file=
_lock *fl)
>>>>> {
>>>>> struct file_lock lock;
>>>>>=20
>>>>> @@ -184,12 +184,15 @@ static int nlm_unlock_files(struct nlm_file *fi=
le, fl_owner_t owner)
>>>>> lock.fl_type  =3D F_UNLCK;
>>>>> lock.fl_start =3D 0;
>>>>> lock.fl_end   =3D OFFSET_MAX;
>>>>> - lock.fl_owner =3D owner;
>>>>> - if (file->f_file[O_RDONLY] &&
>>>>> -    vfs_lock_file(file->f_file[O_RDONLY], F_SETLK, &lock, NULL))
>>>>> + lock.fl_owner =3D fl->fl_owner;
>>>>> + lock.fl_pid   =3D fl->fl_pid;
>>>>> + lock.fl_flags =3D FL_POSIX;
>>>>> +
>>>>> + lock.fl_file =3D file->f_file[O_RDONLY];
>>>>> + if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NUL=
L))
>>>>> goto out_err;
>>>>> - if (file->f_file[O_WRONLY] &&
>>>>> -    vfs_lock_file(file->f_file[O_WRONLY], F_SETLK, &lock, NULL))
>>>>> + lock.fl_file =3D file->f_file[O_WRONLY];
>>>>> + if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NUL=
L))
>>>>> goto out_err;
>>>>> return 0;
>>>>> out_err:
>>>>> @@ -226,7 +229,7 @@ nlm_traverse_locks(struct nlm_host *host, struct =
nlm_file *file,
>>>>> if (match(lockhost, host)) {
>>>>>=20
>>>>> spin_unlock(&flctx->flc_lock);
>>>>> - if (nlm_unlock_files(file, fl->fl_owner))
>>>>> + if (nlm_unlock_files(file, fl))
>>>>> return 1;
>>>>> goto again;
>>>>> }
>>>>=20
>>>> Good catch.
>>>>=20
>>>> I wonder if we ought to roll an initializer function for file_locks to
>>>> make it harder for callers to miss setting some fields like this? One
>>>> idea: we could change vfs_lock_file to *not* take a file argument, and
>>>> insist that the caller fill out fl_file when calling it? That would ma=
ke
>>>> it harder to screw this up.
>>>>=20
>>>> In any case, let's take this patch in the interim while we consider
>>>> whether and how to clean this up.
>>>>=20
>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>=20
>>> Since this doesn't fix breakage in 6.1-rc, I plan to take it for 6.2.
>>> If all y'all feel the fix is more urgent than that, let me know.
>>=20
>>=20
>> It is relevant to fixing https://bugzilla.kernel.org/show_bug.cgi?id=3D2=
16582
>> No idea how urgent that is...
>>=20
>=20
> Seems like it's technically a regression then. Prior to aec158242b87,
> those locks were being ignored. Now that we actually try to unlock them,
> this causes a crash.

The reporter can reproduce a crash back to v5.16. So, it's a regression,
but not one in v6.1-rc. I'm trying to be more strict about that to prevent
quickly backporting fixes that have bugs.


> I move for sending it to mainline sooner rather than later.

I'd rather give this one more time in linux-next. The Fixes: tag will
trigger automatic backport once v6.2-rc1 closes. The fix is available
to the reporter to apply to his kernel.


--
Chuck Lever



