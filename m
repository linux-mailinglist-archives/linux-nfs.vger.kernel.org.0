Return-Path: <linux-nfs+bounces-7890-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851089C4B83
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 02:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167661F21B86
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 01:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B142454727;
	Tue, 12 Nov 2024 01:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Knh+E5T1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598814F9E2
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 01:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373681; cv=fail; b=FhIxaQIbkweY31jHbPD509b1IzmplqWGUhF0wPmVJYJqNAtV3HtTcG/PzK0ja5iiXLbP2Ew8JbM9X3u4YoFIEc/aHDDsF/WONCSmTUbN5Wbwz900+23PhM/zUg2AFu8Euab1uikyUxhaxld+j71dw5dym8X0Nm9nnxfzk+Nm5P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373681; c=relaxed/simple;
	bh=xhU/thiWLVpxXchjKb5LILQxx8ESeC5XTr3c04sq3yc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c/p8pBuRRpPC8eriTLsIrCW0MoK4yn51DDy5sq0OdBr/+p/g9wd2MadTq7T7/SrqQExaVBnfgO+j+JYF1zrq0x+/mMrq+aPZqF2Dk2lbfOt8muPrxqzMVX54IYrw2+jAcEpPSusww4/bVheiNo72dkACvPh0GIvKzOS2X7ZnvAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Knh+E5T1; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1731373679; x=1762909679;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xhU/thiWLVpxXchjKb5LILQxx8ESeC5XTr3c04sq3yc=;
  b=Knh+E5T1Ce5u4OvGKNCWR5bj++p3mWs+EnW833jhoA/J9s2HrP0SST1Y
   1YAh1CXBDc71cGW37qyaPytGufhDiv8DaULA5I8miwGhLhuiDO8CNPHP1
   GdcH2rx0JvtQUW4pPysWg1albD4ra/jtKmcXz/kzJ1tIBGMr8Srv6R/Y6
   M+f4VCRRVLkO1yh1lt8mFu8r2bhlTt9zVRfpG5NeyFbInjGBvoii+9Dnf
   gYskv78iihGycsjyQ4Nvcn5N5n5ZlrJV21N+kZuhjKQZiac882ix6wk8G
   USYHnc3gMjzUmBXrq4Z/AzdG86cg1OfZVFakCDHwtsE4cv8dqu/NcDlQj
   Q==;
X-CSE-ConnectionGUID: Q6JTMHtkQGGlYgXm2WF0Kg==
X-CSE-MsgGUID: lZVeW4oCS52cO4rb/3+aqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="137405364"
X-IronPort-AV: E=Sophos;i="6.12,146,1728918000"; 
   d="scan'208";a="137405364"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 10:07:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fynDcrtUrPmRT7yd/di3FCLF9IKDK4Pe0FP4GuCnFek4H6tHv0oLnaT3TVZ8WO4gvcokyzMy5aHDnuamu66y3sMLjzegoryp6ch/2YeKCs0osjnbtPanzQeiOUGs6sHY2KJmptKYDZY46WTRNkZTVebBMsJ5KU8SJe/xFuSzGEtDNzMe4w7kXA5pg6CicgloVe4MtY6HX1UGYHV/MUwjrjHB6dGwP+DIA7TWT6/KtrvE4zfXVZQEs6EPHKbRLp9PaV3DiBSkdFLbXYwawdYzahvEpQ11w1lWTgaUp1CiyNQqc7yh11lmWPNoXOc749XEQqXSYFtaTyakEyWK8FWrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhU/thiWLVpxXchjKb5LILQxx8ESeC5XTr3c04sq3yc=;
 b=AMavt6AsC0cagjU4knabOEJ59OQYixXDq4YGmkB6huHhjbB1eHcahMnwo/bIIwF9M9nuPh5vyrGI5VqVTQBHnXESYPfqeAWUDz4V+/TkRA2OU7lUHYCao0qcghrMZQp5P9yZu79CWQengf/b/3Pp95N48bFpGRpj3MT5p3wKykAhkM6YmeksmjodQP400LgcdLCvnuLVvTJJ6E+XsBdmHpkqC/bnNP4qxeUVS0Cxucx7v6yOSO9Sk50eSWGlR3pnJ3ua+3XVVa3mV4mHny96Ome7KHxEmfVT4XfRs1y8NXTjzYI9QAlHwvOL8tyhFo8mt4B/tuGxr29VmWUvWRXDmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by TY3PR01MB9980.jpnprd01.prod.outlook.com (2603:1096:400:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Tue, 12 Nov
 2024 01:07:47 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::df28:316e:ef65:39a9]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::df28:316e:ef65:39a9%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 01:07:47 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: 'Chuck Lever III' <chuck.lever@oracle.com>
