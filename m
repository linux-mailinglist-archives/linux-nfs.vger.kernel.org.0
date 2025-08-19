Return-Path: <linux-nfs+bounces-13774-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0818B2C873
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 17:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E8967A4844
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC95E253B40;
	Tue, 19 Aug 2025 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WxX8CBXV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yDsTmFv4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26DF1E9B1A
	for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617334; cv=fail; b=lSL6Ise3A07cEOZtSkhaWUvb/lSCNn+VhYOa3vdzzJlNv7NrKc05HpZqaktCt41724U3OwzrPUZkLqrXlCSEW0pTtfkOvGcIJ9dCzG9+TrNZI6hom9cf7plifWKm6rhEiATpGnI2lyfoUGEwB18jQn/5Cc2g9PCpAsKVb8kqDTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617334; c=relaxed/simple;
	bh=Xce+zaknIfAz1aLWr2Rx8x0Cep6eIfy/uJrK5Ts5RjY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BQofWaNv8a4FfCexAY8RIWlf/PgOHc7ZBkD9XqqhIktKC0XFg/Rgw44DCmWt1+0LIAuQXgIkRGDk0we1XI4mcnhUmxu5QEr2e8mZe2TNIy5mK/QwzSfphSAPSrl1blY7MVpS1vNxCsqrnJBOI2I0TB+hV7B4yAVK3Zub+9UZpzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WxX8CBXV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yDsTmFv4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JDiwMu029544;
	Tue, 19 Aug 2025 15:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1qcuIclAnB3+PItTt1QSMgchZB1JRDnnDM/yb94SDdg=; b=
	WxX8CBXVk6B/OGlKC6aM8A/QpHBFBnzh0u1MM3bFrjLIxM8coZH1m0PQcX+HOKiF
	OYG8r4PGJXydIad+gO2Ml/GbPb98j3ZTVbD3bFQX2FcCjR85cqfoe+htQCoObIIY
	ht21BByoSFzw2BrM77y09AbZgMIVapiy939u9k3gtTiH0wtYyXCIBfoXkIjBFUSj
	bpqilDo8hxeHNRm2DTCz48QBdaD+Bwgmrhdd/6gL+PW+XcyRryBm9hJkduN1NbAv
	pyTfuRyigiM7nKnR0YhHBgxuHP1Z6f8QKUyg15VWXNqTDVfoRgJND0E0pe6+Aj6n
	qKJhWEn029hJxhSPnY+30A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jjhwwkq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 15:28:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JFBX8R003410;
	Tue, 19 Aug 2025 15:28:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jgeakfft-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 15:28:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sr7FwuFrrJXe6sSd/2c3UYCcsqv3ZVfznIYxIiwrippVV+ZNInJbv6MoUz/o5AedQP/kkM0ou5eMImJQ7+JIskXkx2tMcHBI4uDGJBWuwoQ8YNoqk6GI/xvETDV/FENv09LqntqwY3JZIAqGDH89aHrvUkkHLnVfqUS9aESNz9ES7Qasoh0VFFPFKM1MSSrK1U4SQ1NUK669H3U3ticefSChyGXAOwqEKVbbyB5ByRlUICabAan98dPbJ2lOIVp31Exz8rndmbnpx5ybxLXzrbKjeY4PC1j4KAEdGVhz5VfQu6WoHKssiMb7Fw8qoIQVD2tea0VW9fZBtqwJ+nWKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qcuIclAnB3+PItTt1QSMgchZB1JRDnnDM/yb94SDdg=;
 b=YE5JA135MtsEO4UupLB56lO6NI3p9hFFJUDX+BEdEIjSWoP6WobNQYqZXcW1wUkXAgH3VVA7USYL6QAG46O0FmTis04Se4VH1aCPL17Sag+ZnQVn8zem/J/7JGNTFVIw3uCDxKAX4V6zIJFeXIDT9bEwimM528lSM0WzmNvN4EqLflPsTbpVutx9bQu7wJa7md/9uP1So8TKnRz31IYOZDP/q+4AKpUIlXWbrFhcfEyqHcJCCjKhbOGi4Vb4ediBJ0TX5Et48dwpqjgYkDs9Vl+S0QtC1iHC5zPXyfPipPmPVPcaTDaXa/fPw4om5RrbsADUzzIlpovkgXkk7esK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qcuIclAnB3+PItTt1QSMgchZB1JRDnnDM/yb94SDdg=;
 b=yDsTmFv4hrvl2+ozuV0UR65q0dy+6dOHk2BmT6h0FNc/Ubw8plqiq8Ry/6WAKbtpESuyb3AQcx+6z5irUX4tEY7/meToHZjEQNGAVqKb6ZoKUl8UvdjgbnqcUVxu0ZpY0hiRVHeXJC8ZI5DON1QhvRf0zhrGFQHKMoRty9YxfNU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 15:28:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9031.024; Tue, 19 Aug 2025
 15:28:33 +0000
