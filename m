Return-Path: <linux-nfs+bounces-6968-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EC6995BD7
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 01:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A6ECB2125E
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 23:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10886218588;
	Tue,  8 Oct 2024 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="cu0S4ITl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2095.outbound.protection.outlook.com [40.107.220.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06F192B8F
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 23:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728431143; cv=fail; b=QdGsmPp6b3Mx1dTVjKAV9oNOj5zJKoILD5hsbvTrSadSBb6iZFbQhxakcBxQOpa9htCJjMoVil/7tWwTEy35endZBWtBUcUzzf80j8hettBk0HhACW/DOQM8mVFvkPyS8NqbDMvS6nrVJtSvklnmdK8Tg9ewBDyJpIH5Fki7HBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728431143; c=relaxed/simple;
	bh=3O8Ak6GiHKr22ZyfuEmlx8wSS+PtL0giPLJDCwbXe4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HVpi8y+HZafZoJKMQYDBqu/mh5ynZtF3tuzNcJFNq6A8flt/SShleyT6+Z4y82FVJW49rdH6MF6XkbG/NjE4fOx4c1FTzH6E8BmzLyyBJzfppg9rK2VRrfMs9vz1m3S0htxWkJmhmo88A7Fp42TOPlPKUYWIOhAYzoo9JMFD9xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=cu0S4ITl; arc=fail smtp.client-ip=40.107.220.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGjivJ3NLedtymMLgcXSitd2Z8/fW+eNSNXxraeyady4ZZgYu8MrSFFm7TRVg79t/q1zrQXxSV2yIfrAiCMjBpUA0GlNnYfsDDeN1oEeyXgk3Lon4LUMxDO2tMJKDDCJkJTJIEfAhxfoRN2OOCcOK5LFB4pCosMPmBrnySFxu/3Oh/aldC6vnwLzXIwx7p/XyIWClrEtFJuhYStAGDX8Ja+74iQSi0kfgIvBWj3BRDzK6+uBpf/8HLNFsV9vLyq4iymoXFndeOvsF/Mr3egy75qoHNrLUPCPuSrOH0mX7YgbARe/zfiOoHGlZuiP57RRz7TuIIme4ex8Yka9+paEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O8Ak6GiHKr22ZyfuEmlx8wSS+PtL0giPLJDCwbXe4w=;
 b=obG4fZfrD3+zbiNOtf6FMk6OvMnpqz8mDLGsdOB8k4ZcalE5cWovU5bmwQpEO52QcsrAWF2QDTjlOCGCQH2tl8kaO0GR9Tsb9QJOhE5u1Bpgm97h7iZ7feUvcdDECSg+1AChc7BmspuAA66iX6nuag28naHnZgD4Y72H7s9GbvGYeidAp50i4Eqm6YR4pTmo+jMhwra8lxZRmtFqGJ43t6SZWraTJqvBE/dIUo02ESq2L3MBzUTGGod7+XunV8YPYdC9osztiODTTrWFOBhTkSM9QVWxl556xtWHIDGae2mG7HQsEG+4vfOMwT2AcKAbtqAn9jI3QLkPnj5ZJzFiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O8Ak6GiHKr22ZyfuEmlx8wSS+PtL0giPLJDCwbXe4w=;
 b=cu0S4ITlvOk9i0JKDBjYQ035nWXK8ZPxFQTuPOMkW52wSJHHyS3QvpCpPLUQfMD+RkzXjGLPi3TJgtRSgPKCB/fVJ7NcS7JRVv7JbnPZ0CDpjA7kEa6Tx90+vLxLrTCE6hXFgEpBuXbKIuQkYmUyLlO2dEhimVAG0x3WeC4jlA4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by LV8PR13MB6896.namprd13.prod.outlook.com (2603:10b6:408:269::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 23:45:39 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 23:45:39 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "dai.ngo@oracle.com" <dai.ngo@oracle.com>, "anna.schumaker@oracle.com"
	<anna.schumaker@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] NFS: remove revoked delegation from server's
 delegation list
Thread-Topic: [PATCH v2 1/1] NFS: remove revoked delegation from server's
 delegation list
