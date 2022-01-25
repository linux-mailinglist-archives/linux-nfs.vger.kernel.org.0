Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5DC49BDFB
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 22:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiAYVuN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 16:50:13 -0500
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:56978 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbiAYVuN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 16:50:13 -0500
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 315842256
X-IPAS-Result: =?us-ascii?q?A2G8AQAAcPBhh6g3L2haHgEBCxIMQIMsVoFWaoRKg0gBA?=
 =?us-ascii?q?YU5hQ6DAgOddQMYPAIJAQEBAQEBAQEBBwJBBAEBAwSEfgKDXSY4EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEGAQEBAQEBBQQCAhABAQEBCw0OCAsGDhUihS85DYNTT?=
 =?us-ascii?q?TsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAoEIPgEBA?=
 =?us-ascii?q?QMSERUIAQE3AQ8LGAICJgICMiUGAQwGAgEBFweCYoJmAy4BoRsBgRMBFj4CI?=
 =?us-ascii?q?wFAAQELgQiKBoExgQGCCAEBBgQEhQ0YRgkNgVsJCQGBBiqDDoslQ4FJRIE8D?=
 =?us-ascii?q?4J0PoQMIQKDLoJDIpFngRUxG1tKgTKhDGCeAINPn0IGDwUup3mWRyCmGwIEA?=
 =?us-ascii?q?gQFAg4BAQaBeIF/MxoIHRODJFEZD44gGYNYin0jMjgCBgsBAQMJjWUBgkUBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23:yk2gXBIryfmz2v+Ox9mcuWsyDhhOgF28FgIW659yjbVIf+zj+pn5J
 0XQ6L1ri0OBRoTU7f9Iyo+0+6DtUGAN+9CN5XYFdpEfWxoMk85DmQsmDYaMAlH6K/i/aSs8E
 YxCWVZp8mv9P1JSHZP7bkHS5GCu4C4bAVPyORcmTtk=
IronPort-Data: A9a23:vwBe8a+KXAEcW9iGDathDrUDIn6TJUtcMsCJ2f8bNWPcYEJGY0x3x
 jMYXWjSPanYMGanL98ibdu1pkhX65HWzYAyQAo9+H1EQiMRo6IpJzg5wmQcns+2BpeeJK6yx
 5hGAjX4wURdokb0/n9BCJC4xZVH/fzOFuqU5NLsYHgrH1c9Enp503qPpsZg6mJWqYnha++yk
 Y6qyyHvEAfNN+lcaz98Bwqr8XuDjdyq0N8qlgVWicNj4Dcyo0Io4Kc3fsldGZdZrr58RYZWT
 86bpF2wE/iwEx0FUrtJmZ6jGqEGryK70aFjRRO6VoD76iWuqBDe3Y4rNddbQgR2gA+LpPFLw
 okWsrO+VDYQa/ikdOQ1C3G0EglYFIgfovrtByj6tsaeiUrbb3Hr3vNiSlksOpEV8fp2BmcI8
 uEELDcKbVaIgOfeLLCTE7EwwJh8apS2etpB6hmMzhmAZRoiaYjMRKjW9/dd1SswwN1SEObXf
 IwUZScHgBHoOEQSagtNUs9g9Auurn/nKiEbsH6unocqxVbI4zNU9uiqMPOAL7RmQu0Oxx3D+
 Qoq5V/RCREHP9/ZzTeb/2iEgfXGlif2HokVEdWQ/PBrjVmf3UQdCRASWUC2ur++kEHWc95WK
 lYZ0iYooKd0/0uuJvH5XhulsDuCsAU0RdVdCas55RuLx66S5ByWblXoVRZEYd0i8cUwFToj0
 wbTm8uzXGI/9rqIVXia67GY6yuoPjQYJnMDYilCShYZ597ko8c4iRenostf/LCdntzYXhqz4
 juwrhMfvb9P1skk2biKxAWS696znaThQgkw7wTRe2uq6AJleYKoD7CVBUjnAeVod9jHEwLd1
 JQQs43BvLtRUMnleDmlGb1VRNmUC+C53CowaLKFN7Mm5jix/HjLkWt4umovfRgB3irphlbUj
 KL7vApQ4NpZOiusZKouOYapUZ10ne7nCMjvUe3SYpxWeJ9teQSb/SZoI0mNw2Tql0tqmqY6U
 Xt6TSpOJSlGYUiE5GPpLwv47VPN7n1irY80bc2hpylLKZLEOBaopU4taTNilNwR4qKeuxny+
 N1CLcaMwBg3eLSgPnKOqtNPdQhRcSNT6XXKRyp/Jr7rzu1OSDFJNhMt6eh9E2CYt/gIyraVp
 i3lMqOm4AOh3SSedm1mlUyPmJu0BM0k8hrXzAQpPF2y3GMkb5rn56AFb5wtdKUm8+oL8BKHZ
 6htRil0OdwWEm6v021FPfHV9dU+HDz2217mF3f7MVAXIs84LySUq4SMVla+pEEz4t+f7pZWT
 0uIjV+AHvLuhm1KUK7rVR5Y5wrh5CdGwLMrARKgzxs6UByEzbWG4hfZ1pcfS/zg4z2YrtdG/
 2562SslmNQ=
