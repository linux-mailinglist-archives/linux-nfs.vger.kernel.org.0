Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC655B8EF2
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Sep 2022 20:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiINShg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Sep 2022 14:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiINShf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Sep 2022 14:37:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAF276456
        for <linux-nfs@vger.kernel.org>; Wed, 14 Sep 2022 11:37:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EIUs8t026510;
        Wed, 14 Sep 2022 18:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=B+rQ0xNdGCpIFZtonjk8emvRx6bGPz/oLiQYI6jBD1g=;
 b=ZS/BI3bz8T4p087Xi97QbycmBqJ3/J3YzCFMgywllZwXFjDpERwJrNiH1ed0Tpwvir14
 eWLjLiv41Sm1MHrSPODD8+5Wf/clkrIQQ8U7szi/fAw81ZdBGCwlkVM5xnZNAfkvymhQ
 haatyxRTEXlqDmnURRo5G7d3s1nbTMofLFaeHE1ig7GuoGntQ5mKDixCkk/otZt+IQK3
 KRLyZnrMbc6mLO0VRNU9YTTXeaH3R5axWth6ambjjBiSu8kAJQa6ZadUJ8QGCulHOy2B
 4CnVYR/4QZRp1rvSEgIqMSvu0RVDd8SupJFxcNEG0CYmxbnsoO1qQNBHPa3MxHNC9nfr CQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxycb5tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 18:37:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EG6gGr020817;
        Wed, 14 Sep 2022 18:37:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy5e9uw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 18:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEB1h1N/TNnBHVH3rh9p7s7dF0e83Nsvs5W3Rmlild1fgqB0AxjyH48P7Otekl4Lwsd1LgNyUA4BVb9DgKKqCDDJElF4CXOVWAiQKi25o7+qUmhEbURCDX8UPLPLK/HE0x1KBOpxJ/ZC416KwNh15sAFZ3nP3HQiDrmCDadd0PJPrJI8beTRPJK/ces3ni0CV9PmdjrLL/zAjdd8/3qldlbO75+f371gDlyDPabSA+CxHHLAF2XmMIMU41FnTVE8Lqd9AKlzkI5cQ2/4kbxpMbhJchhF4GAJeyPWDVo//gFUZvui6/6mprDSpFFfpZVY4XBoCCPztQJRlWMCSftd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+rQ0xNdGCpIFZtonjk8emvRx6bGPz/oLiQYI6jBD1g=;
 b=RZhRkBcIacNxXvicER3o5zptuAszqEV5TLnxUUfEQRCmUEQ8R/7qiUllyutQQSUWREe7ik1cA6oizOttskUusRejlOOnlPCPpJKMY7GhT2JDRAfIhpZtyRZ4SJZvJSdWXf8/rbhNu4gPSL/pMLdAyA2iJB2Xa/Y5+1k9+ueJwggOS8syrRl0EHyjWrG1kRKfINi90UBglLi4tgKix1TbmY4tlz6KdTgu02D11R9O+7SyWiFhWW4eRF7g01p0vRO6ovk1EspOHU2QFpyXO8iuwAE6OJKnMrLnm/5v8DkpBkNgYfxEsOZV3iPhkJqDSxTmarG3M4v4XnkrMgG4gDIxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+rQ0xNdGCpIFZtonjk8emvRx6bGPz/oLiQYI6jBD1g=;
 b=Tj978keAYAPd2WtsKdPUYUkHYPPI7x0G1532XxXVYmxqwsRvboIFwHkNgE97++YqE59n0BpIGRwTRQkTn1ZT7GY8b5JBnNHoUVH3Vb5V7n2Ro46faznAi0wYt7LoCA5xoGkB1JtuPp+ItxAg2O1NfxODHb608yuj5wLGvtrMgsE=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 18:37:26 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::803:3bcf:a1ee:9e1c%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 18:37:26 +0000
Message-ID: <10929ac3-e6b0-f274-716a-ba9a5589c7f9@oracle.com>
Date:   Wed, 14 Sep 2022 11:37:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v7 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1663170866-21524-1-git-send-email-dai.ngo@oracle.com>
 <1663170866-21524-3-git-send-email-dai.ngo@oracle.com>
 <0E0CBCE0-0270-4086-91F1-901153A9D2B0@oracle.com>
