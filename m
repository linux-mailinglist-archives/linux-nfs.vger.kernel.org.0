Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A32B283CBB
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Oct 2020 18:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgJEQqX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Oct 2020 12:46:23 -0400
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:26898 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgJEQqX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Oct 2020 12:46:23 -0400
IronPort-SDR: OUaTahmqZKdp1hnQ7cOMg3wlM/e1sM38eFR9CYAAMNyCvmB7fA4sAxCWayO68JeZkxd8Q+/W7L
 5bCUYSuwbc+9PrqFjtuCDKWu2LnO/iupDTLO27RYLwl8bQSyhDi9uhjDtIPpZ6FS1UZUPj05WU
 3knvOyQyXkbEQUlgNrmLmiy8v23s9kRYMWw7KyICFDpfOFCz1La0Bua7UJxUENoEgwRd2j8zH0
 7FaMSGU7kT5EXADRkE5FXMkel/Q80hPmIxeeta/pIsfmYeOuCDJsAPXitqjHAbpznLzYZNxFoB
 UFE=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 246178712
X-IPAS-Result: =?us-ascii?q?A2EIBAAPTXtfh603L2hgHgEBCxIMQIMhUXeBNAqEM4NHA?=
 =?us-ascii?q?QGFOYgICCaYe4JTAxg9AgkBAQEBAQEBAQEHAh8OAgQBAQKESAI1ggUmOBMCA?=
 =?us-ascii?q?wEBAQMCAwEBAQEGAQEBAQEBBQQCAhABAQGFeTkMg1RJOgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCFFQkPgEBAQMSEQ8BBQgBATgPC?=
 =?us-ascii?q?QIOCgICJgICMiUGAQwIAQEXB4MEAYJLAy4BjGOOHQGBKD4CIwE/AQELgQUpi?=
 =?us-ascii?q?VeBMoMBAQEFgkyCVRhBCQ2BOQMGCQGBBCqCcoYthC2BQT+BOAwDglo+glwFg?=
 =?us-ascii?q?UaDLYJgkBGMQIETmW2CcYh+kVcFBwMfgw6PFY58kxSBeYh1lSgCBAIEBQIOA?=
 =?us-ascii?q?QEFgWtbDYETMxoIHRODJFAXAg2OHxqDV2qKClY3AgYBCQEBAwl8iwYBKoEKA?=
 =?us-ascii?q?YEQAQE?=
IronPort-PHdr: =?us-ascii?q?9a23=3AdS7weBDx/ogcroANyMtgUyQJPHJ1sqjoPgMT9p?=
 =?us-ascii?q?ssgq5PdaLm5Zn5IUjD/qw20A3XUojBrfFJkezbt+bnQ2NTqZqCsXVXdptKWl?=
 =?us-ascii?q?dFjMgNhAUvDYaDDlGzN//laSE2XaEgHF9o9n22Kw5ZTcD5YVCBvHK/93gRFw?=
 =?us-ascii?q?/5OA4zIf76Scbeis2t3LW0/JveKwxDmDu6Z+Z0KxO7yGeZtsQfjYZ4bKgrzR?=
 =?us-ascii?q?6cp3JUe6JL2W54LEnVkhrhtco=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.77,340,1596517200"; 
   d="scan'208";a="246178712"
