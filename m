Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14FE381164
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 22:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhENUKF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 16:10:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15688 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230426AbhENUKF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 16:10:05 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14EK71wR022409;
        Fri, 14 May 2021 20:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xX08vMoac7AGsPc+X8yjXEtKbkJtZAvCA0rRq1W5prw=;
 b=TzMlb4Xt3JXt6odlYwrBH2HICDUUVbP7emNNdjbfJQOaYLhHw/xqccRg+jeiPo8Lzdgs
 Tmms35X2VDG0caq71KKB7jVIXgTOaT/FNYJpoSZHwqOo+TzS+lRXJoLqFgVb2k9RSVcs
 er5xaHrJzfJwrJJGl9ANMwP88UpJcOqwY0lrm5zc7hbUyCiz2GbIgZ3vGc/wXyffuARJ
 dSbi7tWUMFgVYMNFIVsMD3my2UNLyu6spYrWyz+zcWQSwKzBZhmtSQ7zFje9+glmHr4i
 9KnlEr20I5mKCevR0P2OPHhbsHd0hA1wEs8sp/8ibbJ2OWajtyzwkLyK6jtE2SjrD/Gj iQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38gpqmgu4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:49 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14EK8m2u106137;
        Fri, 14 May 2021 20:08:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3020.oracle.com with ESMTP id 38gppf8cvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmbZt0oL+G4LM1+RB7vw2nQChRGYmh+0KXEh2yYRdD1nUxyKpOH2xI5Tho+mLrWpF5ySycwtGv+w6Mu5Nho+iR1gT74NDYlrmt2c5TEipQ1CvFHFpGBA5lBiDGT6NSV7hxmRmCxcZ4LOumEj2htgjwF4A/gxzmsGJflGHj88DjnloT5XzcW/kU+Z61TZ5dUI99QPfsTKwJl2KYciT6tKCee/wobfAd5oY+t4NZLfQnuAuwzcKruGG2aXaTanTn04kHTVM0pnkMpXo0UInA5n0+OaNplWJULLUQrImTGRR9+NQjyVViWUHUjt1DgcqbWL2XHGmv5Jqc4xiUlAr4gieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX08vMoac7AGsPc+X8yjXEtKbkJtZAvCA0rRq1W5prw=;
 b=AgzUmekyQKwLExLgysqJWluvfgFMLFw8OmDCLvRgLI6GX4fVeA5az7q3SbGxTxVNsiq5eSczW2SubvUsf9VAL/vfC84MAcnKSizZ2BRV+uMZP/kJOWbyGv/oDED81l0Uq6gsw2lmf4cbgwPOvwwIxN1GVfSlu2i5D49cVuzQMhEBZuQfpEQBcWEp9N5CZ0q1JSVUlqifghMwCuTvu/aXBz6xuTr+GSvqcOSXobZZBgTz9K3N5h5spkK+EHya7zzEOyKlGxuVGTGsQpfU6mx99KlCnBHI8TqL7THe/JZ7TYkutfrBdLSG5e84mXD6w4Nu0RhEIGlRqHCQrijAWsElgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX08vMoac7AGsPc+X8yjXEtKbkJtZAvCA0rRq1W5prw=;
 b=vBYbw5SmFujBW6XYDMpPMg0enXd4wqURKwFgzQOQ3WwzP6aS4t3s+Y3lZ7EIk8qKeFaCDHGWCtoDBx0FozyWuIYrqZr5GswxGGuycw6fzo80sbyPnF0Sc5ioWPoJ8BrzaVdmk0hSbhlNnSr//hAE387Kfu4zKujwbVX9uvFNoj0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB3955.namprd10.prod.outlook.com (2603:10b6:a03:1f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 20:08:45 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 20:08:45 +0000
