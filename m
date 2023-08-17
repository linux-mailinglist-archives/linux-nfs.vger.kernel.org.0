Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF63378016A
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 01:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346920AbjHQW7q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 18:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355987AbjHQW7h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 18:59:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0D5136
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 15:59:36 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HI4RHB011209;
        Thu, 17 Aug 2023 22:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ls5Qz3yURxoCUZk4HuFtkLBaNRyhRBwMjLw8ibbfyeA=;
 b=sO0N5EZSYKC4SauIg/Sno1N7hQjfkbg79WXTJ3gOYwyt57VXbirerjYp/P/a2K+DigP3
 8fdZppukjCU5jCGH2y8fVgF3nR2KH13QzRnbR68L8DohwlzwOjGBVeNuNhxYT+JyYB7x
 q2D3BfbamqUqDsyImMmmy6MvtDVIXrce1bb2JBfdQU8ktu4DNa+5NRVbQ60KDMMzqaAI
 1KMhU0rlaYQC/8e/40FiKpV3DJ/zR2xcTwoNvlhjsi2+YNCTPXt2nLArwgybF2OPLjJ9
 K27O68x50eaciqh6JLrPgR6eCt2sl0cuv+g/V/W15JMfIuk1q8SWP4aPaJZMGzu9vScj nA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61cakeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 22:59:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HMe9XA040343;
        Thu, 17 Aug 2023 22:59:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0u6v2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 22:59:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJw7uyTgwJuBqVs3ZHFRCgfcGf9ClVmZiIhuAthneNLkT8Mv7AHBssTp6kQUd7MQnITwCkeDNfaP+yJvuJj7qyTI5oBLcLFgP1d23ZrvbBtbU8BMJ3UUNi/CsCNVPZ2/edeaPQx7ktGecUXciaoBGQWx7Hbw4D9EuulhctbHEXJDt7DDpz319CSL5fb1Y2oo1vtALcY7nlcHjM4X4Qt0skbNNmzN4ArmGHRFXSLShK9kZPU2jTowGUxF208lnJ9Uy6zr+TlxjeMnx844afqMt9h6DLOTF6MNiNo8ufT8nBoeNi6ZqzsI+zNvnwIGzx1GWHb30PThtjD2x4cdVrzO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls5Qz3yURxoCUZk4HuFtkLBaNRyhRBwMjLw8ibbfyeA=;
 b=d+wWw38c0Hq+/hI1SHA9o4lVHkxRPRsjnOpAeDvq7JaD0VInyYqtuD9hubceXwWJCMn8R/rY9I2jPYWByjYuwbsk28vTTc9xy0h9SYNQM8dNQdeREHBUudv6Pi6XvHkDYWE3PDsfIFD3HqDLnPfk2Ah75tF6PAcwRIqyel2no7Jar5rQ3AHELPnlY9iKxJg9BJppDMJPIr4Q8/AXBf7ZT2FpE11ZdrJZk4eKqNTpDOIco6yihL/MnLH9nT0gPuWf37vXZ6eGzoOk9dBVi8rv4x0OixjFbOcWu0M111z4VkLfPl1E1kVNFfgL5qTPqAEk4nOswe4PpeXYG3ujVAlbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls5Qz3yURxoCUZk4HuFtkLBaNRyhRBwMjLw8ibbfyeA=;
 b=U1WG4+xrIpkue/BryMJBT8nBILJUkjCqV0OUDyieY0SE39BzG4yZzxpbW+zIJMUk6XaCOHWBFkPJv955lER2hGBgaI6BFtdRoXsBMYQrPxoloYJcSSdA2UFo7RNJyslzHaKO+6Se8QGnV8IlSI7vPTF9sip7gC95/MTtLrwsbFU=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by MN0PR10MB6005.namprd10.prod.outlook.com (2603:10b6:208:3cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 22:59:23 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::3fd7:973:c9d7:afe2%4]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 22:59:23 +0000
