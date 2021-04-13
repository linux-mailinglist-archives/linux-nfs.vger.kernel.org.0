Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD5135E742
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 21:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhDMTsk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 15:48:40 -0400
Received: from mail-bn7nam10on2097.outbound.protection.outlook.com ([40.107.92.97]:22080
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229796AbhDMTsj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 13 Apr 2021 15:48:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeeYScEV0uih9M60ELrQ+e94oUGtbWQ4a+/hmS79lZbP7OYMYuAw87QVJpL4bnxLmVTngt5XFygr1hAhQflk3Eqtv1h4N3cesfGzkrdmOjib0iXVz8bFPXVNALcxOuSPQ+Dv/3eM7yl3E0TH4fdkdoLA+WPl4LL1ZEPVtuK3E33ILCPUkJwgs/EhwjP1ysP3kM4WRzVo26zaX4Fuk+cbXGPLktDWIkII4HN8heFj2aTPwasfITAdVkNLznbctJMCcXzroi6Sim4N3TUOS9RMfhjn8M7VwBQ22iL19twMA+OCOTcY1Y/LP1vgtW+VQCLsPgS+fjy/77AnMyNHZbbNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gydxc2mi79qrDXKkDEkuzIvUfsKU5ZK+lx9YjLQCV+8=;
 b=f+IOXQKe7CUQTsmgTrRkhaxiYnkkh954g6th4ddlxS1EhrdalciSU9Ib2hgc+EMe794Q4fAGKWAaXH4xtTCn2Ax0yUVRUwpW6G6syujL9/jq2bokp3g0ImISzA2q4xL3rOQDm5otdm2I9iRk7QyxXoM6RcKFl3ExdhzktmzLSPdCgWZEzsBIjOC7p0cY7KcstRD892h7g8IamcrA/C9w/JzSjXGvcO3LplsIE3j4CBalbsZ0qjor/oStkSQggr9NlyxB6VBW2GhiyUFn5uikunhLLT6wCBje37ijxqc1/MSeU8cx1WpctDwpEJdG62gMieoNGhjSvW80ga1SnD9a1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gydxc2mi79qrDXKkDEkuzIvUfsKU5ZK+lx9YjLQCV+8=;
 b=MRCzwkENE1kwotDRED0EL5MXfyLtMeFwyE4rqR+kZscCI+OzPs3LtCrM0GbEYraiVgDIXGDMtaXllpnGo7PaFqPzDbO6hCqboWljS+byjeglA9j5qbOTUkUzL3LKIjV+nusfYRMpMOb/MU3wqzNpM1Y1cZ7xVlJ2WW1ONAKigIY=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by BL1PR14MB4968.namprd14.prod.outlook.com (2603:10b6:208:311::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 19:48:17 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::2848:113d:4d17:51a0]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::2848:113d:4d17:51a0%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 19:48:17 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: safe versions of NFS
From:   hedrick@rutgers.edu
In-Reply-To: <EE014097-EDF8-484B-81DF-9E7012122BB9@rutgers.edu>
Date:   Tue, 13 Apr 2021 15:48:16 -0400
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Patrick Goetz <pgoetz@math.utexas.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <70E12E3F-2DFB-4557-9541-67276E5A195C@rutgers.edu>
References: <D8F59140-83D4-49F8-A858-D163910F0CA1@rutgers.edu>
 <e6501675-7cb4-6f5b-78f7-abb1be332a34@math.utexas.edu>
 <506B20E8-CE9C-499B-BF53-6026BA132D30@rutgers.edu>
 <1EA88CB0-7639-479C-AB1D-CAF5C67AA5C5@redhat.com>
 <22DE8966-253D-49A7-936D-F0A0B5246BE6@rutgers.edu>
 <08DD4F45-E1CB-4FCB-BA0C-A6B8BD86FEDE@redhat.com>
 <5F282359-128D-4F72-B393-B87956DFE458@oracle.com>
 <EE014097-EDF8-484B-81DF-9E7012122BB9@rutgers.edu>
To:     Chuck Lever III <chuck.lever@oracle.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
X-Originating-IP: [2620:0:d60:ac1a::a]
X-ClientProxiedBy: BL0PR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:207:3d::26) To BL0PR14MB3588.namprd14.prod.outlook.com
 (2603:10b6:208:1cb::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from heidelberg.cs.rutgers.edu (2620:0:d60:ac1a::a) by BL0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:207:3d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 19:48:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ecd1b0c-14f9-48ec-5af0-08d8feb51557
X-MS-TrafficTypeDiagnostic: BL1PR14MB4968:
X-Microsoft-Antispam-PRVS: <BL1PR14MB496881C2DB6559C83C26CB3BAA4F9@BL1PR14MB4968.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0/lvdnzEDLOXW8V1W4iofG1VTt3O/7tBW51tk9IjYxAO3gTbdPmFMTby+7ZIK18TlDVmJSHJpvvNt+KY60jSIlx/2dKcFMiKzWNLRc3N54j7b7TgWnlOJ0a2HRKlMnOqf4aPH6pvhhOSajlNz+M4QqEZuogdaapMSSt5CFumlknjGBflGnwTKTkaT/8E+fN+YC94okzeaz81VeGTUZBQ0724LPj67YvPMiYqDzM2xfvIEi/amHVMvIekCUZoMmPnB1Xtdcbq4MfUCo7Tbd1JQPUVeEcc3Zo/lgnthTzwxdR4/tHDO8XtvcSeurylYJNidgyQARUSr3SsjKDWQUq8VGN/F/V8dKRb7ZSOHOKr4EQxsyrhPksjw4W43S2xQM1+zGuLZsGSn+ni61xTXT+y/Zj7bE3THnqXb5LbsSSSQedMVU2nJ0BJnsTDjekLFNtoHiw1dKY1O6Y3gOaY+Sr2vQ5s4DgxlJmcUZar6pD1hjHvvLn28sQKNcxWrzwY3OohC3r6vdl//I43bfLv0mFnFKyYh56jTRTu3komfjSYajF3sZW7YD2SQWwfk3o1kcTikLx7lVltxhoNJZLTu8LTXufCxvojm1OQtrKOZXj6XVzwr4AQJRna23dVmzMfT5LTv2SSC4jkiyL6dNsO0zj7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(498600001)(186003)(16526019)(8936002)(52116002)(7696005)(75432002)(2906002)(33656002)(30864003)(53546011)(8676002)(66946007)(6916009)(36756003)(83380400001)(38100700002)(3480700007)(66476007)(54906003)(5660300002)(6486002)(2616005)(86362001)(4326008)(9686003)(66556008)(2292003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RlM0ZTY5UlUwL2hDbW0xditwU2JBZmViMzd4T2JVQVZxVzVmL09iZzVkRkhs?=
 =?utf-8?B?M0JQNE51V1FuK2swUW9uWElyUjNNR1Vza3RsQzNINmsxR1ViYm9EaElPdjBX?=
 =?utf-8?B?bXUwcmZyZXhDMGpLWElNZkxKV2V3VWVkdHUvQlpmUmFLck1oYzJtUkdiMHBQ?=
 =?utf-8?B?QjkyNW0vY28xekpIWHFPTURCUkFiaVRJWHlJN2tuMWhuUmRoTUl2VkhDdktM?=
 =?utf-8?B?MnZkaDExM1BzblZaQnoxK3VzTXpwWGNUL0RCaEJwTHAwbEpPM3ZiREJveFgr?=
 =?utf-8?B?cXhmSkZJREErTU0rbm5vYytybHJ1SGw0dkdHczVoVEFyZWhrR29MSThrQVhh?=
 =?utf-8?B?K0E0UGx0WDdNN0kvNEZ2RXo3YjlHZHhiSGRDL0JkeVFrNVlaQTJTa0IrSzc4?=
 =?utf-8?B?bHBmZ2ZjRngxUXdhbDMrYk5hNHdJNms5WlpwdUpYSEJRdFBqQU5KSTVJZ2dF?=
 =?utf-8?B?bkZyVDBEQkhlcld0YVV3SXRoYjIvRDJETWRHOUd4T0FmcENwMjFialN6TTUx?=
 =?utf-8?B?UjdwSXJGQ0ZKT2JFLzdYQU85N1MyTkJOMU5sU21kZlNZSDRkTnVhdkU1Y1Qv?=
 =?utf-8?B?bjMzb3pQSy9QdFAyalllZVlsOHM5Qk9PMXRKdDdCRkZERXV1WlVkOWJJdDlN?=
 =?utf-8?B?Yk1JTVl4TW1ZVzk1Z3Y0YTZEa2I4UHAvZ1M2UG45dzgzMkJheW9jNEQwZ081?=
 =?utf-8?B?NUplR2NNL3NnNndRejRCWW15SDg5bWFTTUJBbUpyZWxPcHdmRnFNUGJIWm1h?=
 =?utf-8?B?ZVV2QUZOaWdaMVhZbWhwdG0rK2l4Zy9EbkUzMTl5WjdDNTA0NGVIU0NKZHhL?=
 =?utf-8?B?V2tWNmlJWG9uV2Myb0xlaGx6amo2dzRad1ZiUzUwZEdTRzFYelZZYkZ4Uml5?=
 =?utf-8?B?QlozKzEva2pMM1M1aEZqRmVuMTF2WUV4R3puaC9iMk4zRmd0cHRLNldGWGxi?=
 =?utf-8?B?RVVRSEhNbDNJQU0xVFNwTGg3ZmVKTDJ0TXBvRDYzaUd2OXBrK2N5blo4bG4z?=
 =?utf-8?B?cGVBMkdaK0s5eENRNkkwMW1RYnJPMFpiTGJtcWRGYlVXREtvMDV0M0lFWTEz?=
 =?utf-8?B?emwzYlQwMWV5TzAyMSs5MzBHVm4yc1RUUWEzd0Q0dGxhWFIwNUR2U3g5bytr?=
 =?utf-8?B?TkxDMGlnTUkzT3M2cUFNK1l4ZWJycHhJb3pRWTRwMi8vME8vVXE0MnVmbFpk?=
 =?utf-8?B?Mi9VbWpheVkvRE9PL09ldFBmcTM0ODlLWkF6S2p4eVRCVUp6RHVMMnozUHRD?=
 =?utf-8?B?TUpKeWpWaUIzMHYyM1hGV2FlbFpYZmZmTGVWZE5ySUVucFZ6ZElMVGl4S0Jw?=
 =?utf-8?B?cCtYZ0dHdHNCbk9BdnBHa0lDMUpCeDFFZ2N1aEs4bTdTM3VTcURSQ09tYVlj?=
 =?utf-8?B?eGovQmNnNnRlRy9OblVqM2ptUXdWeElVRDVUQmdhRzRqUVhJdFp3MlJSemRZ?=
 =?utf-8?B?V29TK2JuMGVuaVg2YUVjblVtb21TTTNtOTVKc2p6ZjBnd2ZoaTZDZ0J5b1pM?=
 =?utf-8?B?ekZIZ3JCTlJRVG1zVXVsRUt1NEllc2Myd1FtZFlXNWlOS3kyVUNpOHl6RWVj?=
 =?utf-8?B?RnQ5cGJOVCtpNUVMcWxQVStpdXNLazNXY2hpUXJHUlJUMTFLS3JYOW9DNisw?=
 =?utf-8?B?SzN6UXdBbXJDNzJMSm1waVJ6RnZjVjd2ZjAxS01wSjl1dXI5L2phb2Y0R3VE?=
 =?utf-8?B?OUlpZ3JKOXdpcVhBcDliMVBDc1Q0S1V2UmhmRXpCL1lFWFZ2NTNGQzh4QW1y?=
 =?utf-8?B?NVY0WEVVWkZsUWRyTVc2NXVPa3NUbnhKUmVGYmFuanhVeGV2a2o0YTBJSE1y?=
 =?utf-8?B?Z3QrWmRPOHJ2V2RUT2hNUT09?=
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecd1b0c-14f9-48ec-5af0-08d8feb51557
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 19:48:17.4891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v25NoT+tEi9kdmA4CjJUhmWw23zn1AXaGMwhpzIgQETZRBNpBi/DySJK8cr1H4Ci7h8PXIH/YZBSIyXgZd99/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR14MB4968
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I have log entries for two Ubuntu 18 systems, but there=E2=80=99s no way to=
 get you a network trace for them without using a time machine.

> On Apr 13, 2021, at 3:40 PM, hedrick@rutgers.edu wrote:
>=20
> This is from Centos 7.9, with all file systems mounted via NFS 4.0 (in th=
eory =E2=80=94 there may be 4.2 that were unmounted =E2=80=94lazy):
>=20
> 463 106.786384244 172.17.141.150 -> 172.17.11.218 TCP 66 nlogin > nfs [AC=
K] Seq=3D39641 Ack=3D46777 Win=3D24576 Len=3D0 TSval=3D520277320 TSecr=3D14=
78982393
> 464 108.000270192 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS =
FH: 0xe696b554, [Check: RD LU MD XT DL]
> 465 108.000361904 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS =
FH: 0xd61aa475, [Check: RD LU MD XT DL]
> 466 108.000476711 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call =
In 464) ACCESS, [Allowed: RD LU MD XT DL]
> 467 108.000495290 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK]=
 Seq=3D9189 Ack=3D8761 Win=3D16605 Len=3D0 TSval=3D520278534 TSecr=3D147898=
