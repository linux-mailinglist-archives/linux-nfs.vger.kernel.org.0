Return-Path: <linux-nfs+bounces-13867-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF3CB30A89
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 02:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616771CE5912
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 00:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D9514A0B5;
	Fri, 22 Aug 2025 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="HL91C9h9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2125.outbound.protection.outlook.com [40.107.102.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D05347C7;
	Fri, 22 Aug 2025 00:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755824264; cv=fail; b=uxIIE5U4SeW9Miu26nTcqUhUKjC0HQcLBGBpsOWYgnDvRoniLQeDEENSrumaZcmlj1pFwPKFYspjuMpUGpj9Ln9asIXxJkwTH+a95U14zAkCSkwbY7ssGUSNd4TdPIkBYkLYtfrJ0YyVt8xf5NK8HRWAEIghbkLw8j1+GteTBtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755824264; c=relaxed/simple;
	bh=zAFZ0zRlMVoCWbDB7Gm1u0g9rDydqtbdn2AbTlJik2U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hwH8y6hY4A/5fGf60FoQJcBaCcRmm1FfyvG3mldYUJkUkT3z8nmeQW6IBWxP4SKBERpjlHWfDgNFtoNMOrx6vXaLMpe/CL/ebqIrP6Wq4K9MXFOGHPMvPbRVWAJpaUpJ+Z/q9uits6tz6h+rXfhsemDCLcSp7i40tq9OytBcwVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=HL91C9h9; arc=fail smtp.client-ip=40.107.102.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWtc2WelYgkgDFVsSMCISULpoCEoM34PHNFgnL6zU5HdykM8ztZlCy+TUTwxj4OjaljEpTBMKjYiDDPT0gtxehBsnLp7+wCpYpKcGdG1wLjdVPzewNXFTl0/Ld9hQ3bBYn6KN3sbI4S4A8m+7/B8JHBCGKbUVW5ICM1L9VXbqm++MxqiXQfrDx/Vg2tJXPJ9W9NSxygzmn7OeEwgenVjZ8F0hiQdhAfDyZBUVQ/QuTtVF5aFJYyvYR78lhvxFWZbrxshgiW3kGzNaKzZFkO70j7UWh+pgQ/m9HXKSF2WH2E9UGNv77eqiUqBrO3XYUwou5MzFdX/XAn0dM8T8Oo9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAFZ0zRlMVoCWbDB7Gm1u0g9rDydqtbdn2AbTlJik2U=;
 b=DA+aHc8OEeXMAEdW2RQu1K+pS+m7aMr7/eDZsN9iVP0K13jBliPlKY+FgqOxC4it6Y0cK/jROzh+GsSylsS1cBVjCI1IEipWoZ6FjeuYWzIztVSsQj8GDSwfR+ydIWaK0tJm/ToUqKYJA7myO1/7GfyqIzbLXirIfj2jR8nU62Gl932uecTU6MGf85V09B9Dl8fX0MH5wYJS43J+iPr0HwRokrF/q8HTwF7STonu/BpfZbv6HMBn4i4sd0uNkrsgvDc7/01Rip2hv+mEUehGQpbFzbjBZ6aWODHiyya5COkqgXrbMUFcuWa7qogdUxzRgfTL7YWlXdhlJ/dQ0B4L2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAFZ0zRlMVoCWbDB7Gm1u0g9rDydqtbdn2AbTlJik2U=;
 b=HL91C9h9qk0kw1U4lN/au8oRiVpg+JjIoDUlFRItH01GzCizshJ4UOR3xjx14PyBt7DPvSjNC+rK3hktdcLqKwwNG19ELrXXSRS3iOB+hx1S0oM+qPt82Uy4Lj5fm1HccSv/yMDvfX+Cp5ZL/KWHnt2luOllAKQCYeSJZBfBd/0=
