Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DCD67A3A0
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jan 2023 21:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjAXUKS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 15:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjAXUKQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 15:10:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2714ABD3
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 12:10:14 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OGOIeb028839;
        Tue, 24 Jan 2023 20:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mWdo2GDGS/JWCN5WqHC5E2IkHutdaSXUf0YOHE/hX48=;
 b=nQbVu+qRukQE80hfj7B9lC4x8zSnJ8ZJALqJCeEEvlCBNa5M/7vJ2EB4zRwDWOosolgj
 dnWvpigVcLiUVr8JcofCfZifzvvGb3oY+JYWJFqBXAVnewt0dWqeyMX/uCt6aKvGjNKS
 TEyGfYk1NAO2yXUX5SomnnY96FAB2klICZj+nSzakpgDh8oZqSiHSpSeDvOiZ0eYagDN
 n4JsVM7TvRD3CpB6yHbtKfBlT3CEaO1rjT8kEvEZ8uGVKwJiWXNzkbRIpGY+MlIjvCTG
 +PAtrh5eW8xceZxHq+sPOrsAfNgcW5k93Yqe+l94KLtE53ZqCiRPuEqszBVbQj+lutsa ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ktx8sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 20:10:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OIeXHh005932;
        Tue, 24 Jan 2023 20:10:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g5e7q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 20:10:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsjjmodmstDrIFrA+0UxCvabZobm7yUi1sTW0Ht2k87juf/CjlsyjcRH3i0Mr3cu73pcgmxkHg21FvDhG7f67/CxKPRyJSHI1ZYsqIPpnCggZbZPrA6NNGFIzQhRKjpZjQjEym8zZNVaYYzR6LblHQvb8HJ0uitFaCIxq6hEBe7YDTlWThC+4vy9LhGkV7dLCCEKTzJ+T09dGa1gtuiqF/lORdRfaa5F99hp2ltXIR2trg7gtX0PjVAY79eCg8JGIWbXoIST35AJdKtYcBWqn9TvICjLTjq9HEYFbbvhGewKbljmmMtOf8nz7/F3Tm7e/Vai5tFnfCaMYkaHBVowNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWdo2GDGS/JWCN5WqHC5E2IkHutdaSXUf0YOHE/hX48=;
 b=h5tAQcl1WW7b4OwyTwNh19qefJMZsMn2qkJAAw2VoLRdEbw3n+QM7LVr+eN6gxtLhaCqOwdrKw10lUtvBV5OmanG49zzB6QIuU0XC+BzenPv1GK2GSccZxSuASWzVgu8/+JIUZM7H2Te2DMzD78r98pG4odys2i9jBjtG8hoyeFySv2taAz6+XjUT6mncBQxrUtsss/cgfGwyOCFOSVV4a8i97wmtll7Yp/DZV6FU5yMWRSkfbjdPO0jL28AEn7jTAN0a5kTVu0p3zjThRcwL1iq0jh6ddCRSzmUjXndP/MqQDyYU1dEkMe9ch/3H377G0KHQerSzzxU54VkQNyYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWdo2GDGS/JWCN5WqHC5E2IkHutdaSXUf0YOHE/hX48=;
 b=IPDv8ulBnhv4XdktQYbmOck8wrIDFINgCrGs51/gHkGF/iS2tAw6L13bgu98dqJYVtZZGqiKuKo0qpGfWblU9vyrYWUyyi7P2LM8RTTPe7LcAZxUCS/mhXToEHKG8zkprhlWNiPFvOtti3ECoScl0c+W0GH5S0J3GD2pilH2nQk=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DM4PR10MB6158.namprd10.prod.outlook.com (2603:10b6:8:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Tue, 24 Jan
 2023 20:10:02 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%8]) with mapi id 15.20.6043.017; Tue, 24 Jan 2023
 20:10:02 +0000
Message-ID: <67b6d713-cd2e-252e-f702-7be722dcfee4@oracle.com>
Date:   Tue, 24 Jan 2023 12:10:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/1] NFSD: fix problems with cleanup on errors in
 nfsd4_copy
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     aglo@umich.edu, linux-nfs@vger.kernel.org
References: <1674538340-12882-1-git-send-email-dai.ngo@oracle.com>
 <a6a220ae0645601eefc0d52ab852ebe37d6dff1c.camel@kernel.org>
