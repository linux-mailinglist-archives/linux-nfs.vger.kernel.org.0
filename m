Return-Path: <linux-nfs+bounces-8697-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE649F9CA0
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 23:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE3D16A316
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 22:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706891A3BC8;
	Fri, 20 Dec 2024 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PhTqpqPb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2112.outbound.protection.outlook.com [40.107.244.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE37215702;
	Fri, 20 Dec 2024 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732851; cv=fail; b=rNdjX/k577cGiiyNFY1n0CfeiF5ktJsW/oy2DDp4GA2BsImFFArsXGrs2zgG30bVdRrF8WXIXHOwdrWO18Kc92kSz6Bx+8esiuPERmxItrcrC9dG1UtX5msK6bjFGeqJGb48GUxBmXCqta4lRrEP4I9jGyqGSDsoOEEGNwELy30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732851; c=relaxed/simple;
	bh=BUypZmvZ++oXhoZALIeg5hBdts4JMLQ4g36HOyjtosQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oLDBHqiX+RD1qE2un3EycVtPpgo7JDOyl811WRKRnFEsyo2onan0VpvYtMfOuqAFAw7OH77LFzw/OxcMIarGu8kACD50eO2Vmx9p+oZiWTrLfSVujz4mcT9H62hwkUH4YF9vrypcp7jHeljmGaJmvePNd5W3xmIVCMeq3rWGO20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PhTqpqPb; arc=fail smtp.client-ip=40.107.244.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3D0E1UrGVOrC/UGynKDKvXqP5GRLQjpEQj/tjw573EH9STK1x9rWUYCl1yw71S2NWh0UPaxKYhUSoxnMm9hZPJjyeC6JGUoMVuj3Z7ZGrvrGlpisPZ8CaV1HNffwL3eEdy+8IBT+My7ljIWpD5t9g2JSxX5KqH3CDu+slyGYQaxQHXrh9/1C0zGhkocd6sOa8pH3D31sUKuCB1a6Ujy/cj7oUFhOZAxu2ZOqyjUwerg3eKMuphOzGK+APyzWxYk6J7+gJlbFiU8Zw6XxT2ocdt27XF3dCcCxf11ThwKp1hybOjh209K1zhnLufDcWenUzD5Mwtsn49JynBoqcG8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUypZmvZ++oXhoZALIeg5hBdts4JMLQ4g36HOyjtosQ=;
 b=qNZXC1jN26cLCs0Gn/9pPigom6grI1G4OC70pCHQEUWqitFpSqzJaTWdLRltrjjd51Y34RKvj4AxqZb5tZ5W8THGQHVfz/S+YZ0mlWNeqmNBpCPQLZLCNUxpvzF4sha/Mc5OwKPZ72vrl+qlAe3aeUowP9xloWuwr/KOVhSqJuJkrDJulPBZF9SBDyruoSo0v2uT8e4Pzq4IQLhZBWZM+VWzSLwBMJikutokTSFzUspYl1ekMq6cVVdR3YJcURoeCdg0D2dFY4DbAQGBLYS1gcr3pQDWqGulw1jKiLj3gK7OaKPq/ANKrBmh82qpP7X40MESQujlS6vGlfQfoPiDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUypZmvZ++oXhoZALIeg5hBdts4JMLQ4g36HOyjtosQ=;
 b=PhTqpqPbd6HNIrPJzmAni23dz1KF5URmpPGDSWf0TXX6F+IKKKayt5qWqbiT/dMpRE/GRyV2YfpFrYzVpGzzG1Q23fqbY9YBxTmDidqdnpo03zEDd/3SttnBvFDH0ZGamYFaSSqKMn+Ml/h2J37NuxtCGUWJ2xfspEdjwu8aCn0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW5PR13MB5927.namprd13.prod.outlook.com (2603:10b6:303:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 22:14:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 22:14:05 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT  PULL] Please put NFS client bugfixes for 6.13
Thread-Topic: [GIT  PULL] Please put NFS client bugfixes for 6.13
Thread-Index: AQHbUyx7IC4MolvJKkiEgjeZq935wg==
Date: Fri, 20 Dec 2024 22:14:04 +0000
Message-ID: <10d898a194fa59e8f79ba08b24237c01a3f58a80.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW5PR13MB5927:EE_
x-ms-office365-filtering-correlation-id: a4f42d25-7009-4704-fccd-08dd21439dcc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3pjUndzY0Jzc1dsSHNveXE3RHBscXdTeEtQeS9XekwyQ0hsME1rekZPOWRW?=
 =?utf-8?B?bEw1bHZsVzJrL3IwTEh5eHdFSmZuVjIybnhiN1VRZEF6VmNFaXpDTENoVk1z?=
 =?utf-8?B?VlE5UUlWcEtGWHNKOFhYOVBaL0xYNGVDQUZvc2lXWGRsVzB1alUzdWZkRlZy?=
 =?utf-8?B?L3lNNzdQT1FHSzdBQ3ZVbG8yUTgwQXFxWTlFS2pZbjdmZEFMM2lCblhvZlJ6?=
 =?utf-8?B?MFZLU3A4eVJYcHErb2ZkTEZFWlN0aFM0ZWdzWUxEeFBhUkxkZ2J6cml5ZURZ?=
 =?utf-8?B?eVArR2pYTFNzZm5RN012TjdySTNkMHp3ZmZ1MmJPT2NUUzBPa1lrTFFxU3pS?=
 =?utf-8?B?VEVhU2VuWXdYTEtVL0xsQjdmd1VQenBQaU1zZzBVM1RYZldZczBaL2s2Z3pr?=
 =?utf-8?B?M1lJSTh3ZE5BNlBZT0VvYnRMd1p0OS9HVjlPRkM3UUk1azdXeU9WcExqZk5o?=
 =?utf-8?B?NU5mNE9WR3ZFM3hiaTF3clU4d2FlbDdHV0txQ1ZJUWxpMGVnRkUvNGlpU3pI?=
 =?utf-8?B?R08wZXdiaHpZVVplWTFsU1FwSmtyOXFqd0RwWEZFSVFlVXFDc3ZQTlN6dDBt?=
 =?utf-8?B?Uyt2cEFPZUk1LzdVanZQbyt3ZHNCR25TVGlLSXdWOFd2YUN4UGhSQzBQNTI4?=
 =?utf-8?B?SHo0a1NIcUJIcDFKd25HT1hYZDlJVWxNMXc1ZDR3MWwwdGs3MDZORTZCZlhn?=
 =?utf-8?B?UjVFQUZzRTBhdW5mNmlua3d6Yjh1Tm9CbHpIREFmWVhZMVBhd0c0YmxKUm5E?=
 =?utf-8?B?dEI1RWNTK3FqMG1CL3d3UkFDbVU5MkdKdlhSeUFld3c5Kys2NGo5dGxGN3Qy?=
 =?utf-8?B?b24vczlMRVFicjg4dXFVTE56YXQwQUhkL1E1Ympmcy9hMFZFalVyeU12a29B?=
 =?utf-8?B?ZEZPZFp1Z3QrdUVYSURzSnF6K01hMjM2ZEVUbUpaMER5OHgyRE8velVEU1Bx?=
 =?utf-8?B?UmU4cW8zYm9kaCtoNjZ5ZDBVYmNjbVJrdFFsY29sNUkzRm5mMXRVcVF1K0xE?=
 =?utf-8?B?enU2TS9pU3dUUG5VOFREZzVSSXJ0WVUzZGRPSFpaM0tXL0xES2xhOVRSRWJH?=
 =?utf-8?B?V0t3b1dhbXRkaVdPZ21zaDg2Rjl4LzlMbGhtdGxOc1ZWZjNnWnpSSmdDbnh1?=
 =?utf-8?B?TC9uOVRwenRqcWFXTnNZMlhvdVk5Sk9kT1B3dnlHbEpaOGM3bVQyTnJyUk8z?=
 =?utf-8?B?Z3pRWlNLdytRYklEM01URHJWZHJhQkRTaGhRWGszaUdMZWhTcXVZU0xmWVZJ?=
 =?utf-8?B?cm9NcGkvZmNSdzI2MEt2Mzc4dVFmZGlicTN2bVJraHJNRkF0eXhGU1lhUGtq?=
 =?utf-8?B?WEVWL0ZsNkZKWHNmSjV3N1RaQTY3RzdaTmxsMThPU1B3OCszN1VyRHE4S1B5?=
 =?utf-8?B?bjlhN2tib0pXelRlaVZBeW53MUVmdmpxcHhYa0FBek5aWkd4L2szWDZLbE9Y?=
 =?utf-8?B?TTNPRXA1eVdkM0h1WW45ZGJBVWduUkp0SWRkdEFqcVZrS1kwWVdqNmIrMzdO?=
 =?utf-8?B?OEl5S1lPTzV0b2FpZlVtemdiek5FNGI2SHI4Y2hhNVg0ckZIWVVOZWVYcXgy?=
 =?utf-8?B?UEZPT3RtdDR4aWZIRGRXSzNoTjZ6L3EySXZVQm4xOElOaEQ5WnJnNEtJNWVh?=
 =?utf-8?B?ZC9KMXdiY2x5dFJmRTFXNGs5RU1oMmo3Y3ZWVExzdFBRaHhvN2VNQ01OWGhT?=
 =?utf-8?B?bStyVjE0WWxVcCtJb3BjR1BUcWEzaWtlS051UEdPNFFFU3A0QmQ0MUp6NXR0?=
 =?utf-8?B?Mkptamd2R1hycTMvYUYwaHFSbkh0Q2ZFSUNFUzBaMVZvY3NEdGRaV09ZcUhM?=
 =?utf-8?B?OW9weHRwUUM2SUFxQVpYa3VpUWVXNGRsWFg3Y3JoRllEWGQrS3hOZk8wMFRC?=
 =?utf-8?B?em5RaW1sS3pqbDViR0xtMVBTMlR2K3p2eTl4VDhIaFoxNlJ4dGt1UVJOWVNl?=
 =?utf-8?Q?SDOy2RnfW3dryN3kp+qqDHPQIlUvS0jy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UE5qeVV4SHhzVng2Z0I1VHRzWW5KbHpucncwSFZlMm9hclJmSnF5L3pDZUVu?=
 =?utf-8?B?NFBITHdETHdlVWliVmNldnJsZUlLOHFFSlRyck9TelJIV0Z6OGFUQ2NCdHZt?=
 =?utf-8?B?UEc3eTJ4Mnk4bUZpeE5Fbllnb0QrQVNMMTNiTVo1LzJDZXI5SnBRMVI5aWNQ?=
 =?utf-8?B?ejdndG5sbUhTak1NMGpkcGYvbnA3R3AxdTFja2I3bnc3Y0dUZXNHaUtrNWVU?=
 =?utf-8?B?YzBRYmg2S0NTS3NpKy9HdW84SHRzdzdKRVQ4T0FsTHlZSVkwWXorK2tCNUN6?=
 =?utf-8?B?RC9VV2J0K1VvV0Z3NUlPbkZ6M1FhOFRSOExWUng5ODZNczhsWlRQckVzakFK?=
 =?utf-8?B?UXUrZmo2UzdMWERidmIvamxyd3A5MkxEdTZjNFdYNkNKOHU3Qy85amx3U3M5?=
 =?utf-8?B?OWdkZWNJVHJIbTBjRXpaTnpQdjZYbDFUUTdkaUoxellMWFdFc3Jvd3ZIZ0FS?=
 =?utf-8?B?Y2duVlcydGdQRWNJem0vdUVLN1lWSkdBN1NKUDBWbkZtaXJuNkt0T3NwZ1ZR?=
 =?utf-8?B?bWZyZFVCTUdoZnQ1ZjREcTBXWi9aR0tadUx5a2ljUVY0SFdmS2FPSkRNWkR1?=
 =?utf-8?B?Z1dIYUZiSUFzTVFrbWFJbzhzTFBUTEhseGI4WXM0ZkRUNUlwbnN6VGFGUEYv?=
 =?utf-8?B?T2xheW9qN0dYWmIrOGxTQUlzT3JFZWhoOVE2bVVYeFI0aStUSk5XR3JuTVA2?=
 =?utf-8?B?MVhPWE8rSU9Kb1U1a2cwWjl2VS9IS2FJOXJha0lsUFR3NGlGMmlYN1o2TkJs?=
 =?utf-8?B?Ny9PN1EvM2ZhbzgxS0VBOVE0OFRaa0dzc09JTkpTd3BETDk5Tkpjem5CODh5?=
 =?utf-8?B?RytCZHBvTFJzS0p2a0ZRRVlZV1g0UUFWYyt0bjRrU21oZVNteTNvd1dtUjZj?=
 =?utf-8?B?NmZaWEMzNjNBaldaNFFNRll2WElUMzlYVHpnRHplQUowYXlUa3NFWU1Jd3R0?=
 =?utf-8?B?aWVUVVV3eXFKQmVpaFUySXkvSkI4NlhXbnFEQngwdEd2UGNuS3RQb1hkMUZY?=
 =?utf-8?B?RUFVNHEvSktyYkxZVHZSRjNFVm90eU5pMEFRRmJJSTFkTkFjdTc1YlFlaG5l?=
 =?utf-8?B?WitiMEE4NkxzRDQ4QVo3WVN5d3RDaTdFQ2ZnU2ZjVzFKUFBJMFVwYmljRm9P?=
 =?utf-8?B?ZXRVK0hhN0lzNExqK0grcTZDVHJ3VkYwVjhKeEo2b2tKZzdVSE04QXVwdWRO?=
 =?utf-8?B?eG1iNDV0TGYyZm9pSjZ1SDRoRTR3enZzdTlRdGpCTUFOTGE5Rlp2MXQrRUFX?=
 =?utf-8?B?WkZhWDRhWW9PTWZhNS85ZlRlZHRBWnFzdCswMnhzdXpHR2FtbHVWWW5LVE1w?=
 =?utf-8?B?d29iYUV6NkVjZzl1L3lGcTdRc0toSUxBd1crN1pOUnFOZlRwWWZOVjl5eGFu?=
 =?utf-8?B?UVlUSmd3Q0Q5amdQT2o1NHJITVhGdlF2bkY3VEVpTkFTU3RYS1RRSWdMNSs0?=
 =?utf-8?B?WnBydXdNeDFPU1NzWU9XN3B1TVNySjFsdUQyTjRQWXVVZ1ZJQ29OTE1CeWxt?=
 =?utf-8?B?UXZRNjdrd3VaYUZ4aUZjZklRZ1hPUVNQT0d5RDN6cUpMbC94Um5Hd2diWGp0?=
 =?utf-8?B?OWFjcFhrOXo0dHV3OStmQUtldFVMK0JpMHphVTdzRVFMMEl5enNGUFZQRUJa?=
 =?utf-8?B?cVU5bVVMMkN3bTM3dkhVSDZMVW1IdXhnRG10amhqYWYwbThzdEdxTi9vK284?=
 =?utf-8?B?NVQ2VytpYTBPdjRLWm5LQkdna2xZU2ZaeUtja3FiQmtxWjBIdkNVMU4xNnJu?=
 =?utf-8?B?b2k4SXAySlJ3d1NsSTlEcEhwRGxoRzlHNkQyb0dnZU5UMWR4Zm5RYVBpMlBp?=
 =?utf-8?B?OVQrQmNZaU1PZWFoVmVjUkRxdUtsZGMyRExkTWpWbnBFaHhEdy82ZDE2YnJk?=
 =?utf-8?B?aUNoejlVdnNwcGtRT0ZqMy8xdm5hTmRwd2Y1VGVkWExHWXpCUFdpT3FTNG9s?=
 =?utf-8?B?MWtLbUlDdCs0QjRVZGRSVFFsQVJpanoycDNLdnFsdFh2MjNabzRqZmJUeTFF?=
 =?utf-8?B?YmRaZUpRZnc4MUcwRHBkQWd3SE9EMlhxcFZTVGlXV0RweW9yem10eElOajJF?=
 =?utf-8?B?c292UTVGc3pQUi9HTHBERGdQeUUzSFBFYjErRC9VM0hYNmRUOS9wZlFydno4?=
 =?utf-8?B?SWpKV0tubm5EL2FHMUZmSkwzYWtVQkovNndvd1J5VzRweHRqODhNMUJEMWZK?=
 =?utf-8?B?OEYreENDU3VVdlBKTitnMGNLOXNBTmQxWUxjeWdTR2VMTU1TY3E0aFl3YWFw?=
 =?utf-8?B?YWh2YjRYak9RSy9wUzdwc0pXU0pBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6FE5A5500627D46B6F1CF45004FADEA@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f42d25-7009-4704-fccd-08dd21439dcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2024 22:14:05.0079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j0I4u6Xg/uh40l2V8Za590lZxrlbQA9uqo/CXMkWx88G6wHM+D3LOwy/by/5JDdbFUap2WhCnuER3raZfiZzSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5927

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNzhkNGYzNGUy
MTE1YjUxN2JjYmZlN2VjMGQwMThiYmJiNmY5YjBiODoNCg0KICBMaW51eCA2LjEzLXJjMyAoMjAy
NC0xMi0xNSAxNTo1ODoyMyAtMDgwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMvdHJvbmRteS9s
aW51eC1uZnMuZ2l0IHRhZ3MvbmZzLWZvci02LjEzLTINCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFu
Z2VzIHVwIHRvIGJlZGI0ZTYwODhhODg2ZjU4N2QyZWE0NGUwYzE5OGM4Y2UyMTgyYzk6DQoNCiAg
ZnMvbmZzOiBmaXggbWlzc2luZyBkZWNsYXJhdGlvbiBvZiBuZnNfaWRtYXBfY2FjaGVfdGltZW91
dCAoMjAyNC0xMi0xNyAxMToxNDoyMCAtMDUwMCkNCg0KVGhhbmtzLA0KICBUcm9uZA0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KTkZTIGNsaWVudCBidWdmaXhlcyBmb3IgTGludXggNi4xMw0KDQpCdWdmaXhlczoNCi0gTkZT
L3BuZnM6IEZpeCBhIGxpdmUgbG9jayBiZXR3ZWVuIHJlY2FsbGVkIGxheW91dHMgYW5kIGxheW91
dGdldA0KLSBGaXggYSBidWlsZCB3YXJuaW5nIGFib3V0IGFuIHVuZGVjbGFyZWQgc3ltYm9sICdu
ZnNfaWRtYXBfY2FjaGVfdGltZW91dCcNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KVHJvbmQgTXlrbGVidXN0ICgxKToN
CiAgICAgIE5GUy9wbmZzOiBGaXggYSBsaXZlIGxvY2sgYmV0d2VlbiByZWNhbGxlZCBsYXlvdXRz
IGFuZCBsYXlvdXRnZXQNCg0KWmhhbmcgS3VuYm8gKDEpOg0KICAgICAgZnMvbmZzOiBmaXggbWlz
c2luZyBkZWNsYXJhdGlvbiBvZiBuZnNfaWRtYXBfY2FjaGVfdGltZW91dA0KDQogZnMvbmZzL3Bu
ZnMuYyAgfCAyICstDQogZnMvbmZzL3N1cGVyLmMgfCAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==

