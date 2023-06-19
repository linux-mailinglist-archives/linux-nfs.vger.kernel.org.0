Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F76735CB2
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jun 2023 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjFSRCw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jun 2023 13:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjFSRCg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jun 2023 13:02:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748D8172B
        for <linux-nfs@vger.kernel.org>; Mon, 19 Jun 2023 10:02:18 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J9n5MQ004103;
        Mon, 19 Jun 2023 17:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=2t8oa/o9iHeoPrQgsd6aR/XpVe6r33GG0t2tJ0bvN34=;
 b=N1MckCnZKGi0IqHosur8I/sUtPE7o9y+3YXXXDuNkCMw8gGvSKk26FcS/7NEGc5kCGS0
 J4/Mmf6msaBl8T7rrBzB2xGq4ZSSEbbJ/mpCwvb0WwZCGah9XF/7QO7X5nXkK8xR7mUh
 LnBUbgRDVIYGzkntpBzEYAJFdEiK5uA6BaKgEdaGu2wfZ9VBE+uTofGpjcFdzV69YRsZ
 P0gwnPhXOSGvgK89vh+196H57UOq0F7zSKk6l88m9PNTeScKOYt6wWN8zUlCUQsbLW80
 QFc68HxAVoDLdRGip7yqgtS9k5BGeaPF74oggH45raECQWo5nDVLnUl1jr4kajmvo41D sQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vck397-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 17:02:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35JFXna0032814;
        Mon, 19 Jun 2023 17:02:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9394m9jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 17:02:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9G89gxKCjFr4YiMBbyBbsTgqntitYIognr33NbIvifbQ8vuinmUXknQc/okb8BL3FfWN1ZuvQaL467dwDIJadr/MZ/L/NZJ4JS9k5YjNNhQf2XwxvivN2ge8ZjoVPJPLKKq0S4Cz91XBuHzm57S835NtTO2kMfs7CavIdM4IgDt4Nj+BXZHikiwPnglqA5PFhFb+KBxBffVTncOw/3VY2geOwSKgPmZ0tugF8GF7cQGg1lPn2LCga0QifHDccd7PddR34Oqbigg9feEZXheUGNmindfXFWt1NqeOl46vXSSd8Cd3sRrEBSWOigE60Hjh5KzZ7GSUAWPFWtKM1yOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t8oa/o9iHeoPrQgsd6aR/XpVe6r33GG0t2tJ0bvN34=;
 b=QnIcYgvWeu1xv/lFapZpgw7upjHWQmw4Z7R/lB6hZ737SUym+sqlkzKQFfBmWBeVQXrLOh5gTCLJWYfJEbJlb9Uh/NNpsTdi2kemJkEX2eU47IndI/WRNXi0YpAfi45hG6a+QVOhFRscu5C9Uebe92MOdJ24ythnGCvNOzzkDy51S7HHotXRCVv3HYkS7X378ezUqXc7uLLoQUPa6C4/gW1Xpmpoz9+ZsWuTkRQf3EAQmzb6VLRKNPvBN5esN4WUJXR47itHIHjuwO75HVKUkNEMit73YZ9ZYEzJvDf4S4yWnx1eK2i6bxQK/YzsrqccNwGw+vw3gj4t6I8lNUnIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t8oa/o9iHeoPrQgsd6aR/XpVe6r33GG0t2tJ0bvN34=;
 b=Qb38imiSXKSiRCVpgxq4e7WXXixoXaDoQWsAR5otikZtziHTQg3BRbwxJEP4ACl3/TJCVsdmoI15IDhPbjeOJ5Jrc4ldAmNisncCaS6PdhYFUfwh0iIFfiRWvbUa/KR2CZoo3LCcb42ubtV6i+pnQqwv92Q+dmQgpeesm7536BM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SA3PR10MB6969.namprd10.prod.outlook.com (2603:10b6:806:316::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Mon, 19 Jun
 2023 17:02:14 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8967:3473:fad7:4eb]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8967:3473:fad7:4eb%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 17:02:09 +0000
