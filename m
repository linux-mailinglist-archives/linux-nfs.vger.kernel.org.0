Return-Path: <linux-nfs+bounces-3879-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB190A1C7
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4901D1C20E84
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701A263C8;
	Mon, 17 Jun 2024 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="MMQCi9Eb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2135.outbound.protection.outlook.com [40.107.92.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDFF3FEC
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587712; cv=fail; b=XHwwn9Zhp/FseNnPaK6zui/PC8qNs+cXeg6oQoPUkRYRaLlpr74z2ugiD8b4u1oE24y6NW191YVek6fSU+OHsla7XvoOvaZrLyar4v/j3IW8fAUsM5vSsLVl+OWKGLweFwp75nDnpEncRD1UqV92BNBjgEaeVHLlmwZO7Q33NAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587712; c=relaxed/simple;
	bh=6Y8A3MwQSDUqiilIqJcIoXhW2o06NC+wBp973Rj6BxU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W7qwo7CLggxp0A2KDeG4Ruidq+89iumUmRY+a720xZBA4DduHMznT4QHFLEnckx/nsVnHzcvK7y9oY3IOOmmGsCzE2KJOSLYGBbBjHjdSkkeUOK1L7IG19h78rlUExk+CGl+DuaXhSuYWCi9qewLYfojUc9CPNhCqclgDdoWfw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=MMQCi9Eb; arc=fail smtp.client-ip=40.107.92.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7UxIeaj4zTLx5+ebDNrZGjZ32+/kbLIW5YJ0MQ4rL4W/MNGFfhY5coIW/3GzVI02V06CHo0wj7BMnL9Ph/9BGR9gw8WF+XQWq96G/adcqayADov5Uz75S19YN2wIP1FqRhqq1BBN7/pCi1sU2LpEl6/x5TCz+UvayFhDvN6ZnrHMcKwmWqHFlUB6YXVAUig2ECuDFmYmukVskGYCf/CQHm5z/XJN9fr8srJeDovnA7on05WcCDUjHKYFFZ2CoRHa+3o62fBuK0PTDT/URmIjz7KF0XMoodTzI6iqj5/VwiUgTR6IDnUNZbC2I4Ss3JZoJrbyd5NEjEoVmZrzJHGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Y8A3MwQSDUqiilIqJcIoXhW2o06NC+wBp973Rj6BxU=;
 b=ZgGx1Ryq2nMokIKiBE+1SFjT5eEV2jLsW3AF+CdP2RgNDMJyIHMxnGiY1iIojwIxABVLfdpnPytB8NUoLp8gjcDAYSFqV1OzaFUOgD+NbLpf7C3R0Ozx7rHNdXrXAIWG2/3I6zWAxQgD1Fs8hGypy8jzM95YPP9YrFhuI2A/WU/Qdqrqz7xCYgNTxvdzr9Frfvqr3DWDP1D5QITWHC38HZj6GDASJ0p2gKXE3UhsoxBXRFBnBAmiQawyv2hIkKhS2n6mWm7PL+XiO1rKg4M+qoC4RF8V/ebb7+LjCz2AG68j5TQd+z8HftYp1GrZHJC7/NAb6JlPE8zCYjocxA2BFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y8A3MwQSDUqiilIqJcIoXhW2o06NC+wBp973Rj6BxU=;
 b=MMQCi9EbM1f8bF8MbVMK3ta8HEyApG7RDtu/2phBHV5PBomTNCEKbQI+TfZ+vgP+Tw8XsTRcJCvuCupZd0P9cUoKRI0kwNja/VMOYblcBVCVlj2Cmo4fjbPL1vQXqAbCKxhdQTpmPB9NUGungSYFJ9UqL2RPz4W3kaOK4fVDlZs=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB6710.namprd13.prod.outlook.com (2603:10b6:806:3df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 01:28:26 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 01:28:26 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 00/19] OPEN optimisations and Attribute delegations
Thread-Topic: [PATCH 00/19] OPEN optimisations and Attribute delegations
Thread-Index: AQHavUioZqKm6B6YgUKrt2AZ38xbzbHIXx+AgALRmgA=
Date: Mon, 17 Jun 2024 01:28:26 +0000
Message-ID: <ebf1bc0ca71f8f90f2737d0b974165cb4cb3201a.camel@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
	 <Zm0z5RW90ucxfHSa@infradead.org>
