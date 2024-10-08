Return-Path: <linux-nfs+bounces-6938-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 350219950AC
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 15:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A95AB2332B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 13:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF47E1DF27A;
	Tue,  8 Oct 2024 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hDL5Snmz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tMBKgPfN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA71DF25D
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395491; cv=fail; b=ebHN7LjGDGopK7cfvD4tZ1+uh3lS/lU8mBQmZIGBR3u2nk0f5WGforyseTRECGlRalSvLICyFe1Y5fK6j63e/iCdUlyjXrbYQ1cuffTBSsRPuqKjuf+1vDE7VaksX0nkRF+/YIMBk08hiQrZ0VsSW3b8CiU6fIxNYEdP4EHmD70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395491; c=relaxed/simple;
	bh=7qHNIZmpg2VeP8XqPv99YJaoA6FlIvtRve4KQKLGs2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=loy689hEa5Sx+esDH7Y1aUaw4HBVWWQEaTwKQ9cKUPa5T+P5qq20nD4kcs2fYHTLjVAJwyX/yvLoQyKHd52oFTDV56CcWbacPaY0HTlS0FQQiWg1iXNG2IrvxoL1BqVNuA0YYnnLQyrnfepJFmzq57Hvf8tsa0UD1fTEZi4IQAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hDL5Snmz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tMBKgPfN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498DfZMU010041;
	Tue, 8 Oct 2024 13:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7qHNIZmpg2VeP8XqPv99YJaoA6FlIvtRve4KQKLGs2g=; b=
	hDL5SnmzVhZoXwOS3TjQphdQPuQTFyz0sThiEX7MkTxpxiROjcIN50YioiCQNsfH
	qsARpbH5yDMDvckmTvjsZLj1B7Z2s2zZt/CaAciAjA3NErsnRiXeB7mA5zG79VxB
	M80gJrnzQZc6N/9Hjt9AdT/fU69UyDYUJrw4otphgLdDXevwv+3BSRLtpYmkbVpW
	gGPStAF8TxlQr0/gE6odAp9lrk1udpLvm6rZl7SappIY9WYf0NCZbzcFXJRA8Z/c
	i7wlt/Ei7b9UKfmId6BiCIsSSXOY6QEmejTZXA2VPTYXFO6JdwEI6YSgCXVZUyfv
	9hDuZCbRQOwDax9Vf7UjFw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300dww49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 13:51:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498CDpAU001207;
	Tue, 8 Oct 2024 13:51:17 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw77mw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 13:51:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYtt79Ioailyl5sKms9Not7uQsKxcc1rSGXay0vCTVLJoktF9X/+XCvARmFP69SvP2+FCdF5mSxp8cprAAhysOAzG2jPEXHJFrY31Mp9Yna+wFzYrwwsYh1H97sBx8QM2nec/9yem0ZBVT1NffqeN8Dj2Kd2Qh+V4KoWapDeB0F24QkcDJrpZ7qrLC/3uP/29ab0dMTAKVW9dJlFK3EaPQt2Ap4MNhSj7j/mhNI9YUn03yI50c+8yr3k1+VZ5id0QWNu5uZpffmB8s+TccRI7sUx29O17niwvPOA8Oy8GI0fXnFDn9Crx9SjkE92FXRJBnvg7kCRO0vn63sAg/Y6Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qHNIZmpg2VeP8XqPv99YJaoA6FlIvtRve4KQKLGs2g=;
 b=SoRvqeeoxvom5S/upyeCe+hXFeIUQsh+O8p6OygquD096G2xUqXx96wuAego3rrOO4EV9zQ4ioev15czrNAjwp/9Yhrordkt539cQZFKIUYZovxM2qyFQTVb33jJvaO9YFdlrFOe+JXHjM6dRyyQoEREB6+NEq8L+mGcK9hmRVQcLEoONbF7LK0uVSq6n5EG2LC4NqhxOHL0dlsv8HCQc9zUHzo/zYp3qnKi+OnvRz6tfeidMzNMjaVBYRDvlXaF2yCW/TAzLLu260U2z7gsKv1DI9wzEbUDWXeLywTsNsPvWJP/AFDyNgOmvadYRovy5EfWjmQdLq5Vm4wasOO5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qHNIZmpg2VeP8XqPv99YJaoA6FlIvtRve4KQKLGs2g=;
 b=tMBKgPfNF77uzxdQDmYyiT+ctVkIYZWv3r0OelHzNct8aaYX2KyDjGTsmcyqjkT120W7h/g2JiMsJ2CSEalaLeh4jcTYFGBZpzDGP2d8Y+fpuP+mfrcoWucWKVZ+jZUfbyuBFUVCmM035nXrjgWwD8j/EcJNuPBdUVSmR40x+Lc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4694.namprd10.prod.outlook.com (2603:10b6:510:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 13:51:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 13:51:15 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Chuck Lever <cel@kernel.org>
CC: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 0/9] async COPY fixes
Thread-Topic: [RFC PATCH 0/9] async COPY fixes
Thread-Index: AQHbGYiqbyFRzycAwEKqHw7PACpDnbJ83yuA
Date: Tue, 8 Oct 2024 13:51:15 +0000
Message-ID: <6EB988F6-4B87-4C1D-BC0A-15A368E56275@oracle.com>
References: <20241008134719.116825-11-cel@kernel.org>
In-Reply-To: <20241008134719.116825-11-cel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4694:EE_
x-ms-office365-filtering-correlation-id: 9f102d01-076f-46a2-0910-08dce7a04720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ay9sZ2tTajFxMDB1REJxNFh4R2M3S2orYWxpenZPd09HdnB3VDJraHFDc1lV?=
 =?utf-8?B?Nk1teTQ2c043eHZvNmdKNWpoYVVVNUlleUVNNkt4c0pIK2NrWnZpZ3pqVVJj?=
 =?utf-8?B?M0JaOXM0Y0xNK0kyN1dUdHFZdnJpZ0lCdkVwN0wya2NNb2xzL29nbnlObHRJ?=
 =?utf-8?B?WFl6ZzBDMTIwNWEraGlwcE11Y0FIYyszdm1iOVlsZjJMS2F6a0pPK084ZWt0?=
 =?utf-8?B?azFOcVlJNE4xbjQvRmgyTHNTM0J2MWRMYVN0eGhYS3k2YUNkSTJ3V2oxdWxs?=
 =?utf-8?B?RVdQNnk4WHdscnFKMnpaWkIwTXovL2h0bzVlZXhTRWgyaFpORXRIaDVya2ZO?=
 =?utf-8?B?YWlrWW1uRmh4enYzRWhQZVdBRm1LaXZvcDhkRDk2UGU0STVCbS9aSW81R3lQ?=
 =?utf-8?B?cVZCU0trZW1UM25nUjVwTlFDMDJIa2t2eHJpTkJPQUpxazhhUFNZMUFlUzU2?=
 =?utf-8?B?dCtPTHd3ZkFhMitlWTczb3RQNVJMVlFWOXhONHowTllOUnBLZExIaFJqbVo4?=
 =?utf-8?B?TDh3QXVIaGlEZXNTaHpiSk9HVnc4bmx4SlJPeC9HK0RuN2JSbEFNaVdldlpk?=
 =?utf-8?B?REdXbHVNWHJEd2c5R0tQWGZwazMvck9ycWF2MEFaTU5CSjhIdFlhdnZ2UXBw?=
 =?utf-8?B?b1BWUUkyTXcyM3FwSG82R3hUQWhnakVvNUQ2ZVVJS3RRaEFQK0RsRktuUWZP?=
 =?utf-8?B?NnNGZXU1aWo1U2xYbk5RU05aSjFkMm5CVHh6eFM2ZXRpS0s3VmRKRDhsN2p3?=
 =?utf-8?B?NFFJU08vSVEzZDNLampNYWp6MXRQVUN5d1lHclRON0E3SUFKemdLdkR2Rlpx?=
 =?utf-8?B?anRBdlJXRnhFK0VLVklKYmJHTjJXcjI4czg2ZzRsWGtoaWRmZURydGpGSzNF?=
 =?utf-8?B?NDlvWXJDeDA5Zm9jSFNiT2huYndHU1hPMk0wTWZnRW9LcXVVeDV0U0t6OWhT?=
 =?utf-8?B?U3ZlMUJqcUdic2FDRjdEZ2RyTjY0cWN1SDgxOVhSdi9hQ01heDlTS2MxUHRL?=
 =?utf-8?B?WU80cE5nVnBDaHFoUW44NG9CWUVBZjdnYW15R1M3Wmc0LzBWSW1zZmt5ZEdR?=
 =?utf-8?B?K0ZXQW43TlFjM3MvdEJoTXluZHF4ZVkzamNwT0t3THlmTmJNaWhxT3c3Q014?=
 =?utf-8?B?ZzIrdVc5MWNQbDVkd1hDMm1yNzZZL05BY29nNk4wVjh1OFR6Q0lGc3EzVmZF?=
 =?utf-8?B?ejFQVWRmUXRNYTNmWGRXMkxvMlQxTlp6OC94NmpWbHpnYmx6Yk4yeVBubVh2?=
 =?utf-8?B?OSt0K3kwYkpaVDBQcERjODhkOUR3RmFiYW1nR1RrM0NGVWpOeDR1RWMwTFNk?=
 =?utf-8?B?Q0lQOTJuNE5TbkJZSHBMMUkwcGN6VUpZL3FGSkN2emxHSEVQN1pqeWlJRll0?=
 =?utf-8?B?SDV6bkMrMHU4cnQ0citZVER4L0dNS2JmQjJkRExqRjdUcHp2d3dMY0dwcUZ1?=
 =?utf-8?B?Z0hEUGtSTVhFelVjdG0rU1I1cDBFYUQ3SVJJa21BUStCenAvaHRHVzA4dElQ?=
 =?utf-8?B?WThXazFYT0Fqb2ViYVZwNDZrWXlhUExWRU4vb0hHK0ZPREh5N1JsU2FkL0xH?=
 =?utf-8?B?ZU9ZbDMwd2h4N21wQWxocGh4d25ZQnZ6NVZsblJnMDltSzl3QlhvaXFwS2Ix?=
 =?utf-8?B?bFJpMVppTTBERHlhaTVDdXBJT0pKdnFKN1o5bWN6UzdqamRCRjk5ejBLZDZt?=
 =?utf-8?B?V1hOTHFsUGNjOG1NUzJnRWN3NlI4Z0ZuZWpJZWZQaEJ5RUxyVmR3aW4yNUpG?=
 =?utf-8?B?YjJmR2pRQm5jV2xyVzZEbVhWY0M2a2g5YW9kcHVndm9JSzV2dTEydThjRGdM?=
 =?utf-8?B?UWNaMkJTbm5FRHpKOTFpdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2JUVEFLREp0c01aU0FBekxnVDZvTjQwdTV4cFgxams5Y0dWNnRmSGl6UTRT?=
 =?utf-8?B?RExwSS93cXZhRS9FaWF0RldKZ25UTldFNnQ1UUhDQkpPTDJNcTFhMUpLeXZu?=
 =?utf-8?B?UXhYa2ZsdU9ybUp4NkZwd29icXF2OWh2cVc4aGtmZm5pekFKVjRKQkZ0S1BD?=
 =?utf-8?B?UGZjWDdQaXdLVDFHeTNpUE1RazJZZk1FRjkyY0M0TnUxUGNnWkVOdmdYckNo?=
 =?utf-8?B?SjVDY2JseExIZkQ0Sy9yZjNpekpXZnpFUDlkdExhUEJtdW96bWZXQUtDYVhr?=
 =?utf-8?B?bWVLZ25GTllqTW1oMlF4Tmt0QVVSRmhqdnVWMjFaV0NDSnJjYWNoNlZ4ZDNl?=
 =?utf-8?B?M29tSWliOHBMeUFzZVVTdkJQbS92SWU3cVdZWlIyYTNDbitzMjY4ODd3d2pM?=
 =?utf-8?B?SVZmZHBpTEFEb2RIUDk5dHdQSTJNVkJZc3cxbnY5ZWg3d0dSYS8rQnNldzQ0?=
 =?utf-8?B?WkxJaWdiLzluSzBIbzVQYTJKTkRsRk1JYTZBMEhDTVRSNkFmRy8vQ0RvWUVq?=
 =?utf-8?B?OFExbmlLRFBHY0pVQkwvNUhzekVhSm4xQUVmVWdHS2hReUNKdi9KeUp3MCtx?=
 =?utf-8?B?VTZYL0hpdENHWnZabCtzdXAvaXNUbkMyTWo0Uk5NYWIxamVHalpScDlGL1hH?=
 =?utf-8?B?YStUOWZhTTNIZXR6SThWU3FiZWVpRk56eXVOMGdidll6MUV6d2QwZnh5bzNt?=
 =?utf-8?B?cVJLbng4Rklya1pwZHkvRXQwS1VQMmZWWnorMzExYm11SUlRaVlUa0ZRY3hK?=
 =?utf-8?B?NkVVV3EzQ1dDOFRpMlRiRnNQOUgvc3pKZzVNTUljVDJIWlNlODd4ck54TDRh?=
 =?utf-8?B?aW5JaTZHR3hsajVuU0NCRGVSbDU2QWlSVnRMTUxBVGlUUkNQWXdnK1ZDMlQw?=
 =?utf-8?B?Ky9WK2ZBcWVjUUNNVDhqa0lsb3I3UG52bXMzOXJOMkI3elBoKzRpZWRubU9W?=
 =?utf-8?B?bmhrYjgyMU1pM2pQblQ0OWFaTFgwU0FsZkF6N08vZ0dVUFI0cmpYRU4xV01R?=
 =?utf-8?B?ZFpEdXN4R05jQ1dja1R5VnlIZEt4VDNmd2h2SEE4c3RMNUc1cjlwL1UxaWl0?=
 =?utf-8?B?YXEzNG1IaHFmTVBOczBnUWdKWTBUOTh5WVFMS0dnb2N5cm1ranFyQWt4MDd0?=
 =?utf-8?B?Y1pjcFBqUFlGWTZvYVpEcldQd2wzSGg0WFpzWWJ0cWw5WWtVbE9CTjV2Q3p4?=
 =?utf-8?B?SGdmYWFVMjBuSkd1MUdseXZBMjByTXhUdkNXZHZMQ3VtQ0lVQnJKby9QbUNu?=
 =?utf-8?B?a3ZDNCs0QkgyeUtDbzNWZ1cvT3pNN2Z5TUlNSlpoQzhnWFJxbU1Td3BiRzhJ?=
 =?utf-8?B?ODhjOG5wWUNzRWRhMVR0K203UGtFY3MxaDlWaXh4Vnlhbi8xeDdmSnh1WUR3?=
 =?utf-8?B?am94am12aXBrM1hQbzNhN01rQW9EaE1ET1NPbzI5djZYekkyL3piVWFraUFJ?=
 =?utf-8?B?Q0Z5NG1LWHVQRndIVjBEUmRRNkNvYndvVTZ1a3M4Q1diWEFWVjdkT3M4dmlZ?=
 =?utf-8?B?aG9OejVQaW5BbjgvcHpRRWhRRGxac05CZitwcTZkMnNSKzRHdGhZVkRJQW45?=
 =?utf-8?B?T3lVbEV0aXNuTEhuOWpLQzhuL0JQTisrbUhkc250QkJRa0ZxNnVXNW02T1Bm?=
 =?utf-8?B?L2t4VFl6L3d3Q1pOTGlzTFdGb2RhMHdyZFBDQ29zdlZxVFd5a1NPUUlabzBG?=
 =?utf-8?B?R012cjRNL3ZrbHZlZmtSZjQxWTZBTjFud01TRDlHN3gxbE5KRnNTc2pDUVM4?=
 =?utf-8?B?WkpLd0tEQWhWa3RHOEhtbXhVK0tzN3VPbWJxZWl0WC9DZjVXRHJZRGM5OTFP?=
 =?utf-8?B?VzZpRndLUXFSd1JhblRjeGRkRlNsVHRrRXFmcVhHZ25IblpkWnBsL3g4WkZU?=
 =?utf-8?B?SU9NUGtWcEtITVJWMFVHRktGdEZhMlZUbEZVUWtsV0wvSUxkNUtEYUYrV2J0?=
 =?utf-8?B?WHc4Q0NscmdnSnNFNWUrQ3NmeGFpK1dZclFtVVhoaUREcHd1UTZZQTk4MDVR?=
 =?utf-8?B?VnRkVEFFelhBSk8waUN5ak1zaGNCYTVSbG5OYTNBa0NwVm9SckxSWGRmblY4?=
 =?utf-8?B?NE51cHpaRnFGTTdGVkQ5bytjb3FVclAvUktYa09zbm9Ya2NsNkJRalRUZ1dy?=
 =?utf-8?B?cWF3bFUydXRKQXl5RTFOUnNzMmtDMy95NXErM2lEaVJ2NmtpcjRGbi90UGgy?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CDB2793FDEADB40A5579701A00D0BF7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GjSvFPfXlwoG/xr5Mn0H2gIrgAMI1hq6LWgSjDEAfkpKO7c+b/LAM32k3G5MsQqgX2FxvwteGV6UbDaaiASQma843Rhciu44A/OpG0+NzS9N00ggYz3Gmjo94rliEdLQnRFHYrlzNGYLcktCmyQ/cRQMDrynH9m0QT6vggjZM0kw/2lXczVZqztSi3Scq9bAfWlaMXwOFUAtyGINQmG8Q9sVftnQCez8ziTrfrQVAgNxQZa26IyxRvuD2DxvdfyoNMA1uh3rXMwiuYrS3T27SBEgpFuHMugOUM4pH6oqeHXs+aO/eewcYC2slR7IGZBdpWVOQj1eO+iL5ZXwsJFwtrDjGsW+ELmOccAWGuTymEXsdWjjg2sluCRb6JWzJaDhaESB1w6BhTI5VIhj8++XWQHi1egCpSHhTT1yo977puZuEzsC0CXxXEJmMeFExSV47jHsg8Q0SrkBqo2baLvmKep7DeYr3fBjRxs4C4/YNftwT9qK2D249m98MJiWN8n8D1mAOj+K9vhIQbBrce6bLPAG/316iwssRxKnEfEKPQqgxWM+y5iTJCQwDZB6e1Q8gLBrDD6KNKcBkqmmjPYl+GNof2K0F9HMg+DRpMlR5AQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f102d01-076f-46a2-0910-08dce7a04720
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 13:51:15.3294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: At1CX0KbSytivVqjUozQIcCTqlqe9pvgQFn+WNWSHpwIQThAAKsq+r3FJMxDgEQ0C+dSUJy06EeCW0y8ZC7gLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_12,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080088
X-Proofpoint-GUID: mst6L2EYQLseHL03Q4wSV_EyQRAKg3N7
X-Proofpoint-ORIG-GUID: mst6L2EYQLseHL03Q4wSV_EyQRAKg3N7

