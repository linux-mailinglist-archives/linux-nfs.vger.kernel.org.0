Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B232549BF3E
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 00:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiAYXBS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 18:01:18 -0500
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:6062 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiAYXBP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 18:01:15 -0500
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 315850232
X-IPAS-Result: =?us-ascii?q?A2G/AQCDgPBhh607L2haHgEBCxIMQIMsLih+WGqESoNIA?=
 =?us-ascii?q?QGFOYUOgwIDnXUDGDwCCQEBAQEBAQEBAQcCMRAEAQEDBIR+AoNdJjgTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQYBAQEBAQEFBAICEAEBAQELDQ4ICwYOFSKFLzkNg?=
 =?us-ascii?q?nBjTQY1AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINU?=
 =?us-ascii?q?ik9AQEBAQIBEhEVCAEBNwEPCxgCAiYCAjIlBg0GAgEBFweCYgGCZQMNIQGhE?=
 =?us-ascii?q?gGBEwEWPgIjAUABAQuBCIkMeoExgQGCCAEBBgQEhQ0YRgkNgVsDBgkBgQYqg?=
 =?us-ascii?q?w6LJUOBSUSBPAwDgnQ+gkwXAoEaLoMwgkMikQNsIw9dARsICAV2FjQZCkpDk?=
 =?us-ascii?q?VyPMmCeAINPiwCUQgYPBS6DcpJrkRyWR4o/gkuZMQIEAgQFAg4BAQaBeIF/M?=
 =?us-ascii?q?xoIHRM7gmlRGQ+OIBmBDAEMgj+KfSMyOAIGCwEBAwmQKwEB?=
IronPort-PHdr: A9a23:cJ0iaB1YdqQZB2JqsmDPpVBlVkEcU/3cMg0U788hjLRDOuSm8o/5N
 UPSrfNqkBfSXIrd5v4F7oies63pVWEap5rUtncEfc9AUhYfgpAQmAotSMeOFUz8KqvsaCo3V
 MRPXVNo5Te1K09QTcP3e12Uv2G//TcJXBjzKFkdGw==
IronPort-Data: A9a23:K/E4vKBvKncuaRVW/4bjw5YqxClBgxIJ4kV8jS/XYbTApGh2hDNTn
 2sYUWyOP/2CN2r2KY0nO42zoBkP65PdmoBhOVdlrnsFo1CmCSbm6XV1Cm+qYkt+++WeFCqL1
 yiaAzX5BJhcokX0/39BCZC86yksvU20buCkUrScY3osHVUMpBoJ0HqPpcZo2uaEvvDkW2thi
 fuqyyEIEAb4s9LcGjt8B5Or8HuDjtyr0N8rlgBWicRwgbPrvyJ94KTzhE2GByCQroF8RoZWT
 gtYpV2z1juxExwFUrtJnltnG6Gjr3G70QWm0xJrt6aebhdqjCNs3fkrF+QlN2xIqBionP9N5
 /dcnMnlIespFvWkdOU1dTB9Sns7EYgYvbjNLD64rNCZyFDAfz302fJyAUoqPIoevOFqHWVJ8
 v9eIzcIBvyBr7vunPTnFa8x14J6c5KD0IA34xmMyRnBAvErXYLrRqzW5ZlFwDogj9sIEPrDD
 yYcQWE2MUSdO0cUYD/7Dro7x/mEoXb8agQGqVCOmPUvvVrvnRBuhe2F3N39IYXRHpo9clyjj
 m7P/n70Kh0cOdPZwj2AmlqmiO7CmS/gcIwTGbm07fNxxlqJyQQ7Ax0LXlj9pfSnh1SWXMhWI
 EgZvCEpqMAa8E2tU8m4WROjiGCLswRaWNdKFeA+rgaXxcLpDx2xA2EFSntNbYIgvcpvHzgyj
 AbWxJXuGCBlt6CTRTSF7LCIoDiuOC8Ta2gfeSsDSghD6N7myG0usv7RZvxsTqHqnv7rIG/b3
 BOnjSsRu5oxnOdegs1X4mv7qz6ro5HISCs86QPWQn+p42tFWWK1W2C7wQSCs64ade51WnHE7
 SNawpLFhAwbJcjVzHTlfQkbIF2+Cx9p2hXwjEUnOp4g8Tm2k5JIVd0Iu2khTKuF39ZtRNMES
 ErauAcU6JoNOnKvNPVze9joVJ9syrX8H9P4UPySdsBJfpV6aA6A+mdpeFKU2Gfu1kMrlMnT2
 Kt3k+7zUR726ow+k1JaotvxN5d2mkjSIkuOH/jGI+yPi+b2WZJsYe5t3KGyRu449riYhw7e7
 sxSMcCHoz0GDrGlO3KKrdZLdgxRRZTeOXwQg5wHHgJkClo2cFzN99eKndvNhqQ5wvgEy7+Up
 hlRpGcBlgKm3CKvxfq2hoBLM+q0BskXQYMTOC0nJ1Gz3HY/KY2o9r8YbZIrfL4hnNGPPtYlJ
 8Tpj/6oW6wVIhyeo2R1RcCk8ORKKUr37SrTYXvNSGVuJ/ZIGl2Skve5L1uHycX7JnHq3SfIi
 +b8jVyzrFtqb1gKMfs6n9r2nwru5iBMwbwrN6YKS/EKEHjRHEFRA3SZppcKzwskcH0vGhPyO
 96qPCol
