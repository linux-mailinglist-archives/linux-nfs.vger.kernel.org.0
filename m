Return-Path: <linux-nfs+bounces-9172-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B056EA0BD8E
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 17:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05C1169F70
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE0A22BAB1;
	Mon, 13 Jan 2025 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TP/jspPK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cYV2bWyr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7CD2297E5
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785803; cv=fail; b=pRxumwFvWlhV9VshVx5/4mIpARzhKdRS7IsuuHr8DwtbAE+hTw+DuaeulhvlMOcjR1Y9W96hB31Gb0DR0XMaRpskpEUVjuX2J52HpHwFSrxewRKfyFrk2Lzvjlo0A98M6wNZlVjYZiv1gYnyJRbt6nkToIFWGGWNADN8WG4IX/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785803; c=relaxed/simple;
	bh=/+mUCE5nS/7TSQ9XaOg6bmOpmRW8+gpfXXxxjMYXMIQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DbynK+bwoYEEo1F2ZzhspboaryTcRWmx3uWf0HkLjcIGR7omUwARRCQ1o9+cNVCDH1zQxhr5NdRsb8IANOmRrAET6BBYF4MJ54CJJLXxTjx/P8khcctqRUyP3M21ypWYsSZ0wwKjzX5gD9pikWK05GoJ2IJqLFqz1YUkeffwPmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TP/jspPK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cYV2bWyr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DGR8BJ030410;
	Mon, 13 Jan 2025 16:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kWfnbMznEP7OdAZqKU8SXeIvaX/TaN4phkmrZJMAkjQ=; b=
	TP/jspPKx9Ph6Sfasa0Nl7nfgQT2hqhX4tYF0bu/Ws2RJ5cKWuDruvpB+CDMmkg+
	rtAGHsUrBw9Pud1bj2eCC6be6jFCTnUtIbj+9Hu/uk/Q134d+IG7eNEyUhMLV1J5
	vWdZUYLQmQAywu7h0UWRS+GVGeqJapgNzoNWlFwddxQTd/VD0GG488s62VQvMRCx
	ussZvZFZosnggf5Cza5hvo1lMoC1FH454aEyTc2mZC+TAPPKP7YATBOu6LEmXlcm
	iB5KsTv39QOWFdWWYrVGi6JXd0XA5IZr48m9gGrnMN+UqmmfyGGgi3thyeTXUFsR
	aYsK2RkSGXxDiB4kuEzJRw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f2bv0sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 16:29:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50DFnJBM037036;
	Mon, 13 Jan 2025 16:29:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f37p0g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 16:29:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rClf0+REnUkGKwdZebFfHnv4qhTSrDEm50pdlRFHaXoHIyUP7+jAHtAQl1wvEfjdyZiIHsVLwvh8svE8Y/1fF8v3xxzWGCp1HmpPPkjWhgAtzN68ZP+PY0N14AXpjFo4+xUI2H46pYHIyiWJvm0GsdY5tmBSEun50hcktmYGFmgE0PMSy3D+hr4dKRMvMDduW+G0P7sOd7ZBP9tJph4Vx+qsgzJZv9Ot3yXd4NlKAAVkmlMJ16+cm6Nnh7Re+OhuwRCqS5nfiD8nwWmwJzSbmz7Vy+BnPUFPigJYaQek+uqOyf1jztjggrwH2NkTHWl4CFgiiTtXIGuefls0bhk+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWfnbMznEP7OdAZqKU8SXeIvaX/TaN4phkmrZJMAkjQ=;
 b=b9biCNbUkS0NC5x51XYaPYQ6tSO3j0De/OgKk/B6hDaAbWIFK6HBo9nwj8geLPuETIKXbg6C4SXAgMmTMzGLX7lpcs6RXj//POb7CA5MYnb8owuO/fR6PIf4TVQACO4XFnjwtaEAGs8MN9Nvo02LfsojAYEn9H53ITLcIRiXNt/1U2+lQ/nttWdcD6aUTZIPJYlVm2XgyrJ61Ze470RWHGNUyLjpIZ552htOp5QcLxdu9u1x9t/+t8ASA2uWisP2C398BO0oiwAjSIhb5nApD4d5kRogswABZrv3QBUirQHFQaKfuTDQodvwzTZahIWlwu76WVXstIDgF31Fl0mx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWfnbMznEP7OdAZqKU8SXeIvaX/TaN4phkmrZJMAkjQ=;
 b=cYV2bWyrdqxkdWkiWzy+VZ0D7SvIhwmFkg1elJQhfBpKjWpi5MwbIoNoyxt0VG60jOAMl4nP1u7o7rNo+hVC05eB8EI8FRSzTV4m8VAq2pbvrqZ9UxqmY4Sm9iWqucNNUxKFoIHPTjuJC0Gs0bn8no32eKKwZPmpmvXtRjNhCSc=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by MN6PR10MB8118.namprd10.prod.outlook.com (2603:10b6:208:4fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 16:29:54 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 16:29:54 +0000
Message-ID: <04515ed0-4b40-4dea-8cbd-29f05041464e@oracle.com>
Date: Mon, 13 Jan 2025 11:29:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH NFS-UTILS 10/10] rpcctl: Add support for `rpcctl switch
 add-xprt`
