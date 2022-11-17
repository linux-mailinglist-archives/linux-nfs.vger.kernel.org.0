Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE0562E4A9
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 19:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbiKQSnz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 13:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240509AbiKQSnr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 13:43:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC1778D5A
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 10:43:46 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHHsmkY028278;
        Thu, 17 Nov 2022 18:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ipnYKHunMSoDC9eJs+CYHGKiYY+bMfTWeWxdinWKqNI=;
 b=YpEZ5bmXIOOta7is6HjtrhiYb4G+LpbJ3BxjoVva1zb3rX9lCRh7JpwpLt428OJGOAyM
 IGI4SoA4Dik4kN47QXFxpOGE26leSSf76urDoRuFplu57kWLqS1D6K+FS6WgGX+HIUk0
 tx+o2IDFQ1B0ULmgnlB7zTegYRgpQ6y7LmEATEG+DaR+bNLEeXy8BD1Yo1iLtxSRoCcB
 QmbcwJ4EdzNtADnneETOxhOD5zt/L23fshfWLlRLkt46UilJXQOjwAUHPE/K4iR9CsSP
 LcGlL4pimrKqgav1X0ARqOsIv713Dp6OImFagYF45fUDfFpD6/iCOvBd4GNVoWXHbW86 2w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8ykt21r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:43:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHIYhoc034428;
        Thu, 17 Nov 2022 18:43:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kw2ddy2gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:43:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0cF2xIY9MPf9uxBDmWpS3kZGfO1OsG6gaOGWIWF6/f6v0E7/rCxiVbv3COe95kmXG8hZlZiSHYWsad7fZ892ttecD30kaaRNc5hW4a1F92pRJp80Z/IwNMPbOt+g6IdB3B3RBhXE+gGW2io7y2FWG3lXYKwckd4wmUSjYQiYE44Za3KIS3hp0xjBtfmGp7ZnGCeb7rxr4+k9YG9L+vBplxRZTQEHfTOehk1JVKcDe2Mblc+9rlZNe6HeX5poUFRWA0Neoz5jTmCZaqUgVMGDxFIc6QzD1otDbrLipnIDdZgNbEJmJwj0p51cJeatdEIGw0t2H4KfvNuqYcZnBM8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipnYKHunMSoDC9eJs+CYHGKiYY+bMfTWeWxdinWKqNI=;
 b=S/4MLkaIcEgldZ7CQ9IlrdGrpiWI/dUl/dG4MjowxZ0Kh6uJ/E+pVD8D7lbAyJuddUSf8ucJOwSB/m3t3saF10L43r01fQsxm1FaIzfd1o9P5q1tO80CF/HS5bf6ioCOBdJffB3RedjjX5w/055qf/nSZ9PT0C0+xRLGMtba5cCYOfNDqx3wc17tA/Y7LUz9PffUF3bSieobHqKQLF8+ZmVvbl8FkLpbplqOhZbLKF0KIZtbt3lDmWWl26a76hpPD960kEwbREgln9yrJyZONGYXL9pSoTIh6X4d084ITKZnV6xt9B09qKQrk3HuX1l3WaradIyZYpDfQq24azJYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipnYKHunMSoDC9eJs+CYHGKiYY+bMfTWeWxdinWKqNI=;
 b=rFy8f5PxnoGugdnxjzSHIfXARuJMbJZELxrOZdNWTpXaXpHX8Nf2QwY+XNIpEWn3y9azfL34BnqqVb0t2RRuCWRq7y5BedSAUMHG/QH/XpGQ7XNCEZnGVThbR7O37k3GchRZY+HdQn22pmZC3Q+5XseRoqKaP8IU5a0+Xz7q31o=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BLAPR10MB5233.namprd10.prod.outlook.com (2603:10b6:208:328::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 18:43:38 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2d62:ce4b:356d:e242%8]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 18:43:38 +0000
