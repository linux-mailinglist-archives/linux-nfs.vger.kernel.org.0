Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325AA3221F6
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 23:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhBVWJq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 17:09:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51378 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhBVWJn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Feb 2021 17:09:43 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MLx1YM100382;
        Mon, 22 Feb 2021 22:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=m1FKzsxGnjepC0puUFRFTs10MzLuMP6nfBi2HwviQO8=;
 b=fXF8ei8R5Cs8h2XWW8ViXUmyOH80Ip9tDdGACp4OI1x+XToDkwgqWfOGot78IAjkdIBc
 OaLS0s6sWyKV2EiOwDxL27aQram6EQ2zTAycJ8dL+oLrADOff5fgeT+sStAYBVpw2DH0
 7e4b8HVWrEruAJHyi59mlJCmTC7xuUSPyaArjergDqdBJrst1pnoT49z+YYI8hYIY9by
 PdmSFNBMJvufe7ktlU5l161Q9zKwv6FLvKcM2uyeriox1lTpkb3x6z+IJVbbWZDPHcHi
 FUjLWEA/OAZ/c9d2xizCPo3MymZPyHh5OhNlO1DLoijno7Sn+tXLw5UUlrb3VbnykGdS cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36tqxbde7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 22:08:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MM0YA3173922;
        Mon, 22 Feb 2021 22:08:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3020.oracle.com with ESMTP id 36ucaxkjt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 22:08:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhtXUg6TSU9kXJ5I6DZ6rWLT9wMq9mjIo6ZqXymj32FrYWNGVxonAM8eJKxDYPKHnaHXCYTEj7au6XCa8hN2BGiRx2s+gUx7acV+sTmsiX35vR9Mh64f/f3f3EbDZEPhQ3U0VPlTVSJ90MZNJTRpM2xFGya8m+IvlxBBytzUYi+yNWWHy8z/k9i44Zq4OwMLPSmYzv2C/HajOBqD2m9PIOd+kOnW4ZpZ/vtV4tc40S+r/DYSSR2MtgVG5Z58UaDwuKHjIQMPJPDN28SJhzdlnzpi/oIvXMCLh5u93E3ugFxIDUtyUFvEPSaf+ysX0QyiB0jZDpIdaLtkGq6AgDvCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1FKzsxGnjepC0puUFRFTs10MzLuMP6nfBi2HwviQO8=;
 b=bp0T8L8oWS/Ocmvr2WUFzkvUDfG/tTKTVC34n7SXKDbE+VO57wKFP8Wax3d/ucdABYigRg8Zl/FPKiZTb5aKC82fjFRrYKCmYBK0L1i+4P/IR2E9Vzkmyj54w+SxKOqaWPFlLJEPCBXlylva5tqD+3Fur6km6O2fqEC8stSGBqmWR3sqZQx19MF4uajWcNdJnKjlT0nLMIMKdnzpQsw85RcbRYxrliKHOm3oQOUjOlEy0hLcFSfuy6ePOnxbkXNuB2As2FSg5V52yPWiFctXt6vcfbG36Xn3US7FNczakEAKEHYwHFM1sDqtEG89MmYEpz5HADY+4K/HL0atiyYgVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1FKzsxGnjepC0puUFRFTs10MzLuMP6nfBi2HwviQO8=;
 b=p/WY4t3sNjtJgUpW6rj+vvFxckDOfKK3zOYQukSDCmPUEP045t/ifaendAnvB/2xc+GDqJHo7Z/D1048yo74bdPl9wITon7XgTEmpsuNIDO5PxxYjMgg4URIYEe8lzbb2vnYVdeU1lE6p5K5HuQ72DKS6pjtWKytLosOsxP6aJs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4558.namprd10.prod.outlook.com (2603:10b6:a03:2d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Mon, 22 Feb
 2021 22:08:49 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8%6]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 22:08:48 +0000
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
 <ff068f05-c9cd-9772-4be7-74ae28a268d7@oracle.com>
