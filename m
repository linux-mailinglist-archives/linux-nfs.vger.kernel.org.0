Return-Path: <linux-nfs+bounces-7022-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28346998B78
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 17:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2CC9B2FC80
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 15:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B4F1CCB2A;
	Thu, 10 Oct 2024 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="ZB9nSxMv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2122.outbound.protection.outlook.com [40.107.93.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA701CF285
	for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572174; cv=fail; b=K9SuAazmP8rU+AFBsCI393kJZd6qqKtT93F2vGNjZy8+fR+5gvcJDoGizaccHC+7QteSYzB36D8UDZmPdxlodCqdgUROTnZ5k+EWaCgh6KYenDWIcdCngspB7QtbHq2BdW9cboAan08SehJAJ4vaMWGXopFu38mN1cKJLJtDhr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572174; c=relaxed/simple;
	bh=wjjKTTnQnFb+9H7NyfppogE5I1dGq6Kg6DB6eNT+EkE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CEe+59TZvuihMgTrtG/GYRJ1t26s19yhs/GjLJOZWDQVDYMUedcPbRjATtJCdbPSrIGByjDTtu+KorRFxhgDPJ77HwfcqHqawqfl2N/EWW5R6KIAMNZ8pve3iJdyhnUk+BJp6RX6QhTyGtrpslwGI9pXAe3k4ruXIjyVG7CNu34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=ZB9nSxMv; arc=fail smtp.client-ip=40.107.93.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1Rc9knqO3j6323a8mfz6qqY4f/l0jath97QAPdgZOPaz9+CPiKMiMYMosgII3Z49kPTEZO2uihpo7iPdDTzlWF1aB+w6x1EAq2pFLcXLLenTwEYhN00rdmUt+GcrmCwfFOn//KzY6NNe5meVnUdkX+bYu3kzxdfDK9sT9DhCBgFVzDv1YzeOZvC4J6k8i8UD/e5Xu3pa3+ViSpik0qo/fgfkhZKB+wKcd0giQ9GG9mfJ9koPKxvbfx4IB4m+ggh/yzzCoP3pNeNyZQcO6K2aW6DgbOtWD5DpJHpEwWx3wFkZpl4RrsIg00BBWD3VmeCs/KPTipNENwZeN4nIATanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjjKTTnQnFb+9H7NyfppogE5I1dGq6Kg6DB6eNT+EkE=;
 b=hrCkosieV/dJu/eVPtsfJ6p+fx7xPsHFWgz5wL+HzN8LsMSQvtMGRegDX7wQd3uhMWn5TNoFTLeWzaeGDajfiIy+dXKWxYT7t16s/mFnCibZQdZtgM7Mi3D8WFDhJxoBCNy3/Jwl61RHMh4jLL63p62s0KsQ8LYFP7zuU6nFL9193hxPYRJ3Pn+2SwDiM/JYazpNjBl+pfODusGf/oiOFXHrIzGPc4T8nDuDagZGiFP6mSSnhSg9MQQN4/v7k+1WsT6mYbVmRZ/LWSBIHpwrgwW+LqBuNg3LlnPUSQnKP9ujpGWLhfa3wdL/6ClGKO8XZjZ1LMv1d0EvD+bwfbojkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjjKTTnQnFb+9H7NyfppogE5I1dGq6Kg6DB6eNT+EkE=;
 b=ZB9nSxMv2KyQWtseY3/wUzf2NvYb8B73dartpu3o36lM5XqFu5Y9pidnM0hHWIo9Z02QqFLUFG+o30wg7GOe0dF0LZExib+OV3+PikplI0Bu/NXowG6LIGpz+fBC6cIGEHBNl035Wr3J0e5xDHYnZ5JdeR/59yt86aLYxNINDmQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA6PR13MB6901.namprd13.prod.outlook.com (2603:10b6:806:415::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 14:56:08 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 14:56:08 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "yangerkun@huaweicloud.com" <yangerkun@huaweicloud.com>, "anna@kernel.org"
	<anna@kernel.org>, "yangerkun@huawei.com" <yangerkun@huawei.com>,
	"anna.schumaker@oracle.com" <anna.schumaker@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH] NFSV4: fix rpc_task use-after-free when open concurrently
Thread-Topic: [PATCH] NFSV4: fix rpc_task use-after-free when open
 concurrently
Thread-Index:
 AQHbD9t+pj8ZWRUwq0W3P3OOkzvhNbJsIDQAgAHgxYCAD87kaIAAxtOAgADXMACAALt7gA==
Date: Thu, 10 Oct 2024 14:56:08 +0000
Message-ID: <0b1929fd7f31660c83c49c3829a9141a9dc9aa9f.camel@hammerspace.com>
References: <20240926061210.3309559-1-yangerkun@huaweicloud.com>
	 <929c8087-e28b-43e9-8973-71d9f1b821d6@oracle.com>
	 <965aad29-d119-b3bb-1a19-0c52c28fd376@huaweicloud.com>
	 <ec268559-2b29-c7b1-85b8-7a86a4ba228a@huawei.com>
	 <086eb949-6d07-e5af-da65-e4bccf84dd1a@huaweicloud.com>
	 <edd32ea932f9b24fe188ffbadb28bc8bf4e066dd.camel@hammerspace.com>
	 <ce018620-221e-1ff5-1230-467be841dc5f@huaweicloud.com>
