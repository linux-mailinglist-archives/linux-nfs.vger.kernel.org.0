Return-Path: <linux-nfs+bounces-10573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B95AA5E7A2
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 23:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB833B8B29
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 22:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA861D61A3;
	Wed, 12 Mar 2025 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="KgozXxC1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2114.outbound.protection.outlook.com [40.107.92.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035F282F1
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741819702; cv=fail; b=Z0pm1ptQmZKsVn5mLTmgMZh1nipazBKV8oIkjHx0nuZsHaMOgR6sP90JOK2itQFHGVw0GNnm02ZNZKu3PpRF2tj4LJeU9UwmBJDtyKzpNTMutL2iPjbFPOLao/JGicjw+TnlCJ8FyaYSzwcIPP0Qza+wRjebgncM/QBFoD2DgXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741819702; c=relaxed/simple;
	bh=xbmnGUex5Mu+ZcyUdi2UB5QJRRn2HBBEmkDht4qYx78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sBSLqa+aUveUEbI+29DimWJkzAzWwTL/hhLRmdfOkLSA00BuEI5L8IuZxWXBemkcfyjOmfzxVOuJQ3kGvQp3lbbJSSCZq2gz9LuLFeB7L1r+InFZQKlWdfmE0f7ncYMNioIlM3k3d4FBydHGe22IwKvAZI6YfS35+p24cEQl8m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=KgozXxC1; arc=fail smtp.client-ip=40.107.92.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRof036swG4UsRR+rD1oz41Ta91/M1FxlWvcFtyaoRihdko0kgz46e4+uIVlFjOPALFPszaOj47fY0G86i21nwcSo6UGsWrAoim3hxnjjGkNqWnd71ROcnAnC1NH/bU5FXyz6pganeGF6TKk6qB2gO7qEXFxNBwuNDRUeriyZqNcOa2cy1B3UMlTdxX+gcZIcmrcJwQ+LB77g2pwWwLGFKSqKIN+yV7mu9h+kNCVssqEuXu/Ta7V2v4hWumAbA6O5Fj5K6tOvP0pcqwHOtA5btm9P1EJFD9dnQCb1PlhezDn4PM9mXutXka6jCPj98qVNEwi2Mt4tOXWr0o6JB7diA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbmnGUex5Mu+ZcyUdi2UB5QJRRn2HBBEmkDht4qYx78=;
 b=eK8sPmhpHfdqoXwijhR4pkJ0doeRQwTHLmoe3x4PU2ia8sS4hgpvK/aufyb16SNKFkrd5Wu0iEOKc5UAnyM6gFsTOzSxx0VFeNeDubCjv/BATokZ1UQkKB+qUG2d2kg7nDG2eeXbL8XbhY+CsOhZxPSH97YV7Ro3EFAUmRF0pgnJmBgpdrXpWqIawRFZx4impbj+vPOW4918IUa8jiR+aIenjSbJz/vUdncIkuu6cBvc192x6MBy9Bk7GJb6x4mtDlUOt9Z7YnyaJrI6d9gDK+Ouucx6DBh5JMMGS6c/d5xkjZ7rNbYR48DngXhTfHB0dwMAsu9SZ4ZCZ4+LzqZrRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbmnGUex5Mu+ZcyUdi2UB5QJRRn2HBBEmkDht4qYx78=;
 b=KgozXxC1vrfhy+pCPPkiD3F+E2axgKw0ngmopzGauLYViCI/CiZLV/fRQ0LQr5GggP3ElRMtlU26g96uosj8N5eonHNDU/Jb9eoDMDCPfMvEsgfb07mlYTGgOQK45y+Nvw/5N71I6roT/nduBZfDc+3DANPTZ9TDaPxsJNr3PAQ=
