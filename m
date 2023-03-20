Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E019C6C2093
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Mar 2023 19:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjCTS56 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Mar 2023 14:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjCTS5S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Mar 2023 14:57:18 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C393C797;
        Mon, 20 Mar 2023 11:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGGjGnLhXpayYLBKXNeEkx428TvFLm/SwuVHbtKf57V6tDfYOrHYxn1Hd7XALcAwUdD0J7tB+OzIa/yyRNZbAZyvEvAjcxOWe7DJZgJOMNuQKmygUFXv9FlQovJvowXVM4AX8GaSm6ob4sxlzC/dCMBaRR0qi5uCTMcwvonwZ4ndhs5n6XoE2HDt0wzOC5IAAT6U5TAbj/JFWOHQMizBZJGX0W8YySyWpS8iujyr+Crwo2HFmlwYFcsYRnaKVJlWxsAWbZMjkl5zI4jD8050p3vYm22BBYxr7uTI53y2EIfsF5lyvzmXk82ecqTDSkcmv55oVlpRYptcO0PSoYce4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC23nHvmsjk047LeZyGTlxwogRKKTMdhTbyermoaPGI=;
 b=JoDNtz44sAJbm4FBYgZF60N+N0PTZuKZklnmNpTJq8rGYG5njLh2rciJZHrMBN93yVONHYGOH5NJOIw7F0NPKQo45h5s9BSvlniQos+9AVasBwCNxzPR6Ixsk+6xdz7fCrP0K6qyK8sQCoHDVyGz6ix4iEbE2h1Oo7LOebBkEY/4l2XYBnATbqQ7DOFbhdhTxW6TMBjP6UsHon8ztzXtXatMzUf+AwtPRxMj9Rf8T6rQw4A6oWUcdTPXRZG/jrKk0ca8SADoJSmdKzzvTvPJWwI4i5TROgTJ/6H4iBDnXwjwJW5dpF/62pmgRE1EDD5bOBtJSEI9G9XnbKwaFrfGzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC23nHvmsjk047LeZyGTlxwogRKKTMdhTbyermoaPGI=;
 b=cQ6u8JoSOHluLYhj1AXNogPCky2PG6o433Hu47t99moqNtrLmEi+Yss4ZCAdN/q/Zzlx8/5sw+sA1RcyBa11YAN4HjJty+Bf4spYVEGPoXqGtxd/5keZ6CEPZqlR3YSd6BKCCbDQ076n6aj5tVlbLm4iKPLU0W4vfpaPQ7IU0jIfFESS2bxcw6VgiRCaJ9U1IkBPwYm5EjlpBYoHXTIEXjFkwIDqxnP7BSO8xHGVnaogPpnFZKsXsOHaUXlHCy+iM85wmSKWZ3WYm4fq0YB0HaPtEAeARfDvmfp7j6S9tkIFJLd4n+cNaFRgtYZdGGPX+rr9HnBxVGpRSPhDgJgpFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4121.apcprd06.prod.outlook.com (2603:1096:4:fe::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Mon, 20 Mar 2023 18:48:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:48:02 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND,PATCH v2 09/10] nfs: convert to kobject_del_and_put()
