Return-Path: <linux-nfs+bounces-7428-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813729AE70C
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 15:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F8D1C20A09
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 13:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686A51DE4F7;
	Thu, 24 Oct 2024 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="EK+a7rnv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2091.outbound.protection.outlook.com [40.107.94.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B4C1C1758;
	Thu, 24 Oct 2024 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778236; cv=fail; b=VKfiiXMK2NAjzG7+8FM6i7zNEg2VQf8YfRhrwpo782zaph3GjkTlDWYUGXlC7MvM34xFYOjyUz08g51u+5oBW2P9tgq+sZ+Q1zA7VDSk2zziGVba4MhDOHH6OZGztBZANY17OFoJdRcmvr9XQxbov+X5A6vwNz1Iaur4WYydcxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778236; c=relaxed/simple;
	bh=4sHjmWyKm1O5vI7uuHICPWifnuDrryajsvkM1rs7BQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NkcH8KDKxoXUSHITGdEneRIDK7Nzaxexj+WlrQu85okvluO0IyDMBJCcX5onfyyTqR4SK1xjTfwJSzyJ4f1VNvOh6+l14Eio+x1ma02aVbzW3k0OlTn9TcuD+lT/rOWjMAHYu9gasay3A78IJt7hgfPNsiEwrWDa6+VL9LmrvPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=EK+a7rnv; arc=fail smtp.client-ip=40.107.94.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIffmfi6cfBAnBjQ+Od13404V0vERSDphbbVRr33prXa+faxFZtw9tQt/0Yoo6PAFtlEUJzk5JIMP9VkZ2Ij4b4CpX7MshDzc0iQxUx0J36kHy+ePxHK0DfMN+f3SzTeMWFwfhFs4yJ8jAw+t7RzsGFMnpT1LOS6T5pWnd3IMezQZa8lvkdHh1I/pryV2tLE++8Iw2mYJLwcKttu3xXs3brKyjRYI4EqhLpdrkdQA9hkFWSY7mUL2ML0mf4RXNM4js/97/4vqj8jX/x7EbJqll49SxkL+zdV5meHS6ACVLSdEDvBi++ubMH/EdkoiwsQmkVAANkarWs6GObV2DaBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sHjmWyKm1O5vI7uuHICPWifnuDrryajsvkM1rs7BQ0=;
 b=HD7Mfj5EbYSn4ce64MrfMLBZltzx7QoMNe7JNIJifxCxGi8cisGQEbxPDF5HnNvbC36zY+OmF+yWiXWYCQdODWGtJtFEc/diqJukA+wwDGa6Qq7n7jBiZ/9oR/KYmQfLTHjad1M9omvGJ9LHnZRSMQat94HgZK5B84Dl1Kg2duz6cjvVtGN+7thlaZHDuj2mFk4kT9mIMHqdKzhr/kkfYcS3k5RWABtZ1Xg1jIS7NE/VC/eGu1HyhVtWdHQMdwttS2pz/CaNAUJejCcdN+/myh5HzlTUrJwxXgHVlJEWvF5ocgLGvKOwb4Gurn4eqFqA4LoqmFU4AYj8UxdG+Hj7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sHjmWyKm1O5vI7uuHICPWifnuDrryajsvkM1rs7BQ0=;
 b=EK+a7rnvOdjGigvPH89VpbTPdxQhIbzefoBIc8PLNRaJfkt6xnjoFJFzXZ/O5ntCFTzAc7mzObnuHq9MOJqKqNDtVmUFPNTjq6tQ/C3ScBExgatQhWxD4R0HQKJmtXaEnX2raomKpoFoH5NYLV5QuQR4tDI8T6cy2AIS+Auos3w=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB6076.namprd13.prod.outlook.com (2603:10b6:a03:4e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 24 Oct
 2024 13:57:08 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 13:57:08 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "tom@talpey.com" <tom@talpey.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "ebiederm@xmission.com" <ebiederm@xmission.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "okorniev@redhat.com"
	<okorniev@redhat.com>, "anna@kernel.org" <anna@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "liujian56@huawei.com"
	<liujian56@huawei.com>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "neilb@suse.de" <neilb@suse.de>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] sunrpc: fix one UAF issue caused by sunrpc kernel tcp
 socket
Thread-Topic: [PATCH net] sunrpc: fix one UAF issue caused by sunrpc kernel
 tcp socket
Thread-Index: AQHbJbtPJ4ryUqLRAUiLTzYVTAhYbLKV3SkAgAAL4gCAAAS1gA==
Date: Thu, 24 Oct 2024 13:57:08 +0000
Message-ID: <916a86a4c9d2a483f3576ab36db00bd6fdab4254.camel@hammerspace.com>
References: <20241024015543.568476-1-liujian56@huawei.com>
	 <65b652e60d8681b0898efcd6e020f69447b6e606.camel@hammerspace.com>
	 <1d5a4a4f728b0cd44f006d5f5b0a90cecec1271c.camel@hammerspace.com>
	 <abf1ac13-ee4f-4549-b313-36259cf0d411@huawei.com>
