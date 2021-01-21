Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC322FF582
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 21:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbhAUUK3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 15:10:29 -0500
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:6254 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbhAUUKX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 15:10:23 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 15:10:21 EST
IronPort-SDR: UscwdDIBOi7a6FutncrV2FpkCnEdhv4U2gxgONrKCyuY1Sp7u9TemAK+h/dYlRExnPE9lmzkju
 EwezZe9RCkXS9r+8Ihz7mk318bC3KyRkmFobULGDB3X8BQWu9xTG6xEN9Xt5gxH9ab2OB5/jAb
 zi5uSTHGNL4NsxpKz+8F5rtpioDnRYVUE4YkrvKAlkQfrwtxkifLQuhJdrFST0SsevsvSCwgzv
 db9Z+rqSNM33URLi7l5oR9GiDjtTLVEsv6nurzg06I8f2YAoeruqpISDmbHr3B8lEYAZLkrD+f
 qY8=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 260417166
X-IPAS-Result: =?us-ascii?q?A2EnAwBI3Algh685L2hiGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4FTKSh9U2YKhDaDSQEBhTmIJC0DmRaCUwMYPAIJAQEBAQEBAQEBB?=
 =?us-ascii?q?wIjCgIEAQEChEgCNYFEJjgTAgMBAQEDAgMBAQEBBgEBAQEBAQUEAgIQAQEBA?=
 =?us-ascii?q?YYBOQELg1VNOgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QUCFFQkPgEBAQMSEQ8BBQgBATcBDwkCGAICJgICMiUGDQYCAQEXB4MEAYJVA?=
 =?us-ascii?q?y4BDpYSjh4BgSg+AiMBQAEBC4EIigiBMoMFAQEGgUdBRIJNGEEJDYE6AwYJA?=
 =?us-ascii?q?YEEKoJ2hFOBfQeDbUGBQT+BEScPgWV+PoJdA4FGgzGCYIFZLTwGAhVLLQEbD?=
 =?us-ascii?q?gIEHAI+GwoMMhUEHwkDHgUZAi2PR4JwAYoSihuRP4MBkC2LLwUHAx+TE4lsh?=
 =?us-ascii?q?XCUHYgkgQeTYw2ENgIEAgQFAg4BAQaBbYF7MxoIHRODJFAXAg2OIRqBCwECg?=
 =?us-ascii?q?klqig1VAgEBMwIGAQkBAQMJfIoGAYEQAQE?=