Message-ID: <a5cc3d04-06bc-6f3b-3ac2-c96a8efb1194@oracle.com>
Date:   Mon, 22 Feb 2021 14:08:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <ff068f05-c9cd-9772-4be7-74ae28a268d7@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::12) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-137-111.vpn.oracle.com (72.219.112.78) by SJ0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:a03:39f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 22:08:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 733bea6d-60d0-45ab-5bf1-08d8d77e6e2d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4558:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4558C9B7BEF519EAE93AA6AB87819@SJ0PR10MB4558.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: veuVluU/J+hVcRAsAX0fAEalA7AFYEpG9SqWCoP9bnyMTD3nN4PiZFbwr8jvS2oVlwmyzb10hWtKPr52ybMu4CabUmMRcP7W/kGD8Bo/QC/M+c18UICG8fep1FQ/6bvm79akzN12bYPdDRSmuWx5Y47dPeSJQDSk8SrF2H13Ivt8PFSS2IgcWtKIHxX6VYms5Y4d/ays6oHbTy7KrO1b0I/59bVczbjWr/7P3FAjLYQ3DRrBN4cYL70ZxvEy/aOWQTOt5fWxyau8d01GtW9o5i6GKZ7ZMO2mLhmaryIcIPg54JK4ovPqqE8DjDzqsj1ioFMbn0okFp6FC1qCTAnLLee/9PXXwXzSFEdOCUupoaPVdrCfs8vOQZYkvKSByDpbxATmMRs5+5wyfkD2ypQEtWTfBNMD+zN+mXX6D/utIf/NUvPgSQiqrUNWezV347zyZk0ne32RJ8GxJm3jWkIBDv268Rv7TyOmz1Mm7JFepJrazfK4ZL0WheEshKxKpouTlKIudUfR7OsBovu5OuB4epkVKB74LS1p+FX0z09V8vfaAX0Znpu8NEs/sCh6+OnatUwN4v/7h6+cqUi2a/pEQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(346002)(376002)(8676002)(6486002)(16526019)(8936002)(2616005)(4326008)(9686003)(478600001)(5660300002)(186003)(956004)(26005)(66476007)(66556008)(66946007)(110136005)(2906002)(36756003)(7696005)(31686004)(86362001)(31696002)(53546011)(83380400001)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eTJUNHVQM3NZdzVzckt4UmJGK1ZHTFRNdk5GN2NrNmtIM0VvRkt4SUdWeUpj?=
 =?utf-8?B?UTd5NnNoT3pnY0pNUUxmWWJ6V1VWWUZhZ0dTVW01M2dJNmd0aUZEcUErNURr?=
 =?utf-8?B?bVdKMjFoUDE0M3laeWswYUVoUHhyTUJVZ0dpbzAzM3h1NlI1V09aWHNYT0FI?=
 =?utf-8?B?cHByaXd0ZVBObGFxSllNS1R1SlFyYk9MQlV6K0llOFdkN09IRHkvTjJmK1lp?=
 =?utf-8?B?REM3cmY0eXNheW1Bby85N1JBcEVaek5XZ21ST0JTTWlmSXNScThjRmkzTXRl?=
 =?utf-8?B?TGtPUFNHczVQYWRDcWFNZSt0bWJJTERtZEZGOWVPR2R1R2FRQ0UxZld2cE4w?=
 =?utf-8?B?eDlLSStWWmMwY0k3SithUjA3NHUxdVJLNlpqYVMvSXhYMU5TSmZlTHgvOTZ1?=
 =?utf-8?B?MFFrcGFJem9NSHROUzBMakFKSnN4ZVp1V3JPWXA2cEdhSE05L0JaTnlFT1Rx?=
 =?utf-8?B?eWdUQjRLa2d1bmRqbTBRVWRoaFR4NVB2T2dwQ21BTTNqUFhKelJKNEpqeEpl?=
 =?utf-8?B?d051VGFsV1dYWGIwUmdGYWRXdGVLMlhyK3V0UTdjWmoxVGRSOFdXbjQ4UnV3?=
 =?utf-8?B?Zkx0VXFScnBoYXJkdFZ6dVdONlZkUEZVcjNjZVZ2RFhuanVQSDR1TkZFRDFG?=
 =?utf-8?B?eFNodm1qenpCaDdFWmJYc094bnJOT0pjRVN1dUVlbkRMeXFsNXdWSGJYbDhl?=
 =?utf-8?B?N3V2Y2JUYXA5c3RFZ1F1Z09VNTAycktvckhtaVF1T3BmZnNXazRSYmJwTW5x?=
 =?utf-8?B?ZmN4UUlqT083WjB4Wk1tOEJKbzBzTWtoMEtvNlhaVGJQQWMwaldNSGplV2Y3?=
 =?utf-8?B?VGNtekUwWjU3TFVBQjhObmtCOVFPZUNYMWJxam5rL0h2RG9lZndMeW1wZnRp?=
 =?utf-8?B?SE1QcnJiUDVNMVErOHg3NkhHY0k5U0ZpekxNS1VueEJpSzJzWTF2Sk5zNlBk?=
 =?utf-8?B?NEV2b1FucEZZOGlTZ1dmNUtWZjUwbExPZjB6eHNmTzlBeVZ4ckRpNzV1Mkhh?=
 =?utf-8?B?c2FmN1ZwOC92WDBydjJ4bnE3UzVBdlg3bzVRLytVZEovZHFTTEVjWEdVdXIx?=
 =?utf-8?B?N3ZEQ3B0bmNhS3FsM1ZkUXI5cmJTZEFHWm5McjRLbG9ucHMra1pVVWpRK2xK?=
 =?utf-8?B?TzhTMjZqd00yemZtWFJpaU5CSE5sWUdnQkl4M3lMYVhHKzBvL2dhTlZ4UGR1?=
 =?utf-8?B?RTJKWERuclBIYzZWQ1NNeDcxOFdDZXNiK1VLb0E0d0VUbGJ2aVFlNHJEbWho?=
 =?utf-8?B?SERMS042dVNJNFFXWmdIUHp3c0pDM1daeVhWc2lSWHJhRmlwZzFpSDE3ZnRx?=
 =?utf-8?B?SVprcmlWSlBwTHg1RVVhYXBYaUJKWncxQWZ5T2pabk9QTmVVVkJndGdlUlg1?=
 =?utf-8?B?UjZ5b2RIclh2dlNjczZXa2FYcy9FMmluQlpVYVJCbWxxZFowN2twUUVaQUIx?=
 =?utf-8?B?OUk3L3Q1S3cwNlRKejc3am9lY2FjamdDek5oc3pXdFkveHIrOGc5eUtWM2ZS?=
 =?utf-8?B?Y005M2ZnSkluWHJUUGVpVlIyRzVBRzlxUUFKY1UwYUplWEQ4QlFrMEJPamln?=
 =?utf-8?B?RUNhVzlHMDltNkgyTXBrNG9SUHFoZEhmQUh5NHBqWGlpd0VlcWdBL3ViUzVN?=
 =?utf-8?B?ZWtudTh1ZGQ2MVF2bXpVWEpUUGJrdm9aREwrSTdVYytKWGdUaXRCYWJnQUVL?=
 =?utf-8?B?aGZVai83dlp0RVhMR3BhMENobU5UU0RKTCs5K29lVUk1bHd6dUIwZThMYUsr?=
 =?utf-8?Q?gp2afFfCIC/iAU76yhZiS2+B8++99iREPpZttNd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733bea6d-60d0-45ab-5bf1-08d8d77e6e2d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 22:08:48.9074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnbuG7nvGDRcnP1ZvEyyYvK+hImoIQ9a1aLXOivaCQrWu5avj3P17ZkWisGdCSk9F41a+KIRgYt9MDetDoStaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4558
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220190
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220190
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/22/21 2:01 PM, dai.ngo@oracle.com wrote:
>
> On 2/22/21 1:46 PM, dai.ngo@oracle.com wrote:
>>
>> On 2/22/21 10:34 AM, dai.ngo@oracle.com wrote:
>>>
>>> On 2/20/21 8:16 PM, dai.ngo@oracle.com wrote:
>>>> On 2/20/21 6:08 AM, Olga Kornievskaia wrote:
>>>>> On Fri, Feb 19, 2021 at 10:21 PM J. Bruce Fields 
>>>>> <bfields@fieldses.org> wrote:
>>>>>> On Fri, Feb 19, 2021 at 05:31:58PM -0800, dai.ngo@oracle.com wrote:
>>>>>>> If this is the cause why we don't drop the mount after the copy
>>>>>>> then I can restore the patch and look into this problem. 
>>>>>>> Unfortunately,
>>>>>>> all my test machines are down for maintenance until Sunday/Monday.
>>>>>> I think we can take some time to figure out what's actually going on
>>>>>> here before reverting anything.
>>>>> Yes I agree. We need to fix the use-after-free and also make sure 
>>>>> that
>>>>> reference will go away. 
>>>
>>> I reverted the patch, verified the warning message is back:
>>>
>>> Feb 22 10:07:45 nfsvmf24 kernel: ------------[ cut here ]------------
>>> Feb 22 10:07:45 nfsvmf24 kernel: refcount_t: underflow; use-after-free.
>>>
>>> then did a inter-server copy and waited for more than 20 mins and
>>> the destination server still maintains the session with the source
>>> server.  It must be some other references that prevent the mount
>>> to go away.
>>
>> This change fixed the unmount after inter-server copy problem:
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 8d6d2678abad..87687cd18938 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -1304,7 +1304,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount 
>> *ss_mnt, struct nfsd_file *src,
>>                         struct nfsd_file *dst)
>>  {
>>         nfs42_ssc_close(src->nf_file);
>> -       /* 'src' is freed by nfsd4_do_async_copy */
>> +       nfsd_file_put(src);
>>         nfsd_file_put(dst);
>>         mntput(ss_mnt);
>>  }

