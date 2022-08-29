Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20A35A5211
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiH2Qpa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 12:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiH2Qp3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 12:45:29 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0A12A241;
        Mon, 29 Aug 2022 09:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdX3JC2CmPrFeEBKImRYJI56y+n/FzbT3e6g2ZRGrBpRr4Nc+66umj78bY/Nj4WqJJwQC34t5Vi9hxqfT4GslbvZ80qjN36KBoNnlNgH5UnqcrXeAVh0Wo3O758dhbogIlZs0VKvWM5tkxg6mN45yL3l+yXjzDW+A9uofCxz3Gc/3FIa3CP/RC4TKakvPK3qex4c2vJJD+X/pzM86AvxtKrwDpCcFDTqRLVhq4KpmCisY7xPjuBhf+dQNe/iPf1VKBeq0zgcubI2nvVCJlt15ZRgOyOy5EZUctt3BE/5aCHH4ZuLSZ0sF/ERSTgjLHrgQboUjXO0iqxAfkk7yaY+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxZSrAFR/QE7QwFua0HejgPyn3Dh5mJVo+DeRbyyQk0=;
 b=k6DPO6ttni/zfXzTDu4LwyJXyHihKitYJYcIuEALIXt8FLD00CT4/mv79VA2tYjtGQPYZyWPRhgeuBCzJTCA61DumTEVVgDBx1ngaULicpI6clE507tyEJ6N/TjIL6oF9SLEpTeXPmckYKVpVqAX46MlvNY3aKs6RDf1iMXTv0io1blgrp/gY1QMK2mU6xur05dTAKA/GIds8In5nlW2jPlyee1tt3FC0NG6HgnliKYqDbXjWZOS82+x1ocLw3yPcMSq1kmvdi2absg+GiZ2BVOrUgKmNtUPjVbOLjn+afsSdX7F86fvjdu6TboaU7tjD6+zKjz2ewFnzwLJyJN43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxZSrAFR/QE7QwFua0HejgPyn3Dh5mJVo+DeRbyyQk0=;
 b=cQMNwzPEH1n39wIF3M+aXF5wEz/C2C52D7UvPVzyCJcWwBVaLsX+/R4NiOwqbFHt3dm5Cx3p8ZKgb1neDkqlzhMvz9Gxhw9I4821r5tkd6BlNNp2ZAkqfjYAzNXkhbNzYFpjmPb2xibp1MoPwmcAl2KSOH4i34WlcD09EZnfslDJgDAQfWA/RKEbyGT7KA8zyoE42efOy7CAaGqAv+c0uMeMMwpVpnVlcjV/mZa9dWs4mpWR7Hy6GeWOnRC+DcPniDMh8gFlsRUHKoessB33fU+Mv4dln7O6Y/oYyKTBIU9/vldk++qwoLBp8H8gru2vf26iLTVUXQw8/sFxpYMQ4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW2PR12MB4683.namprd12.prod.outlook.com (2603:10b6:302:5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Mon, 29 Aug
 2022 16:45:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 16:45:26 +0000
Date:   Mon, 29 Aug 2022 13:45:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on addr_wq
Message-ID: <YwztJVdYq6f5M9yZ@nvidia.com>
References: <166118222093.3250511.11454048195824271658.stgit@morisot.1015granger.net>
 <YwSLOxyEtV4l2Frc@unreal>
 <584E7212-BC09-48E1-A27E-725E54FA075E@oracle.com>
 <YwXtePKW+sn/89M6@unreal>
 <591D1B3D-B04A-4625-8DD0-CA0C2E986345@oracle.com>
 <YwjKpoVbd1WygWwF@nvidia.com>
 <08F23441-1532-4F40-9C2A-5DBD61B11483@oracle.com>
 <YwjT9yz8reC1HDR/@nvidia.com>
 <FF62F78D-95EE-4BA1-9FC6-4C6B1F355520@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF62F78D-95EE-4BA1-9FC6-4C6B1F355520@oracle.com>
X-ClientProxiedBy: BL0PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:207:3c::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f84855d2-a545-4a4f-9f57-08da89dddfee
X-MS-TrafficTypeDiagnostic: MW2PR12MB4683:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OX9qPzTUzGqwNH7PfbGW8ACOLR3HPCyEt8GMw4icW4NHrkInuBqM0XGZ7PuOWp0bqf5AOwkIJHYzbMF/BoFs2poi/QUEf3Z5SJGCUk290+dHU+LZZT6qKhLFshnDJWznN9hSFHVbMGu4r11AYVJOq9OqTXRekpvIXz6jg9nDNIr8eG4qyhd1t1ajAdRdMcpB7uo4Z0jsnyqqxCyZH8M7aH6fASeiuv3GtG11UFiWX4KF+XeHTgTixLFNtAJxWynIUdcwDAw96E/xDR2DI/lH8kTl8nwT6+1cdqerbkS/MBb3C98Jli7FrTRu/OREtaOkhSq+gO+ELzkeRVk2u2edH2OfyDtVS4OKV9mhrnVRve1LOm5Vi1n0HRJdKDpU7/5BCEhmwPxWFy8z+4pcJPyqRdAqdkDQDCXF/dqQUZf+UJ0O6wZZhKohaBM+4GtXN+apU0+kX8rvbAg/QsGjqy4oax4K/gjR6U3dzwxqtAVZkvgUnx8Vqc/eZWxdIDcKLkWthJKyLuM9saWUQikqvJgjT2chRjTpnTLGr+3fR7/g8eQXEPgjfRZNZEdB1R5VXS0logCYH2f3anFSmQf+J8EvyHEtT/qdP0WM4CB7EDkRb4MpA4R8+TyxlF0Ax1as57nO8d4+ayvpjjMs9mGPXb2mAYtLxkWomp4K24MsUCEyrvKMoPkQOZP4roTCP50vhjfqxC7N9/89xThPqLxtNPxZdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(186003)(2616005)(316002)(6916009)(26005)(2906002)(83380400001)(6506007)(6512007)(4744005)(36756003)(38100700002)(86362001)(5660300002)(6486002)(8936002)(478600001)(41300700001)(54906003)(66476007)(66556008)(66946007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ip1AdN5ZmZ/Rl90KigSIcUDi2mkpINQ0wQd7oux2GjfQxUDu1JOEc1kzC6dg?=
 =?us-ascii?Q?LDDInl/JcMtvYLiymZqMZ1XhWD2WgsRfDAG03M1SpnGRkd3Equ/cik8nVeMF?=
 =?us-ascii?Q?hvoAIB3BL6wV71eEJAJNzkSEmHVybrh0cXmDouGT9H4WnYku7okqxIDSiJ5X?=
 =?us-ascii?Q?WJeOSs7UAcuBX/G/iEuOxv/xaKvkDNyhc3lmUzp+APO5P4RB9W4nA+DOdqTL?=
 =?us-ascii?Q?ij2SvsmOGanyMyiCpkgFvkJ5kA3Gudu9vGtXUlHDqVTfTdwynGur9aDx0brM?=
 =?us-ascii?Q?yVI6n8HXNY0q1HuDotMbTOqWff1r2bGW/RE2GoZw1MGvvLx6TlUGEmcJ+Iys?=
 =?us-ascii?Q?vwAR8gR8fEQ5fd5+mtHKZZQyYg9PV85VFJsAAvg6RT73hnagP0pV2bM8x7Ke?=
 =?us-ascii?Q?cx9+7Q3hwMwqOKi51VTjltT9RZnbjCs9f9km1iQgpXeCLyofTrHHQj8OrHz5?=
 =?us-ascii?Q?zMraHPcLtMq8VyYZ4N3YAdo77If+YzGvFI9ScOIjOfrdY7eqv/2OR0ezTsTw?=
 =?us-ascii?Q?dC31ssUQbbYSFaUgu9G6kpWrpRBjiWs8lN4GxcMPRxTx2q8tXi1x4fpxB45r?=
 =?us-ascii?Q?Gk0lKx9E+nr3ksMFq0EqeABDLuLXImVoZSNLA8f/fsyGLalql+3bDiCPkyzN?=
 =?us-ascii?Q?0118qm8m3o0Xofbx1GWP/maFrfOrhP6Wq9Pf/l8IWwCwd2iPVYwSj0oYbN5/?=
 =?us-ascii?Q?Fc5D81oCjVjgqylJvcmTxRdSCU9gYIA67RYk6KiwoHDttsUEsfp50ziOpNFq?=
 =?us-ascii?Q?aYxwbJZzznnR0s31DgQYuKv+Y3IxGbE5e+fIAF/lUpp0FC/K805wzPiPVTko?=
 =?us-ascii?Q?+DdfcgP7vBZ30vxLHUItJfuxgcs6+IGofX52C4WfeVnnzxwNmmUBuYhdl4JA?=
 =?us-ascii?Q?WO+bMObHcUhPXioyGFfhdEabXIGN2o//mYPgSTyAZE8Dg2fhrfNx51jSBZT7?=
 =?us-ascii?Q?e7+tIVkE5znTCpB5o+/uiCKlzShlg51IlrpgZTCEyVFTCdijWLFOM9IKjbRc?=
 =?us-ascii?Q?cHGmpouoYldaVzmqkFSTkVjptB1yyZU6l5CYRmY1zNrKKm/XlOtCD2h2Y3+k?=
 =?us-ascii?Q?cAJmWhd4FpxwkdVYh6D2FS3fkLWyAcvY56M90WF/L/JPBpzuyMXnqCpDg5fM?=
 =?us-ascii?Q?UX5d6+L4QXmum7ZA9K6LbbqAtf6ERq4G+5RmVxl+dRy9r4HNfvuA8TQwrDAd?=
 =?us-ascii?Q?aQs1ia36a4tW4Ft0dy3PZyj//Q6V5p2W0X7BMTB77/XLmVxg37aes8Nulr9O?=
 =?us-ascii?Q?qoRukW1fcUsDMHaSovU6mYKukNaOF/4drOujxPYFWiGyoKFYoQ1HjgKHjQd4?=
 =?us-ascii?Q?1d9efCi3usy59ihq+Zrf/jbUNyt5veb+ywn44OoYP0iw1SznrlVUqJdoz10v?=
 =?us-ascii?Q?u6hzFFXjX9CDlTqqKBwxtnLfo6fFm/K+Xgxlnme5k1efGXJkAMILvv3GBFhZ?=
 =?us-ascii?Q?vv1F4GT/Es66gKOLva4/Ix1+6Tatr55ivOO4aH4mhv4P1tljG884bN5iP05b?=
 =?us-ascii?Q?rS1+Z69UaIa50WYeWDRmr7r/KkrGUdVdKOKW+2Gb9fBuT1EVaQ335Q7SgpZU?=
 =?us-ascii?Q?qF9ErorSlQ4mcUj0UEv0/SxaCa3oBHI5THns47FE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84855d2-a545-4a4f-9f57-08da89dddfee
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 16:45:26.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Es8UMDzmoJIykXIay46bZ+DS1ci/YSOjLeScXrjVs6RRdIs4cb4OK2TrBXG6AQ23
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4683
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 26, 2022 at 07:57:04PM +0000, Chuck Lever III wrote:
> The connect APIs would be a place to start. In the meantime, though...
> 
> Two or three years ago I spent some effort to ensure that closing
> an RDMA connection leaves a client-side RPC/RDMA transport with no
> RDMA resources associated with it. It releases the CQs, QP, and all
> the MRs. That makes initial connect and reconnect both behave exactly
> the same, and guarantees that a reconnect does not get stuck with
> an old CQ that is no longer working or a QP that is in TIMEWAIT.
> 
> However that does mean that substantial resource allocation is
> done on every reconnect.

And if the resource allocations fail then what happens? The storage
ULP retries forever and is effectively deadlocked?

How much allocation can you safely do under GFP_NOIO?

Jason
