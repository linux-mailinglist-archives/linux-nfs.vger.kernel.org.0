Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85ACA2842E9
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 01:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgJEXU4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Oct 2020 19:20:56 -0400
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:36211 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgJEXUc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Oct 2020 19:20:32 -0400
IronPort-SDR: 9c7WtLt+c7ZSbpPpLbKzGFw+MLTeOPNGFUJmSyBcAOGE0XXGGT7GqTWYhiSJ4z8odI5UEhVp9E
 ciIcbOjdyzYmU9Mn6hyAxYp6oXaQaG9I/5t52VjASinKWUvbGf091St97PTTKDohSI+bOll80V
 RC4sQhOb1STTJkTQKu4b+e1Xoelp168VkWYnRtgKn0r2cmT4KML4a2GOcqYJtn5NrrLF/fbBq+
 DonzOvtHUZkN5ahWuPcanVAmz5TmqKI0DvIf8yMGEWOXMIssL4A0iGjKChlrTrbJseX7r9qUZh
 CM4=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 246231956
X-IPAS-Result: =?us-ascii?q?A2FRAgC3qXtfh2s3L2hgHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+BUlF3gTQKhDODRwEBhTmICS6Ye4JTAxg9AgkBAQEBAQEBAQEHAh8OAgQBA?=
 =?us-ascii?q?QKESAI1ggUmOBMCAwEBAQMCAwEBAQEGAQEBAQEBBQQCAhABAQGFeTkMg1RJO?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAoEMPgEBA?=
 =?us-ascii?q?QMSERUIAQE3AQ8LGAICJgICMiUGAQwIAQEXB4MEAYJLAy4BmyABgSg+AiMBP?=
 =?us-ascii?q?wEBC4EFKYlXgTKDAQEBBXuBUYJTGEEJDYE5CQkBgQQqgnKGLYQtgUE/gREnD?=
 =?us-ascii?q?4JaPoQlMYJ+gmCQIotcU4lukRKCcYh+hxmKPgUHAx+SI458kxSgFgIEAgQFA?=
 =?us-ascii?q?g4BAQWBa4F7MxoIHRODJAlHFwINjh8ag1eKdFY3AgYKAQEDCXyMOwGBEAEB?=
IronPort-PHdr: =?us-ascii?q?9a23=3AEptzQRZJmUtF0xki4sc7yjf/LSx94ef9IxIV55?=
 =?us-ascii?q?w7irlHbqWk+dH4MVfC4el21QSVD5vU5ugCiOfMta3kH2sa7sXJvHMDdclKUB?=
 =?us-ascii?q?kIwYUTkhc7CcGIQUv8MLbxbiM8EcgDMT0t/3yyPUVPXsqrYVrUry6s4jMIXB?=
 =?us-ascii?q?byLwx4IqLyAIGBx8iy3vq5rpvUZQgAjTGhYLR0eROxqwi01IEWjIJuJ7x3xA?=
 =?us-ascii?q?HOpy5NcvhWg350KEKahFDx6trj8Q=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.77,341,1596517200"; 
   d="scan'208";a="246231956"
