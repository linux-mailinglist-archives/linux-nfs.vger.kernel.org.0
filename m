Return-Path: <linux-nfs+bounces-1174-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1A182FF67
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 04:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F71F2886F5
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 03:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B17A4439;
	Wed, 17 Jan 2024 03:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hmDYxXb+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98D4416
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jan 2024 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705463603; cv=fail; b=i7Uwl7bqYYi3xr0UuTktpar90QBrHpKHrlg+3M6WpqRKK05DWWitA+/VTaWx8d21TI2TS4xezNORgZXVBKqf0mn8AlV/+r2POoq1YesmIJicBpIjE4WtyXucW1WfefUEwdTIVRA9UAD40N6X9ou2FfWUbpnAFDmtZQFUtt2ncMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705463603; c=relaxed/simple;
	bh=zycwBUQ1QTVv0UxFlEV4933Sywu16L28XRUfzzsu3/Q=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=B7jrvcMfEMMQlZ699jVOdgttxMfha1hjTsfQANcsXuI4ugD7UZbSg4wc5qMK7SE/m145PEjlvKhsesXQ+yPnoaAhcl5clU9JeEByf06us3Aeq0UIwnwouMnziSyg2T6l9i1CC0er+q23XhgoROlfMibwe82+tOau8AEsd3wuKeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hmDYxXb+; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705463600; x=1736999600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zycwBUQ1QTVv0UxFlEV4933Sywu16L28XRUfzzsu3/Q=;
  b=hmDYxXb+ozP+Wp9ANOhnNlnGb1+DnOim4ctwJI4IVuJdQriMGMohxCMm
   eyZBi9DSFZ6ncbDF56ncnhvPFgp5lSbrdAmCagmfyb4RYndNkZEZesb0E
   qXUcKm9i/zEVtzkei2BW10bStgfYXbH8ByYoZ4Ft78r3K4P4TSuJvjm53
   raqEZDF1NACpu73RmNzABoVfDKMnOdNKzfZCjzTg91hwbhbsE5gpWEIeS
   IePqjbx+aEFMKZtqNTRo/zOX09E0/Z9VeaZ/DV1g0OBFcbPSB3dUZXTHX
   z/cVdDoD2RXjEON4cVXymNUDsk2rhPB89woz+WoF8I0Rec1PPip13xGi8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="108395223"
X-IronPort-AV: E=Sophos;i="6.05,200,1701097200"; 
   d="scan'208";a="108395223"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 12:53:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfz7cLBkzBz8DHwM9CR61FB44JVwwtiTeppmH76THBUtWqKU6E3IXhQLADHIsp9THWRUp3Il3Y5TFp2Ys3BDHZad9CjQwfZ/VlUXPt5qfItAELRvHdIyEkir3ZtDZur/75nX0NRU8JP8iwfBTbL94wR15L4EnbNg4mJKu9nz3qUjPk9pRs30uTlCZjgyjCJYb1esjpecCefVuFThyLhTDFNTaI8hz5lJy+ToaNY2SvK9uNLEOlCTVmNVHapMd4iaZHRAODKy+914SQACDa2X9l08uPkKGzpqArikyOICztOHpJNKCZb5CgIyUjM1+uxYG0WSJrkEqQfVG4BrVlMuUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zycwBUQ1QTVv0UxFlEV4933Sywu16L28XRUfzzsu3/Q=;
 b=lDM14J+9bqwMFk4uPnqw8Gm1k4YOHcCK5h/be+PvvR45JfVflXU+i83SK/BKWZk2p2/yLJmqXdkSwqPQoldaG+Hsa1v56Y2DzGsHaqGEZ1+F6faqlvw/pCmoY4DHtriVe7AzQqzZhyDea7tIVw5qIkMD4L9LMnk0zmL48nZZGnXZJAtnxjcwXfJvmhg/1P+tDQ5UPXwc4Aj6z+HbX0/w58P74eeDz/mdBGhPKq78Zar9o6hXABnapYLrFCxra2lOE5v39WMg9lu3fERg+yaXy4HpVgohCG4YFv19DcbUNObCn8a2P6S+JRw8AMIJQOHuOF5AqhkG7A3WXDfg2HkrLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYCPR01MB10364.jpnprd01.prod.outlook.com (2603:1096:400:240::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 03:53:11 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::6f98:dea4:77ac:1184]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::6f98:dea4:77ac:1184%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 03:53:11 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Chuck Lever III <chuck.lever@oracle.com>, Dan Shelton
	<dan.f.shelton@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG5mc3Y0OiBBZGQgc3VwcG9ydCBmb3IgdGhlIGJp?=
 =?utf-8?Q?rth_time_attribute?=
