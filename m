Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDEC452E85
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 10:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhKPJ7s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 04:59:48 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:31940 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232326AbhKPJ7r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 04:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1637056609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hc8I+be4JoPTFiCADj1BbbONL89OzTJSxzAQrt+N30I=;
        b=HTXpZT/piyZ2KJjt3f37d07yZXOi9GgRSTU8/Z5Bo6CC4M0kQohEnt0gtLhSFeJcs9HAiS
        M3QwPcruk68TM/9w86PtpvyJjCWRDsLKasBs5PstM4yMuit38Jpp+jBoeo3l6vJU5EtG7c
        9UyG0nxWk34BL2VwvNQTJGM5huWDCgE=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-24-vg6DXsbcMMqIIkM6dk63fw-1; Tue, 16 Nov 2021 10:56:48 +0100
X-MC-Unique: vg6DXsbcMMqIIkM6dk63fw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7KBwl+Js/1wvxtTf06aJii+Xzgg3wh1YloOPsCMjuwq2U3ATfvgc5mis1fuxB02hPBQrmFgCEog6GsNW4+HGFPJJA0NqxQ07mqA9QcJNdlh8d4PpiX9zCd3293EVjQRKycmsKDEHMeT1lrSatU8H+mSPwmfGqB5MeXYyUDfJpnkiDhHr+2vume9ngJV356ccFYx0ZuuX57kXsHMCMTcAMNMGxKVm/iHFET2iaeKQtVIvsRSQFzYON0TdC4QJ04jVlry5Yvk7onwfjym4C3RneVDhtW8+stW6BS8ox+dbaPJHyASQARlyb3DyDgEVyusT8pc6/9BFBfEcRFkJckIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IudZWHCSrAAMgwHVilxHu67K0TSsFAWVqaC3bogiP5Q=;
 b=bQwOBRQ6/J0/JxRGMM/gacYRpKkgsIVMXwX7PVbQ9sw4sQi1qC49lyfekqTXUk69rXbkAC+ztGC8WlAXFNU01v4+vVuB09/2AQ1JikLHwBV6gNf8IPba3RRjK8eLvFrBTXl8Pg5AqyXpt9sdnm+qoiVOsi1F4lwqm2Hyi9zaO/gXrn1+41wRZ77SWEBYsQakugzoVIpZ41BcCZC0e5wv5R9PfA53aOXvLXGQDYlKDLwaGpY3t8hzZtFCT/0FeFC+eTRLfNH+lfv8j5boyYTYDGIzC272Ango2sHsJlp24I+s9EAG8Px19Gkzne+Idhj2LxJAOWL4e5jU0i+V++WfZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR04MB5847.eurprd04.prod.outlook.com (2603:10a6:20b:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19; Tue, 16 Nov
 2021 09:56:46 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::751c:876b:9fa7:9468]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::751c:876b:9fa7:9468%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 09:56:46 +0000
From:   An Long <lan@suse.com>
To:     bfields@fieldses.org
CC:     linux-nfs@vger.kernel.org, An Long <lan@suse.com>
Subject: [PATCH 1/2] README: Fix typo of install guide
Date:   Tue, 16 Nov 2021 17:56:31 +0800
Message-ID: <20211116095632.21811-1-lan@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:4:188::14) To AM6PR04MB6630.eurprd04.prod.outlook.com
 (2603:10a6:20b:f4::33)