3647
> 468 108.000591598 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call =
In 465) ACCESS, [Allowed: RD LU MD XT DL]
> 469 108.000608160 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK]=
 Seq=3D9189 Ack=3D8917 Win=3D16605 Len=3D0 TSval=3D520278534 TSecr=3D147898=
3647
> 470 118.952127064 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS =
FH: 0xef7d152e, [Check: RD LU MD XT DL]
> 471 118.952356881 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call =
In 470) ACCESS, [Allowed: RD LU MD XT DL]
> 472 118.952372768 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK]=
 Seq=3D9361 Ack=3D9073 Win=3D16605 Len=3D0 TSval=3D520289486 TSecr=3D147899=
4599
> 473 119.999835420 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS =
FH: 0x94a968d5, [Check: RD LU MD XT DL]
> 474 120.000067817 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call =
In 473) ACCESS, [Allowed: RD LU MD XT DL]
> 475 120.000082882 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK]=
 Seq=3D9533 Ack=3D9229 Win=3D16605 Len=3D0 TSval=3D520290533 TSecr=3D147899=
5646
> 476 140.000587688 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS =
FH: 0xe696b554, [Check: RD LU MD XT DL]
> 477 140.000688677 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS =
FH: 0xd61aa475, [Check: RD LU MD XT DL]
> 478 140.000746915 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call =
In 476) ACCESS, [Allowed: RD LU MD XT DL]
> 479 140.000759241 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK]=
 Seq=3D9877 Ack=3D9385 Win=3D16605 Len=3D0 TSval=3D520310534 TSecr=3D147901=
