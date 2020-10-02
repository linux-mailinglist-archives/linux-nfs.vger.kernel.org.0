Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF8F28163B
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 17:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbgJBPMa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Oct 2020 11:12:30 -0400
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:2202 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBPM3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Oct 2020 11:12:29 -0400
IronPort-SDR: 0oiGVXT95PPxXSZ/cINyLT9v5BFy8wIADyL29E6pQM2r9WGsI7mPLnzg1pPpm42TvpyPyr/2zD
 OZ8Ik+6TdcuL72fnYBZCSIjoRh1kAVOia2VYcvbMidUkq+I0ufgGKoqXRLo/pi1WkAIdobB0wM
 2H1pBVGRprxk/9J061hUQueJxyODKuZpqkJneTE2gQWZI/1xl46O9NVatUq/W92h+AWwYr5NiK
 TE1GEujF6Aw0ohUAA/sUhYe6h5pq3wQbAdoo88NAsLSErA4pqgzeSXuwVuBPavKUZi48Wq5Ym7
 mmY=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 245890993
X-IPAS-Result: =?us-ascii?q?A2EuAACkQndfh2U6L2hgGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFPgVJRd4E0CoQzg0cBAYU5iAgugQKXdYJTAxg9AgkBAQEBA?=
 =?us-ascii?q?QEBAQEHAh4PAgQBAQKBU4J1AjWCAyY4EwIDAQEBAwIDAQEBAQYBAQEBAQEFB?=
 =?us-ascii?q?AICEAEBAYV5OQyDVEk6AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBBQINVCs+AQEBAxIRDwEFCAEBNwEPCQIYAgIUAQIPAgIyJQYNCAEBH?=
 =?us-ascii?q?oMEAYJLAy4BDoxCjh0BgSg+AiMBPwEBC4EFKYlXgTKDAQEBBYFHQUSCQxhBC?=
 =?us-ascii?q?Q2BOQMGCQGBBCqCcopXgUE/gREnD4IlNT6CXAEDgUVnEAKCNoJgkAoICgcuj?=
 =?us-ascii?q?AGBE5hjgQqCcYh+hliFFYVqBQcDH4MOOI5cKYJFhkGFTJ4BlSYCBAIEBQIOA?=
 =?us-ascii?q?QEFgWuBezMaCB0TgyRQFwINgRmNBgwOCYNOinRWNwIGAQkBAQMJfECKRgICI?=
 =?us-ascii?q?oEPATFfAQE?=
IronPort-PHdr: =?us-ascii?q?9a23=3AX+7CaBRkQUupXaKDDi6gYxXdW9psv++ubAcI9p?=
 =?us-ascii?q?oqja5Pea2//pPkeVbS/uhpkESQBtmJ9f1JkazVvrrmVGhG5oyO4zgOc51JAh?=
 =?us-ascii?q?kCj8he3wktG9WMBkCzKvn2Jzc7E8JPWB4AnTm7PEFZFdy4awjUpXu/viAdFw?=
 =?us-ascii?q?+5NgdvIOnxXInIgJf/2+W74ZaGZQJOiXK0aq9zKxPjqwLXu6x0yYtvI6o80F?=
 =?us-ascii?q?3HuHxNLuFf2WMuOE6ejx/noMq84c1u?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.77,328,1596517200"; 
   d="scan'208";a="245890993"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 10:12:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z51HTE1ZPJQSP3KqLpRvLkD/D2DYqMGM2q6inHxeIJkkXIWwx/YLcyfrUnotBDmaib8dgh7byFZS91/eXkgkq5uZSf6Mcw/Sk0/Ctm32B95IzKOlt7mvfabE/TUfJaTlICf82edpVFrHFcJY19ajuIpHfDWKD17nEPE4QLDsfhqzEqvNNcodJp/Ki79MKZQb3VER4H+N7d6eRfIXWYKzxUoR2a8kH5IFkWHSdUffw2hUUDc1L3ZKJGfJ/VGrldW9iKCvtucwUVlbHDIu82jg78XaYypj1Hip0YZ7JHHcMlTON2IqTlLGleDSxatbhnAZcTO8naW1akYgsHnDyzSJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WIHRTB9mu27/uXWq93QikB0tkXHpN0JXHZVw9j1nuI=;
 b=TeMr2xH+De5mBO6tdk8fwavQplE2ChC5agHjLsVDJrG6T9PrMlIPMVEjtkGOkhoZSlC9RTB06OKrKiWb8XRjWeu5i+S+5BEd1VLV+Sj7TcMiFoviGnQsuv170onFaTxxtI5DAM2DWB7Cp213TPgaTWDd4g70BriFFCcuXU0JR6NQaGO3QoZTs6cHaPMWtWoFDmvesiZ7NLtY/wWcH1Jc2ymLGzmbJf0AtTXmqLh055HcFVmSYzcPkTxe9G94/DYhAzYpEjhmIeSkDUcq2VkmUTY+5DACru6rn1hp/yDlvPp+/y7daSH4gQCG7qa1X8lugqIe/q2+IDDomkZPao0xoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WIHRTB9mu27/uXWq93QikB0tkXHpN0JXHZVw9j1nuI=;
 b=ROd8DveCsLGvwDzyTqFs1n8FZ+GNNtdXmzCO7/Y/s/DN8HqGeId1GVR+1o1trDDRRFfNb16TiQrxNiKi0Br01qIxKKdZ7m0NZUODmR9A/3+VVPueO5lF+BqHvYafprIphXL++hsLt5LkM6J3S3u8zN/v2Z50bPeKVfwAPsfynoI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB4517.namprd06.prod.outlook.com (2603:10b6:a03:49::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Fri, 2 Oct
 2020 15:12:26 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::145b:33d4:e2d3:ad59]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::145b:33d4:e2d3:ad59%5]) with mapi id 15.20.3433.036; Fri, 2 Oct 2020
 15:12:26 +0000
