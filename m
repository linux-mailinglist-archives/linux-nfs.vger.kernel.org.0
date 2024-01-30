Return-Path: <linux-nfs+bounces-1603-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DDC842822
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 16:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A691C22125
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 15:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6A46A32D;
	Tue, 30 Jan 2024 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="n8vD1yLU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A4605A6
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628923; cv=fail; b=Ld00ue6dBO/+EsdoA0LMOMI8RzPsGPPw7iuJE/7jO6BpaXqztAqyvlA0IWZePPTSxiPvnN2sq3U6DMlsMZBDciB6yS/RrkANsKWbo4du1Az2KzwyTqPR80nD+f5SOb1xgEjefMQSdvafh6p1paPSAkwbjhi9RGIJsuVUzn7WF+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628923; c=relaxed/simple;
	bh=d3++rqRRoEXNJutiUzOn/bEKLWwZ8jy7LCVwplbIZE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cSv7OGsymAr/ulG44RnVPlk7S0iTSIhC9F+Z52RmJhZ/pvbDvFW0W3GxXVrmZ25liwJLL4c+mozi0gIuIdSp+y4YQZ2Fc80K7amxmBdBbBUCZP7bn5pvczkwNaaGi/GPzgHvLOznQB2m/hVGk9rHM9N8SginAZi4d9kYVsrVDK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=n8vD1yLU; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1706628921; x=1738164921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d3++rqRRoEXNJutiUzOn/bEKLWwZ8jy7LCVwplbIZE8=;
  b=n8vD1yLUnHyf5dL7AcNMmpQE/OJi/URCtrlxw33DY9EVhXJ1CMInYBU9
   RwLd3XjdttL3dA892RUlIRfTrxraKj3oyev7IkBfGmCI0uN5YgScrVEwv
   xk5/ljq6qVAGzYCM7ZqPrH/zwV9XZSCvebYgqgHoppmXH/zydfEWKQ7SK
   QUNO0lKR3QutCdIsAeSySo2ctiuy8ZGWRFPpKmmyGnulJxNlzm6fX/NNM
   U6W2yDmjAqnOQ0Dujp/zOrfdLpuIWYEBmJ7wBArBP+XKM0XddG7DXGOYO
   OWFFVyHFjHbW3Caus6SBiamrg1DZ9/DpJC7sVRIS66ZKJniolYpms/F+j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="109884010"
X-IronPort-AV: E=Sophos;i="6.05,230,1701097200"; 
   d="scan'208";a="109884010"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:33:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1PDH4shYRWyAiCPllQu1xLf5Fnup9KG39vb4L9l558exIsx/Fxh6v+7oTAEqa6ZNrtj740nBjJMJObEFTT10c6YpHLvCG4BO3+erxcxO8EXSwp3YLl7fVGCpjIn9TkyaN5g6lrda6g7v+oxbNrSXLIkpvQbgugt39WVCkHITN6w6ZSOyUBgewEP4RTrpqCXIxODLmjGFfjARoOUWaY+4jeyOOAnsYx1GRMOq0nVLhSmgp0d5CdsV2ISepGaCrqYQfIfOPiGJ2SzM2dj4PjG6h6ehjIhAsQ9GnNfGVYaEqOwPimrfNIfkL5pubiF+k+EBiiHbu54ARx6Lthrru6IVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3++rqRRoEXNJutiUzOn/bEKLWwZ8jy7LCVwplbIZE8=;
 b=TnK6PNLaBZKpQ6/AUXPSMtQzmLY+jhp+GcazVsuuv9UW3VHElhNCqTucjBRU1xJBHEQnmOjgEB7NYjPipGfvP9jATJJGXvH6rKgmAPil35wPY0LvhF4aY7XYjaQ96rFB0GB55WFHI8wqmMlBO6h9PhsftoyhqA2eeTBkqMNRRKhkQEMK4N7R8AsetcDjyYDibf38wEMkus8uhiFhvbh4apmrU1Qnw2ZT2aW3x4CM7d7Rw8IQIbmjVpZ0y+Y2o0/gEt9AX/psjFjmXWthGLtboPxmhpgQH3K7VL5pgaBYb8njVSch7YHLjILmt6EnDBXtV5L2+7nJgFpeSGXa2BZt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by OS7PR01MB11683.jpnprd01.prod.outlook.com (2603:1096:604:240::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Tue, 30 Jan
 2024 15:33:50 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::fdb2:f9ea:e915:36ce]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::fdb2:f9ea:e915:36ce%5]) with mapi id 15.20.7249.017; Tue, 30 Jan 2024
 15:33:50 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Jeff Layton <jlayton@kernel.org>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Dave Wysochanski
	<dwysocha@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] nfs: fix regression in handling of fsc= option in NFSv4
