Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B732860BC
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 15:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgJGN5k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 09:57:40 -0400
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:35817 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgJGN5j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 09:57:39 -0400
IronPort-SDR: +zOJFFkaUgzppAQEMSM0yWYlWZHvqrAx/Kvl8BNaHuFF4Cjjoz6rvim/elM/4rOXmfLoyQ9mU2
 9NDl0gKpxIoa0pdAy19tP/rAytGn7uLr5f5ZraguIiR7y5bG7yJ7YFUVFKim4B7aKDRd4Uk7jW
 NUmdPtWC2u0LrU0vajRElZKdKIwZuO5J2SXM8/wThaDsxByfcIpctC6VNmMDAl5GtEcMR6qaSv
 cgyVZYrDL84e6co0sigAOfs/XXU8QkUBrZlYQNNjd6Oy1/V/tuhM2j8NUf6p3Y3x9RLwQEEF/D
 gaY=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 246413836
X-IPAS-Result: =?us-ascii?q?A2HlAQASyH1fh2s6L2hgHQEBAQEJARIBBQUBQIFPgVJRd?=
 =?us-ascii?q?4E0CoQzg0cBAYU5iA0umHuCUwMYPQIJAQEBAQEBAQEBBwItAgQBAQKESAI1g?=
 =?us-ascii?q?VQmOBMCAwEBAQMCAwEBAQEGAQEBAQEBBQQCAhABAQGFeTkMg1RJOgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCgQw+AQEBAxIRFQgBA?=
 =?us-ascii?q?TgPCxgCAiYCAjIlBgEMCAEBHoMEAYJLAy4Bm3oBgSg+AiMBPwEBC4EFKYlXg?=
 =?us-ascii?q?TKDAQEBBYJMglIYQQkNgTkJCQGBBCqCcoYvhC2BQT+BOA+CWj6EJYMvgmCcB?=
 =?us-ascii?q?1ObAoJymlsFBwMfki2PAI4+hFygGwIEAgQFAg4BAQWBa4F7MxoIHRODJFAXA?=
 =?us-ascii?q?g2OHxqDV4p0VjcCBgoBAQMJfIw7AYEQAQE?=
IronPort-PHdr: =?us-ascii?q?9a23=3AT2I8TxRksV4hpP1NDle6zzgBWdpsv++ubAcI9p?=
 =?us-ascii?q?oqja5Pea2//pPkeVbS/uhpkESQBtmJ9f1JkazVvrrmVGhG5oyO4zgOc51JAh?=
 =?us-ascii?q?kCj8he3wktG9WMBkCzKvn2Jzc7E8JPWB4AnTm7PEFZFdy4awjUpXu/viAdFw?=
 =?us-ascii?q?+5NgdvIOnxXInIgJf/2+W74ZaGZQJOiXK0aq9zKxPjqwLXu6x0yYtvI6o80F?=
 =?us-ascii?q?3HuHxNLuFf2WMuOE6ejx/noMq84c1u?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.77,347,1596517200"; 
   d="scan'208";a="246413836"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 08:56:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTfY8U5GNRAnvHWCvnppP+Ek01UAkraKhDgXA7Saj4XNoNTspicfWOHAbdTtLlVUf/18/nVRNrfUdXZqnA6VWwdmB75FtfJPCyTyaeboyAHlbWI8YmC2x0MUCs2Ql8dl2DeB2kxBlgQaKW0hfCMfH5q2yg9FU3cwjZJwSlbRMlkv75JHab4jK6cg8gEgEw8GQuAVogrhPdYlewkw6Dm1J+622rQ8XO0UQw1nLWEHhvacrRD79IU1fLzxd6uXgBaG/jEZWJhM3iXQiPoRJdsnw6lSpnrUtLTavPnqJGhAyxWxkdtTjjvDVt+8JEoDx2Cd2sWFkPOw7QzYOI+ORTlqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBn+5y/ozphN0lASEh3IlrBVz14uwWOhW6jM0XAWFA8=;
 b=G5mJbAsatBAm075UKlj3J1HfecDtE3KbZZTw9+aNXJgZ/Aon3Cpd8CTVa7E78NvtKzoVvqapQklssPpC5ywmgM2zvN3jeZMq9Ua5LfHc5ObKuOL1W3upB13WBfvtBIc5nOmfqzxPVWjNFLLdwVBQeqmIFO1Qr55gGrzuZ91Dxq8/tBdAASMAq3sN0u6kPOUy3ZMB79g2j1SC9biS5Zj3Zdof2Gsua+wfe2Bxha6blXlOTy1suP2ORNiqCHPNYcAxPTjlgB1J+oWloqzy++qEMWA4zkhvJ6Ub0zQTe3QyKEu5RT7k4nMFZu4UKJS81/WM6Y89gmFx0l89vE88bHd0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBn+5y/ozphN0lASEh3IlrBVz14uwWOhW6jM0XAWFA8=;
 b=cdmOrc9fRdgVTigJ3pQPNQqoI6Sf9WJKPzkw0pNbNvzTVDhXLjyAgI9dXL8c4LLvp+381iQFrsGTQlYLRsoJ7puSTfVzu8xJH0x1JGf74pZWNv/VuvrHAX9qvqpSdkjN6P0/KzsWUORtv1A260gb0yzcKyjuCM4/IwASenNOKsU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB6120.namprd06.prod.outlook.com (2603:10b6:a03:eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Wed, 7 Oct
 2020 13:56:48 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::145b:33d4:e2d3:ad59]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::145b:33d4:e2d3:ad59%5]) with mapi id 15.20.3433.046; Wed, 7 Oct 2020
 13:56:48 +0000
