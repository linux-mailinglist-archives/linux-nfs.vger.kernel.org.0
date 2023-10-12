Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3553D7C7048
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Oct 2023 16:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjJLO3d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Oct 2023 10:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjJLO3c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 10:29:32 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2070.outbound.protection.outlook.com [40.107.15.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001C3A9
        for <linux-nfs@vger.kernel.org>; Thu, 12 Oct 2023 07:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfLw2ScZ+JDuax0BRIWoV0HO0B88OlBB9kMY91eiuFKlEfnpUz5eiMZgIKtoEnfQ8jInMhUlUXanODsW/D41kgE/iOuZpw2SeKC7Z8LgZ/UeaLp0a5rQwfh3mn6Q+0ATP+CtHKPRWXBkjVLJNektp/PfnJERWkKq5K3TjKNowoEig8+R91Rh4l+NbDm6E37LEbutyvYj691Q2z+E4MyLiiLbiIIyNfi+NDo8DzJqd58XHqIJLsvyhzYzYsvWK2pYs04e8/co3sX5RnJVxie9bQTUmN9GFJ/UTVdOvV7CLvQ+HICGdQg1Uljg7wVrsn+AEc0iGhIB0YQUylljUV2r7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LctMHhkZYXIt9sFnH79VBazSX40SBDonEr/Klekoj0=;
 b=d786WCz3Kh8H3EIW2X5HPU51ohNO3EZdNA6AyK/noy1UjgozgDFYMZJjmmfMeeZFM5hEwEYccLTmLtSaGeikNXG/oQZmp0oWo0ez8J4CUk2G+jx8A02aFz/XLxGqv9/wuhMAWlZHPuDYZbXtahF2gslssPkJ5Tz7f5K+UwroWbVmzrLMavsKf7EzyacUTT+9bTqP8wCRLw2cSGyr+krYee9M0Fay2Yua1LEmi68SCwaQBS9tvdha6KKDFrykJMrWkzmDSKeEAkL2wCdKC1VfOaU7Vq8uabVeKOP8hVwDzbc8LlAbYK5MoTPRFmHMZ2xADW6Z0IH6uBVwWrfZoXTwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LctMHhkZYXIt9sFnH79VBazSX40SBDonEr/Klekoj0=;
 b=obbXytpMkMkKk0R2wz8nUOP0d74WKlm+RojP0R4jrk27NWXdU8T8OPZtUxtZlucFQHwM77gqR+Tgplb3Px6KdR26Ebl71I7bW4mq5oSKVM8OBeG89T61N8Swddmr7NSd62UFvpFAMUpE+SawrZGhSEVYIPAmEpIoRcqVAnuECEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from VI1PR0102MB3136.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:5::26) by AS8PR01MB7736.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:2ae::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29; Thu, 12 Oct
 2023 14:29:26 +0000
Received: from VI1PR0102MB3136.eurprd01.prod.exchangelabs.com
 ([fe80::e2d5:b5c9:16e3:1417]) by
 VI1PR0102MB3136.eurprd01.prod.exchangelabs.com
 ([fe80::e2d5:b5c9:16e3:1417%3]) with mapi id 15.20.6886.028; Thu, 12 Oct 2023
 14:29:25 +0000
From:   =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg.sommer@navimatix.de>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org,
        =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg.sommer@navimatix.de>
