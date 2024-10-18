Return-Path: <linux-nfs+bounces-7268-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68929A3D36
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 13:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5B91F2136F
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 11:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A9E18628F;
	Fri, 18 Oct 2024 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="sWXm4/CI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E834715CD74
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729250552; cv=fail; b=qrcLmAv+D+1up5dN+oPRRjbS2TJ2iFiwbL9RkO5bPWR69pERXL9Ba0r96gzURAdqPUoVPgV18c8mP/39wf/wXL2MKFp9x9pS8+HduUvUrnqhn2hKGUTw1bRSrwCZWPIbqqJ7/Wqmb7AZhIPAN3njcqQ2x5+0FMDT/aS/PZEcheQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729250552; c=relaxed/simple;
	bh=kcp+rqTAJnlVnIKewd+st0W43cl2U51wmeVLSkSzFZc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rxpJB3elj2TFXAoHzepr9+wVgrZK6ppxDswuIZpLkC9bZcODLfDTKVbXm0W9+ZxOvkLaXZqWZap/cMpGRRJ5bF/5dhMC/MLaUMlysaGyzJNnjd9nXZw3hxHXWFCfx/xMr+iVoQ1wNdn15vnlk1BL28wCwIcrseFCCYSbQd9AjA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=sWXm4/CI; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1729250550; x=1760786550;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=kcp+rqTAJnlVnIKewd+st0W43cl2U51wmeVLSkSzFZc=;
  b=sWXm4/CITnbW6pfBiHUjDI18+NvZeo2kGHtShJgO6WDVgXDJN0yb4bZi
   NS4fgFPHT4QYzKgLbhiyfiODqI7rtebvAdYc6QpW1CAOpOxX4T0ma2Iou
   0eyBbGI3zYLs/cw6eA5oyiO3jSkuulIiHE2YQe9Y+6TjRHnSfk77Wd01k
   ZW1e/OZYqrtNmbZl3pXYYC55uDceNyHF+eR7Nf2XLQZYfe1CTJGtDGO1x
   k1cxT34faYRhhWiTFQQRCC6VdlsW+irCRir6v10T5rd5uz+MppIpIl4BQ
   oKbh1XFl+1X7Lti2RH5ilfkLGddgQhf+LKPbtwzvaMaS5k0AOC2710KoP
   g==;
X-CSE-ConnectionGUID: KP2gbyQaShiH7Lj9xurPjQ==
X-CSE-MsgGUID: Ra8/6zWTTHSAOvBQeprMnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="134015545"
X-IronPort-AV: E=Sophos;i="6.11,213,1725289200"; 
   d="scan'208";a="134015545"
Received: from mail-japanwestazlp17010002.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 20:21:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlVBPbx74TLsHNosUgOg07sOuHBB+16X6KFvVAjwMlve97Q6oIIuuOUSHam2bTU0XHB8UUsYMGsLxw/ILjEwtKitiY5Pj1Zjhk1DQi9xfUn5BBfGvau/d2l+SDaqJHp9ZDrCXztMM8xI2/AHo4sWxTXZ9LE/oOEwpeKgUYTFuLVpF8U6mdf1Itjp/EOJIUoq9iDeu/ZfSaOlRCrL2c1WJqggyY7tQ0QXK+OMdRnuayommeCZkC/uodXvuRATqdRtsim3BzbizcbW8TS0T/UU/e9Nz9+97pgPlX3KMWls/y1Kse5DhV4PPnR5wK42U3nZvT2By1x49aHKzvtMgrpXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JilQ5fqkb3y849ckIvDb01cYGOgKP4KjHI/5kaBcbUY=;
 b=gxZfZ6JFOGyMgloMcrZpIYZ7fCVkgo2r7S4yoCMfo4f2DbLjBBA+9vxn+3lpRnz8c+Sn2leulu3nmnuEHHDOLj/OZ7IRK4Hw0Fhoxi4vENXYryHdu9HvAlF6Y7f6/NDwcS7bweNm6H0KVWRrjtUB44LRdN3shrviSHSeANiOQ1CHGwPbfDinCUi7E//QAeSi/CtznHard1meOF2ELNWQ2nkUIDlisUhwKdTMjAI+/TSK53vUdKPaWfR26HJK7aD9Bs0qLevCyvHD9+qEbavKQPKZbLiGus2ZOXs6eoBw7TlaPF5PL2Esa+MOV9c0eB3IwpTfB2ex93Zper/SkUQ0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by OS3PR01MB6376.jpnprd01.prod.outlook.com (2603:1096:604:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 11:21:15 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::df28:316e:ef65:39a9]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::df28:316e:ef65:39a9%7]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 11:21:15 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'steved@redhat.com'" <steved@redhat.com>
