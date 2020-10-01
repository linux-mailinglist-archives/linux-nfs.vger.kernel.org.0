Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C34280943
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Oct 2020 23:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgJAVMg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 17:12:36 -0400
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:38475 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgJAVM0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 17:12:26 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2020 17:12:25 EDT
IronPort-SDR: N3ROMIABSOKBp4U9rerdOkylozmtqvEn+dHeCozI7BnadppERHquhmXLp5jEGGiDO3u09PWi9U
 bRkVmUAHZi2kiwTdEk6dSFIj+LfZQXtYneo5rPjyEnJWbk3h+qudzR6yUrUFiXf7Cxoy2AEKpO
 EkDw1Hr7w8NNfV3hxCQ6GT2b7CS/7gRBYH77tgsGPot6QjpCXwNWNIL+c1v3rBDiyNPyZsVwyZ
 hyafmfIj3rGsRxZgAivTxTSD2ZLPRO6Ay9Fo0jQSyYg4+0tzdh32C5jK6Uh74yBzqUukfgKKha
 QoA=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 246202240
X-IPAS-Result: =?us-ascii?q?A2EeAAAwQ3Zfh2Y3L2hgGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFPgVJRd4E0CoQzg0cBAYU5iCImgQKXdYJTAxg9AgkBAQEBA?=
 =?us-ascii?q?QEBAQEHAh4PAgQBAQKESAI1ggImOBMCAwEBAQMCAwEBAQEGAQEBAQEBBQQCA?=
 =?us-ascii?q?hABAQGFeTkMg1RJOgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQUCDVQrPQEBAQECARIRDwEFCAEBNwEPCQIYAgIVAg8CAjIlBg0IAQEeg?=
 =?us-ascii?q?wQBgksDDiABDo9Rjh0BgSg+AiMBPwEBC4EFKYhhdoEygwEBAQWBR0FDgkcYQ?=
 =?us-ascii?q?QkNgTkDBgkBgQQqgnKKV4FBP4ERJwwDgiU1PoJcAQOBRXcCgjaCYJARCgcuj?=
 =?us-ascii?q?ACBE5hjgQqCcYh9hliKfQUHAx+DDo8VKYkEhUueAJUjAgQCBAUCDgEBBYFrg?=
 =?us-ascii?q?XszGggdE4MkUBcCDYEZjQYMDgmDTop0VjcCBgEJAQEDCXxAilICAoExATFfA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: =?us-ascii?q?9a23=3Av4GIeh2bPNq7DfM3smDT+zVfbzU7u7jyIg8e44?=
 =?us-ascii?q?YmjLQLaKm44pD+JxWEuadzg1LTG4bW8fRJj6zRqa+zEWAD4JPUtncEfdQMUh?=
 =?us-ascii?q?IekswZkkQmB9LNEkz0KvPmLklYVMRPXVNo5Te3ZE5SHsuteVLfuDux4CQUFx?=
 =?us-ascii?q?G5MhB6daz5H4fIhJGx0Oa/s5TYfwRPgm+7ZrV/SXf+rQjYusQMx4V4LaNkzx?=
 =?us-ascii?q?LVoj1VZ+lGzHguKF6OzBs=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.77,325,1596517200"; 
   d="scan'208";a="246202240"
