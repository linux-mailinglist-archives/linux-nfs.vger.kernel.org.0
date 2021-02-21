Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46DF32083F
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Feb 2021 05:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhBUERR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 20 Feb 2021 23:17:17 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:32834 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhBUERQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 20 Feb 2021 23:17:16 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11L4EmmC090844;
        Sun, 21 Feb 2021 04:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IZFH2dwP8qAbM74YOppbwyl2THK1fljFTvy6eqVgEDw=;
 b=DxPT7VkKy4prsex47+P9CTuP2GQVSk/ysapmxFwt93BTTeuDFxC66VgNISxpqo8XhuyP
 4EB3Y6Oq7FFmf6T24bO+xr2w8GLBohfXL8k+Oxa5J36iD+vjCrM/9ewTrnI9QYG6ROrA
 Vw9SGO98H3/VY9lfrVSlvQR92sh1Ctyeq4QqqGBS6kE5hRhclPn31GiSh+AsvtN0USUL
 TgXl3Z/mQrmsXDUn9fejL2nRUOKurKR3qP100uqQRncRmA1A9AHroT0idzM93Ei9AwPv
 Zzk1c+Wgu3QxbhZk2agO4S60NsDvBmI/Qr4J3TNu5xn+GnK0WgVhTBNTSwZESsRaMySR 4g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36tqxb96yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Feb 2021 04:16:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11L4GN3H098606;
        Sun, 21 Feb 2021 04:16:24 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2054.outbound.protection.outlook.com [104.47.46.54])
        by aserp3020.oracle.com with ESMTP id 36ucavv3bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Feb 2021 04:16:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjiumOJbQTXyfP7iILVsqjdEzfbeLfDw9z0CFGLHaWUr6+Fv8HU+2OP5F5SbRsc5tEJI/xi0g/BgxtkkO43szPHuIs0jU2n37wLdY/tNMf/TvTZmk13MlPH4B/uYwj92359/MoUVSW5aeeDQqtQ5EsG0bKj7AFrOOPxN/yF8ZgnFC7CfTtkQSwnZtcnLsXY438qaoXkILzGdM/SfOTfSw9c6352po4qVTrKgNn/0Lu0uD+GW+kmMLNqSPK0PSWA2Vxvab5VeA47kM/kM0qISXnV4L/GiCjbTTWdhrdGqx8pdNZMcGpUKxB/d/3l4QRSa45C7LUaL+9AceafMfYo+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZFH2dwP8qAbM74YOppbwyl2THK1fljFTvy6eqVgEDw=;
 b=UwsryVSw586rvfmKIBAT2jlIx70SsUSkRoVGroO/br9MGceUEo7xQ3KBPPDfmRxT9q8u3rN+DcJSrzXXQ/4xPIiWaa9MYz1pIEkBNdpx1dwfH+WUEmIHFeJ0EkqI4UTk4SYRXZHXuxI8PMrRk+GMHwKAgy2jo5BvScHL7r4dd4HRxYQtjkYsbqavXESpF7lGchu6P3y8KOnPimFq0dqZkpI8aTD3fL6e0vJPL9V36u3b37oBPDwcZyvannGOcIi1Z3Cmt6W/WaDd7lKiX1vxMfXgA26pwQ3JDtNjqGDe3K7LlfW0neA2d87gtpJQbleHsioTzl+EV3aTF+gqTjlBuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZFH2dwP8qAbM74YOppbwyl2THK1fljFTvy6eqVgEDw=;
 b=Zd3hNAfVWUgERcK+k/e5oYe1bX9ohG2vlBPXIBIoVPxXxVAs1IgNJ2HGlO0qtz3+5do+3R9Z+aiUKk+yV+OUmk3oYZ19QdW+YFt+tWaVnouXVH4HiCyKaSPEa6aAK3/MkWpH41ogOMU8EkJ9Re4B/gewCk1Mqka9Eb9ZBoV3GRY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN7PR10MB2434.namprd10.prod.outlook.com (2603:10b6:406:c8::25)
 by BN7PR10MB2435.namprd10.prod.outlook.com (2603:10b6:406:c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Sun, 21 Feb
 2021 04:16:12 +0000
Received: from BN7PR10MB2434.namprd10.prod.outlook.com
 ([fe80::20d8:7ca1:a6d5:be6b]) by BN7PR10MB2434.namprd10.prod.outlook.com
 ([fe80::20d8:7ca1:a6d5:be6b%3]) with mapi id 15.20.3868.031; Sun, 21 Feb 2021
 04:16:12 +0000
Subject: Re: [PATCH 1/2] NFSD: Fix use-after-free warning when doing
 inter-server copy
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
From:   dai.ngo@oracle.com
Message-ID: <ef11a2f9-f84b-7efc-ba5b-ca36c33d1825@oracle.com>
Date:   Sat, 20 Feb 2021 20:16:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAN-5tyHq2NcQRbx01cSyJob=72MDUnwjK_t6GiDjTc3twbnvwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::18) To BN7PR10MB2434.namprd10.prod.outlook.com
 (2603:10b6:406:c8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Macbooks-MacBook-Pro.local (72.219.112.78) by SJ0PR03CA0283.namprd03.prod.outlook.com (2603:10b6:a03:39e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend Transport; Sun, 21 Feb 2021 04:16:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0b95d2b-6823-402a-9539-08d8d61f6bc9
X-MS-TrafficTypeDiagnostic: BN7PR10MB2435:
X-Microsoft-Antispam-PRVS: <BN7PR10MB2435A751A7B766E367EF8C8B87829@BN7PR10MB2435.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPUBaVfr4ow4Ee4SrAoGqPP4DbXfXeoD7JRUqI7LReEduQ+PPC8u7ypzE3odesvHBih255vJURL1jYeC1EDtZ7L3qXI0gb8QD9Elm9x8yHgt8jaISZIPqrLi8RYD2P3rzDiPfhgmKohKvflOBC/sCly1wWA1r2/syJteQPZcslqfliX30olCyfLbQpDMHy5QG76ViJWKErArAYUfQ923zlQjQGb3rpHb5/8c+1vU9VlS0UmaDdLd/WzZ0M2JTj7gfk+OY94A7g8oeesETXgfhuTo+qr1JHB2kXxIKGK7zBnlS8TUdNWRArsp4NC6H9HEhZ4OxNNMCjuNdfZzPeOsBIkMBJu9pzG4/vzQKMn//DUijm5JbVq88zclknGOqejM5n9NH4oUdZ3ARp04xSbiMcT/XvubtMAgupR6SngLB1m+zMyaOQjIr3qf+boFMz3BqZtHWzAu9UcNEiS3ljuOdrz+F+yVW0x9PMAkrFtRPy+Bapxaj5MwaPQDf4ppQT2yzp6rmY6hkyJ3ZGikk98EUvEed4k22QMOU0BA4pjrNcfJSXXoZO/P4MP2FavU129n+i8jwTRjZOS1x57tCOkI8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR10MB2434.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(136003)(39860400002)(346002)(66476007)(316002)(2616005)(66946007)(8936002)(66556008)(186003)(26005)(8676002)(83380400001)(86362001)(36756003)(478600001)(6486002)(31696002)(956004)(4326008)(2906002)(53546011)(16526019)(9686003)(6512007)(31686004)(110136005)(6506007)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N0tSVTdyczVtUXJmNGNiVFh2dkVoek5NSWtwR25Wb1kxWWlTQU1jeUJoUlN6?=
 =?utf-8?B?dHIvcXdnNzZFdzBGb0JNdVdUQndjZWVIdG8yQ0dETDhGNTMyM3Fhbys0SlNr?=
 =?utf-8?B?N2lwZDcxK3hMQk9FUFA0bVpzendMUzh6ZWpibytiRURxY3VBcWVZSXkwRllD?=
 =?utf-8?B?ckFzRFRsb1lkZFo5MXloaDQ3QUNnN1JPbEkwcFV2VGhIRkVyZFdFTnJ0dWJZ?=
 =?utf-8?B?dzdnTDcrQ0NLNDQwd1FwTlR3dEtTcS9RcFVGR0hOTzBFQ0RIT1dsTGtHSHhT?=
 =?utf-8?B?cTdCL202QWcvaWxmdkdMVHY2ZExoYmRFSU1IQkhaSG5iWDVsSUd3bmMxejRp?=
 =?utf-8?B?TEU3czdPQWtTalFUaEE1YUdCelF6S3ROWW5yNjhoNG80dEtFVHc3aXM5SENO?=
 =?utf-8?B?bHNQUitETGJIQlhHbzdsWDY5Z0E4SERuUkIzd1FJMkVwTEJxZkV5aExaaUtQ?=
 =?utf-8?B?WmlqcThPYjQ0Zzl0V25JQlZib3FES21PT2FiT1N5TVJvdmFyVEFDb2YxMHp2?=
 =?utf-8?B?eVltNTVvbUh4VmorOVlHbm41TTZab2lGZjhWSzhHcTZ5TEtNRXE2QThJVXpa?=
 =?utf-8?B?MVBuUGkycUJYbWdkZkwxWWxZT2NvL2hHSGRxdjNmZGVnVHdUZDA1V2dFNThZ?=
 =?utf-8?B?NW92YjdxZmlyb0lnKzRDOTExbXdqeE1qRzUxYncvUTd4ZGdHSmJJSS9TYjg5?=
 =?utf-8?B?TGgvNkUzYmhVbFA2aXM4WmF6MU9IYjJQNFJvaXFxRWR1RzFaY2s2VFZKRko2?=
 =?utf-8?B?U0ZIK1E1U25RbFRQdDRBTE5HM2drajg4WkM3Y1dPTDNkUFBWZkt3czBNejZN?=
 =?utf-8?B?bmM0NVd5QlB4aUhNQmhzT0EvdUlJUVNvL2FLOUtzUllMMXdmbDRBRmowRHRr?=
 =?utf-8?B?YXQ0NHNOY25pWmZqcUdoeDNseXBsVm5FUmhpQ3c4alNpQ09TcTRPVWNmaWJL?=
 =?utf-8?B?MXNVaXU0ZllzUE1ZRENuRzI0c2NWVVNkdzBNWFNWYmpOcUVPaDdUOUpXN2s5?=
 =?utf-8?B?ZFpxSm1pSUgyOENwRXFZcWxOREFYS2ZBc2psU1dUSno3Mk1IbHJqYXZlYldO?=
 =?utf-8?B?VlJDVlZIbnhzZGVlNE15dGUxWCtNSXN0RzFlYmdWZW9iaXFHb3hDSHhCTWto?=
 =?utf-8?B?Z3NhbFZXM1ZLZGZLZFlzYWFIdGNCV04wV1BKNEY3VURrSlZyL3BxdU9GT09s?=
 =?utf-8?B?QnZFRTBxSkJDUE1LL1k1aGMxSDJNOE45UVNPd1JMSFBEdENIc20xdzlodnNm?=
 =?utf-8?B?NFdqTklLNDJPeXFXR1Izbi8yUFZYUEZneXUvZ21rejcrbzBGT0RIcTg5L09v?=
 =?utf-8?B?Ulpjd2haN0hLMG5HR1dZRmNDSlVmQUFqMHY0WnpaMDIzUkFwQVo3YmlRa0tt?=
 =?utf-8?B?RXNUakswSzExYmx1WS9Bek50amQ4Z2R1TDFuWXBBNGdLZ3NUU3oxZzNTaVV2?=
 =?utf-8?B?dHhVcFdSSlh0dlZJQmY4L0RBRWxQT29iSTNFMjVKTHp0NnFGSVB5dktWS201?=
 =?utf-8?B?QmlQN084RjJ6SnFXZkNvQktSTFk0NmpoR1R2OVFsdUw1QzJyVDVNT0JSMG5n?=
 =?utf-8?B?RC8yNVVUT0Q1NWdyaUVCQ0lvZXFKYjh6bVVSUU0wNnUrWExHS25ERmNVSVdt?=
 =?utf-8?B?VENabjdQakdKbWkvRHRBdi9FSklKVDNrYm9LampMVDJYek1BWVl1ajBaUTVO?=
 =?utf-8?B?Z3JzRHVhZDBkMVFVTTVRZWFFeGhLZ3RGV3RDc25hZUFXblpTMmxURXg1d2cv?=
 =?utf-8?Q?5PBJ36dN4mpKcyPoOf0tAcKMBaScLjUPJjrDN/p?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b95d2b-6823-402a-9539-08d8d61f6bc9
X-MS-Exchange-CrossTenant-AuthSource: BN7PR10MB2434.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 04:16:12.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5ZAfgtMpbwPO228TEZCyurRH1TeXOw6v4fPeMQ9ZEhjmmEMsZIkBhA8y3RaKNwrnE/AOgBVP1cypRySZ0i44Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2435
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9901 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102210044
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9901 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102210044
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/20/21 6:08 AM, Olga Kornievskaia wrote:
> On Fri, Feb 19, 2021 at 10:21 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>> On Fri, Feb 19, 2021 at 05:31:58PM -0800, dai.ngo@oracle.com wrote:
>>> If this is the cause why we don't drop the mount after the copy
>>> then I can restore the patch and look into this problem. Unfortunately,
>>> all my test machines are down for maintenance until Sunday/Monday.
>> I think we can take some time to figure out what's actually going on
>> here before reverting anything.
> Yes I agree. We need to fix the use-after-free and also make sure that
> reference will go away. I'm assuming to reproduce the use-after-free I
> need to run with kazan, is that what you did Dai?

I did not use Kasan. I just did an inter-server copy and this message
showed up in /var/log/messages.

-Dai

>
>> --b.
>>
>>> -Dai
>>>
>>> On 2/19/21 5:09 PM, J. Bruce Fields wrote:
>>>> Dai, do you have a copy of the original use-after-free warning?
>>>>
>>>> --b.
>>>>
>>>> On Fri, Feb 19, 2021 at 07:18:53PM -0500, Olga Kornievskaia wrote:
>>>>> Hi Dai (Bruce),
>>>>>
>>>>> This patch is what broke the mount that's now left behind between the
>>>>> source server and the destination server. We are no longer dropping
>>>>> the necessary reference on the mount to go away. I haven't been paying
>>>>> as much attention as I should have been to the changes. The original
>>>>> code called fput(src) so a simple refcount of the file. Then things
>>>>> got complicated and moved to nfsd_file_put(). So I don't understand
>>>>> complexity. But we need to do some kind of put to decrement the needed
>>>>> reference on the superblock. Bruce any ideas? Can we go back to
>>>>> fput()?
>>>>>
>>>>> On Thu, Oct 29, 2020 at 3:08 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>> The source file nfsd_file is not constructed the same as other
>>>>>> nfsd_file's via nfsd_file_alloc. nfsd_file_put should not be
>>>>>> called to free the object; nfsd_file_put is not the inverse of
>>>>>> kzalloc, instead kfree is called by nfsd4_do_async_copy when done.
>>>>>>
>>>>>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>> ---
>>>>>>   fs/nfsd/nfs4proc.c | 2 +-
>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>> index ad2fa1a8e7ad..9c43cad7e408 100644
>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>> @@ -1299,7 +1299,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
>>>>>>                          struct nfsd_file *dst)
>>>>>>   {
>>>>>>          nfs42_ssc_close(src->nf_file);
>>>>>> -       nfsd_file_put(src);
>>>>>> +       /* 'src' is freed by nfsd4_do_async_copy */
>>>>>>          nfsd_file_put(dst);
>>>>>>          mntput(ss_mnt);
>>>>>>   }
>>>>>> --
>>>>>> 2.20.1.1226.g1595ea5.dirty
>>>>>>
