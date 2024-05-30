Return-Path: <linux-nfs+bounces-3495-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B34208D51B5
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 20:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61FE1C22981
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 18:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEF045BE7;
	Thu, 30 May 2024 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="IsNt52P4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2128.outbound.protection.outlook.com [40.107.244.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709E4F217
	for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717093323; cv=fail; b=WOucVnNPmU2sxmKbhebzShq4YTAxMRIr4amhFjpcSgPJGycRH7zkL8KfXZC5tJmehGVpbpNEGv26tlRRyBRSTvN5X9HU7HtxrAE+Jx7+knGY4eP5HpTsz2ca1XJrezp6Xril2WBXXxhE/J0HapA4VerbXaME7afSf66jHLA9nvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717093323; c=relaxed/simple;
	bh=oTmy3sOotW9HGlf5Z4lgG2+3EBxWR4EryHic7XDAXkA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rVES4i4SqLVbc8M8QAF3wmdVxP+ca4P7ECFhf/dRYF1gInm9VY4gJDVgopMZ++1L5HVDgTV35wKdwI05XAKXTZCDErcV7JBtzi91/9jVJPYXqq/yZDtXYoonauNnXfOPydt7cO+lDLoR+N7nR9mzEqdARtmsZn/DUoNiFxJRPmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=IsNt52P4; arc=fail smtp.client-ip=40.107.244.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fR8xr/wPLBmdOW+YifBcMtYgLw8OKrbGC2+ha6SssmRDWZYO61KBYH3Qq+Gh/rTtbjtUbvT/g5RdoGK97Mrf+pkcXLzqosG05s96trV5rHLyHrauQ/XJCGJSe5e0n98bv+mxmbPbOBo9qH3aEU2SEnC7rwJMYigCxkjrgPqIaJOvSKoVZOZa/A+esqv7PViIm0BnU/SGe73yYrNGh5XxPhVJR1QZ/7dY1GY3f/omt+tBG+AdlQ9naOafJ8tjV9jH+TaZa+8pGsAvWOeLEMGXFpNHd/Vluoze64cxDhA76mjaQF97RDTdxld2Fn7359LakxvtlkZoZQyPbgbSew+cow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTmy3sOotW9HGlf5Z4lgG2+3EBxWR4EryHic7XDAXkA=;
 b=e23IvJ/uUFOxQKscGt6pGKTtV9HF2qF3XP2rwoF/fC2BG02pw1kOoCqBBSl1sWFUJiJfxq9ndUom9eOc/13MuZgTLyEq4EtBXoFi2wuFCO/ejCxAv9IExHme0bmequZA54fa85d4WO6R9JKSvs5rLVgCL45elfAVXqJFnxvcxnMUP9K8QVt3ODhDMH3KpZc4/iIkHYmB2wM1l9/RFEOae9wyxHJpnOpzz1EdDcyx8R2/CESTJ2/8azrt+7o+QB9l+ovBEeYAuqSckrs2MzZXeIydWv9uhpTumniXaPtUpQokfZUVUqWkm+fhER7skt9m9cPcQrKaINrj8CQBEC0/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTmy3sOotW9HGlf5Z4lgG2+3EBxWR4EryHic7XDAXkA=;
 b=IsNt52P4K6+kXd3xS9ZApDPf971F1MKrJFTe0K5wzbtcxi4fSh58Hxm4YEgZyKAFR9mzdKwt27GORlnj3akxlsw2nt7Jj0W5OQnXLnLlHXzI3GLYln2iSt4pfgxtAW/Qj+djQJhK5IV50Aaq8W/fyhCRrnZZqKixwJDu5NFdLaQ=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 IA2PR13MB6563.namprd13.prod.outlook.com (2603:10b6:208:4b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 18:21:57 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%6]) with mapi id 15.20.7633.001; Thu, 30 May 2024
 18:21:56 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "jlayton@kernel.org"
	<jlayton@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "dan.aloni@vastdata.com"
	<dan.aloni@vastdata.com>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
