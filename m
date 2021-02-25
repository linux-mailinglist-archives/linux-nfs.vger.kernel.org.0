Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C103255FB
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Feb 2021 20:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhBYS77 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Feb 2021 13:59:59 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56894 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhBYS7Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Feb 2021 13:59:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PIu3ka191431;
        Thu, 25 Feb 2021 18:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MuPbRhshBrG4s6scCBiMHZHPuCiTm0jlsX12oRHdRkg=;
 b=x8W+EbtyAMo88tlvsuOrbcbW97mgyOhlU71sO0UjM1tlh/8Z0xKLb2fzRCp+LjGY1Yit
 6Tix3R/Jh52P+CSvawJiILM2XuXMqqB7d6O2OAhadxko322mz4XCa/qvL3nhTfivsJXU
 ZE6Fw7peYH2vYkp+kqfGphwn3XsI2MGvpjlRwvYJD8kdKQ5/7arpp8ax/qSdK2grFd3L
 6+iuueSINoEu1hqJU55LB1FPRv9k5XmYArxxNt1gZfOUjGHZRtcuWfZUIWHh0gcmxkx/
 lBGXZMK7YIEIoKnS/Vz6UBqqaVWd3UxzKBCwqi3uKM2V9i8jHefe6CSZcSuhwA5xk1Qp Dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36ttcmfhmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 18:58:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PIucvS159509;
        Thu, 25 Feb 2021 18:58:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3030.oracle.com with ESMTP id 36ucc1kw4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 18:58:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PStfhlwLxuiATl5WKG2/XOchvfhdC4uAwP3AeuMKFL2QyznW8g7ETvCDM0PT9CKRAMAP7GxAscKFvPIyZ0nuWsRzg9WonsTy9KEJxneIDx+DFsqYecuCP1mzD2ldguJE6iYBZm1ln2RZ3IS1DQmd5dBbCb3/VlkxWSDkRh3eM6xaBm3AAxX4IYt5QoBBpOdMyT54PTSn3H4UyRbzGmIfLQTsPGTnLKunSoCjTAypSIGlOBIKtzdZkQl10MYAPUFOYxf6RrT3yF+CKQRKRTGdeTRwLvIsSmm1MOShKik6lhrR+IzU+aVmMLMl5qdvVoq8z2eOBUzu8jH/erRCMZ2ZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuPbRhshBrG4s6scCBiMHZHPuCiTm0jlsX12oRHdRkg=;
 b=kzKeb3crZ4xiJzrleWgRUQmcHfIJ8FqiYhPtKaRHhFQBDnnQusbLv2z2sZFzUDuCQv18I2KJCm/PbJSgFHzTwZDxDEu8y0L3BNIIhIqPEF74072S9VreKyes1epgEYMurIlopsGf9iZqmkp6so9GN9OJfKtgLQCizm+iu7YTWVcFrbFHt3ZfdzpEGaZZlvsGnE45kIjAQMb1AMgyEtSwxTwWl3WptZDZeohzJJA/61pwujOGPsfyMGial1UOWvX9NYoAJUdLJgJZbULvTdt7dj7dzXj7vo3NlA21ba17l6QKpzCj8sHpRIoQDbinfcX1/LuPtNTMw9QdQSwHk23HDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuPbRhshBrG4s6scCBiMHZHPuCiTm0jlsX12oRHdRkg=;
 b=h3J7AQJNKnbP0lyMFah+Ivlxvup5kMgm3ycP1oCUs1ArCSBMkS2R6VDnq7BGBKPySAaWhxhtYUMj9Ib6SrkmiYq+hPFYFpvSmuy7+sE05YO/dxLIdzU4FFcr0y6dnR8fjS3tC9vdahDPHgL69Ksu6zg5WnPIXpO6Fo9eKDiv088=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3415.namprd10.prod.outlook.com (2603:10b6:a03:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 25 Feb
 2021 18:58:32 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8%6]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 18:58:32 +0000
Subject: Re: [PATCH 1/2] NFSD: Fix use-after-free warning when doing
 inter-server copy
From:   dai.ngo@oracle.com
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
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
 <ff068f05-c9cd-9772-4be7-74ae28a268d7@oracle.com>
 <a5cc3d04-06bc-6f3b-3ac2-c96a8efb1194@oracle.com>
 <CAN-5tyEXPxb7SZv_qmCECPUSdUgWSrPigrWxTORC0ZrMAj08Fg@mail.gmail.com>
 <7771b9f4-3689-cdca-5dd3-ef77e239ceb6@oracle.com>