In-Reply-To: <Zm0z5RW90ucxfHSa@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB6710:EE_
x-ms-office365-filtering-correlation-id: 1d41663f-5f1c-47d5-2d93-08dc8e6cc917
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZzE0RHFzMS85OWhJSWhyMDJsWEc1UDM5OGQyd2FTWmtodW9oNmEzM05uNkxk?=
 =?utf-8?B?eFJIdXh2amNoZkRpekpGWi91VXlvcGptT0RsMHkwZ3ZuMW1WVUt1R2NRNHBV?=
 =?utf-8?B?WmYvNVZnMmFrakNmUis2L3p3WkRiRE80ZDBDeTZmSmRjNGc0NVBQdVJRcXd6?=
 =?utf-8?B?VXJicmlCNFM3My9saEhKM0dJT0laOFNaNjV5d09iempiRzRhanhmS0YrQy9l?=
 =?utf-8?B?Wnc5NXNtYWw0TFloU3F5T1pRanh6WDBFM3lLWmVCQkxZWHNDa1h5TWxSUVMw?=
 =?utf-8?B?cHd5WTU5MmRMbVh3aE5jM1ZkLyt4TnNWMnhtc25HZERiVEM1ZXhjVkYzWDB3?=
 =?utf-8?B?aWtyc1pRY3lweGlSazB0Q2h2SG5sRUxvdE80ZTYzbDQvTWo5OHpwSjJBSWNs?=
 =?utf-8?B?bHRmS0NPUnlUWVRCNTFQQ0xZNDdmWnlyZmpEN2lLaTlIZnRMcFNGUkN0bEJG?=
 =?utf-8?B?ajRYKzdSOXN5UjhJQjR3LzVQcGo2QkxTOGRPbnUvV3lHb2NNK2NuTTkwN1VD?=
 =?utf-8?B?bS9mUWp4TFRQaGZtUVE4clppL1FycEJyMk80YzNieFJlZFpIbGJ5K1BJMjR0?=
 =?utf-8?B?R0hmaTJnTkdGMm04Nm9QUVUxRE9md1Y1cURRNENzdzNyVHJ5UTA3R1VDZHVh?=
 =?utf-8?B?U095VFd5RXUrLzZHeDFlMmRwWjJlYUVvSjhVYWgxTElHZ0xxSXljUmZ6aG9z?=
 =?utf-8?B?MEhmV09FbGRyVkI3b0x1a0lCZG1mR2RHNWFZR1dlekxlZVFqWXdDNWV6UWlq?=
 =?utf-8?B?TkdoR0RmeDAxaUtJUHUvWm9hREhPUzNCU21oazlud0VxUlFyUzZiQS9sVVNV?=
 =?utf-8?B?elR6RjFSckJSNFJsbUxrelBoWnJUVm5MODNaK281YnVJbmNIbW9uejNhVTZn?=
 =?utf-8?B?dW5NeG4vN05kNmMyZTc1MkpwRzhZOHVYTEphZDJRZ1loUHFLY21QR1MrUVUv?=
 =?utf-8?B?SHNhWVQzMzFzMWpnaDZERUJVMTMrVjdsNHllbHhpaDRvcmZkVGZBeVIrOE5k?=
 =?utf-8?B?VGVTRlp3V3c2T3BzQmNtREpYRnR3b2x4UWJLY3BiTmNDRWk3c0xEK2FSVlRy?=
 =?utf-8?B?WEZnTUVXdGs0c3BPcEIzaWt5eFdnQ2hzWE5PdHdTRi9pUzgwNDVocElvejJ1?=
 =?utf-8?B?YjNHWFVYMi9FZVcxVk1JR1lJYk5rUnQwa1laNmNWbHRTem9ibWw0Ny90dG5N?=
 =?utf-8?B?aEJBTnorKzg0bzhtTDc5bUVra3BtbGlINW5vVkVSeVRybTFrQXVFV2E3b2ZP?=
 =?utf-8?B?MlRsTTE0QktzK3FqRm9zc2V3cWJEMFFkeFVpZHkxakFiTHZYWmM5bTNlWGdD?=
 =?utf-8?B?WHR4OFQ3c2NpeVZEK1ZLRGdobVFrK3dIRWtURTA4UzhKSWgyUzk0ck53eVFs?=
 =?utf-8?B?TFlLK2szMEo1bEd5bzlWNnMwQUIyQ1E1UkhReWRESTZXOUVOYjI0K0FWMDRH?=
 =?utf-8?B?V2lIRDB0anVaREJ2UHhSd1pocXE3VXBsZUFzUUNBVXROSE1ZNndkdmVtU3FX?=
 =?utf-8?B?eWJOVzFhcGUvWUxkOHkrZzdMNEhxeXlLeGZlaHgvVWtTenl6RWtPaVlEM216?=
 =?utf-8?B?cW9yS1BSQWVWVEhEUDNJREp1QjduYTNqMTJQYTdlN3BnbkZJSmJlSWZ6VzZH?=
 =?utf-8?B?WEt3bHlEalF6QmRCZEprRW1HSWs1eEVVczQvL29JMG82NjIrMXJtbkVsK2ZI?=
 =?utf-8?B?azh0Vm5iSndCbmM4STNaNE1TSTVFUGhGdFpIanJLVWdVZ2lGSEtQMVV0UFpH?=
 =?utf-8?B?RUllSExVbnVnb2tNRllmaGxaZHdZdCs0Y2lGaWRVYWFwcjllb2ZEbENId2hT?=
 =?utf-8?Q?BQODAZliQTVurP6OslvujDov9HojfezaKzAy8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L1hLTWJ3bnV3cWMwbEw2dXZvZVU1dGVuYk5xTHFpTzVqNHF5NlRxTUxUVnln?=
 =?utf-8?B?UnFWZTl3K2UwbHd0VFBnMWVJZFJYMTNoMFBUZ0dpUDNJTWNxdlJMbmlWZFFK?=
 =?utf-8?B?YmFlOHpnYXp2cGg1OFdTUHpubHdHbmN5Z01UTzJyMzlxVE9QQ1JpMk1jSFNE?=
 =?utf-8?B?dlhpYnhBYXhtVXVvTitJeXpBY1dGM3hSd1ZSWVZEdlV4ZjdDNy91VTdVMGxB?=
 =?utf-8?B?MGVNSlNpcGFDZDZxRDZWSWtmZmNpdmhQWVpBS3pyZE9IVFc2KzhiQ3VSMzNH?=
 =?utf-8?B?WElEUkZRNkh0Wkllc3Q4UUtCbHFiSUVEVmxuNUJwNUZZOWUreUN2d1lXblVI?=
 =?utf-8?B?bTJBOTJyRnhMNkE2NlNRakNncE40MTh3VERtVHR5Tmh4Z0tlaG9OQkwyei9K?=
 =?utf-8?B?ZDU4TmpvM0RjS21hSHU4R25tL1J6dFoxWjRiMFp6bTdVMEFZWlgwZ3VIRDdx?=
 =?utf-8?B?L3FvTWVXUlM2dEV2UjNhWnhic3Z5anFVMFBUYlZGTC9BU1o1UjU1eHIzMTFv?=
 =?utf-8?B?eUtOTEV2UU9DM3B4QVN6VVB3MFpTQXpEeHBZaStibXF4ejdLZXNCRFlGQTI5?=
 =?utf-8?B?dGNNeUlJUjV5cUhmTDNiZHVXTlp4OWVOWXRDczNJaVIrWEMzN0FjdDBnZ01a?=
 =?utf-8?B?N0UwaGNiLzI1azhySW51SGZROG1lWWlmM0xodERKc1dJOFlWM1ZvN1J1dFdu?=
 =?utf-8?B?Y25rK2JVU0IycVhNbnc0OTI5UXFYaEg4OHZubG5JM3I3dFk2SWNLZGdoV2Zx?=
 =?utf-8?B?Vm9SSDFERHp3WlR2ZFlKbjBLazRTUTd3bllmMG1UT0JBZ3dvQTFYVmgyYUdy?=
 =?utf-8?B?U0tBVXpXM0I3NHVQSDN0amJFenBUQkV5ZWJJaVJRSGNaSzRVSmlxWnlOYW5G?=
 =?utf-8?B?ZG9tR2JOTzRNMG0wbGZPdG4wS2ZmNGdBZzFVcGFxSEthdWZQbXp3WmhRdEcv?=
 =?utf-8?B?WDVybTdta3h5aUt1UVlnSGdEMWFQcGdvdWlKdzlCL1FScHlFcGNuR1FHMFlF?=
 =?utf-8?B?ZlNQazFMK2V5THc0MDFQS2dRN0pvZUx4SFJPc09WOTZXOUt5aUQvRFluUG9k?=
 =?utf-8?B?UEl6V2VJeVdlN3YraytObGVXUkt3eVJWSFVlbkdXVWxEZ2FVTkRmY3duRmVX?=
 =?utf-8?B?eUt5WExGWjBqRzgvcmxEK0ticVNCNHgya2dEdDhIZ2FMbDZPSmdzb0FqSmNT?=
 =?utf-8?B?cWV5eStURVFwUzYrcnBSL2lxbk41a2pIbzQ1ZmJrTlpwOHY4NFd1Mzc4Yi92?=
 =?utf-8?B?ejNZYlZEYi9aWVF4dHUrcEVmTW9TQlk1QjNkZTUxbTN4eCtUdlJ2YVFrZWFL?=
 =?utf-8?B?blVHbzYrMU42MjlGYU9JbEZSNEhPL2Y2emEvcys0aWN6b1hMdFQwcHRtdGo0?=
 =?utf-8?B?WjFFNzFhY2wxSUJtaHdlemR0czdoejdKZ2FDR2FNTTV2SnZtVUNoZkFrWDk0?=
 =?utf-8?B?ODlQZWFYRlRja2tBUE53TkgwMXBOQUlEMHg5Qkg0SG4zWTVpWEswRytWc3Bv?=
 =?utf-8?B?MUlObjQ5SWtpK3VNTWs2a0JKN2cwd05LS052UW5mYzVGNWY4RWswZzE4dk5i?=
 =?utf-8?B?Uk9FM3p3anRtNW90QXB4SW9FRzdQYVROWW4zSWYxME5FWGpDSS92NjJaT2dL?=
 =?utf-8?B?U1VhK2dDYUQzYWVsTHZ2Q0hHVDZ0Mm1Zd3dmZm9zY2IvaHhSLzdQYzNhKzRM?=
 =?utf-8?B?SDZMK0R5NmxCdXNWcVZwWUZmSzFSTWJXTi9aNTczWFFXSGlyOG5rdjlIdnBZ?=
 =?utf-8?B?YzJNM3ZrbDZwYzkrM05tZ1N2c3BubWpoMEw3d21DV002dVJMUzV2RGh1VnJB?=
 =?utf-8?B?b3RDcXhBcmUxRHBBZFJKdlZQakxVY2o0M0ZOMWVZT1NqVStGUWx2RmszM0Zw?=
 =?utf-8?B?TnNKdFdqSzdCc3FHZ1NpSmlmZ2hZZDlOS05BWkRpK1NMak9Kbk85MFhtWUdp?=
 =?utf-8?B?cGRQOTg3Nnp5SEU0Z3pQbXFtUWIzMHppKzZEUTY5UVN1cHhLYUc3dzQwSWdF?=
 =?utf-8?B?KzV1NXJhaWpCV0d1Rmp4R0tRWlVzSEh1ZUNrRWtUUDNaUDUzY3dIZGVPYVpJ?=
 =?utf-8?B?TlhNVnFUZkJDQkEyUGRFZ1g1YU8rZXRVbnpzSzI1SzNOQjk2clIxY3hTK2hz?=
 =?utf-8?B?MFRRbTRQNnFOZGI0ZFZPeHpmREtwQVhlSjZ5ekE0Q2JMdVRqdWNJMlhGdTRy?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <334C8AE334E13A40964673A06C91C22A@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d41663f-5f1c-47d5-2d93-08dc8e6cc917
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 01:28:26.0692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09fP+i2m1pX/zH3tsDmPOkDWRYcNNL1usZVZHqP2RBHWDVXc7BVHWm08nPBBe50lHLtDwa16LYIBf9VgWit9lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB6710

T24gRnJpLCAyMDI0LTA2LTE0IGF0IDIzOjI1IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gQnR3LCB5b3VyIHBhdGNoIG1haWwgdGhyZWFkaW5nIGlzIHF1aXRlIGJyb2tlbiwgaXQg
cmVwbGllcyB0byB0aGUNCj4gcHJldmlvdXMgcGF0Y2ggaW5zdGVhZCBvZiB0aGUgY292ZXIgbGV0
dGVyLCBsZWFkaW5nIHRvIHJlYWxseSBsb25nDQo+IGZha2UgcmVwbHkgY2hhaW5zLi4NCj4gDQoN
CkknbSBqdXN0IHVzaW5nIHRoZSANCg0KW3NlbmRlbWFpbF0NCgkgICAgICAgIHRocmVhZCA9IHRy
dWUNCg0KZ2l0IGNvbmZpZyBvcHRpb24uIElzIHRoYXQgbm8gbG9uZ2VyIHJlY29tbWVuZGVkPw0K
DQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

