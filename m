Return-Path: <linux-nfs+bounces-3698-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9009056F9
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 17:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3281F279B1
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 15:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203361802CA;
	Wed, 12 Jun 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hvs-consulting.de header.i=@hvs-consulting.de header.b="f4FoeNAr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2095.outbound.protection.outlook.com [40.107.127.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7C718622
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.127.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206499; cv=fail; b=gmySmizI/saZINi+icLCLDWYXCOm7b2rvLgqvcD/UnMADwfb+u+xzrdobzi7xtRdERzq89rXBox0CcXiviQvKFE32bDQWX3eq/i42912QhJUna9wGL7hBqQHQGutuzQWIWQrAL0H4z4gx5GYWnBqrN6iazwE/IlZBWRT98ag2Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206499; c=relaxed/simple;
	bh=n3gffyfcSd/Cnfk2MfJyIcLd7tYv/JiCx6nFWGSti3M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jxHecZSih3l71B8JzT9IW53AQCemBJIXwOVrvnwHvlx2Wl+I75opufVk1fvQK8xi+a6YOlHVbPYio4OZX/sjgLaeOSLv5KPELtkb0JsBYvyE9P6PqPXEihhscH4eszw6ehp0+R76KCCBJ16OhnqAh8XGrh8zGutyBMODufu3mGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hvs-consulting.de; spf=pass smtp.mailfrom=hvs-consulting.de; dkim=pass (1024-bit key) header.d=hvs-consulting.de header.i=@hvs-consulting.de header.b=f4FoeNAr; arc=fail smtp.client-ip=40.107.127.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hvs-consulting.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hvs-consulting.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgBb9ZQUVhFGy4GBC+X1jiBFLaZcWiGdlxlLU159l68FJmQ+7u03iBVSHHaT6tDtEFG1dXpFnUFpb3zfp4XK4GMTvyb3LxkMgfmAlef3t0hku3rgk5XbnMhwBgZmbgnuzwc1mXBwo3kvoCpcQs5MfC34X/Gg5HOkrwdIp7VNzLQr5p8sVx47OLZz8QtKNnXtqbt7uuGcIr26lsroVNzcoWwDIdsRYt5EG60f7ueYAk1fj4ysu9O7Qi5AL+LQK9VCra91APLnCxm62y96QBr4YpXiQW4Fwa0/bpMVEPWhOvhETivWuhHSO5V6854eYRKyXh7MHKmh+6a2n5NwF+zOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ov67YVVcvKeuifwp2Iwa+p20sJWeOuypJun699Mq5+w=;
 b=Uy/qcZ0o8U2kWhKiTsw6yH0MC8rloF1Gs1DNYAHaaHZv3cvIVTd2+g2RqgJUix1w7sngvQjtb8CJA1ZuQPTfz0UvXBQMFTBnJKf+o/uvuuNJUFqz9PvSxnsHj2PqDl4gYKKqvpEc2vSdA1fzcjclh4m1IvW9YQSm8WLRDGmLDr7eX1IrUwGpMHxd0f6kdx+4TUwxSVFLIxpHa8RzV2YO4WXvaHKSF4j82WVngjwMkFbxf5deL46Xw0kbwM4cslHyaacZCHUYrBGEBH0O94kkphPaq6C4stxLxlbDMi+fKZ6Uk4bgGnK5KBmmtpr+J3VMGFnALqw8CNeAvsba+7DD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hvs-consulting.de; dmarc=pass action=none
 header.from=hvs-consulting.de; dkim=pass header.d=hvs-consulting.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hvs-consulting.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ov67YVVcvKeuifwp2Iwa+p20sJWeOuypJun699Mq5+w=;
 b=f4FoeNArtjADH3IBmJRlJCgTMUVsJE2FehlyiHqFt+ofGB+BIhSnfTltDvgAAmJbnVh1FIqps6kQD6VAwZKzlXYDRFdlyGC2nKlJReBVVEPmp8m4HkRAv+dPRtqLzdGR+2k56m25gIty7+pqpw0UwpnrZgK7N6tOkQ24kX7An1s=
Received: from FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6::13) by
 FR6P281MB3454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.20; Wed, 12 Jun 2024 15:34:51 +0000
Received: from FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cdc5:6766:f10:c5b5]) by FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cdc5:6766:f10:c5b5%5]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 15:34:51 +0000
From: Philipp Tekeser-Glasz <philipp.tekeser-glasz@hvs-consulting.de>
To: Steve Dickson <steved@redhat.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Philipp
 Tekeser-Glasz <philipp.tekeser-glasz@hvs-consulting.de>
Subject: [PATCH] exports(5): update and correct information about subdirectory
 exports
Thread-Topic: [PATCH] exports(5): update and correct information about
 subdirectory exports
