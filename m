Return-Path: <linux-nfs+bounces-10644-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0BAA660A4
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 22:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D79F1781EC
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 21:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79901FECD7;
	Mon, 17 Mar 2025 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PNyTNwsj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783F18EFD1;
	Mon, 17 Mar 2025 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247336; cv=fail; b=XZwpRBrSU4xoS5B5P9lDLCjNadidxL8jpFfpa9w8NqyNDkgQLD/s3aTnd6cZWsQAOwnqzJM1E8Q81fsSlxgUinYAyV8s8RWqOjM+F4ImxdKPDFDDptFEa6kqNRBsTpPVOAVAd1zUpq0cH4+tPupfUfWny4TXmvZBBl8DRbDXz3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247336; c=relaxed/simple;
	bh=uulGrL9N4eGN9AAGc9xUVshDFJkBlaDeS8P9ZcrO5Nk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V2TGaTo91QtPRIVXlfoLmD5vUCm73ceN7w4aKUDiO1ndAjRWd8lwWoDpHdExF9VhoK6QHRq5GyYEtjTuLMeQcULppf9zWnD6lqXOE/zua2z0tX1PmsrJizuu+XRAy44j4xu+WRmLHTvUgseab97F9MDxhBoutVJFwkjY7t1WfXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PNyTNwsj; arc=fail smtp.client-ip=40.107.220.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMMSR0N7Alql4FuPOLrqCqhOfxUiPaeR6kKMrFPaA2o+A2ewqBThNoZ8xwiuiJlOmTYtOzyyHYs7xPH4ThopLYNALuNvlmSZzW35DUeoavHgJRU6N98ekUG74+ybUrj7Kj6JMdp4JABZCgSqV0m9QZI/5NSWmat3VeVsC2GD/GpbqulUZ8TNJcchEKOo6fjFMMmp8sb2V1JCvJ9eAM2qF7p27QggBCDhAy4kDq23qCQ950V3An7O7/An4244Vh/FnlofACuaHquqKLPC7tP+86xRT/woqETlh0ikr0POqutnVIzTw0O5XImAp3f6V0Qtja8HfRWx9/uD1ckpCloCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uulGrL9N4eGN9AAGc9xUVshDFJkBlaDeS8P9ZcrO5Nk=;
 b=Y3S7ecmE2Wn6KI8A+xbwXFBVZwH2BF6OrrinqKZW4lnzoBkjcaStswCFvVe3JfHih28QyIqwzPoDyFQlHirLQN1m/VYB0G6nCqLCskVYadiphbNm9Orf2pAe6dTnm4TE5ytfHmM4PBaAFtjzRYosHvVGu2zDIDmWVlyVfp0QICYTDn4b7Hv1/g7Fpt/n8HTV8tK4KasnrfE4uEeyaRckAmmPg5UfiQYVFPWSkQv9twaM5TMR1KERbwyucLXdpvslldgf59X+FOpFgh+jeSipUFM7H2jXGvT4MAY8ym0QbrhTcspfO7bSCo7yIjXZCMEh0YsSupRcizU7CdIVFk84MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uulGrL9N4eGN9AAGc9xUVshDFJkBlaDeS8P9ZcrO5Nk=;
 b=PNyTNwsjxQxLsfSs8FcPrNxb6mo1noL3m0mNzWZIsu9sfPHiOXrInqSYsNLkQpaAchtx1l8mi7hy0OT3qJsIKemDR/LFH6c4/Akf9Vyc6VuS/PcXFrwL9EXoAYQXTmZ2zY05kxD2CzRNVFjdlnF5FOD4OECdW+IkUPaFx6jm72w=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by IA2PR13MB6701.namprd13.prod.outlook.com (2603:10b6:208:4ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 21:35:32 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 21:35:32 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "horms@kernel.org" <horms@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"okorniev@redhat.com" <okorniev@redhat.com>, "anna@kernel.org"
	<anna@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, "tom@talpey.com"
	<tom@talpey.com>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "neilb@suse.de"
	<neilb@suse.de>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "bcodding@redhat.com" <bcodding@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] nfs/sunrpc: stop holding netns references in
 client-side NFS and RPC objects
Thread-Topic: [PATCH RFC 0/9] nfs/sunrpc: stop holding netns references in
 client-side NFS and RPC objects
