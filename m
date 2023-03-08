Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA5C6B11B1
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 20:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCHTF3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Mar 2023 14:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCHTFH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Mar 2023 14:05:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2DDD00BE
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 11:04:31 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HiZrV010463
        for <linux-nfs@vger.kernel.org>; Wed, 8 Mar 2023 19:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JLcpEwwV9jmuXfoiy7B1e6c1p+HKaJIWJ8kGTtAVFNw=;
 b=wCnkQo1Mgt2xAGm8XQO07VhLK9P4XYmkP5EJHkgg2AlcrBO6X2w8cah5ujaL3gQ3W5by
 Q1RlKIi6SMXaPGsZ4FfsIJ2Xdqi/POvqavmoK2XIiZfuV7JXXhp6FJwLJHRVAnr4PSZV
 KaKg/fY8pCyRc37hfCY3HBD7UPGOgzKLOIm++0PtgBKTAC3VzNh3aAHhMF7fb5nLaCbg
 URiI+DkSE5LuRn2Vsxi3TYM/qq6uj9KUJDm4WWigxS1GXn3FIuKcFdK/QQIjKR/BUOMM
 YyBwvClEJ4pyZiSd5h7T8t4TVEMwYwbdvbJiz8vSjneoTYD4ngBhp7QVeOQyz1osE3az qQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wrxp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 08 Mar 2023 19:03:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328IO9CY007124
        for <linux-nfs@vger.kernel.org>; Wed, 8 Mar 2023 19:03:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g4g5kue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 08 Mar 2023 19:03:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXaPRRPMqenrep8E5dK9M1rd67MQniJbblBuO+38U2pR0Eitezq/yZTChX4IekXDTZrY3rUbAmNXkhUvaOk+q8BqtzTINjzV2L1YwCem5AB39mDgCPoCaauP4R3Tp0yzwHHlSyZln2rQU73pdNc4cN5pHN3Iu2Nyo7xsXvo4B+KPLgLZZiYd8DQxmA19jQVPdKe7FzQhw/ohEcEtkH+LfPBA5PrYNThHa3KtLF5rEDcLegy3ust4tKIrNpHflyVJhXkusF9LTBHtMdmTjHAW8jKKx78IiJDRLQOmh5ontwaK7EPsstcF4sudaMZczJ29TzXmXam2rxGUM5MAR4as3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLcpEwwV9jmuXfoiy7B1e6c1p+HKaJIWJ8kGTtAVFNw=;
 b=R34W14X4AVcynTRZbTmHQpuOYmi/PYGKZlkGfRlTw9kvLsDJEpvfCf8qTr6vFN2/7/8fBZHT1WUXxPc902lZQn3q+/jqotGqN3yCPI8jWHXUtXqIu7IhpOTqVgk8IGflHhzs8w+wGF++HNz5Kf0BCZN+6zA52W/Bxm4VezfnFqEsntenQ+8U0OhJ8+a5OGaGjJ3SiPBm2TjhocdbQUvRTOwXQIiGrbMRVtcSKUrGexIjIqnRFSh7Gw15Z4iIZGIKIuJ925CILyZUpynn3omOdYUvPcclAr2f8suA9sADz1cuwMC0EJqDAko6IBA6NYw8BOvNTgUtYEtgtcJYWAZ+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLcpEwwV9jmuXfoiy7B1e6c1p+HKaJIWJ8kGTtAVFNw=;
 b=vue+K/iTthLRlmckXRtHhlVPf8fpoiHmeqvhbnUxXTqSa3Oqd8GNga8/N++5i3W5El6B9B+OGdo8k8iAMX7yVw7kEHYuSJSn9uQzJOw8Vgb6jbMAQdHMMRDeei1uoQ3AFPUry+1qWDyYT4yYJajQUqbA9fk3OHeUDRIkYeNFLBI=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 19:03:50 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::82d2:a5f:8f53:813]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::82d2:a5f:8f53:813%4]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 19:03:50 +0000
