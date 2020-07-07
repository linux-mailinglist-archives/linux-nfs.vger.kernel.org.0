Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB45217076
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2020 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgGGPRX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jul 2020 11:17:23 -0400
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:33545 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbgGGPRT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jul 2020 11:17:19 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jul 2020 11:17:18 EDT
IronPort-SDR: hOfkoTFFaYQulGZgUXhCdInyro/v0YsFkZ75yWGYroAonTQvxvGZJwU1Ulje3o3iSRKZXK21lj
 D6NQ8l6ihr0TQVuXa0ZVxI53aCG2wrbSDXymu+oRQuS8xHeaWNi9cUo0XRxqb24AXvykJl8bl5
 +g6xRC/RZms5m7RPmuYAf4g1MOCQgoRnBQL85g7ZokUfIu3UBoGd+77SJW7lkxLtFIhy4jlJKr
 rohEBWSkm1TlqY2Ke36eGSYPusKzdp+31PCyf13uR9SgIPQ4pMR2UyGrjzHgil4AQGYznQ5Td6
 cu0=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 212458475
IronPort-PHdr: =?us-ascii?q?9a23=3AvXhq6xIbRnYKZ52x4NmcpTVXNCE6p7X5OBIU4Z?=
 =?us-ascii?q?M7irVIN76u5InmIFeGvqk/klDER8PY5uhChu6QtLrvCiQM4peE5XYFdpEEFx?=
 =?us-ascii?q?oIkt4fkAFoBsmZQVb6I/jnY21ffoxCWVZp8mv9PR1TH8DzNEPdr2f07jMIHB?=
 =?us-ascii?q?j7cw1vKbe9Fovblc/i0ee09tXaaBlJgzzoZ7R0IXDU5QXcv8Ubm81sMKE0nx?=
 =?us-ascii?q?7AvnsOZvhb1WpzY1+fgkXx?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E3AQCsjwRfh2w3L2hgHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgUqBUlF2gTMKhCiDRwEBhTiIFJhaglIDVQIJAQEBAQEBAQE?=
 =?us-ascii?q?BBgIfDgIEAQEChEUCNYFeJTgTAgMBAQEDAgUBAQYBAQEBAQEFBAICEAEBAQg?=
 =?us-ascii?q?NCQgphSk5DINRgQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBBQINVCs+AQEBAxIRFQgBATcBDwsYAgImAgIyJQYNCAEBHoMEAYJLAy4?=
 =?us-ascii?q?BnAIBgSg+AiMBPwEBC4EFKYhgAQF1gTKDAQEBBXqBT4JIGEEJDYE3CQkBgQQ?=
 =?us-ascii?q?qgmmKG4FBP4E4D4JaPodTgmCaOU6aCIJmiEuQcwUHAx2Cc4EajREnjViCPYU?=
 =?us-ascii?q?LqHMCBAIEBQIOAQEFgWqBeTMaCB0TgyQJRxcCDY4eDA4JFIM6hRSFYFY3AgY?=
 =?us-ascii?q?IAQEDCXyOXgGBEAEB?=
X-IPAS-Result: =?us-ascii?q?A2E3AQCsjwRfh2w3L2hgHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UqBUlF2gTMKhCiDRwEBhTiIFJhaglIDVQIJAQEBAQEBAQEBBgIfDgIEAQECh?=
 =?us-ascii?q?EUCNYFeJTgTAgMBAQEDAgUBAQYBAQEBAQEFBAICEAEBAQgNCQgphSk5DINRg?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINVCs+A?=
 =?us-ascii?q?QEBAxIRFQgBATcBDwsYAgImAgIyJQYNCAEBHoMEAYJLAy4BnAIBgSg+AiMBP?=
 =?us-ascii?q?wEBC4EFKYhgAQF1gTKDAQEBBXqBT4JIGEEJDYE3CQkBgQQqgmmKG4FBP4E4D?=
 =?us-ascii?q?4JaPodTgmCaOU6aCIJmiEuQcwUHAx2Cc4EajREnjViCPYULqHMCBAIEBQIOA?=
 =?us-ascii?q?QEFgWqBeTMaCB0TgyQJRxcCDY4eDA4JFIM6hRSFYFY3AgYIAQEDCXyOXgGBE?=
 =?us-ascii?q?AEB?=