Thread-Topic: [PATCH] nfsv4: Add support for the birth time attribute
Thread-Index: AQHaR31aao72mlpCTUWiCOonxRJgPrDboD0AgAALigCAATdMgIAAbtKAgAAMUVA=
Date: Wed, 17 Jan 2024 03:53:11 +0000
Message-ID:
 <TYWPR01MB12085984C288834462A49DDABE6722@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240115063605.2064-1-chenhx.fnst@fujitsu.com>
 <CAAvCNcDxZF-ftqb1dRnjUW-q-1m2kyqN-MAGNXUd+i1r_b_vSQ@mail.gmail.com>
 <0CDB9C6D-5BC7-4E99-8B08-825424D0DD4F@oracle.com>
 <CAAvCNcCZ=uGxUN=9ztF6iOPsxdYUDYc2JeRrZxC4XPYOPW22uw@mail.gmail.com>
 <0A8A7C46-F59D-4635-A4A9-55D297A9D01C@oracle.com>
In-Reply-To: <0A8A7C46-F59D-4635-A4A9-55D297A9D01C@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9M2I2YTFhMjctODJjMy00YTNhLThhM2QtYzA5ZmJhNjFl?=
 =?utf-8?B?NzRjO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTAxLTE3VDAzOjM4OjIxWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYCPR01MB10364:EE_
