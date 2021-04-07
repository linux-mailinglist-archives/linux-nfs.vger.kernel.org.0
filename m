Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20CE356093
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Apr 2021 03:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhDGBNL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Apr 2021 21:13:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55274 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhDGBNL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Apr 2021 21:13:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1371AEbV100061;
        Wed, 7 Apr 2021 01:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=37Cl3UQQPGjXqBW9AEw7ZhpZ/GRekWvplJwmovtgY9k=;
 b=R7+EU58YX/hBH9BmE1IhkrLo1Jch8rMKtCH3aL35/nwfBxRhCZqm5EYaSqKGRhknlbKJ
 EbdguxjKGn/TCAJxExNslmY5RnjhvSIkYJie/KQVAaAJaAHxL4LLdALA7Td/6GWHwEJI
 Gt24VSdVOet81ecGG87hDFsJ3+8TDESXvB4N+xO1tDoaYPADVLFTH4+YCPeGpMHRWqIy
 P4CzPz4G8coIEeaiaKulRTctN+CHjC3k+/shO2GlMQ2ipj1K4FukkCKtooY/0B5I82zV
 Ub9J6Qk7DGGxcqGMt3pz1INfioWibXb4RmqzgLzWgMistXIlUvFFRc+GVIdpkXkxIq5u 9Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37rvag8vc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 01:12:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1371A35M066822;
        Wed, 7 Apr 2021 01:12:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3030.oracle.com with ESMTP id 37rvbe473k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 01:12:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJmr5S2W0JBPBPt46SszdQvOMAwP69ZSdFi0BFG/eShQUKYFtD/uPrLnlrssWVClZJYej7/neLslRcV01lMsn4Lw9DPwCbTTJPG+Ojl2/PiaqYemMusP9xeGdikJzHq5XffYVlHROksXEi2pJNzAhFqdL6runphs9isCgwjEAGcEnaM3ap+ec45NMzx3xdCQ0Wi58TxhuCM8pft7Dfs5Lm9NBR6Cldl2DmrV29H2npZdo2RvDGPHa0FiA/vwN2B4Ooul51qIP4vZ9iacqUpcoyDtKHkrmSCOVp7rxj1xkyk/jTYh8+y7tJ0tTRiJHZjORSDf6DvPP+t97txPIU/iBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37Cl3UQQPGjXqBW9AEw7ZhpZ/GRekWvplJwmovtgY9k=;
 b=QRi6UQELoVq/sP2pfgWah2djJJDcQV+xO+20hillGZhqvsk71bOknWq7FgHUY47q0Yc1x3Hd77Z9WnelxTupTn2CbvnNo0I62SQ66+yxp/rZcen5xaCqCefjuOjnI7fQYQ8lRt8kiSd8+6xqhnMDR2wShPGGy5Bcdg05OnbPk/LbHADPl2fHhFDHSY4BK3hAECDBr3mt2o3N8pphZYmGLhqPDnu24WlAXoi3vYmaDwpeLv+Mwwrfs7b23piVPkpFMEGliSLTSn+RZpz+KMlTm00fwgY0XXKCwBK/rY2lCHpZk8CHMS3R3aDThd/x6P+IC3DO64G3ymuQRyyr0eCPZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37Cl3UQQPGjXqBW9AEw7ZhpZ/GRekWvplJwmovtgY9k=;
 b=H2IotGUszAHUleroQ/CQ5c6LRLXuLwPp3tux5GL58c93fLJFVfSvLSDahtCQpv750AklByaldEUTUSyEzB/rMo8Mw5XBIfy3UqYxDAAh6dfeNjhXR3agIVI7GT/nO4RXwpkbm+T9YE4RvCLpzEZAlYLEoiw6peGObJ/TcbzglG8=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3461.namprd10.prod.outlook.com (2603:10b6:a03:11e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 7 Apr
 2021 01:12:48 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 01:12:48 +0000
Subject: Re: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's
 export.
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>
References: <20210402233031.36731-1-dai.ngo@oracle.com>
 <D85FBDD3-5397-4D47-932D-159AFE2A5E0F@oracle.com>
 <CAN-5tyHVOEr7zZM92PVS0GYJQ2M6rSs6_zqZwuioumQQm7zzUQ@mail.gmail.com>
 <7BED2160-1052-49EE-BB62-6ACF6F84C91C@oracle.com>
 <CAN-5tyEKqNHmwiMfCpkZrCVYeaO-FH69v5L4Tk_8EsoTfytpVA@mail.gmail.com>
 <01CD778D-57A0-442A-8D1D-5084F0FC2497@oracle.com>
 <CAN-5tyFEXBiWVbCq0Hgh01W=OVZkdYYAEujSug6biBaU=Ny8Og@mail.gmail.com>
From:   dai.ngo@oracle.com
Message-ID: <99a1f327-ce69-e6eb-39fc-77991bec5b4c@oracle.com>
Date:   Tue, 6 Apr 2021 18:12:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CAN-5tyFEXBiWVbCq0Hgh01W=OVZkdYYAEujSug6biBaU=Ny8Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::24) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Macbooks-MacBook-Pro.local (72.219.112.78) by SJ0PR13CA0169.namprd13.prod.outlook.com (2603:10b6:a03:2c7::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Wed, 7 Apr 2021 01:12:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 549ec80b-29ad-4d80-9a98-08d8f96241f4
X-MS-TrafficTypeDiagnostic: BYAPR10MB3461:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB346129A37CD51F9EA308DBFE87759@BYAPR10MB3461.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Raca2THfvffa24sLA3NmBL0CKRQU0mYSuQbm/OcVQiRBV65+uc3T3aeggFrSnMQ0X8Ote49H7CPgubkP3onMU+efeGt6xNXd0q09S9/FvV5gM3UGvLm3KBpjed1WPQ7hYaOBnnzKFqWsaLj4uAc5jgC5V76YZxM1OGqOiwrXw9q0+1MZYaoIETEU9Ovu1ArKiqbOdbEvYFeuvb8YHBQ0nCa3EnbRTmexsOZA4WiuNOirkV4ac4CY8+aHsMpfN4jcisB2sGPqg3W2Z88ZnIds9WHLLYiwWI+FkKf6zWSjPTyttsC6N5jTx2jZH4OeUnsw4MJ3RScuiht5VV1Cbk0k3j6B+RdfjW3PBm4mP6sXSvSnDB258iL/YSVVzwCM8FMHgRhOcDyk1432c+HsolkXJcvJa6fVvcGqQHYiP/NBbEBZfrJXdwdDS43pyLYL/qzgGik7syy92RKuqTL0Oc0vPSXSRdJb5Rq6hWVZrvv8vCw6wvJ550RPP+Ivm02C5VvUHJwCfjBVFN969zUh3NmzmoQOKV3VEaxArUPdU5v864OtVSZO65W+lWhrJLwH3nGZwMkLRBTCrVhLaoCTeFVqiqeP/+FkdTxf8O+S9oMBX40c7omcIcXxXenA/i1NM9yDH0GYVPKXH9MgDrX7t2lk5cxzdwMNI/9PdcKQ09/8WuW+aGM/WlyWrhzngpgc/9su
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(376002)(396003)(346002)(36756003)(8676002)(4326008)(6512007)(2906002)(316002)(8936002)(9686003)(31696002)(66946007)(66476007)(66556008)(38100700001)(31686004)(2616005)(83380400001)(956004)(26005)(53546011)(54906003)(478600001)(16526019)(5660300002)(86362001)(110136005)(186003)(6486002)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WDhlRHAyM214RWtXUk9TOVpJY3gwUDVvWWRDYzNSU3NKMWRPak9EejA1Yllt?=
 =?utf-8?B?cFgrcWxrbVhOOEUxaG1FY2phUjVNSGVrREEzQVRXVzlyR1BXTWR0NC95Vy9r?=
 =?utf-8?B?YXFYd3c0dzY3S2RNemNIbTh2R24xc0RKVE1uVEJyQkpOVDIxZW15WHVnd2ti?=
 =?utf-8?B?dHJqQzNPQUU2R1V0Yk5uNWtTY0xRZllkdGdDeHhrN1hDTGZOdEsvdXhVZGtZ?=
 =?utf-8?B?dlRoV1p6bHNzRmJyTDQralVuMkJnS3d5c2ZNUWk4WFFnQ2ZMWFNTd2ZMUnls?=
 =?utf-8?B?WWRzTlN0SW9nQ2pkZFhkdThLWWtuNzZkbHc3SVpRMWt1bXdJQlZzck5Ea0Ju?=
 =?utf-8?B?bVd4VmV1YU5rNVhGT1kvY0J4RzFNTTVLY1JqVjFZRnAvMWY1NzNUUEZ3aHBR?=
 =?utf-8?B?RjFmRFhBMjQxbDVNb1N5Zzh1dmdMWEJmSk5JbDBDZUhrQlZ2VmdBYnZqdXox?=
 =?utf-8?B?L2RURzgvS0ZvY0lGbXdYRFRrRFV1MVF4QXFnNnR0L25yUEFIQXMwRGoyVWww?=
 =?utf-8?B?UGRIK3R0VFJyc1FiOGJrWFBwV3VFbGFrcXE2SWZDMTQrdlU3OW5JbVBtMGly?=
 =?utf-8?B?a3U5QzJpcis2N0FJYzN6VUZuazVRdmt3V2xiU25YKzd6czFPTllOdFBTb2ls?=
 =?utf-8?B?SExCekgwN1FyQ0FTVXpHMXFtUkMyRmkyaVkyUkVtRDR1bkRhWGhMMGhvUDVP?=
 =?utf-8?B?cjFLRFpqb3RkL3g4T2RRaDZ5NjllS0R1ZXh4Yitpem1ENEplSHR5VXcrQXZw?=
 =?utf-8?B?Mnd6UUxubCtWK0Fmd0ExQit4Y3RkUzM5VlA5cHJyWjFUTWZMVnVXSnNxdE80?=
 =?utf-8?B?M0hCSlBBaks0UUFhN2NsSU1SR2tCaURhUGNacTdDdkRtNElNSFlnUnFueWdG?=
 =?utf-8?B?dDBPMTBzQ2FWK1NmYlJYVVBKRGRVWDRnZnRUQ2JDcUlRWWdCM0tIM3A0NWFx?=
 =?utf-8?B?cDM5dHI0V3VqVTNpWUdmbGZYcno1N2ZUbEl5MHB5UUx0ZUpndUFBM0pWSDUz?=
 =?utf-8?B?UnY4cjRCVzFHYjZTcWc4U1J3b2NCZDBPZHpzYzFOejFCT01VK2FpdkVjL2Nk?=
 =?utf-8?B?TWVFT1NucmthbWNBUldYQUdhTFpFaHRqV3VKT0FBSVdNZVpFVEY4QjhsSXda?=
 =?utf-8?B?SDZSWWdzL1BzZG13Y2s5U1V2S2FQckU1cXNEWUh2TFkyQTIxWkhCeEFSNlpE?=
 =?utf-8?B?dFk2YzdzdmR6QWs2ZjdXME14anVvNlZHTnNJM2ltWVhPT0NEL2NtTDE3M2Yv?=
 =?utf-8?B?bU1xN0ZhbjZTbWNubmduN3NrVXU2RUtkVUxNdVQvdzlSSEl5dGdrdEVXS2V5?=
 =?utf-8?B?cmFyWmdISlZyZ3BkSTA5clBqblhPZFUxNDN6QVlsTzdUeUxLVFpvTzFONFJH?=
 =?utf-8?B?TDFHUlZ4aVVoYW85ZW5NL3c3L3lzRXRrNkRHR2tMV0lSQkRndTB0ckNxeVUw?=
 =?utf-8?B?VW9VOXlQWmhBWmg1TlpiRlJ5VnV4Q2pEV3NBZ0xrcTBSay9NQUtlU09Ca3Vk?=
 =?utf-8?B?STZRV3BGUnJRQXRlVDQzUkNxYmt4d0hzMnUraDVaS3Z4cXJEelZPYW10bDRD?=
 =?utf-8?B?TTVxTExhN0IyWmhCbjZmdWRvSUk3Ris5ak9mQWNaSVczN2t2VkZ1amVXSDBC?=
 =?utf-8?B?RG5YaVRXQk9DZGhFN1FQMDZPWm5WK1VGTmxUZk9NQmNJUHBzaWFOVjFjRkxD?=
 =?utf-8?B?cENYejd0MG5kaWhiSEswNkZIYWVnNFJPU3FvZS82OW9UZzVCTTRaaWwrSnhr?=
 =?utf-8?Q?f+rNHUGZZ68jFHjB2CSUZz3vbEhU/1XFWA+hsYl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549ec80b-29ad-4d80-9a98-08d8f96241f4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 01:12:48.2740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E49inIin1meK+z90iVcZMHHdewarg81XKO5ja0esU3geeO/KyhKEWGsYuajZB7/DK4FbM3/Gti2oPa4lbpX/ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3461
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070005
X-Proofpoint-GUID: 6bAaljo0FoKGpX7mfVLufSz8fM1U5BU8
X-Proofpoint-ORIG-GUID: 6bAaljo0FoKGpX7mfVLufSz8fM1U5BU8
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070005
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/6/21 1:43 PM, Olga Kornievskaia wrote:
> On Tue, Apr 6, 2021 at 3:58 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>>
>>
>>> On Apr 6, 2021, at 3:57 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
>>>
>>> On Tue, Apr 6, 2021 at 3:43 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>>
>>>>
>>>>> On Apr 6, 2021, at 3:41 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
>>>>>
>>>>> On Tue, Apr 6, 2021 at 12:33 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>>>>
>>>>>>
>>>>>>> On Apr 2, 2021, at 7:30 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> Currently the source's export is mounted and unmounted on every
>>>>>>> inter-server copy operation. This causes unnecessary overhead
>>>>>>> for each copy.
>>>>>>>
>>>>>>> This patch series is an enhancement to allow the export to remain
>>>>>>> mounted for a configurable period (default to 15 minutes). If the
>>>>>>> export is not being used for the configured time it will be unmounted
>>>>>>> by a delayed task. If it's used again then its expiration time is
>>>>>>> extended for another period.
>>>>>>>
>>>>>>> Since mount and unmount are no longer done on each copy request,
>>>>>>> this overhead is no longer used to decide whether the copy should
>>>>>>> be done with inter-server copy or generic copy. The threshold used
>>>>>>> to determine sync or async copy is now used for this decision.
>>>>>>>
>>>>>>> -Dai
>>>>>>>
>>>>>>> v2: fix compiler warning of missing prototype.
>>>>>> Hi Olga-
>>>>>>
>>>>>> I'm getting ready to shrink-wrap the initial NFSD v5.13 pull request.
>>>>>> Have you had a chance to review Dai's patches?
>>>>> Hi Chuck,
>>>>>
>>>>> I apologize I haven't had the chance to review/test it yet. Can I have
>>>>> until tomorrow evening to do so?
>>>> Next couple of days will be fine. Thanks!
>>>>
>>> I also assumed there would be a v2 given that kbot complained about
>>> the NFSD patch.
>> This is the v2 (see Subject: )
> Sigh. Thank you. I somehow missed v2 patches themselves and only saw
> the originals. Again I'll test/review the v2 by the end of the day
> tomorrow!
>
> Actually a question for Dai: have you done performance tests with your
> patches and can show that small copies still perform? Can you please
> post your numbers with the patch series? When we posted the original
> patch set we did provide performance numbers to support the choices we
> made (ie, not hurting performance of small copies).

Currently the source and destination export was mounted with default
rsize of 524288 and the patch uses threshold of (rsize * 2 = 1048576)
to decide whether to do inter-server copy or generic copy.

I ran performance tests on my test VMs, with and without the patch,
using 4 file sizes 1048576, 1049490, 2048000 and 7341056 bytes. I ran
each test 5 times and took the average. I include the results of 'cp'
for reference:

  size     cp          with patch             without patch
----------------------------------------------------------------
1048576  0.031    0.032 (generic)           0.029 (generic)
1049490  0.032    0.042 (inter-server)      0.037 (generic)
2048000  0.051    0.047 (inter-server)      0.053 (generic)
7341056  0.157    0.074 (inter-server)      0.185 (inter-server)
----------------------------------------------------------------

Note that without the patch, the threshold to do inter-server
copy is (524288 * 14 = 7340032) bytes. With the patch, the threshold
to do inter-server is (524288 * 2 = 1048576) bytes, same as
threshold to decide to sync/async for intra-copy.

>
> While I agree that delaying the unmount on the server is beneficial
> I'm not so sure that dropping the client restriction is wise because
> the small (singular) copy would suffer the setup cost of the initial
> mount.

Right, but only the 1st copy. The export remains to be mounted for
15 mins so subsequent small copies do not incur the mount and unmount
overhead.

I think ideally we want the server to do inter-copy only if it's faster
than the generic copy. We can probably come up with a number after some
testing and that number can not be based on the rsize as it is now since
the rsize can be changed by mount option. This can be a fixed number,
1M/2M/etc, and it should be configurable. What do you think? I'm open
to any other options.

>   Just my initial thoughts...

Thanks,
-Dai

>
>> --
>> Chuck Lever
>>
>>
>>
