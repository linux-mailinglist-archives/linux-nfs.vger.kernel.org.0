Return-Path: <linux-nfs+bounces-7508-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6AF9B13D5
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Oct 2024 02:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BA7282F5C
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Oct 2024 00:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFFC217F32;
	Sat, 26 Oct 2024 00:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="YvEhzuj2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2126.outbound.protection.outlook.com [40.107.93.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9E0625;
	Sat, 26 Oct 2024 00:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729902937; cv=fail; b=cpOUUDD+4rLZRr8ct4BDigzsltglFXmSUSLX59MGH4HlyQ9Dgn1dCpEQL7chtB0qtDOhDvHwpLfiZHdYWwkjuzBlb3374MN9FcVvxuC3p/RMm2oQPi5pKUPVB4k5EhUPbRRLgrxuSUKwlNX7Wok4aIhzFddvsuEJcjRcKwvfoNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729902937; c=relaxed/simple;
	bh=Oxgxzlhko/WoC1SaYekkfOFzxZ4u92YeRQXleX623ho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vGkNnoW4F7R/yivwWp2rQQtr43z0zOQalDICKk1SEpdWehdJL2MiDqYp8Bw5XX6cCGaivqOmkuI7GTnPBz2EDRyrOkPHR/eU21g6LJ/WABEiu+vVTprRtEXL4BvLbFvdFlPbvDV4XMmjVFDxcc30OgITl9RaIoiZrj1KAQoOB24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=YvEhzuj2; arc=fail smtp.client-ip=40.107.93.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRCa9d466M2G50Z8aCkeR6Vr6D1Tvm8w4bBO55Q/eI49CaKjaO+pmrz3QmdpaagobbHQZl8YXCpsFnfT5XKGez567dWJZaW1LB4QmxJHwE34c+17kc+c7kRZNCH1IbKK+WAdps7cC2X5/AJGAs6jKoEqrOacVHXkhZuojM4bBaMHwVb8O+Q9zEFatX+ADmFvJ7kW19BiXyza3OLPRp0rbR4GuR7QV+n3vvGqRg2PbSS628MO74WHNBX7QqVmMuTgaSso6pazXuoKfAAmS6/Jym0Q6ATS0FHGJPg3JgIzTbbREylWSt6uKgsq1FM8duVqKaErDih7WFsRcHMQKaxWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oxgxzlhko/WoC1SaYekkfOFzxZ4u92YeRQXleX623ho=;
 b=qQudBfINsO2z9dOdPm39zx990IddqLKstEfXS893/7jl1o5hQ8uF0kSYLfCbrk6boTOC9c137Rkw1JCzHJ5i3AY+j0nG8vX9dW97ORgPKLVXM1m1yN6GJC1vmSkKm7d0Z1awPvCSiSpc0GIUD1+1teAENN5DZn8hNmBlHI1FPt4MGO5KDOyfS7qHN6zlKPIqK5W0B5g85Dq8tuHvrc30FtNT5JNYtgTu3yHV+JazyHPuPxHoKBfVvHMVoWtbNNSWQEaHD1+I94VKxl3qf5KR9JR/ON+w26f6QJY76lPYReqL6g8Xj2Noz4uEaUQ2v0r9/Z1UYVVtrL7eipsF+FVZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oxgxzlhko/WoC1SaYekkfOFzxZ4u92YeRQXleX623ho=;
 b=YvEhzuj2sw3B5aLWiEmjqMvW/nUPn5N+/ot4e03rGV7ySiSE4KZpAlUcbG7mxxDq+htgNRsJ+fmGz8j4v7mLBLSbCdzIAnwgWBp1BgXdBJiMG1FszDxTlJVw506GdaDUVgfXfLqbCsyes4k6O3JWOTpYNPete1dnyMXfHD6tuaw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by IA3PR13MB7125.namprd13.prod.outlook.com (2603:10b6:208:538::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Sat, 26 Oct
 2024 00:35:31 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8093.018; Sat, 26 Oct 2024
 00:35:31 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "liujian56@huawei.com" <liujian56@huawei.com>, "kuniyu@amazon.com"
	<kuniyu@amazon.com>
CC: "tom@talpey.com" <tom@talpey.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "ebiederm@xmission.com" <ebiederm@xmission.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "okorniev@redhat.com" <okorniev@redhat.com>,
	"anna@kernel.org" <anna@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "Dai.Ngo@oracle.com"
	<Dai.Ngo@oracle.com>, "edumazet@google.com" <edumazet@google.com>,
	"neilb@suse.de" <neilb@suse.de>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net] sunrpc: fix one UAF issue caused by sunrpc kernel tcp
 socket
