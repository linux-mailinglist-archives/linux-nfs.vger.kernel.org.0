Return-Path: <linux-nfs+bounces-7266-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E539A3BE8
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 12:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14C55B20A42
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA883201023;
	Fri, 18 Oct 2024 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QTwWqYcT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5578820102B
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248445; cv=fail; b=cf67DrmX6qK1WcCHzaT9oSQKuGorHFc79V+yMIw4tHH6fq4dFkrqnMz1uaJZBfheKlCkrha4uYBmNqUsRSyRXOubHVNxc7jP1YFuI8NMSATaXbSuDLiy/IKbZPfKmgaqaY5u5upsTvCZoFhwqAfFfmydGo18YWpUrEtyuKGsfTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248445; c=relaxed/simple;
	bh=EMmaIdFRFzAyO7Mu62bJlOUP8w9G8UaPNfTHOHlOhwA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nr2qNOv1H8kmrCqon+HUMfmdoS80jMc6IC/r4Bg0kpaWjHv5qMhe2+JK4sSW0s0+eAiYNACe5yEyk8ldQueSj26zPC0IUBmYuyd6Ol7MaRYDFKifIbDOHJUCxJ+rRsZacnv0c2q5N8i9RFhmxgywrJfz3zpXdNoCkPtlUCpPC34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QTwWqYcT; arc=fail smtp.client-ip=68.232.159.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1729248443; x=1760784443;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=EMmaIdFRFzAyO7Mu62bJlOUP8w9G8UaPNfTHOHlOhwA=;
  b=QTwWqYcTPTJo7XL+yHatwu9uNzmabhUEnlNUISDHWecLpxPgzAKFDhiC
   VwK0GgAsjNzYPF3IKIe23d9sSwD3wzwJH/I9atawjGdNfQMel2eE6xI6O
   DyiW+69FSfVwkAYjvClNelRbxqK1FBDY1Z8J2AqkJZOX0Ss3TtXJQlVu/
   Do5PpqbiIsP6dVXmz9qIFtL7A49pCE02scl6bjjIi921+DxJwQDLvcKnb
   n66aYpmpnzJIx8t7ntkw72hIjL+4hLx3Cti0FgmfnMYoi/EB4mTrFfSPo
   GMXIc3cjWbfVaUAcFwSw4bcuhGBrEZr9jXWl0qCDuVNHT0+kzFOmwTeps
   A==;
X-CSE-ConnectionGUID: 4Zd8PGnyRB2lQQUQH+wr7A==
X-CSE-MsgGUID: WJXzKf58Ske8nM7vPHFrIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="134108067"
X-IronPort-AV: E=Sophos;i="6.11,213,1725289200"; 
   d="scan'208";a="134108067"
Received: from mail-japanwestazlp17011031.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.31])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 19:47:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/QaNKHbaf5k7EeOQnHFsIgAyQ5HGPMs46tsF2jPbRh88ByBM5eqeKu+wUEDKOrSYIbprOel9U5hc4Hv/eM7jnoR9OGLetu0jnSCRF3N8YIkEn3Rpbn/AQTZbivMH/8CiDhOwsBc6YUL64+BPduWDC9jnAKQda1lJSmcTB0GB3oaVl0mNBClbAOtMBNgPVDaT4ejg069qZSflNly3h15hId3nnvn+qpbcPt7qXOw0p2oBITbJMJIoA/vzcmeA0DZeddlNSidelecHuqpSoJbDsR5+hE5vInum6Mzgz6EayS9wYT0xn1faY5tBAEFD3AFvflbT93JNpe7/b7uAIRXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvNvo+SzHRTJcJ/n1npKX1nlxqDa5fPDralJqDjVC2A=;
 b=q7f2a+pFA2tOJxUB5WaCl02OsqwQdhXG/Mush9ixRFXhDk7XcOTxudDrxYibQfL80xlHC1al46L+FyrUx626jBJKhZNgzzGJ4X2AIB5zfHvRvrML/q6vfIjyCWNv9G5ECPx+XWUzsUc7Z9wBMcsS7REXil6+g1iGzXwTxC5LOZMRiC+Jfe48e27jduV8nOANEv4Onde8MrmHwOEvZ01MLpIfjMECpCYzdR4PbxS2khfb1GZwomOXwnlvVBAxGuitySktM2IcCD+CrmzKBq8rF+Bf7DOsDkVhAlEeZbR3K/pXz5FHOdeED9NNo6iXl7KFOUS6WyTwcMpeZ8+DgxGaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by TYCPR01MB9417.jpnprd01.prod.outlook.com (2603:1096:400:196::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 10:47:11 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::df28:316e:ef65:39a9]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::df28:316e:ef65:39a9%7]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 10:47:11 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'steved@redhat.com'" <steved@redhat.com>