Message-ID: <182842b2-3de4-d64b-d729-f4f6c9c576d6@oracle.com>
Date:   Wed, 8 Mar 2023 11:03:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Helen Chao <helen.chao@oracle.com>
References: <1678301132-24496-1-git-send-email-dai.ngo@oracle.com>
 <9D5A190A-333A-4470-8572-CF85EE9A8086@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <9D5A190A-333A-4470-8572-CF85EE9A8086@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0054.prod.exchangelabs.com (2603:10b6:208:23f::23)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: ba762df9-afb1-4602-4dc6-08db2007da58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlff5JSJPUhyLFdGz8HPb1/d222IlMN5kR0Ot87eZVjsqHMCio1iv/o6thR8uL81pFzDs3Syh4PQ19vGFLPip0gNhGLNsiVLtdz0R6lc/3/RnNzjPyQSyZvgUJY/tA5kbHw2tcdXlfO7hViBpOhVdHtnYMe2szk1rwn++wB3VKCJEBRxyrRlee+IRY9yeUcFYskq1EGMUFaO+z437JV9tbjMTTrvVzZVo4cTkYUJ4yXnjzMnhOwyMGJFeZx6NJv3Q/CO/eoEwqUciYPsKWO8fHiqyts+kw77R0kt9uyNRfYtcATPIfI9TZuM1SxQIY6+AtJQEmOUSjqJHmDcQdvKK7ZAeZzM95Y8cAthtjtigDSczjScckde7rmg7t9iKqJrB7kpzSyjwVibFYmmD+6A9kGnfHZ8taxQC8VdvFlYKfZhlcdViwqYLyCGXLb2A3yjYpd2fpjzZYeGum9lgRiG+/UjEeOv+rMi6j/HNWH9jNSlIvwayfl102C3GtXW9ssxvjOhVldpoJHA7n2WCaZV7MVwddLc8TgXVikOv2vqa8oNGWcdV9qfnxBGBjStYqhSsevdTErXeS5LdZZ1CHVVL8ulmbIRAHqy+9c42Oa/hF7VMH1ITraWBD+8JtOxdmEIzFPJt6Rf6B+qgwNGEcfV0MRgIfSCGMZBGVoTItEbiWSOz0tOyB+vzW3rOG9iXjx2IZK9rdAvSBzNVvjH2cH31g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199018)(83380400001)(478600001)(36756003)(186003)(54906003)(38100700002)(66556008)(9686003)(66476007)(66946007)(8676002)(4326008)(26005)(6512007)(2906002)(6506007)(53546011)(2616005)(6666004)(31696002)(5660300002)(107886003)(37006003)(31686004)(316002)(6486002)(41300700001)(8936002)(86362001)(6862004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjkrUXErcWhCZmNwakxWYTN4NGN6NFEvcnV3VGMyR0lrTFlCWlUxd0JnMnVm?=
 =?utf-8?B?YzV3d0I0ZTZMU244VXZZSEYwUitqVlR2MVJpQWhLSXg1WkxqRXFSVm5qN1ZT?=
 =?utf-8?B?T2N4UVBiUUVsaytWSmFEdXc3am9TbnhzSm1UVXRacWtUTmRxeVg5UkNjLzJN?=
 =?utf-8?B?ajkvQmlOem5PVlI2c1dwWFJ3enZFZ3lyd3JPSmdxZjNhZ1M4RkZ3cTdrclE3?=
 =?utf-8?B?N2xhMGpGSEJLT2ZIRk0rODFpU1ZZWGFyYzRUNUpCRklGOE42K0tkRUdjVE13?=
 =?utf-8?B?UHNEd2NPVkc5VzRjb0JrSU4vZ0FMb3ErVE1HWkpSWmlZZ0IwMTM2ZlF2SHIz?=
 =?utf-8?B?R3VEaXJQa043ZWhJV3E3UjlFTEF0VWJvZlZaT2VSM2RROU5razFMSXJjdHI3?=
 =?utf-8?B?N3Bsc0JzbDJPWWxVK04vR044Nk9rT0xyQjlNWkt4ZjEzSEcyclFFNWFNS3Ni?=
 =?utf-8?B?TUlkd1JIOUhRc1pOai85N09uVUY4cnMzZmFRQ2JxellyTWpnYmNWK25Ib1R6?=
 =?utf-8?B?QXplaXRVMkZWQnh3UDhaNWdCd0pYTmhVZXRoSnBoZStMTXNEeGJUWmt4TUNn?=
 =?utf-8?B?a2M4Vk10emVlSFNxdEVXR2hLTnFpVloxNXR3MEsrOFBhUVQrRTY3MUpjNGps?=
 =?utf-8?B?Z0w1NHNLbUlvc3lDNDY2WkZSMG5DY3VmQitvY29VTW9wcGVYVHJWZUtDSWtt?=
 =?utf-8?B?bTVVY2Z0ek8wMXV0UzJrVUJsUG1kZlJIK3RuSG1LdjhGUjdMOUdFTUEvMGFH?=
 =?utf-8?B?Y05YR2dKYUljNE5xT0Z2YVFYL2JqYnNNL1FNZjdxWndVUVlOWUs3bS80YnZJ?=
 =?utf-8?B?eVJkVmR2TnJNUWF6UkQyTkFpWTdJclJEZE03cXIrMXJ4TDNWSGtmR3pHaHVE?=
 =?utf-8?B?ZmsrM3ZRRGhTdVE4dk55dFZOUm90OGZ5VnBaaUxjamNGaFZiNldPY3pXd0Zr?=
 =?utf-8?B?RGJlMXc3TnpETGFETzA4MDBvUEd6K0l0eCs5REM2REhPbmxCUm5HOVVLRTBU?=
 =?utf-8?B?WHE3RmlGTWdwcW5FSjNhS0ZEYXNTL3NZOFM1a3BWRERyUUEvZC9WeDJKNndx?=
 =?utf-8?B?d1A0QjNlVGNmYUJOcXkzdEptV1dhTmp5ak9oVmpXWE14TjI2QVpVUCtERk00?=
 =?utf-8?B?bWR4bEVKMDVVTi8rYWpjZUZ2YStGbWdPYm1iZWZ5aVpYYUVwT1FFZmVHdHlw?=
 =?utf-8?B?ZEsxVksyR29kMnZlREFzdWxOZDRoZlQxeW15ZnJ1eDMxVzJWRnVrVUtXeVBU?=
 =?utf-8?B?NVg5YjBlRUVZZC93bStmTy80Q3RZUTJQczdMN1MreGJKcGZQMnBkQzJEMnNR?=
 =?utf-8?B?TUtGay9tKzNmR0IyVEg1UmF2M3lxMDk3aWNVN1R4eUF0N3YyYUFqM0phNUJ2?=
 =?utf-8?B?N0JqNUNTanlHVVhqVXRRQVhYbUV3Y0NRZkVLV0liSU95a0RnZjRqMmhjZGx5?=
 =?utf-8?B?QnBQaHMzYm8xMmpFTm1YTkxTV2RvZmluWG9aSlFKN2tCYkNxam0ycmtPRzlH?=
 =?utf-8?B?Z2hvU3VGNG4wTWROOEY2eWFoakJQRnpZK08zUGFnb3kvWDJnTnlLNTFjWXdE?=
 =?utf-8?B?QVNuNlY3TThlSE5GaDVUQWdFMUFvVVRWYzhzUm15MnF2WHkzeEdiMnpsMG1L?=
 =?utf-8?B?bnJ6blB1Q0JRSEpiMzNmTmVmNEN2NGk2S25hSzF0TzY1QWtNa3ZQZUFzTnJa?=
 =?utf-8?B?U3dsSGdmSHJQemNoVVBPU25xMXBUamdHOE9xMWtRRmNmNzIxOS8zL3FhbER1?=
 =?utf-8?B?LzFOeVgvVW9uN09DazBlenVhWTQxRldTdVBBbmczakZlSXkreW42MU15eGhw?=
 =?utf-8?B?SkROM0JKWWRlQlpWVWxBa014TTIvZVUySkVNcUlTWllXc1ZpUU9aQlcrZ2pX?=
 =?utf-8?B?RzRQK2YxWkVQamx5RDh4TC9LZVNQNFA1YnRPOWlwMjhRYTVvcURRRnVwcjRX?=
 =?utf-8?B?UFFYejYvTnhUYVpNUG1OTWxqaUViUVorNTN1VmtRODVlMDFjK1NKcGxMUzU1?=
 =?utf-8?B?c0NmUmxrUFZwRVJ0UWVnclVla3AwWUlDU25MUHlMV0g1T3p0SWxvOFlIYjlh?=
 =?utf-8?B?UzFiQmZhYzZuL0ZNSzNjSTRvMUFWR3NDc2I4NlpCUHZlUDhxQ0h6bW5mTmdT?=
 =?utf-8?Q?i1ez49I/DldNQChUSTF7bR4ix?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2oFCvtmoAmawDKJCvJYz5FSZW1YqJDWNVn4DVyVaXmI40Tqum+It9jkW96JJZe88n298UwhVvjwHP2xdZi3/eRA5zvqORkYTe28Ws+A63kLAbN1C5uK7tHRR7ol1GOp13l4i2l1IZuH6UmZB8H8HGm/XHQ/ggKBkyULzXWHJduttVqSTaTOTDc0dVB+JqRbKKJ5pYH+/5tWeAwfvRovChbsCW+UlmKhWPDQirHF9QrpxMJMdE9w78pPzktddBlWDA4ykcZXcrxACbbBykEeWlwQnMXxNFTgVG/Dc4oPzJ9D/SfiA7q9vjtwIcMOVQw6mtWNvJO3rSKoaRg1/Z++T+gVEaImWJ+yyQXvAZHAOALTTjAEWvpY0EAZkXNS7HmzoECFYPDyuB7mJ9hcNcXdO673MZoQrbFeKETutqirz386lVQWW+GF0eRkRozU28eerz4S6hZecMehjHw0gq83vQ6Xj5Uom8ZVWDv73dSW6ctXTA8DdFi448aibGshz81DFiTTfdZVmXz2uGLE906Zi8/5KEUYCZYDJgfxmD1IrD1l0DkhfqUnmf8B7JwawXaBCsX2vJyqLaETqW6+Y8lXf2C5GjMY6GYdKkSSYp2ujkgB/IAbxxLHIiXvCsuxYSCten0A3Cdy7Y2c5PO/OENV++iRA9D87hoRSx8pm+f+G1px4Q1ZlI02cZ5uhAf5wC+2UsM7N4xY1JHWzizT1lhh9dSJuV0UC9cTYIRIc3O06PW2yivlmBPL29Lo8p708ikx+
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba762df9-afb1-4602-4dc6-08db2007da58
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:03:50.5168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50m116L12HBioGhGBDqJb7sHE9ZMP2UfW4gKmY1Ablw6rTxoIOMotPI7J9j2DNQyRqugr1m5JkpNjRUHjMrW9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_12,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080162
X-Proofpoint-GUID: -izOnPOzVLs4oV-sNXwd9Hmb0HL5SCYk
X-Proofpoint-ORIG-GUID: -izOnPOzVLs4oV-sNXwd9Hmb0HL5SCYk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3/8/23 10:50 AM, Chuck Lever III wrote:
>
>> On Mar 8, 2023, at 1:45 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Currently call_bind_status places a hard limit of 3 to the number of
>> retries on EACCES error. This limit was done to accommodate the behavior
>> of a buggy server that keeps returning garbage when the NLM daemon is
>> killed on the NFS server. However this change causes problem for other
>> servers that take a little longer than 9 seconds for the port mapper to
>> become ready when the NFS server is restarted.
>>
>> This patch removes this hard coded limit and let the RPC handles
>> the retry according to whether the export is soft or hard mounted.
>>
>> To avoid the hang with buggy server, the client can use soft mount for
>> the export.
>>
>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock requests")
>> Reported-by: Helen Chao <helen.chao@oracle.com>
>> Tested-by: Helen Chao <helen.chao@oracle.com>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> Helen is the royal queen of ^C  ;-)
>
> Did you try ^C on a mount while it waits for a rebind?