Subject: Re: unsharing tcp connections from different NFS mounts
To:     "J. Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org
References: <20201006151335.GB28306@fieldses.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <df7b7b26-c6a7-9e6f-edf6-e3c858623462@math.utexas.edu>
Date:   Wed, 7 Oct 2020 08:56:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201006151335.GB28306@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: DM3PR12CA0103.namprd12.prod.outlook.com
 (2603:10b6:0:55::23) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (67.198.113.142) by DM3PR12CA0103.namprd12.prod.outlook.com (2603:10b6:0:55::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Wed, 7 Oct 2020 13:56:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c60215e0-b22e-40b5-5e4b-08d86ac8d544
X-MS-TrafficTypeDiagnostic: BYAPR06MB6120:
X-Microsoft-Antispam-PRVS: <BYAPR06MB61201CC6F2BDFEF59B5196F5830A0@BYAPR06MB6120.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcE7gGkcp+O+jleNP1CuLTUhUbbxXPMm+A74WtWAEGPsmrLqsIfPpDRL6v6sEgRHh0d9hlLJuOuo/gyA1OCFCnpNh5hUygJxAlBldA46zYC7jNUm0HSr3TrY3qydM5Z/qHhoGSMiCsiENQToDonJLpZIK5JjOdwedwE+NFYRIItxyuLLFxKqaZF49dEMSarj/C+CGJqKG3rGzysBP656yrnuWNgRTTwCStcUTER9/0vPf0ivakF9JUqZ4rcVdumdwf5e72WSSfyt80hEPwW3IipQFj83fXi7vKazXCBY6wGWPWIhAvcmxcb/kFwlP8jLySjuAl1OZ0IMqloCkQ1K7b0xutqPVM7Qu2i/DI3uBSdFcEX2pbU0ug79GiB1nNqC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(31686004)(66946007)(786003)(6486002)(956004)(2616005)(478600001)(8936002)(8676002)(316002)(26005)(4744005)(53546011)(66476007)(186003)(6666004)(2906002)(52116002)(16526019)(5660300002)(86362001)(16576012)(75432002)(31696002)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 42QBNmBWZPSOvLCbGYeSna4FCgjvY2jnFjXzS387RN67DSwYsUBVA0kWV8U8OlWu/bn+ylgCDta+160sOy90IrJgSoiZLuRinPvuO6iYiUszNxT+Sc3TdEpgORilCUcnXv2GxHE2iTr33V36qjFi/YUTk3R9YKTiJdFfn4bmM5JgGbEKR7mGepqXw1e6N9mx85e32FTeu028WfNtuFZpt2mAeld4sBQUCxv35nX0dz8hLLCWuqky5ugljdN+SfxV9dowVNgD6fhb6msCmhjfu5rrZu633b1HS7DnfW8C7cLd+b/DudWydjfCTF7THpZi3MGPhBNYbs4dsFcmSjulZvQ9ffQ5+K+kUjC5pWVI9+q4xY2MHRpzzYMvS7B+TJM9/jOoMKlrqo+YmW6ox34b/elWs6+k3nAB2P4PgKIc7Rngy4wvBYSJHrXoKRdWh9hhY5o0ojeJG8UsJ/XSbPlsoKa5A9dXmLy1r0M4UOoYDgZwue/NK/K6mUjOL/iTalMrY5X37hHh1i8Gtpl8iQjDXMt0dgMnpVYEWFAE92Qi8uOsuAzSOs/EB/UOWCHEa4baW3ugiJ7y4e7LmNnypZVTzY7AU9kExrDvbjJOMzSjHLX35+c+nrdcDW5ntMHaMIPyK3pFjx+MnFd5cO3W/9yrgA==
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c60215e0-b22e-40b5-5e4b-08d86ac8d544
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 13:56:48.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zv03U4bxqZCxkdk79oBTkcCTxQieABFIINY6e7RWqZvHEteuiXBAfpNbgB/N3KPLzjtMe3VA6BpaKkScH04xXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB6120
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/6/20 10:13 AM, J. Bruce Fields wrote:
> NFSv4.1+ differs from earlier versions in that it always performs
> trunking discovery that results in mounts to the same server sharing a
> TCP connection.
> 
> It turns out this results in performance regressions for some users;
> apparently the workload on one mount interferes with performance of
> another mount, and they were previously able to work around the problem
> by using different server IP addresses for the different mounts.
> 
> Am I overlooking some hack that would reenable the previous behavior?
> Or would people be averse to an "-o noshareconn" option?
> 
> --b.
> 


I don't see how sharing a TCP connection can result in a performance 
regression (the performance degradation of *not* sharing a TCP 
connection is why HTTP 1.x is being replaced), or how using different IP 
addresses on the same interface resolves anything.  Does anyone have an 
explanation?

