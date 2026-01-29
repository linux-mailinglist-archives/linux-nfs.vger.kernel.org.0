Return-Path: <linux-nfs+bounces-18597-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJOMNIIfe2msBQIAu9opvQ
	(envelope-from <linux-nfs+bounces-18597-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2AEADBDA
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EBD8300826E
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 08:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5016E37E30F;
	Thu, 29 Jan 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="P1CRpU88"
X-Original-To: linux-nfs@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283037BE7E
	for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676672; cv=fail; b=ROUsbw1fgYrTdU0QWDpUR/fYmhkE09BdOEvOAWs/EugAkKdRqHgVymaVA+BCX/b+ZsPFo9GEDyPwl8AEucqFJTacsk6uB2170KW/8Bq8b63iEuX/x5YO0ZzeFr29dpiVF7yTLNMhKUqiacok5rTp3S/nGGzhueCSAAuMuJjV4y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676672; c=relaxed/simple;
	bh=mhwYfWIDYb9j2Vq97N0ds5La4P2gpXkrA/naisvazOg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sNX6xthJhz3soXSkZCHqR76JOiDSIYZQ0tuY9WJp4xkcAFHSK7FY7UC0uKdE7B7GeJhD1HHYKGY+CYMaDCHigEFKWmUvDnBfvp9QJ4JZtjmMXS9jy/hXt/isJYLo0yAiqenhN4/lKG/JHE2fAUCpda/8iwbhCuHc901r/bmFbT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=P1CRpU88; arc=fail smtp.client-ip=52.101.229.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+Yqcjo01KSy32jQtijirD3HLGAR5TzRBAwvWKzRZrRv4iLDSo2EwhDatwG5repQgM+ZhvbaLR9O/KIL8em191IEmO+W4gTy1peKAs/WbeYkscb/SgYmsTFmdRI/oXC04pJ5/EDhdJCleeje8N9G4d1avYiEEe8kkflqIGb7mzOrPoUrCjupynA31Pv5A9F1tNFM6qf1TlGjrBzN1/aBE5+xXocYBR8SaA05MMUYhQnguxxpt79mGns4iF/x0RuljmnpXrlsKTL20QO9cF4L1en/TzPpHpXVV9b9uIQs1ecMp1HTFzY10ZidLdZ5aD7bMQlwVFU48KPYrwkseV9d9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9k4H/tED07abSmTL7jdV81ErjKRzjhbCFDKsBT8xkwQ=;
 b=KyEiBkOFxrBQeU+YgEN6YKPmEnMUMBgQGkNfLi58YPlTFvASo1RQ+AJvGcSVLYOlr0bgpt6e8ibfy0Qhbz8inKUEv7YI9QlesbHjxSjDOSJJkK81c/azG1ASnw2BhVmNGQqrPdX50OmbGiIkqPkH+CKMLV88JR0UnBpfCN6GGdmcTB0xbdZ81QyTIxbMHqa2xGqzSZHDGSTXnK3BEAYvVcZoui+Cb8/IS6DL9go3KoKjWbUbbZCOFRvV78aMtMgRUGDYuFk9xQJ7HuK7VAMkd7h2c/qPkVcO9Eaor7enMZJ9TB5avGyljxesxLsyyR+wS9YzE1EgetMFGHb2zJLq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k4H/tED07abSmTL7jdV81ErjKRzjhbCFDKsBT8xkwQ=;
 b=P1CRpU889eijoBWeYLnzeLq5tJzMxYiKADMQHFqCXFXVL8/UAleEmXMNS1ERP9ktu+W3lqs7h4kR64HcQWyz7R9Z/mNouzzP4+nAf8b2hFbUCwYyyaLXY9+/adNWSNjkZlGIUItXUAGSlz/Ct8f1Js4pJ7qAidNCiB927mhIHFT1cvPLkrRQ6e56hNBXZSYar2D2Uqb+zYoMdVLFT1D6EbHzyC1aqZzXbGqAhpFyESPNnh63B1++UN6mvDlBXPy380rxbpTV3MYRkrTrJuY0Wv7RPy+5BR5g4WR6nfgoRXeH6fYrYGMomvaSZWiITMLJzim8votAHniZeQbwvG7ncA==
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by TYYPR01MB15165.jpnprd01.prod.outlook.com (2603:1096:405:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 08:51:02 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 08:51:02 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: [nfs-utils PATCH 06/10] gssd: fix typos in man page
Thread-Topic: [nfs-utils PATCH 06/10] gssd: fix typos in man page
Thread-Index: AdyQ+p/v4LYklg+VRTWyi512PLVA8A==
Date: Thu, 29 Jan 2026 08:51:02 +0000
Message-ID:
 <OSZPR01MB7772E5C0868DAFB0156521FD889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=b06f2728-748d-49f6-ae91-f555cf8934cc;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-01-29T08:34:09Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|TYYPR01MB15165:EE_
x-ms-office365-filtering-correlation-id: 1f83a3df-7da0-48b8-7e81-08de5f1387cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|7142099003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?dnA2M3ZtZXZZRW4xd0NsQkxpRi9IdVAwRHdkMkd6bk9lNXFUQTEwTnlR?=
 =?iso-2022-jp?B?ZXJnWllpdE1PNnE4V3ErYnFVdWFpYnNOdjd6V3hxNHRqVS9UZFVYSERv?=
 =?iso-2022-jp?B?NTBwTzFnM2Y5Sk82ODd4L0hOOXBoeXQ2SFBObkZqS0h1Ri8xZm50OE4v?=
 =?iso-2022-jp?B?V2xNOWM5aTBudVh4UU5qNnZUTmllMDNGSmZuR0c5L0lPRkpFcjFsUWV1?=
 =?iso-2022-jp?B?VnFjN3RDT1gyc1MvS2NRcVJldGliZVYzelIwQlFUKzZRdlNyMEdNRVNB?=
 =?iso-2022-jp?B?YVNRQ0FCREpuc0FTc05ScXBJYXA3Y1c1eEdIR1p0RVNVSHYyTnhTd0Ew?=
 =?iso-2022-jp?B?NXcybjdkM1JGSjN3dkN6OW5qcUJEL1JVTE1paDZHMExaUWhjenZ6d1BQ?=
 =?iso-2022-jp?B?OFZjQUwwVVplZkNoRVhZTUlhSkZPR3Ryb2NReTFPTXhjcG11eDA0TU1l?=
 =?iso-2022-jp?B?bUw0ZTdrMWJrSmNGUTZITHl3UUhBa3hKMVR0SmpRUDNibzA3Sk5abmp5?=
 =?iso-2022-jp?B?SWVyaks0WDZoM0ZJT080ZkR3N3JrWTIwQ2l3SGhHQWVjMUVXczhWQWZO?=
 =?iso-2022-jp?B?TnBHVHFiNmh2VEt0d3ZoNHljdTBjV1ZLVTlISGIzeWxTR0dqYUpqaHZk?=
 =?iso-2022-jp?B?bWgveFlKdUZaUjh3dDVpUmkwYURsQUYvUjI2cS9zTUlqNlp2S0R1aUkv?=
 =?iso-2022-jp?B?Mmx2RDQ5ZjlwdEk2cE9QWElkTXEwQXkxRkVUZjJrbkhZZ1QxblNyZm1y?=
 =?iso-2022-jp?B?d0JkdlNuWis0ZlhTbmd0RDRGa1ZmVm5ueGE1OFpWZXNYNVBwTEdHZDBw?=
 =?iso-2022-jp?B?ZCthcE40ZmlxaFAyK3JPZ09FVEFNcWphUkM3U2Z2Yy9KMk9lMzZXaVBV?=
 =?iso-2022-jp?B?eUxmSkgwMHNWNWU0N2o3SENvUzNyQXVMc0t4UzhnWWxVTEtBTiswRHpt?=
 =?iso-2022-jp?B?ZHl5MzJ1RjFCSVlXOVNidExrVGY0V0VTK1Z6ME1hY2hvTUpmeVRTZEZw?=
 =?iso-2022-jp?B?TFJGUE5HSTFIeU00VXhVUUJqVWJXa2l2b1V0TndVZmsyMGhaWENzOFpx?=
 =?iso-2022-jp?B?b3kwNXNSUmdKWERZQ3JEeEVKZFVwSVJEdDlPc2p3Mm55R0dxVlViNnAr?=
 =?iso-2022-jp?B?NUd0YlJCSCtpYkVaQUk3cisybGRXclM3NnBYQTdwakdxQTNoMk1Ub1Bs?=
 =?iso-2022-jp?B?MkNSaWFHdDZnc0pzY1FSNlpud0hSSXdWTkJDMGJVazdKTno1anF5Y1BU?=
 =?iso-2022-jp?B?SFd3UkhKbXFTbFErYThpMDNIbElVTWk0T2xiSW9QcUovQXhLcHp1T3Vw?=
 =?iso-2022-jp?B?MmhUYXhTQ2pJVkJTUXVwUWRJNkgrQU9jbEVwWVdxaXFEWk5oTkN4cENG?=
 =?iso-2022-jp?B?aXJnOEtRNm54cTlnMmNXM21SNlZKd0ZIZjlpTWJhZGdIUlNFdHNNVkhJ?=
 =?iso-2022-jp?B?WHdZN2xyT3BnaytoUEhxNkZZaWFmK1dVNnpGMnNTZUNIcVR0Y2ZlcUxx?=
 =?iso-2022-jp?B?b2tnNUZlRSsxZ3BXVnl2SFBTMzNVLzJObzdLMW0yNVkzdVR6M2dHVEZn?=
 =?iso-2022-jp?B?MHZFSGYwY2dZVHp4VXJLOUEzcEo0UXVlRklOMks1ZDhXK3pjN3VpaVRT?=
 =?iso-2022-jp?B?SXV2VGVKTmtwZ2Jnekh6OUhUUmZjbkNway9pbjJnTlhPMEM4a1BBT0VI?=
 =?iso-2022-jp?B?NDlpVGVZUlRBT3RSSXpibGpMbUlRZGVRdEEyNGZqeTJqZHl3VGNOUnJ0?=
 =?iso-2022-jp?B?NHM4NTFSb1pCWk12dEkxclM5aytoZGJkejBMOWRiWTRzcHIyaUhENFB6?=
 =?iso-2022-jp?B?cXMvWEVzbWU4VDd5MVZlVXpSOEM4R2hzaTN4VCtlM3JwQWpkZHkxRThV?=
 =?iso-2022-jp?B?TzB1VkgwOTM5OFM5YlMrQyt6U1V0ekJKdzlnSlk4WlZFdzMrVUhFbUx0?=
 =?iso-2022-jp?B?VkRxTGRJWjY3czUyYUlWNTdLMkZBT0syNmlIdUFRTjZMVlZJMGNOcUtY?=
 =?iso-2022-jp?B?SllNaTEvbXdOOFA2S1RPQ0pMcmFVSHFLYnVjY1Fick83Z0U4NHFKWGNw?=
 =?iso-2022-jp?B?VzVJcUFXYXhDZUhOTGVxN2xZVU4zNHBXbGMydHIyWU40VE04akxEWnND?=
 =?iso-2022-jp?B?WEZ6Vjk2ck9uWHE4QmdJYk1vaFhxVlljZENHS0lUNWtmSG1NN29pMmlt?=
 =?iso-2022-jp?B?QWwvdVhzVlFiWmxEZnBRVWhFNitLMVNIOUNQdzVEaWtjdENjVjk3UzFE?=
 =?iso-2022-jp?B?R2VhYzY3V2UraWdwa29CVHljL0t6NEcwWWQycWZ1TGxsMUpVWjBzREJr?=
 =?iso-2022-jp?B?L0VaTUE3bCtGZVNkeE5CYmZZanFFUDJ2VjArK21KVDNRTHZjNzFVRzVr?=
 =?iso-2022-jp?B?QjZuNkUyemR0Q3ByV3ZWUTlydGMzYkZqVmc=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(7142099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MmFPUFV5TVdNanlBOVB3WTlaQko0bHo4TjZyVDV4WEcyeldtaDFPUXI0?=
 =?iso-2022-jp?B?dGp3WVdEYkFvbjcvbWJ6NVBNKzVTTTJRTUFNMVlmZ2ZyTWxvOWNDZS91?=
 =?iso-2022-jp?B?TlpYUjFHREVtSXZNTjJERGJhdmMzaG80UjhuOWVWTXg4Sld0VTIzdjRC?=
 =?iso-2022-jp?B?S004a0J5VUxzbnVNcHpsV2EwRWo4ZFpzaThhRDMza3dMVFZUaXBodnlh?=
 =?iso-2022-jp?B?SVRvSWpGMWJGa2J5c1NKdThIZk1YQ2dHZVl5MkhXc0w5aWdqU2VSVzJ1?=
 =?iso-2022-jp?B?cWp4Q1lKSWwvUWs5aUlOVGRjenJxSjFPMlBtV1VkdmNWTHZFL3RXZGxi?=
 =?iso-2022-jp?B?RmxTajBrb0kvbEdEQ3ozdW1lTWd6RjJZcTYzbmltMlRhTzhEOVllNnRz?=
 =?iso-2022-jp?B?MjEzYTIrMDNUR1BuS09LTUcxam5FYzlyeW1NUEtORWlGemoxbm1wRk5O?=
 =?iso-2022-jp?B?YVdmZy9VSE96MGRKcnkvSlFFZWY4Q3lZbjQycTI5bU1Nb0NPL1dGYllI?=
 =?iso-2022-jp?B?dWZxbUFKaVhhbUZwV2lHOEJFNUQya1pxc0pGY3p2N0M0QXhDZnJVT0lQ?=
 =?iso-2022-jp?B?ZVd3cTJJNjhTclE2MmJCRGgrczZLRHZjd3kzUnI0RmZTcE9pT3NxSXpZ?=
 =?iso-2022-jp?B?YWRDVGZPWXE1QWtMaWlVWmRCbTFGWXhZUU5FbDBWQjdKaUVGM0d4cGxU?=
 =?iso-2022-jp?B?bXhqWjcwNkcvNEZkVUJwUXJCcGhsZjBaeFFXOHNLUEN4MEZJVU5xcDBj?=
 =?iso-2022-jp?B?T0JQNVNMQ2VXT0M0S3hpMy9Va21RWkozYXd1elU0ZzBBMjVHb3FGSGtD?=
 =?iso-2022-jp?B?MWtIcGNycTlLdFdKanB6NTFKbVdmU25HajdCNWVWVFVRY3d6SEZ2QjEy?=
 =?iso-2022-jp?B?d1d3L3lOVUhNQm50RjhKdzNCbDZGdTBqNmlkWS9DTW1vdGc2a3RkdmNr?=
 =?iso-2022-jp?B?MEdwZ1lEa05obFJpZ1U2OTBLektuK2FWbWZ5OURVd0tOeEgwZ1R3K0Fk?=
 =?iso-2022-jp?B?dTFyY3QyNGIwRE5lYXdieWp1NGdYSnBqRWhZeWIwSyt6anVtVmZ3MlJo?=
 =?iso-2022-jp?B?OVAvRDIwaE9YZzVxNmVDVG9zZnVMaFlubUFsb29rM1dCcUFZYkpac2dr?=
 =?iso-2022-jp?B?Y3FRYXlpY3dFRUdGM0YvazY2M0tqd0dhZjVleEVod0hIUTFZUEhOb3dY?=
 =?iso-2022-jp?B?YTA4SHhiK1lvNUpmMXhOam1BdEdIZjJDa0I1UW1UbVpPS2J4dmhXOU9m?=
 =?iso-2022-jp?B?WnN2UGprcGtHUFBwMzFTN2x0M0FIQm51TkNoazVWZjA3N1hXTWhEQzNP?=
 =?iso-2022-jp?B?R2NWVm5EeS9GTzlLeHhGblFiODZWZEh4WmczMyt2TGdTT1RDZGdzZjRX?=
 =?iso-2022-jp?B?L2Z1UlBHMnVYZ1E0SnZmMlpwUlN5YzhnTllNOFBLNHZnWXhyb2RnQnV1?=
 =?iso-2022-jp?B?U3B4aEkyUDJHalFFQ3d6VTJzeDE5YitkRGpOT0p0TXBRWEhWL1RDSDky?=
 =?iso-2022-jp?B?OWx3cmlud1ZZa2N0Vmt2K1ZFWGFsekQxNlR2d2N0UnV5NnhFajZaVXYv?=
 =?iso-2022-jp?B?THk2Z0cyd2UyejZzVzdjTWNDdC9WcklGcWk1L2ZHY25UN3ZPRG9LZ0hI?=
 =?iso-2022-jp?B?MHphUnNTbFpDOGVhcS9TSlppQTY5TzdLVzUxNk1BVi9MK21lcVYrcjR4?=
 =?iso-2022-jp?B?S0RvTHJ3YnFCR1RTbG90Z3o3UHI4TjdPb1h5VDNPZUx4Ymp1dmx5M1lT?=
 =?iso-2022-jp?B?UHdEd3VLYXlMR0l3TlJWSmFDODVMS3g4T3FoQmpNUU5XVi9WVHRjckZw?=
 =?iso-2022-jp?B?azM4QmVoWmR4RWExRGpBSG9SeDA0cTAyQlZTOE1oNi9TZmhsbHlJS1hR?=
 =?iso-2022-jp?B?cjBZMzVDSHpBU2Q2bktONmZJK1YvSGtNY1VDRUV5NTBhdDBaZkJIVjVK?=
 =?iso-2022-jp?B?dXpTeStxdjh1aUtaREw1UFY3VXovdkdtNVRpUEREUXlwelNvV09xdzlr?=
 =?iso-2022-jp?B?a3lCbS9OLzBSakZXSndXWTdjQ2lJYnUrSHZ1bW41Qy84VE1yVHpSKzQw?=
 =?iso-2022-jp?B?RzZlK2YyTTJoZjhZNXVObnBXZUN1aUJORzVpSE5IbTVYZXlyTlRiU3Rx?=
 =?iso-2022-jp?B?OXJCNW8wS2JyQTA1ZFk4RCtKRU5RbW9ZNEx3WG1KU2Q0RGxvNHJMbjMr?=
 =?iso-2022-jp?B?djU1Z0VJMi9nbjZ1MTVXa0laU1ptalJSTGNPOUNwc01zZzNYZDdyLzZG?=
 =?iso-2022-jp?B?S3NlYXY3REJMdkR5V0pzd090NVpybEhtZGNYd0ovQnc0QmlvMnA4N0RY?=
 =?iso-2022-jp?B?RDhFQVR2azd4MlQvU1Y2SldPZE0yUXV6SityTkVWZUI5dkNvdS8yZUdS?=
 =?iso-2022-jp?B?N21iRk1YQkpVUk9kc1VVSDVpVG1hbzA2dTIxUC9LUFdHeWZvNXhhNE0w?=
 =?iso-2022-jp?B?bHRzR3FjdnJGRWRDNlYxN1JqaGdHK1NESG5PelA2bFlENXBoa0dVYzYw?=
 =?iso-2022-jp?B?TU5tRjdZN0VTS2hJa1lJd2tBM3JwZGN6U3pmZz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7772.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f83a3df-7da0-48b8-7e81-08de5f1387cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 08:51:02.0592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +pUYNDNBuSLY3QLunz4C8jknE29Ofw/82zhYBpoL4Ue0mW604Y6wS+erMlgSDnrm+vjFzNa0CMwNhhk0XxJfM4ndJmxesmB9nqUUr9v/L2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15165
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18597-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.ikarashi@fujitsu.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[OSZPR01MB7772.jpnprd01.prod.outlook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fujitsu.com:email,fujitsu.com:dkim]
X-Rspamd-Queue-Id: 9F2AEADBDA
X-Rspamd-Action: no action

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
---
 utils/gssd/gssd.man | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
index 4a75b056..f81b24cd 100644
--- a/utils/gssd/gssd.man
+++ b/utils/gssd/gssd.man
@@ -190,7 +190,7 @@ name exactly as requested.  e.g. for NFS
 it is the server name in the "servername:/path" mount request.  Only if th=
is
 servername appears to be an IP address (IPv4 or IPv6) or an
 unqualified name (no dots) will a reverse DNS lookup
-will be performed to get the canoncial server name.
+will be performed to get the canonical server name.
=20
 If
 .B \-D
@@ -244,7 +244,7 @@ This option specifies a colon separated list of directo=
ries that
 .B rpc.gssd
 searches for credential files.  The default value is
 .IR /tmp:/run/user/%U .
-The literal sequence "%U" can be specified to substitue the UID
+The literal sequence "%U" can be specified to substitute the UID
 of the user for whom credentials are being searched.
 .TP
 .B -M
@@ -404,7 +404,7 @@ Note that this is unrelated to the functionality that
 provides on behalf of the NFS server.  For more information, see
 .BR https://github.com/gssapi/gssproxy/blob/main/docs/NFS.md#nfs-client .
 .P
-In addtion, the following value is recognized from the
+In addition, the following value is recognized from the
 .B [general]
 section:
 .TP
--=20
2.47.3