X-Utexas-Seen-Outbound: true
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 18:20:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7kJuH0KkJEJm6OnyyOJXwFZtzX8LWrymgrDGoEe1LxuIHa8VJQGj+bFcPFLiJI5+ToHI0W7BnfsM+XsKFvBD1MeJvhcX3EeKW8LXaE+Cef7YFKhoXN2aA/IESSZCHMrFMHQwTVSgBVFKIpCqiqI7NH48vXyNzuPHPwwwqY11sZEdQO35Q2f6IEtK/ZgO4BdNg+0mqyLygOk9Mf9F1oRxjeQvuBeROWehgHDWC43X7V3DfwCabITjHCkwG06C/lyO4o//zyAsKk5N+cWwk+1wgLjXbtSVjpWa2sGbQMOaNDuzSCGT/bRpIJU1WchZRb1v0cJgOTtJNsiEmFvsY4ptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBvllSeyTY+gqUVeLaOjfUmeHGhe7MSDeBTg0SO/iLg=;
 b=WI9Enzv0Wve6EXUqSot+56rm1XVxhdtkOYlM6w3jQF2jjTn/+tCqpprr8ArXAChqRrLLsDe9ztHcocLdGd1AtOcZPkdUQPhQAWUJFkq47mlu4PZG+wTXHOykJhnYH+rnvMIZhdAVtHnTa9JdYqB2Q1QcfVcFhndzrUDrIRYBjToRXainpKS6o7cqMjobJie0n2h5oqUphL0a7AUQonH11GjOKshsoK7IITIgzchl9MjKjtU1gmTv0MKG3Miv7Dlkjq1MaPLiGXHVat+VB83/YpPWj6PfD157E8CkPhOlaWeK/6IBE0e0ZspVxt0bihhFQpBgYcvmpdIWZLi/UT5AsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBvllSeyTY+gqUVeLaOjfUmeHGhe7MSDeBTg0SO/iLg=;
 b=GcJ+FAuEaILceBYxAi4URuEKUQW06+FqyMt86U+40yecpPR9IuNqtAt2ecVWH03mdVG/iKjfn67GIdE8Rswj9mHQA8NngZziVsX9tlQNUEVy2RGADhCoV5woZuUwAyrSnGSVZqi3z92VVLF4p6hOQu/c5UWNq5jtYa+5A4n/9qU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB4918.namprd06.prod.outlook.com (2603:10b6:a03:7c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Mon, 5 Oct
 2020 23:20:28 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::145b:33d4:e2d3:ad59]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::145b:33d4:e2d3:ad59%5]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 23:20:28 +0000
Subject: Re: rpcbind redux
To:     "McIntyre, Vincent (CASS, Marsfield)" <Vincent.Mcintyre@csiro.au>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <6b0c5514-ebb1-fde7-abba-7f4130b3d59f@math.utexas.edu>
 <20201001183036.GD1496@fieldses.org>
 <f621c004-3402-09d0-b2d0-83d610525a7c@math.utexas.edu>
 <20201001200603.GH1496@fieldses.org>
 <2df155d8-2f0b-c113-5244-a09bbea370b3@math.utexas.edu>
 <20201001214344.GJ1496@fieldses.org>
 <5eae41f5-aa78-5cf4-5e39-8b39f1235a65@math.utexas.edu>
 <20201005135452.GD31739@fieldses.org>
 <20201005225534.GC15895@mayhem.atnf.CSIRO.AU>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <18dfec9e-f382-251e-2a8b-1e8a6c2b049b@math.utexas.edu>
