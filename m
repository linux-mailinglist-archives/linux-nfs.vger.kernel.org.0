Return-Path: <linux-nfs+bounces-8384-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A459E6965
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 09:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428F52834DF
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDA91DF983;
	Fri,  6 Dec 2024 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="U0NZYDB6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2090.outbound.protection.outlook.com [40.107.95.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28B1DBB3A
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475320; cv=fail; b=ozm5Dtg0anG/tjdZdOTJ7aHKl02cCnTPZo7Y7udgN51v6/TJ15G6rlmF3oC+npy5b3P2fsOTeSa2/ThzOQDACoiXkIAn9aXfH16zZHY5ag/WP7TMXArDrgqPxYWhE6Nkuy3k+yEgcP+nyFqVtIEOHq/5ry/WkTRux/IkJ0fKntQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475320; c=relaxed/simple;
	bh=/Iy25n4HPz0IflrYYLQZ7ovDyUxuReCe4vXaD+58LCs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oKxxr554m9vIE5/6w2atRI+DFPcwlSmS07O4E7F0LT6aL/y8lUxv9Ba3j4udlMRtmtFgOYDEatbgH8wJOvDcyQ/bd1sHeuG5rY76Eh1XV0xq+whYCGBSh7CuhVzTZmmY/OUnhbFIt2FFwTi+E4q929gUrBxovaebfhbBqcOW6hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=U0NZYDB6; arc=fail smtp.client-ip=40.107.95.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFvFgiyiANXEFREehnxV8xbtbpfVc132pgp/C9jZQk+JDaUNP6PrcK4pS8jcft7esuYkY/EDm439SsyckQ+S0E/lMfeF1fMOfL53iXxR4mEM4mPzm9KxwnOTHbAx7HhMSuuev+IqPVpWjZYKw3JOEEMTskg4OLz7r5epHn7+/TuOJ3pkZRgFy9irBqPT1BLTRf8qOO96Rs956RegnRGraDkc4HasrpVhLostldzNa5Q1r+5uwreVQtBJP4V9nQLw0c1FSxuxrhiQU+Zs1xEAnMJ/PyRrMRiTfKjgWs3zBihhfx8Wh0WLogEq8dpopIx0VBoCkpe3G8iDV8hqQG4jsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Iy25n4HPz0IflrYYLQZ7ovDyUxuReCe4vXaD+58LCs=;
 b=mg5r66O/uCDUUxH9e19tE0rhMGUwaIvS1LNDvyFit/vnN2MSVG5oki8j2BUcoiMJsf9/EywXiArVKBYnGQ8VolTD8jR6n7VkUogKLLziOojv29eZMk2rJs3gnOXoV2G3IjS+xix5zqsl/lqrkxON269+w+ccB0nmq4QE45xN/dtpJEXyTpFC6xSPLlpPCLANRKSXTjaTc26ikWBQAm4Wz+AMcFawlOVY0/mZQ/7D3lgkRSMiA7s5A+jqvepdQ8eTgMgwT8eS61UXqYn63C2bd3NhRDpO84DZYZ9zOSuk6gD3CLsA6KuhHzDtXXOXK18Br3BmkjREt0Gl391jRsfIDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Iy25n4HPz0IflrYYLQZ7ovDyUxuReCe4vXaD+58LCs=;
 b=U0NZYDB6k4KqwIDlXeTN+939GoefVSuVVDOzHA+WGvs5yNNTaMHIan3VM6odvgtiaOM632jha0LQFOY2EIJ8F/rbyRvou+FQxbPWdTTT7WDjos6e0LifnywgkVP0Gc0hJqZYWALxuHagRQgd0dtSYW7VgQvLBadMFj/b0b8OGes=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4590.namprd13.prod.outlook.com (2603:10b6:5:297::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.22; Fri, 6 Dec
 2024 08:55:13 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8207.020; Fri, 6 Dec 2024
 08:55:13 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "cel@kernel.org" <cel@kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "bugbot@kernel.org" <bugbot@kernel.org>
Subject: Re: deploying both NFS client and server on the same machine trigger
 hungtask
Thread-Topic: deploying both NFS client and server on the same machine trigger
 hungtask
Thread-Index: AQHbRmti0xYHT7Dx2kOugyvlEnmsA7LY7EUA
Date: Fri, 6 Dec 2024 08:55:13 +0000
Message-ID: <f8e2ccbb2cd329ddb99282df4c7e668cbdb25545.camel@hammerspace.com>
References: <20241203-b219550c0-abf5589a5df5@bugzilla.kernel.org>
	 <20241204-b219550c4-eb90fb494c92@bugzilla.kernel.org>
In-Reply-To: <20241204-b219550c4-eb90fb494c92@bugzilla.kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DS7PR13MB4590:EE_
x-ms-office365-filtering-correlation-id: 055e2fd0-2782-441a-6350-08dd15d3b272
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1gzNURiM3V0c2FGV0tCYm00emhwM3BNKzl5TjhDOU1JZGFqWVVYWjJad1dI?=
 =?utf-8?B?dXFjWFlROFJleXlqSU1YL3BhUW56TlRMNGRNZUw3WGxIWEVMb0xwU1VsVmtj?=
 =?utf-8?B?Qkx5UkpScytGRFduNGhDYlgwNHVOd1YvREFDWndTRXNwemQ2ZWlXTEZOcXlo?=
 =?utf-8?B?dVByZ1NQc0ltaWE2VzVqTUw2blN6NU5SYS9Eb0FqMVVQUXpMdUxGNDBnMlZk?=
 =?utf-8?B?U0xDM1gzOWxObFE4ZlcvZlhVUTJGSHZyZS9ZbS9UK3c3cmRrQ0Z0cDFDdjFB?=
 =?utf-8?B?NUFiNnNWZ3pZMUVteHVVZ0RxMkd5RHVrOHo2NlRjMEI4bjZWcWFycStuNWVi?=
 =?utf-8?B?N21ZQzdQZjY3c0RVS0tUTlFTN0QwTTZVSitHcW1UazRpcFRHRzFvUVd1Mi9z?=
 =?utf-8?B?Qyt3RnlwNStPY3d5YThMTCtmSGhHRklDa2QvczNLYTVHazhBa0poM3pTTHll?=
 =?utf-8?B?NXRIZlRPOXBPamhQdUs5cy92Ti9WMlAvK2FDNmJ0N094VDYxQzhVYXRTQms0?=
 =?utf-8?B?ZXJNTDIzZkVrSElDRjJJTEZ6Q1o0ZDN2cnFyVWF0WFBjeWRFelo4RlBDeS8v?=
 =?utf-8?B?bjNyODRQbktXa05sNGQvRk1jajNlNkpEUHhyeldhL0QwUGlzTGMwOHBrbE90?=
 =?utf-8?B?WWc1bXR1SGRaaUd4YTIxZndMVkJMdVVtenJBSDhMU0NqZ1RlVGd3d1ROM1Fv?=
 =?utf-8?B?RHNFK2FKVjFtY201b0ZIMk1YTWg3Wld1MHYrbUljQ1JKK3JzUXZkYjRmYW1k?=
 =?utf-8?B?QURIZHUzbnRpcWNLSktNK3NTZ1diRHl2Uk1TcStNeWxLY2h6eExNdHVNRUR1?=
 =?utf-8?B?TnN1MXd4dFBUZEgrOENuR29QNWJPbEFYNWRmUk1HbXkvWS91dHorcjEvWDBk?=
 =?utf-8?B?NWx0aDZocWI5OUlLZk1yWkVqdWtQOTFuYTdWaDhpcnVodWFGWk9pWVFEMzNp?=
 =?utf-8?B?MjlaTVJEemdoREVLbVFib3ZHU1ExVzhBKytGdzdOVE51a2dtYVVLNDVsa21h?=
 =?utf-8?B?cFp3dUtSRDNwNVZ0QlEzRVQ5S1hkUGhJWVdETkJuRnh5bEJ4Mml2RmlmZ0Nt?=
 =?utf-8?B?RGR1aVRyMnI5Snd4OEc2S003ejdXNVBaZUQ2RTJvWEJIdEh5MURGandET3lE?=
 =?utf-8?B?Nm5vZHlHTEZHZk5yZVM2cFBLc0xQcUE1amh3TEtMM0ZwM2JGSlJTTDJCZmwv?=
 =?utf-8?B?SXFTNE9BNVBlNXFRSVlPM0J6dnY3WDJ5Y3h5ZEFOdWo3TG9BdE9raGc4dGpn?=
 =?utf-8?B?RFpCTGx3WktaUjJRVEwvdWhMcE41TU04ZVR5YXk5Y0tvc3VZc1Z3K20zajIw?=
 =?utf-8?B?UzMvbDRsSEwvc1Nyc2pEK1dpQnJzc1N4VUtVYkkyTU5hN3BWT0k0NHdITCtt?=
 =?utf-8?B?S3phWitlYlUwNnQ0S0d1Qi9QTW8yK2Z6UStCODZtbmVUYW5LUmxFZWFyNFkx?=
 =?utf-8?B?VGtVOWRxQzd6WUpISEZnUHQ2eG43UUQ3akhRY3g4MnJqYUtxd1dBcEY3MVdD?=
 =?utf-8?B?bW90Si9SYUtueVFod1dEM0JkSFNjUGtSTkQyVW9oeFBPYWhoZUViV2QrMlBi?=
 =?utf-8?B?Q2tjR1VpdGVlTXVXQ1hUN1EzMTBDMk51MjlML2FrclZJQ2JvZjJHVm1xeURp?=
 =?utf-8?B?Ynowa2xrU0FLMno3eng0NFNiajB3NjBuQlhISGlBeTBoZ3IwMzlzV1RqeXNw?=
 =?utf-8?B?NTNuVUZ3WWxwcnNoNVplNGVrT1NYeStSZjIwOTlhdElPcHlTem1oRkFmejRa?=
 =?utf-8?B?SVd2bWQrRDlDNjk2cXB6bXFHNVd5bDlxSWZwZURpNnJKWkFOZHBpVmVITFR3?=
 =?utf-8?B?M214ZXIwZTFSUVJSZUxHR0M2VFBqd2lYdjhLT2NjU3lLcFpEd3o0QmVYd242?=
 =?utf-8?B?SndGbXUvY2xodlNycldGcTJUQlE0cG9rcXhmTFVOWWNwNmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3VDT0dZNXBCY2tVQ1Q0OGZubVQ5OXNGQWdCODFoUGc3emFDRHlzaWR0RWoz?=
 =?utf-8?B?TllGL0lWUDZtd25yQTZtaHRMcy90a2FFUjNzcFdmTjdjREgrWFpOd1hQVzRV?=
 =?utf-8?B?ZlhPSmUrZGtMWGpmc3FVd3RCbU5MV2RTZ25YazBsSjBuU1YrVDM1TWoyQWZF?=
 =?utf-8?B?S28zOUtHV01maEhyV1dKWG9LRGs3UHowVHFLVzlVdC9vUVRldVMwODV2Nkhm?=
 =?utf-8?B?eHdiTGZOekJFdmdkdi95NnhsN3U5UGpNSGVQejNDSlJNYVJxVXFoWmpWc2V0?=
 =?utf-8?B?SEF4cWJwM0ZkOW56VlhMckVlei9SL0MrOWk1L1BadDR0Rm85NnN3bnZ5cWtC?=
 =?utf-8?B?UWFDeS8vMzhIYzgxMFVjQnJ0a1dKS1Q3RDU3WVNnMmp5dVlWUGFTRGMzTXcx?=
 =?utf-8?B?Q0haOUppNmlOdDZ1Z0s0YVh3UTBDa0VlTUJyMzFxSjZkQmxhYUR3b012bmxU?=
 =?utf-8?B?TFVJeHFGbWxraGJzRGpFYzlBcXd6K08vTzd1bTBMSGNaL1BTR0VwWVNhR1dB?=
 =?utf-8?B?V01DS00yZ0Q3ak1Zc2pWd1FCOHdlTXZCWkQvdmgvbmsvL0lMNVVwdCswdVRV?=
 =?utf-8?B?dFJpQjdRSndHYTRMMzR2KzBwblMyZ0JQcXdZMDZUeVZnZEV1aGhPZjc1WDI5?=
 =?utf-8?B?NklCbGtQcXc3Mlc3U0JiQTlReEZoOXhNazVDWGxCNG9sb2VRMFNIOHdWTE9Y?=
 =?utf-8?B?L0x1R01NMmlkWitHcTZKRFVud245NHNLbTNueFIyYk9tbFJ1elRzcUlBRHZS?=
 =?utf-8?B?b3VVK0FnZStESzhrb2MyelBaTHhTNjgvT1kxTHRyUjFvYklGU1AweTMvaHhF?=
 =?utf-8?B?aWhEVzdTcU5rTkFiS09mWWxjek92SmdEVGFNSjZIVlFWSTRnbzRmK2x0b0RV?=
 =?utf-8?B?UEs2MGRXNkdkU3FhaC96TmFmZERzU2ZLU1ZwWFNVWTBxYjJVUmdVOWxlU0ZF?=
 =?utf-8?B?ampYWnFxNHQvdnB5dEtWWGpiQUlXclV2VFhNaG00Q3YwY05tSG1HMGErNDZZ?=
 =?utf-8?B?dmJwZTdiV3BiUzQ4K09vUGoyRkU0ZEF1R05uenBieXpOU1h3Z3JWR1I0d3gz?=
 =?utf-8?B?NHZMYzVOZGszTmZaVzRzMjZHNFpwVVJLOE01L2tlNDFMbnF0VmdaSDFId1RM?=
 =?utf-8?B?NDZiRE1NWWY2bWY4aHRMNll5TStVeVc4bG53V2JqQWloeEp4UnlMS2kzdEFr?=
 =?utf-8?B?ZWRrSitjYWlCKzQwQ2VHWWZ1SVpsMXZsWHowS1NrYlJNK0dYVGFwOEVOaS9h?=
 =?utf-8?B?eVhvV1hzY2YwOWlxdlE5ZllRaU5SeHpTcnBOKzNoTnhpdlFzcEdBZytJMjRa?=
 =?utf-8?B?dXJNYmt6ZzFPWFR4L3ZlK0R0citQLy9HajU1Zk5PYTJlWXAxRGM5Tno3OHB2?=
 =?utf-8?B?ZXd5SnNRYWw3V2NJbFBBZFM3VWR2YUFwNHNJQU85NVNCaDFIbTg1c1YzZEVO?=
 =?utf-8?B?VktBSXFHZmtQek1IRmxMNGlveFFXNk9uMGpYWWkyOUkzVjhSd1FpRzFyaGQ1?=
 =?utf-8?B?djZXbUhTVkt1TmorVEhSNEdXUWo4K213MGdTU0VUd2dtYlFFOTdqaHlLSlUx?=
 =?utf-8?B?dEpQWGlWS3hFeXBkZWRjTGpLNGRVZUpwUzBVUElpNU1CK3RqMHp1UG1EOTU5?=
 =?utf-8?B?SHdkWWU0WTBPTHZQY0xOVXJwZ0VFL2F0Q3U1d2owbTFPVi81VFlnNE5FN2o2?=
 =?utf-8?B?c1NkbWtwRTJrSWRoa1lyVTVpNHZaRm0vc0xTVDdEVHJkejRTcjVGZ0hTbS96?=
 =?utf-8?B?ZVlHM1ZNNHlpenpFN21sVCt2UXlXVmZiMXVScWE4NmFBRzJSUEt3Z2d4RnpB?=
 =?utf-8?B?Zkg1NzJWYTk4RDlLQ2dPbUhnZk1yeGFiL2JTbWJUSnJyWXZaOU4zVnhRNzc5?=
 =?utf-8?B?ZCs5ZzdRcndvTFczWVByUEp3cUpMNjhJQXJEY2tWZHIzdTVTT1IvRUovRHNU?=
 =?utf-8?B?Y20xTUwwanVxSjFLZWJ4M2xXN3EvNWo4TmVFcmVNb2ZFcnVvQUpGT1A4OCt3?=
 =?utf-8?B?VUt6K1hBZ2lBNnA2bDdBZ25wUGZJVFI5YTBrcmE2UHE2OFVLVFRzTFhGdGdI?=
 =?utf-8?B?SGJHWC94Zk1HOHg3cnprdWxacFdZZ0R4L1JLMnREb29qTFFwTkFTOUZvSG1P?=
 =?utf-8?B?cUlWRmFMZ0RQS2R0STNINHBOWEhZYmRKTnh5R3NwUWVuZDlUMXVwZ2NFdEdD?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5F033123E16E54191E5AFE11A85EF4A@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 055e2fd0-2782-441a-6350-08dd15d3b272
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 08:55:13.2501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s05Fl54zCyKRH7g90M6LwzS5x6QEsKYQ7ZqGOXL94RGBHJHz1AaCr4SU1aEtGZ9NKNRLaGqtqUMVe5v2vNwaZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4590

T24gV2VkLCAyMDI0LTEyLTA0IGF0IDE1OjQ1ICswMDAwLCBKZWZmIExheXRvbiB2aWEgQnVnc3By
YXkgQm90IHdyb3RlOg0KPiBKZWZmIExheXRvbiB3cml0ZXMgdmlhIEtlcm5lbC5vcmcgQnVnemls
bGE6DQo+DQo+IExpIExpbmdmZW5nJ3MgYW5hbHlzaXMgbG9va3MgYmFzaWNhbGx5IGNvcnJlY3Qg
dG8gbWUsIHRob3VnaCBJIHRoaW5rDQo+IHRoZSBuZnNkX211dGV4IGlzIG1vc3RseSBhIHJlZC1o
ZXJyaW5nIGhlcmUuDQo+DQo+IFRoZSBjbGllbnQgaG9sZHMgdGhlIHNocmlua2VyIHJ3c2VtIGFu
ZCBpcyB0cnlpbmcgdG8gd3JpdGUgYmFjayBkYXRhLg0KPiBUaGUgc2VydmVyIGlzIHRyeWluZyB0
byB1bnJlZ2lzdGVyIGEgc2hyaW5rZXIgYXMgcGFydCBvZiBzZXJ2ZXINCj4gc2h1dGRvd24gYW5k
IGhhcyBhbG1vc3QgY2VydGFpbmx5IHN0b3BwZWQgcmVzcG9uZGluZyB0byByZXF1ZXN0cyBhdA0K
PiB0aGF0IHBvaW50LiBUaGUgY2xpZW50IGlzIHVzaW5nIGhhcmQgUlBDcywgc28gaXQncyBnb2lu
ZyB0byByZXRyeSB0aGUNCj4gd3JpdGViYWNrIGluZGVmaW5pdGVseSB3aGlsZSBob2xkaW5nIHRo
ZSBzaHJpbmtlciBtdXRleCwgd2hpY2ggd2lsbA0KPiBibG9jayBzZXJ2ZXIgc2h1dGRvd24uDQo+
DQo+IEkgZG9uJ3Qgc2VlIGEgZ3JlYXQgd2F5IHRvIGZpeCB0aGlzIHJpZ2h0IG9mZmhhbmQsIHRo
b3VnaCBJIHdvbmRlciBpZg0KPiBsb2NhbGlvIG1pZ2h0IGhlbHAgbWl0aWdhdGUgdGhpcyBwcm9i
bGVtLg0KPg0KPiBWaWV3Og0KPiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcu
Y2dpP2lkPTIxOTU1MCNjNA0KPiBZb3UgY2FuIHJlcGx5IHRvIHRoaXMgbWVzc2FnZSB0byBqb2lu
IHRoZSBkaXNjdXNzaW9uLg0KDQpsb2NhbGlvIHdvbid0IGhlbHAgd2l0aCB0aGUgdGFzayBvZiBy
ZXR1cm5pbmcgYSBkZWxlZ2F0aW9uLCBhcyBwZXIgdGhlDQpzdGFjayB0cmFjZSB0aGF0IHdhcyBz
aG93bjoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW5mcy8yMDI0MTIwMy1iMjE5NTUw
YzAtYWJmNTU4OWE1ZGY1QGJ1Z3ppbGxhLmtlcm5lbC5vcmcvDQoNCklmIHRoZSBzZXJ2ZXIgaXMg
bm8gbG9uZ2VyIHJlc3BvbmRpbmcgdG8gUlBDIGNhbGxzLCB0aGVuIHRoZSBjbGllbnQNCnNob3Vs
ZCBwcm9iYWJseSBqdXN0IGxldCB0aGUgZGVsZWdyZXR1cm4gY2FsbCB0aW1lIG91dCBhbmQgZXhw
aXJlIGFmdGVyDQoyIGxlYXNlIHBlcmlvZHMuDQoNCi0tDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4
IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20NCg0KDQo=

