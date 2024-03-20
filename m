Return-Path: <linux-nfs+bounces-2419-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32078814E7
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 16:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97ABC281CDF
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 15:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D76D53E13;
	Wed, 20 Mar 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="TdtGZlRD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60653E09
	for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949845; cv=fail; b=S3rpV3NDr8CHZKhI3QZf+3rabtb4OCO22h4aHgbJPAe5m/oM7pYHADK03WNzkhdSYj4HeEU5bB31jVudhWqGatPRpw0/vT64sHwS71g0ctmJ/JyXYxRZPQyhwpx1RfSKsNMuWZSdSmvV3ZOXdj3SGcWe/WQmgQw2K8RG3q2/ayg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949845; c=relaxed/simple;
	bh=y0hZh00VAe83JuT6it3QaHxghzvFWgpM4j6Dzealyto=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KKqjncp7Htdyw6I7X60C8qlWBvVjvTCoGOmcxwET3mbnukk7X8GgjOUO39iRiNBvo/McPPM4sSRFYYSs/Ue5c8ROHtql4QbXkAkR0p5ow5r7MujoRyw7JXwuwLPSbDWFXCU5GtBd0VLDmx4X63e/uB2LYvEvBlSM+8awX0JXFMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=TdtGZlRD; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1710949842; x=1742485842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y0hZh00VAe83JuT6it3QaHxghzvFWgpM4j6Dzealyto=;
  b=TdtGZlRDN8bZCZtHnOaJh/UkcrUk3Gnpt9kMy5TZfCOfiLprdC9B2x7C
   QDYcz92I39GPW0QRa8pDFGvcqRdrZ43UjMmz62ln9TKA01ubockf2ZxRI
   01zt5LhT9UT1K+rddVtRmwAq3Bao1XWyPNuQPQyg6YvFXF14YBYf68u7K
   eicmsk7Ra9x3guO/CLcnaQhlx4r6YnvAIQCUbk3bMvZW+5DwsK0nyMYxX
   4VqIu/mMrQS1JnHSEi6W/zmz9dZEnp6ppPkoFr9rOsj9cYsPxKMBLFiZb
   Yp3fh2REGHipRuE2eoa+q9oz9Pq53KWOBV7ORRPClhnXmp82IxqjD+qba
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="114554946"
X-IronPort-AV: E=Sophos;i="6.07,140,1708354800"; 
   d="scan'208";a="114554946"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 00:49:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLCU+cIEgBfrL4St7/ZXYrGN7SjdDGhWJW/qEuBPylbLOBPbdaPN59gzVRIl3U9oeyu2s5OtAuLdY7tzLUuzUKu77o2DkEc2qh9oAMNQz/SAw0h/UcV9MQkCwC1CioNtFBO0YG7uDOCB0yatDvLiOuME+S6VFVVMLuFGPiY16/R8Oz80MOErQ8Za+i50u4Yerl7acXxGFrsuDR3xdyos3O16nW89Gcfg71R9l3Pf44yTsT/bY49Tg00TkzYcyfHDhepxc2PmfOTtAaqt5THRZkfGMQWnWPj7woQDalCxwE5aUFYUteesPh1vGyuqbGxiJ4PKdNJBnvsfjOll8UZDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0hZh00VAe83JuT6it3QaHxghzvFWgpM4j6Dzealyto=;
 b=hDNHKlN7Q+viW3aRs1A+qWjAzcIN/nwK5uCsvwBvDqaZDa31IKgSzY4AdoG24d5GxSCoeuFkyhPDhYcbpG9iDLJbiF7TAiSPGnc5QffuJ0UlqYFIDAZJwhS45a3SKS6cxbZJJ4mQoLy9KzcvxY4dwOxaoZ6HBNm7qnE1O0jm/goFdtOUKPjPB7F0TOiA1YK/Kcey8ApwZ2pVhCkjzNrolTqmWQExpiu3wy1kbREL31/hrbuQRzWO22MXswJNHnSteyrk+2/O0fbtIab5gj5mhjmbYQcCVFnrEEWXNYjy2j161zYF+0tLLpozJe22HzUkp8cKa1WZTUmUSWXa/Y0pCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYBPR01MB5454.jpnprd01.prod.outlook.com (2603:1096:404:801d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 20 Mar
 2024 15:49:26 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485%6]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 15:49:26 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: nfsctl: remove read permission of filehandle
