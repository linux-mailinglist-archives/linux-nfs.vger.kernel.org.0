Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116FB38119D
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 22:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhENUVC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 16:21:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62120 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229701AbhENUVB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 16:21:01 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14EKGWOO026627;
        Fri, 14 May 2021 20:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=iBUtvxbG2k3OSt2iDh0LXaAyIm8I23J9Jw3oZ5Qt2Pc=;
 b=gYZsW2cPH0eKTUBjTUhcFpWCFG5cwEHHom7yKW0HlZlDexzfPEs/8oEBndbpq0gZMnqL
 bX/UcqmsoKat3sK7uRn/hqS8dvgxKYCsqwJqKqitg72XGZqdMt2BZqGQEVxFTCP+7MJj
 h/2aDmzuxf5LoBjqW1KHZJtKG9eE5DW9Qrpz/LZ/HDjviMhPfJtq0sHCYWpZbmVIYiS/
 OEEfAd84UfA1tnOcQCtaB4IaBM9ShKi2ATf2GhrJr+AKQT4fEJ2r6Gzxm084zWHbVcrq
 Xf/8wEHYBHYdZXjF0oI3CskJEUndJWiuSr82CWewhGabSHjP2I/gRsQUNOtyd5+sReHz iQ== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38gpphru8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:19:46 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14EKItnQ122085;
        Fri, 14 May 2021 20:19:45 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by userp3020.oracle.com with ESMTP id 38gpphh1m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:19:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3s2oI2syl8JLF9dUniRza74eIdfMKSbZf6X9QebRsAcsZ04FrVqi5kW/s9qz5Dhlc3LG8KH2bLtWUtP2SUOZwZLZj1drL87gs7Fq4luZZStcp45G6+05u+htYJlogAquBcour3s+/sz3MGlSlJSwl4FSGvNQ4mrHowN2JIaKmclykkncb5XMGkInuq8Ea1d8Aiff7pfpFRy3IU+Z5X4stR7G0qPBqHnSJiA8l8zerbLWsCRqnyNaIXqTHmjWIyDN+bEhSWvld9ihetXJ3rOc/sAtI+nKrB8rbQ7HlymvySKCLwIviNu0f7R5ZuYjQIlcHImRmWRhAshorIsA/A4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBUtvxbG2k3OSt2iDh0LXaAyIm8I23J9Jw3oZ5Qt2Pc=;
 b=jyNsunfkhCHe83UoCBvUWFsQMa7kgxgYA1F0nFZMf+4qOuEe+Hh7hwzT5kva9MKD2ES30rNAlh48zHQnuxHSZmeZFWvjuVZ2nIDFnoKVQsZ762SqV3HKXmSLk1yGgnsyGyJTJnTFnBqJbpsTMFRozrU079zSAeazSCu8i8eZT2FO0j1LVJ4vywLgA/nPKPAv7L/KaliBg/4UzRvG2nwnUNZZkzxV7z5hWJ+amAR44MJjySvk7cI/zPA4eWwY11DCAACrEmr0jXw+wqEVHik5SptrypGXBV2ZR5/KFkpsjG9I4SeZdVA18jgSfr3LzELfhdii7AlqmC29j1erF08cxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBUtvxbG2k3OSt2iDh0LXaAyIm8I23J9Jw3oZ5Qt2Pc=;
 b=Am8gZSgrk1W5SILzOMLmcg3O65dV2aKx7yAGcf6kO+qW1Kven+fxSW/mK76dAOYj5f4CBU9Xl3jMl1n11Dn9p8LbdhO7j6BBcjmW5Pm2ADGGrvdrc9Kj7eSP6lN1/x7CSshUz9w5R5acTLFSmLthie5F396iRHHB487DeznFzm0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 20:19:43 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 20:19:43 +0000