X-IronPort-AV: E=Sophos;i="5.75,324,1589259600"; 
   d="scan'208";a="212458475"
X-Utexas-Seen-Outbound: true
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 10:10:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6cxeR8km8z9EkhhmaVioznN72dc1CFb6eOpSya8+otivLJYCLZHVRaHhyc2siosXQfgJiULo5MjXkeLQFNY3oIfin6leUhP7VyxnvT7IKo9ClaIR1MwgjLT1JaudER9Gu4iGKru8T8jXIGj8n4CtH9ERKdJqKfK0cx1EVhA0RgCwc4SP5Oqu4+sEDYSJ5ZRBmxMD9R5/hqyFFwKgUjvVtuTG+bT9oRvsms7yNTTKA4nQM8VRl7Cd7mx0R5L9UcJ0YtNrCpkubEfLorUdVb5oY6yDTqRqtP/ecrzyjcQ7aNUlGshxRDZ+evNtYfXD+mAb6nLCpbve123t4PuIb6RwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAMnZwRprtN2wJzPuHysmTjtPyrg9/z2RdwWAsAaAZE=;
 b=HLBPOZcF8V7YOmsdfAuTQ4sbu8JFS+8iOyE+Aiqc8wYc9hzeGu1nWFy/3RMAI5OlmBsjK0HvCQugaZ6Dc1AYYDC/lY4LkLjYEH9AgU0XvF7hNjhDY8htMnI4A6vf3HMY2l9dAQ1ESfowtQb26QfywD5g3qdP6GOczIX/J8YdDBgOztL6fjPjvpjnqKcpmVCOKE1W2pVthcu4ousOGs2Tlv6H20FD/BwApGOVRZ9rz+MMP938IK18NX3HORR/ILFFqLP3DS3ZdTljO9VYaF9QrJqLnvt7ajDwGGBIax1ERrzCbk1ncjBKpejG6IIGxBVEzTVAB/2VJexswtR4LFDmvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAMnZwRprtN2wJzPuHysmTjtPyrg9/z2RdwWAsAaAZE=;
 b=c230hALJl69xpPgejLUL2zM64rkx80kn6wbIkIBwoUzhBFRfAay/qdRRe2bv/rTNONsLgUgHNKhiUTQzYZ1fHXHjrTS9/FPhuIFKy9N4wNA3XlZbC8GPABBdKMVvy9niJXJoy+gtiYXTiefftkpIc51vap0ESUYnGcXE7AKMxAc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB4613.namprd06.prod.outlook.com (2603:10b6:a03:44::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Tue, 7 Jul
 2020 15:10:09 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::8570:7340:3a13:1f87]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::8570:7340:3a13:1f87%3]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 15:10:09 +0000
Subject: Re: kerberized NFSv4 client reporting operation not permitted when
 mounting with sec=sys
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org>
 <9e25861022acb796c35d3adb392bf4c4@kngnt.org>
 <c058f370-9f7c-146d-e7e6-a3f88b62cbc4@oracle.com>
 <4097833.BOCuNxM56l@polaris> <20200706171804.GA31789@fieldses.org>
 <4fe2af1f-917e-c1e4-f5e6-05eb0c121511@math.utexas.edu>
 <20200706202712.GA32161@fieldses.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <b96b9bdd-3fbd-2e54-c036-fb8813287ca2@math.utexas.edu>
