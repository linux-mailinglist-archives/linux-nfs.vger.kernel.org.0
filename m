Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6C4357D37
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Apr 2021 09:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhDHHUV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Apr 2021 03:20:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39476 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhDHHUT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Apr 2021 03:20:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1387JC7f009058;
        Thu, 8 Apr 2021 07:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QM5KH9d0QaLPCHYN8VNKO9URtkwocAJFbZcUAQSGR0A=;
 b=P3KVoevSbEzQPP0kms14Y+QPYpsePJWpMJ1dn3R/MgXyKZngm3FNfptd8Ou03PX9G+xt
 5VI89zAUwPVr7q9HDCwbqBblX/hdAC8Q3m4MGG5vtM+gz+0kXrxaBrVwLLFHR1aya3gv
 k2muV5XVgngxK+11r9B9sxuEa9d2gQYP1gD4FYVoG7th64ZHwFbSaYbT+AufsQJadrL4
 tvsJUuGuIuYFwVSJf7lZg/X8adxzmxNpOxtsEDKhK6yAfISxnh1U1g/kNHKb90x0Jlsj
 MbShkw5gPR4yLuW0QTZz6Vy/EyAAXIBaWvQDlzeK0qroQKRrRrXhb5VNxJT/FSALlQ+f 4g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37rvaw4us0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 07:19:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1387BAd5026248;
        Thu, 8 Apr 2021 07:19:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3020.oracle.com with ESMTP id 37rvb0uce3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 07:19:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeXe/Y5S7x9Nzlr97YRwXFSAJZjJi8FKL9nzKm7EOe5ob/8094t0Ha7wmIy1+gbtCGlpiusUOOydrXTgfnXDJNJGFwad1L66sW46LaSePdxAEprX/Le6lWxHXSPzQ/5RW7q5RcMkrstYZXfq8AmEPbCowjQIVigBmCB+23cPvVFRCGBQQtBKanRZLSjbGD6idhsLI3xTeu7UDXDsf2M/AsM2aC2y39pfum9O5L710KD/kua8i3M/g9QyCaIyzknqwieDL315juBbfwDbZjgvpgu+uFl4pRHaHSh0sbl1EUcASW3/Pp/dhe/Ns8T2RXWUub9aLjRd0g1EtfO1TKHBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QM5KH9d0QaLPCHYN8VNKO9URtkwocAJFbZcUAQSGR0A=;
 b=OYD2J8wiBmIGoYU4Y4T9eD+ZYNR15O5aEDRfilIPLVOI1t/HHACNQYROQ2udBteYXjMQkjmn3HjkP9izSZ2WOARzwpjhgkAzKerZsV+XDcIlnhgq0LpVuxsKY4Q5stAkypYL5gt9Zad3xFMZj2EBaafl6/vEvemAKbVfXIJD7pGcVTTGSfzV7qj1rieqi5IP8Ncb0NATLHrCSAVyhB983cNGBh75DCeyYe5gIKH+8pYFRzFdAZEfHIvPGOO6qtlLEhhwh/HW7auEofniA1k+ONFJd5RGDDT294O7HrUpPTG7MncN37eFpLibtRVeS7+ZGcAYXIL6F/k3JMUGSNtEbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QM5KH9d0QaLPCHYN8VNKO9URtkwocAJFbZcUAQSGR0A=;
 b=WaXk50nHFgzoM27OeUJf+EJAk/F/rf0NIPKmjkzhu/S6KVJGDjVCRT6LCnu4fMqQyanQkMR9sktAnonchRp769dZntoS8wl3NaGbWBJuxzsQNyes31dp/70tlW9BghVidW30thlpb5/P/6JddFerQSWWHUE415avTSSeYLXnaoA=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB5488.namprd10.prod.outlook.com (2603:10b6:a03:37e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 8 Apr
 2021 07:19:56 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.3999.035; Thu, 8 Apr 2021
 07:19:56 +0000
Subject: Re: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's
 export.
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>
References: <20210402233031.36731-1-dai.ngo@oracle.com>
 <D85FBDD3-5397-4D47-932D-159AFE2A5E0F@oracle.com>
 <CAN-5tyHVOEr7zZM92PVS0GYJQ2M6rSs6_zqZwuioumQQm7zzUQ@mail.gmail.com>
 <7BED2160-1052-49EE-BB62-6ACF6F84C91C@oracle.com>
 <CAN-5tyEKqNHmwiMfCpkZrCVYeaO-FH69v5L4Tk_8EsoTfytpVA@mail.gmail.com>
 <01CD778D-57A0-442A-8D1D-5084F0FC2497@oracle.com>
 <CAN-5tyFEXBiWVbCq0Hgh01W=OVZkdYYAEujSug6biBaU=Ny8Og@mail.gmail.com>
 <99a1f327-ce69-e6eb-39fc-77991bec5b4c@oracle.com>
 <c16b4437-a554-be60-3c04-fd578b9f88ff@oracle.com>
 <CAN-5tyGS0ZO4PtTseLSmC4=fYQCUwMs6FB509g2PSCg1v+jySg@mail.gmail.com>
 <0b0c7c79-d593-c4ae-db9b-46600f2cea28@oracle.com>
 <CAN-5tyGw8_xOfMM4PNUCvo_wKEHs5NgLo3ZQf-sTGb6FHJ_r8Q@mail.gmail.com>
 <3b6e1b4f-4276-e503-9432-e15a339cac9f@oracle.com>
 <CAN-5tyG7HPQxAK-o-q8=_-wtewBcymian2AQV__p=HgL+jJPcQ@mail.gmail.com>
 <d9a26bed-6e29-a0ea-b6a0-2fd30c240a9b@oracle.com>
 <CAN-5tyG4gQ4t0PF9v=8m4BfS-a3iRud0ywmLX2g-Vm8+FCosJA@mail.gmail.com>
From:   dai.ngo@oracle.com
Message-ID: <b2af3336-3724-59e0-d64b-9372cbdb444a@oracle.com>
Date:   Thu, 8 Apr 2021 00:19:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CAN-5tyG4gQ4t0PF9v=8m4BfS-a3iRud0ywmLX2g-Vm8+FCosJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::23) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Macbooks-MacBook-Pro.local (72.219.112.78) by SJ0PR13CA0168.namprd13.prod.outlook.com (2603:10b6:a03:2c7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Thu, 8 Apr 2021 07:19:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f14f7796-1c4b-4d62-0ee5-08d8fa5eb631
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5488F1360814660BCEE948B187749@SJ0PR10MB5488.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3HhldcR4YQtiG2RYC0DrgSBwMbitiKyZ41Efa3UgXvqIkLfGYSot9txaw9WygJo9pP/XIdDfGpFaocZ9nJDGslNLfkdYjGKD1BtXVJtvGwDB0HA8F+pGxEpD5ppwYp1/yhATErlT3qqYp/I7VOEEu26v3pAybxrgghlwyR6YKEvR8JIjihk9bliB8Vp/PP3MaTPJi7+NlBs2a5HaFIDWQ+LfymEnTMK0bPw5sB0E6LKuyxktAz5D3GAeSVHlEgoqTvVrB3pDfyPrF0J/3XwbxJPI5ziNe7COkk/1Iff42Xpj6AMC8LlX4f4qbzZ0v06nsN47eV/HtpC/6la4AnnB+iEe23+89H7WbEFjAaetPXtYYyLmiEJJiChBzl3NpjaiWFmcnaswfeK8sGJRZL/7SEGv/JkqimsUDw2cHlD0oF6F51snt7PL/z2upo62iAiLHpBAVDVbEqXkNKMtTzZSnFXcyth7pd3dGJ/suVTVmVmGOH8/YI5JL1gyycYwGvWD0m2awN18rUVDtOWtq76u0JKPYtHaKdbHNJQucXo2N43Wez6Vt4w7ZvVjh5o9sb/pddIJIY+5ySPD6wgH/9aj/XrzM6wtUDTZ54U8lr/u9q6UgEpAiYP7x03u9IZrLIYV35il2ejqbOMJnSYJf2+msGjAKco/qoRd1iIU4AIcjmtmQpahMh/ab6J+2sVuYPQ4amEmFdQKsJSU7sEMPZrUrBHybQDlOym67pOcY096IFvMRvYyC8YVsroqYEV0eAlBUC7/I1iqrBmitVJFSdFwFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(136003)(396003)(376002)(9686003)(31696002)(5660300002)(6512007)(8676002)(8936002)(478600001)(54906003)(36756003)(38100700001)(966005)(53546011)(6486002)(6506007)(31686004)(316002)(30864003)(86362001)(4326008)(2616005)(66476007)(26005)(186003)(2906002)(66556008)(6916009)(83380400001)(956004)(16526019)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Znl4ZHlZQWI0TnU3ME41MWxKcnk1YnU1OEpUdk9KcXk4R1c2bTAyMk10ZUpF?=
 =?utf-8?B?a2x0M3lzY1ZiOGFjTHpVaE1NSGU1L054MFVLSCt2UDJXTXlNYTlvUVRmZFNp?=
 =?utf-8?B?cmN2aUx5TkJMdytRVVAweXREem1kb2pzRVJXV2ZYTkkxSHBwYTJYUERTa3dJ?=
 =?utf-8?B?clBXbnZLRHphWFlxUWJGemRBVW1MVXYzR0xkMjR2RWs2ZHYrN2pmNXI2NXh0?=
 =?utf-8?B?RUxGTWFCZVI2WFdFVWRkK2VwS1JHYmVIbklVWEF1RFlpNStGYWJFQVBjcGNW?=
 =?utf-8?B?RksrTi8yOFhubndhL2hvbVZYaWhydU1zY0NJRlNuL0s5a0hZWk9FU2FRaXNj?=
 =?utf-8?B?VUkvYkJXbzZqQ1hrM3lXL1ZSYU5ZRjkzVGl0aUxaNy8xU3M3ODVMT09LRkE5?=
 =?utf-8?B?T1RvZnVhT3FKeXAydG5YZzB0OVpyUUdNR2NQd2tWeXlZL3lFSElHbVhMT0VS?=
 =?utf-8?B?SDd0UUJkd3ZwcnJVMmlrdU5KMGdSUVExbm5CUzJqdEtVZ00vcnNFcUxPZm45?=
 =?utf-8?B?MGw5Wmpad29Wa29PSUIzaHZZcytJcURZVUlMUXNWV25xQ0FqWGt0UHVXYkpR?=
 =?utf-8?B?bDhYcTNoOFRqcWNiRjgvTmltd3BNeGtCaDZhL3ZNSFg2WjY3YUZ4ZWxBM3lv?=
 =?utf-8?B?OUZaY3cyREV4anp1VFg1N0hmcXBQamZwZnNWMkNZV1U0eGtTS2V5dmE0TGRS?=
 =?utf-8?B?T205V1o3MjR4UXM4Q0lTR2hsRWQvLzQ0elNudERUaE04RFBhY3JVaVp3WUcv?=
 =?utf-8?B?a09JS01OOGVkdVIvT08vbFY5Rk45RXpYcElxUFBINndTU3g4dVdDbWZvcjRa?=
 =?utf-8?B?dEtGUnIwdEVmUVQ1RWQvUm1HMlB4dnRJbmVpUTRrMjl3SURoZjVDKzVOT0px?=
 =?utf-8?B?VzI2VkJ2eGtqaUEvWTgvTlFkSUxucU1IRnlmNFVqY2dnWks3Y3hVVFMvU3p0?=
 =?utf-8?B?OUFGM0w4RmtJNWVXV05yY3RsK2t2K0dsaVdkYlJyMFd1Y0cxMUp0Zkp3dkx1?=
 =?utf-8?B?OFdGUTBiUHp0RU45VTZWWnk3NHBBUjYra2NPaHYzT1ZzOXEwZ0NEK1BzQ0VT?=
 =?utf-8?B?WVhoM2V5cHI4REFaRzdaSWZLaFFoL1VhbkZReTJQSEEzSXdtcmxId1A0WXli?=
 =?utf-8?B?dzJoR1NpT2RvNTh6MGVZdGNqZkprazFDUXl5R2M3bmJDNDdIMTFOZzNVdDhB?=
 =?utf-8?B?b0ZiVVh3Tk9nbUthanNQdWs5dkFhc0JyT0J4a3IveStITmljNHQ3bDhBZTlI?=
 =?utf-8?B?Vk1DOUZML3BhV0pqT2dRZXdqVGg1SGVNU0x1M1g2eG1zOFZ2NUxIbkg2Zm1F?=
 =?utf-8?B?eHdlSnlGd3hON1B1TGpMQ3o3NVJOWnFHTFc4aVNvUnhqa29sandSaVEwQklD?=
 =?utf-8?B?UW12ZXhQUnVJQ2g5ZDVJYmM0cTVYdkUwTVpCOHFLby9aSHBtS0pITnJlL1ZU?=
 =?utf-8?B?UERDUnczLzZxL1JwZFhxeWtqdEg3VlhFbHdsRE1UaU1HaVl1d2lMc1Z1aklN?=
 =?utf-8?B?TzIraTBtd1lQNkMzQUI2QWdSN3RadXBKVzBkenVHckcwcmgyRlZ1TEhFVzlB?=
 =?utf-8?B?Y1hyTGt6dDRqL2JmTThGMXhmRmFrT3NkUklvNUR1cnpaZ29zSFZIZktIdkdU?=
 =?utf-8?B?VXZtZEYrWXFDMGxnam1Hc2t5YkNlM0x6bC92TlpTSUpTOUVZYkpHRmh0Tmhm?=
 =?utf-8?B?TXVPVVN4eEFkbWNvbmt5K3IyOFI2TzUxcXkyVHRzZ1hZamVJb1o3d1dRc3R5?=
 =?utf-8?Q?yz7EkngO7Nk7BO6xS1/5JNN21x6Y+IZ0jUTjhd5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14f7796-1c4b-4d62-0ee5-08d8fa5eb631
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 07:19:56.5345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDxw17QlMy2/ZKIjHFAdwvQlRt2cCJ3YmhjZ9Nl6cs/T3qYkNCxjAQBAl2FlkVPyx9JBrr+KIVQjO9hiMSE8iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5488
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080047
X-Proofpoint-ORIG-GUID: CdlFa8h3MFikXYLcZxTnwkowCeB54Nbw
X-Proofpoint-GUID: CdlFa8h3MFikXYLcZxTnwkowCeB54Nbw
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080048
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/7/21 5:58 PM, Olga Kornievskaia wrote:
> On Wed, Apr 7, 2021 at 6:50 PM <dai.ngo@oracle.com> wrote:
>>
>> On 4/7/21 2:40 PM, Olga Kornievskaia wrote:
>>> On Wed, Apr 7, 2021 at 4:16 PM <dai.ngo@oracle.com> wrote:
>>>> On 4/7/21 12:01 PM, Olga Kornievskaia wrote:
>>>>> On Wed, Apr 7, 2021 at 1:13 PM <dai.ngo@oracle.com> wrote:
>>>>>> On 4/7/21 9:30 AM, Olga Kornievskaia wrote:
>>>>>>> On Tue, Apr 6, 2021 at 9:23 PM <dai.ngo@oracle.com> wrote:
>>>>>>>> On 4/6/21 6:12 PM, dai.ngo@oracle.com wrote:
>>>>>>>>> On 4/6/21 1:43 PM, Olga Kornievskaia wrote:
>>>>>>>>>> On Tue, Apr 6, 2021 at 3:58 PM Chuck Lever III
>>>>>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>>>>>>> On Apr 6, 2021, at 3:57 PM, Olga Kornievskaia
>>>>>>>>>>>> <olga.kornievskaia@gmail.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On Tue, Apr 6, 2021 at 3:43 PM Chuck Lever III
>>>>>>>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>>>>>>>>> On Apr 6, 2021, at 3:41 PM, Olga Kornievskaia
>>>>>>>>>>>>>> <olga.kornievskaia@gmail.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Tue, Apr 6, 2021 at 12:33 PM Chuck Lever III
>>>>>>>>>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>>>>>>>>>>> On Apr 2, 2021, at 7:30 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Currently the source's export is mounted and unmounted on every
>>>>>>>>>>>>>>>> inter-server copy operation. This causes unnecessary overhead
>>>>>>>>>>>>>>>> for each copy.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> This patch series is an enhancement to allow the export to remain
>>>>>>>>>>>>>>>> mounted for a configurable period (default to 15 minutes). If the
>>>>>>>>>>>>>>>> export is not being used for the configured time it will be
>>>>>>>>>>>>>>>> unmounted
>>>>>>>>>>>>>>>> by a delayed task. If it's used again then its expiration time is
>>>>>>>>>>>>>>>> extended for another period.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Since mount and unmount are no longer done on each copy request,
>>>>>>>>>>>>>>>> this overhead is no longer used to decide whether the copy should
>>>>>>>>>>>>>>>> be done with inter-server copy or generic copy. The threshold used
>>>>>>>>>>>>>>>> to determine sync or async copy is now used for this decision.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> -Dai
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> v2: fix compiler warning of missing prototype.
>>>>>>>>>>>>>>> Hi Olga-
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I'm getting ready to shrink-wrap the initial NFSD v5.13 pull
>>>>>>>>>>>>>>> request.
>>>>>>>>>>>>>>> Have you had a chance to review Dai's patches?
>>>>>>>>>>>>>> Hi Chuck,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I apologize I haven't had the chance to review/test it yet. Can I
>>>>>>>>>>>>>> have
>>>>>>>>>>>>>> until tomorrow evening to do so?
>>>>>>>>>>>>> Next couple of days will be fine. Thanks!
>>>>>>>>>>>>>
>>>>>>>>>>>> I also assumed there would be a v2 given that kbot complained about
>>>>>>>>>>>> the NFSD patch.
>>>>>>>>>>> This is the v2 (see Subject: )
>>>>>>>>>> Sigh. Thank you. I somehow missed v2 patches themselves and only saw
>>>>>>>>>> the originals. Again I'll test/review the v2 by the end of the day
>>>>>>>>>> tomorrow!
>>>>>>>>>>
>>>>>>>>>> Actually a question for Dai: have you done performance tests with your
>>>>>>>>>> patches and can show that small copies still perform? Can you please
>>>>>>>>>> post your numbers with the patch series? When we posted the original
>>>>>>>>>> patch set we did provide performance numbers to support the choices we
>>>>>>>>>> made (ie, not hurting performance of small copies).
>>>>>>>>> Currently the source and destination export was mounted with default
>>>>>>>>> rsize of 524288 and the patch uses threshold of (rsize * 2 = 1048576)
>>>>>>>>> to decide whether to do inter-server copy or generic copy.
>>>>>>>>>
>>>>>>>>> I ran performance tests on my test VMs, with and without the patch,
>>>>>>>>> using 4 file sizes 1048576, 1049490, 2048000 and 7341056 bytes. I ran
>>>>>>>>> each test 5 times and took the average. I include the results of 'cp'
>>>>>>>>> for reference:
>>>>>>>>>
>>>>>>>>> size            cp          with patch                  without patch
>>>>>>>>> ----------------------------------------------------------------
>>>>>>>>> 1048576  0.031    0.032 (generic)             0.029 (generic)
>>>>>>>>> 1049490  0.032    0.042 (inter-server)      0.037 (generic)
>>>>>>>>> 2048000  0.051    0.047 (inter-server)      0.053 (generic)
>>>>>>>>> 7341056  0.157    0.074 (inter-server)      0.185 (inter-server)
>>>>>>>>> ----------------------------------------------------------------
>>>>>>>> Sorry, times are in seconds.
>>>>>>> Thank you for the numbers. #2 case is what I'm worried about.
>>>>>> Regarding performance numbers, the patch does better than the original
>>>>>> code in #3 and #4 and worse then original code in #1 and #2. #4 run
>>>>>> shows the benefit of the patch when doing inter-copy. The #2 case can
>>>>>> be mitigated by using a configurable threshold. In general, I think it's
>>>>>> more important to have good performance on large files than small files
>>>>>> when using inter-server copy.  Note that the original code does not
>>>>>> do well with small files either as shown above.
>>>>> I think the current approach tries to be very conservative to achieve
>>>>> the goal of never being worse than the cp. I'm not sure what you mean
>>>>> that current code doesn't do well with small files. For small files it
>>>>> falls back to the generic copy.
>>>> In this table, the only advantage the current code has over 'cp' is
>>>> run 1 which I don't know why. The rest is slower than 'cp'. I don't
>>>> have the size of the copy where the inter-copy in the current code
>>>> starts showing better performance yet, but even at ~7MB it is still
>>>> slower than 'cp'. So for any size that is smaller than 7MB+, the
>>>> inter-server copy will be slower than 'cp'. Compare that with the
>>>> patch, the benefit of inter-server copy starts at ~2MB.
>>> I went back to Jorge Mora's perf numbers we posted. You are right, we
>>> did report perf degradation for any copies smaller than 16MB for when
>>> we didn't cap the copy size to be at least 14*rsize (I think the
>>> assumption was that rsize=1M and making it 14M). I'm just uneasy to
>>> open it to even smaller sizes. I think we should explicitly change it
>>> to 16MB instead of removing the restriction. Again I think the policy
>>> we want it to do no worse than cp.
>> I can make this a module's configurable parameter and default it to 16MB.
>> However, why 16MB while the measurement I did shows inter-copy starts
>> performing better than 'cp' at ~2MB? Your previous measurement might no
>> longer valid for the latest code with the patch. Can you verify the patch
>> performs than cp even with 2048000 bytes copy?
> 16MB came from hardware measurements which are a lot more realistic
> than VM measurements. Can you please get hardware measurements? I
> haven't gotten around to the hardware testing. Because I think the
> solution needs to be changed (ie the whole mount needs to be saved and
> not just part of the mount). Once we have that solution, we can
> measure performance and see what numbers make sense for the client
> side. Having it as a module configuration parameter is fine with me.
> Updating it to a new set of hardware based numbers is ok with me too.

