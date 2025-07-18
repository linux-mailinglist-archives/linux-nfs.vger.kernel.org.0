Return-Path: <linux-nfs+bounces-13157-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B3FB0AC1E
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Jul 2025 00:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361C03A9F4E
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 22:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE1221FF2A;
	Fri, 18 Jul 2025 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ics.muni.cz header.i=@ics.muni.cz header.b="Ew06aTAR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021122.outbound.protection.outlook.com [52.101.70.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A88C17CA17
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752877149; cv=fail; b=A7e+RwvIDf+EGcLSz2q1hYGC/rfmIo/CGDg89PRlEBr8Dlt3i+6zM3DlFzXiwHMkDm+/Ty09qrpqWgG7FPav5ng14kQ2QsibJAubTT/SXlv7XI5TJ/hzoizSCF3LcJxuBFp8C/MROR0YMgJPPH/umocqEXoqCK1k73UJxOL1Hhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752877149; c=relaxed/simple;
	bh=G/tNt3Fm6yHhe6K7dYtlrg4AUYSxaNm6nFx0aR/okTs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JFI/Yw2lcV1F2fSc1wXIaLiUD0K9sYqfhDFRRQOpUgg9PQoV5aoaMLxeA9ddsfLiJ7Q0n1BYYqShJrG9psapBQGR9ugbWm+QabaArRLqhlq4dQYGaylRj6rneHfaxe3inJ6RnsF15+LndeTcmc3QQBBiJh3r8+y8AiH+kNtoeD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ics.muni.cz; spf=pass smtp.mailfrom=ics.muni.cz; dkim=pass (2048-bit key) header.d=ics.muni.cz header.i=@ics.muni.cz header.b=Ew06aTAR; arc=fail smtp.client-ip=52.101.70.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ics.muni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ics.muni.cz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d61xtQ/tzhTq5E23dFkZfMJWewUMQBos9U0oLlLHoDP7NcsFyLwQ7xHgnwlaz6hCg17s6DC2khNR7szkXxGvpbzcxriNXac9HXqI1TtXL7GoPVajqsnxQPCb0B+MGjKzRojgXGte23aSlDkQWJKEdrVphdKtq/yNZ190s3Cg3YACDHO89lpvxGvmcjlTwAm7haH4+jMbqnbn1IdPn0jivvzSkBErGV/FeQSg5RAuWxWUn4lTaTjuEi4gfqP72htyBrae7xdE6uRvpRTxHf7BVhVEOq3zZgFKGOEERCCJTE0d2dxU0bl8tFnIhRwIeXFnFH10c1ZmTJ/96aodJcUiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/tNt3Fm6yHhe6K7dYtlrg4AUYSxaNm6nFx0aR/okTs=;
 b=iobawa3eqG4rnRmsRY6jlK+tmDUea/tHqlsKVl8WPzmSxIrlDWQEZj9gKfL/UkAMvEyoUyC2TkD+Z4D+I2c2OCPOOcbyR9w55MatqJbgrAPCL3XPVHMbHCYs0sA5CldPBpCUMGDphJtIKZNljMW0VYIdI1D8vFcb7kTkKJgmxlS+A1Dhqhsaf0E/hAtFKK8wq9G510sj25h0V5jYGrq7VnMQWXpGkwXHav4+q5zJ0+iRM0rEDzFwHkG9CEpXhlxdBcAAHLT6yAoBMyjwjJr35l4dof0Scr0DaJFge3sOz4/eiNwlbB5hfW0W8NUOodf+3Y53oPDf/V2hnkTDBcYbpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ics.muni.cz; dmarc=pass action=none header.from=ics.muni.cz;
 dkim=pass header.d=ics.muni.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ics.muni.cz;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/tNt3Fm6yHhe6K7dYtlrg4AUYSxaNm6nFx0aR/okTs=;
 b=Ew06aTARrPQOFGp1RMIXHyZiHdX/YiID/GMylfLG5aClJ0lNn6l1pUwWPJbWl5Kg2iihpZgE8Mom0vvrzkCH2Rm9LxZByxr89PEVzEdHzgWe/t7R9ovd4j6YZh1HAHAO+RP5NkgHkcL6ZOeS+4CsMhVNqQG8Imcset5KGViTxnBYUJhSREyLbGZU8qUgALi3dr1ONcLOTl8wuEA7HAC06p/ax0eQEHI2sA68JCWWur4cz3CEtpcUaVr7YNesx5ZX8ovtDwtpceO4RRNXV9R79TX081tkKR2weLDEN6lpUEN4RccC+18pEx7Qs3UkHT4Bi/oDAhRQfKF1wnFAplekIg==
