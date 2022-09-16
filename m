Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C327C5BA3EB
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Sep 2022 03:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiIPBS3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Sep 2022 21:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiIPBRu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Sep 2022 21:17:50 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2245.outbound.protection.outlook.com [52.100.164.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F0876BB;
        Thu, 15 Sep 2022 18:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhyLOY+N/a0hl5iqFUhc+Ouqf1B2ohoULHIHKKaG9WwDaV6o5ulQUl+18rUpEvCM1Gpeb4b9tAK3UtfuDVdDnkahC/Swbwj4j4jlYEk7fFCW1zaB2Y1pkcDIHsBSp5unPes18XFe+H5DtPDl/mbKLq/6wb0gMvr5Y41LXwV86CJLbdDMy6IV2kyDurK/WdKaZAvmwMVkITGqqgzJM5VkBvBTh1XKHAHAHC6b8Bmlis6E+4vcqP8oXSlwFDQ4svQLidKiKhXYz2O6z659PJkQWOLk78ypyYTDIDvNqa6+zRtYBtbVXGgVgt7cNl1uWXpxwmByJBE1MWTSXIIiWWcUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs10Md+15nMnyayKLyd22Uv+/ZH79IcFcpzuzGLq1Fg=;
 b=fLdaE+A2GAzG3Nl4NeUw3cj0Y9kfK7Y0J6mx0yEReLLby2KkhycHSzFuQX3U0WG5JlFTpU09hC/UYTSdnse1sQtR2gp91ykj23Xae3OVbs43frizA1UAMFyNFUEEZ8ZN6+GKXmsQO0oQJCW4DKUkKY6OdQlHFq+BkoNvFZ9BRzHjFZPXU6g81wqF1yMzoM62fb++iCF94yOKt98pVdgb/+KHOctEl/Re7GB8yG2xciHmtqKys8dKACU2MH+j7U7CJGM9n3SzphxC8dSZjCz9jFngvhuegqq/UYeYToe+MV8jg7/O21P+D5rRnCqjl5J3WU4SEQdzb0+4SQLkRRrlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 45.14.71.5) smtp.rcpttodomain=vger.kernel.orgq smtp.mailfrom=t4.cims.jp;
 dmarc=bestguesspass action=none header.from=t4.cims.jp; dkim=none (message
 not signed); arc=none (0)
