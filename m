Return-Path: <linux-nfs+bounces-10856-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A715A709AC
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 19:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D4A179F3D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E6F19B5B1;
	Tue, 25 Mar 2025 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Z/1BH0ON"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2128.outbound.protection.outlook.com [40.107.220.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BEA19B5A7
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928538; cv=fail; b=l7YDnUj4HZxxm05fjrnoua6HT27LJ9o5PfsBhyx0s6FFZT/78Tor/LHAPxyntKlGGuMZUN0fMwYeo5aPR7BR5PjK5dFDlDKmReNbVPv/zLGT/4XppBNLkI5s2RirNjyfoiU/Tj9uElGzgG9XlXSQ/wceK4o6KIR2f6Wt7kMxr9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928538; c=relaxed/simple;
	bh=tqEbtzV7fsggMVS7pFPkg6ByH+dGYjFMWIf01d4JSJ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s2+7HNFrjWY5RgdxYbQ6psNSq5QqERHAgJwQSN18v4xhn5JKBPtdwBFOYMc+X56jfuWi4kMkLH1IltF1GDG//wDpl8RU+5vwYP4wWeKZpQgCTL3pOHLWnzVJfx2QzN/aI5AlLe5uDcTn2krcEQhpFl3Ql/oloQUSNSjOHLGaOTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Z/1BH0ON; arc=fail smtp.client-ip=40.107.220.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tp0gAaNpzFEMiP5FneaIBrZ0VuH0cEe2N5i9q141nR99yDNlVF+eSox8oN+r8bknLwyTqlAltQvkuJqRE5aQIstkyyzjuYOUxampLMmPc5Ns4IYm8cY70HJygbwKcVNJC60hHENswW1KzxdHuyPziQutQwlmbivgb5qX5kVj/pDSkCLkLRIa5wakv+dMM4Q4XEyAiKXLI1x2U9qyWfV+pgJimet41KFqoTIsz3/SKSboDZxjxzXbB54GmXhJcGfBEEb3C92cAJnUN5GtKvtJtd3Hb9z0WGJMy3tgSeFLSXqE1w/JNZ6mDc3N5O6XGMoXYXnc1fmLyyhCrMaBFEjrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqEbtzV7fsggMVS7pFPkg6ByH+dGYjFMWIf01d4JSJ0=;
 b=I1FMsyAJ/F00ezyLnzyXP5LB2Y17UdkesigSSnQLM3BEaN1ibzlTi5yaLxKq7Gja6gSHqlevo14Vmd7zG23LX3FtlTbdQI/tl3PDrPe9GqlrFoRuWwxBxkQdR2K6hLdUBl16gZOsW+7drN53aj2zwZDYVKsvBNweuDDTS3vjKurdrdLf3ptFAiqVHEsnWY6soWRB63gtg9ggAoAXhNV+Q16YOSxX9YUMV9yDWwBEo/gF3ymaHXqkIuClQZh4shGDAlJCRIsGYqlAZQZlK9649tkgmqBvRb1RnzaEPo1ZxDqKaWzUpIK1HuN5t4H0iNTsmtYo4nWUkgRSCX0XIP016Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqEbtzV7fsggMVS7pFPkg6ByH+dGYjFMWIf01d4JSJ0=;
 b=Z/1BH0ONDsJf+2jyqDOyHcFCU55KhYkxKZioSUmll42n8/3yIECbVVOuAs8dGeHRfnkLo8cc7dqwmE2pFbhBQmC10cYrlgToMMKsS29ypcEqOT+XoL/gRMCnqTYCJswqBjV/1smPneXU10L/wFw5+VS5xcMDdr+vtAMel2hQvAQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB6612.namprd13.prod.outlook.com (2603:10b6:806:3ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 18:48:51 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 18:48:50 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [PATCH v2 3/4] NFSv4: clp->cl_cons_state < 0 signifies an invalid
 nfs_client
Thread-Topic: [PATCH v2 3/4] NFSv4: clp->cl_cons_state < 0 signifies an
 invalid nfs_client
Thread-Index: AQHbnaGz3iZvUDZepUa3HVS9khkBf7OEI+0AgAAN5oA=
Date: Tue, 25 Mar 2025 18:48:50 +0000
Message-ID: <bbfa25ef22c7b7b826d91d8cad71b5de2590ec92.camel@hammerspace.com>
References: <cover.1742919341.git.trond.myklebust@hammerspace.com>
		 <56bc4d7e614a6d9d0aa520c71bd0ffb102e3ef08.1742919341.git.trond.myklebust@hammerspace.com>
	 <202d8ae85ba2b1cfb454356a2781ef5b31ff37be.camel@kernel.org>
In-Reply-To: <202d8ae85ba2b1cfb454356a2781ef5b31ff37be.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB6612:EE_
x-ms-office365-filtering-correlation-id: 3dece5a6-f813-4328-83b8-08dd6bcdaef5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?LzEwRVFGS3A2L05OdW10Skh2N1V3V2ViNXhFcUpLUnRuOXN3dzRPdkRsREIx?=
 =?utf-8?B?QlhlZVIyeUVsZWFlbm9ESThwOWFjWUZGdWRXSSt6OS9tMVJuOTlUSGxsRjV6?=
 =?utf-8?B?ZUpWNWZMcmlwTE5zc2RtWE5tNSt3OWNCdVFKdGpHdHJzcUxJa0NHdXZta0tW?=
 =?utf-8?B?eGJpcFUrSW9taE5tanBqKzkrYjRDeDh0MXRGWk9TNDd5NVROY3JHSmVKZFEr?=
 =?utf-8?B?dWV1c2gzVFZvNXJxNEtTMW50UE5sckdlVVVvdllnZ0xXUWE4TjB3eTlaNjdr?=
 =?utf-8?B?S0RaSWRXTVU3N21MdTJNS05ncVFiaW91MlVNQmlmb3NEQ1VXcnFhWnVQb2V1?=
 =?utf-8?B?UGpFQ3JWV0p2d1lqZUg4Ujd5bExLY1g5a0l0ZkhyK0hFYXNxVUNEUzRaYWhZ?=
 =?utf-8?B?TjNBZnViY0hMbWg0bmczMG9TbkVqNCsrRTNqbFJuTStEWFdkQzFRRDUzV05V?=
 =?utf-8?B?cUtZYVlCNjRZZmlGaWtDWWtQc28wanNXT0ZXUS9EYWxzZk9yampCSGdjZEFj?=
 =?utf-8?B?cDdDdHk0QmtJR3ZaSjJVVVE4dWpkVGYxNEs5cVhtWklzWEZiV3NPejk1OG0v?=
 =?utf-8?B?OGNSTElJbVBQdjNRUkR6OThMWEJuQ2ExRWtRdEcxYkNINVBsWnd1eWJJbXNi?=
 =?utf-8?B?VHZPaHZUU0hET1BmZjBmUWxXdXQvSHBEZk43bmlJbVVOUGhkN0dYaERLRUZF?=
 =?utf-8?B?QjBaN0xxR0V6OTRlRWpXOUFTbEI0cTBhenEyWUVvNFAzUW4zWlJXMmo3Z240?=
 =?utf-8?B?NXJKTk9rN0ZyTDhFeDB0QWlDVk5QNEd5eXVJak50cXBQMGlSRWtHSWI5NGMw?=
 =?utf-8?B?cFNnVm1TZTNqK05IT1hIZUVXbjJlTHllcmZMRk4xZ2thVmljNGlpaUpCTG4v?=
 =?utf-8?B?ek9odFp3eS91WUExaHpzTXFsbjh6OGl0MnZQaHFlTjFhNFF1UStzTFJFdXR6?=
 =?utf-8?B?UnJabm10bmo4TzFJUDlmTCtKNmNlSjZySXFnR2JVZ2pteHNjazR2NGZzQnZH?=
 =?utf-8?B?alNNazMxN1h6cEc2dVB2NGtYNkFjVkk3Y3lHWHU5Tmp5Wmh1cGtua0RhLzI5?=
 =?utf-8?B?SXA1QkdpT3RlVGtNN3A1dnV6dFY1TzQ3R1h4WEs5V1FIZnFTTDVGNUxXcVpp?=
 =?utf-8?B?NjhiUlBFSkorby9ZdmJwdUhraWJqSDk4dHJSNUVnSTVYT0gyaGhqOHZ4emsz?=
 =?utf-8?B?QlZRdjMzTUJYM0kxN2xzZ28rL3hJdzV1bk84WVVVNWQ2ZTRFTlNId0Rhcmdo?=
 =?utf-8?B?d2hvMlNML3dMd3VNYVl1OGZCOFZWY0I2cHRDeHdNdTdLZ0VTSkR0QU9XNHY3?=
 =?utf-8?B?ZC9yNWFHK3BIZWZCUElXS01BMEt6SlI4V3FPWkZpRHNLY0dPT09hSThsZ2dH?=
 =?utf-8?B?TldQeHF0aDZPdlNGbGIrbHgxQXpsaFI1am95elk0VXpkTjN2ZFNWYU1GMEtX?=
 =?utf-8?B?ZTkzalRTb1dnZzhEUHU5QU03ZlJtRi9QRTlaV09QaHlIMG9wbC8vcHdJOGtp?=
 =?utf-8?B?Z0tCS29sT0FGMGNVem9FNHZ3NXYrRHJkT212S0pjY2IrdVhDcUtWREpqSThl?=
 =?utf-8?B?ck1RZXVSU29DOUZKSUM1T0pUTmN6aFhzNXVFS3JjUk9lUFhIR0dQWVVEUXlQ?=
 =?utf-8?B?NmRES2RIMk9aQnFOT3dTQUsrRDR5K0lTc2tCVUE1SERrUjUyNjhoeWRqMm9s?=
 =?utf-8?B?V0U1ODdoWVJYVHYrWnlJa2JJVXd1ckpXbmFDQ3E1cCt4MEEzWW1QbWFZM1ho?=
 =?utf-8?B?UUU0N1BueHQ0SE03czh1dzU5UFU0dHF0cS84ZnRPcm43YVJnMEU1TnpJeGNr?=
 =?utf-8?B?cmpxMGkzeGNZZlhobnUra0hsVXdSSXAzRm13K3VENlhIUUltVkdvQTRaSTZi?=
 =?utf-8?B?aTBoNGNEVXNRL0N4Qlo5OGJQTG9XZ0F1b3NydjJwZkRTWEFVaWZwd2VvOXFE?=
 =?utf-8?B?bVZyWHR1WU51ejQrbUx1alUwdjl1S0oyc1NRWVhpSTY3OE1uN09ocU95UVhr?=
 =?utf-8?B?LzVlSEc1M0dRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WENTTllwd1NIM1lubDRla3dkREpZdGQ4UXNjbWRYVWVwVWRHNlB2ZGxGZmNj?=
 =?utf-8?B?RVFXR25sbGFkTDJVLzZjTU5mbm5JTFUxMElzNTFBVnNMb2lnaGwwUDV1K0Jv?=
 =?utf-8?B?a3FxR3orYUlJaEJvelVzQzltZGVPeGJVZUFTNWxzdVZCVFNURkU4VkVhZElq?=
 =?utf-8?B?Z1RINTB6S0d3L3ViR3J3YnptUnpNNE8yeHJ3cUlrVjZ3TVdiQTlVYUVUWVIv?=
 =?utf-8?B?L2tpU0FxTmNUUG0rdHgzZmFRclJSeVZBNThnL0cwVjNTOFNzZGlGQjY1eGpI?=
 =?utf-8?B?eW9XbkpNY1FadkFkdXo0d2Z3VGhySEZMeXYvNWdrQmZDOWZzdGlDMHV3OUc5?=
 =?utf-8?B?eldJMWM2c2lvd2VOaWcwdnZvelEwUkZJRHJ0MlhBaGdTRUlKY0JMWEJjaWZF?=
 =?utf-8?B?cnVtSVlkbC91UzJnR05XZkRyV1Q0Y1VTZTEzd29leVQrRjNSSVYySHB5aGxz?=
 =?utf-8?B?ekJEVFloQmV3dHNFUkIwTEpFVC9YYUdPcjdkSHVxS2ZQQ0p5Z3QzOUxsOW5B?=
 =?utf-8?B?TmxYTytSU2VRWmpibU1qTDZpOTgxeDJmcTRnVWVoK3RvY3ZEb2ZkcXZmYjlU?=
 =?utf-8?B?VVcxaXJmSGV1TFBFRjV5UTlIWmpFVnhZMTk3VlFBZzRXbzVRazlyNWp6eE13?=
 =?utf-8?B?M2FRVGlZTm85Y0QvYWpqZlBjMHErRm5nVTliODF4Zm1pRTkzL3Nla0t0bjFO?=
 =?utf-8?B?Qy9DSFN2OVhDbjBPem1SY0hSbDJrTUVPV0tMYk1QV1I2Zms2L21HTmdRbUFT?=
 =?utf-8?B?Mi9DMHo3RGZBaFZ6NWpoMnl1ekRWbmxwemhXckE1VE85NzNZNE5DT1FBeVF6?=
 =?utf-8?B?ZnhRZDN6SEV1SWZRRVBncHJWOGJrbjUrUi9Gb0RwVkdCSWRPWlpldGoxaXda?=
 =?utf-8?B?TzZITWxUa1NUNk1TVW5NdzJNbVBlTWttN016cU4wVk5GUnIrMUt2aVpqQjFx?=
 =?utf-8?B?T3M3NzVxalVaRCtYdEZyeEpuU1d0KzVYQ0Q0SStmMXBOS3VTeGtadUdYaEU3?=
 =?utf-8?B?YUp4MnhQRTNCWi9FdUJhMjFDczg2Y0orZjJBY3RSb3AwRUUwYzB1dk4zcE5N?=
 =?utf-8?B?NnN1dldKZGpoamxGdFR3eHgwWWtRZXVMTWQ1Z01USU1aQm9qQVVENTAwT1NI?=
 =?utf-8?B?blhCTFhhMDhuV0Q0UlRQYmYzMDFSdTNleGxzZCtPN2VFbHMxdFJzWjRVbWtQ?=
 =?utf-8?B?R0tLclhyQXR4V0R4QjkzbWZoQkVTZVJTN1BLWHZibDFtRUhlV3ZhYzFGcFFx?=
 =?utf-8?B?NnhTRkhXeGhJdVA3Ti9RNWQvVXJJNzBSSllMQlBKZTcvd3hZQlFaYjhrNSta?=
 =?utf-8?B?d2tPK3MzVDYyY3hIMUNzNy9LNng4MXRpTk0rSWlBYjYvSkZYNXF6eEV4ZWFt?=
 =?utf-8?B?V1JyN09PUUxja3JYYjhFN085SHlkcUcrcHVyMjlUNGdKcG5HSFNnbEEzbmgx?=
 =?utf-8?B?S0hJUE91eUJjZm1GR0FnbXpwaFJLRXBlOWZRa09BclJtdVpBcyt6NkFIenZE?=
 =?utf-8?B?NkdpZmZOMHJ2YXJ0Q2kxakpZS2h6Vnh5VzVWcEdmbmIvNktjUkFzWnNpOERT?=
 =?utf-8?B?dE41OVNmZElUVjluc2VEdU9Tb0wzZGRNdy9sQWs1TURiQ0VMdjBOek14YUx2?=
 =?utf-8?B?ZjlXQjZQalJtM1NqTHBxYkh4Slc1bGJpa2E4M0wxbEUvTTF3ajkxTk1jR2xq?=
 =?utf-8?B?TDR5akxTTmtzVXpPcCtrQTQyQ2ViVVhmcjBFR2hoMVlHSUZtRTlEZk81NmE2?=
 =?utf-8?B?Zy9RRmZjT2NWVzNrL1IrYmM4QytYS0tkclNsVDdVYmFRZGVEd051ZFBsVmRZ?=
 =?utf-8?B?RG1VUjBTdkhUUW41RE1pUk9qMkh5eUQ0b0ZMUU5PcTFtblVYQ1dsekVOS3F3?=
 =?utf-8?B?REM4RjdTekI3YjBoMmtPN0N2dTBYVDNsYjQ1WG9EYllLRlNxbHRXY2hKN3Vl?=
 =?utf-8?B?d3JOZ2lGMnYrdHJRQzdZV05CN0lTb1F4ZzcyQnpPRStPam5hWXBuQ21PUk0w?=
 =?utf-8?B?WGIwMDlrZG8wWUV3bGJyTVd4U3liL2FRNUpRaHRxTFo4ekd6akgvN21OV3Q5?=
 =?utf-8?B?aFM0eCtKYkVYbEhOcVczb0pYMGNXM01UcEU3TjhTak5yZ0dsT3NOMVJDWlIw?=
 =?utf-8?B?dTJ5MENWUi9JTXNsRzJqTWlzcGdCZUhjZDU1S3hva3NKV2c0TFh4TUhWaDFQ?=
 =?utf-8?B?Z29aSU5wL2dCd3p0VEhLS2VvRUhrVUJtTU9VeWhrMEt6L1NmWVVjZjhKMkxJ?=
 =?utf-8?B?THc4M1pqbGVzWDVhZmpkUFdzYTRRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <731F2A1957664A4299521C13613B2BCC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dece5a6-f813-4328-83b8-08dd6bcdaef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 18:48:50.3830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+kMswv5uGBq6vcQjdWAztFYbsWAT3JkVX22mPfzcNDsNZKdvSRD5QeL/6e2UPs8qh+rIKh02VE32KmNNqYziA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB6612

T24gVHVlLCAyMDI1LTAzLTI1IGF0IDEzOjU5IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVHVlLCAyMDI1LTAzLTI1IGF0IDEyOjE3IC0wNDAwLCB0cm9uZG15QGtlcm5lbC5vcmfCoHdy
b3RlOg0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbT4NCj4gPiANCj4gPiBJZiBzb21lb25lIGNhbGxzIG5mc19tYXJrX2NsaWVudF9yZWFk
eShjbHAsIHN0YXR1cykgd2l0aCBhIG5lZ2F0aXZlDQo+ID4gdmFsdWUgZm9yIHN0YXR1cywgdGhl
biB0aGF0IHNob3VsZCBzaWduYWwgdGhhdCB0aGUgbmZzX2NsaWVudCBpcyBubw0KPiA+IGxvbmdl
ciB2YWxpZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gLS0tDQo+ID4gwqBmcy9uZnMvbmZzNHN0
YXRlLmMgfCA0ICsrLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0c3RhdGUuYyBi
L2ZzL25mcy9uZnM0c3RhdGUuYw0KPiA+IGluZGV4IDU0MmNkZjcxMjI5Zi4uNzM4ZWIyNzg5MjY2
IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mcy9uZnM0c3RhdGUuYw0KPiA+ICsrKyBiL2ZzL25mcy9u
ZnM0c3RhdGUuYw0KPiA+IEBAIC0xMTk4LDcgKzExOTgsNyBAQCB2b2lkIG5mczRfc2NoZWR1bGVf
c3RhdGVfbWFuYWdlcihzdHJ1Y3QNCj4gPiBuZnNfY2xpZW50ICpjbHApDQo+ID4gwqAJc3RydWN0
IHJwY19jbG50ICpjbG50ID0gY2xwLT5jbF9ycGNjbGllbnQ7DQo+ID4gwqAJYm9vbCBzd2Fwb24g
PSBmYWxzZTsNCj4gPiDCoA0KPiA+IC0JaWYgKGNsbnQtPmNsX3NodXRkb3duKQ0KPiA+ICsJaWYg
KGNsbnQtPmNsX3NodXRkb3duIHx8IGNscC0+Y2xfY29uc19zdGF0ZSA8IDApDQo+IA0KPiBXb3Vs
ZCBpdCBiZSBzaW1wbGVyIHRvIGp1c3Qgc2V0IGNsX3NodXRkb3duIHdoZW4gdGhpcyBvY2N1cnMg
aW5zdGVhZA0KPiBvZg0KPiBoYXZpbmcgdG8gY2hlY2sgY2xfY29uc19zdGF0ZSBhcyB3ZWxsPw0K
DQpEbyB3ZSBuZWVkIHRoZSBjaGVjayBmb3IgY2xudC0+Y2xfc2h1dGRvd24gYXQgYWxsIGhlcmU/
IEknZCBleHBlY3QgYW55DQpjYWxsZXIgb2YgdGhpcyBmdW5jdGlvbiB0byBhbHJlYWR5IGhvbGQg
YSByZWZlcmVuY2UgdG8gdGhlIGNsaWVudCwNCndoaWNoIG1lYW5zIHRoYXQgdGhlIFJQQyBjbGll
bnQgc2hvdWxkIHN0aWxsIGJlIHVwLg0KDQpJJ20gYSBsaXR0bGUgc3VzcGljaW91cyBvZiB0aGUg
Y2hlY2sgaW4gbmZzNDFfc2VxdWVuY2VfY2FsbF9kb25lKCkgdG9vLg0KDQo+IA0KPiA+IMKgCQly
ZXR1cm47DQo+ID4gwqANCj4gPiDCoAlzZXRfYml0KE5GUzRDTE5UX1JVTl9NQU5BR0VSLCAmY2xw
LT5jbF9zdGF0ZSk7DQo+ID4gQEAgLTE0MDMsNyArMTQwMyw3IEBAIGludCBuZnM0X3NjaGVkdWxl
X3N0YXRlaWRfcmVjb3ZlcnkoY29uc3QNCj4gPiBzdHJ1Y3QgbmZzX3NlcnZlciAqc2VydmVyLCBz
dHJ1Y3QgbmZzNF8NCj4gPiDCoAlkcHJpbnRrKCIlczogc2NoZWR1bGluZyBzdGF0ZWlkIHJlY292
ZXJ5IGZvciBzZXJ2ZXIgJXNcbiIsDQo+ID4gX19mdW5jX18sDQo+ID4gwqAJCQljbHAtPmNsX2hv
c3RuYW1lKTsNCj4gPiDCoAluZnM0X3NjaGVkdWxlX3N0YXRlX21hbmFnZXIoY2xwKTsNCj4gPiAt
CXJldHVybiAwOw0KPiA+ICsJcmV0dXJuIGNscC0+Y2xfY29uc19zdGF0ZSA8IDAgPyBjbHAtPmNs
X2NvbnNfc3RhdGUgOiAwOw0KPiA+IMKgfQ0KPiA+IMKgRVhQT1JUX1NZTUJPTF9HUEwobmZzNF9z
Y2hlZHVsZV9zdGF0ZWlkX3JlY292ZXJ5KTsNCj4gPiDCoA0KPiANCg0KLS0gDQpUcm9uZCBNeWts
ZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