Message-ID: <1d52c88d-0c30-b9a1-9724-596bf7de314c@oracle.com>
Date:   Thu, 25 Feb 2021 10:58:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <7771b9f4-3689-cdca-5dd3-ef77e239ceb6@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR05CA0157.namprd05.prod.outlook.com
 (2603:10b6:a03:339::12) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-144-147.vpn.oracle.com (72.219.112.78) by SJ0PR05CA0157.namprd05.prod.outlook.com (2603:10b6:a03:339::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.10 via Frontend Transport; Thu, 25 Feb 2021 18:58:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3d6b134-2d48-4b2e-5412-08d8d9bf58cc
X-MS-TrafficTypeDiagnostic: BYAPR10MB3415:
X-Microsoft-Antispam-PRVS: <BYAPR10MB341570EA2CFCC133A383CDDC879E9@BYAPR10MB3415.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6/t7SjTyBuz9IcJjiJkW/9c8tf3KiqvgqqvunICTOh8JhhKiZ94NdJ+iqeHaeHWiQZMNPDJ4i1pLx75cMwsZDi81XWtvbpyALWoXOm5gEbZoR4cmo8xUA8OeWe1m7ueWMc0bzN+l+iV17VaLy2W2Gvr0OYZHm6/0vFj9NgdHuRCmXEcbgfLtFnKeRGZAxC7EfY6H83FC0Xtbh3CCYqggnRN1JHNcoVIBaESKEF6HoSFR+ZPwlYF7oRWFYKS8vAC9rB0fj+cFJ9ENzokb6cm2802UCMHnv9Va/H9g45jD/MOVsPBsbiAeng0HJvzq08ChMA6irY0nbFcWQYtRoNseIQeWhrQ0mVWzUIUHgFAmilBemBsxVSH/wxzKZOIm815EdIisCi2MFgbyGSKfJ1AkvuljeRrlQ8VXyHv6/vGuhaaC52Z7CsPYqcqH69wHQdLrUaRsLf2qjk70alU+0DdyACcIcbm9Vz3dk6JneWrUZnrF4n7NmvL+6GIlcBWVEFpJFvB5E6rM5w9dIjfcjpDlv3S8bAxUiC80M8zPCSN/4s7+FF8/xoXi5NIhwvJljSkW1uUdRS/puOLU8AE0L5bvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(366004)(39860400002)(136003)(6916009)(83380400001)(8676002)(53546011)(8936002)(316002)(26005)(2616005)(186003)(16526019)(4326008)(66946007)(86362001)(9686003)(478600001)(31696002)(2906002)(956004)(54906003)(6486002)(31686004)(7696005)(66556008)(5660300002)(66476007)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RWJ5bXAya1ByV0tZai9OQmpLdzk3UFVkZlVCMkpzajExdlZoN0Nwb2VmODlP?=
 =?utf-8?B?dWpMcytQVU9PWFAzRnRJSjRDR0UwTy9jOGZoTWpJVnkvd3pWWUttVnlXODgw?=
 =?utf-8?B?cktrWmU3TDBUa2VNdmdKSXVEM1Z3VVdUTzNuOCt4dXZyY0U5VEtXN3pkNzg1?=
 =?utf-8?B?Ykd5ZUw1RWZRV0xSQ1d4WVFtbTBVVFVsbHNwdzJMSGNFaFBhRUFSVkNvTlpa?=
 =?utf-8?B?TGZCQjNBejBTbTRHK1N3Qk5YSnRPZVd6S1BrVnhBc3dHWVAyVjh2dXlDZlZP?=
 =?utf-8?B?b20zZGZUVG1OOVRjVDN6UU5LZTBmMmlIU2xsSEtpcnFKWXZWdjJDWWFSdjFa?=
 =?utf-8?B?T2lwRGIrQ3dvNzh3TC81N1c1OXh2QUUxZFU4TkdwUCtpOFVDM0JBWWcwemJO?=
 =?utf-8?B?OFI5a3ZxME1BSE9mZVJqWm1uQ2dMbmRWeUlFbDMrOUtoYXVuWmFEQjNGOEZV?=
 =?utf-8?B?T3AwU0MvS1JJTjd4cTdTSXlkSFlLQ002QTQ4c21JS3plVFpFQnNEZ0t5VzRv?=
 =?utf-8?B?OHRSMDNNWkNFblJvZ2dGUi9SUTZhRngzWTM4UW5pM21DdTFNcS9Semx1MTFB?=
 =?utf-8?B?NHl4VVBtVUozRjdsL3ZBT3JPa2Z3Z2xxa2NQeVpBaUtXbFZOdkRneUxsV3Yr?=
 =?utf-8?B?UWgvT2htZDlQb3dDOWVObmNjbmdHdGdmbGZ2RXZndjBpY3lTRmRlTWllT01s?=
 =?utf-8?B?a3c4eldJTlR3djg4RW0yNStITUJPN2g0ampnYWNPZXhyNTZaYkRYcElnVEZh?=
 =?utf-8?B?c2hGY0doT0sxd3R6RFZHVXZ5cnVULzVSdHdpaTJCcWFPcjZibTJ0b0IyY3py?=
 =?utf-8?B?M0dpUDUzRmRJRnhVUmZNak5KU2diS210YjVHcWZwY1g3Mit2MlhrODdYcjdF?=
 =?utf-8?B?bWlxNnhDQ2VudWd1ZVlINHZxeXlIbGFIa25aNk1laDhWSWRZcE5CRlkyWXhX?=
 =?utf-8?B?RGFvWFNGZ29MclE3K0docDZ2V1E5WTl3Rll6TnJtdGJSNURBWkNJYnVXdzVI?=
 =?utf-8?B?RGVFblJFWUk1YTEvT0EwTDdjL25kbmY5YVhzOVIrWERMYXBuNFlpV3hpdG5x?=
 =?utf-8?B?RjE5OXNsTTd4bXo3eDAwWWFzTktadVpSc2kvSVRPVjRUVXBDMTl5SUhqUnpr?=
 =?utf-8?B?VmNqQyszQ1RmdTRBLzhvdUdqNU9SbVBiUHlDRHBkRmRRSlRtcm1WWHZXR3pZ?=
 =?utf-8?B?QklFR0Q3VnNQTnVtTTAyYkF5Vk9NQjlnbjZjZEtXSlljclFDZUc1V0NGNHhX?=
 =?utf-8?B?TWlHTEE0Q3FpRitINXc3STl3MzlDdUI4Vmtjd284Umc4ZHFKUWNGOUJJUmZ0?=
 =?utf-8?B?aWt0cGwzVENMb2pwZWh2cHJWSGRCK1FCYU1xaUNPNGNVNEY1bEszSjlkR1Uw?=
 =?utf-8?B?cFVsL1I5LzQ5RHVTakZWQkJiUkRjWDlHTG1SV0hvdGZYM2ttUkpoN2wySXkr?=
 =?utf-8?B?YWE2NkhmbkR6bEhWM2p1V2NRc1oxT0R6OXh0OWoyaFM1REhMR3dRUDhRSTNP?=
 =?utf-8?B?SWlzQmVkM3ljQW1SaFJpc2QyNFpVMzAwam5xOEdxclozczRFZGtzVE9keW1F?=
 =?utf-8?B?SzBWdC9vM2xGYVBJVXQzNzgwTzVPaVloRHh6Q3NqY1RDdjQxbnVxT1ZzYmt2?=
 =?utf-8?B?SGpqUnpWSWYwRU9mN3ZtdEV1ZS94eHRmSmtRWTQ4KytwTSs3RFovcDR4clBR?=
 =?utf-8?B?YncxVjA5K2gxblljaEZCbWIwekt4dEFZckNLaDVmcEJYNHRaVWhNajdDTjBB?=
 =?utf-8?Q?DpG9HoNsuTDKBvyhfL+h5KlevAOqCsOoH1BeLef?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d6b134-2d48-4b2e-5412-08d8d9bf58cc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 18:58:32.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QsOhAq6iWIIUYAyogJ2PcSGUVHEK5r+6+S5lppkGHzpBYJQPVoTLq9beFY55CzyUTVEelsFYlS+EyYs5e6v6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3415
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250141
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250141
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/24/21 6:26 PM, dai.ngo@oracle.com wrote:
> Hi Olga and Bruce,
>
> On 2/24/21 2:35 PM, Olga Kornievskaia wrote:
>> On Mon, Feb 22, 2021 at 5:09 PM <dai.ngo@oracle.com> wrote:
>>>
>>> On 2/22/21 2:01 PM, dai.ngo@oracle.com wrote:
>>>> On 2/22/21 1:46 PM, dai.ngo@oracle.com wrote:
>>>>> On 2/22/21 10:34 AM, dai.ngo@oracle.com wrote:
>>>>>> On 2/20/21 8:16 PM, dai.ngo@oracle.com wrote:
>>>>>>> On 2/20/21 6:08 AM, Olga Kornievskaia wrote:
>>>>>>>> On Fri, Feb 19, 2021 at 10:21 PM J. Bruce Fields
>>>>>>>> <bfields@fieldses.org> wrote:
>>>>>>>>> On Fri, Feb 19, 2021 at 05:31:58PM -0800, dai.ngo@oracle.com 
>>>>>>>>> wrote:
>>>>>>>>>> If this is the cause why we don't drop the mount after the copy
>>>>>>>>>> then I can restore the patch and look into this problem.
>>>>>>>>>> Unfortunately,
>>>>>>>>>> all my test machines are down for maintenance until 
>>>>>>>>>> Sunday/Monday.
>>>>>>>>> I think we can take some time to figure out what's actually 
>>>>>>>>> going on
>>>>>>>>> here before reverting anything.
>>>>>>>> Yes I agree. We need to fix the use-after-free and also make sure
>>>>>>>> that
>>>>>>>> reference will go away.
>>>>>> I reverted the patch, verified the warning message is back:
>>>>>>
>>>>>> Feb 22 10:07:45 nfsvmf24 kernel: ------------[ cut here 
>>>>>> ]------------
>>>>>> Feb 22 10:07:45 nfsvmf24 kernel: refcount_t: underflow; 
>>>>>> use-after-free.
>>>>>>
>>>>>> then did a inter-server copy and waited for more than 20 mins and
>>>>>> the destination server still maintains the session with the source
>>>>>> server.  It must be some other references that prevent the mount
>>>>>> to go away.
>>>>> This change fixed the unmount after inter-server copy problem:
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>> index 8d6d2678abad..87687cd18938 100644
>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>> @@ -1304,7 +1304,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount
>>>>> *ss_mnt, struct nfsd_file *src,
>>>>>                          struct nfsd_file *dst)
>>>>>   {
>>>>>          nfs42_ssc_close(src->nf_file);
>>>>> -       /* 'src' is freed by nfsd4_do_async_copy */
>>>>> +       nfsd_file_put(src);
>>>>>          nfsd_file_put(dst);
>>>>>          mntput(ss_mnt);
>>>>>   }
>>> This change is not need. It's left over from my testing to
>>> reproduce the warning messages. Only the change in
>>> nfsd4_do_async_copy is needed for the unmount problem.
>>>
>>> -Dai
>>>
>>>>> @@ -1472,14 +1472,12 @@ static int nfsd4_do_async_copy(void *data)
>>>>>                  copy->nf_src = kzalloc(sizeof(struct nfsd_file),
>>>>> GFP_KERNEL);
>>>>>                  if (!copy->nf_src) {
>>>>>                          copy->nfserr = nfserr_serverfault;
>>>>> - nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>                          goto do_callback;
>>>>>                  }
>>>>>                  copy->nf_src->nf_file = nfs42_ssc_open(copy->ss_mnt,
>>>>> &copy->c_fh,
>>>>> &copy->stateid);
>>>>>                  if (IS_ERR(copy->nf_src->nf_file)) {
>>>>>                          copy->nfserr = nfserr_offload_denied;
>>>>> - nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>                          goto do_callback;
>>>>>                  }
>>>>>          }
>>>>> @@ -1498,6 +1496,7 @@ static int nfsd4_do_async_copy(void *data)
>>>>>                          &nfsd4_cb_offload_ops,
>>>>> NFSPROC4_CLNT_CB_OFFLOAD);
>>>>>          nfsd4_run_cb(&cb_copy->cp_cb);
>>>>>   out:
>>>>> +       nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>          if (!copy->cp_intra)
>>>>>                  kfree(copy->nf_src);
>>>>>          cleanup_async_copy(copy);
>>>>>
>>>>> But there is something new. I tried inter-server copy twice.
>>>>> First time I can verify from tshark capture that a session was
>>>>> created and destroy, along with all the NFS ops. On 2nd try,
>>>>> I can
>> Hi Dai/Bruce,
>>
>> While I believe the fix works (as in the mount goes away), I'm not
>> comfortable with this fix as I believe we will be leaking resources.
>> Server calls nfs42_ssc_open() which creates a legit file pointer (yes
>> it takes a reference on superblock but it also allocates memory for
>> "file" structure). Normally a file structure requires doing an fput()
>> which if I look thru the code does a bunch of things before in the end
>> calling mntput(). While we free the copy->nf_src in
>> nfs4_do_asyn_copy(), the copy->nf_src->nf_file was allocated
>> separately and would have been freed from calling fput() on it.
>>
>> So I guess it's not correct to do kfree(copy->nf_src) in teh
>> nfs4_do_async_copy() I think that's probably where use-after-free
>> comes in. We need to keep it until the cleanup. I'm thinking perhaps
>> call fput(copy->nf_src->nf_file) first and then free it? Just an idea
>> but I haven't tested it.
>
> I think the unmount can be treated separately and the fix seems
> to be valid for this issue. I think kfree(copy->nf_src) is called
> after nfsd4_cleanup_inter_ssc so it's not the reason for the
> 'use-after-free' warning. A quick look at nfsd4_do_async_copy
> I see nf_src was kzalloc'ed but no ref count added to it.
>
> I will review the whole cleanup part and report back.

I think this would fix the resource leak problem:

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 57b3821d975a..742fc128fdc8 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -405,6 +405,11 @@ static void __nfs42_ssc_close(struct file *filep)
         struct nfs_open_context *ctx = nfs_file_open_context(filep);
  
         ctx->state->flags = 0;
+       if (!filep)
+               return;
+       get_file(filep);
+       filp_close(filep, NULL);
+       fput(filep);
  }
  
  static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {

-Dai

