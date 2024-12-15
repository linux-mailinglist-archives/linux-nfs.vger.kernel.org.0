Return-Path: <linux-nfs+bounces-8565-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024E39F2570
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Dec 2024 19:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2FCB18817A8
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Dec 2024 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D491B4159;
	Sun, 15 Dec 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="imS8WFqz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PJDRocwX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C426AD0;
	Sun, 15 Dec 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734288801; cv=fail; b=llZybRZse8hdYY0TYs/wSuujZ/JSi5rAge4z6+AFMBmdpRXC3evmzxnBxoAO9HrxqTpS9vAyyKSI8RgDbkgB8UQKTnyZQOTW7N6iixi0WrGptzKmuXcmILfgu4Q1T7CDJc7DGjV6p87p0sdOXGvZBhOualr5sFj4RnUUhrEXUEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734288801; c=relaxed/simple;
	bh=BTkAO1lZiBiWZuipfY6N+fV2BeLAyCvDGkBIzKQRDqM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FF+j+Kp6c3CBHsMjy6oQsZvtNhe75/E1SJ+wT6gnHJGHe5cE99WqwZhTqAe+W39qAXmvKMwSIRjKwPV1tffphNCdIcdWLnBNP/OhybBYOcj1Xm1YPE1utbBlvkc1UpOXE1iqQ0hZgPd5M6sv3E8Phdq6kxGECk1GI5xISLP4oOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=imS8WFqz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PJDRocwX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BFHY4fY004240;
	Sun, 15 Dec 2024 18:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=okjX/BMVvRsDNGnL61cnVgif6lJAMIE/mfrmNngUgwA=; b=
	imS8WFqzyxRELUt7lKMr0DBXBlCCu5Jb3S/MZfH3BoxUX2FQiwfpSnTWjdkKcuW6
	mIk7yxWCqjrZPaYehKOZuXsaWNL9t6HhL/fVTaKQpCFDBpO6tpfmqUZHoyG5Gdhq
	CwU6wE3MzV9S5SQkIjZODo/J2tR2+KZbNqTcKgjyLeT2zPHvfCIQrpIL0IfTHgSV
	LBhm49V+CZvVWfB+41x9DjBBb2HSpxcHTuAkk3Gnd6jVKjUWnY9hnBC6fjplF5kX
	nXe9W1TZad6H3IWU7oz8ojmGjVD+ZxtgDLaXE//IikEuVi9fid0avBCI7tfAXpyP
	ZRITMKI4BciYFVnYL0TT4Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0m01ukd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Dec 2024 18:53:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BFHDp7k006371;
	Sun, 15 Dec 2024 18:53:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f79tmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Dec 2024 18:53:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFCRYrYr2DId3plDXoPfB2hASQLnQ7XQgha7jIYKsht5CEzMCfOf2OCWBgzs50HrXa2JxRM1OUXilerbazZRTp1CJCVFG68fqrMz9mn0nbT3HyL6FjVURa5Ay6TXLftQEC8XtLMDrfo9xfEsUp8UI+ZXu3WNZ9S0BJ/4H6X5784Ch5/gidbSQOVb/w9fdyWtxF65HhZ/qzgeQZttsexZN+7oJA+uJIdrPk6N+teWAuW9fqb16dHIhICWJBwO7beO2xAUGAwReY2DH2/WhxlGH6ka95UFlv55TPpxbs89nPorZEYjQhtmiRQceHdS71rbN9TIJXkC31e1J3Oq82GHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okjX/BMVvRsDNGnL61cnVgif6lJAMIE/mfrmNngUgwA=;
 b=D8OkY0U1C/V8auLA/VOQWV8pX6GZQPcokM4QVnc6UyL1H30ltipUyhjn+Obwpw5e1oUVSq45Bu+xbh7wx/JF+ziVwlaoR1m9zlFiR3UYMkeEmepmWY77mLvmiHtbV7qXbRyLSNAcjD+9rOavNSLL1yNyHhXSn8P0CH3+vRZmrLemMoBrZhezxbOijyH2A2tVtFYfsj47uHUx1V2AAyTZ380kCN20HllE+bIbHxCBWGYX2FRqieo5cr3iXeb2Kp2A62MBPW2fGdqUV8lFC8YvcBBZeKVgy3Sxsjdx1Dcg/j4cjhGHfYCZgzqwDhaq96yFzOY1BBy+sRMlYvux+pXajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okjX/BMVvRsDNGnL61cnVgif6lJAMIE/mfrmNngUgwA=;
 b=PJDRocwX0t30Lgfkwo6FQDQ6QRduP4w6Myr9dq4+KBf/y4Sjs5zqmTW3z7ODWECriXUwsFZ2MHy/09k4D43YhkJXDaQMgJZlZzeDCbpt7mlLLAd40XTSy8+3xdyxc0oymjmqhpV7Toz0Mq04YbWRhGQ+Yn9U0OkgiTxS45b4pKU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4189.namprd10.prod.outlook.com (2603:10b6:208:1de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Sun, 15 Dec
 2024 18:52:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8251.008; Sun, 15 Dec 2024
 18:52:58 +0000
Message-ID: <7cbff5aa-71da-448a-bd6c-3a37d9bf10db@oracle.com>
Date: Sun, 15 Dec 2024 13:52:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] nfsd: handle delegated timestamps in SETATTR
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20241209-delstid-v5-0-42308228f692@kernel.org>
 <20241209-delstid-v5-9-42308228f692@kernel.org>
 <2a3c0a1f-0213-4915-a4c0-a2ba31ae1bbc@oracle.com>
 <f697868bfa7f219d51ba8251db32b22ad942ecd7.camel@kernel.org>
 <c4835f2b-0edd-49a2-9f61-5bd7090382dc@oracle.com>
 <f2284ade0fcda383c29a4be58a3d0eb012bf5ec5.camel@kernel.org>
 <b45404d4-cbf1-4f42-ab74-5868ef7fe895@oracle.com>
 <09a8f219-c639-4fef-b3e5-44e030a76c24@oracle.com>