5647
> 480 140.000830146 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call =
In 477) ACCESS, [Allowed: RD LU MD XT DL]
> 481 140.000836443 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK]=
 Seq=3D9877 Ack=3D9541 Win=3D16605 Len=3D0 TSval=3D520310534 TSecr=3D147901=
5647
> 482 148.442466129 172.17.141.150 -> 172.17.11.218 NFS 226 V4 Call RENEW C=
ID: 0x04da
> 483 148.442650203 172.17.11.218 -> 172.17.141.150 NFS 182 V4 Reply (Call =
In 482) RENEW
> 484 148.442664846 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK]=
 Seq=3D10037 Ack=3D9657 Win=3D16605 Len=3D0 TSval=3D520318976 TSecr=3D14790=
24089
> 485 149.953317362 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS =
FH: 0xef7d152e, [Check: RD LU MD XT DL]
> 486 149.953550872 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call =
In 485) ACCESS, [Allowed: RD LU MD XT DL]
> 487 149.953565993 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK]=
 Seq=3D10209 Ack=3D9813 Win=3D16605 Len=3D0 TSval=3D520320487 TSecr=3D14790=
25600
> 488 162.000571296 172.17.141.150 -> 172.17.11.218 NFS 226 V4 Call ACCESS =
FH: 0xcd1903be, [Check: RD LU MD XT DL]
> 489 162.000794395 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call =
In 488) ACCESS, [Access Denied: MD XT DL], [Allowed: RD LU]
> 490 162.000825598 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK]=
 Seq=3D10369 Ack=3D9969 Win=3D16605 Len=3D0 TSval=3D520332534 TSecr=3D14790=