Date:   Tue, 21 Mar 2023 02:47:28 +0800
Message-Id: <20230320184730.56475-8-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230320184730.56475-1-frank.li@vivo.com>
References: <20230320184730.56475-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ceb05e-30f2-4e95-2a66-08db2973a27a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgpcpRbZ/p42qp5kOKRxMEYBCI/bIOzPDMY/azLBGznK+yp8ZcDOuIkfA1IbdCMgmhMKUQHQtqRKp1ar62MG0+acMu6TBzkXTiu57lu8JdFMbD2bri3GoJdttOojMElM3pRbcs2dsO+PWGCgbo545nWULPnVLHuI89r0w3B/kQDJewt61Cx2pWJ8jdoZ8qUJVFzcb5tvAfWaxAjD8SdaUEBS01+P5c6q4rtDb8/5JtnAsis+vbtdrBxdzFbV5iB5S56OIh3moCbtmGBqOw04vhAd4uZ32ouPI5Q1uj/3LfDzngXOnYTb6G18K7viwYsCHaLIg+t7A8tBZmaSDcIkcEMxvtM5TX3otX+kh60bRWQmzCoqvv1oDrhKMDAF0y+t0lYEq5MkqdNww6Ab4iOyORpJs7FHkGZxClsR3V7iHdJAcT88sYvCxKQsG4gVbDZ1cwJNT0JEceNAgZhNtag7KC6ufVVklRgDgacu8urodennntfocMqyM5DmIS35hq187NLxSKLXQbudv/jpxhrneqBpAg4eYbiO84R5fMDqwXD8GhJ0N1lovKkb2drpjEYYMG25h/SlM1riSNr0h6y6HMjvFdJmgz2/3SvslO69nx8FERmJNczJImGAKf6h9ZwbTjcrOFEM2QdVtlu1p9vJr1SOlfldZ8j9NYV5/nszz73Sdk5o4k8BxXRP9IMRcAuHX9h/viiLLIh+cQactZXH0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(86362001)(36756003)(52116002)(316002)(4326008)(83380400001)(66946007)(478600001)(66556008)(110136005)(54906003)(8676002)(186003)(66476007)(6486002)(26005)(6506007)(6512007)(2616005)(6666004)(1076003)(38350700002)(38100700002)(5660300002)(4744005)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MhbNPhxAebePxin7d/ktdJdxO1Uy2VZP0Rb3c01/grTnEJ1ZF7y+u2u4MFuy?=
 =?us-ascii?Q?4VXsUr6ZPN+qTPkeTgcygVY/Jam8Ffg74IFlUYu+B+oPsPoigtk4VHAwWjr0?=
 =?us-ascii?Q?GZUO/j8ayAw/Q1cR/77T/fLOj6kMnuUBHfPPcZXq7o+ZJsOKfmrbO1cIXxAU?=
 =?us-ascii?Q?fyVesdTZ5ZzJec7mdTPV3Dd05inSmblWw4GjUoex1C0jaP6zKPtoRc4KFJx+?=
 =?us-ascii?Q?XuZtoeBwekoZOzSf0bzaXSv8n3b0bwYbL2Lj/QXWrz97IgWT95gBoZy5WNfz?=
 =?us-ascii?Q?sFIVyNCwxaSWZyLw4b9QpZID6EDweAC83/15DS8VzjrhAmI97S/x6K6vfkX4?=
 =?us-ascii?Q?Z6ye/AMEMqNqc3Td2NKLrU49NcYnYUoaDcgzN4ZQxwT1rBouPLMHhH0sRd1N?=
 =?us-ascii?Q?zJhwDgBwfpqa9bZl8qUnFoTyPBT6M3E7//qMtdLzLCTnCYPdFV4ZbsCvs1Tz?=
 =?us-ascii?Q?fJR4kaoZ1EFHRfMXVjdu7JNaIrSE2gLInH0+bcf34ljhyByDoxZeiS0NN680?=
 =?us-ascii?Q?ie8N8ifEqj4NG8Qa3HbnLBUEVLkBQ6OOJmvtlH/SD3cwH1fnmwYgsc5ByLPg?=
 =?us-ascii?Q?ewsNg7svLEppB7EvJiNbciCH4CgzhPdNixB5UUPpO2yEmJrcJz7Hcvrwy6UI?=
 =?us-ascii?Q?6AX+g0iL22GH7zuq61jHISYqNuSLM9GHUtr5lmqmQKi3EOmNtCc96XJ2raTf?=
 =?us-ascii?Q?BvZGMZ9If0IyXDOSbKS+qFV0kctktXnH/vhTCSwVan6wpg9T//6ySLnFcWDr?=
 =?us-ascii?Q?YyEwt2BuGDzMQK4djmtCWsoaXHZvnE2A7KDoQiQRWpSvzTq2ijlJXB0bjzLO?=
 =?us-ascii?Q?v2QU22I5iDg94Cgwinw4rp+5CgWgkIMtzRB+KynHx9pi2J2ihKCsEEUCrH2K?=
 =?us-ascii?Q?cy6nJ5la6yGMGJSlwzxg+dl1NNpWwFdOJ9Q1dejhTGA0n/cWHTc+L61zF+rT?=
 =?us-ascii?Q?4C779GtS/HI2k1+Z5W3+oYgYudwHXSyCBfa23RMsArWS8rXPD3OfY45kLP0x?=
 =?us-ascii?Q?nrHdL8Y5CqOUNQG9NO/G45SM9AkEZxHv69iu7Zull1AHNA8GNL3XvJz1miCi?=
 =?us-ascii?Q?Ivd/fb3dVjIAswaFBSa8s03wnihUQa1DiYUv4cPwm6O9vo7SO3Jsgc9Orj57?=
 =?us-ascii?Q?9JEOwhK6dlHzP+lja7+IbAxQiaohyA/HVwf1H3WH2/tIOMfE+yFhw+P7XrHD?=
 =?us-ascii?Q?wByygtiV+w52fvQ45Oq9Fa5NqnwWo9Z/hPo9vc6VuZTTLpDt//vV2eDkr9Gr?=
 =?us-ascii?Q?UP2EBc6lw7wlKbhWhdxBuzV9TXAf4h6O5J3c0vZpOQAa/D9LBreShUiWjeAR?=
 =?us-ascii?Q?Rc+NmxE6+I1igFoSwTJtkK2VBIMXGrsBRHny46Ayj5zPIw9TGMPyv20GJz8o?=
 =?us-ascii?Q?ryHRxuvK6/6sxHzL6vLUfe2izRRSmsNDr6dZ8oYwH4fcT08HfMkdgmSFjwRa?=
 =?us-ascii?Q?Z/KCYx93NNUH6HKuwwGdeNKsqlsshN19CXreCAXcBZN4Dn0Dyn3Me1LHk9dD?=
 =?us-ascii?Q?pGZG7kUPfAn4LlVIXEFKDx0IXr7Bo1yXQ+JmoWxHhPvHhN7C4+MLU17pr+UL?=
 =?us-ascii?Q?srbS2uMMk3pdlDqmyxWvwRTUS+uia42snAdBpln0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ceb05e-30f2-4e95-2a66-08db2973a27a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:48:02.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeKEvS2xSX97EDz4w1OL9EGXa40rz2zwOErIFu7bWgon08JLGDok5SUt5bksKA4K7SW/Q3yYQmKURixcN5Wyng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/nfs/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 0cbcd2dfa732..a6072be5fa5a 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -185,8 +185,7 @@ void nfs_netns_sysfs_destroy(struct nfs_net *netns)
 
 	if (clp) {
 		kobject_uevent(&clp->kobject, KOBJ_REMOVE);
-		kobject_del(&clp->kobject);
-		kobject_put(&clp->kobject);
+		kobject_del_and_put(&clp->kobject);
 		netns->nfs_client = NULL;
 	}
 }
-- 
2.35.1

