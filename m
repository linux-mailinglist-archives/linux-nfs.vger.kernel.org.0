Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F63221E9
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 23:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhBVWCf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 17:02:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51658 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBVWCa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Feb 2021 17:02:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MM0PIb013099;
        Mon, 22 Feb 2021 22:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Xr870CfmufUNDQangX50hcGrkgsHn6JKvOap+kmQuzI=;
 b=M2eINJt7/pEM3S0tHUbeT6tOPnKunO6tPvm1wU6bwBXWOmcywlHCjYkTKGJmtlXhfry4
 VZ2cbhwReWEqZuuJ89SfTvghcyhScZ49OIKzLUuvWp98bacEZU9vfwC3g3NZHfEjs9Am
 AAL7cnJe134Yk+qxl1XrWiva4XPP8yL4MaJX7cUGa1mQz4UMAK+tN/0XRrxyMKmlTujA
 dsIcpOdWczZw+BD47j5tVOmT3cQVfKQ4WfAukOdImUxF3m9BvPnSmYLXYbHOG7DUqyBN
 E4RUd09y8Jg/G4+LsA4Pyc+lFDHDHkSxb0SWZmfsTJZrz1h07SvzliGeWzn07GHsMsuF tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36ugq3c5ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 22:01:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MM0ain174213;
        Mon, 22 Feb 2021 22:01:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3020.oracle.com with ESMTP id 36ucaxkd6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 22:01:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEYKRomg52Bq9pkjz0NoUPeEsOq51F79TfW5zHf4RhxynOtho0jeN7KrfKvOKL2qzHvvhFgAd0uafq65tt3CdTX9TZ7H4aXrK2tjlDZyiQmjvO2wZaT05IJvj1o2RQeZkiGA/34kICd20DZ82JRZYfxxo7WRMeRSrdDNZcZEtorkX81bEmmHxe45rnxHbcRKWzAUYvgkAp23hhdNmYI9Yljkstoqe/Eo5Z9im0HxVaMhiO2D6hkLe0zbfG/Gzrf8DqsNvG6o5b2tCpjIiiI1nQ16AZZ2k9mYNL+69vM0ShaOYI6A6431LQexVpxkaOEbVtBn4iVyc74sVz1FctJX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xr870CfmufUNDQangX50hcGrkgsHn6JKvOap+kmQuzI=;
 b=QKFic+HiUrlHn1TCuifX7jPAzqQzc9tZsFD0qU0ELUFT8dxIVOWJOIuibV4muhQPQ/M3Qfb7yknGt3nAQKfErBX/Cy3cjq1h7wivgrSQN2YIqLvnRClTOXYQW+UoN4l3vla6RTppB1WkZlSwKZBqnnRl1OXWJkpF8wQQg/ZjBu+pEfGDwsIsQn25ddDgWxPiKMoCWqDIxh4F2rYKYhfTQk1HxVkPq4fP88xz/btF3B4agFflqgZRB8YO4zjYkHVipsaSODelTJzxNtaRIv8OgX18xy110+z9CzMoX1WVdUjBbY6ylrV5di1sBuGG6bVr4DL5KBu+TFTyY0/VaYRdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xr870CfmufUNDQangX50hcGrkgsHn6JKvOap+kmQuzI=;
 b=I3X8hvP3dFF65TFMOrnagl/p6WVOrn1vZ4rNlKP+mlslTKufMrhNj0/WfY8xCT4p1f9RXhxx/LXUcd2TnGFFeL+Xbk4yB+RYhQpemVDoDeuuFAlJzcDJYaIMEk8CLUpBGI0PbA0wx/rFseAbnFfrT3AHOJVXkh6azsj4Hmrf+qY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4591.namprd10.prod.outlook.com (2603:10b6:a03:2af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Mon, 22 Feb
 2021 22:01:37 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8%6]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 22:01:37 +0000
Subject: Re: [PATCH 1/2] NFSD: Fix use-after-free warning when doing
 inter-server copy
