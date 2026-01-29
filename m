Return-Path: <linux-nfs+bounces-18593-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKQzA40fe2lPBgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18593-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:25 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A6EADBE1
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F1443028135
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93D37D124;
	Thu, 29 Jan 2026 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="LaHoXBkI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835137E2F1
	for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676655; cv=fail; b=dkwDyERCOjDYIJ9iUK7f0rtdI2xr+QLeEdExSlVLfKBlY0AI8QERppUTrR6abi9RjFtzJZ5W0EKsTVJO+cFnhCfdfMfa0cgKEBrpSgn2bhspuMbVQyDHWTnrkzfjTzAyePi7yvciu1sQ2PnbyFD+TQhYLtYEyTg44RbFAfpgQqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676655; c=relaxed/simple;
	bh=Cqlqxiz7ZSYygYXR5MHIQ66278Pybw7P8qJNOdE24F0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AwOFgg/CQzlvwCqlm10j/+s5NZXBajzVx0Owr/parhqeCxodnCOR1hfvqBCIg3Pb1McfSiVTCpuhp9Sn71pAjNnj/caZnDvrsUelHpMRJEpcux1rIgF7SWQreiepvygtyqx6cyq+Zj2b7/6ivAax0EljBAoGotrl+GjEDtDX5Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=LaHoXBkI; arc=fail smtp.client-ip=52.101.229.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOPCrowlVAugPXlDqiOJ73TdCjCMYDQ80/veWys2KdjbwzxG14aYrWnE91QtjAelzVwd/Bj7udCEeIaN7sRTwKL1s/UJoYz7bE1YPjS8CApoWldDsGWae8y3ap0A9b7xCkLYvEz1mmMi4To9AewEilVkcqJHbFg7lxzhUiv2AZzaF3pPF6WNU/EoymCjh8wzK/U1KvHZX1Qkt6qSdxASSpnCd8i68BnuKUg3tlIXF8Jj9vokqcB90wraQS+0iGEV7WMEIkmdYk0yW3MmBtCjKe8m7haNuulRcVQZdboetC4g1tjFgglmIEaz4AaRoHL0HbRKrQYLlsbMQu85r1Y4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cqlqxiz7ZSYygYXR5MHIQ66278Pybw7P8qJNOdE24F0=;
 b=SpSXUA0mp2sBwvUpKirozm9wdysNnJE6aPpsgSMzKo+5WwFIdRIvhBu26jrbSRIxRqBhBx7+d46tWTVr2rVBVmPOtmJ9W4BTSfIOpwOBD1VISBzwV1H4iLGa3WTWdLGjHSXGQjzAzKi0urjj3Ctiia4N4svX86EFCli8vFPhuU6Ykn0bPyovnvAUwGvG1NKt7FJcDB5GESICRWlU3Lnks21ahesr7WpW/YrwJufj5tK7476N6gCb8S25lw070IoMxd5yJb4S7u3YfzXwo8gL2DOpK5GP2kN8PKwXW16RDTBPhQztbwRjITEw07P6qtZMldI8kJ4HcKovMpqCFjutpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cqlqxiz7ZSYygYXR5MHIQ66278Pybw7P8qJNOdE24F0=;
 b=LaHoXBkIIAU5YGsa1qlhtsUFtD4yXyMY7MeHuiRsB8naTI0TiOspX0L+6lmm4riWPTZ9D/sbwvGGgzjzLZd5DdPvG3rAlQSJ9caPK9wHPrGOou1iiGA3z7QJWT+/1G3mkeE1HLHJiH4sZoeGbIqhn966VWtQpkKdiyQykPAb0cveSmV/AKUR+Mb9xRXfYDTxyWZYwGpA2RYtAV3h2eaMWUnrhRKepUbmNUzV51YhFYWSK+8y7kPEKHwo233lAQ8SRs2SZgBo4/UZmpQfB8Rcz9XUfyqaZyx3hTGWv1LfTfn57W9yGBf7QhodvBx1x0kbFT2fvfLP8I+DzJU5eBZrVA==
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by TYYPR01MB15165.jpnprd01.prod.outlook.com (2603:1096:405:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 08:50:41 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 08:50:41 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: [nfs-utils PATCH 02/10] mountstats: fix a typo in man page
Thread-Topic: [nfs-utils PATCH 02/10] mountstats: fix a typo in man page
Thread-Index: AdyQ+k6HtkzqP4MQSJ6kj/xT/oJAfA==
Date: Thu, 29 Jan 2026 08:50:41 +0000
Message-ID:
 <OSZPR01MB777224FD0BF094808D113DC0889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=fc4082e6-ceb9-4449-a181-9dfbeaffcb0b;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-01-29T08:34:20Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|TYYPR01MB15165:EE_
x-ms-office365-filtering-correlation-id: 3faa5bda-9a9c-43ea-792d-08de5f137b7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?b3plMnVVSGVLay9XUFVCRStJZGl2WHM1cUVjZ3pSdGUzS29vRWJEQ1pW?=
 =?iso-2022-jp?B?anJuZ3BEUDE3OFhhdVdDWTNNQ1FSWlhnN0FVcTBoQXpQdzVWYlpqRGI3?=
 =?iso-2022-jp?B?TzV3Tkh4Zm1KUlFuQW5ZRTJIYkI0T29GdFowNHlGaDBZb2tZbFhaTmxq?=
 =?iso-2022-jp?B?bmwwKzBWWnpiSW1FditzVW5CMUZWYVp2S2xiRVJWdVF0V2hVMDNOaWN4?=
 =?iso-2022-jp?B?c01IdzBUc0lHRXBtVjYvakhUcXBIMTN4OUJJbGtka1JtMlNGd2VhYko5?=
 =?iso-2022-jp?B?SmhrK29UbnJZTXdlVkhycTNIaFkyS2ZaWUlRM0pjaVJQRjJUREJnMUtv?=
 =?iso-2022-jp?B?WmxZYVp0V2habVd5cS9qSDl0b0RPRHhSZkhJR1Y1K0MvRWg5T3Jsblhy?=
 =?iso-2022-jp?B?Q09TaXlMT3YrTG5hYWhDZDEvcDAwYmhQWS9wb2puM0xxeTAzT1NsM2FS?=
 =?iso-2022-jp?B?NjcxVndGd2FqQmduM1JNZTEzZUdyZisva3VWTzFiRmlROWdZalR6UWxa?=
 =?iso-2022-jp?B?T0R0MkdXZXZSTi9aZllZa0V5Z1B1dFZ6SzZJRHZMdEtwN3lvVG9oTW9C?=
 =?iso-2022-jp?B?MzBaQVpRanVpaFkybTd0YlhTdkpZMUQycmNpb3c5RVNOTWVGQTNMNlMx?=
 =?iso-2022-jp?B?NHJoeGZSWkVTK1R5RmZ5QitjM2lLVFkwYXp0Zk81OFZNWndDY1NCcHI0?=
 =?iso-2022-jp?B?bU5Ta1NINHBvdFJkdW4zcDFiSWhSUHlpUzNDc3JTOHkwcXc1T0k4QkVX?=
 =?iso-2022-jp?B?ZDFkK09sS2FBVWEvajIrWFlQRFdNNytNNFcyeG51WVl0cWREUEN5MHBD?=
 =?iso-2022-jp?B?cURBbkt1aThGU1ZHVitQbUl1eFZVSDRZSDAydnZnQ3dOejJRQStJYzk1?=
 =?iso-2022-jp?B?UFhQQU84NzJGOUp1MWdNK1FtTDhWMDBtaEpucll1OFhRSU1HQU9UaGFR?=
 =?iso-2022-jp?B?amNvRTlKNy9YaXVML2F3UFZ1Rm1kMG5Dd0lhbExaOWRpaDE5NURPaDE0?=
 =?iso-2022-jp?B?QXlZWUhWWDhVNGxqMWNmQmxOUkd5dUNoWFQ1TmVBWENPOUxhWFNXWVpx?=
 =?iso-2022-jp?B?UzR1VG5TVzIrQktiUGFFVFNoZHc1dENkMHNyQXF2aWpWL285OTZMVGZW?=
 =?iso-2022-jp?B?cUN0dDV6UGZBL09jbW5iSDN2Z2lqOHdRUVN3cVFMWXdNYXlwRHVncGZG?=
 =?iso-2022-jp?B?M1VxcDhXNGQ0U0pkVndIa3VnSUpyNmt5OTRMNTdwdXo3ck1ZUk03R0hV?=
 =?iso-2022-jp?B?NXUxSFpUSjNhUEo4Wk9WZ0NKa3E1djl2NDlvcFdRL1dFN1pWN0RVTzd5?=
 =?iso-2022-jp?B?Ly95SGJ6WGkwM2JZTjhYNnkwYXByM1lNZWxBeWhyUWdIMzRiUGtNWXQ5?=
 =?iso-2022-jp?B?ME5JWUpKRzZDWGpNRjlzekt5UGhJOU54TS9pcXlIZVNiWDBSTENiem50?=
 =?iso-2022-jp?B?SU9uT1cxMWxtOW1LcXhCVzcwN2Y3c2NOVWxiVU0rN05uRENaSUZDUXo0?=
 =?iso-2022-jp?B?eGRDUzdxUDQ0SU56TElZbTdSNm91Q2hEK1BvRmdFYUprclVkVFlaQTlC?=
 =?iso-2022-jp?B?NENrU1NCZDA5cEliNU5ucEZMeWx6SFk2Znhpa25hM0lCZW5yWVJQTWVV?=
 =?iso-2022-jp?B?d0QzbTRPQUtZUFlkS1liL0dJK211US93YkxSUk9KQ0QwWmNsYWhweFFL?=
 =?iso-2022-jp?B?U0dTL1NXc05mUnBSdWJaOUF6OHY4RmtjWlg0TjRkM2NUZVNaT2ExRklK?=
 =?iso-2022-jp?B?ckpaNnU5OXNTS3UwWnBjSGIxVTg0YjJHd2l0TUQ3bkQyczBRTWhkdmlp?=
 =?iso-2022-jp?B?UnlYZW1VZTJMc3l6ZUpkNE1jV2MzVldydGZZSFFGQm9DeVZJanRyRWJ4?=
 =?iso-2022-jp?B?VFptWkZtZEN3UGJXL3JsYjFyRS9xMzduSis4TnlwaWxkNm9IVit4NmpI?=
 =?iso-2022-jp?B?STlveDlrQ1dPbmkyMmVsZmJBODk4Q3ZxV2haWmpNNHd6TXkwOGNpemNj?=
 =?iso-2022-jp?B?Nm0zYVJVYlBNZUZkSGxIRE11dVE2SmhkWHZ3VWFOQlQ4WGxLTlAvR1RP?=
 =?iso-2022-jp?B?ZytPdiszKzgycFNJeUtzVXg3dzlsMG03MnFQSGhQbXZ3K1NwWkc2YURv?=
 =?iso-2022-jp?B?VCtWR0RRSUk5MlVrYy9xWXNLL1NGVWFWTmtNRTM0aHdZTHlTVWRrbEFC?=
 =?iso-2022-jp?B?c1BQai8wd0pmZWdCMXFLYnMvclBOeWFyalk5dy8xSGdOeUZEYWpXclcy?=
 =?iso-2022-jp?B?U3JtOWJZNWdBZmx1RWZkNVF0RE8wNEl5dHJPZlBldnlkbGhvVHg3cEVW?=
 =?iso-2022-jp?B?bnVaK3dBcVVZZDI5MHpKRjdwOXFDbXJ2cmErNUYwOE5EcUNCQzErOVVp?=
 =?iso-2022-jp?B?WHgyVVp5c2UxYktvaWM5ZzZmeDBXRWFOZ2w=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?N3JwenhXc25rQWorREdLeFZvd1hVUHc5UzFzQkdGOWtjSVVVamJ1RXgv?=
 =?iso-2022-jp?B?dmRQOXJKTGxidi9FY1V0TWVNa3kvR013Qy9CNVlSVzc3dXg2VDZvZHRI?=
 =?iso-2022-jp?B?RGwzbG5xcXBDK1hOYkh2SlhGalZ6ZUhrN3p6L1p0U3Zxc3VaMFBLZXp3?=
 =?iso-2022-jp?B?S01IWHptN0E3TzhhRTk5WkVkdThWTkxHRmlLamxYaEtJWCsxUUowTTRo?=
 =?iso-2022-jp?B?U3lXYzQxZktoRGNJejkyNjh5ME1JTVpiUy93ZmRhRUR3TzE4Y3BCdnpH?=
 =?iso-2022-jp?B?OTBQR0V1RVp1cjh0UW9XbFE4S0JabnpNeW5TeC9vQ2NRaGt1bWFEblRs?=
 =?iso-2022-jp?B?M2pZZ2J0aTlkU1V5Vk51cU4zRGlxWjU4Skg0Y081ampjc3U3NUw3ekYx?=
 =?iso-2022-jp?B?VWdFeVJudm5LdUt5Y1dnUUpFMHQ3bWpQbExxdzlPTXpBQkpOMWdiOEcz?=
 =?iso-2022-jp?B?eS9FK1RNNDFkUHh0MDViNjZFcXBXWWQwbUhHeDZkNlhjR2Q2NXhEanJW?=
 =?iso-2022-jp?B?STAwM0RTVmlMVzFLOXpTa0JPeCtPK0tHQmNKeXcwUDJnV0EwSzJ3Rm1J?=
 =?iso-2022-jp?B?N2VCQTdQeXJJN2VaV0RrZ09ITDluTmw2SWdJTENNbVhQWDRQRHdFTmNP?=
 =?iso-2022-jp?B?aHFxZXJCQ2FBb0RqOVZQc0w3SGNnVWloV2xYaHJoNjRrRnUzcFpBbW9M?=
 =?iso-2022-jp?B?VmJPUTNBcHorZ2t0M3Uvd0tOTjh2ZnhIQk04aXp2UTFZTnFEOS8wcFUy?=
 =?iso-2022-jp?B?cmVuMi85NlpFbzNRZ1B3U1dlRWpBaUZkcURGK2JFbnQ5M0I3ajNqeC9X?=
 =?iso-2022-jp?B?VFBJd29sR0pKeER2YkY5VnEySWxkMVBtMTJWaER4MHR2THVOWmExL3lG?=
 =?iso-2022-jp?B?TUtCSDIwcnZlQmNwNDRVVm5rSEhNWEVpNytiWFJDcDFxbGMwb2J3Q2tM?=
 =?iso-2022-jp?B?dHhTeHhOMHJiQ2d3UWtvVEM0NnBydEZsVUxadFhUcHRNV0JrTVBYdU1F?=
 =?iso-2022-jp?B?U1RxTEtweDV3ZlZKbWNlUWFYb1VaMC8vSmxhNkNObWdMWkhDSHJBSzBp?=
 =?iso-2022-jp?B?VGp0Vkd4Y3BZczBjVkNhUkZsQWFVRjlBM2NDbFRLN1MvMFB6V3FGbXQ4?=
 =?iso-2022-jp?B?NlliTGdVajRYUUJYWlFXdVU4aGdzZWJWZWlpMUo1SGp1Q3pEUldzYi9F?=
 =?iso-2022-jp?B?L2VpSEpBRHVqU0ZzNEMwMk9ReHZ5Y1piMWJFTE9iSG1ZQVJxTTVtZ1lN?=
 =?iso-2022-jp?B?L05jbkVsTDB3N2owcFVJcDR6TTlqVWtCeFNSdFhTRUNZdUt2aS84U3dE?=
 =?iso-2022-jp?B?WXgrOXBZd3lBaUl6V0VLbWlkRWZVeTZqOVp2cWV3c0VTaitZNlNJNllk?=
 =?iso-2022-jp?B?ZTBqTWVPUUsxNHEwWGFkTisyWnNsajlZc2tFMnhQdkJHNEtsdTdtenU2?=
 =?iso-2022-jp?B?d2NmbjFPSCt0NXVxMnJuWWJHWUpNOHY4bE5PcjNmb083US85Z1JORFVL?=
 =?iso-2022-jp?B?Sy9ENWp3ZFdBZmRNZFcrMGdkNnFacGxnMW1odXlHTmt6VC80OXFkUC9K?=
 =?iso-2022-jp?B?WlczOXQyRU5PWUloQUdMSWZ0cVFFcmRMV0w5cWNsa09nUFVxSTMxNDRB?=
 =?iso-2022-jp?B?SGVxbDVjS29kUnR5ZVZIZFlKNjZYWVlmdkZ0Tk9RcTBxdURIR1VWT1FU?=
 =?iso-2022-jp?B?NmZVZmRyYXZ0d0szRlRXeWphN0NGTk0xaExTSzdIN2thSnBlYXBTVnkw?=
 =?iso-2022-jp?B?NTM0YzBKZjhxcWNRV0QyRTlwcDhuR0N1RGZBa011aHp0TmhDU2FxR3BQ?=
 =?iso-2022-jp?B?SEdVRk5mYUx0TjJUelp5eWprNWlJVUtYakgwUWtDT08yVi9RQUk5anFk?=
 =?iso-2022-jp?B?WmQ3Ymc0R0p5R1lWZ3JRODl4UVpRUk9WNWkwWTByQkdDaWxjdEkzMGRm?=
 =?iso-2022-jp?B?RG1NTW9NaXBxY1hJU3BHYTZPSVFtY0dvUzkxcXU5cjkzK29SMGhSL0Qz?=
 =?iso-2022-jp?B?Y0RWT2VCV2U3TEVjNUN0RVMrV05zUGlRYVc5RDgwUVgzUHk2NXdMSjRX?=
 =?iso-2022-jp?B?V3hqYVpvbEJGZEMwN0p4bEVqbHJGVFlXdkpJYXVhZy9CTHZ5S29kK20v?=
 =?iso-2022-jp?B?NlMrOVBqU0w5bmhDUHdyTDBvRTZZeDJ6NFRKc2sxeWlXb2pkS1hnOW5U?=
 =?iso-2022-jp?B?cXR4QjFtT1VHSW9GcmpFa2FLS3I1WXdnaUkrL2YxakRKNUd4OFNNZXZ6?=
 =?iso-2022-jp?B?bmh1ODQvYjNTUDZrTmhuS1V0UGZENTZEdVBIeGphaTBlZGhTeEV6V25F?=
 =?iso-2022-jp?B?aTFWRmh3cjVaTjR0a1JaUmFzZ3FqbWc5Q1dOMFVYbm1KRndGbW1SOFNP?=
 =?iso-2022-jp?B?amE2LzRDNGFrTjFjbDc0V2FVNkxmcjduNFFDTjVZbHdHYkU1YUxzNW1h?=
 =?iso-2022-jp?B?a1M0ZUJXc004ODB4MXhHTGRUb25oMklyMEd5LzEvdDJ0b2cxMStkMCty?=
 =?iso-2022-jp?B?OGVCUHFoU01KVkRONUFSYmZHL1Jsekw4T3Rvdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3faa5bda-9a9c-43ea-792d-08de5f137b7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 08:50:41.3067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YftyUD1o0H3teL4o43JVA688PJ8thMv6B7sYKsRrtG8hiMVUf6S4mho4YVJ7AhBRseTwwqkJ3y6ipKjhjRe7t30k5teqThKhP5z/Cs7gZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15165
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18593-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[OSZPR01MB7772.jpnprd01.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fujitsu.com:email,fujitsu.com:dkim]
X-Rspamd-Queue-Id: 82A6EADBE1
X-Rspamd-Action: no action

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
---
 tools/mountstats/mountstats.man | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mountstats/mountstats.man b/tools/mountstats/mountstats.=
man
index d5595fc7..b2940f67 100644
--- a/tools/mountstats/mountstats.man
+++ b/tools/mountstats/mountstats.man
@@ -47,7 +47,7 @@ mountstats \- Displays various NFS client per-mount stati=
stics
 .RI [ mountpoint ] ...
 .P
 .SH DESCRIPTION
-.RB "The " mountstats " command displays various NFS client statisitics fo=
r each given"
+.RB "The " mountstats " command displays various NFS client statistics for=
 each given"
 .IR mountpoint .
 .P
 .RI "If no " mountpoint " is given, statistics will be displayed for all N=
FS mountpoints on the client."
--=20
2.47.3