Message-ID: <bcf2689f-2aa3-4e6c-be55-7ee42763d0b0@oracle.com>
Date: Tue, 19 Aug 2025 11:28:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfsd: unregister with rpcbind when deleting a
 transport
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, neil@brown.name, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <20250818182557.11259-1-okorniev@redhat.com>
 <c4722c18-57a5-49b5-818b-1e46cb4733b8@oracle.com>
 <CAN-5tyHincZxuNL3z5QDZ8Sv1F=fqT1b-3nUt2DVvFhr0MePRw@mail.gmail.com>
 <CACSpFtB3WDtWL7sv3FEyBh7UYiYSwiQwDr42vDck_nVQB_Z2ww@mail.gmail.com>
 <ff15eec1-3827-4057-a116-1f1bbc9bc8fd@oracle.com>
 <CAN-5tyFhDq1Po4ekSYFVkhWTO42CAZJMYWf6GTGQVGo2ndUD4Q@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyFhDq1Po4ekSYFVkhWTO42CAZJMYWf6GTGQVGo2ndUD4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:610:50::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f2fb43-dd4e-4a60-0acc-08dddf350e90
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?c3pHM3pZck8xZGluL3kzRkxHeWkvSExCRERLOG5mVHE3c1VHdU9NTU5jSnh4?=
 =?utf-8?B?NnZNYWZ0UkNibVBEVjg2VmZmSUpHY1ZSaXNIbEprbVc5OXpMa3BUVG1vVzBH?=
 =?utf-8?B?ZEkxUlVpeUtRZExTYXpsOHYzb0U0NFgzUm9NYmxKZHlJU1cvNzEzL3pLSGVK?=
 =?utf-8?B?RFI0VkJBZHZHZzQyZzZPT3VFMmtVZGcrNUwrZFJYTnNiVmJ4RlpINkxCTHJG?=
 =?utf-8?B?NnBxcVM4T2o5SURZVkI2dVRvNGNFZENZdEJVYm5UNFNKVnRtdXB1WlM0QUNN?=
 =?utf-8?B?VTRQandBRDZjd3lxazR4dThqMGVCeWRKTlZBdW5TekVtb2VNWStmQkJ4Z1BZ?=
 =?utf-8?B?WW9HRE5tdFlUVkZyRndLYUxkZnliQkdjQTZyMWxFdmpVWWl6M2NneTh4QXNk?=
 =?utf-8?B?YVQwZ1Z0ZzhXa2R0WVZTMUtSMUtFL1VpRnhOV0ZDNWRJUmliUEZsTFh0MTl3?=
 =?utf-8?B?cVdLUFJKMXFPMFBiNTdwcmRxTHpQaVpZTExwdTh6NW5VMTdkeW1kcjJrV1N0?=
 =?utf-8?B?VVZ2c3IvV05lbDh0NTQ2d3RMSTdGYkttRU1MRENldEZHaTdNeFZHNHpHRGs3?=
 =?utf-8?B?MG1hK3BZcFRtaFJMWGI4aGRBMDIyQkpFTWk1ZVJ4ZHV5U1h4NUxaTVFiUWJI?=
 =?utf-8?B?ZWFiYXZhNkZHMlg0bkVHUjlwV0pYaTNEalRZNTZMdVI3L25Sek5UeXdaVjRx?=
 =?utf-8?B?d3RNSDkwcTJ3djBteWVkU3pYVTA4ZXZubkloak1JeVF2MFNiRENBY0p4U3B0?=
 =?utf-8?B?NUpkcXo3Tk9qV2o2Z2V5N254OGtDMmlaWDFvT2NCK20rREdwWDB4R2c3elA5?=
 =?utf-8?B?ZWNjYVlkNnpjbFJSdk96K1NhVzZiVVk0WkM4aDNIMTVGMFp6OHRIczZkaG1p?=
 =?utf-8?B?SVViVnhXZEltUFFpUlEzZWdLVkRKWnA0bjY2YkVnamFmREdqY3pkUnJTaWxj?=
 =?utf-8?B?RnQvUDZOY0lQeTU5b1lUUE9pcVExVHV4NjEzU2xQTGRtRHd1THpHb2M2dlkz?=
 =?utf-8?B?anY3OVg3U2hLRXgwT2lvWDNlQ0g5aXRKWUYwbVFIWHdXdTJ1MW4rS0dabVlH?=
 =?utf-8?B?Zkx5ekpXbHlFanZ4Q0xTU2dDS1BCMHZqSXpWWTVMalR1UFNQWXR2VVNGM3o5?=
 =?utf-8?B?UEZQRFNpRWROSmMrZVB2SWhkMkFmN2poazRra1M0QVR6YUpZV3Iza2N6dnhJ?=
 =?utf-8?B?ODBmRXhRb3JmVTZJRXVYNnh5bE1CQkhSUnZSUElZQTdxSktYcU54U1lQVkow?=
 =?utf-8?B?VHl3R0taR2UyalR4bTg4VDExdit4Z0plSFJsclBob2E0NEc3UUdTTmdmWnlT?=
 =?utf-8?B?ZU01OU9TUFFKNU15U2lFWFh6Vkx0aG5DS3NzRjJNVXU3N1FIMTlnVjE0QnlJ?=
 =?utf-8?B?TTh3VDVqc0p5VHFRTUY4bnM5cUh2MHNNZ1ZTQS9ZR0VMeEZYeEJjaWtsVmRK?=
 =?utf-8?B?VzErN0JTT2hLdCtDRmNhY1VSUjJOdkQrcFVUS0h5OVBlUncxUU5Ga3NIaEhM?=
 =?utf-8?B?RlNnSThvUlVTOVJVZGRDbDF5QVU5Nm9NQ3NkY01ha0QycFpFeTM1QVVmajVw?=
 =?utf-8?B?MEVnVXpzaUY1bnlVU1QvWnpuZ3hFbHhRKzdzVUZTTGdOVFdsTFBBS0FrWXBl?=
 =?utf-8?B?b2lkbGhpWGNmUWR1TnAxd0FHS3R2STIxSmEyT01zejFKL00ydXI3WEJmUUJP?=
 =?utf-8?B?bksxNVBjY2k4SUZONkpFM0FFcmh2Vkl1dFR5WUtUKzdBNzFVNEVGTWJJNWdE?=
 =?utf-8?B?MTB4UW10dkM4bFhQSHplNldtVmRTaDdTeVoyT1AzbTlUaXFkOE1MU2tMNmdw?=
 =?utf-8?B?OUpzaWx4UGgwRjZKMEc3WUNZSk54a2RSRUhJZnZsNDhYZ3lxRk9rZ2hZYzZU?=
 =?utf-8?B?S3FpdmFCTmVaTWFodVpHc1hEdmZmWmNpc2xFOUJncGNzZG8rYUFuQ3gzbnlV?=
 =?utf-8?Q?xGGqZlpZOmM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZmRQQnY0ZCtRVW12bXgrcERhYkxIRnRXT0JXbVQ3WjdMNVBHYzJTQW9qTUJK?=
 =?utf-8?B?YmJ5U2tmREpSUFFYeXcrbld4TVNSMngxK2pVRjJTTUdTb2ozc3MxUXJrdzcw?=
 =?utf-8?B?bTFOL21uMHJWeFUxUHA0RXJ1R3QrcExQM1p5cnFDblk0cFAwNm4wemlHWmpy?=
 =?utf-8?B?bWs0WC9pVXFGM2pmN2pCUHRnR1pMbnI2bnhFUWJiOHF5bndweGRoQlk1OWli?=
 =?utf-8?B?V1J1bm9JQVpVMGcxNTRLRHdtbngxQWtnV1huQkNoM2JPbXlycnQ5UWNTeE1E?=
 =?utf-8?B?U3dnRkVLNE85OXl6ZFY4NlRuMm5VR0JZaktDdGNISlFNVlhrT2dmZk1jWXFm?=
 =?utf-8?B?cXVUQjUzUjR0M0FMUEJaOUZYTTFIQ29xeWNyNzJ5eVdQejNkQ2c1OGNOcE5T?=
 =?utf-8?B?ME5JTjRFcFM0UTBjcTA5YUpNd0xyOFNIOXUrY05iYVRjYm9zb1Q2NEJDTGo2?=
 =?utf-8?B?ZHdvN3JmdXd4bnBJck9nV0E3WjgwcmdtTHpCSkZpTWRxQW5sbWl5UE4vQTQ2?=
 =?utf-8?B?ZGNPWGVIM0FDT29FM3dmK1NVYXAvcG1oek4zQXd4RlV5c25xamY5VGt4dTNY?=
 =?utf-8?B?bUlod01LLzl5Z0JwZnlDbDZweUpOempsNDBOY3Q3ZG5CcU8xU0xFaUlYUHZp?=
 =?utf-8?B?S0kzSThOa1pPK2k4UlcwYmJqc1hIS29MT0ZjRzk3eEZnd0F0bFNBaXYrN2d2?=
 =?utf-8?B?ZU9SbGdYZGNkL0p6SEFNUnJhU0Z1ekNmVVFHK0RnSDJISXUzUlRWTXdkYTJC?=
 =?utf-8?B?SE9TQmc2TmNFUXZLaUxSNnFYRWdQcXpwWmtuUjhZRldKQXZMSStpVnRUb3BD?=
 =?utf-8?B?WmRvUWEzcmhuaSs1VzhNalpjbDNvSU5Sd1VPNTY4NytwSWcvRjQyWXUvWmxB?=
 =?utf-8?B?YWpFY09xQ0wxOFlYOEtrSEg0ZFpXTER1Y2x2NElDcFZOZzBmM05FUG4wUGhn?=
 =?utf-8?B?bFlLdVpid0pRSUd6a1l0R3hCdXFFTWhVT0p0TEFqbTZWRGFUK2pOL0lpS1Rt?=
 =?utf-8?B?STVhd1Y2a3NqYjlQTEZBVHN3L2FNR3hRZjJ6bm84NmdoQXR4aFlYY0RZVzgy?=
 =?utf-8?B?Mm5ScDMyUHFzV0hIRFVoenJWTWluOElFSUZFRzJrRWk1R0w4Y25vdFM3Vy9F?=
 =?utf-8?B?cGpXSXpIbERQN0pDRjZnTjJyTHVtRjcxRGt1d3hZMVF2QjlnY1FwMkRVOGEz?=
 =?utf-8?B?d1h2dndvc3Q1RlZ1VkE0WGFoV3VhT2ZaZ0N1WWdLYWtkTkdWZ1JtRUpTWEgv?=
 =?utf-8?B?WjVnczRiTGdWcUc0MklGQkpGTDRuZlM4MlQ4TWtKL2RlSlgzeUsvNm9wYjFv?=
 =?utf-8?B?ckhadXYrNGtCTUpWbTRTeit1NmxLTklrbXMxNHhxcEU3Q29tZ09SZnRnNStS?=
 =?utf-8?B?ayswMExBOTQzT25xT2xoWWY2WGZuemJWZ2hxNlZUMzhQSldBQ3BhVHN5Vnl2?=
 =?utf-8?B?c1dXUEl4WVp6cWZyaXRVbmx0WExGYllqbTcwMGkrOFE4NkRQbTFqZGRLZ3lO?=
 =?utf-8?B?TXlaWlFab2JyY0VMeWdRZUtGVTNJUys4Y0NvV01zOWlWSWxMd0tDYkRZck5K?=
 =?utf-8?B?OUFxeHJjN0NFYXdSR1NGWmNEeHE5Z2tweUlMcUZGZlk3SXY3U0JJZHFKWk9n?=
 =?utf-8?B?ME5TamV3YUdZcXJiSHV6TEMzY29HSG1XU3ZIbE4zUGZrRDlGQzdDRE9JamY5?=
 =?utf-8?B?c0pnNlZrckxnM1M5NkRxTXRWa3RaVEp4aDl4R1J6MXBQY1lxalBvUUdxWk9k?=
 =?utf-8?B?Y0tvZUpKSlNHS0tHdHAyaFhIcEgrWDMxQXpDT2ZrUmRvb0p1ZGtYdlcyRVlF?=
 =?utf-8?B?QTFWU05vUDFHZWR4UjdaakRVZmVzUXZSbHRjWkpqU0l6MWVYQjcxYVg3SzMw?=
 =?utf-8?B?RFhqT0U1WjVIR1BXdm9GQmp4V1ordlludjN5MllYUWQ5VkN2ODhwdzNEckV5?=
 =?utf-8?B?allJNWZpRVNSUWgxanF6Z0M1cXdNbG1SbnZsTU5PMWJ0UTlzbEd1ZGIvRW5t?=
 =?utf-8?B?bk9mQ2xmUklKakZhTnZOY2g2NnhtcFlEWE5DQ0djSUc2U3Rna3V0aU5BNGRV?=
 =?utf-8?B?SHhuUzhBTTFFV2pLeVVVVHBmc3V6MXJSR0d4djJnbE9Pcmd6YmYvRTFFUkNv?=
 =?utf-8?Q?rdVTZWeLwB3iy534dO+iVItsa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JBaaul80OQHqpY1vKRk26UiyEbDs/a93MLFrXIcOrQ/kVQTTR9ayLm3xZ6sCRX3iOnxt8S66Ug6oQZfupLQFMQ6C8uZmBTcvmlpc9VGPCzoylwr4ZjHRi1sscNJXroGZRJrlUI75TObjVftZ0IotNIXQcvCTsnfKv0pzUqEqcbt5HmTOTLBrQJcBVuuI93wGKBD/sSwQXUdjjV6pUy7LjkcmMBgCPOz6eVmESQeZ+xofr5BOoRj1c8ePOzUP6IYMdyerQMiIx2eujxntq8YGzH3ePX4TdKZPHmF/VdSr7jO7TIKNNCuNQqilN/kGWwhCht0BeLdtF2pwsc5GaLjJ6aVDEceRu19PFnJWhVQ7zDccZhZOFbgeY+elTscrqHnmDda99pIuSLCVX00gkkgJ7yGuCBoSaW8rEjxv91wSASWdjVb8NlEqbaovORJjn0fhcyNiut4kAkMTDIskvgYRVJ2a3iXHni5UyoD+nDUNqoeQsH9CLKxFaRmA79gFEPR/gvFLCMuXeXpWJxlIdxaOo+6I5O34CCsebh1i45bmcyczNbcU3Ka00FobTN9dSjhIWiPU8iG1T9a7vTm+2Suri2wf9pAZkwBmAWgVpQtU4es=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f2fb43-dd4e-4a60-0acc-08dddf350e90
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 15:28:32.9101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LG+4w1DmT5euv2Ybo6M6odBkNJNQKxqVPF2Saz1iN68Ft5GrCF36uavfBTcptvGc5n+ezXFPK9XzJlciFhgmPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508190144
X-Proofpoint-GUID: A59jBrQdPJJPw1KZuc7LL5VEtXRIwBVX
X-Proofpoint-ORIG-GUID: A59jBrQdPJJPw1KZuc7LL5VEtXRIwBVX
X-Authority-Analysis: v=2.4 cv=G4wcE8k5 c=1 sm=1 tr=0 ts=68a4982a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=wr8nl769gEKkzlwkG8oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE0NCBTYWx0ZWRfXwjDHrAvRrOzb
 I0EdJLbiNTdZLkLYknkaIh7XzbUDo+qJhEwtr8zwAfKOSqU334RygxV9Jysj8SKpSJXa8rm8+8n
 LRr+ykwHj0THgZuIt+E/kDJqVtLynTV41SHm9zPjNeLP8eekRp5E7OSKnSvm3Lv0TI6sZ9UjjvD
 v/GzQO6OpXdI90aYdMd8Nkkpy9MtGD24Xwx99aFOjwIAd6S1ZmYosIwhz3mdOaBOUrR1+yVHLrc
 HYhRO0yJn7mYObFh6DqcAJJ0V0LmrHEt9xpvvNLTYSdp+JNVdZcxg/hR4nn8gH2OJ/nUaaZpeOr
 nAUPTSrZwJ/VipBgQv99SkrgLtAA6+zCGVP2/sF81UnXKbJivvsmdIOlq6p0UuQWfpghVV3JYAh
 28IGCXU7EL9tYYlOF1yjFh6flL9NCWPgcpSjB0oO4nNH5TgoZG7L8DSp7WHOgJvtM1EUlWbk

