Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457913E4C43
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 20:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhHISi5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 14:38:57 -0400
Received: from mail-mw2nam10on2102.outbound.protection.outlook.com ([40.107.94.102]:16032
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232334AbhHISi4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Aug 2021 14:38:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ey3DEYIpTbzJcetyXSy3Kaxt77NDvEdcS0Q4cf4DD7MoP5c3K7Dt6YtffMOBQIVp4xkCXjj75uJlvPZeSqXmV3ugfBA4VMyPwE0kWM/GKIG/ReD8NeRJG2Nt6DUDEyJGDnnnfBXE/m04o+gVRzhCI8MSr613sMoyATNO0uzw2FgpA0Y26CSRBqYko75SP9QuwvpSGZTJx3pLzLCh1qzQntlBlX+za4Yevim+qM+cMVKoqUdSjkSxSra7u1o3XyblDJeMo/03B2Qdq82sdES0l5SWP4vtgIXlKKoT8CtT+enrlX/biQsrCS+3XhjYuInvYRqLt5ktR5fAJx6eJihz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5Gmt2W02Mkq3At2WhW85gHtU3LFyYqTAZybtn5kWLU=;
 b=i72ImQJQc6JJu4hm4jETBnoui9xTsU2itIfli3FhcXDvqKyYTKx1Id0O2ajVF123wu/057MfvKoe895bVXqihT036KCE/maAR/WwhT40deBQ/KwCOx6Frbeam3trj8dGWSFFKbfGLHIk/WB4FEeMRbqxClAFNWz7xyuhkqJFVcwaS5HKTlNmEbsBZ+tOmpt0sDFAF3EBbNTFx1qzRrYqJm63qajoxSkr7Q4uSwnpvfevxPGee2+5BSDyG9W0Q9lV4OxkDNRUrTHhBjZZRchUCLCa2xui0b41/Zcdg+19GXw/D2+5Siu0kyp5fjwSCotGeIjuM9imjAM9h9CeKqNsOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5Gmt2W02Mkq3At2WhW85gHtU3LFyYqTAZybtn5kWLU=;
 b=gOeoZZks0T6iDaI625lZMlLlHCdd8214UqnvT1CVzE7hrGxhtrDZb4b3IDcdm82/BTMi/aOpF40PvsI6y5tddtnFevuSCmKkUFEQskVIH/YT8xqmTQeA+aaXpQsrXqPf+UZL8BikJnTmv724xzmDwbamHE2mdSFc58XlSowQTKc=
Authentication-Results: raptorengineering.com; dkim=none (message not signed)
 header.d=none;raptorengineering.com; dmarc=none action=none
 header.from=rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by BL0PR14MB3682.namprd14.prod.outlook.com (2603:10b6:208:1c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 18:38:34 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::b821:bf6:30b6:e56d]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::b821:bf6:30b6:e56d%6]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 18:38:34 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
From:   hedrick@rutgers.edu
In-Reply-To: <1065010667.1047836.1628533859535.JavaMail.zimbra@raptorengineeringinc.com>
Date:   Mon, 9 Aug 2021 14:38:33 -0400
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <19368DD0-74CA-4DB7-9C1F-707106B50635@rutgers.edu>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
 <1288667080.5652.1625478421955.JavaMail.zimbra@raptorengineeringinc.com>
 <B4D8C4B7-EE8C-456C-A6C5-D25FF1F3608E@rutgers.edu>
 <3A4DF3BB-955C-4301-BBED-4D5F02959F71@rutgers.edu>
 <359473237.1035413.1628528802863.JavaMail.zimbra@raptorengineeringinc.com>
 <2FEAFB26-C723-450D-A115-1D82841BBF73@rutgers.edu>
 <77ED566A-7738-4F62-867C-1C2DFC5D34AB@oracle.com>
 <F5179A41-FB9A-4AB1-BE58-C2859DB7EC06@rutgers.edu>
 <1065010667.1047836.1628533859535.JavaMail.zimbra@raptorengineeringinc.com>
