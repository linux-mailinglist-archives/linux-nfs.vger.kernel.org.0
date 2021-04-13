Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2A35E62E
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 20:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbhDMSUm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 14:20:42 -0400
Received: from mail-bn8nam12on2125.outbound.protection.outlook.com ([40.107.237.125]:64025
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236781AbhDMSUm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 13 Apr 2021 14:20:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAVK4iDUW1ccyCOZZExLE0b4YrjSdyATyhDtEU4V6RneYwXN1WnVjS2+8w5KBk52NPR6akFyxaujTksdxnHCRplyNJlSTCrLRkF7eZ8CE6JgI/U19Nful6kq8n4bAdS+QLu2QZEiU3e75ha4I49DWSI0c7s7rQHuBAyiu7Whu2gE0m61H6OTTZZzFRJeFg468mQeFpVQayGKWQQaK0kXaheQqJBA2DpNBIKcbGQAytitMFWZgxgFo1bqY68S6seQNOf9wtwp3mToHddR9vqubejju9oHkZg+hDkwSTIDFQZKUgaTFaGFwAjsxk/EC95Lkc8G90oR3lVf5xUVticLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GibwMgtZT5J1Bn4dpSCVzzC6xHCho28XPmEY7Ru8jYw=;
 b=TzI9wn/vVvqExccQ+lJ3kVOo3p85PmOpS7WZlfS27F66bU3CaJyhzDNtZwK8dXBe4G9WwfnKiWEJVX4TXQpREb3ASI9CaxegypSVNu+QZtqRHZG2J5BUH+5XOaGPWRZajdJ1usl5fz6pV9UFFbRr2CRLFBscNiwnGh2wQtE6kgBx5Vmmm+xBVCZtdSehlNN8dWgBo6tO2iFf8auuqKqbjYPen+/9QPIeSnoCAM0hDl/VDu373RPZbjwRP5GvPAhLn+LKwLNdjhvDkwPo8F66RYcTEW48NSPo7oPSOOTv5HdRxXEbAjvJNsFb/GwntSncgsSiV+PZU5koFohNPZoifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GibwMgtZT5J1Bn4dpSCVzzC6xHCho28XPmEY7Ru8jYw=;
 b=Brr4k+sgJZGvwhoGG2BVbGdMHcfa3+aU0Ovd2l5eRyxfhdbC/Z/2hc4x811AFKeSaAw+NE2KOKcdcyz/Fs8UlC4WUXtaOFQh8H2wtaipbyyy+npOyvR8s53rHibfZL43HeXdmUX9TQnjfUKeMP25kEb1LmMJkSoUsVg2N9HwTKE=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by BL0PR14MB3779.namprd14.prod.outlook.com (2603:10b6:208:1c7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Tue, 13 Apr
 2021 18:20:21 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::2848:113d:4d17:51a0]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::2848:113d:4d17:51a0%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 18:20:21 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: safe versions of NFS
From:   hedrick@rutgers.edu
In-Reply-To: <5F282359-128D-4F72-B393-B87956DFE458@oracle.com>
Date:   Tue, 13 Apr 2021 14:20:19 -0400
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Patrick Goetz <pgoetz@math.utexas.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7AABD034-1617-43C8-B035-2CE34B22170C@rutgers.edu>
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
X-ClientProxiedBy: MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44)
 To BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from heidelberg.cs.rutgers.edu (2620:0:d60:ac1a::a) by MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 13 Apr 2021 18:20:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b3cd2cc-75f4-4397-b878-08d8fea8cc54
