Return-Path: <linux-nfs+bounces-17346-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0654CE6DF6
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Dec 2025 14:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F5D03004B80
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Dec 2025 13:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDD8310640;
	Mon, 29 Dec 2025 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Hq2pG8po"
X-Original-To: linux-nfs@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021143.outbound.protection.outlook.com [52.101.62.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E030FF32
	for <linux-nfs@vger.kernel.org>; Mon, 29 Dec 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767014594; cv=fail; b=BtndP8zMs39JSayqn4qunLJc6Mb7xiXZ9nExk3yCw7C4Hk5Ph4dUnYxnWOc/CAxdreLs9V3FCSvsz+iho1kRishuRU+uRq21SwiSPT+dAVDUKScry1HtPv+eGfAD4aWeQ1U5Qju0cg9TzXoJWveqsfB7gmILFhEmWzsysZVYgvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767014594; c=relaxed/simple;
	bh=bfKhrajC7iz9514iLQlFEwAZPjIcRRauxvMA6mx17PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHTYbaE0JXxnBdvnj2nHag2/1wl4BDGcxJc18Xgk+ZpsnxWOUYPN8uKXWXH501dHZ2jFFMYfa8WtGeyUe8UZCEuYwOeLVPVbCrWBcxPOUEcd7y1Mo9OR1BmX7+09sN3NF9gFj4oybHgOuAKiQZKu9YZ7SD6Yc4wfroJrGbYdFAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Hq2pG8po; arc=fail smtp.client-ip=52.101.62.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvHPYFF4OhhulueWPqfDnJrUi2IZSGNwjsy3zjW2f9vAfaPcUnPBs1umNH7QzhUDGtVWspvBORNXJzhfwujH5qktMT+Z9mmXgkxPLbQpaxxnd/rqrqOnTEDpmEfjHfHRUqGnjtbjvp1JoNLrR4ZZWY6kpw503BAx/pmNL6mT/MrMGLrLwQi/ITjL0N125JAzSvzolExry1BU7f3TQc1DUByFZiw3qfpGYr9X12nX5GaPYdNnopM2y3bojpAdMA7c39SC2SNdefShulMpD8Iw1yjFjPwUCbuz6uA09YIiubsGkaVdJaDe8tacGCINXICshy9jnoiIrsgF+x31U8PErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URlSlifXR0xRQDRU7chCuakXc1FEg1v0zfUpbe1BBdk=;
 b=sbY+9TUagZOSQeT6LpVDVERMjjCdI4wo9Cfp9i8Pw6ko49exl/4iRbbo5YK9ldeUso5+PxwVs1bDSd+mJy01oOQ4ApznElO4qEfCbfHslxtQiSAoCju5dRMyCtY90C19JKWLXZbFVw8OfrBYueSoB5+cKlFy736lWqG8Yhq5jdcwpOoMEunz33EXz5aD7QIeAT78OXEy0TrwvOWxZp2A7xxFCB8898zVXGmk5XI7txqzF3y5F0VkTXmKfceh4FmdwQMyxdS4lV7C0fc52CyXNxFh04x9T2OcAjRtJLwrQ9EmhErt4gyiMyzs9rj+TuCfmV+nyTOyQR1wGjefKV06Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URlSlifXR0xRQDRU7chCuakXc1FEg1v0zfUpbe1BBdk=;
 b=Hq2pG8pojZxZvfwt+q9BQ521wDPSK/m8W4AKNXvPqyY/xIObxzy0mkHfWkpdqhJZwbEbYKErep6dcUxqT9F/93Xzp3xgPMX+aHDJ8p14xDE7D5xVWtX8QR1KujSXhdPvs8rrm3S5QnFQIxdnLNAPHVkVtqVV34JfU80j9p2hkMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by CH3PR13MB6316.namprd13.prod.outlook.com (2603:10b6:610:1a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 13:23:06 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 13:23:06 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
Date: Mon, 29 Dec 2025 08:23:03 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <2DB9B1FF-B740-48E4-9528-630D10E21613@hammerspace.com>
In-Reply-To: <aac7f668-5fc6-41cd-8545-a273ca7bfadf@app.fastmail.com>
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
 <cover.1766848778.git.bcodding@hammerspace.com>
 <aac7f668-5fc6-41cd-8545-a273ca7bfadf@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::17) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|CH3PR13MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: df184e34-cb4e-4b43-c45b-08de46dd6734
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWZmYzFrbGN2NGpXYlNFY3FhQU5uRzUxU2k5dUhzUlVxcnVxa0orZTRDVGc2?=
 =?utf-8?B?QUxnazZZakNiSWk2d1BVNkpGV3NyK0grTkIwNnp0MXdhVVJVMi9Wbll2bHY2?=
 =?utf-8?B?U0xnRm1JUWhXWHoyYUt1VjFMTGs3REFFZVR0OWxGZUM2SnpkZ0Z3bERPb25x?=
 =?utf-8?B?cHRrSHhhOTFhQ0ZhMzA1K2k4TTc0YlVBd2QyOU5yeWp4cjlIVElqc0EzblFm?=
 =?utf-8?B?S0gxOE02ZlUva3dSSjBHUHNNWkE2QkM2UitlbW5sUTk1di9lVklaKzFLdm92?=
 =?utf-8?B?aTZ3VW5kSzBYbW1xOGd5bmNJM1JhSU5ZaFYvK2RBdU5jcFhNNzVLVzQ0U2Ft?=
 =?utf-8?B?eGhabjVFVFhHLzlZekUrOTFCK3Z4SUdHblFQY0lNNXQ5YitqMU9aaGt6L3BG?=
 =?utf-8?B?cWZhNEVhNG15a2R6RmJFcTVnbGptcElVRktYRmVaeUNUbHR5dzlla3hjaU8r?=
 =?utf-8?B?UjU4QU5LQTQ3Z2dlejQrV2NZZmQ1WDgwZ2pQWHBiY1BxZlBIemVIbGdWUXgw?=
 =?utf-8?B?V0UyMCt3YVB1YXIzczlaUWtKbmRoYzlSWUZ1R25KUkNLUjRLMnVyQjN6M29U?=
 =?utf-8?B?aE9Vak9xN3RvQXRoWnhpV0YrNW5JYXhUUGJkL2gvcW5RR1ZaVlFYcVNsNlhQ?=
 =?utf-8?B?R3NxRFpJWjlrWjNpY1ROaDV0cTZpazR5SnFscndUV0RYNTdkS3VJdlFZYm1y?=
 =?utf-8?B?Y2JYQTdnVVR3UGczUVlnbWVkMzNxazFVN0FLTmhwVVV5aURKSnRieUVtcys0?=
 =?utf-8?B?L05CTExqQXFPNloyNE1yYmxxOG95U1NqM0VUSXRoM3Z3QlZacjBsdWlCU0Nt?=
 =?utf-8?B?ZFdNVldSVVJid2lMV0tRblpuSHNFTDNFNFFlTE50c0xpdUpHY3NGZDB2eGJO?=
 =?utf-8?B?L0RZTjNGQUZMSmI0d2dWd0p6L3A2eHByb0JhM1dPOXhsZTVKVzNoUWtVcW1w?=
 =?utf-8?B?eVo5Y3lmbCsrdnYvOERHTXFZOTN6SkpuMU56bUxiTlZUTko3dkNDeXN5N20x?=
 =?utf-8?B?NWQ3SWVndUQyK2p5bzAzQStreUUyUi9XRHFNWUhJeXFSaXJ5a2dvWEJleEtv?=
 =?utf-8?B?T2syOFE5cXRrdXFyYm9ncXZQSDBTMHdjTFZENTRxYkYxNFZqSEVZSldVOEFC?=
 =?utf-8?B?NmUyTHRTb2xlMTk4bW5SY2hiKzh3cjdZZ3FUZHFrbktWN1lleHRaR0UvVjZW?=
 =?utf-8?B?MXl1M1BlVXM5b0t6WFA5VjBocTVGUkNmNk92azBNUjgzMkJXWUtwMFJDNVhU?=
 =?utf-8?B?ZERpUFJSSlJzeUtyODY5Z0FXVmNrSG9DdnBQSTlhMytvTEpVcE1Wa1l5bTJL?=
 =?utf-8?B?RTcxaUtNZGF6c0lSOExVTWlkN2wrNzlieW9iRUo2S2hrUnBWdW5SOVhKZFNK?=
 =?utf-8?B?RXNNSUZCUm92VmJxWHljZ2c0US9kV205cDZyeXR5Ymc3bk04SXg1MXFUNzhn?=
 =?utf-8?B?S3FNUHgyWWcydm1yQmdKMWVZVU9CL0xCOWhUemcxeE9qN0J5dlhMc0V4SkEz?=
 =?utf-8?B?d1d4R24rWVVnU1h6RHJjZGlaN1N3RXdyNE93dVlDMG0xV29Rbm1FdEhOeUZo?=
 =?utf-8?B?T0pVK21qVm00N3ZRemlkbFlyWmVjVDRsdUd6M0loMm8yb3dyQ08zWGU1ak03?=
 =?utf-8?B?VSsrNk1xb0MyZUtPdXhockxwN1Bma01LQ2VDcldacDNiZ21aRWo4c0VyRjQ1?=
 =?utf-8?B?alRXa2Q3SndrU2Y1cFVQSkJUWno0bllnaUp2U0EzekJSTm1zV3lleElNejNQ?=
 =?utf-8?B?WDZPZ3hhYXY4M3hpZkNKWmU2R2hGOVNxMXVMNEJhcDZCU3ljVkZaV2VMOHUz?=
 =?utf-8?B?eHFnRmN2UFBIVG0rUDB5Z3p4aElpaGE0a1NOcGxETjBFdjhweWVvWnBTTjdV?=
 =?utf-8?B?ZWNrWE5Fd0xPZWtURlRTaHNUeVFpYVVud3BhUk1VV2FLVHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmhXVEdTK1JtbzdPUUwwamZ4Yy9mZmNRZXVEYjNINGlha0JCQ2VjRG45QktO?=
 =?utf-8?B?aHZLZDQyV09LOXNZVkRTSGpTQ01WZmhRQ0xZWGNqcXhJMzY2TzVaVXVkTGN2?=
 =?utf-8?B?bzd0QXlCdkduVVBkSGpKUVB1L3g2QTVKUG44OWdzUXRoVnJ6Ykt2ZWVkM1dT?=
 =?utf-8?B?aE5NV1MzRzg5SHprQkhMeEFvbUdzRFlyMEEvWW9TOXN0OXMvK2o0Y05JODI5?=
 =?utf-8?B?ZWlxU0U4WFVSTnYyRWNBUHUyNlEwQWQ4akpEeDdRWWhDSzlFUGllcTlXa2Iw?=
 =?utf-8?B?VU1GUVpPTVY5ejFrTkR0U1lGMFhnYmNhUFRxTU9lUEdoTGpadUEyZmZIZWZF?=
 =?utf-8?B?MWt0d1h6VWdjbnMrc2tYM1JvY1RkekVTQjZGeTNVdVptUURLc1RpTjVaeTda?=
 =?utf-8?B?Smlac2lHcTAvckJ2Q2x2ditHUGtHZldERW5Ca1FYdHdrNVc4a2sxUSt5MmV1?=
 =?utf-8?B?TTFhNXBXMC9OM1ovV1ZnZ1Z1UGxYS2FIRmd5TExKenhFMTZQc01VdXJidjF3?=
 =?utf-8?B?TGFEdW52a2srS2JUT1BJcWZ3MXEvV1dzU1ZiLzRYZldoOUpiR0w3MEFCU25x?=
 =?utf-8?B?T0NtUDhwUTNwRktiOThLeWNMWVNndnhTV0dHYk1mS0dzWGNCR0draWxYOGRK?=
 =?utf-8?B?NVhTMk1WaU9jTXNVVHUwNnRzL3VXVW9JaHRoQVVTenVMU1JHbisrdFZRcGl3?=
 =?utf-8?B?ZzBVNi9vcUVXK3NxTEFDVkNWRzBVc3NwOXFLblFhNWMzanB1ZkJaQ1IzbEwy?=
 =?utf-8?B?YVBXR3pEVlp0SzlHUzBmNHdlMCtHU3M0ZFdxU0lWZWZwVEppdk50ZHV1aE1B?=
 =?utf-8?B?REsvaW9qblZ5WFppMFRKeEVNWnU1TFdKWFFwbE9QL3N6NFBlbDFnUVVlVVVp?=
 =?utf-8?B?M2thSnZ6bml6T2RmR0J5RTZsd2YvVncvN0pJMUtLWFNtNGtaSGdWZUpxUzN2?=
 =?utf-8?B?QTVGd0czTy9Hd1pCY2UvTlhLYXROZnVRcHh0WTczdEpTdThnTXZ5UXdRdEpX?=
 =?utf-8?B?QjZNRGVkY2Evb0dyQ1RtTWFJMWpGTzRMUi8zRGp0SUhYMDFkRmdkOHFUK1Az?=
 =?utf-8?B?ZTRleXNudUxTSG1MYll0OTZGaEhuS3pIdjQ5bFVRS1dia2NwZWhCNzVwQnJ4?=
 =?utf-8?B?UVc0cUJtczNqdm5ZMlhXeFpVVUc1LzBGTE5qVkdKL2lIeFlhOVdlMWF4NVdL?=
 =?utf-8?B?TFZ1VlpqQnpDeWFBcTVodjIwcG8vS3gvSGcwTjJ5cW9SQ1FZaWNPbHNkb2dy?=
 =?utf-8?B?YzVrZEhubkU3WWJUZTZPWGFPUWxzbUJ1eS9zOFR0ZjJabzJaQ1lDZEhrNmh2?=
 =?utf-8?B?bVpIcnFYRDB3OU14Qi9Zb1lhYUdhQ1V6eXBpbWh1R0N5cnU2c0dpWnhwWDFL?=
 =?utf-8?B?QW5leURLdWxwanVVRmZYWEpUZ3hFU2RuMTlTK3hQQzZ4eU9iaDhLblZXVDlR?=
 =?utf-8?B?SkVWR25VMnZnK3BWS1Z0M002cTUyMW4xblVvc251S2Q4T2wwcHE5Rm54WGE0?=
 =?utf-8?B?Ukt2RzVrLzVma0x1L0d5azBMbU56akJBUmI4S3d5ZkFON244Sm5GS2NWOTJL?=
 =?utf-8?B?ZjVLREE5S0VJbnlMUERBNG9rQ2lJZVZLQXhpeXNtVEVqNEdTS21tajl1OVUw?=
 =?utf-8?B?YjZ0SHRha1F4ZTdFSHAxc3JRME5VWm9KcjN3QWZMb0pweU03RDZtMEwrWGJl?=
 =?utf-8?B?TDJ5MDAxUmpCbThNSFNFYm1TZVZMQlFiaEhvazNhNjdwd1h5QzZvTmNibkRN?=
 =?utf-8?B?WWkvQWp5RDZycnpaeWNpUzZsSzNxK1ExaERxUklESlpsYXZHRHM0cnpYQ0Nj?=
 =?utf-8?B?cDdEMUs2V2ZzZ1JwZWs1MkpEaEJSNlZ2ODlZZmtjUXlNWksvY2YwZ3ZDa3Zj?=
 =?utf-8?B?WmVrY0hFNUV6c3QvYlkwYjQxT1ZOOUJQVk5yVFo2WEpEUkNOb05EVXZ2TW83?=
 =?utf-8?B?eUNIUnNla2grc0wzck1NT0EwTXdMM2kwVHNEL1N6cXA5aGxoMlFRU213TWxW?=
 =?utf-8?B?WkNqaVVPSGM4L0JRaXhHbU9oMzRiZ0Y4dERFSVNwU0RNQ1AxS3pWa0NIZWcw?=
 =?utf-8?B?WWx3eWp6eTNwYzcwZWR5d1Y3QlgxL1ZaNnc2QUlmN0hHRkZPZjlCaUExd0pN?=
 =?utf-8?B?S1V6cFFmVUowRHlxbzh3NlBEczNzb0J4S3FlTHEyUGlXb0dwTkJxVGQ1U0E4?=
 =?utf-8?B?TDRMYm54R3FaNXFIaWFMZzZhRlgyb1ZiM2tlc3lGWUpIYUZFeGRKRzcyME9N?=
 =?utf-8?B?eSttR05vbVF6Wm1mRTk3cGRLTFVNcHFLK0tya1d1WHJLS2VBNTM5SVF5ZFlU?=
 =?utf-8?B?SjA1bDRCV3hrMFFGbzNXcnlCTnM3WGZaQnZJVUY5Q3p2dmdDU2ttbU5pM3Nh?=
 =?utf-8?Q?D2uoMi2TBgb3tNVQ=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df184e34-cb4e-4b43-c45b-08de46dd6734
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 13:23:06.7038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arPPp/iItk9mRkw7kPmbk9iyzhH4NGS4y/Q8PtfuuKHdW1J8WdPEA0+DqjsApxuPMBWI3cn1nvpvJfvBaAgiSMzJx4N2JtDoj1NElRzAGwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6316

On 28 Dec 2025, at 12:09, Chuck Lever wrote:

> Hi Ben -
>
> Thanks for getting this started.

Hi Chuck,

Thanks for all the advice here - I'll do my best to fix things up in the
next version, and I'll respond to a few things inline here:

>
> I tried to pull in the kernel patches as follows:
>
> cel@morisot:~/src/linux/for-korg$ b4 am https://lore.kernel.org/linux-nfs=
/176690096534.16766.12693781635285919555@noble.neil.brown.name/T/#u
> Grabbing thread from lore.kernel.org/all/176690096534.16766.1269378163528=
5919555@noble.neil.brown.name/t.mbox.gz
> Analyzing 19 messages in the thread
> WARNING: duplicate messages found at index 2
>    Subject 1: exportfs: Add support for export option encrypt_fh
>    Subject 2: nfsd: Add a symmetric-key cipher for encrypted filehandles
>   2 is not a reply... assume additional patch
> WARNING: duplicate messages found at index 1
>    Subject 1: nfsdctl: Add support for passing encrypted filehandle key
>    Subject 2: nfsd: Convert export flags to use BIT() macro
>   2 is not a reply... assume additional patch
> Analyzing 0 code-review messages
> Checking attestation on all messages, may take a moment...
> ---
>   =E2=9C=93 [PATCH v1 1/2] nfsdctl: Add support for passing encrypted fil=
ehandle key
>     =E2=9C=93 Signed: DKIM/hammerspace.com
>   =E2=9C=93 [PATCH v1 1/7] nfsd: Convert export flags to use BIT() macro
>     =E2=9C=93 Signed: DKIM/hammerspace.com
>   =E2=9C=93 [PATCH v1 2/7] nfsd: Add a symmetric-key cipher for encrypted=
 filehandles
>     =E2=9C=93 Signed: DKIM/hammerspace.com
>   =E2=9C=93 [PATCH v1 4/7] NFSD: Add a per-knfsd reusable encfh_buf
>     =E2=9C=93 Signed: DKIM/hammerspace.com
>   =E2=9C=93 [PATCH v1 5/7] NFSD/export: Add encrypt_fh export option
>     =E2=9C=93 Signed: DKIM/hammerspace.com
>   =E2=9C=93 [PATCH v1 6/7] NFSD: Add filehandle crypto functions and help=
ers
>     =E2=9C=93 Signed: DKIM/hammerspace.com
>   =E2=9C=93 [PATCH v1 7/7] NFSD: Enable filehandle encryption
>     =E2=9C=93 Signed: DKIM/hammerspace.com
>   ERROR: missing [8/2]!
>   ERROR: missing [9/2]!
>
>
> Whatever you did to post these seems to badly confuse b4. I recommend
> posting nfs-utils and kernel patches as entirely separate threads.

I only told git-send-email to add "In-Reply-To" and "References" headers to
the first message.  I guess b4 uses those headers to climb up the email cha=
in
rather than pay attention to the "[PATCH vn n/n]" subjects.

> Also, the cover letters for both series should mention the base commit
> for your series. Typically for NFSD patches, base your series on the cel
> nfsd-testing branch. But any base is workable as long as you mention the
> base commit in the cover letter.

Oh yeah - I will do so next time.  The kernel thread is on v6.19-rc1
(8f0b4cce4481), and nfs-utils is on version 2.8.4 (612e407c46b8).

> More below.
>
>
> On Sat, Dec 27, 2025, at 12:04 PM, Benjamin Coddington wrote:
>> In order to harden kNFSD against various filehandle manipulation techniq=
ues
>> the following patches implement a method of reversibly encrypting fileha=
ndle
>> contents.
>
> "various filehandle manipulation techniques" is pretty vague. Reviewers
> will need to know which specific attack vectors you are guarding against
> in order to evaluate whether your proposal addresses those attacks.
>
> Also, next posting should copy both linux-crypto and probably linux-fsdev=
el
> too, as the FUSE and exportfs folks hang out there and might be intereste=
d
> in this work. There are other consumers of filehandles in the kernel.

Roger, I can do, though I think the chance this provides value to them is
small.

>> Using the kernel's skcipher AES-CBC, filehandles are encrypted by firstl=
y
>> hashing the fileid using the fsid as a salt, then using the hashed filei=
d as
>> the first block to finally hash the fsid.
>
> Is the FSID possibly exposed on the wire via NFSv3 FSINFO and certain
> NFSv4 GETATTR operations? It's not clear to me from this description
> whether these values are otherwise unknown to network systems.

Yes, the FSID and inode numbers for file can absolutely still be derived fo=
r a
given file.

> Can you elaborate on why you selected AES-CBC? An enumeration of the
> cryptography requirements would be great to see, either in the cover
> letter or as a new file under Documentation/fs/nfs/ .

I chose AES because many CPUs have native instructions for them and I wante=
d
to minimize the performance impact.  I chose CBC because I know that most
filehandles will fit into just a couple 16-byte blocks, and I can use the
standard way that filehandles are composed to arrange to have the most
entropy for a given complete filehandle.  By having each block depend on th=
e
hash output of the previous block, a complete filehandle can be have a
unique hashed result by starting with the fileid.  The actual implementatio=
n
is a little more nuanced, but that was my original thinking when I chose th=
e
CBC method.

> The use of a symmetric cipher is surprising. I thought there was going
> to be a cache of file handles so that file handle decryption operations
> for each I/O would not be necessary.

Oh, I never thought about this - but it sounds like it would have all the
problems that cache invalidation does today.  I can't imagine having to mak=
e
the server persistenly store that cache or figure out how to trim it.

>> The first attempts at this used stack-allocated buffers, but I ran into =
many
>> memory alignment problems on my arm64 machine that sent me back to using
>> GFP_KERNEL allocations (here's to you /include/linux/scatterlist.h:210).=
  In
>> order to avoid constant allocation/freeing, the buffers are allocated on=
ce
>> for every knfsd thread.  If anyone has suggestions for reducing the numb=
er
>> of buffers required and their memcpy() operations, I am all ears.
>
> The required use of dynamically allocated buffers is a well-known
> constraint of the crypto API. That would be another reason to consider
> not using one of the kernel's crypto APIs.

I'm not sure that we'd benefit spinning our own thing.. I'm much more
comfortable using the crypto API.  I'm pretty sure you'd agree, so I think
I'm not understanding you here.

> I'd rather avoid hanging anything NFSD-related off of svc_rqst, which
> is really an RPC layer object. I know we still have some NFSD-specific
> fields in there, but those are really technical debt.

Doh, ok - good to know.  How would you recommend I approach creating
per-thread objects?

>> Currently the code overloads filehandle's auth_type byte.  This seems
>> appropriate for this purpose, but this implementation does not actually
>> reject unencrypted filehandles on an export that is giving out encrypted
>> ones.  I expect we'll want to tighten this up in a future version.
>
> I recall one purported reason to encrypt file handles on the wire is to
> mitigate file handle guessing attacks... so operations on an export that
> uses encrypted file handles really should return NFSERR_STALE when a
> non-encrypted FH is presented, from day-zero, unless I misunderstand.

Yes I agree completely.  What I didn't want to happen is for someone to jus=
t
"kick tyres" on this and break an existing setup, there's some missing
necessary BIG WARNINGS that will exist in future versions.  I also think
that the community can discuss what those warnings should look like.

> Can you elaborate more on the size of an encrypted file handle? I assume
> these are fixed in size. An NFSv3 on-the-wire file handle can be up to
> 64 octets, but NFSv4 file handles can be up to 128. Are both going to be
> encrypted to the same size?

No.  As you know, filehandles can be variable based on the fsid len and the
fileid len.  Also, AES-CBC wants 16-byte boundaries, so currently some
padding gets added in encryption.  I've tested max/max, max/min, min/min,
and min/max for each.  Depending on size for each, the filehandles typicall=
y
grow a bit from their original sizes.

The NFS3_FH size might be a problem - I admit I haven't made sure we don't
blow that 64 bytes for the larger cases.  I will do that.  Now that I think
about it, it might be possible to avoid having to pad out the blocks.. more
investigation is needed.

One thing I can do is produce a table for the resulting crypted FH sizes fo=
r
each given fsid/fileid length..

> Can the cover letter or other documentation include a bit diagram that
> graphically shows the proposed layout of an encrypted file handle on the
> wire?

Haha - yes, but the result is going to look pretty basic: something like:

16 bytes block 1 | 16 bytes block 2 | ...

Thanks for the look and your time to comment Chuck.

Ben

