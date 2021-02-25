Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC283248E0
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Feb 2021 03:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhBYC1S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 21:27:18 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53600 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhBYC1S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Feb 2021 21:27:18 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11P2OrQ5103433;
        Thu, 25 Feb 2021 02:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eqkdqJNBrLngm1qH6EGxGl55w8xXKBBaiKQKv3Hwzyk=;
 b=zfb76Z0b8WZocky0mGf7PHSNJRyj+yTC7HtC7icODdLg3qoCevJCk/36/fpZI8BxB8eG
 hijINU1tA2vLQr4w2z2hqGvmmwcTv3rqTDmHjn+AkA/wn9HPgdVUXoVb2lgiYwF/lW2r
 vtyXrGT5Khct2vkdptwC/0ZOmFv8Yx+6quMFthBo5SJpUbtyZanI6yBKBLYEgmIjoGwh
 33zD2oGweuLUDE1SUWpAhX1FezXN6mxLxGO8ZvSU0H6A6y2hkp//T7VkenOdMjNaiqeT
 ZUD1R50nTGh+H0kc84OINGSX0to3wKTNXEGQGozLK88aiWEpVS68hdMDnV0c0BNXIE9v pQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36ugq3ku29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 02:26:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11P2Oa6M159741;
        Thu, 25 Feb 2021 02:26:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3030.oracle.com with ESMTP id 36v9m6pxsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 02:26:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVvLN5GJQ8qm4F20rzFmQ78JR7bD2ITOLGHZCmQhblL91GBjJK+v856opp8YmWQJj0089kqx8Go5+EcmhyK826XsvmRqJ4CTBUxD/NFWulSOZi8krjIyxrRpbb3wLNt2Oq6ipS75m9yRMveoqFZxBltlZzqRDA20M5SR1LCGCa+sll2d2Hh37E8Ai0ZYY/wosyvMah/TrvSX1o1pP4Qbc1HysGs3XEj/J67y2zl1wLb7JUvGANF5VnYRkV6C619CF/aZaPg3PDltcWRHQZGAbolRoHSmMJm/aHg6jOowWqKyiCTN+tfmZkKIo2lZVBke15AFqQevI3+JRRWcf9brGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqkdqJNBrLngm1qH6EGxGl55w8xXKBBaiKQKv3Hwzyk=;
 b=QxB3qAaS6GYFqGcf6DvG5LxKaG/wvFEke3EQP9lMIK8fJLW+VwZN9fiUm00a+8TBSR/6b5qEDAdKE/xEXMEuVIAJuYzv1V8UY4SL+H3Xgk7IrLpH23WpSmyKMDs3VOYNadoDvmzCTJtVlSmN9EHaPvaxdMQsS1XdMQa3O5oCaoa+1devMdifWlbEPB32ecmUX4A67nSsOPFqW0RQP8MvjCzbbRLhksubCJ+n3P0G3Z2jlecz4W/xGEz7GZqnI7gjSDl+NyFycKlCAkEzy4LcXU3VPp5hmVIhtuSA2iz/QowUVKYhtS0nVk7v+SuiFybRwRA9Kgb6PMgidk/6b/Q5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqkdqJNBrLngm1qH6EGxGl55w8xXKBBaiKQKv3Hwzyk=;
 b=G0PbTMw0fQ6m7/9CGJ6dW3kelaF2uhDeK2ciYpIMDwHiOepOrlczCyTyl6zQmrB9Ykjpih2OBIzT1A1dw87gfybA8mn90woFSXWiVqhlEQ9xIeI45QW/v5pR2zvbxFxEAcEAmcWfBHeHhEuqVnQ3m1UM2q2rtsn0N5oGZVG17eE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2567.namprd10.prod.outlook.com (2603:10b6:a02:ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 02:26:23 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8%6]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 02:26:23 +0000