Thread-Topic: [PATCH net] sunrpc: fix one UAF issue caused by sunrpc kernel
 tcp socket
Thread-Index:
 AQHbJbtPJ4ryUqLRAUiLTzYVTAhYbLKV3SkAgAAL4gCAAAS1gIAA4+4AgAEqVACAADZxgA==
Date: Sat, 26 Oct 2024 00:35:30 +0000
Message-ID: <0e434c61120b5b4a530731260c0f2c72ad02fa6f.camel@hammerspace.com>
References: <d340cd68-f08b-41e6-9202-a13225c744a9@huawei.com>
	 <20241025212038.31584-1-kuniyu@amazon.com>
In-Reply-To: <20241025212038.31584-1-kuniyu@amazon.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|IA3PR13MB7125:EE_
x-ms-office365-filtering-correlation-id: 0b62ef70-c783-4d30-ce78-08dcf55618b7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGZ4R3BxVGQybmRyemNEdWl0Y2VnYXU3dEFKS1k0SVlMSmdISVJLM2VNaGZP?=
 =?utf-8?B?Z2JHVVBOR3ZQbVc3YWxnNllvR3R3dVpDTkFhZmJIZkdGZVAxMFZXOUV6djlk?=
 =?utf-8?B?UUNRL0RVdjQyb2oybXNzQVp2UEFNQ3hZeG1MNDB2ei9JL0RrRHVDM1diTTNz?=
 =?utf-8?B?ME5FYnorTGNrWi9wYjdPZUtycDRyeFdpeXlidXkyUy9XR0w0Nm1neGVyS21Y?=
 =?utf-8?B?L25PaWNYU2hVOThYZWtmcUlMcXJkQlNSd0IxT2tJYVAzVktGakVvcXNZNUJD?=
 =?utf-8?B?R20vU0VrL1dvTE53U2xOYURaY2FNQkVZV0VVbHRGYnhoTVgvclpGdTMvN0Nw?=
 =?utf-8?B?SSsxeW1qcGxKY0UzdndKbFVZa0M4Z0FCMUZ3UU5saTFFdHdzYTVaTGIvbkIy?=
 =?utf-8?B?THdEUTNUa0hrUFkrMm1ndDdzT3haWFdYbGRWMGZZSVhnOVhUL2ZDOVZtUEhq?=
 =?utf-8?B?cS9MRmM1NW5yMExZTmpGeThrTlBLTmtwT2U1RDRtMXhWbFErbzlweUZ0Sk9H?=
 =?utf-8?B?RnBFVitSSENtRktISDVMRTQyeUdva1NCK1RpWTNIczUvUzBoYlBGdDdPemR3?=
 =?utf-8?B?NnRQVThsOXBEaEdCUHRsRmNFeS9OcXJhdzdkaXZrNitQb2gwR0E5RlpjSlJU?=
 =?utf-8?B?QXhzYlBSTDNrSGVuUHlCakk0Qm9YQk0vZE5SdkJUV2k1SWEzZWVRaGN3ZEZy?=
 =?utf-8?B?MysvRzk2M0ZJWSsxc1NmekFJMzdRYnpFamorSzFEV08rbjlFOHJMeXdVUnVk?=
 =?utf-8?B?QTlMVXViem15ZXEySk1xR3dNaDRPVFUrcFd5SWFEd0thT3BxcG1aK3BxNVVJ?=
 =?utf-8?B?MHhWTjdpY2ZseDB6dWhXUGZZTVlSbzl4RDVRY3JPNEIxU2FYUmNla1k2a1pS?=
 =?utf-8?B?dzJJYU56YTNDVHlhOW5zaDgydnZzT2NwNjdwTTFiTDBxa2NQNUZKSkorbDg4?=
 =?utf-8?B?UXNib3g5WGtmTklmMFpuOFZDcm10SFFOY1NTeWhTUmsrczZoNVpiUnhSTllN?=
 =?utf-8?B?WU0wZGhKOElxUkVha1Jtb1IzRDlZeXVhcWZDd0VoZHhZWUFQMmROL2didWVa?=
 =?utf-8?B?dkZ0RjBhY1dmWjYyZFlFSnpSenBkOXVKZFBqRXYzaVdhYUk1dzlWVjErUjk4?=
 =?utf-8?B?UEIvMFZKMldBajdUMlBaL0FLa0svbnBvNTY5SG1NZnpSUHNsaC9oSERJaGNu?=
 =?utf-8?B?dnR4TTJkclpLRzJhTFd4eUZ1VjRib2JXZlRlcC9WV0kvenB5MXJ5ZzlibkNZ?=
 =?utf-8?B?SElUamp2b0FoTlZaRC9zNWh4T3JrckRwOVJzcHV3dmRWbllRb0hRN1VpTkx3?=
 =?utf-8?B?TnFGNUV6SzYrZlJzU2lIK2FPaWhoMnNqMnhVS2xyREprUUlyc05aS2FRUXFE?=
 =?utf-8?B?M3FNYUlvRnhlT1VhYjFFeld0eDVySjBhN3EzSXkvQmtFMEQxVzk5Z1BweFV4?=
 =?utf-8?B?S3FVT0RwQ2h5aTNDZmhYSlErY05kc25CRVJGQjBKdFRKaTl5bEdwaXduSk1I?=
 =?utf-8?B?WVlTRVJNWjhoZGxnMHFVQU50bjJDV2lqbzBVOUswRE5DVjZrWFp5ZWltSEVK?=
 =?utf-8?B?dTVaVk5Xdkh2Tzh2R1lGZGp3QkliaU5CU3ZNRmVOUFlTOTRiUE52RklBMThB?=
 =?utf-8?B?cHNXMmdjRVFUWDdHNnhjOEd5WnozZ0N1b2FSemZPSmNuYStNbkhKVkl0OWdi?=
 =?utf-8?B?Z1FHdkFwelp1U3R2T2xmUmJ4SHo4YXUzUjFLOXBlOC9Nd0ZTOTJ2czZBOVV5?=
 =?utf-8?B?Q25WY2xFZUlnYy93R3NTYWoydjJ3NnIzOVhPVTNxblpxWElxMVFLZ3l1cytt?=
 =?utf-8?Q?QvtFkV7hXVHlaJ43NgJ0+CHC9OUkZa6awImMQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXR5MjRxaGNwbnBBRUFOb3VLMVlkYlIyMDZuUG1WSHpOTnpEMmF4Y2JlMHlm?=
 =?utf-8?B?cFNZVlhjcnViTVVFbnZ1eXBvQUtSOEdjbml4aFZadEY1L0lJa1J2ZXRxd29h?=
 =?utf-8?B?NEg0aDNpV0p1eEJJa3pYZ0xJYUkxd1pCTTk0cEdLeFRjNWkycWRPVTUyVWFY?=
 =?utf-8?B?ZUUrcDJ5ajlRSnhOMTFvKzVDcmRwR1NHT1JEMHR5WU5keEREL2x5UVcrWS9M?=
 =?utf-8?B?WWt5MGxZcUljVmY0ZE51ZUdaREtTWGhCSEV6TWtsakY1aC8rT3dDSk9zVGdU?=
 =?utf-8?B?S2EyTnlGL3kxUVNTOHNiWVdKTkM1TkN4ZUViQk0xbENjU2szYnNiTFBpZmFm?=
 =?utf-8?B?cE5BUk1CaXh1blFSbTdXb0syUGpGT0ltZDFiYUxHVmh5aEdaTnY0dElyK0xK?=
 =?utf-8?B?ZzM5QWNnajIycG5pSk9tZDljNEtBZDZjbTNXdmkvK3RyS0toY0dOQmZXMUZY?=
 =?utf-8?B?SnVEODIxZVdzMlFqZzFxeUptcnZVSGcveU44VXMyRDloNDRxdVFtV2NNbE1C?=
 =?utf-8?B?MmZYaVFaOG9JYWl2MHJaYzNhYzJtMWQzQ3V6K3Q4cHNsQkVENS9lR2NuVWVS?=
 =?utf-8?B?b3hjZENuUjRSTlpFVkRJTGxTYkdrRlc4UlJLYlB4cHN1aGRhSjlONjM5NU9D?=
 =?utf-8?B?VjlmQ3VkN2NXQ2dNRUZ6aFp0dG9HVUFDM1M0QkZLcnB5dEJlMW5yMmo1NGtR?=
 =?utf-8?B?blpBdEpIZjZ0NzIvVmphN1RsaGVPcmN4VHQwQVd2YWdZSDdMY2VOaFRqVnNz?=
 =?utf-8?B?Q0dLaHhZSUJib0JXcVp2UmlBbUFTVEJkVWVJVU5jMG5OL0c4d1FYbWo1QzZS?=
 =?utf-8?B?QTVqUXQzSjJIMndnQkl5Qklta1BZMThLTjZqMnBGQThkMU9YMEJ0andWUTFN?=
 =?utf-8?B?a1gxU3cySjFENzZGTmQvRVBFOFRvcEVSeHM2RmxFaEdoWHRObEFpZkxjNldu?=
 =?utf-8?B?WlpYb1dyL2NYbjViN084aXdJYUxxU1VDNzIzNUdSUkRoaENKQ0daTGFoYnR0?=
 =?utf-8?B?ZWswTjcramdKWkc5dW5GbEdEbGVrRmpTYTYranF4Wld5Z3ZpcE1OYm1yQjlh?=
 =?utf-8?B?MDgrNjF2MWxrdGlJQys4NUVDdG0rNXQ3UnFhQzNYV25UNTFBNXBsZFVPZmpk?=
 =?utf-8?B?QU15Q0lFTndTV1lWSUROWTRuaUlMQmVKM2Jzd2ZqQkxpd1ArR1FZWWtIeXc0?=
 =?utf-8?B?VzdDVDVxK3JDMG1qVkFsbEpvN3hEWVJibGk5Q29oS0ZpSU1wbWNqUFEyREZM?=
 =?utf-8?B?RUROb09FU2dqZkRlTWtKY0Vzck5HbXEyV0taRmlDV2tNUzZiUzcwY1hKYm1l?=
 =?utf-8?B?UXVIaXVmT0xtcVltL2lEa2MzbmRqUFlFQUhDOUlRc0J0cDhuaFNkek0yWWM2?=
 =?utf-8?B?ZXV1Wk9wMllzWEJQYUZnejhkbnVVZnJPOXI4K1BsSkdUaXlmR2tVWVpOUDVr?=
 =?utf-8?B?NThRcG9tOGpneEowVVZZY21wWko4TlgrbCtCWVdLVTBXNENMS0VqSnpMZ3Fn?=
 =?utf-8?B?bHZDRDk2TzY4b1NEejZyWW5hdVB3dXZiT243ZC9jbnYrZlVJTlMxamNidHoz?=
 =?utf-8?B?WFZmMUtleVpESC9YdGxsU1dVelVVdmgzTFNYRWp5cG9YMEtUSmRCV2VzY2JZ?=
 =?utf-8?B?ZnRrU1ZzL2kvTUdzaXUyUkdCRkpORndBc0ZBR2M4OTJYR1BJWmtUV0YzNXpl?=
 =?utf-8?B?U2ZvVHNBYjM3dmtDMWxwdGdFNi9IZjNjOVZGVWFTVU9pbWswa2tmaEhMcmVV?=
 =?utf-8?B?WFEzUTU5akhuT1ZmRjZmUVQwYjBvUm94UldlVnlrcXN5OFVoc0trSnlpTmlO?=
 =?utf-8?B?VDY1ZVdOclVTaTdESXV5Q2ZFRjFKUFloQUhXdUZ3R0tLaWRMQ05sc2Jodjg0?=
 =?utf-8?B?WFRndzdMd2FEcEdvY1lRVTJ0dTZoQmU1STNLQ0t1aFhHWlZiOU1uMGJEc29y?=
 =?utf-8?B?cHV4dWREcTVaaGVQeGZqWmRabnhTL09uNTd3L3h5S3oxTCtPK25kdmQ2ejBq?=
 =?utf-8?B?Y3QvK3VoV2hZYWV0TkppYVdlZHgrNDRpOWtJeHNyQ09sTnFtYy9xVjUwQVN6?=
 =?utf-8?B?bDJGWGFibUFiSU45MW56bVZ6QTFOYW5HV0tRK1VDcjNXMllkOUcvdTdGL2lP?=
 =?utf-8?B?WTdza2s2VGJCM0lEenVhWDNnNjF6VjBxV2FXa1o4cWtnQmpvU1YwTWNibGJO?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F7B69D43A6EB7499F25ABED6D3C7762@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b62ef70-c783-4d30-ce78-08dcf55618b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 00:35:31.0192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7E1cJAUPBa6F8mG0QK2knTELrjEWRm1ywNPoH1ijImXoWW2kIhJao8F4UUsxJ0eJlVKV41nHzSXM4s5j6MIhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR13MB7125

