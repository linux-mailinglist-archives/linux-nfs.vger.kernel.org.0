Return-Path: <linux-nfs+bounces-4073-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DFA90EFF2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 16:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822C41C240EA
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737AB1DA4D;
	Wed, 19 Jun 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="CmRAtxYk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2097.outbound.protection.outlook.com [40.107.237.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A9D15EA6
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806523; cv=fail; b=NfVhEs/+8V7YseIYyaVTVaIuXpDGXG4Tm/utVCCgymYM1FE5pct7bC3D/dpvwdr9PUSaxNlZ2ZHVVv+TvTg9TEfrczn9n8nmMjAUezXWT+3gFdN9/zth3/qyeBcgmImD18OoMcXS1/8yuv7KIayNW/ZhpzApyrIhitQw6wVybXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806523; c=relaxed/simple;
	bh=5d3xY8vWbpsudDBJcvooQlJKhZn1HoZXKMeTHSnZkhA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q3lib0fV/dAt4LQZDPCBzyvfpGace0XVSLtgyycRPBvyvz0da5JnGiJzw5AI++EawWDetdl6mJ1+55nIZCES+1HE2UBUkC1ERcNDiMheQXzxk6ogof2MjLa+R9GHQCW1ld5EmX1tpCYXBnupSf4pFRfKyLKMMCdfUXYN9TyihRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=CmRAtxYk; arc=fail smtp.client-ip=40.107.237.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7qL62VCSw7lLSm1rzcna9uOILbSbqoMzNicx4n6PbVaQEUemXcxBcOza2nQY3KEZdHq7/tJ58+knVUOcQsUFXPIwuaTmMwCf2EO6EnRK93cbVMO5KSPKU5fKV27jigyfQ7Rvhkz1kmFXeQdzQYTid2dOPmvgQheiPP/7XVfGmOmJku/yafNGOz8Uvuxsuc1P6QBLrD9f30/K52Fb04I45V4Ggdl230Y39K2GcUV3ZcQa2B3DgIX/w6cahPfgEYQ9AEqnZOMMXFvzR9TfpMeGsBB2QtwoU9gcu1/Gpem5hJf4I95MJFPL+mxnsZ5PW9t6ie19UlOBmiXkNxSwehboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5d3xY8vWbpsudDBJcvooQlJKhZn1HoZXKMeTHSnZkhA=;
 b=fu9xFrbwuSphj0I0HG4nA2q/1ZPBmDzFivMiAfyH+gs3RghOkPGpFuYtCJl/+C/da1AKr33hh2viVM0GuKSpDNMVL4SyGYWU02fF2LCsjEVA4dfADCPGT1O8yl2DwykyNsYeXKmXeuiODV0uBY/UDQvILF0qCtmTfK+b1L78+y7Ge618suNZabWjQ7RO1AXg6bOC/CDmgORW71Lub9vMJdUEeGpHvgzJaxq/7WSvAMlSFYNo82e1QDRp/dr3MzlLpd5bMy5Pt9uXsqsa1pHSTOWThUI2GkDnh0cERNd2yXo/0kQUMX1RA2V63ssC8FZkT8wBL868Rh7ti80I3vIAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d3xY8vWbpsudDBJcvooQlJKhZn1HoZXKMeTHSnZkhA=;
 b=CmRAtxYkDXfP+oeohmQrLPLxUoz2A7Sr0HpBmR2VO00CWyyVJ2cCFySqfMZC/9CbwumyISKkZw3+zRoHTV3gD6as96TR6IrtOvme0k3evfl/samvnO3122wPbRbCxE471HgQ6YuIKee3gOI8vvaHjBOOwncpbBNJAiW3iKo5WnI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS1PR13MB7098.namprd13.prod.outlook.com (2603:10b6:8:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 14:15:17 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 14:15:16 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>
Subject: Re: [PATCH] nfs: add 'noextend' option for lock-less 'lost writes'
 prevention
Thread-Topic: [PATCH] nfs: add 'noextend' option for lock-less 'lost writes'
 prevention
Thread-Index: AQHawZTgISFLcUQ41kCD6EOpRxYIYrHN4DUAgADkkwCAAF5EgA==
Date: Wed, 19 Jun 2024 14:15:16 +0000
Message-ID: <5366ff2a4f731dbd93a56e109d6809a5348cf080.camel@hammerspace.com>
References: <20240618153313.3167460-1-dan.aloni@vastdata.com>
	 <d2f48ca233f85da80f2193cd92e6f97feb587a69.camel@hammerspace.com>
	 <ae298053-bdee-4a8a-b6a9-e57de79abc97@grimberg.me>
In-Reply-To: <ae298053-bdee-4a8a-b6a9-e57de79abc97@grimberg.me>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DS1PR13MB7098:EE_
x-ms-office365-filtering-correlation-id: 317d4147-65c2-4010-0999-08dc906a3e7c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWlnWFRWTTJmNE9KRzhhVUtacHpDcitleklGS2FnL09XWHJwa0ZWNmFTNHk2?=
 =?utf-8?B?dVNoMDdhOFN5MHdEZ2lQN3hVc3pkRXpEUzlrd2VrVy9oOW01dk43all1TCtz?=
 =?utf-8?B?SjVpN1VVTVpTeG1vL0hTRkIrMEQ4dGpDWUU2M2YvSmNVZ29uK1NxZWs4L21m?=
 =?utf-8?B?aXNMaVFYdERyaDZPa05XblJ5Yk9SVmNYUUxnRHEwSE1Hc2l1YzcxanExLzhN?=
 =?utf-8?B?aXUzbnNGcnpnNVhmWW1haXVJYXQySTBhL1RJc2R4UnZxVUVKV09GdHhNN05J?=
 =?utf-8?B?V280NCsyS0pXaHdxaC93YVZDaDlLSGYwMXZlL1BxVitFWEl6bVlQOUd2Wndt?=
 =?utf-8?B?WVJ2SG5yZ0tLOGZoL1h5dFBRWXQ4UkIrSmF0dGxHelVKclVTOUlKWFd6UFJx?=
 =?utf-8?B?ZTFvbTZEelAwSVl3a1BLc3pMMlFEY2NWcFpheXYvUllwK2dDd01jcE5TbFM1?=
 =?utf-8?B?WVFmYlpKZTBnUWJaN1N0aUF6aWpSdHljdlRwKzE2UEF1WTVZWDB1WjFPNUZ0?=
 =?utf-8?B?VkErQkxTeDBTSzEyUUlObEd0QjRLR1p0T1FFc3VSc2RxZnIzKzNGd29DQVM5?=
 =?utf-8?B?UGZueWo2Y1RXdUxRV3pGYm1GZ0NJcU1Od0k5K01idkZWdkRqdnVKZnhmMGlZ?=
 =?utf-8?B?NHVsZjlWNFNuUEVBdzlhYXB0ZVpneWx0OFpHckdSZmNITGwyRVlRMWpycFJy?=
 =?utf-8?B?WTBxbmFBcW9zOHJFZmxDZHZ6V1hKd3hGcjVPeXpOZ01WYi9GYU9OQU01N2FU?=
 =?utf-8?B?OWh3QTdHTENnOXdaWnVzUElFcUdxUDF4aFpaSWUyRU16M1lkK0E0Z3RleVBy?=
 =?utf-8?B?dzhWY1l6c2FFeWozaWJESVB2c2ZvZjl2ckFZQ1ROQjVvQlhqeWNWM0JyY1lw?=
 =?utf-8?B?Z0xuQ3JOMlE1WHlQVWE0UWdyOUV6ZDhxdDVPVFdENWtBdmtnN2ZLNmR0ZnQy?=
 =?utf-8?B?VklldkJ2OXhIdnplaXpDd09QeHBOdWNLRlVmZ1BIOERZdGc4N29QVmJUSTA5?=
 =?utf-8?B?bC82WUdGL0VPeWV4NERYZW0zUWo2RTdtZ0tZU0xoT0VaZ0pOdU1EbWpEYW92?=
 =?utf-8?B?VTM2eWl6UW1pNlpTbzY1UTFNRHBGTkJBWU9leDluSkhQQjNTdjB3UXpMQnZ4?=
 =?utf-8?B?T1dzUEh6RElVNk4xajNxQUxKMG1xejBjNklvUy9MdUZVNWMxOXV0QzlLODlo?=
 =?utf-8?B?Qm5MZllrMVZRRGVCMzBsRWlpWlo5VHM5dEFZZEN1OElxZTc3L3lDNWRWZWdi?=
 =?utf-8?B?ZkZIalAxb1ZUUU43K3l5TDVRRURWNHBUSHRCZ2RMekp4V0FrSHdNZStvYkpq?=
 =?utf-8?B?ZXpYRVFmdmNwWlJjdDZNOFJnYjh4a3BCWTNGbTVYV2VVM2NnWVVJdWZFLzAy?=
 =?utf-8?B?STh2V1krbDg5b0xYTHVZUWREWnlweUZzT1R2a0FGYWNYaHgza0RxUTBVSEY2?=
 =?utf-8?B?RVRaQ05RNmRKb3YyVGtqZXlVdm52R3kxYzQxSjlFYTE4M2NqOXl1bXF5WDB4?=
 =?utf-8?B?SnZNd2VndjhCL0RHTGwyZzJzcmVQRWk3WjJKdmp0UXZ5Rkl4eGwvaDJ5NG1q?=
 =?utf-8?B?YyswNlVHRHF1T2c0WjB1NXRTV1VDM1BnRXZFV08wdmx4eVQzQWxoYldzQkE5?=
 =?utf-8?B?VTh6eE50angyVjRDYzVDYS9DbThCTWZYUGRUejYwMzBTMVF1bmVCRmtMTVZR?=
 =?utf-8?B?bU9LME1ZeGRrTHdYOU5uMm9yU2ZDbFBOa2tHMjdBUVljNUZkakMvTUNPMEhp?=
 =?utf-8?B?M1JJZXR2YUtObE15R0IyQ1lzbngrK013UXNJM2NOSkhXQmtOZ0NVM1gva2h2?=
 =?utf-8?Q?fBnrqtE/45AFAgwTGEU/olYb1IW+6v63I+22U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VG1qSk5mMEJoNDNZdkxjNWtyM2lZbWdEUGp2WHNoN3g5Vk5xZXBOdmhUVlI0?=
 =?utf-8?B?NjJCYll2RlI3QldadXlkQ1VaM08xN1FFNkllSEFhT3RsWHNYSmsySFQxZzNK?=
 =?utf-8?B?ejExcDJLSTM1TkJSMU1XTXVSdWFYZEdUWWVPMXcxTG0wZ09rRlVaSDdQVmRY?=
 =?utf-8?B?UkhKVG9wenBmK1ExZVd0a3pYV2RnaEdWN0NXeTZlbUlKakpUOHFWaFlCait2?=
 =?utf-8?B?cG5pblZvdTJnOVBaSHBYeExmTDZTUUVzWUNqeXpqRVFSZDFxVFlDUGNmdllF?=
 =?utf-8?B?KzNuWHIwSHp6a3FMRmYrREJkalcxNy9jMXBkZUpVTDFxSThzdGl2NTFRMGJZ?=
 =?utf-8?B?QWE1dlNkNFZVSldYNnZ4ZDhwUHFMejc5VUpnWmcrTzhmR3J4dUJtQnlDZDMx?=
 =?utf-8?B?cDdSOHdlQ2FZVUU2cmZ6Mnpyczc2MThHVGdrRHpEUHBUVzVTRkEyc1ExM1F5?=
 =?utf-8?B?ZTFrMGdybThzM21XaEFzUldGdys2K0MyRzkweng5ajdGMXFnbzZrR05kOWRO?=
 =?utf-8?B?K2s4SG91bjlSWFl6NFVoUXp1bUJmT3Y3VDF5UGhQU1NuOVdsQlZXSjJkZm1i?=
 =?utf-8?B?VU1nMDdrenVxbG5wWlh0MDhTU2MwTzh2MTNraWFNczVRMFlCT3FWbmp0QlNm?=
 =?utf-8?B?Q0VGZ296ZGVhQ2xZWXJIR1Q4TEE2TTNrekhyUzZVaTJHOWZJc3Nyc3Mvb2NP?=
 =?utf-8?B?RnVMYTg2OHBtV2FWZGQxN2s4bERtUk9iV2tjeE9vN0hiamQyeWVhT3lLSzlT?=
 =?utf-8?B?UGpZbmNqU2x2eXpuc3A5VVRmREhSdGJqeWpYNmNsN29UVnFqT0QvY0YvUmNa?=
 =?utf-8?B?S0t1RzZHVExjejVxQXhoU3NFbjBpZlpDTzR1TDVsMm9zSzlteTU1VXJlaEt3?=
 =?utf-8?B?N0RYNy8xbmZrOUkxUitkWUZQRjZhMDNpMEhaVnZYTDFpaXJzTG9oamdSQWc0?=
 =?utf-8?B?MDYzeUthN0FnejVqUHhHd0NaK2pFWWhvUTdXNGZaN0wyeWpVWkJUMk9Cdlgx?=
 =?utf-8?B?VER4ZTZ1blJEa3U2L0lnRzZkeG9NQzUyc3llamVESnZhMXhGRUoyMGEwcDg4?=
 =?utf-8?B?anJ4bFpUak0xQXUyZWhlbWlmRUdhQ1QzY0hjTzNrUDg2dGgybmJsVHAwU1Vr?=
 =?utf-8?B?QU40UHUwZkhwWHUxOGNaVFMwYWpNQmpyMUJUUGpoSHUzRVMraHQ3R3A2Z0pa?=
 =?utf-8?B?OFV3N2xLdXJwQUN1alAyeERwazEyMXNvN2lrTHh2dnBMc04yeVhFV25RN0l6?=
 =?utf-8?B?ZWpDdEwvYlhFcU0wMVpzbFFoZUJkaUthbUcxaVhYdVh0eXNvekRqejFIeGwv?=
 =?utf-8?B?OXlaVGx5dzg0cGJxNFlWeUxUTi9mN1VTWW9mYWxCUExRV2M4YVFxT2VzVG1o?=
 =?utf-8?B?eW1hQ3lBY3ByUmIwdTVSWFhXdThLdFdhWmhtQkZjK1daUFYwNkNpRDJpUFhV?=
 =?utf-8?B?NkFvV1hiRUVCclhEYVBhQUUrNTdFU25iNFY4dmFSTEY2MHg4VDg5aGdjaXkx?=
 =?utf-8?B?UjZ5cHNweDdKUlFvZXFCVExiYWo5NUl5TGFZMlJKZjNBVWpvNkg1c0grN2cy?=
 =?utf-8?B?RWNYN1k1Y2tHTHpVMEVuT2F5UXUrQmEyd1pVeXJ4bXA4L1grZmNPTnZCQmIx?=
 =?utf-8?B?RmxxTnRwc28zOUs0Sng5RDFIRDJJRkh0K3RsR2lnSVdFU0hTajFybmhIb1RD?=
 =?utf-8?B?RWg2aXFWNEYvazZQOGpORlh5dzI2QXB6SWZ3U3dkMkhaWE5nSEVTNE82TnEx?=
 =?utf-8?B?Q0hCbG5KWTBta1M5UEpSSUNLYS9QTWZnczg0cUppZjhrNDBraEdFanpGbW9u?=
 =?utf-8?B?OFVyNFB2MUZOWTVZQm1TWlpEMTBsQW9Vcmc0ZU9rckE4L1FPTmVZSmM1UFZC?=
 =?utf-8?B?d3VucFFaREljK0R3RDRrNUVzaWpQYjl6TW8wSlVFL09uR0hUNU1kY0FJNDFB?=
 =?utf-8?B?SmlaVHY3Y0J3RXRXT1ZHVklZckh1VDlNSnRLMGpRZFVJNUdSczJ2VGN5N1VM?=
 =?utf-8?B?dDQ5TEpIR0pnMUlrRGZJRFN5ZEVyQmFYRENQbzc3S2ZpRG13bUJaSG1OV3Fo?=
 =?utf-8?B?TGh4L3hjVGVYeTRLYnRzS2JNeVBwaFIxWm1vc2d3My9BM0JkNHI0NjlUNG9y?=
 =?utf-8?B?WWRtZC80MittcGRXc0hzb2ZLSkMxSFY1K0JycWFYSjdDdW1KQTBuUExLcHR4?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <002EC8C342AD284AB633ECD40EBDBAF3@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 317d4147-65c2-4010-0999-08dc906a3e7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 14:15:16.8579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERoFdaariTm7rDRZzld26G/bx4yeZWTIqbXFm9mst0K68p187cBxfhBX8Vjm2V/Gjkr9YEcURAWhTsArUhpLCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR13MB7098

T24gV2VkLCAyMDI0LTA2LTE5IGF0IDExOjM3ICswMzAwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0K
PiANCj4gDQo+IE9uIDE4LzA2LzIwMjQgMjE6NTksIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4g
PiBIaSBEYW4sDQo+ID4gDQo+ID4gT24gVHVlLCAyMDI0LTA2LTE4IGF0IDE4OjMzICswMzAwLCBE
YW4gQWxvbmkgd3JvdGU6DQo+ID4gPiBUaGVyZSBhcmUgc29tZSBhcHBsaWNhdGlvbnMgdGhhdCB3
cml0ZSB0byBwcmVkZWZpbmVkIG5vbi0NCj4gPiA+IG92ZXJsYXBwaW5nDQo+ID4gPiBmaWxlIG9m
ZnNldHMgZnJvbSBtdWx0aXBsZSBjbGllbnRzIGFuZCB0aGVyZWZvcmUgZG9uJ3QgbmVlZCB0bw0K
PiA+ID4gcmVseQ0KPiA+ID4gb24NCj4gPiA+IGZpbGUgbG9ja2luZy4gSG93ZXZlciwgTkZTIGZp
bGUgc3lzdGVtIGJlaGF2aW9yIG9mIGV4dGVuZGluZw0KPiA+ID4gd3JpdGVzDQo+ID4gPiB0bw0K
PiA+ID4gdG8gZGVhbCB3aXRoIHdyaXRlIGZyYWdtZW50YXRpb24sIGNhdXNlcyB0aG9zZSBjbGll
bnRzIHRvIGNvcnJ1cHQNCj4gPiA+IGVhY2gNCj4gPiA+IG90aGVyJ3MgZGF0YS4NCj4gPiA+IA0K
PiA+ID4gVG8gaGVscCB0aGVzZSBhcHBsaWNhdGlvbnMsIHRoaXMgY2hhbmdlIGFkZHMgdGhlIGBu
b2V4dGVuZGANCj4gPiA+IHBhcmFtZXRlcg0KPiA+ID4gdG8NCj4gPiA+IHRoZSBtb3VudCBvcHRp
b25zLCBhbmQgaGFuZGxlcyB0aGlzIGNhc2UgaW4NCj4gPiA+IGBuZnNfY2FuX2V4dGVuZF93cml0
ZWAuDQo+ID4gPiANCj4gPiA+IENsaWVudHMgY2FuIGFkZGl0aW9uYWxseSBhZGQgdGhlICdub2Fj
JyBvcHRpb24gdG8gZW5zdXJlIHBhZ2UNCj4gPiA+IGNhY2hlDQo+ID4gPiBmbHVzaCBvbiByZWFk
IGZvciBtb2RpZmllZCBmaWxlcy4NCj4gPiBJJ20gbm90IG92ZXJseSBlbmFtb3VyZWQgb2YgdGhl
IG5hbWUgIm5vZXh0ZW5kIi4gVG8gbWUgdGhhdCBzb3VuZHMNCj4gPiBsaWtlDQo+ID4gaXQgbWln
aHQgaGF2ZSBzb21ldGhpbmcgdG8gZG8gd2l0aCBwcmV2ZW50aW5nIGFwcGVuZHMuIENhbiB3ZSBm
aW5kDQo+ID4gc29tZXRoaW5nIHRoYXQgaXMgYSBiaXQgbW9yZSBkZXNjcmlwdGl2ZT8NCj4gDQo+
IG5vcGJ3IChObyBwYWdlIGJvdW5kYXJ5IHdyaXRlcykgPw0KPiANCj4gPiANCj4gPiBUaGF0IHNh
aWQsIGFuZCBnaXZlbiB5b3VyIGxhc3QgY29tbWVudCBhYm91dCByZWFkcy4gV291bGRuJ3QgaXQg
YmUNCj4gPiBiZXR0ZXIgdG8gaGF2ZSB0aGUgYXBwbGljYXRpb24gdXNlIE9fRElSRUNUIGZvciB0
aGVzZSB3b3JrbG9hZHM/DQo+ID4gVHVybmluZyBvZmYgYXR0cmlidXRlIGNhY2hpbmcgaXMgYm90
aCByYWN5IGFuZCBhbiBpbmVmZmljaWVudCB3YXkNCj4gPiB0bw0KPiA+IG1hbmFnZSBwYWdlIGNh
Y2hlIGNvbnNpc3RlbmN5LiBJdCBmb3JjZXMgdGhlIGNsaWVudCB0byBib21iYXJkIHRoZQ0KPiA+
IHNlcnZlciB3aXRoIEdFVEFUVFIgcmVxdWVzdHMgaW4gb3JkZXIgdG8gY2hlY2sgdGhhdCB0aGUg
cGFnZSBjYWNoZQ0KPiA+IGlzDQo+ID4gaW4gc3luY2gsIHdoZXJlYXMgeW91ciBkZXNjcmlwdGlv
biBvZiB0aGUgd29ya2xvYWQgYXBwZWFycyB0bw0KPiA+IHN1Z2dlc3QNCj4gPiB0aGF0IHRoZSBj
b3JyZWN0IGFzc3VtcHRpb24gc2hvdWxkIGJlIHRoYXQgaXQgaXMgbm90IGluIHN5bmNoLg0KPiA+
IA0KPiA+IElPVzogSSdtIGFza2luZyBpZiB0aGUgYmV0dGVyIHNvbHV0aW9uIG1pZ2h0IG5vdCBi
ZSB0byByYXRoZXINCj4gPiBpbXBsZW1lbnQNCj4gPiBzb21ldGhpbmcgYWtpbiB0byBTb2xhcmlz
JyAiZm9yY2VkaXJlY3RpbyI/DQo+IA0KPiBUaGlzIGFjY2VzcyBwYXR0ZXJuIHJlcHJlc2VudHMg
YSBjb21tb24gY2FzZSBpbiBIUEMgd2hlcmUgZGlmZmVyZW50DQo+IHdvcmtlcnMNCj4gd3JpdGUg
cmVjb3JkcyB0byBhIHNoYXJlZCBvdXRwdXQgZmlsZSB3aGljaCBkbyBub3QgbmVjZXNzYXJpbHkg
YWxpZ24NCj4gdG8gDQo+IGEgcGFnZSBib3VuZGFyeS4NCj4gDQo+IFRoaXMgaXMgbm90IGV2ZXJ5
dGhpbmcgdGhhdCB0aGUgYXBwIGlzIGRvaW5nIG5vciB0aGUgb25seSBmaWxlIGl0IGlzIA0KPiBh
Y2Nlc3NpbmcsIHNvIElNTyBmb3JjaW5nDQo+IGRpcmVjdGlvIHVuaXZlcnNhbGx5IGlzIG1heSBw
ZW5hbGl6ZSB0aGUgYXBwbGljYXRpb24uDQoNCldvcnNlIHRoYW4gZm9yY2luZyBhbiBhdHRyaWJ1
dGUgcmV2YWxpZGF0aW9uIG9uIGV2ZXJ5IHJlYWQ/DQoNCkJUVzogV2UndmUgYmVlbiBhc2tlZCBh
Ym91dCB0aGUgc2FtZSBpc3N1ZSBmcm9tIHNvbWUgb2Ygb3VyIGN1c3RvbWVycywNCmFuZCBhcmUg
cGxhbm5pbmcgb24gc29sdmluZyB0aGUgcHJvYmxlbSBieSBhZGRpbmcgYSBuZXcgcGVyLWZpbGUN
CmF0dHJpYnV0ZSB0byB0aGUgTkZTdjQuMiBwcm90b2NvbC4NCg0KVGhlIGRldGVjdGlvbiBvZiB0
aGF0IE5PQ0FDSEUgYXR0cmlidXRlIHdvdWxkIGNhdXNlIHRoZSBjbGllbnQgdG8NCmF1dG9tYXRp
Y2FsbHkgY2hvb3NlIE9fRElSRUNUIG9uIGZpbGUgb3Blbiwgb3ZlcnJpZGluZyB0aGUgZGVmYXVs
dA0KYnVmZmVyZWQgSS9PIG1vZGVsLiBTbyB0aGlzIHdvdWxkIGFsbG93IHRoZSB1c2VyIG9yIHN5
c2FkbWluIHRvIHNwZWNpZnkNCmF0IGZpbGUgY3JlYXRpb24gdGltZSB0aGF0IHRoaXMgZmlsZSB3
aWxsIGJlIHVzZWQgZm9yIHB1cnBvc2VzIHRoYXQgYXJlDQppbmNvbXBhdGlibGUgd2l0aCBjYWNo
aW5nLg0KDQpJZiBzZXQgb24gYSBkaXJlY3RvcnksIHRoZSBzYW1lIGF0dHJpYnV0ZSB3b3VsZCBj
YXVzZSB0aGUgY2xpZW50IG5vdCB0bw0KY2FjaGUgdGhlIFJFQURESVIgY29udGVudHMuIFRoaXMg
aXMgdXNlZnVsIHdoZW4gZGVhbGluZyB3aXRoDQpkaXJlY3RvcmllcyB3aGVyZSBhIFdpbmRvd3Mg
c3lzYWRtaW4gbWF5IGhhdmUgc2V0IGFuIEFjY2VzcyBCYXNlZA0KRW51bWVyYXRpb24gcHJvcGVy
dHkuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIs
IEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