Thread-Topic: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
Thread-Index:
 AQHaq36jqWobVAzhLU+0cOtTOPPg4LGhrPIAgAAczACAAAIIAIAAD5+AgAHNXICAABdvgIAABFSAgAxdVYCAAAOpgA==
Date: Thu, 30 May 2024 18:21:56 +0000
Message-ID: <f3c1ffe903c9b2dd9fcd131bdbab731ea1c4027e.camel@hammerspace.com>
References: <20240521125840.186618-1-sagi@grimberg.me>
	 <fa1a77fee6403454444fffce839924157778df95.camel@kernel.org>
	 <ac2bfa20-d952-4917-8a70-1e821f9b57ca@grimberg.me>
	 <d5409ff9ce51e439f442abb1cded7c7ab732b726.camel@hammerspace.com>
	 <4d2bc7f1-b5c2-469c-9351-772626c707d7@grimberg.me>
	 <c1d98e76-1b5c-4d91-a7fe-9412df7c2fab@grimberg.me>
	 <e4e181e4a7b2db4b27b6ce3e6bb26b23e514cdb1.camel@hammerspace.com>
	 <81fa32fb-c5a3-4af8-a8ca-08905a8b62ef@grimberg.me>
	 <ea5efcf6-4414-4a66-ad2e-9e9060bf5dbc@grimberg.me>
