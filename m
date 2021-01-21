Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54B02FF8A4
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 00:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhAUXWA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 18:22:00 -0500
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:13114 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbhAUXVe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 18:21:34 -0500
IronPort-SDR: q2hgB+BfxNnzJgCiGEqsH5Yb7f+TtpR3zqmS92pLDlYTZS7LVxsYVwWKPILsETqwebPjKF8ig3
 Oa70U/rz3CG0kGoKd5fFkThSw5fTKZ7UZR2u1hj57OndXF4mvhHuiLvu5q+rPDqUAHOpuVd+HR
 3cmMJGnSr35NTulkqRMyZUkNcPYb6Gh0h3qP9bNHfrnzDnCcUC5Pmn8AzuehDBHhTNA27w9zCu
 vVJIO5QAele05nlEvEM58NLV3CS/gLEbl6DnJZqAp82+lafnkHubRWK5lsAY0isdi5gWPfXWQt
 OnE=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 260460208
X-IPAS-Result: =?us-ascii?q?A2EDCwBGCwpgh2U6L2hiHQEBAQEJARIBBQUBQIFPgVMpK?=
 =?us-ascii?q?II2CoQ2g0kBAYU5iCYIJQOZFoJTAxg8AgkBAQEBAQEBAQEHAi0CBAEBAoRIA?=
 =?us-ascii?q?jWBRCY4EwIDAQEBAwIDAQEBAQYBAQEBAQEFBAICEAEBAQGGATkBC4NVTToBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAoEMPQEBAQECA?=
 =?us-ascii?q?RIRFQgBATcBBAsLGAICJgICMiUGDQYCAQEegwSCVgMOIAGkRgGBKD4CIwFAA?=
 =?us-ascii?q?QELgQiJEnaBMoMFAQEGgkyCVRhBCQ2BOgkJAYEEKoJ2hlCDdEGBQT+BOAwDg?=
 =?us-ascii?q?mM+hCYCL4MAgmCCBD5ETCEwAlESPiMeAyMGE5JmAYk7V5tagwGbXAUHAx+TE?=
 =?us-ascii?q?49clB2cVTmEQwIEAgQFAg4BAQaBbYF7MxoIHRODJFAXAg2BII0BDA4JgQIBA?=
 =?us-ascii?q?oJJindVNwIGCgEBAwl8iFKBNAGBEAEB?=
IronPort-PHdr: =?us-ascii?q?9a23=3APJklNh0Mxxw54lz9smDT+zVfbzU7u7jyIg8e44?=
 =?us-ascii?q?YmjLQLaKm44pD+JxWFv6dqllbCWYid4PVB2KLasKHlDGoH55vJ8HUPa4dFWB?=
 =?us-ascii?q?JNj8IK1xchD8iIBQyeTrbqYiU2Ed4EWApj+He2Yk9PEc36ahvZpXjhpTIXEw?=
 =?us-ascii?q?/0YAxyIOm9E4XOjsOxgua1/ZCbYwhBiDenJ71oKxDjqAzNto8LnYZyI713xx?=
 =?us-ascii?q?fU8XY=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.79,365,1602565200"; 
   d="scan'208";a="260460214"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 17:19:39 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8sxjtUXIQ9MUMSrJhPj3zuu6c3PFLEVOrsoubdx9LEGr6/JwpW0X6GtahxADIskyyLKy1I2QfVATiEqLn9YI9fDIkegFLfiRqfyPN0FJjYNB56TmkQeY8w45kkqKl1ci8YUGutR4sjI01fx1Is1oTukxUfLUYtJ0xArgOJ4PxTiM3shuX1kJwzbGtnV4VcVvh4j1JEt5A1EGiKj0b/JrjjzSZTgea7rltzZnaZG1hW6m4+MJJsx0pLuRnV7GBEWUjnUl79k1Zpw710HSh7L6t2ymNcAlt/UeZyfHS/Z2mSO7J2SDDpcji09FdtcN2j9acX8NvGsD8c4RnXYvLMNvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMc4RLdD5GtsAe47l4H6gZUcvNbq3mIOZdMkScyP80g=;
 b=J/hKEEfVJGvORSaBGbtjc/JrUpQ3mhH8yaRLFe5QyxPd1IHC5JVQotS9jQPbwUbNwJh/kno7bO+wWwJaX8Byksc67dN9D6HVTF5dU6YlXQRq8i8xKUiESItNqO6+DUACQwGYFHYQ15KKaVOV9QQXOy6mK12ogPur3aI0JWb7+HDkkHrRFz6mbzk99AjajN9Nby6P2ZQaqzpTtAVV2kYTtPUaPEhFeoLlNoUp50pEG2QoTLaA9ptlPMBL9mWLgGV3xwXCf6FGTVYqF0qlWMKsNe+g1n1AkmTIWo6RI3JndlOm4vyCfB6yxSFYZ0iDbUUdvHhncZrqz0R4deoXtdnC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMc4RLdD5GtsAe47l4H6gZUcvNbq3mIOZdMkScyP80g=;
 b=j0Zggl0kYxsIxBmosXjiAToLL50BvU/DxlpmGgIDh6rbZaMizMcBgMdTC9OucGvGT71a5QszDbGWvid3IvsdWTMNToM3vY2ZyuY3JNssZzQAzHgs2yUXVM2mbmdjFws7qWHcrv7ur3eFr+NZV41Bz7MieQQpRANkbqaSIhgFo/8=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB3847.namprd06.prod.outlook.com (2603:10b6:a02:8d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 21 Jan
 2021 23:19:35 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::a1fb:e18c:8af5:666e]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::a1fb:e18c:8af5:666e%4]) with mapi id 15.20.3784.012; Thu, 21 Jan 2021
 23:19:35 +0000
