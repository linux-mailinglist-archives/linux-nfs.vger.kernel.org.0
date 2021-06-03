Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D3239A5AA
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 18:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFCQZK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 12:25:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39852 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFCQZJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 12:25:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153GFtpw085818;
        Thu, 3 Jun 2021 16:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bDFBbvXvvo5HvfKznBt2Lhk/Mx/OIC5YzPDHuoBRHls=;
 b=v4qxSGGmR9YeVUy4hhdl49t+ZCEsIFizsk4Pm4Y3O67aEC01mgi2WExtdPRQMg21vVCQ
 4ymR5zH831Xou37xLq+pDqneiYiJiMdTHe0uw8qLuYzPC9VZ7kWtTFl9u9kzga2q3XK1
 4lEVwLzI9ug7HOzZVyMf1OZ45zgZDft/Uyx5yNAIHdqCmaGt+Ih3/xuolcrt9FY57A7n
 7/wVcM1IElehIu3AwuqgeTA8JAhbBJ+EPcL3yF6/zvR5IYqSq9duedSKbCmO3GXOFBZ3
 y3R+uNGQfalOpsS6xlGhGg8BKTEUBEs9sNwJt9NqhwlRUfxxp2/Psaz/WlcMtlUydrk6 9g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38ue8pku7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 16:23:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153GFTb8010811;
        Thu, 3 Jun 2021 16:23:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3020.oracle.com with ESMTP id 38xyn0wss4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 16:23:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIPK61T9ANrcFCVGCcrF8pN3sAwtaupTBaXroxz30/dJbfoxIIlveSNFMeP1R7it1tTEN50eej27l8FXfqZaYJ+wa5iAyLxhT5EGwF9Ig0xTY4FpzlThNRKInPxVmFTcrUlMfmB2y+WMIpMc20aoUvNcxFJnzNa/9WzXT40Y8lSVYxNtuDez1azD+U7jTeU9MRQh225kumw/nQv4ayr/pReNrenJM0t/Rh9aSTKuHa/iHXsKKD18A19izccDd8J++M+Jb7C7nHQQ5PEXosgrmMP/Pa1Um8lZnaXpnWQ4WVosAv1R12aQq/Z6sIivgUjrxpWhZ6U1xNhxI2YqtqHazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDFBbvXvvo5HvfKznBt2Lhk/Mx/OIC5YzPDHuoBRHls=;
 b=XRPkXfL+uEEtIizNGOILSkwSkATlSPTJw/6ORvQ8A4PItUcjOx1rMqmrAo9dA1SxPiQ/aCHBC0B66cadxRGP9PIU41hGyQ9IzcsDx7pTt+NzA5xclJZAhOwe9sLPJKEWXH4zhwREV+8AM3t56z5mPflZE1Wc8Ohq52g6UGdJIyzoZ0h+T9oK8nPzkJDWePOcQKZmfXNUOZY3v85Nl6F5jSK1YjFB7QNSEorVmOPMlJkQKrdSZ3EvN23lsYI8hcpiRGoJWIXUvYJ7Rh2LSc3xJK45fcovMPfeLbiqmyQ18XvblhebKdrrdsInbB8mNWEZ8iCL07FQJibO/2ygAsuKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDFBbvXvvo5HvfKznBt2Lhk/Mx/OIC5YzPDHuoBRHls=;
 b=Sja1GFP2WYS8k/LDABJKjOIACJWryRD2eNoJbvNYZVZMwacA/z2by/daIO7k1WsjwRpKLUdbzMp8Nu04fVEbC7CDh5VtefHnQWdkhvopX+XFzSOEWKAxtQZYV7NCqn6ndsSbaM+1Mh3qUz0YG6evaWZSdcZyBsG7ty4WPvcrSjk=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB3858.namprd10.prod.outlook.com (2603:10b6:a03:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 3 Jun
 2021 16:23:11 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be%6]) with mapi id 15.20.4195.022; Thu, 3 Jun 2021
 16:23:11 +0000
