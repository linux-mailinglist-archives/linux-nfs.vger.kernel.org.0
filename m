Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BFD4230E8
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 21:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhJETsR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 15:48:17 -0400
Received: from mail-dm6nam12on2133.outbound.protection.outlook.com ([40.107.243.133]:55264
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231396AbhJETsO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 Oct 2021 15:48:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8E7/w96Lcx/nlhf/1uOmY8UcQY24QPsi7IL5ePHW0PNUudE4lP/gA9NKpjDnyl0vtRviTV8g2TbpmHQUw/UzJQJwwzQQl7jNgkOPk0jK00YoayqsD/MRmc6wvJkvNGHr3xQ/ho8yqAVI4sTBjUvFU1QPE/AO3WV3sD+rtOs+MdadiNAX3Nix9RjbQcLKzNx8ue8DT0sUvOYCk6mU66z4GqmnmH4yFsVZfaL5cRf2ouCN0LfXq+sh5Uqv+BioXJ569J70er5JQ7+Os7udPCoeWUX8X4mTX1ywtqf0mm68gtuyBOKNai5zD9htYJFCPmKuPvhm/XUPi4N00TdApzd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDCAT1yMa71R5HnTRInR3JCE+x4GEtFGEfsEFcS7MQ4=;
 b=ZE00DBtneutKeXfNm1PJVvEzh7EW39AxJfh7vhRvM0mZX5Iq9bxa/KcMkSoxPSnDGNfvc1QXCgS0eGZ6oi8r7B4ZqrDw0Pa2//SoE7Sc93hNQoGjpC/4gTOfd+1p4/HJv8mrY63SIslevPvmXdPFdC+TBTPDK9x1vR7nGEfDdbBfY4fmdzle9AlYsRRhWAijXGFOKXSox1dWyVNHNOqDdBbpLvcQiR0jG3iuNMewp2LP0Rk2+tqvqeU0YBJ1pkW4kBsWc2HbrmVDRWgwDtVpK17paHK8LIuX1y5UBQ1xVBc3wkTrDKjMl309Sj2GPVIJ5jc3WGx2CE8hM6Z4H1Kh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=cs.rutgers.edu;
 dkim=pass header.d=cs.rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDCAT1yMa71R5HnTRInR3JCE+x4GEtFGEfsEFcS7MQ4=;
 b=YXgdXYLmLtOQuWwXVsU7OapY9RmIKIbMhV4y3DYJR7q+Jv68mCLEmLU3m3AMs6cGwMpcrwKVIMVAvXrJNL5+A51A2kYPgQwBCEcNnH1tnoGB/Y3OUpXBemjGrcm22rEIQ0lW3BuEHEB4TiT0P1rg+G8MYM2fHIPCcXC3QCjlLBI=
Authentication-Results: rutgers.edu; dkim=none (message not signed)
 header.d=none;rutgers.edu; dmarc=none action=none header.from=cs.rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by MN2PR14MB3965.namprd14.prod.outlook.com (2603:10b6:208:1df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 19:46:22 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::e9f9:a6a2:de33:e91]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::e9f9:a6a2:de33:e91%8]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 19:46:22 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: more problems with NFS. sort of repeatable problem with vmplayer
From:   Charles Hedrick <hedrick@cs.rutgers.edu>
In-Reply-To: <70E12E3F-2DFB-4557-9541-67276E5A195C@rutgers.edu>
Date:   Tue, 5 Oct 2021 15:46:21 -0400
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Patrick Goetz <pgoetz@math.utexas.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C0DB856-23E5-41A2-A9F5-6E64F5A9FCB6@cs.rutgers.edu>
References: <D8F59140-83D4-49F8-A858-D163910F0CA1@rutgers.edu>
 <e6501675-7cb4-6f5b-78f7-abb1be332a34@math.utexas.edu>
 <506B20E8-CE9C-499B-BF53-6026BA132D30@rutgers.edu>
 <1EA88CB0-7639-479C-AB1D-CAF5C67AA5C5@redhat.com>
 <22DE8966-253D-49A7-936D-F0A0B5246BE6@rutgers.edu>
 <08DD4F45-E1CB-4FCB-BA0C-A6B8BD86FEDE@redhat.com>
 <5F282359-128D-4F72-B393-B87956DFE458@oracle.com>
 <EE014097-EDF8-484B-81DF-9E7012122BB9@rutgers.edu>
 <70E12E3F-2DFB-4557-9541-67276E5A195C@rutgers.edu>
To:     Charles Hedrick <hedrick@rutgers.edu>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-ClientProxiedBy: MN2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::19) To BL0PR14MB3588.namprd14.prod.outlook.com
 (2603:10b6:208:1cb::7)
