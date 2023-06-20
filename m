Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAE77372F1
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jun 2023 19:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjFTRcF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Jun 2023 13:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjFTRcE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Jun 2023 13:32:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD84795
        for <linux-nfs@vger.kernel.org>; Tue, 20 Jun 2023 10:32:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KGDwqH019858;
        Tue, 20 Jun 2023 17:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6hMdYZYxTZzAbgO/1Cv/MhXNtvoehCqRhKz+6OZm4js=;
 b=p9gm5qTZ0qYBik97VtbPZTiZUgats+gtySt0lbanQahS2xV3D/oOy06rlnlE0x0vs4gu
 EaqIhWm0HrscHaz++uHlLcbAahIOQBEj/FUP78O2kZLdVsrztfIIy+1B56IDvFDBpb9p
 Ll45lrLshesZhUDSB3NvyKLwrEb7Gl9BXONN75BYzgNONvkoRy2FpmCP92/3j9ZzcRpm
 n5kkdNqsHK1MQYLXN5pX9lLTUH8vM/B/flqYxtlkl8LHpXDpQYf4nT42Hlkuh4e/wtbq
 DjeXuetzYhaA6WLlDuGT3d34o9+RD7/lieSVEZG8zwRRUogdYmPD3Oqu/MU6+QJTrye8 7A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dncpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 17:32:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KH4Y3v008585;
        Tue, 20 Jun 2023 17:32:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r93956h70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 17:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF8SyXhiugAX1xRr3XYm2KrjK3yPLAeiT9TSE52j+bUvoyJdm6daU0gEz3kEDDYSoGeTCAyiDho45cEFlc+l4RbjJJ//hw8h+F/O+WYrTGnRoQja3j+msx4E92xZdErYt/eWJc5MnweSfdBFwkDVeUPCWCylvbtuyYxhn0AI66Wm8LHaF06tTnfPB5zohK0EUzR5PxhZGGhJrMqTESpK8lvcHXPR2govX8Okapl6ZcObAEmqscmxpxj7PqYjQRu79zrRoiPF9gtcQmbxQZmwJ8GAPD9FYeTAjBeIQpMNjdjwUfxJFTlTrIDrB+lZatusTJ1xzxBB+l7zIpIEADKEMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hMdYZYxTZzAbgO/1Cv/MhXNtvoehCqRhKz+6OZm4js=;
 b=CoHM9jElxyt0dW6y2CDGbpN4e0WjoJ1xL0J7HgcDcRM0wPTTG8eBYQ/3pOY+vqfesNj84sXmjkK+IXwrjSOwDGC5dWW1m1IA0pS2pA34u1iiRXlfRfnSi5yVaG5HVI/oYKEQTWhbFNoOLkqhOnNNJNeUCguObgeh15bENxbU3uYm3hkGF6pqahqQsCIolnkWZQ8pCZmxjP9bphXAZ8Xv7hjEfhnSzmZpURmwOli3ME9wn1ogHep5c/o1TSSKmG7x0i+XaMSzApgj9dMTyBU5ryI0rZiW5SA3pIfsaFfKhVM9d555CUiOUCnVDjnFs4ScR9f2bAkjV75QyumgfmY1Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hMdYZYxTZzAbgO/1Cv/MhXNtvoehCqRhKz+6OZm4js=;
 b=e44rj9oQYQbgB4KIvIyPrq0o5fUidKfPNN1HrPp52hGeELAYqS00dF0GdyaUBgFw+/20Xq248Yt1c5DViYGhCLrzuugrmQ1XnwDa3ROtyO/xNjBAKrTIu64DfGWy0Z1KiGtomVGpbDlhAE3rLMp1pJ6E9GMN+vh7PwihEe9lrmU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH3PR10MB7494.namprd10.prod.outlook.com (2603:10b6:610:163::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:31:58 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8967:3473:fad7:4eb]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8967:3473:fad7:4eb%5]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 17:31:58 +0000
