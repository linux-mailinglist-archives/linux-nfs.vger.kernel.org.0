Return-Path: <linux-nfs+bounces-16082-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA204C3760D
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 19:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207D61A218BA
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 18:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5382BE7D9;
	Wed,  5 Nov 2025 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Onujm2vc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RzAAMQWC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5123D243376
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368633; cv=fail; b=SbFWVKxMadZuQ9/P4TOxR+pYI5lsTKWPmKVN4iHpiVu+LDh64JK0Lq8br/moMHzAPi6WyIvh/4HaLbXO9zOzHfKZuGNvn1cRL8rV64noRdwkvlsGwSWf01YN7DVZ0s8dkJucJTjfJ0Eru5m9o+/rGWTemM7s3EwbauS+czEahIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368633; c=relaxed/simple;
	bh=XwxSjIi9fVVTdFwh9ZqHb57p+tm3AvjMHm0Uwcz8Yik=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XlkhNpY9JL2AAL4fqcSr/uUKSolmkZIBX5Y9G47N+BRsCwJaJB+ZFMYcxwlMreD/+tUoz6wOLT1qonQ2nS0OEq0WSHBrDsfs4ho6WT2mRhbnt72jt6bZ6vGQmn1gSZ8hY957aeV+zPBApDoD5IuyiudUImLj9nHCPIu7tOOZjPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Onujm2vc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RzAAMQWC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5H9olT018344;
	Wed, 5 Nov 2025 18:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Kq6zZkXArnKs6YpkmbyU2lOxa3drJvmlbzpyLoiuKMI=; b=
	Onujm2vc2OxwvQJ7gz0sbhhYNdzjB3RFDVMiFFK4hqfzvK9qQK0xOS4p+fiOWwTD
	SS3llOiPbD2zJcO4sXbOWUr1Ep/IrWrNeZ3KpxwK3AlejlQWCJlMXMLHdUnIWJxf
	Vz7Da8we8nSD9Wh7FSk55sFqXkEmXd4uYixDcm/RKI1RRww2cq6IPhgM0fHuFzpd
	hm5XW42k5OLUi+g6RpYkdsYGq0VJY5sWPQGt4A2ga4v9CPug9ob1AbrgbdE+mMpp
	MH7UFIAllJHa0uCvc9mFIpAmjTc72KoQ+AHpqYuW7iW45qE0PBrm7hpibQQGBl2R
	dGwxujIixvTpTgv3KmLSfQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aqw88hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 18:50:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5I6UZf002651;
	Wed, 5 Nov 2025 18:50:27 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013037.outbound.protection.outlook.com [40.107.201.37])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nexbdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 18:50:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pE+31/0Y1y27vi43UjoH7imkkPyWnCUX6pXNFP4zxAlW5naRx3/CO8KBC3dRzoaP3Qup/cZWWnFVaBXqXb7ZFVVEq1IpnBwFH5yPF6DemaajvEER3EwBlfc2rD0o4r7ODLnujXZFItAkCDWYdii591GN9idtXIbTyXQ1Frk5yFuWOFLUUGDUqnZP9f1nRYGwNvUR0S+HeKRXl7ObsKncV7ZFMzxO2aDFohs38eaGqKd9YPPHjypOmxvCp8QV77R0GGxmHLsqaxuZZFPJBrDAscjooMJ0Qp09M5gDfPv7ZPdLLvtia3BEqhwTSG/JevNSoixGdr1NuBlB/rSBykB8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq6zZkXArnKs6YpkmbyU2lOxa3drJvmlbzpyLoiuKMI=;
 b=oZXEoe4C+udl4VvKx01BgrVL0gb9vBM1HYZH5yMZwwMz4apXyVvo9NumFKTpQB3r7Z3k0oLo4hfRdGGgbFbupsyP9WwlbRChsI3yAdNHpIOmk2pzh7cFj0r+QXBfcNGdotLhmgg7EInuNUfl1uoNH8u295ZenajdeedSEJk6GEKrrV3RHRjxm+opo3Mz6TFtwedBpDvDT03iQddr9FPtqBNf+tWdEauYEhXQQfBfumXvIdJJSD2jrH1HRoX8x0uY2zQbniFwDfRvaUG1Nwn1kRIPJ6xHyUsT/jf5xqdgwiLHAHYe8KJQzXZbj5fKhIF8T15efYvCQZeTN30FlqWRgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq6zZkXArnKs6YpkmbyU2lOxa3drJvmlbzpyLoiuKMI=;
 b=RzAAMQWCdI73zPQ5iDsZPSB9wWPA9utDsLfzyyyeROPRwcTfYT/2uOLxaTG+Xc9fvNq+TRZ7HSq1Bd5/8qVCfJ2MruK+J0BA8FH2567OaDZjIs8wyGsbi+vLgw94fCNN7O4naNeuIjlq2o8Isc49m1VR0cV8IlqN/Dd395G4bEA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA3PR10MB7096.namprd10.prod.outlook.com (2603:10b6:806:306::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 18:50:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Wed, 5 Nov 2025
 18:50:21 +0000
Message-ID: <65e3729d-8434-4bdd-8039-804782c20f95@oracle.com>
Date: Wed, 5 Nov 2025 13:50:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] NFSD: update
 Documentation/filesystems/nfs/nfsd-io-modes.rst
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20251105174210.54023-1-snitzer@kernel.org>
 <20251105174210.54023-4-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251105174210.54023-4-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:610:20::44) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA3PR10MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 263f3b6a-7c4f-4519-0dd7-08de1c9c2c4a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZzZ4TVQrOUFUdk1aS1pRSWN2bUlzSDNIZFVScDJGUGFINHdUV25ldWRlR2hD?=
 =?utf-8?B?QmhxVkl1aFhQZmhLN1dnR1crTnhvTXJxa2l6b0FYNHpwVjR2VWJFWmJnVkR1?=
 =?utf-8?B?eTdwV3dzZ1JvMTV2Ky9WRmZ0Y3pZVWZQQ1FxMmVyMDRZL2QzSzg3YWxEK0dy?=
 =?utf-8?B?Zyt3TmM2bWdYcUZ0MGZVUGtyWEp5YWVvd21oVFphNlZPeGJMMXFMVk1GK25z?=
 =?utf-8?B?T01aRE0wOFUraHBtWGI1azZlNTZheEtJVXdZQVBUNGN2SHpSbTVsc25ySGpJ?=
 =?utf-8?B?elJMa1VBTzVSOUMxVWNUS2pXNnlwZGFJMkpJNFJmN1FRQnMxY1lST2phbEtC?=
 =?utf-8?B?enVNZFlRY2xWaWR3VWVLVFZZcWhFTVFYUVY2MDB6cVNUN3pnUWl0TmdLcVJz?=
 =?utf-8?B?ZTNKYk5oKzRxcUtnZC9tcmk2QlhUbndwTlprUDU0ejhvekFVVzRDTlFwVzJX?=
 =?utf-8?B?Sis2Slk0R2hYOTVJWmtXdnZzR1VvV2xDbHEwSzNWOEpvNzJsTmFWekx6SWx3?=
 =?utf-8?B?VTRZYmQybVByaVZDaG1IR3R2QWZZYWFtU0RoVkpuWW9FVUNHSnFhUHNlVFhX?=
 =?utf-8?B?Q0tOSlI5SldKeS82ZlhIQW1xSHlNMmJHaFJHZzk0L2FqMTc3VnFXNUxya2pC?=
 =?utf-8?B?ZHhWYkVTQmwzUTJJZmgyaWl0czZkdlBtVmNJbmdDN2dmN2JORE8relVRNnVI?=
 =?utf-8?B?VHZHTEk2RGtFaFoyZUIxOXZoUkN0dTFLWlRTQ0RISTdYQS9rT3d3VzduS2FX?=
 =?utf-8?B?Zng1RW1XTWYvM0ErcGVwMlBvZEpLS1pXaGQzT3RKRSt6UFF0cTEvK0YvU0VH?=
 =?utf-8?B?RHJ0MmwrZnUrNzJGdVYvWEwwSUMxMHN1QTVPVXZhNDdna1llRzBDWkpEbnl2?=
 =?utf-8?B?a3JQMG9rbk9hRGcvbkczQjJONEVrVFowZ3BnOWcrd3ZtcmV5bzBMaWNNVEVP?=
 =?utf-8?B?Zm5mbklBTWdQbTNvV0pxZHFpUHRvUEg0dVBGOXZublhhS1pZZjVSaTlLeGI4?=
 =?utf-8?B?WkpJM2RRYjl3UWRtZjVBL0o5M3duS2M1UmtmUlQ0RUE4aVhvRFdIckNUWUNt?=
 =?utf-8?B?blQ2dHFYWXFxcml0b2c1eGJtSjZGUXloRHh2bDRCdlh1S0llOVQxMzkwdUVZ?=
 =?utf-8?B?TWcxNTE5cHpQQ2kyS1JnU0tzaHErdnJDYjJuUUFKNTNtUFRldzN0QjE4ME4v?=
 =?utf-8?B?WkpPMDE5L09xa2JnYnlDZXhLelNicjArdiszbGlQS1d3ZTBxTUI5bkZpTTR0?=
 =?utf-8?B?eEpqZFhmdjNhUUpvdFVHN3IvR0NHY2RMVDJiYzdhdGxQTW5ZRTF5TnBtVnUy?=
 =?utf-8?B?RktzcXFRR2RmS2FKaDh4L245eWdIVjFhT0VnWUpTK0lqb2xSUnc3Q2VyOUc2?=
 =?utf-8?B?QWt4U2VyVWR2MlRlRHYzdk1KOVhpTWdjSm12RitIUXRyYm5WWTE3UXlJL2VJ?=
 =?utf-8?B?d0xvK1U5L2RNa2RXZ3lQSGVGRHJ3ZG4rUUI3MFVTNXh6TCs3TERpekRqdWN4?=
 =?utf-8?B?OTVrVUx2M1pJYUQ0QThoL1ovaGxCNlN3SnRPZXQvdFBHQThCdXRSYlY0bk5M?=
 =?utf-8?B?SUNTZi9vaEtYQUdBWHRqV3RUSVMrWVVMNUNicGJSSkYzeEM1ZmY2VGlTRjVZ?=
 =?utf-8?B?Ym8vR2NBS043MnVTbUZHaWdZa1lTZ3FIWXBrV29oYk1IS1FBSDRmZS9kNklB?=
 =?utf-8?B?MkU1K3dCVFJUMXpZa1VSQ1RTTVkrMzhTVG1CZDJRd3VTRUZZOW9OR1VYN0VM?=
 =?utf-8?B?SGFEdHBxMm5tS1V3TFlZZFhmc3dMOFkwejFVRTZZZlFqem5oekZDc0dubWFU?=
 =?utf-8?B?UjlDZUhROFd5NHIwL2JmZ2R6Mkpwc0xTV0ZUR1Z2MjhtUENYeEgwQVI2QXY3?=
 =?utf-8?B?Wkp0NGFQVjE2eHY1RFFtT0c5VlR2Y2VOZUhTZmtSVU04Y3dKM3AzM3RMNm1n?=
 =?utf-8?B?VVJ3bVZSUEtuS2dTcEJ4c1VUcXVlV2JQUkdranNWQTJQL3VObkt5cEcrMFRj?=
 =?utf-8?B?YUhmT0ZJOVZRPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aGw4b09oUGx3aWZjbEpYb3NFU1V0NFRzbnJGUXpHQU8xdVo1a3ZzR3NLY3dW?=
 =?utf-8?B?ei8zNVFFOXdhK1djODdYM1VVZU9KVnpKVnM0cnhuQllKMW52OHdEOU1vV2xt?=
 =?utf-8?B?VElzcWNWb0IwTEFEY0NWaGgwakhBUG9nQVlxaDBjN205UElYS2VYbk9mSEU5?=
 =?utf-8?B?dlZNNEEzbkh5Q05sdnEvb2d6dmUrY2ZFT2lYT0RrNXRWNzk1ODduVHVjNDZN?=
 =?utf-8?B?QUc5SHZMMldmOUNiaGZ0ZURFS1UzQVdqSnA3YXg1NE1XdkpOcnIxTFJTNWd4?=
 =?utf-8?B?Y3hkOThhVEg4SGxVajFLYXI1bGMzejM3MkU5aURzTUJ2a0RtVC9QRjMzNEV2?=
 =?utf-8?B?S0U4cUNqd3J3b1MxZ1hOS3BTbCsrMWNCVXNiS214QjhkVGU5c1BmbjV3RWtv?=
 =?utf-8?B?azUvR3pYY0R1dm50QWF3bDA4TWxUZTdPQllVQllDYjkwenl2NnphS1Y0Q3hx?=
 =?utf-8?B?S3d6SDFvWG9FRlE5N0RsY1ZsQ2JaV2xMYWZaOXRaQXlMTGFEei9icWRtZkp3?=
 =?utf-8?B?dWtIdUNibTFIcFNMYno3QXhjbFJEZTZ4MmtWYXRHV2tVcXVJT2lxbzdhQVo2?=
 =?utf-8?B?TnNqS2F2ZHExMlM5R1JDNlpSall5RWJYS2M0di93SWdNcXQzdlkvc3VvZS9W?=
 =?utf-8?B?c2ZFNllrT3lkTTZVRVN5Mk5XREtaZ2RhN25DcHpYeUJhYzVqODBybkdBRDBD?=
 =?utf-8?B?QzNtNFdwWVJrc3dKZGpIOTUzZ280QnFCOWVLV0hEdWRiVVpRM3BMd1VxeWN2?=
 =?utf-8?B?eGRRcFgyT25pRFg3dmcxS1VLdlVsYWxXZk1QOHFUTkY5ZDRXcXJRZW83RDF5?=
 =?utf-8?B?Qk4zMkd0ZWtDVTRSWXEzSGthT29BQWIvMVdJU1k2RFA5WmZNM3FvdUUydTFS?=
 =?utf-8?B?aG4yN2tWVkN3bjlWNVZodER0UnhwNWdDTGJXMnlWT3RrTW0xR29RWngxdkFL?=
 =?utf-8?B?NmhxMnNZSkQxMFExQm1TeDdvSC9ibjZ5aTlLc2sxY3MzeWlCb0xXbTEvcHE5?=
 =?utf-8?B?TEtqVU05MXdIZnpXSWhWcURXQkNYNnpJY0tmdm9RU09lMVhkb0pEdkdmSGUv?=
 =?utf-8?B?NC9oTUlLZXlxSW5md0J6UVliVjJEWmdxanNvMzl2Q09UWXR6L3huL3JBaWlU?=
 =?utf-8?B?Wi9nbHdlZEQvdnNNdXdrT0FkTzBvcytNdWl2OUVGUW5TTUszUExraGJ0TERh?=
 =?utf-8?B?Qllna05JUlR1bEVWTjV1b1RpNlJkRmgyNnFieHJub0JGb0lGZDY5TS9EQUkw?=
 =?utf-8?B?bGtFS2laU1VwRnFwd1pzcHcxWCtoODBtVDYvY2FVSWtQYnlYSUdDL0p0ZWRq?=
 =?utf-8?B?dmV4QnJQbkI5U2pUVWZoekZFQmNaVnUxTldqYjlGc3lHbG04dGVUc2t3bUtm?=
 =?utf-8?B?c2Uza01INFVtMXZLS3EzRGtDelF4RkZuem5TSHNSR3l0amp4OFB5bzFTcjkr?=
 =?utf-8?B?QVMxN0NhcStZVkRHYXZpNys2RDhGc0l4WE1QMHU3TitaekxHKytDbkxyRDlF?=
 =?utf-8?B?ZnRyZDdEVlV6eVFTZUdaYVVsekpUNDZDbnZmYjFHMlJ3SkNmbzNJODRTZW94?=
 =?utf-8?B?a0hNaXloYjBLVkVXc2VGMzVFRlF0Y1hUWWZuYi9yb0FNcHZHUWJiN0FnU21s?=
 =?utf-8?B?Y1FKQlNjcTR1TmFlaGJLUHMrTDZaKzBUQzZvRnFXUFdhYTJtMEJLRlFjZGlq?=
 =?utf-8?B?TUZHaXJhYk1yekxic2pHU3ZlYUEvV1M1SCtUVUdUNzNkcXp1WFhYYW1rblNx?=
 =?utf-8?B?UnRBMEFJQTh0Tm95Ri9RdDYvMzI3NVpSTlFzQkFrSmtvRm5WOVl2M0dNMEZZ?=
 =?utf-8?B?RlNGTDZid3cvTEYzQmNZTVlUYWJNY21DWDZnNExJcm5jV285THZwUHNXQzI5?=
 =?utf-8?B?VDBaMWg1Y1Z1K29HYzJoWnZ5Vjl4L1owZ0ZmTnhiTCt3SnVicVgvRFFXcGFG?=
 =?utf-8?B?eDFOMU9hNlhqU1ZUVzBiWnlxNy8yeXo3dDdkdFdqejFrRlZIZEFXQ2xxZXRF?=
 =?utf-8?B?a05GVFBQNkpGaE5aTkpkdm12bUhTd3ZkNVQyVnY1eEk2NW5TRUxOT3VmZ2FT?=
 =?utf-8?B?YzAveUJVOERYdk5jSVQ1UzRGU0ROYUg0blJhQkJvVHNETWV6VDJZUU10Qkpr?=
 =?utf-8?Q?SBKlVwMdJbMTe98bXb1hf8D5X?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nA0SsLiwsZIa/6v2g6hXXr3mT3hZiOtKhAT3QDIwQjjILrCRy1qaqR0a+F6esZKP0EdZRV27pM7iC1l+1BFdlCIQMD9ndW04pdJrilxFMnh7F/jJz8OT/0Z6SbnS9Z1V2k8DtpHf1DHXL1yOM31O3UhoBRG0cKyKWPDzYGHJhS5RValiSi4Rdzf9nEMNxGp/oXVL2uFhwVLNNg3659gfW5TXJPJ0UVh+iZxN1jESwSTdKVlHHgoT+ZVGzCeQcClgMrhAolRoKRZrS1YZv7NynRAqNllgv8zJszbAR4Bhcf/0mTseOnbekt9IcGfeeaYndmAgb6tKkCY5djPEmYjCxMrpVzWHUWRBwHF+f/WjYxEwt2QM52+btAV6rnaJ2EDjWX5vDIzHu/mrJUg575nZrSBQHKoJjDSY6ry09CogbzXc1/BcH8SlMNJ7UlddSeGNX6mrNfm9s4q5nU8M6CjxoAx7nskZ1fSz3cnd80r2bb5BQsUSuMJvkL6xN4oHVJM5aX/8S51Idc8Rd+QQVsFrx2RnKcAseViGzy1SUQ7bQbhlHkQKV8HJWgFwaRCzoiEYPpEp6Lk11SvGfdY/A3WpZWRZEZKyUiVcl3o85LmSoZk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263f3b6a-7c4f-4519-0dd7-08de1c9c2c4a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 18:50:21.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wf9Gsagd5d26pl3Vj6cKfBATBM2jsG6BRkc9qLaAzY/Lrslx6Hyew/XOnhXwPCXbtG4mhPhMSPLHyydZ6FMAew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050146
