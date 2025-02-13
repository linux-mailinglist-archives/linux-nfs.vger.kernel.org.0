Return-Path: <linux-nfs+bounces-10099-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDA2A34DE8
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 19:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D691882109
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 18:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138982063E2;
	Thu, 13 Feb 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="XpHMCKtH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2099.outbound.protection.outlook.com [40.107.94.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F4328A2A1
	for <linux-nfs@vger.kernel.org>; Thu, 13 Feb 2025 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472267; cv=fail; b=CMO74RR+Pktr9ZxaDyP2/Z3VUhpOwFv5ln59CVQpiZOssZJ3ezrR9rtzYIuuL4UFoQWGKgXsqGFN7gs3EIGqlnSllhBgf/TJbd6E+jwdJ8bzvdX6VrA3ggqwcnQMZmUzxB743d051IdoMNyCi8PAgowQu2UU1GNKzVTjUt0zRqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472267; c=relaxed/simple;
	bh=IiENLz+RPZufMaJiGaU9boSDPSEkMPkWv5P1tzhIjwE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rCLdA3lW6jeVa/8uvGUewDsafvwQMNxgiQNxMr9grCf4IL99W6ovoSaLtIS6GI57QdogLFPYha9a3JD+0NTxVjvfcBrvrTzOKzRjMErd2iDOknAaU7BHXUxSdpLj9Bu8TiLrS8SktW4KGt4/aQ4UYFSV+zEscdoBnBz6u5T8NJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=XpHMCKtH; arc=fail smtp.client-ip=40.107.94.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C++YDvdVhK7UAwnnAiXD/zZPAaCg9qKEQ/XGEy734YeElnDO96rLjGo8XamoRgVUrocJg4lMs29d5J/wuWn9gODD1lNtfQpgkokpQarGMF42aQ9n0wqwdEAg4ASpa25BxRyEgTajXefCTs5yxXBtHeF47/w/3fch4Kyo+oris2audvE3Sgj1fFvJLKEUfWeGeG5J+GDeOGWe9fk7wJZKBZKnswCmAsZYPDesBg7UpadLftF2D8czUNvhbZnaxWyFDMfLAOEOp/CFDo5zVBU4PIZDDM/k+T6g4z05jrIZdJ2tLqUzVi5u8Zv/Ba1uiX/AGSXAUtgi4Vj6OUokT8WX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiENLz+RPZufMaJiGaU9boSDPSEkMPkWv5P1tzhIjwE=;
 b=L6KQtvElKHFPstGKsvTV1klf6BQlAWDJiXbWWhP4P1bacGAHO5GqIRKiRpW5dhmKxPKbZJv2trCfVFtD/r7BoNfJauM3d0wzOgHGr2/+n244UNXWg/tNJQ//bh/Z0xZz3lQdMuiB0J9SAZHDw8NOarfFNXtdV9OuOoPJSuz22Y0b3FEbSWgcoguuQHfxkBAGH5bMhJp90Oq/kL5BCr19WmHAFk8/8BV3od+t57R2V2ZImKrYZNZ8VRvNKHHJw1XdPzXS0wHzVTIfJGOwIcSyCXb4pH/bY/EU/Kmcb932/D88yZ2w8k4/35WB28tf8BIrZ7PEBFrKrnKNWmvlVA59aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiENLz+RPZufMaJiGaU9boSDPSEkMPkWv5P1tzhIjwE=;
 b=XpHMCKtHe0aTeQURHshGs0xUiO+wLOPh9Mf215WaQC2z+Mc0+uVnQE8uWBEsxvywiCTd3EfCur7uHdpOFO6UfbUL6zbMI5x2J/E8VzD/RYVZnKEFLroXMZH/ogSqSbB7J7kKX1WenTEaucOMUjkXI5b616l2BwNblGmdac1mdYM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS1PR13MB6819.namprd13.prod.outlook.com (2603:10b6:8:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:44:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 18:44:19 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "aglo@umich.edu" <aglo@umich.edu>
CC: "okorniev@redhat.com" <okorniev@redhat.com>, "cel@kernel.org"
	<cel@kernel.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] NFS: CB_OFFLOAD should return DELAY when no copy
 state ID matches
Thread-Topic: [RFC PATCH] NFS: CB_OFFLOAD should return DELAY when no copy
 state ID matches
