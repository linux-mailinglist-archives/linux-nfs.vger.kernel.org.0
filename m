Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D55A2915
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Aug 2022 16:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbiHZOJB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 10:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344389AbiHZOI6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 10:08:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48AFC696D;
        Fri, 26 Aug 2022 07:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6SP++Ut3LPS3D1sAQe3Okt8pC3pw/gE+8PK2bk3gQIf+CD+L14xD3DtFvEFR+XJrp0d54HWpReecSenyCgKtHsBzllUPtued+RBIlvXs9T9uu+VbxUh32syg+juVdjfCUI7v8p5CANQpw2MfCf/VyBvakR0RJ6LNiHEAiOLT1siatHWe234BcZ21w/bhmQgPm09H1UNGXvlRwt6RJKYm/8NGTT1roB97G7zus5LtC8XIgK7/uliKAvemZu/JB2usTq4s3n9edfJ1nmVfEXTCQDfYuh0xHy82IzKO1nRX3uix6nzV0H2htOxGo1J5ZuK6GVEmaEGfpbMob4oaaMgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8s61hdiGXypl02H62DPL7ySwxDgTyIgB8oLMzwaFGk=;
 b=Hh/BOTVfPbXJZTgWEg5Y4LmUmjRXxcMRUtHVJ9gLW71+wuphL5GsHVmthqxbjl05h6R4YyvX1CvNvOFaHIy+Z0rH7YhXpouAJ15kuTf1QuSpEieWJ7Y3wvTUtDgKk1+XDTIS251aj++Cwl53txObuTuynptwjvNtWYbgJcUyNCD7N30tArl3cuV3/Tldl06k56HeKZmVVDSIGCEcrh5yYboW/4VgFxmWJfwZTALD7Mb/kQBB6c8uEwCUElj45IR+tW13wQylOtqelyvGNxktFaS8pHvnpqaOD3/RoRIb3ZRS4zKg1wJy0BkpjT4fHuwlFnw9eOmsD6t9IQyCj6Eemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8s61hdiGXypl02H62DPL7ySwxDgTyIgB8oLMzwaFGk=;
 b=SSor77sJh3Vewnx7Zp+5TcTUWb/wfVllDokoXsoi8V7o51MJj8vb1FOSYalTGWpbMfW7AXz6FniRTCYUpEGLWPn4e0PMbr8Ae2exFar4I7KVh9wlZsJc1+rE3CbuQJbC9EbM5BXKEUBfjlv9NLDSfT1drI5yCl+X2TK2LiQYhP7jY7JdmBdcZjf2aBszMnYScvbN0DN3ogWGc/KJipaKLsA33DrNL+0cjOvd70UonWqMJ2boFNDMpkD/sq9U9nTlZ/RxEOiXsKe7P4wJ70Ydvor5t5j5LeYz62j7ulBf+auuleLh3y8DDRhUrXt3smaRQPApoatjgMSawIPry0SHWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 14:08:56 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 14:08:56 +0000
Date:   Fri, 26 Aug 2022 11:08:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on addr_wq
Message-ID: <YwjT9yz8reC1HDR/@nvidia.com>
References: <166118222093.3250511.11454048195824271658.stgit@morisot.1015granger.net>
 <YwSLOxyEtV4l2Frc@unreal>
 <584E7212-BC09-48E1-A27E-725E54FA075E@oracle.com>
 <YwXtePKW+sn/89M6@unreal>
 <591D1B3D-B04A-4625-8DD0-CA0C2E986345@oracle.com>
 <YwjKpoVbd1WygWwF@nvidia.com>
 <08F23441-1532-4F40-9C2A-5DBD61B11483@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08F23441-1532-4F40-9C2A-5DBD61B11483@oracle.com>