Thread-Index: AQHbl3+/il4MJnYfoEWHpLj23/vAkLN32gMA
Date: Mon, 17 Mar 2025 21:35:32 +0000
Message-ID: <b4a720542c9afcdf3d7cf8641893b448423e0a9b.camel@hammerspace.com>
References: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
In-Reply-To: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|IA2PR13MB6701:EE_
x-ms-office365-filtering-correlation-id: c2813ba1-33aa-4059-77a4-08dd659ba518
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFEyWWZNQW1mTGdaRk9hNTBOUEVhdjFKY2Z5bERpb0w1bVlUL2l6eEl2Ykly?=
 =?utf-8?B?QU1TVHo3anh3Y3cyNnNHUHErRWRkeDlreWpoOGdxUHJIRGZyWUZ2QzJsNXBs?=
 =?utf-8?B?M0RvV0JWdUhQVjVzN1lmZkYzN1JHQk1sckVXSUVoY0t2WUVjWTFlaXZDM3JE?=
 =?utf-8?B?UGhnd2lvNlE1cThFL1BuRnhtVlJwZzRvWWU0MlRDYUpnWTBocXFzNzJnOHhB?=
 =?utf-8?B?bGJsTkREZWRqZnNibmdhZncyeUp2QytHNnpuRldZY091SlE0cWMyMXMxbGU0?=
 =?utf-8?B?dHMvaTgybHdZeVM0TkkvUXV1TGpLWWhyaHhaTzZxNDlQa1NNd1I3MkYxbUVa?=
 =?utf-8?B?aFhhek1odlY5dXYwQUwwT2h3ZDY5VUZURGNvOTErS0tCNVl3WVBJajFMTXVD?=
 =?utf-8?B?MlNUdUxnWkZBV05qVTRhTmdKNHRCRVdaZ1lVazlRdUJhNlUyYnJFQ2JONVkx?=
 =?utf-8?B?YWhXVDl4SjJlL1lHL3MyNDczbytRT01UTFNBdjR0VU1UdGVIV2lFZjRhdytr?=
 =?utf-8?B?am9PdHNNcnFvanRPa3BUQTB5NktaN1J4MXlnaXZBY0svR2F0dEk1UWYzK2F2?=
 =?utf-8?B?dDVvZmlNaTZCZit0WGpnb3B2dmxPTVVOMlhXdkVzZDJVbWJnMDRLbEJlQnNN?=
 =?utf-8?B?Ri8yWDhDSENrRXFub3Vwckdhek03Sk9weDlqSm1IV2V5T0FDRTBnR1g0UkZx?=
 =?utf-8?B?Y1c2UUxxL0xuNUpZRHVHYTlEenFpZ1BmVy9OK00vVWtQUWpTUSs4MzFSL0Rq?=
 =?utf-8?B?VXp6MzdkdHgzMzM4RDlqV3g1eVFWRzkveEx0Zm9XYTc4OGxxVHpWbm9IMXZx?=
 =?utf-8?B?d0pMRjhMeU9jaTcxWUYyc1I1SUxnZTA3TWswZkdJL09oeHk5K1dyNUJCTk4y?=
 =?utf-8?B?dkRXdHdiWHN1UExYVnpSM1NzVEdxYUZQQ0RUVENkVTFKMG5NeEZZaDZZTjk4?=
 =?utf-8?B?ZGZHYUR1cDBUdk5jeVN3SE9XU3pLTWNEaUJGN2tqRmw3K2VYQUZjZVhUQnV3?=
 =?utf-8?B?MDZZOGxOaFcxWW0yWXJ5b0dHaEp6ckZSY1NMVmc4UEY0K0xzT002S3VxbDdM?=
 =?utf-8?B?RDQwZFhzSFhsVWphYk1xWnF1MWxsRHN3Vm01bXhGSm9DZUhMUHY1amtMT25n?=
 =?utf-8?B?YWZ0cmRLK3JZbktDNTNDRUZnRzk1OW5FaDlmMEhvZS9IRjZsTGNWZ1FKUHdh?=
 =?utf-8?B?WkRJTWZXOTBZOVMvTXByY0ZuN29sKzlEOEIwcDZ1T3FKaDUxT0x1emJJY24y?=
 =?utf-8?B?SnFjenFvdHNoMkdscDVWUCs1cUdqRkxMUjBuVFIwb0thNTFOcHdqRDNKdUNz?=
 =?utf-8?B?ZnJCcE12WUpCK0FQbjJoRURiL3RnL3lQTjNpQUV6bTkyTGNaMEl2U1VGbUZX?=
 =?utf-8?B?MU83ZlFCNmNjMHFLSzIxSHlyOTJtWVZ5anBrZ2RlaEhydnQwZXBPbUEwVW9B?=
 =?utf-8?B?VzRxWmVjanpMbFNEdFZqeTNkdThuTk4rM1ZHbUZXLzBsU2VUS3lNVERReVJp?=
 =?utf-8?B?T2dpenU4OS9JWGFTWE9zb0s3QnJ1ZGx5blhBYXRIWE1ZMktqeWg5VFpIQ0dK?=
 =?utf-8?B?ZE9VZENRaVlTMXY4UERIS2lqUGhxSGh6RHRZa0syeXFHZUszTkQ2NU45MEU5?=
 =?utf-8?B?anF4M2dLNFRBQkNQTEp5alhvTERPbjIycXJvSUR0YXFBZTYwTVBzQk1TT25J?=
 =?utf-8?B?c0NVMXZIWDdwMXQ4a0ZueGY2dE40WWJ6ekdySm9Wcy9sZUJlNUpjS2d0YkRr?=
 =?utf-8?B?TWJ0WWkyeklWK3k4MHRtQVAyQ25xT2Z2Qk01NmV0NFlKcDdEMEQ3UDgyOURh?=
 =?utf-8?B?NUpLWmczZ1dQRlVvbWxSYmZCQ1lDT1lwNE1nLzdoYnZyVlhEV3ZRbUJuRDk4?=
 =?utf-8?B?bnZQV0h2WHZLdlp0dHo0Ym1od1ZRV0JqMENIZE02MkNCZHptb24vMytOL1FD?=
 =?utf-8?B?a2Vzc0FNYVJvVEpGeXlUZTlqWEY4VnFOaDcvMFZOemZEVmZkZWRlQUR4Q3ZX?=
 =?utf-8?B?bk9mVU1TcStBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUcxNlJoV0V4VzZZZ1NEK1Z0YUpjSHBlMEwwL3cwdlVWLy9KTHM4SHdrNlJq?=
 =?utf-8?B?NEhnR29KK1R3Mk5NU080UFBrVEpYZjB3NHhyVTF0Q1lnUi9od1Z0dUIzRlp6?=
 =?utf-8?B?djJPd3Bod2lXQnVkaU8vQ00vdCtTSFlXaW41cGpqM3RaUWl2ZmFiQXo3RFgy?=
 =?utf-8?B?QS9aRDdCNHE2eTR1QzB1dHlGR3pETFA1TnNjNEU0NldpYVBDOENHK0ZvVkcr?=
 =?utf-8?B?dFFEcE5SRk1Td3o5cTZUM09zYnIrakxqRlN3aXVURFJncWZaNjVjVjloNXN5?=
 =?utf-8?B?ZGhqdzMvck5aNGRvajJIdUEwWnhwbmZRM0JLdmF0ZGljOHFjYnRRL0VPSXZK?=
 =?utf-8?B?ZmhOZ3FTR1NNZU13S3FlMWxMTzNpSE9qb2R4TzhhQXFKM1dZRVFPaWJoUStw?=
 =?utf-8?B?c1g3M0dLNkw1eEZOeHpJMWh3YjBWd3Z6OGg2SE9tZnRQeU1Uc0M2YXFzL0wr?=
 =?utf-8?B?ZHBzWE9kS082VWpNamFlemVibFpVbGc5MERhbjdaeEE2L2FqN29SbU9VU0xO?=
 =?utf-8?B?aVpzaU9iaTUzL3dyTnBHc1k5Rzd2NmE2ZXRHUlo2RTkzQUo0bGpHZmJtb0t6?=
 =?utf-8?B?OW0rYzhLUTA0My82QnJOcEY5SDE3MXBzNmVFclJyTU1TWTR4NXFMSnY3VVF3?=
 =?utf-8?B?TlRJUzUxTlVSWTlRKzdObTJCYXgxRG5pOXEzb1NBV0c4eG8zVFkyQUJuMmZm?=
 =?utf-8?B?SUJPWjJuazVzdkZuclhFNklHa2Zpak1WaXVURlhIUldwWm5ITm1GV3RJVFFF?=
 =?utf-8?B?TldQRXYxQ2M2UlBxS3JvMnhPZlU1Y2dpNUk4Q1Z2eWk4WXV6d2tpT0xER0Fh?=
 =?utf-8?B?bmxRVXp0ODFlZzVDVjVTSTBBZzNocWk1OUsxMURpdFU0a1JwRnRhQkpuV3pG?=
 =?utf-8?B?VHE4UlM2bzBZR0c3NHVEa0lXNFdpUHJoY2twd0g3VlpqSXp4cjVxT29PSnpm?=
 =?utf-8?B?OEdWOW5CYUN4anU2Q0d1VUZGN0xwQXlwb3FvR1NTMWc1V1l4ZmhITGZNYXlJ?=
 =?utf-8?B?c2hjSW9Lektha04yNi82czJNN1lPaWYvd0RxM1VHNGFBc3kveHVocEFBalkx?=
 =?utf-8?B?eVVJNGpZd25rY3BQTGRZMXY1cUUxbWt2Rk1OMXJxZFZsVUNoK2I4RW5yY1Q3?=
 =?utf-8?B?TUNnT2tjYzNzLzliOGFVVG5jd1ZzQlFXS0FwNHdoZ3N4L2VGZDV0SlJnRzhi?=
 =?utf-8?B?SDRYTXFFNXF5aW1Zb0lNd2ZyY0R6Y2w2aGdjY0M5dVNHWW95TUxvRWRNT2dr?=
 =?utf-8?B?SERTckVWT3EzcmpRMmpzRXJkVVN6WlNlcEY1OVRSS21adU1VdDFhdEJHQnV4?=
 =?utf-8?B?T1ZlM3o4bjd5Z0JZSVovNnVZaGJhQ2xFY0dMRllnVW55c1puVkR6VFk4RFR1?=
 =?utf-8?B?MWR0VUVJZWxOb2ZPdGswdStiVmttbHY2bTJCdkI3Wmk1TEpXNmxxRi9SSllG?=
 =?utf-8?B?SmdiazhCOThtdVMxa0pUVU5NKzh1V21MQ3dxeXZDdDhRalAybkxqNTJHMnVR?=
 =?utf-8?B?MTVCUGQ1UkVNUmgrV1RlMGxqRU9KSFRYQ0xyMzZXSnQ2U0E5ZFpScFcvcUNy?=
 =?utf-8?B?TlBsd1N1OXBtUXNheWZESklzUGhsZ2ZCazNIaVh2ZkI4WjBkNWI0dW9UbWRG?=
 =?utf-8?B?L0QxTmhzcmJIRlg2a1JjWjQrLzhkN1AxQWhiaVNvMDhXYzRmR1FzbDB4MHR5?=
 =?utf-8?B?RzlDQTR1Ky9INVF1SW9YaEFReFJRT2ZxMHBET0FqS2dGcTVickloRW1xdUNQ?=
 =?utf-8?B?NU04c3ZsUkYyZm4xeG5zOCt4dmd1cFNEeFZaMHJ2ZUFMSFRSeUJ0VkpsS0F4?=
 =?utf-8?B?ZDdOa0VEUVdPM2VXcmN4WTM2eXVQSTNBc2U1VlpYVnU5d3RUVlVzUVpyQk1B?=
 =?utf-8?B?NitxS1YxREhtM0RuNTlFK0pNWEpTQ0Rvc0xlM0VZZEtRaVRZQVZvK1VGTjdw?=
 =?utf-8?B?SnVPd1I3dHhzemdsa2s4eXNjMnBMMFRqRmg4Qk40Nkt0QmxKdERqRFNwSk9V?=
 =?utf-8?B?Wjd2d3ljaDg1Nm0vRUFLanczSjZWSlFrZ0szSWI5Z1JzbU0rdFRmTkpEL3Ji?=
 =?utf-8?B?SUxCb2g0OU41YXlrelRsYnZSckc0TVlBRmdtc1lGSURCcEhiRTJ4Z1l4VGdo?=
 =?utf-8?B?Tmk5YldLT29zZUJnMlpkTG1LeXRrYWh2eUg1VWJBVE91UzU3R0VSY2xjcHZ0?=
 =?utf-8?B?cEM5NlNYTU5SUElyK1VSUW1oLzhFTjkzRDZZbXNtTFpUY056cXczT28xeWVx?=
 =?utf-8?B?R01xaFg0OXVQKzUyT2U3bzVYY0tnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1B3158A9A26624BA9ADF0874704EBB3@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2813ba1-33aa-4059-77a4-08dd659ba518
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 21:35:32.0232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jX0mtaX61nv/CDuViX88kWJV8AKrAq0BM00RyiEYrPGkEzJpuWTkw6yYfep4Xh7n5BImTtKYcrYaNyuf1bRYPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR13MB6701