Message-ID: <8672ce84-72a0-2e7f-4f31-37af58ac1933@oracle.com>
Date:   Tue, 20 Jun 2023 10:31:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: NFSv4.0 Linux client fails to return delegation
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <f9651599-846e-3331-9353-8a8264de1a27@oracle.com>
 <d5efe21b5f6a4bc7edd0f8ed441f63aa76b7e41a.camel@hammerspace.com>
 <5a43e57a-eb00-6f76-87a8-1a80c584b9f8@oracle.com>
 <9B7E8AD9-C418-4E22-8EEE-B101F1D2F662@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <9B7E8AD9-C418-4E22-8EEE-B101F1D2F662@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::14) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CH3PR10MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 055d5df3-d20d-4664-828b-08db71b43fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDzeRS5aoINyqh1xlt1HHxNn532htnhXB/j8HXuVjdYi2IHd8JvgFdZdZrSfecf4B/hkw2R1pIBWzWfE2WN+1wqGyfbdlgpkVqU7X7TjJiIxo8upS1B6qP1kSacAt+0qrlY/sdSvCuTdm6CRbDvcfyiiDlwL2ZzFmcWSIPN8RflI9NyeE5YZPSFbIiD7RpWptcG7mBdqoL3+9g81t6HM1DqH3hIG4852Gb03Z5Y0/F/WbRHIJBiRfpYkAaOo5JQwJ+QjYQyGnZe5kQV3Kg5QiZqX2BbvnMtau/zts236a+Don78H0kA6rg1y3sPHu3MxvodMR+Uetq3yREZMnNeToeGcoOfl541rvlhozu69ZaVsBCSW5pI31lgHiYr2/NcGTJZw63DEEqf69GFy1VD/SrNd1yVXYcZ71ucHyVhFtlJrWSTR54B9bn9n6m96MK1rqn6LLzmsGT3MmXtZlWEWmETaXg5CaOVCNtCw+fqm5ZHeILqi/5tegJtGX753zCOz8vUTlnE1I+G1h21WjeUWeGXuKry6drUAWjmVb/zdH3r3EHdIwzw9FS41t5Sw0imnn+7KXkVHt6dIh/BLpEt5+f0ZPeSRI84pc2veL2s7G3gz9kCzF0Y6Wh6PkO2G7Vl5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(66899021)(478600001)(2906002)(6666004)(6486002)(54906003)(37006003)(38100700002)(316002)(31696002)(83380400001)(31686004)(5660300002)(41300700001)(66946007)(66476007)(66556008)(53546011)(6506007)(6512007)(9686003)(6862004)(26005)(86362001)(36756003)(2616005)(8676002)(8936002)(186003)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjVrR01tL0xHL0RsYzM5NEtIM2xkaEtBK0t3M1p3aGRDc2lWVWlTU2x6OG5r?=
 =?utf-8?B?V0RoVkNwcFF3R1ZzNWovZENlUXZtR2lHcTVmamhxUVVTN1RFQ2U3WFBwNlg5?=
 =?utf-8?B?bDJUUXQrNXhyRXRhQ0xIcXNGdW9rS29PWTNXdGh3SGRZeEczUE9nZlk1Mk5K?=
 =?utf-8?B?Q2FQdzJyenhQazF3azFSWXlkYksvMk94MWZDZWFoOFRRY1hwdm53VDdhRmFa?=
 =?utf-8?B?WHJHZnkrVWYxN0xoaUdsNE9HV3YvSWdhTlExZmFtQVhYSnJ4MTNVUUNqcXV6?=
 =?utf-8?B?a2NTVFR5dHBOaFRKcDl4dDJIMTdHK0QyRHRxNFg0K0M3MjdyVkdsUVBHTy84?=
 =?utf-8?B?L1E3QkY5M25iaHdXdFNHU1hreXVEbzJhaTl2NE54anFKRUI3SnFDVGhudnBr?=
 =?utf-8?B?MDBET3lMdFl3ZkwrZjd4Zjk2Ukd4aTUxN3R6OU9YRUxlcWM0RDA2elJKZEpX?=
 =?utf-8?B?cUhFeWZ3U2ViOExFNWRzT25ZOEtsL2UzQ0dtbVBkb1daTlF0NGlYMzdaekE2?=
 =?utf-8?B?ZkJSekpVUFhiUXNTSFpkc1lDVUdQM0NqbHRWODh4Qi9ZUmlFODRlL3QxRHBR?=
 =?utf-8?B?SHUvZG5vQ0taZkgydGw5cGd2OFJlQjVMdXNuOFcwdm1ObUNvL2xyVmtLOXFy?=
 =?utf-8?B?VkNPVmpJZ3ZVakJVblE1Zm9IdjhHRHdhSGtTQTVMQ05IZEJWQTlFMUc5SVlv?=
 =?utf-8?B?bXl4bjFQZG8xa0RyTXJOTjArZ3h1bzNEaFdzYmFiSVJIdEx3S1BGMW9JQUFF?=
 =?utf-8?B?cURJN3AwMzlqY1laZHVUWWplVTBTSUxaaFk5c2pSUnlLNk0zYTFTcEJXckJ1?=
 =?utf-8?B?VEVMU2g0Njl3QzhTd0d4YTdheEZqLzNUdEU2TVlhcTZBVndIQzNHZFZ5SUlu?=
 =?utf-8?B?THRZenc2UG9XS1VsQUxOMURQYlkvVzNCang1dkhmd3l4Sis0R0pUMno0L1NP?=
 =?utf-8?B?cHNBODlNWlEwdGRkaXlHZ0hHekZQSVlHa1lKWWJNV25hMXYyN3JrUllFNlhk?=
 =?utf-8?B?cHNZMHJFNzdmVDdvSll3d1UzcjRrTENvUWtPOXBXa1A1L1d3RXVpT21XaDZj?=
 =?utf-8?B?L2Z5dGFKaWFLdTA5OWVVZlhSTlN3OVRLTlloeUZvQ1B5a3hMTVUvYTg2bU91?=
 =?utf-8?B?UTJ0ZVlWN0VBY29rTEIzU3ZwTTh5TXlUeExSS2hFZlJMaE9YYWtZZE9Ud2Fr?=
 =?utf-8?B?elAzd3BsaU4zNUZCZ0tNcGlHTnorb0xCekMrRUlGeEpyOGlIMDFoa2dnc1dG?=
 =?utf-8?B?a1VsWmNudW1Ub05wcm9jaW5JalFIVzNMQnhtSjJISWdFZ0Z6Mit6N29aSjVy?=
 =?utf-8?B?aDUyN3dXZGREdVlraE9wdFFJK0xKYnA0WGpNNWNITnlEUVNQbDVpK1FDSGh6?=
 =?utf-8?B?V0NCaWZsR1RUM1kwcEM2bXRNdHZyV1RITHhrYWJJdXBJRDQ5eHQ5V01naHZ4?=
 =?utf-8?B?cnpvMHpBOFZrR2NBR0U3UjFoOTg0UzhEOEJjK1VLYVEwVkVFUkwzbjdaZlRz?=
 =?utf-8?B?bjFLN25FMkk3bGhEY2JBdWpJTTIybjU4VE1DcVFzNDZnamZOUGc1OGZiODdY?=
 =?utf-8?B?S2F5Q3I3YzJJTnNid0s5bFlXQncxVEpYYzd1QUUyb2UybEVMbjM0WWFZQ3Rj?=
 =?utf-8?B?d3UrQU9RRnVwcW1QdmdhZmtXeU9tTWxHQ1hCTjgrSmxVeVM4OCs3TlorczV2?=
 =?utf-8?B?ZGdzM2ZMSGhtd2swNkV5cVdEaEFlUHpycG9OMDJSZ0tMTCtyQ09JWDZZR09v?=
 =?utf-8?B?NnYrcFI4aVRwKzVEaGVUcVlheHNsRlltRmdISTNwbEFNZzFlVWhTaXcwall6?=
 =?utf-8?B?TEN2ek0zbE5pY3EvZXBXeVNmcUEzd1FVYms5aVdRRkdHLzQ0U3h6aEkzUmRV?=
 =?utf-8?B?dzY0dnFMbW5oUE9CVEZVTkJucXRwYVJ3MndreU5nN0NJOSthWWsxYVo4TVZr?=
 =?utf-8?B?SVdRekpwKy9IeWE3L0ZkVmh5eEpvbmdGNEhNczBmRzd1TS80eXVuQ1puTnhI?=
 =?utf-8?B?cjZyRFkvalhPcEpyK1pqNVFZN3VqWkUva1FKN1hlQUFESWptVk9pVk53cUtU?=
 =?utf-8?B?ZWhkOWJLMnJFV3JvQk4xb0l6Yy9FNlpHcm9Xam5GdWQrdTdIOXBvOTVld3V1?=
 =?utf-8?Q?+4xeFFZEKQNO9XtaNSRLkGc3p?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rPKF656EhMzYN8llLKkA6OgrZ6TKRuzkkwsE8iSU8BYnF4kFGbMEMzfhkDPtYx0mrnPVfy7wGgMNvYwnXsvWyFh3IHnubLvHy0xiFX937NUU8IFKchKHziCg6fRsYwLYTUnRccqSVyYB2ogstoi+zRYH+SIs0TfE8UYrVtJjDQqwalOfn9N77mHTwbb3mbJVluFgR7Ahq2oogtePrxdazFcP+xAXa/6GFFtECEgUmn8oIfF1KP6y2qPnD8vr8KgNnna3Dk4jrHl81avPk3GjMkU2TS3dB0GEVHfSxbGN3RV3cFpUkzxWzggn+L75Pn+psWUOJfOgkJtsngAtQCvWoULDvzRg5+Gr7bJ0tsn3is7wtd3mv+km/YJ6VI5ULTE46Z+lONx+WX3rV9+DeWdf7QnUjdlYb4va3iTWVJ+28cZ/klwU9Ts9AA3BD76fvW7V3gpbevA44esTNg6T/xir3Dlne6UE6IlNhjkZ+GdsvgE9Qx22mzNAGCZ+cs8asS+Dax9CqVg77hrzcESvXH73QYHw5IN721f7CM8m1vm6NgRuqY4THWWkeewLoa58ImteXoqqjujofRHWiznKCOESQLfTrGcqWC9H++hny7fQp0cq8u0ZIdI9i4fxT2ZyZy4RrzlS4coyQK3MoWpvb+q99aj6nfmWKzvS3C1eLn7MGmPI887wp/PbeEzH3AZ5GXML0OG3H0uIWjOpElKz9zVOwaPhGlbTc5JNq94H+h+usj2ggDuaO9t8Yp3l9iCJQyb1Jrz6l3xm6M2FK04ASR6CVyK1jyHsVHPRvbSX00iyquEueV0J3ZspHx4f49Z2HNth
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055d5df3-d20d-4664-828b-08db71b43fe1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:31:58.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OF6ENvui/yj0MKI5juul9Em7QUrjwN/82r2vv2TOInFgGcX447PByj8inN1X/Rfmi78dDf4GWtiHKVrlkAFxoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_13,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200158
X-Proofpoint-GUID: rLGbi_W4otYvPGzFKiCBZfWlOx4Le4q0
X-Proofpoint-ORIG-GUID: rLGbi_W4otYvPGzFKiCBZfWlOx4Le4q0
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/20/23 10:10 AM, Chuck Lever III wrote:
>> On Jun 20, 2023, at 11:27 AM, dai.ngo@oracle.com wrote:
>>
>> On 6/19/23 12:19 PM, Trond Myklebust wrote:
>>> Hi Dai,
>>>
>>> On Mon, 2023-06-19 at 10:02 -0700, dai.ngo@oracle.com wrote:
>>>> Hi Trond,
>>>>
>>>> I'm testing the NFS server with write delegation support and the
>>>> Linux client
>>>> using NFSv4.0 and run into a situation that needs your advise.
>>>>
>>>> In this scenario, the NFS server grants the write delegation to the
>>>> client.
>>>> Later when the client returns delegation it sends the compound PUTFH,
>>>> GETATTR
>>>> and DELERETURN.
>>>>
>>>> When the NFS server services the GETATTR, it detects that there is a
>>>> write
>>>> delegation on this file but it can not detect that this GETATTR
>>>> request was
>>>> sent from the same client that owns the write delegation (due to the
>>>> nature
>>>> of NFSv4.0 compound). As the result, the server sends CB_RECALL to
>>>> recall
>>>> the delegation and replies NFS4ERR_DELAY to the GETATTR request.
>>>>
>>>> When the client receives the NFS4ERR_DELAY it retries with the same
>>>> compound
>>>> PUTFH, GETATTR, DELERETURN and server again replies the
>>>> NFS4ERR_DELAY. This
>>>> process repeats until the recall times out and the delegation is
>>>> revoked by
>>>> the server.
>>>>
>>>> I noticed that the current order of GETATTR and DELEGRETURN was done
>>>> by
>>>> commit e144cbcc251f. Then later on, commit 8ac2b42238f5 was added to
>>>> drop
>>>> the GETATTR if the request was rejected with EACCES.
>>>>
>>>> Do you have any advise on where, on server or client, this issue
>>>> should
>>>> be addressed?
>>> This wants to be addressed in the server. The client has a very good
>>> reason for wanting to retrieve the attributes before returning the
>>> delegation here: it needs to update the change attribute while it is
>>> still holding the delegation in order to ensure close-to-open cache
>>> consistency.
>>>
>>> Since you do have a stateid in the DELEGRETURN, it should be possible
>>> to determine that this is indeed the client that holds the delegation.
>> Thank you Trond. I'll wait for Chuck to decide what to do next.
> I don't have a technical objection to Trond's proposal. But until
> the WG documents the interoperability requirements, I don't believe
> it's something NFSD can sensibly support.
>
> So, until the WG weighs in, NFSD won't offer write delegations to
> NFSv4.0 clients. Let's be sure to document why in code comments.

Thank you Chuck, will do.

-Dai

>
>
> --
> Chuck Lever
>
>
