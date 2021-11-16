Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DAA452E86
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 10:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhKPKAI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 05:00:08 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:48456 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233524AbhKPKAD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 05:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1637056624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dVA1z/XXLTOQlHUc+JCyZeu7wIlll8EWKhUgPvBkNVg=;
        b=YNrdV6JGyxEOrrI2bQFK7jT8kMlEqgqmJMPSUOcNgTxodzd5dnK8g6P6t+B3c7HezKPk2X
        Ne8s7NUITo6ZJc7hlEmNxfimroLDQqLkV1UH/4AZOAo2OPel6pb1lARMTy6frfwmPIc5uj
        fhGTUZ7TSHmFUE/M1t34HFHJuSAcmK8=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-3-5HjvKAQRMsuHxnRCCaKQiQ-1;
 Tue, 16 Nov 2021 10:57:03 +0100
X-MC-Unique: 5HjvKAQRMsuHxnRCCaKQiQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI6xH7drdvHjCZArjTg2BUCiEEj3aXatuBCEdITMxXtpYqPM9m0yMQRehB1ZN/V5Ov+Pqp3xn4wx6SnjALcT/q45f6CQbeGDIa8NkYQNb6LrZvryJJWdTh8+U+v2b6GqkIMCuq8hmg+OZTHdaGfwK2pBh7Ln5LZVM8y87ffqErTnkcR5Cw/9OYME2MXzKuectpT3A0gbKn+M2VdzC5Cd2wHmlU+sr4TmePx+sg8PF06Oia2IYfl1wkDkGIm7XHafKwT4ciUxTMKR5mAVhq9BUhYvwcnMO2P3yndLLTYC/l+U7JcaplgefMNwR/jz6MjJRJVj5BCwSky/ZWB7ISN5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CE/Sd8/ry4RrknwpGMEhxiAXoHliyQ1B8I1JRgiZzEo=;
 b=n3G14vbpvmIiwI8qI/3Q7JwT0/y0kb8RGQJlIkiXy6Hs0y5rB1wb077PLcRKCF5QE4uvMmbvynlUvMIsc5x+Y+/wx70Ur4szo0EqwtXorRVJqkUHQyF7U0bUZgqVg/Ynt3PVzIIf4968QwG3g/beVUY2C6rnIcpsI0LSJDSshB1uxuBjBwuiGldIoAKMoFSvAj2svqRdiej3H5vsFXfS/1Vf8JbYR5IPrPPxTtVBLKRC7eQHPZvjDlJz/6Zv5l3XO+s1gGFStuB5pZe+7C+6ZbbTd8K29PUfK0dsuCkmdYD8Ovmo5jemmw3wNF//jCAnaT/B3+zj5Mh+fLzSZzIQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR04MB5847.eurprd04.prod.outlook.com (2603:10a6:20b:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19; Tue, 16 Nov
 2021 09:57:02 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::751c:876b:9fa7:9468]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::751c:876b:9fa7:9468%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 09:57:02 +0000
From:   An Long <lan@suse.com>
To:     bfields@fieldses.org
CC:     linux-nfs@vger.kernel.org, An Long <lan@suse.com>
Subject: [PATCH 2/2] server: Fix t.time_taken type for xml_printresults
Date:   Tue, 16 Nov 2021 17:56:32 +0800
Message-ID: <20211116095632.21811-2-lan@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211116095632.21811-1-lan@suse.com>
References: <20211116095632.21811-1-lan@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
MIME-Version: 1.0
Received: from localhost (240e:304:4b82:ab1a:3af0:6301:25e7:1bd1) by SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend Transport; Tue, 16 Nov 2021 09:57:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59ce79c4-6cba-47cc-192f-08d9a8e76ff0
X-MS-TrafficTypeDiagnostic: AM6PR04MB5847:
X-Microsoft-Antispam-PRVS: <AM6PR04MB5847574693FC688AB0D1EB1DC6999@AM6PR04MB5847.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5qcONCVxmWpCvzkxI/c2mHoRM0fGTrEbzZN//pN5GIqBg7U+K6YBb/p8m3qRQqyOfCmnI9HDX50y8yQZB7rXYyCAg/2Pkjh+6e7Q49rudEudUBcobYx3q9pT7Hnffwap8qVtDELXxJxc28vFwAzWwD2mVxzHEvPzSzd2r7P9A6ApuCyCxYX+oBd9bU5ncZfJQNDvrSLujICh3QHNt3+V6nWvjFSTboDvZxHQdvAXJqP47z6/xkBZj3dDEd/dzeK2DK3CwIFcPpftvp/1mDpXXWRs7sqrRRYDvcyT79SOh8/jpE/WFzeh0/+UEEJk3pdfi6WtI8SSC9/R/0SchWCJ2TxKl/7TtjD0KNEr5+QHNXyfEqh8AAek55HFyUk/OXVhOsTLgXLtv4vDLL43nS8/1zUiSZm0wa6A7mk/+o7UeulXr7IZzI6A1m/T3fp6pxWAQl5JCed7ueoY2o3gd3q+e8uo3hTBvNx0wDmm+dm3nm1q9OqWxo/Y3DmgLIj8Y7jDq8mvoJO6UKrm4LKaFk4lm+uYh7t+bc+4x2qV8Bla6hgM2bCS0gaM3EOc4V1Bo3poBrVJg+j076ny9oz94HTGhVxyE2+xHSiBjZ7VG0zYBM7XU+GhGXL/jmMLXsJzazQgOufghH4B3CBHVakPvOS7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(4744005)(38100700002)(4326008)(6486002)(8936002)(6496006)(508600001)(8676002)(66556008)(2906002)(66476007)(36756003)(66946007)(86362001)(83380400001)(316002)(107886003)(2616005)(6666004)(6916009)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v6TQNtnecCkr4/3i3380j0CzBF2eIhmiQXRg1Vc7mIbAZRijie98n0cf5rrL?=
 =?us-ascii?Q?uzp/yvfcXBzCZMCe1lPnwTMMc5CY8s2nL+wM8HRErNXZ6zV/vab7ghjcwfTI?=
 =?us-ascii?Q?5jXZbQUueQjEpqfqOHK9tNpJnak/xj/iidBWyO3mH30cEhaDxRzyhFhVdYat?=
 =?us-ascii?Q?rKUvlWuUWeTvlkoAWpg2wtHM0frSkS/CX1time9B3jNQ+j1wPjbJhI0Fwsu9?=
 =?us-ascii?Q?GTqtmq6DyAbZN3JYdHL+ThX9io2ntZp7vzbtlWJcdwsueuCRrWTbbYisHYX7?=
 =?us-ascii?Q?iryl2TfECWex4qomkfFvFBKhh6iotoLNYE+Bz89H9jfTk2qVtvZwccEUMUbx?=
 =?us-ascii?Q?HeaD0atsthe8Crak/2JoX5tchWbUPChOrlbkbD9+ymPf7vCosR/YOb66ewNq?=
 =?us-ascii?Q?GJ9Bz2yzVlqzff66EWySqN7n9I/KkvQqzZQiaTDmUdMAu9aMh2S6NeRX28dg?=
 =?us-ascii?Q?xGmWa844k000dAlG3PWCx+skQbIAHwhGWq1o4fTYmoFgviPKTe0/FsgKG8Bv?=
 =?us-ascii?Q?oZumusgKBFQIKmdAGnNlHbaqw54OAtAX8bZW2CB0JIbdKp/e8um7kcPkkRee?=
 =?us-ascii?Q?IyQ+HUJ3SbWg5J5sNHY0emKPT/+9dfNE288l4X7HWuOwhXGmBj2aoNhERbEt?=
 =?us-ascii?Q?wMOD8vLFWJAUsqcht2plF8aBkxChe4XpmGzHL1A3zDvZw9V44tyaftB9E95g?=
 =?us-ascii?Q?Wm/Yu0kxBlJUNDDDO47pSa54pxI1cwPZxmpUzU74gTnmh16W43bZQTbrd507?=
 =?us-ascii?Q?4shp6dq09HIVSxremkLpmuTnq4djWIj9ygFskOm65b46dv5RuZXOKPRqmCRJ?=
 =?us-ascii?Q?JSohJaCSye4AY2bKQzGXBwSilq7Rpg3KF5Uae5IG5csAqM5CZ4SCr0nWV0JZ?=
 =?us-ascii?Q?g+oczDj3vOBWT5C3g7kPjwNKEA4JKqsC5GLJtbnYG8bPjF7cW9GMzr9tdT6I?=
 =?us-ascii?Q?wy1SNQzKFveEptLMTX6FSjo453iUEjmolt9JIPc8i/64WqpZvadii5uylwCY?=
 =?us-ascii?Q?SV+LGvNn5zN/r1DlQWQyItow4w7sCQkP2W0nrRX2qpNvJasSNpEPwtjWrtnx?=
 =?us-ascii?Q?6HAoQdjQqvZUPNaJ8xnyF2sVdqC0UGGzEkOcJwlih5O3f6pn/7EAdezGcCOM?=
 =?us-ascii?Q?3ElCTObNm4Cnm0uJSKIGO19CTDaqEGPFRQY96vWQDDGlvcEXPHxhV0kAU5ug?=
 =?us-ascii?Q?eDHuWFdmpB7UZJ7yntQFF/riRUlECcqoyoNA8a3UY/GiDWwisCIdZ0IDTP4Z?=
 =?us-ascii?Q?hLrGxXucG6D+nUcn8+6HQvNnCf+pNS3MFav3eTu2IyFGTHyG3BsRY9R0/aWe?=
 =?us-ascii?Q?gfj7/OI6/iVhvUF96MBlgT6KZASGmmLncL3KpfMAoGpXKw3m5NvfXiMNATGI?=
 =?us-ascii?Q?A8+B6W8pHCHHMZnZKB2rD/hbsKDpSgqodcSIV+EH0I7kKBcb74Pp0Gdtpkdt?=
 =?us-ascii?Q?xfBGNDNPh2HQz58dsV5r8VkWDVYCf2bwl8kv76YivQ8rOvgzGy8fS66c+Vbb?=
 =?us-ascii?Q?jdiJ32q6gt1ENcuawrCVdJMRXUkro4FUGuID5JddxmrqIZf0sEwcmrWOfIIt?=
 =?us-ascii?Q?Qtt3F5jLUEsMxLw1Gbs/jZvOw8v7rmzX/DjVwUBiQi3KYwm+1HLVcxkQLM4h?=
 =?us-ascii?Q?y9WP8yNbRMxoOCAzJBMgB4U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ce79c4-6cba-47cc-192f-08d9a8e76ff0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 09:57:02.1781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yyUm9BsEa55GPzpD+C1QZJvnh9iBloragQYczpGtuV8MbrIXzQGGIdm5tihZnvF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5847
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

t.time_taken does replace in _write_data, but 'float' object has no attribu=
te 'replace'

Signed-off-by: An Long <lan@suse.com>
---
 nfs4.1/testmod.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py
index 47016dd..11e759d 100644
--- a/nfs4.1/testmod.py
+++ b/nfs4.1/testmod.py
@@ -524,7 +524,7 @@ def xml_printresults(tests, file_name, suite=3D'all'):
             testcase.setAttribute("code", t.code)
             testcase.setAttribute("name", t.name)
             testcase.setAttribute("classname", t.suite)
-            testcase.setAttribute("time", t.time_taken)
+            testcase.setAttribute("time", str(t.time_taken))
=20
             total_time +=3D t.time_taken
             if t.result =3D=3D TEST_FAIL:
--=20
2.31.1