She uses a test script that restarts the NFS server while NLM lock test
is running. The failure is random, sometimes it fails and sometimes it
passes depending on when the LOCK/UNLOCK requests come in so I think
it's hard to time it to do the ^C, but I will ask.

Thanks,
-Dai

>
>
>> ---
>> include/linux/sunrpc/sched.h | 3 +--
>> net/sunrpc/clnt.c            | 3 ---
>> net/sunrpc/sched.c           | 1 -
>> 3 files changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
>> index b8ca3ecaf8d7..8ada7dc802d3 100644
>> --- a/include/linux/sunrpc/sched.h
>> +++ b/include/linux/sunrpc/sched.h
>> @@ -90,8 +90,7 @@ struct rpc_task {
>> #endif
>> 	unsigned char		tk_priority : 2,/* Task priority */
>> 				tk_garb_retry : 2,
>> -				tk_cred_retry : 2,
>> -				tk_rebind_retry : 2;
>> +				tk_cred_retry : 2;
>> };
>>
>> typedef void			(*rpc_action)(struct rpc_task *);
>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>> index 0b0b9f1eed46..63b438d8564b 100644
>> --- a/net/sunrpc/clnt.c
>> +++ b/net/sunrpc/clnt.c
>> @@ -2050,9 +2050,6 @@ call_bind_status(struct rpc_task *task)
>> 			status = -EOPNOTSUPP;
>> 			break;
>> 		}
>> -		if (task->tk_rebind_retry == 0)
>> -			break;
>> -		task->tk_rebind_retry--;
>> 		rpc_delay(task, 3*HZ);
>> 		goto retry_timeout;
>> 	case -ENOBUFS:
>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>> index be587a308e05..c8321de341ee 100644
>> --- a/net/sunrpc/sched.c
>> +++ b/net/sunrpc/sched.c
>> @@ -817,7 +817,6 @@ rpc_init_task_statistics(struct rpc_task *task)
>> 	/* Initialize retry counters */
>> 	task->tk_garb_retry = 2;
>> 	task->tk_cred_retry = 2;
>> -	task->tk_rebind_retry = 2;
>>
>> 	/* starting timestamp */
>> 	task->tk_start = ktime_get();
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