To:     Timothy Pearson <tpearson@raptorengineering.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-ClientProxiedBy: MN2PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::35) To BL0PR14MB3588.namprd14.prod.outlook.com
 (2603:10b6:208:1cb::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from smtpclient.apple (2620:0:d60:ac1a::a) by MN2PR07CA0025.namprd07.prod.outlook.com (2603:10b6:208:1a0::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 18:38:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64eb60aa-fa9f-4072-f5b8-08d95b64e4e3
X-MS-TrafficTypeDiagnostic: BL0PR14MB3682:
X-Microsoft-Antispam-PRVS: <BL0PR14MB3682B575611A55E61797E8EBAAF69@BL0PR14MB3682.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQ6D4bNs7jSGkwzjrHGci7n68XnAQN+BexNnLB73n0sK8dx/VqVh9GlntAQnORfzLHF2K2QvdNXU7wHECCxtUVsmDU05TEBS0Na+ylqAgryKLQUNI8rUjWadEQYFWJkNQrg/qfrw6Q3Q7bD+SDsLGFN9T8hKia2SH2gWRf7OdAyGEqS7avoypPjpw4fAlt66xr1Hl2TViBYWBpxpmlnWB69rJStU3kfZG/JVgAugIg3hlxHQgRDISE4jWiQqtfj2PaU0J3xWVfOlYAqo/6dhPZ5uz+me1vEr/AbWf2OeydayBb8lQuIF4a+1oC3KSyW0CSFigjnYZZLZepzmFMGCfC30MBaKitpqKuwN4+BarycBKszUve+fSfywJzz+v28hwnpgW9g0g+kOGSCpAyWeuKNlMUJZQGbCHU3a5MJq1GDb6644kK3y5p4EpkNto6Nj/O35xSNSBLS/WgJVR31CrFR55MAvCofY+YrNbmFEa2rFUySQ5dv26kNo26gGEqijRjexrGww2MJ81exoQDvbT0dBHr9tKlhL9W3j+RDLYlNP5lE1E71tAeBi7/YN8oKUfLPSBAd/3cCqDfgb6JsaB5sskrFHSdC8gyGqR6oF+BK5fQsrEWNfsJFc9DY6bN3bGseN1riNLCmoVDHUpWen7smn99ZjMnFEYY1FUoFqC2d5waPV9TDWwqx4J2UXOAgJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(2906002)(38100700002)(52116002)(66556008)(66946007)(66476007)(53546011)(4326008)(6506007)(186003)(75432002)(478600001)(5660300002)(54906003)(316002)(786003)(8936002)(83380400001)(8676002)(6512007)(6486002)(86362001)(36756003)(6916009)(9686003)(33656002)(2616005)(2292003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGtqYXJLQVJJcUtJbGRzUkhzTjhMQ1NSTVhOTWlPVFhtM3E2MEtBRDZpM080?=
 =?utf-8?B?RzZFMEwrbDl0TVdoYWsyT21yK01rb3lXb01wU1F6QUVDK051TWsxN0VIRFpm?=
 =?utf-8?B?VjkvaCtDWlhYakt1QnU5N2EzZEpQV0p0ZXl2ZXN0L1dGK0t5VHAzZHpHQ0hV?=
 =?utf-8?B?YU5ZYlFoaW9XaHFVTk9TTC9SU3JJQk9SK0ltRFdIK3ZRZVBTdUdDdEZiUmdV?=
 =?utf-8?B?TWlLYnJ5L3dSbE9LWmtKTHMzSm1wdVVZYTBqd2ZIWmszc2dmZUFIWjVrcEpK?=
 =?utf-8?B?UVhCUFNSUlFkN1NPTW90clpEQS9NamM1UDczTGxDd2t0UjdwUXhnR3BNN0tW?=
 =?utf-8?B?ZGFjc0Y1Zkd1Zmp4UFB5dXlaZm4rNVdFOElIWnFJc3lzMzJIYm9ZR3J3ZWZT?=
 =?utf-8?B?dFN5SFVhOTVSTVNIRW53dlZvZ2sydEx1ZUYzR3M5S0REb2F1dmpWajMvbXkv?=
 =?utf-8?B?TFZyNzJwRy9FYmx6WDJlSEsyVThySDFzc1F4cDdQWmNpYjUxZU4zN0kxYkR5?=
 =?utf-8?B?djkzbUNWRmZ2d2U4c29TWFcwN0NFZitNZ1lKcFFTY2VrSDNJYS9GcHZiKytQ?=
 =?utf-8?B?TXA4UnJadFd1L3M4emFqU1diRHN1Mk9hNTRhOFdNSytFSUlDSXRsb2lrWHZS?=
 =?utf-8?B?YTJnRk4xMWxGRWRwQm5SenBkL3lNUk9WZFJQZmFpL093dGhESHVKTTB2UnJL?=
 =?utf-8?B?blBVNnBMQVYrZGdSVVZFSjZLNkpCcUttUGorN1d6K3ZnbUNLa3JmNXp2bmZZ?=
 =?utf-8?B?V3RTeXZEWTR5dVUxZUhTY1VMb0VsUStXTDR1WXhmTEJ0eGduRGlsRkZ5c2R3?=
 =?utf-8?B?TGNxbHljdFBKdU5PMzZpdEV0R0xibEFWbUV4NTE4dkF5amFYQzhCZWV3QkZW?=
 =?utf-8?B?cnRVV3BhMDA2dUFTMWpXdE1icWtKdEhMNGRCUTZGeGlGRElOY3dxYWUxd3M1?=
 =?utf-8?B?RFJhWUNHVTlKdFVYUFpPVzZPcWxsY3lSMytsTjBSSVNBTmZnM0h1anFlZFI2?=
 =?utf-8?B?aUZaRU5SbnVJclBSLzAxWjE4R3dTQmVFMFJNbnlOK0czN2pidTUySHI5QnJ5?=
 =?utf-8?B?SjhzWjZEaGw1ajZNUCtPQTFzc3AyY0cvdG9wTGF6QU9MVDd0aTZySndEUzVJ?=
 =?utf-8?B?SWZ0Uk5GOWRFbGcyTzBDczh0Y3M0amZpakh5TnBWYUZpWlRHc01tbEZESjhJ?=
 =?utf-8?B?VS9leHVkVk55bm1SVTE3dGpPMFZOVDBIb1VMVS9JYjBsdVJhbnAvVDY2T3RR?=
 =?utf-8?B?Nmt0VG8wOU13LzlicDNqS0dxbmlkaFlKalp4OUJsYmM1NjNoS2JWc0JKU1pL?=
 =?utf-8?B?UTcyMGlEa3JsYUFXNi9qYVVIa3lnREFsSTlLMnk3bWhIbW5JcjlnT3hhQUZB?=
 =?utf-8?B?SmJaLysyUU5BMzFVS2I2OVd5cEplUzRvampqTTdOcTAxZmQ0S0p0OHNJSGNh?=
 =?utf-8?B?Y0pBUWtYaVdaS01rLytmVVExMkcyZnlIdFM0QnRnMElKTVh3bGNyUjNLOEYr?=
 =?utf-8?B?dFQvZklKbU8yQ3hwTTlOSHdoTC9mSWowRnBSRzNGclRSV2lQRHVvTmN6ZDlo?=
 =?utf-8?B?RElURmxXMzg4eEpXcENKMUZlMGRFQ3IwV2xxOTY2VCtaNFBkT2I4dWtzMkEx?=
 =?utf-8?B?eHk4Q0VKV3dhVjRIV2FDaThoMWpVeEVMenhPMVZFODJsQnBHWnJHNHlaSURx?=
 =?utf-8?B?VUg2bnNjeWhYeGtERWUwdnFZc29HZlliQnRRK2JTVnowK1VpRFhQWHJNNkVk?=
 =?utf-8?B?ZVJHMTJReGw2R0todWFUZnBqWEpzejZrQy9sYTlvRmFLa1A2NFdOUXYyTkoz?=
 =?utf-8?B?d1B6eWFNWnpQMFltcW1tdz09?=
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 64eb60aa-fa9f-4072-f5b8-08d95b64e4e3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 18:38:34.6021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtsCSlbyLQ5dtXPM7sXqZjY/iolxeBCfPA4ORh0EHe06JUg6zjok/J6P8lSzEcUte5QZVu2q3CdolxUQQlD++A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR14MB3682
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Does setting /proc/sys/fs/leases-enable to 0 work while the system is up? I=
 was expecting to see lslocks | grep DELE | wc go down. It=E2=80=99s not. I=
t=E2=80=99s staying around 1850.

> On Aug 9, 2021, at 2:30 PM, Timothy Pearson <tpearson@raptorengineering.c=
om> wrote:
>=20
> FWIW that's *exactly* what we see.  Eventually, if the server is left alo=
ne for enough time, even the login system stops responding -- it's as if th=
e I/O subsystem degrades and eventually blocks entirely.
>=20
> ----- Original Message -----
>> From: "hedrick" <hedrick@rutgers.edu>
>> To: "Chuck Lever" <chuck.lever@oracle.com>
>> Cc: "Timothy Pearson" <tpearson@raptorengineering.com>, "J. Bruce Fields=
" <bfields@fieldses.org>, "linux-nfs"
>> <linux-nfs@vger.kernel.org>
>> Sent: Monday, August 9, 2021 1:29:30 PM
>> Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy =
load
>=20
>> Evidence is ambiguous. It seems that NFS activity hangs. The first time =
this
>> occurred I saw a process at 100% running rpciod. I tried to do a =E2=80=
=9Csync=E2=80=9D and
>> reboot, but the sync hung.
>>=20
>> The last time I couldn=E2=80=99t get data, but the kernel was running an=
d responding to
>> ping. An ssh session responded to CR but when I tried to sudo it hung. A=
ttempt
>> to login hung. Oddly, even though the ssh session responded to CR, syslo=
g
>> entries on the local system stopped until the reboot. However we also se=
nd
>> syslog entries to a central server. Those continued and showed a continu=
ing set
>> of mounts and unmounts happening through the reboot.
>>=20
>> I was goiog to get a stack trace of the 100% process if that happened ag=
ain, but
>> last time I wasn=E2=80=99t in a situation to do that. I don=E2=80=99t th=
ink users will put up
>> with further attempts to debug, so for the moment I=E2=80=99m going to t=
ry disabling
>> delegations.
>>=20
>>> On Aug 9, 2021, at 1:37 PM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>>>=20
>>> Then when you say "server hangs" you mean that the entire NFS server
>>> system deadlocks. It's not just unresponsive on one or more exports.

