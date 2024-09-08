Return-Path: <linux-nfs+bounces-6328-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782979708D1
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 18:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 748CDB21038
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 16:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B81E148828;
	Sun,  8 Sep 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="EwE27eVZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2131.outbound.protection.outlook.com [40.107.100.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B025535D8
	for <linux-nfs@vger.kernel.org>; Sun,  8 Sep 2024 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725814557; cv=fail; b=dUcAarnUAa4n2UNB2vuwJqU9w568NlU04APYGNPApInMk3DDLWIJwr1wTsMusnGbhNk5phyOzkXmcSiyfq9OLqY3m97WPbjI8nhqHu9rT0x/YG3w/dqg1EshVmLRsY3HDLKy/wJze7zSlBv/RmtoomDHh6SGmqUvu4/Xi2HuBr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725814557; c=relaxed/simple;
	bh=cJJwL+emrC6Ejv2O9Ids78kDxZ0oJTYfZY0q+GYk3tQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KwyDEY17ltt6EGCbjasPUgWrkPyJFK5QFWSsGzcyTgiZDeyOlPwLYPpDKwYNfKcdGq5H0HzGZp+I+XoHJbnhgbVBCS44aKp5v+GGBqLZPWZVhDoXtxRYdOGSGk2VFW/1VtP/8VFiOYR1PNaTIWvFaAx5eVt+vaVxjh2P+zPUsh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=EwE27eVZ; arc=fail smtp.client-ip=40.107.100.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MB5s76TPvusavSIoTk+rjdg3U3W3Pg8jWYjnXBTJ9jtqCu7vDHC9k5q0GNnvynQv/YwXaZVwGMQb0VMDBd24xcFDGUHBglqRqyb45IRx2F/d4XOr0Swy3PREUg2i8Z9YP+NJR3NN+P1RmD3RpKjpR8XO6hyAFQxBOAqKhw7FKRb1NV13oiJGvKko11NZdAQrf3sk8KQCa0zp1g7YQCwDOAm4zP2RCsyYxmQqDNOGW1hoN+ukAG5+iZ+cv9zSxlJXQK31IJosNJ0jmYIj1bM4uDkAADZIWKhO/IX718ASnXZUlDt+kfOd1WsSidF/L/hOevpTyWQL/AlLkuky51P0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJJwL+emrC6Ejv2O9Ids78kDxZ0oJTYfZY0q+GYk3tQ=;
 b=y/4iaL4mejAGTpJWVD/ltjpq4/M7ZlQBOzaUeUpw+6oxIvTwKWD2ds3H/5QH0vvBFNCpX4s3sbOe6jKsZq3oBGKWNsCp51t85mBwS9AJM7455Ax4jxW7eSitMoC/X8hUt1C8nB59D35d34RGCjQYXlYxBkQKwezJTn9cL0U7lXV1/UXiP6gMqUJSB2euuYz7FVyW7cOQxu9nvYJmh1dHZmvFlPuxjygagc6co5t7A3lcf4vx2VbOYKHQ7ru6ghTQLzh1bx6t0HxY1lXuX9wqpupTdcrIeCn3KmQfTeyBXw4fGld0Nex7PYWSP5Nu+ARI1arwgjcTxpMVAMz6DbR35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJJwL+emrC6Ejv2O9Ids78kDxZ0oJTYfZY0q+GYk3tQ=;
 b=EwE27eVZdZG6ETr0aozO+oK+UDti1RPpagSyaIdEY2rLz6LrYSp3SWB7e7Ldtkwwnzh5adaGn1lBjok1d/r+2V1K4XDn4VPRMv27CfCHZp2jE6/7VHcrGwiFycNJUakV1N0rdqVBiSxpbEaPGW79uTy0kcMRr4apb56ian64CBE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3910.namprd13.prod.outlook.com (2603:10b6:208:24e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Sun, 8 Sep
 2024 16:55:50 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7939.017; Sun, 8 Sep 2024
 16:55:50 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "roi.azarzar@vastdata.com"
	<roi.azarzar@vastdata.com>
Subject: Re: Suggested patch for fixing NFS_CAP_DELEGTIME capability
 indication in the client side
Thread-Topic: Suggested patch for fixing NFS_CAP_DELEGTIME capability
 indication in the client side
Thread-Index: AQHbAfxLVovO4sMjPk+vVXAfhmiAmbJOG/CA
Date: Sun, 8 Sep 2024 16:55:50 +0000
Message-ID: <48295036a03cf9806eb5a42f890af2e43d9980a6.camel@hammerspace.com>
References:
 <CAF3mN6VbfgBV-o5yiSRn=PHAMO1be7G5H5wYRSsasYJ0Pvwv9w@mail.gmail.com>
In-Reply-To:
 <CAF3mN6VbfgBV-o5yiSRn=PHAMO1be7G5H5wYRSsasYJ0Pvwv9w@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB3910:EE_
x-ms-office365-filtering-correlation-id: 02b98b11-5e30-41bf-4dac-08dcd02717d8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QW5aQmhXcmZPSjZGUm41VW1PdDZuM3FuUllNb0ppVHg1MUs1TCtib0xiNmpH?=
 =?utf-8?B?aDR4eHNFY3NpRTkwQTRpanhDUGx0OXIzbHAzbmgzRk9lM0hGeWw5U1Zkb2Rn?=
 =?utf-8?B?Ukw2Mm9IMW4zbGgvQlNPZlZ3aHc3Y0lpcldJNmZONHVLMGNoNUFNTm1GbDNn?=
 =?utf-8?B?KzFwZjBaSXVGMHJxN2hLRFpOZmtTYVpNbFdoaFU1SGxLT0g2WVZSWUlRV2Q5?=
 =?utf-8?B?NzRicWxDMnl4U0Y4VWhkUmtHVk9paWJTTUgzQ1NwZU5icFhnNzJjYzZOSE9U?=
 =?utf-8?B?L0JkWVJOOEtWY0x6SW5obFY1YXVvK3NXYTlVdC9HMUlGZ3pTSG03cCtpaXh3?=
 =?utf-8?B?ZjNXYTV5UGEzeVhPdHk0c3FuUURGaXJ3cVVDa2JmSmhHdmNKSWE1UmRoUE5o?=
 =?utf-8?B?VklCSWFjM2daNGt6UTc5Yjd2RjNIQ3dOTWdTaURlSFBuYmpiZ2hIR05TanEy?=
 =?utf-8?B?RWZCQXF6Y280ZHF0d1lqbUZrSEtlUW5Ob2Q4Y1BhS21iRlJEcHM3S0JuMCtw?=
 =?utf-8?B?WVlVR0hodkljUzQ3VW9lSGRWdTVaSGJLWWtUQXRsMTlaUkFjZHZKODZUUGdG?=
 =?utf-8?B?R2grOUgwdWYvVFI2bDd3ZGNkMEdjR0Z4NHVWQzVsNW5CN1A4bzNDZjhtRHJE?=
 =?utf-8?B?R1AxdTEwaUpEUFZEMTZkOUdROGM0anF2SnpCbVo3TlJ4SUltZ2xGNk1rd3E2?=
 =?utf-8?B?WVVHclhEVWRGdkNSRXkreDVnS0FVTnowejRPaEJYTWZ6eUdjZkxZbytrRXE0?=
 =?utf-8?B?SE84enRFMU56MVZLRXV1b2R5NkhjTjBUa0wybm1xZGtKU0grSkRDMmszMS9j?=
 =?utf-8?B?U2laVWZHMEVwc2k3MXNPSVNpUTJaVjd0aHhjQWxJMElVQjZxcjdHZFVBU2Fx?=
 =?utf-8?B?cURFQXVQSG9wNVEwNnRraUZoOWd0RjA3N3YwUjBuT1NlYnl2VFgyVmtvOWdU?=
 =?utf-8?B?dEFOMmhHVjBDRWNQeDd0OHpES0ZtK3pRNi9ZSGp4bys1YUJxdzNlMCtjaFBw?=
 =?utf-8?B?NGxVT0tpYUVBUS9Wb3RuTVY1U0Q5emNtWDdGY1ZEalBpNVJYc2sxK3RCc0pI?=
 =?utf-8?B?VUg1Wnl3NlhJS3VIL1BSZm1HWEFQMlJFOWc1bURmbjJxcHVyRWVYd0Jsbkxs?=
 =?utf-8?B?anc4ZHkzK2U2aTVUZEExMG5yRE1OWW9iSTR0M1p2NDhSSEgzOGJjaGlFbGNa?=
 =?utf-8?B?eEZ6NEFCaDVCbXZSRnBvZ1R4TVZsamkrVWZDeHV3eXpQcVpOdzdZUWN1RXFW?=
 =?utf-8?B?WWwxQW9XNVM4b1o0ZUUzT0F0T2VLWVd2N3RkazM3b2IyekhPZzBHMGNCMW9Y?=
 =?utf-8?B?emNjSWR2Y3AzY3dHRTZEOExiL3B3ZVRvWUsxT2lLTWtsSHF1czBJUjlLMFJp?=
 =?utf-8?B?VTlQTGhwZDVVNCtOdXN1QU9rY1RDakNCd3h5ZzZjR1E5dmtuOHZ1TXdnRVNX?=
 =?utf-8?B?akl1alVncy80SXRFdTNTeWNOV2EyUGU1NE44ZG5JSFJrbjUwSkhHT2t6eDd0?=
 =?utf-8?B?akRxOWJUQ3pFZzFCSnNya3ROL2RlODlPRkRrejdCQjc3UWtvMUluK3h0Y3Vt?=
 =?utf-8?B?b2dUTmJqdzF0NDdnS3FLQVRzS0lNd3AydUJON2ZscGRraVVVS1ArRUh4b3VJ?=
 =?utf-8?B?RjlJTUxCMzIxbkRLU1VKdEl2Q0hQUnFyeFlKMTFYa01LdDRvdUNOS3REVC8z?=
 =?utf-8?B?VVgxS2Y3WUR1R2hmZFljSm1Vc0JFRnNyTThrM2JKejVZWFlHaXFhcFNxcFd3?=
 =?utf-8?B?dU1TZVM0Wk9BUTArWlpWQUhpcXh1QzlsZnVqRURzS05RRHFkaXErNlQ3TlIv?=
 =?utf-8?B?ckhqY2EyUHNoVXFRWHVkZ3dWSEZZQUt5K2ZjUjhoeC9Qc0IyVUlNRWEzRmlY?=
 =?utf-8?B?VFJTcDRBWHV2WUc4aXF4MTN6OXdKRmpTNjFTc2tIbTN6anc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEszWjdtUnl5RS9rSDN0Z0t6THVsSWJqdE1TcUFMSjNiYTlPTjlrWVFWYUlo?=
 =?utf-8?B?NGhzamkzbGxqZWcyd2FxOVgzVENhVmg3MVlxNGpQM3didyt3dnB2eGlqUUxI?=
 =?utf-8?B?SWZ0ZFBjOVB3TVFDanRpYnZObnhFTWhIZnpieTF4R2RFSUxqdzVhUDJ2OEVr?=
 =?utf-8?B?MS9FVzJPOExaVkI0OXZjZWIxOGdLWGZKMXppSnBvMXlqS2RWU1pqRk5HaUd1?=
 =?utf-8?B?VmM3RTdrMjEzdGhUQ28wd3RkQWdEa2o3QXozTFdSTWNDM3pNakhPQm9IL2x3?=
 =?utf-8?B?WHRJMHk2YUxKUDV6bjFhWVJLbUh3YktEVmNCcUpWNFNkaXpZRDRtNDgrTWVV?=
 =?utf-8?B?OEpIQzZQaWJrQWNLbVlWQ1NNak1Bc1dVSnJVcVZTMTB2Uzh3b081UHJxeWY4?=
 =?utf-8?B?MzNuSElVbURQRzF0NnhVQXFDbFVFSkRVQUU4TFVGZHNGUmJ4TS9QelpHd3Uy?=
 =?utf-8?B?c0tncTVWQVVuS0huc1h2c0ZlcTFEZEoxWUJzKzI5TUZ0WjZVamVsZzNBRE8x?=
 =?utf-8?B?NGNSZDQ2ZEIvVzlKejlkYXNVNVdvc3YwN2hmWi9IWkUyY3FuaDUyNVJtTHpy?=
 =?utf-8?B?ZURLUEpLNmlkQXc1V3Z0MHVRYjVucVpERVhudlRDeVNXRnpPTHZQUk1sNGRt?=
 =?utf-8?B?dzZnYkFaYTIycy9rUHIvOWdrd0NRZXRXWENjd0ZjSDFoU1BhNlMyRFY3MUh4?=
 =?utf-8?B?SDNGMUc4MGNET3g4ZzlHeUZEd2MvWEFiaU9pWlJpaGxzRCtRcm5XTDlGWDRj?=
 =?utf-8?B?SWRnN1ZmWVJuQTZJdzNXOHFKQVlCYUJkTVRRdWpmdWY4MzBCcWY2ZiszZ2Ux?=
 =?utf-8?B?UnZoUVNrd1pkQi8zRU95YUdvV0NpekpKQzJkSHh5WnNhV1N4VVdyY0hJWlh3?=
 =?utf-8?B?RUhNNkIvS0VhejhJdzUvQXBKZmVuUE5Eck9JVGdUanVScGh0cTFmQjYzZUNL?=
 =?utf-8?B?WFBzMFNPejVvaENuR2RYZko1YUhTT3Z1UTVjSE8xWFpIL2VqZjRYajNIQ29K?=
 =?utf-8?B?b0xRSDlHVEtXSkVvNHdrblNuY2U2djRWbER4KzlHZzRJb0ZjV3lUR1NsdWd6?=
 =?utf-8?B?Q3JvaHpXSk5WcU5FYzk3MzZzQUlOV3JHZEZHb1Iwbi9SVW9sM2VkMjhuTnVQ?=
 =?utf-8?B?ak50U2o5YnZLbHZKLzRrQ1NPa2xCRlQrWWI3KzFRQ0p0Zm15OE9oTGdyc0JJ?=
 =?utf-8?B?RDVTaDBoQTZQcVBOTnJNMGRlYUNUaWJ6dlIxUWN2bnowUnkrdHRycDBJNlpu?=
 =?utf-8?B?Q3RLWkRYZFl2SWNwdkxGTWs3OHdabWtmV1M1dkZVbjE3VnAxSjF3UDlRS25T?=
 =?utf-8?B?U2tJRU5SaGdzWTAyVmdYQmppV2JJNDZnRkE2T3dKQitMc3hVTXdnRkxMTmRN?=
 =?utf-8?B?bkMreHJTMk9QblAvcktWSWMrcm9FZll3bTA3dU5JWXU2cFBPRjdPcC9QalpM?=
 =?utf-8?B?SnoveCtvSURxQ2I4ZENJS2FpK250c25aTUpYUFRWeHYvK3dZODhuNWEwL0FX?=
 =?utf-8?B?ditWYm9UYU04Ym9LV1BWMERGa2xocWhiM1I2MjNVSmxxdTZ3QlFKNjBKOW9N?=
 =?utf-8?B?Q2pPTnpyeDVWMXNtT1BPRHd3WWhtQm9ncDdxaWM2R0VNZ1A5MkszbHJvQnRs?=
 =?utf-8?B?TXNMazZINjZSd3RCcS9hVGtYSlI2ODRoMHk2ZzlTL3UwcFRITFBlaUZoY1Bp?=
 =?utf-8?B?NjRLeVVjSTF3eEdkdnluT0hGU21BOGlyS09RQTAxdzNMaDMrTEJvM3ovUk54?=
 =?utf-8?B?Vkh5QlFpMjExYzE3ZVdMVFZFN2lxbUEzN0N2d01RSmgzY3hrZXZIMnNBY2Zq?=
 =?utf-8?B?cDRVbDJMK2hNSnVDM1RPQ2FXN2xjR0ZiZllHaVFsK3puR0NJRGVYdTBVVFcw?=
 =?utf-8?B?RE1iRFZseEptODRGK0UvaVlMTVBlKzA2TzBnWHVwTEh5ZGZkMG54L2F0d2hQ?=
 =?utf-8?B?dnVUdVczTmpKblFDMWoxWVRvcG1QelQwcDUwSzNpRmUyYnFjMGt3cmZUdEhC?=
 =?utf-8?B?Nk4xN0VjNVVnVDc0aHg1MkM1V3djb1Bjb1piSWp4cUZKdno0ekR0eGpERTdZ?=
 =?utf-8?B?SlJ1dzI1WHRYU0RCREx2d0FhSEVhaTgvVGFjekVHelpwR2djdEhJdnNFbk1k?=
 =?utf-8?B?SjlGSzdNQXU5K2NoUzdVWTdQZXdzeHFXTEhDTVhGMVVjRjRkaUg4aTRqUVJI?=
 =?utf-8?B?YmVURXRaRFpJUytnUEFwblI3YmtIUSt4elhoUjFEcGhLcmorWlJsNWtONWJ0?=
 =?utf-8?B?UEM5T0JMQ2Q5K2thVGJkd2lUc3JnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE2215EC80943D4BA2E8309F222CD91A@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b98b11-5e30-41bf-4dac-08dcd02717d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2024 16:55:50.2009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZaXjjVgvZL171KMv4Glj62e4U5KBs87leiMn1BTkH/Sp936aYcM96LXize8ujp+oh5ZOC2VLnOf7wUj/4cio2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3910

T24gU3VuLCAyMDI0LTA5LTA4IGF0IDE3OjM0ICswMzAwLCBSb2kgQXphcnphciB3cm90ZToNCj4g
SGksDQo+IA0KPiBhcyBkaXNjdXNzZWQgd2l0aCBASmVmZiBMYXl0b24gc2VuZGluZyBhIHN1Z2dl
c3RlZCBwYXRjaCB0aGF0IGFpbXMgdG8NCj4gZml4IE5GU19DQVBfREVMRUdUSU1FIGNhcGFiaWxp
dHkgaW5kaWNhdGlvbiBpbiB0aGUgY2xpZW50IHNpZGUgYnkNCj4gc2V0dGluZyBpdCBhY2NvcmRp
bmcgdG8gRkFUVFI0X09QRU5fQVJHVU1FTlRTIHJlc3BvbnNlIChhbmQgbm90DQo+IGFjY29yZGlu
ZyB0byBUSU1FX0RFTEVHX01PRElGWSkgc3VwcG9ydCBhcyBkcmFmdC1pZXRmLW5mc3Y0LWRlbHN0
aWQtDQo+IDAyDQo+IMKgc3VnZ2VzdGVkLg0KPiANCg0KTkFDSy4gSSBhZ3JlZSB0aGF0IHdlIHNo
b3VsZCB0dXJuIG9mZiBORlNfQ0FQX0RFTEVHVElNRSBpZiB0aGUgb3Blbg0KYXJndW1lbnRzIGRv
bid0IHN1cHBvcnQgaXQsIGJ1dCB3ZSBzaG91bGQgbm90IHR1cm4gaXQgb24gdW5sZXNzIHRoZQ0K
c2VydmVyIGhhcyBpbmRpY2F0ZWQgdGhhdCBpdCBzdXBwb3J0cyB0aGUgYXR0cmlidXRlLg0KDQpp
LmUuIHRoZSBjb3JyZWN0IGNoYW5nZSBoZXJlIGlzDQoNCisJCWlmICghKHJlcy5vcGVuX2NhcHMu
b2Ffc2hhcmVfYWNjZXNzX3dhbnRbMF0gJg0KKwkJICAgICAgTkZTNF9TSEFSRV9XQU5UX0RFTEVH
X1RJTUVTVEFNUFMpKQ0KKwkJCXNlcnZlci0+Y2FwcyAmPSB+TkZTX0NBUF9ERUxFR1RJTUU7DQoN
Ci0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