MIME-Version: 1.0
Received: from localhost (240e:304:4b82:ab1a:3af0:6301:25e7:1bd1) by SG2PR02CA0134.apcprd02.prod.outlook.com (2603:1096:4:188::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 09:56:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27eecf1a-6ba7-4526-dad2-08d9a8e76691
X-MS-TrafficTypeDiagnostic: AM6PR04MB5847:
X-Microsoft-Antispam-PRVS: <AM6PR04MB58472F6AEC5DCDDA7A47CBD4C6999@AM6PR04MB5847.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2H39u/CKZLtLyqzUqNTBlgZBiB7defdkpZtvamKRDqS7rUHPpwM3vdj/Nw/sgr02+59WWX/7b5HJC477VM5Gwqm0fJ+RtyMMfTXE12IompE00jUd3e6bZz4TvCgBo1DxuwMeTJHhJksShGYx7Dc1pJ0+b7WiIv6iqH9I0KEY/shkPZOynU4DUig2ElPAWFySpMobdmkFAijDHnKhNSiVKa6rhw0JUMr6wSoWa6imcd2iQLXt9ihqkIo2YZ1MknJCfs9/fpK2XJJgV2lBwuM64xrOWgiq07YMxg0MeTvNRqGUHij3EInKAjloUsZSA7gq/tgXgS9oDWnqQdiNbNQtJIgYDZvFX2N5OHI8GV9kIIwdwTKTOQucxPqVXIRTxH11l8gQB6ts5D57b+HemlxPCZLE3CqGCS24EFO37cNiPsEyO46sotyU2pvgfcXr/zzha84XswBSN+qSNSnN9+lzzhrd7TzqX5X1Ax4nlGlaF7/Q6gJTrrTpunxjdBAtnqpR8FBbtFMX1pVBzsl5ZnVCFROnWFFNOdHiww6578UD0uxjTZOGtJEKqcAGxkSzJ/4t7E1n7VtoYBJMFogRyppKAQ+dlI8riIpvgwdXbJ4fAu1JcIDzu8g2cATHx4pQhR/pqy/xBsqXlDKyvTVBsR4xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(4744005)(38100700002)(4326008)(6486002)(8936002)(6496006)(508600001)(8676002)(66556008)(2906002)(66476007)(36756003)(66946007)(86362001)(83380400001)(316002)(107886003)(2616005)(6666004)(6916009)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iq+BNFS52mzfoIzoXW6nI+oAekXT8UQ9iChCbsyKSpONFzEFSxRr5h9s5abm?=
 =?us-ascii?Q?NiREczSZpxVZ8JVV8tN6Q8GCS5OQvG8PHwCuo9ZchvU3kRGQE5IVGjbP/cVx?=
 =?us-ascii?Q?nHlD7yUzVJiyMkeyjXXDHsk9+Mov0H0zKElMRHgf9s1U6tR3hHksY3S3I8aJ?=
 =?us-ascii?Q?FZ7K63o4V14VxLhM1CnH6vDxxelopvyGIkO1ndtBv8JWKuRLAQM+sh2ItqWc?=
 =?us-ascii?Q?E2ADVqvfpHFqqPiWPY7ODIi1u0wHMtgITLyr3K8h5+yMoo4Xbu5D1r/GFY0t?=
 =?us-ascii?Q?rHingjAqkOz6H6xEQWfTHxxlroIJ/VBkbqLhDLNOfuQCyX6v7C24mDaYMTy4?=
 =?us-ascii?Q?35Do+le15jFIFS8ZOpMLi0gv9YZmRvpyZYSKQ3rsq7a3i5ELOnJu7jatV+J/?=
 =?us-ascii?Q?Mnp0XEK4HsvO4ayP6XI7er2v7+dYc5/9kI3/T71E6qZ949UJOwATaOuVkV2d?=
 =?us-ascii?Q?s7uXnm2lzPBFhkZdDrlbOXD81QfvyK8MsfWqS5EdjLdwPyB2yxKZTv5DJcBi?=
 =?us-ascii?Q?88LziS83vg3g4+4yjit/3IkNfkaeclO6Z1Q/2SmkkT19jWETFVZBx4DBc3D2?=
 =?us-ascii?Q?4/mzVmn3fMdYFhZm5kks8XfNuCjaWk3gGsDZxMYSZ18nSs5slzp/MO66MkSS?=
 =?us-ascii?Q?mHv3nuSToLCC13vwBZZmUJhJ44vo6nJoACvGyxQZsTTGrjSAvKneklQWwo18?=
 =?us-ascii?Q?eTux0gOeSE2ybfZKRYV2c+4nNuvkr8XSJbuy7NqHBcGtB1y7EwKU2BAz9Pnb?=
 =?us-ascii?Q?JIivOJkGheIPqFnbYEGTdfnjj3xN8RuEYdBKnQTU/AzB/wJl7SCrTLfUeGlN?=
 =?us-ascii?Q?XGP2Sab4QBH7fXWc2ByGosGvuJGrg9r1I+E5Hb9j0ZpVLnS0KzRMZJibXlKy?=
 =?us-ascii?Q?UKmGZi6xNpy7HlJcanbOrvkEazm4iFKV9L4294YMVBVmvs5jYFIVY0REbAVk?=
 =?us-ascii?Q?eQVgtNVVXHhj4VMRLCTob9gTo7YOhp/K8XrdsNEwz0pmUTJXDG+M9gt0iR5e?=
 =?us-ascii?Q?k9TSPdoozxOIESlIZaVl0vuDwdsVOKMsOqMEFOGl3dn/m9qBn7e5go0qKBa7?=
 =?us-ascii?Q?s0e8unajnH6S4t5jWjMD5xB5F4z7oZvzef+8AlABvzptYru6921XJqDrqekU?=
 =?us-ascii?Q?UMFnXnPQ6j2oCYIHvI91rMcD2PYF7yx8OhwFKjK1xYi+qAW3szbcRQHObFsg?=
 =?us-ascii?Q?0Cl9kCDbRngYcm+c90EhW380RmYbRpT/LRmVhnfe+GAbBagAR7YOWtlaVqDN?=
 =?us-ascii?Q?N3/vNhA+CZ2/TnfUaehsOQW7p5qOt9O2A3pHFk1PNYtCFSPAoog3juHQb7DD?=
 =?us-ascii?Q?bWw8iX24z6GDGQ7Zt57KqRPT6EJ1gxmQqCK2CihEBfdXHxyPJsn9Cyn9BGwa?=
 =?us-ascii?Q?6Q2TUwXBG+FXM/OjA+HpuxWn8qJmd3vfjzKWMmyxodRSAnon16uZyTBWGBgw?=
 =?us-ascii?Q?WSuE6wItBrydDaGBXnKj5w8FZM5ObP0VFOHeDi45mccu0+EBsEkbANyNyxWi?=
 =?us-ascii?Q?apqaLHO+8qCEStd9+2bxfouXz/hRTGNWaeHm30yq9C2BY1BNU142sWEhZ3MF?=
 =?us-ascii?Q?2MTWv4ztRb+1H0axJ0NhOv/VVAHQP4RUxev1wn00U0yyxLf2Og72gcWEgb6f?=
 =?us-ascii?Q?97LADf021JAa4s3boPGaf6w=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27eecf1a-6ba7-4526-dad2-08d9a8e76691
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 09:56:46.4320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3FwdBdaKiydxjfQ5c1zGtlgyl7fpUtoFnAVHsVAJk5hcuvqXroroJnZPXr7lStk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5847
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: An Long <lan@suse.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index fe2eae3..b8b4e77 100644
--- a/README
+++ b/README
@@ -12,7 +12,7 @@ Install dependent modules:
 	yum install krb5-devel python3-devel swig python3-gssapi python3-ply
=20
 * openSUSE
-	zypper in install krb5-devel python3-devel swig python3-gssapi python3-pl=
y
+	zypper install krb5-devel python3-devel swig python3-gssapi python3-ply
=20
 You can prepare both for use with
 	./setup.py build
--=20
2.31.1

