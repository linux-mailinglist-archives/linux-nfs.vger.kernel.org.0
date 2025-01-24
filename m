Return-Path: <linux-nfs+bounces-9601-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52506A1BD75
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 21:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BC118903B0
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 20:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0644225A22;
	Fri, 24 Jan 2025 20:29:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2120.outbound.protection.outlook.com [40.107.220.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98222540B;
	Fri, 24 Jan 2025 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737750585; cv=fail; b=SqZtQw7FcymaTILAB5lRPfKROHFxcZjd5HBDgTJ97P0rwaXOQIseBYMZSxBq0oWR9MzcPCvKgffUJ0fkQYiBb2EPtZZiZ0x1p7BzPpRlEFGP1Bkb+tzegqgl+4FmCNmbjAklKFdK8fibQAeefkmgSubgZUUaGMBFeOxYUM2ZSIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737750585; c=relaxed/simple;
	bh=iRLEgRE/n7m8USKpZhbrJhOzCVKSzbidXU3e1MW4b1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=efkLIKcOq2ag/Y6dGZ70HGvhC64Q4GYRa5CkbjSCPEML0avZb7BmOmrirtpwTTkE4Q8LJahgFqf3cz9TvQsakPrBbIsyynL6Hq4HxD6quAjWtDC+IH+y6bTc4WRLrXQ7SS/kzSm8LL043Xg9l2HbPJUb/NmBV/AeOMyYdZoN8Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.220.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miaXdcGsT2enB0vdmRLz8NFiHv6QETgqfdWvGGR/AvQT5SZGmpsH2cqnpQHm07hyhFcFcKiI5AOkoen85Y2exV6SvuBn4aQgiSZcuhkUYbZECMe6EDpEgWx5WJJwQPKwIPq2/FQc8C5J3L5I9gW2ODmamwM1mTtGGEg/lFM+FJrBWucWZH+F1IHjEVGu5j2CV3AIHLujvb1xS6h2Hlc8QccTvFkBL7CpeoA9GJm0LfGqa38nkOCfE2naidWamCgXJnQS+smEvwdK0gesjAm21USw65NuMLrIs5i7/AtFWJGbeen0kbw9Q1ohxSir15/RUEgF6vQ7MhrRblJGvo9jKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Rk2Dq1dNE3fn2Tqp2riTRi7Knftms5+IApcrQILk3U=;
 b=vr1hTBet0/rT95sxfxg4sqXaTlYya+6SVVzXSUFGRO4Qo36g79EKp+HArwpp3LGKsVl1h+Rxii+7ImkhEFreKEQCCGLbrwUIQrm9sp+NcTm7AdbqEyirunURohEloRvvdlobN2C/CrXXrrwQHgMaK7A4EP5FZneh07Ai/nFUWRsw4n71pLzjYJZv28bKs5F3OJ7XxKrhmBBdPVKAm8+55++ektJVeW5RJ8odxJPwZPcg5ThEzTVR8lZt1XHC67s5xICIiLn5ua4RDuNK9Ai0pnF5wMfNrKn407uc8v5vYgoO8Rr+hjupUfpqv2V+MPPHawjzCvcq7TQ9ZjoOqqYmew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 BN0PR01MB7216.prod.exchangelabs.com (2603:10b6:408:15b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.19; Fri, 24 Jan 2025 20:29:38 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 20:29:38 +0000
Message-ID: <2650b9f3-88a6-4f9a-b98b-1b062fb11a0c@talpey.com>
Date: Fri, 24 Jan 2025 15:29:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] nfsd: when CB_SEQUENCE gets NFS4ERR_DELAY, release
 the slot
To: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-3-c1137a4fa2ae@kernel.org>
 <a95521d2-18a2-48d2-b770-6db25bca5cab@oracle.com>
 <4f89125253d82233b5b14c6e0c4fd7565b1824e0.camel@kernel.org>
 <Z5OdECjsie-MCFel@poldevia.fieldses.org>
 <8314a4b3823ead3dc08411dd48da70e5dcf6b2ae.camel@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <8314a4b3823ead3dc08411dd48da70e5dcf6b2ae.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0426.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::11) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|BN0PR01MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dc1125-d2ba-4c2c-8d76-08dd3cb5d2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTVkbnM3T3A4aCsyUHVLSWR3T0FMQjdDSm1zR2NhcVlBY3dWdjdvYVRuT2Ux?=
 =?utf-8?B?QjVGWnFZdnVwbFQwclVkL3A0TDNJY0JEUFAyUHZqVk5jL3VKOWJGU1BrNERR?=
 =?utf-8?B?UW02eUlVTE5SdzVuRnNMZFkwZmhFRXdMMi94YWovMEJOSHhEVWpzNSs4Tzk4?=
 =?utf-8?B?anZzNWlOL3FPbS9EeERIM01pMkxqeFZJVytHY2JqZFFGWkhaMDBWZzg1R29O?=
 =?utf-8?B?WVhtd3lBUFZiRVBZUDU4R2FaS1hQRnk2WS9FK1VHdnIxQS9NR05WS0R0UVBo?=
 =?utf-8?B?eWMyc1V2VVErSitBQmhieXQyc0o1dzhsT1ZZN01IOThFaEZ6YXY3WmM5bTBn?=
 =?utf-8?B?USt5cW1LRHgvdnlJc0xPaUxoSk02RFlOeW11dW94MTdFWUsydkFNbVBKa2Vj?=
 =?utf-8?B?V1FOQUVtUmdMaDVwWCtvNWU1UHJzcTR2V0hmSmhrQ0U0WXlHdSt4KzJWK1BS?=
 =?utf-8?B?czhKZVB0SkVLWHhJZGhzSjBZVU9kS1ZEY1QwMS9xNUNObTFJRGZadVFrUTJB?=
 =?utf-8?B?R1hQZlNTUGJjaEtMeWM4ZnpzaDM3VmhPQUlhb3NzTGZaZFNMNDF5cFRjTkI0?=
 =?utf-8?B?RjEvcnJSYTNQTkZRT3J0c2tFTnRkVHFlL29HWUVTMWNXdlFWTmJ2bVBaSWlC?=
 =?utf-8?B?T2ltSHpyM25ZRng1bUhmZklOeTRuZmgrWHVLSHNZTEVxRWxXQ0lESG1VejF3?=
 =?utf-8?B?Zk1YN0NQWjNhaWRrMHZzVWJ0QjRPWWkyTzh2SVUzT0VDb09YNUR3SkwxV3BQ?=
 =?utf-8?B?ZzZxR2tIQnB1QlJpZk9IbkF1NmxSSnFTR2p6WFk1TnZaMlRDbjJ6c2ZrSkhj?=
 =?utf-8?B?RGkvRHJnQWIxcG9JNlFXaDE0SUxSakp6cU83b1U2WXh5Z0ZVb1ZzTTRZZm1q?=
 =?utf-8?B?MWkvZGdvNUt2TnZUeVZSQThhK3NndThrbC9HdEpnTjVVNFVpN1piV1JSa1ov?=
 =?utf-8?B?OHUzQ0FxN2NrNFE4OS80MDFHcmF0WGhBUzliaXJrWGtuWlhveFdQWlhudzU0?=
 =?utf-8?B?Mnh6eXhLWUk2bzE4RHEyc0I1Y09kRkNGTGhSVkU2MWlodzFrSWRNVmxTa1VS?=
 =?utf-8?B?U1NqRHBtTXNRTW9rcGNHeTRBWGpJMjBsd0Q5a2p6YUM5Z2E4NTVyVEJTRFpI?=
 =?utf-8?B?Y1hlUzJnbjUwTGc1NUlnTURENW5JR05SR2RYWGpUQ2F4dnZETmFwMjlsb0lq?=
 =?utf-8?B?Nk5GWXVSWUxkak4vR3EzdlplY1ZaZkdxZEdtUlJnWkFjTVRoeEhJQ0k4MHo2?=
 =?utf-8?B?cXBnUlhCOHBWWVovOVk0NGNyR0FaQlZTbFNJQURDdTJPMXlFcmhVL1lQbkhv?=
 =?utf-8?B?MUMxL0FwbjRyS1ZYMW83M1cwdExCYTVnNkk0MUV6QkpDMFdCbDVSUXVERlAx?=
 =?utf-8?B?dGU0S3BpZ0Z3VklOQnljMEU4NFkzZHJQV3pnbG9ra0NxYmRrREdXN3lmR2RY?=
 =?utf-8?B?cFRsbkJMVkFFcFR6OXZYdDRvK2F4Z3p1UDg5NUJOVlp3U0MvczNCS0ZzSytl?=
 =?utf-8?B?cDFyZWFpd3N0ak9ZdHRIbW1Dc0pwbElQSjQyQ1hLdTdacmFhYkhhZS8zL0Yr?=
 =?utf-8?B?SWRSRHY5Q01CUlR2cjZUYXVXUUg2OFBiWkRGUGF3cUh6MUR1NEw3WDBJck1w?=
 =?utf-8?B?b2pMK01ZclphdHV1akdWeGxKa2dKdTVacXdoeUhEVGU5c003VUJkMUVxYStv?=
 =?utf-8?B?aU56dXpaeDVWdXNFUG1DZ1BEVFdKakVyZCtiRGkrbG1YRkNjc1M0OUU3a0Q2?=
 =?utf-8?B?WGxlaVpTV1VneWJ2aGo3ei9yMmdBcVhPWVl1R29XZGM1SksrWHFMa0hsak9X?=
 =?utf-8?B?bkwxSm56QUVkeHRmNHlWeVJLRnFTMHFpK05wV1lhRHhlNEhSYUkveko4TS8r?=
 =?utf-8?Q?U10+n1Tn38Gcm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHVKV1dlTFNmVXpiazYvVFdkM0J6ZTcxMWJ2SnR0SVR4ZXF3TnFQamhEcmk3?=
 =?utf-8?B?ZzBIcHlFbXFnUHdsU1hER2NKelpOWTc2dDU5UnJKeGhLYjFMY1lCN0ZBTDJC?=
 =?utf-8?B?Zk1IT29wWmFDZzlFdFNmWjRUVWpzSXRQUmxOV2t5TCtDZ3pNOElITWdvYVI4?=
 =?utf-8?B?Q2lsU3ZDM1pRd0h6WENTcHhrTXh4R1g0Z0UzcjdlTzNlY25DS09ENG9aTGNj?=
 =?utf-8?B?UVI4T0o2SXFQeDY0NmlNdC9SSVZqNi9VTk1SUi9DT2tudjE3dzlvOGl0Qkxn?=
 =?utf-8?B?M2lmaDJsY3B1WHRWUExTVWg1SFU2WlZGbWU3OUt5NE1hM1JHWkhUT3h4UEhL?=
 =?utf-8?B?SWg4d2RYY2ZyOFRoN0NiWDU5bHltMjN5dUN1b3JSL0R3YjNFOG1lOVpOQTF0?=
 =?utf-8?B?cjFWYlk0Nk42RUs1dDYyaGtjWG44TTFGV3ZvSUZRYTN4cHBWQXVCWTJlSnRO?=
 =?utf-8?B?OWtUZjlIZ1BqeFV1ZDVKK0F0Z3ovb3B2dDlXWU84TldxdVVpWHA0a3plNGwv?=
 =?utf-8?B?ODlmK0I1USsvVlhRb0U5SUhQTXpOVTZIUDUxSC9UNWxFMms1b1hpYWY0WUNE?=
 =?utf-8?B?UlFFZTZjbE90aFh4MElwQm9ReDVSMzJqTTBWVk1yRmlWb21zYnYxcHNDL2Na?=
 =?utf-8?B?YVcyRTBvNFdHcVJFdmRERXlQUUlVRzZYc0RCQUw5V2RiR1UxK0xSNTRyMzYr?=
 =?utf-8?B?Q2RUTW8vam92T25ReHBMWURSTHZyY1JXUzZqSGJJWnFnTnc1Q3dpY2JvMzNB?=
 =?utf-8?B?S3Bab3Bod0duOG9UTWN5UkZBbGRpZ3czajAzY2tuTm1WS0N0YXF3akxzZ01R?=
 =?utf-8?B?cVZId0tsWEpxcWprOGJIWmp2a3A5ZU5LUlFMUzdZNlU4YXRUd0djaTFCM0xR?=
 =?utf-8?B?UHozRWFFOVlNcnFXSVl1WVRybjJtZjNEU1hGa01JRWgyZCt3ZzFONTV0aU9Z?=
 =?utf-8?B?cFpGZVp0dzU0bzJnMi8wTnlQbm9yS3NwcmFuS0hWYTllRUR6RmpFWFBkM081?=
 =?utf-8?B?TUZEQW9qNjZuTTZacVRoMjhaSzRIOTRuNHVFMjlEdnZ0eGpNZ1dJUmhHaDVE?=
 =?utf-8?B?TzR5eWlReGV6QkF5VXN4MEhYRTA2RzJXRVpFd0pyUDJMWnZsU2RHaVp4SGpM?=
 =?utf-8?B?SWVwZXFBQzFkY01Odk9hVkFqRXAvQ2RvUmhxRTBucFZjWjRMOXBLRVRyOUd1?=
 =?utf-8?B?OXYwWFVpSUVMalpLK1JneXAxMUlhTkJwaUVsbmdhSVdXOXVZb2JQV1dOcWJx?=
 =?utf-8?B?UDFFOFNZOHNkdk4wOWpzeExSMzdPT1pTS0ZSZ2hZY0tqSm9aU3g3cGYrZFYz?=
 =?utf-8?B?ODJpMWxJSTd6S21SVTQyZXlvUkkyRjlZbVNlR2RZY3JlRnJLc09qL3RjT0o0?=
 =?utf-8?B?bUFXYWlhaVVZd2VGZnNOdW9qWW1IN1dDNUhhN0FHVHcwTVBwTHkweG0vbDZ4?=
 =?utf-8?B?cTF4bVJZUnA2T1ZRN1ZORDBaL1N6R3hMdjFsL3RLYUxGenNwNjlVZ3Y0WGRR?=
 =?utf-8?B?QksySVNGSHpjWk1FS25kSUQwV21BNnU3bmdjdUFXeDdNQVlIR3NaMjQzVzc1?=
 =?utf-8?B?SUo2MmJFMHdWMDBLK2pwMTR0OUZXdE4zYWUvcHhoQmlocitjdEU1UWkvaE1m?=
 =?utf-8?B?RnFxVmo2VlNyK2kxNHBvS1IrYVBmSnU0KzBua2xaTzNlR3lLWnk3K3hzSWU1?=
 =?utf-8?B?V1Ewb1lIUEFyZHFCRmdYMWFrajk1NWhMeTdBYnZHbzhRc2d6VlBtSHRIeFBT?=
 =?utf-8?B?NXZSS1hZcEwwOEpncHlldlRBUUVCQlhZL1ZHTmVBTDRRK3h0NEpYU1diSjZC?=
 =?utf-8?B?N2dLOWxDdzRlZUN4YWNIZHlQWThHTXRPNWN4L2ZVUUNuVXZqRlBNQlJJb2xp?=
 =?utf-8?B?eEE4aXFnV1RYemtiZXowb0FOVGpUaWtLckpDVllPVzVRS2JMYjJxNlRCRGNq?=
 =?utf-8?B?MHhYcVJnbGNCSk5FZ1R3YVZuQ1JoQVBqTVlIWkFpTGdvSmtZVTU4WEY2TjBX?=
 =?utf-8?B?Y3F3L3IvN21tOGlNM08vdzZhcDdpNlFXQUNwWXFuVTluMDUxUGxocEdEOHkv?=
 =?utf-8?B?OW9ORWxqWjB5R2FsNlprRVNQYzlLMEdlbW0ybEp4QWttaGcvVExzZWNIL2Iw?=
 =?utf-8?Q?aAuo=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dc1125-d2ba-4c2c-8d76-08dd3cb5d2bd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 20:29:38.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UAQnnbrld6dHv9K0NxxwxunAArLBNesStkq1URu+7ASbOS08WLXWL2IbF2h9REL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7216

