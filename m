Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA9E6218CE
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Nov 2022 16:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbiKHPvR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Nov 2022 10:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiKHPvQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Nov 2022 10:51:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C46858BD1
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 07:51:14 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8Fnffd011819;
        Tue, 8 Nov 2022 15:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ki1cmQ8Io1YiGMfKszEvCdlm5D68K4VWsV3mPOxJBjU=;
 b=zeyrZTMyVWZSNPXVsQH0h3UZ3oUZhUQL6gcmHHr6HusSKEw2OXQeLpbw3ADsWYXGI7H9
 BQ4Ca4ZXhRmsA7SMX/Hc9yPP9ghSqRNeBN3g4WK3LUX9hncWLq8ou2Hhpkhm48rgwghH
 J1XMCW3+bmsuzzKyRH9WeqNCvPAGOBcJFVKk+IMzfVeebV47BGvkWSmrnlm6EBAQl3Yn
 3Lh/Q+zKZfNTebCotrAtd04x6ZjxBWgRUW+owJPKiOKvA1rU7K78JP/HXf+7ebsehe/7
 8UyFCj+crVraZmd4YIMODyaFt8Zr2s3+tOuaIs6l1Qo23hFr/CT8NTvaRUlYTYubtHLL 5g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kqsgy0562-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 15:51:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8D2iTR030126;
        Tue, 8 Nov 2022 14:58:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctkfv8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 14:58:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzHPA2mmXqGIXVTVVlgEf1+f6X+21aTneef+l8yTlsgpvd7FQgqpuJ9xu7/c9eZfqYe59WVWgvXDr3suki/EtJwYMXe4AaDUi186JZnBqhux87FAbNiPcrx5cEGi+BW+qmdLFtjo2YYsYAkdFdMl5lkpXsJldGfRn4xuFmB8g+Oay5VFwk/IkLq4GIiDDxJoqUSRDjtaPz0VebCCuq7F4rJ/QtXK6SXh5qPHm6mgCann8hLzuVLGmTUG1EGHIxX+fNq1IUUD7Cnp+dMQ+Qq4bUNaAgG1Sa/e0/nCz3ZO1VgNdPCsxzXqxbykYuZFUFoC9CIb6Ag9x3HsEyTV9qNTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki1cmQ8Io1YiGMfKszEvCdlm5D68K4VWsV3mPOxJBjU=;
 b=Oylz58rEm5WAEuYr4c7i44oPU0xBJoWccb6/rl+CTosu1TzBRbrVORMXuPqJy0niMh58Ucrg68qalo09qoA4mnKe0fT7g+O7HsFbPB2Ei0Kj8GHALCd2TqWHBUDT1VgNa9Ok3EYF2vkXx9v+w0JqA8Y6G8oIsliWhxCmYB5Hj8tFahwOovlqfqXByap1kT1JHVwV2lvaCKuZwhEcWDGJys5lTZKdISh2bSIrl8Q+yMPX1UKCEGTuxOZouexoiZKbWypA8aoHMdd2uNxsNmWOPuWIWB+aguonm4kzdlW/rIpDEZw/3HcYjrZcvMARDFjlggYmEvdoErXkAOzqq8xquA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki1cmQ8Io1YiGMfKszEvCdlm5D68K4VWsV3mPOxJBjU=;
 b=U1I4iZmxE1GC8G1LSZRRCrERIOEd3ppnCMosCQjeCpn5mRazpfKhq3eaykJMPOMYC5gIw4kU2MUJUAXvZm1QJT2T4YKiWd3rrt99Q86sqwe/sVrS8dzNUbvZO4OpkOmrcF06fUeE3zWBRXbMzDTJ9oWJKaJkUQ7cvUXm9/bTadM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6163.namprd10.prod.outlook.com (2603:10b6:208:3be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 14:57:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 14:57:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH] lockd: set other missing fields when unlocking files
Thread-Topic: [PATCH] lockd: set other missing fields when unlocking files
Thread-Index: AQHY8hNC3sPhc+haY0qhdJ9lwSIMWK4zSOCAgAC6TgCAAR2kgA==
Date:   Tue, 8 Nov 2022 14:57:58 +0000
Message-ID: <B6C6DFDF-3AEC-4BAD-8810-76A47824E282@oracle.com>
References: <20221106190239.404803-1-trondmy@kernel.org>
 <2b5cffddf1d4d5791758e267b7184f0263519335.camel@kernel.org>
 <6D002058-C292-4F77-A1B7-C943B3A203C5@oracle.com>
