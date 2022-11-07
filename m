Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDECE61F504
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 15:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiKGONA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 09:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKGOM7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 09:12:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B1E1BE94
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 06:12:58 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7DKdno026866;
        Mon, 7 Nov 2022 14:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+pSD4JvHlAjJfK1Kivz46vBU+obpZHb8ueQeAmoEU/Y=;
 b=h3aDZQOvQ74rDxIzeBjGqTxvXnaG0QPaemEBUoF2wbiietpbTVy5RvcnS6nphJJSnR1j
 OvTMO2REEagxoAkufk9AeV+V3IEak+5Ej1s/o7RxBFHBhyWbbhu1iAJ1D5N5JoC0nwWV
 a7tpqfarlpY5qNmQW+zSf6Aaz+Mn4A0eX1ivnq4gge9kTFsAFKbajRygASKfSEeF/xYa
 2CYNtiQGDHTpvmocBaJ0OlDXKKpZ4LNp2q5kYOCumFXgiEz1OD2qhNLHbC42FnXwkCoe
 nTrBHPFpTwrAbBnMy+GjAkR2HvgrVUf2db7kGesDRPnTkYngQ8wfx22pD2Gs638YzuQl /A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngkfv145-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 14:12:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7DNpU5022763;
        Mon, 7 Nov 2022 14:12:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcymjtgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 14:12:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NODe9p9tFDIkaiRHgOHwQmoP3BpDacKRDSa/7Se56bVMPxA25uedwZuO948d6rhaoJoCzVWNUk7HkQQLgwF5qbApveIUWur1FEav1g8POR1s1k08s74vy7jhQf3op5Xsn3u0E3BAb0cYWpOVFP2nccttJjHd2P0tZTACFFSWlJnrtX/99V354BAmRSvK4VoPbalgBq9R5RgNx9HiBtAUad6bLh1s+2b4gSgQGzgF/cf7q6XPcltwqkuxvuNjdXB9c0boeRr9tGP3gKrQA8K21ho+LmS3llY8vYqvPuqu7l4pAMq7zJcLW7nWkMefUGAO5QIriRkyO8xx2KognPLlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pSD4JvHlAjJfK1Kivz46vBU+obpZHb8ueQeAmoEU/Y=;
 b=LiBXjSYfMoPQzJgN8Una6T6LDmlI8jzE2lbSFKPhBbr3xaoeP3opfZ1IMGFA9vD4L5fx5TiJ/7rYjWmAty2CMR67zXrZSe6P/u3K0SskktwgONJDrYaWbNvaORL+uj3Zky1sOL7vhQ9NzWGKpmSRAfTDEgWM3sAdb844zmoBuim4R4wlIeO0L3k/DRsXXAe4umWjOxvES3yEuE8PqQcC6+hGqLS2LydwY9uwPoNvLSV/Nx0Jv0fFnqMxJt85ScQ0GL5+RAZ9SThi42UH0vqD4rY6EhiCBirYZIqM6BTDi6ZmK1TvujOzWZMR64i/W7x5jGAct9fap8dJ1O1IiOchpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pSD4JvHlAjJfK1Kivz46vBU+obpZHb8ueQeAmoEU/Y=;
 b=jxm69p3UXNTH9TdoFNv0TvKIqDBlNA9vY6HmqZY8q4yFD2PNWiKt9tPaImF2rgdRrIKGqcMtb0uAq4kGgZ+h5EzzgiVgGW8qBlo6D8jFMsoLddZ6icWoUkFnO7wqyK7Fghk3trzxrRSiL311BjBMfSI5njVEMry4q4W9mFxqfWk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6815.namprd10.prod.outlook.com (2603:10b6:8:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 14:12:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 14:12:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] lockd: set other missing fields when unlocking files
Thread-Topic: [PATCH] lockd: set other missing fields when unlocking files
Thread-Index: AQHY8hNC3sPhc+haY0qhdJ9lwSIMWK4zSOCAgAA5BIA=
Date:   Mon, 7 Nov 2022 14:12:51 +0000
Message-ID: <D25AE1CE-E8D2-4BD3-83DA-A5C3222C5E03@oracle.com>
References: <20221106190239.404803-1-trondmy@kernel.org>
 <2b5cffddf1d4d5791758e267b7184f0263519335.camel@kernel.org>
