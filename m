Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D4E62017F
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 22:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKGVzv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 16:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiKGVzt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 16:55:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A4DF024
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 13:55:47 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7JOU9d025616;
        Mon, 7 Nov 2022 21:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=e3FNZHMwk2iH7mkwT9/WtdBzXRohwgONQrTrKq1YOug=;
 b=uJ+3uaAHW5EHG3dMSt9imop1QMPw443YBUunJRaivmIagrSN3xy2M/xzBumWol/qAtWG
 EexykEvGp3+sZ8g6S60s9NvcaPXIWqux9ooFFPQKtG1PuCK0JLvNZqbPADxFtBHvGc5+
 KRtXh+SslKMUNR+ZOJziwsx+LJ5LnZt5ZxIhkadFb+8l19CLRKTLYIDANJ7IU34GWOO2
 8n+mE7iSZAPel2nphpDopkqosniAhqWp6VjIabwp1Em+9gLoOpTgxQK7T1x9yLYpM8ez
 kegPILVQEfxsxcBaxbbw8lVMy8b2QRBpSkvwhK8d89VmH+x+bSpxO79Z62pDSrn2fMi3 8Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngk6djtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 21:55:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7LBP0m026243;
        Mon, 7 Nov 2022 21:55:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqf9nj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 21:55:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiNQvrTFRA7zj19n8d6LvLl4bfTLPyMwxq+O9Xz6oNgK1XBd8fSOWXmo0YEMCJF6JoppPE6xXNjC9QPD/hfTFuGlphbA1ZX18bmMRP7PXqLGbkmnmCUQYyrCHcd9yztEBhTRXM6+/6x9dgEDWYz9sVvq4GGjvxpdB7Z6P42OXPGTsQIb+CGGQfgTdaaAdeaOCS7hV//8uSeJeBO/yjPpgNLejgJlheAvfNhASn/17NdMSvTPJs9Pii5RqIIF0A04/rJoeu3Sf65ixWla6QflFA2kg183T/nZQA3pL/HeUEGDsUfRb+tsDXF18u7zZP1RDkgO160OSnZxKTkORT8GHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3FNZHMwk2iH7mkwT9/WtdBzXRohwgONQrTrKq1YOug=;
 b=kibcv1aTqsYpj9vKHqWtBZgdZNHUpIuB1xAHWmZMpMQ+vhJKiEMoimKSTAKga8Vn9UxEQoqVfxw2bZ26jFrdOeiYDrpYQKr8Qw6FCi8CoIgZ1npAF35XFESDzf5LTlg5E5oB1jDmUXTgh507o77TlGcwznkQVaQAUEKOrFEUuNAyYih+JhWhxRV+SEdT0XqEBlt4q5dJDP34SJvPUxvWTfTV3gC1eKOX1FiXWI3MZ4z8/9Zf1e2kmXsa8EldnfF9P+iT2k34xZSVAtVwdfoU4s9cYukznIuVBIxekk2anoBtDxLituj90VwoUvzhc41sforZSr5sdIccHdu65W4r4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3FNZHMwk2iH7mkwT9/WtdBzXRohwgONQrTrKq1YOug=;
 b=WwmrNK9sKVhlWvdoLt3rgwob8cWls8qEBk5WKAq9nlEigUMJfMI05yr/mbTlxVh+W10+YxY4d5aUA2DUTRtVzvccrsgkrE6rxEukCzrX2qHKDSqtfpHWCPI3n6V+DZbfuyR97XyAUVA/eyzTIh60P91rFTmVdUYzx7gZutjLZGA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6208.namprd10.prod.outlook.com (2603:10b6:8:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 21:55:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 21:55:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] lockd: set other missing fields when unlocking files
Thread-Topic: [PATCH] lockd: set other missing fields when unlocking files
Thread-Index: AQHY8hNC3sPhc+haY0qhdJ9lwSIMWK4zSOCAgAC6TgA=
Date:   Mon, 7 Nov 2022 21:55:37 +0000
Message-ID: <6D002058-C292-4F77-A1B7-C943B3A203C5@oracle.com>
References: <20221106190239.404803-1-trondmy@kernel.org>
 <2b5cffddf1d4d5791758e267b7184f0263519335.camel@kernel.org>
