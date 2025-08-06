Return-Path: <linux-nfs+bounces-13461-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7819B1C011
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 07:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6F0183AA0
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 05:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E6B1E7C10;
	Wed,  6 Aug 2025 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HGvvVRVV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xzg7YtN0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C8D2E36ED
	for <linux-nfs@vger.kernel.org>; Wed,  6 Aug 2025 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459306; cv=fail; b=WCSu+oP0ZELE5quXLK1Rwthundv+IOU4tOuMDByzeSYaDbRMhulTh+szfQhNjWZeTugQQKWnLc4BO7Q8EWpmuxEDpRH8bMVsbRnTlldGmnsnmPqHj0fEtAAZHCS6V39pb38FowoADTjSdiYpNUNWfpYU3s+C8RsTxvqacYPmWSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459306; c=relaxed/simple;
	bh=lOyGv69K2npitBQ0xWpkqlpGwtEOfERJSyWKxCk91Wo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tVyxBG9fGd78FBgHxaqUw3vmYTFc0HFXXqIv/r/+Dd6+6W+VWxM407ai1dKcjKKcxKB/SfhhVHyYHwpJuUZzt7Jh5WNG+kXhBE0OVC05FeFXg2uviPcZ6Emlhue00+l1ZqBB/a86Bk3JFQlXpnxNVYT/g3y5j34uQK61ciZhq5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HGvvVRVV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xzg7YtN0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761ukpj017678;
	Wed, 6 Aug 2025 05:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EmqRN6QKLDKylK/hpjPy4lxggq1mIUUKH1gSp2hcpVY=; b=
	HGvvVRVVGeGbxtXLfChBNhoJpK1rf8GbqrWOc7Z6ppWa28ePbhdsjEI8DKBIOxy2
	Mc00QVs7SWKtoDVYfJcz5g2Qzq11B4ULxy4A4WIw+P5pQEiBR8bzpn7RfEryvLeQ
	7ynTK/9pkN3cYXhr53UIRQaUrCoT21NuD8fk2cYkJe+rKQQ7CK/bGvSJKvdzNssC
	0EeFzHFIGIWjbg5M9WsUG9Czw4AgFX9c+3Fpv2IJ9F+ffG/zLD+rn7vjWowDo3eA
	r1jjErJ22c0LSCLhs0X0YTD9hDImmMC9lN/zfSdKmtSyPc7k/BphGt6vbQFJuVRq
	mLltsuS9mDtPaAsfXBUG2Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvf0st1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 05:48:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5765K2E4005674;
	Wed, 6 Aug 2025 05:48:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwwjeuk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 05:48:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8Q6pCyDqqXx9EImjZykSi7sn0Ns9dKoQV4VZ12w2JTArPUBsnCRCNjgIlBKsW3ceIoOXu9Z1sQz06JX5r2qn1W90dr/mEDdMPDNamxOViQjjSX7IrNEyoFxpPzhyMy3eXqbpazZPjki5PSOncwwhY/qZk6a/co0xt8wZcJQD+G5hdmuEsVNlKsu5GW0H7tDHVjCu8m4B3MyL/Ls1anR9j61BUlJBcysnyCfMmItaSbHRFgSB73Evj5QEHxlf8/u3LsPbEg1217MtgKHlQvF0s12OGRosSprBRjUzZgzldG2PSTXurbGPbTRi+e/tX50zgobRufAoljzfuPndVLpYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmqRN6QKLDKylK/hpjPy4lxggq1mIUUKH1gSp2hcpVY=;
 b=ge210NLP6f5sVqwH8XpJ0LOmOaKiOLk980YhbnVEHP7MXs0jUIoIPw1HfhMaXLj6MBXvKr0oywkusIbNLubEM5Wg2St6bvo0ZSNGK7pAeQ/8JITQK5C1TibJWvkhBd6kCjquYDFGSG1Lb+cCrz0bX7QuTzn0c3/H6EfRsxx2SMG4XmQkG5O0k42nneCnFoC227q1Rj3fEk40dEmg7tCftCwRpnuBxLBWHGJ09Aypc/vv+mGaTqgK+yArXQ5GOm2ylWaMI0h1ZyWrPq4oUyiRveN+RzmvYeEih7LdOd2acqkBCZQ59OW+JkPQoP/Bbqs6gADCSNUQySZaoIffRteDiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmqRN6QKLDKylK/hpjPy4lxggq1mIUUKH1gSp2hcpVY=;
 b=Xzg7YtN0P8DB3w7ljA6xPVA0d9DuOr+FYAdBcb723INspqX+elLl1jbT+ahSb4zAnTwYypWHPERMcx1Z/1suQ6RhvUlIwykDl5dMjYSkJ96u9l/M6/4cyLEUGlsmvbXCaGP3eqWjjP5lKJIgZLwRGwg6/tP/NNBHeJBKImFX3qg=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by DM3PPF905D77450.namprd10.prod.outlook.com (2603:10b6:f:fc00::c37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 05:48:02 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 05:48:02 +0000
Message-ID: <7e6108a8-3dba-4a1f-b347-91579a659698@oracle.com>
Date: Wed, 6 Aug 2025 11:17:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: NeilBrown <neil@brown.name>
Cc: Mark Brown <broonie@kernel.org>, trondmy@kernel.org,
        linux-nfs@vger.kernel.org, Aishwarya.TCV@arm.com, ltp@lists.linux.it,
        Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>
References: <> <b0393ddb-fca7-48b9-832f-ed17ccec1f19@oracle.com>
 <175369525960.2234665.4427615634985880450@noble.neil.brown.name>
 <d0dbfba5-a323-4227-858e-94ecb364a0ea@oracle.com>
Content-Language: en-US
In-Reply-To: <d0dbfba5-a323-4227-858e-94ecb364a0ea@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::19) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|DM3PPF905D77450:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ae13f5-152c-4513-1d07-08ddd4acce37
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NW5GUUI1R09LQVNWbDdnUENGOHo4MWJsbXA5T3JncEhhditILzY4OXZ6N2k1?=
 =?utf-8?B?d05kL21TanVkdisvUFBGOEtqeStCdDNKSDJ0cHplZ0g5bGFEeXJuNWRBOXFo?=
 =?utf-8?B?Zk0wbFVGL2h3Rzl0TFJwM0hxMkExeGJRbWgzSVZFR1NxUm44clpDZEJsUCtD?=
 =?utf-8?B?NEdOTGhEUUhDS1Y4R09NVWo4VU9MN3ZrY0JLRUVmSmw1eUkrWG0yOHhEZUpi?=
 =?utf-8?B?MzdiSGF5Z0hBNGpDL3pEN1JJWEFtTTBYVUlmaDlLL2lKZUcwdkJROUt4Nkd3?=
 =?utf-8?B?S1B0Mm1Ub1VMVlc5d0gyaUJxeWRzbmtuc1p2dTVtVS91QkVRUzBvTHpQOW5K?=
 =?utf-8?B?RGxvbXhnUEI2WGhxZGVIT21zWW1vcUFMTmxFRWRmcXRTRk1zdExORnV3Q2hq?=
 =?utf-8?B?QktXQnpnRUY3Tmg2TG13Q1VHTHhHVTJ0cmRJTFQ3Y2J0bEZscTlKL3ovQmgv?=
 =?utf-8?B?bnh2MGJNazNKZUFDRytSdEFsUDZBN1EvQ1Npd3JNeUQra0FUZGhhcWIxTVFH?=
 =?utf-8?B?eUxuY0VhdkNMYzdZNTFnbG44MWdhOTloZWJ6Qjc1NXpzcEtuK1RVN2tnRlNI?=
 =?utf-8?B?dHl4OG5FNXZiVWU0Nk5zVmM3U0d1b2JhTUt1VTJXNXNnTXNaUDBWNW9uWHZX?=
 =?utf-8?B?N1hycVVrWGFqS3QvMy8xZDYrWU8ySDduZ3ZTMGNhSG5ab3Z5Yi9zcDUvckJI?=
 =?utf-8?B?cHlPRldyK2hOR09kV1ZzNWJBTXFEOHZ5bGMzSW5ubFcyUVhGYlk4UGRnNHRD?=
 =?utf-8?B?UndEUWZ5OWpvTkF3Y1ZmRGcvZnVXejM0eGdxRUFHUDNZMnMxYS9tcHJZOVZD?=
 =?utf-8?B?eXlIUk1BNUcxMnNlU29KaXROS3VOMDM5RUZyY0FIL3lnN29uTnBRL1dPQXp6?=
 =?utf-8?B?MHNQbTY3bWl0UlJIQXR1elY3bUJ1YUl6dnA0L1FSTG9laGVvQ0NoY1kxU2FH?=
 =?utf-8?B?VVUxQ0JxSVZCYzA5L0hWOWUvS1lTWGQ5MFRpL2JVaW1rK1NnTUlzTDY1THpC?=
 =?utf-8?B?S3J0eWhkbXkvZkVmRVBLMEFBRnluamZoN25Xc2lWMGNTTnNOY0t5OUdvbnNs?=
 =?utf-8?B?dUgvY1hkQU5KNWxoY3NaSG1VajlkbUlKQXFRSG1PNWgramxIbCtKU3JpU3da?=
 =?utf-8?B?VWkvS1pCcEhzQjJZV2RXSDQwV2twYldobkM2S2ZJZytETXVuNTBlWCtBRnRY?=
 =?utf-8?B?OXNDRTB2M21UZTFxMEU3Tko4TE5sOXhnOW0zVWt4dVZYdmxUMW9idXVBeWpP?=
 =?utf-8?B?ZGZrWEczZEp0Q0dmS1RGcG9NYTF3WEZvUDdEOWpuelBabHV6Z0hqRnBuNjgv?=
 =?utf-8?B?c2o4ZUpsUXp1a20yOVg2ZjRtV00xNWZIdHI2WFN4dnk4Y3FBamErSElEQndx?=
 =?utf-8?B?cVBvMFN1andTUlJ5YTF4ZUpWNmhLNDI3REUxblluMVhPNEdnYnFlVGloYWZH?=
 =?utf-8?B?WWErMEpTbEZGdytWOGFXV01Db2FyV2xYS1V4Y0VqM2grb0RZLzdoTnJCVmZp?=
 =?utf-8?B?bUdQdFVaa0xXWGE3djVGQ0FwRnQybUtRN2l5aEd0QkdURzB4WEVkVitJZ2Ez?=
 =?utf-8?B?dlpnQWZ2VE5IUmgwVjJJc1NHQVJkQlE2Q0pPamVFQmpralk3WGZkNjJ2cnBH?=
 =?utf-8?B?OWxvZk91ZU92KytnZzM4K1Y0MC9leUFvSVdLSWVoRXVETGdhM0U3bzliMmxu?=
 =?utf-8?B?S0ZHL1dxNXJqMHY5dHdaYXM5T3NCRHdTZTJDQzY5UkhsdHh4SDF0aGs4QWpy?=
 =?utf-8?B?cVg3b3d2WldnbW1Wdm4zZjJzWjQyNFM3MjJsQTlkcnh5MUJNVlgva281OGIr?=
 =?utf-8?B?TW5TRkRWL0RvamY5aXluNHNmNE1TWUtLMzNUTGdtTVMwQVJSa2d6YnhyWjFU?=
 =?utf-8?B?Wkg3SndxZHNwMnF3TmlEZm9BZEpsU1pZaEN0V1V3dzk0NWN1Vng4R1JIZHp1?=
 =?utf-8?Q?BPKSc9Qzjwo=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YmJFcFY4QlZzdmVldnN5NUFtY25TbzlPc1pBcHBZdGt0RTZyZkRlcWM0VlU3?=
 =?utf-8?B?MnNXTm1kV0JKZHlQeUJDYmhadFJVMWZUMUZYZVlVNEZLYUFwUGNZWXhLY0tW?=
 =?utf-8?B?anNleldXK2xBK3I5WTVDVEkzcXVqYytzM3d1dDNtTTgySHVuNkhaaE8rem40?=
 =?utf-8?B?ZkNqQkc5UWFpc3IybkVCL0V1RnBuQUNkSmZIQVA4akRJTlNoVFQrOEo1a0R2?=
 =?utf-8?B?cVl0cUptaUFGNTZ6VEQ3V2UycDg3U2RaWlNkczNkckh0TkdQdnZDbzBZeENZ?=
 =?utf-8?B?VUFDN2t3STBkN3J5Nk5zcy9takF0OUlWbXFTQmpJUkt3bTJsQ2lBZkhJbnVR?=
 =?utf-8?B?K00yOFFJU0R0RGhFZTl4cDlIYlNoVFZuQXlBaWdDVkdIWTdEazFvMWpwaTdv?=
 =?utf-8?B?ZGxaYnlQOFNRYk1SR0dUQ0crN2d3U0xnZGlGaHhPeCtZZnd5MjN5YTVZUHY4?=
 =?utf-8?B?TCtnRGlhZjlSNDg2QVRURTN4NGdFek9Gc0ZRTSsvTUFlRDdlVGhJMytyZTFr?=
 =?utf-8?B?azZNMDdGcng3K08wRGxiTXB6ekVOZVRXQkVBdUZnYk5QNkdpaTl2ZmFRWkhW?=
 =?utf-8?B?cEhMVUNUcnRrR0l4WldoSjVyOENIUVRCanNiaUNhUUljRnM5VG5ITnBZcGk3?=
 =?utf-8?B?N3R4UHI5SXhNQzRkMWhJK1F0YThoalduVUU2NTRJVlc2b0ZqMUJRSTFyQ1ZZ?=
 =?utf-8?B?c3o5YWNEL3FpVE9idlVna1JOYU1VejR5RzJvNG5vMG5jSktaRlk4NHdOZTFK?=
 =?utf-8?B?QmwrY2E3MWhNdVpjQ2RSRCttY3d2Q21MOFBGdTRrWURWVklJSVNPYkZ2Sk9l?=
 =?utf-8?B?ZGh4T2ova0dadjFNeEZ5dXY0S3lYTE5aTk9qSUdpNEtZRzkySm93VTBMNnAy?=
 =?utf-8?B?ZEhvaFFIMlI4dTJEWUExa2V4MDVtUU5wTmo4TldJYkVxME1abjNJaE5DWUl6?=
 =?utf-8?B?UmZZUy8xRmY5U0NjRDhjbWpjcVk4VFB3c0VGU1VmYmZmQTdLV28zWTlRUHVQ?=
 =?utf-8?B?RUZ6SVVsRVFqc0VBNmxhNTkzbkgyN29GOXR6UVloWEtzc1ZTTlh3bjJ3cWpJ?=
 =?utf-8?B?R0h4cW9yaWJ1ZFNKUUQrYmM0WXljempPekc3VmI2TkxzQXJiMmE2OWRqcjlm?=
 =?utf-8?B?bkt6VWhZQ2hKZHJZT21OZkZBUFJGb1hCZFRDcStvZmVyQVZsektVcGhxRFU1?=
 =?utf-8?B?VGxrQk11aFYyUmVjYW5ibUtZcXVUOXVuMlFhV2xUUjBuSXpVS3krdGQ1MlF0?=
 =?utf-8?B?Q041a0piREVRcE9pekVabDVLREVQUnFHRDFPVWRBUW9jY09CN3NqZ2xMS0dJ?=
 =?utf-8?B?WTROMHc0U3ZXNkllNDY5VElFSkhRNFM1enZjVGVtYXpOZHV2SSt4a2NFTk5z?=
 =?utf-8?B?WmFydWFseEt1M25YZG1iYkVGVEo5NjdhTjdoaUxMdjFubUtKNGxabmlGZ3Nm?=
 =?utf-8?B?V1hOcnAxdmt6bysrNXlwSUdMVkRabm1HY2NNRXRKWHZqc091ZTNrdkgxdGQy?=
 =?utf-8?B?YzgwekRIR2Qza3FJTGZ1M1IyREVYWTAzc251TFpibkFqdEFSck9sSnNZVWZN?=
 =?utf-8?B?aVJOOGk2LzBkNnlvZEpPTmhUMGk0clB0SGpEMHlrZytlM3V4OG50WHRZdXJw?=
 =?utf-8?B?dFVjaEJCOHRlM3VLU3BFNC9pUDlTd3p2OVFndVFOckNXVkQ5U055YnJiSEFN?=
 =?utf-8?B?NnRSZWlOSjRlOWViellsUVVvdzUzSndvbGxmeE1Pclh5WisxcGxBVHNNMzAx?=
 =?utf-8?B?T05wdGozdmhVUm9IN1JmbmFMQ0NBWjk1ZEczcjlxMldFanNnVURMYm1SYkRU?=
 =?utf-8?B?UVJhMDRIcXJlbzRlWVlMWTVacFBYQm5NbEwwUWRSNXY2S0tWeFYzalRta2tE?=
 =?utf-8?B?WDJLOE1rQ0VVcEwrYTFLclJDU0d3SlN0VjZ3dmN3NGxVa3NGYTgvbWcya3N3?=
 =?utf-8?B?NW5ndUNNTnNmK2lxclZlOE5vSUVEMHJvbHc1cHpRR0YvWFhSeFkxM3NkMzQv?=
 =?utf-8?B?NHBSUkxWK2R4aVRxeU1DVkVibVpoU2IwSENxOG1zbmJtYWR0NW9iUHA4QmhT?=
 =?utf-8?B?V1cxa3JSWWtPeVYzY1JaSU9aQW1Qem1UNDdKUktUeVFZaU5JL2lhSHdVcTQx?=
 =?utf-8?B?elV6THVqTTBjTndlVHVBUUVhbmM4V2lpMWhPZkVPWnBOTUVEMUM1azVlLy9O?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mJKzHP8T5XgoVSfQWVRbaHQYq217pZNZH5n3u8MHZExLP73DJmKPcHU8rwe00euU8pC2/Nv2AZvES/Ed6fgxFYourCXnYk1ANeMqfNryTJv4xhuZti+VNeL/5dvrcBXOMd7JxICvaJPmif14rl63p7n9e0tM6z911ADpatk+dBsBbgB0Yn3ztXwwZq+V5WlT79k8t6QUCJqLS582qf+jOD7fUxY+XNFCnZp4WHGVSGbAfme5JUPA2dMZB3uz8Qn0C6YM5oJ/mqWHkRpnpyddPXJIdAoCWxSHlsys4DQJDEslTBh7ATPqBP2UAkkNJ9aFysuReS08TMqk/kyAI6PgqTbKelcUla3C3eck843JjHYfEwMwswaQDWT8ykvZ6uiQCOVF1n6zvHBXtq4crGwqdPaWCYCrHt/YqhnwHMPedCcX3V5nZ34XvcWEcZnf8N20Ct4FRJRoByNKoGX7M5ol1WReTfILFzhY1SwoMmH4hgXoOZcW+banzYfz9Q3r8xZxiUNNXM8TC/dWPIOzfke064q98KAFlXrOt03mDwwmdXon5/2BRWrl0jJPy5/rX0lcXKr5npG4LblqAbX9m7YMUauJY5PcoZoJbhDtcOzIvZw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ae13f5-152c-4513-1d07-08ddd4acce37
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 05:48:01.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9vswiyFLJw8JGNckXB3Z20rSEH4qgi39xqYd4HO8k0QGvNufrWwbtHWOF9EkaBIbAKnwIcKY3edjhCvXDot+2G/azxMTR8GLn6/MbYNvwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF905D77450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508060034
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAzNCBTYWx0ZWRfX6/5j4VgVdym7
 DQVRXX3LTP0KZxvHWmMZJneHZt9/9LWU+id2p2q4MLc5XVM6JQevkh4aEft3R7WSzC1PR3CZdwQ
 JI+A7XW/eZfu70huZWpZvQmJbOtHKJdoVG11eSuiLwUQ8yRmtl5+zNqKSbsyIJUg7R+oWDn/VwL
 wk4mpijso8HpWrT2xWWaZbjoNFYAmDEbpwdyuqRLcBXfyViuY3LBqEMSwMSCx88c7HbUN0TcGB2
 VaqFwigymWDQg8d61amJtlX6uxwRdcO+0IWNFSq84F9r/70JA9r+ebHlGiilp1U2HEMMim2lxtY
 eJTh9RNdCHXEuMcKfkY4s1ywkTZOnDx4YBTYgxmAli5OyO+DiRjzvfFsKrh9327tPk4Lm1I4biv
 MwWQPOM6pvsOQWs06+/g6kaN6fwpjDDAFIapbs90odaz9hBf1wEIDvO/xEGKD/6qQNaCWZwF