To: Steve Dickson <steved@redhat.com>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org
References: <20250108213726.260664-1-anna@kernel.org>
 <20250108213726.260664-11-anna@kernel.org>
 <2ac43d80-3623-4be6-8d3f-b2dffa485b12@redhat.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <2ac43d80-3623-4be6-8d3f-b2dffa485b12@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:610:e7::25) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|MN6PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: f04ca14c-88f1-4a63-2a06-08dd33ef8278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1VEQ3RidWxGRGRYMzlpend6bzNwbnRwQStCeVAwRDgwV2d4eFRYbGdOR0da?=
 =?utf-8?B?V0IvUkJuSmJUWGJGZ2ZVOWtvNTdpMWFpUGZLRjV6WHBEcEtvcjFNYTFscXBJ?=
 =?utf-8?B?M1lYQ2ErbHc0d0kwNjlSZDYxZUNHYXFabTJkRlJLcnJXTE5xTmRuOU5WRzVP?=
 =?utf-8?B?bDRabi84cWNnVDhpUVdyMlNqeHh6c3BHNnl0Tnp5QXZDYmphU0lHYUs1Mjhz?=
 =?utf-8?B?ZUVGaFpLQ25hWjJsWldJOUF3RVYwM3RlOFRlRjNrMW5SS2ZRS2l2cUxKRlBZ?=
 =?utf-8?B?Y2d3d2t6MlF0NzFjN1dwVjI2b25sRm05K1dKN05JQVI4ZjVyUUJnZmtucnpW?=
 =?utf-8?B?QlJMMUtYOXZ3Y2Z4YzFIYi9kTDlDLzNCd0JONDl4Q0k0Rld1ZVd5WnMvSWFr?=
 =?utf-8?B?YU9SRlRWSWphN1hNWjFVeklUOFpaNkh0NFZxVGprTXYxajNjZ3hib2pnbXpv?=
 =?utf-8?B?aDVlblhrMUNLcmpLWFVqbjhsK0RWODRQbnk4ZU5LN2FjTU0wdHlkbi9PS2x6?=
 =?utf-8?B?TTlOK04wU3UzYmNiQndjQXl5TWlZY0VPSzNTV3c4Y2ZNK0JCRy9VSWhoZGRr?=
 =?utf-8?B?d1pmZWVIam1FMGQ0WHg3STJFVXZOVVU2NDhtaSt3ZWMybHNZWDJkSUdKMzUw?=
 =?utf-8?B?ZHB4bzhwZHQzMzJwU25VTG5ZcU9lQ3FVM1FnYmxKWFJicVZZWXdMQjNpZEMy?=
 =?utf-8?B?bmFnUmc2WC95WTRScVVBSVZtU09IOHB5KzBxdFhDV2hJWS8zeThJdHdaWkU4?=
 =?utf-8?B?UlM4NkdnZEpFV1RrN3E1NEhXTlA2bFNvRS9Rcmk5aXFaZUlpMDI4d1RodW5B?=
 =?utf-8?B?d3ZHQTQrdHFWWjljVnpWR1hEL3pFRVRXVUJiWEdyZ2M0VUcwWkRLUWgzUUZC?=
 =?utf-8?B?bm4vL0ZkY2RSVmFvejZzUkJpUE96bFl3aTlSMytPOWNSaFpndEtYQXlMTVBN?=
 =?utf-8?B?cCtLZ2ZtWG56WEs1T1pkVUY1L1prbDBxcU9xcFlKVXU5cnpnTjZvZzBKRnBM?=
 =?utf-8?B?aWVSa0NhWVpLWjN6dDhPSi93Y3I0ZlhoRmdQcGRDamxrTWI2LzR3U0tCajRl?=
 =?utf-8?B?VXNRc2ZGdHJpdzJzbUVNSzlDczE5cFpPbDd1OHJaY2U2ZStDa21IdFY1Q05n?=
 =?utf-8?B?Q3U2YWRoSlh3NjBWbnRXbDRBc0s5LzAwZ3dsQVdDQTFUM1pXbjhES2JpQXM3?=
 =?utf-8?B?dXROVHBCYnVxdGJIcVorV1FVcUUrd1ZkNmV2bDNUdGI0eWh2ZXNsbU1uTElD?=
 =?utf-8?B?U3JXNWZ0Zm5UZDJFZGltUlB2ZzYzSWNpeHp0c2RUN1dmSTE1NGFHcWhhY1cr?=
 =?utf-8?B?V1BrRTB2VmZ6LzFmNm9Wd3lLRzFxNzc4c1d4bGlzb2p3SFFTVFJORzZ3VVow?=
 =?utf-8?B?Sk9wcktQOWpKOHpTSmhlL1VXRm5LSzNrOUROcmh5T3ZYazVSK1cvNzF6ckJ5?=
 =?utf-8?B?M21oYjVpdFVYRGxFUUdVZVFUaVFyS1ZuNmhJNHBwL2Zyd0xjc044cUlORGhF?=
 =?utf-8?B?dGRibXV1NFU0cVVPOXRzam4zUHVmUUpkRVVKQWFuTlZZMTlMTlpCam9TbWNy?=
 =?utf-8?B?WEN6ODA5NHBNYlJWdGUrTVdLQ3VCZERFZVdDbGRIYlRXQVltMmd2VmR2cWRu?=
 =?utf-8?B?THZ6eVA3ZDNTM3NSQURpMWoyMlBUMmk4Z0tTNUwyL2hTY2txbkJWQUVGc0hm?=
 =?utf-8?B?bWlsVWt3d1gwODBuQmxCQXNObzY3TjBsa1hJM0dLUmk4aTE5QkJQSTVEa0FI?=
 =?utf-8?B?L0dGVDNDcyt1UmdIVGtjcksrckZLVit5bER6OTYvYTVCNUpkL2FXZDNuQUJ4?=
 =?utf-8?B?eUMwdXg2VWdKbElOUmM0am1TUmc5VFFNUUtjS21UNFZLWTFQeWJiZW52WTNl?=
 =?utf-8?Q?TfYplTIsXNC4e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZURuS1Q0ZzRwYzFqeWZYanh6SGZ6WWIyQkhzWGxyK1pJMUx2Tm9Ma3R4K2dI?=
 =?utf-8?B?OEZRM3lXY2JsZmdldjlEVExuZi82U2ozSE1mM241UDJxc0g1ejlFWEo2dWpX?=
 =?utf-8?B?ZGRTQ1pqVTBjTXdCc1d2d05yMWR2cFcweExNMFEydUF2Nkk2Zmh3TENhb29T?=
 =?utf-8?B?T1lFK2dqaGNoRnN0S3ViaURsVndQQ1JPbFJOckVlYlozQmZENnZWREsxVlFS?=
 =?utf-8?B?ZUN5bXlEM2hFc21oYXRQeXpaOUtNNVpLM2w0UUhST3ZsaGRWOElQMXlmeFZ1?=
 =?utf-8?B?VXFxbndUS0NoelZFMEdzVU9zdU1HQ2dVdXFFR3hzWW5VOEVCZVhYQ2xrcTdB?=
 =?utf-8?B?eC9VQ2EzUHdnWjNJcW5iQTJXTk1OQ2lzNlBjaitwTENralg3VEc1dVgrb0tT?=
 =?utf-8?B?MzI3ZDVxTzhQZDhoaDliMGV2ZjE3cERQWnlTejNleCs2dkZTekp2aUJYRWQz?=
 =?utf-8?B?bjVGUFhkNEY2TExQRHNQQU1QYUdvMjVKaG5JaUE4a0pnaUxlQSt5eFZnV3ND?=
 =?utf-8?B?NU1tN2RUMzFEYk1SWXYyclhkVVBhampjdWFOSVcxK3hTZVdYVUdRQlRFNVpM?=
 =?utf-8?B?ZTFJc0gxZC9DM1AxcFRUR0Z1ZHRRa0FIVFNkWXM3d0Rva01vS1VnK25zK2ti?=
 =?utf-8?B?TmdoMk1YRVJKcXk2NXdEMWkwaS9vSlJZKzFpRHhwY2ZIN2hITStIYnNoVllU?=
 =?utf-8?B?aXNOMnVuUG9vdGF2SFRZVEhLbXcrRklRay9WSTkrRWJZb3hZMThGMGN6WENF?=
 =?utf-8?B?b2tVUmhtblFmSXlwN210V2h6ai9tSlg2cHc5NC9LaFBaekUyKytKU0JQZTF3?=
 =?utf-8?B?ekRiWU9lR3hKMWx3clF5RDFPWVZVejZTeTJJU2hOZGNjeVRqVkNYNEdlS3BU?=
 =?utf-8?B?VVBISlVQL2duMnNHREp3Qkt2ejJ0L0FmRXdUVjExN2xzSVIrdTkwWEJxSm5B?=
 =?utf-8?B?MUkxT2g4c3gvTHF3ZjcxZ2RZN2JkYmtKVFRPT3hiN1Z5RGpxSmdVaFo4WjMx?=
 =?utf-8?B?RFAwTXBLUmNMRVVIRHRBSkRGRjdUbU5CRm9NQ05OUTBtTlNHSDRhUmhOenpx?=
 =?utf-8?B?bXlZNVZRYk5BTWhOUVVaa1NvODhmeEJ4TENIaTYzSjVFWlhYZy9VQzJNZDRu?=
 =?utf-8?B?SExTUkRvdkpRT2J0MERSYnQ3MzE5RXhyN2I5SENibDA2eXVHOWJhMmZ5SmZ0?=
 =?utf-8?B?N3FxcDQ0RFNIcUF4eXJKWGtpRk1vWDk0OUN0Z3ZZMWJnZUNzdzk0WXdXdXBX?=
 =?utf-8?B?NFJOZjZJWmhqaFFjZ0t2dHFYeVhQUzdjVUJrNXRPL3JRcS9wSTYzT3Z4QUYy?=
 =?utf-8?B?WEx1bG5vWUg2WUYvbmVBTWNoVUxRd09VaEIyOTNvL3RNSkc1RmY3K1o3ZHlx?=
 =?utf-8?B?OEJ4dEFBYUNBVFlUVjNoSis2Vjg3bW5jellmL3Q4NEFwU0N6VmFqRUYyYVd6?=
 =?utf-8?B?VXRpQUFEWVdiZklhYkRjOHV0RVBwYU5sNG9GSWJwYmR4S2pZWlR3eDN4d1VW?=
 =?utf-8?B?VHlLV1FGb0NvMGJHdEVTWDJIYUN2VWo5WHg2S2lLSXpFVTNpckNHUTNNSGRQ?=
 =?utf-8?B?emFkQU4vUW0yM3BYazV5UVFSU1BoMkhoa2JBa05Gc2IyclRVTkdCSmVxb3JL?=
 =?utf-8?B?R2UxK29OZnJNYXJJWjVWRVdONVllQUd5cVd0SDhpSTcrTDVha2szbksrQ05z?=
 =?utf-8?B?YStyS2dWZjYrc3BqU1Y4ZWxDaHBrTGpiSUtDOUtibTg4Sy9rbG1uYWY2UHV4?=
 =?utf-8?B?UGhEZklzVWRTajhOZEZ6Mnd5eVl1TUJ5K1dqWHA4dWovYVRwRWhUOFBUSzRE?=
 =?utf-8?B?MnZGZW5qRVJaNmFGZXRBZTZVaXNxYTc1ZEZaQVlNOHBPL2d4M0g2dmtrQmQz?=
 =?utf-8?B?Y2pYajQ4Wjk4RGNXMGNwSUpSNVcyY0VyNW0yaWNQeDhmVGdmaTB5ZE9yMlNi?=
 =?utf-8?B?L1RYY2d0RXFNL3B5Y1pFUWpRVGhBUmNEMy9rZTlRZ2JHRjNXYnBsZndrTDd3?=
 =?utf-8?B?UzFpM3VhQ0xUQnROSjdkTmpTVkpqSlpZM1VsQlB0d2JEcXVXcjN5OHJGcG9p?=
 =?utf-8?B?SXVFcWlyMlBUR3JuQ29nUkFSbVU4Z2l0SXpXT0NaR1JSUjN1elp0TDBEWGFz?=
 =?utf-8?B?ZnVzU2E4b2lTQk8xbXJtTFhFOXNzZlBZV1ZVeFhOcjdwNy9xMGRqU3lGd3RW?=
 =?utf-8?B?OHhZaW5xREFHQVpPcHdOOWh4Kys2QkpvOUhhbnh5eDdlZUtwUUplVEU3cWpP?=
 =?utf-8?B?dXJNTkJCSDNhTUNHaURqZHRxdXVRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H7ukW6NS4X5N/3MEQ341KTFd0+NvEkFp1UBHmZ6Y0XBA5qRZDY36u3GZOKJnpStvmq0miGYFmLgNjvC850ct+kwtro9qBB4gIePZTKtD3+AAKnsllHHHu2bzzJG2Pb6RcEscGdS2zWN+6JHUJemAn0JcyIBbarywLYzFHSJXckMRDZag6N1gQAp8Raxk5hnOrzS0lND6mkFocTkwzE2jUXIfWZwC+EC1Lbw1nouYhKNP2fgZ0XZjOufWGsDjpSi104R1R1gji21+5gfOZnB8yH+DDTQPP3CIyxjdCx42elamFaLbQQKXLerfvUg+CwJvPV3zsUno8gQYVhz4iuylY+RThSUjlxXvqWzkcZeTK3sxSUDA/OyvKYhZSpDYb0Mu1W2rWzmxcVXulzyfYpxHgshA3lD2JsCUDbWUcKnvgwN0FLrFW7L1/RJ543Q3jaTmeKWOAyVHGGqXc+dN6/Qw958wxeI2OZHnMUHpGF3D42A5mW5eKr9wZEAvZCtqO1JGnYLBP/hUN8Qa9NWejsA1cnKcHMzlWanBgrIYx2tnE30drqAZF9vYdSFeVhS1gZ4KbVNeQ8o7htbLtf4fVbrBJ7AAjmmu/LS7aD5WZyJTeF4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04ca14c-88f1-4a63-2a06-08dd33ef8278
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 16:29:54.0616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUd2cpHgMRIzfheq1tkcPMrvjBRUTAGBrFhdCBDVw6Wu5CJr5kxNebbK77HrE30kVShEAdm0TnR4Mi8p5junyKPJzvsd+LAmxsXK0Pl6xaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_06,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501130135
X-Proofpoint-ORIG-GUID: 0CQTUkiRLgai-0uCuRETd7d4OhvjfFeh
X-Proofpoint-GUID: 0CQTUkiRLgai-0uCuRETd7d4OhvjfFeh