Content-Language: en-US
In-Reply-To: <09a8f219-c639-4fef-b3e5-44e030a76c24@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:610:52::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e4bbf2-87d6-4c80-e112-08dd1d39b18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3NHdnJGTjZraEpWWDUxYXhKMkJoVzNLSmZYRWFpWERDblh0Q2czMHJmcUVC?=
 =?utf-8?B?MVZEMFAwNmY5TWsyNldvVk1CRmc5NTBaVkRFd1VOL1d5dUlXUUhzRlBiK2hL?=
 =?utf-8?B?YkhMbUxmNVdiYW5CT29mMjVtSjVVYVJFeTVwT1dROGxGcnF4bUxwSWZISC9i?=
 =?utf-8?B?UlN1aTNlR2VuZjgrYkNMSWRpTWFIVGM2RmE3ckR5a0ViVXQ4eDJyQkhEdytI?=
 =?utf-8?B?ZW92TzhIUnpaS3NxVi9wWUVRTWt5MDdhc3Z4N0dQdE1NS2JJNTFaam9XRjBG?=
 =?utf-8?B?bXI0U3FuK3RGU1RFcjZ0QmlPSCtmSTZiUFZlTXhDRHFXZDF4RjFEa2dWWlAx?=
 =?utf-8?B?THhvYVF4anBlU0czYS8vZG9vMi8zSW54OTZ5eWwzOTRaYTdUbVBWNmU0cG0v?=
 =?utf-8?B?TkRqTzNGSXcvU3VPanQ0bisyUEl0cjNxRHlDZ0dRU3krU2pOSkhMQ3ZlVFhH?=
 =?utf-8?B?c2hWTGRhUXFRNWpaZ0JMVXdFYk1Pd2xCQzc3NjBZallkQURnMkRzaUJ3T1Ew?=
 =?utf-8?B?eHQ2QUxzWWVMQW1DcVpsMlVKZWIwTjJtN29XUjEyV0pnTCt1d0pBa0R1TXow?=
 =?utf-8?B?VEdMOGpibTE1QzFieXdNZmVLVVpPWGtrUnFVRnBvZnZxN0RkaU9JY0ZzbytX?=
 =?utf-8?B?TE10MERNTTNiY29BU2NVVEhNSGxUTkp4VlptbUhvektHLytaYVdZVHhqS0dT?=
 =?utf-8?B?cG5RZjFscjZ6SzFhSm15V29Gb0liRmJPclZwTGQ2eU1tT3RsV0hUckY5VjFQ?=
 =?utf-8?B?MWZEeGxHa3d5L1JzWXo5a2Q4TDhHUkJMUmR1ZTVHME5FNGNsekhCSHRaTVp5?=
 =?utf-8?B?OGorMjAvd3VGMEh4dVZ0Z2JpSzlld1RWZUhISnFqUWJuVVpqbXl5UEJ2Nmww?=
 =?utf-8?B?R0d6SFdvMXc3VUFJb1l5SVJtQ2FJeGw0WEREQzZZbWhmZVZZOGVvT085WFN3?=
 =?utf-8?B?UnFDSUwxcWpTT1poUW4zNlFxdEpzb3BDVkJmQ0NraTkvV0FjSjlzb0J0VklL?=
 =?utf-8?B?clNNcmRmTm9PMU1XcXR6bHFpOU03QnNtODduVDBtaERXRVRNbkZiQWUzejF1?=
 =?utf-8?B?SUMyYkg4bFlWTVFSVXNUUVp1VS8vWXZlQVh4dklWWStERHBBNHlua0sxVTFK?=
 =?utf-8?B?ajFSK3lrRjJPbTRwZTAxTmpRM0JYM3Bnc01NVTFhZEdJQWlWWHJpWjRVcyt2?=
 =?utf-8?B?b1M4dFk5bWpscEpHaXJBeDM3V3Z0ZnRySkxJZDBHSnBwSzBybFBJd3dlbWor?=
 =?utf-8?B?OXJJOE5reHJUek1hNSszR2RXMW1UTlZIREFKVjJubmgyVkRMOEE1Z0wzTDlI?=
 =?utf-8?B?K0hmdENXaFFreTdpWkU5UkZMOU9iSXdDaWQ5L1dCcEJaS0VmWTdTZW41N281?=
 =?utf-8?B?L1hXOHdqM0pSd3JLbzZxOFl4Znl3NStMNjBaSkpJbEtnTnpoTGRsdU1ROUxM?=
 =?utf-8?B?NzRUcVhSYktZb3ZwVFBsK25NdmNxSFZIYTdnT0w5UHNCclNCQk9zTEl5SU4x?=
 =?utf-8?B?aS9XMTdlNEtNWmdsNGYvV3d5WHhETmxiSk5tUGZVL0UxS1NMM0gzM3V1YXRX?=
 =?utf-8?B?eExjTHhocFdBZS9qQVI4bDRBZk91U3JURDl2dEZoY0tLNXRac002SkNNOUJC?=
 =?utf-8?B?L2JuR0ZSc2tMS0VTN09KV2k1SU1WTUFEK0dUZ0F5SzF3dVhRUys5aHZQQW1Q?=
 =?utf-8?B?ZHFTU0xKUFVnRXFGUDlXZi9qUnpVSFFlUU9MNm5nVW9Ba0dnUG83SXdLRS9r?=
 =?utf-8?B?U01EcVBSN3o5cWRRSWZVZVZibWJHS3EyR3NGZ1loeDlmNzFscHJUZ0ZXV24r?=
 =?utf-8?Q?OATtyLNeb2754vFlV8yyoMBGD231tM8L3k2AQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnd0eERvY29abWxpNWljV1RER0xWWEhyWHhlNWIzU1IxbjNPeUZCWlpvN0Zu?=
 =?utf-8?B?VDFWMGVrWnJrQnVHRUdBOXNFNVVSZGFYUDNia3A1U2JMdVgwdFF2RktRU0VO?=
 =?utf-8?B?em9FZDF4eTJsK0tUU3pmSzFRMlhUSVdEQXVNS2NTUjZqb1VacG5wMFA4a2Q0?=
 =?utf-8?B?VHRlaEhTemdJclNCcFRCVzZLZ2o2WHFvSlk4MnUrcHlkTzF6aC93QkZOUDNM?=
 =?utf-8?B?dEYwTUVMNmUzTGhrcnIyT3NobUpJWlJ4NzZtd0ZkZU16RHNLMTRHYWpHQ0Z5?=
 =?utf-8?B?OERrTEZhRVFzWm8zQk42VWdaeWY5aDVjZWxaclZGT1hrN3I2ZlNKeFN4eTlY?=
 =?utf-8?B?UzZxbUR1bVg3M09xVHJxbWtDeGc3eUZhZzhudUllU2x4RDJKaUZyeTF5bnJM?=
 =?utf-8?B?eXJmcXFzTnFiTTZwbmo1K1FsQlVpN1VjcUNrNi9qa05oMDJOS05GU2NMQmNR?=
 =?utf-8?B?UHNvR1dsYkhLcWVLaG1FZGhQamtyNG8yZmNFTmZadDJRYnVkWXpYUTh4RGNB?=
 =?utf-8?B?Sm12RVJ2aHRkYkU2cDRJWmlBSE1wUUVsVVd6ZVNwdi8wMytYVjVJVFJjT0pa?=
 =?utf-8?B?a1FNZ015Zk8yck5DWGVrVi9PQ2gyaEJOQnJ5bnRtZ09oL1hWRXl3blhWUTE0?=
 =?utf-8?B?RndZUWNKVy9QVnhCT3RqNktxc3BMc014YkVudUhCcEM3cnNFWWtMbFdkYm02?=
 =?utf-8?B?Z0pISndoak9WaGZFeWE0dU1JZm5IWUw2R1NiUUpFZW5aYUV1MWZ1RHJaL05L?=
 =?utf-8?B?bWRhQUw1dlV1OFBBT1EzNDhGVS9sNVVSVG0xU1ErVkpaa2lUYVpxSVorVnEv?=
 =?utf-8?B?SkViMDVrL0ZxRXU4Zjl1WjU0VXZvd3lRclhGMUYxTGN6U3RMQldCZWRSRVZi?=
 =?utf-8?B?N0dZRlBlMktINXdNWUdiT0U0OU1jd3JVckJ1Wk0wOWFXMVZjemw2eHBseHM4?=
 =?utf-8?B?endpc3g3K1VyWWZIdkN0VHpKWlNTVUkxSUJSNkFYODJnL2x2M2FOUHd6K01i?=
 =?utf-8?B?UTc0OVk5L1g3ZUkxL1VXSjFSSHpyNlhiMFBKRTM5cURDUmtLMyt1dEViYnFn?=
 =?utf-8?B?TG1manJaK3M1WVhoV0puODZ2VW1zVVhveDJTaXNMaFk3YXczNEI0ZlFzNlp3?=
 =?utf-8?B?Q2JuZitVMFd1QStTRDVtQnhsMmNrNW93NEQrMTl5TTUwQUwxZm9ldEl5emxm?=
 =?utf-8?B?U3V3SjB5NmVoRnYyKzR6ZlpRaDcvdkVTSlJiZ0tsN0l0VStleS9mSG8zOW1o?=
 =?utf-8?B?OCtyY3RITUg4b0JqQVhUNGhFWXVsZmxsajRCT0pLYUlIQ0hmSjg4WnIySHVu?=
 =?utf-8?B?d2VuM2N1V1ZGTzZUUjFoUytCbk0ySFlIc2V2Z0cyN1FGOENoaFNrU0VaWGFu?=
 =?utf-8?B?WEdLbVZodndEdmpIU2pad24zT3llclE1dWJzR044S2pQQWVZU1F3U3gvMGJq?=
 =?utf-8?B?KzJPNG9uK2xDNFdsV2ZWWEZYOHU4NTFGREY5RVRXQmxTVkw0VlRqeXpXQUdp?=
 =?utf-8?B?Vml2cXRpbXBncTFWb3F5ZThMLzR1eUtGRCt2ei9RUndDaThVbjVDdEhtNDlz?=
 =?utf-8?B?dlJtbkRzeHc0alpjSTlnYnhlMDl4Z3F2azZFajQzbkdQN0JSanE3L1h5OXk2?=
 =?utf-8?B?Kyt2cm1WaXNJWlE4T0I1Rzlkb002M3IrTUlhR0lIVXpSd09aN0pwYVdkRWVI?=
 =?utf-8?B?ZE9QWE5vdWRHcENrYS9OU2k1aS93bW4xRy9sVEtzd0hWd3FYWlY0a0UxM2Fj?=
 =?utf-8?B?MlNHa2VpQkVPU2hZWkhZM1p0QkR0bFVmTjZLVVZsSEcxWWNyVG9LUkNONTRJ?=
 =?utf-8?B?cmg0Q245TTF4Tk1oNW5hZWQycUZ0MzZSOEFwWjdtUzdRc2dweVIxN2xaM1hH?=
 =?utf-8?B?enUwNHJNNVBpYXQxUVNOK2tiOEczNVNWaUY2M0FJcm1yWTFuWWYrZCtGTTg1?=
 =?utf-8?B?QzBsMk1lQUgvbGJEMFY5Tm10bUxXaWwybFI0UlZNZDU3eGJqQVh6dysyUVYz?=
 =?utf-8?B?TTFnZlNBSmFhdHpxRm54T0RRSGxvbEZSaUFCVHE0QllycTJ3b2wwekJMUzBZ?=
 =?utf-8?B?Vmp5c0h0cHhkeEtKK0NCRFlwcFNHak5Cd2VCTVVaOVRQSnZiTWtoNVRwcFRX?=
 =?utf-8?Q?Neg4O3oL+lSMY6lhTRt+ulZKf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l7qDNPti6D4wt+9+sqUqJmQbanFg3+uJCaoxVZv9C4Qsh24dD68zPth4birH31h3k5DEwP8F7Z1mMkIYBW/N4Kdzkb2eFHCKq/XQ/klJ3AnoI7JVmqlUlpVzwK487Ir1bE4GgHB1HgGZQwgnmvq7gwsMSYEhvvwQ6Bmk01hLZyX2LtNMT6Xc8/9vbOWuwWqjkC1FdzUoDoKrq5eL3A/a1j4gmS7vnlBYQ6lsfhp1/ROwBwHwzdYZ6g7x5slEoiLqHTHGhNPg6mvV3DEbvEyV9KuZvc9N+PpAzzlap7lpwL3WPmbYQHB6KywlgBcypVR+PT/zxFI3tG/2c5EfpLuaCH8gnRJsk3QzfVV0itHnuhK8WJzJrW9jCHNaGwQcwcFGFINQ79rFmFECxo1PFkNz00tedx2DZ1a7MIf6k/ytcBbN7KAiYdCRidgN+XDdrgC0qCeFhnrZCOd8AHftAheLtB6Ak6OJp6b+E+XhMAVidXA4HoPkvjWqPQ1SrO4Ta95onw4FPd6oZzFddtM3MkZZMzpA9jB7uR8gps0IEM8SL8qWqzbkenvv1EGeX9vyLhcS431IXMKzhVaTK+ChCoiNTRs3kM8fgfhvj7E1WcmSN3o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e4bbf2-87d6-4c80-e112-08dd1d39b18a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 18:52:58.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sN84xNJyxF5MVTcYiaObUMYDp3Oulg8yRmR/wIBcTXGzcnGczlXbNKOVqeR/tcVi1GQG6An6iAqObBlihkMREw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-15_08,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412150163
