Return-Path: <linux-nfs+bounces-3880-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD6890A1D3
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A811F21A49
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8585C83;
	Mon, 17 Jun 2024 01:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="div3ffuf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2138.outbound.protection.outlook.com [40.107.93.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369363CF
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588352; cv=fail; b=isUdhws4x9RRj/CaSh5FuG0Uhs3tswwRtUQoxAJ+IQnZbpKJQh7AWw57Ghj4C8aod8Ur4AjRKbYVo2+Y0yTsR3wV72GiXqCQ8xO/887awydHSYkiNvsKs1vd9aHtIjw8HDv2AwhghhwOQflP8wWhvtE57Gd16DNlfvqaTfw9jzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588352; c=relaxed/simple;
	bh=CpzuvNpjqQFL5jJ5jJgEk4e+mNNB2/XMd34T2OO5f5k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RYrUAln9yheLdFnKnZvoOckk85u7xiFE7tV5CwjWrBjq1ClZMTJAeOj2lTV0f5D4oFh9xnBrF2q1v3eNmd5KUcJHti9CrdMhBCYw28+WQb+ijLQjKSuZezZ3RIjCa6AOdErtEbpguWt9qj1ribC6XVqkwMdIOjfyX60gqt+Yqsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=div3ffuf; arc=fail smtp.client-ip=40.107.93.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkBtOJeJS7gfx1Dc5sVRzuAaPzfQ142BeBvkw0f1UTbfEQf1Ae0AP/iSggW1VHRNR0gm+QHBYsIBJ5eq0ZaSoKP2Zyo6ubkAvD3nd/R9/FR0ulLcrwSuVcy13oQQsdPDShM9/ffnZT98At7tFy6Yg/rezMjyMEfpmmdVChQE3oF4oVI00C2yNzRTWwY8X9mIiWnaY4vxGWAOOhgmK5+4ewwI7vazWKjtp0Ule3SeXX+PYgjMk0ASCSrtuqPEWHCxd7eQwDMwPF/VEPjzqcXz8TeZX3qqXSLhnqt+T1toIjiP3McyYI26zkYHx0DAVYzuUnBDf6+MOihhQceK+3WlIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpzuvNpjqQFL5jJ5jJgEk4e+mNNB2/XMd34T2OO5f5k=;
 b=jf0WpjFU0kdqsxveCLePIEvNkaFxNCyO20LGzVC0WIABVhBKacd1RCoGujr3LZV+bazcvoOB9V2efVkTRs4To4+Bszpc2Mohrt8A0mKPHiG67ShZachtSOy+51mf3S2G8mEUgT2dyhJf4Mk+Q/S0v2qG4bT97M5BbjUSeZbWeiXC2SZVF8ZQq0U+dLeSsIyUFuMQLZ5WDGrz+xMfOck3EsrFQ1ML9OyTKiwfr3gAx0DIQpzRNj7iYmSJUjCxs7aoVARGI3DNrHDWQ5cuvaB8N6oIV0aSFH0xLflfURiypyYKEeACvEjkw+qQUoghdE6leDSIrqMXwHUqNSJGDQ6tgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpzuvNpjqQFL5jJ5jJgEk4e+mNNB2/XMd34T2OO5f5k=;
 b=div3ffuft1kiOKXulypOYVPQvXjUmcaIpSRia4PrehDk75I0tXQQjj2lZqARKxNH+WgFhjXZS+PnVo629JvrB2QFCTV+bYig7b65GP1hrHuh6V9vyOOVgHJv8/2oYWEfFFNA0m4nShE5O55bPEnO1xgAsyAzCh+rBY7gUDeXGjU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH7PR13MB6138.namprd13.prod.outlook.com (2603:10b6:510:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 01:39:06 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 01:39:06 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "jlayton@kernel.org" <jlayton@kernel.org>, "hch@infradead.org"
	<hch@infradead.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 00/19] OPEN optimisations and Attribute delegations
Thread-Topic: [PATCH 00/19] OPEN optimisations and Attribute delegations
Thread-Index: AQHavUioZqKm6B6YgUKrt2AZ38xbzbHHM9gAgAErrYCAAtQvAA==
Date: Mon, 17 Jun 2024 01:39:06 +0000
Message-ID: <cf0f94ff9259d2bd97d51291e420aa368a2e3d6f.camel@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
	 <b9f5ae349c6ff90b90aff43b86bc3de8b8a9f863.camel@kernel.org>
	 <Zm00O4JN7rY2BiiI@infradead.org>
