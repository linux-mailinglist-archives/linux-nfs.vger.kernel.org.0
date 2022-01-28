Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533B549FB07
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jan 2022 14:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239256AbiA1Nqw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jan 2022 08:46:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62084 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232870AbiA1Nqv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jan 2022 08:46:51 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SCx002023376;
        Fri, 28 Jan 2022 13:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CMFkUujYyDqY/wh74PdJfJq2p3QJFVSVLuYcMyb1K3w=;
 b=nCae72ppf0fsvwnjBiECbh7NDwHs5axQAkgzarOZaFw0n2o9kzIs1sIbR5TBoIV2miAx
 BKmY3cMTXmIZhwxVVQKFEQ1MvJvbRbWZ9yUS1xVgKjPu6P/MtWdIp/X+fA5E7FSI0fD5
 T1nBvZ5HoKRxVub6byV0dPPb4GSGdqKL7kwgoxgKRX7IF1CNW2L6sj9imsPIvaMLt8pu
 utI72N5WQSo+bsbnncgdK0Rzi4BxU7hfsadGXeihPsWbVTGRkjpN/3Nn7/T7GnOpygoQ
 LuW9dCZiKjIUXH2GO63NL6SVBY8gwW6/j6Oj3tm0fAeWPwlHwcZGLkyaXf9iHb7IpE7C Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvquubqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 13:46:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SDfp1J134091;
        Fri, 28 Jan 2022 13:46:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 3dv6e4v0mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 13:46:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKVy4GEbRZ9QPbNpTvOFC+WC6m7TNv+QbRvoOqUx4Pvy7QzmPXoTXqzVhKEcjEIMNWHm5SUXqXDVzhJzTe4NLCfCtXT3Yte7KtQTikG0YxheWdpEJ/MGyau4MbOXSY1Yj7kRTbysu8AjEzVAEYqw3mzYwMfrSkMGffX0xliBECh0aEzl9yVXjSbP4F0VdfnFtlFzqDLonb3Tj14/q311FvPpwvBLFU9yL5Bkj/sUO54wccYzlWJG/VJr58CIKOCgvcJ2DR2KgWaI81lRaXO+2YNagdxWiz+E9gSf9AvzvROZ9atVlTFYg305OdR6HFAKCzN9SVxXaYQ7uoiT3YViNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMFkUujYyDqY/wh74PdJfJq2p3QJFVSVLuYcMyb1K3w=;
 b=baA93eUCLqS8JZ7bJDOF14o/wDLZ1MTwWd/5+aynKsbMbgkOtgtzFbMfIApHvuh1Kg5wgoLdGNbbzNB6EiJ+ktZ/07ctOTM2kP1dJ/eJE5+UywK3ajGGhbHW3qhDkYki2BcEXlvSKAMrEUYBEaG5WVXjlJ2q+R2K5NPTNrjaITcB6wOgJLIZWYi/4q5e6VL93/388bfyL82R9UzlWCk4HCHG+gFvReSfzS7/BTjNSutCPazsFFug6wXe5EeAi80kf/lowhvO4Wt5unZ3RI+6xD009zFgcdSDHl9VNskqo2omhSWZJbJ8Bl9HsNbzkURFm9+pjOc5zwOxQ97zyNgJ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMFkUujYyDqY/wh74PdJfJq2p3QJFVSVLuYcMyb1K3w=;
 b=qvBmzeZC3nlDuZTQRVkSneGUWiLFiM0V82TMj5Z7rPgV5/+tMGAKiNZNv/X63vVUv3XkOCxRbZKXEnVx0KOPKYCGZUyvzUnIMLElUw7zyIY4HDtQ6O9XchsJt2FCqBveh4k8kRsPKH/dk172netgPe0X/RZ/nF8RAtrkCpPQ7gk=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BL0PR10MB3444.namprd10.prod.outlook.com (2603:10b6:208:73::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Fri, 28 Jan
 2022 13:46:45 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 13:46:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] nfsd: allow NFSv4 state to be revoked.
