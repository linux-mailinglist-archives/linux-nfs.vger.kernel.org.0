Return-Path: <linux-nfs+bounces-3414-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC488D080C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 18:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE471F2259A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 16:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C4B17E90C;
	Mon, 27 May 2024 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="ZMUFf520"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2095.outbound.protection.outlook.com [40.107.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E162629C
	for <linux-nfs@vger.kernel.org>; Mon, 27 May 2024 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826466; cv=fail; b=SNeLGW8PU2ZNAF3PUs2z0dcuYDl8squbatlTFrouT4fd6aSM7pScpKTddrUX5zGWS8hfL4E17eSa27t7j0z8S0zj13hWMFYPmGaEyT8N/RieNsGvquhcBJjqA2qtpH/fiq9GilU3m5L6+ESkekDMtd+lbkDO1bqTsRDvfweVCc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826466; c=relaxed/simple;
	bh=lvlbocSslKCXsXKwVgC2Q6DjOWZ0BSfauDB6lXx7NjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GM7jhj0iNyj992BeowFWj385iWWxJ4s9klRE6Q3goUWVJ6Cz8xBUd7mZK1z/8rpsNJ4QB+aB5HL2J+qlOsDS8s5BKF0Whku7XHW2UTlxOwOtFNldqSt8h3rPwMlaRsgRp+vYqfF5JC4YSoEPqtD4WbUVL8HMVMJV5U3q0c/roBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=ZMUFf520; arc=fail smtp.client-ip=40.107.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+AftLGVO1CN1mU9WlqPgLFTDeE65v9xFEhsaYX8J0oOvl0sYWMkgR8d7Qnq6FA4PohgxVYkffz73l/BgeKLjm2W8hWpM7efnxxQSiZ4hoVAeESPvzEkhiUjJI74LBFhTaDY1f7F44FA99D5XTlf19f85bCxMJlR3u3AY2FN3dpwd3+GQXvlzxLhGuz6oOYAKTkM4TRZkV+2i37bXmRXJtPN1nOh1a08/3mvlrySn2IDBYqmat6U29mQWNxCqUCFnJm895gzLy41HxED/hHhM0amJ85wA3PdjrZXrGtObgsnVsDX0uIu0p37WWTPhrY1Weua+YVBrQeMK+MQl1v8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvlbocSslKCXsXKwVgC2Q6DjOWZ0BSfauDB6lXx7NjY=;
 b=gljx71wGGcms7iSaiFbo4DYuRxbfAfyqZxub2DUipx4DsHA84gZcdIXgOlg3yQ5fHPCdCXkGvoZXE2bPUMp2KUmofuJJHYt4I21wYo8iT0iVRdBzAd13TILYAuKecQDT5YjkUCV26uFNk0hnpuYmLzF2zqvFjiCtjNNnz52DZ8/EzERQtcmZ2mFoXEdlHE2izh5jh4+WlkL9Cy75uE4m0xBMzI2mNSXjfVDRurhAZZBu1r/2g5i70TmMZ1UPCe9bPoPYtq7Wg72aTRySm204l4+F7QwdcvIMqyGhmHREQim2bQAbR8K4Qq7JEhKg0N66ZTd8LXztrueJ3kq4BKu4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvlbocSslKCXsXKwVgC2Q6DjOWZ0BSfauDB6lXx7NjY=;
 b=ZMUFf5209DlZUx8BI913sbCRt+E/VpUhAAeCsFCIZdd3yd0UQ9+ZKgGYkHxR0q2dmquMtKqxj+th0ueszam8T+cOh9i+nYxF+TSlzOpk7n+3aiBKYH3Ph7dvQT8O29IP6mA8e/TCTMfJrvMKDdG/vxMB/zzOYC4MlPIyZgLlH/w=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 LV8PR13MB6557.namprd13.prod.outlook.com (2603:10b6:408:229::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16; Mon, 27 May
 2024 16:14:20 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%6]) with mapi id 15.20.7633.001; Mon, 27 May 2024
 16:14:20 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "neilb@suse.de" <neilb@suse.de>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"richard+debian+bugreport@kojedz.in" <richard+debian+bugreport@kojedz.in>,
	"1071501@bugs.debian.org" <1071501@bugs.debian.org>