In-Reply-To: <Zm00O4JN7rY2BiiI@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH7PR13MB6138:EE_
x-ms-office365-filtering-correlation-id: 2d468697-ac6d-4bc5-5102-08dc8e6e4697
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?RllPK1JwNjQ2bkdVNHBvenF6amlUS05jRmlxQnlOTmlvbU82M1F5V1lDL1dW?=
 =?utf-8?B?KytsemNtT2YxTVpQa0FKQndTVnBKeFdqd3JQelY5K09zaWFEd3VPa1IzVThy?=
 =?utf-8?B?Y0Zhb2hZc0gyc29ubXF3c0ZHb3dKY3BNSXVBcjROWk83eEtzM2hIL0FubnlY?=
 =?utf-8?B?eDlSSmpITG1wS0J6ZVIrMHZnYmpEMit3bUVQOVgwZzJkUE9zR1pXM1dIOVh1?=
 =?utf-8?B?cHpYYnZZUnF5L3cvT2Y3aU54dmJEY3A2SElIbTk5QzRObi92RFQ1dWhhZjVY?=
 =?utf-8?B?bk52MWtaUFN3eGtnUWY5bVNzU00zNVZ0MUFJYk03ZmZ1SktxaytROFJ4aGM4?=
 =?utf-8?B?ck1OcVVYSE51dlppUFpSUmQwM1dRc2ttMi8zdnFZVTNEZEtTL1Q4VFFVZVpS?=
 =?utf-8?B?SGFLeThHOVFDUzNpT0hreERoL3R1UzNITlFjNmZ6dlBUQU0yZFVaNzRrc3di?=
 =?utf-8?B?UDNiY3hrSjVwblJUQVpOTG1MUGNxLzgxNmdBUy9HZGQxVjl3b0ZhV0dFaDRE?=
 =?utf-8?B?N0Rsc3VDVytlZGRab1BsWG5IMng3ZDROWHJOVDNsUkxuOHhNU0VxYXRDVVRT?=
 =?utf-8?B?cHZUSklUVHBnWkpDaHJxTzh5TjE5VDRaU3ZzRThqUTJUVW1ObldYQkFpeUtu?=
 =?utf-8?B?M1pkT2V0TStuTVdIY2tVRGduakErcytUd1JkWDNDMzJ3amVIR2c4RXNhTE81?=
 =?utf-8?B?ZlRQYS9reitvN3BEamdZMHVtU0tFWXFQZ0NPV29PUXA2TFlKSDM4NHM3bnBT?=
 =?utf-8?B?VXdlWitPSmFjeTVURnpiUTAyQkZpYlprcVdlTDROeE51VWxxazdwTnBvZ0M0?=
 =?utf-8?B?RmkrNkFFb2lKNmRZdDlBQjFsZm1YSzJQcUhWM3BpYklVVzQ4K3kydW4xc2Zz?=
 =?utf-8?B?S0FRbDZidWdCenBiUG5TNk1peFVON3FLTUpCYlFlNVBJZmlKQXRpazdvVWt6?=
 =?utf-8?B?b1JyZFhrd0FvTkViMVpYRFRXMjZnN3FKbEpOKzlubWZlRUVPRTdMVXhvcEtB?=
 =?utf-8?B?aS9MNW5aSDFlMzZlSEMzK3JlRXNlSnRkeHJUcEx3c3hCMThLT2RQcU9rQXVC?=
 =?utf-8?B?QllLUGRoa2lnajlncFNjZ1dsNmNza21RdTZyeG4rcEZ3RldQbVZlN3VLb0Rj?=
 =?utf-8?B?UktPUS94cHlTQTgyN0ZiWms4MUxweVZJQzlpL0gwVCtaVnNCaDIzUFVndE9X?=
 =?utf-8?B?WVpEZURMc3JWOWV6UXpLN0dNNTRlOVcrc29vVkR0UndKaFZ2LzhXQ0I2cmd1?=
 =?utf-8?B?Z1NXcjdKVDloemRlZXdpZzVOWXpjUmxWR1gvTDdrZ1d1OW1nb2VPY3A2NEZN?=
 =?utf-8?B?NW9PTGlna2R3YVM0NGhVcE40MVkxT0hsNFVHSnZBbnlUNEYwaEZXY0VsTU1t?=
 =?utf-8?B?bXcvSWdwSDNQRU52akhOUVJFank5M0JNamFnZTZPRlg5QnZtUDdzcFNxQTJT?=
 =?utf-8?B?OGhza1NJSE9NWHkxOVlnaDkyRnhMWjkxS0Mrb1VydENCQms1RWx2NTJWWWpG?=
 =?utf-8?B?d3lScHd0TjRMS1AyMWk1cE1DQnIxbnN0MFl1ZnlZZm9sWXpaMHNlOGN2dkta?=
 =?utf-8?B?ZGVHeThodVVBc3FaTTBSUGRaR1pkOFQvMGJORjFlc1gwQllTdFdEbGRGeUtx?=
 =?utf-8?B?aEtWNG9VY1ZOQmR6emdGbTFPelhpMy9zNG1OUkpIbnoyN3UyU0FuOStWcktz?=
 =?utf-8?B?Z2ZOdVV5Zng5UGR5d203ajB5SHhyelByS2dEUXdwS2VhUjNYelpKYmxjb3Vm?=
 =?utf-8?B?N1FiUDFPdzBVZllTQTBTVStCSXdSQ3dTK01Eemx1TG5lVS9aVk5Hd09DZWZC?=
 =?utf-8?Q?BR9TUrtGm/fiimrUZ/q8UIWLYq1ll1AL8me/4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFV4OUpWMEpGNEM4czVUOThlK3hVY0gvSDU2QkE3YStOTVFpQ3p1L01VN0hD?=
 =?utf-8?B?ZklJemxQOEZWZUZCUGQ1alBZaVU4R3hySTBERUk0RlcvM3RUZGE4QWJKd2lq?=
 =?utf-8?B?WDRkK21HTWg3NERtNS9iOUxCTlZ4eXprdDZ2TlhmMEZHRnphUXR5UXUwY2xO?=
 =?utf-8?B?Zlg1c0xuaWZjWEwwWmNkVE1Qa2dYMWJpRmttY2FFMFgzVTA2SE1meDNGNCtO?=
 =?utf-8?B?Z0ZRc3RKQkdNZWVsNDVhWEVLTzMvZlVYcm0wZmlYSDFaMjdGTUhuVTgwOFhn?=
 =?utf-8?B?V0dqM0lSdWlEZnNYZExnekRrTjM4OTAwRUFXcURoTHU1eG83N0J1Y0UzT0R1?=
 =?utf-8?B?TXg2ZjlZRUQyZEhuYTdsT1RQK2t1TWlqQTNEdjE0U1lxK01IT29qdHBtdzd6?=
 =?utf-8?B?U0tOc3FDZXhYRVdvTWVaUTZlWlFTaEMzczB4WUp1SkFBZ2VHNVJwM0d4Ynpr?=
 =?utf-8?B?QWYvMlV2OVlpS0k0Tmt5L0Q0MUw5K01TTk10S2g2VXNaTm00VFk2RjZvQU1y?=
 =?utf-8?B?dmtTaGtTTnlZMlM5Qk4wTTNCdDBwRDc5Rmd0ZjlyUXpsQ1hxS1lia25hcXB0?=
 =?utf-8?B?VkowRXFXZ0o4M1pUNjZSRXRrVi9CbCtlR1Y4c0MyRE5TeGxlSDNaVldyTlZJ?=
 =?utf-8?B?U21hVFd2VVZrVDRLNVNRWFBmOVdVdG5mL0VDclZhbGQ2Q3Jwd3RRd1dpeGdV?=
 =?utf-8?B?bHZaWEppbHJmNkdsUHVtcVhVb3JkdVBRWS91NGpHWi83NytUSXIxMlpnTDlW?=
 =?utf-8?B?cmdJc2thZTh4MXduZnpEVlpjdXpDTGZ6SUVnWFdxZ0lWT1VZdzJJUFlIcm9V?=
 =?utf-8?B?RVEySnMrYjF4RTlveVRmNllxUTdvSkx4Q3pPUVNPclhNQmdubkFXODIzalVz?=
 =?utf-8?B?SzBNNWZZWnl0djVJTHMyd0FWL01NN1djU1lTYVA3WVFScXR2V2ZOcjk3eEw1?=
 =?utf-8?B?ZmtnOGdxWFFSa2YrSDA2V2VRaU04eEkwZjdqSEFqRDlBekI2VWxkRFpLbWMy?=
 =?utf-8?B?alBRallyd2ZiZjErdmtTcDZrVkRwdUg2enBrQ2hVRjh1RmdFTW1tSmN4bFBz?=
 =?utf-8?B?M0t2QlRtZTBkWi9QZ1IyNVNhQzB1Y2FwVDU2Y0wrSmhhbndzNUlHOHJnVnZi?=
 =?utf-8?B?ZjIzcGZ1eXZaYUJETzNOMFJwUlhpeE5iRmptNU1pdWM1QkcyOExmQzlXRy8z?=
 =?utf-8?B?ZUR1YmFmVTdHaENua3J6Rm5JRW1qczE5alVzK2lxVTJKSFdYRHV3bjdNUTRu?=
 =?utf-8?B?N1V1ZzFSVVI3RUNKaWluYUhkcVhLMlVHZUZ1cnErNTdYRExCcDA4bWdLTGVn?=
 =?utf-8?B?WWpjNHFpdlYrbkRyZURWMHJRYnZVWW9QTkk1TUZZK3RNVlNFYkd0Z05qOHli?=
 =?utf-8?B?eTJwK2JEbko0UDBxUWJkT3pGZ053dG1JK3lwV2xZc1dCU0hVTmZFekIyM2xT?=
 =?utf-8?B?NFJwem9HVTQvU1d5SzlrL0FvTFdGNllyOU1EOVVZR0c2VzRWd3pLbldoUUVw?=
 =?utf-8?B?VmdLUWdrSFJReHhFL2JZT3dYak9vSnRBalBZeFc5RnR2clQySmsyM1loS2Nu?=
 =?utf-8?B?Q214bVozWTkvQ3graGp5UUxYdDQ0dDZnMGpCMGVIdEVYWWd6Ulo4RE9mcjFT?=
 =?utf-8?B?VTBiUHZDRFB4Z1pTVHRmYldaa1lOcEFWbFQrbmYya1lVdUF2RGlhNU5XT2xD?=
 =?utf-8?B?cmNRNWdFMytQSU9LMzdxaHJUekRCNVgvT3oxaGFxVjRTMFFvb05pOUFOMUtv?=
 =?utf-8?B?bWNyYkYvS0UrSEczbWx1R204OVVoZ1RJM0E5RmVIWDkxMGJNalUvWVZ1dHRF?=
 =?utf-8?B?Z0J3YnlRSklBZFVuVFI1eklhcVNtalM3VDFsYnJBY285MU9RM25UdWgzOWQ0?=
 =?utf-8?B?RmlHelRDUEdlMVNnV29ldENRQ1d0bUtkaXFqd3hIMHdJdXl5TTFrZi8vVHpo?=
 =?utf-8?B?YTZNNGg4VVZGYktBZnFac2VtcDd6U3hqTkNrTzgvZ1J2T2ZvelZ1VEFWOTUv?=
 =?utf-8?B?QnVTZTNlZnFoeTF1Y0Njb0p0VXFBRHlCUTFsVVBKSDlNZForUWNra3dxNGNV?=
 =?utf-8?B?bUhKaXIwSjg4Tk55aEFxQm4rQU9yVktyckp6SEFIRXNUM0RPdExzT2RtdWxJ?=
 =?utf-8?B?aTJZVkc2T1IxK3dZUzUvUFhUN3YzWGlyY3ZLSmNXSVZvenhnWi9NM2hvODlj?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19A0909E14650346AA4F6AF60CEDAE0E@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d468697-ac6d-4bc5-5102-08dc8e6e4697
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 01:39:06.1033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MJ+kB41sRj5mPvv3ldl9E3RTnTtoWVj0KUxsi0PvcsYZ+mSNAtcDRaMxgq6INkGt3mP9QYMmEC2FgWqu2Rkww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6138

