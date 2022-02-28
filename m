Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E0F4C62B6
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 06:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiB1F4p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 00:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiB1F4n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 00:56:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CE55A175
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 21:56:05 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RMdVK5021527;
        Mon, 28 Feb 2022 05:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Nsf7BkWcw20L5vIQUXa5JY9g/PP3M1UdGxTqnlO7Zqo=;
 b=lpKOmRtpfHqJrsg+T6mQuvwT2dGjBoD7xtIS3KR787A9A30ZZeBJXRU86j0giTqA/7/O
 H9JN6B3vjPAib4ikr5kTrq/KyxN7Yu8+CPPL8GmY8LgOKTa3/PxgQ8jUrrmyFAo2GsbY
 XDmsqimqTPlfUIozb8toK362VrlpMtj/L71TVOCWMoZPipQ4vetiLoPUU2fpjGYEQoff
 UuZUAFW2mm8CQj9+H5XXsOhblxYWsTytsnHvy66HvrEUVglXOmBi1cQr4EdfL3EXJAh7
 nJ8T1dGoxNOA0BCJNM1bkFe1HC5gcgbleY3KaPTZqtmkCLo1S4AI+fkw0O07fFwWLwn2 iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efat1u6b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 05:56:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S5kiiI136795;
        Mon, 28 Feb 2022 05:56:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by aserp3020.oracle.com with ESMTP id 3efc12jm7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 05:56:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu0BKHHyHgC43aTGBtM+/OTF8kHODHGdwtZp84OZbEc8ZTPQzKk4CZnzUaVKC3EcWs2ROuo4oPFb7xrY/atmvXPMUC+2ochUoayYL54uzIrKVaMGvU+VI/meY/wPHEiyJSOQpjf5q4bUl8VJv3wTrMI4g7Yx2/xcszj0Z/wIPESSipMNj/VwFCiHHxgqFu/SBdILHRGThJKje9iaO0ZAo2Sf1drt8jwIdRfnq1ww8fQ1HNy6R5AAp3CKiKfc9juI6iWu1yF6VHo06tFOwSaJoh/I22a7pucgiUj/aktugl3vG7f4HTeNM3XCiZzs28KcnhdhnLW35YhQOJSvFgaJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nsf7BkWcw20L5vIQUXa5JY9g/PP3M1UdGxTqnlO7Zqo=;
 b=jpleqbwpAaQYpov+vXesBCQJBr/IKtYMwA6OO3ZIzB7rUM2U8PLIZfrR29LUw3oW4z6fSx6kfSGZL0G3FXXlp2T5kywuLpbUUrAKAqx0Ww/Q/roSxBmFejJzoz48QW+qbbJw9b+E8vCPKu/g+vQnM/rIzD2n1Se8zMLEYvots7+r11BzAAwr1bL6z5oFygaCahN+5eYqjQNHwvoGyeq/4IH515V7LN4eJcUhnKbIp42C78QL5nE/oyNvFHCyA9F56/4l0Df6T8FjLnk6InlFchK/rEXg7pQNdDuJs7oTitlctCKTgTIkz60JcLCrPmPAS97Fpp88slNpbqgE6okwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nsf7BkWcw20L5vIQUXa5JY9g/PP3M1UdGxTqnlO7Zqo=;
 b=PvUJ2aS9gRuRQoZLloJR2/t+c4E07RVfZkNJShsmE1ZNolAfGbkVQaOQss2S49FOfSW91DWflwc8oLgyvakVS03uVh08E2vbMq1ZHP97WJ2jABm99PG1YCshnEq7YJnimgIiJ2gz/RV2nJgqxwQOK0PpYMckX3ELN1+2TcCOkD0=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by SA1PR10MB5823.namprd10.prod.outlook.com (2603:10b6:806:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 28 Feb
 2022 05:56:00 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::ec41:df7c:ccb0:22b4%7]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 05:56:00 +0000
