Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A722332E2A
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 19:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCISWY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 13:22:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51858 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCISVz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Mar 2021 13:21:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 129I9D9Q151364;
        Tue, 9 Mar 2021 18:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OKwGq2fzSus26kImRoNDHyoWTSzFFaL/cCzfomINls0=;
 b=rsltyfZCuuPqqM4HWSHsNhaNIKP8AWJ6Qd5/znE89+CPt7rBf5qvemo6jveIhLWJC1Vl
 pLXwH9J5siynkD4E9g+t1zxlWgPfduoz1X8dcTxj2vdbBgD1UMQn+kkdywFALxUqgynE
 TCbdr/fXf+Nhm8H8L4F36tj8A/dnmEIHAx3HFr6VSL3gbypdj7wPspcA/R+FqLc12+Dl
 lzrbe4s3dTMz/H8TOMHQTHg6V9kCOO3k1tq4PLHZ0Js++PzXhHi9PoJkxrzyLAGrriuG
 Co+/E0pcwsWxqO4qPw8VVo1Z/8OHgZNfWJC1G9ddxyzp45sZ84ZIokkvcxHOOC7Hi6il iA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3742cn8br1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 18:21:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 129I9Umt022920;
        Tue, 9 Mar 2021 18:21:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3030.oracle.com with ESMTP id 374kap35jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 18:21:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6YH9Bs91swM4kYzQ+jkX3GwvauQZTK0Dz8rtgO1VK21c3ExspQArA+hYQs2s4A+nMFIUff8TwJdeHEGGO6OyCaYyfTMT2lFYj1U2135rGhl2ShXhRR8CQ5SqdofvGhlHaIUd7HsrcjD+VJgyRYd1boFvBLUbzqWShtBpIADdPgovwAfoWWu1MBmSy28iu807d3yqUqq9DsM/ASGRVjwQtt1UM6xxk2krQ82uyTDw5acKcGj0mYudbvY/2VPsosGU8mH5LBicW68wmLViPRTcxuvAxFH8lR6hhjzAjH/E7wYbTGZqdFSxN3X3XxWN3f5sE9hiLbyoXF7Wbp37M2zFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKwGq2fzSus26kImRoNDHyoWTSzFFaL/cCzfomINls0=;
 b=N5wZ9NctzeuzOeyGuL3oW0hjDQ57fQJ8SzHXd2qbbyMFARhPCtSILX+8RKy7FOxcRisJOJu32OdsfsHPJwUO+aESlNnrcKnGrbPe8t92qjB07Dh0AL2ui/vKUyBmNWB0auAQw1p6Cd8KjP/+AvUuY9xjoW4Cd+ox9lZOwaMjxnAJ7mFL+lpCcdsiFFbx7hdxbX4xt1HnDCho3Ey/pIXa0GRu8zxhJdn4sde/7fD+PV/psJo6d6pDTpFY1x6h50/ok5ZhoZyUdo/U8Y14vuiEPRX3O5cowJoq942tQOtK9kjYlNBJc/r76B3F7rOW6idYgPk5fokUFQ4/+s3++zlLLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKwGq2fzSus26kImRoNDHyoWTSzFFaL/cCzfomINls0=;
 b=b9cP0I5teHAw4zFEUIoJJCbGg/M0gn3s3FrkEyfK3VDErjroA9f579lMLXT4Q70RERSye6wB5i33ZvPnHJkP2qXNNI4szDZrukdvxgz+529mMbkc5TkAwehG4ZfX14MboIRh0+1ID6o3IG8zKe1JRYPwJN75z44Ri2L/GjZSaHM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB4321.namprd10.prod.outlook.com (2603:10b6:a03:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 18:21:49 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::a5bc:c1ab:3bf1:1fe8%7]) with mapi id 15.20.3912.029; Tue, 9 Mar 2021
 18:21:49 +0000