T24gRnJpLCAyMDI0LTA2LTE0IGF0IDIzOjI3IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gRnJpLCBKdW4gMTQsIDIwMjQgYXQgMDg6MzQ6MzJBTSAtMDQwMCwgSmVmZiBMYXl0
b24gd3JvdGU6DQo+ID4gVGhpcyBhbGwgbG9va3MgcHJldHR5IHJlYXNvbmFibGUgZXhjZXB0IGZv
ciB0aGUgbGFzdCB0d28gcGF0Y2hlcy4NCj4gPiBQcm9iYWJseSwgdGhleSBzaG91bGQgYmUgc3F1
YXNoZWQgdG9nZXRoZXIgc2luY2UgdGhlcmUgaXMgbm8gY2FsbGVyDQo+ID4gb2YNCj4gPiAtPnJl
dHVybl9kZWxlZ2F0aW9uIHVudGlsIHRoZSBsYXN0IG9uZS4gVGhlcmUgaXMgYWxzbyBub3RoaW5n
DQo+ID4gZGVzY3JpYmluZyB0aGUgY2hhbmdlcyB0aGVyZSwgYW5kIEkgdGhpbmsgaXQgY291bGQg
dXNlIHNvbWUNCj4gPiBleHBsYW5hdGlvbg0KPiA+ICh0aG91Z2ggSSB0aGluayBJIGdldCB3aGF0
IHlvdSdyZSBkb2luZykuDQo+ID4gDQo+ID4gRmluYWxseSwgSSBzdXBwb3NlIHdlIG5lZWQgdG8g
bG9vayBhdCBpbXBsZW1lbnRpbmcgc3VwcG9ydCBkZWxzdGlkDQo+ID4gaW4NCj4gPiBrbmZzZCBh
cyB3ZWxsLiBJJ2xsIG9wZW4gYSBuZXcgZmVhdHVyZSByZXF1ZXN0IGZvciB0aGF0IHRoZSBsaW51
eC0NCj4gPiBuZnMNCj4gPiBwcm9qZWN0IG9uIGdpdGh1Yi4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsg
dGhlcmUgZXZlciB3YXMgYSBmb3JtYWwgcnVsZSwgYnV0IGhhdmluZyBhIGZlYXR1cmUgbGlrZQ0K
PiB0aGlzIHRoYXQgYWZmZWN0cyBhbGwgb2YgdGhlIGNvcmUgbmZzIGNvZGUgd2l0aG91dCBiZWVp
bmcgYWJsZSB0bw0KPiB0ZXN0DQo+IGl0IGFnYWluc3Qga25mc2Qgc2VlbXMgYSBiaXQgZGFuZ2Vy
b3VzIGluZGVlZC4NCj4gDQoNCldlIGhhdmUgYmVlbiBnb2luZyB0aHJvdWdoIHRoZSBJRVRGIHBy
b2Nlc3MgdG8gZW5zdXJlIHRoZXJlIGlzIGFuDQphZ3JlZWQgdXBvbiBwcm90b2NvbCBmb3IgdGhp
cyB0aGF0IGNhbiBiZSB1c2VkIHRvIHRlc3QgdGhlIGNsaWVudCBjb2RlDQphbmQgdmFsaWRhdGUg
aXRzIGNvcnJlY3RuZXNzLiBUaGF0IHNwZWMgY2FuIGFsc28gYmUgdXNlZCBieSBvdGhlcnMgdG8N
CmNvbnRyaWJ1dGUgdGhlIG1pc3Npbmcga25mc2QgY29kZS4NCkF0IHNvbWUgcG9pbnQgc29vbiwg
SSBkbyBob3BlIHRoYXQgSGFtbWVyc3BhY2Ugd2lsbCBiZSBpbiB0aGUgcG9zaXRpb24NCndoZXJl
IHdlJ3JlIGFibGUgdG8gY29udHJpYnV0ZSBib3RoIGNsaWVudCBhbmQgc2VydmVyIGNvZGUgZm9y
IHRoZXNlDQpmZWF0dXJlczsgZm9yIG5vdywgd2UgYXJlIHVuZm9ydHVuYXRlbHkgc3RpbGwgcmVz
b3VyY2UgY29uc3RyYWluZWQuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tDQoNCg0K

