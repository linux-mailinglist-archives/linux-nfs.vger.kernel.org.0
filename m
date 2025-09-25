Return-Path: <linux-nfs+bounces-14702-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E20B9D3FC
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 04:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10B77B541F
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 02:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145822E6CA6;
	Thu, 25 Sep 2025 02:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="hDYA3wNk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023083.outbound.protection.outlook.com [40.93.201.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA7C2D24A6
	for <linux-nfs@vger.kernel.org>; Thu, 25 Sep 2025 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758768974; cv=fail; b=kUZmiNB1otYAJgW9YZH4iQwtquJHuAGSFBrPAW26ETsXb6NFdCdy+gY9EzNA1EpsdEgkz/ZRu/rjByIHpFuaRFKs7J+w5sD9Drku83PBovLHg7oCjmqMOLfGYjmKJJ+tTdek1m2ofO7djqXB8K9QhkpJywh8AL5KcvPOKnD6OqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758768974; c=relaxed/simple;
	bh=s8E1LaHxFJ/gRDYZK+Gx06EF5Odic+uK+awRbLhSF6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RpAGdhGHtXneSApu1yBcunQpk+0x5KVrQAYk6pJo2LJKGUrm971HSAmO9MKN3RRhE/lng8QUFYMM+S2mEC98lk9NW0630jqR7/PHMPHXm49tAudkAHT9bXgaWFJAtsWk9Og5rdy6Jv279WLTd8q4HIqxA67x5opsolLvgxd9Low=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=hDYA3wNk; arc=fail smtp.client-ip=40.93.201.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOUvEY5h9MyPyZopnt9H7uueit88ZQqU13sS1iUHB4hurAauP5nYI3jf1OCnmqNKbfKxKmgU3Qtula3SxBpZ2RRkXrHfwo4auezPt0IJO14DVmZgP+Ghg0bAYdZs95pkfZut3LtxIStpecmvAANfCLTasX/sv6C3fnPU5jhJk3nZKbdA/htF0CA8Mqje9lXvtjoQioLACqiqO7HOrWLwRY3oHbi/f8k3LOkeM8R4b25D9UV3e51oBH+6n3FXmMGfifgzeBDZq9AzqAbp5JVJgrfjSiBprMmxbdoyi++M5QQLB4NMsCWTaraJIvjv3R4raO0aWvqk824xtcIrLbHV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkexZNDVpIDCbTQK1hQwNBzgcshzi0TOO6QTNjYx5sQ=;
 b=ZfneBelKfOEy5BfRXPyWirAcALWy08oLxpfMObA62/FrZvxJ03ruDVRI5BE8TCei08RDVGjTuTdy9crEaBWBEk3HPWl5cJ8vDqj8BCDGKvfKtpohMThB0UC82futyzoUkYEJpUCfcjLCcF4vYGsKMzWjl56P3eX3UIToLrjYvFQqAfAPYf8tKMhnY1bbvRPBiuG8EqGwkq4NEdCBckfz6a9ODXLx1dXmeXHt+Z8aUpWtrKNODcFWFU+6lz5WbHS+UyRhHhAszyGi4dr7t283XbTioYu15tEobVIfyWxHZcQHFZ96S96ZTBwzTeJIENm+jaB9dpQCjXx1lg9ASNglDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkexZNDVpIDCbTQK1hQwNBzgcshzi0TOO6QTNjYx5sQ=;
 b=hDYA3wNk78ZrjtjTlpRLGN97aFLx/p3mz5dp+AkfPyrsEybVdv/XOWYEqSz1HfULgcwJADfWobjK5+2vwQOUPbQY+wYKSDr1BWHhcq4rxBN26Yo0Gkl3no4IJV2mlGp7aGULNJoTeDKH05otIDI54uKXKfGsyhKMevAnUkcbXww=