IronPort-PHdr: =?us-ascii?q?9a23=3AOiZtSxDqSNCRhzhdXtS9UyQJPHJ1sqjoPgMT9p?=
 =?us-ascii?q?ssgq5PdaLm5Zn5IUjD/qw31g3OR4zQ7/8CgO3T4OjsWm0FtJCGtn1KMJlBTA?=
 =?us-ascii?q?QMhshemQs8SNWEBkv2IL+PDWQ6Ec1OWUUj8yS9Nk5YS8HkblbWrzu56jtBUh?=
 =?us-ascii?q?n6PBB+c+LyHIOahs+r1ue0rpvUZQgAhDe0bb5oahusqgCEs8AKgc1/Nqshww?=
 =?us-ascii?q?CPr3dVKOk=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.79,365,1602565200"; 
   d="scan'208";a="260417171"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 14:01:18 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NedPNniA4Cx5XPmzcQxZAIANZewr2TOgIYWa6cnRog7F4OtW+CBVnqa5Pa/zrp0BitIWvWUx824rz0lDzYOog+j0tjKDErtZv+SmB0v2ZVDQpE6+qysF8k070COIyKBkbY60S1DVPK3FRoKndVl1CNPHKVqGfLbaEQ9GV41B4RuIJ4LEw1ui4BJ+uSeww5eJtdnh20TB5VznUO4IJSmv8rhogqf1Jbv9wEc2gtF5k8YIbi5AscSHkuxpeowjCpiZx057DDzC4cGkxuypNRmZpC/Jzss5E8I2VI/BAI8K6SWdN4SC/o1ndfdwVC5oDdZZKt509fcfRB77rdWbl6Wm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSjghXXj5RCv93+d+YYASkJWE8udPIBp3NShPYm/k5w=;
 b=dIASvU8LVDsZBwwbBiQgHTJ2tL2WymOiyobyNZyP5KhBooTAjk8dA6ktPnbypDYT6gM4b92lMrARgm3ixkG1pJFVhxXRy11tI6R1l4GZmmI2VbekJcfzulYe34LbaX9QLG42HP8mKJ3h6mlB7U3lav6VmV+j4o5pAjgAey17/7Hu+f4CjNm7EybeJYXcuZvHlTjmWItUWzKiLYikmMshs1r39Wl2F/8Sl8YzWkt1Vz2GynEmSSCTDrYNR/rRtlhm+dO/9T1x6Qy0FBmSx574LPsjBelTX5V0s+Ghp4zQnGzOVOAhhWjIkxvzAyuPP2BhUFFpmbqb1h8P8wD4knUy3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSjghXXj5RCv93+d+YYASkJWE8udPIBp3NShPYm/k5w=;
 b=lFP0EwzxYxRCdnNRm9S3l812/v4f2fBm1DD4wMssEvk+kU1o81bcv6cePqSPr7ERz7pMUIGzo8uV7ECRzQXExQgILwtCykAqB0Cj8C1No/9fUQQYacOTFulFh78dTaDXhtdoQHwnvp1mPmUeNCXEsYyuZKbkE+A7RJgfoJLKLw4=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BY5PR06MB6484.namprd06.prod.outlook.com (2603:10b6:a03:23c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 21 Jan
 2021 20:01:16 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::a1fb:e18c:8af5:666e]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::a1fb:e18c:8af5:666e%4]) with mapi id 15.20.3784.012; Thu, 21 Jan 2021
 20:01:16 +0000
Subject: Re: nfsd vurlerability submit
To:     "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "wangzhibei1999@gmail.com" <wangzhibei1999@gmail.com>,
        "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
References: <20210108152017.GA4183@fieldses.org> <20210108152607.GA950@1wt.eu>
 <20210108153237.GB4183@fieldses.org> <20210108154230.GB950@1wt.eu>
 <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org>
 <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <42fcbc42-f1b3-5d99-c507-e1b579f5a37a@math.utexas.edu>
 <20210112180326.GI9248@fieldses.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <eb09db3a-9b43-cf03-5db4-3af33cb160e6@math.utexas.edu>
