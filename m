Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA7F35E226
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 17:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhDMPAZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 11:00:25 -0400
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:34763 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhDMPAZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Apr 2021 11:00:25 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Apr 2021 11:00:25 EDT
IronPort-SDR: wcE4LPr8MzvTZAJIyXOI8Dr3qkEi/5+fzKShSJW/gCK9b/0Aupo/Tvi7L4BKoNugAT/GOA1qlK
 xyDqSNZsvX6PjfGjszog+0k0tmmvbC0MQHd/g89VvnzuuZJUSkd+JBtxtIix+WZm6IZxXMnX7F
 KgffchBzj+BSZgRVS1A7ynTW34f1bUcx57k/6OTz7XmEXUYs1I1ppolGzPF6pftDJadku4x176
 KQ6gwpYuEXxXnPqtPFytXsDukGO7ljUB5w4p0YNnSWTgTXkotIVXF+MK94+6mVk/zN6w61wSJw
 oTQ=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 270523622
X-IPAS-Result: =?us-ascii?q?A2EiBgA2r3Vgh6s5L2hSCA4OAQEBAQEBBwEBEgEBBAQBA?=
 =?us-ascii?q?UCBUoFTUYI/C4Q4g0kBAYU5iDYtA5k8glMDGDwCCQEBAQEBAQEBAQcCMgIEA?=
 =?us-ascii?q?QEDBIEPAYM5AjWBPyY4EwIDAQEBAwIDAQEBAQEGAQEBAQEBBQQCAhABAQEBb?=
 =?us-ascii?q?IUXOQ2DVU07AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBB?=
 =?us-ascii?q?QKBCD4BAQEDEhEPAQUIAQE4DwsYAgImAgIyJQcMBgIBAR6CT4JWAy8BniMBg?=
 =?us-ascii?q?Sg+AiMBQAEBC4EIigWBMoEBggQBAQaCTIJMGEIJDYE7CQkBgQUqgneGZoN1Q?=
 =?us-ascii?q?4FJQoE6D4JsPoQbDwKDLYJggkyBDn+BFUIcnlacLIMVnHcFBwQflC+QSZUVo?=
 =?us-ascii?q?zACBAIEBQIOAQEGgWuBfTMaCB0TgyRQFwIOjh8MDQmDTooYX1U4AgYBCQEBA?=
 =?us-ascii?q?wl8iU6BNQGBDgEB?=
IronPort-PHdr: A9a23:vOSr9hOJ0xR0aSKr4Zwl6nfDWUAX047cNxMJ6pchl7NFe7ii+JKnJ
 kHE+PFxlzfhQ4rW8bRHhvDQvqSmXnYPst6Ns3EHJZpLURJNycAbhBcpD8PND0rnZOXrYCo3E
 IUnNhdl8ni3PFITFJP4YFvf8WO94CRUGRjlMwdxYOPvFd2ag8G+zevn/ZrVbk1Bjya8ZrUnK
 hKwoGCz/skbiIdvMOA/0BzM935BZ+QQ2H9lNVuI2Rvw+5TYwQ==
