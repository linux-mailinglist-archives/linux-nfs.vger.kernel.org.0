Return-Path: <linux-nfs+bounces-4186-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 927DF911141
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 20:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484C6283F9A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 18:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490001B5835;
	Thu, 20 Jun 2024 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kpSxYN9h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KsuztXXi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536BF1BA09B
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908613; cv=fail; b=YbRDeYnkdUpiuAg/S41p1yJYBUEUphvFiqMkaoDIlmnFDY+a3L4Pf+zNJyD/401N/nZz81yM1GiUILDytdp3tBZjGjI9vyg+8VEOLYZXFigfEB86LZ6MszpU5kziJqKhhWsDbG/dZ5aWhgKCeaWL0oAILzukbcKc+RUcL60cZUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908613; c=relaxed/simple;
	bh=jkRXvk2tBtLX6jSuEwtsc//TnKaGh0jGvWfKkrwX9OM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RANB3Fjb+lF4nYnIoswR6ObZsZwRu7cSyOu5JRbj31TtP+dSAeQEKanM3tkF85yIF+ptJc7uZ9ULtDG8QI9YCuH6itGFvqPkp10KpXQoQMMjpPa57kzhDzkt94UVRgc/dGnBZad0EOdrxual7s8XZ8SGGW+u7eaf+slz4DT+H4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kpSxYN9h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KsuztXXi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHB9wl009907;
	Thu, 20 Jun 2024 18:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=jkRXvk2tBtLX6jSuEwtsc//TnKaGh0jGvWfKkrwX9
	OM=; b=kpSxYN9hgcR4QxrLJAhMUmQe0kTwdJWZRUNWYYa5PzeeEMfQXBjsYlrO6
	CURqUDPk7c8B5tLjxdmd6Nq0C8yemoIDGk7SLGrReTDdheg5eKtKi6B4WRZEnwXO
	2U9OH4tem29r+Lt/ParXIm9+kxj57d77leiOEf7z/7LWUpYYS9czu387tHf5KsCm
	na6YqUDMIYXEZQXgQ0rGY6rZGfhy00VlGjuyAvQv3y9+QkazO+xp+Um3y3BwSsrg
	lYhd+2oBdAH1BhOuFyOGPZnzIB5Xe6/gr562EE3Foh9PkCx1c9khXl+xk/CtOUYQ
	AIDFaNGJ5NVx9rFFVXUadXBJWouqA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkj059b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 18:33:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KHE2UO025124;
	Thu, 20 Jun 2024 18:33:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn5324j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 18:33:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLqBzItZ5Kpu7CyZivLU8HVCtbHm5cJ3LsEtE9i8OIRTGr8wPNZnBht969yzEENcyjoq1ZwaMfIY+ej0SAuoQf1l62jCNpbCN57i9FIj3+j1RzFcO+KIhwS3eOJf7FB4/q8LVHSFx+4c4UWQzU+lEmg5NrypAmznPC2K2Z6d2JsYvWU+UcUXV4yrZCqJQztNXfHAAkJAlHSbccBpCu35zBPPxFJKu2JmLDc0O22iyjW4lM1bk+j8lNPV06U7+eqHObKEP54KUOQpNR8GF6/2SxvqNYgMLVW8tfNqrtDLIUbKw3sYVY6LkTUYeAYDoLDvdmmCfzQBZ6SgD06VFuQ+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkRXvk2tBtLX6jSuEwtsc//TnKaGh0jGvWfKkrwX9OM=;
 b=ofwscjJ2JxboLP9d2xrpBkcwnV7YO63xdeH96jgECk2g4GgtTas5w3ZfkkbLqKf3y0Zm9F36F1AVIBOTyIc6I0hb1NTB48tPH09sVbclp/P0h/zZqCU6VZghU/qMU66GtItljC+jC8bvhjtS+AGnbUTrmyKBAZgKiva7UfNedATB4SWpPZuibath7DlYrjfT0do7VqZCQEvZvBqIBM57KJTnG2tsXUatRvz3OD7mUtaQClKNVaT8o/61yurffBE1qUCGuq3MJ7lhU10fd8YYxqgn0nVo9p8XnOhKycNwmKYX9rHRJGI20CIbOAvT6/bRY1PQRXZIikVgIetZrmVvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkRXvk2tBtLX6jSuEwtsc//TnKaGh0jGvWfKkrwX9OM=;
 b=KsuztXXigXDiqO7dP8WZSU6AhaPfO4c15uZNwRwtRzG2JzX7Dq7Cls0Qc8lsyks9s5zrBoBG582BibVDHTwxc29heYpr+vAjp+ByIERHdGhN5ljTltUlseYCuuEBbNU9rwvRsG19aveNby8NNVnVMThyVI4PMwsqOFnFTYpNSfA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5809.namprd10.prod.outlook.com (2603:10b6:303:185::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 18:33:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 18:33:39 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>
CC: Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: knfsd performance
Thread-Topic: knfsd performance
Thread-Index: 
 AQHawa3dybcUo3ed40e1woBUDQls6LHN2rIAgAANu4CAAAKdAIAAAygAgAABH4CAAFB+AIAABSQAgAFWC4CAAFUVgIABDUAA
Date: Thu, 20 Jun 2024 18:33:39 +0000
Message-ID: <2F6F431C-59AE-4070-B7FF-CF456B95CBB1@oracle.com>
References: <ZnIpfgCrRe95sXdr@dread.disaster.area>
 <171875886281.14261.15016610844409785952@noble.neil.brown.name>
 <171883231568.14261.16495433738354176501@noble.neil.brown.name>
 <ZnOUG2Nh80vTJXxe@dread.disaster.area>
In-Reply-To: <ZnOUG2Nh80vTJXxe@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB5809:EE_
x-ms-office365-filtering-correlation-id: ff701062-01a1-4123-6e1c-08dc9157810e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eklNNFRJak5pTDlVWGtYNDdxTXA5U0U4dC9DUHIreGhRSzU2dmlIdDduNjBM?=
 =?utf-8?B?Syt5ZGhMM0VZcnJ6VDRKYmhaOW5ncUZsYnh3ZnEwQVcwdjFjU1VGRll3eHZK?=
 =?utf-8?B?YksrMXZIdnExOVhDYTArdmZBMjczQ2xOdlVqV3dhRjA5QTEzSCtvL0xVQ2RG?=
 =?utf-8?B?bVl3QUluQzFmQnpCOURheGo3Z2Fpa1lrMGhkOGtSYmM3bC9rRmR3ZU1mWVdi?=
 =?utf-8?B?bUw0RjBvYkRwYVk4eWxzL3RpbTk4NzBpQ2hGeUk1Y0pyaUZvOGVnTVRnWTFu?=
 =?utf-8?B?YTIybGNRNnBFTDhjeUFsZktmY1FXbkhsWEJvZ2FDcjFJeUtQZ2lBOUtMVnBF?=
 =?utf-8?B?SHp0NGQwRUpoQzU1eGZ2YmM3VmhkUk5qMVgrNjlEY1doU1ROdjArcU1WRExE?=
 =?utf-8?B?eWFvc1UrZFV3ajRHTkFraU1NOHJtdXplZjQyOU03NmZBSlMxQVUvVkJQQjJY?=
 =?utf-8?B?SzJTZnY1MHZISkw1bFhlZjJsMG1yKzFHL0RGMXFEMmcrZ292S2VNaHplS3JF?=
 =?utf-8?B?cHRPc0k0aE53dFZreFN6SU1IY09SSHgwbVBwOXIwZ2g1ZDMwdGZkRzJqb250?=
 =?utf-8?B?eVFrZUhhKzVtV1hBQTJOLzI1Q1VCZGs4WUJsYzB6UGl5YndZRGtkTm9TMnFn?=
 =?utf-8?B?RW5WS2RiSXZYVXpxcnpvSEZoLy9lU3VPdmc3bDJ5Mm1QMGMzVkZjd2lXU3do?=
 =?utf-8?B?WndzdWFrSVU2Q2lLMnR0UGNVNFJNVmZIRDBSekUwM2dnUzBZRHF5VHRITFBo?=
 =?utf-8?B?ZEtzUmhhVnpqZkdyNkhhWWF5c0hmdk8rR2pLK0xGdU1wOXByaXBDbTlQY0dE?=
 =?utf-8?B?c0tpK2Y1cE9aNG5Lb3JmRnA3NU94ZitzcnFjQ1d2bTIyQlpDSWxFUmx2cHFz?=
 =?utf-8?B?VWdtUHJ5dllXVnE4SllVUm5FdTI0d2twTDArSUJrSmI5YndwYU9sSWtJODNp?=
 =?utf-8?B?c2xEV1lsQXVjMUg2TUNPSCtQK3p3YzRVRlV1aDFoSlNiek1CNmJKYWdrL204?=
 =?utf-8?B?WUxteXZOaHZEZFJqbjBTYmhxenU0Rnd1blJhcWxmN1hRMnJYTGZWa0poNXpH?=
 =?utf-8?B?SUh3QjEvZUVIcGF6Yy9pWWdqYUxLNDlGK2R0bCs0cThYeEhNSk55VDNDQWhp?=
 =?utf-8?B?VVEwblplTDBZcjdMM3VFR3czZUtCR05SRGZReXBBZGVWdmFpV1FTMG9JNUJi?=
 =?utf-8?B?bWNuWHRXM0phaDA0U0p3a3h5YU0wWFdtdXNQOU5seXpMM1M1Z1pFWmpRVnBR?=
 =?utf-8?B?c1FFNUxNVkcwV0NKZmlhakRmRzVOS3lLUm9zekd0MDc0Rzl2dFZad2tGY0RC?=
 =?utf-8?B?bmhxRWllQkxaMFlYc2tGUzl5QjlsQllubzhNVU83Ly9qSWtNRS9jdUFRVHo5?=
 =?utf-8?B?eHFuWHR3NGNYQXZjNnVvc3E0TGxWcFNCTFdxTldzenV1V2lEYTFVdWZET3hq?=
 =?utf-8?B?Z05nZmZYSFkvMkZ3L2hYcTRSbDQyUy9YdEFERlhLYldWMHk0d0IrcmpGZEt4?=
 =?utf-8?B?MDA5WUxRaXk4TEFQR3NkRDFWQmVmSUM2QUpjdEQvNWhLK1RqZGdLS05KY2kv?=
 =?utf-8?B?RytJa1pvQlQrcWhQTDhUSjVTdHFvOThNVkNUdTBPYm4veWsvSnlyTVcvek4x?=
 =?utf-8?B?Y2g2NzhoQUxmSEVFZlBoSEJVM3I1VlQ2bWQwQWE5NkkyNW1TMXhkUFV2Z1c3?=
 =?utf-8?B?Q2x6WjJzL2dBMGhlZjhOZjdMcU93M040NklFMllWQ3VrRlVhRWkwVm1PdlhP?=
 =?utf-8?Q?8PZ1uF250Z8oGafwr2x6gswCpV0zgquB2OlHWIM?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SXZLM1dKTmFCbjlCUmw2STQ2MG9sRnp1V1RsdlNVTFRkS3orVzFWUlJnNjNO?=
 =?utf-8?B?T0NnN25WS3V4QnVPaU5sMWVBQmpsaEViNmt0RGlmdG9KYXIrMU9QbGhKZCtE?=
 =?utf-8?B?bGVyRXpZTVRsdnF2OXBhL2JVUFBsNnQyRmtxaGFTQjJSTzVsVEIrNVEvekVh?=
 =?utf-8?B?UTJsSlkrM2pSOTNwRTR3cFViYngwdTY3b0FyMkhiNW54bC80R01EcW9WSmYw?=
 =?utf-8?B?eFhyR2c2OHNQZFJ6OXNSSStYQVNnMEV3RG50LzZLbjFGemFpNENBeVRUZUYy?=
 =?utf-8?B?Z3QreXgzdEkrcTcwWjNCWkRMMHJITU1KRXkvMENuTUZIWUgwNDFWcVFBQ090?=
 =?utf-8?B?QnEzU1MvMGpVQzVNZ0FESkZPNmJma2l5TVErdnNkV0Mycnd6TTlvdGxUMnpN?=
 =?utf-8?B?Z01UL3h0MU9XSTRZdWxJK1kvNE1Lc0NJZVpaeHNVeHdzeHlrY09QaFJXUjBP?=
 =?utf-8?B?YVNZZUhLU1c1VzNCazRmRXl2QjdaQU5PTkpmQmFYVnNMcXJZOHAzWW1UTG1J?=
 =?utf-8?B?WkIzWlRsc0dheGhWTGdOcjdteExieVhzVWUweldNUlFnazNOZUE1dzAwQVdt?=
 =?utf-8?B?QXV6aGJPdlc2OVlNUmRCaUFxWHBIVlFtNGw3SXlHRkVlRWUyQzVlSEtCbXYy?=
 =?utf-8?B?dW55QXdreXNLNjBUMW5RTHVGVFBTZklVR0EwRVdqV0h4UVJWVFBSUGJUWEty?=
 =?utf-8?B?Q3Fmd0JNYUt1dFIzU25ud0hQQzc1eVczZzVqRFhFc29sREhHQ25TZzlmUXVT?=
 =?utf-8?B?QkNNd1VzeVJrOE82Q2llalZQSnB4SVZRZ1NYc2QxM09sYWp4OXNJTGZNSEtz?=
 =?utf-8?B?OW5GclJpa2N2TlNVbWdtNWozalRSeUdYcDRPTkZZQlN4OGxuRHJJRHNRc3dQ?=
 =?utf-8?B?TXU1SnFzZmdsMFB4alpXWDlJU0JRMERYRmhFazFyelgvRU9GaHZuWFFsRlB1?=
 =?utf-8?B?aytVaGdOTUxEeEcwcjBEWjdPTjVQR1dyRmQwMU9Pc2N2d21HckZvdzB3T1Yv?=
 =?utf-8?B?NXN0V29IWXRTYXlGZFVYOUZjNzI1M2NueXpqMVBlMGNwRHNPWWpiczUzMVpi?=
 =?utf-8?B?cDdFbDlmRUZqWXdWWHpUYVZDZ3hUYnJPZWIrTkMxbkhMWUhvT2NkVklOMDg4?=
 =?utf-8?B?TUQyMUFSWVlReGVUOEs1aE9kVWVnL3JkSjl6R0d2a05xN1p6RmxIM29RNlVX?=
 =?utf-8?B?c2RNSTlid1hOTUZoeFRHOUVLT0JaM0VXbzRoR3lDdjhaRE1xZUg4WSsxcVRP?=
 =?utf-8?B?WkRMRE9HY2NyY1g1QTBYc3Znai8rcnZuOWI4NEtDTWpkZ1czQ2MzQ0J4OVo2?=
 =?utf-8?B?RG5nNlRsVUF3UXh2WVA0K09qUndZSk4wL05EMWVyRnBHeFJ5U2hFK05KaEU3?=
 =?utf-8?B?QUh6UVh4cjRIeXl5Z0IzZlJwOGE0Wlo2ay9Oc1lCMDA5ZVNVNFpTOE1RS3dC?=
 =?utf-8?B?dy9Tdk1zMHFhR2thYXEyb25uZG5reEJOUFdvaW51dys3ckszTUdmYWdnSUtO?=
 =?utf-8?B?SkNpclBnNGNobjk1cm5YOHpsTlg1Q2pNcDNPbEtNL3VGeXU0ampyVE5TUnNq?=
 =?utf-8?B?cFBJdnkrSitRZ1RLbU5ubzhwQUp1dnRzTTV5M3YrUnVzMVNVaWJFbDBNN3VH?=
 =?utf-8?B?M0N4S1MwUW1peFd6aWVDakswK0FxOHpkT1UxVklFUDZDVUNxbnRjdndCckJy?=
 =?utf-8?B?YmR1TDE5aW1QTStXcDNVbW5IMWozcldxTzhjZXRPcjMxWWJ2MUJmYnNac0Fv?=
 =?utf-8?B?RUpQWUN1VTZVSHBtejhHWkdLMkt0RGVkSk9RZzE1SnRoQkphUUM3V0dxc0hl?=
 =?utf-8?B?UENBaTE3WmRVUDRFRXJWMnorV1BSUlFmSHM0dFBqODd1U3p4MWxPL2MzbFNN?=
 =?utf-8?B?VkpwVjlicGdpWUhneWdsL0o3Y3IxMkkyMlFlNE4xeEFpbFNxdjZJT01lTmlW?=
 =?utf-8?B?QUVDYm05WWJZMEtOMWpMa3ZIYVZrZFZjR1lNQVdsMHpsczM5azZuaU5sVERj?=
 =?utf-8?B?WTIvaWhiK3ZRRGdwUXJFV0gzakpFVnM2c1p3OGpCZU0rbExlRnRCUEdUV2tG?=
 =?utf-8?B?a3dDVjJRek04NkFzdm10ZEd3TUhwSHUxUHRwRDZ3VFFqRk54K3dwa05HSDQ1?=
 =?utf-8?B?T0RsY1ZvdTRqbDl0dU83amxoUXVjdnVRbXRpbHlsK0krdmFUSDhKUGFIMG1a?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70726349AC63C140BB527991DE7E4A33@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PiOMhKzFnNcMlOeO/DRfw1YTcoRtqX4S7KCyMHokeqnIRedC+fo0pMkcjZ4x3R2A55HXOzdN7Fg7OmY3hKpEWngeAChnLCUAN/KHVX7bhOZwVLmwAI1uiuviqWqQHtXn5Ir2jAT+znlstgsh0SdbW9yXopJHxcapw02dSB2iFYR7JjQOFIVFu63WNs3EbMpkoqLaumhuTr9hGW+4HfjKPKLTxfiWcDyRxGh78NMK2vV6hzR3N0VCMUdqmGozdXiPzcnqr7H+sABJvFvRLSt6F7ABhjD/k9+aNdWfk5cCiRoYxQlfuwYcSqGuNu60RveyrIrjoOgs/jIa2mSqOgO8s/A2f7/H4tc/1rxizOQLCnlbdl79wZwGgXCw1cICfJUyLr2zVG3b4zmHGYTlHIJGDUybvHUukMjjGZbVEJjBQNSjUJjsyywLuUyGZcqzqR1JSURG+9P/lMptVkLAPjzObgPVS+acUsi806s8ZgjYS0tuarZqHiZa/ewUpQwVM+bex8MtIHq1KXZiIgkBdcwbdShyMYA77/cimj9GhiM0BO+tmhhxp+MGQX7/mboPIfvwqaJK16Lk/nQcjRvimwsw8qH2q+QeXSY8+kwqlyHzitE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff701062-01a1-4123-6e1c-08dc9157810e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 18:33:39.3103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G6Z1nnlpIWZULX2hXZqkH/10DNheq5krKdXm7Gg2F8tcaq6C1WLTh2/ZTokU/yeeu0B01W0LdOoDNbmKM5Y8HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406200134
X-Proofpoint-GUID: CSQpSOkDtfWOZ2DN7XYte2hQgBVTIMxX
X-Proofpoint-ORIG-GUID: CSQpSOkDtfWOZ2DN7XYte2hQgBVTIMxX

DQoNCj4gT24gSnVuIDE5LCAyMDI0LCBhdCAxMDoyOeKAr1BNLCBEYXZlIENoaW5uZXIgPGRhdmlk
QGZyb21vcmJpdC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBKdW4gMjAsIDIwMjQgYXQgMDc6
MjU6MTVBTSArMTAwMCwgTmVpbEJyb3duIHdyb3RlOg0KPj4gT24gV2VkLCAxOSBKdW4gMjAyNCwg
TmVpbEJyb3duIHdyb3RlOg0KPj4+IE9uIFdlZCwgMTkgSnVuIDIwMjQsIERhdmUgQ2hpbm5lciB3
cm90ZToNCj4+Pj4gT24gVHVlLCBKdW4gMTgsIDIwMjQgYXQgMDc6NTQ6NDNQTSArMDAwMCwgQ2h1
Y2sgTGV2ZXIgSUlJIHdyb3RlICA+IE9uIEp1biAxOCwgMjAyNCwgYXQgMzo1MOKAr1BNLCBUcm9u
ZCBNeWtsZWJ1c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4+Pj4+PiANCj4+
Pj4+PiBPbiBUdWUsIDIwMjQtMDYtMTggYXQgMTk6MzkgKzAwMDAsIENodWNrIExldmVyIElJSSB3
cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IA0KPj4+Pj4+Pj4gT24gSnVuIDE4LCAyMDI0LCBhdCAz
OjI54oCvUE0sIFRyb25kIE15a2xlYnVzdA0KPj4+Pj4+Pj4gPHRyb25kbXlAaGFtbWVyc3BhY2Uu
Y29tPiB3cm90ZToNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gT24gVHVlLCAyMDI0LTA2LTE4IGF0IDE4
OjQwICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4g
DQo+Pj4+Pj4+Pj4+IE9uIEp1biAxOCwgMjAyNCwgYXQgMjozMuKAr1BNLCBUcm9uZCBNeWtsZWJ1
c3QNCj4+Pj4+Pj4+Pj4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4+Pj4+Pj4+
Pj4gDQo+Pj4+Pj4+Pj4+IEkgcmVjZW50bHkgYmFjayBwb3J0ZWQgTmVpbCdzIGx3cSBjb2RlIGFu
ZCBzdW5ycGMgc2VydmVyDQo+Pj4+Pj4+Pj4+IGNoYW5nZXMgdG8NCj4+Pj4+Pj4+Pj4gb3VyDQo+
Pj4+Pj4+Pj4+IDUuMTUuMTMwIGJhc2VkIGtlcm5lbCBpbiB0aGUgaG9wZSBvZiBpbXByb3Zpbmcg
dGhlIHBlcmZvcm1hbmNlDQo+Pj4+Pj4+Pj4+IGZvcg0KPj4+Pj4+Pj4+PiBvdXINCj4+Pj4+Pj4+
Pj4gZGF0YSBzZXJ2ZXJzLg0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gT3VyIHBlcmZvcm1hbmNl
IHRlYW0gcmVjZW50bHkgcmFuIGEgZmlvIHdvcmtsb2FkIG9uIGEgY2xpZW50DQo+Pj4+Pj4+Pj4+
IHRoYXQNCj4+Pj4+Pj4+Pj4gd2FzDQo+Pj4+Pj4+Pj4+IGRvaW5nIDEwMCUgTkZTdjMgcmVhZHMg
aW4gT19ESVJFQ1QgbW9kZSBvdmVyIGFuIFJETUEgY29ubmVjdGlvbg0KPj4+Pj4+Pj4+PiAoaW5m
aW5pYmFuZCkgYWdhaW5zdCB0aGF0IHJlc3VsdGluZyBzZXJ2ZXIuIEkndmUgYXR0YWNoZWQgdGhl
DQo+Pj4+Pj4+Pj4+IHJlc3VsdGluZw0KPj4+Pj4+Pj4+PiBmbGFtZSBncmFwaCBmcm9tIGEgcGVy
ZiBwcm9maWxlIHJ1biBvbiB0aGUgc2VydmVyIHNpZGUuDQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+
PiBJcyBhbnlvbmUgZWxzZSBzZWVpbmcgdGhpcyBtYXNzaXZlIGNvbnRlbnRpb24gZm9yIHRoZSBz
cGluIGxvY2sNCj4+Pj4+Pj4+Pj4gaW4NCj4+Pj4+Pj4+Pj4gX19sd3FfZGVxdWV1ZT8gQXMgeW91
IGNhbiBzZWUsIGl0IGFwcGVhcnMgdG8gYmUgZHdhcmZpbmcgYWxsDQo+Pj4+Pj4+Pj4+IHRoZQ0K
Pj4+Pj4+Pj4+PiBvdGhlcg0KPj4+Pj4+Pj4+PiBuZnNkIGFjdGl2aXR5IG9uIHRoZSBzeXN0ZW0g
aW4gcXVlc3Rpb24gaGVyZSwgYmVpbmcgcmVzcG9uc2libGUNCj4+Pj4+Pj4+Pj4gZm9yDQo+Pj4+
Pj4+Pj4+IDQ1JQ0KPj4+Pj4+Pj4+PiBvZiBhbGwgdGhlIHBlcmYgaGl0cy4NCj4+Pj4gDQo+Pj4+
IE91Y2guIF9fbHdxX2RlcXVldWUoKSBydW5zIGxsaXN0X3JldmVyc2Vfb3JkZXIoKSB1bmRlciBh
IHNwaW5sb2NrLg0KPj4+PiANCj4+Pj4gbGxpc3RfcmV2ZXJzZV9vcmRlcigpIGlzIGFuIE8obikg
YWxnb3JpdGhtIGludm9sdmluZyBmdWxsIGxlbmd0aA0KPj4+PiBsaW5rZWQgbGlzdCB0cmF2ZXJz
YWwuIElPV3MsIGl0J3MgYSB3b3JzdCBjYXNlIGNhY2hlIG1pc3MgYWxnb3JpdGhtDQo+Pj4+IHJ1
bm5pbmcgdW5kZXIgYSBzcGluIGxvY2suIEFuZCB0aGVuIGNvbnNpZGVyIHdoYXQgaGFwcGVucyB3
aGVuDQo+Pj4+IGVucXVldWUgcHJvY2Vzc2luZyBpcyBmYXN0ZXIgdGhhbiBkZXF1ZXVlIHByb2Nl
c3NpbmcuDQo+Pj4gDQo+Pj4gTXkgZXhwZWN0YXRpb24gd2FzIHRoYXQgaWYgZW5xdWV1ZSBwcm9j
ZXNzaW5nIChpbmNvbWluZyBwYWNrZXRzKSB3YXMNCj4+PiBmYXN0ZXIgdGhhbiBkZXF1ZXVlIHBy
b2Nlc3NpbmcgKGhhbmRsaW5nIE5GUyByZXF1ZXN0cykgdGhlbiB0aGVyZSB3YXMgYQ0KPj4+IGJv
dHRsZW5lY2sgZWxzZXdoZXJlLCBhbmQgdGhpcyBvbmUgd291bGRuJ3QgYmUgcmVsZXZhbnQuDQo+
Pj4gDQo+Pj4gSXQgbWlnaHQgYmUgdXNlZnVsIHRvIG1lYXN1cmUgaG93IGxvbmcgdGhlIHF1ZXVl
IGdldHMuDQo+PiANCj4+IFRoaW5raW5nIGFib3V0IHRoaXMgc29tZSBtb3JlIC4uLi4gIGlmIGl0
IGRpZCB0dXJuIG91dCB0aGF0IHRoZSBxdWV1ZQ0KPj4gZ2V0cyBsb25nLCBhbmQgbWF5YmUgZXZl
biBpZiBpdCBkaWRuJ3QsIHdlIGNvdWxkIHJlaW1wbGVtZW50IGx3cSBhcyBhDQo+PiBzaW1wbGUg
bGlua2VkIGxpc3Qgd2l0aCBoZWFkIGFuZCB0YWlsIHBvaW50ZXJzLg0KPj4gDQo+PiBlbnF1ZXVl
IHdvdWxkIGJlIHNvbWV0aGluZyBsaWtlOg0KPj4gDQo+PiAgbmV3LT5uZXh0ID0gTlVMTDsNCj4+
ICBvbGRfdGFpbCA9IHhjaGcoJnEtPnRhaWwsIG5ldyk7DQo+PiAgaWYgKG9sZF90YWlsKQ0KPj4g
ICAgICAgLyogZGVxdWV1ZSBvZiBvbGRfdGFpbCBjYW5ub3Qgc3VjY2VlZCB1bnRpbCB0aGlzIGFz
c2lnbm1lbnQgY29tcGxldGVzICovDQo+PiAgICAgICBvbGRfdGFpbC0+bmV4dCA9IG5ldw0KPj4g
IGVsc2UNCj4+ICAgICAgIHEtPmhlYWQgPSBuZXcNCj4+IA0KPj4gZGVxdWV1ZSB3b3VsZCBiZQ0K
Pj4gDQo+PiAgc3BpbmxvY2soKQ0KPj4gIHJldCA9IHEtPmhlYWQ7DQo+PiAgaWYgKHJldCkgew0K
Pj4gICAgICAgIHdoaWxlIChyZXQtPm5leHQgPT0gTlVMTCAmJiBjbXBfeGNoZygmcS0+dGFpbCwg
cmV0LCBOVUxMKSAhPSByZXQpDQo+PiAgICAgICAgICAgIC8qIHdhaXQgZm9yIGVucXVldWUgb2Yg
cS0+dGFpbCB0byBjb21wbGV0ZSAqLw0KPj4gICAgICAgICAgICBjcHVfcmVsYXgoKTsNCj4+ICB9
DQo+PiAgY21wX3hjaGcoJnEtPmhlYWQsIHJldCwgcmV0LT5uZXh0KTsNCj4+ICBzcGluX3VubG9j
aygpOw0KPiANCj4gVGhhdCBtaWdodCB3b3JrLCBidXQgSSBzdXNwZWN0IHRoYXQgaXQncyBzdGls
bCBvbmx5IHB1dHRpbmcgb2ZmIHRoZQ0KPiBpbmV2aXRhYmxlLg0KPiANCj4gRG9pbmcgdGhlIGRl
cXVldWUgcHVyZWx5IHdpdGggYXRvbWljIG9wZXJhdGlvbnMgbWlnaHQgYmUgcG9zc2libGUsDQo+
IGJ1dCBpdCdzIG5vdCBpbW1lZGlhdGVseSBvYnZpb3VzIHRvIG1lIGhvdyB0byBzb2x2ZSBib3Ro
IGhlYWQvdGFpbA0KPiByYWNlIGNvbmRpdGlvbnMgd2l0aCBhdG9taWMgb3BlcmF0aW9ucy4gSSBj
YW4gd29yayBvdXQgYW4gYWxnb3JpdGhtDQo+IHRoYXQgbWFrZXMgZW5xdWV1ZSBzYWZlIGFnYWlu
c3QgZGVxdWV1ZSByYWNlcyAob3IgdmljZSB2ZXJzYSksIGJ1dCBJDQo+IGNhbid0IGFsc28gZ2V0
IHRoZSBsb2dpYyBvbiB0aGUgb3Bwb3NpdGUgc2lkZSB0byBhbHNvIGJlIHNhZmUuDQo+IA0KPiBJ
J2xsIGxldCBpdCBib3VuY2UgYXJvdW5kIG15IGhlYWQgYSBiaXQgbW9yZS4uLg0KDQpJIGFncmVl
IHRoYXQgTyhuKSBkZXF1ZXVpbmcgaXMgcG90ZW50aWFsbHkgYWxhcm1pbmcuDQoNCkJlZm9yZSB3
ZSBnbyB0b28gZmFyIGRvd24gdGhpcyBwYXRoLCBJJ2QgbGlrZSB0byBzZWUNCnJlcHJvZHVjaWJs
ZSBudW1iZXJzIHRoYXQgc2hvdyB0aGVyZSBpcyBhIHByb2JsZW0NCndoZW4gYSByZWNlbnQgdXBz
dHJlYW0gTkZTIHNlcnZlciBpcyBwcm9wZXJseSBzZXQgdXANCndpdGggYSBzZW5zaWJsZSBudW1i
ZXIgb2YgdGhyZWFkcyBhbmQgcnVubmluZyBhIHJlYWwNCndvcmtsb2FkLg0KDQpPdGhlcndpc2Ug
dGhlcmUgaXMgYSByaXNrIG9mIGludHJvZHVjaW5nIGNvZGUgaW4gYQ0KZnVuZGFtZW50YWwgcGFy
dCBvZiBTdW5SUEMgdGhhdCBpcyBvcHRpbWl6ZWQgdG8gdGhlDQpwb2ludCBvZiBicml0dGxlbmVz
cywgYW5kIGZvciBubyBnb29kIHJlYXNvbi4NCg0KVGhpcyBpcyB3aGF0IGtlZXBzIG1lIGZyb20g
c2xlZXBpbmcgYXQgbmlnaHQ6IFsxXQ0KU2VlLCBpdCBldmVuIGhhcyBteSBuYW1lIG9uIGl0LiA6
LSkNCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KWzFdIC0gaHR0cHM6Ly93d3cubGludXNha2Vzc29u
Lm5ldC9wcm9ncmFtbWluZy9rZXJuaWdoYW5zLWxldmVyL2luZGV4LnBocA==