CC: "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfsdcld: prevent from accessing /var/lib/nfs/nfsdcld in
 read-only file system during boot
Thread-Topic: [PATCH] nfsdcld: prevent from accessing /var/lib/nfs/nfsdcld in
 read-only file system during boot
Thread-Index: AdshSv3QJTApk0+OQxOKVhDvmjUSKA==
Date: Fri, 18 Oct 2024 10:47:11 +0000
Message-ID:
 <OSZPR01MB7772A2EBF4EE02460E546CDB88402@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=ca6ba484-3d98-445d-94ca-feeabab53b7e;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-10-18T10:34:07Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|TYCPR01MB9417:EE_
x-ms-office365-filtering-correlation-id: 9acecbbf-cdb8-40af-2127-08dcef623872
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?S3FTUmFVRHR0Y21YZkpOei9RMS9hcXJvMmhrRmVvYkY3Z2wxeCtJSVE1?=
 =?iso-2022-jp?B?S2NqUUVIam5aeVRjYmtleXkvelI2YXV0ZCtDeFdTVEJXM1I0V290SFlC?=
 =?iso-2022-jp?B?MWZmNEdVNjRDWXQxKzlyWitUZGFRdGUrWUdSNWNSd1c0Z3JoYWplb3RX?=
 =?iso-2022-jp?B?WUlCUVh0TDVwUy9malpvbXQyVmN1WlBmelJrdDhobnZqQkNIb1NjUHVy?=
 =?iso-2022-jp?B?bVdOMTFhMmVqaWNXMG9PQzRXQzFSUlhBVU40TU1sUnNTQU9hbUxzYmRM?=
 =?iso-2022-jp?B?T29YWm1TTjZ4UjRqSHZZd1QzbEo5QjZPdFRpZkJPVTZJSGJ6UGJBSWRm?=
 =?iso-2022-jp?B?cVVjUDhiTGpjQjNVWlBQeVhsLzJKZ2JGcDJpUS8zV2szc1MxUUdvZjhX?=
 =?iso-2022-jp?B?ZFNUcWpLU2tFN1k1VmRyUHN2WmFManFqcjBRUHFSanhVUFpVSjJZUlp4?=
 =?iso-2022-jp?B?ZXpWWmtERmZuelFzRTlyU0RYRTIyek81Vm0rSmRReGxXYitmNmp0cS9q?=
 =?iso-2022-jp?B?SWVqcGpZNzIrYVNseEJKbzFkWVp0OHArenVZTDRidDUrT1hwdW4vS29a?=
 =?iso-2022-jp?B?RVZQd255R2NuOTRmUW94SERRdi9qYzVYNjhLaDA0dFRqZmFtMTBUSTZo?=
 =?iso-2022-jp?B?QWROM05ocGVlNWc1MTN2SHJrcjhkMEpjVEtMUmRVWHJhY3hYZlpzZGJ3?=
 =?iso-2022-jp?B?WVBqUURvMVppdHZGVGJiVzZZNVZKM3lJaXZUSE1rWFFPRFVJeFEwMTJp?=
 =?iso-2022-jp?B?QmVCdkpnaGxMMmFFeWs4WEF4K0cvVzk3cmNNS2x3TWREdnQ3MUo1U09q?=
 =?iso-2022-jp?B?SmZISENwNkQ4NFFlc3J2VXdiVEdmMW9DL0dLMmp1YXg0UUsxbVdtM3Nr?=
 =?iso-2022-jp?B?ZElhYVFndkN4V1FzV0xwakkxdm1vSDQ3UkhvRDJBdWpJTXF2REVsS013?=
 =?iso-2022-jp?B?ZGxHMFlYaUFhOGNzSi9qNjlNbGVzaHd5UGphcU9mYUxpMXVIa3FEOEZS?=
 =?iso-2022-jp?B?bFFBRUVQUWpiOE5ISmNEZXhpZkRuZk1Xb0pQdG1XSUNzN2dBbzNmQkxl?=
 =?iso-2022-jp?B?dS9NU0I0aFd0a0tnN1Y0dzVkYTB6d1J3Wkc2QkIzelVzSXplK3hiWFZp?=
 =?iso-2022-jp?B?NUtVZ2xWRW50b3hhOTRlamdFalFmbU9Pam52dzhQclNNTzVkK3J1MzlY?=
 =?iso-2022-jp?B?c3VETnpMSVFRWkZzOWExUWJDM3NaRXJxUDBpV2VVRVVEUXA1ODZ6R1FM?=
 =?iso-2022-jp?B?QmI4aDlPSEJhMUJXZE5YcklrOEFZaGgxSWtFYXM0T3Z4aFVhazdDSlNX?=
 =?iso-2022-jp?B?ZGNOYkwvNjBlZWIvVjJDZE1KdHZkODE5RjdudnZsaTVsdVZuTVFrajFN?=
 =?iso-2022-jp?B?OUxZWTE1ZGxnTWIyeHVsKzZXTmtOTUhaT2xRNFBZR0cyQW5FbGhYY25u?=
 =?iso-2022-jp?B?NTdwR0llWG9RTHVhei82bFVSdlRQL0hlQXBJSDV2VHFFYTgyaFVFVWIy?=
 =?iso-2022-jp?B?cFVFeUxzcGMrQUNIS1JTYldqK1JZZmpRVHU0U2Z2WjFnaituRk5sNkx1?=
 =?iso-2022-jp?B?SmEvOHZVQlRucFZKWElHN3FaT0xGdHJlaW5qSi9zdU40YUNLbEJuaHVy?=
 =?iso-2022-jp?B?ekdScnVobTE0cFFzSyt3emErdElOQm1ya215MUtPaGJJb0RPOThYclE0?=
 =?iso-2022-jp?B?K3FaYVlIdVlIVG1qMDRhYWZWNC9EM3NNaE0wWUZLbS9DMjRGRFBsSWlV?=
 =?iso-2022-jp?B?Q05PMVZFNVF5eXlkMXRsWUUzR285eGlJN3pWSG5KNEVISHF3dldHVEpn?=
 =?iso-2022-jp?B?OHdYRGZwdEV5cVM3dWpGd1pRbHVpV1RpZWc1dlp3UElaczJpc2VzODhu?=
 =?iso-2022-jp?B?S2JoSG1ZZkg1UU1BODRYRW4rMTVpeVdLK29ZYWw2MnpNcWw4WjQwOFRR?=
 =?iso-2022-jp?B?bFVQMEx4cTBPWU5BQ216Y1k5RkdodTZQT1RQWFZndFJSVzNIczdYY3Ji?=
 =?iso-2022-jp?B?YURnYU1CS2kwVVNpVUVNdkR5elc5ZldBeWhWTmdMWHllR3A5c1hieVZw?=
 =?iso-2022-jp?B?b0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?S0c3WU1lc3MvemNwcDJ5UktsMHJoakJWbjFvcnVGVDJDUHEyeisyYVQ5?=
 =?iso-2022-jp?B?UmlTbHozbjVmTkV2bUN4U3BGYzZ0SmxoOTJXaWluYlgzcWY5dlMwUTVj?=
 =?iso-2022-jp?B?MWhYQlBLNDJlZmZndjhYY2tFVzNWTXpNc1N0dXdpMFRuZ01aTEFPd1Nt?=
 =?iso-2022-jp?B?R3BTUVV1aVM2bEFvQi9NNDNVRmM0cEpEaUo1aGYzbEZrcGk5UkJpcThR?=
 =?iso-2022-jp?B?MVFpazJzWmxkT1EvRFdFandZL01wUFNTcktLVWRPRFFkM25XVXo3Q2tU?=
 =?iso-2022-jp?B?TUdaL0g3Q0s0Mk5GenlJWW9tNDBZNW4zclZpc2JTRkJkWi9XSTZyRDhL?=
 =?iso-2022-jp?B?d1Y2OXR5U3djVnM1dGU3SEtJQUo4RTVzdWU1WHdQWDRJZGFzeGtkc2RU?=
 =?iso-2022-jp?B?V01kTGZqa0tPOS9JVVhNVE5lQ0ZsQXVlOWJrWnZ5N1lXcmlEZkc1MXha?=
 =?iso-2022-jp?B?K0JrV094SkNHSEw2MzFPVVZINVNqeHZWbHpKb0lJQnJNZmhzUFVIMit1?=
 =?iso-2022-jp?B?cmtGWVNBbEY3LzMrcm5sNjZaeWdsZ2wvU1AyLzhMa0REajdodHdyZnoy?=
 =?iso-2022-jp?B?RXVoZ3FVOVIrTzk1NmpkRzdZQ1hWcXRKbW9UUjdpNlpQNkFiaS9nOTQy?=
 =?iso-2022-jp?B?OVo0d2FRR1JKMExreUFHalpkV0llV1dkczBTMVZCMUhYVzlUbkZMRTdJ?=
 =?iso-2022-jp?B?OFZDVTBPaWZnQS84azZDVWxnY2ZEcHM5MVRQNm1xS1hsTUhTK0V5N3BE?=
 =?iso-2022-jp?B?SDUrdFFFR1piSmZKNDA3aTJsTDMyOHlwcWd1V1k5bEdhaE8rQTNUL1FN?=
 =?iso-2022-jp?B?VkFuaUtMMFI2YXZ3NDAvSUJwSFYzSXhmZXkvRVBsSWxaTU1GamxDNE56?=
 =?iso-2022-jp?B?ZUNaVllNRDh0SVpmS2I3UTlXSXlpaWJmanNhTGdGNHVGSE0xTk9xOUJw?=
 =?iso-2022-jp?B?Qi9HMzJQNGJBaHpMMzd5d3d0blhYQmJIek1lTlBuOHlsMHRFbUpOUlBS?=
 =?iso-2022-jp?B?a3VpK0hsMjVZS1ExNlZ0cXVoNlFWNWV1NTRBcVRSejZ5Qm5NU0srVHBU?=
 =?iso-2022-jp?B?NjJCWW1udFhXSkc4VHBJck16bXNEYy8zVm9NNUMzbk9PWUhZL1JUUWpW?=
 =?iso-2022-jp?B?YjM0dEx3S1phYnBMMnBBcFB3aHoyNzBDbXUybUMxb3BzSFNqamZ2bU1v?=
 =?iso-2022-jp?B?a3p2c1I3WWRwdUQzdmQ1a1hqdmlVWjkzTTdHT1k2VThRdXFzVi9iUFhY?=
 =?iso-2022-jp?B?cWNoYlRYMEhHSkNvVnQ2enQ3ZzZDZDU4V3dQU2FpcTJGVldlRGlMSVpG?=
 =?iso-2022-jp?B?Ni9MK2NnZmhCamE2cnMxSzFjNDJBeDRQNGE4bnRGazFQbzlidmRlbXFX?=
 =?iso-2022-jp?B?UkEzS0hZc3l6RzVyL1g2cnNOMXZIV2g2aTgvWTlINzBjQks3RktHVklR?=
 =?iso-2022-jp?B?Z0JRQ09JejBqZWRCenBsWSs1eDQ1OUtoRURxbVo1K0VHblBqWEg4U2tF?=
 =?iso-2022-jp?B?Z2Eyb0JLUlF2WUNyZHVDZldZYUpKYUUwNWxHMnFkRmh3R1ZnaXdqa1Jj?=
 =?iso-2022-jp?B?TTlxYjg5bC9FYTcvNzlpMlVpa3UxMFNpZ01QczQrMFExdlQzQ0hLYTVo?=
 =?iso-2022-jp?B?RSt4VlFROUxLdHp1TWQzK2FKUXdPUWVLMWdGcXR2VEx3VnpRN2JrOXhs?=
 =?iso-2022-jp?B?R2dwTjBNVjNTNm9nOFZaQXNEb0krcENnV0tpYUI0TGdVRmdRQ2xvSGtU?=
 =?iso-2022-jp?B?c0hMSDR3aHFnVCt0TVBaZnpaMEFkSGxkMTJNcVNwYld5bDIrU2VDV1Er?=
 =?iso-2022-jp?B?T2tJSm43amRYVzhRdU1mdFJWQVMrcG9ZQ1c0OEROTnhxckxETzc2VTAv?=
 =?iso-2022-jp?B?MlVCVlZ4UkQ0a213VlR5NnA2eWp4WEM5blMzZEFvQ2Fia1g5QjI3cmZx?=
 =?iso-2022-jp?B?NzJGQXIzT01CWXMyaE5GTnhaYjVmSjZxTjkySUFFbWlIV1M5elZibERE?=
 =?iso-2022-jp?B?dnRqbHZvZTJKODhlZVNvRk0yeE9EVzBGQTRJRlFCTkJOOFA5UFlrTldo?=
 =?iso-2022-jp?B?SStrdG9NZEhLcGJKMGtOU09HRnhYcVVzSU5vTTBobUVIcVBrQUVZSzRx?=
 =?iso-2022-jp?B?bDRZMUFGSEJOV1d5OTE4dUcrTlBBdkRld1UzdURtNTdSYmhlZ041OWUv?=
 =?iso-2022-jp?B?MVZjMllHam42OEQ2Rjd3bDRCVnJ3cldhU1R4elhwbG02WHg1TU8xT2gw?=
 =?iso-2022-jp?B?SVF0VEJkSGN3aUFKMitpTzZkVFFZanp6amJjV2pDWTR3WlNSdW9ZOEJn?=
 =?iso-2022-jp?B?akxKRzAyOHBaYk8zb284LzZNSXBuZE5BS0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eBLqagKu0TfrBrfjKV66XZZzSAxgDjt+XW16vSR5zd0BGoG8HoCWxyu1oRkN/yYuAmYruOsWjbsN+PRH3qsLNk+TxTqk0s+15CSot6N50Y1J/qIyaVIISln8skUW0x9ni6L6ik+ToyWaGJ+JHcZn6yn/POcTsw4i2VaNKpLwyW2JXaZsnqwD66cg26Ne3fL1Mf9XTBUWcEX14yhMI1iVaXp67HvnKbFZH8r3OYXUQDRVFjR5AGhbo0QVmRE/9+uGURqbKKfunWRLR8u8MxN0eifhBkuB8IUbDY+na6vuoH9pCQXfxC3oq7X+ZeH8eRP5TQuCYSv/Wm4lh/BtA/gB/Vzpl0ZhYkU9yJ2LcqMBzNp1MbZB0heHZ1pqIbHHhyxLbmxqD0+Ts+t6sA7+u1q5a+4rMoLY93kdQO8TxXSDlq7XwMzfXzBvK6VUwLIkNok9ASEV4yVtf2GP+3NDk5JmR1vPk5w2esro0xElNHzAQWy8F6oj9R9VxJUr4RPkpytIMwXxIQGYxRx/iKo3Ca/mpwMpqNocAd8sTizvMI9lOLAtYukOBe1ifSWPpjxZFFAqc0aEYqLbEpPwk9/GYb24ghQvCndc2bvjh+AZKVsUbzJvsd5ljZwuUNQhVtKsW+6M
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7772.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acecbbf-cdb8-40af-2127-08dcef623872
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 10:47:11.2114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxE2TA+ckmaZArz0S4/lQMfPUvcxLegBOi8Jd4OCncYMOP+f8YEvjGdOfmbMXTsSK4ipD4vE+nya35xhPJ71K9R4NoyjKtoRoZAQqhs6xPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9417

I saw a VMWare guest that hit a rare condition during boot;
nfsdcld started too early to check access on /var/lib/nfs/nfsdcld which wer=
e
still in read-only file system as follows:

  nfsdcld[...]: Unexpected error when checking access on /var/lib/nfs/nfsdc=
ld: Read-only file system
  systemd[1]: nfsdcld.service: Main process exited, code=3Dexited, status=
=3D226/NAMESPACE
  systemd[1]: nfsdcld.service: Failed with result 'exit-code'.

nfsdcld.service needs to wait the root file system to be remounted at least=
.

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 systemd/nfsdcld.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/systemd/nfsdcld.service b/systemd/nfsdcld.service
index 3ced565..188123d 100644
--- a/systemd/nfsdcld.service
+++ b/systemd/nfsdcld.service
@@ -4,7 +4,7 @@ Documentation=3Dman:nfsdcld(8)
 DefaultDependencies=3Dno
 Conflicts=3Dumount.target
 Requires=3Drpc_pipefs.target proc-fs-nfsd.mount
-After=3Drpc_pipefs.target proc-fs-nfsd.mount
+After=3Drpc_pipefs.target proc-fs-nfsd.mount systemd-remount-fs.service
=20
 [Service]
 Type=3Dforking

