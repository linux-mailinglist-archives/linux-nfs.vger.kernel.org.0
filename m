Return-Path: <linux-nfs+bounces-6949-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C892D995607
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 19:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24848B2A1AE
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 17:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F148E20C498;
	Tue,  8 Oct 2024 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PB0PErv0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2122.outbound.protection.outlook.com [40.107.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F59F1E0E0D
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409862; cv=fail; b=qroxQaDfW2hUy8plodTtAQKSBYMjsHuUf9mLfzTm1CGMvnErldmGB4e/HxmFpwxuzPHDs8deJXCQm1QSorTW66eTQ8S6nhBotb8YceF8wnJGedL4SYmcFG1cT/IlIZ8Xn25oAwly/kWCH1gJ7eVldfrI79U8KzwrXmnMO0d2NP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409862; c=relaxed/simple;
	bh=M4dYuJpQFb+4JkhOMjIfUNLQtQIsNJUFQcbBInCwDg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NgjCGLr/r7yed+nkysxVWKZS/QbiNoqhQrPGwioVxhEbt9SVuME53DhhQPMdBX355LkArbFpFuqcJNulN38QXZUn9oOG+asXXOyjeQWIRn/cuTAX1jHC7L96B7k8kC0rVR7o6sYWp/UmWfWNWud6g20Xjww7ywzMbz+cL+MUV0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PB0PErv0; arc=fail smtp.client-ip=40.107.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCWnlwKLhFlUa8a/0lbaaFbUE1EhFWFR8FXzs0QGxrIUsWeLj5YsRvCRBIzDlG3gu9Kz9O58/Evct4WzY1wCUL7yuRptFt1IvHvgMxoyyHAGaTuRIofds1nzNKbMDVduwpaGG4/LnS/x2Y6hT9dUQTF6WhsLFRLLv3YHp/dPwbixzGYJW8qk/XqoV1RX9Vz9JKnGOJ+v+A1tsQzw9OzF4k2tEacIhD100f+jkEZMEx4ZEHr8xRlBgDrccWPZ1BsgbR9sGZ+qd2014Lg1UzuFcnhMPwuMLqsOu6L3bX5fuNVaHJKRaRbIpWujw8WDkDkN0BbRlmPbHFSWvCsL0p9RaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4dYuJpQFb+4JkhOMjIfUNLQtQIsNJUFQcbBInCwDg8=;
 b=emMYfa959HxkP93KFSkOUnRxAFQKUeMT0Ft84stLQxEeoVAPPMQod1VbfzJ15k33DHl7RQ7wGc2dQNEuL4CHgA2oI3sxapIeyILib1xdv0DHgADBN7icQ6t+POSTVJPBnYokFAUE7TfuuQdXzeSx5m7/XN9Gm05eVdDVoR3eGdCVOsdVlfMKOP565UjAhAVK9Lw3ZrlsF4wBbK5mSQmG9npUSyiU4eh54+96dI3QqjyolX4wV/PUeX+Kfstu4BTf6P1jHxkbkMGX4KezbGbSCOOJh/b43Nx3E+Qrzg6MV7xPD0kkamrYaIZOt8/bwjShT4ChqXYX2r0bTw7h+meCvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4dYuJpQFb+4JkhOMjIfUNLQtQIsNJUFQcbBInCwDg8=;
 b=PB0PErv0suQbsk/xkHBA+Z7nmJJ9BttEQRxMJUP34WOAI0YujbDYRN37pXqvSqP0bSVL/pcRbf4mN1OGZ9B4I/IQcjlBTt5zGpevGfmcbawAPaVlDoVjbQ7QqPLZ5g2sIAqgX6PpPdTofVN6yPXLtp7tKR/qufd6T7XonnYC/So=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ2PR13MB6141.namprd13.prod.outlook.com (2603:10b6:a03:4f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 17:50:53 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 17:50:53 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "dai.ngo@oracle.com" <dai.ngo@oracle.com>, "anna.schumaker@oracle.com"
	<anna.schumaker@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFS: remove revoked delegation from server's
 delegation list
Thread-Topic: [PATCH 1/1] NFS: remove revoked delegation from server's
 delegation list
Thread-Index: AQHbGaNTtBSG2Bx6cUi/B8hqfFgCOLJ9IfQA
Date: Tue, 8 Oct 2024 17:50:52 +0000
Message-ID: <a35e31e53c87c96cee9bf82ec4727ee793931789.camel@hammerspace.com>
References: <1728406678-16857-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1728406678-16857-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ2PR13MB6141:EE_
x-ms-office365-filtering-correlation-id: 3933977d-07e9-4584-3b8b-08dce7c1c0da
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3VzOWdhZFc5SmIwMmRGREg3ME04NkEyWFF4bG5sUUF6TXE3cFlHeStLaFY3?=
 =?utf-8?B?STFERTFjUDFUN0VsM0pNdGJ2UnVpeWY1aStEVGZsOHB0OFJOenhLQzVQQzZ1?=
 =?utf-8?B?ZDNwa2VTbmVlSXJsUjMzYTQ2VytmeFFsMGk2b2MrRVpJV3B1Y2NMTUJzMUpV?=
 =?utf-8?B?TG9jWTJNSnhvbG11N0MzRGErM2xnZUF5b3lOWkt5ZERPZ2RaT25Bc1QyMmd1?=
 =?utf-8?B?Z1BBSHM1TzIxYlFhaXp1UVpCWkZZUCtuUlVSZWNNbEZROVh0V3RDTDR4Unlz?=
 =?utf-8?B?U1FOWmRYVzFGTzZ0a3VaVGlNY2pBZVhHTHZsc08xRWprc2VLdDRnazd4RnVy?=
 =?utf-8?B?RDh1emYrUHcvVzZoaWVBY1hyMG95ZkQ2OU1jTXZ3eTBMbDV3ZEZ4b1BvMm42?=
 =?utf-8?B?eTNnQjdhaTFWR0dRd2FaTm5ZMUVFaURnejdrOWpQcSt5OHUxSlhhSEs0S3J0?=
 =?utf-8?B?UitpMURnOE03alM5Znp6NFZnblpvbERDeXh1SERTTFEvZXlDWU9YNWZCMTQz?=
 =?utf-8?B?d1V0cnpGUUpzNjVnTFA3Q1VYQ2lCWWJOazQ0cjZscy9CaXFtR2phRitMeXM4?=
 =?utf-8?B?M2dyTENWenlaRmlaRk9LNlJOVGFDcllzUWtvaXJicnJoMXNiWDdDelpXdWM3?=
 =?utf-8?B?MmNGRi8vMWVoYmZpZUN3UmtTczc2YjNnQjBwZDdBMWdTWlV2dHhETFJpVDdE?=
 =?utf-8?B?WG50TkxYaWRIemE0cEtCSFhoc0ZhbnppYmIyRmtkeFI2K2tnSVRieTNGcU4w?=
 =?utf-8?B?NFY4cStGbTh1R3EvekI4WThZSWg1QnQzaE9PMWp1RHhScHI5QlNZSXV4d3Mv?=
 =?utf-8?B?V25uMUJmQVNKTDhhZ0hXZVdBQkJ5bDU4US9FMWNxdFFBd3IwSlBmeTZwN2Nn?=
 =?utf-8?B?Rm5rVkQrNmlFTHExa2k0aFk1R1B5OXVUSnRQZndIZ2RYNURXdmZvaFpRdm9r?=
 =?utf-8?B?b1pLZWtxQVBIVU0yUnRuamYrVlQwTnNkYlp0NDN5VW9BaTlvaU5lUC9jWDE3?=
 =?utf-8?B?U2o4bWVoUG1RMHh2REpFa3hDNDJCMGx4ZE5NTkZScDkxRXI1d1k2ajBPTHly?=
 =?utf-8?B?eVg1ZmJEQ25TbmlmTGtHSUtjd3BJanZBUVZ6bXh5MGVXY1RhRGN5a0ZwYkdt?=
 =?utf-8?B?OTRDQVpFUkpsbTJiNjF1dU5Yb3ZwUFJ5M0xwWVVVUkRkSUFVak5IODRKQVpa?=
 =?utf-8?B?U0xwbWNMRDdHYzRBdlRKYzRGb1lTbVltSDU1S2tEV1pHSHEyaGExbGk0Zm5T?=
 =?utf-8?B?YnV1TmttVWVZYW0vUklqUUR2N1dwSzdMWnkyWHlRQ2lKVmhaZkJCY0tYWGNS?=
 =?utf-8?B?Ry9kMEtwR2xRV3BkSmN4djJub29FN2hBZEF2dmRGNnV0V0orSWpXZGt4RC9O?=
 =?utf-8?B?QklrT2xFR1YwZkV1ekxhckNkdG8yREwxWUQwY0k2YVhIU0RHNUVPMEZUU0lr?=
 =?utf-8?B?RVJRTkdBK1ZFdm9RYWEzR0JPeVBIR0pDOXN3Z1U1UTBDL25scWQ2RktxVFkw?=
 =?utf-8?B?dDlqR3I3M3cyOE5PSzZyTkQ0ZzhQVDZFMFdOVUY5YkFPYU9maG5jSVBtUDdw?=
 =?utf-8?B?RCtxSVRSQU1tVXRqalkzV1lQczkxRWFaVUNoeXVlazc3WjBwV2ZwL0N0VzBz?=
 =?utf-8?B?eC83czV3UlVLcjZaV3I0Uzg4R3JocGpKbWgrOGNEL05SRzh1WFNMRjVsd1BE?=
 =?utf-8?B?V3g2b3J1UnNsTVBFQVIxQmMyYW5VdXFuOVl3SThBcWl5eTFUQzBicHBnamZp?=
 =?utf-8?B?NXpLNjdWK0hJekVmdlArMjRZa1U3M21lYzFORDVucndjc2sxMXRyV2pHWW90?=
 =?utf-8?B?S2UwajNRMXN4U1k3bjY0QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXpPbUZseUpNZ1JXMEVpOWFuN0ZkVTdUQ3Npc2ZOdjVCaVVZZDdoUEI3STFI?=
 =?utf-8?B?UmM2U01ZdkhZKzJKVmVQWUpFbnNDd1BycTRhSldNanpxT3RMOXdvUkEyU0xC?=
 =?utf-8?B?RXpJd1M4eUhBYUYxOUtBdkpERWpLbHFMcHU2c1Jsdkt0WnlaQTM3aUtrcGw1?=
 =?utf-8?B?VnhBWFpNbFcxUTBRVVh1cjkxRU8yTUZ1dzg3QlNEYVBDNSsrbHNzWENOR3VP?=
 =?utf-8?B?bkI4YTFSOUJHMGlnUUlhb3pxb1M0aE8wV1V0WWFoU09Ycm1XN2E2N0RwYVpR?=
 =?utf-8?B?SlV5cFB2TjkxKzlJYWd3TDdpZHFpdXRlYXgyK1dGMkhNakdKUXRFUHFzdGhm?=
 =?utf-8?B?QUh2REtyU0Erc3ZSTnJ3TTNPeStUeG5nek4xYk1GRDE0YTBJQkpydGVRQVRy?=
 =?utf-8?B?N2YxRnFRNWN5WDE0Y3hMa0JmL29tNmtVVFU3d0FYT0l6VjlFRkxuV3Nhak02?=
 =?utf-8?B?NEsxcXNNbTk0UUVLYTZjMENSSG5PRjZpb1BrdDBOYTdzckUxYUFsR3B2UGly?=
 =?utf-8?B?WmNtTStuSldEa3ZlZG5XT1gwTjlJVUtOa1pWRXBnNFhXQURsYzlIS0dGMkpS?=
 =?utf-8?B?TS9SRnN0U3pHL2JKS0tOOUVydjdpalN0Y3VpWDI0ajJ2LzFKTHI3dGhhRXhU?=
 =?utf-8?B?eXFVTlZ4M0UrQzdQZnFRZ1FLYjR5eVg1ajhaQUlEQTlhUnFHNzczdy96UThz?=
 =?utf-8?B?OGljVWJaeUJkejdJWGowVVhlb0lpNkhpQjFKMXlJeTkxWG4yTjFTbUlFL2x3?=
 =?utf-8?B?K3IzMSswaGEyQ2VHa1htMXFxblZSL2RIUERINXEvWVNjbjZ5R1NLTjZtY2RU?=
 =?utf-8?B?K0I4NmF0N3VwcFhONU8yS0tUTjZtRkZ0ZjV2NmcrRGUxT29kYURBeCtLcVRC?=
 =?utf-8?B?ckY4MVFuRm0vaVFRejhoUGZ2eU9UTVJ3T0VjUUk3ZFgwVWFWSWZnM3RYUXdZ?=
 =?utf-8?B?dEdOQmxIMURkSzJUZVp2bjFweW9XbFRqVk5pNnoxM3ZKMS9MU0RQUlRhN0E3?=
 =?utf-8?B?Mk5NTjV1MU52MzVhVHZvdHpQQVBQMW16WjZDMnduUmg3blVDSi8wblArUjl3?=
 =?utf-8?B?MisxdWFKbUZaZWJYdFQ5WUtoQ0JrSXl2dHFabHk0ZmowY05FRmtNaEJHQmpF?=
 =?utf-8?B?c2Viditzc3JWYlNIYU9TWElER2R3MmRDWTdoK0ZFTzRlSnN5a2dJbFNpZ3NJ?=
 =?utf-8?B?SFVnbDZRY0ZQdzcyaDJLTTdFSFFtQTR4UHRlNjJrU1NDK0lkM0JSbU9xZUNL?=
 =?utf-8?B?M3BQVmR1UlhRR2tSZ2g5cWxpVW1EMDFDMTlCR1JjZk4yQ2ZIRnljVlNCa2pV?=
 =?utf-8?B?RUhsQVhNRjZBSi9kRUxIRkxyRWlsSHRXRy9aajNCNlgxSkQ2eUVsWEo4S2tv?=
 =?utf-8?B?bExEK24yRVNsdmZtZ2xTREhSV0VFVG0wS0FjV0NjYkZUWHVGekZDYm53STRt?=
 =?utf-8?B?a0VRWXMxdnR5OXpDVnUrYVJVVFlxRmI0Yi85Um1ieG55SXhCQzNOSlZ1Y0ZE?=
 =?utf-8?B?d2ptWG1rZmt3VkpoS1lrZFFpanUyaEpwSUZ6eEdPaW1odlNTYkdlbGt5VXhE?=
 =?utf-8?B?dmpYSHVXazJCSlU5cktLVnpBdFlObFU4aU1hNjlzL0ZtMEJrNzd3NjlyN2Er?=
 =?utf-8?B?VjdHUlJ2aDd5dEZXRjJyaE1YZG5VWXAxRks1L1o0TU40bU5kOWdYMTl3bVY1?=
 =?utf-8?B?b3dWWGVBY2NlQ2U1M0p1LzhVWVNJeFZLQ09SVmtPUjdRVUhuMFI1TWJTY2RN?=
 =?utf-8?B?ajdVYkZuY0k5RUZQMHZEWmJRa0kxWGxvdzhkaDFFUDNFVTVvN25aTkF6Ym1n?=
 =?utf-8?B?WURwUVlZNE9SREo0MTNRZTFieGpIcHplczVtZk5YV09PakFGOXMyT3FudDJR?=
 =?utf-8?B?Zjd5WHFNT0w2cjhzZWNtdlBsSjgrb2I3VE9sRmxab2pTaWF3RkxmQ3dMQXNB?=
 =?utf-8?B?cDd1emQvMjg3US9PaXFNaWZMUGEvRmo5U2xxdjFkQnVXd3NEdUwzYlpka3E1?=
 =?utf-8?B?bHJERDBmeFhqeWpQV010UGlPeU4rV0ZZSzBQRlVYMzdFNEc2d2VQNUNMMzZo?=
 =?utf-8?B?Z3I1RlpFRmNOa2ZBMUNkaVhYYjQzR2ZVS1VtOEx1R1FFQmNablNFbldWZHFD?=
 =?utf-8?B?czc0K0ZWVnEySU9tUzcxMmpXRnFmWDhxdGpFR3BPc2JhOFZJZUVTK0F5cU9R?=
 =?utf-8?B?QWh0VFhQUlRrZU5xek9lYTUyS1dPamdVZzhoNEg5Q3J6dG92dnB0SE4za3dt?=
 =?utf-8?B?dUtXQk1DT3lFUjhDK1poZlJTT013PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D00A336C02F15E42B27709C24D2A9CB5@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3933977d-07e9-4584-3b8b-08dce7c1c0da
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 17:50:52.9548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/vKv+XxcxNh65i9EPkJbXVZAh4LVkoo7XrmccG1qF/EGexs/Voi+J270Z9gPbxqwdrPhXH3yvdcy3p/bvABmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6141

T24gVHVlLCAyMDI0LTEwLTA4IGF0IDA5OjU3IC0wNzAwLCBEYWkgTmdvIHdyb3RlOg0KPiBBZnRl
ciB0aGUgZGVsZWdhdGlvbiBpcyByZXR1cm5lZCB0byB0aGUgTkZTIHNlcnZlciByZW1vdmUgaXQN
Cj4gZnJvbSB0aGUgc2VydmVyJ3MgZGVsZWdhdGlvbnMgbGlzdCB0byByZWR1Y2UgdGhlIHRpbWUg
aXQgdGFrZXMNCj4gdG8gc2NhbiB0aGlzIGxpc3QuDQo+IA0KPiBQaWdneWJhY2sgdGhlIHN0YXRl
IG1hbmFnZXIncyBydW4gdG8gcmV0dXJuIG1hcmtlZCBkZWxlZ2F0aW9ucw0KPiBmb3IgdGhpcyBq
b2IuDQo+IA0KPiBOZXR3b3JrIHRyYWNlIGNhcHR1cmVkIHdoaWxlIHJ1bm5pbmcgdGhlIGJlbG93
IHNjcmlwdCBzaG93cyB0aGUNCj4gdGltZSB0YWtlbiB0byBzZXJ2aWNlIHRoZSBDQl9SRUNBTEwg
aW5jcmVhc2VzIGdyYWR1YWxseSBkdWUgdG8NCj4gdGhlIG92ZXJoZWFkIG9mIHRyYXZlcnNpbmcg
dGhlIGRlbGVnYXRpb24gbGlzdCBpbg0KPiBuZnNfZGVsZWdhdGlvbl9maW5kX2lub2RlX3NlcnZl
ci4gDQo+IA0KPiBUaGUgTkZTIHNlcnZlciBpbiB0aGlzIHRlc3QgaXMgYSBTb2xhcmlzIHNlcnZl
ciB3aGljaCBpc3N1ZXMNCj4gQ0JfUkVDQUxMIHdoZW4gcmVjZWl2aW5nIHRoZSBhbGwtemVybyBz
dGF0ZWlkIGluIHRoZSBTRVRBVFRSLg0KPiANCj4gIyEvYmluL3NoIA0KPiANCj4gbW91bnQ9L21u
dC9kYXRhDQo+IGZvciBpIGluICQoc2VxIDEgMjApDQo+IGRvDQo+IMKgwqAgZWNobyAkaQ0KPiDC
oMKgIG1rZGlyICRtb3VudC90ZXN0dGFyZmlsZSRpDQo+IMKgwqAgdGltZcKgIHRhciAtQyAkbW91
bnQvdGVzdHRhcmZpbGUkaSAteGYgNTAwMF9maWxlcy50YXINCj4gZG9uZQ0KPiANCj4gU2lnbmVk
LW9mZi1ieTogRGFpIE5nbyA8ZGFpLm5nb0BvcmFjbGUuY29tPg0KPiAtLS0NCj4gwqBmcy9uZnMv
ZGVsZWdhdGlvbi5jIHwgMTEgKysrKysrKysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9kZWxlZ2F0aW9uLmMgYi9mcy9u
ZnMvZGVsZWdhdGlvbi5jDQo+IGluZGV4IDIwY2IyMDA4ZjllNC4uNjViMTBmN2VhMjMyIDEwMDY0
NA0KPiAtLS0gYS9mcy9uZnMvZGVsZWdhdGlvbi5jDQo+ICsrKyBiL2ZzL25mcy9kZWxlZ2F0aW9u
LmMNCj4gQEAgLTY0Miw2ICs2NDIsMTcgQEAgc3RhdGljIGludA0KPiBuZnNfc2VydmVyX3JldHVy
bl9tYXJrZWRfZGVsZWdhdGlvbnMoc3RydWN0IG5mc19zZXJ2ZXIgKnNlcnZlciwNCj4gwqANCj4g
wqAJCWlmICh0ZXN0X2JpdChORlNfREVMRUdBVElPTl9JTk9ERV9GUkVFSU5HLA0KPiAmZGVsZWdh
dGlvbi0+ZmxhZ3MpKQ0KPiDCoAkJCWNvbnRpbnVlOw0KPiArCQlpZiAodGVzdF9iaXQoTkZTX0RF
TEVHQVRJT05fUkVWT0tFRCwgJmRlbGVnYXRpb24tDQo+ID5mbGFncykpIHsNCj4gKwkJCWlub2Rl
ID0NCj4gbmZzX2RlbGVnYXRpb25fZ3JhYl9pbm9kZShkZWxlZ2F0aW9uKTsNCj4gKwkJCWlmIChp
bm9kZSkgew0KPiArCQkJCXJjdV9yZWFkX3VubG9jaygpOw0KPiArCQkJCWlmDQo+IChuZnNfZGV0
YWNoX2RlbGVnYXRpb24oTkZTX0koaW5vZGUpLCBkZWxlZ2F0aW9uLCBzZXJ2ZXIpKQ0KPiArCQkJ
CQluZnNfcHV0X2RlbGVnYXRpb24oZGVsZWdhdGlvDQo+IG4pOw0KPiArCQkJCWlwdXQoaW5vZGUp
Ow0KPiArCQkJCWNvbmRfcmVzY2hlZCgpOw0KPiArCQkJCWdvdG8gcmVzdGFydDsNCj4gKwkJCX0N
Cj4gKwkJfQ0KPiDCoAkJaWYgKCFuZnNfZGVsZWdhdGlvbl9uZWVkX3JldHVybihkZWxlZ2F0aW9u
KSkgew0KPiDCoAkJCWlmIChuZnM0X2lzX3ZhbGlkX2RlbGVnYXRpb24oZGVsZWdhdGlvbiwgMCkp
DQo+IMKgCQkJCXByZXYgPSBkZWxlZ2F0aW9uOw0KDQpUaGlzIGlzIG5vdCB0aGUgcmlnaHQgcGxh
Y2UgdG8gZ2FyYmFnZSBjb2xsZWN0IHJldm9rZWQgZGVsZWdhdGlvbnMuDQoNCldlIGNhbiBkbyBz
b21ldGhpbmcgbGlrZSB0aGUgYWJvdmUgaW4gbmZzX3Jldm9rZV9kZWxlZ2F0aW9uKCkgYW5kIGlu
DQpuZnNfZGVsZWdhdGlvbl9tYXJrX3JldHVybmVkKCkgaW5zdGVhZC4NCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

