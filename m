Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED82536854B
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Apr 2021 18:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhDVQzK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Apr 2021 12:55:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12394 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236287AbhDVQzJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Apr 2021 12:55:09 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MGqgbA005076;
        Thu, 22 Apr 2021 16:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9pxOuDwWZtZ+ye0QgivZx1eDVikoN2EZMJYDAp6jkZo=;
 b=C3zJfzL2iJ0MQUr4OvQH7BkLGsSMsf0XnqUm6OTB3w04ura7JD/pntFSaPiyE3tGlFKe
 HEPe3UeOAU+uiWxfBlCoS1ktlp4UZnqZhKK+9wjtYHFZI0+/F94P7kAoPEX81QKdbU2q
 NyDWSexsgcHNoev7hXzrVCBIwjfYKyUIniML9EEp7pTYz+IePB3rwyiRtfA7B0wLJk40
 0KJE63zUrN1487wwohJJRcgn9tSUGM0j9+4sbmM9JZ/o4B9uxv901J9rWpb/3HGbDwN5
 X0BA1HxiuKXPm7bcSYFd0U9HEw6zWdhZEkx1Jf4DuwJl/UBHAF82Cywtht5xlCQfpFFq bg== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 381tw0h3c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 16:54:31 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13MGsURd106082;
        Thu, 22 Apr 2021 16:54:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3020.oracle.com with ESMTP id 383cbd27fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 16:54:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNXQEE55u3rHJoPweaRE1Js5upzLkWlNuPVCwC0/eTOrzsntRIImsOa57eTtCdHsOE3Qvqi86wrOgOZMfTm4s1HZDd3vwLbc5CpqDWJhWPX31n9Qe/iHK7OMlgAi/gKBTZcrLMIOgTcMEppK1fRb7tTO3HoAL2iyzekCd453ocidmUjgjDyZjL67v1SwWJ+Ie9KFhs8rnYVYezclkKHxWxlFmg1yVgkogqcxCdjPKwYYXXFsPp535tK8TSj/Fy5pNuw+BzOTP2IGIpnqSDaZfu751noOodFB+fN/P4kYSf+ipa7A4uD0iyTqv9W6vKmlv+Xgg+lvhC98gM6ZJSebuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pxOuDwWZtZ+ye0QgivZx1eDVikoN2EZMJYDAp6jkZo=;
 b=f8arOTjieRzml23mYwmBDvHTKgRLEOzDZvlyRF4Rr+dZcNs2mKt7D8kGWYJW4ju/KuVNIfHVTUG/wcHN7ivCaI5cGT3ZNQHSG4jL+EOXlllbrTBFA95qA0/pnDRb88cycghx/tbytTK3hJyw0FMZA6rSxm57Gwbejbo6lbsY/1S8Ccf7rMFkvXH/3hmLhZeZKAuIxC2lKAeu8RN99ispkIOwb4LUWBd0CHGPZq+laJGMAmYK01/W3JEdw9C+2P7M2n9Np1tR3FVY2qvNylm2bV9uVYtxyAH1jAlopYzSJv4OV7VFilaPdoeb6Hvt/RNgHN6hWhFFBd7s3fkpaViT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pxOuDwWZtZ+ye0QgivZx1eDVikoN2EZMJYDAp6jkZo=;
 b=ypUieyfl+jR6k9YoSI98Z2PiZPc/MxbpLdAR/iexX/xjl06MDdJ4BBlQPgVp+UXGpmeXXh5WaQvPl2diT63Mmepya9skgvIbTw2K9awOyosKQi8ma23VXJW5AE2pdab6vvueKrvVNOKLBxAKeq0jmas61+qppRBtBt0eVCcg36g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3269.namprd10.prod.outlook.com (2603:10b6:a03:155::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 22 Apr
 2021 16:54:28 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f58e:50cc:303e:879%4]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 16:54:28 +0000
