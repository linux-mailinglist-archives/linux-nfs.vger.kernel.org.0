Return-Path: <linux-nfs+bounces-15872-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 301CBC29129
	for <lists+linux-nfs@lfdr.de>; Sun, 02 Nov 2025 16:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E25C14E293D
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Nov 2025 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FC0221DB5;
	Sun,  2 Nov 2025 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YDdwlV7w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GWXHL360"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F82224B1F
	for <linux-nfs@vger.kernel.org>; Sun,  2 Nov 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762098105; cv=fail; b=nyG5r5xhyX3u6KEOBHX8BQbcln04uHaaj0sVkwb3FScj+E1mvoR8qcxO2ArREYfp0luraD3xDg9+XpjhUcYcawebffKmENPo360sl3yc0GYz9ojdM/MiEC6IKAGV0IW0csLLCq2PksNP8ubDnwPXVprrEgmWY22Yma+IDQLZ2zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762098105; c=relaxed/simple;
	bh=RIDHt6lzXPemGIkKRCadvJFsvLjvAhcgQnOdBx2qyUI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GK+/QFBhJktCcqf7zT3r9kidaFS0M9Ja1VuHMnrb3e77JNt94eLwtW60rWUqQluuqeFb+fxJwgi1zNUR4oeuNsmtucJ7i1u/UCLO9sdwGWXf2mCZArkXOACHWTugtumWTaht9x/5p1mNYNJdhsG8apQklFddjmXhtpedUeoX/0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YDdwlV7w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GWXHL360; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2Ff4jk005385;
	Sun, 2 Nov 2025 15:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OZnFF/S6YDnmhIDlFqlWdoyHh/5TeWuo/wNIm5LnzW8=; b=
	YDdwlV7wbJTVzQPTyHkolH7a1DJKPngomKP0K9k0Y3CKYBAaoJbfsX96guGt0XHy
	wY72GhHEnQUZDBDj1Xc18A8/2Tei+7PLP25zb+1W7WcCQ9XVnlz7PsOJz39YEIe5
	v1NUIlhjUO/4SDdBQN6oCP0hiaDCyspYnDUFlTuA/Eombk/JehajrEchAqhjTeJy
	8x8eyEoylmzO5nsGYyX0IcQQkAWHG2HudaYJO8UFo+gb7rYoKFWaGKR9AfzEInWk
	vv7r/EDqGWc+Rfeg9rDdLTGzqofAdpLAlzI0EkX8OTywAelYDxdx2V/o/h1H9vFq
	PdB8adC4O5qaWvFJR7UCRg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6a4rr00q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Nov 2025 15:41:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2BcEAR039842;
	Sun, 2 Nov 2025 15:41:06 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nh1nyw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Nov 2025 15:41:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wj/cI8jYdl777lwPbfj77J+0LwxR39qbCrBtddBIZe/fswtX2SaNSivd0XE7cQAzxt7m8+NmX5lri6b57kU5iJiBq4rT3DQyf3jxPYYO2F6W+omigYC/SX+6vu+D95v8R7nQofuGpBI6J3CJWgGk2DzfZ22YzFj2RO90kbER15E/go70QRcDZwTg4qcMpXTqpK/h1y3Y5poqFZNAqKlxi0T758CMP+VVC0k9Cj3A1P7lNV1/YUJm4WOX4Dn9gG9dNv7BnyuTj6RB5RawyzYur6XSKplqOpLp3gifLp55BOz2IFYZamkPVEYLMNRBmopwr5H3rdP+uwaug3w/qW/C7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZnFF/S6YDnmhIDlFqlWdoyHh/5TeWuo/wNIm5LnzW8=;
 b=LlmX+zfY8DbPgzA1JK25xh7bJZ9AEsuJ59SrYLRWxjV7FFuVwxxyx7QyhJi0EBRnuWGsRLHmtWX9waMgzmUOCMZFaWObrgJhzG4PPQ4OcvoXx/9SdY3A0NhApXOVnKIJffmalGaSuMis9nRIQ6cG84plb/yF/1Z4vzbEC1DL11UcwdeQtGWIdnEbynGG7HxiAI3bjJ+ZpRrxA012b75az84ijCDpVn9CYjV1wTjoWquEjLeAILU+LCD0RvIO8jrBqu9EFis3UXJWKfkMKA5UVTDF/QyABtLUxgl4fNkC9WC59dWJlC2nLFx1G4r7j8m0KUEAxA4OaVvtKZ+I0nvhIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZnFF/S6YDnmhIDlFqlWdoyHh/5TeWuo/wNIm5LnzW8=;
 b=GWXHL360ju8CUPFAU/NKC4m+3CVbPZUVAMw8S7Ng5C6IDWhRdEQTGt3Ku13lEZ2H4Ku5jJGWjfEzUoIKSP/30/kdGWlKfNHHPACWheA2QXFb5Ja9BrwJGcxfMOQASqF05NwWHA/aUS1Yi2hQKfoL+33swCYiGQ3kBVK/6bwUQ+o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7554.namprd10.prod.outlook.com (2603:10b6:806:379::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 15:41:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Sun, 2 Nov 2025
 15:40:56 +0000
Message-ID: <b8a55017-5bff-49f0-a2bc-6bea6df7d658@oracle.com>
Date: Sun, 2 Nov 2025 10:40:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] NFSD: Add trace point for SCSI fencing operation.
To: Dai Ngo <dai.ngo@oracle.com>, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
References: <20251101185220.663905-1-dai.ngo@oracle.com>
 <20251101185220.663905-4-dai.ngo@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251101185220.663905-4-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:610:59::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ebe5d5-c546-46a3-745e-08de1a263699
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SXl2Rjd0aGtvVnhNZmZSNm1kSXBlWllIb2RxeXRCUEI0WUdwLzMvUEgwUWFx?=
 =?utf-8?B?Q1JWRUNTS05XT3NWbDhnWE1lS1dDVFB4czcza0dYSzZ5b3h4L1pJWkJlOHFk?=
 =?utf-8?B?cWZMbU5EZnNjM2JtQ1gvZTNPd1hlNTE2U2FMbDFwKzJZL2p0ZmRwWFRjVGpv?=
 =?utf-8?B?OEhuam1JRWhBeC93Nm9uZ1dKVCswUUZPaC9BRkRZRjJqR21zMlV0K1J3OHJX?=
 =?utf-8?B?TzBUN1dobUtoMlhzVDl4OG01Qk0yVkZZbis0b3ZuaHl2aS9iS0JsZUtCTmJv?=
 =?utf-8?B?RElWNUNHWjliQ3EvZEdqbDFVZFd4c0RYOHhsKzZpNTh1TzdvQ3cxT2VsY1J1?=
 =?utf-8?B?T2JncUpUZjFuSmZ0cTE5cjFZdVQrdGJsck1BSWxOM1RKa3RSTnJmSVMwWGow?=
 =?utf-8?B?VTZQLzBpMmVjNkc5c2dteEJFYzE1QWtFRmZ1MmEvOFV0ZlYrZjVGZEdTZkhY?=
 =?utf-8?B?cTVKMHR1K0ViY3poZnR5OFd5c2dRQzB2bmFXbjVPMkRJVlIzR29USUVzQmxo?=
 =?utf-8?B?MEh6Sndya3lmdnUraWgrb0FXMUFncllhTGsvc0lrVmxRUndhZ1VNS2ttNkVm?=
 =?utf-8?B?ODNQbXdSVmRnRUFERVJlMGZ5SGVtMVFGYld0aEFQanV6ckpIa3B4bmwybUFK?=
 =?utf-8?B?RHZjU0c1N01GNjU3ZWZPNHpUUkVZRWI4ZmtjVVFMSEg3K3Y5ZE1wT2ZJQ0lq?=
 =?utf-8?B?bmFiRk1qUythU3hlazFVc0owOEtmanpvNDN2Szg1VmJHcVdYSUdDRTF1L25t?=
 =?utf-8?B?YWozTGllTk96QkxPNDJjSTlkRXB1VzduR1JpYmNDd04wdzNhNEJNQThteXJo?=
 =?utf-8?B?NnUwS1Z6aGVnL3NWNlZWQ3N4bUlpTnhlSkZGUWw0bm9EbnZaYWo0dFIvWHB5?=
 =?utf-8?B?Mk5PODJCZWEzbjQxb0U3M1FIZkJjMVAweHR2ZWdkNGdjbFdMZkhlM0pqNGgv?=
 =?utf-8?B?L1R1ZERRWXhua3FlSXNQdmIzKzJMMkFtY3dISlRDV0cwZkZEVmVnTVZoV0V1?=
 =?utf-8?B?NjNmS2sycVJBZGpES1U0S3VVeGduemU5K3RBRi90OWRMMTZ4NE8wSjI2eVNH?=
 =?utf-8?B?d2s4KzBWaGs0L2xLYzFrSnFYY3R1ZmQ3OWtISlZHYURqRFZLZXNPcEl3a3hx?=
 =?utf-8?B?VDVtTmdpb1puTGtnZ09SdzFWQjZ2eEc3Q2hnTGJhd0k3UGlmUExpM1BtYXFs?=
 =?utf-8?B?T0l4bjVWU0FqMm1MaWsxUlhoMVl0Y1QvTkhTTGo5clZGVVRKMHVrSjFMVnE2?=
 =?utf-8?B?T3hNVlRKYSt0RzFZOUdwT2hWTjRmcTUrVGIyV3BKbDJwZ2RRd3VIYzdrUURa?=
 =?utf-8?B?NkthYkd0Z3BIMWs5N1Q5QnZJbFdldlRlM20xcU1aL0NMKzhoZEhxangrNWVY?=
 =?utf-8?B?bFc1TTZWNEJKR05weGdldll0VUk3WlF0L0UvOWZPbWlzSlgxMTBPaTd1MUdQ?=
 =?utf-8?B?TjhpN2N2SHMxaTNVbE5YdTcxL0V6RS8vRXFVbmN5cnc2VDMxU1N3WFFlUUJI?=
 =?utf-8?B?WHNZNzN6a2cySm11TTZ4MlB4UmJGUmxJRExqK01JQU0yNUl4Zk54bWF6SXI0?=
 =?utf-8?B?OGJsNlRvajcxZVZYTUUxY0ExbElPZFFYQkZRSHB5K3BTR04vNy9hQVU1UjN3?=
 =?utf-8?B?MmwvV1NEWElPZ1ZPcEFFRmk3b2J1bm12UGJ6OE1kS0RtZmFYcnl0QjIxQ3Ba?=
 =?utf-8?B?Ui9MSFM4bnhlaVZ1QlIrYWlKaU1XSWRTZHdIS1I5RS91cDRxbHQzQ3lzQlFw?=
 =?utf-8?B?VE53U1R2Q2xoVTQvcWZOV1RSSlJjU3M0ODJDNlU1aGdKa3ovbThwRksvZUdJ?=
 =?utf-8?B?aXhZSVYwbHJTRjA3L1c2U3JZU0hucTdXTG9PV3YrcE40Y2hOdnlYZTV5NE5N?=
 =?utf-8?B?QUhJWlRBd091ckhmTVBHYnhiN0RJenR5aVIyNXBvRGp2d0VLNExJaGZ4bUx4?=
 =?utf-8?Q?YIrW5pKXqcVyyFyhDsH4sqVB0hkryYyV?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eUUrWkwwL2FKTVRsOVRsa0RwWDU4QjJZdXdsTmZVNlo5SzFWU1NIR1RtRjdo?=
 =?utf-8?B?azFMZUhkZzh1cTREVXI2MlYyT1BsVmFuTTFwY0phcEZHNEViY0Vjcm9LeGJs?=
 =?utf-8?B?V3FWclVWVEpQb3FMT0lCaVFLVzdEZ3RUUGFwMy9aMlpsSWkwTG1qNmRreHVB?=
 =?utf-8?B?M1hZRVh3dmI5akR0eERRTnRTQnllYkt1Yzg4OWJ0cEZIRkhFdktiSVJ2d3hX?=
 =?utf-8?B?bWhXbExIWnZPdTg2Rm1SNmlIdVFiK0RKV3lFZ1FNN3ZOMlZVYko0UHZHbllI?=
 =?utf-8?B?MjRyZWh6SCtoVi9lSkpQNFJWOUFLdytxbUhjV0VnbW9RUTRqWXIzVG9abGtk?=
 =?utf-8?B?LzJCYXVPaHgvR2JUZm1QZ1pvc2tHNFhMUGVtd3VDbmYwUjRkSHJQYjlLc25v?=
 =?utf-8?B?dUZqR1VMWHJWUnp5QU9kc092ZEVVSGQxNjJYR1ZaSlV4ZlJKUEV6VWdCZHZH?=
 =?utf-8?B?M0RzTGlmNC9MTFJ5Z2NEY0lzMkxvTmluRDVCbFRLNUtkVmVGbjlwMUcreVJ0?=
 =?utf-8?B?b3ZkUWNOVFRNR2t2dm1NY0N6U2oydk5hcTBsSnpYQTNNS2FsZHpNbkhIME5F?=
 =?utf-8?B?R2hRRmsrOStMWExpWGxZb2RDaEVwanhGMmhvaS9JU0lac0phVUhVT0N2NFlM?=
 =?utf-8?B?U2VBbTM1NGgxSTVpVEJzT0ZSUHpERDFPcm9ZUlJjdVVydGZmUGJWQXJ1a1RP?=
 =?utf-8?B?dUZtU1NldGwzZUpXVUxVYXJlcXdqMkhrcklGeHhLajN0SVRYbUU5dHNjU3Bt?=
 =?utf-8?B?b00wUXVndWtSV2JwbmtCRzFDSFAwc09lZmJNK3Y5b2NpS0UyZ0ovVGFDK3Qz?=
 =?utf-8?B?blZQWXpUT2dtTVdpeVYzRDRGWGVzZFA3OUtncVorRnZpdDJEWkVoWHkvQXdQ?=
 =?utf-8?B?V3hTemd5OXI2c2tTdmpGTFRMeVJkQjBDOC8ydk0zOTVySW01NDAwUEFYczN2?=
 =?utf-8?B?dGxOZXpLZDdoOHNoMUZ0MEFTWnlxR2dOQld6OVBxY1U0aGpXUkE4SkU3K1VN?=
 =?utf-8?B?MFR3cmc3QzloSjZ0NWNETFZsdGMzNVpSVWg5RnZPbWNLVExOUm52akJYb1Ja?=
 =?utf-8?B?a3RTcm0vSDdsM1Y5Wk4rd0ZBSjhTQ3BGditFRERta3NPTCs4SFBVWDZVODgy?=
 =?utf-8?B?bVlYTXp6YjljcnVnSDZwb0ROeUFoZmlINlRwaUlrUTdwaS92bVVkSXNHb2Za?=
 =?utf-8?B?YTRHRWQwbVoyVWZ5Qk9qS3FNanpqckEyTTZ1SVN4QmZpSVExRE82VGdRbFZs?=
 =?utf-8?B?RkdlamU3SXg4cGZoakhJRWNxWVdxbUdPT2xGVHE5bEdSZWJFYW1oaDJnS21a?=
 =?utf-8?B?Ylo4UW5zUHI2N3YxeW1HWEh4akQwbU1tSEd0Rk9QZXdFYmhXNzZwWTB4aW5p?=
 =?utf-8?B?UlhuZHU5N3ptOGpZL25DVFdsN1ZpM0diWmtnTXBhbzlaNm5pd2ptb2FHMW1W?=
 =?utf-8?B?bDBOdmoxdytERHhXK0Nab2lTYVhpdFZXK3hHNE1aK2R2RVpZOVc4WnVnWWI4?=
 =?utf-8?B?eWJIQ0RNWkU2dzhZdGZQcmZTc1FTWnJWSzdJOC9XYjJDaW1QbXVwQXVKRlFu?=
 =?utf-8?B?anlVTnJGR1pJdmdCN0Q0TTBwV2h2NjRnejRaWjVhVUsxME1NcG1jT1dLWXgz?=
 =?utf-8?B?KzBZNGEvSHVvcmswMnNmemJrUmpYK01XdTZ0V0ljanpDN0NuS1Y5VTkxRDJY?=
 =?utf-8?B?M3NSYUlIWFQ2NkhheEtSR2UwRXZHd3NOMm9nTlVLenN2cXRtZEt1R2hZa08y?=
 =?utf-8?B?OVl4aGFabjNkUWNYVXIvYitQSnZDR1Ixa0JodlRzU1lDUFFqNjFPRnJUb25r?=
 =?utf-8?B?cWFPZTFNZkhMNHFzeVM0WW0wSi9ySFViWC9nT1lPUFBzVkcwRzN6QXBiNjJt?=
 =?utf-8?B?ZmJWYjExVkdmdGVWWnkyZ1hTTXBWdnpCbU5MTmgySTRWZmJzZXFrK291Ui9s?=
 =?utf-8?B?TW9UNFU0dzg2Zzd4bzBIWWt1bEQ0ekFEUURMc2VKcFdtZ01zVmJjQStiN0RU?=
 =?utf-8?B?RkdFRmFCY3NpTGlBeDNnS2g5cnZMSFkwVFdNeGxGdUdxbXFYeXVKclZFalVN?=
 =?utf-8?B?WjBHTExVRnpkeGRXVHhxYUxRbkIzZEZ0cElzYUhZRks0MUVjSjVpNG1OVjMw?=
 =?utf-8?Q?tWpC0JGIWJZ5skhaa0qqz/Lsa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/dEoUho3lDaqJpoReeR0MDbWiwqVL+d5G4ckIhWvv+z957GuHYwzM1sdHrJDhdSdRuw/7ULd8cJg9XFlBAiFZSRWxdLAsPUMH2HeLtOQR+VK73pwrhOJ3wZm/oMBcHv8aYlSMuvSKxrQNCxI9Afk0B5OP0s/qgALBWVDihQkKCCSzEx9v3b0yflzv87tiT+HWTsCXvaZAnyNhts9KPCLAnzLgDBGE3PQj2kAUE14QEnkP6I67finM9n1u+rZ2T1YP/o7prIDJuoMnqwfAyD3AgaGegZtgZLFEG4nK6anl/zd5EdF+0YyzlLO6ffpHtDh2cL+mNCj+zBcFZWAQbBctUUt6S2M0OqttgEjF5W5nrLmuR3kBYcccg8R0NLomzwwzDiaLTrTVo8Uv4qYm7DtDy1b9Zb+HoS+g/22Zxh5KOVfiWe5erhFdjZXVsyCjIqA3sSKpOWrY9LS3LIAK4RJP8dNW7ujPPzsRiFDwwRcBVOgdv62WPWnICVhudbmwkvjGwomAAsWeC8JdXwFBaX2rg8zD4M+ftl+7No5lulu6B4n8QNwiLbAYPoRn7wcW34AoLaa1/1JuIlu4oGLmkq3alShGJSVelqnqexYVDf7YlQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ebe5d5-c546-46a3-745e-08de1a263699
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 15:40:56.1814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUSxk4SLtxUPtaKGWFqnMFwRabLFKpIvOYNGInoxz8rNH6mKh9VngkstMq78yrHbB2P3cV95WbXqzCqmyoKLqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511020145
X-Proofpoint-GUID: xh3Onvnmvk2vuhPjlzTEFzzbb7xdBied
X-Authority-Analysis: v=2.4 cv=f49FxeyM c=1 sm=1 tr=0 ts=69077b93 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-lSghJI8lMy_-ThVvWQA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12124
X-Proofpoint-ORIG-GUID: xh3Onvnmvk2vuhPjlzTEFzzbb7xdBied
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDE0NSBTYWx0ZWRfX75JmtyYkzx6w
 QM1LIIF7BSc3WTLkcpcTsytEnozapF6993LgnT5sso1qkwpBKlUBxuHM3Av/W7+1oc3zdhWGXRq
 2+K5ja2PwMEDLPi64TW/5hf9jbuj2JQrCvTJ22EUG2I/cMtlXIn6BnEJ8f13c48e7dO1FedAj/k
 WUBk0RIJpoG+AfS8pp70YO/IYlUiV/9RDRmGHCuroCfmKAC/GzqQSXnOwnKo56QOyR4zJO33/EG
 33NA4nGEzOsDSirJZMze+Tox2ZiDBaTShvhP3PNTuKqigi1RRMZeVnf5MekBqStQLT7HMWLix6T
 FWsMsbV3C6/2tNWQbnpxy864uBmtCrB2lcsk7xRSF5hvn4W6R8Kml9Jj7xMfK5cG7KzHr9fAsLB
 AD8X+O49HFKvD4YSeaY0xr7foCZVSHcxIaKN8zP1fSn5ZRQRPgQ=

On 11/1/25 2:51 PM, Dai Ngo wrote:
> +	TP_STRUCT__entry(
> +		__string(dev, dev)
> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
> +		__field(u32, error)
> +	),
> +	TP_fast_assign(
> +		memcpy(__entry->addr, &clp->cl_addr,
> +			sizeof(struct sockaddr_in6));
> +		__assign_str(dev);
> +		__entry->error = error;
> +	),
> +	TP_printk("client=%pISpc dev=%s error=%d",
> +		__entry->addr,
> +		__get_str(dev),
> +		__entry->error
> +	)

Have a look at the nfsd_cs_slot_class event class (fs/nfsd/trace.h) to
see how to use the trace subsystem's native sockaddr handling.

Do you want to record anything else here? The cl_boot/cl_id, perhaps? I
guess there's no XID available... but is there a relevant state ID?

-- 
Chuck Lever

