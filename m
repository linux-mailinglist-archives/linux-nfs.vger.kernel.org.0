Return-Path: <linux-nfs+bounces-10793-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5405EA6F456
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 12:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB4B168C73
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 11:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52868255E3D;
	Tue, 25 Mar 2025 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Vxmzk52+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2116.outbound.protection.outlook.com [40.107.223.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6C19F111
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902596; cv=fail; b=IevJ8L8NrOWLiemYdfn/2tmudqmukWiBovHev0+TOsbfTsNhpfFH5sAIZ6CrVJAZ9UGH9CyM1whfSpVnFWAuqjSZ/XiTCOBAG6amqwUyc2zE9cf8xlsA/9NWyW+Z9UBI6Wln/4inAaJembb8ikW4tM1TvrLxu+PFWwnghSM7Z5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902596; c=relaxed/simple;
	bh=rHTjEJiEoSFnb+cj27APyfJ/CFZuTz+DoCT8Be+uOKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C59i6dExFo3tUPdNEaFs0aIfDjORhr/wFbtvgWHeYABmZIK/qDG2rlbZvR2LLEmjeCorc/z/MLx6dOHL/kWH4Ht8ADtalG+D5r1n3+G1DNeNDBraPsK9C6dQUSkv8H95mGY5EXAj2M/jl2PHOAA1BhfsYfKO1JsdXlosyGIGuW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Vxmzk52+; arc=fail smtp.client-ip=40.107.223.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEWhiCUIShhrrbxrkhWH4xJaP4/SD47tz4ZHzVcnJjDGe3rT902d3Ps33fw37Ulfxz/nG+NblFqawYAOpWQP2O3TgNa+g/otLfHyy99Bxm1UmSHjBOJcKYc2akZteK4wBFlvV4P8FOXfYe4nKxd4xZ1Ku/4IAB6cENdFm6WKNPFJGczvhLePGNiV+3EKTOmpJHYM1sYviGGGKPThZq9jVXfHp/BHotvtZB+OlL1/GzHanTYwzvJw6jORlRxYZeL6EhsUEV7CDMNWmPK0M0FkbrWwD9xhf66sPANPHbmCBqGOee2wWy4ic9Hqcp6XlQicVXdqgdAFBJ/4AA+HGciy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHTjEJiEoSFnb+cj27APyfJ/CFZuTz+DoCT8Be+uOKw=;
 b=pOcRDtERQRpOeL2xtuUOGmc9ZHAhsIfwKLc2n6ZiB4Of8CxttFjP0qBvdnB57gI+A0iJ+JT5BKvO6rrzs/VMHrVzkuVVdCmSWx/EflJ/N4dRWdrOF2en75ZfigkuqKeNVxfa+l4j2S2kr7VJ/S5DT0nVy20ZBHNTUW8RcWpgOJBbz/Rs8TJehdljDbab4PVBo8Fy/196L5P10CrGIGw8k7+vyiaATr8stEKgz5HkEakrsn4OpKGwoFufvnMmlNrtUkWTmWkjW/yem04CQnyHFDZPYp8q20ITELGZQ1i3fJYyYp0pl/Ef67wbgB12X50BZiyr/AvQ67obITfPKO/qmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHTjEJiEoSFnb+cj27APyfJ/CFZuTz+DoCT8Be+uOKw=;
 b=Vxmzk52+qxh/Mv5tjvQcXu5n6/HMbvefjr65M7y+49hM/A2niSBbqx3FFls8s9IaLamK6+F81As9wY/iCuIax3Xpg3FUzDA9SWkH2Wp9nuHtNZ0u3C3dYB1tu9XK6bNut5eor7gijKvsxkBBWuJ4frgI11R+IHYxh8bLzbG1y14=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by IA2PR13MB6786.namprd13.prod.outlook.com (2603:10b6:208:4aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 11:36:30 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 11:36:28 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>, "jlayton@kernel.org"
	<jlayton@kernel.org>
Subject: Re: [PATCH 4/4] NFSv4: Treat ENETUNREACH errors as fatal for state
 recovery
Thread-Topic: [PATCH 4/4] NFSv4: Treat ENETUNREACH errors as fatal for state
 recovery
Thread-Index: AQHbnR9yrLKXcTkiekiZ7N4E2w54SLODugkA
Date: Tue, 25 Mar 2025 11:36:27 +0000
Message-ID: <7920f2e437aef041d54568097ad29a7b945588c1.camel@hammerspace.com>
References: <cover.1742863168.git.trond.myklebust@hammerspace.com>
	 <4855d263e403a8b56738f2f630954348718d7cc5.1742863168.git.trond.myklebust@hammerspace.com>
In-Reply-To:
 <4855d263e403a8b56738f2f630954348718d7cc5.1742863168.git.trond.myklebust@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|IA2PR13MB6786:EE_
x-ms-office365-filtering-correlation-id: 1528fbd1-5866-48df-2951-08dd6b91480d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?amF3OCtLVmNFQUw4RDFKRHU5LytkcXY5SnBKWUMyNW8yZkhyNHA3REhYQVlv?=
 =?utf-8?B?NGRUSk1tTXNJaU9FblNDYWZZMlp2S2M2d1N5SlozbjFZVEhGS1ZRb29PaktO?=
 =?utf-8?B?b2tNWmhhbk1jTE84TS9vdVVBcGo5WGFES2VLWGdZQzUzbzFYSE5pYlUxWTla?=
 =?utf-8?B?RXFBYkl4VUE5d1FUZlQ4ZVVvNnlTT0pBYk1HS0dGYXFSUC9ySm9QTFZmUFNP?=
 =?utf-8?B?a2dwMUNocWtjOXU4ajVpREVDeUdwdi9sQmowMG55aGF6OVAxRkJmYnBZck5n?=
 =?utf-8?B?aEFxbm1zUWR5Wmw5dmkvTU5kNjJ5cC9YVlQweXBZdkxjUTJUVVp4M2VNU09R?=
 =?utf-8?B?N0F4L2ZmTTFRV2pxbHZpTHM3SldKRkExMjJaUSsvMHNzOFFOQUFUNzZDWW9D?=
 =?utf-8?B?S3dGRkZsWDNuV2hQalpmRTNJa1ZrYjhBNXZkQktTQ3RoMW1LQlFqa0dLaFFF?=
 =?utf-8?B?d2pMZHV6UWRRZ0xwTjNwdDIyZDB6aUFFOEs5bldhNjhVNHd6NHZaQjNJcXNN?=
 =?utf-8?B?eGRGTnhEdWFvblNQVUVENTB0ZkxaYzQ2c09RZ0N5S21PcTAxdU8zMTZ0L3oy?=
 =?utf-8?B?R2xqS0RjY3l1cUVIQlF4S2NyU3UrZDJyaWNjejlxTktJYlFBSUxBUjFRdUJi?=
 =?utf-8?B?RWJITGdESFVsSitlVEo3TlNoZ3lhRHloOURtRVRhK2N6bUJ2L1Y1eERkbzRX?=
 =?utf-8?B?aE9kaSt5UG15RzNHMG5KSVNXczIyOXVDRTliQzd5T3ZyNFVHRGx2NTRRSTds?=
 =?utf-8?B?ZkRSMmtBWUlpcU9LYVQ1eGRzWVdzeU1SWS9uVGhEZnI5NXJwbmlObDJRVHRD?=
 =?utf-8?B?cnM4dkh5a1RJZVEwTXlXWFEyVFU5eHRkQ3FXbSt3aEptRWlGMDRQNm1GaUMw?=
 =?utf-8?B?ajdZV1A2NDMxRjNYR2hZZG9PRDZybExxN1plMTVqUlNDbU8yQy9sbXdxWDhh?=
 =?utf-8?B?eituOS96NUloMUhrQVZIVE9sbUFMUVFlR1UwRUxjVlNCRmpycXp6UTZBbFZ4?=
 =?utf-8?B?TTNLdUtRZVUwdGV1Ky9xUEZOWlBSS0R1SDErTFQ0RFRYZVhKMGhBbUNVamcv?=
 =?utf-8?B?VVMxVEd4RVRnOGl4NFdyUVA5ejlwaHVKSDkrNGZFNGNSQ2M4RC9iS0VQc2Fz?=
 =?utf-8?B?NEVFTUc2YmhYdG1MUlB1S1pZc3BaOHdDdWdKYjJGWUJGZFhvbnhSOVUvVWZF?=
 =?utf-8?B?eHlWcU8xbXUyUlVnaE5GNUduWk1SNkdZTVRoVmJRSCt6ZFBIcFlvdmo3dlVN?=
 =?utf-8?B?bDFuRU1GK2NJTHNhckppTTAwMngxVmxtaGNvbUdPdUlTYk0zd042cmNWaVkr?=
 =?utf-8?B?azRlTXdKWUk3bHN2RzVrYzJHajNNS0lWM1JMQURTSlZlRk9rQmRSYlNJL3Z0?=
 =?utf-8?B?cW50N3NjMVZYcmhKQU9SRDNYemtOQ2o1VHA0aS9ReTI2dHZ5T21ob0xtNHhk?=
 =?utf-8?B?SG1FRHptbjZuZXk0RnRNYkZOcHdFaUM0K2RrbE5SR0NGUkFaMjg2MUNpRHNi?=
 =?utf-8?B?NXNNZzZ2QTdsSllNRGo0ZUJYc21iRmtnMXY5U1lIWHE1djNieFpUOEQwbHIz?=
 =?utf-8?B?cENSa2tvR240OGMxYlAyV0wyWUJsMVBlTFNOOHFJTXJsdTMyS0ZaTkkxSStM?=
 =?utf-8?B?YjdpcHF0dXE5SlVUQUF0OXg3UWpEc2IyRkpSMnk4K3RST0FaVStWb0JZcFNy?=
 =?utf-8?B?aXJ0Mmk1Yno2WVlHQ2hEQS9sZC93blFtZHlDWGx1alc3d01KRHFyVnBOQVl5?=
 =?utf-8?B?Mi9EZWR1Skw1LytYZU1HMUQ4S3pKR2tuRGhndkpRU2FMUENMbkhFczFpYjNH?=
 =?utf-8?B?M2wxTjJCOWFobDFwMXV3K0ZOdS9CNlNBTXFUQmk0c2JFcksxOStKdFFKd29k?=
 =?utf-8?B?YlFuOWNuUU9FYjRhdGpGOTN6T2gveWUwQnR6aWFkdk9xTHNtWHh2dWlWdGJH?=
 =?utf-8?B?VW1JMkVnRERDMCtVcVhQblFRL09NdURvY05ybFNvQ09oNDJ5S2thY1J4QTd5?=
 =?utf-8?B?MlZWZTZTeW1BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eE15cXhseDc1ZVcwUFlwUnl3VENlQ05VTCtIR2VUQnZ1YzFVOWFTMkV1cmJG?=
 =?utf-8?B?MTJiRFlTWTA2OHVTUXFSNGZKcU4xYk9BMXd0bVJWYmdmMnVDV2N5STUyTlNz?=
 =?utf-8?B?enBLL3Rsc3hQNGxudEdRR1dOSmplcUdPMG9lVEtJNjYwWTdnTG84Tk85ZVJS?=
 =?utf-8?B?WmRHUGhYQlhxMi9teSs0emMwQ1ZvQndYT1AxZ3oxb3NiMWZhYU9Jc1ZyVDV3?=
 =?utf-8?B?MFFXR3BDRUZSZTFNaHQ0a1N3dWMrNFAvTlZLeEIrclNOdWViV1d6bWtmZ0xB?=
 =?utf-8?B?akdFeStSaXowMWxDT0NYajZ3elNMTGJ4UGtnaG1DZTZLbWZoQ24xY09wRTZm?=
 =?utf-8?B?T2pmcGZObVdGWUxsaE1FMXd0KzlINTVZWXhhZ0ZQY3did3ZIZGlwc213TmRi?=
 =?utf-8?B?NE5WYktxUDFucmQzMDJRdFZKUys4d3h4ZEJnWVg4Wndnb1c3WHlpOVIyOUMw?=
 =?utf-8?B?aHRCSElSQ3RZbkVWakZoUXB3RVkyL3BpWlRMeE1GSzRubTdzamp4N2doRU4y?=
 =?utf-8?B?cEtCbGQ2U3NDTXQvSFVxTXlVUGFDL1k2V2RZMmZIQlg4bERuTE84dVFSMFhn?=
 =?utf-8?B?bVZ0SkhaWnFSL1pQVFFmR2dzMy9CYkNKamJEVGV3dTlhZFdZaUlNbXlpQVp1?=
 =?utf-8?B?Q3FaTlQ2V3dJcnB4dnRmSE5qNDNvYno4RWNic2xwUWt3Q3hkbmNLOVRYV1VP?=
 =?utf-8?B?QWNWTkRzLy9RNUg0RENyWWpreDNoRUt2cUdnSFowRjJqb29iWS9iM2xvMC8r?=
 =?utf-8?B?bUthSVVMNGJpWjlqdEpkN1ZxUG10cDJhcTlmWVBVV2t6SXU1bUtmVjBDTjFN?=
 =?utf-8?B?OWJocTZwZW9ta0NuOG5ZVS93STJJQjVlL3NWTUZ2bnVjLzVsT29KZmxpRnJ0?=
 =?utf-8?B?dVBxUmcwQjBXZEwvVm8zb1RlNm80RXRRQ04xM3VYYlgvMHRhU2FTQ3AxTG1W?=
 =?utf-8?B?ODRBblpXWHh1anhXdUZ1M2kzTWdNUWlUeGJEMHo4VHJWd3ZTQld3YXJYNnAz?=
 =?utf-8?B?OW8zVUNJQ3d5NGJIam5nQXBUU1RNQjNPWXl6dk82cVphQWFSSFcvdDE3MStr?=
 =?utf-8?B?WDFUTW5CcHNwSURwUE5NY25QcDJGYUs5blBKZEx5ZDFiMFgzN0xDT3NBZWlL?=
 =?utf-8?B?enRyR1cxSzVlSCt3Z3RsY0pnb3crVzZmZlBJVFBjVFZkQlRWVkZWcVV1ZkZG?=
 =?utf-8?B?MzVpOVFKYXgxOThQYW5DbktiTjRWRjAxNTBiVlFra1AvUlJQczRnRjZBajdv?=
 =?utf-8?B?WDJ3bngzOTNCeW5BWUJ3UjhmVW5tU0VPc041SWFJdDBIN2tFckN5eGt4S2RT?=
 =?utf-8?B?by9TdUtnQUZ1MnZXNUNoN2hNYVBJTmVtMjJkSzdaVDBCZG5WcmZQKzJ2WWI0?=
 =?utf-8?B?THN6akNjRTQ5dGN2MU15d1kzRmNWT1c1eUs2U0t0bDJVNmh4a21XRFVMS1pU?=
 =?utf-8?B?WDYzbXdsNU5DK0hWb3RDZGZ0T3NVdFpUZkZKS1pJYlphYmNXMU1MQ3hRMHJk?=
 =?utf-8?B?UkJSVlhzc0szQkxEbWVERk85K1RCZi9WMERQeHdPdVk5eWQ5ZGNsbXFIZ3Rh?=
 =?utf-8?B?R3FUKzdiYVZ6ZkM0R1lPUk1GZHZYS0lLb1BNbDVpbnhwV1F1WGkxUktFYUVZ?=
 =?utf-8?B?Q0I3VWNtTWpkSFF3RVdYVmpSZnFNdmVIUTBkSFlEVi9vdTJpQzN4a2ZEanJn?=
 =?utf-8?B?K1g5OXRIdjJlQnVzaEx5a0lodkE3bG1hYkJTZ2lOUGxlSWRVdm5XWUo5VWJq?=
 =?utf-8?B?ejU0aVd1YTZadlZtTk51MUVwSTFmVjY4cjFud0ozQXhEZ2NxMFlBTXp1ekRl?=
 =?utf-8?B?aVFrK2JHVlc4R3FxR0s2MTBTUU1VZ0wrVENwL1huTHYwenNaeGx4YnA4clJH?=
 =?utf-8?B?bG1SQnNBVloxaWVYUW9HOFRNY3VOYlNmRmg3T3VJbnZPZ0JxWU4yT0FWQlZR?=
 =?utf-8?B?OEUwbGVEM3N3a0xIYytsR2wzalJIcjArbWV1QU5Rc2t5dGxZSy9NdzAvUXRy?=
 =?utf-8?B?anhid3YvSnFLSUUvVXdUMWVTYjBwdzVUK3YvSE1lMFpWb3drRGxodDl6eDRW?=
 =?utf-8?B?OGNaNkJlbjNheDQ4cnR3L2ZvWmxYY1cxaElXdDFEaVprS3dwbk4wL2hTdE5x?=
 =?utf-8?B?QnN1UWprb2ZDTGdaS1hvYklNSEpwQXFhNzBxY0dqV2JPc3lmMFRUNUZHVHBK?=
 =?utf-8?B?UmMvY2JpU1ZDeVZSOVRHdklFRjVvNGVLTGNmQVRHTFBpUHJLZmN2cGFvbFI2?=
 =?utf-8?B?M0lTSE1EblNFQUd1R2ZsQ3RSNldBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65B70B257C0DEE46A44B5ED4C46D55F6@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1528fbd1-5866-48df-2951-08dd6b91480d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 11:36:27.9425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TFsYq5KinfhnP4ciLL20n1XWk1Uc+c5TCJrqxXOpwgISNNX+rVbUpz103XOJKVJYKkAc13mF+1jx4bUI50hYOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR13MB6786

T24gTW9uLCAyMDI1LTAzLTI0IGF0IDIwOjQ2IC0wNDAwLCB0cm9uZG15QGtlcm5lbC5vcmcgd3Jv
dGU6DQo+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbT4NCj4gDQo+IElmIGEgY29udGFpbmVyaXNlZCBwcm9jZXNzIGlzIGtpbGxlZCBhbmQgY2F1
c2VzIGFuIEVORVRVTlJFQUNIIG9yDQo+IEVORVRET1dOIGVycm9yIHRvIGJlIHByb3BhZ2F0ZWQg
dG8gdGhlIHN0YXRlIG1hbmFnZXIsIHRoZW4gbWFyayB0aGUNCj4gbmZzX2NsaWVudCBhcyBiZWlu
ZyBkZWFkIHNvIHRoYXQgd2UgZG9uJ3QgbG9vcCBpbiBmdW5jdGlvbnMgdGhhdCBhcmUNCj4gZXhw
ZWN0aW5nIHJlY292ZXJ5IHRvIHN1Y2NlZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBN
eWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+IC0tLQ0KPiDCoGZz
L25mcy9uZnM0c3RhdGUuYyB8IDEwICsrKysrKysrKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25m
czRzdGF0ZS5jIGIvZnMvbmZzL25mczRzdGF0ZS5jDQo+IGluZGV4IDczOGViMjc4OTI2Ni4uNjI5
NTc4ZGQ0YTQyIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvbmZzNHN0YXRlLmMNCj4gKysrIGIvZnMv
bmZzL25mczRzdGF0ZS5jDQo+IEBAIC0yNzM5LDcgKzI3MzksMTUgQEAgc3RhdGljIHZvaWQgbmZz
NF9zdGF0ZV9tYW5hZ2VyKHN0cnVjdA0KPiBuZnNfY2xpZW50ICpjbHApDQo+IMKgCXByX3dhcm5f
cmF0ZWxpbWl0ZWQoIk5GUzogc3RhdGUgbWFuYWdlciVzJXMgZmFpbGVkIG9uIE5GU3Y0DQo+IHNl
cnZlciAlcyINCj4gwqAJCQkiIHdpdGggZXJyb3IgJWRcbiIsIHNlY3Rpb25fc2VwLCBzZWN0aW9u
LA0KPiDCoAkJCWNscC0+Y2xfaG9zdG5hbWUsIC1zdGF0dXMpOw0KPiAtCXNzbGVlcCgxKTsNCj4g
Kwlzd2l0Y2ggKHN0YXR1cykgew0KPiArCWNhc2UgLUVORVRET1dOOg0KPiArCWNhc2UgLUVORVRV
TlJFQUNIOg0KPiArCQluZnNfbWFya19jbGllbnRfcmVhZHkoY2xwLCBzdGF0dXMpOw0KDQpBY3R1
YWxseSwgdGhhdCBwcm9iYWJseSBuZWVkcyB0byBiZSBuZnNfbWFya19jbGllbnRfcmVhZHkoY2xw
LCAtRUlPKSBpbg0Kb3JkZXIgdG8gbWFrZSB0aGUgcmV0dXJuIHZhbHVlIGEgZmF0YWwgSS9PIGVy
cm9yLg0KDQo+ICsJCWJyZWFrOw0KPiArCWRlZmF1bHQ6DQo+ICsJCXNzbGVlcCgxKTsNCj4gKwkJ
YnJlYWs7DQo+ICsJfQ0KPiDCoG91dF9kcmFpbjoNCj4gwqAJbWVtYWxsb2Nfbm9mc19yZXN0b3Jl
KG1lbWZsYWdzKTsNCj4gwqAJbmZzNF9lbmRfZHJhaW5fc2Vzc2lvbihjbHApOw0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

