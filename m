Return-Path: <linux-nfs+bounces-4316-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF3E9182EF
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 15:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A3C5B21D46
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 13:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F7C183066;
	Wed, 26 Jun 2024 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dm4b+fiu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="COZwNpjl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60099D27A
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409423; cv=fail; b=VfVasKv1UX2VP7W2ZghntZHq/oXe2KcjFskGwrmfeu3mV+p6ugWTTsrZ20nLbul2wijBPM/7XqiWYfYLPaCSKntNk5vLBFMZeuLQkTVGRPVVrY3y2VBYPhB9/GVkRZRAlZylDrzmJK7fXumvIPLunFmRjt0grtdemlyrh+8DVsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409423; c=relaxed/simple;
	bh=RC+OPSXcxwBihPHJsZa7B32n9eocv5m21ZlHWQ8tS74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tItKtP7KvqQX2wz2BiwpiAhIKD+NbhYj+F8uueEdV6aE2K5zLrd/x+xOeLCudFF07/K43NGJKLvKZhVlLmP4Qd/c7K2NSotLEZXBj5dhThMECwTncgPVgHUJGKcVElGj/mSEfD3+aJC0IRmxrbx20Kjgp6x7kQuAffTgwyaydBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dm4b+fiu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=COZwNpjl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q9sG1K017342;
	Wed, 26 Jun 2024 13:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=RC+OPSXcxwBihPHJsZa7B32n9eocv5m21ZlHWQ8tS
	74=; b=dm4b+fiu9ZXJnUZUWJwvHwGTBGRifNufAee0SuN2sKdBR80Vge12SZCDK
	Ai2mUgqs9qY8PTG718aRHgBh9B34KP2e26dXRVcv3hJEJY4wbLeG6qLjbwnzCFaE
	Vzi2FiLpZx4s008aeSeebII8pmIsv4t/kyDiF45HXJIuMMt7E8MCS91LcVJU7RoF
	LppdCrB4wLeufbHKIyg1aUg2RTVK2QluJhHjrstuaPMGmukAKIHC1ioZBrwP/Afs
	H9FgAIA9bhQ6etzJ59d9CJT+2cv/qBQFCDoCCrQ2p5WGuboZfwZtmEkSbAqbQlN4
	ejgYUX6HwTNPkQwJL9MJJW7Iq/V8A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7skaug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 13:43:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45QD97C2037043;
	Wed, 26 Jun 2024 13:43:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn29k064-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 13:43:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2np/loa86NX+8qHg5YOMvMmvgHW3VTl/77d7QaeIPYyFeiC9RgTBO0cMMT3HbZweUjJhyGSa+Lcu0x661swYsxuxqDT2oJUlBruaf+QOMhDbubv9VcJB/pXpY+WldFbyMUtQSBykWYFyQleTy1G7q2wHlp5eM5HSKQa4Q/KB5ZlMR7eMO7qu14b6KCxLzfFjKeLEcLrOhtNC9/iXnRI+WRuOFSHxjq9TzySROmTdU7EYTnjJIU0DkOqb5iJsP0viX+HNq0EMcOiXAF0ay4WCECBnEcvLH3SUxc/QG1EeWuq4XBD30obnDaxcBmzB0Q4zFOZk/4AvbIIvf6+NcN+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RC+OPSXcxwBihPHJsZa7B32n9eocv5m21ZlHWQ8tS74=;
 b=k5A5RpwJdwunhWL8ZU0whbAW2MRwoWX/Ggvstkzd5d+2I5HftZGNSRE947lP7DVJ3saqdNnRH5Syz0PEokIebWX8XW71BRz0pHzuF62HoaQ8U9VXfRcbey4F4FpHDwZctl0l1JwIqWw9F1Sy8iu/QQNuP0f1CY5CiVBRYsIEP56jVg5zR31Gv3cCQDJpml1ASA0qgl/vz6f/7wi4LYF+7iP0oMaJAWkJCkWGFF35cZSy5puzKPq2KJOytRLjJQ1prY4v/Az+nfRxvumC4xbogXzPpV+ZcZ4GpvjA5pPCsktKqLDtgtPDvfofDNzVH9DqtS+0DPBavpDShe+kQmCW9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RC+OPSXcxwBihPHJsZa7B32n9eocv5m21ZlHWQ8tS74=;
 b=COZwNpjlQT/o9u76CwKPmDNhZPL9P4/TY3hfKWE02KFw4etqEJs8qjf2F4Nec09CIReIvhbD4Tvt+E+IK63CcQRvYtHr7P4G1BDvFAM49i7RYScag5sn1u5jBM1GO18zMnl1nam/IG4RHZ7/OP3RsC3gDXJHZ9k6zeuQfF2Osio=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7315.namprd10.prod.outlook.com (2603:10b6:930:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Wed, 26 Jun
 2024 13:43:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 13:43:32 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] nfs/blocklayout: Fix premature PR key
 unregistration