From:   dai.ngo@oracle.com
To:     Olga Kornievskaia <aglo@umich.edu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <20201029190716.70481-1-dai.ngo@oracle.com>
 <20201029190716.70481-2-dai.ngo@oracle.com>
 <CAN-5tyFnTSuMivnBPD9Aur+KDxX8fCOuSaF7qGKe6bFB7roK6Q@mail.gmail.com>
 <20210220010903.GE5357@fieldses.org>
 <69ea46ff-80d1-acfa-22a5-3d1b6230728f@oracle.com>
 <20210220032057.GA25183@fieldses.org>
 <CAN-5tyHq2NcQRbx01cSyJob=72MDUnwjK_t6GiDjTc3twbnvwA@mail.gmail.com>
 <ef11a2f9-f84b-7efc-ba5b-ca36c33d1825@oracle.com>
 <52e26138-0d3d-bd3c-6110-5a41e1fdf526@oracle.com>
 <517d8f58-4a00-8fe1-ad5a-b19ed50a8fe3@oracle.com>
Message-ID: <ff068f05-c9cd-9772-4be7-74ae28a268d7@oracle.com>
Date:   Mon, 22 Feb 2021 14:01:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <517d8f58-4a00-8fe1-ad5a-b19ed50a8fe3@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR05CA0208.namprd05.prod.outlook.com
 (2603:10b6:a03:330::33) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-137-111.vpn.oracle.com (72.219.112.78) by SJ0PR05CA0208.namprd05.prod.outlook.com (2603:10b6:a03:330::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.13 via Frontend Transport; Mon, 22 Feb 2021 22:01:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bc2064c-bef2-4a41-0c0c-08d8d77d6ccc
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4591:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4591197DFD2A1800D43BFCE987819@SJ0PR10MB4591.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4B4ya/3+1D/wuOkY1c6nnQeODbbQMrYwSqWvF85sJkfQxfFY7E1jU2r+B6jmIZ9cEDcn35GyQEoakZloTdi/09R8k2TRabJ35CTaORQ8Ux/293ghLywOpN+CH4AuRo/DyqGWHNujG2u0v0UxN1Aksc/NpINwTenFEqhgLtc7+UKpV8ll/6jiImq03vRoyBejy2xFRom+S14CW+hh8yN31O0aXAaNz59Rp84tl/3ej5GJLdRWmQ6UdJhvYPAWVu+2HZPMDCB3/jds/Q32Wn5/+2YazfBUfw3s0tREHu6LJkjGILnButVeR7uQnm/LKG5ekqC9P2P0MRLwRGtEtP8X722kPeQdAO3+qJ6XkdtL89cWjIljMKjDgvAQ5xGhfwfOm+h4gTxlgv/HLjW9D3JUdVc7NlOpMZerpxU3H9RwtI1YGyXfxdnmIM86QZc460tgeNCEimcxRHpdPplivj89fR5tatB+F7WYG8m16iZhyb3hX6KJpvXWltsH7uRDzG8cAp9edIqlW3HeeRET0C2R2yxXr/D3+Y6SreZFZINFrgdDFHxQouLxPHmDpgSMrLSFm8p96QyM/XLfb3Iwk5nMTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(346002)(376002)(39860400002)(86362001)(956004)(66476007)(83380400001)(2616005)(186003)(31686004)(4326008)(9686003)(8676002)(7696005)(53546011)(5660300002)(2906002)(36756003)(8936002)(6486002)(31696002)(316002)(26005)(110136005)(66946007)(66556008)(16526019)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y3BvV1NSM2lEbnB4NFBIaGNlbTdiRStrVklVL1k0OE9WNSsrb25MZmRCaFZ3?=
 =?utf-8?B?TjhmejNWSVVzZitLUVZyUXVLV0dKMjVCS1NOWHBrZkFtdHhrM3EzdTFqQmxK?=
 =?utf-8?B?dHMvSkY4QXZUc1dyMUpNNzRTYzJJejNJdkxrMFFYZC9hMHMvVmZhWkRBNjFX?=
 =?utf-8?B?Tlo5NzdPZGdRaDVjcnE0WnhPemlZT1Z6czh5WWtiM3hxcmpGT09TV2JFSFda?=
 =?utf-8?B?U3NFVHdzb3NKMVBJRlNvTEVzaUdTVzFmQWVaSGZ2ckZRSWo3YnF3NU41R3Nz?=
 =?utf-8?B?VEovajJjK3JockRqWExWR1RjNHdVWHhjcDk2dmFGNzA2SWdGTXB5NXUyeUhS?=
 =?utf-8?B?R2JJRUt1MlRuZ2hVT3N0NFpheGgrY1grcXJVaFAyaXFHZFlHa2dHUytPeDFk?=
 =?utf-8?B?emViWWZjUFBpdWhram1wSitaVjludW11OUozdU5pZjZMdlM3RzR0TWQ0SkRz?=
 =?utf-8?B?QmVRV1k1S0hvODlJZ1dVaWMzUnY5V1FzTGJwOWVpR09MT01vUXBZTXpQaXR2?=
 =?utf-8?B?QzlKSnlnZDI2Y09vNittaGlNMFJ2SG1tZFlsQVMvZ3gwZWdRa0V2YkRBeFhT?=
 =?utf-8?B?UkNuU05Vd25PcHNlOGdlL3FhenNaa1lFS3BkZjVJdWxleDF5SGdUQkR1Z1Zi?=
 =?utf-8?B?STc3UW1Bc0Q4ZnVtYjNiS0VqcVA5Zmh5bnZtczBpYWFaR3lyWkNRY3lValBR?=
 =?utf-8?B?Zy9jZUIvMyt1ZUkyQ2tIcVd3RzZHQXRDNE91SXdTTUx6ZmR2aDkrVStvcHNq?=
 =?utf-8?B?NkdIdVJmekdjNXdhTUllNkZFUHpiUFUwV292RklROEtnUzE4andaWVpwWCtv?=
 =?utf-8?B?OE5ENUdla2lsSFdMTXJlRWVOUGFuVHlEOXo1cXJGNEVTRmdwR0Uwcmg2eG9l?=
 =?utf-8?B?N3M0LzJ5N2o5WlpvMXdOeTN6d0RvSnNQNm5qbnZiZ1J6N1JEc2dqM2FScjZH?=
 =?utf-8?B?bXJJci9SVVRoNFZNZlpTdkh2ZDFxWmY5d2puTHZ4bE9lOFRjN0NsR0d5N3lM?=
 =?utf-8?B?b1Qyd25uSnp0TU1iUkxFTGgxWWRMVE5hbVR2blZtWVZkMGY5dWpjSE5NaXQ5?=
 =?utf-8?B?OVBsT1BsNXdCMVBSN0JkeUFaRlljandsSEV5dkRMM2Y3UG84YkhRSnRMaVlp?=
 =?utf-8?B?K1l0dml2ZldKdHBXYlVjV2RQWGhnSGtFYlExckFOaG5IMHhLNFZ5VC95NjJM?=
 =?utf-8?B?eWFXYW1raTRCV1R0TlMrNkNaQkFIV093WDJoL0tpejg3NHFWNDAxVjZnSXJ5?=
 =?utf-8?B?bzhndmt3TlkxemhFNWUzbkdwdDQ3a0J3U1lIZ054bHZUSnRmRUMzN2RDcC9v?=
 =?utf-8?B?QVBxVGV3YVdpQVJ2d3FRYSs2VWZ5bzhpMStHRk8za2ZQWmFaS2hoWFJET0ZM?=
 =?utf-8?B?clVRYitlZnFXU09JaTJuTWpCWVRTZFpSV3pVRm1rNWN5N0hYcjVkbDh4WUNV?=
 =?utf-8?B?aGZlSzc2N054aTl5d2pUTU5NM3NjcHJWUllrYVd5VThycWtRS0Q0Q0JMLzdY?=
 =?utf-8?B?Y0NMdzgvNCtSaWJnZ1lFSjB5c1NmM1J4RVVxYnZXNDdVVWFRUTJSQlIyVXN4?=
 =?utf-8?B?NSsxSEV0aXVFV09odUIxNUFER1d5U1lrOVZlRUlLL1MyNE1aNWpYRG5sTkRs?=
 =?utf-8?B?THJKR05CUjBrWk4wekhjb2hzS05JRHowZ2FnalFtczZ6dTJ1T3VSMHRiVWdF?=
 =?utf-8?B?dmxHSnU3WlVySUE4VHpPR2NNbkZtNlEwaWFCd0FHQjZSK2tBOFROc3F0eU83?=
 =?utf-8?Q?qPGizL5bs4JjRGOhksYPT5z+HhNIPZYZ7Dh9RwT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc2064c-bef2-4a41-0c0c-08d8d77d6ccc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 22:01:37.0504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSVErbFKM2sZq5Fy5Oo9Ia6kqgvDWAIyKZij/6XzuOcynYSC5eDNW80Tk2s23L7YG9GQDvUX6QrVaVKzHZ7X8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4591
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220190
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220190
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/22/21 1:46 PM, dai.ngo@oracle.com wrote:
>
> On 2/22/21 10:34 AM, dai.ngo@oracle.com wrote:
>>
>> On 2/20/21 8:16 PM, dai.ngo@oracle.com wrote:
>>> On 2/20/21 6:08 AM, Olga Kornievskaia wrote:
>>>> On Fri, Feb 19, 2021 at 10:21 PM J. Bruce Fields 
>>>> <bfields@fieldses.org> wrote:
>>>>> On Fri, Feb 19, 2021 at 05:31:58PM -0800, dai.ngo@oracle.com wrote:
>>>>>> If this is the cause why we don't drop the mount after the copy
>>>>>> then I can restore the patch and look into this problem. 
>>>>>> Unfortunately,
>>>>>> all my test machines are down for maintenance until Sunday/Monday.
>>>>> I think we can take some time to figure out what's actually going on
>>>>> here before reverting anything.
>>>> Yes I agree. We need to fix the use-after-free and also make sure that
>>>> reference will go away. 
>>
>> I reverted the patch, verified the warning message is back:
>>
>> Feb 22 10:07:45 nfsvmf24 kernel: ------------[ cut here ]------------
>> Feb 22 10:07:45 nfsvmf24 kernel: refcount_t: underflow; use-after-free.
>>
>> then did a inter-server copy and waited for more than 20 mins and
>> the destination server still maintains the session with the source
>> server.  It must be some other references that prevent the mount
>> to go away.
>
> This change fixed the unmount after inter-server copy problem:
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 8d6d2678abad..87687cd18938 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1304,7 +1304,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, 
> struct nfsd_file *src,
>                         struct nfsd_file *dst)
>  {
>         nfs42_ssc_close(src->nf_file);
> -       /* 'src' is freed by nfsd4_do_async_copy */
> +       nfsd_file_put(src);
>         nfsd_file_put(dst);
>         mntput(ss_mnt);
>  }
> @@ -1472,14 +1472,12 @@ static int nfsd4_do_async_copy(void *data)
>                 copy->nf_src = kzalloc(sizeof(struct nfsd_file), 
> GFP_KERNEL);
>                 if (!copy->nf_src) {
>                         copy->nfserr = nfserr_serverfault;
> - nfsd4_interssc_disconnect(copy->ss_mnt);
>                         goto do_callback;
>                 }
>                 copy->nf_src->nf_file = nfs42_ssc_open(copy->ss_mnt, 
> &copy->c_fh,
> &copy->stateid);
>                 if (IS_ERR(copy->nf_src->nf_file)) {
>                         copy->nfserr = nfserr_offload_denied;
> - nfsd4_interssc_disconnect(copy->ss_mnt);
>                         goto do_callback;
>                 }
>         }
> @@ -1498,6 +1496,7 @@ static int nfsd4_do_async_copy(void *data)
>                         &nfsd4_cb_offload_ops, NFSPROC4_CLNT_CB_OFFLOAD);
>         nfsd4_run_cb(&cb_copy->cp_cb);
>  out:
> +       nfsd4_interssc_disconnect(copy->ss_mnt);
>         if (!copy->cp_intra)
>                 kfree(copy->nf_src);
>         cleanup_async_copy(copy);
>
> But there is something new. I tried inter-server copy twice.
> First time I can verify from tshark capture that a session was
> created and destroy, along with all the NFS ops. On 2nd try,
> I can 

