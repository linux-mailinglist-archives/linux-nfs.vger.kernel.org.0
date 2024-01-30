Return-Path: <linux-nfs+bounces-1596-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF67384183C
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 02:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D94B229DE
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 01:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A80A2E40E;
	Tue, 30 Jan 2024 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kS6iMKqZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Eb689F5c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D242EB1A
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 01:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577745; cv=fail; b=c+wOtWAV+V1PbwvDoKtPswkPoVClaJzAKBrZmoTi1YZad9V9E8jOh+v2PFmLrbzAC4UQXLpeH7oqfPYnKfEjf+G//aIPlVwfgwOeW/l2mmCkna4ni5MlcLg3md5d/d2jiqt6UKCLIh1puXNTOFUJ9CDcwevy8ZPH1HpEP49tUkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577745; c=relaxed/simple;
	bh=o/1UxalVwD5hCEkIFuO4xSVHF08kGpP3SFNVJhPM1w0=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kXr+xjcPBiBhyyIec6GVG0kErQ8ho04uoj5+rYOecuEHmNcU9rh8OwcT8MPrfIBUuNcQg8claQcwqCewXmXp+pl+oBZuW3x5h+H6mu6lrHUsZRmmz0l0sB9vJQI4w9ASqikWontrwrdvABqrSqXgcN5xXEv4ZvYpZGka+C2/vC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kS6iMKqZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Eb689F5c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJi3gf003525;
	Tue, 30 Jan 2024 01:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=o/1UxalVwD5hCEkIFuO4xSVHF08kGpP3SFNVJhPM1w0=;
 b=kS6iMKqZjGIv9lXjaG0tN1cyjckMozHPBDR1Wrzsy9noz9wu9ascjH0Xwgb5Amws7+d/
 I9rVejhZBXlOI6OryF1s53/j8LLwOwnR0OOT/t9RQ9lhapHRLilVHDoOX0VriTq8r4qN
 ZCNzdEfMKwkztXOt2XrEPjNEOIwUB6Fe/6FYCwCW9qKryS9TZvWwqU7PpAQJ+8YXTyVK
 DZha0YgyYVQtihMWl+nNlZQJs5CMHVUJIOxA76DgMfP2TWz9mYBLEQJQpO6Z3J1mSeZQ
 omgNJAxAhoEE+5Vlh/PQw/LeckAdvQmKfzWUyoElMQqXJJgZlXdRGTbafB83uZjdKaMw Vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm3wdu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 01:22:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40U0u5SJ040528;
	Tue, 30 Jan 2024 01:22:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96kb5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 01:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKObaypUQCa9MOWvqcNHdpAs0/ekDG05M1XloGJx5CWlxM0rQNr1mTf7nF9Oxm4mtNn9QSDQ69D1ratWmPPhdxRQG98WJ9PLbX5CpC9A3Uc4ii+LlfAPJtcOGEYDJzqHM30rj0qDGGKtn9VTA9Md0TXX/GSB7Z1AuF9EcPqO8FY9Y9nUdr1drV4qufIlpWM7Gd3qBOQEsiMcAdDWULpV+rhw36ReOR8a+TkfHO/kIw6jROroFlJGmR7VryktydTPcIbVVcwMxvQlYOSgqurkVQqgNcfN5w6sxvVYClyvYWZC0mv3OmuS9uihHJyzdsJKVK1J0rBbr+IwTRSHWzSqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/1UxalVwD5hCEkIFuO4xSVHF08kGpP3SFNVJhPM1w0=;
 b=ZNvfERNDiOyiStuviPI2RWLzAf4LfMXZ7q6KhT7yEGltgmrvH16Ynvqwv87fCm65jRmpsQAzcQPY3LadxhiQQjD2jj3mbjebo6YHnrn95YHGwGXKjW2ptPDv4vmhniWe/ydVYNke5eFppom4RYwF6cQSBr/GL30H3srGCzttUu8Gl6Ut/XccmHj4/YCKgUAq4iFg34v54+xqZy+TSz2wFuTmHoYwEnfdeUxaHwy8j2nE5wRW5TGChYDJdwEoQP8kXti6baycze9YYR/kdWhujJVZBxtaRDS9dDs8h9ZoXhX0/J+beEcFirMZMq48bvuzXdt4BVpH5jvd53GWhv45fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/1UxalVwD5hCEkIFuO4xSVHF08kGpP3SFNVJhPM1w0=;
 b=Eb689F5c75kWfWsH9Ajm1TVNIQXe6khkPLjZfhNbwtCLeho9mCdE1VRptEdqlF2STdg641yV82S0vHZMs3NFee0Vl86SMLgACW4aIq1nAGO0ZOj73iLQIswCJfElDaEa7bR4rhtqIinFoyZQv0esLJhcNuObPRDe+tlps1f8/ZU=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 01:22:11 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::7135:2939:5d26:f667]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::7135:2939:5d26:f667%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 01:22:10 +0000