Date:   Thu, 21 Jan 2021 14:01:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210112180326.GI9248@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: SN4PR0201CA0007.namprd02.prod.outlook.com
 (2603:10b6:803:2b::17) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.7] (67.198.113.142) by SN4PR0201CA0007.namprd02.prod.outlook.com (2603:10b6:803:2b::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 20:01:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf2ad9cc-937a-4bd7-3dc2-08d8be474f86
X-MS-TrafficTypeDiagnostic: BY5PR06MB6484:
X-Microsoft-Antispam-PRVS: <BY5PR06MB648415670FB1EA86CCC8B16883A10@BY5PR06MB6484.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLm8wJF60Ce4XUe+uTGGXtssbMILa/J2ft0qBE6WHNlTpbZ2n+EXhdnwkKnK/f52YkDIseIrKQmF2N10a7pi3xhxM/7GIsU4CGnQIJ6fy0KmGFUW08Fg6INp/ejLVViaHG+6DDN3w9axcTkjkjuyrQG+Z1Qrhx4cKQ4vcGBlQVwRCWUb3eRnCAx7oMY31Y7Ug6VMCrTiC6sZSkIabYq36QEZnxFA0GDBaAxGgAnhiAGCT5acSjZYgnzIfbW1kuuyZhxPbmsvRf7/ydKt9f3BpeE2lpz7N77tK6vAWwXfWneWfU9Nmq+e6lXbaIzK5zAmMlPa7G3XhNlnDzoHiy7VcgIams5As4sBR14IY5LNFlqfqPosYFygqyJLDkouhTDv42Hyfc6COTsm2lwt/McRZAnX+JoCX6wy0AvUbunxKFs1LjmRayu4FV/q2ONQWp3ak8KmgjXAmvzfZ9ko90hKrpjmhRv9mngkmi2kylkVVUTL7pTGO6CwRwdfZIrPKUDKsJ5QXHwP3GUtUk4bJ1VHMygF9bzBMGE+JbYL6kv7ID86BDFVrMoVR2ddw6KsPoYm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(31686004)(8676002)(2906002)(316002)(2616005)(26005)(6916009)(54906003)(6486002)(4326008)(956004)(966005)(786003)(7116003)(16526019)(53546011)(31696002)(86362001)(52116002)(83380400001)(8936002)(186003)(75432002)(66556008)(478600001)(66946007)(3480700007)(5660300002)(16576012)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Sk1NWHNzUnJqN1ZNb3oyZHBlQ1k1b3lHZUgzMmFEZWlLZTNIQndKcngxWG4z?=
 =?utf-8?B?TUxKTGJxNEFXY0xwNUpDclRpK2xwQzg0OGhqMEp3VGZQWWI5MERTVUkzODgr?=
 =?utf-8?B?THNVMzlqamxOZ1NHVXlwcTlDOUZweUNLUHRpZFFGZFYxMHRuZVhURUhPdVdC?=
 =?utf-8?B?Tkg0NDdZSldSNGRwMkw4WERLczIrZVF2TEFhQWpzTENUQkxXMDdRcDJOdzQx?=
 =?utf-8?B?RUpNdUtPN2JBeTVzNjBPb2Y1QmtrSUx5Qm4wWlUvbys0MXpBNkM5MStzKzdu?=
 =?utf-8?B?eW90MEdwdVJIVDJMVVg4ZUxERWRJN1RIbkZhSGhONGxmUEhONzJKdkFObWxz?=
 =?utf-8?B?TEo2amR5MGZlRUNJRUd3Y2srZmRNSHB2alBWU3ZZMUZCcS95YlhyMHU2endD?=
 =?utf-8?B?bTBNeTRUMlBVd1I0N1BuVGZQTE1naVFtdFBPSGQ3L1dZdFBrdGFBaVdrL0pu?=
 =?utf-8?B?b1ZLWHd5Nmd6UVB0VU03U0IvUHpGTi9Nd0hKeTZwdjdGZEpDbVpnaE90a1po?=
 =?utf-8?B?VkFCamRYcHliZUZVeHNDSmNWMUJEKzUvY3ZraXFuRUN3aGUwRG5KZlRiOXdK?=
 =?utf-8?B?VzlrTGx4UU9iMnpRQjBTdWhyWjhkbUJSWTYzSW5jaHgzeXppY2g3TFFtWUtj?=
 =?utf-8?B?T1BldFlQb0NOcHU2ZXJzeUxxTjJZR1U3cFlnelJjNzIzaVN5SXB1dVFJUHR3?=
 =?utf-8?B?VTlIL1JMRDYvUXU0TnBoaDRWRHF2dE96TnpYVnQzVHF1dGgyU3VOeGtpWTVs?=
 =?utf-8?B?T1FNS3JaVFhWK2l4REVUbjN6NEEwV0tYYkl4aXdZcXFrelZxKy9mdFErME5P?=
 =?utf-8?B?blBscDRibUh5cy94bzRrSzBFTXlzb05IR01LcmkyVytIZUZEVi8yMlMwMHht?=
 =?utf-8?B?RjRrNU1EYmpTM3B0RTVmNVdlZnJkVEN6VjlZVmpZZlJWWGQwM1ozOG9PSVdh?=
 =?utf-8?B?TDJ6dmxZN0kzRE5pQU1zKzJ1QnhzcGpSZkg3bWhRbzhHWFM0bG1Zd2ljUTlt?=
 =?utf-8?B?YzJUNnBNTFNFM1hqNExZdWd6NXQ4Y0dNazhDNExMOVNsR0pKQnQ0dUgxcWIx?=
 =?utf-8?B?WHJLbTNyZ1pqTDlva2hQVkFWSnAxVkt4OUZUcnhjVVpwWXc2ZThVZTRzVWZF?=
 =?utf-8?B?YmIrakRFMmdTMDBuaG42U1NvTUVzUzh3ejNmZWNtb2lPQXNRRkM0cEVZSWN4?=
 =?utf-8?B?NVVvV0IrTzdicWh4UFRzUnJYVHFBbk5Vb1BmbjBHdC9TZ3NVSGZvSllyb25l?=
 =?utf-8?B?NzBPQWhlMW1XWFlLL29JQU9LUjU4Q0V5cmc3VXJndXcvSW1xa0p4VzNrN2hw?=
 =?utf-8?Q?KwL3M4SVvUM+H1Nqkyl0P/qutfclRdhWFL?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2ad9cc-937a-4bd7-3dc2-08d8be474f86
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 20:01:16.0627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzRagf5zF56fA6k00L+1ISj3JIv8D+jGVv5qClDxN913MH2slWAALBjUiQ1zf2D57nqsrW5P6IcY5HY8NjP69w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR06MB6484
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

See below.

On 1/12/21 12:03 PM, bfields@fieldses.org wrote:
> On Tue, Jan 12, 2021 at 11:20:28AM -0600, Patrick Goetz wrote:
>> I was under the impression that the best practice is to create
>> something along the lines of
>>
>>    /srv/nfs
>>
>> and then bind mount everything you plan to export into that folder; e.g.
>>
>> /etc/fstab:
>> /data2/xray      /srv/nfs/xray        none    defaults,bind    0
> 
> You can do that if you'd like.  I doesn't make much difference here.
> 
> You can think of a filehandle as just a (device number, inode number)
> pair.  (It's actually more complicated, but ignore that for now.)
> 
> So if the server's given a filehandle, it can easily determine the
> filehandle is for an object on /dev/sda2.  It *cannot* easily determine
> whether that object is somewhere underneath /some/directory.
> 
> So in your example, if /data2/xray is on the same filesystem as /data2,
> then the server will happily allow operations on filehandles anywhere in
> /data2.
> 
> Every export point should be the root of a filesystem.
> 
> --b.
> 

I didn't respond to this message immediately, but it's been bothering me 
ever since. When I do a bind mount like this in /etc/fstab:

   /data2/xray      /srv/nfs/xray        none    defaults,bind    0

it's my understanding that the kernel keeps track of the resulting 
/srv/nfs/xray filesystem in it's vfs somehow.  Even when directly on the 
server I can't "break out" of /srv/nfs/xray to get to the other 
directories in /data.  Then how on earth would an NFS client do this?

I thought the whole point of doing a bind mount like this is to solve 
the problem of exporting leaves of a directory hierarchy. In particular,

   "So in your example, if /data2/xray is on the same filesystem as
   /data2, then the server will happily allow operations on
   filehandles anywhere in /data2."

Yes, sure; but I'm not exporting /data2/xray; I'm exporting 
/srv/nfs/xray, a bind mount to the preceding.  Am I missing something, 
or is NFS too insecure to use in any context requiring differentiated 
security settings on different folders in the same directory structure? 
  It's not practical to making everything you export its own partition; 
although I suppose one could do this with ZFS datasets.


>>
>> Presumably this becomes a non-issue under these circumstances? Not
>> sure it's a good idea to attempt to accommodate every wacky use case
>> someone attempts to implement.
>>
>>
>> On 1/12/21 10:53 AM, Trond Myklebust wrote:
>>> On Tue, 2021-01-12 at 10:32 -0500, J. Bruce Fields wrote:
>>>> On Tue, Jan 12, 2021 at 10:48:00PM +0800, 吴异 wrote:
>>>>> Telling users how to configure the exported file system in the most
>>>>> secure
>>>>> way does
>>>>> mitigate the problem to some extent, but this does not seem to
>>>>> address the
>>>>> security risks posed by no_ subtree_ check in the code. In my
>>>>> opinion,when
>>>>> the generated filehandle does not contain the inode information of
>>>>> the
>>>>> parent directory,the nfsd_acceptable function can also recursively
>>>>> determine whether the request file exceeds the export path
>>>>> dentry.Enabling
>>>>> subtree_check to add parent directory information only brings some
>>>>> troubles.
>>>>
>>>> Filesystems don't necessarily provide us with an efficient way to
>>>> find
>>>> parent directories from any given file.  (And note a single file may
>>>> have multiple parent directories.)
>>>>
>>>> (I do wonder if we could do better in the directory case, though.  We
>>>> already reconnect directories all the way back up to the root.)
>>>>
>>>>> I have a bold idea, why not directly remove the file handle
>>>>> modification in
>>>>> subtree_check, and then normalize the judgment of whether dentry
>>>>> exceeds
>>>>> the export point directory in nfsd_acceptable (line 38 to 54 in
>>>>> /fs/nfsd/nfsfh.c) .
>>>>>
>>>>> As far as I understand it, the reason why subtree_check is not
>>>>> turned on by
>>>>> default is that it will cause problems when reading and writing
>>>>> files,
>>>>> rather than it wastes more time when nfsd_acceptable.
>>>>>
>>>>> In short,I think it's open to question whether the security of the
>>>>> system
>>>>> depends on the user's complete correct configuration(the system
>>>>> does not
>>>>> prohibit the export of a subdirectory).
>>>>
>>>>> Enabling subtree_check to add parent directoryinformation only
>>>>> brings
>>>>> some troubles.
>>>>>
>>>>> In short,I think it's open to question whether the security of the
>>>>> system depends on the user's complete correct configuration(the
>>>>> system
>>>>> does not prohibit the export of a subdirectory).
>>>>
>>>> I'd love to replace the export interface by one that prohibited
>>>> subdirectory exports (or at least made it more obvious where they're
>>>> being used.)
>>>>
>>>> But given the interface we already have, that would be a disruptive
>>>> and
>>>> time-consuming change.
>>>>
>>>> Another approach is to add more entropy to filehandles so they're
>>>> harder
>>>> to guess; see e.g.:
>>>>
>>>>          https://www.fsl.cs.stonybrook.edu/docs/nfscrack-tr/index.html
>>>>
>>>> In the end none of these change the fact that a filehandle has an
>>>> infinite lifetime, so once it's leaked, there's nothing you can do.
>>>> The
>>>> authors suggest NFSv4 volatile filehandles as a solution to that
>>>> problem, but I don't think they've thought through the obstacles to
>>>> making volatile filehandles work.
>>>>
>>>> --b.
>>>
>>> The point is that there is no good solution to the 'I want to export a
>>> subtree of a filesystem' problem, and so it is plainly wrong to try to
>>> make a default of those solutions, which break the one sane case of
>>> exporting the whole filesystem.
>>>
>>> Just a reminder that we kicked out subtree_check not only because a
>>> trivial rename of a file breaks the client's ability to perform I/O by
>>> invalidating the filehandle. In addition, that option causes filehandle
>>> aliasing (i.e. multiple filehandles pointing to the same file) which is
>>> a major PITA for clients to try to manage for more or less the same
>>> reason that it is a major PITA to try to manage these files using
>>> paths.
>>>
>>> The discussion on volatile filehandles in RFC5661 does try to address
>>> some of the above issues, but ends up concluding that you need to
>>> introduce POSIX-incompatible restrictions, such as trying to ban
>>> renames and deletions of open files in order to make it work.
>>>
>>> None of these compromises are necessary if you export a whole
>>> filesystem (or a hierarchy of whole filesystems). That's the sane case.
>>> That's the one that people should default to using.
>>>
