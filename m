Return-Path: <linux-nfs+bounces-10007-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE44DA2EEDC
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 14:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7976716190B
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 13:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363DE230991;
	Mon, 10 Feb 2025 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PGlClSY3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tc4V4Oj9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7722FDFA
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195535; cv=fail; b=LFKTHCnoHg0n++KJ5xwMbh7Uf8fD1vbJZTx0+KalNXXXHxKOxW4su7NFLLhg+FmgtZfEJz5Z+1IkIm5hh9vakSvE86tIgxvHpao66/wjcoRwWD9sAseC0sk49PbFf9ueTcGvYeg0nQab+/TyTZEQpi1U5PHc/Qyx4gnC6fhzMbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195535; c=relaxed/simple;
	bh=iMfAu3m2JbplxFtfGBuVmRNlnQ/kmEIKKwnCYDXcbrE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AvYl89LL+IJBQZL7FpAfQYVRwcqCu+5jOqqnHPwkxktWytAumYMcMmxSUcqYPTojOUw3zxRE9lI/JbCzc9g6TxDatyxhCprlVUOtRhkCIZRMj94xR9YSJI16caB/SKGoBKQXu9uTLznOol8N8tZRcjRcwy5ZZ1e9ky2KOTEy4Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PGlClSY3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tc4V4Oj9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A7tZ4p031934;
	Mon, 10 Feb 2025 13:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EFwX5NQv6yu4kIneYaAc7LjyvqIrf13ob0XZFjoOcS8=; b=
	PGlClSY3N0ZHSqXfGxVm17ZgoF/8rBOSF5fZWiG/LkxIRFjlQne/5sr/2/Zh+1BW
	vDudNjJK1h8LH9W7e6l5dO0oessCvj4SE3TzCaTqEYzumfvKAWBys0yRC0ELJZQI
	ZEtMnVCpvZ8A/4JWORiObivho39L+zu0ujoKrM+TZwz4kmVPXFn06VRJ8UkAjtEi
	YrXSqfcQCPtI5n3EU4u5FUXb1OF0nvN38mC78vVpPYOWywpyi1YmdedAjWm3+kul
	LuFvgv4cQwSh+9t6e4Yde4TkXD/5P6juAPOT1qBwfeA0VgJGDVhXUHkRMMmugCaM
	io+9PL7P+zGfckAmq8MSrg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2ay1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 13:52:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51ADMHlX027014;
	Mon, 10 Feb 2025 13:52:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq7dfhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 13:52:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cz+1HwvSGSxsxKNUJaADiWjvYyiIgtkbycvn3IxaMbyFqienM8GYvvAs4VlD+9nTyjnK7Ia0Durg3JB1laWqGXjfVpvGXfGCHK7Av4FxntU+gj5VNexKqalbhhkel26WzgiLqo/yNz3ene5967zk3Y72ENjPVD+ubblFxJmcdHr+9wUpW1Ersp8vFrQVHbB2uFZ9PgwPQR4aPC9nA0Mvk9igiXRdO7BI2leWjdWCyH60g+RLiu9CjBTIw8K8ZFnpmmICAC0Oi3FeCNLOhqHYKylx9JMjS/Cn7kLZtmu9PcyN7km9XqYjgFk6+dXiBALggw+AS6yMivmDsVHmPygeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFwX5NQv6yu4kIneYaAc7LjyvqIrf13ob0XZFjoOcS8=;
 b=TP0iv3SN0WkD3dLfWBeUQVccl4HvH7YsR6J8cehj7peh/2QUm19Q4EAmnW5V6Qvczb+AsZdOIgKWbcWhLYHIrb0zlHBviK1dQqmNCCnfuAyCjung7D2uWmx39mLUBRAOv3xIyWig9toiXucwhqPrnDfq/ElkPnQ2LKG/lVJ8DelRfn75AdsmhZyS0wVHSHGsOgvG8V9W/6aDOZ8owzAFAs47VrPMGyK7EDkrkhaXiGWLRQPPLncKSn8cuWDw33Uaq4UvIOxeXFJKbz/N40s20/pBM/aQ+dadi2UxLPU6Ex5I2QY9Mn7l0ZgpLN/oC5Ry8rsNanP3X4AwyVhh2Qi5Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFwX5NQv6yu4kIneYaAc7LjyvqIrf13ob0XZFjoOcS8=;
 b=tc4V4Oj9gQTvw0R73wW3S0ja4dnUWJen9QKjtvjvHwZn3jK0Sq6P1DP3ss4Lcjkku1nYhSO/O3Q6NP4uexqNNY6Si2RPh+YHUVNmSetIfBMcC8Pj4byXndkp5aK8C9qlsfmI6V19qzOAb0T3VHEzB2UGYhnn5uIx2VfaGPySJ4c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7729.namprd10.prod.outlook.com (2603:10b6:510:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 13:52:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 13:52:04 +0000
Message-ID: <a9127b76-29f3-4782-ba9b-dff1ebf6f647@oracle.com>
Date: Mon, 10 Feb 2025 08:52:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: resizing slot tables for sessions
To: Rick Macklem <rick.macklem@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <CAM5tNy4f9YyMhYRydudNkCqzVp5f8Np6N25NOT=-+TjJN2ewqg@mail.gmail.com>
 <884876492c56e76fd6fbb4c5c4fb08ee14de9fe1.camel@hammerspace.com>
 <CAM5tNy5yv1CkVc3z0dTJ_Fed9mP-ZBug1L39Jnau48s=OnSPvA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAM5tNy5yv1CkVc3z0dTJ_Fed9mP-ZBug1L39Jnau48s=OnSPvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:610:cd::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da08162-ca86-429c-6e2a-08dd49da19d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVRnYUVad2FlbWZUOTVPQUhSNklReWNtUXo4dk9rTytXVjlvam1Cd0lPaVFi?=
 =?utf-8?B?VG9Rc2FKWDVCSnpjUXNLTVV2STVic2UxN1FnL1BJRU5iWTJvNGRSc2hTRkpI?=
 =?utf-8?B?T0thRHZ4c1g1dUx1bU9MUXhVbVVBbS9FcURVNzJLalZ2M3Q5SXJyRjJEMW9V?=
 =?utf-8?B?bjlsR1VNdDY0aWdYcUg3dFlXd2d1WjBTUEJMcTI2TlNHdDhLcWdUaGFuemVy?=
 =?utf-8?B?d2FlaVB2RUFtSXJJRStPdkRhdDlWYWxEMFZzN1Jwakp0R0ZQZXJQZTg5elBR?=
 =?utf-8?B?dFBwNmM1M2ZGMzRIYTNxekpCdCtaMHBpa1IvOTZZcnIrTWJBR21yYUNUdHc3?=
 =?utf-8?B?dnBiRmdmSlJ2b3d2UDExVkNIMG5Kb3NjYU16aXJBOStIelR6N0FxR3VwZzlj?=
 =?utf-8?B?WENsYXpQTlZSZWFCTWR6YUdjUm5JcVNnVHFQeEFya1BKWGVKZ3orKzMzUmxx?=
 =?utf-8?B?WEJaS2NuRWVwODYzNTc3ZzRmTUpiNU9EczBpdis1dm9VSXRRdk90Q1JqVXF5?=
 =?utf-8?B?Q2VuazRPOUNJYjYzSTdXVHJ0dFNpdjJxWEExaUJaMVhhVjFJYWpEck4xQlo3?=
 =?utf-8?B?TmNOd0pLc2tLKzJZd2xVWjFjM3NzREZmQ1ZxUk5uRUpmNndkaGRzNWxmeTdQ?=
 =?utf-8?B?MnJYcFNVckZnbHRReC9ad3pHbTFHdVNEdXIyNFcyOFQ1TmdRNXdpMzFpbUho?=
 =?utf-8?B?SGFxTHAzS3dRcjd1ZzhhTEhHMHcxRks3ZzdMbDhWS0Y2aWYvdWtSSVk4YnpQ?=
 =?utf-8?B?WUhCM2NHbndHOE1XU0pYelZkK3kybjlmT2VTR3VwdFdKZ1h1VlV2TnFkbDNp?=
 =?utf-8?B?ZFoyOE4xSk05K1ZPc1kzZDFacVNlZ3hibFA1QVREeG44QmV3WHlSM0R6Rnlq?=
 =?utf-8?B?L3FQbUkxNjB3bnI3R0ZxSFVRZ2ZqV1oxblNLOWlqN3VjUmxaZ243MHk0TVVR?=
 =?utf-8?B?cHNDNkJ6RTg1ejBjVkhUYzBmQ2oxWjFSTUVOSVVuWjdnTlV2MzFzL3A0MC81?=
 =?utf-8?B?NXV0OC9ORXBqOWZma3pFWCtremNYL3VyRzhtUjRXRTNUVDRVYTdwWTlIbkxL?=
 =?utf-8?B?dlVQWjg0WGtxeTBmU2h0dmh3d0JRa1V3ZTZGVmlRWDBQTGVSOFljNXluTzZx?=
 =?utf-8?B?Y3RsdEhRSWV0OFl1Q2JxSk5KS09mZC93TERTUnN4b2NkVUFnakFSTS9sZFRr?=
 =?utf-8?B?dVE0ZVBXRzJzTVFyNnlReG1RUFJEZERmbUNlZmtrK2RMMU92d0hQd3BHa045?=
 =?utf-8?B?ZXNnWWFDQkF1M2lPaC9sL2tkWEpWYjRNWlBwR3Q4ZVdEb2pWRnJLek1FSDNN?=
 =?utf-8?B?dE1sa1dmU09OeDk5bXdxMDFhTlpDMlkrZGk5TnIrdERtcjBlYzdKT2J2L051?=
 =?utf-8?B?M2hxTTA4cmJCRWRrbCtBZ3RRTjd4QU0zRWtaTllCQ1FIdVhFdnpTZ1lKdXZM?=
 =?utf-8?B?cUI0UktoUFdsd1NOOWt3YjkwSkpxV2dtNyt6cHdaaG1YWXRIVG85Nnd5QlZy?=
 =?utf-8?B?cXIzYnRWdUY1RURlV2wxSnlaS0dBWm55dUFiSHFnbjJiU3ZwU0VXY3U0L2Nn?=
 =?utf-8?B?clgvNVpDWmFBSWlQL0kxWTlhV2JDNmRmSkhoN3NORXlFcHpFbWlGQU02SDJY?=
 =?utf-8?B?VzBMeWozMDFFbVdsV0ttYUVtbGd4ZldveVZIeVZidjQvOGpUVFZ2R0dmcmNr?=
 =?utf-8?B?U2xyRHA3M3NOeHp0eCtaOWdITXh2Rks2R2pNRWkxV1R6b1ZPZFBMbVBLMmdx?=
 =?utf-8?B?c2J6VUhVQTBMT251eFpVVXQrbHorUEVmenc5MGEyM1ZvTTBpR3VycnJmazFr?=
 =?utf-8?B?L0NVUXF1OFl0YXVHQUwvcU1ncFdrclRsYmtYZnlPTjJCMGRtTnQxRmw4a2N5?=
 =?utf-8?Q?bA171cG0IS+Zw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b290U3pkZzdldGtvYXl6dUJseW9HS2lvR0tZZWRncUcxUGpuOERJTHNOSDZp?=
 =?utf-8?B?bXVSZ2htRUJwNVpsVnZ2ems4VjhQNmhuZno3US9MWHp3ajEzVGVJaTh2ZHh6?=
 =?utf-8?B?UVNjcDBBc09uUUNudE9JdjRaazY5Y1VKdk94VXlFMExqS1lmVC9vMy94WHBZ?=
 =?utf-8?B?aWs3WUVoVUkyREk3SG4xSWxMNFRMZDVHNnlaZXZPdzY5dlZuMGxldU1FdzVN?=
 =?utf-8?B?cXNjdm5HQWNsMFhnZmxSV2ZLZjNud0RHbXg1WDJSNHBENXJoZk1OSEJTNTV4?=
 =?utf-8?B?UXN2STFKWmcyUUpSZHNTWTJMZ1V6RDhzMEJoZjV4cjBhTjNFcm1RTEFucU9Y?=
 =?utf-8?B?V2J6b3hqVVBwaUx6OWFHeWd0elFNWlNMTS9FeDNIaGQ4RERGZFB0c3M3SHM1?=
 =?utf-8?B?R2VLVDFDUmhxdGo3RTVMUkdsOTR6cVcvMVhFZ3BQMWh0UmlOSDdXU3BScFZZ?=
 =?utf-8?B?b2swRE41M1FIT2JmaWVtQkc5UTlPVkxveXk3QWdqN05rRzkzcW53Z1F1MWlL?=
 =?utf-8?B?NlcxTTYxTFZNK2MraHdGclNpTVdPV2o5b05iczBPcnFZZnIwLzFNYzF5cllY?=
 =?utf-8?B?UkN4ZktGWnc5ZXJGWm1RQ2ZHMlNhWDlmNlF5anBaNDh6bHpscWxhdGsxNVVs?=
 =?utf-8?B?NEZyMmFSeGQvSVJZZ2JTWDhHaDY5cEwvYTUwYVJUYklXRGRuN2JrQWpXSGxB?=
 =?utf-8?B?UDF6VmJ2K25LL1JwL08rU3NWenZ3V2tQYjI4ZTg3dmVQMHhkWUc3anFiMzFB?=
 =?utf-8?B?aU1teVZtVEhPNk5qcWYza1Fnb2RWQlhUQnNIZmh0V1N6dVppcm1Rb0VOdjJw?=
 =?utf-8?B?eWIwbEswZG1kTjkzdjlIUXRqbG9pS2dvUTA2SXRVdkpFNThmSXM3SlAvYjhU?=
 =?utf-8?B?ckIzOEI1Wm53L2pYWUM3MTVpRzZTT05IcmRnaW0vcHVjY2c5eEluN3QreS9h?=
 =?utf-8?B?MkpEOFZWZ0pEK1pnaTlxU0hVYzA4aGFnSk5LeEdwRHQxc1U4MG9wY1FBblZk?=
 =?utf-8?B?T1hMci9jL2NLYVhWY3QrZmZOcHV2QTh0QUNHeDJMeU9YZWRFNzZzS2cxU1l2?=
 =?utf-8?B?Nk1kczR0SjhIK0tJRWIzcmV6anVhazF0OWxNUFpFcDJYNERRcVQrQnNMTFY4?=
 =?utf-8?B?MjFxeDIxZGVOS1Z2Mk44ZzlGcE9HTTBBWk5heFdBZVRRTkkzSDhueFZjcGJu?=
 =?utf-8?B?N0lkUW41YmM1SlNGMnl2RVVNSjlHLzNGZ3dXS1dkeFV2bWpMbFVPUEc2eEpY?=
 =?utf-8?B?REhuSlN3bzZYczY1cEt0aTNneXA0eFdNSUNPRDBaUk9mWVJCRjFlNHdpSTdY?=
 =?utf-8?B?QnB2WTJnQ2ZOQ1NrZk55UWc5Y2c3bG1ac3pTazcrNEVlVE1sb0VBdEh6WkV4?=
 =?utf-8?B?U01ObHBlaTJRQWcvQnZhd1R1U0p6Uk4xcHU2b2kzeFJIMnR3YldsL1VMNkZy?=
 =?utf-8?B?Ukt5TGRqUnRKVk9waThjdENQUjgyRG9LWXF6Vko5dzJlKzJObDg1RG5CSThL?=
 =?utf-8?B?M2M5SDlSSHY0V2d0MDNqcmdaQkpzRFYwZUx4NmEwSWFoNmUrOW5RbklEeElO?=
 =?utf-8?B?eTZvRXN2aHR6U0lac1BFbStOS1V0aHEzSTVNNnBHbnRjZVFJeUFtWnR2TXNx?=
 =?utf-8?B?cFhpcVQrenlsc3JzSDQ0b2RiNGIxSTRvU1R6U3BkY2dqTVlmUFRtMmt1eEhY?=
 =?utf-8?B?MytJanZ1MzNKNWpIZFNEZDlWQTZsQzlaRWd2S2pKVUpJcFFkY3hnblVqcit4?=
 =?utf-8?B?WkJpZHlaRXhKdG8vSE8xdkI2VFZwZVQ5NFFLZXNnblgyRFNqN2RGQ0lXNFVs?=
 =?utf-8?B?cXQ3RVMxQnJ3TDg4bHZGTTZJbVZUVk1OYUQxVFlBWEUvVjhpVGFDbDNuRHdM?=
 =?utf-8?B?dklBUGs3Mnk3djl0eEFRTlZqbDU4akZVYzZwNkplV283dWhpNDNoaGxOVjJu?=
 =?utf-8?B?cUxralF2b1VhTUhIZEFaVTFKTTh6bzIxNnRyZlk1enFXL2orZ2plUW1JQnFp?=
 =?utf-8?B?NzdINENjRTArNmdjN0REZzM1MmpvK0k5VGhPOGFnWlpCUGJIY3cxMk5TajJs?=
 =?utf-8?B?NmlQUThGNHE1d2dvK3l6K2RFQ1Y3Vk4wTGpjSDYza09ESlZNK3MvWjYzWGN1?=
 =?utf-8?Q?GjFNUqbkWDrshKphXJBxP+AUQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8wTgRChAHyEXBoJP25ogrAn6cR8xhGx6kd/zaTpztDhKn/oPG9qx7dM+1vteNKq8n0Cr7yCg67BUKjW7M714b2z+tSQV4u64Ebs/zNn4gjdRio+8X86lMXO4k3ie9fM09V6ldzePrHa3bsslle6bMJN+y3ZTQucrcqkxBvZTfDsBcQutFNypnH96ebapYlNl+tu+Fz7KrGRpF3p8YwN5Vw77UPTyPcl3Mw6ERauB7cJqRVesjcp0uq9GYkPjoXcS0IA0tohOB82Gy3TLh9chwfRcziDWOfres6om/VGYadU1dfJdnQGaqqPnKpQL2MHXj5alDivQ+hL5KCfFmuhJUQ1O0JfRcj5xISmej7oyKVztKNzc/FvAyDHLjpwQMlt6v8nd0CgsKpRpulOUVcMwyyqgToDdKkIudcmdxMCIh+92e2Fxx0pra8IVyBNY35MjFgkLCmI6oyEHk1tESaBtnQT3ncgOYMW0PtfvWJu5NVLLOn9kGUDgl1bkD0lZT2WelEXh28Lnai3NkmduN3AwkND16Cm0CIRqj4vqAwKEwwzpT1ss+nWpCxk1xU30tKFi+SjtdZf8AE2HveHMyfVspchwTERTJ2Qx36x8ZmoWtEA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da08162-ca86-429c-6e2a-08dd49da19d0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 13:52:04.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQ13lrlVQFgpUundKNkugqGG162RrP+oDxfO0pxbbwsrolF3/HpCfm4KMuAROsawVlQ0D2yc8gaGHHs0vB/5Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_08,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502100115
X-Proofpoint-GUID: khW6v3HvqQ3c00gabRtWHxJi1NF92BXV
X-Proofpoint-ORIG-GUID: khW6v3HvqQ3c00gabRtWHxJi1NF92BXV

On 2/9/25 8:34 PM, Rick Macklem wrote:
> On Sun, Feb 9, 2025 at 3:34 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>>
>> On Sun, 2025-02-09 at 13:39 -0800, Rick Macklem wrote:
>>> Hi,
>>>
>>> I thought I'd post here instead of nfsv4@ietf.org since I
>>> think the Linux server has been implementing this recently.
>>>
>>> I am not interested in making the FreeBSD NFSv4.1/4.2
>>> server dynamically resize slot tables in sessions, but I do
>>> want to make sure the FreeBSD handles this case correctly.
>>>
>>> Here is what I believe is supposed to be done:
>>> For growing the slot table...
>>> - Server/replier sends SEQUENCE replies with both
>>>    sr_highest_slot and sr_target_highest_slot set to a larger value.
>>> --> The client can then use those slots with
>>>       sa_sequenceid set to 1 for the first SEQUENCE operation on
>>>       each of them.
>>>
>>> For shrinking the slot table...
>>> - Server/replier sends SEQUENCE replies with a smaller
>>>   value for sr_target_highest_slot.
>>>   - The server/replier waits for the client to do a SEQUENCE
>>>      operation on one of the slot(s) where the server has replied
>>>      with the smaller value for sr_target_highest_slot with a
>>>      sa_highest_slot value <= to the new smaller
>>>       sr_target_highest_slot
>>>      - Once this happens, the server/replier can set sr_highest_slot
>>>         to the lower value of sr_target_highest_slot and throw the
>>>          slot table entries above that value away.
>>> --> Once the client sees a reply with sr_target_highest_slot set
>>>       to the lower value, it should not do any additional SEQUENCE
>>>       operations with a sa_slotid > sr_target_highest_slot
>>>
>>> Does the above sound correct?
>>
>> The above captures the case where the server is adjusting using
>> OP_SEQUENCE. However there is another potential mode where the server
>> sends out a CB_RECALL_SLOT.
> Ouch. I completely forgot about this one and I'll admit the FreeBSD client
> doesn't have it implemented.
> 
> Just fyi, does the Linux server do this, or do I have some time to implement it?

As far as I can tell, Linux NFSD does not yet implement CB_RECALL_SLOT.


>> In the latter case, it is up to the client to send out enough SEQUENCE
>> operations on the forward channel to implicitly acknowledges the change
>> in slots using the sa_highestslot field (see RFC8881, Section 20.8.3).
>>
>> If the client was completely idle when it received the CB_RECALL_SLOT,
>> it should only need to send out 1 extra SEQUENCE op, but if using RDMA,
>> then it has to keep pounding out "RDMA send" messages until the RDMA
>> credit count has been brought down too.
>>
>> --
>> Trond Myklebust
>> Linux NFS client maintainer, Hammerspace
>> trond.myklebust@hammerspace.com
>>
>>
> 


-- 
Chuck Lever