X-Authority-Analysis: v=2.4 cv=RtTFLDmK c=1 sm=1 tr=0 ts=6892ec95 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=SEtKQCMJAAAA:8
 a=jiAbWkNVqXn7qf2YYqIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:12065
X-Proofpoint-ORIG-GUID: PVv37tecHCh7hGF1Q4cxuk3apyfqhytU
X-Proofpoint-GUID: PVv37tecHCh7hGF1Q4cxuk3apyfqhytU


On 04/08/25 1:15 PM, Harshvardhan Jha wrote:
> On 28/07/25 3:04 PM, NeilBrown wrote:
>> On Mon, 28 Jul 2025, Harshvardhan Jha wrote:
>>> On 27/07/25 10:20 AM, NeilBrown wrote:
>>>> On Fri, 25 Jul 2025, Harshvardhan Jha wrote:
>>>>> On 23/07/25 1:37 PM, NeilBrown wrote:
>>>>>> On Wed, 23 Jul 2025, Harshvardhan Jha wrote:
>>>>>>> On 08/04/25 4:01 PM, Mark Brown wrote:
>>>>>>>> On Fri, Mar 28, 2025 at 01:40:44PM -0400, trondmy@kernel.org wrote:
>>>>>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>>>>>
>>>>>>>>> Once a task calls exit_signals() it can no longer be signalled. So do
>>>>>>>>> not allow it to do killable waits.
>>>>>>>> We're seeing the LTP acct02 test failing in kernels with this patch
>>>>>>>> applied, testing on systems with NFS root filesystems:
>>>>>>>>
>>>>>>>> 10271 05:03:09.064993  tst_test.c:1900: TINFO: LTP version: 20250130-1-g60fe84aaf
>>>>>>>> 10272 05:03:09.076425  tst_test.c:1904: TINFO: Tested kernel: 6.15.0-rc1 #1 SMP PREEMPT Sun Apr  6 21:18:14 UTC 2025 aarch64
>>>>>>>> 10273 05:03:09.076733  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>>>>>>>> 10274 05:03:09.087803  tst_test.c:1722: TINFO: Overall timeout per run is 0h 01m 30s
>>>>>>>> 10275 05:03:09.088107  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>>>>>>>> 10276 05:03:09.093097  acct02.c:63: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
>>>>>>>> 10277 05:03:09.093400  acct02.c:240: TINFO: Verifying using 'struct acct_v3'
>>>>>>>> 10278 05:03:10.053504  <6>[   98.043143] Process accounting resumed
>>>>>>>> 10279 05:03:10.053935  <6>[   98.043143] Process accounting resumed
>>>>>>>> 10280 05:03:10.064653  acct02.c:193: TINFO: == entry 1 ==
>>>>>>>> 10281 05:03:10.064953  acct02.c:84: TINFO: ac_comm != 'acct02_helper' ('acct02')
>>>>>>>> 10282 05:03:10.076029  acct02.c:133: TINFO: ac_exitcode != 32768 (0)
>>>>>>>> 10283 05:03:10.076331  acct02.c:141: TINFO: ac_ppid != 2466 (2461)
>>>>>> It seems that the acct02 process got logged..
>>>>>> Maybe the vfork attempt (trying to run acct02_helper) got half way an
>>>>>> aborted.
>>>>>> It got far enough that accounting got interested.
>>>>>> It didn't get far enough to update the ppid.
>>>>>> I'd be surprised if that were even possible....
>>>>>>
>>>>>> If you would like to help debug this, changing the
>>>>>>
>>>>>> +       if (unlikely(current->flags & PF_EXITING))
>>>>>>
>>>>>> to
>>>>>>
>>>>>> +       if (unlikely(WARN_ON(current->flags & PF_EXITING)))
>>>>>>
>>>>>> would provide stack traces so we can wee where -EINTR is actually being
>>>>>> returned.  That should provide some hints.
>>>>>>
>>>>>> NeilBrown
>>>>> Hi Neil,
>>>>>
>>>>> Upon this addition I got this in the logs
>>>> Thanks for testing.  Was there anything new in the kernel logs?  I was
>>>> expecting a WARNING message followed by a "Call Trace".
>>>>
>>>> If there wasn't, then this patch cannot have caused the problem.
>>>> If there was, then I need to see it.
>>>>
>>>> Thanks,
>>>> NeilBrown
>>> This is what the dmesg contains:
>>>
>>> [  678.814887] LTP: starting acct02
>>> [  679.831232] ------------[ cut here ]------------
>>> [  679.833500] WARNING: CPU: 6 PID: 88930 at net/sunrpc/sched.c:279
>>> rpc_wait_bit_killable+0x76/0x90 [sunrpc]
>>> [  679.837308] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs
>>> netfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd
>>> grace loop nft_redir ipt_REJECT xt_comment xt_owner nft_compat
>>> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib rfkill nft_reject_inet
>>> nf_reject_
>>> ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
>>> nf_defrag_ipv6 nf_defrag_ipv4 ip_set cuse vfat fat intel_rapl_msr
>>> intel_rapl_common kvm_amd ccp kvm drm_shmem_helper irqbypass i2c_piix4
>>> drm_kms_helper pcspkr pvpanic_mmio i2c_smbus pvpanic drm fuse xfs
>>> crc32c_generic
>>>  nvme_tcp nvme_fabrics nvme_core nvme_keyring nvme_auth sd_mod
>>> virtio_net sg net_failover virtio_scsi failover ata_generic pata_acpi
>>> ata_piix ghash_clmulni_intel libata sha512_ssse3 virtio_pci sha256_ssse3
>>> virtio_pci_legacy_dev sha1_ssse3 virtio_pci_modern_dev serio_raw
>>> dm_multipath btrfs
>>>  blake2b_generic xor zstd_compress raid6_pq sunrpc dm_mirror
>>> dm_region_hash dm_log dm_mod be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls
>>> cxgb3i cxgb3 mdio libcxgbi libcxgb
>>> [  679.837524]  qla4xxx iscsi_tcp libiscsi_tcp libiscsi
>>> scsi_transport_iscsi iscsi_ibft iscsi_boot_sysfs qemu_fw_cfg aesni_intel
>>> crypto_simd cryptd [last unloaded: kheaders]
>>> [  679.873316] CPU: 6 UID: 0 PID: 88930 Comm: acct02_helper Kdump:
>>> loaded Not tainted 6.15.8-1.el9.rc2.x86_64 #1 PREEMPT(voluntary)
>>> [  679.877769] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>>> BIOS 1.6.4 02/27/2023
>>> [  679.880782] RIP: 0010:rpc_wait_bit_killable+0x76/0x90 [sunrpc]
>>> [  679.883189] Code: 01 b8 00 fe ff ff 75 d5 48 8b 85 48 0d 00 00 5b 5d
>>> 48 c1 e8 08 83 e0 01 f7 d8 19 c0 25 00 fe ff ff 31 d2 31 f6 e9 8a e6 c4
>>> d4 <0f> 0b b8 fc ff ff ff 5b 5d 31 d2 31 f6 e9 78 e6 c4 d4 0f 1f 84 00
>>> [  679.889976] RSP: 0018:ffffaf47811a7770 EFLAGS: 00010202
>>> [  679.892196] RAX: ffff97be48e00330 RBX: ffffaf47811a77c0 RCX:
>>> 0000000000000000
>>> [  679.894978] RDX: 0000000000000001 RSI: 0000000000002102 RDI:
>>> ffffaf47811a77c0
>>> [  679.897786] RBP: ffff97be61588000 R08: 0000000000000000 R09:
>>> 0000000000000000
>>> [  679.900600] R10: 0000000000000000 R11: 0000000000000000 R12:
>>> 0000000000002102
>>> [  679.903432] R13: ffffffff96408ea0 R14: ffffaf47811a77d8 R15:
>>> ffffffffc07568e0
>>> [  679.906233] FS:  00007fc2563f8600(0000) GS:ffff97c5c890f000(0000)
>>> knlGS:0000000000000000
>>> [  679.909289] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  679.911736] CR2: 00007fc2561fba70 CR3: 00000003bce3a000 CR4:
>>> 00000000003506f0
>>> [  679.914555] Call Trace:
>>> [  679.915918]  <TASK>
>>> [  679.917215]  __wait_on_bit+0x31/0xa0
>>> [  679.918932]  out_of_line_wait_on_bit+0x93/0xc0
>>> [  679.920914]  ? __pfx_wake_bit_function+0x10/0x10
>>> [  679.922944]  __rpc_execute+0x109/0x310 [sunrpc]
>>> [  679.925024]  rpc_execute+0x137/0x160 [sunrpc]
>>> [  679.927020]  rpc_run_task+0x107/0x170 [sunrpc]
>>> [  679.929032]  nfs4_call_sync_sequence+0x74/0xc0 [nfsv4]
>>> [  679.931319]  _nfs4_proc_statfs+0xc7/0x100 [nfsv4]
>>> [  679.933520]  ? srso_return_thunk+0x5/0x5f
>>> [  679.935391]  nfs4_proc_statfs+0x6b/0xb0 [nfsv4]
>>> [  679.937367]  nfs_statfs+0x7e/0x1e0 [nfs]
>>> [  679.939138]  statfs_by_dentry+0x67/0xa0
>>> [  679.940887]  vfs_statfs+0x1c/0x40
>>> [  679.942596]  check_free_space+0x71/0x110
>> Thanks.  I'm not sure why this causes a problem as if vfs_statfs() fail,
>> check_free_space() assumes there is still free space.
>> However it does strongly suggest that we still need to NFS to work in
>> processes where signals have been shutdown.
>>
>> Could you change rpc_wait_bit_killable() to be the following and retest?
>> I intention is that when the process is exiting, we wait up to 5 seconds
>> for each request and then fail.  It's a bit ugly, but it is a rather
>> strange situation.  It blocking forever that we really want to avoid
>> here, not blocking at all.
>>
>> Thanks,
>> NeilBrown
>>
>>
>> static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
>> {
>> 	if (unlikely(current->flags & PF_EXITING)) {
>> 		if (schedule_timeout(5*HZ) > 0)
>> 			/* timed out */
>> 			return 0;
>> 		return -EINTR;
>> 	}
>> 	schedule();
>> 	if (signal_pending_state(mode, current))
>> 		return -ERESTARTSYS;
>> 	return 0;
>> }
> Adding this change makes the test pass:
>
> <<<test_start>>>
> tag=acct02 stime=1754066481
> cmdline="acct02"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.8-master.sunrpc.el9.rc3.x86_64/config'
> tst_tmpdir.c:316: TINFO: Using /tmpdir/ltp-lNzAk1qhuX/LTP_accZ75zl1 as tmpdir (nfs filesystem)
> tst_test.c:2004: TINFO: LTP version: 20250530-128-g6505f9e29
> tst_test.c:2007: TINFO: Tested kernel: 6.15.8-master.sunrpc.el9.rc3.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Jul 29 05:06:28 PDT 2025 x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.8-master.sunrpc.el9.rc3.x86_64/config'
> tst_test.c:1825: TINFO: Overall timeout per run is 0h 00m 30s
> tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.8-master.sunrpc.el9.rc3.x86_64/config'
> acct02.c:61: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
> acct02.c:238: TINFO: Verifying using 'struct acct_v3'
> acct02.c:191: TINFO: == entry 1 ==
> acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('iscsiadm')
> acct02.c:131: TINFO: ac_exitcode != 32768 (5376)
> acct02.c:139: TINFO: ac_ppid != 52326 (2475)
> acct02.c:191: TINFO: == entry 2 ==
> acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('systemd')
> acct02.c:125: TINFO: elap_time/clock_ticks >= 2 (1065/100: 10.00)
> acct02.c:131: TINFO: ac_exitcode != 32768 (0)
> acct02.c:139: TINFO: ac_ppid != 52326 (1)
> acct02.c:191: TINFO: == entry 3 ==
> acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('(sd-pam)')
> acct02.c:125: TINFO: elap_time/clock_ticks >= 2 (1062/100: 10.00)
> acct02.c:131: TINFO: ac_exitcode != 32768 (9)
> acct02.c:139: TINFO: ac_ppid != 52326 (1)
> acct02.c:191: TINFO: == entry 4 ==
> acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('systemd-user-ru')
> acct02.c:131: TINFO: ac_exitcode != 32768 (0)
> acct02.c:139: TINFO: ac_ppid != 52326 (1)
> acct02.c:191: TINFO: == entry 5 ==
> acct02.c:202: TINFO: Number of accounting file entries tested: 5
> acct02.c:208: TPASS: acct() wrote correct file contents!
>
> Summary:
> passed   1
> failed   0
> broken   0
> skipped  0
> warnings 0
> incrementing stop
> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=exited termination_id=0 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>
>
> Thanks & Regards,
> Harshvardhan