Thread-Topic: [RFC PATCH 0/4] nfsd: allow NFSv4 state to be revoked.
Thread-Index: AQHYEzqzINafEUb13kObHCDc0cTYeKx3GDuAgABfVQCAABgdAIAAR7yAgACdGgA=
Date:   Fri, 28 Jan 2022 13:46:45 +0000
Message-ID: <C462D2BB-BD5B-4372-B644-FD4D6D877072@oracle.com>
References: <164325908579.23133.4781039121536248752.stgit@noble.brown>
 <7B388FE8-1109-4EDD-B716-661870B446C7@oracle.com>
 <164332328424.5493.16812905543405189867@noble.neil.brown.name>
 <A933D67A-0C1B-4700-97E7-0DBEF4458A77@oracle.com>
 <164334386787.5493.637178363398104896@noble.neil.brown.name>
In-Reply-To: <164334386787.5493.637178363398104896@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffbaeb1e-438f-4d84-d84b-08d9e2649fd2
x-ms-traffictypediagnostic: BL0PR10MB3444:EE_
x-microsoft-antispam-prvs: <BL0PR10MB3444137F081C72F0E1B7EB2893229@BL0PR10MB3444.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WxyecLrGIpavDauAbfExXOPWdMNK1Gd424z1qGBgrybFqfHVBnP1ghReIFeE81B7tV7FS3jBDRdE//2KOY+IJm57aGkLqlefOb90nDgqjXRYS9Y7nim1I6riIHFGhMi1lV+bfn67zhF3a4yZ/i9vy96rP/ryKpwuA3R6l05FqSUpxZSHBYOPALY/k74Yk3CwaHQaM9uQOwAcdX2cSs9Z0NGB3VAF5gNFbRuJu905PpuvrdDmSMRa4n3DLFowBQOrqt4XhWllyJCwNPbbiPlmpIEkbbMCb4piI3OUZ7g/+ckxQktofGVoJxxvS4nNvHgG+lrRHGlpW+MxgFoNMwbp9rMK3Q2aHm1YzHrzvWELYQv5eEMTaMkTgCXhVgMldntUXdketiyTwOMeV8OoZNTLYaUE01u5D2Hcg1F1a6BYGH6VaZ1f63DCXnsX2i0RtGvZxjCM5LNJPhnUNskfxt2BIOOpiQCOvaC/0DeIpHanM9S3Xr4Gj3vfy0UNeBfCjdHeBp6nbIzGDhWxpG5O2MPMcZ0cd12v5EwZGe3CDPA7875iA94/JhsaY+xCr0HIcWHI68zSH9nvb0I81Uxa41faZfRbqoop3Je5OKOmeiVfxY8ThF115Ks2GNAfAE75OovhvMnwths0PxhkAxr3eHIwDACMMKPVIAptAJiISrlNEicl5pBDGrg/fha4Io9quXCBQdfgklfyV5RtkhxdpToG5YchKloBjurxVCPqzzPMu3PDSCZX2foXVu98sbS31qkZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(2616005)(122000001)(83380400001)(186003)(316002)(26005)(71200400001)(66476007)(66946007)(36756003)(66446008)(66556008)(38070700005)(64756008)(5660300002)(76116006)(4326008)(6512007)(508600001)(53546011)(6506007)(2906002)(6916009)(8936002)(6486002)(86362001)(33656002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VfGJwhXdIOZDSfU6N6WNcE1SNZ7ZZVDwYt82ftCDCQ+Sorv/K6zTFrmhfpvo?=
 =?us-ascii?Q?eq1S2uRxi5poXSkGgT5bAfPfze1GLwZn6uRcrJ7/cXEDwwryH7KPyr30B47w?=
 =?us-ascii?Q?LBsj44+fXnD7u7OLuBqN3VzoG4djTNPijc3xef30yKRBF26xz3Ln3QMTajYD?=
 =?us-ascii?Q?k513/5FKrGD+HJMMMUsq7pQCLm/0vV42VaCCeiry6Av5KThEnxVx9wm2fqRm?=
 =?us-ascii?Q?QFYBh01UX8qBB2QsLNJnchJBXXteWYCm9jDXH48hLpvRuaCV6lOfNYyzEegT?=
 =?us-ascii?Q?voOmQv48/HLOjJXTXaDMt+pEVXazWnpFivrtvGS5GSvIecQLnDEwi9RTia54?=
 =?us-ascii?Q?eCCm+tGwlQk/91OWBgJTd3fE6GcuByGWPpP7hp9uGRHJsT76kIigbMPT3rja?=
 =?us-ascii?Q?C/5IXoKfeJrBZFYmyXVEc41sIVubjXRccW32HThhcLmKITYjVki+1PzY3yeO?=
 =?us-ascii?Q?FxlFeIT96MrzhAlKINbQt1NnfCDYlwPfLS3aOmLxzI/G0Nn9r75sbyg5J3iV?=
 =?us-ascii?Q?s7IJDlZRzP2ks9DHPRJKVJ1w41ouqk6/+VOgpWUiLod/KkydkjRy5hVDtEe0?=
 =?us-ascii?Q?eXtpPQbhjMMGip9+y/ozOCCM0OJQfiYqhL+kfjb1fEWBU65IR9ob3xlWlbu8?=
 =?us-ascii?Q?mWEI34D+y6N4jtjK6zm6UOmz7v+/CPRgc6xMFWXuKkfiefn8h0tgjxfChYDA?=
 =?us-ascii?Q?XEY4XT0pqyvypGwBZDg+S4djZtsZrAp1G6zhB9KpiUPLkgSzXu0ASJJwlBSl?=
 =?us-ascii?Q?tyMSOvf4hsEKEGdxuBI7QGGNC894VVsMBauNdc2iN05PyPOrDCAHI9ydl+/S?=
 =?us-ascii?Q?VKiulUxLFT5s2ePk2tCOGr53rUdWsFMJcFPEnDbjARjA6aVROsV1fBE6AiVV?=
 =?us-ascii?Q?CRVB3HzsD1sBXsFDfIlYgwLEf+tEQxIdukIRUCtRcCuYWYFm2sBK9NKHMh7M?=
 =?us-ascii?Q?dH5uIY8CnUgBxD0XoTWkUSxkt1ZuPZj3mpxlxA8KwvorVm5PLNYmSBlioXjF?=
 =?us-ascii?Q?PWdfdJy7eiWXBrTeqGmNfNYC+fyAkbnxuWiBCWDfg4B8iRcoryniZb4A/TAn?=
 =?us-ascii?Q?2FPVdgooD1ic2GB1gIpHv2aBpE3V+Mmw0HYSKTfaQJRwi3kDJ374Oc6tbpFs?=
 =?us-ascii?Q?bloGPqnFU4SFJmNV/7xrVrp5P53uSPb0n3zR0wQjmXzB+corV3sdy0x4W/P4?=
 =?us-ascii?Q?RTzVXbE2B0VdW7RjvtzMzJMG6XgDefLoYBHkIvN9s4QXa3WYidswIHNMVmiA?=
 =?us-ascii?Q?Sca5dVJp1LcERaSFeQd5RWIvHVlQxUFLl+nfhtqYlFLKJw2WdDwa681VKEWY?=
 =?us-ascii?Q?+vueMOsPl4Dmd8RWB2dtK164oM14Nw9qDpbzgX8Qh/7b8j4oxvPdQz06mBGG?=
 =?us-ascii?Q?GYO4BbwaWnPwJhx6VCLoWhZFYfyC1xEj5zaVp1CDWs8F8Sfe6c98GRoaVLUj?=
 =?us-ascii?Q?G6AO6aNgwVD23CY+BvWnf9KLllX6wnpRWtGoWgHiJpnt93G0GPDj/tyVw7Vu?=
 =?us-ascii?Q?cev76bnpAGbSlXJkCxgwsiFtuzSZOZdwI2xzqOu3IF9mVJ3o6Qe02IYHddqa?=
 =?us-ascii?Q?Hm8cCcNvdoo/oG5Q1yTQXsZNhuC5GKZROEYPkeYyGpw8qmGOe0s+jruOqgTN?=
 =?us-ascii?Q?TxfT3zGw2dwkQZpVzU5CeyU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BBF92D005D0FCB479520CBB373DB4DF0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbaeb1e-438f-4d84-d84b-08d9e2649fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 13:46:45.4232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94ZIp4aoTsPrm/ZichYiQhMbyV7LxWcJHEqkyMrXsVNm1o0dkX/YU7Q0G7Ok0H2AedzeKBODAAffJYrR9cI4HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3444
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280087
X-Proofpoint-GUID: tyXu4ZOwW1PcZ29d-AOQ33no0rV-8Tds
X-Proofpoint-ORIG-GUID: tyXu4ZOwW1PcZ29d-AOQ33no0rV-8Tds
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 27, 2022, at 11:24 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 28 Jan 2022, Chuck Lever III wrote:
>>=20
>>> On Jan 27, 2022, at 5:41 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Fri, 28 Jan 2022, Chuck Lever III wrote:
>>>> Hi Neil-
>>>>=20
>>>>> On Jan 26, 2022, at 11:58 PM, NeilBrown <neilb@suse.de> wrote:
>>>>>=20
>>>>> If a filesystem is exported to a client with NFSv4 and that client ho=
lds
>>>>> a file open, the filesystem cannot be unmounted without either stoppi=
ng the
>>>>> NFS server completely, or blocking all access from that client
>>>>> (unexporting all filesystems) and waiting for the lease timeout.
>>>>>=20
>>>>> For NFSv3 - and particularly NLM - it is possible to revoke all state=
 by