IronPort-HdrOrdr: A9a23:PlbJJanIEdLgSjs0kvaj+TRvrKvpDfOsimdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcLC7V5Voj0msk6KdkrNhWYtKOzOWxVdATbsSl7cKpgeNJ8SQzJ8/6U
 4NSdkHNDS0NykAsS+Y2njHLz9D+rm6GcmT7I+xrkuFDzsaEp2Ihz0JdTpzeXcGITWua6BJc6
 Z0qvA3xQZJLh8sH7iG7zQ+LqP+juyOsKijTQ8NBhYh5gXLpTS06ITiGxzd+hsFSTtAzZor7G
 CAymXCl+iemsD+7iWZ+37Y7pxQltek4txfBPaUgsxQDjn3kA6naKloRrXHljEop+OE7kosjb
 D30l0dFvU2z0mUUnC+oBPr1QWl+DEy60X6wVvdunfnqdyRfkNNN+NxwaZiNjfJ4Uspu99xlI
 hR2XiCipZRBRTc2Azg+tnhTXhR5wuJiEtntdRWo21UUIMYZrMUh5cY5llpHJAJGz+/wJw7Ed
 NpENrX6J9tAB2nhkjizypSKeGXLzYO9k/seDlGhiXV6UkYoJlB9TpZ+CRF9U1wsK7USPF/lp
 P52+pT5fZzp/QtHNJA7dE6ML+K41z2MGPx2V2pUCfa/YE8SjvwQs3Mkf0IDN/DQu178HJ1ou
 WMbHpo8VIud1PnE4mgx5tOtjzdZgyGLEHQ9v0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,315,1635224400"; 
   d="scan'208";a="315842256"
X-Utexas-Seen-Outbound: true
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 15:50:11 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2p+6BaE7yxPHQexYjRMPyGOS8MsfCzK2yE3mtHIMzU4fLNxaVB/s3KiAQW+JJF5zQLZ8t7O/gnziQD9BEKg5QQmf2w591TxmJq+XR2oYPvQEv/tuT8dLly3ImXlezurSAsXvA7RinPbsL7L8ylujYvd94tA+TqQD4uNP22QOLrQd4VDLIMIKO02+VGvILFNBxcDXwzkaP460ph/puXZhL0evDFkoutktP/s5FU1cnMBmFE9CSLlyGxOlZsYPAP5MlWwFLxsYVLsVSmp8I2ZvGAV6xxoe4xg/aRdbVjKb1WiquFfLUrwOG6cCq9rwIshJrw4Ubpn7tzbDRGUiv4Odw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU3pw0PSj0lU2tAWTD9hmp9CG1Jhk+x8blNZuu7n57Y=;
 b=OSt1n/HktNtDHHnJvtt+l3PUw5kk7X+AK/dvZtdqZ3vIaRGdipw9LAgngJ1MStSkyEN1hdbjHHmMKkCiSbyfcqloSKSzWb5jW6b8shB4aeH+S8TPizVKjWOI6clMwttpwDYm2LBVQ6DZGwSp+o1MMOzAksHJBVP82AC7irx4t3R7SsPE8wcfbYkf0Xz3dlWfRKtwuCArA6SGSDm8cxDV+q9ZSgwW3ppPxDLQs3ckhbhE7LzcJ8dBpNUqFZNCe/gIaPykfNgXq72vrPK1A+7J1YUP0CZkiGGglQuSILEE+qAa5EuLA4W3GnTDUZiAgcKO3tU+BB8pIg9kShgRVMiMqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uU3pw0PSj0lU2tAWTD9hmp9CG1Jhk+x8blNZuu7n57Y=;
 b=gqbIIS6Xt7z8isDTJpy9qK+0H1eQVavjDm+0cVZB34wqPjeHZ9BHdL+QzKcduUD63P1IoZjsngYKSrLS/t3LA52lxNbA8kgaclfrHEwTsOn6VtCTGKkGZLhYG7D5pRQ6PZ7QoPqgsS9Xec2/7AE6hH6V0YIKTCJW63qmLP7+O5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by MWHPR06MB3023.namprd06.prod.outlook.com (2603:10b6:300:3e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 21:50:07 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::7949:fab0:e011:12f2]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::7949:fab0:e011:12f2%4]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 21:50:07 +0000