IronPort-HdrOrdr: A9a23:NT6rHa9TuPPmM7tefNFuk+FYdb1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYVYqN03IV+rwXpVoMkmskaKdhrNhQItKPTOWwldASbsP0WKM+UyCJ8STzJ8k6U
 4kSdkENDSSNykFsS+Z2mmF+r8bqbHokZxAx92utkuFJTsaFJ2IhD0JbzpzfHcGIzWuSaBJdq
 Z1saF81kadkDksH4+GL0hAe9KGi8zAlZrgbxJDLxk76DOWhTftzLLhCRCX0joXTjsKmN4ZgC
 X4uj28wp/mn+Cwyxfa2WOWx5NKmOH5wt8GIMCXkMAaJhjllw7tToV8XL+puiwzvYiUmRwXue
 iJhy1lE9V46nvXcG3wiRzx2zP42DJr0HPmwU/wuwqUneXJABYBT+ZRj4NQdRXUr2A6ustn7a
 5N12WF87JKEBLphk3Glpn1fiAvsnDxjWspkOYVgXAae5AZcqVtoYsW+14QOIscHRj99JssHI
 BVfY/hDc5tABCnhk3izytSKITGZAV3Iv7GeDlMhiWt6UkXoJgjpHFogPD2nR87heUAotd/lq
 P5259T5cFzp/ktHNZA7dc6MLqK41P2MGHx2UKpUB3a/fI8SjrwQ6Ce2sRG2AjtQu1F8LIC3K
 jdXEJRryocYETrTeGe+vRwg2XwfFk=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,315,1635224400"; 
   d="scan'208";a="315850232"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:01:14 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ff4Q7Fu+eI36YwaIS5XQBQu0rUCtWFlGjAnGJqPc2+l+2EN4/KCD4yqgE/X0X0q0J0+rCD4ZceACJRQr4K4hoZhaDV3yF8x35O1Qcz267kWgOMxzbXwkc8y8QlqwUkYbyvdKZOqzRVTNZOpsyHZwO93AGar5FuCffL+whoeY4WT/U9lQC5e0FQ1XXx/l5Hf5ulOp+TUs3Cv4vLJw9yqEjfvlrRGb1xNehbhzsGpQfBs4cs1ZtxjJTNe8RqDc5JI4po16Hz4QVs7Q+fmX1dzRjaIqZc/KLoRGrHmQtzrwquaJt8B0/djf4nsWbx3fgHvUWyjXGWoFXxQIaZwnfipHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5B1gRwPmBOxLPk+TPmPoxDNVK7oRSCyGJMpiAfFbqA=;
 b=Z2zvoyowwOr2OstVR72KvFDoVGRmW/bFHxLoGAXtKYQD8Yx5cp2jGCt1t4U1koykwzb0u/b0jZU1YWllwA0VvqM7kVpmNU316ow4mHd4vzTF/Hhkj6SVM5c4Odx9Z2wv319BCZ4IO14NqqL+FNPqmDT9c6p/QHeeALfyw5OWGLa3ewRQH7/4c1P5wXmVkVbOno/uxUJqjbeDhfs6EOYtLJEs2Q5+Lo1D4FG/xXllBZNa8JRAxe3mfDgNINrkMMfRJ3Q4Y+1KHha5KJ9PbAL0xPZWyWrE52t+5G6uC/O/6lstQ5JIbb4aiJWaYel0jWrZfZeYKNXoQCa3/238773A1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5B1gRwPmBOxLPk+TPmPoxDNVK7oRSCyGJMpiAfFbqA=;
 b=d88NEgyNbTgXAKBHB+wktgoXJRGP/cvbh0ypjbHgLbndE5HEdy4yZqaNjixQa1XHKlm+/mamcTl3Q/veXRf7qUmIw/rU7629x0N9+yUzg3vXAVticuGrtVPBnLVZLgzpNhmfRdCX8CV7XCaMnKlwOUKaMXDXKSR4tNmpDNMH7Jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by SN6PR06MB4816.namprd06.prod.outlook.com (2603:10b6:805:c0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Tue, 25 Jan
 2022 23:01:12 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::7949:fab0:e011:12f2]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::7949:fab0:e011:12f2%4]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 23:01:11 +0000