In-Reply-To: <6D002058-C292-4F77-A1B7-C943B3A203C5@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6163:EE_
x-ms-office365-filtering-correlation-id: eec29897-8bce-4ba9-56e3-08dac1999fc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elt+HsDl+zaRjlU3xgJ2Qm9yVoxCUAvodH0BqhEVK+4isiLJmm2ofYNwSY87h9m+Fcgmj/Nkbrz+vXNCVddy0WVCLsnzjYEILzs6S2vNIgMhrl/FxyGYTxc9CBM20JRSOFsCl0Pa/Y2Bg6U/0sPmIQE4i52XbdQyX6uTfAUGOIMbhIBKBl8+m/XGzTd3du5C70O65FtE3CKOovhauy6ihtzm67MQdrXXAZ8K1VmW0P7dtpcDWLXNVxDFJNlWMgXKWLWvpmQmJsndMfHk6SKstCDFYSrWEoQhdUXbdnlBxB4NLr1+/oeNyJJDiJ/cwV3XhPYd+rnwUgAXD3WThh0gypfdZFlzRnDyN5GML6Y9I64vKtBmfK/u2jzhT2Vw6zVOKItaXQEGajsfuKm7mWiQEr/yFpja8Vt0gRu0XVx514Dm2N+XyKU6cvVvTi+nFkP+tgfd22DeIJxT/L4tBx/+97iUkN0v6qllwQjHDojulgP9G+5oG5N/3XHESNj/Umf0h8jfHH40oXVAKttaFu1RYcb3rDD5TOn6zgu96rGx6ZVyXs4zDw+UCWQ/Bi+S4+VxvZGKXysQnOXVoClJRG5MFhr+Hlirf70Fi6IUhfvsdoHmnftRvvLVdet9SNayLNUX0ILiSMkoslkA5kExFauxMoiHQvSdDdgS6+MBrwcgrBkpFH8C2EW0ViEq9XyHHAPNk8Ez9wSPD3bagAs6pN2RdoTIiciZdR8+lD/OkKe59Hg6hKbke3XMQzFqpAStD96Efb2Y+cS2BcMS4aSQKMiUrZcdwfc4iKsWtfHRVBM+UAg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(83380400001)(86362001)(66556008)(122000001)(38100700002)(5660300002)(38070700005)(6486002)(66476007)(8936002)(41300700001)(64756008)(4326008)(8676002)(66446008)(53546011)(2906002)(6506007)(66946007)(6512007)(316002)(186003)(2616005)(26005)(91956017)(76116006)(6916009)(478600001)(54906003)(36756003)(71200400001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6LXy2Q1aa/4FBPA8fa6QRX6wtjyMGeQNd7ou9qcGukUcdeuzwBbAEydKYPq1?=
 =?us-ascii?Q?MjX9tIVhJYAhNrRpH16H+inJInCdy6iNKTaVIMAKMGpXzo8lS71IX1xBJlak?=
 =?us-ascii?Q?80xUTrRTvLqLXd1B6fYHPqtBbjRx0eDnr3N6IqQP4VbKrEHhvMLDIdA2yHgo?=
 =?us-ascii?Q?fA1UmIFazJihjd21ehEOlWgFlh6fZZoTXjL3KxFPvxuxUsI12FSlo3xryRlZ?=
 =?us-ascii?Q?O6sI/xyg/zKfv4Kmyj8NzJnlecDWe8THjQ0MG32xRVzPPPhkx27WT56dhI78?=
 =?us-ascii?Q?eLb7RKHKpOI+qIc3CuWt/++KKWvYjoME+7UPX9+6KYjljLAoHsco7YXGE4hh?=
 =?us-ascii?Q?0PtXCdD5hBnC6pkXmP3ovH3eIIOcAOCL4BhvvEv84tc1fR1u3KjmKCWGSdtT?=
 =?us-ascii?Q?lpyfeh0ED36fZLpTSe31nQfqWemWnpXDmJ4eF1Tkw7Qhd4LLUVxP/8xPf5TA?=
 =?us-ascii?Q?8h8q3WaHU6lJIHPfDWSzDzrzBSPUxHqNAMEesWwdqZzDUmJBiqzXyXVZEuCZ?=
 =?us-ascii?Q?9Rb59ylZi8Ep/j/XqK9eXXE8OF9xKc0Q5sNHPyfL3i+YZqXD61NvRUDTWYMm?=
 =?us-ascii?Q?s64o61NsHXpBOEy/tqxhYKgEssGh+emFSptCcdbBvEslfkc1O7X2D0+f6j73?=
 =?us-ascii?Q?HPGjSWvktpBMs9dC2cO3zFM6MRfU2Os8y9EneButLwRmZYn6XLMcI29IJhNc?=
 =?us-ascii?Q?IIn14PjHYQAgWuyvLMuWPeo2rPXxUI4109gSiLBkpUslfDlsGbjEn+KZ9iCT?=
 =?us-ascii?Q?n3UDeaIyqxA0MJx/DQUM83FKzKVqJDc3CfJxBffKVBXLdqGqyhOHEG4cZIhK?=
 =?us-ascii?Q?FVRywyu4xQCwVXi/4xPIM7eG6wHbTJFJd0GMr68VtNNv+kducio91ELDv5+7?=
 =?us-ascii?Q?dmb4G58fENHvS3vO9no2t2+3bDmP+CPVcKhFMNxglUHpl+65OzqdjzDVrv7u?=
 =?us-ascii?Q?ygi8k71lwuwTugQq1Bo/wwMZdezyJ5ZOqnjH5Ys7NWS1a++luzFqPdFbDit6?=
 =?us-ascii?Q?zCopS/Msgfd10b/nY/p8mpkd/0ThSIV6JBRHe/7vCPxNzSjE0Cm5oIaawIlx?=
 =?us-ascii?Q?4Ixm5+71wBJo0Xr52EC8U6jFivk7zpFYmJK2J2dRN5SEUq4ukiX81SilGgmV?=
 =?us-ascii?Q?fFnC3wPRAF6jkLX4STiv142OxXdbvk0CQf8VMwh4XpYfhxQXF+6cV0ZHnyBN?=
 =?us-ascii?Q?1B8SO2+uFP1T/9CGaRmSskbmDLKOX8uKDiDKxR95IGGWaKbbJpE/TSBwEZ8G?=
 =?us-ascii?Q?MurcJHNr+D7hrjbtT9MNuydAsFbIbdH49xy5s5O2PPGkmUWD8h4UZP69hiWZ?=
 =?us-ascii?Q?qafkYMpQVi/YMhFvwRQ2ru5cGV0/01DL/uUMSca4HuBhM0eJJ7B5K7ldtoGn?=
 =?us-ascii?Q?bxf1u0/sKzA6QZsQNacBh1VsCG0nXeAlrkMpzfZl3Ng3aDBj6ffBvGEnFQsE?=
 =?us-ascii?Q?7YkWA602YwXSDhVUYH8PBZ+FezKjQNYeNu330pU2c+bQgam6d64NydK1KgDc?=
 =?us-ascii?Q?yeFR8CqVSXEka6y4itPRiNN77NTddCI+jVr+PHrSBrFDrWTwA1V/km9qxnXv?=
 =?us-ascii?Q?P9SRPaojfqv++mXr4pkFD2hSJxZUrJc2TPjSfYn4ukaZm0A8l/GMFizLCEUj?=
 =?us-ascii?Q?Hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <675B4F11BE5F414CB043D4020E9A6EA8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec29897-8bce-4ba9-56e3-08dac1999fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 14:57:58.0807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lwkTSN9dTT3ATzkFrKwNcRhjMw0XD8AwAzqRWcaVWQ5mkAG3j+ypu9RtnA4M14/mcLh+dopQDHs0dgu8LCDuHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080091
X-Proofpoint-GUID: zLpXwDNU-2hhjBnem8cEwQ3V49xbNXZg
X-Proofpoint-ORIG-GUID: zLpXwDNU-2hhjBnem8cEwQ3V49xbNXZg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 7, 2022, at 4:55 PM, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>=20
>> On Nov 7, 2022, at 5:48 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> On Sun, 2022-11-06 at 14:02 -0500, trondmy@kernel.org wrote:
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>=20
>>> vfs_lock_file() expects the struct file_lock to be fully initialised by
>>> the caller.
>=20
> As a reviewer, I don't see anything in the vfs_lock_file() kdoc
> comment that suggests this, and vfs_lock_file() itself is just
> a wrapper around each filesystem's f_ops->lock method. That
> expectation is a bit deeper into NFS-specific code. A few more
> observations below.
>=20
>=20
>>> Re-exported NFSv3 has been seen to Oops if the fl_file field
>>> is NULL.
>=20
> Needs a Link: to the bug report. Which I can add.
>=20
> This will also give us a call trace we can reference, so I won't
> add that here.
>=20
>=20
>>> Fixes: aec158242b87 ("lockd: set fl_owner when unlocking files")
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>> fs/lockd/svcsubs.c | 17 ++++++++++-------
>>> 1 file changed, 10 insertions(+), 7 deletions(-)
>>>=20
>>> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
>>> index e1c4617de771..3515f17eaf3f 100644
>>> --- a/fs/lockd/svcsubs.c
>>> +++ b/fs/lockd/svcsubs.c
>>> @@ -176,7 +176,7 @@ nlm_delete_file(struct nlm_file *file)
>>> 	}
>>> }
>>>=20
>>> -static int nlm_unlock_files(struct nlm_file *file, fl_owner_t owner)
>>> +static int nlm_unlock_files(struct nlm_file *file, const struct file_l=
ock *fl)
>>> {
>>> 	struct file_lock lock;
>>>=20
>>> @@ -184,12 +184,15 @@ static int nlm_unlock_files(struct nlm_file *file=
, fl_owner_t owner)
>>> 	lock.fl_type  =3D F_UNLCK;
>>> 	lock.fl_start =3D 0;
>>> 	lock.fl_end   =3D OFFSET_MAX;
>>> -	lock.fl_owner =3D owner;
>>> -	if (file->f_file[O_RDONLY] &&
>>> -	    vfs_lock_file(file->f_file[O_RDONLY], F_SETLK, &lock, NULL))
>>> +	lock.fl_owner =3D fl->fl_owner;
>>> +	lock.fl_pid   =3D fl->fl_pid;
>>> +	lock.fl_flags =3D FL_POSIX;
>>> +
>>> +	lock.fl_file =3D file->f_file[O_RDONLY];
>>> +	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL)=
)
>>> 		goto out_err;
>>> -	if (file->f_file[O_WRONLY] &&
>>> -	    vfs_lock_file(file->f_file[O_WRONLY], F_SETLK, &lock, NULL))
>>> +	lock.fl_file =3D file->f_file[O_WRONLY];
>>> +	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL)=
)
>>> 		goto out_err;
>>> 	return 0;
>>> out_err:
>>> @@ -226,7 +229,7 @@ nlm_traverse_locks(struct nlm_host *host, struct nl=
m_file *file,
>>> 		if (match(lockhost, host)) {
>>>=20
>>> 			spin_unlock(&flctx->flc_lock);
>>> -			if (nlm_unlock_files(file, fl->fl_owner))
>>> +			if (nlm_unlock_files(file, fl))
>>> 				return 1;
>>> 			goto again;
>>> 		}
>>=20
>> Good catch.
>>=20
>> I wonder if we ought to roll an initializer function for file_locks to
>> make it harder for callers to miss setting some fields like this? One
>> idea: we could change vfs_lock_file to *not* take a file argument, and
>> insist that the caller fill out fl_file when calling it? That would make
>> it harder to screw this up.
>=20
> Commit history shows that, at least as far back as the beginning of
> the git era, the vfs_lock_file() call site here did not initialize
> the fl_file field. So, this code has been working without fully
> initializing @fl for, like, forever.
>=20
>=20
> Trond later says:
>> The regression occurs in 5.16, because that was when Bruce merged his
>> patches to enable locking when doing NFS re-exporting.
>=20
> That means the Fixes: tag above is misleading. The proposed patch
> doesn't actually fix that commit (which went into v5.19), it simply
> applies on that commit.
>=20
> I haven't been able to find the locking patches mentioned here. I think
> those bear mentioning (by commit ID) in the patch description, at least.
> If you know the commit ID, Trond, can you pass it along?
>=20
> Though I would say that, in agreement with Jeff, the true cause of this
> issue is the awkward synopsis for vfs_lock_file().

Since Trond has re-assigned the kernel.org bug to me... I'll blather on
a bit more. (Yesterday's patch is still queued up, I can replace it or
move it depending on the outcome of this discussion).

-> The vfs_{test,lock,cancel}_file APIs all take a file argument. Maybe
we shouldn't remove the @filp argument from vfs_lock_file().

-> The struct file_lock * argument of vfs_lock_file() is not a const.

After auditing the call sites, I think it would be safe for vfs_lock_file()
to explicitly overwrite the fl->fl_file field with the value of the @filp
argument before calling f_ops->lock. At the very least, it should sanity-
check that the two pointer values are the same, and document that as an
API requirement.

Alternatively we could cook up an NFS-specific fix... but the vfs_lock_file
API would still look dodgy.

--
Chuck Lever