X-ClientProxiedBy: MN2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d4a49d5-b6fd-4c73-b2dd-08da876c83d1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5142:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6c523ZfQP72d9DETuoPd2NbcbRYRQlPa6C8iHVO6tXbrYUeWaiNm8BdNaDP+vvOVkZ298m7wLPJuAi3UWflHWb8taK4j21jmOQXvw+Ejerzr96Ivap8JoVmaZn7Dm6wN2KLDKjZS4jdlAGxtI4zgK1bz004t4UtqghMBrF5hJNiPU2ebTN+hsDGRlqMx97YdUnO/6NOVl3M0vTW6cGyrahNRnVZJ2WTeiyn6nwJbiov/QLHNVz0gZpmnUKjzP7PhU0mP4r0p6SS5fMv22n5/frHPZv4QkG02MrMqF/ZMhmaLIFDw31GmSUcF2jo56qx6LH0cYllcD43qhBpT93b9RqH4ZRje/8t5zT5HsovGv64Ulw3eoZca5AkqI+iY6jC49B4X69+V+bPTQeRXCA3z8GtNH+Am7Mi6PLd32OlAVGVr3plyUSCPqBAxpXnjV9Qfo5u4jn1PvZ0H2AZBoRWXbat75U6QI2FOEWKH9rODRyWRpbdkyj5k6mZwcJqWwTpQW29VFJP7A3umEwjbaBasJGXKzksiE5ICoVcLibAgK00qvOvmjOmMURMhVNufNDXbzz4Ca4qRsmunIifViSBaSNExOvyx+A90b1Y0wXnzq/yNpumZBijDVHOwFljcFPIYkhKtV6JXRN6TJQFMwTHQeEvDJx+9KW9u7AKf+IPP7YoRwOiQVApvJIE9SO64oi/Hp67nD7aU8UrNtIs+VLZk3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(83380400001)(2616005)(5660300002)(66476007)(8676002)(66556008)(66946007)(4326008)(6512007)(6506007)(26005)(2906002)(36756003)(8936002)(478600001)(186003)(6486002)(41300700001)(86362001)(6916009)(54906003)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?keebmw9qgHiL8+2i7/nYxn+lycnNEYmK/qJRXe6CxDR7XLbHUaXgBNXDFITj?=
 =?us-ascii?Q?ZvoqKlkSxQ+zs7FSh34EglSwN8Bkxt3RY601AM0uyYtuH92uZ/ylnU/RewV4?=
 =?us-ascii?Q?I1+fPjBadsMg9ysQFwU26gw4DfUK5wa6eWJgeMkNikSSeFSmOSCwVxmHg347?=
 =?us-ascii?Q?QHgCQrAO8NtBW1uBtgRj+XRhIWUPiCBWmaXu43ksMNFeXWYroDjR1IO9bhBm?=
 =?us-ascii?Q?EL4kBcF5Q2HT7kUcBFjjYNh5Tadhy7Qy76X3oTN0xxWbFGHY33Qpd/zGn/Kn?=
 =?us-ascii?Q?QF+KAanOsOsN1We464IzWqsmSCKNbdGeKoShIHpdzzu2i9Zynww5wI4SnQsk?=
 =?us-ascii?Q?bqSPRdzMQ5Xisf1U5cFhhwFHe9WUK7qpRuYaXR9zJ1kB90YtdQygVT4tjacY?=
 =?us-ascii?Q?7GIGHP0kpA/2PrRlstMbvXnTAWntVqVpvXS0VJsYAVGSu+quSRE4uOkP7r4a?=
 =?us-ascii?Q?CDuNK75vB6Qxq4tIGeoyxKIe45qttQqyd2eR2sRp2iEDRpLIU4qfo752L+p6?=
 =?us-ascii?Q?+CVwnucVLmzhRHcIVGe+xYU0VcuOYsw5thuoEovOP1NjhLzdFvl9fnbTDk9j?=
 =?us-ascii?Q?5du0eHLDbQYT8oJ7Ww1oW/aoIiJUTQHrMRslpQykE43RmHLp6TZoSUv4rL0i?=
 =?us-ascii?Q?Ug+I2kiuZX65aIxLocpitaK9sUFzvatxuvlwE6vtCAq7MCRdgoceNw26yzW6?=
 =?us-ascii?Q?a9m8OompGamugmeXQNwyW269ivyC9qPw7W7aXb/g+QN2vhGN+h6n/6PjNqLZ?=
 =?us-ascii?Q?zeJ071swPtzAgk9G7TUQNBFLi44bCkoiNgi3hAmnV7xczN5+FjapvLn/O8EB?=
 =?us-ascii?Q?kVDfPlT1PfzxLyP5dygYHkOPRREiHOK33n1J15RhTds/81/51BalURV/Mwal?=
 =?us-ascii?Q?kakI/Lf8se1gXInPffZ1M1U0sT4Cwv15DauISLuKizYPiTFTRd75zVSI7YRy?=
 =?us-ascii?Q?qZv0mkkaGTi7W08/Xf5/aU5El5yJXZVmtXONTOwSwFJUPBqtqoeIVVe/busp?=
 =?us-ascii?Q?TG98eiZvwdXXVkBHT+CGLjDbuO2bcgGyjACVe29ejQdnceC4KeBKmrT7DIEV?=
 =?us-ascii?Q?xJpG3Kroc/zB6LwdnWRnnE1Ob8xBTYvfmzA8SmaEFJvN8w6USisU+DVlOzdV?=
 =?us-ascii?Q?Do1Yt8GmU/0+VKTuXk9rhC9oCHX8xNmYnLbBSGU8g6sJ8karf0FlEwVnauu1?=
 =?us-ascii?Q?kWw7+jbR1vLFPAXx+eUKvsY2wWj0e3JuLGjDXsIAL/ro3Mg6m/TLOXDGkSn8?=
 =?us-ascii?Q?1uMww6wi69O6gVhmW5uPpoe4B93amY+7mQ1/8OohuOA7RSCzEafkzUHiDfZ3?=
 =?us-ascii?Q?Q3CM/XAf5sIxzXjXjT7rdZxaQJF3tJPk3g5jizFGxozGhSbSfdMCLZ48nbgt?=
 =?us-ascii?Q?HA7Wwo4NEUc9dcBiGxe++c/I+zf/vcyXEqTS0XxGoCF50qecJW4io0Yy5R+r?=
 =?us-ascii?Q?nkXomSsjedvxodUpmjOq4l7daM16oVgSUVD8aJhhPw+EUj+t18l/JZH6YYHW?=
 =?us-ascii?Q?N6Y6Pc1uFmtll8l1cmKfz4bm2AR48FQX4pgGdkm/Z+tbd2VZEABY+P7B8ncw?=
 =?us-ascii?Q?osbo833d4cg0tdNyPQygMI8PSdLZezsxsIu8AWB5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4a49d5-b6fd-4c73-b2dd-08da876c83d1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 14:08:56.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8mlPQqBpsSXigrJRLMymFULPMfGWFc+B1oz0zkOspL7XlJjnxiCZKdhvyte9bo2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 26, 2022 at 02:02:55PM +0000, Chuck Lever III wrote:
 
> I see recent commits that do exactly what I've done for the reason I've done it.
> 
> 4c4b1996b5db ("IB/hfi1: Fix WQ_MEM_RECLAIM warning")

No, this one says:

    The hfi1_wq does not allocate memory with GFP_KERNEL or otherwise become
    entangled with memory reclaim, so this flag is appropriate.
    
So it is OK, it is not the same thing as adding WQ_MEM_RECLAIM to a WQ
that allocates memory.

> I accept that this might be a long chain to pull, but we need a plan
> to resolve this. 

It is not just a long chain, it is something that was never designed
to even work or thought about. People put storage ULPs on top of this
and just ignored the problem.

If someone wants to tackle this then we need a comprehensive patch
series identifying what functions are safe to call under memory
reclaim contexts and then fully auditing them that they are actually
safe.

Right now I don't even know the basic information what functions the
storage community need to be reclaim safe.

Jason
