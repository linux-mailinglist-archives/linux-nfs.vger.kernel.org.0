Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6183728071B
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Oct 2020 20:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgJASlq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 14:41:46 -0400
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:37003 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgJASlq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 14:41:46 -0400
IronPort-SDR: CHvKn479kPI1BX8mn0rrg0/pvcFlElcSeh4iPp8OndlQvbE8uHYPKz+ev7Ov3+YAQj329TqcXH
 7qbdKJXAqfEcGvHX6Fg0nA7iiAYjgAB4a1vTi/r2Be778pXkum4pNON8lKuwV7DpKjz0fC+KyX
 5PRfCjxGbaJYc9Fh+cw6r+uDB6hKjYIvCkd83MhSviaScWO1xebqZRiVP507GRyL1jRp3ohc1T
 JHYfCY2M1jURBMQiJc5ZE84k0XiNpl+j8oNM92Jqz4cO5p0IG7J2PotvrUkAEF3cUgVjy9qk4V
 j4c=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 245802980
X-IPAS-Result: =?us-ascii?q?A2EeAADoIXZfhypKL2hgGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFPgVJRd4E0CoQzg0cBAYU5iCEmgQKXdYJTAxg9AgkBAQEBA?=
 =?us-ascii?q?QEBAQEHAh4PAgQBAQKESAI1ggImOBMCAwEBAQMCAwEBAQEGAQEBAQEBBQQCA?=
 =?us-ascii?q?hABAQGFeTkMg1RJOgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQUCDVQrPQEBAQECARIRDwEFCAEBNwEPCQIYAgImAgIyJQYNCAEBHoMEA?=
 =?us-ascii?q?YJLAw4gAQ6PV44dAYEoPgIjAT8BAQuBBSmIYXaBMoMBAQEFgUdBQ4JKGEEJD?=
 =?us-ascii?q?YE5AwYJAYEEKoJyileBQT+BEScMA4IlNT6CXAEDgUWDL4JgkBEKBy6MAIETm?=
 =?us-ascii?q?GOBCoJxiH2GWIp9BQcDH5IjiS2FS54AlSMCBAIEBQIOAQEFgWuBezMaCB0Tg?=
 =?us-ascii?q?yRQFwINgRmNBgwOCYNOinRWNwIGAQkBAQMJfIsSBIExATFfAQE?=
IronPort-PHdr: =?us-ascii?q?9a23=3Ar6s/ghcqqcaMkryEKaEG/T+xlGMj4e+mNxMJ6p?=
 =?us-ascii?q?chl7NFe7ii+JKnJkHE+PFxlwaSAdfF5P9ezenbqabtXSoH+5nS+HwBcZkZUR?=
 =?us-ascii?q?gDhI1WmgE7G8eKBAX9K+KidC01GslOFToHt3G2OERYAoDyMlvVpHDh8zEfAF?=
 =?us-ascii?q?P8OBBzK+CzHZTd3Iy70umo8MjVZANFzDO2fbJ1KkCwqgPc06tegYZrJqsrjB?=
 =?us-ascii?q?XTpX4dfu1KxSV1OV+Dlg2668utr5M=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.77,324,1596517200"; 
   d="scan'208";a="245802980"
X-Utexas-Seen-Outbound: true
Received: from mail-bn8nam08lp2042.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:41:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQUf8PfjSCGpAOqIMaSURjxc/kGmrUjqKopQkVqT/a2C3OboyiOs60i5g9PmtM/3Hpr+IgtkFKXdEIqgGkgAUlUVh3PQ3Z/1GRDigUImAWVYQIwOQZ9X5QxL+c4m4lPAHL4dVBik7YXvlFVdXxLDWZPWBcsdiKAuRO+UBWn1iMmX9AZgPFXJM2NnGyoTp+8OacBsRUtwqXvYlhCta8R9i7iZS7uatyYpTdMxoKfXAbAYnn4goHKf2huggiNq6JDRSGVvaFJG9dVCy2onb/STra3RmPnz5E8Npsqpnv/jeXa39q47PqWp0u9JXImXZ6hek9U9p2QfvyTHY68irdK5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEGN5GXuxtKLvl9m+sLov29ltuLTCw5UkbU7xbnVXW0=;
 b=cLkqxK8wI7oFkhFKDmy/q+79eCGnx9gUYAjNh9Z31q2xZ5ljkUa332g4EAd//derUjbCoBeHaIvOw/ppXeHaOU1cSyg5uVfJpjSI6kHjIAvHt5cGIFAOEKPGbPJCLLyUOQ/v3499Kb3QE0VdbWJM4UxUKkmdGEGZLTsenY3OHYLw9y8TerustsM813P8yJkzgftRSSYI6thZp+FVor2JzYWveWGzRDb9Y3X7aSXV46BtSWvhwziCf99QTMJitTy//cSsfZuwUwML4exG9FuLfZu65VLvfanTSb3Gw6ygx40rXoie3tFyla3P79fMXRn5zv5+9TpJJbJs+sOUe2beRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEGN5GXuxtKLvl9m+sLov29ltuLTCw5UkbU7xbnVXW0=;
 b=iLxcn3pPGaDnFOhe6Xscyvc0HS2zbuNy7DuebUEYEfHqUw6I787grxbADtx8m9yo2K8ylIGHKUuKB5urpYW5Xr6//aOVXBv7Rto5gr1bfd6U7Q+sVC+/JX5CPvSsSoEkcsIZ2EfrKB7jMzol7C7Hyam7I7W2Z/shWSlIoYEA2B4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB4919.namprd06.prod.outlook.com (2603:10b6:a03:76::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 1 Oct
 2020 18:41:41 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::145b:33d4:e2d3:ad59]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::145b:33d4:e2d3:ad59%5]) with mapi id 15.20.3433.036; Thu, 1 Oct 2020
 18:41:41 +0000
