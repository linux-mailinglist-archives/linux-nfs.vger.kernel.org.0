Return-Path: <linux-nfs+bounces-10669-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2A7A680EE
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 00:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C4CD7A6D13
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 23:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8E720967A;
	Tue, 18 Mar 2025 23:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="aW/xvoX9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2095.outbound.protection.outlook.com [40.107.220.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE4D250F8
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 23:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342062; cv=fail; b=Nqz1roCG+oUFYpb+f2at6Rx8sCQPD2hl1L//YfYQrszcMKc0xOCaRTRcN7s6fa8IDlEhtcwctiZc/6o0B984odXzBbI7oYEjwWetdipiXERu8ep6FZONCU18y1rH8+X2f/deJBw3VqkLEuDLcuD+l4NwpucVpeI+LHYABpbLTuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342062; c=relaxed/simple;
	bh=T6R/yW27QYtjUF5CbKko4Gy0BYALrZYskK4fjAwQ2UA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/KTXlbQVFNGWNsVMTGree8VKBzk/o2s3gzIP2kbsqav+4xry11n8hH2k88nxJ68dmsreh74VHaLJrB31YgH6rCioMWQVp1F9bRs3iBKQMiCLBc1xNAhxRgYv+3BGBgAgB8UbpijFCaXTKfWc4af8xhEg2TTohQXlixV+Dpa0n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=aW/xvoX9; arc=fail smtp.client-ip=40.107.220.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFo3dOVHteMJZrioH8kIjkhHapwhsZCmSFpm5zwVvdKezQyXo8mdj3sm0J6AS71vqbmC+/MmX2ss9QQm3Q91e8sr6LDSG7TTkARyqgXAz6V7B7cVK6iHJQq4i7yrbeO+uceua7wLlShhjSlBYRFpl7KdmRd5rBxqANaC0pOno6Pn+1C3RZdiCGEJV+oGcKtE/P9x+DIRXnA7sk3R+hUIPqBUVtSbs/ahFO4QgZiwLc85GTC4TS+rGi/Ef8dxRFITfGJAYGVxR5iUgYyoFlu3pmgbhubgozHjoroRb8sRdC03ZM87B951hENNmsmImLwo7fUFtEGClPO5GVq3k+rVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6R/yW27QYtjUF5CbKko4Gy0BYALrZYskK4fjAwQ2UA=;
 b=U0Qfd8UCBpVfk8qsvwW2GqBtVS+HQCiudidAvz9SrrfHn9r+biMNf5gBL+/ckT4KB3sDbPCkCeFlNXDYCfasgni1l1bQTQlz8+pRbVy1/7Dkb8/SYdlF4zAlzGNnzEdhMjIfiWUaQtrOZCvPlyR+9HIp6PO6SbIUtql3siY0JZ/U+wwdUkOdkLnMTuSTa3br4qAY2/UX8G8PbC14c+4/d2PTUqOfasNlNNg3CVcVTFXtKrMbRU31glb72HLdTMBYa+nKD7fRpCbJbiz89RBdlxwcKCV8Din6HSxToXCbzmTchgeezBm+GIZdU2jgwWyuiGbfaUkzPxI0nihYil4jOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6R/yW27QYtjUF5CbKko4Gy0BYALrZYskK4fjAwQ2UA=;
 b=aW/xvoX9eOMNvpRwk68qFj0ajKNiMPBkgRl+PVDzyKTJtpoZ5IyXXrHxNIiXvpaS0tcxipqXs1QpQW85bhZg4ujXinC2cdv75jQAIOU4rFL+AnKumYvELksnthdiRBAc1lqUHEce/dQBMuy0f52jLMNOQCcU+Nd2XwsKRM1dvqk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB5183.namprd13.prod.outlook.com (2603:10b6:408:156::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 23:54:16 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 23:54:16 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "rick.macklem@gmail.com" <rick.macklem@gmail.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"takeshi.nishimura.linux@gmail.com" <takeshi.nishimura.linux@gmail.com>,
	"anna.schumaker@oracle.com" <anna.schumaker@oracle.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
Thread-Topic: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
Thread-Index:
 AQHbmBa5xy/j3c2GaUCylZ3htsCWqbN4/18AgAAOAgCAAFTsgIAAA8+AgAAdLoCAAA6kgA==
Date: Tue, 18 Mar 2025 23:54:16 +0000
Message-ID: <e285a3e013e0ca593f21b5aed24f545e6e64312a.camel@hammerspace.com>
References:
 <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
	 <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com>
	 <89535c4a-7080-41cc-a0a3-1f66daa9287a@oracle.com>
	 <CAM5tNy7FdNRC6i62jqyMs=A=03omztTk3YdgS=P3qJVersSFbg@mail.gmail.com>
	 <e674d6ec96cc8598b079efd3b93612537f840a87.camel@hammerspace.com>
	 <CAM5tNy7AGHk+-H2BQpzB0r8LtSy37XdWvpjcNxPmOuG+v5zBtA@mail.gmail.com>
In-Reply-To:
 <CAM5tNy7AGHk+-H2BQpzB0r8LtSy37XdWvpjcNxPmOuG+v5zBtA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB5183:EE_
x-ms-office365-filtering-correlation-id: a17588c2-3fd1-46cb-9141-08dd66783159
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MHViUFdqSWNvcWt5Zlo3b29nWndpT3ZJWE1PQVRNcWR0MVFwV0pCdmtpTVdU?=
 =?utf-8?B?UjlCZUJKaXVTSnBBVUhtQWFUY0JjZUFoTmhXUGdLam82c3NHMHF5Y2JEOE43?=
 =?utf-8?B?aGxqMWpCMDVLenhHQlJCVWx1Y1hwNU13eGpvV1RTUWZTVENnVUFJZWRCekhx?=
 =?utf-8?B?Ynp3L1ZJQWJ4RzF0b2tsamtJdE5SMjZRQ2FZc2JxWHBNQ2RZL0VvbGphWTRL?=
 =?utf-8?B?ZHNWTEh1dzRSdjhVUkVabm5EcjhYay95RGkxd0h5V2piWnJaWWg4bmVwYlI2?=
 =?utf-8?B?VWZqZG1WUUpBazMrdC9GVTNKUTl5RmxhRlQ4MC8wZUgyMHk5MnpTaWhRcEh4?=
 =?utf-8?B?blV3c25MbFdCZVpLZTJ2Zys4K1BaTUxrdEk1ckpLTHNzQjc2ZmRtdERINUF2?=
 =?utf-8?B?T3pSb1c1aitSYzBQSnVyb3plQUJURHQ0L2RGeWpzMjZ3ZnFnKy9NNjFuZnF2?=
 =?utf-8?B?MnVSRkJvL1RQcVJ3WVlmVHJ2QWswMm9CcGdqcThtaFNubFduRmhGVC9OUFVl?=
 =?utf-8?B?TjZ3OGtqTXVzQlRCYTkwTnFlYWIxcHNFWG1MdGMxWGZyM0luYVkwL0c3eWFY?=
 =?utf-8?B?dUQxM1VjZXRwdU9mNlNOSTFKc2JBRlI5eU1DWWdYMGVHRHp2TXRkNHZQb1JO?=
 =?utf-8?B?aUtEOHp5RlhRRzlYN2FPeERTU0NaZEpWQldKMGU1VHpkRk42TVVqOWhEeVVL?=
 =?utf-8?B?UExhbVhEMkNaM3JRa21RVXAyQlRSVDFJNXJuYlF5dUxXS01zVEo1cHFLRzhz?=
 =?utf-8?B?c3dCQ0cvdHZvcHhKYURoR0J6c0cyOUV4TVZZeGlNTFlwb0h5VlpNR2tCaXg0?=
 =?utf-8?B?UE5vKzRXNDdNWXYraS9CUWN0R29ZYnhsS3ZMeGhXZ29Nb1JHU2R2a2xlaXBC?=
 =?utf-8?B?bjVRVnhZWjkybXJPbEVFbFdUTUdzZUZ5OHI0Wi9lUG81V3l3a0lHaUFreFlZ?=
 =?utf-8?B?NlRUVnprTXBFRHNDd3RpWk1NMkoyNjZRUzFKKzl1bm5vU2FBMEd1cUQ3TWhr?=
 =?utf-8?B?a29KWTNQVnMzQ3hOcGljeUx3VUZCSERuS3JPS1V5a0djVW1oZ0RGU25aUW9O?=
 =?utf-8?B?cjh0UWdQRHQ2MXB3SHhzc0o5amluN0V1YjZDUVdSR1JnYW9IOTI0MXVDUTRC?=
 =?utf-8?B?V1NNL1hwd1NsNDI5VnFRRHQyY1E4SWVFdVV0SlFzQlFUTk8xWWE5eFZWUHZp?=
 =?utf-8?B?Kzg2Y0FQWmR3Y3RYSE83ZE45encvN1BBQzBzVmRKTnUyK1RoTm1oRjlnYVBM?=
 =?utf-8?B?SXBlNGpTUlkwbXEzeU5YZDNDck55RnZ6SXNlQms5Z242QlRqc090MlIzbU9D?=
 =?utf-8?B?bjl6bU5iUkRvWmFUaDAwVXJhVGh1MWdranUvdGlWa0ZiZ1c3dVJQdEJ6M0Nj?=
 =?utf-8?B?dVdEaFlybWtaN0JMNnRscGxDVEE3L3Zwc1dWa1RFOUR1YW5tQUVSUUE3bCtU?=
 =?utf-8?B?NXZjQ2NqNXZsaVEwTDZrZ2VwcVNhN2JDZHlsLzNMWFNldTNVVHRwZWVvTWIr?=
 =?utf-8?B?KzI2Y1JDb09melJKMDFLN3FSajNuQ1BLRjFUdC9SaGlYbXp5RHpyWTgwR1h4?=
 =?utf-8?B?RmJOYktrUFdWY2lOWWdMQ2MxbUYwSzljOGwxTUZZNmloTlFLeG5rdCtkZUlr?=
 =?utf-8?B?WW82dEUyV2tpRWVMcnRVNC9JN0xhYmtObVN4aml3U0J2aHZzWDczMEJoYmtx?=
 =?utf-8?B?NGVQc3Z4QW5kS09UWXNrYlRHWllGVnlZbmZhOFBkem91V093Mk9QMGVQUjVH?=
 =?utf-8?B?UUFUUTdQQ2VseCtGSDBSdzA5cFMvemFuT2lxWGlzRWRBWUx4L1hUdFE3K2FD?=
 =?utf-8?B?bXV2dUNOcjd3ODdPc1JNdWNpZ3lmUk5kVHgxcXdCaHJPdjRvdk95MGJ1aDBk?=
 =?utf-8?B?SzloajIyQlBuN2ZiSW5aOGZZUEF4WTNGb3laOXFGd2tjSFc5bmNBQzJFdWEy?=
 =?utf-8?Q?PYVXIwSZV+LAkerDyz1msD32ST2uADog?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWYyUG8wMlRLY3NmRG1RYkVUUTRCUTNyaGFCNWNiVDcyamdHaGtJSXlvR0tC?=
 =?utf-8?B?QVBhaktDMGo5a2RoSUgxN1FXWHhuVi94VlBTRlgyeEtrYkNyVzRhcFVlYkoy?=
 =?utf-8?B?VDdmVTlQUUk3VmZkalRKT1dFaVhINVZyZEtVb3R4SjZvenZFY0VBb0RGU3Bu?=
 =?utf-8?B?alRla2t2WmdJb2Z0YVV1aDlSQUtGYXdiVTdtaEFnc01SWmVHQnFBWkZIM2xE?=
 =?utf-8?B?UHhTdW1nMGpJSW9WWUJJTEZYYkg2RjBzOEJETUo2MUFLTGdySmd4ajh5c1hF?=
 =?utf-8?B?dHljb2N2cWhGWGFrRHltcjZYNzMrWERZOC9uUlo2QXN0Ulp1eUVSQlhsbHNP?=
 =?utf-8?B?eUpGNHRGOHZONE9wV0NoQUZkMk82VFR1bEQ2NkdLaFNSRVRWOTNRajkzMVRh?=
 =?utf-8?B?eU5Wd25EOXExTWVuUEY5bHpudklIZXFrYUF6Tkk3UGRBRi9tcm5PNnpURGxE?=
 =?utf-8?B?S3Q2QUdqVmRuTE5CZ25XSllsV2ZuQkhnM1JaV0M2QUYyMzJWYjZac2Z2cERp?=
 =?utf-8?B?c2FtaTVIZW1laFY3WVNCbHgzNzVEcTNhN3ByU0FHMzJlZ085VFpRcllLYzJB?=
 =?utf-8?B?d2RXQ0E4WVVnNUJYdW1Ob1pyRkxQZTk1STZaOC8wU3A5bW5zNVdaYTIxM3Ix?=
 =?utf-8?B?L1kvWmJPR24vdnJFTEVRbkp3UFhPYWxSUUw0VlhkL09FdE1VSi9sZU1mZG9Y?=
 =?utf-8?B?Q0YvdHhUd05sc2RWM2lVK0llazhBK0lyQW5ORDRoc1BuNmVVS0dxSUYxRGY5?=
 =?utf-8?B?UlNFeUtScUczZm9xeElFMmVhRWluYmdZb01acW1FWXA3VkFkbkxkMFNJRjJv?=
 =?utf-8?B?c09DNm8yZ005WFZ3RnkxRmFueGVlRlRPVng4eVlOSXJsUFlvVUZ6bzVTUkhC?=
 =?utf-8?B?VVhuaERndmNNUkxHb2JOUFVRUWZVUE9PdmhCSVVpM0x3UVZ1aGxSNGRId2hU?=
 =?utf-8?B?SVMyNHlhaDArY0FyRExkQnpMbkhlcnY3dXJVdEloVzdZcVduaFpuTy8xWFpR?=
 =?utf-8?B?Y3FRdGxLVmRvNmF3a28rb1NPZ1BTWVE4Y0NOWjZkZUR6c3RMYVpKcVh1RWZu?=
 =?utf-8?B?NEpDYWdwYkdUdGYwaWlVRHlpU1NLSEJuVkpIOVFLbXJHSUJBOGhCWmxaL05F?=
 =?utf-8?B?ZDNRTUtxZ0t0dHo4eU03eDJ3OUQ1c0VaOHlJSWp6UmJsTXM0T3E3S0VxYmg4?=
 =?utf-8?B?aC9wVTJqVWhkbFF4RVFFUDIzUnowWnBaTlhhZU9idndpeWN3Sy9IQkVibjF5?=
 =?utf-8?B?cWN5WTFYTi92YzRzdlFPdlRiS3lXNlVEQ3hYQnp4NTM0RGpmSm4rRE1ZaUxh?=
 =?utf-8?B?Mi9OU3NnNFJ6L0hwVWVWRC9leXVUQWxtS29PSGRWbThPL0w5eWtELzVrdGtN?=
 =?utf-8?B?bDdjZHFzMFlYdnNud0JTYVB2UklyZWt3U3VFdS94MWtZMkVMZ09xNndwaDNQ?=
 =?utf-8?B?VWNDY213ZXJoUmdlSDB0Wi9MSUZGajAyWmt6cGRqeDVldWx1Y1hPS2V6MjBT?=
 =?utf-8?B?a3hEeGRyYjh3bnRqSXZaVjlZWDU3Z08zTHdCZVNmOThVS1pCanVMNmRUVHkw?=
 =?utf-8?B?MkR1REtsQ1hIOTVWRFFjOTYrZUsva2tDcFM5TXBkQm1IVnlONzlobzlJUWFj?=
 =?utf-8?B?bnlDR2xHTGxsMXRwSkI2dm16NGJRNStndU1DY01FczVDRE9JRGdTMi80NzRU?=
 =?utf-8?B?ckk3ci9pUjZ6ZUZYTTlXOXFYU1FENG1UaHJlNDJPY0wzaU1pbGxIYXB4R1F0?=
 =?utf-8?B?aEpoVkZPdVN5VlUxY2dTOEQ1V1ZBVXJ0RldjY1lVSHRJdkd4dmpDaFUzbDVz?=
 =?utf-8?B?OHZrb2xvOC9hK1pnV2lycjMrZlY4OVhGR3BBanB4cTNBVUQwMFlaZ1RoQlVj?=
 =?utf-8?B?NjBnQXEyUk5nQkd5VFNITEpnZlY4Uy9OUUc1M0puWUdTekpqWC9KT29YaEN2?=
 =?utf-8?B?alJ4ajZHMGpKVUVNZDZORGthc3lQN3hWWDdiOGVJdzVMYnBTLzlFSnY5Tnh1?=
 =?utf-8?B?RDFSV2s4Kys4RlFjQ0wxdmtIbDMzUlI5YVBrM3JiL0Q4M2xCY0haaFRtdlV1?=
 =?utf-8?B?aWk4TldoMi9iYUJUZnVqTkZsNEsxRXFTM0J5dDkraDVOaGxCSHlGUnhLZzBF?=
 =?utf-8?B?MHhZaUpkYUVEakp3YVd2dnEwUGVDTGc2VitrcmRpNWcrRXlDR0RkR3dscXNh?=
 =?utf-8?B?bGpyWkl1UnBnWHRmK0puN1NoVWpWZ2IvUlA1czkzV05KdG9pcjRHdGYxazNw?=
 =?utf-8?B?ZEVRTUxxcjk1SkJTcFpUNGtkbUtRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <946974013DAEF94CB90F5232EFF2C956@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a17588c2-3fd1-46cb-9141-08dd66783159
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 23:54:16.5938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONuJAMkSAXdnn8hHN4S7kmrjT9hKwPHrR6FhuxZLjqFdw3BKyg2g8LwHqmTJuFBcWrTe5z/XGdBAQSwh6F2IjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5183

T24gVHVlLCAyMDI1LTAzLTE4IGF0IDE2OjAxIC0wNzAwLCBSaWNrIE1hY2tsZW0gd3JvdGU6DQo+
IE9uIFR1ZSwgTWFyIDE4LCAyMDI1IGF0IDI6MTfigK9QTSBUcm9uZCBNeWtsZWJ1c3QNCj4gPHRy
b25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUdWUsIDIwMjUtMDMt
MTggYXQgMTQ6MDMgLTA3MDAsIFJpY2sgTWFja2xlbSB3cm90ZToNCj4gPiA+IA0KPiA+ID4gVGhl
IHByb2JsZW0gSSBzZWUgaXMgdGhhdCBXUklURV9TQU1FIGlzbid0IGRlZmluZWQgaW4gYSB3YXkg
d2hlcmUNCj4gPiA+IHRoZQ0KPiA+ID4gTkZTdjQgc2VydmVyIGNhbiBvbmx5IGltcGxlbWVudCB6
ZXJvJ25nIGFuZCBmYWlsIHRoZSByZXN0Lg0KPiA+ID4gQXMgc3VjaC4gSSBhbSB0aGlua2luZyB0
aGF0IGEgbmV3IG9wZXJhdGlvbiBmb3IgTkZTdjQuMiB0aGF0IGRvZXMNCj4gPiA+IHdyaXRpbmcN
Cj4gPiA+IG9mIHplcm9zIG1pZ2h0IGJlIHByZWZlcmFibGUgdG8gdHJ5aW5nIHRvIChtaXMpdXNl
IFdST1RFX1NBTUUuDQo+ID4gDQo+ID4gV2h5IHdvdWxkbid0IHlvdSBqdXN0IGltcGxlbWVudCBE
RUFMTE9DQVRFPw0KPiBOb3QgbXkgYXJlYSBvZiBleHBlcnRpc2UsIGJ1dCBJIGJlbGlldmUgc29t
ZSBsaWtlIHRvIGtub3cgdGhhdA0KPiB6ZXJvcyBoYXZlIG92ZXJ3cml0dGVuIHRoZSBkYXRhIGlu
c3RlYWQgb2YgdGhlIGRhdGEganVzdCBiZWluZw0KPiB1bmFsbG9jYXRlZA0KPiAoYmxvY2tzIHN0
aWxsIHNpdHRpbmcgYXJvdW5kIHdpdGggdGhlIGRhdGEgaW4gaXQpLg0KDQpIb3cgZG8geW91IGd1
YXJhbnRlZSB0aGF0PyBUaGVyZSBjb3VsZCBiZSBmaWxlIG9yIGZpbGVzeXN0ZW0gbGV2ZWwNCnNu
YXBzaG90cywgdGhlcmUgaXMgdGhlIGRyaXZlJ3Mgb3duIEZUTC4uLg0KDQpUaGVyZSBhcmUgZ29v
ZCByZWFzb25zIHdoeSB0aGVyZSBhcmUgY29tcGFuaWVzIHRoYXQgc3BlY2lhbGlzZSBpbg0KcGh5
c2ljYWwgZGVzdHJ1Y3Rpb24gb2Ygc3RvcmFnZSBtZWRpYS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