T24gRnJpLCAyMDI0LTEwLTI1IGF0IDE0OjIwIC0wNzAwLCBLdW5peXVraSBJd2FzaGltYSB3cm90
ZToNCj4gRnJvbTogImxpdWppYW4gKENFKSIgPGxpdWppYW41NkBodWF3ZWkuY29tPg0KPiBEYXRl
OiBGcmksIDI1IE9jdCAyMDI0IDExOjMyOjUyICswODAwDQo+ID4gPiA+ID4gSWYgbm90LCB0aGVu
IHdoYXQgcHJldmVudHMgaXQgZnJvbSBoYXBwZW5pbmc/DQo+ID4gPiA+IFRoZSBzb2NrZXQgY3Jl
YXRlZCBieSB0aGUgdXNlcnNwYWNlIHByb2dyYW0gb2J0YWlucyB0aGUNCj4gPiA+ID4gcmVmZXJl
bmNlDQo+ID4gPiA+IGNvdW50aW5nIG9mIHRoZSBuYW1lc3BhY2UsIGJ1dCB0aGUga2VybmVsIHNv
Y2tldCBkb2VzIG5vdC4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZXJlJ3Mgc29tZSBkaXNjdXNzaW9u
IGhlcmU6DQo+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQU5uODlpSkU1YW5U
YnlMSjBUZEdBcUdzRStHaWNoWTNZelFFQ2pOVVZNej1HM2JjUWdAbWFpbC5nbWFpbC5jb20vDQo+
ID4gPiBPSy4uLiBTbyB0aGVuIGl0IGxvb2tzIHRvIG1lIGFzIGlmIE5GUywgU01CLCBBRlMsIGFu
ZCBhbnkgb3RoZXINCj4gPiA+IG5ldHdvcmtlZCBmaWxlc3lzdGVtIHRoYXQgY2FuIGJlIHN0YXJ0
ZWQgZnJvbSBpbnNpZGUgYSBjb250YWluZXINCj4gPiA+IGlzDQo+ID4gPiBnb2luZyB0byBuZWVk
IHRvIGRvIHRoZSBzYW1lIHRoaW5nIHRoYXQgcmRzIGFwcGVhcnMgdG8gYmUgZG9pbmcuDQo+IA0K
PiBGV0lXLCByZWNlbnRseSB3ZSBzYXcgYSBzaW1pbGFyIFVBRiBvbiBDSUZTLg0KPiANCj4gDQo+
ID4gPiANCj4gPiA+IFNob3VsZCB0aGVyZSBwZXJoYXBzIGJlIGEgaGVscGVyIGZ1bmN0aW9uIGlu
IHRoZSBuZXR3b3JraW5nIGxheWVyDQo+ID4gPiBmb3INCj4gPiA+IHRoaXM/DQo+ID4gDQo+ID4g
VGhlcmUgc2hvdWxkIGJlIG5vIHN1Y2ggaGVscGVyIGZ1bmN0aW9uIGF0IHByZXNlbnQsIHJpZ2h0
Py4NCj4gPiANCj4gPiBJZiBnZXQgbmV0J3MgcmVmZXJlbmNlIHRvIGZpeCB0aGlzIHByb2JsZW0s
IHRoZSBmb2xsb3dpbmcgdGVzdCBpcyANCj4gPiBwZXJmb3JtZWQuIFRoZXJlJ3Mgbm90aGluZyB3
cm9uZyB3aXRoIHRoaXMgY2FzZS4gSSBkb24ndCBrbm93IGlmDQo+ID4gdGhlcmUncyANCj4gPiBh
bnl0aGluZyBlbHNlIHRvIGNvbnNpZGVyLg0KPiA+IA0KPiA+IEkgZG9uJ3QgaGF2ZSBhbnkgb3Ro
ZXIgaWRlYXMgb3RoZXIgdGhhbiB0aGVzZSB0d28gbWV0aG9kcy4gRG8geW91DQo+ID4gaGF2ZSAN
Cj4gPiBhbnkgc3VnZ2VzdGlvbnMgb24gdGhpcyBwcm9ibGVtPyBARXJpYyBASmFrdWIgLi4uIEBB
bGwNCj4gDQo+IFRoZSBuZXRucyBsaWZldGltZSBzaG91bGQgYmUgbWFuYWdlZCBieSB0aGUgdXBw
ZXIgbGF5ZXIgcmF0aGVyIHRoYW4NCj4gdGhlIG5ldHdvcmtpbmcgbGF5ZXIuwqAgSWYgdGhlIG5l
dG5zIGlzIGFscmVhZHkgZGVhZCwgdGhlIHVwcGVyIGxheWVyDQo+IG11c3QgZGlzY2FyZCB0aGUg
bmV0IHBvaW50ZXIgYW55d2F5Lg0KPiANCj4gSSBzdWdnZXN0IGNoZWNraW5nIG1heWJlX2dldF9u
ZXQoKSBpbiBORlMsIENJRlMsIGV0YyBhbmQgdGhlbiBjYWxsaW5nDQo+IF9fc29ja19jcmVhdGUo
KSB3aXRoIGtlcm4gMC4NCj4gDQoNClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24sIGJ1dCB3ZSBh
bHJlYWR5IG1hbmFnZSB0aGUgbmV0bnMgbGlmZXRpbWUgaW4NCnRoZSBSUEMgbGF5ZXIuIEEgcmVm
ZXJlbmNlIGlzIHRha2VuIHdoZW4gdGhlIGZpbGVzeXN0ZW0gaXMgYmVpbmcNCm1vdW50ZWQuIEl0
IGlzIGRyb3BwZWQgd2hlbiB0aGUgZmlsZXN5c3RlbSBpcyBiZWluZyB1bm1vdW50ZWQuDQoNClRo
ZSBwcm9ibGVtIGlzIHRoZSBUQ1AgdGltZXIgcmFjZXMgb24gc2h1dGRvd24uIFRoZXJlIGlzIG5v
IGludGVyZXN0IGluDQpoYXZpbmcgdG8gbWFuYWdlIHRoYXQgaW4gdGhlIFJQQyBsYXllci4NCg0K
DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

