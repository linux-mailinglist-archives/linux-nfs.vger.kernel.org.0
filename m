Return-Path: <linux-nfs+bounces-15042-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B62BC2DBC
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 00:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB6BA4E50E4
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 22:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD541F63FF;
	Tue,  7 Oct 2025 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a51dtfZx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u3EX9G+P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382913C914
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 22:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875683; cv=fail; b=DCvR4TaCjn90Wf3Tf4Ngho3RXRu8B3NQKq/UJna8AGZUdbjltzcjWhN2Kbxg2hAYjlsRwTyGQHhEpUtVwNLvEo5Bif6sWWmKE8YgtQpAlpCiN4vw6064jYN9iYoqZs9Lgj1wCREvTQVoJWB6RJTX+WGpY7eedG42Y2bCcc1vsIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875683; c=relaxed/simple;
	bh=NrSVE3Yentuw0WKulO9eGTfTtfhBw0rHCIQo71lpTaQ=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pboOr/I7NJSoRSV/xFb/17CWP9vtWaIonhPfrWJjzdRDK9ZdSmC2nbvgJcJVkCAHJPpf4NdHR7XxbzXUxWFc1hhLUfbJOWI1vnA+QXFMDF3V+JKcLjI2c5E8kX9pvvYRLxuHtZzQoIvsgxsglq+3tfIhNN8A1lQkEWsDmGozz9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a51dtfZx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u3EX9G+P; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597M43bD014646;
	Tue, 7 Oct 2025 22:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jBeurUFhDNyK7pWUX2WK9BRXo+V35s9b4tqU+GVZxVE=; b=
	a51dtfZxdCCpdMKCIcSQ9YL7gZCrgH+gyuZLrhGqImcAuNzTrH9wJ8fXrPHvm6gP
	yJXr7nFsb0lJW9vw6mQVk8WPr3/XPxydKI2M1CrimyATPGjKsL/4qJujI4rU7jlC
	UyiSj7FA3buiH98Bq8yRfGUyJJfrnESqKebjcAlp2rKx+PXfxGvoClIWb/15sqId
	mgbGB9I9cwbijgLDRZDuRLIYPphkR5fmDSUUsCCbI7WjO4fCkRaR6Fem/Ai88yAz
	MrD1EYgoX3at6pfqaI75WDEWSASz284M/JsjDQ+mCz3xBNkjMqv6pZyeGNq+G9ns
	aZ3imvE07sdWUZ+4vVeXDg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nb45g123-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 22:21:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 597Jv8Gv028649;
	Tue, 7 Oct 2025 22:21:13 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012013.outbound.protection.outlook.com [40.107.200.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49jt18tv2a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 22:21:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWbkYbR6t48tYP6s5Q7d0/SnUoAQqGHGej6IJfTDfoY0cwgrMc9+HmWdD7ABkDl+g1jC8ZPrKJlKH8vPvdL9jyP87NNEFS0+LLYg1g6ZJpbGkmcJZNZ2Duj+XSrvDBE20PtEWcpRKfrG+rwb9yEkQyHm/0yNpPquJaUyrn+S1QXvijDfnAc11LDUfxGeTm7vJ7/Xm44CZo4zbroIIdeVEoDWlo7KgbiCrI1xXtoHprDXTHPBk5ExB5eRq2yN8C5Z39ZqjbTg6DL1lIHlaG3lWUHQvdZdeGScOxS3EFKQ6YwIKK/RCSoF7u75MWU/gkBIUwo1BcbQZcFB8i3ljl/P6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBeurUFhDNyK7pWUX2WK9BRXo+V35s9b4tqU+GVZxVE=;
 b=vIJpSi+mpMsmvit4NTZhmwruiYVC0PtQWIb+9luPVMkz865nt4H+V2qoj2ARn6K4+Bn2LvUWJMUX8yP9qXCGMdOeK+VdguWD/9KFOJD5kfAxx/TPof9lo0J85aec+T0pRrsWVMcrRwZKyrrUo2L+cLGdcy7/NGXLbaielkjrUyh54Kj9sYuy/8FEXJ2cQsDu4kkXMEBNp1xskbsiyREogXEk7F5ECnZrt6373ibHBC0z48Hocvi4D0OMhny5LrdWJd5Q5fYWbgKqVJQ3pCCUv2nYrCz4ZRpjXR3fN4KfIXJ2dCLDDRjOiTY7ZKyI9FAq//8Oy4tfHvX1PyOMoTXZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBeurUFhDNyK7pWUX2WK9BRXo+V35s9b4tqU+GVZxVE=;
 b=u3EX9G+PCJYTj5zW9LA2nxLZf3Tm3YQixO7jBPPpA68ZwdSAAiS3FexIy7xjWFylKpxa5Fe2XCm3pUb7nPNXVv9Z0MvIdJop6EPqqwOobzZNOKFnxlqhr3r92AZDyCkj7MQa8wYfKJnT4GC3VDi7mCoCllmBCDFmQqb2XXBK1XM=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SN7PR10MB6620.namprd10.prod.outlook.com (2603:10b6:806:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 22:21:06 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%6]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 22:21:06 +0000
Message-ID: <e233f87d-7c18-448d-8400-6ad886a91dc3@oracle.com>
Date: Tue, 7 Oct 2025 23:21:02 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 3/4] NFSD: Do not cache solo SEQUENCE operations
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
References: <20251007160413.4953-1-cel@kernel.org>
 <20251007160413.4953-4-cel@kernel.org>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
