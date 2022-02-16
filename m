Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1554B9142
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Feb 2022 20:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiBPTfZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Feb 2022 14:35:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiBPTfY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Feb 2022 14:35:24 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 11:35:11 PST
Received: from esa10.utexas.iphmx.com (esa10.utexas.iphmx.com [216.71.150.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDBA2AFEA6
        for <linux-nfs@vger.kernel.org>; Wed, 16 Feb 2022 11:35:11 -0800 (PST)
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 318553193
X-IPAS-Result: =?us-ascii?q?A2GTBACKUA1ih7A5L2haHQEBPAEFBQECAQkBFYFcgiaCU?=
 =?us-ascii?q?YRVjhWCVC4DnX4DGDwCCQEBAQEBAQEBAQcCEhMcBAEBAwSFAAKEAyY4EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEGAQEBAQEBBQQCAhABAQEBCw0JBQgKBw4QBSKFL?=
 =?us-ascii?q?zkNg1NNOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCg?=
 =?us-ascii?q?Qg9AQEBAQIBIwQRCAEBIxQBDwsYAgImAgIyJQYNCAEBgwCCZgMNoREBiiB6f?=
 =?us-ascii?q?zKBAYIIAQEGBASFCxhGCQ2BWwkJAYEGLAGDDYs1Q4FJRIEVJw+CRDA+gQUBg?=
 =?us-ascii?q?xYRAoMugmWVI3MsJSUIEV0CC5I9L45eYJ4Hg1GfTAYPBS6oEIMqhk2MU6Fag?=
 =?us-ascii?q?WKDDQIEAgQFAg4IgXiBfzMaCB0TgyRRGQ+OLAsCCYNPin1WOAIGCwEBAwmOW?=
 =?us-ascii?q?AGCRQEB?=
IronPort-PHdr: A9a23:NJtzkB2Ph1UDiPI+smDPpVBlVkEcU/3cMg0U788hjLRDOuSm8o/5N
 UPSrfNqkBfSXIrd5v4F7oies63pVWEap5rUtncEfc9AUhYfgpAQmAotSMeOFUz8KqvsaCo3V
 MRPXVNo5Te1K09QTcP3e12Uv2G//TcJXBjzKFkdGw==
IronPort-Data: A9a23:Fd5Esq0MXZyrS0X+VPbD5U5xkn2cJEfYwER7XKvMYLTBsI5bpzAFy
 mJJCG/QbqreZDSnL95/aI218kwHvJXVxt9nSldo3Hw8FHgiRegppTi6wuYcGwvIc6UvmWo6t
 63yUjRERSwNZie0Si2Fa9ANllEhk/HYLlbAILScYHopH1Y6EH1JZS9LwobVvKY52bBVPCvQ4
 bsek+WHULNy82cpWo68w/vrRCJH5JweihtB1rANTawjUGvlqpUgJMl3yZddjpfPatI88uaSH
 44vxVwil4/T109F5tiNyt4XfqCWK1J70MfnZnd+AsCfbhZ+SiMa34AQZNY5dRZtryjOrst/x
 NsTq9uNVlJ8VkHMsLx1vxhwNQhbZPQD1JqZZH+1vIqU0lHMdGbqz7N2FkYqMIYE++FxR2ZT6
 fgfLzNLZReG7w606OvjFq8w2YJ+c4+yY913VnJIlFk1Cd4+TpfOX7fi4NZE3HEtms1eFO2Ya
 sYEAdZqRE+ZM0ASYQ5GU/rSms/3pEfwIh9l92jLhqx05FLJkSxR+YbEZY+9ltuiHpwOxRnwS
 nj91273AxweOMe3xzuI9n63i/SJmjn0MKoWFbul5rtsjka72GMeElsVWEG9rP3/jVSxM++zM
 GQR8ysq6KQ3qkqiS4CkWwXi+SHa+BkBR9BXDus2rhmXzbbZ6BqYAW5CSSNdbNsht4k9QjlCO
 kK1c83BCBpE4JGwVSOn0qrTnCi8NSZLMyg/enpRJeca2OXLrIY2hxPJa99sFq+pk9H4cQ0cJ
 Rja/EDSYJ1D0qY2O7WHEUPv32vy/sKQJuIhzkCGBTz8tFgRiJuNPtTwsTDmAeB8wJF1p7Vrl
 FQJgIC76+EIAIrleMelHb1WRO7BCxpoIFThbbNHGpAg83Gh/iCldIUJuTVmfh42bIADZCPjZ
 1LVtUVJ/phPMXC2bKhxJYWsF8AtyqumHtPgPhw1UjasSscsHONk1HgxDaJ144wLuBVx+U3YE
 crAGftA9V5AVcxaIMOeHo/xK4MDyCEk3n/0Tpvm1Rmh2rf2TCfLFetUbAreNrhisvrsTODpH
 zB3Z5riJ/J3AL2WX8Ur2dJJRbz3BSRmWcGr85APHgJ9ClA+QDh+Wpc9Po/Ni6Q+xv8OyY8kD
 1m4W0RCz0H4i2GPIgKQcnd5Ya/uWpAXkJ7IFX1EALpc4FB6OdzHxP5HKfMfJOB7nMQ+k6IcZ
 6RbKq2oX6UXIhyaqm91RcSs/ORKKk/x7SrQZHXNXdTKV8U9L+A/0oS4JVSHGehnJnbfiPbSV
 JX6hlOBGstcHV0/ZCsUAdr2p26MUbEmsLoadyP1zhN7IS0ALKACx/TNs8IK
IronPort-HdrOrdr: A9a23:Zo+RQKx3f2ZldS5SR5j9KrPxrOskLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9wYh4dcB67Sc+9qADnhPpICO4qTMqftWjdyRGVxeRZgbcKrAeQeBEWmtQtrZ
 uINpIOc+EYbmIK8/oSgjPZLz9I+rDunsGVbKXlvg5QpGlRGt5dBmxCe2Om+yNNNW577NYCZf
 ihDp0tnUvdRZ1bVLXxOlA1G8z44/HbnpPvZhALQzYh9Qm1lDutrJr3CQKR0BsyWy5Ghe5Kyx
 mJryXJooGY992rwB7V0GHeq7xQhdva09NGQOiBkNIcJDnAghuhIK5hR7qBljYop/zH0idhrP
 D85zMbe+hj4XLYeW+45TPrxgnbyT4rr0TvzFeJ6EGT1/DRdXYfMY5slIhZehzW5w4Lp9dnyp
 9G2Gqfqt5+EQ7AtD6V3amIazha0m6P5VYym+8aiHJSFaEEbqVKkIAZ9ERJVL8dASPB7pw9Gu
 UGNrCT2B9vSyLYU5nlhBgs/DT1NU5DWytuA3Jy9fB96gIm3EyQlCAjtYgidnRpzuNLd3AL3Z
 WCDk1SrsA/ciYhV9MIOA4we7rHNoXze2O+DIuzGyWvKEhVAQOEl3bIiI9Flt1CPqZ4gKcaqd
 D8TV9IvXR3VFnpDYmjzbsjyGG5fFmA
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,374,1635224400"; 
   d="scan'208";a="318553193"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 13:34:09 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZytYQv3NARe4+GGoFrZwYbBJqkbILFZLS3RZmlg3XhcJC7m4oC8iftwIXJQZP+AKsNL5SRs7ONvH9j/l9z0b/dP+PgKDNj0+5DDnDi/LsV+I62Sc+efKg/Rk0cHD04BEKaeeoP2KBxvG8lrNy2IlwjjibuC2yhlLnfvBfLLYYqNot6pP7DWnBpvSsV7eBwybaALNULFVYwOryNufFvg3ppn42zr4MpjR43lxryUPOU7k8J4c3o20inrdWfk0gUWal+ot8DOGUN1mGFZBlyd2SdnzrBgUuID3gMc2Th2yJRkYUxZxagpU8PlJLGUfPi1GOarU4DSKmQKKVXtjvOJikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW84507kcN9abRvr7LywEAQQxal0tX3JZCAgGrV97vk=;
 b=DhpTSBNuXTFK7MkCDM6Xw4wL5uJYsrYGMWb5A8NJAlb7x5olG/OHRBDGVZhPZuWdCyKD15bs3s13r7DD7zIXN+AgF5kaR9k3pnoz9PE5GM33r1BhXE2uXX7vd6aH26ThUY5SU6VzS8VxTjXbZae8C8TKh0wrsXoFe30UpmyRlHOo94gV1ogPh9YW42eDyd7oTFAcrLCydAO3n+xpwwMVYimYq+LzU/ONl86fBvLOYcNxuLg6ORS8sUM+53Y9lBNI3hcpCguCyHALLwi9EZBBQAFHr6bLpvmUWSs9b8IVue5lellXp4WMOT7pO6HKLJZIF1VLh4amW4rSRv9wADUk6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW84507kcN9abRvr7LywEAQQxal0tX3JZCAgGrV97vk=;
 b=eDYuYFR5JsqilWNY7OnXhD/QrC5HV9Tb93VZChvf6DRRqTjyrkXIMpY0SgqIQbSAd4Onxtn1aE4Y1kphEPHxBeNIa74PBa1g5jcWYS+e3OUCZb2/zSIHdEst7OgiRHoeD7I662j2r4XRGxyoS/AtZSkTEHmIRABO3zYp9Oh55S4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by DS7PR06MB6917.namprd06.prod.outlook.com (2603:10b6:5:2cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 19:33:58 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::7949:fab0:e011:12f2]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::7949:fab0:e011:12f2%5]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 19:33:57 +0000
Message-ID: <715a5da9-a7a1-f2b6-b02b-8cc2712b001d@math.utexas.edu>
Date:   Wed, 16 Feb 2022 13:33:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: How are client requests load balanced across multiple nfsd
 processes?
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <19e14932-ed88-60a1-844a-0e17deee269d@math.utexas.edu>
 <20220216192215.GB29074@fieldses.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
In-Reply-To: <20220216192215.GB29074@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0401CA0022.namprd04.prod.outlook.com
 (2603:10b6:803:21::32) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a36d781-7ce4-4df4-7d3c-08d9f1834660
X-MS-TrafficTypeDiagnostic: DS7PR06MB6917:EE_
X-Microsoft-Antispam-PRVS: <DS7PR06MB69170B58AB5F654627BE2A5983359@DS7PR06MB6917.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76tDDQJhw6EGhjcCJ8XMqcv/H1d2Vh+2/thDgNkvUxTu8S9oY7gnp8arARbi0uMIFZr76lAqVI7uvyTAR/OaAvW1FwhUDPNYoS6GnUlA3qKrh+G/VuWmzI8r7uPavoJXWi7xmJFT13Obienn3DqMi6pB+zuY1GxCJ4XwY3+EtkHE1GyrIj/pIb+Sfc43/A8NacGLAY3AjYGyyo8qUSRck6CsZRLjjejURqc6ofY09nW2u9UBc2Ow42gciVmZws7zYu1Z3VZhzel8VDEz3LHyrUwuqfCgnPInbgqMVu8fihmzRdRMvaxj9D6K5SdkWiMJ/l4Rg/FPI+aM1IwnyjvV46iZ/uGFK1EVXaVa2aJqePny+J8T8Pl3Q9diopPTmHUm9o6vDzLDKwIAgIyfQv8rJJE2ChpAtF4MijiEUejiOjyoqBt2/wOhowYLlrCujJ3ONEeFfrKDA7g+esf30ACTwr+NnqjLLujkMHwtooqag9GrKRCkUeKRyyCLEmqqaWhe+GFgmXlgLMRrirkBBuxTVmvUYuX5BRt0vbVA3scPrvrK7ksRa977mxtZT++H7+2iWzXVFlTt7on+vPNBZGDNiBjOBbA/9RiWinVeK7m6kv08dgBxVtxQD2CQkQlNr/Nl2lhVWm3XpYnzUOr+yhxSXteskmFcddBOF7zel7Htn1dqP7toQhqe75Y04D65Sgu+JIe83kRh3OM/jZt6vtdV1AZ+b20A6H77Cg/mngxo6zxBB5fpxEXXeDBPwLqv39SSJISDVZIC1hICpwVks67UeiJcHf3bFivGFXD+RVsgiAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(31686004)(6486002)(786003)(316002)(5660300002)(53546011)(52116002)(6916009)(66476007)(508600001)(66946007)(6506007)(38100700002)(66556008)(38350700002)(6512007)(26005)(4326008)(8676002)(75432002)(8936002)(31696002)(86362001)(2906002)(2616005)(186003)(98474003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXd1OXFLZE91bXRlWWprUDhEZC9VVExRcit6SlV0QUVmK2lzd0pyb0ZuTitn?=
 =?utf-8?B?OTNuWWhUWWdUQnpWRGNxVGFaRDQxVlh1OGZmZVQzSE52M3doUWc5SXY3SHNT?=
 =?utf-8?B?bmdTZ2NOYU9SZmFONGtWMTZrMWZwWjI5RmpsMmF6ZnppN3kwQmlKSGZWeHFj?=
 =?utf-8?B?clVZUWdtUlBsVTc5ZFIwQWJCU2poalRtamRIczl4MGc5VnBGRmx6MGxQb2dI?=
 =?utf-8?B?Unh0WjQ5S09VVFFJNk1YNnpnb3BSNlV4TkdUTDdyaVJ4RjIyVHBCaVU3MHI3?=
 =?utf-8?B?RmtiZ2pjUXZYdm55Y2Nyb1JzWUs5MXFtVFRWY2h3YTgzNFhyRm5CL1hiVk9j?=
 =?utf-8?B?MUpXQTF4QTN2NnpmNWJxSFlSYVpnZTFuNWhhTGpab3EveVNibk92Z2RmbHpY?=
 =?utf-8?B?eEFLV1lkOHpNZUd1S2dTcW5uZFZFZW9EVEtpQkUzeVpST25EWXBnaDJ0RmlX?=
 =?utf-8?B?YVBpMVlINUZGbXk4RWQrT2lFTFcxeUFsZnlwb2VhQ1F3ZktYZ25mdGxnY0hZ?=
 =?utf-8?B?S1RxcWRzUWNBQTA3RnNhK1BCVHZtQmRWSCtaQ29nazl4Skk0WmpUSEdESVR6?=
 =?utf-8?B?bW9Dc1ZkNHZJcysyWU1VdWhkN2xrZy9hczl6K2tzTHNyNTluNnBuZDhFT2lo?=
 =?utf-8?B?MWZkdWMveDROWUt4M0JLVXlyT1d1OGR4Z0hnQmtqMXNUU2FOTVovQlVid004?=
 =?utf-8?B?aUM3TkxQQUNPWjZkWVcwdnFZS0g4eWFyMkJMMVl0UXcxbUJFYW5SVHRlclUw?=
 =?utf-8?B?UE51VjA2K1hIS3F2eDdER0ZBTW4wVUNkNndMVk55bnU4bG9YYTRSU2p3bUZk?=
 =?utf-8?B?L3dPNmpWQ0pTZmx1aCs1ZWZRbDQ5NlpUandNcERKSm1TaytsZitnTlEyOVlu?=
 =?utf-8?B?aXFuUUpYZVFRWW9iVnhJUSt0b3ViN0tkQytJSEJXMjlmemxOcDVtZElkNUhu?=
 =?utf-8?B?M2tRR3kxbnhiV1R0WXMzaGpYR3hmYjV4Zjk1dU1JQm41RmxuRnZPSXBMZGpI?=
 =?utf-8?B?dm9MUXVUVHdxTy84Y1RkWGdRYjIwTXI5TkdKUHBxVTdPQW9iemJUbHZLR1Za?=
 =?utf-8?B?NnJxZHZnZlE3S3NsZkcrV0FpM0NQRERxUjNKNlJ1THpkT2lkazFFdUlVNnJN?=
 =?utf-8?B?ZEpZUGVJV3NUWUx1b1NIMmZtMGdkMmhjOVFHN1BNYVFmRWxmbThncVRPWHJU?=
 =?utf-8?B?Z05hK0tKanp2ZU5GNWdrYTY4V0tpajNIdXRUVEJZdFpNWjVIcWhPTjJ3M1hR?=
 =?utf-8?B?OWR4SEV4MkVBc1FoaTM0eHhzcXI2R04zQU8raWxzcUhaM0tGemJ4MUt0VW5Y?=
 =?utf-8?B?OTN0S3dPQ3k4OUVjYnQxd0I1VHhmeUV3K1Bsc00zaTIybHRiSE5tOU9aR0M4?=
 =?utf-8?B?bU5zUC9rZHBMVERYZW9oKzhzUWNXTXZ0eWNENllCY25nK3ZsM0pqYzdWN1Zx?=
 =?utf-8?B?aUV4Y3pCTXcwYUFodUovYWJUakgxN3lTazQzRkx6L0J4VmN4TForN0d0TWw2?=
 =?utf-8?B?dG9DSDlxcW91MFJDUURtWmdDV0tiRGlNTXJmamxuQTg2ajBzQkhvTXpLcEIw?=
 =?utf-8?B?SE5PSGFvMGhJeWZSc1V4V2F3empjNW01NEF6T0pKZXM5SlJJN3NML0VRWjd1?=
 =?utf-8?B?YVhmVGsyalNKN0dXcng3OWlqZUxLWjVQY3dNL3FPS2ZFbENac3lIWFNGU0Rt?=
 =?utf-8?B?M3VkKzFkNEZ1aXNPNFNBN1Q0K2ZxeUdBeUZXdDNSZmdFN2xmV0F2RDF0cnRL?=
 =?utf-8?B?TFhZanFxUkZFLzZsakxRRTY4L3ZRV29KTGR3R0gzVnJWclpRNHRNNU5ReStm?=
 =?utf-8?B?Rkk0eWh1bk5RMUNiaHZXZzlWVlRmelZRVXQ0alBEYXR0WHdRdEFxU2prTmYr?=
 =?utf-8?B?QlZYQm5oY3g4blpHYUJpWXR1djIweW1za3lmRnVobmxsUnZBclV4QkcrOWUw?=
 =?utf-8?B?Um0rS3doVlZSRU1OQzJWTiswRFRmT2RtZDdOTDBseWQ0TnNyMUdlUC9oU3Z0?=
 =?utf-8?B?Z3NNSVU4UkdsekEwaUZKc2ZCeHNzR3pibXpPc1VLazgvWEJHV3VUSzZ1OFVh?=
 =?utf-8?B?U0xOUGpUQVhEbnlIbDN6MEp5OXd2U1hpWWI2UFVqdk42STR1aWNNUFJxenh6?=
 =?utf-8?B?V1hkRHVSL2g5RThPMS9mb21sc2Z4eWVnd0I4KzJhVyt4UGk1TlNjcHFuZWp2?=
 =?utf-8?Q?QhFtcB7WUEyD1uTz833fVWQ=3D?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a36d781-7ce4-4df4-7d3c-08d9f1834660
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 19:33:57.5092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/4w+7eKcHX2IDCHFoIN6d4iJiTto6Ms7uUG1fDRgtLKXOp8t1UUbaFWy4qzNxl90X53AMxJTVEo32oPT7rlTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR06MB6917
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, Bruce.  As always your responses are super informative.  Just 
one follow up question based strictly on curiosity:

On 2/16/22 13:22, J. Bruce Fields wrote:
> On Tue, Feb 15, 2022 at 04:13:25PM -0600, Patrick Goetz wrote:
>> When I set
>>
>>    RPCNFSDCOUNT=16
>>
>> what I thought this did was spin up an nfsd thread master with 15
>> threads and the thread master would pass out client requests to the
>> threads, but looking at /proc/$PID/status -> TGID clearly indicates
>> these are all entirely separate processes. (I wasn't sure if ps
>> showed threads as separate processes; apparently it doesn't.)
> 
> They're all kernel tasks, which makes the distinction between "thread"
> and "process" a little vague.
> 
>> So the question is how do different client requests get farmed out
>> to different nfsd daemons for service? Who's actually listening on
>> port 2049?
> 
> There's no user process that calls "listen"; knfsd's normal rpc handling
> is all in-kernel.  Incoming rpc's may be handed to any of those 16 tasks
> for processing.  A single task just runs a loop where it receives an
> rpc, handles it, and sends a response back.
> 

How does knfsd decide what user space nfsd process to hand a task off 
to? Is it random, round robin, or something more sophisticated?  Or does 
it even matter if nfsd is only handling one request at a time anyway?


>> This was all prompted by some vendor trying to sell me an EC
>> (Erasure Coding) n+m system who commented "NFS isn't multi-threaded,
>> NFS can only communicate with one server, for a shared/mounted
>> filesystem, so it will always be limited to the speed of that NFS
>> Server. POSIX/Multi-threaded means the filesystem is parallel and
>> can be reading/writing to multiple nodes at once in a storage
>> cluster/setup. The opposite of NFS."
> 
> That explanation is a little muddled.  NFS clients and servers both
> typically have lots of parallelism.  Whether it's sufficient for your
> purposes depends on exactly what you need.
> 
> But, yes, they're mostly correct to say that, in the absence of pNFS,
> "NFS can only communicate with one server, for a shared/mounted
> filesystem, so it will always be limited to the speed of that NFS
> Server".
> 
>> I think pNFS addresses this, but then how does one implement pNFS?
> 
> So, right, pNFS can let you perform IO to multiple servers
> simultaneously, if that's what you need.
> 
> The Linux NFS client has support for pNFS, but the kernel server
> doesn't, so you'd need to look elsewhere for a pNFS server.
> 
> Whether any of this is useful to you depends on exactly what problem
> you're trying to solve.
> 
> --b.