Subject: Re: rpcbind redux
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <6b0c5514-ebb1-fde7-abba-7f4130b3d59f@math.utexas.edu>
 <20201001183036.GD1496@fieldses.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <f621c004-3402-09d0-b2d0-83d610525a7c@math.utexas.edu>
Date:   Thu, 1 Oct 2020 13:41:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201001183036.GD1496@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: SN6PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:805:de::32) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (67.198.113.142) by SN6PR05CA0019.namprd05.prod.outlook.com (2603:10b6:805:de::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18 via Frontend Transport; Thu, 1 Oct 2020 18:41:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aabb770-a806-410a-193a-08d86639a383
X-MS-TrafficTypeDiagnostic: BYAPR06MB4919:
X-Microsoft-Antispam-PRVS: <BYAPR06MB4919CA9C93EA725220501BD283300@BYAPR06MB4919.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJgqdeE+vHsImZkZDlS9Miz38RbBRLtfN7uvW7B/9s/2in0icdtqEdj9a23RdtS88iMtEmjkMKk6r0ZlIRt27ZqG2B1x87iKgkKPoh1CfRrHgCn9sDKN1/wreJgG/CwpqUMxVLpa+WWBAUdu5FSjUPlWOHH2yz6Q0QXXxfo0R1R3GgiZaNf08kzlB2eMvw5xj3ctoMOtZe8IyMB0CBIKkfNVDZQVTEFgcmYaqhKOe5dX0IcJQEdEwv+vHJ+rxKHLD/ZLAk0NFtXfC+Arirg0p5PDFz/wNWu2OZG1gislb1BsFTvRgu78AgOwACTRdq5mVErPpnezq7SVhFLQPr3FIKlJ0W7Jo6I6d3jUxWV6ArWkneWimYLFtINf675MV+Ff1v13papCL4tsbutgcvOUiPqjWoEehuhWKzObdg5JYnMGpFrSimUg+qZURess+GDeigUxTWPdT2/Z6y/gL03k816MS7El6oxeVPXfzgYJRfJOYS5o3YcWjKbBRJv8iIMi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(478600001)(5660300002)(8936002)(83380400001)(66574015)(6486002)(2906002)(66476007)(966005)(4326008)(86362001)(75432002)(8676002)(6916009)(31686004)(26005)(2616005)(53546011)(186003)(66556008)(956004)(7116003)(16526019)(52116002)(66946007)(3480700007)(31696002)(16576012)(316002)(786003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9/xH5l066sPVDDFbTzvEaVKMPozc7gJYSzpJaAiNnpR28lTiHT0LRvnIrTWRSDNEum5gj9W/2CLGeQtSc7sYBa6NZO5jGu1wAceBpRW9s5W0IMXSrf/rs3ymVUWb2rJH7m55Ivi55gcy+oX3ygTfAfL3HU1aYia1B70OEepHhkBz6I/NtFx8z/bVDOlGodaT02nxc4xJ1gnSF2WtXbBtFUGgZZMe3PwOOMPCq4KAOGea6F1ArnrZC5xCPtU+o3PNZao6DUMD9tSifuu7ZTJ3xOle17KOY6rX1N8Lcaa++4Ve82IDuZkYYe8VVdIk1If7+4RQ7/SL3prQXw+gzoCvEUELDnQNxsk7Xa/FW7UuMLmJeX0GoXp8NQVCfhZyecPRTVyRe/oROl2N82OHFmcZY8gw2lcevDNUiu87IxcfIv5ar8Oc7HNco5dTrfg9oS/uCTdHgYLf0xAfYOVbX+x72JP0MSoT+SI83zBD5Ze+S7B8Dh3xzJGtlGVDmoFGBnr77tc1IPlCi2Ha3rOwFHnJc87P2T6vbYmRTmaO14YWW1NXhGl1ivtHpnFp3/iCfs0FedUrkCohrLLVMNnlhDQXX/L+kYmDio4k7SPYWD4K4p1GUkSYiLtRiZBVQattZ6J1alZnH/mq7w1QmQOXghc/Rw==
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aabb770-a806-410a-193a-08d86639a383
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 18:41:41.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vi4On1v+d005fcwL/dQd4o7mR3S4TTrtsjNDYSKAeuanyCNwgOL7D3iWAHggRUK2BGhu0Ule2Iw0ittXcvAHRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4919
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

Thanks for the reply. See below.

On 10/1/20 1:30 PM, J. Bruce Fields wrote:
> On Fri, Sep 25, 2020 at 09:40:16AM -0500, Patrick Goetz wrote:
>> My University information security office does not like rpcbind and
>> will automatically quarantine any system for which they detect a
>> portmapper running on an exposed port.
>>
>> Since I exclusively use NFSv4 I was happy to "learn" that NFSv4
>> doesn't require rpcbind any more.  For example, here's what it says
>> in the current RHEL documentation:
>>
>> "NFS version 4 (NFSv4) works through firewalls and on the Internet,
>> no longer requires an rpcbind service, supports Access Control Lists
>> (ACLs), and utilizes stateful operations."
>>
>> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_file_systems/exporting-nfs-shares_managing-file-systems#introduction-to-nfs_exporting-nfs-shares
>>
>> I'm using Ubuntu 20.04 rather than RHEL, but the nfs-server service
>> absolutely will not start if it can't launch rpcbind as a precursor:
>>
>> -----------------------------
>> root@helios:~# systemctl stop rpcbind
>> Warning: Stopping rpcbind.service, but it can still be activated by:
>>    rpcbind.socket
>> root@helios:~# systemctl mask rpcbind
>> Created symlink /etc/systemd/system/rpcbind.service → /dev/null.
>>
>> root@helios:~# systemctl restart nfs-server
>> Job for nfs-server.service canceled.
>> root@helios:~# systemctl status nfs-server
>> ● nfs-server.service - NFS server and services
>>       Loaded: loaded (/lib/systemd/system/nfs-server.service;
>> enabled; vendor preset: enabled)
>>      Drop-In: /run/systemd/generator/nfs-server.service.d
>>               └─order-with-mounts.conf
>>       Active: failed (Result: exit-code) since Fri 2020-09-25
>> 14:21:46 UTC; 10s ago
>>      Process: 3923 ExecStartPre=/usr/sbin/exportfs -r (code=exited,
>> status=0/SUCCESS)
>>      Process: 3925 ExecStart=/usr/sbin/rpc.nfsd $RPCNFSDARGS
>> (code=exited, status=1/FAILURE)
>>      Process: 3931 ExecStopPost=/usr/sbin/exportfs -au (code=exited,
>> status=0/SUCCESS)
>>      Process: 3932 ExecStopPost=/usr/sbin/exportfs -f (code=exited,
>> status=0/SUCCESS)
>>     Main PID: 3925 (code=exited, status=1/FAILURE)
>>
>> Sep 25 14:21:46 helios systemd[1]: Starting NFS server and services...
>> Sep 25 14:21:46 helios rpc.nfsd[3925]: rpc.nfsd: writing fd to
>> kernel failed: errno 111 (Connection refused)
>> Sep 25 14:21:46 helios rpc.nfsd[3925]: rpc.nfsd: unable to set any
>> sockets for nfsd
>> Sep 25 14:21:46 helios systemd[1]: nfs-server.service: Main process
>> exited, code=exited, status=1/FAILURE
>> Sep 25 14:21:46 helios systemd[1]: nfs-server.service: Failed with
>> result 'exit-code'.
>> Sep 25 14:21:46 helios systemd[1]: Stopped NFS server and services.
>> -----------------------------
>>
>> So, now I'm confused.  Does NFSv4 need rpcbind to be running, does
>> it just need it when it launches, or something else?  I made a local
>> copy of the systemd service file and edited out the rpcbind
>> dependency, so it's not that.
> 
> Do you have v2 and v3 turned off in /etc/nfs.conf?

It's an Ubuntu system, hence doesn't use /etc/nfs.conf; however I do 
have these variables set in /etc/default/nfs-kernel-server :

   MOUNTD_NFS_V2="no"
   MOUNTD_NFS_V3="no"
   RPCMOUNTDOPTS="--manage-gids -N 2 -N 3"

maybe this isn't the correct way to disable NFSv2/3, but it's all I 
could find documented.

The linux kernel version is 5.4.0, and the nfs-kernel-server package 
version is 1:1.3.4-2.5ubuntu3.3 (so upstream 1.3.4), but I'm not sure 
this is relevant.

> 
> If yes, and nfsd is still refusing to start, that sounds like an nfsd
> bug; with v4 only it should definitely be ignoring any failures to
> contact rpcbind.
> 
> --b.
> 
