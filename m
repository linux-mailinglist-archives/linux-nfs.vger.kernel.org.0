Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3DC60BC53
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 23:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiJXVi1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 17:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiJXViC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 17:38:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF83FAC294
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 12:45:58 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OI9TZf010233;
        Mon, 24 Oct 2022 19:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vqwCJeNgVB0fCQg5NUDOLvYzn9Ww6hDoEg4c0ANZCG4=;
 b=cx8lM8JeUGmuCgS7knWqQGaOAMyn5a8aLzK7iyo2Da0r65xYtcZbqDchMQ+PtCFkrrwT
 hzY2xQ904TSuQ3HBu3fpRYjb2GoQkbH9ey48ZW0haMgjETo0OAiF+Y//z7UkMMZv7LDD
 gUuyng75SR73y9KeBd/81SfWDMibhG9cwyUfaMrtPvCujEQsc2sqbWauL1sB5evdSGHB
 0mxF+TPKUTsGrsEHmw5qJRPWXkm+9yYRumZWBosb7Rza/JUf5OBxHcrbHqHCjfI+MHmD
 0S6jcZWPHM+HDG+B3+BeSaw5lBFFpSFRXyQZE/k5knMSY5YfC851vw/aq2038P6t5Kow dA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc741n4wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 19:44:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OHx1hR032204;
        Mon, 24 Oct 2022 19:44:05 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6ya6fgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 19:44:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTMpouChBDjvbHW8JgEq9ovWgIHadfVJb0y6d6sTvBmmVyWg51SxZsJn2tYhxOXy+h3PmAW8sqdPWX9A3Unxb/G0aVUh6Hp1pbV6HIWqzHv7m9x0cTdAgB/mtHxAcjVdpyVETf7yrx53llAb9bS+6Ars3ZW+w7vR4gbfhI8dWdLPRIVL254R3osY3KffNuW+xkHod93iwErLPcho/uTAikVZC3mwrH8h5ZDBO5OtXGblRUbqeAWi6ShUnBT11pqVPtPt8tDFwPRv2Ui2krTnBmAKxUFKefa7pDACCJCXgQRIjjlnFYdw4xt0qIizP5Xp2USe6KN0XwMXel349qKU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqwCJeNgVB0fCQg5NUDOLvYzn9Ww6hDoEg4c0ANZCG4=;
 b=NAUCTky7Mp3YTu1i1YA47xhazn6G6P9U/NgABHLj+zkNvDnnYKEvqy7TcFj+nTpciRtS5OkUsaTi17cTdfdiMTtGURpMbYVQDHP6cqL6AwdOnAyZVEDYsEM1lPRfr6yKInJasZeqF502h4UDKKVfaSCee9fRKVowwoEPd1CVUshSxn6tZs2sVA9eBi8URTgOC9XwsH1JiX9onewPrsQ5wzZXPOtlU5LNgitpeuPCzsOqLAp2GPGHN7uqLdFA2um4pr0SR2o8Mt0i2xJJnOCWTHhhj+geWrVosd1+Nl0cjIH2IR9RecHI1mhJO1/rpKJM00Ti0VSq+cKokMQRIW7WiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqwCJeNgVB0fCQg5NUDOLvYzn9Ww6hDoEg4c0ANZCG4=;
 b=Jv3xMpISJv8Y0Yle1ot8KA5icI7TvIn8JyrTiTDZD2mougY2eBLu4C7+vok2kkm4eaWeJQNct0HiZbt7SYp43R9awX6JPlwOarh9LVWBo+9OX31+dtADWlmyUCldu6USn9VTE15wXcM7ipEp8vJsZcOhbPIN/D4zWZ9X/DrAm1k=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN0PR10MB4887.namprd10.prod.outlook.com (2603:10b6:408:124::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.37; Mon, 24 Oct
 2022 19:44:03 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::21ec:d1ee:2a59:a1d0]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::21ec:d1ee:2a59:a1d0%6]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 19:44:03 +0000
