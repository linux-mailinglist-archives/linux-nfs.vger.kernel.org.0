Return-Path: <linux-nfs+bounces-14048-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9E5B44632
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 21:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F40172C32
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 19:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7E223D7EC;
	Thu,  4 Sep 2025 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnal.gov header.i=@fnal.gov header.b="tyJFlpwV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SA9PR09CU002.outbound.protection.outlook.com (mail-southcentralusazon11010013.outbound.protection.outlook.com [40.93.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D34D599
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757013235; cv=fail; b=V6aSGYSJlIltvVwdu20jKs6DgF1WE3X8vN/uNU1vagwwG8TkVbCXPZteNr2bvzHx6qz4avtpvUvtmo6fkPelGf8TRqpU9ChbEMBC0ndRWk2MNRtYovxPdWQ4zAECseMcinqAyeuq9uzDgsB4+b2HSOH/3RR762NJYSkkKUbd3a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757013235; c=relaxed/simple;
	bh=HKDgmvh/51iN+4M1/vmKd1/A+eSYrA0BQbV9UcXm/w8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ADCUJliSaQsHn0EpXCDBTr69oI97bbgA123mJZeYi4JWMI80njN7WlJjSmjpu4fViX057fx1pETBArl6JoQL5arGe9wFgIXx3/FBV2NWykMKyW0Br9nbyM37w1/nHixmIu/bUcbyW5N8r0CN84Z2fLwYyF0tFIWZuofnsl1d7i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fnal.gov; spf=pass smtp.mailfrom=fnal.gov; dkim=pass (2048-bit key) header.d=fnal.gov header.i=@fnal.gov header.b=tyJFlpwV; arc=fail smtp.client-ip=40.93.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fnal.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnal.gov
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1nRjZiqqIunPjuSlteikEsUnfJJO1+tIiU6sa4XC2QEMox4VWU8460LoaVn5Nb+7rnOpo19bCUhUeYx9T7I6fsazKQmp6YOA9BlOHtCkOO4oJ5a9mFt96ma2qMRujZXxKYxG9zPjD3aDpQzufur183AkLjq2+R9IhONkUWkJBZZ2rMzFCUVqiXYBVKK7eqqU+khwsjfGs8vPZ3TweXccJ3Sb/z1xlujUDTr87uao5q80PmHtCUeLYxmd9j97segDTx5nAgJRZPK1pyCod1yHISvfMFBgw4dlLJymAA0g4658XDQAF/RuK0sa35QV8M05ilpuK7Fo9sZvognETJ1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKDgmvh/51iN+4M1/vmKd1/A+eSYrA0BQbV9UcXm/w8=;
 b=X+HEtDNeS1ApuJIgMGwD7/CkjjMhDZ+fFeyKtyoVsWsOrjpudKp6SznCN9uIA8IcZ8v67tab/Rp+CWCFyIkihUk549mg5XPUY4/qLzsgbP72RQWaj8PZ4U64UpuGYIU9liPq320EwN8gJ5zd6Ka/9Zz1u3vXXd8yCakqDe7JSqXpC4d17eD8r8brMdDwEhJ54oTYLrG4DKOEG4dco44wXj7YA4ABe5sFv0x0l8j+83i08wsnUPhgA/5TaM3FPWayOREOcF7Yy/BQzxJO2LI3+NkmsV30dNP9MyT4OeL9YoZ5XMaF041w+mZwiRl+iBLYqwEm+oNcBzFI9nNhl48htA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fnal.gov; dmarc=pass action=none header.from=fnal.gov;
 dkim=pass header.d=fnal.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fnal.gov; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKDgmvh/51iN+4M1/vmKd1/A+eSYrA0BQbV9UcXm/w8=;
 b=tyJFlpwVxnbfCVC9hVObTOeZapwTegWyxjs+QIe/bGyY+gyNTE5IgY3G9+iVSw3rk5JLKgpWic1fDUqzUpvF7D6fnjHAjEsGmGb6gqLmvAPanC/+Ame4eTL0hgs8jb0rSwyRkespq70LM5xL0i9I5hTXxyVMikBYgWrcD6GtQ6koYLnWj1AXFA74u5M/CSgRWZAncUs/qCIMrPDa6sk1zAjUoYda0Reh7+EgHgAYhLW30kbTGnZZh1xorXLFg4Im1SXNykk3a04Q9MbYFm48wNfUgbqy0Klgm3LomU5e35C1NOGxsGgI6Y30Nm9wasp2SgoMJTKeOw4NkD1Afb9HMw==
