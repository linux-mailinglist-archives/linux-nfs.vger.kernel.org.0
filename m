Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436EC368617
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Apr 2021 19:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhDVRiZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Apr 2021 13:38:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32282 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236287AbhDVRiX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Apr 2021 13:38:23 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MHVOsB004143;
        Thu, 22 Apr 2021 17:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nxsLXygz77Gpo23B39+MpnnMfkTA226RMx8M3yEl7xg=;
 b=XsQGutYJ6eIZWH0veVfc0XcI2B0CWJWYJxD9or8oawrrjjacGOMrNzL/xpi/wFVCSLAs
 5wT0BSWkna3Qrs9CqBjO4akV66HQbBAEyPaq03rFHF3Kz9TrinKc8T6WlBaTCtKPO/rX
 VacxcJoH6kLvxyeHo+fGDYg4oTbLPeZbD6QV8D9q8nGTE5i1vChTWayyh9EcuKoZ61qe
 YAjOqs12aDV6RCvTbky0I8haKSk9/DsT9Ne3qaLltmOTPEWKRxlRhnjNZzNr0u5oQkYV
 Q61BxzcekXFbgH0VJjTQdZY2thiRfb7/KoV6/s+qphQGt79qHbWq8iPF52ZpwTqp/wxc cg== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 382unxgd2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 17:37:44 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13MHbg04043243;
        Thu, 22 Apr 2021 17:37:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by userp3030.oracle.com with ESMTP id 383cdrutdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 17:37:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSSILIFMyb+4wdNKJ8yp/ChHYswdoKlgyarLnkwxKw06XvlL0ZR/gYqfsd0OS5Wwi5Uxwp4LLPIH7kuBLrqEIAuHzJiX7ZECkGwhNjYdTfBcjiRT40Sio/20AiBYgHbNg1nKlV2hrND4T0ROWoVCblh+AgFbcwoTvxge5WLt0v4A01vagDcyHFJx7KqUE5Z7m//pmMnL/oQsGJoQ0ovhF4AVfQixWUnKAqOkS9ytTSwTnmHKM4ZBQVbFv6VJhm8SryKrMsMFMWcywmSW/9UP6Cq6dN6sPILcfIRncDZZounWx3Rihj0ssIea6i/2oJRHqfSOqPtQgGftCwhcdhRpcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxsLXygz77Gpo23B39+MpnnMfkTA226RMx8M3yEl7xg=;
 b=IIJHES3QvR2x8R34n30s95sNqbkuyl/1gJnF6XzwHZdMCFL80TKkXf9yFnaoRRbgRWD4ZIanTN+ojl3FjJ8aIBbzJiAwDoltrLGLl944fdPS3896C6UCsVxKXUW1BFYJe68koZhZcPkmL4eOPzvzxg5rwpY9v8MBKsQrZvho1epU0ktvQZkVrzAz1vYXMF24foyMEPEZeCvd26ThRnGcfKLtJKfqBwi3CA5pL1/CHM/4Ul7UV/eRehQ2ec/l/TEQmj8BI3fGlj9ALbFrKlTw94E1YnD2XvY148PBcJGr1iGPKKpF66WoUFV5ogyMlf/WV2kPymVJ3NxTVpYVbq33JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxsLXygz77Gpo23B39+MpnnMfkTA226RMx8M3yEl7xg=;
 b=Ewn3A2meUolj4DhiyXctuarMKKSgDRuL4412LoVdmw9Co29/9CMUSyszqlny+gcol5tIiM+3sfGsxVNwIa2TVR2mo8QSrvjp5Yxw7oSx3+jMt6N5BwkwaHVMTr7AYc/uJhOngQAQbzM6dHTk0EB3uuSVVHp4NRRy/V6u0kla9mM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3720.namprd10.prod.outlook.com (2603:10b6:a03:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Thu, 22 Apr
 2021 17:37:40 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 17:37:40 +0000
Subject: Re: [RFC 1/1] NFSD add vfs_fsync after async copy is done
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <20210422161922.56080-1-olga.kornievskaia@gmail.com>
 <22046fa4-730f-4e08-cfd8-eadc5fe098b3@oracle.com>
 <CAN-5tyFbwOmyeTw7iY9M2GaofSpz03ui3nFNUPM8HkaHqv1D9g@mail.gmail.com>
From:   dai.ngo@oracle.com
Message-ID: <651a32f3-7504-ed53-2fa9-21ceedba7bd2@oracle.com>
Date:   Thu, 22 Apr 2021 10:37:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CAN-5tyFbwOmyeTw7iY9M2GaofSpz03ui3nFNUPM8HkaHqv1D9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: BYAPR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::17) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-254-102.vpn.oracle.com (72.219.112.78) by BYAPR02CA0004.namprd02.prod.outlook.com (2603:10b6:a02:ee::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 17:37:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6efc7e84-eaab-43df-d00c-08d905b55402
X-MS-TrafficTypeDiagnostic: BYAPR10MB3720:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB37202F8DD8972D9D8CCA0BB787469@BYAPR10MB3720.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgFIkG10H/BW7SGw9FiKTiWugRNsx8N8Ry1zIq3bbtQvNuntxTlmq2p1mVhOarkIoO//lREUXEFETEnko7grwBphn/06G6D8qRxT9FgTB+jZwzGFwSa7ICTuDIsAc22DgjR+lAHbBq8zbD57EIBReLLY1GYO16S3KbGQGBd6hwGD2cUCjJxuCcq8LkAwHNW6A6M3AgeuyGVjuq27ASgM6EizHr5c6Jw007SGKR912hGNsQjFN8qDV/b4WryTCdCyT3X7jAF7Zo1/qzr2GnAbwvwuD0Ol7SsQfwgFTERuuU2W5/S/oWzjfB/Oe/+ZSurnJ8jx971WgN0M0FEv9HR8KgHrf0Pb40Judal0IDLa4a9IkXehos9ljOSIR8JhiWUW2MSB/8cN7a0zmcOHMNoSrsi0ba9D0dE/sC25ts8UC8tZ2VWlKD1/52O06niMrGUUtujfsOBvSuwmYLjFOzYdyVs5vFCKs8n8m92lcVeKTfWwf2BX2D4CfaCcVCm/6A+9gYHbS3284GIswOkdTXUVB3RnSQKTMpAbQVotVLQ20rbSdESLRIWZo6OBHXxN5bT69b9lXVfWbD4dD4YS9IXa8pqLN9GW101rvhYB0FlFQhI1xRLu/5JOFFzA0tMa/5Iq1v4eKz9JTxX7aPQh/mAELw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(136003)(376002)(346002)(66946007)(26005)(186003)(956004)(16526019)(36756003)(8936002)(478600001)(2906002)(5660300002)(31686004)(316002)(86362001)(66476007)(83380400001)(2616005)(6486002)(7696005)(6916009)(8676002)(66556008)(4326008)(53546011)(54906003)(31696002)(9686003)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WjFpeUk1YTBrY2FvNGM5b3c5dlE1Qk1mWFJaVzM1OG9mRTAxNGNvOWtGb2p0?=
 =?utf-8?B?anJEZXlDM3Bla25GamxKWnRXUzhKNklxN1p2bVBhOTZNa3R1NUVDSWVVOWhn?=
 =?utf-8?B?akVRZ1JybnkzcEljL3JTUHN4KzZVVU5LR21BM3IxZGVXS0liRFJBb1I4dWRL?=
 =?utf-8?B?QTR4NWhCbDQyVjE2RFlZTFJFUDlTUDVIT3hZRTl4R1BQRndlTjdGK2Z4YTRH?=
 =?utf-8?B?SGlQNGRMZ1RjR0pPdVVGVU85aEtYaUFuMVFDNVp0U29MRzdYcXNKaUZ1WmJs?=
 =?utf-8?B?K0pldEVhZUdyVTFocCtFclgzOFcwSVpOY3EzakMrUjFTT1FqMk01TFFxMXM2?=
 =?utf-8?B?dW9oSnFhYm5NSFFjWWRqbWwwYnFWUUh3QUhBR0FtWWQweitBZTI1ZWNWcDJj?=
 =?utf-8?B?ZklwN3pCa2l4THAwRXU2TW96dWVqQ2I5R3I2aEJPU3duRlR4cE4zcnUyejVZ?=
 =?utf-8?B?QXNRVUgvQkdPQ1dTNkRYUDZsZnlVWkRWdXJVZFQ5NytUSFFIcmhDai9mRXpK?=
 =?utf-8?B?STIwNmFlS2hsM1JDRGk2TkwxeE1tYk1RM0U5RlRqdEd1cVNsd1hJRXp2TW9o?=
 =?utf-8?B?SGhVLzAwNXpua3pCelNydnZsZ3Bla3phK0hSOUUyK3J4aE1FeU1NZndwNE9R?=
 =?utf-8?B?L2s5My94RXdiWDE5VUVpYWZ4NmhNYTdXRXVFLzFnTWRzRXVIV2lZdENJajVq?=
 =?utf-8?B?aWhoVkhBeDdQOUJKNXdEbnRrQzNRMWZ0OXcxb05ZV2FZT3FxeGhkZ0lOSWhI?=
 =?utf-8?B?MWxzWm84UEJnYXYyS0M4TXcyNWlMb3BYVHpLaUpUazdweFFlY2JKMDZ6YkJD?=
 =?utf-8?B?Tlc4VkJoMXl4eDB6RitoaU0xK2k2RWYxZVlRN0lnSnJSQU8xSldvdzZwS09o?=
 =?utf-8?B?S2t1cUNwZnNzRklFRjY1V1YrUzlrd3dRa29VU2ZzL0N6S0Z6cXVIZWJSRlJN?=
 =?utf-8?B?Y3JnY3BJSS9NaTRWamQyWWJXb2VCSXlUVGNuckNHS0NQc1pYVVZpZDJaV3c3?=
 =?utf-8?B?eGZ5RFB2U2dmN01RanlpS1pweFZCQkNBVnpPeW9WMXhVNElicjJFUkFiYzNP?=
 =?utf-8?B?MGJEZjNha0dhUzZlWWtiREdoc0dyNkFHQkN2RldWZXNoSEFCTGVqQ0piOWZo?=
 =?utf-8?B?eCswWldLNlU2aWxVbGxabFhzWlpydElUS3ZoSEU5NlFkTUxIUE8yVlNhc2Ex?=
 =?utf-8?B?b3BTU1NiMmcrdTk1K2xhRjZTL1lJTHZKT0tDbzcxMlZRcXp3Z3l6djQvajJ1?=
 =?utf-8?B?K2tmNk9OTjBkVU8wblRKRnZyWnQ2akQ2cDlVdWhHcHQrUUNXZ3Z5RlQ5c2F5?=
 =?utf-8?B?aUFZMUpuQTZSV2lRTGhWNWVOQW1PM1EyeXlWYmVUdWphQ084RThOOVVHekFi?=
 =?utf-8?B?bWRsSE5ZWFBKWWJmRWFXUTQ1ZWYvVUx1djJ1NzgwTC9hUWJFS0xWdUErVklo?=
 =?utf-8?B?SjNSVzR1SHdKRlZqVGJZallJakdEc040K2Y5SWcydVQySmRRc0FOOExWZEUw?=
 =?utf-8?B?bG5jZ0tHempSRDZvUkJFb2xaWXpMK2hPYldraU9KSXVFU1BFcTgweDlWUHd1?=
 =?utf-8?B?ZTlMU2xjT0NhRDI4bjl6dm50QzErUEo4UmF2QWlocG12MThRMHFWTGdVdG1N?=
 =?utf-8?B?MTJUZ1ErR2M3Zmg5SDZEQ3lLYkJqN21kaGhkdnAvcVVKaDdRNTVPOTQ2d0Vk?=
 =?utf-8?B?ZnpDUDZCa3RnYk1LbXB1dTNrRFhneUc1T0NBNWJJTmhmUjI5K2d1Q29ZQlZN?=
 =?utf-8?Q?ygVAhMv0o3aP3R/K6RZSHIAbO0p1lQoUWZDoec/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efc7e84-eaab-43df-d00c-08d905b55402
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 17:37:40.7341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYS2f1Ghfm5IdgMZxG4iR3JU3cuzNY44lR1gLP9cKCROQfMF0OKD2Mw1Yvv7d74hfoWp3tJokFxX5mRhQXKIHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3720
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9962 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220132
X-Proofpoint-GUID: Zf9i8pzqY97MFk9xopMAiLFFaRlEQQ7F
X-Proofpoint-ORIG-GUID: Zf9i8pzqY97MFk9xopMAiLFFaRlEQQ7F
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/22/21 10:27 AM, Olga Kornievskaia wrote:
> On Thu, Apr 22, 2021 at 12:54 PM <dai.ngo@oracle.com> wrote:
>>
>> On 4/22/21 9:19 AM, Olga Kornievskaia wrote:
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>
>>> Currently, the server does all copies as NFS_UNSTABLE. For synchronous
>>> copies linux client will append a COMMIT to the COPY compound but for
>>> async copies it does not (because COMMIT needs to be done after all
>>> bytes are copied and not as a reply to the COPY operation).
>>>
>>> However, in order to save the client doing a COMMIT as a separate
>>> rpc, the server can reply back with NFS_FILE_SYNC copy. This patch
>>> proposed to add vfs_fsync() call at the end of the async copy.
>>>
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>>    fs/nfsd/nfs4proc.c | 22 +++++++++++++++++-----
>>>    1 file changed, 17 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index 66dea2f1eed8..c6f45f67d59b 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -1536,19 +1536,21 @@ static const struct nfsd4_callback_ops nfsd4_cb_offload_ops = {
>>>        .done = nfsd4_cb_offload_done
>>>    };
>>>
>>> -static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
>>> +static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync,
>>> +                             bool committed)
>>>    {
>>> -     copy->cp_res.wr_stable_how = NFS_UNSTABLE;
>>> +     copy->cp_res.wr_stable_how = committed ? NFS_FILE_SYNC : NFS_UNSTABLE;
>>>        copy->cp_synchronous = sync;
>>>        gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
>>>    }
>>>
>>> -static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
>>> +static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy, bool *committed)
>>>    {
>>>        ssize_t bytes_copied = 0;
>>>        size_t bytes_total = copy->cp_count;
>>>        u64 src_pos = copy->cp_src_pos;
>>>        u64 dst_pos = copy->cp_dst_pos;
>>> +     __be32 status;
>>>
>>>        do {
>>>                if (kthread_should_stop())
>>> @@ -1563,6 +1565,15 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
>>>                src_pos += bytes_copied;
>>>                dst_pos += bytes_copied;
>>>        } while (bytes_total > 0 && !copy->cp_synchronous);
>>> +     /* for a non-zero asynchronous copy do a commit of data */
>>> +     if (!copy->cp_synchronous && bytes_copied > 0) {
>> I think (bytes_copied > 0) should be (bytes_total < copy->cp_count).
> I don't think so. A successful async copy should never be less the
> requested bytes.

nfsd_copy_file_range can return 0 on the last write in the loop which
causes the test (bytes_copied > 0) to fail which then skipping the
commit. The check (bytes_total < copy->cp_count) says do the commit
if there are any bytes successfully written so far.

-Dai

>
>> -Dai
>>
>>> +             down_write(&copy->nf_dst->nf_rwsem);
>>> +             status = vfs_fsync_range(copy->nf_dst->nf_file,
>>> +                                      copy->cp_dst_pos, bytes_copied, 0);
>>> +             up_write(&copy->nf_dst->nf_rwsem);
>>> +             if (!status)
>>> +                     *committed = true;
>>> +     }
>>>        return bytes_copied;
>>>    }
>>>
>>> @@ -1570,15 +1581,16 @@ static __be32 nfsd4_do_copy(struct nfsd4_copy *copy, bool sync)
>>>    {
>>>        __be32 status;
>>>        ssize_t bytes;
>>> +     bool committed = false;
>>>
>>> -     bytes = _nfsd_copy_file_range(copy);
>>> +     bytes = _nfsd_copy_file_range(copy, &committed);
>>>        /* for async copy, we ignore the error, client can always retry
>>>         * to get the error
>>>         */
>>>        if (bytes < 0 && !copy->cp_res.wr_bytes_written)
>>>                status = nfserrno(bytes);
>>>        else {
>>> -             nfsd4_init_copy_res(copy, sync);
>>> +             nfsd4_init_copy_res(copy, sync, committed);
>>>                status = nfs_ok;
>>>        }
>>>