X-Utexas-Seen-Outbound: true
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 11:46:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRgDZC/ry8U8ultqlikFJCeuAgpPuGsQyosCY8zw9iCuDVrsArHVYDoZdd6en9t7ikq2ErEY7I4b1B4DsXh8PAUOs3iNMU3WTwvs7v2I5h/P9yqbl7rpYSpIxTLeDp6EeA905JpJQAqis+ZlHQE4wqfJ9FeeortnWZbACU+irz7d+jWy/KrotcI4orCasKRkoHz11TqmzablS7M55tDFujK8KiMZUr6SN0qmx7MK3PfWqXY6SlAr7225+xHT6snH2eKCOOUHk2Xj9yntAu9xy99NAh3MK/wT5geklf1r3M+jWwz0m970bHKxjuj9xFl6QdtkmbsMCP/xvJSimGxADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blse6BfmQKzecQ25ESObrUyfgUYSL9Y8f2nisP0n2hQ=;
 b=Uhnt44qq7mykfjFy1Qy7dArtHGWm5vvUqEVmk8Kg+yYYu7/W9mzcrKSyaq51M0tK5ZEMawzjDubFpj42BM9tOSe+3Rjhq8mhrCLcA1CwbGrxFvv8DlLgcLN0uIv2PSUAc5eSqpnMhhOOqxnILqWCQTyiDJKnCSVgNql9Z1LZ5omb5ZgwQ8pmQZMUsx8wLE0pRZV1Io3y8c3f/H+D01FHAb7dqGf6vneL6d1OnAEMDebPj5RBneMGrBa0FO5QZB5tOy54nW5fHW5/RBFiNL8Q0S9Av22KdBz34s2TOvk+Z49KSKKFL95nrbtd4uLsgGfkrxxlHsNgq1JzmIQtP+YcWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blse6BfmQKzecQ25ESObrUyfgUYSL9Y8f2nisP0n2hQ=;
 b=Hcueh30hgZciVD1FPVx8VRhPbTC1/Tp1io1/wYTIwr53okgXZRbFtIlwvr6qD1DI1rCVays4eu23zXJf2UB9qk/RCZNFYI2WjC5NAKMcuWQ13AU0ecUlwyb9zK7gznZDV1RnFcZPkcMxC1xPgZpQIwE4gG6fUqDIxuefxJI/XR4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by SJ0PR06MB6782.namprd06.prod.outlook.com (2603:10b6:a03:28f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Mon, 5 Oct
 2020 16:46:19 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::145b:33d4:e2d3:ad59]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::145b:33d4:e2d3:ad59%5]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 16:46:19 +0000