X-Authority-Analysis: v=2.4 cv=NajrFmD4 c=1 sm=1 tr=0 ts=690b9c73 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=nDVBkZEsgj93R_hh1rcA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13657
X-Proofpoint-ORIG-GUID: edMbNHIlaThz1pCaZ--vQwhZxwzxIFeh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfX/c67WbGMUwmj
 QpDngxZS82ARD5xD0O1HeSB8P4GIdHsX6rCI0hbPpZOdpazOcsw0YaRrVy4WBY/FAtIuj2abznk
 DcrRa1yREP2iFgW7H/YIVEA+MFt7eghediEGRltYp73wnYyuGupYTQoTZ5QOG5QEyXv9bPhRqz+
 JGjgC7/YM31PGXDiqww6G6X4KDyWrB/+fm4G2+5q96WhBtx2RAr9Oss3eHZwCHJ6nL0I9z7zVK9
 CdVwdrNGGfaGU/MIUUkshsXrrV7P5mW4Khj4VxZmeLDspIsfZP2ZBX8gG9T6VsPOegFWJtVzh6C
 0BApSSdFJgUb+3fJs7AdLDLv5jmknt32Hj2lSbUVb6OSu3sLGsWyVRb/L5hUcYTfbVv3kT+WpP7
 4xdZ6gAInt2gxT3B8Q30pJu9/gzGSKEB3Oowy9aqWemQFD37zvw=