Received: from BL3PR13MB5073.namprd13.prod.outlook.com (2603:10b6:208:33c::7)
 by SA6PR13MB6828.namprd13.prod.outlook.com (2603:10b6:806:41f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 22:48:17 +0000
Received: from BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::b148:fe5d:ff6a:6310]) by BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::b148:fe5d:ff6a:6310%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:48:17 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "bcodding@redhat.com"
	<bcodding@redhat.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFS: New mount option force_rdirplus
Thread-Topic: [PATCH 1/1] NFS: New mount option force_rdirplus
Thread-Index: AQHbk4d0DIHEOdRfXkyblppsFp2iiLNwGqAA
Date: Wed, 12 Mar 2025 22:48:17 +0000
Message-ID: <ef4218cd2eb30558692857d02ea1518e1e06684f.camel@hammerspace.com>
References: <cover.1741806879.git.bcodding@redhat.com>
	 <4a471ab1bdea1052f45d894c967d0a6b6e38d4a6.1741806879.git.bcodding@redhat.com>
In-Reply-To:
 <4a471ab1bdea1052f45d894c967d0a6b6e38d4a6.1741806879.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR13MB5073:EE_|SA6PR13MB6828:EE_
x-ms-office365-filtering-correlation-id: 953b1fcf-e5ba-46ad-2e2d-08dd61b7fafc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjR1TjJkRFhadkRBL0Q1eVM1Y0ZwbUdlQ0JQZkxzRmhaZHJVbmxxRS80cTF2?=
 =?utf-8?B?dmJhNUpFTVByWTBoWkROUTJSNUZaOFcvK2JjNjlqRGFZVlVFRnNNa3VzS1A1?=
 =?utf-8?B?UGVWM2tvSHBwNUplQlNvYzJFb3RnWUZncHFlM1JJMVB6eXR2dGxqN0IwY3Vu?=
 =?utf-8?B?UEs3V1Z3Q0JTWWk2cjVCNERtZjF5Q2xOdUg0MTJuQXRwOXIrU2pHd2tEZW1q?=
 =?utf-8?B?VWw5U0lNbmkycjRLcEZnSDh6S3NicDFGRU44dGRWK2lRY0EvdnFpWmVKZlhh?=
 =?utf-8?B?ODRXR2ZmQzJOQ1YwZy93R2VSMjRRZkJqU0lHTzdtZE9YTVFlM0lmVWpkZ0JM?=
 =?utf-8?B?ZEt3TWNPTHp5NUNvQlBtYnRUb0ZWQXIrWk1Pc3JNNGIzNld1Mm55SVFkOUpl?=
 =?utf-8?B?L1NNNmsxMXoxckVNZklFY2R1cnp1K1BsUkpzUUFtdkZBV1VFeEtDOTR2WFBJ?=
 =?utf-8?B?L0R4TzI4ZExDand3M1ptVkRlM0cxQXo0TWt3Vlc5OHhacWhXcHFiYlBKcjc5?=
 =?utf-8?B?YUVHUWMra01iM3JPT21yYTN0L01yUmxnOThiTUY3cGwwNWxTSW56aVQwYmhS?=
 =?utf-8?B?RzgzNnJVNi8zRVBFTHNuV0dVVlFXekF2ZEJGUnF1L0dmblN0M1JlZ2RERnFn?=
 =?utf-8?B?dFZrRlRPOW9ROHhzZzJJUnNTM1hDQUtBelJXMUFVdkZ6bGFNMEsvL1JNS0FM?=
 =?utf-8?B?NWpaaUVTZjh2R210c1NxNUl5Sk43ckIzeXh5NXRaRWJQK2ZEQUs2Ukc3MEpl?=
 =?utf-8?B?djdsWHY1SkpCV2xmZHZSb21xWGJZR0h6VWQ1U2d5cWJLNzF6K2ZWbjVqa0hD?=
 =?utf-8?B?TE1DVitzWktGWG1BMXQwUFBuSUxtSnA0R1FkUDA5TXJFYkxKbS9kQ05sNjZD?=
 =?utf-8?B?b2VXVmtZUUpoQXhBaHJvMlVxY2lGU0tsOHBZNGw5bnlDMjBNeUtZSVdIdFRy?=
 =?utf-8?B?UlhmVmtIODBoY2xpZWwyZU9ubENQWG1yV1RzcENtL01hOU8yQ2xXVzNXNjFo?=
 =?utf-8?B?Q3dqZTg1c3lXY015cm9tTGJRRE9PMEl6QnRFTHdkL2VMSkFacXBvOUk0YUxI?=
 =?utf-8?B?R2t2U1FEa3lzS3NOVFFXYVVtVGM4Wk9ORnB0MW9tRXo5OWpZNWZqSTNBcjB0?=
 =?utf-8?B?aVRLY3liRTBZa2Fla1VuWjJvYnNTbFVmSFB6UlFrYWdEb0hCVEh6ZGJwSmtY?=
 =?utf-8?B?RVVmZnJUeDRacUY2SUxEUHlDRzlpclI2bGZ6ZE03UTNVbUp2YWhTN2VVZTBE?=
 =?utf-8?B?QVpRTGhxK1k2OUJkSUdmN2hNRTN6Smo2VG5uaEU5QnREbDJlYWpic04veTI4?=
 =?utf-8?B?TStaano2UUJmdGZKNnpRYjM2ZXcvZ0w2bHBGZGIzMUhPTlpLOC9JK2Y1M3Nw?=
 =?utf-8?B?UkgyTGxqVk93OU9uVld4aytKbnhzaFVneVluYmR6UkttYXdTVnMyQnB3aUN2?=
 =?utf-8?B?NGFsZFdVdEdUTDVLMzlFTE14SC9VUlIwb3BQdVNMWCt0NkFJN1BLdXl2WS9H?=
 =?utf-8?B?NFBSbVdMKzhGbjZsUW4rOHN0NXVvd2hEQ2dlU1ROeXhHUmtTOGYwL0NlTVJt?=
 =?utf-8?B?WFRoeDJYb3ZUREJxcjlhSnFhRUdVaFdRQmN0NWRTV25oa3JqeFF0TUVBTGdq?=
 =?utf-8?B?MjBRVi9vSWFqam0zSGNpbEt6NExIbEZkeE1ORVRrNlBVSzJEeVg4aUNpREVy?=
 =?utf-8?B?dTQ0WGxRQjZuR25sN2lKdzVwNk5JenBKNExHS1ZXbkE3NVJwOG1xRExkcjJX?=
 =?utf-8?B?Sy9GQUVoUjRMbFFld09WWTh6WWs4R2R1RVBob21XQnZiUEx5cXVRK0xpN0N1?=
 =?utf-8?B?ZmVPbkpmejYvN3NtWFF6RHZ5TkYxQmNJYkhsTzF2bEhjaW9HSVNjQjBtNFNU?=
 =?utf-8?B?bGtZdVN3QVRpVFFuYUJqY3l4ZkkrV0VLOUZaK0ZXdkhqY2NMWld2VU1WcU1E?=
 =?utf-8?Q?BcSl5EwxxgBVyrwhtXf7ct6Dao+d6yaD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR13MB5073.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUIrd25ZTE12YUNJamJJMjM5ZitzTUM0VDU5TzVIYlJUNGVuWkNPeXNLSWRS?=
 =?utf-8?B?dnd0K1FFSGVqMDRDeVRvYlZLNUVpYlRyZkpzaERRWmVpZzZsYVBIbkkrdERk?=
 =?utf-8?B?dTlENHRxa1ZkUUc1MjY3cDJna3lJNFFXZTlUTmdGZWRpQ1Z1ODRHQXMzbmVn?=
 =?utf-8?B?cncvNlhiYUQ0cnJIeVlKSVltdGFRM0Jpc0Nrd3pYWXBuV0ZLRU9yaS9iWFJE?=
 =?utf-8?B?NDVSdkUvUWt5NlRrUFc1emJCUzZFeVpkamJnMWJ3MHBkTXpnZjFVTkJ6bkkw?=
 =?utf-8?B?R3Y3NUhTZUJhYTh4bFlFb0tjcU1lSGMwbGdzMXdET1dWRHEyMzZPY1NoZ092?=
 =?utf-8?B?ZTA4M216MGJIdlJIS1hlNVY2M2txTE9RYmF0R2FxUmlzVkR2RUxkZGwrZ2tp?=
 =?utf-8?B?L3JLclJranhZcEpvd3g5SkNtZFRWZ2xtZ3ZVcnE2bUQvVW8zZmNOOGt2Yk5E?=
 =?utf-8?B?d0JCRjNlZ0N3TkhOYXJjMURyYjE2bklaZ3Y2RVRib2RCRGdHMEI2MTc2ZmFP?=
 =?utf-8?B?OXJpZjk4MEtoVXFudzlReGF6dzN4ZjNWMjRCREhLU3lGdjJkUXp4SlpxeUVV?=
 =?utf-8?B?blhzWU9TaTB1QWV2bTFPb2JpYXdOUWhsc0YxN20wdVF2RDVnTU1LSTJSbjl0?=
 =?utf-8?B?bEN1TDNiNTdSVzQyQnRaUVpIN1hKOXMraU9WM1VJb0NTby9ONUNRbm0vdmxv?=
 =?utf-8?B?V3FHV2Y1S0JlcnJQbzVheEFpcnk3YkN1QU15Snptb0hZUG9hSkk0Qy91cE5y?=
 =?utf-8?B?K1dGcXJtbjd2WXljOFRDREwrRVE4Y0ttT3JiTExsekNSSGpyd3F4aEVPUUwz?=
 =?utf-8?B?Zzlsa1JseHpDdnp6cUZPclpjOU5SWmpYK3UyaHV2aStuTzNYNWU4V1R5MTdo?=
 =?utf-8?B?SXlaeHF5ZU8raHQ3ZWpielR5R3RSdSthamxYZlBBODVLdVA3RmhtQlg0SERh?=
 =?utf-8?B?KzMyRHVNSHcxNnJITEc3NDVVZHgwNXQ2SmVLTzV1SCtRRVlNL3FPaXBzaWZO?=
 =?utf-8?B?cmp1cU0wUGFhTk0zcFVEYW1hME1TejVWc01QdGhPMXlqZ2owNWxZeHdNM08r?=
 =?utf-8?B?OVYyUHhFV2lSMGYybzBiM3JGMXFGUlFtM2FZR2lTc1RYWE5rdzNRczMwL3Va?=
 =?utf-8?B?V3ozeDVtcmw2QWRrck5BM0tEV2pyRXdYeEtwWXZSbkVVWXNNTnR6cHNUZUtE?=
 =?utf-8?B?Z0Z6ZXo4bmpPNkVjM0pHeVFIMDVCanNDWjFoaEJ1S3ByZ0dhYzRETHJ3TmFE?=
 =?utf-8?B?WlNXUmI4c3gxWUtVTHdPTURuS3h0WlgyL3RGNmNtdjZRVmNmUlN2eHdkVjNl?=
 =?utf-8?B?Q3ZrOFkzU0p0bTZtdFV0OHlYemQ0bGcycmRmSmM2RlFPQTBSVDZTclk5aE9m?=
 =?utf-8?B?ck9aMFF6YVZmYmUwRE1qNEdDMDFFb2FGU1NoU3JlVmVlTUM2ZktiZnAvMzZO?=
 =?utf-8?B?SHBoNDVBVWtsTjFWTkhYRDB0TDZNZ1NRbThTNUdvT3NWYlNtQWQwcnh2L1B2?=
 =?utf-8?B?NWVvZmVhbDlSS1NHOGxyR3hUaUthdHZjSW9xNXIyNUI3eXpkTFlRSnEwZmRJ?=
 =?utf-8?B?Qnl0ckZHOHQwMFliWG14ZzIwbG1qMmNTd2FySnhPY0pEYXBzV1ZFaGo5dS9E?=
 =?utf-8?B?eDY3OWZ5aXp6T3V2QXZublVBV1dHaW1JQVNmMUo4RkFycCtwbnRPdytWcU91?=
 =?utf-8?B?Uk9YQUl6b3VIeWhWS3Q2VWI2MGlPRmVXRDhsNWNyTW52bTBmU1h1WGIySXNY?=
 =?utf-8?B?WS8xWldtNGNaeUswbGhGbXF3eHRCT2dzNkhvbmluVzNDVll5VFRKZjk4d3li?=
 =?utf-8?B?UDVYeU9pamc1d1lnaW94anEyR1p0bEkybTNBVVBiemdyblhxeXcrWWc3b29v?=
 =?utf-8?B?bUdwTFU3TTRyYUdRKyt4a3hXZHVXYW40eUJtR1k3d1JjbXQzaVM2ZGZSNkZ1?=
 =?utf-8?B?V2t0K3BtOEhnWEhpNDVKeTFPOEQ5OEFQNyt0c2toOEl6SkhDb1l1b1J5ZVpX?=
 =?utf-8?B?eWJ3dHI4QWhSYXgycld3aTVwNHB3VXlYMUkxNWl5eHZqNStnN0dPQzM3WTZ3?=
 =?utf-8?B?T0pneldKbjVEalNJN3ZHTjJ0MURYZFFML0ZsQTdmOURYSFZDTE1jRUk0Z0hZ?=
 =?utf-8?B?UExGSlZVeDVlMUpid09NeEFYMGNNQ1ZnL3UvTFloTlgrNXNRbW9LY1RrT0ts?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0387EE5C4F12344193916AF88EF19623@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR13MB5073.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953b1fcf-e5ba-46ad-2e2d-08dd61b7fafc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 22:48:17.3987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nqHR+7BdKr5GyVMl/vr+5gtAjBx6VOTl6Xk/0fkGOkwYU0e9niG9+V/aCcoiSFTFkqX80mXpLiBJYQNyXiyRTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB6828

