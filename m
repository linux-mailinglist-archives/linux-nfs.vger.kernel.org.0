Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B7761FFD0
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 21:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiKGUuq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 15:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiKGUup (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 15:50:45 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2105.outbound.protection.outlook.com [40.107.95.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A57F1EEDD
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 12:50:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWT4Of2OG5TEzw48x9Riaz5YeRKiS+CQr7lE2msMqyvtzDomWEGX62r1MP3UegeeVcpD3jw77L8dsZhVYdIh1imcClv1tQpdc1yq7hgE4bhVcEREXZbXwBy6RSgwRU1N88bQytcthSDpCRjj7eF1FVTa2fQtU6Kopy+LptzBS8mvU/K94gEBfPXDklqbv3u486nqkJpoUW0QaIhuocu/TuU2mg219wJF7/ZD3spgaCe8OtdnfQcxjdLZ/wKGITikQv6W4ATf1ACeZQZs/uTg5E3Isx/MqN+fUVaPgWXN4qJ4gaIrJVD/Fs1NMGRxfoRxlhDfjfbBTT9rzyf9KXVqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+yRsWbW94EgB6TW0OpEv4/2BnH3XVlOdGD/JIFMXak=;
 b=VVvN/QChvmZQFJv7kB/m69wRraUQ4mvy+2cLX1J2fRJHEdk1o+8gcrb9CVdRa+81Gbsq2oISnrUM9rGuuEVX0X/lVY1CUGv0nodr2qVPP/Wy6jxLTFlE88Fonx2+MKRhz0k4fm/UziFs7D8Ez25j6+25zND9Io5N3lKS0D2W28I+4V04fiGHKqs0PbXbdemQbzH/rPld8m5Q6SipOdYtrMG4hNAIAexm7XTjVw7oqE+w4SeQqp+hugeSA2ebaLUsFEAsFPUwUQ3BUMG+DmZtrxIb7slOZYmMnQiVddNpc+QHNSi7iAZzrLWmJ2XbTi0y+P3CSTki+VN10M7DQBDavA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+yRsWbW94EgB6TW0OpEv4/2BnH3XVlOdGD/JIFMXak=;
 b=FCum1SBXRLMXe5gkkPhPnPLGGBTSKnKsQ4YrhKLmqcQaEi339Zwqc5s8awdcgrUuaBKH13TFBMb0es6AQVxUXOhax1r2mVKN+WegxHV55/6gLhPcdVog9j09Mrbdb/kivWP4rCGu6NUtw4uEmeGeG+XgjeojfP/34BIw0Jc3ZSM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO6PR13MB5308.namprd13.prod.outlook.com (2603:10b6:303:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 20:50:41 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 20:50:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Charles Edward Lever <chuck.lever@oracle.com>
CC:     Jeffrey Layton <jlayton@kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] lockd: set other missing fields when unlocking files
Thread-Topic: [PATCH] lockd: set other missing fields when unlocking files
Thread-Index: AQHY8hNCCVE1uG9XTE231alNVaBdka4zSOCAgAA5BICAAEtDAIAAHAIAgAADPQCAAASYAA==
Date:   Mon, 7 Nov 2022 20:50:41 +0000
Message-ID: <B5475FC6-D839-4017-81D3-3BF4715A3EA3@hammerspace.com>
References: <20221106190239.404803-1-trondmy@kernel.org>
 <2b5cffddf1d4d5791758e267b7184f0263519335.camel@kernel.org>
 <D25AE1CE-E8D2-4BD3-83DA-A5C3222C5E03@oracle.com>
 <3E5DCADE-432D-4CAA-88E8-DD413EDE3626@hammerspace.com>
 <47eaa40205fe86ca0418a4e8bed8a6ff9755571f.camel@kernel.org>
 <BA142991-D8B4-4522-86B7-BC8CEF249F87@oracle.com>
In-Reply-To: <BA142991-D8B4-4522-86B7-BC8CEF249F87@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.200.110.1.12)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO6PR13MB5308:EE_
x-ms-office365-filtering-correlation-id: b01dc1a5-7fc1-4aae-3d67-08dac101bb8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3g8fOjwT4oHnazDC4LKJ3gEqoxjILx3H6tnT1QLFmRi0pSDUbTFHPFCDWzEJpbWxrYjSxPrRPpi2UauFlk42+DufUS8Cu+O7+n8SWqVAgqUuV8wAQrtvK7YHViLTwnKdr6PfgHzWVYVtzI4rnHNJyte4m8ZDUfyjGw9ieWwBOR5aH3gmz+zZoLKDMc19zJoJvHpdT38MpMlxdN84LLn0JxGPOD3BOef8z36GOXTH+P0BRM802xS3mNucfbM4V5nElkvYdXx4h1bO/oLnH0wPXwg1gNZYX+hr95XesbXJSWOIAG9loD7ubiMkUktTA9rH1tPCXW5BVLlH3xuOINhgcnLioRxU/Rc6aslbMB4rhbLxE6Wbdx7sUAiPAp/bHUFRGdAJ5UV0o3rlQOUAp+xpD9GtOWQXbLCAlz0fZx9jX6tWZ48ikvuvmOz0rIVcCkPztpSS89veTGuiPd1ukB75HvZd1v1uBNUdfM/WUjqWb9xhvOfvztWfVpL2j4h8UGwkesoGemgsu4Kxv89gh2KYFIMKuz/KJ/L5spyZoNBmWP4QhDwqr4dpk9leYGVddaB3RjshM6md5jkjzModPsod3mk4VHLx15TKn6pAQrjaPvmfzOzw4uzGL233o5mME/qvcyykdR69SYOVakhXfl/omKPDMw4QSZspwkpfvAq2ht5WBExzYfhCiHCbLufKZmja6M/Vp+HcN9onIRqj8fndrgmdgQUdSLvDNwOqQquABNYqbr2crzuOkYD9KewEqDLKxU9CyYoaLrCTwq4T0usbbJuh3PsZ+m1EcI/Plo045nCa8t1ZFsYUAI2i8AuQxn6ZHprGVAzajUdh7PYZzwBFfbPeptu+hH+iVs1Pp1tf8zcKrYk3NWUDQCeHMMkGCQuE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39830400003)(346002)(396003)(366004)(451199015)(6486002)(5660300002)(478600001)(71200400001)(2906002)(8936002)(38070700005)(41300700001)(33656002)(6916009)(66556008)(66476007)(76116006)(316002)(54906003)(66446008)(122000001)(38100700002)(64756008)(8676002)(966005)(86362001)(66946007)(83380400001)(2616005)(26005)(186003)(6512007)(6506007)(53546011)(4326008)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YUzhk8ULvqDTwxY/X/SR9pcoQyvNd9tBj2Co7X5z3c7hK+6sIOjBT0k1cKoU?=
 =?us-ascii?Q?bGAwT1TtMGXL4yWv9OSBB84ObW5muMPlGEhNR4hB/zUK3frrUlNRDqiSDCuu?=
 =?us-ascii?Q?T4AFUbns+wtqsw7T9kYxhJ32RmDTe1ZQLTtRQP0yB+Jdx/Ydi2GkpTsovEG8?=
 =?us-ascii?Q?4jcVCFsAUkP5Yqf4CQtBf6if8THp2bEY9GWWR/yV7hTngE9O0ajqk4OIiLYb?=
 =?us-ascii?Q?qISACldo2oL4sr5cOJluyGV5xforcFY2PAhH2DLN62JzOOr+LlU5PFckFTbK?=
 =?us-ascii?Q?glDb1R8f35waCDa3j5sFcO1jj/jty2uvf3rggGfmVQxgtDdQdwoXM7wGcrKV?=
 =?us-ascii?Q?vcuXqbHiWm2xyMYvNNRKq/86jhPlYYpuGgBLWtgG6+rRjqNJa55Msu1/abOf?=
 =?us-ascii?Q?WPJ4Pj9QF8vwGZcKYjdjVWTRyiSNbANHEuedvUf9v/9NP/QssvnVF5vc7c/W?=
 =?us-ascii?Q?yborDtjrUFQnT6B1fRrVq/p75BTHonHkBPqK+HNkqKeczvsP0oz2+ajobnkl?=
 =?us-ascii?Q?wxJsNiCjaCW4CMKAAKknUrKMo8/8uOgsZxFCguZmORHKa2k4AtjDoYLf527E?=
 =?us-ascii?Q?JdpYpn+uWwjEUQz6PvwjFr4m4VUJdvFhq5ElAfY7XfIlzmOuCqUZ5SBghAXz?=
 =?us-ascii?Q?SzpOPRO/JJjfnoxEnfEl7P/Amv7BenwPjv0QbJumw4myfYvPgsvYrgIMcGRf?=
 =?us-ascii?Q?29cHX9tf9D+61OxbWedQQEhanT8tX+RQqWEqdPNiV3u/IveZLFMvDxSu+TcJ?=
 =?us-ascii?Q?SOQMZhMhhmebJ6PslXHDjhfLu0yCTklAcTGZC7xjXk9WLXLnRUGg6t3R+ZGJ?=
 =?us-ascii?Q?VaYRe4WNlDBJCdopMH5+bvqSlxtRzeccoiC3hGF4XzkcKIp+qBXudaYItbV0?=
 =?us-ascii?Q?IKTzmSeXHV3shGJtHwde/yxMMSlMXpET6c56oKroGxiI9KC+6Yx9gv6QZT5s?=
 =?us-ascii?Q?0Gg3b9a+W4KmB6sEb7stQ90U67bxNYJzgHAY1AfwS3zygwF0lnWp2pT1qRbM?=
 =?us-ascii?Q?syL5pzUFJxLceDGiAKaft1SkS8B0+6guVFPae2PsVVn0ntI09DT3B3sMYyWs?=
 =?us-ascii?Q?J32MaEv55sgewyRWvjb1QgIT8iCxEjpUl9g2boD/tu9mY9i3RYfhYGXRMrH9?=
 =?us-ascii?Q?Okr8gqKurbuKgX5ZuegbqgoUdyxLwbdHV06q3kd1Nwp1TNt2T11T/jq2dFHt?=
 =?us-ascii?Q?KTWuhbNcJ+WdgdTdt4jIos2g8n9awMmYJzVDOSnT4Zv8L/aSa5//x9MfrY+p?=
 =?us-ascii?Q?Kcoa4qyerUfA+JM+3YhAAWBsLr1XD+X2brEhtOOBMjKztdaHnA9HvGD1WGnF?=
 =?us-ascii?Q?weHb9i4v9Q5oa5DhSwBfrOhtsascxnxL06vAaX5AjT+6B4/nbG++CFmR1zDp?=
 =?us-ascii?Q?cJSSVYHMunTX40INIPovCe0x2jxDwIDRiw5xLWapYDMU6/sv9ekQq2BHh033?=
 =?us-ascii?Q?oCR461rMp3KHpm1loT64vuTnT/FZt05JPrrowNriRjeZnfx0HBSboYTHv+1N?=
 =?us-ascii?Q?I0sg7Uo5uY23NUN2k4l/8ydHH4946Bg7porZ55F2LtNTWXLvV2ML4vwQLge7?=
 =?us-ascii?Q?5RqMeZhMzMHp/qiJdYBYLOPU1u1DKzabYAyRqJ63/pBsvalM/DkH8c5fJUd4?=
 =?us-ascii?Q?xA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0A8165847A3ED41B838315D61C66BA3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01dc1a5-7fc1-4aae-3d67-08dac101bb8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 20:50:41.1576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iboZBPgGVLwWVrN3YMLMO5OfmsKNu7EJ4q1DHdj3+aDbj4lF2G6XXI+Lti2N970cXGEJXr3HPMLqmzf7c+c9/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB5308
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 7, 2022, at 15:34, Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>=20
>=20
>> On Nov 7, 2022, at 3:22 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> On Mon, 2022-11-07 at 18:42 +0000, Trond Myklebust wrote:
>>>=20
>>>> On Nov 7, 2022, at 09:12, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Nov 7, 2022, at 5:48 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>=20
>>>>> On Sun, 2022-11-06 at 14:02 -0500, trondmy@kernel.org wrote:
>>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>>=20
>>>>>> vfs_lock_file() expects the struct file_lock to be fully initialised=
 by