Message-ID: <99ec805e-a0d4-44ea-a6ea-9478e98d4670@oracle.com>
Date: Tue, 30 Jan 2024 01:22:06 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>
Subject: Re: Filesystem test suite for NFSv4?
Content-Language: en-GB
To: Martin Wege <martin.l.wege@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CANH4o6MqecahkZj3i4YwS1UQjQimFrDcbM8abCbrGiLyk9ZTkg@mail.gmail.com>
 <CANH4o6Na-KPweTmeUAiU9sK4OGt8RkkZU+vK5xpEe-BrP-s_Bg@mail.gmail.com>
 <761568108.788363.1700121338355.JavaMail.zimbra@desy.de>
 <CANH4o6MbXf1vehqa4VSUc6VhJbb_pVH71M+ovFSWV7kz4j0Pmw@mail.gmail.com>
 <CANH4o6PxoQEk3SFvRDa+BqpKXFUW6cPC9Jcuf886Ntxqmorbmw@mail.gmail.com>
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <CANH4o6PxoQEk3SFvRDa+BqpKXFUW6cPC9Jcuf886Ntxqmorbmw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZR13esZPaMPsqK3Nn8ZCjusp"
X-ClientProxiedBy: LO2P265CA0453.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::33) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|PH0PR10MB4679:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d35280-1f46-47d8-299d-08dc2131e1d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qPF3pP9kT3n7RM/z6T3pMdRkUyDeOSrmCTeRq9owTJFrg+lecaidECejKu9+0A6QUNsbNQAnOEMmjRgZoegJBdlmVhMArvQ/7/hSUX3SjMrXQ7KIyK1gOe8vBBKQ+zs39BVPaQkJxOZI+Zg+4PxulYVfRUtMgRPiv3Vxr/t5HhOALY8us01YFHpCoZNDQok1Y9cQsfm6yoYHoK9Dmnw8Tn/+2bOmxTEiSJjBLgaPJQRkq093Ivh2V74zcrc9T+Ua3A/dQ5CLqKk9rtCj7pCR8xecAf1fbeFzN33FoaitWJ4QWa/TZ+4Mycnfh16R5L0j/RjX8iSojYVGlujWePrVxPmsBZpj3msBYO3ZZpU2/lqtJfPBYbERT/vVrOwj6NoL5+49jdAMC02dym43NTppS0t1tMITfcFHCnCZwWkiSWaHt3MpGVkPkm+tqOI770C948LxRpVi85QNF1kxSgs9LODSHPymToAXbAxnQDaQYHYKQGhM65FlMmehD1ExUkRoPwxl/3wWltmjgkF7JGs7//5i+6rXQKIuRknm/uctTmNA1JFTJB7MwoZikyqDAHS+2cpJifvpRaypwl0dBDsond9+7oxX/DPoeJk8UiLjnnUPAMYdMwbU+3FdK8PBhjpKGh76UdaONdWtTD8RUt0M8w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(36756003)(2906002)(235185007)(41300700001)(2616005)(107886003)(33964004)(36916002)(53546011)(6512007)(21480400003)(83380400001)(26005)(6486002)(966005)(66476007)(66556008)(316002)(110136005)(66946007)(6506007)(6666004)(478600001)(31686004)(38100700002)(8676002)(8936002)(4326008)(86362001)(5660300002)(44832011)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cjBIclhJSG9BTFhWckJoL0ZnYm9COTBrc3dMN2UvNnVvdXo4aDdhSC9CN2k1?=
 =?utf-8?B?aDFjdi8veU81UHJhaDdvMi9MYXlZSXVyb0g1eEpoSlEzTW05dmdJYzRyUUR5?=
 =?utf-8?B?QWtNNEZjTTFoUkpRd05GTmxoT3hncWFUa01WdkJlN21RK2JHbEtrS1l1R0g1?=
 =?utf-8?B?c0xOZCs4Q3Z0MTNDcGZPcksrUUpSNGNtU3Nhd0ovZWtqcDdzd1p1R0FqZ2J5?=
 =?utf-8?B?akZsQ0trdW1IY2RKeHhzeG15alg5TUNtVTBCQlNUSkNZWWdRbVo3ekNBV2ZE?=
 =?utf-8?B?OVlKR1ZPeG9TYUlscGwxTmdaUDdoQzE4c0I3M2lYZXJodnh6M3d5bm9SN1JQ?=
 =?utf-8?B?TlFiR2tzU28veHhya3hVWGMxNGVHSERKSzZaVG16ZyttQkZoM1luVHVoSFdt?=
 =?utf-8?B?LzQ2ejJ5NmNhdXFvVnFXZWp6Sm9sNldXTkp3VlJnaXdhZ2tXUnpmcVh1a0FM?=
 =?utf-8?B?alY1UDgwK1hhTHVVS1FJVW1lQ0VTZ0hnTEdHRmxKTjBPRlV2WUlWMS9FbFVP?=
 =?utf-8?B?SGhxY0FFay9abCtCenpBeDZrWktKSy9kMkJ1cXNTQXQzcUl3cVNrdmx4ck1x?=
 =?utf-8?B?SEh3UXlwK04xTVlKRDlIRGJhRzlzTUpPcm9GdUFBeUE3WnZkdk8wcUs4RCtE?=
 =?utf-8?B?eFZkbnY5emhrUzV2cW9FNmR2V0hNTEVMdlowaldhMFR1RDBqSE5mMEhUMVhI?=
 =?utf-8?B?Q3FrRmpZampTZ0YvZDFsb2psQTNjRVViK1lnWGlFckt4ZHdXOXZGYk84NG9t?=
 =?utf-8?B?MWR6Q0tmVE5kRDlPSk9ZNGZBQ3Q5NjArR29JcFNtRTRndmZFb2piTDZQY3Yr?=
 =?utf-8?B?WVVRZVZqWDdHcXBWaW1IWXlnWjhVKzdZUUxIdVBMT211b2hJS3hZWHhaZHVk?=
 =?utf-8?B?c044K0FEUGJiSnA2cXdWczB2T3VMbFNYR1RXZEV4NG1jMXpGcGh2RzJEclRK?=
 =?utf-8?B?WUs4Y1JwMGgwY3JMcDZ0cklPOWJrL3QrZTVvWkZDMitNZGRDUUxoakkvaXlN?=
 =?utf-8?B?eHVRWG5vQ2hXMUMvMzFNMjN3dEYzUnNVTzdDWHpBTUgzSkJYR2JMVThqeUhu?=
 =?utf-8?B?TVljbHlBa0VnQUErUzZZaXJWWVhjVU1YaVIxTDhheTJJUzRhQUhudG9FVkFQ?=
 =?utf-8?B?c0pVZ2RqZ1RCQTFjN1I1WTVxWTBMRGhjQk5DdjJkcTRHOFNkT0JCUW94S2xk?=
 =?utf-8?B?cStDY2huZHNsbXZqV2FGMzFEOVhFaGZjZXBMbnozKytqem5wTWdVTGd0anFE?=
 =?utf-8?B?Sm1tTk96WlE4QlVFWGdid1VWSTlBYmovT2tBTXZaeGYzSnhGYjI5US94a2pO?=
 =?utf-8?B?eTV4ZGQ1SGpIUmIrZnd1Q01QVTg5cjMvUnZjcnMrb2ViZGU4bzBid1dVeDkr?=
 =?utf-8?B?TFlDOVljTndJZXFobWJiR3ZwSFl3SlpyRVMwRWo1TWlEYy9Zdi95bWV4RTQ5?=
 =?utf-8?B?SVo4bXZLdXhoTEo2ZkdmdGxERDVvZmtERzNFa0pQT1pUR3duVDlzV1JqL0U3?=
 =?utf-8?B?WFpsQzN3Z1lMQjhubkI2R1dSSG5rODR6Y093dE1LRjhjSmxEUXNydkZHaE1Z?=
 =?utf-8?B?alBacGo0M3R5Yzk1T0NRWWlHOGpLVnNTRnJyKzZlRHplSEo2VDRzT2pXYVBu?=
 =?utf-8?B?Szc1NWhmTkttK1JNWnlmWjRBRmNFcU1HdFNuUDJnYmhBQ2JCOVYxdU1Wa3hV?=
 =?utf-8?B?MEUxaENRS3RiQlMwMXRFMEFiSUF1cFVNMldQUmdQclpiTnhqMjRlUXRFVmhn?=
 =?utf-8?B?TGphTzVJNmVWN09VL3ptMzFJWUZFUmpnRU1yQ1lmMnZCRHVWU21WL3JNaUVr?=
 =?utf-8?B?US8zZi9XYVViakFZM3puOHlpYzJvNXg0M2t6ZVNreHRzUWhYU1R3RExQYkZt?=
 =?utf-8?B?RjZBb1ZTRHdHcTNkU1JZK2ZMTkFybzJteFRNb3UwNWU5M25VOWhpV3h6SUUv?=
 =?utf-8?B?MUJCT21JMUtDemNseEFmZEJ2WWhZNzZqZ1BjZ0ZlVmlpcFlwUDc1VFZ6VTVE?=
 =?utf-8?B?dnhPdTM1MERmNW1LdTMwc2RVemU0RXRWeEdRUHVhZEYxN2FXUjY2SGRZWmJB?=
 =?utf-8?B?VzQ3RE9qME9xL2tjVkRBNGh4amhhbVFqcFFlMi9MaHZkaW9zS3R5WkRYV3Vw?=
 =?utf-8?B?c0RJRllXRmVIRnlQSDN6aFJuWEZ5REtKWFhGWDZxWU9RVUxyOTRwQTFuN1l4?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cBHPXXNOj8zn2+djWKYcTed45aIMKtcUjYrqMQaD7V5TTfVo+rXzw82XRSYH+/FjXRZ3qnSpO4tFlWlneds/UkmsOIiWBm7yicaCbZrgMrbT1rPoe/f+C1nSSb+4wGuoJXbfaDrdd8Aiomz+pFQ2QRKnY1oOfB3kUAai0mvm+4PpvKO6MvZsGAO1rVn2bpG62+78M85u4Ihd0QYSc6tvFKEkK+vupq/yWAknq9eqdT4TW9VHUfyLd8P/pbSA22AMLDvzbXXdxl1RGdBZ5Uas43BD1jFFjzC5s6i0vM4d4b42NQl5e5XEsDBk9rmIVL7Polavk0um/GdVUOci2unRInR9tdcxNbfD9OJ9KovZijn5vWmzu0Cox2osMdI/1GTTP3KycTYcDrRCmTAPM7qzMd59EPG8/SEpSSdvueJk/04F0+DQ6fdUpJvz4TF+M/a6YRuekXATIbj7qotJ2IBAHv3z1RBtVN8nsQI4wqIqk1WeNwuAZX/KLCY9rN9EG+i/V4uoEmRIqDTKNJDsZLIonfQvCS23E+Tc1WjXlaR4IFRq8NZK8n+KH6vLFdHgHH/wHhx8IYkR4K2KqXa+WuWkVkmp+16DgzgHBoTzTKiteo8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d35280-1f46-47d8-299d-08dc2131e1d5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 01:22:10.8637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e07B/SCXZkSelzhSYM12JH5iLLpcB3WgGmNbCucssxYjIGoDL1kbT8Ms+PkyNYi1Fa8xbNUNIdfWucy87GCTnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=992 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300007