Received: from TY1PR01CA0184.jpnprd01.prod.outlook.com (2603:1096:403::14) by
 HKAPR04MB4033.apcprd04.prod.outlook.com (2603:1096:203:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.19; Fri, 16 Sep 2022 01:17:42 +0000
Received: from TYZAPC01FT021.eop-APC01.prod.protection.outlook.com
 (2603:1096:403:0:cafe::94) by TY1PR01CA0184.outlook.office365.com
 (2603:1096:403::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Fri, 16 Sep 2022 01:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 45.14.71.5)
 smtp.mailfrom=t4.cims.jp; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=t4.cims.jp;
Received-SPF: Pass (protection.outlook.com: domain of t4.cims.jp designates
 45.14.71.5 as permitted sender) receiver=protection.outlook.com;
 client-ip=45.14.71.5; helo=User; pr=M
Received: from mail.prasarana.com.my (58.26.8.158) by
 TYZAPC01FT021.mail.protection.outlook.com (10.118.152.130) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 01:17:42 +0000
Received: from MRL-EXH-02.prasarana.com.my (10.128.66.101) by
 MRL-EXH-01.prasarana.com.my (10.128.66.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 16 Sep 2022 09:17:01 +0800
Received: from User (45.14.71.5) by MRL-EXH-02.prasarana.com.my
 (10.128.66.101) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 16 Sep 2022 09:16:30 +0800
Reply-To: <rhashimi202222@kakao.com>
From:   Consultant Swift Capital Loans Ltd <info@t4.cims.jp>
Subject: I hope you are doing well, and business is great!
Date:   Fri, 16 Sep 2022 09:17:12 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1251"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <9503e0ab-4510-47d5-bcde-9fb0a78227ed@MRL-EXH-02.prasarana.com.my>
To:     Undisclosed recipients:;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[45.14.71.5];domain=User
X-MS-Exchange-ExternalOriginalInternetSender: ip=[45.14.71.5];domain=User
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT021:EE_|HKAPR04MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 629bded5-1128-4957-f6d7-08da978140f0
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?windows-1251?Q?vcG2ZJ3c7cHHwBxLwaIoH+mS9wdGk/tReUPMbRPGf2GVJPKHxy8K1iXb?=
 =?windows-1251?Q?IQffiUP8k7IEcJri6j24FoR2oNikZBD2Wa9pWUeWpplUI/NxrmmJAKe/?=
 =?windows-1251?Q?tH6ZgM9B+qFV3OdoY+9FjexkZcQo2kAzsAkgCocGGCRM/5J83ubRrnQz?=
 =?windows-1251?Q?gOIDRDrLttf8vfg4Bjy/NeVd7ADvsVsYZ5ZT5mIQdoYV2AP4+AR7s9ch?=
 =?windows-1251?Q?DniXh47s/wErYVvCFvrxxh7HE6BSL1HTpjSAq35OBanAgfOh3TZealw1?=
 =?windows-1251?Q?GNkIx9yrqssEpWzLbBQDge+ftyRckG3cMrzph+fypJnv69sElpAwK3K5?=
 =?windows-1251?Q?6AeaN48XK4rV2uaWEdYJT0Ww8Lrf6imjqaTaaUkF8A7zjm9tV3UUqrbL?=
 =?windows-1251?Q?x63qAk5poPHlrvbJhNSEE2EWBsfovoWM8Rl3gBn3+yo5o1aT//XD2cWu?=
 =?windows-1251?Q?onVveE4NtKKtJDqb7LkzITyf8B9PW7iOUPUh/ooOeL4biG5WNHkK9dN1?=
 =?windows-1251?Q?S/ifuTKuXcJZfpExvP/yRHA6bD2vpWYMDXdoYzjjCAPuYiZNCQeTtIoi?=
 =?windows-1251?Q?pQSv5am/6fSAyTvVn48LHSFsfbuwcvZSQf1QjH7jsMozM2FVOiGf+M3W?=
 =?windows-1251?Q?tJIRDhmpAScZQSsMNdwjb3dbHE0W6gN6kI+ijQZr0ldSEZPNE4eJDQQ2?=
 =?windows-1251?Q?OFBRgBLmjGdDw3vZnWP5pQkiyGiWAJPR5Wt9jxmqoqgIJkItGsh1h0PQ?=
 =?windows-1251?Q?pHLfe6qUKqD2Y0e5+ydbWytS1ZRTu5UQHcBMpHQ8r98ZjLGNgkBWIKFJ?=
 =?windows-1251?Q?XnyN7Z9Uos5gmARBc23bW8hVP4i7TtKE9xpJfGmaEFt53iZrO5jxDLcb?=
 =?windows-1251?Q?7tqKq1tY5BbE5OiksSqpNgx1XpyAP1UrJFemIWmgXPkbsyBw93IHtLNQ?=
 =?windows-1251?Q?HU0o9drnK33Vjv7WJT24hwu8P+aQuhzgXFcIAdQewip05I8ixdtrLDgi?=
 =?windows-1251?Q?2UJv9NuchlqKW7g9u7bsk41TB/3noQ0v4aFOx4tX1fV4ucse/xxqTcvs?=
 =?windows-1251?Q?algx4oLtHkJg59+Y+9xcJpQg2eMQ3iqpDBv8qX9L6LKBBIHuBX43VMNA?=
 =?windows-1251?Q?/vD7IYfomzMXCemBsTUlinUydK6IHTRUyIyiK9FeS6oWUbYzOqsqLwf7?=
 =?windows-1251?Q?+rUcu9MS7xc4tVpHkNQsCI+SVLg7fCR4Q2vL+pDeUr7y9NqCnjJTm2mJ?=
 =?windows-1251?Q?AfaXVXcHhmhciN49a2FzDPTz+5jwCOxLUdlRte/8Ig+onKI7C37Vfdpx?=
 =?windows-1251?Q?I8xALmlS5AE0ZHBl7wnjx9cL+byAK2XcWAecWsTpNHHw4LRv?=
X-Forefront-Antispam-Report: CIP:58.26.8.158;CTRY:JP;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:User;PTR:45.14.71.5.static.xtom.com;CAT:OSPM;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(40470700004)(46966006)(498600001)(109986005)(40480700001)(41300700001)(316002)(8676002)(6666004)(47076005)(40460700003)(7406005)(9686003)(81166007)(70206006)(2906002)(36906005)(82310400005)(7416002)(70586007)(4744005)(8936002)(86362001)(31696002)(5660300002)(26005)(82740400003)(32850700003)(336012)(31686004)(956004)(35950700001)(156005)(66899012)(2700400008);DIR:OUT;SFP:1501;
X-OriginatorOrg: myprasarana.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 01:17:42.0737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 629bded5-1128-4957-f6d7-08da978140f0
X-MS-Exchange-CrossTenant-Id: 3cbb2ff2-27fb-4993-aecf-bf16995e64c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3cbb2ff2-27fb-4993-aecf-bf16995e64c0;Ip=[58.26.8.158];Helo=[mail.prasarana.com.my]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT021.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAPR04MB4033
X-Spam-Status: Yes, score=6.2 required=5.0 tests=AXB_XMAILER_MIMEOLE_OL_024C2,
        AXB_X_FF_SEZ_S,BAYES_50,FORGED_MUA_OUTLOOK,FSL_CTYPE_WIN1251,
        FSL_NEW_HELO_USER,HEADER_FROM_DIFFERENT_DOMAINS,NSL_RCVD_FROM_USER,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5012]
        *  0.0 NSL_RCVD_FROM_USER Received from User
        *  0.0 FSL_CTYPE_WIN1251 Content-Type only seen in 419 spam
        *  3.2 AXB_X_FF_SEZ_S Forefront sez this is spam
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [52.100.164.245 listed in list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [52.100.164.245 listed in wl.mailspike.net]
        *  0.0 AXB_XMAILER_MIMEOLE_OL_024C2 Yet another X header trait
        *  0.0 FSL_NEW_HELO_USER Spam's using Helo and User
        *  1.9 FORGED_MUA_OUTLOOK Forged mail pretending to be from MS Outlook
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

I hope you are doing well, and business is great!
However, if you need working capital to further grow and expand your business, we may be a perfect fit for you. I am Ms. Kaori Ichikawa Swift Capital Loans Ltd Consultant, Our loans are NOT based on your personal credit, and NO collateral is required.

We are a Direct Lender who can approve your loan today, and fund as Early as Tomorrow.

Once your reply I will send you the official website to complete your application

Waiting for your reply.

Regards
Ms. Kaori Ichikawa
Consultant Swift Capital Loans Ltd