Subject: Re: [PATCH -next] NFSD: Fix error return code in
 nfsd4_interssc_connect()
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
References: <20210603135145.972633-1-weiyongjun1@huawei.com>
From:   dai.ngo@oracle.com
Message-ID: <521b3f52-f205-a9a5-cbce-c36365057175@oracle.com>
Date:   Thu, 3 Jun 2021 09:23:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <20210603135145.972633-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SA9P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::15) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-229-179.vpn.oracle.com (72.219.112.78) by SA9P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Thu, 3 Jun 2021 16:23:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f3eee59-1eee-40d0-84a7-08d926abe1aa
X-MS-TrafficTypeDiagnostic: BY5PR10MB3858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB38582E8F9DCEC443DC8C8AF0873C9@BY5PR10MB3858.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3pB0EusQzEECGKmuxIj4RTeVM7r9cTvhqeD6hmoHhiRQ8M5zqr8ijf+Fd6zMxO8o5WwmN0wyt/KxBaa3/FQZ03k4BYbPF4zv6n2BHqquzWIQKZhalWGuysFet5kKkgcLMKJyvolDobHkpTvZBSrKTWka2KeBuK9wT8HurQyV504ZqE6kBUkZCcAgDmPVHOpnx77xDuH7ky1GuCxmfcC0BNWL1Z1JIUuwMdZrY5uceOgaSd57Ylb8Mr7vXsPt894ZOg2f1laWRTS0haX+Jzg1jriqq05Z21K/iDHsNc7zdEBacNz1VPvwa/Rd64D2vgbkrkjOdv/7c56u10r+jI9QMvxXSv+4S+JXgqyqBO1zO4gmYMvm/sc+/MsR8yblupRE8yTe4EQoqEjzxwLJaJwaT7GYtRbHITbJSgst8UbabyMe8//Zej0cr0czU/Gl6i9R5s53o5Xe9Fk5iANJs6rizSuGqngpPQISlyyYGDVyEzD0tzaG4queM2CNUpax08mBZMMPIQwjXZ6wfDfnfObONomGgjFCXbtyeulcDXDnhhZTKy8uBiYNv1TYhkrinVpSetPLgnJgAECrxDbBjoL+7Wflold1FX8TMc0lnxYLyCyOozULapCAQbjr0xHeRqZliONHbYqAIvq1e6ee2MeJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(346002)(376002)(36756003)(16526019)(31696002)(110136005)(2906002)(38100700002)(186003)(4326008)(53546011)(316002)(66556008)(6486002)(478600001)(9686003)(2616005)(956004)(66476007)(66946007)(8936002)(86362001)(26005)(31686004)(7696005)(5660300002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dFRBMWUxMEY0Ymh4OHA3dno1NHY4SnFKZ2RCVVFldGFpYm13UUUvTyt6bVEy?=
 =?utf-8?B?Y1UzbWpIa0NrN3F2R2NnYVgwQnZlZ3dWdVl6MVZEK0h0Z1NpWk5JQ2hXV09U?=
 =?utf-8?B?RkVvTWh5TGRuNHF0azRZMFJ0MEMvTHNqMlMyOS9uSUhjOWI4VGY2OFFaQnBh?=
 =?utf-8?B?K3Irb1VtYjN3a2xtbzNkdllVV1JNMkR3QnBIQkV6a09CSisyWW4vNEhpV0VL?=
 =?utf-8?B?c0dzOGVTNCthL1d2SXlQa2gzWHcycGQ1ZGlOdytWQWdtd09HaTJxcWRhR3FM?=
 =?utf-8?B?SUhpdFdIcUVaTGRtZ0MzeG5uaEwvbFBIb0VTMlBxY2JLUUZlRyttOEVSL3NL?=
 =?utf-8?B?bGU5d2syT3F2SkF1VEpXNW85SHBRZDlLaGIrOEQyZ2M0RmVNdW5IdjRGakg5?=
 =?utf-8?B?RlFxY0t1dzhGeGYrZEprSldiWXE5QVFUSkJGL3dyUUI2TDgvVUVVdHFNc0I4?=
 =?utf-8?B?UUJISStLWFUxNDdsWnVIK21Cd3NjNk1OYXBnWVhaVENUaXpXc2RSOFk4MVdj?=
 =?utf-8?B?ay92QTlHNi9FVER4ejAwaXZkaDY5QUliUng0a0hvWHVTbVlvRVdyY041RXdH?=
 =?utf-8?B?OXJZRFU2VVJLOGVJdWk4L0J2RTgrRjRQK1NYZDZqb1ljanhZWHJSbFIxZHVi?=
 =?utf-8?B?RVh0T1ppRFVLSi8wbXFBdDRNWEpNcXdDQzYzWG13UnlOU3hOUVYrSGtIYkY4?=
 =?utf-8?B?SmNuaVdQSndud0N4bVpxOTBuU1JacitWbFYrUUpQd21KKzdNKzFEZGY1cmxT?=
 =?utf-8?B?bW1EMjBqalBDR3daWGpyYndLNUlyUHJYVFp0c0JaK0ZySDhFb21UbE9tb2Yx?=
 =?utf-8?B?NXlYQUhsUnZEckFtRTVIZzhzdkdRUTZhcDhqVEZFZzJIWjd1b0Q4Z3NtZC9i?=
 =?utf-8?B?dWplNi9vMXIwZ3hXdjRsK2JMU3JwLy9GQTlrNjBrdTVyY25YR1o1Z1A1dmN0?=
 =?utf-8?B?bmRMOUFEVFZHdEN4M0gzOGpSRHRHK3ZyVmoybHM0RkdrSnRIOFFxeno2Zy9D?=
 =?utf-8?B?TTd0bDdIZ04ydnZTQjkrOHd4M3pMZXZBUmJBNGs0ZDEvY3RBSkJYbkg1Vjgw?=
 =?utf-8?B?RlpBMkhVall4dExJQ2oyWFdGRk9mOGhpcnRHejJwTk9SYTlrVXRneVQ2d3dq?=
 =?utf-8?B?eWphT0JZYjBHcE11SVQvc251L3EyaVdxYlV2WmV3ZkQ2OHFFRjBSaUlpMFMv?=
 =?utf-8?B?OCsvSXhOS01pR1hoZHFVN3lDNTQ4UWIrT0FkT2F2SzFxVk83c3hGbFc4KzZx?=
 =?utf-8?B?UEdNZlFtUlhHQzdkTHJTODBhTXdFTVBGcHBzS2E0Y2JtUGkxUjlYdUdtQnpC?=
 =?utf-8?B?NVJEcVNycFNkeWdHT0hFVkR2ckVTOUNHRU5pa2grZVYvaEt3eTl1bzVNZmxj?=
 =?utf-8?B?QkVWTmIxbHNsL2hKaFRYY1gxWjk3SUxrWXN1dm5GWjAvcUxLMGdsZ2NBcHAx?=
 =?utf-8?B?bmtMaVhxcFJzOHpFOTBJWllwSFZkL1M4Y3V5WUw0dkt6K0dLVXBzS2YvYUU3?=
 =?utf-8?B?cEx5bnNVTEE5bU1wbmowWTFCOGlMVVdrQlAvZjJKT3IrRFIrSTVCYVRoR0dC?=
 =?utf-8?B?SFVvc0lqTG5tOVRZM0wrV25YblE1MDJBMjNHbmM3dHNnajFPWi9jaWdFSHZP?=
 =?utf-8?B?L2p5NG9YTlFnSDF1eDJmUzhVQWFLWC93U2F4RStZNkg3VmVZV1dPN1RHNm9C?=
 =?utf-8?B?NVR4OHBJbnhVSVZxSzBtcUYzelJvcXdUTUVxQzJtdEkyZVlwM3BmZUc1alFm?=
 =?utf-8?Q?m3BK9VSljZpyD5lFZJwN5W3r07swNXbNFWwRSgE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3eee59-1eee-40d0-84a7-08d926abe1aa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 16:23:11.8640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1m05mWU8lSDMokRQ/r2+DYp0pVs40bGN8NE06i3HPfqEBv/XEKfBWBQ2FPRgkrLnM9iPAIIsoUvH6OG7hsUOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3858
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030110
X-Proofpoint-GUID: u6kYQ2E6Aqv_75scUxK047n7Q5iim0MQ
X-Proofpoint-ORIG-GUID: u6kYQ2E6Aqv_75scUxK047n7Q5iim0MQ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106030110
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 6/3/21 6:51 AM, Wei Yongjun wrote:
> 'status' has been overwritten to 0 after nfsd4_ssc_setup_dul(), this
> cause 0 will be return in vfs_kern_mount() error case. Fix to return
> nfserr_inval in this error case.
>
> Fixes: f4e44b393389 ("NFSD: delay unmount source's export after inter-server copy completed.")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   fs/nfsd/nfs4proc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 0bd71c6da81d..2bfb6c408dc6 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1323,6 +1323,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>   	ss_mnt = vfs_kern_mount(type, SB_KERNMOUNT, dev_name, raw_data);
>   	module_put(type->owner);
>   	if (IS_ERR(ss_mnt)) {
> +		status = nfserr_inval;

I think the correct error code is nfserr_nodev.

-Dai

>   		if (work)
>   			nfsd4_ssc_cancel_dul_work(nn, work);
>   		goto out_free_devname;
>