Message-ID: <42867c2c-1ab3-9bb6-0e5a-57d13d667bc6@math.utexas.edu>
Date:   Tue, 25 Jan 2022 15:50:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: parallel file create rates (+high latency)
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Daire Byrne <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org>
 <CAPt2mGOCn5OaeZm24+zh92qRcWTF8h-H2WXqScz9RMfo4r_-Qw@mail.gmail.com>
 <20220124205045.GB4975@fieldses.org>
 <CAPt2mGPTGgXztawDJfAKsiYqnm6P_mn1rtquSDKjpnSgvJH1YA@mail.gmail.com>
 <20220125135959.GA15537@fieldses.org>
 <F7C721F7-D906-426F-814F-4D3F34AD6FB1@oracle.com>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
In-Reply-To: <F7C721F7-D906-426F-814F-4D3F34AD6FB1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0061.prod.exchangelabs.com (2603:10b6:800::29) To
 BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fec045d-4350-4fed-5e43-08d9e04ca700
X-MS-TrafficTypeDiagnostic: MWHPR06MB3023:EE_
X-Microsoft-Antispam-PRVS: <MWHPR06MB30232F415AB8E734BBFA8579835F9@MWHPR06MB3023.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTZiOh9l0yYRumuXLk8pyIA3E5wcjsl5SUHIQ+yP3+t559qxyZhv8LMYvYATuSXZpcBqYJrIS9PqFWrAHQO3A8LLWGQ1o4gRLcAWn9JNEWoRIZjb6YiRmaiI/9RQsnbU6DC5zOAUL+N4m2wXLXZqE/5Pp9itrUvGZAI7gMzFl2G5p5xS/1HCsDU6g7sK+aqsrIcrcQ1aQEVcSROc6uiDGool6KGUzLwJkFawnNprWxaZIVBc+ZLHEs3Azfg7L4rKKKjGST6gBr7px1IP4DvF9Sld+qaMkclzkS+cPZGfb6fOafEjeQlhC78LLeXQywNHIkFXXtKO7EDITvSFp4Gv9I/23fLRt8kvj2KWi0rnfzMa5G9FpLptNeyIb4z9xnNrsPcrMu/jMOSp4u4l0n7doX2PqixCXDA25MVOafFtnfk5MyNmFMEW2Fazdo0ezzsss62htdRIXQNAuD1zXkg+Tplc0gDFJDVmFS9thqkTCxUYjSBH0poFBS8M/XV3ca3h/DmbgX2Zmuj6Yti357aNxQDG+qkz0rXg6l9EkIur+OnTy0p7rzF1vebIKE9UgKRQjlV3JvgGScrwieAw8GLyq2M6CtrbZKPtBqjHuO12Fudh2QxzIU9CN5IGWQpOLtnyvcXYe6SoMq1BAAiFW9uiXHM307InzNJul2FRRyzZwDAzIlO1RsERJLwFq92Jxibv3pn7P62sj4GfKT3+wqt+GAVXH+mghhwmmPjin5vxW3DL9TwaQBFYp+WB189bUHINypHAZzKSdcynuxoeZQ/5Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(6506007)(31696002)(66476007)(316002)(786003)(86362001)(2616005)(66556008)(38350700002)(110136005)(54906003)(83380400001)(52116002)(5660300002)(53546011)(66946007)(6512007)(38100700002)(4326008)(508600001)(75432002)(26005)(6486002)(2906002)(8676002)(8936002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2xHNjZBd1RVeEVtV2hzOXBVS0dpckF3VXVpakZ4SEhvM2x0V3U0YXNnNlp2?=
 =?utf-8?B?VkhuVnYycU0yYTBMWHJWQi96WFduaWJhY3RuWVU1MWNieVNYcm1rQlo1UUpW?=
 =?utf-8?B?V29vaTBFVDhvVHkySEFtNTlQZUZpd09nVGlMUHFjR1VleGx1VDFDcUNiRndk?=
 =?utf-8?B?SzMxQytQSVU0K0Y3V3dsa3ZoN1M2OXZFUEZEeUp3UVdHSlYvd3BZOU1YeTNQ?=
 =?utf-8?B?S1I3Y3M3QmMwNVZadnZ4aW9RbGlMWVZHWjJ6bVhOeGlDdU0ybjBZTHZXa3Ji?=
 =?utf-8?B?bk5CeDJXcm1BenlsK3I5amZXT1VHVjNLTmFRTHNIUUYyNmM4MytjblJvcEhF?=
 =?utf-8?B?ZW5lWFgwbkp6bUtvUm1zK2hrZFBiZ3IwYW03MFFENm1oQVN0TXpwUXlmTTJv?=
 =?utf-8?B?VkxFTVF6OEk0WmJMS3dINHhWNkRlQ0tlSXY0dGpnM0VNeHc2YVV0RGpHZ2pu?=
 =?utf-8?B?M0tnZkpiK3Nid2JiN1VGem9GUWxSZnRGYjk0enR0RHJqVkFEWEY1TGc5dU5Y?=
 =?utf-8?B?djdWb1NZZkwrcXhsKytjRDZJOS9adnl1ZjlXQlVtVkhLNGlHL1ZTVHlPeWFi?=
 =?utf-8?B?dWpZYk9Ncmd2akFidmo2bmZQRGNtRFM4bGFGdEpVVlYwTWpuZm5tMERWeE9Z?=
 =?utf-8?B?eUdkNnZBNWFSTlJsdjQ3dERYZTBYanNsbFBmM25BbFRXd002Y3ZCZVh3eE9Z?=
 =?utf-8?B?dURmRi8zelBlam9LcnZJczZMRXJCZjdFOWVzVGlQZVdpS1BIMGVwUElNazd2?=
 =?utf-8?B?a2ZZMmRKbkV2c1RUUEVXRlEzd2krZ3EvTWFOLzBldVpHa04ralJRMVZMMDJz?=
 =?utf-8?B?dTFsUFBmeVQvUm9DZFAxNDdGNTBTeGVvd2V2UnVpdFN0Y3Q4a2pDNlFzcVZv?=
 =?utf-8?B?cEVBZXFHeG1oUUtRWlprdUtZc3BBaGF6czl0QkxIaVB4bENPOHEwclJhRmhk?=
 =?utf-8?B?ZUhRMGtYRzZVcTVla3pkbFRVYm8zeHVDL2dLTHIwMjhsanJadS8wUUFKbHQ5?=
 =?utf-8?B?Ly9uUThRL1BsTVh3eENySlp4cW5UVFJYQmErLy9OWSszRHRpYldWclA0MkJp?=
 =?utf-8?B?YTgzdjkzeS82aFdEMmtZUEd0VlNpNEFudVIyQWQ1MnI4dVFXY1JVNno3OXpX?=
 =?utf-8?B?QWtSdmpVTmsrM284VENLa0t5YTgrY2kwSHJrTktiZVF2Skx2a0ZWRGFqMDQv?=
 =?utf-8?B?cm1Mc2ZHUXlUS0RqdWtYcDROeVB3dUpvRDlLQXY0b245eDkrZUtCODlua3U1?=
 =?utf-8?B?TTQvL3NTYkVoMDhlWE9nLzgrbDJiMmVJL0NxWGU2VENEczNBMVFCUzJjb0Vo?=
 =?utf-8?B?dm9lcTZydThVWGFXVXpkY1Y4aWM2T1J2L2RFTURzMjc5alI2T1lKNFZwRFAr?=
 =?utf-8?B?Ymt4b0E5YzBIMFY2TUpPWDlYdnNXTCsvM1prbFNkRnBJSjNJMWNXSVJVVUlm?=
 =?utf-8?B?WjFMNlRZZUZ1cFFGN1FMbUZSS1BIaXVvM2J1eXRJQlhWN2ducWprM0Jsajd0?=
 =?utf-8?B?NkRGU05VTG94ZkptVG9jbWNjNHBrd3FMbFpFYXEyejFURS92ZnpQZzYwTlFU?=
 =?utf-8?B?bWpzNE9EcHZ0NGJWVTJUSzN6d1YwWFdsKzFaUEg2Q2xYK1BUSTJDQnVvRzhB?=
 =?utf-8?B?UHQ4a3hhbUFGQStrZlVUU2FyZks1aE9GK0VNQ2dLN2xRTW5Bc2NQYnBhUVl1?=
 =?utf-8?B?eXNkT0o2bS90VlEwNG5UQzlabGxlRkZrTUxCVlZnMi8zZHlFU0VKdTlSWnNx?=
 =?utf-8?B?dmpIeE42OU54cFVTQ3lTbnlqUEpwNUpiaTRVSzNSZFZkRS9qL3d5eHVWRlJu?=
 =?utf-8?B?cXJVTldkUVNMMHBDRjVPTWR0WFdFd2hYODZZRkhrWWJDMXo2cEgzdzdxZHA0?=
 =?utf-8?B?d3dkcGpDZFRWU0NLeVR5SVNMd2JFbis3d2VSZHBGK0JJS0N5ZjlEUUdJUjJt?=
 =?utf-8?B?TE9kK21hWGZhQ2NuV1RJMnI0MFN0N0U0SktvaHZZS1dlTVg1OG8xK2g5OFlu?=
 =?utf-8?B?UFlCdFZWM0FUbjNQRGxCMHg4ekhHUGFDR2Z5MGcxczI2aExORkFURURMbnpn?=
 =?utf-8?B?NkFNYTlIUFJkWisvUWRZQTVaUHczRkR3MWNQT1NId01NSjJXVGFOcGtMS2Ns?=
 =?utf-8?B?ZXhOclBRL0Z0QkUrbkxEeG9sOGJ5aWlDd1VVWWZBaTRzeTViOWN0R2lVS3Fo?=
 =?utf-8?Q?QGKO++YtmjQAqEkG5U+otHY=3D?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fec045d-4350-4fed-5e43-08d9e04ca700
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 21:50:07.5310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RENw5pquO5QUOZsbirUsEr5ZGRxX+Ytn0lu0j5Ndl1FTw0zrUnv1fmkKz7vy+HNmVNii2NT9JrXY/2kdz3O3Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR06MB3023
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/25/22 09:30, Chuck Lever III wrote:
> 
> 
>> On Jan 25, 2022, at 8:59 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
>>
>> On Tue, Jan 25, 2022 at 12:52:46PM +0000, Daire Byrne wrote:
>>> Yea, it does seem like the server is the ultimate arbitrar and the
>>> fact that multiple clients can achieve much higher rates of
>>> parallelism does suggest that the VFS locking per client is somewhat
>>> redundant and limiting (in this super niche case).
>>
>> It doesn't seem *so* weird to have a server with fast storage a long
>> round-trip time away, in which case the client-side operation could take
>> several orders of magnitude longer than the server.
>>
>> Though even if the client locking wasn't a factor, you might still have
>> to do some work to take advantage of that.  (E.g. if your workload is
>> just a single "untar"--it still waits for one create before doing the
>> next one).
> 
> Note that this is also an issue for data center area filesystems, where
> back-end replication of metadata updates makes creates and deletes as
> slow as if they were being done on storage hundreds of miles away.
> 
> The solution of choice appears to be to replace tar/rsync and such
> tools with versions that are smarter about parallelizing file creation
> and deletion.
> 

Are these tools available to mere mortals?  If so, what are they called. 
  This is a problem I'm currently dealing with; trying to back up 
hundreds of terabytes of image data.


> 
> --
> Chuck Lever
> 
> 
> 
