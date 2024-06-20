Return-Path: <linux-nfs+bounces-4149-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C075B9107F4
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 16:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C6B28185E
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 14:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8031E48B;
	Thu, 20 Jun 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g29hgZ/9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k9qm6DFi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630841AE080
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893142; cv=fail; b=iduSfDAYgcYs/zZjuxdx0oSZBqgypHD2OfpTvthGwOTiKLQ3cKk9CFcb0l/2nwaqcJgT7u8ccr9BMKCVszfKtHkX4Gk9ORAMLIg32ycDnXQ3QLeBN7Fs0wW61OsozQue4beVffJaiN4gHxrMc7CSkBFraqcYnWhjJ5maBAtZk78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893142; c=relaxed/simple;
	bh=ioyT3ZTVuz9mwq9NwsUuI2ebPfTw2xcAkO6xLAsrG5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dFkOXadTDJIfVa/DBDSnmKXNcakWOYa3tOr4L0l8ttFsqYKVfAbsvUThoQGcQ8tQjjf/njZqk0r/BS5gYg4zgx69c8GzvSbE621OlFy/89YYTeslaCXGgbCL8OGv1JheqQ0T6knvPmEDckVdV4Ped50AZXBGrQ5Cj4ZXail70tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g29hgZ/9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k9qm6DFi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KEAtjL002309;
	Thu, 20 Jun 2024 14:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=ioyT3ZTVuz9mwq9NwsUuI2ebPfTw2xcAkO6xLAsrG
	5Y=; b=g29hgZ/9qf1sN4tMj90udsl2fggaz4rHDFPzlrV7/P+99CaGnGjvzHC1q
	7GPH5o1P+4NkholmlGZm2FdH1zPAddBvJg2T/vrmzBUNrVbFikuCXgFSA8e8QWBk
	IMPjoWtPns4DD/buaqjdoa9J4WlQy+Ub0A7IJdWmKlpYjdBJnw5U1mBsf+GkOzxh
	7bDNfX2owxnAik5Me38Ig/buYkbgvCIVFF8/usK8MCPdSUOpA0TX0b71sQTBgBB1
	4BfUGa1TWoYh488vpEM5bD1TK61FosNBNmNQ1h/wZjtnX9HXP9SGOhtqfJ3JC42y
	ArX1NwTXRElHpMIZaNX2Cq5ZE0oCg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuja0kbdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 14:18:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KDVLFO034471;
	Thu, 20 Jun 2024 14:18:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dh3sm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 14:18:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuoOgPBIGxxdx6J68fMfBQAp7VsYvC+bdtdRd1Zy1IPGknEAsXZEAxcYTIyNXpW41+oeWLqYUzE0V4o8JgtX2az226LcFK+9TFwO8efw5CBVdqoCPXlkb7aGuoC7rrIIItFjvgbTC32gGP30x0kSWlTBT1z6Aa6YzIjYruq9HxIoKpliQenLy1Xm80GK+S9u1hmmfAcPxC2fELHSHjJw3BI2olc3nlCIsLKeJgzALE9qrpjPooOSGbgpiEcc7t30r7FXdms36Zd5PZ5TiuAdIna58sVGdRgaXe8FxpJJIPeR+bcZ1eOwDAQMmDUAA4FZ3tgioAQY3MdhaCgM95kulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioyT3ZTVuz9mwq9NwsUuI2ebPfTw2xcAkO6xLAsrG5Y=;
 b=GQ65yfROTFEaZnZ5IgGuVv3zz9ix/7u/6kXhfZ7J4+Qs0xlMEUSXuKgCpe6J+kBS/tyQTjObnmGqoU2XKeQNlPwt0RSMRegZRwGgNf4Iq5ijy5KcNUlNl3dvqqmrUtakIBkLvHN8fxmQ6JkhLPXjrekLG3CqKLS37l3egPzId0QF4P0IenwiQREzey1RPkM7VtFtTI543xwDTD2OIWWS/GcQhzGKPNKnstgY5FfomtgVIkg9FiBEWFdGdZdEMs2Hbv+0Y52/n7a0Ul9v/u1DVU96mMJSiNtN4iUo+1Debg0OHCQQGOx/9WMKpy9q/3Wr9Ubvu4O81EAk4LOWy6Pi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioyT3ZTVuz9mwq9NwsUuI2ebPfTw2xcAkO6xLAsrG5Y=;
 b=k9qm6DFiMsOUhD9EoK2PIjqbgPKLdSTUklKM89Kf1v8+yzL5EoGkgFJsAcVQ9bYgdRlEJMIx9futs8a4hBa+fbJHLKeSJi1gf6qCLKyztq8/bfU8d4Jj0IN0OWP3Ou2GV468oQP6DPI+QAvzeZ10zbNU7bvlqqktvTK2ztH5kGU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8172.namprd10.prod.outlook.com (2603:10b6:610:239::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 14:18:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 14:18:44 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: Benjamin Coddington <bcodding@redhat.com>, Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Thread-Topic: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Thread-Index: AQHawm/CgEvIcdZwlkSjDWk5lLIWlrHQGkYAgACTLICAAAY9gIAAAOiA
Date: Thu, 20 Jun 2024 14:18:44 +0000
Message-ID: <948F5D3F-9152-44CC-8D6A-75DD69182802@oracle.com>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-9-cel@kernel.org> <20240620050614.GE19613@lst.de>
 <3859730C-40EC-4818-9058-D74E4153623B@redhat.com>
 <20240620141519.GB20135@lst.de>
In-Reply-To: <20240620141519.GB20135@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH4PR10MB8172:EE_
x-ms-office365-filtering-correlation-id: 2baf5949-be86-4c5c-2c1c-08dc9133e469
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?djVaNnJpbCtXYkd1KzEvRHlXRlAwYXQ0M2tJaHlGY3F5UEFLNk9UN3ROWWNC?=
 =?utf-8?B?SUl0cTJwanBXaUEyNUtvQ3N3eS84NTUzYlJITWhxNHBkQzVYNDdXZ2dQamFR?=
 =?utf-8?B?eHdDZzlNdi9lcjJoUXhHY1RXWndINHNiSG9HVFF1STNURmVBdCtSQXh0cHUr?=
 =?utf-8?B?UUhSaUNuMzc5ZVlYOWovQ0l0MXVDRnVlQ1pkUjNiejFTMHRFUVFmNGdUdFBK?=
 =?utf-8?B?K0t1aG1VN3RqdkdpNlJtUlRYUis2cnFrQjNkZ1VraVYvYnFyUE5zZEFjWE9a?=
 =?utf-8?B?eTBCZSs5WDdyMldqeUlYeFErL1ljVXZaNEFQc1hrMGpXV01PNXY3N0t5ZTcz?=
 =?utf-8?B?Nk1jZnlGM2VBSFBhMFh3STh1TTV6ZUgyZkp2eUExME5Hd3BGd0h0N3ExK0Jl?=
 =?utf-8?B?bzBENGkzSkUvdnZXNE1LUlJiWkx0UjdSaVVJQkg3aGtXZm0rbzlxZTJTVG9X?=
 =?utf-8?B?S21KY1R1WWdBdmx6K1dhdnZaeUl2aFA5bG4xOG0wc3lSYVBpNEs0UEN4aU53?=
 =?utf-8?B?NzdDZU9BSTM0ck1yTHVqV2lRK1RMSHB6UC9mVllVVTlsWEt2UGNVR2paenJT?=
 =?utf-8?B?OWlpRkhNNnJuMG9LaHlhN2NpUXBLOTVWdHBlWDA3Y25FR0k4dTF2Nm1MQnJ0?=
 =?utf-8?B?YUMxaHNXUjdKRlNTZWU1alRXN01ta0dTZk9wWkg2U3ZVRWErN1c1Wlh5NUNs?=
 =?utf-8?B?QnZLSnR2R3pYRUdOL1BoUjF1Y2VIczdQcFVIVUhKQWVRd2RhTGVCR2NCN0h3?=
 =?utf-8?B?YVF1VFh0MmQrWGtqbGt0NTZyTUgrclFxYkhtdnZERUw2dE0yTEhPRGlxRTl5?=
 =?utf-8?B?YXpIZS9kcytTUDROZHl3Z056YkJXQmZ0MFVXcU0vdXBWd1cwUk5JM1l3K0tl?=
 =?utf-8?B?amsrM0pHV055OGNabkRzekZmOUk1MnR0YkU2R2JvbTRpNFBwQURyVFBmekhR?=
 =?utf-8?B?Tjdvd2htOCtkdXpkcGVpdks1MEVpL3ZEVGNhSVhmQzNGb3JIYWNQZWJmMU92?=
 =?utf-8?B?MUkvOUdtMHdOcGdEV0lRYTdVSmVXWE1sOW5PRWtqWCtkMW1QaFRPdUZRbU83?=
 =?utf-8?B?RmVPL2wvZFM1K25KaHRtbHBPYWY5SDJZeVhPZkdGLzQrZFE2RWM2VDhxeE94?=
 =?utf-8?B?ZE5CM1NCTkV2U295MUN0T1h1eWpWSUkycVNKdFZxU1NEaEJlbFJROHFUb2Mw?=
 =?utf-8?B?a094ZENaZEFZSldvS0JEamppOGhFYVgzS3JzdVFNSU44eEhRVzQ5TERBdjZt?=
 =?utf-8?B?cFdLanZIcG9RRC8yS2tOTjBTN2djRm5sVmZsb0JmRzhlR3pjY0xZUlRPVHU4?=
 =?utf-8?B?Y0YxREJxNXBIb2NEcllGS2ZPR0pyUXM1U2NOOCtKZnpxdk5MaXZPRnREQS9p?=
 =?utf-8?B?bFVxRzNCTUMzRVNOdFhtR2c3aFYwNXBaZVkxb2p4UTZ6Zmtud2k0Q0lUWjJo?=
 =?utf-8?B?U05Ra2sxV05LZkFCZGdrZm56dkVDV0dlbHVIS2ZwTkdSMFhnZG41Y2t3M0VQ?=
 =?utf-8?B?YWZPVkpIMFp5M25FbnVYVEdEaUNnWDFEeGlnUml0Q0hnRUVBb1JFSjlkUVVa?=
 =?utf-8?B?UmRNemRSbFFBaTlGNUc4MDFJZTA2bThkRUtPWDBJbkhJTE1sSDFQdXhrNU1U?=
 =?utf-8?B?NzNTMENWZlVqZFA4RjU0MERJN2V4MkJ6NXNLS2ZmcFFlUHJxYUgzamhZaFln?=
 =?utf-8?B?RUVUZHQ5MWZuQjdyc1FQanVNRGdXYWZ2bmtIY0UyTk9KRVcvZWVkK2lxZU1R?=
 =?utf-8?B?YXJmR0o5UjI1aXU5N09hZ09PUGxHeE9qSkJ5dDJiOFlONkpKYTRoUVZxVWhD?=
 =?utf-8?Q?9i0TxQVDGyBCxIdh+dHrwRVvJtJvQQrcEcXnM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dzNiSXcydFNsYTgrV1ltUVJDUGdvWnZIVU9pSDdHY2ZTZWw1Um9qdEZnK2J2?=
 =?utf-8?B?c0dRaU45d1FCbWtlajduZlZrSDFJZUY5dmE5NThuNGFtbHVKYnkzM2l5WG5Z?=
 =?utf-8?B?RkhQc3Y1YTRBWTRhUk0vNm9nVE94ZXdWTUhNR1RPQ3ZoL3dudndteVUwZVZD?=
 =?utf-8?B?SVB4Z0tORjhESjZSUStndm81UitydUpNR0RseFhhWmlIU0h6bHhNMHVIMENZ?=
 =?utf-8?B?cDN6d2FmOVpwZmM1dHhBa25MelV4RWNvNCtnOUZGb3NVQmRmTnV3aUFGclBi?=
 =?utf-8?B?REw4WE5aaGIraXFtR0p2N2JrZ2FvQVlzeDVaSFBuT0thTm1MVWh2NFh1VzRU?=
 =?utf-8?B?aEpxdS9kNzdQVTU3Y29xbjRlZkdkNytUOUpuREUrSXRzYTAvM1habC9aV1pY?=
 =?utf-8?B?RlJZZnlMd294QXNPT0pUcUZMT2U5cVlKSEEzYlZCUmpkZmJCZWk2NklPbHZ3?=
 =?utf-8?B?T0duUDd6bjh5ZGV5bHNoNDJMaFBMNUs0NjNjZi85RjRYTjY2c3ZBd0RtQkJS?=
 =?utf-8?B?Mk5KcEh0SW56U1FWeWo1R0pDU2ttR2gxVStFcFBDd21YWHB3SVVyeS83QkRS?=
 =?utf-8?B?bkVja25uaTQrdDRXdlJyNGxYMEIvaHphdzZxanBzdU5Kb2pYa1Q0WU1ib054?=
 =?utf-8?B?dDhiNXgvZkcrY1BlaWQrbDRuUkkyVkhObG5oblBNcTZMNnJHZGRVUWFWUnpW?=
 =?utf-8?B?RXo4bmFaeEc4MkVoejgzNVQ1OTYwN2M5SmlTa1ZyWWdidlV3dEsvNnlJMisy?=
 =?utf-8?B?RWxjRzM5MkVjQ0lxMTRGd09Sc3BOaXRJS2NQaGx2dzVDMnJtZ3VoNG0wNXkx?=
 =?utf-8?B?Mmt6Ym01RlFDL2EzaDZGY2I4cUlGdzVJWTBTTk9hUEc4a0ZUbHFuNnNNR092?=
 =?utf-8?B?aXR2NmJvbE1RZEFqMUVtRGE1STBpWVZLQ1FVUHp3Z0VrTDVYQnNJa3A3RjZU?=
 =?utf-8?B?RktCWW54ejlNSXJSU0VLbSt2YjFVM3E1dkY5aFFLQ2h6NHBJVzkzV0ZRczBW?=
 =?utf-8?B?dG5TTzZjWjhQVEZEQllWWWR4RXR3VTNYK1FZbUNGVDBqaTBxMHAzZ3dSR1NY?=
 =?utf-8?B?MGxZMkRYZ1djakVJanVScG9xNTMxUktxQmhpeWdEc1diblJ3WlNLRmM5Zlox?=
 =?utf-8?B?RGMrSE1kdTJTTTdHZyt4bUlYVzVubmhYUmpCUThCc2hQK2lTaVF4N2tjdXE1?=
 =?utf-8?B?UGY1SHJRNnpBR2tJeGxkdTN1blBGZHFFOGdhY0YvRk91czU5Y01CNXVhQXBx?=
 =?utf-8?B?ZjcyaUVLZWZVbzRvbzUydzdHTUxVTWVOVHgrcEg3MVQvR2M5b3FSdzVhSExB?=
 =?utf-8?B?bWMzTGVDL0tWaVgxbkxWSmtHWnV5aUkxaEpzeXBpWjBUL2hPVVd6UDEzK2Vj?=
 =?utf-8?B?OWwrU05JRUdWcnphTjNPWkRyVlFxVHBDbXdEWXdHV2hYV2NXOEpKMVRDa0VW?=
 =?utf-8?B?M1ZHeitxLzZqZitWeU9OZjVRZis4T0trd0d1MlVGYjVkZldYdmR3bFpKL0k4?=
 =?utf-8?B?eG0vNTNRWXQxaE4zVkZzM0dWd1BQQmNkVFNCN3R6R1ltTkxSMCtTOHlmQmFT?=
 =?utf-8?B?VERuVjh3UVlNVWZjeGd1L0NRb2tBRTkyY29HTDZTODFyOXExSXk4R1pkekFh?=
 =?utf-8?B?Z2hoanZZQ0dISFo2VkZwbURMelZBcnZBaFRlc1dtWWhBZ2tTYVM3Z1BtSjdE?=
 =?utf-8?B?WHpHNVZjeXRnMDFhMzhOcUEzY0o4b1EwTzhEajBDUklEU2YxZkRGTkIzZ1VN?=
 =?utf-8?B?WFRaaWxhcHN5dUErNHpxbXdSYmZYQjJBdzEyN20rVHZhRHN3OStnaHVpRWQy?=
 =?utf-8?B?SmVQcFFVT1ZHd0J4SzNLKzhrZTk1UUxnTURsTndBbTVBVUpTSUdPcGhLZHpD?=
 =?utf-8?B?MVA1TEtmMkkzMGMvSG5lZmk5VENzNTVlMzVZZU5RaGg5eVBjM1ZSVVhXZkpl?=
 =?utf-8?B?blFrSDJrUWZpVFozQ2VSWHRVOWV0RWtJSVpQTzA3eVJUV25zQWRqb1lISHNq?=
 =?utf-8?B?aGVpSng1enluU3Z4dTJvaGVLbldxakExdGxTUWJuVFdQdEw1OHkrc3JJd3Nl?=
 =?utf-8?B?NmxhV2tuRjE4UHpHcmxMRGZsaCt0cWZkNTFhZzgxcGx0M1labWtEZUE0bTJo?=
 =?utf-8?B?SVNqVkJ2L3pvcVdicysxdlVxa0t3TE0rVWdLWXRmaEV6N1htaFJHTlhQOHh5?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <444CD066F4425A48A025861C7C996149@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ChbT8jpn+VyQnCqsOrZkIlJChcs8qMn2qGvkNKlK9tjgWZoZIh5dE/CGpNBuKQ54//N6T3aNQH0THsgpv6+ksuQTe6xjc3GIwl+3B/piqpuT4CT2JWydb1arLsL4bikVsaBe7Ty53ESdzIikE5RTZkzsjR63IRJMhGJkJEZZV2wnUcHnxer5hBckQic75QvL4n4VPgjgEZ0eLdAQ9YUG1iLEZxXvcErFwXAZ088fG0SdP1JR7StSdjN9SGWrZShZ3Ik20h8I8i0S9TppEe444O2nLQDu5sbZUNGQ6W6YaPOhQncbRTy5yfSFicfJhzkLaV8IE0Bn3wB822SdhAMKc8+SF7MJLcDmUAOurr0t7c3fTF2GkP9xm4GmCplnR9W7bAKu3jtYKrR8cxatlvHL7i+jLeSsbERMwDC+d4PDPYOQIDGT/f29xEmGXmnhwa6urxJwAAR7TwwwVFl8A83vLpVIU3Ghtjvi3dqBvRjwKDX3lbGOaRqQFvXAz92ZNCOF4pXaOeg8v14NyYbTWBF4omQPCOQxvV6ehoP54zzdFhfeImRt6Gy2m4OEFaNDkYpqvUn/gmSasAD9EsOgNFusCkH4PmosgK5gZm3cNov8I84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baf5949-be86-4c5c-2c1c-08dc9133e469
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 14:18:44.0618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IonnKKH7NPIvxmbZT9CRScUbnxOa4gebXObvBWAuzPO/74J9wSLgeWdmBHyaQB/kNRCjS4QGQX4/tFg5bIyzLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=633 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406200102
X-Proofpoint-ORIG-GUID: GVTNdpAEiDLMaC4D9VG4YC0ugBCsHZNR
X-Proofpoint-GUID: GVTNdpAEiDLMaC4D9VG4YC0ugBCsHZNR

DQoNCj4gT24gSnVuIDIwLCAyMDI0LCBhdCAxMDoxNeKAr0FNLCBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGxzdC5kZT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEp1biAyMCwgMjAyNCBhdCAwOTo1Mjo1
OUFNIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdyb3RlOg0KPj4gT24gMjAgSnVuIDIwMjQs
IGF0IDE6MDYsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4gDQo+Pj4gT24gV2VkLCBKdW4g
MTksIDIwMjQgYXQgMDE6Mzk6MzNQTSAtMDQwMCwgY2VsQGtlcm5lbC5vcmcgd3JvdGU6DQo+Pj4+
IC0gaWYgKHRlc3RfYml0KE5GU19ERVZJQ0VJRF9VTkFWQUlMQUJMRSwgJm5vZGUtPmZsYWdzKSA9
PSAwKQ0KPj4+PiArIGlmICh0ZXN0X2JpdChORlNfREVWSUNFSURfVU5BVkFJTEFCTEUsICZub2Rl
LT5mbGFncykgPT0gMCkgew0KPj4+IA0KPj4+IEl0IG1pZ2h0IGJlIHdvcnRoIHRvIGludmVydCB0
aGlzIGFuZCBrZWVwIHRoZSB1bmF2YWlsYWJsZSBoYW5kbGluZyBpbg0KPj4+IHRoZSBicmFuY2gg
YXMgdGhhdCdzIHRoZSBleGNlcHRpb25hbCBjYXNlLiAgIFRoYXQgY29kZSBpcyBhbHNvIHdvZWZ1
bGx5DQo+Pj4gdW5kZXItZG9jdW1lbnRlZCBhbmQgY291bGQgaGF2ZSByZWFsbHkgdXNlZCBhIGNv
bW1lbnQuDQo+PiANCj4+IFRoZSB0cmFuc2llbnQgZGV2aWNlIGhhbmRsaW5nIGluIGdlbmVyYWws
IG9yIGp1c3QgdGhpcyBiaXQgb2YgaXQ/DQo+IA0KPiBCYXNpY2FsbHkgdGhlIGNvZGUgYmVoaW5k
IHRoaXMgTkZTX0RFVklDRUlEX1VOQVZBSUxBQkxFIGNoZWNrIGhlcmUuDQo+IA0KPj4+PiArIGlm
IChkLT5wcl9yZWcpDQo+Pj4+ICsgaWYgKGQtPnByX3JlZyhkKSA8IDApDQo+Pj4+ICsgZ290byBv
dXRfcHV0Ow0KPj4+IA0KPj4+IEVtcHR5IGxpbmUgYWZ0ZXIgdmFyaWFibGUgZGVjbGFyYXRpb25z
LiAgQWxzbyBpcyB0aGVyZSBhbnl0aGluZyB0aGF0DQo+Pj4gc3luY2hyb25pemVzIHRoZSBsb29r
dXBzIGhlcmUgc28gdGhhdCB3ZSBkb24ndCBkbyBtdWx0aXBsZSByZWdpc3RyYXRpb25zDQo+Pj4g
aW4gcGFyYWxsZWw/DQo+PiANCj4+IEkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMuICBEbyB3ZSBnZXQg
YW4gZXJyb3IgaWYgd2UgcmVnaXN0ZXIgdHdpY2U/DQo+IA0KPiBZZXMuICBUaGF0J3MgdGhlIGJh
c2ljYWxseSB0aGUgc2FtZSBjb25kaXRpb24gYXMgdGhlIG9uZSB0aGF0IG1hZGUNCj4gQ2h1Y2sg
Y3JlYXRlIHRoaXMgc2VyaWVzLg0KDQpObywgdGhlIHByb2JsZW0gSSBzYXcgd2FzIHRoYXQgdGhl
IGRldmljZSB3YXMgdW5yZWdpc3RlcmVkIGVhcmx5LA0KYW5kIHRoYXQgcmVzdWx0ZWQgaW4gSS9P
IGVycm9ycyBhbmQgZmFsbGluZyBiYWNrIHRvIHRoZSBNRFMuDQoNCnByX3JlZ2lzdGVyKCkgZG9l
c24ndCBmYWlsIGlmIHRoZSBkZXZpY2UgaXMgYWxyZWFkeSByZWdpc3RlcmVkDQooYXQgbGVhc3Qg
d2hlbiB0aGUga2V5IGlzIHRoZSBzYW1lKS4NCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

