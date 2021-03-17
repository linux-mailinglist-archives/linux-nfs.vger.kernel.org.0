Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3C633F8A9
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Mar 2021 20:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhCQTA5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Mar 2021 15:00:57 -0400
Received: from mail-mw2nam12on2132.outbound.protection.outlook.com ([40.107.244.132]:39104
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232207AbhCQTAr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Mar 2021 15:00:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfGpc5WbcIoff8ja7tHzGbuiWxuwjgEPMtpAYpKpm54bKUq7oZutSvEoN5KU5xJ5XjdovSomE0T18UaDrxZxZYjc0XIiFa61wWwM85Pzoxlaj/EKeV4DP8iZ6ZWs/nnloqMjNOXQKBOsN1Rb+sVShfeZ5MrczX7NlvcBBxKbAAoVCfSCq9tyK5FxBYiZrTpkoXeqDO+lgeV6XgDVfbSITiYo6poC9CeYecZK6jqHPdrgtYkOiTTzcUn9p4M6L8qKqxuYKxAxodOZc146duU1WxfUqh8TlDighftex3CVQzQG79cGqu92wQSTd3WBNLhVyl8FJKuLCchNIjo2d7tv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVV97ypIweJtyrD8VYj9QHS+D81fAY0L7WOUnNkvVrw=;
 b=BbklMNMwnlsrFmboISS6z+HNkNwLYU71vBkitrY+rIvTpxn5Vh+FDRtOXnDdk3CX3PuzdedouDJjhv+a4cKjr1/M07O1srUMmL6xfUUPxHCmhLzNjST4tEtuBbPXiFEUWb0pb4Pupq2T1iquXmU2Nxqbiyl1x0k+jS9yNx2u+kQLOsUx6qDViBypo1SFQUxKV/Nmk4+s0sOSVYWC+MZKxkNYwzzf/kXiouoCbRpBuv6b1JX9omFaUfqzWlc1fv0YNP/wuOC+5+tnqd5myiErOAF6Wo+cyS89/5A2M7yVJ4eRPIo3t9/eG6vUXu7V4dcZmlXKYu2i3gyWMwTDM0XmbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVV97ypIweJtyrD8VYj9QHS+D81fAY0L7WOUnNkvVrw=;
 b=ZjRhtfqR4Js9CfKAZhbjKIn8tkllYwfiez8i+47/T+Zl/okl1A03Nc/nJmgJ1FK9ytXaVPoXYXOlaHQ6XCyGbQvr3+fD+K07MCsNUbgtvw3PnRAzz2+b5zM7fcLor2EKsn4Ep4mlk4H3p5T4+5hnOSrK43wbrhK2wGqqWqekPuo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by BL0PR14MB3586.namprd14.prod.outlook.com (2603:10b6:208:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 19:00:37 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::ac70:fcf7:df8f:f589]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::ac70:fcf7:df8f:f589%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 19:00:37 +0000
From:   hedrick@rutgers.edu
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: group changes don't take effect on NFS
Message-Id: <CC0F1034-8572-4556-8351-28499903258C@rutgers.edu>
Date:   Wed, 17 Mar 2021 15:00:36 -0400
To:     linux-nfs@vger.kernel.org
X-Mailer: Apple Mail (2.3654.40.0.2.32)
X-Originating-IP: [2620:0:d60:ac1a::a]
X-ClientProxiedBy: MN2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:208:234::15) To BL0PR14MB3588.namprd14.prod.outlook.com
 (2603:10b6:208:1cb::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from heidelberg.cs.rutgers.edu (2620:0:d60:ac1a::a) by MN2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:208:234::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 19:00:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 335efa45-e9f3-4f13-70a1-08d8e976f3b5
X-MS-TrafficTypeDiagnostic: BL0PR14MB3586:
X-Microsoft-Antispam-PRVS: <BL0PR14MB35865EE02620C0EF9AB832C5AA6A9@BL0PR14MB3586.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bb1feMTnse4Kt4gx1FgD+owD4WtOhUOM4RGtGJDkpWN58V7Zbs8XvQcWrxbz/rtmd49KBPMInvyUhB6B3m4ajjarKrasDV+6ftCY/LTGAlmw2Xf5vso0SWIkx6e1w0WrgfpBvsTmxkkwUMUBWFaeyW9VYBJ6rutQr7KeI9V1TEGP46CN6kuhHe5M5nX2Y58rje0fqJShZb2IlB0u9JTV3Wa6MOXhgBXOdf8UVKjnzKB6CnjLoUR9Ed0CziVb/a8aHeICVuR5CxBGdLoeuV3qgk10UQCMZ2xNvrMNEzR9oFAFGEJVHD0vUAfk3YZiwwcbdj3na5wtN3afK7M4RMZjEiGnZlsLIzOf+qdNxOiQWxPjuop2imrftt3/INdGNgn5RT4pfKBOPzVAydVHEfpp5Fzd93owcImC/fwOyAT5Jkb2AirYJ0OG6xLWpeFP7nVoMwyBLqVULHcVHuvDxNwWHqKuJUeQPlMo6HtBVbyszSUegP6fz5eU5PRzOA2RqAIK94mB8OTnN4d5750m4nFmZ4MHfDpbDeW7Cl3brZKnEebSF4t+SsiOeShLSLab0RM7XnswpD8bxMqvI9P2+b+k7QdKDKReovudsSI4l5EW+n85C1q+uGTg5rQAAygBQ0Hw5sIDnlypVJMu91f7tEOnCMeHTDAH0VrhURwJaXiwE8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(75432002)(2906002)(6486002)(966005)(16526019)(2616005)(33656002)(316002)(786003)(66556008)(186003)(6916009)(5660300002)(8936002)(66476007)(83380400001)(36756003)(7696005)(8676002)(66946007)(86362001)(52116002)(478600001)(9686003)(21314003)(2292003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cDhVcEFYMjE3WEtXWm5XVU5kOGVNK3VvOWtka3hSNkxjS0wzeFFvbW5NaFJL?=
 =?utf-8?B?dDFuMTRvWUVmaTdGaTBsSU1qZzloRVVteW55cUtNNnJkTys1UUpZSGkzVVBS?=
 =?utf-8?B?c2VBUmdFQmZidDdpTjVyYjhHQThlWTFyVmxUc2lITklnNXRQYy9FS3pkNW81?=
 =?utf-8?B?Qlc2dmUvYWdvQ2pFUkNSTXhFZE92WEpkeUhZNkZJUlIvNHlxc3dabGhXR0FB?=
 =?utf-8?B?S1luMUo3dGIzNnd4Y0NaTFlrTXZMaDBKSW5BS0d3dkNoaTZaNjVyVm1vQ2FZ?=
 =?utf-8?B?MWh1akZUaCtKdmZoUHdCaDNlTzBUZXpjb2JLMDdUbGNUck8wd21OV1BtTUI2?=
 =?utf-8?B?R044NWFGalFUWWxCMmc4RWx6MjZmT0pFY1VCeUxtbjh4Z3F3dFU0U0ZRTFlY?=
 =?utf-8?B?SlpPY3FHODMzaWxXY2J3b0U5dzJCTldacFlKN3BVN0ZQSGtsNmNSKzZJYmtJ?=
 =?utf-8?B?TE5yTGFCQ2k5ZHpkck9LZUtpbnNuZ3dseGgrZWdKZFEyTk1Nck5NM1dGS1ZT?=
 =?utf-8?B?aXZ5YzVLMTZQSk51VEFGMjBNa3Y0eFExanFvOTJxRHUzeUY3VEJqaytBQklh?=
 =?utf-8?B?Nlk5V2RoYnRRK0o3M2tHM29za3M0RXFQWVUzbTV4ai9GeHdKMnRPSVlZWXBD?=
 =?utf-8?B?ZDhYc0JieEFYZVQxUEQrK3ZkbVR1Vnl6NVZLNEVUL1gyTDBYY2pydXJhMmxq?=
 =?utf-8?B?QmlWcDZKZGVJdUlNcS9uYXBUQjhwK2RzeXRnR2J1R3BQbmE3YnJvSzg4YU5h?=
 =?utf-8?B?TkxxQ3J0N1J3STZKT1V2Y3JwZzNmUUFhYWpSTHFSRlhHSXp2NWtsK1h6azJL?=
 =?utf-8?B?Qmk2bk4vaTBZYklOaHpXQlJMWE95K29tdUl3K25qSkFLSmM0UDJHZHF0dmlM?=
 =?utf-8?B?bXRNUWZTVTRSdE1wd3dIOVlLQU9hTFNSNGQ3d1dPWU1IT3ROcVI1VnpMaVlK?=
 =?utf-8?B?bGlIOUR6TURlWXNJNGdNd1ZSN1hzQ2hyVDhhWUFXOXJaRjRWRlljM0dQaEU5?=
 =?utf-8?B?akpkWlYvaDZSa21ySlhCUkFNeUxCZ3VMNkRHcVJWUjlLQ0o1aVhxVThXY1JR?=
 =?utf-8?B?UklnV0kydUxLNHplQ1RiblRLcEIwV2VhNkhPUzIzcVZNSnBBY2owWUpCNkJP?=
 =?utf-8?B?OFF0SjZ6SlIxN0p6ckpiREJiY3J6NGxFU2diS1RpbCtqNHdJdHVvODkzT3Bo?=
 =?utf-8?B?ZEQ5cFFLODN2Z096TDFDVFNKelZaeUpSL28zNVpLWkI5aE1lMXVtR0dWVlMy?=
 =?utf-8?B?ZmNHblBqdlRmaGVTdE1BdjZ6TmtPdW0yb3VZb0pjdTJDYTQwLzl6bjhzY3hB?=
 =?utf-8?B?SWZaRmdPb2YzRlVISjZZMm5TR3VSTTNGdWJQeHUxQllIOFhGY0pGdlVPbjUz?=
 =?utf-8?B?MDlRa3NYRmFOWFlXNGdsVmYxR1BPWjUxbXIyNGhTQ1VMVEdYVmR4aTIxVXJI?=
 =?utf-8?B?Yzc4L3VpdmdOZHVGRWFmRUljK0QycFRiUTY3VTN3bzEyeEpGc1VNK2MraStB?=
 =?utf-8?B?U0Q2T3dpekJXOUtPTzFsUnJkMGxCbHEyd0tDMXE4K3FHaDVqWXRVUXdhMDZ4?=
 =?utf-8?B?RXcxeDFGcEd1U3hBek5aUTZEYU55R01OWWdEYVMvMS9iYXhJNlNxK1M3Vm5x?=
 =?utf-8?B?UWMyeWk5MkpUYUxPcWNHaVNmK2x1M0Q3bHF6clRUeUg3ODcvYmxRd1ZYcERI?=
 =?utf-8?B?Mi9LdlJiQjFlcW8rUXFaTUExVHVxODh0Q2FpT2I1eEozeWlORDlva0Urc0h4?=
 =?utf-8?B?SUZpNFlqNHFvcEZ4aE5oQTZaNERqRFlRMUtySllldS9TazhQaTc3SVVnSy9Y?=
 =?utf-8?B?T3NuMGoyRndnY3dmWWR0QT09?=
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 335efa45-e9f3-4f13-70a1-08d8e976f3b5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 19:00:37.8655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JItRpxMXtoR3Y+nJTf2undObszpo8OCeu8tvOfLe4VJTVl83LnyAHzDcNocHkiqd9ZiigCJaK/9tn9JZuX4fzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR14MB3586
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Accord to the web page, this mailing list is the official place to report b=
ugs in nfs-utils. This one is fairly serous for us.

The problem described in https://linux-nfs.vger.kernel.narkive.com/dgTL2KiI=
/svcgssd-allow-administrators-to-specify-timeout-for-the-cached-context is =
still present. The patch described there needs to be applied.

TO reproduce:

On file system mounted sec=3Dkrb5, login as user xxx. Cd to user yyy's dire=
ctory.
Add user's xxx and yyy to group ggg.
As user yyy, create directory ddd, chgrp ggg ddd
As user xxx, try to view ddd. This will fail.

THe problem is that the nfs context for xxx was established when they acces=
sed the file system. When they were added to the group, the context didn't =
have it. In theory the context will be refeshed when the Kerberos ticket ex=
pires. 1) that's typically a day, which is too long a delay 2) it doesn't a=
ctually happen.

The patch allows you to tell the server to expire contexts after some finit=
e period. We're using 30 minutes. I'm also using a slightly different versi=
on of the patch.

Instead of just ctx_endtime =3D now + 1800 (I've hardcoded the time to mini=
mize the patch) I'm using

+ /* timeout in 30 min or ticket expiration, whichever is sooner */
+ {// so we can use a local variable //
+ time_t now =3D time(0);
+
+ if ((now + 1800) < ctx_endtime) {
+ ctx_endtime =3D now + 1800;
+ }
+
+ }
+

This is technially a security problem. If a user wants to remove access fro=
m someone, it can take an arbitrarily long period to take effect. The origi=
nal bug noted this as a security problem, and others involve din the discus=
siosn agreed.

There was a patch to limit the context lifetime to the ticket lifetime. It =
appears that it works but isn=E2=80=99t useful. If the user renews their ti=
cket, the context continues. We do that automatically as long as the user s=
tays logged in. Even if the patch worked, 24 hours is too long to wait for =
changes to take effect.