Message-ID: <f9651599-846e-3331-9353-8a8264de1a27@oracle.com>
Date:   Mon, 19 Jun 2023 10:02:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From:   dai.ngo@oracle.com
Subject: NFSv4.0 Linux client fails to return delegation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0033.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::6) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SA3PR10MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 3141e73b-0ae9-4bfc-791a-08db70e6eaf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HEStemmQjUUb7nwIWBFbpzTI0IBwrpRjO+PAwZY3RYgqEXuj2US6++idj+9ch14vCthYUJlYkcKyHC2PRBkQiAEZy24jPRjYAyX1n92HDQwpbcuYCQdcvqYypsSlH7/HLz91AaujlYbKf7UHEuYoMF+8v7y4n+OZ04+zw3VQDkaWxdEoTSvUD9DTgPX783nGlgBVa8MDcv6PavtiNbVpm84m3KO62MiF47XGdI7g+HebPgnK4lwPdFankWKJ6S4SJUJobst54sb0/2Ah7wh5/qJzGwompLY7xgpO5Z149ZelfVpDen5DSgPaDpHeG7z8QvfMq6Uv5cEfFzVP/q720WZH6iJcKN0k5g7aDqlnWhWdkmN2e3SAaROvFZJWB7phXKJKT7MBeJTmWsv0yKmZ/bznCbDs9udCKPByDCu6RNiReWIiDb+B12LGN0cIgdsO/U10nsjN8+aBHEb7/hKfucWaZ4nKF3HFuYKQ2eFJjH5/Qg8VcKHwLek+UoAzYCBN9DOupmeNSbFRCf4JZ5OJy7Zxc2TO4k5hw5eolNEVjw0ECUg+fFO0NUJjXQQGxX3Ai8s/ssnSXqrRoIHhUEA2h9Ps7oni43ZglT9oC9/9Zv+6BoYRFXGw77AWc+zv9so
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199021)(6512007)(9686003)(6506007)(26005)(478600001)(36756003)(186003)(6486002)(2906002)(316002)(41300700001)(8676002)(31686004)(86362001)(31696002)(38100700002)(5660300002)(66476007)(83380400001)(8936002)(2616005)(66946007)(66556008)(4326008)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3YwWExBRDJHMVhVc2hvTHFGUHd3dnp1enVFRUI4TExYYXF6TEw2OWtNYzYz?=
 =?utf-8?B?cXpMRHlDK25oS2hMK2RmSnFINmxxSUdwbG1nTnVXL3dpMTZUakhLQXhTM003?=
 =?utf-8?B?OUVWcWRkNkFJMU9mcDk1WWVsY3N6WFR4YTdMMDZvcU5pLy83cldpdWlaZTcy?=
 =?utf-8?B?ZFNKRmI5RWVWdmRhN0xoU2VOZThMRkNWUEJQUGNHaEdJdngzOXVFWHE0SEg2?=
 =?utf-8?B?UFQ1WUMxOXVhdmN2UWQ5SGRhUW5IYnRxa2p0YytCSDVUUEtGekNVYUdaaWx1?=
 =?utf-8?B?WG5WVzNndjhIRGtUNGZSVGlEczZWNUVxUXJpRUdXakljMm1tKzBPeXpIZzA1?=
 =?utf-8?B?SndXYlVjT3c3ajZFYVRwSEs4TnN0OVVTZjEweEFldVhFN3pVZmJYSXEzelU5?=
 =?utf-8?B?S2lwelR6eHlpWVJBb1lCMW9vV3JXcm9NS1pSVjhBZGV6V3JvRkFMNUl1Q2hN?=
 =?utf-8?B?UEFRbnI5OTN6NVR1dzBHN3UzVXBuS3R5dENZendkSHVjbGFKRVdBa1pwWkRs?=
 =?utf-8?B?Sm0vNmt2bWduYXdkS0JxY3hqQ1l6dHAyUWVvUDRMUjZTdDIxdXU4c1ZleG9D?=
 =?utf-8?B?ZW5wajZJdkJKLzNkdExtTjcyYTVQNVRGamJycHZNL05mV2xyYitOang2cW1P?=
 =?utf-8?B?VERUQmFCTlMrcGxpOE5SU1lRektzdkZhQ0xxaWZCSCtodEJSbjltL2xhWEdS?=
 =?utf-8?B?bVpIcmk4YXJ5bWd1Qkk0ZEZQOEZkU1lGY1RNZEVJZ0VTQW1aM0Vaam8yNGs2?=
 =?utf-8?B?ajdGSERJdmdrKzZpQ2M2bXFEbEhKZ2kwdVZ6ZHBiOTdBWXQrRVRUOEF2V040?=
 =?utf-8?B?Y3ZoZGlKZTdzeE5rOS9jYXgzSm9nUisyenFXOXFuYm1lMmNzTVE4QkVLYjcv?=
 =?utf-8?B?c2VLSUNYTWRUVTZwZk5JM2NBeWVVRTVIL3J6YUR3NXFTazk3WWZBQTRjbS9U?=
 =?utf-8?B?eVp0ckE3dDFLOG1lZ2xtMEs4ZFFSazNsV1pPY0ZPOFh1M0xtamtUTTF2b3p6?=
 =?utf-8?B?OGFGeGgzRWtpT0hwSEg3aUNpLzFYL1NjcFA3VlRzQnpDcXB2WURhQW5EWWU4?=
 =?utf-8?B?a2I2aHlKK3poRXdRSXEwNURTamZsTkFjTFB4SkNvYXdDWlNrWUswK0l1aDgy?=
 =?utf-8?B?MFk2YmV2TVZndzA1bVFIVTBDeGRKMzlYaUVyZVIxbWNHVDErNk1nckhGVGhZ?=
 =?utf-8?B?WFlha0VqR3BYV1hnVkR0Z0l6Vm9KcnZhbHRzV0xsSmtENXg3NXYzWHRuV3Ey?=
 =?utf-8?B?WVl6TlBUZ09zRUN0cStmUXZTVGdmOHBOVEpmendMOCs2aGNiZGNlTkNuYkxD?=
 =?utf-8?B?aVdVaHBxQi9PcGVkMDdnQUhNR0hJSkdWOFdST25KZWtCNlRPY3g5SURqbUww?=
 =?utf-8?B?QURpeDhydDRvNG04S1FCRGZtZEZUZi93T2l5L3hwczFPM1owa3F1VmRvY0xn?=
 =?utf-8?B?QTNjL0VKZkg5aWovc0EyN0NWK1NUUmNyb3RqTWJpVkNJTDBCSllNZkZTNFNW?=
 =?utf-8?B?dXY1OHR1WmZGUTdhYld5ODdSaHJTVmVsVEZNVDFkSEFlK25JOGhOdTRJOHo1?=
 =?utf-8?B?cm9XcnlibFBvWE9xVzB6OG5QazZDQ1UyU1QwclQ2NWJRV0FQMTRlMVlJV3RE?=
 =?utf-8?B?NjJYMGJvSk80NWwycFdIb09KcWdNdWZ5bVQzdXlYWElidWxqNkR6VThJRWI5?=
 =?utf-8?B?d0hNWVFDMVZVMUlOTkxvaFBWRHo4V01GRHc0cUJtcW5WTVBDRkUrRTkwTDYv?=
 =?utf-8?B?OTVnaXBGREdPeGN5RW9NOXlSc1FNRWpPOFFzSTFxV3ZHb3RtVjdaMlNOd053?=
 =?utf-8?B?dFBGNDVwL0ZiaVdZYW1FbXZYbHFKY1N3cmw1TkZXUzlDellUdkZPNStmM0tz?=
 =?utf-8?B?WmRFajNhWlduYmhpVXNkbXg4RVB2bHYzRFFWdkxybDVsSXJ0bHVkWkFxeFk3?=
 =?utf-8?B?UmtmcWl3VG9KWGR4YURvaDVhSXZSS21BSHh5S0I5RXZFWnNnOXN6Y2VWcjJC?=
 =?utf-8?B?d1lqSDdvQ3VwZXdJWElGalFpTnNYUC8wMVViaDlkUVNBYzg2OUIxTTRYN2hC?=
 =?utf-8?B?d0gzWVJLUUo1OEhjOHorMEp1L1hidm9YS2ZnNVNLOVo4V0ZRL2l0Wm9FZUtL?=
 =?utf-8?Q?FZqjtKfANqStNEYdSvss5w6qr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5FonEHXhZSdux2ctPCXv//IB80hU+Mcv0wVEUSfI9oH4VoLrOpp9EcQLoFo+pHCBI1EaknnzW/HKQO9+jfs2uTmL7rXNnFwM+DINu+TdR+uqcd7UjbKaxoq9PpEAIyNXmcBQiknTz3elhk8ECq9BgwHMulkf/jpVeXCCgbojt68THDHXsLR00e1FvVdLtfe16qohddlsOhQ2VQ/Z0b+20WV/Eist9Vza6UoJ2mYLeKQqX/+z5gjdxSKPf6mtCANlea/dIMATZKJKye6Gb4eg4IEgrVvQHD7fIMoNSzXT2wsAfQp3gW0uM8qCYVcmC/XrVYVPknM13HCOWo7yez/ROK7u8mh7jT3Trvqac6k5/Imgjm8T94S4PSIuxBtsbeYikYgaTf36Rapo5Jq3JLm660KOeocHMVph4qShol1uuZW2AKM6trxGlmp+4Lt+4dA550+VkJkyCAbG7B/Daap62veprUDAuIF4ocD+O7HeNWgOXyrnY0lD0MdX01LV/exEZ5hTi2uHoP0f6rWVrtErLvKqE9dADht5nfpBTwdAzuNBGh8F0ivnONl80tPvm6OjNYvWheGHpFIaqmG891PAXBmOD6gVK9vHTXSyLShwOhjXiGlOE4vSiiPJNtYmagxpadOdhbBRPMRQ6WCzPpx4ajiP73QJt1J4TUBmlV3iKYQhUsNdQCXT9fNG0b1oyTzHgDC60RUBvMnDAj4XeN0nYibfPp3RMTyv0jc9GxjbsJ+hd+U0RqL3PCTSyPuGhgEEewsHUZP9GwlPzWxNNyzJc0qmW6iR9iQ3tIuDUtjPUaA6XaYnDZuiZNFTq/1qTz5Z
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3141e73b-0ae9-4bfc-791a-08db70e6eaf8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 17:02:09.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oounsTOkCcIaMnkSsmsfJKPGqCElK8Hs4HGfQ+qAgaS7Ftp6CLHeqHv6gQdrV+OlHEPXJL1/vpABIO+mvgUC0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=919 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190156
X-Proofpoint-GUID: EUWlQyNAhDbcwvm77LSKV1cjACh-QS7k
X-Proofpoint-ORIG-GUID: EUWlQyNAhDbcwvm77LSKV1cjACh-QS7k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

I'm testing the NFS server with write delegation support and the Linux client
using NFSv4.0 and run into a situation that needs your advise.

In this scenario, the NFS server grants the write delegation to the client.
Later when the client returns delegation it sends the compound PUTFH, GETATTR
and DELERETURN.

When the NFS server services the GETATTR, it detects that there is a write
delegation on this file but it can not detect that this GETATTR request was
sent from the same client that owns the write delegation (due to the nature
of NFSv4.0 compound). As the result, the server sends CB_RECALL to recall
the delegation and replies NFS4ERR_DELAY to the GETATTR request.

When the client receives the NFS4ERR_DELAY it retries with the same compound
PUTFH, GETATTR, DELERETURN and server again replies the NFS4ERR_DELAY. This
process repeats until the recall times out and the delegation is revoked by
the server.

I noticed that the current order of GETATTR and DELEGRETURN was done by
commit e144cbcc251f. Then later on, commit 8ac2b42238f5 was added to drop
the GETATTR if the request was rejected with EACCES.

Do you have any advise on where, on server or client, this issue should
be addressed?

Thanks,
-Dai

