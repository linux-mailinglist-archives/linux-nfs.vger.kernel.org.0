Return-Path: <linux-nfs+bounces-10101-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1130DA34E05
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 19:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758673AC8F3
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04049245AF9;
	Thu, 13 Feb 2025 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="TjTAD2B6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2115.outbound.protection.outlook.com [40.107.92.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A3245AE4
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472549; cv=fail; b=hTqjx5DOTtCaa1qapTQGzMyTouV/u31uePxHr1WMiq9G9u31lXcsvhjomTRMXcyvDYy+7o+mN90rtRsS+FQ3aKDvQlagQuPN5N/TZ+U8EfdX7vzZ1DsckmROJzsNwW5CQ8OG5R2enz0fcv1ttoQXGmijTRlj31mKAnVlsUnAobQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472549; c=relaxed/simple;
	bh=CeSwFRLi9uYTBB58WgbP2hcbrF947aIhF3FrPZDooog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hqvxGVb0mZ0jo+J5F9V+yYyvQfdjEqxCehiG0dxXcepMT4DiNpGXMYZ5d4Siuks2dYfhBq3cOh+mYWKynf6QTCWT+qpLVjHCn8KLtvEOb0+zfWVE1Al6Ly1DSVn6hKx89WraNr3qpZYLiMUTOXebPP2Yi6K7ckor/2Gpu1EzCK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=TjTAD2B6; arc=fail smtp.client-ip=40.107.92.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwhPrObqtQlKrLCaWQL28WjF83oHDH63A3NCPHEsA5R0Cu+EFQ8Th1YLOBiVI27bTfy8fWYc5y8AcdlKIduaZlYsJUGRqGm1Hd0CVw1XelbwcWuyOZJ8LdfcUnF6vg6JJqqpiitPA9+fTetAZvj2pgNnJTkkGg7/HnDfigGMb5p5UlG7z5PdkIW4/NQKSNtGRAshRHIlgm9FQo2t2+AegkgpByP/p9lwtLCoPmbYyFmEKfyAZc/nPnNKB5B1QXV+TTyoHlPDyB725B2SuFkQQ20Gj+XefSPNdsCd56hKptzDEky3lMrJySi6SfX57er5QLIkrrhGxs37jo6lIxhhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeSwFRLi9uYTBB58WgbP2hcbrF947aIhF3FrPZDooog=;
 b=fsKmW3zXOBclHnIYjkmcHBiTVgwNf+73uJGSY57fXCPKld6YSVxkfOTtNYCW+iq6XrrmYxESlDwCc11fg56RbkusSGX9gK5nO8VQImhEmMDoLQLP1Ptkt9dWtxA3mnqVccRLvO0SYj/xbID7JsZOuTstZSsqgjsCbH3eqRTvMIeWLAsL4xLHk6eotUFE6t2OfVhqyzw9HSyEjiHO1Q2q1hyvEa6A3Kw/38MD/gD1WchKz3Tp8Iqb6Nc/IVjKgsIDkm57rKJ6i6UCcPPHUmC27PSRACKmpZsLEpJfKQiscucncWot8KqF0akNij+Ao0cAiaEgSQLA1pvGfdP3Odud4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeSwFRLi9uYTBB58WgbP2hcbrF947aIhF3FrPZDooog=;
 b=TjTAD2B6KqbSNMDhBwim+gE5Du4Puir2j+/tl2IdKI2Qg2nreTW6hReQMRqLdL6qEMCEDMi2u9rFKSC7pJ7eCjlNMecnJ7SRkI12zQfJuY3XfIRwUaNybQ+swq8/0NJVuk+YFyf5w0LbS+oXCTBUsnSrVMqyg8/RfYqErkhOnmA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4750.namprd13.prod.outlook.com (2603:10b6:5:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 18:49:02 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 18:49:02 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "aglo@umich.edu" <aglo@umich.edu>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
CC: "okorniev@redhat.com" <okorniev@redhat.com>, "cel@kernel.org"
	<cel@kernel.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [RFC PATCH] NFS: CB_OFFLOAD should return DELAY when no copy
 state ID matches
Thread-Topic: [RFC PATCH] NFS: CB_OFFLOAD should return DELAY when no copy
 state ID matches
Thread-Index: AQHbfjOM2qaXtGaATkKgNd/ysX5erbNFc3UAgAAQcYCAAA5GAIAAAMoAgAAAh4A=
Date: Thu, 13 Feb 2025 18:49:02 +0000
Message-ID: <db7103ddc9ab031dccf0807456c09e5297179fc9.camel@hammerspace.com>
References: <20250213161555.4914-1-cel@kernel.org>
	 <df999d533683548ba91b69b017bf2b4acc0add52.camel@hammerspace.com>
	 <CAN-5tyGt4OhqZbzzADe9OumbaThrefZ1nTw=_wrrxy7FWfWK9A@mail.gmail.com>
	 <18421def0a2aa132a6817b56f97eb9d6f3928727.camel@hammerspace.com>
	 <12784b78-d053-46f6-b0e3-e81ca2e90269@oracle.com>
In-Reply-To: <12784b78-d053-46f6-b0e3-e81ca2e90269@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DS7PR13MB4750:EE_
x-ms-office365-filtering-correlation-id: 8c5d5943-d363-4227-2f9b-08dd4c5f15c1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkczTmZuVGFzUUlpdFpqMDVWZGpyZFd4U1NHSGZlYkFwR2VZREZ4NFUwbGxT?=
 =?utf-8?B?TmNiVkxKUWE4V0dmV25zYjJjZ3dwNXdUQkR4azBtaWphQ2hBMmErT3I1cmFl?=
 =?utf-8?B?emJIODdmZGFwbmlkclkycHBpbkZicy9aMGo4RkZBdHloaGJiTmNDOUxvcWhP?=
 =?utf-8?B?aWpNQmtOQXNJVWxGNU54dCtueGtBWVVuNW1NYVNFN1RleVY2eDAySCtYUkw1?=
 =?utf-8?B?UWRldUFFTVVhYXYvRHZiU3Nka2dGTzlEd3pzV0FTUDhLOXNlenlKQjY3TkM3?=
 =?utf-8?B?MnBnUnRmUjBEQTdjRjZKdkM0S3M5Rks0N3A4VHhyYjdqSFZmbnlWWmRjMzNq?=
 =?utf-8?B?aWFhNTVQMXZ1WU9RTHFFTzdmNERwcHR1THB3YndRWWZlVFVsaDBhenU5d3Fx?=
 =?utf-8?B?OXIxMFpHd3NXL0ZLenA4Vm9wUW1iVktuWUdZR3lOSjlsWXRYWlp3YzRmYklz?=
 =?utf-8?B?VTZTSnM1TnhxSzRSY3pFKzdXbG1oNGpIRlJscEh1Qy9icmtyb2J3RmRlak9S?=
 =?utf-8?B?eVc2WXF2a1hIbXhRT3owM09KR0czSCs5YXlYTzJDNmhIL1hoY3U0US9mWFNv?=
 =?utf-8?B?dGFXTk9ZK080YTRjWjJDSnUzanl2eU1iTkFZbC81SVBxa1ZHckVkOGRWUW41?=
 =?utf-8?B?czdjVFIzV0tIbzBCejNrQmpVZXRPRU1oaURZaVh0VThuSGViaUZlSnFKeHdx?=
 =?utf-8?B?TFIySUh5RTlrTjhTTHlVK1dqM04wdVJZQno1SUx0dldONk9HU1VCbEFRMmM3?=
 =?utf-8?B?WG41SXlSMU1YMFdndXF5enZScEJ3UUd4SDArS0o5T2ErM0FMSXhXMkEwY2tF?=
 =?utf-8?B?bFUycXBITHIyWE5xSlJETVloamRnRkxhVWVMNkFoMkN0Q1NWNTFCakV6andZ?=
 =?utf-8?B?c2pMYm1NeTFlbTlCMEVLbGxubkU0Mzh2dmJBTGhKTHBOaGJoR3hlL0syUU5q?=
 =?utf-8?B?bmVQZ3M0OERKUDNxNXRpMjJXUXljVUN6QnVEVkNocHJpalhqR2o3bmVZbGlB?=
 =?utf-8?B?WTVPcXJ1WHNrRGg3ZFZPNDNFTjJqN01PTlNpd1Nhbzl5RVYzdEplMmxkOVdz?=
 =?utf-8?B?TlpuYnhhSGNFaWc4MC83cXdlc1RMQ2Z3S0tNOERSVEdLTithOVJCbjFoTUFD?=
 =?utf-8?B?OVF1WGRSMzJRU2dWbGcvYWlRVWpDelBLRmtOV01vOEptNVhoazVtalg2M3Nk?=
 =?utf-8?B?c2VobzBrSkV3TXFadGZKeTlFMXJ0aDIrb0lTaWN5dENMei9aREJyMjNmRHVU?=
 =?utf-8?B?dGNBN3ZlRTVQWE1pRXYrMVIvNHA1dyt1TXRweW5VN3UrNE9vR0s2NlpnQ2Ev?=
 =?utf-8?B?RHhUSWd5WE9GVWtpR0ZtaGJMVHNEaEp3RlN5NFdpdTVRb1ZpcS8vdEJhdmFq?=
 =?utf-8?B?WWFubkVOS1dScStHWnVTNVA1TFdnM0g4c2NuR2ZTaXJrYThWU2VmU09NV0Jo?=
 =?utf-8?B?M3J3ai9scVRsR3JaRFlWR2NIZmVqVkFaYWVPWlZFTDE5WXJCY1Z4ajNxblFu?=
 =?utf-8?B?WVZDaXJOeFFFd1YvbWVPWVd2TEc5OHFTS2R1WTR2K2ljVmNpaUpIamNndFQ5?=
 =?utf-8?B?WjRCZjI2VGp2T09DbFgyZHVQTmdEVHJxY0xCS25ST05TcGdEbyt0UHUxQnl2?=
 =?utf-8?B?UFc3aE4vU1lNVVpCek10QmlPNzZsQit6ckF2UHl3TG9CU1FGZjN0YzBTVmZF?=
 =?utf-8?B?RDRlNEl5UURaR1dTU1pKaWZIZTVDM0x6Zk5TaCtWVUJ2bkRLMjloSnhLQjhO?=
 =?utf-8?B?cm50SitYMlpJUThhQmRPRmhJVUtBeTlEUFo0RFdHM0MzeWhocUh3dG50ckJI?=
 =?utf-8?B?TmhsS0FwekJ1S2xFWWY5YStyZ3E4Sm5GRldLOXQ1a3RDT0tOeFBmUGYxM0xS?=
 =?utf-8?B?N3lybzBoM0R6UnFXakhyMTRIRm1OWkVQa2F4RjBKYU1OZGg3RzQ5MllJRmNS?=
 =?utf-8?Q?IFqjja1JsPEsHWwrIMtv9IkoY8muHyb4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2RRbEZQdEw5UUVDOGp2dzZ4VEszRHkya3NKVjhqSDZKUEIxcVliMXczdXJ5?=
 =?utf-8?B?THJHWERGaldiSWRwdlEyQjRVMUdrR3dCbUo1R2JpUTM2QXdGNVZ2b3lQU08r?=
 =?utf-8?B?eW1GeUUxV1gwMmtpR2xDMlh4UGFNaXlrU1YyQmxGREhpQytCcWErc3BnQUxG?=
 =?utf-8?B?eEE4eFlKemFIOFNmVENqbkFOQkUraHRCOEE2TncvQ2dkemJZQ2dqRnhRMnBu?=
 =?utf-8?B?bnZ3ZFZWTjcwZy9HdVVHT09GVi9qNkc4V1JVOFdRamxmR2trWkdNWWNTYkU0?=
 =?utf-8?B?bGdTaXRSSGQzRjFIS2pyYzNaSCtieEN3ZXVrUDdQdlpQUHNyeklQNzVEWmRp?=
 =?utf-8?B?MFl1V2JUNElicGpnTkVyMFVNUEFsVlA1aEhkZHVmZkNJU1kxUlptTm96OFBJ?=
 =?utf-8?B?NUFXWGpDM0VwZlhjQjlPNWsvUDE4RGZScm53bE8xMG5tam9YMml5QzdWZFI3?=
 =?utf-8?B?bjkwN0JNUThiVnNSMThyUmROY0s4ekJMZk1Rc2NMT3BuRThZUFYvaEt0R29w?=
 =?utf-8?B?SG80aVNzZ3hGcnNoTWlTNVJoNnlCYkFnY0hqOU5yQ013L0dyU1NsRXJDRExh?=
 =?utf-8?B?QTUvL2FNZUNRK3RkY2tDZ2ZMWjJuaTVCSyt0MlMyeG02a3RUMCtpbWlJR1NV?=
 =?utf-8?B?VlRSd3oxWDlVR2grVWRnVEh0UnZKWm5LTERMb29iclQ4UXczM3dwV3Z6bEcv?=
 =?utf-8?B?TFJKL3pkK1F2anVHS0dkdlVUM3dtVlBtL1E2dUIrcGJzNU0vZElwLzhvQkJi?=
 =?utf-8?B?SzBQOThGNm9qKzVqY21TUy90M2V0U2k3REc2SXNiMjBORlF4ai8vMnBFSWgw?=
 =?utf-8?B?MnhrL3I1cFF5SDhPaUdFMGRFUXJGNEZFWXVkTTdWV2hkb1VKNm9jYk9KL3Bt?=
 =?utf-8?B?TGF6ZHFUK3RleWoxSHdmdlZDK1dxNUNtbkxtNGFxdld3Tk1rb1VqNDVnekw4?=
 =?utf-8?B?dmJyZ2pCSSs1TDBQemZQSkF4dGp5cGdnOER2Rk50aWV6Q0JMSmRUYUg4NjU1?=
 =?utf-8?B?MnJQNkc3Z2pma3hVMnFpRm54YjNBcnFEc1k1TWxnU0duU0Y0VytHRXBZdERN?=
 =?utf-8?B?cU4xVjRqckQ4THdhTW5BWVk0aXMzWTRUODlhSTZTTUZZMGVPdFVEaXpGS2t1?=
 =?utf-8?B?Yk1MYzNzME9IUUhFNk1RNU9BZjR1M1VRYUJ6aHhFajg5dWx6aUFOeTdlYTQz?=
 =?utf-8?B?K3VIRXZudVZTZG5vY1ljYlBjcUIzY2tzODMwd2crcHVvVmlTbWJnRlFieU1W?=
 =?utf-8?B?bXorZFY3LzhWMFR6V3dtTDRxNkh2VnZGYUVmdFRiMVp4YzFQMitlVlpkM3JW?=
 =?utf-8?B?dldJVG43Ly9yMGhXd2hqanJRZ2hJV3dHaW5abklFc0VUUThNUGxscUFGYWhq?=
 =?utf-8?B?d1pob2Z1a1pjcFNJbGhQY1ZQUDErK1FMWmkwUDFwOFF0dVdqSHRBNXFnRm5T?=
 =?utf-8?B?NjRwYXJxbEFoVkJkaStBT080aVdPSzZLdTlGelpXK3hWS1FZWTBoZTZXMGlu?=
 =?utf-8?B?Y0h2emRRUjU5VmEyTGtTS09rK0xGYVBOeTdUa0t5bENrUDNkMTlmK1ZlK29T?=
 =?utf-8?B?NHNDcTM2Tm5GaUhmUncwVyt3eVlFQjQxVzNpTXR0U01TY0lzMThEOGdYRDVU?=
 =?utf-8?B?MElmbmdkYVY4eXNFVjc3QlJQbWFuQW1Rc3BIN0N1WnJTbG1tZTV1eVlmYXpi?=
 =?utf-8?B?ODhyU3BFc21zL1ZZdlg0c01oQnlwRXAyd0Vnc0FhcndJNGRwRmFPYXFsU2JT?=
 =?utf-8?B?dDZQOU01M0hsWHZLdWtwVlJnUWVLeG9pMXJmSGlVRUxCQjNEZ0lydmlCZi9o?=
 =?utf-8?B?eGpoRmVSM1FJbHF2emxaOE9wVE5QSE5sbzZFVU5VSjVxYi96anFvZHdQMytF?=
 =?utf-8?B?REhkVkEyL1FlQWlHYmdjZmFWL2dXTlJLYjF1Nk95MHhpYXVpZnoxbXRlamwx?=
 =?utf-8?B?aWtTaVpEQVRWYWFtNGlKWFN5cVl2SFNUV3FKeEtjM0EwMHJyS2lyMHNRcS9N?=
 =?utf-8?B?dURxN0NDS21ZSnEvOHBZN2Vya0pITk9nUkI3T2FMa0pvNlNBdkFWNTVtZERK?=
 =?utf-8?B?TDBKVE9oaldsRnUzSHBiSDlHM0pjZjBlTE42VjJkTGwzd2ZYcXorTHQ0N0Ny?=
 =?utf-8?B?eUpUUWpvMUNkMnV3RWJNSG5DWXlaNmExMnR5UG1RTk55ZXgwYkNCaWw2cmNZ?=
 =?utf-8?B?SEVRUGJma010R05SQlBZeEZzT0w3Y0ZQT2FXaE1QMlBiYms0WHFDc2MrRHZN?=
 =?utf-8?B?YXM1NStVRitReEVtaEZOK09aR3lRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D60A77A3BE9AD4F9E1819D2D22E8B05@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5d5943-d363-4227-2f9b-08dd4c5f15c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 18:49:02.6644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yihn5d1nQWGr/hxUTGyA4vsZcBxSDi6BpHqkoXLvVwGIlj2AeGH3Rwe9Q7mQu86Mqa/61ZIzXu6ztVBdyEJP2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4750

T24gVGh1LCAyMDI1LTAyLTEzIGF0IDEzOjQ3IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gMi8xMy8yNSAxOjQ0IFBNLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gT24gVGh1LCAy
MDI1LTAyLTEzIGF0IDEyOjUzIC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+
IE9uIFRodSwgRmViIDEzLCAyMDI1IGF0IDExOjU54oCvQU0gVHJvbmQgTXlrbGVidXN0DQo+ID4g
PiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gT24g
VGh1LCAyMDI1LTAyLTEzIGF0IDExOjE1IC0wNTAwLCBjZWxAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+
ID4gPiA+ID4gRnJvbTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gVGhlIE5GU3Y0LjIgcHJvdG9jb2wgcmVxdWlyZXMgdGhhdCBhIGNs
aWVudCBtYXRjaCBhDQo+ID4gPiA+ID4gQ0JfT0ZGTE9BRA0KPiA+ID4gPiA+IGNhbGxiYWNrIHRv
IGEgQ09QWSByZXBseSBjb250YWluaW5nIHRoZSBzYW1lIGNvcHkgc3RhdGUgSUQuDQo+ID4gPiA+
ID4gSG93ZXZlciwNCj4gPiA+ID4gPiBpdCdzIHBvc3NpYmxlIHRoYXQgdGhlIG9yZGVyIG9mIHRo
ZSBjYWxsYmFjayBhbmQgcmVwbHkNCj4gPiA+ID4gPiBwcm9jZXNzaW5nDQo+ID4gPiA+ID4gb24N
Cj4gPiA+ID4gPiB0aGUgY2xpZW50IGNhbiBjYXVzZSB0aGUgQ0JfT0ZGTE9BRCB0byBiZSByZWNl
aXZlZCBhbmQNCj4gPiA+ID4gPiBwcm9jZXNzZWQNCj4gPiA+ID4gPiAvYmVmb3JlLyB0aGUgY2xp
ZW50IGhhcyBkZWFsdCB3aXRoIHRoZSBDT1BZIHJlcGx5Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IEN1cnJlbnRseSwgaW4gdGhpcyBjYXNlLCB0aGUgTGludXggTkZTIGNsaWVudCB3aWxsIHF1ZXVl
IGENCj4gPiA+ID4gPiBmcmVzaA0KPiA+ID4gPiA+IHN0cnVjdCBuZnM0X2NvcHlfc3RhdGUgaW4g
dGhlIENCX09GRkxPQUQgaGFuZGxlci4NCj4gPiA+ID4gPiBoYW5kbGVfYXN5bmNfY29weSgpIHRo
ZW4gY2hlY2tzIGZvciBhIG1hdGNoaW5nDQo+ID4gPiA+ID4gbmZzNF9jb3B5X3N0YXRlDQo+ID4g
PiA+ID4gYmVmb3JlIHNldHRsaW5nIGRvd24gdG8gd2FpdCBmb3IgYSBDQl9PRkZMT0FEIHJlcGx5
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEJ1dCBpdCB3b3VsZCBiZSBzaW1wbGVyIGZvciB0aGUg
Y2xpZW50J3MgY2FsbGJhY2sgc2VydmljZSB0bw0KPiA+ID4gPiA+IHJlc3BvbmQNCj4gPiA+ID4g
PiB0byBzdWNoIGEgQ0JfT0ZGTE9BRCB3aXRoICJJJ20gbm90IHJlYWR5IHlldCIgYW5kIGhhdmUg
dGhlDQo+ID4gPiA+ID4gc2VydmVyDQo+ID4gPiA+ID4gc2VuZCB0aGUgQ0JfT0ZGTE9BRCBhZ2Fp
biBsYXRlci4gVGhpcyBhdm9pZHMgdGhlIG5lZWQgZm9yIHRoZQ0KPiA+ID4gPiA+IGNsaWVudCdz
IENCX09GRkxPQUQgcHJvY2Vzc2luZyB0byBhbGxvY2F0ZSBhbiBleHRyYSBzdHJ1Y3QNCj4gPiA+
ID4gPiBuZnM0X2NvcHlfc3RhdGUgLS0gaW4gbW9zdCBjYXNlcyB0aGF0IGFsbG9jYXRpb24gd2ls
bCBiZQ0KPiA+ID4gPiA+IHRvc3NlZA0KPiA+ID4gPiA+IGltbWVkaWF0ZWx5LCBhbmQgaXQncyBv
bmUgbGVzcyBtZW1vcnkgYWxsb2NhdGlvbiB0aGF0IHdlIGhhdmUNCj4gPiA+ID4gPiB0bw0KPiA+
ID4gPiA+IHdvcnJ5IGFib3V0IGFjY2lkZW50YWxseSBsZWFraW5nIG9yIGFjY3VtdWxhdGluZyBv
dmVyIHRpbWUuDQo+ID4gPiA+IA0KPiA+ID4gPiBXaHkgY2FuJ3QgdGhlIHNlcnZlciBqdXN0IGZp
bGwgYW4gYXBwcm9wcmlhdGUgZW50cnkgZm9yDQo+ID4gPiA+IGNzYV9yZWZlcnJpbmdfY2FsbF9s
aXN0czw+IGluIHRoZSBDQl9TRVFVRU5DRSBvcGVyYXRpb24gZm9yIHRoZQ0KPiA+ID4gPiBDQl9P
RkZMT0FEIGNhbGxiYWNrPyBUaGF0J3MgdGhlIG1lY2hhbmlzbSB0aGF0IGlzIGludGVuZGVkIHRv
DQo+ID4gPiA+IGJlDQo+ID4gPiA+IHVzZWQNCj4gPiA+ID4gdG8gYXZvaWQgdGhlIGFib3ZlIGtp
bmQgb2YgcmFjZS4NCj4gPiA+IA0KPiA+ID4gTGV0J3Mgc2F5IHRoZSBsaW51eCBzZXJ2ZXIgZG9l
cyBpbXBsZW1lbnQgdGhlIGxpc3QgYnV0IHdoYXQgYWJvdXQNCj4gPiA+IG90aGVyIGltcGxlbWVu
dGF0aW9ucyB0aGF0IHdpbGwgbm90LiBUaGUgY2xpZW50IHN0aWxsIG5lZWRzIGFuDQo+ID4gPiBh
cHByb2FjaCB0byBoYW5kbGUgQ0JfT0ZGTE9BRC9DT1BZIHJlcGx5Lg0KPiA+ID4gPiANCj4gPiAN
Cj4gPiBUaGVyZSBhcmUgc2V2ZXJhbCBjYXNlcyB0aGF0IG5lZWQgdG8gYmUgaGFuZGxlZC4gT2Zm
IHRoZSB0b3Agb2YgbXkNCj4gPiBoZWFkOg0KPiA+IMKgwqAgMS4gVGhlIHJlcGx5IHRvIENPUFkg
aGFzbid0IHlldCBiZWVuIHByb2Nlc3NlZC4NCj4gPiDCoMKgIDIuIFRoZSBDT1BZIGlzIGNvbXBs
ZXRlLCBhbmQgdGhlIHN0YXRlIGhhcyBiZWVuIGZvcmdvdHRlbi4NCj4gPiDCoMKgIDMuIFRoZSBz
dGF0ZWlkIHByZXNlbnRlZCBieSBDQl9PRkZMT0FEIGlzIG9uZSB0aGF0IHdhcyByZXVzZWQNCj4g
PiBmb3IgYQ0KPiA+IMKgwqDCoMKgwqAgc2Vjb25kIENPUFkgcmVxdWVzdCBhZnRlciBhIHByZXZp
b3VzIG9uZSBjb21wbGV0ZWQuDQo+ID4gDQo+ID4gVGhlIGNsaWVudCB3aWxsIHdhbnQgdG8gc2Vu
ZCBkaWZmZXJlbnQgZXJyb3JzIGZvciBlaXRoZXIgY2FzZQ0KPiA+IChORlM0RVJSX0RFTEFZIGlu
IHRoZSBmaXJzdCBhbmQgdGhpcmQgY2FzZSwgTkZTNEVSUl9CQURfU1RBVEVJRCBpbg0KPiA+IHRo
ZQ0KPiA+IHNlY29uZCkuDQo+ID4gV2l0aCBjc2FfcmVmZXJyaW5nX2NhbGxfbGlzdHM8PiwgdGhl
IGNsaWVudCBjYW4gZWFzaWx5IGRpc3Rpbmd1aXNoDQo+ID4gYmV0d2VlbiB0aGUgY2FzZXMgYW5k
IHJldHVybiB0aGUgcmlnaHQgcmVzcG9uc2UuIFdpdGhvdXQgaXQsIHRoZQ0KPiA+IGNsaWVudA0K
PiA+IG1pZ2h0IGVuZCB1cCByZXR1cm5pbmcgTkZTNEVSUl9CQURfU1RBVEVJRCBpbiBjYXNlIDMs
IG9yDQo+ID4gTkZTNEVSUl9ERUxBWQ0KPiA+IGluIGNhc2UgMiwgZXRjLi4uDQo+ID4gDQo+ID4g
U28gaW4gcHJhY3RpY2UsIHdlIHdhbnQgYWxsIHNlcnZlcnMgdG8gZG8gdGhlIHJpZ2h0IHRoaW5n
IGlmIHRoZXkNCj4gPiB3YW50DQo+ID4gdG8gYXZvaWQgY29uZnVzaW9uIG92ZXIgc3RhdGUuIFRo
ZSBjbGllbnQgY2FuJ3QgZml4IHRoZXNlIHJhY2VzIG9uDQo+ID4gaXRzDQo+ID4gb3duLg0KPiA+
IA0KPiANCj4gV2UgYXJlIGN1cnJlbnRseSBsaXZpbmcgaW4gYSB3b3JsZCB3aGVyZSBhbGwgTkZT
RC1iYXNlZCBzZXJ2ZXJzIGRvDQo+IG5vdA0KPiByZXR1cm4gcmVmZXJyaW5nIGNhbGxzLiBJIHRo
aW5rIHdlIG5lZWQgdG8gdW5kZXJzdGFuZCB3aGF0IHRoZSBjbGllbnQNCj4gc2hvdWxkIGRvIGlu
IHRob3NlIGNhc2VzLg0KDQoNCk15IGFuc3dlciBpczogbm90IHRyeSB0byBmaXggdGhhdCB3aGlj
aCBjYW5ub3QgYmUgZml4ZWQuDQo+IA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==