MIME-Version: 1.0
Received: from smtpclient.apple (2620:0:d60:ac1a::a) by MN2PR15CA0006.namprd15.prod.outlook.com (2603:10b6:208:1b4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 19:46:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ff7ffbc-09ac-4fa0-bf39-08d98838cf26
X-MS-TrafficTypeDiagnostic: MN2PR14MB3965:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR14MB3965F034D2DDCF21B57BF9C5AAAF9@MN2PR14MB3965.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRpa8mTnXT89TxC+We6ae8jPk+PAI3Tj5fLgaVb1tdBJIjBpDNpEhIkypJnuFpk7PjtsCvRV7iJM2Lv4Cdw1+Tx18BX725ItrS2VRX8C/OpxNQYqYxTnktfu+SUyjWVRAMU/rHBw7XIgxJlNayXxkQmbltNs9NgMaJtAnsD/iv/JhPXENRFZRMoyBpvRKLn6unj6t5b7s10ApwMvb0C3Sx6P3oOCP3vcZ4PDDp2K5HFe61biBtO2fi9YJUGJlx/0sBvU9DzWU/CB1OsEoVrcwseEFnaTEGwHL+y8hjlYRo2pcIS/7jCVjGSsJ3/v01IUOQ7d6tt1ucs18xvxNurJSpzZbkqMVdJHSetK9bamm22V/DHphcXQ992DIyPuEVBZPEmedQ+rCpB0/LeqbMb+SD8QJZmIjYnqvUTjVo7l4E0b598Yk3rfOP6zQ4cMsU2rX4hM7OXHibK7nPYBG4kwN76+wfRQ5EQRg9GZHgvGOBP9ebNBFXFpJtnV+f43ezYF4VZLMuhOEcF2fqU+JVVNb+MHCZzTHIgQdNnfyG+FU1VEqDycGuv3W0QZi6y/H9IysKYEQ6RmJLHcV9twBJy8eNAX1VFqK07H1IbhXO+DJfWZ1sSIMc5pJRpvIGA9+0hD47D/lS2DRNswEgvq6yVpgogLuW47e8CW8YHLO8F1CYtnZSgmA7lLpDSWYs5ANWC83ZpwNgC4MQT64p8MJE+rbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(2906002)(508600001)(66476007)(186003)(6512007)(66556008)(4326008)(5660300002)(6862004)(66946007)(75432002)(6506007)(52116002)(8936002)(83170400001)(83380400001)(8676002)(2616005)(38100700002)(54906003)(6486002)(316002)(786003)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0MyVWdzWTVycHphc1M2VFRLTk1HdmRCNS8xV21lRTdTdFlNNTBqTktmYXhs?=
 =?utf-8?B?UFBYam9BaVdrcW1MVUROeGtYTTdHVkFXclNVVlRYenVmUmtRcTA0N3RvREZB?=
 =?utf-8?B?a1lodWlMc25UYjYrZDFDcGhacEUwMEx0T1p6NzJpcmtacmdlQlVubFFrTElF?=
 =?utf-8?B?aVJjVjdJU3V1OW1CVEk3RkoxY0p0RXBBVFRQNDMyNFZvakxvMWhYSHRVREhv?=
 =?utf-8?B?MkQvWEs1eVRyNkRKcTdIaWIrSFcxY2ltU3hRR25uY2d5angxN29IblgxQVNi?=
 =?utf-8?B?MnR1SC9URkdyc0ZwSXVIamNEY2xxWm9mYlV0RnR1SlRTUGxqN0pUOFlrNDFU?=
 =?utf-8?B?OXN3ZGc0ZlNSbHdZTHJCTVhHVUREVllmZGQ1RWMrakRTb084S2dXNFRZeFV0?=
 =?utf-8?B?ODJpck9Pd3dvY1gvN1NtQnozdHZMVmg5bHVaN2dZRTNGbnpsMWRYVHZsWng1?=
 =?utf-8?B?eXNXbDdTME5LaUEybWpQdXdZRUhrVDJ1OERUcFJqZ20yY0ZOcmZ6eUZEeWRs?=
 =?utf-8?B?VUtwK0xYWGN1dW5EeHY0MGF0OGFzeFZhSnNpeGYwNE0vSTVCd3ZuSVZDclBs?=
 =?utf-8?B?K25nOFpnR2pOU1p5aUNVUkpHc3g0cEdHbmNsTWtieTFwY054MXZHZzV3RU8w?=
 =?utf-8?B?MFI0RnZZZmdjT2Y5RGFCRko2TzcwZTF5RERUUUNPMkgxSUszNFVjU2kwZWk1?=
 =?utf-8?B?STJYbnc1enlhekJELzNJai9PU25WRGZ2QVErT3FmTkRYSnFSNm8wWVlMVnlL?=
 =?utf-8?B?cGhxZFU0RnI0ekNQcE9OcGlncWV1b0pIMjNEaXQ3RUFocmhYeVBTcG1CdW0v?=
 =?utf-8?B?Q2UwN25CQWpFaGpzUmtlZkxxeWpuek9reUt4VGduMU80Ky9SY2VEM1dFbW1i?=
 =?utf-8?B?RVJ2YWFMZk9KL0p4SHd2ZDhQVi94Um9NUm9hMlcrQ3lrQ1NVMitON2xSQ0Jp?=
 =?utf-8?B?Vm41V281ek90bGlrRm5hU1MyWU0vakdzdFhoZ1VML1JNdmNmalk2bU4rUzFY?=
 =?utf-8?B?YmVhd3I5akdUbk5kTXZ4STFKcStIbUFJbWw2TmJmZXhRUjFvb05UbGVyZEVD?=
 =?utf-8?B?Ky9NenRaeEd5MjhlemRDSGtaRThJSjRPa1ZmeklSU2tLeU5zQ1NJeldHcHdm?=
 =?utf-8?B?T0d2eXZpZkRYcUxBdnFLQTk3N04zTjRYeEVOWkc1b0RrTCt4SnpXMVNpazZo?=
 =?utf-8?B?RFNlZmdxRjg2aGQ3Rit4aUxqR0ZSSVRZbk0vQWNVZmh4eGs2VFZVUG5lcmdL?=
 =?utf-8?B?eHZJdE5DSFZHNWQyTlRUZTJMWm51Q0QrY2E2Rmk3MVBpcEh2ZFR1T25uUUZk?=
 =?utf-8?B?b1ZDZGppR3EvUjVTQ1h4bXZVTGdXZm5MamtkOW11ODhTMG85RFd1aGpCZ3kr?=
 =?utf-8?B?ZjVyTVEyUXpabFc0dFhEV05wVmt2ZUhJQWdzVk5LdzQ0U0lvWVM0MkM1cjdB?=
 =?utf-8?B?Ym1DTUlUR0dmVU5jT2ZiQzV2ZXMvVXVDRkJBOHA4cnJadm1jVm5HelViRU5W?=
 =?utf-8?B?Z1lyczZ4MVpDTUt6WFpyN1puVHl5djI4MTVZT2ErNUpEM3hYVGlWNVZjcGVq?=
 =?utf-8?B?Sy9TYkRIUTFiRG9HVFptY2R4TGRqcS9WLy9JdW5DalF2RXRFRG9HK1RDYVN6?=
 =?utf-8?B?QXhCenFLdEc4cGR3RUhVNEdYTVorMExVNWxiNDNmL1FFZHlsYk92eG9YQlhP?=
 =?utf-8?B?NVZSc0w2ekpKYzh6NVpEUzYrSU1za3Q5ekhUZDFBcWVKZzhpcW91VHQ5VDZ5?=
 =?utf-8?B?dksxc25PclRZaFZ1NE8wMTBpTy8xVHBuWkZiK0g3b1RHRnplRFJkczdIT0ZI?=
 =?utf-8?B?ZDF0dGl5anl2TFkwWXBNUT09?=
X-OriginatorOrg: cs.rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff7ffbc-09ac-4fa0-bf39-08d98838cf26
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 19:46:22.5949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +t9LOB5J1hSDb9+P1Dr+SaJAXUeypFCX+fLyXFt7A56577PiPJXrywiRz5RECA7YXk8qS41mHWUNPXU42pjN7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB3965
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We just found a nearly repeatable problem. If you run vmplayer (a desktop V=
M system from VMware). with its vm storage on NFS, the system eventually lo=
cks up. Some of the time. It happens consistently for one user, and I just =
saw it.

When we told the user for which it is consistent to move his vm=E2=80=99s t=
o local storage, the problem went away.

It tried running vmplayer. Shortly after starting to create a new VM, vmpla=
yer hung. I had another window with a shell. I went into the directory with=
 the vm files and did =E2=80=9Cls -ltrc=E2=80=9D. It didn=E2=80=99t quite h=
ang, but look about a minute to finish I also saw log entries from VMware c=
omplaining that disk operations took several seconds.

We saw this problem last semester consistentl, though I didn=E2=80=99t real=
ize a connection with vmplayer (if it existed). We fixed it by forcing moun=
ts to use NFS 4.0. Since delegations are now disabled on our server, I=E2=
=80=99m assuming that the problem is locking. We don=E2=80=99t normally use=
 locking a lot, but I believe that VMware uses it extensively.=20

The problem occurs on Ubuntu 20.04 with both the normal (5.4) and HWE (5.11=
) kernels.

Any thoughts? At the moment I=E2=80=99m tempted to force 4.0, but I=E2=80=
=99d like to be able to use 4.2 at some point. Since it still happens with =
5.11 it doesn=E2=80=99t look good. I=E2=80=99m willing to try a more recent=
 kernel if it=E2=80=99s likely to help.

We=E2=80=99re probably an unusual installation. We=E2=80=99re a CS departme=
nt, with researchers and also a large time-sharing environment for students=
 (spread across many machines, with a graphical interface using Xrdb, etc).=
 Our people use every piece of software under the sun.

Client and server are both Ubuntu 20.04. Server is on ZFS with NVMe storage=
.