37647
> 491 162.000998283 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS =
FH: 0xeabd4697, [Check: RD LU MD XT DL]
> 492 162.001218772 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call =
In 491) ACCESS, [Allowed: RD LU MD XT DL]
> 493 162.040415201 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK]=
 Seq=3D10541 Ack=3D10125 Win=3D16605 Len=3D0 TSval=3D520332574 TSecr=3D1479=
037647
> 494 166.874398617 172.17.141.150 -> 172.17.11.218 TCP 66 [TCP Keep-Alive]=
 nlogin > nfs [ACK] Seq=3D39640 Ack=3D46777 Win=3D24576 Len=3D0 TSval=3D520=
337408 TSecr=3D1478982393
> 495 166.874438892 172.17.141.150 -> 172.17.11.218 NFS 250 V4 Call SEQUENC=
E
> 496 166.874506845 172.17.11.218 -> 172.17.141.150 TCP 66 [TCP Dup ACK 462=
#1] nfs > nlogin [ACK] Seq=3D46777 Ack=3D39641 Win=3D24559 Len=3D0 TSval=3D=
1479042521 TSecr=3D520277320
> 497 166.874720218 172.17.11.218 -> 172.17.141.150 NFS 218 V4 Reply (Call =
In 495) SEQUENCE
> 498 166.874730215 172.17.141.150 -> 172.17.11.218 TCP 66 nlogin > nfs [AC=
K] Seq=3D39825 Ack=3D46929 Win=3D24575 Len=3D0 TSval=3D520337408 TSecr=3D14=
79042521
> 499 166.874987010 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 500 166.875172744 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 499) TEST_STATEID
> 501 166.875309487 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x534735df/
> 502 166.875655661 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 501) OPEN StateID: 0xd7ae
> 503 166.875801366 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 504 166.876042044 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 503) TEST_STATEID
> 505 166.876210946 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0xdabfc399/
> 506 166.876485761 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 505) OPEN StateID: 0x9578
> 507 166.876607463 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0xdabfc399/
> 508 166.876820365 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 507) OPEN StateID: 0xfa83
> 509 166.876941430 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 510 166.877123487 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 509) TEST_STATEID
> 511 166.877205876 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x968ca393/
> 512 166.877464268 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 511) OPEN StateID: 0x25d5
> 513 166.877600104 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 514 166.877841822 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 513) TEST_STATEID
> 515 166.877997847 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0xde4187cf/
> 516 166.878265626 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 515) OPEN StateID: 0xd5ce
> 517 166.878393548 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 518 166.878603997 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 517) TEST_STATEID
> 519 166.878692334 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x9f6703e9/
> 520 166.878920958 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 519) OPEN StateID: 0x69a1
> 521 166.878964818 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 522 166.879156141 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 521) TEST_STATEID
> 523 166.879195140 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0xe5c84183/
> 524 166.879435831 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 523) OPEN StateID: 0x6069
> 525 166.879518910 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 526 166.879709592 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 525) TEST_STATEID
> 527 166.879796731 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x927973ae/
> 528 166.880024682 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 527) OPEN StateID: 0xf420
> 529 166.880070944 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x927973ae/
> 530 166.880265884 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 529) OPEN StateID: 0xec63
> 531 166.880301034 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 532 166.880511051 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 531) TEST_STATEID
> 533 166.880575938 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x05761d23/
> 534 166.880798417 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 533) OPEN StateID: 0xb199
> 535 166.880840801 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 536 166.881008021 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 535) TEST_STATEID
> 537 166.881043797 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0xb6b205f7/
> 538 166.881270127 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 537) OPEN StateID: 0x49df
> 539 166.881304710 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0xb6b205f7/
> 540 166.881498628 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 539) OPEN StateID: 0xf0d5
> 541 166.881545126 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 542 166.881732646 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 541) TEST_STATEID
> 543 166.881775578 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x0183cd1e/
> 544 166.881978864 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 543) OPEN StateID: 0x546d
> 545 166.882021595 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 546 166.882209030 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 545) TEST_STATEID
> 547 166.882252306 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x673ef4c3/
> 548 166.882484514 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 547) OPEN StateID: 0xa46d
> 549 166.882523043 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x673ef4c3/
> 550 166.882710061 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 549) OPEN StateID: 0xaa9a
> 551 166.882750420 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 552 166.882933338 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 551) TEST_STATEID
> 553 166.882961488 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x3699764a/
> 554 166.883192776 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 553) OPEN StateID: 0x3c37
> 555 166.883223581 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 556 166.883407176 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 555) TEST_STATEID
> 557 166.883468198 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x94fd1187/
> 558 166.883679012 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 557) OPEN StateID: 0xbedf
> 559 166.883719911 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 560 166.883910224 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 559) TEST_STATEID
> 561 166.883937791 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0xcd96c73b/
> 562 166.884165115 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 561) OPEN StateID: 0xbf6c
> 563 166.884194351 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 564 166.884378426 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 563) TEST_STATEID
> 565 166.884433848 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0xd24bb22d/
> 566 166.884661584 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 565) OPEN StateID: 0xaaf5
> 567 166.884719445 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 568 166.884904098 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 567) TEST_STATEID
> 569 166.884952255 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x5e594598/
> 570 166.885154240 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 569) OPEN StateID: 0x11cb
> 571 166.885206342 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 572 166.885389478 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 571) TEST_STATEID
> 573 166.885454506 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0xa4fd80c1/
> 574 166.885686638 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 573) OPEN StateID: 0x9363
> 575 166.885745762 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 576 166.885933232 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 575) TEST_STATEID
> 577 166.885980692 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x80e4743a/
> 578 166.886212637 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 577) OPEN StateID: 0x63af
> 579 166.886272585 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 580 166.886457823 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 579) TEST_STATEID
> 581 166.886514332 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0xb3e2d284/
> 582 166.886742488 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 581) OPEN StateID: 0x52d9
> 583 166.886803826 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 584 166.886989516 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 583) TEST_STATEID
> 585 166.887100351 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x95137efa/
> 586 166.887304377 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 585) OPEN StateID: 0xb26e
> 587 166.887395696 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 588 166.887587544 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 587) TEST_STATEID
> 589 166.887703373 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x1d70394e/
> 590 166.887919160 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 589) OPEN StateID: 0x753c
> 591 166.887999278 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 592 166.888190709 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 591) TEST_STATEID
> 593 166.888298867 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x680da7ff/
> 594 166.888530666 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 593) OPEN StateID: 0x097c
> 595 166.888605330 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 596 166.888795331 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 595) TEST_STATEID
> 597 166.888902566 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x0a52a987/
> 598 166.889113308 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 597) OPEN StateID: 0x7781
> 599 166.889162100 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 600 166.889353078 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 599) TEST_STATEID
> 601 166.889461157 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x56462642/
> 602 166.889699242 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 601) OPEN StateID: 0xb209
> 603 166.889772552 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 604 166.889963172 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 603) TEST_STATEID
> 605 166.890070241 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x850c0567/
> 606 166.890272350 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 605) OPEN StateID: 0x8134
> 607 166.890335412 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 608 166.890542793 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 607) TEST_STATEID
> 609 166.890650208 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x31aa2390/
> 610 166.890886053 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 609) OPEN StateID: 0x1f30
> 611 166.890959992 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 612 166.891158969 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 611) TEST_STATEID
> 613 166.891264349 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x2ae7f451/
> 614 166.891516937 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 613) OPEN StateID: 0x3fce
> 615 166.891591778 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 616 166.891788024 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 615) TEST_STATEID
> 617 166.891902329 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0xa5cb13d3/
> 618 166.892117369 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 617) OPEN StateID: 0x03d6
> 619 166.892175933 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 620 166.892398086 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 619) TEST_STATEID
> 621 166.892447518 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x3f5cfcdb/
> 622 166.892671544 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 621) OPEN StateID: 0x8bff
> 623 166.892716533 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 624 166.892901971 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 623) TEST_STATEID
> 625 166.892940753 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x40b4d194/
> 626 166.893167930 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 625) OPEN StateID: 0xe3e8
> 627 166.893215973 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 628 166.893398652 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 627) TEST_STATEID
> 629 166.893445197 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x4643d6fc/
> 630 166.893682547 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 629) OPEN StateID: 0xe194
> 631 166.893731829 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 632 166.893915920 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 631) TEST_STATEID
> 633 166.893960986 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0xd246cbd3/
> 634 166.894191435 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 633) OPEN StateID: 0x22f5
> 635 166.894240889 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 636 166.894425035 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 635) TEST_STATEID
> 637 166.894470784 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0xde40a6e1/
> 638 166.894695618 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 637) OPEN StateID: 0x9ce2
> 639 166.894744788 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 640 166.894929372 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 639) TEST_STATEID
> 641 166.894967975 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x0f26a4dc/
> 642 166.895197152 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 641) OPEN StateID: 0x879c
> 643 166.895245038 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 644 166.895429467 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 643) TEST_STATEID
> 645 166.895471234 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x82162062/
> 646 166.895694775 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 645) OPEN StateID: 0xab68
> 647 166.895744208 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 648 166.895929221 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 647) TEST_STATEID
> 649 166.895973162 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0xb8b3b57f/
> 650 166.896197535 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 649) OPEN StateID: 0xfb0b
> 651 166.896245960 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 652 166.896430271 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 651) TEST_STATEID
> 653 166.896475752 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x2e6c2b31/
> 654 166.896705501 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 653) OPEN StateID: 0x8e00
> 655 166.896754419 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 656 166.896939911 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 655) TEST_STATEID
> 657 166.896983440 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x547cf5ea/
> 658 166.897209526 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 657) OPEN StateID: 0x0532
> 659 166.897258079 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_ST=
ATEID
> 660 166.897443527 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call =
In 659) TEST_STATEID
> 661 166.897484081 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN DH=
: 0x33c176ce/
> 662 166.897693578 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call =
In 661) OPEN StateID: 0x3648
> 663 166.937386876 172.17.141.150 -> 172.17.11.218 TCP 66 nlogin > nfs [AC=
K] Seq=3D59461 Ack=3D70165 Win=3D24576 Len=3D0 TSval=3D520337471 TSecr=3D14=
79042544
> ^C663 packets captured
> [hedrick@camaro ~]$=20
>=20
> Here=E2=80=99s the corresponding section of /var/log/messages
>=20
> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: nfs4_reclaim_open_state: =
1 callbacks suppressed
> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_st=
ate: Lock reclaim failed!
> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_st=
ate: Lock reclaim failed!
> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_st=
ate: Lock reclaim failed!
> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_st=
ate: Lock reclaim failed!
> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_st=
ate: Lock reclaim failed!
> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_st=
ate: Lock reclaim failed!
> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_st=
ate: Lock reclaim failed!
> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_st=
ate: Lock reclaim failed!
> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_st=
ate: Lock reclaim failed!
> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_st=
ate: Lock reclaim failed!
>=20
>=20
>=20
>=20
>> On Apr 13, 2021, at 1:24 PM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>>=20
>>=20
>>=20
>>> On Apr 13, 2021, at 12:23 PM, Benjamin Coddington <bcodding@redhat.com>=
 wrote:
