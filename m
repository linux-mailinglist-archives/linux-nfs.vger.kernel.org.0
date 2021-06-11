Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8BB3A3E30
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jun 2021 10:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhFKIon (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Jun 2021 04:44:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59722 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFKIom (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Jun 2021 04:44:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15B8eJxl155480;
        Fri, 11 Jun 2021 08:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BYKozb0P/z5XPVbeYDSC/UU5JLgmYniNFmJMKl25Gbw=;
 b=rviqJGLNlMq8ONmt9vuPMUjXM0MInzJfSZv/s4qkEIEebLYfmduG1uRb4WeHXYsSE3IN
 ULZZvNJBT5zJVL6rckrEKEvoGwrJaUJ2CYqH9dHY/OHq/V3sUnVXlDuDNObaEnr//jly
 Ez3LWYpNkhkSCXIBKg7G9/UHryejB/+EQbrOahrkgp69ojWjtijPsdFNaPzlulqZFFO+
 aYHU9UCXPx2WeQ/2ikWEBGdtEp6X0gMJwW6SwfFU0aSBa2Assv7JJMPeE288VTpL1k1+
 KEziN5BmDdfTunpfMJwxyZv4GCQQfW4UULmn6skSULK6L0vY/1A6uUi16sSZP4TrzVmG lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3914quvkmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 08:42:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15B8adtk039926;
        Fri, 11 Jun 2021 08:42:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3030.oracle.com with ESMTP id 38yxcxbwxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 08:42:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmQ5mfN+rQySD6CjvSU8+ZOyd1XLzHDYV3is4LSvYF3ziNv/SAsfuuLagPJX0a419G2mDdhBw/DZfyYWWNxw5sOvPUtsfmyXfY2H18b+Ss6clB8JOJMdApwiFBTZenqXN1eBDf/H9B+8jprq7R1tXpFg7wyZxDWJCnKK6MnEyGcFeSR8n088KtgXqQCMs905Ar2denvZcy/VtXVWSC5CDl+V7UeZSDLQW4Ipbo1D57tlOak1oA/vAYylhsCO+ImM+zK8kHuE1ht+X5Gbj7w2CKzbeNdJehg4vbCPk4p3JwgpUcdahlo6TY0Z/qzhmOODhwsKlPdg9iqsIxPOufLYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYKozb0P/z5XPVbeYDSC/UU5JLgmYniNFmJMKl25Gbw=;
 b=V2BR16ZhzcVKKqPhvr+GrAzyLN9Nv3ALctFbKuwDt7lwvifQyknfNIBsvraxlnI6JajP2dLM6mdPYiReWRBphuQuwCGY2TswmKJVg2kHsCXWVJVIDEXCT6A8GbFNPPJjhjwtNUAIj/RXGzCU6sonGB8eiwhDu+KzPQYjtvmTxGzkAp9WQO6/4/nDgsfySzdD60EdLpIUJzZhtT600if1X8eSQ1FIJ5ulufQ5mS/7+qHd8piHoEOCbtp28/E61TGOQFuO0SmcBcgBF3qChGPQNFMp1qgNBGfMGyh+xf8k9u05m1hLeBiKOcOhYG6VMDTIFAiv7JBBHJN4a1Rnvgp+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYKozb0P/z5XPVbeYDSC/UU5JLgmYniNFmJMKl25Gbw=;
 b=Ic1y3Epo85ysgxH6KFxnDYlic+nB05ZUua3tBj1c8NlwKDlgk5m5bDWblccrSgXZ/dG4B4rG59khIGq9g5S8U/qBX6L+ZpHLckhhNFP6Zko7R/wbiFR5LLuoqOZ2/nN1pumYPu2kSwbh6dIajilsSYb4bBgqgnIBYF31xa5eop0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3559.namprd10.prod.outlook.com (2603:10b6:a03:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 08:42:34 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::ec57:cc81:ad54:10be%6]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 08:42:34 +0000
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
From:   dai.ngo@oracle.com
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
References: <20210603181438.109851-1-dai.ngo@oracle.com>
Message-ID: <d5c68f04-4ebf-842f-dc20-ba5c99a96382@oracle.com>
Date:   Fri, 11 Jun 2021 01:42:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <20210603181438.109851-1-dai.ngo@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [72.219.112.78]
X-ClientProxiedBy: SN7PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:806:f2::28) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-250-203.vpn.oracle.com (72.219.112.78) by SN7PR04CA0023.namprd04.prod.outlook.com (2603:10b6:806:f2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 08:42:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0dd7079-15be-4a1f-7cb5-08d92cb4db98
X-MS-TrafficTypeDiagnostic: BYAPR10MB3559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3559D5E0EAF170FA89EAA07887349@BYAPR10MB3559.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:407;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 462wO+MRrlJ2SNwGQiHD2SOGBGvkXC60Ot0nQ3E94M2hHj/i5GWkKwzZl4euwtBGGd4Fm0N4jy+lhoC8MerHulaLhlAeh8kVKa/EjK5q+Dy80NNw51L8pyzqXPiUf8J6FBNUj6+wWpbN20Mvef7APAa3ypSQ4B+J4GUaAyfjPaKcf6op33E653flPJQO+FJGrzdnc5m4SYVjqFsJaK9/8iEeKNoKMXOdGGXTvywQsAVqRd6UO5SLfttam/NQ/OiLGlzvRNFWY6LE4tfZqL03oAwMuaFR4kzxV+9LdhqMQ0nO/y0r+yL0+tisUILn5r7ed4IXCbEA+RzbfvvcMNDh4KkrO0vih0ekAYmh2/AGDZTjJCgwqAP/aXSiGvTMhJuh9rORAbPI5fJDwGia2ZtekUMTb8Wv9cqOl9Qx27IqS7A4aEZV9RJzC41CzjNaIsEyQXm5WHxsPdkjKLPqZjV2x1qygSToJSO28zXvx8TWVOQFOTG9nWuUJk9aFSkuTFs0thdbBvnOwbFNX0O3CiqjWnRHCoUxdE3SfKtD3GMUtwQezsOcOgwufdTNw6Y+qaqsoa9jMHG5ZZ6WTse9zwKZx0Fukn0dVR3bZVmNfkDYa379lBAuS3evV6seMjTh0jN4WHhTA6kNhZJvONQahFGRzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(376002)(366004)(346002)(38100700002)(53546011)(8676002)(31686004)(86362001)(4326008)(956004)(316002)(16526019)(5660300002)(7696005)(8936002)(6916009)(2616005)(186003)(66476007)(66946007)(66556008)(6486002)(36756003)(2906002)(83380400001)(30864003)(31696002)(478600001)(9686003)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkhaWnA4L1FRVnZnZFFvQy9TUEtGRkpOK1ZCMzJrdzJkSzNML0g4ZGg1Y3I0?=
 =?utf-8?B?UjhmL1M0Z0ZqejEvMDlFbEFFWjdqSFpyNjU2Kys1aVkyUjNCelhyVEtSVzJD?=
 =?utf-8?B?NVkwb1N4Q3JSNm10Y0RBdytRVjJCMXFOWlBtNUU5OHZuYmVWUktHRm13Rmgx?=
 =?utf-8?B?THVBOHpxSVUwQit1bFM0eGlERnlpbWdKcDRKNGxDOFplK21IYStuT0V2K1RH?=
 =?utf-8?B?N3dZckdBakVrSXdYeWRLNjgwMkRDNzhmZkhVYkhFQXR0bWplZzFQb3E0ZHpp?=
 =?utf-8?B?TzQvVjRSeHFiR2dvUDNZYjZZbWk4bjVxV2dmZXFvMTUrQXZ3ZWQrSUYzMWpP?=
 =?utf-8?B?cC9XUXMrdWhwT0VUMTdZNUFZZHp1bW4wZHNSMG1zdENGOXRsOFNDTjhwbzI1?=
 =?utf-8?B?M1BDczNUY01DSnlMQnZ2NzFsUkxkK0hpeC8rbVh1Sy9DTjd6WHlvYXI2UTZk?=
 =?utf-8?B?QlJ1TUlQWlozOG51NDBZOGp3dnplRGpjVDZNcHdJWnp5M1NvdHJKUHcxYzB1?=
 =?utf-8?B?c1NJei9aR1F1NlJHWDJtaWNVbmJBWitHVFp2SjZVOHFrWlI4RmRzSFkxeUgx?=
 =?utf-8?B?TDU1aXBUd3ErS3V0d3BkN2RtRUs4R1BSdHoyRDRmNnhndm5YY3lIYjJrU004?=
 =?utf-8?B?d1JKMmw0T3Q5Qjhldm9xM3d6cDF1VGhBOFRYMUZFZ2hLcFFhYlBaNi9jdlFm?=
 =?utf-8?B?dG5ydUNSd2YrU2tTV3ZOTkVYS25jSDl5UjFscDNLY0lGRlFhenRZOGR1Qjhn?=
 =?utf-8?B?akZEZlVRbkxKOW9xb0pNNEozWkdNYVpGa3QyK1RxbklRTkxlRlNNWmRtSUlR?=
 =?utf-8?B?SzdpcXlqNFVJUEltOHIvRU0zaUlWRUd3WUhJaGtOKzBwUEhYYzFCcUdpMkcz?=
 =?utf-8?B?aVd1d2JWVkJhaFFGazAxNkptbGdRZkl3bEo5Snh1L0xmWFZoU2VQckZVVjBS?=
 =?utf-8?B?OWxSTm51RVdsekZ2OHhLanpQSlNZQWNjZ0N2RlBkR0xwOFljM3hCNHA5TlBu?=
 =?utf-8?B?U2FzbHlpV0s1RWpSR0pUKzhWUmlVQjB3U0hEcGlzay9tNU56NTlDSnBhTVpz?=
 =?utf-8?B?THRqSlhmS1BZYUxnekNBaW1wYlhoSWZiVVVsNCs4NTkwbTRPUnNRZmF6MUZD?=
 =?utf-8?B?aTJIbDhndWExNUJqS2tRQjZCSXVNT2w5cFBSbGZpSnZpS1RLYUJ2VjUwaWVJ?=
 =?utf-8?B?SVNvOStnWEtxMXhtQ3BmN3h0V2hSUjREMFE4ZXV0SlJjTDRpYzdhcU04NCsv?=
 =?utf-8?B?Y3RqQW45Rkw1dk9XNkdianc5cUJ3SFErU0licU9GaU0wMisxK1pVQ2tQbCti?=
 =?utf-8?B?Z1Frd2N2Q04xaGhZS2pFMDVzTFNzY2RqeWxvOHZrWDdwQWY4ckRxNjlTaGtt?=
 =?utf-8?B?Q3hXS3hkUkhVMW9ETVBmQWFVRFdpc3V0SkIyMDkwcXo3Rmd5WVpXOXg0QXNK?=
 =?utf-8?B?eUtWUGRDeTd3MjlyS05qSzhqcXFHVDJqbUZLakwrUSsvSmh5bVZNeE9TZ3k2?=
 =?utf-8?B?ZDBJbHdySzRjT1YwelJvZEprMmRmYlRIVnRZK25KUWNGbjBhNWFvMm9kOHRz?=
 =?utf-8?B?Z0hRSG8wTUVxa081ZWQzdmlFRjE3aXNzb2ZJbGlHKzIwYThlYlc1RUVNcnZB?=
 =?utf-8?B?WTVxVW02VGhCaDdQY3A1U25Bay9DRkNGTGtQTHgvNVBPNzdVeVRjc1k5SVZO?=
 =?utf-8?B?cEd1b1VPZW5hTlVmWkZZRUg1TlB1aGYwM3VsendsUG5veVI5bFRGajljcUc4?=
 =?utf-8?Q?6EpoD4lpqXeppYNVfgxUiX2etAiMWbTOrqxL5ND?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0dd7079-15be-4a1f-7cb5-08d92cb4db98
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 08:42:34.1138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SN69V+eBKLiH6iJCjZ+nNkwxsmZOjDxLx6DTjNtMRFO/IR+7lK5rqMrJiTD3/cin5lE9LEUOarMDyALW+VYzNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3559
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106110055
X-Proofpoint-ORIG-GUID: XU-utQkxCop6vYAgs7DjRJMR80-g_75B
X-Proofpoint-GUID: XU-utQkxCop6vYAgs7DjRJMR80-g_75B
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110055
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

Just a reminder that this RFC still needs a review.

Thanks,
-Dai

On 6/3/21 11:14 AM, Dai Ngo wrote:
> Currently an NFSv4 client must maintain its lease by using the at least
> one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
> a singleton SEQUENCE (4.1) at least once during each lease period. If the
> client fails to renew the lease, for any reason, the Linux server expunges
> the state tokens immediately upon detection of the "failure to renew the
> lease" condition and begins returning NFS4ERR_EXPIRED if the client should
> reconnect and attempt to use the (now) expired state.
>
> The default lease period for the Linux server is 90 seconds.  The typical
> client cuts that in half and will issue a lease renewing operation every
> 45 seconds. The 90 second lease period is very short considering the
> potential for moderately long term network partitions.  A network partition
> refers to any loss of network connectivity between the NFS client and the
> NFS server, regardless of its root cause.  This includes NIC failures, NIC
> driver bugs, network misconfigurations & administrative errors, routers &
> switches crashing and/or having software updates applied, even down to
> cables being physically pulled.  In most cases, these network failures are
> transient, although the duration is unknown.
>
> A server which does not immediately expunge the state on lease expiration
> is known as a Courteous Server.  A Courteous Server continues to recognize
> previously generated state tokens as valid until conflict arises between
> the expired state and the requests from another client, or the server reboots.
>
> The initial implementation of the Courteous Server will do the following:
>
> . when the laundromat thread detects an expired client and if that client
> still has established states on the Linux server then marks the client as a
> COURTESY_CLIENT and skips destroying the client and all its states,
> otherwise destroy the client as usual.
>
> . detects conflict of OPEN request with a COURTESY_CLIENT, destroys the
> expired client and all its states, skips the delegation recall then allows
> the conflicting request to succeed.
>
> . detects conflict of LOCK/LOCKT request with a COURTESY_CLIENT, destroys
> the expired client and all its states then allows the conflicting request
> to succeed.
>
> To be done:
>
> . fix a problem with 4.1 where the Linux server keeps returning
> SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after the expired
> client re-connects, causing the client to keep sending BCTS requests to server.
>
> . handle OPEN conflict with share reservations.
>
> . instead of destroy the client anf all its state on conflict, only destroy
> the state that is conflicted with the current request.
>
> . destroy the COURTESY_CLIENT either after a fixed period of time to release
> resources or as reacting to memory pressure.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>   fs/nfsd/nfs4state.c        | 94 +++++++++++++++++++++++++++++++++++++++++++---
>   fs/nfsd/state.h            |  1 +
>   include/linux/sunrpc/svc.h |  1 +
>   3 files changed, 91 insertions(+), 5 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b517a8794400..969995872752 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -171,6 +171,7 @@ renew_client_locked(struct nfs4_client *clp)
>   
>   	list_move_tail(&clp->cl_lru, &nn->client_lru);
>   	clp->cl_time = ktime_get_boottime_seconds();
> +	clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>   }
>   
>   static void put_client_renew_locked(struct nfs4_client *clp)
> @@ -4610,6 +4611,38 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
>   	nfsd4_run_cb(&dp->dl_recall);
>   }
>   
> +/*
> + * Set rq_conflict_client if the conflict client have expired
> + * and return true, otherwise return false.
> + */
> +static bool
> +nfsd_set_conflict_client(struct nfs4_delegation *dp)
> +{
> +	struct svc_rqst *rqst;
> +	struct nfs4_client *clp;
> +	struct nfsd_net *nn;
> +	bool ret;
> +
> +	if (!i_am_nfsd())
> +		return false;
> +	rqst = kthread_data(current);
> +	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
> +		return false;
> +	rqst->rq_conflict_client = NULL;
> +	clp = dp->dl_recall.cb_clp;
> +	nn = net_generic(clp->net, nfsd_net_id);
> +	spin_lock(&nn->client_lock);
> +
> +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) &&
> +				!mark_client_expired_locked(clp)) {
> +		rqst->rq_conflict_client = clp;
> +		ret = true;
> +	} else
> +		ret = false;
> +	spin_unlock(&nn->client_lock);
> +	return ret;
> +}
> +
>   /* Called from break_lease() with i_lock held. */
>   static bool
>   nfsd_break_deleg_cb(struct file_lock *fl)
> @@ -4618,6 +4651,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>   	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
>   	struct nfs4_file *fp = dp->dl_stid.sc_file;
>   
> +	if (nfsd_set_conflict_client(dp))
> +		return false;
>   	trace_nfsd_deleg_break(&dp->dl_stid.sc_stateid);
>   
>   	/*
> @@ -5237,6 +5272,22 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
>   	 */
>   }
>   
> +static bool
> +nfs4_destroy_courtesy_client(struct nfs4_client *clp)
> +{
> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> +
> +	spin_lock(&nn->client_lock);
> +	if (!test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ||
> +			mark_client_expired_locked(clp)) {
> +		spin_unlock(&nn->client_lock);
> +		return false;
> +	}
> +	spin_unlock(&nn->client_lock);
> +	expire_client(clp);
> +	return true;
> +}
> +
>   __be32
>   nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
>   {
> @@ -5286,7 +5337,13 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>   			goto out;
>   		}
>   	} else {
> +		rqstp->rq_conflict_client = NULL;
>   		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
> +		if (status == nfserr_jukebox && rqstp->rq_conflict_client) {
> +			if (nfs4_destroy_courtesy_client(rqstp->rq_conflict_client))
> +				status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
> +		}
> +
>   		if (status) {
>   			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>   			release_open_stateid(stp);
> @@ -5472,6 +5529,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>   	};
>   	struct nfs4_cpntf_state *cps;
>   	copy_stateid_t *cps_t;
> +	struct nfs4_stid *stid;
> +	int id = 0;
>   	int i;
>   
>   	if (clients_still_reclaiming(nn)) {
> @@ -5495,6 +5554,15 @@ nfs4_laundromat(struct nfsd_net *nn)
>   		clp = list_entry(pos, struct nfs4_client, cl_lru);
>   		if (!state_expired(&lt, clp->cl_time))
>   			break;
> +
> +		spin_lock(&clp->cl_lock);
> +		stid = idr_get_next(&clp->cl_stateids, &id);
> +		spin_unlock(&clp->cl_lock);
> +		if (stid) {
> +			/* client still has states */
> +			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> +			continue;
> +		}
>   		if (mark_client_expired_locked(clp)) {
>   			trace_nfsd_clid_expired(&clp->cl_clientid);
>   			continue;
> @@ -6440,7 +6508,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>   	.lm_put_owner = nfsd4_fl_put_owner,
>   };
>   
> -static inline void
> +static inline int
>   nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
>   {
>   	struct nfs4_lockowner *lo;
> @@ -6453,6 +6521,8 @@ nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
>   			/* We just don't care that much */
>   			goto nevermind;
>   		deny->ld_clientid = lo->lo_owner.so_client->cl_clientid;
> +		if (nfs4_destroy_courtesy_client(lo->lo_owner.so_client))
> +			return -EAGAIN;
>   	} else {
>   nevermind:
>   		deny->ld_owner.len = 0;
> @@ -6467,6 +6537,7 @@ nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
>   	deny->ld_type = NFS4_READ_LT;
>   	if (fl->fl_type != F_RDLCK)
>   		deny->ld_type = NFS4_WRITE_LT;
> +	return 0;
>   }
>   
>   static struct nfs4_lockowner *
> @@ -6734,6 +6805,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	unsigned int fl_flags = FL_POSIX;
>   	struct net *net = SVC_NET(rqstp);
>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	bool retried = false;
>   
>   	dprintk("NFSD: nfsd4_lock: start=%Ld length=%Ld\n",
>   		(long long) lock->lk_offset,
> @@ -6860,7 +6932,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
>   		spin_unlock(&nn->blocked_locks_lock);
>   	}
> -
> +again:
>   	err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, conflock);
>   	switch (err) {
>   	case 0: /* success! */
> @@ -6875,7 +6947,12 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	case -EAGAIN:		/* conflock holds conflicting lock */
>   		status = nfserr_denied;
>   		dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
> -		nfs4_set_lock_denied(conflock, &lock->lk_denied);
> +
> +		/* try again if conflict with courtesy client  */
> +		if (nfs4_set_lock_denied(conflock, &lock->lk_denied) == -EAGAIN && !retried) {
> +			retried = true;
> +			goto again;
> +		}
>   		break;
>   	case -EDEADLK:
>   		status = nfserr_deadlock;
> @@ -6962,6 +7039,8 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	struct nfs4_lockowner *lo = NULL;
>   	__be32 status;
>   	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> +	bool retried = false;
> +	int ret;
>   
>   	if (locks_in_grace(SVC_NET(rqstp)))
>   		return nfserr_grace;
> @@ -7010,14 +7089,19 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	file_lock->fl_end = last_byte_offset(lockt->lt_offset, lockt->lt_length);
>   
>   	nfs4_transform_lock_offset(file_lock);
> -
> +again:
>   	status = nfsd_test_lock(rqstp, &cstate->current_fh, file_lock);
>   	if (status)
>   		goto out;
>   
>   	if (file_lock->fl_type != F_UNLCK) {
>   		status = nfserr_denied;
> -		nfs4_set_lock_denied(file_lock, &lockt->lt_denied);
> +		ret = nfs4_set_lock_denied(file_lock, &lockt->lt_denied);
> +		if (ret == -EAGAIN && !retried) {
> +			retried = true;
> +			fh_clear_wcc(&cstate->current_fh);
> +			goto again;
> +		}
>   	}
>   out:
>   	if (lo)
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e73bdbb1634a..bdc3605e3722 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -345,6 +345,7 @@ struct nfs4_client {
>   #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
>   #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>   					 1 << NFSD4_CLIENT_CB_KILL)
> +#define NFSD4_CLIENT_COURTESY		(6)	/* be nice to expired client */
>   	unsigned long		cl_flags;
>   	const struct cred	*cl_cb_cred;
>   	struct rpc_clnt		*cl_cb_client;
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index e91d51ea028b..2f0382f9d0ff 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -304,6 +304,7 @@ struct svc_rqst {
>   						 * net namespace
>   						 */
>   	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> +	void			*rq_conflict_client;
>   };
>   
>   #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
