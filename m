Return-Path: <linux-nfs+bounces-1197-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72478311FF
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jan 2024 05:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF0A1F22580
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jan 2024 04:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B1A6111;
	Thu, 18 Jan 2024 04:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="brNrYPs6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5597A17C7
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jan 2024 04:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705550729; cv=fail; b=sIzIuhhhjzQVaav4B3kOA92BTCfqFwlipyv8dvnXDehSSvEtS6kYVhSDsNGedMndN84busEGzqlg4AM9ONpqF/ecWLSEfktRDe2fr86q3LHQFIeukYdz0cjv92wkULOXjNL6m0fAfSrYvF2mDaIAyeHfSDAm1XkvmQT8h+BDtA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705550729; c=relaxed/simple;
	bh=dhp3RqHcsaVRujRdau3rMz/hsKg+xip/hOH+QIJR2d0=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=bbcgXT4615HGewyo/1EiFRLZUpQk9NXcP2YTdDnMX5mz+pRSx8J7boSYBREfC0pyJA80NVomBxClUaYhFlkTLCUhyMe+RaeijmCxRoyUuu9YGyzXqRd8ahYX8yOgnmf6PzzUogZrJKXJ9r/qxeHb0R3pR4kr2sREI/hVO0thyYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=brNrYPs6; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705550724; x=1737086724;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dhp3RqHcsaVRujRdau3rMz/hsKg+xip/hOH+QIJR2d0=;
  b=brNrYPs6LXQr2VQhgJVobEKQj+M2PCLCGFbC5wBqQGeSicrGw3SpPXB+
   U8v2VhiSQgIG3iAiEgoFeA4D4ymwMKmhMBF6CygvSORMmZAAqdvnI8KRZ
   yJSiTeS0qJCpUWCW3iXcOo6vonOJKuugnE64wX11YCiYoPkWCET+MYy1p
   NKWAO+xLcJIzBl/CkTlPEu5jRx7eyUjA3JxGJxsCjxHHPHH25M3oRUKgw
   EYq0JYlLwHSYUlwtz4VyCd2ew0JUyV43NfHd91PETWKNNunwMvo6KwzGZ
   xRSKsptzS/5z8uDpo1oPoPpk9g4lAMrD/t9EAOMZ2NUrX2y5S17CNcj40
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="108494855"
X-IronPort-AV: E=Sophos;i="6.05,201,1701097200"; 
   d="scan'208";a="108494855"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 13:05:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6Ew9CWpAAJ4xl5ISCSgUFuiXgO3Gam5QuLqd8GlXQz/3Zg4Hd0Enbd2fph/uILQfwmKleV0qtd3jl6QZH+cEYHwfO2TRAS5MQtXPmO+p2Plex5Ampyt2HBo0+qim+A9NO72ZdOpa5jkEzTB1//CDXzOvcC7yyz40x5ZPZcWb7JfuZdIv+b0cyJMK5XPz+L4Cap6d5WfoUnUim+7OvN+znwfyvao4WewvnYE2CeWDGTRBbVKaCvdkb//ny3PXKdbx6ZY8mhNTtHEDul//bgz3B7BPwaMmKFivcD6FtHeAy6HwFvosvXHJMuPtxXkdoh6rG3OYZOiG9Ebeb8nTupstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhp3RqHcsaVRujRdau3rMz/hsKg+xip/hOH+QIJR2d0=;
 b=GBY3pK3AmOEiz+PEnGr5dtaF8+nD6IU7T50wsBus3LVKLGQOyu2HcT1NUjYRBeEoAKqPLPo0yGcfmaUCI8IotydU9nq6iGid0swx9DkM7t5e+RnlBbOYQ5/uNxL5vx9NX59qtG2Fw8dBcKORW8GU1BdP6nrTWe/anfcj/HHru8BWwI0q80ZBbgJ6YUGWgOxmYT+vO4I07wPInp2bvIFHy/cCaDClgCuKJiYi/+7zACbcs0+CNxfAM0ZK2Sdw9vSSQuwWDSWKVAvfW4qSDIDIzxQhns/q+db4QEDktqqZlU496l9IKJIJpzz0G76yw1rPFrfdA0k4kz0OljUoajgOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYVPR01MB11129.jpnprd01.prod.outlook.com (2603:1096:400:368::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 04:05:12 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::fdb2:f9ea:e915:36ce]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::fdb2:f9ea:e915:36ce%5]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 04:05:12 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>,
	"trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
	"anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIDEvMV0gU1VOUlBDOiBhZGQgeHJwdCBpZCB0byBycGNf?=
 =?gb2312?Q?stats=5Flatency_tracepoint?=
