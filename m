Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E0F394678
	for <lists+linux-nfs@lfdr.de>; Fri, 28 May 2021 19:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhE1Rcf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 May 2021 13:32:35 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59530 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhE1Rcd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 May 2021 13:32:33 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14SHTgYf064414;
        Fri, 28 May 2021 17:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HVj1JeZ2KKTewDKWeucugKtvJnf/DJhB8Qd1JPHGHZI=;
 b=tOpIkSt6dELPN/qQCwIbh6KojzhsQ38q5Ut/vPLx1Uaf+su7DSS8/jvPs8T1t5llC++/
 Riks8fYHdERS9BgvIms4I0S5pdHTRs1eR3IJKmdkupkHRWvmVDPDa6bgXVPljScVMwvH
 TEHTb54MrCWbMrVnAdtgeH+umX4vhs3ObS8XHUjLKAh2uPzCWzCtnvCQydutQ1EHlH8V
 l1RCiJ4sq8FINbkzTjhgPJTRhT4xL1/sYu363i2Yep8v39zvEJ/wxqiY+yHu0Q40MyGI
 3c54SaaboJFrmMjv2DzN/mvwPuhOAczveTeL8O3FclG1x3b/SlO2VCbpB6FLpef9RveK BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38pqfcqsbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 17:30:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14SHTe1x082264;
        Fri, 28 May 2021 17:30:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 38pq2xp8a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 17:30:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ai/DHOXp/xROJG2kIPN0UEX4KNZVwa8UCp5HEoJt67+PyA/OkP5v6eHu+XIM9Dr4wQ8Ctev3YUbZ8DrnG0SL/gibU0g0EbLhqbEYIafuCEuQsHIF+3DVJud23JaU9ZlFfThkPjfB8m4aq3SHLFKcVcBjCrb0/Bzo6dD+DuhDWcjCe6WNnPZ1BBwZuVjwLh2LFF/6inRTIh/TxSdTAOlSmXApDHvuYiVhKXG/i7wubLE6Cl2iic7ccnZTfGSKKu0GoiI9rVI7uC1sjmqUmnUhYKXfA4Y8q2g0/gK8xmTDTh5zn9Ic9eniPd+ZLy59ebLcZkvQ6bigfur9JL7hsNGQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVj1JeZ2KKTewDKWeucugKtvJnf/DJhB8Qd1JPHGHZI=;
 b=EZHMEedGL1GkuEvWk38XOnv5tO7USmjrKWdA0rpWl2+MO+yPoAipl0f6aEu1nP77GueVj2olF54/I0SFmhDFRBt8wD85Cn783dvckqdHC1epMbOFvj8O0aaNHH7YsapQM/puWsEwSW8NtTk5Kv6gzRwLXHT/UAk5oYArqSsu+kkyDrquFO0fW0xrWgss1mxJ0OWVxW9LVX1KHi4hMqGF8xoXIh8pGFbj7KXzaFVybECUNj/fx9BfDyeqA6nXiXBsm6e8B8AIm9doDnfPMl96QRuGA3DjVuqa3v4JzixnnoUwTEm/72WCJFq/dlJw6bfhLA+wbMIfhx2EeJ7gzT0zAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVj1JeZ2KKTewDKWeucugKtvJnf/DJhB8Qd1JPHGHZI=;
 b=GX9cgupgx4QUPIUbnjZbeN5wJgEQXYzOkAx/Hiqz8gLC4cp2U2PCzYwvYYkOyvmquUdznzAisOrKdbZuDVZ+FDcxSnCIATpL95gcGEteYU6ghVQdxnHIzxTcp7jbX8bdN8OfF1o78KxT5ZjQcSnhzIbC8BiE1kEIrque9CV3oto=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 17:30:48 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 17:30:48 +0000
Subject: Re: [PATCH v2 1/1] NFSv4: nfs4_proc_set_acl needs to restore
 NFS_CAP_UIDGID_NOMAP on error.
