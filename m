Return-Path: <linux-nfs+bounces-1172-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F14682FF3A
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 04:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670431C20997
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 03:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F9A17E9;
	Wed, 17 Jan 2024 03:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WC5FbHjv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3810F5
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jan 2024 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705461300; cv=fail; b=SwHVHk7DKimlnEb1SySdJbCnJmn5JuLeZr9wEYAog/YVVsgWLumWVBnkIrj/1qiejVBwVpc93cNmRxUoNEPNl9lWRScVCwLpzuZzBfzUMIdZOvg7QnI0bZh5f2Zynk8btVaylKSgsxBtaZF7UhI6VpREq82x/6RBHHhBaItqP2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705461300; c=relaxed/simple;
	bh=ByY1LEOZUVlLA7edPKN9SD1WRELKCMN9Mh8H0vcVUJM=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 From:To:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=O65z6tKKB49jidap/VWIImM8VM1EzC2ZHCM3EW/qf9aMWW3la8GWLsTHdmHtThY9Sm/afOvw+R+PffCEMIFGx/qjNnrgX0hsHQpQpF/jrHNCwdj0C+WxMwxWFKETJImpEAeRiC/PhMUdy8AN6F0dQYdXueyfIUbEHzAxyuSctp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WC5FbHjv; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705461297; x=1736997297;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ByY1LEOZUVlLA7edPKN9SD1WRELKCMN9Mh8H0vcVUJM=;
  b=WC5FbHjvfqMVW201QysFFs5QyyIQPSbJiTpED03Lw9aspCYN83muA1Lw
   NV+OScVg24PuEjzhecW2GGAZ3Oi1J3+paXVhM4ufH2Pw+QkQRZAbmSUiV
   mUAbKp06eFEAE1VgnupZw03I9TwVP1qmOBx1okYPP2CkWFqPt2563iBce
   wNpi82i6EFPD+YuZyIpTvcrXnthyJMQq2gQlePtDFc8fyDfYiIEoYCp/L
   Z9Ysv0yuP/Krhy5/irRVgx1i9CuNpkzVYwXq5phJYSj0q8qjataPLXT1c
   mlnaWk4cHu//kb8PcMiesDRqP1gGz213i5mP34UkKT/H0nYtld+cGSoop
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="109093148"
X-IronPort-AV: E=Sophos;i="6.05,200,1701097200"; 
   d="scan'208";a="109093148"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 12:13:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuH0DxBM7nAhasKNSfa3bB9GN4eAe7DMixmZNuzXBa5tsm7a2uqhGVd8Orw1a+vXT8tdKQqNHbVUJzlosIN7Yh8wvOrTQRf6NZ8V8EhqfmxlaErBUyk68KwW2ZGMKI6fSUTuJtPZe4JhbGUkvSKJTNYTZUdaBAcBuDOLUR6HF/9l2ykO21Ynd9qvczqkkescCCAl8OApnREiLsuBxpY3DAcC7MS/bu6A6t44nhiSfockRLZsvB8IDkDvs335qlB76IWFsv7pWNIKomp3O4/ivh2suISD5o0gNSiCddS3HzwcpcHuT1Hfwq9C2D/t/b+QynUS49mWLU5LZ7YLPZ2Y2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByY1LEOZUVlLA7edPKN9SD1WRELKCMN9Mh8H0vcVUJM=;
 b=GWHoCOx+IcoE+Y8yb7b3e3u8m7dxKERmonmzcjYCBbdsVbrB7n3uqqmyfhc0Z+w8N+zQif4h+WDJnxJH5IrnfeCSUSm2/JLn4YUx0Vd2IY4mSi7X9BU4HCO/8Y9R5tXi8wkSKJbCNEPo/OErp/Nfjzq9Iu32AT8iBZD4t+0zM4WeMA1EIReiqA7ugAqHSEBZFkb+5QQqeTMMlmQIFgDCsM85B3B82W780F79LUmnTDwNMMOmTRiRYQ4G0xZCBE8K2FBb81VmzjFqrbrdDiXBP4ljGfQ3uAWgU4R5X69NuN3puAHlqo+aR/Wp75E/eK3B9pka9y8Lrlh+5O2V76H3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYWPR01MB8871.jpnprd01.prod.outlook.com (2603:1096:400:16a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 03:13:42 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::6f98:dea4:77ac:1184]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::6f98:dea4:77ac:1184%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 03:13:42 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Dan Shelton <dan.f.shelton@gmail.com>, Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG5mc3Y0OiBBZGQgc3VwcG9ydCBmb3IgdGhlIGJp?=
 =?utf-8?Q?rth_time_attribute?=
