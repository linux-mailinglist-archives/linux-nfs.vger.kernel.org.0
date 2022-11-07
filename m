Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0622F61FDC8
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 19:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiKGSmf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 13:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKGSmd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 13:42:33 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2111.outbound.protection.outlook.com [40.107.220.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D30A18E2D
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 10:42:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM6CrwY7UgAQDIbxNHy0m6MtkgxgdzSV8TjHnf4IXYgKVpY4qb17TwdmFlfy7zRVc+i0+A07LOv3eTXOfzjIcfkieYqQfiYsnGOsYYWAY2XbcZQUXueX2XDVaQOYF7uDNELXDyRT/7oT9O5Xiwp0xXJlDnHv15JYmF5YLBkXKzg2rQCuBfcVUP5GVSJ2FfQ3ofCUX/YzOG9GXQaBnWmkHREVOkkOaR+w29VWlzbGpQJxRjAer6TQnPx+sUuI6hHoyGkjiehUAJilBRIM7amvWl07t7fFymBvinVUM73v5Kh3l8vTOrl5Ls+c+sL7f+wuh/FmvHOaPtOw8rC9+PQTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jL6Po3LqMe+bdWO+PIjAzHift1a0AXXYJvDbAJ+qM9I=;
 b=nv8A1BtiPhn0oJd03bzeWn8yfQl+/jHiaG0+BFnTrCbjSFfFD32H5DFjitUD/nfQNHFJJ2bvbcHX9WRmdbwJZ/1cX2T7hMviqGCOMkmSCtzPu8xIfVTe5MO0Guom/IRRAxOhVg4d4yxsOXoK0w5LaCkUapyx8mk2JYsrRxws2qUrN+g0ZYq/Ji0hG2x7oinj2ElD+Dt/cXladJ4X/rzkjm3vgpSv6tfjLrls4RMNFcpYiNXtjATtogkH+2kqIWS5BsCuINs/swkqBKE8Uh1UDRAd+CErw0vZ8dKTh2lQKPuQhDFUEXu0TynqRSOQqt9VGDFPV3DOtRqLkH29hmOd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jL6Po3LqMe+bdWO+PIjAzHift1a0AXXYJvDbAJ+qM9I=;
 b=NEKky4r4WcSlA6aPenLLyBB/Zt6zShE+4yrgw3XgtSZlSceACGftkR1c/qeOxKdAHA1nEVx4INZowiNIgFklMdTunDZxQlqauX8kVmZc5yDo2ZsZEd2drqKX8Eje7/e5YrNc7c1S7HZlrHvKsHnN7oBdDpMWz10RZiEtte6Z0xo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA0PR13MB3952.namprd13.prod.outlook.com (2603:10b6:806:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 18:42:25 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 18:42:25 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Charles Edward Lever <chuck.lever@oracle.com>
CC:     Jeffrey Layton <jlayton@kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] lockd: set other missing fields when unlocking files
Thread-Topic: [PATCH] lockd: set other missing fields when unlocking files
Thread-Index: AQHY8hNCCVE1uG9XTE231alNVaBdka4zSOCAgAA5BICAAEtDAA==
Date:   Mon, 7 Nov 2022 18:42:25 +0000
Message-ID: <3E5DCADE-432D-4CAA-88E8-DD413EDE3626@hammerspace.com>
References: <20221106190239.404803-1-trondmy@kernel.org>
 <2b5cffddf1d4d5791758e267b7184f0263519335.camel@kernel.org>
 <D25AE1CE-E8D2-4BD3-83DA-A5C3222C5E03@oracle.com>
In-Reply-To: <D25AE1CE-E8D2-4BD3-83DA-A5C3222C5E03@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.200.110.1.12)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA0PR13MB3952:EE_
x-ms-office365-filtering-correlation-id: 3d434330-2e1b-41ef-8bf6-08dac0efd088
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 86cuVhbPr1GH5HnKHjIgcPOGg3OeC3/3tLqowMy9lIjACXse2oGRwhtIKi/Amu71C0mTYRv8mTrqkhtmVZ7lAXx7Q6s9rFq9kYGBORF807e+o8trJqRddB5lHUmgL5GHrkU1qI3RADR+HhBj6HV+Hh+O58no6WNEt3NI2gbYq5REsltil2L2ZxzErOhAQuX0g2xgS4KgVvC4tub/ZL8AvU3TajjZJgs8QQPeE1/oOczalN1FPIHShD7EyOfaDSpTP6oFo+Gw9SgKBNjYBB0rINoKzwVr1VDCgKUJiAYc3pyU19rjwrMqFfpWkcsv1eUn8J7nvgfCZTdjaI5rTAGw2gRDsMuLduD4N6kHjrdVJ+vMl1u+59yyxSht8DrrvhVF49XDu23/gfqAAERx8O9q5WnLfw1YozsWf53rgKyjYDEEMda/WDRu9u/LkW71f2r73VL84rkIXt2GSEwFcX4I4480I6mt6ZMwUFo1V2RucS+IsIh/SLg9sHf+UdMcpSSnmaEzk+SHTp7UkIfUAc01xLoCaxgoqa/dv+Gu4ESxkiLdHju4VujFLz20M3BDJtq0HconBQ6S15obxuxj2wNkZYsKFH3dKeODWHmStOQNkooFBpJ/23qNjd3j0+2haxqRFD7th+vjAPt77eEkqlTCp7lrBXTE7PfTy9bcNNqIQj+kfZkLXxvN+SVIQJMhFvM9qxG0HLpNgnBjb41UZMoEhQAb3loUuHz7AJeUxbqM2vsq1BOyCyBXhh+OUNeLQqbBnpWSA0pDdj/gS4uAwzF4px52UZ83Z1I9HHyDUHoK0eJgAdG2XlIEThlHBoxqO5X0xFxOLvBDH5soTaJFfLiKQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(39840400004)(136003)(346002)(451199015)(86362001)(5660300002)(41300700001)(8936002)(6506007)(8676002)(53546011)(38070700005)(33656002)(66476007)(2906002)(66946007)(4326008)(66556008)(76116006)(64756008)(36756003)(66446008)(54906003)(6486002)(316002)(478600001)(71200400001)(186003)(83380400001)(2616005)(6916009)(122000001)(966005)(38100700002)(6512007)(26005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VJzwNL66Kg2ttrej7mBSB7wDg/AQIa7ogkqjltOkHEshBs5fOmjRvaLnQSfL?=
 =?us-ascii?Q?RbK4tSziltbU7ZINjQRLGIsWcpRl5B+KugwIJnX1vtli1DPVvT3hr2Rovtcn?=
 =?us-ascii?Q?K1JXTS1eCv3kpmYvLntbfAFwE/BNMA7JWRF3zmjOL3g2CVlARvwEt/wVd13z?=
 =?us-ascii?Q?ikhci5gqqDlKihfmpX48ev6w+de0yV4MSS3SioOSwINZ8v8yFgDl3Oo+pN6I?=
 =?us-ascii?Q?UdikyU6bO9rt8h9NQGrya8taZl7tx6JHqvLR686mHauFF9Sj8IoEkHGFmliq?=
 =?us-ascii?Q?ImqmDjmUiEk3Bw00XimR7luwvQgrwsb/i/gHXRZHa2puo8mGHCWtlbiUt+li?=
 =?us-ascii?Q?VRAEOi7vAcTZ1eRQcCZ69gUbGWl0ZfzB+HKugt+j6S5PxaJ1y9utABq/Z4hR?=
 =?us-ascii?Q?wRPfmpJaIdUV8YHDVuMUhrT9M3f8Ql+edgPRDNW1Ja/lT+valaOcd6CNRDnK?=
 =?us-ascii?Q?X2wXlv6/MvRlf+A/yiqx9xyuDI/eDpZBWhcKQgC6Mu87bNBgEgo4ctQZoT7w?=
 =?us-ascii?Q?GQMuDv0sNLVVBu0qMHbdlIwQSr4+NXi/umzjD83KyVqcBagke2/4EKDjjQfn?=
 =?us-ascii?Q?ibAfGVejIWaKD0ZcLQmvV7FW/74z5/2Oj99FEp1tSc4LX5SFZ6atblLV9va9?=
 =?us-ascii?Q?5ahYkElEEcqKFhML2sQG7CfHQ0XZz9FiXmUdpzKXA4//Uy9fRLggsvW47uOx?=
 =?us-ascii?Q?MAhWpvNR9PJSndnwl8rmGcI0jP3HRgMznUYIcFkM8pitHFKWoDrO+0whadH0?=
 =?us-ascii?Q?xXdC/ppVqLiFNTnWX4cKDCXYhIr8SWg4GvWYaqxVBC53S5R8momAXLnEfD1f?=
 =?us-ascii?Q?T40vkZVQhErbRpmpRFqbzlPglTf1sJq8VLckCOckUCXjHSVkl1csQ3EfGaHr?=
 =?us-ascii?Q?8V3SISITN4JG6+1ir6q2cIjzhoaoCsheIxbH7+T2LuYpRAq3FmVXSFI9BZM/?=
 =?us-ascii?Q?ODpSiABnsv7AizVwt3Oj7A0jyJE7H4PN/yLSfRyfCNEyZxbzNDXU7oLpcH3M?=
 =?us-ascii?Q?QzU3BpUg80rCXqOuNpkKBfaGnuq/0C+cDJE7qgDb0dMyZVX5BgQgGFJZxt9T?=
 =?us-ascii?Q?Q73dLAXVsqPqAQ4HP8ShNYf5AjfJ0rr11qz58WE9ozTozwjZNL9fEFd1HQC3?=
 =?us-ascii?Q?sxwq/cOjCAm8SCDekQrpRbl3z8sCYJArEXzg+Vin9q3Fd426yFthbXpda7KR?=
 =?us-ascii?Q?5Vp30qojJaoeJrPi4nTsYpvkeKeuEGiojhOU3GY0bnTC7Q/VqC9FBAaxc9jI?=
 =?us-ascii?Q?gSYa7QcNXYJ+j9t2s5U6ksgkVevZTuHSabtI5jVsqThc8+h5VDKjVIJ25BNY?=
 =?us-ascii?Q?0QMck0gABigKobbRgRxYaF0EcLT0LN/CPmADxvLehT3kTJM5huSc5V+IVnSP?=
 =?us-ascii?Q?8bHiUDj2Geo5LZVLmbGQKQimOEkLonlp9R5IWbWTez2wfBgulw9xap8pptSV?=
 =?us-ascii?Q?I8+kZYViFEGtXQG+fyN9BCFNhDwfe5v4xDfq8sZeMr1bUhRfEdPJigQ/e9jU?=
 =?us-ascii?Q?skRfCWb0uu0haASC5/abqAbEc+f2O70i1tuN/zv1Rgv1XqrSmP1B3HZBl9Ec?=
 =?us-ascii?Q?CSnGkYTusZDDsqzjpGul5vTpEp4sC6xqkl9HXOd8JEQzxf1KiFanUDzrRGsF?=
 =?us-ascii?Q?uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A20703830EF09C4EB70AA6C9FA596441@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d434330-2e1b-41ef-8bf6-08dac0efd088
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 18:42:25.4203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWn4SEjKUsbjvA8ynuKBRl5KinH5OJ7gLvjCZhHSHBteHdEhywFEVrcBF2Bdfw5Nec6F2cAc3QEIjI6IhGg/yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB3952
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 7, 2022, at 09:12, Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>=20
>=20
>> On Nov 7, 2022, at 5:48 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> On Sun, 2022-11-06 at 14:02 -0500, trondmy@kernel.org wrote:
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>=20
>>> vfs_lock_file() expects the struct file_lock to be fully initialised by
>>> the caller. Re-exported NFSv3 has been seen to Oops if the fl_file fiel=
d
>>> is NULL.
>>>=20
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
>>> }
>>> }
>>>=20
>>> -static int nlm_unlock_files(struct nlm_file *file, fl_owner_t owner)
>>> +static int nlm_unlock_files(struct nlm_file *file, const struct file_l=
ock *fl)
>>> {
>>> struct file_lock lock;
>>>=20
>>> @@ -184,12 +184,15 @@ static int nlm_unlock_files(struct nlm_file *file=
, fl_owner_t owner)
>>> lock.fl_type  =3D F_UNLCK;
>>> lock.fl_start =3D 0;
>>> lock.fl_end   =3D OFFSET_MAX;
>>> - lock.fl_owner =3D owner;
>>> - if (file->f_file[O_RDONLY] &&
>>> -    vfs_lock_file(file->f_file[O_RDONLY], F_SETLK, &lock, NULL))
>>> + lock.fl_owner =3D fl->fl_owner;
>>> + lock.fl_pid   =3D fl->fl_pid;
>>> + lock.fl_flags =3D FL_POSIX;
>>> +
>>> + lock.fl_file =3D file->f_file[O_RDONLY];
>>> + if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL)=
)
>>> goto out_err;
>>> - if (file->f_file[O_WRONLY] &&
>>> -    vfs_lock_file(file->f_file[O_WRONLY], F_SETLK, &lock, NULL))
>>> + lock.fl_file =3D file->f_file[O_WRONLY];
>>> + if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL)=
)
>>> goto out_err;
>>> return 0;
>>> out_err:
>>> @@ -226,7 +229,7 @@ nlm_traverse_locks(struct nlm_host *host, struct nl=
m_file *file,
>>> if (match(lockhost, host)) {
>>>=20
>>> spin_unlock(&flctx->flc_lock);
>>> - if (nlm_unlock_files(file, fl->fl_owner))
>>> + if (nlm_unlock_files(file, fl))
>>> return 1;
>>> goto again;
>>> }
>>=20
>> Good catch.
>>=20
>> I wonder if we ought to roll an initializer function for file_locks to
>> make it harder for callers to miss setting some fields like this? One
>> idea: we could change vfs_lock_file to *not* take a file argument, and
>> insist that the caller fill out fl_file when calling it? That would make
>> it harder to screw this up.
>>=20
>> In any case, let's take this patch in the interim while we consider
>> whether and how to clean this up.
>>=20
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
> Since this doesn't fix breakage in 6.1-rc, I plan to take it for 6.2.
> If all y'all feel the fix is more urgent than that, let me know.


It is relevant to fixing https://bugzilla.kernel.org/show_bug.cgi?id=3D2165=
82
No idea how urgent that is...

_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