Thread-Index: Adq824ZRb73cWLV1Qf+/Cbf5cumaZQ==
Date: Wed, 12 Jun 2024 15:34:51 +0000
Message-ID:
 <FRYP281MB02054A1BF04D3B65241939AFE6C02@FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3103361b-63c3-4e5d-bb32-7dcff6bc1758_ActionId=155c84ba-7eba-41fe-8098-c7ac68f04fcb;MSIP_Label_3103361b-63c3-4e5d-bb32-7dcff6bc1758_ContentBits=0;MSIP_Label_3103361b-63c3-4e5d-bb32-7dcff6bc1758_Enabled=true;MSIP_Label_3103361b-63c3-4e5d-bb32-7dcff6bc1758_Method=Privileged;MSIP_Label_3103361b-63c3-4e5d-bb32-7dcff6bc1758_Name=Public;MSIP_Label_3103361b-63c3-4e5d-bb32-7dcff6bc1758_SetDate=2024-06-12T15:16:51Z;MSIP_Label_3103361b-63c3-4e5d-bb32-7dcff6bc1758_SiteId=46b507cf-19ef-44e7-9c57-03090a2c6e24;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hvs-consulting.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB0205:EE_|FR6P281MB3454:EE_
x-ms-office365-filtering-correlation-id: 7d1db5c9-4e64-44c1-de2c-08dc8af533a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|366010|376008|1800799018|38070700012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?O6viDfUDK6bljmQZVq3EI6vayxk4nWtdFkcGFnieBch3XaqLss6mkXu98m8x?=
 =?us-ascii?Q?VAlQgDEDWEfu0eBNRLVe//pv894B+FSJfCcu3Fs+d8q93OcQbuUtE2Ani0mg?=
 =?us-ascii?Q?W6usVIoKMY/ebWCDcHsb74nuTOJ3dk9FJuP4yNhZNbzCP7wLyIpQrwTpBpMW?=
 =?us-ascii?Q?2rjUjh9UqP7H+t0xAcQhKzdWxfhwOjNJwM+DFOD13i0x9keOnlruGYsIqPNo?=
 =?us-ascii?Q?pJlZmzW+a+UaRhqArsg9UCd5Mu0eWLKS3HPF0IIBie5fQV7NX/+Tmy3ibT/j?=
 =?us-ascii?Q?9IM4Mhy2avwha3z3RdB/lbGSgFopHtbmcylxCqrspngkEuyp9Fsp6BdNl9gM?=
 =?us-ascii?Q?AAUyYfZ18bVuvK13rPvQfo98BoWRlDwmcKkPsdWF+9eTDW5elymOR/CdZrz7?=
 =?us-ascii?Q?b9Pr6iNq3OZtxLxYYEoFyld6Qf14bW8fkruKGngnBkI393HmZvauB0598xxI?=
 =?us-ascii?Q?RhDQiVQn9TS5xjS6yQQvM/Bo8OhG5JNds1sqvzmGH2H3pYGrFZ7z8qhanciZ?=
 =?us-ascii?Q?034KusUB1CdOSTjwrIDq/18bPVxcc3QeFluujPtCyyKiwYtG+T+1uqNEkWKj?=
 =?us-ascii?Q?s9pxv7y2db8/7zCRnxUYct2bwbiZS3Fd0d8Spl3wErnarPBt+ujVv4Y//zbP?=
 =?us-ascii?Q?8pVdaL6VBQjt5QcUzrCc9OgoZaHfxS6q3FVx1m7iSDtBwU/UiInidscOR39d?=
 =?us-ascii?Q?Jzuq3YREHnztbUnB0VJB4cXXKGonQTgGkiPcVNYD6mLyAf1qMaKsInOMm4Cf?=
 =?us-ascii?Q?xhZmENxrstKttHeMLoQSvZrq2MavLPdC0K7BrS+UvB1cMU6peSOISqGnAxli?=
 =?us-ascii?Q?cAhWlVEQUHqNSAQExXhYMBid0OCSwA2xir67IFn8b8kl2A3slNJdgBqLuOiY?=
 =?us-ascii?Q?aEF0hezRpob+361IT4CoGJ7L5KwpPF04vH68K8UOq5BiME34EVWKITsKuIEn?=
 =?us-ascii?Q?0gS4VmaF1io4OZemjDhRmGpcD/bZONAfmZV9dCrqNvmyXvpaPu3Q5cH+2nId?=
 =?us-ascii?Q?XimjtsFhfGFZn71sJLmP2TFK4C6MEHFft2FizmsPpOjt8Ia7sLnmKohnMIRo?=
 =?us-ascii?Q?pV/jiVw1ws5xszrv94/zFmFkSrif3QdUE9kzqUEzp1htOOIE31Fp2w8/QeDx?=
 =?us-ascii?Q?q+BgDV/G3nzggCJDtBU+rIQBtxtfzWV3awIMPGlJL9tEi243dnMS2bp21X27?=
 =?us-ascii?Q?6isDgDM+Lze2Vq4vZzF7Y7MGmuaqeUDU4NX4Bl6X5JHNKUQTBpGNMH1Qeo8t?=
 =?us-ascii?Q?bf198hLiyxOnjYcI15fejr4Q7/U0y1zeeN7TIlSFvB+4Hi614EldTghGfx9R?=
 =?us-ascii?Q?w5PW00H10pC5+pmfSD0Y4n1+u1WZclj+8+gs4qpuRn8HntWFU3WPE++JIl/z?=
 =?us-ascii?Q?g+kCsNw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230034)(366010)(376008)(1800799018)(38070700012);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z4CPM+suB8iJTznf7wvtrnS9Flv9dyS1j4yihh0W5vVzr2Twto/UAGq5KYr+?=
 =?us-ascii?Q?snZ4xfSKuxEDrC/GFw+d+AZ9rwUXthoyLCsvYcXvyNEDOfVNlIrfBBQgVqZu?=
 =?us-ascii?Q?bxZ36uLsd3Lv4GSAN+qiBwDwNBg4on+VPsOJ5FMGMXfV75YpifE32HTffWVD?=
 =?us-ascii?Q?WeRZpIqntWHRUJzc1Ptc6mTxVGq/4vniUy5eZY3Ao6Kt/Og1bEnhDwD4vUjr?=
 =?us-ascii?Q?UsfYKkq5G3BQkOq4Ou336GtIn6+oOTAOyyq5gRPi9HOlRNa44WzDvf2taAvL?=
 =?us-ascii?Q?ftSigJHl7ezu/YukbF1vyrA+jI8+JLN8Rhsc1/0bWlm6cmD8bkIMjaX+bubI?=
 =?us-ascii?Q?Z0HYuWSRNL5ykQafjpq3kYHJvH039jaubyslSA1FiI8c6IELcBHRyioLuYY/?=
 =?us-ascii?Q?uh4S7T/uo9o1h6/cwEO1LAC+EvWt4RWggjOfJLrFLLJnwQxWqdWTlUf+LYt8?=
 =?us-ascii?Q?vDBCUJy8cHaJfZj8/hOxs/7FZ9gBksyKH+rtmUNnA018mrWlrv+fVNHfoy4X?=
 =?us-ascii?Q?IIjNEpaCtjHIeCCkKmL9CmmpACU05thv0kI/gcZ2P7X0gKqDzJ9ri+8jtVw/?=
 =?us-ascii?Q?9oiF4NIXXk5hX66x2K5t0SpS2zn5lmJ8zLGKMFwUMB49S3WNMqH+rqdP85y+?=
 =?us-ascii?Q?/L4YsCQymRDQwcp17UHBLcnWZikvdLobfSz5ghg+ljKVKoN8ON9hKHV2GiD0?=
 =?us-ascii?Q?juMQXJDQQsgc2peC9KpTyTppWG4A0XZebTBiCiU/BmOV78zyMcDOv0GV1nY+?=
 =?us-ascii?Q?HLOpCmmosM1gN5pMBzm7LBU9rXe7iWTvldrJG8o35Gld0RMGIsdcLaLHxbR4?=
 =?us-ascii?Q?l6U8qT0OYZpQa1M0rjhpwhmdmPP7dyWjICbuRYrYWhtLe1S/lE5cO02bj+KU?=
 =?us-ascii?Q?QXj6UUUGCXXXrJQbMLMobwYvOS9qhmA17fvCJNo7EQbP5gWLfRlMVwuAXxDM?=
 =?us-ascii?Q?9pqS7PJgGvuR60FG+Rdf1E0mUh4CimAHotvwt84MiClr/VI8rsM8psSSo6T5?=
 =?us-ascii?Q?wg4DvYWAh3Z4dx751ucENPeSJn3LCmSvMgPxc7LHARMK7FhLx+KDtAGlphaZ?=
 =?us-ascii?Q?aN0v5HEeIT6DmCfjxW1HCqqoLIbd/oqLr7H5oEF0ht7hott+qvdprW7MiMGq?=
 =?us-ascii?Q?ZdfGz5ZF9BADyw7CAZ5tOBqP/jm/EKfGXjL/T3rg0G8Vd7SgJ6hTDz/81T8L?=
 =?us-ascii?Q?UF0w8o0K4JtU7H/L8xINHO4EHIFCpxVx0pyVve/m6TfwvOQ6vT/tjNrKpQJI?=
 =?us-ascii?Q?mDA7PcPWrxVVyfnrC+xyCwlnMgVOJXeWCStTGPgGvA4E3j69xR8PfLqSnAgo?=
 =?us-ascii?Q?rYCPD8FSX/PhB9bRl05nla2SS+YsoXFG8TpEfRmjYrXIMHvB7va9Rbhr5h6A?=
 =?us-ascii?Q?+5M5pzQWgWxJyRjnX5x/k7iMSK2l21y3EHngu1UYpzW1oUaGIPJuzi6wP6rR?=
 =?us-ascii?Q?iT3/ZgYP0xDwj0iHNNXSljfYWJawITht4kRVJRLAxqQvSPDvJa7HWJzF2tSv?=
 =?us-ascii?Q?GeYDaBlBm2Hx5Y1jg4u4tjQJsJonG8KFUt9uofWhZA7vY4M0o00fGFu9cXag?=
 =?us-ascii?Q?WfBpdODdMckoMLxLW3UHTjToTAlKas+E8yEgbORRAwfWanrQ1KS7i5VKxYOp?=
 =?us-ascii?Q?I6RK1QIEyR2T1ukq8/lXYiq7ZG+Ikk5kkz/FMVdah4HiZ6n8grtvFwzmOlPQ?=
 =?us-ascii?Q?039XGWgbv3TkXV5jUDDJpEbEb/I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hvs-consulting.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1db5c9-4e64-44c1-de2c-08dc8af533a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 15:34:51.7713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46b507cf-19ef-44e7-9c57-03090a2c6e24
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4c136Pj01yDsCb3WGFBk1UADl1u8zlDUMTcEO47Vm/1azRO6RXR4l60GxwqBxU2jmc8U485jwEeVkWw/pZ/nsdik7SfLXG23oLInvG5/Me01nA2ASeN5+4c60yEBkOsJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3454