Received: from BN0PR13MB4696.namprd13.prod.outlook.com (2603:10b6:408:121::23)
 by LV3PR13MB6455.namprd13.prod.outlook.com (2603:10b6:408:196::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 02:56:08 +0000
Received: from BN0PR13MB4696.namprd13.prod.outlook.com
 ([fe80::c2cc:45de:549a:ae13]) by BN0PR13MB4696.namprd13.prod.outlook.com
 ([fe80::c2cc:45de:549a:ae13%6]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 02:56:07 +0000
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
To: Mike Snitzer <snitzer@kernel.org>, NeilBrown <neilb@ownmail.net>, Chuck
 Lever <cel@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>
Subject: RE: [RFC PATCH v3 4/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
 (v3 and older) [Was: "Re: [PATCH v3 3/3] NFSD: Implement NFSD_IO_DIRECT for
 NFS READ"]
Thread-Topic: [RFC PATCH v3 4/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
 (v3 and older) [Was: "Re: [PATCH v3 3/3] NFSD: Implement NFSD_IO_DIRECT for
 NFS READ"]
Thread-Index: AQHcLYq94k/xAybMN0+rE8hKUKG9B7SjM0og
Date: Thu, 25 Sep 2025 02:56:07 +0000
Message-ID:
 <BN0PR13MB46960E5A7E35265561C3BF478B1FA@BN0PR13MB4696.namprd13.prod.outlook.com>
References: <20250922141137.632525-1-cel@kernel.org>
 <20250922141137.632525-4-cel@kernel.org> <aNMei7Ax5CbsR_Qz@kernel.org>
 <19eef754-57d9-4fe4-a6e6-a481dcec470e@kernel.org>
 <175867132212.1696783.15488731457039328170@noble.neil.brown.name>
 <60960803-80b3-4ca1-9fd3-16bc1bd1dbd4@kernel.org>
 <175869903827.1696783.17181184352630252525@noble.neil.brown.name>
 <aNP8U48TjSFmRhbD@kernel.org> <aNQL3fFzFZIL3I4u@kernel.org>
 <aNQ-1OSG9Ti5XbUm@kernel.org>
In-Reply-To: <aNQ-1OSG9Ti5XbUm@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR13MB4696:EE_|LV3PR13MB6455:EE_
x-ms-office365-filtering-correlation-id: c07769a6-f7a6-4aef-c247-08ddfbdf136b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?dEdCaUhVMzVyS2ttUU5DWG9hcXovaDh2c254QWUvd1Y5TStiNUltZ1F5?=
 =?iso-2022-jp?B?VWErTzh4THNkd0dWc2gzZWJndUQwOGNhRHRNemU3TmhuWjhCK2xQSjlO?=
 =?iso-2022-jp?B?a0c4ZWRVTVhscU03VTMyeUYxUkp3b0JLay9zTmhINWxabFVpOWZMMkZo?=
 =?iso-2022-jp?B?ckxKcjA3a3R3anlyeE5Ed1hKdUdIUWRjTlB4UTExYVB3c082ZDNHejFa?=
 =?iso-2022-jp?B?YVRseWdDYUZUMlZPeWllbXNYVUJpM2pnV0xRTjZIa1J6TjRLYzNhelJC?=
 =?iso-2022-jp?B?ZTlQMTRzLzlxNFh0OXdHT2lSNS9rMzZkK1dsRmQvU0N5eXVoUVpKT01F?=
 =?iso-2022-jp?B?eGh0S0xINnpsZnBiMkYwMGw0Q2VwTGlTb2daM1IrcmxTU240RUpVSWJV?=
 =?iso-2022-jp?B?dFBhL2pQZXByZHRURk12MkNTTVlHc3kzd2VVb29TQmZFS2xRREI2VTAv?=
 =?iso-2022-jp?B?NFVrMzNuNWNKQXRQZnRjaDBTMWVEb2V3UkF6ZklxeHQ2NHVrTnNJcDlS?=
 =?iso-2022-jp?B?U3FUU2Q3UXArNUtUZGJjd01QTVFpS2pUTGdHdnNqektaaXlxQ1IzcXFD?=
 =?iso-2022-jp?B?QS9oWTRvR3hYL3UvVjM0bDlkZmc4Zk9MaWRtem95dmJpQSsvNi9WUk40?=
 =?iso-2022-jp?B?SzkxQTczcjBjVGNKYzNRUnVmSmdUcDhZa2RlZDJsL0I5ZnFDZHB4ZzlB?=
 =?iso-2022-jp?B?ZStQbnpPMXdOQVRpRWYzZG96NVhoZWsycGFJZzVVSlZsZC9uOFhINE5L?=
 =?iso-2022-jp?B?SFdjV3pUSERFZkZiemNPRUVmR1U5aVZzVWZCSG5pdFVaSVdQdVh4SDNt?=
 =?iso-2022-jp?B?d29NeE4zYmZwVnR4NnJzY1hwRlVwSDlHMXN5L3lHMS9ZaXFWUEhRSGcr?=
 =?iso-2022-jp?B?eVIyZm43a0dpYUgyNWxsWHl3Q0VEaWw1dFZkWWpmNjBNRGFrWUlXVGRv?=
 =?iso-2022-jp?B?WHZvWmFNam9INCsybjJQTWxicGxxbEhxaUhGNWxFRXo4dS80TnZpb0Y3?=
 =?iso-2022-jp?B?aEFYclo0TmV2ZmJrOVB2NXZoSDhQM2JlTmIzY3B1Y0NIeFpmWVVyYUtK?=
 =?iso-2022-jp?B?U3laYTUvMUp3VTB4ZzdiR09XcUpGNVFHUEpCSVlqY1RqM242TmtSanhl?=
 =?iso-2022-jp?B?aUJERFFGR1R3aklmQjRiOXJlVUwwcUdJelRMWk1ud1gvRENUbWppNlRt?=
 =?iso-2022-jp?B?TFIwb1VTb0lxeVVSYkZsRGJ6UStmcWFOZVlmR0haMFEyWUNGdk9JeFdY?=
 =?iso-2022-jp?B?RWl5NHYxbmtlQ0NJQ21kYU94YVdnMXRNaXBOZzVKOHJtZW9yS1lhWXU4?=
 =?iso-2022-jp?B?UmU1a3JKOTBhdHdDckFPL2FDMHNRcm9Ba3BMK0JEa2ZlMXVnYitYb0FU?=
 =?iso-2022-jp?B?SHNjWDlrTUhvejdXWGFtLy84VHNOTlZwa1J3bnBseGxYOWVqb1k0Wkxp?=
 =?iso-2022-jp?B?YnMxM2o5bmhWUG1EZmJqVmh1MkZ5TVhOVzkrSThXRllab0dOSm9lNkZj?=
 =?iso-2022-jp?B?OEtQQi9STUFWOE53Ujh1Qm8wWjdIdS9HMkRId0pKbjlaSXUyUFV2V1ZK?=
 =?iso-2022-jp?B?eERhZGQ0L0xLT0Zmc1lPUUI1Z2phS05wNGFOTS8yYUsyS3RadmRJcnFG?=
 =?iso-2022-jp?B?YUJhaWN0Y1pXc1FrcXlXd1ZmM1JzTmJjdnYzWkwyZnBpays1VGFoVVBK?=
 =?iso-2022-jp?B?Um9QOTEyZUtpa1pLUmZLZGRpQXFUUnArQlV0ZjZwdmNlem5HaHVRenpP?=
 =?iso-2022-jp?B?YytDTVBiOWs0dU43UVpiQ1FHUjNqYkt5RDdmWi96N2NlZGN3emsrMFZ3?=
 =?iso-2022-jp?B?eHB1dzJaK2tlVEVBZXRWWG44S09ORjMxZzhmT3FOUTRiNUFtU1VuZ3Ri?=
 =?iso-2022-jp?B?bi85WlNIeWVLeHBZazZEZGtZY0JwbVZzNTc0c3BZMXE1bVZFbjhoeDg1?=
 =?iso-2022-jp?B?VXVMNnR6bC9mb3V5OTVOa1FLR3A4ZkhROHVDUURKMWVHZ3JvS29SbGdP?=
 =?iso-2022-jp?B?UkdBSDYyeGd1cUJnOE0yOGpxSVNOS1VyQktyeFl2ZENEVDdFV2lZSkpx?=
 =?iso-2022-jp?B?SFNNdmxiTlJ0ODA5Zk1FZGliTXlDL2hsdERkTGNOd084Z1ZhK0VmVVFs?=
 =?iso-2022-jp?B?bmJ6VXZwTUZWY1BRNUxiaDl4RXhvVWR3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR13MB4696.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Y3BEV24ycm5nRGlGaXI4Q2VIbnB5b0RCckg1bUYzUXRCMHNrYWVHWWhl?=
 =?iso-2022-jp?B?ODVWRGZHRHNERjdOaHlxRFVPWUlGdSs0WHNKZFhUSDIydE93RDhQZVlt?=
 =?iso-2022-jp?B?TWhFSE0rdFVuZ1ZnUy9uQTdid280VVhETlFnVzZ2RGRlV0I3d0NNMmJH?=
 =?iso-2022-jp?B?M0daVnhXcVhQckEvSm81SWJvd3NCNy9jbjZ2RW5xbzlmQjlOOW5MZ05z?=
 =?iso-2022-jp?B?RU5FTkNMcFErNFlXQzdoOHpVWHdsY1E1SkEwVDh0bXE2VFdsWFNUcFMv?=
 =?iso-2022-jp?B?WnBMSnRacHlCaWhKNGwyWXVtaGc4a1V3UU4xWWN5Z3NxcU5FRGRBRHg0?=
 =?iso-2022-jp?B?eVNWeEQ1OTNjWTJMeCs0RGIrZldQa25yYjFmT09IYXN6aG9rTEVxSHk1?=
 =?iso-2022-jp?B?ZW1HaWdaamJ1Z29YVTVZYXNkVE9odm83a0F0c0lpdzNYTHhtK0ZUM0FM?=
 =?iso-2022-jp?B?OTNTVzRiSEhIcHM2djM0a3hXWjZkZXduUkZDSDcxVkdXb29hNDk2OGJS?=
 =?iso-2022-jp?B?a3B2M2ROT09XbTBQdVc5Y3lNaTFLUnVMU1E3YzBwTkpGWFhreTRwZlZ0?=
 =?iso-2022-jp?B?ZW5TSXpmRXZsMFAxNUd1NEk1clRIZFFlcExGMCs2UXRqanNVKzh1c1RZ?=
 =?iso-2022-jp?B?MVJXVjhBemw1cXNwSGJxTktEcXFoQW9KakxzVm04ZjJ2LzhBaS9iamdG?=
 =?iso-2022-jp?B?YXVuUFFyNGpoT2dDMW1aV0Rsbm9pTDM1bmF1TVZIT3pRSWJmOVpmUmdR?=
 =?iso-2022-jp?B?MldUcHR0Y2kvcUNJcktxR1ladjdXNWpNV0lSK2ZJY1o1b0M2ZzRuQzJY?=
 =?iso-2022-jp?B?cm1YQnNGcUk0YTBvTmlJMmdhakdjYk9zVVA0dStaeEtLQnE0REpJV2tv?=
 =?iso-2022-jp?B?YkRheWRERi90WW1aamhRdjc3NFljR3hnZkFMMGo2bjFCTEJHV1NvbzJs?=
 =?iso-2022-jp?B?eGcxOSswMUF3NEF3SVFySWlWaG1mOHA2KzU4QnpCRnZ4bitnMG1scmZ5?=
 =?iso-2022-jp?B?NjBqR0hCaEh6Zm1Oa1Z2TFM5VHFmTXB2ZWt1UmdMTFZMUTJVaWxpaVNB?=
 =?iso-2022-jp?B?ck5Ia0h3bWZlQTlGZ0pYWkZGQ3B2Vk9qL0JQZndNWUpwZlBvd0ZSRnQz?=
 =?iso-2022-jp?B?em5XbUNTcWdDYzdlblhHakxUbXZ3bTJVbGk0alE2UXlTUFpBNHdzUTcy?=
 =?iso-2022-jp?B?VTJoaUxOUEExZXI4ZnhkOW9aMTlsSjdiZVRQZElYcS9uRGFpZ0tiU094?=
 =?iso-2022-jp?B?aW0yYjdsQjQzWXlaRkhoWENGMWZkRkZqZlFFTEVibUpsbUNOUTBLeUNi?=
 =?iso-2022-jp?B?SUp6WFYvMnhsaFU2VDlmSWF4VDlDaTNvTXBRa1MvVjFQd052UEV3cGNL?=
 =?iso-2022-jp?B?VmZVVTg0VEViSytST2pWOEgxb1ZDNDVVekN5Zjh0RGRPMUk2ZXhkQlZj?=
 =?iso-2022-jp?B?RHc1MUUyUlJncUVQTHdVVC9JM0dXL2FvbFRFOU9ZaTk1OFdjTzcwclhu?=
 =?iso-2022-jp?B?bG1uT1lqZ1pxNVE0bkZnTGdxblZFMjVyZjN5cjRsWDlJYUl4NTBmTmRl?=
 =?iso-2022-jp?B?Wk5tREM5MmFDUkE0NHZVRlhFSWp1MHhIVXhDNDBtSFp4RThlOXN5aGF0?=
 =?iso-2022-jp?B?SDNEbG5XWjArYSs4Q0RldlRQRDlxOEJyckRmVDJYMXVNUWs5TE1laVY4?=
 =?iso-2022-jp?B?bkI4Wm5zVEhSRitSK2c2MjhCOWV4V050aWdMMHVuVWlNcjlQMU0zMWFq?=
 =?iso-2022-jp?B?aEJlNXBCY1lScEVtS0llbDBWb1p3cS9RVDdQK3ZnL0NJMkcwQ3puYndw?=
 =?iso-2022-jp?B?aWNMTWF3Qjc0MERlWm9wL2w0WndGVGxGS05OQkNWeG9DRTdjV3pUZHpT?=
 =?iso-2022-jp?B?NHNkSEdBa3BjWGZpVjdjODdUaEZlVUY0TUhQUzc4MXZTUGwzR0tOR1U0?=
 =?iso-2022-jp?B?TzRKSk1qaUl4VU1nSmNsUGVlZ1pXZjMvTzlacmZ0L240NnNaVGxiT3hY?=
 =?iso-2022-jp?B?a3hrcGE1cXhrZm1tZjBIbFlRRDg0Q3d1ZHVEaEZxNFR5RFVuOXBUeitw?=
 =?iso-2022-jp?B?WGdtUXdQYlJ3OFV5T0N4UUhWL0FUMXhWMUlMNk5aSzl5TUU4OUZJMzIz?=
 =?iso-2022-jp?B?UFdJTENrcDhhNnpYdzVLMC82S09IOWxnNVo0YUlSL3ZKQzV2dlBRSE1T?=
 =?iso-2022-jp?B?d0Z5SmxHOE5SeWJIdXFuNHloMzVpcVdaWkZLR1U1dGFYbVNZRndZZUxv?=
 =?iso-2022-jp?B?ZWIrU1FWWjNOcW0vcDVNY2xlQi9FNkw5QWpWeHRaMjFwS2pleVdRSFBs?=
 =?iso-2022-jp?B?d0VIRGJ2a3Ftb2RCMytmdHI3Y2xsZzNrVXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR13MB4696.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07769a6-f7a6-4aef-c247-08ddfbdf136b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 02:56:07.8555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: baMiVjQCwS3qYJURROgTzt4tPmeYN0R7Y28vXCRNo3UPbAsnOYihDbaxmZPAK3zpFn6LwO2k7ImeoqAgBCkjhrdO6dCwp2hAHHn3gBTBmzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6455

> -----Original Message-----
> From: Mike Snitzer <snitzer@kernel.org>
> Sent: Wednesday, September 24, 2025 12:56 PM
> To: NeilBrown <neilb@ownmail.net>; Chuck Lever <cel@kernel.org>
> Cc: Jeff Layton <jlayton@kernel.org>; Olga Kornievskaia
> <okorniev@redhat.com>; Dai Ngo <dai.ngo@oracle.com>; Tom Talpey
> <tom@talpey.com>; linux-nfs@vger.kernel.org; Chuck Lever
> <chuck.lever@oracle.com>
> Subject: [RFC PATCH v3 4/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
> (v3 and older) [Was: "Re: [PATCH v3 3/3] NFSD: Implement NFSD_IO_DIRECT
> for NFS READ"]
>=20
> On Wed, Sep 24, 2025 at 11:18:53AM -0400, Mike Snitzer wrote:
> >
> > FYI, I've been testing with NFSv3.  So nfsd_read -> nfsd_iter_read
> >
> > The last time I tested NFSv4 was with my DIO READ code that checked
> > the memory alignment with precision (albeit adding more work per IO,
> > which Chuck would like to avoid).
>=20
> We could just enable NFSD_IO_DIRECT for NFS v3 and older. And work out
> adding support for NFSv4 as follow-on work for next cycle?
>=20
> This could be folded into Patch 3/3, and its header updated to be clear t=
hat
> NFS v4+ isn't supported yet:
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c index 96792f8a8fc5a..459a29f37=
7c2c
> 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1182,10 +1182,6 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp,
> struct svc_fh *fhp,
>  	case NFSD_IO_BUFFERED:
>  		break;
>  	case NFSD_IO_DIRECT:
> -		if (nf->nf_dio_read_offset_align &&
> -		    !rqstp->rq_res.page_len && !base)
> -			return nfsd_direct_read(rqstp, fhp, nf, offset,
> -						count, eof);
>  		fallthrough;
>  	case NFSD_IO_DONTCACHE:
>  		if (file->f_op->fop_flags & FOP_DONTCACHE) @@ -1622,8
> +1618,14 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	file =3D nf->nf_file;
>  	if (file->f_op->splice_read && nfsd_read_splice_ok(rqstp))
>  		err =3D nfsd_splice_read(rqstp, fhp, file, offset, count, eof);
> -	else
> +	else {
> +		/* Use vectored reads, for NFS v3 and older */
> +		if (nfsd_io_cache_read =3D=3D NFSD_IO_DIRECT &&
> +		    nf->nf_dio_read_offset_align &&
> +		    !rqstp->rq_res.page_len && !base)
> +			return nfsd_direct_read(rqstp, fhp, nf, offset, count,
> eof);
>  		err =3D nfsd_iter_read(rqstp, fhp, nf, offset, count, 0, eof);
> +	}
>=20
>  	nfsd_file_put(nf);
>  	trace_nfsd_read_done(rqstp, fhp, offset, *count);
Hello,

I wanted to contribute some reproducible data to the discussion on=20
NFSD_IO_DIRECT. With a background in performance benchmarking, I ran fio-ba=
sed
comparisons of buffered I/O (Mode0) and direct I/O (Mode2). The following=20
write-up includes the problem definition, configuration, procedure, and=20
results.

---------------------------------------------------------------------------=
----
Problem Definition
The primary motivation for NFSD_IO_DIRECT is to remove page cache contentio=
n=20
that reduces overall read and write performance. We have consistently seen=
=20
substantially better throughput with O_DIRECT than with buffered I/O, large=
ly=20
due to avoiding contention in the page cache. While latency improvements ar=
e=20
not the sole goal, they serve as a clear indicator of the performance benef=
its.

Why dataset is much larger than memory (and why 3.125x)
    - Goal: ensure the server cannot satisfy requests from page cache, forc=
ing=20
      steady-state disk/network behavior rather than warm-cache artifacts.
    - Sizing: dataset ~=3D 3.125x server RAM. With 1 TB RAM and 32 jobs, th=
is=20
      yields ~100 GB/job (total ~=3D 3.2 TB). The 3.125 factor is a conveni=
ence=20
      that produces even 100 GB files; exact factor isn=1B$B!G=1B(Bt materi=
al as long as=20
      dataset >> RAM.
    - Effect: Buffered mode under memory pressure shows elevated p95?p99.9=
=20
      latencies due to page-faults, LRU churn, writeback contention, and=20
      reclaim activity. The NFSD_IO_DIRECT read path bypasses these cache=20
      dynamics, which is why it reduces tail latency and increases sustaine=
d=20
      bandwidth when the system is under load.
    - Concurrency mapping: 32 jobs/files ensures 2 files per NVMe=20
      namespace/share (2 * 16 =3D 32), balancing load across namespaces and=
=20
      preventing any single namespace from becoming a bottleneck.=20
      (This is primarily due to my test environment being designed around=20
      pNFS/NFSv4.2 for metadata path but uses NFSv3 for data path)

Aside: Dataset fits in memory (~81% of RAM)
    As a control case, we also ran tests where the dataset was only ~832 GB=
, or
    ~81.25% of the server=1B$B!G=1B(Bs 1 TB RAM. In this in-memory regime, =
buffered and=20
    direct I/O produced nearly identical results. For reads, mean latency w=
as=20
    1.33 ms in both modes with negligible differences across percentiles. F=
or=20
    writes, mean latency was 1.76 ms in both modes with only fractional=20
    variation well within measurement noise. Bandwidth was likewise ~97?98 =
GB/s=20
    for reads and ~72?73 GB/s for writes, regardless of mode.

    CPU utilization during this in-memory run further illustrates the dynam=
ics:
        - Writes Mode0 ~91% total (38% system, 50% iowait, 2.6% IRQ)
        - Writes Mode2 ~79% total (9.4% system, 68.4% iowait, 1.8% IRQ)
        - Reads  Mode0 ~52% total (50% system, 0% iowait, 1.4% IRQ)
        - Reads  Mode2 ~72% total (11.5% system, 59% iowait, 1.9% IRQ)

    Even though throughput and latency metrics converged, the CPU profiles=
=20
    differ substantially between buffered and direct modes, reflecting wher=
e=20
    the work is absorbed (system vs iowait). These results confirm that=20
    NFSD_IO_DIRECT does not hurt performance when the dataset can be fully=
=20
    cached; its advantages only emerge once datasets exceed memory capacity=
=20
    and page cache contention becomes the limiting factor.

---------------------------------------------------------------------------=
----
Hardware / Software Configuration
    - Data Server: Supermicro SYS-121C-TN10R
        * CPU: 2x Intel Xeon Gold 6542Y (24 cores/socket, 2.8 GHz)
        * Memory: 1 TB RAM
        * Storage: 8x ScaleFlux 7.68TB CSD5000 NVMe SSDs=20
          (each exposing 2 namespaces, 16 total)
        * Each namespace formatted with XFS, exported via pNFS v4.2
    - Metadata Server: Identical platform with 8x ScaleFlux 7.68TB CSD5000=
=20
      NVMe SSDs, acting as a pNFS Metadata Server (Hammerspace Anvil)
    - Client: Identical platform minus local NVMe
    - Data Fabric: 2x ConnectX-7 NICs, 400 GbE with RDMA (RoCE)
    - OS: Rocky Linux 9.5
    - Kernel: 6.12 baseline with NFSD_IO_DIRECT patches applied
    - Protocol under test: NFSv4.2 was used to mount all 16 namespaces unde=
r a
      single mount point via pNFS (layouts/flexfiles). However, the underly=
ing=20
      storage traffic exercised NFSv3 shares, so effectively the test behav=
ior=20
      reflects NFSv3 with NFSv4.2 coordinating access.

---------------------------------------------------------------------------=
----
Test Procedure
The test methodology was automated using a wrapper script=20
(nfsd_mode_compare_fio.sh). Defaults were used without overrides.=20
The procedure was:
    - Compute per-job file size so the aggregate dataset is ~3.125x larger =
than
      the memory on the NFS server (default: 1 TB =1B$B"*=1B(B ~100G per jo=
b for 32 jobs).
    - Build fio commands with:
        * --numjobs=3D32, ensuring two files per NVMe namespace/share=20
          (2 files =1B$B!_=1B(B 16 namespaces =3D 32 total)
        * --bs=3D1m, --iodepth=3D2, --ioengine=3Dlibaio
        * --direct=3D1, --runtime=3D600, --ramp_time=3D30, --time_based
    - Files created in ${MOUNT_POINT} using format testfile.$jobnum.$filenu=
m
    - Two threads per file: the second thread starts 50% into the file.
    - Pass 1 (mode0): Set remote io_cache_read/io_cache_write to 0, run wri=
te=20
      then read.
    - Pause 60s between runs.
    - Pass 2 (mode2): Set remote io_cache_read/io_cache_write to 2, drop re=
mote
      NFS server's page cache, rerun write and read.
    - Results captured as JSON and summarized into bandwidth, latency=20
      percentiles, and comparison tables.

---------------------------------------------------------------------------=
----
Results (Executive Summaries)

--- READ Executive Summary ---
Key                                mode0                mode2
------------------- -------------------- --------------------
Bandwidth (GB/s)           18.51 (+/-0.19)        97.86 (+/-0.01)
Mean Latency (ms)          7.21 (+/-15.30)         1.33 (+/-0.25)
Max Latency (ms)                 3113.78                37.40

--- WRITE Executive Summary ---
Key                                mode0                mode2
------------------- -------------------- --------------------
Bandwidth (GB/s)           34.20 (+/-0.25)        72.70 (+/-0.01)
Mean Latency (ms)           3.84 (+/-6.54)         1.76 (+/-0.47)
Max Latency (ms)                  199.07                25.68

CPU utilization during 3.125=1B$B!_=1B(B dataset runs:
    - Writes Mode0 ~83% total (79% system, 3.5% iowait, 0.98% IRQ)
    - Writes Mode2 ~79% total (8.9% system, 68.7% iowait, 1.8% IRQ)
    - Reads  Mode0 ~99.5% total (97.1% system, 1.7% iowait, 0.76% IRQ)
    - Reads  Mode2 ~72% total (11.8% system, 58.1% iowait, 1.9% IRQ)

The improvement on reads is more than 5x in bandwidth with far lower tail=20
latency. Writes also show significant gains, indicating the direct path is=
=20
valuable for both workloads.

Here is a link to the full results as well as the scripts used to
generate this data, with a README describing how to reproduce the tests:
https://drive.google.com/drive/folders/1EbIAmigAv1KbE37dp2gRh_lCKIBxn2RM?us=
p=3Dsharing
(I highly recommend reviewing the detailed results and the latency distribu=
tions)

These results support enabling NFSD_IO_DIRECT for NFSv3 now, as Mike
suggested. The benefits are clear and measurable. I agree that NFSv4 can
be addressed in a follow-on cycle once the alignment/validation work is
sorted out.

Happy to rerun with different parameters or workloads if that helps.

Thanks,
Jonathan Flynn


---------------------------------------------------------------------------=
----
Share file list:
3.125x_memory
    grafana_screenshots
        cpu_nfsv3_server.jpg
        memory_nfsv3_server.jpg
        nvme_nfsv3_server.jpg
    logs
        command_used.out
        detailed_results.txt
        fio_20250924_181954.log
        fio_20250924_181954_read_mode0.json
        fio_20250924_181954_read_mode2.json
        fio_20250924_181954_write_mode0.json
        fio_20250924_181954_write_mode2.json
        what-if.out

0.8125x_memory
    grafana_screenshots
        cpu_nfsv3_server.jpg
        memory_nfsv3_server.jpg
        nvme_nfsv3_server.jpg
    logs
        command_used.out
        detailed_results.txt
        fio_20250924_230010.log
        fio_20250924_230010_read_mode0.json
        fio_20250924_230010_read_mode2.json
        fio_20250924_230010_write_mode0.json
        fio_20250924_230010_write_mode2.json
        what-if.out

analyze_fio_json.py
nfsd_mode_compare_fio.sh
README

