Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082433946A9
	for <lists+linux-nfs@lfdr.de>; Fri, 28 May 2021 19:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhE1Rp7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 May 2021 13:45:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36252 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhE1Rp4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 May 2021 13:45:56 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14SHcuQ8088209;
        Fri, 28 May 2021 17:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1WQiQjDF50S4X71yO9NMv/04ANB9JOM7FDBbOJbQa8s=;
 b=zYGwU2wq8To37a/GbMeL1mHDYOkY7VPCbrJtZDa7p+zf7gnvH7zHcS/xRr5WRYwrYlj6
 KmkbjxuzVmGXaccCqSFzmZiQbVtsSgUmDQBREBH4aleMflyWQXgt3u/OqpfQzlHAVLuw
 YTNnTkCLEiM/TIrco3ZPGs+vJKXOyoD1EY/9LFQs0bBqqms2ZUwVA6ZmosL2lxYMd3UL
 qc9W4niOrjqNVcUqBNUc0mRJtdDQ5Lnc+EB3b/2EnrMumko2Fxx3V3dgBuaKvyyCx/Ka
 i1S18bWyawqic2RbzEMqhkgiW0ZH2NFJg2myZKjiE1YmwkjHF5rzPu5V3YLzd8kX76Tm LQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38pqfcqt3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 17:44:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14SHeO0Z045513;
        Fri, 28 May 2021 17:44:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3020.oracle.com with ESMTP id 38qbqvp12y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 17:44:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/EOdCBSds9E2xAukuxg11aAvheLtVI/RqMXi+clLnj8u2FlkOXPWeRWOGbIXQS4WhEwXNwmpx1I9RN0zShE7GxjDJH7FXNnByd9FXLSmBIYpCjcSz4xPo3JzihKw+wcuaaOLimAeteCu7xsC+pywJaJiJdlsKFNrdQ9EGghfuMatHOovCnX3NOvPrwb8VQjGuUdeQiOZUw8DivELGOABJJlh605h6wg29WCB/8O7xdBNAjdoH5Mir6lX+SpT1SiDaqlyfzaG6fUyxCC+P5auoiSHPF3bUn5RBcVgmrYymH/THyuxzUc0xsRKSuqVhYEAWdZIeFRweKe/XimK47Rbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WQiQjDF50S4X71yO9NMv/04ANB9JOM7FDBbOJbQa8s=;
 b=QqFWqZMV0k5tMqiKBUX/KWGFNPPi0s/fAujdnAewcZluHa6PZIzWx3TFH3SUB17lRHfHcGHxYEVTtGZSmSzAToJ7QCowQKDtmXItWi8MHsnpW1p7XlT5puKik8HiAhQfAprwQmzIkpEnm+An5KpWKEuCbCMKXjm5f/CrUubqioTEQbCGBxOnmvKJSOgGeRV7Y4ZdOUtawKjM/wGDIpRLFowZg9jH5kegaSNWG7wYmDpWx3HgQP8XT8FeZvSBEDj7jYSx1k2Bt4ZEqP8TIb2gUB+Tnvii8nHBQ9ngndf8gdMcJ/qLPc8D9MQmJCSMndNqMxjhsxDNJE4hwdznge6LjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WQiQjDF50S4X71yO9NMv/04ANB9JOM7FDBbOJbQa8s=;
 b=vpEOZiECX76YlFzNlVXqPaxNQL87Hc4H1ubFLoRb9hTXpgIl9k6DHpog8z/3l4oyL9KJd+87UVOq67GNanwsXRFueJT/MYFp8MddksvTmPRwOAxtEw8wwaYzd67AEw9zYKBviTrmupJquf5Ce3TK/OtLwtemOSKrsSuMX7Iq8cM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2645.namprd10.prod.outlook.com (2603:10b6:a02:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Fri, 28 May
 2021 17:44:15 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 17:44:15 +0000
Subject: Re: [PATCH v2 1/1] NFSv4: nfs4_proc_set_acl needs to restore
 NFS_CAP_UIDGID_NOMAP on error.
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20210519211510.60253-1-dai.ngo@oracle.com>
 <f019e70d-d677-b0b7-3ac0-8f374430804e@oracle.com>
 <7ebfc2c9dc69bd44836bdf7c9c96d9b915b76d4c.camel@hammerspace.com>
From:   dai.ngo@oracle.com
Message-ID: <a78e33e5-eb4f-dc31-0285-ab3a1e54b32b@oracle.com>
Date:   Fri, 28 May 2021 10:44:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <7ebfc2c9dc69bd44836bdf7c9c96d9b915b76d4c.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SN4PR0501CA0049.namprd05.prod.outlook.com
 (2603:10b6:803:41::26) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-238-186.vpn.oracle.com (72.219.112.78) by SN4PR0501CA0049.namprd05.prod.outlook.com (2603:10b6:803:41::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.10 via Frontend Transport; Fri, 28 May 2021 17:44:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cf582bb-d63a-469a-4d71-08d922003620
X-MS-TrafficTypeDiagnostic: BYAPR10MB2645:
X-Microsoft-Antispam-PRVS: <BYAPR10MB26459FC0378EAF885B62E07287229@BYAPR10MB2645.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cP/yhysMm58zEK8B/njgDDbWxXMqNAwXBRiRd3ThNtk2IboM1R5IlCSis8dPBr5hTMTgsXDqoEhrHe5z+wd16nNtwN5k5fgkEqRhSmAteIE9a5kfqW8pNcg03ffHG+J8iB7Rq1wwHqafsNJIEUii4D1Cy4galju0sMS2UMWfGDw1eyE+n415q/gglGDw7kF4KHgQzzvAaExynD1Kd2LeclMzjDg8r1XAxzgOXK5QNfxj2YJSJ33o0VDvT95CZlTkOm+atDFwQa6CI2iKHkLamkRP8C/66QKEHr8GQnXJG62182/EUh+/2tjzKrCVsPxTeDzxVh8ilDtxr+MBfxYh5rsJGfpg6TEF17DNAHSBKIVs2jyyOCwe1D7bZeXQAe5NmWpd/wthv/luXwYoa/3/E2HCYQf8SKR/VJd8PyXaPfZgR7CkR7623cCYSaQWU9807GPVuiY1A3U3pv8fK6jh0e6iYgMvuiE1vBrG722tlkQtH2BiCdIiHMOB58qZ0DcMNdz8tWPaw2yAW/TBnWym5iJeiFikmf55vOu6SgvrOSmXqHyLHKcvktYUFAJ9m/xZSqNp2O0f8wSKv7Cd32OeX/qLgN8ABgmTDj/Kq4sd30vB/tvuofKYMmH1JEGoA0ObebVWOykxDTJ7lw8gdcxhYof4g/cEb7ClQCgspVO5x7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(346002)(376002)(396003)(6916009)(4326008)(26005)(6486002)(2906002)(5660300002)(38100700002)(316002)(7696005)(16526019)(186003)(956004)(53546011)(31696002)(2616005)(36756003)(31686004)(8936002)(66476007)(66946007)(83380400001)(86362001)(8676002)(66556008)(478600001)(9686003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VHN2TXg1MmtENkVCQlhoTG1KWkwzT1g4aisvK0VEWnI2MDhIRWR2QXl0NlhQ?=
 =?utf-8?B?WDZJQXM3aVAzWnJ2eGNXQjdzMnlZKzBWdm9hbWZhV1FXK0FlLzg5MDNmRjVC?=
 =?utf-8?B?L3FUcFFnN0dtRnhGSmhIRi9ncEZ4QllMTG1hVUJmTEVaWmRpa2NVTVNwemVn?=
 =?utf-8?B?MGZSdGxNdlFsa3luenVSWWtNa1VGN3NvNDlJM2ZUQS81ZDcwYVZnbThybUdB?=
 =?utf-8?B?WkdQbFhrOVBGT3kwdzVoam9yNVV1WmxBRE1zSkk2Mk1DYWs1a3VoM1M2OE9K?=
 =?utf-8?B?cmJaczdITzlxYTJ3Ym83Zy9kSjR4TUhhWlZWMmc0Y212NVlPSG9aeHZTaDdh?=
 =?utf-8?B?MkhuNXJpMnJtdXUrSyt0R3VockRNVktzWjBJL2NkekZZRnBZMmY2bkZvM2Zj?=
 =?utf-8?B?S0t4UiswZjZFS2pTREl6cCtlVjl4Y0lNc3hXMUJjKy9WSzdSMWVjTlFqNDlP?=
 =?utf-8?B?Uk1INHFoNlBmQWk5V0VrREVMZWRtdmJWQUNuQTgzQkhkTEM0OEpCMHFEZmdW?=
 =?utf-8?B?OUNjSEFTRnhMTE1ZRjdwVVlFdlMzczduYkNDd2lNK2xlZ0lCNm9TS1RTRzh3?=
 =?utf-8?B?d0ZvNjVVSk83dDdsZVN5d01lUlFaOTgwWnE2bDh1WnJyWmpmcFM0dC9qZEo0?=
 =?utf-8?B?WHpZeHl5L2x1VXhzL1VXQ0t3NlZ6R1d2eERjNk1uSG9EOUNoRnRpaU1LODlx?=
 =?utf-8?B?MVdhOHF0UWNhdkRaeHlrbXNBT2xNb1E1OGM2UGdUZTdlSUw5MHdOWGhadkJl?=
 =?utf-8?B?cEpGdEtaK3ZrdEl1eUlWNjRKVmFlS2k5cXJGUGlHMFNwcGtXb2txT3NVaTBT?=
 =?utf-8?B?NU5NdlZONEZHb091SmdFcVdscTlwekxnNEZicHNDYlRrV2pMVEI0UCtSSWky?=
 =?utf-8?B?NTkzN3ZGVG1Jb1JMN2l5MmJRZmNXazF6T3E0akxRd2hRT21KelRCNzlha3Ew?=
 =?utf-8?B?RERGOVc0SHdEb09qSGZhcW1KdGxHNjNmZmUrQ3ZZc3g3Z1hleENiak4vdmhp?=
 =?utf-8?B?ZXc1dHJGTHFKSkhXMGNLVDN2SjZuUi8vM0I1ZnVoNXJXR1p2STgvODBhRnU5?=
 =?utf-8?B?Y0lHcGJTbkxqL0UyWlk2U2J5RElJVmVUOVNucEtIeWdjYW1yVGkyQm9ROTRT?=
 =?utf-8?B?TlNSZnJCQzhVVzZDK1R1Sksvb3h1ODNiKzBTOHd2R25TSzRwNmtlMGsyZnZi?=
 =?utf-8?B?SW5mTTg3cU5yUzVnRHhIZGczekZvTTJSVkdjLzRhaS94RmZpN3pPcjd3c3Rq?=
 =?utf-8?B?Nk9UekNyU29Jb0ZkYzBqQXhJbkVoTXVDREk5Y3N2a2lsZHdTYUc5dmpPL3Vl?=
 =?utf-8?B?SmlMUE8yckNmM2hyc2RDelllbWprQlRSMmo5NDhhUUFHMkoyMEw4eEI0VW1C?=
 =?utf-8?B?TEJjbEQ3MmhUbWhVVXo2ZVVUSi9Qb3RHQi9WREpEY3ZqcW5LQjBXd25VUDRN?=
 =?utf-8?B?VXltKzh3YVJlMzFKSTBPNW10blpNUEJHcStWRVFoREtHM3FDeVdzdHZiSGU0?=
 =?utf-8?B?WVV4aVplNithWUhxSC9RMEZGMlN0UGUwa2ZCK1pucnJhUDJ6bGJBamZ3ZHZt?=
 =?utf-8?B?RzdUeDlpdXZ1MkNtNCtKVGhveXhhVlB2YUtFSVMzMHpTK1NjRjdicTA1Qzc3?=
 =?utf-8?B?UDhvU1liSkZ3bVFzaUxsL1V2UFZLb2xxb1dvaFE1bUJvRUZCZnB5UWhsbU55?=
 =?utf-8?B?WTQ3RXhxSHlWZGpvY0xBMWt4QWdOT2Y3WW8yVHJ5d1h6MmFuUXZTRTU5RWR4?=
 =?utf-8?Q?K0OjpBoecx/c6U3OLpX2HFtlokzdWcA0XlJ0BQL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf582bb-d63a-469a-4d71-08d922003620
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 17:44:15.3743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3cdIBykjVZm5fyyDfp0mexcvAP/poyGYDWVrN6/ksP1zhPhffphS73dnzNrQtHHRdmydGZxfiQoQN3wwGCAZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2645
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105280116
X-Proofpoint-ORIG-GUID: JL6B6fkUhWOL3oOEym1seD5VmH9ra_Rf
X-Proofpoint-GUID: JL6B6fkUhWOL3oOEym1seD5VmH9ra_Rf
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105280116
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 5/28/21 10:41 AM, Trond Myklebust wrote:
> On Fri, 2021-05-28 at 10:30 -0700, dai.ngo@oracle.com wrote:
>> Hi Trond,
>>
>> Just a reminder that this patch is ready for your review.
> Sorry. I missed that update for some reason.

it's ok. It can wait for the next pull.

Thanks,
-Dai

>
>> Thanks,
>> -Dai
>>
>> On 5/19/21 2:15 PM, Dai Ngo wrote:
>>> Currently if __nfs4_proc_set_acl fails with NFS4ERR_BADOWNER it
>>> re-enables the idmapper by clearing NFS_CAP_UIDGID_NOMAP before
>>> retrying again. The NFS_CAP_UIDGID_NOMAP remains cleared even if
>>> the retry fails. This causes problem for subsequent setattr
>>> requests for v4 server that does not have idmapping configured.
>>>
>>> This patch modifies nfs4_proc_set_acl to detect NFS4ERR_BADOWNER
>>> and NFS4ERR_BADNAME and skips the retry, since the kernel isn't
>>> involved in encoding the ACEs, and return -EINVAL.
>>>
>>> Steps to reproduce the problem:
>>>
>>>    # mount -o vers=4.1,sec=sys server:/export/test /tmp/mnt
>>>    # touch /tmp/mnt/file1
>>>    # chown 99 /tmp/mnt/file1
>>>    # nfs4_setfacl -a A::unknown.user@xyz.com:wrtncy /tmp/mnt/file1
>>>    Failed setxattr operation: Invalid argument
>>>    # chown 99 /tmp/mnt/file1
>>>    chown: changing ownership of ‘/tmp/mnt/file1’: Invalid argument
>>>    # umount /tmp/mnt
>>>    # mount -o vers=4.1,sec=sys server:/export/test /tmp/mnt
>>>    # chown 99 /tmp/mnt/file1
>>>    #
>>>
>>> v2: detect NFS4ERR_BADOWNER and NFS4ERR_BADNAME and skip retry
>>>          in nfs4_proc_set_acl.
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>    fs/nfs/nfs4proc.c | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index 87d04f2c9385..4e052c7f0614 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -5968,6 +5968,14 @@ static int nfs4_proc_set_acl(struct inode
>>> *inode, const void *buf, size_t buflen
>>>          do {
>>>                  err = __nfs4_proc_set_acl(inode, buf, buflen);
>>>                  trace_nfs4_set_acl(inode, err);
>>> +               if (err == -NFS4ERR_BADOWNER || err == -
>>> NFS4ERR_BADNAME) {
>>> +                       /*
>>> +                        * no need to retry since the kernel
>>> +                        * isn't involved in encoding the ACEs.
>>> +                        */
>>> +                       err = -EINVAL;
>>> +                       break;
>>> +               }
>>>                  err = nfs4_handle_exception(NFS_SERVER(inode), err,
>>>                                  &exception);
>>>          } while (exception.retry);
> Yes, this looks OK.
>