X-Proofpoint-GUID: W-MnuVNc6LWihgdx9MnhLY1WYDk4wsY6
X-Proofpoint-ORIG-GUID: W-MnuVNc6LWihgdx9MnhLY1WYDk4wsY6

--------------ZR13esZPaMPsqK3Nn8ZCjusp
Content-Type: multipart/mixed; boundary="------------SxHos0s0y00SwTpflUAVtSSO";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Martin Wege <martin.l.wege@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>
Message-ID: <99ec805e-a0d4-44ea-a6ea-9478e98d4670@oracle.com>
Subject: Re: Filesystem test suite for NFSv4?
References: <CANH4o6MqecahkZj3i4YwS1UQjQimFrDcbM8abCbrGiLyk9ZTkg@mail.gmail.com>
 <CANH4o6Na-KPweTmeUAiU9sK4OGt8RkkZU+vK5xpEe-BrP-s_Bg@mail.gmail.com>
 <761568108.788363.1700121338355.JavaMail.zimbra@desy.de>
 <CANH4o6MbXf1vehqa4VSUc6VhJbb_pVH71M+ovFSWV7kz4j0Pmw@mail.gmail.com>
 <CANH4o6PxoQEk3SFvRDa+BqpKXFUW6cPC9Jcuf886Ntxqmorbmw@mail.gmail.com>
