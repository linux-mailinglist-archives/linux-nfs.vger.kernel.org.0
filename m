Return-Path: <linux-nfs+bounces-5859-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6E0962894
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 15:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E692829AD
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 13:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A6186E4B;
	Wed, 28 Aug 2024 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MlHi07c2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VoFtyew2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C675316BE1B
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851587; cv=fail; b=Y1qtlVkqWuZ2VecCoAiovHDT8AfXWI5xlQSivS7gL1tQDxX595moV4Sal1XSwZgQuoHfoqeUnZDOMJ+HuEh/AgciTxnDepNhUvEohQsKY85Si4Dq2YYCO+d1eInUlMW258XEXfDJwXDdI/Filr+wfJ5hpU45dhzYWj95WS58c8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851587; c=relaxed/simple;
	bh=irC7EW0gW01dvafmwYNKkosvhJMt75K7aZMW25nGwig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jik2pS6q137G9iUALTmPbRDFflkUnwka3ctvgiO/+8uL4lWn7wHC7DrnNW+YsDHuigOVg2zyq0eeC5lbpdWvv5eC425Wbt2CyuxT0n0+MJhX9geEvquHn5k9GZHTLVH8d9MaofSWeyolZwXLKJT6FLOOmwtYNslsXXh7JQgA22c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MlHi07c2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VoFtyew2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SCMZ1F008002;
	Wed, 28 Aug 2024 13:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=irC7EW0gW01dvafmwYNKkosvhJMt75K7aZMW25nGw
	ig=; b=MlHi07c2vkzyUodjpunKVSRbsVZJBbpDr4Esb95mgWwOCOmvh82u0DbUx
	uRU3uKiD+i5h4uGGwB1OGPoFbMI+TpeFDeMIFQihiDKWnfKHPX1bqPl9rXPjRX4W
	icrQQpGmoaGAivrZvWqT5umifatWvmgvQvw7PjRvB+vRwLsd5pkCEagujEvBFkbS
	32IwkwacqlZDjmRBYjMd3kCxdT4KTq9D+x3/2bEet71Jb/OOCVvdLFGnW5fj2t3+
	Msska2ewYrXUcDqLbFBvpUpggRVN+S1PsorzcZ32KdIb2rmXtwDnvaSl2Xe7hZHe
	rw6Jwlqt9NXQspUUGuxOW9RVl+IXg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pwys97r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 13:26:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SDHsBW036501;
	Wed, 28 Aug 2024 13:26:18 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jkty80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 13:26:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNndSbgC39UGd1Hqx2CVDODP6m80QeStBhgteNQ8x6dltZgOlq0eAXI8jKYBILcD8KIp1KnGEFLE0p8mxt4zPf9eeNvTK3nFvdrobty5sc5sPQBQc5jiTKdxNGlTnGGshu4dCimFhjx7bWWtB9m43R+70doyrYXQ2H/LupjMrv7+G5oz3BGd9iagtsLd94Z+r7DxUIb4qoilbvS43Vn+c3RsnpF9JGigHIvp5EwtWwRT2eQoWntnpYV4FKSoJVyxfgMxH++RGaIuqukeZQLNoGaLERMf39+kYmtDBFw+gxJ+8Rzxu1k1BD8yYOH/8BHvBPxH+OTOvnsnN/lEwvx6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irC7EW0gW01dvafmwYNKkosvhJMt75K7aZMW25nGwig=;
 b=fTu8wHIRDm+WxjTHZNtzyw2onMapraCl3KP92CrnF1lqR42yZhskzxH2vci0Dt5LyycUQ06lZQAQ4X095ox79A0OND6Bov2Z7Jc5VMlRzd7iq+QAjZYVtWy1MS8+YSUfHLO5UyeXhjvCuVRqfedD198lM5Y2FNFNusWP7sliMUa/zzQabJnGHDkOsWA6RrRImj50Unj9wJHkE22ozc7FFF2CkgWmjF1jxSQSr+jtH2B01Ja6rsK3xdc20GAfmQzNlrwgp3xrJzwnbyg7sHt7xIZMDDwvvZs5PRkkxML101ocbI04FHfhxCJtZVTeMXukSzCFqcKWddZ4Y7haVEv1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irC7EW0gW01dvafmwYNKkosvhJMt75K7aZMW25nGwig=;
 b=VoFtyew2CghNHJIIrOZEdMjO9sO3ZBQqLtc7bykoyaYM8LYWs9sETvgoE+seTu4TLGj4F7RKIdGYwJVeRvSPr+9lmxdHRARb7wL0V1GN34iEQhTri+bFZDP9M3m08/PhRCD+baSVibNAt2FFBtFqa21iCSYOo3db59TXqRNOqXs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA6PR10MB8205.namprd10.prod.outlook.com (2603:10b6:806:43e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 13:26:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Wed, 28 Aug 2024
 13:26:16 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <cel@kernel.org>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 1/6] NFSD: Handle @rqstp == NULL in
 check_nfsd_access()