Thread-Topic: [PATCH] nfs: fix regression in handling of fsc= option in NFSv4
Thread-Index: AQHaTtTbByyxSQeqJkmkCP1P+n/7GLDyclEAgAATdXA=
Date: Tue, 30 Jan 2024 15:33:50 +0000
Message-ID:
 <TYWPR01MB120856FF65C14F8B2BD843BB1E67D2@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240124143755.2184-1-chenhx.fnst@fujitsu.com>
 <3c10192ac3d70834b6c721dc756ddab0a28b87b9.camel@kernel.org>
In-Reply-To: <3c10192ac3d70834b6c721dc756ddab0a28b87b9.camel@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=fcc5987e-1404-4015-8eac-0d9d8bb95ed7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-01-30T15:18:20Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|OS7PR01MB11683:EE_
x-ms-office365-filtering-correlation-id: 734ade9c-82cc-4db5-813e-08dc21a8dba1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fhlPyA7JByIBPV8qWXHjWZ4izYKbSygNYp56WJD/iRZ8CVwqG8vgJLEsZH1y+iPvfZge/FkQYqI/zfi4dOiV0SLkNvOgxUWzfCPBpXrZYPp6k7FRDf33WzrUZ3aMv3Gwx4jGt9TV8vzqWEmRijmwdfsE92+yhjoTzwWqbO5mSC5FtuSEvwanDAiX98v3ICzspJms7cD1J+RUZTC+1GS/dKw4JDUF4LvvWc8XpI+JdZGxnAY5K0ITsl6etfuiJQXQLB1L2TP2ctHruZqX6c8587xIErkb5bdYvWT3cVPcyz0OfDM3bIKvjCWlGX+LKg85WaQEryZm81YuZfg15th3B5uX+HJT3RzJ7mCAOtvfrvcEndGGeplJhpxUzl2myCODBJPWJ/liCgrB73UgRoW3dDtPLJWaUseyFZtaa3c0Os+a5Kd5qobKoV69pAxFp6FyrbWlfT+ryGa4WsgG3Odr73/YuSR3vTwihqwx8IIeVMaeFl0Dl+NLiG7LSEErqwtMU3jAt7d8fHCLb+BHRaHpgMpRC1rBTsYizqGMNWixSWs1hpvEnBtPz6X77fulltJLDesJlMSpnmYfwbX/W95eV0lkpp+C3ESRU5mUJ/oD0lankhq39WygsAlzj5+m7yiUgTC5n8klynjO2OT0Wr6+7w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(1590799021)(451199024)(1800799012)(186009)(1580799018)(8936002)(122000001)(33656002)(86362001)(82960400001)(41300700001)(85182001)(38100700002)(478600001)(4326008)(52536014)(110136005)(76116006)(316002)(66946007)(54906003)(64756008)(66446008)(66476007)(66556008)(8676002)(26005)(2906002)(9686003)(6506007)(5660300002)(71200400001)(7696005)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WGFqZ1RoNXZSTlZoUXo0QmJ1a1dCNUJLOE94VlZmTVh3OXI4ejlRY09GTis1?=
 =?gb2312?B?MzdKWUtuN3RPOFBQL3Z6TG0reGJHMUJmNWhqMmNmZldhQitadEphUVE4Snls?=
 =?gb2312?B?NVRQMHd2enZKdFhaY3JuZnZKZEx6NDRTSXlJbHRWOUVGcnVIUnR5NjY2bXdT?=
 =?gb2312?B?ekhwQTdURUhsdTRsNjhxSlIzV2dWbExUaVJILzRvS1dXYnNUMExTcHdEK3NT?=
 =?gb2312?B?a1FETzdPWGJOY1pqTWxvMXVRRk1xUytrNm1ySUd5N0NDTFIvamR6QTZVNzV5?=
 =?gb2312?B?Z2habWp2aEpuRlJiYTdNTjBPaEQ5bnlOZlJ1N2ZCYXM1Z2xxamxKNnhQeU9M?=
 =?gb2312?B?STBWZWZkUVZiMXZDak1EUjd4VGJUMklaTkprMlIrWUNtYWN3WGxtZXFjNHB3?=
 =?gb2312?B?QmtQdi9oVU1laE1UUHpFdlA4akhUQkkxaE9zajVaUGRiVm1pRGVPMjAwNVNk?=
 =?gb2312?B?bUo4eFVBbVdSamZBR1ZQVXJZMm14Y1o0L2lXcnlMWnAzY0F6V1N3Z1RkQ2xz?=
 =?gb2312?B?Z1lHTXpyeEY2N2lJVm1PUi80Q1Nwbm9TMnpIZW16RkkvajlVODY2aGJwWEpW?=
 =?gb2312?B?RFNNYlNvY3pidWlOTFRoRFdXMENZNndncEo3dWZFd0s5UlNobEtTa1FweHdi?=
 =?gb2312?B?dVVzRWF5NXV1RUZmYWRtb0xKMm5qNmRocVQ3ekV0aTNkWmxVR21vLzk4cVZQ?=
 =?gb2312?B?UmxkUHNDZnpsQ21ydnoxcU5sbjZkSUswRXlTekcrM1RUREI5OXRRb252NFBq?=
 =?gb2312?B?bktGeXJDTlp6VzVGaFRXa0RDdUdhRFpCdGxFVDNIbmdXaXR3RjV4UnlrVXZG?=
 =?gb2312?B?M3J1bm85T0h5RVI3WXlFVmwyOTA3TTJ2ZWhtWTNEZ3liemtCdEpXZlNTYVdV?=
 =?gb2312?B?NzZjWG1OZDFsdHJtVG5OcDJvT1N1MjNNU1ZzSDd1U1BCMEY2VGpCN3l3MlhQ?=
 =?gb2312?B?R2xYTHoxd3JJdHVXRFZlN25tUFJQd2FnZU1OYUlHVjVzV3lRY3QyWUJXRURi?=
 =?gb2312?B?aGR0SzdKVHM4VnJzWXBOZzF6ZGRLaklrYUdPK1dsbGQwL0xFMEdZbEQyTDg2?=
 =?gb2312?B?SlhVakdNazl5ZFgzRkJiekJ1dnBHc3loUnI3bTFTMHlsQU5TclBIaVRoQXUr?=
 =?gb2312?B?Y3gySFhOdG56TGRITlNpQ2h4c2xxMjJuT1dVWC9WNC9sWjdWM0xYOXdlQ0Mv?=
 =?gb2312?B?UTM0WVYyUEVrNVMyMWNSVmQ2VW5TMmxKL3VLZ0dQU3YzVy9IQ1E4MWd5d1JZ?=
 =?gb2312?B?R3BLWW5CelFrRUFwY3lEMVVQUE1EbkhnK3Vqb2tVOHd0UjN4ZFRhV2ViOGJj?=
 =?gb2312?B?OWdYaGFzVU9HaWtMQzhNQVFRckRwZ1dJTllPNk9leU5rZ1F3TkZacVAyaGVH?=
 =?gb2312?B?dnY5QzRqMVJnbW9vOVRxdEZrMkRINU5Lb2t6UEt4ZVpqTDZMMGdXQXMvMjhk?=
 =?gb2312?B?a2QySHNWcUVPaEtod3loaGsrVGtEbVMyUVhPdk9JN2FKUlJjby9NK1NaVG5M?=
 =?gb2312?B?S3dxckN4VXA2Z3ovbDhsS3FidG8rT0JRU2hRSWs0bG5BWC9GcUx6dUgyNVBH?=
 =?gb2312?B?Qy9Ga2Y5TXp1aTIyS1RIYVozVjRoMGxLSGwwYjV2STIrUno3eVlXbWlKS2J5?=
 =?gb2312?B?c3ZUWTRrVHdjcEgyQkFUV3FJQllIK1hmMGJNWHB6bXk2VTY2MWQybHI4WTdB?=
 =?gb2312?B?STFoSTl6aXlqNHJTcWhMczBIY0NUL0lqTnJMeXlzelVrWnJzSEZWT1U3NXJq?=
 =?gb2312?B?YUxQaVdTaU9ZQ3hWUGFrRHpRY09IcDBzNzZ2SndyVnNsWkE4RmxIYWRkSVdq?=
 =?gb2312?B?dis0aXFoNmtkc1JPUFZIN2JOa2pIVERiM1JjUjd0QTFsNDNKWjh2VGM1WFNk?=
 =?gb2312?B?aEY5KzBKK3lVZHNVYnByalN0bGxPbUgvRkl5cFd0Y0d1Z2FyaW4xRi9IeDRT?=
 =?gb2312?B?dW0zeTRNY1A0djg3M2ozcVR2K2pBbHlVTFoyYW1FK2szUDVUU3Z5K1ZXUzlh?=
 =?gb2312?B?UG1XTVkwSUkvUEVFMG05emkvRENnOVdQbXB5Ty9FMDdSa1F4ZjdERzRreTcw?=
 =?gb2312?B?TzlUdXRRaElpQ2xkMmJ1TllHUFRCRC9jQktUdEpDeXlsZXlCbWFkZEdycVlG?=
 =?gb2312?Q?FAXGRmJrP5twSTGPBAV1/ReL8?=
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
	WaP1xCvt3FJYUlDmfNrKnbXdLA9i1A+1MNZb4MfwzmaLIqRJFbcPed0i/GVWhZyhjaucsXf9dm6p0Stfh7eLFbLEkh5M1w/yODRgxSL0/yO/Pc46ECNjlAjaEP9tBt71d1ClKpXKlrmEMBou9mEk90QF1g426TaohIP5ul48rU89Uv3pPKgpToK1SxNjyoDcdmzn2/3TuZjgux8h7VyEJYfRHFKkmJAwc38fImwv8XeNKA4nLdYNid8RIx+DZR7SdvD5MlVDnDAb8ndmPccEpWxCyXDuj9KJTyyp9tOy8fLl6U7h/dy6Ak2goF4FIxyLley2ZynR1hKopqMLkBc1ZuCVdhFMYPqnE63ZqHuGGZeHS6GK7aiI35SbDzdMusAgkBRzvZpuqt8p+xWLDr2aeLSbGy/3qoOTrBzW6xJ6muhcGtkZ9o4MCKXqnTFpOF7iyGTbiSwRfrWh2poqFXV0fxIIW+8FoptQbOtSbvi49Kp3wpxJgTePPUKtOAaXCQ5NVHVOByPf3LfxEDOZD1U7ABaFj0CKgsXrW8BDRIxTHps+BLCfPo09c6zdHy/0udKc1GQEpez6CBek+1ybi7xY2wTWi72YyOqyTMe0Owp1WTSs6g1o7nY0yVoooo4jhZhO
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734ade9c-82cc-4db5-813e-08dc21a8dba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 15:33:50.2686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADVHivG3jVuUqq8hchuoy9rGIch2dF0bVGFm9fFUKsoZ/khTiSkO+AauQMZrk6MdXVTuwSTyjL30H/5tpgcuFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11683

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogSmVmZiBMYXl0b24gPGpsYXl0b25A
a2VybmVsLm9yZz4NCj4gt6LLzcqxvOQ6IDIwMjTE6jHUwjMwyNUgMjI6MjQNCj4gytW8/sjLOiBD
aGVuLCBIYW54aWFvL7PCIOrPz/YgPGNoZW5oeC5mbnN0QGZ1aml0c3UuY29tPjsgVHJvbmQNCj4g
TXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPjsgQW5uYSBTY2h1bWFr
ZXINCj4gPGFubmFAa2VybmVsLm9yZz4NCj4gs63LzTogbGludXgtbmZzQHZnZXIua2VybmVsLm9y
ZzsgRGF2ZSBXeXNvY2hhbnNraQ0KPiA8ZHd5c29jaGFAcmVkaGF0LmNvbT47IERhdmlkIEhvd2Vs
bHMgPGRob3dlbGxzQHJlZGhhdC5jb20+DQo+INb3zOI6IFJlOiBbUEFUQ0hdIG5mczogZml4IHJl
Z3Jlc3Npb24gaW4gaGFuZGxpbmcgb2YgZnNjPSBvcHRpb24gaW4gTkZTdjQNCj4gDQo+IE9uIFdl
ZCwgMjAyNC0wMS0yNCBhdCAyMjozNyArMDgwMCwgQ2hlbiBIYW54aWFvIHdyb3RlOg0KPiA+IFNl
dHRpbmcgdGhlIHVuaXF1aWZpZXIgZm9yIGZzY2FjaGUgdmlhIHRoZSBmc2M9IG1vdW50DQo+ID4g
b3B0aW9uIGlzIGN1cnJlbnRseSBicm9rZW4gaW4gTkZTdjQuDQo+ID4NCj4gPiBGaXggdGhpcyBi
eSBwYXNzaW5nIGZzY2FjaGVfdW5pcSB0byByb290X2ZjIGlmIHBvc3NpYmxlLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogQ2hlbiBIYW54aWFvIDxjaGVuaHguZm5zdEBmdWppdHN1LmNvbT4NCj4g
PiAtLS0NCj4gPiAgZnMvbmZzL25mczRzdXBlci5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZnMvbmZzL25mczRzdXBlci5jIGIvZnMvbmZzL25mczRzdXBlci5jDQo+ID4gaW5k
ZXggZDA5YmNmZDdkYjg5Li42NjlkN2Y2NWVmOWMgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvbmZzL25m
czRzdXBlci5jDQo+ID4gKysrIGIvZnMvbmZzL25mczRzdXBlci5jDQo+ID4gQEAgLTE0NSw2ICsx
NDUsNyBAQCBzdGF0aWMgaW50IGRvX25mczRfbW91bnQoc3RydWN0IG5mc19zZXJ2ZXIgKnNlcnZl
ciwNCj4gPiAgCQkJIGNvbnN0IGNoYXIgKmV4cG9ydF9wYXRoKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1
Y3QgbmZzX2ZzX2NvbnRleHQgKnJvb3RfY3R4Ow0KPiA+ICsJc3RydWN0IG5mc19mc19jb250ZXh0
ICpjdHg7DQo+ID4gIAlzdHJ1Y3QgZnNfY29udGV4dCAqcm9vdF9mYzsNCj4gPiAgCXN0cnVjdCB2
ZnNtb3VudCAqcm9vdF9tbnQ7DQo+ID4gIAlzdHJ1Y3QgZGVudHJ5ICpkZW50cnk7DQo+ID4gQEAg
LTE1Nyw2ICsxNTgsMTIgQEAgc3RhdGljIGludCBkb19uZnM0X21vdW50KHN0cnVjdCBuZnNfc2Vy
dmVyDQo+ICpzZXJ2ZXIsDQo+ID4gIAkJLmRpcmZkCT0gLTEsDQo+ID4gIAl9Ow0KPiA+DQo+ID4g
KwlzdHJ1Y3QgZnNfcGFyYW1ldGVyIHBhcmFtX2ZzYyA9IHsNCj4gPiArCQkua2V5CT0gImZzYyIs
DQo+ID4gKwkJLnR5cGUJPSBmc192YWx1ZV9pc19zdHJpbmcsDQo+ID4gKwkJLmRpcmZkCT0gLTEs
DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiAgCWlmIChJU19FUlIoc2VydmVyKSkNCj4gPiAgCQlyZXR1
cm4gUFRSX0VSUihzZXJ2ZXIpOw0KPiA+DQo+ID4gQEAgLTE2OCw5ICsxNzUsMjYgQEAgc3RhdGlj
IGludCBkb19uZnM0X21vdW50KHN0cnVjdCBuZnNfc2VydmVyDQo+ICpzZXJ2ZXIsDQo+ID4gIAlr
ZnJlZShyb290X2ZjLT5zb3VyY2UpOw0KPiA+ICAJcm9vdF9mYy0+c291cmNlID0gTlVMTDsNCj4g
Pg0KPiA+ICsJY3R4ID0gbmZzX2ZjMmNvbnRleHQoZmMpOw0KPiA+ICAJcm9vdF9jdHggPSBuZnNf
ZmMyY29udGV4dChyb290X2ZjKTsNCj4gPiAgCXJvb3RfY3R4LT5pbnRlcm5hbCA9IHRydWU7DQo+
ID4gIAlyb290X2N0eC0+c2VydmVyID0gc2VydmVyOw0KPiA+ICsNCj4gPiArCWlmIChjdHgtPmZz
Y2FjaGVfdW5pcSkgew0KPiA+ICsJCWxlbiA9IHN0cmxlbihjdHgtPmZzY2FjaGVfdW5pcSkgKyAx
Ow0KPiA+ICsJCXBhcmFtX2ZzYy5zdHJpbmcgPSBrbWFsbG9jKGxlbiwgR0ZQX0tFUk5FTCk7DQo+
ID4gKwkJaWYgKHBhcmFtX2ZzYy5zdHJpbmcgPT0gTlVMTCkgew0KPiA+ICsJCQlwdXRfZnNfY29u
dGV4dChyb290X2ZjKTsNCj4gPiArCQkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKwkJfQ0KPiA+ICsJ
CXBhcmFtX2ZzYy5zaXplID0gc25wcmludGYocGFyYW1fZnNjLnN0cmluZywgbGVuLCAiJXMiLA0K
PiBjdHgtPmZzY2FjaGVfdW5pcSk7DQo+IA0KPiBBZnRlciBnZXR0aW5nIHRoZSBzaXplLCB5b3Ug
Y2FuIGp1c3QgY2FsbCBrbWVtZHVwX251bCBpbnN0ZWFkIG9mIGRvaW5nDQo+IHRoaXMgbWFudWFs
bHkuDQo+IA0KPiA+ICsJCXJldCA9IHZmc19wYXJzZV9mc19wYXJhbShyb290X2ZjLCAmcGFyYW1f
ZnNjKTsNCj4gPiArCQlrZnJlZShwYXJhbV9mc2Muc3RyaW5nKTsNCj4gPiArCQlpZiAocmV0IDwg
MCkgew0KPiA+ICsJCQlwdXRfZnNfY29udGV4dChyb290X2ZjKTsNCj4gPiArCQkJcmV0dXJuIHJl
dDsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gIAkvKiBXZSBsZWF2ZSBleHBvcnRfcGF0aCB1bnNl
dCBhcyBpdCdzIG5vdCB1c2VkIHRvIGZpbmQgdGhlIHJvb3QuICovDQo+ID4NCj4gPiAgCWxlbiA9
IHN0cmxlbihob3N0bmFtZSkgKyA1Ow0KPiANCj4gVGhlIHByb2JsZW0gYW5kIGZpeCBsb29rcyBh
Ym91dCByaWdodCB0aG91Z2guDQo+IA0KDQpUaGFua3MsIHdpbGwgc2VuZCB2MiBzb29uLg0KDQpS
ZWdhcmRzLA0KLSBDaGVuDQo+IC0tDQo+IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+
DQo=