In-Reply-To: <abf1ac13-ee4f-4549-b313-36259cf0d411@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB6076:EE_
x-ms-office365-filtering-correlation-id: 054c7e88-1b71-45fe-cb10-08dcf433c043
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YS9hUzZzcHdza3h5Y0dOSlJ0US9yaGJndGMzUWJvNTgrK1VETmNZdFc3b05t?=
 =?utf-8?B?a0NUT25xU0J1U0ZLZUhZU0dabndPQk5MeXZadkpHRERoM0xjaHhwbG1WcUdS?=
 =?utf-8?B?YUVIakJuZGlEZXF6R3F0NDRjbDc1L3EyQ0cra3V6aWhVVkdTRkJiUC9NaDVD?=
 =?utf-8?B?UU9FOUd6eXlrT25MdVFrRG5zbTlMaHlpWFpSU2xJUGl3T3o2eVo5UHJVb2hJ?=
 =?utf-8?B?d05wWmUzTUlrNFJOaitNUkFnMDViNitCOWFiUzlHTHY2ZmN3RWpXWUEybzcv?=
 =?utf-8?B?RWxiVWNlR2x6MVY2ai9HbmdDc0wwa2gxMkRPZE1tMllHZ2J4VWNpZDh4TVJT?=
 =?utf-8?B?SEJ6RTgrWWQrNUdZVFhHZGxoK0FZUUtBcXlrN3FhcFJsM0FUSDRSNE5ZQUxv?=
 =?utf-8?B?V0w5NXp2eG9PUnh2TFJTeGtUT1RrcVZDNU45cW80REV4VWtYOU1RT2c5SEND?=
 =?utf-8?B?eFYrdU1jYk1RUmVYclJrZWFJdCtUY0FxaDNBUytnOExGZllYSGtGVlpBeVYz?=
 =?utf-8?B?dkVDMVF3alB0ZEo4SDgvV3hRZ1IrOEU1WmxUVnM5Y1FGQVRNbnRoTTJ1eXpD?=
 =?utf-8?B?T29qRERFMncyVFdPQjY5Zmw4WUNrVzBOT29VKzM0R0p1aXRJeGpvMmEzcWRG?=
 =?utf-8?B?cVpvN0ord3dOaFVsWnVVNWJOdmVsYnhhT1pXQTFiZmQrMGpLaTlPNGdPY2RR?=
 =?utf-8?B?MnR5VVkvYVMyYWFYeDZzNmpsdjlucTFBeUFKODRsd0tjVjl2Vm1xeHdqdTNh?=
 =?utf-8?B?QTgvcGI3ci9vRHd5T2h6QUx3Nk9LbW9KaVlhR0RIS24wWGxxRnJzWmU2NHY2?=
 =?utf-8?B?Lyt2SGI4bjE1T0xoelhMYll1UlNRaHRvOTJsa2dndWpTS0hLS3paOFgwdEwy?=
 =?utf-8?B?Y0lSa2psZExOYzNQNjUrQXdkNHFkcFlYa3k2UmJDZXZjR3krSnliVUc2Tmor?=
 =?utf-8?B?OFZSVFI1UEhSNTVIcGsxZ3RqenN5NGdXLy9xd2ZKVm9heHJsRmVuYUE4S3I0?=
 =?utf-8?B?elBKcFdlck5Nck9IZWVuMW94a3BSaHpvdjNjdDJ1VjJkb1hMK0hVRnBPQUJv?=
 =?utf-8?B?V1htT0Y1WHd3bVh3dkt3dUVPVS9KUC9qaGtmckRpWDFRZGxGRENLOExaZTBm?=
 =?utf-8?B?WUxEaEFYSS84a1JwNCtsV2o4NkNzQkdnTU9LSjlZU0tmR044Qkk0KzJaZGFu?=
 =?utf-8?B?WGxUVTYzVTFINlh0aVdCOENvcVltWlhYcStCRFNCdGlBVG5VZTJ1Y3JTSmx0?=
 =?utf-8?B?T1pCei9DQ0pzWndmYjRFaU90TGJYOGhGTEFEakxzS0xuaEtocU5zY0d5YitX?=
 =?utf-8?B?RVNzZm1GTG55WEFsQ0ZOdGRjYlhsSk0xZWRkWFRIZ053YjZ4QzVjMUVqRS9G?=
 =?utf-8?B?cnUxNzQ2SzFoSm1SelZGNXEra3YxQnR2WTdEMTZzc3MzbmFaMmNGU0hqdHp0?=
 =?utf-8?B?aGFBZ1cvWkFtTHVwMWZMODV5SUNJbEhQZjd5bXUzVHlsbm1WckRaWFlkK3Vh?=
 =?utf-8?B?djFDbTUzK1h3UHVKb1lFaStMS05YaDNuTkFHK0Uvbmh4MEV2ZlhFTWg0MmxH?=
 =?utf-8?B?VlM1S045bDJ2Rnc5Y1NTenk0R0hOeWJiOCtMSXg4dUhWU1dBYlZmZ2hIRjVt?=
 =?utf-8?B?YWRxMHRlTUVKYVNnR3lYK3FzbytNNFhrK0I4NFNNVzRIcVE0T1FoT2ZLQ1Ra?=
 =?utf-8?B?cXYzM2VoYTdWa2ZmbmY2MGdjLzRTRWFZU1g1N2NKM0FNQWJnMk1QZks4Qnhh?=
 =?utf-8?B?YXgwMTBybnR2V3NabUczVXdnRUtkclFvVFlTTklQRWYxUllwS0pSZnNTZUhZ?=
 =?utf-8?B?S3M5NE9ZY3c0YnhiV1lCUnp5MjBYMU04UHpGMlBLdUYvQ1g0ODJGYWRHdk9P?=
 =?utf-8?B?VzZUeFVaVlNjNE1yS1ozeVp3WVd3NWhZd3dOMTlvVFN5aEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0MyeFZyRm5yRnV5RmJ3RWlGVFVMZUQ0b2pUZkpPNGJJT042b0thN25kekd3?=
 =?utf-8?B?dEE1dzVpc05aTGdSTjZGdzBzeS81TGNTL09TVlArSVY1K3k4MmFSTzc1d2I0?=
 =?utf-8?B?UjF6NHJPVlJoZXZoZXlFZ3dIRXZ1SmdCTG44MysvVjgxMmNTcXBNV1ZCVTA5?=
 =?utf-8?B?YmZKaG0wTEEwU3VmZHgvY05QWEJlc1pZWk13dTY1WUEvNnpSdkpHRUpWTDJK?=
 =?utf-8?B?UUZqSjl5OWd4QnpiVVBlTXJBNDJ5VFlFRzE3WVhxOEtscmFxVHdIZUtQMzQy?=
 =?utf-8?B?T09relFPZk9nWFA4RmRHYU9jUkdtUzZ4L3E1UkMreUZkQWJHQnNrVXZGaEp0?=
 =?utf-8?B?Ty8xT0xjQnJwNEJ0a2tKU0hFK0tRQSt5cm9PN2NIZEVjOWQrSHNISWl2UDEw?=
 =?utf-8?B?U29OZ1RrY212Um5sakFhQ0wzYUNHWTg5Z25FL21YaVBUaE5GQ25FNy9MS3Va?=
 =?utf-8?B?R1J2Ym9IeVBrdkJHdHlwSmQwOGlUM1I3ZWRKOU5kRmlBQTN6N3crV2cza1B1?=
 =?utf-8?B?VDhpN1JYSVpXV1FlbTlIK1VQZ2xrM3VmWW13SDlNeHFualdsaUVoRmdqcStS?=
 =?utf-8?B?QjhxaTFJRFRCUHo1RUVTNWRLckF2MWo1T1kwSXVVV3BOZ2QrQlRkSGpwaDB2?=
 =?utf-8?B?VkFYMDdYL0kyQTVrdHROWnFLaG5wdHVlUlR1djArbkxMVFlPSmRoMHpwOHl0?=
 =?utf-8?B?MG42UnRGTHdoRUZTT3JzNXpBMS9RcDRhTG9HMWJza25EN2g5bXl2UVg4dzE3?=
 =?utf-8?B?SnBnQVZ6UkE0K0tJWVVCdnhBWWxxMUo2YWE2c1VOR2xaQ1JCcUx2MkZkbGNS?=
 =?utf-8?B?MFJWVFpkZzk1MzE0c2F2MDBHOUdqdGs0NEZlSmxpMktTWndZbTZkM0JJWE9q?=
 =?utf-8?B?aytSemY4TG5SUlNnOWdzZ2xtbkdFcW1OWVZzc1hKYzdzVno0VCthRHJ4ZytF?=
 =?utf-8?B?SUNHV3B5Uk5vTEdJeldDb3VMMkJYbnpPOWZqVXBTc0tqREZUZys1a3RBTlUy?=
 =?utf-8?B?aXp2QUJqU3pmanBUdWkxbUpTUjZldFl4SjRZWlU1RTFLYnlFWFU2LzRMcGhp?=
 =?utf-8?B?cnVFZ2YxVmQ1SlZJMEkybnd3ckZLYVNaM0luS3UwYWIxQXowdGRjU2hmNGhB?=
 =?utf-8?B?OFBEc0JHRGFKSkR3Y2d2YnNGNUdEU3JIN3E4a1hLSHg5bU54N2pDMlNtTXl2?=
 =?utf-8?B?SUxYcGMzQnpaQ1ZWb29acFR6WHlpYVh4K1pTVHBTbmQzc0pkUC93akQ0cXJa?=
 =?utf-8?B?YlhXc0xlWCtuWVlYOER4UzBHMHBJcXpLc0dyNkhCVS9uc0NKazR6U1FnRzdm?=
 =?utf-8?B?NDl2czRGdEQ3cDNScndvNEs3SlhVOU9HZytjc2NsWVdRVEo4Qm5pRnpvSksw?=
 =?utf-8?B?enl2NkdBZHQ5ZmtRK2JwV21QQ0RnT2hwZCt5aWpFaFl1ajhhZGhyOXdnSGJh?=
 =?utf-8?B?VVVpeGRrN2R4RFNxY1o1TWNhV2U0enRoTklyVC9TRmtkV3N0REM2ZEVXR1VI?=
 =?utf-8?B?aUJRK0ZJaUhlWjZzTHVpNy9lTkl3RHo3NXpndXR0ZEtNTi9XTXhGTDBiRC8w?=
 =?utf-8?B?bTdwTGdhREszcEZKYm02Q0JmOUlsQzkvSno4TnZvcXB2SkVKamZoaE10OHlZ?=
 =?utf-8?B?UHJMcC9kL2FidUxMVWlOSlE1dzQwVHZqQ0tBaGhiSTZkL3d3M3lSRGRoanhU?=
 =?utf-8?B?cU9aQ25CaFNyS2VCMkk1aWNhK0lNVmpqeWZmUGx3eThHaWYvQjY5Z3gvWnh6?=
 =?utf-8?B?UVJTa1BsNWZ5ZzhuRUZySzdIMkdWQnp4aWdmOHlMSlRyOHlBTkJOQ3R3TUh4?=
 =?utf-8?B?b3RlenlINXBIZkdvK2dkL1Q4WUxLWlJTL2YwNUJwSmhHSEF1SGJWNTBSckpz?=
 =?utf-8?B?TnpQOUFoOWZhZ2U1R2hkTHFYRC9jZjJ6S0g2QS9jdWNYdDRCaVVwK2toU2xM?=
 =?utf-8?B?U3hrSmwwU0tyeHNYeXhSY0Y2VHJlbGNmODB0bloyOHJ5NUNKQWRvanh0Z2pG?=
 =?utf-8?B?d0phRURBcTJZdFcvQVZEMjZOT25sOXY1eEw1SklCdXJtSjVYemo2Z0dOM0pO?=
 =?utf-8?B?bzdJd1ZOQkU2bVNRQU9uR1U0aWFvTHQxM3hZWDlJTDdhTEJOVk5ISERGWTVZ?=
 =?utf-8?B?T2tvbk82WUtmS3pKV3BiSFlVRTlSTlBMdlAxN0RmcnhUVHRldmNBdm0xWW1a?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D06A0CE00EDD2640B51100E314B10A80@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 054c7e88-1b71-45fe-cb10-08dcf433c043
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 13:57:08.5377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oj17TSSS+5CpN0lnoGln0a55zqK/GRcNJsUnxPeLanx8yp65qw63ncSOR4Y0gXgVnfi2cuRcimaJNW2xSfPASw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB6076