X-Proofpoint-GUID: s2VIcSBLhd6yJNk_l_5EsWH79sFqoLBL
X-Proofpoint-ORIG-GUID: s2VIcSBLhd6yJNk_l_5EsWH79sFqoLBL

On 12/14/24 12:02 PM, Chuck Lever wrote:
> On 12/14/24 11:34 AM, Chuck Lever wrote:
>> On 12/14/24 9:55 AM, Jeff Layton wrote:
>>> On Fri, 2024-12-13 at 09:18 -0500, Chuck Lever wrote:
>>>> On 12/13/24 9:14 AM, Jeff Layton wrote:
>>>>> On Thu, 2024-12-12 at 16:06 -0500, Chuck Lever wrote:
>>>>>> On 12/9/24 4:14 PM, Jeff Layton wrote:
>>>>>>> Allow SETATTR to handle delegated timestamps. This patch assumes 
>>>>>>> that
>>>>>>> only the delegation holder has the ability to set the timestamps 
>>>>>>> in this
>>>>>>> way, so we allow this only if the SETATTR stateid refers to a
>>>>>>> *_ATTRS_DELEG delegation.
>>>>>>>
>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>> ---
>>>>>>>     fs/nfsd/nfs4proc.c  | 31 ++++++++++++++++++++++++++++---
>>>>>>>     fs/nfsd/nfs4state.c |  2 +-
>>>>>>>     fs/nfsd/nfs4xdr.c   | 20 ++++++++++++++++++++
>>>>>>>     fs/nfsd/nfsd.h      |  5 ++++-
>>>>>>>     4 files changed, 53 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>> index 
>>>>>>> f8a10f90bc7a4b288c20d2733c85f331cc0a8dba..fea171ffed623818c61886b786339b0b73f1053d 100644
>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>> @@ -1135,18 +1135,43 @@ nfsd4_setattr(struct svc_rqst *rqstp, 
>>>>>>> struct nfsd4_compound_state *cstate,
>>>>>>>             .na_iattr    = &setattr->sa_iattr,
>>>>>>>             .na_seclabel    = &setattr->sa_label,
>>>>>>>         };
>>>>>>> +    bool save_no_wcc, deleg_attrs;
>>>>>>> +    struct nfs4_stid *st = NULL;
>>>>>>>         struct inode *inode;
>>>>>>>         __be32 status = nfs_ok;
>>>>>>> -    bool save_no_wcc;
>>>>>>>         int err;
>>>>>>> -    if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
>>>>>>> +    deleg_attrs = setattr->sa_bmval[2] & 
>>>>>>> (FATTR4_WORD2_TIME_DELEG_ACCESS |
>>>>>>> +                          FATTR4_WORD2_TIME_DELEG_MODIFY);
>>>>>>> +
>>>>>>> +    if (deleg_attrs || (setattr->sa_iattr.ia_valid & ATTR_SIZE)) {
>>>>>>> +        int flags = WR_STATE;
>>>>>>> +
>>>>>>> +        if (setattr->sa_bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS)
>>>>>>> +            flags |= RD_STATE;
>>>>>>> +
>>>>>>>             status = nfs4_preprocess_stateid_op(rqstp, cstate,
>>>>>>>                     &cstate->current_fh, &setattr->sa_stateid,
>>>>>>> -                WR_STATE, NULL, NULL);
>>>>>>> +                flags, NULL, &st);
>>>>>>>             if (status)
>>>>>>>                 return status;
>>>>>>>         }
>>>>>>> +
>>>>>>> +    if (deleg_attrs) {
>>>>>>> +        status = nfserr_bad_stateid;
>>>>>>> +        if (st->sc_type & SC_TYPE_DELEG) {
>>>>>>> +            struct nfs4_delegation *dp = delegstateid(st);
>>>>>>> +
>>>>>>> +            /* Only for *_ATTRS_DELEG flavors */
>>>>>>> +            if (deleg_attrs_deleg(dp->dl_type))
>>>>>>> +                status = nfs_ok;
>>>>>>> +        }
>>>>>>> +    }
>>>>>>> +    if (st)
>>>>>>> +        nfs4_put_stid(st);
>>>>>>> +    if (status)
>>>>>>> +        return status;
>>>>>>> +
>>>>>>>         err = fh_want_write(&cstate->current_fh);
>>>>>>>         if (err)
>>>>>>>             return nfserrno(err);
>>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>>> index 
>>>>>>> c882eeba7830b0249ccd74654f81e63b12a30f14..a76e35f86021c5657e31e4fddf08cb5781f01e32 100644
>>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>>> @@ -5486,7 +5486,7 @@ nfsd4_process_open1(struct 
>>>>>>> nfsd4_compound_state *cstate,
>>>>>>>     static inline __be32
>>>>>>>     nfs4_check_delegmode(struct nfs4_delegation *dp, int flags)
>>>>>>>     {
>>>>>>> -    if ((flags & WR_STATE) && deleg_is_read(dp->dl_type))
>>>>>>> +    if (!(flags & RD_STATE) && deleg_is_read(dp->dl_type))
>>>>>>>             return nfserr_openmode;
>>>>>>>         else
>>>>>>>             return nfs_ok;
>>>>>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>>>>>> index 
>>>>>>> 0561c99b5def2eccf679bf3ea0e5b1a57d5d8374..ce93a31ac5cec75b0f944d288e796e7a73641572 100644
>>>>>>> --- a/fs/nfsd/nfs4xdr.c
>>>>>>> +++ b/fs/nfsd/nfs4xdr.c
>>>>>>> @@ -521,6 +521,26 @@ nfsd4_decode_fattr4(struct 
>>>>>>> nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
>>>>>>>             *umask = mask & S_IRWXUGO;
>>>>>>>             iattr->ia_valid |= ATTR_MODE;
>>>>>>>         }
>>>>>>> +    if (bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
>>>>>>> +        fattr4_time_deleg_access access;
>>>>>>> +
>>>>>>> +        if (!xdrgen_decode_fattr4_time_deleg_access(argp->xdr, 
>>>>>>> &access))
>>>>>>> +            return nfserr_bad_xdr;
>>>>>>> +        iattr->ia_atime.tv_sec = access.seconds;
>>>>>>> +        iattr->ia_atime.tv_nsec = access.nseconds;
>>>>>>> +        iattr->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET | 
>>>>>>> ATTR_DELEG;
>>>>>>> +    }
>>>>>>> +    if (bmval[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
>>>>>>> +        fattr4_time_deleg_modify modify;
>>>>>>> +
>>>>>>> +        if (!xdrgen_decode_fattr4_time_deleg_modify(argp->xdr, 
>>>>>>> &modify))
>>>>>>> +            return nfserr_bad_xdr;
>>>>>>> +        iattr->ia_mtime.tv_sec = modify.seconds;
>>>>>>> +        iattr->ia_mtime.tv_nsec = modify.nseconds;
>>>>>>> +        iattr->ia_ctime.tv_sec = modify.seconds;
>>>>>>> +        iattr->ia_ctime.tv_nsec = modify.seconds;
>>>>>>> +        iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME | 
>>>>>>> ATTR_MTIME_SET | ATTR_DELEG;
>>>>>>> +    }
>>>>>>>         /* request sanity: did attrlist4 contain the expected 
>>>>>>> number of words? */
>>>>>>>         if (attrlist4_count != xdr_stream_pos(argp->xdr) - 
>>>>>>> starting_pos)
>>>>>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>>>>>> index 
>>>>>>> 004415651295891b3440f52a4c986e3a668a48cb..f007699aa397fe39042d80ccd568db4654d19dd5 100644
>>>>>>> --- a/fs/nfsd/nfsd.h
>>>>>>> +++ b/fs/nfsd/nfsd.h
>>>>>>> @@ -531,7 +531,10 @@ static inline bool nfsd_attrs_supported(u32 
>>>>>>> minorversion, const u32 *bmval)
>>>>>>>     #endif
>>>>>>>     #define NFSD_WRITEABLE_ATTRS_WORD2 \
>>>>>>>         (FATTR4_WORD2_MODE_UMASK \
>>>>>>> -    | MAYBE_FATTR4_WORD2_SECURITY_LABEL)
>>>>>>> +    | MAYBE_FATTR4_WORD2_SECURITY_LABEL \
>>>>>>> +    | FATTR4_WORD2_TIME_DELEG_ACCESS \
>>>>>>> +    | FATTR4_WORD2_TIME_DELEG_MODIFY \
>>>>>>> +    )
>>>>>>>     #define NFSD_SUPPATTR_EXCLCREAT_WORD0 \
>>>>>>>         NFSD_WRITEABLE_ATTRS_WORD0
>>>>>>>
>>>>>>
>>>>>> Hi Jeff-
>>>>>>
>>>>>> After this patch is applied, I see failures of the git regression 
>>>>>> suite
>>>>>> on NFSv4.2 mounts.
>>>>>>
>>>>>> Test Summary Report
>>>>>> -------------------
>>>>>> ./t3412-rebase-root.sh                             (Wstat: 256 
>>>>>> (exited
>>>>>> 1) Tests: 25 Failed: 5)
>>>>>>      Failed tests:  6, 19, 21-22, 24
>>>>>>      Non-zero exit status: 1
>>>>>> ./t3400-rebase.sh                                  (Wstat: 256 
>>>>>> (exited
>>>>>> 1) Tests: 38 Failed: 1)
>>>>>>      Failed test:  31
>>>>>>      Non-zero exit status: 1
>>>>>> ./t3406-rebase-message.sh                          (Wstat: 256 
>>>>>> (exited
>>>>>> 1) Tests: 32 Failed: 2)
>>>>>>      Failed tests:  15, 20
>>>>>>      Non-zero exit status: 1
>>>>>> ./t3428-rebase-signoff.sh                          (Wstat: 256 
>>>>>> (exited
>>>>>> 1) Tests: 7 Failed: 2)
>>>>>>      Failed tests:  6-7
>>>>>>      Non-zero exit status: 1
>>>>>> ./t3418-rebase-continue.sh                         (Wstat: 256 
>>>>>> (exited
>>>>>> 1) Tests: 29 Failed: 1)
>>>>>>      Failed test:  7
>>>>>>      Non-zero exit status: 1
>>>>>> ./t3415-rebase-autosquash.sh                       (Wstat: 256 
>>>>>> (exited
>>>>>> 1) Tests: 27 Failed: 2)
>>>>>>      Failed tests:  3-4
>>>>>>      Non-zero exit status: 1
>>>>>> ./t3404-rebase-interactive.sh                      (Wstat: 256 
>>>>>> (exited
>>>>>> 1) Tests: 131 Failed: 15)
>>>>>>      Failed tests:  32, 34-43, 45, 121-123
>>>>>>      Non-zero exit status: 1
>>>>>> ./t1013-read-tree-submodule.sh                     (Wstat: 256 
>>>>>> (exited
>>>>>> 1) Tests: 68 Failed: 1)
>>>>>>      Failed test:  34
>>>>>>      Non-zero exit status: 1
>>>>>> ./t2013-checkout-submodule.sh                      (Wstat: 256 
>>>>>> (exited
>>>>>> 1) Tests: 74 Failed: 4)
>>>>>>      Failed tests:  26-27, 30-31
>>>>>>      Non-zero exit status: 1
>>>>>> ./t5500-fetch-pack.sh                              (Wstat: 256 
>>>>>> (exited
>>>>>> 1) Tests: 375 Failed: 1)
>>>>>>      Failed test:  28
>>>>>>      Non-zero exit status: 1
>>>>>> ./t5572-pull-submodule.sh                          (Wstat: 256 
>>>>>> (exited
>>>>>> 1) Tests: 67 Failed: 2)
>>>>>>      Failed tests:  5, 7
>>>>>>      Non-zero exit status: 1
>>>>>> Files=1007, Tests=30810, 1417 wallclock secs (11.18 usr 10.17 sys +
>>>>>> 1037.05 cusr 6529.12 csys = 7587.52 CPU)
>>>>>> Result: FAIL
>>>>>>
>>>>>> The NFS client and NFS server under test are running the same 
>>>>>> v6.13-rc2
>>>>>> kernel from my git.kernel.org nfsd-testing branch.
>>>>>>
>>>>>>
>>>>>
>>>>> I'm not seeing these failures. I ran the gitr suite under kdevops with
>>>>> your nfsd-testing branch (6.13.0-rc2-ge9a809c5714e):
>>>>>
>>>>> All tests successful.
>>>>> Files=1007, Tests=30695, 10767 wallclock secs (13.87 usr 16.86 sys 
>>>>> + 1160.76 cusr 17870.80 csys = 19062.29 CPU)
>>>>> Result: PASS
>>>>>
>>>>> ...and looking at the results of those specific tests, they did run 
>>>>> and
>>>>> they did pass.
>>>>>
>>>>> I'm rerunning the tests now. It's possible the underlying fs matters.
>>>>> Mine is exporting xfs. Yours?
>>>>
>>>> Mine is btrfs, and the NFS version is v4.2 on TCP.
>>>>
>>>>
>>>
>>> Nope, I still can't reproduce this with btrfs either. I'm also using
>>> v4.2 on TCP. I assume you're running this under kdevops, so we should
>>> have a relatively similar environment.
>>
>> I'm running the "stress" setting, which starts twice as many threads
>> as there are CPUs (so, 16, I think?). 32 nfsd threads.
> 
> Also, I'm testing 2.47.0 of git. The default version that kdevops uses
> might be older.
> 
> 
>>> Are you also testing the same commit?
>>
>> The first failing test run is on 6.13.0-rc2-00016-gb45eda1daa7d
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/? 
>> h=nfsd-testing&id=b45eda1daa7d79a2bf0426d27d4b359b8bb71d33
>>
>> I'll take a closer look.

My bad, I was testing with 2.46.0. When I changed to 2.47.0, the
failures in 9/10 went away.

Now with 2.47.0, I see one failure when testing in "stress" mode
on 10/10:

Test Summary Report
-------------------
./t4255-am-submodule.sh                            (Wstat: 256 (exited 
1) Tests: 33 Failed: 1)
   Failed test:  19
   Non-zero exit status: 1
Files=1007, Tests=30810, 1330 wallclock secs (11.27 usr  9.81 sys + 
1098.89 cusr 6274.49 csys = 7394.46 CPU)
Result: FAIL

It doesn't seem to reproduce in "fast" mode.


-- 
Chuck Lever

