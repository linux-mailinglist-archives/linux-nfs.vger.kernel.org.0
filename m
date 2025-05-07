Return-Path: <linux-nfs+bounces-11588-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECA2AAE804
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 19:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849031C4261A
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 17:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEFB28C5C1;
	Wed,  7 May 2025 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b="vE9TnXBs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BY5PR09CU001.outbound.protection.outlook.com (mail-westusazon11011071.outbound.protection.outlook.com [52.101.86.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532928C2D1
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.86.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746639564; cv=fail; b=FOjbKZN9jdEM8z9SodmKpg3JII56/sstuhaUFARs6BAGGxim33pYThwuIgtQsJafs0kARKFA83Hx68xffDaTof+F7Jh5zpmT+IUW6K3wAE2+fUs5rXuFRgtqZ18wlX9KfSEjVy9zkwkzQZjKYCsEBnmFbeyeKDu6aMuzuDBrpQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746639564; c=relaxed/simple;
	bh=DoDoMtnBTtL2kwlq9namyKhvqPfeTsQsqrGN6NXp5wI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QU++fZsewvmM2cApd2BOt9SNPcJ1UXWts/zKD3vUsvFvXYig6UGeay3y71AT4o+YNjwb+rR6fy4hVBAs7BWwi+BAnu2sD1uEdyEw4oNE42nCkEDg/BIUDMRfYS1SgNC7OwNNpioZedbnwx6ub81NOtxTsJ/niUlujlkvg5cuUzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com; spf=pass smtp.mailfrom=nwra.com; dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b=vE9TnXBs; arc=fail smtp.client-ip=52.101.86.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwra.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT4/l+q08AzfXxoW8NZ1Egztml+jJh0fWghU+U3vMpBwLjset07ENuk6xV7UESOqEWoXs8wHbVxd8sTXJc48GIbN6qi5JQxpa4E2DBqb/P6grD81xkJm72KLXCIORYF5aXfPTehf7oyA8+Iue37XNWMUiwVvUr95PMvrLxlKa6XK298BQf/CXY+wQp13B97BqzEEazr3E5JkYLcKJey5vjraGiB0MvIFmeqDIkw2L89lH5veuQA30Gfi19dpsw59oToIdLdAp8upSJydzdpWGC51HzUbfJpGYtCmFg3Sf5PfbnBQ5P6KbWe1GD8nGfsI8kZgCDlBVLnKQQgWCPs4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsNcSGx/RAIr9pOY85CA+d9KSaG+WakwyFkM0pX/XwQ=;
 b=B5GH5weR2QG0fve9o1hrivxwfBpfV8JGhD7hpd8mQ+//+hKF8HtV7uKFjsNv/jGOuMirIgHRwxdw2Q+GNymwZR1PunBgjfMz4RqP7AJB4KhBG3GFznQ8wJG8Od7X/tH6mcW7Y5goT2kWui9RQm7sDTG/vaIvQXNNpmUJdNfQrvv3k0MvWNCkmy/kBpj1zE59EB3OmWC8h9LjHZhfjePVkDVpZyubK+d00fowL7xzAHmvebYV7ovX4ozE6BMAfcqMft5kWAj6MFJe6beFMXZQ0fYJa7bLasswmL3OSrzSOVcOYA5fqAptIR/gN6QU0xasgXPNibR5RtKt7AYkmM0ksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nwra.com; dmarc=pass action=none header.from=nwra.com;
 dkim=pass header.d=nwra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nwra.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsNcSGx/RAIr9pOY85CA+d9KSaG+WakwyFkM0pX/XwQ=;
 b=vE9TnXBsb93/vYGBn2EzLc0IERLITo9Fgq1vC5rbu+cjXC2RR9Pt0mAstdUN72z49VnOb2brrsHW5fYvdLnWQHt4pCq3a70yFKWB4duuSlSFaD+yALdlxQmtk1qZFuzMrF5w0x72ohUcYP/PVmWkdLaqvnwo91Z41o/XEiecEsq3xArSI2R9TWUen9rflOdmcTXuWF70RmFXq7fi5KudbZhj7NJgwfjUHM6T2udZ8QtP1t7I+XU2L2yN5zsmcGLM9HanvpAxHyqetQwhxkkH2IWvfyFES0r61JtRCi6ozPcP8YV1oKNaEt9hiPtfWpqMlmdgz0o0gSQWnAwLs+/IIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nwra.com;