This change is not need. It's left over from my testing to
reproduce the warning messages. Only the change in
nfsd4_do_async_copy is needed for the unmount problem.

-Dai

>> @@ -1472,14 +1472,12 @@ static int nfsd4_do_async_copy(void *data)
>>                 copy->nf_src = kzalloc(sizeof(struct nfsd_file), 
>> GFP_KERNEL);
>>                 if (!copy->nf_src) {
>>                         copy->nfserr = nfserr_serverfault;
>> - nfsd4_interssc_disconnect(copy->ss_mnt);
>>                         goto do_callback;
>>                 }
>>                 copy->nf_src->nf_file = nfs42_ssc_open(copy->ss_mnt, 
>> &copy->c_fh,
>> &copy->stateid);
>>                 if (IS_ERR(copy->nf_src->nf_file)) {
>>                         copy->nfserr = nfserr_offload_denied;
>> - nfsd4_interssc_disconnect(copy->ss_mnt);
>>                         goto do_callback;
>>                 }
>>         }
>> @@ -1498,6 +1496,7 @@ static int nfsd4_do_async_copy(void *data)
>>                         &nfsd4_cb_offload_ops, 
>> NFSPROC4_CLNT_CB_OFFLOAD);
>>         nfsd4_run_cb(&cb_copy->cp_cb);
>>  out:
>> +       nfsd4_interssc_disconnect(copy->ss_mnt);
>>         if (!copy->cp_intra)
>>                 kfree(copy->nf_src);
>>         cleanup_async_copy(copy);
>>
>> But there is something new. I tried inter-server copy twice.
>> First time I can verify from tshark capture that a session was
>> created and destroy, along with all the NFS ops. On 2nd try,
>> I can 
>
> cannot
>
>> see any NFS ops from the tshark capture because all data
>> are encrypted by TLS/SSLv2. This behavior seems to repeat.
>> I will look into it but I think this is a separate issue.
>>
>> -Dai
>>
>>>
>>> -Dai
>>>
>>>>> I'm assuming to reproduce the use-after-free I
>>>>> need to run with kazan, is that what you did Dai?
>>>>
>>>> I did not use Kasan. I just did an inter-server copy and this message
>>>> showed up in /var/log/messages.
>>>>
>>>> -Dai
>>>>
>>>>>
>>>>>> --b.
>>>>>>
>>>>>>> -Dai
>>>>>>>
>>>>>>> On 2/19/21 5:09 PM, J. Bruce Fields wrote:
>>>>>>>> Dai, do you have a copy of the original use-after-free warning?
>>>>>>>>
>>>>>>>> --b.
>>>>>>>>
>>>>>>>> On Fri, Feb 19, 2021 at 07:18:53PM -0500, Olga Kornievskaia wrote:
>>>>>>>>> Hi Dai (Bruce),
>>>>>>>>>
>>>>>>>>> This patch is what broke the mount that's now left behind 
>>>>>>>>> between the
>>>>>>>>> source server and the destination server. We are no longer 
>>>>>>>>> dropping
>>>>>>>>> the necessary reference on the mount to go away. I haven't 
>>>>>>>>> been paying
>>>>>>>>> as much attention as I should have been to the changes. The 
>>>>>>>>> original
>>>>>>>>> code called fput(src) so a simple refcount of the file. Then 
>>>>>>>>> things
>>>>>>>>> got complicated and moved to nfsd_file_put(). So I don't 
>>>>>>>>> understand
>>>>>>>>> complexity. But we need to do some kind of put to decrement 
>>>>>>>>> the needed
>>>>>>>>> reference on the superblock. Bruce any ideas? Can we go back to
>>>>>>>>> fput()?
>>>>>>>>>
>>>>>>>>> On Thu, Oct 29, 2020 at 3:08 PM Dai Ngo <dai.ngo@oracle.com> 
>>>>>>>>> wrote:
>>>>>>>>>> The source file nfsd_file is not constructed the same as other
>>>>>>>>>> nfsd_file's via nfsd_file_alloc. nfsd_file_put should not be
>>>>>>>>>> called to free the object; nfsd_file_put is not the inverse of
>>>>>>>>>> kzalloc, instead kfree is called by nfsd4_do_async_copy when 
>>>>>>>>>> done.
>>>>>>>>>>
>>>>>>>>>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>>>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>>>> ---
>>>>>>>>>>   fs/nfsd/nfs4proc.c | 2 +-
>>>>>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>>>> index ad2fa1a8e7ad..9c43cad7e408 100644
>>>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>>>> @@ -1299,7 +1299,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount 
>>>>>>>>>> *ss_mnt, struct nfsd_file *src,
>>>>>>>>>>                          struct nfsd_file *dst)
>>>>>>>>>>   {
>>>>>>>>>>          nfs42_ssc_close(src->nf_file);
>>>>>>>>>> -       nfsd_file_put(src);
>>>>>>>>>> +       /* 'src' is freed by nfsd4_do_async_copy */
>>>>>>>>>>          nfsd_file_put(dst);
>>>>>>>>>>          mntput(ss_mnt);
>>>>>>>>>>   }
>>>>>>>>>> -- 
>>>>>>>>>> 2.20.1.1226.g1595ea5.dirty
>>>>>>>>>>