Subject: Re: [RFC 1/1] NFSD add vfs_fsync after async copy is done
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        bfields@redhat.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <20210422161922.56080-1-olga.kornievskaia@gmail.com>
From:   dai.ngo@oracle.com
Message-ID: <22046fa4-730f-4e08-cfd8-eadc5fe098b3@oracle.com>
Date:   Thu, 22 Apr 2021 09:54:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <20210422161922.56080-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SN4PR0501CA0014.namprd05.prod.outlook.com
 (2603:10b6:803:40::27) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-240-87.vpn.oracle.com (72.219.112.78) by SN4PR0501CA0014.namprd05.prod.outlook.com (2603:10b6:803:40::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Thu, 22 Apr 2021 16:54:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc2215b2-be7f-4410-b333-08d905af4b08
X-MS-TrafficTypeDiagnostic: BYAPR10MB3269:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3269732957F48CCC6074470F87469@BYAPR10MB3269.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qO67l0vfdP2tPWunerDTqe/yM2+1g6+FPvi16QsXKVmKtJioDsVhJpVVibxoNfE/9qw5kyHgjrCrHcZD3Ar1WRQj/eVHcO1GpCZ4bvz81U8FEosDXXWA1blB8Qn7KwDJpHTMBgzgpXoFytbkoT+ozgLedwrXHdXu2VrY1mUzEcIsIFzABdyDx/nhOh640bO3IqVYvlpCcV0sXuh+kt54QQAzkfoxImO+ECAY//j5vtaojqXUeOyTZUF6QPwJefLV3wGspEsat6OOd4Z9yaVxQQMR605Gm94UvGiBFhNJ7MS5svoYgvmMYME6bbhqecTGo/LUWaJ5wLPOx3MP6YLrWVF7BeoNQU1x86CmU4a1qYg5MNczfYiP4CfY3d+rlb+hE0wHTljzc10/dAp0QoLlknR1dvuIlV3lf59eyNdw3Z9JjQEWj38KTlPR2LD1VEBwYDVIU40qpMJ7Ose/kJsT7VspJ3cFj61BEmf8U53nmPXk1qu125I9cdoBEvoD+gefepsncJ60CvA7wV9vgHhchSqDsQwVg/JTt7cmiufD4crzZuqF1nU3JUIBKAB+1Hu4OQiezNSdgkhLMD/oGt33N5fDkpbLt+zB/3P8nAx9Cqwq24a/hiBRlKK5foKqn6bD9trSO4UXaZy4wiq6IvlBXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(376002)(346002)(136003)(86362001)(53546011)(2616005)(8676002)(36756003)(31696002)(83380400001)(478600001)(316002)(26005)(2906002)(956004)(66556008)(8936002)(9686003)(38100700002)(4326008)(66476007)(5660300002)(7696005)(16526019)(186003)(6486002)(66946007)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SWtrZTFHcnJ6eE9QNnVZS2R4Y0lnWkw2ZlNrVk9YZDdpWmdmR0MrcXdwZWxr?=
 =?utf-8?B?dnJHbHJ5cUxiNS8rRDlSZ1RreHJzUHc4bEloOUFXWHRJQVFNcmVZZ28rNHRw?=
 =?utf-8?B?RllhL2ZVTUJ5d2VzaHZpTU1TZ252MjArU2RjUnpqUmR3Vi9ibjlBQTdlem9r?=
 =?utf-8?B?bzdNRFZPUkczTUVrNElSNnYwUmRoZ0h3T2xpNXZzMzk5QkFMNmM2Q3RoWkw2?=
 =?utf-8?B?YXpFS1VjbW05WmpHb0Jxam9GdmFWb3ZZSU42SktmSXl1R3p1OUMrazN6Y1BM?=
 =?utf-8?B?akFMaG5tYVMwUUZXNFBEWlIzNmdyWk1wT0x1cGJibU85UnZUdFppd0sxTkw1?=
 =?utf-8?B?SkRLaHJCOXB4ZGVnbCs2QUFockVxRTJ4NlVJSkpCakJYZWl4aWlWc2RRRGJG?=
 =?utf-8?B?TzBWY3hsRlRzY1ZUZmlSNitRR2Z1RFhVaGpUemhYNE9UZkhYalNVc0k5QzJP?=
 =?utf-8?B?YU1CM0tURFlvcnlLbHFTcWRBTDhFRmprS2R0WXZaR2xDMkhYNFNiRmdFQk1t?=
 =?utf-8?B?dGE0aWtlbnEyNDJSZGN3dWtDVUQ2Zm9jbU1GSTBGZFMraFFkMjl6NTFrU2sx?=
 =?utf-8?B?V204Q1gzQ2piMkJNUEVXRzJMOGJBTmtxaVd3d1RlWDU1d1JPazJQdzA5WWNO?=
 =?utf-8?B?aHVwRDdVSytOMEFUeXFPbnpnVEdwN0JXa1VPamZvSEsyWndFcUx1dDdyRzFh?=
 =?utf-8?B?MjN1cW9BRWtJQ2o5d1h5cExlOHN5alowaFBtanQ5TTE2Z1FRNXA0RFdSbllB?=
 =?utf-8?B?UHRoVXRNdVNhaTdEem1IWlkzVXlzVVBReVhveW9CRTZxczdBVGJIWXZZbjB0?=
 =?utf-8?B?MENsekpsbXhCRzNnMWVvN2R0SUp0dmFVT0IyMHZkNHN6Y29qeFBoNU9vZVdJ?=
 =?utf-8?B?TUxpWWZFSHNpWDdLNWE3TEd1bUJxc0FiU2tNbWpCcHNFOEtxdGZFRkRjczBM?=
 =?utf-8?B?UXJucmROeW1seExDdkdNbWJadVVESmw3NVNtbzVmUmtKVXNmaDlKWHFmODln?=
 =?utf-8?B?VzYwdzE0Q2pFMG5DRGxBWm1xQlY5ZUZuaDNSY0hsRHVtczZ3cFJaUzdPd0g3?=
 =?utf-8?B?bGpmbTZ1RnlqOUlNZHB4Q3dWaGNwcmw0Nk9ZalNFWEVtbDhyYktMK24zY04x?=
 =?utf-8?B?Tlk5YjZoNHhaaXNDN005Y0lMSW5vWUowdHYvdk1ac3U0UEVEWUV0dktYWnRS?=
 =?utf-8?B?Yi9aK1dlUzZxdmJjNTdkOHFVRTgvNFIydEN4ZlAvWlByZEpZd2pJMmJXSUZm?=
 =?utf-8?B?M3JCQkxxU1U5Ym9SWFRGMU9JeCtDMUtKZkNIMzA0QmxZM0Jsb1YvWnNIMlFJ?=
 =?utf-8?B?YndFWTdzOG56aFJ2SjUydEdySkRNU2hDL2tCNk5JWGswRlFicEsrbUdEMWVi?=
 =?utf-8?B?VjZaQTkzUlVFK1gyZHVxS0phZ3hTcmQwZmtndytXQlgxN3NhSG04TjNGRnBl?=
 =?utf-8?B?NTcza0ZHZVZjckpwcEtPOUpDYm9LRzlvRThsVC9wQmNUNEh5cWxMMUhOcUVq?=
 =?utf-8?B?QTZvTkVKdGhJTktzbGU0OGtqYktpMVFSampuOEZmcXUyRUx0ZG0rZjFvRGpp?=
 =?utf-8?B?MTNiRzErdWVOU291WnRTSkhOY0k2MU96Q25hbENlRDk3RGZzR3RjRnFXbFJM?=
 =?utf-8?B?aCsyWEJLczFoMFVaZkhIN3ZGSXhQUzM0Sjg2cEl1UTV3Q0NEK0c3c0p1RTBF?=
 =?utf-8?B?UVBqazVNdk5EcHpwSGp6endLbEgySUo0VlYvTWNtbGxoc3FzQ2VycXB5Y2pC?=
 =?utf-8?Q?WI7n8ThVrAqmtTMXc/WzgqbTSrjqtHxptIyFida?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2215b2-be7f-4410-b333-08d905af4b08
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 16:54:28.8232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FG6lg+7ceFjZm94Q1YDlPlK7aE/5mUple7/i/Pv33ns6iCmfnwM90m8kIzD65B7zlGB7sBP9vvklvj+nTWHx/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3269
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9962 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220126
X-Proofpoint-GUID: 608Ch1aDvcU7k0FdhlcTIpBkANYWcftV
X-Proofpoint-ORIG-GUID: 608Ch1aDvcU7k0FdhlcTIpBkANYWcftV
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 4/22/21 9:19 AM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Currently, the server does all copies as NFS_UNSTABLE. For synchronous
> copies linux client will append a COMMIT to the COPY compound but for
> async copies it does not (because COMMIT needs to be done after all
> bytes are copied and not as a reply to the COPY operation).
>
> However, in order to save the client doing a COMMIT as a separate
> rpc, the server can reply back with NFS_FILE_SYNC copy. This patch
> proposed to add vfs_fsync() call at the end of the async copy.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>   fs/nfsd/nfs4proc.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 66dea2f1eed8..c6f45f67d59b 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1536,19 +1536,21 @@ static const struct nfsd4_callback_ops nfsd4_cb_offload_ops = {
>   	.done = nfsd4_cb_offload_done
>   };
>   
> -static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
> +static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync,
> +				bool committed)
>   {
> -	copy->cp_res.wr_stable_how = NFS_UNSTABLE;
> +	copy->cp_res.wr_stable_how = committed ? NFS_FILE_SYNC : NFS_UNSTABLE;
>   	copy->cp_synchronous = sync;
>   	gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
>   }
>   
> -static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
> +static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy, bool *committed)
>   {
>   	ssize_t bytes_copied = 0;
>   	size_t bytes_total = copy->cp_count;
>   	u64 src_pos = copy->cp_src_pos;
>   	u64 dst_pos = copy->cp_dst_pos;
> +	__be32 status;
>   
>   	do {
>   		if (kthread_should_stop())
> @@ -1563,6 +1565,15 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
>   		src_pos += bytes_copied;
>   		dst_pos += bytes_copied;
>   	} while (bytes_total > 0 && !copy->cp_synchronous);
> +	/* for a non-zero asynchronous copy do a commit of data */
> +	if (!copy->cp_synchronous && bytes_copied > 0) {

I think (bytes_copied > 0) should be (bytes_total < copy->cp_count).

-Dai

> +		down_write(&copy->nf_dst->nf_rwsem);
> +		status = vfs_fsync_range(copy->nf_dst->nf_file,
> +					 copy->cp_dst_pos, bytes_copied, 0);
> +		up_write(&copy->nf_dst->nf_rwsem);
> +		if (!status)
> +			*committed = true;
> +	}
>   	return bytes_copied;
>   }
>   
> @@ -1570,15 +1581,16 @@ static __be32 nfsd4_do_copy(struct nfsd4_copy *copy, bool sync)
>   {
>   	__be32 status;
>   	ssize_t bytes;
> +	bool committed = false;
>   
> -	bytes = _nfsd_copy_file_range(copy);
> +	bytes = _nfsd_copy_file_range(copy, &committed);
>   	/* for async copy, we ignore the error, client can always retry
>   	 * to get the error
>   	 */
>   	if (bytes < 0 && !copy->cp_res.wr_bytes_written)
>   		status = nfserrno(bytes);
>   	else {
> -		nfsd4_init_copy_res(copy, sync);
> +		nfsd4_init_copy_res(copy, sync, committed);
>   		status = nfs_ok;
>   	}
>   
