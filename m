Return-Path: <linux-nfs+bounces-15057-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 291A7BC61F7
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 19:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 630414EBD90
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 17:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C8D246782;
	Wed,  8 Oct 2025 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="lWAWhSpi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021122.outbound.protection.outlook.com [40.93.194.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5E20E030
	for <linux-nfs@vger.kernel.org>; Wed,  8 Oct 2025 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759943390; cv=fail; b=ui20xQt0a6qDxZC8WhxrVJT2fSaOZhalJqASTbSUAOc3lQUgIwTjHLKKgiEIex/fc2FjQ2ZpiVWbm2mHh99C88JlU0cgVk8gDEPx8ydUEyLB4dpBMllOIeV6y+fwuxqzgNupbtNpQcNpXt8axJSSqPVFnVOP3mzLKXXH0453T3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759943390; c=relaxed/simple;
	bh=iSRXgDG0qUDSsbneUDC4XIm9LIqNoHionolsaqQUDPE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pX/J7FDCfAJPsW/CS9toAz3wpVc5appM/mfe9DvCKME3WctufdGPGuZ4hlabbr2aUkqYZJr7oG7v0U/MoVQAeZSv0ehDmggmmXuyjgdjHRIq14MG/F/9tfV7hChtm1LQxwlaMaQrGlVPyIG8DIvmNW+4A02SSEnTMTgNupf2Haw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=lWAWhSpi; arc=fail smtp.client-ip=40.93.194.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPIIoyMxA5dhqIpYLVFlX71JvH5s86jMRtJQoX70oNUh1Sr/Rvd65EEn0es5VA84bWH/vEOFkzr8HgPWGweNtmlusZfE9b9tP0wDvtA2SpEfnU5tgiFIMnV0Wv5gf1IcmcIzcwT4dii2Srfd0eREciX9PNRWpWelkPI2mSjY8ohLYc732Q4n6dUR3fzKm+ZmQbIcpg4ZfMEDMyY/bhDQ9Gw3/r3EP7TtseuyXTAfMOom87Bitnd2hwo7prnfn6H2x1wedhh+WgWOtuVzTQmmLx8yuvIQA6psj4UKVUYKXONic1Y7AV5LnHwROCbk/b7P2EA8mC2WyDr7kfzbPNINlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSRXgDG0qUDSsbneUDC4XIm9LIqNoHionolsaqQUDPE=;
 b=hbQYXp4OsZpuwzb8O157dNVH7BBtC03OF7McIcW0BoVwI7ey9+bAJHTGWiinHAyPZOoFfAgPuJh/tQCLcIpuucOa9dA3Ji5yz+pyzerqQXHSgzy8GbpLmhxgvbb2ztUAoW5h4h9jptWl4JT20AmNrbT1iprm/rvqL0KXvsXPnkTvKnZdrT0lwwfQTWy+vOprlqawU5vz8p5oKl4F31AvsO+zS61HDjff7UwTdzBgV+PORm+FFYuDk0eygwukZbKcX5gAqqFlCUS4Ngmayl/CLQDc43zL5EDEi6KsKcRtiTaAnEckV3+kkabXJ6LcXswB0tHnHY2RWU9A5jypyZ/ZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSRXgDG0qUDSsbneUDC4XIm9LIqNoHionolsaqQUDPE=;
 b=lWAWhSpiucyBfqhTiyVC2ToRy60pXtcGZAK7a/nCpLgNSv0Q37qljXelFZNB2hYkaEjcKq9W8csqKmPCHk6ZdoIgcXWVHdM7CdGIDk+cMcXe8tIHoQrZ5RY390fFYJtFHk19gW7qA8LUYtwsw/6JCGZ+utE8MJmKVUNZkF+1F/bye53zzTdWJtjy6Wn11dCBtwFbgJ6KAI/e3Y3sq4szwaCzcEz1dlMbhRal02zXwyq7bvjYWb8JCO1RDt0wHaTxP21DjJH3zBxUtfHtXllDhzD9daBRo5P9FSzTaYzcA285PTniX0n211Q+y/ZVHhWrOnE6tQSBBHE6eKpZxBfcWQ==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by BN8PR14MB3267.namprd14.prod.outlook.com (2603:10b6:408:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 17:09:42 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 17:09:42 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: Linux Nfs <linux-nfs@vger.kernel.org>
Subject: can gssproxy be used for both cron jobs and normal users?
Thread-Topic: can gssproxy be used for both cron jobs and normal users?
Thread-Index: AQHcOHSp2bRH/rxeCU6w9gGA3nGp6w==
Date: Wed, 8 Oct 2025 17:09:42 +0000
Message-ID:
 <PH0PR14MB5493C920FE1A01075DC59CC8AAE1A@PH0PR14MB5493.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|BN8PR14MB3267:EE_
x-ms-office365-filtering-correlation-id: d29fc6c6-6e34-4cdc-b1df-08de068d78eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?RET2frQOieUB/bLbDY0ysDDBmlkRSmpK2YrcnW5R7uj7k63Wjn4o7pmhpv?=
 =?iso-8859-1?Q?8nv7VStkk8epuVup+kSRzbqKHWS+Xkn1pBbewMwZfHGXp96gpt4eUzTfW7?=
 =?iso-8859-1?Q?hPzKm95JC4zM946Tal8DvSPQ/eb84QEomDGvHKgPczgXluHN23M3MYZrMU?=
 =?iso-8859-1?Q?KwrVmSapNCmb0WaRPCEseSngWZF28LzWYs4Bnv3qbdcP3twXVanV8+sL1D?=
 =?iso-8859-1?Q?2SrERUhCyauB4jRDoZBJaJS6zJsIUgZKdpWurUxSxIVPOQNPM7Jc5DTAdV?=
 =?iso-8859-1?Q?Be2AxkrnOOI5xSPrdUIJVoGK8cn3cI4J1kNyVysfbp5tQ1CpAZwbWyzn5q?=
 =?iso-8859-1?Q?corzROCFg4HmY2VlRMfRa0lKxxqvXtLu+i/qQ21SNRaUgT4rNRQg8uROZl?=
 =?iso-8859-1?Q?F9XqQ6BaiP7N4dDD2yLEVDXrPDY0QrKuSHrchsVVpw3iTaJr3m9bo14BKQ?=
 =?iso-8859-1?Q?BQYEd7k1m82ZDrte4QgabOm5Uu25JI3aRyvDJ8Tv1SHrtOOp/nIU2BNu1E?=
 =?iso-8859-1?Q?zRYLnGCJZDQ/yGjwDc0BYLk8TSO7TvXX8iPrXmUzowM433XhmKxqoqSG+p?=
 =?iso-8859-1?Q?oJyW784GRcZm/7v84BYzAaxggLWHBKfhqT6qMPe4YsFWy39DSfCashBWjh?=
 =?iso-8859-1?Q?HSJ+gyaAEoENndBH8B4bXWNgwJPtYwVRtgTk20aGC73cpQleJ3LtgivBsU?=
 =?iso-8859-1?Q?DLq9mLCCiOwf/QUbOTWVz+Pj9SMo3B0b9jgO72o/18n8ypfnDcDfaZr34e?=
 =?iso-8859-1?Q?JFoxopesIYZa27HCtafVm/XpV99TfCWIWQ5IVAm0ONP0nXDb3uwF8h9Tpq?=
 =?iso-8859-1?Q?EvdSCaTWKiWyCWx3MTHsqEZ3nfpVjN7csfgdQSmjKq4c7UL9vf9JqyZhrH?=
 =?iso-8859-1?Q?B84+wAT76XtLMlD/0KYKRxf1MJ3H1g/cZITQvxu3ZyjR8M0DKD5eQG32/L?=
 =?iso-8859-1?Q?APqOoy8pAmeV+6y8Vpi1AdZweUtj2A50NUaKLXzazSMelO8I0RE27wxk0h?=
 =?iso-8859-1?Q?oRcl3BBx8y/DrROnEFIMRXJao1N1o84Vfuk2stTUfdAs4xSJ1e13JPGTiI?=
 =?iso-8859-1?Q?hlrkiQjRUb3jPe5uPyOcxJjkqKXV5fxfbP2xzcCXYi3eJ1d5IDOyyak9uC?=
 =?iso-8859-1?Q?4XCIN4cvwg6RNIOQkBk8A65xuBHrYs6Ft0eoPtKhSLMNQelrAwceNXT9ON?=
 =?iso-8859-1?Q?dEohUACUD223HW64M9cqRzLtS/YHwggSyF4cp4H9A3YnL/eO59+fGC32Z1?=
 =?iso-8859-1?Q?G4clWbOMe00/0ZQEiIpmo65F250jusETkQwGlu1Y19q3wsEevtrVAs6wKD?=
 =?iso-8859-1?Q?ijm9W1rJ4VR/a3DyvTMjmTyY9gSuYWAhT+cUan6jQhNZ9zfuM24cTGJvIH?=
 =?iso-8859-1?Q?6J5PIfeVV2PnorRajQoaeazAXw7RhNtvLBuIXhhLUrhLuuy8cenDJWKmC7?=
 =?iso-8859-1?Q?Da2ashxRq7ZzEx5d236da+YYatb0pGy9EbkAlj6FRCmel6Yr23mWy1CndT?=
 =?iso-8859-1?Q?MK0HQEtekAp3DdwNVX1sdVq0kUzGG9kp9fL42VWqRBvu9GCuGvIXTQ9bmD?=
 =?iso-8859-1?Q?QTYr8DXFF+hRgrTY69qOkGAT3Rqv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KyfNfti8Ih6rKnms+4HBqWnOhXYkSjNCLVZBWidNqu7wgLLu1z6mjnHG2t?=
 =?iso-8859-1?Q?MKS+Bmd9WnWeJteRgIIuXAHX10pWC1adPI2c3K/rbaJHT77jtOP2phItWA?=
 =?iso-8859-1?Q?2gsJQ0km54SQYuZLHhtpd7Tc5D9ciJHeGt0BzcwTwMq/2IalJrUF0tG+2n?=
 =?iso-8859-1?Q?8Z3fOuqkLMEsabs3RQOc2kCHLenU7YRszh15FAcxrK1MuEZ4YOjSGnNiIV?=
 =?iso-8859-1?Q?kMralq5SqVWyLkXsvNV6vJU9YiM2RSjMOq5ubA7Od7Sf1BuSJZ13r5OCxv?=
 =?iso-8859-1?Q?f06Pt5hbl/n6paD+/jENTuT07Zf7mo4DFmwOGHC+zRwNXyxl7wampT+GaL?=
 =?iso-8859-1?Q?xEWnMKmiLYimeC0jYoBBkXcpDQzvAMMOGjElpHkhtpn6mSclxIBAhS5FfB?=
 =?iso-8859-1?Q?5fqUiBNcI2AhzGK1Xfrk2WM/DxIicbdXZz97zJXXOuYGkR2ZJQWXfCsXG3?=
 =?iso-8859-1?Q?RVNSGyCTDY0bU5gCDKTtWGmFKh0Aw1sCeYCxFye3SXkyhRo5vYUX60mWUS?=
 =?iso-8859-1?Q?/B1Phm1d159T8dIyy3L6LUEXB8Llf07JVqNXPXj10VVC7rbcKBXsys+ibC?=
 =?iso-8859-1?Q?u7FxKcuY6vL59N2TLhQL5+XkwT/1Iug0SVuLCLSJ/pUBGJbXyxNBpafcEA?=
 =?iso-8859-1?Q?ShsSbrwYWYlBPDhd0qOrVETGBGfyC+IYPOLSLWjuUHip+N9xrNnvoLnnPR?=
 =?iso-8859-1?Q?Og6fjeDzMihK71YXik2aYZ5hOZ8IvqbKbvISpFD+3u9FufyztD74Gn5ZGb?=
 =?iso-8859-1?Q?D9EesQDPca2C1jdpskRz64USQRDUsUfmMhUbasLcfuDGeBXWDY2o/Uxf9m?=
 =?iso-8859-1?Q?AJayThS4GyMsWYF1p2jVJWKm7rWTJH4jyecVXw27sKA7FCRddnLacPY/lR?=
 =?iso-8859-1?Q?XeIpyWOp8Pua5CPhPsVaZxsW0iYIbcEV95WgqEqpaOGr5L2EFlkepxtSyI?=
 =?iso-8859-1?Q?Kp+7r2Fg90csEOE/pwrn8CF6LUcec0solZm9Y1J0oqpGfLka0TGhx5+nz/?=
 =?iso-8859-1?Q?ZkMhNvwb0QkvodEN4LCEakzp7MDOgcrTVvgSJD+6vRZf7gMrv0ILCLRZsS?=
 =?iso-8859-1?Q?UAQbJgEwUCw0LPVZNgIGzZ+Nexfbhw1CejDFvFFGhR5gZT+fAd4PhKsorq?=
 =?iso-8859-1?Q?0G6newKuGkj+fgcp2ZAs2fvoF49ACh9x3zNrTal9PigZ4mQJ2ko5xOroDv?=
 =?iso-8859-1?Q?p9nh9xR3z778JuPEGZoLvRtbhXwBqHwyE7ptIe3reVa6PPiPMWkXgC03jm?=
 =?iso-8859-1?Q?McZ09aV1sQlHIpJConc3e8TDGpL8985mo2H2Dd4G2vUZ+XkvYEPsZAp+lx?=
 =?iso-8859-1?Q?KX8BrdXC0hBCi9B4aa6O8LqUosOylioffnaITH0NXb400reUEqzsz4O6Cr?=
 =?iso-8859-1?Q?cYoYKAtW6i7DkiZLLVyvbKhJlg/r/awRFqzEvfuqNaEqvqtg0z+DzrOgSw?=
 =?iso-8859-1?Q?l+kTy3ZyQ2jK5rgj+k1olEFJkirtXtjHNtb3hgJirpz4V1kf6rMAEtFeDd?=
 =?iso-8859-1?Q?YI/42oiY1wuVE0FHgeeDONOugQHJkb9lVo8UM3OuaVhG8mx2InWecj5NmJ?=
 =?iso-8859-1?Q?ONsa/l/Ltn3SI3JwMU16ab4QxXZU4WvEjZtwW+thscsSND/eECwJLIUe8c?=
 =?iso-8859-1?Q?NaunEfl3HHUuQO1Lz4RSfYuKo450SZMSA6ix/7dzWQtJGC9v8NtA6FBQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29fc6c6-6e34-4cdc-b1df-08de068d78eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 17:09:42.1463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhAFg71CF4qEckkMjrlHwKk5vB4n1IaaX9xGlTYfaHF9peoAD8Tz1aa659WjatiUMly8JyF3vNbWrON6KZ3Agw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR14MB3267

<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">About a month ago there was discussion about gssproxy,=
 including use for cron jobs.</div><div class=3D"elementToProof" style=3D"f=
ont-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvet=
ica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"><br></div><div clas=
s=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">I just did some testing. With constrained delegation I can make=
 cron jobs work. However when I do, normal users can no longer use NFS. It =
appears that when rpc.gssd has GSS_USE_PROXY set, it always uses the proxy.=
 So normal Kerberos tickets from login or ssh don't work. I looked at the s=
ource for gssproxy. It appears that when impersonation is turned on, it alw=
ays tries to impersonate.&nbsp;It doesn't check if there's a TGT that would=
 allow it to get a normal service ticket.</div><div class=3D"elementToProof=
" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"><br></d=
iv><div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_Embedde=
dFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0);">Unless I'm missing something we can't actually use =
this for cron job, since the system couldn't be used for anything else.</di=
v><div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);"><br></div>=

