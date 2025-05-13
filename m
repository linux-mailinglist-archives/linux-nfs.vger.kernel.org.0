Return-Path: <linux-nfs+bounces-11668-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE9FAB487B
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 02:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A721B41F2B
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 00:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DFD3FB0E;
	Tue, 13 May 2025 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="CDKTWCYz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2121.outbound.protection.outlook.com [40.107.92.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBDB17BD3
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 00:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747096565; cv=fail; b=kmo300jLmQMMwxzcQlGX3HKuX9bFo8sAbie7Y+j6NntUS6UTfM7TZBEfF9MOcc58IZADqrhe4ks85ezR4FM7CjZSKRMJWAqIdS4pL52G05nFcaPWPhqCNFUTaqxUm8mXXxUpMiqztI90bKShreOWf7IcbNbRtn7FyqT9t19e1QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747096565; c=relaxed/simple;
	bh=aMcCNhSOvevgPmx8KD0i72BVyXCPZIPZ6znbk6EbbEw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f7QxWugoYAGN93zG0XXyu18ifXHWCwf2vZoDReTeKkVBnnpdjMh+KZRgKG2xls2sLhlHT0q3/9ilMOeKbqiAgz/S8eTBmQaVHBKG46a1YtxeYp8ws0RwUfZa5kDD8KzB9wHFZ2yxjwh2ZOGKDgRwDkf9d59YgZfaXM2ZiJmXCb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=CDKTWCYz; arc=fail smtp.client-ip=40.107.92.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFoqUAsKDeIq20YtunDd3rIFx+xx3DcNSCJeWlgdxjCBSRygUR78eywMzCQIAAQJXWWyKSsObQL53tmtfV+jvuMwG4zwPyL2INIPthFvYV33fTZQxmEAOnnRM5F7Tgm5C2khxsEjP5CyFx2nDGWMyH6tai8gRZlDaUeQg+SVfO4Fgz+E8r0rHHkaLwvgoY/dHikCWPkby+rF0ZL8orpQFonsVY1Aht9c4rOIzMBxjkSIT0z+kktu9Ve9XUekKRrRRgMU8T4xDeEShkieWrUNJPrCCbIlaU4BCKbQ9vYT0gs3I3O2hZu/HOOOC8o1gpPKzA1WHxte8nYGVZ4s9XUmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMcCNhSOvevgPmx8KD0i72BVyXCPZIPZ6znbk6EbbEw=;
 b=Qam4jDPQNlFgWAwNrmCJhdNX8PkuEpJXSLr649bxwQs7PXDR9V/9BlsmeWDw66XLj7yjcDqUhnBLfn6zt81xkbCmmkTEVdYjRsz/2XgXQgUCwvuurlPRdF3ib+2sGJo/8hnVN6+vUXzcffs9ducBEEN23XAosM1HAlK3L9o7rQiSM4GWcTPG0Qnpg00FevCl8+8CY23AN9csyv6OJs22Z9MCjf1GRKy+9PnZuNkioNr8Ra4S7evcKfS++eNyS/r4Ih0UgGD0l3cdCBGVkTYsNQ7TMBArFh4xf+rXtAfzi01k+7ASvevmVcEEP4+CtHxvHjlaUb1nIJB4HX/bVwUc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMcCNhSOvevgPmx8KD0i72BVyXCPZIPZ6znbk6EbbEw=;
 b=CDKTWCYzc/Y0bqtgzvR5bUH4+zge30BMWIxyy7uiMsoUHXWErCOrKbErbvIPayRnpItPIk4Ku1A29xr/QHi3W0AKKn14dJrEzIO6akO3EV3c9w55j3a2sOrIab/t/mPL0aYXrJh343V28QFYsHWc6NePIEgHRzzs5AE9A1Tbvx0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ2PR13MB6403.namprd13.prod.outlook.com (2603:10b6:a03:566::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 00:35:56 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 00:35:56 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "osandov@osandov.com" <osandov@osandov.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"clm@fb.com" <clm@fb.com>
Subject: Re: [PATCH] NFSv4/pnfs: Reset the layout state after a layoutreturn
Thread-Topic: [PATCH] NFSv4/pnfs: Reset the layout state after a layoutreturn
Thread-Index: AQHbwnihi+d3mg9/R0KcvwzlM9JAHrPNce0AgAHpLQCAAF3tAA==
Date: Tue, 13 May 2025 00:35:56 +0000
Message-ID: <7dfefee0e85b8e2392c57179946d0dd2a075aae7.camel@hammerspace.com>
References:
 <956259d72ee10ad81fd49daa8f2daf12644dc50f.1746970063.git.trond.myklebust@hammerspace.com>
		 <67c41c84df54b67c0dbbe01dc1076a4070eb5e82.camel@hammerspace.com>
	 <787cefa341d5f75ab6a0ab137089ca3fd12e2ce7.camel@kernel.org>
In-Reply-To: <787cefa341d5f75ab6a0ab137089ca3fd12e2ce7.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ2PR13MB6403:EE_
x-ms-office365-filtering-correlation-id: 6059f28a-80ee-4df6-1c5a-08dd91b62001
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K0t0WFNEajJxVTl5WHR1VEdFNDZLbmt2UUl5NWw3QWlHTDZlWXAvaG9HanBQ?=
 =?utf-8?B?QTMxbDg1R3RWaHIwT2RoTTNKNXJjSTVMUlJaQkFJa0VLZ21JbjlOMjI5cXZh?=
 =?utf-8?B?THFrOE02S2VubU5wbElVM0lqbmhrUXRUSHVZZ1dTeHJlc21Ga1VIdXNxaW9W?=
 =?utf-8?B?WDJGc2IxcksrZ3hMZGJJK2djS1pLWDAreEMzN0V5WHg1aWx0ekZRQ1lPLytR?=
 =?utf-8?B?RThvT3ZMdFJ2dHhqZFZ5VVlXZGhHemM0S2kzQmo4ekErME1zV2JZbTlpUGxW?=
 =?utf-8?B?Z2JaWitlSk8wbEYzcVNxVHo0Y1pJejhLN2szWFlReDFwVUk5Q0gvU2EvRlFo?=
 =?utf-8?B?RWJMMGZOWEtGbnBhOG1mUFdCUFB6STljTFhwSmllWDgvc0JTcHl1YWdndUZ4?=
 =?utf-8?B?OVE4VGNpVEJuTmtOaGhqL2xQTWdBaVNIbDd5b1RvRG8reUd5S2I3QWE3RGRG?=
 =?utf-8?B?Mk50VW9RNVE2dnVJSFBUTkZxRExSSFRLUmR6dFJ6ZE13RTk1dGQrTis1Z0N2?=
 =?utf-8?B?RGcyUllJalN3NkV4dEhyU0lGSzI4RlJodWNrb2VJeTBjRmpqMHBHUjJyVXFh?=
 =?utf-8?B?UXVLWHd0SS9KVWttTXJObDQ2ZlhLOTI0QndpNUorUXluMWkwVS9qVXM4eTNr?=
 =?utf-8?B?U0xjN2lRSnlRa0JlQVhJWUVDUGttZVZOckdTNGlubXVqVm51Vk9hRFY2MCtC?=
 =?utf-8?B?Q1k1YTVTcHorNzdFV0NFZkN1LzUzMXVFR1A3cndFVkw4M3BPakNQb1pFdDEz?=
 =?utf-8?B?cE16dUZRKzNwWHRvNmlnY0tGdXdQVGljdFI3MmRFY0Y4bDZRTXkvQnhMNTB5?=
 =?utf-8?B?VEloZ3U0cFFKSlRuMlI1eUVwb3RKUGd3SnFKWjgxekUwaTRBejlYY0dkdTV2?=
 =?utf-8?B?NXJVdmRCbnFVWFkxcWU5ZDJOWXMxUzFONnN3L05FOUlnWEVnbFZEQ1BLYlNw?=
 =?utf-8?B?K3VtWENUUXFSeXRJUHpRMkVqRjRuZXBIN01LT2x3OG54eXRzT0h5cXB3djNE?=
 =?utf-8?B?cFJuYk8yV1FNbTRXOHFNeE5VeWhRSmpjcm44aEZ4OVovRUVrVERubGpkTEkv?=
 =?utf-8?B?YVd2RzExOExkMnkxYjQ1OEVrRjdrK3Z3K1J3V1FmWTZ2WVoxaHJ0M2lJREwz?=
 =?utf-8?B?ZFdNSjYyL0dMZVlKUnRFbjBBZnZ4bWhXZE5SUlBrRzRmZU1tSkpOQndmdVY2?=
 =?utf-8?B?ZWJYZG51Mkd2Um9sN3UvcVc1aTlFNm40VlNNVlZoVGVNN2t4aUdIRzJ5NnlK?=
 =?utf-8?B?MEFjcE9hcUl3c1Jic3VqaFBSSkU2UGNrWklvdDhrZ3ZlWjFDMm13SmZzUThs?=
 =?utf-8?B?eXYvbVlEd0VBRUliWVN5RFpxdzJJQWFwN0xMdFF0SHllQ0N6akhYOEF3d0h4?=
 =?utf-8?B?ZnRmUEpLUWZGQkhxaWswLzlvelhQQlNVOVRNcUp2NzM5RTlTV0RiT1hVSW5j?=
 =?utf-8?B?RSttZSs5ZW1ZUGFobWhXUEprRTZaSDVNUUZPMlFTZ1k4UGVtSzdXd3dCR3Vm?=
 =?utf-8?B?ejBYVUhSQ05HOVBBMEVWSXRDWEtxTzR5VFlXZFQyeW5JV0JWNGo4U0lmQ3Rh?=
 =?utf-8?B?SWtlNVc5bm9jL25VQ2pGWC9xVVEyN0Fra0IrTDB4bWF0MmtHcktBMXRFRkFI?=
 =?utf-8?B?ZTB3eHBzeDk2cElYTjMraCtLWGNISytHMy9ocUhUS2JIRGhlTnREN215bXNN?=
 =?utf-8?B?SlhmR1Zla3Q5T3lwd1hKVjVNaE1GaDh3ajl2TlBMUFNONGdueWRBVDdPS1Ji?=
 =?utf-8?B?L0IvdzhpNldVOEVBeE5ZNDk1YUwydFp5bXkrVVRIMmtCdk5iMDJnUVZUY3ZR?=
 =?utf-8?B?SG9mcFcycWI0QkZ5WW1LNDdmbWlqYWVnYzZqSkZyN3d1VU1jY25VUFBaUHpR?=
 =?utf-8?B?VHczZzJzcXRxUXFSOEt1TFJmMnFlSFJMYmExbk5pWUZpOFFHR1NaUjVBRzE0?=
 =?utf-8?B?aWt0bzA1dE5PTkhodjJ4TXZLcXBUcEZ5OHBBVEhuMERZOE9CSnpZV01qNDlX?=
 =?utf-8?B?TXg4ZzJ5N0ZnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yk9CaWhFUXgvK3ptOUg5a2xvb1NuOGxOQjY3cjJrUkxNbG1BV2Q4QlF0c3Fa?=
 =?utf-8?B?bXhNcGNUTWhWYWFuK3AwUnlGeVdEWWRJVmpGV09hVHB2Sm42SThwZVU2eDht?=
 =?utf-8?B?aHlGSHVaejlpTXZadnRXdXE3YjRZZTNBYzVQaElKR2pYcm9PNm5RMnJhNEs3?=
 =?utf-8?B?TGJQd2t1ek5yR0JSNjZFV1BxWWZlVWtYZ0xCY04wNDA3YXlPUHFyY1QxS2JE?=
 =?utf-8?B?bGlJUlNINUprUHNrQTFYOE42ZVJrWUNqR09iZ1dyWjJIVWFOSlNJUWFtaGF6?=
 =?utf-8?B?aWZWbEV2UkNXN2NZV1BPelloRWZtUm1PaDluanVhaURFbWhwVE12MkJodG5h?=
 =?utf-8?B?aTNSSkthQmJkMHkwRHRFV2d1bnNqUStwWnIvOFNQb25vMCt6U2d3S0ptcE1L?=
 =?utf-8?B?QmlETTFha3RLMWZ0S1FPQmVCVmR2RzUzNHNwV2tGK2RaVWkvaEkrMW1ZSDBP?=
 =?utf-8?B?ZjBRY2w1ZUFtS0lmVjBxTlZVQm5pWFlDbEdQc1A1MDVpV1FlUEhlYVE4V0lj?=
 =?utf-8?B?SlVvVEpYRDE5SzZuanp6K21wNWwrbGFJME55dDlUNWpBWU9razFVT05BRGR6?=
 =?utf-8?B?QnV5cXRVbXBSdWlJcnFlQ0t1aE03YUVnS0FGc0EvRFhWQXBOZU1DTlBNMXl4?=
 =?utf-8?B?bVVVeFQ2VnVRTW1HbkxxRlVtY0JtWDRXeWJtMWt4ODhLWWR2eURTRGJ2T2ta?=
 =?utf-8?B?MEI2WUZrY3Rsb1VqN08zTjJYY25XZm1Wckt3YnlqMGExZ3hKNDdhSVVRM1NS?=
 =?utf-8?B?KytQK0RSSHJ2YXU3TTBSSDVmaVYzMUw4T0JRY2x5akNYMEJjVklySGVDM3pQ?=
 =?utf-8?B?NWxyY0N3YnlPdUYvZVpDWmlhUzdTQVY0aVgrNXg0R1VNM3JNZk16cmJmQ0hv?=
 =?utf-8?B?b0U5UEhBRjcxL1cvRVU5VUhtSGtGdi9TSDFyM29aWitadjhiNDBVcmRkemZR?=
 =?utf-8?B?M0QrcUN0N0R3N1BRRDRLdXFFa1Rzb2hnSGlBUXAvUUZ5N1R3QWhvQXU0Rzdj?=
 =?utf-8?B?NGtnTnB6L04xbVFvNXRTTk8zUXg2V0RGZ1VIWlhSOHNPNXpuMnk1Z2JZL0tE?=
 =?utf-8?B?d1k1LzlxYnNOQVQxOW9UanZwNStzMjdtN1JNY1B1SU0rVTdveDkwbmFmUW5O?=
 =?utf-8?B?d2NpYU5kdjNSK0lnSjJrUDR1cDl3QVdtVmNmcEVZS3pzVGZLblJQYnRjSFlP?=
 =?utf-8?B?cWtYUDNqdWJBdk11MzJYZmtyKzZ3WGdCN2N5bDN6MEJHZ3dZZ2VlS1BPVFlx?=
 =?utf-8?B?dzZ2YTEwQUxIZXdMcjM3L3JFYVFwV2pyUnV2b3VLQVNPTXJHTlB3TFhrSkxT?=
 =?utf-8?B?bUZ5RFloTnBYZXcvMDM2UGFzZUZHRGdDWkZSMXNKcXM4ektwOVpYNk40SFZt?=
 =?utf-8?B?dkdIZW5ZaWo0QUhUaTNYVkczNlA3OE1WbjBaZHl1NlU2Q29vTVlIVFRFZWhv?=
 =?utf-8?B?UzVBeVlaRWN4T01tOEViR1c0RFJFUHowZ2ZZOG9tZ0g2VEQ4NFFqeWpDbVhW?=
 =?utf-8?B?Q3psQWtPeXJyZm5XUjdlZlhsc2RNd1gyTUkxV20wNXBRUHBsdjVnbmIyQ21j?=
 =?utf-8?B?N0N1NVQ5UU5PKys2N01qSlJ2bzdMV1FaWFZORHhZOTlYNE9FRjdlTWNVaDhX?=
 =?utf-8?B?U3dROThFbno3S21ESXpEYUhpUnI1ZjhiT1FaMmptNW11Y0pORGRxOTZIQlhR?=
 =?utf-8?B?WGlrc1JGaWQ5TE4vUDg0M2hmbUwreGNTZlZBUC9XZlBTMHJqUFZaSlZyRHlo?=
 =?utf-8?B?SFEzb1lQSzRpL1BXWXczTGtORitvSmY2UDNNa1BTRHhUZXdsZHpzR0kyYmZy?=
 =?utf-8?B?TVg5YkZhYW5EejJ1MDh1dWhIQ2pSaWswc1dwKzhQQnVNU2ZtUW5pQVI2U216?=
 =?utf-8?B?SzRyNitnTTUwaEZHa0gxOEN4K1ErSXRzaERFTUVXaE52TVZmb1hpcVAyT2Jr?=
 =?utf-8?B?SjhVS3lvOGVUTmdwZG9zRkpUL29YbDZjelVWTFo0NjZ2VzZrOFRwUE1Gc3hv?=
 =?utf-8?B?RHFVWlRoSkRzdlpQNnRRRVJrTGZ5V1FUcWxzVEZCVW1za3hmUmRZNTdIZkZJ?=
 =?utf-8?B?c3FBcFR1OFlwS0xKbGQra2ZjKzd4M0RDcFFiTHdhb3BUMmtlZFJLM0RkVEEv?=
 =?utf-8?B?WXJSVzhKc2E1a2pubktKQUp6Q3lxcjY3Rzk0RTZvMFpWZldQZi83dEZ2TGNx?=
 =?utf-8?B?MGVDZWEyQ3Fab1Z3emFsSjBhTnI3bzkrU1dDUkcySURkZTIvWWRBRFU5M1cy?=
 =?utf-8?B?bWZMVEVSbllRYU1XNStvdll4VG5nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77949EA1A7976D40804D1D70E8CDBCD3@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6059f28a-80ee-4df6-1c5a-08dd91b62001
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 00:35:56.3425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +uS8HLb6zNgrDkeozyxG9etasREOLzMgh8FFTwlR63j8b9JPXdWMg1RhhTvBgnIyAlmBff4y0h+oDoGcnffjSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6403

T24gTW9uLCAyMDI1LTA1LTEyIGF0IDEzOjU5IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gU3VuLCAyMDI1LTA1LTExIGF0IDEzOjQ4ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gSGkgSmVmZiBhbmQgT21hciwNCj4gPiANCj4gPiBPbiBTdW4sIDIwMjUtMDUtMTEgYXQg
MDk6MjggLTA0MDAsIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gPiBGcm9tOiBUcm9u
ZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gPiANCj4g
PiA+IElmIHRoZXJlIGFyZSBzdGlsbCBsYXlvdXQgc2VnbWVudHMgaW4gdGhlIGxheW91dCBwbGhf
cmV0dXJuX2xzZWdzDQo+ID4gPiBsaXN0DQo+ID4gPiBhZnRlciBhIGxheW91dCByZXR1cm4sIHdl
IHNob3VsZCBiZSByZXNldHRpbmcgdGhlIHN0YXRlIHRvIGVuc3VyZQ0KPiA+ID4gdGhleQ0KPiA+
ID4gZXZlbnR1YWxseSBnZXQgcmV0dXJuZWQgYXMgd2VsbC4NCj4gPiA+IA0KPiA+ID4gRml4ZXM6
IDY4Zjc0NDc5N2VkZCAoInBORlM6IERvIG5vdCBmcmVlIGxheW91dCBzZWdtZW50cyB0aGF0IGFy
ZQ0KPiA+ID4gbWFya2VkIGZvciByZXR1cm4iKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQg
TXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+ID4gLS0tDQo+
ID4gPiDCoGZzL25mcy9wbmZzLmMgfCA5ICsrKysrKysrKw0KPiA+ID4gwqAxIGZpbGUgY2hhbmdl
ZCwgOSBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvcG5m
cy5jIGIvZnMvbmZzL3BuZnMuYw0KPiA+ID4gaW5kZXggMTBmZGQwNjVhNjFjLi5mYzdjNWZiMTAx
OTggMTAwNjQ0DQo+ID4gPiAtLS0gYS9mcy9uZnMvcG5mcy5jDQo+ID4gPiArKysgYi9mcy9uZnMv
cG5mcy5jDQo+ID4gPiBAQCAtNzQ1LDYgKzc0NSwxNCBAQCBwbmZzX21hcmtfbWF0Y2hpbmdfbHNl
Z3NfaW52YWxpZChzdHJ1Y3QNCj4gPiA+IHBuZnNfbGF5b3V0X2hkciAqbG8sDQo+ID4gPiDCoCBy
ZXR1cm4gcmVtYWluaW5nOw0KPiA+ID4gwqB9DQo+ID4gPiDCoA0KPiA+ID4gK3N0YXRpYyB2b2lk
IHBuZnNfcmVzZXRfcmV0dXJuX2luZm8oc3RydWN0IHBuZnNfbGF5b3V0X2hkciAqbG8pDQo+ID4g
PiArew0KPiA+ID4gKyBzdHJ1Y3QgcG5mc19sYXlvdXRfc2VnbWVudCAqbHNlZzsNCj4gPiA+ICsN
Cj4gPiA+ICsgbGlzdF9mb3JfZWFjaF9lbnRyeShsc2VnLCAmbG8tPnBsaF9yZXR1cm5fc2Vncywg
cGxzX2xpc3QpDQo+ID4gPiArIHBuZnNfc2V0X3BsaF9yZXR1cm5faW5mbyhsbywgbHNlZy0+cGxz
X3JhbmdlLmlvbW9kZSwgMCk7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gwqBzdGF0aWMgdm9p
ZA0KPiA+ID4gwqBwbmZzX2ZyZWVfcmV0dXJuZWRfbHNlZ3Moc3RydWN0IHBuZnNfbGF5b3V0X2hk
ciAqbG8sDQo+ID4gPiDCoCBzdHJ1Y3QgbGlzdF9oZWFkICpmcmVlX21lLA0KPiA+ID4gQEAgLTEy
OTIsNiArMTMwMCw3IEBAIHZvaWQgcG5mc19sYXlvdXRyZXR1cm5fZnJlZV9sc2VncyhzdHJ1Y3QN
Cj4gPiA+IHBuZnNfbGF5b3V0X2hkciAqbG8sDQo+ID4gPiDCoCBwbmZzX21hcmtfbWF0Y2hpbmdf
bHNlZ3NfaW52YWxpZChsbywgJmZyZWVtZSwgcmFuZ2UsIHNlcSk7DQo+ID4gPiDCoCBwbmZzX2Zy
ZWVfcmV0dXJuZWRfbHNlZ3MobG8sICZmcmVlbWUsIHJhbmdlLCBzZXEpOw0KPiA+ID4gwqAgcG5m
c19zZXRfbGF5b3V0X3N0YXRlaWQobG8sIHN0YXRlaWQsIE5VTEwsIHRydWUpOw0KPiA+ID4gKyBw
bmZzX3Jlc2V0X3JldHVybl9pbmZvKGxvKTsNCj4gPiA+IMKgIH0gZWxzZQ0KPiA+ID4gwqAgcG5m
c19tYXJrX2xheW91dF9zdGF0ZWlkX2ludmFsaWQobG8sICZmcmVlbWUpOw0KPiA+ID4gwqBvdXRf
dW5sb2NrOg0KPiA+IA0KPiA+IENvdWxkIHRoZSBhYm92ZSBidWcgcGVyaGFwcyBleHBsYWluIHRo
ZSBpc3N1ZSB3aXRoIGxlYWtlZCBsYXlvdXQNCj4gPiBzZWdtZW50cyB0aGF0IHlvdSB3ZXJlIHNl
ZWluZz8NCj4gPiBJZiB0aGUgY2xpZW50IGRvZXNuJ3Qgc2V0IE5GU19MQVlPVVRfUkVUVVJOX1JF
UVVFU1RFRCwgYW5kIHRoZQ0KPiA+IHNlcnZlcg0KPiA+IGlzIHVuYWJsZSB0byByZWNhbGwgdGhl
IGxheW91dCBkdWUgdG8gdGhlIG5ldHdvcmsgZ2V0dGluZyBzaHV0DQo+ID4gZG93biwNCj4gPiB0
aGVuIGl0IHNlZW1zIHRvIG1lIHRoYXQgdGhlc2UgbGF5b3V0IHNlZ21lbnRzIGp1c3QgZGlzYXBw
ZWFyIGRvd24NCj4gPiBhDQo+ID4gYmxhY2sgaG9sZS4NCj4gPiANCj4gPiBJT1c6IHRoZSBzY2Vu
YXJpbyBpcyBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPiA+IMKgKiBUaGUgY2xpZW50IGhvbGRzIGEg
cmVhZCBhbmQgYSByZWFkL3dyaXRlIGxheW91dC4NCj4gPiDCoCogVGhlIHNlcnZlciByZWNhbGxz
IHRoZSByZWFkIGxheW91dC4NCj4gPiDCoCogVGhlIGNsaWVudCBjbG9zZXMgdGhlIGZpbGUgd2hp
bGUgdGhlIHJlY2FsbCBpcyBiZWluZyBwcm9jZXNzZWQsDQo+ID4gc28NCj4gPiDCoMKgIHRoYXQg
dGhlIHJlYWQgYW5kIHJlYWQvd3JpdGUgbGF5b3V0IHNlZ21lbnRzIGFyZSBib3RoIHB1dCBvbiB0
aGUNCj4gPiDCoMKgIHBsaF9yZXR1cm5fc2VncyBsaXN0Lg0KPiA+IMKgKiBUaGUgY2xpZW50IHJl
dHVybnMgdGhlIHJlYWQgbGF5b3V0LCBhbmQgY2xlYXJzIHRoZSBhc3NvY2lhdGVkDQo+ID4gcmVh
ZA0KPiA+IMKgwqAgbGF5b3V0IHNlZ21lbnRzLiBUaGUgcmVhZC93cml0ZSBsYXlvdXQgc2VnbWVu
dHMgYXJlIHN0aWxsIG9uIHRoZQ0KPiA+IMKgwqAgbGlzdCwgYnV0IHdpdGhvdXQgTkZTX0xBWU9V
VF9SRVRVUk5fUkVRVUVTVEVEIGJlaW5nIHNldC4NCj4gPiANCj4gDQo+IE1heWJlPw0KPiANCj4g
VGhlIHByb2JsZW0gSSB0aGluayB3ZSBoaXQgd2FzIHRoYXQgcG5mc19wdXRfbGF5b3V0X2hkcigp
IGdvdCBjYWxsZWQNCj4gYW5kIGl0cyByZWZjb3VudCB3ZW50IHRvIHplcm8gd2hpbGUgdGhlcmUg
d2VyZSBzdGlsbCBlbnRyaWVzIG9uDQo+IHBsaF9yZXR1cm5fc2Vncy4NCj4gDQo+IHBuZnNfcHV0
X2xheW91dF9oZHIoKSBjYWxscyBwbmZzX2xheW91dHJldHVybl9iZWZvcmVfcHV0X2xheW91dF9o
ZHIoKQ0KPiBhcyBpdHMgImxhc3QgZGl0Y2giIGVmZm9ydCB0byBjbGVhbiBvdXQgdGhlIHBsaF9y
ZXR1cm5fc2VncyBsaXN0LiBJdA0KPiBsb29rcyBsaWtlIHlvdXIgcGF0Y2ggd2lsbCBlbnN1cmUg
TkZTX0xBWU9VVF9SRVRVUk5fUkVRVUVTVEVEIGlzIHNldA0KPiBvbg0KPiBhbGwgb2YgdGhvc2Ug
ZW50cmllcywgYnV0IGlmIHRoYXQgZmxhZyBnZXRzIHNldCBkdXJpbmcgdGhlDQo+IHBuZnNfbGF5
b3V0cmV0dXJuX2JlZm9yZV9wdXRfbGF5b3V0X2hkcigpIGNhbGwsIHRoZW4gSSB0aGluayBpdCBt
YXkNCj4gYmUNCj4gdG9vIGxhdGUgYW5kIHRoZXknbGwganVzdCBsZWFrIGFueXdheS4NCj4gDQo+
IFNvIEkgZ3Vlc3MgdGhlIHF1ZXN0aW9uIGlzOiBpcyBldmVyeSBlbnRyeSBvbiBwbGhfcmV0dXJu
X3NlZ3MNCj4gZ3VhcmFudGVlZCB0byBnZXQgYSBmaXJzdCBhdHRlbXB0IGF0IGEgTEFZT1VUUkVU
VVJOIGJlZm9yZQ0KPiBwbmZzX2xheW91dHJldHVybl9iZWZvcmVfcHV0X2xheW91dF9oZHIoKSBp
cyBjYWxsZWQ/DQo+IA0KPiBJZiBzbywgdGhlbiB5ZXMgdGhhdCBzaG91bGQgZml4IGl0LiBJZiBu
b3QsIHRoZW4gSSB0aGluayBpdCBtYXkgbm90DQo+ICh1bmxlc3MgSSdtIG1pc3VuZGVyc3RhbmRp
bmcgdGhpcyBjb2RlKS4NCg0KU28sIHRoZSBwb2ludCBpcyB0aGF0IHBuZnNfbGF5b3V0cmV0dXJu
X2JlZm9yZV9wdXRfbGF5b3V0X2hkcigpIHdpbGwNCnRha2UgYSByZWZlcmVuY2UgdG8gdGhlIGxh
eW91dCAoaW4gcG5mc19wcmVwYXJlX2xheW91dHJldHVybigpKSBiZWZvcmUNCml0IGtpY2tzIG9m
ZiB0aGUgbGF5b3V0cmV0dXJuIFJQQyBjYWxsLiBVcG9uIGZpbmlzaGluZyB0aGUNCmxheW91dHJl
dHVybiwgdGhlIG5mczRfbGF5b3V0cmV0dXJuX3JlbGVhc2UoKSBjYWxsYmFjayB3aWxsIHRoZW4N
CnRyaWdnZXIgYW5vdGhlciBsYXlvdXRyZXR1cm4gYXR0ZW1wdCB3aGVuIGl0IGNhbGxzDQpwbmZz
X3B1dF9sYXlvdXRfaGRyKCksIGFzc3VtaW5nIHRoYXQgTkZTX0xBWU9VVF9SRVRVUk5fUkVRVUVT
VEVEIHdhcw0Kc2V0IGJ5IHBuZnNfbGF5b3V0cmV0dXJuX2ZyZWVfbHNlZ3MoKS0+cG5mc19yZXNl
dF9yZXR1cm5faW5mbygpLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0K