In-Reply-To: <ea5efcf6-4414-4a66-ad2e-9e9060bf5dbc@grimberg.me>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|IA2PR13MB6563:EE_
x-ms-office365-filtering-correlation-id: 603eee88-9e69-4a15-5be7-08dc80d56396
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?V05JSkhjc29GMjM0N0QrQUhYc0ttZHZOenlzWXVqcVRlMWh6c2xuMkJEZ3dY?=
 =?utf-8?B?Z0dwVHJiWUdWQkRpVVZwQnBFRUpjb1ZwbUR4bW9ieGprNmxmUkJsZENCRWFn?=
 =?utf-8?B?NG9weVpEcUJYSWtzeUs4Qy82Z2x4eG51L093ZVdSSHVpSG12WElDODROcFZ6?=
 =?utf-8?B?UTJ1NnNwZXFtbnEveExPTThwcWN1cWxueVJiTGJQNERqQWpYMHNacjJWU3pU?=
 =?utf-8?B?Q0FlcjdKSlRCOUtaR1VlcnZmOFg1SkdMcXVFRFh6L0J2M3EyNlFQSnZHUitj?=
 =?utf-8?B?SlBhajNtMTB4U0pKczl3Skhaem1xSjg3TWtHVTQ3Mmp4V2tIWTIvOVRqQU1O?=
 =?utf-8?B?QS8zS3VaemhrL3lFVktRMGcrUkZSWGd6TXlWSWd3RDBlenlxUi9zdG0wcXAw?=
 =?utf-8?B?RFdzcW85cVZ5cUx5S21tdmdWUk9wcEVSRjNMRWEyZU9uR2h1a1IyMjRUWG80?=
 =?utf-8?B?Z3N4UFlkbDcwMzl4Wm4yaTlqWEQvTUxBZ3d1TE9zZDBpQmh4ZnM0T0VMV2xh?=
 =?utf-8?B?S3g1a0s3eXlGcExNTWdUeWJrOWtPVk12VUd4dFRUcHk1dlA0a1hxWGFrdjJR?=
 =?utf-8?B?dWtEWHduY1ZWSElLZGZKQ2hxY1dKa2IvekxlTGZYVGU2a3EvMUFGUkszK1dE?=
 =?utf-8?B?UkFtNjhHZ2FxVU94ckprOCs0R0diU29SSG9OaEZPZlo1eS82bnRRK3AwbnlX?=
 =?utf-8?B?S1BCNnIvSE1zL0hZS1p4c2NWNWdacDVld21kLzJ3Z3JTSzV5NHJ5VFFYU01Q?=
 =?utf-8?B?bThRbjB1V3NEMk91dklnVTFCRUtLMlV3MUJ4WG1Nek1EQ0hXSEVIOTVPdjcw?=
 =?utf-8?B?c1RndnJyZWhkcUxWNHM2RDl3Njk2V1hlejRYdFJWVFFwUlFhanBMTStSRzA2?=
 =?utf-8?B?UFVjZFZKYU45UFkydXRvN1hjbExhTVZUcHh1TngzRG5hMCtvcEFHYnBVaFl1?=
 =?utf-8?B?eXNUYTNOSFdlZ1ZRM2lHeGMvRXpQbkVuUGVsc2pubnVLK3pidnJsTmhMMzFY?=
 =?utf-8?B?UFVRUnZDWUhrcWhoSnZPS09jcy8wNXpna3pNaXRqbm5HV1hDMGNhRkh2Z2Fo?=
 =?utf-8?B?aDgwb0xBTmp3UHg4dlNyN1FaQlBtVEdTV1hEcDNCYkMwQTFGMkZDY0x5WTZi?=
 =?utf-8?B?SjZ1Q1o0c1hJTzY3ZnZnMnJBT2gxMDVhQVFpTWJXVERiUTR3c0xhOGd4dE40?=
 =?utf-8?B?UlZkWlhDSVdTbUN2UzJiaFNramgwRGIxVXZTRUFCM0gwWmpHNXVyZXBmWTFj?=
 =?utf-8?B?bXJOQ3hYSzNNM3J3K1hwTmRndHNUbEFFM1FJQnlpak5hY3BwNkZLOGNubTFn?=
 =?utf-8?B?VVkxTWhjZU1VZkJDVXhVWmx2eEpIVnF2QTA3RnBJU1hBb1AyVnBEZXpWQ3Vm?=
 =?utf-8?B?bVh6aWVLdkRZUmZZTEZJVm10OFVsQ0tKR1RPZVlKRm40VGRyNk9kaFc5RWlv?=
 =?utf-8?B?NExnTjRZdStCeVVPNWpzK21hZnkvbFA2WVdJSERrc2pMenZKeGJhL2hYYVJN?=
 =?utf-8?B?eW03UlIwWDVlYU9JWVFlUC8xVnQ1R1FvV3lac0d4UFhPMGYwaE1yWmc0eElz?=
 =?utf-8?B?MURpeitQeFI3NmpoN0hNQnFMNVU2UGhzUFNBYjJEQXBZWDlPWEh0Y25yOUlW?=
 =?utf-8?B?YnZzSDJhdFNNYVRkbDFMMUFSeVJHVTAvaDE0akZ1M21GclJ3VEJxK3lZT1ND?=
 =?utf-8?B?UUdGcGFJa1RyNjZzTk1RUy9EVUttZFFmVUJUazIvU2svUENPUklPNG5nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGp2YlNlZldiMmNIaHBpN0NmVGhIMkMzUG9LQjJQRDZ3RVVxWmY4SVJMYzlK?=
 =?utf-8?B?dWdTNTNKWXNzY2NaM0JxaU9EK0ZqSklyeDJnc0xZMnllRDYwSDN1L05hSzhJ?=
 =?utf-8?B?WGFIem5TWkFrNkl6YXVxUzJ4cGdBU0Z2eDhnZ3ZKMksrckJvcjBGenoxd0V3?=
 =?utf-8?B?TnU5UzEyaTNaaXBQN1JyaitMNytaQkJEbVZBZG5rRWhFZEM1YkpQWXc5T3J3?=
 =?utf-8?B?OHhhMU9UYkJpNDBreWNOc2hOdUt0M0U3ZkxRV2tLYWNUS0RLZCtwMTRNWnhq?=
 =?utf-8?B?STNnS2E2STNGSjJBYTYxZ3lGMS9GdjJES0xONVEzWC9vMmRXN3F0WnlIODFk?=
 =?utf-8?B?eEUvcHE0WUZhMjRqQTEwT3I0d1JLci94NkkyOGRjdFJUMjlsSUVpcWFGanpj?=
 =?utf-8?B?d0pqTFhxYjFRZDdBWnVYRmhUM1I2Q2FJUTFaNjZVVEVpZzFndXV5akpXUDlC?=
 =?utf-8?B?OUt6ZitVR1RKYktHZUV0SitzLzEzamt5YTQ3cDRqRGRFNEtLWEloQk1qdTkv?=
 =?utf-8?B?NG5sUGFqdUxxWWlxU3FMZUYrY1diNk9nNUhsM2NXSVBjSkRKNkF4ZksxOXR4?=
 =?utf-8?B?VWR6SnZrb3ZtTGhHanVoYmdsN1Z4YmRjK3EzUG5VOHh4UUVwQzF5NXlHdld1?=
 =?utf-8?B?dHV3cE5ZaFZycWdRTTYzeUpkbWg2dnd4alF6WHlpZUJXL1d5azRobzQ1eENS?=
 =?utf-8?B?UVpBNElwVFZwRVIwb0VpYW4xUGpjaE1XNmZzcVdldjdSSEorN2ZGZVV6QkFq?=
 =?utf-8?B?eGFiUmhPMVJuU25IK0liYlJCZ3Z2UDEzcFRBSlNVVnpKcnRjOUg1VExzRE1W?=
 =?utf-8?B?WnRJMVI3Z2MyQVVNSzdyZ0tORThEK0pvSjlXa2NXOU5uaExJcmY2RUdCRHFZ?=
 =?utf-8?B?UU5Bb0hlbG92V2dRZEJja3BpU0kyY1AvbGIzTUxBRXNGVzVUalgvOUc3eHdE?=
 =?utf-8?B?WkZuKzZnbGFBL2RYYUdkT1J3S25JNjZNenhrMVJEbWt6bExuTng5aDNIcVds?=
 =?utf-8?B?ZEZ1RXRHMEZqcWhsa05teUIwN1JRMW5ZZklOQW5FOEI3a3NnaXZ0UjRJUkht?=
 =?utf-8?B?SzExUFhIVHpYTUs5eGU2clVIWExXVFZUaXRFbjRZaGlhOHJMYWhaRGs5Skk0?=
 =?utf-8?B?bmp2QTJtZ1RjeHo5SXJsdTJYeDl3bWE1M016YmxDQXRUNTRUWDhMUkFTZy9M?=
 =?utf-8?B?MXZmTkc0K1FHeTVrdUg5MVY1UDVhNkFYYUd6Mmx4S1dWRk0rQ0JIb1Vma05F?=
 =?utf-8?B?eWhTSHlXVlVoTU5vQ0V1NjJ6aU1yaEM3dFRLbEg2dm5YM3dBOVBmWk1udGRT?=
 =?utf-8?B?OHNjUnRwQ0F1eTRxMzRyYzFtNnMyc09Ba0NXaUI5SlFlWkN0anVpU0FoUHFq?=
 =?utf-8?B?b3dvV0JvQm9SaHY1Y0FSeFh1U3lNclMwOS9wR0piRVB2bFFUZEtSWjM2RFlm?=
 =?utf-8?B?RTFQY1BJTGQyOVRYT3o4YXNWRlRUSk9ka2xTQU00SVFhekVnelc2YWJUOVdp?=
 =?utf-8?B?ZXRsMDg2eSsrYU8vMXlsc1ZiWEI4VUIzVG5kME0ydVVyVnp2NnppZ09GTUQr?=
 =?utf-8?B?ZXRMZkRvVjFQZUcyZ3JvMU9wVks4VmZwdktIVHZHNFFXRDJqeFA2Z1Q4dTd0?=
 =?utf-8?B?SlJ4aVREYlBpRjRvOXpsVXU2T01lRzAyMDRrNlBLNDRHZ0FQWlQ3aFRVMGdN?=
 =?utf-8?B?Nlp0U3QvWUQ4enFad3NwNlR2OXY5ZGhjUk9lR0dMU0RxT0JLOGN6R24vR2xi?=
 =?utf-8?B?R3dUbEpCYnl5MUIrMGpPaG1SV1hKQzh2dVc1aENqQkNCbWxFdUZ4bG1wak1E?=
 =?utf-8?B?eXV4aEJlS0xMcFp5bGJSNmhWSkxVOGM3SlRBM0x6elZRSUN4SmZrbXBBaDNP?=
 =?utf-8?B?S29ZbTQrM0NQOXp0L1g4cU9tT1dBaVZNclFhNHRNdjRQREJwZ0JyeDFFemVN?=
 =?utf-8?B?cUlrOUprK2M0VkkzRTVaK2d6dDcrWkp3M0FzZW5Qc2E1aUdzSGVhd3RyNDZF?=
 =?utf-8?B?VXlOTjhsbjZRd0FKZXk0eWxiNjhENnlROHMrazRpRzRHcithK0lFSURYemFY?=
 =?utf-8?B?YzlKaU9qM3lBcU9XQ0JNYTY5K015ZlQ2elkramdUK1VLWCs1RnNTVlNES2I2?=
 =?utf-8?B?WStpSlZVdTZnS0ZZenF4UTRORHRVWTZjaVVWQXVtSENqRzZaNWc4NmFZMVFV?=
 =?utf-8?B?NnZERmlMT1N5R2IrTlVvZElzWmxyNHRlbXlOd2VpbldWeG1JNUFRcTA0VGVl?=
 =?utf-8?B?NnNpQUxqcHhhZnpjRTZXMGptcnRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B923B9CD3DE064E833E36265D1DB290@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 603eee88-9e69-4a15-5be7-08dc80d56396
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 18:21:56.6613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABjOkt8EMHXXn7VyqXPMmccKGM7/WkB6uxNHabE0VnjIU4f3IK2MGT6dcqKJq2Ql9E6l3m6enRdVLTovEMomUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR13MB6563