>>>>> writing the path to the filesystem into /proc/fs/nfsd/unlock_filesyst=
em.
>>>>>=20
>>>>> This series extends this functionality to NFSv4.  With this, to unmou=
nt
>>>>> an exported filesystem is it sufficient to disable export of that
>>>>> filesystem, and then write the path to unlock_filesystem.
>>>>>=20
>>>>> I've cursed mainly on NFSv4.1 and later for this.  I haven't tested
>>>>> yet with NFSv4.0 which has different mechanisms for state management.
>>>>>=20
>>>>> If this series is seen as a general acceptable approach, I'll look in=
to
>>>>> the NFSv4.0 aspects properly and make sure it works there.
>>>>=20
>>>> I've browsed this series and need to think about:
>>>> - whether we want to enable administrative state revocation and
>>>> - whether NFSv4.0 can support that reasonably
>>>>=20
>>>> In particular, are there security consequences for revoking
>>>> state? What would applications see, and would that depend on
>>>> which minor version is in use? Are there data corruption risks
>>>> if this facility were to be misused?
>>>=20
>>> The expectation is that this would only be used after unexporting the
>>> filesystem.  In that case, the client wouldn't notice any difference
>>> from the act of writing to unlock_filesystem, as the entire filesystem
>>> would already be inaccessible.
>>>=20
>>> If we did unlock_filesystem a filesystem that was still exported, the
>>> client would see similar behaviour to a network partition that was of
>>> longer duration than the lease time.   Locks would be lost.
>>>=20
>>>>=20
>>>> Also, Dai's courteous server work is something that potentially
>>>> conflicts with some of this, and I'd like to see that go in
>>>> first.
>>>=20
>>> I'm perfectly happy to wait for the courteous server work to land befor=
e
>>> pursuing this.
>>>=20
>>>>=20
>>>> Do you have specific user requests for this feature, and if so,
>>>> what are the particular usage scenarios?
>>>=20
>>> It's complicated....
>>>=20
>>> The customer has an HA config with multiple filesystem resource which
>>> they want to be able to migrate independently.  I don't think we really
>>> support that,
>>=20
>> With NFSv4, the protocol has mechanisms to indicate to clients that
>> a shared filesystem has migrated, and to indicate that the clients'
>> state has been migrated too. Clients can reclaim their state if the
>> servers did not migrate that state with the data. It deals with the
>> edge cases to prevent clients from stealing open/lock state during
>> the migration.
>>=20
>> Unexporting doesn't seem like the right approach to that.
>=20
> No, but it something that should work, and should allow the filesystem
> to be unmounted.  You get to keep both halves.
>=20
>>=20
>>=20
>>> but they seem to want to see if they can make it work (and
>>> it should be noted that I talk to an L2 support technician who talks to
>>> the customer representative, so I might be getting the full story).
>>>=20
>>> Customer reported that even after unexporting a filesystem, they cannot
>>> then unmount it.
>>=20
>> My first thought is that probably clients are still pinning
>> resources on that shared filesystem. I guess that's what the
>> unlock_ interface is supposed to deal with. But that suggests
>> to me that unexporting first is not as risk-free as you
>> describe above. I think applications would notice and there
>> would be edge cases where other clients might be able to
>> grab open/lock state before the original holders could
>> re-establish their lease.
>=20
> Unexporting isn't risk free.  It just absorbs all the risks - none are
> left of unlock_filesystem to be blamed for.
>=20
> Expecting an application to recover if you unexport a filesystem and
> later re-export it is certainly not guaranteed.  That isn't the use-case
> I particularly want to fix.  I want to be able to unmount a filesystem
> without visiting call clients and killing off applications.

