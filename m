Return-Path: <linux-nfs+bounces-11643-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD6DAB1D88
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DE41890523
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAEA253935;
	Fri,  9 May 2025 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b="SrJyfh5F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BN8PR09CU001.outbound.protection.outlook.com (mail-eastus2azon11012047.outbound.protection.outlook.com [52.101.58.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C70F246760
	for <linux-nfs@vger.kernel.org>; Fri,  9 May 2025 19:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.58.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820509; cv=fail; b=FiPnzkQHpQOTAgSTaoGfNKkfHHu6fEVtRc/FGyQ/6XpSmbTeK+Pc4YeG49ILkHeBKfEMQlqaOTlfxZnsyNuBVMa1J4gcerC2HGQcCH/CVXCPzlfFHJGQy0jsYSTN8CFDPfXAbPjdgVUWIv2HXNf/X7yvYi7pkKQK3Ku4u0Ralpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820509; c=relaxed/simple;
	bh=QUnpmIK9mV/LvE0mTVCxOwaMFjVc4mx3YAVlNxxTMTE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JYK8mJWExyq54jsNco63UNqDrrwdNPqSCUIVz6Rj9iI2cR06zz/TRmpYcpXNf/OXy3ZoRd7T4WgE2LfEDaDuv7Q1i41hYrClpmmmgZMzjJWGhq+A4wTtGnxXtDMkWIxVjuPCXe1PtGlVL5izL123PhHINO+70CZLs6Jy+XlmoOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com; spf=pass smtp.mailfrom=nwra.com; dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b=SrJyfh5F; arc=fail smtp.client-ip=52.101.58.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwra.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNkKMx8U+M5VjKZjQzmI5VJyG/6fiz5/H1CPJJMt1h+6TVx0+mskdGG7w4bKK5pUpUVZG0UpHE2bSL7bRT3Vi+2zVUefoE591KOUfPJj53SimM2+YsuMPxEdRwX+8Qb8p8dQrLfVUuP9KLz5ceOZQAsrHt1MeucrWCv+0hvjxvofSRXrPwehQOIaSDNT/XRrqbrDsu9K89UahmtUuvqp/e5IoomchzC9thGqk7AAJmpWcG1e3y32KqbX1z4Y7tELTKMata/XfQmFkeHyZ90IPJHj2OKVA2uvKCxxNFN9HgDjtXIHcNoVZS5yNbQRb80IP47dvtS6Gf9RmQEXcxfx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i60OLxohV75SnpxcvsPJMCkuFWYIXcvn7aA+KTwrfKY=;
 b=RzMBLcD1ThUir3DaENhL8929Qni/vYxX6P1YSvhD5evPfRSSp5qAA3226TwP17k69GN6QQfyWJ/0N9372ER82HtjCgC6nwKiQkwbL9+BJ6GaYRnDV73JQLv5YWyN519miQJlOkN+dl9Z9zbQh0p4WGjUJ19F+SVxqFPnLYwWouJ/VhtKjvFYu+haH3ASbut5lgpvXUJvrR3Oc1J1qZAlem0kd44k4n6ga0EbbskJG0Slg+fSsc+AXDMtwg7CQC8acvaaktk2eSPYVBaS/Airdcnec5y+pN7Ff/Coo1mvl7oP6SjPbBXGQs/WiKJ9kdiOTautqOJSyQGUjgoja8z+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nwra.com; dmarc=pass action=none header.from=nwra.com;
 dkim=pass header.d=nwra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nwra.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i60OLxohV75SnpxcvsPJMCkuFWYIXcvn7aA+KTwrfKY=;
 b=SrJyfh5FfqV0S0L0fBdZJOm+mtcajaMyzM7AqJlF4+KpLQkz8MgAxCujqJzRhNqgEXB8HeOG5gdOmj9PJOZoGla9vRHC0uQTajBS2pmQLaOTUc9O0x41isfOYxeAf3xqM+UaUscpjsZ7KF4ZTlDHO5M1XsUUTOt2l0uNBokMcnjBjzMjxxbM7R/x6e1IQFyVj3uCUoOVAZgltB1kumCxlBakxuIWR5jF99Sp4dL7EqFNJcUdTWg3euC8XpfxAB274DpvLOgEeUWQDKLpCurKcZnNXokS3mITQ5HdDRLiT+K2V5p+sTmhdQCV4u+ddCg7umujF4yWrt1hm8yLNvQghw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nwra.com;