>>>=20
>>> (resending this as it bounced off the list - I accidentally embedded HT=
ML)
>>>=20
>>> Yes, if you're pretty sure your hostnames are all different, the client=
_ids
>>> should be different.  For v4.0 you can turn on debugging (rpcdebug -m n=
fs -s
>>> proc) and see the client_id in the kernel log in lines that look like: =
"NFS
>>> call setclientid auth=3D%s, '%s'\n", which will happen at mount time, b=
ut it
>>> doesn't look like we have any debugging for v4.1 and v4.2 for EXCHANGE_=
ID.
>>>=20
>>> You can extract it via the crash utility, or via systemtap, or by doing=
 a
>>> wire capture, but nothing that's easily translated to running across a =
large
>>> number of machines.  There's probably other ways, perhaps we should tac=
k
>>> that string into the tracepoints for exchange_id and setclientid.
>>>=20
>>> If you're interested in troubleshooting, wire capture's usually the mos=
t
>>> informative.  If the lockup events all happen at the same time, there
>>> might be some network event that is triggering the issue.
>>>=20
>>> You should expect NFSv4.1 to be rock-solid.  Its rare we have reports
>>> that it isn't, and I'd love to know why you're having these problems.
>>=20
>> I echo that: NFSv4.1 protocol and implementation are mature, so if
>> there are operational problems, it should be root-caused.
>>=20
>> NFSv4.1 uses a uniform client ID. That should be the "good" one,
>> not the NFSv4.0 one that has a non-zero probability of collision.
>>=20
>> Charles, please let us know if there are particular workloads that
>> trigger the lock reclaim failure. A narrow reproducer would help
>> get to the root issue quickly.
>>=20
>>=20
>>> Ben
>>>=20
>>> On 13 Apr 2021, at 11:38, hedrick@rutgers.edu wrote:
>>>=20
>>>> The server is ubuntu 20, with a ZFS file system.
>>>>=20
>>>> I don=E2=80=99t set the unique ID. Documentation claims that it is set=
 from the hostname. They will surely be unique, or the whole world would bl=