Message-ID: <a5627c80-4b03-29f2-1432-6e0f0b5197ef@math.utexas.edu>
Date:   Tue, 25 Jan 2022 17:01:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: parallel file create rates (+high latency)
Content-Language: en-US
To:     Daire Byrne <daire@dneg.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org>
 <CAPt2mGOCn5OaeZm24+zh92qRcWTF8h-H2WXqScz9RMfo4r_-Qw@mail.gmail.com>
 <20220124205045.GB4975@fieldses.org>
 <CAPt2mGPTGgXztawDJfAKsiYqnm6P_mn1rtquSDKjpnSgvJH1YA@mail.gmail.com>
 <20220125135959.GA15537@fieldses.org>
 <F7C721F7-D906-426F-814F-4D3F34AD6FB1@oracle.com>
 <42867c2c-1ab3-9bb6-0e5a-57d13d667bc6@math.utexas.edu>
 <20220125215942.GC17638@fieldses.org>
 <7256e781-5ab8-2b39-cb69-58a73ae48786@math.utexas.edu>
 <CAPt2mGNMGjq+i=k_6oYBYPFPCTR2UdeEtWfyeTU9uUC0OC=T4w@mail.gmail.com>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
In-Reply-To: <CAPt2mGNMGjq+i=k_6oYBYPFPCTR2UdeEtWfyeTU9uUC0OC=T4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:6e::29) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1c1369b-400b-4099-c16b-08d9e056945d
X-MS-TrafficTypeDiagnostic: SN6PR06MB4816:EE_
X-Microsoft-Antispam-PRVS: <SN6PR06MB4816D3B27E14EDBC4AAC7083835F9@SN6PR06MB4816.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BOBE8OEcjUNoo+t/RXZroN7uganrOXq0TM9onOVbQbu5JQK+kXz3LVMpyP0N+TJe6dGg6ttluVTzJT476UoCSBVN14FXVj13tR6BQqX7KbN6VDAUMJPbtfzHJ6W5GmTl6ufI9LBj7m2ARuUdaPg4lE/aKymbzQvl7m/4CZAuNURgBMZUxuSb7FfPYaySIOFgc3oYXP/GuyKsodctPdbBHYUCtbYoGTOBuqe3AFGkh4SnPsLJg1NOCKdsCzKYwFvYrrP9oVcnAK1+OMdMdXClKmgfPWhOTJvsP58b4CTQenjrqHX0/Z/KFOW4wel8kgNMTQJPlSLxNWtPWQW0tJbGdVcIrHjJQeUvacvkeECM4Jdyr7H4YKGsEcaXaKx5H+YkUgw0+eIMAAJnOQ5egUGyH3zGwFGu/Bls7+Xs3U6DeXLr897yjKLxpC7wGmPEkTcNvw+5OiLm5vuotdMblSAZiZV4FoNyDyG6ZUtPQ6HCE+rs+aJ+jmJYEMpC31hfZlR4mZZDZeuognnukaV3BmHW08/tyNaBbagHRaifr9X0jAkg+XozGSnFRfwvB8zV/KcFEq0MZtVBv9OpUNqXbN09vTQMuUfQ0R1cUw3Q7T8LpRPBhXDt1wqXwE8eHBCdPXcUyWZ+YnDdc/mzttcAxA2lb1YZTLVc/Xls3UOHQ7kMKCc7S2qizlq1cX/rU+vtfpK8rtdJt5dhwK8yAMTAJg7O12I71kow3N6FJZ6+HkHOhtBPC28tSQb+6uWAx5cSjmLJshvLCKiNub7lL2db00mCW9oSNDdHP32CQO/76ERhlAJBtPZ0ZUoNi9cxc82Pk0l0xkjozhHSfQUppHEkP1zHGv970lWSwvVMIHua8MlG/To=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(75432002)(86362001)(66556008)(2616005)(31696002)(5660300002)(186003)(4326008)(8936002)(26005)(66476007)(38100700002)(38350700002)(6666004)(66946007)(54906003)(2906002)(53546011)(6506007)(6486002)(316002)(786003)(6916009)(8676002)(6512007)(52116002)(508600001)(31686004)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUVKcWk5amtIc0hkZ0V4L0RKTThRR2hkRGQxMFFSaDdBSkRSc2U4cDhDTEtU?=
 =?utf-8?B?eVU4dWRXNFM1U2p0Y0wxL2JRWERDRGcreWpESG9oTTlWb1NoVmYweklKVlJM?=
 =?utf-8?B?cldLUWVGQlpzVndBN3dHK0ZjVG9neUFTMTc3Ri9PLzRwdVlFeU9qeVRWWDBJ?=
 =?utf-8?B?Q1k0TERKNDkreDZBcUtHZGxIdENYWGM5RmhWZlhocUpHM1VuU2R6QXJNUzZr?=
 =?utf-8?B?cXQ3Z3RSTG0vbll4b2I0UnFBWmltRFUyVk9iYml3bTBGYmxadDVkV3VCYnVC?=
 =?utf-8?B?eHBydnc1QlA3NnAzeGYxQmJWL3k0VUNiWFlPeElUVzQvbnZobHpSbGpTbmRu?=
 =?utf-8?B?YjEzVklZRTQyZW5BZWxpTUdnT3lWQ0RyYVVHZ202Wm81NGUxZTdjWG43cHJF?=
 =?utf-8?B?YmR5MTJyb01sdDRqOVd4UGw1NU40S3p2S3Rod25TWWI3TWMwSS9iNy9lRjk3?=
 =?utf-8?B?VWtDZ1hWZWUrS1ErN0dHeE5WWTBLU0hndXpCM3RFNGVMMGlFQW93Y1R2Tm9Q?=
 =?utf-8?B?QUN2c1lBYnJyRW5VR2dTNTZCb1hwVWtFL0ZWK2pENmRrR2ZBVFBUN0FLM281?=
 =?utf-8?B?eFFpTGxEbU9RQzZMRTBvM0RMTTFhRkdZMEFtT0V1akxvbmJoME8yTVJpaHhQ?=
 =?utf-8?B?K1lEejI0aUVyTjA0QS9IRE1GcTNheEZuRENzTFJXQlZseVRYOFJWQ0wzUGZT?=
 =?utf-8?B?NjlSNklrdDk1U3NmcEF6dENuc3dIQ0dpTEI5cEkrL0M2MHhJVmxoNCtDaVZ5?=
 =?utf-8?B?NWh2U0dFcVduYXJ2QXJ6WXFEa2N5TzJ4MXJnQXZUWHFlMEIyVHNvTjFEdnZw?=
 =?utf-8?B?QWFSVVNvWktaZ052d05xNmlwTGRZR0REMG1LWDBiU2hwb1lpUVJVd2sxUTha?=
 =?utf-8?B?V200MDJlV0NZREdwR0FFTVlRZXg3MGhhcXM5Z1Y2OVJkSDgwSVB0VW5URXcx?=
 =?utf-8?B?SU9mYkFsQVloejAvZTBGUDdhK2pkaGtyUDNvQWtpM0c3VFE4UkxzektWd29S?=
 =?utf-8?B?bVUxdXZxRGZiZmZyMDVaazdscVlhVUtDVlRBZEx6Mno0UnhsOUs4VG9FaFpI?=
 =?utf-8?B?dEo1ODRxYXZsQXBoTk0zQ0VDemRyN3ZBZExjZ2ZzZmNuTkJUdTRTSllGbnVn?=
 =?utf-8?B?RU9hRkNIWTBwQmZKL1BPbHdWOXlIUTNaQVUraHBiTG42MncxcGtpaW1RSE1y?=
 =?utf-8?B?NXZnMDdVQTlpclJEUlZ0aXNKL0x2UlUxY2RWRHBkZ3NnaVRZYXMwakt6QkVW?=
 =?utf-8?B?WXFHMXVRV1pDcFZaN09aT1JaTHhpRWR2c1dTMTR2WWVvQ3d3L00zdHNJUy9T?=
 =?utf-8?B?K00wSDRuUDFuQ1Zmc1lRVmZNNFVHdERYVS92am43bVkyMUZ5K2lBRkV5MURQ?=
 =?utf-8?B?NlI2NWc5bDdBczlkcVRKaGpNcFl4bVNHV1JTWERKMnFEekV0V3Z3elZwL2dH?=
 =?utf-8?B?NlVaVUFweS95SWNjbEd2bWtxNWszb0lqMlB5bWFCSmQyTlR6am5kR29vTHI5?=
 =?utf-8?B?UkVJaTU0Z01ubGtSUWduUWJaSE1lOW8zaEk2bFQyVjJKeUlwcjhWZXFuc1lj?=
 =?utf-8?B?UWNOTkhZTlJQRjgvV3Z4YVdvaXREa2w1OE1yUFlXeU9JWUZLU0NmSml2Tzdl?=
 =?utf-8?B?YXRYMWJMQnFiL3l3b1VpUFlFTFkvRGtSWEhXV1I3NkFuSHZwREdDT0Q3clhF?=
 =?utf-8?B?MW9EWkZndnFsbVp4aEdhSnZPbU5LaHR6NlhJYXJpMUdsWk1leHlPT3V6dmdn?=
 =?utf-8?B?blU3T3BWQm5XcGtQQUZMbUwyV1Fsa0RJTjNJbkVoY3hreXQ1NlNEOGlybFA1?=
 =?utf-8?B?SXFIWDdGVk9BRlYzbWptWDZ6cEkvVVY2aHlSNmZ5eFMvKzNmNkZIUDhpZHpN?=
 =?utf-8?B?VW9WT2NnU1dPM3BkZVE2Tzd5SzNXc0R6UlhlTG1jWURBdFlQVlNMcTNJKy85?=
 =?utf-8?B?anYzYzRkdUk1bk5RVCtWS0FmOGpOZlpkbnVoSUZhbnRCWklmQjhSSjlzZWtr?=
 =?utf-8?B?ZHloUVNOa1VIbUVINUZhdncxRXZubjFIcWpRUHkydEN5K0dCL3RrTzhiVVBO?=
 =?utf-8?B?UDdqRGttN1lWSFp1ck9iUmNnWThLQ2NKc1ZHZ2hFbUw4Y2RzZnBUekU2dWJk?=
 =?utf-8?B?ZGpTUGJHeVI3RXVDcW5ncUgwOFE0dHBiVjdzZnRmTzlieEhCQ01YaVF1Q29V?=
 =?utf-8?Q?EdSs6gsJjWhvDabQIRP1340=3D?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c1369b-400b-4099-c16b-08d9e056945d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 23:01:11.6085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FG/HP/G6zUxeII0XkfkvwWeJbwur26Dix1gaFEl1ljy0kOO+6N1XBIcfQBCdEWd9eLk1ZZvcjBerCFxGuaHKvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR06MB4816
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/25/22 16:41, Daire Byrne wrote:
> On Tue, 25 Jan 2022 at 22:11, Patrick Goetz <pgoetz@math.utexas.edu> wrote:
>>
>> IDK, 4000 images per collection, with hundreds of collections on disk?
>> Say at least 500,000 files?  Maybe a million? With most files about 1GB
>> in size.  I was trying to just rsync it all from the data server to a
>> ZFS-based backup server in our data center, but the backup started
>> failing constantly because the filesystem would change after rsync had
>> already constructed an index. Even after an initial copy, a backup like
>> that runs for over a week.  The strategy I'm about to try and implement
>> is to NFS mount the data server's data partition to the backup server
>> and then have a script walk through the directory hierarchy, rsyncing
>> collections one at a time.  ZFS send/receive would probably be better,
>> but the data server isn't configured with ZFS.
> 
> We've strayed slightly off topic (even if we are talking about file
> creates over NFS) because you can get good parallel performance
> (creates, read, writes etc) over NFS with simultaneous copies using
> lots of processes if distributed across lots of directories.
> 
> Well "good" being subjective. I get 1,500 creates/s in a single
> directory on a LAN NFS server from a single client and 160 creates/s
> aggregate over my extreme 200ms using 10 clients & 10 different
> directories. It seems fair all things considered.
> 
> But seeing as I do a lot of these kinds of big data moves (TBs) across
> both the LAN and WAN, I can perhaps offer some advice from experience
> that might be useful:
> 
> * walk the filesystem (locally) first to build a file list, split it
> and then use rsync --files-from (e.g. https://github.com/jbd/msrsync)
> to feed multiple simultaneous rsyncs.
> * avoid NFS and use rsyncd directly between the servers (no ssh) so
> filesystem walks are "local".


Thanks for this suggestion! This option didn't even occur to me.  The 
only downside is that this server gets really busy during image 
processing, so I'm a bit worried about loading it down with dozens of 
simultaneous rsync processes. Also, the biggest performance problem in 
this system (which includes multiple GPU-laden workstations and 2 other 
NFS servers) is always I/O bottlenecks.  I suppose the solution is to 
nice all the rsync processes to 19.

Question: given that I usually run backups from cron, and given that 
they can take a long time, how does msrsync avoid stepping on itself?




> 
> The advantage of rsync is that it will do the filesystem walks at both
> ends locally and compare the directory trees as it goes along. The
> other nice thing it does is open a connection between sender and
> receiver and stream all the file data down it so it works really well
> even for lists of small files. The TCP connection and window scaling
> can sit at it's maximum without any slow remote file metadata latency
> disrupting it. Avoid the encapsulation of  sshand use rsyncd instead
> as it just speeds everything up.
> 
> And as always with any WAN connection, large buffers, window scaling,
> no firewall DPI and maybe some fancy congestion control like BBR/2
> helps.
> 
> Daire