Received: from SJ0PR09MB11875.namprd09.prod.outlook.com
 (2603:10b6:a03:51f::10) by MW4PR09MB9803.namprd09.prod.outlook.com
 (2603:10b6:303:1f5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Fri, 9 May
 2025 19:55:02 +0000
Received: from SJ0PR09MB11875.namprd09.prod.outlook.com
 ([fe80::30e0:339f:805:2779]) by SJ0PR09MB11875.namprd09.prod.outlook.com
 ([fe80::30e0:339f:805:2779%3]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 19:55:02 +0000
Message-ID: <66ebdde2-916c-4984-8aa8-0a659d89acd8@nwra.com>
Date: Fri, 9 May 2025 13:55:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: Trouble with kerberos encryption types
To: Daniel Kobras <kobras@puzzle-itc.de>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <c4ecc067-9a51-40c8-9300-29119ff2e1d0@nwra.com>
 <e482c8e4-2939-4ef6-a004-e23fcf5e666d@nwra.com>
 <c123b772-ab05-4333-a868-c409c03fcfa2@puzzle-itc.de>
 <62ed2e30-30ba-4b45-b602-14da6f29e9dc@nwra.com>
 <8225a6a4-3b68-44db-ab99-17cf1a4f5175@puzzle-itc.de>
Content-Language: en-US
From: Orion Poplawski <orion@nwra.com>
Organization: NWRA
In-Reply-To: <8225a6a4-3b68-44db-ab99-17cf1a4f5175@puzzle-itc.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060808020009070701080607"
X-ClientProxiedBy: CY5PR19CA0118.namprd19.prod.outlook.com
 (2603:10b6:930:64::22) To SJ0PR09MB11875.namprd09.prod.outlook.com
 (2603:10b6:a03:51f::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR09MB11875:EE_|MW4PR09MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb828eb-f790-4e97-366d-08dd8f336306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|41320700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkttcTQ5SE1HaENxMVJsY1pGbW1WWUQ3V0I3N1d3Y0F0czlETWNUd1VyeU14?=
 =?utf-8?B?S2RtQ3ZVRjdQY1dZck1Uczl3Q05id1J2ZEJsdHFBSVpwejVRbGJONXJCOHlM?=
 =?utf-8?B?bzFMRVVBUWE0NWFTNlZhMWxCWHBxblg0Q0l0VWhLVlJYVTNyMXdGY2x0TVFk?=
 =?utf-8?B?Z0lERStZTmN5TDNiTUZJUkFuSUp0YVdtLzlPUnhnM3NheGtCNDc4RGttL0Fr?=
 =?utf-8?B?WGtKV3lESFFtUVF6TTlYMjNrOHVkRVFnSm5hZXVuT1JXNTZxN2dIUkZwVlZO?=
 =?utf-8?B?RUt3Yk9kZkJEbWVrQUxiWXRKY0JLQk5renIzZUxNdHdCcEtkMVZvejE1SlNW?=
 =?utf-8?B?LzhDY2M5NHk1OHlBV0FOcjNXM2dqSUZ5cng0a0Mwa3haYTVxeHZQOWlmcWNJ?=
 =?utf-8?B?NFpnZFE5UjFqeDM2L3NaMHc1RXhKREdHMVlldWhLZTlUelhXQ1dYS1NMT203?=
 =?utf-8?B?ZjZMSStpM20yN29CSjhOcnROL3hYOW01LzR1SUpQUmcvTkZxZWRuN0JQcVpQ?=
 =?utf-8?B?WWtLYnMrNzhJU0ttTENmU3lXc3RBTGdGVHF6VFZTRlRLK0tqcnVrV0hCOUZC?=
 =?utf-8?B?RXY2UmhPM1VpNkhxSFh0V3hIUE5NVGp2a0wyNEZsK0tHWHh4bUdnL2VPTlN4?=
 =?utf-8?B?SGk4ZHltWkh0aEp4dVpuODVaaTdHVzZmeWlXbFRMSlhUUDNiUm8xajI1Yllz?=
 =?utf-8?B?T2Vuc0lPUVEyWm9qc2xjVVNDYVdiNzhLQTFsZDB5aTFXN1EvTVNveHJJT09F?=
 =?utf-8?B?UXM0bCs0a0pRZVBPa3kwMld5SjFkUTI2WWord2JvS0s3K0R6dXdTdk5aUjZZ?=
 =?utf-8?B?VlVEb3h3VldHdHdFR2JzZkhWL2F4QU9CK3ErQ01kc0VtQUljYTlKaGF3SU5t?=
 =?utf-8?B?WGhvYTYzdGZhL2VnUkNSQTd0ZTlGL0xxNWQ5K2RJRFkzYVpxbE1YS3EvaHBE?=
 =?utf-8?B?TjlNTHY2MnBYa0RseExyaDRGZU8vN29rNE8yRkp0ZDFnN1BROHlYL05VaWZX?=
 =?utf-8?B?RUVCTVZZaSt4WEIyeFdJRVpTa2FiRjFnNU81K2hiOThORHp1bndqUnV6UmVK?=
 =?utf-8?B?SGtHM01CM0NYMU1nN0l1K3ppNmk3cFNxTy91OUhPbTIrdnRrZFFBV1pxZTAz?=
 =?utf-8?B?QXVsNnp3U1ZjQ3dnU1JtSng4dHZIaDh2QmZRdW9zVkdsTWE0MnR2T0JNUFNw?=
 =?utf-8?B?UjZjbFE5U3JibmJyUzMzcTQvQUVzamEwQkdUV2hoeE1ZeWVXQXgxNHJocjBm?=
 =?utf-8?B?WjJRakNZSzdCUmF0MkQxa3RzWW1qV3FXNytxVU5FT0NBVFJqTnVzM2dKNFFq?=
 =?utf-8?B?NzFwOGVHTXVMV0JPZkxaWHdiL1NVNENsUmN1bVcwblRSSHhFRE5OZlp5eHQ0?=
 =?utf-8?B?WmZqSWJIS2owUkJUR2RMUTE5Q2hEcXlYTExZRDVpZjBxbVpYTW4yZ0U3dVdx?=
 =?utf-8?B?N1RyUC9ZL05sd0Rudmh5dHAyRnhlRlovb1l1MW1ZTm9oeEY4V0N0TzJzc0Ru?=
 =?utf-8?B?dVhmRU95NVJSbVE4RS9FaE1WRUViMmF4OXhXM0pHS1owTStzZHhqTGRaaG5q?=
 =?utf-8?B?bU1WQ3UvWGFhTWhLaTllaXZidzEvMzIySEtDbk4zcnMxVm9kR2svMWVrZXVo?=
 =?utf-8?B?Z2FYVmIreHhSSnR2UG9reXlleEJhZ1lMVkdqd21PT3hTdG9ablpXd3hwUGpz?=
 =?utf-8?B?ejc1bHREdkdmZ29RL1JEMWtYNFNQTkN0dGp6cXJUajY4SlZvb1A5bDNlQXhV?=
 =?utf-8?B?Q0RkdUtia0pON3V6TTQzSVEvemJ4TTlPdm44RlhHYnhqcENJbGdFS0pmbWhZ?=
 =?utf-8?Q?GQao0E84s3rHS4j3v+h9DnRu/jqiWsrZWIV9Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB11875.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(41320700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2lSeS9LSm9WQWxRMzFzM2pvNU9IdXBRWFlUZEZQUGxhWjBXcndrMEZwbzFx?=
 =?utf-8?B?MXMyWUIyak56UERMQ2pwU0ZtYmV0Und0M3daMjV4LzUxVVY1bFlZV1VhUE9u?=
 =?utf-8?B?cGg1MVc5bm1QS1g4Q2xQeFVZckU2UHpQbURlVW1WSHUwb0crdjhBUUhTYUI3?=
 =?utf-8?B?YmY0UzVBK20yWk9nTi9QeUtPM3k1NFo2UUNmLzBWUEpnZWJ6akpqck5JOG4r?=
 =?utf-8?B?K0RGTzg2SE1Zb09MVlZkdTA2YTd3S2g0d1VjdEZDb0I2Sis1QTdBdFp3RjZ4?=
 =?utf-8?B?UWs5dm5TTUhMTUlZa014MmpaNVFxSTIyOEJmRnROemUwQzcxNEdXZSthNUo0?=
 =?utf-8?B?M1FoQWxaQmJTRU1YOEJVRnhZRFF3MnIrR2xmQ3JsN1h4emU3RHVNSzlRM3cv?=
 =?utf-8?B?WmR2dE1oRDF2a3JQMTZPVFZjeCthWDMxRVZFd0lkM1dPZ295c0VEYXZIVmxE?=
 =?utf-8?B?Wk9tRXNWeFljTEJsSlFEWkdhSDJtcytmVmNmUGNoUlZ5ZlBFdXdZZmRyT0Jj?=
 =?utf-8?B?VUtTQ05ZdWh3NkRqV0djR0dDb1NaMnp6cS9uV3o4UU1rWEpmSXdOdDYvTnhz?=
 =?utf-8?B?RzM3R0cwTXJKR1RaRzBZVEgwcStleHNDREIrZGFRYyt2Q2FSOUo1eDU0RkJ6?=
 =?utf-8?B?VXJVNERmQ1JjZFVMK216L0lNdWhIT2ppWnZOWnRDaGZXbGZURXhmUUMrTGps?=
 =?utf-8?B?VWFjMXhhYU9pQklXTmJYUi9IVU9uQ3FOUWxVUUhHOTFQZkMycmpVKzR5WjBa?=
 =?utf-8?B?U1RkZVR2YmsrYkJhVzVyaDNvOFhmQmxJNEc1U3VvSWxSQWtHNHMrMjJTcjhN?=
 =?utf-8?B?SzcwdUMzZ0puY09WSHZwdEFrbEhLTVRJVkpibFZLVjBZKzZveGN0VXErL080?=
 =?utf-8?B?NFdxeUhkK3BqN2VrdFlxSHhzTWlxaHRLYS91Q1lncGJSMU5JZmFsOFJ2Vi93?=
 =?utf-8?B?Mm9OYy9KRk9SMmluYjFjVm1GZVVZUEliMDNUU0pkYWs5QXZISjN2S2s2ekxa?=
 =?utf-8?B?OE1TaUNjQitDNk13N0tmSkExYkRwOTZBT1lsNmxaRTZmaW14MTIzYm9DWE94?=
 =?utf-8?B?MGgrOHVHK3FISi9hSTdDRG9pTnpCNkxXKzNJWFRaVzcrTWdsaEJwZG1MOE4y?=
 =?utf-8?B?RUZVV0lDbXpwNEkrMmxlWkVDWXRDR3dLTWZWaGIrcXlDck5uTXd3aUZGN3ox?=
 =?utf-8?B?WXNTWHJpM3I2Z2VQSEJGQWlzaHB4N0RTVVBFdHg1aENYZjliSncyN0FlN0Yr?=
 =?utf-8?B?RUlOeFRwWFo2UkVDMWltdDRwUUZ4THdqdWlMaFRPRzY5bXlsMnhuMmFHYnhm?=
 =?utf-8?B?c2p2b094aWM2TFhoWTNEQ0VRMlhUbjR2MFhJeW1DeG15L1dtQWdlTFI3Vnp3?=
 =?utf-8?B?T3VUZzl1UitDWldsYU5Cc1lESGplVldORGZWRkp6ZVY5TGN3SlA3d2krSXg0?=
 =?utf-8?B?Z2pMWTdkVUtlMmZiTFZMbzNTd290b0g4RTFDWnVDRTg2Snd5dXhDTEdqZUhP?=
 =?utf-8?B?WDZmc0R2KzFMUXN5Y0ZLbWN2SExHVWkvSXhOOE9nOWhxRDd0MzQ1bThqVzdW?=
 =?utf-8?B?V040N2NKbTQ1ZUNoSzZKK1FKM3dna0MraHc2cUszTGlFT2YvOTlqVXltZTJ3?=
 =?utf-8?B?OHdXVUNSWXpLV2xYVk9wK21PMjJBeW5Rd2pQOUwyMnFCOFIwTHpYUGJtc2Jl?=
 =?utf-8?B?RWRsZG1RK0NyZnFvYnh0UWdhMkpyWm96dWUvTUlmNFl3UUFYRUxTbTRzR0hF?=
 =?utf-8?B?T1NsemtnU2gyWWpXNDI3UGlsVHBidWZ1Zm5ZbDBhOW1BcXJMaVhFRzFxYmNp?=
 =?utf-8?B?cGJZUSszMTArK3VuWFlPUG02enZKcTVMamE3cnBhSXNDeVJOQkYyaUFDVWJL?=
 =?utf-8?B?MGIzS0d0eEtES08xakw4cmNjZU5RclEzcUdaUTQ4RG9DQ3VDTmUzaFVUNXo4?=
 =?utf-8?B?TS9BVlBhNDY1LzdwcitsYUtzUERsN0pXRmthbWtkZ0EyMXhpTmdHSWcxNVRo?=
 =?utf-8?B?aDY0ZGxrQkUrL1psVTRCY0ZFdVRZbjJUYnNISkEyRUxGdlJKcExpVXBOL3Mw?=
 =?utf-8?B?cWEvNHJQY3JuSDVVMm9oK3QwN2s4ZEFwUzJiQmM4VGRpQjJxT05wclVtZ2t0?=
 =?utf-8?Q?R+tBck9bcVGF7bIKY4BOBoR49?=
X-OriginatorOrg: nwra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb828eb-f790-4e97-366d-08dd8f336306
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB11875.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 19:55:02.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 761303a3-2ec2-424e-8122-be8b689b4996
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR09MB9803

--------------ms060808020009070701080607
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 5/9/25 07:21, Daniel Kobras wrote:
> Hi!
>=20
> Am 07.05.25 um 19:39 schrieb Orion Poplawski:
>> On 5/7/25 10:57, Daniel Kobras wrote:
>>> Am 06.05.25 um 21:54 schrieb Orion Poplawski:
>>>> More details.=C2=A0 The issue seems to arise when doing gssapi deleg=
ation from a
>>>> macOS client to the Linux box.=C2=A0 If I have ticket on macOS:
>>>>
>>>> Ticket cache: API:427671FC-DB63-442F-ACA4-13A9194F4398
>>>> Default principal: user@AD.NWRA.COM
>>>>
>>>> Valid starting=C2=A0=C2=A0=C2=A0=C2=A0 Expires=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Service principal
>>>> 05/06/25 13:29:54=C2=A0 05/06/25 23:29:54=C2=A0 krbtgt/AD.NWRA.COM@A=
D.NWRA.COM
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 renew until 0=
5/13/25 13:29:50
>>>> 05/06/25 13:30:30=C2=A0 05/06/25 23:29:54=C2=A0 krbtgt/NWRA.COM@AD.N=
WRA.COM
>>>> 05/06/25 13:30:30=C2=A0 05/06/25 23:29:54=C2=A0 host/host@NWRA.COM
>>>>
>>>> and ssh to the Linux box, I can't access the nfs mount:
>>>>
>>>> -bash: /home/user/.bash_profile: Permission denied
>>>>
>>>> Ticket cache: KEYRING:persistent:30657:krb_ccache_efgrZpc
>>>> Default principal: user@AD.NWRA.COM
>>>>
>>>> Valid starting=C2=A0=C2=A0=C2=A0=C2=A0 Expires=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Service principal
>>>> 05/06/25 13:30:30=C2=A0 05/06/25 23:29:54=C2=A0 krbtgt/AD.NWRA.COM@A=
D.NWRA.COM
>>>>
>>>> I also notice that the ticket is non-renewable.
>>>>
>>>> If I then kinit I can access the home directory fine.=C2=A0 Other th=
an the new
>>>> ticket being renewable I don't see any difference:
>>>>
>>>> Ticket cache: KEYRING:persistent:30657:krb_ccache_efgrZpc
>>>> Default principal: user@AD.NWRA.COM
>>>>
>>>> Valid starting=C2=A0=C2=A0=C2=A0=C2=A0 Expires=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Service principal
>>>> 05/06/25 13:31:27=C2=A0 05/06/25 23:31:27=C2=A0 nfs/server@NWRA.COM
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 renew until 0=
5/13/25 13:31:22
>>>> 05/06/25 13:31:27=C2=A0 05/06/25 23:31:27=C2=A0 krbtgt/NWRA.COM@AD.N=
WRA.COM
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 renew until 0=
5/13/25 13:31:22
>>>> 05/06/25 13:31:27=C2=A0 05/06/25 23:31:27=C2=A0 krbtgt/AD.NWRA.COM@A=
D.NWRA.COM
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 renew until 0=
5/13/25 13:31:22
>>>>
>>>> Actually, I also notice now that there is a krbtgt/NWRA.COM principa=
l as
>>>> well.
>>>> =C2=A0=C2=A0 I wonder if that is the difference.
>>>
>>> Can you please check and compare the output of 'klist -ef' (which inc=
ludes
>>> additional info on enctypes and flags) in both cases? It sounds like =
the macOS
>>> client is forwarding a ticket that is not accepted by the Linux clien=
t's krb5
>>> library. This could happen if eg. the default_tgs_enctypes configured=
 in
>>> krb5.conf on the macOS side is incompatible with the permitted_enctyp=
es in
>>> krb5.conf on the Linux side.
>>
>> That does indeed seem to be the issue - but it seems strange.
>>
>> On the mac:
>>
>> Valid starting=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Expires=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Servic=
e principal
>> 05/07/2025 10:50:16=C2=A0 05/07/2025 20:50:16=C2=A0 krbtgt/AD.NWRA.COM=
@AD.NWRA.COM
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: FPIA, Etype (skey, t=
kt): aes256-cts-hmac-sha1-96,
>> aes256-cts-hmac-sha1-96
>>
>> On the Linux box:
>>
>> Valid starting=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Expires=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Servic=
e principal
>> 05/07/2025 11:17:25=C2=A0 05/07/2025 20:50:16=C2=A0 krbtgt/AD.NWRA.COM=
@AD.NWRA.COM
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: FfPA, Etype (s=
key, tkt): DEPRECATED:arcfour-hmac,
>> aes256-cts-hmac-sha1-96
>=20
> Can you please re-check the 'klist -ef' output on the mac once you've s=
sh'ed
> to the Linux box, ie. once also the host ticket is present in the ccach=
e? The
> TGT that ends up on the Linux system gets requested by the mac, which d=
oesn't
> know about the krb5 configuration on the Linux side,
> and therefore needs to guess the supported enctypes. MIT's libkrb5 deri=
ves the
> enctype to request for the forwarded TGT from the ticket for the target=

> service, ie. the host service in the case of ssh. On macOS, you're like=
ly
> using a Heimdal-based libkrb5, but I assume it uses a similar heuristic=
=2E
>=20
> If the ccache shows that related host ticket also uses RC4 enctypes, th=
is
> could be either due to the default set of ticket enctypes configured on=
 the
> mac, or because the AD computer account for your
> Linux system does not allow any stronger enctypes (see msDS-
> supportedEncryptionTypes attribute).

It looks fine on the Mac:

Valid starting     Expires            Service principal
05/09/25 09:05:31  05/09/25 18:32:46  krbtgt/AD.NWRA.COM@AD.NWRA.COM
        renew until 05/15/25 18:11:23, Flags: FfRA
        Etype (skey, tkt): aes256-cts-hmac-sha1-96, aes256-cts-hmac-sha1-=
96
05/09/25 09:10:05  05/09/25 18:32:46  krbtgt/NWRA.COM@AD.NWRA.COM
        Flags: FfA, Etype (skey, tkt): aes256-cts-hmac-sha1-96,
aes256-cts-hmac-sha1-96
05/09/25 09:10:05  05/09/25 18:32:46  host/LINUXBOX@NWRA.COM
        Flags: FfAT, Etype (skey, tkt): aes256-cts-hmac-sha1-96,
aes256-cts-hmac-sha1-96


> Either case would explain the weak session key in the forwarded TGT. Bu=
t then
> I wonder why the ssh login works at all, given that your Linux system o=
ught to
> reject the RC4 host ticket due to its restricted set of
> permitted_enctypes. So something still doesn't add up.

Things are definitely not adding up!

>> The linux box has crypto-policies:
>>
>> [libdefaults]
>> permitted_enctypes =3D aes256-cts-hmac-sha384-192 aes128-cts-hmac-sha2=
56-128
>> aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 camellia256-cts-cmac
>> camellia128-cts-cmac
>>
>> Shouldn't that prevent it from ending up with arcfour-hmac in the firs=
t place?
>>
>> I tried adding this to the mac without any change:
>>
>> [libdefaults]
>> permitted_enctypes =3D aes256-cts-hmac-sha384-192 aes128-cts-hmac-sha2=
56-128
>> aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 camellia256-cts-cmac
>> camellia128-cts-cmac
>> default_tgs_enctypes =3D aes256-cts-hmac-sha384-192 aes128-cts-hmac-sh=
a256-128
>> aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 camellia256-cts-cmac
>> camellia128-cts-cmac
>=20
> Those are options for MIT's libkrb5. Unless you're using a non-default =
stack
> on the mac, you probably want to use Heimdal's default_etypes, or the m=
ore
> specific default_as_etypes/default_tgs_etypes instead.

I ended up slimming down to:

  permitted_enctypes =3D aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96
  default_tkt_enctypes =3D aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-9=
6
  default_tgs_enctypes =3D aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-9=
6

but those are the option names from man krb5.conf on the mac.

I've set msDS-SupportedEncryptionTypes for the AD user to only allow aes =
to no
avail.

This seems like arcfour is disabled:

$ kvno host/LINUXBOX -e arcfour-hmac
kvno: KDC has no support for encryption type while getting credentials fo=
r
host/LINUXBOX
$ kvno krbtgt/AD.NWRA.COM@AD.NWRA.COM -e arcfour-hmac
kvno: KDC has no support for encryption type while getting credentials fo=
r
krbtgt/AD.NWRA.COM@AD.NWRA.COM

I tried enabling KRB5_TRACE during the ssh command, but it does not seem =
useful:

2025-05-09T09:15:21 set-error: -1765328234: entypes not supported
2025-05-09T09:15:21 set-error: -1765328243: Did not find credential for
krb5_ccache_conf_data/realm-config@X-CACHECONF: in cache
FILE:/tmp/krb5cc_1504398909_0a9FHZRC0q
2025-05-09T09:15:21 set-error: -1765328243: Did not find credential for
krb5_ccache_conf_data/realm-config@X-CACHECONF: in cache
FILE:/tmp/krb5cc_1504398909_0a9FHZRC0q
2025-05-09T09:15:21 set-error: -1765328243: Did not find credential for
krb5_ccache_conf_data/time-offset/host\134/LINUXBOX\134@AD.NWRA.COM@X-CAC=
HECONF:
in cache FILE:/tmp/krb5cc_1504398909_0a9FHZRC0q
2025-05-09T09:15:21 Setting up PFS for auth context
2025-05-09T09:15:21 set-error: -1765328234: Encryption type
des-cbc-md5-deprecated not supported
2025-05-09T09:15:21 set-error: -1765328234: Encryption type
des-cbc-md4-deprecated not supported
2025-05-09T09:15:21 set-error: -1765328234: Encryption type
des-cbc-crc-deprecated not supported
2025-05-09T09:15:21 set-error: -1765328234: entypes not supported
2025-05-09T09:15:21 set-error: -1765328243: Did not find credential for
krb5_ccache_conf_data/realm-config@X-CACHECONF: in cache
FILE:/tmp/krb5cc_1504398909_0a9FHZRC0q
2025-05-09T09:15:21 set-error: -1765328243: Did not find credential for
krb5_ccache_conf_data/realm-config@X-CACHECONF: in cache
FILE:/tmp/krb5cc_1504398909_0a9FHZRC0q
2025-05-09T09:15:21 set-error: -1765328243: Did not find credential for
krb5_ccache_conf_data/time-offset/host\134/LINUXBOX\134@AD.NWRA.COM@X-CAC=
HECONF:
in cache FILE:/tmp/krb5cc_1504398909_0a9FHZRC0q
2025-05-09T09:15:21 Setting up PFS for auth context
2025-05-09T09:15:21 set-error: -1765328234: Encryption type
des-cbc-md5-deprecated not supported
2025-05-09T09:15:21 set-error: -1765328234: Encryption type
des-cbc-md4-deprecated not supported
2025-05-09T09:15:21 set-error: -1765328234: Encryption type
des-cbc-crc-deprecated not supported
2025-05-09T09:15:22 krb5_rd_rep not using PFS

--=20
Orion Poplawski
he/him/his  - surely the least important thing about me
Manager of IT Systems                      720-772-5637
NWRA, Boulder Office                  FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/

--------------ms060808020009070701080607
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
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUwOTE5NTUw
MFowLwYJKoZIhvcNAQkEMSIEICsdm+nyQsn+sUMlqnuq5aksELVUY3zo1Im3Pdrgj+9LMIHL
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
K4EEAQ4BMAgGBiuBBAEOAjAIBgYrgQQBDgMwDQYJKoZIhvcNAQEBBQAEggEAU8mLcc43dGbt
XFHcpKBf0C/XEVqnaE/8/tS0ewOFMisaIZq9CMiq870ylGebmV44LJ0pBjSryU6NMyL9K0GP
wypw60T6BKnhbb7uO3rGUNhdnSmOvxghhyF+cKnm4W2y8Tdxz1exyE3uiRgwlL441qpZ/1Wo
6tcTYlDrusgFck7LeKDzhFBsqWXnOwrrgi3cfrKqPOj4hf4+l1rEH0OK1OXq06mMAW38Go5y
t68+bfK/gcBsKH54KCiu18G41hu0vVc2IplSKRl6pH4eVWOh8XKeBKFXloW6f47wlGKWBlkk
Rh0cpQyUbWdfvuIULK80qRASrTCuAztK/bLFOMZx5gAAAAAAAA==

--------------ms060808020009070701080607--

