Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EB4665A60
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 12:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbjAKLj3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 06:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbjAKLjH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 06:39:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EAFDEB2
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 03:36:36 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BAoxj3024288;
        Wed, 11 Jan 2023 11:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rpUpMSyb5i6VWHyJE1KsTwm0awtMoLaUv0RDpeR9ENM=;
 b=3DKA/BCREuaFZR9haDV/lv0NHGyXXWeKcsOJAXbMfcK3u4fxnyBRDlOcN3HW6UDZDhgl
 hn5jCHAZOJ5Meo/ZZlZcNtqg5D54QaB1JCfMEnzrJ70ibiB/SQhZQaZv95/TARYHg0jt
 E1/kCuKa3/kv0UTAe2r96JHxZrOKiitA6iTRcgGt+BZ6iOJcx41M4KA0Y5RClavrEz0C
 hRywQ39IdP2EzTrPyQZjeCn6s7oo/wLoOYqXVJ7DrLiLZqfPv2q8cE8Jjgov1vz2Xm9B
 nWT4nwDvSMMqOg8kzGDUrTK4GBQTTuhW9GIpbY08AdKhSLSt9SAWcIRBwmfpE0AimDiZ hA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n185tabbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 11:36:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30BBVUiS024101;
        Wed, 11 Jan 2023 11:36:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4p3a1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 11:36:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0dwai0E2ALDLGmzE05uO/RhqQcP71+9K1Kq+h5gDcv/Pr+0iIYp0WpdI5OPWa9Oof2RYGv5bm+8QKe8bBi9iYVxlZXEZvoLilUzPwyuYhDfcy3d5HPmj33y1/nHlbkm0WsO5Ys4kF8k94BVC2+YSzBWepYbWjGMITsVjCcuj2zjzHKI3kbbS536bhV/NYxihyxoa7fEP/iC+uEQ/FMD1pNGXS4C0XM4Ruv9x1jshJO6IjqQ5xHLQKlvRvN22RpQHS5BJ7khBjGHpjtpagXypT5mNSDTDzKiKlY8q1po/3OcbeMsWLTAySOu9dGQWluYYuGNJNV1Yta2apeyrsOoiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpUpMSyb5i6VWHyJE1KsTwm0awtMoLaUv0RDpeR9ENM=;
 b=mCzLQ21DipdMB7Lc8NgXtKyEnYaUCD+kFZziY3F3Qxuaakkiu11HZlEAlcyAoz5Ndx1nFfr3uL7fSPKFx9ohsIkDkfBE1IpGayqtWmds8/Qu3vEUWgFVLnkz+UMLfeVeYu3G9++2ID0oBbIDWU68t8arAWOyUO1mJhP90nVe0Hy21VcGSCSKhpASmcFcq4PSVk5L2aCLRXc9wDpCHwZrm7Io3rqBdoHH4J2nL9x1BX798Xa/XbKTEbX85wIihmI773skAqcwW3NBQLZTrATXkX0XTeZJYCfWRIoTL30TNN1UM478B+OUzxWSV58Ow7SPOfKcxX6RpzPHUGJyQ7umfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpUpMSyb5i6VWHyJE1KsTwm0awtMoLaUv0RDpeR9ENM=;
 b=NOi0lk3n9KWEoISexchPV9y4X2mu8j8/Peni/yKWHSlV1V1+48BlmhTWMEOqLrHv5xysNIdLBi0AFSHurHGyUrWDMLPgiQ9pjpagltEKcWxKCn6m994bj+sNd02aqwKYcjZ6wuaPEp3/xcZ/3EWCehVaXfOKB0xpZEOv6twjhG4=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM6PR10MB4203.namprd10.prod.outlook.com (2603:10b6:5:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 11:36:26 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%8]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 11:36:26 +0000