Thread-Topic: [PATCH v3 1/3] nfs/blocklayout: Fix premature PR key
 unregistration
Thread-Index: AQHaxzqZl7WCPa7mKkSDTivMadY4PbHZgm+AgACMuYA=
Date: Wed, 26 Jun 2024 13:43:32 +0000
Message-ID: <BD93C352-CE34-4221-8534-49911C7848C8@oracle.com>
References: <20240625200204.276770-5-cel@kernel.org>
 <20240625200204.276770-6-cel@kernel.org> <20240626051941.GB21996@lst.de>
In-Reply-To: <20240626051941.GB21996@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7315:EE_
x-ms-office365-filtering-correlation-id: 9a5a7391-87ce-444d-0f39-08dc95e5f805
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|1800799022|38070700016;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dVZzZExFa04vRjAzYkFtVDNuYzB0V013dmhOZjB2MzR4VVR0M0xic0xVTzlo?=
 =?utf-8?B?Ui9rNjR0ZjJVc2hjSmFsM01EMmJrSUYycmYwYm5MNHVyb3g4VGptQmFVeTRH?=
 =?utf-8?B?ZithSVk2YUZvZk5ERkY1eXg1a05XQm5abnFGMlpSTEhsYUhBd2RET2tGeFdG?=
 =?utf-8?B?NHdqOCttVmJmWFI5UjFXRGhOeHpjbXZtUEFwS3JLaXd3bHNNMFpFL2JsNlhp?=
 =?utf-8?B?WExsSThMQytRUFZ6SG5UeGdKaFZlUThzekxTb1JVT3RtNFJZRWR6WjZrbGpM?=
 =?utf-8?B?eFRmWXRjRklHc0hzL29kQzlkaWIvWVdXKzBDT3I2T05SM3ZIdHZlWHliU3Zy?=
 =?utf-8?B?QXZYTVErYXJsU2dlMmQ4UGFpU3RPTGQ1aUVpaUdLN2FJQWpDU0xERFE4RDdi?=
 =?utf-8?B?QTBZRXEvZVY0QjQ2SkpueFV0OEx1Tyt0Mm4vSVk0aHBMaitNcXVTcklPbW9O?=
 =?utf-8?B?Skp6QnhJdzVEbFVITkV4Sm5hRVdwaHg3MWR2R2lRSVkwVkVrZnN6ZFdyMUFt?=
 =?utf-8?B?cy9OZHkxR25Td3ZQWkZjK0dIdDZxMWgzVzEvOUdVMTh0N0RFSkhFWU5HdFJV?=
 =?utf-8?B?RTNKZ0VwdzJYb2ZIMEpYZDhiZkdwcFJiNnNUU3p4VG1IbzdPcGsxNXdSbHZ5?=
 =?utf-8?B?Q1VaZHNZU2VPMm1YL3N3UElrZXZFV0Z3ZmdKYklxbis5aTBZbCtkeGlPQWhr?=
 =?utf-8?B?cWhhanhON1I1T2VSTXgvaXhnUHFkQVVrOEVJTUR2Sko0NlE3QURrd3BYcWNZ?=
 =?utf-8?B?N01PSEVaTDBqVU9GYWJIcXFHcEVSWW8yNUtqMDRiZ1MycnVwbGdYUEZOT2pq?=
 =?utf-8?B?RTlIOElkQW9Qby9Kd0xjbEE2cW9wbXVnZGw4cmY5N1dWSEozbWZ3b3lsUW45?=
 =?utf-8?B?UmxZeUJUYmhGWFNNeDc5T2dYaG5mU0QvOEh3TmFLTDBzc0RzeUxUeUM1djNt?=
 =?utf-8?B?UncyVHFNTW9vb2hEVmJLUFNZcmFHWVVMRG5pRVRlci9seEdIazFVeEJBa281?=
 =?utf-8?B?Q3EyekZoMjZlRmxFRG9PUk9hc3gydkIwTVFEV3NoeHkxSjBER2l4WnBUMnZF?=
 =?utf-8?B?ZjZ2bTNOTXRBOGxvcG10RjR5YlRQaGMwZ2lTVlQzMHdxY1JMNGN2V0NCT2hu?=
 =?utf-8?B?U0tlUWd6VUZaVWdJVkFsMkhtdTR6STU0ZW5GRVdpRXlGR1MxRHBJaURKMXZQ?=
 =?utf-8?B?YzhGdmMwbkw2Yjk3cit2Z29QTVdYTGhMclN2aGt2SWdIRWtvdnhBdWk0eEc4?=
 =?utf-8?B?RFNrUS9icmVuQVJVZVZ1NU0vMXRqa0ZXUU9ua3FUa0QyWm9YZmJ1eFBmd2Z4?=
 =?utf-8?B?YkRrY1pDTHllZnVTbU1oYWlyaGFVTTBZVTlHZWhKaUJSSStqV3pBTWxHOXRO?=
 =?utf-8?B?L3E4QkRiVnZ0Qm80bWdJRmpIMTRneHgxRWFYelZzODdmc29HeU5uNGhnU2xM?=
 =?utf-8?B?bjRSSE4xb253bkJWNzJNVmlpU2ZmR3JFOCtjaTlsbGNHQmxIbFlYOWJVaGZQ?=
 =?utf-8?B?bGt0cjVxZUQvdGxBVnNocVo4UnFPbXNYZFVONzYwSXY4alJTWG1iTzdRaU82?=
 =?utf-8?B?eHBJN0poTWFlUXRaWWZOazNuNldOSi9ndWc0QW1vN2NuK1VISno1SW1TQVRz?=
 =?utf-8?B?ajdjOUE2WkdqVzlDTVlPOHBhd3dDaTAvblBEaTJsSmlFZlNxcjhQKzRucEsv?=
 =?utf-8?B?VUNHajZma1piMTNSdExlUno3bXJvUTZHRjErSW1QK0JmZ0V4WitQc0tIaEpj?=
 =?utf-8?B?QTRsaURkS21ic0NHNDRJcWZTRlRGdWJ2OFFGVFQ5djZ6VnJIVWYzTFJLL08v?=
 =?utf-8?Q?c/kD7EoK7R8Y2463XNPutwo/7YDPrtFvvviEU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dUJLMWNFbS84Q0V2NVZUeXp1cFc4VFZYM2RJSm02cURoR2FOZzZqYWREdGpI?=
 =?utf-8?B?L0o2WjdkR1hPRHU1d0RMY1BuYmJheW5EaFQzZDJTdDkwYjAxZ3pnQ1pxd20w?=
 =?utf-8?B?K25ZUGFEZWI4SGJpOE5YdXJtdndDNmZ1cWZmdEs5a3dEN2QrTmFGa2lRUDdE?=
 =?utf-8?B?ZVQ2S0xiZno5M3NIUXYxRUNZWkx6WUtFazEyN3Z3ak1EZWlsMkc0SXRpR1BG?=
 =?utf-8?B?R2lmQ3BVZy9CeGtXQkczd28wUjVmVVF5clcxaFlNTE9sWUxvVWVXY2J1VmV1?=
 =?utf-8?B?SmFyeVZ3V24zZi9OQlVNL29RbkNMYnhLTVRRM3FBL2FFQzlrNXFRZHdQVGRz?=
 =?utf-8?B?cDRtcm9DOGVRTDQ2KzBycU1mTGRzSk9ia3IvZUZHd0xybCs0UDIwcytQaU1m?=
 =?utf-8?B?MzRRcjFvdG9BRDJZbkI5V0EwczhKTytMTW9XQVdjdnBBdjVKeC9ML1FPcHFm?=
 =?utf-8?B?LzRnKzZuNnFGOWk2L0tYemdVUGRGa2FGV0o1VWxEdXREdTVSVTlVN1NsYUtq?=
 =?utf-8?B?ZmVFamFrRklJR1JMbjZBMENVVzl6cDJpSnk4d01pTHRFNkFXYWFKUGRFeG94?=
 =?utf-8?B?M3NyV1lDUmdlR3I0MkdWTm5pYnNVT0ZST1J0VFRHc0tuMWF5NXFJdG5GdWNl?=
 =?utf-8?B?b0xQOXVZcTdjT3pLVmJlS1FFTHFJS1ZDWGJRZEFtYTBXRFdxV2xzWGVkUmJh?=
 =?utf-8?B?cURHZG50emEvMnJUc0N1YTRpS09RRWJRa1JEWjNFR3FCMXV5RGV6STlOQk1C?=
 =?utf-8?B?ZXM4aXRFN0tkWWN0Vm5takRZRkoxOEVmNFRRdmYrUzRteFZEMWlOSFNaTEk1?=
 =?utf-8?B?SXNpL1FJY0tLSElJclA4RkVKTzc5anp1T1d5c04rbEtDSEU2Y2w1aU0wRnFT?=
 =?utf-8?B?anR3dkYzdkJFeiszY1FmL2U1cDZxRnlSaTU2WnlOVE5RMEdpWkw5dlE0V2Fs?=
 =?utf-8?B?WGF5VWpPbDFBRG91NkJCS2x4czVzeDdjeG5XeGdIdDcwdzJlRC9pdWxieU1Z?=
 =?utf-8?B?d0NkRnZoTC9CZENYUTdHMUxsSDh4T0t2SkQzamhBVTFJaDc3d3lRMFoyaUlF?=
 =?utf-8?B?eGEyWVduM3FoWFh6QlNNb1MrKzVkdDc1ZDFaaWluNWNBYWFjeHRhNkxCRGdv?=
 =?utf-8?B?UTFQa2ZzSWlVc2pFZ0szOE8ycXFXSzZENkVxV21HMnVMLy9TMnRES21ITENt?=
 =?utf-8?B?aTB1aGtwKzUrSkRYUTFCOGk1WGpXMWxFc1JCWGlYbGo5SGEyZXZ5TW9lUm4r?=
 =?utf-8?B?VlkzMk1KOHZLRUlISDlFZEViYjYyMi8vc08yZjRXUFNKdnBKV3Q5b2tJY2NQ?=
 =?utf-8?B?Z0djbGtpT0tOOFh5eUxFQWZ5UnlzYWY5dTBoMXlOdjhkZ3NMN255VXgrMndl?=
 =?utf-8?B?THpSdncvMXZwbmpzOHkyeTdNL09ib01ES2JVbVkzQUlHNDY1dy90ZlB3cHNC?=
 =?utf-8?B?MUM1U3dCb3A0YjVwbXNlN05SOXVnYkt6Z0psSTBEMkxlQk1yb1g1Y3lEa05h?=
 =?utf-8?B?WXVpSG9ZWHVVdDFGdmxHbEtHdFZKNjhWbmUrck5QMmQrdytzVnpLR2paV1Bl?=
 =?utf-8?B?SkpMdHBaZC92cElsVXh5cXBmRUZGU3Z1WlhhNWQrOGR3QkFqcVVETFc1Vk95?=
 =?utf-8?B?QURCakVMSWxLM3Jxb2ZUT0k0SVlDaFNxZ2V1dU5KNkpROVR1TXB4VGkzWXho?=
 =?utf-8?B?cUIzbGVDSkx3N1B5UTlrY0NGVUJwWXcwQ291WXZ3VmhGU1RteHVUWTVYQ0Fk?=
 =?utf-8?B?ZnFFcmpBelV1N0VwOUhFM2IzQUg4K25YOE1Jd3k4S0xONENyenFxc003SU1M?=
 =?utf-8?B?Yjk2c2FVQlZkN0dFR2hQMzJCamZJc1RISWxBemhCWmNDRUs2MjVDaXZLaTZy?=
 =?utf-8?B?MmU0TUFqOE5qWHU1bml0UCtNalBEOEpLdkhHak1ra0QwR1hMTGpqSURCWjhq?=
 =?utf-8?B?NENtVzBvNlBET1pxSUtzNUZIekJGMnpSb0preXcybU1kTWNxTGxKQ01mWmdt?=
 =?utf-8?B?N2drQUJQRUp4NW5TYkxsWG9PUVBYeTFkOWQyMm9iZVVRbFhQUTVjU0NkUjVm?=
 =?utf-8?B?dVAxT01xTXo3eVdGcWFmZTNMcTBFV1dGcTFFejJjeDhzb0xWQ3NEOVhNVXNC?=
 =?utf-8?B?dFd6TDFOakIraER6V3FFdkxYekdUZDJUU3N3MTNveUc1N0NHN2pOay85QWY5?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C530158228D4AB4EBDC1E37334493CC6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rT7sV0eNEW7Qsz2jY/xc4PMw1kva38msoXI1Pg1GrSXFloggwhO/W83dcO3g6WzqRsjsjtt//mt49Z5SKN3nlBfmIGQHvH0SK5v7yqegDpd3fp8SlOSzREdZ/JZ2ewmvsfSW0atCPDiH+7ZxF+ALtm2UU3AyGP7qhNYYI7UnPXPAovxQdxOBPoWIPyS0YBjiDk5eC7Ub8AhAhGQZdX/HDiLzrsoWjpRM0Euhw3NM4iK6UJ8/Sy+ucFDHGOnRFVF+khzeaT+wGPPYiahzKtgWr7yNvF369Yf79v/O3MF6AJUSzAuhzjso5G502irUUq+BZFiBxfo1R9P4Eu4mKVdVuqwnwrYsuxwrpk9ouFighflclhfmP/BJp5OsdXGTGXtxWWcwVbFKp64xBz9fN+HpwZD2xixvjCjVhi9mZP7gy6asGpIGaPFFAIXB+2xqcvw/ODhqiZX4AI8EFFEtQ45kZRh4k0X9ykbRj+gnbZ6OwZ6+tpONOCt32d7rJqkP2GjMpRXMoZtTXgpGbogVBel1JO9PNSauh0jOXjfhahInE5TITKSwpqk6I55ZZpMmLcOOvOntRaNznUOOO1wM6C/8emfLrq76ZzVPH7kzkXIjPaM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5a7391-87ce-444d-0f39-08dc95e5f805
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 13:43:32.0695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5drVXIN3dN064DpBtGmmPzotOU8VSwWBo2Cp5fd3UQKi5QvAxxslJWV0JV9/PR7PbYdtwujA2EjqGDmOSrP4ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=850 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260102
X-Proofpoint-GUID: qFcLcOQ_EyeGyaqVeodEny3WbaVemb4t
X-Proofpoint-ORIG-GUID: qFcLcOQ_EyeGyaqVeodEny3WbaVemb4t