Date:   Mon, 5 Oct 2020 18:20:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201005225534.GC15895@mayhem.atnf.CSIRO.AU>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: SN6PR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:805:66::47) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.7] (67.198.113.142) by SN6PR08CA0034.namprd08.prod.outlook.com (2603:10b6:805:66::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Mon, 5 Oct 2020 23:20:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e23a7da-cbd7-4037-a44e-08d869853ec7
X-MS-TrafficTypeDiagnostic: BYAPR06MB4918:
X-Microsoft-Antispam-PRVS: <BYAPR06MB49188CDBD1984C93B81CC415830C0@BYAPR06MB4918.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMSqXiwK+Jt8vOosScIGYnrT9jmHLIEEd/aRuYBk0T40k1NO1CzfRTGeuovsE6JnAvaU1wEN2Oijhg/CvPCX3ZCIdlVQ3KD8Ytk6+R3SvR93WPE7KjAYCsMaftklG4Kk4qqpq95K7clVQnx9ZRl4jSJwHHh4hVn/lXvzP7jAIBioqXZ05Q2x0xOokTx9gr9ahtYFdPkZOsVvO1EG5BhMpZ3xDr5X2Q2/Pl1L3FCMATW1s8praDy//NiY9CVRz07nmM3Vp6KTC2MWoiiKbzhgY6JIC0JP6759bUBtvEr/30K/GqJt+hXY/nRJpaIa2edJowrCvjeUAyEbtn1o2kF5BEUFri1MWTV7QALPoTnjr/GcOd1fxRnbqKJMELoLGC+P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(8676002)(86362001)(31686004)(316002)(786003)(2906002)(8936002)(16576012)(3480700007)(5660300002)(2616005)(66946007)(110136005)(31696002)(956004)(6666004)(66476007)(66556008)(83380400001)(26005)(186003)(478600001)(16526019)(75432002)(4326008)(52116002)(6486002)(7116003)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: S6l2gDMmnS9hZMB8UyPJh/ZdVcW9TXr43ITfq23l2c4RuJcek8Ey3b28FEBfWddoa8hjOiVzPMK0PLGoocRwfy4KVOW9MPKxV5qC2PpgSFuFt1nBkC27Td8RrVFUFNwLy3/Iq1KNQDf0rdBN9jayD73c3DQlff8LO/8yzAQvURTixvt2ceA38/SyCbKN3GPtJKnvwa4lJGe4/8OTlkIu8+H9Y1NM7ZvyDdpYCvZkV7HL78uH27C8oOtuuhgFMZIDXCKiv9TCjbAWztT81BwSWUfhJ5gHsuchesYyTRx6eOIQoCEiSTFktgwMKBfEpicR5bnjjwYitphOiNdh6zFGfcc7fNzjDv9aKwM9Yb/v3KS89tDZ1iDKZVScYL/3bBjrHFOqVzuUYKpVv3FgyzcwWACEoYLVVvHnhJGnica939pLajhCudC5gxV4DdE9aHC1cOQ3upf2+AbWHbG2eAJqO15rbmdwW56bhow791ruTvxmZSRSNLLuLIsztn5/BaXTPrcVikGDcrJxJm0SFJlTApsN0Nrsgbauk48TGBT6eyW38YMN9qhXK6tY0ke9Olw/0soLwrUCpQXaJQPVEXSavqqCMtwBQd5T77sk9+bfLD9hcZQA+YUn+QoMCxBcAQkJG7CL9HnVu6rOz+m/dkJ+dA==
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e23a7da-cbd7-4037-a44e-08d869853ec7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 23:20:28.2440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJBRoJBT7p3MAsXqxx7H4HmUdnz8a/0sEplu4p3i5vxxhhK8oGldMyqDQTU5k5PhD06n2pmI+ULku0xD28I6Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4918
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Yep, just came here to post this myself and saw your message.  The 
problem is RPCNFSDOPTS is missing from the 
/etc/default/nfs-kernel-server file.

The service file for the nfs server, 
/usr/lib/systemd/system/nfs-config.service

includes this:

   Wants=nfs-config.service
   After=nfs-config.service

All nfs-config does is run this script:

   ExecStart=/usr/lib/systemd/scripts/nfs-utils_env.sh

and the script reads the /etc/default/nfs* files and then

   echo RPCNFSDARGS=\"$RPCNFSDOPTS ${RPCNFSDCOUNT:-8}\"

which then goes on the command line in the nfs-server service file:

   ExecStart=/usr/sbin/rpc.nfsd $RPCNFSDARGS

So the solution is to add this line to /etc/default/nfs-kernel-server:

   RPCNFSDOPTS="-N 2 -N 3"

Still unaccounted for is this variable in /etc/default/nfs-kernel-server:

   # Runtime priority of server (see nice(1))
   RPCNFSDPRIORITY=0

Which I can't find used anywhere in the service files.  But in any case, 
adding the RPCNFSDOPTS variable resolved the issue:

root@helios:~# cat /proc/fs/nfsd/versions
-2 -3 +4 +4.1 +4.2

Thanks!

On 10/5/20 5:55 PM, McIntyre, Vincent (CASS, Marsfield) wrote:
> On Mon, Oct 05, 2020 at 09:54:52AM -0400, J. Bruce Fields wrote:
>> On Fri, Oct 02, 2020 at 10:12:24AM -0500, Patrick Goetz wrote:
>>> I think what you're saying is that I need to add $RPCMOUNTDARGS to
>>> the service file command line for rpc.nfsd?
>>
>> Somehow you just need to make sure rpc.nfsd is also getting "-N 2 -N 3"
>> added to its commandline.  I'm not sure of the right way to do that with
>> Debian's configuration.
>>
> 
> I think the canonical way to do this is to edit
> /etc/default/nfs-kernel-server
> 
> and set
> RPCNFSDOPTS="-N 2 -N3"
> 
> or similar.
> 
> There were some issues in the past with the nfs init scripts
> not picking up settings in that file correctly, but I believe
> they have been corrected.
> 
> Kind regards
> 