cannot

> see any NFS ops from the tshark capture because all data
> are encrypted by TLS/SSLv2. This behavior seems to repeat.
> I will look into it but I think this is a separate issue.
>
> -Dai
>
>>
>> -Dai
>>
>>>> I'm assuming to reproduce the use-after-free I
>>>> need to run with kazan, is that what you did Dai?
>>>
>>> I did not use Kasan. I just did an inter-server copy and this message
>>> showed up in /var/log/messages.
>>>
>>> -Dai
>>>
>>>>
>>>>> --b.
>>>>>
>>>>>> -Dai
>>>>>>
>>>>>> On 2/19/21 5:09 PM, J. Bruce Fields wrote:
>>>>>>> Dai, do you have a copy of the original use-after-free warning?
>>>>>>>
>>>>>>> --b.
>>>>>>>
>>>>>>> On Fri, Feb 19, 2021 at 07:18:53PM -0500, Olga Kornievskaia wrote:
>>>>>>>> Hi Dai (Bruce),
>>>>>>>>
>>>>>>>> This patch is what broke the mount that's now left behind 
>>>>>>>> between the
>>>>>>>> source server and the destination server. We are no longer 
>>>>>>>> dropping
>>>>>>>> the necessary reference on the mount to go away. I haven't been 
>>>>>>>> paying
>>>>>>>> as much attention as I should have been to the changes. The 
>>>>>>>> original
>>>>>>>> code called fput(src) so a simple refcount of the file. Then 
>>>>>>>> things
>>>>>>>> got complicated and moved to nfsd_file_put(). So I don't 
>>>>>>>> understand
>>>>>>>> complexity. But we need to do some kind of put to decrement the 
>>>>>>>> needed
>>>>>>>> reference on the superblock. Bruce any ideas? Can we go back to
>>>>>>>> fput()?
>>>>>>>>
>>>>>>>> On Thu, Oct 29, 2020 at 3:08 PM Dai Ngo <dai.ngo@oracle.com> 
>>>>>>>> wrote:
>>>>>>>>> The source file nfsd_file is not constructed the same as other
>>>>>>>>> nfsd_file's via nfsd_file_alloc. nfsd_file_put should not be
>>>>>>>>> called to free the object; nfsd_file_put is not the inverse of
>>>>>>>>> kzalloc, instead kfree is called by nfsd4_do_async_copy when 
>>>>>>>>> done.
>>>>>>>>>
>>>>>>>>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>>> ---
>>>>>>>>>   fs/nfsd/nfs4proc.c | 2 +-
>>>>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>>> index ad2fa1a8e7ad..9c43cad7e408 100644
>>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>>> @@ -1299,7 +1299,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount 
>>>>>>>>> *ss_mnt, struct nfsd_file *src,
>>>>>>>>>                          struct nfsd_file *dst)
>>>>>>>>>   {
>>>>>>>>>          nfs42_ssc_close(src->nf_file);
>>>>>>>>> -       nfsd_file_put(src);
>>>>>>>>> +       /* 'src' is freed by nfsd4_do_async_copy */
>>>>>>>>>          nfsd_file_put(dst);
>>>>>>>>>          mntput(ss_mnt);
>>>>>>>>>   }
>>>>>>>>> -- 
>>>>>>>>> 2.20.1.1226.g1595ea5.dirty
>>>>>>>>>