Received: from BL3PR13MB5073.namprd13.prod.outlook.com (2603:10b6:208:33c::7)
 by SA6PR13MB7136.namprd13.prod.outlook.com (2603:10b6:806:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 00:57:39 +0000
Received: from BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::26de:13be:e67a:3671]) by BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::26de:13be:e67a:3671%4]) with mapi id 15.20.9031.023; Fri, 22 Aug 2025
 00:57:39 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "aksteffen@meta.com" <aksteffen@meta.com>,
	"jdq@meta.com" <jdq@meta.com>
Subject: [GIT PULL] Please pull a NFS client bugfix for Linux 6.17
Thread-Topic: [GIT PULL] Please pull a NFS client bugfix for Linux 6.17
Thread-Index: AQHcEv/BFDSnSKfGPkijmHg41NI5+A==
Date: Fri, 22 Aug 2025 00:57:38 +0000
Message-ID: <b72bf6be6869a8540051bdc6d93f59bbac50d3ea.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR13MB5073:EE_|SA6PR13MB7136:EE_
x-ms-office365-filtering-correlation-id: ea77f340-473e-46b9-f026-08dde116e44b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RU1LWE5xUUx3ZXdpS0R1L2U1aGRhS1p4eW1pWEg2MGo5YUZ1OERFSU1xUzAx?=
 =?utf-8?B?c0EvMVZLWXFUZlZieHlWdU9rUk1KREE1c2ZnamI0S2hIUkxlQW5QK1NlanVp?=
 =?utf-8?B?VFFHM1hBVFhxQVBLNlA4d1h5WnR2ZEJFTlhZOS92NkRCUEVXM2FYa2VQNWxP?=
 =?utf-8?B?SjJxcU5Zajg2Y2VpV2czN2dXd2pYZmMxTFEydEx0bU85MkkvejJiSHcyYjBQ?=
 =?utf-8?B?TGF4SUJ1TmtXVEo2b1gwTHJTZUM0VjlhNGNNUGdWcGpoazZzRnRjRDJCN0JB?=
 =?utf-8?B?VXhuT2k4YlhDZWNaODQ5M0FNVWNwREJnM0YxUXZid0U0eFlUUmFYZnRtUlhD?=
 =?utf-8?B?UStaSExkVTZyL2V1eUI3bzc5Q2ZPVXlRdHltaUhWV1RLL281SUJpVlU4dFhP?=
 =?utf-8?B?WWVsbHh2MnJ2TEF6bDVCblFrR1FCT2E2RFhMdXhhRmJQVUtKemxNQ1d4dWpa?=
 =?utf-8?B?SXlBajhmMUx4MmVHTzNxZjZUcnZuYVFCbXRlSmc2RHVKK1VtbzA0Wk9yckpx?=
 =?utf-8?B?T0NoejFwRE03TUJMRjZLLytFWUVaREpIOEQxcGE2eXd5dDdJUk9MUGcvS0p0?=
 =?utf-8?B?cjdQcFR4OXVGNHVXQWVTb2VXUW14MkRNMDNGY0J1WDlIUGk1SU84ZXQ0RENr?=
 =?utf-8?B?c3h0dTZMUDBJWXdIOVZsbjZuSGV4T3BPakQraDFnUFlGaUpQekVNbGdBWDl5?=
 =?utf-8?B?Y2NOV0tGellFM2VldUZPa0h5OW40NE1BTGNIb2hYMkxhSWVaMC8wU1JjT2Zn?=
 =?utf-8?B?SjVsbDJDNGxsQVpQYm1YSzNKM3hGZi9WWktONHVQaTBrWlN0K1NkVjFVRjQx?=
 =?utf-8?B?ckpoeXRDV3lHZjBJU1dkaE1jVGY0TWdQbkpvUGh6V1o0c0ZZVGh0WDYrMUg1?=
 =?utf-8?B?d1puWHR4Rmd2YVRhbFd0TE9vcU15RzBmSEhOdFJpUzVxblZia3h3RVRrZGR5?=
 =?utf-8?B?M28vTWZLclVHM1k5RUhCVHlVVGFxclE5UnBvYUJZVVhYRGVzZ0pGMUtpeXNi?=
 =?utf-8?B?T0h3YjNja3NmQUJFQnF6QUVQZlZ3ZHh0OFNsdXQ1eHQ4b01VU2dLSkVKR2Rq?=
 =?utf-8?B?UHJkVTFKZktyQUp6dm9lMjNiQXFUWGkxcUhaNGwvTkJxSCtPSms2T0t6Q083?=
 =?utf-8?B?MnFoeEtzTWI5Nytac1hLeDdNVUdyemZZdys1ekhobGhyaER2RjRncVR6UCt0?=
 =?utf-8?B?UkU0N1BMeE42Y1J3SWV3eGtqeDV5NnhPN0VxTHJETDlzdHJkb1NWT29ManZr?=
 =?utf-8?B?Yms4b2NKU24wVUptY0tFOERlZlM0RUN4Sjlwdkd0MHJiRlFBdlVISyt0WXor?=
 =?utf-8?B?d3doYnpQNy9tYlZhQWlvSXlTM09HeDRlRWhHZzUrZi9wTElrS1pKZ3Q5aSth?=
 =?utf-8?B?SnVMWm45S2MwaUtBWkg0STZwUU9YdjFKaDVpNmQ0NElBWmw5TnA0SUhKdWNY?=
 =?utf-8?B?MmxLUEp6MGt5bndnaW9Wc2IvNkQzNG5vU0J1MnFSNlNGOUUvMy81cWR0N0xM?=
 =?utf-8?B?RjRER3ZEdDZQUXBXRFVCYjN1QlBNOTAzVWE4dUNLS0dnTmVKM0pVMzFYVlpu?=
 =?utf-8?B?eXNUY0hPM2tnZ3R0QlFzcWplRXdxY1FxTm5URFBGZ3dxR0Z6SFU3dXNHN2xz?=
 =?utf-8?B?bDZrUndZQXJDcWh4V1IraWlwdmhkeHZYTGZaUW82QW5FWnRTM0JnQkR3Vm9M?=
 =?utf-8?B?M01tSjZrY1FwSHlaVjhTVjZ1YitZUk1Zc0h3K3IvMWU0SjdsaHNDQ2hRL0h3?=
 =?utf-8?B?SmxDbjR4TWI3c3lQMHBxVmYzUGdXZGRHTzY3YUMxd2xoQzc1TkJDS3JleXcy?=
 =?utf-8?B?K3ZZeDZsRWhCaEU4QlNnSW82MnJkVEFvZWJseTFKNm9DZmlZTlVwNTlnNDVI?=
 =?utf-8?B?OWdkZTNtZkhoYnNXNlEyTFlsMDFTajVlMGRnckRrMC9mMGJlcEVmaUVkR1N6?=
 =?utf-8?B?MDcrODNmTGgzdGkrdzAveVBTNkJqTC9tbGRvU3lXZzFkTWVsWlVTS0dUN2ZS?=
 =?utf-8?B?d2w2ZlErZFV3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR13MB5073.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFdEbFk1NFZtN2ozYXdRbmdUaE82YVF5MktaaGF0VkNJMkYzWjEwTXcvVHlv?=
 =?utf-8?B?ZUVqcFh3c2hmdVNGY3FSUzhpV1VTQUJZbHlpbkUzdlBIUG9OblgwbDVyVU83?=
 =?utf-8?B?cmpYUG1FR1JOa2tjeS8zdHdVc3JweDdDTmpXb1NWeHRlL3ZjenArbUpzR1Ex?=
 =?utf-8?B?SWRkRWdLL1hjNzU2enFndStXcWZpRDZicHQ1WnlJTTRBa3RRdWI2cUYrWDJz?=
 =?utf-8?B?NnNjUDRzbGpYWTdTSTZaemJBUjU4bnpsWU1OQ05QYzhRZDFaSmpjNTdIQTRp?=
 =?utf-8?B?NGdsMDc4M2w2QmxhSFNTeWVucGQ2VjhFekZlUzkwVmNHOFA0dndhNUxlL3hU?=
 =?utf-8?B?bU1JYnhVS1lVWS9jMmUvVWtxaXpIMFZnai94NWVxMGlaT2orYlZ6WDMrK1Bn?=
 =?utf-8?B?Q0d6by9OQXVzQTVsWDhIc1pHb3FDbWpMZFhLaFJrUWI1U3VPWTJTVDVFTW5H?=
 =?utf-8?B?OE83Wmo3WFFWRFRNNXFzNjFDd0htcUlBMFdadjNZS3BzMVhFVlVqZ2RMSzkv?=
 =?utf-8?B?UEdVS25YamtEbFNJMjhCQTdtMUh6TVNNbkFmZ3FsM0p6SWFselhmTlFOcmZW?=
 =?utf-8?B?QXJTTFpoTTF5UmEvQnJoRUlFM1JOL2traEhnWGQzN2ZoVUJqZHQ5V3YwVUxh?=
 =?utf-8?B?ZjR0NVlvWktqNEU4QWM3M3dSTFlLTUg2R2lwMVN1TWVheVdpNytZZVMxTGFH?=
 =?utf-8?B?c2NrTHcwMEtQczNicWVwTFJDby9VUHoyZU5xK0NZRFA5R1M1eGQ4eGlzVDVR?=
 =?utf-8?B?SXdkK2dhZ2NxeUI2NVIydmU1WStoZFA4dVo0TCsrZDMyVUJCMExNOHRSWDRv?=
 =?utf-8?B?YUZ0T0xKQisyellaMks2OHc2eXc0azJTQ0JsbHNXTUZuMTVoVlVMRUxwUHBL?=
 =?utf-8?B?YlZNWmZNSjR5dWNGUWlERjBFTDZ1Y0s4cFV5MHZrUEh4ZjgyZ29BemlaN3g2?=
 =?utf-8?B?SzRKeGJGMG1wWXFzNlErWUR2VGFMbUFKU3U3Qkp2dFNYMlFiU0FMc2Y1WGFt?=
 =?utf-8?B?M3EwRTUvYkN3dUVvbTM4ZEhYd2hYQmhBcUgzWCtlSldXR3MzVCtmNVE2bEdF?=
 =?utf-8?B?YmNCVFdBRUtRYk9YVG5rYnlGTHJ0MFpnUGI5MjAwbkdZRk5UWjNmalB6Umwy?=
 =?utf-8?B?YTE2dUtaTUhLNEMwSW5zdmhia0Q1dkNqdlhBZ3ArZ2laeU5ObzZyd0tsSnJF?=
 =?utf-8?B?K1dJMWpCaEtiS2c0YnZQS2YzVDVVQ0JSd2M5RGNMVnhpK1hoaGRRbmhqSzV5?=
 =?utf-8?B?MlQ5WXBhQkhrQ2hReFJpU3lCRnFUSmF5ZzRsSHd4MzNTMTdibnA4NU1vU1Vm?=
 =?utf-8?B?R0ZlWFk0M29DdWw4YVZPeGRvWmdick1lRGNpd1M2bUtIaGJCZ2EvOXE3enVV?=
 =?utf-8?B?NDNyZUJHQytSUW5TZFNsUTBlUkxSZVBsazJ0WXZsSHhkTnJVRWlLK042NXkz?=
 =?utf-8?B?dDB4dW9GUGQ1Mmo4dGRnSkJRaC9nZXQ3d24xd250K3RBSUh0WE5GSE5wQm1t?=
 =?utf-8?B?WEpZU0U2RktDMW9qVi8yUFA0TWJZWit5SFVuY21DcmRvbkVsNmJNNW1FYU95?=
 =?utf-8?B?TVA0YmxUS2dkemt3NTNjc0paWHVYRHQ4dlE1SkhDekN0WHJOS3p3SWUxRERZ?=
 =?utf-8?B?R2NOWkcwTzBldTE1SGhPZnVLTm5EcDRDRExLOXdxTE5BZXNKTGlETy9hTTZz?=
 =?utf-8?B?N0hTSXZpeE5UaSsrKzlEbDNKVHFmb1dKbGhGZEh5S1F0U2U0aFg0Y3hTSTlM?=
 =?utf-8?B?K3V4QTI2bDl5Q1J6Z25FYzgvTit1QmsvODl3UThIM0t4Yjc5VGU5Z2lXMzUx?=
 =?utf-8?B?K2hmNUFwVGJ0dnc1a21lekgxVjlTemF4VWJCcExjSFpMa1pPRHpSalZqQXRz?=
 =?utf-8?B?T1psNElMMDIvK0xob281Y3l4Mnh4Y2FURE5QbVJpRUpKTE1DdFpnVm40Ulds?=
 =?utf-8?B?VGNBdmR3VGtBOUExVHF6cXFpdUQ2NWc5dGp4TWJMQjdYT0cyRFdTYlMxaXdi?=
 =?utf-8?B?NVB4RkNPa0J5bURJbzBSWVNEcksxU0ZwTi82d3YrNkFMNGdFcDBURUQrZ3Fy?=
 =?utf-8?B?VlZ6QlVsOGNuSVJ2S0xXVlVTdEtTZlVrbVh1aG5xeEVaU250Q05pSko3bzc4?=
 =?utf-8?B?Z0lQNXdpUGIrRnBycUQzOGxxSytlcDFlNjh1M3RUWTBqbUszOXNqOGNoYm9I?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA789E97F667C840A9D76FAC7505D325@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR13MB5073.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea77f340-473e-46b9-f026-08dde116e44b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 00:57:39.2066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpXRe4egjt9aq7nHpnIC9ckDcPv82/gDYTdbKG55Cgf4Ca/Uc7sdtnxB/gvyTgEJjE8xtbm2dqYRgCwNTrYSvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB7136

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgYzE3Yjc1MGIz
YWQ5ZjQ1ZjJiNmY3ZTZmN2Y0Njc5ODQ0MjQ0ZjBiOToNCg0KICBMaW51eCA2LjE3LXJjMiAoMjAy
NS0wOC0xNyAxNToyMjoxMCAtMDcwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMvdHJvbmRteS9s
aW51eC1uZnMuZ2l0IHRhZ3MvbmZzLWZvci02LjE3LTINCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFu
Z2VzIHVwIHRvIDc2ZDJlMzg5MGZiMTY5MTY4YzczZjJlNGY4Mzc1YzdjYzI0YTc2NWU6DQoNCiAg
TkZTOiBGaXggYSByYWNlIHdoZW4gdXBkYXRpbmcgYW4gZXhpc3Rpbmcgd3JpdGUgKDIwMjUtMDgt
MTkgMTE6MTY6MDIgLTA3MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCk5GUyBjbGllbnQgYnVnZml4IGZvciBMaW51
eCA2LjE3DQoNClN0YWJsZSBmaXhlczoNCi0gTkZTOiBGaXggYSBkYXRhIGNvcnJ1cHRpbmcgcmFj
ZSB3aGVuIHVwZGF0aW5nIGFuIGV4aXN0aW5nIHdyaXRlDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClRyb25kIE15a2xl
YnVzdCAoMSk6DQogICAgICBORlM6IEZpeCBhIHJhY2Ugd2hlbiB1cGRhdGluZyBhbiBleGlzdGlu
ZyB3cml0ZQ0KDQogZnMvbmZzL3BhZ2VsaXN0LmMgICAgICAgIHwgIDkgKysrKystLS0tDQogZnMv
bmZzL3dyaXRlLmMgICAgICAgICAgIHwgMjkgKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0N
CiBpbmNsdWRlL2xpbnV4L25mc19wYWdlLmggfCAgMSArDQogMyBmaWxlcyBjaGFuZ2VkLCAxNiBp
bnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxp
bnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kbXlAa2VybmVsLm9y
ZywgdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K