Thread-Index: AQHbGdWYIryF9pJBZEqZH9avQ97HFbJ9hK6A
Date: Tue, 8 Oct 2024 23:45:38 +0000
Message-ID: <441bbfab2f4f8964c3f60e2009331affbac45592.camel@hammerspace.com>
References: <1728428287-2031-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1728428287-2031-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|LV8PR13MB6896:EE_
x-ms-office365-filtering-correlation-id: a3e74c74-2658-4f7e-48a0-08dce7f35038
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUZJeW42ajFIVlJJME5YOUxaNFRtUDZoQ1NJTG5BUkUyUEpyc0dUZzl6amlF?=
 =?utf-8?B?K1NMbVMweDRXcU44ckdoSW0xQnRTbkF5ZVl2M2s3bkQ2UHZUdUhjYVhMWnZm?=
 =?utf-8?B?Sk9kSzFDTHY1RmhZWlIvZ3QwSldBbER3NjZub3JOaDJDcHFxSldLN1lvU2dz?=
 =?utf-8?B?S3g1STlMd0FLMGJBODEwZ2xEd2VDUlNId25RMXJDcGJ5cVNHbnp4MElEclFs?=
 =?utf-8?B?MGxTUEx4djBBcEZod0JJdHRMbWVRdnVmTC8xNzk4ejBMYnVCTUZVcUl2d2dJ?=
 =?utf-8?B?c2drTjFNeWhaM0M5a3lyY2lzSXYzQUV5d2dQeGZveGdtTUNPMzA0RG5MRHJW?=
 =?utf-8?B?dVUwazEyYkl2amh6b1B5RjExa3FNVExGUGpSUSt4QmNwaisyRmtoN1dZU3FY?=
 =?utf-8?B?djhrTU5LWml4a2Q0SEhOa1Q0UEZLYWNKTjNOL0Y1RUVkanNZZDgwM0lYdkFt?=
 =?utf-8?B?L2pUOFpUQ05BcTlrZ3FHZjNJS2wvOWFKRTY5UXhOS3lkS1lPeDAreHBYcmxo?=
 =?utf-8?B?WVl0QzN0anNnS2k3ZkZCWTIzdXNmM1FVY3E5bmlXYVVBb2JFUUpjWGJtUC9Q?=
 =?utf-8?B?dW91NE0vVVRYNTFFMDR2MFF4enlPVG5VeGdGTUxIdTZMUTRLSVIzTnNmcHFp?=
 =?utf-8?B?OXBzRkgrMHRWRDdJeW95QktQUnFGQ2pkK3J1WllHa3BIVlVHN1Myc01ZdGZ1?=
 =?utf-8?B?ZnpOdXg0ZXUzYVNvZHVvKzl4L2QvbEdKM1NlTE53RnRUcUpncXJuRlU0TmFi?=
 =?utf-8?B?M1YwMXlxcEpnelIzNDB4Q0RnR0FJZElld3pRTC9TaW1VUWgvNFJzVERETmNJ?=
 =?utf-8?B?blljNHd2MjBRYzRVc3Y1bWZURTFlS1E1cUJ4WUM3dVZrWGpIaktURnBaazZm?=
 =?utf-8?B?QzJsQ3pOTGFEOVdTdUhvK3NYS3M0SWpVQzNRbGc5OGk0eDNHZi9SR0lib21D?=
 =?utf-8?B?dDhDZWc2UlFyeGRRYVBJVzF6MUJGdGh2Y0Iya0ZXcFJMRkZDTkdndWRLNEpj?=
 =?utf-8?B?L3JsR2NETVpPRkt6dUVvWkV1OVZWbU9TNWVZdU9tT3JVVDZHQjZISmpoMnF0?=
 =?utf-8?B?QVlDemZVL1A4eisvM3U2VHZWTTRCak5sZC94b041U05jTC9yL3o0WlU3U3V6?=
 =?utf-8?B?MkYxaGZlVTlPcWJ4VmVPODhZc01OK2IwUCsxUjltak05UWZDOWdHSHVhVjhR?=
 =?utf-8?B?VGdXUmZKbllSazBPaUc4T2NJODcxdS91dzZ5N2R5K1ZjclJ4ME9FeVRVenM3?=
 =?utf-8?B?enE5YlBSaUxia2o2em9yWHlhdlZtVG8zMmFKOWxrN1JoeEVEeVJBZlBaRGUv?=
 =?utf-8?B?Uk9rNW9MRmU0NFYwcVp6bFViRTVIbnZMY2lUK1hYZFFUSlBVMHJYMFdQZlR5?=
 =?utf-8?B?TGlMOU9nWitlZUUzSHpwSGRJSFJod1ZkTWJGbjJZWktSWG8vaWUvTS9zV25u?=
 =?utf-8?B?TEYydnhtdXJrc25pV1hNbVBpTE1vd2dTd0wvQTM5OW50ZHVMV09NRE9OOGND?=
 =?utf-8?B?ZjVIN2lBS0dLQ09Iek5BL25IVVhSNGV6Um5CbWRFb1dENHBUTlRLYkRXdGlI?=
 =?utf-8?B?Q0paZmhQUityL2EvamUrWEtqcG0zcWR6eUxsSER3Rm5KdllRRVRGS3l6LzJP?=
 =?utf-8?B?VjlPRWE4L2pOMDFSUUZjMU1DRlFNWGpWYVMwMGd3RlJLa1ZGRXZnWkhtOUlk?=
 =?utf-8?B?OWNJNlMrbEtBVmFxblVkbjF1ZE9yR2NMMkdzaUZMZ1RRUkJZSVRldm91Z2Ir?=
 =?utf-8?B?SHF4UXNCSmJHY2dDQkQ5U1ZjZUs5MmhuVXdmWFB0U04yTXlCWU0zNTRUbStz?=
 =?utf-8?B?N24wUFZITDRzSVZBQkRTZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2Z0ak9xY0JhNWNLUDYyZlZaMzUyNXFudEVtaXZpS0NTWUNFYlBVUUx0QXZt?=
 =?utf-8?B?RklselRQdXgxczAxNzBQTzN2MENvbUpDWG50MkRsSnpadFRHK3RkS0tuZFAw?=
 =?utf-8?B?V09tc0Q3c2ozTHo0OXRPMUE5NkNoaHNpdU1sSlg1cWtvb1F4cGlrQ3ZuNXFR?=
 =?utf-8?B?RlJLUmRKa1hqdjFpcHo5QjVVZnM5WHZVRnRaN2hYc3VXZ1RwYWJPRXc2WElG?=
 =?utf-8?B?NG5aZWpDbS9GVzV0RmZ1dGdOK0RSNS9wdnBLODhKVEI4Nmlyb09CU0FaQXFY?=
 =?utf-8?B?UHM3L0pLQU9FNTlyMXdScTkrU1hOSFF4ZkdnbDRsRWdmYlpoZmVNSnpXQXd3?=
 =?utf-8?B?MUxKS1lzTGRIS1ZHMkp2aFVJNHRKTXE2Ny9zR29mckh4dkhFQTNUbUExYlRE?=
 =?utf-8?B?VDJoRVNQMXhxOWZnZjlkY2tIWS8rTmdFVUNQOVZQa0VGcGhWeU4xclFtWVlu?=
 =?utf-8?B?ZGZUbG9ENEhiVUpNVU40MG5aVS83bHFBMjFhQzhYR2pkMkZUaTlCUkVUMmw5?=
 =?utf-8?B?T2hGNlpMZHFCNEZLTS9wSmFuVUdsdE9MM0VzYnBCNEdkcmpRbFZ6Q2lvTG9K?=
 =?utf-8?B?V2hVRUZ4dUsyb3ZtYk1DMWVXbThZRHFlNkZRUHprdm94MnliTEFjdWJTejll?=
 =?utf-8?B?K1hqeHRUMWsra0lldDhFK3cxS0k0OTRjbnhXZTBQdjgxTlg3aWsxZFByakNF?=
 =?utf-8?B?M0NXSDNsZFI5V25iRkdHbzViVjl5NmM0MS9VeHArUFJmWjhERy9ZNHJKaEkv?=
 =?utf-8?B?QkFhU0ZpZng5Vi9ibHNvTjJpeE90cllGTFZsSHB2dDFTdE5Xc2JhQXorditS?=
 =?utf-8?B?d3REZ2M4SmhOcGNxTmg0SmxNR3JhTDhFeHFZMVl6R3hpWlZzeHpEcEdkTGFG?=
 =?utf-8?B?WEs0RXZmNEY4RVFkL0tiWGdsMElheTcyVFpaZjBWdFpyUy9xZDRvai9tRHE5?=
 =?utf-8?B?Q2hUTWlXZTlTV3llS0JGMzVUNTdnbzBrcTZseGhsays4SWMrL3ZhQmpSUUFv?=
 =?utf-8?B?Ym1DcnRZS3Nha2hETWovdFluUmlEaWU0azdCTjJlK0l4VW5oVmkzSVoxdnNM?=
 =?utf-8?B?c1lZa096R3RCQTRROGxBM2hVM2FnMkptbGk2TmtMRTJXWklvVy9KMHA1Vkdi?=
 =?utf-8?B?ZXNjSFlLRVBFZldGN1ZFb3BhaHRXQmFUWlkwWGE5UDcvS21PMVNzYU1CMVZW?=
 =?utf-8?B?ZXptMlVkdEJ4SDVONmVtT2xiRjY0bDlYeWJuclRKeENLVFkreURzcFpsem13?=
 =?utf-8?B?K3BNY0p0cjZVNmMvSzJncFFVODZZdEVuK0lRQVRsanJGTVZ1bytuc3JROG5Z?=
 =?utf-8?B?N2o1YXU0Uk42SmszYWVrK1V1eHV2aDl2MXpseXNCVlFYbk9yY2VaQkRSaUc0?=
 =?utf-8?B?a1lHYnppRmN1TWljZ1BDTDdrSzZ4Z1BKZ1I5Y0FwNEs3aDVSMG9EbUpVYzJI?=
 =?utf-8?B?Vm10bmJxK1RvTEpsQmhxTStyT3BJWGVHRW1xUnh5VXFxemFDZ0VOMnRDOEtV?=
 =?utf-8?B?Y21yZlJwMzJtZlNSUzlsMUZQMXJwbkdmUW14NFg2bWRGNjhXbGNlVklPUnJG?=
 =?utf-8?B?ekRsVmg2Z09mMzNIR0U1N2prZzVjUGg2UzdQY0JTcy9WTjdhSG9BWG1ZY2k1?=
 =?utf-8?B?MUdTcjVRR1A4WkFscSttSWpkYXRublNMbVJMVDZOaGl6cXYyeDVYcVordldQ?=
 =?utf-8?B?N3BER0QyOFJrQVMxUnkrNm0wQlJybGV5S1FQc1pqRDBlb1JsZGIwVlRBalAv?=
 =?utf-8?B?cUVscitxM1lOeE5pL2luak5HZmIyTmg3VzFucGFjWDhqYW1TRUhPeVZyb1g4?=
 =?utf-8?B?SUJPR21FSUZjcUtPZXBaSVVhREhLUVQ0V2R1MTVIU2pEWUJ0aW11ZGVGUjBj?=
 =?utf-8?B?ZUJURjJWSldVajN3Ymo2REdMTm11bFZjNk95bG9jZnBrMWVnU3dZdEs4dWR4?=
 =?utf-8?B?TmJpYzJaelNXdCtuSVZWTFVJa0R4UEhHWVlXUXhVQlVzaWgzS25SSkp4MXU1?=
 =?utf-8?B?OTcrdFdlSkpld0VSMXhzTUUxb2sxNmhZSFIwd1JxNFRObUE2QW03MkNhTCt0?=
 =?utf-8?B?ZWNMUExCbzZzVE40MEYrS3p6cXFGcVdJMFhodWhXeEdRdzhJa0FENk9QVm9l?=
 =?utf-8?B?RitxV0k4M1VSYmRKUlZCZ2pkd0dnL0hnaldSTzFwRkE2Z3FZYnZRczRJV2Va?=
 =?utf-8?B?ZDNDbVl5QXZEWE5OWGdqR21JcnFTckl3RXlmNTdvQWhhRWcvdk95YnB5Q2tw?=
 =?utf-8?B?QjRIWmFqS3g1aGFydjM2MzBmMnd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <561C6FF34BF5C5419A844E2EEB55C773@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e74c74-2658-4f7e-48a0-08dce7f35038
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 23:45:38.8332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVSSu1g+1jV5lGfArpUURKXb5DpfYSYI36M8nps1j0i4T6u54IqvyFWvXib0JKpvX9nDNa7RL/Gzhl8GgXEsGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6896