OK. The top level goal then is simply to provide another
arrow in the administrator's quiver to manage a large
NFS server. It brings NFSv4 closer to par with the NFSv3
toolset.

I say we have enough motivation for a full proof of
concept. I would like to see support for minor version 0
added, and a fuller discussion of the consequences for
clients and applications will be needed (at least for
the purpose of administrator documentation).


>>> Whether or not we think that independent filesystem
>>> resources is supportable, I do think that the customer should have a
>>> clear path for unmounting a filesystem without interfering with service
>>> provided from other filesystems.
>>=20
>> Maybe. I guess I put that in the "last resort" category
>> rather than "this is something safe that I want to do as
>> part of daily operation" category.
>=20
> Agree.  Definitely "last resort".
>=20
>>=20
>>=20
>>> Stopping nfsd would interfere with
>>> that service by forcing a grace-period on all filesystems.
>>=20
>> Yep. We have discussed implementing a per-filesystem
>> grace period in the past. That is probably a pre-requisite
>> to enabling filesystem migration.
>>=20
>>=20
>>> The RFC explicitly supports admin-revocation of state, and that would
>>> address this specific need, so it seemed completely appropriate to
>>> provide it.
>>=20
>> Well the RFC also provides for migrating filesystems without
>> stopping the NFS service. If that's truly the goal, then I
>> think we want to encourage that direction instead of ripping
>> out open and lock state.
>=20
> I suspect that virtual IPs and network namespaces is the better approach
> for migrating exported filesystems.  It isn't clear to me that
> integrated migration support in NFS would add anything of value.
>=20
> But as I think I said to Bruce - seamless migration support is not my
> goal here.  In the context where a site has multiple filesystems that
> are all NFS exported, there is a case for being able to forcibly
> unexport/unmount one filesystem without affecting the others.  That is
> my aim here.

My initial impulse is to better understand what is preventing
the unexported filesystem from being unmounted. Better
observability there could potentially be of value.


> Thanks,
> NeilBrown
>=20
>=20
>>=20
>> Also, it's not clear to me that clients support administrative
>> revocation as broadly as we might like. The Linux NFS client
>> does have support for NFSv4 migration, though it's a bit
>> fallow these days.
>>=20
>>=20
>>> As an aside ...  I'd like to be able to suggest that the customer use
>>> network namespaces for the different filesystem resources.  Each could
>>> be in its own namespace and managed independently.  However I don't
>>> think we have good admin infrastructure for that do we?
>>=20
>> None that I'm aware of. SteveD is the best person to ask.
>>=20
>>=20
>>> I'd like to be able to say "set up these 2 or 3 config files and run=20
>>> systemctl start nfs-server@foo and the 'foo' network namespace will be
>>> created, configured, and have an nfs server running".
>>> Do we have anything approaching that?  Even a HOWTO ??
>>=20
>> Interesting idea! But doesn't ring a bell.
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



