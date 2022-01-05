Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F300C48578C
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 18:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242472AbiAERoC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 12:44:02 -0500
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:20641
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242412AbiAERn7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Jan 2022 12:43:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7vWL66Nv+CR7Z9Px6e+NGqOWrYsV3pnKMFA+iOC+DxjtsczATHyybQktdPVicyvdnFl9/BHrhjFosWexM6aMmM6ME94cBh6EMHSRmPA9+L8KMuaF3gJGmgTzz5Tvy6PSIA/0lGzC10xHsIPnpcpy/qJIzyRtHWPsEqnKJDBJQViirOEQhuYioxYSU6Dginvnc6mDIoxO4HEtwoUJg6s6OFe/8bYVaiFSZRQZlRXpd0h55gG+3WuqtG2EFXmhrYeuub5MQfnW5cZDKv0q7DLtT18IBOGtlCkmlCcRGjhV0Y3We0B71mssezwnuCCe7Wu2DubWA1muiTzDd7W+766Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yGbzagseq6vKTOPFSR9f8cLZ3AuEPGRh5bOOs7CxDo=;
 b=EsEQqQFdqvWJdJujuZL4E1ytRmq5ZixYTWHfSp3YjtlxpjQNc0eTX92Z9oHNbSDPPZINlki8NmDQpmfzGfRncylufuRCtKJpKNG4RwQ0iZEjY8xPdh9AsinaWQMkA6z6q5cH2tq7SohjgU2OrAM+oiCSQjx5nFyMJ1IyFj33nTg3JE3G/VWL4Num3GMxx2+BQ8ZA+q389pmwGqhDZ2u50f6pnv5y1fQT7+Eyat7TMWWUG5Ahw/U6auuZOEW/mdRJWgdg1InM/Z0RWwhbRO4gA3OPRKZiL/7G4fA7+QyPKKYNJ2UhpfNMNETSLFsMvVzDZzhQ/tpzLNyrCnkwJSuG2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yGbzagseq6vKTOPFSR9f8cLZ3AuEPGRh5bOOs7CxDo=;
 b=fH183Iv1++sUfKHDWHXL54dq0NY3rvhVdqWiW+lnDmipO+qNrpUcfQ8yGZ8J1SAxx0kesBWruKHrXPeKnAo0Yeg7OwV8V3OGKwd6dfkEKvmdI761PLEW/R2mFBMC08YgU/4ANDszkXHtBZt//GEfq9H8QouUEhmwEXuJJJxbRURtPUsdQ2u/zwnWiYmAAZxDLpn9UOPSD1YpaU6T+MM07pgOaU4YZFJDLPYBJR5yiomDNk59lY2Jqu+rrzVJNc8KG1l7tAxausTEe/NakyFuJH0vO1H4cd6DgK0XBD5kcXEy5PgPh3dK25yALhopfcaQGopFPTugjtDn2W+upmRBIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5239.namprd12.prod.outlook.com (2603:10b6:208:315::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 17:43:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 17:43:57 +0000
Date:   Wed, 5 Jan 2022 13:43:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH] RDMA: null pointer in __ib_umem_release causes kernel
 panic
Message-ID: <20220105174355.GU2328285@nvidia.com>
References: <20220105141841.411197-1-trondmy@kernel.org>
 <20220105143705.GS2328285@nvidia.com>
 <3b74b8f4481ec27debad500e53facc56f9b388cd.camel@hammerspace.com>
 <20220105160916.GT2328285@nvidia.com>
 <f6480329a7d86e5eb10f11b5bc5049868981dd3d.camel@hammerspace.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6480329a7d86e5eb10f11b5bc5049868981dd3d.camel@hammerspace.com>