Message-ID: <efbea8dd-1998-fe2a-1a94-6becc5ea691f@oracle.com>
Date:   Mon, 24 Oct 2022 12:44:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/2] NFSD: add support for sending CB_RECALL_ANY
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <1666462150-11736-1-git-send-email-dai.ngo@oracle.com>
 <1666462150-11736-2-git-send-email-dai.ngo@oracle.com>
 <d43a3dac01f8c4211ec7634a0d78dae70468f39b.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <d43a3dac01f8c4211ec7634a0d78dae70468f39b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0171.namprd05.prod.outlook.com
 (2603:10b6:a03:339::26) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BN0PR10MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c78861-97e7-4a46-aec6-08dab5f81abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCOT3FqOR3uhQRyM8TTjQIBqmdjpkHTT0PzP7BhJEi/aaFVPVm2kkIIQXRuBDIzK8fwRHQg2+6cCluk7SbgHxvLxBiRSltmUQ15ZclL3EDpsnLdoD3X+mzDOkIEydcxipMak0LlHlN4RKkD763bRWBF9+9YA6B81nk1iQAqe4k9hjz0829lD7XOzeuC6+VPv98iCD9MBtqeoIgv7zOrw0MnFO8EDSWxCinpd75PhjceeXZRzI8i1pkc5M2GksznL/rV0BBDLZmBmSDeJ5K631XAZtgPeRDumqjNRSrWagaXjuPpbMbHxaQKTHbRkJ9l8B/czvm1JCK4Z8TzCcAz17GKNARPUCg1S3MFgyGLwMDoxibm/FmkzQDeHZ2V1Af5gtiYZmfoE0Mmi7eso1KMD2gCV5gE9RDzEPGKHC5t5BbwN293s8lK7lH641p7nqhhzS/oYP6/oUKoL7uPFupZKwpQwI8uxDJSXGlLM6QrXTRWCCS7AyymV8dgrLSzXCCE/6Nz6ckSMEipcGugsImrcDcIT3FpZeB7zwgHY2/Rc7GMxROz9rXR811kqjdN2mDG4dgD78mEDQWdKRPW5/Wklj63Uo+rRJCN2htHdd8YQZ715HzOR2NAlu5a+icJR5XNGTG/Z1RzziIoheYa1y99EF0S9IuyhXifr80zsLcsRJsrY3/tc0WA3Jn9fv4B5301GqturtFhDRpVj0NdE3UrH7JzOiHpPArRIg+gfThCdK7CKMqQ2H3dpI4fFnSHSdxTK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(53546011)(6506007)(5660300002)(66556008)(66476007)(4326008)(36756003)(26005)(9686003)(8936002)(41300700001)(66946007)(38100700002)(2616005)(316002)(2906002)(186003)(4001150100001)(6512007)(8676002)(478600001)(31686004)(6486002)(83380400001)(31696002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTBnVzJ1ZnoxbUpTT0xPenRZYUlvYjZkOTZyQjFsWHBraEdkbHJNaTY5Sk5Q?=
 =?utf-8?B?K2ZFZkVRZnBIS2pyVElMaWEvR3RJVE85aXpZMVNWbHBESENSUXV2STJ2RlI0?=
 =?utf-8?B?Z0ZWakcxTjN2bUlUR21RMTVFQUVKZExxTklZNHdPd3ZVZnVtMmVHanhDWWVC?=
 =?utf-8?B?c2NTdTdBU1VsSFFReDcvMHVtOGkzRkJMZXhUdmxuVU13Q29MdEtoL2tvYmZG?=
 =?utf-8?B?NEZPbTBVMU5QdEVsTWFDb2dZWHpSaXc3NmN1S0NtdlZaeHB5aFpFZTFKT05L?=
 =?utf-8?B?RE1EZUhPNDU0WVlha3A4Y2Zqdk9TcWdqVlA4YnczWEtVaFV3bkdEbFU0SVVC?=
 =?utf-8?B?dUJ6UWV3TUNKRmErZ2NFT1hGcEJPa1NjMnRLemhKWTB5MXpxOExlZ0JndlRO?=
 =?utf-8?B?SHNrS0tlcFF1TFlodVIrelhWb0wwcURockxUc2lSQ1gwR1diaWUyM2RzNVRo?=
 =?utf-8?B?Q21JZHBFSG8rRDhpbXJqOU1NZnlHajFLdmwzY2dGNk5xOEJSU2tFVE82SG5I?=
 =?utf-8?B?Y1JGS2JWdDg5S1J5YjBBZlpwTWZPOWgvSllEc053VW5Cb2R5ajhBbHBwcmlL?=
 =?utf-8?B?RFhqS1pIZWFNSEN2RmZIQjhuMUlPemUra0VKU0VIbnBGU0grUnlKdm8wZU15?=
 =?utf-8?B?azZ6bDBRaDRacmRNbkg1d1dnZjNGaU43bFBhd2F2dUxIcHdZMjRtcVRqVjQ1?=
 =?utf-8?B?alBXV2xEY256RWEvRFhRblhheEhiRDZFN0tOVUpxUlRWQTdnaVI5eFRGcnRm?=
 =?utf-8?B?bVNCY1hRbVViTXlSSGlPSERHeTBVZ3R0b09HVm9qS0J6YzExUTZXNFIrNFVQ?=
 =?utf-8?B?V1EzMXNTOUdndkRPU2txSVRpc0Uxc2Y2YlovaFNPMUdHUWpMdUZzekRYbkMx?=
 =?utf-8?B?bzhLSkplRzNNOE8vdHhxQURtNXZybGlibmw0WXZDY3ZEOEQ3MmdRTHhQbW9D?=
 =?utf-8?B?R3YvR2ZvaXZOY2FReHRPN3pQSDc3bmZ5ZGhpR3gvemdiOER6RDJnUFBmSER5?=
 =?utf-8?B?cjNIdFcxRzB5TXhtaU16Nzdnc2o3dmxZV1FuQ2JuYm1zdUZXbzRFQTRLK1ds?=
 =?utf-8?B?NkRNSXhpNU1teDlsSUtuU1RVRGNwTVdSZEptT3hFcEZOUEd0N1VpNllXUnBv?=
 =?utf-8?B?N2hoeVJnRTJzdkVyandtZzhHeE5DbFJiRmpCWjBSYjY3WnA2NnkxanRhQlll?=
 =?utf-8?B?NitQc3c5VVNXUXl3RHBidGVWRkdCTDAzVDZ1QitYaVo5VllJSElMUkZZbDI3?=
 =?utf-8?B?MFlnMG40V3UxTnNrbm1PM1lFS0ZlN3pYSzU0R2IwNDhIN1FJQzNhMFFNQmhM?=
 =?utf-8?B?aXlzQUViVUIwbnZ6Z2tuVmVpLy8rNGFvQzhnQ2p0c0FNREVwMmNKLytkQUdP?=
 =?utf-8?B?WmdzaHJTb1FWVGcvOHgxc0hBTDY5MmtlUkkyMkkyY2FwWDJvSnUxbHFRajBI?=
 =?utf-8?B?OXFibFpOYm16YUJYbzFNdGE4b2hXaXhHR0VwV2tKejFlSlk4Q0I0dmRZRlBT?=
 =?utf-8?B?cFB5ZXVvclp3N05SR2NUanA4NzMrWUdLMkhIb2NvaUNwVUE4SkNqcURMa1hR?=
 =?utf-8?B?SGxORlphSGV3Z0ROR2MzRXJwcHNqVk9wNzROdEVjVzVxVzhwaVA4L0ZOUytn?=
 =?utf-8?B?NHlqenl3WDFGK2FZdjBwNXpWWkV2TmVPd0Z3NUNSa3IrU2dBQ2VxbUpjNzVP?=
 =?utf-8?B?c1hzUWtockk1ZFpoOXpidXZCNlc4Q0o4RkpZL1NaK0FaKzh1T1N5U2FwcVpn?=
 =?utf-8?B?U044QTlEMXF4OWt5dU41N3ZXam13UE5XcDNmOVQ4SC85anVscXhPRzVndStk?=
 =?utf-8?B?OE5QZmdMQzh1SUwwM2dDL1BSRGN5Z0dOMTZVcjc5eG1LUklRUkwzWndFMTFD?=
 =?utf-8?B?NkhxaW90b1V1QzJJQS95YWxaZ2ZzSWdkekNYVk9iKzN3OVFRb0N2aVYzOGN3?=
 =?utf-8?B?T0EwekdMNS9obGYreWIvWGZYdGw3Q2hBWTZDUEY2cEVXMHR5WWIzbWI0Um9S?=
 =?utf-8?B?ZW4vOHFSa1hoWFB5b20zUWZCdTNRUXF4aVM3Q1FjOU5Na01idlhjSE52Wnpy?=
 =?utf-8?B?VEdCSVJUdCt6RFFka0NDVkhBelNMTDVjQXd2b3U3YmJWRUcrc1lOVzdXYncr?=
 =?utf-8?Q?WW+qq17PPTHzqWxau3WjI56PF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c78861-97e7-4a46-aec6-08dab5f81abf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 19:44:03.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Syd2towt8pjkoEzsR5z0ibWkPnLL0L2exvtagtYQYEEzy8zCy81SSbSzdiaYttvahO6mQEwv8UiVC8hJ5UtzOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4887
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_07,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240118
X-Proofpoint-GUID: T-UHvxh2xP529BIzkSCl_e88BKwYFdZ3
X-Proofpoint-ORIG-GUID: T-UHvxh2xP529BIzkSCl_e88BKwYFdZ3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 10/24/22 5:16 AM, Jeff Layton wrote:
> On Sat, 2022-10-22 at 11:09 -0700, Dai Ngo wrote:
>> There is only one nfsd4_callback, cl_recall_any, added for each
>> nfs4_client. Access to it must be serialized. For now it's done
>> by the cl_recall_any_busy flag since it's used only by the
>> delegation shrinker. If there is another consumer of CB_RECALL_ANY
>> then a spinlock must be used.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4callback.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/nfsd/nfs4state.c    | 27 +++++++++++++++++++++
>>   fs/nfsd/state.h        |  8 +++++++
>>   fs/nfsd/xdr4cb.h       |  6 +++++
>>   4 files changed, 105 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index f0e69edf5f0f..03587e1397f4 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
>> @@ -329,6 +329,29 @@ static void encode_cb_recall4args(struct xdr_stream *xdr,
>>   }
>>   
>>   /*
>> + * CB_RECALLANY4args
>> + *
>> + *	struct CB_RECALLANY4args {
>> + *		uint32_t	craa_objects_to_keep;
>> + *		bitmap4		craa_type_mask;
>> + *	};
>> + */
>> +static void
>> +encode_cb_recallany4args(struct xdr_stream *xdr,
>> +			struct nfs4_cb_compound_hdr *hdr, uint32_t bmval)
>> +{
>> +	__be32 *p;
>> +
>> +	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
>> +	p = xdr_reserve_space(xdr, 4);
>> +	*p++ = xdr_zero;	/* craa_objects_to_keep */
>> +	p = xdr_reserve_space(xdr, 8);
>> +	*p++ = cpu_to_be32(1);
>> +	*p++ = cpu_to_be32(bmval);
>> +	hdr->nops++;
>> +}
>> +
>> +/*
>>    * CB_SEQUENCE4args
>>    *
>>    *	struct CB_SEQUENCE4args {
>> @@ -482,6 +505,24 @@ static void nfs4_xdr_enc_cb_recall(struct rpc_rqst *req, struct xdr_stream *xdr,
>>   	encode_cb_nops(&hdr);
>>   }
>>   
>> +/*
>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>> + */
>> +static void
>> +nfs4_xdr_enc_cb_recall_any(struct rpc_rqst *req,
>> +		struct xdr_stream *xdr, const void *data)
>> +{
>> +	const struct nfsd4_callback *cb = data;
>> +	struct nfs4_cb_compound_hdr hdr = {
>> +		.ident = cb->cb_clp->cl_cb_ident,
>> +		.minorversion = cb->cb_clp->cl_minorversion,
>> +	};
>> +
>> +	encode_cb_compound4args(xdr, &hdr);
>> +	encode_cb_sequence4args(xdr, cb, &hdr);
>> +	encode_cb_recallany4args(xdr, &hdr, cb->cb_clp->cl_recall_any_bm);
>> +	encode_cb_nops(&hdr);
>> +}
>>   
>>   /*
>>    * NFSv4.0 and NFSv4.1 XDR decode functions
>> @@ -520,6 +561,28 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *rqstp,
>>   	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
>>   }
>>   
>> +/*
>> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
>> + */
>> +static int
>> +nfs4_xdr_dec_cb_recall_any(struct rpc_rqst *rqstp,
>> +				  struct xdr_stream *xdr,
>> +				  void *data)
>> +{
>> +	struct nfsd4_callback *cb = data;
>> +	struct nfs4_cb_compound_hdr hdr;
>> +	int status;
>> +
>> +	status = decode_cb_compound4res(xdr, &hdr);
>> +	if (unlikely(status))
>> +		return status;
>> +	status = decode_cb_sequence4res(xdr, cb);
>> +	if (unlikely(status || cb->cb_seq_status))
>> +		return status;
>> +	status =  decode_cb_op_status(xdr, OP_CB_RECALL_ANY, &cb->cb_status);
>> +	return status;
>> +}
>> +
>>   #ifdef CONFIG_NFSD_PNFS
>>   /*
>>    * CB_LAYOUTRECALL4args
>> @@ -783,6 +846,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
>>   #endif
>>   	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
>>   	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
>> +	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
>>   };
>>   
>>   static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 4e718500a00c..c60c937dece6 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2854,6 +2854,31 @@ static const struct tree_descr client_files[] = {
>>   	[3] = {""},
>>   };
>>   
>> +static int
>> +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
>> +			struct rpc_task *task)
>> +{
>> +	switch (task->tk_status) {
>> +	case -NFS4ERR_DELAY:
>> +		rpc_delay(task, 2 * HZ);
>> +		return 0;
>> +	default:
>> +		return 1;
>> +	}
>> +}
>> +
>> +static void
>> +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>> +{
>> +	cb->cb_clp->cl_recall_any_busy = false;
>> +	atomic_dec(&cb->cb_clp->cl_rpc_users);
>> +}
>
> This series probably ought to be one big patch. The problem is that
> you're adding a bunch of code to do CB_RECALL_ANY, but there is no way
> to call it without patch #2.

The reason I separated these patches is that the 1st patch, adding support
CB_RECALL_ANY can be called for other purposes than just for delegation such
as to recall pnfs layouts, or when the max number of delegation is reached.
So that was why I did not combined this patches. However, I understand your
concern about not being able to test individual patch. So as Chuck suggested,
perhaps we can leave these as separate patches for easier review and when it's
finalized we can decide to combine them in to one big patch.  BTW, I plan to
add a third patch to this series to send CB_RECALL_ANY to clients when the
max number of delegations is reached.

>
> That makes it hard to judge whether there could be races and locking
> issues around the handling of cb_recall_any_busy, in particular. From
> patch #2, it looks like cb_recall_any_busy is protected by the
> nn->client_lock, but I don't think ->release is called with that held.

I don't intended to use the nn->client_lock, I think the scope of this
lock is too big for what's needed to serialize access to struct nfsd4_callback.
As I mentioned in the cover email, since the cb_recall_any_busy is only
used by the deleg_reaper we do not need a lock to protect this flag.
But if there is another of consumer, other than deleg_reaper, of this
nfsd4_callback then we can add a simple spinlock for it.

My question is do you think we need to add the spinlock now instead of
delaying it until there is real need?

>
> Also, cl_rpc_users is a refcount (though we don't necessarily free the
> object when it goes to zero). I think you need to call
> put_client_renew_locked here instead of just decrementing the counter.

Since put_client_renew_locked() also renews the client lease, I don't
think it's right nfsd4_cb_recall_any_release to renew the lease because
because this is a callback so the client is not actually sending any
request that causes the lease to renewed, and nfsd4_cb_recall_any_release
is also alled even if the client is completely dead and did not reply, or
reply with some errors.

-Dai

>
>> +
>> +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
>> +	.done		= nfsd4_cb_recall_any_done,
>> +	.release	= nfsd4_cb_recall_any_release,
>> +};
>> +
>>   static struct nfs4_client *create_client(struct xdr_netobj name,
>>   		struct svc_rqst *rqstp, nfs4_verifier *verf)
>>   {
>> @@ -2891,6 +2916,8 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
>>   		free_client(clp);
>>   		return NULL;
>>   	}
>> +	nfsd4_init_cb(&clp->cl_recall_any, clp, &nfsd4_cb_recall_any_ops,
>> +			NFSPROC4_CLNT_CB_RECALL_ANY);
>>   	return clp;
>>   }
>>   
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index e2daef3cc003..49ca06169642 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -411,6 +411,10 @@ struct nfs4_client {
>>   
>>   	unsigned int		cl_state;
>>   	atomic_t		cl_delegs_in_recall;
>> +
>> +	bool			cl_recall_any_busy;
>> +	uint32_t		cl_recall_any_bm;
>> +	struct nfsd4_callback	cl_recall_any;
>>   };
>>   
>>   /* struct nfs4_client_reset
>> @@ -639,8 +643,12 @@ enum nfsd4_cb_op {
>>   	NFSPROC4_CLNT_CB_OFFLOAD,
>>   	NFSPROC4_CLNT_CB_SEQUENCE,
>>   	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
>> +	NFSPROC4_CLNT_CB_RECALL_ANY,
>>   };
>>   
>> +#define RCA4_TYPE_MASK_RDATA_DLG	0
>> +#define RCA4_TYPE_MASK_WDATA_DLG	1
>> +
>>   /* Returns true iff a is later than b: */
>>   static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_t *b)
>>   {
>> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
>> index 547cf07cf4e0..0d39af1b00a0 100644
>> --- a/fs/nfsd/xdr4cb.h
>> +++ b/fs/nfsd/xdr4cb.h
>> @@ -48,3 +48,9 @@
>>   #define NFS4_dec_cb_offload_sz		(cb_compound_dec_hdr_sz  +      \
>>   					cb_sequence_dec_sz +            \
>>   					op_dec_sz)
>> +#define NFS4_enc_cb_recall_any_sz	(cb_compound_enc_hdr_sz +       \
>> +					cb_sequence_enc_sz +            \
>> +					1 + 1 + 1)
>> +#define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +      \
>> +					cb_sequence_dec_sz +            \
>> +					op_dec_sz)
