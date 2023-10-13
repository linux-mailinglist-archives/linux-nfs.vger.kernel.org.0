Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD0E7C86B2
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 15:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjJMNVa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 09:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjJMNV1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 09:21:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F355AC0;
        Fri, 13 Oct 2023 06:21:24 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D7NuxU009518;
        Fri, 13 Oct 2023 13:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=1+6neCIBZs1NE6sdWeGGyK8vxBUGOg4W3UfaEoGlO0s=;
 b=Ql7+6I33yL1KzfoX8aDW182B8u+5mLwlKKVgtupfh+iPwnIbDNfP/TuACqRc/CaR7yRj
 NP4gd3+sRp8y+KmHy83gsrdEjTzVH79r0kBOthrV1ZX2bhGJ7XrbYOEow/55erUfS/El
 mSpLfvaHqNoyNVvE7MijLkQW8aZiqUeBAQOJOCc6Jfpgc9Rgsjrz17btno2UAK2ZUF22
 gTXYzli1y2zC8mME35Ylg/hP6WDFzUBtxZvltZAvihfe9GpKzAc8L9wiSvUlNRFTfW40
 W/JoEnE1jYbkenQRFOLKRhVGaM8qEI1ljqZPj97ithsjIQqPOcQho0vsPotKsBJwMmMX Xw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdw37b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 13:21:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DDCoQh020186;
        Fri, 13 Oct 2023 13:21:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tptcjjred-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 13:21:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJmIQmgLOjevzGZqepKeNmb8hRSuVp+geWmc9dOw3pm5hybIxBJFJrJHicV1AoWPwwgBErm0obZJzvH37ZFHwtFuXq1xMx+oFguXRnWq6AuUmUyk+EH9dXmkiKi1Mj8BUkz0o2SQqCUG/HxG2bxgWyFaD4mqXJNOI8cVNSSz0rQArCmWd47hywt2UE9RzaAUZ/VM3T/twHaLtDncfxXJL8uA0g9bK7Sd4XjE9uPTLTJkGnmG1bYTaJRZZI/cyLQKl9KfN3lVGnVYcMwKQ4N7E/QSoceNsZHJENGKF8+uSrg5y0yQoVDtp/Sko1kIu2vfupjUhoIBCslCtqR0T9KQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+6neCIBZs1NE6sdWeGGyK8vxBUGOg4W3UfaEoGlO0s=;
 b=Cx6KomjugTyJ0lMjIj+yOimYFwhENB6YUMTZn/oAqWRj2WegerSMVml7zksKdX9d7h7AU/NIBr1wMTv4OMAusd/NVO4l1KASsYqqj48zcHJXK8NYgzmiDZDCBXuvX0C90GpPLe0dvKbqLLLr2FlvFDlZ131uUi54HLPjHku1kLOz/4jifOoYFdPSA0tAAOrCUcCGSPBU3GqYqxFVQ7CBSxgOy8cXCDiLvmXaYFJLq9jSw7Dc59cq6goV/gdmAOOUTqBzGhgVTmQF3HHtYyyntXfutAYKdug+i8p+OMsR2XV4na5yYdSJkf6ej05h9F0OQVmC7/l5f0h2LRIHZk5wyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+6neCIBZs1NE6sdWeGGyK8vxBUGOg4W3UfaEoGlO0s=;
 b=I9tjQ/m/ezmluSriuO+QgmmOOAbzyyMdq63vqQ7rr9nmiHnZQFD7TF2IuDeoxEzdqYzE1Yj+tgV3sH43nzuaEMmKdsZTdHkTk4bgeChoKgHvLEBvE6X0yO/c1zZ72J99kRcamSv6nw/soguWbKFjBVewhPFAZQQMVkvyZrERzLo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7674.namprd10.prod.outlook.com (2603:10b6:930:c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 13:21:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 13:21:11 +0000
Date:   Fri, 13 Oct 2023 09:21:04 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: new Kconfig option for legacy client tracking
Message-ID: <ZSlEQLGtXRP//k2L@tissot.1015granger.net>
References: <20231013-nfsd-cltrack-v1-1-5d8a3a6a39af@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013-nfsd-cltrack-v1-1-5d8a3a6a39af@kernel.org>
X-ClientProxiedBy: AM0PR10CA0040.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYYPR10MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: be2b367a-9f6a-4d72-d88e-08dbcbef447d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+YFJZ8AVvWPCZ88SXjIv3pj/7jGaPK6slOPuLg7X5zZRR+PkzERz2S2AJ8lJw4IXJrnyyXoaQHDnAIbD7XsLSoBboCjMEpSN9nP9jfDEbyWPzpTq+g28VdTMsOv3B9ti4TbYgWU71ThfI11vDzzFclFXiW52774U/vw/G2zUlbZ9guF8/DtcqM4gpeL44i/ktlV10l5jNa/paiPbceQ12DLpE8V+bqUDsCkKANeA86R9sK4h6U3vPxluOQNabDUzBK/4Rkh9Q2qfiG7Gbkpz+f8J1L2gvKdb09L6HAdaeoxnWXApP1jJ02H5ovDoALtM7hI3omDlzFaHeENbX+y5+f0m429TzbEx8f0N8ThJIrpuVJ/VHRmRa+FyHRX06cXGZZF5DNucszeFAdjsNxmCamaoFactObi1z9n3HwEeVqI1bCUAj1nLK9pEzbMl7El5PgOWOdXG/Fn+ZckDN6g8C3YRcDHK2FDYpyk8nVrYnMFfiQh9Y+wICfaurIqXWmyndm7sejhhjblQS0A+ibdjSrNPpVBxtqdD3U3kl21E+JRL0aYchatumCBeBB+ZhGZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(6512007)(9686003)(478600001)(5660300002)(44832011)(8676002)(26005)(4326008)(86362001)(30864003)(2906002)(8936002)(66946007)(66556008)(41300700001)(54906003)(66476007)(6916009)(6666004)(6486002)(316002)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qzoPgObvnqDXGHJMAD5MsjKX5J/RkLmfOeXRcw0+mJYbwDixMHldJzwLqV/h?=
 =?us-ascii?Q?lAEc0eTr27Urc/b3XXxJRC9K22nO5eA+kL4g/4plpVVJEBUkYIjkbX5OzuPR?=
 =?us-ascii?Q?URlgw4PtpWNT5uzvafdk+BvLoj9mOj9MWW4nUqM6ldKTt3OStS/8Amp0t9UU?=
 =?us-ascii?Q?sNzMTGuKG/xymuXCkct8E17fukkIEDkiO+2saGahv2iwxRL2F8XLmPvMYqxU?=
 =?us-ascii?Q?Cem4kjxHyZbFFa7vQ3xMp9BR9UemnPficAwC5E6LOtDo0TgzDcZZ40smr8VH?=
 =?us-ascii?Q?yD0QOUtjWxW/z6BI46n4Iek3kXUgdSaqmXRZgi1DY7JxyqWQZo8A3E/fd0Xv?=
 =?us-ascii?Q?HHAE4oOHirKhGjEomyL/h4M48nUYFaydTdXjXKRRcRvdw9GpAOzekCRgXu6f?=
 =?us-ascii?Q?ogxlIrwDhJX3/FQsJlUm4EiMU6RiG/0iuFbBQJUgGdrMMWmyTpmGUSBjk6le?=
 =?us-ascii?Q?E4PZmC+by3R4w6UFzlPdNvCwORJk8FmfbAWTNNT2b3BDizlBjsDCdNSLpys3?=
 =?us-ascii?Q?G66EhsQ59Rc5UMf5cubSvQztIxm1emuHMYm5aHja505S1yYZTgDJPPQ3v863?=
 =?us-ascii?Q?EIQjyUO+KrxRDJg4vSchK0ehvoffVIkdZTOhq3HQcJmsMabgedbjiqVAUrEB?=
 =?us-ascii?Q?M+ilA2heOaadbEdIw2PHnAaEh5zmrb3bI3sohVWHZTR1pnCJh37PnZFSsfBG?=
 =?us-ascii?Q?Qr8GXSN8BAfRQb94Wyi6A171elXd32wFBJ+hJ3iTG1j2ij9Uq6+tRoEH28sX?=
 =?us-ascii?Q?BTUOKwQU9Ks+Jze6W6mawBrKyzUspOWvEQayUfKoVuZO/dsS2le8tayGSNCj?=
 =?us-ascii?Q?M7AcJ4KKOANCQcsphTs1rgNfbDloTBae5kNT8QNG3zDDDa+huAT/DHroK9K2?=
 =?us-ascii?Q?y0YdQVggizSzyzvt+UGjmfaQZi/6BugGO2lYytuYTjKxftt3zUqLHwXlr3oO?=
 =?us-ascii?Q?lFd+EjIVxyTV0bxa2bGaGof8w9lrhRHEfkY6kq4R2LxbltkqxXI4ohbgmq0D?=
 =?us-ascii?Q?8sBwml9rjrJMvGXWu6ZmJ9ksL6K6uro3b7pSIXcw/R8p4+Hxo9bTB397MRg6?=
 =?us-ascii?Q?MINrodPMvNm7sBY1KDI3njywD1a4Zo7BJ6pc+o2FlahYyafW8XCaiK8++lEv?=
 =?us-ascii?Q?WCBXJ6joKKLtK/yYG1/4Pi/7IRqVzKPwQnjaJSdTuxCw7ZwLsaDBhaD6QpYS?=
 =?us-ascii?Q?0uL5AvP2rg4s6aqKp/8mqujNn/u8wdSw+/sQFqWOSlVCGueARNgJfql3QLWq?=
 =?us-ascii?Q?xyTlaxhH888vCcJv3Yk4+gP4act/oquBMFJ2vgE226pZmeh76sJMQ4Sg3eeP?=
 =?us-ascii?Q?rGbe3DNZvVWhdvudqRBbF4iKH/ONs2rQYAxjMH9nZrd/RWaBf2uWmHEZCNIf?=
 =?us-ascii?Q?ioCPVx3yvNH8m5N6PccyEkQcPEEdpzZOebtthnWe6++VmLvqfA6dg+cpmK9k?=
 =?us-ascii?Q?5I8vCKvPyPxhHPL25RQCkX/mHg2dM1y2JH0tLpvTY0HqBTlcCed3ZrBgvmAU?=
 =?us-ascii?Q?MO2kdHkJbkgh6oRUSTOc7+s3nTmywHhldWwnpq88iDtdiqAD8YM0H0JB2ssb?=
 =?us-ascii?Q?ZBZuj9QjYjB/upwRk+MPQgr46I2mjSzp2K9tCi79?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yQ0Ty1a4YtpJYe82eF2Hdm6e9eo3KMDYrb4c/tsGnWcT4VWwfsvfxR+h3EEJ2NLaPeijspo6cJzJznb3pAZTT6b7MOnB6HsSxdLrGkv4tNGD7CfGvOEYjgXE1pGxTHBwpPX9E6GZPhAROYiin6NA8sdSSpReHlFH9aF1xRioDykrdp+p3GqBc+N402kZUg1JqApkR8xzhQhHb/Vfyho+11WEGjEw/9JEvTTzXqAKEVWb12ptT7PxW1mFKiV6vdf6PTxKxNsBlZHSaWTLlkkaYAu0kJ88lMbpuopiet4vwn8MTm0l2ukcjxbA9L/LyHbzGL5si0NI/+t4X2XSaCu56lr9xygAFVzMZX1N29oC9YjSH69AXtoYlcxh8TTKL/Dz2MKMnPEy3GpN6bQAnwNqDU4dx0QMMQC6iBMEfqkVU6PK/6/TvpQwYXQqFMm8EuDGN53aMiE9lMyOwHCjVQugYMtdJQtOVaUFBNPEfRwC66I/8uy9sngM9+vYM1ZP5Pm0RobzPBxcxzlYVByxNiNDxZDbRLBS6plUYCuaowfjITiKskLnvPLx7DVsQvC13vRCNWYWca098cmH2EmyMGtuO7MtGeGnQ3UnlZfc8kLohGWLW1SNEFdSOHuir3g9w0TOHnJhfweArX3MHIph+jxhGFGMT9OBoD81KmiqFOgX+pZ7Ho7Lx/pExMgGIkW6uXfsH4T1IV2byz9tC6SB0uklwc4mjg7lpVidwBjknbdid7sSdztIM9GJHHuPLkoVEDPG+Vr62HNhOvjb7vRy8r0BVe/GgGuGDIkgSbYNP5I5h0ASjLek+N3pYjn8vqJFMtv0XfQqPBwt56Xo7LLHk7gN9mRyFIL+3em49GMEjoLQ2ZsbDyMah0iWSWaAXsPJiaCr
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2b367a-9f6a-4d72-d88e-08dbcbef447d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 13:21:11.1159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXSRnJVmF4kreBAvZNmYfldCXFTcgqaEcIK+PRHaVGmylfdL2XApQ8RjN4JT30M6jY7wLL2/F3Z1BrVn5LJSZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_04,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130111
X-Proofpoint-ORIG-GUID: 1C3xfCg7sw5dpzb5l7QXT_w5W1S1rZ1u
X-Proofpoint-GUID: 1C3xfCg7sw5dpzb5l7QXT_w5W1S1rZ1u
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 13, 2023 at 09:03:53AM -0400, Jeff Layton wrote:
> We've had a number of attempts at different NFSv4 client tracking
> methods over the years, but now nfsdcld has emerged as the clear winner
> since the others (recoverydir and the usermodehelper upcall) are
> problematic.
> 
> As a case in point, the recoverydir backend uses MD5 hashes to encode
> long form clientid strings, which means that nfsd repeatedly gets dinged
> on FIPS audits, since MD5 isn't considered secure. Its use of MD5 is not
> cryptographically significant, so there is no danger there, but allowing
> us to compile that out allows us to sidestep the issue entirely.
> 
> As a prelude to eventually removing support for these client tracking
> methods, add a new Kconfig option that enables them. Mark it deprecated
> and make it default to N.
> 
> Acked-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Now that we've really settled on nfsdcld being the way forward for
> NFSv4 client tracking, put the legacy methods under a new Kconfig option
> that defaults to off.
> 
> This should make it easier to eventually deprecate this code and remove
> it in the future (maybe in v6.10 or so)?
> ---
>  fs/nfsd/Kconfig       | 16 +++++++++
>  fs/nfsd/nfs4recover.c | 97 +++++++++++++++++++++++++++++++++------------------
>  fs/nfsd/nfsctl.c      |  6 ++++
>  3 files changed, 85 insertions(+), 34 deletions(-)

LGTM.

I've kind of closed out 6.7 at this point for anything but fixes.
I've applied this to a private "futures" branch, planning for 6.8.

If you think this should go in earlier, let me know.


> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index 43b88eaf0673..272ab8d5c4d7 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -158,3 +158,19 @@ config NFSD_V4_SECURITY_LABEL
>  
>  	If you do not wish to enable fine-grained security labels SELinux or
>  	Smack policies on NFSv4 files, say N.
> +
> +config NFSD_LEGACY_CLIENT_TRACKING
> +	bool "Support legacy NFSv4 client tracking methods (DEPRECATED)"
> +	depends on NFSD_V4
> +	default n
> +	help
> +	  The NFSv4 server needs to store a small amount of information on
> +	  stable storage in order to handle state recovery after reboot. Most
> +	  modern deployments upcall to a userland daemon for this (nfsdcld),
> +	  but older NFS servers may store information directly in a
> +	  recoverydir, or spawn a process directly using a usermodehelper
> +	  upcall.
> +
> +	  These legacy client tracking methods have proven to be probelmatic
> +	  and will be removed in the future. Say Y here if you need support
> +	  for them in the interim.
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 3509e73abe1f..2c060e0b1604 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -66,6 +66,7 @@ struct nfsd4_client_tracking_ops {
>  static const struct nfsd4_client_tracking_ops nfsd4_cld_tracking_ops;
>  static const struct nfsd4_client_tracking_ops nfsd4_cld_tracking_ops_v2;
>  
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  /* Globals */
>  static char user_recovery_dirname[PATH_MAX] = "/var/lib/nfs/v4recovery";
>  
> @@ -720,6 +721,7 @@ static const struct nfsd4_client_tracking_ops nfsd4_legacy_tracking_ops = {
>  	.version	= 1,
>  	.msglen		= 0,
>  };
> +#endif /* CONFIG_NFSD_LEGACY_CLIENT_TRACKING */
>  
>  /* Globals */
>  #define NFSD_PIPE_DIR		"nfsd"
> @@ -731,8 +733,10 @@ struct cld_net {
>  	spinlock_t		 cn_lock;
>  	struct list_head	 cn_list;
>  	unsigned int		 cn_xid;
> -	bool			 cn_has_legacy;
>  	struct crypto_shash	*cn_tfm;
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
> +	bool			 cn_has_legacy;
> +#endif
>  };
>  
>  struct cld_upcall {
> @@ -793,7 +797,6 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
>  	uint8_t cmd, princhashlen;
>  	struct xdr_netobj name, princhash = { .len = 0, .data = NULL };
>  	uint16_t namelen;
> -	struct cld_net *cn = nn->cld_net;
>  
>  	if (get_user(cmd, &cmsg->cm_cmd)) {
>  		dprintk("%s: error when copying cmd from userspace", __func__);
> @@ -833,11 +836,15 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
>  				return PTR_ERR(name.data);
>  			name.len = namelen;
>  		}
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  		if (name.len > 5 && memcmp(name.data, "hash:", 5) == 0) {
> +			struct cld_net *cn = nn->cld_net;
> +
>  			name.len = name.len - 5;
>  			memmove(name.data, name.data + 5, name.len);
>  			cn->cn_has_legacy = true;
>  		}
> +#endif
>  		if (!nfs4_client_to_reclaim(name, princhash, nn)) {
>  			kfree(name.data);
>  			kfree(princhash.data);
> @@ -1010,7 +1017,9 @@ __nfsd4_init_cld_pipe(struct net *net)
>  	}
>  
>  	cn->cn_pipe->dentry = dentry;
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  	cn->cn_has_legacy = false;
> +#endif
>  	nn->cld_net = cn;
>  	return 0;
>  
> @@ -1282,10 +1291,6 @@ nfsd4_cld_check(struct nfs4_client *clp)
>  {
>  	struct nfs4_client_reclaim *crp;
>  	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> -	struct cld_net *cn = nn->cld_net;
> -	int status;
> -	char dname[HEXDIR_LEN];
> -	struct xdr_netobj name;
>  
>  	/* did we already find that this client is stable? */
>  	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
> @@ -1296,7 +1301,12 @@ nfsd4_cld_check(struct nfs4_client *clp)
>  	if (crp)
>  		goto found;
>  
> -	if (cn->cn_has_legacy) {
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
> +	if (nn->cld_net->cn_has_legacy) {
> +		int status;
> +		char dname[HEXDIR_LEN];
> +		struct xdr_netobj name;
> +
>  		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
>  		if (status)
>  			return -ENOENT;
> @@ -1314,6 +1324,7 @@ nfsd4_cld_check(struct nfs4_client *clp)
>  			goto found;
>  
>  	}
> +#endif
>  	return -ENOENT;
>  found:
>  	crp->cr_clp = clp;
> @@ -1327,8 +1338,6 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
>  	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>  	struct cld_net *cn = nn->cld_net;
>  	int status;
> -	char dname[HEXDIR_LEN];
> -	struct xdr_netobj name;
>  	struct crypto_shash *tfm = cn->cn_tfm;
>  	struct xdr_netobj cksum;
>  	char *principal = NULL;
> @@ -1342,7 +1351,11 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
>  	if (crp)
>  		goto found;
>  
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  	if (cn->cn_has_legacy) {
> +		struct xdr_netobj name;
> +		char dname[HEXDIR_LEN];
> +
>  		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
>  		if (status)
>  			return -ENOENT;
> @@ -1360,6 +1373,7 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
>  			goto found;
>  
>  	}
> +#endif
>  	return -ENOENT;
>  found:
>  	if (crp->cr_princhash.len) {
> @@ -1663,6 +1677,7 @@ static const struct nfsd4_client_tracking_ops nfsd4_cld_tracking_ops_v2 = {
>  	.msglen		= sizeof(struct cld_msg_v2),
>  };
>  
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  /* upcall via usermodehelper */
>  static char cltrack_prog[PATH_MAX] = "/sbin/nfsdcltrack";
>  module_param_string(cltrack_prog, cltrack_prog, sizeof(cltrack_prog),
> @@ -2007,28 +2022,10 @@ static const struct nfsd4_client_tracking_ops nfsd4_umh_tracking_ops = {
>  	.msglen		= 0,
>  };
>  
> -int
> -nfsd4_client_tracking_init(struct net *net)
> +static inline int check_for_legacy_methods(int status, struct net *net)
>  {
> -	int status;
> -	struct path path;
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> -
> -	/* just run the init if it the method is already decided */
> -	if (nn->client_tracking_ops)
> -		goto do_init;
> -
> -	/* First, try to use nfsdcld */
> -	nn->client_tracking_ops = &nfsd4_cld_tracking_ops;
> -	status = nn->client_tracking_ops->init(net);
> -	if (!status)
> -		return status;
> -	if (status != -ETIMEDOUT) {
> -		nn->client_tracking_ops = &nfsd4_cld_tracking_ops_v0;
> -		status = nn->client_tracking_ops->init(net);
> -		if (!status)
> -			return status;
> -	}
> +	struct path path;
>  
>  	/*
>  	 * Next, try the UMH upcall.
> @@ -2045,14 +2042,46 @@ nfsd4_client_tracking_init(struct net *net)
>  	nn->client_tracking_ops = &nfsd4_legacy_tracking_ops;
>  	status = kern_path(nfs4_recoverydir(), LOOKUP_FOLLOW, &path);
>  	if (!status) {
> -		status = d_is_dir(path.dentry);
> +		status = !d_is_dir(path.dentry);
>  		path_put(&path);
> -		if (!status) {
> -			status = -EINVAL;
> -			goto out;
> -		}
> +		if (status)
> +			return -ENOTDIR;
> +		status = nn->client_tracking_ops->init(net);
> +	}
> +	return status;
> +}
> +#else
> +static inline int check_for_legacy_methods(int status, struct net *net)
> +{
> +	return status;
> +}
> +#endif /* CONFIG_LEGACY_NFSD_CLIENT_TRACKING */
> +
> +int
> +nfsd4_client_tracking_init(struct net *net)
> +{
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	int status;
> +
> +	/* just run the init if it the method is already decided */
> +	if (nn->client_tracking_ops)
> +		goto do_init;
> +
> +	/* First, try to use nfsdcld */
> +	nn->client_tracking_ops = &nfsd4_cld_tracking_ops;
> +	status = nn->client_tracking_ops->init(net);
> +	if (!status)
> +		return status;
> +	if (status != -ETIMEDOUT) {
> +		nn->client_tracking_ops = &nfsd4_cld_tracking_ops_v0;
> +		status = nn->client_tracking_ops->init(net);
> +		if (!status)
> +			return status;
>  	}
>  
> +	status = check_for_legacy_methods(status, net);
> +	if (status)
> +		goto out;
>  do_init:
>  	status = nn->client_tracking_ops->init(net);
>  out:
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 7ed02fb88a36..48d1dc9cccfb 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -75,7 +75,9 @@ static ssize_t write_maxconn(struct file *file, char *buf, size_t size);
>  #ifdef CONFIG_NFSD_V4
>  static ssize_t write_leasetime(struct file *file, char *buf, size_t size);
>  static ssize_t write_gracetime(struct file *file, char *buf, size_t size);
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  static ssize_t write_recoverydir(struct file *file, char *buf, size_t size);
> +#endif
>  static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size);
>  #endif
>  
> @@ -92,7 +94,9 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
>  #ifdef CONFIG_NFSD_V4
>  	[NFSD_Leasetime] = write_leasetime,
>  	[NFSD_Gracetime] = write_gracetime,
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  	[NFSD_RecoveryDir] = write_recoverydir,
> +#endif
>  	[NFSD_V4EndGrace] = write_v4_end_grace,
>  #endif
>  };
> @@ -1012,6 +1016,7 @@ static ssize_t write_gracetime(struct file *file, char *buf, size_t size)
>  	return nfsd4_write_time(file, buf, size, &nn->nfsd4_grace, nn);
>  }
>  
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  static ssize_t __write_recoverydir(struct file *file, char *buf, size_t size,
>  				   struct nfsd_net *nn)
>  {
> @@ -1072,6 +1077,7 @@ static ssize_t write_recoverydir(struct file *file, char *buf, size_t size)
>  	mutex_unlock(&nfsd_mutex);
>  	return rv;
>  }
> +#endif
>  
>  /*
>   * write_v4_end_grace - release grace period for nfsd's v4.x lock manager
> 
> ---
> base-commit: 401644852d0b2a278811de38081be23f74b5bb04
> change-id: 20231012-nfsd-cltrack-6198814aee58
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever
