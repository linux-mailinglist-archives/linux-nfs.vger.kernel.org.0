Return-Path: <linux-nfs+bounces-3768-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FF09076B6
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 17:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333E11F22CC4
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1609A12D74D;
	Thu, 13 Jun 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Weske3Sf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2095.outbound.protection.outlook.com [40.107.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88AE5BACF;
	Thu, 13 Jun 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292673; cv=fail; b=QqTQmbLp6mGAnaoHYe3/3/5R8ogabCEH/EJwaV8ys+J5sFTJNClA+sKUPK3lCUH3DFQbruPLaJsm/BIKxtKDzH7nWHPwzsiRYwBRxr3o/NI9sqkz2E/uYc3nXyu48Hh2vmUOBfyox1oNRpmfE5MHyZwRqc/3v533PwX7T+eRScI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292673; c=relaxed/simple;
	bh=2HBbG2f24wwc76H4cQ1hho9uXWAuUebpTch9DfoJRZs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ANJ4STxhFr34GZ4sLV0WDmouQRzo20YgsPwfk2ucX+GTWMu/0JhCIHiPfsXkkL9+CYT+uzG4Vc+G3kS9qv/p9dE04+C2y+J39d+KuOfCVJ/B4hfBX3Vu3Ahd+KVNo38ZhteT1OzXlbLXMzoTrbRmGKHZC5vxrH15CBAhofn3aKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Weske3Sf; arc=fail smtp.client-ip=40.107.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+HBCA+F33ro6keawnjJxIe4yLGkNG6LUjrc+gv8KXSfYwJmsJPUWwZxD6KIMb2b0PkxIvRlARswKsKz4RPOH78kfL76vMa5UMYfwfrJAYP0RPZcwvmKXFhFdJhEPVQh/aGNVkKYmQArp5LPb8ZyrGEuUguKi8jIPt2X1m4+nZcw0LaF9yQFFBS7NvxRYRIXXfsEqxzp35ThkU3bntdJtLm80d92VvlClsPeto7jQyzdHqiizjTHRwc7evGAInKwmwtK2ZrLGXshTbjmTaJ1OLukWSsAYmKvdq4v+5Xjmm5Ds/8Z51/chMc8OFZ3y7FMTALlJN6A5GHzCt8JBuEr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HBbG2f24wwc76H4cQ1hho9uXWAuUebpTch9DfoJRZs=;
 b=fZg888rgmAhZIUC1J5WYn2sC+Oo14QFwKSCfUdAgZR9B7QPWBvfHesmVn9CSVjV9PuYADpacxaE/91+oC2eDdQQSqzwEcnu+v1VmmmMWl79mwC3ppNoatDLQvAm2Zeb9kOhahdNpFHVO9rVDu++xHoTsXU/d/pxrm9BNdlg387lbSgn4/1rLDFCHmDlyAN9BMQMSyX0CdrRAMqUPGkpR6kONLi6YsUzWnq89lQOCmq+Ni0vPgdqV4zSG5yXLezA+GbKGBCyVyADoDguyUR4qy1hFZMSxVFlj2Kmkf3A+VBY7ofedoI4GSMXQqXw40kHbnhTb386LdvRhodepXiXTnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HBbG2f24wwc76H4cQ1hho9uXWAuUebpTch9DfoJRZs=;
 b=Weske3SfkSjxj7XKdDpMyc4nj7yR3FILfctRgiYGJDbJs6kOlg2IWc8/Pv+U084Vp32paq1sAa962e9NW3pIzVB+qiu7Vpp881o1yEkmK8dU+SiX47DQ7yzM7E0WSmWtrPySBBUg2t4iwZAlsVHxdrGrTtXkWUCFMZdJbtyjWTw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO3PR13MB5671.namprd13.prod.outlook.com (2603:10b6:303:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 15:31:09 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 15:31:08 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes for Linux 6.10
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes for Linux 6.10
Thread-Index: AQHavaa24aJlvFhE/U+/Lu0+BLZavg==
Date: Thu, 13 Jun 2024 15:31:08 +0000
Message-ID: <789b8f5da4f8a0406fd977f2e067237c51947b45.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO3PR13MB5671:EE_
x-ms-office365-filtering-correlation-id: 4bbd660d-798f-4d00-6078-08dc8bbdd927
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWVoKzBMeWplcEpCNkdVaC9CVUgvYWs0alFkM2RLUUVCOVNxcTBxOHVDWm9a?=
 =?utf-8?B?VTFYNEtXNVdJS2s3YkJRZ2ZpS2IySVB2bHQ5bHZ1NnIzRXdxOVNNVHkyUGxk?=
 =?utf-8?B?amxBVCtIM05UWDNMQTB6dCs1a1J3RWxQK3B1Wkd5bkxYdkkzem9Hb2dlWk9q?=
 =?utf-8?B?UXRYRXQ0dnBpdmEyOGZEYjJCQk9GOEM0Y29pamdBVmg1S1dXcHZGZWdQeWgz?=
 =?utf-8?B?dTFIQ256bkhtNVczZXBRYzNlc0Fwc1BTczJxNEtxblBLWUpkUUpqRWx5aUNO?=
 =?utf-8?B?SktpaXh6OFZyQ0oyWHAvUnJNZmszZS9sZisxRnBERHAwbnBWcUhrRGh3UU10?=
 =?utf-8?B?c0tmYjg5dFdSM0NwUWRPdkFzS1hrUWU0REFGTTlzdEdxOFhqTXJFSlFreG1C?=
 =?utf-8?B?TW94SUVuWHJwNVh0bzRGeWFOQVFmSkNaWnY2NDRvbEsxa1BDdGMxdlpqRFNE?=
 =?utf-8?B?dk5vSnRTNHdob2dRUDZ6NlRMd1NubUM2NENIdTFPMlovNFQ3TmR3WGtCbzY0?=
 =?utf-8?B?WnlOOVpaaE1rQXdPd0Y3N2V1RjhPcXpMUXdpdVJnY3VOekVvMFFHU2FPZXJr?=
 =?utf-8?B?N2pDQmNEL2RubEwvb1lCMmJLL1FNVnY1V1lZZGh3UHg3Snk0NWVsSUtaVjZ1?=
 =?utf-8?B?eHBPVzdxOWRvc1c3bFU4TGRIazlhMEpReVV2SS9oc3F1RzcramNwanh0TzFC?=
 =?utf-8?B?SVN0dnRjN1FiUGNNZ2ZNQlZLR3dGb2wxNXc2SGJhb2lXZXNnSWRsNlhPelFJ?=
 =?utf-8?B?b0t1dERCZ0VSRFhEWStaYWpkc3dBU1kwd0VRaFBRUzJ4VG92eTc0UVE0bnNR?=
 =?utf-8?B?YXBTMCt3Tk1FK1pnQjFsU09sT2duOU9JcFFCNVNBVWsyLytwMWViSGNZdmRh?=
 =?utf-8?B?cE5kZkN6aXZCNFU0SXZLSDM2WlhCdUZlbFZlVkJnYVZYV1U0VjE5UW1GY2hI?=
 =?utf-8?B?RmlibDRoby9TK2F2VDYrNkVBdldCMEgvcnpNMTlub3Q5ajB1UEdOU3QvRnFy?=
 =?utf-8?B?Q05MSCt2MUFlcysrRXY5UGtLOHNjZ2kvbmV2NDdKdzE5cjdvaGZDTEZ5a1Fr?=
 =?utf-8?B?ZEF5UHlkTW96SVQ3VG5UMDg5ZkhrVG5vbjY1Q0F3cnEyWEp6TFdVeXBvNWdJ?=
 =?utf-8?B?UisveGIwcXR2OUR4QlFhTDJNYndJSDFLQlZvMTBENVNqWlM4ckYzVll2d3J2?=
 =?utf-8?B?bkJCaWJ3RlBWdk5XbDV3VVE4YXdXNHVrRUgycUhoMmY3U2d6ajY3UmswNXhw?=
 =?utf-8?B?aVJ1K1UybG1ZaERBVmdqSlFzam5SV0ZnaVJ2Y2kzMER1NUpzWGZaS2VVYWNY?=
 =?utf-8?B?REVvb3hVanVIbm5sYUZQaVE3Smw0dnpMV0lZMjZTbHRMT3NJZVlHOGl3M1lH?=
 =?utf-8?B?ZXRQcFZaREgvcldGdisrbTJGVjJxRXRSMjNjVlFETHk1ZHhIVDlPWG5MaE1a?=
 =?utf-8?B?engwMlJKcjZWQlRZc3FHNlZ3eGcza0x6bWordU5IMEw1MUZTbGRHMlFMZGNT?=
 =?utf-8?B?NzBUaW9xVjEyb05ud3gwS1BLU2FsMjE1QWdFeEpwbHZMMzNmWlJ0ZmhMNVhw?=
 =?utf-8?B?SzhNNFJMdGtBU2h3K3JvMkJEYTdtNWxBbFNVeGFwRmt5aFR5bVhWQjh1azlH?=
 =?utf-8?B?b05ZVzA4WThsZWZTdGdDTjZVNU5oTjgvL28rc1AvU3BTNWVmcHhVK043NHlQ?=
 =?utf-8?B?SWM5bS9PZ2NNTTZiMXVQUk91amozR2xESHBPQUl6SDdINDIxVFlObWdjellG?=
 =?utf-8?B?aWRGSVdRN241eHJqUmt6MytyaFlsdER4QzhGaDgxQVc1MStjTWpYaEJCUmV6?=
 =?utf-8?Q?UZMx+hn4PCXRFIj6tuGlN3qaEAZ6u52GgqUv8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WStTMUh5ODl1WFM5Q1VFL1lQbzBQUktlVVBEUDlVelo5ZGp4a1c3SlNEZTFV?=
 =?utf-8?B?Um51RUY3V0RzaHhHYlJYK1o0YWlVb1lISE1jVVR3OFVSaGc4b1I3VUN3cU5L?=
 =?utf-8?B?amcwbWVibjhVbklKL01NbW95Y0g2Q1BNVHNYWkptNWIvWXFGS2ZBMjN2ZUc0?=
 =?utf-8?B?RTF5N2R0MU9pY2JkSnNncVhjQWtmUmgxNmtjU2hwYzkvVXBKcjd0bHNpU2Ey?=
 =?utf-8?B?ZVlpcmoveXAwVFJhcGNPcUM3OUZsZGlCM2JSb2xibEF6dmNlT1VrU2NhZUJ4?=
 =?utf-8?B?U2hHTXhIbHpHTVBSeFltanBMOWtTNWxYQXBzTTVZajNFRGgrSW82QzlzMWhs?=
 =?utf-8?B?UUFEYkxNT29sVUQzWmpCZWpnMjBIWG1PMnpLMEREbGl4Umt2MDA0SDJSd1dT?=
 =?utf-8?B?amRqNWlNRk1RUzRaczkxWUNsWHRZbzBGeVFiOW5XbGJqdXhHVld3MEpacGZ2?=
 =?utf-8?B?Ny96cTdweWN2ZXRmWC9LaDBiZUZtQ2FEMjdTSGMrV1BVNXRDcnVYYm8zNG9H?=
 =?utf-8?B?NzBUQ2ZrUmF5UEFiQm84NFRQQ1dYRjd5SVg3eWF1bmtlS1dvU0MvbGYydmxn?=
 =?utf-8?B?Q0xUalVEQjl0QWo3VzJsb05sYi9kQkNHN2dFYzR0RmlPbGx1Q0RDYi9STUJK?=
 =?utf-8?B?QUZnRXJUdjdSQ3U3dS9aYStUbTU2dEZxcmhOakhMN1VuVW1WVWl6RXBRRE05?=
 =?utf-8?B?UmhWbFo5WnBMWEJaRDJWT0p6bXB0azBuUXRFNXBiNUw4YUw0UC91aDVydUN6?=
 =?utf-8?B?N00yU29lZ0ZKWGhIZUtOVlhtZ2ZUckFqUUcvQk1vaWEwV0xoUHZPMGh6dUY3?=
 =?utf-8?B?clZRenFNY0wydjNXZ3JtcjBpcVhESG9LMENpRUc3ZmpKM1ZudFptUXM3K3RJ?=
 =?utf-8?B?RkJBYlFWUStCbFZxTy9RNVJkK1pIU2hWMFByM3B1UTJjRnMremIyamxlUlBt?=
 =?utf-8?B?Q1kzNUphelVOejdsN0Q2VFArMUlpRGRuc0VtTjNvc253NnNlbjJkQ3E0NjZw?=
 =?utf-8?B?ZDFTQVorYUxQUkpKU3pYYVNuek0xSUxlOUJZY2NXL3lNRmRFaUlXRlNic2Fp?=
 =?utf-8?B?cC9TY3Q5cisxaUV2M2JkaS9QcVEvU28zK0xrQkk3NEZ2Y2NwN1hYUTFYZGsy?=
 =?utf-8?B?cERlSWJlTmVkQUdGMEJPNUZoTWIxYldGUGkzaGhPUGNHTHpJVFdSVmNDa05X?=
 =?utf-8?B?dTh0RmZNMk4yYzFSMnB5NlY1ZjZYREF0emFSMy9ZZnNHcjJLenVFbTRhS1R1?=
 =?utf-8?B?UGs2NDlJREx2T29FSjBTcnVXQlBMNXg1RTZqdVRKVXB2cHlhZUVvVDN2VnBt?=
 =?utf-8?B?cnlRTFNTOWpCVVdITUlZR1crVFBCRlJXTEV4UHh0TjA2SnorODlLLzdEWHA4?=
 =?utf-8?B?UkpMdVpVYWxSSm9aTzhaV1NDV0xGS3N3MXNNek9lYytQV2F2WFlkeXV1eEp4?=
 =?utf-8?B?eERjK0NvTmVvNlUyUDU5Q29FQmxTK25LY25ZWENMb0l5NU5zaCt4cmpCQ1Vw?=
 =?utf-8?B?by9CWlRhanVHVHNITk5iQUJ0Uk5xeEVwQ2VyeU1zaGh4eU1xdzJYc1AreHFa?=
 =?utf-8?B?a1JpSU4xdnpLV0NIb2xoUkpGWVVDUWs2YkRhdDE3NHJhYnExQmNFMjd4d2th?=
 =?utf-8?B?TG5RWFFBcWp1ZnhtVklVZG8zbGhWTUNXajNBOW8rOW5pZjQzNUZ0NSs1ODUv?=
 =?utf-8?B?ckthVnpDTitMbUU1Q2Frbi9hWGpXMTA5THRMNHhXR0ppY1VPSVllK213OU10?=
 =?utf-8?B?aFRidUd4WWxVenBYVzdqQ0NnR2d6bUUyb29RZUR5MEk5cUl1UkRwM25RTDNX?=
 =?utf-8?B?WC9oVUZ1N25kY2pFUDQxaXVZK0pMRXFGdWhiZWZiSXFSc2dDMG1Wd0lJZE1s?=
 =?utf-8?B?LzdZVzFVUFErVU9LQ2duRk9ucFFvUTlOMVU1d0g3MTlmTGQrUTNnbk40VXFC?=
 =?utf-8?B?eUs4bmthLy9Gb2VMV3VLa2FkalFKUmFtaXFZd09YUEN4c3prc0dtWXpZZlZz?=
 =?utf-8?B?a3VVSTNwaTMxcmJtbWpLMlp2TnRwSllwTUkzdW40eUxwMFo1ODdXS200b2hr?=
 =?utf-8?B?d24zcVdvUjg4OUFzMURnL0FHUm9DMEkxcHo1NHNPTDRGU0lpWkFBaWNVNk05?=
 =?utf-8?B?N1JPRjF2bXlrNWQzcDlpMW5jQ1czK0NNMUVuWUhKcEpqSVU5cDBoM3E2bUZF?=
 =?utf-8?B?NEFoeTltK0l6T25qaERQclFndVVlRzVGUkRHK1VkdUlaQkZEZXhra3RYL2px?=
 =?utf-8?B?SUdPV3FkNWRKa3hCazJPbDE0Z1RBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <149E7B18D3AE5544A091E6A52501F323@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbd660d-798f-4d00-6078-08dc8bbdd927
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 15:31:08.7608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJuXtfh3VAFOQgr+TOl5nbFsGPJmJ9l2ONThxF4kn1iSAWJgCgWsZecARiHib3A3POxnEuN7aVR4yel6JLLFLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR13MB5671

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgM2MwYTJlMGIw
YWU2NjE0NTdjODUwNWZlY2M3YmU1NTAxYWE3YTcxNToNCg0KICBuZnM6IGZpeCB1bmRlZmluZWQg
YmVoYXZpb3IgaW4gbmZzX2Jsb2NrX2JpdHMoKSAoMjAyNC0wNS0yMSAwODozNDoxNSAtMDQwMCkN
Cg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0
LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMvdHJvbmRteS9saW51eC1uZnMuZ2l0IHRhZ3MvbmZzLWZv
ci02LjEwLTINCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDk5YmM5ZjJlYjNmNzlh
MmI0Mjk2ZDliZjQzMTUzZTFkMTBjYTUwZDM6DQoNCiAgTkZTOiBhZGQgYmFycmllcnMgd2hlbiB0
ZXN0aW5nIGZvciBORlNfRlNEQVRBX0JMT0NLRUQgKDIwMjQtMDUtMzAgMTY6MTc6MTIgLTA0MDAp
DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCk5GUyBjbGllbnQgYnVnZml4ZXMgZm9yIExpbnV4IDYuMTANCg0KQnVnZml4
ZXM6DQogLSBORlN2NC4yOiBGaXggYSBtZW1vcnkgbGVhayBpbiBuZnM0X3NldF9zZWN1cml0eV9s
YWJlbA0KIC0gTkZTdjIvdjM6IGFib3J0IG5mc19hdG9taWNfb3Blbl92MjMgaWYgdGhlIG5hbWUg
aXMgdG9vIGxvbmcuDQogLSBORlM6IEFkZCBhcHByb3ByaWF0ZSBtZW1vcnkgYmFycmllcnMgdG8g
dGhlIHNpbGx5cmVuYW1lIGNvZGUNCiAtIFByb3BhZ2F0ZSByZWFkbGluayBlcnJvcnMgaW4gbmZz
X3N5bWxpbmtfZmlsbGVyDQogLSBORlM6IGRvbid0IGludmFsaWRhdGUgZGVudHJpZXMgb24gdHJh
bnNpZW50IGVycm9ycw0KIC0gTkZTOiBmaXggdW5uZWNlc3Nhcnkgc3luY2hyb25vdXMgd3JpdGVz
IGluIHJhbmRvbSB3cml0ZSB3b3JrbG9hZHMNCiAtIE5GU3Y0LjE6IGVuZm9yY2Ugcm9vdHBhdGgg
Y2hlY2sgd2hlbiBkZWNpZGluZyB3aGV0aGVyIG9yIG5vdCB0byB0cnVuaw0KDQpPdGhlcjoNCiAt
IENoYW5nZSBlbWFpbCBhZGRyZXNzIGZvciBUcm9uZCBNeWtsZWJ1c3QgZHVlIHRvIGVtYWlsIHNl
cnZlciBjb25jZXJucw0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpDaGVuIEhhbnhpYW8gKDEpOg0KICAgICAgU1VOUlBD
OiByZXR1cm4gcHJvcGVyIGVycm9yIGZyb20gZ3NzX3dyYXBfcmVxX3ByaXYNCg0KRG1pdHJ5IE1h
c3R5a2luICgxKToNCiAgICAgIE5GU3Y0OiBGaXggbWVtb3J5IGxlYWsgaW4gbmZzNF9zZXRfc2Vj
dXJpdHlfbGFiZWwNCg0KSmFuIEthcmEgKDEpOg0KICAgICAgbmZzOiBBdm9pZCBmbHVzaGluZyBt
YW55IHBhZ2VzIHdpdGggTkZTX0ZJTEVfU1lOQw0KDQpOZWlsQnJvd24gKDIpOg0KICAgICAgTkZT
OiBhYm9ydCBuZnNfYXRvbWljX29wZW5fdjIzIGlmIG5hbWUgaXMgdG9vIGxvbmcuDQogICAgICBO
RlM6IGFkZCBiYXJyaWVycyB3aGVuIHRlc3RpbmcgZm9yIE5GU19GU0RBVEFfQkxPQ0tFRA0KDQpP
bGdhIEtvcm5pZXZza2FpYSAoMSk6DQogICAgICBORlN2NC4xIGVuZm9yY2Ugcm9vdHBhdGggY2hl
Y2sgaW4gZnNfbG9jYXRpb24gcXVlcnkNCg0KU2FnaSBHcmltYmVyZyAoMSk6DQogICAgICBuZnM6
IHByb3BhZ2F0ZSByZWFkbGluayBlcnJvcnMgaW4gbmZzX3N5bWxpbmtfZmlsbGVyDQoNClNjb3R0
IE1heWhldyAoMSk6DQogICAgICBuZnM6IGRvbid0IGludmFsaWRhdGUgZGVudHJpZXMgb24gdHJh
bnNpZW50IGVycm9ycw0KDQpUcm9uZCBNeWtsZWJ1c3QgKDEpOg0KICAgICAgTUFJTlRBSU5FUlM6
IENoYW5nZSBlbWFpbCBhZGRyZXNzIGZvciBUcm9uZCBNeWtsZWJ1c3QNCg0KIE1BSU5UQUlORVJT
ICAgICAgICAgICAgICAgICAgICB8ICAyICstDQogZnMvbmZzL2Rpci5jICAgICAgICAgICAgICAg
ICAgIHwgNzcgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQogZnMv
bmZzL25mczRwcm9jLmMgICAgICAgICAgICAgIHwgMjQgKysrKysrKysrKysrLQ0KIGZzL25mcy9w
YWdlbGlzdC5jICAgICAgICAgICAgICB8ICA1ICsrKw0KIGZzL25mcy9zeW1saW5rLmMgICAgICAg
ICAgICAgICB8ICAyICstDQogbmV0L3N1bnJwYy9hdXRoX2dzcy9hdXRoX2dzcy5jIHwgIDQgKyst
DQogNiBmaWxlcyBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkNCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