Message-ID: <b535fccd-acd2-8fca-71ac-6aa17ee84708@oracle.com>
Date:   Thu, 17 Aug 2023 15:59:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: xfstests results over NFS
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Tom Talpey <tom@talpey.com>
References: <9ee56f62652c3d338aff809f70e7941dfc284bf9.camel@kernel.org>
 <7C595ADA-E841-44F7-918A-3A46A55D546B@oracle.com>
 <2fc1f9bf5fdc25acbcabaf4266584f0857bc4b19.camel@kernel.org>
 <CAFX2Jf=gq-U464_SrebSwCMOU+g0Vcx9Us7SPn8JQEoA6s27DQ@mail.gmail.com>
 <77977950a7d6a4539114fdd0d6db982143c4f9b1.camel@kernel.org>
 <0AEF7E06-E2F6-426D-B3DF-3D0ED8233082@oracle.com>
 <6af7807c75e3d6110bc80661a600038f5cfb0022.camel@kernel.org>
 <7b2746692aef1725cb000faabf4db2d115279423.camel@kernel.org>
 <25bc018a-00a7-1634-9535-9d01328264d3@oracle.com>
In-Reply-To: <25bc018a-00a7-1634-9535-9d01328264d3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0004.namprd21.prod.outlook.com
 (2603:10b6:805:106::14) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|MN0PR10MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0a7aa3-fd93-461e-a485-08db9f759907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCGqafQht74+vjZdEP1MH9FDmx5yGSWiQLO906eULFBs6MaOPT4nl18qgJE9jftW2AwmPJwBMhx0j13T2xZhbYsqcwUfO7iMbQwYKNobOE7MWDFy1anGx6MMkLCKABDRVlEw/MuiPsQmIRHRnjWszgZZHweix85XHF3vvPAy4eAYURUpRbY8Vu9QTnYe9B022/PRpCkrVRhCowH0lCoG7/uAMnyDnDMv+uEtQR0B1yQqd5TK2vSgoNkOjteWRRMHZ0bPleomC58QXAT610IlE9ajTAVQkP1kZrEi8tIsHLsPRfVlrxPFDyjVXsVO42QHS+5lxDyKeJ9xE8wNba7bHLTh93IbC3FxRkA49+U5mc2MBNFVVwOrblDEC/3r1D6BWyVqFkfFLzBkoxEDG8or4Z1IbjaaV+wlqDASO+0hBszbZ4RG5p//bWVJS0Tg5TAhYjPnweGPhrUbRYntL82UNkAjrhHBvAfwuvc43Wf8V8TvlfdlWdFD4Jl3VfdI5UzGmpB2lnEUANYfI80VTyIp3GulsnU+0sxDgvvJ8Nu0d+ciejMy513KxdTwYODPymecXuFRsaqjNRqlgkfzzbqPqMClVNskoR/mO2wZquVodsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199024)(1800799009)(186009)(83380400001)(66556008)(66946007)(38100700002)(316002)(66476007)(54906003)(478600001)(110136005)(2906002)(41300700001)(8676002)(4326008)(5660300002)(3480700007)(8936002)(53546011)(9686003)(6512007)(6666004)(6506007)(6486002)(26005)(2616005)(31696002)(86362001)(36756003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEh5S094VHluR3ZIcU9hTCthZ0NwY3VDU3AvRFRFb3pvZmZUREJHNElWUFlZ?=
 =?utf-8?B?MzViNUZjMm1nVTZ2eC83RnZ5QzN2VXdDNHNaakVrOTJZL25VWVNTcTRLMUR5?=
 =?utf-8?B?dTlZRzJad0QwNFF6WFI5Y1N6MkJGQlNtY0NtRGlyOXhNNlFrTUk3OHVkUWY5?=
 =?utf-8?B?NlpHMTBMM2dNVTdHRHVIdEZKOWRHWFpIYWhFbzdWMjFmYjVYc1dWQmRXYUl2?=
 =?utf-8?B?bFFPZitVazJpL0NEZ0dldTQ1d1lEYkR1U2IwaDhCbmx1Sk9NOXNQNTNyS2pn?=
 =?utf-8?B?SURsUU1VTFpLY2hXbVpXcDA3WWFBc3lSWTEvdWxqNmVlSHMvN3JmNGFPSlcw?=
 =?utf-8?B?QVN1eks3RkxXVlREWmdzeXV6YXhTTWZzeVdUZFMwQzJyL0wySGJWUTlrR05t?=
 =?utf-8?B?VEkzcWdlbFVna1Fscjk5MzJNcnA5b0dYdGo1b3NlZ1FNQWNEV3JFRndXdXE0?=
 =?utf-8?B?UVVsZ0NVT0FlRkhWQmRGVmFOYkNvWHhmdW55K0VXN2JrV05kNGd4cHJ6Q3JZ?=
 =?utf-8?B?bDNFaFdoL0tMUzRpZFVSSkpCOENCdnJUR1QzV2ZSYnk3MWwrK05LOHlzdCsr?=
 =?utf-8?B?a0czeHVFeXhFWmpENHBNUndKUEk4NEdiYWlrZUJWa00rUEo4SXg1VlNlekl5?=
 =?utf-8?B?OW53djh4SjNxdGdhaGlsUitCUjR6QjhidHdOVmxLcEdxcUl4ZVd1bW54U2Y3?=
 =?utf-8?B?b2U5ZSt5ZG5tcDBudkp1RnZpNkE3M2lWZjZVbUVXYnhISm0xaS9SR0NHSk5R?=
 =?utf-8?B?YjZwTGlFb1lTbGFVYlBHODBKZGxZdytRRGdONGRsR2FLcHJqTUVFSU5uUy9q?=
 =?utf-8?B?aWhFQktZWjFYMFdHQXc4MXplZGtoUG80Qm1BVWxHTTg5dDlMQ2hEdkhkWlpF?=
 =?utf-8?B?aVh2RjZNc2Jrd1UxQ2tUenRhVFRibjFlNFZVVHhFOTFzeFg3disvbXFhc2F6?=
 =?utf-8?B?OWR4azcySDRXbE8wZ0Z5M3lMbTRXTGdqY0FpVTZxL0lzanlPdnlSSDRQSWhP?=
 =?utf-8?B?eUpiVXZoYkdMZkZLV2lFWTJ1L2l3MksveDQwNzBWbE1rVGVGdzRIdG1sdzk0?=
 =?utf-8?B?TlJ6TEw5Z0h1ZkYrYWtqampyNDFjOWVNU2tyTHFCb1QzczFhTFNNOC83eGpV?=
 =?utf-8?B?WnQ4UGNwT1R6bi94WW5sRTN0MzVhYnpHZDFvYW1LcFF4WU5LZ0pVdzdYdUgy?=
 =?utf-8?B?eWR1Q0psVWRkREtLSnVyVGVuUmZhZjVzWlVMY1F5V0VBOXlsbTcrNzF2Uzk5?=
 =?utf-8?B?YmREMDExR0xyKzVCMDlaRThVWThvSnBQdkJMRVYxNVRkUDFJc2YzRlM3SW9M?=
 =?utf-8?B?czM5NU5pbHhUMTZxa1dYMEJRSmtRZTQvVGVQMGhzVXV3SW5vM2c1M0Y5WGNx?=
 =?utf-8?B?VFlaaTVYZjkzTVdxTFF0UXVkRGZSQnlwRVFVelRZUThEaGJwMEwxOHdhMmpy?=
 =?utf-8?B?b1pqV3h0eVZ1Ukx1S2RyNlErRzRqQlVqQWJxMXQyRlV0RUJhb3lmRGgwVVFo?=
 =?utf-8?B?OVpySnhhNFdjdHJRWFRqS09GRFd6c1BHa0dqRlg5RjlGd3IzKzd1eGluOXM5?=
 =?utf-8?B?N1RUNkI5bk5WODJndElyZ1QwMGs1ZFhSU1hZcVZHRFJHRGpTd1ZyVjNxREd2?=
 =?utf-8?B?WFV5TmZveHFSUXRPZElzTm9pMit1WFdmWlEwU2Jjam04aGFZTnYwc1NhSDVK?=
 =?utf-8?B?TGptenhoTk5WcHFpL3g0QXAyMmlTa3p3Q0JLVEtvQ2FuNElZVVcra04reGI4?=
 =?utf-8?B?SCtkd3J6Wi9oSWZwVTFpZm1OTEZTd2hYckh3N2V3S0RqdnF4ajV5QkJiWEZw?=
 =?utf-8?B?Z216YUxOOHBZMjFNQXJDRy94Y3RpYU9uRmxhWFA2ekVvc1JWSnpOaU9abnla?=
 =?utf-8?B?ckZxOElYK3ZZaUltTDNBUGNucFJwV1c2UG94TDd5K2N1bHFzVnBZSEJTSlJu?=
 =?utf-8?B?enYzclpjenpBOG1RUDEvc0pNM3duQnVicUJrclJCVitUS29CSTB0cEJ4TUdT?=
 =?utf-8?B?VU12ZVhZNHlXM0R3TWN4ei94YlZOYnB5L0F3TlJxTG5YTGJNMFk1VzFTN3dN?=
 =?utf-8?B?UGp5SEwycVlDTHF0MVpkUkNaNy83SkV1bytUZFdpSUpHaXB2azFYajRZdCsv?=
 =?utf-8?Q?LrLJsNY/bAAf/Ytuk3R8XPiCl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UAdsmrVgzxwYqb8vqvo1BoRj4/GvT0mI1tKzofFhCTBtirZQVRzFb8NAuintN0D9yJ7mixFvH821M2FCFR/Qk7DIpXmykmJPiFfOBNDhY4pQxSMXuE1Hw7BL6HxR2qXn28xw3kgMTgMv31O/MJ2sxjqUE3yQnhLfeO/04cyqDij93GAYoGIkqlM4pQRhMtq3kcSmJSjimR+Jv415NKXDtoBHyp4dRV+RNwa4QDbTC2nMxZWG/WocjhDvy9zDt6gATycobRPNSu/EJfawJYjCe+eiW7Ufbn3jUh397YBkMwXB2y+lGb9I1IJIvzSIBRgFhZTdVsH72WL8qIZ2afC8vxSVfNn/+qkGjed9HrhbhlG+iz/hHt+tStm1YHoNO6ZQdomgtmfllRuN/M4C0Fygv5ud9jQHrBN5wFNbfaprVtj8F6Gs+TYM1bvVWs2NX0cibi9UlSvW0a5lnptlAAW/spatkPgR5kgXmFSCVKOviHH9nvJ2BxYUGWAOLwBxvl9cwDSAQAQDgXXCjH3Pc024tp/fX8egJMdjpu5V1neMHZDSdGDrwDZt9ZSHYm55FoDusgqDRNQHPCiMfwvH7WTAe/0AE7KirHm/UdZybK4BBDhlDeZDRySYXW3E6HWdgtCpfcSDQi8R2Zd2O4kf24eOXLby/yzAYVkCwHEf9RVkFzct0vVBMP0QnwyEDZOjB95TPuwPM0SMBe53k+BMery/3/ZQeJEjGCN0oIBcWJZPiqGVlqpCBwfUueuVx6WFhaXO1biUV7qin1aDmsb/OFJOHKsCgljZ6+9LWPhDWK3zV1buXOhxzkRzwjF0xWREHDsYwpxFDEN68FZSR6mwU0OAAHIlkIDBe8/i4cE7VfC1t0tAapU1M8+ivxnf6P2rHhrYsJsy1QuvfJMT2lWhusMpIQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0a7aa3-fd93-461e-a485-08db9f759907
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 22:59:23.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5SGBWEAmyqVnFYYshEbq/qdl/56X+XonfIQx+xwdJFeDRjCV2UWOxePsIag9bFeRRqyu6Dsji2FIEeh9T+eLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_18,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308170204
X-Proofpoint-GUID: aWuo_LiHQFCzgIQcIINGGfE8uxEeqUVt
X-Proofpoint-ORIG-GUID: aWuo_LiHQFCzgIQcIINGGfE8uxEeqUVt
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 8/17/23 3:23 PM, dai.ngo@oracle.com wrote:
>
> On 8/17/23 2:07 PM, Jeff Layton wrote:
>> On Thu, 2023-08-17 at 13:15 -0400, Jeff Layton wrote:
>>> On Thu, 2023-08-17 at 16:31 +0000, Chuck Lever III wrote:
>>>>> On Aug 17, 2023, at 12:27 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>
>>>>> On Thu, 2023-08-17 at 11:17 -0400, Anna Schumaker wrote:
>>>>>> On Thu, Aug 17, 2023 at 10:22 AM Jeff Layton <jlayton@kernel.org> 
>>>>>> wrote:
>>>>>>> On Thu, 2023-08-17 at 14:04 +0000, Chuck Lever III wrote:
>>>>>>>>> On Aug 17, 2023, at 7:21 AM, Jeff Layton <jlayton@kernel.org> 
>>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> I finally got my kdevops 
>>>>>>>>> (https://github.com/linux-kdevops/kdevops) test
>>>>>>>>> rig working well enough to get some publishable results. To 
>>>>>>>>> run fstests,
>>>>>>>>> kdevops will spin up a server and (in this case) 2 clients to run
>>>>>>>>> xfstests' auto group. One client mounts with default options, 
>>>>>>>>> and the
>>>>>>>>> other uses NFSv3.
>>>>>>>>>
>>>>>>>>> I tested 3 kernels:
>>>>>>>>>
>>>>>>>>> v6.4.0 (stock release)
>>>>>>>>> 6.5.0-rc6-g4853c74bd7ab (Linus' tree as of a couple of days ago)
>>>>>>>>> 6.5.0-rc6-next-20230816-gef66bf8aeb91 (linux-next as of 
>>>>>>>>> yesterday morning)
>>>>>>>>>
>>>>>>>>> Here are the results summary of all 3:
>>>>>>>>>
>>>>>>>>> KERNEL:    6.4.0
>>>>>>>>> CPUS:      8
>>>>>>>>>
>>>>>>>>> nfs_v3: 727 tests, 12 failures, 569 skipped, 14863 seconds
>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/124
>>>>>>>>>    generic/193 generic/258 generic/294 generic/318 generic/319
>>>>>>>>>    generic/444 generic/528 generic/529
>>>>>>>>> nfs_default: 727 tests, 18 failures, 452 skipped, 21899 seconds
>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/186
>>>>>>>>>    generic/187 generic/193 generic/294 generic/318 generic/319
>>>>>>>>>    generic/357 generic/444 generic/486 generic/513 generic/528
>>>>>>>>>    generic/529 generic/578 generic/675 generic/688
>>>>>>>>> Totals: 1454 tests, 1021 skipped, 30 failures, 0 errors, 35096s
>>>>>>>>>
>>>>>>>>> KERNEL:    6.5.0-rc6-g4853c74bd7ab
>>>>>>>>> CPUS:      8
>>>>>>>>>
>>>>>>>>> nfs_v3: 727 tests, 9 failures, 570 skipped, 14775 seconds
>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/258
>>>>>>>>>    generic/294 generic/318 generic/319 generic/444 generic/529
>>>>>>>>> nfs_default: 727 tests, 16 failures, 453 skipped, 22326 seconds
>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/186
>>>>>>>>>    generic/187 generic/294 generic/318 generic/319 generic/357
>>>>>>>>>    generic/444 generic/486 generic/513 generic/529 generic/578
>>>>>>>>>    generic/675 generic/688
>>>>>>>>> Totals: 1454 tests, 1023 skipped, 25 failures, 0 errors, 35396s
>>>>>>>>>
>>>>>>>>> KERNEL:    6.5.0-rc6-next-20230816-gef66bf8aeb91
>>>>>>>>> CPUS:      8
>>>>>>>>>
>>>>>>>>> nfs_v3: 727 tests, 9 failures, 570 skipped, 14657 seconds
>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/258
>>>>>>>>>    generic/294 generic/318 generic/319 generic/444 generic/529
>>>>>>>>> nfs_default: 727 tests, 18 failures, 453 skipped, 21757 seconds
>>>>>>>>> Failures: generic/053 generic/099 generic/105 generic/186
>>>>>>>>>    generic/187 generic/294 generic/318 generic/319 generic/357
>>>>>>>>>    generic/444 generic/486 generic/513 generic/529 generic/578
>>>>>>>>>    generic/675 generic/683 generic/684 generic/688
>>>>>>>>> Totals: 1454 tests, 1023 skipped, 27 failures, 0 errors, 34870s
>>>>>> As long as we're sharing results ... here is what I'm seeing with a
>>>>>> 6.5-rc6 client & server:
>>>>>>
>>>>>> anna@gouda ~ % xfstestsdb xunit list --results --runid 1741 
>>>>>> --color=none
>>>>>> +------+----------------------+---------+----------+------+------+------+-------+ 
>>>>>>
>>>>>>> run | device               | xunit   | hostname | pass | fail |
>>>>>> skip |  time |
>>>>>> +------+----------------------+---------+----------+------+------+------+-------+ 
>>>>>>
>>>>>>> 1741 | server:/srv/xfs/test | tcp-3   | client   |  125 |    4 |
>>>>>> 464 | 447 s |
>>>>>>> 1741 | server:/srv/xfs/test | tcp-4.0 | client   |  117 |   11 |
>>>>>> 465 | 478 s |
>>>>>>> 1741 | server:/srv/xfs/test | tcp-4.1 | client   |  119 |   12 |
>>>>>> 462 | 404 s |
>>>>>>> 1741 | server:/srv/xfs/test | tcp-4.2 | client   |  212 |   18 |
>>>>>> 363 | 564 s |
>>>>>> +------+----------------------+---------+----------+------+------+------+-------+ 
>>>>>>
>>>>>>
>>>>>> anna@gouda ~ % xfstestsdb show --failure 1741 --color=none
>>>>>> +-------------+---------+---------+---------+---------+
>>>>>>>    testcase | tcp-3   | tcp-4.0 | tcp-4.1 | tcp-4.2 |
>>>>>> +-------------+---------+---------+---------+---------+
>>>>>>> generic/053 | passed  | failure | failure | failure |
>>>>>>> generic/099 | passed  | failure | failure | failure |
>>>>>>> generic/105 | passed  | failure | failure | failure |
>>>>>>> generic/140 | skipped | skipped | skipped | failure |
>>>>>>> generic/188 | skipped | skipped | skipped | failure |
>>>>>>> generic/258 | failure | passed  | passed  | failure |
>>>>>>> generic/294 | failure | failure | failure | failure |
>>>>>>> generic/318 | passed  | failure | failure | failure |
>>>>>>> generic/319 | passed  | failure | failure | failure |
>>>>>>> generic/357 | skipped | skipped | skipped | failure |
>>>>>>> generic/444 | failure | failure | failure | failure |
>>>>>>> generic/465 | passed  | failure | failure | failure |
>>>>>>> generic/513 | skipped | skipped | skipped | failure |
>>>>>>> generic/529 | passed  | failure | failure | failure |
>>>>>>> generic/604 | passed  | passed  | failure | passed  |
>>>>>>> generic/675 | skipped | skipped | skipped | failure |
>>>>>>> generic/688 | skipped | skipped | skipped | failure |
>>>>>>> generic/697 | passed  | failure | failure | failure |
>>>>>>>     nfs/002 | failure | failure | failure | failure |
>>>>>> +-------------+---------+---------+---------+---------+
>>>>>>
>>>>>>
>>>>>>>>> With NFSv4.2, v6.4.0 has 2 extra failures that the current 
>>>>>>>>> mainline
>>>>>>>>> kernel doesn't:
>>>>>>>>>
>>>>>>>>>    generic/193 (some sort of setattr problem)
>>>>>>>>>    generic/528 (known problem with btime handling in client 
>>>>>>>>> that has been fixed)
>>>>>>>>>
>>>>>>>>> While I haven't investigated, I'm assuming the 193 bug is also 
>>>>>>>>> something
>>>>>>>>> that has been fixed in recent kernels. There are also 3 other 
>>>>>>>>> NFSv3
>>>>>>>>> tests that started passing since v6.4.0. I haven't looked into 
>>>>>>>>> those.
>>>>>>>>>
>>>>>>>>> With the linux-next kernel there are 2 new regressions:
>>>>>>>>>
>>>>>>>>>    generic/683
>>>>>>>>>    generic/684
>>>>>>>>>
>>>>>>>>> Both of these look like problems with setuid/setgid stripping, 
>>>>>>>>> and still
>>>>>>>>> need to be investigated. I have more verbose result info on 
>>>>>>>>> the test
>>>>>>>>> failures if anyone is interested.
>>>>>> Interesting that I'm not seeing the 683 & 684 failures. What type of
>>>>>> filesystem is your server exporting?
>>>>>>
>>>>> btrfs
>>>>>
>>>>> You are testing linux-next? I need to go back and confirm these 
>>>>> results
>>>>> too.
>>>> IMO linux-next is quite important : we keep hitting bugs that
>>>> appear only after integration -- block and network changes in
>>>> other trees especially can impact the NFS drivers.
>>>>
>>> Indeed, I suspect this is probably something from the vfs tree (though
>>> we definitely need to confirm that). Today I'm testing:
>>>
>>>      6.5.0-rc6-next-20230817-g47762f086974
>>>
>> Nope, I was wrong. I ran a bisect and it landed here. I confirmed it by
>> turning off leases on the nfs server and the test started passing. I
>> probably won't have the cycles to chase this down further.
>>
>> The capture looks something like this:
>>
>> OPEN (get a write delegation
>> WRITE
>> CLOSE
>> SETATTR (mode 06666)
>>
>> ...then presumably a task on the client opens the file again, but the
>> setuid bits don't get stripped.
>>
>> I think either the client will need to strip these bits on a delegated
>> open, or we'll need to recall write delegations from the client when it
>> tries to do a SETATTR with a mode that could later end up needing to be
>> stripped on a subsequent open:
>>
>> 66ce3e3b98a7a9e970ea463a7f7dc0575c0a244b is the first bad commit
>> commit 66ce3e3b98a7a9e970ea463a7f7dc0575c0a244b
>> Author: Dai Ngo <dai.ngo@oracle.com>
>> Date:   Thu Jun 29 18:52:40 2023 -0700
>>
>>      NFSD: Enable write delegation support
>
> The SETATTR should cause the delegation to be recalled. However, I think
> there is an optimization on server that skips the recall if the SETATTR
> comes from the same client that has the delegation.

The optimization on the server was done by this commit:

28df3d1539de nfsd: clients don't need to break their own delegations

Perhaps we should allow this optimization for read delegation only?

Or should the NFS client be responsible for handling the SETATTR and
and local OPEN on the file that has write delegation granted?

-Dai


>
> I'll take a look.
>
> Thanks,
> -Dai
>
>>