Message-ID: <7834d4f4-47a1-f503-902f-fe33f35a10c6@oracle.com>
Date:   Thu, 17 Nov 2022 10:43:35 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/4] add support for CB_RECALL_ANY and the delegation
 reaper
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
 <8517F18C-9207-4DE4-A217-2A0EA4C4484C@oracle.com>
 <7ee9c36b-b3d8-bb84-36bb-393eaa2369f2@oracle.com>
 <A5796183-BE7E-4B05-A620-4BC76A2608D1@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <A5796183-BE7E-4B05-A620-4BC76A2608D1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:805:f2::22) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BLAPR10MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: e408dafe-d5b5-4c88-fd35-08dac8cba410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eK+wZCbcIJYn5n8rd9cVdKetiJgVRW+ZrhDVZM8sPlAFsKviWz4EfWUjbIXTr1lL4TuRGnirJQpzZeHGGHN2UjOjW8cb3MyPc7ob9Rho1Zlp6LVmDvfJxJ/qeU6i1yeCZOYV4VKaJNKIcyj2Q1UMSLu1FhLmf2ojhUfPwhYSbYn16PKw11RWQjhjm0K0d1OC0iiqv96Pn7Y3/6i8xyN5sYMXiKe32xgVG5XyMTmgKUbmip1da3PTJfTYqiUyhLyFlrG+WIGwsQhRuUAMuSsreO+joC/sbTc7xt7Q90t1TRmrbCzzOfRSMEx6nieTbUeMfpQ9JZQX4BZ1HroHu7yrO9b3gIO7lGiwhMS0chB6I1q+52oDjo2co3yBDZoIWZOqIHoP2K0MHkdYhu1MRRuF4yjENtukQ1Jrnfu7Ipdih/lkHJKgTzx88PIMuXtK0YfZpvIz+tmfz3iB8YBtwSwvbR/SyDP9qxfhxCPj4d7J4auw4N0d+xcLkpieKWWHR/DHoPnF/NZiJvJo+LH0yiweyr9XyxY6anhaylzt+rDWqd731JrMzw2bp0ZKQLA3pMjjmmcil8IIpwQg4UPrBmfLBQOoXwzO+RvOAziQhI5bn/orirosG3vXcAYX9c/8L7KGtXUEPLYt4HGERhPwSbUQaq+MGikZhDJyZO0RXorvC6nkiDNOIz2ZkMdZTpAAsWVh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199015)(2906002)(38100700002)(186003)(31696002)(86362001)(83380400001)(66556008)(6486002)(6512007)(478600001)(26005)(9686003)(5660300002)(2616005)(6666004)(53546011)(54906003)(66946007)(66476007)(6862004)(8936002)(8676002)(41300700001)(4326008)(316002)(6506007)(37006003)(31686004)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEk1YWZ1K2ZQbmtGbVRrWUdWM3lyaDBCNHdlYjgyMVppMk9VZUgvM2xSUzZp?=
 =?utf-8?B?Q1BHMFYvVTVpbzRaL3lEbUx6RWJrdjNLWEdtZ0VwRXBXM2djMktSTXV5SzZ6?=
 =?utf-8?B?V0N4Y0NaSDdKS29Zb2YrY0FCZ3B5dTVyV1h1dG5sN1NYVmczUjNJQVBSWlRx?=
 =?utf-8?B?enlXNGJTUnFMTjEzRUtlaFhkS2loVTMra0ExeXBJUmtZMTA1Yy9ldDFsSE0w?=
 =?utf-8?B?ekpBVkVjc3FyUFoyV3dyQkIyMTRyRVdHMGxkQkk0eE53UTZpN3RCMFcrNGNy?=
 =?utf-8?B?YzVDeHZ6aWZJYkRYY2FjK1oxVUhScDNiLzd5QjZ0OWJQTjJubENsM00rTmIv?=
 =?utf-8?B?Nm16NEcvSDNaRnUxUnJwWlA2T0hlWWgzWVlBM3Y5dTlyQnhzTDlmd2FFTDFU?=
 =?utf-8?B?Mkh5SUYvVmpWSnJsSWozQVRvZ3liSW81cG4zYURuL2hyTjFvV092SzhLTnVR?=
 =?utf-8?B?Z2QxZHBRZFVBMjV6NytWakFacDdvTEJ0OEcvNEhqajhQNjNGT2RIV01YZ1hN?=
 =?utf-8?B?K25rS2dMZUFlcDlOZ3pEM2ZhaWhkMkhQSnN3ak1jNTZnaGlpejhka085WnBO?=
 =?utf-8?B?dFVZNytkUVJ1U3RjaXpVWVdubjNEQkxiMWlTdm5sZlU4S2dRRmNkZ2Rtbk96?=
 =?utf-8?B?OUhKQlhaWXJxc2laeVo1YlV1SEFxcnlWb1RuekJXWlVRaGszV1Q4U1pQdEFj?=
 =?utf-8?B?eS9nYWs2TnpkVWIySVR2dkZUa2hzRFZNUzVIU2o2SldrSDNHOXR2eWRBdVBa?=
 =?utf-8?B?dXNIdGpsdHNURUJBd0tOOU9Sb0ZkWHF2SnRWcUpOK29uaW54aUlzdWQ4Rlpl?=
 =?utf-8?B?djhrbWR2eUdVdU90RFVZUWI1Sk1pZWJ5UllETDcrSjJvbzFkVGVJYXdBdHJK?=
 =?utf-8?B?NlRLc0tYY2REMXRkbDVYY1FGMzNmaXpicUNOdUR2Q0FaN1l6TzlacE5kR0F5?=
 =?utf-8?B?NjZOV010a0xhempQb09XdUlrRkxYRy9wbjgrS3NRSEN4OWltUTJEdEVmQW1I?=
 =?utf-8?B?U0g4RkpVamoydFQzUDRGN0k4dzR2T0dsVWh0dHB5WnFIcFJMdmI3Tkl5NUtl?=
 =?utf-8?B?aHNRTWU2eDJPSGJ6c2JxT01reGM2ekZZRXA1RnFZOWRYbGZLOThsUWhUMmFW?=
 =?utf-8?B?V3U0QStpVjNxc1Q4VVFmR0QvMWJPRzQrSEwzUVQ5N1pvRXBaZzgrWFFrbFJi?=
 =?utf-8?B?aVFMMjZZSm1wS3RKUXZrck1MR3d0ZjdzREg4NjJTbS9QUHI3RVRUbzZKblA1?=
 =?utf-8?B?ckJvWGFzeDBaWFNyckRCK0c4YVFzRUhiam1wTHFnek1JbnN3ckhVK25VeVE1?=
 =?utf-8?B?ZUZmRk1yV29PYkEweWZWMlRCTUhkK2V4SGlCSUJQOE5DcnlxeGRmMDQ1ZEdC?=
 =?utf-8?B?aEJ5cFgwbGFaSnlLeE03bEd3OEJTc2lSdXFCek03cDFpUUowTUZhRFYwWWdO?=
 =?utf-8?B?NGdkUHVYT3k1Z1dTVkJuN216OG84WjhXZ0RNVUJ6WjBaR0FBVGkvRW9nWGdT?=
 =?utf-8?B?bGs4Q0w2R1pGQjgwWFJGdDFDdlBVSTFsUWVsbHB3WHJ4UkJHVWVNUXQzcGpL?=
 =?utf-8?B?Uml3RXdydGhFbFFTOWZiSktwSVZFWFAzUXNyeDF2NlozbFJuUWNRYkJMQm5t?=
 =?utf-8?B?elhqRzYwamJqZll3dWNURllzYWJxVzI3UDBBLzFPQWd4eTZITm5tTi9OSHY2?=
 =?utf-8?B?MUpRMDR1WDRuZnFVMDljQzY5NUgxNHRxZ28wczUvd09IcVJFT3MrTzVoME11?=
 =?utf-8?B?aUNVQTNxVWZ0M0JIdFdBWWFHMW4zWk5ZNG1ZLytncnE5Qk9lV1lzN3Y4ZitL?=
 =?utf-8?B?RHNrYTQzRlhZVmErditZbXo2dCsvN1drODFWcEpmYjBpcjIvakhvUGt6K2ov?=
 =?utf-8?B?NEx1NmZINE9uY1JyN3Y5SU9hQVNKUzQ4S3I2eGkyZ29UdFh6eE00cTlJU1lQ?=
 =?utf-8?B?OUVkWm5aUUhtUzNsQlpKT3craTdoY3ZlQ1VLSW5tM0RjSDBvUzRlZEpwb0hi?=
 =?utf-8?B?aTZTaGwzNTh5ZENuTjQvbXZVTG0xazRUUWpoeTBEcjNlcGJqenN0ZGFPWSty?=
 =?utf-8?B?R0UvL1ZxVFhzZkl1akI0aUQwN1J3dlBBVjFvZHIxMjVyMU9DV1JQMFNBZXBn?=
 =?utf-8?Q?FWMEZn0t6JJrWLw8/o99CTyEz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: juWeJ/Pc4julei1bc3RPRRQrIaWdqOPgIONk8p+IODrn1jq7bI0AHxXUGG52uZEDddRwSP5/SFw2al2cbGrg3MDoKEs7umFdGLQdr9+kGBRrj+HV+hiZmSxL29oFqBbSPVxcqIzuoYsmTIk/9siC8a1xXmammpVNXw8Oz47op6WIfetROB/pqsh0BlAKq2Eudig3JTVtX7WzhrhkswbTo+t6TbLbaUGYWt5KRbm5szAz2y8/L8DWK6VU+9FBo+DE1fRSt/7Lk/pBGuE3B91IOfE32YR2GhKzpUEvj3X0Jsq6NrVRI8aFBKrXe+LeytZZLGI8dze0rEd88gdnNvfNHHTUn+RHvLoFtwzghEGZec4Ku0XxrGl916In55zVmiGk6Ut1HkgUvOWLhlcG8kj0xaONEhuhu8PaaN+JtcpERkttkfxXQzd/PZsn/L+AHF0H5fg04OJBJUnUicEdNXReKgQYpvQy/dC5QVmYdZUtf+EJ98IN8fvBQfSO3NOb5859W1/7uKXbfZP1QVRfksLpGF/UpcwWR8aLnPmIfy3qQKdyupp/K5MFyv23B3dPhwYTyL6ovBp45/tGDaa+EHw++ehukuEZaVNJCAhUfUHobgXphf1AMu/rDieX0+hu+TPyOgN9hVffRcJyDRSHGzWRIKDkmUzhZO5cKIsHFNqOYNyDha8yfth/nt6Fl/0IFr1azsi3D45hMYmN4KTkQeMbtXUZjeWf70dK3SYO2tOPgDVIbsIAeuHrs24v/Ngbv8wdQ4lPt89pNp4JLNwnvVT4eVMqGdWwlF9Ejwbatf/wH+g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e408dafe-d5b5-4c88-fd35-08dac8cba410
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 18:43:38.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuYhoHk9YvQ5ZxjOo0ISVlLpOUvu+FYaPTdYuzx5A46Zdx7ZbnjDFswcVgBcB7LxYUivpx/lrCo26bab84j7XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170135
X-Proofpoint-GUID: HJ-CEL3xg7fvkQ-39vRJKrxjYINah0mo
X-Proofpoint-ORIG-GUID: HJ-CEL3xg7fvkQ-39vRJKrxjYINah0mo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/17/22 9:04 AM, Chuck Lever III wrote:
>
>> On Nov 17, 2022, at 11:53 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 11/17/22 6:44 AM, Chuck Lever III wrote:
>>>> On Nov 16, 2022, at 10:44 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>
>>>> This patch series adds:
>>>>
>>>>     . refactor courtesy_client_reaper to a generic low memory
>>>>       shrinker.
>>>>
>>>>     . XDR encode and decode function for CB_RECALL_ANY op.
>>>>
>>>>     . the delegation reaper that sends the advisory CB_RECALL_ANY
>>>>       to the clients to release unused delegations.
>>>>       There is only one nfsd4_callback added for each nfs4_cleint.
>>>>       Access to it must be serialized via the client flag
>>>>       NFSD4_CLIENT_CB_RECALL_ANY.
>>>>
>>>>     . Add CB_RECALL_ANY tracepoints.
>>>>
>>>> v2:
>>>>     . modify deleg_reaper to check and send CB_RECALL_ANY to client
>>>>       only once per 5 secs.
>>>> v3:
>>>>     . modify nfsd4_cb_recall_any_release to use nn->client_lock to
>>>>       protect cl_recall_any_busy and call put_client_renew_locked
>>>>       to decrement cl_rpc_users.
>>>>
>>>> v4:
>>>>     . move changes in nfs4state.c from patch (1/2) to patch(2/2).
>>>>     . use xdr_stream_encode_u32 and xdr_stream_encode_uint32_array
>>>>       to encode CB_RECALL_ANY arguments.
>>>>     . add struct nfsd4_cb_recall_any with embedded nfs4_callback
>>>>       and params for CB_RECALL_ANY op.
>>>>     . replace cl_recall_any_busy boolean with client flag
>>>>       NFSD4_CLIENT_CB_RECALL_ANY
>>>>     . add tracepoints for CB_RECALL_ANY
>>>>
>>>> v5:
>>>>     . refactor courtesy_client_reaper to a generic low memory
>>>>       shrinker
>>>>     . merge courtesy client shrinker and delegtion shrinker into
>>>>       one.
>>>>     . reposition nfsd_cb_recall_any and nfsd_cb_recall_any_done
>>>>       in nfsd/trace.h
>>>>     . use __get_sockaddr to display server IP address in
>>>>       tracepoints.
>>>>     . modify encode_cb_recallany4args to replace sizeof with
>>>>       ARRAY_SIZE.
>>> Hi-
>>>
>>> I'm going to apply this version of the series with some minor
>>> changes. I'll reply to the individual patches where we can
>>> discuss those.
>> Thank you Chuck!
> Changes folded in and pushed to nfsd's for-next. For the trace
> point patch, I've rebased your series on top of the patch that
> relocates include/trace/events/nfs.h so that the new
> show_rca_mask() macro can go in the common nfs.h instead of
> the NFSD-specific fs/nfsd/trace.h.
>
> Feel free to pull and test to make sure I didn't do anything
> bone-headed.

I removed the get_sockaddr temporarily to test show_rca_mask.
It works fine:

[root@nfsvmf24 ~]# trace-cmd report
trace-cmd: No such file or directory
   Error: expected type 4 but read 5
cpus=1
     kworker/u2:6-2297  [000]  1349.863391: nfsd_cb_recall_any:   client 63767ac9:adb1a3fb keep=0 bmval0=RDATA_DLG
     kworker/u2:0-8698  [000]  1349.869652: nfsd_cb_recall_any_done: client 63767ac9:adb1a3fb status=0

Thanks,
-Dai

>
>
> --
> Chuck Lever
>
>
>