X-Utexas-Seen-Outbound: true
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 16:05:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPg4XVzZwG1n5b1GrgXwIO9QxphBbyqb96bVbMUpXkQR8QSwjELQ24V8KBjuNzb6W4TyANWHVpEmw9XtPmPQWqXnRFjSg4ULZkFXZLoo4iZHNGVBU358KytWethfwT/9MiUH+Av/TA7krDRe3/SB1TcQHB7VtrK18sSDkceCMXkTHhACuqSboKv4i46WpBYHPyp2hS87UkiPTRW/VY043rTwKocfR81sh7lQMhYrI5+/dDDiP3dnD/VCsWHIQW3vowFAV5CryJsYIPlFMKji4B183V7ZZa75Y9ERZWBYiTbPrULA7Xypa1U8sdkYHyW588XFygYP4j5s4dLzoRrKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEK1tCZ+eb4mYDChuWTPBGP15z6wVqI9b3oOrun48VM=;
 b=dN7Sm3j4FxDd/qwHQqkYjCpXrcbaBoXYZls7Dy7k/2cFIU23N8sDL9HUHfAO9UejIC34yTqQTzUNGvD5oFptzKC2rBu0anv2yZaMSxKJVgWmkQdTDuHz9bUT0McNoZU79LgpAFSaw3hLgeUh+vbhJUh1ht4HXPwoEZA+aivctAWV68DXpq+h2hD0fC5Z26jLdsYkfDWB9RK2t5d3HRuht+eZa0hqrBupomJSdEg9U1uL0IUkwe6KRr4nx2QOz6y96I/umWVS/m+rrqA9XFxelXJqVS5omxyS4+7V3U7nor4xLyaFE2zEFzlJSNRBX54ecnjqzbAmK/KEwM4YtzsjGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEK1tCZ+eb4mYDChuWTPBGP15z6wVqI9b3oOrun48VM=;
 b=KuZDv0mtcMXTgACA89YT+dxdUZrMagDP0n56UtZotb0xSGr6tHWc16vCP+YrGvzsxdQUPdcdJauj3izyt+um1Ke+e9vaqIDm1Fer+ODCgZMQdpc9ECv204i3UhZt7Gv82XFLvcFQ0ny+n4qWkR22hl2TMfro7SurzNV9Nattc4E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB4630.namprd06.prod.outlook.com (2603:10b6:a03:52::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Thu, 1 Oct
 2020 21:05:15 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::145b:33d4:e2d3:ad59]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::145b:33d4:e2d3:ad59%5]) with mapi id 15.20.3433.036; Thu, 1 Oct 2020
 21:05:15 +0000
Subject: Re: rpcbind redux
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <6b0c5514-ebb1-fde7-abba-7f4130b3d59f@math.utexas.edu>
 <20201001183036.GD1496@fieldses.org>
 <f621c004-3402-09d0-b2d0-83d610525a7c@math.utexas.edu>
 <20201001200603.GH1496@fieldses.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <2df155d8-2f0b-c113-5244-a09bbea370b3@math.utexas.edu>
