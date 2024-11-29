Return-Path: <linux-nfs+bounces-8267-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6DD9DEC63
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Nov 2024 20:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD74280F51
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Nov 2024 19:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F346C1A0BFF;
	Fri, 29 Nov 2024 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="MU6xYKP/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2129.outbound.protection.outlook.com [40.107.93.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED941E489;
	Fri, 29 Nov 2024 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908482; cv=fail; b=NXFo2mJbgigFnAUVOtYaPqm6g5p24KWzapaRpo3Dglpb4OlsNJV97UApHrvWVNVPp7VQiPQuEEGOyEtOVabkpVtyHssCqlkXyAfl3J3q5LdQfBLsq8Pku1DqvzKski7kd9oRqkiHxRfnWvKsch1kfaCFvEPRg1Ida/DVHtX4Fyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908482; c=relaxed/simple;
	bh=Ic4TIAWhvhXPfGWDQYUpyZ/I+uHPj/JQplf07mCkFv8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eVZWo+2ajub1afMTHK7Qbj0rWUNGI5TRynozGvowm4OkP3LMYzSPg21cdx25sj7ydhLo+ptbNq6IyolrDBqMcEi6t8/esdMoAQm0/zP3Ij8FxmDaCydQN9g9cJJuqOHARR21LZPyWC3Xpe364kC5dKcsWzECRr7OoMLxBfdIxHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=MU6xYKP/; arc=fail smtp.client-ip=40.107.93.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXe9PEQsqcny0rs86p/nf0mQg9AC6bqUeI5IM5yT2JF8DkVKv8rK66gPHuxk9U02vp7LatsQnZ+r0CCGdVs1xtuGerCYmWKymMpA05bTc/6ZCjQfQlNb25ql1J3oWFWwbxXY5xd8LSQ9T88RYv73iUMhXCXOvy698x2wYvkx7r0YYKzXfk4pe5/MklgEH4CVKRc65RBisLrUgt5yW2hnpCg54xk/HLJ3G5Hw4pZS1FpbYWjiB7eNch3IqEZ1J53D7FzOvCYvHl40/bSYzRzBEltSb0nuPX/9/mWUYzTPxvD5JNMS+qo5HMJGvZJF5mg2zze68d9gbTlcDampDa+I1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ic4TIAWhvhXPfGWDQYUpyZ/I+uHPj/JQplf07mCkFv8=;
 b=EMrcDgokR/pRc1iO7ztT2ZR4vOMo9mUsmfyk6IeZeWABkKbM++m4qR1eZJ1KFAsc7EB6eFNPrehmeDjpBH8Y1fEvwU530YbGue2ZV0rEf5tI6mNu+6yeRZGMUgZDa4kXB2U1sU+KpRLDSOCYDkJPAougnEcQWx+zMsqBZAPSGr/9omM06eCi0ATA6HLSHb1JpIkccXc6YsPbFa98hqCc3G4TuQ6sHHBvZADv0nF0AQhR0/4IqXCaPXXDsLZgNEKRuSxFKfE6jliU3+742n1O8BzNqrES3hgZWFtqA1WaGZKBl6yDMc1jhTLpbDJx1ttI28H+gnYjHTk0KTb2VkP3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ic4TIAWhvhXPfGWDQYUpyZ/I+uHPj/JQplf07mCkFv8=;
 b=MU6xYKP//lKVSvEOw5T+/+LTcIGecbCfvlAxTHcf7liEAcgbByNL/dMD2PEr3zTQUo4YD4nAVUofnXvTySI1PFUoGKaTkuqLcprAN8hmCR7cIrQpBFky18wDF4IU6gXyiM+gfxFQzHMThATB90V40iu7I4Da6FXrSyYAAy1xZOc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB5024.namprd13.prod.outlook.com (2603:10b6:806:187::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 19:27:57 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 19:27:56 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL v2] Please pull NFS client changes for 6.13