>>>>>> the caller. Re-exported NFSv3 has been seen to Oops if the fl_file f=
ield
>>>>>> is NULL.
>>>>>>=20
>>>>>> Fixes: aec158242b87 ("lockd: set fl_owner when unlocking files")
>>>>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>> ---
>>>>>> fs/lockd/svcsubs.c | 17 ++++++++++-------
>>>>>> 1 file changed, 10 insertions(+), 7 deletions(-)
>>>>>>=20
>>>>>> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
>>>>>> index e1c4617de771..3515f17eaf3f 100644
>>>>>> --- a/fs/lockd/svcsubs.c
>>>>>> +++ b/fs/lockd/svcsubs.c
>>>>>> @@ -176,7 +176,7 @@ nlm_delete_file(struct nlm_file *file)
>>>>>> }
>>>>>> }
>>>>>>=20
>>>>>> -static int nlm_unlock_files(struct nlm_file *file, fl_owner_t owner=
)
>>>>>> +static int nlm_unlock_files(struct nlm_file *file, const struct fil=
e_lock *fl)
>>>>>> {
>>>>>> struct file_lock lock;
>>>>>>=20
>>>>>> @@ -184,12 +184,15 @@ static int nlm_unlock_files(struct nlm_file *f=
ile, fl_owner_t owner)
>>>>>> lock.fl_type  =3D F_UNLCK;
>>>>>> lock.fl_start =3D 0;
>>>>>> lock.fl_end   =3D OFFSET_MAX;
>>>>>> - lock.fl_owner =3D owner;
>>>>>> - if (file->f_file[O_RDONLY] &&
>>>>>> -    vfs_lock_file(file->f_file[O_RDONLY], F_SETLK, &lock, NULL))
>>>>>> + lock.fl_owner =3D fl->fl_owner;
>>>>>> + lock.fl_pid   =3D fl->fl_pid;
>>>>>> + lock.fl_flags =3D FL_POSIX;
>>>>>> +
>>>>>> + lock.fl_file =3D file->f_file[O_RDONLY];
>>>>>> + if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NU=
LL))
>>>>>> goto out_err;
>>>>>> - if (file->f_file[O_WRONLY] &&
>>>>>> -    vfs_lock_file(file->f_file[O_WRONLY], F_SETLK, &lock, NULL))
>>>>>> + lock.fl_file =3D file->f_file[O_WRONLY];
>>>>>> + if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NU=
LL))
>>>>>> goto out_err;
>>>>>> return 0;
>>>>>> out_err:
>>>>>> @@ -226,7 +229,7 @@ nlm_traverse_locks(struct nlm_host *host, struct=
 nlm_file *file,
>>>>>> if (match(lockhost, host)) {
>>>>>>=20
>>>>>> spin_unlock(&flctx->flc_lock);
>>>>>> - if (nlm_unlock_files(file, fl->fl_owner))
>>>>>> + if (nlm_unlock_files(file, fl))
>>>>>> return 1;
>>>>>> goto again;
>>>>>> }
>>>>>=20
>>>>> Good catch.
>>>>>=20
>>>>> I wonder if we ought to roll an initializer function for file_locks t=
o
>>>>> make it harder for callers to miss setting some fields like this? One
>>>>> idea: we could change vfs_lock_file to *not* take a file argument, an=
d
>>>>> insist that the caller fill out fl_file when calling it? That would m=
ake
>>>>> it harder to screw this up.
>>>>>=20
>>>>> In any case, let's take this patch in the interim while we consider
>>>>> whether and how to clean this up.
>>>>>=20
>>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>>=20
>>>> Since this doesn't fix breakage in 6.1-rc, I plan to take it for 6.2.
>>>> If all y'all feel the fix is more urgent than that, let me know.
>>>=20
>>>=20
>>> It is relevant to fixing https://bugzilla.kernel.org/show_bug.cgi?id=3D=
216582
>>> No idea how urgent that is...
>>>=20
>>=20
>> Seems like it's technically a regression then. Prior to aec158242b87,
>> those locks were being ignored. Now that we actually try to unlock them,
>> this causes a crash.
>=20
> The reporter can reproduce a crash back to v5.16. So, it's a regression,
> but not one in v6.1-rc. I'm trying to be more strict about that to preven=
t
> quickly backporting fixes that have bugs.
>=20
>=20
>> I move for sending it to mainline sooner rather than later.
>=20
> I'd rather give this one more time in linux-next. The Fixes: tag will
> trigger automatic backport once v6.2-rc1 closes. The fix is available
> to the reporter to apply to his kernel.


The regression occurs in 5.16, because that was when Bruce merged his patch=
es to enable locking when doing NFS re-exporting. The workaround is therefo=
re to mount the NFS filesystem with -o nolock on the re-exporting server.

That said, the patch is trivially correct.

_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