From:   dai.ngo@oracle.com
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
References: <20210519211510.60253-1-dai.ngo@oracle.com>
Message-ID: <f019e70d-d677-b0b7-3ac0-8f374430804e@oracle.com>
Date:   Fri, 28 May 2021 10:30:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <20210519211510.60253-1-dai.ngo@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: PH0PR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:510:e::28) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Macbooks-MacBook-Pro.local (72.219.112.78) by PH0PR07CA0053.namprd07.prod.outlook.com (2603:10b6:510:e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend Transport; Fri, 28 May 2021 17:30:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f449a8b3-2c4a-4805-1319-08d921fe54de
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4494:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB449438131A5A989F6802EFB687229@SJ0PR10MB4494.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMG8gPUKQomSLMAw1i8Z26yxVsHjuwsmxjyR6QdmCsOGbVLjVptkzt+7d/arOliPUslcaesZAU2Ce6nooKTqEfVRYybNUuoq3/pXBrdsv1JScpD/e3DVnNmss5aTNwwuNiT22h7Hj39vW64UuOE+U/f4+LFm5ziPFEx17ngnjLx0WnNJBFCr3Supdj434yjxFO/SjHvlerLJ575xC2gUSIVT1qIWPeePcJs/kQ3Br0iK3z9ctuDD1Wksku7i4/FM8Q+nH6yh4eSN73DxZd89E4BvpEB+WywkQ4WW0vGOgoIDRR/Z/sGHMTIpxVeh+wmZ7yk1U37c+Q3TIQYTiTJR6bU6lp5Lu85XHhI3NJ+ZKLfSEBaCa3hVeZ6VktuzaFDd52NC/+8Cf9fZUFOZpl6xrK8IZheyoUp1ZJ9cFWeja+ip/D7pxP8uhUdgmV4mLmPLbp/hVgha1nUZ9zxVPKg/8u5IWDv4KM2a93VWmo1zYP/ujNwes2D0drkHMXBePac03SIeOS8pmLZc1AfZARfENH1dH3NSawRmL2TcXrWjEJ2s9z4/IkI8yDGdlobLYJTJUNriyFUX0og6JxjQ1L4nCzgdIobxfEoX4Y8Z1tbsSlBvOSzEpOpm4SNf8RH/gaVDNAr4ro9z5t1UXKWb3JJE8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(31696002)(6666004)(4326008)(9686003)(6512007)(5660300002)(36756003)(8936002)(186003)(86362001)(6506007)(31686004)(16526019)(2906002)(2616005)(956004)(53546011)(26005)(478600001)(83380400001)(316002)(6486002)(8676002)(66556008)(66476007)(66946007)(6916009)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a1hIYjRwV2tYOUo5NFZJOHhQbGQrRXUvcHEzSGlxMWY3SmJoZ2IySHJBckpV?=
 =?utf-8?B?dFZuSUV0WnQwOG1ZTlVNN2o4TXZ4ckZBS2E1cTNwUURkVjkwN3JoaTBLR1BP?=
 =?utf-8?B?aXpKQUwzcXJHVnNSU1lJWUQySlUzRzQrNkVLbTZGU0NiWm9aM3FzYkxrNlFT?=
 =?utf-8?B?NFVIOVpGTTdwdmh5NjZlSUs2eW1ReU1RbzJkVklpTWxEeEZ3bnYxb0o4NHRk?=
 =?utf-8?B?aWRTVW8yL1hvcUxnVGZoUVZ0dUowRWFsWnRKcWkwVUtVV1Z0VE55YnRCSnBY?=
 =?utf-8?B?L2VkNk1RL2lSSE15Mmc4ZUd4WjI4c1MyZHM2RG5TbEFiUzIzLy85eUJKdGZy?=
 =?utf-8?B?NUVBSVlFZjRUajdQRjkrUFBOVnlhSVdyTUhFVkRZN3RhUEVFdFl1Tkg0dEZ0?=
 =?utf-8?B?aTNHOG9udFk5Ym5nZk1sRERsYzcyYW1URFhubGhrbGlCaTRGemFCYldIR2R6?=
 =?utf-8?B?eHVuU2tPWkdHRFZjMjdlM1piLytSbDdkc2dRYzE4VUxuOUdNbHZTRXl2WW13?=
 =?utf-8?B?akthb1ZxZU9vd1VCdmdIc0dQYmN3UklZYlVMSjZUZytTU2xUaCtsa3F6d0cw?=
 =?utf-8?B?UnpnS2hRdTJsbTIxZ0RMa3VZSmpDR01uUlBjRGl4UFdVWnVuUFpsV1I5M1J5?=
 =?utf-8?B?SnVQMGZHTVhHMzZ2ZWhRdGhsWllXS2lRZUtFYUJETjNmOGo2dXlJQ3B6MXdJ?=
 =?utf-8?B?dVlubTl3N3RJMVp2ODRBcGpTT0VZTkdib2djT1F5eGNCTWpBVTBTbEQyMzd1?=
 =?utf-8?B?VXZ1Z1ZCNmNtK3J4MFJxSkFIdEpwOHNIOWFRRHduR2xuOHE3ZHFDL3hucEdC?=
 =?utf-8?B?RjFkWm55NWZ6RlExVU0vVEZwRWlvV2RaZ2l0MUhBbWJuRHBndFQvaitrSlEx?=
 =?utf-8?B?SEt1SU1RQjl0ajgweElOTlNTZDQ4TzU5cWp6YlVwSFFCL3lVSFY5UE5QbVpV?=
 =?utf-8?B?b0tlS25QMGNpc3pKNG9iREFHaGJZNlppbld0L1J4Mmd4cXdKdFMvdmNxY1Bo?=
 =?utf-8?B?MlZWRGtQWHJxeE1yMkhkRVhQbjhBTW1lUG1VTUVDQUpoa2JaT1VLN2I2cDBx?=
 =?utf-8?B?enFlM3V0dXlOKzlnQnEyQWVGSnRVL1liM2xCSzFVT21hZkhoMjdIMlpSWmhG?=
 =?utf-8?B?d2xiUnhTSU9RQytIQm9JWXVOTkRtdDJXeC9sKzBXdlFCL0JPTmpyUlFHeElX?=
 =?utf-8?B?Tml0aEhtcys4YTU5V3JRczNPNzg0NU84eGRFMEozNmJxc0JpVFpVS2hZczFX?=
 =?utf-8?B?OGNTMnBUWXdVUGR5OGk1b2pxL3ZyOUU0enNxMjNiTVVCdFhRTElBNmhvdXJN?=
 =?utf-8?B?WVhYUTNXOTkrcDJDa2ZSK08wdTgvdk45N3NzZjZXZ3Zva1h3RnVSQTRZbU5Y?=
 =?utf-8?B?dXZPcVA2RUg0V3ZFT0o5WnRxblAyOVoxRlQ3MjB4bDlVL1M2SnpGcDdwVmNG?=
 =?utf-8?B?SWVjUElURVNZandBNnk3ZHExbFRTeHVUOElyL3U1bjg1ekV2YlJlNTdOMDEw?=
 =?utf-8?B?MlBMbFpLTGQ3a1NhV0VWSWwrTTRweThleHZoNE9yMzJsY3JtK3N0emp3SC9x?=
 =?utf-8?B?d1ZnaWVBWHlBYUlxdGNEUGlVbHhLV29KVllZSjRlakdqMFVHQ1VFdmc2djdD?=
 =?utf-8?B?T1VQelRrTGVtTGVqa3RCOTFrdjZORk92Unc0UXJFTlUvZExTMzZMdTYwMlBl?=
 =?utf-8?B?Q0hwWjBXeENMMWRxbUkydVJEeFVvV3gxTWJsOTRRSmoxbW50alUydG92ZGhk?=
 =?utf-8?Q?H3zi9k6YNub/+doOS66OqbXs/AwZSaG1vUFitps?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f449a8b3-2c4a-4805-1319-08d921fe54de
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 17:30:48.0916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWclcx2vDKk9684h5mk+0XdBuj/XTDNybGzPNxDrr2DiDLEe2mx9qISQohYh6Myv2dNPhsjn0QLtAtY5FbpWnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4494
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105280115
X-Proofpoint-ORIG-GUID: tb7qs42ItbE2JI3HOPbcPPygcmDlIL8r
X-Proofpoint-GUID: tb7qs42ItbE2JI3HOPbcPPygcmDlIL8r
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105280115
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

Just a reminder that this patch is ready for your review.

Thanks,
-Dai

On 5/19/21 2:15 PM, Dai Ngo wrote:
> Currently if __nfs4_proc_set_acl fails with NFS4ERR_BADOWNER it
> re-enables the idmapper by clearing NFS_CAP_UIDGID_NOMAP before
> retrying again. The NFS_CAP_UIDGID_NOMAP remains cleared even if
> the retry fails. This causes problem for subsequent setattr
> requests for v4 server that does not have idmapping configured.
>
> This patch modifies nfs4_proc_set_acl to detect NFS4ERR_BADOWNER
> and NFS4ERR_BADNAME and skips the retry, since the kernel isn't
> involved in encoding the ACEs, and return -EINVAL.
>
> Steps to reproduce the problem:
>
>   # mount -o vers=4.1,sec=sys server:/export/test /tmp/mnt
>   # touch /tmp/mnt/file1
>   # chown 99 /tmp/mnt/file1
>   # nfs4_setfacl -a A::unknown.user@xyz.com:wrtncy /tmp/mnt/file1
>   Failed setxattr operation: Invalid argument
>   # chown 99 /tmp/mnt/file1
>   chown: changing ownership of ‘/tmp/mnt/file1’: Invalid argument
>   # umount /tmp/mnt
>   # mount -o vers=4.1,sec=sys server:/export/test /tmp/mnt
>   # chown 99 /tmp/mnt/file1
>   #
>
> v2: detect NFS4ERR_BADOWNER and NFS4ERR_BADNAME and skip retry
>         in nfs4_proc_set_acl.
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>   fs/nfs/nfs4proc.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 87d04f2c9385..4e052c7f0614 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5968,6 +5968,14 @@ static int nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t buflen
>   	do {
>   		err = __nfs4_proc_set_acl(inode, buf, buflen);
>   		trace_nfs4_set_acl(inode, err);
> +		if (err == -NFS4ERR_BADOWNER || err == -NFS4ERR_BADNAME) {
> +			/*
> +			 * no need to retry since the kernel
> +			 * isn't involved in encoding the ACEs.
> +			 */
> +			err = -EINVAL;
> +			break;
> +		}
>   		err = nfs4_handle_exception(NFS_SERVER(inode), err,
>   				&exception);
>   	} while (exception.retry);