Thread-Topic: [GIT PULL v2] Please pull NFS client changes for 6.13
Thread-Index: AQHbQpTKHSIr+ATC1E+ruH/tEbbJ6A==
Date: Fri, 29 Nov 2024 19:27:56 +0000
Message-ID: <173b7b2ce8ca6ab9cf692ea5e2ae7efea6ee9b31.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB5024:EE_
x-ms-office365-filtering-correlation-id: 9a26a2a6-b669-4741-35b9-08dd10abed63
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3p6QURROGphUGt1bXk1YjVtdEJVT1lmdzFRejlJcHZyLzROTUk0SFd6cEpO?=
 =?utf-8?B?a0FQVGt0SnhjMEdpa3VKNyszMHMybElCSlJYOFVFYUFXeW52QmhQUU92Umx3?=
 =?utf-8?B?cm45eG45WU5sTXZOOXlwbTdCWEQwdVFma1B4NlljNFlxckM1ajIvSDR6c2p0?=
 =?utf-8?B?ZW01N0JaVzhwMU0yYnNQbTFVTkJOZjh6QUd5UGZ5Z2NtTzI0L2VYaXZRSTFM?=
 =?utf-8?B?Mm9DaTliWkhxTmN1OGt5VEtqb2hIRk5iLzN4OXhjdlFYczFOdzhDWkJsUEt6?=
 =?utf-8?B?ZFIxVEJXUjBDdXZCNUMxbWRhbEpmT3RGU0h6ZDJCRmtGRHpMSFdEVDFFeWZ6?=
 =?utf-8?B?dVBlRzBmNnpmbU9OMFhpNC9iUUlLR0pWYVpKY0lzRUJTeWF6V2IxRGF5eXFw?=
 =?utf-8?B?c1lPM3BwLzZydzB1d3hpZi9teldvN1ZyT3k3a0NmWitIK2ZqUnhvK29qVW8w?=
 =?utf-8?B?TmRBdGVjbVdpYnRpOG8vOVFVT0FGeUIxYmxxeXFEdTBXbEQ4TUFOOXBObkVI?=
 =?utf-8?B?OWVYc3Y0eENQeG03WWg4dmlJbURrK1ZRcW1WcUg1TGx1MVI5MDByUmlJbW93?=
 =?utf-8?B?TlY0SXlVWXh4UjlYVEFhME8wTWVMUTh2U1RncGNDWFAvSnU3OGtPLzdIdnBz?=
 =?utf-8?B?NCtLYzR5MVdGWUVOMkRoczNNc1RoYUhqdnBxZzluT0J2anpwVkFmSDFac3Rh?=
 =?utf-8?B?cCt2Y1IzaHBOM2VFSlBBRmJISHc1bWhpdXV0b0pOOE9BYUFjQjR3MmJYaEZJ?=
 =?utf-8?B?bkxzRlBQNjNDQzFYN1lQbGY1QzdCNkkzQ21jSEZwQ0FhVk5VUWhwS0N2aXZx?=
 =?utf-8?B?UTdDK2NZOGhVamRVK29aQVhTSXAvK2tkbldwdDNpalVicWNCRldDYWlja0NP?=
 =?utf-8?B?SVYxSzFmcS9UbHdBd3ArWm5KM0thQW5WLys3bGFDV0hpa1ZKVXdORDNvaHN3?=
 =?utf-8?B?bFNuanZzYWc5SGFRRG5lSWhlcXpwcmExeWFMOEtyN3AyQVBEOE1waG1jWW9N?=
 =?utf-8?B?MTdDcTd4QXAxZ1FvK1pObE0zUXBuTC9CQXEwUlkyK3VFTEdmTkx4OWFOQktq?=
 =?utf-8?B?bktyOUY1a1VZYlQrekVmRHZRWkFSN0dXZ1QvejN3cHFYdzNQRm1IQVlMcFpz?=
 =?utf-8?B?a1Z1TUhJSEpNVmNtUXFLMzNEaWJvM0Z6NVZwMHo4ckk5VEs0L095TDJBNy9H?=
 =?utf-8?B?T3ZxdGk2V1ZDOUdoOW9neGNpZngrazFJdkoyN0ZYaVBteUlPY1JtVm5vaWhI?=
 =?utf-8?B?c0loVXpoU2VrRVg4ZGtUY2lxNURRMkVjeW1FR010SEk0WE1ZbUhGVDRBem5q?=
 =?utf-8?B?RithTzJSNHNIK1JHQWovY01hVDdNL2crTCtLWnBoaE9DR2ZuUGF6Vk0wTktK?=
 =?utf-8?B?YitWMTBVdkpkelJ6blRmQ3VLc2lHTUJONjRoUjhWV1JwbFoxSVZ6ZkQ5QlFn?=
 =?utf-8?B?VU02d0RaNkhaRU14WU1Ec2ZzS05lVnNHb1FhOXE4a3NFb1RwUkhRazhZeFll?=
 =?utf-8?B?MEROVzkwK29yb1ZzcjU0TVhpT1FlcGJnZkEwcW9wb3BGSlZya1E0b1pGcGFp?=
 =?utf-8?B?QXB2OTFaTTUyOFBaZlpKTUQxZkFsMEhNZERyZzNvT09ZeUFnMWtqVm5Nb3Uv?=
 =?utf-8?B?V0RzOFhDUi8rWlFWMmtxdXRRSXcvNEpvZ3VjTXVZTDgrdGRxNjgyUmo5QVd2?=
 =?utf-8?B?M0o0dkFPNnVlakw0L2dwR2JzbjlRQ2N6SXR0bWd1V3ZUT05weUc0R3ZCd1ZC?=
 =?utf-8?B?N2VZYmhTc09ib0dLd2ZDcnlmVFI2VURBekVIVDNXM3phNU5FMHFrY1ZxajdN?=
 =?utf-8?B?QlZUUzBLbi9xbVQrem1sYUpkT0dWbStpdW5lSDkwZEZvWEJCRlVsbGFVK21E?=
 =?utf-8?B?dVZoYzVEdGF4RGJDZFNnR0VwNm50ZXY5dkRrb1RvWWNmYlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXRGS0hEWXQ2cHA1M3FEZ2dJM0JwVFV3YnVBVEJQRGcxWkxWb1I4YmN3N1dt?=
 =?utf-8?B?Z09vMlBhY0VzcjdyT3QzYU81Nk9McW1WZ1QwOXVVc1o0QTc1Y1FsM1AwZG9h?=
 =?utf-8?B?N0MvanRLSlBnbUhLQkRoZm53bWtCNW1jMkN3alZNUGVTR3JCM1dueFVwM0pX?=
 =?utf-8?B?STBzL1lhL3F6V3JKNWhPQkI1QTIxdHhrWi9OaXdSZE5RdmkwTUFHMU40dnV5?=
 =?utf-8?B?YVFiL3RFcWswdG1icGR2UFJQbFBBa1FnWU5CdGk4cHlIN1N0T2RQczJqUW9Z?=
 =?utf-8?B?ZXh2ZUlpWWtobDJqdndOMHpYZzFQRlFhREhSNFB4ZktOYy8zY0x5UHVVaEdF?=
 =?utf-8?B?M3VIVFBrWUt6SVlhVFlIRERrMENZQ3JwNzJpRm9LM2NoK3Q5UDNYd1B4MDVi?=
 =?utf-8?B?Ri9YSitDNnBzQUR0Tkp0RzdNU3BOZW9GMFRWL1hCbU04ZzkzS0w4NUt3bmVG?=
 =?utf-8?B?Ui9zcm1XRlY5Y3ZyRC9PeGpKVitWVmFCWmR2QjlaanpsUUxjTW5kQkdiVEs2?=
 =?utf-8?B?VnlsYVVKdkc1RXd1K0tlemFpeXVmSFdFNGcwMGNvamlwSGNuSWlRT3IwN0JW?=
 =?utf-8?B?MWZsOXVZQ01VMjdYeklnTFlsbCtQQ1BiOGpHdnhzeGdCeElBS3ExUi9UcVo3?=
 =?utf-8?B?SXNjMzJyNUczRmk3a2toNmtmLzFXVzdvTndoSU5YY1dYdnhBYis2RXpnQ0R3?=
 =?utf-8?B?TGN6REo3WFhGU2g1alJtQ1dWK285QTN2M1kwZDNZR1liZFNRaHNwczF5Tmxo?=
 =?utf-8?B?WHBsTHI3eUF6L21zVmgrSkJEMkxVbGFQM2trOUxUd0hpU2hBYlBOUlhUbEti?=
 =?utf-8?B?NDgydFNMNEhXVHMzRGhPTldLZXJVRGRSa3MxTmowSCtrQ0F6UnJ3amlNaEl0?=
 =?utf-8?B?KzZuTEhxOXI5K3N4R3l5SVBMWng4NkM5NitZZXhEa2J2RkM4SmZuUlhNamJX?=
 =?utf-8?B?TXgxUm8ybVZJOE1lNm5NWUZaVnJ3NUowcndZNTcwU2NzM0Z2QTNzUWx2RldY?=
 =?utf-8?B?S2V2OGZLUkRYYUR5QWlGa0ZWR1cwZmU3b281R2ZzT3NRQ2NEd0tRaTh5UGVM?=
 =?utf-8?B?MWppOGt0dG5GZG96S2xtUzBJWlIwQ0FJSmZwVTVKZ084aWRLT3hibmxPKzJo?=
 =?utf-8?B?ZUJCMU1LcHp6TFovNEFWZUlUYkREZmlPRkxOUUlQNWlkQUY1bS96c1NuSGNQ?=
 =?utf-8?B?djdhVnBPM3UzdlJ1UFQxWVllK0dBRi9PbS81aTY0VFk4SFFUc3NZT3lJN3pT?=
 =?utf-8?B?emNaZi9XTnVIaDBhd01abUtXUWc1MHdSM0orWFRoRlVCME1XU01TMDhiOWc5?=
 =?utf-8?B?cXE3aTRlUFZBSTcxaEkxejdsMW9YSDBlV0FIdTlkNDZNT2lBeXZTZG8zRnBB?=
 =?utf-8?B?SXd0YUdmaDNhL0ZnMVVDZ05JSzJhVElZMkFEcEVpS2U4NmJzcElPZ01vNnNC?=
 =?utf-8?B?VnRjT05VSkdsWEo2M2xlUCtUUXFtV3VaRi93VWlzc1h2UWNpYVg4NUt1a3M5?=
 =?utf-8?B?Tlp5YWE4TmlqMTB5QjR4WWhhSE9yWnNrTS9UOVVqL21xOXpoSnlpLzBwWlFB?=
 =?utf-8?B?bi9IdG9PNnIwdXpXRmtPSHJOVmszNUs5Mnk4ZURobkg5bWZtV3lEaHk0Skl4?=
 =?utf-8?B?S0hFYzdBSUlsWDVLK3U1ZUhMTU8yQWpEVUxieG1QdVhub0NkNEpKd25NaUUx?=
 =?utf-8?B?eDRFeFhKdEdiRVRhSjh1ZWxYcnNJYmlNa2ZrUloyZzJlNEFyS2N6ZzhIMVdY?=
 =?utf-8?B?Y3VTNTFHTkErT20xWGgyMnFPRDRWMkxlbytJZXVNelc0QlpTeGpZS1hEUk5O?=
 =?utf-8?B?cUE2YkwyR3JzaEpDQmNFS3ZZNUtoMWI4dnUrV1hwWXlRcHArcG1hUDRHVGU4?=
 =?utf-8?B?V0hSRGVMWWJIUkNNYXNRQUNuWGlVSHRwbk5xdmwyaUk5S1c3SGRCYVVNSzdy?=
 =?utf-8?B?aEYvbDRuT1BhYTM5V3ZZNDhGVXpNc08xVjNZOWh0WGo5MWpEbHhKdTVFU0pC?=
 =?utf-8?B?WTk2SCt1T2lpV3loR1p0aExkT0VFQTc0c2dwWE5aaU9kV2MyaVA3TURycnMr?=
 =?utf-8?B?Y0o2dWFjcHIzMFduS3N0TkwwQ09JZjl5cXp6TWNoT05abG1xZ2ZReU9PTktX?=
 =?utf-8?B?UnJ4UVdKT2xHcHh5MDlFcTg4QVF5SkR4SHpYZE1rcTA0bngxR2hLMlYyRkhQ?=
 =?utf-8?B?WXZnUE82SHhWK3duQk13YmZOM08xL0Y4THQ1eW0rOU5qSlhMclZIeWhVN05t?=
 =?utf-8?B?R2NCSE1ZdDkxMUlsb1VvckRKTWFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2013D021480F3F44B61E4F913E4E310C@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a26a2a6-b669-4741-35b9-08dd10abed63
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 19:27:56.4522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AgR5xUI0KIoLlhE8rgrYZOxETCGPeRgK9drmjnUTkGfR2D5DohhzsKPYy/q8uA/GevKJwAtPpwfNUlZHKbnXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5024

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgZmY3YWZhZWNh
MWExNWZiZWFhMmM0Nzk1ZWU4MDZjMDY2N2JkNzdiMjoNCg0KICBNZXJnZSB0YWcgJ25mcy1mb3It
Ni4xMi0zJyBvZiBnaXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy9hbm5hL2xpbnV4LW5m
cyAoMjAyNC0xMS0wNiAxMzowOToyMiAtMTAwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0
IHJlcG9zaXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMvdHJv
bmRteS9saW51eC1uZnMuZ2l0IHRhZ3MvbmZzLWZvci02LjEzLTENCg0KZm9yIHlvdSB0byBmZXRj
aCBjaGFuZ2VzIHVwIHRvIDM4YTEyNWIzMTUwNGY5MWJmNmZkZDNjZmMzYTNlOWE3MjFlNmM5N2E6
DQoNCiAgZnMvbmZzL2lvOiBtYWtlIG5mc19zdGFydF9pb18qKCkga2lsbGFibGUgKDIwMjQtMTEt
MjggMTI6NTU6MzMgLTA1MDApDQoNCg0KQ2hhbmdlcyBzaW5jZSB2MTogUmVtb3ZlZCB0aGUgcGF0
Y2ggIm5mczogcGFzcyBmbGFncyB0byBzZWNvbmQgc3VwZXJibG9jayINCmFzIGFncmVlZC4NCg0K
Q2hlZXJzLA0KICBUcm9uZA0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpORlMgY2xpZW50IHVwZGF0ZXMgZm9yIExpbnV4
IDYuMTMNCg0KSGlnaGxpZ2h0cyBpbmNsdWRlOg0KDQpCdWdmaXhlczoNCi0gTkZTdjQuMDogRml4
IGEgdXNlLWFmdGVyLWZyZWUgcHJvYmxlbSBpbiBvcGVuKCkNCi0gbmZzL2xvY2FsaW86IGZpeCBm
b3IgYSBtZW1vcnkgY29ycnVwdGlvbiBpbiBuZnNfbG9jYWxfcmVhZF9kb25lDQotIFJldmVydCAi
bmZzOiBkb24ndCByZXVzZSBwYXJ0aWFsbHkgY29tcGxldGVkIHJlcXVlc3RzIGluIG5mc19sb2Nr
X2FuZF9qb2luX3JlcXVlc3RzIg0KLSBuZnN2NDogaWdub3JlIFNCX1JET05MWSB3aGVuIG1vdW50
aW5nIG5mcw0KLSBzdW5ycGM6IGNsZWFyIFhQUlRfU09DS19VUERfVElNRU9VVCB3aGVuIHJlc2V0
aW5nIHRoZSB0cmFuc3BvcnQNCi0gU1VOUlBDOiB0aW1lb3V0IGFuZCBjYW5jZWwgVExTIGhhbmRz
aGFrZSB3aXRoIC1FVElNRURPVVQNCi0gc3VucnBjOiBmaXggb25lIFVBRiBpc3N1ZSBjYXVzZWQg
Ynkgc3VucnBjIGtlcm5lbCB0Y3Agc29ja2V0DQotIHBORlMvYmxvY2tsYXlvdXQ6IEZpeCBkZXZp
Y2UgcmVnaXN0cmF0aW9uIGlzc3Vlcw0KLSBTVU5SUEM6IEZpeCBhIGhhbmcgaW4gVExTIHNvY2tf
Y2xvc2UgaWYgc2tfd3JpdGVfcGVuZGluZw0KDQpGZWF0dXJlcyBhbmQgY2xlYW51cHM6DQotIGxv
Y2FsaW8gY2xlYW51cHMgZnJvbSBNaWtlIFNuaXR6ZXINCi0gQ2xlYW4gdXAgcmVmY291bnRpbmcg
b24gdGhlIG5mcyB2ZXJzaW9uIG1vZHVsZXMNCi0gX19jb3VudGVkX2J5KCkgYW5ub3RhdGlvbnMN
Ci0gbmZzOiBtYWtlIHByb2Nlc3NlcyB0aGF0IGFyZSB3YWl0aW5nIGZvciBhbiBJL08gbG9jayBr
aWxsYWJsZQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpBbm5hIFNjaHVtYWtlciAoNSk6DQogICAgICBORlM6IENsZWFu
IHVwIGxvY2tpbmcgdGhlIG5mc192ZXJzaW9ucyBsaXN0DQogICAgICBORlM6IENvbnZlcnQgdGhl
IE5GUyBtb2R1bGUgbGlzdCBpbnRvIGFuIGFycmF5DQogICAgICBORlM6IFJlbmFtZSBnZXRfbmZz
X3ZlcnNpb24oKSAtPiBmaW5kX25mc192ZXJzaW9uKCkNCiAgICAgIE5GUzogQ2xlYW4gdXAgZmlu
ZF9uZnNfdmVyc2lvbigpDQogICAgICBORlM6IEltcGxlbWVudCBnZXRfbmZzX3ZlcnNpb24oKQ0K
DQpCZW5qYW1pbiBDb2RkaW5ndG9uICg0KToNCiAgICAgIFNVTlJQQzogRml4IGEgaGFuZyBpbiBU
TFMgc29ja19jbG9zZSBpZiBza193cml0ZV9wZW5kaW5nDQogICAgICBTVU5SUEM6IHRpbWVvdXQg
YW5kIGNhbmNlbCBUTFMgaGFuZHNoYWtlIHdpdGggLUVUSU1FRE9VVA0KICAgICAgbmZzL2Jsb2Nr
bGF5b3V0OiBEb24ndCBhdHRlbXB0IHVucmVnaXN0ZXIgZm9yIGludmFsaWQgYmxvY2sgZGV2aWNl
DQogICAgICBuZnMvYmxvY2tsYXlvdXQ6IExpbWl0IHJlcGVhdCBkZXZpY2UgcmVnaXN0cmF0aW9u
IG9uIGZhaWx1cmUNCg0KSmVmZiBMYXl0b24gKDEpOg0KICAgICAgc3VucnBjOiByZW1vdmUgbmV3
bGluZXMgZnJvbSB0cmFjZXBvaW50cw0KDQpMaSBMaW5nZmVuZyAoMSk6DQogICAgICBuZnM6IGln
bm9yZSBTQl9SRE9OTFkgd2hlbiBtb3VudGluZyBuZnMNCg0KTGl1IEppYW4gKDIpOg0KICAgICAg
c3VucnBjOiBjbGVhciBYUFJUX1NPQ0tfVVBEX1RJTUVPVVQgd2hlbiByZXNldCB0cmFuc3BvcnQN
CiAgICAgIHN1bnJwYzogZml4IG9uZSBVQUYgaXNzdWUgY2F1c2VkIGJ5IHN1bnJwYyBrZXJuZWwg
dGNwIHNvY2tldA0KDQpNYXggS2VsbGVybWFubiAoMSk6DQogICAgICBmcy9uZnMvaW86IG1ha2Ug
bmZzX3N0YXJ0X2lvXyooKSBraWxsYWJsZQ0KDQpNaWtlIFNuaXR6ZXIgKDQpOg0KICAgICAgbmZz
L2xvY2FsaW86IHJlbW92ZSByZWR1bmRhbnQgc3VpZC9zZ2lkIGhhbmRsaW5nDQogICAgICBuZnMv
bG9jYWxpbzogZWxpbWluYXRlIHVubmVjZXNzYXJ5IGtyZWYgaW4gbmZzX2xvY2FsX2ZzeW5jX2N0
eA0KICAgICAgbmZzL2xvY2FsaW86IHJlbW92ZSBleHRyYSBpbmRpcmVjdCBuZnNfdG8gY2FsbCB0
byBjaGVjayB7cmVhZCx3cml0ZX1faXRlcg0KICAgICAgbmZzL2xvY2FsaW86IGVsaW1pbmF0ZSBu
ZWVkIGZvciBuZnNfbG9jYWxfZnN5bmNfd29yayBmb3J3YXJkIGRlY2xhcmF0aW9uDQoNCk5laWxC
cm93biAoMSk6DQogICAgICBuZnMvbG9jYWxpbzogbXVzdCBjbGVhciByZXMucmVwbGVuIGluIG5m
c19sb2NhbF9yZWFkX2RvbmUNCg0KVGhvcnN0ZW4gQmx1bSAoMSk6DQogICAgICBuZnM6IEFubm90
YXRlIHN0cnVjdCBwbmZzX2NvbW1pdF9hcnJheSB3aXRoIF9fY291bnRlZF9ieSgpDQoNClRyb25k
IE15a2xlYnVzdCAoNCk6DQogICAgICBORlN2NC4wOiBGaXggdGhlIHdha2UgdXAgb2YgdGhlIG5l
eHQgd2FpdGVyIGluIG5mc19yZWxlYXNlX3NlcWlkKCkNCiAgICAgIE5GU3Y0LjA6IEZpeCBhIHVz
ZS1hZnRlci1mcmVlIHByb2JsZW0gaW4gdGhlIGFzeW5jaHJvbm91cyBvcGVuKCkNCiAgICAgIFJl
dmVydCAiZnM6IG5mczogZml4IG1pc3NpbmcgcmVmY250IGJ5IHJlcGxhY2luZyBmb2xpb19zZXRf
cHJpdmF0ZSBieSBmb2xpb19hdHRhY2hfcHJpdmF0ZSINCiAgICAgIFJldmVydCAibmZzOiBkb24n
dCByZXVzZSBwYXJ0aWFsbHkgY29tcGxldGVkIHJlcXVlc3RzIGluIG5mc19sb2NrX2FuZF9qb2lu
X3JlcXVlc3RzIg0KDQogZnMvbmZzL2Jsb2NrbGF5b3V0L2Jsb2NrbGF5b3V0LmMgfCAxNSArKysr
KystDQogZnMvbmZzL2Jsb2NrbGF5b3V0L2Rldi5jICAgICAgICAgfCAgNiArLS0NCiBmcy9uZnMv
Y2xpZW50LmMgICAgICAgICAgICAgICAgICB8IDY0ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LQ0KIGZzL25mcy9kaXJlY3QuYyAgICAgICAgICAgICAgICAgIHwgMjEgKysrKysrKy0tDQogZnMv
bmZzL2ZpbGUuYyAgICAgICAgICAgICAgICAgICAgfCAxNCArKysrLS0NCiBmcy9uZnMvZnNfY29u
dGV4dC5jICAgICAgICAgICAgICB8ICA2ICstLQ0KIGZzL25mcy9pbnRlcm5hbC5oICAgICAgICAg
ICAgICAgIHwgIDkgKystLQ0KIGZzL25mcy9pby5jICAgICAgICAgICAgICAgICAgICAgIHwgNDQg
KysrKysrKysrKysrKy0tLS0tDQogZnMvbmZzL2xvY2FsaW8uYyAgICAgICAgICAgICAgICAgfCA5
NiArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogZnMvbmZzL25hbWVz
cGFjZS5jICAgICAgICAgICAgICAgfCAgMiArLQ0KIGZzL25mcy9uZnMuaCAgICAgICAgICAgICAg
ICAgICAgIHwgIDQgKy0NCiBmcy9uZnMvbmZzNHByb2MuYyAgICAgICAgICAgICAgICB8ICA4ICsr
LS0NCiBmcy9uZnMvbmZzNHN0YXRlLmMgICAgICAgICAgICAgICB8IDEwICsrLS0tDQogZnMvbmZz
L3dyaXRlLmMgICAgICAgICAgICAgICAgICAgfCA1NSArKysrKysrKysrKysrKy0tLS0tLS0tLQ0K
IGluY2x1ZGUvbGludXgvbmZzX3hkci5oICAgICAgICAgIHwgIDIgKy0NCiBpbmNsdWRlL3RyYWNl
L2V2ZW50cy9zdW5ycGMuaCAgICB8ICA0ICstDQogbmV0L3N1bnJwYy9zdmNzb2NrLmMgICAgICAg
ICAgICAgfCAgNCArKw0KIG5ldC9zdW5ycGMveHBydHNvY2suYyAgICAgICAgICAgIHwgMTggKysr
KystLS0NCiAxOCBmaWxlcyBjaGFuZ2VkLCAyMjkgaW5zZXJ0aW9ucygrKSwgMTUzIGRlbGV0aW9u
cygtKQ0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