Subject: Re: [PATCH 1/2] NFSD: Fix use-after-free warning when doing
 inter-server copy
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
From:   dai.ngo@oracle.com
Message-ID: <7771b9f4-3689-cdca-5dd3-ef77e239ceb6@oracle.com>
Date:   Wed, 24 Feb 2021 18:26:20 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAN-5tyEXPxb7SZv_qmCECPUSdUgWSrPigrWxTORC0ZrMAj08Fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SA0PR11CA0137.namprd11.prod.outlook.com
 (2603:10b6:806:131::22) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-104-3.vpn.oracle.com (72.219.112.78) by SA0PR11CA0137.namprd11.prod.outlook.com (2603:10b6:806:131::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 02:26:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eba3dbb-2328-42e2-9bd9-08d8d934bed7
X-MS-TrafficTypeDiagnostic: BYAPR10MB2567:
X-Microsoft-Antispam-PRVS: <BYAPR10MB25675B657F670BE2AA1DE1BA879E9@BYAPR10MB2567.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3WKgjyy7G8g7TRY/O2Ln/ni6Qh0QdauiavCUCUrjB11PDFYiAuq7BwTBPnzLhCltGF4FRP1uisyEDfUpmRqiwmEV3lwzdnaLJrI+8XVPcCLJAQ9ero5xqEKWl2FqOGNcYTo+6N1Hz02vnv56VPDr6r5XEW7CX54adMpbFqyynZBsa+87aDTKh4jkXey996UKlix4BK0APJZSBtwV4PGJTLrH7nln9/HejNr5BbWZn3bK1hggkYvNj5GoEA3lIAdSSwRDUG1UEfU3QCdRFKsRufIWWjGIDKQyGeZYrDolt6BRC51gjtQkhYbJ03rBIULoZ6Vh1qZlz3+ENr1lGXTxrN4UwLAXNPnBfAcenMajY92n1gFhBwM5Lrbk3SkWz7ztIlpmIQNIqAkW0KsD+Y1TuUHeYkNlf8IDXBWqcfFvMeSoSx2s9KqgkcZo6Y8OiatfFbnTacmwgoIz/9FgTn5dpRJey+ZEx/9My5uEoHpBAHWV0jNEYFRgwJNSBih5EMR0mHCnu+97be0bQAQupqVhotRoYBKiHJ0WhI/oIhnoGEyyPvWKf3+W7EEp3SimIdOZtcs871mEIL6iGrTwvqNGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(366004)(396003)(376002)(66946007)(5660300002)(478600001)(54906003)(86362001)(83380400001)(53546011)(66476007)(66556008)(4326008)(2616005)(31686004)(9686003)(31696002)(8936002)(8676002)(956004)(26005)(6486002)(7696005)(2906002)(316002)(6916009)(186003)(36756003)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RUpabFpjeWNCZjNFdlR5bjlSd1liSzNFZ3JYTnU3dmZXU3FNSnJNa1l5eUFZ?=
 =?utf-8?B?bHV3eHRTSlpWMC9GVU90b2tvcDhSRHEvbGU3SGFzU1FvdGJvMXNHL1BSNFNY?=
 =?utf-8?B?eEFIZzdWd2J3dm1KS3lINFpvdGt1QjNVekR2K2piam1Kblg3K1BOaGdobHZ5?=
 =?utf-8?B?b2o4eWg3NnNpWXF2WVE3bUYvK2MrNGNQRHh5TlJXYkxOeVBpOGJybS9Hc1Er?=
 =?utf-8?B?WkJTSGZoZ3dqZzd1bDlxNklEZEp5SS83SGxxWmM4Uyt0WjJ3M0xISEZvS3lL?=
 =?utf-8?B?M1czQWZPcVd4UWFLWEtBMFI4eVhjRlpMUG9CRDlpeWJheUZLODZrWG5vY2F4?=
 =?utf-8?B?dnhhblZGUXFUM3Z5WTdhMmg1aHJZdTBBT0VlRm90RmY0Q1BvYmluUUpkVzVT?=
 =?utf-8?B?MURiRmEvQk1qL3NCaTdKNVNYQUxKME4rUFhkTk5UUzlnMCtzQXE4Wmx1SVlM?=
 =?utf-8?B?L2pFNnJCRlJzeUw0Y1JvcVR4b01Gd2s5N2FCRE9VdmtBLzAzNC8yRGFYNml0?=
 =?utf-8?B?MElqV21DTXp6dnZObWFNaDBuSDcxdmFEd0orN09Xd3Fod0RXWnpmRTRtRTNQ?=
 =?utf-8?B?Y284eGtQZ21CYVpwOXZBMnlpUURRbG14Q0ZTM2RVV2E2WFlDYWxrcUxZWC9x?=
 =?utf-8?B?UTlhNzh5Mm5oU2VJRkFEN28rN2VLbE42d1Ara24yaHZQL2ExUkhyeDA2bExt?=
 =?utf-8?B?eE8vUnZOKzZhUVM3ZmpYTUFGL1FOOEMxbWdBanFYaUtWU0ZlY0ZheDhYUWVE?=
 =?utf-8?B?d2ZhYXk3Vk5ESS80aWFoRXNJRGNkYUhQcTU2OEJ0bDZvUWc3ZnpDNjF5dG9n?=
 =?utf-8?B?TkhFTk9jVkhmek4vY1N1eStaY1VlWjRaZlBEUnovSlNDdmN0WnZJNHJYOXFC?=
 =?utf-8?B?SGRpdWk1Tkp5RC95c0VEVWp3ZXFkbE9SOW9GWjZrTXNnY3BINWxrQ0VJRFow?=
 =?utf-8?B?dVBzT09lL1lwd2ZZQzZNMWNhSkV1SmhpWS9CTytaLzgweEIrYm5aSlJoaVMv?=
 =?utf-8?B?ZkdLYUtDWURCYlJ5WmVCSlRUSlI1ZHRXUEZ4NW1CS1JJMWlvWU8wS1Z5SmtQ?=
 =?utf-8?B?OC9GSWxUREhyUmVMUC94YjE2OXNydXdPemFHWEp4MG00Uk9hTTJ4b2hNMFdJ?=
 =?utf-8?B?Y3Bub3k5ODVKUlNUM1JrTGlKRDdCL1A3V0J5aCtBbmNpelROa0k0dXBJRnV1?=
 =?utf-8?B?WGtMRnR6V0wxKzBpbFRGZ2F2OU9HNGVYMHI0QlFqQkNXcVZZVXd1WDRYU2pV?=
 =?utf-8?B?a1dGMXVIcVdNQVhzRzVQZEtjS2xFSTZSNDB6THZUWjVoTFJwbFJpM1ZCdHNz?=
 =?utf-8?B?Uk9XWGd3eUtPOFlRaXpGV29VbDYyejBSSlBVZ2JIZTVsWjdLbXozQTRjalY3?=
 =?utf-8?B?b2xOWVZUQ3h4RFNaNmk3SHhUN1dmRTlFR1NDZ0p3RlJacVhFdDNJSm1xQmxp?=
 =?utf-8?B?Y1diUFh2bEhDRzJGMFRYMThNeDQ4bW1SbUgrSlNxU2JqZ0xTcWNkVGJwS0F6?=
 =?utf-8?B?bVdkY0pmSnovNTBmcTRsZUhaSW9CNnJIRmlkb012YUp6clN1MDQ0MExOakpP?=
 =?utf-8?B?Skk2V3doYVg4NDl1TlBRVSsrd01VMUVkSnQzb2JxQTNVdm9uWlJFNmZsSG1i?=
 =?utf-8?B?QUtqbGhqMDE0bXFXZHFveEk5SjdJeHZOMUREVVdNWVk2a1NpRkZ4SVdDT2xk?=
 =?utf-8?B?Qk9ZRDhPRExsMzVlNXRLMDZ6RHZ1Q3Y5Ukw0dzBCWUpWdFNvNVhSSmkySm14?=
 =?utf-8?Q?18wqiX1vj2V6JdsKhDoaqJfif/xqjqzQj46YOtt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eba3dbb-2328-42e2-9bd9-08d8d934bed7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 02:26:23.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46AdN03lVn4Gw8ydbGHKkvx5jZifIKW9gnsHH4u2OEfHWqWh9T7Akh/LI8EU00swGUbCj0pUf1STNklkePWFNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2567
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250018
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250018
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga and Bruce,

On 2/24/21 2:35 PM, Olga Kornievskaia wrote:
> On Mon, Feb 22, 2021 at 5:09 PM <dai.ngo@oracle.com> wrote:
>>
>> On 2/22/21 2:01 PM, dai.ngo@oracle.com wrote:
>>> On 2/22/21 1:46 PM, dai.ngo@oracle.com wrote:
>>>> On 2/22/21 10:34 AM, dai.ngo@oracle.com wrote:
>>>>> On 2/20/21 8:16 PM, dai.ngo@oracle.com wrote:
>>>>>> On 2/20/21 6:08 AM, Olga Kornievskaia wrote:
>>>>>>> On Fri, Feb 19, 2021 at 10:21 PM J. Bruce Fields
>>>>>>> <bfields@fieldses.org> wrote:
>>>>>>>> On Fri, Feb 19, 2021 at 05:31:58PM -0800, dai.ngo@oracle.com wrote:
>>>>>>>>> If this is the cause why we don't drop the mount after the copy
>>>>>>>>> then I can restore the patch and look into this problem.
>>>>>>>>> Unfortunately,
>>>>>>>>> all my test machines are down for maintenance until Sunday/Monday.
>>>>>>>> I think we can take some time to figure out what's actually going on
>>>>>>>> here before reverting anything.
>>>>>>> Yes I agree. We need to fix the use-after-free and also make sure
>>>>>>> that
>>>>>>> reference will go away.
>>>>> I reverted the patch, verified the warning message is back:
>>>>>
>>>>> Feb 22 10:07:45 nfsvmf24 kernel: ------------[ cut here ]------------
>>>>> Feb 22 10:07:45 nfsvmf24 kernel: refcount_t: underflow; use-after-free.
>>>>>
>>>>> then did a inter-server copy and waited for more than 20 mins and
>>>>> the destination server still maintains the session with the source
>>>>> server.  It must be some other references that prevent the mount
>>>>> to go away.
>>>> This change fixed the unmount after inter-server copy problem:
>>>>
>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>> index 8d6d2678abad..87687cd18938 100644
>>>> --- a/fs/nfsd/nfs4proc.c
>>>> +++ b/fs/nfsd/nfs4proc.c
>>>> @@ -1304,7 +1304,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount
>>>> *ss_mnt, struct nfsd_file *src,
>>>>                          struct nfsd_file *dst)
>>>>   {
>>>>          nfs42_ssc_close(src->nf_file);
>>>> -       /* 'src' is freed by nfsd4_do_async_copy */
>>>> +       nfsd_file_put(src);
>>>>          nfsd_file_put(dst);
>>>>          mntput(ss_mnt);
>>>>   }
>> This change is not need. It's left over from my testing to
>> reproduce the warning messages. Only the change in
>> nfsd4_do_async_copy is needed for the unmount problem.
>>
>> -Dai
>>
>>>> @@ -1472,14 +1472,12 @@ static int nfsd4_do_async_copy(void *data)
>>>>                  copy->nf_src = kzalloc(sizeof(struct nfsd_file),
>>>> GFP_KERNEL);
>>>>                  if (!copy->nf_src) {
>>>>                          copy->nfserr = nfserr_serverfault;
>>>> - nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>                          goto do_callback;
>>>>                  }
>>>>                  copy->nf_src->nf_file = nfs42_ssc_open(copy->ss_mnt,
>>>> &copy->c_fh,
>>>> &copy->stateid);
>>>>                  if (IS_ERR(copy->nf_src->nf_file)) {
>>>>                          copy->nfserr = nfserr_offload_denied;
>>>> - nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>                          goto do_callback;
>>>>                  }
>>>>          }
>>>> @@ -1498,6 +1496,7 @@ static int nfsd4_do_async_copy(void *data)
>>>>                          &nfsd4_cb_offload_ops,
>>>> NFSPROC4_CLNT_CB_OFFLOAD);
>>>>          nfsd4_run_cb(&cb_copy->cp_cb);
>>>>   out:
>>>> +       nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>          if (!copy->cp_intra)
>>>>                  kfree(copy->nf_src);
>>>>          cleanup_async_copy(copy);
>>>>
>>>> But there is something new. I tried inter-server copy twice.
>>>> First time I can verify from tshark capture that a session was
>>>> created and destroy, along with all the NFS ops. On 2nd try,
>>>> I can
> Hi Dai/Bruce,
>
> While I believe the fix works (as in the mount goes away), I'm not
> comfortable with this fix as I believe we will be leaking resources.
> Server calls nfs42_ssc_open() which creates a legit file pointer (yes
> it takes a reference on superblock but it also allocates memory for
> "file" structure). Normally a file structure requires doing an fput()
> which if I look thru the code does a bunch of things before in the end
> calling mntput(). While we free the copy->nf_src in
> nfs4_do_asyn_copy(), the copy->nf_src->nf_file was allocated
> separately and would have been freed from calling fput() on it.
>
> So I guess it's not correct to do kfree(copy->nf_src) in teh
> nfs4_do_async_copy() I think that's probably where use-after-free
> comes in. We need to keep it until the cleanup. I'm thinking perhaps
> call fput(copy->nf_src->nf_file) first and then free it? Just an idea
> but I haven't tested it.

I think the unmount can be treated separately and the fix seems
to be valid for this issue. I think kfree(copy->nf_src) is called
after nfsd4_cleanup_inter_ssc so it's not the reason for the
'use-after-free' warning. A quick look at nfsd4_do_async_copy
I see nf_src was kzalloc'ed but no ref count added to it.

I will review the whole cleanup part and report back.

-Dai

