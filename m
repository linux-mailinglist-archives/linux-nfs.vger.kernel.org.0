Return-Path: <linux-nfs+bounces-18594-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH1yKZQfe2lPBgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18594-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7EAADBFA
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29FDB302D0D7
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 08:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8563837BE8A;
	Thu, 29 Jan 2026 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="A168p6e+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F6D37D11E
	for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676659; cv=fail; b=tKLfNwLZswiUtRuvLa4C5qBkqK2RRWwf+uSnB0PdT8vx297DZWy6CMKbqQyMiOEreNXQc8OGnE/QKrfqj8ZHQ1/DLEBe9mEdDdRqB2VTAbAQEgPcpDNroBnHyJnKMgxaHMh6GZBbeClIyZA24F50IVsGaEWFPOb8zFKGiY5QD+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676659; c=relaxed/simple;
	bh=VRcE7pR7qiSoi549yaieb7xkuOccHx9IepsyZdFH5hc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=N3CdyqnmB/nz36Q9TKMHnuWe5fxKwtKVTgX1Q4M/YpWxiMnVYklWGq8LAwjGrMaN3v1+STUmM9Y4+qx5c0v03IVcfdXaYhh8BcEfi4Xzkf5KH5WkqS142qAmmRpdSmO5dVrDrkUguaeV41lLAxs1bI4OEPZnLhfKallbUdIcfSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=A168p6e+; arc=fail smtp.client-ip=52.101.229.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcpWd5gjdtwzn/k6tWwYuevTwU/97cQ/wKf71lNxWkSZvMEZAFDZsVmVaU5a32+iM7b5frx/zCqnDEae+HDfhoOD1okN1JKtstU7jKhmGiXdNaNBEUiHlFSFi+7Nrxs85FY3IYsOy/53gzGT8Auzt9d0BxEZF96/k2DeN7xCQ+I0RGoWoNG2XmdXOiSbrZ6ZemmqwDcT8ELdns6pEtpHuSeh0LDR4gixNjmFqOFVqOwDAdonuN4EKizXtpJDSlJbyCYvMf+jipjd8oFCUhQLPOv5Jvosnl+V7LLSXCsJxvEilQhxawZ+GtyCk6NuhgMEE5X3WaUqnDZw/wJKQaOdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRcE7pR7qiSoi549yaieb7xkuOccHx9IepsyZdFH5hc=;
 b=BtnJgMFTJ/zzhmltygLdfCmEfuqHOta8a277hH6vOu+4ib1eqnV3G+80UsteJzQ4a2PPpZFbzyLpiA+BsF9vmYyhYyJWZyj9xQ6LVLMcyYc6Si+K4JEExLXm279s1WAlmjHcVJnanIOH8kMvh0xk5dE7RwQ+fDSeRM/Lw9MkaI9fe/W17SjsaocK4mkqsJu+D9pvg97ZTCbMqesSOmM9zKzCOvwX/hlFEEk0jcdLHpEvtbR9zDtrZXaZzm9Ld4lzPaZqKxnA8hnGbl7nWP/9uRsFFQekQKeD4RgfEJXNUp1aKqRtsf1G69HifIgwUtb+sklCaT2OzZyEzl9s60Id7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRcE7pR7qiSoi549yaieb7xkuOccHx9IepsyZdFH5hc=;
 b=A168p6e+lanxt+aRYNjC4Vgn6wM05MJ9m5BtEtcRnPfsObjTbm1hU/pmoOWIn6ZOs6jkTHF6K5mVVynySLPKKE6Biclkhegey/ymDjNsgemyl4U1nTYl6rh0PDsjwALo/XkHT5vES4qTi9PEtcXwFqyk8PgNq0mPITtjZpF/sjj15Cu+RZ/ErQ1tape1jxpodVycjzOz68CGO3WlXvXyU6ca5bkWfVFADeLc6j6ZVv0hRet0tlAhe18+oArXC02RHP5o2oUOqeA4J2ppWuHcEn2PexWY+M99S+P46TMwBAy3myi6OVo8wX+p65U1bEMdrNZzYeNFRFVVkupM9z1Hgg==
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by TYYPR01MB15165.jpnprd01.prod.outlook.com (2603:1096:405:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 08:50:47 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 08:50:45 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: [nfs-utils PATCH 03/10] nfsiostat: fix typos in man page
Thread-Topic: [nfs-utils PATCH 03/10] nfsiostat: fix typos in man page
Thread-Index: AdyQ+mLXY1u/7W3sTguMK570FaU0Hw==
Date: Thu, 29 Jan 2026 08:50:45 +0000
Message-ID:
 <OSZPR01MB77728284358B24417AAA1D26889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=c81134c7-356f-4dec-b2c4-802835777e74;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-01-29T08:34:18Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|TYYPR01MB15165:EE_
x-ms-office365-filtering-correlation-id: d1b052fe-d3f4-4eba-af6a-08de5f137e27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ME03ei9NOHZHelgzUVV4S2lJVHhrK3FrVWhEWjhNYjJBWXlxT091UFZo?=
 =?iso-2022-jp?B?c1A1dUtKemR3Zml3U1QwYmEvRmZ6N3hNM1NZQTJqa1NLTHFUdy9TRmhI?=
 =?iso-2022-jp?B?ektvZzZJZFdWaFVnV1lReEh4NU9sQmlDYjNFRWpnM0RkQU5zdHFBQzlC?=
 =?iso-2022-jp?B?bjRpYlpOdXJDZFNPNE11bFp4WTIxeFFhNkJ1V1VORVo1TVJ6SDduRnpu?=
 =?iso-2022-jp?B?M0xWVU9qNnB1dUNzb1NEQlE1ZHZJZ1d2Ylhlem94RWtsdlNjazlYY01O?=
 =?iso-2022-jp?B?ZjZiRytkOWQzTkV3UE1NTEVlT2R4WVBiZzRvcDlHT1doblU1Vi9xUjlY?=
 =?iso-2022-jp?B?eTRRV2Y2S2RQRndWQml3RlVnUGZabko5L0Fubm5xQnZnWU1JSEdvQkRH?=
 =?iso-2022-jp?B?OXZoMWFZMkpxZFZmRGNDaGFTS1VTYVVML2RKbCtqU2NDWUNlUE93blJC?=
 =?iso-2022-jp?B?QkxaQ1dRZEprdkxNT013UjB2ZmxseS9aUWdGOC9ZRlpWQXJqc0V3cWUy?=
 =?iso-2022-jp?B?SlpTcXllVGhBTUZBNzlvbEQzeHllZlJXTTY3U0d1S09XWHY3OElmV1J3?=
 =?iso-2022-jp?B?SW5EUFlhVldhVUpDQ25rTzBGL0Y2SERRRkd2UzFQOXg4ek13WlBzZkxQ?=
 =?iso-2022-jp?B?UE91RXUwaW5wSGdLYzN1NENNRFBoTVg4U092bGluTUFLQVNud2NPWXh6?=
 =?iso-2022-jp?B?cGhGR1JUSE5sYlVnWWtPajZBMXM3SEc1ZElVeHcwUUdVMXZ0c3NMVFdo?=
 =?iso-2022-jp?B?VC9VTERIaWpGdmdEbk0ybjdOb3BPUzBqUmZncHRPS0J0RC94SzNycFlB?=
 =?iso-2022-jp?B?NjgyeGRiUWRZaDBSV2pYejVCS2h3Y2s3K1k0TGpXYWZVWHhyVWFPaXg4?=
 =?iso-2022-jp?B?OUtsaHF2SnNldWNVS3Q0K29pWUlxeC9NVE9rMVZJK2sreGpYb2tGcmtw?=
 =?iso-2022-jp?B?dVRPVWIyYk5GM3hjSHp2RC9oejMvQjhMQkplckFtc1ZsSVk4ZnpWVCtq?=
 =?iso-2022-jp?B?UEVid2JtRGZqWS9oTitqU28wdG53c3YrTVFvL1hyUzRZWWNEQ2pIQXEw?=
 =?iso-2022-jp?B?bElCT0VUZ1ZvVndac3NYVXZFNUZhVWMybzZtRlhObUJLMWhERXAvYTFE?=
 =?iso-2022-jp?B?VzFFK0ErdUN3a1dHNEJVekIzMVByZ1VvZGtpWVBwV0UxcE9zcUFWbHZY?=
 =?iso-2022-jp?B?TlV4c09nRlYxWFBqNUlHOThnL3J6UHlzSURUR3VkVkI2SHdFRE1MaEU4?=
 =?iso-2022-jp?B?c2FjVUZRNnlVMVNtMUlmMnVBekE4ZDgwQ1d4eUdQanE2UHRsMlB3RWFT?=
 =?iso-2022-jp?B?bkNrMEFQUndIS29TbUYyY3JTYUNKNmNlcHY5SWtPRzlOV1BlQXlsQXZS?=
 =?iso-2022-jp?B?aVY5aXRMTE9obGp5aW15bEplWk1jMVViN2hrVE9WVHozVXYrZnI3Q29M?=
 =?iso-2022-jp?B?MGZoQVlOQVdiMXpLdFEzdFNQODhRdnZQTVd4c3lXK0xSYnNmTHgzMWUv?=
 =?iso-2022-jp?B?bGdCaFpka29PN3dmM1paNHdvL1dFWk44Q01qMkNla0xMWlF4eTUwYzln?=
 =?iso-2022-jp?B?V3lNandGcW0wNWduM3RDNWJhZ3JCOGVBMzhweGJkZngwTG5wTDFTdGJw?=
 =?iso-2022-jp?B?YTlCajhtcW5yWGJmd285dnFQdWQ2TGRNSE83eU9XeDJoKzZnQ29GNE52?=
 =?iso-2022-jp?B?c0t5WG9Oa1I3cGpJcXhPRGlSOEdqekJNSWIrd01kREZpMVcvTGRjdS93?=
 =?iso-2022-jp?B?aFhaMGVhWi9KRE0razVTRG5iNUJhNXljaE8xLzVYRDN4VXp0Yk1OWElw?=
 =?iso-2022-jp?B?RG5VaU5yYzFYZ1I1OFBva1FJL2x3MkNyN0FDR2lpQ1ByblFLSk13UHRt?=
 =?iso-2022-jp?B?cVdIL203bmJHbWJibHVlS04yekNNUk1QRVUzaVRENjE1SHZiNE9BTThL?=
 =?iso-2022-jp?B?U3FQZzZUaEdwemZnSjdwMTdGVVpoVmlDaUdER0Q1Z0NWeTBNSXpaaDh2?=
 =?iso-2022-jp?B?NjMySGdPUm04T0o4ZjdROUdFWVp1QUF6allNSGFlaC9DbUVjU09xY25y?=
 =?iso-2022-jp?B?Lyt5U3d4S3JkN2N4QUt3blJPNlN2Vm5mOWtPK080dTcrOWZJN0pWWFV1?=
 =?iso-2022-jp?B?UXVwTmdlTUZwTkhJMFRaTTB5RlVlcmdFR3grMnVOU1JjSGNjRjhCRFZr?=
 =?iso-2022-jp?B?ZWJDa2hCMHN0WXM0MkFaQkVobVRJZVBPWFhzTUFyc0xNRG5SajI4YWhI?=
 =?iso-2022-jp?B?UHVRZ0RLQUdjWDF3Tldwa2E5em1qYWR1RXBNQ0s0dkFFTFQ3VVZDU1cr?=
 =?iso-2022-jp?B?eTc1dTNLczBLMWJtYVlWSHMwTzN0ZHZBRnlxRmpCRjJheGh3UGZnSE1t?=
 =?iso-2022-jp?B?Qy9ua25JbURUcHZsWVNEMk0vdTJhQ3BPS1U=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?a0JrOC9jaWhidnNYVHptRzJJQWJXYUdKV3BLWVZXK090VmR4T3hlNnR5?=
 =?iso-2022-jp?B?TUVBWVFZZXVNcStmWlVhN3BPUkhyM2ZKamNIV0NGRjViNTRDRER5UXVh?=
 =?iso-2022-jp?B?dW40TFU4MFpoUTl4TEsraElOc0ttUW9pMkVtL0JqSGNZOEJ5SVNQV3ov?=
 =?iso-2022-jp?B?V2FqTmMxOUptQjVmVU8wQXp2NzRrUTB4eFlXUG5LaUJ3bUJRNVErZjA0?=
 =?iso-2022-jp?B?RnB3TmtPZUkwMlB0SXZHSjh5dzFHdy8rTTFZWVdHQ3NCMythbmxuR3V6?=
 =?iso-2022-jp?B?RnRjTklXZVVBUHV5N2E2eStOUnY4eHBzRE9DaVhadzFwMXJXcWVSakRS?=
 =?iso-2022-jp?B?bEtqLy9EOTc2MmZhT2VtblRJSXVpNURtZkFySVM0M3F5NDg3WlFWOTdM?=
 =?iso-2022-jp?B?Ylp3Ulc4cVlTYndLQjJVZnRDUjl0bVIyUFhzU3p4U2lmZkpaT2lTUUNT?=
 =?iso-2022-jp?B?MzRwYjZMOUFZTG5uMVpjSDNPQmcwVlR5bjhDT2xQRkRkV2hsN2RaaC9l?=
 =?iso-2022-jp?B?elJ4ZEM4ZUhEdVR0aWdoNnI3YlNmM2V5cEF1eU9uYWNDdkk4dXFvZUd4?=
 =?iso-2022-jp?B?NXNRc05SNzdrMUx4b2pEb1VYOTJsR0hJSnlXUU5TNE9EN0Z2ZGM0b2N2?=
 =?iso-2022-jp?B?T1Z0K1VKWDlrVk84OHIzVVdRWXhpS0pPcHBXQlloNkhyZ21ISG5vaE1y?=
 =?iso-2022-jp?B?VE8weUJraVVqSkVTeHdhNVUyYnlqa09KcHdhZ09TNGxZRk1CV1F3bloz?=
 =?iso-2022-jp?B?MmxVb1Nua0pYejc5akNIOGtqK2Z5cktMQ1lrWkVML2ZvZms4aGlMclNa?=
 =?iso-2022-jp?B?TmJLYkwreDgydHNxanNqTk9pSmRKeDFiYjhIM0RmTkQwQlVVQi9hZG4x?=
 =?iso-2022-jp?B?bm4rWHZiUGZJQ201RUNsSGx3YmRCSTFDOUQxN1NJb2VINDBJSHRjeEhG?=
 =?iso-2022-jp?B?cmVQWkY5V0pVKzR6d200SjBUbk5pelpkd0RncGQ2eVZrUDF5SUl2UFBv?=
 =?iso-2022-jp?B?b0g2T0tIWjROcldOb091d3BUd3d5Y0VIN3prb2M0UGZibUlQbmJUR1lk?=
 =?iso-2022-jp?B?SXV0NGZNamczTVBrZHVNT04xZ3gwejFJOHByRkUrYVBoTXNSNzczdWx6?=
 =?iso-2022-jp?B?SHp3OVFsQ3Jpaldoeng3Y1VtWVEwUng5WFJpVlIzKy9nYlllZkk4eG1E?=
 =?iso-2022-jp?B?VWV2U09JVjJkaTY5b1ArN3RlRk9WU1p6OFhxczE2TkJLcHBaaE42S1Nl?=
 =?iso-2022-jp?B?WElqWEM5aVEzSmZSd3JTcUVvUG1JbEg1M0tON0pnd2FtZHVOa2pWU1Zh?=
 =?iso-2022-jp?B?YkdpMmRwVGpYT3lMVFg2TlZkMjJUY2g5em1BcUNIbytkMHRBSk8yM1hR?=
 =?iso-2022-jp?B?RFJxd2VJOURTOGF3eWRQVDlIdlZ2SmtCcjdsWFU3ZXVjL2Y0Sk8rRHVB?=
 =?iso-2022-jp?B?SnNIclh3R1FnOXUvSS9Mbis2Wmczb2VaaUJxYVcvWS9IY1NBNVFCWGNH?=
 =?iso-2022-jp?B?aHUrck1scGlZQ2NiN0ZsaFNmT29CcUhGS09OUnM0Y04vZlZnYkd0d1Ev?=
 =?iso-2022-jp?B?cndBMlI2TXZNQlFsYWJ4cFpnVUQ5UGluK0dLRTEzd0J6NEJiWHY4RGQ3?=
 =?iso-2022-jp?B?cThwc1IwS3lQZFFHT0tIdXl0YW44c0QyUFBJRzd5bWdjYnlBNmxvaTFP?=
 =?iso-2022-jp?B?ZVl5VUJJQmRXdi9aM3hIRXB6MWswTUdJMFdnclp6TE9pd0tQVm4wWitR?=
 =?iso-2022-jp?B?Nlo4QVUzNlZpS2RXT0NmbXRMZ25PWVlDWGlPbnZVL0x1S3lzaFgwWi9x?=
 =?iso-2022-jp?B?M29ZZG9XMnhoQXZMU1Fma1RmNU1QUFJFeHVzeXpRWHk4dVpqTnVET2ZG?=
 =?iso-2022-jp?B?QTZMM0lrNTd2K0dGT1BycFc2cElUUTNNVldrajFJQWdGUEF5d3AwV2FG?=
 =?iso-2022-jp?B?bG1WWHVJS1E3VFppU3JDOUZZc01MMnA0dGNPc0tMYWFpMnVHNThyVDJ6?=
 =?iso-2022-jp?B?S3d3Z3RXWG80SzA5aXF4Y0gvTVB3amJTcm5ndHk3dzRpQVhJVVUyNVda?=
 =?iso-2022-jp?B?RDZNSXc0MFkzTncrbDNrR1o1enhpR1VZaTB2ekY5VHRVT2dFRENCTkxR?=
 =?iso-2022-jp?B?b0JTeVZwVmNGWCt5RHdoSXYrbUlkVVM2dFYyT0gycEZSUUF6RWNiS2dz?=
 =?iso-2022-jp?B?OVR5NjdtMnVHcE9obm1XYVFHYS9oTlQ0OUdjZElaUFY5Zkc3QkxIMUJF?=
 =?iso-2022-jp?B?U25weVJjdW13QmU5YWFXZFRhQWN4bWVEamRzRnJjTmx4ODB6Zk1lQ1VM?=
 =?iso-2022-jp?B?MUtPaFpHeGVBS1BvS21DaW9UTUlTUXd5WlVWWCtTdWVGNmI3cURLUU8x?=
 =?iso-2022-jp?B?M0ltRWlxTmFxTlFoMXIxcE5oM0lPOHM5ZVhHMnRyLzVIV1hqMGhkSkEz?=
 =?iso-2022-jp?B?WE5KVzkrRHNlbWs4bFR1ZU1aczRGTEN5WEtWUFV2VnAvY2Q4UlNtTm8v?=
 =?iso-2022-jp?B?aUlVYUhkU2VsMDI5K0drTEJoQ2w3NE8wenZQZz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7772.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b052fe-d3f4-4eba-af6a-08de5f137e27
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 08:50:45.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oM3YhpbakHI04882O1HQFeW8lBzrIoy+inA/BEt/3Ka3MGuW/+NBvZxd6Jrpw90l421KF3v9a5TPFNMIMAco6x3z713+HK4UzYtSuKHWQAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15165
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18594-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.ikarashi@fujitsu.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[OSZPR01MB7772.jpnprd01.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fujitsu.com:email,fujitsu.com:dkim]
X-Rspamd-Queue-Id: 5D7EAADBFA
X-Rspamd-Action: no action

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
---
 tools/nfs-iostat/nfsiostat.man | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/nfs-iostat/nfsiostat.man b/tools/nfs-iostat/nfsiostat.ma=
n
index 940c0431..104c7ab4 100644
--- a/tools/nfs-iostat/nfsiostat.man
+++ b/tools/nfs-iostat/nfsiostat.man
@@ -9,7 +9,7 @@ nfsiostat \- Emulate iostat for NFS mount points using /pro=
c/self/mountstats
 .SH DESCRIPTION
 The
 .B nfsiostat
-command displays NFS client per-mount statisitics.=20
+command displays NFS client per-mount statistics.=20
 .TP=20
 <interval>
 specifies the amount of time in seconds between each report.
@@ -106,7 +106,7 @@ This is the number of operations that completed with an=
 error status (status < 0
 .RE
 .RE
 .TP
-Note that if an interval is used as argument to \fBnfsiostat\fR, then the =
diffrence from previous interval will be displayed, otherwise the results w=
ill be from the time that the share was mounted.
+Note that if an interval is used as argument to \fBnfsiostat\fR, then the =
difference from previous interval will be displayed, otherwise the results =
will be from the time that the share was mounted.
=20
 .SH OPTIONS
 .TP
--=20
2.47.3