On 1/24/2025 9:11 AM, Jeff Layton wrote:
> On Fri, 2025-01-24 at 09:00 -0500, J. Bruce Fields wrote:
>> On Thu, Jan 23, 2025 at 06:20:08PM -0500, Jeff Layton wrote:
>>> On Thu, 2025-01-23 at 17:18 -0500, Chuck Lever wrote:
>>>> On 1/23/25 3:25 PM, Jeff Layton wrote:
>>>>> RFC8881, 15.1.1.3 says this about NFS4ERR_DELAY:
>>>>>
>>>>> "For any of a number of reasons, the replier could not process this
>>>>>    operation in what was deemed a reasonable time. The client should wait
>>>>>    and then try the request with a new slot and sequence value."
>>>>
>>>> A little farther down, Section 15.1.1.3 says this:
>>>>
>>>> "If NFS4ERR_DELAY is returned on a SEQUENCE operation, the request is
>>>>    retried in full with the SEQUENCE operation containing the same slot
>>>>    and sequence values."
>>>>
>>>> And:
>>>>
>>>> "If NFS4ERR_DELAY is returned on an operation other than the first in
>>>>    the request, the request when retried MUST contain a SEQUENCE operation
>>>>    that is different than the original one, with either the slot ID or the
>>>>    sequence value different from that in the original request."
>>>>
>>>> My impression is that the slot needs to be held and used again only if
>>>> the server responded with NFS4ERR_DELAY on the SEQUENCE operation. If
>>>> the NFS4ERR_DELAY was the status of the 2nd or later operation in the
>>>> COMPOUND, then yes, a different slot, or the same slot with a bumped
>>>> sequence number, must be used.
>>>>
>>>> The current code in nfsd4_cb_sequence_done() appears to be correct in
>>>> this regard.
>>>>
>>>
>>> Ok! I stand corrected. We should be able to just drop this patch, but
>>> some of the later patches may need some trivial merge conflicts fixed
>>> up.
>>>
>>> Any idea why SEQUENCE is different in this regard?
>>
>> Isn't DELAY on SEQUENCE an indication that the operation is still in
>> progress?  The difference between retrying the same slot or not is
>> whether you're asking the server again for the result of the previous
>> operation, or whether you're asking it to perform a new one.
>>
>> If you get DELAY on a later op and then keep retrying with the same
>> seqid/slot then I'd expect you to get stuck in an infinite loop getting
>> a DELAY response out of the reply cache.
>>
> 
> Hi Bruce!
> 
> That may be the case. From RFC8881, section 2.10.6.2:
> 
> "A retry might be sent while the original request is still in progress
> on the replier. The replier SHOULD deal with the issue by returning
> NFS4ERR_DELAY as the reply to SEQUENCE or CB_SEQUENCE operation, but
> implementations MAY return NFS4ERR_MISORDERED. Since errors from
> SEQUENCE and CB_SEQUENCE are never recorded in the reply cache, this
> approach allows the results of the execution of the original request to
> be properly recorded in the reply cache (assuming that the requester
> specified the reply to be cached)."

