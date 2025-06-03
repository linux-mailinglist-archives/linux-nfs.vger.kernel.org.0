Return-Path: <linux-nfs+bounces-12073-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBCBACC60E
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 13:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C351716A548
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375CF1DE3D9;
	Tue,  3 Jun 2025 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ics.muni.cz header.i=@ics.muni.cz header.b="XYM5Dc4z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023111.outbound.protection.outlook.com [40.107.162.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B947417A2EA
	for <linux-nfs@vger.kernel.org>; Tue,  3 Jun 2025 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748951880; cv=fail; b=gOmRToZBjoij5Q12nYqG5TG6qW4rN7Mvjp2p6yjtg/E1gjkadgegXbk6YSlagwolY9MvPkotratmqBjgODuhx8zxoFvhYL8V+zaUrjSkes2I4pV65pDfF1RBe3tTXzaSUEKlSetkfDJmed19oiwVsllLEfxofUEm/I//fPj+ywI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748951880; c=relaxed/simple;
	bh=/O8J1XpZc8BIyceBTg26uroy1ADS1Fwo88Gc2xGK+g8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iK/PRi6F+zraM2Wo1y0mcFJ27115Ai6VblbMi6isq5g4GSdqFg349t5AcSphkZrEuIaVOzZdcOUze15ylzRW188QRRuuZj+zGOn5begGWs9OQYL7B8hWGM9t11i/ZsV2oKstjuSZWWi8vRnlBy536LJo9SZPUrup+N9Oaierp4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ics.muni.cz; spf=pass smtp.mailfrom=ics.muni.cz; dkim=pass (2048-bit key) header.d=ics.muni.cz header.i=@ics.muni.cz header.b=XYM5Dc4z; arc=fail smtp.client-ip=40.107.162.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ics.muni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ics.muni.cz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbuFdZECOG910I4ws1MVXqAtA8G5fvOkq/tuqqhJ+78ZxGjRyC63t+zRSnzWz8sRWN7EZyRGLA3LenUZFfZE8uW6xluo/GvGOH/847uxocSCt7IjkToVsIanSBxddw5P98DCEyM7kBG6gcRv6YeO69m7WsmtH4XMlptJt5IW3DVGGworblZXgAxdM+fNeV1xUnSSE0OlRQnblHjBOyMXY+sasolwutukuTONuSx1tqXp52n9YtvYkGXOzw/Gc7zBHF33MgZB5HoVvQMYSl9+IkE+2Qq1HMIAecZzYuMqMxuKPxB5IEGuQYk4w5wcgbJppzfTGK4ruR9e4+pTOtMGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/O8J1XpZc8BIyceBTg26uroy1ADS1Fwo88Gc2xGK+g8=;
 b=GSkwSkPmrNOTNUA4qGayyKO406mlRKenp2JdSMacQfl/3ARfoC/24xfBsv1zrkNqrO3dV3DftJEfXmQpr99Bw8AfEq2uqy+ylkaHxpywg84asAuKIlO45PKpLVuaoxU7rRKkWNaN0is6rTbXTfs4X9Qoe4njvlfAqbGJ6RsneZdGgV1FeTUhVxo6TwUH8Ms624+/SqX/ND0vNQDq6Y72BzGSrpK6+9U0rMdbV1zh0y4fjIxEwauYkGwNA/EwV/ucoyMG/bqTxq7+paHWBbdaVZ811QkcBGg3ZL6KFZVqfnxIwZ0TRNnwvZpCeUiHJHDp9d8fV0XwM7R1MH5RXyA0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ics.muni.cz; dmarc=pass action=none header.from=ics.muni.cz;
 dkim=pass header.d=ics.muni.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ics.muni.cz;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/O8J1XpZc8BIyceBTg26uroy1ADS1Fwo88Gc2xGK+g8=;
 b=XYM5Dc4z4mm+nMbowU9q4Yla2y8S88qHnkd2xBuewgSYsBSn5BQy8sAEjHjhuTPoOr29kMyNDFgbcjyM6fjvutVvFuannHl+bfQnF9kzSA4KdNvC4M3z0SkUetVMyaW5QhpvaGNWW30hhWZOIdTkr+y20xBnnkLXlq3H07dO5fyJnTJ/Zr9OLUCa2X+ttX7R4x9OUwKJm5ngXYSgTyAzzNRZDFfZDzexnebE9uYMol5J7UIWu63xzugGA3RSjBxJMYQ2CACsPoGu0dcPenfsu3QoZeHuTxNKETJb8rD85EEhvgfF3n1iuS4pwkCX79/phcrXO2P2BhdlQQ11DUteiQ==