Subject: Re: nfs home directory and google chrome.
To:     Kenneth Johansson <ken@kenjo.org>, linux-nfs@vger.kernel.org
References: <0ba0cd0c-eccd-2362-9958-23cd1fa033df@kenjo.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <5326b6a3-0222-fc1a-6baa-ae2fbdaf209d@math.utexas.edu>
Date:   Mon, 5 Oct 2020 11:46:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <0ba0cd0c-eccd-2362-9958-23cd1fa033df@kenjo.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: SN6PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:805:de::17) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.7] (67.198.113.142) by SN6PR05CA0004.namprd05.prod.outlook.com (2603:10b6:805:de::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.15 via Frontend Transport; Mon, 5 Oct 2020 16:46:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e982066-ed98-4797-a3d7-08d8694e2f05
X-MS-TrafficTypeDiagnostic: SJ0PR06MB6782:
X-Microsoft-Antispam-PRVS: <SJ0PR06MB6782C5A58540B7B80819B33A830C0@SJ0PR06MB6782.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0p1NbngPS6JUafnAtmcmBK1CzI3ooXu2FwHfOKuKAwqOr6cPTqoXi/qbiwITryFdikqj0REsMkFplA0ltGK6IhobzpLusLug0l/LSll8eldB7QJVJHuNqULDLHaKDkS9t+olyvdSghsQds4FeKyqge2yhGruuYKgpHsoVDTHZHl+vFXI35x786ovkZdco82QGA271tIhB+y2IbzKwgBqSV5FsgVGSsdMd8eBErUxKhQIWu0/4xxmEhCjzJEwmjg/EUliAIjpU7RPp+/znnp3MSCRbOBlLkWvchMCCK0H901hdY+iU8rpzrTmH2LIK4Fgd9eNu/dAWEy8VqAmlJfdL/C4haqm7BzXjTIaXJmLZMv3i820zjLKJFDPIuiw0YGknsbw78SaAnWCQz6030TYu1nK+dTdH2eci9TZYY+vnDmUu8t9kZtwdsn4Lj76n0wYUy96TPe3sf9NWyEF1Anpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(83080400001)(66476007)(66946007)(478600001)(31696002)(2906002)(16576012)(8676002)(66556008)(186003)(52116002)(53546011)(83380400001)(26005)(316002)(786003)(16526019)(966005)(8936002)(86362001)(6486002)(31686004)(5660300002)(2616005)(956004)(75432002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: c1LLecKln7u7AfyowlDplY0bmXbzFftBwN5ZcStIK3EQn1JDNRagUw7LDKRhcEYgGSG/uBeMuGoQ5kDZkjQ3BN+pekyYPw54O/LO/y+qrKFyWGGTGdPEAhy+FUPoae2Uq+vfzuiVFCLgtv86tV5VLidiG/x7i7+e/1d5PslJ5wlgc5mJ8y0E3KC4INHW78yP8pPa7znpEz58lFPcMKysLNJhVJsUP1/COg1Mq4Dfb5iXIw5ZvUgFr2mHYavCriJqqMWBVRnBzDwAwa9XMzzPowzpy3pi7T1xLr9marwBLtNjCGpNGWoejGPBMK6CYNsWIq99oXg5rdvEL/sVmyTnQq/6VGDgrHob/7Q4sFkiW5EKwHr1T0c4B6mHcCSQ6E0K0JoUYSfexpiEwG043uGMGOjtffM/1kCu70RQ3XwlFd3sAzNLWuS7w1RC7yAr+JwgTB3XnK3zvP2ohfC9w591kj8891ucwqePTbQbaNq5NknDlYvMSaDEW+mmc2bEZOKAjhVK48Hc03BfGpgirnxt96mWKwNQCActeVbuJQyZPd4n6Chc37DEZzkARQGi1wDD9NyHRmJHaRvnn5rDiDg6dozf//Stbzkhqkxq3C+gp5tHn1U+XxAlF1VUVHSdRuTCBxW+HysJ6pjIgFvZ5lvBtA==
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e982066-ed98-4797-a3d7-08d8694e2f05
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 16:46:19.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ct6GirQSrKI1+xPRYqHQ4SppeCO5LNzTfs2Hlg/unpyuSXRI/RsnQ9TpmP3UjIymVe6idg/Pk0Ip4kIiBcUyMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR06MB6782
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We had a similar problem with Firefox, most notably with Mac OSX users 
who have NFS-mounted home directories. There's an about:config solution 
for Firefox; namely set

    storage.nfs_filesystem: true

This forces a specific network file locking mechanism which makes sqlite 
behave better. I'm guessing google chrome has something similar.

On 10/4/20 6:53 AM, Kenneth Johansson wrote:
> So I have had for a long time problems with google chrome and suspend 
> resume causing it to mangle its sqlite database.
> 
> it looks to only happen if I use nfs mounted home directory. I'm not 
> sure exactly what is happening but lets first see if this happens to 
> anybody else.
> 
> How to get the error.
> 
> 1. start google from a terminal with "google-chrome"
> 
> 2. suspend the computer
> 
> 3. wait a while. There is some type of minimum time here I do not know 
> what its is but I basically get the error every time of I suspend in 
> evening and resume in morning
> 
> 4. look for printout that looks like something like this
> 
> [16789:18181:1004/125852.529750:ERROR:database.cc(1692)] Passwords 
> sqlite error 1034, errno 5: disk I/O error, sql: COMMIT
> [16789:16829:1004/125852.529744:ERROR:database.cc(1692)] Web sqlite 
> error 1034, errno 5: disk I/O error, sql: COMMIT
> [16789:16829:1004/125852.530261:ERROR:database.cc(1692)] Web sqlite 
> error 1034, errno 5: disk I/O error, sql: INSERT OR REPLACE INTO 
> autofill_model_type_state (model_type, value) VALUES(?,?)
> [16789:16789:1004/125852.563571:ERROR:sync_metadata_store_change_list.cc(34)] 
> Autofill datatype error was encountered: Failed to update ModelTypeState.
> [16789:19002:1004/125902.534103:ERROR:database.cc(1692)] History sqlite 
> error 1034, errno 5: disk I/O error, sql: COMMIT
> [16789:19002:1004/125902.536903:ERROR:database.cc(1692)] Thumbnail 
> sqlite error 778, errno 5: disk I/O error, sql: COMMIT
> 
> 
> [16789:19002:1004/130044.120379:ERROR:database.cc(1692)] Passwords 
> sqlite error 1034, errno 5: disk I/O error, sql: INSERT OR REPLACE INTO 
> sync_model_metadata (id, model_metadata) VALUES(1, ?)
> [16789:16829:1004/130044.120388:ERROR:database.cc(1692)] Web sqlite 
> error 1034, errno 5: disk I/O error, sql: INSERT OR REPLACE INTO 
> autofill_model_type_state (model_type, value) VALUES(?,?)
> 
> 
> and so on.  if you use google sync you can also check 
> "chrome://sync-internals" to see if something is wrong with the database.
> 
> 
> 
>>> This message is from an external sender. Learn more about why this <<
>>> matters at https://links.utexas.edu/rtyclf.                        <<
