Return-Path: <linux-nfs+bounces-8858-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434F09FF31D
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jan 2025 07:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE29E161B43
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jan 2025 06:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EB7F4E2;
	Wed,  1 Jan 2025 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="pkYHa+UA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E31EACE
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jan 2025 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735712560; cv=fail; b=u09kHBp+QkDMsBiSz2VtzeGHFj3DdVdMJbciQkP+iB4RR7aWAIaURI90GYhsQDHTnAojYIL0sqm/V3UfHaVf8CR7iuqfn3piq6s/0Nvl6cANMMsonzzzaia3/MoQpqdprJMFOhu3SiM/w2OCob684n/JuuXEdPdEQbAsPC0m9wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735712560; c=relaxed/simple;
	bh=zptSKoP4muXf3WTVdS9aZM+1l8t7Nb8JIQeaNjh6cLg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JqGM2ksdNTzJHmeIPwZAaWGH8ulEl59mQ9e/1faqRETs05EVgdIzbtKYIlBMa+cYPCWs5pKGaUcOtNJ+eOwk/F4e+i6q1l1cD0mpDADuFahqeS5WWMtGn3SQ71GFoZedSduFP4dVSUGeUpffpKEucn7LAINAxKL6z11SlQtAKdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=pkYHa+UA; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BVNLCKb027183;
	Wed, 1 Jan 2025 01:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=smtpout1; bh=zptSKoP4muXf3WTVdS9aZM+
	1l8t7Nb8JIQeaNjh6cLg=; b=pkYHa+UAMo5P0X1lwXKhMojsOzm+aIpD4OA5n5V
	YHztky7W3g9Lz6R1zuW75OjT4uzEaoLKt32Gmk2Z1g9hPZ7l//rg4QIRPLGp4Ff6
	k2sisrlO1MLzPMw2Ry/koS/U9Zf/5kqucJDnXYAjt7UqxkD1Q6w4g3dYMz9vqBL3
	56VCRKJHZ4F8dOoeIUtFzhnXGGSHlJKaxWeURebsCXe5nnQcWjiaP9lIL0/tE6zn
	GCINepo9o6glomoyo10kc5qPM9TKQ97sjPGfjGK1RaOWn0KmAcza8lBnkl/SyUF0
	fKFX/ffSLpEalwLZya0TzoHVhCnPh+NUHmESL+TbKinPBYg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 43vffjbq1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jan 2025 01:22:31 -0500 (EST)
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50144MfS026567;
	Wed, 1 Jan 2025 01:22:22 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 43vxbngvv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 01:22:22 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElF1Fd6+BvmLME3XtWMqIKOw2xqLZBBwklimM9AYvMKk+q20RaW/WxPSb0ACch4XyaX9qITDWn1iuwqUiPO6UI6akB3MblaagXmvzJHt2tkywPWkEDJfZhXSCIBfR5wEFBC77xYtKTvfxZB2YPSAqP/ixol9TLsvmRVbg4ZuoK5ldNoxLYXuXEDg4TGw6oeUDTcSjWMbpsTwyDlJVZ4hAiPckemx+1h+FEHeeKL+15A4gHjRAA6Uv3nArPy8DCbs8nr3FoMvLFOz+IlzAZYVjNxuePXDKXdNC7AaKAPsBbLNQE6bViig2LCg9Oin0B5bHjnXulDtmQXwraR9S/NNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zptSKoP4muXf3WTVdS9aZM+1l8t7Nb8JIQeaNjh6cLg=;
 b=UMuWQWLocopEVeZ3XjX6yLgb9p//YML3xXS7ayc9WwVfYTjs0AEVk+5tXtvcuSpW4Mfb2V18v9petc5hjyjoWYhYzvfqyqr1NttcLJ9FvHyLrvcM5aJgwnbA0ue6A9lswHId4cxrVxTWy3SPBLHIeags+d0qb/ahiDHHzXJkniPawjK5xfA1bFImwxtRaVk3yy9UrXmQIOyaYvGTUj+ALMUrjCfcW5Dk5WVZ9xXboOYQiEmYzCG6qPU/8FCY2ZkxCWyJT9j6i3WzZWqMtcy+r10zFUL/Rj7DdwmvkWICjhtl2xGAHTSXnjoV4nziBaCkmVq+VYTKxci/t3wP+O7p3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from MW4PR19MB7103.namprd19.prod.outlook.com (2603:10b6:303:22c::20)
 by MW4PR19MB7031.namprd19.prod.outlook.com (2603:10b6:303:228::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Wed, 1 Jan
 2025 06:22:15 +0000
Received: from MW4PR19MB7103.namprd19.prod.outlook.com
 ([fe80::7ef:eec8:9bce:990d]) by MW4PR19MB7103.namprd19.prod.outlook.com
 ([fe80::7ef:eec8:9bce:990d%4]) with mapi id 15.20.8314.012; Wed, 1 Jan 2025
 06:22:15 +0000
From: "Gaikwad, Shubham" <Shubham.Gaikwad1@dell.com>
To: "bfields@fieldses.org" <bfields@fieldses.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Godbole, Ajey"
	<Ajey.Godbole@dell.com>
Subject: Clarification on PyNFS Test Case Behavior for st_lookupp.testLink in
 Versions 4.0 and 4.1
Thread-Topic: Clarification on PyNFS Test Case Behavior for
 st_lookupp.testLink in Versions 4.0 and 4.1
Thread-Index: AdtcFL06/eNq/jyGQD2UjcrUFgrwSw==
Date: Wed, 1 Jan 2025 06:22:14 +0000
Message-ID:
 <MW4PR19MB7103ABF9F49A383372C29AC0C40B2@MW4PR19MB7103.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=abb9ed2a-47ba-480e-9765-1043dac8d36c;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-01-01T06:14:27Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR19MB7103:EE_|MW4PR19MB7031:EE_
x-ms-office365-filtering-correlation-id: 43a35f18-b659-4f87-dbb8-08dd2a2ca283
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hfaavLxmu54e+aDLMYhmiK2NZz98ZJe8DhSLpBYwjcCx7s5uI1NWlgj9NjAw?=
 =?us-ascii?Q?5Qj1fA5irSvCgqUCZHfR/FtHPfV6VA0o1LNu9dNnszDprrR/35+BphWWrfLM?=
 =?us-ascii?Q?DE/jU/et5m9KzmrBJ5DPk7/AEbvu6j1hXIVaC0vhNNCeXBBhb3ABnhVSOquz?=
 =?us-ascii?Q?1slWel371eEHY2uVoXdgSJtZ2YwyrOvt5I0HPJarAvEDofagQQZtr62STwdq?=
 =?us-ascii?Q?3uE5C5jrEMUMT3JCQkHLi/xRWOfNW5G/+ssN1SoTK0seOjOHpk501Or2hHdX?=
 =?us-ascii?Q?TTetvfVy5/xEI4M3DG0WiS1RV/usPTZJeqrWRFx/7vaAchcmRbC30O9RVTPU?=
 =?us-ascii?Q?XgSX51NBujpWUKSFPN11swwvjhRAbTYSiC5UcVJk8MZF4D16YhKfZ9j4s8T/?=
 =?us-ascii?Q?qYErITb4Mky2UEoG8uRB1+gdgc4gBVow0Lk4NBe0M9ax0PTiBtVwgqD7GPfO?=
 =?us-ascii?Q?Pil6oxMegQRIvMAN18IyuBeNa6E0YpceMotqW5fF+9oL7SM1ZFYOMa6+Zr0J?=
 =?us-ascii?Q?qMSNosImpYBmEvZFXE5/sfgz9Zc5VTJux4hlSP8loHbFjkxvARKT8kn2uaOm?=
 =?us-ascii?Q?jwJ9otqpe9jUFJIuQpSannnApOxY6u76B5hlfxr6saGd+xdgp24jqpxLPTlx?=
 =?us-ascii?Q?o//vWXQG3QYtn+tHRCU8QV3JlTpum1IAX79Dv8/owHDrDOPvmwJZSMcYQwpg?=
 =?us-ascii?Q?u/6Bf96C1+nDOgOQDCX9pBLfgDY7/v1/qWKb+SoEDrdRLjDkhiwrQA1bgh7h?=
 =?us-ascii?Q?56JQYUy6FSJcCdpEVTodnwJqDHvauA1TdMpBraSqvrSc9SF86bh11xJ5fAT0?=
 =?us-ascii?Q?wP6mSm8MixbTs+hOi+wwB4W6BLbaM1x1Br5bNlfOyWdmue8rNqHn7uj9q1K5?=
 =?us-ascii?Q?Eq/YBt8Ybnrrur6VY86OIoeIX8kiVmgcCj1IwwM72UzqgRl1AGs5cji87NBP?=
 =?us-ascii?Q?2fI8kkCFZPBOJr7tgM0Oe+8k9T8m9osrl4qj3SeNqNPUVUwIpVRyVjIB6pYY?=
 =?us-ascii?Q?743/0eIKOb5n4b5A3MAKrWJ11yuFc5FSBOYCPffpsz3o25eUZ7/QoL2FaFnH?=
 =?us-ascii?Q?SnRI0ptwi83qFXmuKaeHmPOfr/aLTFmt+IAi2yMbwxfvQxsjiWIow5L2uoTX?=
 =?us-ascii?Q?Ip+RGwIpRXhdmTkgqSeIVYKs/QyJfYhuTloeS/M5wCG+/RLxTRiRv5vCt/JK?=
 =?us-ascii?Q?2dK6pvXBLmGiMyvQdfRU0X2oZ3fyt5XKjEEL2CtbcoDp1AsaRrLigHHtRUE9?=
 =?us-ascii?Q?Ic+vqYv5zIypLUCLQK44QbquKoGH6Sa5o0cIBLq6yEKp+svXWvIyxHFGgMc4?=
 =?us-ascii?Q?UqogZItMrwmvr0hl50jy2pMykKHiwYCduZAPC/fW5Xo7nU/vUuOOjPFpQHhg?=
 =?us-ascii?Q?YiIPcIkQETlq7fC+nGS1YS1HCpn5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR19MB7103.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wjR8Wpi4jmCHt3MWV/9sA/HILpeIZG+ImsohlaJDRNFpa4bIzbQwCmEl+lFs?=
 =?us-ascii?Q?1P176duQQDSwzave/2LdnELPH0tQnEp6iaQWZk6Jkh+QG4A7vdFnCCKSrVuB?=
 =?us-ascii?Q?S6a4kpgyWCsEIcmczJoZb1/5TM6jb1GxF6gNUlZI2oNTMK0LsXGdnyiTWXFv?=
 =?us-ascii?Q?WwEroEOE2AEK8p725N9POCa1e0zEqFxCHrDzurKlHpZIVKxYblC1TOTpflFb?=
 =?us-ascii?Q?oHZK2sakuuX612k7i6DPmyHaZHfPo6EfMIxYr+u7x4oCEo03Wnq/O4AAATA6?=
 =?us-ascii?Q?sBFbUoLN1tcjoy0TXtztOAkfLvkxeQdUmGEpbZ6scOlWgkCIX50NfoImMUhI?=
 =?us-ascii?Q?dvlUCNSuf7zj7WldoAISBqJM1sI275WDBspEgKXT/nytEdUCjzA0apbpPkBX?=
 =?us-ascii?Q?cFzgGlVV7o7NE2ecN5Vfubvu69BLMqf0rmGdur/Uh9L+/ZR4S/+z9amOMYK9?=
 =?us-ascii?Q?tSJldTx14g3nWxUC9GGK/ccHZQeb7VORR0z+6tJK/1oWFn0n1lwKrhZljo4T?=
 =?us-ascii?Q?sAV/9XoAg6rf7Pz6b1N5RAZbAtym3AXpcv2sGU7tsD65mK6XBcEs5dOTjAgC?=
 =?us-ascii?Q?LJTN7Iss2jI30EOEjQqALKtKg+i0Qn1o9cPqJXw2LGBTprD0qmwVi1Qv+8/4?=
 =?us-ascii?Q?k8RHFciWRnGTTj/3kCscMo7QyT3B8XV4o74xesOPEiBpAghfPtVAH6QvICk0?=
 =?us-ascii?Q?EM9A++UBxOY5sk5X/mTJtpEA9JkAC5Xfxn6V8UCYQhw8NQJOVQVSz8ax732B?=
 =?us-ascii?Q?GRnGPl+DBvTFKvUWgtqx8BWPs3huU4AFVG35P15xlStsHkq6c1SAa+Rxuav0?=
 =?us-ascii?Q?YDQw4mJDNc9rqsyKz5g447IX36sFNYPxFdKwZqY7F++JR0rPpv2OLFfT+4NP?=
 =?us-ascii?Q?rEwx23tp4gOpIfmyLEh+1TTIgh6b1ipgD3Cahb6w7F5bqTqnoC5RUXtONkAf?=
 =?us-ascii?Q?QYbqXchV2rxjTJAXi44nh1p6lnZp5uTpJW0e4+Q99ChY4fdSRpkEqm04zSOR?=
 =?us-ascii?Q?wWvRYgghqZIHCAMvifztl9pGEIN+MxD7goS9AvS80Mvcv5v5Zph+kBDCBswQ?=
 =?us-ascii?Q?m3g4oM9nQCyuEhCLpPufW63xF06ol6OVyBeKqujPO7+qBy+iTahDONCPuu2K?=
 =?us-ascii?Q?1uD7Rkv62CqTZSZJGa1uaKUo2RyF++IzAqvKimHnXtVADr13Vf61s3+crBPF?=
 =?us-ascii?Q?SnWmKDME8JwI9v1knLnJiC46L+NyReNvfunKUfxDh/Iph+4YlAAvzdNpqgt9?=
 =?us-ascii?Q?r3I9ToWhfwyhpCsFPuaRfWlfF25uJ9C1pCJLl0En7OMSGr/EoXtOELbNPoN6?=
 =?us-ascii?Q?ZGSEka1cPUbCas2WeGYFGnfoZH8GjAfLBRSWu8RM92u0z9LXP3tQ398nMksM?=
 =?us-ascii?Q?K5B+l8g0zp9sQz2gL6fw8r8GVjnNYSZLLOx/ilYGAVc1I/x4iK8WHgTy+pED?=
 =?us-ascii?Q?3/vC9AK29n2Jrcn6BFnbUEmrXMhi2tveh3Gchhyuu6VljAIOUMV1VDZs/z7E?=
 =?us-ascii?Q?+Y3MMaZc4kkVhle3YRDwk8cX1O36/4QpU7eydNQojpP/5FBnHIyraWy8Kp3U?=
 =?us-ascii?Q?/7IdfetmrIldhj5WmAjAelsm27GQhuBMJxGIux71?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR19MB7103.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a35f18-b659-4f87-dbb8-08dd2a2ca283
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2025 06:22:14.9696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TYJ3vLfKk+f0lL/3vRZ8iTqi/Cro5pQWZ9h9O2FDgp3soE2aNEO6jL9E8KRQGn2imhyPexwK4oyyNIXJSqTqxG9jPnkAjhIYWU5TofDdHTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB7031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_02,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501010053
X-Proofpoint-GUID: -HeA8BWrQBoQ_q9cqL3MxREnfMtLP3_O
X-Proofpoint-ORIG-GUID: -HeA8BWrQBoQ_q9cqL3MxREnfMtLP3_O
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501010053

Hi Bruce/PyNFS team,
I hope this email finds you well.

I am reaching out to seek clarification regarding the PyNFS test case 'st_l=
ookupp.testLink' (flag: lookupp, code: LOOKP2a/LKPP1a) included in the PyNF=
S test suite for v4.0 and v4.1. Specifically, I would like to understand th=
e expected behavior relating to the error codes for this test case.

In the PyNFS test suite for v4.0, the test case LOOKP2a (located at nfs4.0/=
servertests/st_lookupp.py::testLink) initially checked for the error code N=
FS4ERR_NOTDIR. Subsequently, an update was made to this test case to also e=
xpect NFS4ERR_SYMLINK in addition to NFS4ERR_NOTDIR [reference: git.linux-n=
fs.org Git - bfields/pynfs.git/commitdiff]. However, in the PyNFS test suit=
e for v4.1, the corresponding test case LKPP1a (located at nfs4.1/server41t=
ests/st_lookupp.py::testLink) continues to check only for NFS4ERR_SYMLINK a=
s the expected error code.

Given the discrepancy, should the test case for v4.1 (LKPP1a) be updated to=
 also check for NFS4ERR_NOTDIR, similar to the modification made for the v4=
.0 test case (LOOKP2a)? Additionally, while the RFC 8881 section on the loo=
kupp operation [reference: Section 18.14: Operation 16: LOOKUPP - Lookup Pa=
rent Directory] does not explicitly mention the error code NFS4ERR_SYMLINK,=
 it is noted in Sections 15.2 [reference: Operations and Their Valid Errors=
] and section 15.4 [reference: Errors and the Operations That Use Them]. Th=
erefore, would it be reasonable to update the test case LKPP1a to allow bot=
h NFS4ERR_SYMLINK and NFS4ERR_NOTDIR as valid error codes, ensuring the tes=
t case passes if either error code is received from the server?

Your insight on this matter would be greatly appreciated.

References:
1. git.linux-nfs.org Git - bfields/pynfs.git/commitdiff -- https://git.linu=
x-nfs.org/?p=3Dbfields/pynfs.git;a=3Dcommitdiff;h=3D6044afcc8ab7deea1beb77b=
e53956fc36713a5b3;hp=3D19e4c878f8538881af2b6e83672fb94d785aea33
2. Section 18.14: Operation 16: LOOKUPP - Lookup Parent Directory -- https:=
//www.rfc-editor.org/rfc/rfc8881.html#name-operation-16-lookupp-lookup
3. Operations and Their Valid Errors -- https://www.rfc-editor.org/rfc/rfc8=
881.html#name-operations-and-their-valid-
4. Errors and the Operations That Use Them -- https://www.rfc-editor.org/rf=
c/rfc8881.html#name-errors-and-the-operations-t

Best regards,
Shubham Gaikwad


Internal Use - Confidential