In-Reply-To: <20251007160413.4953-4-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0129.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::21) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SN7PR10MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: f61a0fe8-3d78-4578-7dfe-08de05efcec8
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WXBjdFlZTUNOd3VaRXhqUzh1SjV2NnVFdVdXbFJkaUtWQ3NFdmRsN283Vjdi?=
 =?utf-8?B?elFYMGQ3TW01V1NVRFFtN2JwRkNRbXN6am5DNEs5S1E0YjVrVTU0MUdrejhO?=
 =?utf-8?B?OXdhYy96UGlLajNTamRaTGJYV2pnL3BTS2t4NERjM3VGcXFHb0RkcDBNUllp?=
 =?utf-8?B?STQ4NU5WTGxYMENrUmxhOXdEZWc1UktiQnJ5QlZKLzN4MVJwbTBzSUl4T0Vq?=
 =?utf-8?B?Q2tad3gvZ1pmWmhkeXZibDlqU1hiTnNoUXRtSFlSZEJBaC8zK0YwZzNpT3Ur?=
 =?utf-8?B?M0Mvb2k1UzduYzE0NmtBN3FlWnhKVFIxemtEUlE1bkFTbFRTRzZ1N0g0WHo5?=
 =?utf-8?B?RjZNSysyTkpLNVlGTU9DVEFUNStQUnhtY2krKzZXUm80UU5XdDhnVlAwckdG?=
 =?utf-8?B?aWdNbGMrVnJFRGFKdGZITUdpVXJJNmtjM1NrVWQyWXJUM291TmZYS0k0aFZn?=
 =?utf-8?B?UmRxeXpJTjVvYXFoTldYTXQvbjVRbjd0UzNna2V1QW42M3ZkaE9MY2dJWlYy?=
 =?utf-8?B?R2JXa3drSEw4ZmdxSDFsWkNRSnhuVktwQWRHREFuN1pXak0xcTUyMEExem5U?=
 =?utf-8?B?TlcycXNvSGR0T01pOWZ3Q3VTY1FRd2xlVUV2OTdUeVVpSUI3RWtPeWo5K05j?=
 =?utf-8?B?REtyU1NnL3R6bGFrUHpYeVh6blJVNElrQUh6OFhBRVdjSzBJdGdnelFJbFFw?=
 =?utf-8?B?WDVuSW9QcTVGZ0J3eGJRY3QvaWFtWmUwWFZRbVpQL3YyanRTd29tNlFzUVox?=
 =?utf-8?B?dkFUN1VmblF0Z3BYbnN4cyttbnZLamQ5YXdJcDhUUVhYMDN3QWpNd1kxdmhD?=
 =?utf-8?B?ay9MaGN3SURhdENwNlBvUXI5eVdwRXVUbytGSDBYS3lmcmJsdkJDcFh2ZmVa?=
 =?utf-8?B?d0JvYkNHazJ5WXV2UjhnUHBQUmFVRVdSbE9nYnh4ZGRtWnhwaUhGQlkvdCtW?=
 =?utf-8?B?dUlPaSswZmhmbGtjc0RzVXdJV0o3eEhnVGJ6QkhXZmsyUnBtVk40V1kzNFdB?=
 =?utf-8?B?bElPQzBUbDdMN0d4ejY4YW9KUzhUR0Nsd3R3TXBDcW1KdllPMFlSS2UwZGdl?=
 =?utf-8?B?aVc0SHdrc3FLSWFodU5GMXhQdWtwVFBhOGI0em5pSDBiaW5jU0RqRm9aZHJX?=
 =?utf-8?B?WnBJbkEwM0tGYTFHTlNvallsT05iR25mNFJFY1FwdFFmMmRJR3k2Q1BPa3hr?=
 =?utf-8?B?eS8xaEJWZ2lOdExmRmZ5Q09zeno5ZE5JU0dXeGRoVWxBdkNmZFVGK2U3N1hT?=
 =?utf-8?B?MCtlQjJvcVVuNDNyN25VRFd3QnRuaDQzdWkrMnVZZUZRUHdGS0pLYUp2Y0lh?=
 =?utf-8?B?amJaMU5EVVRWOXFobGhNdmV3VkoySERpaGg0bWpCeDMrR0tsMDVCNkg1UmNE?=
 =?utf-8?B?NmZaZldMc20xTDliSHR3R1RoUDRUQzhidk9TL1FzSncxeWxjK0cwUVMveHkw?=
 =?utf-8?B?V1lKcmhkYjJiamtGWmVwdmxyOHNlT2REb1pMdTBDZXNKNHd1ejM0QXhpSVdT?=
 =?utf-8?B?QTJuTEtyR3lleHNHSEhUSy96Y29LNkVjcHNkTU0xdjN0MmNKYVNVNlVoZkpG?=
 =?utf-8?B?Y1J1K2RyWS9Wa0V2RFdWUGlPUERIKzV3RlNxS2pTdUVkVG5LZWlDMmJCdXBS?=
 =?utf-8?B?MFZTOFA3a3NuRHIyU1FXdllyWmRQdnNuR0swajBpZUZKWmlSdjlvTno0UnNM?=
 =?utf-8?B?UEpWcmZHNDhVK2x3clRJdGZBYW1EcFBtc3BkVGpUL0szeE96aFZaYnpKbGhn?=
 =?utf-8?B?MVlVZG1MUFhjdlQyMmZqMjdRZk8rcXB6aEE3WEd3ZzJXTDVqSmJvbFZaQ1hR?=
 =?utf-8?B?eHZiVTUyRGNKVTNUTmFubXU2azN1WHBYWkFpWm0zUkFtWkx2ZXBTdG0xMyt0?=
 =?utf-8?B?anV2N0dGYmVQRFNzM0JQOURpNXIvS1cxMi9aa1BITCtScGZuWFFlZ0hEQUJU?=
 =?utf-8?Q?NnrePmHbWTcY4C9PYpnx9eCFXiBauF6J?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WWd6b0FmY3FwUXBsUDhnQ3Z0UHZ3eHpTTis3YWJScVNzZit0TnlZbnovL0hx?=
 =?utf-8?B?VWYxSE9lKytYSnV3T3o5RXplY0xXek9nczNKblovSXJ0SmJhUHl4Y0Z4UUVP?=
 =?utf-8?B?Y3oyTnU3eVVzVUtwUVNLWWlqRTRuS3Q5cVd2b25EUHlLWTBFZndYL0dmMSt6?=
 =?utf-8?B?MnBQUFprb1J3aERzY0MzRGtqZUFMWkdyYXl2dXR6WlhQS0JQbzJ2WnlOUFZJ?=
 =?utf-8?B?RlorN3pFMVNEbk9SeE9MM3R5alJDNUthK1k3bFJaMVJxOUpiWW9uc3FVRW1N?=
 =?utf-8?B?WmN1SnNLNHEweVpmbmpzdEk3MTEzS1JaSDF6RitmcWduS2lndXJ0TitPd0V0?=
 =?utf-8?B?dzRoR2pXbFc4bkg1MG1vSkRmdThOanVSSXZmaFNTT1M5aURpcVRySTJHWDVD?=
 =?utf-8?B?WjVuWlloTXBkbFhXUEhoWE12QmprZkpGWTNQeWZaNlFLOVFCZGJmQThDUnVM?=
 =?utf-8?B?aU1tb0pyVzlUQkxkOFVQclZxKzBRS1p3cmd4TFVydG5lcG1HWHRNeEdZWlY3?=
 =?utf-8?B?enUxendLWFViZnM3cHRQRXE1OUtpZk9UWHFXQXVLOXZDajdzZldzMk5JUmVU?=
 =?utf-8?B?NTd2NHBmdHFaa3pHemNIQlV2R2pUOFBhZ1JiaHVFZkVNdWJhcWNuNWN4N1Jn?=
 =?utf-8?B?N3plMnlPUXFyY3pneDBwWlJxMWo1dU1zbDRTU3lqRUZjRkhjQWdncVBEdTVn?=
 =?utf-8?B?VXNFOVZQOFZWRVRLV0k2RE1YTGtZRUVzMFE3dDczQmhaai9rcTVUdkh0Nm5u?=
 =?utf-8?B?ZWYxQ1pEY2pRSEdIVnRuWmdXUFB3ZWNlWU1IOEtxSzJVU3J0aGRzRitodVJE?=
 =?utf-8?B?V282RkppUWFpMkRveU00VWRUYVlKeTF4WjJIdEZtWFRyQzdPVzN0VVlsbW05?=
 =?utf-8?B?QkFnRmtqNElvcjdGTk5UblBycEsrMDFTdUtiVzVVVUJteHJKQW8rNWFFMVBL?=
 =?utf-8?B?TG9ieHJ5UWJ2d3RsYWVqazFseXZJcWREQiswRmxqL0pyMlhXemRlR21ocXJ5?=
 =?utf-8?B?bHUrcytBQm5IRVlZMVBpeEUrc25qc1NuV094UmU3R25JQXU2Z3RsRUttbnAy?=
 =?utf-8?B?MHExQnF0WklWbnRmOEk1YnJzamxFbHRDV013UVJYY3NPdkFSSlNwUTJYanRC?=
 =?utf-8?B?UTJpTHJkTi9xOU9aQ1dpTVFlTnlzY1E3WkR0aWdKeTZXdWFJSUR1N2ptUDRs?=
 =?utf-8?B?OTljNFp6enJ5MmFlb3J4U0h6L29HdDN5V3RSMkdVZ2wxWXJvMnI3Sks2RmlG?=
 =?utf-8?B?QW5vOEo4Tm9MMDVnUGNnOHh1RXdoTmMyWkJ4V0NVZXRyV050ZTZwYUQ5ek5i?=
 =?utf-8?B?VyswbkxUSXJ6djZVREpkdVNmU0duMGh0L21VeHdWenNaNTdRT1ZPb1ptbW9Q?=
 =?utf-8?B?UlZ5S1FkS0NwMWJJdktLS2xpM2R6QThRTHZIUnN1eUUvU2pmMDZtMTI5MWRG?=
 =?utf-8?B?b3Bkd1VsbWp6Q0xSVTRHcVFFbzkxSUtTTDdpd1pTQmU0RmtPNXBrbkY1RVJl?=
 =?utf-8?B?VTFGUG94ZGJRb2pObFRyKzU5MytrVFdYWFZlVzZSRVZBSUNRSWtmNTJmdk9J?=
 =?utf-8?B?RjlEWUgyQ0YxOG1JTi94Z3ZJUHdlaDd2d2JoSEx5QjlZUUdtVVhOTERSSTA1?=
 =?utf-8?B?OE85TjZncU9FNktrRERPNWlCbmRqL0RCcjdpSjJUU0dzS0RteFRwQ0hOL01G?=
 =?utf-8?B?NWp2Z0ZINk9ZVWZwbXBTRW9kWDNyT2RFZllNSVhyY21HcmQvdEV6MHBMckJu?=
 =?utf-8?B?dldmTUZ0am95K1FLSDJVczIxWGQ4UDI2bG9XcVY3VjR4bEhhelc3R1ZPRUxJ?=
 =?utf-8?B?TzBYUUdpOE5aYjlveXlyWnNkUkplU2FYMDJxV05IaWxWVlNzTXJwMkc2dEtJ?=
 =?utf-8?B?VkVIYU9QN040dytaL1JYSUdqeGoySGZFMEhlK0xyYXQybGZXWEhZUFRqTVU4?=
 =?utf-8?B?VEx1cE5nN0ZQTFRRQnExbk5sL2xjcjNxc1ZWN21uL3NRYjc4MmYybmRtVmY2?=
 =?utf-8?B?ckxFWWVYSjVocE80WG1JMlQwZzlhQW1maUhJajRKTEVUc0tZRGs0UkdXSlRh?=
 =?utf-8?B?VzducjJ5M24vWnhXQlNXTWFoeEpBRnA3bElqY29OSnE1ekN5MXNLakdaazM1?=
 =?utf-8?B?WWpXaDJGcEd6N0ZHYUJ1SkRhOUhmbEhaVXJhb0RCcHZaUFJ0WkVVVDV5TmQv?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uhXKpWc7GAiUfURCTOBlhPQq+nxgNv/dmF/o+TChui5GE3Ip9z0DWYt6zaSKGL8d/QZ1oirIC1tizcx8oTxx84je3no360jwifKgXYBjfqvBnUM5GjBayQlFxohsfPIZgK2xHKxuQ1lC/HDw4e+bBLkiqopZ5dXf/+/00XgCNcjCzmtyitgXOnaD7XK4viLZScrpsDCaUhm8fpgJ+DXRf1D7EADgERIjaOnKCx7p+URpHKincFJnoPbLkfMT8LXDh+zRstf+huBNZzuHLa7v+XaWtCBpLAx/+lz0af7eilc8t0IifY51AXdQSyb2vnCJR/FB2BZ3LoNb8OZrpesCBBHxUjghO4xbLjCCXfDtew6DPiazfrmHWDDO9ggnqhqDvnG4IqFKgwF0ko1TfB6MvIi4j+xdc46JkL0vRdJnNRkY93eRmyb+jRDVZKquYzhCxYG8ztb3+COviJqmpU/ucbASDGUKlu+xeWhGAKXV9yWsFvS3/dUOf2+uNxRGY8AgZQOQGbDIvKyVX0STRkDyZIswCLLrAZEXrGd3+M6MvT4T6zuUMllmL0d90ZPaXQut/L/6YCf4zApjImjWqbHsV5iM83frkpu00K+cAsHx2/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61a0fe8-3d78-4578-7dfe-08de05efcec8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 22:21:05.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhsURiH1KM1N4ZDj82F0bY342nCxna2Q+fgheh5QWf8BiNfeVc7ABc/LJY4w+lOdS+p8Lfyo+D9CKyWQsaQjGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510070171
