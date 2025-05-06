Return-Path: <linux-nfs+bounces-11530-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B8EAACA3B
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 17:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BCE4A72F4
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B883525DB1E;
	Tue,  6 May 2025 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PgwwPLUj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2118.outbound.protection.outlook.com [40.107.223.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41053A32
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547144; cv=fail; b=ONj+fmrgpz3aUorInz8rVtH0OfeExknDS091z5t6sIsYZkLvrixeQY2fet/XxHiaxu5O5HX0RUSw8R55MZAR2G6KiaqvhK/FhzA1G9/2gw2lo1xFdVvqRMe6KMDa4MvShTaonns1XAWUFv5hiXax4KL4GYJJImNZwvEBRb5H/cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547144; c=relaxed/simple;
	bh=03Bfg3YGcNSjJIdgOoQ8JSpUDC11XlfS+EAvEYE8h5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NIxdWAXmeugqbve1pgIt3nu+08Hdk1J6OYXwsDCLnLY00vvBfjwH0a2uZS1XtylKxy1IlwdJAVP9t+I1ebFQNEGT4Gy+2eLSGhTiaLrzIlGc0/mvYmJEFA0wFmkkIPo10cq2pLGVuLWFXDz43JBguoJbB0N6U0LAGo73QrcaBtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PgwwPLUj; arc=fail smtp.client-ip=40.107.223.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRG/B5znu2Wnrm6G5vewTLGnvdj6HSTBnDiCXYK/WOHjmvFka9nkkfrhJh0w9hDwoL8TMkgAKJC6WpMv/VsKjx+AUWGOIcdOnoPOhFkU+4F30M0OvR28E4qglZcJMlqsAXy+tbQikOWDRHakOmOebEwkTm7nvsQwuHbLGHWmD2kDwbHzLCFubrpU7RH7OnuRSyiX+BRdymA2q2L+ujOR2G19nIb43XOUZpAl5ld6VHVi+VZzdMWOGN+PfdXHXZqQofhJXtBG2wV0bqxYhlCHIrIwi6uZUo9NUyZ95/GBzU3bgRqNB0sZxLQzvt5pUzhnBaPAF6jrQ7CC4rS7sL6gzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03Bfg3YGcNSjJIdgOoQ8JSpUDC11XlfS+EAvEYE8h5g=;
 b=fBD5eBGqWR8otRoiYWXgIXW7e3ryafiU06vYOtNenj8LZBTc9qFSQRO921xmN7o7etX/j+9Tz01fjN2jPzGl+oPiR2vszgtIpbaBRBxDXinWzgfD+wJJbMRT1Zfe3NHNEn22rs7r81tIgI5udOKq6itiyaxF7kM3AM8oboA/5oZTV4xU7Ya7oh1t2nDDXx8U4EGRAKvm6ar0Q5TEhXiHiNX3qX6xqggwRosXSlve2YBtqTnn9ZLZ9tW+Yf/5p+SfFcrF+nE0yvaJFSf7+Z8Enlrb9Ll+JQeHxZKXuZ7eGoAWzW/Ma9VvPlbG1uTCZP48OH8lT4wNkgT66kOYYUFptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03Bfg3YGcNSjJIdgOoQ8JSpUDC11XlfS+EAvEYE8h5g=;
 b=PgwwPLUjIZDHrfsnOnNpA2G/JAFc+vPM/LBTStWn3Npg0t7mDtbbvV33iyv8qjymDVwH7sg3YCCmLXUhofkwmKRpJSX16HFn4+B/UC20NHikMRD5W8lqww9gEMnhTwXqAQvRCU1M9i9dHOIh4IL4loKZIXpC0ZYV8QlvcOBz+GE=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 CH2PR13MB3781.namprd13.prod.outlook.com (2603:10b6:610:9a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.22; Tue, 6 May 2025 15:58:58 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%6]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 15:58:58 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>
CC: "jlayton@kernel.org" <jlayton@kernel.org>, "Anna.Schumaker@netapp.com"
	<Anna.Schumaker@netapp.com>
Subject: Re: [PATCH] NFSv4.2: fix setattr caching of TIME_[MODIFY|ACCESS]_SET
 when timestamps are delegated
Thread-Topic: [PATCH] NFSv4.2: fix setattr caching of TIME_[MODIFY|ACCESS]_SET
 when timestamps are delegated
Thread-Index: AQHbteCAtttyyqpzMk6XZf4olcSUY7PF08iA
Date: Tue, 6 May 2025 15:58:58 +0000
Message-ID: <8b902648694f8022e7455d4aa88d19540864fbed.camel@hammerspace.com>
References: <20250425124919.1727838-1-sagi@grimberg.me>
In-Reply-To: <20250425124919.1727838-1-sagi@grimberg.me>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|CH2PR13MB3781:EE_
x-ms-office365-filtering-correlation-id: 2e9a34a1-6712-4edc-c108-08dd8cb6e96c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tk95SU42dENONUdzeWRBT2JmczcxWldKbGNIZzFQM1Q1WS9NWTVwTXpZTnBN?=
 =?utf-8?B?YmcrVEtNanN5SDNnWDNHOVVjOFJYTUpTeU1lelpHcFM5dWI0UlhtNVVYWWxN?=
 =?utf-8?B?bldrbi9oZzExZHB4ODBnYlpCdDVTOXpQbkJOVy91bXd6YVVDQnovbUZ4cVhJ?=
 =?utf-8?B?cUVFMUVtYW9KcmIvellDd2htOG9zSlhXaEFVdWljWnppNDh3NDVvN0R4WmJx?=
 =?utf-8?B?cWZOUDBmV1MwTU1uRjMwR2E1NUZDeHVKbVpKQkZ3elB4dDNNRGJQdE41dW5L?=
 =?utf-8?B?RGs4SUZEa3k1Q0xxcEFDSVByQ2p6aG1FNFN2U1NiN2JRTTVpK25zUW9Ob0Zm?=
 =?utf-8?B?Mmh4NHliU2VqMGFsSEpVT2hYNVk5di9LNTJYQms0OHhjVEZBZU9sTDJ4UWVa?=
 =?utf-8?B?cXFDNm0zMDhZejN6NnhYRFNrQnZyR0VrQjBLbUNGRDhvVUJXaVAwejF4Z0Jy?=
 =?utf-8?B?bngxMTY5alhYOW9wL3dDbUJkTUJBU1puMU5QSXhiYjdOM3FtNGJ6dDFmb1du?=
 =?utf-8?B?N1dacEdHcUwzdVREYXU3ZnowSi9xMXZZMDJ3eWlpRlg0NmRpMTNwQ1J3cTZn?=
 =?utf-8?B?d3dtVk1uZysvcDV6bnViVFMvTTBYSWtKR0VNN0NxcTFHME5kVXpkSFVIVEtV?=
 =?utf-8?B?aldmZFZOaEN0ZjNhcG5abHVBVlN3T1VseWdPYjNTSWNIVjhXRkxONk9GbFQ1?=
 =?utf-8?B?blFTRytIRmFCbFJUT29KeThjN3VCamkyUGkxSTFzdkdENUcwSmNzQ2NDRVJX?=
 =?utf-8?B?L2hzU0tjbzZORUE0L1NaMGUyREVaaUFmWlZiVjdkY3NmSnE4L1lXNS80SUpS?=
 =?utf-8?B?Ym9mc1RuMEFvVkVWdFhLTlQrbUlOZGQwTzhkd3RDM0ZqSVB6WWRxVGJUZjky?=
 =?utf-8?B?REtXTTJhcnpjaEY0QlgzNVhYbU5maklMZCtQMUFSWmczY3RTakVpRHp1R0I1?=
 =?utf-8?B?M0lUQ1l5ZGFQaFIrN3E4Rmc4Ujl1QjBobWRLa3BMZnF6OGc0SCtqZ2dsdXdT?=
 =?utf-8?B?eXVCZG1Zczc2M1ZMWVllM1VVd2Z5bkxNTUVpVzJiSnAybGJBMGo5YjNWZ2Ur?=
 =?utf-8?B?WkZmMmVrbGdhUFFuSE9TMittYU1kQnRGejdaWmw1UWhtK3IyMlJTZHR5RFJs?=
 =?utf-8?B?dnRLdk5ab05BNWg2aDgrZmlZOHNzMkJTb1huNVVVRHZQbld6Q0p2MGNHQnBT?=
 =?utf-8?B?VmYrMjVlZjRsdmdhQXpyalIrMUlyK01oM1o3M3hQNjl5Q0VaOXpXRFZ2bTMx?=
 =?utf-8?B?Ym51aTZ5U0ttaDdUc1h3VmxsN0QzQnF0Lys0dUxnSUpURnhUMEE0d0xCUVFI?=
 =?utf-8?B?ZjFqRTZPM3FJNm4zZ3VFbE5JTHd0ME41SVNUL0pUMFl3YzdMSGFneGxEdHJx?=
 =?utf-8?B?NFhRY3VOanhZbzgrOXI3U1RMV0Z3dXFqR0dOd3pZSm9xNXVMMElXdUlSZTc3?=
 =?utf-8?B?c1ErOFY5R0cyQVluSjhSTmt4eStlR3liSGdsVUYwSWFHb1ZTekVuK3lZTGFT?=
 =?utf-8?B?Nm5QNHdsTXJiUHl6QXkvS0hmcWlpM1ZRNHdyd0wwcnJzY2dqdE1vTU15SHEy?=
 =?utf-8?B?U1ExWW5qZnl5bncxNytCNGs2TzNjZSsxYXFldldvZVJVdHdIcDZhY2JwTEJu?=
 =?utf-8?B?VmpJeFBNaVVrNWxBQ3NRVHl1aHBXZDVCUUpBd2txTGlGeFJmZXRSbUI5Qk1T?=
 =?utf-8?B?dzZOM1hWUGx0YThqSjN4MFcvVmEyNEpOWkpvRGFxMEFKRitqWXB1aUNCVjZm?=
 =?utf-8?B?dzZNM0pKRnVKcDdDaU95OUI4NVM4M0J4eG5YT2hTRkJVWW5qSzJrU0hSVVdZ?=
 =?utf-8?B?ZDhBck5nQldiWWE0M2F6SUZMWkNUbVYweWxPL0pjQmtFcjNGUFhobVJpTHFW?=
 =?utf-8?B?Z3ZFVkNLVlpmL3pCSEprQUpBY1FaTnZCMERnVE05QkVubG9QdzNiRnp0Nmxn?=
 =?utf-8?B?Nnpyc0Z3b2tKa0NHYUg1b0dPaDF6dks3eC9aTXUyQWhnUDhMNHJNbGlGajFI?=
 =?utf-8?B?OVlqNUd3cjJ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWNkR0tRN1VKTDh0c0srRVZhNFk0U29wR05BTzN2NnFNdXZxblpLVWIzdHky?=
 =?utf-8?B?MEJBNm5uU2RDTjVyWWFJcDE1RGhnYm9nTEUvWWttaUdnRTgweDMwMmRZNkpC?=
 =?utf-8?B?aVFCbmRQOWN0bXFGOCtwNmY1K0pIYTlTUGNHMmNDU01BUFY4Y1NwRXdySnJ2?=
 =?utf-8?B?UkN6bWthV3Jubm9CWHVxSjh0UU1HUTI3T0NhTEJZUlM1T25GekJOSVg1VEFr?=
 =?utf-8?B?OE9aQUY1WVg5b3VDNlZ3M0dZMzFjOFpJUTVReWR3SkhoVkhPVWlkaUEwdTla?=
 =?utf-8?B?YmxWOFJVNVk3dWdYcVpEc2wvWG1rdXlicDRyOFpsSzh4aURKcVFzeE1WN2h5?=
 =?utf-8?B?aERlNDZncWhtT1B5UWZQRU9HcS9BV2J5L3pBcndGNFh2UC9RWERWSVhnL0Nz?=
 =?utf-8?B?REhwV0dHQklwRnJwcGhuQlBWYjZCL1g4Z1JQc2t2bXRwMkVmMTdvNHY3UndO?=
 =?utf-8?B?MGNQeVNOek54dHNlTjd4WVFrUnQ4MGRIakVmVzdOZEpLNC9PL0tJUXNPckRi?=
 =?utf-8?B?K1ZYWW5jYW9MUkh0TkxlaHNoUXBJNG0rOHN1Q3NKSXVWb3BDQTlxNUVJMExH?=
 =?utf-8?B?eVZOdFBuU3UvSDl1dUYwOGV5TVY3eGVqcDZVY0Fabmw0MkxuN1dTc21rb2hj?=
 =?utf-8?B?WXExWU4wTGlyK3l0WFV3ellWbkk2cGQ4eEZrZkJWZWdxZmF3Zmk3TGtFd1Ay?=
 =?utf-8?B?ckhsdjE3dEFhOXFnOTc4ZXVscUdmeUN0L1R5QkErdVZVUWJseWE4ay9CTjU5?=
 =?utf-8?B?cnNwS3RzcTlWMTBKWHFRT0dlWmNLOG0wRTRiWHRqVnA5dkFVdmFoUXk2SW1N?=
 =?utf-8?B?M2JUcHUzNUY3bEZPeEZFbXdpNmJML3czSUljMmJuYXNRWmNJWnNsMWljVHlG?=
 =?utf-8?B?WkRzZzVCdFdjV0l2Y00vTkk2UVY2WjExdkdqOHpGNjh1cDEzWGo3TTIvY0ta?=
 =?utf-8?B?QjNTdGpTMjNla0pzU3o3Qy9UKzhQZHRoQSt3WnB6eGIzTkwwdk95OXFxUmd0?=
 =?utf-8?B?Qk1YZ3RIRjJ6eW5UeUFJOFJ5aS81UnY1bUNBcGdqbDhqcWt1TGorblA4a2xa?=
 =?utf-8?B?cHlnejQzZ1BPNXE4dGNnMzIxdjdxQnhIeVFRWHVyeFV6aHRwQ1BDMUxibUhJ?=
 =?utf-8?B?V0ZsalZpcmdIeXhnR2VZaDRFS2tSY0ZiQnM1RE9IQkZzQVJaU2p0UEt0NjRa?=
 =?utf-8?B?b2EvalFrS2gvVjAxSXFDc1oyR1dzSU1wK2htOFlMNm1yTG5XRkVYTkh4MTF2?=
 =?utf-8?B?cHVxaUdsQ09yWUhIenBlVkdZcWZ0a1JndjFCN3pZWEF5QW9aVkdKcnZnMW5T?=
 =?utf-8?B?VzVZM1JPanN2blVidm1jZGswVlh0ZWQyUHU0aHNUck4vdGVSd1VjaEtkRkc5?=
 =?utf-8?B?Q2g4b0YvNkpXRHg3czRaSER5cnVHYjgranNpT0hMRFRodXcvNklGcnNsK2Za?=
 =?utf-8?B?QWFlN1FiQjhKd2RnSFdYYXFtUkxmUXZoZmNrNTFiaHpMWFVaNkhYbElSR25R?=
 =?utf-8?B?MFBoVzl1YmFFcHQ2K2xKMWNLZVFnTWV2R1J0MXdxZm5rY3JyZGxGSGVqcTNR?=
 =?utf-8?B?RGhCMldoMUdjR2JQbEZRWG9kOFAwRmR6MEl0M05Cc2ZLQWRjaFN6N094Q1ZW?=
 =?utf-8?B?bTRzajhxalFQSUZrenkvRGRzSU44RXA0NnRJNzlYdE1WVDkwWkNFbHcwYi9o?=
 =?utf-8?B?SjlkL0lRVW5oU2tNUmVESFRnaDc2WEIxcS82UG95RFYxb3FNNlBDMXIvbFlM?=
 =?utf-8?B?SmNWRWpURzd4bDRreTNYOE42UWdtZ2tuc3FEUTNFdHR0RnlzWmNCa2ZIRmx5?=
 =?utf-8?B?T3RsWlYvUXBFbGEraFRERXBpYmV0TTREL0FSd2VWYmRjNi9KbmpHZnpOaExx?=
 =?utf-8?B?bGp0S2ZLWGRhbU5ieDZOL3dDbGM5VGYrS3l2QitXdkRPUVpDUDFvd0h2Ujdl?=
 =?utf-8?B?K1JZNGxPK1lndnJCRkNUTVN3UmNmTGNhaHd4ano3MG5ES2xlbDNqUjRJS2ZG?=
 =?utf-8?B?ZEY1SndFMXVtajZCaWVPQ2hicVB5S2JMZWRLSHcyOEtWcmR4RE91ZW12cW85?=
 =?utf-8?B?dElHYVNTREU0UmpjWGM2WWs1cUplcE5jaytCaTVkc3pZSTRCVHlreGFxdXNT?=
 =?utf-8?B?UXVmQVlRLzdLM3FJUjJKeWNBVDcwdUc1ckxLNGE2RGlPYmovTlBBU24ycGhz?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2558A00D8A0BAD41BCB3375E5E775316@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9a34a1-6712-4edc-c108-08dd8cb6e96c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 15:58:58.4551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxr7C6miHntnaPRBsZvFxgV21Nb6Fgq/egZCNgGdJ+v9L8MhXpytMQFUKtQw89+WE+kCPgM9AsFvybdXNdnz+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3781

T24gRnJpLCAyMDI1LTA0LTI1IGF0IDE1OjQ5ICswMzAwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0K
PiBuZnNfc2V0YXR0ciB3aWxsIGZsdXNoIGFsbCBwZW5kaW5nIHdyaXRlcyBiZWZvcmUgdXBkYXRp
bmcgYSBmaWxlIHRpbWUNCj4gYXR0cmlidXRlcy4gSG93ZXZlciB3aGVuIHRoZSBjbGllbnQgaG9s
ZHMgZGVsZWdhdGVkIHRpbWVzdGFtcHMsIGl0DQo+IGNhbg0KPiB1cGRhdGUgaXRzIHRpbWVzdGFt
cHMgbG9jYWxseSBhcyBpdCBpcyB0aGUgYXV0aG9yaXR5IGZvciB0aGUgZmlsZQ0KPiB0aW1lcyBh
dHRyaWJ1dGVzLiBUaGUgY2xpZW50IHdpbGwgbGF0ZXIgc2V0IHRoZSBmaWxlIGF0dHJpYnV0ZXMg
YnkNCj4gYWRkaW5nIGEgc2V0YXR0ciB0byB0aGUgZGVsZWdyZXR1cm4gY29tcG91bmQgdXBkYXRp
bmcgdGhlIHNlcnZlciB0aW1lDQo+IGF0dHJpYnV0ZXMuDQo+IA0KPiBGaXggbmZzX3NldGF0dHIg
dG8gYXZvaWQgZmx1c2hpbmcgcGVuZGluZyB3cml0ZXMgd2hlbiB0aGUgZmlsZSB0aW1lDQo+IGF0
dHJpYnV0ZXMgYXJlIGRlbGVnYXRlZCBhbmQgdGhlIG10aW1lL2F0aW1lIGFyZSBzZXQgdG8gYSBm
aXhlZA0KPiB0aW1lc3RhbXAgKEFUVFJfW01PRElGWXxBQ0NFU1NdX1NFVC4gQWxzbywgd2hlbiBz
ZW5kaW5nIHRoZSBzZXRhdHRyDQo+IHByb2NlZHVyZSBvdmVyIHRoZSB3aXJlLCB3ZSBuZWVkIHRv
IGNsZWFyIHRoZSBjb3JyZWN0IGF0dHJpYnV0ZSBiaXRzDQo+IGZyb20gdGhlIGJpdG1hc2suDQo+
IA0KPiBJIHdhcyBhYmxlIHRvIG1lYXN1cmUgYSBub3RpY2FibGUgc3BlZWR1cCB3aGVuIG1lYXN1
cmluZyB1bnRhcg0KPiBwZXJmb3JtYW5jZS4NCj4gVGVzdDogJCB0aW1lIHRhciB4emYgfi9kaXIu
dGd6DQo+IEJhc2VsaW5lOiAxbTEzLjA3MnMNCj4gUGF0Y2hlZDogMG00OS4wMzhzDQo+IA0KPiBX
aGljaCBpcyBtb3JlIHRoYW4gMzAlIGxhdGVuY3kgaW1wcm92ZW1lbnQuDQoNClllcywgSSB0aGlu
ayB0aGlzIGlzIGEgZ29vZCBjaGFuZ2UuIEkgY2FuJ3QgcmVtZW1iZXIgd2h5IHdlIGNob3NlIG5v
dA0KdG8gZG8gdGhpcyBiYWNrIHdoZW4gd2UgZGV2ZWxvcGVkIHRoZSBkZWxlZ2F0ZWQgdGltZXN0
YW1wcywgYnV0IEkNCnN1c3BlY3QgaXQgd2FzIGp1c3QgbGFjayBvZiBtYXR1cml0eSBvZiB0aGUg
cHJvdG9jb2wgYXQgdGhlIHRpbWUuDQpJIGNlcnRhaW5seSBkb24ndCBzZWUgYW55IG9idmlvdXMg
cmVhc29uIHdoeSBpdCB3b3VsZCBiZSB3cm9uZy4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2Fn
aSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4gLS0tDQo+IFRlc3RlZCB0aGlzIG9uIGEg
dm0gaW4gbXkgbGFwdG9wIGFnYWluc3QgY2h1Y2sgbmZzZC10ZXN0aW5nIHdoaWNoDQo+IGdyYW50
cyB3cml0ZSBkZWxlZ3MgZm9yIHdyaXRlLW9ubHkgb3BlbnMsIHBsdXMgYW5vdGhlciBzbWFsbCBt
b2RwYXJhbQ0KPiB0aGF0IGFsc28gYWRkcyBhIHNwYWNlX2xpbWl0IHRvIHRoZSBkZWxlZ2F0aW9u
Lg0KPiANCj4gwqBmcy9uZnMvaW5vZGUuY8KgwqDCoCB8IDQ5ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLQ0KPiAtLQ0KPiDCoGZzL25mcy9uZnM0cHJvYy5jIHzC
oCA4ICsrKystLS0tDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9pbm9kZS5jIGIvZnMvbmZzL2lu
b2RlLmMNCj4gaW5kZXggMTE5ZTQ0Nzc1OGI5Li42NDcyYjk1YmZkODggMTAwNjQ0DQo+IC0tLSBh
L2ZzL25mcy9pbm9kZS5jDQo+ICsrKyBiL2ZzL25mcy9pbm9kZS5jDQo+IEBAIC02MzMsNiArNjMz
LDM0IEBAIG5mc19mYXR0cl9maXh1cF9kZWxlZ2F0ZWQoc3RydWN0IGlub2RlICppbm9kZSwNCj4g
c3RydWN0IG5mc19mYXR0ciAqZmF0dHIpDQo+IMKgCX0NCj4gwqB9DQo+IMKgDQo+ICtzdGF0aWMg
dm9pZCBuZnNfc2V0X3RpbWVzdGFtcHNfdG9fdHMoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0
DQo+IGlhdHRyICphdHRyKQ0KPiArew0KPiArCXVuc2lnbmVkIGludCBjYWNoZV9mbGFncyA9IDA7
DQo+ICsNCj4gKwlpZiAoYXR0ci0+aWFfdmFsaWQgJiBBVFRSX01USU1FX1NFVCkgew0KPiArCQlz
dHJ1Y3QgdGltZXNwZWM2NCBjdGltZSA9IGlub2RlX2dldF9jdGltZShpbm9kZSk7DQo+ICsJCXN0
cnVjdCB0aW1lc3BlYzY0IG10aW1lID0gaW5vZGVfZ2V0X210aW1lKGlub2RlKTsNCj4gKwkJc3Ry
dWN0IHRpbWVzcGVjNjQgbm93Ow0KPiArCQlpbnQgdXBkYXRlZCA9IDA7DQo+ICsNCj4gKwkJbm93
ID0gaW5vZGVfc2V0X2N0aW1lX2N1cnJlbnQoaW5vZGUpOw0KPiArCQlpZiAoIXRpbWVzcGVjNjRf
ZXF1YWwoJm5vdywgJmN0aW1lKSkNCj4gKwkJCXVwZGF0ZWQgfD0gU19DVElNRTsNCj4gKw0KPiAr
CQlpbm9kZV9zZXRfbXRpbWVfdG9fdHMoaW5vZGUsIGF0dHItPmlhX210aW1lKTsNCj4gKwkJaWYg
KCF0aW1lc3BlYzY0X2VxdWFsKCZub3csICZtdGltZSkpDQo+ICsJCQl1cGRhdGVkIHw9IFNfTVRJ
TUU7DQo+ICsNCj4gKwkJaW5vZGVfbWF5YmVfaW5jX2l2ZXJzaW9uKGlub2RlLCB1cGRhdGVkKTsN
Cj4gKwkJY2FjaGVfZmxhZ3MgfD0gTkZTX0lOT19JTlZBTElEX0NUSU1FIHwNCj4gTkZTX0lOT19J
TlZBTElEX01USU1FOw0KPiArCX0NCj4gKwlpZiAoYXR0ci0+aWFfdmFsaWQgJiBBVFRSX0FUSU1F
X1NFVCkgew0KPiArCQlpbm9kZV9zZXRfYXRpbWVfdG9fdHMoaW5vZGUsIGF0dHItPmlhX2F0aW1l
KTsNCj4gKwkJY2FjaGVfZmxhZ3MgfD0gTkZTX0lOT19JTlZBTElEX0FUSU1FOw0KPiArCX0NCj4g
KwlORlNfSShpbm9kZSktPmNhY2hlX3ZhbGlkaXR5ICY9IH5jYWNoZV9mbGFnczsNCj4gK30NCj4g
Kw0KPiDCoHN0YXRpYyB2b2lkIG5mc191cGRhdGVfdGltZXN0YW1wcyhzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCB1bnNpZ25lZCBpbnQNCj4gaWFfdmFsaWQpDQo+IMKgew0KPiDCoAllbnVtIGZpbGVfdGlt
ZV9mbGFncyB0aW1lX2ZsYWdzID0gMDsNCj4gQEAgLTcwMSwxNCArNzI5LDI3IEBAIG5mc19zZXRh
dHRyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QNCj4gZGVudHJ5ICpkZW50cnksDQo+
IMKgDQo+IMKgCWlmIChuZnNfaGF2ZV9kZWxlZ2F0ZWRfbXRpbWUoaW5vZGUpICYmIGF0dHItPmlh
X3ZhbGlkICYNCj4gQVRUUl9NVElNRSkgew0KPiDCoAkJc3Bpbl9sb2NrKCZpbm9kZS0+aV9sb2Nr
KTsNCj4gLQkJbmZzX3VwZGF0ZV90aW1lc3RhbXBzKGlub2RlLCBhdHRyLT5pYV92YWxpZCk7DQo+
ICsJCWlmIChhdHRyLT5pYV92YWxpZCAmIEFUVFJfTVRJTUVfU0VUKSB7DQo+ICsJCQluZnNfc2V0
X3RpbWVzdGFtcHNfdG9fdHMoaW5vZGUsIGF0dHIpOw0KPiArCQkJYXR0ci0+aWFfdmFsaWQgJj0N
Cj4gfihBVFRSX01USU1FfEFUVFJfTVRJTUVfU0VUfA0KPiArCQkJCQkJQVRUUl9BVElNRXxBVFRS
X0FUSU0NCj4gRV9TRVQpOw0KPiArCQl9IGVsc2Ugew0KPiArCQkJbmZzX3VwZGF0ZV90aW1lc3Rh
bXBzKGlub2RlLCBhdHRyLQ0KPiA+aWFfdmFsaWQpOw0KPiArCQkJYXR0ci0+aWFfdmFsaWQgJj0g
fihBVFRSX01USU1FfEFUVFJfQVRJTUUpOw0KPiArCQl9DQo+IMKgCQlzcGluX3VubG9jaygmaW5v
ZGUtPmlfbG9jayk7DQo+IC0JCWF0dHItPmlhX3ZhbGlkICY9IH4oQVRUUl9NVElNRSB8IEFUVFJf
QVRJTUUpOw0KPiDCoAl9IGVsc2UgaWYgKG5mc19oYXZlX2RlbGVnYXRlZF9hdGltZShpbm9kZSkg
JiYNCj4gwqAJCcKgwqAgYXR0ci0+aWFfdmFsaWQgJiBBVFRSX0FUSU1FICYmDQo+IMKgCQnCoMKg
ICEoYXR0ci0+aWFfdmFsaWQgJiBBVFRSX01USU1FKSkgew0KPiAtCQluZnNfdXBkYXRlX2RlbGVn
YXRlZF9hdGltZShpbm9kZSk7DQo+IC0JCWF0dHItPmlhX3ZhbGlkICY9IH5BVFRSX0FUSU1FOw0K
PiArCQlpZiAoYXR0ci0+aWFfdmFsaWQgJiBBVFRSX0FUSU1FX1NFVCkgew0KPiArCQkJc3Bpbl9s
b2NrKCZpbm9kZS0+aV9sb2NrKTsNCj4gKwkJCW5mc19zZXRfdGltZXN0YW1wc190b190cyhpbm9k
ZSwgYXR0cik7DQo+ICsJCQlzcGluX3VubG9jaygmaW5vZGUtPmlfbG9jayk7DQo+ICsJCQlhdHRy
LT5pYV92YWxpZCAmPQ0KPiB+KEFUVFJfQVRJTUV8QVRUUl9BVElNRV9TRVQpOw0KPiArCQl9IGVs
c2Ugew0KPiArCQkJbmZzX3VwZGF0ZV9kZWxlZ2F0ZWRfYXRpbWUoaW5vZGUpOw0KPiArCQkJYXR0
ci0+aWFfdmFsaWQgJj0gfkFUVFJfQVRJTUU7DQo+ICsJCX0NCj4gwqAJfQ0KPiDCoA0KPiDCoAkv
KiBPcHRpbWl6YXRpb246IGlmIHRoZSBlbmQgcmVzdWx0IGlzIG5vIGNoYW5nZSwgZG9uJ3QgUlBD
DQo+ICovDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNHByb2MuYyBiL2ZzL25mcy9uZnM0cHJv
Yy5jDQo+IGluZGV4IDk3MGYyOGRiZjI1My4uYzUwMWEwZDVkYTkwIDEwMDY0NA0KPiAtLS0gYS9m
cy9uZnMvbmZzNHByb2MuYw0KPiArKysgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiBAQCAtMzI1LDE0
ICszMjUsMTQgQEAgc3RhdGljIHZvaWQgbmZzNF9iaXRtYXBfY29weV9hZGp1c3QoX191MzIgKmRz
dCwNCj4gY29uc3QgX191MzIgKnNyYywNCj4gwqANCj4gwqAJaWYgKG5mc19oYXZlX2RlbGVnYXRl
ZF9tdGltZShpbm9kZSkpIHsNCj4gwqAJCWlmICghKGNhY2hlX3ZhbGlkaXR5ICYgTkZTX0lOT19J
TlZBTElEX0FUSU1FKSkNCj4gLQkJCWRzdFsxXSAmPSB+RkFUVFI0X1dPUkQxX1RJTUVfQUNDRVNT
Ow0KPiArCQkJZHN0WzFdICY9DQo+IH4oRkFUVFI0X1dPUkQxX1RJTUVfQUNDRVNTfEZBVFRSNF9X
T1JEMV9USU1FX0FDQ0VTU19TRVQpOw0KPiDCoAkJaWYgKCEoY2FjaGVfdmFsaWRpdHkgJiBORlNf
SU5PX0lOVkFMSURfTVRJTUUpKQ0KPiAtCQkJZHN0WzFdICY9IH5GQVRUUjRfV09SRDFfVElNRV9N
T0RJRlk7DQo+ICsJCQlkc3RbMV0gJj0NCj4gfihGQVRUUjRfV09SRDFfVElNRV9NT0RJRll8RkFU
VFI0X1dPUkQxX1RJTUVfTU9ESUZZX1NFVCk7DQo+IMKgCQlpZiAoIShjYWNoZV92YWxpZGl0eSAm
IE5GU19JTk9fSU5WQUxJRF9DVElNRSkpDQo+IC0JCQlkc3RbMV0gJj0gfkZBVFRSNF9XT1JEMV9U
SU1FX01FVEFEQVRBOw0KPiArCQkJZHN0WzFdICY9DQo+IH4oRkFUVFI0X1dPUkQxX1RJTUVfTUVU
QURBVEF8RkFUVFI0X1dPUkQxX1RJTUVfTU9ESUZZX1NFVCk7DQo+IMKgCX0gZWxzZSBpZiAobmZz
X2hhdmVfZGVsZWdhdGVkX2F0aW1lKGlub2RlKSkgew0KPiDCoAkJaWYgKCEoY2FjaGVfdmFsaWRp
dHkgJiBORlNfSU5PX0lOVkFMSURfQVRJTUUpKQ0KPiAtCQkJZHN0WzFdICY9IH5GQVRUUjRfV09S
RDFfVElNRV9BQ0NFU1M7DQo+ICsJCQlkc3RbMV0gJj0NCj4gfihGQVRUUjRfV09SRDFfVElNRV9B
Q0NFU1N8RkFUVFI0X1dPUkQxX1RJTUVfQUNDRVNTX1NFVCk7DQo+IMKgCX0NCj4gwqB9DQo+IMKg
DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQo=