It's true, but note that the NFS4ERR_DELAY response is a SHOULD, so it's
not the complete picture. It seems rude to return MISORDERED as suggested,
but it's just as possible that the server may not respond at all, and
simply wait for the in-progress operation to complete. We certainly
can't count on all servers to do the same thing.

Tom.

>>> This rule seems a
>>> bit arbitrary. If the response is NFS4ERR_DELAY, then why would it
>>> matter which slot you use when retransmitting? The responder is just
>>> saying "go away and come back later".
>>>
>>> What if the responder repeatedly returns NFS4ERR_DELAY (maybe because
>>> it's under resource pressure), and also shrinks the slot table in the
>>> meantime? It seems like that might put the requestor in an untenable
>>> position.
>>>
>>> Maybe we should lobby to get this changed in the spec?
>>>
>>>>
>>>>> This is CB_SEQUENCE, but I believe the same rule applies. Release the
>>>>> slot before submitting the delayed RPC.
>>>>>
>>>>> Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>> ---
>>>>>    fs/nfsd/nfs4callback.c | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>> index bfc9de1fcb67b4f05ed2f7a28038cd8290809c17..c26ccb9485b95499fc908833a384d741e966a8db 100644
>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>> @@ -1392,6 +1392,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>>>    		goto need_restart;
>>>>>    	case -NFS4ERR_DELAY:
>>>>>    		cb->cb_seq_status = 1;
>>>>> +		nfsd41_cb_release_slot(cb);
>>>>>    		if (!rpc_restart_call(task))
>>>>>    			goto out;
>>>>>    
>>>>>
>>>>
>>>>
>>>
>>> -- 
>>> Jeff Layton <jlayton@kernel.org>
> 