I'm also ok with a module configuration parameter. I don't have the
hardware for testing, I will use the default value of 16MB for now.
Since it's configurable anyone can adjust to the desire value. I will
send a new patch for this.

>
>>>>>>> I don't believe the code works. In my 1st test doing "nfstest_ssc
>>>>>>> --runtest inter01" and then doing it again. What I see from inspecting
>>>>>>> the traces is that indeed unmount doesn't happen but for the 2nd copy
>>>>>>> the mount happens again.
>>>>>>>
>>>>>>> I'm attaching the trace. my servers are .114 (dest), .110 (src). my
>>>>>>> client .68. The first run of "inter01" places a copy in frame 364.
>>>>>>> frame 367 has the beginning of the "mount" between .114 and .110. then
>>>>>>> read happens. then a copy offload callback happens. No unmount happens
>>>>>>> as expected. inter01 continues with its verification and clean up. By
>>>>>>> frame 768 the test is done. I'm waiting a bit. So there is a heatbeat
>>>>>>> between the .114 and .110 in frame 769. Then the next run of the
>>>>>>> "inter01", COPY is placed in frame 1110. The next thing that happens
>>>>>>> are PUTROOTFH+bunch of GETATTRs that are part of the mount. So what is
>>>>>>> the saving here? a single EXCHANGE_ID? Either the code doesn't work or
>>>>>>> however it works provides no savings.
>>>>>> The saving are EXCHANGE_ID, CREATE_SESSION, RECLAIM COMPLETE,
>>>>>> DESTROY_SESSION and DESTROY_CLIENTID for *every* inter-copy request.
>>>>>> The saving is reflected in the number of #4 test run above.
>>>>> Can't we do better than that? Since you are keeping a list of umounts,
>>>>> can't they be searched before doing the vfs_mount() and instead get
>>>>> the mount structure from the list (and not call the vfs_mount at all)
>>>>> and remove it from the umount list (wouldn't that save all the calls)?
>>>> I thought about this. My problem here is that we don't have much to key
>>>> on to search the list. The only thing in the COPY argument can be used
>>>> for this purpose is the list of IP addresses of the source server.
>>>> I think that is not enough, there can be multiple exports from the
>>>> same server, how do we find the right one? it can get complicated.
>>>> I'm happy to consider any suggestion you have for this.
>>> I believe an IP address is exactly what's needed for keying. Each of
>>> those "mounts" to the same server is shared (that's normal behaviour
>>> for the client) -- meaning there is just   1 "mount" for a given IP
>>> (there is a single nfs4_client structure).
>> ok, I can give this a try. However, I think this only reduces the
>> number of RPCs which are bunch of GETATTRs so I don't think this will
>> help the performance number significantly.
> They are RPCs and meta data operations that go into the file system.I
> would think they affect performance...
>
>>>> I think the patch is an improvement, in performance for copying large
>>>> files (if you consider 2MB file is large) and for removing the bug
>>>> of computing overhead in __nfs4_copy_file_range. Note that we can
>>>> always improve it and not necessary doing it all at once.
>>> I don't think saving 3 RPCs out of 14 is a good enough improvement
>>> when it can be made to save them all (unless you can convince me that
>>> we can't save all 14).
>> I don't understand your numbers here. Without the patch, there are
>> 14 RPCs for mount and 2 RPCs for unmount and overhead of creating
>> and tearing down TCP connection each time. With the patch, there are
>> 8 RPCs for the mount (PUTROOTFH and GETATTRs) and 0 for unmount and
>> no create and tear down TCP connection. The RPCs that the patch save
>> are mostly heavy-weight RPC requests as the test showed the patch
>> outperforms the current code even at 2MB.
> I counted mount operations savings. I agreed with you that we saved
> the umount. I'm saying that given that you are keeping track of the
> mounts structures, those 8 RPCs shouldn't happen.
>
> I think my approach didn't keep track of the mount and just delayed
> the execution of the cleanup function so it was not possible to "save
> the mount rpcs". You code takes it further but not far enough.

ok, let hold off on this patch and I will look into the IP address
approach and also see if we can completely remove all RPCs related to
mount.

>
> As for the savings as I said I'd like to see the performance numbers
> based on the hardware setup not VMs. And yes the existing hardware
> numbers are based on the old code and need to be re-run on the
> existing code. I will try to do that tomorrow.

yes, it's useful data point.

>
> I think at this point you need to have one of the maintainers weigh in
> on whether or not this intermediate step of saying a few rpcs is worth
> checking in and then get the saving of the whole mount. It's really up
> to them. In my opinion, I think if we are trying to save mount
> operations, we should do it all the way.
>
> Furthermore, I still really would like Bruce or Chuck to weigh in on
> the use of the semaphore. We are holding onto a semaphore while doing
> vfs_kern_mount(), I thought it's frowned upon to hold any locks while
> doing network operations. What if vfs_kern_mount() is trying to reach
> an unresponsive server, then all other unmount are blocked, right? I
> still don't understand why we need a semaphore. I think a spin lock
> that protects access to the list of umounts is sufficient. I probably
> should be commenting on the actual patch here.

Let hold off on this until I submit a new patch.

Thanks,
-Dai

>
>
>> -Dai
>>
>>>> -Dai
>>>>
>>>>>> Note that the overhead of the copy in the current code includes mount
>>>>>> *and* unmount. However the threshold computed in __nfs4_copy_file_range
>>>>>> includes only the guesstimated mount overhead and not the unmount
>>>>>> overhead so it not correct.
>>>>>>
>>>>>> -Dai
>>>>>>
>>>>>>
>>>>>>> Honestly I don't understand the whole need of a semaphore and all.
>>>>>> The semaphore is to prevent the export to be unmounted while it's
>>>>>> being used.
>>>>>>
>>>>>> -Dai
>>>>>>
>>>>>>> My
>>>>>>> approach that I tried before was to create a delayed work item but I
>>>>>>> don't recall why I dropped it.
>>>>>>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-nfs/patch/20170711164416.1982-43-kolga@netapp.com/__;!!GqivPVa7Brio!Jl5Wq7nrFUsaUQjgLJoSuV-cDlvbPaav3x8nXQcRhAdxjVEoWvK24sNgoE82Zg$
>>>>>>>
>>>>>>>
>>>>>>>> -Dai
>>>>>>>>
>>>>>>>>> Note that without the patch, the threshold to do inter-server
>>>>>>>>> copy is (524288 * 14 = 7340032) bytes. With the patch, the threshold
>>>>>>>>> to do inter-server is (524288 * 2 = 1048576) bytes, same as
>>>>>>>>> threshold to decide to sync/async for intra-copy.
>>>>>>>>>
>>>>>>>>>> While I agree that delaying the unmount on the server is beneficial
>>>>>>>>>> I'm not so sure that dropping the client restriction is wise because
>>>>>>>>>> the small (singular) copy would suffer the setup cost of the initial
>>>>>>>>>> mount.
>>>>>>>>> Right, but only the 1st copy. The export remains to be mounted for
>>>>>>>>> 15 mins so subsequent small copies do not incur the mount and unmount
>>>>>>>>> overhead.
>>>>>>>>>
>>>>>>>>> I think ideally we want the server to do inter-copy only if it's faster
>>>>>>>>> than the generic copy. We can probably come up with a number after some
>>>>>>>>> testing and that number can not be based on the rsize as it is now since
>>>>>>>>> the rsize can be changed by mount option. This can be a fixed number,
>>>>>>>>> 1M/2M/etc, and it should be configurable. What do you think? I'm open
>>>>>>>>> to any other options.
>>>>>>>>>
>>>>>>>>>>       Just my initial thoughts...
>>>>>>>>> Thanks,
>>>>>>>>> -Dai
>>>>>>>>>
>>>>>>>>>>> --
>>>>>>>>>>> Chuck Lever
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