T24gTW9uLCAyMDI1LTAzLTE3IGF0IDE2OjU5IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
V2UgaGF2ZSBhIGxvbmctc3RhbmRpbmcgcHJvYmxlbSB3aXRoIGNvbnRhaW5lcnMgdGhhdCBoYXZl
IE5GUyBtb3VudHMNCj4gaW4NCj4gdGhlbS4gQmVzdCBwcmFjdGljZSBpcyB0byB1bm1vdW50IGdy
YWNlZnVsbHksIG9mIGNvdXJzZSwgYnV0DQo+IHNvbWV0aW1lcw0KPiBjb250YWluZXJzIGp1c3Qg
c3BvbnRhbmVvdXNseSBkaWUgKGUuZy4gU0lHU0VHViBpbiB0aGUgaW5pdCB0YXNrIGluDQo+IHRo
ZQ0KPiBjb250YWluZXIpLiBXaGVuIHRoYXQgaGFwcGVucyB0aGUgb3JjaGVzdHJhdG9yIHdpbGwg
c2VlIHRoYXQgYWxsIG9mDQo+IHRoZQ0KPiB0YXNrcyBhcmUgZGVhZCwgYW5kIHdpbGwgZGV0YWNo
IHRoZSBtb3VudCBuYW1lc3BhY2UgYW5kIGtpbGwgb2ZmIHRoZQ0KPiBuZXR3b3JrIGNvbm5lY3Rp
b24uDQo+IA0KPiBJZiB0aGVyZSBhcmUgUlBDcyBpbiBmbGlnaHQgYXQgdGhlIHRpbWUsIHRoZSBy
cGNfY2xudCB3aWxsIHRyeSB0bw0KPiByZXRyYW5zbWl0IHRoZW0gaW5kZWZpbml0ZWx5LCBidXQg
dGhlcmUgaXMgbm8gaG9wZSBvZiB0aGVtIGV2ZXINCj4gY29udGFjdGluZyB0aGUgc2VydmVyIHNp
bmNlIG5vdGhpbmcgaW4gdXNlcmxhbmQgY2FuIHJlYWNoIHRoZSBuZXRucw0KPiBhdCB0aGF0IHBv
aW50IHRvIGZpeCBhbnl0aGluZy4NCj4gDQo+IFRoaXMgcGF0Y2hzZXQgdGFrZXMgdGhlIGFwcHJv
YWNoIG9mIGNoYW5naW5nIHZhcmlvdXMgbmZzIGNsaWVudCBhbmQNCj4gc3VucnBjIG9iamVjdHMg
dG8gbm90IGhvbGQgYSBuZXRucyByZWZlcmVuY2UuIEluc3RlYWQsIHdoZW4gYSBuZnNfbmV0DQo+
IG9yDQo+IHN1bnJwY19uZXQgaXMgZXhpdGluZywgYWxsIG5mc19zZXJ2ZXIsIG5mc19jbGllbnQg
YW5kIHJwY19jbG50DQo+IG9iamVjdHMNCj4gYXNzb2NpYXRlZCB3aXRoIGl0IGFyZSBzaHV0IGRv
d24sIGFuZCB0aGUgcHJlX2V4aXQgZnVuY3Rpb25zIGJsb2NrDQo+IHVudGlsIHRoZXkgYXJlIGdv
bmUuDQo+IA0KPiBXaXRoIHRoaXMgYXBwcm9hY2gsIHdoZW4gdGhlIGxhc3QgdXNlcmxhbmQgdGFz
ayBpbiB0aGUgY29udGFpbmVyDQo+IGV4aXRzLA0KPiB0aGUgTkZTIGFuZCBSUEMgY2xpZW50cyBn
ZXQgY2xlYW5lZCB1cCBhdXRvbWF0aWNhbGx5LiBBcyBhIGJvbnVzLA0KPiB0aGlzDQo+IGZpeGVz
IGFub3RoZXIgYnVnIHdpdGggdGhlIGdzc3Byb3h5IFJQQyBjbGllbnQgdGhhdCBjYXVzZXMgbmV0
DQo+IG5hbWVzcGFjZQ0KPiBsZWFrcyBpbiBhbnkgY29udGFpbmVyIHdoZXJlIGl0IHJ1bnMgKGRl
dGFpbHMgaW4gdGhlIHBhdGNoDQo+IGRlc2NyaXB0aW9ucykuDQo+IA0KDQpTbyB3aXRoIHRoaXMg
YXBwcm9hY2gsIHdoYXQgaGFwcGVucyBpZiB0aGUgTkZTIG1vdW50IHdhcyBjcmVhdGVkIGluIGEN
CmNvbnRhaW5lciwgYnV0IGdvdCBiaW5kIG1vdW50ZWQgc29tZXdoZXJlIGVsc2U/DQoNCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