T24gVGh1LCAyMDI0LTA1LTMwIGF0IDIxOjA4ICswMzAwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0K
PiANCj4gDQo+IE9uIDIzLzA1LzIwMjQgMDoxOSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gPiAN
Cj4gPiA+ID4gU28gd2hhdCBkbyB5b3Ugc3VnZ2VzdCB3ZSBkbyBoZXJlPyBJTU8gYXQgYSBtaW5p
bXVtIE5GUyBzaG91bGQNCj4gPiA+ID4gcmV0cnkNCj4gPiA+ID4gb25jZSBzaW1pbGFyDQo+ID4g
PiA+IHRvIG5mczRfZmlsZV9vcGVuIChpdCB3b3VsZCBwcm9iYWJseSBhZGRyZXNzIDk5LjklIG9m
IHRoZSB1c2UtDQo+ID4gPiA+IGNhc2VzDQo+ID4gPiA+IHdoZXJlIHN5bWxpbmtzIGFyZQ0KPiA+
ID4gPiBub3Qgb3ZlcndyaXR0ZW4gaW4gYSBoaWdoIGVub3VnaCBmcmVxdWVuY3kgZm9yIHRoZSBj
bGllbnQgdG8NCj4gPiA+ID4gc2VlIDINCj4gPiA+ID4gY29uc2VjdXRpdmUgc3RhbGUgcmVhZGxp
bmsNCj4gPiA+ID4gcnBjIHJwbGllcykuDQo+ID4gPiA+IA0KPiA+ID4gPiBJIGNhbiBzZW5kIGEg
cGF0Y2ggcGFpcmVkIHdpdGggYSB2ZnMgRVNUQUxFIGNvbnZlcnNpb24gcGF0Y2g/DQo+ID4gPiA+
IGFsdGVybmF0aXZlbHkgcmV0cnkgbG9jYWxseSBpbiBORlMuLi4NCj4gPiA+ID4gSSB3b3VsZCBs
aWtlIHRvIHVuZGVyc3RhbmQgeW91ciBwb3NpdGlvbiBoZXJlLg0KPiA+ID4gPiANCj4gPiA+IExv
b2tpbmcgbW9yZSBjbG9zZWx5IGF0IG5mc19nZXRfbGluaygpLCBpdCBpcyBvYnZpb3VzIHRoYXQg
aXQgY2FuDQo+ID4gPiBhbHJlYWR5IHJldHVybiBFU1RBTEUgKHRoYW5rcyB0byB0aGUgY2FsbCB0
bw0KPiA+ID4gbmZzX3JldmFsaWRhdGVfbWFwcGluZygpKQ0KPiA+ID4gYW5kIGxvb2tpbmcgYXQg
ZG9fcmVhZGxpbmthdCgpLCBpdCBoYXMgYWxyZWFkeSBiZWVuIHBsdW1iZWQNCj4gPiA+IHRocm91
Z2gNCj4gPiA+IHdpdGggYSBjYWxsIHRvIHJldHJ5X2VzdGFsZSgpLg0KPiA+ID4gDQo+ID4gPiBT
byBJIHRoaW5rIHdlIGNhbiB0YWtlIHlvdXIgcGF0Y2ggYXMgaXMsIHNpbmNlIGl0IGRvZXNuJ3Qg
YWRkIGFueQ0KPiA+ID4gZXJyb3INCj4gPiA+IGNhc2VzIHRoYXQgY2FsbGVycyBvZiByZWFkbGlu
aygpIGRvbid0IGhhdmUgdG8gaGFuZGxlIGFscmVhZHkuDQo+ID4gDQo+ID4gU291bmRzIGdvb2Qu
DQo+ID4gDQo+ID4gPiANCj4gPiA+IFdlIG1pZ2h0IHN0aWxsIHdhbnQgdG8gdGhpbmsgYWJvdXQg
Y2xlYW5pbmcgdXAgdGhlIG91dHB1dCBvZiB0aGUNCj4gPiA+IFZGUyBpbg0KPiA+ID4gYWxsIHRo
ZXNlIGNhc2VzLCBzbyB0aGF0IHdlIGRvbid0IHJldHVybiBFU1RBTEUgd2hlbiBpdCBpc24ndA0K
PiA+ID4gYWxsb3dlZA0KPiA+ID4gYnkgUE9TSVgsIGJ1dCB0aGF0IHdvdWxkIGJlIGEgc2VwYXJh
dGUgdGFzay4NCj4gPiA+IA0KPiA+IA0KPiA+IFllcywgSSBjYW4gZm9sbG93IHVwIG9uIHRoYXQg
bGF0ZXIuLi4NCj4gPiANCj4gDQo+IEhleSBUcm9uZCwNCj4gaXMgdGhlcmUgYW55dGhpbmcgZWxz
ZSB5b3UgYXJlIGV4cGVjdGluZyB0byBzZWUgYmVmb3JlIHRoaXMgaXMgdGFrZW4NCj4gdG8gDQo+
IHlvdXIgdHJlZT8NCj4gDQoNCkl0J3MgYWxyZWFkeSBxdWV1ZWQgaW4gbXkgdGVzdGluZyBicmFu
Y2g6DQpodHRwczovL2dpdC5saW51eC1uZnMub3JnLz9wPXRyb25kbXkvbGludXgtbmZzLmdpdDth
PXNob3J0bG9nO2g9cmVmcy9oZWFkcy90ZXN0aW5nDQpJJ2xsIHByb2JhYmx5IHB1c2ggdGhhdCBp
bnRvIHRoZSBsaW51eC1uZXh0IGJyYW5jaCBvdmVyIHRoZSB3ZWVrZW5kLg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