Received: from AS2PR03MB10156.eurprd03.prod.outlook.com (2603:10a6:20b:644::6)
 by PR3PR03MB6586.eurprd03.prod.outlook.com (2603:10a6:102:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.37; Fri, 18 Jul
 2025 22:19:01 +0000
Received: from AS2PR03MB10156.eurprd03.prod.outlook.com
 ([fe80::976c:f372:23d2:d79d]) by AS2PR03MB10156.eurprd03.prod.outlook.com
 ([fe80::976c:f372:23d2:d79d%7]) with mapi id 15.20.8901.033; Fri, 18 Jul 2025
 22:19:01 +0000
From: =?utf-8?B?THVrw6HFoSBIZWp0bcOhbmVr?= <xhejtman@ics.muni.cz>
To: Santosh Pradhan <santosh.pradhan@gmail.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"salvet@ics.muni.cz" <salvet@ics.muni.cz>
Subject: Re: NFS stuck in nfs_lookup_revalidate
Thread-Topic: NFS stuck in nfs_lookup_revalidate
Thread-Index: AQHb1H67kqkAOy3mbEyTEsZmDTFDwrPzVJMAgAALRoCARVsJAA==
Date: Fri, 18 Jul 2025 22:19:01 +0000
Message-ID: <59D374DB-14C8-42F5-956F-C030AF614C69@ics.muni.cz>
References: <18945D18-3EDB-4771-B019-0335CE671077@ics.muni.cz>
 <CAOuNp5kzbyVfbdumXJF3bb=RKxdE5P8aKJDeSoLtgEV9=9xU+g@mail.gmail.com>
 <aECaSYGt59HHgi7M@horn.ics.muni.cz>
In-Reply-To: <aECaSYGt59HHgi7M@horn.ics.muni.cz>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ics.muni.cz;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR03MB10156:EE_|PR3PR03MB6586:EE_
x-ms-office365-filtering-correlation-id: bf1fe01e-3f1b-4dbf-4754-08ddc649191d
x-muni-spam-whitelist-from: O365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eVFJUTNjK0pTdklFR0tPVm1BM2xGMDdMUXRUQ0RWdjVNWHdWb1hkU1lWVUEz?=
 =?utf-8?B?bGlBS3BLYjVsSlhheUdEc25KUGxOUWdKNnQ4c0VvTHBibXhGZU96SGFDQXZ3?=
 =?utf-8?B?aVRYK3ZQeHVTS3pZUnQzY2Y2MHZxZE1YUFhFbkwwRlg4WVpZSU15ZTIzY0JL?=
 =?utf-8?B?OG43dUQ2RFB0TUgxNTBIVVlTNmRoYWN1ZGV4KzkwcjB5VnJDbldsaXRvZzNJ?=
 =?utf-8?B?bzgwa2hmUitHSTI2MXQrVjRMdWo2eUhrMnRVdER1L1ZHMkNjdE5rYk9OVHky?=
 =?utf-8?B?NUc5aGFRZng0MkVSK2pZK1VmQWRXSUVTdG9lVjhZOTR3SWd0a0RDZ3dXaEhM?=
 =?utf-8?B?VWF5a2YrU0xnelRQYjZmOThaelEwNjVlUEh2NkkrckorRUl4L2RQSkR1em0z?=
 =?utf-8?B?WXQ5eEo0K3B5TVQrM3RGdWgxUi9wTzhSczF4V1hMWUFKTmFBWlBUdlFNYlcx?=
 =?utf-8?B?VGZ6bGpYWW4yaEEvaUVoSHVsam9FTnJFbkpTTFNscVNQOHk3NWlxZENrMDVL?=
 =?utf-8?B?NE5NbUcvRC9YMEVld0p6K0w3V1B6bWdCc2tnQ3YyRm5YQ3hGdnFBaGpPVE1a?=
 =?utf-8?B?alQybDB5Y3FuT0NPMEN3YkFzN202L0k3cUpHY3ZkT1BRMHRrVkM2ZmJLa2Vy?=
 =?utf-8?B?Nm5sVERFRWZyWXpOQzEyTmpScEFnZ1pXbE1sa2xIck5HYmNrQXVYbXhCUC9V?=
 =?utf-8?B?WlFsbXFabkF0cmx2MnlZWDQ3N0VZTjM2NVhDeUQ2L1FNbWlzdVA0OUZ6akl0?=
 =?utf-8?B?V0wzSit6bEp6UDNlN0YxYXc4cGIyNUlZSjV2U2JPM3NRTW1zSUROQ3FNTEFl?=
 =?utf-8?B?aEVpUWRTWng2TjZJaGdnZnpFVmdNbW5GN0xTaUhVZ2hZR1daS04ydXd0eDd1?=
 =?utf-8?B?bVdLS0gvMUNWYlNwQTgxKzl5RTg4THFTMjk5aVc1TlBieFFRZ1ZQa0p3MFVa?=
 =?utf-8?B?UEgvNWtYVnBobmxIeWV4cDZ6U0FEY254UEtLZmVFOWNRRG5meG5EajFJSlAw?=
 =?utf-8?B?WVZud3F6TW85bnlPWjl6bmNua1JsY2Q0QUN3WUlhZ3RiYVE3NlhBVUF2OWNl?=
 =?utf-8?B?bWM1d2picWJXMTlCcVVYYTBZZStGUjZlQnJjbzFuRDRGbndKdE9Jc0hQTTlH?=
 =?utf-8?B?c21UaUxqOTA1eW5OTGt6b1Vua3JxaFNodlA0b29waW8vQ2tZYWhVY2UrYTdU?=
 =?utf-8?B?a0dmSEpqVS9UdTl2L2RDWTVzcm9IRUJac1h1S3BNNUxoTVhDWGoyTGdQb1Y4?=
 =?utf-8?B?OUVtUHZ5VU5aNi9NdVVNZXpaalliRGpaMVNhbFh6V2pRTS9ndGh1OG1aWWJG?=
 =?utf-8?B?UWtab1pPRlg5WE5Xc0ViMGtnakI3WXpveFkxM2s3WDkwbVluU0tYZWtrcjlj?=
 =?utf-8?B?eEROWWY0dVMxTFVXaHVhNGlEMXJwVjVlYWhlUmZZbmdCdDlkbVZRWGdZREox?=
 =?utf-8?B?SHFRRkZNNERlUEEyMW8wb2ppaWxhcy9SRC9EeTBsUmNtVXRVbHVoZHNlc3hV?=
 =?utf-8?B?ejBLTHM0UDRZenF5UFYrREVJMnlQc0RrZzB2cnNxendKdnJMb0g2RUJoaVFR?=
 =?utf-8?B?ajExY1hTMUltcjhPTmtTa2gvWjNpZUdORThHSnQrZ280MWd3dFA2cXpXMzln?=
 =?utf-8?B?VlcxOXRKam1TaVVVRXdQVzd0czZ1cTBEemVWYTRDSk8ySFBJajcyS2tvWU8v?=
 =?utf-8?B?TC9XWWRkSm5jdU4vTUJ5Q3BBQmZFOVB5clFDeXJRVFIvSzlTWE1zYUxjcnI5?=
 =?utf-8?B?aEVaQXlkdkgydXNrd09sa1o3amUwdXpZdC9sdzNXNnE5dlp4VEhjb3BIc3E5?=
 =?utf-8?B?V1RnSkVSdXFIc3RFT2F1M2Q1MkJvNG5UK0FReko3c3M3UnhEbE5nL3F0OWRK?=
 =?utf-8?B?ZEtjM2NpcUFLRUhDN3g1YzB3RXRFSWNQSmI3b0hJWVY0cVd1Yk5aRGd5cGRv?=
 =?utf-8?B?Q2EyMG9BdUFQNzZEVk5vTnlSN1BxT0hJVHV3d0FKRzRnV1B4RnI0aE82aEpP?=
 =?utf-8?B?M3NucG1Ld21nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR03MB10156.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3E3czkwOXRPcWpEZ1AyQkNUSDZpaVZWU1FuekZsdytlS1o5MUwrNnl3WStM?=
 =?utf-8?B?aDNKK1pVWFdJZEo0VHV0MGZTbFovUHNVY2IrUTdVKzRsQUJZY1BBU3F4NWlq?=
 =?utf-8?B?TkppbHdmVlovZUpXL01FRWxrQjViam9SekEyd3BSSHdOTXlEQ3hoaXZsOG92?=
 =?utf-8?B?NlFkS1RoaWw2aUVzemZRc20xaUc3bzRNbWNScjZPSk5MSHdPZ2dmOU9obEV4?=
 =?utf-8?B?ZDBMSEsyQ1hncjlCTFprSGxtY2I2NWFEK3piWDUzSHN2TlFSQm8wQ2FkUStM?=
 =?utf-8?B?ODVSOXZwWUVYR0huZWk4TXc0RHFOZkJORmZnM0o5U2JyL0wzRzRraXpkWG5y?=
 =?utf-8?B?cFZJVVlTdXFBSFFXaVdQdVNVL3RYZ2ROTUcycXU4a2NNMlBXaWVOWEpoa3o0?=
 =?utf-8?B?YTVYM0hoVDdYdGUyMjc1MWM1ZitkM1ZqL1dGMmdxRktIRDBCOENQSndhM2VF?=
 =?utf-8?B?WlE1cG12OEl5OHJHT2RZa1hPdkZ6bm9kNk1hanFybmYyb2RVSC9Ka0lBQ2pl?=
 =?utf-8?B?K3ZmMlowSDJtL0x6UVhlYXNpbzZJUzgwZkFFOC80aFhuVURzMFdIM0NxK3lE?=
 =?utf-8?B?ZmtKTjlVV1AyblRubHMrWUpTR3pXcjlzZkxBekFCOE90OFoxZWY1UEdxRUta?=
 =?utf-8?B?TkozRkVWTnU5UjBHaUhoZDh2dmdDVGdDc1VyWUVTS2VSaVh4alBXcHQydERI?=
 =?utf-8?B?NW5yb0JWcE1SL3YwL3FyTDRhcnVSaTNvdWQ3QXJiK0NKd0pxcUhSeVhoMjlH?=
 =?utf-8?B?OFRFMWxQN1pXZFJRb1VMWGhkclBkOFdKMEM4WFdGSjQxOWxoVUJGdkZPNGdH?=
 =?utf-8?B?Q3ZRaEVXdkkraTdZZ0gxeHZsRVEyb2hEd1NFUnJRK0x2UEVkNmxGTlhnS1px?=
 =?utf-8?B?MU1PN2tFUVg0LzFkMDJPdGJsT3lWSXYxTTducmZnWlJYOHJZVks1dzRwT2hT?=
 =?utf-8?B?aFIxYkRiM3YraHJ3REJ1VzhOdU9YWUhBQkhUeEZCNW9GRGloYXdYVWR2YndJ?=
 =?utf-8?B?N0NTZGc5VXdqWUNua2gxREprLzBFNFR6b3B6SU9QcVpEVUZ1U3Y5c1p1akpS?=
 =?utf-8?B?QjBjNGd6SVZDc0ZrSGY4TEI4dEtOUXFRTDBaai8xcGNQb0UzeGpFQUREWklV?=
 =?utf-8?B?NkxqRDkxcDZhYm9lOUVlbnBadmpadS9xaUVXOW04bXVJcDBMNCtHQ296Rm1P?=
 =?utf-8?B?M1Ryb29DTEQ5ZytnL2xCV0FSN2kvWXdteHdnc1hlS0Z0bDF3emhtd3d0Q0V3?=
 =?utf-8?B?Qm5Vc1BkVXExcnM4ZFE5bUNzVDYrSFdrVCtROW5WYTVLZHo5Z3k1QXRxLzgw?=
 =?utf-8?B?VDNIOUl4Um5IYjFneFFpT01pL1M5d01hRzNPMkF3UkI5OWNYQ2Q3ZmY1Ym9P?=
 =?utf-8?B?cHM5RWFNSXdiUERwbHdOUEVoRnlxaFlQR2pBazBXYmVWYUYxZGpMdGhXV0pK?=
 =?utf-8?B?ZzM5Tk80d2VQdFc2Nm50MEQ3UldhSnhkcTFhejFlTENJazJBRzZqWi9HbFBz?=
 =?utf-8?B?cStlM1R1YTQyL3pwNWtCVGpwSzNVbmtFNXd5WHhpdmw0eEVZa3lmSEIwUFZG?=
 =?utf-8?B?WUN6bklGdHRZNitjdDllL1NWdjdONHhUV3pJS2VaazBReW5sRHRaOWp3bHA4?=
 =?utf-8?B?Nm1IWVByRGpDblBXY0hBUGdua1dneW5TOEl5TDBCSGhON2dyT1c5c3I2dE94?=
 =?utf-8?B?eDlmRndnWkNpS1VmeGlXK1ZJKzdqWlBKNklqK3FxWE9zTURvZFMvbVAxNFFp?=
 =?utf-8?B?VEVpVU5tL3cvYmpTYU9ySjdRZUhLUm5FdUE5djhZUy9VZndmU0JDWjd4YzhO?=
 =?utf-8?B?NExpdGh1UTFJWDUwVFhiWGhVZmV5ZUkyejdYbXQrekRrUTQxUmZIQWdoK3VT?=
 =?utf-8?B?aTVoTUpuUXVkSGpJUlM1R0ZIZ1NmRkh4TExvNVpqaEJ1Wk1LZURlMUhmeE8v?=
 =?utf-8?B?UU1tMmttK2VycWh5RGQwRG5Dc0xXVzBlSzFZUlZoZVZIV1FmY2Z4TUlPOVlx?=
 =?utf-8?B?S2p2Q2NpTDFTRUV3NTlkdTlHM3BIZHU4MDYvVG4xTWFnVkxzbGVpZDN5bUdO?=
 =?utf-8?B?SW02QTNtU20wUnFGbjJDWFk2VXhwTUFPVFIxbzB6M0Z4R0UvU0JpOUxTU25w?=
 =?utf-8?B?WldPYXlod042WUhXNFFIYUgxcDM0ZGFhRkdva0JlblZCUkphNDRsTyt6NHBZ?=
 =?utf-8?Q?MgAx9H2yELPllcdOEQB6vKo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AA8ABFCE77CE8489D4461077A91A598@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1fe01e-3f1b-4dbf-4754-08ddc649191d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 22:19:01.2363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 11904f23-f0db-4cdc-96f7-390bd55fcee8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hm994MiHv+JBqtbif40oh3Y/z6voz8tP6PEXETSXqTanj9leranRI/nn+nQF4dbE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6586

SGVsbG8sDQoNCj4gT24gNC4gNi4gMjAyNSwgYXQgMjE6MTEsIFpkZW5layBTYWx2ZXQgPHNhbHZl
dEBpY3MubXVuaS5jej4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEp1biAwNSwgMjAyNSBhdCAxMjow
MDo0NEFNICswNTMwLCBTYW50b3NoIFByYWRoYW4gd3JvdGU6DQo+PiBJIGFtIG5vdCBzdXJlIGJ1
dCBJIHZhZ3VlbHkgcmVtZW1iZXIgdGhhdCB0aGVyZSB3YXMgc29tZSBzaW1pbGFyIGlzc3VlIGFu
ZA0KPj4gTmVpbCBpbnRyb2R1Y2VkIHN0b3JlX3JlbGVhc2Vfd2FrZV91cCgpIHdoaWNoIHB1dHMg
YSBmdWxsIGJhcnJpZXIgIHNtcF9tYigpDQo+PiBiZWZvcmUgY2FsbGluZyB3YWtlX3VwX3Zhcigp
Lg0KPj4gDQo+PiBpbmRleCBkMGUwYjQzNWE4NDMuLmU3NTRlM2U0NzhhNSAxMDA2NDQNCj4+IC0t
LSBhL2ZzL25mcy9kaXIuYw0KPj4gKysrIGIvZnMvbmZzL2Rpci5jDQo+PiBAQCAtMTgzMCw2ICsx
ODMwLDcgQEAgc3RhdGljIHZvaWQgdW5ibG9ja19yZXZhbGlkYXRlKHN0cnVjdCBkZW50cnkgKmRl
bnRyeSkNCj4+IHsNCj4+ICAgICAgICAvKiBzdG9yZV9yZWxlYXNlIGVuc3VyZXMgd2FpdF92YXJf
ZXZlbnQoKSBzZWVzIHRoZSB1cGRhdGUgKi8NCj4+ICAgICAgICBzbXBfc3RvcmVfcmVsZWFzZSgm
ZGVudHJ5LT5kX2ZzZGF0YSwgTlVMTCk7DQo+PiArIHNtcF9tYigpOw0KPj4gICAgICAgIHdha2Vf
dXBfdmFyKCZkZW50cnktPmRfZnNkYXRhKTsNCj4+IH0NCg0KYW55IGNoYW5jZSB0byBnZXQgdGhp
cyBpbnRvIG1haW5saW5lPyBJdCBzZWVtcyB0aGF0IHRoZSBjdXJyZW50IGdpdCBtYXN0ZXIgZG9l
cyBub3QgaW5sdWRlIHNtYl9tYigpOyBpbiB0aGlzIGNvZGUuDQoNCi0tDQpMdWvDocWhIEhlanRt
w6FuZWsNCg0KTGludXggQWRtaW5pc3RyYXRvciBvbmx5IGJlY2F1c2UNCiAgRnVsbCBUaW1lIE11
bHRpdGFza2luZyBOaW5qYSANCiAgaXMgbm90IGFuIG9mZmljaWFsIGpvYiB0aXRsZQ0KDQo=

