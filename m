Return-Path: <linux-nfs+bounces-10663-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0536EA67E8C
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 22:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231DE19C4C98
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 21:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900EE1537CB;
	Tue, 18 Mar 2025 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Q6cfFzHI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2096.outbound.protection.outlook.com [40.107.93.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C58143748
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742332651; cv=fail; b=fJOFZsQNMHwOGHGndDfAEAeJTWjTDzd1rtzOGOwA6ybFbuN4/tywUZG6erV1Qp6LRjS6esDHLPdQyNgeJNx1m85151uAU+NS/S6MusU/0oUGPs9LySaZNGNCfaerxKERJ3taWl2HyZcECvwKlxvSP3BKoLihXWiQilhQ4hW/toE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742332651; c=relaxed/simple;
	bh=XxZPVizvR9J/fJwsg8Rl7zzdBQ+ADvJrMkCI6FOIaMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E6I4/oMdR+0JLHk4Zv2GwVjg/0xcMV9j0zbAR9jOYKviTUEQ3KkqhPIk7MvQzPmMMZ2D0SZIv2/hm8hlvh0XFOlmM4He6QGN54KJmukTTSKucyjumM8jhqOGVcoS79XmVV0GCalkTjorBSXGO5D34D4yWL1Gxr7M4cLfYbUNsdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Q6cfFzHI; arc=fail smtp.client-ip=40.107.93.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMCLC5ywoPST2/HACSMNHayCUMzGSnGlkyAPbyMD1/d6tteIU8IDLcr2QO1YuJRXEBz93U12rWAQiojl4GzLAVpdjEiM7pL60tm6M/r/91XmrjNgSuhWJuaGih+6JYId6l2JzhS32JOW6GWoNToVvaYL3HVLl84zHTKuF7TP0dCzADwnjTB2nli6oBHTBhp6jxpWxnjGzsWac18BlE/PLv1LdnqU8gtbJV4cZFlA7dkl+zuaQ7Pw34/GkWQRE6S84cqcy3WrRYR2gzuDHXWSpaqiU9+rbw6+KigeMOl3Hl6GwhvleJrAmEkkbJr6uUagaIQ8A+lKqObrq6dvMh941g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxZPVizvR9J/fJwsg8Rl7zzdBQ+ADvJrMkCI6FOIaMI=;
 b=MRL0acRHv9j0aYYI6xjJ+f5T24ZkME3mfYJim+MnUGRssdfR7ROe1YYffic7ZIibogWhKcjgTZVrpq6XW1AR84M0mlGvwlK+sF+fnC3JWimS8j8uFV6qmNtNmBA6QW9T28DSiZZoqRs/pzsnmpa2jKct10IOSoUvOoPz5hpREjli5V3Ml502xIp84zIfctzl6jv8w2v7rkYzbzkb8j//4kr43zaIr0zV1onZAUM0h/fSHItZ7ZmdE8bVTydRzyZSrY5YRa6fOJd74BeHSYjktWz4mOQWEwFYBTTaDwluNR3riP8Rc4NvkOlVluSaYzqcztizs+Q5NRzCa5rReyWapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxZPVizvR9J/fJwsg8Rl7zzdBQ+ADvJrMkCI6FOIaMI=;
 b=Q6cfFzHITNH58wafsB8tWVcIf8k3z2o+3+V6YuOtJUvnRQAetU3r+Im4nbNwY+uGk7y2bGUBSd2UQ2hkA4/hHCR2+UDiR0gX84OWKJgJRaA2ye8iv8pQxIJbTTQpe/eXYC4WfjhncHaYC6dU4m0HRuae1m/acO03ttxgklCFITc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3885.namprd13.prod.outlook.com (2603:10b6:208:1e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 21:17:27 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 21:17:26 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "rick.macklem@gmail.com" <rick.macklem@gmail.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"takeshi.nishimura.linux@gmail.com" <takeshi.nishimura.linux@gmail.com>,
	"anna.schumaker@oracle.com" <anna.schumaker@oracle.com>
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
Thread-Topic: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
Thread-Index: AQHbmBa5xy/j3c2GaUCylZ3htsCWqbN4/18AgAAOAgCAAFTsgIAAA8+A
Date: Tue, 18 Mar 2025 21:17:26 +0000
Message-ID: <e674d6ec96cc8598b079efd3b93612537f840a87.camel@hammerspace.com>
References:
 <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
	 <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com>
	 <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
	 <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com>
In-Reply-To:
 <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB3885:EE_
x-ms-office365-filtering-correlation-id: 2bf62ca4-2b26-4e76-3d36-08dd66624898
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1FrdHVuYXNBRS9HSy8xQWFjcUdleFFlc0lkSDE4NVN4enFXOHVrNlJuK2Yy?=
 =?utf-8?B?bHMzOG1LRDVUMVVrdEtWYXJOV1I5eHRCM3VER2J4QTdLcnZZcHFVMS9zMmpt?=
 =?utf-8?B?OTEwUXdPaVdreW5hQitWS3pTYzlkcUNGYTZkM2w0eGY0b3FYTy9xdWd2aWNq?=
 =?utf-8?B?Z0RkdGtVUjB0eHVhbXVBL3d3TXJtR1ZTT3huemhwWVRiTTVGQ2owVnNqcmdj?=
 =?utf-8?B?NFpyTDllK2RMZUZ1ZHV1czNzV1R3RVBQNSttcWNrTlkrS2pXSmRJL2VjaW5s?=
 =?utf-8?B?V2hFU0VxNXZGMEhETHFrclVWTnUvTVVhODVJTHBhYXZYWmN0aDRqcnl3ZElH?=
 =?utf-8?B?TFYxS1cvMHVXd0hoejd3UTNpNXdsU3NLTnU0eGVDSUswUzZxTlY5MWlGd0Z2?=
 =?utf-8?B?UzNsZ2prdWtjYi9GQVRsMFNNTjczN1BaSFc5eVd2TUxranRvMjBlbzAwanUz?=
 =?utf-8?B?c0pJUGlwT2d6OUVRUjI2bElCSzNXUThvL3duNHRjbkVqdlVqVHlQWFRselZ0?=
 =?utf-8?B?SitKcytRQVpJYmVqdU55QkNqU240OUtpTDNPZmlsbzdwbzBhWXp3dVB0K0Mz?=
 =?utf-8?B?V1VZRkZ1YWNoVEUzQWZtczQ1VzgyVU1oSWNTTmhaU0hGUUF1alRHTko4SGg4?=
 =?utf-8?B?Z1ZQTEltSnFheC81cVUrMUFpSEw0a2hhcnpHN0pTcTZPaDlDajB2RWh4MXF5?=
 =?utf-8?B?RnZpczZLRy9vUmZjeU8vYkVlRnNKR25MZGg2SFdlMVBjWTdoMUpxaEJPZ1p0?=
 =?utf-8?B?a2Rjd0dkdmFORWZ3dWNpU0VnQ0IvOE4yTEI4RloxNUZKMXZSYmlMc0FiZzNx?=
 =?utf-8?B?RWhkdVYwcWVEQUNHWE9SK3YxK2VFRCs0SDIvWnJ1UUg0OU0wRjNtL1NreTJo?=
 =?utf-8?B?c2NyQ2xPUU0wZ0k3QXBGUFlWOGI0Y2JDWHI2T1lIQVNCc0lyT3RKa0FPUkRy?=
 =?utf-8?B?L0ZBUzdSQU9iZzJrREJVRVBRanZOWWZOSDRXejVTSkNCeldxQTJIN3JyRng0?=
 =?utf-8?B?Y0hKOGlBdEUyTE5JMjYxbDZHZmwxei9oMXNBZldPejZpSWJraVBRSUJ3ZXdp?=
 =?utf-8?B?V013Ni9LaDRCRUlHc0ZTVFIxZWNtamtkRkc1bmQzUTBnTVd2QWtuTlhGbFg2?=
 =?utf-8?B?TlNQelpNbURnMEViOWgzWnlWdE1XakNpZWVTbTVKWDEyY1cyMGlyUFZSOXVW?=
 =?utf-8?B?OWFybWdWRG4rQzdjSlJGUWdoTlJyQ28wa2NNY0pKMm9pTDNRa1pVV2VwRndO?=
 =?utf-8?B?OFBOa2lqNUo3a0hyc3N2OVZ6Y1V3QkNtRFI3ekxrWm9OeGVGOWZ3ZEV4RFkw?=
 =?utf-8?B?SFFCRmhWZU0rSERCU09vdGJ4MFhUQmJHN3Yyd2FidlZtWStyd1V0N3FENk96?=
 =?utf-8?B?OXkramZIaVhYUkRxbWlIVkZrRVg1SkkzMkdObFBvcDI3bzZkcWJib1lXenQz?=
 =?utf-8?B?S1VBdDEvdlFweUExRGkwUXZCakU0MEdYOEdtVENLZUI2bmhGc2tFS1NNenVH?=
 =?utf-8?B?OGNyZXVzcGkxb1VZclNUZCtGNkllN2ZtVW81TkRFQ0Vrc3kyZ3kvdjZKdzlZ?=
 =?utf-8?B?b3BoTEt3cUY1akxva2VVRFlvcVgwOXhOSitLUkN3ME85RG8xbGFDeC85ckpE?=
 =?utf-8?B?cm1zUDZqYkVMNnNDaFVyNTMyVUk4SkZKYThWTkhxUTJTbHRUekQ4ajFSUVFG?=
 =?utf-8?B?SFdlQmlJSlhVMHd6NEtML3A5bzB0ZEdVZ21ISGoyaDh4Slk3eDNoWHA2Rnl4?=
 =?utf-8?B?RG5la2pSOG9YU1JDazFGazJDZTM5YlRRZUFsUEJOd1RqakM1eWI1ZkdUMWs0?=
 =?utf-8?B?dStZZlJDVVNSZnBpYkVPK0lRbFp6aDJtbG9yeXY1bWpQVytuRFhXRGdWcHFE?=
 =?utf-8?B?NjlraVJlZEhaOU1OR2tuS0ZlUHM4UVlJNjFqbWdoZ3lLQktCYUxHSnBOVVJ5?=
 =?utf-8?Q?+QUgMPzcIABbhXCPty9FW1Samc13GCFP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2dsYWtCWkUxZEtxV1RtRnl6VHAvYUpBY3B5WVRRSlhLU1MyMm93UGZ3K3Az?=
 =?utf-8?B?ZlI5Vm52bGFSczF0N2RPb2ZMVFQ3bVVxUGRLL0VBUUtVY3lSM3ZyTnFjRnFM?=
 =?utf-8?B?ZUw5c01GWlZ3dHREVllYaThkNWI1TUFpOTZ4aitCOG1ZQUp0OTBQSmxGTzVK?=
 =?utf-8?B?ZWVMa0w5dEZxamJUaW05K0NlM0M1ZmJEYzBYalVNVzNxYzhuM0pmdW0wMkcv?=
 =?utf-8?B?T3BSTDYxd3NoZlhoYlM3Zm41aEdNT3NDWUFzRVBMU2EyRXZnelJ2TEV4OHIr?=
 =?utf-8?B?a3BENU5OczFLbjNkbnFMQ1J5NS93ZVZQYmRwY0JjSHdNQ3FFN2JnbVN2dUpX?=
 =?utf-8?B?ZWJ2Vm5ZR0VMdUVTOW5KSWVWUDE1M0NiU1BEcVdhMXJhU3hlb1o3NDJVVlQy?=
 =?utf-8?B?NTFuaEZFTXp3TjdpNGZQcTlzK3ppSllUWUQvS3hZeUF6VXNWL2JFRmZpOXJM?=
 =?utf-8?B?V0U2RmdRalZubWlIRnZVci91L09OQjJSVjgzYk9CN2VyK0RsWmhuOHo1eEtn?=
 =?utf-8?B?dkFNVDJReFRsdDV1Um44dkRtSkFKQmZlQ0UxMFZnd1psakZFY3lSTFcvaHRE?=
 =?utf-8?B?VnY5SGNuMjhkVjZhNHJUZnVzbU1DM3l5Q2pwaUdoMk5EdDhsdFlCUFc0S1Bv?=
 =?utf-8?B?bDlzNXZjOFdKK1M5TEY1R1ZpWDJEalFiMXdzYXp5dmhDbXRuZ0gwVm1LMTBn?=
 =?utf-8?B?NVVwUEpBelB3dG5iMHZ6Z0xBb1A0eWhhV1kxTWhMbEJrVlZpcWplQUlGdmUw?=
 =?utf-8?B?TndseVVZSUVXaUlWdVluc1lZa0hoeUk2MDZyMWhkTjRMT3ArWEdjTng4bEFl?=
 =?utf-8?B?RWlvZWFHQVdHLzcxaUp6aW80eVpJd2dhVHNpR2p3YmFCSDFhTGZ2QjIvY2tP?=
 =?utf-8?B?Z3pJQmcyWEY5MFMyS2JQNzlURGhybkI4T2VsY3phc0VPaTJOU2haNXNWUW5V?=
 =?utf-8?B?L0VWWHJENVM5L2c4UitsLyszd2RhL1Q3dzBFVC9FQTNoMWhXanExUHZHWEl3?=
 =?utf-8?B?UE9KNjVyckhlY2c1bHVzNEVncStqSXBzOENuU0NGdHdVbTNTakNwWWJyQ1U0?=
 =?utf-8?B?bWlWR0JEQW1PU0ZreFpLUlF6WmJ3QWxuNDZqNXE0bFZHZXZWdU1JK0luTlpo?=
 =?utf-8?B?R3Z5UmtBQ0ZuMDZyY3FTUVMySGZKRnJFRDVwTVNVcnRIZVdneVRXc1Azb2Js?=
 =?utf-8?B?V2FWTksvd0NnSHBBTGV0bnNLUktKejlTK0ZRMnlTcm5xZTQ5L2tFWENBRkpQ?=
 =?utf-8?B?ZmJVWHVwK3NMNzMwR0FXbnd5RmgzSkRydUhXbnovc2VXc25EcWFRU3pDaEtX?=
 =?utf-8?B?UDE2VDZqYU8wbUVTYkNQeWFmOGQrNEdSLzI2c0Nza2VWVGtpS0EzcC80MVNs?=
 =?utf-8?B?VWFhR09wWFNGaW1NdTI5QWQ5Sitxc1pPNTIzb3kxL1BBWFdLTzkwZzVTT2pP?=
 =?utf-8?B?NXJURkNMK2tvYVBmRHJpT1RZYmY0dGx6NkpqM1krZTZxN1VENUtrRHJwajRw?=
 =?utf-8?B?U2dJdUN4V1hWZmRoM0xxSVBNVVRPY05PN1pqRGE4T0ZqcFJhSHFuOFp3UDVY?=
 =?utf-8?B?SWVRajZIbjBoVnd3Y0NxOUdoVU1MZi9WNXpncjlWUlNCZ0o0VHhFVWdPUC9M?=
 =?utf-8?B?dWt0dGJrTnNseTZNcERRVDBEKzdVQjRDTGxONUtUdlZLVTNoQnl4SCt6WFRs?=
 =?utf-8?B?d2FpRytQSVg2MjduTDJhV0JLSTdZVzAxRDhkKy8vNUcvSEVMbnFPcWhKQTZm?=
 =?utf-8?B?K3pXY2NiT2daTVJ5eE5VemxJYzJ3ZjcvYzYwRndqbzJXNWJTWVFRNDAxRkxR?=
 =?utf-8?B?TTJ5M1FqSVFsbzZ5TUxrOXcvZGZzMFkvdlBUN3haMjBXVjdpQXlldjRaR0ZF?=
 =?utf-8?B?YkxwTjY4ZVlobUlyUERmWUUzVlVLcEJ6STkyQW5UWVpSMWxvcUw4Q2h1T2tC?=
 =?utf-8?B?Q1BHd3ZFMXE3bk0xWUZIb1F6QlJXTmVTZFJKUmRGSkpYUmZiODRBbmpFWlBS?=
 =?utf-8?B?dFNrMVBXNmNHZmdMaWE2NFJIQ1VoaW4vWTdGaDBCOXVLSW5zYVBWK2JseG42?=
 =?utf-8?B?ZUhqK1lIMDZPQlBQUWJOcnczN00wZ0o4b1NMbGVicWxxT00yVTlsT3dUUEJW?=
 =?utf-8?B?MXErOHA0RmJPL3BrTzZQbTczM0ZIZ0M1QU9BZllteXI4VXVDK3d0VTR0bGZM?=
 =?utf-8?B?Y2dSQUg3TUdwYTFweWptVUEyRk1jNHF4eE5wNzlGYkZsOUJPNzZRVGpmNWxC?=
 =?utf-8?B?TVRSemZnNlhyNFFzMFZuVWRTU3NBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C1B6DBB4C7FCE408B7432F860419546@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf62ca4-2b26-4e76-3d36-08dd66624898
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 21:17:26.7148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQjx7p74telcKBlmUzwPhKhrHP7n9eZyazGNGbUT4fiOzTBRd1peE+GYGSLK79Y+JUpj6jifG5o/4oII8Q/wkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3885

T24gVHVlLCAyMDI1LTAzLTE4IGF0IDE0OjAzIC0wNzAwLCBSaWNrIE1hY2tsZW0gd3JvdGU6DQo+
IA0KPiBUaGUgcHJvYmxlbSBJIHNlZSBpcyB0aGF0IFdSSVRFX1NBTUUgaXNuJ3QgZGVmaW5lZCBp
biBhIHdheSB3aGVyZSB0aGUNCj4gTkZTdjQgc2VydmVyIGNhbiBvbmx5IGltcGxlbWVudCB6ZXJv
J25nIGFuZCBmYWlsIHRoZSByZXN0Lg0KPiBBcyBzdWNoLiBJIGFtIHRoaW5raW5nIHRoYXQgYSBu
ZXcgb3BlcmF0aW9uIGZvciBORlN2NC4yIHRoYXQgZG9lcw0KPiB3cml0aW5nDQo+IG9mIHplcm9z
IG1pZ2h0IGJlIHByZWZlcmFibGUgdG8gdHJ5aW5nIHRvIChtaXMpdXNlIFdST1RFX1NBTUUuDQoN
CldoeSB3b3VsZG4ndCB5b3UganVzdCBpbXBsZW1lbnQgREVBTExPQ0FURT8NCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

