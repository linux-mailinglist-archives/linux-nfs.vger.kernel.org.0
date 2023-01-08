Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAF8661B11
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 00:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjAHXYJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 18:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjAHXYH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 18:24:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB2BD111
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 15:24:05 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 308LPmAT017701;
        Sun, 8 Jan 2023 23:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9AIbpxsqUr01z2RHulepPfVjO8uKDUOy+YkgCihXVbU=;
 b=yyPxWRrtKRzjqZ5XmZgBFNs+Aw2YmojSIy/NTfS2lrFbQtHfINgxTmWPCQym7aaAPLH1
 4saJYff6DpMuPGNeaFZoyya4iUZ4b0U6xovBjQvODC/HZd9DQkEawto+mGZMHS9ammfv
 1Jyqr2/CeqcdhlQqerf/GX7SgCJSDTHL0BjOZUHOyLkbcUPYEf9K5TxzAbC2j2wwYIZG
 Nm2pxgWuoLLl0ILoKep/itFh9UJyCIbbJxkvuWiBYcdg7NUgbyMcbiGKJEm5mxWR7zd2
 hXhyecDUURefDsOK/nwHUCL75lBJtHkE3EJ095ChrAZkfmQQ8VLyvlU0L+Paz572jQS9 5Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n033br4wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Jan 2023 23:24:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 308L5og3008137;
        Sun, 8 Jan 2023 23:24:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy69by4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Jan 2023 23:24:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F42bZ/9Z5PrjC2G8bHmR+b3s+ybwh3z1Dad8DVxn2zbxlAscSL34fGuzkVavLrg1ObR+VIkb5sY5Kt8atY5OF0zXaRABVoLuZz8EanbRktzdXA26isTZV9r2A+FrWmt/AD386ztvETkE3KFogW3hL21kGS+rnCAIbz00v9nmun6airA9gJySEpWY/jvT/zVbDsw1x31AXo01PRO5JAhS6lD0e2gMkSyLL91tJlFx42EE4utOSmdltIPSM+w9Yhl2yrqdVtkBiIgJlu70wfJOZQexPg2FawgNAKwWoHQbpwPHiNG8KFe4cbxfGX+kFtbQh3aE2XIEQZ9oU6Ja3ZMpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AIbpxsqUr01z2RHulepPfVjO8uKDUOy+YkgCihXVbU=;
 b=mcVQpI+QVXNS02AQxS1QauRiacldJZ+rmTy4rwnKUrXQXa8xehkiWlR7iQYGCjWv7wl/H10l6VRr+7EU3iRDgvfmdL3oquVkvI2vqE1msk+6dygO0Odw7C/LFEsMZw4lOYV0bJxIhnzHkxmHKM08PUAy3WH4iUxiZ+FxOCwNXwN9IjthW/2ycctx0hIubYuxzz5LVAQQ+TbRIDBVp8ciw6ZJHsJzRlHS2AqoJ/08laK4tMZdGqX7N/lCgNzVQk7wMAwM2L1K84N09ExiKYKCcpO9JayO+YDXupI4aNQOmn0lXfq+nnQhnKtjVlKJZqgXuNKm2/NRq2oqBBKWh2dIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AIbpxsqUr01z2RHulepPfVjO8uKDUOy+YkgCihXVbU=;
 b=WAnY6GoQvV7vGHeUNViZsCPNME+hdrSABhKeTek4Q7aWj0zHKKxMPnqe+GCR43xlvP3E3ThSyMR0qFThGWgwQtkt5hZH6b8Hor205dkkIyhaGOAOb672pr2B2Zvur3cYvBr8BWG0lQ8vU96f/yUK5L0kmdOLL7aKoVDdkbL+I2Q=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BLAPR10MB5091.namprd10.prod.outlook.com (2603:10b6:208:30e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Sun, 8 Jan
 2023 23:23:59 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::940c:19a:12c5:e152%6]) with mapi id 15.20.6002.010; Sun, 8 Jan 2023
 23:23:59 +0000
Message-ID: <445f3dbd-7fe0-b16d-227b-b545d6cf604c@oracle.com>
Date:   Sun, 8 Jan 2023 15:23:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: NFSD: refcount_t: underflow; use-after-free from nfsd_file_free
Content-Language: en-US
To:     Jeff Layton <jlayton@redhat.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <3c525b04-ef64-2bee-efc9-9a43069306f7@oracle.com>
 <830543ab-10e0-3a62-c683-8bd95292db4b@oracle.com>
 <a456ac8ccdb54f4d661fae5ef090d63d0bbcc690.camel@redhat.com>