DQoNCj4gT24gSnVuIDI2LCAyMDI0LCBhdCAxOjE54oCvQU0sIENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAbHN0LmRlPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgSnVuIDI1LCAyMDI0IGF0IDA0OjAyOjA2
UE0gLTA0MDAsIGNlbEBrZXJuZWwub3JnIHdyb3RlOg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4+IFNpZ25lZC1vZmYtYnk6IENodWNrIExl
dmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiANCj4gVGhlIGZpcnN0IHNpZ25vZmYgYWx3
YXlzIG5lZWRzIHRoZSBiZSB0aGUgYXV0aG9yLCBpLmUuIHlvdS4NCg0KQWguIEknbSB1c2VkIHRv
IHB1dHRpbmcgbXkgU29CIGxhc3QgYmVjYXVzZSBJJ2xsIGJlIHRoZSBjb21taXR0ZXIsDQpidXQg
aW4gdGhpcyBjYXNlLCB0aGUgY29tbWl0dGVyIHdpbGwgYmUgQW5uYSBvciBUcm9uZC4NCg0KDQo+
IEkgZG9uJ3QgdGhpbmsgeW91IHJlYWxseSBuZWVkIHRvIGNyZWRpdCBtZSBmb3IgdGhpcyBhdCBh
bGwgYW55d2F5Lg0KDQpGYWlyIGVub3VnaC4NCg0KDQo+IFRoZSBjaGFuZ2UgaXRzZWxmIGxvb2tz
IGdvb2Q6DQo+IA0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+
DQoNClRoYW5rcyENCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

