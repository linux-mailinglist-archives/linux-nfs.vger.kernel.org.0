Return-Path: <linux-nfs+bounces-11218-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1192DA97B92
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 02:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413FC46081E
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 00:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B39EC4;
	Wed, 23 Apr 2025 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="H7BftkXo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2102.outbound.protection.outlook.com [40.107.220.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28681FAA
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745367287; cv=fail; b=bUBlKwaFFw7vO3RB8kmYbui6vBC/fmYzScCuFLrkETZPRoavHgV9l0vNEqIl27x5E79/3TNCslTaKaUMKaWdRfA1zYZsVNzJ9iq4YsA36BryohDKHwO595ZWW6PX3lLQ45pdxpsajDJ7sVc7PpAIf1JBdGr91zVXnfab/iq16j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745367287; c=relaxed/simple;
	bh=r/K+SN6iSNXtLjGOAYa1w+8EQwX/YxfjzChn9dGsQuQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lhm7A6lsH78eifF09JYChci60WUMFybp6DeD1q0adtaGOo+KpCCjqPlQ3Uopy4i2dlqYmX4F+d0Z613S+IkOXKbNEHHplVpnCiwRdTmv5mroBImtleU2jrLWX5O7JO7T818jfeaUsbgJ4Qog+myD2Z+zS7UKZmPcPZZkpseiaBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=H7BftkXo; arc=fail smtp.client-ip=40.107.220.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpDTOZeFjTaafrmS2nbN5Hh/cR67tl/9R4LJRecJp4fE2bTyZROw0EL56rbNuNAvLNtXT0IzQBn/il2Djd0J5mgOKwHRkmtY5Ds+EaJcPBTwSXwgsx731eeanlZtrUXyBmZfSYcuo7YNnmkQA7c5vDrvz1DdUe+c4pHUMJJhIJ5xJSfn4hRK5k9dmu4zjdwJ3NdHd9TgCv8KLWYhc7FXognLd9asymxlwRby3PUF/lgAMfgbBQr0NtNk4clLhL8/jxkgrW8g0T932ZuV80zqtIh+itNys3QQFuEvzCc1qAUVv2l98+SpV438QatUEIRCS1aTuEpDhgLy9l42K9IqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/K+SN6iSNXtLjGOAYa1w+8EQwX/YxfjzChn9dGsQuQ=;
 b=hb0hEOw8pTIFXyyRz4DOESVmpD1qhv3BuMOCF/eOL7/XZVnR9VpP3CPhJqSt9opBt+udMxuu8nLjSl5gNn7LmkbM/8/V/YppHZ4fsdC9BwSdpNtoQhjpaivfaPWpT4sJnIrBAM93aYuv+7XsLT4RhcHxe50p/8FeS0pWIOmEvlSAEtnBW/Oo2ZZOr9rZ5sxzk8I19PGctwkznJiKNOGzqspqmp+4AQL6701+SSbarrQoTrXEFzIW2I2hPogZSHlmJ91UA3KrPCtvmjiQwbMhuo8szTp8X+J06vJxgwgFeswJ4d6VHJgD8MmU/qaGdu4gNzIaF2JkvEGO0vE/zCORjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/K+SN6iSNXtLjGOAYa1w+8EQwX/YxfjzChn9dGsQuQ=;
 b=H7BftkXotfmg3P/mI3kXHvRZsubOQiRwiGjWHp5m/5kMSV9E4M9EeJwHNVgw4KZBRGlasQH3SoLNg846Y1l966f5dVgvETa4fZVvrcgKTT8CDmPwCBXS7vDfX6NvYbNcNqS8lpMn3jm2saJyZiMuzfYPkFDsJFgFocRbi9gvrQI=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 SN7PR13MB6067.namprd13.prod.outlook.com (2603:10b6:806:322::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.22; Wed, 23 Apr 2025 00:14:41 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%6]) with mapi id 15.20.8632.035; Wed, 23 Apr 2025
 00:14:41 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "neil@brown.name" <neil@brown.name>