Thread-Topic: [PATCH] nfsv4: Add support for the birth time attribute
Thread-Index: AQHaR31aao72mlpCTUWiCOonxRJgPrDboD0AgAALigCAATdMgIAAWWbQ
Date: Wed, 17 Jan 2024 03:13:42 +0000
Message-ID:
 <TYWPR01MB12085B345BEB39434B15A2B45E6722@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240115063605.2064-1-chenhx.fnst@fujitsu.com>
 <CAAvCNcDxZF-ftqb1dRnjUW-q-1m2kyqN-MAGNXUd+i1r_b_vSQ@mail.gmail.com>
 <0CDB9C6D-5BC7-4E99-8B08-825424D0DD4F@oracle.com>
 <CAAvCNcCZ=uGxUN=9ztF6iOPsxdYUDYc2JeRrZxC4XPYOPW22uw@mail.gmail.com>
In-Reply-To:
 <CAAvCNcCZ=uGxUN=9ztF6iOPsxdYUDYc2JeRrZxC4XPYOPW22uw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZTJhYTJlMzAtNTRmYy00ZmU4LWIwNWItNjhmMjdlYjZj?=
 =?utf-8?B?YmJlO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTAxLTE3VDAxOjM3OjQwWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYWPR01MB8871:EE_
x-ms-office365-filtering-correlation-id: b9996a63-f175-4300-7364-08dc170a4efb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XRTAIFT1kADeame5x2aMYi2jpsvejl2POJzYxbuzBlh87b1eBrRMwQXry1SrQMEkDp/8WEnHUVudradqiP0dZFn5LbimyKKLLOajVUpeSibxJb/qjKZDNljwA7QDCfDt0u5s9sEVaKmMrc1qjPoY2VAyzyMLXJyeHr/0ZjYMOYawnG7sXMLs5Z6ZCJSXUBFUSgFOqrhTblfWP+7Zlm/LIhbwXSSnP0NNkvuGBLfPXZwmzUdwUogrhM1hKhuvp6vfwEcq0O9J6OV6HtdK4HH+w2TUQ69VKYvDtRRoLx2rgWuZxffa51IBBZcNsU+B3DClKWmBLCPZ5MWPTNpb/yNFmrpdsLW1Zu7OzrXvFg3qi/XYTnZz4kpz8NKpmjYUjcDCIYV3vgiMfM7pnib1YER2PUb/6UuA6K0XHLJBVmIWT5fZaNMB3haoV0djL9R/DoiiDhJGeCDnAgzLV81110y3OZNkqlDJ6dYOA/dT/HmsiDLdju1j96LBSVBOWjn2ZgBoIAqR+bpwbTs4dAVMsoegkV1JypwcBqmxXb5EdA5xYPrpZ0Et4XEtCz+ce4rhzCQKaqaLnipTSjxMokSP1OXQmYP9VzM+a/M7HdcUduOD7DCGMd2+B+M6UNmJLluMohB3kkXoCl5AFctKAQ+D6FZ69dWoU0C0crI2HSP+pkmot1Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799012)(451199024)(1590799021)(64100799003)(186009)(71200400001)(8936002)(5660300002)(66446008)(66946007)(66556008)(66476007)(64756008)(316002)(2906002)(33656002)(26005)(9686003)(85182001)(224303003)(86362001)(52536014)(76116006)(110136005)(82960400001)(53546011)(966005)(6506007)(478600001)(7696005)(55016003)(1580799018)(41300700001)(38100700002)(122000001)(38070700009)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1NkMmtlSzJxMmpNeFhxM2E1eXRUZEhhTng0WW82cGNpTm40V29xb2Zqem5q?=
 =?utf-8?B?T2VnK1hGM3F6Q0xsYjlWRUVocmdXOHFFelc1R08xSTZZNmhIZW9rRVRZVllY?=
 =?utf-8?B?YmYrck11Z2c4Yml4TndtSGJpNFlncTdMZENxVjZ0c0RWcjUxZjNsaWRUZ0pt?=
 =?utf-8?B?V0cyWCt2dktFb2RPL1hrRmxGZU0rM0NsRGJpVUM2NDU3QSt0Ynh2Q3loWSsy?=
 =?utf-8?B?bG4wQW5PNzBLR1BiRGp5ZW5uUXlRRmR1MU5oZ2NzczdHakNaVGJoVjBqLzRr?=
 =?utf-8?B?USt2WExqVDRGWE5Ca2s2dTNKRStORDV4RktRZ2prZTdIaEJMT1ZZV3JqbDcv?=
 =?utf-8?B?RXhzek1nSlMvbFk1dzZGMk5LSDhiYzVOVStnKzNuRkl0ZGRsYkNVczNxQUpp?=
 =?utf-8?B?ZEw2d0Q5L0FIR0hCcERmMHFkZHpwajBIRVFpQ21DdHhBZE16eWZWMC9OOUkr?=
 =?utf-8?B?UHd3aXRVMy83MDkwelRFem44d2JhQkNVWkpPYkRjclBwSlRQaVE3WmdPRTdI?=
 =?utf-8?B?b0pvc2U3SU5oOEZxRm9MZm9wRUc2cmFuUm1BWGhFSjdHb0VzbjMzY21pdko1?=
 =?utf-8?B?VVZlWUZQaytNRXlPUmFrZlplSnRsWHZPQXZraUFwT3duZ3BkN1J6ZzYycjhp?=
 =?utf-8?B?OXVubU8xcHNNdTcyS3k1aFNmL1hXWWRMNUd5Y2E5ajhYbHdlZTZMTEZtZWdP?=
 =?utf-8?B?RE9NcklwRFprOWlLekVXMU5SWCs2cUo4ckdubmlSSFRtbGgzK2xiWFN2YkJS?=
 =?utf-8?B?ZXU3dnRyT01XUkRyQW1NWFJyaEVjRFdINHVPTmdWY1JrS2JvVlBsV1pYajVJ?=
 =?utf-8?B?VzZnU3loTGdBL1pnNSt2SDJjN3NvOExhUmxJdURxQVNFQytHMTVsWXdrVm1t?=
 =?utf-8?B?U2s2dURxVVdYSlVUZ2xLTTBnWTNyaW56aUVPaW5LVXFVazRHcC9JL09aWldU?=
 =?utf-8?B?MXE4TUNZNWJrTC83anBKbFFQa1R0N2J1QUhJUDJkR1VHeEtMeS9oMjJsc2o2?=
 =?utf-8?B?bjVGd2VMZTEvYk84MGhoVTN0L2tpWkZJOWR4dUJJaWVuNHU5bk5PYWJmNHZB?=
 =?utf-8?B?NEc2blpKaDJNZkJvNUFuaDU2Nk5hcHNuNzNEdXRQOSszVktkb2xKV3RITllZ?=
 =?utf-8?B?amUzZDVwWG9zMEtxZ1V6U0ZkVGNMM1VOck5VaHNHTEs1WlA2KzdKTlNrUGdv?=
 =?utf-8?B?cmdJazJnVGtiRjIyQlRiNm9aYk9TaFdCWmdkQzQwS2lpY2VxdXZUaDBhUkkv?=
 =?utf-8?B?bCtUSnhFa3U5QlNBV1ZNcnhnbVpDdzFoZnlBYzljdFEyQjRFN2c1bHhXNlVN?=
 =?utf-8?B?aFBYZUJidlpOdnlXUnljdy9INk40dGg1VnJrU2wyZlBUNGxwd3c5aUJHckhy?=
 =?utf-8?B?cWw0UUZaN2wyRjMyZTUveEV3TXhmeTFpZnVQWWdUQ0U2NkFDUDFSOVlyQ0hY?=
 =?utf-8?B?U3FzVUtrQk9HeVB1bkorZTFhQk1nRnV0YTdFQ0sxVEZRZldPbHBlcUN1bGpR?=
 =?utf-8?B?Zm10dFpKWWtBdk93UHQrcDNrVFZ3MStKV0hsMVRYYXQ1NjNIZHNpMExtQUJN?=
 =?utf-8?B?NS95aFU5UC82NGpVbjVUQnhIdW5ONFVWa2ZOenR1dlhnOElaMjAxRVpMRjZO?=
 =?utf-8?B?Mms4by90ZStoeTE0Y3FhVDBoanJkcFlVSVBiRENZU1Z3Y3JDNW5YN0hsQXRL?=
 =?utf-8?B?d0lQZ1EvTzdiS1UxZW1UcXVtS3IwTTU2c3BvVXliaG01am1hemR6ekt4VWxP?=
 =?utf-8?B?aGdGOFJGTEY3dXNJdUwyTnI4Ukw2dGMrdElKVTVyelpFeDQyM0pDNWZrdm5R?=
 =?utf-8?B?SmtMald3bWhQOHhCckdEbmdHRDd4SCsvZVpuQkd0KytpZ3pwaTdIaEpoS2xm?=
 =?utf-8?B?RlhUSHpybFNiQk9KSDNwcnpiaXMvcVVhbEFRSm9vZURqNmdZZ2ZQVEVoU3Mv?=
 =?utf-8?B?RjJTQlY4d3dCNXRjajVQUmsxMEtHNVZOUjd5STVKcDVIbVJzZjhXdTQ5S3ZV?=
 =?utf-8?B?T1J0UXZobVBQVjhtak5iSXV2TlZ4U2tSL1BYWCtqVTB2Y0lQVCtXYTVVeUI1?=
 =?utf-8?B?TG5ub3A2OVJEQWtROUtkMmszZncyOTNzQWtZcmtlOHF0WWxNV1lZTTdVMDI3?=
 =?utf-8?Q?HZcyvVUlDhnsmF94ITHLPqzEi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QVRcehgGXRCUDoBkq0TY+SrLR6uONHWcTa9psYsaILSWIbkkCynyS2rekU4U7JHpvTg+7fZzLbXtXtHHrA33WzDUn4Zw0ZUy298o5Rroff5c/OYJwhmgdboD3LsxVaE9bxZyPV5DWm5xCKJv3kTqscFZraMn+HS2XYdWxh5saGELwKUkeKS4LsAeAFDMeauYprHkFCm2XXNkB4t+w1YCLFUh8ofu2hfDTsuX3Nuk0kTR3ZXeN7TdI3lRSQ1oIMXKbmG0woSOm2w8pWupYtklhU4ukwrUB8WB1IUq2R9q56SnpQkvCHLlWfmxzlUpj8kdnx3Yb8bfUZ30tpyO+DI3qVUK5f2xLaS5wCynB52eNJ3ymoGNRokRTl5KtwRuLkGozImF2ADt5B9Rgd6lkNUNeE8orUcLPS3bBtvcEG0IvcarAR2RzdTHK3enh6qMFMVANwGNxetH2IcraJguxbOOsPhsI7UWjEnTKDMVkAYZjZNOfXaVzhxxYTXSIIuXenAvWaNC8R7ZTg2U8rEPb7RHW+3GmXqxCU4XkB2LvxxsATSEE9sZhTP3HhoTRgcVIlglyf6hnGg9ZgtMH72lfkkcRaeFovGO5/U72PGUZ786nebgqq8QvYSPcXhXdHVdyYQG
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9996a63-f175-4300-7364-08dc170a4efb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 03:13:42.1635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rDs/7bb3cCrBYh3wIHcZbiy8hDv+M+oXWTybQrpy/oy4TH9x7wD8sW912ZYsG4shp0434GzFzRI4EbdzVtfqJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8871

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IERhbiBTaGVsdG9uIDxk
YW4uZi5zaGVsdG9uQGdtYWlsLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI05bm0MeaciDE35pel
IDQ6MTcNCj4g5pS25Lu25Lq6OiBMaW51eCBORlMgTWFpbGluZyBMaXN0IDxsaW51eC1uZnNAdmdl
ci5rZXJuZWwub3JnPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0hdIG5mc3Y0OiBBZGQgc3VwcG9ydCBm
b3IgdGhlIGJpcnRoIHRpbWUgYXR0cmlidXRlDQo+IA0KPiBPbiBUdWUsIDE2IEphbiAyMDI0IGF0
IDAyOjQzLCBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0K
PiA+DQo+ID4NCj4gPg0KPiA+ID4gT24gSmFuIDE1LCAyMDI0LCBhdCA4OjAy4oCvUE0sIERhbiBT
aGVsdG9uIDxkYW4uZi5zaGVsdG9uQGdtYWlsLmNvbT4NCj4gd3JvdGU6DQo+ID4gPg0KPiA+ID4g
T24gTW9uLCAxNSBKYW4gMjAyNCBhdCAwNzozNywgQ2hlbiBIYW54aWFvIDxjaGVuaHguZm5zdEBm
dWppdHN1LmNvbT4NCj4gd3JvdGU6DQo+ID4gPj4NCj4gPiA+PiBUaGlzIHBhdGNoIGVuYWJsZSBu
ZnMgdG8gcmVwb3J0IGJ0aW1lIGluIG5mc19nZXRhdHRyLg0KPiA+ID4+IElmIHVuZGVybHlpbmcg
ZmlsZXN5c3RlbSBzdXBwb3J0cyAiYnRpbWUiIHRpbWVzdGFtcCwgc3RhdHggd2lsbA0KPiA+ID4+
IHJlcG9ydCBidGltZSBmb3IgU1RBVFhfQlRJTUUuDQo+ID4gPj4NCj4gPiA+PiBTaWduZWQtb2Zm
LWJ5OiBDaGVuIEhhbnhpYW8gPGNoZW5oeC5mbnN0QGZ1aml0c3UuY29tPg0KPiA+ID4+IC0tLQ0K
PiA+ID4+IHYxOg0KPiA+ID4+ICAgIERvbid0IHJldmFsaWRhdGUgYnRpbWUgYXR0cmlidXRlDQo+
ID4gPj4NCj4gPiA+PiBSRkMgdjI6DQo+ID4gPj4gICAgcHJvcGVybHkgc2V0IGNhY2hlIHZhbGlk
aXR5DQo+ID4gPj4NCj4gPiA+PiBmcy9uZnMvaW5vZGUuYyAgICAgICAgICB8IDIzICsrKysrKysr
KysrKysrKysrKysrLS0tDQo+ID4gPj4gZnMvbmZzL25mczRwcm9jLmMgICAgICAgfCAgMyArKysN
Cj4gPiA+PiBmcy9uZnMvbmZzNHhkci5jICAgICAgICB8IDIzICsrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gPj4gaW5jbHVkZS9saW51eC9uZnNfZnMuaCAgfCAgMiArKw0KPiA+ID4+IGluY2x1
ZGUvbGludXgvbmZzX3hkci5oIHwgIDUgKysrKy0NCj4gPiA+PiA1IGZpbGVzIGNoYW5nZWQsIDUy
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pIw0KPiA+ID4NCj4gPiA+IEhlbGxvDQo+ID4g
Pg0KPiA+ID4gV2hlcmUgaXMgdGhlIHBhdGNoIHdoaWNoIGFkZHMgc3VwcG9ydCBmb3IgYnRpbWUg
dG8gbmZzZD8NCj4gPg0KPiA+IFN1cHBvcnQgZm9yIHRoZSBiaXJ0aCB0aW1lIGF0dHJpYnV0ZSB3
YXMgYWRkZWQgdG8gTkZTRCB0d28geWVhcnMgYWdvDQo+ID4gYnkgY29tbWl0IGUzNzdhM2U2OThm
YiAoIm5mc2Q6IEFkZCBzdXBwb3J0IGZvciB0aGUgYmlydGggdGltZQ0KPiA+IGF0dHJpYnV0ZSIp
Lg0KPiANCj4gV2hpY2ggTGludXggdmVyc2lvbnMgKHRydW5rLCBMVFMsIFJUKSBoYXZlIHRoYXQg
Y29tbWl0Pw0KPiANCiBGWUksIA0KIENvbW1pdCBlMzc3YTNlNjk4ZmIgd2FzIGluOg0KICA2LjYg
TFRTIFsxXQ0KICA2LjEgTFRTIFsyXQ0KICBTdGFibGUgWzNdDQogIFJUIFs0XQ0KDQpbMV0NCmh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51
eC5naXQvY29tbWl0L2ZzL25mc2QvbmZzNHhkci5jP2g9bGludXgtNi42LnkmaWQ9ZTM3N2EzZTY5
OGZiNTZjYjYzZjZiZGRiZWJlN2RhNzZkYzM3ZTMxNg0KWzJdDQpodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2l0L2NvbW1pdC9mcy9u
ZnNkL25mczR4ZHIuYz9oPWxpbnV4LTYuMS55JmlkPWUzNzdhM2U2OThmYjU2Y2I2M2Y2YmRkYmVi
ZTdkYTc2ZGMzN2UzMTYNClszXQ0KaHR0cHM6Ly9rZXJuZWwuZ29vZ2xlc291cmNlLmNvbS9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LXN0YWJsZS8rL2UzNzdhM2U2OThmYjU2
Y2I2M2Y2YmRkYmViZTdkYTc2ZGMzN2UzMTYNCls0XQ0KaHR0cHM6Ly9rZXJuZWwuZ29vZ2xlc291
cmNlLmNvbS9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcnQvbGludXgtcnQtZGV2ZWwvKy9lMzc3
YTNlNjk4ZmI1NmNiNjNmNmJkZGJlYmU3ZGE3NmRjMzdlMzE2DQoNCg0KDQo=