CC: Steve Dickson <steved@redhat.com>, Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>
Subject: RE: [PATCH] nfs(5): Update rsize/wsize options
Thread-Topic: [PATCH] nfs(5): Update rsize/wsize options
Thread-Index: Ads0CNAGIEAUadG7QF6DMBzDxhWiYQAQXK+AABM7u/A=
Date: Tue, 12 Nov 2024 01:07:47 +0000
Message-ID:
 <OSZPR01MB77729C34BF03B9D78202ADDE88592@OSZPR01MB7772.jpnprd01.prod.outlook.com>
References:
 <OSZPR01MB7772841F20140ACC90AA433B88582@OSZPR01MB7772.jpnprd01.prod.outlook.com>
 <D001CF66-6807-4FF2-B45A-C10ECEB80015@oracle.com>
In-Reply-To: <D001CF66-6807-4FF2-B45A-C10ECEB80015@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MmE0MDI4ZTAtMjJkOS00MzlmLWIzYjgtYzQwYmMyY2E3?=
 =?utf-8?B?ZGQ2O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjQtMTEtMTJUMDA6MDk6NTFaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|TY3PR01MB9980:EE_
x-ms-office365-filtering-correlation-id: 6dede3d6-0573-4b7d-7904-08dd02b66bde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?cE1Hc00xTjRIT25STVB5ODhiZEVwQ1FZRGVLZTRISnNYeDZFTEpNWHZEYllK?=
 =?utf-8?B?c3laam5MU2M0QmdFdXIyNnVyazBUMjhuSmdtclNHWmZ1QUdIcXJKb2h3aStq?=
 =?utf-8?B?K3V4YlBRODVsTm9vSmJpcTVxdjhUVzRPbzZUcUM2ZEVEOHBaZGpERnh6UXY1?=
 =?utf-8?B?TmlsUlJaeUJuR3pkYzlacTRhWVc3c2VzcnRURUVXY2ZzV0kvbDUzb0RBdGxI?=
 =?utf-8?B?eFFqWTJaaGpXOURWTCtkSkYrL2s3YjNQWms2UnAwZkZCL0l4dkV0UHNxckpI?=
 =?utf-8?B?akhOOHBMSWJHTjdJT0dPSW9yaDZhTTViNjdTY1R2R3oyVVp1am9pK2lBUTl1?=
 =?utf-8?B?MkROanNzTWozZ2NIcXMzQWdiNVhYSk15eHBGMU15djZzV3JGSVNWR0RZaEkx?=
 =?utf-8?B?QjhpeGZxS0loN0pPSUhKQTZCaDB2YWJlbk1ZMlR4bTVwL2RxRHg4R1V2Umd1?=
 =?utf-8?B?c2EyR2Z2VXlpbzZmSVJBSkRZNXJyUlk0bzhhVVpPVTRKTE1aYkMyV05Ba1Ix?=
 =?utf-8?B?WUJEbmY1a1VSTGpyVW9RVms2czNQeE5SL2dPRi9TSkJ4T09wQWoyVlZwUkZX?=
 =?utf-8?B?bWVMbHVJNHhRVGdyT0hwNC9oamlyRjZZcmNheEFWTkRqQWN4N25Xd2ZnSDI5?=
 =?utf-8?B?UjN5aHBnYk5Td01XN2V4OUp5ak1UWDJXekRUdmNMU3dzdWtCdmFlV1BjWkR0?=
 =?utf-8?B?Z2VtY0h2M3k4WGNkRk11MUswbDdjOUVSQ01NZ1BQeko2RXFpNkJ0aWZKbkVV?=
 =?utf-8?B?ZzZ5Sm9za1AyUVp5WmtsQ3RPMlYvc1NRM2t0QkhCQUVTazdONWZiM2Z6aGo3?=
 =?utf-8?B?K0dOd3BUK2k5aHpzd0dUSnJ3YU1PcnMvQ0JWcFRwUGtwM3BZNnV3UlRSMGZN?=
 =?utf-8?B?QTZGdUtoeS9hZHpVMjdRNUlHN3JLcXdOTDBUcVlzbjhyTnNnR3JGSUlXUlFX?=
 =?utf-8?B?UnJTek4vWEswbyswVmhCWkN6M0lLaXg4UlNjYnN4MHMyWHE0aGY0Q1BqSnY0?=
 =?utf-8?B?OERUU0lOb1NOOXQ0eTc1dWJFQTEyY1hndWNUUGt2cVNXbDVoc1QyRkx5alZO?=
 =?utf-8?B?SmIxWjJ1dERrUXdET2hEVHdxTURoNVZhS28vN0JKckYwMDlQYjFnZVphZzdn?=
 =?utf-8?B?UDFQSEFPSGZkdFdwV0ludmc0Ri9ON21ud2xCSmwzOHRrMG1mUGlydHRRZWJj?=
 =?utf-8?B?eFJHMGlUWmlkMzY5dmFpNVlMVWY5V0plOVpBRTNkYkwrc2tnYjFETDBZRlJ2?=
 =?utf-8?B?ZllOOTVMNkIrUEIrYUJlQVcyZzJGZWNJNFV4ZW1GNHNKOG9xVzZCY3RjK0dU?=
 =?utf-8?B?ak85TXR6V2xleCtjYUJYcHhROS9lemluOFVRTll3eEkwQzJydVk1UVhrUHUr?=
 =?utf-8?B?c2NBS1VUZGtWN2UzUUNUZkJXMUdMRndTQWxuMXYxc3BVcVpKWlYwN2hVR0F1?=
 =?utf-8?B?WUVZdGlud0VBd0Q5MFFXbzJpbUhGRnlSRVdaUnZqejg2RjhwNGhZQXl4d2dX?=
 =?utf-8?B?dzkyNlAxVFRyTmNQR0NneDNvTi84eE5tdzBlSU5jZDdHSm80ZU5teWV0ZjQ1?=
 =?utf-8?B?ZzE3RXFTM2Y0djI2TC8vZ3JySzhQKy8xVkF2cVVucHVpbTZGTHgrcSs4cmJ5?=
 =?utf-8?B?amRqUlN3RVBPZEpQSnNwR3l5bUFVZ1lQbXB4RTZ5R3VJSUgycmNCZE1hV2JM?=
 =?utf-8?B?bjBZVS9SL1RSbzkxQTNWZkxFaE94Y3RZRVhjTTBxdEJwRkhNVlcvV2Zydysz?=
 =?utf-8?B?dFpSdkxmeXhRZm1iVE9uYThuMk1vTG9xaDNqZUJpOVlNVWR4aldGZzJTaWFs?=
 =?utf-8?B?QWN6VVd5eFFwaXhicXNOV1ZCZXpPZ1FKeU8yRlgwakI2WTJieitBWGhwVHdY?=
 =?utf-8?B?czdJNEZ6ejFHUC9Sc3Y0NjIyc2NJUmlLUUY3eU5zWHM2QVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVdFeWZIU2haMFFPSk5hc25QcXVQV1dXTldRcWNGNlhicG5QMy9tazVkR20v?=
 =?utf-8?B?SjlyZDZvTjdMQ29SREFOVUlzUjU1OXdFRzc4Q2d6YkJWM3hqVlV4NVJEMi8x?=
 =?utf-8?B?TUIvK2l1MTg3WnE4bHd0RW9wb1paNk5WbFBrMmpDUXpjbEZhbzZ5SmxtWEVq?=
 =?utf-8?B?aEVKdzMzS25sbUNqYzJRK2JMMXFrWGxLZFZWQjUwVW10dkpvc3JuVUJ6R3Z1?=
 =?utf-8?B?V015aEt3TUJVRG5tRm9oUTdTVTNpa3puWWYwdFc3ZzRaTGg0OEtkdldCdmxN?=
 =?utf-8?B?Y2N4L29ySFdLN0dJZVltRFN6emlrazcwYUxKWmR6OUR0dGRsYUErKzBPVGY3?=
 =?utf-8?B?RnBDdWsweW9LT252NWVVS3cvandoaitpRis0SmJ1UjlKU3EzQy9oQW8zWktt?=
 =?utf-8?B?Y3dkaVJSaVlZNWN2TkF2ZEFtTEhWMWVMdDZLbERKRWdKTWx6aENCblhUMVAw?=
 =?utf-8?B?WTZPK0hCL3l5TDUvaUZkS21Uek9jM2U2dlIvaWVmbllMbkR1a1U4L1IwMVFQ?=
 =?utf-8?B?MVNqSHpUeHY0ZWZ6OE9mYys2MTJEV29QQ0VjaFNuNW13b1FuVG92eDhmZWF0?=
 =?utf-8?B?MW94Mms0RHZrNE5sRkZqREE5cjhGc0U1aW81cU1iN2FEVG5IQTZMbHZVTVRo?=
 =?utf-8?B?cmIvdFJZWGFnWktJVEpUcHVuaFRDbnQ4Z2Q2UFExaGZHSWV3TkpnY1AwQVRy?=
 =?utf-8?B?ZDF1MWpmREhCdnhMYmRXcXorNWFyZkltbGhmTk9xWFM4L3psNG9Zd1pOcHpY?=
 =?utf-8?B?cFYrQitKZ2dnTWo4U1dtUHp4UzdiYkR1Y1ZITVE0MzA4UGVIcUN4VWNISkhB?=
 =?utf-8?B?M3ZDdkpQbXlya3VqLzFYelB0bFowaGErL0k4VU1JUERKU1BITElEWlJzSkpL?=
 =?utf-8?B?Mk1UV3dGbVRWVmFUMUM0eW9YS0taTTM2WFovcXZteFFySjIxa3NIdGdGc3dt?=
 =?utf-8?B?T21iQzNIbjlwYnlKMXkyaHRrVWc1cXJRQ2lHZVY5clE1aG50U1Y5YWZDblQx?=
 =?utf-8?B?TVEyQUtLVjcwb3pzT1FoVDNLUjV5bEY1WkdKcEpib2tVSEIrV2VaSHhEUkVt?=
 =?utf-8?B?Wld5a01YS3gyYjMrSm9IcS9DVGRqZzBRdVFabVNiM1NadEFDV3paVy8yMVF0?=
 =?utf-8?B?OVgybUNhNEp3cEdUdGlPQlpKY2xzYk1NZEUyTGtJY2FJQ0R0eU9GZ0lXRk9F?=
 =?utf-8?B?SGdjbjFuMjFJL0xzRmJDbVlvRkpYUmdaWU1mM1EydExYTUV4OXZpS0tWUXhR?=
 =?utf-8?B?K0paRkg5VnROS3NPTDJITGw2YUdnUXpRSXg5ZE9DV0NhZlMyRFVqOXdyaTNF?=
 =?utf-8?B?OVZyOXFNRnJ1bVlQaCsva29rTFBhVUNHTVRHVkVuYlg2OGtjelg1bVUweTZT?=
 =?utf-8?B?S2lwWjdaZHo3cmxPWmt3c1M1WjZtZXdBYmJ1a0ZON2FjS2s0K3hwMTMybVZO?=
 =?utf-8?B?L0hwYzkzRm9RYUllZU1KS1A4NEhtMk83KzRqRXFIZnFNTklYV29aMGxiUVZi?=
 =?utf-8?B?a0xKTG5Bd2NhOW5uTFdFaGRvNlRQazR2aEw5Wm5ZSVAzdTYzeFVidGNMTmYy?=
 =?utf-8?B?QXkxUEhqaWltbk5yR1ZaLzA2N1NPRDhsRHRVWlc2NHZlckQyTFU1Q29pOTB2?=
 =?utf-8?B?TnhaNjdhNkZmRjY3YlJmZ0hpdFM1NE9oV1MxU0Rwekx1Wmx6UjBKSEZ2alo4?=
 =?utf-8?B?MzJKdzhZaDBmWEhHYW93RUNTWjdJMTNqWVg5SEQrNGZLaFlCc3NtVnFpdmM2?=
 =?utf-8?B?c3YrYmRXUWNsd0VFMXZ6MkwvOHU4YVFTUTdjY3loUHZSRHZxdUNXNldJbXE4?=
 =?utf-8?B?QVBaVE5PcWdvb0p5akN6dHZoaDk4dFhhWHRoWkhja1NsVENjTlp5U3d3akwz?=
 =?utf-8?B?dWI2VTh2NVJvMXlKMGZ6bHBSTDlwemdzd2N6aTNrS3ROUEdzaG5CS20vckNk?=
 =?utf-8?B?M1duUkJqZEtKeDd5S2xIQnlmQldYby9xOFZTaEJUNzFhNEgrNmUzc0VCOCtu?=
 =?utf-8?B?MlRSRjRhK3RXV2JpMFk1c3ZFWjcwWmJtR3NSMkoxMTVZSGpzMGJzdkkwTlRq?=
 =?utf-8?B?MVRCZTBVUmp5cm4zUlNjcm4raEVDbEZ6RnRUSTM0WWtMSTM1aWdENmZNN2Zl?=
 =?utf-8?B?TSsrTkw0dkczMHdjcm5VQUVCUlR3cmV5bFR2aGxGSlV2NEZZdTR3MlVBbmNn?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I2/jsihCIrF9Cm7KJddS+piaP0/WjkvjwnCVkNL/GutaortCMZn/RoJ2YJHfuzOwrrNIhrtW0tCnhniuZJMNGPn7Tn+S3B2VO4mZIOGgkHZ5yHcmdEmATDFIUI2PKflPvKwPqZ36zO7Lc4Fn9Tzflp268xDLXc72wbwNKLzOwAHQer77cE/QiridGFSn4hJ0gMUR6BbtnpN46cUzo3nVBee3pp6CBAKN2a0b0tCs/Z8RBUvV6V+h1lf/roksqTPFwX82cxVrcBqyZ2wne/Yc/lzg1tS1kfrNkSpMcfduua6YYLoWBSDKilWTY5EcCracjMrblIc6IWRaDn3l80Pb/7WkklzzmDc2/0vcHpGs6Q5RrK1yZFHjQj1nBoDeLfuH9m4h8wGFrB0vrble8Xj3P15cYvyDIjw28+H9nAPRwOEsGZs9r0WSBYb+vHFQwRpweIK/lsN0CLEat+hF6jzcjXVy/ZHB7ZFb86MTBECpZccLYTCoKeR8Wnv/2afjP+9CihHI1DZUq6dpfZ+lD90EwU1RZUVtfYbU4udr0soiDrEX3tO1cgRDBo63LtocHC0ioO0k58B5iDm4hUnVb0XO9GKBXqFC2wX1BC1+b6OcMmcWqOmHRxCJaSoi1KHeNeyf
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7772.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dede3d6-0573-4b7d-7904-08dd02b66bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 01:07:47.3469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +iAYAqfb9cu73C3Fmjnv3xYM2LtBvoS+LLskPZi2/E+jDvc/tdF0EtkFLxc4J98leg2eELWG9lUgyKfFSC8dgRjZRIdo1/iUA0xMOO1KYGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9980