Content-Language: en-US
From:   dai.ngo@oracle.com
In-Reply-To: <0E0CBCE0-0270-4086-91F1-901153A9D2B0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:806:130::19) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 56221a50-96fc-4563-1308-08da96802bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3U+NRCrFNgUgx1cSh/aBGS/4uuI6C5R1ntu4WzfVBa9HJknHhaRCDW2vX428WxSxzSjezFTJHaS4WgNt5ruOsSyswPNPd3NizSb09rUf25AMl7OsjQy5VA7QuutXVhCYpR5chguH2EtWxOR2UGFFsNcXADaY8XrCQiN9ydqijMebIXDcmTAVlwzuPzxmevU9RTJvSO571NywRzhYupryQ2u93a7s0MlmdqAyIpPhdHZ5eZC2/4/SZoKDyTRgSaBfn6QLHVP3ICHHbqDDonM5jQsviA+XhJcFwsrn88utVF+PeknNKAE99Ts8qG0zu+rWVXEZ2Ay8I/DOzkUk4CMAoJ2N2Sj/ajRtTC8c7qvPHgj2SfvvqP2cQyghe3IMjo9X3dAedOZxwKYZNU7ye4zHazJBz0Ky7Q8QAdEB0CbXYHElmmw9IRmNmnfR1oxqUtNFWCNJeYUIbvHwzHS+q310Vd0dF8clWgnimd0f0MhSkgwKgBbs9XjPqz2xVeI2yI1oon5v2q8cQKKOJWHabiNAwF8YvaWVg/aNLQpl1ydUF1lwum94eot3GOhJGQP1DDGE3ENowmTs0DyXaE1ye1q2k5AxSpEu/QU6X3lhIIGCNQ8ThI6JELPb2fMt22DMKrvjx6Wnw40D1VkhvKuuS1wm9vqHiShONO8QSYJ012Mr2bo7WtHdV1fxski/ET2qDjBvhJ7vD6YISnG1bU0HAfbQawPqSWV+VFw5ZDxdLB5596Fsc/kPGWsYPXUbyGCkUbJZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199015)(6486002)(478600001)(66556008)(4326008)(66946007)(2906002)(8936002)(186003)(2616005)(9686003)(36756003)(6512007)(31686004)(38100700002)(83380400001)(8676002)(31696002)(26005)(6862004)(86362001)(5660300002)(316002)(37006003)(41300700001)(54906003)(6506007)(53546011)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDRkUFNpaGRtcVFWTGY3V1NwUFFuUFdYT2hoQjZrKzJkamFneEdTRHVyWStt?=
 =?utf-8?B?UjhFMmh4bkN2RXd0ZWpJcGp1QmkvakJXRkh1UldYSXc4ekY5WHBoUnlxL09s?=
 =?utf-8?B?anljc3ROT3h3QksyWTEwVTQzUHZZeDhSOXI3R1VaNlQ2QmthbFZ6MWpvY1c1?=
 =?utf-8?B?d2JKU211Z0lVendpNTN1UDdaQTlCQmlKVHB0VzBEUnphUXkvemFlREs5L0M1?=
 =?utf-8?B?Wi83REFlSkQraExNYWdoRE5WV0Q3QStGcTJ2aUNEWU9DL2xuRHRaQkxKNTVS?=
 =?utf-8?B?UERISGNWb2F2VEpCWlY4ZWcxVytTTmVMMEt4ckxkKzI3QnMrdFJvcDE5SHho?=
 =?utf-8?B?dDlzcW1pSWEwbHhKZi9Gcm9YblVtTjBwU3ZPS0VaNG5mdHpseTdEcTVqQkQ5?=
 =?utf-8?B?bW5kVkJNR0k1V2lTZWZ6emlkNnBocEYya2tObFVNVkZQZmlkMmx5UUdQZjc4?=
 =?utf-8?B?Rzdhc2VBL3h1MWZzdm05NGtWZmlXU3dlQW94S0g5ZmJTcDRqWmxmZnE5UlNl?=
 =?utf-8?B?c2ZmOFZwbWllZk1JMGtoN0t6azZHWHhhSHlBaHZXZzYwSWt1V2lUN05ETEtX?=
 =?utf-8?B?c01udUUwQThsM2cydjEzQ3grMmVZRC9JUlJoZkF4NkZMMWIvRE5DcEtXZ2cy?=
 =?utf-8?B?Z1hVOW1NR0FGUnFkRXZQUVA0NWNOeFU2cGoxQ1FxM2ZobEN4eGtwN3VNVkpB?=
 =?utf-8?B?WGtscXlicHhFZTljVi82VmxrYXRXUG03WXRVaWs2OFFWUjRRVWtDaVhEZ3ll?=
 =?utf-8?B?UEQxY1BDeFFuZEVVblpFMjVpZExzS1UvN1N6VW9HSEErN09VWGxZN3lBdTVM?=
 =?utf-8?B?VWwwRURvd3JhejM5Znk4ZE12SWFTKzF5am1tQWd0a2R3NXROLzEvU1lCNlBh?=
 =?utf-8?B?MFdrYlcyYXZUdFM5RkVQRlRrejNNMXpkWVh1bmVLR29qaVdzY214OGRLbkVs?=
 =?utf-8?B?WG53U3ZWc1JSeC9EaFh1NFdVN0V0emlpdXBaSVg4Y1hWdVJaS1FReThKemRx?=
 =?utf-8?B?U0llS01lOE0yTUJyT21HRm05Q3BrWkZqOW85QlJrRkVIVE5QYkpzbjYyZjVK?=
 =?utf-8?B?Y1BaUkJQcW5XQUtZVC9TUjVjT3g2azFqRmhmUHMzc05uNjRLc3djMEpibk11?=
 =?utf-8?B?RURoQTk2bXZYcXdlNnF6eXRhVGRaTXd5Q2l3ODNMMTJucEZCN2QvOElpbThk?=
 =?utf-8?B?WWplNjczcnJ0ZmZSVXVMakJwTXBzZm1IZDF4alRYclpjTmZDRWZrbTV4REU2?=
 =?utf-8?B?UWtuSDZ6ZVJwODBwNjczMjM3U0JHazhLRVJwcDE0M3pxdE1kelJVaUwwRC9M?=
 =?utf-8?B?bHZLM21RRTNKeHFVS3h5amZRclpIcGllOW1IMFAySFZNYWVlVVBwT25RalBD?=
 =?utf-8?B?ZDRsNTZYWnVZa1J3Q05ZMVY1ckNYeEpTbHpwY0FHUGYyNUMrMUQvY3lvazVa?=
 =?utf-8?B?M3JQNWR3TkZiYVJBU2ErVjFMN0pFWkpCWTFUc25kS2xCcklrL21FcGhXMU1X?=
 =?utf-8?B?M1ZXYnUyMzEzR0RmTUc1NU95SDY4a21YczhZYmErZVkyN2VZN2xBc2xIcUNq?=
 =?utf-8?B?R3lwMDRPM1RGeVpZRkpnM09wUWlyMHNjNlB2V0U0U2JTQnVxNkQ2RU1nTkto?=
 =?utf-8?B?ZVFyRlNmYUxZLytseUNhOHFpU3lNZGwvNkpWYklnWkxOanpONDE2SnZ2UHFS?=
 =?utf-8?B?bDlKWlFaV21PRjZocmpwU3B1U0twQjNzRlBZWWxwT3BDbHRqbmF5SUFxOWJD?=
 =?utf-8?B?RTZOcFlyR3NBMC9naDQvR2hqRGRGZkVIaU9IYnFRRjBkLzRGU0lEelpSOGRr?=
 =?utf-8?B?bTVvU2FQNWcxRU5ubDNqaUpBbGlpTTRVUVZmMmF0WG1LSWZubmZPYzY0VUFw?=
 =?utf-8?B?SEU4QTVRQ1BHdFJwVjE2OE4wR3BDd2ptb1JQSkVldkUxRWs2cUhxVzY0Y3kz?=
 =?utf-8?B?dDNBbDA0bGhRSENpZllSaUhBditWZ0Y0bWV2L05ka24rY3dEYmFUdWVNN29o?=
 =?utf-8?B?ekNwbkZjRnJpZzg3R0d1NHVzNUFxQVVnZzFWcWxNemtEdFpFZThxNGI4OWo4?=
 =?utf-8?B?OFplbm1LZUcwbHp2WmNhY1BJaEwwdWlvWXFpQWZ1WDBCZmREbnhKK1B0dS9m?=
 =?utf-8?Q?b7b1wD57m22aGzfvSgihKUJUI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56221a50-96fc-4563-1308-08da96802bd8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 18:37:26.3782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SKOV0AUw5fW/zk9KVioWCDIjjkZ/Rd1i+J3YUAMJM8kWoGakySd/kJyFlakxNSz8L2ziMuCzNx8ZkCrP9yt/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140090
X-Proofpoint-ORIG-GUID: XS4oNuBtL4rjb6iLKVoDWG-ielKZGdVZ
X-Proofpoint-GUID: XS4oNuBtL4rjb6iLKVoDWG-ielKZGdVZ
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 9/14/22 11:32 AM, Chuck Lever III wrote:
>
>> On Sep 14, 2022, at 8:54 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Add courtesy_client_reaper to react to low memory condition triggered
>> by the system memory shrinker.
>>
>> The delayed_work for the courtesy_client_reaper is scheduled on
>> the shrinker's count callback using the laundry_wq.
>>
>> The shrinker's scan callback is not used for expiring the courtesy
>> clients due to potential deadlocks.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/netns.h     |  2 ++
>> fs/nfsd/nfs4state.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>> fs/nfsd/nfsctl.c    |  6 ++--
>> fs/nfsd/nfsd.h      |  7 ++--
>> 4 files changed, 97 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>> index 55c7006d6109..8c854ba3285b 100644
>> --- a/fs/nfsd/netns.h
>> +++ b/fs/nfsd/netns.h
>> @@ -194,6 +194,8 @@ struct nfsd_net {
>> 	int			nfs4_max_clients;
>>
>> 	atomic_t		nfsd_courtesy_clients;
>> +	struct shrinker		nfsd_client_shrinker;
>> +	struct delayed_work	nfsd_shrinker_work;
>> };
>>
>> /* Simple check to find out if a given net was properly initialized */
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 2827329704ea..62b848bb55df 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -4347,7 +4347,27 @@ nfsd4_init_slabs(void)
>> 	return -ENOMEM;
>> }
>>
>> -void nfsd4_init_leases_net(struct nfsd_net *nn)
>> +static unsigned long
>> +nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_control *sc)
>> +{
>> +	int cnt;
>> +	struct nfsd_net *nn = container_of(shrink,
>> +			struct nfsd_net, nfsd_client_shrinker);
>> +
>> +	cnt = atomic_read(&nn->nfsd_courtesy_clients);
>> +	if (cnt > 0)
>> +		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>> +	return (unsigned long)cnt;
>> +}
>> +
>> +static unsigned long
>> +nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control *sc)
>> +{
>> +	return SHRINK_STOP;
>> +}
>> +
>> +int
>> +nfsd4_init_leases_net(struct nfsd_net *nn)
>> {
>> 	struct sysinfo si;
>> 	u64 max_clients;
>> @@ -4368,6 +4388,16 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
>> 	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
>>
>> 	atomic_set(&nn->nfsd_courtesy_clients, 0);
>> +	nn->nfsd_client_shrinker.scan_objects = nfsd_courtesy_client_scan;
>> +	nn->nfsd_client_shrinker.count_objects = nfsd_courtesy_client_count;
>> +	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
>> +	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
>> +}
>> +
>> +void
>> +nfsd4_leases_net_shutdown(struct nfsd_net *nn)
>> +{
>> +	unregister_shrinker(&nn->nfsd_client_shrinker);
>> }
>>
>> static void init_nfs4_replay(struct nfs4_replay *rp)
>> @@ -5909,10 +5939,49 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>> 	spin_unlock(&nn->client_lock);
>> }
>>
>> +static void
>> +nfs4_get_courtesy_client_reaplist(struct nfsd_net *nn,
>> +				struct list_head *reaplist)
>> +{
>> +	unsigned int maxreap = 0, reapcnt = 0;
>> +	struct list_head *pos, *next;
>> +	struct nfs4_client *clp;
>> +
>> +	maxreap = NFSD_CLIENT_MAX_TRIM_PER_RUN;
>> +	INIT_LIST_HEAD(reaplist);
>> +
>> +	spin_lock(&nn->client_lock);
>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>> +		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> +		if (clp->cl_state == NFSD4_ACTIVE)
>> +			break;
>> +		if (reapcnt >= maxreap)
>> +			break;
>> +		if (!mark_client_expired_locked(clp)) {
>> +			list_add(&clp->cl_lru, reaplist);
>> +			reapcnt++;
>> +		}
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +}
>> +
>> +static void
>> +nfs4_process_client_reaplist(struct list_head *reaplist)
>> +{
>> +	struct list_head *pos, *next;
>> +	struct nfs4_client *clp;
>> +
>> +	list_for_each_safe(pos, next, reaplist) {
>> +		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> +		trace_nfsd_clid_purged(&clp->cl_clientid);
>> +		list_del_init(&clp->cl_lru);
>> +		expire_client(clp);
>> +	}
>> +}
>> +
>> static time64_t
>> nfs4_laundromat(struct nfsd_net *nn)
>> {
>> -	struct nfs4_client *clp;
>> 	struct nfs4_openowner *oo;
>> 	struct nfs4_delegation *dp;
>> 	struct nfs4_ol_stateid *stp;
>> @@ -5941,12 +6010,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>> 	}
>> 	spin_unlock(&nn->s2s_cp_lock);
>> 	nfs4_get_client_reaplist(nn, &reaplist, &lt);
>> -	list_for_each_safe(pos, next, &reaplist) {
>> -		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> -		trace_nfsd_clid_purged(&clp->cl_clientid);
>> -		list_del_init(&clp->cl_lru);
>> -		expire_client(clp);
>> -	}
>> +	nfs4_process_client_reaplist(&reaplist);
>> +
>> 	spin_lock(&state_lock);
>> 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>> 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>> @@ -6029,6 +6094,18 @@ laundromat_main(struct work_struct *laundry)
>> 	queue_delayed_work(laundry_wq, &nn->laundromat_work, t*HZ);
>> }
>>
>> +static void
>> +courtesy_client_reaper(struct work_struct *reaper)
>> +{
>> +	struct list_head reaplist;
>> +	struct delayed_work *dwork = to_delayed_work(reaper);
>> +	struct nfsd_net *nn = container_of(dwork, struct nfsd_net,
>> +					nfsd_shrinker_work);
>> +
>> +	nfs4_get_courtesy_client_reaplist(nn, &reaplist);
>> +	nfs4_process_client_reaplist(&reaplist);
>> +}
>> +
>> static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
>> {
>> 	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
>> @@ -7845,6 +7922,7 @@ static int nfs4_state_create_net(struct net *net)
>> 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
>>
>> 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
>> +	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, courtesy_client_reaper);
>> 	get_net(net);
>>
>> 	return 0;
>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> index 917fa1892fd2..597a26ad4183 100644
>> --- a/fs/nfsd/nfsctl.c
>> +++ b/fs/nfsd/nfsctl.c
>> @@ -1481,11 +1481,12 @@ static __net_init int nfsd_init_net(struct net *net)
>> 		goto out_idmap_error;
>> 	nn->nfsd_versions = NULL;
>> 	nn->nfsd4_minorversions = NULL;
>> +	retval = nfsd4_init_leases_net(nn);
>> +	if (retval)
>> +		goto out_drc_error;
>> 	retval = nfsd_reply_cache_init(nn);
>> 	if (retval)
>> 		goto out_drc_error;
>> -	nfsd4_init_leases_net(nn);
>> -
>> 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
>> 	seqlock_init(&nn->writeverf_lock);
>>
>> @@ -1507,6 +1508,7 @@ static __net_exit void nfsd_exit_net(struct net *net)
>> 	nfsd_idmap_shutdown(net);
>> 	nfsd_export_shutdown(net);
>> 	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
>> +	nfsd4_leases_net_shutdown(nn);
>> }
>>
>> static struct pernet_operations nfsd_net_ops = {
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 57a468ed85c3..cd92f615faa3 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -343,6 +343,7 @@ void		nfsd_lockd_shutdown(void);
>> #define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
>> #define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128
>> #define	NFS4_CLIENTS_PER_GB		1024
>> +#define	NFSD_CLIENT_SHRINKER_MINTIMEOUT	1   /* seconds */
> You don't need this definition any more. I can remove it
> when I apply the patch.

Oh yes, I missed this.

>
> Otherwise, these patches look great. I will give a few
> more days for more review comments.

Thank you Chuck,

-Dai

>
>
>> /*
>>   * The following attributes are currently not supported by the NFSv4 server:
>> @@ -498,7 +499,8 @@ extern void unregister_cld_notifier(void);
>> extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
>> #endif
>>
>> -extern void nfsd4_init_leases_net(struct nfsd_net *nn);
>> +extern int nfsd4_init_leases_net(struct nfsd_net *nn);
>> +extern void nfsd4_leases_net_shutdown(struct nfsd_net *nn);
>>
>> #else /* CONFIG_NFSD_V4 */
>> static inline int nfsd4_is_junction(struct dentry *dentry)
>> @@ -506,7 +508,8 @@ static inline int nfsd4_is_junction(struct dentry *dentry)
>> 	return 0;
>> }
>>
>> -static inline void nfsd4_init_leases_net(struct nfsd_net *nn) {};
>> +static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0; };
>> +static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) {};
>>
>> #define register_cld_notifier() 0
>> #define unregister_cld_notifier() do { } while(0)
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