Message-ID: <b46a0da0-e10d-b27f-e17c-907f452a306c@oracle.com>
Date:   Wed, 11 Jan 2023 03:36:24 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     efault@gmx.de, linux-nfs@vger.kernel.org
References: <1673432658-4140-1-git-send-email-dai.ngo@oracle.com>
 <956fe608b456141b1b43f9dfe65581f168247cb8.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <956fe608b456141b1b43f9dfe65581f168247cb8.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::33) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DM6PR10MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 588f3ab0-c70b-4f4c-ae14-08daf3c81311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMEdE1r0fCuKL1X7UIvxzAVF2FeF/5f3BPPIjJO6gKsHbNhiHIQYZap1FtIYj0ubGUgdtsDAOLa3sMbfE4Qn34e0tugdoShpUksqec9bEUUMkgBopjDewlnW3BCCkWORXdJ+AF2DDnpSADL+62Jhlb8oCfMFvJREcpex0z8HRIs1Els4I9RtIhhDoPTX/TIN2z4uovq/l1Cv/LEo/cWxGiuIt2+LYyRROU8j0gmk+FxPy99EceqQ5vWiRkEtzvvB5HyHMUo6g+j7V0rv248WkrwlxdS50dWCwkLSAKbFH6Y/aHNeHdV32RpxQ9UIxXj+gJLSOXs4Z6ITdP5xCUTtZrNOU9Xiu5scRysf/q5D+NLeVyITzyEV4gXQP3ufeXsNw8GXB2EeaO80VB5nNp+3G5Xa9kRdAK7HO/OJKeuWaWOlaGUSXOM/tsYZnFVPQ2dbwXwAHg9ckoilIOWX35C9KEAyyZucy+BwPMvmfkp0tOKhmMuREIrgzyGzP4G+5589ZFhjrLEboHzOJbgm3iAtpRxd8xUzhnkyHF0RiZg3q8q8kMkPi1v/fZlUV14HBsZ27/JXyF5YmQEeIUU+dcBKAMpvKGWUrw+vwM2VH/A9sCFU/3GXbHWfH/Fw5k3kFiOmO92RhoVbmO4f8Z51aBOYV+MEXjIgkkVFamjg52M7rz2MVjv+YLaHFGhb853uezuSJSDIew7B+OwLhYnihGym9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(9686003)(478600001)(6486002)(41300700001)(38100700002)(6512007)(86362001)(316002)(31696002)(2616005)(186003)(26005)(66556008)(66476007)(66946007)(8676002)(4326008)(36756003)(5660300002)(53546011)(6506007)(2906002)(31686004)(83380400001)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1FPMk55L0NnWDc2ZERoaVhhOUliSkRkUnBsZDlhUVUyZS93TnhHMXBxOEFL?=
 =?utf-8?B?OWR2R2tMR29FTTljVGFobVBEYXFRRjFWMzE2RkRtYjA0TzVKR2lhcG5JcWpu?=
 =?utf-8?B?WnBLRStxUWQ3d1RsUGEyeWRrODBzc0R2Q0xhOWwyYzRYdlVMQkxXaVRDV2xZ?=
 =?utf-8?B?b1RFc21lbFpyN1IvbCtwb05OVDMyNFhyWFNFMytmcElKL0VWR2phdmR3OUtQ?=
 =?utf-8?B?M3k3dGZteW9wTEtya0JXWWtkMHFKbUJBcXptRlN0YWVQNlpxRlp3RDd2UlJV?=
 =?utf-8?B?K1RZTFVqZTZseWU2ajZLd1pJaTc4aG9aOGxON0VvSGM0dEtOcTVKcmg5aVlm?=
 =?utf-8?B?UE1DYVcxWHZhR3EwTFMxUHFOUzlwRk1WUEtINTNoUGNWNnFHZ254dVNpMFJv?=
 =?utf-8?B?TVUzQjlXSHNTQ1hKQVJuYnZyVllGZ0JVQnlEWWpvbUZFWDRlU0RrTFQvRHJr?=
 =?utf-8?B?TVU4bFBEelJML0xLaFpoTzlITlRYZm1kUHN5M0R3U1ZqenZJYUNab1lQSitN?=
 =?utf-8?B?N2Yvc2o3K1M1Mk02RXdYdUF0bWdZcmF1aUFpaXZxRVVvMXJ0RE5oS05LOXRy?=
 =?utf-8?B?VGp6Q1lSOXNnT3VVL3ZtY2ZPMU40NzNTVThPalpEcTJNQUJLdWJTUWlhbzVH?=
 =?utf-8?B?YlovTFowRGhPeUUwMWpOSlBKMWRoalphQkE2VDVMaVdzY1JSbGc3bWRXdnVy?=
 =?utf-8?B?SER1M0ljUFo1ZStzVXgrTTM4aC81QXh4UGpyVTJhNzMwSjJsd0JndklQRnlh?=
 =?utf-8?B?Q3hjU1pESXFEQjVzdzd3KzI4Q0FHNFNJaDk3Y1E1U3Zxb3Yvck5hTzZROFZq?=
 =?utf-8?B?WHBaWG90aktrbm8rN0YrOHE4Wm9RL1FmcEdxL3hiOWRMTHNjZUt3RDVSY0Yr?=
 =?utf-8?B?TlVqektXejZyMHJoVVZhYXpVZ0NENzJjOXpJTlJCQ2xyaDJVUW5jdElqVHJV?=
 =?utf-8?B?YXZ0bzFTTTVmSFF5bG1KMjBxNS85REpJSjJrSjVWM2dRamdxb1hYdjd4cEcx?=
 =?utf-8?B?TTZmZmdpYmlXdFpCWHBBU0tZTWxocGtrOHNrOGJEdEM2N1dmMmdjMHhLYUxD?=
 =?utf-8?B?YXZIVFJCbFZoK3ZYUGQvRzNSWXpNRkU1SU9FUENVL3o0R2V6RVZnYUhwOU03?=
 =?utf-8?B?THZTNkFuSkJrQ2Z1bXg5WHZwWHNJWHBRdlVaNmVFQ3dKcEwzcE9MdzEwVDA2?=
 =?utf-8?B?dVZMQUlNQjZVQkVyTE1tcHdRbkNucE9jazFwQ041L2N2bDFCRWhJd0I0NlZl?=
 =?utf-8?B?UXZoZFp6dXNXTEozU3V4dXdGQzliVmlzbFVJcDBwSmpiaWlHODZaSnUwTFpK?=
 =?utf-8?B?QkhCTWxVOGtFbXNGQzMwQ0tMMEV6Q0FWdUNEeEhxNEQ5WS92M3UxcU9peWxS?=
 =?utf-8?B?TW5QL0V3TmVEVm02a1pZREJVaCs0dS9STTFrMlMxN21BeCtMeHUyS2tWTitW?=
 =?utf-8?B?TXlTR1pLQXZuZEtESTZTdWRjc1JKR3lrV1lUTzNvUklkL3BVY2pkeUtwdENG?=
 =?utf-8?B?SlRsZVBabE9zMDVicmFUWldBdGYzOHBMNW9wM1I2eS9YR2dEN3Q2b2hhM3BQ?=
 =?utf-8?B?a3JzVHBQWDl2SHkzbXlCdHZCYXBGVENnRE43MG9TcXFzcEJ1eDVvdnllUk4w?=
 =?utf-8?B?VzA2NjhJcUxpZ1d6OS9oeEtTS3JlR3ByczJxSFgrVDgvdXFYeTRQeEMrVUQw?=
 =?utf-8?B?ZGozc0hBSE1CNjVQTGxZcEI0bCt0TFVMR0hLOUVsQjkxZlVia05BbXlBdGRJ?=
 =?utf-8?B?Vk0yNGZVK2psOU5Md3lFSTk1d2JIZ3dUdFB1YXRudzR2OWdkaUxVOEFkVlRk?=
 =?utf-8?B?QytpK1VvWDNTbEtRNklPVHhhUEVGbG1CWHJDMUpROWw0cndMTjBjSVhFNThu?=
 =?utf-8?B?bUtIZmIwQnRhSFNzaEpkWlE5Q3d3aFBadWlnai83VzZlM0tOM1d2VzJwNG4y?=
 =?utf-8?B?UTFNZ2ZCQWxNSWJsYnF1Y0hySi9mL0loK28wYm1zaTRhQ2RuQ0JuWVJpYlBu?=
 =?utf-8?B?Rytya3Z4Y1NnMDY1em8zY2dqNGl0QlJnNlRPQnh4dDYzVXp6N0FsK1FlSmIz?=
 =?utf-8?B?c2tQQXI2U2ZUMkRhTDJPTjFDS2pwOEhPbUtpam5BcHFuckhwVjRFelcwS2pm?=
 =?utf-8?Q?SAhGinV5uyd9VrZdqcG7TzJNf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yqIQO9S+k+g7YeeJM+YtHrUlorIyoccvpRzCUvo+iF4LGaidAg5F478hq00Syn5SruqvMW+rH53lUE305BIi6Sj6bv3pZgvXMeWa73fiCOIWjsd9iBSdVKy2tOvZM0AlF2V2saVfiMmy/g/GYnkLzO+bQmvRYzLO6ogKkJ0d+lA7rB4GgeqVToZIn6ueqGkWFiWH8yhlsVITj1bv/pN+0spsDs/FVEwve039dQK+k0NMZQLNcOVjgwlmuuTHqjD+hdPWUKMn9H0KV1plH2auDwqnai/13OCCFWB/eHG6I6MbpQibIUlquBm0OY8hqWP97KzsmCsi003b27HijUfQrRGzEzAtE+x2iPY/XPWBxEQTaf4DJkgB/g19PH25IWkb9Gpl/InwB6a1szsG8FY6mx/IpTB5keotvIpKmS0G+mzFaATt/qWKHOQuD0h4+ujHdLmwoocXch4NRh2S9wAEB5XfO2bnazONvjM2UPQ8XD41xVDNwkkMoG/0FH/7jjTB2TgxVzDZnnwRx2oqSi62IPkYhDC0iYb7KhGRaU4L3mz6zP364NlV9hkrn/yycA0u6Reda+H0xP4MriTu/Aq070l3lpVozVzoIXicnYwzs3pmpuZnGONzq4tEIQa9OWFndOh9ODKFuCOofzxwZ5dnntZtU2tb53pzm3M7BEKJUqQVNxt/bU28xSjhQ0lBJwtwbWqmYV+EJZ4V2+ygGlb1jwx2S9j90T8pufi9LAznTsPAiJAej4reIpHBL+UjMu5PdbauYhbDik0UTHhj8GCjyFoKRxIVzNe9jaR+jyPkkycKSWOnpddCyseN/Q+O/YAx
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588f3ab0-c70b-4f4c-ae14-08daf3c81311
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 11:36:26.6218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqY1JOv4Z81l2mxkx5dg8AOyzVhHfplnk/z8LXSfLPs8x/8OVoLG+q0kVHXW8Xfu8Xp5EH9Qbc0VZPQdeYBv2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_05,2023-01-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110085
X-Proofpoint-ORIG-GUID: yPnJ5XqpvuinKKMcaD7ghgyxCcAsDy8H
X-Proofpoint-GUID: yPnJ5XqpvuinKKMcaD7ghgyxCcAsDy8H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/11/23 2:47 AM, Jeff Layton wrote:
> On Wed, 2023-01-11 at 02:24 -0800, Dai Ngo wrote:
>> Currently nfsd4_state_shrinker_worker can be schduled multiple times
>> from nfsd4_state_shrinker_count when memory is low. This causes
>> the WARN_ON_ONCE in __queue_delayed_work to trigger.
>>
>> This patch allows only one instance of nfsd4_state_shrinker_worker
>> at a time using the nfsd_shrinker_active flag, protected by the
>> client_lock.
>>
>> Change nfsd_shrinker_work from delayed_work to work_struct since we
>> don't use the delay.
>>
>> Replace mod_delayed_work in nfsd4_state_shrinker_count with queue_work.
>>
>> Cancel work_struct nfsd_shrinker_work after unregistering shrinker
>> in nfs4_state_shutdown_net
>>
>> Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
>> Reported-by: Mike Galbraith <efault@gmx.de>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> v2:
>>    . Change nfsd_shrinker_work from delayed_work to work_struct
>>    . Replace mod_delayed_work in nfsd4_state_shrinker_count with queue_work
>>    . Cancel work_struct nfsd_shrinker_work after unregistering shrinker
>> v3:
>>    . set nfsd_shrinker_active earlier in nfsd4_state_shrinker_count
>>
>>   fs/nfsd/netns.h     |  3 ++-
>>   fs/nfsd/nfs4state.c | 24 +++++++++++++++++++-----
>>   2 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>> index 8c854ba3285b..b0c7b657324b 100644
>> --- a/fs/nfsd/netns.h
>> +++ b/fs/nfsd/netns.h
>> @@ -195,7 +195,8 @@ struct nfsd_net {
>>   
>>   	atomic_t		nfsd_courtesy_clients;
>>   	struct shrinker		nfsd_client_shrinker;
>> -	struct delayed_work	nfsd_shrinker_work;
>> +	struct work_struct	nfsd_shrinker_work;
>> +	bool			nfsd_shrinker_active;
>>   };
>>   
>>   /* Simple check to find out if a given net was properly initialized */
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index a7cfefd7c205..35ec4cba88b3 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -4407,11 +4407,22 @@ nfsd4_state_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
>>   	struct nfsd_net *nn = container_of(shrink,
>>   			struct nfsd_net, nfsd_client_shrinker);
>>   
>> +	spin_lock(&nn->client_lock);
>> +	if (nn->nfsd_shrinker_active) {
>> +		spin_unlock(&nn->client_lock);
>> +		return 0;
>> +	}
>> +	nn->nfsd_shrinker_active = true;
>>   	count = atomic_read(&nn->nfsd_courtesy_clients);
>>   	if (!count)
>>   		count = atomic_long_read(&num_delegations);
>> -	if (count)
>> -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>> +	if (count) {
>> +		spin_unlock(&nn->client_lock);
>> +		queue_work(laundry_wq, &nn->nfsd_shrinker_work);
>> +	} else {
>> +		nn->nfsd_shrinker_active = false;
>> +		spin_unlock(&nn->client_lock);
>> +	}
> The change to normal work_struct is an improvement, but NAK on this
> patch. The spinlocking and flag are not needed here. I seriously doubt
> that we have a clear understanding of this problem.