Thread-Index: AQHbfjOM2qaXtGaATkKgNd/ysX5erbNFc3UAgAAQcYCAAA5GAA==
Date: Thu, 13 Feb 2025 18:44:19 +0000
Message-ID: <18421def0a2aa132a6817b56f97eb9d6f3928727.camel@hammerspace.com>
References: <20250213161555.4914-1-cel@kernel.org>
		 <df999d533683548ba91b69b017bf2b4acc0add52.camel@hammerspace.com>
	 <CAN-5tyGt4OhqZbzzADe9OumbaThrefZ1nTw=_wrrxy7FWfWK9A@mail.gmail.com>
In-Reply-To:
 <CAN-5tyGt4OhqZbzzADe9OumbaThrefZ1nTw=_wrrxy7FWfWK9A@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DS1PR13MB6819:EE_
x-ms-office365-filtering-correlation-id: 758de56b-81de-4748-54a9-08dd4c5e6d0d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1FwQWZqLzEwY3JwdDlheFJXV3lEdGR6ZDVDdC9EK2JjTnpRMnRjNHcrRVJU?=
 =?utf-8?B?Z21ZU3J0S3FDOGwxVjVicytwMlNCdDVMUURtUTBQL1hzamtvMkYxMlFhVzZ5?=
 =?utf-8?B?ajVwbEt0VDBqNlZtSmE2UFg0aFM5ajV1ZEM1eUMrRzZEZ0hodFlDNW9hM21X?=
 =?utf-8?B?YlRsRnRwSWhodkhsNWdjWHZWY3BHRzMva1Z5OWkrTzVXeUc0b3dFVHViemhC?=
 =?utf-8?B?Q3ZyYSt6eGVGdjJPN25TUzFObjJ1cjZzZHc5SjBkc3VrYjN5T3g0UFFsZzdh?=
 =?utf-8?B?UFZNQkNPSXpOTGxrK1RXZ3VlSzVmV0FPTXBXUi9WTzhSdmw2RXVISVQwTGxn?=
 =?utf-8?B?OTJDREMvSHQxRHdxWEpWYmxEaXBBYVQyRzlxeWF4RGxlZE1mMnlrY0dDOU9h?=
 =?utf-8?B?d3NYek81S1VHRE94eGVFbHR0SG5OcUtIRmJIRWxpdGt6V1hXOStvOGNjbTRn?=
 =?utf-8?B?ZWpNNVpRVXJNTmYvVDNCbzMrOWo0cnNjOTFRM1lpU3Y3KzF2ZGMwYy9uRzV6?=
 =?utf-8?B?cUN0VEU3ZHgweisxVTRLOTRla2Iza0svYmY3UStZWlYxNmZNdVBjYldOY3RS?=
 =?utf-8?B?dWh4R2p2TWFxQkRmenQ5K0lMaUJmTERmK3lFbU9nN05UNVRLMk9rSlQyUGZn?=
 =?utf-8?B?clRzcm9SZWI0ZUF0MStIUExPcHNqZEpuT1JXamdueE9RYkpmTzhVemdib2JS?=
 =?utf-8?B?b1NvSGhEWWgxL2s3aTc3NjZxQnhGNmFPOWpBN2lOM3Nvc3U0cVNYYTNKT2VS?=
 =?utf-8?B?NW82VUZwSzNKRGxBL290RUVoaWZQMWJQRVV5OWRSNWF0SXVVam43YWtLdmpM?=
 =?utf-8?B?Zm1GQUxBRk5XNGpqZWdxMTlUeERDOTB3WTdybW9lZmh3RDczRXdKOWsvSXNh?=
 =?utf-8?B?ekZFVVJWVGlTc1NYcTJ2Z0pENThVdGpVQnBEZ3dHYkYwc0FtZzU4cE9xMTlh?=
 =?utf-8?B?RXVzdnhjWkozcmhGUjFvckg0dGR1T0dkb01LbVRiNWJ0WnpuaW1kRUZnZ1p0?=
 =?utf-8?B?MStEMEhhREVvaEtNcUhaYXBQc25rNGVQd0p5ZFdOcFo5TjlLd1VPb0FjbDlL?=
 =?utf-8?B?SGx1Zk9kSGR3WFJRd0ZRaFBrMkJaamFpNGxLeE5RRmNwVGJNbWtCMDFxL3N5?=
 =?utf-8?B?dUNlTmx5eDM0MnRvc2xLbi8wMVg0TGJrUWhQMnFGUHlacU83NHZ0aks5aFoy?=
 =?utf-8?B?aExyK09uZzdoVklkbFV1Slh3cHFrNUxCK3RPSWRVbVZHRm84OERmMTRTOHZ6?=
 =?utf-8?B?OElxYy9DLzFncjdycXBrTmZIRktpZGFwZHRNUE5LMlNnS1dhVXFaNHFZazhw?=
 =?utf-8?B?QnYzQkdmM3FBakZ5REUzcitrQi9CYVUxVUNHZDNQVzFXcGlHakgwWlVFZDJQ?=
 =?utf-8?B?NG1KRmtOZHpPczFGSnZhL3kwV0JCREd3cFFUbWFWc0cxMHZUOGpGdUgwSDh3?=
 =?utf-8?B?b2FjNGVqMDBQUmNucEVKdldiUUMwU2lGV0xHdjh1dEtmWkRpM0ZmVHpST2hL?=
 =?utf-8?B?SjB2N1dGeDRrblZpY0lBU3Y2OGJXSHBkS0ZLWGNYRi90cXFzTVhOQ3BaS3cw?=
 =?utf-8?B?WWxranBiUXhKaXVCc1RTSzQ0VUo5TFphS0x3MXlMWFdhb1BNZy9qWkszUHcy?=
 =?utf-8?B?WFJVZ1ZGNm5aU1BWNERUYlZhdG9RclRkcDBOSDJWMEFIMFVjb2Vzc3RhR0ZV?=
 =?utf-8?B?SVVId0RGZHNzRDZONjdRU1IrTmZsaFJNS3dycHZGYjBaZ1RjSlQ0MXlrVjRw?=
 =?utf-8?B?WW1zSklxSkVpMHAyQUlwcnp0TlgrWnFRanpHMyt1TXNna2JobFBoM210T2hY?=
 =?utf-8?B?ZGlmNUYraml1SWxoTGdkOGdrMHVHMEYwZ3k1ZlFPeTNjU2JDZ3R5ZmY5TE1z?=
 =?utf-8?B?M3hBMFFUN0MyTjRvTW53VEpoTTVWcUtpMlQvdVV1ZGFpNjhyeFBMY0FvNk9X?=
 =?utf-8?Q?7AkqEbMT0Y4Or2w3JmIIYyFRqBlZAOdZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0IrVG51VHpvN3R6OUZaVGZvVlY5OUlaYTBPSDUrMURMRXJPdnFrTS8zRWo2?=
 =?utf-8?B?NS9LR0Z5SjJ0L1RIT0VRRmQ3cWtKL0MyMmdSamNsNStPQUJwU0c2Q2o5QlZZ?=
 =?utf-8?B?MnZZRkhrTzI2VWp5S1RraVdiYURUT3d1UGVhQkNjQW04eVZCYTVOdkUrejJz?=
 =?utf-8?B?OEJBMVR4eXJZdUc5QVNFOWFhTzdqYzlnWW5kUmJQWExmRjNqcG9vMGZtK2gy?=
 =?utf-8?B?TE0rSjJTM0plY0Q1bFIrWG5vd3pVdXA1S3dsVE1WZGFUL2hWNHdSaFQyWi95?=
 =?utf-8?B?cFdZazlCKzhqVm1PZjUrOVdzODRKSnRKa3ROeVoxRE56TEFFWkRieFVyV3Zh?=
 =?utf-8?B?Z1NXR3RraHdXZ25wdGhWRXpmWndQWVkzazl5UzEwNHUrM3hqTzRsTWtMM0R6?=
 =?utf-8?B?aWVDMHl6NmRVZW80bW82a2dZVnp1ZDFOS2t0bHhoNXNHbk93MERKQzdnTW1T?=
 =?utf-8?B?Y0RzbE02N1RaU2kwVmM1eGRXTWh0alpMT2FaaHBFNVpnTGhXWWRWdkd5Y0Zn?=
 =?utf-8?B?Zlc1aVNGRWsyWGRobTlvS0VFYld2MVBjajI4dk1OemdsdmlQYUt2b0piQkpm?=
 =?utf-8?B?Y1dxWTBEYllJM3MrMm1JR0RhVDlDM1o1T0dRc015cFRBNzQ4SlFGN05jUkRz?=
 =?utf-8?B?Smo1K1IyQS9qa3JWODBGV2NsTHlORTZmQVNVd0NhMDZWYVMyM0JuOVIyQmhX?=
 =?utf-8?B?bkJvbW5mdm1pdGUra09FVGdkeWR1QXdhbzQ4a2tiWHoxdlQ3MGxiTHpOK00w?=
 =?utf-8?B?dUFWejFneUFvUVhoajRxN0NlU1JrTlNHRXk1SGQwdnI3MEVqNk53M1BONHlN?=
 =?utf-8?B?eTFqL3g2Rm4vS3ZBbHI0YnNWR1BkM1JtRWhHc0tJcDBJSHJWSC95bnlOOFEx?=
 =?utf-8?B?T21Bc0FnMm5MaWhyVEFlVWhKTnp2WUt1SU55VjAwUG0vVnh5Ui8xbVZSSUw0?=
 =?utf-8?B?d0V1eXhrMVNwMVZoRTRoczZvRFRBVXRlUU5IOXp6cVhrNzlGMnFwT3ZyOFJ3?=
 =?utf-8?B?WnpaRGQvNkxkNUdib3J1UlFVdTVwemxoM2tBanltdVFqSnRaZjNnT0xaU0U5?=
 =?utf-8?B?eVY1YnhRbHc3ZTRad1JuRWdrQWYrYXpQb3lNN0FIcGlrcE80UE94dnpMOTdq?=
 =?utf-8?B?b1J4TGl6M0tCay94U1drRkR2dHR0dWZsQUJJMFB2SzE5cnNCOXRiN2F5cFhT?=
 =?utf-8?B?cnZGUisrTEw4eml1WDNnSmxEQkErek93WVFtbCtuU1d4YVNvU3FrbTFscGl2?=
 =?utf-8?B?OWJ5Mk95Z251UUIvdUtFeVFpUENYbnBrV3pjaHE4RUZsZ1pHMzBORGhQb0dv?=
 =?utf-8?B?SXhkd0ZKWVFIUldsNTBDczltL3VxOEdXRDNMOWsyeXVTSkx0alBGeEVMS0xU?=
 =?utf-8?B?dlk3TFIrSVB6eHhKWkNVQVlmN3dIbm92ZHBVcW9QVWhzMUxQRk5pZ2ROeTl6?=
 =?utf-8?B?bS93eFZ0T3p6Vi8zOXA2amowNXpHZ0FvYjNRTmxNMjRuNnpSYkdWUkJOcTNp?=
 =?utf-8?B?YzZKYWdkd1BTb3Q4bXJ2VGJwd045MndTTDQxbS94VXZuK2xzR3creW9FVnVi?=
 =?utf-8?B?QmtrYlN3cWVrdUVyTG41aERyUTM4aXljSXFQNGdrc1VlUDZiOXJ4OGh0ZWs2?=
 =?utf-8?B?ZzFQcEs2UDBWM0grdFdQSUxOa1B5YTJia2ZPOEdVN0VIdlNUZkV6MlhJOFlh?=
 =?utf-8?B?SkdvWnJuYXhWc1R5Q1RsaUQ1OW8xR0VOTEZYQnBRenFwdVN1ZFEzWFZuMWZo?=
 =?utf-8?B?YzR5bEZybkxFZHB4YWU5MmVZdkVBQ2pZemNHaFJCKzlNWFFxSjgxdzNFbDFy?=
 =?utf-8?B?RW9DQjc2ekowS0VvOHAwV0V5d2tYMFZQYStBTTBBUjlTMW5TZ1RTbFV1ZDRp?=
 =?utf-8?B?Y0gyaTJOc1FLNVY2MjRBNEFZbzFvM2xCd3FuUlFLWjhUUXBnRlJrR2I0M3Rv?=
 =?utf-8?B?MEZPRWF3NldGVWJrQ1plQklCY0lWV2hQQjRUeG1QdUZ2Zm1xeEpFN0l6SWRB?=
 =?utf-8?B?Z2lvN1N5NVBxeHl5NFljcWcxb3dUODUxbHZYaUg4N1YydDdtMVdSa2pxVEZN?=
 =?utf-8?B?dDQ0anVUTTJoZGRISlJaOHVHUXFMM3Y1c1ZBRnR4YkVCQ256M3dwelNNMURk?=
 =?utf-8?B?bUVlcittNFgxWDQ0MzZNVEs2UTB4eUdBaUFYblltUWV2Vng0c2tkbmpLQTI4?=
 =?utf-8?B?bVlZNVpnQU52RjBnYnZFbkd0bGxDa0RIWVRvSFNiQlRUSmQ5Nmd6d3BSU0x0?=
 =?utf-8?B?OGV5WVRYaFNxNGh6a1k5YUdYUThRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D7FBE7A73B1594EB5C6E9B78DA07A80@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 758de56b-81de-4748-54a9-08dd4c5e6d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 18:44:19.6070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YV9tcX7DPSxx8LUafQygrm37y6w0WKn9JAnPBVClwczi5PpA7pCkFcVAYr8cEdo+W86hCcl6C7JnkANyEzAw/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR13MB6819

