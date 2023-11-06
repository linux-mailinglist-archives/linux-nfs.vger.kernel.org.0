Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570697E2DD6
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Nov 2023 21:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjKFUMU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Nov 2023 15:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjKFUMN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Nov 2023 15:12:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC311705
        for <linux-nfs@vger.kernel.org>; Mon,  6 Nov 2023 12:11:56 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6FkZPL007649;
        Mon, 6 Nov 2023 20:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=l9QPMtyKg2jMEf23PYz1RrRw9zbJyrP/6glRFN7UfBE=;
 b=PkCBfMjKUFO/YLFuF03FcybEz4Y5h9J4yXG3u3brficgCwBig1Avt5zN1C16OnXK7f3N
 PLUZHlTtBoI6xXnKprEroutGJfW0hO4vMILu9G7vajpLT5zHIkiiQ4n7AL2kgibavW2/
 y143RGsZsQ/nS9tonTn3NTKktXySMx/Btmn8HRGFA+pStP6ggvJRv+zFpljXV1plv1Ts
 tR42WpGX9wSfKlNBQurqpk8ZxG6lUgri1rY0jkQHb4j3afKAOysoDBHh4/4VOCBv/WrL
 YaKqwxNHeOWwymolIT2U/3wOeFvvn0fOGLNHo0dqc9WRXAS8sUgIaZ3hgACtEXAT8UfV 5A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5cj2v9hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 20:11:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6JYuAY023669;
        Mon, 6 Nov 2023 20:11:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cd5g6hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 20:11:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmXagGIvl10QDrRX2R0RPAkh8/HyMDQuCzQqIorOtCMZl0soKyWjGaBo0E31DteZkW5FDM0yVwsne1Ik4hOhlW5SP3EygftSyyRodKg/6ijS4oyzu2yGtrJ2efFOloY9vhiCYEaaA0zf91Tynuq/kqTPf1tJYhaVMLCUIywi7jcwT7v80qO7AnzR90i6D4UDEEcJSZXkZEHPPOUdHA+l1UYiHYxAn9arVJg2ChQULC8cW2ZyCuK22AxKL+xlOOM/NNpelp5i+MEYrBHKXsYAmrtt8xNOq9mXOCMyl/fbhY7WvmF522swO8tM8qG2yAaPc46gbAUsbZDFimvaTCLz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9QPMtyKg2jMEf23PYz1RrRw9zbJyrP/6glRFN7UfBE=;
 b=CVDt3AM4i4baPnwBhT/gxDVcJd++3Lhxs4WySAYtFU9pACSqKYWlq8JnUcea4t7fhcgfQjGjfU6xqDRzMDfjDHLvsx1DOlo99IOpbE/LzH0UqLv6qsGDof5yVj8H506z0m/zTUbgIinLCA2Fg54mSMCm4tyup0ihNi38PzNXULPrEOm1OLcVc1k74PlmsHs4lSU5uqiOFf3TJYjO/a10YXKDkMFTreXbDtRFOWXruwcDEDK1FW58j+E5Tw+4ynNAq5xLf55FLTJvYALalVT2fP4O8/6bjrGkl+fa08AtKNPsqMf/i/3i7xGMkHxqz4kfZYxettKPriC0pK/SRG4gMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9QPMtyKg2jMEf23PYz1RrRw9zbJyrP/6glRFN7UfBE=;
 b=uFQ4xA+VUICaqug4Ziie0GWv7d1L5YJp+oWuJra2JHw0tX/MEdcoGv3zOEoaFFgjeF7vsjFQQ2i1DZzAeHaFG0CW0g0+FudKuXIo1tp/ziBX80IIBuTEE16ACd0A8klzh/lag1UYEMKx+6+3aZIXPGATvwXLtNbXWaMqAJJ9Xfw=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 20:11:50 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::195d:7231:581b:2c92]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::195d:7231:581b:2c92%6]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 20:11:49 +0000
Message-ID: <84f065ca-435d-42a5-b190-44546d549681@oracle.com>
Date:   Mon, 6 Nov 2023 12:11:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: General protection fault in nfs4_setup_sequence caused by
 delegation return task
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <151d80cb-33dc-4266-a3ba-4b89ea80e49f@oracle.com>
 <971e0321c1637fa4bb8625b618734fa8b229b0e0.camel@hammerspace.com>
 <c53af0da-58f4-4981-9006-a6acbf404de4@oracle.com>
 <ed79385ef7c8ce2c6ff6753bcf8c5301f2d39584.camel@hammerspace.com>