Subject: [PATCH] netconfig: remove tcp6, udp6 on --disable-ipv6
Date:   Thu, 12 Oct 2023 16:28:29 +0200
Message-Id: <077bbd32e8b7474dc5f153997732e1e6aec7fad6.1697120909.git.joerg.sommer@navimatix.de>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE0P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::16) To VI1PR0102MB3136.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:5::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0102MB3136:EE_|AS8PR01MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 61dd0a91-91e4-4409-a4b8-08dbcb2fa24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QB/ZRZq9gPUKIkouLBiA9TlAsswEDfJM8/weBAj+CI7O6RdnFWNf3Dx+ThP3BrMt29yvunDaW5AlLamzaaknzKL6n8e3N+I/c5BO8lDSk3N6gv2ASSJG3oJ2bM2bv7hzytM97LQKk/i2jZXgdR87kJl0r0wyyADCicY5R86tbVwisGdqbeHnx8LGuieKmK31ZRSosfwO87kC5G9Nl6um0Gsf1o3mAsAw2R7DExVjyEVuWWdtENjEudn1THqONHURj9t1tBn469hPfzxbajLd1RTC87ACDnXLv8tFCMT1XSkEsdGPjcgKAaUvcopYVe/Rsg3twx500G+kkwE3GMf2c4HptH4r7wZ6uxdU8t/aleN2Yq5TMJSa+GGwTGgMBmy3ku/xyL4RV96COF7iUhCvj29yF06jY1ecSOGwZL+aiUZpMKYDkcFxZcK+7Y1ke/ZhlJ0zPrYcFvBhZVS0Zi1leMp3S+in9cmiUZxvOqKC28j3l7qil2t9oKCcd3QSqXXAvc3Bx2mpC/A/owzTNg/wO+VJ8VaKebr3zDIomLZtc71xSCrH7czJ3ErvIQikiXFptpKr9Utt01N+Kl7Z/zu60UBdyfSiyGBSUmgS7m0WPZDmP9uJxiEFESTO8gg44De
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0102MB3136.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39840400004)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(83380400001)(2906002)(6486002)(6512007)(6506007)(36756003)(86362001)(38350700002)(4326008)(41300700001)(8676002)(8936002)(2616005)(316002)(66476007)(66556008)(66946007)(6916009)(52116002)(478600001)(107886003)(66574015)(38100700002)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0ozblBHQStTd2kzU1Q0NklXMnc2eHdFM0lBYnFYdW1hQ2w3QVNWeU9HZjBS?=
 =?utf-8?B?N3VDOFNWMlVpbmVNb3Q2M2lacWZRbENqa2Nxd1U5WW9PQjQ2RWNHKzgvejJB?=
 =?utf-8?B?OUw1NE5jRktVNFpFNDhPeTRsQUh2eTRnVG9mYjJsQzFHYVk5RHVyZllLYi9H?=
 =?utf-8?B?NzVhT09uK0JtNnlIQmhEdkhCZ3NYUyt6a1VVQVVjaU1GWXBpcSs1NVlVN1gx?=
 =?utf-8?B?cmVqRlVRKzlkNDJGNWppYkNVeHlFYStvQzIzNmxneEZBcUp4ZDJ0ZnAvSXhp?=
 =?utf-8?B?MGR3WEZsbVZPZ1FPYzl5TVJjczFuYlE2YzlTZXF3QnZjem02ekk5bHNhck5J?=
 =?utf-8?B?MEo5NDJWcm1NWC9DaGJLa1pIWEVhdEZmU2duSXlnSThnbElHclFITHpTbEFM?=
 =?utf-8?B?emNPaXQwamVTNFVuOFdzMnlxYnlTQnlTMTlqZnNUVEpBSjlpN1JDKzd5WnlR?=
 =?utf-8?B?bWNVejlsTG1CWHFJNnE3WStIS2t6b1p2ajY2c0E4ZlhBWDZHSndvQkMyVGdC?=
 =?utf-8?B?Y0dTbC9qZmUyTTQ0WGxxakt3T2NVVDhkb0dCWHZKTHNvNnhuMEpZalp3cnBs?=
 =?utf-8?B?UmVQUno4WW0vNnZJaU1CWVh6aVBzdk1LTzRSWDEveGRwRmcxd2J2SXJBSS9K?=
 =?utf-8?B?Sk9FZWdpTWxnUkJuQU05MVd1aU9sNTd1RXd0cGZNdDRNUkFCUmZUY3Yvem1u?=
 =?utf-8?B?NFJVaGVESEJqeUppek1IYzArc2NkUmtmeEFWYTM1NEVwMmE4bk9LRDRjZzVO?=
 =?utf-8?B?bWlBOWlqVVdKcjk3QzlDejVWTkNDeC9Pek42V2pCVFZVZ05qc1prNVZHUU1L?=
 =?utf-8?B?OGpMMGVhUGZuOGlneHhrNUdxaDBwa2o3bFFlWkk5bWFjaXB0NGYzbEFhS0l2?=
 =?utf-8?B?Ykdxd0ZwZkpPSXVQcEdUQTljdkd1YnhKZWZOR1lqUUN4Q2M1ZFBHNUZnSm9z?=
 =?utf-8?B?ZnFhamRVYk1RU3kvdkFtNEJvK2ZUYlBpbFFzN0VkRklRTDlRYkJ2WjYxZkJO?=
 =?utf-8?B?bC9UYXpvVlVCblN4WWxybkMwNE1QMHp5SnFUeEltNjdvb1hGclZFRlErK3pL?=
 =?utf-8?B?UElSVTZ4MkczN2kzWHlNK2NzcmkyUHNldXFDbHRpTk1KdmczcWJNTXNsU0pt?=
 =?utf-8?B?UkNnU0d2dHQ2WkpudktLZ3F0elNTa0ZEVSs1cVFEZEZZa2NDcmU3UkhzNU1H?=
 =?utf-8?B?dXFmUVB2Y25RWDFzSlkrQnpuL0FnRXQwN1VHT2NtdjhYdnFPUU9oM1NwWkhT?=
 =?utf-8?B?TFlzQ2NqY1VVcmR4M0dDN2tVR29GcEREVk40MHlBMEduRTErTHRLTVNSaWlT?=
 =?utf-8?B?YkpMMVdPNDFlSitTalZtZFBnOXEzbGtoYUo0d0Vic2RxVFNERTlvUStJUlQx?=
 =?utf-8?B?eUhEUFd2aDBNL1h4aE1NT2lrUzhDZElkaEdtSUIwbk9JYzJaZ0ZtSHpzZXo2?=
 =?utf-8?B?d2xPSW1BQ2xqWi9Wb3RqNHlzWlZHaHZoSjVBTndjdG85RG5DWGVUYVlLeHBK?=
 =?utf-8?B?R09ZWCtidlRFNVlsUDIxeVVVV2wwTW5WZWxOeHJKK1phZzBIRVVuTHU3R3k4?=
 =?utf-8?B?SHNpL1ZucVRPSFVGZ0JNNFNlMDdWcFNjWVJFdm5aNVFsMm1WWjhBcWJlbUJG?=
 =?utf-8?B?cTFhYXN4MWtCRFVaci9pdXRraUNvelExWlR0RDFLaXEwaGloMjNRSFBrb3FR?=
 =?utf-8?B?QXdOelZ0Wlh2ZGx4TnBlQ1E3S0t2NUlBT2RVeWJFNHBYTDI0cmNXd2VZZVpX?=
 =?utf-8?B?WDlHalJNTEwxcStJcytKdElPT0hxRWlVWENNNGY1K3hzalkzMVJzMmZ0Qnpk?=
 =?utf-8?B?Y080VVlLcTlRUnYzTi9vM1lSVnBDVWM3OElpWWdZaGJ1dTgxdFM4YlloRmlq?=
 =?utf-8?B?d3ErYVBDTFRwWTVYVjg2SVRJUmVaMmxINGFZanlMdmFhZnRKRWlhODBxWEpV?=
 =?utf-8?B?VUxtdEZEY2ZtU3RqcU1HVHlRWmptY2ZNVFYza3NQb0Ivd1lJQ0FobFlZZlI5?=
 =?utf-8?B?U2JGZzJyWFArZXV4dW0yYm5wZHIzTlJxcGtWc09jbE5rVG5UQVYrWkdwTXFq?=
 =?utf-8?B?RkhDc2dZdzJKWFpCRGd4MnB1SUY0M2VKMlJ4aHRmb0NNZGNjUk8yZXI1OTRS?=
 =?utf-8?B?Um8yZDVwUndDa0E5K1FQUHB5VjI5MlRsN0N4NG9KL3VTcm1RWWhaWjBsbGxX?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dd0a91-91e4-4409-a4b8-08dbcb2fa24e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0102MB3136.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 14:29:25.1907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /joPtzxlYW5lEstley2IhTuREhXqwuXj8ZggUg79DGdPH3SSrPVITFLs4nkDnT+r005vL5nz7o4b0pyUoVimBmkAbXD7x8XSNnJVhbArX/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR01MB7736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the configuration for IPv6 is disabled, the netconfig should not contain