T24gVGh1LCAyMDI1LTAyLTEzIGF0IDEyOjUzIC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVGh1LCBGZWIgMTMsIDIwMjUgYXQgMTE6NTnigK9BTSBUcm9uZCBNeWtsZWJ1c3QN
Cj4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUaHUsIDIw
MjUtMDItMTMgYXQgMTE6MTUgLTA1MDAsIGNlbEBrZXJuZWwub3JnwqB3cm90ZToNCj4gPiA+IEZy
b206IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiA+ID4gDQo+ID4gPiBU
aGUgTkZTdjQuMiBwcm90b2NvbCByZXF1aXJlcyB0aGF0IGEgY2xpZW50IG1hdGNoIGEgQ0JfT0ZG
TE9BRA0KPiA+ID4gY2FsbGJhY2sgdG8gYSBDT1BZIHJlcGx5IGNvbnRhaW5pbmcgdGhlIHNhbWUg
Y29weSBzdGF0ZSBJRC4NCj4gPiA+IEhvd2V2ZXIsDQo+ID4gPiBpdCdzIHBvc3NpYmxlIHRoYXQg
dGhlIG9yZGVyIG9mIHRoZSBjYWxsYmFjayBhbmQgcmVwbHkgcHJvY2Vzc2luZw0KPiA+ID4gb24N
Cj4gPiA+IHRoZSBjbGllbnQgY2FuIGNhdXNlIHRoZSBDQl9PRkZMT0FEIHRvIGJlIHJlY2VpdmVk
IGFuZCBwcm9jZXNzZWQNCj4gPiA+IC9iZWZvcmUvIHRoZSBjbGllbnQgaGFzIGRlYWx0IHdpdGgg
dGhlIENPUFkgcmVwbHkuDQo+ID4gPiANCj4gPiA+IEN1cnJlbnRseSwgaW4gdGhpcyBjYXNlLCB0
aGUgTGludXggTkZTIGNsaWVudCB3aWxsIHF1ZXVlIGEgZnJlc2gNCj4gPiA+IHN0cnVjdCBuZnM0
X2NvcHlfc3RhdGUgaW4gdGhlIENCX09GRkxPQUQgaGFuZGxlci4NCj4gPiA+IGhhbmRsZV9hc3lu
Y19jb3B5KCkgdGhlbiBjaGVja3MgZm9yIGEgbWF0Y2hpbmcgbmZzNF9jb3B5X3N0YXRlDQo+ID4g
PiBiZWZvcmUgc2V0dGxpbmcgZG93biB0byB3YWl0IGZvciBhIENCX09GRkxPQUQgcmVwbHkuDQo+
ID4gPiANCj4gPiA+IEJ1dCBpdCB3b3VsZCBiZSBzaW1wbGVyIGZvciB0aGUgY2xpZW50J3MgY2Fs
bGJhY2sgc2VydmljZSB0bw0KPiA+ID4gcmVzcG9uZA0KPiA+ID4gdG8gc3VjaCBhIENCX09GRkxP
QUQgd2l0aCAiSSdtIG5vdCByZWFkeSB5ZXQiIGFuZCBoYXZlIHRoZSBzZXJ2ZXINCj4gPiA+IHNl
bmQgdGhlIENCX09GRkxPQUQgYWdhaW4gbGF0ZXIuIFRoaXMgYXZvaWRzIHRoZSBuZWVkIGZvciB0
aGUNCj4gPiA+IGNsaWVudCdzIENCX09GRkxPQUQgcHJvY2Vzc2luZyB0byBhbGxvY2F0ZSBhbiBl
eHRyYSBzdHJ1Y3QNCj4gPiA+IG5mczRfY29weV9zdGF0ZSAtLSBpbiBtb3N0IGNhc2VzIHRoYXQg
YWxsb2NhdGlvbiB3aWxsIGJlIHRvc3NlZA0KPiA+ID4gaW1tZWRpYXRlbHksIGFuZCBpdCdzIG9u
ZSBsZXNzIG1lbW9yeSBhbGxvY2F0aW9uIHRoYXQgd2UgaGF2ZSB0bw0KPiA+ID4gd29ycnkgYWJv
dXQgYWNjaWRlbnRhbGx5IGxlYWtpbmcgb3IgYWNjdW11bGF0aW5nIG92ZXIgdGltZS4NCj4gPiAN
Cj4gPiBXaHkgY2FuJ3QgdGhlIHNlcnZlciBqdXN0IGZpbGwgYW4gYXBwcm9wcmlhdGUgZW50cnkg
Zm9yDQo+ID4gY3NhX3JlZmVycmluZ19jYWxsX2xpc3RzPD4gaW4gdGhlIENCX1NFUVVFTkNFIG9w
ZXJhdGlvbiBmb3IgdGhlDQo+ID4gQ0JfT0ZGTE9BRCBjYWxsYmFjaz8gVGhhdCdzIHRoZSBtZWNo
YW5pc20gdGhhdCBpcyBpbnRlbmRlZCB0byBiZQ0KPiA+IHVzZWQNCj4gPiB0byBhdm9pZCB0aGUg
YWJvdmUga2luZCBvZiByYWNlLg0KPiANCj4gTGV0J3Mgc2F5IHRoZSBsaW51eCBzZXJ2ZXIgZG9l
cyBpbXBsZW1lbnQgdGhlIGxpc3QgYnV0IHdoYXQgYWJvdXQNCj4gb3RoZXIgaW1wbGVtZW50YXRp
b25zIHRoYXQgd2lsbCBub3QuIFRoZSBjbGllbnQgc3RpbGwgbmVlZHMgYW4NCj4gYXBwcm9hY2gg
dG8gaGFuZGxlIENCX09GRkxPQUQvQ09QWSByZXBseS4NCj4gPiANCg0KVGhlcmUgYXJlIHNldmVy
YWwgY2FzZXMgdGhhdCBuZWVkIHRvIGJlIGhhbmRsZWQuIE9mZiB0aGUgdG9wIG9mIG15DQpoZWFk
Og0KICAgMS4gVGhlIHJlcGx5IHRvIENPUFkgaGFzbid0IHlldCBiZWVuIHByb2Nlc3NlZC4NCiAg
IDIuIFRoZSBDT1BZIGlzIGNvbXBsZXRlLCBhbmQgdGhlIHN0YXRlIGhhcyBiZWVuIGZvcmdvdHRl
bi4NCiAgIDMuIFRoZSBzdGF0ZWlkIHByZXNlbnRlZCBieSBDQl9PRkZMT0FEIGlzIG9uZSB0aGF0
IHdhcyByZXVzZWQgZm9yIGENCiAgICAgIHNlY29uZCBDT1BZIHJlcXVlc3QgYWZ0ZXIgYSBwcmV2
aW91cyBvbmUgY29tcGxldGVkLg0KDQpUaGUgY2xpZW50IHdpbGwgd2FudCB0byBzZW5kIGRpZmZl
cmVudCBlcnJvcnMgZm9yIGVpdGhlciBjYXNlDQooTkZTNEVSUl9ERUxBWSBpbiB0aGUgZmlyc3Qg
YW5kIHRoaXJkIGNhc2UsIE5GUzRFUlJfQkFEX1NUQVRFSUQgaW4gdGhlDQpzZWNvbmQpLg0KV2l0
aCBjc2FfcmVmZXJyaW5nX2NhbGxfbGlzdHM8PiwgdGhlIGNsaWVudCBjYW4gZWFzaWx5IGRpc3Rp
bmd1aXNoDQpiZXR3ZWVuIHRoZSBjYXNlcyBhbmQgcmV0dXJuIHRoZSByaWdodCByZXNwb25zZS4g
V2l0aG91dCBpdCwgdGhlIGNsaWVudA0KbWlnaHQgZW5kIHVwIHJldHVybmluZyBORlM0RVJSX0JB
RF9TVEFURUlEIGluIGNhc2UgMywgb3IgTkZTNEVSUl9ERUxBWQ0KaW4gY2FzZSAyLCBldGMuLi4N
Cg0KU28gaW4gcHJhY3RpY2UsIHdlIHdhbnQgYWxsIHNlcnZlcnMgdG8gZG8gdGhlIHJpZ2h0IHRo
aW5nIGlmIHRoZXkgd2FudA0KdG8gYXZvaWQgY29uZnVzaW9uIG92ZXIgc3RhdGUuIFRoZSBjbGll
bnQgY2FuJ3QgZml4IHRoZXNlIHJhY2VzIG9uIGl0cw0Kb3duLg0KDQotLSANClRyb25kIE15a2xl
YnVzdCBMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQo=