T24gV2VkLCAyMDI1LTAzLTEyIGF0IDE1OjQ2IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBUaGVyZSBhcmUgY2VydGFpbiB1c2VycyB0aGF0IHdpc2ggdG8gZm9yY2UgdGhlIE5G
UyBjbGllbnQgdG8gY2hvb3NlDQo+IFJFQURESVJQTFVTIG92ZXIgUkVBRERJUiBmb3IgYSBwYXJ0
aWN1bGFyIG1vdW50LsKgIEFkZCBhIG5ldyBrZXJuZWwNCj4gbW91bnQNCj4gb3B0aW9uICJmb3Jj
ZV9yZGlycGx1cyIgdG8gY2FycnkgdGhhdCBpbnRlbnQuDQoNCkNvdWxkIHdlIHBlcmhhcHMgY29u
dmVydCByZGlycGx1cyB0byBiZSBhIHN0cmluZyB3aXRoIGFuIG9wdGlvbmFsDQpwYXlsb2FkPyBE
b2VzIHRoZSAiZnNfcGFyYW1fY2FuX2JlX2VtcHR5IiBmbGFnIGFsbG93IHlvdSB0byBjb252ZXJ0
DQpyZGlycGx1cyBpbnRvIHNvbWV0aGluZyB0aGF0IGNhbiBiZWhhdmUgYXMgY3VycmVudGx5IGlm
IHlvdSBqdXN0DQpzcGVjaWZ5ICctb3JkaXJwbHVzJywgYnV0IHRoYXQgd291bGQgYWxsb3cgeW91
IHRvIHNwZWNpZnkgJy0NCm9yZGlycGx1cz1mb3JjZScgaWYgeW91IHdhbnRlZCB0byBhbHdheXMg
dXNlIHJlYWRkaXJwbHVzPw0KDQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBj
bGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20NCg0KDQo=