Message-ID: <62e66ef7-a78b-7006-d852-83efad9e6bde@oracle.com>
Date:   Sun, 27 Feb 2022 21:55:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v14 04/10] NFSD: Update nfs4_get_vfs_file() to handle
 courtesy clients
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
 <1645640197-1725-5-git-send-email-dai.ngo@oracle.com>
 <18A7CDF9-74A3-42D0-AC32-F7B6CAF32D3B@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <18A7CDF9-74A3-42D0-AC32-F7B6CAF32D3B@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5e96da1-8422-4023-077a-08d9fa7eff0e
X-MS-TrafficTypeDiagnostic: SA1PR10MB5823:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB58238B40732BFA72E1D9261687019@SA1PR10MB5823.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3AbNW2QCqSXtZKYzf2omdTvWNOE2bDI7aexcwAXOpXKKfTKBE5nHhSmy8AYC7lOZsZ+LAl6Mi9Y/cxCoEKJSVCXleYjsHV1fOPXPhLOpZ/LToEey5X9fYt2y/kouyDYn1wbRSHnw0DAB0UwSCjJzkHuq1CrFruuvIgggLlkyffjYurkjdmpWUyueJ9qD0z8RbDOoc0SAwmVYVtQ7lqjZfrmqTArjuGfkgzvQlDjQOWj6bauSWS1YBom7hBZ9PwDih/o9za2YEBpCj4Jdi0f6KvqVBnr6wnC1u90V4lJSDBLiMp0OsTD5gi2drZ3dmcmSjItDC7Am1a9aBQ0/J4EJYzFyBPJZTDfrN2gYe1cyO7z28gUA30KauOs4HoKF5LXjkkMAEadAoWcGs9yRfuteIFIFfp85KfSyMZ2JLl8EsO9rMk4kGu6b8v7pY39HiThNol+UNuS6hsYyLPp6IGase1jUqxctOZhVMhBeBSSLk7fZxLd+5A/6qffLMHNFVNC8dMH4k8ql9cN2m/ZmaQnQxOebx8dVk2y6k6NspHFhc/agSKm7Vt6CkiJCmuwaJExB2dDuAsOYYVpJt4g4G8jOLNIGjao8TsWuvVUaf4y6A+3J6oLlKJTlvjeMvOe0+S8hfb0gN34f9zFfRXBm++YkATM/tHXBnZ03Mli9pnx388CeDDSBvteKUXTKGlg/ihFF5LYwSEEFfVY4bAaOv95x4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(508600001)(2906002)(186003)(53546011)(86362001)(66946007)(8936002)(15650500001)(5660300002)(2616005)(31696002)(26005)(6666004)(8676002)(66556008)(4326008)(83380400001)(66476007)(6862004)(316002)(36756003)(9686003)(54906003)(38100700002)(6486002)(37006003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkQ3SDE3c1gwWUVCRmpmSi9xbXRWWnhlSStzb0lVK2dxN3pmMkdnL3ZhdnZW?=
 =?utf-8?B?N1QrQWlWRzd4clJFNFl5UzViRTZQMHNaZmU0MDkyTTJoRGJPbXVCYVlzNlNm?=
 =?utf-8?B?d3Yzd0N6YXJEclc2TVJ0UGlqMjhwZkY2Zms5dDZnUzFiSmlZcGxleGN1WWtw?=
 =?utf-8?B?bGhUbEl4QnVBdVVtQVd3alQ4UjhTVlJMdHdINUpTNzNndGJTMnBLUEJXUkxQ?=
 =?utf-8?B?S2Y2K2w1SFROSUtlc005akpiVW5vOW1ndUF1SjdWSlhEQXVMS0J4OUNuaW5T?=
 =?utf-8?B?ZUtRazloYVJqSlBpNG9FdlFJWlZvMGNlLzlSZlZndVgzVE9BR2FQQjNIVUpl?=
 =?utf-8?B?OTdwQUI4MXEyMmtScEhLN0lqdVNMVE9TWFVZU3ZubmxhaXRLUkhnUktFNEZN?=
 =?utf-8?B?Wmh6Y2lVbWJxdmtYSmpYbkdFTjc4em5mZGtJb3Evb0wxb1FBQzFlRGpPNXla?=
 =?utf-8?B?ZWdMNEtaaUNxcDQvSjZCVHV2bDRBNWNMeEpFaVAxTytjR05uTUxxU2lDOFNH?=
 =?utf-8?B?c054N05ENFo0M1dockRoYW4zTDcxNHFUVGozNzdLTGN4YUp2UlUzNGI2T1px?=
 =?utf-8?B?SWx6RW5LdWdrZXVqN1VieDVYWUR0ZzFNYUFRYnFyQXFlVTVVY1ZMdnczSWFt?=
 =?utf-8?B?U0xxNDFRdlppeEhDVktZb3pUOXRVYnhJL1UxbXlFeXlOQ2htYUcrbnIyYWRF?=
 =?utf-8?B?ZGNHUTEwZHRTS01OYnhuZW5TT1F6Uml5Y3BYTjdNbllWZG9EQzRKRkRlZmJp?=
 =?utf-8?B?c0ZuckUzYjNXUlFkZE41c1lWc2ZIcGxuRldDTEZMK0htb0IyR1V0UlVVeExm?=
 =?utf-8?B?VzVuV1NKWlVNUzJWTDcremIweWUyMVpLb25RcTFEYnRpQktEdGtRL2FHUWdu?=
 =?utf-8?B?SmRUS0xGSE5rb0hXVndNdDNreDVDWVgvb3RhNnpnTE4zTU5Da3M0YnNUSzNI?=
 =?utf-8?B?WWRScnhQWitLY1hOK2h4cjJMbzVTYVE2WDFxdXEwRU05YTh5Tm9sbTdyOTUw?=
 =?utf-8?B?TEUwV0lLazI2dUorRnc4YXRwZmFyamlCMWhyT09aN1Nld09RSkZ4enF6NDVK?=
 =?utf-8?B?Nm4xYmdRcHh1aXNvRmRVbVp6YWp5WTFVZnBoVDdkK0pvQ0JVS0NZa0tHUzA5?=
 =?utf-8?B?OWhLai9tNksxbG5tdDVaMEJ4YlpIZzZ4RUNzM0F2dkd0cGh6ZUlWZjhVZ1U3?=
 =?utf-8?B?UmM1NmIrQytVNGE0UVZtWUpoeUxJVTROM0lnZlkzZENVZ21mTGozMDQrKyti?=
 =?utf-8?B?UlY4Tk1RZk9KRWFLS3lYNDZTdDJsaktzL1NPbytPN0dNKzJXNEFlbXBKa1dX?=
 =?utf-8?B?ZWFERkd0SThBNDF3c0Q2MjJVdC9TN1p6azFZbUlndVFMSzFxcWhkSkNDT2pS?=
 =?utf-8?B?UDZtd0kyLzJwWDZKQUpyVlZyb09oM0FxdTM2TDN4OVJ0RnQvSXpzV2g2UWFq?=
 =?utf-8?B?QTAzZ0RmWEx1eEdPMWx3K0JMVlh6SHhGNWJvaXJDWVNvYkNIY0RiV3puME0x?=
 =?utf-8?B?dG5ybit4cmZLNXJaSk82eFJtK2NqY0R1SVN3R0VOSDRibWNFZDUrUERDczNF?=
 =?utf-8?B?N3UvREU5N1llWmViUTJwWHYrVVhJRjFGL3BnNkM3Q01TS2F1MnNzWUExdFVa?=
 =?utf-8?B?VWRTRUlqUllyMVB4VzVObmFlb2VOdlAyREZSWU5hYXoxelRFU3djUXplSlEv?=
 =?utf-8?B?ZkI1ZElUMmhPSzFvYXVWVHIvNTZpQVBLdXBQcU4yY3pVVXlBTlFYeDRHQkti?=
 =?utf-8?B?cUdFOHVDZnBjU2srdTZBMS9QbjV4RDkrcG9rYlRmQlRYM0ZDck1SaGE4TFpL?=
 =?utf-8?B?MkVyY0VIbEwvL1hpTTU5aldnOUVWcnVrNy9Fc3JKcld0Qm9OMStDVm1hNmdp?=
 =?utf-8?B?YS9pNm1NR2k1Z3lYSURoQXJxZ2tlYm1uVlFoWUVqZWUyYTNwVWRjdDNYS0c2?=
 =?utf-8?B?bkpEM0JhT21CVXFyRTJtOWdTTVo3MG53RmNHMUtTWThnU2QzSmtrWVJHdXFr?=
 =?utf-8?B?V3V5WitvdHM3VVl3bUl5cnM3cTdYaXhxV3lvZ1JUbFBrQ0tDejF4M2lRTkcy?=
 =?utf-8?B?N1MyNXVNNFpFMkdrQ3VEQjJIWkgvWngrZ1lrKzJlUTlHUnJyRVlYVGhMSU45?=
 =?utf-8?B?RFk4dmo1U2FRMk5LeFIvNDRFRS9MdjFNVVNrUDdlMWVnWW11WEh0M09EajFF?=
 =?utf-8?Q?x8U51DXm/BzhSmfkhpMombo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e96da1-8422-4023-077a-08d9fa7eff0e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 05:56:00.3755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2yV8E/bONsP9kPuCzYgOXzlKz93vA2s8cB7JLBhvzrr6hRWQ3W+B2ilVXkrjAvhI7DSm6F1d+RlAujzaCvetA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5823
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280034
X-Proofpoint-GUID: oJomU8B4xr5834cUJAFTEYO2XObbMxy_
X-Proofpoint-ORIG-GUID: oJomU8B4xr5834cUJAFTEYO2XObbMxy_
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/25/22 9:57 AM, Chuck Lever III wrote:
>
>> On Feb 23, 2022, at 1:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Update nfs4_get_vfs_file() to handle share reservation conflict
>> with courtesy client. If share/access check fails with share
>> denied then check if the conflict was caused by courtesy clients.
>> If that's the case then set CLIENT_EXPIRED flag to expire the
>> courtesy clients and allow nfs4_get_vfs_file to continue.
>> Client with CLIENT_EXPIRED is expired by the laundromat.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> I'm still getting my head around this, but there are
> some items that can be addressed now, below.
>
>
>> ---
>> fs/nfsd/nfs4state.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++----
>> 1 file changed, 99 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 542a13676c91..1ffe7bafe90b 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -4965,9 +4965,87 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>> 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
>> }
>>
>> +static bool
>> +nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
>> +			bool share_access)
>> +{
>> +	if (share_access) {
>> +		if (!stp->st_deny_bmap)
>> +			return false;
>> +
>> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
>> +			(access & NFS4_SHARE_ACCESS_READ &&
>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
>> +			(access & NFS4_SHARE_ACCESS_WRITE &&
>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
>> +			return true;
>> +		}
>> +		return false;
>> +	}
>> +	if ((access & NFS4_SHARE_DENY_BOTH) ||
>> +		(access & NFS4_SHARE_DENY_READ &&
>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
>> +		(access & NFS4_SHARE_DENY_WRITE &&
>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +/*
>> + * Check whether nfserr_share_denied should be returned.
> This function is doing more than adjusting a return code,
> now that I'm reading it more carefully. How about "Check
> whether courtesy clients have conflicting access."

fix in v15.

>
>
>> + *
>> + * access:  is op_share_access if share_access is true.
>> + *	    Check if access mode, op_share_access, would conflict with
>> + *	    the current deny mode of the file 'fp'.
>> + * access:  is op_share_deny if share_access is false.
>> + *	    Check if the deny mode, op_share_deny, would conflict with
>> + *	    current access of the file 'fp'.
>> + * stp:     skip checking this entry.
>> + * new_stp: normal open, not open upgrade.
>> + *
>> + * Function returns:
>> + *	true   - access/deny mode conflict with normal client.
>> + *	false  - no conflict or conflict with courtesy client(s) is resolved.
>> + */
>> +static bool
>> +nfs4_conflict_clients(struct nfs4_file *fp, bool new_stp,
>> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
> Functions that are called with locks held are usually
> suffixed with "_locked" -- this one should be too.
>
> A better name might be "nfs4_resolve_deny_conflicts_locked".

Fix in v15.

>
>
>> +{
>> +	struct nfs4_ol_stateid *st;
>> +	struct nfs4_client *cl;
> Use "clp" to be consistent with other areas of the code.

Fix in v15.

>
>
>> +	bool conflict = false;
>> +
>> +	lockdep_assert_held(&fp->fi_lock);
>> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
>> +		if (st->st_openstp || (st == stp && new_stp) ||
>> +			(!nfs4_check_access_deny_bmap(st,
>> +					access, share_access)))
>> +			continue;
>> +
>> +		/* need to sync with courtesy client trying to reconnect */
>> +		cl = st->st_stid.sc_client;
>> +		spin_lock(&cl->cl_cs_lock);
>> +		if (test_bit(NFSD4_CLIENT_EXPIRED, &cl->cl_flags)) {
>> +			spin_unlock(&cl->cl_cs_lock);
>> +			continue;
>> +		}
>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &cl->cl_flags)) {
>> +			set_bit(NFSD4_CLIENT_EXPIRED, &cl->cl_flags);
>> +			spin_unlock(&cl->cl_cs_lock);
>> +			continue;
>> +		}
>> +		/* conflict not caused by courtesy client */
>> +		spin_unlock(&cl->cl_cs_lock);
> I think I'm seeing similar code as this in some of the
> other patches. Whereever you can, please deduplicate by
> creating a helper function and moving the common code
> there.

Fix in v15.

>
>
>> +		conflict = true;
>> +		break;
>> +	}
>> +	return conflict;
>> +}
>> +
>> static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>> -		struct nfsd4_open *open)
>> +		struct nfsd4_open *open, bool new_stp)
>> {
>> 	struct nfsd_file *nf = NULL;
>> 	__be32 status;
>> @@ -4983,15 +5061,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 	 */
>> 	status = nfs4_file_check_deny(fp, open->op_share_deny);
>> 	if (status != nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_conflict_clients(fp, new_stp, stp,
>> +				open->op_share_deny, false)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> 	}
> Doesn't nfs4_upgrade_open() need to perform the same check?

Yes, we need to do the same check here. Fix in v15.

>
>
>> 	/* set access to the file */
>> 	status = nfs4_file_get_access(fp, open->op_share_access);
>> 	if (status != nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_conflict_clients(fp, new_stp, stp,
>> +				open->op_share_access, true)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
> This is nfs4_file_get_access()'s only caller. Should the call
> to nfs4_conflict_clients() be moved into nfs4_file_get_access() ?

We could, but I think it's better to keep the call sign of
nfs4_file_get_access as is for speed since we don't have to pass
additional parameters for nfs4_resolve_deny_conflicts_locked
which should rarely need to run. Also, I think it's easier to
understand to code when both access and deny check are in the
same place.

-Dai

>
>
>> 	}
>>
>> 	/* Set access bits in stateid */
>> @@ -5042,7 +5134,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
>> 	unsigned char old_deny_bmap = stp->st_deny_bmap;
>>
>> 	if (!test_access(open->op_share_access, stp))
>> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
>> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>>
>> 	/* test and set deny mode */
>> 	spin_lock(&fp->fi_lock);
>> @@ -5391,7 +5483,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>> 			goto out;
>> 		}
>> 	} else {
>> -		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>> 		if (status) {
>> 			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>> 			release_open_stateid(stp);
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