X-MS-TrafficTypeDiagnostic: BL0PR14MB3779:
X-Microsoft-Antispam-PRVS: <BL0PR14MB3779DD41B24CE3D8B1E31506AA4F9@BL0PR14MB3779.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBlYgHKINTlE9e0zhNw2ik/GdKf0tqzdJvC1XEd9H6B6ptZuDtNYmPCntniS6Biu2bpIQU3me2CqQLgJIFBmLGILe6EVEn8FD1eKhUXPdjqOTzKy+355JPoJ3/KsasbkbRW6Spb2PqI1D9dJb+PVDg5AkZjMo51BlTwu+/jAXH70gq0XjsNUMhvX/uW8Awd1OoQt/hMg85OQ3YlqN5U43UyYFeEf5ksHVPFec5w9aR6atC7dNBL5aXY/Wf1SW035AMODdF50PH+hvHi+O4i4+cn4A7hHzBq1iGKtwwy/FCEoQdwRHoGFPIBbJ5Zw/JpsxTmadkgN0vHEtMy40vBgkrsvUWAHe7obu58xcDR7NHZ/riDhlRzvoY+V1wzqiFWOWPTXiqZUhRXmkPYgQWejDjYaJRQDPPLSCYTNyjpaPRbHmEYvb3h9Jr13wPlEcy427JTNaDpDLFItfQYqkCeGzXgb+b2flnE5LgKGnP17677TY/9et2CQFmn/cCi30OyzVuvAfHNCYrU6G3xK2nnQhje+B26qO3YqFUfayPRIlvkwNf4tzEhTi3IomfT0ndT72RT6qszHi43hQCYFGtogXbYlJoRFUYIWd+U+QPPqKtaTgkX0GBFwcVinCB4/pny59nOM366mtnCXQVDRALQ1sQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(6486002)(6916009)(16526019)(2616005)(75432002)(4326008)(186003)(7696005)(52116002)(66556008)(53546011)(5660300002)(86362001)(66476007)(316002)(786003)(54906003)(33656002)(3480700007)(66946007)(8936002)(8676002)(478600001)(2906002)(83380400001)(36756003)(9686003)(38100700002)(2292003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M0NWYU41dGRIZzN4N2NvenQrNEhkQ1lVYStsMi9jNzdLcDhkWkJVTU1DM2pv?=
 =?utf-8?B?cit2emJkcy9iTzR0RStLOUY3dDZ2NEhtWmJIWHhZZG1nbjNSY3dYbEowTStG?=
 =?utf-8?B?V1V6blNOSUFORHNBMXphbFR2M0trMDNCY3d0Q05pejhObGZrM1dXRzhyYTlU?=
 =?utf-8?B?aWcyY3o5TUNuT0NKVUxKNnVCNkprYTVpdTJHczFHN0pEVEpuSjYwbnJVcVRt?=
 =?utf-8?B?OFVhMTN1aGk2R1FhOExNUWZlejljV3E5T1hEODVub2U5bUxOQWpPKzJ0NEUz?=
 =?utf-8?B?TGtmbmtKZkhPQXhSZFlBNktjQWZiNWkvVi9VYTgzYy8wZTJRNVNmbFJoczFK?=
 =?utf-8?B?K01pdkxVTW9KMWUzRGZBYkxsMXJqWG9scjZUSU5qR1dKRGhmZHIwYlcrekFa?=
 =?utf-8?B?VGhSMldwK25XK2hwV0UyZG1MWGhlS2FaN0lPZ0J1cEc2R2pQMUZSNU5qcW1q?=
 =?utf-8?B?bVBpR0h2dUZMZnBYSzA1VFM4VWFidGdhTjd0WHdpSXZORWtGRE1VeGtlMjdN?=
 =?utf-8?B?NG5Zbm8yYnRDWEcrMlZJL3p5UEduWUc4ZUZCMmdjNUhJSGpDdkJVWHV6Tk5S?=
 =?utf-8?B?NWcyL2R1MXcvYW5GemkyYytJNFpjeTZwR1dscmg1TmgwRDRmdG5QQTY5SXlO?=
 =?utf-8?B?VGZ2SG45Q05DVTkzQ01maFVldXlybHhJZDlIWEZOS0Q3TGNlc0xGYkplcHdJ?=
 =?utf-8?B?anJ1K0RLc245MHBocnNRbDZoQmo1T21YVldiWnloUXZUci81bDV5RCtGVTZu?=
 =?utf-8?B?UmlzelN6ZDgrL1hUZEFGNGtpb0pvZmdlTjNwc1pCRERXcjdsdkw1Y0tZM3FN?=
 =?utf-8?B?OElBRjlhYXAxN1VINENWbUNMTmVXUUlQRU9vUUZ1eG1WMDRGRFpWQmFHVDdu?=
 =?utf-8?B?Wm1tR1VUMEJicE9GUDJINWQ1UGVqREszVVlBQ3hNNGVsV0xzV25SNUN0MGVh?=
 =?utf-8?B?a28rcGpyZDZpWTJ1M0UrbTVkendkSDJyN1FrS2V4TnkvUSt2angrWTFzQ2U1?=
 =?utf-8?B?dHFMVFVEU1A3bkpEUUtWeE1OOWU0N3NZZ0k3Snd5bFFCYjJIY3NSY0RDQ2Zm?=
 =?utf-8?B?S3o2M3Vlb0lYVGZXWFMrUXViUzgzMXR3VHJSOFhUMEtrZ3F4Mk9LN1Rpa2sz?=
 =?utf-8?B?aXQ0ZFM4SFA3SVBudXB2WTU4M08yazAzVi9xU1ZrOEJxWlkxV0diYTd2Uktr?=
 =?utf-8?B?K3VBWjlIc2pkMEZpb0tYUlZybHVPd0NkV2p6dmdqNHB0SlRLenVTbUdPNTEy?=
 =?utf-8?B?eGZnTjV5TXBQQnRiUWZBNjFmRVBoaXh5T0hyUUQybGRVNFBXR28xd3JiTTV1?=
 =?utf-8?B?WEFJRVkrMlU4dVozUkwxbDllbmNobGs3N2tncjBhL3F3TnJDQUdoLzNWeUtT?=
 =?utf-8?B?NWNremVnUWJkMFd2dDVkeVRUSW1TVlpuWXNDVG4wV2RHaXlhUXJScWVCSEtO?=
 =?utf-8?B?NGgzbzVYU1F0R1ZXT2RCQXo1LzEraWhDbnZqUGpReitUV21oWDloeGFLZzRt?=
 =?utf-8?B?emloenFMOUlRM0M3WEhYWlFhZXVNSlZGSjBpcGdKNXRSOFF3dTJCNWVpaS9K?=
 =?utf-8?B?TWJQY3k3bnFyOU9Yc3ZQVWRzZUplRTVucmF5N2hlaWM4VWJKNGxINTJOUmli?=
 =?utf-8?B?ZGVSQVl6RGh4Q0xLdThJQUFTZWluYjZ3YUkxcmQ2NnRCU3FydnFqekhOUEJK?=
 =?utf-8?B?Wk80MjZxVmRsZG9abEJSSCs2K2hxbUJMbWdoMkc3VGlNSTlveEkrYnBDdFdW?=
 =?utf-8?B?LzI3RHdOVHUzRGtBTTNsaGR2M2VMZDcrZ01VM2tQYWZXZ3Z2YzZnTEhlbmRD?=
 =?utf-8?B?cnduMG5BRWh6cUY3a0k1Zz09?=
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3cd2cc-75f4-4397-b878-08d8fea8cc54
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 18:20:21.0578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNtyEm6WmyJjaA1L8bywL/UqCOlWDvYSx1L3o/53AruMCJjMYxyA10wfqqTznRyX7ijkxjHJGSX6oUnaPh06XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR14MB3779
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

One other specific:

I=E2=80=99ve been talking about ubuntu 18 and 20. Our first issue was with =
Centos 7. We have a reproducible problem with Thunderbird. It simply won=E2=
=80=99t run on 4.1 in Centos 7. The problem is with sqlite. It can be fixed=
 by setting a special parameter in Thunderbird and also Firefox. But we cha=
nged the mount to 4.0.

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