settings for tcp6 and udp6.

The test for the configure option didn't work, because it check the wrong
variable.

Signed-off-by: Jörg Sommer <joerg.sommer@navimatix.de>
---
 configure.ac    | 2 +-
 doc/Makefile.am | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index fe6c517..b687f8d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -64,7 +64,7 @@ fi
 AC_ARG_ENABLE(ipv6,
 	[AC_HELP_STRING([--disable-ipv6], [Disable IPv6 support @<:@default=no@:>@])],
 	[],[enable_ipv6=yes])
-AM_CONDITIONAL(INET6, test "x$disable_ipv6" != xno)
+AM_CONDITIONAL(INET6, test "x$enable_ipv6" != xno)
 if test "x$enable_ipv6" != xno; then
 	AC_DEFINE(INET6, 1, [Define to 1 if IPv6 is available])
 fi
diff --git a/doc/Makefile.am b/doc/Makefile.am
index d42ab90..b9678f6 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -2,3 +2,8 @@ dist_sysconf_DATA	= netconfig bindresvport.blacklist
 
 CLEANFILES	       = cscope.* *~
 DISTCLEANFILES	       = Makefile.in
+
+if ! INET6
+install-exec-hook:
+	$(SED) -i '/^tcp6\|^udp6/d' "$(DESTDIR)$(sysconfdir)"/netconfig
+endif
-- 
2.34.1

