Return-Path: <linux-nfs+bounces-13049-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E71B040D7
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 16:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB814A3F64
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 13:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4717324BBE4;
	Mon, 14 Jul 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lql1yzag";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bv1F+p3s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8553D255E20
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501579; cv=fail; b=b4H38DKiM69VeWKEiegFjKEJT2u9W8mDQS+pTTypveYh55+kFCKtYqISPj0U8RODcCq7QC8ssMuhKrK2gY7PDiaactjwZp51AKhf17ejP9IpBZmu1GOOqiD7jtt+VmWiYkQOUlmkZmkxxtJ+U/1DScGuhfohFvUbZFhEfw2Qh10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501579; c=relaxed/simple;
	bh=DSEb6tpkrn7NtqqWFIaYel/k0u9phUahbp/fQORYg4Y=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=FPvioWL9jPROOrb5+vjx14+5cJ9QRjm86lW42jKdvPJC+dLgzSuH5QHIfPVs/9DCfVYvAx2hiv8yZBaA0Y4e9+vR922pIH2t2/gxXWL5m+zW3aqod0IVbgimZVJW/IQohOPbZ6CZOvcUiKPAikw9YwpW0cn9+y+FDaxKCChtr38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lql1yzag; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bv1F+p3s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z3Lw004546;
	Mon, 14 Jul 2025 13:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ANG7vsWzyoHP94pOLUFsJeoLHeGlOtIVZjSYnIyTAOQ=; b=
	lql1yzagZpj9tHluzlXPvrBlyspmjEUEJV3znji0vzDrn2IyZDycY/+Zoj+VxgQ5
	uddg2m/Zw7Gzx5+kba9fmkIx+aEk+3GlQ8MLN1GMBKK6LwkuaKF6ojwO2juemJo8
	toCQVqO42rWRfeKe9xFK7k90N194YE3WfGmRIn2Ah2cDhHvgqVupP831X6mE27h2
	PhBZ9gQMXQepoRzRF75IVyygKTrppnQ1mLyq6vCzfs182d2Aw5sLK1VSXIdfLXyL
	pFQgS3JrDcPMLB5TEmr0XwllOgy8NNT3BtB672H+FBciYtOLP+2R7Nu0BgG7XBv5
	F8F7egfPsf6zM/zGooXqDQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx7vcwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:59:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56ECR7it010912;
	Mon, 14 Jul 2025 13:59:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58jqy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:59:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDO5QEhuWjdTJyeBpaUqAxgJ9orCSIl+AI28JHJsKOoe40fY01ZLpg9I9Mh34/FISrK07Dr2/EWb5ZE9RF2zZCcRn6safpYD3JUzM6/6kXqXLLYLW6syRGnV5kXtssi9orkGjCP8jukeqWzPN3bsWiw1evGrcGhynQg0bEI4LmMa6scQPluEZyWxNYa4wf7UiaFeJctrbIFigVoREGigowwGwPAt3Xqt5nX5ld4GUvNCHbQSL5/uF8GsWx6RExGvg4VmqwYGc7wYlR1l35zaGebvCmAVZP+62uDLcJddJUtPB2TGHzdUCSenuj4SccfRdSZj6NiQEgBnSLX2K/BGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANG7vsWzyoHP94pOLUFsJeoLHeGlOtIVZjSYnIyTAOQ=;
 b=HrpUvpyKVkggxbNIVuKxUt5jZpogm0Zq2dkhclaANu1AUAzNBVYiD1Riv9zAoIOLXzoCH6tnmv1Oh/auhxg8vAnU+wA0/r+aDIKLQZndGSdp822vzyoNZsmCjByqAUo3hMFI0YXzx1nP42+AqrdUw0WPraNT/o7JXI0a7tTMhMnqHNues6qBP0JTLkIZX1pJd3PogpCDWetDKNqyGIr1R5BxHo/yAnYI9uSosIk1MJAjF3/aUuCZBfBi06GRqGNVghlHkmUqqjt79gomYpWoN2RZznfN61WfYqCYa5LB07XLXvSRwNWbvElDMVlixfK3iAyE94HmhE5sM0eWYteLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANG7vsWzyoHP94pOLUFsJeoLHeGlOtIVZjSYnIyTAOQ=;
 b=Bv1F+p3sROthid81w48ImBAjegsK3knkuov5fLAUuK7I19AR+a6l0y8n365moKbFjQPvVNaR4dzc7irTEvQfCMFUqVwxJ7gRpvCrykZvSCVDRaWnrrb6GNKpPFQhKGnZ1YGmbnxocOxvvQMEo7ASxVyHJxZzfesmDBCOLtrQPmY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7962.namprd10.prod.outlook.com (2603:10b6:408:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 14 Jul
 2025 13:59:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Mon, 14 Jul 2025
 13:59:31 +0000
Message-ID: <9afc753f-aeb0-4b85-9d46-d6e83da1b819@oracle.com>
Date: Mon, 14 Jul 2025 09:59:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] Revert "NFSD: Force all NFSv4.2 COPY requests to be
 synchronous"
