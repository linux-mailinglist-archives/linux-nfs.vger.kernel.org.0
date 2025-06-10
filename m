Return-Path: <linux-nfs+bounces-12258-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92428AD39FA
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 15:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499BC18827DA
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B2F27FD7E;
	Tue, 10 Jun 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VikOQZkH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e9GBeiFn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6774230273
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563564; cv=fail; b=ctvaIWGcrMqElOMJR0CjRPlk4zb/klCJp++kIQpU2XB1ySlA0stk64fvznWSjiB+RPTGxwNAWE20cQwL7x6DKpVx8F94nhX3Hriq2Sou0Chm3hE/ARpVh6SJOeIhXm5yEo2Z+UjdmFRhZyEj/lYRaqepC3Pm4wuKzrEtxDsgxaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563564; c=relaxed/simple;
	bh=UGg7dzJdjPYJ2pdq+pDI4Lq+Tj/KroHsRl1goIQGbdk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AMuVxRqCXs5DIMqMDeBE/HbcRnigNw2sRkxZ0bgSUQhNrScmyMHFR47BhSUy03jKUVRyLzelwpPMZ0Yq+ugTBa2g8KlfmsyDB82mvPBMaQasoQe1ly1J2p5Xo1XJPBsKmtEUNqixBH+0PpWXD6QJMDCBUd2vthRtPi1Qk+Ti9bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VikOQZkH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e9GBeiFn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADBdtQ000585;
	Tue, 10 Jun 2025 13:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=M2dz0akQM0IZmn8yhUbhItlJQYtg8Mc0jwyOx7eRJVI=; b=
	VikOQZkHScwI0fUAg/Js+0bxnMK1pLSj+NeyaiBxPMYtZw8qkleIkVCNUis4po1+
	mqejjtHpkb/Bhy82oONgngKIjwPK0eEu8as7yFzZ3G/VoJMjcizs0ctWUAcIw/o4
	Ts+JqnpUWvkfPJ+VgHiiZcdhb/XdXSGLVF12RYwVFrXoV4NbeU+9j83UOp0sCatc
	Y1MVuLPXV2jxBnyqvcWA9ZTtmRSan0OdGvP8I5Rard8/7RNcyL0ERdAKLAcOopjm
	sa7WanCJHUH/97OmYcX42nUOR8iphbp/bq1CPXd3AubtLeJxIAoXZ1J+hNZS3x68
	55A8Ao36f4FNiHYgAfCyGg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474cbec9mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 13:52:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADm5bC020712;
	Tue, 10 Jun 2025 13:52:33 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012026.outbound.protection.outlook.com [40.107.200.26])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9fqmd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 13:52:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAJU6I9pCC+oMIy44o8RNonDxZaA4J51MOhVPdMSMaxo/geocSuG2oJDIJabGbPXG3168FQLqGqOP7CDPXDzhWanRoPuO2i1uDfH8kuk/JfeLeaTdWliXdI6iwCkm+h89Whj9oAfj8bz3jNao+RS6ideGLTWZ87dDzU7rr9eBXxJh361JGaXHE1HuKvlEm58OUdMbOQJQubQdcgiJGc5nr5ymv7Qwpcsd3q7hNAs2ilJEuqb7rHo/YtcpcRRl9MimHrI9ModQkmD+5WxtVwi7H+Pju1YASiDGlUGpDdH6VXHHE4e3y1BHwuu8CoS/AbsS6sMwGBBKArb9Q5f2ukhxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2dz0akQM0IZmn8yhUbhItlJQYtg8Mc0jwyOx7eRJVI=;
 b=bsywGjoByrMFvfuyAVEB24t1cbFr/HKi4W+7xE931lCKARiO5+lsSJFx5RdrUSOcGJJASLX8vT6w8ZlLYNZbwrdbZWJIhEBNfXmF4ikKrzZTMZe6rPbNM0W71DDKToGT4+gEJxHZN+uAq/UmzdDoFR5JUC9lApUX0wT9Oe2SuJ5E+zCbEhj+QXZiQvAZtIXely/5UT6tncxZuCE45sqof8Twszl9s3di7LpTOoWpRYbTtRiMfie8KB5vNrktIi6aaDg2s1f8UJwxUbSR3mNhucWdFGpTkHJxPd3lvQNwYx62L6IAU+2khWnXlLTSaPdLKPboz68U+VEHEulEoxstPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2dz0akQM0IZmn8yhUbhItlJQYtg8Mc0jwyOx7eRJVI=;
 b=e9GBeiFntsULvf8X5aIt9dear/jIQfOFWicxxJaaTrLpeLCrk1IMGx4xRPuD4xVNLmy2xopUwxhuVAmEmk21ewvrQWvyTmP+V6KrZif3e/7S23A8qryB5iM+NnwdTVE8Z6MerbP4YDsGS81HXj2waOj4pn/4bSNE6Mu+hmF6N5U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4613.namprd10.prod.outlook.com (2603:10b6:510:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Tue, 10 Jun
 2025 13:52:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 13:52:30 +0000
Message-ID: <6bc66030-adba-48c0-a992-82f7bbb153f3@oracle.com>
Date: Tue, 10 Jun 2025 09:52:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: detect mismatch of file handle and delegation
 stateid in OPEN op
To: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org
References: <1749562875-28701-1-git-send-email-dai.ngo@oracle.com>
 <f580a2f30274ca61f44d4b8d4b5e9779acd84791.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <f580a2f30274ca61f44d4b8d4b5e9779acd84791.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:610:74::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4613:EE_
X-MS-Office365-Filtering-Correlation-Id: 0348f044-0ca6-4d9b-99f1-08dda8260b3b
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z1ZOTEw5bVRNbkNmRFk5alp4L011QVRUbW1aZXp3c2xlYXBPRkVCa1doWWlK?=
 =?utf-8?B?N2l3WXBreVJQdHdLcE9BcGIrZGgrdVlpNzRlVHo1MklLc082YzYvWFo0UDVR?=
 =?utf-8?B?SXBCb2NyWC9XVkc3dVc5bmRPaGlTTkRZM29tUWtPK25NWFNmQmVraHpVeUNI?=
 =?utf-8?B?M3ZGVEtIQWp0M0U2YkVQM2IyR1Qzc3NrYTFBRnJtczgzZk5Ta21YUmx5M3p6?=
 =?utf-8?B?Zll2cEE3YjVIVlhLb05pWWdCdi9vam5yVEt3VTVXYjdtelhSMVpMTTBmdnQw?=
 =?utf-8?B?M3NzNmZ0SVZBN1dvczNMSFVRMmEwaDhLOWsxL2x1VTJyMDJ5QnFzQmJ6d0xp?=
 =?utf-8?B?K3REU05BY1AyaDl0K1BXSWt1cUJ2UkkrQ2szdTV0M0Yvd29acWg4QnFaSkM4?=
 =?utf-8?B?NVJvNUNSOTZlR2huSU5kTS94NVhuZ3V0YVFaRmFBYU1NcXduVTg3a1AwMm9i?=
 =?utf-8?B?clozODFPUGRjeFA2Y0NINHdOZWpKSjA4bGJ1Z05RYzYvV0hHYzFyRFJlSU1w?=
 =?utf-8?B?ZEN4OXg2Y3B2cmgzOE1sdGduSzVFS3F2ZUQ3cGVaTXlUd2d1OVNpMWtVbW9V?=
 =?utf-8?B?UHl5aFBaVCtOQkJHTG02N3BpZllEZ1l1aEMvOFhTOSswTXFsQ2JmTGFud2dP?=
 =?utf-8?B?Y0E2OHIvcm9DRmdpNFZLUGplQ3hSS0NHZWRPamJOTSt4MnZKOFFHUDV1Yzh0?=
 =?utf-8?B?V3I4YW1zbkNkbG0vQlpyYlNLNHhSWlgvSm82WjZqV1cxN0xYcVNEaVIwc1Br?=
 =?utf-8?B?UWhOYzNDMlZ2MmU2ZWxyeEdjRlcyRHh1TGdaZmpPbEF1amVSSWk2MjJhQXp2?=
 =?utf-8?B?SkIvT0V1SkNVWmlMQ3Rtb1lOVjg3UjFETXloNnVNSGMzTURBTkZNQk9lU2l0?=
 =?utf-8?B?SjlHc1p2WW50WGZYVml0SzVjM2cwNGNaa25YN2M2eVpRS0JBODRDRUZ4eDlL?=
 =?utf-8?B?SDM2Ym5pUFlrTmYrL2prWjU1Vlp4YWVOR0syME9kVDErczJrd05sTWNTSDRM?=
 =?utf-8?B?dmJqMFpSVTNNS01YcWMzMVVlYktpSGQ2RWVEZFZhYVhXbjJRYlBGQm9ZdXNB?=
 =?utf-8?B?YUpJSEs2dUQ3WENSMVRQcEM2RlhScnNOeUMyaGZwT29TRHovaDc5WDRaSHFJ?=
 =?utf-8?B?Z0EwaUdxa0ZPTVVKUkFiT3Bpa24zWG9ONGdScE8zL1gvVTh1WmtFZWVIVUR6?=
 =?utf-8?B?MGZyVDlUSTZ2cXR0NVJVeFI3MkxIckhzTUpFeDVxM2ZGRm9LVmFXaHJNUkx4?=
 =?utf-8?B?TmlWNmZnTEZMNmRwZFJTbmxrcVFLQ3lIelBMMyt5SGJPdGVvWTRvOVhMRUZ4?=
 =?utf-8?B?RXlIRzJxSGIxRERLdDdzUFJUTTFCZ21nR2d1L1JHZ2RBUFU5ZGZvTnFSQmNz?=
 =?utf-8?B?M3lKNHBLOVlIWEtwOXdHQzNuZzU1YkpNSElaaDdydXVNRWNTcGVQK25UY0NO?=
 =?utf-8?B?b0FxRnp2ZHlOWXZLT1F0UUFZbTVCYnJ2cmNjaThlY0ExTGNlemdBUGpzMkpW?=
 =?utf-8?B?bHc1NDdiZk9kVnZtdnpxT3dGQ2Jzd055VFh6Vm9XZk5xb3NtdGRxTGY0Yytr?=
 =?utf-8?B?cjl2MHJFSGIxM09RcjErSVp2OStUMUtRZkd1enJndWJZSnptakpKUm1rdnFz?=
 =?utf-8?B?Z0V5RDR0cVBnbkMvb1lBcXQyWEtlN3l1NFRvLzJ5V3ZoRk9pMmVXa0dmb21M?=
 =?utf-8?B?ZDF0bG1KNDBpTXNsS1kwVkFNVEFvbUFiU0NnclhzdDFEOWZxODBmVGxFa3NB?=
 =?utf-8?B?M0VQL3Zrb2wyelhPbWtDcXVXanRpSW5sRFJvWEFXdGRZVXdickZBY0Z3MWpO?=
 =?utf-8?B?WHg4b3RDQTk1d25RZkdJclhjbkxBaDZtVk1OMzhZTFhDK21MVEdia3dtVkY5?=
 =?utf-8?B?bENWOUt3VVAyMWp3ZGpHb2RMUVhyd1IyNVQva3ExVzhZeGpjMW13MTQ1WGtT?=
 =?utf-8?Q?lq7hR/Zt4YM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y1owMjZTOUQyeDRZSm96eVlOMVFxWHAzNTQxMW9kcmM1NnZuWjl0NEpNR2wx?=
 =?utf-8?B?dURPaytLOTlNRHhRMzZENExzeFkzK1ZDNlJsVzdJYXZVclczeTFPelQ0dXFK?=
 =?utf-8?B?OXJWRGhrYjNPVFVjcXh4UVZQczF1ZnBvMVg5K3QrVG8zcW8rZjhWOXJQRG05?=
 =?utf-8?B?bDhmMVFoeWZHSjdsMWl5SllXa3RMczdscllpZWhNRUw0SHhnNkJCNG9PS2Jn?=
 =?utf-8?B?ZUUrYTVjbGU2MExkVTZKQitXanpITUV3enhIWHEySFo2L2lBaGJ4dHpycUFw?=
 =?utf-8?B?T0JGTkdzdW1BaytIODdxb1JoeTJqeDl0azRCNUtxL2ZvODdFUmlkVHZaY0Ew?=
 =?utf-8?B?S3ZJYk53a3NTb2hEc1Z4RmVMNWlzaHR3SFZKTVdYVXNhTkRGcEV3dkg1cXhN?=
 =?utf-8?B?dlVwV3lSZzhVVUplM204QTZoaTJMREkyUDl2dUlXQVo4TEVSNjdpemozWVE1?=
 =?utf-8?B?SElYQ1RHK1N0ak9MVEtTdzJJY283d1NxNUF0dzJZZnBRaFA5N1hqVEQ1aVEw?=
 =?utf-8?B?bjFvNVR0TnFPY0w3bGNxT3ZMclRDYm52cGZRUHhMNk8xQUtNUE4rUUVja0dP?=
 =?utf-8?B?SVpzUXYybkxoOHlRbzVmZ0t5aWYrY2dGdHNua3JmcE9MN1JqbVpaRzJmSTlQ?=
 =?utf-8?B?eVVsOEk3YzdYUnI0U1E2WlhNTTNTUlNzUGt1b1c1cVNrNDFaUzhQOU02MzNt?=
 =?utf-8?B?QWhvR2NBdlhPUnVCUitVMU5uUFdQMk1VRVVySzVMd1FVV2xheDNvcEUzaWZJ?=
 =?utf-8?B?TVA3U29VTWpMUDNMeWNtYkhRbHVzQjJzbUhYb3h2bkh1QnVCUUFyeFVQYnho?=
 =?utf-8?B?cXkyUGdvenlVd290QjluamlCNVB6czROSVIzMTdjUU9HdDZONzhZZnFWZi9w?=
 =?utf-8?B?T2RGNVMwaXcwVXJCYThXK2ZrSzJ2eTE5ZjNFRFBqL0JpNm14WGptYUlOUXhh?=
 =?utf-8?B?ZjROcUV5TUp1cWdjRy9pNzRXMktOcGwwcHduWjkxUXhwRkpQWXNmYml4TDVo?=
 =?utf-8?B?TXUwSko5emgvcHJIdGlUa1pyL3B2eHNJYUMzdC8vRWRRYWZHVVRqR1NXUWRm?=
 =?utf-8?B?ekZKTWwxWjI4cklXUmNlODY1NlA1cDUxU3ZKcGxCRXdNMktiQytiUjB1TEdO?=
 =?utf-8?B?TmRWS09lVUlodFFieEFLQVdwYTBFWDZSWVNRa3d0RkJJRGNpcnlkM0l3OThK?=
 =?utf-8?B?UUE5STA0czVZazc2SmFWK1F2dWJIS203WlZRdDdhcTNsQkkyTGZPa0xYOHNK?=
 =?utf-8?B?NGphV0wxa3hiS01lWFBDUktHTE9BdllkUXV6bGRwdE5UOVVlaHV6N0RVVEYz?=
 =?utf-8?B?bm95UmNWS240MTJZdlZZdGl6Vk0xcEVMTkhkd2s4NjFaZld6NHArY3NvdTkz?=
 =?utf-8?B?V1ovdkhSamdnRHVTSVpzbGROMG11MlY2aHlMa09CRXp1SUtlRGJoRG5jWklU?=
 =?utf-8?B?dFJseUxUNFUyRktlYmNlcEg4VHlsUVdCWFlka1lHaU94eE5vOGRRZWhpTWs2?=
 =?utf-8?B?anlzL1grZFR3VUV3MFNLSGpObmNJTlhSVldxcjZoUGtpRG1nZGVscXJPdUtH?=
 =?utf-8?B?Wms0cm9qYS91eHdtM0lxYWRhSExzYmlLcnh3azNyT1pacXRxUmQrcmppMTBw?=
 =?utf-8?B?VlNVK1JuRGVGQTlQRTNmRVJFMkpNaHArSkk4cmF6VmoxQ2U1RnBEeDNVVk05?=
 =?utf-8?B?c3dHSWNESFdRcUR2anBFN0RTcGtBZkZvV2E1R3BFVFFLVlduTlFrcFhtNHlz?=
 =?utf-8?B?YStVVkdvb3c1aURUQzgvNlVKMjd2RW9TT0kxaFFQU1VaZEJ2cVFJakRmdFox?=
 =?utf-8?B?bjRpbERneUt5Z1gyQ3JnRnlCQ3NKajcwaGxmbCtwc0dnNjZoUUl1dkQvNGlX?=
 =?utf-8?B?T0dlYzB6K0Y2RzVZMElZYitSUjVXbFc2c2J0KzdnU2QzYmR2VWhORXQ2ay9R?=
 =?utf-8?B?NGZVZk1nSy9KUWVuRVBwblc1ekxxRG9MN3VYNDMxUExzcTNsbUxDYWtUMldY?=
 =?utf-8?B?WGdPcGRUNWp2cDMvZVZ6a1V2WXE3bHVHZmtkYm83eUNOQzJwdmpBd1l3VVk1?=
 =?utf-8?B?TTduTUgrcVUzSGt2SUVnR0MrbHZ4VDhrTlRmQ3RDT1lzM003bmJFMlhtYmg0?=
 =?utf-8?B?Wkpnck05Ly9KRzBiSUZvc2o2YjFmWEgrQ3cwV2V2cm5sT1cxUm1oakRLUGNE?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qfm6qjSbNGa+pIBetmioAn4hnvZZqRLL/0MiAhiQZiSdjnvVv5CH7dXs3ldun8OLIKUJKEL5YxoMdDZAkKKp6bBgrSOsR7neWdrr9oDKim9gj+l+NimYoguNSInrC7V6obZTI8fnnXiPvSmClRc70tfU5nXuGuxR2eOmhl+6gDqW7AXa4fkKOKO4pQUft8t0lANX6ZWU9dR5dbrzcchmnxEj8Wf++uX7Up6hN39rSEm5xzHoWBLE3L8gbbQFO93pSJrg/PGiVmZAUaUdLVUlYdqH8UXUzkPK65SVNf84e2uFpiJ+gnYuRIdAVubaGox17TU1vAe3+TZ6VMj6vLjI7CPY3Gw+ONrtDIHcXk3tiieLL4MmAl/CX+pbten0aPaZmuk9fhNTGXnFupDhvYd2YUuQJHkLP8SeAhAQUFy/9yvYP+gHQOiW6GimDv6qIOtmtVbH31bZe9udM6Xet97tFD8Ay5FocFs/q+TmrT3WLj+S88fX+HufUG4yZjmBWVoW1etxKx9uy5xT/d28nqv+0eA2ydlmcFLerM4ii/im5rygFQtcxV/mBhlMHZbUBQUxJPaA9B3XbFj9H+WkuzZ0na0ewvRnPXWYab1UK9DzBJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0348f044-0ca6-4d9b-99f1-08dda8260b3b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:52:30.8520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBVwl6jtF9nFVsRNYhBMDwbTngth0Y+ljeNHMs2BYrRd2i32RhRfPl0Re1OiMmrDqyq6QF2UqXOn64s1OWmvnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100109
X-Proofpoint-GUID: kTy6fmXF_h0gzyYj7pOx1jZ9hpDCxEeA
X-Authority-Analysis: v=2.4 cv=BffY0qt2 c=1 sm=1 tr=0 ts=684838a3 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=gk6bgfwW6Dnjl62PfXcA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: kTy6fmXF_h0gzyYj7pOx1jZ9hpDCxEeA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEwOSBTYWx0ZWRfXyNpYWEqYLGdX 5ZE8YpLM2Rg/R/xl7jbACs1W1Z3WxlOY82R4sPiBtVhtZwMscxe7FIpf89Aludy30VA68jdYMf3 cJ0YsWihNj67ZkRSuwKl3Mrq3BKI+LKu6GX53C2cJ1foCFFm/zif9xG3ZrxU21jRJdviadnDUUn
 8xhsSsqa5QjFDweEnrigtWUIcitBTJ9cZKVkcmg1fw6Hqm9KvZWEQrnmRdb42eUrHiZPWErNvo6 RC9mnvjRu7QFeDljOucDw2KRIIDZ11NyvdIc9RMIre2clKsjm/ZNDsJ3kjvFiCxjgWXGzKdD+1i DLv8LkLhC9QEvydHxuYg2m0LIkcUNIKQKsrjVcubuD8Ug4kj96djXySNlXGHltw4u4ZcewMh4zm
 ozGFiWzniJW2zL5Z+QQ1CIwn4EuY7c8occ32Aj9+P3dApPENlYkQTyA9l9yhvnU56e9QflKA

On 6/10/25 9:50 AM, Jeff Layton wrote:
> On Tue, 2025-06-10 at 06:41 -0700, Dai Ngo wrote:
>> When the client sends an OPEN with claim type CLAIM_DELEG_CUR_FH or
>> CLAIM_DELEGATION_CUR, the delegation stateid and the file handle
>> must belongs to the same file, otherwise return NFS4ERR_BAD_STATEID.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>  fs/nfsd/nfs4state.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 59a693f22452..be2ee641a22d 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -6318,6 +6318,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>  		status = nfs4_check_deleg(cl, open, &dp);
>>  		if (status)
>>  			goto out;
>> +		if (dp && nfsd4_is_deleg_cur(open) &&
>> +				(dp->dl_stid.sc_file != fp)) {
>> +			status = nfserr_bad_stateid;
>> +			goto out;
>> +		}
>>  		stp = nfsd4_find_and_lock_existing_open(fp, open);
>>  	} else {
>>  		open->op_file = NULL;
> 
> This seems like a good idea. I wonder if BAD_STATEID is the right error
> here. It is a valid stateid, after all, it just doesn't match the
> current_fh. Maybe this should be nfserr_inval ?

I agree, NFS4ERR_BAD_STATEID /might/ cause a loop, so that needs to be
tested. BAD_STATEID is mandated by the spec, so if we choose to return
a different status code here, it needs a comment explaining why.


> 
> In any case, whatever we decide:
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>


-- 
Chuck Lever