CC: "snitzer@kernel.org" <snitzer@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS/localio: Fix a race in nfs_local_open_fh()
Thread-Topic: [PATCH] NFS/localio: Fix a race in nfs_local_open_fh()
Thread-Index: AQHbs9H4y38SJqV0UUuYADxMB7ojCbOwYcOA
Date: Wed, 23 Apr 2025 00:14:41 +0000
Message-ID: <e3fedef06b142901d0c8fd962a38671052de9eb4.camel@hammerspace.com>
References: =?utf-8?q?=3C3d2d3ade569302f7d52307d71e0fe1c46fc95f32=2E17452614?=
 =?utf-8?q?46=2Egit=2Etrond=2Emyklebust=40hammerspace=2Ecom=3E?=
 <174535921354.500591.6488717737987093498@noble.neil.brown.name>
In-Reply-To: <174535921354.500591.6488717737987093498@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|SN7PR13MB6067:EE_
x-ms-office365-filtering-correlation-id: 537844d0-cfed-4ab7-a83b-08dd81fbd7cf
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q3BTemhLWE5IMEdJTDlmQ20vckRjYmszdXBZQTh4ZjluSEdIZEJ5Zm5mSlZ1?=
 =?utf-8?B?Z09qOUdjU09JajI2b0JldDV4L2pmc1dDb0p1ak9xRklDWm9VTDJ2Qm5XS01Q?=
 =?utf-8?B?MzRieEgzNXhlb3pRTXNVU1dJbCtSdzAxbUZFR0VkNzRQMW1uell5QzkyVmcv?=
 =?utf-8?B?TW5WNFFCcEs2TklveHdmZXRsNThkbHFac0ZCWmxLcFBndVJEZHptMDU5eHY0?=
 =?utf-8?B?dUZkTUs1NWhQb3BZRDNkTGhZMWZmbEdjY21DUm9OcjJVL1d4ZEsyK01ycFls?=
 =?utf-8?B?dmdwRVBwT2tDQU1UK09vaGpNZXVwaXU3ZUEwclRSVzlWWDZJYTdOb0Qrc2pH?=
 =?utf-8?B?c0t4WWxQL3BFZ2xpRmFHVy8zZjJHUWV1eXI4RXJKT3hKUGZGVjN2aTdUalJN?=
 =?utf-8?B?VjlTY0dKcjlhY2poRGhRQjNLR3NJN0Y4RW5seDc3TnFqUnV6VU4yUVlFM1hB?=
 =?utf-8?B?SUFUaTVwczEzZlEyRnBGRHJDakpGQWcwbnREMGhaTEtNczN2eU5hMzRlamVQ?=
 =?utf-8?B?ZzAxZ2x1SmZrV21XcVFaR3l5WWd1emhNcGRyOWk4VkFUcHN4L29QZFlYQ1pP?=
 =?utf-8?B?ZS9weXlUcyt0N3FlamNkNXpDNkZMWnAzZUVaL29TVThSczd6eTd3dG5mVjlm?=
 =?utf-8?B?TXRBenBHbzBGWVowQ3JSdEg5STJ5T205dk9sYWNEUTM4TjB4dTZwSzBMcnBY?=
 =?utf-8?B?dGxDNFNhMldUUmZxck4rSG9ablhreWhtazY5Y3JyZE1pbDZORmFwN3A1NVQ1?=
 =?utf-8?B?MVhHc1NtdjdNbVo1cW9iMEt2anhTMU5naTdzMWUydXlZaFR6Y0x1Nm84cUNZ?=
 =?utf-8?B?dUpUNE1vbDRIUzJqb3lISFBvMWZWZkk3aDYrdWJUOE1JOWw3UytPTnN0VkRi?=
 =?utf-8?B?cURSRVRoZXZ3cXNIUkRxUExqSUU4dEh0WE1tUThPa2VLZ0FBWStBT3lGZW5t?=
 =?utf-8?B?ZVM1ZVpZK0R2a21TY1FJT1BsYmpobW5BUnVjMFNCUytISG9WSStBOFlKSlRQ?=
 =?utf-8?B?TGppQnRueHJkbEZxOWlUMzJaMWtSRGZxQjlKNTRPUHAwNkJBazNUQmliL0xP?=
 =?utf-8?B?cGdoM0xDNVJJTnhTQVNRbG5ienA5UWh3OXVxWXhSdjNKdWdtcGNpelkyTG43?=
 =?utf-8?B?c0p1N293TDBMSm9URWExYlMrOEFiUDV2UlNNQTZLWDFDSW1rV3pDdml3OW9B?=
 =?utf-8?B?Z0VrM1lZbzlTWVc4RzRKQ25CQlVUNlRKVW1CYjdMdzNPeXpvNEhWTmYxTVdk?=
 =?utf-8?B?QWFLNFE1VUprWWdFVU95L3VUYXlta2Q0L25LbGQyeUp3bUdkZ3p4d0JNejli?=
 =?utf-8?B?dk9vVjk1Z0E4bTVUbmFscDhWeFp1NlluclIwUlpRd1dycm5GMjJEVWh4aXNH?=
 =?utf-8?B?dis2czJoN3hQOHd1T2VBWi9WUTk5WUFOT2wzNERTVHFiOS9CaFFEQzRRWDFJ?=
 =?utf-8?B?UDd4QTByN2tQSVRzQ2xUUC9mZnJmVm1WRm1aMEhDMDZwUi9LSFEvUWliNHZS?=
 =?utf-8?B?SXZJdEZSME1lQUh3WjBDMmhYaDg3VUorNVFLYjRJTS8xT2NsVHpMc1g4enVL?=
 =?utf-8?B?blYybmM0enlwc1JZRHVQTHM1N2J3aUZIbXloRXMxR2poa1o2TlNHOEdlT1J2?=
 =?utf-8?B?eW90Qi93Vi9sT2JVdk01L1Rab3N0YlFlVmxCKzZLMTdoQ0dIdWF5WTE4K2lE?=
 =?utf-8?B?bDZ3U0Q1bTFVU3BjQllhTjZNZ2xvZWZ4Qzd4cXlIZlFvWG4vZklONk4xTkxU?=
 =?utf-8?B?USsxNDNQeWFtMlJmVklpQitzT1ZWRCtKeE9GTTlVSUREVm5uY0kwbjZPd2VG?=
 =?utf-8?B?ZXBVSWROZVdBbFhxN2l5WDI4R2c0UlpSYVJDQ2dHSHgzd3NpR21QZ1FKcHN6?=
 =?utf-8?B?NE9qNWc2MUo0VWtVTTlUQ0xJbVVYNkJzdlhOZTF1Ui8ybGthRnM5cldsR3gv?=
 =?utf-8?B?RGRDMFRtNm44ZXVKZzNPdkd6MG53NEo3NWwwUUVrU3MwcDVoalJ3WTNQZHY0?=
 =?utf-8?B?SXZ4bDhUVi9BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVpoVHlvaCtUdmlDM3orRTVxUXhIUnh4VVZ2K25JalFqNUtGN25HT0NyckNi?=
 =?utf-8?B?clA5LzRzV3pVOWVsN1ZQYXhyMDl4a3lDMHV2ZU1ZdjB1VTN2WXFiV3pIZFRR?=
 =?utf-8?B?VVRzVVdxam1sVDJHR2U4SngwZEtGd2s3ZklzdkZqVU5BNG93SmVLbW8vL3cz?=
 =?utf-8?B?Y0VtTjdRejM1QkVZdjlmNE9oUlNFREdMYzJ1QjR2aG5Uc3FuTWRBZkt4N3hW?=
 =?utf-8?B?ditOdWtLTC9TdnZlRGE2aGlHRkxKakRycm9BRGlKdnVNL3BTaFdma1ZrZHRn?=
 =?utf-8?B?YVNtQUU2NW1ob0NyZjZ2aWIzTitoeGVITGhSclpiRkpJMnlDaWM0M0xLanlG?=
 =?utf-8?B?akU2dCt0MnV3dy9UNml6VHFFZVA0V2F0NVg0cFR1V3J6d3kwT1VIWm85Z084?=
 =?utf-8?B?YU9PUzdpYm1Uc3A3OHdPV1AvRm9ZeXFZNnlxME1QbUhIdWJGek1nNkJVNlQz?=
 =?utf-8?B?dEZBVDdjcGxWYkczMW5IalUwRGN3a0dwNjhMUWhieitqeURadXpTRmkveEsx?=
 =?utf-8?B?dC8zSFdpdlZ3S3dxQ1RDNTErS1Zicm5OUUd5Q21KWUxPS2ZJQTRlVEUzbTVS?=
 =?utf-8?B?WGk3RVJxMjB3Z3FDWXk2WlNMZWtEUW1hS1Nrcng3V3dJN0swbWRSUFl6TGZL?=
 =?utf-8?B?OFZNQWR2NW1vUE1WK2dCRy96cjI5bERCTzgwQXBQS3BzaUlKUFJqMU5VRnFa?=
 =?utf-8?B?OUNNd0VUM0ZCeUVXTVU5SFlkM29TNmpwQjFRY0JzZW5adVJjWlRqUEU4UEs4?=
 =?utf-8?B?Y2pvMDVGTGU1UkhrSHFDckhCWmFLYnVLYXBHQTY3cnVlVVVqRGlqUm5LZHYr?=
 =?utf-8?B?blVTdSttaVZ3RHVDcWNUWnYyZjhjNmg1Rkd4OFVWUUNkUjNHeWZFRURzb1J5?=
 =?utf-8?B?UWg4eHU5a0c3YnY5RGZCSEJ2VXZDVUJ5Snh0RFZTMFJOYWVHZ0w0ZGNCblVH?=
 =?utf-8?B?Sjl6VlVBZ09GMUxWdkN4VWN0ZDI1LzJQQUFubE8wY2RsdEJmTHg1Ti81NjZn?=
 =?utf-8?B?SkxkMElPdGlIOW1lZW01MVdob08vYnp6c2hKOUJISEp4TGVBN0t2MHg1OVdn?=
 =?utf-8?B?YURQUUdFVkdIamJjMzhSSXVMY0tMeVA1M0llVUNnRGkyOXIyMXVVbGV4dFhO?=
 =?utf-8?B?UzJPS2VOaWg0cVZyOUxGNG5VbnZCSTE2am5peXg2UEp0Z2I4VTg4MWpESC96?=
 =?utf-8?B?b1lWM2dGWDhEaFlYdXU4a0QvQlh0RlJzU3FXTlUzbUVsd2NrejJDMm9OT2Iz?=
 =?utf-8?B?Ly8rcWZDNm1QL0p5ejBrcDBSNURUZWlxSUZWQnJsR2VVK3NHRG9KT2lqeDdm?=
 =?utf-8?B?NTlrZml3VnArOEpEbjYwVGRiYlR6MFNNYVJmYWZGSXVRQlhzUWZzRlc1TmYv?=
 =?utf-8?B?T3VIMEZTY1BnMjZRNytKTmRpbGxiNTc2MjZZUHB6QjhJNFI0ZERxVWI3aVVB?=
 =?utf-8?B?cjhkcXJMeGNieFdxeEpnYzFPdnFNVnRtendkZHJQZ0JyVS9IRWk0UU0xWnJT?=
 =?utf-8?B?L3ZwY3A5MlFJeVVVRzZ6aUFtWEFydTJ4NTdYcTNjL3hSdDk1Mkdiam5UTUtv?=
 =?utf-8?B?NEU0UXdQZW1uZ3crRUIxV3cwOEhKeFR1VUgyTmVHYUVTa3NDb0NnckNBbjlB?=
 =?utf-8?B?UitEUzVtWm55RmExRm9SK0FRcDlVQzdaSUpOK3dsS2I4U1o2T0UzTzNwM2p2?=
 =?utf-8?B?MlYvTkNsaE5BaUJpdTRNZmp4dzBKc2NrUUU5VmprTCt0dU5Wclp2ZWU1dWp6?=
 =?utf-8?B?b0ptK1dCcDdGZXBuYXRPUHlRNzFGY1hwaGxSa0FXU3ZpSTdMaHM1SFh5V293?=
 =?utf-8?B?NytFaE1QMXpHelo2Mmd6K2tFbmQ2dXpPY2NUMDU3bWg5d3VCMnRCREhxWFZR?=
 =?utf-8?B?K2RUaFEyNU5vYytsOXdTbjJkVUx0N3FpbHFYaGdsK1JMWXh0NTFZbWxwQzg4?=
 =?utf-8?B?UURtUHZDUFYzdktMZjA0SzdocVBJUGtydTZDb2xLcDRoaldaV2luVjl2M3BC?=
 =?utf-8?B?Q2lMT1JlODFPS281ZllGRE9rcGhaQU02M1g0RXlpTEpPZVlhYUt0RFBubG4x?=
 =?utf-8?B?ZzdDVjQxRnZ3QlBEbjVPZWltUVR1QU00cHdMbU5VWWtLN0RLUUZuTm5FYlAr?=
 =?utf-8?B?dy9sWS9LRTU0bmlXclJHVHpGb1VmdWw3TG04Qnk3S3VuWGRueFBkVXRpR00z?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10EF25890E82AE4F83A87ECC0372F544@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537844d0-cfed-4ab7-a83b-08dd81fbd7cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 00:14:41.3752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i45VS1fNlnUAB63g3rv1itsxNkckG4jYCxkcW343mrwe6LJVwQHMzaXbkSQmd9KklW6D+ayQt+1mn3QDpZ66Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR13MB6067