Subject: Re: [PATCH 1/1] NFSD: fix dest to src mount in inter-server COPY
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        bfields@redhat.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <20210309144114.57778-1-olga.kornievskaia@gmail.com>
From:   dai.ngo@oracle.com
Message-ID: <88214ebd-c902-2886-d66b-2eaec0b14443@oracle.com>
Date:   Tue, 9 Mar 2021 10:21:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210309144114.57778-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SJ0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::18) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-172-102.vpn.oracle.com (72.219.112.78) by SJ0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:2c0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.23 via Frontend Transport; Tue, 9 Mar 2021 18:21:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8af6d6af-a100-4224-4a0b-08d8e328347c
X-MS-TrafficTypeDiagnostic: BY5PR10MB4321:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB43213170083F5B5C8B12127787929@BY5PR10MB4321.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7IoJiEFuDal1zCo/6lXDzlrqsHeVZ7i3Rx7v7Bqc500R9KC64IkpZLJcOhzIdYn9uXLsjDS0RgkD7v8/UHrTDn6dhtDlhd9uaHmUe7VMdTL3p5mWgwfYVtDjX1eS2mi5KBWJxz/Xrgu1IzuyWvvrSzkYQHlcSDkGL2hFB2p8iIfdyOEFdFpkex2sVJY/ijOrqlEzjD1T7Jo2xgbQCRJYrX9OLmUE1r8R0/wu8pWuVqig4gSMzxMx467oZ29uaHEidPM3StG9ZWVPAdAG1Pbo4EPzK+zZn+/EAtncWxSUZl3BbXhHs8lyZmoEjFH+UMKYvcM7T9vyr1U1U/Hy0iFrCxLZWlWcyZd5YC/qmeUI6kL88E4TCsUy4TH5owuGOq2mK6NGBlqA6/A9vRcFsuHzWqw4odmgZUrWgKjD4/4xNweiiTLPE83427Jr5vpgN8s6nKtYQ59OlkDnA6phXFvNkiy4DrAxA46xkd4jcCxDKoxgYvNksnBB16onELN8TZ23M7pNa9rDB48GR9LcQbYF5tNB3O+aGnBKjjTkA5gzYYIlQfnnwC5Mro2fjcKoAFHiJAH3HgV4k5WutH66cL80Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(366004)(376002)(346002)(2616005)(956004)(7696005)(5660300002)(2906002)(8936002)(316002)(83380400001)(9686003)(36756003)(8676002)(26005)(66946007)(86362001)(4326008)(66476007)(6486002)(16526019)(66556008)(53546011)(186003)(478600001)(31686004)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?amJyUFJpQUtWSkg5Q2NVZUxNY1cxSFJjL1ZML25WOGJ1OFdFRVVwQ05CUnFW?=
 =?utf-8?B?UzRCWmowTVNxc0dnb1RlSWl3OW1yekxqYnBKNG1EUzg1Y0RrMXZUR0NTNkR1?=
 =?utf-8?B?ME8wMWxlZ01kWHdINWJpR1QyWjZTU05KNEJPOEtNb0xaU1JZellUMjgyNU5X?=
 =?utf-8?B?ZnpmVm5tREdlaStCQjFoRVJCSTBQblgrTEFFT3FKakMwV1JQZ1J5YUZXdDA0?=
 =?utf-8?B?RktmWkJYbzJZUmU5M0VTV0dDUmlKK1FFMFBRUWk5TmY1Vm1WS3U3SnVielY1?=
 =?utf-8?B?aHNCMDVudTlES3ZYRUZXeUEvNHN0RktXZlUydFYzZTlYbkI3OGxMUUI4ZXE1?=
 =?utf-8?B?ZnEwSHFEY3Fzc051SXNCaE5Ca20yNW9mOHUySllQME5KTkdnVk9TYnZwdzZY?=
 =?utf-8?B?NXhSMkRoUXpsbENwTEp3bkw1VThiZVo5TXAvdXFaTE8ySXB4S25YeXhvQnVu?=
 =?utf-8?B?L2RlK3JqNFNWdHFzUC9pSC93RUlqaTRoemdsNFRTZWsxQ0JJZHd2RmRVQS9B?=
 =?utf-8?B?ekhRLzJoQ2Z2R0Znb3NORlpuNzBsa3J1TEhHWGdpWDEwd2h5WjVxbjB4S3Ft?=
 =?utf-8?B?MUVDdzhjR3Z5cE16dHNoTElVQTNoeCtSYVgzd0hWOFlITVVYWlRkVmhvQ0dF?=
 =?utf-8?B?KzV2MzdHUEhnM0JmbVR4WWVNSEdpVW93YmgvUk9WbFMySnl4TUZKZWhmOFY2?=
 =?utf-8?B?cy8rdEVvTWx0WklkSGNZVjRUQmpCZnZKSjJEQ01vcktYVHA3c1pDRjJqQW4y?=
 =?utf-8?B?Q0ZXbXJaOU1hVnlUQTFVOEtWSm1CT2tjZWxnckFnTm5qbXlBcVRnNnlvQlVr?=
 =?utf-8?B?Q3pQUEN1d0hBaWxGbkt0TWhmaldsV2VSd0lwcnBlNEFybml1VWF6d3JILzNk?=
 =?utf-8?B?NnpwRWk0TW1tVHRSZEpaSUlHKzlIY05CcGVvWHVUUEZSV1BOV0R0OTZqSkVQ?=
 =?utf-8?B?UXdVZEcvb3BteVBLTkdHRFFXRHI5RFF1UjAyN3dsU2svVFhDWFZzVDNITitK?=
 =?utf-8?B?aGZmRHZ0OUdiUW1zWVhMY1ZIeEREU2hxZS9oeGRFazFCSCtvNDNKZThmU3No?=
 =?utf-8?B?SURpbGEwVXVPUWVIVE5xakZaUjBWOUhXbFAxUGdpL3VkeFRJTlFYZDRpQjdx?=
 =?utf-8?B?YkNySzNBM2ZHNTNZU0w1Mk41TnErb1U3VWg1MlluVnJodVVjN29nYmt2Q2ZG?=
 =?utf-8?B?ektaekF0SWxoREc4RWkybVgxZUx4cXlOM3NBSVNmRG1xVTdodjhRUS9Pakd4?=
 =?utf-8?B?UmJCN1FkcEh1ZTNmZVN4TytnaE9DeG1jeGl1bzFmNTBtT0hyb1pYdnkvdm1E?=
 =?utf-8?B?USt1SXY2MjNtK3cycEtYNyswZ2NRZkZhUC9HNnhma1dJQlJJSXdqZHFucEJF?=
 =?utf-8?B?aG1qVkE5T0Nydy9YT2k3UXp0dUh4NTRZS2tSZG1LbFFRRE9QRkYwMlVMbVJU?=
 =?utf-8?B?V0NYQTRhVXQzL3lmcTJUSDBGTWlRNDVibXFReU9Wd3ZvbEh6RlVVMU5zd3ZB?=
 =?utf-8?B?S0hzMVUyYzBMVnhhcno1T3Vnb2hlVFJSK2l2c01uSEJPQTN2N210NndZOWFj?=
 =?utf-8?B?YU9laEhOaXRPNytaU0crKzlWdlRqdUxOeXFMQWhIWVBFSVB0c09yUDIvYWow?=
 =?utf-8?B?Wm16WEM4WmdURmVWWXB6U28rNVhjVkk3Z2w5ZWNkaStSMmV6U3A2dE5pOFR4?=
 =?utf-8?B?aHlLaThIY0MwcHArVXd1YmFWWGwvckRnODJYbkdNMzQ2K091REo3VEtXcFZk?=
 =?utf-8?Q?tDESJ/z5gsfAPTLFansO4kDt5SGNZVOr7g3yzLD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af6d6af-a100-4224-4a0b-08d8e328347c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 18:21:49.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anaRgla/aJ7g0RG9eKxAUJ5JBxocR15OT6Ubgcef479EZbYZiLCS/1B0CRjDp2vq7XzQEGDkDF0MXaQVqeeH2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4321
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090087
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103090087
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3/9/21 6:41 AM, Olga Kornievskaia wrote:

> From: Olga Kornievskaia <kolga@netapp.com>
>
> A cleanup of the inter SSC copy needs to call fput() of the source
> file handle to make sure that file structure is freed as well as
> drop the reference on the superblock to unmount the source server.

Thanks Olga, I tested the patch and verified that the source was
unmounted and the file resources were released properly.

Tested-by: Dai Ngo <dai.ngo@oracle.com>

>
> Fixes: 36e1e5ba90fb ("NFSD: Fix use-after-free warning when doing inter-server copy")
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>   fs/nfsd/nfs4proc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 8d6d2678abad..3581ce737e85 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1304,7 +1304,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
>   			struct nfsd_file *dst)
>   {
>   	nfs42_ssc_close(src->nf_file);
> -	/* 'src' is freed by nfsd4_do_async_copy */
> +	fput(src->nf_file);
>   	nfsd_file_put(dst);
>   	mntput(ss_mnt);
>   }
