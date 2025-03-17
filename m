Return-Path: <linux-nfs+bounces-10643-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03979A6607F
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 22:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A067A77EF
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 21:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76091F8ADB;
	Mon, 17 Mar 2025 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Qf0Nkgr6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2093.outbound.protection.outlook.com [40.107.243.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EEF1F4170;
	Mon, 17 Mar 2025 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246889; cv=fail; b=sAYYf8Nz+H0nJ5eeYmsZNgPgYtGVgJtkvrRQ9DKgRmus1ZXW55mGAXdNE5MXrY/zyTjpAduxLmovWWwJmeJdfF/mmWFE4C8Z4iiGb4t++sQIndV/wCMlGzhQKY9ip6c19J+EYEs9bxzl1znMtvOKq0kTvWzBYw/nEg2q41pYt6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246889; c=relaxed/simple;
	bh=fGUqaN2VBsHGYRdfbHHE4mZJUOOvwy6qmNyv9oQbhak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RtuKhOJUC3z3N55hRRsvDRJs/+S4n1aBgz9NlWO1Z3aacm3y0LDuhTSl9O8AC9SmSs4Ua91MbsR8w7Kv5F22unmQXqlRKYdWH8b63GeWPbnsLlvFdRY7z+epBmxTbN8ZKkJlT5lQl6Koq7RuuhA9A2OjOZhHUzkOdqkG+P3n3lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Qf0Nkgr6; arc=fail smtp.client-ip=40.107.243.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhIuv9HDfIna8aA5dHscawhmvUS+TQEdnzAkxupIMjem0X3fOa0HklkgX/ruRAnwfGB8xWdz2JpBNekp6e5M1W2rtZoS4POqJrOPzwtfaCKEJWC8cffh1pC5va+VaReN9FSq0831fcqG3ERvzFyWWbm0OXgjjP1LrAnKbhoevP+l10w98H8V7S6bPtDCl4ANNEwQYUDrtM5qQ8OarpMJ5rFFMHWETA3GLAjNdq5JPD3gHzu5T3vlbuR/M5yMivpBOWoc/akFfhq2g2aW4vtxV4AmduH6KOkZH1twi5YxFFf0xDGwCT/rLYgcBogg42ZuWT2YmK18RoG0vxUIUniMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGUqaN2VBsHGYRdfbHHE4mZJUOOvwy6qmNyv9oQbhak=;
 b=C1shbcY2FNs9ixvDB2cr+0oV7dgD2BqwEcH8+6V9tWgPyU4VkW6m7d6j4MGKChBbDrU5e1k+cw7nM5mt1ucksjb+2r10V8LigE3X4N5ifxCXWpBG26slu2TWKsGGErSsHkcf93doIYj8FhCZ939nXZqxS+cRS80+pWWLGfYzeyxsidyNVFy/Ga7YJSRfv4TRXDKUsT+WzoL7LEGqmtlvm9pJ6HvhlIHR7cleDjcj4n/PeyJbeG/ul+AYtegeoysMkzMAk0C79BgDvvueh48H6jXWIb/Y/Incbn0pI9Zd6L5bN65fPGEU5dE0DdlEyeAJ58CDQojqqKIvnLFnAoLBlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGUqaN2VBsHGYRdfbHHE4mZJUOOvwy6qmNyv9oQbhak=;
 b=Qf0Nkgr6QhHN9yGQgoy6Yi2ZfWLyFh3FdGDn5fk4jcmduXgD6PiphLTjw4lbW+UodfdyP7m4n5AUSlS5Spi0LWhf2Ud/PGMo5+zAnfrdtOdsgB0MgAa2BUrGF4BWvAJRcJzMANqWllv8EPYXjvv/tN4llSgTIBpblLw6M632FUg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB4784.namprd13.prod.outlook.com (2603:10b6:806:18b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.33; Mon, 17 Mar
 2025 21:28:04 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 21:28:04 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "horms@kernel.org" <horms@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"okorniev@redhat.com" <okorniev@redhat.com>, "anna@kernel.org"
	<anna@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, "tom@talpey.com"
	<tom@talpey.com>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "neilb@suse.de"
	<neilb@suse.de>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "bcodding@redhat.com" <bcodding@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC 9/9] sunrpc: don't upgrade passive net reference in
 xs_create_sock
Thread-Topic: [PATCH RFC 9/9] sunrpc: don't upgrade passive net reference in
 xs_create_sock
Thread-Index: AQHbl4A93CHa4xOFS0Wz/Ra5qddpqrN31+wA
Date: Mon, 17 Mar 2025 21:28:03 +0000
Message-ID: <8555e0cb4774bc1b225fe628cc4e07eb3c6e2a40.camel@hammerspace.com>
References: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
	 <20250317-rpc-shutdown-v1-9-85ba8e20b75d@kernel.org>
In-Reply-To: <20250317-rpc-shutdown-v1-9-85ba8e20b75d@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB4784:EE_
x-ms-office365-filtering-correlation-id: 4a816890-16a3-4ad6-81ff-08dd659a99fb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?RzRqTTBwSFYvekRmQ3kzd2N4R1kwVWhrZGNqYURtbkZ4eThBMXNCVXlGeU1j?=
 =?utf-8?B?bGNDL1YvV1ZjWlhhNnlHYXNsTytTNDYwMDRvR0NhN1labFpaQ3NoRFBBMDMx?=
 =?utf-8?B?UDZlOEdhK01ydlJKQkZkSHUweVM4aTNnVUdvczhIRjNvVC9hVjNhUm9GaGFj?=
 =?utf-8?B?QmJJS1cwbnIyKzdIWUpWOEd2d0t3L0lOeCtqSWhveG5lNmFzRGlZZ0NkQ0NN?=
 =?utf-8?B?d0h3eHFNOTNGZS9PNTRvaXhvRFpyV0ViQnQ3cE9VS3JxNTFZZzNiNHdDVlJO?=
 =?utf-8?B?U0lCdEh0RDlOa1gwU0xKNmtoS25RN2hmVEdSZUNBVEJXY1ZybnZBcXhVZVpY?=
 =?utf-8?B?bjM1VWc1akFQdjBTY2dHdjR6b0hhd2Z4Y21PeEdsRHNZN3RZQXZiaVlGQzVD?=
 =?utf-8?B?VkhUSzlyOFVNLzQxQUU0NHRPL3o1OStLRmlYeWNiK1hIR0NZejBzbXZPWW9s?=
 =?utf-8?B?UFVNZ3hPTml1MzJNQTdUZ1FFRk40UnR1dW9pSlB2dUNnLzFNT1I2eVhWOEFU?=
 =?utf-8?B?S045MUIzNVVnTVZzSDhLT05sbklQUm1BUUNOaXlIaitnQk5SSGVhMytEbTRo?=
 =?utf-8?B?OGM0SzlaMXFyNkZEdEY0Y2lwekFNOERIdmVtNjlVeGJhT0JueUVSVkRoemlp?=
 =?utf-8?B?RGhWS25uekh2RjJBamg1SVh1SHdTUXRPaXUvUi9ONkI5S3RRQlpoQ1JLRG5Y?=
 =?utf-8?B?aDJPZXp5NGpxVzVKYnB4VjRneEhaRmpRaS81dmgzU1orTW5ic1g0UTNjbGg1?=
 =?utf-8?B?UFU5cmVwRkhkQ2JyelE2VExDZmV0eUU3ZUxwVEcwOTZRODNtR053QUd4N0RH?=
 =?utf-8?B?R0I0QWI1RDhJbFBmdUFsbDZFaHQzZnF6RVlVUGNOalZCaStOTDJpNGFjWHZy?=
 =?utf-8?B?RDJ0eFN2ODgrRkN5L1RhOWkxT1VYSnFYSzNoMmgzTEp3dEFYemxXNnJXZ0JN?=
 =?utf-8?B?aWw2V2dSYnlkMTlHTGRndWVLclFNdnc2ZkVZV0xRcjhnY1ZIb2xuRWdmSFZL?=
 =?utf-8?B?MTNjRFJ4OFJ4bEhNd0tueE4vS21Pb2dWbUtIK2REYTF1dC80OHRzcXBlejFQ?=
 =?utf-8?B?SWEyODV1emloL1dldllYRU50alZjSEFYTUdTdldaaGpXMEdJSk1GYWRtZkht?=
 =?utf-8?B?YjFhVjlYeWRwd0N0Q3lxVHVLV3NtM1o0a0xYajRieVFPM096WWJmOUQ4Qngz?=
 =?utf-8?B?SFdvbmVlWkN3NDFkanpUMWFqMnp6R0FGN29LTWRqKzBGMWVUdWk1ZEVEWkt0?=
 =?utf-8?B?elNIM0lzaFQwWm43dVdhNTU3NkNFYVB1dE5QUXdRMVBGWmdON1VMMXNDV2Zz?=
 =?utf-8?B?bkRkWXRZMXc3aW42d1ExYXYvSEYwYTI0dTZDQ1NIQ0dUMzh3bHlNV1YwU3NY?=
 =?utf-8?B?Z0MwNk16UTJBVVB5QWtaT05xK1FZRGVobHltRnJaNkRNMkRjWWJla2ZLZmZp?=
 =?utf-8?B?MDJMbk5mMWZZM3JnOVd5dXFDRGVaOElVa2hmWHVzK0Jwa2V5MDJTeGpvZHBG?=
 =?utf-8?B?dVJKclU2Um8yOUtGeXFvaWdRTW5SVzQ1OEw4QkZzK3BXSFlLSThia2NMVDRT?=
 =?utf-8?B?RDhYOXN5VXJ6Tkw0d0JoaGs3aEs0WnFhdFEyTjZEQkFERFpDYlZDbDlJRVJZ?=
 =?utf-8?B?bUpBUk9TQkVkSlFzMXBYY0RWN0JEdWlSZmRhYkFqMWhhejlzczFoQjNNRnNp?=
 =?utf-8?B?WFpoczRRUWxmbml3cGRmWVBRRlhnZzNjd3pTY25tZXQrOGxBbkwzUUErSzh5?=
 =?utf-8?B?V2lyMy80L1ZzSWkzaTFxa1NQWkV0MlkwMk0yV1lZTnhwTm9ickRBdDVrRGM0?=
 =?utf-8?B?TTdDSlg5UmYveFVmNi8zNXdUVkhqcEo2NUlEMThyak9pTTJEZ1M5Q0U2NnJU?=
 =?utf-8?B?TEgrQU40Q1duRGNrdmlTanZvRDl0WmhhZ1k0dVltM1o1Snc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yis5dlljTVRhbzZLWTdvSDhlVi9sSlR0MFhNZXB1WEI2R0tQU2p6cVR1MUI0?=
 =?utf-8?B?S0FhMnZjTjVncVhZTmtMTUNFeFpGWHNaYVlLTzU5dStmZUZDS21VUENCeUUy?=
 =?utf-8?B?RWJYdkhKZ20rK24xREJJY2I3V29pNVphaGp2Tk02V05TNUI0dUw1aDM0UTZk?=
 =?utf-8?B?OGdqdjZmWGROb3FodVZ5VkhGcUwyazlQci9IbFRyRGpZN3Q4M2JhY09IeFhs?=
 =?utf-8?B?UTZtN1RQcEx1dTdkdTRNbCtESHQyUnQwM3B6dFZrTE1QdW9MUHdYVDRXdktB?=
 =?utf-8?B?K0MvclJCc0djR0xFRUV5QkhxamtrV3Z1NnBRU1ZydXRUaE1jSWljaHhXNlhq?=
 =?utf-8?B?cHRWY0NBSHhMa2xwMDI4YVFvSXduWVhMVUhLUU9MOUJIa0hvdmxDTHp4SVVt?=
 =?utf-8?B?SDN5T2pXN1JNTWtWaTlQTE5aY1Znb1g4VjNmdm9tMEFhWUhmVmJwMGR3VXNX?=
 =?utf-8?B?SGlpejN1TWN6T20yNGRYSk5SYUVkS1BxN3MwOExoNjBkU2VSa2diUE8xSC9Z?=
 =?utf-8?B?NkN4UGNPdE9Hangza2NPdng2UXM3T0p4QVVZQ21Jc1FlaEJETG1HK3U5K3hG?=
 =?utf-8?B?d05lYlFoM0o4WjhRZzBLVFdBWE4xYWhpcW9rMDZ1cDRsbS90bEdwelJHcURT?=
 =?utf-8?B?ZTM4cCtnQzZsbFJZU0dycnJnUHgzWHRCZHdrZEF5MGsrb1JHSGp5SFRSR3FH?=
 =?utf-8?B?K2tSQmxvdVJIYnlDL3pXNHdYbnZVenhNYjRMQVQ4cW9Lc1lORUhsaFpnMjFv?=
 =?utf-8?B?RWZQMWM5N3A2WjBJaGZWaFBLVWZ1VUdINW0xQTFkbktoTVY0UCtTaWFXVTk2?=
 =?utf-8?B?MUdBT2tybnhQbGxGSW9JcUhIU3g5RllGZytPWGwxZm5zTVFJSUhjUytJRWpt?=
 =?utf-8?B?eVN6QS9kSEtqUXY5L1RDU0J6NUVNUE83V3FyY1ZnQmhZdHpTN2czdnF0cThr?=
 =?utf-8?B?TFRVKzBmMmh6SG1oWGRIWkNKakR6SXZkYVZrQUVsWGNuSUxKUjBvSVdZUnA4?=
 =?utf-8?B?UEg4UGtQdDhsVzNKcmxGYS9MbjZMYVZaR0dBclRZV0dFTC9wTnkxRHk2RFdD?=
 =?utf-8?B?M1FlMmk1cDJ5aXFTKzJOWkRLU3RUcUVoQURrbDZKZUtpUmQyNzUwdnlXVjd6?=
 =?utf-8?B?RnV0RWQzcDA2WnJFSFZ4WFJxNVNRSCtBMXhjNzI5cjA3Qms0Sm9rZ2tidWhv?=
 =?utf-8?B?QnpaVUV2UWZwbEhrT2c4djIwNmFJT1l0S1o1Mm9ndzJBR2IyL1pGejMyQ2pD?=
 =?utf-8?B?RU9kMldHd0RPbTQvYWQ1RWNrZDVPSjQrUjFvSW8wMk9WSTVxL01OS0xwL0k5?=
 =?utf-8?B?VUpQcWRyOHVQcm83WlMxWnlqVmlPTVdJSCtXRVJXSzZKSDE3djRpMjdSN25a?=
 =?utf-8?B?R3B5LzFTbVo5QmNGcStodzl3WWdkVFpSUHV2cjJVRjhCWUY4UEZDWUdRMnpn?=
 =?utf-8?B?ZUJYYVVoRmpETXRwSDcrRWhqcEg2RnlYdmYxcE1NNmxoMkpKUEhHNFpZOXJD?=
 =?utf-8?B?YTlteVVXYjlCY3ZQQVptRzAzS3VMbUt0QndnVlFuK0hIYmpHOUhuTENBaG4r?=
 =?utf-8?B?YUlBVjBJRnhLR3BrWFNTWU1FSWdvWk5KRTBlQm5idVBwbFllTDlybE4xL1hz?=
 =?utf-8?B?SXAzTGc3RHl4SG9PYnRjUFZCWktweTVkL2hZNk1iYXJ2QzhKWTZ2MWtxRzd6?=
 =?utf-8?B?UU9oaTJETFR2YVpzSWd1MFozNFdXM1U5aTRrUWtEM3lEclF0VXlzMFpybVFa?=
 =?utf-8?B?Q0hvUGxmbUVDNkIxQzM4elV6RUhhN29udzF1emRDVkVkWVpGR2pxUUxPY2l1?=
 =?utf-8?B?d1RVSjFnSHNTYllsZUJuSkhRYU5Ndy9BWlhIU1VyZGlzZTJIYkJjM25RSkIx?=
 =?utf-8?B?NHh1TmJLSW9zR1h0MXduNjhLWUJoWDhZdDN0cDZlaTJxQTJsaS9KSUZBQTUr?=
 =?utf-8?B?RXJVQjZtU0J1MUZNdzcxSTFndjNsWXpSL1lxOU9IWHg0aWdWMXo2Y3d0SVo0?=
 =?utf-8?B?aERTelhJTWpGbitWVTJzbklVUE8ybFBsTCtDL2owU0x1T3NDVHRDYWh2cmln?=
 =?utf-8?B?OW1EdDJKR2NpVVkvdXJ1TWxwVUNaOEhHSFFCeEFWOERYYlhZOC9iS1RNazJr?=
 =?utf-8?B?Zm5xZ0EvT0xsdXJzQWRjc2xKTlFncXN1VE12NHI5ZWZqWG9velFoOHJtaFM5?=
 =?utf-8?B?bEs5ZXE4RzVibjBFLzVmZGJlZjRzRDRQcWJwU09GWU4wUmw2WFdXS1h3Ny9H?=
 =?utf-8?B?OVZUUkYzMlJIMU9oYnZLMWFERDdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C686BDA44D531444AEEB594C1E96567D@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a816890-16a3-4ad6-81ff-08dd659a99fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 21:28:03.8941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XeRmd9jk9XItzZPHMyBMyI/fr/sTz9d4QMd60tZ3rB7hKPv4Q5Uf+NU2Nh6MDOftZ3EtP/lNrhbgQHsjZvY+rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4784

T24gTW9uLCAyMDI1LTAzLTE3IGF0IDE3OjAwIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
V2l0aCB0aGUgbW92ZSB0byBoYXZpbmcgc3VucnBjIGNsaWVudCB4cHJ0cyBub3QgaG9sZCBhY3Rp
dmUNCj4gcmVmZXJlbmNlcw0KPiB0byB0aGUgbmV0IG5hbWVzcGFjZSwgdGhlcmUgaXMgbm8gbmVl
ZCB0byB1cGdyYWRlIHRoZSBzb2NrZXQncw0KPiByZWZlcmVuY2UNCj4gaW4geHNfY3JlYXRlX3Nv
Y2suIEp1c3Qga2VlcCB0aGUgcGFzc2l2ZSByZWZlcmVuY2UgaW5zdGVhZC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiDCoG5l
dC9zdW5ycGMveHBydHNvY2suYyB8IDMgLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94cHJ0c29jay5jIGIvbmV0L3N1
bnJwYy94cHJ0c29jay5jDQo+IGluZGV4DQo+IDgzY2MwOTU4NDZkMzU2ZjI0YWVkMjZlMmY5ODUy
NTY2MmE2Y2ZmMWYuLjBjM2Q3NTUyZjc3MmQ2Zjg0NzdhM2FlZDhmMA0KPiBjNTEzYjYyY2RmNTg5
IDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBjL3hwcnRzb2NrLmMNCj4gKysrIGIvbmV0L3N1bnJw
Yy94cHJ0c29jay5jDQo+IEBAIC0xOTQxLDkgKzE5NDEsNiBAQCBzdGF0aWMgc3RydWN0IHNvY2tl
dCAqeHNfY3JlYXRlX3NvY2soc3RydWN0DQo+IHJwY194cHJ0ICp4cHJ0LA0KPiDCoAkJZ290byBv
dXQ7DQo+IMKgCX0NCj4gwqANCj4gLQlpZiAocHJvdG9jb2wgPT0gSVBQUk9UT19UQ1ApDQo+IC0J
CXNrX25ldF9yZWZjbnRfdXBncmFkZShzb2NrLT5zayk7DQo+IC0NCj4gwqAJZmlscCA9IHNvY2tf
YWxsb2NfZmlsZShzb2NrLCBPX05PTkJMT0NLLCBOVUxMKTsNCj4gwqAJaWYgKElTX0VSUihmaWxw
KSkNCj4gwqAJCXJldHVybiBFUlJfQ0FTVChmaWxwKTsNCj4gDQoNCklzIHRoaXMgbm90IGdvaW5n
IHRvIHJlaW50cm9kdWNlIHRoZSBidWcgZGVzY3JpYmVkIGJ5DQpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9uZXRkZXYvNjdiNzJhZWIuMDUwYTAyMjAuMTRkODZkLjAyODMuR0FFQGdvb2dsZS5jb20v
VC8jdQ0KPw0KDQpBcyBJIHVuZGVyc3RhbmQgaXQsIHRoZSBwcm9ibGVtIGhhcyBub3RoaW5nIHRv
IGRvIHdpdGggd2hldGhlciBvciBub3QNCk5GUyBvciB0aGUgUlBDIGxheWVyIGhvbGRzIGEgcmVm
ZXJlbmNlIHRvIHRoZSBuZXQgbmFtZXNwYWNlLCBidXQgcmF0aGVyDQp3aGV0aGVyIHRoZXJlIGFy
ZSBzdGlsbCBwYWNrZXRzIGluIHRoZSBzb2NrZXQgcXVldWVzIGF0IHRoZSB0aW1lIHdoZW4NCnRo
YXQgbmV0IG5hbWVzcGFjZSBpcyBiZWluZyBmcmVlZC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QN
CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