T24gV2VkLCAyMDI1LTA0LTIzIGF0IDA4OjAwICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFR1ZSwgMjIgQXByIDIwMjUsIHRyb25kbXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gRnJvbTog
VHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IA0K
PiA+IE9uY2UgdGhlIGNscC0+Y2xfdXVpZC5sb2NrIGhhcyBiZWVuIGRyb3BwZWQsIGFub3RoZXIg
Q1BVIGNvdWxkIGNvbWUNCj4gPiBpbg0KPiA+IGFuZCBmcmVlIHRoZSBzdHJ1Y3QgbmZzZF9maWxl
IHRoYXQgd2FzIGp1c3QgYWRkZWQuIFRvIHByZXZlbnQgdGhhdA0KPiA+IGZyb20NCj4gPiBoYXBw
ZW5pbmcsIHRha2UgdGhlIFJDVSByZWFkIGxvY2sgYmVmb3JlIGRyb3BwaW5nIHRoZSBzcGluIGxv
Y2suDQo+IA0KPiBJIHRoaW5rIHRoZXJlIGlzIGEgcmFjZSBoZXJlIGJ1dCBJIHRoaW5rIHRoZSBi
ZXR0ZXIgZml4IHdvdWxkIGJlIHRvDQo+IHVzZQ0KPiBuZnNfbG9jYWxfZmlsZV9nZXQoKSB0byBn
ZXQgYW4gZXh0cmEgcmVmZXJlbmNlIGVhcmxpZXIuwqAgVGhhdCBlbnN1cmVzDQo+IHdlDQo+IHdv
bid0IGxvc2UgdGhlIG5mc2RfZmlsZS4NCj4gDQoNClllcy4gVGhpcyBwYXRjaCBvbmx5IGVuc3Vy
ZXMgdGhhdCB0aGUgYWRkcmVzcyBwb2ludGVkIHRvIGJ5ICJuZiIgc3RpbGwNCmNvbnRhaW5zIGEg
dmFsaWQgb2JqZWN0LiBJdCBkb2Vzbid0IGd1YXJhbnRlZSB0aGF0IHRoZSByZWZlcmVuY2UgY291
bnQNCndvbid0IGJlIHplcm8sIG5vciBkb2VzIGl0IGZpeCB0aGUgaXNzdWUgdGhhdCB0aGUgaW5p
dGlhbCBkZXJlZmVyZW5jZQ0KdG8gJypwbmYnIG1pZ2h0IGJlIG5vbi16ZXJvLCB5ZXQgcG9pbnQg
dG8gYW4gb2JqZWN0IHRoYXQgaGFzIGEgemVybw0KcmVmY291bnQuDQoNCkknbSBub3Qgc3VyZSBo
b3cgbXVjaCB3ZSByZWFsbHkgY2FyZSwgc2luY2UgdGhvc2UgcmFjZXMgc2hvdWxkIGJlDQpleHRy
ZW1lbHkgcmFyZSBhbmQgd2lsbCBvbmx5IGhhdmUgYSBwZXJmb3JtYW5jZSBpbXBhY3QgKGFzIG9w
cG9zZWQgdG8NCnRoZSBleGlzdGluZyBwb3RlbnRpYWwgdXNlLWFmdGVyLWZyZWUpLg0KVGhhdCBz
YWlkLCBhbHRlcm5hdGl2ZSBwYXRjaGVzIGFyZSBkZWZpbml0ZWx5IHdlbGNvbWUuDQoNCj4gSSdt
IHdvcmtpbmcgb24gYSBwYXRjaCBpbiB0aGlzIGFyZWEgd2hpY2ggSSBob3BlIHRvIHBvc3Qgc29v
bi7CoCBJdA0KPiB3aWxsDQo+IGFkZHJlc3MgdGhpcy4NCj4gDQo+IFRoYW5rcywNCj4gTmVpbEJy
b3duDQo+IA0KPiANCj4gDQo+ID4gDQo+ID4gRml4ZXM6IDg2ZTAwNDEyMjU0YSAoIm5mczogY2Fj
aGUgYWxsIG9wZW4gTE9DQUxJTyBuZnNkX2ZpbGUocykgaW4NCj4gPiBjbGllbnQiKQ0KPiA+IFNp
Z25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbT4NCj4gPiAtLS0NCj4gPiDCoGZzL25mcy9sb2NhbGlvLmMgfCAyICstDQo+ID4gwqAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZnMvbmZzL2xvY2FsaW8uYyBiL2ZzL25mcy9sb2NhbGlvLmMNCj4gPiBpbmRleCA1
YzIxY2FlYWUwNzUuLjRlYzk1MmY5ZjQ3ZCAxMDA2NDQNCj4gPiAtLS0gYS9mcy9uZnMvbG9jYWxp
by5jDQo+ID4gKysrIGIvZnMvbmZzL2xvY2FsaW8uYw0KPiA+IEBAIC0yNzgsNiArMjc4LDcgQEAg
bmZzX2xvY2FsX29wZW5fZmgoc3RydWN0IG5mc19jbGllbnQgKmNscCwgY29uc3QNCj4gPiBzdHJ1
Y3QgY3JlZCAqY3JlZCwNCj4gPiDCoAkJbmV3ID0gX19uZnNfbG9jYWxfb3Blbl9maChjbHAsIGNy
ZWQsIGZoLCBuZmwsDQo+ID4gbW9kZSk7DQo+ID4gwqAJCWlmIChJU19FUlIobmV3KSkNCj4gPiDC
oAkJCXJldHVybiBOVUxMOw0KPiA+ICsJCXJjdV9yZWFkX2xvY2soKTsNCj4gPiDCoAkJLyogdHJ5
IHRvIHN3YXAgaW4gdGhlIHBvaW50ZXIgKi8NCj4gPiDCoAkJc3Bpbl9sb2NrKCZjbHAtPmNsX3V1
aWQubG9jayk7DQo+ID4gwqAJCW5mID0gcmN1X2RlcmVmZXJlbmNlX3Byb3RlY3RlZCgqcG5mLCAx
KTsNCj4gPiBAQCAtMjg3LDcgKzI4OCw2IEBAIG5mc19sb2NhbF9vcGVuX2ZoKHN0cnVjdCBuZnNf
Y2xpZW50ICpjbHAsIGNvbnN0DQo+ID4gc3RydWN0IGNyZWQgKmNyZWQsDQo+ID4gwqAJCQlyY3Vf
YXNzaWduX3BvaW50ZXIoKnBuZiwgbmYpOw0KPiA+IMKgCQl9DQo+ID4gwqAJCXNwaW5fdW5sb2Nr
KCZjbHAtPmNsX3V1aWQubG9jayk7DQo+ID4gLQkJcmN1X3JlYWRfbG9jaygpOw0KPiA+IMKgCX0N
Cj4gPiDCoAluZiA9IG5mc19sb2NhbF9maWxlX2dldChuZik7DQo+ID4gwqAJcmN1X3JlYWRfdW5s
b2NrKCk7DQo+ID4gLS0gDQo+ID4gMi40OS4wDQo+ID4gDQo+ID4gDQo+ID4gDQoNCi0tIA0KVHJv
bmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQo=