Hi there,

I tested this around 50 iterations and it passes all 50 times with this
timeout.

Thanks & Regards,
Harshvardhan

>
>
>>> [  679.944433]  acct_write_process+0x45/0x180
>>> [  679.946313]  acct_process+0xff/0x180
>>> [  679.948003]  do_exit+0x216/0x480
>>> [  679.949799]  ? srso_return_thunk+0x5/0x5f
>>> [  679.951621]  do_group_exit+0x30/0x80
>>> [  679.953329]  __x64_sys_exit_group+0x18/0x20
>>> [  679.955217]  x64_sys_call+0xfdb/0x14f0
>>> [  679.956971]  do_syscall_64+0x82/0x7a0
>>> [  679.958717]  ? srso_return_thunk+0x5/0x5f
>>> [  679.960550]  ? ___pte_offset_map+0x1b/0x1a0
>>> [  679.962434]  ? srso_return_thunk+0x5/0x5f
>>> [  679.964261]  ? __alloc_frozen_pages_noprof+0x18d/0x340
>>> [  679.966389]  ? srso_return_thunk+0x5/0x5f
>>> [  679.968183]  ? srso_return_thunk+0x5/0x5f
>>> [  679.969945]  ? __mod_memcg_lruvec_state+0xb6/0x1b0
>>> [  679.971977]  ? srso_return_thunk+0x5/0x5f
>>> [  679.973690]  ? __lruvec_stat_mod_folio+0x83/0xd0
>>> [  679.975671]  ? srso_return_thunk+0x5/0x5f
>>> [  679.977392]  ? srso_return_thunk+0x5/0x5f
>>> [  679.979079]  ? set_ptes.isra.0+0x36/0x90
>>> [  679.980771]  ? srso_return_thunk+0x5/0x5f
>>> [  679.982375]  ? srso_return_thunk+0x5/0x5f
>>> [  679.984052]  ? wp_page_copy+0x333/0x730
>>> [  679.985648]  ? srso_return_thunk+0x5/0x5f
>>> [  679.987220]  ? __handle_mm_fault+0x397/0x6f0
>>> [  679.988818]  ? srso_return_thunk+0x5/0x5f
>>> [  679.990411]  ? __count_memcg_events+0xbb/0x150
>>> [  679.992111]  ? srso_return_thunk+0x5/0x5f
>>> [  679.993689]  ? count_memcg_events.constprop.0+0x26/0x50
>>> [  679.995590]  ? srso_return_thunk+0x5/0x5f
>>> [  679.997177]  ? handle_mm_fault+0x245/0x350
>>> [  679.998807]  ? srso_return_thunk+0x5/0x5f
>>> [  680.000339]  ? do_user_addr_fault+0x221/0x690
>>> [  680.002042]  ? srso_return_thunk+0x5/0x5f
>>> [  680.003553]  ? arch_exit_to_user_mode_prepare.isra.0+0x1e/0xd0
>>> [  680.005643]  ? srso_return_thunk+0x5/0x5f
>>> [  680.007202]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> [  680.009025] RIP: 0033:0x7fc2560d985d
>>> [  680.010510] Code: Unable to access opcode bytes at 0x7fc2560d9833.
>>> [  680.012660] RSP: 002b:00007ffde591df68 EFLAGS: 00000246 ORIG_RAX:
>>> 00000000000000e7
>>> [  680.015355] RAX: ffffffffffffffda RBX: 00007fc2561f59e0 RCX:
>>> 00007fc2560d985d
>>> [  680.017749] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI:
>>> 0000000000000080
>>> [  680.020292] RBP: 0000000000000080 R08: 0000000000000000 R09:
>>> 0000000000000020
>>> [  680.022729] R10: 00007ffde591de10 R11: 0000000000000246 R12:
>>> 00007fc2561f59e0
>>> [  680.025174] R13: 00007fc2561faf20 R14: 0000000000000001 R15:
>>> 00007fc2561faf08
>>> [  680.027593]  </TASK>
>>> [  680.028661] ---[ end trace 0000000000000000 ]---
>>>
>>>
>>> Thanks & Regards,
>>> Harshvardhan
>>>
>>>>> <<<test_start>>>
>>>>> tag=acct02 stime=1753444172
>>>>> cmdline="acct02"
>>>>> contacts=""
>>>>> analysis=exit
>>>>> <<<test_output>>>
>>>>> tst_kconfig.c:88: TINFO: Parsing kernel config
>>>>> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
>>>>> tst_tmpdir.c:316: TINFO: Using /tmpdir/ltp-w1ozKKlJ6n/LTP_acc4RRfLh as
>>>>> tmpdir (nfs filesystem)
>>>>> tst_test.c:2004: TINFO: LTP version: 20250530-105-gda73e1527
>>>>> tst_test.c:2007: TINFO: Tested kernel:
>>>>> 6.15.8-1.bug38227970.el9.rc2.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jul 25
>>>>> 02:03:04 PDT 2025 x86_64
>>>>> tst_kconfig.c:88: TINFO: Parsing kernel config
>>>>> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
>>>>> tst_test.c:1825: TINFO: Overall timeout per run is 0h 00m 30s
>>>>> tst_kconfig.c:88: TINFO: Parsing kernel config
>>>>> '/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
>>>>> acct02.c:61: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
>>>>> acct02.c:238: TINFO: Verifying using 'struct acct_v3'
>>>>> acct02.c:191: TINFO: == entry 1 ==
>>>>> acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('acct02')
>>>>> acct02.c:131: TINFO: ac_exitcode != 32768 (0)
>>>>> acct02.c:139: TINFO: ac_ppid != 88929 (88928)
>>>>> acct02.c:181: TFAIL: end of file reached
>>>>>
>>>>> HINT: You _MAY_ be missing kernel fixes:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d9570158b626
>>>>>
>>>>> Summary:
>>>>> passed   0
>>>>> failed   1
>>>>> broken   0
>>>>> skipped  0
>>>>> warnings 0
>>>>> incrementing stop
>>>>> <<<execution_status>>>
>>>>> initiation_status="ok"
>>>>> duration=1 termination_type=exited termination_id=1 corefile=no
>>>>> cutime=0 cstime=20
>>>>>
>>>>> <<<test_end>>>
>>>>>
>>>>>
>>>>> Thanks & Regards,
>>>>>
>>>>> Harshvardhan