In-Reply-To: <ce018620-221e-1ff5-1230-467be841dc5f@huaweicloud.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA6PR13MB6901:EE_
x-ms-office365-filtering-correlation-id: 449dce4c-4e40-4fec-da6d-08dce93bac62
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aDFseTYwK0hKTkNoTE9aVitGSFpvU1Z4bS91VnJWeU1MYjdPN01rZjFRRHFh?=
 =?utf-8?B?VWhyZk5KYm1HRG1nNXVPU25DWkRyeEZTZDhjNlIxT3hFODNtMzExMExDOHZF?=
 =?utf-8?B?Q3NhdUVUTUM3SjRxNmUzVzliVlFzcWlYQzlwTWorYURNd0tON2E1aCtHTkx4?=
 =?utf-8?B?K3NMV3dQVi9lR3MyQW5Db3o2LzZ6L3hyUUh3MDB6dTdWRzlhQzdkbDgwcVRn?=
 =?utf-8?B?NGY1cHZ4WW51YzUvbmRwejZDV0ExbzlWQXNsVDVEQXZCMjdvczdWdGRxMG1S?=
 =?utf-8?B?RHlkMTJ1dllEbFBtcHkveWY3NkhhS1JvYVByaWR0YmpFaE9YWnd2dTVjMkF0?=
 =?utf-8?B?YVY4SUtNcE5uaGlqdTJpVy92bkdQclRwSllMU0VHM3RHbWZScU9LVC9RL2FK?=
 =?utf-8?B?R0ZzbmJ3ODNXaVdhTG5zYXozZUFSZC9PbU5nQjNJRVJwakVLd0lIVDBXNkxy?=
 =?utf-8?B?RGpIeW9kY1JzNHEzRmYzMk9JUmVhc085ODN5ZDgzMkFDVEVnY25Ib0dWekxa?=
 =?utf-8?B?dHRTcWRvdENnMlBHNm9VMnVOdk5wejFjR2duYm9oaS9BZytFTWVMeXdtaHdX?=
 =?utf-8?B?ZmhIeEl4SlhucXVaaTl4TmM0Tno2V01rMkc5dUtHbytVL3JSNGJvbzVTNTRx?=
 =?utf-8?B?L1dKdjRETkhHMEFHclNoMi9tMC84aWhhZDJma3E1d2pGQmRreUx0d2Q5UmIx?=
 =?utf-8?B?VS85QlRabzIrWEVsaVZ3bkVSMktJajJpb2x3SWordDluekdXM1U2RmtpeUlK?=
 =?utf-8?B?L0hBV2dUdTRibi9RZW5nTWtzc0ZuT0JhM1RaUi8ycXFCRy9VRXR1bEVvTkJZ?=
 =?utf-8?B?azR1V0lhTWc0cVVxNzBhcEFvd0xPK3RQd3JzTUd3L25STnhpanNTNFdOQlIv?=
 =?utf-8?B?eEFlSjZEQUFHVEpSYjZ6ZUZHVW5zSDJVWHJoVk5seDVxYktwY2xjdXJzZVBr?=
 =?utf-8?B?cGV2VDlHblRUNnFpRTBEYWVFWEJSL1ZFOWdpWUw2WmJpQkJuem1VelhyeU8v?=
 =?utf-8?B?MUtKRmxZdGJDSUdHUE1PZXFNRjIzODdjdC9EVUJ0YmRrL0VnNzJUOEhOZGRs?=
 =?utf-8?B?U1hLR0tMeE9wRjNNajRxTVRIUzJOancvR0w4bktpUEQ4TlBOampDUFBrZ2VD?=
 =?utf-8?B?Tk9nMjBuY2RCdUs2aENCWDhOcnhVWW1LSTl2TEQwY3pibmMveHN6VU0zWnln?=
 =?utf-8?B?STF2ak5KSm8vcXFVTDVtTlZpNUlUSlVRcFVsd3lhcWlLcFNTT1hMRythS2hr?=
 =?utf-8?B?QlVjVHFxNE8xZE5qck84Q3FtSGJxSEZvWnkvbFdQR1huODVXT0FjbThWb3pz?=
 =?utf-8?B?Wm1MT05Fc0R0SHFNQW9BSjVkMWY2NUhITW83YmhSdGRKakFhN0I4Y3VFbzNB?=
 =?utf-8?B?aU9QVWVpZGR0UTYrc2FvK3NjWkYvZ2VsQzY3ajNEbGoyMjdMbjdPWUNGYS95?=
 =?utf-8?B?ZVJMYm9YZkFrelBrMUh5WlZTNnlJWUt5WmcrZXJJU3MreDBhZUQzSitWOUEr?=
 =?utf-8?B?UmhoS3hxTUxDR2pFNnZtNmVzV05WanZmbFBvdmphNURFMFVGMzlVdTRnYVE2?=
 =?utf-8?B?VFQ1dkFlaEpxSFVYeXZXaTVUVWQ0a3VVbmVxbHVYWkIzbEt3ekEvQkVEZWNI?=
 =?utf-8?B?ZVRmK05EWmk5MllISEZ2bHQwelE0MlcwdlU4SVdnYjFoV1A5ak00UDQ5c09i?=
 =?utf-8?B?NXExVVhkMXU3bUduZjI2b1YyTDJhYncvVFdCbEFXZFJ3WlpZL08vaDZrd1gx?=
 =?utf-8?B?K0JqVGZCOWdtek5KY3VSb2NicXRNanQyNFYrWkt5dFltYU5pSFhTSmdCYklN?=
 =?utf-8?B?R3h2YmdGdHpLdnh6M2Fldz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEVjVnd0eHN2Rnl5SVZrS0tpZXZyQXBjSHo1dzQydEhKZ1dSQ1F1Kzd1c0Vt?=
 =?utf-8?B?OGpDZWVrc2MvMTdjVGxKMmpNQmZEUi9qbWE0STlpdENKUmNPSEE1Zmt5M3ox?=
 =?utf-8?B?c0pZZGdWRTI5anp2bXprYTlIU3dxZ3pMYWtHbjgyMUpKQVZHaTFBTmNWV3Mw?=
 =?utf-8?B?RFZkL1Zwc0xTenBPZHR5M0JuNTNNQ05IMk1RaDZFSnA4b1JVYW1GMkptUTRV?=
 =?utf-8?B?NC9vaGdvcGFJajlVSUo5RmVBeHNEdUNzai9LdTYwUW4weE1Ca0hwN2R0MnRp?=
 =?utf-8?B?K0srd0krNVVRSk1IRHdLQnBpS0xYaEZMQ25iM29rRXlGbzdOMnR4amMxNUkv?=
 =?utf-8?B?M1hBNXFaUW1OZExUT2piTFlsZmJ5RWVpdHh0VERoZnNZYmdGY1pITGJORnpJ?=
 =?utf-8?B?YnBpRGR3RXFHczZrV05OOU1WTFBHSHEvTjNwNmR0YXRRQ212TFpsNFBpZG1Y?=
 =?utf-8?B?aUZidktRMXNOVXNSbmhVL3pNRzF5TFJ5L3k2bjAwNXJzNmFnSlpkQUsxaHhE?=
 =?utf-8?B?dmdXMWZxOTVvMzdJbDg1UStESWZ2YnRuTUNOYlVxTm11RFVyNkg1dll2RjQ4?=
 =?utf-8?B?c3VkVmxJTmdpaXdUMUtEeWpnNS82aTFUQnAreUwvNkFoZU5FUkY2WGRNTU41?=
 =?utf-8?B?cXlMcU1iWEh5dmwzM1p6cDFWdlc4MDFhc2IrZ01mMjZPWDNad05BQ2VZQ3lB?=
 =?utf-8?B?TjcySzE1MU9yK0ljYnVlS3dGQ2RJbk9CYkI5d2gzdlRzMW5kQXNyVUZMN29P?=
 =?utf-8?B?cnpjM29OalhPMnFzYzFUMnorU2hBQkN1ZU9vWFdaa0Y0TU1QemFCL092RGZJ?=
 =?utf-8?B?UnVqc25SQnVSb25JVGRCZ2Q3NXZOclNCRUltWEZ4Z0Vyb0NaY1JjTWd4dXJL?=
 =?utf-8?B?dkJwSE9mSy9LRzFOUFZ1dmhFZlJWbWp0eThJQzBpekkyT2MxV0tERHdpZ0wv?=
 =?utf-8?B?MXQwa1p0M296d2t0UHFpdFk3enBEVlJnbG9GR2w1c2VUenlkZE16M1l5WEhI?=
 =?utf-8?B?VnlEeGFlNmVsa1NyNmRVM3ZwSnhpbUdYZE5QMUxqVWlra3VRSWV4QjB4dkpY?=
 =?utf-8?B?TFFwYnFEZHhGUDhBRkd1aUdJRFJhU1IzL3c0TVNScklGNDdqMEt0RllnSnhF?=
 =?utf-8?B?eS9TcDJIQVkvL1lFdVNUV3NEM1Rqekx2YWM5UElmdVU1MGVLK1RKMzRDUVlE?=
 =?utf-8?B?ZWlwWFBiVHQ0NDBKYUttV21BNy9yMm9vcTNGRGNQVVUyN3ZYQVNuZnZmZjFp?=
 =?utf-8?B?N0hIeUNYdC9MbnBFTXFTdDRleHVuNU1WU0hETHYzRVRxc1JKM0IwdGxQbUVa?=
 =?utf-8?B?RGJDRGhmVnplSENUSTBvMllpNjhWZ2s1cXVJbUdnMlBaOHFza3J4K3Q0eC8v?=
 =?utf-8?B?Tk5JUmQ0aDEwSzdSUDJnUXVYcDArNmdORmJ6TEpYbG8rZDRsS1YvZVloK1Zw?=
 =?utf-8?B?ajAyWWNMQ1lWdCtqc3NnSk9yb2J1M3pBY2txR2VNOHlpcFl4MHF2UFkwaWdJ?=
 =?utf-8?B?Q2JlcFZUZW5JS3RIcnNwdWdFd054NUhaMkQ0V3NyalpyWnhrSGV4V1NTeWkv?=
 =?utf-8?B?b3pTM005RzR5MG8zc01kRGUvdE1IRUJzS0NyZ285QXhBZ0tWWFhKT3RiMERV?=
 =?utf-8?B?R1RmQy9ZSUVLa0RpNkcxUVIwUlNlemFOS0lVWWdWbWFWQnZoRUFkdXVZWVNE?=
 =?utf-8?B?YXdmVDRMWmdjcEdkeExHUklUSkpOejh5ZnRuZ3U5RVlFWGtFeGlxdUNSMUpN?=
 =?utf-8?B?ZlYxYXo1RURhMXJOdWE2R0wvVGZVVW1hVDNDM1dxaHloNUhYaURkbllBajB4?=
 =?utf-8?B?Z1duZ1p2SUFYaEN4cUxGREZQcFNoa2pOUXhaTXlYUjVtczdtZldZcHZ4bVFa?=
 =?utf-8?B?L25KWnJWSkhzZGM0VWlaS1BXMkxiQi96R2tONTVjdkRmNkhSenp6eE44VTIr?=
 =?utf-8?B?Mm9kWXEzYW1vZ0MxUHlSeWFYQ2Y0aGJ5Z2l3Q2IvNlowUnNqTW1WYXFMUEw5?=
 =?utf-8?B?OWo0T0l1YU5RWHI4NnZMQ2FYMnNHM0hVWDJ3Tm5ES0ROZzNvdlphcEw2RFhh?=
 =?utf-8?B?MVlSMGZXUHNHcmtEOFl5VTJiVENsTGY3LzNlZUhiVjh4aDBJRDFiVzRRL1VL?=
 =?utf-8?B?RUdSOW9kdVhLdWtnZEtLcElCajNKMDVPUjJwZ3ZUNVFuaU03VnpoSlVDYmFn?=
 =?utf-8?B?M2E1RTR2TCs2SlR3TTNGZElxSERIeXZCbThtZlErZEkxczVLVlhkbFRVc25o?=
 =?utf-8?B?YlFuQWZnSTc3ekxzNjBZVjNhNmVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C76C88357D27964BB6D9F372357D682D@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 449dce4c-4e40-4fec-da6d-08dce93bac62
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 14:56:08.4237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VkIdWCO8DXnDQsiFI2vOfSjmD/CH5DME7Zn+1jJkjs6hwprzR90ES7+i6f2BXF8GJRJmElqcz0hvjj/HTAeTVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB6901

