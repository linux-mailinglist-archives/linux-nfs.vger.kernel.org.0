Return-Path: <linux-nfs+bounces-11646-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5756AB1EA7
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 23:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2EA01C07E32
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3C420F07E;
	Fri,  9 May 2025 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b="DvsSqnXJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BN8PR09CU001.outbound.protection.outlook.com (mail-eastus2azon11012007.outbound.protection.outlook.com [52.101.58.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4D95464E
	for <linux-nfs@vger.kernel.org>; Fri,  9 May 2025 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.58.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746824595; cv=fail; b=D7iHVgIpcsjlj8x2CjqKLL8S6/t5vQj7cqaSFRyLpUBq33ihUfWLpDNIbQ2TfOuJGTcgsZ/A+0EKjp8yC4Ki4rZ9chfHR26uBcpuA+6r10osmi6AXk9x3n9loOrLkCJXqy4CdktggVS1t198IUr9gF9/ljnpelZ/g6w12S1a4Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746824595; c=relaxed/simple;
	bh=dkycEU1NZ4DZlxCJmGKQqEzxRMG168bXA6dkaTv3mKg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sU/2dHTxMhD2/d3dw3EASfdKcuX2j/Sgk4fDtn27yv9bFKqiDisJFQx5a036qC0ooqyW+gn/DZbE/AjZG9oTNtkUGzlB0bO9o09eXB0OHxquf9Rsur3Ucr4ZmBs4UTHe1/Ek8F6AixXbCTE2HRKUrvmM6A067719FhJIWEGOAw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com; spf=pass smtp.mailfrom=nwra.com; dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b=DvsSqnXJ; arc=fail smtp.client-ip=52.101.58.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwra.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMKX67rcpFY9RWfwxL/71mK0y36y2qcNV+c3MiwEUC/9PyI8ZUrKI630tA2bJ3mgm5LDX8huvOEbSGMLNHqhCwmRIvau3LTsVsYrFLcbfOhc44EaOrZA02ReKIBMPRH/023RsUEesGyeOQllq72UkAQhM86Vq26CJ+yBD+NgB9h68fCgleyjCKs9rJkEW0vutJbGgc/WppiAhINjCLegNac04pgGacFwe1H/qr8btC0bb3YR9i+qRyYBzujSmKHWRYFkXfoZMPRWKTtS3lQvI3QB5x6m5vFk5DgXMMjpWErwrGplA3WLxU/jtMehJRTlHQHx+VmoRNvBRd+eNPVz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVsXFbAXQJICm/J1Ejv9SHrFukZjB1kHcTiFBQXXO4U=;
 b=j03MV/kH1kOgmisJSBFzHfoo7zgORCKj3xTMPFTgyoPiDpn+0J2JRsQjnQd5mUoBeJ/g5Azo6jLO97XWViNzTzQbd3jeelzWC18XdwXGo0lmiQSJ1KqWiPSm/5NJ5nFkfCLIHY+8BqAPDtQLs9imsOgLMzGrWq4e92LjqdfZbJYoyR8vZhLbQNd2KzcbxNLbEKofKb6GPUwQOFbeWm+3XPKR6FUzg10UH5q7QCAPFNCWgS4nOxK+VrZuhYi8g044DeQq1WcIVmBxvqf9GhzfjwqstCCdDI6yzeSDCzACzRF+B6YCloIngnxNTytkU/CUbgzvwVVFbTV4qGBzQDI16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nwra.com; dmarc=pass action=none header.from=nwra.com;
 dkim=pass header.d=nwra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nwra.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVsXFbAXQJICm/J1Ejv9SHrFukZjB1kHcTiFBQXXO4U=;
 b=DvsSqnXJPosbF1+XTM/VnKLM+iezet+jePSxoQ2j5MZxVdcoCbSlb5u7h7DojdniPsecNq035nJM0d3EmV37AYVJchAAMyOQjuTsUyFSlgs34XO24Y0zm3+jx53gCFvNlG0b2UEMtcgcUDtN8Z/+0eRcc+kMg8YCQhJw3hTp2avdlCPn5ED55y4Xhuu+ArDvbM9D4ev7Br9Iwt5sWZqVx043qk4TvXcTBUXcezH2PGpAaa52iDexHzj3ULTJRx1MpEyctiMscQxyh/+ME8I5eScGcN3YKm6JbqWC30qCCvnRcSfJKoVDweOFMPLL6O60oOK5EYWf9FiWg2uPa69J2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nwra.com;
