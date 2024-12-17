Return-Path: <linux-nfs+bounces-8632-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B7A9F51AF
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 18:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569AA163EE6
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5D71F8900;
	Tue, 17 Dec 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="RjVLB41g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2096.outbound.protection.outlook.com [40.107.244.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED01F6671;
	Tue, 17 Dec 2024 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455233; cv=fail; b=tg7VMuqQMuyw25ByKn8UjMnIFee6VsRx/BsWVTPXUOr+fI0p+PdNJ40zcg0D6O3pxP3pxeT/l9Zu0W12VPvPdFMfhLQsozVpwmZqYxkutv3aZjWrikaLUAbGATBwChCSFJAq43No91MRZ8u0DDbyNGi4qxbkaC/l7/8Ic8ZAHhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455233; c=relaxed/simple;
	bh=7LcZuglu8nGz89XDsNWrhAu6dkMUugpLyDVN1L9hJag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f7bWJNkjRjV+chHJDresQsZvo+ZEQJ4O+3wSQ5BltGCUVWsH+Qb+Tgm8lHwXRrZYGFsOaUTvKOHMH9/TMEOcGEuFPrXJHWYJDQRRuq8cdMJVpAHXRg8cs6gVuTeIpm1YKHK6xs0obk0fMPaJnMJsH6rHazEVSahKox2+jiyzaSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=RjVLB41g; arc=fail smtp.client-ip=40.107.244.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CN3XzmjvLWWLtIdyDu+KwTsK9oumNvjSSFUvmmn3ciPAqaV/ZDrhM06UfL9VOPNqpKBdoIqWgZmPQPvgb+z1su2BpzlwRYK05L531ALPE9wNb8KRS+Guu3/7x27FzIDTo5dIn+IdHPR6iOAIhTAokoFx/LeTAouWxE9jzBhUBc9kwSDT1Hhfj/gMd8P+SkAhMclpGzLpT+qrajRbgMYURRPxVVJ00Vm03uTqDPjxDJsikgwACgtNGcXwIjaCbAPWHKAlGVbYgitJJDmlMWWbREvWcv4E0GAsY7dpRtN6Fef13hr1xLgEqoHUNwJksPhEOTRdXOw49XeNRcr8dsPp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LcZuglu8nGz89XDsNWrhAu6dkMUugpLyDVN1L9hJag=;
 b=WxAt7r0SK5w+yrzFjp3665ecx2+MSVTpJKOZkxsN/XGk/0Hn6B8SVQfkcIH7fszcdk7TfkHAT4o3Vou6SQFitq70oagOAtMkN2aqlcHH0TeYhZvB0REoTvr9XnNhQCOPtRE8heYsBcmbhtO/DPLu/3q8vaep28+/9h+BD2Lr4fDS/XaqxXZOuYSLu3jLErk4RNfTfTQtmgTqxH2l7WRe4jpzhu39ibX/aALZmH40yUuv8onFHefg0gItxfuqtZ3RkjxiwbbbOAy0fbqIGei0h0Xb6SIFHpNVBEjW6wisc1vbce2YDf6/+9ZggLGDbkAv9XFTjcETYIdHQ8NdGMIApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LcZuglu8nGz89XDsNWrhAu6dkMUugpLyDVN1L9hJag=;
 b=RjVLB41gCfcaHo33EOhLE6EMwaW35qeG6pCi2MifmZqmeelIQKXOLsjjQymJ5KiOCDfueu8bHrfq3pNy31v+IMcqRPKNnTbcYY7jEPh4MJ4ou5mwNGtOs4GuVLrdkD5fGahNoapyxcyrQLLluLheYK19UYvGlg4FaIliWTs4siA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3880.namprd13.prod.outlook.com (2603:10b6:610:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 17:07:08 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 17:07:08 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "zichenxie0106@gmail.com"
	<zichenxie0106@gmail.com>, "bcodding@redhat.com" <bcodding@redhat.com>
CC: "zzjas98@gmail.com" <zzjas98@gmail.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "chenyuan0y@gmail.com" <chenyuan0y@gmail.com>
Subject: Re: [PATCH] NFS: Fix potential buffer overflowin
 nfs_sysfs_link_rpc_client()
Thread-Topic: [PATCH] NFS: Fix potential buffer overflowin
 nfs_sysfs_link_rpc_client()
Thread-Index: AQHbUJ+1kwLLMgq7iUmD2RyOCngpdLLqpoqAgAAEaoA=
Date: Tue, 17 Dec 2024 17:07:08 +0000
Message-ID: <299a43ab3a10317475fcd53f5d130fe3610ca07a.camel@hammerspace.com>
References: <20241217161311.28640-1-zichenxie0106@gmail.com>
	 <41572d6005dfb2042482f98177a9b295433c8a5f.camel@hammerspace.com>
In-Reply-To: <41572d6005dfb2042482f98177a9b295433c8a5f.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH2PR13MB3880:EE_
x-ms-office365-filtering-correlation-id: e915edeb-3c14-4fd4-77c6-08dd1ebd3da0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yi9xanpPbnpkYXhoVjFJVHNiaG9sTEFEeFU2S3RVelZmNUpHN0dxWWw2VVcv?=
 =?utf-8?B?Z1VJYlRSQmZaelVZT0p2MisybEZaSGc0alVaVUcwY21pMzJEOTVPL21Jak9L?=
 =?utf-8?B?QzZwMnVpcVBVQTdOUnNZT1NWcVdTUktEY2pvK0xYSTI3MG9qcWVGbkQwRGVy?=
 =?utf-8?B?YVM4NEcxSkhqU043bmJUV1BiQTd0M2hXQkdiMlJKYURXaVVNU09VeUJOb29p?=
 =?utf-8?B?aHpYTUYzbUdOdzhBcHMzZlRLaXdZc3g0cDd3TlFBVEpuL1JjTkEwMjhaUWtm?=
 =?utf-8?B?QncrM1VsY3E5RFliYUlFMWJhbHN4QWJXa0plVFB4SEJJL0ZzNHBFclIvRHVH?=
 =?utf-8?B?dFRzQzJaaHBoeFpuaXVBNVJKU0JWV3FHQTlZaTBEMENnYk9tYXhvQVlwVTVh?=
 =?utf-8?B?OU5vR2FCN09xRktGZVJBKzVCeXF2YTE2N3d4ckdhZlpjWE5DVlpZcUlzZEp6?=
 =?utf-8?B?ZGZVaGlBdmMrbFNzcnAvL2dTdDlNbUtFa0dMenNFQzNwZG43ZzZvcVZ0R0Mw?=
 =?utf-8?B?dlQ2bTNoRjloaXpCbjYvZXc3b2gvMTNCV01zdFZZT3ZKWVhnbzNOOXUwL1kz?=
 =?utf-8?B?VXhGRzNZVHovWlVtSVVuandMZEpLeXhvaUsyL0dTOS9xUGxyb0hKUTgxS1ky?=
 =?utf-8?B?bDQrMDNZeU1ZaG9ERmo2RUp0b054aHdMeHhvWm5pS25nc2g4cWowZ1FRdGJC?=
 =?utf-8?B?bVJEbE9CNDNoNTFiaUI0VElYK0I5WldDcEhOV0ZleFZKSVBGS1RtN0gxVVBT?=
 =?utf-8?B?NmZ2Q210OEJYMTZQeHFvb0p6UHJ1bURKZ1MxVS84eW9rc2RObVZsTTVjK0px?=
 =?utf-8?B?TVYweG1SWm00QlhDMTBuVGhlS1dZd0NIeS9yU0lxaWNUZVliS1ZkQ3JKS0Nm?=
 =?utf-8?B?ekEvbzl0bVc3R1l6eCtXZWV5OVhyOWpLc0RVOEZtdnZVZS9hTi8zZVkzWURZ?=
 =?utf-8?B?RGkyUkRrUndpSXpFcFNWWUZkUncwcW5MbUd3Tk04UWJGZkF1VnZ1cVVYT0Ez?=
 =?utf-8?B?RHdFRy9wLytkUVhFYWcyVE83dFluckhNNlQ5MDhXWTFFZExYMFljQXp0RHI5?=
 =?utf-8?B?d1FkU2s3UTFXZXNwY0hPT3NVakRiNWM5Vi9YTjhnTlhXSTYwU29IRnB3WUNj?=
 =?utf-8?B?YXdRdUxDekZGdGdUU0hSQWUyNE1WVGVwaGNnbGEvUVJlV0FKbTlXcVFPVVpE?=
 =?utf-8?B?Qi9PMStZbHE2NG92Vi9yYnBuSlVRMmFSSlNFRTdBcjBTVnkrVWxXQXZmdWox?=
 =?utf-8?B?bDc5ckwxclYraXp5WERpeGpZZnF0Zm5VS09PcG5uZm1CQVNzYlRUWk92M2wr?=
 =?utf-8?B?UVArckUzR0NpSlh1RkM3by9LTHlMVC9WNDRVS3lhZmNqa01lYnZVaDMwNjZS?=
 =?utf-8?B?T0lNMWlWMkxYMnVGUTNZbEpIOFdwSml6T3IraytMamRKNmk2T2l0NlVyV05o?=
 =?utf-8?B?OFJuR1hQZlQ2R09vUXRkTGRCdEMwZGk1UlJ6OUlqZHpUVVZYUEJZVytuSlgv?=
 =?utf-8?B?dWFUd0hFNmNTZ2FWSE1oSisvYmlHdVZXZ0NrMWNJSEE2ekw4NDRDTW1QNlo0?=
 =?utf-8?B?UFU5Z0h0RDV1UmcyaXZUWkZPZHp2VTU3TlRYMWdMZ0I3UVlGZXk2Lzk4QUdX?=
 =?utf-8?B?WjdNaCtaWFdhV2lKcmU3Y0gwWk9kSllubDJwdVdCQjJnQktWaU9YYTcrL2lS?=
 =?utf-8?B?SWo5QjhZRmtIK0lhTWM1emJIYjBQRlVsRDZaSWdQcHlmN1hCekdPUmpDUkdU?=
 =?utf-8?B?UWRhOXpQUzNKa2tDcEU3cjJVbnZwWEFrRjkyek1FdzZDd3BaN1lrbzk4bDFI?=
 =?utf-8?B?ZTVtUm9yYUc4dVM0aFYyRE9JN0VIOTNYVGdhWWN0TWtsOUsyL1hLQ1U0cm1H?=
 =?utf-8?B?SW93NzMzTjRGQTZEV0xPV3hEQWlzZ2xxMHl5WTBNUFlUVEFPQ2FHQWZlc3pE?=
 =?utf-8?Q?bVF+UmREKjajX/mzv/L4OTm1cEJXYmgr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajg2OWx2UXUwR0JLajRUZFVLSHRudUZySXlIUFdra25wNTBkOUdxUHJFQTBz?=
 =?utf-8?B?Zklic05vWVhaY3hzd3lXTVNHY3pqaGk2UWQvMk5hTC9rQko5RXg5RHpXZWdM?=
 =?utf-8?B?K3B2bTRUc3RMTm9QYzBYb2RaRkVIMjVSbDBGQUxOR1k1TzVRV3VuVEIweUQx?=
 =?utf-8?B?MXZTbC9lYlRoeFVUZWJJSW5YZnI4WTVvRTgzRm5TSHFra2g0K2F4RXg0NENn?=
 =?utf-8?B?M0NOVXdnekZGRUIyQzVyekFub3Z1WDY0VHpOMkZYOEFvSkVEWGlSNkg4OEpH?=
 =?utf-8?B?cHhEejRxaXR6U2NuN1VHSVNnNm91Z0FSbDNtVDhmNTd2c1lyaUxZdFlocGh1?=
 =?utf-8?B?NkhUTVNJS0h6QkFiOFZrYmVDOTA5U2Q3SlNVT1dEdUtjdEgvdGorNnZGeVlF?=
 =?utf-8?B?NlpCQ093WmtSQ1pHREJ0ZGJzdUtVeWp0eVlsQVRJOU9qbGZ3clNaM2FxaVJY?=
 =?utf-8?B?eFA1YzF3OTVOUGFpdDRKVS8vNXpTQ3YyR3RFcUlESjd1NGV0SElrdmkrQng2?=
 =?utf-8?B?SGlUMjZwZFFBTi9oZGdQVlZWUjQvZnJxUE9tMmRnV21NT0xPYmRrS0xrSVZZ?=
 =?utf-8?B?azRjdFNkeHpDYm81MjlHTHl0Q09ocldQWW1nTHdlNmZIRnczZ0lpa3l3TXRW?=
 =?utf-8?B?d0hXTWk0cEZIWGFYNW1RYnFsbnhUUnN4NjBES0xZVkxCR1FqVGxhY3I0b1l4?=
 =?utf-8?B?RTRpdFAvYzZmWkRCWFMzSElNa0E4dUdnNmwvVVdFQWNCUTMxY2pBZ2JiR3ZX?=
 =?utf-8?B?akpRR2xqNUlwOU9VRCtvWXJWcFgwNTg2bXRMRjhEdXBNa3piVDdkK0tlQm5o?=
 =?utf-8?B?eWR0S25qT3JMbFRMRkFCMU91aWdGbWlvRndjQjNFd1lUUFNpNDJSc3ZQWGgx?=
 =?utf-8?B?RkV6YmVjV3Z5UU96OXViNW4vcDk5ZFBpLzQxOTV1WWh4WjhyRGpxSW13Vkdj?=
 =?utf-8?B?YlNXYmd2RU5LaWVPaGN2SWVJd1FkTWUwN2V1WHRXbDcrTHAxRGRpSzN0SDdK?=
 =?utf-8?B?WmdPN2pHNVNxU0FYdm9WZTZGWVFjMWRhYWducmZETk5lVTRKQkNOdFlITXR3?=
 =?utf-8?B?SXdLRm9DdWh1NU1rY2YwZUh4MnJwSzdrUGVMY1RtQW54ZzZScjNXWi94QUgz?=
 =?utf-8?B?NXpQNEhCMjI0Q3M4ditjU1BEbjNyUkVCdG5MNitrZEFJeFdDSWJ0Q0VEb0Ji?=
 =?utf-8?B?RVVwdGgrSG5QbEV1QWYzQmNYVTFJT3ZCUnV3VlNIM01hKzdwTDkvZlhzWHU2?=
 =?utf-8?B?OFUvdEpHMWN6Ymo3TjMxdUtGVm56SUtDWkhSQlEwWjFYU21sRnRWL2orek96?=
 =?utf-8?B?Z1JsQmE4ejYxQWRFT0VGSUdKdEtUb2M0b1B5dVBHMysyRStvUzZIWkNGWkNo?=
 =?utf-8?B?a2JFc3Z4bUlCM1pZdzVEYlUrVFMvc1NIQzEwRzM1RzBmYjF4OEI3UnRUOUNh?=
 =?utf-8?B?MWFCS0ttRlhDRi9DQTVjbi9oam44NjRmSWNXQ1MxWFo2dUt4NmdHVFNOSE9h?=
 =?utf-8?B?QVFpWFU2VWNEdy9qK3h5RkdPa2FHWEkzeXNURDRjUkxVSVZLQ0t2MUY2YzZq?=
 =?utf-8?B?b21ydnFNSEZrSHNYWjc2djZVSHV4RzV1cVJrYXNrNHJvSHNlMzYzSnd0cTBD?=
 =?utf-8?B?QkpLc2NOWi92NDNYZE5HVFVubHVQSFF3a0wvSXBIRFpzSlo3L3BQOEM0NmRB?=
 =?utf-8?B?ME52NmtmN2h2SnpsWkxFU3VBdk1vdzVGR3hZNkVqeEdxSDB0OUdLQ3ZhYUpD?=
 =?utf-8?B?N0QrTjM4c3kwRHZvdWZLcFNWdXc2UG93S1lLejd1UUw5UEFVY3B3bGdtaUJF?=
 =?utf-8?B?NitHM2VFaE5OenA4MVowVUZsUzlnaFhSd3Z4dGRDZ3djL1RWRzk2ZjBqNElz?=
 =?utf-8?B?b0pRTHlmbmhJTUhaanhQQllER2drci9oeXpvY0RIaXNjc0VycEY1RXlVWFBZ?=
 =?utf-8?B?ZkQ3NjQ3Yjl0dG5EdTR0cWFLR2lLRWFxQ3d1Y05PSDFYMS9Pekh0TnlQNy9H?=
 =?utf-8?B?VmwvbUZ0MXR5WlVTa2dsUlM0ditBRTI2OUUrcU5LRFhxRmVTUWt5SzAwVXM2?=
 =?utf-8?B?VW13RG04bHArUXRGNUxxYXh4ZjdmV1NpT3RXMnlMTWFneXlJUGdVSFZiSzJv?=
 =?utf-8?B?MmVnMmxiU01uMHVjMWRTaXRGdCtFbndZWUh2akFodWE4WEhwWWRldHk1b05Z?=
 =?utf-8?B?VHhVQ1dQWDQveEw4SGtRbFFhaFEvdHJUa3ZFVGd5ZUFtaHh2cUpyMHI5Y0xi?=
 =?utf-8?B?di8yRVJpQm56MnVJRmNVSm9wV1Z3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BBAF868C012E140A0944303C4CB5E2A@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e915edeb-3c14-4fd4-77c6-08dd1ebd3da0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 17:07:08.7606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OlsZFmvu8+ygVIPDz2aIEyr7eR1P/bLkgUclu1MTP3L2BnOlRB1UQaKF63ZcTf8dMgUwAGH2FJ8EzjqsKKIWUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3880

T24gVHVlLCAyMDI0LTEyLTE3IGF0IDE2OjUxICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFdlZCwgMjAyNC0xMi0xOCBhdCAwMDoxMyArMDgwMCwgR2F4LWMgd3JvdGU6DQo+ID4g
RnJvbTogWmljaGVuIFhpZSA8emljaGVueGllMDEwNkBnbWFpbC5jb20+DQo+ID4gDQo+ID4gbmFt
ZSBpcyBjaGFyWzY0XSB3aGVyZSB0aGUgc2l6ZSBvZiBjbG50LT5jbF9wcm9ncmFtLT5uYW1lIHJl
bWFpbnMNCj4gPiB1bmtub3duLiBJbnZva2luZyBzdHJjYXQoKSBkaXJlY3RseSB3aWxsIGFsc28g
bGVhZCB0byBwb3RlbnRpYWwNCj4gPiBidWZmZXINCj4gPiBvdmVyZmxvdy4gQ2hhbmdlIHRoZW0g
dG8gc3Ryc2NweSgpIGFuZCBzdHJuY2F0KCkgdG8gZml4IHBvdGVudGlhbA0KPiA+IGlzc3Vlcy4N
Cj4gDQo+IFdoYXQgbWFrZXMgeW91IHRoaW5rIHRoYXQgY2xudC0+Y2xfcHJvZ3JhbS0+bmFtZSBp
cyB1bmtub3duPw0KPiANCj4gQWxsIGNhbGxzIHRvIG5mc19zeXNmc19saW5rX3JwY19jbGllbnQo
KSB1c2Ugd2VsbCBrbm93biBSUEMgY2xpZW50cw0KPiBmb3INCj4gd2hpY2ggdGhlIGNsX3Byb2dy
YW0gaXMgcG9pbnRpbmcgdG8gb25lIG9mIG5sbV9wcm9ncmFtLCBuZnNfcHJvZ3JhbQ0KPiBvcg0K
PiBuZnNhY2xfcHJvZ3JhbS4gU28gd2Uga25vdyB2ZXJ5IHdlbGwgdGhlIHNpemVzIG9mIGNsbnQt
PmNsX3Byb2dyYW0tDQo+ID4gbmFtZS4NCg0KSnVzdCB0byBjbGFyaWZ5OiBJJ20gbm90IHN0cm9u
Z2x5IGFnYWluc3QgdGhlIHBhdGNoIGl0c2VsZi4gSG93ZXZlciBpdA0Kd291bGQgc2VlbSBwcmVt
YXR1cmUgdG8gY29uc2lkZXIgdGhpcyBhIGJ1ZywgbGV0IGFsb25lIGEgc3RhYmxlIGZpeA0KY2Fu
ZGlkYXRlLsKgDQoNCkhhcyBhbnlvbmUgZXZlciBzZWVuIGEgYnVmZmVyIG92ZXJmbG93IGhlcmU/
IElmIHNvLCB1bmRlciB3aGljaA0KY2lyY3Vtc3RhbmNlcz8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