Date:   Thu, 1 Oct 2020 16:05:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201001200603.GH1496@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: SN1PR12CA0057.namprd12.prod.outlook.com
 (2603:10b6:802:20::28) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (67.198.113.142) by SN1PR12CA0057.namprd12.prod.outlook.com (2603:10b6:802:20::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Thu, 1 Oct 2020 21:05:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e60085f2-158e-4262-71b2-08d8664db182
X-MS-TrafficTypeDiagnostic: BYAPR06MB4630:
X-Microsoft-Antispam-PRVS: <BYAPR06MB46307B44D85CED103FDF6E3A83300@BYAPR06MB4630.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Ht0wvEqvrPyvGIhy3p9K1HkmQzFCuFyGyftaAy4FLw8XlJD3oMDrFgorJi8ipaH/AgfyhzdTUkIFYO56c95atF2od6RdMEmoDiCum4iPRMPbLWTqnKbFJ+QFaQiukuMa5POZIKXNziRzd3k6WC0mLKi2Lgy6/X4dBAqHXYXRZbS+DXUtgOPSEwxaV7ry62azCyEE3PNI6YKn1D77aM9nB2ZW1TbFZGB9y4zsSghig3eg0IuaEpBCVz2qAze4ARmBkWX4hxYIQBPfm0cpDNzqqqQ3zGkrxe9Zf6pyBdDi47+JXf2d9WJhOjGwWG2O4HbguJoAseUFri+e5uffAzc7V7Jivs7YPz9wzY08SKFueVolS70Is5qFuaRBbVRHbdlGx3QQNZ+K68lkqwfiT12nDoVyLUltFr9zjL+081Ov8uypfd0Q9ycpqfj2eZ0kk/G6yRz0viMWABaqj0byCYASw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(52116002)(66946007)(53546011)(66556008)(83080400001)(3480700007)(83380400001)(66574015)(31686004)(66476007)(6486002)(7116003)(4326008)(8676002)(5660300002)(8936002)(2906002)(86362001)(6916009)(75432002)(31696002)(26005)(2616005)(786003)(956004)(16526019)(478600001)(186003)(16576012)(316002)(966005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5oTLl3lS0CMIUAMBRFGpE5gawY77u2rrf4udcaKTAnE/l+unTQoziTJCWQ5GS2WiieVgp1lg8AcDDP65JGbahTEvUkeyV1yP36HbzjsCVtzrQecFQUAbJhH1MAZN0wGlKR5YjVl4rjgKRHqPrbiWbwEAkeiRbz6vay5OaEb53rQGStmikf9689ZeLJr7Hh9IJf8VxERowGVw/oY+DBrX0Hk/HiododUUKe9JSS1WXG1gTx27aGkwk5m68WF6tASJOVezCP2KhoI+PNb05YPZoscqFAVbMMcNaddTtbA/oFYx2w4EDjVtd5P9gLvJ+L2y5d0nPxe391pbR0g7dBCFn2gIkDGhxGaSVlZ9s/5UedhRe+pJ4lNuYXj1Cllayc8d+ylp86gALit6VZMA9un7UXjyH+gByUCNlIet6fNseUmuBnwWev6V/wtpUVITMAgOhNiKz5D9XhrHLwSWwbNgM2yYmRgIIIFzqauo/T8aSY66hOQ3m428NeGfQwdPA+8G5e6k1Jm3pA/sqRFSrNxoz0iq2b8BevZ5w5mUwCkWFiXOfubpXzH62si5RfKWg8qCGq/QXXogDQCfp0gKmZywvUWISGP8cq7zjCSJ8oFjgkjk1irJ4hAmY9SvFjvn9Xut/vrWqGi9tAqkzX8cobb5vQ==
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e60085f2-158e-4262-71b2-08d8664db182
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 21:05:15.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55cHW5oCRPfFTXcMsyf8TTRBnkU7Q8gwBT6cc3h5wVDyrbL40o4TwEaFMYBpoHR1K9yssqnhNf8JOzTiO3Mx5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4630
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/1/20 3:06 PM, J. Bruce Fields wrote:
> On Thu, Oct 01, 2020 at 01:41:39PM -0500, Patrick Goetz wrote:
>> Hi Bruce,
>>
>> Thanks for the reply. See below.
>>
>> On 10/1/20 1:30 PM, J. Bruce Fields wrote:
>>> On Fri, Sep 25, 2020 at 09:40:16AM -0500, Patrick Goetz wrote:
>>>> My University information security office does not like rpcbind and
>>>> will automatically quarantine any system for which they detect a
>>>> portmapper running on an exposed port.
>>>>
>>>> Since I exclusively use NFSv4 I was happy to "learn" that NFSv4
>>>> doesn't require rpcbind any more.  For example, here's what it says
>>>> in the current RHEL documentation:
>>>>
>>>> "NFS version 4 (NFSv4) works through firewalls and on the Internet,
>>>> no longer requires an rpcbind service, supports Access Control Lists
>>>> (ACLs), and utilizes stateful operations."
>>>>
>>>> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_file_systems/exporting-nfs-shares_managing-file-systems#introduction-to-nfs_exporting-nfs-shares
>>>>
>>>> I'm using Ubuntu 20.04 rather than RHEL, but the nfs-server service
>>>> absolutely will not start if it can't launch rpcbind as a precursor:
>>>>
>>>> -----------------------------
>>>> root@helios:~# systemctl stop rpcbind
>>>> Warning: Stopping rpcbind.service, but it can still be activated by:
>>>>    rpcbind.socket
>>>> root@helios:~# systemctl mask rpcbind
>>>> Created symlink /etc/systemd/system/rpcbind.service → /dev/null.
>>>>
>>>> root@helios:~# systemctl restart nfs-server
>>>> Job for nfs-server.service canceled.
>>>> root@helios:~# systemctl status nfs-server
>>>> ● nfs-server.service - NFS server and services
>>>>       Loaded: loaded (/lib/systemd/system/nfs-server.service;
>>>> enabled; vendor preset: enabled)
>>>>      Drop-In: /run/systemd/generator/nfs-server.service.d
>>>>               └─order-with-mounts.conf
>>>>       Active: failed (Result: exit-code) since Fri 2020-09-25
>>>> 14:21:46 UTC; 10s ago
>>>>      Process: 3923 ExecStartPre=/usr/sbin/exportfs -r (code=exited,
>>>> status=0/SUCCESS)
>>>>      Process: 3925 ExecStart=/usr/sbin/rpc.nfsd $RPCNFSDARGS
>>>> (code=exited, status=1/FAILURE)
>>>>      Process: 3931 ExecStopPost=/usr/sbin/exportfs -au (code=exited,
>>>> status=0/SUCCESS)
>>>>      Process: 3932 ExecStopPost=/usr/sbin/exportfs -f (code=exited,
>>>> status=0/SUCCESS)
>>>>     Main PID: 3925 (code=exited, status=1/FAILURE)
>>>>
>>>> Sep 25 14:21:46 helios systemd[1]: Starting NFS server and services...
>>>> Sep 25 14:21:46 helios rpc.nfsd[3925]: rpc.nfsd: writing fd to
>>>> kernel failed: errno 111 (Connection refused)
>>>> Sep 25 14:21:46 helios rpc.nfsd[3925]: rpc.nfsd: unable to set any
>>>> sockets for nfsd
>>>> Sep 25 14:21:46 helios systemd[1]: nfs-server.service: Main process
>>>> exited, code=exited, status=1/FAILURE
>>>> Sep 25 14:21:46 helios systemd[1]: nfs-server.service: Failed with
>>>> result 'exit-code'.
>>>> Sep 25 14:21:46 helios systemd[1]: Stopped NFS server and services.
>>>> -----------------------------
>>>>
>>>> So, now I'm confused.  Does NFSv4 need rpcbind to be running, does
>>>> it just need it when it launches, or something else?  I made a local
>>>> copy of the systemd service file and edited out the rpcbind
>>>> dependency, so it's not that.
>>>
>>> Do you have v2 and v3 turned off in /etc/nfs.conf?
>>
>> It's an Ubuntu system, hence doesn't use /etc/nfs.conf; however I do
>> have these variables set in /etc/default/nfs-kernel-server :
>>
>>    MOUNTD_NFS_V2="no"
>>    MOUNTD_NFS_V3="no"
>>    RPCMOUNTDOPTS="--manage-gids -N 2 -N 3"
>>
>> maybe this isn't the correct way to disable NFSv2/3, but it's all I
>> could find documented.
> 
> That should do it, but if you want to verify that it worked, you can
> read /proc/fs/nfsd/versions.

That's it.  The syntax above is *not* disabling NFSv3:

root@helios:~# cat /proc/fs/nfsd/versions
-2 +3 +4 +4.1 +4.2



> 
>> The linux kernel version is 5.4.0, and the nfs-kernel-server package
>> version is 1:1.3.4-2.5ubuntu3.3 (so upstream 1.3.4), but I'm not
>> sure this is relevant.
> 
> I can't reproduce the problem on my 5.9-ish server, but I also can't
> recall any relevant changes here.
> 
> Looking back through the history....  Kinglong Mee fixed the server to
> ignore rpbind failures in the v4-only case about 7 years ago, back in
> 4.13.
> 
> --b.
> 