Subject: Re: [PATCH] NFS: add barriers when testing for NFS_FSDATA_BLOCKED
Thread-Topic: [PATCH] NFS: add barriers when testing for NFS_FSDATA_BLOCKED
Thread-Index: AQHar+KTHwwwwsDV00+el7pgbq3jKbGrQhWA
Date: Mon, 27 May 2024 16:14:20 +0000
Message-ID: <a14f4bc37abb28c20cac7de3722f4b86c1fd28fb.camel@hammerspace.com>
References: <171677905033.27191.7405469009187788343@noble.neil.brown.name>
In-Reply-To: <171677905033.27191.7405469009187788343@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|LV8PR13MB6557:EE_
x-ms-office365-filtering-correlation-id: 0b7b2623-a527-4a42-888b-08dc7e6810c8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?UU1SQlRkWDg2SkZNRTRJQkNRL3BOeEozVWVZbU95aVlWdmVOdVppM0pxcjR3?=
 =?utf-8?B?NmxtYWV6NDkyTXpFRyszVHZuZUhlRUNaakRqN3NLaDdqckpVSml3aGY3RitE?=
 =?utf-8?B?NkE5ZlU4QzdrZlArVUFTaEM2ZE9RZmM4NW9LVVdGcE9IcGc3N2NJYVhuTEtE?=
 =?utf-8?B?ZE42LzFVTUd3d3dxNi9KK0VVN29STWN4SUl1RmpXZnZkWGxGcGhWNTRKeDd1?=
 =?utf-8?B?S0JhWFZncVZBRjM4VTlMbTBVTWd6YW1FQ2p2YVcrUkgxMVJQK1NWdStWVHM4?=
 =?utf-8?B?ekQvYnRRbDI5aUFTN3pEd2FpeUdqUGN4dVJMVU1tYnYzcUJXNkJqdzd6Z2lw?=
 =?utf-8?B?dDBpbkZJdzltQ3R5YzBSQlcwYW5na0JJblFuQlNzdE1JQVNRZGNkQnh0MllC?=
 =?utf-8?B?QjVHTjJoS0lpMkJPVTFqWU85RGZaUWNobWtXZlR0N1BHL1kyampNck9GNkNX?=
 =?utf-8?B?ZG9FWFZhQ1phUVNVVG0ra054aVUzUkdyZnEybUtGMzAvRkM0S2FJSXRsVVll?=
 =?utf-8?B?TjVtZERVK3BHalhnOVRzcDZtbUhPb0xuS1gwNWRGYVlVcEdJanM3THdsSC9H?=
 =?utf-8?B?T0t4V0l6MEZrU2U5MFUzTDFIaXZrRzMzanJzQTVZYkxJRVpuNWM1WWRGWFZk?=
 =?utf-8?B?QWRZREk1UkszSFdlcWNQOElPR0xpZTRGZ2RFZkxNUGJQZW1mdXM5ZjJzRWkw?=
 =?utf-8?B?VUlEeWVpVGNOOW9NVmh4Y2FnKzBCSTdETEloZ21KeVNuVDZ5SFB6TVlMUTVw?=
 =?utf-8?B?U1hsZWgwNXdPdm5ESDIvck1ES3krTVM1V01Xclh1ODVmc243NEsyMUsrQU1p?=
 =?utf-8?B?ODVZcytQcXRFTFZPeXpSNTdqMnFQOHJPT2FYUE9oV3dKdk1VNGV2OTROdkl1?=
 =?utf-8?B?cnprUlY4clV4U01OdzV3Q3JyUGppcEFYV0x0OGZGSjhyUjFMSTV6am11YkVW?=
 =?utf-8?B?aFhLQ3hXVys3ZGhZeXBLM3VoRFYyKzAwQ3lVM2ovS29YQU9lNlhrTXJsWWYr?=
 =?utf-8?B?RmhoQU9PNW1SK3ZzNVhWd2pIMDR2M0RsK0NIZ3Vqa3RKZkRIamNNTUFYRWw5?=
 =?utf-8?B?Vk9VRVQ3aXc1ZkdlVmhrVmJmdGYzeFhpUktRR242YUo0NGNMRldlTDFFRXht?=
 =?utf-8?B?WVI4UXhaVjUrN1ZWa3RzUzV2SDQ4OG4xeW9ITzJ0WWh3L3dsakpZcUVwRGJU?=
 =?utf-8?B?dG9xV3JOK3YwMGI2NFE5RWlNNEJEbExSUEkyOXNXYldDUXpsVFY0aTE3djg3?=
 =?utf-8?B?dDJHUWl1V3IreGQ2cU1SeTN4TGlGNmRxN2I5ZmovdmxtTjhFZlpTS2x6aWRI?=
 =?utf-8?B?WXUyTWFvZHp4TWdBbk5sSWhLMmJnajc0dnFnYlF3UnYvR3pGZGhta2dXNXB6?=
 =?utf-8?B?NFJGcGg5RTM5dG45M21ZTlFWbHpxWEViOE43TU9MNTV2QnFybG92Yk0xMDI3?=
 =?utf-8?B?RnFqd2hkOFpxTjZZNWRzaldPT1B1c3ZMelhjUnE4NGFYTE85Y002ck5aOXBh?=
 =?utf-8?B?cFNXbkNBMnJ0ZEdUSlcxR295emlOYjFmWWhUTitqeWtNRUtuOHdlY2FvTmMr?=
 =?utf-8?B?MW8rUTR6MDVURnFncUxhSEoxakw1QlcrcGR2UEhYVFNIa0dUa1YrbzRiRHJU?=
 =?utf-8?B?RlpDazY1WlhsNE1hWkZVbnBvWXJqalpoTFd6RCtNT1EweFl0UVExSE9OVVQ3?=
 =?utf-8?B?eGYzWVRvVmtUN0ttcWxJNlZWNmJ4VlBHUExVR3UrK3czZUVVRGpUbFFRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zm8rTDlHNTJNTWI1a293MTYvbkg5NGY0Nk5jK3g3d25nMWxlZS81b1RPb0NU?=
 =?utf-8?B?NVMrY2ZUd2xQZktTZjM1UWUwcnN0OXo2dXhBN0kxV1UxQy90djRGNXZ5YThK?=
 =?utf-8?B?d1RmVlZVVVYvL2JWbkxHU0JtclQ3QnRoS1dIc2RZbjR6WHBCZXRPRXR2RUh4?=
 =?utf-8?B?Zk1XOGMxK2NOSHNGMDltYjBXNm5lYmZXcXB5K08zb0dpS1RHQ21GRUdENXlZ?=
 =?utf-8?B?Q0hrUC8vKzlYY25hRTZLNUtaTHFpSi9zWHYzd05HMVBrUXRLYTU4QkhKbldL?=
 =?utf-8?B?dHBmTHZ2ZUxjZjRJWHZKdk9Yd3RwekFoVEttbDRUR0JGVXE4YnVNdENjS29G?=
 =?utf-8?B?M09uTEVNY1BHNUFPOFdQY2lkTUN2NkpML3hSZVcrdUd4ZmNtMnFFZE5qQ3Nz?=
 =?utf-8?B?aEp3M3BaM2l1dkZGVzJiT2o5TkF5WUhwaER0OEt6ekZYRzZhTEcwSVMwMllN?=
 =?utf-8?B?RGxCa1JtdnE4ME9VYlhQNExNaWZzQ3lNUzl1Sm00aWsvSnk5R3hUM1RzNWtt?=
 =?utf-8?B?SUZjU09ieFZNZ1VwYnd2VmRvRDlhZmtBbktGU28rVWlkT2svLytDekdUOFkv?=
 =?utf-8?B?dzVpSU41aDNzbzdVTFNkMFhkdjhtUHJlYkN0bkZJNzZhL2RKS2RNNlVlTmlj?=
 =?utf-8?B?UHl0a01haXZ2NnBldmdrNW1nNERiK3F3YStpdGR4TXN6eHV6MzJsQzZoYUJm?=
 =?utf-8?B?QWpFSGl4N3J6Wmh3WEJFaGNaWWloNFJMbmdEK1gvZUw1RFNKQXJYM0JXWjFG?=
 =?utf-8?B?dnVFMy82R1F6QnZ0R2tMVndjWUNqaHVUTkNtcy8rNnNyTE1ETmxaVk12UDZy?=
 =?utf-8?B?TExkMGVSeFpIN2hkdy96UmtRSURMRmF2KzVWbm5PdDZVREVtemt0bUdMNUE0?=
 =?utf-8?B?WGdaRmFKVjVSK01ickxBV202eUFEY0NoL2ZKbi94MVFpRHFRQk1ENzJyaDBE?=
 =?utf-8?B?TkNLY1E3L3YrUmw4VTB4UlNMZmVXYWJDYWxQMnl5WnFtRko5azZaSy91cTZw?=
 =?utf-8?B?VjhVbTl2S3VzMU1SOUhsNWdJR0RIclRpa3JkWFNZU1NYTGRJYmVJT3hqWmV5?=
 =?utf-8?B?Wk9ySU1uellUYjZmZjlCcE1qOHMzQ0Nya1JsaEpnczNGcm1vNjJCbjNZTVk0?=
 =?utf-8?B?ZTRZdWFXZis5eHduUGxzWXB6Z0NIc3ZuangvcnM3WUtUK2xpc1hFZDd0RCsz?=
 =?utf-8?B?SEFBeXg3NXh6REhKQXlPbnhjd2l0cit1Q3NaN3RRdC9rUU5EVTZMMk1rR2Nx?=
 =?utf-8?B?Q09GT25zbGExWUh6MWIzQWpFOWc5WXF1cDRua25FRmJ5NStCVmtRY1BhVmUz?=
 =?utf-8?B?T1phdzkwdnd6ZlZxYTVGZjd1K2R6Y0JpUUsrOW5QZmgvTWFNT2M3YTdQQ1B3?=
 =?utf-8?B?S1laUWlBb2liZHJQdzJxa0JxT2lOU3B0d0lrYXFPVHBLbmtmUFEyM0pqTVNm?=
 =?utf-8?B?bHRSRUF6MGpacXI5aXBTT01PcW1XVXJmNngzWUJNVDMxYjMrek5IRFFwV1Jv?=
 =?utf-8?B?cHlkVTU0eXM5dnpya0RJa2VtYkJ0Z055ZXlra1pCVFFNdEQ4Sm5iYUt6WkRQ?=
 =?utf-8?B?SjBZbHJYT3ZNNy9GOENUalB3OWpvR0R1aGZ3MmoxWm1LbitaSVFFT1MyRS9u?=
 =?utf-8?B?SnhJb29aUFpIdWxaTjdyVjh1ZXNyYnNuc1A5US9LSkhxRC9yMjRWaFJxaEpp?=
 =?utf-8?B?VlBoRWlQZCtpaUdUU05mVDRVUVdlQlFnN1ZLeVRvVjBjb3BMMDNSaTVvbUt0?=
 =?utf-8?B?UTZybmpybjg2ZjdQWDcyMlppMlJ1SmlpZjlRN0Z3dFI4R09KWXZUOWJYVTIy?=
 =?utf-8?B?YjlNaW5MdUlsKzYxTDJUK2Z1YnFrblBVOE1oVDdrVWlMK0t1bFgxVDBrcW9t?=
 =?utf-8?B?d2QxYmN0NzhzVXlPMGVITlRNN3ljQWJPQmFBcjB3M3ZaTkl4UWkwT2FaUWFo?=
 =?utf-8?B?UkI5QkFwL2NKbUZ0aDhmdXhPd1RLRWoxbnpqOWc2ZW5tOVRTZ1h1TEpxT21R?=
 =?utf-8?B?UW1YdjdmRlpZV0Q4Q29rTkpBS0dXa0JCRmFWVlMwK2JqMUpUTVlhUmZLRlVW?=
 =?utf-8?B?bDJ4Z21aNFVhRUdvQ3VabVlKNmJ3eDRpdmlNTGRheExTUDJFemRmWkpLcE9Q?=
 =?utf-8?B?bkVvR0RCOHdKOE5oc0U5Q1ExU00yczBIb3VJNXNjYmhTMWZTWkh3VEhOU3lv?=
 =?utf-8?B?VCtRcGVzcTRzRStRNzFwcWdLSGFYNnRWeGcyVmpLTXRpZUx5RkRSTmtuemMy?=
 =?utf-8?B?MmhTYkNkUENucmRMajVXR0xiWE9nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C51FC0E61CBD844794CB3B9C17B45334@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7b2623-a527-4a42-888b-08dc7e6810c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 16:14:20.2714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Tjf0H2TOMH4Ldt353JXMF404ebnLDQiBSemqTuuGU8Dz+5x488GKWI+hsF+I/0vA2HFqSdqhVG+P9VEs2L+NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6557