To: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
References: <20250618125803.1131150-1-cel@kernel.org>
 <CA+1jF5pJQePnFWWT7G5T3RXwcmwNyfo=phaXaUB0v7Br6yrgdw@mail.gmail.com>
 <CA+1jF5pP3MJQ6L8TBzfuBNRr-YZxefBpBrQSxRR2kJWSqjgYxQ@mail.gmail.com>
 <f6f3c22f-8c49-4f9a-937f-2103cd780f6e@kernel.org>
 <CA+1jF5qu31AjMpRxmZPVmWVvd_beXS=0egeCxbdthY13GDRiQg@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
In-Reply-To: <CA+1jF5qu31AjMpRxmZPVmWVvd_beXS=0egeCxbdthY13GDRiQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0038.namprd14.prod.outlook.com
 (2603:10b6:610:56::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f05b92-1e6e-4827-6638-08ddc2dea7b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnhKbWNOUTRjZzZhTE9jRU94Tm1RaldnK3drQzd0QUhrZ2dBNmdKSGtnRkZu?=
 =?utf-8?B?WnBDM1RhT1dpdnZnV3pXem9lYzBEVENEUnNFTlp3STVqQldWTmVsUExRcDFQ?=
 =?utf-8?B?V0RUWnJvNmFZbXZSQ0xaaGZPVG92cjdOMWZTd21JRStZS0JxamI5WEZ3eDRH?=
 =?utf-8?B?d3FRWW1qMWdYTmo0OFc5dWZvQ3Q2L1JVTk1LNHdEYmMxbXVNbWxtb1JkZ25P?=
 =?utf-8?B?cm4wRVE1QVZYNkdQekxPWDI3c3cvVU9SSjNPUEltYmRQaTQxVlMwS3NlSWFu?=
 =?utf-8?B?ZzMwMzVoQ0hrWGkyMFdGZHFnTzh5bWdJSU52UG9Mc1RyVjdZcFNLclAwc2Jt?=
 =?utf-8?B?Q0U3LzJ2c0g3ZWxnMENScU1LT3BXZlBnWW1lbndFRWcrRUZ5ZGNmZmVQajRY?=
 =?utf-8?B?V3E2bENIZklzRWY2TVNEYW1CTHhxK2dKWUhWc3dZZDZyRDlaSjV2b2laNlM0?=
 =?utf-8?B?UStheVVQZDlKSUVPNDhBdng5RXZxTWZXSDluR2FhNlhKYzE4MTRSVVVTamtn?=
 =?utf-8?B?cy9FL2lBL1hUZ1BOZEcvMW9FTURDRm9JVGFJSXdxN2pIWDR0K1M0bndnVmRq?=
 =?utf-8?B?UEpSSFZlNW1qUzZudHRIVmNQMmJ6T013NG9CTXNtenpZTk1aSVphYTlBT2x0?=
 =?utf-8?B?OG93TmJ4bDA3T0hzWDl1V0N0OVpUd2pFcVUrTTMwZytSY1Vab3lqdi9uR3Vi?=
 =?utf-8?B?R3pmUzRCV243MkN2WnlZNU1ubjV3R3gzWlhYL1VxQmFMWENaSEtMKyt1RDRX?=
 =?utf-8?B?aHdDOXVrUTNwL1RxRGxOUXRzWEhIS2daMy9IN091TjhmS0ltdEJsdVJ4Qkhp?=
 =?utf-8?B?R0cxUU9uMnEzeStKSjRacFN3QVVROXRXeCtaZnFueWw2UFZaRHZGdFc4UFRm?=
 =?utf-8?B?VjFPUk5QZ2N6MWF3dGJRZXZvSHdIQ1BtSlNQbythNUhJSEpiL2hxTEZRbDQ0?=
 =?utf-8?B?NHZIODVSSlN4QWxGT0xLTlh6ZW9pVGtyUGx5ZE9IUE8vcnlld2RkckRxbzM4?=
 =?utf-8?B?bU02NStjVllMbk01dUhBeHhSVUc0a2tkSjRxdlp5eC9rNFV4ZmdoNXZseDZn?=
 =?utf-8?B?ZFJrc3RrRVVmQWY1QXFLVFRlRmM3QjdhTnBiQmNIZUJhQkNxL1BqU25jcWg0?=
 =?utf-8?B?TWp5NWx6bTYrMVZFVlJDTm42RGcvdmhvNFZJeUR1OUdOTllpcGJkZlNDNHFN?=
 =?utf-8?B?QWlWRU8rbWh6cTBLWUs5NzNISHh3c0YwMHhZMlg1THQxN0hiL3JhMTVzY0tL?=
 =?utf-8?B?UEFkUkl5MnRHRzJjRVMwM0phQnFlU3kyUU9lOVA4TWZJczZLTXhabi9TSG16?=
 =?utf-8?B?VTVQMkRsQ3I3YlFOaGdYSEFsbjdKWWJKcEltU1hNRnZVaTVrRGdEdW8wc0xK?=
 =?utf-8?B?Yms4OTZxeUp2RElsb3FlWUhCcVJDR1B4U0lRS2pFOHdZOXdIWUlRUjRuVTFO?=
 =?utf-8?B?bTFScGNzOWlheDRRampqVWJEYkdjd1V2RnlrditVUDdnVDl4MTJSYXN5T243?=
 =?utf-8?B?Nk81SmxsQ0JDejVRak11YVpWN2tMQVRRTjVybWFyc3Fsa3FBbmd1WDJNN1ZR?=
 =?utf-8?B?anlOZ1BwR2cwT2NJTENwSE5JbEJQOVMvVUVGNS8wVkFJdVZPWVZUN0dOZ0hI?=
 =?utf-8?B?T1VvRHd0OXdQdXNQbUZJRTlxSmxrMGhQUjIrbGJBUEFQWStLdlNSSUNmRzls?=
 =?utf-8?B?bmlTY1k5aHNGQkthRWlsWVI0MVRoTE9Qc3dpZFJKK1NrNHFyT21uUWxCL2Zj?=
 =?utf-8?B?ZWsxQ0hyZFlwTFhzR1hwWlpHZElxLzNXMlZERkI5UFd2MjRlT0JiODZRSVUv?=
 =?utf-8?B?d01MWlBjSHN3RUZ0L0h5OSszNi82SU1Pbi9ic2hNbEtiN3ppM2pnTmtSWGta?=
 =?utf-8?B?TU4vOUc1d3VKL3dEaUN6djdQeFRyb2R6R0xFZkZKaXQ3eTE5bmU2MVB3MXll?=
 =?utf-8?Q?mhFfWo6Ltjs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3RGdlFiM1Y3ZWdLdDlZc2x6dVU0M3pLQ2kvVitOTXZ5dVhBZHBBN2hSc2hU?=
 =?utf-8?B?QjBxSFhNL1ZrcTZDMjR0bWpXY25HSDJuT1FFcllsVitQeWxaRnprVG5uVDRF?=
 =?utf-8?B?WjRGNzF1N1NpOGdlOGJEbi9tcm9pdkIwNHFxYkk1MklXcHF4WGJvcUlXNlhT?=
 =?utf-8?B?clVPb3hiQkRtUC94UnhOaWdnR0Yxam9kQ014bllwL09EYTNwbm5YOG8veFBD?=
 =?utf-8?B?NEZvYUppYUNSaUw2TGZRVjdiSGxaSkRrY05ZUWtDbzhJamlHMythMzBaUmFD?=
 =?utf-8?B?bjQzYnY1WlNkSU1yczkrUVhiVFBJSFRFNmdaZDhaOHhST0h3d1hwQmhxQldy?=
 =?utf-8?B?c0lSclh2WHprQ3RZRGZ5Y2J1SjQ1WmNDYkNjRnlsUDhzcWNzYUZaNG9hcW8x?=
 =?utf-8?B?NzVOYm1NSm9zcEVwZWRVWFpaSElYTS9lUUZYQy9JQ2VCL2VSdXdhQXkvV2x5?=
 =?utf-8?B?RC9mQ3JQWmRGOVhPTkFNbDNZQitsWGVHd29LM1ZIRnYrOUd3ZkR2VHR5QzlH?=
 =?utf-8?B?TXI4YnNXWG1xZ3VBNWFxeUk2ZnR2Smt4SEkreWhoYnpkcjltbGFocWtiRHUr?=
 =?utf-8?B?SEcwRmlpb0tFV0dpdFhIT3I5Qm1jTnV4TkpCcWtNY3BXZTdacTBSZVpvNHFh?=
 =?utf-8?B?SXhwTkVjRDZHWm9TS3VUdzY0dGx2VTFlZGxtREtESXJZS1E5RHRJTm9BazA1?=
 =?utf-8?B?N0ZhTWRtMlQ3bk1SS3l2VWJuQm4rSUtsNEdkaHZaajJnelB6NDhIMU8zWWla?=
 =?utf-8?B?S2NjUHdQd2hGazRJUWNDNEMrL2NLZFNXWXNLTmF5bkNMbi9HSzVUMFNWY0R2?=
 =?utf-8?B?eEN0amZ6RWVKUGdhTStWZjdQWVlYblJkdFJ4ZXczaVVUSmk5blRueHFQVXY3?=
 =?utf-8?B?TVdFZTZVejhOcElxTmFKT2xjWHRSdnZBNTFoT1lwTVJyV3pmekZOaXhPd1dl?=
 =?utf-8?B?MHZqQ2k5aFVIWmNHYmpOUmxCTVVxanY1WFk4VHhGZTFSWnAvUHB2ZU93cWZ1?=
 =?utf-8?B?QWMybXRHZmhuTVhoK2JKU25hSGU3aHAwYm9vQnVjaEd0Q2VmSU5jU2JFcE1T?=
 =?utf-8?B?bXRZZElhZDVuWnY5MHQ0TzJYengzNW5xaU9nTjhyNEhrZHlCQUwzdFprOUJL?=
 =?utf-8?B?LzVZbmoxdit6Mk1FMWVkK2EzWEI0T0RRUG9rOGJZM2JYK1pMZnZrdXNOdVhS?=
 =?utf-8?B?T2FudHZoMy9iMXluY3N3U3FWOGxvbjAvRlR6cU5VUXljTEVwNDMwZlVpbDcr?=
 =?utf-8?B?UWY2UzdyaVg3Q1ljRFBLcS9GWWFtN0t3dUtkU3lWOWoydlZJQ0l6aFB2NHlZ?=
 =?utf-8?B?ZG15bkZDSVBOTlhFWVpqazl5VUhLa0g0SkRnb2NTOUpyMGtaWFZnVk1qWnds?=
 =?utf-8?B?Wk45WTBjRS96K0tCTUg3d0ZIVExybTZLZy96WW1XTG5HSHExbDhoM3c2S3Fx?=
 =?utf-8?B?MU9tcEptYThydEVjNkVSbXozZ0hubFVjalFNb0VSRTJVRnh1NTRGai84WHVu?=
 =?utf-8?B?MmwxODJNUzE0N3NWYVhtY2tHQXBKUEo5Y3N2WDBVQTFvZmdydHlKOGhUWncy?=
 =?utf-8?B?ZnNOSWZLU3Y3QkV1STFpa0VuOWdPNUxaZXQ2dWhQTGRhRVBONWtmSWdtTkUz?=
 =?utf-8?B?d014VXNvU1NoUVhlRytZeGcxWWFSTXN1TEIzcjFlVHNFSndLOXMzanFxZkEr?=
 =?utf-8?B?ZlZ2L3NyVlM0Q2xteXZHKzVUMUVJa1BheHZjZkZ2bHNMSXBqWVZNOG9mWElw?=
 =?utf-8?B?QXhCSFl4cU83eXppVVRsSVh2bmM3eW42QVoyaUV5Uk1kcW4raGdtZHV4QVVz?=
 =?utf-8?B?bGRkYlQzTkd6b3Z2Wk9sTHFHbGh2MVJ3dGRKN2wyamtqd0tEZ1pDdHhHV0tO?=
 =?utf-8?B?Q2ZsRnpWcDRVWnZWWkxNVVBMVlRKcXJBUDRHalNkZjJQOFM5TzRRQXp3Z0k3?=
 =?utf-8?B?NXRiT1EwUGxGWE5vQ25pTEs4QWdaVS9SS1hRSW9LUWtxS2VqUmx3U2w5TUFX?=
 =?utf-8?B?bE81RHZlV1VUblZuL2M5TG1zQTR3bUtuMjFZYmJrdFA0UGRad2NjUlg0SlRR?=
 =?utf-8?B?YjAwbFA4VFhIZENFUmMrS3pJeDFIWGlsWXdyS2dQZ2lueEhMN0VXamQrelRj?=
 =?utf-8?Q?UTvggKrIxxpzNcivAu1Yp6KGp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LsuKUSP04gVF+EQ9CQOqfzhJ0FJSYqitn1z3hkBUfY+ooGLjyzTb4WbVjYF7jfng99m9Fe2c4k7vjAXQWCxDQelrfQLeCERzMtb9X4znvUh6uw4CO585KJXER6kZGo5d++L5A2Ulk92KNj19BhzWiv1BjwCwWNQih5ytfS6xtW5bK/GfpRQMxkZpFJ6TzZBhud5TW1MhNVlBFne+1IlbrZp7PYstzQ2xtDDlhkDsOCRbdV8aRqk37BXrOB2aaARivQ12mKia30YeA+DZW/g/c2tMa/ep0vNl3h3Nt9v5IT0aaJjt2PJ6j62ZwgdK6WKd3f5zH3xTUgr9JbjvOdom6TJSAl8DcD2CoUszmODkyOdhBtg20wN7iPUqcmIVmbwadEjyD2o8Wxxz9T7HS/CmAsdQESL+O22sW6HVUlQABVXvpjN+vRcuXxLk/5DRB2wZc9CAT6B7FOpzPRhR4hONULOxLKNVAy3Fi0g7yCV9JXyFnsov0Yuq9Gq3Dt1RPtpUllbHYahzMfzETjeFTLB5Sq2030mcZ5LRPMo6S5axivZC7xsi4C15RHav9AKYbUVIE1UtFxhR/wJ/5UAX8u1IHvGPqmawIZkI/kF4bl+bxTI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f05b92-1e6e-4827-6638-08ddc2dea7b9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:59:31.5457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/y59S8nEgiHzPlN+v1NPuF/emSe8sHYWptF34+6keRi7a26YbJcLCSZtgJb2BAWVwmCkyCPDysL/wbma5+YBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140082
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68750d46 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=hAhA0azD156Qo1U5RN4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: b8YJEHxMBMyDQ3v3JZQMA2dD8Rf6iaoA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4MiBTYWx0ZWRfX5kRHgSKoes19 Xnumv/nSKLZTa800UDiCm1/c6PYtrKYzbcTm5Kh/IOFRB6xcGRoWEyo5WtZ3vm7ajeTjnWq5bG9 s+70OGSR/f0t50StTiAWUtCZIpYJA4dR1gcFtyxcZX4NyrzKJlnwr0NPy8f7qVmNIkTqnlJcJw/
 d5Fz8ampE49+nh1vRzN0DbdBMBB18hhRpp35HVC3DrM9A3nmCcaY60ymSG4eKg8OFV5R6iHffNA AdkP37yI7pWaV+52n5DqBvLqzy7h57fKphGjWJBsiMOJB/9Pzsl1MTtE1l5jlGuFHn2EXOSpesT RCd08wjI6qUjw8CpomflEws1I2kTEiBT+6UNkIy9HQC7MV5Y7w3Gct4AkXNhb0E+YvtoNC11q5V
 UqoxMBa29q4fO08v+w0bacnWK+T5sB+qe9STz3CTw6SZ8AHEMth01AuDBlZQjrcs0eYwhsPj
X-Proofpoint-GUID: b8YJEHxMBMyDQ3v3JZQMA2dD8Rf6iaoA

On 7/14/25 6:36 AM, Aurélien Couderc wrote:
> On Sun, Jul 13, 2025 at 7:50 PM Chuck Lever <cel@kernel.org> wrote:
>> Also the request for "training material" for individual NFSv4.2
>> operations does not make sense. We do not have training material for
>> the NFSv3 READDIRPLUS procedure, for example.
>>
>> Therefore I ignored the email.
> 
> OK, but as an analog: SMB is infamous for "too many" features, all
> which can cause trouble. Over time SAMBA added controls to turn
> features on/off or use different ways of emulation.

Samba has to navigate between two rather incompatible worlds: POSIX
as it is implemented on Linux and FreeBSD, and the Windows world,
via a non-POSIX network file protocol (SMB). There needs to be some
flexibility of configuration there.


> So far NFSv4.2 has
> no controls to turn specific features on/off, or even get statistics,
> or put limits on certain features.

There has to be a demonstrated need for each such control. We're not
going to add controls that don't have any real use because controls
actually have a long-term cost. One or two might not be expensive to
maintain, but when you add them with abandon, it adds up:

 - Administrative complexity increases
 - Our test matrix increases exponentially
 - The documentation workload increases
 - Kernel API rules make it difficult to fix mistakes or remove
   deprecated controls
 - Replacing a constant with a control setting has a small run-time
   cost
 - Developing around these controls can sometimes be difficult

There are very good reasons why Gnome removed most of their
configuration settings a few years back. Eventually it becomes
impossible to manage and maintain the software.

This is not to say we won't add a control if it should become necessary.

So do you have a need to disable an NFSv4.2 feature? If so, which ones,
and why?

Do you have a need to limit some feature? If so, why?

What operations and events do you want to count? Why? Why can't you use
eBPF, kprobes, Dtrace, systemtap ?

Since this is open source, can you contribute what you need rather than
asking us to implement it?


> That IS a problem, which SAMBA and even Windows Server SMB have
> solved. Otherwise you're at the mercy of whatever combination of NFS
> client and NFS server you have, and that is NOT good.

That is still a very generic complaint. If you have a specific issue
or question, please post it. Simply saying "we need more controls" is
just not actionable.


-- 
Chuck Lever

