Return-Path: <linux-nfs+bounces-7554-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E39B4ED0
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 17:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90AC31F23BD7
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 16:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712E818C939;
	Tue, 29 Oct 2024 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ehFBvlWr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yf+xhFdU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B3119309C
	for <linux-nfs@vger.kernel.org>; Tue, 29 Oct 2024 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217827; cv=fail; b=ligmw2dOZRjzfhEcLDRcS/nEbZE9m1Ys3c4n++sL6HnB0PEFKY6I6MzDkF2H8Q+AjctyAeoptJ6IQn5ZWnmafbYSKk6xuPAQSed8NDZ7OGbacM+p99iGJnI/lc7WRcQXv0Nl86+qjObXbhKTrFLhlg/jV0e9Mk+uz59uqJbBckE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217827; c=relaxed/simple;
	bh=vm1S8J1qMxoO3Khjp8PItRz/sjEviM0BzM9gVDFMZL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gku1dGPtYiiXvz+2DdK4ywROCHzufrLxKB0hnw0/Kgv0XeJZIXDxA+b2xV6xoTg8WqwMvGZn6DeiC+vmIDnHvcgOR2go6SK4YlWYBmAUtBdWiTFW7YUeFExa13D5+CkV2WobRh3Ri7prqragBBxbhPrVcXtBohrUTEJIQ5opshg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ehFBvlWr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yf+xhFdU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEtc8U026021;
	Tue, 29 Oct 2024 16:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vm1S8J1qMxoO3Khjp8PItRz/sjEviM0BzM9gVDFMZL0=; b=
	ehFBvlWrAnM0ZODd8JW3G78Km+Bud0SWrSCfLkFm93eru1YawHv/08fK93eyhULs
	xTb3rjv3g/miq6xWZGQ2JunfXFIh+2lZo8GjMB9hs6qy6Dk3hcrU7VeyOgEyclS8
	6fOnS47JkY4nplmt/crF1e5suNuJc2tFd0yULaqHW7ktSf7fw5mSEsN1jRO7Yy+y
	0FOeUzy73dk1gyN8OAhzpnUVSmUBqQBRFgMYq2r9M0RPt5tPRksOIPGRV6LQuhxJ
	CbLW5qS8saV6lsRqeZiSJtjNXHfrAwbu93da4vae30vtcqBg9zifAblu/GXfvq6h
	ZgQYZXfijxijhqaDxno6dQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys5xw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 16:03:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TFjN1C034908;
	Tue, 29 Oct 2024 16:03:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnd7vat7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 16:03:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vN/N6m8THHKcV1riYANMc/8sAL8ppcNICSrIcknd5YU3M5K0tOhYuR9DyQIw0SheQ67UndQMCW8BdWSOBcsyyEVUCy1mGw8XVUpxVyLVl9mZaDu5+YKbJS9Mn1rOuhCqE4gTX8dfsECGpJT7MzKlZ+Oorp5Y5NFJxyn7r+A0WVGJH5N8CNx0ehFOAJ4Fjrjk4NnsLGV+ZQ4eOf0HqcuVVFcLwREvrDEkLOYhTaH1xL0H3OLDn1fD63kJFmJKPHUGUDqr1ikJuufjzqKRb4bwDxiqEXIgrqtHPD/TZiuxfa98cKKKu1Ybds/N+q4BzuPwAVZs0GPAoCJqyKZjf0F2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm1S8J1qMxoO3Khjp8PItRz/sjEviM0BzM9gVDFMZL0=;
 b=IM2luEZpR8Ipo4/MqS0Gnfp7xX1bPrD6NcV8TV5gVcQys3ab1i067vuLA5vCIBYjfET7LRtqxvhwLEQ+vPJgENIC0+X/KDgtVVCDS0Wr0RZ9yEVewjpWXe+m/hMnI4K/flNN0zF0GEFblvMf9aiXzeDmlxWw1/oFWi6aHzoAQhTOnF//08elSiI4xlF1PR837aVZLP0jtqhMfUFXYQ1K7UHY84i3RSA6xA/Xm2a6yv1dl3oCdBtTo//24BQ1C+l7EORD9Re+uaOGAg5Jas0vwD1oaUy7bkeqwjHy8nB7Vk58bvMHk4hhm/GxrbPrYmAjtp3hfjAYlqtiSs3GxyfttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm1S8J1qMxoO3Khjp8PItRz/sjEviM0BzM9gVDFMZL0=;
 b=Yf+xhFdUqiBuRhZwBZX+u5zIBxxFLfAaF0Pe1KQ2F9HpizxP77H8Er031XzRcB9LeGACcM6eLSfhktQN6IjZ48BvhU4vHhGoi1EepNUlEE+uJWnJc4EYuvg0gFX1cDi6VxiF4nzJiIePKh/RM6OHXojLfh7GjCV5P4Um9D8Nwkw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4477.namprd10.prod.outlook.com (2603:10b6:a03:2df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 16:03:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 16:03:05 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Brian Cowan <brian.cowan@hcl-software.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4
 reexport
Thread-Topic: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4
 reexport
Thread-Index: AQHbJWR3BlJOXtfJrUiYxWPBjvAIV7KdyhAAgAAD4YCAABzbAIAAAnEA
Date: Tue, 29 Oct 2024 16:03:05 +0000
Message-ID: <91F0EACF-76BC-49EE-9340-AC60F641B8B2@oracle.com>
References: <20241023152940.63479-1-snitzer@kernel.org>
 <20241023155846.63621-1-snitzer@kernel.org>
 <CANH4o6Pi13aEtQW5-vmuJiuCNzx6tjn1+v=pLUpVMuffX-WkPA@mail.gmail.com>
 <7FB2B261-48F9-4DA0-B4B5-E8E30EC31CD9@oracle.com>
 <CAGOwBeX7xw7cPRXGO5RmLQUgzOjqr-7Bh4EhV=hONpXCAqsX-g@mail.gmail.com>
In-Reply-To:
 <CAGOwBeX7xw7cPRXGO5RmLQUgzOjqr-7Bh4EhV=hONpXCAqsX-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4477:EE_
x-ms-office365-filtering-correlation-id: ec99fdea-31e4-49e8-1ed1-08dcf8332c9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXZPNXJjRHhXYUtHa0FqTTNVZEtUTndyZGFLdHVvTkpQUThmUml5K3RoRk9S?=
 =?utf-8?B?Y1FFOXZXRmpTTFhLUGdZZzZCazN5SWVkZlV6NkJjWEZIeHQyMmE0bGc5NDVv?=
 =?utf-8?B?MVJPeFc1alNNYytkU3JwMFNTTGlxMlFsYy83REUyT0YvTHYydXJHdEhnZ20w?=
 =?utf-8?B?VCtzYVFOcThMT1lPYjdxVml4akp4RnNGY1hTMWpKelBaTSs1UUZyN1M2RFJB?=
 =?utf-8?B?K3pyTlpab2VtSlVNVVBPTGpjRTArZVpQU0R1TXlPUXVqOXJSRjRlenZGNis3?=
 =?utf-8?B?aSs1NTVXbFVnK1Uwa0FVUkdReVRkcVFGOFRyUEFqbnhpeWo4K3Q2bTNxSnYr?=
 =?utf-8?B?KzlKT2ZDWDFkK0lQVDFCM3ZUNVZZdnNrQnR6Mm5sWkdlQzdzTEl0M0ZJcHQw?=
 =?utf-8?B?QnZYbzViRjVHZE9pSlpOVUx6cllTV2tzdHdVM2pUbGtLVWwxbmIxYnI5WG5n?=
 =?utf-8?B?ZCtERG1PL2JlU0tuZE5JQXBNZ1B0VVhEQm5nY1J1cmtVTGZobElqbTVBT3Fp?=
 =?utf-8?B?eDVMMDF6QkdMZi9iWkowbXQrbU04aklGaTIvSjNDdHBPZjhQTzZ6N2krbVJZ?=
 =?utf-8?B?cEJTWkhFNm56RGt3SUQ0SXQ4T211YzFiUWtFYWF6RjdnN0l3eWg2c0ZhamJs?=
 =?utf-8?B?MjhEeU9DNXZ3dWJGdURnM0xDRmNNQ21vbGVwRWxyR0NmUFZmNmRFQUpGNjdN?=
 =?utf-8?B?Y2NnY1ZlKzVPd1kwNmNCaDY1Y3MydmUxWi9FaDYrRUx0VXBJZWtCNjBjK2NQ?=
 =?utf-8?B?Y3ZEU1RkblcvVFpvZ3RCLy82bFIvVGZkRHZrTHNzcU1EYWE2Tll1M2lPR3NG?=
 =?utf-8?B?OWNtZU50V0VjL2NFblRJSEhMcml2VEVsUUsvRWgvaStmRzVja1lkbVlaK2VI?=
 =?utf-8?B?bjFoTVRxeS9QTm9pa0Vhb3hhUkY0WFNmNGcwNDlVTHFuWmRIRkZzS01rZldF?=
 =?utf-8?B?aU1Dd3YveG5WOVd0SS9IaFVBRU0zckgyanpSR3Z1ZFh6ZCtickZvMU0xZEs5?=
 =?utf-8?B?QTZtUHdsWXBxOUFYS0cvUmIyQzZ2NlVXMlFZbFJTQmluRUlyZmd3OXB4ajNB?=
 =?utf-8?B?Vk4zeDV2dmRWOTNDREQzY1A1THpTbWMwRU9SUDBxbmVpVEtkdGxPTkY1Vmdt?=
 =?utf-8?B?WHZGdVRsSEl3RUZIZWN4VlNGeGlRVFlRZHpjMTdFMzRQQWxCTk9Pa1FNRmUv?=
 =?utf-8?B?RzQwM2VBSVdZRDlkMFVLZEdIR01iWkZ5T3JwV3B5dHF3ekViemxlbmZqUEdh?=
 =?utf-8?B?NmpMejlvZjVLRHBrMWxWSnBPT2ZyMm42T2ZUNGlESWJnUjlGT1lXZFF2TVRV?=
 =?utf-8?B?UnFQVHd1SzJMQ0tMQnZCRVlwS0FVWlRiM0VOZHE2QWhITERoVkNKUmFlNElQ?=
 =?utf-8?B?OXN5aGE0ODNWMDJZRDdNVmIyMFhJWkFmbS9xOW4wbzJIQng0bFlVQjgxQ3RI?=
 =?utf-8?B?REVPb2dMTCtOWEp4S2hNWGl3Wmw0Wk1uL1hPd0tWSllEcDdjQUJWY2hybDB0?=
 =?utf-8?B?WFVMNjArOGxreUduanRidEx3WjNCUlhWRTRhRVpKcGdhWU11MStoK1JsRy9j?=
 =?utf-8?B?TUNISzhZajVaNGRnMTVOeUlwT2JnUW5MQ00wSDRmYkxLK0RETkZmekVLYTN3?=
 =?utf-8?B?djRGLzgxdXlYQU1nRXUvcDV2NEF1VnQ2UW16eHdKeHBLNmVvT0xBUEVMMW1Z?=
 =?utf-8?B?RHBRSW9UdU5RbWQ5ZmlXU2xwSnJEMGdIanZwNDk5cnpYRWdyNDd4a0dmOWpn?=
 =?utf-8?B?UXlBMXhmZ2lxZXYxUFBTTExMVWN6OTl0a05WTTVYN3h1NWhkMnBFY1hhdVFL?=
 =?utf-8?Q?9UHA7PGFXt9iVWOAE/RGbe71C4PIfnZmI0doY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkNDemtBWW16SHZUeGdrZG1ZTlFJVkJqdXoxdkN0UWJVZTc5a3ZXd2FLZlFy?=
 =?utf-8?B?YWVXU1Q5UlA3dTROM3lIOUdQMHAvMmZnRCsycGpDc0N0c3ZGTzBKaUFSK2Ey?=
 =?utf-8?B?OVpvS2dMZWd0NFpJbGZscFZ5ZjFuNS9kRVRjR0loZ2lFd0lKU0Z5aVMxUTdx?=
 =?utf-8?B?dG9SNDNna3BsMHkrTnVjRVZaNWFBWmVqRjRaOW80RmJHUm91M2lFNC9lTmJa?=
 =?utf-8?B?bnQrUGhjb2Z4WmpyOE1SZE5zeWIwWSsvWUR5Ri9HK2p6OXk0MXRUTzRpZmc5?=
 =?utf-8?B?eVBOckhielNHK0hrWnRWOVA4WEZkN3FrTnNMeERlWk1XeGtIQUwydnpCNGZK?=
 =?utf-8?B?Um5URXRHYi9XWk1iMXp3NkNqd1NPRFVYSTdSaFpqT1p1cVBjdEFLRk5tL3Y5?=
 =?utf-8?B?a3VORGNwdGdGMU5id1EvdXFyL3J4N1ZudFQwbU1ja0o3NC9Hb1ZNdFhPeEMv?=
 =?utf-8?B?T3FEcXptSVRtWUtCVGl6d0FucDhwUmtKRWgwcHNCR3FqYWdPWjRYZ1h2Z2hw?=
 =?utf-8?B?cm1ESU5lQTJMU05XYWNzcXp1eW13YkhBOForczdwNXp0VGJ3bGlRblQwMUdO?=
 =?utf-8?B?YnJmT2RTVHByUFl4WXlDVzFjZ1JWVTZzL3ZROEFycmZsYkZNaTFVQ1FaOVJu?=
 =?utf-8?B?R1BFbkp4d0ZnYmlFMmJWSVFkbkc0TXc1aklvZ3pmVlh5LzRXWUxrNW5vYi92?=
 =?utf-8?B?WCtERWZhR2VEL2VpcU1IcnkzTXVoOFpnYjV0Z1FaR0VFWXRlNFVaQ0lWMCtZ?=
 =?utf-8?B?QzVyQ0lQY1FHY3RWRHZEL050YWNkTkp1VWlSQUFYR1ZkUjI4cjBsdnFyZFZC?=
 =?utf-8?B?eWU4K2JhUitEUGcrc0tKTmluR2hwVWRiSUxJSW5tQzRIM1czZ2hPRzhzQ21Q?=
 =?utf-8?B?Y2lubk9icXBmYlJzb2NzMXJTalNvTFhHRU1Ib29qZ1FvZ01yNXgyVFFTcFd3?=
 =?utf-8?B?d21vL0daQm5zYVFYZDZtYndYbjdXdnFoQVk5T3hKMG43dzY2dG9DSi9Cd0FY?=
 =?utf-8?B?Qy9pMDR3Nnh4aGx6RkRrSm0vVDlVSWhWNEZrd0RoWWlrazVTNW9LT0FJVm1I?=
 =?utf-8?B?Q255RGQwOWJzK0h5QUc1Rjc3VmNjMVU3WDl6YVNqcnZzRXBrQ3luTm1DdDJY?=
 =?utf-8?B?TzdXdnNyeTB2akxvbmRUL2VDV1V5OGhmVG9BTVRqV2JVejJtN1E1MXMvMXB0?=
 =?utf-8?B?NlN0TUIxOWxickhrNnUyTytDcytIeS85bXU2QlkrL1dnKzJEYUl4bWk1MVl3?=
 =?utf-8?B?ZHFIby95dDhmSG9XUjJBSmtRYVBDdUhxLzBFY1JkZ2QvaHBLTjdVbGRyZk84?=
 =?utf-8?B?ZVdwU2FXdzRYWGRmTVFaYmxuOGdzdEk2WmRZVVRKZndFdUNCZURkNkNCRmFo?=
 =?utf-8?B?N0E1U0gxV0JwclpmR0ZGOUp4dmlIanlpdVRYNzlwWUxKTkxZZmxVUS8zZHdX?=
 =?utf-8?B?TWx3MTJybzJiVy9XcW15YTRIUGt4Q05VWHFmZFlEKzdIcFAwMmRUZTRlbDZy?=
 =?utf-8?B?Wm90TVlxL1JJRFcyWHhPWEt0ZitLbUZBcEZxbUM2R1JYT1pCQVpwellodzdm?=
 =?utf-8?B?d3ZnZmVoK2lhUC9pSWtVRlpsRmZ3d0FJWThMUGl4TVNPdnJELzFlSmdiV0Vl?=
 =?utf-8?B?KzFReW9hZUdyd1J2REJOd0huRDJsNVVEU0JKZVlXd3psakYyUlhMcEtWVnZn?=
 =?utf-8?B?Y2psK2dnUmRXWWYydEdvQTRMV3VMbmlTMzlicHNBVkdJY0tObFJvZFJLQm9S?=
 =?utf-8?B?MFAxRFh5a0FCZWI3R1FRZ2pjNkF2SXlDNlIzMUVTWEZGWFdsbE5NZXFzbjRR?=
 =?utf-8?B?M2JpY3FNMjA4SExtekx5NXgxYTZwQ1JGOTBLQlhUM3J0cjNycnN6enJYN3dv?=
 =?utf-8?B?M3JzcnY1cDlicy9uMUhkSlFqSUt5WUhjbE5RMjE1QTBDdlVsUW5tZzE1U3cz?=
 =?utf-8?B?YU82SFdwaVIzRHdBaXJ5UE5oSUUrckwvdFdtcThLeGpodmdhaTkxZjVYNzlo?=
 =?utf-8?B?ZE1Jb0hoanorek0vL3ROemROUnI3MzNsMEs5SmhEbCtOcy9kTldyVXlUL1lT?=
 =?utf-8?B?T2svQXduM2F3STVaeHpqbzJOVVZxanFNTWpCWXAralFtTGZLVDFabjR3V2pX?=
 =?utf-8?B?WW9Ub2c2RC9WajF4dE53ODZaRkpnNFB6bEwveitSWmJnZ2xnMTVhSUJmSXkr?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18A7F29D67DE904CA7E349BF2348D0A4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b1o1j1Gof1oAD1hYqzYPtXnUonF0D9NWt9Ao8EHjNVyLk41Q/Mro+9ZCLqelBqrohgDT3pE436iLF+K/RTk22MJ9fxDheDKAlljpbAJduGc0G+wDkr/F1ubQnhciGv1T65F/znmURov8PG/VqbVjLymFstfMRTFgsmNWUbuzulMQ4al6ZkEz3AVHlrLlL4uLT3swev4wGeaey3VwYjMSTL7y1HgaDCJHwXKpPJwEzt+GWc2y/YGpySuQA0hjxKRIxtYxs/enWFrXKBpkOmT7ctJc5prArN+I9WkxJ7U42altAfF5ZzdLd5qfbuQ6SUZFnsfPSEyem6Me0qvGy3tmTkylXO+LjbkERD0tH5teB8/puSnYmRBL/9q/4v386UaXDfZpb/xDKo+v5lGYpnP8Us7H1uSpabkmr1vBePVgDXBe8yPDe9WCW3AsB1Lz2NXVx1G67P0k5U9oOMg85UuCbd2bV11Pc2ooMqkr0iwiGE78snLXGAothDnhgLk2Yq9PviR8BclG31BdJ5QOi6DROrLtlflKw2bk8MLvmGJi1Z52IsNq5pytAt4a4ULRILev0Xr04ByIDOb4tZL0yp4VDMtnKMt6S6cck1N4MYUNu5c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec99fdea-31e4-49e8-1ed1-08dcf8332c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 16:03:05.4971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7aVfW1r7yd0a7z6CPD7d9Py6hKsMS7rbTwehXhauZVI8P//UJ8TkBz45iy+AFqZb+bJSM9+xYu9JFQd/7yygw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4477
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_11,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=852
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290123
X-Proofpoint-ORIG-GUID: UhWZAI-eXFFxInVAknRhojfNvkmJr_sL
X-Proofpoint-GUID: UhWZAI-eXFFxInVAknRhojfNvkmJr_sL

DQoNCj4gT24gT2N0IDI5LCAyMDI0LCBhdCAxMTo1NOKAr0FNLCBCcmlhbiBDb3dhbiA8YnJpYW4u
Y293YW5AaGNsLXNvZnR3YXJlLmNvbT4gd3JvdGU6DQo+IA0KPiBIb25lc3RseSwgSSBkb24ndCBr
bm93IHRoZSB1c2VjYXNlIGZvciByZS1leHBvcnRpbmcgYW5vdGhlciBzZXJ2ZXIncw0KPiBORlMg
ZXhwb3J0IGluIHRoZSBmaXJzdCBwbGFjZS4gSXMgdGhpcyBzb21lb25lIHRyeWluZyB0byBzaGFy
ZSBORlMNCj4gdGhyb3VnaCBhIGZpcmV3YWxsPyBJJ3ZlIHNlZW4gcGVvcGxlIHNoYXJlIHJlbW90
ZSBORlMgZXhwb3J0cyB2aWENCj4gU2FtYmEgaW4gYW4gYXR0ZW1wdCB0byBhdm9pZCBwYXlpbmcg
dGhlaXIgTkFTIHZlbmRvciBmb3IgU01CIHN1cHBvcnQuDQo+IChJIHRoaW5rIGl0J3MgInN0YW5k
YXJkIGVxdWlwbWVudCIgbm93LCBidXQgMTArIHllYXJzIGFnbz8gTm90DQo+IGFsd2F5cy4uLikg
QnV0IHJlLWV4cG9ydGluZyBhbm90aGVyIHNlcnZlcidzIE5GUyBleHBvcnRzPyBIYXZlbid0IHNl
ZW4NCj4gYW55b25lIGRvIHRoYXQgaW4gYSB3aGlsZS4NCg0KVGhlICJyZS1leHBvcnQiIGNhc2Ug
aXMgd2hlcmUgdGhlcmUgaXMgYSBjZW50cmFsIHJlcG9zaXRvcnkNCm9mIGRhdGEgYW5kIGJyYW5j
aCBvZmZpY2VzIHRoYXQgYWNjZXNzIHRoYXQgdmlhIGEgV0FOLiBUaGUNCnJlLWV4cG9ydCBzZXJ2
ZXJzIGNhY2hlIHNvbWUgb2YgdGhhdCBkYXRhIGxvY2FsbHkgc28gdGhhdA0KbG9jYWwgY2xpZW50
cyBoYXZlIGEgZmFzdCBwZXJzaXN0ZW50IGNhY2hlIG5lYXJieS4NCg0KVGhpcyBpcyBhbHNvIGVm
ZmVjdGl2ZSBpbiBjYXNlcyB3aGVyZSBhIHNtYWxsIGNsdXN0ZXIgb2YNCmNsaWVudHMgd2FudCBm
YXN0IGFjY2VzcyB0byBhIHBpbGUgb2YgZGF0YSB0aGF0IGlzDQpzaWduaWZpY2FudGx5IGxhcmdl
ciB0aGFuIHRoZWlyIG93biBjYWNoZXMuIFNheSwgSFBDIG9yDQphbmltYXRpb24sIHdoZXJlIHRo
ZSBzbWFsbCBjbHVzdGVyIGlzIHdvcmtpbmcgb24gYSBzbWFsbA0KcG9ydGlvbiBvZiB0aGUgZnVs
bCBkYXRhIHNldCwgd2hpY2ggaXMgc3RvcmVkIG9uIGEgY2VudHJhbA0Kc2VydmVyLg0KDQoNCj4g
VXNpbmcgIm9ubHkgbG9jYWwgbG9ja3MgZm9yIHJlZXhwb3J0IiB3b3VsZCBtZWFuIHRoYXQgLS0g
aW4gY2FzZXMNCj4gd2hlcmUgZGlmZmVyZW50IGNsaWVudHMgYWNjZXNzIHRoZSB1bmRlcmx5aW5n
IGV4cG9ydCBkaXJlY3RseSBhbmQNCj4gb3RoZXJzIGFjY2VzcyB0aGUgcmUtZXhwb3J0IC0tIHlv
dSB3b3VsZCBoYXZlIDIgZGlmZmVyZW50IHNvdXJjZXMgb2YNCj4gInRydXRoIiB3aXRoIHJlc3Bl
Y3QgdG8gbG9ja3MuLi4gSSBoYXZlIHN1cHBvcnRlZCBtdWx0aXBsZSB0b29scyB0aGF0DQo+IHVz
ZWQgZmlsZSBvciBieXRlLXJhbmdlIHJlY29yZCBsb2NrcyBpbiBteSBjYXJlZXIuLi4gQW5kIHRo
aXMgY291bGQNCj4gZWFzaWx5IHJveWFsbHkgaG9yayBhbnkgc2hhcmVkIGRhdGFiYXNlcy4uLg0K
DQpZZXMsIHRoYXQncyB0aGUgZG93bnNpZGUgb2YgdGhlIGxvY2FsLWxvY2stb25seSBhcHByb2Fj
aC4NCg0KSSBoYWQgYXNzdW1lZCB0aGF0IHdoZW4gbG9ja2luZyB3YXMgbm90IGF2YWlsYWJsZSBv
biB0aGUgTkZTDQpzZXJ2ZXIsIHRoZSBjbGllbnQgY2FuIG1vdW50IHdpdGggImxvY2FsX2xvY2si
IChtYW4gbmZzKDUpKS4NCg0KDQo+IFJlZ2FyZHMsDQo+IA0KPiBCcmlhbiBDb3dhbg0KPiANCj4g
UmVnYXJkcywNCj4gDQo+IEJyaWFuIENvd2FuDQo+IA0KPiBDbGVhckNhc2UvVmVyc2lvblZhdWx0
IFNXQVQNCj4gDQo+IA0KPiANCj4gTW9iOiArMSAoOTc4KSA5MDctMjMzNA0KPiANCj4gDQo+IA0K
PiBoY2x0ZWNoc3cuY29tDQo+IA0KPiANCj4gDQo+IE9uIFR1ZSwgT2N0IDI5LCAyMDI0IGF0IDEw
OjEx4oCvQU0gQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToN
Cj4+IA0KPj4gDQo+PiANCj4+PiBPbiBPY3QgMjksIDIwMjQsIGF0IDk6NTfigK9BTSwgTWFydGlu
IFdlZ2UgPG1hcnRpbi5sLndlZ2VAZ21haWwuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiBXZWQs
IE9jdCAyMywgMjAyNCBhdCA1OjU44oCvUE0gTWlrZSBTbml0emVyIDxzbml0emVyQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPj4+PiANCj4+Pj4gV2UgZG8gbm90IGFuZCBjYW5ub3Qgc3VwcG9ydCBmaWxl
IGxvY2tpbmcgd2l0aCBORlMgcmVleHBvcnQgb3Zlcg0KPj4+PiBORlN2NC54IGZvciB0aGUgc2Ft
ZSByZWFzb24gd2UgZG9uJ3QgZG8gaXQgZm9yIE5GU3YzOiBORlMgcmVleHBvcnQNCj4+Pj4gc2Vy
dmVyIHJlYm9vdCBjYW5ub3QgYWxsb3cgY2xpZW50cyB0byByZWNvdmVyIGxvY2tzIGJlY2F1c2Ug
dGhlIHNvdXJjZQ0KPj4+PiBORlMgc2VydmVyIGhhcyBub3QgcmVib290ZWQsIGFuZCBzbyBpdCBp
cyBub3QgaW4gZ3JhY2UuICBTaW5jZSB0aGUNCj4+Pj4gc291cmNlIE5GUyBzZXJ2ZXIgaXMgbm90
IGluIGdyYWNlLCBpdCBjYW5ub3Qgb2ZmZXIgYW55IGd1YXJhbnRlZXMgdGhhdA0KPj4+PiB0aGUg
ZmlsZSB3b24ndCBoYXZlIGJlZW4gY2hhbmdlZCBiZXR3ZWVuIHRoZSBsb2NrcyBnZXR0aW5nIGxv
c3QgYW5kDQo+Pj4+IGFueSBhdHRlbXB0IHRvIHJlY292ZXIvcmVjbGFpbSB0aGVtLiAgVGhlIHNh
bWUgYXBwbGllcyB0byBkZWxlZ2F0aW9ucw0KPj4+PiBhbmQgYW55IGFzc29jaWF0ZWQgbG9ja3Ms
IHNvIGRpc2FsbG93IHRoZW0gdG9vLg0KPj4+PiANCj4+Pj4gQWRkIEVYUE9SVF9PUF9OT0xPQ0tT
VVBQT1JUIGFuZCBleHBvcnRmc19sb2NrX29wX2lzX3Vuc3VwcG9ydGVkKCksIHNldA0KPj4+PiBF
WFBPUlRfT1BfTk9MT0NLU1VQUE9SVCBpbiBuZnNfZXhwb3J0X29wcyBhbmQgY2hlY2sgZm9yIGl0
IGluDQo+Pj4+IG5mc2Q0X2xvY2soKSwgbmZzZDRfbG9ja3UoKSBhbmQgbmZzNF9zZXRfZGVsZWdh
dGlvbigpLiAgQ2xpZW50cyBhcmUNCj4+Pj4gbm90IGFsbG93ZWQgdG8gZ2V0IGZpbGUgbG9ja3Mg
b3IgZGVsZWdhdGlvbnMgZnJvbSBhIHJlZXhwb3J0IHNlcnZlciwNCj4+Pj4gYW55IGF0dGVtcHRz
IHdpbGwgZmFpbCB3aXRoIG9wZXJhdGlvbiBub3Qgc3VwcG9ydGVkLg0KPj4+IA0KPj4+IEFyZSB5
b3UgYXdhcmUgdGhhdCB0aGlzIHZpcnR1YWxseSBjYXN0cmF0ZXMgTkZTdjQgcmVleHBvcnQgdG8g
YSBwb2ludA0KPj4+IHRoYXQgaXQgaXMgbm8gbG9uZ2VyIHVzYWJsZSBpbiByZWFsIGxpZmU/DQo+
PiANCj4+ICJ2aXJ0dWFsbHkgY2FzdHJhdGVzIiBpcyBwcmV0dHkgbmVidWxvdXMuIFBsZWFzZSBw
cm92aWRlIGENCj4+IGRldGFpbGVkIChhbmQgbGVzcyBob3N0aWxlKSBhY2NvdW50IG9mIGFuIGV4
aXN0aW5nIGFwcGxpY2F0aW9uDQo+PiB0aGF0IHdvcmtzIHRvZGF5IHRoYXQgbm8gbG9uZ2VyIHdv
cmtzIHdoZW4gdGhpcyBwYXRjaCBpcw0KPj4gYXBwbGllZC4gT25seSB0aGVuIGNhbiB3ZSBjb3Vu
dCB0aGlzIGFzIGEgcmVncmVzc2lvbiByZXBvcnQuDQo+PiANCj4+IA0KPj4+IElmIHlvdSByZWFs
bHkgd2FudCB0aGlzLA0KPj4+IHRoZW4gdGhlIG9ubHkgd2F5IGZvcndhcmQgaXMgdG8gZGlzYWJs
ZSBhbmQgcmVtb3ZlIE5GUyByZWV4cG9ydA0KPj4+IHN1cHBvcnQgY29tcGxldGVseS4NCj4+IA0K
Pj4gIk5vIGxvY2tpbmciIGlzIGFscmVhZHkgdGhlIHdheSBORlN2MyByZS1leHBvcnQgd29ya3Mu
DQo+PiANCj4+IEF0IHRoZSBtb21lbnQgSSBjYW5ub3QgcmVtZW1iZXIgd2h5IHdlIGNob3NlIG5v
dCB0byBnbyB3aXRoDQo+PiB0aGUgIm9ubHkgbG9jYWwgbG9ja2luZyBmb3IgcmUtZXhwb3J0IiBk
ZXNpZ24gaW5zdGVhZC4NCj4+IA0KPj4gDQo+PiAtLQ0KPj4gQ2h1Y2sgTGV2ZXINCj4+IA0KPj4g
DQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

