Return-Path: <linux-nfs+bounces-23178-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IbXAI0/DTmp8TgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23178-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 23:38:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ED872A92C
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 23:38:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netapp.com header.s=pps1 header.b=j+MGTxyM;
	dkim=pass header.d=netapp.com header.s=selector1 header.b=MOyDz5aB;
	dkim=pass header.d=netapp.com header.s=selector1 header.b=MOyDz5aB;
	dmarc=pass (policy=reject) header.from=netapp.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23178-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23178-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=3")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C76303080F09
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2026 21:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA9E3E4506;
	Wed,  8 Jul 2026 21:28:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-003fbd02.pphosted.com (mx0a-003fbd02.pphosted.com [67.231.149.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F733F54D8
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2026 21:28:04 +0000 (UTC)
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783546086; cv=fail; b=ITxtHo2ZVX61DPgD3VF0ulkhbz4sGr+MauHw/hVCPAQ00v1QvKCCHalgSILm7SAOPiGIkScMVDRHas9/gXXucFuHEGeoTLZJfayK0ORF6fBRrrfyeWAawWGWRoqQsmpCLWzjw4w6uOGu346wXuR3fTAu5mZedy6UOFPjD1xfybY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783546086; c=relaxed/simple;
	bh=DHDOvx+LTisAzu1vQVs0Qvbc+CDDx3FE5qs30/MLaxQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PxWlhH4sHoZCvJofRfG3D0MonJhpE/6Zb4LC+cE90Rl55cLbBxev4no93GSF/BCniNqNpCFzDi6Nx98qcwTC6G/gfskc9sMj2qSNYmSvxBueYWJKEbhjVv49vepIJptdBWHUsE/Tg8y79X1xq960JzGXrIcd5Kp97zTPpm2naGQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netapp.com; spf=pass smtp.mailfrom=netapp.com; dkim=pass (2048-bit key) header.d=netapp.com header.i=@netapp.com header.b=j+MGTxyM; dkim=pass (2048-bit key) header.d=netapp.com header.i=@netapp.com header.b=MOyDz5aB; dkim=pass (2048-bit key) header.d=netapp.com header.i=@netapp.com header.b=MOyDz5aB; arc=fail smtp.client-ip=67.231.149.249
Received: from pps.filterd (m0412378.ppops.net [127.0.0.1])
	by mx0a-003fbd02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668K6FmB3662216;
	Wed, 8 Jul 2026 21:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=DHDOvx+LTisAzu1vQVs0Qvbc+CD
	Dx3FE5qs30/MLaxQ=; b=j+MGTxyM+OZgjpgDuBbwwtRZpb/OOEVYWwbOA6P9dpq
	tRn/Lcau8wUOJR0BGX7ZWFcggjIvl9MLN8AHfwIPHBKhSa05j5ZoP3aYbh7dMcTa
	gNitpQdti93MkWZiFCtLp/0121cNHvJCPNtwrU/ONImWC1hHXJxXxN8oPiAd4cJn
	0wRekpAUIowkwjziHJ/AiOiL3OPtpTs+pnNm/KQWRR3b8Q4/FNdo0lBWRyccB6cN
	dBSk9jgwGq24C9KKH40Tbrvmtfx0DIh6iHCp+Br+C3iO6IdKH60fPFxCYXoy+DDi
	vegA/RUuO/n3trih5IWwcV6izRE7BanUCREonEZMPFQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
	by mx0a-003fbd02.pphosted.com (PPS) with ESMTPS id 4f93tknxbh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 21:00:08 +0000 (GMT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GKCzpO3/Ocu+KCnKorRk6fl9lJmNNSHklf2L7RSzcAkV1NAtjT50pWMOODJ1T8r9yG54L1TF/YKcKdZ0FN5F1genJLOgfz8sKHGNj6tYCYwcGkahoz1RMP1raL+F15X3v9O7o4zKJ5Da6DfQS1R6H7LWhRyD/uJR/TSaGxL+d0FIVUnh7UStZPEk2icT+YsoWDDAdrZnQ/UdkdJYGLxJZEW3gLxfXzXOhaJYhvUJkj9CrLUQmRvOdX4nWZsB8Zz3hRAMsgufYpWan7RLFMzWeBrzXTSo+OdbCcE+WM4shlAEIh18yM6FJN0w7W/3hjrsnA68ckE8lS4AOSn5qYoHKA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHDOvx+LTisAzu1vQVs0Qvbc+CDDx3FE5qs30/MLaxQ=;
 b=q5guiOAiNadS2LO5SRjkv4LvphWqD0TinrsAEOTal0szh9oqi/tHO2H6Gyj/Yp6L1dwyeM6imTYpKUe4oBJQA4F9X+u4knbxO01ujofJwNONEvsPywShiFYhepXwDg4Q5IzLq7qGkI3laU9xdm+hPcSGZKjY9ITD6Dpr3YAVdlW0L1mhvHPK4Lx/ot96LDZ5X0Z2eB8txiw1jR2V8ACVPrwQ7nMSn9UwbgdL3LHejUSJB1qOxMyYK6tHeJElvnNDuwLIDa/Sd01HesAAvUwD9y9gjCx/AO3VwC9jy3XvgpFDVEWaX0nhARTVs9bfc3ltmAQHC4nJggfx3TglDOnHLQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 147.161.205.61) smtp.rcpttodomain=kernel.org smtp.mailfrom=netapp.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=netapp.com;
 dkim=pass (signature was verified) header.d=netapp.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=netapp.com] dkim=[1,1,header.d=netapp.com]
 dmarc=[1,1,header.from=netapp.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHDOvx+LTisAzu1vQVs0Qvbc+CDDx3FE5qs30/MLaxQ=;
 b=MOyDz5aBjHdwVFsQMg+HAitov7CSHNZjFpnc4QQI0KBlsqBekSbjkNcUObOzYpGU5iZ336NZtn3UT8q7pcGU1+WctCA5FxymKq90IFKn7NmtvYz4EuEt3JMWzBvKJleqMGhZOGEuQ5KCeJZAdxDt/MJjFKcI5I+UIz623YLe9OhBYuVYFijbqLcvKnkN6nHpXrbczCi4guM+Vo3ed/WrqDn8dDZ3Wtkn0Q+i19syqiIrrtywosLb/aVSaXaTWvV/pYGtfDr+VVDVckI9IrLF7N2jfL4SPF5nrtzzWS7g5zIXDCDHVjKYsPL7hP2yKCMFFhkkNummhOxzFcCqq5eYhA==
Received: from PH7P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::31)
 by PH0PR06MB7951.namprd06.prod.outlook.com (2603:10b6:510:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Wed, 8 Jul
 2026 21:00:06 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::8f) by PH7P222CA0029.outlook.office365.com
 (2603:10b6:510:33a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 21:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 147.161.205.61)
 smtp.mailfrom=netapp.com; dkim=pass (signature was verified)
 header.d=netapp.com;dmarc=pass action=none header.from=netapp.com;
Received-SPF: Fail (protection.outlook.com: domain of netapp.com does not
 designate 147.161.205.61 as permitted sender)
 receiver=protection.outlook.com; client-ip=147.161.205.61;
 helo=sin41a4.mail.zscalertwo.net;
Received: from sin41a4.mail.zscalertwo.net (147.161.205.61) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Wed, 8 Jul 2026 21:00:04 +0000
Received: from dm5pr08cu004.outbound.protection.outlook.com ([40.93.13.97])
	by sin41a4.mail.zscalertwo.net ([147.161.205.46])
	with ESMTPS id 6A4EBA5108460000;
	Thu, 09 Jul 2026 05:00:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2VL+5VXZkhNccf2d4ghjBDyhesFxO3s7+UPoua2LPLrn7wgY86BeHzvYU8XFWkj0Tz34yvldl2je9TgpG/obTjnrNStih0WvTEAW3nrWnEd4z6/PGq88Bu6ciAFxRVdez+Hqtgm737FsjZ3mi1qN9kNbrMRONYIN6MECMcCRkCLz9qPOBD0qEpjkZEx5OeQiSf5aAXR0r92opWqyR+8aKjcsnpx3o9eK0SskxXC/wU7gQpfAVP+FEqq2N6zwZ0jFHAA9OkXlt2zZoS+4VXDC/r+tfqhwSgdCL7Fon23U689Wu4ViA5VG9O9disjevNOuDciEDwYGGiLanvMjhlH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHDOvx+LTisAzu1vQVs0Qvbc+CDDx3FE5qs30/MLaxQ=;
 b=FS3ncZ6v0w2/wzbBgCiia4kLSoWSSzxbpQeoenzio6JwYjQlsWD6J6S7fO4jxx4LpmdlqfQEW1NQvK38pZWl2Yb0YbbnMjggTi3UuzfPSnbhIc8cNKm710BxRzrc8Fq3oPBg0jgybHZ1edikbsleydgAhJ9o2XGlHnzgrLsBvih1J86KoZtCERMnVXMUTMFrWIbWuaHq6EX/qNVo2cDeN/kvZ04ZN1V7rtaJHU25iQk6O61MQ7mfsv6c1vkcSg6JGoE22lgh/CBZ/ie5ouBuTxCnvgGpyGnFIsSllyVEJaJwL9MIRXWaPzCSL8BZ76GaxZmlNAtE9YPhL8viRiAh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHDOvx+LTisAzu1vQVs0Qvbc+CDDx3FE5qs30/MLaxQ=;
 b=MOyDz5aBjHdwVFsQMg+HAitov7CSHNZjFpnc4QQI0KBlsqBekSbjkNcUObOzYpGU5iZ336NZtn3UT8q7pcGU1+WctCA5FxymKq90IFKn7NmtvYz4EuEt3JMWzBvKJleqMGhZOGEuQ5KCeJZAdxDt/MJjFKcI5I+UIz623YLe9OhBYuVYFijbqLcvKnkN6nHpXrbczCi4guM+Vo3ed/WrqDn8dDZ3Wtkn0Q+i19syqiIrrtywosLb/aVSaXaTWvV/pYGtfDr+VVDVckI9IrLF7N2jfL4SPF5nrtzzWS7g5zIXDCDHVjKYsPL7hP2yKCMFFhkkNummhOxzFcCqq5eYhA==
Received: from SA1PR06MB11353.namprd06.prod.outlook.com
 (2603:10b6:806:4a2::17) by DS0PR06MB9562.namprd06.prod.outlook.com
 (2603:10b6:8:1cd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 20:59:56 +0000
Received: from SA1PR06MB11353.namprd06.prod.outlook.com
 ([fe80::ff:880:c010:68bf]) by SA1PR06MB11353.namprd06.prod.outlook.com
 ([fe80::ff:880:c010:68bf%3]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 20:59:56 +0000
From: "Mora, Jorge" <Jorge.Mora@netapp.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Trond Myklebust
	<trondmy@kernel.org>
CC: "Williams, Keith" <Keith.Williams@netapp.com>
Subject: NFS mount option rdirplus
Thread-Topic: NFS mount option rdirplus
Thread-Index: AQHdDxsh9JJiyX9uik6pS7FOpN4H8Q==
Date: Wed, 8 Jul 2026 20:59:55 +0000
Message-ID:
 <SA1PR06MB1135309B2E478CE0323EF04BCE1FF2@SA1PR06MB11353.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-traffictypediagnostic:
	SA1PR06MB11353:EE_|DS0PR06MB9562:EE_|SN1PEPF000252A3:EE_|PH0PR06MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 9163cb86-bce1-4e57-a4cd-08dedd33e2f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 A5zkdFAsGG/5Fd61uD5maAlj/4/EJ4MM7Id8v3HUepNWOw4ceNRqrEOBzTZOpwVFdV0niEZ6hiaYzY5esmMTWrHWZg8QhbW27C6HtA5fJsvQeDOQV2M89vddZUL4tmXNg04d3Mlal3Mfipk/CRmayRjn/uh1ZnDQI8KfgHb1oQgesBFP3gGi9rAgWSVbXhFN2kZGzvKUz5jT3uSB3C0lRhTdbb2JYCE62Ovj5dFQpqynmBWzT9OtYgx++GHEOyT33Py4EOJQ5LnzpQBSVabMsYQMr1jgRQo7AY4DdqfevN/cc5W9vff60z8AetPkyYaZmzmkVMpsPK/vhXFidvr0FqsJ4XPK0wduW7ejgjP39jNpxAxsty4NC0XVmf/dwn7SZORPBwZkpKS/0vtnvuahgS/q0wZpLHbdB3RKUxsHUQI2G5DVwG8oibjErQ6CyJ5z5s4Tx93TrKUKuNzV2cSnNzGVFOwtnOYSCYoG9NO5wQNePK12FwpfIcDWGE8+jQvj9zrm+eghHbrq/kbJ5abxbQ67IjYWxWhCFX/PczFJYO+S5CbfxBMqCzREDuDgsyfM/yJkaSdESPdnvaFK/xMyHwWFE7z1Vgxr18E1vrekWwG0zjkChW311sJsrIulDznSn7myjUdcUAMVARWDPtmmoNucax7KW0FmqgVjCprBurpZwSeh0gV47LTltYrsJoaH+SEVK6bYJa1vUJ+xNgJnfDnCK5HhH0JsA85HB439U4E=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR06MB11353.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 eXL3F2VA6M/uGURsyZW1hulQU7ODxi8131T2kEFowKkvGJY8k77MZoNv+lcDutp6Kjx0R0VdjonmCZfIISr2sCKKXSZRt1kbsGJMsFUdSC5Lg04XBA6DJk0Qi9eYXShDwboL6CkndadC+YFCE+LQet68FZ8qivnkcyiQFlPHSOaNZibyJiHzf9xR2ZW1znkHIlLiQSs6gjQaevNp59/x4AK3+P46LXrevKpM0YUVZxX4eRgc72x0A8vat+qarF081DO7ygb5yOPdHRgy9tq+XQ3cnd1eXf3zdkgi41nXrp4Qerngi2yqLo44rP+9h7QrdGrkqqAO1qnFhKZl2PZQsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR06MB9562
X-Zscaler-Block: 0
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ef5e4ccb-f3f3-4d63-ce26-08dedd33dd5c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|23010399003|35042699022|376014|82310400026|1800799024|36860700016|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Huz7nXZgrCWDug+ZiazRcAT7C0qnCOFkBlAUHUEmNLtpq2MNz6rjXvGccJ524votxJvfBaY5TUftpEIkRXmvwit4ofwRwS3w2FVNelNkZ/m8Irah1P6+Wet6jiamcRzHzWSEfTt+Ki1ZsaT76FBDGlF4/735CUHsKiRxYe1Y2IDI62wEIaNaDYFnxHLHzb5Nnk3dX5qvBcq5beOHkc0JRr9PF/cIghTHFpCOnYd/45AqZkVaNnw0PhSpyZDribKFofKxWcSeQDRwgi6k7X7t4CiWEv4IfuIJwLEd2N1nbFgxttubGX/bCfJo5TEgszjxxA/XJ+b64IYKFrG1qmmDKG3CfgJsSUXEevMNH55Sjvb/fDhtUdViA8z8TFFrTkROa0Gu/PB7w48HzJiV2HQHnRRggx39KiQYbC4UqxWJcJabCw20MvCnNYTDHT0AUnnj72byKWgyQ3hNU+/F0pREFdP2A8d7R/zN6He2fOd1Dtgry2HLadAY/N0uojWuS5kcsUR759c770vFMbfPsLhpqUZjoFjXLQcHEIScVd/bNIjfVUZh923qWTvekhl+xCy/ZzLMR1OOUnVxoRAYSZDVQLWK6zZG/MVwBgbzrk8YSL53A6KJxvG5ljdVpphVJ5HipUUnP5t/l4vV/sWxUii9GWf9qNC2yL3iQUNCIHUBRfAs+24VPXwQPU8vMZBNOYgwfUB6OBIYIoDgqFGzwpc2mg==
X-Forefront-Antispam-Report:
	CIP:147.161.205.61;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:sin41a4.mail.zscalertwo.net;PTR:sin41a4.mail.zscalertwo.net;CAT:NONE;SFS:(13230040)(14060799003)(23010399003)(35042699022)(376014)(82310400026)(1800799024)(36860700016)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3srP8qPcSA6xjsuexYAdZyKSqOzpZAeQHAEmBEFB4tc0PXWEbIF0K2BEbxHuPqWpnXtZJuFyPXnxZZXpF+pNicpkx9KDoOgHHB92755y2nhurop2PYmTQnaxEnVyEmDc6+9McNL21J7cVtZQhWhVzTksfe/8NWO2inEFKIGnVT0Uy1YXq73vXpdUUATVgSk+nMlHigDZUsrcfDxW5O8XnghdlMRjnlcEiLTzYZJDdiNQ6ODVl3OSRlBeJjcNlefEheYPscfz4nDuKdlMDW+qzHEaDZPHC1PywuY7wNMFytkCX3IqVcFY45tVgYJdVVWnmbvGo3Ck+czmtRxGyB3ibPhLLKN0wKwbRhuaIJcZgKDXKyEXU65/Tz8hEaXoBUpxMz/qia7OnbI2A7kFATxRn4bqAMEAe8AJCjYjHaAuG0WwzIpA3N7MqNmxI5npTVSd
X-Exchange-RoutingPolicyChecked:
	kE/Vw/vJ3bFP2ustHfbT9aYtSSseYb7QmsKvFYSWQyKpXR+v9pXlltfR1iskj0EB4A7uKryD43xrmYusxE6eAABLMqX5niWMVXDglwR/ITUHcKhhPNlbHc4AWk9t9URiC3ux7fPaybQ9D6hlv9PfwsmQyPY9RU/+dHOeVLSVlV5IgnMEJth6rU6lM7ROEd5070QmtEV1n8CN3Jfe31neakTLVxS+0wsFn4BCaH/S3Gr0lYCKbBDa1qIDIbrfw1JioQ0EK3LS7n0GXK9S0IlmLd88Lg9gcjoq4ZdMTmbd0jFcTuqBPWNW/ANanH30rVtcPxQj06ljwwtSYoPrNxf//w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ynjcTBxGWrCjLEkFoTxA2hcyiESF86a4sBJeYTKaOjOLp641VwOaArlSdAFHRTJoTjTEUaP1PQePlTuSAVsMAi4T0Z7E2362FfUCPNA3AVvtG/hkYikN/mJnUZvHcYYUjAC3fcQlbvlytRkE62yOYDeDOWrKO+V1m9OcorTaX937EuVpp2spY7kOz9Q32O57SHMrEXTDxn2NvVTz1WtHVtBRaIVMG6wSgCb7MPbCNjVsPX86jwdMZE0AqA3MPr2IejiRvKB6sLHQUHNSdL3NXmMiHCPZj2aHu15WJYnjkjypB/9fYiVXfkkKykGMfp+WfthooAwnX2SeFvRgmEXGz4bYNEegwBT3Ehwia3LZ28BquTOiXlUqpairORhTm34XqMoWIDp5scwFvWhUAduUZfvi041TO9Z960L9VkGYnh71yweMINIp3GMYAsPbioeavKBxdGCNARs2TMhiixn74a7dnTTLdaE2JlQazbVx2YseUua+Wb61SagxGQDMmk/zvhuUj5YmXp+5vVs0NKvwuhpQhhZvM9T0VC4f9saoxOPopMLu7xrOkwngkunp+jVY9QCrsQZPgRr9afMILG82Y8S1ux4LZxv+PfuRu2LpzdYND9Dckh7Ph61Tq4vlP6Bw
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 21:00:04.5787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9163cb86-bce1-4e57-a4cd-08dedd33e2f8
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4b0911a0-929b-4715-944b-c03745165b3a;Ip=[147.161.205.61];Helo=[sin41a4.mail.zscalertwo.net]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR06MB7951
X-Proofpoint-GUID: VI1-ulP2bLZA6w5SmFdDZCQ712L4a_Sb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDIwNiBTYWx0ZWRfXyVqze1jyDs/S
 +nW9XPtU+7c4FNh3i2jhVeuBmTW7pepKGPiHa162LSO32VAbNQhKd7Kxt0LdEAmclUcyRtKTGaA
 Jw25ta+Kgv4mnh7EavHdCQ0r6vVjyts=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIwNiBTYWx0ZWRfX65XDKIIFwvke
 xqfR4NF6kbxasA2cIYHM+1HD4DnvB22MKJX/2btmwSyUZqVRuLlu4PLiI0rMdtPjU1TGPn0bAHP
 Oy+LxW6Xw/LYt6U1aEdFizCM4imaP/kF3l7ZqnmQ5L2t6bJOfj/nVFisNUROhNvdwtmyI8YVjbD
 EsdA1tCIdAuHeokMauaIRzTpbOvep+v2RHalo5kLpeIj0ZDVvXza6hbVJ4iMM/TLmMSZHeIHSu/
 XVIQGYfUtNYaDG3RHBwfnlbNDNYsFzjmhPCSN2HKsVv1RJUMVkgv/u/4znP87zqINQmF06lsYT9
 /o5rSqYDZhmh0PQAmJDzJCAb1x9678cAR61vgBEA2JLsVbqDehI1j7G/6TOre38AQQ8XrXSC7Sj
 7h83i1o1y5Ca6E4uy6PHxd6pqYPymyCbaxH2cwfOzadYD9JDLcUvdh3WftoYLn2pfZ5zZASBg3H
 57+qPBejL1pu/koPbGw==
X-Proofpoint-ORIG-GUID: VI1-ulP2bLZA6w5SmFdDZCQ712L4a_Sb
X-Authority-Analysis: v=2.4 cv=HekkiCE8 c=1 sm=1 tr=0 ts=6a4eba58 cx=c_pps
 a=qX5DP9EEIf1faxnBSU0rOg==:117 a=SJQ76AT8gcEatleHPgizPw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=GWG4Yq0kndkA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=1lWG0UuNQvn8UhQ8Wh4S:22 a=kB86kffJK16PCAXrulPp:22
 a=UXOv7JqAU9CCetynGrgA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_04,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011 phishscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080206
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[netapp.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[netapp.com:s=pps1,netapp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23178-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:trondmy@kernel.org,m:Keith.Williams@netapp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Jorge.Mora@netapp.com,linux-nfs@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,netapp.com:from_mime,netapp.com:dkim,SA1PR06MB11353.namprd06.prod.outlook.com:mid];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jorge.Mora@netapp.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[netapp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46ED872A92C

Hello Trond,=0A=
=0A=
A customer is experiencing significant performance degradation after switch=
ing from Rocky Linux 8.7 clients to a 6.12 upstream kernel. The clients wit=
h the newer kernel are seeing a dramatic increase in GETATTR/LOOKUP operati=
ons. Their workload primarily involves traversing a read-only directory tre=
e and reading or retrieving file attributes.=0A=
=0A=
This issue is related to changes made to add heuristics to READDIRPLUS. We =
have been testing on RHEL 9.7 using the mount option 'rdirplus=3Dforce' to =
reduce the number of GETATTR/LOOKUP operations. However, this option introd=
uces other issues.=0A=
=0A=
Is it possible to add a mount option to completely bypass the readdir heuri=
stics, such as 'rdirplus=3Dlegacy'? Alternatively, could a mount option be =
added to make the client less aggressive in sending READDIRPLUS requests, s=
uch as 'rdirplus=3Deager'?=0A=
=0A=
=0A=
--Jorge=0A=