IronPort-HdrOrdr: A9a23:KFMpJaFLE+1NbRXNpLqFUJTXdLJzesId70hD6mlYcjYQWtCEls
 yogfQQ3QL1jjFUY307hdWcIsC7LE/03aVepa0cJ62rUgWjgmunK4l+8ZDvqgeLJwTXzcQY76
 tpdsFFY+HYJVJxgd/mpCyxFNg9yNeKmZrY/dv25XFrUA1sduVE5wB2Fg6UHiRNNXJ7LLA+E4
 eR4dcCmiq4dR0sH46GL1Qmf8yGnd3Ek5r6fQULbiRK1CCihS6lgYSKdySw8QwZV1p0oIsK0W
 +AqADh47XmjvfT8G6k60b2z7B73OTs0cFCAsvksLlZFhzJhhyzbIpsH52u1QpFx92H01ohnN
 nSrxpIBa0ahB3sV1q4rhf31w7r3CxG0Q6F9XajnXDhrcblLQhKaPZpuINDfhPVr2omsd1suZ
 g7ul6xiptNARvM2Bn6/tjDPisa9HacnHxKq44upk0adbFbRK5arIQZ8k8QOowHBjjG5IcuF/
 QrJN3A5d5NGGnqIEzxjy1K+piBT34zFhCJTgwpocqOyQVbm3h/0g8x2NEfpHEd75gwIqM0qd
 jsA+BNrvVjX8UWZaVyCKMqWs2sEFHARhrKLSa0LUn4EroEf1bAsYT+7rlwxOzCQu1I8LIC3L
 D6FH9Iv287fEzjTeeU2odQzxzLSGKhGTv3zMVT4IV4p638SLLnPTbrciFsr+KQ59EkRuHLUf
 e6P5xbR9X5K3H1JIpP1wriH5leQENuEvE9i5IeYRajs8jLIorluqjwa/DIPofgFj4iRyf6Cn
 sHVz7jOdVY4imQKzrFqSmUf0moVl30/Jp2HqSf1fMU0pIxOopFtRVQj0+46MGNIThLqbc3Y0
 N6PbPinsqA1CmL1FeNy18sFgtWD05T7rmleWhNvxU2P0T9dqtGp8+SYnlI3HyMJgZ2SsTfFA
 I3nSUyxYuHa7irgQwyAdOuNWyXy0YJrHWRVpEGh+mo/sH+YK41CZ4gRY18HQjGDAZOhA5vsW
 tPATV0AXP3J3fLs+GFhIZRLPzDf9N86T3bW/J8mDb6jwGggu0BAlEcRCWjVMaLhx1GfUsoun
 RBt4kFgLSBnj6zL3AYm+pQCiwBVE2eHK9GAAOZZI9dh7Dsf0VqQX2XgCGB4itDBlbC5gEcgH
 fsIjaTfuyOCl1BumpA2qKv619scH6BFngAI0xSoMl4FW7cvGx03vLObq2v03GJYl9q+JBrDB
 jVJT8TKBhp3da5yVqcnyuDD2wvwtErMvbGBLouN7HV1XXFEvz/qYgWW/tV9o1iLtbgr6sCVv
 +eYRacKHfgEPwysjbl1UoNKW1xsj0pgPno0Brq4Cyx22M+G+PbJBBjS6sAK9+R4mD4T5+zod
 1EpMNwufH1PnT6a9aAx62SdTJFJx/JqWO9Tu0jq/lvzNYPnao2G4OeXSrD1XlB0hl7Mdz9k1
 kGRr9npL/GIY1icqUpCmlk10tskM7KKkQlsgb7WLBjOV4simLWJNOP7f7Dr6E1DkiIuQv3Ph
 2e/kRmjob4djrG0aRfDaQ6ZXlSYgw77n9p+euZbY3eCAmwbYh4jS+HG274dKUYUbSPHLUbsw
 1z7N6JlfKGbiaQ4nGvgRJrZqZVt3u9Scy8AAiQCfdF/tyzN1OLmLar6qeI/UfKYCr+bV8Zi4
 1DfVERacoGiiBKtvxJ7gGiDrDrrlMsiR9Q+jdi0lL93OGdkRXmIX0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,219,1613455200"; 
   d="scan'208";a="270523622"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 09:52:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3cb5lL+6+yOpqpZyoksJrEs7aPCONpeufEB/Ukck7eUcFuis1x1lB2sm6yBk7wd5WpqVndbMcPTrxw7Bf0u/4IAlGy5qpxrWUHS1y4iAMFSh4h8ATlsIdomSdtVP28KmKuNVGFdQwM9cYw8MMVdWe+L+fPtq6eGRgXQUanPNl+Tjqu1EuBa/7d+vLSK+QzZT0L72DUp/zagM8SlnM3ziU+4rIxojn0NnZal3kPJXIqjNzzxbENF7jpR1GagTFvJOc+gbewt3fH4bhdOV/V75AFZRh2nWz/DP7/a7MfgHJ1af39zfH2cBSfDYFLhw3fJaogzrH3kl9CyHz4WSS9Hng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEEYGwRaSdZ8xig0dIkiGccyzxbg0yuxLukF08okJzU=;
 b=klviB4YDahpkjmN2mA0fOHF2twya/TySkITPC5fjuHmuVvu+GFBVQoDkR8ZduAN2J56ey8hz/kpJxtKSn+/YdHGzllQr5t5BdoIODvbylAvGCwYkf09uUmvJkF7X/GTJLNC+a27FwNr5KEkTj7VzsK4uivZ6r7056w/IUtc7Lg8p9DeQNP9IM0y+akdYRPjcdFPJKkLvZappYauPiFnXsq1RLx52Ybs9u1D7Ec1JLhfR0IySV5IsRawTRD6iJZwdGXUhoxlol4l+SzpacMkNqbx3XQNfdhpUcKKIEKL/R9yWidTow5lRtrJ6W4N+HEgHOVzgvcpoWGJClhPMBkHZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEEYGwRaSdZ8xig0dIkiGccyzxbg0yuxLukF08okJzU=;
 b=M+xvm5nfoVNztp56st78+oBt3JDV762IFGqSV7tGtO+u+O1EYYl/fWMPR6jF0soeymsZzpDWrBVZUGTF51pLjbvl0fap4vqLpbE7E/Pa52WKZI7XgUHGQE9WW3LQsFiIPSMq3W0awtpHolUO+DbgHySOSa5tykuiVYvvQh9PU3M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB4919.namprd06.prod.outlook.com (2603:10b6:a03:76::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 14:52:54 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::e871:d81d:56e1:5017]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::e871:d81d:56e1:5017%3]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 14:52:54 +0000
