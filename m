Return-Path: <linux-nfs+bounces-6361-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52530972627
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 02:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77AA11C23238
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 00:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354942FB6;
	Tue, 10 Sep 2024 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="WxUbVDy7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A6A28DA0;
	Tue, 10 Sep 2024 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725927778; cv=fail; b=SXQNIvl+XxEnK8GxlIEDdAVaGd42pftYRXP9xqVncwKO7B+YJ2awwzzvn2hEoVTy2VP5Bik4pKr9A63S2aSh9B6/gMYRMESSBe4TQzHMW77pi98hiBMhAIJG/wE7cEnc0BHl4Hf0d4GnUnUE8GI7IjztjHDrl0KQaKjkqeQiX4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725927778; c=relaxed/simple;
	bh=XQEnRiQfWnskFj24XOBVY72pCQf+oEAb2/v/QbrW7Ks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KOcRfUhGAIFZ9bzYWAmCzxK7/n4bHaTUlsY+GfDd7T5u5cYpZalC/t0M4YSSNzt7BJbrwDgRMUYwJ8Nms76WHZbkWrFz560fn7DoghMBRV+cG3nnP4hnqsTbRRyXOhenrkXe37def1gw7nTW3e+zaP8g2PGdEWSPmtV/IYpTLNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=WxUbVDy7; arc=fail smtp.client-ip=40.107.220.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOHuQ+3konT6LOhog80f4Nc2LEuHF+zVPYhWP0chn8cPsTAdqtx8+R8yUJxxmW2eTBDz8FnLMTY6T/mnFNy20Xy91jbXvr8VnhaqNIHTUBCaOePEvDGZK2hD5wDpNaHGzZNgZNpVqz41afdRGjzibGX+M5JR6UKiN1JIyTFkc4K7HuPfdtpfE2aRSdRrZlD7qAxpL5yCNKozNa1hz0XBPtB6irbZLtQu8MuOVoiU2z4p4xmJ1j8y9Ktm8lMmh2BKZzF62TsaMp0MhGCcYkkrriciI5wTp8UzdTWUllWDIDkMSiqCKxnEissup9d/078/1ysV/GlCNN9gELdbnXsxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQEnRiQfWnskFj24XOBVY72pCQf+oEAb2/v/QbrW7Ks=;
 b=OFeKPQ3kGSI8W4YBmZTSSLyhVNPdY8gdrk4etkngRNnmtWUauOnHIANZq0EWMwaHR+FGsXWQAQIWLnnGUk/WYiOTSFjJXKV6dqIYXp4u+hdyVZ34XsXviRb+WdoTeLtcoY6bxusVcBqz/6khkytepK2dMJaAJa+n8/QE/oB1wNSsJ8Z14YoY1MDR0rZlt0x/vn3bxlfTsa76i5bdd+Pnengslzr1e4QSbiARfs/G6Jx7c1yJxJ1Ypah729AUj20Cakjl9eYFpuaQx6k5u9GgBePT7r1uEcbj8y01PmgNn7DTEGlBKzcb17SkHOCMKVmkgVC9rX9osJ6+yO3DiiHQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQEnRiQfWnskFj24XOBVY72pCQf+oEAb2/v/QbrW7Ks=;
 b=WxUbVDy77iARnwCgYlWzPI2KurkYqPiGm5IDDGkvyEfhpK045dpNHyl5A0IF2+stgCmH/phwC3NiYxhGTkIfoqUmXgMx+3PVwQLyIeK91T5JCFl+ZKIf/YC45YeeO9XtrObcXVNYSdWOj6W3SMs+bI4v4irg8p06D5L8jyIDA40=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN7PR13MB6277.namprd13.prod.outlook.com (2603:10b6:806:2de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Tue, 10 Sep
 2024 00:22:53 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 00:22:53 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "ovt@google.com" <ovt@google.com>
CC: "anna@kernel.org" <anna@kernel.org>, "jbongio@google.com"
	<jbongio@google.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: fix a mount deadlock in NFS v4.1 client
Thread-Topic: [PATCH] NFSv4: fix a mount deadlock in NFS v4.1 client
Thread-Index: AQHbAwztQJsv5RBnrky+aAqWUODlvbJQKQsA
Date: Tue, 10 Sep 2024 00:22:53 +0000
Message-ID: <8d95e5334c664d10a751e5791c8291959217524e.camel@hammerspace.com>
References: <8f2e20f2fc894398da371517c6c8111aba072fb1.camel@kernel.org>
	 <20240909163610.2148932-1-ovt@google.com>
	 <84f2415b4d5bb42dc7e26518983f53a997647130.camel@hammerspace.com>
	 <CACGj0ChtssX4hCCEnD9hah+-ioxmAB8SzFjJR3Uk1FEWMizv-A@mail.gmail.com>
In-Reply-To:
 <CACGj0ChtssX4hCCEnD9hah+-ioxmAB8SzFjJR3Uk1FEWMizv-A@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SN7PR13MB6277:EE_
x-ms-office365-filtering-correlation-id: 5bef2ccd-d5f7-4495-0aed-08dcd12eb624
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dUNJVjlSajhGYmVLbWxpenhtSHJtYXo5bEZiTk1LeXZoMHhFYUd2NjlMcTNB?=
 =?utf-8?B?YjErVG9NUDE2azJKaHB4RXVka3FEYkRHT04vYTM5L3ZQWFRyc0thUXVTNzRo?=
 =?utf-8?B?OEhZRVRZd0ErMlE3dXlSV240NnJ0NDd3Vkk4Y3AyZ2haVFliNEExc1VrM2xH?=
 =?utf-8?B?ZUc4bm94a01EdU84VWdDc0RMTEgwc09OSWhDSmRUczVLcG9qaVlKY0hmcHVo?=
 =?utf-8?B?TGt0QUxJTCtWV1RhdmJmQkdOOHZYT09MdHR2SldrY1MyR0hTL1ZuZTBpZEd3?=
 =?utf-8?B?SjJyTzAwQmlOUU5DMHd5VTgzeUtkcG9UZnlWQVZ0MlExdjJ6dStYWittOEx1?=
 =?utf-8?B?Z21HbmZFM0lIbkY1eENFYm13d3ZOU0tFQTBTQmFLZEowQXVLOG1yOEFvaG82?=
 =?utf-8?B?cXhVNWlnUlFhcWFWejkwZEdpSEJ1M0xCN3QwWUJmQ1BhZy9lbjgveUxZZElE?=
 =?utf-8?B?N2U4U3czTVR2ak9Gc3ROa1djdllqaEQrcFJRR3NhVmFjdkRWS0ZkZnVpZnEr?=
 =?utf-8?B?MFpCMnNuQXNUdFJlY3lqSy91WUd0dVRrWXlqZHl0RWFaSGZsb2ZaNGdMWnl0?=
 =?utf-8?B?YlpiZGNvNis3bm4vSG9QNmNxZ1I2Rmh3bGlhMnY5dUtVZkdJMTB2YW52YStw?=
 =?utf-8?B?c0xHRnNpTGNNY2h6d3JTS3NiNDZBSmVBNWtpa0I0dWdBRlB6S1MwM0hnd0pD?=
 =?utf-8?B?cGgvb3UwZ0lqdURmMWZQQ0FXQmRuTGd3YlRZYnR0S2hseVd2VDNUQU44cDFG?=
 =?utf-8?B?MytCMFREN3ZBODNwTlcySlJtN2FPUk54TlYzRVkwdDFVWFJURVprS00vUEFm?=
 =?utf-8?B?ZW05WE5GaUJDajYrZmo2dGxyRlo1N29CN002TDZXYUlqN1drSi90SkJyd0lO?=
 =?utf-8?B?UUhNZW1Iei8zcDlad1pyaVAyZG9zRjhyZ0FMQ3MyQkxrRHVFSE1hMVZ1MTgv?=
 =?utf-8?B?cSswTVBhVTJydm1iM2d2V2JObG4yNzh3eEJOeG9WT1IwK05iQU8vZTZGR21E?=
 =?utf-8?B?QyttR00wNm9EbUY0RVRlU0Y1Wm1zNnozRmF4N256UnRTR2w0K0tlcHVWVlFR?=
 =?utf-8?B?ZzdIMk5ZOFo4VEVSeXNYOXliS2R0b0k3M2V3K0JJaUZZcGI2MzhvVVhLMlhU?=
 =?utf-8?B?cFRHZ0daSkZ2VVNMSTZKdStmRDBsblpKTFdMNnhITmlyeUdVcVlKV0ZpQ3VY?=
 =?utf-8?B?RnVBRGVNdG1id1M1SFZmbmJmQkpzVXJNaU84ZmptOVRMUVptbVl6TU42RnMy?=
 =?utf-8?B?TGpPOFhEaEszNVJUZWpNNWxXd2tmeDRKS2l6OWYzdHZwRmRmcGhCbldFN21U?=
 =?utf-8?B?aDlyaWNJcVdNblA0MElwcituM1dZeW5odVE1cHgyMnR3ajNKb3RjV3pkWmQ1?=
 =?utf-8?B?NTdhemR6R1BobTNQUTVHR2hkS0ZhNHdtWUF2SFBidldSTVRzTG1rNnhWUkZJ?=
 =?utf-8?B?cldUa3dzSFZEY05MNFNiZC8remNOTzRCYzV3MWQ0OExHL3BtMFBZRm1SdkdL?=
 =?utf-8?B?M2hlWlkxVTVYQ05zd1dBeTF4cjRxU29DTnpidmlGTzA0T1BoVDdKVTI3WEh1?=
 =?utf-8?B?MUFobFZwenZ6MFVmY01rN29vdGdkMjFCOUtUd00xKzEwWWFmRWNoeG81RzRX?=
 =?utf-8?B?Tk1YZEk4b3czMHYzSVEzRUNSbjU0NEdLZmZQbDJHRFA3eVNjUFFQcVlwc09B?=
 =?utf-8?B?WWp6ZlRaWmVvc0JVbFRUejQ3UEtxczI4OVFoOW1tQUh5Y2FKVXFoTmt0MDNi?=
 =?utf-8?B?eDhTeWI4NEFxZzA3d3JId09GcTYwTW16VzhUOGx0Q2NzVnJxUXJIdVpweEs3?=
 =?utf-8?B?TFVBWmxxZHE4MSs2OXNUZE9IclZsYXZPdWlGc1Y3WE93NlRNY01yU1dxUkVm?=
 =?utf-8?B?VmhMM1pOaVBTQlF0bFRoWDhHcjJvUVZ2SDdCUHd3UFozeVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3hOSCtNNWQ3ZUg1QnZQY2RHVzMzYkg0S0NzeXdjdjBkTUF4b0dFUDVRdzlq?=
 =?utf-8?B?a0FtMXRaem0xUUx6S3F1dkhnbjQ0cFZhVW1kaXJMZjJkTFludVRYNkhUeU1a?=
 =?utf-8?B?bmpkbExHN3dTaGtYOUVsU1NwcGozS0lBc05VcU1UQkJjUVAwUVducXh1a1JU?=
 =?utf-8?B?MzI1VmphSlJXY1NVZHhTZ1hQdXhIdkVvTHNBL3ZYUDVOZ0FUcHY3NG9paHlF?=
 =?utf-8?B?eU4xanJlcGhpMXFFdTZ4VHBxTjZUTTN4aU5JRWt5OUNwSThzSEc4TmoxU01j?=
 =?utf-8?B?Mi9CYXFodTNTVDNndmlmU21yaTBGdnJEZDFVazR4MUNjQk44ZThOOWlOc3dJ?=
 =?utf-8?B?anY3UDJJRUxIeHRTWW9UeUI3UUlyTjVTRUNRblVTQVZtY2U0QUpnb1hmVG04?=
 =?utf-8?B?OGZKU0pkc3R6NWJaNFZ2aEdjd1JwcWtRdDBhclZrOEY0eDN0T1BrY2g4K2xV?=
 =?utf-8?B?N0hZUUNhaFNDYWtLYS95YUxGOEFTV1dldi9kdHZlaVorWkVUNDByWWR6ZE5U?=
 =?utf-8?B?VnBReXplaDZ3NHU3M2xWQzZNZlZTZnJXcWNnZHIxV1JUNm9tTnYzYjR3Y3h3?=
 =?utf-8?B?WStSaGdFTDJlYWN0NDF6ZUg1ODJLbFl2YklRRWc0ZkpLVUEva3NGWHdtNThM?=
 =?utf-8?B?Y3hlUEtTUm1NNjk4RjF6WWtPbnlzL2NhWVpLWnNUelJMYXBkWkQvSHNTV3Aw?=
 =?utf-8?B?aDJQVFI3cXJIaldseWF3UTFCdjFGN1owUFQrSW9TM3hSMEtpUUlmZzdkYlpj?=
 =?utf-8?B?RzlQZU9RcTROcmMvMGlxZFl0R09GWTltaWJxekRINE1rZmlPWFpjR2hnSzcv?=
 =?utf-8?B?d2c2QnViYkVPS2xCRDRhYlZlQzJVV1FXc0ovWlpWODFXMyszMjZXblBQaE5X?=
 =?utf-8?B?TDJ3bThZVXdsOTVkU1NUUlE2SWZpbWpBYWJiZ1dOdmdnZlJ6dG9jQ3J3Rlo5?=
 =?utf-8?B?NDZIZ01aNHp3b3VpV0c3VWN4QkN4VUVKK0V5a0JWMXZTQ0IwRUVsd1ExbEtZ?=
 =?utf-8?B?Q2pzck9xTGNpeDMrNEFGbDdHY1FhV3VteVlkL0lCdVRDckd4MzlJenJOZVFM?=
 =?utf-8?B?TGpTeDZFWHczUzRQUHNHLytPa3Y5RklQeHZhRXF6YnNmMW0xc01zYWZadXFQ?=
 =?utf-8?B?ejgxOHd1dko5ZjFqaUNpRGNBNGtnbFdIMTI2NjFQdE1qV1RVVXg4WktkMU9X?=
 =?utf-8?B?WXJna0h1SUtSdURnd2JFYVVGQnRLdzdhVEo0YUxsRTFoWlVnYmhwK1F3djB1?=
 =?utf-8?B?OVdjNmZ0cjhvSGwwV3ZNRGcrWitIL1pZMENnKzhwaHdMSVFsN0ZtNXBGWFFj?=
 =?utf-8?B?RHMyNDBLZ0JvZVR0SC9oR004NFJ0dklGUXFrSmVMcUhtSTBtbk5XSVpkS2k0?=
 =?utf-8?B?eGlobjNyVWVZUDhhQnQ1Wjg1SVI2RENVTUR0TndXSmNPUmZZM1lsaVZJOUU5?=
 =?utf-8?B?bmp6WVpaNDIrcDFpS3pyNWU4eHdwYjVzKzkzNTZ2c0oyZFY2anhBSUxJRVF1?=
 =?utf-8?B?eHJSYmJ5dlRJb1hoQjZyVVhhV2wwdzAvdm93SjdLbE9QYkpJdFFuRSt5bXps?=
 =?utf-8?B?am5pSGxzZ05rTE4xRWZub0pKTDJ5bEY3VW80VWMrc0JBcnYwbXE1R3FkRld0?=
 =?utf-8?B?NTFUYjdUU013ZVJEaGx3OEFGaEtsQkRpMEN5emZSS0F2Z3dhb1ZnYkJ0dWd0?=
 =?utf-8?B?UDdPQUdsSDJTSFBWTnlYRUkwdll2T1N5Y3JUV3YrdWg0T1dzL0FkbzdCV3VR?=
 =?utf-8?B?NmNNRVhvaWxSb21CL2dmL21wYVpQb3RKaGZRd0RJOTNwREIxSklZYzFjZFh5?=
 =?utf-8?B?ZzVMZ2NLUUFjc0ZsLzdUaENoTVBvK3l2S3NYTFZ0LzJqc3lYcWY2RGlJL2o0?=
 =?utf-8?B?UGMyYWhwQmEzaksrTXpUQWpBWFJ1RzNTYlNTOGxiSDY2MjB0YXAxVkxBZU41?=
 =?utf-8?B?bXJpcXFWcUNmTm9hOEFLRDJKcjRXZXYySjFYeE1pdCtwbVZDSm9aUklBWVNG?=
 =?utf-8?B?NWxGN1U4bDczSHlPUjE1NnorSXY1R3dCTk4vSm56UGUrUFRzRlNlUUNUQlB4?=
 =?utf-8?B?Y3pSdVhjWUVBMjRIYTdsNHBPT3Q5R3R3dEVkQnJGTTNxME9TVjR5QVA1NUsr?=
 =?utf-8?B?MU04dFF4ZVkyN3M5RG8rdDE1SGRHMWtSdHdQTnoxV041b0Q4VHJBVFdCdGhD?=
 =?utf-8?B?dlJmNDh0UFNhUUV2ZHdwWEhaUkJvbXZKZTdlNUlyMFY5RVJBV2VNRWlaL3RX?=
 =?utf-8?B?NHJPaElucjJMb3M3S2NqdExpaXFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F6802DDE517D74A8D39258C806151DB@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bef2ccd-d5f7-4495-0aed-08dcd12eb624
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 00:22:53.3979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ji9He+uTKLCyyJ9K7zxAm3bhZWWzrAghaVgdIjd2j7E99KdnRG8vMPE/JyXdnd5s3UhtxPhJ0ajEkz+5BTxyfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR13MB6277

T24gTW9uLCAyMDI0LTA5LTA5IGF0IDE2OjA2IC0wNzAwLCBPbGVrc2FuZHIgVHltb3NoZW5rbyB3
cm90ZToNCj4gT24gTW9uLCBTZXAgOSwgMjAyNCBhdCAxMDo1NuKAr0FNIFRyb25kIE15a2xlYnVz
dA0KPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIE1vbiwg
MjAyNC0wOS0wOSBhdCAxNjozNiArMDAwMCwgT2xla3NhbmRyIFR5bW9zaGVua28gd3JvdGU6DQo+
ID4gPiA+ID4gbmZzNDFfaW5pdF9jbGllbnRpZCBkb2VzIG5vdCBzaWduYWwgYSBmYWlsdXJlIGNv
bmRpdGlvbiBmcm9tDQo+ID4gPiA+ID4gbmZzNF9wcm9jX2V4Y2hhbmdlX2lkIGFuZCBuZnM0X3By
b2NfY3JlYXRlX3Nlc3Npb24gdG8gYQ0KPiA+ID4gPiA+IGNsaWVudA0KPiA+ID4gPiA+IHdoaWNo
DQo+ID4gPiA+ID4gbWF5DQo+ID4gPiA+ID4gbGVhZCB0byBtb3VudCBzeXNjYWxsIGluZGVmaW5p
dGVseSBibG9ja2VkIGluIHRoZSBmb2xsb3dpbmcNCj4gPiA+ID4gPiBzdGFjaw0KPiA+ID4gDQo+
ID4gPiA+IE5BQ0suIFRoaXMgd2lsbCBicmVhayBhbGwgc29ydHMgb2YgcmVjb3Zlcnkgc2NlbmFy
aW9zLCBiZWNhdXNlDQo+ID4gPiA+IGl0DQo+ID4gPiA+IGRvZXNuJ3QgZGlzdGluZ3Vpc2ggYmV0
d2VlbiBhbiBpbml0aWFsICdtb3VudCcgYW5kIGEgc2VydmVyDQo+ID4gPiA+IHJlYm9vdA0KPiA+
ID4gPiByZWNvdmVyeSBzaXR1YXRpb24uDQo+ID4gPiA+IEV2ZW4gaW4gdGhlIGNhc2Ugd2hlcmUg
d2UgYXJlIGluIHRoZSBpbml0aWFsIG1vdW50LCBpdCBhbHNvDQo+ID4gPiA+IGRvZXNuJ3QNCj4g
PiA+ID4gZGlzdGluZ3Vpc2ggYmV0d2VlbiB0cmFuc2llbnQgZXJyb3JzIHN1Y2ggYXMgTkZTNEVS
Ul9ERUxBWSBvcg0KPiA+ID4gPiByZWJvb3QNCj4gPiA+ID4gZXJyb3JzIHN1Y2ggYXMgTkZTNEVS
Ul9TVEFMRV9DTElFTlRJRCwgZXRjLg0KPiA+ID4gDQo+ID4gPiA+IEV4YWN0bHkgd2hhdCBpcyB0
aGUgc2NlbmFyaW8gdGhhdCBpcyBjYXVzaW5nIHlvdXIgaGFuZz8gTGV0J3MNCj4gPiA+ID4gdHJ5
DQo+ID4gPiA+IHRvDQo+ID4gPiA+IGFkZHJlc3MgdGhhdCB3aXRoIGEgbW9yZSB0YXJnZXRlZCBm
aXguDQo+ID4gPiANCj4gPiA+IFRoZSBzY2VuYXJpbyBpcyBhcyBmb2xsb3dzOiB0aGVyZSBhcmUg
c2V2ZXJhbCBORlMgc2VydmVycyBhbmQNCj4gPiA+IHNldmVyYWwNCj4gPiA+IHByb2R1Y3Rpb24g
bWFjaGluZXMgd2l0aCBtdWx0aXBsZSBORlMgbW91bnRzLiBUaGlzIGlzIGENCj4gPiA+IGNvbnRh
aW5lcml6ZWQNCj4gPiA+IG11bHRpLXRlbm5hbnQgd29ya2Zsb3cgc28gZXZlcnkgdGVubmFudCBn
ZXRzIGl0cyBvd24gTkZTIG1vdW50IHRvDQo+ID4gPiBhY2Nlc3MgdGhlaXINCj4gPiA+IGRhdGEu
IEF0IHNvbWUgcG9pbnQgbmZzNDFfaW5pdF9jbGllbnRpZCBmYWlscyBpbiB0aGUgaW5pdGlhbA0K
PiA+ID4gbW91bnQubmZzIGNhbGwNCj4gPiA+IGFuZCBhbGwgc3Vic2VxdWVudCBtb3VudC5uZnMg
Y2FsbHMganVzdCBoYW5nIGluDQo+ID4gPiBuZnNfd2FpdF9jbGllbnRfaW5pdF9jb21wbGV0ZQ0K
PiA+ID4gdW50aWwgdGhlIG9yaWdpbmFsIG9uZSwgd2hlcmUgbmZzNF9wcm9jX2V4Y2hhbmdlX2lk
IGhhcyBmYWlsZWQsDQo+ID4gPiBpcw0KPiA+ID4ga2lsbGVkLg0KPiA+ID4gDQo+ID4gPiBUaGUg
Y2F1c2Ugb2YgdGhlIG5mczQxX2luaXRfY2xpZW50aWQgZmFpbHVyZSBpbiB0aGUgcHJvZHVjdGlv
bg0KPiA+ID4gY2FzZQ0KPiA+ID4gaXMgYSB0aW1lb3V0Lg0KPiA+ID4gVGhlIGZvbGxvd2luZyBl
cnJvciBtZXNzYWdlIGlzIG9ic2VydmVkIGluIGxvZ3M6DQo+ID4gPiDCoCBORlM6IHN0YXRlIG1h
bmFnZXI6IGxlYXNlIGV4cGlyZWQgZmFpbGVkIG9uIE5GU3Y0IHNlcnZlciA8aXA+DQo+ID4gPiB3
aXRoDQo+ID4gPiBlcnJvciAxMTANCj4gPiA+IA0KPiA+IA0KPiA+IEhvdyBhYm91dCBzb21ldGhp
bmcgbGlrZSB0aGUgZm9sbG93aW5nIGZpeCB0aGVuPw0KPiA+IDg8LS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiBGcm9tIGViNDAyYjQ4OWJiMGQwYWRh
MWEzZGQ5MTAxZDRkN2UxOTM0MDJlNDYgTW9uIFNlcCAxNyAwMDowMDowMA0KPiA+IDIwMDENCj4g
PiBNZXNzYWdlLUlEOg0KPiA+IDxlYjQwMmI0ODliYjBkMGFkYTFhM2RkOTEwMWQ0ZDdlMTkzNDAy
ZTQ2LjE3MjU5MDQ0NzEuZ2l0LnRyb25kLm15a2wNCj4gPiBlYnVzdEBoYW1tZXJzcGFjZS5jb20+
DQo+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tPg0KPiA+IERhdGU6IE1vbiwgOSBTZXAgMjAyNCAxMzo0NzowNyAtMDQwMA0KPiA+IFN1Ympl
Y3Q6IFtQQVRDSF0gTkZTdjQ6IEZhaWwgbW91bnRzIGlmIHRoZSBsZWFzZSBzZXR1cCB0aW1lcyBv
dXQNCj4gPiANCj4gPiBJZiB0aGUgc2VydmVyIGlzIGRvd24gd2hlbiB0aGUgY2xpZW50IGlzIHRy
eWluZyB0byBtb3VudCwgc28gdGhhdA0KPiA+IHRoZQ0KPiA+IGNhbGxzIHRvIGV4Y2hhbmdlX2lk
IG9yIGNyZWF0ZV9zZXNzaW9uIGZhaWwsIHRoZW4gd2Ugc2hvdWxkIGFsbG93DQo+ID4gdGhlDQo+
ID4gbW91bnQgc3lzdGVtIGNhbGwgdG8gZmFpbCByYXRoZXIgdGhhbiBoYW5nIGFuZCBibG9jayBv
dGhlcg0KPiA+IG1vdW50L3Vtb3VudA0KPiA+IGNhbGxzLg0KPiA+IA0KPiA+IFJlcG9ydGVkLWJ5
OiBPbGVrc2FuZHIgVHltb3NoZW5rbyA8b3Z0QGdvb2dsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+
IC0tLQ0KPiA+IMKgZnMvbmZzL25mczRzdGF0ZS5jIHwgNiArKysrKysNCj4gPiDCoDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25m
czRzdGF0ZS5jIGIvZnMvbmZzL25mczRzdGF0ZS5jDQo+ID4gaW5kZXggMzBhYmExZGVkYWJhLi41
OWRjZGY5YmM3YjQgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvbmZzL25mczRzdGF0ZS5jDQo+ID4gKysr
IGIvZnMvbmZzL25mczRzdGF0ZS5jDQo+ID4gQEAgLTIwMjQsNiArMjAyNCwxMiBAQCBzdGF0aWMg
aW50DQo+ID4gbmZzNF9oYW5kbGVfcmVjbGFpbV9sZWFzZV9lcnJvcihzdHJ1Y3QgbmZzX2NsaWVu
dCAqY2xwLCBpbnQgc3RhdHVzKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBu
ZnNfbWFya19jbGllbnRfcmVhZHkoY2xwLCAtRVBFUk0pOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjbGVhcl9iaXQoTkZTNENMTlRfTEVBU0VfQ09ORklSTSwgJmNscC0+Y2xf
c3RhdGUpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVQRVJN
Ow0KPiA+ICvCoMKgwqDCoMKgwqAgY2FzZSAtRVRJTUVET1VUOg0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChjbHAtPmNsX2NvbnNfc3RhdGUgPT0gTkZTX0NTX1NFU1NJT05f
SU5JVElORykgew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBuZnNfbWFya19jbGllbnRfcmVhZHkoY2xwLCAtRUlPKTsNCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU87DQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGZhbGx0aHJvdWdoOw0KPiA+IMKgwqDCoMKgwqDCoMKgIGNhc2UgLUVBQ0NFUzoNCj4gPiDC
oMKgwqDCoMKgwqDCoCBjYXNlIC1ORlM0RVJSX0RFTEFZOg0KPiA+IMKgwqDCoMKgwqDCoMKgIGNh
c2UgLUVBR0FJTjoNCj4gPiAtLQ0KPiANCj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgaXNzdWUgaW4g
bXkgc2ltdWxhdGVkIGVudmlyb25tZW50LiBFVElNRURPVVQgaXMNCj4gdGhlIGVycm9yIGNvZGUg
dGhhdA0KPiB3YXMgb2JzZXJ2ZWQgaW4gdGhlIHByb2R1Y3Rpb24gZW52IGJ1dCBJIGd1ZXNzIGl0
J3Mgbm90IHRoZSBvbmx5DQo+IHBvc3NpYmxlIG9uZS4gV291bGQgaXQgbWFrZQ0KPiBzZW5zZSB0
byBoYW5kbGUgYWxsIGVycm9yIGNvbmRpdGlvbnMgaW4gdGhlIE5GU19DU19TRVNTSU9OX0lOSVRJ
TkcNCj4gc3RhdGUgb3IgYXJlIHRoZXJlDQo+IHNvbWUgb3RoZXJzIHRoYXQgYXJlIHJlY292ZXJh
YmxlPw0KPiANCg0KVGhlIG9ubHkgb3RoZXIgb25lIHRoYXQgSSdtIHRoaW5raW5nIG1pZ2h0IHdh
bnQgdG8gYmUgdHJlYXRlZCBzaW1pbGFybHkNCmlzIHRoZSBhYm92ZSBFQUNDRVMgZXJyb3IuIFRo
YXQncyBiZWNhdXNlIHRoYXQgaXMgb25seSByZXR1cm5lZCBpZg0KdGhlcmUgaXMgYSBwcm9ibGVt
IHdpdGggeW91ciBSUENTRUNfR1NTL2tyYjUgY3JlZGVudGlhbC4gSSB3YXMgdGhpbmtpbmcNCm9m
IGNoYW5naW5nIHRoYXQgb25lIHRvbyBpbiB0aGUgc2FtZSBwYXRjaCwgYnV0IGNhbWUgdG8gdGhl
IGNvbmNsdXNpb24NCml0IHdvdWxkIGJlIGJldHRlciB0byB0cmVhdCB0aGUgdHdvIGlzc3VlcyB3
aXRoIHNlcGFyYXRlIGZpeGVzLg0KDQpUaGUgb3RoZXIgZXJyb3IgY29uZGl0aW9ucyBhcmUgYWxs
IHN1cHBvc2VkIHRvIGJlIHRyYW5zaWVudCBORlMgbGV2ZWwNCmVycm9ycy4gVGhleSBzaG91bGQg
bm90IGJlIHRyZWF0ZWQgYXMgZmF0YWwuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K