From:   dai.ngo@oracle.com
In-Reply-To: <ed79385ef7c8ce2c6ff6753bcf8c5301f2d39584.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:208:e8::15) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DS7PR10MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: cf273978-e443-4363-899d-08dbdf049c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpORFMzInL2t5E94zbuGPuO+X2ZKJEx0Ib/xOuUtsTho73mkEMI9DjFykJz9bhPSONh8kpFaQL7F90xBwWxan76FvtNiwWDlpM2PazY6LkNOEbL+ZWoVHy2gZU7k9i9+IJDhgLVtSUdliSPxdgszGXmmkAZH5pHcwbMC5oDAZPtqE76KkbgHIDvFsaKJ95ExF9zVDqIpXxJwb7+88SXJXhj53jMJseqm6RcSRzaNAnUby1NtgD/9+WN/zgkJmWwNJIYzqcktqbWQO17aJ2yKpbCjcUVXzxG9fLXn698NV5Ci1cBcdt6TbJcUMw8pf2Z8hUiL9ypvf/YpX46m/w0p/kRtqoGFkUx0jlBLcy9YpM6+s/wThFMjm3CHMFi7UZ4F9K+hsGf5HxvClgjk2rqtVlmunJKBrBkJkz12YAUxBYnfj56uSBcJQC4gglnbsyjNf/M/D+ITyOBLzvGMfGFA5sACm8EKwMByQ2K4dA1D1+S45mjclXvdljYBZLkAirWvp/BHM2tDsRRZ0QWlRLthbC4XeZa67Gr2G/yPIIIabKpFICaUnZmQ5AFxde95nV4Rxk0LIhv4R2+g++I3RFhpok8UDR6a+25EcJlqT2sEzv2ls3/nB6usk26Lo+/dqRr3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2906002)(31696002)(5660300002)(86362001)(66946007)(66556008)(316002)(66476007)(8936002)(8676002)(110136005)(36756003)(41300700001)(26005)(2616005)(83380400001)(6512007)(9686003)(6666004)(53546011)(6506007)(38100700002)(31686004)(6486002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHJTakU3bzBHU2tOK0Jxdi9wQU9iZzlITUZncU0xYlhrYUo3b2VhdGI3ZkRE?=
 =?utf-8?B?SWFzcXpjKzloN1k4cSt3akcwTFVTNnhBVmdyWWEwVE1NNlhIdjlEd0RuKzNB?=
 =?utf-8?B?U2JlK2JnUU5DTXJLYkFBUDNjZFhJR1Q4Y1pGd292cXJqSkwwQXFtVUxCR3BH?=
 =?utf-8?B?eFl4V2hVeFNSMFRvRE1KRUNOZXlISW5YbTVjNnR5MG5Gc3BjcHBzUHNMK3Zn?=
 =?utf-8?B?dzFSYmNZTXdCaGtsZlBLTWZGK2xpY2dId1k5Q0ZQa3RlZWNwa2hEanR3OHFk?=
 =?utf-8?B?cUFMOVJybVRteEkwYVY4RkppcG9zZnhyYmxSczY0VWV3M3FZdERaV2ZGTWl5?=
 =?utf-8?B?dHZXay9pYUVTeGhMb3c3aSs2NXdhenVBUFRaK1B6ajVLdW13YXZ0UnZJcG4z?=
 =?utf-8?B?TENxZ1pva0xSZk1MNW00cHRQT3h2Z2t2aSt4THYvVnZiOXF0ZC9CWEROR1ow?=
 =?utf-8?B?dlMwU3VkV2Q3Y3d6MVNEVDk1YjBidFQvYmw2a0VqZW5JSlhIU2FFRkk3UWpO?=
 =?utf-8?B?V3NBeFZTSjhMMm5rc3ZMVGFlak9ZSWJxYThGY3IvMUhySmJhS2UxVkdqaDFO?=
 =?utf-8?B?Y0xNY0wyZFhxK0V0aDIwWGg2K2U5bnF4REpucllHUmdrUENaS3pscXhqQjUr?=
 =?utf-8?B?QU1GZXg0M0NBWHNwcEZrTTZlKzRCZ3NlTHk1V0VFZUJIY3VLZzk3enZJYVhh?=
 =?utf-8?B?eHNpMWtzaW82S3c0dndjQXQrdTlmbHg2Yk9oRVY5b1hoQ0lnRXFXL1kxRldF?=
 =?utf-8?B?S2VmaHppakdrbXFqZEpWOXpHZ3VLY0I4NVFjYjhxb2xoOG9qYURBZFBlSU1u?=
 =?utf-8?B?c01aSldXMS9SQ2NQRnRSN0d6THdrekFVZ0V0SUZPd0lHTjRIa1RXeUtaYzcy?=
 =?utf-8?B?bWozMTZtY21jQ1JSaUtsRHQ4MjFIOHRNNjI2ZXRoM3grOUE5ZDh1emtXZzY4?=
 =?utf-8?B?czE1Tk5CK2JLczVKUjB4dTM2eVFXTC9HbjRUVmhkRTJMc2prajF2TE9iWDZk?=
 =?utf-8?B?SWR1clhhdXEwemRkV01yWUJqQWl6WkZESTdxRHFORHIxWnFkZWVIRHQ2Rmxr?=
 =?utf-8?B?VERsVjF1aXpRaGE4Rm5NN285aUt0ck91a3l6WGVFR0g2NXV4TDhMMzRmQ0Rm?=
 =?utf-8?B?VWFDdU9FZkttSk9UYjVZNW9HWDZGRUJYRThaUmk5Z2pPRE0yWHpOejdqeHk2?=
 =?utf-8?B?NmpHaTE0YlNoQ0x3UG5tNGlBbDRrTE80UUIrQVR6N2VEd3V0cEZUbTBKVGMv?=
 =?utf-8?B?Q05RY291NkdNbkViMzExakxWbi9vMFEwcVVGWDZFbjFrdmtWUCtIcmFQZ3lY?=
 =?utf-8?B?NW8rRzVpdXNoc0FnVitvVGFFa1JBZEZmSlV6MTVSUU0rQUxEVUlhUHNoZWVp?=
 =?utf-8?B?S2pNWTNWalhaY0o3VGJxU0xHcWVHcjFGZWRsL0IrK0Y3NksrZUMxTXo5bmhq?=
 =?utf-8?B?eFF2YjhFS25oeDN0a050aUVCOU9wMVpmaFR4b3lPS3NnR242WnZGRWYwVjVP?=
 =?utf-8?B?SWF3VlZnVDVJR2d2V1l0N2VOdXlUOUdFSVFVT2E3eG0wUXErK3hKTG52NThR?=
 =?utf-8?B?VndwUUxVSExFS204SFZOUC80Y0huTnB3M1NnMmF1NUcrcElVT2lyUkRVZnJO?=
 =?utf-8?B?UTRaRnJ0cFRJa3Z0QUEycFY0L1NMSDlzK045b0ZXSkR1OUhud3N1Q1hkeUVZ?=
 =?utf-8?B?LzFHUmFZZnBZeEJRZXFsVkc0NGp4alk5TVhCVVVkNnpzemI0ODZxNU41b04x?=
 =?utf-8?B?QnFmQ1N3aXIxc2t0eVBFTU0vNDU2eTA1dEV4d2lpcjM4akh4OUZBb2MxTE1u?=
 =?utf-8?B?VWVodW1pS1NaSE1zMmNSOWQvTVIzemlVV3NHaGpaV1pwdnpzNmk0dTBhMjM0?=
 =?utf-8?B?MWUrV3hsc0Rmc0lKaDZ0REc3RHBiNVo5LzVJK1RDL0lCL0NWWkYrT1NWd3JK?=
 =?utf-8?B?dGFJNHd4T01YWGt4dXg5TnpQa1JqTElUbllyTGdsWEljMFR3QVI4MEg3UFE3?=
 =?utf-8?B?QnRXM3RvUTM3eXJZaDFzMm1RbzE3MThHMVpvOW5wa0FtQnNRK1B3dkgyQ2Jm?=
 =?utf-8?B?RGF5U0gwRE5iYndra3hCYXIvOGZNckIvNjlyRHRMU1lPNXpVd3JxM09ESmhk?=
 =?utf-8?Q?5gDTXvfBRW6RzPJT1KBTzDtiy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wpwXGpFI9V7ZQmV1//3yy/rmI3SFI68wVKmFr7bIecamd6FFT3+77dvNrt0sQ5uLO+Pi0/om5CZ51wHEgAUmslWbta8y/74gd1Ne+BSx2av6Dhvz9cZlQN3rTuAV1ca9I9bBj+50MfWwtLKhMlSBKSqwMFeWZVdhOQu6axs51Pweykomd3H7lT9MLsRahsDOwpTUs7Y1aClTiHJxRkWE7HPF+J+6YmjIBWMMY4Hw7t8LdyA0mxkVH175m+notTo1Perx2tFvs0YhdrddXoB4xxdZFcBWzaiuKjU8pPfplz2kJlrkLaa6JRmUS0vV05Clda75X+hwgaKQda+GJv7m5TP14y25YOhSkGRYuB1fYwcX4Ea0LiVmNSR2eIxpqjdFlY+ri5rnk5d6knWOydy3g6DKu3W8RvGxhpCCZAc/yNgTtoKbazggD4f9mPFrHFfRSRqPGRTU/HmsXQfRxSUphxG/r7D6fXjxtUZ8aLQeApKB7joeuNqpjn7DIJeApuLLnPme9DVDdUvbYk8l08yf2fergIooUwCe/ScQ/olMGky12qp0JmwgWF4dg1X4rON20KOAa4D1YaTCWtINzG87EKHZCqbXeJkAwQg1unl0pwuikYDb4Ey9H9ugSMkgwjHY3eLgMEF/j+HzVU0DVdNSq4jx6GFChm+zwpk2LIfAHNegamM2Zchjt7LzPyyQtMUSVyn6cwCu6eEq67/DQM4LxdSCQ2gYc39t1wcfxyDR0UY862Mtwa+RXQ3RzrtO6nw3hslyf+FGv+y5hd1dgcMGfe2RwldZtx6JzN7Nqz9xW/rro8WYHJ3rYzdVZ5sxlYHt
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf273978-e443-4363-899d-08dbdf049c04
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 20:11:49.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RApA594Z3671V6noPXvZpl+Fd1AK/0+HYJgCyhj1KVsV7ZwBY3WT0bcfh3V4RWn/zvyqxgeEsqXUrSlnujFZtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311060166
X-Proofpoint-ORIG-GUID: akCicnpQP7sd4qAyVftqfh8ODVbLFzqS
X-Proofpoint-GUID: akCicnpQP7sd4qAyVftqfh8ODVbLFzqS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/6/23 10:44 AM, Trond Myklebust wrote:
> On Mon, 2023-11-06 at 10:18 -0800, dai.ngo@oracle.com wrote:
>> On 11/6/23 8:30 AM, Trond Myklebust wrote:
>>> Hi Dai,
>>>
>>> On Sun, 2023-11-05 at 11:27 -0800, dai.ngo@oracle.com wrote:
>>>> Hi Trond,
>>>>
>>>> When unmonting a NFS export, nfs_free_server is called. In
>>>> nfs_free_server,
>>>> we call rpc_shutdown_client(server->client) to kill all pending
>>>> RPC
>>>> tasks
>>>> and wait for them to terminate before continue on to call
>>>> nfs_put_client.
>>>> In nfs_put_client, if the refcounf is drecemented to 0 then we
>>>> call
>>>> nfs_free_client which calls rpc_shutdown_client(clp-
>>>>> cl_rpcclient) to
>>>> kill all pending RPC tasks that use nfs_client->cl_rpcclient to
>>>> send
>>>> the
>>>> request.
>>>>
>>>> Normally this works fine. However, due to some race conditions,
>>>> if
>>>> there are
>>>> delegation return RPC tasks have not been executed yet when
>>>> nfs_free_server
>>>> is called then this can cause system to crash with general
>>>> protection
>>>> fault.
>>>>
>>>> The conditions that can cause the crash are: (1) there are
>>>> pending
>>>> delegation
>>>> return tasks called from nfs4_state_manager to return idle
>>>> delegations and
>>>> (2) the nfs_client's au_flavor is either RPC_AUTH_GSS_KRB5I or
>>>> RPC_AUTH_GSS_KRB5P
>>>> and (3) the call to nfs_igrab_and_active, from
>>>> _nfs4_proc_delegreturn, fails
>>>> for any reasons and (4) there is a pending RPC task renewing the
>>>> lease.
>>>>
>>>> Since the delegation return tasks were called with 'issync = 0'
>>>> the
>>>> refcount on
>>>> nfs_server were dropped (in nfs_client_return_marked_delegations
>>>> after RPC task
>>>> was submited to the RPC layer) and the nfs_igrab_and_active call
>>>> fails, these
>>>> RPC tasks do not hold any refcount on the nfs_server.
>>>>
>>>> When nfs_free_server is called, rpc_shutdown_client(server-
>>>>> client)
>>>> fails to
>>>> kill these delegation return tasks since these tasks using
>>>> nfs_client->cl_rpcclient
>>>> to send the requests. When nfs_put_client is called,
>>>> nfs_free_client
>>>> is not
>>>> called because there is a pending lease renew RPC task which uses
>>>> nfs_client->cl_rpcclient
>>>> to send the request and also adds a refcount on the nfs_client.
>>>> This
>>>> allows
>>>> the delegation return tasks to stay alive and continue on after
>>>> the
>>>> nfs_server
>>>> was freed.
>>>>
>>>> I've seen the NFS client with 5.4 kernel crashes with this stack
>>>> trace:
>>>>
>>>> !# 0 [ffffb93b8fbdbd78] nfs4_setup_sequence [nfsv4] at
>>>> ffffffffc0f27e40 fs/nfs/nfs4proc.c:1041:0
>>>>     # 1 [ffffb93b8fbdbdb8] nfs4_delegreturn_prepare [nfsv4] at
>>>> ffffffffc0f28ad1 fs/nfs/nfs4proc.c:6355:0
>>>>     # 2 [ffffb93b8fbdbdd8] rpc_prepare_task [sunrpc] at
>>>> ffffffffc05e33af net/sunrpc/sched.c:821:0
>>>>     # 3 [ffffb93b8fbdbde8] __rpc_execute [sunrpc] at
>>>> ffffffffc05eb527
>>>> net/sunrpc/sched.c:925:0
>>>>     # 4 [ffffb93b8fbdbe48] rpc_async_schedule [sunrpc] at
>>>> ffffffffc05eb8e0 net/sunrpc/sched.c:1013:0
>>>>     # 5 [ffffb93b8fbdbe68] process_one_work at ffffffff92ad4289
>>>> kernel/workqueue.c:2281:0
>>>>     # 6 [ffffb93b8fbdbeb0] worker_thread at ffffffff92ad50cf
>>>> kernel/workqueue.c:2427:0
>>>>     # 7 [ffffb93b8fbdbf10] kthread at ffffffff92adac05
>>>> kernel/kthread.c:296:0
>>>>     # 8 [ffffb93b8fbdbf58] ret_from_fork at ffffffff93600364
>>>> arch/x86/entry/entry_64.S:355:0
>>>>            
>>>> Where the params of nfs4_setup_sequence:
>>>>         client = (struct nfs_client *)0x4d54158ebc6cfc01
>>>>         args = (struct nfs4_sequence_args *)0xffff998487f85800
>>>>         res = (struct nfs4_sequence_res *)0xffff998487f85830
>>>>         task = (struct rpc_task *)0xffff997d41da7d00
>>>>
>>>> The 'client' pointer is invalid since it was extracted from
>>>> d_data-
>>>>> res.server->nfs_client
>>>> and the nfs_server was freed.
>>>>
>>>> I've reviewed the latest kernel 6.6-rc7, even though there are
>>>> many
>>>> changes
>>>> since 5.4 I could not see any any changes to prevent this
>>>> scenario to
>>>> happen
>>>> so I believe this problem still exists in 6.6-rc7.
>>>>
>>>> I'd like to get your opinion on this potential issue with the
>>>> latest
>>>> kernel
>>>> and if the problem still exists then what's the best way to fix
>>>> it.
>>>>
>>> nfs_inode_evict_delegation() should be calling
>>> nfs_do_return_delegation() with the issync flag set, whereas
>>> nfs_server_return_marked_delegations() should be holding a
>>> reference to
>>> the inode before it calls nfs_end_delegation_return().
>>>
>>> So where is this combination no inode reference + issync=0
>>> originating
>>> from?
>> The inode reference was dropped in
>> nfs_server_return_marked_delegations
>> after returning from nfs_end_delegation_return.
>>
>> I don't quite understand why do we continue on with the delegation
>> return
>> in _nfs4_proc_delegreturn after nfs_igrab_and_active fails and issync
>> = 0?
> I'm not seeing how that case can occur at all.

Since this crash is almost reproducible with 5.4 under a test setup,
I can add a patch to crash the system when nfs_igrab_and_active fails
and issync = 0.

>
> If nfs_server_return_marked_delegations() is holding a reference to the
> superblock and to the inode across the call to
> nfs_end_delegation_return(), then it should not be possible for the
> call to nfs_igrab_and_active() to fail

Yes, this is where I'm struggle to find out how can nfs_igrab_and_active
fails while we already had a refcount on the nfs_server. There must be
a scenario that causes nfs_igrab_and_active to fail since the
nfs4_delegreturndata->inode is NULL in the core dump.

Is it possible that the igrab in nfs_igrab_and_active fails, the inode
was marked with I_FREEING | I_WILL_FREE?

-Dai

>   because none of the reference
> counts it tries to bump can already be zero.
>
