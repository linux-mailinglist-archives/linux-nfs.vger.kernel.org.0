Return-Path: <linux-nfs+bounces-10950-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BECFDA750DA
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 20:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA4F3B0287
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 19:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7084A1E1E05;
	Fri, 28 Mar 2025 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Igdod6G2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2113.outbound.protection.outlook.com [40.107.236.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C09E1E1DED
	for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190625; cv=fail; b=jSbq2JwiQ3VK8uZq4XN0U2NDW4xm4/vFQeBi6jDGO9PcRaZ14YSbMZ4gAP1M5nczair+YikWYYYZf9nisZG/bOS9YFxrGPfifk14mqOrl4RHsekfNBEJ1XVQj63ER0hy2Yina05ZWIHTOfYNc2UdoL8GwjEvyQ19jcNC//mcVnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190625; c=relaxed/simple;
	bh=AF3BqQBTwUF1zNfdjqs3e/skQZbFqRMa9HIgQDd/FvU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uCiAIEmpQ3UCLbrwbQK0godxN3oBJnuNX+O9D8gFaBkZlRDho0HSh+ZuxiXD0pgW6mI2WKTsR0tMxeyes7yAhM89RAlXFiBEXuOMP8owmuPuSy9aJpTisRXcp00uBk3XW1dYPAD8zMPfQZLxd4/UdJn0bedkcaTjZv4aa68vX3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Igdod6G2; arc=fail smtp.client-ip=40.107.236.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBCy0iJVeleUcCbAHm0niWRebSQB4iOpggMLe/2AQahug75S3JNW10YSjGADYkJb4S5wU7XQ9sHZDgkTOqaKJz3vkVevb5BVxNjo7i59bBvewNCvo/Ebx1dnr7rcxqOmNhcVX5TR4Ik2pz42IBWbmDXWHKfYFNQ0SvsDnRozr6YJ6Fspc3hgyJ/7reNV5FTcK5b/CHAy/tj/YBEawoL18+yirA9CgpFtHyyVcm8qJjPRKs93L0n90gUBW9KJT8wN/0WMFVYNDzOHx1u4wn9GHmHNOS98+saJ5CoWnqMMxGlOu0xSNDxVW408GXNxxq5uEZXK6kEpfij8LiJoDymwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF3BqQBTwUF1zNfdjqs3e/skQZbFqRMa9HIgQDd/FvU=;
 b=Hw4aenxK1ly5dzDJ8BB3mLFg/CyGfQtr22cDIfmGIjQ3cUq7aRKa3ymewxl7YKDYXsvp6jHwJvUKbNE8w6zoloaUHWgFfBBnhRn2IkZ//L614Yn2CQBy+IC4FgOyO1XG7XrBgmHgNWqe8SryWfmCVlbqQ/jGO3Yt5+kuEx1Zia8fJU78Nv+OU1DrxqiuKPONsQ67mQfGJwSXfMcVgQKG3ZSHrHCOIA7i/gHtLHHSPIPCXTPQ4uWWZuBCyQc6XDVqv1h9Tv465KLenh+LHM5DsDykcMAXveWte8HPH/LzzNlS5n4DwqcvyRftUF5HhIw4fhLs5xpYqc+kUWztWHlXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF3BqQBTwUF1zNfdjqs3e/skQZbFqRMa9HIgQDd/FvU=;
 b=Igdod6G2hQPWn8dO5ohCPHaYnZErfWyN5qVj6zmQA6HMoDnHG4dWKlrLV3FTQQDBPmXSU75eyofDWu528Me2OJCZ3aQTb0GPQtBMxy6ImFJ0S4UIC7F8hTx6aVeiBbInO7MiNaSFEE7ixVqFSDTvWbExEBAyBmJ9ecx4PE2WEGs=
Received: from BL3PR13MB5073.namprd13.prod.outlook.com (2603:10b6:208:33c::7)
 by SA1PR13MB6767.namprd13.prod.outlook.com (2603:10b6:806:3eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 19:36:59 +0000
Received: from BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::b148:fe5d:ff6a:6310]) by BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::b148:fe5d:ff6a:6310%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 19:36:58 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
Thread-Topic: [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
Thread-Index: AQHboAiPGcKqnENVnEOPq33w2Lzm6LOI2SGAgAAYVQA=
Date: Fri, 28 Mar 2025 19:36:58 +0000
Message-ID: <29a3ff4f059fe3900b59ec7bb25d879854d29727.camel@hammerspace.com>
References:
 <f301a88d04e1929a313c458bd8ce1218903b648a.1743183579.git.trond.myklebust@hammerspace.com>
			 <26602925a3b7623c17c58cc9d5adeddde95e70d6.camel@kernel.org>
		 <653869b6e69d65b0314e133b901d670968d7b345.camel@hammerspace.com>
	 <e8dd5ab70e23cbba22dae76acf52884f0676d81a.camel@kernel.org>
In-Reply-To: <e8dd5ab70e23cbba22dae76acf52884f0676d81a.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR13MB5073:EE_|SA1PR13MB6767:EE_
x-ms-office365-filtering-correlation-id: e58cda3a-8cda-48e5-f2e5-08dd6e2fe7ba
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SmJReEZ5WDVGcnNYeTRWOUtPWFBNaU9lK1RYWGV5OExqWVpQRThqQ2RMd0Ja?=
 =?utf-8?B?MUF4cmNDZHVLUkU1SG40S3I4bk1mMys3TlpweC9UekN1TFZiR1ZWRXAvM1hM?=
 =?utf-8?B?cEdnY29NdlN0RnB0UmdJRktnTWZGWFRuc0hOVUg1SllvNlJKL0ZDRFBtREhm?=
 =?utf-8?B?T1NheDZnN3RMNTZUa3NPSWZ5My9kQUIvUTJaSWdSaVhtcVUwL0pJQXZ3RDNp?=
 =?utf-8?B?V0NzMVh5UFlpWllXZENwZTMwZ1dGT1pJMzZIOUhVZHZSRzZldzhodHNDM1R0?=
 =?utf-8?B?L1JMK01CZ1dkQlF1cDJid2dwcXZxY2xRRFZjV1drd3JFQTdXQ1RVcVVKWWQw?=
 =?utf-8?B?dnBoV0ptWWRzd09TUGF6S05FWERyRzBjQTZSdWJLNHJPVWJyNWZEQUk0Nk9t?=
 =?utf-8?B?ZFZmVjl0cTM3SnV3enUrQzBidXhyQmdSajRhRlhYMHEreFdoWlZTNkcxUW9O?=
 =?utf-8?B?YmRKTVJvWXZMZVB4czNhdnlLb0N1VDMyUmZBZkptTUtxRnRUd3cwVGFRdHJp?=
 =?utf-8?B?MFdSMW8zdmhvbTdObjBhM0hYTHh3Q2k4dnlwWS9SVHM0ZDY1eGpuMFhZNWVZ?=
 =?utf-8?B?TlA5VEVQQUxhTnVNVmZycXM2YXdqanVEckRWQWQvMm8wTEp1bERrSCtoWnJm?=
 =?utf-8?B?Y1JodmxQRTJiMVJ4OU1uOU8yQlRZckJFbndiVnFwbnVrSU0xVWZPV1VSbGpD?=
 =?utf-8?B?RHhCdGQ5WUxvZTFnVjhDdFhRMjV1OVBBQ1B5V3VNYTZCT2RlWHRoZ1Z6bHJK?=
 =?utf-8?B?WHpSMzlib21PZjBJNWxRRTBydkNRbklMY0hTNGN1Z2JrblRGVkJTMWV0SmNp?=
 =?utf-8?B?TUx5VUZaUElJSXh1R2UxMlRXNTNybERVSXI2RjhFU0NzRVllYndzSmFWb1VP?=
 =?utf-8?B?MlF6cUZNMVhpOC92emdPZVEwVjhHa0NLTXlCYXpvSXNWNUVxMlh5ZUZvT0p3?=
 =?utf-8?B?d0hMNllvQXdYTjBOcnJKM2J0dkVaeGExcE5DTURXZnI5b1dPYzJwZGpGaE1R?=
 =?utf-8?B?b3dPeFpXbHpvR1pvb1NpSTB0Zk9BZ2RDQ3NzL0V1cStGUG0vWG42emtYMVdl?=
 =?utf-8?B?U0RkenRoa1R4MUFkaUt2UXBSOXFXSXBubVF0Tld2d0d6OURjcWhZYnEzbEdh?=
 =?utf-8?B?Z3lDcjl1OFQvcWgxcDdUaFZCdjlKUTFBaXEwWHhFajloSEJyRUlrUGw3aEpF?=
 =?utf-8?B?dVFJMENsU1Y5UGVGRDV4ZDE3OCtUOHhteWJKSVF1Zm5sOG9ud2VodW1nbGoy?=
 =?utf-8?B?YThWY2ZpMTdyQ3FIQldUanAyZmxhd1NUMDBiQmpMaGxhUGJhYlNiRjNmWHBp?=
 =?utf-8?B?QkZQU0cvUVluUzUwRWZlQUhoQ2s0aEEyWEo1RmFNOFViYXNLL1E5WU0yWWhy?=
 =?utf-8?B?UHc0L0J4d1dFNHRoQlprR2sxUnlIVUlROUhZSnFqaHc0RnJRZnFKd1BueHox?=
 =?utf-8?B?c1Zlbm9PZ3JwNGdVL2JGZVVKeWpKZ2JJKzJBdHorb3l1cS9kRHpVVnhPd2dn?=
 =?utf-8?B?cnFqbnZYYzk5THhXREsxd0NreGxYSThCOThGYkRUNDlKWm5SR0pLdVZhcCts?=
 =?utf-8?B?cThORDVxUWEvZC8xNFYyR29JUXBlbkRaS3JNeGlaMUhjT3dabmo0b2dJVzlm?=
 =?utf-8?B?MFdFYVVjMWZ5V2JLd3dkQi90TmgwSmVMM3lHU2VVK3B0cWhxR1dOS0wwQjVp?=
 =?utf-8?B?aWZoRXZveEM1d0wwbjdNbU5UNlFUZ1FaNWdiSTFCT040WjJsUjkwMXIyUXpH?=
 =?utf-8?B?U3N3TXFZUjE0OHk5NGVNamdUUFpjWGN4dzE5QWNKRjVDTjNSVmtFeE5oMDBz?=
 =?utf-8?B?QTVOUVArd0VrWW9TVEk2UEdHOUtkSENQTXhJMGF1enY3eU1FcXNNZmlvbmJU?=
 =?utf-8?B?Z1grd0ZCMFUyUFNtbVRWV1FQUTA0d1pWUCt4NXdTK085VXplb3pWOVhzM0VX?=
 =?utf-8?B?cmZHdkRvVm9ac2crcGxGOE9PRFZ2NCtYbUdvNXZIWGlKSDZ3aUErZUpQTlFI?=
 =?utf-8?B?aXoyKzBoWVBnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR13MB5073.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGd0TmhNREl5SGNhTU1lQk8ySk9IZ0dEa1VPNzhwMUE3b1lOQlFSdFg3R0RS?=
 =?utf-8?B?MTQwcG9INWNuTnZ2cHo1Um01VjMxbUl4bmI2UUd1ZE5keWdkQy81YWF2K1dP?=
 =?utf-8?B?Wll6WHRTdngzQXNnWWR2VFUvejlaVlBQb3U4UkJFQSt0Rjhzb2JPbnF1TUpY?=
 =?utf-8?B?Tnp4eTkxNnhTT1hEakNBOFhxanQwclhIckVwalROMElDdjFPOGtWTU5Tek5C?=
 =?utf-8?B?ZTJQL3JLN3djUURNazBMWU5Hblo5OXQwYkRXekgvdXB6UlpDYTFmZ1EvN2Rq?=
 =?utf-8?B?R2l0cnFRdzBucHBZWndhY1Q0N2xZY3R5cWdIRHBJNW5sZWE3T2RBaSthMDZw?=
 =?utf-8?B?VjlwSndlTU5jMjVvakIyVnNZY0JndmNlL1ZqNWxFZktMQXE2T0NTNi9Fdm5h?=
 =?utf-8?B?ZzR2OW1TQW9mTFRaaEllRFFEdTlaVU9TcWR6bVc2alFGdVUzWk1ZTlJGaFV0?=
 =?utf-8?B?UTY3aW52ZzdwWDMvTjNacXhnZEFoV21DbklXWTFwUDFGVUhraEN3NkNBVm1n?=
 =?utf-8?B?eElhS1BINzZyR0kvZlJ6OXBwMGdqR0R0NnVjbVpLdE1ZVUQ3Q0VMb1dmc05W?=
 =?utf-8?B?V1E2K2pPVVljTzE3L0JSNHhuei8wUGZvbnVRTkVMeUNXUzVaK2NYNE50eVFt?=
 =?utf-8?B?QTVzcytrWnY0ZlNqaXp5OGNoYmRwcnpmWWMrNzYwelg4YUdzSkNOb2F4ODlj?=
 =?utf-8?B?QjVoMmtMUUJyR0FDMHdZa0ZudjNjOFVyY1BNaEVRUHNPU0c1Qm1VV2NUZXor?=
 =?utf-8?B?TDBXcmo1Tnc4KzE0dDdYY1BJUEFVMmhrTG1uQWZSQVB5ay9GTFVPdHgreGJH?=
 =?utf-8?B?cFAxbFVwMUxMV3hETzFjdllHOSt6anFJMXVXbFVzTGdjMG9yY2hpOHpPL0R0?=
 =?utf-8?B?R291aDZkTm4zNHJabzRqRmd4YW1WZmdOaXlKbTBqT1YwNkNtZ2dYSWNJWWd2?=
 =?utf-8?B?dHNIRHRhbmFEVlNvck9wcXlzc0FFTkI0eFhwL2tVQXpiam5EK3M0UEl0bVJH?=
 =?utf-8?B?RkM0UEY4d1hLamZ0THBrZlNYUXRyVkZGWVJWZXRJUDBtUzlyZnZvZzlCWG1w?=
 =?utf-8?B?N0JCVXhyTmVqMFY4OGNVRmRuTHNseXB0Nk1tMkhZV2JCODd0MFM4STJIWjJo?=
 =?utf-8?B?Q3dIaE5BZWllN1VuUGZlUFh3MEI1QmRFbnBydm5QM1p4TU5JdkFjQThSYnE5?=
 =?utf-8?B?M0NSSXlkNDc3T2p5USttUVVXTStGcVc0ZUh1alNwZWRMWDlla0F3YnFtM3Bs?=
 =?utf-8?B?ejZ5WllleTh4cnhJSTd6dzh4blNEY0ZiZ2VyVW53Nk01S2RIWnRIVmpsSGZt?=
 =?utf-8?B?L1VPKzRxUTI3TjlhcEdkYVdBVWk2UW94L1VHM3JvbjRvRFJXM1h5NDBoWFNr?=
 =?utf-8?B?L3NIcXVKLzdiNG9Qb2F0WXpEYnFCOGVnRkVhekxyMEVDcUtvbk1BcDNNNTFo?=
 =?utf-8?B?dVRUZ1ljLzkrRnV1ajV3aDhUSjhVTnZQclQ2QVRGZWlvTmxPS3hmRWp0R2R0?=
 =?utf-8?B?U3JJeVFRNHdVL1FkM3k4alJyZ0JacjlXSnNSRjd0TytFK2dDcXNJcVdoekU3?=
 =?utf-8?B?V042N3p3YTBxTkxDY1NPZ2hsdXdFcWdxSklDc0ZDcXZwNEFWajVZQUxUUmNi?=
 =?utf-8?B?cFlkeUZVUVJzVXNSbmhkSjNma1hTbVlBL3ZZWDhWa3BDMU9TWVFOY2NJdzZr?=
 =?utf-8?B?Q2huL0ZzWlI1aUJsVERDUUN5MVN2WnFReE9TRzlFQ0wxQkFwbXAyNS9ZM01K?=
 =?utf-8?B?ZWw1NHh5dUE5SGxrdEVtZ0M3Z25KL09QWkEvMnBXN0VkZlBUV3NOTXcrbzFm?=
 =?utf-8?B?N0l6MXpsaW9hNzloT2cvT1g2N011ci83T2xVSEt2UmNjOXJGdlVjWUxmK0NU?=
 =?utf-8?B?Z0RzNFphb3ovcm4zdFJ1bUg3Y21QdHo3RnRsbWtqMUpudGlBaGlxVm02RklH?=
 =?utf-8?B?R05nUzdsUnR2bjBDdnhzUXVIQ3VLRHJMZTZSMHVIOWJ3YjFaa296MGcrSWVP?=
 =?utf-8?B?Nmo0WVdiZlpNQlM0WWphS1Z6UjJLbmxtcFo4L0pvRFgzRkJTOFlnWFFmWHli?=
 =?utf-8?B?RGhIcDh3VUJGbVVXMnNoM2h4TGZjaGtRUzJpMXdpWTNLd1oybWJTZk9BSW55?=
 =?utf-8?B?aDMzNWJMSFVRSWI1eCsyeWZrcXVGNFFIbUM2d0VoQXhORFY3clY5cC9sRFpG?=
 =?utf-8?B?NFN2ZHlLTkpoNDhwWVBVbGZtZThVbGtqM2R0elpsbTJnUG9DdlNlcFg5bWdn?=
 =?utf-8?B?WTh4N1dwMnhZanNvcnRuNEN2SjR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2876D7230F04EA489B3BBCA58CE897FA@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e58cda3a-8cda-48e5-f2e5-08dd6e2fe7ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 19:36:58.6255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H805ALQ2PxxQttPgAFOn1oZKa448hTg91AtBVF+6N9zyPTkgZ/KUHfFlI+niR8Jfe22E0ti2jsKU39G2gNaxnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB6767

T24gRnJpLCAyMDI1LTAzLTI4IGF0IDE0OjA5IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gRnJpLCAyMDI1LTAzLTI4IGF0IDE4OjAwICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gRnJpLCAyMDI1LTAzLTI4IGF0IDEzOjUzIC0wNDAwLCBKZWZmIExheXRvbiB3cm90
ZToNCj4gPiA+IE9uIEZyaSwgMjAyNS0wMy0yOCBhdCAxMzo0MCAtMDQwMCwgdHJvbmRteUBrZXJu
ZWwub3JnwqB3cm90ZToNCj4gPiA+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gT25jZSBhIHRhc2sgY2Fs
bHMgZXhpdF9zaWduYWxzKCkgaXQgY2FuIG5vIGxvbmdlciBiZSBzaWduYWxsZWQuDQo+ID4gPiA+
IFNvDQo+ID4gPiA+IGRvDQo+ID4gPiA+IG5vdCBhbGxvdyBpdCB0byBkbyBraWxsYWJsZSB3YWl0
cy4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdA0KPiA+
ID4gPiA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4g
PiA+IMKgbmV0L3N1bnJwYy9zY2hlZC5jIHwgMiArKw0KPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9uZXQvc3Vu
cnBjL3NjaGVkLmMgYi9uZXQvc3VucnBjL3NjaGVkLmMNCj4gPiA+ID4gaW5kZXggOWI0NWZiZGM5
MGNhLi43M2JjMzkyODFlZjUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL25ldC9zdW5ycGMvc2NoZWQu
Yw0KPiA+ID4gPiArKysgYi9uZXQvc3VucnBjL3NjaGVkLmMNCj4gPiA+ID4gQEAgLTI3Niw2ICsy
NzYsOCBAQCBFWFBPUlRfU1lNQk9MX0dQTChycGNfZGVzdHJveV93YWl0X3F1ZXVlKTsNCj4gPiA+
ID4gwqANCj4gPiA+ID4gwqBzdGF0aWMgaW50IHJwY193YWl0X2JpdF9raWxsYWJsZShzdHJ1Y3Qg
d2FpdF9iaXRfa2V5ICprZXksIGludA0KPiA+ID4gPiBtb2RlKQ0KPiA+ID4gPiDCoHsNCj4gPiA+
ID4gKwlpZiAodW5saWtlbHkoY3VycmVudC0+ZmxhZ3MgJiBQRl9FWElUSU5HKSkNCj4gPiA+ID4g
KwkJcmV0dXJuIC1FSU5UUjsNCj4gPiA+ID4gwqAJc2NoZWR1bGUoKTsNCj4gPiA+ID4gwqAJaWYg
KHNpZ25hbF9wZW5kaW5nX3N0YXRlKG1vZGUsIGN1cnJlbnQpKQ0KPiA+ID4gPiDCoAkJcmV0dXJu
IC1FUkVTVEFSVFNZUzsNCj4gPiA+IA0KPiA+ID4gV29uJ3QgdGhpcyBtZWFuIHRoYXQgaWYgYSB0
YXNrIGlzIHNpZ25hbGxlZCBhbmQgZG9lcyBhIGZpbmFsDQo+ID4gPiBmcHV0LA0KPiA+ID4gdGhh
dA0KPiA+ID4gYSBDTE9TRSBzZW50IGluIHRhc2tfd29yayB3aWxsIG5ldmVyIGdldCBzZW50Pw0K
PiA+IA0KPiA+IEl0IHNob3VsZCBtZWFuIHRoYXQgdGhlIGNsb3NlIGdldHMgc2VudCwgYnV0IHRo
ZSB0YXNrIHdvbid0IHdhaXQNCj4gPiBmb3INCj4gPiBjb21wbGV0aW9uLg0KPiA+IA0KPiANCj4g
R29vZCBlbm91Z2gsIEkgZ3Vlc3MuDQo+IA0KPiBSZXZpZXdlZC1ieTogSmVmZiBMYXl0b24gPGps
YXl0b25Aa2VybmVsLm9yZz4NCj4gDQoNCkl0IGVuc3VyZXMgdGhhdCB0aGUgdGFzayBjYW4gZGll
LCBhbmQgd2l0aCB0aGUgYWN0dWFsIGNsb3NlIFJQQyBjYWxsDQpiZWluZyBhc3luY2hyb25vdXMs
IGl0IHdpbGwga2VlcCBnb2luZyB1bnRpbCBlaXRoZXIgdGhlIHNlcnZlciBjb21lcw0KYmFjayBh
bmQgcHJvY2Vzc2VzIGl0LCBvciBzb21lb25lIGZvcmNlIHVtb3VudHMgdGhlIHBhcnRpdGlvbiBh
bmQga2lsbHMNCnRoZSBjYWxsLCBldGMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K