Received: from SJ0PR09MB11875.namprd09.prod.outlook.com
 (2603:10b6:a03:51f::10) by MW4PR09MB9297.namprd09.prod.outlook.com
 (2603:10b6:303:1f3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Wed, 7 May
 2025 17:39:15 +0000
Received: from SJ0PR09MB11875.namprd09.prod.outlook.com
 ([fe80::30e0:339f:805:2779]) by SJ0PR09MB11875.namprd09.prod.outlook.com
 ([fe80::30e0:339f:805:2779%3]) with mapi id 15.20.8699.019; Wed, 7 May 2025
 17:39:15 +0000
Message-ID: <62ed2e30-30ba-4b45-b602-14da6f29e9dc@nwra.com>
Date: Wed, 7 May 2025 11:39:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: Trouble with multiple kerberos ticket caches
To: Daniel Kobras <kobras@puzzle-itc.de>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <c4ecc067-9a51-40c8-9300-29119ff2e1d0@nwra.com>
 <e482c8e4-2939-4ef6-a004-e23fcf5e666d@nwra.com>
 <c123b772-ab05-4333-a868-c409c03fcfa2@puzzle-itc.de>
Content-Language: en-US
From: Orion Poplawski <orion@nwra.com>
Organization: NWRA
In-Reply-To: <c123b772-ab05-4333-a868-c409c03fcfa2@puzzle-itc.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090400000608050602090306"
X-ClientProxiedBy: CY8P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:46::23) To SJ0PR09MB11875.namprd09.prod.outlook.com
 (2603:10b6:a03:51f::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR09MB11875:EE_|MW4PR09MB9297:EE_
X-MS-Office365-Filtering-Correlation-Id: 62154c5d-31db-45a6-32ab-08dd8d8e15df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|41320700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHVjMzF4RFhyRHdJNWYvNlNUMjFLTXNIY3BzTXdxcUNreEdHVEV5czZhM1Fa?=
 =?utf-8?B?dGtIVHBoQmNIMVIzNktQR1N6bHBOWXlIL0kvMjlqSHBaNTBjaHZXR2VVM0RJ?=
 =?utf-8?B?aDg3YzNLbW9aV1kzYTJvZHV1eHE2ZldjclBnQ2FsanR4RWM0czNkU2dUcnpI?=
 =?utf-8?B?b3QycTdJZWkwRnJ5SHRtSzAzaXMwMU0rYjBCTWROTzFOSjRUbmhrOUNGZW94?=
 =?utf-8?B?cVBTckhhVFNZVnZPQVk1dzc1NXF4N0lnbjBVWW4vWTBBYlVGSkkxQzJkNTVj?=
 =?utf-8?B?bjh1QStHOWE0Vk1PbXF0a1NFcC9ZS01UZExxRndoZXZHNlUxUzV1Ti9YS2s0?=
 =?utf-8?B?MHRUaGorS2l1STh2ZTVwUk5oOE5JMjdVUFk2bkhiYmF5bmVpUVB4UmFHTVhu?=
 =?utf-8?B?WGlJdC9oRVdmSEFucG93NHBMckd6SWd6MHpYeEtaTENRMytBTWVjMW4xYUZR?=
 =?utf-8?B?RHBlUUJiekdZUmNlKzZiSDJvbGhLaTBOcHJNT1AwY2VLQ3d0dzJ2MzkzbDBW?=
 =?utf-8?B?K2liOHNDeFMvWU01bjRJU1l3NXFESlJYTWhwaStNZlNOSXk0ZEZxSHI5NXRo?=
 =?utf-8?B?TkY2ZmdnZ2lva3l6SEVva2x6SEpXTzZRRU9ZR1cvMGx0QmViYkVmR0h1MGpB?=
 =?utf-8?B?c29ueDRjMVN1VEVUc0RlV0V2QVQrZnpUaHlSY2tqQkxGL0xQZmNoTFRDUWJ4?=
 =?utf-8?B?MFI5TXZWZEpOejA4WnZaWlZZUWQ2RUNMRi9HdGx4REV2a012VUdmdGZDcHF4?=
 =?utf-8?B?MUlLemhMaWVGNnltbVM3NXJ3WCt1Q0R1dUxzTmhXcGpmaWdUZTNiZkQ0blFp?=
 =?utf-8?B?ZmN1emZVMUhQK1ZOT1psMzM2M1BBUGNoa1FOTkZKdHNsV0xoVUROZ2R4U0to?=
 =?utf-8?B?eG9OQzVxTUl4RHorR0Zvcms2cDRhcW5DSEtHRXBzYmtHOUxCbnVLMkpoQWV2?=
 =?utf-8?B?a08wTmhnM3E3REtMNzV1Mkc2U0psdkZYWXE3UXJsL3B2MlVabitEQkJ6b3FB?=
 =?utf-8?B?QkpNSGtVNGVHUkphaHpIWlhNblFVWkZ2Q29MSGZZUW5MN1hFM2h5NFU0alZh?=
 =?utf-8?B?Q2NRQkRQS1VXMDFtRWV1U0RBWE9PNng2MFNnaGdEMTR3NHlJSTJ6QmU4bjNK?=
 =?utf-8?B?OEhqY2tCMTB6UGlUVmxwQXJTMG1pNE1EMThJQVl3QW5XY1lUd1d3dGNoaXkr?=
 =?utf-8?B?MG0vb2Fqd1hxMXp1NjF4aGtqb3NOdENNcm9WQVQwdzdKdzkwSndSdHhIS0ZD?=
 =?utf-8?B?TmlaeUcvY1gzWU1WSU1BR01OcUlQQ0IxbldkSlRiMHMvTXBvczdFM2paRHBM?=
 =?utf-8?B?R0c5TWxWMXVXTzNvVDZROU9xMlJSeVkxYzJKN0RrQ1hSQ010WXEzOXVzVG1I?=
 =?utf-8?B?YURBeFlEWjFKUGlzOG9iSEdSTXZLYU1NTW9GY1BQOWdWSGNPeGRaZUdWdGRn?=
 =?utf-8?B?Y2lSS2xMWlpMSWdrR2IxQUdVemViOE9CbCt3QXE2UUI1bkx0MHh6U1VHVVlG?=
 =?utf-8?B?aFpZV1UzWndndVE2d2wxNyswUnNPeklseUZPcW5QN3I3M1B4bWpFMmczalRZ?=
 =?utf-8?B?cWZPOXpodG40TTQzVFRzSCsyY0p0Yys4MStENWk1UmRCejBjQ3U0em1MTHdJ?=
 =?utf-8?B?MkNOZFQwejB4THNqcnczTlovYy9CTHpPQXkyL1ZTTjRCRy9FUU5oY093QjhF?=
 =?utf-8?B?MWZ3eW1jUVJYRmpFRW1NWGtkdFNMa0xRUXl3ZzkxSS8rNmlSejZpZHRHaWM0?=
 =?utf-8?B?SXdPWDN2WHZkeGNNT0NtdmY0bVRDUDNOeGNkeE5NaVFsRzRVd3M2MFpxbk9j?=
 =?utf-8?Q?DOnoMeAKrWCkV9mqKItKJzEJHqOuAmaONs8iI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB11875.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFgvUmljeEtBcHFNRWcrYjlaVjZCMGhmMmdrZDUxNXJVQWRnMzAvTlEyakEx?=
 =?utf-8?B?RWIvMEI2SnF2M1JtS1lINy9vTHR0STN1am5sYWpiblpnVW9DNk1ZckZNd2Jv?=
 =?utf-8?B?TFRMand5VklxcDhJK0lxNUxlQitsQUFCMkJxQ3c0NzZadjF4aHNybUZRY3Jh?=
 =?utf-8?B?bDdpU1liQ0kvMkt3R0s2d1pWT2d4ZFFvZkMwWU9pNmtBRE1rZ0pxTHhGRFQr?=
 =?utf-8?B?U3E4a0xxR2FnK1BvaklSaHdmWDQzSkErWTNwbzZTazlnN0kzZVQ4d3pEUjRv?=
 =?utf-8?B?OHltWkc1TGxheDlxN0xGMlU2OHpFdkZTRGxmSGNWTXFyYjRGcVl0Rm9BVHND?=
 =?utf-8?B?KzQxamtkeW9CaXpDZFYzVnZ1UzlTMkNtaVhWWkhWbDl4eWtwV0pMSGtUK1Vp?=
 =?utf-8?B?bDl4SUZHMDFSOEk1dnZ1cm9JZDJyQnE2azZnWnB0UU1mZDZEWFN0U2xTeXZp?=
 =?utf-8?B?SE1BUW5UTUhSOWJMdXNGc2NEOHpSSy9HR3pVUEEwRm1VWEZDMUF4V2w3ODlF?=
 =?utf-8?B?UVpZRmFPSXJqWXFzcnhzRm42MG84N3VVeGQ3aGJnSDl4U0FWWS83Y3prWlM4?=
 =?utf-8?B?UGY1VWJ6T0hVSzF1MjZaNlRhL2NLZ3d5cVNBSlRUd2hUWXQ0S1RkalNOdVlw?=
 =?utf-8?B?cDIrM0JDWW45a05pdzdiTFpIa2tzQkZ6NXFDZXEyaWZDbUcvdzd0U0FvQTQ2?=
 =?utf-8?B?c0RyNEgzeFdQV0R5alZqdUl4bS9BV200K1hhTk9QM0lZajY1OEx0YlZaaE94?=
 =?utf-8?B?c1dZazBCY3pzenRDK2RwWmZrVEV1NGU2dXVnN2NXSHFObGc0YmNaWCtITm1z?=
 =?utf-8?B?SlJzM2h3UVAwTCtwcGNqUm92SDJjSkMrN0ViWHpxOFU4NWZVK083ZVdwNUJn?=
 =?utf-8?B?eVFrRkJhSFFMbHdtTFNsb3d6UGZPaUNnUXEzQ3hUZ2psalV5VDFWRTAvUDdB?=
 =?utf-8?B?MHRGZm5mS1E3Uk01Z05HeFZTSks5Tm9XcHg3N3BoeTBIRjcvZTFUcGZ2dEZV?=
 =?utf-8?B?UEVKdEs5N1dYZ24zQ3YxY3kxOGF6UVFXRlVUY28xQlo1bWxuUFJ3c2kyNVZs?=
 =?utf-8?B?UWJkQmhCQXNYYUxSRnJiSXNra3hjekR4Y3VRQW9pZm9Tb1NpdWcwbGFwOTE4?=
 =?utf-8?B?aFk5L2VoNUNGMU52QWNESFFWTFVLV045STlRNzF6eEhOMGprV2VhNTJDR3dO?=
 =?utf-8?B?VzNlcER4cE4rd0cxWERwbUtJMEp2eHRocTlraDcwcXBHK1czVnZYdmFuVjNG?=
 =?utf-8?B?Tlo3dnp0SHhCZHVHRlNJM2dxWFE1RTArN2RYUW9CZVBqT3VQNnc0aDJ2UjdE?=
 =?utf-8?B?N01hTko1d3diaHlCTXY0am8rcTdrNUJSb1ZhRjdRYzVJOE9MUllVRzFNdVlU?=
 =?utf-8?B?cU0rMURmYXZmbmpyaktCdDllcTh5YWtnRzNsVjlSQ25EOUMxbEczV0hlYTd1?=
 =?utf-8?B?L3pUUjhyOFpBN0hGVVMvMjlIZll5ZVZTWlROY2crQzFCdDIwRi9ubDlLOE5F?=
 =?utf-8?B?TXYrcklHZHZxWVZLdEE2VllhV1N0THRoY21mbnFnK0NjTmdXcXpleWhQVC9H?=
 =?utf-8?B?WGpaYVA3MjJwT2xGTE1Od3V5eWNjYkM0dHlSRmVNbExxM2dhNGZGbGhMMTFz?=
 =?utf-8?B?SjRNMkNTdDllUXAvdEowRk5wSUdLaGQyZG1oRE9xZXV6aVlqWFNFeUpFUllu?=
 =?utf-8?B?eUxobWQvOTlud3JYR0pUaXgyWmtad0JpeDlhaXB6SFhKaWUrdE1GWFpJcWNQ?=
 =?utf-8?B?VjdzcWlTTHEzS2N0eFJqWldBak9LM1NLWm5wMStSWVRTVWZZdFRQUDRGU2x1?=
 =?utf-8?B?aytCUVd2dlJyTXNvdG1hOEpMTVFTSVFmb1lONTlKNHpLZ3dXdFJsZTRhbFdI?=
 =?utf-8?B?eHhZVzA2TXo3endRd1YwaDVpVFFQaUpJNUhNZ0EvcFJlTFVnSWtKbjd1K0VD?=
 =?utf-8?B?eTZoWUJmRUNOdmtzV085Nm44T21GM0Q0ZVovSFFsOHBEbUVucHUzOVNPeEth?=
 =?utf-8?B?YnlTUXRxSE1ZOHI5VHpKMVg4RTlnL1pGTkhWVlRYUjd0eEdLWWNUbGJiRnNF?=
 =?utf-8?B?dHN6Tm9PN2RUempvSlhXNU9RUHhCa1ZZMFM2SXRGOHMxbVVDZVhHKzFwSmRW?=
 =?utf-8?Q?ut8LJI1lR7xVI2p7F7CQxUPEJ?=
X-OriginatorOrg: nwra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62154c5d-31db-45a6-32ab-08dd8d8e15df
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB11875.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 17:39:15.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 761303a3-2ec2-424e-8122-be8b689b4996
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR09MB9297

--------------ms090400000608050602090306
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 5/7/25 10:57, Daniel Kobras wrote:
> Hi!
>=20
> Am 06.05.25 um 21:54 schrieb Orion Poplawski:
>> More details.=C2=A0 The issue seems to arise when doing gssapi delegat=
ion from a
>> macOS client to the Linux box.=C2=A0 If I have ticket on macOS:
>>
>> Ticket cache: API:427671FC-DB63-442F-ACA4-13A9194F4398
>> Default principal: user@AD.NWRA.COM
>>
>> Valid starting=C2=A0=C2=A0=C2=A0=C2=A0 Expires=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Service principal
>> 05/06/25 13:29:54=C2=A0 05/06/25 23:29:54=C2=A0 krbtgt/AD.NWRA.COM@AD.=
NWRA.COM
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 renew until 05/13/25 =
13:29:50
>> 05/06/25 13:30:30=C2=A0 05/06/25 23:29:54=C2=A0 krbtgt/NWRA.COM@AD.NWR=
A.COM
>> 05/06/25 13:30:30=C2=A0 05/06/25 23:29:54=C2=A0 host/host@NWRA.COM
>>
>> and ssh to the Linux box, I can't access the nfs mount:
>>
>> -bash: /home/user/.bash_profile: Permission denied
>>
>> Ticket cache: KEYRING:persistent:30657:krb_ccache_efgrZpc
>> Default principal: user@AD.NWRA.COM
>>
>> Valid starting=C2=A0=C2=A0=C2=A0=C2=A0 Expires=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Service principal
>> 05/06/25 13:30:30=C2=A0 05/06/25 23:29:54=C2=A0 krbtgt/AD.NWRA.COM@AD.=
NWRA.COM
>>
>> I also notice that the ticket is non-renewable.
>>
>> If I then kinit I can access the home directory fine.=C2=A0 Other than=
 the new
>> ticket being renewable I don't see any difference:
>>
>> Ticket cache: KEYRING:persistent:30657:krb_ccache_efgrZpc
>> Default principal: user@AD.NWRA.COM
>>
>> Valid starting=C2=A0=C2=A0=C2=A0=C2=A0 Expires=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Service principal
>> 05/06/25 13:31:27=C2=A0 05/06/25 23:31:27=C2=A0 nfs/server@NWRA.COM
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 renew until 05/13/25 =
13:31:22
>> 05/06/25 13:31:27=C2=A0 05/06/25 23:31:27=C2=A0 krbtgt/NWRA.COM@AD.NWR=
A.COM
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 renew until 05/13/25 =
13:31:22
>> 05/06/25 13:31:27=C2=A0 05/06/25 23:31:27=C2=A0 krbtgt/AD.NWRA.COM@AD.=
NWRA.COM
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 renew until 05/13/25 =
13:31:22
>>
>> Actually, I also notice now that there is a krbtgt/NWRA.COM principal =
as well.
>> =C2=A0 I wonder if that is the difference.
>=20
> Can you please check and compare the output of 'klist -ef' (which inclu=
des
> additional info on enctypes and flags) in both cases? It sounds like th=
e macOS
> client is forwarding a ticket that is not accepted by the Linux client'=
s krb5
> library. This could happen if eg. the default_tgs_enctypes configured i=
n
> krb5.conf on the macOS side is incompatible with the permitted_enctypes=
 in
> krb5.conf on the Linux side.

That does indeed seem to be the issue - but it seems strange.

On the mac:

Valid starting       Expires              Service principal
05/07/2025 10:50:16  05/07/2025 20:50:16  krbtgt/AD.NWRA.COM@AD.NWRA.COM
       Flags: FPIA, Etype (skey, tkt): aes256-cts-hmac-sha1-96,
aes256-cts-hmac-sha1-96

On the Linux box:

Valid starting       Expires              Service principal
05/07/2025 11:17:25  05/07/2025 20:50:16  krbtgt/AD.NWRA.COM@AD.NWRA.COM
        Flags: FfPA, Etype (skey, tkt): DEPRECATED:arcfour-hmac,
aes256-cts-hmac-sha1-96


The linux box has crypto-policies:

[libdefaults]
permitted_enctypes =3D aes256-cts-hmac-sha384-192 aes128-cts-hmac-sha256-=
128
aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 camellia256-cts-cmac
camellia128-cts-cmac

Shouldn't that prevent it from ending up with arcfour-hmac in the first p=
lace?

I tried adding this to the mac without any change:

[libdefaults]
permitted_enctypes =3D aes256-cts-hmac-sha384-192 aes128-cts-hmac-sha256-=
128
aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 camellia256-cts-cmac
camellia128-cts-cmac
default_tgs_enctypes =3D aes256-cts-hmac-sha384-192 aes128-cts-hmac-sha25=
6-128
aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 camellia256-cts-cmac
camellia128-cts-cmac

Thanks for the reply.

--=20
Orion Poplawski
he/him/his  - surely the least important thing about me
Manager of IT Systems                      720-772-5637
NWRA, Boulder Office                  FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/

--------------ms090400000608050602090306
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
ClEwggUVMIID/aADAgECAhEArxwEsqyM/5sAAAAAUc4Y4zANBgkqhkiG9w0BAQsFADCBtDEU
MBIGA1UEChMLRW50cnVzdC5uZXQxQDA+BgNVBAsUN3d3dy5lbnRydXN0Lm5ldC9DUFNfMjA0
OCBpbmNvcnAuIGJ5IHJlZi4gKGxpbWl0cyBsaWFiLikxJTAjBgNVBAsTHChjKSAxOTk5IEVu
dHJ1c3QubmV0IExpbWl0ZWQxMzAxBgNVBAMTKkVudHJ1c3QubmV0IENlcnRpZmljYXRpb24g
QXV0aG9yaXR5ICgyMDQ4KTAeFw0yMDA3MjkxNTQ4MzBaFw0yOTA2MjkxNjE4MzBaMIGlMQsw
CQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1
c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykg
MjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxDKNQtCeGZ1bkFoQTLUQACG5B0je
rm6A1v8UUAboda9rRo7npU+tw4yw+nvgGZH98GOtcUnzqBwfqzQZIE5LVOkAk75wCDHeiVOs
V7wk7yqPQtT36pUlXRR20s2nEvobsrRcYUC9X91Xm0RV2MWJGTxlPbno1KUtwizT6oMxogg8
XlmuEi4qCoxe87MxrgqtfuywSQn8py4iHmhkNJ0W46Y9AzFAFveU9ksZNMmX5iKcSN5koIML
WAWYxCJGiQX9o772SUxhAxak+AqZHOLAxn5pAjJXkAOvAJShudzOr+/0fBjOMAvKh/jVXx9Z
UdiLC7k4xljCU3zaJtTb8r2QzQIDAQABo4IBLTCCASkwDgYDVR0PAQH/BAQDAgGGMB0GA1Ud
JQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjASBgNVHRMBAf8ECDAGAQH/AgEAMDMGCCsGAQUF
BwEBBCcwJTAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwMgYDVR0fBCsw
KTAnoCWgI4YhaHR0cDovL2NybC5lbnRydXN0Lm5ldC8yMDQ4Y2EuY3JsMDsGA1UdIAQ0MDIw
MAYEVR0gADAoMCYGCCsGAQUFBwIBFhpodHRwOi8vd3d3LmVudHJ1c3QubmV0L3JwYTAdBgNV
HQ4EFgQUCZGluunyLip1381+/nfK8t5rmyQwHwYDVR0jBBgwFoAUVeSB0RGAvtiJuQijMfmh
JAkWuXAwDQYJKoZIhvcNAQELBQADggEBAD+96RB180Kn0WyBJqFGIFcSJBVasgwIf91HuT9C
k6QKr0wR7sxrMPS0LITeCheQ+Xg0rq4mRXYFNSSDwJNzmU+lcnFjtAmIEctsbu+UldVJN8+h
APANSxRRRvRocbL+YKE3DyX87yBaM8aph8nqUvbXaUiWzlrPEJv2twHDOiGlyEPAhJ0D+MU0
CIfLiwqDXKojK+n/uN6nSQ5tMhWBMMgn9MD+zxp1zIe7uhGhgmVQBZ/zRZKHoEW4Gedf+EYK
W8zYXWsWkUwVlWrj5PzeBnT2bFTdxCXwaRbW6g4/Wb4BYvlgnx1AszH3EJwv+YpEZthgAk4x
ELH2l47+IIO9TUowggU0MIIEHKADAgECAhBOGocb/uu4yQAAAABMPXr3MA0GCSqGSIb3DQEB
CwUAMIGlMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMw
d3d3LmVudHJ1c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYD
VQQLExYoYykgMjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIg
Q2xpZW50IENBMB4XDTIzMTIxNjIxMTUyNVoXDTI2MTIxNjIxNDUyMlowgbAxCzAJBgNVBAYT
AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdTZWF0dGxlMSYwJAYDVQQKEx1O
b3J0aFdlc3QgUmVzZWFyY2ggQXNzb2NpYXRlczEbMBkGA1UEYRMSTlRSVVMrV0EtNjAwNTcz
MjUxMTUwFgYDVQQDEw9PcmlvbiBQb3BsYXdza2kwGwYJKoZIhvcNAQkBFg5vcmlvbkBud3Jh
LmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKn5wO5Bjob6bLDahVowly2l
AyCWBHGRq1bSptv7tXpj+Xaci4zpCqRoyqX0Gjpo8BEulUYQK8b7nO7UM3aMLC8H6vyzQ64A
GupPGIKuJg+Qr8jA0ihCVH+duE0bNXfDPTm/8VsXOubmVLPLp0cejxzrEC/RI5l8rdl0sQ+2
QZp9jTlyghB1Rxt2AYVYhVVnRMSJ8RgKp9MLV3qIfHqF1k5MGBIP6rS1afmlGd/yW9IWSB8z
iASPtr/Ml5ObbxtYZG47kCKCS7RF2rI6rGNmK/R6cITRs37dzUfBmagDFV897wAW3tHTyLQM
4vobhmS2UYi8C5voc+I75LYOsvLaXHUCAwEAAaOCAVEwggFNMA4GA1UdDwEB/wQEAwIFoDAd
BgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwFAYDVR0gBA0wCzAJBgdngQwBBQMBMGoG
CCsGAQUFBwEBBF4wXDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwNQYI
KwYBBQUHMAKGKWh0dHA6Ly9haWEuZW50cnVzdC5uZXQvMjA0OGNsYXNzMnNoYTIuY2VyMDQG
A1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwuZW50cnVzdC5uZXQvY2xhc3MyY2EuY3JsMBkG
A1UdEQQSMBCBDm9yaW9uQG53cmEuY29tMB8GA1UdIwQYMBaAFAmRpbrp8i4qdd/Nfv53yvLe
a5skMB0GA1UdDgQWBBSZhCz4u7bZ2JjPtNAM8gx3QVEp1zAJBgNVHRMEAjAAMA0GCSqGSIb3
DQEBCwUAA4IBAQA2L6VG0IcimaH24eRr4+L6a/Q51YxInV1pDPt73Lr2uz9CzKWiqWgm6Ioh
O9gSEhDsAYUXED8lkJ3jId9Lo/fDj5M+13S4eChfzFb1VWyA9fBeOE+/zEYrSPQIuRUM324g
PEm8eP/mYaZzHXoA0RJC7jyZlLRdzu/kGqUQDr+81YnkXoyoKc8WeNZnSQSL+LqRvPJCcCTu
JbCdd7C8zYW1dRgh4d9hYooUSsKTsSeDoRkFyqk4ZH0V3PFqa2HiFrdi8h3vpBX44VFddyaa
e+ekomLvvVZWGtJgXWr6VEBo8PTah0fw8BQjCIfFym44D9dulz1YW7E6FRPMSZ7x8X3UMYIF
ZDCCBWACAQEwgbowgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkw
NwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVu
Y2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3Qg
Q2xhc3MgMiBDbGllbnQgQ0ECEE4ahxv+67jJAAAAAEw9evcwDQYJYIZIAWUDBAIBBQCgggN6
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUwNzE3Mzkx
M1owLwYJKoZIhvcNAQkEMSIEIAHIsJSXYXqqSWP2NHafYG62l+Pkyhzt5uXLYSRhL+KNMIHL
BgkrBgEEAYI3EAQxgb0wgbowgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJ
bmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29ycG9yYXRlZCBieSBy
ZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4xIjAgBgNVBAMTGUVu
dHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEE4ahxv+67jJAAAAAEw9evcwgc0GCyqGSIb3DQEJ
EAILMYG9oIG6MIGlMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcG
A1UECxMwd3d3LmVudHJ1c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNl
MR8wHQYDVQQLExYoYykgMjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENs
YXNzIDIgQ2xpZW50IENBAhBOGocb/uu4yQAAAABMPXr3MIIBbwYJKoZIhvcNAQkPMYIBYDCC
AVwwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzANBggqhkiG9w0DAgIB
BTANBggqhkiG9w0DAgIBBTAHBgUrDgMCBzANBggqhkiG9w0DAgIBBTAKBggqhkiG9w0CAjAK
BggqhkiG9w0CBTAHBgUrDgMCGjALBglghkgBZQMEAgEwCwYJYIZIAWUDBAICMAsGCWCGSAFl
AwQCAzALBglghkgBZQMEAgQwCwYJYIZIAWUDBAIHMAsGCWCGSAFlAwQCCDALBglghkgBZQME
AgkwCwYJYIZIAWUDBAIKMAsGCSqGSIb3DQEBATALBgkrgQUQhkg/AAIwCAYGK4EEAQsAMAgG
BiuBBAELATAIBgYrgQQBCwIwCAYGK4EEAQsDMAsGCSuBBRCGSD8AAzAIBgYrgQQBDgAwCAYG
K4EEAQ4BMAgGBiuBBAEOAjAIBgYrgQQBDgMwDQYJKoZIhvcNAQEBBQAEggEAUSjM15m3pZsq
2glj4cwfoPo7wtKuKhKTGE1LEsR9tJm7GXBy2PMNzfrRJjmEUu52TkQqAZCJhId2U6WeTy3L
Y8Uic6s4LOKYMn7tuo11Nq4EIRrZxhdsWly++r1e+D/igFMlcE394RDQEULpJF4zPfYeA64B
Nh1r0pTEKj6HPlviOKnshEpN4/oWecLCMSRhHVJpmpPBtW8bsDoAsRwBP4FMVtrGijZEWHql
szky16ES98fc/DPQMAMn0T7K9X+0LoEsz4dSrUQgfR871pWAA8i960o3J6et8Y6JyJuOwHQd
xqe6dC+5vaPD1lsWHauKpuZyU/TNAdJNORueqNleEgAAAAAAAA==

--------------ms090400000608050602090306--