Subject: Re: [PATCH v4 1/2] NFSD: delay unmount source's export after
 inter-server copy completed.
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <20210423205946.24407-1-dai.ngo@oracle.com>
 <20210423205946.24407-2-dai.ngo@oracle.com>
 <CAN-5tyGS9z1+So-MAiWEX-a6-qCGxzm_mW82dt4DTV2E-SBKtg@mail.gmail.com>
 <20210514184235.GA16955@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <6b6cb87d-75fd-cc0d-5642-d8e65a897ed7@oracle.com>
Date:   Fri, 14 May 2021 13:19:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <20210514184235.GA16955@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SN7PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:806:f2::18) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-137-176.vpn.oracle.com (72.219.112.78) by SN7PR04CA0013.namprd04.prod.outlook.com (2603:10b6:806:f2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 14 May 2021 20:19:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58e5fa4f-7996-413b-0d2d-08d917159c60
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44298F42E804A84EF787A0F987509@SJ0PR10MB4429.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kC2TLXsEwDkrR0nnt0RPo6tiaZRz/b2C3FTof2FcHXHcN+3S/Y1SphoIQAdDAvX/KJiBlMuefIaF3QnlZeKgPpXhiYgXX2PwXjFxhZjmPAUYJZjidMR3tFHsq1f+TmWmxkJKpLKh+tfI63ASllfTPrB4U06YVODB6+0bY+NAw8YY2VnTtrYY+sC24xr/z5mU0w1tjaLH9gkq6SMjozyAe0JyjCOSoKjQcyAKOJSkKwR1DaR/x9O09GrmNBvcnuT1bbYamDU7fy0BKV32T80LTmLVYIwQjvvyVpU1NYERbl/35dTNdedv4ft9ldKLzePs/1mfk3BJ7nunO/i2rX4JWsfdO5xFZ3SvkKdtWonT4b+CbAV7qX569LrzRYe5jrUE9VZT+05A820aMlRbdgZMOxDI09wht/w9drV553DNti7MBmCjxrYEEUFT/WzDUpdFhPweJQqs1dcCCiR+Ia5/dDdWMGc0eJonDGu21YmZWF8nEveMN/yqYd4cXzpEBIsExdBeyhnh7UiK/yRfHR/0b/caukUxUt/Y2QSQ0WVWGpCV3vox21qSkVM7GtDqY2J6onj1H2ycQCv6JquL5PEZnRxYB2UHoXgojx8RHJW7+gGZsVcxREEWS4vEi9DoDDr/mhYYuixkeBITw8bRhnHz9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(39860400002)(366004)(9686003)(66946007)(186003)(6486002)(16526019)(66476007)(66556008)(4326008)(5660300002)(36756003)(31696002)(8936002)(2906002)(83380400001)(31686004)(2616005)(26005)(316002)(478600001)(8676002)(110136005)(956004)(54906003)(86362001)(53546011)(38100700002)(7696005)(30864003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c0lneFc4bDI1K3AzbHRnRHZ0M0REaEJCQ3RHRG9rM3JaT3RGZW12WVNCcnlI?=
 =?utf-8?B?U01WM1B6cU8rQVhoVFBZTjgvRTZ5MFRzVVlicEpHZ0dJblptWDl0aWo0V1BC?=
 =?utf-8?B?RWpXMlQvcDVTU0lWcFRIZVA5NDFPTnZ0L2NXblg3R3FPVDlsVWJ0LzJScnQz?=
 =?utf-8?B?TEhYRVpXek92NW9MUUpMUGVTbHErdzlQeUR6NEZ6dUd0SlpFN3FwVTBxcjh1?=
 =?utf-8?B?emZkd2hZTE5SRExJQU5uRjF0VVo3N0l5NEFIYVVjK0h4a3JOTzU0eUxzckph?=
 =?utf-8?B?NFUzSzdFdlp6NHBTSnhkTHU3U3VDbVRianZvNnAvdWJhK1g4UGN3dDFKNlU5?=
 =?utf-8?B?NEJGNGE0REw5Z1hwSXJCdzBoOStrL3EwZUR6cllOcytCTUVFQ2lya05hOGVB?=
 =?utf-8?B?K29icTRaU045UFlkSXFYRHBBVVZ3SjR5WHk2MU54L1psejhWV25wRXRHeElu?=
 =?utf-8?B?V1Z1L01pNjRFWncxOHV0QWhkQWZQR3VYVjZKeG9aKyt4ZlJmWHEzcWJ1ZUZi?=
 =?utf-8?B?YWp4RHlLY1NmWlRDY3FUNXd2NmYwV3lTdHk1a29GUTN6UWdueit5ZmdaK1JW?=
 =?utf-8?B?akx6Q3FHVjlMR29SVmh3SUoyYXVuU0ZEYTFsTGdRUmlCZTJKNSsyTHp3TVlB?=
 =?utf-8?B?eTV2bUkvdEgyWEVFeTRGZGpOUjBzOTN3MERySWFpVzZ1UFpNaHd6aCtQQ2k3?=
 =?utf-8?B?ZGN6cU8yRnJHSW1pZlpHTXJOd2JrbW9IRFdiNUNQYlZtR1F2bDVYbWE2U0tJ?=
 =?utf-8?B?YTNONTBReFRQSU5Pbi9ZYmhZdlBTdUJqUm1DdE0yNm13UFBEelgwVlFuZUVv?=
 =?utf-8?B?Tks5WjY3M2g2RURXc3RGUFVlOG1xOHR0T1IwNW9CdkM4QnZqeEc3eUMwd3pV?=
 =?utf-8?B?MERyOEVKWWFRekJBZWVmVGlDaGQ2TzRRSUZPanU0ZGRIRlJzcU14ckdITDNH?=
 =?utf-8?B?L0wvKzRTTTd4ckE1V3ZTb1pQVWVSV1VlVFFNUVZabGhyMlNrNHdCQ2pROHFB?=
 =?utf-8?B?TnI2eDVFM0trNHZ5NGFtdHc4S0t6Z1B0RCt1cWQzZnZJZmFoNE0xU1NMY1Fh?=
 =?utf-8?B?SlhQb1FDL1N4VGpvZ1Y5Q2dvbkozaWJNNXBzaHF1THd3bC8yNkJwR2w1N2tR?=
 =?utf-8?B?alZSNmp2cVhhNFFtZmhKZXVlUkVhdnhzVmU3bUR2d2JkWlM1WithL3dWYkky?=
 =?utf-8?B?c29FN0RTU0N5VnNxbGZrUExlMkNTMUVIakloRHN5M3NiWGcrRDVkaDQyVTF1?=
 =?utf-8?B?YlE2c2RjNS83NEE2VFY4UndjVWF1Nlc2NjFaVUtYWEpMTGQ4b2N4MVY5Y2Ir?=
 =?utf-8?B?b3BKRHQ5REV0clVTRmQ1NmRFVDV4aEM1cXJSM2Z5MG5ULzNrdDVKSzI4NmFl?=
 =?utf-8?B?ZGFBaGY1UWY5cFNuQzg1dDloR1l4MUxDb1IxWmJGOFFUazBSQ1ExNjR2SkhB?=
 =?utf-8?B?UytPOU02SzhsUTFmcVJIQnZzWUEvdEtZZWN1T3dWd2I3S3NuRjJYbHlnYTVK?=
 =?utf-8?B?U1dYZ2NVT1U4TkU2UTZ2dGJGVExHNGozT2NqbHI4QlpiT3VpbEQxTDc3aUNN?=
 =?utf-8?B?akRMQ2YvYVBIYUFBQ2l4Rmcza3hiWU5BSVJiZkdCL0IrQUprckJXbitGaVJz?=
 =?utf-8?B?ZGc4dkNTcDJVZU44S2Q5V0g4MlJxdlRLdFRmand1ZVR4enExTVFkVjZHQmlK?=
 =?utf-8?B?amQ3K0hUbzJjM0grYkwreE5UVytzTHRUUElEYS8vQU4rSmNVbFo4MnhkZ0h0?=
 =?utf-8?Q?jghVdhtiq7Ui98tS5q9DsiwyO4uZ3rvTfEuM4wV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e5fa4f-7996-413b-0d2d-08d917159c60
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 20:19:43.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkgSMXcCVO/f9WngKgIzd+jNJW6XgiqMEObet6ozJz/QTff/dgUvjqAHL/RdFGdLsh5IJTpCF/7tEiJid5LWbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4429
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140161
X-Proofpoint-ORIG-GUID: AcpS0r2lo9r2FhxJA8HnV6RU2kQ5hDTH
X-Proofpoint-GUID: AcpS0r2lo9r2FhxJA8HnV6RU2kQ5hDTH
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 5/14/21 11:42 AM, J. Bruce Fields wrote:
> On Fri, May 14, 2021 at 02:12:38PM -0400, Olga Kornievskaia wrote:
>> On Fri, Apr 23, 2021 at 4:59 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>>> Currently the source's export is mounted and unmounted on every
>>> inter-server copy operation. This patch is an enhancement to delay
>>> the unmount of the source export for a certain period of time to
>>> eliminate the mount and unmount overhead on subsequent copy operations.
>>>
>>> After a copy operation completes, a delayed task is scheduled to
>>> unmount the export after a configurable idle time. Each time the
>>> export is being used again, its expire time is extended to allow
>>> the export to remain mounted.
>>>
>>> The unmount task and the mount operation of the copy request are
>>> synced to make sure the export is not unmounted while it's being
>>> used.
>>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>   fs/nfsd/nfs4proc.c      | 178 ++++++++++++++++++++++++++++++++++++++++++++++--
>>>   fs/nfsd/nfsd.h          |   4 ++
>>>   fs/nfsd/nfssvc.c        |   3 +
>>>   include/linux/nfs_ssc.h |  20 ++++++
>>>   4 files changed, 201 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index dd9f38d072dd..a4b110cbcab5 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -55,6 +55,81 @@ module_param(inter_copy_offload_enable, bool, 0644);
>>>   MODULE_PARM_DESC(inter_copy_offload_enable,
>>>                   "Enable inter server to server copy offload. Default: false");
>>>
>>> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
>>> +static int nfsd4_ssc_umount_timeout = 900000;          /* default to 15 mins */
>>> +module_param(nfsd4_ssc_umount_timeout, int, 0644);
>>> +MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
>>> +               "idle msecs before unmount export from source server");
>>> +
>>> +static void nfsd4_ssc_expire_umount(struct work_struct *work);
>>> +static struct nfsd4_ssc_umount nfsd4_ssc_umount;
>>> +
>>> +/* nfsd4_ssc_umount.nsu_lock must be held */
>>> +static void nfsd4_scc_update_umnt_timo(void)
>>> +{
>>> +       struct nfsd4_ssc_umount_item *ni = 0;
>>> +
>>> +       cancel_delayed_work(&nfsd4_ssc_umount.nsu_umount_work);
>>> +       if (!list_empty(&nfsd4_ssc_umount.nsu_list)) {
>>> +               ni = list_first_entry(&nfsd4_ssc_umount.nsu_list,
>>> +                       struct nfsd4_ssc_umount_item, nsui_list);
>>> +               nfsd4_ssc_umount.nsu_expire = ni->nsui_expire;
>>> +               schedule_delayed_work(&nfsd4_ssc_umount.nsu_umount_work,
>>> +                       ni->nsui_expire - jiffies);
>>> +       } else
>>> +               nfsd4_ssc_umount.nsu_expire = 0;
>>> +}
>>> +
>>> +static void nfsd4_ssc_expire_umount(struct work_struct *work)
>>> +{
>>> +       bool do_wakeup = false;
>>> +       struct nfsd4_ssc_umount_item *ni = 0;
>>> +       struct nfsd4_ssc_umount_item *tmp;
>>> +
>>> +       spin_lock(&nfsd4_ssc_umount.nsu_lock);
>>> +       list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list, nsui_list) {
>>> +               if (time_after(jiffies, ni->nsui_expire)) {
>>> +                       if (refcount_read(&ni->nsui_refcnt) > 0)
>>> +                               continue;
>>> +
>>> +                       /* mark being unmount */
>>> +                       ni->nsui_busy = true;
>>> +                       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>> +                       mntput(ni->nsui_vfsmount);
>>> +                       spin_lock(&nfsd4_ssc_umount.nsu_lock);
>>> +
>>> +                       /* waiters need to start from begin of list */
>>> +                       list_del(&ni->nsui_list);
>>> +                       kfree(ni);
>>> +
>>> +                       /* wakeup ssc_connect waiters */
>>> +                       do_wakeup = true;
>>> +                       continue;
>>> +               }
>>> +               break;
>> Wouldn't you be exiting your iteration loop as soon as you find a
>> delayed item that hasn't expired? What if other items on the list have
>> expired?
>>
>> It looks like the general design is that work for doing umount is
>> triggered by doing some copy, right? And then it just keeps
>> rescheduling itself? Shouldn't we just be using the laundrymat instead
>> that wakes up and goes thru the list mounts that are put to be
>> unmounted and does so? Bruce previously had suggested using laundrymat
>> for cleaning up copynotify states on the source server. But if the
>> existing approach works for Bruce, I'm ok with it too.
> I guess I'd prefer to use the laundromat, unless there's some reason to
> do this one differently.

I will look into the laundromat approach.  I try to avoid destabilizing
existing code by using separate mechanism for SSC.

>
> Also: on a quick skim, I don't see where this is shut down?  (If the
> server is shut down, or the module unloaded?)

Ah thanks! I completely miss this part. I will add this in v5 patch.

-Dai

>
> --b.
>
>>> +       }
>>> +       nfsd4_scc_update_umnt_timo();
>>> +       if (do_wakeup)
>>> +               wake_up_all(&nfsd4_ssc_umount.nsu_waitq);
>>> +       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>> +}
>>> +
>>> +static DECLARE_DELAYED_WORK(nfsd4, nfsd4_ssc_expire_umount);
>>> +
>>> +void nfsd4_ssc_init_umount_work(void)
>>> +{
>>> +       if (nfsd4_ssc_umount.nsu_inited)
>>> +               return;
>>> +       INIT_DELAYED_WORK(&nfsd4_ssc_umount.nsu_umount_work,
>>> +               nfsd4_ssc_expire_umount);
>>> +       INIT_LIST_HEAD(&nfsd4_ssc_umount.nsu_list);
>>> +       spin_lock_init(&nfsd4_ssc_umount.nsu_lock);
>>> +       init_waitqueue_head(&nfsd4_ssc_umount.nsu_waitq);
>>> +       nfsd4_ssc_umount.nsu_inited = true;
>>> +}
>>> +EXPORT_SYMBOL_GPL(nfsd4_ssc_init_umount_work);
>>> +#endif
>>> +
>>>   #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>>>   #include <linux/security.h>
>>>
>>> @@ -1181,6 +1256,9 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>          char *ipaddr, *dev_name, *raw_data;
>>>          int len, raw_len;
>>>          __be32 status = nfserr_inval;
>>> +       struct nfsd4_ssc_umount_item *ni = 0;
>>> +       struct nfsd4_ssc_umount_item *work, *tmp;
>>> +       DEFINE_WAIT(wait);
>>>
>>>          naddr = &nss->u.nl4_addr;
>>>          tmp_addrlen = rpc_uaddr2sockaddr(SVC_NET(rqstp), naddr->addr,
>>> @@ -1229,12 +1307,68 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>>                  goto out_free_rawdata;
>>>          snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
>>>
>>> +       work = kzalloc(sizeof(*work), GFP_KERNEL);
>>> +try_again:
>>> +       spin_lock(&nfsd4_ssc_umount.nsu_lock);
>>> +       list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list, nsui_list) {
>>> +               if (strncmp(ni->nsui_ipaddr, ipaddr, sizeof(ni->nsui_ipaddr)))
>>> +                       continue;
>>> +               /* found a match */
>>> +               if (ni->nsui_busy) {
>>> +                       /*  wait - and try again */
>>> +                       prepare_to_wait(&nfsd4_ssc_umount.nsu_waitq, &wait,
>>> +                               TASK_INTERRUPTIBLE);
>>> +                       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>> +
>>> +                       /* allow 20secs for mount/unmount for now - revisit */
>>> +                       if (signal_pending(current) ||
>>> +                                       (schedule_timeout(20*HZ) == 0)) {
>>> +                               status = nfserr_eagain;
>>> +                               kfree(work);
>>> +                               goto out_free_devname;
>>> +                       }
>>> +                       finish_wait(&nfsd4_ssc_umount.nsu_waitq, &wait);
>>> +                       goto try_again;
>>> +               }
>>> +               ss_mnt = ni->nsui_vfsmount;
>>> +               if (refcount_read(&ni->nsui_refcnt) == 0)
>>> +                       refcount_set(&ni->nsui_refcnt, 1);
>>> +               else
>>> +                       refcount_inc(&ni->nsui_refcnt);
>>> +               spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>> +               kfree(work);
>>> +               goto out_done;
>>> +       }
>>> +       /* create new entry, set busy, insert list, clear busy after mount */
>>> +       if (work) {
>>> +               strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
>>> +               refcount_set(&work->nsui_refcnt, 1);
>>> +               work->nsui_busy = true;
>>> +               list_add_tail(&work->nsui_list, &nfsd4_ssc_umount.nsu_list);
>>> +       }
>>> +       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>> +
>>>          /* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
>>>          ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
>>>          module_put(type->owner);
>>> -       if (IS_ERR(ss_mnt))
>>> +       if (IS_ERR(ss_mnt)) {
>>> +               if (work) {
>>> +                       spin_lock(&nfsd4_ssc_umount.nsu_lock);
>>> +                       list_del(&work->nsui_list);
>>> +                       wake_up_all(&nfsd4_ssc_umount.nsu_waitq);
>>> +                       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>> +                       kfree(work);
>>> +               }
>>>                  goto out_free_devname;
>>> -
>>> +       }
>>> +       if (work) {
>>> +               spin_lock(&nfsd4_ssc_umount.nsu_lock);
>>> +               work->nsui_vfsmount = ss_mnt;
>>> +               work->nsui_busy = false;
>>> +               wake_up_all(&nfsd4_ssc_umount.nsu_waitq);
>>> +               spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>> +       }
>>> +out_done:
>>>          status = 0;
>>>          *mount = ss_mnt;
>>>
>>> @@ -1301,10 +1435,46 @@ static void
>>>   nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
>>>                          struct nfsd_file *dst)
>>>   {
>>> +       bool found = false;
>>> +       bool resched = false;
>>> +       long timeout;
>>> +       struct nfsd4_ssc_umount_item *tmp;
>>> +       struct nfsd4_ssc_umount_item *ni = 0;
>>> +
>>>          nfs42_ssc_close(src->nf_file);
>>> -       fput(src->nf_file);
>>>          nfsd_file_put(dst);
>>> -       mntput(ss_mnt);
>>> +       fput(src->nf_file);
>>> +
>>> +       timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>>> +       spin_lock(&nfsd4_ssc_umount.nsu_lock);
>>> +       list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list,
>>> +               nsui_list) {
>>> +               if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
>>> +                       list_del(&ni->nsui_list);
>>> +                       /*
>>> +                        * vfsmount can be shared by multiple exports,
>>> +                        * decrement refcnt and schedule delayed task
>>> +                        * if it drops to 0.
>>> +                        */
>>> +                       if (refcount_dec_and_test(&ni->nsui_refcnt))
>>> +                               resched = true;
>>> +                       ni->nsui_expire = jiffies + timeout;
>>> +                       list_add_tail(&ni->nsui_list, &nfsd4_ssc_umount.nsu_list);
>>> +                       found = true;
>>> +                       break;
>>> +               }
>>> +       }
>>> +       if (!found) {
>>> +               spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>> +               mntput(ss_mnt);
>>> +               return;
>>> +       }
>>> +       if (resched && !nfsd4_ssc_umount.nsu_expire) {
>>> +               nfsd4_ssc_umount.nsu_expire = ni->nsui_expire;
>>> +               schedule_delayed_work(&nfsd4_ssc_umount.nsu_umount_work,
>>> +                               timeout);
>>> +       }
>>> +       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>>   }
>>>
>>>   #else /* CONFIG_NFSD_V4_2_INTER_SSC */
>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>> index 8bdc37aa2c2e..b3bf8a5f4472 100644
>>> --- a/fs/nfsd/nfsd.h
>>> +++ b/fs/nfsd/nfsd.h
>>> @@ -483,6 +483,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
>>>   extern int nfsd4_is_junction(struct dentry *dentry);
>>>   extern int register_cld_notifier(void);
>>>   extern void unregister_cld_notifier(void);
>>> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
>>> +extern void nfsd4_ssc_init_umount_work(void);
>>> +#endif
>>> +
>>>   #else /* CONFIG_NFSD_V4 */
>>>   static inline int nfsd4_is_junction(struct dentry *dentry)
>>>   {
>>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>>> index 6de406322106..2558db55b88b 100644
>>> --- a/fs/nfsd/nfssvc.c
>>> +++ b/fs/nfsd/nfssvc.c
>>> @@ -322,6 +322,9 @@ static int nfsd_startup_generic(int nrservs)
>>>          ret = nfs4_state_start();
>>>          if (ret)
>>>                  goto out_file_cache;
>>> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
>>> +       nfsd4_ssc_init_umount_work();
>>> +#endif
>>>          return 0;
>>>
>>>   out_file_cache:
>>> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
>>> index f5ba0fbff72f..1e07be2a89fa 100644
>>> --- a/include/linux/nfs_ssc.h
>>> +++ b/include/linux/nfs_ssc.h
>>> @@ -8,6 +8,7 @@
>>>    */
>>>
>>>   #include <linux/nfs_fs.h>
>>> +#include <linux/sunrpc/svc.h>
>>>
>>>   extern struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
>>>
>>> @@ -52,6 +53,25 @@ static inline void nfs42_ssc_close(struct file *filep)
>>>          if (nfs_ssc_client_tbl.ssc_nfs4_ops)
>>>                  (*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
>>>   }
>>> +
>>> +struct nfsd4_ssc_umount_item {
>>> +       struct list_head nsui_list;
>>> +       bool nsui_busy;
>>> +       refcount_t nsui_refcnt;
>>> +       unsigned long nsui_expire;
>>> +       struct vfsmount *nsui_vfsmount;
>>> +       char nsui_ipaddr[RPC_MAX_ADDRBUFLEN];
>>> +};
>>> +
>>> +struct nfsd4_ssc_umount {
>>> +       struct list_head nsu_list;
>>> +       struct delayed_work nsu_umount_work;
>>> +       spinlock_t nsu_lock;
>>> +       unsigned long nsu_expire;
>>> +       wait_queue_head_t nsu_waitq;
>>> +       bool nsu_inited;
>>> +};
>>> +
>>>   #endif
>>>
>>>   /*
>>> --
>>> 2.9.5
>>>