PiANCj4gPiBPbiBOb3YgMTEsIDIwMjQsIGF0IDI6MjPigK9BTSwgU2VpaWNoaSBJa2FyYXNoaSAo
RnVqaXRzdSkNCj4gPHMuaWthcmFzaGlAZnVqaXRzdS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhl
IHJzaXplL3dzaXplIHZhbHVlcyBhcmUgbm90IG11bHRpcGxlcyBvZiAxMDI0IGJ1dCBtdWx0aXBs
ZXMgb2YgUEFHRV9TSVpFDQo+ID4gb3IgcG93ZXJzIG9mIDIgaWYgPCBQQUdFX1NJWkUgYXMgZGVm
aW5lZCBpbiBmcy9uZnMvaW50ZXJuYWwuaDpuZnNfaW9fc2l6ZSgpLg0KPiANCj4gSSB0aGluayB0
aGUgYmVoYXZpb3IgY2hhbmdlZCByZWNlbnRseSBkdWUgdG8gYSBrZXJuZWwNCj4gY29kZSBjaGFu
Z2UgQW5uYSBkaWQ/IFRoYXQncyBteSByZWNvbGxlY3Rpb24uDQo+IA0KPiBJZiB5b3UgY2FuIGlk
ZW50aWZ5IHRoYXQgY29tbWl0LCBpdCB3b3VsZCBiZSBncmVhdA0KPiBpbmZvcm1hdGlvbiB0byBh
ZGQgaW4gdGhlIHBhdGNoIGRlc2NyaXB0aW9uIGhlcmUuDQoNCkkgYmVsaWV2ZSB0aGF0IHlvdXIg
bWVudGlvbmVkIGNvbW1pdHMgYXJlDQpDb21taXQgOTQwMjYxYSAoIk5GUzogQWxsb3cgc2V0dGlu
ZyByc2l6ZSAvIHdzaXplIHRvIGEgbXVsdGlwbGUgb2YgUEFHRV9TSVpFIikgYW5kDQpDb21taXQg
YTYwMjE0YyAoIk5GUzogQWxsb3cgdmVyeSBzbWFsbCByc2l6ZSAmIHdzaXplIGFnYWluIikuDQpC
ZWZvcmUgOTQwMjYxYSwgdGhlIHZhbHVlcyB3ZXJlICJwb3dlcnMgb2YgMiIuDQpBZnRlciBhNjAy
MTRjLCB0aGV5IGFyZSAibXVsdGlwbGVzIG9mIFBBR0VfU0laRSBvciBwb3dlcnMgb2YgMiBpZiA8
IFBBR0VfU0laRSIuDQoNCkkgY291bGQgbm90IGZpbmQgdGhlICJtdWx0aXBsZXMgb2YgMTAyNCIg
aW1wbGVtZW50YXRpb24uDQpPbmx5IHRoZSByYW5nZSBjYXBwaW5nIHdhcyBpbXBsZW1lbnRlZCB1
bnRpbCBMaW51eCB2Mi4xLjMxLA0KYW5kIHRoZSAicG93ZXJzIG9mIDIiIGVyYSBzdGFydGVkIGZy
b20gTGludXggdjIuMS4zMi4NCg0KUmVnYXJkcywNCklrYXJhc2hpDQoNCg0KPiANCj4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogU2VpaWNoaSBJa2FyYXNoaSA8cy5pa2FyYXNoaUBmdWppdHN1LmNvbT4N
Cj4gPiAtLS0NCj4gPiB1dGlscy9tb3VudC9uZnMubWFuIHwgMjQgKysrKysrKysrKysrKysrLS0t
LS0tLS0tDQo+ID4gMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdXRpbHMvbW91bnQvbmZzLm1hbiBiL3V0aWxzL21v
dW50L25mcy5tYW4NCj4gPiBpbmRleCAyMzNhNzE3Li4wMWZhMjJjIDEwMDY0NA0KPiA+IC0tLSBh
L3V0aWxzL21vdW50L25mcy5tYW4NCj4gPiArKysgYi91dGlscy9tb3VudC9uZnMubWFuDQo+ID4g
QEAgLTIxNSwxNSArMjE1LDE4IEBAIG9yIHNtYWxsZXIgdGhhbiB0aGUNCj4gPiBzZXR0aW5nLiBU
aGUgbGFyZ2VzdCByZWFkIHBheWxvYWQgc3VwcG9ydGVkIGJ5IHRoZSBMaW51eCBORlMgY2xpZW50
DQo+ID4gaXMgMSwwNDgsNTc2IGJ5dGVzIChvbmUgbWVnYWJ5dGUpLg0KPiA+IC5JUA0KPiA+IC1U
aGUNCj4gPiArVGhlIGFsbG93ZWQNCj4gPiAuQiByc2l6ZQ0KPiA+IC12YWx1ZSBpcyBhIHBvc2l0
aXZlIGludGVncmFsIG11bHRpcGxlIG9mIDEwMjQuDQo+ID4gK3ZhbHVlIGlzIGEgcG9zaXRpdmUg
aW50ZWdyYWwgbXVsdGlwbGUgb2YNCj4gPiArLkJSIFBBR0VfU0laRSAsDQo+ID4gK29yIGEgcG93
ZXIgb2YgdHdvIGlmIGl0IGlzIGxlc3MgdGhhbg0KPiA+ICsuQlIgUEFHRV9TSVpFIC4NCj4gPiBT
cGVjaWZpZWQNCj4gPiAuQiByc2l6ZQ0KPiA+IHZhbHVlcyBsb3dlciB0aGFuIDEwMjQgYXJlIHJl
cGxhY2VkIHdpdGggNDA5NjsgdmFsdWVzIGxhcmdlciB0aGFuDQo+ID4gMTA0ODU3NiBhcmUgcmVw
bGFjZWQgd2l0aCAxMDQ4NTc2LiBJZiBhIHNwZWNpZmllZCB2YWx1ZSBpcyB3aXRoaW4gdGhlDQo+
IHN1cHBvcnRlZA0KPiA+IC1yYW5nZSBidXQgbm90IGEgbXVsdGlwbGUgb2YgMTAyNCwgaXQgaXMg
cm91bmRlZCBkb3duIHRvIHRoZSBuZWFyZXN0DQo+ID4gLW11bHRpcGxlIG9mIDEwMjQuDQo+ID4g
K3JhbmdlIGJ1dCBub3Qgc3VjaCBhbiBhbGxvd2VkIHZhbHVlLCBpdCBpcyByb3VuZGVkIGRvd24g
dG8gdGhlIG5lYXJlc3QNCj4gPiArYWxsb3dlZCB2YWx1ZS4NCj4gPiAuSVANCj4gPiBJZiBhbg0K
PiA+IC5CIHJzaXplDQo+ID4gQEAgLTI1NywxNiArMjYwLDE5IEBAIHNldHRpbmcuIFRoZSBsYXJn
ZXN0IHdyaXRlIHBheWxvYWQgc3VwcG9ydGVkIGJ5IHRoZQ0KPiBMaW51eCBORlMgY2xpZW50DQo+
ID4gaXMgMSwwNDgsNTc2IGJ5dGVzIChvbmUgbWVnYWJ5dGUpLg0KPiA+IC5JUA0KPiA+IFNpbWls
YXIgdG8NCj4gPiAtLkIgcnNpemUNCj4gPiAtLCB0aGUNCj4gPiArLkJSIHJzaXplICwNCj4gPiAr
dGhlIGFsbG93ZWQNCj4gPiAuQiB3c2l6ZQ0KPiA+IC12YWx1ZSBpcyBhIHBvc2l0aXZlIGludGVn
cmFsIG11bHRpcGxlIG9mIDEwMjQuDQo+ID4gK3ZhbHVlIGlzIGEgcG9zaXRpdmUgaW50ZWdyYWwg
bXVsdGlwbGUgb2YNCj4gPiArLkJSIFBBR0VfU0laRSAsDQo+ID4gK29yIGEgcG93ZXIgb2YgdHdv
IGlmIGl0IGlzIGxlc3MgdGhhbg0KPiA+ICsuQlIgUEFHRV9TSVpFIC4NCj4gPiBTcGVjaWZpZWQN
Cj4gPiAuQiB3c2l6ZQ0KPiA+IHZhbHVlcyBsb3dlciB0aGFuIDEwMjQgYXJlIHJlcGxhY2VkIHdp
dGggNDA5NjsgdmFsdWVzIGxhcmdlciB0aGFuDQo+ID4gMTA0ODU3NiBhcmUgcmVwbGFjZWQgd2l0
aCAxMDQ4NTc2LiBJZiBhIHNwZWNpZmllZCB2YWx1ZSBpcyB3aXRoaW4gdGhlDQo+IHN1cHBvcnRl
ZA0KPiA+IC1yYW5nZSBidXQgbm90IGEgbXVsdGlwbGUgb2YgMTAyNCwgaXQgaXMgcm91bmRlZCBk
b3duIHRvIHRoZSBuZWFyZXN0DQo+ID4gLW11bHRpcGxlIG9mIDEwMjQuDQo+ID4gK3JhbmdlIGJ1
dCBub3Qgc3VjaCBhbiBhbGxvd2VkIHZhbHVlLCBpdCBpcyByb3VuZGVkIGRvd24gdG8gdGhlIG5l
YXJlc3QNCj4gPiArYWxsb3dlZCB2YWx1ZS4NCj4gPiAuSVANCj4gPiBJZiBhDQo+ID4gLkIgd3Np
emUNCj4gDQo+IC0tDQo+IENodWNrIExldmVyDQo+IA0KDQo=

