Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F84321F35
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 19:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhBVSfL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 13:35:11 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54206 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhBVSe5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Feb 2021 13:34:57 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MIPNNp160265;
        Mon, 22 Feb 2021 18:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=A11AzF7M4NX971lw838d7Smrr6jpqsjojvgYqERteAs=;
 b=pVhVi6MWdzb8befwXlMeXXTXtkmtJPB2aHwj10rPon1/L3l62XAz3GXx/wb5/rRSc9kn
 tJhCvO0Qa0rCsgOuksoSSzoZf9dQwugu8tvrrbPFOmjXH1sD69H/YyNurVbw4FvnLd0B
 g6C0qBsrJSOrcU6euZQQN1Iu61nrAV9mxG1uuKlZ0HsKkLFB6zuGNMB4rR491y+jOAMc
 9BsJXiMKNE3Jrf90MpYfkTmNm5kkeAipcdJYhwpprp3PKMKLMLnQnXVhWV40lYNb+SY5
 v4q/QCUWcJg9LEbysh4xccuUGmhaNRdH0Wdmv953A4rrzGzDV/gPcUvTQs762vtnXJlD jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36tsuqvq20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 18:34:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MIQVin035310;
        Mon, 22 Feb 2021 18:34:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3020.oracle.com with ESMTP id 36ucaxdbv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 18:34:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbUUDSJ2BsNgwr6zDWNXz5QeB9m2OxiVnwM96+ViEcMDasSE6oy3UZcscp4TFUFDk3RG/CYNVjuiO5oSIRG2Y4K4d27zLTkE15pDlcfNyi7d+7n1Vh+X7zNa2Wg732TOkw+0VyD6TQp8/fYw8akExbCzd6wk1RIwfwI2z2h3M3DLbQyz3Outz+aSKJuQMGIidw8I8Ab9ftcTkYWxIX/xn8U3EQZPQt09lS9DYx3tHwniZwEckxpMQyKGy2p6mrgAE90f1AH2ol82NLRSfa5XmnD/2+Wngg3LM+8mu/1PW57IUD5FlmLV4qUQnM746GnxdEWI8OZialDmgpHmVhj6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A11AzF7M4NX971lw838d7Smrr6jpqsjojvgYqERteAs=;
 b=eBwOsYBFhP2L2wZ0yc5LmskCH11n5nH70B/M/W1G4g2X2QiACyXOBfV8ylonnCt2kk+r+Rs69NR7AnjW2KHDeQeaAZc1/PDyFvEK5Ri4vploRHZ4okPzBMnbjz61nHgkn181zpPs1x2nl8UgvuRgA3r88/4IPUeFIbLjYSO/0J6WKpEBmMDCJSknXcEg6p+KhZTPwvTSLoNsUNrNzc3nqJtIl8CMXNkHb70M0czZ50gTzvCAEuP6xP++/1N0tvzLQaQO2Kdrdk89CjyUorFyhVOJQsW9FDfMRK0OIu4JnXFb5nw34BJAU9tXquh/HvJtSUy21YiuBz5XVomB2r9RoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A11AzF7M4NX971lw838d7Smrr6jpqsjojvgYqERteAs=;
 b=RLakD5p2Deww3pzQYSXeIAH6Hwaffm9lQhKKwcdT+F/UBtm0B2pW1sYL5idAgTLPOxgE/LqCtO+DkG5LJpnhcA8v51r+Ry4Z6I/wE2nFotjVXgaklu9mnY7q+kLvim/OtsA6cNHqh8GGz5L9Sq5Ge6Ce2ci0eVZQxM5iTWzFIqk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4510.namprd10.prod.outlook.com (2603:10b6:a03:2d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Mon, 22 Feb
 2021 18:34:02 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8%6]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 18:34:02 +0000
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
Message-ID: <52e26138-0d3d-bd3c-6110-5a41e1fdf526@oracle.com>
Date:   Mon, 22 Feb 2021 10:34:00 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <ef11a2f9-f84b-7efc-ba5b-ca36c33d1825@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::11) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-137-111.vpn.oracle.com (72.219.112.78) by SJ0PR13CA0006.namprd13.prod.outlook.com (2603:10b6:a03:2c0::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Mon, 22 Feb 2021 18:34:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40f7081b-84f3-4b71-3158-08d8d7606d66
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4510:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45105C0B495C578CB4C55F9087819@SJ0PR10MB4510.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5SD726Sw2LaiLzOzX40YA25jSnbOhXB+prRYJuSRbm7ZUsGwURSV18x8EL+bAmmBPM8FKfG2LnydnnNNjvecCHlTIv2VPACEZoT2026N1euJWv/J6/6wdGaRUSNocN1UIfpXywwvHedsJD6roCqyQ4N6S29OdBdIL91PMdM2wh9LI3x13ghftNL5wvdIi1gY/v1jQQpTgsy8rVn66yf+FEE4lDYC0p9aohJrQ6aTcumQpTRXTCph97YljOP+3Dbs9TLalvcoAmLv/L3DKk46UUCaJl+I1C7wC75XBhBJtJskXpat2i//VAu+XSKVFt7tT04gsqADiGlD92otFC2I8CoVbIUlo0db/iVfB5NChvWrmHG7apGJ8XCCf1PE9/anKRgGsBTySmfg9J77gPWV2simu+CgtyFAhk4Z0QGCNyPVE5Uy8JYzmeF21+L91ra5Z3CbcTIUoJElvfiLi+GB6WJdG6LhGXKFpLviawrkd3XNc/PEfZYUbEV/syJQi46VtzMz0a/uX3LWTycmk5NP2Ml/Tini2wMOYMnV9rkbyBKW4lL2dcYvP/LAnlCBj+5Vy87SaXePKBYUmGoa7qSdtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(136003)(376002)(396003)(31696002)(36756003)(16526019)(6486002)(8936002)(53546011)(316002)(2616005)(478600001)(956004)(31686004)(4326008)(66946007)(5660300002)(7696005)(2906002)(26005)(8676002)(110136005)(66476007)(66556008)(186003)(86362001)(83380400001)(9686003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QkZMVHlCV2ptQmpkWkg1MkdmQldUV3EvSjhDUjhra1J2NHVFUjIycTY5VzRR?=
 =?utf-8?B?TlViR3JQZ1RNTXBkY2VHeW9ZQlkvN2RDYU9GemgzYTR3djlybnlnWmNrTjRK?=
 =?utf-8?B?d0dZZ0djSS9xb0RnRFJrK05ZMjFON0djcUFyanlJMkQ3bWVwOU5iUW1rSFlt?=
 =?utf-8?B?b01iNDZ0RENaN2ZqVmFWaHVoWUdmOGtpR2ZUZjdDZUQ2OCtCNU1zenFoM2ND?=
 =?utf-8?B?MG8yUlp1aG04Z3NRKzRiU21VU1kvLzhnYk9mMXROVXNyN25TZ1ZOaHgyT2hW?=
 =?utf-8?B?VXRhSzRWLzFaTGlGVnZmT3MwWFVraDZ3UzZmU0p0UlA4Rnp2ZWpTTW94RkNs?=
 =?utf-8?B?d3R3RmlzSzNiN2xwb1Nib0ZwWVI5WFpBSG96eW1LZXJQN0M0akpnd3ZRY0dx?=
 =?utf-8?B?SjRISmtqMkk1SC9ENlF4N2dwOEdkZEpzcWM4d28vMXR2cllYejhQY09Kd2RZ?=
 =?utf-8?B?ZkIwcE5FZ0gxWld6bTMzSVduOGh5cFJyRjVqdVdBSnp3M1pTbys5WkYwOW5B?=
 =?utf-8?B?cWg2QjlHZ2Z6WHh6bmZ3OXZ3OWlJSm9uS1lRVVczU1J1NStFVXhiMG9HRVJi?=
 =?utf-8?B?TzBxSHl1RCtDQzUwNHA3aDNrd1hqbVR2eC9Zb1RZTExkem9QNnJweGgyVURw?=
 =?utf-8?B?KzA3UStQNHZsdC9rRmxJdjF6Um0wdnBqakwwa0JjS2creGdnMXVId2JTVTRK?=
 =?utf-8?B?S1YrVVhkZS9Dd0xsTVdTZDlPVWVwbEFKdSs5ZzR1aFhucjFldURTMStML2Nx?=
 =?utf-8?B?SCtmR2p4OW9XcnJ0dGJWNGhhdWZxSVZhWGpyUmxLcnNLWUVhejhiZWVnS3VK?=
 =?utf-8?B?bTlwWnhSQ2ZSM2dEZkw3ZE5pT3RmQkRqT1Z3OW1kSDBKZVRPVitTSFVpREZN?=
 =?utf-8?B?MEhhSzBEeGd6clV2UlY1Rng0RWlkN2hBcmxrMDB0N3NvVnhrdGdDQVU2TUZ3?=
 =?utf-8?B?ZUxRQUVUNjlzOWMwcFMwSEtuUkhmS3RTMGhlaUVyWnF4WXNjRU54NWlBVko4?=
 =?utf-8?B?K0tZbFlYNU9iMlVONE9qWEFQSG9GUFEyUUQzcG1DRDE5VVp5RWloLzRTajFD?=
 =?utf-8?B?MThCSll0VG00M3RNeGgrbkt6TmY5bkI0aVBOcmFpam9oN2xlSUViaHNpNDdr?=
 =?utf-8?B?Q2hId3pvR3ovSXd2Z1kyL25ORXhPMi8yK2Y0bHEyWEtlR0Z4RE5JRnV6R3oy?=
 =?utf-8?B?Vyt0TUZQbFJKRUZzSHVqVlM4M1RPd0lESnJXV2sxaFk5Sk1rV1NKMS9wRFlt?=
 =?utf-8?B?aEw0TkFoaTBCZ2gyZ25ZaG82d2xNcFAycVNUV3FhVDdrWnZwNWdKbnY3VnNU?=
 =?utf-8?B?QWVoaE40NmZJQzlPaWptS3k0SDlIRDVMWmNrZXRla0I4dkVlOHkwYlZYOGp2?=
 =?utf-8?B?T1poS0txOHlPL2hiVVorL1dCVFZ2Sy9ZM0NwNTRod2FvNGNwMmd2aTRSQTE4?=
 =?utf-8?B?ZEhBTTVlbHI1akJmYXIvUFRFV0NoWmVSUEt6L0tVekl2VU9ibUhJZEJjMkZX?=
 =?utf-8?B?YWZmeGZ3eUtiRUtiTjRSUXFlNWZrMzhMY0oyVEVqbXV2NzlKL29OMzYxSzJO?=
 =?utf-8?B?U1Q4TkZUVVpwYUNENi94QVBkOW9ucm05UXE5OFFyUUJYbUpwR0JXNFRIT29w?=
 =?utf-8?B?NE93Sjg2ZDhVVXJhcWhMMktZb2JYZWFjOHNNRmk3U3Y5T1hENFFyaXg3QVZP?=
 =?utf-8?B?ZWdoRGppZnRrcUFIMFFVNzVEYjNkMk5LcVpJYjJkNE1QWHFLUmJMT21ySlZQ?=
 =?utf-8?Q?40mZ00ogOxx3v9A7+LalwR3CEweQouVmYRgU9JL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f7081b-84f3-4b71-3158-08d8d7606d66
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 18:34:02.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJqlNfTrm41cjYgTcjLJl13vhGR7tun1JopjJwh/O7Phr/jAysUbL9wylZnelLsIJnZYn9/fjnQ2G/sBDiQttA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4510
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220163
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220163
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/20/21 8:16 PM, dai.ngo@oracle.com wrote:
> On 2/20/21 6:08 AM, Olga Kornievskaia wrote:
>> On Fri, Feb 19, 2021 at 10:21 PM J. Bruce Fields 
>> <bfields@fieldses.org> wrote:
>>> On Fri, Feb 19, 2021 at 05:31:58PM -0800, dai.ngo@oracle.com wrote:
>>>> If this is the cause why we don't drop the mount after the copy
>>>> then I can restore the patch and look into this problem. 
>>>> Unfortunately,
>>>> all my test machines are down for maintenance until Sunday/Monday.
>>> I think we can take some time to figure out what's actually going on
>>> here before reverting anything.
>> Yes I agree. We need to fix the use-after-free and also make sure that
>> reference will go away. 

I reverted the patch, verified the warning message is back:

Feb 22 10:07:45 nfsvmf24 kernel: ------------[ cut here ]------------
Feb 22 10:07:45 nfsvmf24 kernel: refcount_t: underflow; use-after-free.

then did a inter-server copy and waited for more than 20 mins and
the destination server still maintains the session with the source
server.  It must be some other references that prevent the mount
to go away.

-Dai

>> I'm assuming to reproduce the use-after-free I
>> need to run with kazan, is that what you did Dai?
>
> I did not use Kasan. I just did an inter-server copy and this message
> showed up in /var/log/messages.
>
> -Dai
>
>>
>>> --b.
>>>
>>>> -Dai
>>>>
>>>> On 2/19/21 5:09 PM, J. Bruce Fields wrote:
>>>>> Dai, do you have a copy of the original use-after-free warning?
>>>>>
>>>>> --b.
>>>>>
>>>>> On Fri, Feb 19, 2021 at 07:18:53PM -0500, Olga Kornievskaia wrote:
>>>>>> Hi Dai (Bruce),
>>>>>>
>>>>>> This patch is what broke the mount that's now left behind between 
>>>>>> the
>>>>>> source server and the destination server. We are no longer dropping
>>>>>> the necessary reference on the mount to go away. I haven't been 
>>>>>> paying
>>>>>> as much attention as I should have been to the changes. The original
>>>>>> code called fput(src) so a simple refcount of the file. Then things
>>>>>> got complicated and moved to nfsd_file_put(). So I don't understand
>>>>>> complexity. But we need to do some kind of put to decrement the 
>>>>>> needed
>>>>>> reference on the superblock. Bruce any ideas? Can we go back to
>>>>>> fput()?
>>>>>>
>>>>>> On Thu, Oct 29, 2020 at 3:08 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>> The source file nfsd_file is not constructed the same as other
>>>>>>> nfsd_file's via nfsd_file_alloc. nfsd_file_put should not be
>>>>>>> called to free the object; nfsd_file_put is not the inverse of
>>>>>>> kzalloc, instead kfree is called by nfsd4_do_async_copy when done.
>>>>>>>
>>>>>>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>> ---
>>>>>>>   fs/nfsd/nfs4proc.c | 2 +-
>>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>> index ad2fa1a8e7ad..9c43cad7e408 100644
>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>> @@ -1299,7 +1299,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount 
>>>>>>> *ss_mnt, struct nfsd_file *src,
>>>>>>>                          struct nfsd_file *dst)
>>>>>>>   {
>>>>>>>          nfs42_ssc_close(src->nf_file);
>>>>>>> -       nfsd_file_put(src);
>>>>>>> +       /* 'src' is freed by nfsd4_do_async_copy */
>>>>>>>          nfsd_file_put(dst);
>>>>>>>          mntput(ss_mnt);
>>>>>>>   }
>>>>>>> -- 
>>>>>>> 2.20.1.1226.g1595ea5.dirty
>>>>>>>