Date:   Tue, 7 Jul 2020 10:10:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200706202712.GA32161@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR20CA0048.namprd20.prod.outlook.com
 (2603:10b6:3:13d::34) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (67.198.113.142) by DM5PR20CA0048.namprd20.prod.outlook.com (2603:10b6:3:13d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22 via Frontend Transport; Tue, 7 Jul 2020 15:10:09 +0000
X-Originating-IP: [67.198.113.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb205b78-5666-48e4-d388-08d82287d708
X-MS-TrafficTypeDiagnostic: BYAPR06MB4613:
X-Microsoft-Antispam-PRVS: <BYAPR06MB4613482675A5F8BE699AE18683660@BYAPR06MB4613.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55KchjkLJqgr2mENoQO2BjgMB37ZMkC712okQlecEoFPHrZX+jsGU//udUeCPNcxFxA9pnsAY7HSgg7lFPsrRqCsDcf2XaUp35f5p8q6dQrfyVFER/Q7OWXb55obhdrUeAaRbkwY9LWo0ypr2efhFdwLRYUdCHA4sxdf129IHvbbV5NkjLn52+s2Oy008MYqgD+OtbqIP03Wq/MIfu2kUUzqfv5+ybuPOrvpx+YsA1nzf1ootOLcMkY2qgr6EnpjTokjstT07xFilhoViaisDzSw+9QC9i0lKoVqAwDV3UQ2gj30xA7NYcMci/AKUq7Gt+4uZsoZTu2/jQFYeuBV5jXHSutpap4Kjns6Vx7YmdbhNGrLFvfCuOd8s6biOESM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(26005)(53546011)(86362001)(6486002)(5660300002)(31696002)(186003)(2616005)(8936002)(2906002)(956004)(16526019)(6916009)(786003)(316002)(16576012)(8676002)(66946007)(31686004)(75432002)(4744005)(4326008)(478600001)(66556008)(66476007)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dVkxgWT4i91GNXpHxgxZ3fZ2ISoFQDxRTS1KHxEW8uJf3plQVAOfyPWr1s7cK9uwD54FNgttiONtPC8iku0WymXydkxqV6Gjaq8bEOUw/vuFbUuFaBxmStR6Ccco3zMuBXMk0lWU/ILzwOzPue8nz4Y0YTNLnxyR3XbmpyjN7vNLF4N/rOhhZPbP1CwG7loUXRsG8RISik/wYwOgV8mzrLHk7XR9/KeZQfwjamc2ZNdohRWL3Yh+Pd41qEmPXHLvT9IOJ9BgPzRmH2xfXRlTPZSiEEW22TmXpK51BDLt4yh1RgiDBSMSJXOVWZUjLPeltzWlul9ML0uurCskV4kL3/wL7nff5pb+lsuM41dqJwY2tzzycKNwaK7BoollePYIdQqgLlg7K6Kh+nfLW2hLFgj2LKD7Kq0/83i1UKOYXojN98fxJOhSQf2uVDDe6TcSnxbAhOFAc+6QXIRxLOBR70RRzrSIWsyBlgr64o7RYSFrbT/ZJuipTSmIpF/M1iC7
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: eb205b78-5666-48e4-d388-08d82287d708
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 15:10:09.8073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDCKvhkXAYPZ9cCQR/+QaKFAgRiqZDMWXcwgUEBgDE1pgrmDnL3Wh4+ZV51qFKeyRqa7Bh+Y3J6oD5fDosjlgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4613
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/6/20 3:27 PM, J. Bruce Fields wrote:
> On Mon, Jul 06, 2020 at 02:57:52PM -0500, Patrick Goetz wrote:
>> On 7/6/20 12:18 PM, J. Bruce Fields wrote:
>>>
>>> Note, by the way, that fsid=0 thing was required for nfsv4 exports years
>>> ago, but no longer is.  It's usually better not to bother with that.
>>
>> Are we ever going to get some solid up-to-date NFSv4/pNFS
>> documentation?  I'm sufficiently frustrated to write it myself, but
>> am not 100% sure where to start.
> 
> I guess the places I'd start would be the man pages (original source is
> nfs-utils, git://linux-nfs.org/~steved/nfs-utils) or wiki.linux-nfs.org.
> 
> But, I don't know, you may be in a better place to position to know what
> gaps you want filled--where are you looking for documentation, and what
> are you not finding?
> 
> --b.
> 

Well, a good example is the fsid=0 thing. Where is it documented that 
this is no longer needed?  I'm 100% certain I've read through all the 
man pages I could find several times.