On 8/19/25 11:14 AM, Olga Kornievskaia wrote:
> On Mon, Aug 18, 2025 at 3:36 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 8/18/25 3:04 PM, Olga Kornievskaia wrote:
>>> On Mon, Aug 18, 2025 at 2:55 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>
>>>> On Mon, Aug 18, 2025 at 2:48 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>
>>>>> Hi Olga -
>>>>>
>>>>> On 8/18/25 2:25 PM, Olga Kornievskaia wrote:
>>>>>> When a listener is added, a part of creation of transport also registers
>>>>>> program/port with rpcbind. However, when the listener is removed,
>>>>>> while transport goes away, rpcbind still has the entry for that
>>>>>> port/type.
>>>>>>
>>>>>> When deleting the transport, unregister with rpcbind when appropriate.
>>>>>
>>>>> The patch description needs to explain why this is needed. Did you
>>>>> mention to me there was a crash or other malfunction?
>>>>
>>>> Malfunction is that nfsdctl removed a listener (nfsdctl listener
>>>> -udp::2049)  but rpcinfo query still shows it (rpcinfo -p |grep -w
>>>> nfs).
>>>>
>>>>>> Fixes: d093c9089260 ("nfsd: fix management of listener transports")
>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>>> ---
>>>>>>  net/sunrpc/svc_xprt.c | 17 +++++++++++++++++
>>>>>>  1 file changed, 17 insertions(+)
>>>>>>
>>>>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>>>>> index 8b1837228799..223737fac95d 100644
>>>>>> --- a/net/sunrpc/svc_xprt.c
>>>>>> +++ b/net/sunrpc/svc_xprt.c
>>>>>> @@ -1014,6 +1014,23 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
>>>>>>       struct svc_serv *serv = xprt->xpt_server;
>>>>>>       struct svc_deferred_req *dr;
>>>>>>
>>>>>> +     /* unregister with rpcbind for when transport type is TCP or UDP.
>>>>>> +      * Only TCP and RDMA sockets are marked as LISTENER sockets, so
>>>>>> +      * check for UDP separately.
>>>>>> +      */
>>>>>> +     if ((test_bit(XPT_LISTENER, &xprt->xpt_flags) &&
>>>>>> +         xprt->xpt_class->xcl_ident != XPRT_TRANSPORT_RDMA) ||
>>>>>> +         xprt->xpt_class->xcl_ident == XPRT_TRANSPORT_UDP) {
>>>>>
>>>>> Now I thought that UDP also had a rpcbind registration ... ?
>>>>
>>>> Correct.
>>>>
>>>>> So I don't
>>>>> quite understand why gating the unregistration is necessary.
>>>>
>>>> We are sending unregister for when the transport xprt is of type
>>>> LISTENER (which covers TCP but not UDP) so to also send unregister for
>>>> UDP we need to check for it separately. RDMA listener transport is
>>>> also marked as listener but we do not want to trigger unregister here
>>>> because rpcbind knows nothing about rdma type.
>>
>> rpcbind is supposed to know about the "rdma" and "rdma6" netids. The
>> convention though is not to register them. Registering those transports
>> should work just fine.
> 
> Question is: should nfsd have been registering rdma with rpcbind as well?

Solaris doesn't register it's RDMA services, so I didn't implement it
for Linux. There's no reason we couldn't, though. But probably not worth
spending time on if there isn't a practical need for it.


> __svc_rpcb_register4() takes in: program (i'm assuming nfs, acl, etc),
> version, protocol, and port.  Protocol is supposed to be a number
> (below). I don't see how "rdma" can be specified as a protocol/type.
>         switch (protocol) {
>         case IPPROTO_UDP:
>                 netid = RPCBIND_NETID_UDP;
>                 break;
>         case IPPROTO_TCP:
>                 netid = RPCBIND_NETID_TCP;
>                 break;
>         default:
>                 return -ENOPROTOOPT;
> 
> We can register nfs, tcp, port 20049 but nothing that would indicate
> that it's rdma. I have grepped thru the rpcbind source code and didn't
> find occurrences of rdma.
> 
> 
>>>> Transports are not necessarily of listener type and thus we don't want
>>>> to trigger rpcbind unregister for that.
>>
>> Ah. Maybe svc_delete_xprt() is not the right place for unregistration.
>>
>> The "listener" check here doesn't seem like the correct approach, but
>> I don't know enough about how UDP set-up works to understand how that
>> transport is registered.
>>
>> A xpo_register and a xpo_unregister method can be added to the
>> svc_xprt_ops structure to partially handle the differences. The question
>> is where should those methods be called?
>>
>>
>>> I still feel that unregistering "all" with rpcbind in nfsctl after we
>>> call svc_xprt_destroy_all() seems cleaner (single call vs a call per
>>> registered transport). But this approach would go for when listeners
>>> are allowed to be deleted while the server is running. Perhaps both
>>> patches can be considered for inclusion.
>>
>> You and Jeff both seem to want to punt on this, but...
>>
>> People will see that a transport can be removed, but having to shut down
>> the whole NFS service to do that seems... unexpected and rather useless.
>> At the very least, it would indicate to me as a sysadmin that the
>> "remove transport" feature is not finished, and is thus unusable in its
>> current form.
>>
>> An alternative is to simply disable the "remove transport" API until it
>> can be implemented correctly.
>>
>>
>>>>>> +             struct svc_sock *svsk = container_of(xprt, struct svc_sock,
>>>>>> +                                                  sk_xprt);
>>>>>> +             struct socket *sock = svsk->sk_sock;
>>>>>> +
>>>>>> +             if (svc_register(serv, xprt->xpt_net, sock->sk->sk_family,
>>>>>> +                              sock->sk->sk_protocol, 0) < 0)
>>>>>> +                     pr_warn("failed to unregister %s with rpcbind\n",
>>>>>> +                             xprt->xpt_class->xcl_name);
>>>>>> +     }
>>>>>> +
>>>>>>       if (test_and_set_bit(XPT_DEAD, &xprt->xpt_flags))
>>>>>>               return;
>>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Chuck Lever
>>>>>
>>>>
>>>
>>
>>
>> --
>> Chuck Lever


-- 
Chuck Lever

