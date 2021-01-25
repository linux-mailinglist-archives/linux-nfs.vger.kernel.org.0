Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A270E302861
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jan 2021 18:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbhAYRCc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jan 2021 12:02:32 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42746 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbhAYRCL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jan 2021 12:02:11 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PGtNmk102432;
        Mon, 25 Jan 2021 17:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rZEfH189gDECEf10A3LdWoBVjtyuJehQPHxLMfsjTVM=;
 b=AZyyXt6oGBJ+F7lMca8j165FHedT1nOultShoUr8erEgYo0o4ukQrKAJnHu1u+MmIr8h
 xHQxl9n5xgvnpZp/1kpbqvJqFbGi1He8Ea1hhXF9RcerXs7OCQWX1sYYvdSbTo1oSjDO
 xc/dtMspwRcJf3oZnxMymL1DwHaz6gHZ8ssOoXMc+4bc480gMV7xETXaDxUvwJD7x/vC
 3yjvObZQN907dVLuS1AT/CbgpqRGlvflgif1Ommqa5n+54R0jzEckgieG2auAc5RHLrT
 Pq8fCEGdYN2OKtck+mgGD6etS0ECijY3QWcVfBxd+eeh/C88c0dijBGk10IV6x1Al3O8 kA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 368brke78w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 17:01:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PGuSXG040472;
        Mon, 25 Jan 2021 17:01:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3020.oracle.com with ESMTP id 368wpwu6y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 17:01:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l87hXGizJhevTlO5PmaHYkTau9V3GDNdP0WAzFY9rKgtXpvJbpYloZleTXXOiemWzlu29fHffVo1xCiz6zZeOo23QSewpkdKH7Q9zusf/JlVaC+sDUgdSWIK3ougRJZxnGLa9hgIYCcmersVd7sjfyFij9+Fq5hT3M20khEqsjvQfmM47swCdVRXlA01b8qUHCXDBWe0RD0iMMMLnmevPzmmsm9BicjBW7nkqHxNGpmNfw2vOOHIRWAFDTBI5iVWjKfXhBg68yw9teqB+xR8T6XmwD4VufKOzburDvVQhpRdX6HzOVL2wNy+CDH2NQ/sfWh6YS8WugBaYo3lgqFwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZEfH189gDECEf10A3LdWoBVjtyuJehQPHxLMfsjTVM=;
 b=fldFHCzI33Hc9Y+WWuynhMSwgP1M0Bs9Mr0O+mVjpNVLX+cL0KwYf8hLcVjh6NwZffY44ztasPoi153pPGw9NzNE0h76+DNJ0CA9wprIF4c4WGU5BKOQOBf+9g86dRlBdY1jXvGH8NqVLwX3tRrk2btkzs+whSdPuCB4CAbSnLeEQK2njeDILyMhDvhjV8enSnebZTzU1WVUPv22wiDDmdl0mW64yIRRbPtxHK72izOvpLSGCm1zleO8O7WRxsPj6JswMCVEAxKAK+kU43a44DrjxmPNEmPUmwjYYlKo01HpIL65EzRVQqVMfo3PyIMa7cJ/k+iJTYikdpzNdtXRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZEfH189gDECEf10A3LdWoBVjtyuJehQPHxLMfsjTVM=;
 b=fJLnZLNyIHNU1rwT7JLmg7Yo72XAAuG9cQHcnGHu25w3UKPZu6CxR0mmp9wKVJLKfMMLgOAv/WF7iotGwBrAqGdweB7f12FCkXbTB7V1oLTni2uomjm0yVmo3St8nflhV7BEpEl08Ed/PIIdKUXgetmBychBds3A+BttGSY0MNU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN7PR10MB2434.namprd10.prod.outlook.com (2603:10b6:406:c8::25)
 by BN6PR10MB1441.namprd10.prod.outlook.com (2603:10b6:404:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Mon, 25 Jan
 2021 17:01:12 +0000
Received: from BN7PR10MB2434.namprd10.prod.outlook.com
 ([fe80::20d8:7ca1:a6d5:be6b]) by BN7PR10MB2434.namprd10.prod.outlook.com
 ([fe80::20d8:7ca1:a6d5:be6b%3]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 17:01:12 +0000
Subject: Re: [PATCH] NFSv4_2: SSC helper should use its own config.
To:     Chuck Lever <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20210123015013.34609-1-dai.ngo@oracle.com>
 <3F738386-929D-403A-9876-1063C52BAE4D@oracle.com>
From:   dai.ngo@oracle.com
Message-ID: <eecbf018-dc67-7537-0523-7a9f894d6a28@oracle.com>
Date:   Mon, 25 Jan 2021 09:01:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <3F738386-929D-403A-9876-1063C52BAE4D@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: DM5PR1101CA0006.namprd11.prod.outlook.com
 (2603:10b6:4:4c::16) To BN7PR10MB2434.namprd10.prod.outlook.com
 (2603:10b6:406:c8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-123-8.vpn.oracle.com (72.219.112.78) by DM5PR1101CA0006.namprd11.prod.outlook.com (2603:10b6:4:4c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 17:01:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ce770e0-120c-473b-6646-08d8c152d169
X-MS-TrafficTypeDiagnostic: BN6PR10MB1441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR10MB1441B6224E2095485514C61C87BD9@BN6PR10MB1441.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZcRBxZRCDH1IjVRmP6PY9L0eaGoqPQhnjSA8ZW1l4brfUMEI6H41wScAjMJq1lCxu7c9T1B6V7JKSxwJSkaRmbGWi0OQHEef9pO8aDG3DEy3MidRQF6iRqsPqWiCpy7lESs+c1bFqJDfaIadpNBsEGzuIQvg7avMtea4Qk4tt6RmREvO0zboRMfb/bsSrXCTgwCbQqU+AJycP6cPC4Z7RfcIfxHbFqA6UtLT0FY1mNci/RXQ/FcVSZRoK2UXcOt94oxxq+WCVTUUyQzYvHz0bUlddNubwTDzay+YfXKx0eHX0o9Y5iCX0qLZhDUmskTGb8wwIy3ip5myNhjvr05IIzggO8QrSzbefu2Ba2GkKVoL0PJlD0steInfKBDEHC3m7oTgIVEWWTzE6TMt48Isqg0/18kvwHcVhnuQ2i1nRfh1ZhnwDyomtLoQ0MohJ8/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR10MB2434.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(376002)(346002)(83380400001)(6666004)(8676002)(478600001)(2616005)(6486002)(36756003)(956004)(7696005)(2906002)(26005)(16526019)(66946007)(31696002)(8936002)(66556008)(86362001)(31686004)(186003)(66476007)(9686003)(110136005)(53546011)(4326008)(316002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QS9VS25Tbml3MWtZWDZTUFZwbHRtcWJyeFFJVllYSzJBMXhYUkdqOHA2aUxs?=
 =?utf-8?B?UGtSaXkwdEp1NFhPOXIzMU14K21tQnQ3NXRTWXJqRC91WmQzQWY4L3ZqYUJY?=
 =?utf-8?B?MmoxMkc3Z2lmbDF5bGRhMkFaeEFYU2FLK1hQSFM2anN6eEZaeFpmbU1KN2J2?=
 =?utf-8?B?RUVjd2tDRDB3OU42NFpnbDc1SmtlZGd2VWY3enViVlV3VWpURnVaQlByaVRY?=
 =?utf-8?B?Zk5DaUJVQ21heit1TjVaZFFVd3NiNTIvYnlhTEVSOExsSnVSdFVkbXFuQkRZ?=
 =?utf-8?B?Nmh1T0lxUkdjNm5XdUswL1h3b1A2R3o2MmlPcVhOaHNTRytmQTkvQzJKelpZ?=
 =?utf-8?B?VENUNHkyUTNFaDBmV2Voa1g2NG1GM3I0a2liRStIcTZRTlBma3p6T0szWlFz?=
 =?utf-8?B?bXFVNTRkeVZ3SnhqTXoxTndjTGswQkNRTFlRQ2ludWhoQ0lhTDRJamZtVmxC?=
 =?utf-8?B?anBmR2EyTFFNcDgvR202VW15NGJMLzdFVTdoYzFuK3pIaHpjZGFxWGFSdzdl?=
 =?utf-8?B?dGQzYlp0eEpHMUpNRFlQQ2x4WC9aUk03cWRaRHVPcWJZcy9DYll1L1FzaEJl?=
 =?utf-8?B?bDl2UE02WXdKaTJ6Zmx2Tmw2aEJQTGVHSFd5eU9KZG9aWjUzZEtNOUdwN29N?=
 =?utf-8?B?RFc4YURLWjVVdURxN2R6VHViRXZLMm9FOENsMEswUjNVOUtqN2h3SmlCb3p6?=
 =?utf-8?B?MlY3UE4vajdTVHB5Q3RobG9oODJrY2xESDNiS2dLRmREYzJMd2JkYjl3bmF6?=
 =?utf-8?B?MEtHamg2RmZ1WHZGYjY5b3VLNHJGMnU4dWt1RlRBNmM5MHRuNHpEbUZxTEFS?=
 =?utf-8?B?SXlzbWlQQ29qUGh4dWlhQ05UYWxhSVZjenRBWnhkOXhRQVRBRHVRVXQ3Y1d3?=
 =?utf-8?B?Q1BUSG9tLzNJTUwyVU5XZXFwcjd3THk4UFNzUXBYTlYwczhQUU95Yzg4anhI?=
 =?utf-8?B?S1IzUVIyelNhZ0lZZlFYTzBqVWw4Q2h1U1g1dGc0UjlPNC9TYmgydFU4bHU5?=
 =?utf-8?B?MmNsRGxDdm5UeDltcUEyeUhxcDlobHVkeVRQVFU0RndNTkF0cGlYaDdVYVNa?=
 =?utf-8?B?N2RTTGoramhyamtLeVVKVlVxVFhRNElvcFNBeURDbTd6d296dHJPWXRmRktW?=
 =?utf-8?B?bEFzUStDdjd6S3BRZzBqVFhrdHFCRGpUY1VFRlZGODNnbTR1dDhINFFqTE8v?=
 =?utf-8?B?YkRhMXd2c3ovTTRmY2dVbDlCMVVQejhhYjNWeUg0V1IxUEtJeWRURVBTM2wx?=
 =?utf-8?B?bzdQWmgrVE5lNVFlZS8rY3ZqakNsLzEvMkU4Y2txV3l0M0pNU0FWOGt3bDdy?=
 =?utf-8?B?TmhaSDBIclJzbWhwVlo5dDg3SDBLVnozejZSRkk0YW5nTnpWbGdMMVAxUVh1?=
 =?utf-8?B?RzJMS1JUYkZSaHdaSEZuNlFQTEpBM2R4cnBQcHROUFhEMzVaclFMK2d1TldI?=
 =?utf-8?Q?A8iKdRi8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce770e0-120c-473b-6646-08d8c152d169
X-MS-Exchange-CrossTenant-AuthSource: BN7PR10MB2434.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 17:01:11.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdhO0h08IrE0CTlVJY6CnMzbKSFdYBaIc6rlLdBAsChDUjj56yv9WcmtO5TSQGmw3olTw4bXKFNX/CKvNRZ/jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1441
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101250093
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250093
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 1/25/21 6:32 AM, Chuck Lever wrote:
>
>> On Jan 22, 2021, at 8:50 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Currently NFSv4_2 SSC helper, nfs_ssc, incorrectly uses GRACE_PERIOD
>> as its config. Fix by adding new config NFS_V4_2_SSC_HELPER which
>> depends on NFS_V4_2 and is automatically selected when NFSD_V4 is
>> enabled. Also removed the file name from a comment in nfs_ssc.c.
>>
>> Fixes: 0cfcd405e758 (NFSv4.2: Fix NFS4ERR_STALE error when doing inter server copy)
> This patch feels more like a clean up / refactor then a fix,
> so I'm not certain we want to request an automatic backport
> to stable for it. Dai, would you mind if we dropped the
> Fixes: tag, or is there something I missed?

Yes, it's a cleanup. The Fixes: tag is not needed.
Thank you Chuck,

-Dai

>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/Kconfig              |  3 +++
>> fs/nfs/nfs4file.c       |  4 ++++
>> fs/nfs/super.c          | 12 ++++++++++++
>> fs/nfs_common/Makefile  |  2 +-
>> fs/nfs_common/nfs_ssc.c |  2 --
>> fs/nfsd/Kconfig         |  1 +
>> 6 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/Kconfig b/fs/Kconfig
>> index aa4c12282301..d33a31239cbc 100644
>> --- a/fs/Kconfig
>> +++ b/fs/Kconfig
>> @@ -333,6 +333,9 @@ config NFS_COMMON
>> 	depends on NFSD || NFS_FS || LOCKD
>> 	default y
>>
>> +config NFS_V4_2_SSC_HELPER
>> +	tristate
>> +
>> source "net/sunrpc/Kconfig"
>> source "fs/ceph/Kconfig"
>> source "fs/cifs/Kconfig"
>> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
>> index 57b3821d975a..441a2fa073c8 100644
>> --- a/fs/nfs/nfs4file.c
>> +++ b/fs/nfs/nfs4file.c
>> @@ -420,7 +420,9 @@ static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
>>   */
>> void nfs42_ssc_register_ops(void)
>> {
>> +#ifdef CONFIG_NFSD_V4
>> 	nfs42_ssc_register(&nfs4_ssc_clnt_ops_tbl);
>> +#endif
>> }
>>
>> /**
>> @@ -431,7 +433,9 @@ void nfs42_ssc_register_ops(void)
>>   */
>> void nfs42_ssc_unregister_ops(void)
>> {
>> +#ifdef CONFIG_NFSD_V4
>> 	nfs42_ssc_unregister(&nfs4_ssc_clnt_ops_tbl);
>> +#endif
>> }
>> #endif /* CONFIG_NFS_V4_2 */
>>
>> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
>> index 4034102010f0..c7a924580eec 100644
>> --- a/fs/nfs/super.c
>> +++ b/fs/nfs/super.c
>> @@ -86,9 +86,11 @@ const struct super_operations nfs_sops = {
>> };
>> EXPORT_SYMBOL_GPL(nfs_sops);
>>
>> +#ifdef CONFIG_NFS_V4_2
>> static const struct nfs_ssc_client_ops nfs_ssc_clnt_ops_tbl = {
>> 	.sco_sb_deactive = nfs_sb_deactive,
>> };
>> +#endif
>>
>> #if IS_ENABLED(CONFIG_NFS_V4)
>> static int __init register_nfs4_fs(void)
>> @@ -111,15 +113,21 @@ static void unregister_nfs4_fs(void)
>> }
>> #endif
>>
>> +#ifdef CONFIG_NFS_V4_2
>> static void nfs_ssc_register_ops(void)
>> {
>> +#ifdef CONFIG_NFSD_V4
>> 	nfs_ssc_register(&nfs_ssc_clnt_ops_tbl);
>> +#endif
>> }
>>
>> static void nfs_ssc_unregister_ops(void)
>> {
>> +#ifdef CONFIG_NFSD_V4
>> 	nfs_ssc_unregister(&nfs_ssc_clnt_ops_tbl);
>> +#endif
>> }
>> +#endif /* CONFIG_NFS_V4_2 */
>>
>> static struct shrinker acl_shrinker = {
>> 	.count_objects	= nfs_access_cache_count,
>> @@ -148,7 +156,9 @@ int __init register_nfs_fs(void)
>> 	ret = register_shrinker(&acl_shrinker);
>> 	if (ret < 0)
>> 		goto error_3;
>> +#ifdef CONFIG_NFS_V4_2
>> 	nfs_ssc_register_ops();
>> +#endif
>> 	return 0;
>> error_3:
>> 	nfs_unregister_sysctl();
>> @@ -168,7 +178,9 @@ void __exit unregister_nfs_fs(void)
>> 	unregister_shrinker(&acl_shrinker);
>> 	nfs_unregister_sysctl();
>> 	unregister_nfs4_fs();
>> +#ifdef CONFIG_NFS_V4_2
>> 	nfs_ssc_unregister_ops();
>> +#endif
>> 	unregister_filesystem(&nfs_fs_type);
>> }
>>
>> diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
>> index fa82f5aaa6d9..119c75ab9fd0 100644
>> --- a/fs/nfs_common/Makefile
>> +++ b/fs/nfs_common/Makefile
>> @@ -7,4 +7,4 @@ obj-$(CONFIG_NFS_ACL_SUPPORT) += nfs_acl.o
>> nfs_acl-objs := nfsacl.o
>>
>> obj-$(CONFIG_GRACE_PERIOD) += grace.o
>> -obj-$(CONFIG_GRACE_PERIOD) += nfs_ssc.o
>> +obj-$(CONFIG_NFS_V4_2_SSC_HELPER) += nfs_ssc.o
>> diff --git a/fs/nfs_common/nfs_ssc.c b/fs/nfs_common/nfs_ssc.c
>> index f43bbb373913..7c1509e968c8 100644
>> --- a/fs/nfs_common/nfs_ssc.c
>> +++ b/fs/nfs_common/nfs_ssc.c
>> @@ -1,7 +1,5 @@
>> // SPDX-License-Identifier: GPL-2.0-only
>> /*
>> - * fs/nfs_common/nfs_ssc_comm.c
>> - *
>>   * Helper for knfsd's SSC to access ops in NFS client modules
>>   *
>>   * Author: Dai Ngo <dai.ngo@oracle.com>
>> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
>> index dbbc583d6273..821e5913faee 100644
>> --- a/fs/nfsd/Kconfig
>> +++ b/fs/nfsd/Kconfig
>> @@ -76,6 +76,7 @@ config NFSD_V4
>> 	select CRYPTO_MD5
>> 	select CRYPTO_SHA256
>> 	select GRACE_PERIOD
>> +	select NFS_V4_2_SSC_HELPER if NFS_V4_2
>> 	help
>> 	  This option enables support in your system's NFS server for
>> 	  version 4 of the NFS protocol (RFC 3530).
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