T24gVGh1LCAyMDI0LTEwLTI0IGF0IDIxOjQwICswODAwLCBsaXVqaWFuIChDRSkgd3JvdGU6DQo+
IA0KPiANCj4g5ZyoIDIwMjQvMTAvMjQgMjA6NTcsIFRyb25kIE15a2xlYnVzdCDlhpnpgZM6DQo+
ID4gT24gVGh1LCAyMDI0LTEwLTI0IGF0IDAyOjIwICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3Jv
dGU6DQo+ID4gPiBPbiBUaHUsIDIwMjQtMTAtMjQgYXQgMDk6NTUgKzA4MDAsIExpdSBKaWFuIHdy
b3RlOg0KPiA+ID4gPiBCVUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIGluDQo+ID4gPiA+
IHRjcF93cml0ZV90aW1lcl9oYW5kbGVyKzB4MTU2LzB4M2UwDQo+ID4gPiA+IFJlYWQgb2Ygc2l6
ZSAxIGF0IGFkZHIgZmZmZjg4ODExMWYzMjJjZCBieSB0YXNrIHN3YXBwZXIvMC8wDQo+ID4gPiA+
IA0KPiA+ID4gPiBDUFU6IDAgVUlEOiAwIFBJRDogMCBDb21tOiBzd2FwcGVyLzAgTm90IHRhaW50
ZWQgNi4xMi4wLXJjNC0NCj4gPiA+ID4gZGlydHkNCj4gPiA+ID4gIzcNCj4gPiA+ID4gSGFyZHdh
cmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MNCj4g
PiA+ID4gMS4xNS4wLQ0KPiA+ID4gPiAxDQo+ID4gPiA+IENhbGwgVHJhY2U6DQo+ID4gPiA+IMKg
wqA8SVJRPg0KPiA+ID4gPiDCoMKgZHVtcF9zdGFja19sdmwrMHg2OC8weGEwDQo+ID4gPiA+IMKg
wqBwcmludF9hZGRyZXNzX2Rlc2NyaXB0aW9uLmNvbnN0cHJvcC4wKzB4MmMvMHgzZDANCj4gPiA+
ID4gwqDCoHByaW50X3JlcG9ydCsweGI0LzB4MjcwDQo+ID4gPiA+IMKgwqBrYXNhbl9yZXBvcnQr
MHhiZC8weGYwDQo+ID4gPiA+IMKgwqB0Y3Bfd3JpdGVfdGltZXJfaGFuZGxlcisweDE1Ni8weDNl
MA0KPiA+ID4gPiDCoMKgdGNwX3dyaXRlX3RpbWVyKzB4NjYvMHgxNzANCj4gPiA+ID4gwqDCoGNh
bGxfdGltZXJfZm4rMHhmYi8weDFkMA0KPiA+ID4gPiDCoMKgX19ydW5fdGltZXJzKzB4M2Y4LzB4
NDgwDQo+ID4gPiA+IMKgwqBydW5fdGltZXJfc29mdGlycSsweDliLzB4MTAwDQo+ID4gPiA+IMKg
wqBoYW5kbGVfc29mdGlycXMrMHgxNTMvMHgzOTANCj4gPiA+ID4gwqDCoF9faXJxX2V4aXRfcmN1
KzB4MTAzLzB4MTIwDQo+ID4gPiA+IMKgwqBpcnFfZXhpdF9yY3UrMHhlLzB4MjANCj4gPiA+ID4g
wqDCoHN5c3ZlY19hcGljX3RpbWVyX2ludGVycnVwdCsweDc2LzB4OTANCj4gPiA+ID4gwqDCoDwv
SVJRPg0KPiA+ID4gPiDCoMKgPFRBU0s+DQo+ID4gPiA+IMKgwqBhc21fc3lzdmVjX2FwaWNfdGlt
ZXJfaW50ZXJydXB0KzB4MWEvMHgyMA0KPiA+ID4gPiBSSVA6IDAwMTA6ZGVmYXVsdF9pZGxlKzB4
Zi8weDIwDQo+ID4gPiA+IENvZGU6IDRjIDAxIGM3IDRjIDI5IGMyIGU5IDcyIGZmIGZmIGZmIDkw
IDkwIDkwIDkwIDkwIDkwIDkwIDkwDQo+ID4gPiA+IDkwDQo+ID4gPiA+IDkwDQo+ID4gPiA+IDkw
IDkwDQo+ID4gPiA+IMKgwqA5MCA5MCA5MCA5MCBmMyAwZiAxZSBmYSA2NiA5MCAwZiAwMCAyZCAz
MyBmOCAyNSAwMCBmYiBmNCA8ZmE+DQo+ID4gPiA+IGMzDQo+ID4gPiA+IGNjDQo+ID4gPiA+IGNj
IGNjDQo+ID4gPiA+IMKgwqBjYyA2NiA2NiAyZSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCA5MCA5
MCA5MCA5MCA5MA0KPiA+ID4gPiBSU1A6IDAwMTg6ZmZmZmZmZmZhMjAwN2UyOCBFRkxBR1M6IDAw
MDAwMjQyDQo+ID4gPiA+IFJBWDogMDAwMDAwMDAwMDBmM2IzMSBSQlg6IDFmZmZmZmZmZjQ0MDBm
YzcgUkNYOg0KPiA+ID4gPiBmZmZmZmZmZmEwOWMzMTk2DQo+ID4gPiA+IFJEWDogMDAwMDAwMDAw
MDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDAgUkRJOg0KPiA+ID4gPiBmZmZmZmZmZjlmMDA1
OTBmDQo+ID4gPiA+IFJCUDogMDAwMDAwMDAwMDAwMDAwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEg
UjA5Og0KPiA+ID4gPiBmZmZmZWQxMDIzNjA4MzVkDQo+ID4gPiA+IFIxMDogZmZmZjg4ODExYjA0
MWFlYiBSMTE6IDAwMDAwMDAwMDAwMDAwMDEgUjEyOg0KPiA+ID4gPiAwMDAwMDAwMDAwMDAwMDAw
DQo+ID4gPiA+IFIxMzogZmZmZmZmZmZhMjAyZDdjMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDAgUjE1
Og0KPiA+ID4gPiAwMDAwMDAwMDAwMDE0N2QwDQo+ID4gPiA+IMKgwqBkZWZhdWx0X2lkbGVfY2Fs
bCsweDZiLzB4YTANCj4gPiA+ID4gwqDCoGNwdWlkbGVfaWRsZV9jYWxsKzB4MWFmLzB4MWYwDQo+
ID4gPiA+IMKgwqBkb19pZGxlKzB4YmMvMHgxMzANCj4gPiA+ID4gwqDCoGNwdV9zdGFydHVwX2Vu
dHJ5KzB4MzMvMHg0MA0KPiA+ID4gPiDCoMKgcmVzdF9pbml0KzB4MTFmLzB4MjEwDQo+ID4gPiA+
IMKgwqBzdGFydF9rZXJuZWwrMHgzOWEvMHg0MjANCj4gPiA+ID4gwqDCoHg4Nl82NF9zdGFydF9y
ZXNlcnZhdGlvbnMrMHgxOC8weDMwDQo+ID4gPiA+IMKgwqB4ODZfNjRfc3RhcnRfa2VybmVsKzB4
OTcvMHhhMA0KPiA+ID4gPiDCoMKgY29tbW9uX3N0YXJ0dXBfNjQrMHgxM2UvMHgxNDENCj4gPiA+
ID4gwqDCoDwvVEFTSz4NCj4gPiA+ID4gDQo+ID4gPiA+IEFsbG9jYXRlZCBieSB0YXNrIDU5NToN
Cj4gPiA+ID4gwqDCoGthc2FuX3NhdmVfc3RhY2srMHgyNC8weDUwDQo+ID4gPiA+IMKgwqBrYXNh
bl9zYXZlX3RyYWNrKzB4MTQvMHgzMA0KPiA+ID4gPiDCoMKgX19rYXNhbl9zbGFiX2FsbG9jKzB4
ODcvMHg5MA0KPiA+ID4gPiDCoMKga21lbV9jYWNoZV9hbGxvY19ub3Byb2YrMHgxMmIvMHgzZjAN
Cj4gPiA+ID4gwqDCoGNvcHlfbmV0X25zKzB4OTQvMHgzODANCj4gPiA+ID4gwqDCoGNyZWF0ZV9u
ZXdfbmFtZXNwYWNlcysweDI0Yy8weDUwMA0KPiA+ID4gPiDCoMKgdW5zaGFyZV9uc3Byb3h5X25h
bWVzcGFjZXMrMHg3NS8weGYwDQo+ID4gPiA+IMKgwqBrc3lzX3Vuc2hhcmUrMHgyNGUvMHg0ZjAN
Cj4gPiA+ID4gwqDCoF9feDY0X3N5c191bnNoYXJlKzB4MWYvMHgzMA0KPiA+ID4gPiDCoMKgZG9f
c3lzY2FsbF82NCsweDcwLzB4MTgwDQo+ID4gPiA+IMKgwqBlbnRyeV9TWVNDQUxMXzY0X2FmdGVy
X2h3ZnJhbWUrMHg3Ni8weDdlDQo+ID4gPiA+IA0KPiA+ID4gPiBGcmVlZCBieSB0YXNrIDEwMDoN
Cj4gPiA+ID4gwqDCoGthc2FuX3NhdmVfc3RhY2srMHgyNC8weDUwDQo+ID4gPiA+IMKgwqBrYXNh
bl9zYXZlX3RyYWNrKzB4MTQvMHgzMA0KPiA+ID4gPiDCoMKga2FzYW5fc2F2ZV9mcmVlX2luZm8r
MHgzYi8weDYwDQo+ID4gPiA+IMKgwqBfX2thc2FuX3NsYWJfZnJlZSsweDU0LzB4NzANCj4gPiA+
ID4gwqDCoGttZW1fY2FjaGVfZnJlZSsweDE1Ni8weDVkMA0KPiA+ID4gPiDCoMKgY2xlYW51cF9u
ZXQrMHg1ZDMvMHg2NzANCj4gPiA+ID4gwqDCoHByb2Nlc3Nfb25lX3dvcmsrMHg3NzYvMHhhOTAN
Cj4gPiA+ID4gwqDCoHdvcmtlcl90aHJlYWQrMHgyZTIvMHg1NjANCj4gPiA+ID4gwqDCoGt0aHJl
YWQrMHgxYTgvMHgxZjANCj4gPiA+ID4gwqDCoHJldF9mcm9tX2ZvcmsrMHgzNC8weDYwDQo+ID4g
PiA+IMKgwqByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzANCj4gPiA+ID4gDQo+ID4gPiA+IFJl
cHJvZHVjdGlvbiBzY3JpcHQ6DQo+ID4gPiA+IA0KPiA+ID4gPiBta2RpciAtcCAvbW50L25mc3No
YXJlDQo+ID4gPiA+IG1rZGlyIC1wIC9tbnQvbmZzL25ldG5zXzENCj4gPiA+ID4gbWtmcy5leHQ0
IC9kZXYvc2RiDQo+ID4gPiA+IG1vdW50IC9kZXYvc2RiIC9tbnQvbmZzc2hhcmUNCj4gPiA+ID4g
c3lzdGVtY3RsIHJlc3RhcnQgbmZzLXNlcnZlcg0KPiA+ID4gPiBjaG1vZCA3NzcgL21udC9uZnNz
aGFyZQ0KPiA+ID4gPiBleHBvcnRmcyAtaSAtbyBydyxub19yb290X3NxdWFzaCAqOi9tbnQvbmZz
c2hhcmUNCj4gPiA+ID4gDQo+ID4gPiA+IGlwIG5ldG5zIGFkZCBuZXRuc18xDQo+ID4gPiA+IGlw
IGxpbmsgYWRkIG5hbWUgdmV0aF8xX3BlZXIgdHlwZSB2ZXRoIHBlZXIgdmV0aF8xDQo+ID4gPiA+
IGlmY29uZmlnIHZldGhfMV9wZWVyIDExLjExLjAuMjU0IHVwDQo+ID4gPiA+IGlwIGxpbmsgc2V0
IHZldGhfMSBuZXRucyBuZXRuc18xDQo+ID4gPiA+IGlwIG5ldG5zIGV4ZWMgbmV0bnNfMSBpZmNv
bmZpZyB2ZXRoXzEgMTEuMTEuMC4xDQo+ID4gPiA+IA0KPiA+ID4gPiBpcCBuZXRucyBleGVjIG5l
dG5zXzEgL3Jvb3QvaXB0YWJsZXMgLUEgT1VUUFVUIC1kIDExLjExLjAuMjU0IC0NCj4gPiA+ID4g
cA0KPiA+ID4gPiB0Y3ANCj4gPiA+ID4gXA0KPiA+ID4gPiAJLS10Y3AtZmxhZ3MgRklOIEZJTsKg
IC1qIERST1ANCj4gPiA+ID4gDQo+ID4gPiA+IChub3RlOiBJbiBteSBlbnZpcm9ubWVudCwgYSBE
RVNUUk9ZX0NMSUVOVElEIG9wZXJhdGlvbiBpcw0KPiA+ID4gPiBhbHdheXMNCj4gPiA+ID4gc2Vu
dA0KPiA+ID4gPiDCoMKgaW1tZWRpYXRlbHksIGJyZWFraW5nIHRoZSBuZnMgdGNwIGNvbm5lY3Rp
b24uKQ0KPiA+ID4gPiBpcCBuZXRucyBleGVjIG5ldG5zXzEgdGltZW91dCAtcyA5IDMwMCBtb3Vu
dCAtdCBuZnMgLW8NCj4gPiA+ID4gcHJvdG89dGNwLHZlcnM9NC4xIFwNCj4gPiA+ID4gCTExLjEx
LjAuMjU0Oi9tbnQvbmZzc2hhcmUgL21udC9uZnMvbmV0bnNfMQ0KPiA+ID4gPiANCj4gPiA+ID4g
aXAgbmV0bnMgZGVsIG5ldG5zXzENCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSByZWFzb24gaGVyZSBp
cyB0aGF0IHRoZSB0Y3Agc29ja2V0IGluIG5ldG5zXzEgKG5mcyBzaWRlKQ0KPiA+ID4gPiBoYXMN
Cj4gPiA+ID4gYmVlbg0KPiA+ID4gPiBzaHV0ZG93biBhbmQgY2xvc2VkIChkb25lIGluIHhzX2Rl
c3Ryb3kpLCBidXQgdGhlIEZJTiBtZXNzYWdlDQo+ID4gPiA+ICh3aXRoDQo+ID4gPiA+IGFjaykN
Cj4gPiA+ID4gaXMgZGlzY2FyZGVkLCBhbmQgdGhlIG5mc2Qgc2lkZSBrZWVwcyBzZW5kaW5nIHJl
dHJhbnNtaXNzaW9uDQo+ID4gPiA+IG1lc3NhZ2VzLg0KPiA+ID4gPiBBcyBhIHJlc3VsdCwgd2hl
biB0aGUgdGNwIHNvY2sgaW4gbmV0bnNfMSBwcm9jZXNzZXMgdGhlDQo+ID4gPiA+IHJlY2VpdmVk
DQo+ID4gPiA+IG1lc3NhZ2UsDQo+ID4gPiA+IGl0IHNlbmRzIHRoZSBtZXNzYWdlIChGSU4gbWVz
c2FnZSkgaW4gdGhlIHNlbmRpbmcgcXVldWUsIGFuZA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gdGNw
DQo+ID4gPiA+IHRpbWVyDQo+ID4gPiA+IGlzIHJlLWVzdGFibGlzaGVkLiBXaGVuIHRoZSBuZXR3
b3JrIG5hbWVzcGFjZSBpcyBkZWxldGVkLCB0aGUNCj4gPiA+ID4gbmV0DQo+ID4gPiA+IHN0cnVj
dHVyZQ0KPiA+ID4gPiBhY2Nlc3NlZCBieSB0Y3AncyB0aW1lciBoYW5kbGVyIGZ1bmN0aW9uIGNh
dXNlcyBwcm9ibGVtcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBtb2RpZmljYXRpb24gaGVyZSBh
Ym9ydHMgdGhlIFRDUCBjb25uZWN0aW9uIGRpcmVjdGx5IGluDQo+ID4gPiA+IHhzX2Rlc3Ryb3ko
KS4NCj4gPiA+ID4gDQo+ID4gPiA+IEZpeGVzOiAyNmFiZTE0Mzc5ZjggKCJuZXQ6IE1vZGlmeSBz
a19hbGxvYyB0byBub3QgcmVmZXJlbmNlDQo+ID4gPiA+IGNvdW50DQo+ID4gPiA+IHRoZQ0KPiA+
ID4gPiBuZXRucyBvZiBrZXJuZWwgc29ja2V0cy4iKQ0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBM
aXUgSmlhbiA8bGl1amlhbjU2QGh1YXdlaS5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoMKg
bmV0L3N1bnJwYy94cHJ0c29jay5jIHwgMyArKysNCj4gPiA+ID4gwqDCoDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9uZXQvc3Vu
cnBjL3hwcnRzb2NrLmMgYi9uZXQvc3VucnBjL3hwcnRzb2NrLmMNCj4gPiA+ID4gaW5kZXggMGUx
NjkxMzE2ZjQyLi45MWVlMzQ4NDE1NWEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL25ldC9zdW5ycGMv
eHBydHNvY2suYw0KPiA+ID4gPiArKysgYi9uZXQvc3VucnBjL3hwcnRzb2NrLmMNCj4gPiA+ID4g
QEAgLTEyODcsNiArMTI4Nyw5IEBAIHN0YXRpYyB2b2lkIHhzX3Jlc2V0X3RyYW5zcG9ydChzdHJ1
Y3QNCj4gPiA+ID4gc29ja194cHJ0DQo+ID4gPiA+ICp0cmFuc3BvcnQpDQo+ID4gPiA+IMKgwqAJ
cmVsZWFzZV9zb2NrKHNrKTsNCj4gPiA+ID4gwqDCoAltdXRleF91bmxvY2soJnRyYW5zcG9ydC0+
cmVjdl9tdXRleCk7DQo+ID4gPiA+IMKgIA0KPiA+ID4gPiArCWlmIChzay0+c2tfcHJvdCA9PSAm
dGNwX3Byb3QpDQo+ID4gPiA+ICsJCXRjcF9hYm9ydChzaywgRUNPTk5BQk9SVEVEKTsNCj4gPiA+
IFdlJ3ZlIGFscmVhZHkgY2FsbGVkIGtlcm5lbF9zb2NrX3NodXRkb3duKHNvY2ssIFNIVVRfUkRX
UiksIGFuZA0KPiA+ID4gd2UncmUNCj4gPiA+IGFib3V0IHRvIGNsb3NlIHRoZSBzb2NrZXQuIFdo
eSBvbiBlYXJ0aCBzaG91bGQgd2UgbmVlZCBhIGhhY2sNCj4gPiA+IGxpa2UNCj4gPiA+IHRoZQ0K
PiA+ID4gYWJvdmUgaW4gb3JkZXIgdG8gYWJvcnQgdGhlIGNvbm5lY3Rpb24gYXQgdGhpcyBwb2lu
dD8NCj4gPiA+IA0KPiA+ID4gVGhpcyB3b3VsZCBhcHBlYXIgdG8gYmUgYSBuZXR3b3JraW5nIGxh
eWVyIGJ1ZywgYW5kIG5vdCBhbiBSUEMNCj4gPiA+IGxldmVsDQo+ID4gPiBwcm9ibGVtLg0KPiA+
ID4gDQo+ID4gVG8gcHV0IHRoaXMgZGlmZmVyZW50bHk6IGlmIGEgdXNlIGFmdGVyIGZyZWUgY2Fu
IG9jY3VyIGluIHRoZQ0KPiA+IGtlcm5lbA0KPiA+IHdoZW4gdGhlIFJQQyBsYXllciBjbG9zZXMg
YSBUQ1Agc29ja2V0IGFuZCB0aGVuIGV4aXRzIHRoZSBuZXR3b3JrDQo+ID4gbmFtZXNwYWNlLCB0
aGVuIGNhbid0IHRoYXQgb2NjdXIgd2hlbiBhIHVzZXJsYW5kIGFwcGxpY2F0aW9uIGRvZXMNCj4g
PiB0aGUNCj4gPiBzYW1lPw0KPiA+IA0KPiA+IElmIG5vdCwgdGhlbiB3aGF0IHByZXZlbnRzIGl0
IGZyb20gaGFwcGVuaW5nPw0KPiBUaGUgc29ja2V0IGNyZWF0ZWQgYnkgdGhlIHVzZXJzcGFjZSBw
cm9ncmFtIG9idGFpbnMgdGhlIHJlZmVyZW5jZSANCj4gY291bnRpbmcgb2YgdGhlIG5hbWVzcGFj
ZSwgYnV0IHRoZSBrZXJuZWwgc29ja2V0IGRvZXMgbm90Lg0KPiANCj4gVGhlcmUncyBzb21lIGRp
c2N1c3Npb24gaGVyZToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBTm44OWlKRTVh
blRieUxKMFRkR0FxR3NFK0dpY2hZM1l6UUVDak5VVk16PUczYmNRZ0BtYWlsLmdtYWlsLmNvbS8N
Cg0KT0suLi4gU28gdGhlbiBpdCBsb29rcyB0byBtZSBhcyBpZiBORlMsIFNNQiwgQUZTLCBhbmQg
YW55IG90aGVyDQpuZXR3b3JrZWQgZmlsZXN5c3RlbSB0aGF0IGNhbiBiZSBzdGFydGVkIGZyb20g
aW5zaWRlIGEgY29udGFpbmVyIGlzDQpnb2luZyB0byBuZWVkIHRvIGRvIHRoZSBzYW1lIHRoaW5n
IHRoYXQgcmRzIGFwcGVhcnMgdG8gYmUgZG9pbmcuDQoNClNob3VsZCB0aGVyZSBwZXJoYXBzIGJl
IGEgaGVscGVyIGZ1bmN0aW9uIGluIHRoZSBuZXR3b3JraW5nIGxheWVyIGZvcg0KdGhpcz8NCg0K
PiA+ID4gPiArDQo+ID4gPiA+IMKgwqAJdHJhY2VfcnBjX3NvY2tldF9jbG9zZSh4cHJ0LCBzb2Nr
KTsNCj4gPiA+ID4gwqDCoAlfX2ZwdXRfc3luYyhmaWxwKTsNCj4gPiA+ID4gwqAgDQo+IA0KPiAN
Cg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

