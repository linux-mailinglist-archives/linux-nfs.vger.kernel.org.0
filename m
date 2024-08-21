Return-Path: <linux-nfs+bounces-5530-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2DD95A299
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 18:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 879D6B23DDA
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C5B146D69;
	Wed, 21 Aug 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="TJ1ENdOl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2091.outbound.protection.outlook.com [40.107.236.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754113C914
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257105; cv=fail; b=GI30KaDYtyRDx57ncgiJpMVcKl02Fn9HHhtRBSn1pxYpIKfBIq22TpCSPKrKdejEvdMAH1MxP4lHYohwTKn5dzyao+moYW2Be3zhC+6dGcLwJQfUR7Fu8coBgLinjjvW1iDuEVKR2fQNyy30RnOfqVYy7j1kVaWNPo5cHvPt7Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257105; c=relaxed/simple;
	bh=XCps+fl6FNqwILGYRMaKMldTq7EpFPMYw4TrZ3gTSoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=As2VDWmgFrEDxBqAfbhEagx+2ErhJKfsxqe4v3SotGK1FbsmglOat2R5fl/AcVp+hopGCLDhAEFvTmfqvrSAjWZ79U34nqdWrwyd6Es36sBH16IPAslWPhIhUnuUqX7CQOd7wrswpvirPibBNHPlOByZ6JRaThJXznsV35+pHxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=TJ1ENdOl; arc=fail smtp.client-ip=40.107.236.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOLDvs7YiTn+/yQgKh17BUbJMEu7ASvBsU3D2nX+7DtHGD9p5/ywBrtOduA+xIk8PQaaf6qFGq9w7uxZMTxi4gmqbeUUUjuvbs9hFoDhfW/HeXwpCUInpSqWqzRbR7AxRtHFVCF/yLKit9krQpo7JDvMt2QsSYuJfpGiOJLFLHDPGdMMk8qKXL89JkhGxI1PU+HpbyqxyRwSt1Wr01KrMHjfPmwpgGK4dyXFFIBY/YKshP1kkG9876dyKbeiiMu2AtPWYU1kF/Oonfh5TIR0JwnKrU0zAaa5M0fpYj24SwCW6QE1NZletQROjUgI2s6gd9ClfjrJmxQnV1GoHxzIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCps+fl6FNqwILGYRMaKMldTq7EpFPMYw4TrZ3gTSoQ=;
 b=txZ+gxAVbItiiIG1gGbNEyE7oXoY+xyHt/aPWllNAFTydYwB50/yyPvLBCiCnYP1gk54lfqZztDcq5GutO2x6YV2+Mp+9XlvtEl718nVOBqZD7qqyCu0L4IrnZwo3ZibBCPuBL87fIZHBqfHspqjHF0XYNq0Wnz25mQTYiOlNV/uSQT0S4w4wZEG84xCXAHFpAYze9051CMLinFD74fcqIvW4gWZWPghTNnTy3GWeu9/7kCD71nQDrA9ad8OJ3OdwFWUnwXfXNpE8PmQtXvmmHuIyPh7FcZO3RJdfkyiO4jRS3aSsQd1rHOYn1PV2GILgIB7iVXjftRSOPvbDWTD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCps+fl6FNqwILGYRMaKMldTq7EpFPMYw4TrZ3gTSoQ=;
 b=TJ1ENdOlLk37kRC5tOrvCNPYZOwJekaI9OyDDu5v3GzsQtD/fH4Er+xSg30XgOeQ06Uiyatk24sHvfbvMNUzb3OPw/yfoud+vwsn7EL2XpavMuE0pH4sg82o3UyLlFYcgOEum+M6olc+3qD5Q5A7DL/NzpdMGfTckC4/eJ7GBtA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY3PR13MB4916.namprd13.prod.outlook.com (2603:10b6:a03:36f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 16:18:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 16:18:17 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "jlayton@kernel.org" <jlayton@kernel.org>, "bcodding@redhat.com"
	<bcodding@redhat.com>
CC: "anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: fix the fetch of FATTR4_OPEN_ARGUMENTS
Thread-Topic: [PATCH] nfs: fix the fetch of FATTR4_OPEN_ARGUMENTS
Thread-Index: AQHa7x4u3q+d0Cdc/UeYFdl+RVkuubIx6ea9gAADUgA=
Date: Wed, 21 Aug 2024 16:18:17 +0000
Message-ID: <a726dfdc9a57b4e04ef35f1ff52f56722df5b87b.camel@hammerspace.com>
References: <20240815141841.29620-1-jlayton@kernel.org>
	 <74650085-DEEE-4483-8754-EE409649E574@redhat.com>
	 <06fc6f0eab32ea183c5aace43ba08ea6ecfd9cf4.camel@kernel.org>
In-Reply-To: <06fc6f0eab32ea183c5aace43ba08ea6ecfd9cf4.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY3PR13MB4916:EE_
x-ms-office365-filtering-correlation-id: bb0346f2-55f0-44fe-e1c8-08dcc1fcddc3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTBtSVUzM2hrVitwVy9yM1JkV2RDeUxrbTRhdkdEQm5zblhlZWNPNVZZZUpr?=
 =?utf-8?B?VXRDUXVZU1BZVXVGSkh2ZCtLNDJ4UzE4WmdSRFFPYW0yVXBTTVNjeTRCSDVL?=
 =?utf-8?B?RGxlZWFxdHpPRXN5dHB2MzhnRXJhM3pUT1pYRmhuVTViQlVFY0s1WlNidit1?=
 =?utf-8?B?Zlc1YXFCRFY5S0pOS2VWekNhQTlxZXVrMS9mbUVtYzFrSmk2cy9pNU9hSUV3?=
 =?utf-8?B?ZEU0QkJmbTFYZkdjNGFqRXVIckVsZUROL29Na3ZlVXFvZHNvekxpbTByTEkw?=
 =?utf-8?B?ZDVNbHk2NUIwN0lzZjZ1ajZaTmJiSXlPaGdRQ1BqMkhrd29ZL3dxT04yRjFT?=
 =?utf-8?B?TnQ3c1Zla01tQkp0Tm1QMHg4Tk02YzV0OGdwQmNLMGcwUm4zQVRWOTg1OWhV?=
 =?utf-8?B?ZXMrTlczWklvZk5RZFB1Qlo2QnB4TTltNGQyUVZhRGZSODVvM1BnVCtWdk8y?=
 =?utf-8?B?QmJrVUJjbkxoLzhYOHkyZXp3aStzVWhOYXJoZnA5T29SRkZTNGZ4MElwTEEz?=
 =?utf-8?B?cGMvMDlqVE5ORy9idFc5RHRNbXVpQmRTeldRZk1CcHpRcWQwQmQzRGE4V0I3?=
 =?utf-8?B?L2lYb01FZGwvK3hwRmd6bElVNXFnMWJqTUFmSFE3OWx5d2tWVTg4aWRUOGVT?=
 =?utf-8?B?QkdYUUVvNFZHaU5QNnJrMGdJL2JENDN1MGhKbmh6RVJYUjlpeEJUVzhCZWRE?=
 =?utf-8?B?Ry9Pb1hrRjJnNVY1dG5xZ3puSlRBQ1ZXRnh0ZGRVcXAwN1AwaUFPc0xFUDVB?=
 =?utf-8?B?elZSVzVGbWpTRkQ2MkdhNXl2UG1oYmZha2FuQldLRFV0eS9QY2x0UGlSREZZ?=
 =?utf-8?B?cXliSDBYeFkrK0EzaFcya0J6aTE1OVBiRk5pa2FkRnJRL1lLZGRiWVowSFZ1?=
 =?utf-8?B?cGc1YjRtbk5jUzRwN1UvNllDRmxWQTBvbXp3RzJib295WWptUXBjR2NDczUv?=
 =?utf-8?B?N0pqVHQxemFkWk9oN0VnaW1DdkowcDJVMHVGVU5PSDkvWnFheG9ONkdsVlNL?=
 =?utf-8?B?YWVZZ3cyR2F5WUZVSzZzWDdWakZ1VEtIOVVyTFFyZXE3WCszZEx6eVdQYWdh?=
 =?utf-8?B?RlFyTHdKWE1lZGVUbnJ6TC9kZlAxYU5zcU9OWkU5K2dLRlF1TXlMUzZldzVi?=
 =?utf-8?B?b3JwS01wU3dSbWo1alNhVERCb2ZkSXdacSswRW56azhHU2c3aUhRRjJHeDFH?=
 =?utf-8?B?cXp4WGlQYXdRQmNyL3B1UUJvTUxmeHU4eTliTUhlYUwxT25zaDlTSTZIL2dS?=
 =?utf-8?B?UlIveVpHRHl6MUtRZHFZUVRUOHNLSW1DOEdQNjJxMXRyaUVmSWRWUHNteGMy?=
 =?utf-8?B?WHlEUG8wai9memFKc0RZRE5wKy9MUnVzSEhMTmlaYnA5WTBIT2sybTdQdkFx?=
 =?utf-8?B?NDkxdnBldklXaDh3MVBKSDhuVThQMnRFTTlaeVdJTWNwaUJtYXl2QXFNekZR?=
 =?utf-8?B?SldORjhzM21OeU5admFIT29ER0IwMUFKQksrOTc0ZnBieFBQS3pyMmhKRkJX?=
 =?utf-8?B?ZkdjdnNpNTI3a2dWcGlUbC9CQ1NWWUVWeFh2S0V5cDNYVEJYMzR4QzJQTWRz?=
 =?utf-8?B?eWNJU1QxVitqNlJ6akE4dzJBdVFsNWZoRVI5YkZiaG1ZaWgzbGprUEJNL0hD?=
 =?utf-8?B?UytGM1V2OGVjOEFheElsem5ZZENzNU05c1huRmZXZ1ZGMmI3ZzZSRWlBdm4y?=
 =?utf-8?B?c2dCcm90c2ZjRW5TMUdpY2ovTnNYd0Y2Z3dGVDhHVzAyNkhHRTh2cjlHOTFB?=
 =?utf-8?B?TTc3S3U5VTBhTGhrNDJDc3o5U3JPT1NOOXN2YjExV21lbkVRdXczOFRIZmNq?=
 =?utf-8?B?TER3ek00dTU5S2FCQW5DTDlmN2R6SnRvdEM0aGlRdkt2SFJzanJPWmxqZzEw?=
 =?utf-8?B?TlUxWHBqZlVJUXYvMnNrY1VMd25CUWM5ektJVk9adUY3YUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFdGZjhmdWZLeVdZM2ZsUG1ZUCtJWjR4WjRHY1kvbGQ5VldUQWZpcFZ0MFVZ?=
 =?utf-8?B?WFlobmNXY1doaDlZejFZYnZaMDRuRzNuRTIxemdERnQvN0lFdmZXUW9zL0hM?=
 =?utf-8?B?bEc3T1VZbFhoNzdpY3NYdmxOeUdlc2FYRlZsZ05rWWFZaXFsR2JUT1ZaVmtJ?=
 =?utf-8?B?aEthM0l2MWdpQW51TUpyZ0RONmE3eWdYbUpTQ21IakZmUVdOKzQrR0x1Q3Yz?=
 =?utf-8?B?ZUNVdVR1UUdRNjZ5WWJRdXE0T1h5L1UzRXl0RGljTXN3dGt1MnFyNm5ZNU9Y?=
 =?utf-8?B?eEgxZ2diaDRyWnA0dy9qM1JYTXVHUVVaK05vVWRIQWpBYWo1NzBGellrZTBD?=
 =?utf-8?B?Yzd0U3liUW1oRlI4Zy9KRUZxTy81N1NaTUx1dmxLN3IvS2FQNTdhWTlBQWpY?=
 =?utf-8?B?ZkNuVWczalNVRURncEJ5d1FhTGFsc0xSUDlzekVPYXlsdWViTHNJaTM0L0ho?=
 =?utf-8?B?OWhWa1BPWXVjcTl4RTFVQ0RId1BHUHkvVlJIYzd6ZGIzL1IzMk1mbUQrNmc3?=
 =?utf-8?B?c2Q4MXNwdkE4Q1hoWlRHZzBVWnM1MjJMMENncGVwUUg1SnRMcVZnSXZVLy9M?=
 =?utf-8?B?Q1BnRm5kQUczbFc0bXhDZkprRVhvTlNKK3diNDVPVXZMa0hac3FGcEJhZ0ND?=
 =?utf-8?B?NDl5VGtHZ29mdU5LbXhuZERkY21MQThkNU9heXFJSlN4ckNsN3hIK1JZaC96?=
 =?utf-8?B?N2M3WnVBRm1oTlplc2QyRGo4TlRXQUhEVm9yTmdLRVVhSG1tVEY1alY0bHpK?=
 =?utf-8?B?K3N1TzRNRk9OTTc3MGJsbXpSYkUxRWZub09ENEozTDdTcDVSa1NPU1pPTTJl?=
 =?utf-8?B?aTB0UkFyYU9vYTd3MmFhUy80Sm9NUzl4NlhUZ29TWWY2UkRkV3NZS2trSjJ0?=
 =?utf-8?B?VWV3WVg3VDFCZWhQd0RwYkFSSzBTMnQ1OGFXQnErZlFzVDZ6dHFJcnZTRmkw?=
 =?utf-8?B?UEVxd2h4WGNPT095VkV4VkszcHhMTk5FTS9kNDREK2lRdG9zNEx4aWJBb2NX?=
 =?utf-8?B?VGZDK05IQnVTMC83dkxIQVNQNVBqZjIybVZwVW9GbytHdlgwazR2bFJSRTcz?=
 =?utf-8?B?S2xPV1I1dmN5MURPRGxSelBsZW5XWVFsQjBxZmhTMEdxR2pSOFEyaGJoMzQz?=
 =?utf-8?B?aktyMDVrQXNqTjJsaTRiZXRNMjRNQUxsWkk0SlRkRVZzcEhxcVdTRk1KWFlZ?=
 =?utf-8?B?cnRHbWN3MTA5TW5Pc3I3ajZBKzVIZTE0ejF5RmIrbVV6Wjh4NGdXa2RTZ0Q4?=
 =?utf-8?B?dERmL3VMckZ6dVFXakdpTWJROUdFVnZ3akRRS0YrSUVKNTNjSmh2MWtZeEhl?=
 =?utf-8?B?ZnFBRDFuZThDTUkzQnBicURKUkQzZmZUOVduRExwdVhQbWpFTzFWUERieEdl?=
 =?utf-8?B?RmdqdHRhL21sMVBhdk1wL3Bya1FKR1ZtRkdSZk44dlJBbjRmNFh5RktTZGRj?=
 =?utf-8?B?SnUveDlyL1Z1THp0dDNyb09zY0VnajJlSHlLeWc5cC9RdEN2ZUhrTkZ4UHVh?=
 =?utf-8?B?eHdGZ0c5U0F4Z2Ntbi9rL3VBV3pvVWYwLzhMc0diT2ZsbkVlQzlpRHZXOVhl?=
 =?utf-8?B?LzB2dlBHc2NVNzd5RlRzVUJoc2thTWJFRHlrbkMxVzl3ZHRCYkk2dXBmVU55?=
 =?utf-8?B?REY3cmF6RFBIcHMrYzlBMzBzRzJRQzRLL3gvOExMb0xxaDlUZmdweFlwdUQ1?=
 =?utf-8?B?eDFWNnBoZ2ZURkxGcnpwWkIwa1EyYjAwVXdZRW9GbmJVZEkxeDlkMmNRL2ZJ?=
 =?utf-8?B?UVZOUWQxUUtUMXRlOWR4SW9OL2J1cDF0d2FENlo4dFg4bGVwaEpLTkNidVBi?=
 =?utf-8?B?SHNGOTd5Qnc4aWdxN2gzYitZdUpsVWgxcXI3SzdpelJqQ201QjU5ck5GcGZh?=
 =?utf-8?B?YVljMVI4REVndzNvbU04WWhSWjVoY0NEaWZnSEtnd3lTeTNDM1YweHkrQlYw?=
 =?utf-8?B?MVQ0QlNYMUJIZi82dy9ueWJHN3A4L2JXbC9BZm1YSW9UVFJScVVTQXhiWDkr?=
 =?utf-8?B?VjN6VHcrSStVSlVhZzNZUVZDVTZNVTg2SVgrcWZVcStJbzltY0Z2YVNHWER0?=
 =?utf-8?B?Y2FjeFVYWUlmWnVJa2hSUUVGU3pxeno0bWJBUFBrTmhnckZFZm52WFUyRXBh?=
 =?utf-8?B?VWpNTmpNa3pqeGFnZlpjZmgxNWU5ajFmdG5rYzQ3VWxHajBjaXJIUjQrcUVx?=
 =?utf-8?B?YnpSaisyb2oweks2d2ZGdXpiNWI3M0VUdTBpeXcvaFdFTHBkL3RYRmpOcHdx?=
 =?utf-8?B?cTQxZHcwblBLQmo1SFdwRUU0end3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <223AC304CE07E845A37CC07D41361867@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0346f2-55f0-44fe-e1c8-08dcc1fcddc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 16:18:17.5936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gR7A8B6pOL/GGBtiVYnwzG8pHrKBYss/srkJMin22v4uTUCUtM1Qry/9AEyZ045BrgC+qBuA9ZIECq4K+DfdyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4916

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDEyOjA2IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gV2VkLCAyMDI0LTA4LTIxIGF0IDEyOjA0IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiA+IE9uIDE1IEF1ZyAyMDI0LCBhdCAxMDoxOCwgSmVmZiBMYXl0b24gd3JvdGU6DQo+
ID4gDQo+ID4gPiBUaGUgY2xpZW50IGRvZXNuJ3QgcHJvcGVybHkgcmVxdWVzdCBGQVRUUjRfT1BF
Tl9BUkdVTUVOVFMgaW4gdGhlDQo+ID4gPiBpbml0aWFsDQo+ID4gPiBTRVJWRVJfQ0FQUyBnZXRh
dHRyLiBBZGQgRkFUVFI0X1dPUkQyX09QRU5fQVJHVU1FTlRTIHRvIHRoZQ0KPiA+ID4gaW5pdGlh
bA0KPiA+ID4gcmVxdWVzdC4NCj4gPiA+IA0KPiA+ID4gRml4ZXM6IDcwN2YxM2IzZDA4MSAoTkZT
djQ6IEFkZCBzdXBwb3J0IGZvciB0aGUNCj4gPiA+IEZBVFRSNF9PUEVOX0FSR1VNRU5UUyBhdHRy
aWJ1dGUpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwu
b3JnPg0KPiA+IA0KPiA+IENsZWFybHkgY29ycmVjdCwgc2F2ZSBmb3Igc2xpZ2h0IHN0eWxlIG1p
c21hdGNoLg0KPiA+IA0KPiA+IFJldmlld2VkLWJ5OiBCZW5qYW1pbiBDb2RkaW5ndG9uIDxiY29k
ZGluZ0ByZWRoYXQuY29tPg0KPiA+IA0KPiA+IEJlbg0KPiA+IA0KPiANCj4gVGhhbmtzLiBJIG5v
dGljZWQgdGhhdCBhZnRlciBzZW5kaW5nIGl0LiBObyBvYmplY3Rpb24gaWYgeW91IHdhbnQgdG8N
Cj4gZml4IHRoYXQgdXAgYmVmb3JlIG1lcmdpbmcuDQoNCkFjayB0byB0aGlzIHRvby4NCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