Document that the default option is now no_subtree_check and add a
reference to the Subdirectory Exports section.

Add a warning to the Subdirectory Exports section that it is possible to
also access files on other filesystems based on a previous discussion.

Fix a typo in the Subdirectory Exports section. The correct option to
prevent access to files outside the subdirectory is subtree_check, not
no_subtree_check.

Signed-off-by: Philipp Tekeser-Glasz <philipp.tekeser-glasz@hvs-consulting.=
de>
---
 utils/exportfs/exports.man | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index c14769e5..39dc30fb 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -302,9 +302,9 @@ option can explicitly disable
 .I crossmnt
 if it was previously set.  This is rarely useful.
 .TP
-.IR no_subtree_check
-This option disables subtree checking, which has mild security
-implications, but can improve reliability in some circumstances.
+.IR subtree_check
+This option enables subtree checking, which can have mild security
+benefits, but can decrease reliability in some circumstances.
=20
 If a subdirectory of a filesystem is exported, but the whole
 filesystem isn't then whenever a NFS request arrives, the server must
@@ -325,6 +325,9 @@ filesystem is exported with
 .I no_root_squash
 (see below), even if the file itself allows more general access.
=20
+For more information about the security implications, refer to the
+Subdirectory Exports section.
+
 As a general guide, a home directory filesystem, which is normally
 exported at the root and may see lots of file renames, should be
 exported with subtree checking disabled.  A filesystem which is mostly