Received: from SJ0PR09MB11875.namprd09.prod.outlook.com
 (2603:10b6:a03:51f::10) by SJ0PR09MB10616.namprd09.prod.outlook.com
 (2603:10b6:a03:50b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 21:03:08 +0000
Received: from SJ0PR09MB11875.namprd09.prod.outlook.com
 ([fe80::30e0:339f:805:2779]) by SJ0PR09MB11875.namprd09.prod.outlook.com
 ([fe80::30e0:339f:805:2779%3]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 21:03:08 +0000
Message-ID: <81edb674-2dd7-4ede-887f-40e6177661e8@nwra.com>
Date: Fri, 9 May 2025 15:03:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: Trouble with kerberos encryption types
From: Orion Poplawski <orion@nwra.com>
To: Daniel Kobras <kobras@puzzle-itc.de>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <c4ecc067-9a51-40c8-9300-29119ff2e1d0@nwra.com>
 <e482c8e4-2939-4ef6-a004-e23fcf5e666d@nwra.com>
 <c123b772-ab05-4333-a868-c409c03fcfa2@puzzle-itc.de>
 <62ed2e30-30ba-4b45-b602-14da6f29e9dc@nwra.com>
 <8225a6a4-3b68-44db-ab99-17cf1a4f5175@puzzle-itc.de>
 <66ebdde2-916c-4984-8aa8-0a659d89acd8@nwra.com>
Content-Language: en-US
Organization: NWRA
In-Reply-To: <66ebdde2-916c-4984-8aa8-0a659d89acd8@nwra.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070007010106080208020507"
X-ClientProxiedBy: CY5PR15CA0121.namprd15.prod.outlook.com
 (2603:10b6:930:68::12) To SJ0PR09MB11875.namprd09.prod.outlook.com
 (2603:10b6:a03:51f::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR09MB11875:EE_|SJ0PR09MB10616:EE_
X-MS-Office365-Filtering-Correlation-Id: d75f5818-4322-4ea3-2c00-08dd8f3ce615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|41320700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alBrWmd1eGNldFFwTVNMNlJqMmJLZmQvb25NUk5GNXZLbGhkNXdvTHRJaHY2?=
 =?utf-8?B?QnlsWVVlWUhPajQ2ejZjbnI3dGFzcll3azZqOTc2YTUvNkZlQ3RzU05DTVRx?=
 =?utf-8?B?bmg1UUdGNzJYMDIwOU03UDZQWkdOK1RvOUVQekpiMnVYcm52S01nMWZBOVdP?=
 =?utf-8?B?ZU93N29Za1IwV0tLcnI4M09nU0NKeDJLMzQ4Z3hxMFNFdllCaFc3L3FtUE1G?=
 =?utf-8?B?LzZibEhSM25MUlJCTFZHYU5ndWhETVc1RVVQSWZhRlpua0ZWalR2bVp2Vzl0?=
 =?utf-8?B?TGxQOHVZaGNNSUhBTURDSWF4NnA1dDdhTmNVaFJZc0tXTVc1RHkzK3M5VXJM?=
 =?utf-8?B?SEx3VEZBcHpDZTY1WGYxekZJWThZaG1aZmwveVV2dHQ4ZXBjc0l4ck5SeFND?=
 =?utf-8?B?eEMrOFFNNHJxd3I1VnBIdE1mV0p3RDJuT1hEeGFkYjd2M2htUHJjaXB2eXJh?=
 =?utf-8?B?T2FIQWhoV3JKNm5VbE1laVY4dWNiTDdDTWxweHg3MWZlZWUrdUNQRlRpdzhw?=
 =?utf-8?B?ek5FYjd5TjBQVjlpMmFRLzAvN3NJWmN4MG5YVVU4bnd5MTkzd3hUTXFYSGFw?=
 =?utf-8?B?S0pTLzlnUHdaNXNmRmt1eXFXcUhaNGtBREs5a1ZLOUo4aktGZUIwUW9kUXFv?=
 =?utf-8?B?Nnp3NU1oanJVOFFMQjErTVZOcHZnNERuemkxei9MS3JleVl3OTZ4RGZGLzdq?=
 =?utf-8?B?bnNzblhpWVpGcnpaU284NFJTWjhrYU9PL1RuRGVaditZTGp3VktHdG9ra1h2?=
 =?utf-8?B?ZjZ5bkNsc3pWZmlCVWRxOVdQNkdJaUNybU9tb1FPMFlBNjBubDJtNGtuYmE0?=
 =?utf-8?B?Q3g5SWorcWdZcFpaMktwaU5zaHNwcklVcU9YeThMakhGbHdWSStnQjc2bEpH?=
 =?utf-8?B?K0JPVkhPdVF2ZlVzRDJsTU90VTNpNW5FVzdreUlwSDdUNEJMVGx2U1NscEp5?=
 =?utf-8?B?OFVFVUdnWU4xYmZ1TFhoWk5rU0w0alpJTFFjc3Y1aFFPNlV6TGh4YjVvYm9r?=
 =?utf-8?B?L3NKTlIwclI0ZFg1bHo2Z1liSkhVak9RWmJFdW9ldFY1SlFRNDlDZ2R6bGc5?=
 =?utf-8?B?UHlvdGdEeUZxNkFzVHhaTHJWSjdxbnFBWGlOYTQ4RkNQeWRYN2dpcnMxY1l1?=
 =?utf-8?B?cFkyM2FmV3E2eWFVREM3clVVUlIyTStQcVcrNG1Fc0U3azdIOE5MM0ZQVXkr?=
 =?utf-8?B?bUtZcE9adzYrV3lVQ2RXejdnYXlyNWxaRGwyMjlrcWxmVXpMRHpFcmtxSlYy?=
 =?utf-8?B?TEVWTVNiMXZmMWRpTlBkWFc2RnUvZkxOTE1aQVB4SEt0MXNiYWR6aE1vcTM4?=
 =?utf-8?B?c05EczdrRE9JeDVGNEg1Rit2eVFlOWh0RFJpMXR2RWIwQTR5YWt1cHBlQkVW?=
 =?utf-8?B?K00wazJRMzVRQnhnd1kvSWt4SEw5UUErdHhjUTY3VlQrVVZZdlA2TVE5Z0lT?=
 =?utf-8?B?SHR0RFhhd1I0b21xWVpsc0RRY2dQOHh3WmE0M1J4RXJzR0M5cnBzejA3VkxN?=
 =?utf-8?B?Qk9MY2o1YkwwaVQvRU1HQVlJOFk1MEdTZTdLditLYlF6Zlh3SnphREtmNHV0?=
 =?utf-8?B?N25ncys5UHMzVnB5ejNPdEFzWUhvOFlKWHF2ZktadXFzTTZRT1VncTBGWU16?=
 =?utf-8?B?bkZHYWRQN1ppU0VMTkEvM3REaVZXZGk3YU1KeFZnS2tadVl3Qk9yRm9IZVdT?=
 =?utf-8?B?TnRlOFJiQkU5QXo2YkV3bmE4WGcrb0pKWDlOaVpzeHd6RXVtUU9lTWxlYmtk?=
 =?utf-8?B?ZGljdkxnSlphVGVzWFVaYVVVc1ZqUmpha1pMd25qd29pZUJ1WmJYRGV1cWhW?=
 =?utf-8?Q?hglwJgGpcRFAakazhAZDMdh0ZVDCdzD9++LtU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB11875.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnJKNWNPbE8wRlRpUzlBeUJGWjJPSjg1RXRYZHdjUU5BaCtJUzdBZTR1a0Nw?=
 =?utf-8?B?YTNjRGMrVWdrWGxaS1NOcHlEaVRwNDVIZVFrb3R3WDMxSk52NCtSVHpDajdW?=
 =?utf-8?B?Tlo3ajlvRGNtL0Z1Vm9IZFhwdThWNi9wcTB2ajhycHdVek5GMGpSaHRHUjZx?=
 =?utf-8?B?Ujk0ZGxxeVRSN05JWWgraTBVZ3RGQ2pwRldLQzhuRGF6SDJpclRmTDZOSG14?=
 =?utf-8?B?TGtuWjI3dm9QMXlMSG1NSFJWYzRNUzJrWHlZR0NNT3BQdDIraEdpdzBDNnda?=
 =?utf-8?B?eEFYWFVBblJrV0luVVdDckV4OW1WR2Q0RDlSU2d4U0luUVMrc0Z1VzBUb2Z6?=
 =?utf-8?B?ajJzRmNLLzJqZW1ZaSt6ZWZDd3FiOTJ0V1FNNDFzK2orTzIvRXRJWWJZaHcz?=
 =?utf-8?B?dFpTRzdyWkhLejd4b2RmRVFMUWJXbmJUbkx5NHI1YXhSakxBaDRRYXBsSitt?=
 =?utf-8?B?MUF0WWtnQmtsa1I1SmZFdGs1eGREazVMQTJUcC9HZ3hhV1BKTDVLZ3JPbEt2?=
 =?utf-8?B?aDdkcGdQbWFWQ2tSU2JOQTlGY245RytPL2N6aGZ6RVhxUk1SVC8yYVhHZ3VV?=
 =?utf-8?B?eXN6QzBMb1FERzFsOGZIckNaZkt6aW5YdkdLblNzQXhNeGY5SjdZRGRVNy9U?=
 =?utf-8?B?K2NPelppRG05eE9IQXg4dmVCTFlrZTloRGZXV0x1ZktFWHdQdjYzMnpxdjBK?=
 =?utf-8?B?VDk5RmlXNVNQeDV5eTRiNVNsdW9qOW9HOWtIUUVzZ0c0dkY1SldKYXppY29u?=
 =?utf-8?B?dTcvb21KMVpoaHlIbndjQ3JRV1R1TkxEb3I1bTZyUzExNFRKSDAyY2o5U1BB?=
 =?utf-8?B?dDV1MEhCRGxZZHo0MVdkM29YRlI1cERySWdreVE3QmVCUFdwdFNSR0pDTVR2?=
 =?utf-8?B?OGJHa05XWWJxUzRqSlBGQVdUNUhzU0Znc1BRbnlXbDFobDZyQWRQZCtBNkVz?=
 =?utf-8?B?bEdIdWF1OWYvTC9mUjlmTHNkZUx5UW83U2QwaHlDMHFBVWpwLzVGenVmQzVv?=
 =?utf-8?B?VTFwa0F2Ris3ZzJsQWxrMjNqRzVsYitTLzhzQ2lpREd5TWIvS2s0bGNBdnND?=
 =?utf-8?B?Ykx4SFZRR0RhekNRa1dFbGQya2xJMFcxeFFTS1VCaXQweXg4bk5pdVJ2NWpS?=
 =?utf-8?B?VjVkZGFGbTJoUG1iWThIUEY4SXNCWGVSVXAyMUs3Mm42Z3RzTVhWOVdnQmk0?=
 =?utf-8?B?K0t2eWxUekpzUStWRjVTVW11c1RqMWlRYUpveFRSTk9YcERiNGNHYWNzenlG?=
 =?utf-8?B?QVIxQ1dXL1RnRFVWN2VYd0lkSVJwMXd0QXpLaE92cjV0dTZLb1BGYmY3dklY?=
 =?utf-8?B?c09CU2Rmbm45RzZoN0EzYVh4TWlMMUYzTkoxUkMwNDdHbExXNlcyRlVFVnVN?=
 =?utf-8?B?NzlVMlpsTWI3YnZBUFIyWWx0Qjd2WEFLZWhIc2R3UThFWkp6OHNwZTQ2bzFi?=
 =?utf-8?B?UW52WHFQVlhhcUFCK1dMa1FFeW1ML0pXaytaaWluQXAydWpuOUFQSEtuZHFq?=
 =?utf-8?B?c1pidFkrSytEVThOMnN0WVhvR3p2d1JoTHRGTHJ1TmhxQm0xVy9RczlpTHZO?=
 =?utf-8?B?MklQNGk4Mk9tNlRyY2dyMStHTFpHOU9OM3BFUVQ4dkJUOHFZRFI5dTBmUytS?=
 =?utf-8?B?eDZRdmx5VTZSdmNDT3pRVzIzaU04em95TnRIanNPT0theVlMRi9JampuS3I5?=
 =?utf-8?B?NENpbXVhd1d0K0NtSEwxK0VvcjFxRzNmYUVNZGJPM250OVBaMDk0QnZTa2sz?=
 =?utf-8?B?NXdhUTBJaE5wbkFFUzR3Uy9uNzFNaDA4c1JTd1VkUE1BT2ljcjlNWVVYTCtI?=
 =?utf-8?B?dTlxc1JBYzB5REpZN1RZYjVhMXdvc1VpZkM0TWRBOTQ3TkNRQmw5YUswRWhq?=
 =?utf-8?B?WC8reUM2MzlQMlBVd2Fqa21ma2k1WEppUUlnZkVZOTJqZUxYYUNuWWlVRXFw?=
 =?utf-8?B?ZTluSnUzNDgzN3VJK3IreGVldlk2RUZMWTc5cG11SGhkMk81STFCbmpKMVg4?=
 =?utf-8?B?RXZxR2FnSGxjTk9uUHBpemhTMFZreGphUndkb1J3R3VMaEpuUDNOTGNuQlVa?=
 =?utf-8?B?dHowK2NTZno1VzB3YTZTUk5tQnNtTFpRRmRBbjRqcFJCbGJ2MWJoRTZUbFp6?=
 =?utf-8?Q?yw8oLc9BCyqBwXFzaxElOjLdp?=
X-OriginatorOrg: nwra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75f5818-4322-4ea3-2c00-08dd8f3ce615
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB11875.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:03:07.8324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 761303a3-2ec2-424e-8122-be8b689b4996
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR09MB10616

--------------ms070007010106080208020507
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 5/9/25 13:55, Orion Poplawski wrote:
> On 5/9/25 07:21, Daniel Kobras wrote:
>> Hi!
>>
>> Am 07.05.25 um 19:39 schrieb Orion Poplawski:
>>> I tried adding this to the mac without any change:
>>>
>>> [libdefaults]
>>> permitted_enctypes =3D aes256-cts-hmac-sha384-192 aes128-cts-hmac-sha=
256-128
>>> aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 camellia256-cts-cmac
>>> camellia128-cts-cmac
>>> default_tgs_enctypes =3D aes256-cts-hmac-sha384-192 aes128-cts-hmac-s=
ha256-128
>>> aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 camellia256-cts-cmac
>>> camellia128-cts-cmac
>>
>> Those are options for MIT's libkrb5. Unless you're using a non-default=
 stack
>> on the mac, you probably want to use Heimdal's default_etypes, or the =
more
>> specific default_as_etypes/default_tgs_etypes instead.
>=20
> I ended up slimming down to:
>=20
>   permitted_enctypes =3D aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-9=
6
>   default_tkt_enctypes =3D aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1=
-96
>   default_tgs_enctypes =3D aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1=
-96
>=20
> but those are the option names from man krb5.conf on the mac.

I should have trusted you :) - I finally came across this:

https://services.dartmouth.edu/TDClient/1806/Portal/KB/ArticleDet?ID=3D89=
203

which has:

        default_etypes =3D aes128-cts-hmac-sha1-96 aes256-cts-hmac-sha1-9=
6

and setting that does fix the skey encryption type.

I'm still stuck with the non-renewable ticket that they mention as well, =
so it
seems like GSSAPI auth from a mac is not very useful.

Thank you very much for your help.

--=20
Orion Poplawski
he/him/his  - surely the least important thing about me
Manager of IT Systems                      720-772-5637
NWRA, Boulder Office                  FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/

--------------ms070007010106080208020507
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
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUwOTIxMDMw
NlowLwYJKoZIhvcNAQkEMSIEIGr4/rytERjHVMTNZ0o6NX4T6uQSOH4XwX4DJVEKuOrrMIHL
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
K4EEAQ4BMAgGBiuBBAEOAjAIBgYrgQQBDgMwDQYJKoZIhvcNAQEBBQAEggEAmPhDt3GaJlwF
Ot2NqimF3mAfBseqDV7bkcRdMqoWlv0B3swZea79cJtBGsqVjrQo9tepu6YIbQl0ohCFgqwn
aJwzsE9IWpBJTkblzAfn3F7IZ1Ix2+JuKXaMcjjYSQGZBwcm1pICtHpa7NSToq8MaqD8+oCj
G8oLqIDv34p+x7dZChfFMswB83Ji5mx/SUb8yOm0HwHvTBDDsA9ZqSeJLVpkCKHMTYviV/w6
mQj5Xroy5Ezqg96TO0uTFnsYSuCh3NmcEtgz4vkRdiPacIGNfTauItzJbNlbgrTtTlsRaU74
d6fG/3+MCgVQVUbXkgje8twDSSp/EObU6dVxYUYAkwAAAAAAAA==

--------------ms070007010106080208020507--