In-Reply-To: <2b5cffddf1d4d5791758e267b7184f0263519335.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6815:EE_
x-ms-office365-filtering-correlation-id: 3cace309-f3a3-4e02-c521-08dac0ca285c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6e4r6CxOLirhwy0hQXrAOD5bpeSuKm5OcKwNiA/MsFbSKqFjk4VgsO5gbfuv9BnN4XQQEvxOQdzsPQoYoq42sO//huLw+4CuYYVQz7K8UHY9yfBjTXTyMm0BKQq64PaO/Qtornvt6zRQBwzmcqgLcnviXrfPKNcyCTjTIDaLHKS3jHv0nerFb94AgC1vZrXqHxqDmWfVnvoYMJmKMRDDhG7GjQ8beMne5Wjigif4cWl94W3RjfsRZ2IVt1WaHXzJ64ixO8ZsQKFMGMvoK1hR1DVgy4VQ5CahpyEBrMNZBU0lNK1PieEH+yF1H6jwloKQGppZDggHlOQxFRp++tAfVje43jtUUhQM87p3PK0ftJKKwqzkD7BhOviodbfcKbI1JvFyxDK59M29KrWwGUokU5kmouc0ZHUgQN2jKJGY+xTbEs0y0cjUWcPcu6QGsoiOqZfp1UWpFRbN/jeW2lf9H6TYyhSoTpOtwsZ0dVltB53Ri6xN31/Bv7Uro/yyUzVQyWOMa3jVK6C5XAE/eLXCNfDIdvm03qiPGyDZxW8REfYTHqEi+NpTmLRlmNs0whr5a75LlL5fdBkmntJ8fzQpURKWbCW1YhHwiD2VjRR7MMHwklcaREmzN2jBrImUHBzyarYAyly6hl8PgFKO3dGbPbfXBD8BjWFhbXGr1jQy4cDpTdpS7c2FlgVrOaheCmS25ZBVY2SvuQ0OHUnFeMsG+UfurDZ1/8njI3Kxf0qDAnIlgD+mreH4b0aNZw3E7pkoQAVu580Bst514QLu0ZmExkMgG12kfUg/14sfXcvj2vM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(2616005)(83380400001)(33656002)(186003)(38100700002)(122000001)(38070700005)(2906002)(8936002)(86362001)(5660300002)(478600001)(6486002)(26005)(6512007)(53546011)(6506007)(66476007)(66446008)(8676002)(66556008)(64756008)(91956017)(76116006)(71200400001)(316002)(4326008)(41300700001)(110136005)(66946007)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kC//4sK6neLm9xFP6qNfaBttxWWGOxCURmWNcux5JQ8oNrbeUW+bdYeU+0Fq?=
 =?us-ascii?Q?tq9FNEHI0BEd7WU7gmO1jyQ6M5XaSnHmMWQx2iaYGksECHvhbnRqn/KuPyJU?=
 =?us-ascii?Q?FXv63+n7kWB/SUpzZDWJkHWWtQl2VhenJaATNmaQIlk/bWQxq9Pw5Dhakytz?=
 =?us-ascii?Q?oWqpQuMbS7Tdh8JGGr+xJvbdo+67wzE7YBO1ueZXmPcTdnr+1/FPZVfM29u/?=
 =?us-ascii?Q?Tm0QwgDVR4f7VMS26Fl750gGI1vabPy4Yg3KohQLeYzugzHR2VKa/s86/R+z?=
 =?us-ascii?Q?ntAB1G7zmoYfzBcx7eUzAk5FOkxg4g4Lo23nrqUFXcFDRBNdX7zpv0iBD+Zh?=
 =?us-ascii?Q?TZ3SLLgcYi0J9pokQnz/zasXSIU2RlgMw6Pe5itde8tv/FoN3dbXinoG5wii?=
 =?us-ascii?Q?u3q32u6wQN5VQ/uaFnV8MNgyjuD+9qYcweYPeO/V9q7UMzKuBdO2YmYaD0xk?=
 =?us-ascii?Q?t6fpgPVcm0EZ50pKk3X3Ulz8t/KzkI4LIVIPz3v5mX02bpe9u+OBgguL5TxN?=
 =?us-ascii?Q?MjXMDjpdD8MiSlBYlAvyVxsS3LfLtV8OsUN4HdqoXEyZrPzJYSw3hOxPmNdG?=
 =?us-ascii?Q?gs/AjVV2iaTnAfQOmBvTwXVtrvrKeK+6cGJ7WqfiqIq3pPQjSbv5UgFDaUwi?=
 =?us-ascii?Q?8zaLbclcoh+fJHtiVi0hXT1Q+Df40ZORSFdMSZnv1Cm3IV9TKK8hAEqfCcMZ?=
 =?us-ascii?Q?ot2qP0367TjNF/jVZSwmZXrYn8T4TOJgFBPQOKOZAZsyLkJ8i5xlBFPYHYuN?=
 =?us-ascii?Q?VSII1TujeH3JlbDE0RulH9htnHYIa9stlz0K3Jf5cPSJAPvhyh2UZPUsxaYn?=
 =?us-ascii?Q?qBYd4Ibz2QQOCU3YvkGsKJun7lkgBD3gSkj7XRcFTAYRBaSYFmyWITdgUoW6?=
 =?us-ascii?Q?jwUd8IOXfu9fqCL507h7ED3Unq+0L+OWEK1PZA3YaftyMNpgZFLklvhesRk8?=
 =?us-ascii?Q?bjhqR9sgrpCyrmjck1FO0V3W+wChmEtcKDEchQezcR18edr9DdJLSd1NcAx1?=
 =?us-ascii?Q?X7K8mmUFmoJOFMV/sZE4Meb5HYyY2YHhC6sRrtjSX7dBOQdwkaj3f0NGBLsr?=
 =?us-ascii?Q?1X0+Q1sjo45Uk3/EJMYhQEKw08Hzt8B6XJ7IA4a6G94pHo4MW0lMdGwWi7ER?=
 =?us-ascii?Q?nnhoiXWkfCc0fArZR0MNl6BEpkQUqmtWjIq6V1a8qKpJMRTYeOik++toogW6?=
 =?us-ascii?Q?kbHf+eqj2JtbWCXXRCFLgAaw3i/1fptZayUMLYwn0CaGt9ihotxt4+CSJ0ko?=
 =?us-ascii?Q?4mZGbOcZywFOginA8CJjjZLjol2az0XFgQ2D4BKBltmoDo3GDBzJDqGAYXE2?=
 =?us-ascii?Q?oWykYDxUAxAvZd3Zj1yfJg6TfHBK1fC2TB2jeghkqZlyop/Z3SGvnvgB1s7N?=
 =?us-ascii?Q?4Ec1TKl/J3BOQjqsRhJisaV4OPLN39heCp4FIXe+SstBq4C1wEEXPTWhX8tB?=
 =?us-ascii?Q?Jum0FvfXoWpgqR9Y0gkKJGCifWTgIO3bK6LRJjhknTK5dPjBS65t4yTdGTRn?=
 =?us-ascii?Q?u1nvuzL7ZWMe7iUqBnbhHfAeOFQoIJHJW8X9tHFVmZ5OC2GaDpkrNFhGKOKG?=
 =?us-ascii?Q?l8pkVMdlpE4k2+Nhj2uiG0+45dw8hHFj9fW6EGddZfTpxGCJGGulxGwF45f6?=
 =?us-ascii?Q?+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8B118D220555545A3E04689C8A8052C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cace309-f3a3-4e02-c521-08dac0ca285c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 14:12:51.9128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfZTy9dTClxEVY0zTBIeE1S3A8LJKYF+6qfoCxMNs+zhTizA7fuVLBIcVsv/qSktdrR9e6jf22rrRcDguETOKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_06,2022-11-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070115
X-Proofpoint-ORIG-GUID: KddrMzRw_SHumLeQEBWJb3oTElZS2sHZ
X-Proofpoint-GUID: KddrMzRw_SHumLeQEBWJb3oTElZS2sHZ
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
>> the caller. Re-exported NFSv3 has been seen to Oops if the fl_file field
>> is NULL.
>>=20
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
>=20
> In any case, let's take this patch in the interim while we consider
> whether and how to clean this up.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Since this doesn't fix breakage in 6.1-rc, I plan to take it for 6.2.
If all y'all feel the fix is more urgent than that, let me know.


--
Chuck Lever