Subject: Re: [PATCH v4 1/2] NFSD: delay unmount source's export after
 inter-server copy completed.
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <20210423205946.24407-1-dai.ngo@oracle.com>
 <20210423205946.24407-2-dai.ngo@oracle.com>
 <CAN-5tyGS9z1+So-MAiWEX-a6-qCGxzm_mW82dt4DTV2E-SBKtg@mail.gmail.com>
From:   dai.ngo@oracle.com
Message-ID: <82335254-1398-00df-ccfa-4b03172713cb@oracle.com>
Date:   Fri, 14 May 2021 13:08:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <CAN-5tyGS9z1+So-MAiWEX-a6-qCGxzm_mW82dt4DTV2E-SBKtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: BYAPR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::24) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-137-176.vpn.oracle.com (72.219.112.78) by BYAPR06CA0011.namprd06.prod.outlook.com (2603:10b6:a03:d4::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.32 via Frontend Transport; Fri, 14 May 2021 20:08:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4ae5d7e-200e-45f8-7084-08d917141451
X-MS-TrafficTypeDiagnostic: BY5PR10MB3955:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3955E06763E7BF2D53A0CA5987509@BY5PR10MB3955.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLAh6FBqErRwAwxJIYcR0vgSHARaPRMSHF6495u+/RbrTxU0F6eU90I9h7ywOYXAqxwFHuwEQe/evQFv/CnGEHo0dO3qosHMwmeLzvHOzRCEVgS2UdVb9gys0Aggj9AgPp9o2KCShZs4UY0nROX7tHyWCDy34HpvtUj1XfUYSIVinsQqqvuF1FhlfZHPijR4xbG0WICiIVQy6vM+CdwAsVfCeM15EMnFCdz8hGjJhRcCzNG/U2oefP9Y9vXSweHo6sk4X9tbYVJyST1pg6H0VJ/yD5XrgOVbJ6UVP0RRKXyU3rNOagV6Fsp4jm+6MMAxGaK6fsUmGSm3v+vmEz3EPAkudMzfgRVGkbKsXlmtHvqRuLn4oVGGQnV/SPeZ7xAsQIkE+TdOMLCg7ZKJWr9jUMAR1cjIlk3t5yloO1K+/2oC2MqlO+EyymYELuwTKyJwzCi3oKIkZKFx2F4qyJorVUm3qJc0J38FvwAQDCQ2VzQFlNTEqx7u2dcAfpEWzD8pEvPCjyKXr0XgAU/ysb5LdNvfgTvM/O7Bm+j2sPuE6KiXGmu8gExz++hUSjhcr8uGYTSufUDvUcLD3Kw9hV8qX1A6I5mpP0qVSDYN7nR/kkjNVC/eW3nX0M6Cid4lYF6eIfILEpam8gZlzxD+VylRfBbHGQVVC6W7xnlWrlHGiJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(7696005)(5660300002)(30864003)(53546011)(6486002)(83380400001)(31696002)(86362001)(31686004)(478600001)(36756003)(66476007)(66946007)(26005)(2906002)(54906003)(16526019)(6916009)(186003)(8676002)(316002)(38100700002)(9686003)(66556008)(8936002)(2616005)(956004)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ejNBM3pxZUNUS3IzcFhzSHpOZzMzTkVQblVQRERRZXVIaUlhTTcyQ1U2bW1B?=
 =?utf-8?B?K2plaHcxVEFZK2tCcVFhd3lISzJteUZ3cXFPSG1wY3daWm9UTzd5NE82ek5I?=
 =?utf-8?B?eUV6UWZCYkNlK0dtYTRBS0RaNEFLTHhPNFBJbUpYVUo5ZjBwek5jNy9ZSllo?=
 =?utf-8?B?VUlEU3paMk9wUDhBWGljdlRkejlDL2x5VTBTM2JUOElKVStCYm5YSWJvQVNU?=
 =?utf-8?B?eG9tZTZ5eGNNa1QvVExmeGIveG93STlsNVpST0VyRWFRVmF4OHFQalZzKyts?=
 =?utf-8?B?NnoyU3JKODB1QjhOcFMrWkY4eUtnT0w5UkxIL1orODU3M2p6TGc0eEtLQ1Fj?=
 =?utf-8?B?WkVoOHVTS1ZYK0VDVVV0dDFEUjNzeE5WTVdZNjFHRVcvWE1RL3QzQlhWWlBC?=
 =?utf-8?B?OU44akNWcXdzd3pHZXFYSnN6MUk4bWRmaHV6b3pUSHloSmJCbCs0VHg3TENy?=
 =?utf-8?B?R1ZHYlFoZklMOFZtRjExQkp4bi8vN0lpYVZzaDUzSytYOVNKTkxvczRiaU9H?=
 =?utf-8?B?aVFUV20xZ0dvU1d0b0pEbFpnUzU3dmx1Qksra1Y0cDVLTFhKbWlOVWhybU42?=
 =?utf-8?B?dmpNb05Ga2w4UDk2UVJNc1c0SlNiTTlqY3ovMDdDRC9FajA5ZHl3dzlzcjZZ?=
 =?utf-8?B?dUdGOUttZzBlSzN3TWZQTFJpT05oYXhvNFpOeGhOTHM4dmt1QWhlQTMzTU11?=
 =?utf-8?B?eDlFRmRRSjMwcmxrRUdWSU5SV1ErMHpYdi9lenBzYVFrREpNdmtLMkVSMG5x?=
 =?utf-8?B?cTJmZUZSMzBnaERENlAyMU9xRmU4bVdrMlBYcHptMCtrdDZWMDdpeTFDRWcr?=
 =?utf-8?B?R1M1SHJDaWFraDNvSzJJbDNtSGlvSkkxa3Z2cmpWVFJBN0laSWgxN1FmNFFK?=
 =?utf-8?B?OU1aY0lnYklPR1Badjg3dlh6OENlUFVSd1VqOXMwNmdXVC9LalVNSDZRdFNt?=
 =?utf-8?B?ZktodjMwem5lTnUxSTFLTkM3UlNCV3JFdTRjR3VvOHFNRDRrUHY0K0dOU3Ry?=
 =?utf-8?B?ekJ3ZUQ5d1dLaVU4RHZiOXROQUJHK3lURTdtMlMwTVhKWlV2aHRlSHcxYmxO?=
 =?utf-8?B?RTRuV2ZZbHhZTXBYZk14OWwvZ0syc1dLMW05SU1NVGlEcnMxdi9NeElMd0pT?=
 =?utf-8?B?M2VjWGVZTEFZZ2dlZzZYcTFISlZXVVFJV2RNbExkT2RrUGI1UG5aM0hpMUtW?=
 =?utf-8?B?NjY1enNMQm9IcC9GQ1RRdjFtU25ReHBSU2tFS2pHWFZiV1J6VTQ4WlBqMHhI?=
 =?utf-8?B?Q0l1ZWI0WVNuZ3RKcW9nM3BEQVQ2dFR0L1hnbW5LVmtwQllaZTBMT0RkYWtO?=
 =?utf-8?B?djNWSmhSOW9SVlZ2dVdvd2dOUzRtVU9pZ2RWZytlelpVUVJiMDc0bnZ0d1BK?=
 =?utf-8?B?YnF3MU5OajZiNDVFYjdjY0p6a3l0ZjM3NWxTS2tEN1NtRForMEtsV1FOa0tZ?=
 =?utf-8?B?ZnBOVUZIQnlHM3YxSlpFVEo2MTVtM0JheWF3dFJ3TUhlNG1SakNUa3VNbkJE?=
 =?utf-8?B?THpkYUZ3d1l1YjA2bDFYV0xaVitnSjFCVWd2S1VyYVFLd2M4cmhHdzc5Wml0?=
 =?utf-8?B?cFkwZ3ROVTNWRUZyYm91dGI4bVc0V2huNHZ3RmFqaFlzNG9VZnZwQWdjcmky?=
 =?utf-8?B?eUVnNnYwb2pIaGlQeEpVNWFLM0cxSDN5N1BTNWo0TlFGaFFuM01xMXN6K05Z?=
 =?utf-8?B?OEhUcjFYbEF6MlF6L1ZSRU1tVmlqSUgrU3JJMjlBVXNnWnFEZDFzM3VRQ3lk?=
 =?utf-8?Q?rR9Tkf4ysfUI38hQD/zozOmdb/qUwBWblKJBSYB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ae5d7e-200e-45f8-7084-08d917141451
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 20:08:45.8656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOKiDhyDSOcOfly/b2mxrbloLQ92cEYQhlrm0QI3JIpCSfxldf5tAElSh7ZU9riIeNdRrK2iMjZmPm18zVZFig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3955
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140159
X-Proofpoint-GUID: V7V3q5HimMouWYX5NL9uoc90NHu5Zw4T
X-Proofpoint-ORIG-GUID: V7V3q5HimMouWYX5NL9uoc90NHu5Zw4T
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 5/14/21 11:12 AM, Olga Kornievskaia wrote:
> On Fri, Apr 23, 2021 at 4:59 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>> Currently the source's export is mounted and unmounted on every
>> inter-server copy operation. This patch is an enhancement to delay
>> the unmount of the source export for a certain period of time to
>> eliminate the mount and unmount overhead on subsequent copy operations.
>>
>> After a copy operation completes, a delayed task is scheduled to
>> unmount the export after a configurable idle time. Each time the
>> export is being used again, its expire time is extended to allow
>> the export to remain mounted.
>>
>> The unmount task and the mount operation of the copy request are
>> synced to make sure the export is not unmounted while it's being
>> used.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4proc.c      | 178 ++++++++++++++++++++++++++++++++++++++++++++++--
>>   fs/nfsd/nfsd.h          |   4 ++
>>   fs/nfsd/nfssvc.c        |   3 +
>>   include/linux/nfs_ssc.h |  20 ++++++
>>   4 files changed, 201 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index dd9f38d072dd..a4b110cbcab5 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -55,6 +55,81 @@ module_param(inter_copy_offload_enable, bool, 0644);
>>   MODULE_PARM_DESC(inter_copy_offload_enable,
>>                   "Enable inter server to server copy offload. Default: false");
>>
>> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
>> +static int nfsd4_ssc_umount_timeout = 900000;          /* default to 15 mins */
>> +module_param(nfsd4_ssc_umount_timeout, int, 0644);
>> +MODULE_PARM_DESC(nfsd4_ssc_umount_timeout,
>> +               "idle msecs before unmount export from source server");
>> +
>> +static void nfsd4_ssc_expire_umount(struct work_struct *work);
>> +static struct nfsd4_ssc_umount nfsd4_ssc_umount;
>> +
>> +/* nfsd4_ssc_umount.nsu_lock must be held */
>> +static void nfsd4_scc_update_umnt_timo(void)
>> +{
>> +       struct nfsd4_ssc_umount_item *ni = 0;
>> +
>> +       cancel_delayed_work(&nfsd4_ssc_umount.nsu_umount_work);
>> +       if (!list_empty(&nfsd4_ssc_umount.nsu_list)) {
>> +               ni = list_first_entry(&nfsd4_ssc_umount.nsu_list,
>> +                       struct nfsd4_ssc_umount_item, nsui_list);
>> +               nfsd4_ssc_umount.nsu_expire = ni->nsui_expire;
>> +               schedule_delayed_work(&nfsd4_ssc_umount.nsu_umount_work,
>> +                       ni->nsui_expire - jiffies);
>> +       } else
>> +               nfsd4_ssc_umount.nsu_expire = 0;
>> +}
>> +
>> +static void nfsd4_ssc_expire_umount(struct work_struct *work)
>> +{
>> +       bool do_wakeup = false;
>> +       struct nfsd4_ssc_umount_item *ni = 0;
>> +       struct nfsd4_ssc_umount_item *tmp;
>> +
>> +       spin_lock(&nfsd4_ssc_umount.nsu_lock);
>> +       list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list, nsui_list) {
>> +               if (time_after(jiffies, ni->nsui_expire)) {
>> +                       if (refcount_read(&ni->nsui_refcnt) > 0)
>> +                               continue;
>> +
>> +                       /* mark being unmount */
>> +                       ni->nsui_busy = true;
>> +                       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>> +                       mntput(ni->nsui_vfsmount);
>> +                       spin_lock(&nfsd4_ssc_umount.nsu_lock);
>> +
>> +                       /* waiters need to start from begin of list */
>> +                       list_del(&ni->nsui_list);
>> +                       kfree(ni);
>> +
>> +                       /* wakeup ssc_connect waiters */
>> +                       do_wakeup = true;
>> +                       continue;
>> +               }
>> +               break;
> Wouldn't you be exiting your iteration loop as soon as you find a
> delayed item that hasn't expired?

Yes, the code exits the loop as soon it finds an item that hasn't expired.

>   What if other items on the list have
> expired?

All expired items are processed in the loop. The loop terminates when
an unexpired item is encountered. Work items are inserted at the tail
of the list so I don't think it will miss any item here.

>
> It looks like the general design is that work for doing umount is
> triggered by doing some copy, right?

After a copy is done, its work item is removed from the work list, its
expired time is set then it's re-inserted to the tail of list and the
delayed task is scheduled if one is not already scheduled.

> And then it just keeps
> rescheduling itself?

When the delayed task runs, it processes all expired items and only
reschedules itself again if there are still items in the list. The
delayed task only exists if there are works. So there is no overhead
or any resources consumed when SSC is not used or after all inter-copy
were completed for awhile.

> Shouldn't we just be using the laundrymat instead
> that wakes up and goes thru the list mounts that are put to be
> unmounted and does so? Bruce previously had suggested using laundrymat
> for cleaning up copynotify states on the source server. But if the
> existing approach works for Bruce, I'm ok with it too.

I can look into the laundrymat if you think there are advantages
with that approach.

-Dai

>
>> +       }
>> +       nfsd4_scc_update_umnt_timo();
>> +       if (do_wakeup)
>> +               wake_up_all(&nfsd4_ssc_umount.nsu_waitq);
>> +       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>> +}
>> +
>> +static DECLARE_DELAYED_WORK(nfsd4, nfsd4_ssc_expire_umount);
>> +
>> +void nfsd4_ssc_init_umount_work(void)
>> +{
>> +       if (nfsd4_ssc_umount.nsu_inited)
>> +               return;
>> +       INIT_DELAYED_WORK(&nfsd4_ssc_umount.nsu_umount_work,
>> +               nfsd4_ssc_expire_umount);
>> +       INIT_LIST_HEAD(&nfsd4_ssc_umount.nsu_list);
>> +       spin_lock_init(&nfsd4_ssc_umount.nsu_lock);
>> +       init_waitqueue_head(&nfsd4_ssc_umount.nsu_waitq);
>> +       nfsd4_ssc_umount.nsu_inited = true;
>> +}
>> +EXPORT_SYMBOL_GPL(nfsd4_ssc_init_umount_work);
>> +#endif
>> +
>>   #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>>   #include <linux/security.h>
>>
>> @@ -1181,6 +1256,9 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>          char *ipaddr, *dev_name, *raw_data;
>>          int len, raw_len;
>>          __be32 status = nfserr_inval;
>> +       struct nfsd4_ssc_umount_item *ni = 0;
>> +       struct nfsd4_ssc_umount_item *work, *tmp;
>> +       DEFINE_WAIT(wait);
>>
>>          naddr = &nss->u.nl4_addr;
>>          tmp_addrlen = rpc_uaddr2sockaddr(SVC_NET(rqstp), naddr->addr,
>> @@ -1229,12 +1307,68 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>                  goto out_free_rawdata;
>>          snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
>>
>> +       work = kzalloc(sizeof(*work), GFP_KERNEL);
>> +try_again:
>> +       spin_lock(&nfsd4_ssc_umount.nsu_lock);
>> +       list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list, nsui_list) {
>> +               if (strncmp(ni->nsui_ipaddr, ipaddr, sizeof(ni->nsui_ipaddr)))
>> +                       continue;
>> +               /* found a match */
>> +               if (ni->nsui_busy) {
>> +                       /*  wait - and try again */
>> +                       prepare_to_wait(&nfsd4_ssc_umount.nsu_waitq, &wait,
>> +                               TASK_INTERRUPTIBLE);
>> +                       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>> +
>> +                       /* allow 20secs for mount/unmount for now - revisit */
>> +                       if (signal_pending(current) ||
>> +                                       (schedule_timeout(20*HZ) == 0)) {
>> +                               status = nfserr_eagain;
>> +                               kfree(work);
>> +                               goto out_free_devname;
>> +                       }
>> +                       finish_wait(&nfsd4_ssc_umount.nsu_waitq, &wait);
>> +                       goto try_again;
>> +               }
>> +               ss_mnt = ni->nsui_vfsmount;
>> +               if (refcount_read(&ni->nsui_refcnt) == 0)
>> +                       refcount_set(&ni->nsui_refcnt, 1);
>> +               else
>> +                       refcount_inc(&ni->nsui_refcnt);
>> +               spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>> +               kfree(work);
>> +               goto out_done;
>> +       }
>> +       /* create new entry, set busy, insert list, clear busy after mount */
>> +       if (work) {
>> +               strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
>> +               refcount_set(&work->nsui_refcnt, 1);
>> +               work->nsui_busy = true;
>> +               list_add_tail(&work->nsui_list, &nfsd4_ssc_umount.nsu_list);
>> +       }
>> +       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>> +
>>          /* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
>>          ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
>>          module_put(type->owner);
>> -       if (IS_ERR(ss_mnt))
>> +       if (IS_ERR(ss_mnt)) {
>> +               if (work) {
>> +                       spin_lock(&nfsd4_ssc_umount.nsu_lock);
>> +                       list_del(&work->nsui_list);
>> +                       wake_up_all(&nfsd4_ssc_umount.nsu_waitq);
>> +                       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>> +                       kfree(work);
>> +               }
>>                  goto out_free_devname;
>> -
>> +       }
>> +       if (work) {
>> +               spin_lock(&nfsd4_ssc_umount.nsu_lock);
>> +               work->nsui_vfsmount = ss_mnt;
>> +               work->nsui_busy = false;
>> +               wake_up_all(&nfsd4_ssc_umount.nsu_waitq);
>> +               spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>> +       }
>> +out_done:
>>          status = 0;
>>          *mount = ss_mnt;
>>
>> @@ -1301,10 +1435,46 @@ static void
>>   nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
>>                          struct nfsd_file *dst)
>>   {
>> +       bool found = false;
>> +       bool resched = false;
>> +       long timeout;
>> +       struct nfsd4_ssc_umount_item *tmp;
>> +       struct nfsd4_ssc_umount_item *ni = 0;
>> +
>>          nfs42_ssc_close(src->nf_file);
>> -       fput(src->nf_file);
>>          nfsd_file_put(dst);
>> -       mntput(ss_mnt);
>> +       fput(src->nf_file);
>> +
>> +       timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>> +       spin_lock(&nfsd4_ssc_umount.nsu_lock);
>> +       list_for_each_entry_safe(ni, tmp, &nfsd4_ssc_umount.nsu_list,
>> +               nsui_list) {
>> +               if (ni->nsui_vfsmount->mnt_sb == ss_mnt->mnt_sb) {
>> +                       list_del(&ni->nsui_list);
>> +                       /*
>> +                        * vfsmount can be shared by multiple exports,
>> +                        * decrement refcnt and schedule delayed task
>> +                        * if it drops to 0.
>> +                        */
>> +                       if (refcount_dec_and_test(&ni->nsui_refcnt))
>> +                               resched = true;
>> +                       ni->nsui_expire = jiffies + timeout;
>> +                       list_add_tail(&ni->nsui_list, &nfsd4_ssc_umount.nsu_list);
>> +                       found = true;
>> +                       break;
>> +               }
>> +       }
>> +       if (!found) {
>> +               spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>> +               mntput(ss_mnt);
>> +               return;
>> +       }
>> +       if (resched && !nfsd4_ssc_umount.nsu_expire) {
>> +               nfsd4_ssc_umount.nsu_expire = ni->nsui_expire;
>> +               schedule_delayed_work(&nfsd4_ssc_umount.nsu_umount_work,
>> +                               timeout);
>> +       }
>> +       spin_unlock(&nfsd4_ssc_umount.nsu_lock);
>>   }
>>
>>   #else /* CONFIG_NFSD_V4_2_INTER_SSC */
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 8bdc37aa2c2e..b3bf8a5f4472 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -483,6 +483,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
>>   extern int nfsd4_is_junction(struct dentry *dentry);
>>   extern int register_cld_notifier(void);
>>   extern void unregister_cld_notifier(void);
>> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
>> +extern void nfsd4_ssc_init_umount_work(void);
>> +#endif
>> +
>>   #else /* CONFIG_NFSD_V4 */
>>   static inline int nfsd4_is_junction(struct dentry *dentry)
>>   {
>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>> index 6de406322106..2558db55b88b 100644
>> --- a/fs/nfsd/nfssvc.c
>> +++ b/fs/nfsd/nfssvc.c
>> @@ -322,6 +322,9 @@ static int nfsd_startup_generic(int nrservs)
>>          ret = nfs4_state_start();
>>          if (ret)
>>                  goto out_file_cache;
>> +#ifdef CONFIG_NFSD_V4_2_INTER_SSC
>> +       nfsd4_ssc_init_umount_work();
>> +#endif
>>          return 0;
>>
>>   out_file_cache:
>> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
>> index f5ba0fbff72f..1e07be2a89fa 100644
>> --- a/include/linux/nfs_ssc.h
>> +++ b/include/linux/nfs_ssc.h
>> @@ -8,6 +8,7 @@
>>    */
>>
>>   #include <linux/nfs_fs.h>
>> +#include <linux/sunrpc/svc.h>
>>
>>   extern struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
>>
>> @@ -52,6 +53,25 @@ static inline void nfs42_ssc_close(struct file *filep)
>>          if (nfs_ssc_client_tbl.ssc_nfs4_ops)
>>                  (*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
>>   }
>> +
>> +struct nfsd4_ssc_umount_item {
>> +       struct list_head nsui_list;
>> +       bool nsui_busy;
>> +       refcount_t nsui_refcnt;
>> +       unsigned long nsui_expire;
>> +       struct vfsmount *nsui_vfsmount;
>> +       char nsui_ipaddr[RPC_MAX_ADDRBUFLEN];
>> +};
>> +
>> +struct nfsd4_ssc_umount {
>> +       struct list_head nsu_list;
>> +       struct delayed_work nsu_umount_work;
>> +       spinlock_t nsu_lock;
>> +       unsigned long nsu_expire;
>> +       wait_queue_head_t nsu_waitq;
>> +       bool nsu_inited;
>> +};
>> +
>>   #endif
>>
>>   /*
>> --
>> 2.9.5
>>