T24gTW9uLCAyMDI0LTA1LTI3IGF0IDEzOjA0ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiBkZW50cnktPmRfZnNkYXRhIGlzIHNldCB0byBORlNfRlNEQVRBX0JMT0NLRUQgd2hpbGUgdW5s
aW5raW5nIG9yDQo+IHJlbmFtaW5nLW92ZXIgYSBmaWxlIHRvIGVuc3VyZSB0aGF0IG5vIG9wZW4g
c3VjY2VlZHMgd2hpbGUgdGhlIE5GUw0KPiBvcGVyYXRpb24gcHJvZ3Jlc3NlZCBvbiB0aGUgc2Vy
dmVyLg0KPiANCj4gU2V0dGluZyBkZW50cnktPmRfZnNkYXRhIHRvIE5GU19GU0RBVEFfQkxPQ0tF
RCBpcyBkb25lIHVuZGVyIC0+ZF9sb2NrDQo+IGFmdGVyIGNoZWNraW5nIHRoZSByZWZjb3VudCBp
cyBub3QgZWxldmF0ZWQuwqAgQW55IGF0dGVtcHQgdG8gb3BlbiB0aGUNCj4gZmlsZSAodGhyb3Vn
aCB0aGF0IG5hbWUpIHdpbGwgZ28gdGhyb3VnaCBsb29rcF9vcGVuKCkgd2hpY2ggd2lsbCB0YWtl
DQo+IC0+ZF9sb2NrIHdoaWxlIGluY3JlbWVudGluZyB0aGUgcmVmY291bnQsIHdlIGNhbiBiZSBz
dXJlIHRoYXQgb25jZQ0KPiB0aGUNCj4gbmV3IHZhbHVlIGlzIHNldCwgX19uZnNfbG9va3VwX3Jl
dmFsaWRhdGUoKSAqd2lsbCogc2VlIHRoZSBuZXcgdmFsdWUNCj4gYW5kDQo+IHdpbGwgYmxvY2su
DQo+IA0KPiBXZSBkb24ndCBoYXZlIGFueSBsb2NraW5nIGd1YXJhbnRlZSB0aGF0IHdoZW4gd2Ug
c2V0IC0+ZF9mc2RhdGEgdG8NCj4gTlVMTCwNCj4gdGhlIHdhaXRfdmFyX2V2ZW50KCkgaW4gX19u
ZnNfbG9va3VwX3JldmFsaWRhdGUoKSB3aWxsIG5vdGljZS4NCj4gd2FpdC93YWtlIHByaW1pdGl2
ZXMgZG8gTk9UIHByb3ZpZGUgYmFycmllcnMgdG8gZ3VhcmFudGVlIG9yZGVyLsKgIFdlDQo+IG11
c3QgdXNlIHNtcF9sb2FkX2FjcXVpcmUoKSBpbiB3YWl0X3Zhcl9ldmVudCgpIHRvIGVuc3VyZSB3
ZSBsb29rIGF0DQo+IGFuDQo+IHVwLXRvLWRhdGUgdmFsdWUsIGFuZCBtdXN0IHVzZSBzbXBfc3Rv
cmVfcmVsZWFzZSgpIGJlZm9yZQ0KPiB3YWtlX3VwX3ZhcigpLg0KPiANCj4gVGhpcyBwYXRjaCBh
ZGRzIHRob3NlIGJhcnJpZXIgZnVuY3Rpb25zIGFuZCBmYWN0b3JzIG91dA0KPiBibG9ja19yZXZh
bGlkYXRlKCkgYW5kIHVuYmxvY2tfcmV2YWxpZGF0ZSgpIGZhciBjbGFyaXR5Lg0KPiANCj4gVGhl
cmUgaXMgYWxzbyBhIGh5cG90aGV0aWNhbCBidWcgaW4gdGhhdCBpZiBtZW1vcnkgYWxsb2NhdGlv
biBmYWlscw0KPiAod2hpY2ggbmV2ZXIgaGFwcGVucyBpbiBwcmFjdGljZSkgd2UgbWlnaHQgbGVh
dmUgLT5kX2ZzZGF0YSBsb2NrZWQuDQo+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgbWlzc2luZyBjYWxs
IHRvIHVuYmxvY2tfcmV2YWxpZGF0ZSgpLg0KPiANCj4gUmVwb3J0ZWQtYW5kLXRlc3RlZC1ieTog
UmljaGFyZCBLb2plZHppbnN6a3kNCj4gPHJpY2hhcmQrZGViaWFuK2J1Z3JlcG9ydEBrb2plZHou
aW4+DQo+IENsb3NlczogaHR0cHM6Ly9idWdzLmRlYmlhbi5vcmcvY2dpLWJpbi9idWdyZXBvcnQu
Y2dpP2J1Zz0xMDcxNTAxDQo+IEZpeGVzOiAzYzU5MzY2YzIwN2UgKCJORlM6IGRvbid0IHVuaGFz
aCBkZW50cnkgZHVyaW5nIHVubGluay9yZW5hbWUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBOZWlsQnJv
d24gPG5laWxiQHN1c2UuZGU+DQo+IC0tLQ0KPiDCoGZzL25mcy9kaXIuYyB8IDQ0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQs
IDI5IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Zz
L25mcy9kaXIuYyBiL2ZzL25mcy9kaXIuYw0KPiBpbmRleCBhYzUwNTY3MWVmYmQuLmM5MWRjMzZk
NDFjYyAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL2Rpci5jDQo+ICsrKyBiL2ZzL25mcy9kaXIuYw0K
PiBAQCAtMTgwMiw5ICsxODAyLDEwIEBAIF9fbmZzX2xvb2t1cF9yZXZhbGlkYXRlKHN0cnVjdCBk
ZW50cnkgKmRlbnRyeSwNCj4gdW5zaWduZWQgaW50IGZsYWdzLA0KPiDCoAkJaWYgKHBhcmVudCAh
PSBSRUFEX09OQ0UoZGVudHJ5LT5kX3BhcmVudCkpDQo+IMKgCQkJcmV0dXJuIC1FQ0hJTEQ7DQo+
IMKgCX0gZWxzZSB7DQo+IC0JCS8qIFdhaXQgZm9yIHVubGluayB0byBjb21wbGV0ZSAqLw0KPiAr
CQkvKiBXYWl0IGZvciB1bmxpbmsgdG8gY29tcGxldGUgLSBzZWUNCj4gdW5ibG9ja19yZXZhbGlk
YXRlKCkgKi8NCj4gwqAJCXdhaXRfdmFyX2V2ZW50KCZkZW50cnktPmRfZnNkYXRhLA0KPiAtCQkJ
wqDCoMKgwqDCoMKgIGRlbnRyeS0+ZF9mc2RhdGEgIT0NCj4gTkZTX0ZTREFUQV9CTE9DS0VEKTsN
Cj4gKwkJCcKgwqDCoMKgwqDCoCBzbXBfbG9hZF9hY3F1aXJlKCZkZW50cnktPmRfZnNkYXRhKQ0K
PiArCQkJwqDCoMKgwqDCoMKgICE9IE5GU19GU0RBVEFfQkxPQ0tFRCk7DQoNCkRvZXNuJ3QgdGhp
cyBlbmQgdXAgYmVpbmcgYSByZXZlcnNlZCBBQ1FVSVJFK1JFTEVBU0UgYXMgZGVzY3JpYmVkIGlu
DQp0aGUgIkxPQ0sgQUNRVUlTSVRJT04gRlVOQ1RJT05TIiBzZWN0aW9uIG9mIERvY3VtZW50YXRp
b24vbWVtb3J5LQ0KYmFycmllcnMudHh0Pw0KDQpJT1c6IFNob3VsZG4ndCB0aGUgYWJvdmUgcmF0
aGVyIGJlIHVzaW5nIFJFQURfT05DRSgpPw0KDQo+IMKgCQlwYXJlbnQgPSBkZ2V0X3BhcmVudChk
ZW50cnkpOw0KPiDCoAkJcmV0ID0gcmV2YWwoZF9pbm9kZShwYXJlbnQpLCBkZW50cnksIGZsYWdz
KTsNCj4gwqAJCWRwdXQocGFyZW50KTsNCj4gQEAgLTE4MTcsNiArMTgxOCwyNiBAQCBzdGF0aWMg
aW50IG5mc19sb29rdXBfcmV2YWxpZGF0ZShzdHJ1Y3QgZGVudHJ5DQo+ICpkZW50cnksIHVuc2ln
bmVkIGludCBmbGFncykNCj4gwqAJcmV0dXJuIF9fbmZzX2xvb2t1cF9yZXZhbGlkYXRlKGRlbnRy
eSwgZmxhZ3MsDQo+IG5mc19kb19sb29rdXBfcmV2YWxpZGF0ZSk7DQo+IMKgfQ0KPiDCoA0KPiAr
c3RhdGljIHZvaWQgYmxvY2tfcmV2YWxpZGF0ZShzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQo+ICt7
DQo+ICsJLyogb2xkIGRldm5hbWUgLSBqdXN0IGluIGNhc2UgKi8NCj4gKwlrZnJlZShkZW50cnkt
PmRfZnNkYXRhKTsNCj4gKw0KPiArCS8qIEFueSBuZXcgcmVmZXJlbmNlIHRoYXQgY291bGQgbGVh
ZCB0byBhbiBvcGVuDQo+ICsJICogd2lsbCB0YWtlIC0+ZF9sb2NrIGluIGxvb2t1cF9vcGVuKCkg
LT4gZF9sb29rdXAoKS4NCj4gKwkgKi8NCj4gKwlsb2NrZGVwX2Fzc2VydF9oZWxkKCZkZW50cnkt
PmRfbG9jayk7DQo+ICsNCj4gKwlkZW50cnktPmRfZnNkYXRhID0gTlVMTDsNCg0KV2h5IGFyZSB5
b3UgZG9pbmcgYSBiYXJyaWVyIGZyZWUgY2hhbmdlIHRvIGRlbnRyeS0+ZF9mc2RhdGEgaGVyZSB3
aGVuDQp5b3UgaGF2ZSB0aGUgbWVtb3J5IGJhcnJpZXIgcHJvdGVjdGVkIGNoYW5nZSBpbiB1bmJs
b2NrX3JldmFsaWRhdGUoKT8NCg0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCB1bmJsb2NrX3Jl
dmFsaWRhdGUoc3RydWN0IGRlbnRyeSAqZGVudHJ5KQ0KPiArew0KPiArCS8qIHN0b3JlX3JlbGVh
c2UgZW5zdXJlcyB3YWl0X3Zhcl9ldmVudCgpIHNlZXMgdGhlIHVwZGF0ZSAqLw0KPiArCXNtcF9z
dG9yZV9yZWxlYXNlKCZkZW50cnktPmRfZnNkYXRhLCBOVUxMKTsNCg0KU2hvdWxkbid0IHRoaXMg
YmUgYSBXUklURV9PTkNFKCksIGZvciB0aGUgc2FtZSByZWFzb24gYXMgYWJvdmU/DQoNCj4gKwl3
YWtlX3VwX3ZhcigmZGVudHJ5LT5kX2ZzZGF0YSk7DQo+ICt9DQo+ICsNCj4gwqAvKg0KPiDCoCAq
IEEgd2Vha2VyIGZvcm0gb2YgZF9yZXZhbGlkYXRlIGZvciByZXZhbGlkYXRpbmcganVzdCB0aGUN
Cj4gZF9pbm9kZShkZW50cnkpDQo+IMKgICogd2hlbiB3ZSBkb24ndCByZWFsbHkgY2FyZSBhYm91
dCB0aGUgZGVudHJ5IG5hbWUuIFRoaXMgaXMgY2FsbGVkDQo+IHdoZW4gYQ0KPiBAQCAtMjUwMSwx
NSArMjUyMiwxMiBAQCBpbnQgbmZzX3VubGluayhzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0DQo+
IGRlbnRyeSAqZGVudHJ5KQ0KPiDCoAkJc3Bpbl91bmxvY2soJmRlbnRyeS0+ZF9sb2NrKTsNCj4g
wqAJCWdvdG8gb3V0Ow0KPiDCoAl9DQo+IC0JLyogb2xkIGRldm5hbWUgKi8NCj4gLQlrZnJlZShk
ZW50cnktPmRfZnNkYXRhKTsNCj4gLQlkZW50cnktPmRfZnNkYXRhID0gTkZTX0ZTREFUQV9CTE9D
S0VEOw0KPiArCWJsb2NrX3JldmFsaWRhdGUoZGVudHJ5KTsNCj4gwqANCj4gwqAJc3Bpbl91bmxv
Y2soJmRlbnRyeS0+ZF9sb2NrKTsNCj4gwqAJZXJyb3IgPSBuZnNfc2FmZV9yZW1vdmUoZGVudHJ5
KTsNCj4gwqAJbmZzX2RlbnRyeV9yZW1vdmVfaGFuZGxlX2Vycm9yKGRpciwgZGVudHJ5LCBlcnJv
cik7DQo+IC0JZGVudHJ5LT5kX2ZzZGF0YSA9IE5VTEw7DQo+IC0Jd2FrZV91cF92YXIoJmRlbnRy
eS0+ZF9mc2RhdGEpOw0KPiArCXVuYmxvY2tfcmV2YWxpZGF0ZShkZW50cnkpOw0KPiDCoG91dDoN
Cj4gwqAJdHJhY2VfbmZzX3VubGlua19leGl0KGRpciwgZGVudHJ5LCBlcnJvcik7DQo+IMKgCXJl
dHVybiBlcnJvcjsNCj4gQEAgLTI2MTYsOCArMjYzNCw3IEBAIG5mc191bmJsb2NrX3JlbmFtZShz
dHJ1Y3QgcnBjX3Rhc2sgKnRhc2ssDQo+IHN0cnVjdCBuZnNfcmVuYW1lZGF0YSAqZGF0YSkNCj4g
wqB7DQo+IMKgCXN0cnVjdCBkZW50cnkgKm5ld19kZW50cnkgPSBkYXRhLT5uZXdfZGVudHJ5Ow0K
PiDCoA0KPiAtCW5ld19kZW50cnktPmRfZnNkYXRhID0gTlVMTDsNCj4gLQl3YWtlX3VwX3Zhcigm
bmV3X2RlbnRyeS0+ZF9mc2RhdGEpOw0KPiArCXVuYmxvY2tfcmV2YWxpZGF0ZShuZXdfZGVudHJ5
KTsNCj4gwqB9DQo+IMKgDQo+IMKgLyoNCj4gQEAgLTI2NzksMTEgKzI2OTYsNiBAQCBpbnQgbmZz
X3JlbmFtZShzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0DQo+IGlub2RlICpvbGRfZGly
LA0KPiDCoAkJaWYgKFdBUk5fT04obmV3X2RlbnRyeS0+ZF9mbGFncyAmDQo+IERDQUNIRV9ORlNG
U19SRU5BTUVEKSB8fA0KPiDCoAkJwqDCoMKgIFdBUk5fT04obmV3X2RlbnRyeS0+ZF9mc2RhdGEg
PT0NCj4gTkZTX0ZTREFUQV9CTE9DS0VEKSkNCj4gwqAJCQlnb3RvIG91dDsNCj4gLQkJaWYgKG5l
d19kZW50cnktPmRfZnNkYXRhKSB7DQo+IC0JCQkvKiBvbGQgZGV2bmFtZSAqLw0KPiAtCQkJa2Zy
ZWUobmV3X2RlbnRyeS0+ZF9mc2RhdGEpOw0KPiAtCQkJbmV3X2RlbnRyeS0+ZF9mc2RhdGEgPSBO
VUxMOw0KPiAtCQl9DQo+IMKgDQo+IMKgCQlzcGluX2xvY2soJm5ld19kZW50cnktPmRfbG9jayk7
DQo+IMKgCQlpZiAoZF9jb3VudChuZXdfZGVudHJ5KSA+IDIpIHsNCj4gQEAgLTI3MDUsNyArMjcx
Nyw3IEBAIGludCBuZnNfcmVuYW1lKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QNCj4g
aW5vZGUgKm9sZF9kaXIsDQo+IMKgCQkJbmV3X2RlbnRyeSA9IGRlbnRyeTsNCj4gwqAJCQluZXdf
aW5vZGUgPSBOVUxMOw0KPiDCoAkJfSBlbHNlIHsNCj4gLQkJCW5ld19kZW50cnktPmRfZnNkYXRh
ID0gTkZTX0ZTREFUQV9CTE9DS0VEOw0KPiArCQkJYmxvY2tfcmV2YWxpZGF0ZShuZXdfZGVudHJ5
KTsNCj4gwqAJCQltdXN0X3VuYmxvY2sgPSB0cnVlOw0KPiDCoAkJCXNwaW5fdW5sb2NrKCZuZXdf
ZGVudHJ5LT5kX2xvY2spOw0KPiDCoAkJfQ0KPiBAQCAtMjcxNyw2ICsyNzI5LDggQEAgaW50IG5m
c19yZW5hbWUoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdA0KPiBpbm9kZSAqb2xkX2Rp
ciwNCj4gwqAJdGFzayA9IG5mc19hc3luY19yZW5hbWUob2xkX2RpciwgbmV3X2Rpciwgb2xkX2Rl
bnRyeSwNCj4gbmV3X2RlbnRyeSwNCj4gwqAJCQkJbXVzdF91bmJsb2NrID8gbmZzX3VuYmxvY2tf
cmVuYW1lIDoNCj4gTlVMTCk7DQo+IMKgCWlmIChJU19FUlIodGFzaykpIHsNCj4gKwkJaWYgKG11
c3RfdW5ibG9jaykNCj4gKwkJCXVuYmxvY2tfcmV2YWxpZGF0ZShuZXdfZGVudHJ5KTsNCj4gwqAJ
CWVycm9yID0gUFRSX0VSUih0YXNrKTsNCj4gwqAJCWdvdG8gb3V0Ow0KPiDCoAl9DQoNCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

