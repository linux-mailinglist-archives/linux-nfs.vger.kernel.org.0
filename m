Return-Path: <linux-nfs+bounces-7465-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFD79B040E
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 15:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771FAB21C73
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 13:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD0521219F;
	Fri, 25 Oct 2024 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="UwEJvT7W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2131.outbound.protection.outlook.com [40.107.96.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F40F70816
	for <linux-nfs@vger.kernel.org>; Fri, 25 Oct 2024 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863114; cv=fail; b=YsnWEKZP9D48l+KOTbqIZD39eCiP9smLUwjQxWUWHxKbZ/nD3H6MazYz8N8VF6Bj8pBtwQxSudKhPe4jrKf+8KxfJojk2IiEorDruzYn3/uPdzmI9ebBu5PiQOwhUx17CfngeJijq4vh3Nftr17eyNPLk4E4OC7xirOQ76Fhuqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863114; c=relaxed/simple;
	bh=iGbbrbK157kElZpNMvZglpm5pwcO9gWbVY+H5YOwTlI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AaDIhlZNTmHAXn1LE8Qt2UN3WGy3rbjfL0C+SceMqmU8KVs9aehJ/iYrdl07SpQzGTNnL7XaoxUiXAvSQytvUd6pTOYzvfYPPar9aULMrl7zsSwJcyNEabKeMqnktxH26Tn4vhsk1nCdz61FG/b5LG/TdRbJHYKYqXbv8JuaQp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=UwEJvT7W; arc=fail smtp.client-ip=40.107.96.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Svmq8d8lHIVscsKmNymdBo6AZz03yPASp4PJo039Mf6YHz/2i/H4478jIIdaUXCrmO339FM2zWwuhqJ71g4G8jQM5NVKZL4p1Avx00EzXoV5LHyvKOJ/olFFvgLiTN2gcNlKMbC1F05hh7bJMQDozneS8Hq25Fz5TrEhBHDwMJsxTzw0JGNUM6yECao8xPLIiqaC3l7A8OAaNS4V38crfTbuHc+4ujgnDnIwpdTvBXwEIzXOFEUATqf/O0AENWy6f8+vlm0cMONx7/EzjRm0XbNl0zHyY87OZQKnPOsuepEenTeFU2dP3U8+AJgT4P5aa+FxLdHGQrNFNwzRDTNU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGbbrbK157kElZpNMvZglpm5pwcO9gWbVY+H5YOwTlI=;
 b=gjJ5Zraa+pDGgQ2MGRnvqbz01BHoTSbYIkoSL//Ef3CZ6L3xDpkr7bEHgulSkYMhy+bUKwP4llMpBhTNF2yAbwIGe1e1MQ8F7S006b/QvqoR8nDrCVCHyKn2HHGTFzQYxCw1NeexyqSWjWQKWqURax4BC/WXxtNqk4PS9nQ3uGdQlGsamMvKRgi8OULQKv86VU93s6UyjAmwkygEwKFHUO9mc416/Abrdwh0TLz8kJUviOQwHm5qIxWzTRjyl3aY7ZgAtKZx5NRSG9Z95K8TYKzH8K64gVEPXUN5iDt/tPN5EpymsPBuNrs1KLS0zjpNjdBe9tH/8usJ6zKdbrZlzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGbbrbK157kElZpNMvZglpm5pwcO9gWbVY+H5YOwTlI=;
 b=UwEJvT7WvtplnqeWr7Vzc2OtT8kXszIfnUj1gMgHvYuPNWTK3E9PFYKzXeWZsBo+VIYNjkyGR8usKcXzVfJ3UIIbLg5BpFKCnAQIXYnB9DaNVsXw6EMhePrsjIHUFNbcgWet4yXnGnQFaz8e/o5NO+weivRQ21+VYUeLF3SAph0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by LV3PR13MB6916.namprd13.prod.outlook.com (2603:10b6:408:278::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 13:31:48 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:31:47 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "neilb@suse.de" <neilb@suse.de>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
CC: "anna@kernel.org" <anna@kernel.org>, "snitzer@kernel.org"
	<snitzer@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd/filecache: add nfsd_file_acquire_gc_cached
Thread-Topic: [PATCH] nfsd/filecache: add nfsd_file_acquire_gc_cached
Thread-Index: AQHbJkZOLjPXiFa6pkKTOu3mHlwd0rKWx6wAgAClV4CAAArnAA==
Date: Fri, 25 Oct 2024 13:31:47 +0000
Message-ID: <2ca444702fe535a04adb26df41a9ae2b904fc260.camel@hammerspace.com>
References: <20241024185526.76146-1-snitzer@kernel.org>
	 <172982525650.81717.5861053414648479623@noble.neil.brown.name>
	 <4EDD901C-1CB9-4F99-A35C-3FCBE6F115B6@oracle.com>
In-Reply-To: <4EDD901C-1CB9-4F99-A35C-3FCBE6F115B6@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|LV3PR13MB6916:EE_
x-ms-office365-filtering-correlation-id: 97c93db7-61e0-4179-c452-08dcf4f9603d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WmJ5KzIxdkhHNEcyWnJ4L0dkNGV1YVZ0MlN2N09QeGNsdGl0d2RmV0JvbDFx?=
 =?utf-8?B?U2JQT0RLcEhvZVZ4TXVPbk5RalY4MFl4ay9JVlcyK2RvSnFCd3JTNXBvMEl0?=
 =?utf-8?B?a00zVnY5WVVQWXgrc000dDArMVZXajZNVzdQbnAwQllyMXJENTJTM1Q0QzZH?=
 =?utf-8?B?SjdmM3o4ZWRONFlQaFFRcUNEdnBVTk1GdktsSElyUFMvSkYrNks3d2ZoQkp4?=
 =?utf-8?B?eWlITkdxQS83WklyTUZHL1lON0FubG9FYWgzTkxKeTNiMTF3ZGViVXQ2QTdp?=
 =?utf-8?B?cENxR3RhSjZQME9HZ2kxbk5GdkRFWXFkUjN3bDR4dDQ4MmEySkxteVFrTjRI?=
 =?utf-8?B?dGxiQ1h3MlJsci84K2lLekJDZng2ZDNKNE5ITWJLNThlcmVnRWd1elQvUW9v?=
 =?utf-8?B?bkZlbkEzRVZHZ3dOYVVkZ3lpSkI3dFpjSVpmUE0rWmVJTjZMNHlLNTlFenJ1?=
 =?utf-8?B?ZVFPRHk2eFU2N21oZUZ5ZFltOEVZQ1RPQ0ZrMkZuNTZXVmtqT3VDY296bXBI?=
 =?utf-8?B?ZkpRSXM0ZTBZc3N6MGtybWNDTjlhWlZKSnBUT0pJSWZrb3BPNzc3bXhnUElJ?=
 =?utf-8?B?UVFUVXBKQ2JDYkUrSXNSZVJNVnBJMys1WHpOY1M5OGgzdzViY3p4Q3dNVXps?=
 =?utf-8?B?allPT3RDZ2VlUlA0RVBzQWdLeTloR2xBUEozSWZIUXNyMkZXVEVUazhpWjRU?=
 =?utf-8?B?WENKMXpYZmRRK1NZaVI3VFZtcWp0d0VJMW95bVBTQmZQdHJVdGR1QTlCakQ2?=
 =?utf-8?B?VmYzT21FTllvOWVZbTdmKzlMMnNmNEhiOTdsUVNjcWNRY3FpK1lJaWpXYmVK?=
 =?utf-8?B?bU5ITUVldWVBR3dnREJPc29QcmdnVmhlb3RlREFKMGN3Q3Q4L2NSWEtpRzN6?=
 =?utf-8?B?QUJ6QUY2b2QvSk51djBMYkk5R2tUWnFjcXIzYm1nRWVza2VRQ2QyT3ZORWJ6?=
 =?utf-8?B?VGdaVmN4S2xkU2w1K2NKbkdxTXBpd3pDTVcwREcwZWl1UWNGZk5YT0pIRjFX?=
 =?utf-8?B?OGRIT2Uwd2JvNThhbThhclBDWnJsVEVpRnAvdnMwaVQ0RHpzSHJRNXpIVkxv?=
 =?utf-8?B?cXlrSDJMY3dSZmxQdkNBZVBLZHpManB6NGl6MEw4eHAvYVdxU0ZKcjMxRGFr?=
 =?utf-8?B?RzUydDFrTThEV3p3TU0rMjhySTNlLzdQbnRxRmozTExLUGQwUkptZ2V6Lzlz?=
 =?utf-8?B?ZUZkMWQyVS83YWx2UGp0V2dKdFZrb3gwUTVQY0REKzBHV1lmRGVHdngxcHlq?=
 =?utf-8?B?Ukh2WnNmWnh0cHVHVUtqSFZwUWlmdFlDUnQ4UG5QVU1EMGtsOE1YczFnbFha?=
 =?utf-8?B?Nk4xZlhsMktuc0dpZjVENnVzK210LzF0WU40NlNVdHp4eTdYbHA4NG5uQ0V6?=
 =?utf-8?B?Zk13WHphcHRPU01vT3czb1NWdzRVamdPVVZmSUM0RFN4K045R3Bmb1NvSTcz?=
 =?utf-8?B?enJ1WGdBRXVWcWZ4dE5FeHBCSVc5TUp2aDRMZDJSQk9RMFRXN0I5Z1hRdXdE?=
 =?utf-8?B?UXRZcUs5eGN2RTd5R2F3MHo1VWhoSjBEaWlnTklsR3h6eWhKNkZyNjBsZTls?=
 =?utf-8?B?S3I4cXA5UUwxM1VGS3I5QWJOeFNta2FJTUtpWmFxQWZ4VVVNWGdMaEtZSHpp?=
 =?utf-8?B?cy9kUDNwSXpGZVo0UDI1YzdiQTZZclpPSFFEVUhwbE1vNHVUbjA3SnNET2Vw?=
 =?utf-8?B?RjJGYVlOVTRmakZCdkE4N0IxSlVEQzVOSFg0dXFnSXV5YXVvbzNFaUVTek5P?=
 =?utf-8?B?a0tOajh3U1pQNzNvT0t3VHJOT1phVDJVRXY4aVZLWDNwcjV6bDh2Um9RWkVH?=
 =?utf-8?Q?TnhJd6xUtQtrJDPKE3nc0O0o2yxvX5r3hd38E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2NiZGNwWHV1c3Jlb0N3VitrNlhxcWNYM0R6RlRmbHJCd1ZNbWV3V21RTEZp?=
 =?utf-8?B?N3BMcGRnNlFiVXR6L2VhUkdWL2RnNXV2cXhVK3ZQVTRjZFpTbytKUWdLRTBF?=
 =?utf-8?B?VzdJVUNDSnNZSGxPTE1NZ2dyWlF6dmlYYWd5NjVQR3lINDA5OXExOW15KzdJ?=
 =?utf-8?B?NTBuMzkyNlVuS3VMczR2Q0FaTzVLTW1udzJsNzdNcGt4dGJFc1FkSXRLaWhS?=
 =?utf-8?B?ZUNyZVhITzU2R2lKdldkN1pkL3k1QU91U0l3WnY3WTdRTk4vbzJuc1lGN3ds?=
 =?utf-8?B?TG92YTZoWWJndElLQ3lTQVRBZXFiRVNISndRNEsyUFBiVXppbjVBd1pHSXdB?=
 =?utf-8?B?ZENVOVFrdWNyQ05HNkRjSC8waVNvdm84T1JnNm1XdHQwSWM0MTR4amQ1NlhB?=
 =?utf-8?B?bmpZNm5Gd1VGSkFnZGhMbGRUMU5BYVNaZVU4T2FMdHFjQ1hXTG5SR2xBeVh1?=
 =?utf-8?B?R1RHWXhLVERsVmd1andTUnhpUkprM2pkYjQ5UXpHQTZwVklqTkVBL0Ntc05I?=
 =?utf-8?B?em9XVlhjM2pYL2FsOWNFK01ZVTEwL2NmUXhXOEpnZEpHVS9SVEdSTEpOcDNh?=
 =?utf-8?B?dFVyYkF1SkNQZDBabUsxMlhvVG85UkROM010aWc5VHRHNElBNEllUjlRTzNz?=
 =?utf-8?B?QjNKV0dPRnJXTnNFLzk2L1UvdHBwTm5qbkJLVnY3RUszZ2FYdGx2SXdjSW5S?=
 =?utf-8?B?eDhncXJOdTVNMkszM0llbHpLa0Z5Q1RjZ0oxVFQvK2RGM0Nib2s3QktUYkRE?=
 =?utf-8?B?UEdPSk5rTGlYREpFdXdGVlhpczNWS0JtNXJscmw0b2hmemhqSldOQzl5SjIz?=
 =?utf-8?B?ak82YmQ0S29TV1dFSzJ5LzhyVEkvTjlXWC9BMkxmcVcrckNXenIydmUwVUdl?=
 =?utf-8?B?Zit3aHY0Sm4wSnpsSGF5ZFZwbG9FYms3cjhzSVh3QjVqVGVUZVZGSkRLdTd4?=
 =?utf-8?B?eEViSElQZnJLeFQwV2xzNlJSOWxZOEorS3dEYWNYd0J4ampzMGdtb2lQZTMy?=
 =?utf-8?B?WVRXNld5SDlOSmhtNGVpRTNkamJwRUxGbFh1SDlJSjZacUhnSGE0a1VXTXJF?=
 =?utf-8?B?dFA4M0IzTGlieW0xYnBLZnJoc1J3aFJGM1FISFJrUzhDM1ZuSkxvMVJDZEhj?=
 =?utf-8?B?SkJ1RmVxNWtYS3BrUjNocUdBei9ZRWg2OXlKcWI5L0VsL2lZYWMwd3o3Umpx?=
 =?utf-8?B?UWZadlJES29oUlN6OVlYWTV4KzhpdU1Kc2hDcHJFTmlhbElKdUd6WEpWWE1t?=
 =?utf-8?B?Wk1reGVrbXBOUitMRjQ4SE1Eak95ZmRlWU1haFpicDNsSi9PT2k0cXYyS0Ni?=
 =?utf-8?B?aDBCVk4yRWdLMlJiRnFMZkszdjhqa3ZEUEFGME9qUCtndDJvVWR5YldtYlJC?=
 =?utf-8?B?SHFaeXZhM2VIZVQ0U096elhaaklDRm5mRSt5RFVudGVIR1JPZkozNUJRQVhZ?=
 =?utf-8?B?NTV5MWloM0NicUNybHBpcmN4MWNqZ1BsWi9qdjRLd1NQdExmUGZRMFJ3VjJs?=
 =?utf-8?B?NHN6RnFCUlFqOWc1R0FUQWplQU5Rb1JCeFJEK0R2ZmlsekdLdkdWdGFraVFt?=
 =?utf-8?B?WjlPVVNlWDJ6eS9VWkZ1Q0U3Wm40QUJMd0U3TFZTa2o1UmNBUkdBUTMycHZt?=
 =?utf-8?B?U29zd2g5VlFNakloN3dXblpjQXEzNkpjQlNobjNYTFV2Z21EdkZJYUl0U0Y2?=
 =?utf-8?B?WUZPSWlJcHZNdUVpMk8rNllQdUwyTzljV0dFdmY0QS8xL0RCMUYyd0VaRzhY?=
 =?utf-8?B?VndOTGQvRFBzZWZIVVZlQjMvK0Y3Mk9zUTNLSG9MS1lqRE0xNGxOMEllSkgz?=
 =?utf-8?B?bndQb0VoU0hjTUE5TnNPVkNFQVQ2d2F5cGgwcEVnd0RBa0VyaUhQU0prb0Jj?=
 =?utf-8?B?b1NwSjFIMzNGdVFnOUtucnFpM1VkVmZGNk1pWmxBaHk3OU1hZEFtV1JVcXZH?=
 =?utf-8?B?bnYzUnFaVVVGRHlVUjhxSHdUWHlJQ0ZtVWZPcXZCTWdHOHpkUGgwN2J1eStI?=
 =?utf-8?B?dTR2TUJ1N056dlhkWWhWbkcrV2d3WkFVZGNCVU1vdlRIb0toZnRKeWlEUEUz?=
 =?utf-8?B?MHBINHp3OHRGUm1CZlEwVk1UR0VrZGdNMUEySDM3ZUhEZW5ncm5QTW9EbmpK?=
 =?utf-8?B?OE5RUVU0NXlNbVN4OVRVWTZ2WVp3QTZVMG1oRnhrM2RUZS92T1ZqVVVkRW5v?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9000AD4C18D6C409AD7BF62E519077D@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c93db7-61e0-4179-c452-08dcf4f9603d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 13:31:47.8170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9ITepc3UtnvTwRiqp63d8PNiR5HKaIbETjeMkMaFANbkv02HT5OzafsHfm/QAVLTZE5UIrUk6p0s7FfpmI0Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6916

T24gRnJpLCAyMDI0LTEwLTI1IGF0IDEyOjUyICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBPY3QgMjQsIDIwMjQsIGF0IDExOjAw4oCvUE0sIE5laWxCcm93biA8
bmVpbGJAc3VzZS5kZT4gd3JvdGU6DQo+ID4gDQo+ID4gSSdtIHdvbmRlcmluZyBhYm91dCB0aGUg
cmVxdWVzdCBmb3IgYSBnYXJiYWdlLWNvbGxlY3RlZCBuZnNkX2ZpbGUNCj4gPiB0aG91Z2guwqAg
Rm9yIE5GU3YzIHRoYXQgbWFrZXMgc2Vuc2UuwqAgRm9yIE5GU3Y0IHdlIHdvdWxkIGV4cGVjdCB0
aGUNCj4gPiBmaWxlDQo+ID4gdG8gYWxyZWFkeSBiZSBvcGVuIGFzIGEgbm9uLWdhcmJhZ2UtY29s
bGVjdGVkIG5mc2RfZmlsZSBhbmQgb3BlbmluZw0KPiA+IGl0DQo+ID4gYWdhaW4gc2VlbXMgd2Fz
dGVmdWwuwqAgVGhhdCBkb2Vzbid0IG5lZWQgdG8gYmUgZml4ZWQgZm9yIHRoaXMgcGF0Y2gNCj4g
PiBhbmQNCj4gPiBtYXliZSBkb2Vzbid0IG5lZWQgdG8gYmUgZml4ZWQgYXQgYWxsLCBidXQgaXQg
c2VlbWVkIHdvcnRoDQo+ID4gaGlnaGxpZ2h0aW5nLg0KPiANCj4gSSBkb24ndCB0aGluayB1c2lu
ZyBhIEdDJ2QgbmZzZF9maWxlIGZvciBMT0NBTElPIGlzIGEgYnVnLg0KPiANCj4gTkZTdjQgZ3Vh
cmFudGVlcyBhbiBPUEVOIHRvIHBpbiB0aGUgbmZzZF9maWxlLCBhbmQgYSBDTE9TRQ0KPiAob3Ig
bGVhc2UgZXhwaXJ5KSB0byByZWxlYXNlIGl0LiBUaGVyZSdzIG5vIGRlc2lyZSBmb3Igb3INCj4g
bmVlZCBmb3IgZ2FyYmFnZSBjb2xsZWN0aW9uLg0KPiANCj4gTkZTdjMgYW5kIExPQ0FMSU8gdXNl
IGVhY2ggbmZzZF9maWxlIGZvciB0aGUgbGlmZSBvZiBvbmUgSS9PDQo+IG9wZXJhdGlvbiwgYW5k
IHRoYXQgbmZzZF9maWxlIGlzIGNhY2hlZCBpbiB0aGUgZXhwZWN0YXRpb24NCj4gdGhhdCBhbm90
aGVyIEkvTyBvcGVyYXRpb24gb24gdGhlIHNhbWUgZmlsZSB3aWxsIGhhcHBlbiB3aXRoDQo+IGZy
ZXF1ZW50IHRlbXBvcmFybCBwcm94aW1pdHkuIEdhcmJhZ2UgY29sbGVjdGlvbiBpcyBuZWVkZWQN
Cj4gZm9yIGJvdGggY2FzZXMuDQo+IA0KDQpOby4gVGhlcmUgaXMgYSBodWdlIGRpZmZlcmVuY2Ug
YmV0d2VlbiB0aGUgdHdvLiBJbiB0aGUgY2FzZSBvZiBORlN2MywNCnRoZSBzZXJ2ZXIgaGFzIG5v
IGlkZWEgd2hldGhlciBvciBub3QgdGhlcmUgaXMgZnVydGhlciBuZWVkIGZvciB0aGUNCmZpbGUg
KHN0YXRlbGVzcyksIHdoZXJlYXMgaW4gdGhlIGxvY2FsaW8gY2FzZSwgdGhlIGNsaWVudCBpcyBh
YmxlIHRvDQp0ZWxsIGV4YWN0bHkgd2hlbiB0aGUgYXBwbGljYXRpb24gaG9sZHMgdGhlIGZpbGUg
b3BlbiBvciBub3QNCihzdGF0ZWZ1bCkuDQoNClRoZSBvbmx5IHJlYXNvbiBmb3IganVtcGluZyB0
aHJvdWdoIGFsbCB0aGVzZSBob29wcyBpbiB0aGUgY2FzZSBvZg0KbG9jYWxpbyBpcyB0aGUgJ3Vz
ZXIgbWF5IHdhbnQgdG8gdW5tb3VudCcgZXhjZXB0aW9uLg0KDQpJcyB0aGVyZSBhbnkgcmVhc29u
IHdoeSB3ZSBjb3VsZG4ndCBhZGQgYSBub3RpZmljYXRpb24gZm9yIHRoYXQsIHRvDQpnaXZlIGtu
ZnNkIHRoZSBvcHBvcnR1bml0eSB0byBjbGVhciBvdXQgYW55IG9wZW4gZmlsZSBzdGF0ZT8gVGhl
DQpjdXJyZW50IGFwcHJvYWNoIGFwcGVhcnMgdG8gYmUgZmxhdCBvdXQgb3B0aW1pc2luZyBmb3Ig
dGhlIGV4Y2VwdGlvbi4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=