Received: from PH0PR09MB11599.namprd09.prod.outlook.com (2603:10b6:510:2aa::9)
 by PH7PR09MB11871.namprd09.prod.outlook.com (2603:10b6:510:350::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 19:13:47 +0000
Received: from PH0PR09MB11599.namprd09.prod.outlook.com
 ([fe80::7c3d:ada9:5944:a121]) by PH0PR09MB11599.namprd09.prod.outlook.com
 ([fe80::7c3d:ada9:5944:a121%6]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 19:13:46 +0000
From: Andrew Romero <romero@fnal.gov>
To: Charles Hedrick <hedrick@rutgers.edu>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: RE: GSSPROXY ( for NFS with sec=krb5, krb5i  , krb5p ) is development
 still active or is it being depreciated
Thread-Topic: GSSPROXY ( for NFS with sec=krb5, krb5i  , krb5p ) is
 development still active or is it being depreciated
Thread-Index: AduTpkJL3Z+Uz30mSiOYGbEcxqj6hSKHVvbbAAMKg7A=
Date: Thu, 4 Sep 2025 19:13:46 +0000
Message-ID:
 <PH0PR09MB115997E77F482596DBD1718ACA700A@PH0PR09MB11599.namprd09.prod.outlook.com>
References:
 <PH0PR09MB115997CF2D7A117949CDDB375A7D02@PH0PR09MB11599.namprd09.prod.outlook.com>
 <PH0PR14MB54937B2DEB65E01D5B40C97DAA00A@PH0PR14MB5493.namprd14.prod.outlook.com>
In-Reply-To:
 <PH0PR14MB54937B2DEB65E01D5B40C97DAA00A@PH0PR14MB5493.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fnal.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR09MB11599:EE_|PH7PR09MB11871:EE_
x-ms-office365-filtering-correlation-id: 36ff0557-69f2-4c69-5414-08ddebe72c2b
x-fermilab-ob: 1
x-fermilab-sender-location: inside
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z0pCMzhiNit2OU1JUzFUMUxwOFBWYWxhY0RtWHVlSEkxZ0NOcWJOV3V4K1RU?=
 =?utf-8?B?ODlIdm5JZkd3RWpWUXRaTUJmRzBMNEU0V3FMSUF5VTdpV0dJTkpGWmJ5U3A1?=
 =?utf-8?B?OERmTklVK2ZkMUFKM1JSUXhlNmsyQks3a3lRelYvME9ieVJtRVFzVW0rTndP?=
 =?utf-8?B?MjN6UVB6ZUt2YjQrWFozaEdON2hHdXk2Z1JBaVFUSDMzSnRHbG16enNrR1Na?=
 =?utf-8?B?L3RHY3pwUzJvcHFQekxjWnpaRzlHcmJoeUdOVmdBa2t6dysxS0c4UkQ1Z2R5?=
 =?utf-8?B?RGpkWUVPTzM1S0NhQklzb0huVFBydVpHTm1GVkJJMVBuektWdEExaS8xcGNG?=
 =?utf-8?B?RVpwNGhjTk42VFE5UUoxYmtJYjJIbTdqRHJEeUE1TEtZOGc2NWdvZ21idWE2?=
 =?utf-8?B?VlZxa1NFYnJ5QTl6UkRodGJBVnF5MTNIdE40eGIyK1QvSm1GUHhJSzNqWHUr?=
 =?utf-8?B?QWR5MjFnd2NHaWVDU2hUbm9GY3VpV3JQblEzZzNxMHhQcGJ2L09zcDhYTkxO?=
 =?utf-8?B?d2FGdlpTOURhTXVIVEJtMUVLWTc0ODA2YSs1TjhrRzVDaVVyU1N2aVBTTzZT?=
 =?utf-8?B?TXlVUzAxQU91VFlqOG83dnFVdFh1THFmTjlCTjU0WjRVK0M0NWxEMkFtQ3Zu?=
 =?utf-8?B?a3pkd3NQSUNPakRscitnUjdRVGdWTGJab1FGb2wxRlJzV3Z6L2Ira3gwa1pi?=
 =?utf-8?B?NVlzTjZMekRKVEZ5ZWhpWXQ5SDRkcS9ia3dKZzRSMWhIUmpLMWdwaW04WkRT?=
 =?utf-8?B?TEpxRU1sOVJoanA4ZldHMWJxM053UlpRZ2pRczlPcGt1emE3VUh3OUtGZU9Z?=
 =?utf-8?B?Z01TVFltYkxIZWcwR3JsNzZzTEo2SGdlK29NRThQelNSUXIyYkFXa0FDd1BQ?=
 =?utf-8?B?TWc2a0RRTkpIWEwycks0SEdiUm5GbURWdkRIS3BBR1FQYjVmTFdlV01aZXBK?=
 =?utf-8?B?UWhNTllNcUNzZDE1WWc1U0gxSmhtSk5yS04zL3MxcStYV0FlTHljeGtHRlds?=
 =?utf-8?B?YXE4cUZVSUIrcnZkTXNuT0dWZnlzN0tXcDFEZGdLK2J5N2JKRGxaQ2xvVEJw?=
 =?utf-8?B?eUlQMW5TQ2Y0V3VnbDNtODY0R0lLQjhtdU5USnRzcVVCZmhTajhSNVRTMmJ3?=
 =?utf-8?B?dFZQVW1nS1hZN1N3Smw4anZzK2FEVHhpbFhUSHNrNVFQUFIvQy9WTXIzRVFH?=
 =?utf-8?B?SFIvazdDRVVpZW9MYThEUHp5bkE5TjZtcUo4VUlmR1RUSHYzelhtQWdRV1c2?=
 =?utf-8?B?bXplVDFxbWh0TndmYWEwYnRqQ2lxcTBGaVNnR2RZODBpcVliSXF1eHRBSGFG?=
 =?utf-8?B?RXdMcEhodnFDaVJzd2FmQnR1R3lSODVmQlhiTHNNUWs4bUo1WlBWNEJTNUJz?=
 =?utf-8?B?ZFlCZVI2S0pPTitLSjlsaUxURHdrQkxQMEk0KzVyVHN4TzZnWCtpa3RXd1hi?=
 =?utf-8?B?ZzBzSWRCZlNFek53dVZKYTY2d0lzQUFIRk5Sb0NUZjZNeXB1cWNFOGlyME5Q?=
 =?utf-8?B?Njl5b3k5d0hwN2M5Y1lXcVoyQXVkSmdzSVZ4M3dFdnFEd3BPT2l4ZENhVGpF?=
 =?utf-8?B?RjF0ekxxUjJWdkJXbGVyWW94djljMHlqZ1cxdkRSdHlkYW9qR2hlWnJ2S0Yz?=
 =?utf-8?B?SXNxZDFmUjJUb3ZMSThwMmdrU01SSjBzNi90TWs5ZVgwV0RjN0wzcDMzOHNC?=
 =?utf-8?B?ZXJOei9JZUhWN0J0TXlJQUN2Rys1bVpDcWJ3anEzM2JMU1NGcHpNMTIwU1pR?=
 =?utf-8?B?NHRpL0N3aGJIdnNwUDZ0YWFMcGhSSWJ5TnM4VVV5VE8rRmJ2UE8ydlpFNXR2?=
 =?utf-8?B?QTc4NnJPREhDWnJPY1h0ODlCVS92SXVGQkpPS21ORnZVL1JQdnZBdklRek1i?=
 =?utf-8?B?SUhIVURxVERnYmxTajZFNTFTUTRsWEtZZ2greHY0YXB0U0xkcHdDZThDSU0x?=
 =?utf-8?B?MUpoMWlYMTRueThUUTZNaG1BaG9MQk95elU2dTNCZjVybktXczhBcDl6RVF2?=
 =?utf-8?B?UWs0c0xKc0hnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR09MB11599.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkpVaVJJRi8va2NLeUZOZ3ZhMEJLd0Voa1cxVGJET2V5eHpMc01CK05wS1hI?=
 =?utf-8?B?Ymh5ME1PYWxoU21ONWdCcEJNY2xUYkZVOHJudHdYN3BtRFV2dTFEV3N1S2xi?=
 =?utf-8?B?RE12ODJGM283a1hFUVA1RFpsQit6aXh6SFk1WXR0WW4wZTFBeFZzSnYrcnN0?=
 =?utf-8?B?S01FTzRISXFtOTJhblBubnJsVU1qTjlNMWdFOVVuai96UTY2NkJrVThORDVG?=
 =?utf-8?B?ekdnWW1HWnpQaENyVEhyVElPVTJnbkUrZUt0aUI2ZHc2Z2tRclFXVUI4Ukhh?=
 =?utf-8?B?MStBem53ODAvZ0RYMncxRDJRSEdaekpmY1hoaThPeWlaM2JDQ0ZBUmt0Yjk3?=
 =?utf-8?B?S2dyZmdkYm1NdW1Kb0FRT3NHN3lvMStFS2lZR201bkgyUG1OeVVUN2d0QTYy?=
 =?utf-8?B?R3RtOFlPaFFnaFhvMGxXd0RoN1gzNFc1ZmxqTnBvaks4LzNXSlZBeFBiUWRI?=
 =?utf-8?B?TEdZem1ETmxrVFdrRVNVZ0xPTVhyN21QaExGVDlXdmhSR08zelRjeUQ3OC9Q?=
 =?utf-8?B?U1hPaERFWVlCVDd3cnlTTmU5bS90TjRzYXByZVMxYWhmV05BNWdJUVVVVjl1?=
 =?utf-8?B?UEI1OW5DV08xS2pNUDd3Ym9pNTFOc3ZvellJRkpRUzNPM0lsUGZDbjJlU0VJ?=
 =?utf-8?B?ajNMaForSVlQTFFHRDFIdjJIMHgvOTNNWlR1ZXRZNkdlRTAxVTVoakVBTFFN?=
 =?utf-8?B?S1lUVXdxKzUyWUVqamx1NEpTMGM0ZGIydHUxVm9KdWZNdnM2OFArcWJhZ2p2?=
 =?utf-8?B?Z3JvVVc3ejlEOUs5V1p6Nm9ab1BTVFpUWGJ4bVBqN0RXazBOVVBkcmRDU3Jp?=
 =?utf-8?B?OXR2TWliVGtZb29VNjFHUDhBTForZXZ0ZEM0aFVIcHpFbjBYdVp3TXlLVndh?=
 =?utf-8?B?d3NlM01tT1c3azl4LzJHWWNscmZZczdZNXRGSG9kZ21XYWwvemo4RjhGK1V1?=
 =?utf-8?B?NDVqWlZ0NFlGTEFnSWRHcEVtYmdock90c0dzV3BMNVdzTkhUbEkyMDhxTk5k?=
 =?utf-8?B?L3U3Q2VzSnRkM2orTlJmSFZCVkRqUXVYUmtBMzExZEtuOU5QRDlyN0d2bGl1?=
 =?utf-8?B?OEVnTkhweDE2Z2ZwOU1tZlMvUFdCaW5QcGxKcVY0UlVpNWEwUnJtQisra3po?=
 =?utf-8?B?ZHQzd3F0eDV0dlJ6QmtsRmxvM0Z2TVNUSnY4NWQxUy9UblIvS3pycWNiSUdV?=
 =?utf-8?B?cnRpTDNTRGNKdk1LZWxwT1BjRW9sUXJqNGhCSnFNd0hKOWlRS1J4N3JuVHda?=
 =?utf-8?B?UWYrSVZuTmtBbFJ2ekJ3REgzT09QMlhqeTM0cTVRSmhheXlraFhKQVpDZlVS?=
 =?utf-8?B?MXFtdVBKSnM2aXFRdCtUSGVDcm53NExTUDJRZHlpSzRkWXB4YlFFV0lEVmhF?=
 =?utf-8?B?SkE1dldLSHBBL3VIYUxDc2JwMHdqY2VaTkJ0eVVoZ2xnVWt3LzY3cyttU1k4?=
 =?utf-8?B?bEdsRXR0SWY0dVhqTURCelJTbVREYmNiQm0yUHI3SzZtRXd5M3ZtbzlMd2tT?=
 =?utf-8?B?N0pqbExwM0tURGJDcFFRZzM0YWYzRG4vS3JTOXBXWWd1S1lzdlBXZFpnTlNJ?=
 =?utf-8?B?UkZiakdUMnhRU3dLd2JieWlvUmpNM2kwVDhUcHRUUjV2Qnl4citzN2VEWmNX?=
 =?utf-8?B?WksyRjZENytUR1kvUnFRVG5KK21FRWxHaHQ2V0dDTlZtQVFaN2dKY0RMeVFL?=
 =?utf-8?B?akt2T21BNWFZV2Q1MWtaNFpNNXhPZ3FiYmZoWkJ1VmFVd2ZRQ1Njb3RSclNE?=
 =?utf-8?B?OEZhYWZTUVptR0l0a1YrbDdoS29Sa3U3MW54aGNFRFM4NmJqR0xUVkNob2tK?=
 =?utf-8?B?SVYxbUFCU2dSSW9ZZEIzelE5L0hsY0EwQU9rcytmQjh4RHR2WlFnVW9YcWxx?=
 =?utf-8?B?cElxeW5PdlVZeEFBMFpsaFZSNEIwZGx5emRBdE9JeDU1eVJTTmNENEZlTjQx?=
 =?utf-8?B?QnFvYlk5UENYejJUbzZrbWZuY2JBdVpZWWNvdFpMTkZUWmtsMTJpWHMvdDBF?=
 =?utf-8?B?amJiZmNnMkNUSHF4cHhKSVAxeTl1Yys1UXE5a1J1RTNNSUNlZ1YrcUxpbjIw?=
 =?utf-8?B?ajA3VEhubzh5ZEpXOEoyOU9kRjV4ZUJOcFkrSy9DTkQwNmtNWWlBQXBxSmpa?=
 =?utf-8?B?WUFCdVVQcVN3Snc0OUFCWTlXcURsVkY0NjVBdGZ0WTRGWGFuWHB0MHYybW9T?=
 =?utf-8?Q?qCTzQuE172vXPmt/GifQxs/dEIDeU0xlE/Tk3lonij50?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fnal.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR09MB11599.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ff0557-69f2-4c69-5414-08ddebe72c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 19:13:46.7111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d5f83d3-d338-4fd3-b1c9-b7d94d70255a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR09MB11871

SGkNCg0KSeKAmW0gc3RpbGwgdXNpbmcgZ3NzcHJveHkgb24gdGhlIGNsaWVudCBzaWRlICggc28g
dGhhdCBub24gaW50ZXJhY3RpdmUgcHJvY2Vzc2VzIGNhbiBhY2Nlc3Mg4oCca2VyYmVyaXplZOKA
nSBORlMgdm9sdW1lcyApDQoNCk5vdGU6IEkgYmVsaWV2ZSB0aGF0IHRoZSBzZWN1cml0eSBpc3N1
ZSB3YXMgbm90IGEgcmVhbCBpc3N1ZSwganVzdCB0aGUgZ2VuZXJhbCByZWNvbW1lbmRhdGlvbiBu
b3QgdG8gcnVuIHNlcnZpY2VzIHVubGVzcyB5b3UgYXJlIGFjdHVhbGx5IHVzaW5nIHRoZW0gDQoN
CkFsc28sICBJIGJlbGlldmUgdGhhdCB0aGUgdXNlLWdzcy1wcm94eSBwYXJhbWV0ZXIgaXMgc3Rp
bGwgdmFsaWQuDQpUaGUgaXNzdWUgd2FzIGp1c3QgYSBtYW4gcGFnZSBpc3N1ZSDigKYgd2hpY2gg
SSBiZWxpZXZlIHdhcyByZXNvbHZlZCANCg0KDQpBbmR5DQoNCg0KPiBGcm9tOiBsaW51eC1uZnMr
b3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1uZnMrb3duZXJAdmdlci5rZXJuZWwub3JnPg0K
PiANCj4gWW91ciBtZXNzYWdlIHRvIDxsaW51eC1uZnNAdmdlci5rZXJuZWwub3JnPiB3YXMgbm90
IGRlbGl2ZXJlZCB0byB0aGUgbGlzdA0KPiBiZWNhdXNlIGl0IGNvbnRhaW5lZCBhIEhUTUwgcGFy
dC4gT25seSB0ZXh0L3BsYWluIG1lc3NhZ2VzIGFyZSBhbGxvd2VkIG9uDQo+IHRoaXMgbGlzdC4N
Cj4gDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENoYXJsZXMg
SGVkcmljayA8aGVkcmlja0BydXRnZXJzLmVkdT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJl
ciA0LCAyMDI1IDEyOjUzIFBNDQo+IFRvOiBBbmRyZXcgUm9tZXJvIDxyb21lcm9AZm5hbC5nb3Y+
OyBsaW51eC1uZnNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBHU1NQUk9YWSAoIGZv
ciBORlMgd2l0aCBzZWM9a3JiNSwga3JiNWkgLCBrcmI1cCApIGlzIGRldmVsb3BtZW50DQo+IHN0
aWxsIGFjdGl2ZSBvciBpcyBpdCBiZWluZyBkZXByZWNpYXRlZA0KPiANCj4gW0VYVEVSTkFMXSDi
gJMgVGhpcyBtZXNzYWdlIGlzIGZyb20gYW4gZXh0ZXJuYWwgc2VuZGVyDQo+IA0KPiA+IEZyb206
IEFuZHJldyBKLiBSb21lcm8gPHJvbWVyb0BmbmFsLmdvdj4NCj4gDQo+ID4gSSBub3RpY2VkIHRo
YXQgaW4gbmV3ZXIgdmVyc2lvbnMgb2YgTGludXgNCj4gPiAoIGZvciBleGFtcGxlOiBSZWQgSGF0
IEVudGVycHJpc2UgdjkgKSwgdGhlDQo+ID4gcGFyYW1ldGVyICB1c2UtZ3NzLXByb3h5DQo+ID4g
KGluIFtnc3NkXSBzZWN0aW9uIG9mIC9ldGMvbmZzLmNvbmYgZmlsZSApDQo+ID5ubyBsb25nZXIg
ZXhpc3RzLiAgV2h5IG5vdCA/DQo+IA0KPiA+IEkgaGF2ZSBhbHNvIHJlYWQgdGhhdCBzb21lIHNl
Y3VyaXR5IHNwZWNpYWxpc3RzDQo+ID4gKCBub3RlZCBpbiBzdGlndmlld2VyLmNvbSApIHRoZW9y
aXplIHRoYXQgZ3NzcHJveHkNCj4gPiBpbmNyZWFzZXMgc2VjdXJpdHkgcmlzay4NCj4gDQo+ID4g
Z3NzcHJveHkgZmFjaWxpdGF0ZXMgdGhlIHJlbGlhYmxlIHVzZSBvZiBLZXJiZXJvcyBzZWN1cmVk
DQo+ID4gTkZTIHN0b3JhZ2UgYnkgbm9uLWludGVyYWN0aXZlIHByb2Nlc3Nlcy4NCj4gDQo+IE5v
dGUgdGhhdCB0aGVyZSBhcmUgdHdvIGRpZmZlcmVudCB1c2VzIGZvciBnc3Nwcm94eSwgb24gY2xp
ZW50IGFuZCBzZXJ2ZXIgc2lkZSBvZg0KPiBORlMuIE9uIHRoZSBzZXJ2ZXIgc2lkZSB0aGVyZSdz
IG5vIGN1cnJlbnQgYWx0ZXJuYXRpdmUuIFRoZSBvbGRlciBycGMuc3ZjZ3NzZCBoYXMNCj4gYSBs
aW1pdCB0byB0aGUgdGlja2V0IHNpemUgdGhhdCBtYWtlcyBpdCBub3Qgd29yayByZWxpYWJseSB3
aXRoIHRoZSBuZXdlc3QgdmVyc2lvbnMNCj4gb2YgS2VyYmVyb3MgKHZlcnNpb25zIHVzaW5nIFBB
Q3MpLg0KPiANCj4gV2UgYXJlIGN1cnJlbnRseSB1c2luZyBvbmUgb2YgdGhlIGtsdWRnZXMgeW91
IHJlZmVyIHRvLiBJIHdhcyBwbGFubmluZyB0byBtb3ZpbmcNCj4gdG8gZ3NzcHJveHkgd2l0aCBj
b25zdHJhaW5lZCBkZWxlZ2F0aW9uLCBzaW5jZSB0aGF0IGlzIGEgc3RhbmRhcmQgZmVhdHVyZSBh
bmQNCj4gdGh1cyBsaWtlbHkgdG8gYmUgZWFzaWVyIGZvciBvdGhlciBzdGFmZiB0byBzdXBwb3J0
LiBJZiB0aGVyZSdzIHNlcmlvdXMgcGxhbnMgdG8NCj4gZGVjb21taXNzaW9uIGdzc3Byb3h5LCBJ
J2QgbGlrZSB0byBrbm93LCBzbyBJIGNhbiBhcnJhbmdlIHRvIG1ha2UgbXkga2x1ZGdlDQo+IG1v
cmUgc3VwcG9ydGFibGUuIFN1cHBvcnRpbmcgY3JvbiBqb2JzIGlzIGVzc2VudGlhbC4NCg==