ow up. How can I check the actual unique ID being used? The kernel reports =
a blank one, but I think that just means to use the hostname. We could obvi=
ously set a unique one if that would be useful.
>>>>=20
>>>>> On Apr 13, 2021, at 11:35 AM, Benjamin Coddington <bcodding@redhat.co=
m> wrote:
>>>>>=20
>>>>> It would be interesting to know why your clients are failing to recla=
im their locks.  Something is misconfigured.  What server are you using, an=
d is there anything fancy on the server-side (like HA)?  Is it possible tha=
t you have clients with the same nfs4_unique_id?
>>>>>=20
>>>>> Ben
>>>>>=20
>>>>> On 13 Apr 2021, at 11:17, hedrick@rutgers.edu wrote:
>>>>>=20
>>>>>> many, though not all, of the problems are =E2=80=9Clock reclaim fail=
ed=E2=80=9D.
>>>>>>=20
>>>>>>> On Apr 13, 2021, at 10:52 AM, Patrick Goetz <pgoetz@math.utexas.edu=
> wrote:
>>>>>>>=20
>>>>>>> I use NFS 4.2 with Ubuntu 18/20 workstations and Ubuntu 18/20 serve=
rs and haven't had any problems.
>>>>>>>=20
>>>>>>> Check your configuration files; the last time I experienced somethi=
ng like this it's because I inadvertently used the same fsid on two differe=
nt exports. Also recommend exporting top level directories only.  Bind moun=
t everything you want to export into /srv/nfs and only export those directo=
ries. According to Bruce F. this doesn't buy you any security (I still don'=
t understand why), but it makes for a cleaner system configuration.
>>>>>>>=20
>>>>>>> On 4/13/21 9:33 AM, hedrick@rutgers.edu wrote:
>>>>>>>> I am in charge of a large computer science dept computing infrastr=
ucture. We have a variety of student and develo9pment users. If there are p=
roblems we=E2=80=99ll see them.
>>>>>>>> We use an Ubuntu 20 server, with NVMe storage.
>>>>>>>> I=E2=80=99ve just had to move Centos 7 and Ubuntu 18 to use NFS 4.=
0. We had hangs with NFS 4.1 and 4.2. Files would appear to be locked, alth=
ough eventually the lock would time out. It=E2=80=99s too soon to be sure t=
hat moving back to NFS 4.0 will fix it. Next is either NFS 3 or disabling d=
elegations on the server.
>>>>>>>> Are there known versions of NFS that are safe to use in production=
 for various kernel versions? The one we=E2=80=99re most interested in is U=
buntu 20, which can be anything from 5.4 to 5.8.
>>>>>=20
>>>=20
>>>=20
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20