Thread-Topic: [RFC PATCH 1/6] NFSD: Handle @rqstp == NULL in
 check_nfsd_access()
Thread-Index: AQHa+OOHwXLCpgvUWE+/uIU2jot4wLI73MoAgAAeRACAADqbgIAAdDwA
Date: Wed, 28 Aug 2024 13:26:16 +0000
Message-ID: <7EE6BB9C-C1DF-4A74-8851-E43480392BF5@oracle.com>
References: <Zs6SxCUgv8yl9aqg@kernel.org>
 <172482660567.4433.10002819732828170761@noble.neil.brown.name>
In-Reply-To: <172482660567.4433.10002819732828170761@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA6PR10MB8205:EE_
x-ms-office365-filtering-correlation-id: 00b0e2de-37dd-4892-ec55-08dcc764fed7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T3JhcG4xdjdVa24zOWpQMWNqbTJySk82L3daeEh1ZUMyejV3WGZ0eW1vcTJw?=
 =?utf-8?B?aWRldjI0RkZkOHBwanFLZTg1WDBVQ0FpckZOckFVUmpkS0NqaEtiR2Z0cVh6?=
 =?utf-8?B?OStyUTVSL3lOT0Q2V0FjTnJjM3BITFVTM2gzcmg4Y211WXViYW5tZ25tdkdT?=
 =?utf-8?B?R0d6WTE3VHcxMG01YTk3T2I2REtQMEVkeXJGWGt1K1UxU1c2K0NPdHBmdjdN?=
 =?utf-8?B?WVgyeVg2R00wejVTQ3hXa0VEbVMrRXhBbjV5NnN4Mk5SckMxTERPS2RJMlNK?=
 =?utf-8?B?VmZDZlZXWnI3bVMwc2pvc25ZeXZaYVJVSTN6SUFiRWNSZFF0Y2c0RUFOeE55?=
 =?utf-8?B?Q0JzNGRLTFdZd210MTUzRXM3ZEt4eUQyaFBCN0NuTnBKZE16YUtmYWM1TjVa?=
 =?utf-8?B?VUVhMVRCK0t4VkZFU3dITERwekZpMkJvdVEzQ3ZSa0s2M1Y5QkR3WEVVVjF2?=
 =?utf-8?B?OU5ZRW5NU2VrREJ2eHBzaS9zejk4YVl2Y1pEanU0bE9rekZSRVpFMzVHNUUr?=
 =?utf-8?B?aWg5LzJScmVVb2VIQXZZM0dQTFpIVy9ZSDF5SFJnMnE3M3U3aStPTXJoRWJs?=
 =?utf-8?B?Q0cxRG5WR0VZLzYwUDZBNG0xWFAxUkduNm0rRmRTL2ltRjRpVmdvcGVReEo0?=
 =?utf-8?B?OEhmU3JWZFhNUlMxTTZHYndEdlZxcHVqWWVnM1AzZXdMMjNzSXNpWkEzMjdX?=
 =?utf-8?B?d1FiaDMvVTJoMERnVHM3Ly9qbDlRMXliWHVPaUg0OHprcTVxYXBtK3J6dVN6?=
 =?utf-8?B?U2g0K1JBV3J0ZCtjdlpGNTVXeThFejlBbG9DeCt1YUNhNVNnNnV3N3dISVd4?=
 =?utf-8?B?cW54MXRxaEQ0UU13NktFYnVvbmJqK21yd1VpaHRqWlJYS25RRnBLNFNTOWM0?=
 =?utf-8?B?Q2pJQVZPUCtSR2F3a0p3VENVVmFNdnJWSnpZMkxTNlZjWXhGblNlZnJrQVFW?=
 =?utf-8?B?T3JyOGcwN2xTNFk5eGJRZ2xJdko4dzFjVmlqS292cnlwUzllSWZwSzJtLzhC?=
 =?utf-8?B?aFFwd25FVDJmTFI5RGpBUEZhVFkvM2huUWxvaW52NDBKL0l0enBBWUVOQ3RP?=
 =?utf-8?B?UXZUUWNLQ0FTT2Q0MmQ1UXZjNzZWYm5GeTNOcFhZcDE2YmY1MWdqMnp6N3cr?=
 =?utf-8?B?UFR2dG0yOHZtRXpkQUI3WloxTldLajdpNWZDRGlVNkJndElrbGxYMTZWSnpW?=
 =?utf-8?B?Z3lmTVl5S21jN1VGWm53anFxUVk2SWFOUm1NZXYyNDVvTVVoVEZ5ZC9Qd29X?=
 =?utf-8?B?VVJSUS9JOG15QUpkR2JLS1pIRVNhNWVLTmdKb1Y3MjFlNm5XTExOOU9lTU5M?=
 =?utf-8?B?MVNKQWQ4dTRIeTU1TlJCSFRoc3RBZlFPdy9LVnJ6Um14SmlhRVp1TUVmWWp4?=
 =?utf-8?B?Rlh1bEpMT0E0TmJTSlAwL3JzVlMydzM5VUFLVitYTTFBUXZJV1pKQmJkOWo1?=
 =?utf-8?B?VkZRWXBFdHNQYytpMXVYMlpPRHhhdW1IaERVVXNRc0phOUIyU3l6TkNyeG1C?=
 =?utf-8?B?eStiYkdzOU81cmg3VHJLRGlwbXlreHNkZVc1dk5vcHhlQ3hLcG5jdmhXb3V5?=
 =?utf-8?B?VlVhV3p4cWhTM0xDNExrSWg0WTRhTHI4Unl1dFU0TDYxTkp5YmdtVUJVeWZH?=
 =?utf-8?B?STdhZjZNTHlpcVZmMkUwR0tSWE85Q3IyT0tTL1FscnJyY2xpQjdieTlEK3Zl?=
 =?utf-8?B?NWx1MmlNMjFJKzMvS3lNWDVZN0hhTHQ2NkFhNjhHQUxoZFE0aGJrK05EZG9v?=
 =?utf-8?B?WlpEcjZiN3ordjN5dWR3WDc5bWk4Ym50QnVoOXNQVmZMeERDQVQ4a0ZUU2Rz?=
 =?utf-8?B?eHU3VEs0S2VqZCsxQ3JDVUdZU0lPdi9lK0xPUWlmS2dvOE9Sa0JDODNKUGRx?=
 =?utf-8?B?Wk5MQldLVURGOTg0UE9XQm1ZV29zckZYcXdBdyt4VzREUFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmpPc1NIYlNaQ1BHUHM2MXZvVk5BNExJUGExSUVpdXZEM0VlMXZJdzBodGYr?=
 =?utf-8?B?MWRpclpxVlgzb2Q2L1BrdXZ1T2VTeWkzb3VVSzFjSi9leWVib2F5VjRNRTMw?=
 =?utf-8?B?ZkxXeGlLWWl2dVhlbHdzMWwraHlWTGt4UWVtb3lqbWZBWFljOUdGVHQ1cVJL?=
 =?utf-8?B?ZzJVYUZnUEVVYncwWi9sRHgvb3E0M1NxZ3BMNVRGc1UrM0MySmU3SXZheVND?=
 =?utf-8?B?d2EzWkw0bk5TQjJwMGxMYjM0am1ySU9ENWtkOHJkaWdUdWh4U0c3WmxXdGNl?=
 =?utf-8?B?VkJXb0NqMFNpSUJyMU9zejI2L1ptZ2tKWVhhaTJBMElLU1MxVmtITk5TdFcz?=
 =?utf-8?B?WGUwejNxaENFazAvVVo4aGRKdzEzeGdtRzZ5WXczTXRYZmZJa1NrVmZ1eXhv?=
 =?utf-8?B?cUNvMk9KWTJ4SnhzYTJOMUNuc0hTQWJzNFlNWlVwY0paZXVhcEMxUDJ5VFlL?=
 =?utf-8?B?MmlzT2lUdXJXVHFEcXJuR1dydjByZk1lTjJ1NmFxaUJxQklrSGV6WGkxSU1X?=
 =?utf-8?B?ZzhlUjNweTdwQWZLU01sMk4rYmJFNHlXVmNLM1RlYjhyZGxMbzcxaTUzeXFo?=
 =?utf-8?B?THpLMVkrNXRiY3d0Tk9VZXYrdVMyYWxkWFltTU5WbTg1RDl0bUo3cmRoVXo2?=
 =?utf-8?B?L0FHTCtPRFd5Z0gzWWxQK0hOVVNCb2dyMkkxSnBRZGV3WkxBR0NKOVJ3OTQx?=
 =?utf-8?B?VGdKRHQ1QW5hckRHYnovQUNvcDAvVjNBVFJ3dWQ0dVU1QzBDYXlscXZPbS9j?=
 =?utf-8?B?aHU3V2g0UHRBcGFzTnpCOFY0SVZycGlPWHhPQ2JRdkV3ZG5oMjRJWW1QOUlJ?=
 =?utf-8?B?ZlQxR0NrRDNZK0VIbDlzQ0xPN2dGNm4rTERWaXloNHhZc2QwUW80RlV6R3hW?=
 =?utf-8?B?K0xUZUJVa2FETjF1OE1WRFNaeUZDSURPR1N0NFMveUwzZ29QcWIxQjNoR2k0?=
 =?utf-8?B?dWdDb25VYUtxc0libjJucXhsM0FIMjlJa3Y4VEsxV2FxOEtxd2NON0Q1ZDBM?=
 =?utf-8?B?dy9qc2RtNTJneVR5a3JPVjNqU3pDTDNKRzkwdUdTQy9wUW9DRUdIZVg3NmI4?=
 =?utf-8?B?TmloSjNHWWFKV2lOQ0JiRDlRM1kwcnZobk95ejJQMDZjZkZ1dXVUK2NUQTdE?=
 =?utf-8?B?K0VScEhxN3NJcFZ4NnJxUytSK0J1TWJ1QUJHUFBsd2FpalZiYW5XRWtTRG1k?=
 =?utf-8?B?Mng0d2tkc3cvOHRtZkhQanhSN3Q3U2NsZ0ZMRmhtZTNMQm5XTHQ2Q0txRTdG?=
 =?utf-8?B?VmNQRUlhb3VuL0NPWW1pY0VGZzZKWmt3NXlwZ3BGdmNEZC9mQmwwMDBHQ1hx?=
 =?utf-8?B?dTRTSTZoZmptRnJkeU1jcExpQWZ3eTNpMXRIS3RsalowS09DZmpGT1BVakdF?=
 =?utf-8?B?MDZ2SlJTTVViMnJSNFFwa2xrMnRLNlBjekdkSWFORWJqUy84LzV0VkFFbEFU?=
 =?utf-8?B?TkFMQzRrUkZSeFRpQ04xeWpVSVZBdzlZYmJZN2llRGhvK1hmYzJTTWJPa0NF?=
 =?utf-8?B?dlZBMzV3Y0FZOU9MZ0w0Z2p1NGIyYXhJRS83cUpsZlR1TGowckgvRTZTRENr?=
 =?utf-8?B?Q0dlczFmTVlUVjI5MVlnT2I5a0lWOGRkc1oyeHFrZ1IzQ1FuUmlENXo0UCtM?=
 =?utf-8?B?aG03Wm1qaktjbXlrU2EyUEtPUlAzaVorSEdUbU9DMmpVZXExd3FWbDZZL3lQ?=
 =?utf-8?B?S3o5WG9IS2NONzJRaUptWU9oK2Y4cmI4TFFBQzRwMnpEZGJWajhMSTltOURR?=
 =?utf-8?B?aWpqbkIwUmIxMXlselpTL2EvKzNlUFlpdmVBMWhKYk9JeUZQS09kUlFFaVVI?=
 =?utf-8?B?RVpnZFVmNmdETXpZYXdXcG1pWW1MWFNZTE5PaXhLT3Nua092cUwxdTRnTHJF?=
 =?utf-8?B?Rm1kTDNQbFhlZzJIZVV2TllnMlZFUTNvMXFocmVkYTRqY2h5VXRaL09sOVkz?=
 =?utf-8?B?T1NFbGlLZyt5aWI1M3JoYXM1TVpOYkVLS2V0NTFOd2QxZjRlYnRuaFJCUHFR?=
 =?utf-8?B?eU8reUNBWHhKazY0eC9hM254T0JIcWRUWGt5b2hxVXpvMGV6allBLzFnMjRO?=
 =?utf-8?B?Qi9Xa3BURkFwRlFwQTlZYXFEaHNJcGNOZXB4U1FpeHVDZzBxbG12ZVVKbEtB?=
 =?utf-8?B?b0dWTUpDSEcrdTFOR1pmbUUwS29WWVFQVEYxWDJ0SDlRTmFkRmJJZWs1dkMz?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C025CBC2DC46334DAE3642D952AA079B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TtJnZDiiv6JIPLrr53iaLdunu7s5t5JP8NFF6AQR7fkRkE0Iejn6TlVbfp+wEi8Cirpz6kmwc6uUm8CYyfXDDoSWCF8jHtRJXJq9R3Z7Sx9d8oquW6XrTXG9ZnE1bzV+GastZIRmxnTvxmEuwtsBfuEtsG2dWs1/Oyh2xBCH7JTG+2Rz3dr0OP+AcxDauYI+TTaS6Umfh4zKJHeY628yr5LiQWAd5KESnAWtYA6emESYYuT7BXPqFx5qlLoN9TjJOHZMymEh9jb5mC964fFX4h3DnPglahPJ68/lors2lH3QCNIAKCYpSAtfDKRtN272tNRSCgW8dri9u2Sw45UFZupDIZNf7s2MF+6Jzgwpje7yxbChve3Ej5pCLR8HTexwcNWrRcbuTCyLVjmbG0R8rqdgojsKOONW1V9B87EkjbLN3PI7T6k4WneyqKqXTTlgqevOkFuIiQBhlU5VVpcemtNpc4Yr1qLu1dTGRPH54CM7gJrN5Vjf+P1UNpFSM5UaBDeHiv+unZr2e0aux8J73aVsi5Hr/G5aBYWduQprsgdBS1hKAuBazOcXk3H2szEblznV9BaiRdRGqyiRZaXK0W7O0AKKTx9yhyfXYxf4/BI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b0e2de-37dd-4892-ec55-08dcc764fed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 13:26:16.5481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+SA1h+8DuxPnO439JiLWmbm+eIijEPLPWsOF5wwt4mLkshvZflb1Vu+jK/fmP6KWYIu9eXlCdC163rk+7ufvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_05,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=889 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280095