In-Reply-To: <2b5cffddf1d4d5791758e267b7184f0263519335.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6208:EE_
x-ms-office365-filtering-correlation-id: c1f7ed6c-796f-4d74-25a1-08dac10acdb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XOTm3tMNQBRKN/ZI4YonK4hFo7EpFuMozjTwh5MrumQgt4SQhhROVRSVs9+HhkG72HlZX7PbyJkv7LKrdgrCChGwcby7PzZUOUALkvyVjzShUEjX3TcCKrcYtz7ZOZAdT4LthZcJTAfNY1o/QEmUelMykpu3rpYngUlyYqvlwdt+UhNj2mDnGv0eI6QoHD5egblsqv6/3pdv40jk9BlMlusFjoEEEER3diwKCohzkcQ0ZWOLyz5EqvaBltkrALvYy0iKyRpO5B8BzHlUQ1N44RF59Ub2DsT1d6AO2koPjEHDsnF5ye2EQ9DCW7zHwX3qwMHesz2apfybY8NkaQhIzWP332HTnEATySwdIxXD8hWk1OXYX2zoLrvjYNyfLLbFyaC0iL5zUujhFSGOW8lOd3qedFujaaQq6x+lADqltgSaOYrQRIq2zzkFVBCm+Et81Fqs0ThZuWiDdXI93zczFutrSnxxvcaV4NufEH0XI59j3H0/RU3QnsxveSkKpjbY/gQduIwPlFwVlDp3ExG4Gel8yUrhST99ZvBoxjdGE3yf3wwMDIb39HcA0iSyDMTJylPWZhGNYzpEQJh/FYkxXF5ADG4EV3J3KgrdlLb/a9MfhFjM85v17aWdkngS5Wlj9CS3ZbU/X7nqJKLpgYfneYvAJmWE8nD5g9KtnJFyixT0OJfGt4B4BcNdV+kZOU/JAiQaxLmWERptdTRqppyf89e8FUXGJEI68/GoXjHc0FTzhWJ02lsQzpnIjKLn/zxyKBokkeLAzXo8VP1FA6zkm/MpqrmPDdN8EmFpd9ClSRw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199015)(36756003)(33656002)(86362001)(38070700005)(2906002)(26005)(6506007)(2616005)(53546011)(186003)(6512007)(83380400001)(122000001)(66446008)(66556008)(66946007)(64756008)(8676002)(66476007)(478600001)(110136005)(316002)(4326008)(8936002)(76116006)(91956017)(6486002)(71200400001)(5660300002)(38100700002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mp8U7gRExPcQ+M8/9Ub48Sm4n57+3tTisMMnU2ySszIGObRq+4b5Yl6ZFIIE?=
 =?us-ascii?Q?KikUg/RdYPanypMk7vegSOpe1uE8/1D74yOsxXTf+NVX5v0hafNVg0OPDWB8?=
 =?us-ascii?Q?WkBQEYdmQ5Gsw4bWnyWs3v6hau4zXHA26APUmvT18hTB8MbD5VIkxLzpTgBj?=
 =?us-ascii?Q?FZueLWBL2ILFUUNR03ZBzjfXQTfHsC6yONBr4f2e5bm67CDKev9lIeeXZDDN?=
 =?us-ascii?Q?C4yx4hMAy9gHWGtCdVpLyp4ckFWeu9MBaW9tlnxM+8OySTa3VxULSFBV+0/x?=
 =?us-ascii?Q?+yc2O5nTNL7WgjYSfmdnXsUpPL4eMgaQcx5ql9mvG8ZU7hEq2ImGu3wr2U2T?=
 =?us-ascii?Q?KlXb73ht55m53zDhP8MVmOdyFsYi6B2Q5zmKlIa7Si3jr3RK4PuZUgbIP/hc?=
 =?us-ascii?Q?9PcqdkEjBW775lQXmvAIFYIWrh6Ssb9CEtThqVDd7atMHek5hKWrYDP2hguR?=
 =?us-ascii?Q?V8tSYnCYqN1L+TpsMqzkm2F/f0pa9ANz8QdqgmTJ4L6bszOx3PGmKxGo+dwQ?=
 =?us-ascii?Q?1QgiJwb366V8oHjFLxQXkVqB6pU1Qj5skiaQ3AQRRYEnxOmKz00QXxBiwype?=
 =?us-ascii?Q?ozDCca/y1OtZFB0JFCyfWH5Kz5MJ0hyr7xq1GL5ljptD7tg1vTHqz0LOsXgx?=
 =?us-ascii?Q?VrSn/U2YtdZ0B8yiTbKWeJcJekj9rVAyF8tW0cl6hdV95QH47Wq6F8qQqGJD?=
 =?us-ascii?Q?01ALXGKqxthuqU6/Apb5u3bgKJA3PlnZ84xWtP/pglgt3MA0LWdiRkJDBZgn?=
 =?us-ascii?Q?AvIh+3ckLsV2F8yar3YHjRc8MvF7fooj96WH/H64Srf5SA59w6u7XnACzy3Z?=
 =?us-ascii?Q?dpC5w5p9YnaRV8orMM0DZweOD50ydAtK3OaD6OB30tza19U5fNetLLkv6c+r?=
 =?us-ascii?Q?IySb8tsSHkCCX/84E43qipC6KtugDvvLVP4j0ixnpYqUajVzwdAfVish9Fdn?=
 =?us-ascii?Q?g0rp8KcxviBJGVDwTB3XhsRDKp3loSAEwMWadevsFIjCy/gQXzgvwNngE8pg?=
 =?us-ascii?Q?CPdfn4OS77/i88eAczQljsrPsGuMcqSocGFoyI7eCeLTa4LEAAljE8ZtfN/1?=
 =?us-ascii?Q?ltaV1AIq7jZ8rCNukoGOWIXx1yLUXr4Gl5ID1I6ISNZ4cSw/Yyxr4us2x/Ti?=
 =?us-ascii?Q?LliQ68MmFaO5rYo6ajt7SJEVxeB8OBWvticinfA+QOZHMNZN1aQfWAeuY4mf?=
 =?us-ascii?Q?1xGCh6w0kYZXjxExd7cK7huPVoCrb8RNm1309TON9PtwLHVHpJvY5WBPuVqF?=
 =?us-ascii?Q?Hc3qnzH0629HzpyHu7z/dluiplNqOfWCGISrIjjTjnxmqPpsdluRSKm2wV1X?=
 =?us-ascii?Q?VwRQkthMaGU8rfgjRvi8U6ojA+t94jifO4jzaCgfCZ+dTdldbi2RrPD0cgxR?=
 =?us-ascii?Q?tQVyLbrIdIJ4ONIlJR+sa2x4WIKRXXOUoMwjUlthxkUegiMYe9NLkEHIwBmz?=
 =?us-ascii?Q?n+RFIX8ZrEmnn+IIzAyOdcOl8q7YZoP6T6IoCH0RpJB0QYS9T+Me2HwAmsXp?=
 =?us-ascii?Q?P9qaXffrDVaSv76jgOUW6YhBSKaL2/pwKIzGjWmC6MTgRkfiT08j7R5fPcj4?=
 =?us-ascii?Q?mRYHbU0x6+E7I5gbVBhxl+48Ox/22aUjODPgQlF7l/iLhn/wAr0DoNGPP7bc?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <42C8252F731AA34FBA304C39E2FEE0EF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f7ed6c-796f-4d74-25a1-08dac10acdb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 21:55:37.0821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEP9aAtjUct7lYIcT5my7SklmCOmLVgf8jqiGjpMmUSgfZflOpXnGXI4gTMF+rzoAVHearpSPUz0Lgg0d1d46A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070167
X-Proofpoint-ORIG-GUID: UlylcG_yYGbIPXHmZ39agXv7HV2vGOG9
X-Proofpoint-GUID: UlylcG_yYGbIPXHmZ39agXv7HV2vGOG9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 7, 2022, at 5:48 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sun, 2022-11-06 at 14:02 -0500, trondmy@kernel.org wrote:
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>=20
>> vfs_lock_file() expects the struct file_lock to be fully initialised by
>> the caller.

As a reviewer, I don't see anything in the vfs_lock_file() kdoc
comment that suggests this, and vfs_lock_file() itself is just
a wrapper around each filesystem's f_ops->lock method. That
expectation is a bit deeper into NFS-specific code. A few more
observations below.


>> Re-exported NFSv3 has been seen to Oops if the fl_file field
>> is NULL.

Needs a Link: to the bug report. Which I can add.

This will also give us a call trace we can reference, so I won't
add that here.


>> Fixes: aec158242b87 ("lockd: set fl_owner when unlocking files")
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>> fs/lockd/svcsubs.c | 17 ++++++++++-------
>> 1 file changed, 10 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
>> index e1c4617de771..3515f17eaf3f 100644
>> --- a/fs/lockd/svcsubs.c
>> +++ b/fs/lockd/svcsubs.c
>> @@ -176,7 +176,7 @@ nlm_delete_file(struct nlm_file *file)
>> 	}
>> }
>>=20
>> -static int nlm_unlock_files(struct nlm_file *file, fl_owner_t owner)
>> +static int nlm_unlock_files(struct nlm_file *file, const struct file_lo=
ck *fl)
>> {
>> 	struct file_lock lock;
>>=20
>> @@ -184,12 +184,15 @@ static int nlm_unlock_files(struct nlm_file *file,=
 fl_owner_t owner)
>> 	lock.fl_type  =3D F_UNLCK;
>> 	lock.fl_start =3D 0;
>> 	lock.fl_end   =3D OFFSET_MAX;
>> -	lock.fl_owner =3D owner;
>> -	if (file->f_file[O_RDONLY] &&
>> -	    vfs_lock_file(file->f_file[O_RDONLY], F_SETLK, &lock, NULL))
>> +	lock.fl_owner =3D fl->fl_owner;
>> +	lock.fl_pid   =3D fl->fl_pid;
>> +	lock.fl_flags =3D FL_POSIX;
>> +
>> +	lock.fl_file =3D file->f_file[O_RDONLY];
>> +	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL))
>> 		goto out_err;
>> -	if (file->f_file[O_WRONLY] &&
>> -	    vfs_lock_file(file->f_file[O_WRONLY], F_SETLK, &lock, NULL))
>> +	lock.fl_file =3D file->f_file[O_WRONLY];
>> +	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL))
>> 		goto out_err;
>> 	return 0;
>> out_err:
>> @@ -226,7 +229,7 @@ nlm_traverse_locks(struct nlm_host *host, struct nlm=
_file *file,
>> 		if (match(lockhost, host)) {
>>=20
>> 			spin_unlock(&flctx->flc_lock);
>> -			if (nlm_unlock_files(file, fl->fl_owner))
>> +			if (nlm_unlock_files(file, fl))
>> 				return 1;
>> 			goto again;
>> 		}
>=20
> Good catch.
>=20
> I wonder if we ought to roll an initializer function for file_locks to
> make it harder for callers to miss setting some fields like this? One
> idea: we could change vfs_lock_file to *not* take a file argument, and
> insist that the caller fill out fl_file when calling it? That would make
> it harder to screw this up.

Commit history shows that, at least as far back as the beginning of
the git era, the vfs_lock_file() call site here did not initialize
the fl_file field. So, this code has been working without fully
initializing @fl for, like, forever.


Trond later says:
> The regression occurs in 5.16, because that was when Bruce merged his
> patches to enable locking when doing NFS re-exporting.

That means the Fixes: tag above is misleading. The proposed patch
doesn't actually fix that commit (which went into v5.19), it simply
applies on that commit.

I haven't been able to find the locking patches mentioned here. I think
those bear mentioning (by commit ID) in the patch description, at least.
If you know the commit ID, Trond, can you pass it along?

Though I would say that, in agreement with Jeff, the true cause of this
issue is the awkward synopsis for vfs_lock_file().

--
Chuck Lever