X-Authority-Analysis: v=2.4 cv=YO6SCBGx c=1 sm=1 tr=0 ts=68e5925a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=lifx2PBoZT2KrEN0QY8A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13625
X-Proofpoint-GUID: bnyWfNm2O3xW_5tW-5zOQdfhZ9hPMj5U
X-Proofpoint-ORIG-GUID: bnyWfNm2O3xW_5tW-5zOQdfhZ9hPMj5U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE2NyBTYWx0ZWRfXzdPT6Kd/QtQw
 81jqCTwcIt93EW1Fuuflla29GDV2n8fGGSGHrn6mcYFMwhoBDPzDt/Qo4jLiTM6O1IHKWjSC3C1
 af2RmHqe7jqeO6CJJf+QV0qeWp5vrTKpAhZLXHGIxBR0IqmyGVw6wvqXIzu5c8ZDbX2pAgyflwe
 N+4P82AKNrrnA9dZpiO6DJ48xAv2jVHcug5BenShPXLErrnQvdfA8WAW1RxOtsvTQkERbeGbp1r
 uZVvjee4x8gfD//D7BNhH/P54hVQUcnw7Tgqz3SPvfR2mTnU+sMErDyoAXeeJjnMxPr9eTw8IW1
 JdqyHZJPJnTqfg/c0UoNlKY67c5WBVAqeSQ1RaOZq9v7GBUOnyBZwV8nR2TnVD7Bq0P6E63Ye+c
 Cyp0d8BBsqEjCcr7JKyjS6fzw5Tjl34eB3kjQAIZd8z4N4+liPw=