Thread-Topic: [PATCH 1/1] SUNRPC: add xrpt id to rpc_stats_latency tracepoint
Thread-Index: AQHaSX+wsNx363zQfU2em0jnfeCHJLDe872Q
Date: Thu, 18 Jan 2024 04:05:12 +0000
Message-ID:
 <TYWPR01MB1208564778889D36409BED08BE6712@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240117195912.19099-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20240117195912.19099-1-olga.kornievskaia@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=0ac457bc-e953-41f4-a511-c3f79eeaba76;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-01-18T04:04:07Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYVPR01MB11129:EE_
x-ms-office365-filtering-correlation-id: ce124cc2-be5c-4b7d-9044-08dc17daab47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0K0IKDZeGSBsHEUtGpdogdN7cF50khBTu+uv3Jluj0D5N1yra8ImeTzQDposT2H9Qis/01x/UFl25QyZWBIWdb6Kd72aKxSiOoB4RORYKFoAVs8uewkAYdFQvI5rs9U+kVNP2DtdAwLI/7hQ+05P/jZFd9EzL9V/IzlrHuoYY/5XCC6flxHmTi+/a2OcbIz+iOnJdAYPHYSoVQPKoOgX9iJwC5GTVGm1Rxzvj4rjGHSXubjZnk5sNWbBj/Y0LBgcr/eOL9EEqGpqQhx1JzuqRSAclP+sOBJXkJwqRrTZXwEwwdJrDmNiqmTuecaqnolpwSmV+6/4Jt6Z/+lkMk+c76IzgtKRuft8DR8fkxybYO2UtcCJpDtGraOsxgjAjqK7H40MfvOmmZCX627z/CZXr33BH8uCB1XoznBkCIfcxCM8RxMl9Q1g845d1w4CgISe9sLUL4+andg74x5z/8BrZthOgakrNlyXPib+80fRnbAINjYjxlFfx/UWTvMVJzME8IOoYscHRwsy5eF8D04g6sivhkWMMSWEcoSEZ2E9XpNN3lRFnUUE2j1PZlNZHgj5GI1ed9STDTzi6rZVmX0Jd29N4IpqaMRO0szSG3QQJO5CIN7qhS+Y4BjjocMWbgndxlCUq4imJz1SZ4WI4SeR1Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(230922051799003)(1800799012)(1590799021)(64100799003)(451199024)(186009)(55016003)(1580799018)(9686003)(71200400001)(7696005)(6506007)(26005)(38100700002)(82960400001)(224303003)(86362001)(38070700009)(33656002)(85182001)(2906002)(41300700001)(52536014)(83380400001)(4326008)(8936002)(122000001)(5660300002)(478600001)(316002)(66476007)(110136005)(76116006)(66446008)(66556008)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dFd0RjcrZm9IeUR5Uy8zWUIwdmRqZDJnYU0wK0E3TEVvb1BXVVJUMGxjemZT?=
 =?gb2312?B?bytXZ3NMUG1OTmxlUHRvNW95WVVVMFZnMkRnUFQxaWVVSmpVZk9hQXRZYlBq?=
 =?gb2312?B?SjU1MHF1YlZYMnhLZDJmTmNWbWhrYk5TcUoyZloyZGs1U2VVV3VrV1h3Wmd0?=
 =?gb2312?B?U0E0cVVRQ3lFczQ0ZjgxckU0ZFNlNnlGcndWNG8rczJ6azVNcUlncEEyRTg4?=
 =?gb2312?B?OU5jc0RDTTFHRG1sVWx1M3hia3QybHlNS0hJQ1BLWDF6MUs5b2Yrbzgwd2ls?=
 =?gb2312?B?VUxZa1NjY2U5TGpqbUllSy9NMVBBTGJGR3VCd2JIWU9yTW83bHRMT2R5bEsv?=
 =?gb2312?B?WnZvWng5cVB0Y1lmcFB5cEM5YktaTm9TNDJkSWw0dmhKclJOcUVrNE95SUZ3?=
 =?gb2312?B?eVpQVXJRQ1lQT2V2bGQzeXJ4UXlueUJkQ0MwOWJGT2xXQU51N2xCUy9acytz?=
 =?gb2312?B?RGpWbmtmckg0V0xDb3cvdjFlbVlGcHJmeU5CWitFdFJOOWhka2VvZnFub3Az?=
 =?gb2312?B?a3NMWFFlUnA0ejdiOEN3U2hMOUIwRmdleXRjazhaRlhNZFdQOHljVjNKRWVk?=
 =?gb2312?B?dHdMWW5Ib0pJeEdhM0hSbmxocE5oNkxwNzJBTDBYWlYzRTNSUzR3dnhxL1Ev?=
 =?gb2312?B?cnM4dWk2c1k1eUkxa2dpUXFGTUg4V0V4V3dPWmplTXVxTU5Td0xIQXEwU1hv?=
 =?gb2312?B?dUErOVhheDlYK2EwZDBuQkRrTllUekpqNUlESGtwZ2V1dTA3a0M1WmEyUkJP?=
 =?gb2312?B?Q20rYlJUTTBsQy9uRC9HZmpMR1BBWXBPOHFuaTM3My8vQWs4b0VoRUV4ejhi?=
 =?gb2312?B?SGM4UXVpQlQ2dk44V2svVGQ2TkNSUTI1cHRWRHBQNnBzWkQzU0xDREkreVhX?=
 =?gb2312?B?TVg4bkh6b0ZRNEZxbWRuVXVFMXZmL2p4WmVOd0U5WlBlRHhQU0pzV2MvY1Bo?=
 =?gb2312?B?ZXBQeHZSSm1HVDdJMEhqUXJsUjlVNG1keWZIWDh3ZUU4K056ZGhORmVLbTVD?=
 =?gb2312?B?a3AxK1FXWEN3WklxVlpmT0daV0JINTdHWC9qL2ZLaTNsNnVYV3FMYVk2dDhD?=
 =?gb2312?B?ckQzUTFqbms3OWpDZEtNNzFZSjlwMWcxMHRNeTlHUkdqMzhkb08zeE1WVlo5?=
 =?gb2312?B?eDZ2eVEzVmdmbnExUEV3eGt5Z1hydnF4VWY4OVJXaGorRWtTUUdUbkJVRGRL?=
 =?gb2312?B?WG5xYk1YbEdBc0xvYlVsblJPRmhBM3FqYWJBNnU2NHFGMFQ4YmhUVGFoK1JD?=
 =?gb2312?B?Zk9nN3JCdHBWL3JWNDQ5eEYvVU0xVFNhRURhbzRyWWtHc3VYZmhrV1ZPWm55?=
 =?gb2312?B?R0ZVTW80UDFmam9pcWpIMWlxU2ovOGNNb0F6Sy9DWGQvMmVSYXRZTm9mY0Jh?=
 =?gb2312?B?dm5ZWVU1Q3ZSNUN3c3JpNHlWcDlqQXZpOEkrZFc3NVpNWE5oYzN1YWMwdmYw?=
 =?gb2312?B?bDMrVUxxT0xONVlVZkpPNmJvc0tOaDhscHFrZFIxaUQ4dHlFUDV2OUtXQmhW?=
 =?gb2312?B?SEVWV1JLbXNWLzZmWktFb1MwbGFuRmFNbkkyK0R4dUd1emFUZHJ3anpLcDZM?=
 =?gb2312?B?LzVxbmJkN0RhOW80aXlwK3I3b2RnYUhtbjg5T08wWWdLRUIvWDRRejF3UnZW?=
 =?gb2312?B?alFCelY2M0xxQnJscjA5NkY2M0hab3hoNWRBWnN4QnI3YmxlZEpDMFhSZHFP?=
 =?gb2312?B?OHdiOVBPNjc5VVQ4a1FRNldCNmo5VVFiRHE4cFYzYkxhdnFJUUhWakZMSUZO?=
 =?gb2312?B?Z0x0ME8zSzNqRVo5ODBlZUcrTldaVC8rYkdkTzZpc3RhMmNFSzdCbVlHTVBT?=
 =?gb2312?B?akt5b29TM3BtRVBsU2twd1J6WjI1MGlBdmErTGRMZ0RWM1FVc1FNZUpkdFFr?=
 =?gb2312?B?RHE1K1I3NXlQeTdRclc3KzdzTHJJdko5NHFzYVdNd1FxbW9VbjFSZDZiSUhU?=
 =?gb2312?B?Zmx6K3Zsakl3Tlc3WFErcFpFRE1wNXVGVFRrTUVueHFDNGRmZkVjMVFqallN?=
 =?gb2312?B?YnZyWW92UTBGQXMvcDRLeDUvRk1TRHlwV0g5cDBQYXZldHNMZlZUM1JvZ1Az?=
 =?gb2312?B?anYvRFpWSzVMWU9BZHNPcXZsNVV3Sml4czJOcS9HSGVuOGVBNStNbmdIcXp6?=
 =?gb2312?Q?WzpyzwUX1QdxqDoSneywYdKq4?=
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
	0oLmjwfmGU+YTpvQECJd9jPSNYPpMCdvhCPMv7BVNMkVgs3cACW0yq6n1RIDhAoCvlepcMz2Hi+nGAi26cycXOI5Qz3Lr6KheQDaVNg9HIFdcm6qWRZMKia3c9c/qepVCz6L1zCR0pR5P7glLoCY2884FU1xIaSwnnSji1c/QAdOdcR22RROPfv3jyiVVtM64WLLfmxoQJI4vKJ601n3dxduHyhwWTgQ4TJPqinPIbBEaAtraLQJww1X5O5B34lZeQq7Yr0+5fZ8pTLzCflWxGfikODdCsWi4LwfWfbBspluNxWx+/uYMsFG+lSSEX10NCxUT4ucEpDdmwXF9u0XHFlL1givaM585tAJdO+E+hBnKEJwuaCGIgafumX9sSSjTvTekzF/kpihW8E32hkXhijhan7uCNCpZk0DkFd9pxnVPDE9MPAPDNrqZO+B6rfzi/PGV3yhLX1odvKDhdvDyc1fcYB/FLBumeMj9sYLxctqCzg54VwzOAdeKFojoDentNJNykw6izbyiMC8mVtz9MuKUEKuQa0JfZyvfPUSx2kOebyvlaiUtoA5eMmjA7z6ynQDmhi49bVpEb/LTK16g8HNfbJ1dG3JdA9/Jc6E+6pnObKTqLoWviwNWFZbe+8a
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce124cc2-be5c-4b7d-9044-08dc17daab47
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 04:05:12.3117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1kUHvtJMI37nFQIsIipV9V+UF6VsBq+KODvbqzanRKLWBs3rzjabuweU6zGlo/wjRYUMVOZhxtFTLKesl7kdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11129

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogT2xnYSBLb3JuaWV2c2thaWEgPG9s
Z2Eua29ybmlldnNrYWlhQGdtYWlsLmNvbT4NCj4gt6LLzcqxvOQ6IDIwMjTE6jHUwjE4yNUgMzo1
OQ0KPiDK1bz+yMs6IHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb207IGFubmEuc2NodW1h
a2VyQG5ldGFwcC5jb20NCj4gs63LzTogbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0KPiDW98zi
OiBbUEFUQ0ggMS8xXSBTVU5SUEM6IGFkZCB4cnB0IGlkIHRvIHJwY19zdGF0c19sYXRlbmN5IHRy
YWNlcG9pbnQNCj4gDQo+IEZyb206IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29t
Pg0KPiANCj4gSW4gb3JkZXIgdG8gZ2V0IHRoZSBsYXRlbmN5IHBlciB4cHJ0IHVuZGVyIHRoZSBz
YW1lIGNsaWVudGlkIHRoaXMgcGF0Y2ggYWRkcw0KPiB4cHJ0X2lkIHRvIHRoZSB0cmFjZXBvaW50
IG91dHB1dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBu
ZXRhcHAuY29tPg0KPiAtLS0NCj4gIGluY2x1ZGUvdHJhY2UvZXZlbnRzL3N1bnJwYy5oIHwgOCAr
KysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3RyYWNlL2V2ZW50cy9zdW5ycGMuaCBiL2lu
Y2x1ZGUvdHJhY2UvZXZlbnRzL3N1bnJwYy5oIGluZGV4DQo+IDMzN2M5MDc4N2ZiMS4uYzFkNTAw
YzNlMDMxIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3RyYWNlL2V2ZW50cy9zdW5ycGMuaA0KPiAr
KysgYi9pbmNsdWRlL3RyYWNlL2V2ZW50cy9zdW5ycGMuaA0KPiBAQCAtNjM5LDYgKzYzOSw3IEBA
IFRSQUNFX0VWRU5UKHJwY19zdGF0c19sYXRlbmN5LA0KPiAgCQlfX2ZpZWxkKHVuc2lnbmVkIGxv
bmcsIGJhY2tsb2cpDQo+ICAJCV9fZmllbGQodW5zaWduZWQgbG9uZywgcnR0KQ0KPiAgCQlfX2Zp
ZWxkKHVuc2lnbmVkIGxvbmcsIGV4ZWN1dGUpDQo+ICsJCV9fZmllbGQodTMyLCB4cHJ0X2lkKQ0K
PiAgCSksDQo+IA0KPiAgCVRQX2Zhc3RfYXNzaWduKA0KPiBAQCAtNjUxLDEzICs2NTIsMTYgQEAg
VFJBQ0VfRVZFTlQocnBjX3N0YXRzX2xhdGVuY3ksDQo+ICAJCV9fZW50cnktPmJhY2tsb2cgPSBr
dGltZV90b191cyhiYWNrbG9nKTsNCj4gIAkJX19lbnRyeS0+cnR0ID0ga3RpbWVfdG9fdXMocnR0
KTsNCj4gIAkJX19lbnRyeS0+ZXhlY3V0ZSA9IGt0aW1lX3RvX3VzKGV4ZWN1dGUpOw0KPiArCQlf
X2VudHJ5LT54cHJ0X2lkID0gdGFzay0+dGtfeHBydC0+aWQ7DQo+ICAJKSwNCj4gDQo+ICAJVFBf
cHJpbnRrKFNVTlJQQ19UUkFDRV9UQVNLX1NQRUNJRklFUg0KPiAtCQkgICIgeGlkPTB4JTA4eCAl
c3YlZCAlcyBiYWNrbG9nPSVsdSBydHQ9JWx1IGV4ZWN1dGU9JWx1IiwNCj4gKwkJICAiIHhpZD0w
eCUwOHggJXN2JWQgJXMgYmFja2xvZz0lbHUgcnR0PSVsdSBleGVjdXRlPSVsdSINCj4gKwkJICAi
IHhwcnRfaWQ9JWQiLA0KPiAgCQlfX2VudHJ5LT50YXNrX2lkLCBfX2VudHJ5LT5jbGllbnRfaWQs
IF9fZW50cnktPnhpZCwNCj4gIAkJX19nZXRfc3RyKHByb2duYW1lKSwgX19lbnRyeS0+dmVyc2lv
biwgX19nZXRfc3RyKHByb2NuYW1lKSwNCj4gLQkJX19lbnRyeS0+YmFja2xvZywgX19lbnRyeS0+
cnR0LCBfX2VudHJ5LT5leGVjdXRlKQ0KPiArCQlfX2VudHJ5LT5iYWNrbG9nLCBfX2VudHJ5LT5y
dHQsIF9fZW50cnktPmV4ZWN1dGUsDQo+ICsJCV9fZW50cnktPnhwcnRfaWQpDQo+ICApOw0KPiAN
Cj4gIFRSQUNFX0VWRU5UKHJwY194ZHJfb3ZlcmZsb3csDQo+IC0tDQo+IDIuMzkuMQ0KPiANCg0K
VGVzdGVkLWJ5OiBDaGVuIEhhbnhpYW8gPGNoZW5oeC5mbnN0QGZ1aml0c3UuY29tPg0KDQpSZWdh
cmRzLA0KLSBDaGVuDQoNCg==