x-ms-office365-filtering-correlation-id: 7041a327-411b-45bd-985d-08dc170fd369
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ndoyJPIiZKHYZeTdHKgjDEf8ySSxfAj/6jSoLctZJ1hokE9rVWR5pIPw7/oGKpDdiBWbvz0/Njb0/8bKQW/Il/5JPt1cjsRll5qguOq0unNmPOoDCxxsxP5i5Lo7e7pcSWrLB+tKSp55frhpgDY/VbAJeSLYlFz49ae6rw5EBDoQlrt84hrfXyfk9PnmgePH4vVymHAfYVoa4gPSKPgNfjPIiSuVqIsEZJUl+a+0DbAtOq8UoBdg2Iqv6p1Nmm/LpVvvpHZV8v3v48p2Mm16T4LhJs4Teu8T/L4xlV4J5Rkpl5TsxmH3e+dIgAowygnGiMpTXaaW0x+r0y3lHVM8kitv40u7IGK33XAoxMU8jCTfbIYJZL6ShTOFl8QRMwAl3r+GTofJu+JZR342N0SCKY+G3epDJ7eKls7T60Y9/ohA3O7gOY3MMcJTnBFTFWUpjBdeV4Jb/NkGXIED5lQZkqHzJOggdl6hN0/t0Q/d1R9hriw9OSdB8ay4GA+KmNm17zV1H+ck2Yt8lPp2s/EPu6Oi3Wlx3GlyR1MFWQkf88mszX2Ls3nJxuZo5VSaesC8jn75FDiYEb74O8GWqiquhjhGsC2TJgcLUP+X4yQnSGOzTvHJgJVcbEkRGVyJePqhzfHXGreHtTNHxtZiyXMAjQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(1590799021)(186009)(451199024)(64100799003)(1800799012)(41300700001)(1580799018)(122000001)(38100700002)(83380400001)(38070700009)(33656002)(224303003)(86362001)(85182001)(82960400001)(52536014)(110136005)(316002)(66946007)(76116006)(66476007)(64756008)(66446008)(66556008)(5660300002)(2906002)(8936002)(4326008)(71200400001)(26005)(6506007)(53546011)(9686003)(7696005)(478600001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cU9jVjFrR1BSdmk1bXBBc0FjVHVjSkJYSU1BVzd2N0xlY0cySFMva0lwVVdv?=
 =?utf-8?B?Y0p0cGlLdmwzbzBsUFFSMVQ3QlZYWVJmMmsxQlRkNmJ0WE9VeTdENUFsbDFk?=
 =?utf-8?B?YmlSUDNpQU9JS0srOThJM1lqcnJjUFQ1Z3YxYnc1b0o5OU93UkV5TDBCcVV1?=
 =?utf-8?B?THUwbkpQV1BRY0ZkNXNUUkhzQlRaNGwvUnZRYzJoV0l1Z25UR2t4RUpQK3Jn?=
 =?utf-8?B?dE1KOW82VUx2NXhmV1dCQ0h2cWN4ZHo0Q3A4dDltVlBPakY1VWh2MnNHUkda?=
 =?utf-8?B?MUlxeWRGcGdzTEd3STI0OXRXbkZHeUp3T1ZkQ29EVVY4OUtaT1RPQkVQa1hr?=
 =?utf-8?B?b2JQRlREUVFJdWxkNkJYZG9GVmVuNytkL05kbytpTmxHdEtMdHZYS3lveDBO?=
 =?utf-8?B?YXlFUjhMc3BMRWNIY0Y3WnIwMUkwdmtISnBEcHp4ZU1kNE12bloxWjB5ZnRX?=
 =?utf-8?B?dWNOcFhDYjRVelRnUFg3eWMrOEV4SHZNdkx3UjlNb2NPMStqbmJqMGxIV2FH?=
 =?utf-8?B?cWJXZ0hiRnMyYnhmdU1DZG9tOG5Yb095Y1ZQTEdiT3lIMUp2cDZyMVk5MW5U?=
 =?utf-8?B?NnIxS25obXhVSUlNeTlUS1BCMm5xVXlZQ2R3WlpXUTBvMGZHSHV2YTljanZU?=
 =?utf-8?B?aFRMUDY1c052WnB5R3hSQlVSMzhlcmszWkdjLzZHZzFzT3RMMVNQZ1U3M3pn?=
 =?utf-8?B?em1PK0g0NkpKYW01TUhKc3N3ai9mM2k3VlNlRktxeXhQeWJ1VzBzUDRsbGZa?=
 =?utf-8?B?WHJQdW5va1lmS3JSejF4TTNHTG1QcDFmTis1REFoRWN5Z3FSVXJMK1BvcS9I?=
 =?utf-8?B?ZEk1YXFBZ0NmWGZSUVlLSEJCdWtEQ211NUJPL1MzYjU5bjJ6Sk42NWhzUEky?=
 =?utf-8?B?NEQvakNtTlJ5WWN1MUduWi90VzUvOVYxNjA2eE91ZjVSVmx5YVFpNUhWakpL?=
 =?utf-8?B?dUdNOERVWHY2SnFBWGhrRHJDWGlmTzVkTUNHL0l0R29mY0g1OGp0WWR0WnlY?=
 =?utf-8?B?ZDA0WnBUcGx4MHBtSmtkbU9ySmFCSCsrRGdSdFZ4aVNyV3JEcGlYUVdoNDdi?=
 =?utf-8?B?YVlqWjVBVTU0dmhFSlNmT1dabW41N25kKzJlS3BRVWVzVDF1Ty90eG4rQ25G?=
 =?utf-8?B?N0JNdU9WZy9JWE84SXlXVTVFMzd5RGR6VzB1dlZwMkpXekNvWHNMbVorYWQr?=
 =?utf-8?B?NkZnYklrU3FBbTlZNFhNUU5XQzM2R2MxSEdIMmRWSkhOcnBYMUp1WHJxQ0FK?=
 =?utf-8?B?L0ZKcmUxdzYwR1ZFb3F4YnFHcU41bjZaUVUrNTB4NnFOSWc0MVdXditxbkhZ?=
 =?utf-8?B?WFpCUlVpUnR5clkvZGJ0R3czV0NvbjVUV2VhdXVhbFE0YjYzV0ZNeWdXazUy?=
 =?utf-8?B?SkRWS1FKa2M4MWhORnIxaW9URFR1VU1UMm81VTAyTjJFOUw3ZXowS2c3SUI3?=
 =?utf-8?B?WHVkNVA5RGtIUWt2aldvaEM0NnhZTnFNR2pSVDZpb1NhT1pRQkVaNkhJenVD?=
 =?utf-8?B?RmxTTWkrbXpManRTVHladE9tL1cxaTRDUldYSmgwTXExb3VHcjZFQ2prUmV0?=
 =?utf-8?B?SE9oRzdDUEMrbGtwK3RWZ2krdDlOdkdjQ3NQcWMxWDlCSkRqeDZTdEFhdDUx?=
 =?utf-8?B?VjNEdThncFRlbnJmb1ROODdqblVCcTNLVEdrOWRBV1laMnRNekJVWnppZUJ4?=
 =?utf-8?B?UHQ1dUxjUEtDajNrMXNLNE1RdUN0SWswM0NBMWxFY0tiVG5ZUWViR0xIYjJH?=
 =?utf-8?B?dnA5dEtUT3N4M1NiYkZyVERYSEhQUDlPT2V4QUtXOWFHQ0pobEJuQkI3ajFH?=
 =?utf-8?B?cHQ1M0pIa285eFN3T2NzRUpMNlhzSGY4aDBrcHFSK2NpNUsraklpQ0k4UUlr?=
 =?utf-8?B?WXJ3ajk5bVphZUtRVXNxbHVUcHhKMGdKNFhGa1pkbEwvZmV6ZmErY1FrV3Zy?=
 =?utf-8?B?eEgxMVBmMG04RTk1RnRqaWNJSm5MbUVVZjhYOWIyb1pOVjR6a0xzc2dOcTRZ?=
 =?utf-8?B?RGxHcVJaNGY0a2RBeXgzNWFyUDFobXJqYXdHelUrK3U0WjNqWm9DcjJwMlBL?=
 =?utf-8?B?Vm42QjJHU1dUcTNMVWdQNWhYV3ViMUlHaXJDaUR1bDdvMGE0SW5zU1d2bExH?=
 =?utf-8?Q?4B2KuzW5oTGQvc7Yw3Ls+x6X7?=
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
	3gq7fwQqVhJ67EWibbMvaTfAEhGjcirTwX/7ojup0JO0+EaLYJ0E4NELrfgpYeBgSCX7/B/g0pBDKoz1Icht8NiID1LeNaBfY3A0pmq96H4Mw3oktaxRCdpoclX7ddg5xXZlJW/sfA57I1/Pl4FkpVfar8lJAu5zBKxkuodon5umeT44JZEZU7CHmRbOr6hjoe+o2fBD5UxVr2wXP0ha0EtslF7EtqlmwndOhi9Hv7IliCZsNH8oUxvxASEsuJ6LoOZbV+8yEbGNhBGb3/sRTQoaS5cacQD9hnlbOdpacUwgrzSMeI9L0N/ia5l1LdVN6OazsXmYzBtdtxamAy5pTTKAP/TKjEXaPKp8d7V8uG0xgUD74e0FxRQkNw5iX35/c9atmV6Z+GIVbqRCrPqvfdx4RoG6aQ9mU+uA+67BXwwqpGlFNOvfCJLdshpeASa1trxaiZJERlkeSwabkEouWJzI0rPV5D+cSZi2i1k6+tMi3GY8iycJ1U82IwgMXVGuwqq+EuDJF0YjrjIIyHL2wX7LBECBkEBtyuVPzsl7lcv3qaT0ZbHKem+dILqRcQkDDEzP9tHZV2r3O9eZxPFaZUHQ4y+rxv4N2kW/UHpM2I5AEWW0JEOCABtglHfR7Xoi
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7041a327-411b-45bd-985d-08dc170fd369
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 03:53:11.8440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XB0mMlpUToOtqhgwq7nab3JkAzAnm8mCq7sCMs8pZIVTRd3Fld/ofEFFJoNRg8WKJqfuOhIPen00QOsFb84t2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10364

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IENodWNrIExldmVyIElJ
SSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI05bm0MeaciDE3
5pelIDEwOjU0DQo+IOaUtuS7tuS6ujogRGFuIFNoZWx0b24gPGRhbi5mLnNoZWx0b25AZ21haWwu
Y29tPg0KPiDmioTpgIE6IExpbnV4IE5GUyBNYWlsaW5nIExpc3QgPGxpbnV4LW5mc0B2Z2VyLmtl
cm5lbC5vcmc+DQo+IOS4u+mimDogUmU6IFtQQVRDSF0gbmZzdjQ6IEFkZCBzdXBwb3J0IGZvciB0
aGUgYmlydGggdGltZSBhdHRyaWJ1dGUNCj4gDQo+IA0KPiA+IE9uIEphbiAxNiwgMjAyNCwgYXQg
MzoxN+KAr1BNLCBEYW4gU2hlbHRvbiA8ZGFuLmYuc2hlbHRvbkBnbWFpbC5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gT24gVHVlLCAxNiBKYW4gMjAyNCBhdCAwMjo0MywgQ2h1Y2sgTGV2ZXIgSUlJIDxj
aHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiB3cm90ZToNCj4gPj4NCj4gPj4+IE9uIEphbiAxNSwg
MjAyNCwgYXQgODowMuKAr1BNLCBEYW4gU2hlbHRvbiA8ZGFuLmYuc2hlbHRvbkBnbWFpbC5jb20+
DQo+IHdyb3RlOg0KPiA+Pj4NCj4gPj4+IE9uIE1vbiwgMTUgSmFuIDIwMjQgYXQgMDc6MzcsIENo
ZW4gSGFueGlhbyA8Y2hlbmh4LmZuc3RAZnVqaXRzdS5jb20+DQo+IHdyb3RlOg0KPiA+Pj4+DQo+
ID4+Pj4gVGhpcyBwYXRjaCBlbmFibGUgbmZzIHRvIHJlcG9ydCBidGltZSBpbiBuZnNfZ2V0YXR0
ci4NCj4gPj4+PiBJZiB1bmRlcmx5aW5nIGZpbGVzeXN0ZW0gc3VwcG9ydHMgImJ0aW1lIiB0aW1l
c3RhbXAsIHN0YXR4IHdpbGwNCj4gPj4+PiByZXBvcnQgYnRpbWUgZm9yIFNUQVRYX0JUSU1FLg0K
PiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hlbiBIYW54aWFvIDxjaGVuaHguZm5zdEBm
dWppdHN1LmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4+PiB2MToNCj4gPj4+PiAgIERvbid0IHJldmFs
aWRhdGUgYnRpbWUgYXR0cmlidXRlDQo+ID4+Pj4NCj4gPj4+PiBSRkMgdjI6DQo+ID4+Pj4gICBw
cm9wZXJseSBzZXQgY2FjaGUgdmFsaWRpdHkNCj4gPj4+Pg0KPiA+Pj4+IGZzL25mcy9pbm9kZS5j
ICAgICAgICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKystLS0NCj4gPj4+PiBmcy9uZnMvbmZz
NHByb2MuYyAgICAgICB8ICAzICsrKw0KPiA+Pj4+IGZzL25mcy9uZnM0eGRyLmMgICAgICAgIHwg
MjMgKysrKysrKysrKysrKysrKysrKysrKysNCj4gPj4+PiBpbmNsdWRlL2xpbnV4L25mc19mcy5o
ICB8ICAyICsrDQo+ID4+Pj4gaW5jbHVkZS9saW51eC9uZnNfeGRyLmggfCAgNSArKysrLQ0KPiA+
Pj4+IDUgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkjDQo+
ID4+Pg0KPiA+Pj4gSGVsbG8NCj4gPj4+DQo+ID4+PiBXaGVyZSBpcyB0aGUgcGF0Y2ggd2hpY2gg
YWRkcyBzdXBwb3J0IGZvciBidGltZSB0byBuZnNkPw0KPiA+Pg0KPiA+PiBTdXBwb3J0IGZvciB0
aGUgYmlydGggdGltZSBhdHRyaWJ1dGUgd2FzIGFkZGVkIHRvIE5GU0QgdHdvIHllYXJzIGFnbw0K
PiA+PiBieSBjb21taXQgZTM3N2EzZTY5OGZiICgibmZzZDogQWRkIHN1cHBvcnQgZm9yIHRoZSBi
aXJ0aCB0aW1lDQo+ID4+IGF0dHJpYnV0ZSIpLg0KPiA+DQo+ID4gV2hpY2ggTGludXggdmVyc2lv
bnMgKHRydW5rLCBMVFMsIFJUKSBoYXZlIHRoYXQgY29tbWl0Pw0KPiANCj4gZTM3N2EzZTY5OGZi
IHdhcyBtZXJnZWQgaW4gdjUuMTguIFlvdSdsbCBhbHNvIG5lZWQgdGhlc2UgdHdvIGZpeGVzOg0K
PiANCj4gNWIyZjNlMDc3N2RhICgiTkZTRDogRGVjb2RlIE5GU3Y0IGJpcnRoIHRpbWUgYXR0cmli
dXRlIikgKHY1LjE5KQ0KPiBkN2RiZWQ0NTdjMmUgKCJuZnNkOiBGaXggY3JlYXRpb24gdGltZSBz
ZXJpYWxpemF0aW9uIG9yZGVyIikgKHY2LjUpDQo+IA0KPiBBbGwgdGhyZWUgb2YgdGhvc2UgY29t
bWl0cyBzaG91bGQgYmUgaW46DQo+IA0KPiB0cnVuazogdjYuNSwgdjYuNiwgYW5kIHY2LjcNCj4g
c3RhYmxlL0xUUzogb3JpZ2luL2xpbnV4LTYuNi55DQo+IA0KPiBJIGRvbid0IGtub3cgd2hpY2gg
bG9jYWwgZmlsZSBzeXN0ZW1zIHN1cHBvcnQgYmlydGggdGltZS4gSSB0aGluayBtYXliZSBleHQ0
IGFuZA0KPiB4ZnMgZG8/DQoNCkFGQUlLLA0KIFhmcw0KIEV4dDQNCiBidHJmcw0KIGNlcGhmcw0K
IGYyZnMNCnN1cHBvcnQgYmlydGggdGltZS4NCg0KUmVnYXJkcywNCi0gQ2hlbg0KPiANCj4gDQo+
IC0tDQo+IENodWNrIExldmVyDQo+IA0KDQo=