X-Proofpoint-ORIG-GUID: XaVdpmUKHtUKAXQhyhPVy3lyVeYncXag
X-Proofpoint-GUID: XaVdpmUKHtUKAXQhyhPVy3lyVeYncXag

DQoNCj4gT24gQXVnIDI4LCAyMDI0LCBhdCAyOjMw4oCvQU0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDI4IEF1ZyAyMDI0LCBNaWtlIFNuaXR6ZXIgd3Jv
dGU6DQo+PiBPbiBXZWQsIEF1ZyAyOCwgMjAyNCBhdCAxMToxMjowMEFNICsxMDAwLCBOZWlsQnJv
d24gd3JvdGU6DQo+Pj4gDQo+Pj4gVGhlICJBVVRIX1VOSVggY2hlY2sgYmVsb3ciIG9ubHkgYXBw
bGllcyBpZiBleHAtPmV4X2ZsYXZvdXJzID09IDAuDQo+Pj4gVG8gbWFrZSAicnFzdHAgPT0gTlVM
TCIgbWVhbiAidHJlYXQgbGlrZSBBVVRIX1VOSVgiIEkgdGhpbmsgd2UgbmVlZA0KPj4+IHRvIGNv
bmZpcm0gdGhhdCANCj4+PiAgZXhwLT5leF94cHJ0c2VjX21vZHMgJiBORlNFWFBfWFBSVFNFQ19O
T05FDQo+Pj4gYW5kIGVpdGhlcg0KPj4+ICBleHAtPmV4X25mbGF2b3VycyA9PSAwDQo+Pj4gb3IN
Cj4+PiAgb25lIGZvciB0aGUgZXhwLT5leF9mbGF2b3JzLT5wc2V1ZG9mbGF2b3IgdmFsdWVzIGlz
IFJQQ19BVVRIX1VOSVgNCj4+PiANCj4+PiBJJ20gbm90IHN1cmUgdGhhdCBpcyBhbGwgcmVhbGx5
IG5lY2Vzc2FyeSwgYnV0IGlmIG5vdCB0aGVuIHdlIHByb2JhYmx5DQo+Pj4gbmVlZCBhIGJldHRl
ciBjb21tZW50Li4uDQo+PiANCj4+IFRoaW5rIGV4dHJhIGNoZWNrcyBhcmVuJ3QgbmVlZGVkICh1
bmxlc3MgeW91IHRoaW5rIGEgTlVMTCBycXN0cA0KPj4gX3dpdGhvdXRfIHRoZSB1c2Ugb2YgTE9D
QUxJTyBwb3NzaWJsZT8gIHdoaWNoIGNvdWxkIHRyaWdnZXIgYSBmYWxzZQ0KPj4gcG9zaXRpdmUg
Z3JhbnRpbmcgb2YgYWNjZXNzPyBzZWVtcyB1bmxpa2VseSBidXQuLi4pDQo+PiANCj4gDQo+IEkg
YWdyZWUgdGhleSBhcmVuJ3QgbmVlZGVkLiAgSSB0aGluayB3ZSBuZWVkIHRvIGhhdmUgYSBjbGVh
cg0KPiB1bmRlcnN0YW5kaW5nIG9mIHdoeSB0aGF0IGFyZW4ndCBuZWVkZWQsIGFuZCB0byB3cml0
ZSB0aGF0IHVuZGVyc3RhbmRpbmcNCj4gZG93bi4gIFNvIHRoYXQgaWYgc29tZSBkYXkgc29tZW9u
ZSB3YW50cyB0byBjaGFuZ2UgdGhpcyBjb2RlLCB0aGV5IGNhbg0KPiB1bmRlcnN0YW5kIHRoZSBj
b25zZXF1ZW5jZXMuDQoNCj4gSSBkb24ndCBrbm93IHdoYXQgaXMgYmVzdCwgYnV0IEkgdGhpbmsg
d2Ugc2hvdWxkIGhhdmUgYSBjb21tZW50DQo+IGp1c3RpZnlpbmcgdGhlIHNob3J0LWNpcmN1aXQs
IGFuZCBJIGRvbid0IHRoaW5rIHRoZSBjdXJyZW50IHByb3Bvc2VkDQo+IGNvbW1lbnQgZG9lcyB0
aGF0IGNvcnJlY3RseS4NCg0KTXkgZ29hbCBpcyB0byBkb2N1bWVudCB0aGF0IHVuZGVyc3RhbmRp
bmcgaGVyZSwgYXMgeW91IHN0YXRlZC4NCkkgd2lsbCBsZWF2ZSBpdCB0byB5b3UgYW5kIE1pa2Ug
dG8gYWRqdXN0IHRoZSB3b3JkaW5nIHRvIHlvdXINCmxpa2luZy4NCg0KDQotLQ0KQ2h1Y2sgTGV2
ZXINCg0KDQo=

