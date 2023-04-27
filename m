Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1F26F01AE
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Apr 2023 09:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243022AbjD0H1C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Apr 2023 03:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242961AbjD0H1A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Apr 2023 03:27:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867B946AB;
        Thu, 27 Apr 2023 00:26:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R6Hx3X022581;
        Thu, 27 Apr 2023 07:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/ckUezRte0ScCFIFGTBzTRKBbp9RgEO8CqnOF+U2nrE=;
 b=GD7ZvWTOBD7CrQK+Lp3A9Rcx8YQQglvcH/FFpi8N/LENMv7oG+iTSsEcxYIOrdIKyj72
 oqDqqPHCDz5CnaRpn8n4KD5MCsdZGIJ/IPn1xuJ0ChpoU7YVFOIbyBRVFGmwuzCBaabq
 LWCaZcR2J12ID1nlk7tJ8U/oPmlgYPg49qWT9IKsX6/Nm7LIsPIzBgSGKgEW1IjGUCHZ
 1L19NEkk+PF3sePJzsYVPVy7QNqciN0e5mkBWNX5uD6cI3Dal6HqbpAgVH87I5Bkq7wZ
 A3WNoSoFY0LW+tDXa2pzHp0IxqbQKwg+DzYT4bLexaEpssP1ZQ1f2bJbGbWxO32fK3/G rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fau5jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 07:26:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33R60IRd025092;
        Thu, 27 Apr 2023 07:26:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461f8a9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 07:26:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er+skNJ7+1to2Vpytuz++FnKZjOwXvfp8s5C7UYsY4KxnVtaRHKAtR7qG0W3s4Pt2dRvKMp9ItaLzKV2krQ4jCbLMlKFPNiZ2HUKRA22phGkyiyq8madIYkrSc+ih6oz4fAEk78Uf+XFjXTyVM5kkGHfUrFYMXSYOi2b8N/HviKZkg2gverOpWWnkj352zWAfRjSJLIFmCvnBT0/rFwDCWR3LwCom7ytJXwBG0kq12HubaB2uO11eqOGz2RQPwsUfP7iwPHKQTDx4eVSJIud+cHiuDTok5wBqbgCIz2iHcnDi2h1+YRRmGZky2f+R0n4HRt221mz+Lge96HEUp0djQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ckUezRte0ScCFIFGTBzTRKBbp9RgEO8CqnOF+U2nrE=;
 b=mQiX4iO66jrYIrCYIIJT3BHmQaWJCX8nHRouLm/fuQq0L3leGxTw0oZPYrZa6L1v2J3UaNx6FegxWu2Lhoht+EWsQMI849jWXyTOkMUvYhZkFczXu7m3gZkSzbw3fmS3O9ZnwFqPyaPZjQlMsYsPBpUEYOnK7mllYuIo1owkTaGwTSJSyGUE0QewdombzhF6tWq6ohfx08dPo1Pd9eH3axwqh/Bcb9LaQMfbzucTRqLPjSj1iLvnlZVhqLpFvOU23lga8z7Qmr64WtwksIiO3jQQdg7x9cz9fyR31QWDXEr67KP8oOKRTnjAo88w1qZq9FtstpeTLrA7xbtcbhY2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ckUezRte0ScCFIFGTBzTRKBbp9RgEO8CqnOF+U2nrE=;
 b=dWQvl1zhCUOeVXEVx5bIRXcLc7ONHQf9yYip+wz4hTBJkrEHkZCYYDGiDEqvbChLIQU7qA3OCE64c0FRzUxGk6WiKTi1mGcEm8ytgt2m+79WC214fBjA87N2xpCXePfG8Eud4Uk5bMBv/2a/QjX+Q7Ho43ut1DhV4508tD+twuM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ2PR10MB7600.namprd10.prod.outlook.com (2603:10b6:a03:543::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Thu, 27 Apr
 2023 07:26:47 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 07:26:47 +0000
Message-ID: <4a2a77e8-857a-9ca7-5594-15d1004e7d9a@oracle.com>
Date:   Thu, 27 Apr 2023 00:26:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: "[PATCH] nfsd: rework refcounting in filecache" caused
 nfstest/test/nfstest_delegation stuck
Content-Language: en-US
To:     "Jie Zhou (Fujitsu)" <zhoujie2011@fujitsu.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        "Mora, Jorge" <Jorge.Mora@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6e287adf-25bb-3c62-c390-e642488aaf5c@fujitsu.com>
From:   dai.ngo@oracle.com
In-Reply-To: <6e287adf-25bb-3c62-c390-e642488aaf5c@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0036.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::21) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SJ2PR10MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 718e7c1e-1373-4acd-b301-08db46f0c2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hZ4P0nFPT2FmPum1vYnv2X0gxx/meq4ph1abZPQfr5tbEFaIlgOvlogs7olL3bPjyFaovfiTjcL1nc1W/XQUn57mF8K1O+47Lr9lp/QfuHWO+nfVISI0GEFDlBcQKN9Y5mwxrfPiPsz1GDA3mhpLW8n2/Eck/He1YpeIRo5/0stG3qvyFm9uiWDFhLsZt/AHSwY7OsbuGwBdDEdRjHCHcbWXGzTq/37LBksdfDxdI1bCqseHihXrIEpotYC4YZCdnFjiPAdrWxcn2/PjQQaowuHyvDwhNPrz7OumJDjiJvqpl0eZsyyPcNRrX4dOoN095XVEVMCqeLs70RTZKltf76ygR2eAAi+MUFgKIkD9grUaxrIFk34SM86BBAQOffao3ha/7IPv7Cbcupz3Q2pP31cCApi9hadMjnXSGgrH+834hGGV+xnOrygAnRbCgsfkVHu0aycoWKha0UWQjEZIwYR2Fw/M7RKQNdXFJgJ1+kJKFBLfM9kzlIXf2Ls5kHKs2EgMyGVe84adv99b/biH0vcrPY8ggHJGj1CF3Dm9tqP6fGHbXGBPfhB11zSMyXtriGxNOjOP9qzZSnJstxx1wCUSI4OyorLcq05OLz7MIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(26005)(6512007)(41300700001)(5660300002)(186003)(9686003)(2906002)(31686004)(6506007)(54906003)(53546011)(38100700002)(110136005)(8676002)(478600001)(2616005)(8936002)(31696002)(86362001)(83380400001)(36756003)(316002)(4326008)(66556008)(6666004)(66946007)(6486002)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzQ4VytORm9YQ2thRmpYaWV1UDQ0d2RDS2c5VG9lZGFsbjhUQ240cGtkamdk?=
 =?utf-8?B?VDUzR3E4ZW1Nc2NGM2VncmgvSUhuRUFtUlRqcGdFTWc4VDQ2eUdZbnhUSDM5?=
 =?utf-8?B?azlmUk5RMjVDUnFkNG9mV0FnUC9qM05KUUNETk1Ya3oyQ3pXQituYk5WMlE3?=
 =?utf-8?B?d2RIdkw1WkY2VDExTHhIdnJhRDQxS1lvWUhYcWV1c3dYOFNKRWtuc2NvcVoz?=
 =?utf-8?B?ekI2TlVYK2hTV25yTXZad1FjL3lTdDJDZGFJdHVSa2VJdWlvSytSR2lNbk5S?=
 =?utf-8?B?SFNoeHc2Qm5UREdIaTczQ0VNdmFzOU1NWWVZa0pkazFmZjVkUm1QU25xZkFO?=
 =?utf-8?B?OElPeWVBZitrMEZvL3QrQVFETVFQL1VzbGxCaHVjSnZObWNaallDYUV3c2hZ?=
 =?utf-8?B?dTA5ZW1ydTlkdG1FS0MydTNLUkU3Q3A2NURqRVZyYjBBcCtrbE9YVEswSDBH?=
 =?utf-8?B?Y3ZES1BFWkUzYUVsRDBUcHRVU2dENmRhT2gwdFJrWnV3TStsTUtxbXovZDEy?=
 =?utf-8?B?RWZLbnpyZnVZSzVWV01xM1BWc2piRDJ4RjhrY1RuWis0UjZnZ1ZFb0RhR1NE?=
 =?utf-8?B?Ykx4ajEvbzJYMEQ0ZU9iRENEbkFjMFhsNS92ZjNubmd0Yi84RFNNR1RWbGxX?=
 =?utf-8?B?aTg4OC9kQ1Y2WUlYazRaMk5iVU9VeDJkMU9PaUU3NnA2Qi9YZ3hNWUprTGI4?=
 =?utf-8?B?S0tmTDZPdWMvQWR4MEc3NWFoVlE2UDNhRU81eUZMdHVUanlSaFIzODVRUUQ2?=
 =?utf-8?B?R1M0azJNcUU4VTBhOEdnWVRHY3VMRWN5eXV4OExzV1JHb0VEYndDUEZueXBr?=
 =?utf-8?B?UlgzRVp4RkVvZ3drR1dmd1VyWHc1S2V4QitpLzJDZEI0MG1nS0s0UE1SY1lV?=
 =?utf-8?B?TmZNbXRyNEZnMGlWbG1scDZtMlFsa2xpb1V0b2x4cEdkOGVjSXhkeHQxQ0xw?=
 =?utf-8?B?MWtrbUpWTWRrNDNWWWp5Ui9Sc21rUXNrckt5d2JCYi95Nk9UeHFlbmVZVUFN?=
 =?utf-8?B?YXdqTU1qRXZaSjRIWlQ5WFVaN1hac0RveU5CUHlIaHh4TnNKUFhxVTgzOGp6?=
 =?utf-8?B?WVNoamUrVllxWCtqdlhkTHpldll1N0txQXlpdzhMUXlNSTV3bTBCcXd3ajM5?=
 =?utf-8?B?R3NCOHIyVFRBWXY0alI0ZUlHeDlxMUlHdDJPbVBnTVFPVjdyRCtJNlhEUDJa?=
 =?utf-8?B?S2I2TkxFWjNRTVpreTFYOWxDN2ZpcXhvL2F6ZEpWS2hTWUxBRkNpQnVRclgx?=
 =?utf-8?B?aFlhamJWVHpkMDVSdEFOMWFkZ3BreDZVRzUzSStOOUN0Wm4wbldnK2F6cG0z?=
 =?utf-8?B?NTRUeDdEaGxzME1pZWhSYmJMenh4b3cxaGdOVUJNNkZyU1NqWFlnbU9VbEhz?=
 =?utf-8?B?QzY3cmdyK0ZPWU41ZERBR2FJZnN5ekpCUFg4d3dXZHRUcEFodTJjeDB6aWRo?=
 =?utf-8?B?dkRFQk0xeVQ3RjQwdEpOcnBrRlpiU3p1L0tVYTYzeFc5bUtVaUlSbWdteDR5?=
 =?utf-8?B?eEJ6a2pFMEdNUGhCM0NBSDlnUW1wWXREWGllZkd2WDl4SUFEbC9mdE5zZXpM?=
 =?utf-8?B?c2xVaG9sYWpWWnlIcGhFVzAxWE9rNDVBeFdiS2phZEo1dmE2eEM0cFVMclEx?=
 =?utf-8?B?S2gvRlJxaVFqU3NoYU9vdVVxNXdxNDJXc3lXNEZPS2pYVXhWeVNEajdJRDcx?=
 =?utf-8?B?dkFvRkpXb1J5eERwV0VtT055VkFMOUk1KytFTnBtTXo0KzllaUtuNXF2SmFh?=
 =?utf-8?B?YTZCdTVFdTZzTzR1bFh3R0IrSHFJRnJIWUYwU05YY3FYU3RURjEwK2ZYQ1Zt?=
 =?utf-8?B?SEhMWC81THNWem5UTVBnWm5SV3JxSTBTUHM0SmZ5SGloSjdBazJmRFloYlY1?=
 =?utf-8?B?M0xtYnhxbUFOVzVWN0VaSDIvT3FRaTB2UWdhWjc2RlpYcUpueU5OcVUvVFM1?=
 =?utf-8?B?enJJTFhVaVEvNWd4Rzl5ZEJBbGEvTUc1aTBkMnFEbkxNajlINkhKWk4xUlgx?=
 =?utf-8?B?M2xGZE80aDV1QVNZb2pOVmZBY3NkZWJKSWREUzBvTU54aS9kdDQ3STg4SnRV?=
 =?utf-8?B?QjJTVVpmbmNzVVg0cXFiMU9XbDVHcXpqZWkvdSt4Nk5DOEtZZEludG1zaVU4?=
 =?utf-8?Q?M4WBx6wWD9niWXLa5RRpNRiHG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OgYVg4rQ8XIUGdli0wTLDK/O8qzgXUQuLyDwjzXOs3EHH4M0aW6JsNWIhZRqvL/hSosQ2sK/35KLIMf/K/pJe9vv1E52L5sI1WoGQRV+5HpJgBjaje2KhbYekA1Um5IDFkYkO/gNaawdN8IR3aoMOrXgG+VTrokH5+1NoN97i+qWXEqDvA25HWNohPy8PyyrLG/sxfPsrVoeP5u5pi3LrYNHsXMO/PT/VIWNqNtg/fYXzNtrzCmJciEnOFud/cvPaHliCHQ6HEc2WC6VIUZEhn4XZM1aIoJMuOVtPLHsXDpc5r5zVGKCzZ310Vt9K6gDc2GkVHdyR6SH9KtYQ5rvowNNx9v3xj4MS2yMAPq1FGJM6rrZEnB97F+tSxO7+F3X+Qt0k+sLV9aMlM2vP5K3D0qup4QNQf3b67B4EOqrqe7pXYqk4UJNXLN92Z/oOjjY9G1ZE7ON1w15ULOwRZ6z+X4AEoUe0XN0Clhg3R2+XFhPLLt3zkDwLmr7DJnId88hI4RIurGOhBefsHUaHDPNSo234HxXEjMIMVbL8JLjaQ67Tqz/9dkZnOazMQE0q/lAyxQTZ4IyHRe2ctn2vBMDgdF0q+WmWx5tF+yt7eWZJBm/e0l4y8Krcpb1Sos5SgXYKf5YU6i2VbJ7mlEvhon2AE8zRr2fwHA8pxCEPai0SF8wCnhcpvkWJwSW1vavleEtwQAhDztAbWolKN868e1ze/hAR5QhEj8Zzh7O27X18wp+bx1UHRKu+U8M5aIXIfsn8zx+X3+JRFhtlM8XCbiJNreqjVmq2D4OALmrs2Mu0xUCXDEuP3kQ/MXKt6WMh6v1yw7xgHFOxYhZ/y+IFfr6bnW41GEEQNbXtvjZOft4EH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718e7c1e-1373-4acd-b301-08db46f0c2ad
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 07:26:47.7869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1onioEn/w2SizdJwUbjpVZkSMngZILcOP5IwTdGd2ySdzivdkY5w/lGYq+zXOUCIjitgMij/5JYCuXBeFLmGcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_05,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270063
X-Proofpoint-ORIG-GUID: j-uKYtxMGb6hZCpmKW_fLDX-eT1XaXmI
X-Proofpoint-GUID: j-uKYtxMGb6hZCpmKW_fLDX-eT1XaXmI
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This problem is fixed in nfsd-next with this commit:

119437271d94 NFSD: Fix problem of COMMIT and NFS4ERR_DELAY in infinite loop

-Dai

On 4/26/23 8:50 PM, Jie Zhou (Fujitsu) wrote:
> hi,
>
>      Download nfstest program from
> "http://git.linux-nfs.org/?p=mora/nfstest.git;a=summary".
>      And run following test command and stuck at recall12 recall14
> recall20 recall22 recall40 recall42 recall48 recall50.
>      ./nfstest_delegation --nfsversion=4.0 -e /nfsroot --server <server
> ip> --client <client2 ip> --trcdelay 10
>      test OS: RHEL9.2 Nightly Build
>
>      After I bisect linux kerenl, found that following patch caused above
> bug.
>   From ac3a2585f018f10039b4a856dcb122da88c1c1c9 Mon Sep 17 00:00:00 2001
> From: Jeff Layton <jlayton@kernel.org>
> Date: Sun, 11 Dec 2022 06:19:33 -0500
> Subject: [PATCH] nfsd: rework refcounting in filecache
>
>      Run following command at different kernel version.
> ./nfstest_delegation --nfsversion=4.0 -e /nfsroot --server
> 192.168.122.153 --client 192.168.122.152 --trcdelay 10 -v all
> --createlog --keeptraces --rexeclog recall22
>   >nfstest-delegationv4-log_recall22 2>&1
>
>      The following test result are attached.
>      kernel:
> commit 0cfd8703e7da687924371e9bc77a025bdeba9637
> Merge: 793582ff47f8 d3f2c402e448
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Tue Apr 25 18:44:10 2023 -0700
>       Merge tag 'pm-6.4-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
>      result:
> test program stuck
>      log:
> nfstest-delegationv4-log_recall22_6.3.0
>
>      kernel:
> commit ac3a2585f018f10039b4a856dcb122da88c1c1c9
> Author: Jeff Layton <jlayton@kernel.org>
> Date:   Sun Dec 11 06:19:33 2022 -0500
>       nfsd: rework refcounting in filecache
>      result:
> test program stuck
>      log:
> nfstest-delegationv4-log_recall22_ac3a2585f018
>
>      kernel:
> commit e78e274eb22d966258a3845acc71d3c5b8ee2ea8
> Author: Kees Cook <keescook@chromium.org>
> Date:   Fri Dec 2 12:48:59 2022 -0800
>       NFSD: Avoid clashing function prototypes
>      result:
> test program stop normally
>      log:
> nfstest-delegationv4-log_recall22_e78e274eb22d
>
> best regards,
