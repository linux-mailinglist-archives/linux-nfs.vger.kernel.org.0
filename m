Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3037735E552
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 19:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347314AbhDMRtT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 13:49:19 -0400
Received: from mail-mw2nam12on2096.outbound.protection.outlook.com ([40.107.244.96]:32818
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347345AbhDMRtP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 13 Apr 2021 13:49:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfW8udItr2EdLLXBnOBQtM/z1E622wfoipjazgJQ4kxJjiM3h22TL+pM1Oz1b6DyCUGmIhrzmKSb6q8x2nne4Pb+28zHsryiPDm2jPxTmiGgr+soGUatCWw1w5vp69mqrm3mEu0o4iyzbXxiyU3kAG8h1VrqXFezJXYL0uzkCLhLLusYp+Igyrj16/OSC+5XSsc8uNnQDiusKu6lKaEkYNi0zRFwxbOQhV1iAoAVOUjbmbEyuNuNkgrG+fgB8K4FSzPAF0M4B1PUulaWZchdgsZXH/21/l3bBzD6/99lwnsXrXhiVPgQOdwBfkt1fWIHaSzKNjtKhhr0BE27QXL+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hGzHsITQRlZhRqdpxIXMPZI+XiKyqaPSVhT+xkvU8U=;
 b=eBClJezIKYowwU/l7arQWk1RTsLt6LzIYit7czbhF+gHZDH5BPqJlM1CaCqiDfbcBAvUQdmj6Lhj6gmt8mrDZ/3220yhWGf1VZmQJ7It1+fs3PPufAdDd6EnacWYibz0KwWuTs1+n9zEng07coF90VPJCjeKe99YHAZey27oMuLj3vntOf6+SxjBLMaWPgIMTAB+lfsumpHM+4kQeLNLoDUozwpCRh7pPuSy4570SrTRrzocbmMeaMhdDdW0wI4PKhD9PBvUYV2DWnZxyFSt5sqTJ8woz3peixCAA1xViixwZLosc4Y/aoCOzKCUDaaTUntYUhqEm29We6RIi/jSqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hGzHsITQRlZhRqdpxIXMPZI+XiKyqaPSVhT+xkvU8U=;
 b=qz1G9y/TaV4XLAlj5o+4cXv0tQUBjZt552cml6p7Vh/BWe4LRs11cg4Q8+jI3qM1veaVCAG05SZ3Dt3GLZcLji4H1iiWkGisIqbUq+HBhEJ9tuaeHfpetJDEixdCVPe6IHmm3jfmG7PWEMOnebXX+hx06G9YR8LDX1sZGST/2M4=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by MN2PR14MB3934.namprd14.prod.outlook.com (2603:10b6:208:1d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Tue, 13 Apr
 2021 17:48:51 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::2848:113d:4d17:51a0]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::2848:113d:4d17:51a0%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 17:48:51 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: safe versions of NFS
From:   hedrick@rutgers.edu
In-Reply-To: <5F282359-128D-4F72-B393-B87956DFE458@oracle.com>
Date:   Tue, 13 Apr 2021 13:48:50 -0400
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Patrick Goetz <pgoetz@math.utexas.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FDBA5185-F6BE-443B-81E4-12DD1501E4A6@rutgers.edu>
References: <D8F59140-83D4-49F8-A858-D163910F0CA1@rutgers.edu>
 <e6501675-7cb4-6f5b-78f7-abb1be332a34@math.utexas.edu>
 <506B20E8-CE9C-499B-BF53-6026BA132D30@rutgers.edu>
 <1EA88CB0-7639-479C-AB1D-CAF5C67AA5C5@redhat.com>
 <22DE8966-253D-49A7-936D-F0A0B5246BE6@rutgers.edu>
 <08DD4F45-E1CB-4FCB-BA0C-A6B8BD86FEDE@redhat.com>
 <5F282359-128D-4F72-B393-B87956DFE458@oracle.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
X-Originating-IP: [2620:0:d60:ac1a::a]
X-ClientProxiedBy: BL0PR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:207:3d::45) To BL0PR14MB3588.namprd14.prod.outlook.com
 (2603:10b6:208:1cb::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from heidelberg.cs.rutgers.edu (2620:0:d60:ac1a::a) by BL0PR02CA0068.namprd02.prod.outlook.com (2603:10b6:207:3d::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 17:48:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5583af4-1d0f-4a6f-5aa5-08d8fea4661a
X-MS-TrafficTypeDiagnostic: MN2PR14MB3934:
X-Microsoft-Antispam-PRVS: <MN2PR14MB3934E21967220C5DD0A6E6E3AA4F9@MN2PR14MB3934.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8eG8vVtCZyWxxqaJqN09R1d51AaZnWSD7p8DlWWqzCqf6O469njWwbpHSZS0FrB/hWPMR0ImDZAxdrAUf6FxYKhaUqsq3+ufSL3ZF+ZOLt887pY65u/oLLHhgxhCh33hMx103jyfGzzckBKzYMfk8oxCxwFuIUMapNlL2xmPNtnI5fJfBNGbybBCl/584ggmPqSu1emJbyfwvWtrqkDcUp7ICRQ8w/CVlx0hiTBBffwx+9iJvChW/q5raJWAsRxe7y9M7SwGijNFDoAKYon7Pd27D89g03r3w74LRvyv6kPWL81dkB5/RFxgKdm/06Jiq0+RcEhxT6Ymvjm8OScc2fM9TckmLL1hmAwS3t/rex+kckzhW1YRVYQC+iDa5CaNNXXxPl27RTuuI6R/stkU6w3nbvMLyiTb02E0EidInuqeqIoSAifml2932q0dFDJNrQ28VnHp54Wub6X+PDJCFUmCvfbRLIkoLgiwkJp+gwzx82dHZq1Y0WCG0egcUCf387YN8rJnTjQkA9cBvBjfDv5rRkpMoHfYStHOLAAVG4LtamiLF+RNiTm3zd4Kk3MtMgN6foa7xm8pgcH35eHCiMqlfRig1kWjkYd6Wbq8Doac95ghbLfhQHJmpMh+oebRXQXeFJwutqWedFvDguzNzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(52116002)(786003)(3480700007)(478600001)(9686003)(316002)(186003)(54906003)(5660300002)(8936002)(38100700002)(6486002)(33656002)(86362001)(2616005)(83380400001)(6916009)(36756003)(7696005)(53546011)(75432002)(2906002)(66476007)(8676002)(16526019)(4326008)(66946007)(66556008)(2292003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZDY4OWVGZ3pMT3ZnRElYbjdYOExMdVN2dEJ5Wk1MekhUNStFTkFYbk13QmNI?=
 =?utf-8?B?eFREeGZ2TTl6QXA0R044Z0pZdVFsMERITFpieWN2dmNndzFJZTZZNnUrRkps?=
 =?utf-8?B?WUlvTS9nc0tqWVFYYTJyRFNpa3NuMEdLWCtZQmI5VG53dWxlYzRDV2tyZXJI?=
 =?utf-8?B?WW1VS09HMENmcmdPbEl1RlIxQXl1UHI4Q2U5QXcwOWxDQ2ZJSjJtWHVNbk9Z?=
 =?utf-8?B?cCtsWURRUm5EMlRvUWFMM1ZyZmpPL0NWeGQrU0N0b2JobmtoaWM3d3FaYTFV?=
 =?utf-8?B?YjF4UzVzYi81R1pEakU4aG1UazZtUmNyaFh1aEUwUmRRbmV5Tkc4bG9hSW9T?=
 =?utf-8?B?MUdXeHdsSzEybnlwS1ltaE41b3dsYVVuOVlVZlMxaUczMGtYaExwckZMNDA0?=
 =?utf-8?B?Z1lPYzBIc2hQbCtxVDE1ZTNqZTZmbHdzR3kzY1loQWJsYUdSTU5aUm5CQ1JB?=
 =?utf-8?B?TFMwNWlsTFNBK1MvUExDYTNYZ0ZVNFpVcllRMzN1Wi80aE9kTFphYzQyT0ll?=
 =?utf-8?B?N3NqZVFCMkxVaVRnNkp4V2NYak5sSk8wVVRGTkZGRk9JYk9jeUc2N2VOeTlI?=
 =?utf-8?B?RHh4ZVU3TEJISUVuOVIzQU5FTkpNYXFlbWFMZS9EK0dZMUJtS1RlaXI3UEdn?=
 =?utf-8?B?SFNzdG9zWmo5blZCNFRWVXRoakZNSDRvanJ1aDc1ZE51Z0tRdHRNQUs2aWg5?=
 =?utf-8?B?R2JWb3JPaXlIcjkxMnRTMG0yaEJ4WERoL2MzUk56SXIvNFhZMXFaSm4vcXVm?=
 =?utf-8?B?ZTFRQ2pEK2NkVUo0RHJ2aGlDUHBUVllOdk5FVlplQ2FWYzAzbDdZVS9Pei9r?=
 =?utf-8?B?WXB2d20wbkV0cUg5WU5pNTJFV0VMbVdBc29nOG05ckJDa3lnVWlKNmR1RHZu?=
 =?utf-8?B?cUZ2eGJNWnRYREFwLzBRU0NTQU1MN2ZraTBDaTBic0NqMUYzMGNXREpBbVor?=
 =?utf-8?B?UmZpMWxyV3RaQnd6aXd3WEFNRVY3L2o5OU1WN3dKMEhSZUUvNUt4MDkyL3FZ?=
 =?utf-8?B?VUNqWEJMYy9BL2x3S0wwczJ5dVNGaFBmRGU5RWhKeFdISnVJbWlwTEsyM1Js?=
 =?utf-8?B?M3VrbTB5bGNrSVA2Z09yZVJucFhqVGw4c1F5bVRIZjhsSjRQNUJvdlcxbFFV?=
 =?utf-8?B?dVlTTHZuUVlCamNhQnI5VE9zY3dST29MUUNMYkZmUVl3ejBtbGZjWkJuTnRK?=
 =?utf-8?B?OUp4WXlkSjlwQ09aK3o5dEpwM0UyYjdXVkR5UE5maFUyYWpjMEQ2aTNxMnNm?=
 =?utf-8?B?OERmdnBZNjR4dW5ZQnZTdHM3U3RLUU9OYXFyWlh3VVliZ09GVUtZQkp6OGFh?=
 =?utf-8?B?eGpSSDVDRjZTOUJHQjd5dFJsTVZSTFV1RlY4bGREd2ZzVmtnYjUvRWg2K0g3?=
 =?utf-8?B?cVovNWR2Sk5xNm9lSjdRV2EwYmFEdXZMY1dhVmVZbll1ektMZEJUQjNVVUlm?=
 =?utf-8?B?bmZNQlVMa3ZQYkxEYVdpcUhYeVpXNStXVmIrN3psVTJRTTRYQlJpNTNnMDhY?=
 =?utf-8?B?aTlCYWc1UjRzNEpObVp2QTFoNVgrbUFSb1FmaFpWMDZBK2hBVC9hZHFzUVJr?=
 =?utf-8?B?TnhDSkwvWHloNDFCZWszNkFRTW1MWU9KWmNPVko3bEYrblhIYzZLeGdnNU5U?=
 =?utf-8?B?TGdPN3JBakgzOHEwdWNqNDNDRnIvQjFxOHoyVHl6M0IrQkVQSTNwNEtiamUr?=
 =?utf-8?B?aWdEVFpPUWR3U1M4N29yS0RsYklnV0MzbU40S2UxekhQaEorb0UxM2pCejBE?=
 =?utf-8?B?T21LWHQ4YW5RckNHTmgzaHdldTU2ZUxBVzNUZEZDS0lybGJ1Y2lwOGVySXFG?=
 =?utf-8?B?dFlLZUttdTdIcGswOWJsUT09?=
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b5583af4-1d0f-4a6f-5aa5-08d8fea4661a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 17:48:51.5364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBlXwTKK6Q+1BvHH9nWjCsIH3KT1V3g6Yi0l7ManEurLk8URfM52HFtJcm3a/+Rw2vA0u4FXxe/aucQU8UXE5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB3934
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The two oddities I=E2=80=99ve seen are
* the fairly common failure of mounts with =E2=80=9Cnot exported=E2=80=9D b=
ecause of sssd problems
* a major failure when I inadvertently reinstalled sssd on the server. That=
 caused lots of mounts and authentication to fail. That was on Apr 2, thoug=
h, and most problems have been in the last week

We=E2=80=99ve been starting to move file systems from our netapp to the Lin=
ux-based server.I note that Netapp defaults to delegations off with NFS 4.1=
. They almost certainly wouldn=E2=80=99t see these problems. It=E2=80=99s a=
lso interesting to see that there=E2=80=99s been enough history of problems=
 that gitlab recommends turning delegations off on Linux NFS servers, or us=
ing 4.0. I=E2=80=99ve seen another big package that makes a similar recomme=
ndation.

As soon as we can verify that our applications work, we=E2=80=99re going to=
 upgrade the server that has shown the most problems with Linux 5.4, to see=
 if that helps. So far our Ubuntu 20 systems (with 5.8) have been OK, thoug=
h they get fewer users. We=E2=80=99ll be moving everything to 20 this summe=
r. While Ubuntu 20 server uses 5.4, I=E2=80=99m inclined to install it with=
 5.8, since that=E2=80=99s the combination we=E2=80=99ve tested most.

> On Apr 13, 2021, at 1:24 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On Apr 13, 2021, at 12:23 PM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>>=20
>> (resending this as it bounced off the list - I accidentally embedded HTM=
L)
>>=20
>> Yes, if you're pretty sure your hostnames are all different, the client_=
ids
>> should be different.  For v4.0 you can turn on debugging (rpcdebug -m nf=
s -s
>> proc) and see the client_id in the kernel log in lines that look like: "=
NFS
>> call setclientid auth=3D%s, '%s'\n", which will happen at mount time, bu=
t it
>> doesn't look like we have any debugging for v4.1 and v4.2 for EXCHANGE_I=
D.
>>=20
>> You can extract it via the crash utility, or via systemtap, or by doing =
a
>> wire capture, but nothing that's easily translated to running across a l=
arge
>> number of machines.  There's probably other ways, perhaps we should tack
>> that string into the tracepoints for exchange_id and setclientid.
>>=20
>> If you're interested in troubleshooting, wire capture's usually the most
>> informative.  If the lockup events all happen at the same time, there
>> might be some network event that is triggering the issue.
>>=20
>> You should expect NFSv4.1 to be rock-solid.  Its rare we have reports
>> that it isn't, and I'd love to know why you're having these problems.
>=20
> I echo that: NFSv4.1 protocol and implementation are mature, so if
> there are operational problems, it should be root-caused.
>=20
> NFSv4.1 uses a uniform client ID. That should be the "good" one,
> not the NFSv4.0 one that has a non-zero probability of collision.
>=20
> Charles, please let us know if there are particular workloads that
> trigger the lock reclaim failure. A narrow reproducer would help
> get to the root issue quickly.
>=20
>=20
>> Ben
>>=20
>> On 13 Apr 2021, at 11:38, hedrick@rutgers.edu wrote:
>>=20
>>> The server is ubuntu 20, with a ZFS file system.
>>>=20
>>> I don=E2=80=99t set the unique ID. Documentation claims that it is set =
from the hostname. They will surely be unique, or the whole world would blo=
w up. How can I check the actual unique ID being used? The kernel reports a=
 blank one, but I think that just means to use the hostname. We could obvio=
usly set a unique one if that would be useful.
>>>=20
>>>> On Apr 13, 2021, at 11:35 AM, Benjamin Coddington <bcodding@redhat.com=
> wrote:
>>>>=20
>>>> It would be interesting to know why your clients are failing to reclai=
m their locks.  Something is misconfigured.  What server are you using, and=
 is there anything fancy on the server-side (like HA)?  Is it possible that=
 you have clients with the same nfs4_unique_id?
>>>>=20
>>>> Ben
>>>>=20
>>>> On 13 Apr 2021, at 11:17, hedrick@rutgers.edu wrote:
>>>>=20
>>>>> many, though not all, of the problems are =E2=80=9Clock reclaim faile=
d=E2=80=9D.
>>>>>=20
>>>>>> On Apr 13, 2021, at 10:52 AM, Patrick Goetz <pgoetz@math.utexas.edu>=
 wrote:
>>>>>>=20
>>>>>> I use NFS 4.2 with Ubuntu 18/20 workstations and Ubuntu 18/20 server=
s and haven't had any problems.
>>>>>>=20
>>>>>> Check your configuration files; the last time I experienced somethin=
g like this it's because I inadvertently used the same fsid on two differen=
t exports. Also recommend exporting top level directories only.  Bind mount=
 everything you want to export into /srv/nfs and only export those director=
ies. According to Bruce F. this doesn't buy you any security (I still don't=
 understand why), but it makes for a cleaner system configuration.
>>>>>>=20
>>>>>> On 4/13/21 9:33 AM, hedrick@rutgers.edu wrote:
>>>>>>> I am in charge of a large computer science dept computing infrastru=
cture. We have a variety of student and develo9pment users. If there are pr=
oblems we=E2=80=99ll see them.
>>>>>>> We use an Ubuntu 20 server, with NVMe storage.
>>>>>>> I=E2=80=99ve just had to move Centos 7 and Ubuntu 18 to use NFS 4.0=
. We had hangs with NFS 4.1 and 4.2. Files would appear to be locked, altho=
ugh eventually the lock would time out. It=E2=80=99s too soon to be sure th=
at moving back to NFS 4.0 will fix it. Next is either NFS 3 or disabling de=
legations on the server.
>>>>>>> Are there known versions of NFS that are safe to use in production =
for various kernel versions? The one we=E2=80=99re most interested in is Ub=
untu 20, which can be anything from 5.4 to 5.8.
>>>>=20
>>=20
>>=20
>>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