Received: from AS2PR03MB10156.eurprd03.prod.outlook.com (2603:10a6:20b:644::6)
 by PA4PR03MB7390.eurprd03.prod.outlook.com (2603:10a6:102:10a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 11:57:51 +0000
Received: from AS2PR03MB10156.eurprd03.prod.outlook.com
 ([fe80::976c:f372:23d2:d79d]) by AS2PR03MB10156.eurprd03.prod.outlook.com
 ([fe80::976c:f372:23d2:d79d%6]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 11:57:51 +0000
From: =?utf-8?B?THVrw6HFoSBIZWp0bcOhbmVr?= <xhejtman@ics.muni.cz>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC: Zdenek Salvet <salvet@ics.muni.cz>
Subject: NFS stuck in nfs_lookup_revalidate
Thread-Topic: NFS stuck in nfs_lookup_revalidate
Thread-Index: AQHb1H671gOEqltOqEOL0BrST2FWug==
Date: Tue, 3 Jun 2025 11:57:51 +0000
Message-ID: <18945D18-3EDB-4771-B019-0335CE671077@ics.muni.cz>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ics.muni.cz;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR03MB10156:EE_|PA4PR03MB7390:EE_
x-ms-office365-filtering-correlation-id: 5b0cd89c-345c-4f38-b2e3-08dda295de1e
x-muni-spam-whitelist-from: O365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dTVBZktxOGxXNzRJQndNQWhja3dyZW93b2k1NEMxeEFKbW1rTnZMRWpuMkhj?=
 =?utf-8?B?K2xUSjhNY0t1WlpnYlIwUUxCU1lOczU1R3JwZnBmWnRIQ2JBQ0xkNXRUbGNy?=
 =?utf-8?B?dERHYzJ5TStkY2FiQXdZSERDSVJzZ2l3TW9LV1VTMFE5NnQ5QXV1cW1jQUdR?=
 =?utf-8?B?cGx5UHZwNVV0eHZEWkV2V0t4MzAyY3RXcURhQWgvM2RQSHcwMGdscEFrYXg3?=
 =?utf-8?B?UUhjSXRYRFB6NXRQS0VXWndWYVZhSUJYaVVWSVo0bTFpUStIdmlhaEJoUjJa?=
 =?utf-8?B?QlhNTU5kRkprc0lJYm53WkNBWTh1Q0x3OEZVVEdjUGxHRE9UdjQweURCNUc5?=
 =?utf-8?B?VDF2NXZjR3lDZVNGaVoySFNzSFRLVzVIQlpjTWdGa0FKdTlCM0pmYk0yQnNX?=
 =?utf-8?B?VGVoWW1VYjZCMndENlhXZDNHVjhhY0tFUjEvcDJkSS9UMmY5NklvcHJLemk0?=
 =?utf-8?B?dUp2RWdVUGMvWnJzMnVmMnQ0Y1F1aE9GVTYyUTdmQldtYjQ3RC9ja3hKSTdq?=
 =?utf-8?B?T3pjYWxHRVg2bVJZTG5qcDA4eVNFem91Smo4NGd2dnkvbmh6bWlzdysyMElz?=
 =?utf-8?B?aG1wSld3enZHUkZZUmFaSG0vQmNhUVFwbjBmaU10SUdJYWxGT1BLdHB1a1Z3?=
 =?utf-8?B?OEdFcndMSVBLMnIzMi9nSEkvUTVieGg1YVZoYnFSYVZGV2RJd3JFRzRwOGRR?=
 =?utf-8?B?Sk5STEY3ME5VcS9kaEo1V3lydGFwQUpxbzVkT0NONmdHeTZTQ0hQUEtXRzBl?=
 =?utf-8?B?T3I5c2xIMmpDQklUUUU0eXF1NXR4VFBsakdHRVV2RFBTeUg4R1RTZ1RwdGtO?=
 =?utf-8?B?aUFzelVnK1JjVlRsUTgxZUFZK1pxRUt6dGVxL0JrOWE0cFFEOE82V1Z6Sm5W?=
 =?utf-8?B?OUZiVGRid0VqVXJ3ckI2UG44eXdwMHhPU1I5R01SS3hWWGJCU2E3V1UydDdy?=
 =?utf-8?B?a1dLWFdhdjFjZC9ZL3ZIR05qL21RQ3BUQjhhTFFFK0dJYVRuKytmSXpPdXdn?=
 =?utf-8?B?S05CTzE0bktTbjJDVXVXZWI3dit2OS9Bam1naVRRYkdsVHN0NGVDZVlscGlU?=
 =?utf-8?B?d0RzODEzamZKeHUyeWxzblNHVkpEWFROa1BhYURxaXI3WTlXZzJwRzdmcEtz?=
 =?utf-8?B?bTJOaDJheTJHdFl2ZGE4V1Ava1hkMlBKSDNuT2RTM2ZvZUtLTkdHUnM4S2hm?=
 =?utf-8?B?OXBHaHZkSFJSdWZZVkhjcGtkcFk3WlNrVGFOeFgvQURReUx5alAxaVVVOGtq?=
 =?utf-8?B?U3UvbFJRaFdEK1U2WG5mSTROb3AzUXRnM2JNSENST2FMd1pNSDB0MW0xUzNI?=
 =?utf-8?B?cVp3di92NnZuQ0hqN0hrejZwQkNoNWFKTmh4K09oanBoa1d2SXN5Mis0WFFN?=
 =?utf-8?B?bW1XbHA2Z2pMYmFMbGlyb2w4U2h6V1JtMXBoL0VUSy83Ym0vL043V3B1Qjky?=
 =?utf-8?B?WWMyZXU1UUxxM0J4dFZKbGtoZTFFWE9GWUJDYmJteUEvSGtCdmo5cnFmblRl?=
 =?utf-8?B?U3oxVGkzbTRUdlRMOEZXMTBrTTZRVTU5alhZcWpKUm9rRVN3SWYvUU1wdmFY?=
 =?utf-8?B?cStDSGJLUGlLYkhsTHEzbE44djh3emIzTzVaL01pdjB3WEJSRE0ycHA1bEQz?=
 =?utf-8?B?RDViQ29GUm52SXVrSndPc1B1b2phUC9MVlRFa2gvVTJlaDdrYmdPQ0MwV0hk?=
 =?utf-8?B?WXo2M3lVeWtNQ3V0NzlRTzEzS1ZkdzhTQ0p6THBIK2hkVWNBWXIwV1hyOGhS?=
 =?utf-8?B?Mm90ajVtZzZ0RmpleU5vZHd4ZWd6RG5CdGpaRE5PSmRiU3pmQ0VUN3JvZnBj?=
 =?utf-8?B?Y3FibWhYbGNIYjBBWHQ2aUVzemcwMW5ONDlkRU81MEhXNFVxeFF3TkR1OGVi?=
 =?utf-8?B?WE0vSE1kVTdTbU5zcWlLcS8rQ1NkclFTcUxMV3pPTnhtVC9YbzFNbWEwZ1o2?=
 =?utf-8?B?SHpLaDNnRmJOWElGc05tRFpia3JYbWJuclZ5d0E4ejZNZ1N4TzBIR1NXd09P?=
 =?utf-8?Q?buNtfCTPadYOe5Bc6cGFa0dSM9fuAs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR03MB10156.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sk1qdjY3OTdtdUhvRWZ2bGUxRXY0MDVDK1pFM1M2cUd0N3BFVys1b0lOQ0JU?=
 =?utf-8?B?VlRsRFJYN2Mrd3M0SFpWZVV2MXh0MTJsUFRncVZWWGVRT2lrUkQ0UU1idmFk?=
 =?utf-8?B?cG4vR0x6S083dUZ5eEdXbFBINC9zcjdlTDB1OG9ORlk4WjJ3bVNZKzlLWWJ2?=
 =?utf-8?B?Y1R2WEFpYi9VN21jNGNleU0xcHJmbDZRN0xJUitNc1RETGhucWtJT3dKaTBx?=
 =?utf-8?B?UE42R2RONjlHYnp5WHdCeURpZkkxVzlHaHJVa3EwZlhMbC9oV1h3UzJrYTJI?=
 =?utf-8?B?TWNXSEdmdnltNm91WXFqYVRCM3hPenRrMFY4S1RPY3VWMlkvWVNnQnh4Tjh4?=
 =?utf-8?B?YWlvcEdkYS9kUUlJTmx4QTl6ZmVQVmUwZE1ML1pTeHNZa1RPaWFtT3UrUlgy?=
 =?utf-8?B?bXp5OE83SGdrUW96SlNEKzh1cThEZW5DYzI4V1hoaUw4R29mNXhvbTVxazZR?=
 =?utf-8?B?SkdPS3RDaU9odXo5M1NIWmltZjFQMzdDcHMyU3ExUXZSOXg5L1hlaTdIYUwz?=
 =?utf-8?B?Y0xOcTNZR2V1REhuaWFIb1k4c3AxNWpkeUl4dnJ1dTIzTkhQWDZ3Rk8vRzdB?=
 =?utf-8?B?K3ZrbnFmR0ZiODNvOUZzWXpRK2oxaWw5b29tWU9aM093QWZwODdZN2E4dXc4?=
 =?utf-8?B?YUtHbzZZWlF3djhNL1RSNGo0WCtrRzNMam8xbXByT2xXek9JZXdBbjlBMHpt?=
 =?utf-8?B?V3U5OU5VV2pNVERCRnRKM0VHNkt4VjkwcEJxOWxHOE9yQVNETHNNSnlPclU0?=
 =?utf-8?B?dVVodi9Zd3grUzBrSHRQWjJLellrb2VKeGU1Y2pzbU9WWitNZ1hzNDdmSWRH?=
 =?utf-8?B?R0IvWW55ZVVuMDBkRThXMXJEOTY3eko5eWIyV25kN0w4UWVxRWllemVwVENp?=
 =?utf-8?B?cVRXVGNHNEZ4dGZrTXU2U1ZmZDg3ZnBJWlUzbi9NVXhZeFRrbHRZQnhKaTZ1?=
 =?utf-8?B?WVlZcEdhcjZTRzFNTEptYnMyVm8vR3VCTEIyUHFxS09vcngvdVVmZlZmb1lq?=
 =?utf-8?B?dFZjUkF3VHRDQWNtbHdWZ3g5QkFaZFFDZ0xnNE9YZUNjemJrZEJGb3JjaWRV?=
 =?utf-8?B?dWY1YTJTZlhhVDFUMXZVQ004Q2QrSTMrMXVIcUhpdnhOVGxnRTZSTDd1Unds?=
 =?utf-8?B?VHJnUlR6RUJtWWJyLzI2RVpHU21lRCtDWVRsUmZvTDRxRXBQdEhqVUR5ZUI0?=
 =?utf-8?B?SXBoSlBPK2hBRksxZ1hFMjhDTEFua0wzSjVleXJZRXBaMHpNOER4SUNwSW9o?=
 =?utf-8?B?YjF3UVFhL2h0MW5zd21oVEVvNnRzNkVVd043ZWt1SjRNanJlR3pCR2p6UFlP?=
 =?utf-8?B?K0NDY1RuN2dyWE4rVWY2VzE2T0NmY2JvWGwyLzRRUHIxSWJFT0NDSnpXUmtV?=
 =?utf-8?B?QnE2TktxYmNmTG5GVDhCOURNd21tNkhMWkhaWldrOEk1bXRGSFIxTm9zTGtl?=
 =?utf-8?B?WVc4ZXRjM3FyYksyT3cyKzZMeDhkZGo2cFdzOVBoK2FIaVNVUEFrK3RVbEpP?=
 =?utf-8?B?Tno2VVNOcExJdmZRazU2enJ1ajZsV2Qyb0RjMmdsU0lhS3FYYm44alNTdGZu?=
 =?utf-8?B?K3FLaEowMFpGKzFiRElwSGlyNlg4blpnS1JpQXpLUDdJbVg0SWRFNUpOY2VL?=
 =?utf-8?B?eWo1cGMvOUFaR3dTZG4yMTJiY1Fya25WeE5GdjZHeDBYazZ5bkV4SVdzK05T?=
 =?utf-8?B?Vzlmak1iYk96eGM4dWw2a2kxYkd6WktkU2VrUDlZR1l3ZGVEd0RwbytMMEVo?=
 =?utf-8?B?TG15djlnd2FUUkpOMjFNVys0VXFQY2pqVTAwaG9xSUp1djgzR1hkZStMQnFR?=
 =?utf-8?B?RlduZUdSMUZyYmFGM3RlZWc0QUJkQUJkZjdVSGJ4UnVkaHBNTGsvN3pnTWsy?=
 =?utf-8?B?MHFsMXBwbnlwNG0rQkc5bXhlWWN4VXQ0M1NiNnI3THJpd1ludEdtRE8xRnUz?=
 =?utf-8?B?dFI0UW8xakJLMXlWME04NWpQTXpCb2FjRUN0eE5HVHBUM2Y5OEd5WEZNRzhp?=
 =?utf-8?B?YjV0WjZRRXhhcVF0cVpHc29HSklmbWNjMWhuai9jMDczWldKc0RBYjBReWJR?=
 =?utf-8?B?NDlqVHYrSWtIVnJjbW8vVDlRN1QxbGxhUzZaMmNVSCtOMWFSZTBZNFNBeHY3?=
 =?utf-8?B?VGhEekpqMW1McXN1R1VwdmtWbXR6aWJ1Zk5VdGJLL1R3dHQ5UzJVUXJKN05O?=
 =?utf-8?Q?De8h3MZgzrOHx2Q8CQj6mLU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91197D6E119F684C8404B302FB345EBF@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ics.muni.cz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB10156.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0cd89c-345c-4f38-b2e3-08dda295de1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 11:57:51.6742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 11904f23-f0db-4cdc-96f7-390bd55fcee8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkXc86nt4+8IIKSIGqswpBDlI3hilCb0WopqmXOJp9Per7ui5OKis39RNo+HwyrE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7390

DQpIZWxsbywNCg0KV2UgYXJlIGV4cGVyaWVuY2luZyByZXBlYXRlZCBQb3N0Z3JlU1FMIHByb2Nl
c3MgZnJlZXplcyB3aGVuIHVzaW5nIE5GU3YzLW1vdW50ZWQgc3RvcmFnZSBvbiBjbGllbnRzIHJ1
bm5pbmcgVWJ1bnR1IGtlcm5lbHMgaW4gdGhlIDYueCBzZXJpZXMgKHNwZWNpZmljYWxseSB0ZXN0
ZWQgb24gNi4yLCA2LjgsIGFuZCA2LjExKS4NCg0KU2V0dXA6DQogICAgLSBTdG9yYWdlOiBBbGwt
Zmxhc2ggZGlzayBhcnJheSBleHBvcnRlZCB2aWEgTkZTICh2MykNCiAgICAtIENsaWVudCBPUzog
VWJ1bnR1IHdpdGgga2VybmVsIHZlcnNpb25zIDYuMiwgNi44LCA2LjExDQogICAgLSBBcHBsaWNh
dGlvbjogUG9zdGdyZVNRTCB1c2luZyB0aGUgTkZTIHZvbHVtZSBhcyBpdHMgZGF0YSBkaXJlY3Rv
cnkNCg0KU3ltcHRvbXM6DQpPbiBhZmZlY3RlZCBzeXN0ZW1zLCBQb3N0Z3JlU1FMIHByb2Nlc3Nl
cyAocGFydGljdWxhcmx5IGF1dG92YWN1dW0gd29ya2VycykgaW50ZXJtaXR0ZW50bHkgaGFuZy4g
DQpUaGUgc3RhY2sgdHJhY2Ugc2hvd3MgYSBjb25zaXN0ZW50IHBhdHRlcm4gaW52b2x2aW5nIF9f
bmZzX2xvb2t1cF9yZXZhbGlkYXRlOg0KWzwwPl0gX19uZnNfbG9va3VwX3JldmFsaWRhdGUrMHgx
MTMvMHgxNjAgW25mc10NCls8MD5dIG5mc19sb29rdXBfcmV2YWxpZGF0ZSsweDE1LzB4MzAgW25m
c10NCls8MD5dIGxvb2t1cF9mYXN0KzB4ODcvMHgxMDANCls8MD5dIG9wZW5fbGFzdF9sb29rdXBz
KzB4NWYvMHg0MDANCls8MD5dIHBhdGhfb3BlbmF0KzB4OTkvMHgyZDANCls8MD5dIGRvX2ZpbHBf
b3BlbisweGFmLzB4MTcwDQpbPDA+XSBkb19zeXNfb3BlbmF0MisweGIzLzB4ZTANCls8MD5dIF9f
eDY0X3N5c19vcGVuYXQrMHg1NS8weGEwDQpbPDA+XSB4NjRfc3lzX2NhbGwrMHgxZWIxLzB4MjVh
MA0KWzwwPl0gZG9fc3lzY2FsbF82NCsweDdmLzB4MTgwDQpbPDA+XSBlbnRyeV9TWVNDQUxMXzY0
X2FmdGVyX2h3ZnJhbWUrMHg3OC8weDgwDQoNClByb2Nlc3MgVHJlZSBFeGFtcGxlOg0KODYzODEz
ID8gICAgICAgIFpzbCAgIDEyOjI0ICBcXyBbbWFuYWdlcl0gPGRlZnVuY3Q+DQozNjQ0NTA0ID8g
ICAgICAgIERzICAgICAwOjAwICAgICAgXF8gcG9zdGdyZXM6IG1sZmxvdzogYXV0b3ZhY3V1bSB3
b3JrZXIgdGVtcGxhdGUxDQoNClRoZSBhdXRvdmFjdXVtIHdvcmtlciBpcyBtb3N0IGNvbW1vbmx5
IGFmZmVjdGVkLg0KDQpXb3JrYXJvdW5kIEF0dGVtcHQ6DQpXZSBvYnNlcnZlZCBzb21lIGltcHJv
dmVtZW50IGJ5IG1vZGlmeWluZyB0aGUgTkZTIGNsaWVudCBzb3VyY2UgZnMvbmZzL2Rpci5jIChh
cm91bmQgbGluZSAxODMzKToNCg0KQ2hhbmdlOg0KZGVudHJ5LT5kX2ZzZGF0YSA9IE5GU19GU0RB
VEFfQkxPQ0tFRDsNCg0KVG86DQpzbXBfc3RvcmVfcmVsZWFzZSgmZGVudHJ5LT5kX2ZzZGF0YSwg
TkZTX0ZTREFUQV9CTE9DS0VEKTsNCg0KV2hpbGUgdGhpcyBtaXRpZ2F0ZXMgdGhlIGlzc3VlIHNv
bWV3aGF0LCBpdCBkb2VzIG5vdCBmdWxseSByZXNvbHZlIHRoZSBoYW5ncy4NCg0KSXMgdGhpcyBh
IGtub3duIGlzc3VlIHdpdGggTkZTIGluIDYueCBrZXJuZWxzPw0KSXMgdGhlcmUgYSByZWNvbW1l
bmRlZCBwYXRjaCBvciB3b3JrYXJvdW5kPw0KQXJlIHRoZXJlIGFueSBrbm93biByZWdyZXNzaW9u
cyByZWxhdGVkIHRvIF9fbmZzX2xvb2t1cF9yZXZhbGlkYXRlIG9yIGRlbnRyeSBsb2NraW5nPw0K
DQpQcm9ibGVtIGNhbiBiZSByZWxhdGVkIHRvIHRoZSBhbGwtZmxhc2ggYXJyYXksIHRoYXQgaXMg
YWJsZSB0byBwcm92aWRlIGFib3V0IDMwayBJT1BTIG92ZXIgTkZTIGFuZCA1NjMzIFRQUyBpbiBw
Z2JlbmNoIChwZ2JlbmNoIC1UIDMwMCAtYzEwMCAtajIwIC1yKS4NCg0KT3RoZXIgTkZTIGNvbm5l
Y3Rpb25zIHRvIHRoZSBzYW1lIE5GUyBzZXJ2ZXJzIGFyZSBub3QgYWZmZWN0ZWQgYW5kIGFyZSB1
c2FibGUsIGhvd2V2ZXIsIHRoZSBwcm9jZXNzIGNhbm5vdCBiZSBraWxsZSBvYnZpb3VzbHkgYW5k
IHRoZSBjbGllbnQgbm9kZSByZWJvb3QgaXMgcmVxdWlyZWQuDQoNCkkgYmVsaWV2ZSB0aGF0IGlu
IDUueCBrZXJuZWwgc2VyaWVzIGl0IHdhcyBtb3JlIHN0YWJsZS4NCg0KLS0NCkx1a8OhxaEgSGVq
dG3DoW5law0KDQpMaW51eCBBZG1pbmlzdHJhdG9yIG9ubHkgYmVjYXVzZQ0KICBGdWxsIFRpbWUg
TXVsdGl0YXNraW5nIE5pbmphIA0KICBpcyBub3QgYW4gb2ZmaWNpYWwgam9iIHRpdGxlDQoNCg==