Subject: Re: nfsd vurlerability submit
To:     "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "wangzhibei1999@gmail.com" <wangzhibei1999@gmail.com>,
        "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
References: <20210108153237.GB4183@fieldses.org> <20210108154230.GB950@1wt.eu>
 <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org>
 <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <42fcbc42-f1b3-5d99-c507-e1b579f5a37a@math.utexas.edu>
 <20210112180326.GI9248@fieldses.org>
 <eb09db3a-9b43-cf03-5db4-3af33cb160e6@math.utexas.edu>
 <20210121220402.GF20964@fieldses.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <a6429a2c-ce90-caec-0704-6626cd564300@math.utexas.edu>
Date:   Thu, 21 Jan 2021 17:19:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210121220402.GF20964@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: SN6PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:805:de::39) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.7] (67.198.113.142) by SN6PR05CA0026.namprd05.prod.outlook.com (2603:10b6:805:de::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.7 via Frontend Transport; Thu, 21 Jan 2021 23:19:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75eb5393-d23d-42f4-7b9f-08d8be6303e4
X-MS-TrafficTypeDiagnostic: BYAPR06MB3847:
X-Microsoft-Antispam-PRVS: <BYAPR06MB384711F262884F3249E7170183A19@BYAPR06MB3847.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0d6ZGXyGuY7CxptogpXYpXB2D8IzJFR0oM4BPmJj9Wxb0mvr0CBi0oWZDtWvzcMHDjXUgXOW+ftHgtSw3kEa9Sfj8leMQsCprQRi8pENFHVaaHAlA1AJ7kkTQHDj5h1PTF905xNqt7G5wBKKFfug4xtc5bTigFc4daedG8Kp51nlOv0l5KM2HTC245+zDIaoQVrMbtW15OjMcFcNsAro0LqmxuL1swkGNY61+gXphc5G+1ReqN5yr4fNNddMc3tyk9PGgobKFYPBExnrDGMoWYhEK5Tm0CeHNhfcDN4ARVfVTjOotqRDw0DxIMNGWrVArUcY2vEzTwKVS4mhz4Q4PCfNAWum/AWmSJlpuS/2+6HE1dheuutlTqoaD3QTtegLz0biAPNdgC9Fc/+8ifsDB7DlWv7etRTwmKw8vLjFl3tabYn7cc0qrzZaO40UwxozjLsHUxPDVuA2aQsGl1aOQnon8bCKky5Ol1M1mik7JhwGzTUqHMImTTy200QCiwmQjm7LxcZoN5jD+ApUqrQE5vI/b+Z1KdG35fEuCdNsqiktra7TmeUBAqeX29S+UOpRxu53gHgyc2gvn8Ai9JsyX1NHzdxPde+OKAfin0x25eE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(3480700007)(2906002)(54906003)(6486002)(53546011)(8936002)(478600001)(8676002)(5660300002)(4326008)(31686004)(16576012)(83380400001)(52116002)(86362001)(31696002)(66556008)(2616005)(316002)(786003)(26005)(16526019)(7116003)(66946007)(956004)(6916009)(75432002)(66476007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bDhrb3djd0dnY1o3Ykd1bzFLR09sNWhGUi8yWmsreWpRa0lYYWpqaVVMSnhV?=
 =?utf-8?B?U0VPUHBkU1FpRU5SOGtPWnA4VzdYRzUxYXQrNXNkSGpkMnZ3dXlaVGJoS2NF?=
 =?utf-8?B?TVRSaUpsVkdpWGpLYy9pMU0yNGhBWnRWQVVJWEJHYkZWYmw1T0R2REZ2alh3?=
 =?utf-8?B?R0pXa1Z1Q2xmdVhUVEhFMUtUdy9Cd3kxQ2ljSm0xVVAzcnY3QzA5eVJTM0hw?=
 =?utf-8?B?R2FsQVF0TjUxTTFzeEVmQU9mYk9KWmJxOURyRzkxZ2t0VXgrRjVUUG5IQWc1?=
 =?utf-8?B?WTJvdTlvRE1TeWY1eUE4VW90eEpBUUk3SDNBOHpubkUvbEFZcnRXWWlBdGdo?=
 =?utf-8?B?cWs0WGU2VXc2UFd4cUdtbGpSbGorbGxobWM1MFNQSTY0REZHNzZHUTV5bytx?=
 =?utf-8?B?akl5d1dkV2VnWkNpZWJHczVaWldvS1htUkNmQ1hob1RxMWhJL1ZhcXF5OFdY?=
 =?utf-8?B?SGVWSzQzbHFsbXViRWdORzliNm9OdGFHUEh6ZTZTcjlzSUVqM29FbXppOWIr?=
 =?utf-8?B?cnJoblZkOEQvUldSeUpjcFRyM0srMzNpQlZuVU9OdWpQTlZMdm5DdTN1Nzlt?=
 =?utf-8?B?dkFZNjg5MmwvMGVhTXVIK0hOaVR1akUvbXRTZktsdkZNc1RLeDAvMk4wQWlV?=
 =?utf-8?B?Q0o1Mzk2OW1CUVlkQmJpYzdZVU85K0xmbk5LUnZvN1p1aktjZTVXL3NqYXIx?=
 =?utf-8?B?czMrYkxYUEV5WFJQK0tJTEkzMWxZc0NVcUpuYkNESitOcjB2Y1A3WGducGFR?=
 =?utf-8?B?bm9Wa1RxNVMybmp6QXkzQ1F2VXJQRm1kRzRNM3VyRlFTZlBIT3NKWlVueWk0?=
 =?utf-8?B?a0FGWEdBRXVKaHBjNk9KeERnNjVWVzRtZkltOCsvdzg3K3VqdFRoNjI2UlQy?=
 =?utf-8?B?dUpTb1c4d0ZrRHR1WkhJSFJrVnFVRU1WZWsyVWYwZFJ4MmRFaFEzVmprMjZT?=
 =?utf-8?B?NVErL2doNm0zZG9EUG1GRlUvRGlsOVNTYTVnZE96VWFZNnJCQTFocjNoN2Js?=
 =?utf-8?B?RlhqZ0NtYVZ0Myt4dHNYajFuZnRCeGQrZzEzTFJKV1pmSXdva05ObjROb0lC?=
 =?utf-8?B?bVJTSXZsV3BIWmljNmtzclJ5dHdmdjdWeFJ1c0p5MWJmdU1uN2dBRm5taHhr?=
 =?utf-8?B?RFpmcUh1cStyTURFNHMyNC80OFBkSGtibmV1NnhzODJZN29oS05pMTJGeWhC?=
 =?utf-8?B?SVhlVENRZE5pWkZseGhFekhOaHcva2VPU2RBUmI3N3YrTm9xWWFJQXphSkNE?=
 =?utf-8?B?eU9ranlLbWptUmhxdDF6YVpFWDBObTBON0owaE9YNUwxZm8xWTJlQjMxY3kx?=
 =?utf-8?Q?ssnmkwiAFc1fWoy+Qj+mJWBeDGrMOoLdi6?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 75eb5393-d23d-42f4-7b9f-08d8be6303e4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 23:19:35.5486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqcIQquH3/bqbfvhOgDHuJh/VnqnbFxnkDz73/m7hPhDkNLEZtA1/QhO5y+28ncYVwyd+/pWR63gqPZt2Vp+xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB3847
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/21/21 4:04 PM, bfields@fieldses.org wrote:
> On Thu, Jan 21, 2021 at 02:01:13PM -0600, Patrick Goetz wrote:
>> I didn't respond to this message immediately, but it's been
>> bothering me ever since. When I do a bind mount like this in
>> /etc/fstab:
>>
>>    /data2/xray      /srv/nfs/xray        none    defaults,bind    0
>>
>> it's my understanding that the kernel keeps track of the resulting
>> /srv/nfs/xray filesystem in it's vfs somehow.  Even when directly on
>> the server I can't "break out" of /srv/nfs/xray to get to the other
>> directories in /data.  Then how on earth would an NFS client do
>> this?
> 
> As I said, NFS allows you to look up objects by filehandle (so,
> basically by inode number), not just by path

Except surely this doesn't buy you much if you don't have root access to 
the system?  Is this all only an issue when the filesystems are exported 
with no_root_squash?

I feel like I must be missing something, but it seems to me that if I'm 
not root, I'm not going to be able to access inodes I don't have 
permissions to access even when directly connected to the exporting server.

> 
> Also, note, mounting something over a directory doesn't hide what's
> under the mountpoint.  And it's unwise to depend on directory
> permissions alone to hide contents of anything underneath that
> directory.

Well, I only ever bind mount over empty directories; but again, "doesn't 
hide what's under the mount point" from whom?  I'm sure root can get to 
this somehow, but can someone with ordinary user access? even if the 
user doesn't have permissions to access the stuff that's been mounted over?


> 
>> I thought the whole point of doing a bind mount like this is to
>> solve the problem of exporting leaves of a directory hierarchy. In
>> particular,
>>
>>    "So in your example, if /data2/xray is on the same filesystem as
>>    /data2, then the server will happily allow operations on
>>    filehandles anywhere in /data2."
>>
>> Yes, sure; but I'm not exporting /data2/xray; I'm exporting
>> /srv/nfs/xray, a bind mount to the preceding.  Am I missing
>> something, or is NFS too insecure to use in any context requiring
>> differentiated security settings on different folders in the same
>> directory structure?
> 
> Definitely do *not* depend on NFS to enforce different export options on
> different subdirectories of the same filesystem.
> 
>> It's not practical to making everything you export its own partition;
>> although I suppose one could do this with ZFS datasets.
> 
> I'd be happy to hear about any use cases where that's not practical.
> 

Sure. The xray example is taken from one of my research groups which 
collects thousands of very large electron microscopy images, along with 
some xray data. I will certainly design this differently in the next 
iteration (most likely using ZFS), but our current server has a 519T 
attached storage device which presents itself as a single device: 
/dev/sdg.  Different groups need access to different classes of data, 
which I export separately and with are presented on the workstations as 
/xray, /EM, etc..

Yes, I could partition the storage device, but then I run into the usual 
issues where one partition runs out of space while others are barely 
utilized. This is one good reason to switch to ZFS datasets.  The other 
is that -- with 450T+ of ever changing data, currently rsync backups are 
almost impossible.  I'm hoping zfs send/receive is going to save me here.


> As Christophe pointed out, xfs/ext4 project ids are another option.
> 
> --b.
> 

I must have missed this one, but it just leaves me more confused. 
Project ID's are filesystem metadata, yet this affords better boundary 
enforcement than a bind mount?  Also, the only use case for Project ID's 
I was able to find are project quotas, so am not even sure how this 
would be implemented, and used by NFS.

