Return-Path: <linux-nfs+bounces-4084-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E2290F5A9
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387BE28312C
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 18:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46571524C4;
	Wed, 19 Jun 2024 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="eb/k1zyC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2130.outbound.protection.outlook.com [40.107.243.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC801AACA
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820188; cv=fail; b=rVOC5PmeT79jfJOMpMgNxu05aM7FLCno7cdN6VNEyyzsbvr+TovPrr3TCGI2JLHHoalZ/eQhT+eztUWVBRllKRpC8BSqDHYwgXepAAHdsVLRnoUFRKCyR2VsH7DmaCA81oqYYj84au6w2mAb04/ECawQS+pMA531941U3rcMZLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820188; c=relaxed/simple;
	bh=IcU9w2FCaZXgYHJHKPvjOhVG25MwX9prXgvteQcDRy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NufoX29MTf0a4ismeS+vzf7k3E8Om0hUpS3wTQKC/5QqRT5zSUGuUu0U9BdBsC/01sNFMt9fwdHOJiO4dInCRH1B93wN/PdVA9A2Fif47+UAsuBKYvI5cyGv8vMG8FCqb246c6J+/9d4pVhzxALtkKmBe+pkkvcvcr9Riixe8cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=eb/k1zyC; arc=fail smtp.client-ip=40.107.243.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgUha3Re3d8T3owJjQidFctcOcCyckG4Nr7HiXzMXMsUD7+3cmHhtjj9QBhV7hiOX+DhoCLs7pksT7663+bqz+aDUWejT4O8aayX2a3hB8CuEIj0RBIiS9ZRXgAFhE0u03fwLcUPBSGWYlp9mfxhhE3nNRA/1A59jr4AOBfUtYz+nLNstNL8MvT+W67hbHI1QbX1Lcm1X4q1iRKHt9FQvJ1iu78Ju9B3w6bKLIOUK8BzyTROFpzcP0610KdM5DIPhg61hVlJtbzUo1oGARyxVfMLud6A/vHY/5h/Tjixz7onVL8ts3REyrLs6K+gJqI1HKM4/Urrv2RnoXp7qH6KlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcU9w2FCaZXgYHJHKPvjOhVG25MwX9prXgvteQcDRy8=;
 b=oa4Kh3O2D+8GilTQf0ziAVrLDfyscZW3BaBLs3YFks32taRl0ZW/G6W1vf5BJyLcN4Oli8MaYbTbGIXvWEEhQ5FjxJCekHKIvE3Wk8ab5KWKhZtVoWB1T1tEoT7UBkysQXEbQCS40l9aHSLJVHNCojgOvPYYKXnGlEr18vpwRYsQRic46ILuVpn9lG+euMEdNIzKPidYeIiJ67VyrFMkPnXjF53WR+dn4YT9ZBdKO9YdM/sJEmkhri20cOOqTNsFc/Js5i0w4V6FwmOkku90iEXf0RaBcCR08Lji7riXXI3bsOf08GOpaGxELOc9QXjQ82IBEhLkvEcPh2aivJ3TIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcU9w2FCaZXgYHJHKPvjOhVG25MwX9prXgvteQcDRy8=;
 b=eb/k1zyCRHeJ1GViQLUPbCqSJ/z4UDTQwqRHnVRQiFSzMrFqqdvXAXVOxAhBZaIZebhMwGICRRxD/UQkym/cr139gIYqohL51HCg0GY3DV1Xsew2g+j0p6LEf4w/XXpGLyYRVkOQn9JvXUt4vMukviv+pe+GdsrfuNqqQnSlY24=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3870.namprd13.prod.outlook.com (2603:10b6:208:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 18:03:03 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 18:03:02 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>, "hch@infradead.org"
	<hch@infradead.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: add 'noextend' option for lock-less 'lost writes'
 prevention
Thread-Topic: [PATCH] nfs: add 'noextend' option for lock-less 'lost writes'
 prevention
Thread-Index: AQHawZTgISFLcUQ41kCD6EOpRxYIYrHOlGqAgACCv4CAAEuGgA==
Date: Wed, 19 Jun 2024 18:03:02 +0000
Message-ID: <7b0eda741ac6d575db7d69da6b14799686e02c51.camel@hammerspace.com>
References: <20240618153313.3167460-1-dan.aloni@vastdata.com>
	 <ZnJwTaTw5JEOnuLw@infradead.org>
	 <3cd6df545d9230758db38a4b7e5921dd57089153.camel@hammerspace.com>
In-Reply-To: <3cd6df545d9230758db38a4b7e5921dd57089153.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB3870:EE_
x-ms-office365-filtering-correlation-id: 27ccf2dd-304c-4729-8e44-08dc908a0ff8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?QURZaEtGNnpEaDdFbituQVVtRVJqaDdzQXlYRWpiMWVKMXNhWlAyS3lBRFJZ?=
 =?utf-8?B?NVg1UFRIVjlJTXI0V2tMalhoR1RMRXlyUTZLeEcyK0hFeDFyRXRDdGJIK3ZK?=
 =?utf-8?B?ZkFlcUgwMnJ4Y2NDVU05K3lDdUh4NVNaQm1udjl4MlppMGpXUGU1N3c5OHZP?=
 =?utf-8?B?b0kvRVFuZ1RHU3VkaXV6STFveWRwRmJ6clY0aU5zdjNqUFNWdURHZlNoUi9X?=
 =?utf-8?B?bHQ1ZXpVU003QUpkUXY0TnpOVDdNZFFGK2J4eTM4QkJCM3pObU9RQ3E0Ynll?=
 =?utf-8?B?V2Z5T04wdm0rbXdQTTQ1aVNOVEhiZWdzeVNXU1B3WjBRSGo0Sm5NdDBqQU1T?=
 =?utf-8?B?ZUxOOVZ0em5ROVI4WldiRkI4VStudVdqWEQ2bkFWSFpUVmxBbzZoOXU1eldW?=
 =?utf-8?B?b05QR3B3QkJ1MStjWU5qamMwY0wvZ3ErMVNhWllDUmZkay9UazVYdENmUXFK?=
 =?utf-8?B?Tko3eFMzOFV1SFpoOUlLV3V2RlhoY0lxTVZtMURYdHpGRVJ2OGprdVE3NlpE?=
 =?utf-8?B?TmpMTVY1NEZtaE56dGpzL003c1RQUFN0dC9XTEdsL3JIblhHTE5LYmpTR1Nu?=
 =?utf-8?B?aEJadWFQdVhqYWNYVEtLb1lMMlM2Z09PYnozZTYySVB1NHYzNnlQOEZpZWtY?=
 =?utf-8?B?Tmg4dFZEMFcybHYraGVxeDdlQlhPbXFJcjRJRWs2NWFZdWhRaU9STmtUb2dP?=
 =?utf-8?B?Vm9SNWo1cVIyV2g5d2dkMlJnSHREdlhaL3ZNcUR5UmJtbEpOTElMcytVMnRU?=
 =?utf-8?B?c3ZTdDByTUh6VkNNLzVOUVVuYWdVT2ZaWDJraW9ZMkxrN2x1dXNFZWM4Uzlw?=
 =?utf-8?B?ZGlEZHhFYUlLZ1ZIQURHK25kUWNHQ0E1VUZwV3JEemNqb0xaOXoyQ0kxdWFJ?=
 =?utf-8?B?b1hnT1dHUlEzLzZ3ejFXem41NzVXUnpOUmVyV1dHemlPWWg5UlBSNGViNFBI?=
 =?utf-8?B?cmh4d205N3hCOUJFV3VNajBGN2JjbVNSZ3RocjZsb1kwbXRvTjRObXVxcmNv?=
 =?utf-8?B?VjhzNVBWL3l0Z242RUhMOC9Rbk1DdTNmS3JrSjlxOTdTYVpOL3p0SE0vcEZo?=
 =?utf-8?B?K0hOS3lYb2Zhei96OFZiSk1velNESUVOWCtIT0hJc0QwUXRPM1NPa25oQ0E2?=
 =?utf-8?B?eFNtdVpUcWc2Mm1MMVkvZ21YZnFFSXZHRGlaaExMRXptd1daYnlUTUxsR3kv?=
 =?utf-8?B?eThleU1xaE9KcEI1VTdNVHorOHNnZUxQYTZ6VWswZkhuZVZ0SUlRR20zVzky?=
 =?utf-8?B?RjFIZERZcHdBenVPcytZbXQzTEVpQVBDSXQ2SWFtbDFsUGRHTlp1b2dORUJS?=
 =?utf-8?B?Sk1rL2F0ODR2OW8vMCt1dU5YRC9Ga3hNZDBJVHpXYWg5WitNK2F0QVprcjZ3?=
 =?utf-8?B?eDRPczFVVFY3cjBsL3BJRG5MeENxMmc3MSt2NXZhUWFrNm5palVFUE5RQ1Np?=
 =?utf-8?B?NzJrUWpxVTJqR2pVM0JNNEN4eitISE15QWE3eE9yZW5UY0R0NWN6Vk9nS1Vy?=
 =?utf-8?B?WG5Jbi9Ta0o3OE80cEd1WEZsN1krd2loZmhoanhCaUNaMXlBZk5yTzRqZHJ1?=
 =?utf-8?B?LzFkdTFKQ3dQTTMydHpTMVY2NmxGSGJNTkVtNGRKYkNEbVFERUpNLzFsZ0RN?=
 =?utf-8?B?TFZGWmZxRk1pcGxwLzcrajYvODZOdndDakQyYjQxeHNpdkowSWxheWNYU2Jw?=
 =?utf-8?B?Rm5NWFNrdy9abi9hR3k2bUd3SkFpdk0wZDhHUFBRbXdMMTF1dkZMaFd6TytU?=
 =?utf-8?B?M1J2a2NTQUFpNVdCRndobmFFZEd1a1lXdWZieGxxTTVjZmlRcmU4bTEwaWRX?=
 =?utf-8?Q?2yMXpH0vxhAc0gYnfxL9/NKrCaLKOI5MfzpvQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUZFc3pReWswNFRQbk5GbkRFM3dQY2JLK1FEdGU1YVc5empJVSs0Z2Q1dTVH?=
 =?utf-8?B?aWNaWUYvQU9aZEk5SjBjY2FFUE55Tk5KeU15eUxYUElFcGpWdDFiTWlsNkFZ?=
 =?utf-8?B?YkhLcEo5V3VNL3gwM0Y4Z1FCUzNhTHNRK1lLM2VHdVRBT2xGaU5jOEtuQVpZ?=
 =?utf-8?B?M3gvUEt4YjRPVm9FWWVvYTJvWGpqMjJuR3dKVSszZTZaN20wUjR6QlFOY0hH?=
 =?utf-8?B?TFp0YTFuajBsbmNMQ2h5TDlDajZxMWJaVWN3bTEvMnB3SkE5czlib0JXWEMr?=
 =?utf-8?B?bFZpek9OZjd3Y0JoZElDS1dCR0NwZHRoZU9icFdsc1NRSjEvQXpGeW5OK25h?=
 =?utf-8?B?cFVRUGZrbUpiNmdwbll2dUV2V1Rkc1JkbHJtRys2cStna2p3NzlnQnE2cDFS?=
 =?utf-8?B?MVE4WUV1a1cvcUlZNW41T3hqMC92cGNTcXlKcThLZlZmdEZaa2hhMytqLzlw?=
 =?utf-8?B?cERoL0M2SUFtajgxWEV3U2kwbCs3cHpBRjRNZnRwSElOR05PNWRMbGpsUzJU?=
 =?utf-8?B?Z3FJaUlvWFNTVU5qVHdIWE1nODY3OVJJR0xMUHJ2aWV1bEpZSEswLzJKaDdH?=
 =?utf-8?B?S21wc0NZdDZEWWc2Z2I0bzRZNGorRForSXFqWkhnbWxLZXNtOXdTNDFOdlc2?=
 =?utf-8?B?TkM4WTY3Y1R3bnJnQUZPNS9jb1YzdTRSNGFmRGYxN3ZjTzdwcFQwZ1JVUDRr?=
 =?utf-8?B?eXJ6ODdkZGc4MG5hV3FJZEd1KzdhdDZjTjVBUUcwN0hVM1dhZzJkSjI5NFVl?=
 =?utf-8?B?NXRDMHdwcWc2dGtzRG5TTm9yRzlZNDdraDZXQWxSeFpJTHEwOU0yT3NWQ3dD?=
 =?utf-8?B?eXg5MW9rSEhoQlQ1dXpsTHZJeFV0NTJmcjk0TGxPTVpJUDk3YlBITms1d2Qz?=
 =?utf-8?B?LzBlVXRsYzZKa3BEY21BcTE0MjJEYWxjNGZwMm1SVVNsY25wUHdvVVNKbGlF?=
 =?utf-8?B?cXlsWFVYSkVkdXluTnFZOWJmaGFGY1d6R3orVk1BN1NRN2FMRFoxSnY1eUxv?=
 =?utf-8?B?TGh3Qmkyd3BFWXR4M1lyUThhTlRzWkU2N0Z1U2x3MVZxT05paWxXdHlXTXIz?=
 =?utf-8?B?TFJ6UG9uRHVkbEp1L2pMMVpWODc0b0c1RGtualpEQ1BrdzF5R0tuYkF3eGVQ?=
 =?utf-8?B?Q3ZLOUQxTHlndXdwdHRZdUlzQ2YwYWtoZnRGSlBwVWZhK1k1L2IwUEMrMkk0?=
 =?utf-8?B?cTJOQWpwQi92RVg0VFlnaGYvZE9WdkdDT0loQXV0bHdxRGNsZk0reFNoRTR1?=
 =?utf-8?B?UkFaUmpvRHNIbUVJWU1SYWExWlNLZkJ2NW9YcitrR0xVcTNWMHJ1V3FjemQv?=
 =?utf-8?B?M0g5Kzl2M0dvNXVROFdIMDhaQ2xuSW1tSGM4S2QzM2RJUkVVTkNwR2YydHpJ?=
 =?utf-8?B?dTdLRTRSSEhHWTJZY2pGQW9oQkN4QnlLeGRSSTdSRVFrZVZwblR2aDNPSHBV?=
 =?utf-8?B?UWpmSW1GckMyY2R3YjV5L0ZoWk81RXU0K05JTmNwZG8wWUFJUytEZHYwZzl5?=
 =?utf-8?B?M3E2eU1hL1gwUHRhT3dWcFYrN1hIRXhFODFZMG1HOFNGMnB6U25nZkY5RThx?=
 =?utf-8?B?Q1BVMFdmNUVwZkZacTllTDFUMGpHL0RvYWdPQk53WkdOQ2dnbkNLMDk1V1JT?=
 =?utf-8?B?aDZwVmprdGMzVUFzRGxxRUtRMEc4b01vNGVpMDh4Z0xndkpVMDgvbzF6VlVm?=
 =?utf-8?B?M095eEVHbVphZzBLUTgvUW15Qk1NNGQ4RjUvT21vVnA3Wmx5ZzBIVlBRWXNI?=
 =?utf-8?B?UFkxM0lUdThNRXVKUUpUZHQzUFlBcnJaazlVWm1mT2ttWjh5cEh2OERNM1pk?=
 =?utf-8?B?N2ltc0F5V21ZSnVqKzZUWnRtUHpkWW5pVXlGSUUrMDJ5djVUeXlyMTgwMklO?=
 =?utf-8?B?RENVL0djRE14WGN4U2dQZ1Q3LzRRbGg1N3pYcVcrVi9qWUF5ZTZBUFVMZlVI?=
 =?utf-8?B?ejVmMEFKNE5JUzhWSDgweVgvYTlKS2JIOGJNdldycDVnNjJBR1VWNHRUTGtl?=
 =?utf-8?B?WVBLMTVJc3ZDN3NOUmNFR3FKZUY5bit1bXJWaFJhTkt2SlFKRnl3V3hucFQ3?=
 =?utf-8?B?TVBNbnh0SUJSOTNJL2V5MWlBTVdrOW44TVhGYkdSNHkwZzBwc1I5UERBZEFq?=
 =?utf-8?B?QkdlQ2NWbTdTRlJSKzRvZEd4YWRCNE5LeWEzTGdrd2UvZ1FHYWpOa25aYTVX?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32CAC3359C412842A8B6F0BCB0F273CB@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ccf2dd-304c-4729-8e44-08dc908a0ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 18:03:02.7306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfBydrGG0VEJVt2nQe1vIAQ1Nrgpz9dyC/iP5OgQ+8aAYLSt73cidnMfxQuUHO0QXaKBIWoYK5BqD6fMGCiD5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3870

T24gV2VkLCAyMDI0LTA2LTE5IGF0IDA5OjMyIC0wNDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyNC0wNi0xOCBhdCAyMjo0NCAtMDcwMCwgQ2hyaXN0b3BoIEhlbGx3aWcg
d3JvdGU6DQo+ID4gT24gVHVlLCBKdW4gMTgsIDIwMjQgYXQgMDY6MzM6MTNQTSArMDMwMCwgRGFu
IEFsb25pIHdyb3RlOg0KPiA+ID4gLS0tIGEvZnMvbmZzL3dyaXRlLmMNCj4gPiA+ICsrKyBiL2Zz
L25mcy93cml0ZS5jDQo+ID4gPiBAQCAtMTMxNSw3ICsxMzE1LDEwIEBAIHN0YXRpYyBpbnQgbmZz
X2Nhbl9leHRlbmRfd3JpdGUoc3RydWN0DQo+ID4gPiBmaWxlDQo+ID4gPiAqZmlsZSwgc3RydWN0
IGZvbGlvICpmb2xpbywNCj4gPiA+IMKgCXN0cnVjdCBmaWxlX2xvY2tfY29udGV4dCAqZmxjdHgg
PQ0KPiA+ID4gbG9ja3NfaW5vZGVfY29udGV4dChpbm9kZSk7DQo+ID4gPiDCoAlzdHJ1Y3QgZmls
ZV9sb2NrICpmbDsNCj4gPiA+IMKgCWludCByZXQ7DQo+ID4gPiArCXVuc2lnbmVkIGludCBtbnRm
bGFncyA9IE5GU19TRVJWRVIoaW5vZGUpLT5mbGFnczsNCj4gPiA+IMKgDQo+ID4gPiArCWlmICht
bnRmbGFncyAmIE5GU19NT1VOVF9OT19FWFRFTkQpDQo+ID4gPiArCQlyZXR1cm4gMDsNCj4gPiA+
IMKgCWlmIChmaWxlLT5mX2ZsYWdzICYgT19EU1lOQykNCj4gPiA+IMKgCQlyZXR1cm4gMDsNCj4g
PiA+IMKgCWlmICghbmZzX2ZvbGlvX3dyaXRlX3VwdG9kYXRlKGZvbGlvLCBwYWdlbGVuKSkNCj4g
PiANCj4gPiBJIGZpbmQgdGhlIGxvZ2ljIGluIG5mc191cGRhdGVfZm9saW8gdG8gZXh0ZW5kIHRo
ZSB3cml0ZSB0byB0aGUNCj4gPiBlbnRpcmUNCj4gPiBmb2xpbyByYXRoZXIgd2VpcmQsIGFuZCBl
c3BlY2lhbGx5IGJhZCB3aXRoIHRoZSBsYXJnZXIgZm9saW8NCj4gPiBzdXBwb3J0DQo+ID4gSQ0K
PiA+IGp1c3QgYWRkZWQuDQo+ID4gDQo+ID4gSXQgbWFrZXMgdGhlIGNsaWVudCB3cml0ZSBtb3Jl
IChhbmQgd2l0aCBsYXJnZSBwYWdlIHNpemVzIG9yIGxhcmdlDQo+ID4gZm9saW9zKSBwb3RlbnRp
YWxseSBhIGxvdCBtb3JlIHRoYW4gd2hhdCB0aGUgYXBwbGljYXRpb24gYXNrZWQgZm9yLg0KPiA+
IA0KPiA+IFRoZSBjb21tZW50IGFib3ZlIG5mc19jYW5fZXh0ZW5kX3dyaXRlIHN1Z2dlc3QgaXQg
aXMgZG9uZSB0byBhdm9pZA0KPiA+ICJmcmFnbWVudGF0aW9uIi7CoCBNeSBpbW1lZGlhdGUgcmVh
Y3Rpb24gYXNzdW1lZCB0aGF0IHdvdWxkIGJlIGFib3V0DQo+ID4gZmlsZQ0KPiA+IHN5c3RlbSBm
cmFnbWVudGF0aW9uLCB3aGljaCBzZWVtcyBvZGQgZ2l2ZW4gdGhhdCBJJ2QgZXhwZWN0IHNlcnZl
cnMNCj4gPiB0bw0KPiA+IGVpdGhlciBsb2cgZGF0YSwgaW4gd2hpY2ggY2FzZSB0aGlzIGp1c3Qg
aW5jcmVhc2VzIHdyaXRlDQo+ID4gYW1wbGlmaWNhdGlvbg0KPiA+IGZvciBubyBnb29kIHJlYXNv
biwgb3IgdXNlIHNvbWV0aGluZyBsaWtlIHRoZSBMaW51eCBwYWdlIGNhY2hlIGluDQo+ID4gd2hp
Y2gNCj4gPiBjYXNlIGl0IHdvdWxkIGJlIGVudGlyZWx5IHBvaW50bGVzcy4NCj4gDQo+IElmIHlv
dSBoYXZlIGEgd29ya2xvYWQgdGhhdCBkb2VzIHNvbWV0aGluZyBsaWtlIGEgMTAgYnl0ZSB3cml0
ZSwgdGhlbg0KPiBsZWF2ZXMgYcKgIGhvbGUgb2YgMjAgYnl0ZXMsIHRoZW4gYW5vdGhlciAxMCBi
eXRlIHdyaXRlLCAuLi4gdGhlbiB0aGF0DQo+IHdvcmtsb2FkIHdpbGwgcHJvZHVjZSBhIHRyYWlu
IG9mIDEwIGJ5dGUgd3JpdGUgUlBDIGNhbGxzLiBUaGF0IGVuZHMNCj4gdXANCj4gYmVpbmcgaW5j
cmVkaWJseSBzbG93IGZvciBvYnZpb3VzIHJlYXNvbnM6IHlvdSBhcmUgZm9yY2luZyB0aGUgc2Vy
dmVyDQo+IHRvIHByb2Nlc3MgYSBsb2FkIG9mIDEwIGJ5dGUgbG9uZyBSUEMgY2FsbHMsIGFsbCBv
ZiB3aGljaCBhcmUNCj4gY29udGVuZGluZyBmb3IgdGhlIGlub2RlIGxvY2sgZm9yIHRoZSBzYW1l
IGZpbGUuDQo+IA0KPiBJZiB0aGUgY2xpZW50IGtub3dzIHRoYXQgdGhlIGhvbGVzIGFyZSBqdXN0
IHRoYXQsIG9yIGl0IGtub3dzIHRoZQ0KPiBkYXRhDQo+IHRoYXQgd2FzIHByZXZpb3VzbHkgd3Jp
dHRlbiBpbiB0aGF0IGFyZWEgKGJlY2F1c2UgdGhlIGZvbGlvIGlzIHVwIHRvDQo+IGRhdGUpIHRo
ZW4gaXQgY2FuIGNvbnNvbGlkYXRlIGFsbCB0aG9zZSAxMCBieXRlcyB3cml0ZXMgaW50byAxTUIN
Cj4gd3JpdGUuDQo+IFNvIHdlIGVuZCB1cCBjb21wcmVzc2luZyB+MzUwMDAgUlBDIGNhbGxzIGlu
dG8gb25lLiBXaHkgaXMgdGhhdCBub3QgYQ0KPiBnb29kIHRoaW5nPw0KPiANCg0KQlRXOiB0aGlz
IGlzIG5vdCBqdXN0IGEgdGhlb3JldGljYWwgdGhpbmcuIExvb2sgYXQgdGhlIHdheSB0aGF0IGds
aWJjDQpoYW5kbGVzIGEgc2l6ZS1leHRlbmRpbmcgZmFsbG9jYXRlKCkgb24gZmlsZXN5c3RlbXMg
dGhhdCBkb24ndCBoYXZlDQpuYXRpdmUgc3VwcG9ydCwgYnkgd3JpdGluZyBhIGJ5dGUgb2YgaW5m
b3JtYXRpb24gb24gZXZlcnkgNGsgYm91bmRhcnkuDQpUaGF0J3Mgbm90IHF1aXRlIGFzIGRyYW1h
dGljIGFzIG15IDEwIGJ5dGUgZXhhbXBsZSBhYm92ZSwgYnV0IGl0IHN0aWxsDQpkb2VzIHJlZHVj
ZSB0aGUgbnVtYmVyIG9mIHJlcXVpcmVkIHdyaXRlIFJQQyBjYWxscyBieSBhIGZhY3RvciBvZiAy
NTYuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIs
IEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