Thread-Topic: [PATCH] NFSD: nfsctl: remove read permission of filehandle
Thread-Index: AQHaeertD882miJTuEWuCdVzqjxc4rE/CW8AgAG/GNA=
Date: Wed, 20 Mar 2024 15:49:26 +0000
Message-ID:
 <TYWPR01MB1208550A963443FA4F3FC5335E6332@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240319104714.1178-1-chenhx.fnst@fujitsu.com>
 <3dc4e3e0a730795bb803ce4cde66b45ed428765a.camel@kernel.org>
In-Reply-To: <3dc4e3e0a730795bb803ce4cde66b45ed428765a.camel@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=1072b34a-1c2c-4667-afc5-b788a242000a;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-03-20T15:43:13Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYBPR01MB5454:EE_
x-ms-office365-filtering-correlation-id: 9bd88c5a-6e06-44ab-28b9-08dc48f55253
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 u04G539BFyA3wbLYymfUaDeNUA9pshfBm4E/9a5L8ID9tmUd0rrdpgvPnwc6Z02wGmGfaQv0JtmFtX1DAo4uymb94efJm3bAUHIpVN9gpjftXtQoRpWqun3HtPyJlTT9cCYC9eBW4tCVmkljfZQxMOvmQ+q6iJvU7nXrYKuWlIrAaKyr26c0zeU7hZJXzzfohHOgf3FFqRKMsjjbCHvR2FQAviiKolHkg2V/d9cULQgeITNuQ6ZElsQXvP9nYiAmN8yYe81P8yCGs06I2V/hgbTx798muh15d5ulUGf2df9GTVUh4PvCaKx6sewKAmx9ZgGdJpI9bwUNzHcvxiU82n1/T+LUZ6MLqnTKTl82SmI8tdqvakHKtyWc0AV1w2lA5OWLGqJ+0BJ7YWmTGUmTwdSVVDyZpY+Wq6KYZEq0oehej2bl6kfqr2XzgvF9xQjL7jU3OI2UHVao3YqYNzewaA7idwKg6dRhHzVUVe9ipTw9obCX3lxYaSmGNJBIXo9eKPE23g3jTeQVWWueiaZnfObwMuVu9q45ssffL5ithPchWuVQUQpL0mOLHiopJ3YXbEw2NPz/ichxZBZHaUWkwZxKq5KI3Ixz1hvVUlfCCi8dUNvGJxaz7omUdq6pX1PghRcFLF4KA5kVw/++yCH4hZvLmvOVjICFO+pwD1TnHrkRPlpJ1qoHk2mSVYhXblr3JViguFmtHKzBhrarbnepHi6xMxt70IvWd2UgO88kGojFAxSg7jKKTW8vQuoqBiCP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WFp2bW5MMUgzRDdoeTg3akpuZncweGhsZXYzc0JVc1pZcjNkeUorYzNQVXF2?=
 =?gb2312?B?eHljb3ZaR0JaSitacFhneTduQU1aYUp0QnFsRXlZNkFRbCs2d3h2VHZONmsw?=
 =?gb2312?B?L3YzQjgyL3Nick0wc3NqWndsb2J5UzJwWmR6QnFKblNBeGdCaXVoQ0RENnpR?=
 =?gb2312?B?d1JhZU1RZXRrRUtMWUFYSWpod3VZTWxsNHhvVDAxWGhxcjY1S2pkR3p6QkJp?=
 =?gb2312?B?MHJISG85Ym9WUENXR1Q3Y1hJNHZxR0Qyc0kwQU43Rk83L3ZERkMzVWlmNlp0?=
 =?gb2312?B?cUpiZ2pzU0txMit4WlIyR2xYWDN0KzI0Z1F1OGltVVNMdHdJbGRTdUJUODBl?=
 =?gb2312?B?VW82QzU0d2RDY0JHOVR6WnQyZzhNSXRWeWdqRUdNZkpxbTZnT1ord2FyNldj?=
 =?gb2312?B?K2lSb1A5YVlXWFRQeldibEJuTnpaMWxDcnQ0TGZ5YnJiYSs0M2hKVDZlc1da?=
 =?gb2312?B?UkNDNWJPa0RYWThMNTVORFFSeEpoNzNhZHdSR1B2QVFNQURVcVdPeWpzZmk4?=
 =?gb2312?B?NE90cmNjV3FlTHRzMzNJUExrQmhXZ3k0ZGlpeFJCVjVOaitpRkJSem9Heisw?=
 =?gb2312?B?RmtDTEUybVNKRnJGb0xiSVNaRWRVb3Ruc2h0WDI0dFBVOHZ0aW94Z2xaZWR1?=
 =?gb2312?B?cVU1andXVXVndW9Ba1NJR3VhdzNZVE5JU3ZlR0o2R2tWVHVxT1NQWEZTTGdK?=
 =?gb2312?B?eFVqUkFKekN3eFZtaXg2bzhZYjFUczgraEp6eWovMW04L2NQdjdoeEJHRWdz?=
 =?gb2312?B?cXowRXk5aVN4Q3kyYktBY1dkUEg1SXl5cjVKRzQyZjAzZnk5bW81MDE1cHJu?=
 =?gb2312?B?Vk82b0NwTGtBZE9nUVU4UURCdUNnQnBrd00yaEZ3S3pmQ0JRd2laVS93eXdi?=
 =?gb2312?B?eU5ybGpHTmQ2VTNPcTFCeExFa0NxQndPVTNVbE8vTit5a3dZbFNZUXlMS3Iy?=
 =?gb2312?B?d2lVblE4WURpR2xZM29HMXViVmVUZDFnSHVET0doN2p6anlzZkNlMVYyamd3?=
 =?gb2312?B?ZEh4eG1FSGRPVHZjRS8yS2NlSThzQ004MXVFckFtb2M0N3EyQ1VES0Z1Tzg5?=
 =?gb2312?B?UVlDdXJkZXZrMmkxaGVzVWxtdHp0TWhvSmpQMzM5eTlqRjZWbkI5TWIva0VL?=
 =?gb2312?B?elNGcEMrS1oxK2UvejR5TGJxbFF0SUJnZGFBTlhodkZzaTBBeHp5dlI4RGtt?=
 =?gb2312?B?ekMxOGhZRHpmTy83WXVCYUhyZVo0MkZaMFBaZHNDdWhLWTlpZjRNd0QwckQr?=
 =?gb2312?B?VndCK2RVMko1VTV5bmZYczNIMk51UCs2RTE0dVAxamlROWpaZHE3dm9OZ3FS?=
 =?gb2312?B?djdjTVcrVXJscWNWQjZvR0dFVXFMNU1iS1RqaW4xT0d3Q09rb1N5c2liSjVa?=
 =?gb2312?B?TWNsSmY1REJKcW9PcEZFOHFyT3Rxb2IxaHhSWDViVWxnVWliNm54QVBOdlRJ?=
 =?gb2312?B?Y1dwT1FFLzVKMXJMVWo5OVFjbW5OekhCTHJCWXdSeU5XZ3R3OE1KUW1ZWEpJ?=
 =?gb2312?B?ejhkMTFyNWhsZFFMdUZIVG9SRnlibm1UdER2dTRGRHRsY1VpZit1aFVId0FM?=
 =?gb2312?B?UFVkQ29nNTNRTm5tOVE2OUlqWVQxRFA1M2dQVk5ienlrSi9qR0ZQOHQ1dm13?=
 =?gb2312?B?eGQrc1RRd3c5Sm5raER3N3R0NTZrdnFNbWFIS0FxNXBHMXFJdTVoNXRDVkZy?=
 =?gb2312?B?K09PSE03aWd6dUVSSEhxN2puZjBvWUFpV2YwWDZEMXBJRmdoWXBxNHByV0dB?=
 =?gb2312?B?L1RsVjJCVGFUbzFGa3o1K3lOdk5tOTZndnozUEpVOWZReE8xMGpPSEtBSjZV?=
 =?gb2312?B?dUVlRWNMejZSS1pUMUtSQXFDNnFwSEVyOEVBWjVZTnhrUTBtSlljUkZrZFZP?=
 =?gb2312?B?WU9JTzg3YWZ5b2lyVzE1SGJjaWpjRFgrNU1jK0pBWXhpakNaL280bnlESWJR?=
 =?gb2312?B?ckVJZHU4QW1qNG1NK3ZWUlBBS1M2dXFOLzNrV3RoZmN3S0VJZ0dxQjIwZkhG?=
 =?gb2312?B?SmgwL2phaUsyRnJwT1h5TE9DNWpCNm1XVFMzbGJQbElNaE02N3F5TmtwbVVi?=
 =?gb2312?B?UnpRZnFwZlRZYnkvVjhFRitDUmM2OHlNSCtRVGRza0VYQTVURXFCbzZJQ1My?=
 =?gb2312?Q?Hd2/gVOTbd4KMGXJxU42cGeGZ?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aUT88RKG4nUBY+89iX55Ur75agTh0VoYwV8+iLLsuCDJm6zLmTxXFOBbEPnKvPWm6UejTYzwdZX7bpf7jsS4nJYuHCEfqu0GeT7Lu293mNDN8Pa06/7viqmtH0YpsAx7zp3JXk1FULyjcN29u1UBBpXOhmpcsFHI6z8ZcYcj4tvpw7PQK6/6KW3dNIFlDDTGeJWFC4Ql3zePxWbWvGRnf9/9TS2xjSqrte0edmRQAuTXjzgDOxoCRgRNcFktJJkDMXnIvjvG/PLmP8waCYiHehLXm/vMm/TLzRCaqUT3GgGmtHWLx59fezaFyuWWZolnbqMEYFcNq/ng4JZBP+sHNtJC2oByQbzFEDogt/hnCA2a8fLZ0oQv/f4Zpb5z/F4ADJbNY6F69VDYTTsj1fkdMEh4PBxm0G4HUzkbNWr5k9ROYe5XIaf9w6CCZXTiMV6CPgYP/8N913+bLWfcWEmD9iGO5F7luK68aT3Jw0qx6cwmdXLhqBsjCfxQYX/+DPPTadoh23MPU5NTK0jZKnG9pdBzX1aRLYPEf0HGBtFH5X1TwYBsq1Siogz827cuVIpT3fack6JkgCWbZoCzJMsXoVQgSj0kq9sKyy2SVrUapom+9EKJVRIeYpKdeyFJ8fiT
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd88c5a-6e06-44ab-28b9-08dc48f55253
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 15:49:26.4593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2HET06drDgKjqmSjE+GjMdM9GqZ15g5PjThPPYREa1Qj0S7VPUQDYmNFBMtKrGDDxjNdhh+zr2qqofuYWws1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5454

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogSmVmZiBMYXl0b24gPGpsYXl0b25A
a2VybmVsLm9yZz4NCj4gt6LLzcqxvOQ6IDIwMjTE6jPUwjE5yNUgMjE6MDkNCj4gytW8/sjLOiBD
aGVuLCBIYW54aWFvY2hlbmh4LmZuc3RAZnVqaXRzdS5jb20+OyBDaHVjayBMZXZlcg0KPiA8Y2h1
Y2subGV2ZXJAb3JhY2xlLmNvbT47IE5laWwgQnJvd24gPG5laWxiQHN1c2UuZGU+OyBPbGdhIEtv
cm5pZXZza2FpYQ0KPiA8a29sZ2FAbmV0YXBwLmNvbT47IERhaSBOZ28gPERhaS5OZ29Ab3JhY2xl
LmNvbT47IFRvbSBUYWxwZXkNCj4gPHRvbUB0YWxwZXkuY29tPg0KPiCzrcvNOiBsaW51eC1uZnNA
dmdlci5rZXJuZWwub3JnDQo+INb3zOI6IFJlOiBbUEFUQ0hdIE5GU0Q6IG5mc2N0bDogcmVtb3Zl
IHJlYWQgcGVybWlzc2lvbiBvZiBmaWxlaGFuZGxlDQo+IA0KPiBPbiBUdWUsIDIwMjQtMDMtMTkg
YXQgMTg6NDcgKzA4MDAsIENoZW4gSGFueGlhbyB3cm90ZToNCj4gPiBBcyB3cml0ZV9maWxlaGFu
ZGxlIGNhbid0IGFjY2VwdCB6ZXJvLWJ5dGVzIHdyaXR0aW5nLA0KPiA+IHJlbW92ZSByZWFkIHBl
cm1pc3Npb24gb2YgL3Byb2MvZnMvbmZzZC9maWxlaGFuZGxlDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBDaGVuIEhhbnhpYW8gPGNoZW5oeC5mbnN0QGZ1aml0c3UuY29tPg0KLi4uDQo+IA0KPiAN
Cj4gSSBkb24ndCB0aGluayB3ZSBjYW4gZG8gdGhpcy4gbW91bnRkIGRvZXMgdGhpcyB0byBnZXQg
dGhlIHJvb3RmaCBmb3IgYW4NCj4gZXhwb3J0ZWQgZnMgYW5kIGl0J2xsIHByb2JhYmx5IHN0YXJ0
IGZhaWxpbmcgaWYgaXQgY2FuJ3Qgb3BlbiB0aGF0IGZpbGUNCj4gZm9yIHJlYWQ6DQo+IA0KPiAg
ICAgZiA9IG9wZW4oIi9wcm9jL2ZzL25mc2QvZmlsZWhhbmRsZSIsIE9fUkRXUik7DQo+IA0KPiBU
aGF0IHdyaXRlX2ZpbGVoYW5kbGUgaW50ZXJmYWNlIHN1cmUgaXMgd2VpcmQgdGhvdWdoLiBDb3Vs
ZCB3ZSBnZXQgcmlkDQo+IG9mIGl0IGJ5IHRlYWNoaW5nIGNhY2hlX2dldF9maWxlaGFuZGxlIGhv
dyB0byB1c2UgbmFtZV90b19oYW5kbGVfYXQNCj4gaW5zdGVhZD8gVGhhdCB3b3VsZCBiZSBhIGxv
dCBjbGVhbmVyIGFuZCB3b3VsZCBnZXQgcmlkIG9mIHlldCBhbm90aGVyDQo+IGRlcGVuZGVuY3kg
b24gL3Byb2MvZnMvbmZzZC4NCg0KbmFtZV90b19oYW5kbGVfYXQgcmV0dXJuIHN0cnVjdCBmaWxl
X2hhbmRsZQ0KY2FjaGVfZ2V0X2ZpbGVoYW5kbGUgcmV0dXJuIGhleGVkIHN0cnVjdCBrbmZzZF9m
aA0KDQpDb3VsZCB5b3UgcGxlYXNlIGdpdmUgc29tZSBoaW50cyBvbiBob3cgdG8gY29udmVydCBm
cm9tIGZpbGVfaGFuZGxlLiBmX2hhbmRsZSB0byBrbmZzZF9maC5maF9yYXc/DQoNClJlZ2FyZHMs
DQotIENoZW4NCg0KDQoNCj4gLS0NCj4gSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4N
Cg==