X-Proofpoint-GUID: edMbNHIlaThz1pCaZ--vQwhZxwzxIFeh

On 11/5/25 12:42 PM, Mike Snitzer wrote:
> Also fixed some typos.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  .../filesystems/nfs/nfsd-io-modes.rst         | 58 ++++++++++---------
>  1 file changed, 32 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/filesystems/nfs/nfsd-io-modes.rst b/Documentation/filesystems/nfs/nfsd-io-modes.rst
> index 4863885c7035..29b84c9c9e25 100644
> --- a/Documentation/filesystems/nfs/nfsd-io-modes.rst
> +++ b/Documentation/filesystems/nfs/nfsd-io-modes.rst
> @@ -21,17 +21,20 @@ NFSD's default IO mode (which is NFSD_IO_BUFFERED=0).
>  
>  Based on the configured settings, NFSD's IO will either be:
>  - cached using page cache (NFSD_IO_BUFFERED=0)
> -- cached but removed from the page cache upon completion
> -  (NFSD_IO_DONTCACHE=1).
> -- not cached (NFSD_IO_DIRECT=2)
> +- cached but removed from page cache on completion (NFSD_IO_DONTCACHE=1)
> +- not cached stable_how=NFS_UNSTABLE (NFSD_IO_DIRECT=2)
> +- not cached stable_how=NFS_DATA_SYNC (NFSD_IO_DIRECT_WRITE_DATA_SYNC=3)
> +- not cached stable_how=NFS_FILE_SYNC (NFSD_IO_DIRECT_WRITE_FILE_SYNC=4)
>  
> -To set an NFSD IO mode, write a supported value (0, 1 or 2) to the
> +To set an NFSD IO mode, write a supported value (0 - 4) to the
>  corresponding IO operation's debugfs interface, e.g.:
>    echo 2 > /sys/kernel/debug/nfsd/io_cache_read
> +  echo 4 > /sys/kernel/debug/nfsd/io_cache_write
>  
>  To check which IO mode NFSD is using for READ or WRITE, simply read the
>  corresponding IO operation's debugfs interface, e.g.:
>    cat /sys/kernel/debug/nfsd/io_cache_read
> +  cat /sys/kernel/debug/nfsd/io_cache_write
>  
>  NFSD DONTCACHE
>  ==============
> @@ -46,10 +49,10 @@ DONTCACHE aims to avoid what has proven to be a fairly significant
>  limition of Linux's memory management subsystem if/when large amounts of
>  data is infrequently accessed (e.g. read once _or_ written once but not
>  read until much later). Such use-cases are particularly problematic
> -because the page cache will eventually become a bottleneck to surfacing
> +because the page cache will eventually become a bottleneck to servicing
>  new IO requests.
>  
> -For more context, please see these Linux commit headers:
> +For more context on DONTCACHE, please see these Linux commit headers:
>  - Overview:  9ad6344568cc3 ("mm/filemap: change filemap_create_folio()
>    to take a struct kiocb")
>  - for READ:  8026e49bff9b1 ("mm/filemap: add read support for
> @@ -73,12 +76,18 @@ those with a working set that is significantly larger than available
>  system memory. The pathological worst-case workload that NFSD DIRECT has
>  proven to help most is: NFS client issuing large sequential IO to a file
>  that is 2-3 times larger than the NFS server's available system memory.
> +The reason for such improvement is NFSD DIRECT eliminates a lot of work
> +that the memory management subsystem would otherwise be required to
> +perform (e.g. page allocation, dirty writeback, page reclaim). When
> +using NFSD DIRECT, kswapd and kcompactd are no longer commanding CPU
> +time trying to find adequate free pages so that forward IO progress can
> +be made.
>  
>  The performance win associated with using NFSD DIRECT was previously
>  discussed on linux-nfs, see:
>  https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
>  But in summary:
> -- NFSD DIRECT can signicantly reduce memory requirements
> +- NFSD DIRECT can significantly reduce memory requirements
>  - NFSD DIRECT can reduce CPU load by avoiding costly page reclaim work
>  - NFSD DIRECT can offer more deterministic IO performance
>  
> @@ -91,11 +100,11 @@ to generate a "flamegraph" for work Linux must perform on behalf of your
>  test is a really meaningful way to compare the relative health of the
>  system and how switching NFSD's IO mode changes what is observed.
>  
> -If NFSD_IO_DIRECT is specified by writing 2 to NFSD's debugfs
> -interfaces, ideally the IO will be aligned relative to the underlying
> -block device's logical_block_size. Also the memory buffer used to store
> -the READ or WRITE payload must be aligned relative to the underlying
> -block device's dma_alignment.
> +If NFSD_IO_DIRECT is specified by writing 2 (or 3 and 4 for WRITE) to
> +NFSD's debugfs interfaces, ideally the IO will be aligned relative to
> +the underlying block device's logical_block_size. Also the memory buffer
> +used to store the READ or WRITE payload must be aligned relative to the
> +underlying block device's dma_alignment.
>  
>  But NFSD DIRECT does handle misaligned IO in terms of O_DIRECT as best
>  it can:
> @@ -113,32 +122,29 @@ Misaligned READ:
>  
>  Misaligned WRITE:
>      If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
> -    middle and end as needed. The large middle extent is DIO-aligned and
> -    the start and/or end are misaligned. Buffered IO is used for the
> -    misaligned extents and O_DIRECT is used for the middle DIO-aligned
> -    extent.
> -
> -    If vfs_iocb_iter_write() returns -ENOTBLK, due to its inability to
> -    invalidate the page cache on behalf of the DIO WRITE, then
> -    nfsd_issue_write_dio() will fall back to using buffered IO.
> +    middle and end as needed. The large middle segment is DIO-aligned
> +    and the start and/or end are misaligned. Buffered IO is used for the
> +    misaligned segments and O_DIRECT is used for the middle DIO-aligned
> +    segment. DONTCACHE buffered IO is _not_ used for the misaligned
> +    segments because using normal buffered IO offers significant RMW
> +    performance benefit when handling streaming misaligned WRITEs.
>  
>  Tracing:
> -    The nfsd_analyze_read_dio trace event shows how NFSD expands any
> +    The nfsd_read_direct trace event shows how NFSD expands any
>      misaligned READ to the next DIO-aligned block (on either end of the
>      original READ, as needed).
>  
>      This combination of trace events is useful for READs:
>      echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
> -    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_read_dio/enable
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_direct/enable
>      echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
>      echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
>  
> -    The nfsd_analyze_write_dio trace event shows how NFSD splits a given
> -    misaligned WRITE into a mix of misaligned extent(s) and a DIO-aligned
> -    extent.
> +    The nfsd_write_direct trace event shows how NFSD splits a given
> +    misaligned WRITE into a DIO-aligned middle segment.
>  
>      This combination of trace events is useful for WRITEs:
>      echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_opened/enable
> -    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_write_dio/enable
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_direct/enable
>      echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_io_done/enable
>      echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable

I've already squashed the previous version of this patch into my private
tree... if you confirm there were no changes, I'll leave this one for
now.


-- 
Chuck Lever