Hi Steve,

On 1/13/25 11:23 AM, Steve Dickson wrote:
> Hey Anna,
> 
> On 1/8/25 4:37 PM, Anna Schumaker wrote:
>> From: Anna Schumaker <anna.schumaker@oracle.com>
>>
>> This is used to add an xprt to the switch at runtime.
>>
>> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
>> ---
>>   tools/rpcctl/rpcctl.man |  4 ++++
>>   tools/rpcctl/rpcctl.py  | 11 +++++++++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/tools/rpcctl/rpcctl.man b/tools/rpcctl/rpcctl.man
>> index b87ba0df41c0..2ee168c8f3c5 100644
>> --- a/tools/rpcctl/rpcctl.man
>> +++ b/tools/rpcctl/rpcctl.man
>> @@ -12,6 +12,7 @@ rpcctl \- Displays SunRPC connection information
>>   .BR "rpcctl client show " "\fR[ \fB\-h \f| \fB\-\-help \fR] [ \fIXPRT \fR]"
>>   .P
>>   .BR "rpcctl switch" " \fR[ \fB\-h \fR| \fB\-\-help \fR] { \fBset \fR| \fBshow \fR}"
>> +.BR "rpcctl switch add-xprt" " \fR[ \fB\-h \fR| \fB\-\-help \fR] [ \fISWITCH \fR]"
>>   .BR "rpcctl switch set" " \fR[ \fB\-h \fR| \fB\-\-help \fR] \fISWITCH \fBdstaddr \fINEWADDR"
>>   .BR "rpcctl switch show" " \fR[ \fB\-h \fR| \fB\-\-help \fR] [ \fISWITCH \fR]"
>>   .P
>> @@ -29,6 +30,9 @@ Show detailed information about the RPC clients on this system.
>>   If \fICLIENT \fRwas provided, then only show information about a single RPC client.
>>   .P
>>   .SS rpcctl switch \fR- \fBCommands operating on groups of transports
>> +.IP "\fBadd-xprt \fISWITCH"
>> +Add an aditional transport to the \fISWITCH\fR.
>> +Note that the new transport will take its values from the "main" transport.
>>   .IP "\fBset \fISWITCH \fBdstaddr \fINEWADDR"
>>   Change the destination address of all transports in the \fISWITCH \fRto \fINEWADDR\fR.
>>   \fINEWADDR \fRcan be an IP address, DNS name, or anything else resolvable by \fBgethostbyname\fR(3).
>> diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
>> index 20f90d6ca796..8722c259e909 100755
>> --- a/tools/rpcctl/rpcctl.py
>> +++ b/tools/rpcctl/rpcctl.py
>> @@ -223,6 +223,12 @@ class XprtSwitch:
>>           parser.set_defaults(func=XprtSwitch.show, switch=None)
>>           subparser = parser.add_subparsers()
>>   +        add = subparser.add_parser("add-xprt",
>> +                                   help="Add an xprt to the switch")
>> +        add.add_argument("switch", metavar="SWITCH", nargs=1,
>> +                         help="Name of a specific xprt switch to modify")
>> +        add.set_defaults(func=XprtSwitch.add_xprt)
>> +
>>           show = subparser.add_parser("show", help="Show xprt switches")
>>           show.add_argument("switch", metavar="SWITCH", nargs='?',
>>                             help="Name of a specific switch to show")
>> @@ -246,6 +252,11 @@ class XprtSwitch:
>>               return [XprtSwitch(xprt_switches / name)]
>>           return [XprtSwitch(f) for f in sorted(xprt_switches.iterdir())]
>>   +    def add_xprt(args):
>> +        """Handle the `rpcctl switch add-xprt` command."""
>> +        for switch in XprtSwitch.get_by_name(args.switch[0]):
>> +            write_sysfs_file(switch.path / "xprt_switch_add_xprt", "1")
>> +
>>       def show(args):
>>           """Handle the `rpcctl switch show` command."""
>>           for switch in XprtSwitch.get_by_name(args.switch):
> 
> Quick Question... Is this patch dependent on the previous
> posted kernel patches (aka NFS & SUNRPC Sysfs Improvements)

Thanks for checking! Yes, these patches (especially the last two) are dependent on the kernel patches. I'm in the process of updating these for a v2 with the kernel stuff. If you would rather me split this up into cleanup patches and then new feature patches, I can definitely do that!

Thanks,
Anna

> 
> steved.
> 