@@ -332,19 +335,21 @@ readonly, and at least doesn't see many file renames =
(e.g. /usr or
 /var) and for which subdirectories may be exported, should probably be
 exported with subtree checks enabled.
=20
-The default of having subtree checks enabled, can be explicitly
+The default of having subtree checks disabled, can be explicitly
 requested with
-.IR subtree_check .
+.IR no_subtree_check .
=20
-From release 1.1.0 of nfs-utils onwards, the default will be
+Before release 1.1.0 of nfs-utils, the default was
+.IR subtree_check .
+Since release 1.1.0, the default is
 .I no_subtree_check
-as subtree_checking tends to cause more problems than it is worth.
+as subtree checking tends to cause more problems than it is worth.
 If you genuinely require subtree checking, you should explicitly put
 that option in the
 .B exports
 file.  If you put neither option,
 .B exportfs
-will warn you that the change is pending.
+will warn you that the change has occurred.
=20
 .TP
 .IR insecure_locks
@@ -578,8 +583,12 @@ however, this has drawbacks:
=20
 First, it may be possible for a malicious user to access files on the
 filesystem outside of the exported subdirectory, by guessing filehandles
-for those other files.  The only way to prevent this is by using the
-.IR no_subtree_check
+for those other files.
+In some cases a malicious user may also be able to access files on other
+filesystems that have not been exported by replacing the exported
+subdirectory with a symbolic link to any other directory.
+The only way to prevent this is by using the
+.IR subtree_check
 option, which can cause other problems.
=20
 Second, export options may not be enforced in the way that you would
--=20
2.42.0