In-Reply-To: <CANH4o6PxoQEk3SFvRDa+BqpKXFUW6cPC9Jcuf886Ntxqmorbmw@mail.gmail.com>

--------------SxHos0s0y00SwTpflUAVtSSO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

aGkgTWFydGluLA0KDQpPbiAyOS8wMS8yMDI0IDExOjQzIHBtLCBNYXJ0aW4gV2VnZSB3cm90
ZToNCj4gT24gVGh1LCBOb3YgMTYsIDIwMjMgYXQgMTA6MjbigK9QTSBNYXJ0aW4gV2VnZSA8
bWFydGluLmwud2VnZUBnbWFpbC5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIFRodSwgTm92IDE2
LCAyMDIzIGF0IDg6NTXigK9BTSBNa3J0Y2h5YW4sIFRpZ3Jhbg0KPj4gPHRpZ3Jhbi5ta3J0
Y2h5YW5AZGVzeS5kZT4gd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IFdoYXQgZG8geW91IHdhbnQg
dG8gdGVzdD8NCj4+DQo+PiBGaWxlc3lzdGVtIHRlc3RzLCBmcm9tIFBPU0lYIGxheWVyLiBv
cGVuKCksIGNsb3NlKCksIG1tYXAoKSwgd3JpdGUoKSwNCj4+IHJlYWQoKSwgU0VFS19IT0xF
LCBTRUVLX0RBVEENCj4+DQo+Pj4gUHJvdG9jb2wtbGV2ZWwgdGVzdCBjYW4gYmUgcGVyZm9y
bWVkIHdpdGggcHluZnM6DQo+Pj4NCj4+PiBodHRwczovL2dpdC5saW51eC1uZnMub3JnLz9w
PWNkbWFja2F5L3B5bmZzLmdpdDthPXN1bW1hcnkNCj4+Pg0KPj4+IElPIGJhbmR3aWR0aCBh
bmQgbGF0ZW5jeSB0ZXN0cyBjYW4gYmUgcGVyZm9ybWVkIGlvciBvciBmaW8uDQo+Pg0KPj4g
SXMgdGhpcyBhIHRlc3QgZm9yIHRoZSBORlMgc2VydmVyLCBvciBORlMgY2xpZW50Pw0KDQpJ
dCBpcyBtb3N0bHkgdGVzdHMgb2YgdGhlIHNlcnZlciwgdmlhIHNlbmRpbmcgaGFuZC1yb2xs
ZWQgcHJvdG9jb2wgDQpjYWxscywgYWx0aG91Z2ggdGhlcmUgaXMgc29tZSBsaW1pdGVkIHN1
cHBvcnQgZm9yIHRlc3RpbmcgYSBjbGllbnQuDQoNCmJlc3Qgd2lzaGVzLA0KY2FsdW0uDQoN
Cj4+DQo+PiBUaGFua3MsDQo+PiBNYXJ0aW4NCj4gDQo+ID8NCj4gDQoNCg==