From:   dai.ngo@oracle.com
In-Reply-To: <a456ac8ccdb54f4d661fae5ef090d63d0bbcc690.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0072.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::28) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BLAPR10MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b066d72-efd3-4ebf-9529-08daf1cf6b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Tdxb8JR4yRJaEfHMYDdBoNcf53AHmuEa/P4EqkAQ2YePgg+jj1haS9rypOoTKAhqdnyvBBIrQR3Kyhu7dIb7gU39syAq07UABDSw7fUiapCpGIZpzl/dsntfJ5JVwtOsQG8Ve44U3DN9Mj/4bb5wSJcF9gDB3odMIxpwBJFmdMGZu+nJWoVWAJrMIe6D3kW5UgnR7aHbNvHN7jkD8PU8bdqm9DZBBpSsCtjkm+cWoB6S0xYWU2bY3dBCQHMLFCCDH81ZKMIxBZPVhTve7lZM1FCjkjwioAKa/+wAz6ybVJSyzajm+l9SwYcY0lygljXUO1lyTP3B3s76n4EpriEtw13aSVkL8HFmAbUezzKQ9t6b41ECFtWrGY0YAa7IN+3GQzMaoDtyFWSsMQ1P7C3u9nfV1qYa4mmKvXpZSRV/lDWuu72DJbiHB+XewVWM7E/xeBGAELl/KMP3dpaIHANo5dTHBFa60xoQKuIb6z1zv6a5F9D0zQJqcpJy7h0pwXobF3FNl0xj9FjpqX4MX1xPUToxBEk1CYP5tMPLFxXcBwp2Gl6kM9ol+5WT70J1WGv4We0EeBvyGGENrbAd8/qemJlwpfUh9Gv+RLhkxre1nFX72KU5CH6CeR9ycZXEY5oAXL2ELokesWi5IdqEcRD1JO2EsS0VHwQgr5ILDc4GRrEltTYDo4bTzADYOWWzMeg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199015)(38100700002)(86362001)(31696002)(83380400001)(66556008)(66476007)(8676002)(4326008)(66946007)(41300700001)(110136005)(316002)(2906002)(5660300002)(8936002)(2616005)(9686003)(6512007)(186003)(26005)(6486002)(478600001)(45080400002)(6506007)(53546011)(6666004)(31686004)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTRnNGw3ZzloeWhhK1I5cjhjM3A1enlMVXp3eUhYVUFmZ0NyZnY5dlIvSkp6?=
 =?utf-8?B?VWJjaDU5REd4czY0K1pCVWY0d0tNYmdMb2t4bUw1dit3akxuaVA0RzFaN2hW?=
 =?utf-8?B?UTVYaWdMRElqU1NoeVRUNVc5YUxnZTVhM3FuNGxLMzdLcE1tWG1IZEJjUFFF?=
 =?utf-8?B?aTh1dmgvSGtYeXNVVE55Rm9tQ3Y5dnBaeCtLcWhMRThkckl1bWpkZE5qYzht?=
 =?utf-8?B?SEh6Q3A4RUFPSnhzSkhuME1lTHQ2c2pJY0VKV0lhS0pwR2RheGg0TzNFRnFU?=
 =?utf-8?B?bGsvQ1JSRVpCRFR5VU1EVTVFMUpsc2tRV2hQY09ZRXVoUmdlU29zSWsrU2g1?=
 =?utf-8?B?b0tIRDIzUWI5RmFZRGpEUGNoOUpNeTl3VVMyWkpxcC9XNDlZaWR0SXdUYVhk?=
 =?utf-8?B?RUlnQUtyQ3p6NzhFZlVabE1rMjdxSWhDT2pPbmkzTnF6a2NPa1ZITzZPRUNv?=
 =?utf-8?B?blNZZ3NZZzhvd2NGVW9oMzlHelNhQkNKTWxBQkg3ait0WXZnekFBTFFxNE5i?=
 =?utf-8?B?VXRXV093TURMMGVBNmxnU2xtcUVpUmJEajhSM2FZNGxWSWxCWHBFbExmVHhp?=
 =?utf-8?B?dXN6RGt0aTZTUm1JRXczVVkyaFdEZXR3c2pFMWNPMXRuaGpOLzJVNTgrOTdT?=
 =?utf-8?B?bVdMWjNrN2FtTU5UZ0pyZmZQYlpDRXZReXVyTWJySkNsSk9zTGd4aHVGalRo?=
 =?utf-8?B?R1QrWG1Lc2hESDlFUmI3amZqSno1RkxOOXYvVzVNQWZKMFRLNWFDUllCVDJ3?=
 =?utf-8?B?ZGdjNkM0bzB0d1JpV01VUG5BU0pLcVR6ekJZY2NDYkF0YW9MS0xqbzB1akdl?=
 =?utf-8?B?UUxRYlEwU2pCaVFhd3hSdW5PM3E3VW1CczlMb3ozUGR0dFF4T3lJZEZmb0lx?=
 =?utf-8?B?MUdEVStsTk94MER6YUt3Y09rTDFDZWd4YndCMDcydFZtdndSMXNja0JIaWZ2?=
 =?utf-8?B?c1ViVll1cExFbC9UdGhuZmFUM1I2Wml0VDNuVVpoOXdHQ0VtQlZmTmNabUh5?=
 =?utf-8?B?NXdWTCt1WFZUL0hPNzViR0ZNMHpkOHJkbUdKVFZUM0FRaiszVCsxN2lRRXJ1?=
 =?utf-8?B?eGRMOUpnbTRBcStFU0lxZmRZTzdWNHd6MWdHeE5sdGxra09vTVhLbzduMGF6?=
 =?utf-8?B?dzN1QkNtRXcxazhoc2JRb0ZhQWF2UUdBRVBodXBTbkdnRmlIYjNjdHlhbXZr?=
 =?utf-8?B?MzZHRE9TWDh5dWZSSnVxL2xpeHhLeUdySzVOS0QrZ3VnV29JS1psV0JwNmRv?=
 =?utf-8?B?N0VFMVQvRnczdXduNDgwQnBNanNadS9NUDZLSFFURUJZeE9ZM2dyWG81c2Mz?=
 =?utf-8?B?ZU9ObytMQlhMQ2k0WU5HL25EVzB1cTg5N2FEWXQ4WW5ES09ZeDhCV3g2elN6?=
 =?utf-8?B?ODg1dHZsZ1JSSkJyNktOWWIrN3Zjc3ZLRnByamQrSXg4ekI2a3EzODkybVBv?=
 =?utf-8?B?SmtnSUdIbktBck5vdkdPbmU1eGZ1THVoWGk2UGZtdWZrcHRrSXJZRDhvTG1R?=
 =?utf-8?B?SFNrTGlVVzBSSloxN3l1eFJxRFE0Q3pMeXdmM3hmcHk5cTJRbnNKK1hLMkpB?=
 =?utf-8?B?d2ViSGtwSm9Vd1NXdEUwQk5FV0Q4c08rMlZUWUVMVmxOTnAraldDSTRhOEFy?=
 =?utf-8?B?L0RvNVVjMDlPUzdHSXBmOC9xckFSRDNpZ0lOTG5DdFNBbWNwMTBkb0s4ZHpk?=
 =?utf-8?B?U2pDUEk2clBKOUtxQXNodlQrTEZJa2h6SFZ6cFovU2gwaXErRGZOeG12VTlz?=
 =?utf-8?B?eXhpT0NlWjFGZ21hZkxPcHFEK2JlUzhiZDF2VlFmMGNONktTVGY3TVQzZVl2?=
 =?utf-8?B?ZDdvMi82NWV6czlkeTVtNHNBZU9QZjRHTXpRZ2ltR1djaG9vSXB3aVpESDEw?=
 =?utf-8?B?S2Q4WlZPWkdvRU9UNHV4QytFbi9rbmd6OEV4ZDdJbjhET3g5U1Bncnh6NWI1?=
 =?utf-8?B?NWh2Y2U0RStsRXYvV211WVVkZ3lSZk1FN1M0azlScHp6WXpEc01pcWRaQm5r?=
 =?utf-8?B?ajlLWXRpczR2R0hDakpUWjlxOUNOUUhmZlc4SUpwN1pRZWVQNUphd1F1cWl6?=
 =?utf-8?B?Qm9VdkhMWDl2d0JRb2JKdWRWN1VKblFrdDBtSVdrTEtOZE9BRGhwS01MWWR4?=
 =?utf-8?Q?meAnu9qhOkE+rRiyYra5gFQpG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5HL48MNG+gVyur16BEQZi6usFbwI8JHoPc2XRde3uEuwQmqTfX/KDnshyf4x+JAPJxtP5W/hJsL9pGp/0nX4g6hxMykQ7f78IqpTBdmfQT5a0SSy4NDk6G857L72qJyD+OU+WDDav3d/YPdJy1zpkr80GNV9ibEr7a+wZzIohNYMLkPaGjIv6YAIbBSKy8OPNGjG6iIIy0AMF6R90fk9rUEkSPJgnEK77OalssrhwJ4nozaO3ESRkLtB4EG0lNW5cSTmqOO9IIYi5Un1bh7McDdGlbk/6qw4Qm7Tzu42hqtzZX3V4WrQqEYe5Vv54Aj9Nl4/aGrsA4G06wqNCbnQNmbYwQm13z7rAw7Sv8ChOIfLA0YJVgZZ8xfdGXStT5LI9+XQOBF7cYg9/NPi+QUJtWdpCsG63nZyTaGQm0uQt6AEcrlsGEI8QvZXMOsEU1ton6le7P8HraZ4L9cYznAIbYCgqrvybIYEUVFPV5hUCP6kyArMOyUzj7msnYKOCO4dRxYGg6GU/N83dU8YBpyM4raZz1xZskNnlBZqVwhPIs9V8OXqnVtl1q9GyKcySyDv5VlCmW+Gk8EO1GppdBJcM8VjQVI6zcnUd4ZEc/83m5xDlwxud9plQ/wUhDP43/baukqJ+ZS8sPVQgpQ5sjKh0+Q/K2c7VsGf5xq5Vw+0piiPG6uGPL9aTLG/bgZfgDQ9IgbeKfy1QcIRwE9edDlXKMnFKEjz7V0poRBnxLUu1EF4gvQsT1J/F4z8r6medFcL12dn19x8nkQ3xAQLw9AFKSWTPEX5sYvSsfbbEQX7aQ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b066d72-efd3-4ebf-9529-08daf1cf6b3f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2023 23:23:58.8855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ndtd6sltVlpy1x///KpYnTYFXrDcvET2WAEkGWa8NHb5/ne0A0WhWs4Uq3iEaCA0YHyaMtNYr2wVz9rT2+vP8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5091
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301080173
X-Proofpoint-GUID: xvB4FyMhT1U8opKJk1e1P0lflGLVsu1g
X-Proofpoint-ORIG-GUID: xvB4FyMhT1U8opKJk1e1P0lflGLVsu1g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/8/23 2:23 AM, Jeff Layton wrote:
> On Sat, 2023-01-07 at 14:04 -0800, dai.ngo@oracle.com wrote:
>> Hi,
>>
>> This is a regression in 6.2.0-rc1.
>>
>> The problem can be reproduced with a simple test:
>> . client mounts server's export using 4.1
>> . client cats a file on server's export
>> . on server stop nfs-server service
>>
>> Bisect points to commit ac3a2585f018 (nfsd: rework refcounting in filecache)
>>
>> -Dai
>>
>
> This looks like the same problem that 789e1e10f214 ("nfsd: shut down the
> NFSv4 state objects before the filecache") is intended to fix. That
> patch was not in -rc1. Can you test a kernel that does have that patch
> and let us know if it fixes this?

Sorry Jeff, it's my bad. This is fixed in 6.2-rc3.

-Dai

>
> Thanks,
> Jeff
>
>
>> Jan  7 12:15:56 nfsvmf14 kernel: ------------[ cut here ]------------
>> Jan  7 12:15:56 nfsvmf14 kernel: refcount_t: underflow; use-after-free.
>> Jan  7 12:15:56 nfsvmf14 kernel: WARNING: CPU: 0 PID: 10420 at lib/refcount.c:28 refcount_warn_saturate+0xb3/0x100
>> Jan  7 12:15:56 nfsvmf14 kernel: Modules linked in: rpcsec_gss_krb5 btrfs blake2b_generic xor raid6_pq zstd_compress intel_powerclamp sg nfsd nfs_acl auth_rpcgss lockd grace sunrpc xfs dm_mirror dm_region_hash dm_log dm_mod
>> Jan  7 12:15:56 nfsvmf14 kernel: CPU: 0 PID: 10420 Comm: rpc.nfsd Kdump: loaded Tainted: G        W          6.2.0-rc1 #1
>> Jan  7 12:15:56 nfsvmf14 kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>> Jan  7 12:15:56 nfsvmf14 kernel: RIP: 0010:refcount_warn_saturate+0xb3/0x100
>> Jan  7 12:15:56 nfsvmf14 kernel: Code: 01 01 e8 3f 21 65 00 0f 0b c3 cc cc cc cc 80 3d f5 d1 4a 01 00 75 5b 48 c7 c7 c3 4b 22 82 c6 05 e5 d1 4a 01 01 e8 1c 21 65 00 <0f> 0b c3 cc cc cc cc 80 3d d1 d1 4a 01 00 75 38 48 c7 c7 eb 4b 22
>> Jan  7 12:15:56 nfsvmf14 kernel: RSP: 0018:ffffc9000078fc98 EFLAGS: 00010282
>> Jan  7 12:15:56 nfsvmf14 kernel: RAX: 0000000000000000 RBX: ffff88810e8a9930 RCX: 0000000000000027
>> Jan  7 12:15:56 nfsvmf14 kernel: RDX: 00000000ffff7fff RSI: 0000000000000003 RDI: ffff888217c1c640
>> Jan  7 12:15:56 nfsvmf14 kernel: RBP: ffff88810cbd7870 R08: 0000000000000000 R09: ffffffff827d9f88
>> Jan  7 12:15:56 nfsvmf14 kernel: R10: 00000000756f6366 R11: 0000000063666572 R12: ffff888111c9c000
>> Jan  7 12:15:56 nfsvmf14 kernel: R13: ffff88810fb5fa00 R14: ffff88810f980058 R15: ffff88810e6d68b0
>> Jan  7 12:15:56 nfsvmf14 kernel: FS:  00007fa614d16840(0000) GS:ffff888217c00000(0000) knlGS:0000000000000000
>> Jan  7 12:15:56 nfsvmf14 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> Jan  7 12:15:56 nfsvmf14 kernel: CR2: 0000559a53e66908 CR3: 0000000110c72000 CR4: 00000000000406f0
>> Jan  7 12:15:56 nfsvmf14 kernel: Call Trace:
>> Jan  7 12:15:56 nfsvmf14 kernel: <TASK>
>> Jan  7 12:15:56 nfsvmf14 kernel: __refcount_sub_and_test.constprop.0+0x2b/0x36 [nfsd]
>> Jan  7 12:15:56 nfsvmf14 kernel: nfsd_file_free+0x119/0x182 [nfsd]
>> Jan  7 12:15:56 nfsvmf14 kernel: destroy_unhashed_deleg+0x65/0x8e [nfsd]
>> Jan  7 12:15:56 nfsvmf14 kernel: __destroy_client+0xc3/0x1ea [nfsd]
>> Jan  7 12:15:56 nfsvmf14 kernel: nfs4_state_shutdown_net+0x12c/0x236 [nfsd]
>> Jan  7 12:15:56 nfsvmf14 kernel: nfsd_shutdown_net+0x35/0x58 [nfsd]
>> Jan  7 12:15:56 nfsvmf14 kernel: nfsd_put+0xbf/0x117 [nfsd]
>> Jan  7 12:15:56 nfsvmf14 kernel: nfsd_svc+0x2d0/0x2f2 [nfsd]
>> Jan  7 12:15:56 nfsvmf14 kernel: write_threads+0x6d/0xb9 [nfsd]
>> Jan  7 12:15:56 nfsvmf14 kernel: ? write_versions+0x333/0x333 [nfsd]
>> Jan  7 12:15:56 nfsvmf14 kernel: nfsctl_transaction_write+0x4f/0x6b [nfsd]
>> Jan  7 12:15:56 nfsvmf14 kernel: vfs_write+0xdb/0x1e5
>> Jan  7 12:15:56 nfsvmf14 kernel: ? kmem_cache_free+0xf1/0x186
>> Jan  7 12:15:56 nfsvmf14 kernel: ? do_sys_openat2+0xcd/0xf5
>> Jan  7 12:15:56 nfsvmf14 kernel: ? __fget_light+0x2d/0x78
>> Jan  7 12:15:56 nfsvmf14 kernel: ksys_write+0x76/0xc3
>> Jan  7 12:15:56 nfsvmf14 kernel: do_syscall_64+0x56/0x71
>> Jan  7 12:15:56 nfsvmf14 kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> Jan  7 12:15:56 nfsvmf14 kernel: RIP: 0033:0x7fa6142efa00
>> Jan  7 12:15:56 nfsvmf14 kernel: Code: 73 01 c3 48 8b 0d 70 74 2d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d bd d5 2d 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee cb 01 00 48 89 04 24
>> Jan  7 12:15:56 nfsvmf14 kernel: RSP: 002b:00007ffc79bf4748 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> Jan  7 12:15:56 nfsvmf14 kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fa6142efa00
>> Jan  7 12:15:56 nfsvmf14 kernel: RDX: 0000000000000002 RSI: 000055d4cb8093e0 RDI: 0000000000000003
>> Jan  7 12:15:56 nfsvmf14 kernel: RBP: 000055d4cb8093e0 R08: 0000000000000000 R09: 00007fa61424d2cd
>> Jan  7 12:15:56 nfsvmf14 kernel: R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
>> Jan  7 12:15:56 nfsvmf14 kernel: R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000001f
>> Jan  7 12:15:56 nfsvmf14 kernel: </TASK>
>> Jan  7 12:15:56 nfsvmf14 kernel: ---[ end trace 0000000000000000 ]---
>>