Agreed. We need to get to the bottom of this.

-Dai

>
>>   	return (unsigned long)count;
>>   }
>>   
>> @@ -6233,12 +6244,14 @@ deleg_reaper(struct nfsd_net *nn)
>>   static void
>>   nfsd4_state_shrinker_worker(struct work_struct *work)
>>   {
>> -	struct delayed_work *dwork = to_delayed_work(work);
>> -	struct nfsd_net *nn = container_of(dwork, struct nfsd_net,
>> +	struct nfsd_net *nn = container_of(work, struct nfsd_net,
>>   				nfsd_shrinker_work);
>>   
>>   	courtesy_client_reaper(nn);
>>   	deleg_reaper(nn);
>> +	spin_lock(&nn->client_lock);
>> +	nn->nfsd_shrinker_active = false;
>> +	spin_unlock(&nn->client_lock);
>>   }
>>   
>>   static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
>> @@ -8064,7 +8077,7 @@ static int nfs4_state_create_net(struct net *net)
>>   	INIT_LIST_HEAD(&nn->blocked_locks_lru);
>>   
>>   	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
>> -	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
>> +	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
>>   	get_net(net);
>>   
>>   	nn->nfsd_client_shrinker.scan_objects = nfsd4_state_shrinker_scan;
>> @@ -8171,6 +8184,7 @@ nfs4_state_shutdown_net(struct net *net)
>>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>   
>>   	unregister_shrinker(&nn->nfsd_client_shrinker);
>> +	cancel_work(&nn->nfsd_shrinker_work);
>>   	cancel_delayed_work_sync(&nn->laundromat_work);
>>   	locks_end_grace(&nn->nfsd4_manager);
>>   