T24gVHVlLCAyMDI0LTEwLTA4IGF0IDE1OjU4IC0wNzAwLCBEYWkgTmdvIHdyb3RlOg0KPiBBZnRl
ciB0aGUgZGVsZWdhdGlvbiBpcyByZXR1cm5lZCB0byB0aGUgTkZTIHNlcnZlciByZW1vdmUgaXQN
Cj4gZnJvbSB0aGUgc2VydmVyJ3MgZGVsZWdhdGlvbnMgbGlzdCB0byByZWR1Y2UgdGhlIHRpbWUg
aXQgdGFrZXMNCj4gdG8gc2NhbiB0aGlzIGxpc3QuDQo+IA0KPiBOZXR3b3JrIHRyYWNlIGNhcHR1
cmVkIHdoaWxlIHJ1bm5pbmcgdGhlIGJlbG93IHNjcmlwdCBzaG93cyB0aGUNCj4gdGltZSB0YWtl
biB0byBzZXJ2aWNlIHRoZSBDQl9SRUNBTEwgaW5jcmVhc2VzIGdyYWR1YWxseSBkdWUgdG8NCj4g
dGhlIG92ZXJoZWFkIG9mIHRyYXZlcnNpbmcgdGhlIGRlbGVnYXRpb24gbGlzdCBpbg0KPiBuZnNf
ZGVsZWdhdGlvbl9maW5kX2lub2RlX3NlcnZlci4NCj4gDQo+IFRoZSBORlMgc2VydmVyIGluIHRo
aXMgdGVzdCBpcyBhIFNvbGFyaXMgc2VydmVyIHdoaWNoIGlzc3Vlcw0KPiBDQl9SRUNBTEwgd2hl
biByZWNlaXZpbmcgdGhlIGFsbC16ZXJvIHN0YXRlaWQgaW4gdGhlIFNFVEFUVFIuDQo+IA0KPiBt
b3VudD0vbW50L2RhdGENCj4gZm9yIGkgaW4gJChzZXEgMSAyMCkNCj4gZG8NCj4gwqDCoCBlY2hv
ICRpDQo+IMKgwqAgbWtkaXIgJG1vdW50L3Rlc3R0YXJmaWxlJGkNCj4gwqDCoCB0aW1lwqAgdGFy
IC1DICRtb3VudC90ZXN0dGFyZmlsZSRpIC14ZiA1MDAwX2ZpbGVzLnRhcg0KPiBkb25lDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBEYWkgTmdvIDxkYWkubmdvQG9yYWNsZS5jb20+DQo+IC0tLQ0KPiDC
oGZzL25mcy9kZWxlZ2F0aW9uLmMgfCA1ICsrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9kZWxlZ2F0aW9uLmMgYi9mcy9u
ZnMvZGVsZWdhdGlvbi5jDQo+IGluZGV4IDIwY2IyMDA4ZjllNC4uMDM1YmE1Mjc0MmE1IDEwMDY0
NA0KPiAtLS0gYS9mcy9uZnMvZGVsZWdhdGlvbi5jDQo+ICsrKyBiL2ZzL25mcy9kZWxlZ2F0aW9u
LmMNCj4gQEAgLTEwMDEsNiArMTAwMSwxMSBAQCB2b2lkIG5mc19kZWxlZ2F0aW9uX21hcmtfcmV0
dXJuZWQoc3RydWN0IGlub2RlDQo+ICppbm9kZSwNCj4gwqAJfQ0KPiDCoA0KPiDCoAluZnNfbWFy
a19kZWxlZ2F0aW9uX3Jldm9rZWQoZGVsZWdhdGlvbik7DQo+ICsJY2xlYXJfYml0KE5GU19ERUxF
R0FUSU9OX1JFVFVSTklORywgJmRlbGVnYXRpb24tPmZsYWdzKTsNCj4gKwlzcGluX3VubG9jaygm
ZGVsZWdhdGlvbi0+bG9jayk7DQo+ICsJaWYgKG5mc19kZXRhY2hfZGVsZWdhdGlvbihORlNfSShp
bm9kZSksIGRlbGVnYXRpb24sDQo+IE5GU19TRVJWRVIoaW5vZGUpKSkNCj4gKwkJbmZzX3B1dF9k
ZWxlZ2F0aW9uKGRlbGVnYXRpb24pOw0KPiArCWdvdG8gb3V0X3JjdV91bmxvY2s7DQo+IMKgDQo+
IMKgb3V0X2NsZWFyX3JldHVybmluZzoNCj4gwqAJY2xlYXJfYml0KE5GU19ERUxFR0FUSU9OX1JF
VFVSTklORywgJmRlbGVnYXRpb24tPmZsYWdzKTsNCg0KT0ssIEkgY2FuIGZpeCB1cCBuZnNfcmV2
b2tlX2RlbGVnYXRpb24oKSBsYXRlci4gVGhhbmtzIQ0KDQpSZXZpZXdlZC1ieTogVHJvbmQgTXlr
bGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KDQotLSANClRyb25kIE15
a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

