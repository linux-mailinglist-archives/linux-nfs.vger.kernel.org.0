Return-Path: <linux-nfs+bounces-3317-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DA68CB10F
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 17:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27551C20B9A
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 15:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC9143C4F;
	Tue, 21 May 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Qsp2KXjg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2098.outbound.protection.outlook.com [40.107.94.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1664143890
	for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716304392; cv=fail; b=T3R8wY6PSk7ufE63w2dojYc5ZFOcPB0ZsVaBkv6Frpx/YxFVRLFhL9iUDi3QQCyxNytzTuSl1XUefVSP0CCaIrIh5bbkJGhAi7hwr375L3oRSBUMzYrMf/XXoQnsR/wZy75ptT7CDtam43UDmTGhKvnhO/oPNCpIHhDvtfZUl+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716304392; c=relaxed/simple;
	bh=cx7uUcsTFBIKR56hX3iSbnZ7mOavCfjXBGjvgc4HNQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R15Oiu9hftlQ5GAKQI4KmlxYesekIg155gu2JiK6vc7H59H7pFIwhFxwBUmcrh8ainhCQol/YwdpfB/mFrNN+CUsYkBdKzNhKHteWCXMg0dSjmrTd8TLywDbbcU0DiCAcKo3Ri3pKPqFskeF3SPK0xXvChteppIFo0zWz5ltQws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Qsp2KXjg; arc=fail smtp.client-ip=40.107.94.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+mbkX6r7rsxX/9E+kfooHrc/IYiyUkjcAM0YGUlnDN6Rdl3TTfUpuBgMOQFLF48NlaZSNcUjOf83NXE8QNW7k2rkKKbi1dddSnzWKZ9GhhLy/BPxJVgBwxC3k/C3dEnX7TRGU52rrEXIrR5wz0QE7dFNHloyRNxLDlhgm55yRpVyGtruc/0Tujk4QQ7XRtIKjrhERRZgeqBw2wjlI6cYYnOPBdEtPBVoWMU+Jz1iUtENf64RDx3/upo4BZXTN1tVpqFrX7ud7brpcwLu279sN6/Lk79hpqb9foax1K4CtcI6C8tFjCCdETc/FV51oq7ugS4nW2QbppMnHP2/spMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cx7uUcsTFBIKR56hX3iSbnZ7mOavCfjXBGjvgc4HNQw=;
 b=Hhm0dhr5YSWWt7L0m/rM1Q6sijEvYquy+Men5gYGsSTYU0zsU/Mqn34PHcfUsoZUkJG73GWTugLJdLUDfScDkdSKMVC7ZS3NqDdwD7D1C1rjD/bo+6+3msol/z27bzSKtbfF7STxsEIS4cT7Z5ua/ZWNTUL1KpE5CCOdkXnHEaj99ufAjeD36dxnVMUuIXjPDIVADiOTS0VWQtWWe3Tiq7WfLZU1MmfCmTn1xSNxoGkGDg67IrRgD1neGY2QksLiBLi03Wa1bGHJ9CrFdFePb92yl2oTK/0A6frPy7xsqWCXeBUaTpd81bEWGuHmkHhUQ8YuWggjk/ZEuQsimXGpPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx7uUcsTFBIKR56hX3iSbnZ7mOavCfjXBGjvgc4HNQw=;
 b=Qsp2KXjgun/2dL6mVGRUSG/HBcJJhAJrNG9slx00Pkcf4zt3l5wc6GGVcdg+mjIBPA4anug0M2M5wkmWX+MWu+1c9mDdTK7kC1tFBvqOsOuqrSa76S1WbPh+ssHcMysqtkqEqwH5tVG49hjzqupbHT2HCa3vF0miZXYDl7s3kPY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB4496.namprd13.prod.outlook.com (2603:10b6:5:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17; Tue, 21 May
 2024 15:13:07 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7611.016; Tue, 21 May 2024
 15:13:07 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "jlayton@kernel.org"
	<jlayton@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "dan.aloni@vastdata.com"
	<dan.aloni@vastdata.com>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
Thread-Topic: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
Thread-Index: AQHaq36jqWobVAzhLU+0cOtTOPPg4LGhrPIAgAAczACAAAIIAA==
Date: Tue, 21 May 2024 15:13:06 +0000
Message-ID: <d5409ff9ce51e439f442abb1cded7c7ab732b726.camel@hammerspace.com>
References: <20240521125840.186618-1-sagi@grimberg.me>
	 <fa1a77fee6403454444fffce839924157778df95.camel@kernel.org>
	 <ac2bfa20-d952-4917-8a70-1e821f9b57ca@grimberg.me>
In-Reply-To: <ac2bfa20-d952-4917-8a70-1e821f9b57ca@grimberg.me>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB4496:EE_
x-ms-office365-filtering-correlation-id: 3d776e78-ec92-402d-335d-08dc79a884d4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejkzWlA3eU1jWEJZaSt6U3h3YWhnODdBaDYyeTVUSDMxaHgxY0JodFV1SEoz?=
 =?utf-8?B?UXFBa0pBUk9tejJOMjZlWS8ydHc1NTJPRHRLSWVYSndlUmZvQ09yNG1yVS9D?=
 =?utf-8?B?VlFkbzZGb2IxTHRNZzFlWW9pdkdhNXNOTytEcENwZkF2NVRRNVhlNks0YTNX?=
 =?utf-8?B?eXYvdnVLWDR1dHorVlZKWlN6cnQzK1VYLzczMXJZZmdFb0xYdnA4N2FPbEkw?=
 =?utf-8?B?aThDNGpBaml6NDlqOFZGSnoydE5hQXluV0UxbTRCUEZJSE85L1pJcTJ5RzEw?=
 =?utf-8?B?YnZpdlZnZ0UyVXk2ZXpsMC9ITDNVb0xHN1YvZTI3bDM1MUdubUZNR3JROEhW?=
 =?utf-8?B?ZWdYYkY1RjdBT0ZISngzUVpUb1FWS3l6L3JrNmszYnpleEVJV3BXSzQyRS9z?=
 =?utf-8?B?ZEZCOGo0U2s5b1hldVpKRkkrUU0yTCsxQ0NXbkVhRFNhV01pN0xScnk3cHVL?=
 =?utf-8?B?d1F2RWh0Y1g5RGZMbFpySzA1bTNlb1ZRZEd1WDB2YURBenZpWTRMMXZUZEp3?=
 =?utf-8?B?TmVaT0xDVDduOGxBQ3dmRFBydHI3L0E3RE11OWNuUzk4K21sOXA2RG9yMEoz?=
 =?utf-8?B?Nm9xMDFuZXg4RkRzWHc5UUtBYW5iWDZLQjhVdnRlMGY1NDB5eXArbjJWa2ox?=
 =?utf-8?B?QnQ0SUJCVGQxbVZQVFF2eWxtNlphRmVWL2lrVEI1UnRoWVhPMmtkcE1NVkJM?=
 =?utf-8?B?VGRYOCtjVFc0UjJIOEN0czNoN01IUDdsY2VkMVl6YnQ3czRXc2k2MktlSWN4?=
 =?utf-8?B?cTJqa3E0SGE3U1NNUUVhUVhjYlE4L1lOWVlXbm8wOGNDTkF0eFh3WTUvRER4?=
 =?utf-8?B?d2I3bG42bE1qVDVDYVQybkNIZEJ1aFFoYWJzdDNkRFV2M2J4ODA5Mi9QQ1FH?=
 =?utf-8?B?OEZMQ3N0RS9OYzFKUFRUdGsvc1FjT2wzcFY3OEZsL2xTdldRM3ZQQUhSYWhl?=
 =?utf-8?B?ZStvR01UZmsyZi9Cd0xRN2pQcmJNQ2w4RHV0clNwTFMxVnd5RytRSVl4UUg3?=
 =?utf-8?B?U1NPclVZaFM5SVRuc0w0bmdnQkdJYnVSQmVVRzk2VXdNTUM1d3pZOG96ajky?=
 =?utf-8?B?dGs5eUthRkpUUlppYnU1cE5QUnNXTTBuRXlUbGRnZ1VyS0FUM29KZFA0UjQz?=
 =?utf-8?B?ZVBJV3FlaVRqOExIeE9UN0pQbHpxRURCZE1vbnQxR3ZrQS9IL1M2NTNISHhH?=
 =?utf-8?B?WktSQlNySUZKR2xKL3R3UWhpUUVVMDZyRHplLzJBL25XbmJoM1JwNktSbFlX?=
 =?utf-8?B?ZFVKaVF1MVBneUxFTDhBR1BJaTVYNUM4VGRsUWNXVHV3TjQ5d0pzSzdyVnFU?=
 =?utf-8?B?MDNZNmZoSDhEQUJsN2NXUTh6RWZza3NiUmd4bFNidGJ1ZStjM2pPUTBWN0tC?=
 =?utf-8?B?RTNOeHB5b05LNzZhSkJ5OWVDN3lwd0dCbFRTZUI3b0Z3akdVTWphNGo2dWRq?=
 =?utf-8?B?b2JMTUErOUx3TVFMRGZRa2x2ZDhXbmg1dUFxZUxQR1l6TGNTZ2M5endGQTlr?=
 =?utf-8?B?ZHVRZkpPS004cEE4Z21UZ0JPbjBmcUg1MHdKanVFNFJ3MCtyeldkczN3QVUz?=
 =?utf-8?B?M09nNm9GblJ2djBad28vODRwbVZTSytjMzNlREVtWmtYN2NTMm1XRWY3ZkxV?=
 =?utf-8?B?c05SMWhISlRMQm9pc1JlV2JGVGJZRDFkUGNVY1N3SEdHMVdVRUZXY1BUa3cz?=
 =?utf-8?B?S25GcVpMdlgxUU4ySFBoQlhiL09XMzJJbzFoSmFsdTROajh1VWNrTm1xdldk?=
 =?utf-8?B?WGt2RlNXOWxRRzlvU0ZJYmwxMHRyWkh2TXdxaE1HQVBwRVIzNFFHYnhMWlU0?=
 =?utf-8?B?V0ZJTVJXUVhiTjNKaHlwQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGdFdTFxVkJxUStpRTdSeGVOT0tEQ1NMK3ZDazcvd1BMR3NyMWJkUkFQR1Bi?=
 =?utf-8?B?UEY2K0ZYVnRZRmhhK3lNYm5tUS9mT1I5aHVoeUowSkZ1TVI1Mmd5ZDVpMEU0?=
 =?utf-8?B?M2xRZEFnOWRBRWdlZTV0a3ZJQUZHNk9NbDZhdC9YQnZMQVYway9Icktaelgx?=
 =?utf-8?B?SExWUEhGNkhEcEpIc0doMVN5QlA5YkdqWXJYMzlWN0NaN2N0aVp0alh6NlpR?=
 =?utf-8?B?bVNZWDJwbk5SUDdMS0ZXSDRSZm53WlJlUHN2clZwQnlra2ovUnBudEJhSkR5?=
 =?utf-8?B?MGc2ZmNVWkNpcDQ0OHRxWStBVkVFbDlpblR3a0xlUC9Hekg4ZTR2N3VTYUVG?=
 =?utf-8?B?MWErNXBETWU4S1dSdDdKa2Ewd1RXTmJoRTc1OHdvZ0J1RFFxTjlLcGkwcXdR?=
 =?utf-8?B?TDluaDdWa3p5R2l3U0tORWl0SEwxcEVJMDZFMnV0R3ZDWUVqNHEwa3ExVEdY?=
 =?utf-8?B?cWRsNk9PTWYxTnFTMTRBRzJmbk9LdjNQL1lSN01HclVYSHFGUTVNMFB3QTFQ?=
 =?utf-8?B?WFhmWFB5eXlqd3k1UU5WeWROZlkwTlVRaWZmNFdMbkNPUnFoMzFUbUE3RlEx?=
 =?utf-8?B?MEZTcGNBMFlrMERIZDRyU3ZnN0NyaEtXNXVEMVlaZDUzNklQeVgzOG1MVDB5?=
 =?utf-8?B?RkEyU2gyWEVnQncwRWhkeFZXMkRiN1lxZGdPM1pDMHZFNU5Ya0ZmalQvWXcw?=
 =?utf-8?B?b3FaQ1VhcnpwdnJnZEdGaVlTS3kxcWpPVW1aYnc3V29xUi9lYW1QT0UzU2Yv?=
 =?utf-8?B?R0hLSDl4TXBVenF5NUJqL216QjdBdGhsUFJEMVRXbXZaTCtGOXJMaVMrQTZw?=
 =?utf-8?B?R3hXclpId01YUk53Z2ZWcVh5dndmOHgrWlQ5WWw2THVWdlZ1VDJDWC9EU2Jy?=
 =?utf-8?B?SmxlREtadVU1V01zNGtqcFJlWEJuT0tKblhlU3IyYkFwMXk5cWszcURpUXds?=
 =?utf-8?B?QlJUTUFNSk9iS3RiRTcydGJvRHpYMUxJM3pvNG54T2JWbnV1WlJueElWS3ps?=
 =?utf-8?B?M3ZESWY1dkJQdVo1V0RiSWgrQUlha1k1eU91RmxaVktkRERDTHN3Q0tYNjRx?=
 =?utf-8?B?ZVA4Y25raUVtZjBXbFh2c2VlWkMzRWYybzlhOVFQeEg4dmFiN0NKV0pBTWVu?=
 =?utf-8?B?cE9reGY0U1dYbStacTVlTmlPVlhVVElOUlRVYjZtRC9CUmF6ZzZwMHN4cDh6?=
 =?utf-8?B?U0lmSVczTTNiTy9pbjgvTDBFU0lKT3ZRQjQrZ29uTytzQmlqc0hxbmxoTGFa?=
 =?utf-8?B?djhuaUR0RjU2WXhETUlrYkVMVURycHIvQUdLTmNFYVIwNVJvVk04bFhsQUc2?=
 =?utf-8?B?N3ZvalZKaDBqN3hmS1BzVzdnaWU2Q3BoWEZIRjI2OVVqZzZOS1hYbC80bE5q?=
 =?utf-8?B?bXFMbG5BMXFnckJLd1hOUEpUK0NCZVU2YWI0bEJlRTViWW1nbTRoVGVBdkJT?=
 =?utf-8?B?QjQrUzJPWmpmQ3RMbGIvMGtrellCbkczbjZMOFVsT1E1SVlUMXV3TlFXdmp1?=
 =?utf-8?B?eU0ycVg3N2p1b2d1S2FhQmd0NlV1aFg3WTZ1NTJtODhwQXlZMW8zREc5ZlEy?=
 =?utf-8?B?OGRoZ1k0aThhZklxL1lZNndlaTQ4bm9OL09HTnMrT1VJd3paZmg1c29Bbk4w?=
 =?utf-8?B?cks1YW1LL25TQlFVSEdUNk56bVNoNENZbWZjNThTRW9MdzdHU3ExTUhIQzhE?=
 =?utf-8?B?ODFLbmxOamIxT1A5Z1NiNmNscmlEK2oxbmxqUWFWYUlicVZNSXgxQ096eDdw?=
 =?utf-8?B?WGJVWjhsL1F2eHJ3aHo4cDRNWG1VZUgwdXVBMFpyQWE1S2UrSi9tQ0JZUGph?=
 =?utf-8?B?RnJvc0lVazFxTmRBY1U1dDVZamN5ejlidXF1M0duOUswUUlybGd3bW4ybmFX?=
 =?utf-8?B?NlpKbzFCVTZ0emJSMGZsK3FnVzdtMmEvZW56bG8vSWVIOGZndUtCU3BZMVBz?=
 =?utf-8?B?QytHU21TaEs1eWtmYmJhTE9ncFZaeWJlTUFTV2pWaTBVUHI1QUE5TjBkUmR3?=
 =?utf-8?B?T1AvcmtYNVk3QnJPdDNmK2JtRG4zM3J1U3NBOWJ2ZjlxcjdKa1JjNklxUnZG?=
 =?utf-8?B?cTF6NjlaeXFzampLaW9Nb3RTdXVsNmJJNWlPVXhGb01pRnIwNXVZeXVCbGV1?=
 =?utf-8?B?VHJDbUJiTkNmN2gwL2NQZDM5bmpxenBoN1FwSWxvZkpQRkoycVVRdmtTK1Yy?=
 =?utf-8?B?aHlxK1AzQkdjSjZZdUFZZ2h6RW10SmtoYTN2UnN1Nk1EdTJRTWZ6ZFBTV1Jj?=
 =?utf-8?B?c3lFK1dNaytXQ2ZLM2JwZ1RxbW13PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CA2F22D3DC2A54594FF2BCAECAB9052@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d776e78-ec92-402d-335d-08dc79a884d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 15:13:06.9367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RSE/64mdU6OWnb26rFNLeTa7v9mxRuZYnT6hJa+8gkuc9PCr8BQooFJ2tp9vCLPXab/cOjeUPUbeMRXyPMyv8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4496

T24gVHVlLCAyMDI0LTA1LTIxIGF0IDE4OjA1ICswMzAwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0K
PiANCj4gDQo+IE9uIDIxLzA1LzIwMjQgMTY6MjIsIEplZmYgTGF5dG9uIHdyb3RlOg0KPiA+IE9u
IFR1ZSwgMjAyNC0wNS0yMSBhdCAxNTo1OCArMDMwMCwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4g
PiA+IFRoZXJlIGlzIGFuIGluaGVyZW50IHJhY2Ugd2hlcmUgYSBzeW1saW5rIGZpbGUgbWF5IGhh
dmUgYmVlbg0KPiA+ID4gb3ZlcnJpZGVuDQo+ID4gPiAoYnkgYSBkaWZmZXJlbnQgY2xpZW50KSBi
ZXR3ZWVuIGxvb2t1cCBhbmQgcmVhZGxpbmssIHJlc3VsdGluZyBpbg0KPiA+ID4gYQ0KPiA+ID4g
c3B1cmlvdXMgRUlPIGVycm9yIHJldHVybmVkIHRvIHVzZXJzcGFjZS4gRml4IHRoaXMgYnkgcHJv
cGFnYXRpbmcNCj4gPiA+IGJhY2sNCj4gPiA+IEVTVEFMRSBlcnJvcnMgc3VjaCB0aGF0IHRoZSB2
ZnMgd2lsbCByZXRyeSB0aGUgbG9va3VwL2dldF9saW5rDQo+ID4gPiAoc2ltaWxhcg0KPiA+ID4g
dG8gbmZzNF9maWxlX29wZW4pIGF0IGxlYXN0IG9uY2UuDQo+ID4gPiANCj4gPiA+IENjOiBEYW4g
QWxvbmkgPGRhbi5hbG9uaUB2YXN0ZGF0YS5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTYWdp
IEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiA+ID4gLS0tDQo+ID4gPiBOb3RlIHRoYXQg
d2l0aCB0aGlzIGNoYW5nZSB0aGUgdmZzIHNob3VsZCByZXRyeSBvbmNlIGZvcg0KPiA+ID4gRVNU
QUxFIGVycm9ycy4gSG93ZXZlciB3aXRoIGFuIGFydGlmaWNpYWwgcmVwcm9kdWNlciBvZiBoaWdo
DQo+ID4gPiBmcmVxdWVuY3kgc3ltbGluayBvdmVycmlkZXMsIG5vdGhpbmcgcHJldmVudHMgdGhl
IHJldHJ5IHRvDQo+ID4gPiBhbHNvIGVuY291bnRlciBFU1RBTEUsIHByb3BhZ2F0aW5nIHRoZSBl
cnJvciBiYWNrIHRvIHVzZXJzcGFjZS4NCj4gPiA+IFRoZSBtYW4gcGFnZXMgZm9yIG9wZW5hdC9y
ZWFkbGlua2F0IGRvIG5vdCBsaXN0IGFuIEVTVEFMRSBlcnJuby4NCj4gPiA+IA0KPiA+ID4gQW4g
YWx0ZXJuYXRpdmUgYXR0ZW1wdCAoaW1wbGVtZW50ZWQgYnkgRGFuKSB3YXMgYSBsb2NhbCByZXRy
eQ0KPiA+ID4gbG9vcA0KPiA+ID4gaW4gbmZzX2dldF9saW5rKCksIGlmIHRoaXMgaXMgYW4gYXBw
bGljYWJsZSBhcHByb2FjaCwgRGFuIGNhbg0KPiA+ID4gc2hhcmUgaGlzIHBhdGNoIGluc3RlYWQu
DQo+ID4gPiANCj4gPiA+IMKgIGZzL25mcy9zeW1saW5rLmMgfCAyICstDQo+ID4gPiDCoCAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2ZzL25mcy9zeW1saW5rLmMgYi9mcy9uZnMvc3ltbGluay5jDQo+ID4gPiBp
bmRleCAwZTI3YTJlNGU2OGIuLjEzODE4MTI5ZDI2OCAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL25m
cy9zeW1saW5rLmMNCj4gPiA+ICsrKyBiL2ZzL25mcy9zeW1saW5rLmMNCj4gPiA+IEBAIC00MSw3
ICs0MSw3IEBAIHN0YXRpYyBpbnQgbmZzX3N5bWxpbmtfZmlsbGVyKHN0cnVjdCBmaWxlDQo+ID4g
PiAqZmlsZSwgc3RydWN0IGZvbGlvICpmb2xpbykNCj4gPiA+IMKgIGVycm9yOg0KPiA+ID4gwqDC
oAlmb2xpb19zZXRfZXJyb3IoZm9saW8pOw0KPiA+ID4gwqDCoAlmb2xpb191bmxvY2soZm9saW8p
Ow0KPiA+ID4gLQlyZXR1cm4gLUVJTzsNCj4gPiA+ICsJcmV0dXJuIGVycm9yOw0KPiA+ID4gwqAg
fQ0KPiA+ID4gwqAgDQo+ID4gPiDCoCBzdGF0aWMgY29uc3QgY2hhciAqbmZzX2dldF9saW5rKHN0
cnVjdCBkZW50cnkgKmRlbnRyeSwNCj4gPiBnaXQgYmxhbWUgc2VlbXMgdG8gaW5kaWNhdGUgdGhh
dCB3ZSd2ZSByZXR1cm5lZCAtRUlPIGhlcmUgc2luY2UgdGhlDQo+ID4gYmVnaW5uaW5nIG9mIHRo
ZSBnaXQgZXJhIChhbmQgbGlrZWx5IGxvbmcgYmVmb3JlIHRoYXQpLiBJIHNlZSBubw0KPiA+IHJl
YXNvbg0KPiA+IGZvciB1cyB0byBjbG9hayB0aGUgcmVhbCBlcnJvciB0aGVyZSB0aG91Z2gsIGVz
cGVjaWFsbHkgd2l0aA0KPiA+IHNvbWV0aGluZw0KPiA+IGxpa2UgYW4gRVNUQUxFIGVycm9yLg0K
PiA+IA0KPiA+IMKgwqDCoMKgIFJldmlld2VkLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJu
ZWwub3JnPg0KPiA+IA0KPiA+IEZXSVcsIEkgdGhpbmsgd2Ugc2hvdWxkbid0IHRyeSB0byBkbyBh
bnkgcmV0cnkgbG9vcGluZyBvbiBFU1RBTEUNCj4gPiBiZXlvbmQNCj4gPiB3aGF0IHdlIGFscmVh
ZHkgZG8uDQo+ID4gDQo+ID4gWWVzLCB3ZSBjYW4gc29tZXRpbWVzIHRyaWdnZXIgRVNUQUxFIGVy
cm9ycyB0byBidWJibGUgdXAgdG8NCj4gPiB1c2VybGFuZCBpZg0KPiA+IHdlIHJlYWxseSB0aHJh
c2ggdGhlIHVuZGVybHlpbmcgZmlsZXN5c3RlbSB3aGVuIHRlc3RpbmcsIGJ1dCBJDQo+ID4gdGhp
bmsNCj4gPiB0aGF0J3MgYWN0dWFsbHkgZGVzaXJhYmxlOg0KPiANCj4gUmV0dXJuaW5nIEVTVEFM
RSB3b3VsZCBiZSBhbiBpbXByb3ZlbWVudCBvdmVyIHJldHVybmluZyBFSU8gSU1PLA0KPiBidXQg
aXQgbWF5IGJlIHN1cnByaXNpbmcgZm9yIHVzZXJzcGFjZSB0byBzZWUgYW4gdW5kb2N1bWVudGVk
IGVycm5vLg0KPiBNYXliZSB0aGUgbWFuIHBhZ2VzIGNhbiBiZSBhbWVuZGVkPw0KPiANCj4gPiAN
Cj4gPiBJZiB5b3UgaGF2ZSByZWFsIHdvcmtsb2FkcyBhY3Jvc3MgbXVsdGlwbGUgbWFjaGluZXMg
dGhhdCBhcmUgcmFjaW5nDQo+ID4gd2l0aCBvdGhlciB0aGF0IHRpZ2h0bHksIHRoZW4geW91IHNo
b3VsZCBwcm9iYWJseSBiZSB1c2luZyBzb21lDQo+ID4gc29ydCBvZg0KPiA+IGxvY2tpbmcgb3Ig
b3RoZXIgc3luY2hyb25pemF0aW9uLiBJZiBpdCdzIGNsZXZlciBlbm91Z2ggdGhhdCBpdA0KPiA+
IGRvZXNuJyd0IG5lZWQgdGhhdCwgdGhlbiBpdCBzaG91bGQgYmUgYWJsZSB0byBkZWFsIHdpdGgg
dGhlDQo+ID4gb2NjYXNpb25hbA0KPiA+IEVTVEFMRSBlcnJvciBieSByZXRyeWluZyBvbiBpdHMg
b3duLg0KPiANCj4gSSB0ZW5kIHRvIGFncmVlLiBGV0lXIFNvbGFyaXMgaGFzIGEgY29uZmlnIGtu
b2IgZm9yIG51bWJlciBvZiBzdGFsZQ0KPiByZXRyaWVzDQo+IGl0IGRvZXMsIG1heWJlIHRoZXJl
IGlzIGFuIGFwcGV0aXRlIHRvIGhhdmUgc29tZXRoaW5nIGxpa2UgdGhhdCBhcw0KPiB3ZWxsPw0K
PiANCg0KQW55IHJlYXNvbiB3aHkgd2UgY291bGRuJ3QganVzdCByZXR1cm4gRU5PRU5UIGluIHRo
ZSBjYXNlIHdoZXJlIHRoZQ0KZmlsZWhhbmRsZSBpcyBzdGFsZT8gVGhlcmUgd2lsbCBoYXZlIGJl
ZW4gYW4gdW5saW5rKCkgb24gdGhlIHN5bWxpbmsgYXQNCnNvbWUgcG9pbnQgaW4gdGhlIHJlY2Vu
dCBwYXN0Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