On 07/10/2025 5:04 pm, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
>   RFC 8881 Section 2.10.6.1.3 says:
> 
>> On a per-request basis, the requester can choose to direct the
>> replier to cache the reply to all operations after the first
>> operation (SEQUENCE or CB_SEQUENCE) via the sa_cachethis or
>> csa_cachethis fields of the arguments to SEQUENCE or CB_SEQUENCE.
> 
> RFC 8881 Section 2.10.6.4 further says:
> 
>> If sa_cachethis or csa_cachethis is TRUE, then the replier MUST
>> cache a reply except if an error is returned by the SEQUENCE or
>> CB_SEQUENCE operation (see Section 2.10.6.1.2).
> 
> This suggests to me that the spec authors do not expect an NFSv4.1
> server implementation to ever cache the result of a SEQUENCE
> operation (except perhaps as part of a successful multi-operation
> COMPOUND).
> 
> NFSD attempts to cache the result of solo SEQUENCE operations,
> however. This is because the protocol does not permit servers to
> respond to a SEQUENCE with NFS4ERR_RETRY_UNCACHED_REP. If the server
> always caches solo SEQUENCE operations, then it never has occasion
> to return that status code.
> 
> However, clients use solo SEQUENCE to query the current status of a
> session slot. A cached reply will return stale information to the
> client, and could result in an infinite loop.
> 
> Change the check in nfsd4_
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/nfsd/xdr4.h | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index d1837a10b0c2..9619e78f0ed2 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -931,18 +931,19 @@ static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
>   }
>   
>   /*
> - * The session reply cache only needs to cache replies that the client
> - * actually asked us to.  But it's almost free for us to cache compounds
> - * consisting of only a SEQUENCE op, so we may as well cache those too.
> - * Also, the protocol doesn't give us a convenient response in the case
> - * of a replay of a solo SEQUENCE op that wasn't cached
> - * (RETRY_UNCACHED_REP can only be returned in the second op of a
> - * compound).
> + * Solo SEQUENCE operations are not supposed respect the setting in the

nit: perhaps -> not supposed to respect

cheers,
c.


> + * sa_cachethis field, since that field controls whether the operations
> + * /after/ the SEQUENCE are preserved in the slot reply cache. Because
> + * clients might use a solo SEQUENCE to query the current state of the
> + * session or slot, a cached reply would return stale data to the client.
> + *
> + * Therefore NFSD treats solo SEQUENCE as an uncached operation no matter
> + * how the sa_cachethis field is set.
>    */
>   static inline bool nfsd4_cache_this(struct nfsd4_compoundres *resp)
>   {
> -	return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS)
> -		|| nfsd4_is_solo_sequence(resp);
> +	return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS) &&
> +		!nfsd4_is_solo_sequence(resp);
>   }
>   
>   static inline bool nfsd4_last_compound_op(struct svc_rqst *rqstp)