Content-Language: en-US
From:   dai.ngo@oracle.com
In-Reply-To: <a6a220ae0645601eefc0d52ab852ebe37d6dff1c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DM4PR10MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ec3063-88f1-463f-a71b-08dafe46f9fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t35BLrP7mtBnxSiAfwTTCO4gX56z1kuJ6bl9KazKKuq8HvY2zcNtPeE85+1oUBnKyV9vN/Rjs0+oaB7YRfKuQKaD58QKLrQEd6oCzc3d/8/mVJ3Vr30Z8X2BkfrIsfqKda6DGeklmkSQ9PVxxZfEuko9+1D9lkFuoGmbIWRUi2pi17eLNopgK5DKza/2JqkVmzi5fudzc2q6LVMFTudsflLbpDV98eF8jS+6Rm2hL8qjd8xt+jQMlPZfpf3W+VDdrWh8OV7tRQuqGQftxU7FMkOBheMDt/5ZuX0D6jMsNF0O7m89Vsel3AKikLtBvFN6W8/RHl1RLPHp6Dbd3R9YC4OGElBpcgU3g4YLaDcDVRg/hY9k15/4z1A0ox6XTX1XOp0F7Wt0RJgJpB/DAyr4Fh9/FQH2tpxhdwLTOScw4AltcUV2Xd+7Qa6NATt8swQZ57NpAxBtBEH2pDTYBxVxqtYnrpCHJ14aRcULc5O9RkV9FTBviXgjYVtjhsmMzkdVA443K1HhCBNIIuZIh5NbZKOP3Ht8Snq7LGb8N0aRa5unpqtVcNaOs9D8zdFqCB1VusU+nyxXZ73ndjwDSOspVwt4Z5KCyUIAC6INvyGT62CQnudGfiXzKl8aQtIzqZcs6bpnqmkLNZmpwW/9KeXgtMYK5kZKunDwsiQ3cn0QixFhbwNEGf89ajvA7fFfIKj1P+4RpSXJTfHWcgoCQFs8ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199018)(2906002)(478600001)(5660300002)(6512007)(8936002)(86362001)(41300700001)(31696002)(36756003)(31686004)(38100700002)(316002)(4326008)(9686003)(26005)(186003)(6486002)(53546011)(6506007)(66556008)(66946007)(8676002)(66476007)(83380400001)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak1mUWIxZU8xM0NCSWJHZFFmRnVzTW92Qkp6anpBd083QjNlb0ZXbkozcHh5?=
 =?utf-8?B?M3c4SjBmclB2cU9NWXdlNm9FTWozeTBSb2V6OGtwMCt2bkZBNS9yVjBSWnhZ?=
 =?utf-8?B?OVJJY3NLeW9yQ2g2eno0dnkyWGFhUVdDV1BYN3FacDlOUUllWUdlV2VPMkRN?=
 =?utf-8?B?bHFvejRSRGRUSE1XRCtoZUN5ME1xMVBnSERuRnVRUDFSYUJCTXl2ZVBVOUZE?=
 =?utf-8?B?Skl3RU5kRWdLS1ZTUW94TkVyZ3kydEIxQkRIU0J0cTNtd1BNQUpmbDdEbGJx?=
 =?utf-8?B?WVlBV2V6RUlPQmVwT0E2djZQcjRoNERONDFqOCsyM1hjdEN5dEQrRVh4OE5H?=
 =?utf-8?B?V05VclZKR1FqbHgxV1hvT0pnM0ZFd2tRdjh0NHhFSDk1WkRYMTBNL0ZpUm83?=
 =?utf-8?B?TmQ0WWw4c1dIYWU1eTluWGFCS2VCNW54WmFoc0szd1BSWVJmUEpWOENXRitE?=
 =?utf-8?B?R0o2UDQ3WXdWVUJLMDI2TGw5K2tYc3dEL2luYjF0Q2JKQ1RFNmc3OVVqckxX?=
 =?utf-8?B?SVlGRnB1RXhVaFFld3BNQWw2ckJ0cjdvOXhJQ1ZmdEgvNHl1dlFoUk00eTFE?=
 =?utf-8?B?UTNIT05wSXltSENCN2ViK1IycnJnc3pHWUVJdVZSK3FkbG04ZXVuTjJOcVFw?=
 =?utf-8?B?ZlhXamg0NGptam51LzQ2a1RBQUQrb0FDdVVnbi9sME0zbis3Sm0xaDFpRVZl?=
 =?utf-8?B?ZUZuVnYwTW4wTnVFK2txdXg4c215ZEd4bzFWK1FsRWRmZzkvSzVsbjg0WW5h?=
 =?utf-8?B?VU5jcU1xSUJxU2lmYkU2alUrUW04Vjdad1JDNVEzaU1zK0s2QkZlUVJ6WXFS?=
 =?utf-8?B?OFM2dkwwQURXWldaQmxvclAzN0R3dEpnR21zcWdaS09CZzY1OEpKYmFrdVY3?=
 =?utf-8?B?eVlFVnpHbER4ODgwMkpCRm9ibTdKaVR0R3hhemFJSE5LS0hoa2pJYzZyN01H?=
 =?utf-8?B?L0M3SjI5dGRGWTZ4d1lrbWxUUXB5SkRWTEtkd1llK3JpeWtEY3Y1UVd3eHV4?=
 =?utf-8?B?Ykx2MEF5c0ZSQlBpMEsycHorSktudDRGT01MYitVMzVXdHR6ak1PcTZuSlRX?=
 =?utf-8?B?SFhFaTAycUJBS1JpWTdqRDBvdXJYMkVNelhrbGxTSkREcHNZN3NDY2o0VkpG?=
 =?utf-8?B?V0VYSXYyaEN2cTJJMHFXYzRJU28vbXhYVU52K0pJYVFlNVJpNVJMa3Foa3F1?=
 =?utf-8?B?NXQ3cnNQcDR3TzQrR2JmMkpGZHRIbytvRUxNRFR5NENYclo0RmxoODV3Q2VS?=
 =?utf-8?B?MEdhTTRvalM3dkVOSk55QVhNMitiTVlMR2JUcmQ3QWdRYk1XWVNvZGtJaTky?=
 =?utf-8?B?L3gxTUV4ZnJqOEpTR0xabFRUcmNTZ0QyRFlxaTZab1FnSXVJS0RBcXFLQUN3?=
 =?utf-8?B?eXUzVStOSjAwZlp3TEp5dlNjeG05TGJseVVjMGFrNUpGRHB1SS8rd1dvMENt?=
 =?utf-8?B?dmdjY1g3Wi9LWVMzYVFMUXVsZGFaNzRUR3hMNHBMSk84WVdCUDlmNE5lT3VB?=
 =?utf-8?B?eXBPMS9MYktCNE51SUNUNWoyWWhQMDg3dHB1UEdKTFlGbndoandEb01vVk52?=
 =?utf-8?B?a1FTQlc2aEVPZE9iM3B3VGNyL2QyZEppS3BpWk1oY28vbjhuN3lZdWJxa1JM?=
 =?utf-8?B?YXFDZTc5UXdtaW1GY1lqa2JoN01ESkJpLzJ6RjlOcVN4c0ZoVXgvbk5McEdH?=
 =?utf-8?B?OGY5dCsxWWIvSCtMakF6UldRUnJWajdGZDB1S3dQM2Vyc1Y5WkRiclVaL1Y2?=
 =?utf-8?B?VUNZZE5DVVh2U0JuT3V2aDNZZzBDMGR1blBPd3l5VDVHMUZVTjN3U2pNSmsy?=
 =?utf-8?B?ZGc3ejZNRkFVQXRuc3VuNFJmRHpzQXNSb0I5dDN5WWJmemcyN29STUdCMEdU?=
 =?utf-8?B?NG9QamZLNGl2a1BQbWVKcjh1NEVSWHd2a2U2dkplSHRneUttUTBQZG1GV3Jo?=
 =?utf-8?B?cExGVnhtdHpzbHU3ejVsUmw3ZWN3eFh2dHQvSTd3ODRNYXE1QkdGUUpXTUtq?=
 =?utf-8?B?bFgxRkhzeG9XTVltbUllOTJJYVgvY2x1aEZjdDYzUDFNbTV6TUFSNXBWRm5Z?=
 =?utf-8?B?WDhzNVlGeWZMWEdWMlgxWVNwL0d6WGFoUWRvU3FEYzhFSjlTbEFkaW95WGFL?=
 =?utf-8?Q?iQnGTFNwSSj/AVXb+A4/IcuNW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6Wo8dwWMw5a3mvEHyVMY7QhI99pSH62xGVFuHuIeNjNn40H35Jdx94w0jZlJ0TKgkNTuSnFzMUEGEVkxwVR+u9Tu9c+nNUfVf55jZ+KWdktvkuZSS00Alo06SsQJDXdmhXR9/7zI8qn4aNHuy9PI7Kmacm9/goK2J+Sxo6uZovzjn7ODVL+pKsMO+wxGpndnvghOADJwOt2+MLlHuBxw5kEHvH3C3KgpgGq78AhzWA+v/xh23cX2A1bKI0SDWyHNzpzu2OxpxradNjib58TjTVRbPOlt8rKBHaEUsgOBdNTgFF2WxV1qTNVnBn6KfEsTadzQFhNqegJTe145Mj0VWQKF8DjYg0Jl5vZOtrr1qTKJi9ROISv+Bz5pn8AecYOcAhMqfsN9GH2WcDPrKci7CoFvwc9GTsCjxTmD6MhM8ldMQ1qQtUHAZSS1c+RKeWyBbMJR6C/uf+QmqeFEv7h8O/ZF1engL9mpwOPDxbem3HvTme3y5y8wz3PXeKfBOx2Mz5hSmsymwh52fGlNr+3QQYqMZdlFVSk/GeTly6tOL9qzD6MZseb4zB9XdxhlEOMoS8Qer9fvqDwXLG0Fh7lc8iqkPoQTWqD2xoywdKbcLl6pcP1A1nBJ2m6x/ez6O+eTmvTqujHSEfdwUYbPJPyPLl7DBOL4jIMyAm1UXbZ2s09U4yBPMpi6e8PTNFT0h5rvzemK/rfw9m0Mik4C+1lzFVvvtt5YQaazJIn15gCiciEbw889xhh/ZlN+/SkkAILVoHWJu3dZCY0SonYxxcYqWJHqf+4yJ3rq+yAzdxrAy9xb7mnJFHgcc+Vl3VM8iipE
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ec3063-88f1-463f-a71b-08dafe46f9fa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 20:10:02.3341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8c0n2pzMmCTilvYa4953rDXcN3TXnw9+7yAFh2sB05rRVHfxWMngg0gdlXLbiFb33s8q5DAX9YYflu6Y7LxyVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_14,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240185
X-Proofpoint-GUID: bJOEqMaBpqOehgp2NehHCqD1kNdufrb2
X-Proofpoint-ORIG-GUID: bJOEqMaBpqOehgp2NehHCqD1kNdufrb2
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1/24/23 3:45 AM, Jeff Layton wrote:
> On Mon, 2023-01-23 at 21:32 -0800, Dai Ngo wrote:
>> When nfsd4_copy fails to allocate memory for async_copy->cp_src, or
>> nfs4_init_copy_state fails, it calls cleanup_async_copy to do the
>> cleanup for the async_copy which causes page fault since async_copy
>> is not yet initialized.
>>
>> This patche sets async_copy to NULL to skip cleanup_async_copy
>> if async_copy is not yet initialized.
>>
>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>> Fixes: 87689df69491 ("NFSD: Shrink size of struct nfsd4_copy")
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4proc.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 3b73e4d342bf..b4e7e18e1761 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -1688,7 +1688,8 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
>>   	if (!nfsd4_ssc_is_inter(copy))
>>   		nfsd_file_put(copy->nf_src);
>>   	spin_lock(&copy->cp_clp->async_lock);
>> -	list_del(&copy->copies);
>> +	if (!list_empty(&copy->copies))
>> +		list_del(&copy->copies);
>>   	spin_unlock(&copy->cp_clp->async_lock);
>>   	nfs4_put_copy(copy);
>>   }
>> @@ -1789,9 +1790,15 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   			goto out_err;
>>   		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
>>   		if (!async_copy->cp_src)
>> +			goto no_mem;
>> +		if (!nfs4_init_copy_state(nn, copy)) {
>> +			kfree(async_copy->cp_src);
>> +no_mem:
>> +			kfree(async_copy);
>> +			async_copy = NULL;
> This seems pretty fragile and the result begins to resemble spaghetti. I
> think it'd be cleaner to initialize the list_head and refcount before
> you do the allocation of cp_src. Then you can just call
> cleanup_async_copy no matter where it fails.

If we initialize the list_head and refcount before doing the allocation
of cp_src, we still can not call cleanup_async_copy if the allocation of
cp_src fails or nfs4_init_copy_state fails since:

. dst->cp_stateid is not initialized
. dst->nf_dst has not been incremented
. dst->ss_nsui is not set

The fields above are initialized by dup_copy_fields and we can not call
dup_copy_fields if allocation of cp_src fails or nfs4_init_copy_state
fails.

-Dai

>
> Bear in mind that these are failure codepaths, so we don't need to
> optimize for performance here.
>
>
>
>>   			goto out_err;
>> -		if (!nfs4_init_copy_state(nn, copy))
>> -			goto out_err;
>> +		}
>> +		INIT_LIST_HEAD(&async_copy->copies);
>>   		refcount_set(&async_copy->refcount, 1);
>>   		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.cs_stid,
>>   			sizeof(copy->cp_res.cb_stateid));