--------------SxHos0s0y00SwTpflUAVtSSO--

--------------ZR13esZPaMPsqK3Nn8ZCjusp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmW4Tz4FAwAAAAAACgkQhSPvAG3BU+JT
/BAAidIyi5kmYI+fWCtHIpVBPK0oInKRkcTGpOy352s29+kaJE7GRL9oRSq6dFC4TbsruxqmNSIC
wh2cCJ2EKb/inuPdPN/o19O5sDMyirPtfi97RHlYK0CgwGKNOLhl+oBEeehf/kJT3YlIwm3MgU80
iYDvijY8T8tNTdiyEres0mFU3BPs7fxYU6Qn+O5dZWLbMeEXUFPz9TZLOvXdJiZW5LujfVKcP+ZP
kI3ZkUAJq0DivPClupOYNinfovcdOF7P0IFqbrv8NGaAUEhixguFVNuPGILkrUCmSPNFM00aJ0nI
XGy0Sk5yIOqxnrFre4FHOiAsy4LylguBd71K4EetXyB4KRsNEMdIJ4y3+fr5Kbuff4O/8HS41CrT
EjoY8F57H2umbqjqW6G0s9Nu2pe8nzos6HFxjQlkG0fegDkAlmzqhJzBkrtv/UyzEynRcFTieBA3
6CW/3X7vVVhW/kMAnA+zcKKGAmzXQ5blSDEqKyYTBFoDJmdCQ8bppZJZ0ZKhThvhhcVByW6dJC03
JDsvtqNvCEJpSQfOsUfH+8NDEv3C8+t4gP4yEohyduBNpzGi2HbNqgLBGCacXPuzsRMcxgr8MR63
5nJzmYrQ0raLqEph4HI2eNvL9m1Zw+DWTDlcOz9lACvt+YcUgeYf1wEViNTwwG2dTtlEUAU5rt8u
YAM=
=5ZXn
-----END PGP SIGNATURE-----

--------------ZR13esZPaMPsqK3Nn8ZCjusp--