CC: "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
	"'sorenson@redhat.com'" <sorenson@redhat.com>
Subject: [PATCH] Retry NFSv3 mount after NFSv4 failure in auto negotiation
Thread-Topic: [PATCH] Retry NFSv3 mount after NFSv4 failure in auto
 negotiation
Thread-Index: AdshT3pHAdh8JNDrTLS/dtZP1FOkEw==
Date: Fri, 18 Oct 2024 11:21:15 +0000
Message-ID:
 <OSZPR01MB777260693E426F03068BC6E688402@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=87ed64dd-f8fa-4579-bbb8-baf1a3c21b8e;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-10-18T10:47:20Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|OS3PR01MB6376:EE_
x-ms-office365-filtering-correlation-id: 7cbf51bb-a0e9-4dfe-5802-08dcef66fab0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?WnRZSkpIMXZXTlFUcldhQnJUZjVvWTRGSTUvSHZ0Y0RaWmJhK01MRldR?=
 =?iso-2022-jp?B?MDJUeFJ6YVphRnc5ZGNNNWN6M1J6b2w0QzU0RUcxQUpKUC9nS3FVbE4w?=
 =?iso-2022-jp?B?QUtxZmhCZTVhVEFqbzJCWEVoYXduRkN6RGNVRW5wWUcxT0hkRE1Hdk5x?=
 =?iso-2022-jp?B?K2plVC9jb1JJdU13OTU3VGtDRWs5SWZGMXBlUWRSTGp1OTl3T2FPdmpv?=
 =?iso-2022-jp?B?TEs3ZXJWUWo4a0h4MTd6ZDMwRURuL0V2WnJDNWE5b3pLRTAxdGZnRTl2?=
 =?iso-2022-jp?B?QzZQa3pJRmRnU29UOG0xVldCN1l5clpwZlovNVd5SEc2RDZjalpWVjNS?=
 =?iso-2022-jp?B?T1FlbWNIZDBqRThINVkyc2xjUE00RzUrQ1F5dk1ZSnZIejVWVitYNnYw?=
 =?iso-2022-jp?B?S0trcjZEWmNsN0NCQmY1YXhnYUpXZGJ4YnhJbW1mU3Q1SGJkQ0I0VkFP?=
 =?iso-2022-jp?B?THlCcFJTanpJVFpFdHFVcWt0UnNtV0thYzN3aWRBR1ZFc1RBRUdxMHVq?=
 =?iso-2022-jp?B?RGQ5OXM0Yno5eHFVV0hiSFU4Y0p3Y1Nab1g0N1JUQ0xBQk5hWXRJa1N5?=
 =?iso-2022-jp?B?dGNJZC9meVVBVzFTNkZnT3lSK2x1L1VJaWRrZWlBdWNwaFlWbktORmM0?=
 =?iso-2022-jp?B?NWpmR0k5eSsydm8rNzJLQUtONUpBbmRCQjR4MGFDaHpJOHNlY2dyL05p?=
 =?iso-2022-jp?B?MHpTWGpKRW9PRGZ0cnpIcGNUOStNSi9aR1QxYkI4WENYbWlKUkU2bUtT?=
 =?iso-2022-jp?B?K3hYUjhyRUlFRlhHMzJWN3pIV3lvaTE3dzA5dTVia01mNVJ0R3FsSWxz?=
 =?iso-2022-jp?B?K21IVXZ6NnZIR0Fldkx4SWNqWjY3bEErUm00YVp5cmp3eWFyM3JmTksw?=
 =?iso-2022-jp?B?ZjJjeGlMMmtWOThzalJRd0dxUWJqN01LdHNzbVo3d3hFVEVDTWt0bmhJ?=
 =?iso-2022-jp?B?YzkxazVMcjQxWGlXeDJuV2JKdnZ3dllSSmgwMlNuWkg3YlpTR2FWRGU3?=
 =?iso-2022-jp?B?TlU0ei9yTGJtaTE5bUQzaGVlYVRKdkkySTJsV0I2akZ1T2VGZGZacjJD?=
 =?iso-2022-jp?B?ejhxYXN4UFNKa3pGdm5KQVRXcU5lSFhrdFpnZUE4WUg5aWkwdzNUVWgv?=
 =?iso-2022-jp?B?b3hiQmM3bXFsemwwcGpOYlhObkw1UTJORDFPOEM0T3RNU1N3M2oxQTd0?=
 =?iso-2022-jp?B?YktiMHU5OWZQa1UydDJrNzdTNDBZVXluTWJ3U3Znck5MMlJkMkJ5cmti?=
 =?iso-2022-jp?B?RjluZVR2T2VkL2tHKytjMlJ6NHZMWkw1OGRlamxRN3M1QlRVTWxheDJK?=
 =?iso-2022-jp?B?VmZYbVBvQnFCS2ZLbU5KM2wzUENBWHdwYW94R0VFcjllOGcvZ1BIZ3NR?=
 =?iso-2022-jp?B?U2VrVEtBNWkrZ2Y2d2J3NVVnS1FWYUxWUkk3bnpMZXJCOU5PODgyRlFj?=
 =?iso-2022-jp?B?WXl4MEIzZkpRNTl4alNQaU1PZDhmbXE0dUZURTdWVVprVUhuampFbEJi?=
 =?iso-2022-jp?B?WFJPUUphRldxeTRadEJoTzRqaFFHb0p5ckEyL29UL0hIRGhTNTFzcmo1?=
 =?iso-2022-jp?B?NTdWcGxES0VTS3lqakFYS3R6WVRDck4xM096YWEvTkpVOHZjaklqWktp?=
 =?iso-2022-jp?B?RlczWk42QUdoQTNXdVF2bnkvWEVkRnRLYm0vOEZYZVNtblE0cGNQLzBE?=
 =?iso-2022-jp?B?YTNHQ0lSQXJFYkwrbTZlc0ROcDNQMDdpa0ZRNjdZais1dUFYL1BxMUJK?=
 =?iso-2022-jp?B?N2NiczFqb0lZK0dvOHhueE5nbGk2ZXBzaWhqRzlrZnU4aHFGUWVkU0Nn?=
 =?iso-2022-jp?B?Vmh1cTI0RlZXTEh3ODE3OGdNM2twOW9vUGpuZlRYbWYrTkhKSFBpb3FV?=
 =?iso-2022-jp?B?QnNxZmFDbnl1aWlkV20vVUYzaTdPSHhGUFJUeHNNWEFjcjBUQmFpL3VB?=
 =?iso-2022-jp?B?eTlZUVcvRS85MVdwV1V3TEpza01qeWNrbUlPYkMwNmFRYTdNSHRFZmZi?=
 =?iso-2022-jp?B?b2ExU3BHUHhic25mMzdPZHIxeTN3UVZobkdFSVdJRHI0ck9oMmdjTFVQ?=
 =?iso-2022-jp?B?amc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?bDBvWldGK0Nicko0aTM2ZFArVHZ5QlEzamJ0dkRCZ0U3a0gxVFIzNVBq?=
 =?iso-2022-jp?B?ekpvRVBEbVNNZGViajRMZkovR0lMK2h6UFFDVjVmSndmdHlVbkF2T2ZE?=
 =?iso-2022-jp?B?MHhTSHNYQ2hXblVuSFV1SFVIQ291bytLYUtNc0RpYm9mU3grY3pPUm9H?=
 =?iso-2022-jp?B?QVFFUnBvYkcrSlJNZHl0SzBpZHZsM2x0TDM5cjVNK25kTmw0RWh6Y1Zh?=
 =?iso-2022-jp?B?eS8rTjBla1hLdzQxbUpINE13WVJNbEJla2MzZXBURnhxY0ZqQzd2YW9M?=
 =?iso-2022-jp?B?dHZqT3hoUDFYNFU5VXEwTWpwVjh4ZlJMbVJHQlpXbHc5eW4yOUswaE8y?=
 =?iso-2022-jp?B?dFpYVGxRbzBsaVN1eDBKRDhYTFVTNnFOMWlBeWRKMUxWOHFjZlJ0RmNB?=
 =?iso-2022-jp?B?ajAzSld6VlZLWDRxMFhDRUJvUTZuRzBacm56SnV5QW45amxqTnRuSHQ1?=
 =?iso-2022-jp?B?ZW54VzA2NWlReGdXa1NIQnJVSGFibVF1R24vYmJ4UUQ5ZFZ5M3p6U3U5?=
 =?iso-2022-jp?B?azZNc3d6ZXQ3bnJlVmw0Z3RhOEQ0Y01LalVDa0lqTElhNjduVDA5eGpG?=
 =?iso-2022-jp?B?WWp4bE0vVTgrZGk0YVNoaGtjNThteEpMM3FueDZ1MGp2eFIxYnY4ZTly?=
 =?iso-2022-jp?B?UmtLMTAvNUoyVDg3Q2NBajRpWVN5eHdNbytXMUNXc0NxeXRsMDB3b0Vl?=
 =?iso-2022-jp?B?c3lBVER3WlE4SzR4UVBsRnRSNVBhZnIvMDd4SnhJSEM4aXp0dUNtampJ?=
 =?iso-2022-jp?B?dEVCcXZnVUlJYUpITCszYVo1dHRkeUNZOEdTTk52UWpzVmc3RlJVRFk2?=
 =?iso-2022-jp?B?SDZ6RWlPUUNudm0zQVJHNm9qenFsdlZMTTRvZmFFbUVNZm1tTnh1SUJY?=
 =?iso-2022-jp?B?ZVAyd2RFSEQvZWQwdThOWmgzRUhEdGFjVy84VUZxTUQ0MWYvNExwWG8w?=
 =?iso-2022-jp?B?bmFzWi9WMzdNS2g3TUFsMU1FYmNKVnh1TXdTd3NVUjhIeUJZMk5SaWln?=
 =?iso-2022-jp?B?VHZldUJUY2oreWM1MWQvdVRwMXQ2OFNCNDRUeVdoNmlEeTZPWGNJNG4r?=
 =?iso-2022-jp?B?TmVZOXFzTG5mTUNyK3ZMSXpXWS85N1hsaGF6OHJXMGNwUmZ3OVI4enlO?=
 =?iso-2022-jp?B?eEt6NTRuVldVT3YvM1N1UjRvYnpFTmQxdDl1WUdSUmEyd0NTT0Z0RHc2?=
 =?iso-2022-jp?B?SDlQWXJoMk4xR3krSXZNb3JHMzU0aStMTnM3VTU5bkxwMThneWtyZ0sw?=
 =?iso-2022-jp?B?UkRUNzVmS1MxdXpjV0ZTdFVsazhJSWlZcVIwTFJxK2J2ZzFnSHAyN1Nv?=
 =?iso-2022-jp?B?a1M0SVpCR0JVbkliSDllbmJSREFTc3BjNDlGdDB4SzlmZG5qZkhlQkJX?=
 =?iso-2022-jp?B?blg4OThITC9xSkx1ekdNSnBnaXhLRjZzcmg3aHIwU0ZhVDMwOU5lSmRJ?=
 =?iso-2022-jp?B?anNvQUVMR2l3WTY3Rm1rUW02RlZ6RFRCZzBCK1QyRHJzQnB1cUVCK2Za?=
 =?iso-2022-jp?B?Q0NLN2k3Yjh0WWYxb0xreVVRamdjN1hIdnY4aWhuK0Z3Q0Z2SDc3YWs2?=
 =?iso-2022-jp?B?VmJhRnNMeGNhUzY0eEROS2VhblRkTFJMTmZuaWlxS2x1eXUrbmVaSGlT?=
 =?iso-2022-jp?B?ZHdsbkxjWXRaTGJ3dDlDVFd2bUQxMjZFaHMxWTdFYzNUQVRYUG5ibFZN?=
 =?iso-2022-jp?B?Tkw5L1dPZG1ZRTN6ZllpS1FvYjh2NytwZFE1ZEFEUXJmTFhEUC9jQ3pi?=
 =?iso-2022-jp?B?UUVlaGZLOG41eVpBTVFCYXcyR2NBeVVVdmlFbmxFa1FERjhIS2VISjlk?=
 =?iso-2022-jp?B?T1UvWTNLRTNxWGRlM253VmNUbi9yNTNFai9oa1A1TXo5VkpRc3lRRlBh?=
 =?iso-2022-jp?B?d1dBbXlWWXhVNjkvUC9OZVd2WGptWjUzd0swc3hNUXl4SmJUL2UyaVlz?=
 =?iso-2022-jp?B?SjljUWYvVTlQeXp0cFEvZE83MmhtV2t0aG1QZ1FHV2Zkbm12QXQzUUdz?=
 =?iso-2022-jp?B?eVFhYUx0bUkvSXdvZzhYNkY4WldEUmFlWUJEcDRZN3RjSDlNMzJCS0Jr?=
 =?iso-2022-jp?B?Zzg4M3dwN08zd0FJNTZKQXFuNytlN05zakFoT2pKV3JqeE5kSjU1dDVL?=
 =?iso-2022-jp?B?d21KcHREVHAzcms3WFZLM0NQakVmVHhXRmtuWW9aSWY1bVFUdWlFOE1u?=
 =?iso-2022-jp?B?bkRjNGNsQUpad1dlVEZxRVBBb1VabmFDMjFvS1ZrRGM3a0dEYTNUWjRZ?=
 =?iso-2022-jp?B?VmRuSzB2NHZBV1VqeUtHbUFUem0rUmw1cDlab3NmcmUweEQxeEpGWHJX?=
 =?iso-2022-jp?B?NkxHTTN0eGVtdERRMmZWSDdNdjl0TU1zUEE9PQ==?=
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
	DcgpMQF82+0b74a11me6lRsZtaewo/rvqzEIRLCaZjRDf807ykXSeVsAD4t8dx+GeMh5h0afi3C1deNRuC9k8cFcz2TwFiyVKABV/25shOZERn0/+yW7aElbw/fCNhdZb7ywBX37+oL+9x0kH6tbdZW7AHjuA1oRV7s0SOkkjnChfkCTI+Y2Ial0vE2xgBqgFfVGsqb5sHXfiaWlIHrWZdAQ05UqebLuPcrQFJMINt709tkHdaQ1t7zZMB+UBorJAzPA+SLWFNB3vtGxPbe7ANjLF9K4KR4V11N7m5gVMI+bqHPGCkSC2b6lu+CuRyvgzi44NJVKFYX/ZG/OCvoAAZfsV+FSNOY9JKN+JQKpKONm39croY6m43mtaPJnc4UBUbSxWPQu0+JWqYHaDHXWXbAx3YesAvssTwPTo7KTYFmJlq83vetiO3jHSC73wcL1Mn4COgM3skSQVavGksqAVSZ02/JC+O57EaT+OTR/Nlffroo1PgoPFf+FvWnDv2V1uoD5xk/SiomC1zjTsUF8zn8S5BzDpwrq9cZofAaPAA6+fa1dkd4boVcJq3R3yZ4swmmch8CJiKCof00qxZNxVCy3c58un+vZ+D0SxEEgj7DdfXVb3Rj3SmoPt8uUGj+S
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7772.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbf51bb-a0e9-4dfe-5802-08dcef66fab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 11:21:15.1248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5sHSN60xTuFHwXXQSu1u/lZIP3gAGZWFuwUCMSvdMy0t+Zwyj3hizAngGd6WLohbu0w3MC0fcYIXTyhy7LP39Dk1mNsSSCW15F+mAzSndQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6376

The problem happens when a v3 mount fails with ETIMEDOUT after
the v4 mount failed with EPROTONOSUPPORT, in mount auto negotiation.
It immediately breaks from the "for" loop in nfsmount_fg()
or nfsmount_child() due to EPROTONOSUPPORT, never doing the expected
retries until timeout.

Let's retry in v3, too.

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
---
 utils/mount/stropts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index a92c420..103c41f 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -981,7 +981,7 @@ fall_back:
        if ((result =3D nfs_try_mount_v3v2(mi, FALSE)))
                return result;
=20
-       if (errno !=3D EBUSY && errno !=3D EACCES)
+       if (errno !=3D EBUSY && errno !=3D EACCES && errno !=3D ETIMEDOUT)
                errno =3D olderrno;
=20
        return result;