DQoNCj4gT24gT2N0IDgsIDIwMjQsIGF0IDk6NDfigK9BTSwgY2VsQGtlcm5lbC5vcmcgd3JvdGU6
DQo+IA0KPiBGcm9tOiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4gDQo+
IEhpIC0NCj4gDQo+IFRoZXJlIGFyZSBlZGdlIGNhc2VzIG9uIGJvdGggdGhlIExpbnV4IE5GUyBz
ZXJ2ZXIgYW5kIGNsaWVudCB0aGF0DQo+IGNhbiBiZSBpbXByb3ZlZCB0byBtYWtlIG5vdGlmaWNh
dGlvbiBvZiBDT1BZIGNvbXBsZXRpb24gcmVsaWFibGUuDQo+IFRoaXMgc2VyaWVzIGFjY29tcGxp
c2hlcyB0d28gdGhpbmdzLCBwcmltYXJpbHk6DQo+IA0KPiAxLiBBZGQgc3VwcG9ydCBmb3IgT0ZG
TE9BRF9TVEFUVVMgdG8gdGhlIExpbnV4IE5GUyBjbGllbnQNCj4gDQo+IDIuIE1vZGlmeSBORlNE
IHRvIGtlZXAgdGhlIGNvcHkgc3RhdGUgSUQgYXJvdW5kIHNvIHRoYXQNCj4gICBPRkZMT0FEX1NU
QVRVUyBjYW4gZmluZCB0aGUgY29tcGxldGVkIENPUFkNCj4gDQo+IFRoYXQgc2hvdWxkIGJlIGVu
b3VnaCB0byBtYWtlIGFzeW5jIENPUFkgcmVsaWFibGUgc28gdGhhdCBpdCBjYW4gYmUNCj4gZW5h
YmxlZCBhZ2FpbiBpbiBORlNELiBJJ2QgbGlrZSB0byBzaG9vdCBmb3IgZG9pbmcgdGhhdCBpbiB2
Ni4xMy4NCj4gDQo+IER1ZSB0byBvdGhlciBidWdzIGFuZCBpc3N1ZXMsIHRoaXMgaGFzIHVuZm9y
dHVuYXRlbHkgYmVlbiBzb21ld2hhdA0KPiBvZiBhIGJhY2tncm91bmQgdGFzayBsYXRlbHksIHNv
IGFueSBpbmRlcGVuZGVudCB0ZXN0aW5nIHdvdWxkIGJlDQo+IGdyZWF0bHkgYXBwcmVjaWF0ZWQu
DQoNCkEgYnJhbmNoIGNvbnRhaW5pbmcgdGhlc2UgcGF0Y2hlcywgcGx1cyBvbmUgdG8gcmUtZW5h
YmxlIGFzeW5jDQpDT1BZIGluIE5GU0QsIGlzIGF2YWlsYWJsZSBoZXJlOg0KDQpodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jZWwvbGludXguZ2l0L2xvZy8/
aD1maXgtYXN5bmMtY29weQ0KDQoNCj4gV2hlbiB3ZSBhZ3JlZSB0aGF0IHRoZXNlIGFyZSByZWFk
eSwgSSBjYW4gc3BsaXQgdGhlbSB1cCBzbyB0aGV5IGNhbg0KPiBiZSBtZXJnZWQgaW5kZXBlbmRl
bnRseSB2aWEgdGhlIGNsaWVudCBhbmQgc2VydmVyIHRyZWVzLg0KPiANCj4gQ2h1Y2sgTGV2ZXIg
KDkpOg0KPiAgTkZTOiBDQl9PRkZMT0FEIGNhbiByZXR1cm4gTkZTNEVSUl9ERUxBWQ0KPiAgTkZT
RDogRnJlZSBhc3luYyBjb3B5IGluZm9ybWF0aW9uIGluIG5mc2Q0X2NiX29mZmxvYWRfcmVsZWFz
ZSgpDQo+ICBORlNEOiBIYW5kbGUgYW4gTkZTNEVSUl9ERUxBWSByZXNwb25zZSB0byBDQl9PRkZM
T0FEDQo+ICBORlM6IEZpeCB0eXBvIGluIE9GRkxPQURfQ0FOQ0VMIGNvbW1lbnQNCj4gIE5GUzog
SW1wbGVtZW50IE5GU3Y0LjIncyBPRkZMT0FEX1NUQVRVUyBYRFINCj4gIE5GUzogUmVuYW1lIHN0
cnVjdCBuZnM0X29mZmxvYWRjYW5jZWxfZGF0YQ0KPiAgTkZTOiBJbXBsZW1lbnQgTkZTdjQuMidz
IE9GRkxPQURfU1RBVFVTIG9wZXJhdGlvbg0KPiAgTkZTOiBVc2UgTkZTdjQuMidzIE9GRkxPQURf
U1RBVFVTIG9wZXJhdGlvbg0KPiAgTkZTOiBSZWZhY3RvciB0cmFjZV9uZnM0X29mZmxvYWRfY2Fu
Y2VsDQo+IA0KPiBmcy9uZnMvY2FsbGJhY2tfcHJvYy5jICAgIHwgICAyICstDQo+IGZzL25mcy9u
ZnM0MnByb2MuYyAgICAgICAgfCAxOTggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0NCj4gZnMvbmZzL25mczQyeGRyLmMgICAgICAgICB8ICA4OCArKysrKysrKysrKysrKysr
LQ0KPiBmcy9uZnMvbmZzNHByb2MuYyAgICAgICAgIHwgICAzICstDQo+IGZzL25mcy9uZnM0dHJh
Y2UuaCAgICAgICAgfCAgMTEgKystDQo+IGZzL25mcy9uZnM0eGRyLmMgICAgICAgICAgfCAgIDEg
Kw0KPiBmcy9uZnNkL25mczRwcm9jLmMgICAgICAgIHwgIDI2ICsrKy0tDQo+IGZzL25mc2QveGRy
NC5oICAgICAgICAgICAgfCAgIDQgKw0KPiBpbmNsdWRlL2xpbnV4L25mczQuaCAgICAgIHwgICAx
ICsNCj4gaW5jbHVkZS9saW51eC9uZnNfZnNfc2IuaCB8ICAgMSArDQo+IGluY2x1ZGUvbGludXgv
bmZzX3hkci5oICAgfCAgIDUgKy0NCj4gMTEgZmlsZXMgY2hhbmdlZCwgMzExIGluc2VydGlvbnMo
KyksIDI5IGRlbGV0aW9ucygtKQ0KPiANCj4gLS0gDQo+IDIuNDYuMg0KPiANCj4gDQoNCi0tDQpD
aHVjayBMZXZlcg0KDQoNCg==