T24gVGh1LCAyMDI0LTEwLTEwIGF0IDExOjQ1ICswODAwLCB5YW5nZXJrdW4gd3JvdGU6DQo+IFtZ
b3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20geWFuZ2Vya3VuQGh1YXdlaWNsb3VkLmNvbS4g
TGVhcm4gd2h5DQo+IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJv
dXRTZW5kZXJJZGVudGlmaWNhdGlvbsKgXQ0KPiANCj4g5ZyoIDIwMjQvMTAvOSAyMjo1NCwgVHJv
bmQgTXlrbGVidXN0IOWGmemBkzoNCj4gPiBPbiBXZWQsIDIwMjQtMTAtMDkgYXQgMTE6MDIgKzA4
MDAsIHlhbmdlcmt1biB3cm90ZToNCj4gPiA+IEhpLA0KPiA+ID4gDQo+ID4gPiBQaW5nIGZvciB0
aGlzIHBhdGNoLi4uDQo+ID4gPiANCj4gPiA+IOWcqCAyMDI0LzkvMjkgOTo0NSwgeWFuZ2Vya3Vu
IOWGmemBkzoNCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiDlnKggMjAyNC85LzI5IDk6Mzgs
IHlhbmdlcmt1biDlhpnpgZM6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g5Zyo
IDIwMjQvOS8yOCA0OjU4LCBBbm5hIFNjaHVtYWtlciDlhpnpgZM6DQo+ID4gPiA+ID4gPiBIaSBZ
YW5nLA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBPbiA5LzI2LzI0IDI6MTIgQU0sIFlhbmcg
RXJrdW4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IEZyb206IFlhbmcgRXJrdW4gPHlhbmdlcmt1bkBo
dWF3ZWkuY29tPg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gVHdvIHRocmVhZHMgdGhh
dCB3b3JrIHdpdGggdGhlIHNhbWUgY3JlZCB0cnkgdG8gb3Blbg0KPiA+ID4gPiA+ID4gPiBkaWZm
ZXJlbnQgZmlsZXMNCj4gPiA+ID4gPiA+ID4gY29uY3VycmVudGx5LCB0aGV5IHdpbGwgdXRpbGl6
ZSB0aGUgc2FtZQ0KPiA+ID4gPiA+ID4gPiBuZnM0X3N0YXRlX293bmVyLg0KPiA+ID4gPiA+ID4g
PiBBbmQgaW4gb3JkZXINCj4gPiA+ID4gPiA+ID4gdG8gc2VxdWVudGlhbCBvcGVuIHJlcXVlc3Qg
c2VuZCB0byBzZXJ2ZXIsIHRoZSBzZWNvbmQNCj4gPiA+ID4gPiA+ID4gdGFzaw0KPiA+ID4gPiA+
ID4gPiB3aWxsIGZhbGwNCj4gPiA+ID4gPiA+ID4gaW50byBSUENfVEFTS19RVUVVRUQgaW4gbmZz
X3dhaXRfb25fc2VxdWVuY2Ugc2luY2UgdGhlcmUNCj4gPiA+ID4gPiA+ID4gaXMNCj4gPiA+ID4g
PiA+ID4gYWxyZWFkeSBvbmUNCj4gPiA+ID4gPiA+ID4gd29yayBkb2luZyB0aGUgb3BlbiBvcGVy
YXRpb24uIEZ1cnRoZXJtb3JlLCB0aGUgc2Vjb25kDQo+ID4gPiA+ID4gPiA+IHRhc2sNCj4gPiA+
ID4gPiA+ID4gd2lsbCB3YWl0DQo+ID4gPiA+ID4gPiA+IHVudGlsIHRoZSBmaXJzdCB0YXNrIGNv
bXBsZXRlcyBpdHMgd29yaywgY2FsbA0KPiA+ID4gPiA+ID4gPiBycGNfd2FrZV91cF9xdWV1ZWRf
dGFzayBpbg0KPiA+ID4gPiA+ID4gPiBuZnNfcmVsZWFzZV9zZXFpZCB0byB3YWtlIHVwIHRoZSBz
ZWNvbmQgdGFzaywgYWxsb3dpbmcgaXQNCj4gPiA+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiA+ID4g
Y29tcGxldGUNCj4gPiA+ID4gPiA+ID4gdGhlIHJlbWFpbmluZyBvcGVuIG9wZXJhdGlvbi4NCj4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFRoZSBwcmVjZWRpbmcgbG9naWMgZG9lcyBub3Qg
Y2F1c2UgYW55IHByb2JsZW1zIHVuZGVyDQo+ID4gPiA+ID4gPiA+IG5vcm1hbA0KPiA+ID4gPiA+
ID4gPiBjaXJjdW1zdGFuY2VzLiBIb3dldmVyLCB3aGVuIG9uY2Ugd2UgZm9yY2UgYW4gdW5tb3Vu
dA0KPiA+ID4gPiA+ID4gPiB1c2luZw0KPiA+ID4gPiA+ID4gPiBgdW1vdW50DQo+ID4gPiA+ID4g
PiA+IC1mYCwNCj4gPiA+ID4gPiA+ID4gdGhlIGZ1bmN0aW9uIG5mc191bW91bnRfYmVnaW4gYXR0
ZW1wdHMgdG8ga2lsbCBhbGwgdGFza3MNCj4gPiA+ID4gPiA+ID4gYnkNCj4gPiA+ID4gPiA+ID4g
Y2FsbGluZw0KPiA+ID4gPiA+ID4gPiBycGNfc2lnbmFsX3Rhc2suIFRoaXMgaGVscCB3YWtlIHVw
IHRoZSBzZWNvbmQgdGFzaywgYnV0DQo+ID4gPiA+ID4gPiA+IGl0DQo+ID4gPiA+ID4gPiA+IHNl
dHMgdGhlDQo+ID4gPiA+ID4gPiA+IHN0YXR1cyB0byAtRVJFU1RBUlRTWVMuIFRoaXMgc3RhdHVz
IHByZXZlbnRzDQo+ID4gPiA+ID4gPiA+IGBuZnM0X29wZW5fcmVsZWFzZWAgZnJvbQ0KPiA+ID4g
PiA+ID4gPiBjYWxsaW5nIGBuZnM0X29wZW5kYXRhX3RvX25mczRfc3RhdGVgLiBDb25zZXF1ZW50
bHksDQo+ID4gPiA+ID4gPiA+IHdoaWxlDQo+ID4gPiA+ID4gPiA+IHRoZSBzZWNvbmQNCj4gPiA+
ID4gPiA+ID4gdGFzayB3aWxsIGJlIGZyZWVkLCB0aGUgb3JpZ2luYWwgdGFza3Mgd2lsbCBzdGls
bCBleGlzdA0KPiA+ID4gPiA+ID4gPiBpbg0KPiA+ID4gPiA+ID4gPiBzZXF1ZW5jZS0+bGlzdChz
ZWUgbmZzX3JlbGVhc2Vfc2VxaWQpLiBMYXR0ZXIsIHdoZW4gdGhlDQo+ID4gPiA+ID4gPiA+IGZp
cnN0DQo+ID4gPiA+ID4gPiA+IHRocmVhZA0KPiA+ID4gPiA+ID4gPiBjYWxscyBuZnNfcmVsZWFz
ZV9zZXFpZCBhbmQgYXR0ZW1wdHMgdG8gd2FrZSB1cCB0aGUNCj4gPiA+ID4gPiA+ID4gc2Vjb25k
DQo+ID4gPiA+ID4gPiA+IHRhc2ssIGl0DQo+ID4gPiA+ID4gPiA+IHdpbGwNCj4gPiA+ID4gPiA+
ID4gdHJpZ2dlciB0aGUgdWFmLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gVG8gcmVz
b2x2ZSB0aGlzIGlzc3VlLCBlbnN1cmUgcnBjX3Rhc2sgd2lsbCByZW1vdmUgaXQNCj4gPiA+ID4g
PiA+ID4gZnJvbQ0KPiA+ID4gPiA+ID4gPiBzZXF1ZW5jZS0+bGlzdCBieSBhZGRpbmcgbmZzX3Jl
bGVhc2Vfc2VxaWQgaW4NCj4gPiA+ID4gPiA+ID4gbmZzNF9vcGVuX3JlbGVhc2UuDQo+ID4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiA+ID4gPiA+ID4gPT09PQ0KPiA+ID4gPiA+ID4g
PiA9PT09PQ0KPiA+ID4gPiA+ID4gPiBCVUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIGlu
DQo+ID4gPiA+ID4gPiA+IHJwY193YWtlX3VwX3F1ZXVlZF90YXNrKzB4YmIvMHhjMA0KPiA+ID4g
PiA+ID4gPiBSZWFkIG9mIHNpemUgOCBhdCBhZGRyIGZmMTEwMDAwMDc2Mzk5MzAgYnkgdGFzayBi
YXNoLzc5Mg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gQ1BVOiAwIFVJRDogMCBQSUQ6
IDc5MiBDb21tOiBiYXNoIFRhaW50ZWQ6IEfCoMKgwqAgQsKgwqAgVw0KPiA+ID4gPiA+ID4gPiA2
LjExLjAtMDk5NjAtZ2QxMGI1OGZlNTNkYy1kaXJ0eSAjMTANCj4gPiA+ID4gPiA+ID4gVGFpbnRl
ZDogW0JdPUJBRF9QQUdFLCBbV109V0FSTg0KPiA+ID4gPiA+ID4gPiBIYXJkd2FyZSBuYW1lOiBR
RU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwNCj4gPiA+ID4gPiA+ID4gQklP
Uw0KPiA+ID4gPiA+ID4gPiAxLjE2LjEtMi5mYzM3IDA0LzAxLzIwMTQNCj4gPiA+ID4gPiA+ID4g
Q2FsbCBUcmFjZToNCj4gPiA+ID4gPiA+ID4gwqDCoCA8VEFTSz4NCj4gPiA+ID4gPiA+ID4gwqDC
oCBkdW1wX3N0YWNrX2x2bCsweGEzLzB4MTIwDQo+ID4gPiA+ID4gPiA+IMKgwqAgcHJpbnRfYWRk
cmVzc19kZXNjcmlwdGlvbi5jb25zdHByb3AuMCsweDYzLzB4NTEwDQo+ID4gPiA+ID4gPiA+IMKg
wqAgcHJpbnRfcmVwb3J0KzB4ZjUvMHgzNjANCj4gPiA+ID4gPiA+ID4gwqDCoCBrYXNhbl9yZXBv
cnQrMHhkOS8weDE0MA0KPiA+ID4gPiA+ID4gPiDCoMKgIF9fYXNhbl9yZXBvcnRfbG9hZDhfbm9h
Ym9ydCsweDI0LzB4NDANCj4gPiA+ID4gPiA+ID4gwqDCoCBycGNfd2FrZV91cF9xdWV1ZWRfdGFz
aysweGJiLzB4YzANCj4gPiA+ID4gPiA+ID4gwqDCoCBuZnNfcmVsZWFzZV9zZXFpZCsweDFlMS8w
eDJmMA0KPiA+ID4gPiA+ID4gPiDCoMKgIG5mc19mcmVlX3NlcWlkKzB4MWEvMHg0MA0KPiA+ID4g
PiA+ID4gPiDCoMKgIG5mczRfb3BlbmRhdGFfZnJlZSsweGM2LzB4M2UwDQo+ID4gPiA+ID4gPiA+
IMKgwqAgX25mczRfZG9fb3Blbi5pc3JhLjArMHhiZTMvMHgxMzgwDQo+ID4gPiA+ID4gPiA+IMKg
wqAgbmZzNF9kb19vcGVuKzB4MjhiLzB4NjIwDQo+ID4gPiA+ID4gPiA+IMKgwqAgbmZzNF9hdG9t
aWNfb3BlbisweDJjNi8weDNhMA0KPiA+ID4gPiA+ID4gPiDCoMKgIG5mc19hdG9taWNfb3Blbisw
eDRmOC8weDExODANCj4gPiA+ID4gPiA+ID4gwqDCoCBhdG9taWNfb3BlbisweDE4Ni8weDRlMA0K
PiA+ID4gPiA+ID4gPiDCoMKgIGxvb2t1cF9vcGVuLmlzcmEuMCsweDNlNy8weDE1YjANCj4gPiA+
ID4gPiA+ID4gwqDCoCBvcGVuX2xhc3RfbG9va3VwcysweDg1ZC8weDEyNjANCj4gPiA+ID4gPiA+
ID4gwqDCoCBwYXRoX29wZW5hdCsweDE1MS8weDdiMA0KPiA+ID4gPiA+ID4gPiDCoMKgIGRvX2Zp
bHBfb3BlbisweDFlMC8weDMxMA0KPiA+ID4gPiA+ID4gPiDCoMKgIGRvX3N5c19vcGVuYXQyKzB4
MTc4LzB4MWYwDQo+ID4gPiA+ID4gPiA+IMKgwqAgZG9fc3lzX29wZW4rMHhhMi8weDEwMA0KPiA+
ID4gPiA+ID4gPiDCoMKgIF9feDY0X3N5c19vcGVuYXQrMHhhOC8weDEyMA0KPiA+ID4gPiA+ID4g
PiDCoMKgIHg2NF9zeXNfY2FsbCsweDI1MDcvMHg0NTQwDQo+ID4gPiA+ID4gPiA+IMKgwqAgZG9f
c3lzY2FsbF82NCsweGE3LzB4MjQwDQo+ID4gPiA+ID4gPiA+IMKgwqAgZW50cnlfU1lTQ0FMTF82
NF9hZnRlcl9od2ZyYW1lKzB4NzYvMHg3ZQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
Li4uDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBBbGxvY2F0ZWQgYnkgdGFzayA3Njc6
DQo+ID4gPiA+ID4gPiA+IMKgwqAga2FzYW5fc2F2ZV9zdGFjaysweDNiLzB4NzANCj4gPiA+ID4g
PiA+ID4gwqDCoCBrYXNhbl9zYXZlX3RyYWNrKzB4MWMvMHg0MA0KPiA+ID4gPiA+ID4gPiDCoMKg
IGthc2FuX3NhdmVfYWxsb2NfaW5mbysweDQ0LzB4NzANCj4gPiA+ID4gPiA+ID4gwqDCoCBfX2th
c2FuX3NsYWJfYWxsb2MrMHhhZi8weGMwDQo+ID4gPiA+ID4gPiA+IMKgwqAga21lbV9jYWNoZV9h
bGxvY19ub3Byb2YrMHgxZTAvMHg0ZjANCj4gPiA+ID4gPiA+ID4gwqDCoCBycGNfbmV3X3Rhc2sr
MHhlNy8weDIyMA0KPiA+ID4gPiA+ID4gPiDCoMKgIHJwY19ydW5fdGFzaysweDI3LzB4N2QwDQo+
ID4gPiA+ID4gPiA+IMKgwqAgbmZzNF9ydW5fb3Blbl90YXNrKzB4NDc3LzB4ODEwDQo+ID4gPiA+
ID4gPiA+IMKgwqAgX25mczRfcHJvY19vcGVuKzB4YzAvMHg2ZDANCj4gPiA+ID4gPiA+ID4gwqDC
oCBfbmZzNF9vcGVuX2FuZF9nZXRfc3RhdGUrMHgxNzgvMHhjNTANCj4gPiA+ID4gPiA+ID4gwqDC
oCBfbmZzNF9kb19vcGVuLmlzcmEuMCsweDQ3Zi8weDEzODANCj4gPiA+ID4gPiA+ID4gwqDCoCBu
ZnM0X2RvX29wZW4rMHgyOGIvMHg2MjANCj4gPiA+ID4gPiA+ID4gwqDCoCBuZnM0X2F0b21pY19v
cGVuKzB4MmM2LzB4M2EwDQo+ID4gPiA+ID4gPiA+IMKgwqAgbmZzX2F0b21pY19vcGVuKzB4NGY4
LzB4MTE4MA0KPiA+ID4gPiA+ID4gPiDCoMKgIGF0b21pY19vcGVuKzB4MTg2LzB4NGUwDQo+ID4g
PiA+ID4gPiA+IMKgwqAgbG9va3VwX29wZW4uaXNyYS4wKzB4M2U3LzB4MTViMA0KPiA+ID4gPiA+
ID4gPiDCoMKgIG9wZW5fbGFzdF9sb29rdXBzKzB4ODVkLzB4MTI2MA0KPiA+ID4gPiA+ID4gPiDC
oMKgIHBhdGhfb3BlbmF0KzB4MTUxLzB4N2IwDQo+ID4gPiA+ID4gPiA+IMKgwqAgZG9fZmlscF9v
cGVuKzB4MWUwLzB4MzEwDQo+ID4gPiA+ID4gPiA+IMKgwqAgZG9fc3lzX29wZW5hdDIrMHgxNzgv
MHgxZjANCj4gPiA+ID4gPiA+ID4gwqDCoCBkb19zeXNfb3BlbisweGEyLzB4MTAwDQo+ID4gPiA+
ID4gPiA+IMKgwqAgX194NjRfc3lzX29wZW5hdCsweGE4LzB4MTIwDQo+ID4gPiA+ID4gPiA+IMKg
wqAgeDY0X3N5c19jYWxsKzB4MjUwNy8weDQ1NDANCj4gPiA+ID4gPiA+ID4gwqDCoCBkb19zeXNj
YWxsXzY0KzB4YTcvMHgyNDANCj4gPiA+ID4gPiA+ID4gwqDCoCBlbnRyeV9TWVNDQUxMXzY0X2Fm
dGVyX2h3ZnJhbWUrMHg3Ni8weDdlDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBGcmVl
ZCBieSB0YXNrIDc2NzoNCj4gPiA+ID4gPiA+ID4gwqDCoCBrYXNhbl9zYXZlX3N0YWNrKzB4M2Iv
MHg3MA0KPiA+ID4gPiA+ID4gPiDCoMKgIGthc2FuX3NhdmVfdHJhY2srMHgxYy8weDQwDQo+ID4g
PiA+ID4gPiA+IMKgwqAga2FzYW5fc2F2ZV9mcmVlX2luZm8rMHg0My8weDgwDQo+ID4gPiA+ID4g
PiA+IMKgwqAgX19rYXNhbl9zbGFiX2ZyZWUrMHg0Zi8weDkwDQo+ID4gPiA+ID4gPiA+IMKgwqAg
a21lbV9jYWNoZV9mcmVlKzB4MTk5LzB4NGYwDQo+ID4gPiA+ID4gPiA+IMKgwqAgbWVtcG9vbF9m
cmVlX3NsYWIrMHgxZi8weDMwDQo+ID4gPiA+ID4gPiA+IMKgwqAgbWVtcG9vbF9mcmVlKzB4ZGYv
MHgzZDANCj4gPiA+ID4gPiA+ID4gwqDCoCBycGNfZnJlZV90YXNrKzB4MTJkLzB4MTgwDQo+ID4g
PiA+ID4gPiA+IMKgwqAgcnBjX2ZpbmFsX3B1dF90YXNrKzB4MTBlLzB4MTUwDQo+ID4gPiA+ID4g
PiA+IMKgwqAgcnBjX2RvX3B1dF90YXNrKzB4NjMvMHg4MA0KPiA+ID4gPiA+ID4gPiDCoMKgIHJw
Y19wdXRfdGFzaysweDE4LzB4MzANCj4gPiA+ID4gPiA+ID4gwqDCoCBuZnM0X3J1bl9vcGVuX3Rh
c2srMHg0ZjQvMHg4MTANCj4gPiA+ID4gPiA+ID4gwqDCoCBfbmZzNF9wcm9jX29wZW4rMHhjMC8w
eDZkMA0KPiA+ID4gPiA+ID4gPiDCoMKgIF9uZnM0X29wZW5fYW5kX2dldF9zdGF0ZSsweDE3OC8w
eGM1MA0KPiA+ID4gPiA+ID4gPiDCoMKgIF9uZnM0X2RvX29wZW4uaXNyYS4wKzB4NDdmLzB4MTM4
MA0KPiA+ID4gPiA+ID4gPiDCoMKgIG5mczRfZG9fb3BlbisweDI4Yi8weDYyMA0KPiA+ID4gPiA+
ID4gPiDCoMKgIG5mczRfYXRvbWljX29wZW4rMHgyYzYvMHgzYTANCj4gPiA+ID4gPiA+ID4gwqDC
oCBuZnNfYXRvbWljX29wZW4rMHg0ZjgvMHgxMTgwDQo+ID4gPiA+ID4gPiA+IMKgwqAgYXRvbWlj
X29wZW4rMHgxODYvMHg0ZTANCj4gPiA+ID4gPiA+ID4gwqDCoCBsb29rdXBfb3Blbi5pc3JhLjAr
MHgzZTcvMHgxNWIwDQo+ID4gPiA+ID4gPiA+IMKgwqAgb3Blbl9sYXN0X2xvb2t1cHMrMHg4NWQv
MHgxMjYwDQo+ID4gPiA+ID4gPiA+IMKgwqAgcGF0aF9vcGVuYXQrMHgxNTEvMHg3YjANCj4gPiA+
ID4gPiA+ID4gwqDCoCBkb19maWxwX29wZW4rMHgxZTAvMHgzMTANCj4gPiA+ID4gPiA+ID4gwqDC
oCBkb19zeXNfb3BlbmF0MisweDE3OC8weDFmMA0KPiA+ID4gPiA+ID4gPiDCoMKgIGRvX3N5c19v
cGVuKzB4YTIvMHgxMDANCj4gPiA+ID4gPiA+ID4gwqDCoCBfX3g2NF9zeXNfb3BlbmF0KzB4YTgv
MHgxMjANCj4gPiA+ID4gPiA+ID4gwqDCoCB4NjRfc3lzX2NhbGwrMHgyNTA3LzB4NDU0MA0KPiA+
ID4gPiA+ID4gPiDCoMKgIGRvX3N5c2NhbGxfNjQrMHhhNy8weDI0MA0KPiA+ID4gPiA+ID4gPiDC
oMKgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc2LzB4N2UNCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gT25jZSBJIGFwcGx5IHRoaXMgcGF0Y2ggSSdtIHNlZWluZyBteSBjbGll
bnQgaGFuZyB3aGVuDQo+ID4gPiA+ID4gPiBydW5uaW5nDQo+ID4gPiA+ID4gPiB4ZnN0ZXN0cyBn
ZW5lcmljLzQ1MSB3aXRoIE5GUyB2NC4wLiBJIHdhcyB3b25kZXJpbmcgaWYgeW91DQo+ID4gPiA+
ID4gPiBjb3VsZA0KPiA+ID4gPiA+ID4gY2hlY2sgaWYgeW91IHNlZSB0aGUgc2FtZSBoYW5nLCBh
bmQgcGxlYXNlIGZpeCBpdCBpZiBzbz8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IEkgaGF2ZSB0cnkgdG8gcmVwcm9kdWNlIHRoaXMgd2l0aCBrZXJuZWwgY29tbWl0Og0KPiA+
ID4gPiANCj4gPiA+ID4gRm9yZ2V0IHRvIHNheSwgYWRkIHRoaXMgcGF0Y2ggdG9vLi4uDQo+ID4g
PiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGNvbW1pdCBhYmYyMDUwZjUxZmRjYTBmZDE0NjM4
OGY4M2NkZGQ5NWE1N2EwMDhkDQo+ID4gPiA+ID4gTWVyZ2U6IDlhYjI3YjAxODY0OSA4MWVlNjJl
OGQwOWUNCj4gPiA+ID4gPiBBdXRob3I6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1m
b3VuZGF0aW9uLm9yZz4NCj4gPiA+ID4gPiBEYXRlOsKgwqAgTW9uIFNlcCAyMyAxNToyNzo1OCAy
MDI0IC0wNzAwDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gwqDCoMKgwqDCoCBNZXJnZSB0YWcgJ21l
ZGlhL3Y2LjEyLTEnIG9mDQo+ID4gPiA+ID4gZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L21jaGVoYWIvbGludXgtDQo+ID4gPiA+ID4gbWVkaWENCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBBbmQgZm9yIG5mczQuMC9uZnM0LjEsIGFsbCBzZWVtcyBvayBub3cuLi4N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBDYW4geW91IHByb3ZpZGUgbW9yZSBpbmZvIGFib3V0IHRo
ZSAnaGFuZycgeW91IG1lZXQgbm93Pw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gVGhhbmtzLA0KPiA+ID4gPiA+ID4gQW5uYQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gPiBGaXhlczogMjRhYzIzYWI4OGRmICgiTkZTdjQ6IENvbnZlcnQgb3Bl
bigpIGludG8gYW4NCj4gPiA+ID4gPiA+ID4gYXN5bmNocm9ub3VzIFJQQw0KPiA+ID4gPiA+ID4g
PiBjYWxsIikNCj4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWWFuZyBFcmt1biA8eWFuZ2Vy
a3VuQGh1YXdlaS5jb20+DQo+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiDCoMKgIGZz
L25mcy9uZnM0cHJvYy5jIHwgMSArDQo+ID4gPiA+ID4gPiA+IMKgwqAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvZnMvbmZzL25mczRwcm9jLmMgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiA+ID4gPiA+ID4gPiBp
bmRleCBiOGZmYmU1MmJhMTUuLjQ2ODU2MjFiYTQ2OSAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gLS0t
IGEvZnMvbmZzL25mczRwcm9jLmMNCj4gPiA+ID4gPiA+ID4gKysrIGIvZnMvbmZzL25mczRwcm9j
LmMNCj4gPiA+ID4gPiA+ID4gQEAgLTI2MDMsNiArMjYwMyw3IEBAIHN0YXRpYyB2b2lkIG5mczRf
b3Blbl9yZWxlYXNlKHZvaWQNCj4gPiA+ID4gPiA+ID4gKmNhbGxkYXRhKQ0KPiA+ID4gPiA+ID4g
PiDCoMKgwqDCoMKgwqAgc3RydWN0IG5mczRfb3BlbmRhdGEgKmRhdGEgPSBjYWxsZGF0YTsNCj4g
PiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgIHN0cnVjdCBuZnM0X3N0YXRlICpzdGF0ZSA9IE5VTEw7
DQo+ID4gPiA+ID4gPiA+ICvCoMKgwqAgbmZzX3JlbGVhc2Vfc2VxaWQoZGF0YS0+b19hcmcuc2Vx
aWQpOw0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqAgLyogSWYgdGhpcyByZXF1ZXN0IGhhc24n
dCBiZWVuIGNhbmNlbGxlZCwgZG8NCj4gPiA+ID4gPiA+ID4gbm90aGluZyAqLw0KPiA+ID4gPiA+
ID4gPiDCoMKgwqDCoMKgwqAgaWYgKCFkYXRhLT5jYW5jZWxsZWQpDQo+ID4gPiA+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X2ZyZWU7DQo+ID4gPiANCj4gPiANCj4gPiBJZiB0
aGUgT1BFTiB3YXMgc3VjY2Vzc2Z1bCwgYnV0IGFza2VkIHVzIHRvIGNvbmZpcm0gdGhlIHNlcXVl
bmNlDQo+ID4gaWQsIHdlDQo+ID4gY2FuIGVuZCB1cCByZWxlYXNpbmcgdGhlIHNlcXVlbmNlIGJl
Zm9yZSB3ZSd2ZSBiZWVuIGFibGUgdG8gY2FsbA0KPiA+IG9wZW5fY29uZmlybSBpZiB3ZSBkbyB0
aGUgYWJvdmUuIEkgc3VzcGVjdCB0aGlzIGlzIHdoeSBBbm5hIGlzDQo+ID4gc2VlaW5nID4gdGhl
IGhhbmcgd2hlbiBydW5uaW5nIHhmc3Rlc3RzLg0KPiANCj4gSGksDQo+IA0KPiBUaGFua3MgYSBs
b3QgZm9yIHlvdXIgcmV2aWV3ISBZZXMsIHdlIGNhbm5vdCBjYWxsIG5mc19yZWxlYXNlX3NlcWlk
DQo+IGZvcg0KPiB0aGlzIGNhc2UuIEJlZm9yZSB0aGlzIHBhdGNoLCB0d28gb3BlbiB0aHJlYWRz
IGNhbm5vdCBzZW5kDQo+IG9wZW4vb3Blbl9jb25maXJtIHJlcXVlc3RzIHRvIHNlcnZlciBjb25j
dXJyZW50bHkuIEFmdGVyIHRoaXMgcGF0Y2gsDQo+IHRoZQ0KPiBmaXJzdCB0aHJlYWQncyBvcGVu
X2NvbmZpcm0gYW5kIHRoZSBzZWNvbmQgdGhyZWFkcyBvcGVuIGFuZA0KPiBvcGVuX2NvbmZpcm0N
Cj4gcmVxdWVzdHMgY2FuIGJlIHNlbmRlZCB0byBzZXJ2ZXIgY29uY3VycmVudGx5LsKgIEJ1dCBJ
IGRvbid0IHF1aXRlDQo+IHVuZGVyc3RhbmQgd2h5IHRoaXMgbGVhZHMgdG8gaHVuZy4uLg0KPiAN
Cg0KRWFjaCB0aHJlYWQga2VlcHMgaW5jcmVhc2luZyB0aGUgc2VxdWVuY2UgSUQgYW5kIHRoZW4g
bG9zaW5nIHRoZSBsb2NrDQp0byB0aGUgb3RoZXIgdGhyZWFkIG9uY2UgdGhlIE9QRU4gaXMgY29t
cGxldGUuDQoNClRoYXQgbWVhbnMgdGhhdCBuZWl0aGVyIHRocmVhZCB3aWxsIGJlIGFibGUgdG8g
Y29uZmlybSB0aGUgc2VxdWVuY2UgSUQsDQpiZWNhdXNlIHRoZSBjb21iaW5hdGlvbiBvZiBzdGF0
ZWlkICsgc2VxdWVuY2UgSUQgdGhhdCB0aGV5IHByZXNlbnQgdG8NCnRoZSBPUEVOX0NPTkZJUk0g
d2lsbCBub3QgbWF0Y2ggdGhlIHJ1bGVzIGluIFJGQzc1MzAgU2VjdGlvbiAxNi4xOC40Lg0KSGVu
Y2UgeW91IGhhdmUgYSBsaXZlIGxvY2suDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K

