Return-Path: <linux-nfs+bounces-4001-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A79D90DC1A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 21:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E14CB229DF
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 19:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB4F15ECED;
	Tue, 18 Jun 2024 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="FMSQWLPx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2090.outbound.protection.outlook.com [40.107.95.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589C14BF92
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718737192; cv=fail; b=drS65BXs0pwXAyCDr3mAaIPoYUalY7+4Q3ZAnzJs678xVAlyt5cMHSO6/opGsrPFHVwD/RDrmo7ob6UVcE3K2vJFhHQE1CYCeA5F0CtbxrYp5teFgCUqc1V4II57yW3QKiQxyVhzo6p8MJkbZ/5XAZGeCL1bBG9M+1nAD1Ji9/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718737192; c=relaxed/simple;
	bh=Ur1OWobQPAPWDk4FM7kLcqctEZ7DzADHHOAkiR9UYfw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mr+UajwL73dBDPYjx9DI3u5yHsJHbNe9Hgt78bYaivD5RjbVn/3FA6N0Sx5PUNLJr+7uDpFaZ4Eo46ys7ivw+3iWJCrz4IeP7NwRcsFDR+ULXFJG6vLChJ9PdGQlVG3dGSyLdXEJG/Ql9sL4yQvZ3LnnAVgGDHUZpqJucfnQZOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=FMSQWLPx; arc=fail smtp.client-ip=40.107.95.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhbGC1JIx69wQk8x1S7+dcvlAqBhGG8Oxs4gvnfooOljCDzWGl4+z+9m85FANo6ZmztHzpFtyvq9GUz7yLD3Apw+NlcEwdyeDm3to9CAd8uGwDL1Peu3HHUprYsMlAVvvUSTEOFOb68/V80RGhiJez9TEIR53sYeYG7KRGFvjQaTxhPAUGo/chR3sxU3zesWxjSVWQ0q7D2/WDgWn9wmErJO73INF6fj1A3c5mwUKBZJ5VsB2IGj6GRqOMlyhxpWnRtk9x83k2cEA4ZwaRdGfxRo/2p79y6uZuU+f875i+rNCbruVIUFkbq3McBlyL93sR+VJcDLw9TsanTykhP5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ur1OWobQPAPWDk4FM7kLcqctEZ7DzADHHOAkiR9UYfw=;
 b=PJsnLHN6/DJI1mz0mIS7/Cl9wMG6yDA36w/qlzARyyyWE+wuhOwd47BjwJwjeJgAgJVQvjT7/YiHZemYstyBt5SdLFEYOVTTx00hQfMolZTjyH7yomrD9P1JvWlzwrZ05UtklxjKBbE58duXfBC/SIPz17QjZy48gQlN0KniYuqFV04JCLZ5DnZPJT+WVmhgSOevI7uJKNCcUhYEVeE0Rs9MMlHXARZM53Lxxyhce+1dfLISM34EEhfJ8vvVJESLqeBrorwDL6KyLX3VkgFwjafpXEG5sCvvsawaFMaASCMarbbJ6o0rqtC0qBahCIj6S0cF7Qgd7syIUjlbNIgRMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ur1OWobQPAPWDk4FM7kLcqctEZ7DzADHHOAkiR9UYfw=;
 b=FMSQWLPxUQxwk4AYXopIyDN2U71PJjDvQnn1ejGyPr05OXJAIjn+Sj+DP3K8wS9RCkjObuxLpmvTuc8T3PBJnlmQDApwYGpubUOOpb5Spf8PMPXOxRStUE93+wXvwqmyMD69cbUX9kkSCCk5HqNVL0JOU1M2vHGcWDhAHmgeLXk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY3PR13MB4849.namprd13.prod.outlook.com (2603:10b6:a03:363::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 18:59:47 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 18:59:47 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: add 'noextend' option for lock-less 'lost writes'
 prevention
Thread-Topic: [PATCH] nfs: add 'noextend' option for lock-less 'lost writes'
 prevention
Thread-Index: AQHawZTgISFLcUQ41kCD6EOpRxYIYrHN4DUA
Date: Tue, 18 Jun 2024 18:59:47 +0000
Message-ID: <d2f48ca233f85da80f2193cd92e6f97feb587a69.camel@hammerspace.com>
References: <20240618153313.3167460-1-dan.aloni@vastdata.com>
In-Reply-To: <20240618153313.3167460-1-dan.aloni@vastdata.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY3PR13MB4849:EE_
x-ms-office365-filtering-correlation-id: 8e9c871c-2cf4-4544-239a-08dc8fc8d317
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkU4Nzk1Q1p6TTFLbXdLV1ptZ0JpQXljR2N1MlZhYndidld4RHdteHFSbHhQ?=
 =?utf-8?B?T3FSaWxJa2dYeVo3ZzJEMUF4dUZyN21Xdno2dXI5YkxNNlFmb29CV2hTR2ZD?=
 =?utf-8?B?b21PQndxaktSVitUVzJXMkx0VkRyRnJ2eTFKYnFyY3dxRXlqMGVLd3RMVnFx?=
 =?utf-8?B?MysxTXZJNmpOMzZ6RE5PR0x0cTduLzBSV2paNjZrakl0dldlYmt1cDlTSXh1?=
 =?utf-8?B?WUtXcTBHaEZxUldKcy83c3RpMVdycG1jdFhUNW5NMVV1MGY1bE1CN2hJQkRP?=
 =?utf-8?B?cE1TN2hXdU16aVlLalNjNkdXVVIxbDBjYjRaRXRTb2I2Y2lsQ3dKc2x1WnZE?=
 =?utf-8?B?OTh2T3BTQXk0aUR5UTJIVXhCd2RQVDl0TjF1Znc4SnU4Syt3MXY1QVdmQld6?=
 =?utf-8?B?aEZSaWRGYXp6ckM0UnpmNnRFbFJyejJKZmtORm5yeCtYS2lQeUJUbCtHRU1l?=
 =?utf-8?B?RGdhOGd3bU4zK1k1enhCSjJYYkd0YU93NHNWdHdxdEtoUkN5WTdBMkUrZGt4?=
 =?utf-8?B?N3pxOThCZVRPNVF5QjRXVHRoRWdsTzI2YmJjaXRKZkRvQWl3QVM4a0VQdFBt?=
 =?utf-8?B?YmxyTVFZUW8zSUs3UldWRXZUNURPUnVBTm9maUVCN2ZteU9IdGpNaUZPd3hZ?=
 =?utf-8?B?bzJSRVpWa3doVGdVL09QdE1TcG02UzB6MHZ6aloxVmpUQ0FMMXlGVjlaa3pr?=
 =?utf-8?B?dnJSQXVjNmtOL2hGMGRUR3A1dGR6ZWc0RENBUjg4YlJiOU5UWUVYRUZTeEpO?=
 =?utf-8?B?YW8yTUkrVzUwQWV5L2E1a2ZxODhCdDFHMWg4a1lac0lEMjNOWGlEQVk0ZTUv?=
 =?utf-8?B?MVo3eDdhVlVpaGM5a1ZUR2p0bUZqR1lObWhuQ09Sdzd6WHFTWTFRZmE3YnFH?=
 =?utf-8?B?YkVhYlF2eGR1Q2xtQWV5eEEvbFVKb0FvRGpOdW5SQk4wK3BnUHZxazBPa3dz?=
 =?utf-8?B?bjBQUGthbmNXQ1pTNDZBQncyN05iWnJkM1B6YUgzazVRQkUzeEtabXZoK3c4?=
 =?utf-8?B?KzVZeWtrS2M3b1ZOUFZYZVhFMUlTYUZzOCt2b0VKZnhBbzgxUmtBQ0k5QW8w?=
 =?utf-8?B?dStvYTloay9VbnAwaHBQeFc5WCt5Yk54Y3VBVkQ4VURqdmY2UWlVUERJV3hz?=
 =?utf-8?B?dTdRM2o5UU5ucklzanZhMlVpY2JyVWp5SVdmREgxMVFlSEI4QzNrYUF1Rkly?=
 =?utf-8?B?N2ovWjhINVRSei9xM1RhSWRORjNxM0E1U1U0Nk1QdStBVmZhTEZLY044YVd0?=
 =?utf-8?B?eHg0UFdLdGxOdDh4bnB1TjcvaHA0dzZjeXNPUExlUWNTWWh5MENycW12dkFo?=
 =?utf-8?B?UHlNejJud201OEhJM3pzOHhOQXpPOFE1cUUrMXh6bElHWmgvMnVOZll5TUVm?=
 =?utf-8?B?OTVsMktkNjhzOXpxTTRPT1FXSEpZUXZxcjg2b2tzMVQ4aTUrNU1Jcmw4anVZ?=
 =?utf-8?B?NWgrSmRBZzBEbjl0am15Q3lZR1ZPVjkzcXZzdEhqVnZJU3Nma0M0NGU4SUFK?=
 =?utf-8?B?alFIck9YZmw5Vm5la1BlRVZWbytyak5xQThFbkZMQUhlVjhxL0hCaDM5Zzgz?=
 =?utf-8?B?RS9NazN4UGJjRlFmUnNsRXJTWnJnbTE4bzh1QTdwYlBWRGJJcnRiczRkV1pV?=
 =?utf-8?B?TkpDYlhwUFNxc0g3a0t5VjVydTJCcGRNRUpuS2hSUFZ4RjA3bFJkWDd4aFhL?=
 =?utf-8?B?SWJqeThTNXViUWlzcmJ0VnJ3WGpibk5kamZBaTNITEZabXRXcWNsNURRRVd1?=
 =?utf-8?B?SUYrL0YrMThNU1o5VWVwbXAvOThCQjE0RHhTNFQ1U0h4NEM0VzNJakY1T2RF?=
 =?utf-8?Q?4WjezVb8KclGidK+UjJWaf9rj/5nJMTyAQVbw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUY5cjdvVUdrb2kxQW5BNmxMRE1UK3JtMlF2Nnl1R2hEWXdnMTNJcllLSE5J?=
 =?utf-8?B?eWx4QS9xM09DYklOKzZGWVkxempEbHJZdjNsUTUvVHNKdlRZenVVUUEzV0hZ?=
 =?utf-8?B?TlFleUo2NlRlK1VRcDIySDhvS3BxTjZZZzZrdExZZ3dGRUhuWHh3bEJhOE1h?=
 =?utf-8?B?dVpiQUwyUDQ0UFN6eUtFT3ZiVXRJNVhUcGc5RXVRSWdLL3V0Zk1nQXBiS0pn?=
 =?utf-8?B?NE9uTXVpT2ZPTFZDMU5GR294aHFwQ1VmZXRuUEtFM2hlV3JkUms2SDF0ZlZ3?=
 =?utf-8?B?U21DM1NFb0lrWmFJbUp2c1NjamJyWXl4RnFJMUFkYThBU3lsZTZIY0NaUmx2?=
 =?utf-8?B?SFN3engrOTF6S3FMdVVoSktXemo1TFFEa2drdWYvT1lmeGI5R1JQUVZBWmZG?=
 =?utf-8?B?S3Zyc2h4VXV0Ly9uNHRFWUVyZTJhRTVTbW45aWlwZElGMWsxTTZFYVdQdmt6?=
 =?utf-8?B?a0FicTBRYkFrVWpQZDlLTTEvMkxpZ2gxM1c4VldMZStsN3cvcUZaTS9ieDdG?=
 =?utf-8?B?Mk1ldTFVTHVRamIyQy9TRzZXQjJDSCt6NjJFZ3hLcUZUSVVxNUdwVzZ2T29s?=
 =?utf-8?B?d2k4VEpBbUFmbGJTUW1iaEkxbDBZaTJEdDMxUW1iai9oZjFCSk42bXdyVll4?=
 =?utf-8?B?aEZiNUlJUnZIZ1pnYzQ5UEM5aFRsWWx1TzlGN0tuZDdqamVVZ053enJ1Mm1Z?=
 =?utf-8?B?TGlHWHZVcktYWSs1Y2Vsb0lYYW5KQUhhbkx3bWk4S2t0MmpsTmZGSW1jc01C?=
 =?utf-8?B?MlZDRWFCdDBHVUx1WEJjZnoxYW9MWXlORkZ2dEtHeFg5eXNMOWx2U1FYb3Yr?=
 =?utf-8?B?ZVFLeEtSUHZabmNldnowNGR3dGdZSFgxTWN0cm1BUG81eXRsclpxbmtoMzky?=
 =?utf-8?B?emM4THl2MVZXMWdJT1lmQjVyL3BzMjRzbk1jc2Jpc1d3Vm5Yc0MzcFRnTVJ0?=
 =?utf-8?B?MzFOcXBLelIvUHhkL01RUkNvcVcvNU92N1hZcHFVUUpWQ1ljekZqMlFNY2xl?=
 =?utf-8?B?b1RmcEgyck1MTFo1MHowNytPakNwajI2a1AyVXhuQWltd3JFWUJFUG5nMThY?=
 =?utf-8?B?N0xVeTFwZGs3c01uNnVwbDNIUkFYRTZYTEQ4VmtSWFUzblMrMG0yUG0yYXRn?=
 =?utf-8?B?ZVJDUVduVTFxR2RUVDdHbHJrUnltQVJjdWlHbGl5OE42Vk4zbUtQTU9lNDJP?=
 =?utf-8?B?ZnVjU0EvRnplUngvWVNMUDViWU9BZ1FvbVdKMngrUVVnMFNJbnlWMTM0d0FC?=
 =?utf-8?B?clhKMjFIaFJyR3MyYmNSdC9ZaGlPQy84OXc5K3ZtKy9pcS8wS1VSdUFBNGIy?=
 =?utf-8?B?ZTh0MWlMc0ZqMEUvL2F3OEoyVDJ4Y2NNNytWaXoxaWlTQ0FLTXRTR1ZDT3pp?=
 =?utf-8?B?SzJjYUk5Tko1SVkyVURtT3pFZE1SN2pGOXJZMWVIV0FYMlRJeGNwNVJ5TTZM?=
 =?utf-8?B?SExyR2IxaDB2UlNvTHZjaG5ma3U4bUF5SVpjRTNac0JMUGEwd1JwSU95L1d4?=
 =?utf-8?B?U3JUYXY4a0l5S1ZpUnkvcFViMUlTSkJ3aHBFTDZVVHdRQVRqbUtDLzZOUVNj?=
 =?utf-8?B?dEE5MDgxMFdDMzBiMDVtZkpJSjBWWnFybHowcUdZTGt0cXBwWDA3RlFFWXpI?=
 =?utf-8?B?QVY4RzBDZVpVSDFSa2tsNWpsYU5pR29LV3NKY2JmR2trUDBVblp0VDFYNGpn?=
 =?utf-8?B?ZkgxTDNwclJOZ203RXpkYTRVc1FjY3lobEVCN09QOWFSOXVzSmNpcm1JKzdB?=
 =?utf-8?B?UlNmR0s0ekdYVjltL1gzZ1JBT3FqMkVEQTJZWUlvS2M3MGFMRVN3dldsd2R5?=
 =?utf-8?B?QnBsRUZuQWVXRFVrQktlNDdQV2NiRGpBdlh1dlU3NHV6a3VqTzVSY3lNYnFo?=
 =?utf-8?B?TDFFRHdvOGJFZlJTa0FiaWk4RG00cnBqUHBIUG5DM3FocVhmSDRjZmZoWEZo?=
 =?utf-8?B?MExlNXB1N2pzaitXOFpyOE1WWmpIVGhwM1RyR2g3ZmZQdVRLYXdrV1cwVFUy?=
 =?utf-8?B?MUlhbTh3YzZXR1FMaG5LTmFYd0krNFMvMXB1RHdsM1pjallxeFBBZjRvdHF6?=
 =?utf-8?B?QXl0SFk5d3ZXbEUwZWp2K0JDVDRKb3l2ekQ0SmpRWFA3TFJMb2JrdWg4OU8w?=
 =?utf-8?B?dnVHcmZTSUVsQWZaS2JMeGY0VUpPT0d6by8ycmhNcnloQmk5cEkrVGU0N2x0?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B890808444CE16408B7D1F2999557041@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9c871c-2cf4-4544-239a-08dc8fc8d317
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 18:59:47.7037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNEDr7KjVPETBPalxXK9721mZ5x7Ua5lx+PrWKH6ub7jR07N+GZEmp68ULRwpgO/VzTvc9v2y/gfgbVaJh71Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4849

SGkgRGFuLA0KDQpPbiBUdWUsIDIwMjQtMDYtMTggYXQgMTg6MzMgKzAzMDAsIERhbiBBbG9uaSB3
cm90ZToNCj4gVGhlcmUgYXJlIHNvbWUgYXBwbGljYXRpb25zIHRoYXQgd3JpdGUgdG8gcHJlZGVm
aW5lZCBub24tb3ZlcmxhcHBpbmcNCj4gZmlsZSBvZmZzZXRzIGZyb20gbXVsdGlwbGUgY2xpZW50
cyBhbmQgdGhlcmVmb3JlIGRvbid0IG5lZWQgdG8gcmVseQ0KPiBvbg0KPiBmaWxlIGxvY2tpbmcu
IEhvd2V2ZXIsIE5GUyBmaWxlIHN5c3RlbSBiZWhhdmlvciBvZiBleHRlbmRpbmcgd3JpdGVzDQo+
IHRvDQo+IHRvIGRlYWwgd2l0aCB3cml0ZSBmcmFnbWVudGF0aW9uLCBjYXVzZXMgdGhvc2UgY2xp
ZW50cyB0byBjb3JydXB0DQo+IGVhY2gNCj4gb3RoZXIncyBkYXRhLg0KPiANCj4gVG8gaGVscCB0
aGVzZSBhcHBsaWNhdGlvbnMsIHRoaXMgY2hhbmdlIGFkZHMgdGhlIGBub2V4dGVuZGAgcGFyYW1l
dGVyDQo+IHRvDQo+IHRoZSBtb3VudCBvcHRpb25zLCBhbmQgaGFuZGxlcyB0aGlzIGNhc2UgaW4g
YG5mc19jYW5fZXh0ZW5kX3dyaXRlYC4NCj4gDQo+IENsaWVudHMgY2FuIGFkZGl0aW9uYWxseSBh
ZGQgdGhlICdub2FjJyBvcHRpb24gdG8gZW5zdXJlIHBhZ2UgY2FjaGUNCj4gZmx1c2ggb24gcmVh
ZCBmb3IgbW9kaWZpZWQgZmlsZXMuDQoNCkknbSBub3Qgb3Zlcmx5IGVuYW1vdXJlZCBvZiB0aGUg
bmFtZSAibm9leHRlbmQiLiBUbyBtZSB0aGF0IHNvdW5kcyBsaWtlDQppdCBtaWdodCBoYXZlIHNv
bWV0aGluZyB0byBkbyB3aXRoIHByZXZlbnRpbmcgYXBwZW5kcy4gQ2FuIHdlIGZpbmQNCnNvbWV0
aGluZyB0aGF0IGlzIGEgYml0IG1vcmUgZGVzY3JpcHRpdmU/DQoNClRoYXQgc2FpZCwgYW5kIGdp
dmVuIHlvdXIgbGFzdCBjb21tZW50IGFib3V0IHJlYWRzLiBXb3VsZG4ndCBpdCBiZQ0KYmV0dGVy
IHRvIGhhdmUgdGhlIGFwcGxpY2F0aW9uIHVzZSBPX0RJUkVDVCBmb3IgdGhlc2Ugd29ya2xvYWRz
P8KgDQpUdXJuaW5nIG9mZiBhdHRyaWJ1dGUgY2FjaGluZyBpcyBib3RoIHJhY3kgYW5kIGFuIGlu
ZWZmaWNpZW50IHdheSB0bw0KbWFuYWdlIHBhZ2UgY2FjaGUgY29uc2lzdGVuY3kuIEl0IGZvcmNl
cyB0aGUgY2xpZW50IHRvIGJvbWJhcmQgdGhlDQpzZXJ2ZXIgd2l0aCBHRVRBVFRSIHJlcXVlc3Rz
IGluIG9yZGVyIHRvIGNoZWNrIHRoYXQgdGhlIHBhZ2UgY2FjaGUgaXMNCmluIHN5bmNoLCB3aGVy
ZWFzIHlvdXIgZGVzY3JpcHRpb24gb2YgdGhlIHdvcmtsb2FkIGFwcGVhcnMgdG8gc3VnZ2VzdA0K
dGhhdCB0aGUgY29ycmVjdCBhc3N1bXB0aW9uIHNob3VsZCBiZSB0aGF0IGl0IGlzIG5vdCBpbiBz
eW5jaC4NCg0KSU9XOiBJJ20gYXNraW5nIGlmIHRoZSBiZXR0ZXIgc29sdXRpb24gbWlnaHQgbm90
IGJlIHRvIHJhdGhlciBpbXBsZW1lbnQNCnNvbWV0aGluZyBha2luIHRvIFNvbGFyaXMnICJmb3Jj
ZWRpcmVjdGlvIj8NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFuIEFsb25pIDxkYW4uYWxvbmlA
dmFzdGRhdGEuY29tPg0KPiAtLS0NCj4gwqBmcy9uZnMvZnNfY29udGV4dC5jwqDCoMKgwqDCoMKg
IHwgOCArKysrKysrKw0KPiDCoGZzL25mcy9zdXBlci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IDMgKysrDQo+IMKgZnMvbmZzL3dyaXRlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMyArKysN
Cj4gwqBpbmNsdWRlL2xpbnV4L25mc19mc19zYi5oIHwgMSArDQo+IMKgNCBmaWxlcyBjaGFuZ2Vk
LCAxNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2ZzX2NvbnRleHQu
YyBiL2ZzL25mcy9mc19jb250ZXh0LmMNCj4gaW5kZXggNmM5ZjNmNjY0NWRkLi41MDk3MThiYzVi
MjQgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9mc19jb250ZXh0LmMNCj4gKysrIGIvZnMvbmZzL2Zz
X2NvbnRleHQuYw0KPiBAQCAtNDksNiArNDksNyBAQCBlbnVtIG5mc19wYXJhbSB7DQo+IMKgCU9w
dF9ic2l6ZSwNCj4gwqAJT3B0X2NsaWVudGFkZHIsDQo+IMKgCU9wdF9jdG8sDQo+ICsJT3B0X2V4
dGVuZCwNCj4gwqAJT3B0X2ZnLA0KPiDCoAlPcHRfZnNjYWNoZSwNCj4gwqAJT3B0X2ZzY2FjaGVf
ZmxhZywNCj4gQEAgLTE0OSw2ICsxNTAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZzX3BhcmFt
ZXRlcl9zcGVjDQo+IG5mc19mc19wYXJhbWV0ZXJzW10gPSB7DQo+IMKgCWZzcGFyYW1fdTMywqDC
oCAoImJzaXplIiwJCU9wdF9ic2l6ZSksDQo+IMKgCWZzcGFyYW1fc3RyaW5nKCJjbGllbnRhZGRy
IiwJT3B0X2NsaWVudGFkZHIpLA0KPiDCoAlmc3BhcmFtX2ZsYWdfbm8oImN0byIsCQlPcHRfY3Rv
KSwNCj4gKwlmc3BhcmFtX2ZsYWdfbm8oImV4dGVuZCIsCU9wdF9leHRlbmQpLA0KPiDCoAlmc3Bh
cmFtX2ZsYWfCoCAoImZnIiwJCU9wdF9mZyksDQo+IMKgCWZzcGFyYW1fZmxhZ19ubygiZnNjIiwJ
CU9wdF9mc2NhY2hlX2ZsYWcpLA0KPiDCoAlmc3BhcmFtX3N0cmluZygiZnNjIiwJCU9wdF9mc2Nh
Y2hlKSwNCj4gQEAgLTU5Miw2ICs1OTQsMTIgQEAgc3RhdGljIGludCBuZnNfZnNfY29udGV4dF9w
YXJzZV9wYXJhbShzdHJ1Y3QNCj4gZnNfY29udGV4dCAqZmMsDQo+IMKgCQllbHNlDQo+IMKgCQkJ
Y3R4LT5mbGFncyB8PSBORlNfTU9VTlRfVFJVTktfRElTQ09WRVJZOw0KPiDCoAkJYnJlYWs7DQo+
ICsJY2FzZSBPcHRfZXh0ZW5kOg0KPiArCQlpZiAocmVzdWx0Lm5lZ2F0ZWQpDQo+ICsJCQljdHgt
PmZsYWdzIHw9IE5GU19NT1VOVF9OT19FWFRFTkQ7DQo+ICsJCWVsc2UNCj4gKwkJCWN0eC0+Zmxh
Z3MgJj0gfk5GU19NT1VOVF9OT19FWFRFTkQ7DQo+ICsJCWJyZWFrOw0KPiDCoAljYXNlIE9wdF9h
YzoNCj4gwqAJCWlmIChyZXN1bHQubmVnYXRlZCkNCj4gwqAJCQljdHgtPmZsYWdzIHw9IE5GU19N
T1VOVF9OT0FDOw0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL3N1cGVyLmMgYi9mcy9uZnMvc3VwZXIu
Yw0KPiBpbmRleCBjYmJkNDg2NmIwYjcuLmYyN2ZkMzg1ODkxMyAxMDA2NDQNCj4gLS0tIGEvZnMv
bmZzL3N1cGVyLmMNCj4gKysrIGIvZnMvbmZzL3N1cGVyLmMNCj4gQEAgLTU0OSw2ICs1NDksOSBA
QCBzdGF0aWMgdm9pZCBuZnNfc2hvd19tb3VudF9vcHRpb25zKHN0cnVjdA0KPiBzZXFfZmlsZSAq
bSwgc3RydWN0IG5mc19zZXJ2ZXIgKm5mc3MsDQo+IMKgCWVsc2UNCj4gwqAJCXNlcV9wdXRzKG0s
ICIsbG9jYWxfbG9jaz1wb3NpeCIpOw0KPiDCoA0KPiArCWlmIChuZnNzLT5mbGFncyAmIE5GU19N
T1VOVF9OT19FWFRFTkQpDQo+ICsJCXNlcV9wdXRzKG0sICIsbm9leHRlbmQiKTsNCj4gKw0KPiDC
oAlpZiAobmZzcy0+ZmxhZ3MgJiBORlNfTU9VTlRfV1JJVEVfRUFHRVIpIHsNCj4gwqAJCWlmIChu
ZnNzLT5mbGFncyAmIE5GU19NT1VOVF9XUklURV9XQUlUKQ0KPiDCoAkJCXNlcV9wdXRzKG0sICIs
d3JpdGU9d2FpdCIpOw0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL3dyaXRlLmMgYi9mcy9uZnMvd3Jp
dGUuYw0KPiBpbmRleCAyMzI5Y2JiMGU0NDYuLmVkNzZjMzE3YjM0OSAxMDA2NDQNCj4gLS0tIGEv
ZnMvbmZzL3dyaXRlLmMNCj4gKysrIGIvZnMvbmZzL3dyaXRlLmMNCj4gQEAgLTEzMTUsNyArMTMx
NSwxMCBAQCBzdGF0aWMgaW50IG5mc19jYW5fZXh0ZW5kX3dyaXRlKHN0cnVjdCBmaWxlDQo+ICpm
aWxlLCBzdHJ1Y3QgZm9saW8gKmZvbGlvLA0KPiDCoAlzdHJ1Y3QgZmlsZV9sb2NrX2NvbnRleHQg
KmZsY3R4ID0NCj4gbG9ja3NfaW5vZGVfY29udGV4dChpbm9kZSk7DQo+IMKgCXN0cnVjdCBmaWxl
X2xvY2sgKmZsOw0KPiDCoAlpbnQgcmV0Ow0KPiArCXVuc2lnbmVkIGludCBtbnRmbGFncyA9IE5G
U19TRVJWRVIoaW5vZGUpLT5mbGFnczsNCj4gwqANCj4gKwlpZiAobW50ZmxhZ3MgJiBORlNfTU9V
TlRfTk9fRVhURU5EKQ0KPiArCQlyZXR1cm4gMDsNCj4gwqAJaWYgKGZpbGUtPmZfZmxhZ3MgJiBP
X0RTWU5DKQ0KPiDCoAkJcmV0dXJuIDA7DQo+IMKgCWlmICghbmZzX2ZvbGlvX3dyaXRlX3VwdG9k
YXRlKGZvbGlvLCBwYWdlbGVuKSkNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbmZzX2Zz
X3NiLmggYi9pbmNsdWRlL2xpbnV4L25mc19mc19zYi5oDQo+IGluZGV4IDkyZGUwNzRlNjNiOS4u
ZjZkOGE0ZjYzZTUwIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L25mc19mc19zYi5oDQo+
ICsrKyBiL2luY2x1ZGUvbGludXgvbmZzX2ZzX3NiLmgNCj4gQEAgLTE1Nyw2ICsxNTcsNyBAQCBz
dHJ1Y3QgbmZzX3NlcnZlciB7DQo+IMKgI2RlZmluZSBORlNfTU9VTlRfV1JJVEVfV0FJVAkJMHgw
MjAwMDAwMA0KPiDCoCNkZWZpbmUgTkZTX01PVU5UX1RSVU5LX0RJU0NPVkVSWQkweDA0MDAwMDAw
DQo+IMKgI2RlZmluZSBORlNfTU9VTlRfU0hVVERPV04JCQkweDA4MDAwMDAwDQo+ICsjZGVmaW5l
IE5GU19NT1VOVF9OT19FWFRFTkQJCTB4MTAwMDAwMDANCj4gwqANCj4gwqAJdW5zaWduZWQgaW50
CQlmYXR0cl92YWxpZDsJLyogVmFsaWQgYXR0cmlidXRlcw0KPiAqLw0KPiDCoAl1bnNpZ25lZCBp
bnQJCWNhcHM7CQkvKiBzZXJ2ZXINCj4gY2FwYWJpbGl0aWVzICovDQoNCi0tIA0KVHJvbmQgTXlr
bGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