Subject: Re: safe versions of NFS
To:     hedrick@rutgers.edu, linux-nfs@vger.kernel.org
References: <D8F59140-83D4-49F8-A858-D163910F0CA1@rutgers.edu>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <e6501675-7cb4-6f5b-78f7-abb1be332a34@math.utexas.edu>
Date:   Tue, 13 Apr 2021 09:52:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <D8F59140-83D4-49F8-A858-D163910F0CA1@rutgers.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: SN6PR04CA0079.namprd04.prod.outlook.com
 (2603:10b6:805:f2::20) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.7] (67.198.113.142) by SN6PR04CA0079.namprd04.prod.outlook.com (2603:10b6:805:f2::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 13 Apr 2021 14:52:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78656130-9f09-42e3-c9c5-08d8fe8bd1a7
X-MS-TrafficTypeDiagnostic: BYAPR06MB4919:
X-Microsoft-Antispam-PRVS: <BYAPR06MB49193DE9F66436C7DEE63127834F9@BYAPR06MB4919.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09dmfJWx6Jk+2jajmJE+bzG2Cabkcvbu9HwFtI5R3hYIlDc0rFR3MlQyYNqT565ocrQY0HUEx4TKhzIhTQbaA46PmoojZCBuYNl4NsnF4/454sFwndWGOLKKrVgTk/E/TEc7WEnpPyy92xVH1PXmrHSE9iq99p6+G9xISF2U5t2UJnfERMeUZzxNHZeSHOGnwred8YG5HrLiS/5pg6/7IeFS0HIdyLjfc002buImsG1llg+6/UBX7eYn5ykyhfzCNfzux9DuXBMCM8qQwJL0NoOOkJ8OTUzJXaZdrhxDnMwgF+Ox2OhUstfw6+II4oZ951gAnm9WmS5pFuPLa/HHHzzS//9aLSDLjjJiLQ3WsLYFlZMWqXh3K9SwmKcjg1R8RPq9cLPnL+wA0uTjGm1aFL3XDLQRwp5+bhIRXNd1w3GGRbiGQbfsupgp0YMxG2Gv62yqt3ijOv6v+r1HwwJZpWDXZoblDMT45XVEFdmt9EsztURnh/TGcTFAg1udh/QCH+u61jThr78Y9j8/qIzBig5utchnlOxjZ+1fQ81vlB/aQ5qZJ74yE8VCVFc+HjuGZPsgIEXIGOYC9c9d6B9WaEFKxvitLSBNUwqS8HI9zRUePnH5NXtieH7FQ05o0xI+a8ppaPfjExDdc8X5JFQC+MW5C8MrWBo0pdLmi/oHRFK3qFjxXgiay61mjzN07Ckd9VGeiodyGT7zG1ugBTF9PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(6486002)(38100700002)(66476007)(66556008)(38350700002)(16576012)(3480700007)(316002)(83380400001)(66946007)(86362001)(52116002)(31696002)(75432002)(16526019)(478600001)(8676002)(786003)(2616005)(26005)(956004)(31686004)(8936002)(2906002)(186003)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QlJlQ3ZYWXlLS2JGWFoyTE1adExaNFdBM0duZFhEOVk2VHl2bVNWTnlEZmVG?=
 =?utf-8?B?KzZiZlVseXhWZmxQdUljSVcxRlNDU0ljMEFxaktsNU9TQ1dLUnlHNUE0Qzda?=
 =?utf-8?B?TGZ6Q1dJVnFDNUM1SkVmd1l6YlZMUzVOcVlqUjlGbVhLVDIyUGYxVmh4SFl3?=
 =?utf-8?B?SFkzRjNTUkowTjllQlhScnNNRDdJbjdmTGVqT3lPM0hIYVNYMEhhUElOQ25X?=
 =?utf-8?B?NG5BNFQxeEdtaGR5cDdMZ0pxV2s5V3RsOTFQbUY2QThwdWZhYjhuODFHbjFM?=
 =?utf-8?B?V0pPeERoRS9zcGF2RnFScTFRVnJPSE9mczcwL2xWNFBWVHczS0F2cHpReGUw?=
 =?utf-8?B?UFZrb1c4bHpYc0R2TXVCSXpVRWZBRUtvZk5TbWFldWNXaU8yZTFYdlYzWmt3?=
 =?utf-8?B?ZWpGYXlOWjRDT3VBWHBwaGZqbXRseStlNlJJY0p4Y25OTGdSNUExWGovYnU0?=
 =?utf-8?B?R0hXZFpacW9jY1AxZ2lnUzVybG5jWit5QXp1Z0N3ZGU2eXFhL1NNRjNKR2xW?=
 =?utf-8?B?YlJPOGdVRmFOSlF6NVJ4dUtUMlNCSkJYSlEzTkZZTGRERnN6LzNJUWx6VGlk?=
 =?utf-8?B?ZGhadlplYXZidHArbkdGUzNFUHh0YlNIK0t5MkRhUHNRK1RVa29VVStPRTB6?=
 =?utf-8?B?cGNHSWc3aHZmQ0dQeTF4RXRUS1dySjhpL1N3c1lSL053WGtTU2E5MndIYXNa?=
 =?utf-8?B?WmVFVEhKcy9FQ2FhZlVpRXBwWUU2YzBZclg0QWtsaUZReVZIK3EyUTZadTQz?=
 =?utf-8?B?Q0syRCtQeXZnVkpMakxuRG1rYmVHaTdtcjRkVDZneW9PWkxoTWxENjZLRzdN?=
 =?utf-8?B?TVJMUDRTTVlINHRhSUNXalF3YWtISnJCM2N0c0M2TEhOV1VGblE0dEcxQURo?=
 =?utf-8?B?c1dPRk55T2Qxek9iUXJISERzYithbXkyWkcxZDBxVXh1MXlCWCtDQ0dUZmh3?=
 =?utf-8?B?M3N2cHNjNEdOMURuckZBNVJicGVucFU5QllkaEF1MHFLUUk0NmZ1Y0NpNU5Z?=
 =?utf-8?B?TnNvUUdrYzRzdHk0Yzg5VHRoenIxcGlTVE11Y00yOXU1Y0h3ZzQxekJwYWN5?=
 =?utf-8?B?YlkyVktjdlZzVlZlNWdYNWx5b1RvVlN6SnBiWWdLU2llRFZtWXJySXZNYkJ6?=
 =?utf-8?B?dWM5OEhlNjl5UlphVmN0OVI1bDMvQ2hrZTNGemV1eWdLYzBweENCUHNBVEJh?=
 =?utf-8?B?Z3ZoaENJWGMwL0xFaFQvcllnejRmMy9uQS9Kb0dvTEdvOFBXa200QnI4Z24x?=
 =?utf-8?B?bHdzRUd2SGk2cTFWVkllM1cvbWxQZTArY3RhdTFNT1hwTlpoemlGZTkzdnMz?=
 =?utf-8?B?ejBWbkF1cVpKWFNUS1RHaXg5OXBRbnNMOEUxZXBUeTdFVmdsK0Jrc01wbERC?=
 =?utf-8?B?ZzhBa3FWQ3lhS2pPeXJ1SCtxTU5nUDF5SWZXM2lRWGU3K0ZPbFJmczd6Mldo?=
 =?utf-8?B?c0RSRDlFK1dZWFR3anVRemxKSE5Na1hYWlpkUWY2aXorRExBSDl5ekxyN0Zk?=
 =?utf-8?B?Q1pWb0xCbWV0ZnpvVWh0Wmc2M3k3UWpHSnFYSE5YRmtnWGYveUNLeE9zUFRI?=
 =?utf-8?B?STFNSnZySUFjdEhuM3k0K25lRU1ZUkwxUnQxdVU3ZHFZL3FNTkFiWEJPQ0Vw?=
 =?utf-8?B?dEN2amYydmxINXluZHJldy9WZ2V6dGt5ODFiQ09KUFdXV3NMVmpaaDVKcVNp?=
 =?utf-8?B?VzRhemhFRXdXODFJRHlNZDFWQnpCYkorSkxIWTdiVmJwN2ZLVUxoanhHU0hJ?=
 =?utf-8?Q?ZXK1cAGxeQEcEOVbLi7Rrko3dyI5nHIWPkIAYgA?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 78656130-9f09-42e3-c9c5-08d8fe8bd1a7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 14:52:54.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+yqBnjCU5ROtcAAfwi5BgXHAvEXmTadF7h+E3Bz/H7ESX9+jtkAZnBcfID7nuJffxwqTzMCaDRtNswwe3WrAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4919
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I use NFS 4.2 with Ubuntu 18/20 workstations and Ubuntu 18/20 servers 
and haven't had any problems.

Check your configuration files; the last time I experienced something 
like this it's because I inadvertently used the same fsid on two 
different exports. Also recommend exporting top level directories only. 
  Bind mount everything you want to export into /srv/nfs and only export 
those directories. According to Bruce F. this doesn't buy you any 
security (I still don't understand why), but it makes for a cleaner 
system configuration.

On 4/13/21 9:33 AM, hedrick@rutgers.edu wrote:
> I am in charge of a large computer science dept computing infrastructure. We have a variety of student and develo9pment users. If there are problems we’ll see them.
> 
> We use an Ubuntu 20 server, with NVMe storage.
> 
> I’ve just had to move Centos 7 and Ubuntu 18 to use NFS 4.0. We had hangs with NFS 4.1 and 4.2. Files would appear to be locked, although eventually the lock would time out. It’s too soon to be sure that moving back to NFS 4.0 will fix it. Next is either NFS 3 or disabling delegations on the server.
> 
> Are there known versions of NFS that are safe to use in production for various kernel versions? The one we’re most interested in is Ubuntu 20, which can be anything from 5.4 to 5.8.
> 
> 
