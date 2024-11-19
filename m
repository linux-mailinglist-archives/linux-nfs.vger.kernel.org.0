Return-Path: <linux-nfs+bounces-8118-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5CF9D2992
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 16:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA48B32BC2
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 15:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65831D079C;
	Tue, 19 Nov 2024 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="K9yWPy0k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2090.outbound.protection.outlook.com [40.107.244.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0EC1CF28C
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028997; cv=fail; b=sP+V+CpfPP1imQwqrTUY+Nlz88Sxi4SQ3EqcqQxjJXsKRezNbvKHpMdY3rqEVnKYnNUGpID8yeMS8C/SBfAw0m3Gm+P+3Rowx6F62S6aEZgK9+HB1lTIAP51oU6aAUD3zMpMLp1mVZj4/DBPtQIe4CTfKTNOQdYpXJnirtF+TJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028997; c=relaxed/simple;
	bh=fDndqDDGF34xXO9FxAz3+6PLvUDl4jCNiGopua4s7wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rkAoqqI+TRsVSGolYPx9WhbdMk/duI3Ijx+TX7UYfyW6IB6LmqflPrhDcgF0jcQtbyIQtlJGnKiFZdgpGlqiMVdZrunmavzlLJqnro2EVuk7st19WW88Ohnc7KpPTVGJvJ5ETGEVvEcvHBV5pHOFBl4aWYahu304wF15FisbszU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=K9yWPy0k; arc=fail smtp.client-ip=40.107.244.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdSdt0jQaMEKJAgDffml5bJoD0TzEKbG3AcMn/ngczGRcFf+EdZcTsDm7ogJPsZRN7IWj46/BG+uDjEfVA2pzp2wwKwADnwHVz/zfWkt6L70yMR3Y03ykU2Jo7rSZd4L5I64Ub9dU126Zbj8Kl3azeHhB1eSGDQUUCQfRZXumES2kGIMb+HKD66D1+AL9aunohYFVRgvkI+adr7zgMa/e8/HE/QdrnxgtoJ8IE36ukIdSo53NOHG35ESCMTFZBldd4F9C5i6RC6eOFIkGf8RSgtnvsqZDE1Y+EWbrzxhe6Ydki+Psn0lCvwEZqtCzSQEkrnBQstBR+hzw/q9bPiJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDndqDDGF34xXO9FxAz3+6PLvUDl4jCNiGopua4s7wk=;
 b=nHOfF/f1LRBRUG05xqzSHKJgfP00vlMnDHmpY2yy0Al6qDdbMnhQgqZZ+l5istNsVEnzi+dPHFaOfb4og4e5FgXOVarkBAotdeFxQTU6a11cQsu/Rl7ibjsCylEVKPj/kW8fH4PU4oqnnVo1RZ9WD9qIISECIvrqHny8inUZnKq08ImYN5/EiqK/jxiCt7TYpNG+T+9Ho+pt+fIzUXSAQIn3SfgpGxAQtSiaVXtMGP98zB3gVfXA/70+FbO/r8mN6jU6xjrb77F1LE13JG5I3XRWxU1Tsdv6axpfWNdlrwrPNf+8wXAck0gmb9qsfwy94DWfpMhn6R6Un48vJC/tAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDndqDDGF34xXO9FxAz3+6PLvUDl4jCNiGopua4s7wk=;
 b=K9yWPy0k7auh3hK1PblwUYgB3Ddj96/SNUV6m+uuYElef0m+Ftyp3SLvL+DyNCJw/pesVBxIZ7Lp9NSQG/4070df5XFc+BBHg+xawK5qQN0VapegVBx/UG4WqFDyIMZFLu5/UuL+0lajilH7TUgN6F5IA+k+a4MZ5H1ALn0tlRc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH3PR13MB6533.namprd13.prod.outlook.com (2603:10b6:610:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 15:09:50 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 15:09:48 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "snitzer@kernel.org" <snitzer@kernel.org>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "loghyr@gmail.com" <loghyr@gmail.com>
CC: "anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
Subject: Re: OPEN_XOR_DELEGATION performance problems
Thread-Topic: OPEN_XOR_DELEGATION performance problems
Thread-Index: AQHbOnibc6euXr8i1E2iQk73XgURbLK+tTIA
Date: Tue, 19 Nov 2024 15:09:48 +0000
Message-ID: <ec60bdca5eea7d459ce81144914f7bd56cd747a9.camel@hammerspace.com>
References: <d5b8d3d6c7592808ad1332ae8c7c2f2cc9635550.camel@kernel.org>
In-Reply-To: <d5b8d3d6c7592808ad1332ae8c7c2f2cc9635550.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH3PR13MB6533:EE_
x-ms-office365-filtering-correlation-id: 967addef-de72-4497-f831-08dd08ac3584
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0QvNStCaU8wemVRUy8xNWpvTnNReENQQ0VUS25sYW5IL0ZkaXVHWC9ETW1X?=
 =?utf-8?B?d0lncFNzRlhtM1RXaDd4Z3lvMmY2V1ZESEtPN2RNa2pzcnRHdU0vdmdaWVBn?=
 =?utf-8?B?clg5WDZydWg2QnUraVJhQmdVS0U3bmFSa1ZORWt1V0xTTU10Nk9DMjJWNlRy?=
 =?utf-8?B?TUdHeEdxQnAwK09LRGlsTUdURUNFc2tTQXhSSzNCbFFIMjZwRE5tUTJ6SjBi?=
 =?utf-8?B?L0xDc1hUdmo0VXVydTdjaFR4OTIvUEM5djNzekxEdFhtc2d5eExESmxLbENW?=
 =?utf-8?B?aUhVdzRwcktGYUh6MktrS3VOUis0VTFPTnVXeHJxWW9HM3dVRHFFRVcrZGRN?=
 =?utf-8?B?ekNjUlg3NzFvejNxcjhKSHNsYlM0MmhackdsTGFlSG5YV1VnRFFkSm1Ma2lE?=
 =?utf-8?B?VlpQS0VxYUYrOGR0Q0c0SldFVnR4T1gvVy9nVksvOXVYSzltMWFrN3IzdE9D?=
 =?utf-8?B?RUcrelB4aWY4dGVack8vUmVpY1pwbzBxNGdzQmNqTzZTY0tQZGNNTzMvL0lH?=
 =?utf-8?B?UGJKVW9RVkxCZnFyejJRNlpSRVFiZFIyeVpkMTVNSzh4Ky9jTkZML2J2QXl1?=
 =?utf-8?B?Q0NJOCtZdzlBbXpLRUVQWnRDS3NCaWRvUmhodGJZRWsyVkt4R1NnelFPWklp?=
 =?utf-8?B?QUxnQXQxUWZ2NUNtc1V4RkZKWkJjbGtlZmxqalhWYmVMM3FwMlpXUmY0VnV5?=
 =?utf-8?B?b2luOEcwYWVjY0xFL2tVTldNQ2d2MVJIYmNreDNGVjZMNlFNckxjNmFyMndV?=
 =?utf-8?B?QjNUM2x2dXNvZ2lneWExZlphQTB4ait0T3VFd1VSZGxVelRFbFhKdmxuQmtt?=
 =?utf-8?B?czRKUVUrNitWSGdHd1hocE8yRkd3WExIWm9YOEMzZ05XaWF5SmVQbjZHZkpP?=
 =?utf-8?B?Z09wQmpiQ3RpQWhrc1AybU1NQmpUQ2hSL09kOCtHWFpjMHhxL2oxMi9US3hX?=
 =?utf-8?B?NW9YdXpNYkR4c0g5dU40ZXArZHErL0ZwcmVhV0lyRnFOVkRpV25neUZaKzRZ?=
 =?utf-8?B?cUE0SnhvSkREdkxiSWxnTitSOXk4ZmZrVlNDU0dZZzdJWTZnUWtFUkxOSFF2?=
 =?utf-8?B?S2tLNWpxMmNtbFJEUmhBWlpGY3B1bTQ1Nm5uaGhPVDdQdWtPcU4xZGNoNU1x?=
 =?utf-8?B?S3hKcnZyUVRkS0lOcUIwekNqL2RzTmVOWEtjOENkeVBGRUZHK3hnSzVNTUpH?=
 =?utf-8?B?VGgveHJpSDFrT1ZoaEJLUjBiVTNoSnZ0dmpycDZ2bk9uQkJSd1N1S3J2c2pD?=
 =?utf-8?B?dXoyV0xGSUxwbXpxbWdMLzNNOEV3dDJqZEtHdmk3TDZWekpBSG9Pc2l6Umc5?=
 =?utf-8?B?MVhLZGNGRVhJME5QUTM2QW9IVG9EMjlMWFY4eWdVbnV1U1hTZHlJZVYwRlcx?=
 =?utf-8?B?QXZidHM3SzlkeVYzMTBucytDWTBHcEk5SlFyemdReGl2a3lFeFJnYVgrZE8v?=
 =?utf-8?B?cWRSVktMRmJScXRjVDZIYVJsekZoMHJRVm9SWWt1dnY5OTF1SVQ0N2RudDhC?=
 =?utf-8?B?TDMwcEFOM2NVQmZQc0pqTnJFRXo3VUY4SDRrRVVWN3M4aWFXc29ZT2wvbjlj?=
 =?utf-8?B?N3FSSWprUGlMdnZiWU1OSWhZc2N6TjVrOVRHMUFuT25iby9hMC9CRFdubmdo?=
 =?utf-8?B?d3VGQmhlbkRtVU9iR2lyenI1UXhVNmdsQkl4UnBsZnE0VWhOVElMYjdsMWxs?=
 =?utf-8?B?YmdnbERFek1qRG02MlNDaHY0ZjBmS3Z5RTZUSmtWL21GNi9UbHIvcHJNcjJW?=
 =?utf-8?B?ZVR2UjJ2dldlOElYNnE3RWhoTE1QMGYzaE5UaXhmUzZPOFVrWThaZGFNUkhK?=
 =?utf-8?B?ZXJoRjlWQkp0SzBtdUl2K1pqUURzQUFpTTczZlc0c2Zjbmd4MjYzMHk0N3lD?=
 =?utf-8?Q?NPtAZmoNe8AVf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Um5rUzNwa3NEUkJnb2lxZGlubFBKT2pBSmJDalNhVHBleWVvVkRpYmVvRUFa?=
 =?utf-8?B?NDliU1hFZ3hpTXk5a1AzL2lKU0lteTlDQ0dObXdybXJUU1BCa2ZEV0lMVzR1?=
 =?utf-8?B?elhCbFhFU2pyaW82b2lobUw4T1RCSFZVbEpFRkRDTE1kWlFMcm50NW9pTVBC?=
 =?utf-8?B?Y2N3RzBTV0VyZ1hqWkUrc1JRdWlPUVlFd2I4MFE2bWNOdEZVZ1pTaENmZUlK?=
 =?utf-8?B?ME14S1IybC9nak05cjI5M0MySjJ4aTUwbWFvYzEvTkgySDZPbGdMbmtYY3Z4?=
 =?utf-8?B?TDlWWldySlRkZ1hSTm5UaCtIMUxWYjFYb2dtaXorZjBLNDl3NmhDdzZ4cEl0?=
 =?utf-8?B?UjV3MVArRUdiTVpQWWdsNXVuK3A2U2ZFL21ic0I1dkgxMC9oVWhBaGhTOTJS?=
 =?utf-8?B?bzBNVi9LcVpPTlI5OGY3MFRGU2x3c3U2ZEtJQnJXOVRaSm5ydWt2ZFNEa0R0?=
 =?utf-8?B?RUVFRURqUXM0aG14TjcyampmOEUvQ25EVUhyVTU1U2w1THVLbmZpV0NOdnRt?=
 =?utf-8?B?WGhiWloxWWRTVUdmWjJlYlRlK000K0t4RFcvMWlUZ0wvY0JOd05VRGNoMThq?=
 =?utf-8?B?NUxqNmFJLzltN1BNUHRjZnk0V05BOG1LY0lFK1QvOTVNVUE2UzZ2NDVOcndB?=
 =?utf-8?B?WGRFczk5MmtZS0J5VWhIRUNIOXJpNS9NMXR4NStoanZucUxkdGR6YmRPSXRX?=
 =?utf-8?B?WVVqWFNoY2FnbW9xWHk3eWNxWUovdFFPNWRmdFhjR3hCcHE3aGZxd2JKRDBx?=
 =?utf-8?B?Y25USGdwRjRSZ2ZTVEZhYzkyVHJyQzhWVTc1NE1OVDdPcEdvaTZlb2tteWZn?=
 =?utf-8?B?a2c0TmYrOUZYQXpycWcrUG00NXI0eTVqQ0w3Y2lic2VOUmc0QTRad056ODJq?=
 =?utf-8?B?UEtzMStZWUkvUk8wWWVreVNpK3hCdGVvZ1FhMzhxOWhXYUdnZG1DU2pKNXN4?=
 =?utf-8?B?VWo2cWwvS3lNR2ZQWHRwN2UwcjBCcTgzeEo2bkxMMWJRd3VkREJKM1NLOUVH?=
 =?utf-8?B?Y091M0JGRmRNYnpBdHBkaVJkWVl0MXlUbHhYK0xZYlhQZ3AxL1RERHJCZkxw?=
 =?utf-8?B?THNWaHJXQ3JZWVlrMlAremRoRG5VS2JsZTBiMm43b24rTDRMWGJBWGZnY21Z?=
 =?utf-8?B?MGtibG80SnpvY0toY1JvZC9pQzFWei9jQUUrRlZUVlRXSTcyUXhhaSs3R2k3?=
 =?utf-8?B?amFTQnZ4Rm1OVXhFWUVBRDJJeXk4QkZkbCt4NUZ1ZGExUjdQNFdteVBaaVRm?=
 =?utf-8?B?bHB5R0lIVnlZdHBkWCtjZkFzazNwWjAzaGxEYlRjcTJwN0Y1VVVXbWFnVHdw?=
 =?utf-8?B?YXFTTWNtRXFxVDlUVUx0MXZucG9sNWtGTEI0clR3ejN3c2ZQN1VWSEJOSkpn?=
 =?utf-8?B?L0tuUUNPbnU3OVp0M3d2Q2RFU3l3SzgzS2NvaXdoS0lPNlpheC9mbytNb3Rn?=
 =?utf-8?B?YXRhNXdMUTU4RExyalVZRU1qOGhKMG82VGVBQ0hxdHFpYmY5R2lJa3cxZFlE?=
 =?utf-8?B?czVLaXVMa3FZcCtUUGtXZEVLclZONmE2NXo5ekNKdGJ2ek14V0VKVDlyRHhS?=
 =?utf-8?B?TVAwWmNMRTgvUjY1bWI3d0dCMWdmcVZ0bVlsQ0srT3lKZGRIZnFpNWxDejJz?=
 =?utf-8?B?NE9Ha2V3WHk5VWt3TndlL1l3dmZiTlE0TUxHNUZReG0zbDZaL2N3R21BaWZn?=
 =?utf-8?B?YTltS1ROWkNmNTdGSTdnNW1jZ1JpUWZ2MWF3L1BjZ3huSkkzNTNyRDJNcGhO?=
 =?utf-8?B?ejFRbWRlekk3L3VCU2N1VzgxZC9JWGZEejBCQTN5LzFzZXoxa1o4aHVVTS9P?=
 =?utf-8?B?bVIwYVc1WEZWSXhpN3hsbVRDZzVtdXZudy9NTVNDK0tvbTFuY1EydXdrWE9p?=
 =?utf-8?B?NDNScWZVeThUMklGbHV0MENnQlAySU5VNTJEUnBhMDJ5TWhnR1ZKY1RJa0Nx?=
 =?utf-8?B?ejZkVUZ2N0pWMHg4djRQMUk5NzA3cEVyd21hWnNVeEFpRVZQUUhrYXo5ajV1?=
 =?utf-8?B?MjhlQTdwWnN0NHU0dDh1NHJaaEtMdFFmWDZHbzlpY1diQmN5UzB2K0xZVXE3?=
 =?utf-8?B?YnNlR2tBZ0F0anpUc3pRMllVRmVsWXllSTFMeEZSMWNvM3E0UThaYWFpamp2?=
 =?utf-8?B?ZGhseXBkWnhFeXgwNW55TTZsazlJdk5kcjJTcTN0bDE0UzVVTGp2M1JNRHdk?=
 =?utf-8?B?V0N0YThmK1pDZWtoQWhSdXB5QW13UjlrNXYycjQ1cEVrcWJRTVZVYnRBODFn?=
 =?utf-8?B?UmxOUzQ5dEFKOGZRLzV6SVNVV3B3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1645B73071C74D4695E37766B4D2EE2E@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 967addef-de72-4497-f831-08dd08ac3584
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 15:09:48.1545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zI+pSHK/oNZWibbTn0Qp9I1wNTCVVuYDrCwI9KD0ztqAQRfdOg/iOl2teb48FEzRsnXf5V7/TUoDH/J311/iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6533

T24gVHVlLCAyMDI0LTExLTE5IGF0IDA2OjQ1IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
V2UgYXR0ZW1wdGVkIHRvIGltcGxlbWVudCB0aGUgImRlbHN0aWQiIGRyYWZ0IGZvciB2Ni4xMywg
YnV0IGhhdmUgaGFkDQo+IHRvIGRyb3AgdGhlIHBhdGNoZXMgZm9yIGl0LiBBZnRlciBtZXJnZSwg
d2UgZ290IGEgY291cGxlIG9mIHJlcG9ydHMNCj4gb2YNCj4gYSBwZXJmb3JtYW5jZSBpc3N1ZSBk
dWUgdG8gdGhlIE9QRU5fWE9SX0RFTEVHQVRJT04gcGF0Y2g6DQo+DQo+DQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LW5mcy8yMDI0MDkxNjE2NDUuZDQ0YmNlZDUtb2xpdmVyLnNhbmdA
aW50ZWwuY29tLw0KPg0KPiBPbmNlIHdlIGVuYWJsZSBPUEVOX1hPUl9ERUxFR0FUSU9OIHN1cHBv
cnQsIHRoZSBmc21hcmsgIkFwcCBPdmVyaGVhZCINCj4gc3RhdGlzdGljIHNwaWtlcyBzaWduaWZp
Y2FudGx5LiBUaGUga2VybmVsIHBhdGNoIGZvciB0aGlzIGlzIHZlcnkNCj4gc2ltcGxlLCBhbmQg
ZG9lc24ndCBzZWVtIGxpa2VseSB0byBjYXVzZSBhIHBlcmZvcm1hbmNlIGlzc3VlIG9uIGl0cw0K
PiBvd24uIE15IHRoZW9yeSBpcyB0aGF0IHRoaXMgdGVzdCBpcyBvbmUgdGhhdCBjYXVzZXMgdGhl
IGNsaWVudCB0bw0KPiByZXR1cm4gdGhlIGRlbGVnYXRpb24sIGFuZCBzaW5jZSBpdCBkb2Vzbid0
IGhhdmUgYW4gb3BlbiBzdGF0ZWlkLCBpdA0KPiBoYXMgdG8gcmVlc3RhYmxpc2ggb25lIGR1cmlu
ZyB0aGUgdGVzdCBydW4sIGFuZCB0aGF0IGNhdXNlcyB0aGUgYXBwDQo+IG92ZXJoZWFkIHN0YXQg
dG8gc3Bpa2UuDQo+DQo+IFRyb25kLCBUb20sIE1pa2UgLS0gSSBrbm93IHRoYXQgdGhlIEhTIEFu
dmlsIGhhcyBzdXBwb3J0IGZvcg0KPiBPUEVOX1hPUl9ERUxFR0FUSU9OLiBJZiB5b3UgcnVuIHRo
ZSBmc21hcmsgdGVzdCBhZ2FpbnN0IGl0IHdpdGggdGhhdA0KPiBzdXBwb3J0IGJvdGggZW5hYmxl
ZCBhbmQgZGlzYWJsZWQgKGVpdGhlciBvbiB0aGUgY2xpZW50IG9yIHNlcnZlcg0KPiBzaWRlKSwg
ZG8geW91IHNlZSBhIHNpbWlsYXIgc3Bpa2UgaW4gIkFwcCBPdmVyaGVhZCI/DQo+DQo+IElmIHNv
LCB0aGVuIEkgc3VzcGVjdCB3ZSBuZWVkIHRvIGNvbnNpZGVyIGxpbWl0aW5nIHRoZSB1c2Ugb2Yg
dGhhdA0KPiBmbGFnDQo+IGluIHNvbWUgY2FzZXMuIEkgaGF2ZSBubyBpZGVhIHdoYXQgaGV1cmlz
dGljIHdlJ2QgdXNlIHRvIGRlY2lkZSB0aGlzDQo+IHRob3VnaC4NCg0KQXMgYWxyZWFkeSBzdGF0
ZWQgd2hlbiB3ZSBkaXNjdXNzZWQgdGhpcyBhdCBCYWtlYXRob246IHRoZSBzZXJ2ZXIgaXMNCnN0
aWxsIGluIGNoYXJnZSBvZiBoZXVyaXN0aWNzIHcuci50LiB3aGV0aGVyIG9yIG5vdCB0aGVyZSBt
YXkgYmUNCmNvbnRlbnRpb24gZm9yIHRoZSBmaWxlLiBUaGUgT1BFTl9YT1JfREVMRUdBVElPTiBm
bGFnIGNoYW5nZXMgbm90aGluZw0KaW4gdGhhdCByZXNwZWN0Lg0KDQpZZXMsIEknbSBzdXJlIHlv
dSBjYW4gZmluZCB0ZXN0cyB3aGljaCBjYXVzZSByZWNhbGxzIG9mIGRlbGVnYXRpb25zLA0KYW5k
IHRob3NlIHdpbGwgYmUgbWFyZ2luYWxseSBzbG93ZXIgd2hlbiB0aGUgY2xpZW50IGhhcyB0byBy
ZS1lc3RhYmxpc2gNCmFuIG9wZW4gc3RhdGVpZC4gSG93ZXZlciB0aGUgaXNzdWUgd2l0aCB0aG9z
ZSB0ZXN0cyBpcyB0aGF0IHRoZXkgYXJlDQpkZWxpYmVyYXRlbHkgc2V0dGluZyB1cCBhIHNpdHVh
dGlvbiB3aGVyZSB0aGUgc2VydmVyIGlkZWFsbHkgc2hvdWxkbid0DQpiZSBoYW5kaW5nIG91dCBh
IGRlbGVnYXRpb24gYXQgYWxsLg0KDQpGdXJ0aGVybW9yZSwgdGhpcyBpcyBubyBkaWZmZXJlbnQg
dGhhbiBhIHNpdHVhdGlvbiB3aGVyZSB0aGUgY2xpZW50DQp1c2VkIGEgZGVsZWdhdGlvbiB0byBj
YWNoZSB0aGUgb3BlbiAoaS5lLiBhdm9pZCBzZW5kaW5nIGFuIE9QRU4gY2FsbCkNCmFmdGVyIHRo
ZSBhcHBsaWNhdGlvbiBjbG9zZWQgdGhlIGZpbGUgYW5kIHRoZW4gbGF0ZXIgcmUtb3BlbmVkIGl0
Lg0KU28gdGhlIHBvaW50IGlzIHRoYXQgdGhpcyBpcyBub3QgYSBzaXR1YXRpb24gdGhhdCBpcyB1
bmlxdWUgdG8NCk9QRU5fWE9SX0RFTEVHQVRJT04uIEl0IGlzIGp1c3QgYSBjb25zZXF1ZW5jZSBv
ZiB0aGUgY2xpZW50J3MgYWJpbGl0eQ0KdG8gY2FjaGUgb3BlbiBzdGF0ZS4NCg0KLS0NClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