X-ClientProxiedBy: YT2PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 805c25c8-0ea2-4792-a21a-08d9d072f2f6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5239:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5239D6A727582C369AB35D63C24B9@BL1PR12MB5239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afH5QVWQSaqES09crwEClNrfjNoXJwn/hXU/UeZLzXq4Is2P+SE3PuFAs3lex03wu4QWuVNRePM/+6a0MDBo1367rpx+JGu0ZhwoXqwNrj098UTZc0Vb8uepWCYGwByuLASJIN7nTprXORV15Gi4UYfyzJmuCNuDyuFelQUZhkjQ1MPcpUsDL6jgAP90QazKjE48jGtvaXBkVAe9OsE5aFRP0zi9csjnp3Yuo5RqY3rGGsDbEWkwPo+krsxGQ/3yC4dcSU9JxXYuXwAePW7Az4OYnf8HhNwTi5Fr2HV7a/9GyngOSQkdMD73n7l4W0RMt/KkKKji3N2QNceZcvN0MOO4lWrtUlFLnPIAfpzYaiV+jBblW3g8pnCDGk5JpUBOcwOy770MJ7TsZoI3JP4UEezvrg82bE8fSdIqAzWI5dgbRTjRd/g/y5rlBZdJtLIPMm4g3KzboWMLBYmMUrJobV8YI/moFsXvNzmTClh6NCjAF/RttSCVVweEOkLPA6fcxKW8v3P2bYCg3uoDAXihE5zMF9mI0Epp8AazJXqUTMU62cTqBctQNh4aq8HGF1O+mYKbX9wdZXAGC2nKjk1XKGjzke+Zq0Vzbqq+d891U1DgsZkRjX1CRZ1iu/gQ6K8ppGhvKrQ9crOJbJe1tCWHrqKgp15lKGAFcw9fvpOYgHqo7lr5Perww3Zq9qHeCq/JPR+C9en4C4yBpABzy9vp9D7RMcn+f+29Mrxnq7Ro7PY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(66946007)(966005)(66476007)(36756003)(8676002)(508600001)(2906002)(8936002)(5660300002)(66556008)(33656002)(1076003)(26005)(4744005)(6512007)(186003)(6916009)(54906003)(6506007)(4326008)(316002)(38100700002)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WgATtuvvTcHHcwLeVQ79ZZJJLC07Pe5GWvBWDV4wtk9XQ8y2jYp+OibdXcm6?=
 =?us-ascii?Q?Y2mYSkFGFLmq9t6aqQccAMo4RsEQY4myMxo4ayDyBHTSO/yzieoKsrPjCfoQ?=
 =?us-ascii?Q?H3kZUbfHI+PZNTgTyIs5Obn7rEl9MEbkWjUOPVcr6IM1upzdY0YYEwYgPiZO?=
 =?us-ascii?Q?FuuY0xPzLG4NJ7h/HHKcwy+VyOfRpTs0tOGbj4xBtMcthdr/b36sjkNfBRu9?=
 =?us-ascii?Q?gtZyLbOzJgYJcdZ9Dsis2AiNvE8OY7BCGkvZAZ5Lqke92XxVH4yjS0G36NT9?=
 =?us-ascii?Q?zE5cdtwFFAIO7boKd1zoz/OPSmjqpARJqNwuTNtYfjCkZpn1iW/IBGMIYlCn?=
 =?us-ascii?Q?G468y8HYBdFlZDmI5EVaeV72EP5HUAVWBn7bnwf332Z3i/ydcLcgceHxUh5g?=
 =?us-ascii?Q?0iIT/C90jSNHpZeWN/dLaRNu0I5hbPOib9MwgLsx66POX84uiXvMG9Y4ZXxK?=
 =?us-ascii?Q?dsp2JKwX4yEAm9agUUXJbckOtBi0p84B/1ofmG7xniWf38Hz/Yj2Hqdc6AmI?=
 =?us-ascii?Q?cB9Iuxc8A9/xPuJJ5PisD5RR70l1A9lYv5IHsWWkPWi8j+sx4xmvCNOlriOm?=
 =?us-ascii?Q?VjcKc/K+RDKonA121swTjdgathFzZ07aQh9vBM3dTG+KR6Qva2ObDsHJcjuv?=
 =?us-ascii?Q?54vmt4OM2oJqAzSnupjs40LqRCokqnFtCAaODy5nh0OOod/QdeV1oEVHsGrP?=
 =?us-ascii?Q?CMAddwTglmI0G4HRrGSqA6OfMXb/iT4WIyAooRyq0bd1gps5jHg+WWLD774t?=
 =?us-ascii?Q?/En3zF7MTos3CEkLoe4xFds4OlKw1Gy5eCm1C4mK65OejzgbHJcHTJI/Yiu1?=
 =?us-ascii?Q?V3c+lWG77f2bQfDDaCbfM8xCdR6ZQsNVgpcvNMfalgQLKeWVwq96hA8KsGtx?=
 =?us-ascii?Q?YN348jhjPP3ryvTfPS2CNc8SWh4qSxxGmnEd2Bi0egtTOz7BKkRWQrfIZXvh?=
 =?us-ascii?Q?00yvrA6+QRM4pZmCmMM5HVdSQOx6SaAMY4G3txFAbucCgCW4VpZTzcpWy5qy?=
 =?us-ascii?Q?0c6Vpl8Lj3Q0lYFtTy1WZsKPixsgE9GdeYllbu2bbGoyFCn8Rs33AmZ/zxFM?=
 =?us-ascii?Q?ZeVlOI9D2S3PNNtENVn+8oVRu/6xP6oQ/9l1h8kAo6Cc8dlfY+YiaZS9rAhh?=
 =?us-ascii?Q?DMNyQiBDN4//fbGJCKE9N/DHOkvF0gy340NESJiLpSrgjxDm4USHFr37WZbZ?=
 =?us-ascii?Q?nJuVX7Kil97M1cSERufkOn6zchfPyg9fXEKMGAWfZ2RrLR1dIO9niduj4ei8?=
 =?us-ascii?Q?BuvvrD1H5JXowRwzcfpzDjMdOjxt15rjAJ6QH8voyal2+CDYxHxO55nSR3vz?=
 =?us-ascii?Q?Lj2E6GwSSo52pSUGYuJRZ9xMKIFRIbtsQlG6mr/OSO1X+OJrYaRC8vAexjPd?=
 =?us-ascii?Q?3vhIfPxko6oM/unhJGbt5w+ym31sqxxdr7lvuxYcTif0TrOmp4RTyUvvw/XD?=
 =?us-ascii?Q?Bq5BCoCIau6Ch391b24+dkfGQz8N7NedK9vQ7M7bC2FSccRdJBuQqTrduwJi?=
 =?us-ascii?Q?1rRB1Fhh3MnfzFxnxStW9D928IkioojeTeyy3e6FQr5JKbpPm1OoDHSqQWU0?=
 =?us-ascii?Q?oxyDh4ZP7aMlLoKKD10=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805c25c8-0ea2-4792-a21a-08d9d072f2f6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 17:43:57.2921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqBYbkczGuJSkmzSPJbWzfic2T5rWFOEer86B5hZTs9xhRlEHzIpRYmiymRGLBJM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5239
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 05, 2022 at 05:16:06PM +0000, Trond Myklebust wrote:
> > I'm confused, RPC/RDMA should never touch a umem at all.
> > 
> > Is this really the other bug where user and kernel MR are getting
> > confused?
> > 
> 
> As far as I know, RPC/RDMA is just using the RDMA api to register and
> unregister chunks of memory, so it is definitely not directly touching
> the umem. 

I mean, RPC/RDMA doesn't have a umem at all, so seeing it any stack
trace says something is corrupted

I suppose it is this:

https://lore.kernel.org/r/20211222101312.1358616-1-maorg@nvidia.com

Jason