Subject: Re: rpcbind redux
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <6b0c5514-ebb1-fde7-abba-7f4130b3d59f@math.utexas.edu>
 <20201001183036.GD1496@fieldses.org>
 <f621c004-3402-09d0-b2d0-83d610525a7c@math.utexas.edu>
 <20201001200603.GH1496@fieldses.org>
 <2df155d8-2f0b-c113-5244-a09bbea370b3@math.utexas.edu>
 <20201001214344.GJ1496@fieldses.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <5eae41f5-aa78-5cf4-5e39-8b39f1235a65@math.utexas.edu>
Date:   Fri, 2 Oct 2020 10:12:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201001214344.GJ1496@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: DM5PR12CA0051.namprd12.prod.outlook.com
 (2603:10b6:3:103::13) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.7] (67.198.113.142) by DM5PR12CA0051.namprd12.prod.outlook.com (2603:10b6:3:103::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend Transport; Fri, 2 Oct 2020 15:12:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2334c574-fe7a-4975-7b21-08d866e59277
X-MS-TrafficTypeDiagnostic: BYAPR06MB4517:
X-Microsoft-Antispam-PRVS: <BYAPR06MB4517D95AF95B512F12BC634A83310@BYAPR06MB4517.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2fUyBuwsD2IBxM70LrTtx638bbFxpP02oiR2xQQN97wSEI3HdQ36YRO3naSZVriYs1t08trWGYRfNRqbEwLyTDATtZkxBBrrWFGFt10QrwI5QHx6jtwjwDd+45HoHgNzhBSQSjejSv8l69Wb860OEENNslq+2rvkYw28k1ojwyOyHXLyAquraJOKAZIJMcYnX5vzlzTNEQX9EDd8T7z382Q5RrvUIE7ualopw6C9zdArwZ5ve5aUeYyoqM1idAqyku3zfzUcjygKY22/Y+X5ejLU4sZckJv23XVpLiVj2ELsguBPKjGFWrOh0v9sZyEHylp45uSB09Ige7g5e64J+ZAEu/+nHPSkpxg9VXJHrUp6laDfRHcLNHvXFsgVkfU0llLy96N0WdAq+f4Zc1k1AIuH4gjUkfevX/Kky6Emm5C2yu1Vh9VSGhv+nuVoH5CCi5BM1OE4KgJyiEOh9PvlaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(26005)(478600001)(6486002)(186003)(31696002)(66476007)(8936002)(2616005)(66556008)(966005)(16526019)(66946007)(6916009)(8676002)(4326008)(956004)(7116003)(5660300002)(53546011)(86362001)(2906002)(52116002)(75432002)(83080400001)(16576012)(316002)(3480700007)(31686004)(66574015)(786003)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0BHvXXTDugPG6K2FZukuqmIIzeVq9i0uFPgsiKFN9Zhj4/Azg1uvmnjAm5QaspITg+5Rd3xhl6req06eIwAzg1uMaD4ehjqNjIWNS/vhrR6PcqDnOeyn0rg7Z5gh54zpcResatbc+2CQPMfvHFUMckBHOagkY8bRpkwnb483SjgwRiWEm6reHdjMxUo3NekkYoteeDw4SH3uMkDHXwUkwExeqHcC0X1ArOLfoUsaNYpg5cqNC48rbxepKPWwxiH/a75zb5g7kA8BtyOvwKg5yaJrRQISTCdcPcl12O9CxrdAeFh7Wpv1DPa77a+78dEeVJyx3/Xcd5WdbygAHm3p7ri/QCqeNKf0q16sIB8739JigSfBWyf/pOFNZKzuTsr96ZIbgxkT1IXD3N37hai2zXbO7s/IOe2T3NvkhkgYzDgfpkNCTdkWrvkk7NJL5tQNggEP7m2VDC8IGR++Cl13Gd2xBmL9lKxvGyLU+VpkE+wbTtQODo1tD8a4+3JOrLwRd92Pbak2osgEE8lo7FAQ11DqkR57GlkqjCwnjkDMWmm6SsJfQHthDZEOdKjx4Sbk0pLl8wdeRqpLsdo78c9fzxVhUD3Vu9x//lMC+YAElYqeVKJpgXRQGdJZ4e/ZQ3Lljb7SuytmgMssI+01yH+Zsg==
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2334c574-fe7a-4975-7b21-08d866e59277
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 15:12:26.5751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oo4LdAKdzMTYgwUJtI+LVMl1hm8QopHhiV3hM06k/CYRkjK7rBsZColqcNWKLvfxfE3UgV4xlTkVTTFx6E+m1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4517
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/1/20 4:43 PM, J. Bruce Fields wrote:
> On Thu, Oct 01, 2020 at 04:05:13PM -0500, Patrick Goetz wrote:
>>
>>
>> On 10/1/20 3:06 PM, J. Bruce Fields wrote:
>>> On Thu, Oct 01, 2020 at 01:41:39PM -0500, Patrick Goetz wrote:
>>>> Hi Bruce,
>>>>
>>>> Thanks for the reply. See below.
>>>>
>>>> On 10/1/20 1:30 PM, J. Bruce Fields wrote:
>>>>> On Fri, Sep 25, 2020 at 09:40:16AM -0500, Patrick Goetz wrote:
>>>>>> My University information security office does not like rpcbind and
>>>>>> will automatically quarantine any system for which they detect a
>>>>>> portmapper running on an exposed port.
>>>>>>
>>>>>> Since I exclusively use NFSv4 I was happy to "learn" that NFSv4
>>>>>> doesn't require rpcbind any more.  For example, here's what it says
>>>>>> in the current RHEL documentation:
>>>>>>
>>>>>> "NFS version 4 (NFSv4) works through firewalls and on the Internet,
>>>>>> no longer requires an rpcbind service, supports Access Control Lists
>>>>>> (ACLs), and utilizes stateful operations."
>>>>>>
>>>>>> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_file_systems/exporting-nfs-shares_managing-file-systems#introduction-to-nfs_exporting-nfs-shares
>>>>>>
>>>>>> I'm using Ubuntu 20.04 rather than RHEL, but the nfs-server service
>>>>>> absolutely will not start if it can't launch rpcbind as a precursor:
>>>>>>
>>>>>> -----------------------------
>>>>>> root@helios:~# systemctl stop rpcbind
>>>>>> Warning: Stopping rpcbind.service, but it can still be activated by:
>>>>>>    rpcbind.socket
>>>>>> root@helios:~# systemctl mask rpcbind
>>>>>> Created symlink /etc/systemd/system/rpcbind.service → /dev/null.
>>>>>>
>>>>>> root@helios:~# systemctl restart nfs-server
>>>>>> Job for nfs-server.service canceled.
>>>>>> root@helios:~# systemctl status nfs-server
>>>>>> ● nfs-server.service - NFS server and services
>>>>>>       Loaded: loaded (/lib/systemd/system/nfs-server.service;
>>>>>> enabled; vendor preset: enabled)
>>>>>>      Drop-In: /run/systemd/generator/nfs-server.service.d
>>>>>>               └─order-with-mounts.conf
>>>>>>       Active: failed (Result: exit-code) since Fri 2020-09-25
>>>>>> 14:21:46 UTC; 10s ago
>>>>>>      Process: 3923 ExecStartPre=/usr/sbin/exportfs -r (code=exited,
>>>>>> status=0/SUCCESS)
>>>>>>      Process: 3925 ExecStart=/usr/sbin/rpc.nfsd $RPCNFSDARGS
>>>>>> (code=exited, status=1/FAILURE)
>>>>>>      Process: 3931 ExecStopPost=/usr/sbin/exportfs -au (code=exited,
>>>>>> status=0/SUCCESS)
>>>>>>      Process: 3932 ExecStopPost=/usr/sbin/exportfs -f (code=exited,
>>>>>> status=0/SUCCESS)
>>>>>>     Main PID: 3925 (code=exited, status=1/FAILURE)
>>>>>>
>>>>>> Sep 25 14:21:46 helios systemd[1]: Starting NFS server and services...
>>>>>> Sep 25 14:21:46 helios rpc.nfsd[3925]: rpc.nfsd: writing fd to
>>>>>> kernel failed: errno 111 (Connection refused)
>>>>>> Sep 25 14:21:46 helios rpc.nfsd[3925]: rpc.nfsd: unable to set any
>>>>>> sockets for nfsd
>>>>>> Sep 25 14:21:46 helios systemd[1]: nfs-server.service: Main process
>>>>>> exited, code=exited, status=1/FAILURE
>>>>>> Sep 25 14:21:46 helios systemd[1]: nfs-server.service: Failed with
>>>>>> result 'exit-code'.
>>>>>> Sep 25 14:21:46 helios systemd[1]: Stopped NFS server and services.
>>>>>> -----------------------------
>>>>>>
>>>>>> So, now I'm confused.  Does NFSv4 need rpcbind to be running, does
>>>>>> it just need it when it launches, or something else?  I made a local
>>>>>> copy of the systemd service file and edited out the rpcbind
>>>>>> dependency, so it's not that.
>>>>>
>>>>> Do you have v2 and v3 turned off in /etc/nfs.conf?
>>>>
>>>> It's an Ubuntu system, hence doesn't use /etc/nfs.conf; however I do
>>>> have these variables set in /etc/default/nfs-kernel-server :
>>>>
>>>>    MOUNTD_NFS_V2="no"
>>>>    MOUNTD_NFS_V3="no"
>>>>    RPCMOUNTDOPTS="--manage-gids -N 2 -N 3"
>>>>
>>>> maybe this isn't the correct way to disable NFSv2/3, but it's all I
>>>> could find documented.
>>>
>>> That should do it, but if you want to verify that it worked, you can
>>> read /proc/fs/nfsd/versions.
>>
>> That's it.  The syntax above is *not* disabling NFSv3:
>>
>> root@helios:~# cat /proc/fs/nfsd/versions
>> -2 +3 +4 +4.1 +4.2
> 
> Looking more closely....  Does nfs-kernel-server have an RPCNFSDOPTS
> variable or something?  rpc.nfsd needs to be run with -N 2 -N 3 as well.
> 
> --b.

Hmmm, not exactly, but here are the relevant details from the 
/usr/lib/systemd/system/nfs-server.service file:

-----------------------------
Wants=nfs-config.service
After=nfs-config.service

[Service]
EnvironmentFile=-/run/sysconfig/nfs-utils

Type=oneshot
RemainAfterExit=yes
ExecStartPre=/usr/sbin/exportfs -r
ExecStart=/usr/sbin/rpc.nfsd $RPCNFSDARGS
-----------------------------

which I think explains why this isn't working properly, based on your 
comment. The /run/sysconfig/nfs-utils file is assembled by 
nfs-config.service from the /etc/default/nfs-kernel-server file:

root@helios:/run/sysconfig# cat nfs-utils
PIPEFS_MOUNTPOINT=/run/rpc_pipefs
RPCNFSDARGS=" 16"
RPCMOUNTDARGS="--manage-gids -N 2 -N 3"
STATDARGS=""
RPCSVCGSSDARGS=""
SVCGSSDARGS=""

So rpc.nfsd is only being started with $RPCNFSDARGS and not $RPCMOUNTDARGS

I think what you're saying is that I need to add $RPCMOUNTDARGS to the 
service file command line for rpc.nfsd?

  -

Ugh, lengthy aside: I'm finding so many bugs in Debian/Ubuntu packaging 
based on packagers minimal understanding of how NFS/autofs work. We do 
computation biology, and for almost a year were plagued by a performance 
slow down which boiled down to these 2 lines in /etc/passwd:

syslog:x:102:106::/home/syslog:/usr/sbin/nologin
cups-pk-helper:x:124:118:user for cups-pk-helper 
service,,,:/home/cups-pk-helper:/usr/sbin/nologin

Notice the invocation of non-existent home directories. On Arch Linux 
systems these are set to /:

     cups:x:209:209:cups helper user:/:/sbin/nologin

On non-network filesystem workstations this is harmless, but we use 
autofs for home directory mounts, and the biologists run their software 
from anaconda environments. A rather poor design decision, but when 
launched, mini/anaconda scans through /etc/password looking for places 
environments might be hidden away. autofs was hanging every time there 
was an attempted access of a non-existent home directory. As experienced 
by the researchers, they would try and run a program and it would just 
hang 5-10 minutes loading some python module.

This is why I was complaining about documentation.  There's now a whole 
generation of IT professionals for whom NFS is entirely opaque due to a 
lack of up to date documentation.

> 
>>
>>
>>
>>>
>>>> The linux kernel version is 5.4.0, and the nfs-kernel-server package
>>>> version is 1:1.3.4-2.5ubuntu3.3 (so upstream 1.3.4), but I'm not
>>>> sure this is relevant.
>>>
>>> I can't reproduce the problem on my 5.9-ish server, but I also can't
>>> recall any relevant changes here.
>>>
>>> Looking back through the history....  Kinglong Mee fixed the server to
>>> ignore rpbind failures in the v4-only case about 7 years ago, back in
>>> 4.13.
>>>
>>> --b.
>>>
