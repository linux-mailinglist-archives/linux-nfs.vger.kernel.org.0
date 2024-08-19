Return-Path: <linux-nfs+bounces-5474-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2C695788A
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2024 01:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938D42836AD
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2024 23:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB65815958E;
	Mon, 19 Aug 2024 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c2/Djk/O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HXfs9KVI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C468A3C6BA;
	Mon, 19 Aug 2024 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724109394; cv=fail; b=b11GERSAh9za23qThATT36W2Nb1nx1ueBLEAmmylytZMcscNuOKxE1tLPWZGkzAS4KtVfOQocZOXD/9MsjYkY6LsJk2GBCc8pq3tZ3m+qJgVi7u08cJpfTOiYsuBLNvzd52i9chBHFsQ4PGyg0hpjdB0ltcqapPRxWsnNebP1bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724109394; c=relaxed/simple;
	bh=Ai0m3rIXulet1JcMeF1XzGHLtAR+Uq/m9H+MZLdSC5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gZUqsTyo/Xq1VdQ7mCsmyM4ycad/2tTfJw5BfMjzuPqhv9Q54miFfAHm4DyopRptrMw0eL3OUVwtum5IYl73LgTP8YXhibAtbXayzt/snzKYdFEQ5jMd1WnyBE32CzbtDZyAlm9FagcMthd7lk4TF8NsK1OKsZf8jTmUCOgbZ8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c2/Djk/O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HXfs9KVI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JLKGwL014717;
	Mon, 19 Aug 2024 23:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=Ai0m3rIXulet1JcMeF1XzGHLtAR+Uq/m9H+MZLdSC
	5I=; b=c2/Djk/OVUQJ4jwnKC4lCklAb6157bkgw/1+ZV2+O6hBqR9GYedi56xhj
	c5oCI4h5kX6VCjdiq1FXLzv8QXDBDIj9W8CyoECzjKGqKCmVRgGa846yOQdZ1Rwd
	go8ntjrNTJirJfiwi/EsCNYe0HcZFIcVvdm9vcxLHN42ZrSgr+zcRXKmDbWPPEco
	6lKlvJd0sMKo/WN5jbLA9FAtmp1K0Kz08Ks5Ztq/cem5TEStDFnVIu1VfthWPypD
	j48j/a4TGbJOwGv3PAOMwp3eWga3laC0qSqNUPAwYH06sYuORj2xAM6dZTLizmK+
	UoKdxHH6zHd+9Uitee91TbkVS4dkg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6gbswr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 23:16:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JMqmbD020022;
	Mon, 19 Aug 2024 23:16:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 414d71cnyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 23:16:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWOWyhn/rOGCg78e+VqT9fxG/cWz475+esJHs/Gr1/QF1ViAl+wlS37kbjBzTunhxzBF9DZqyDQr5zM9CIsU9no0ufFssFw/YxcUw3QuzaToQiNCIjnsXUKuZhcEZV5oPNdOLR1deOEEFe5z8+i5mIFBfcZBdX/JZwfG4eWA/5xVoT5QaSboU05b5CnHog35dfMCE3fNcGfaIlTk9URlLD9KRkPjPLL6diMYHODr64ndYDyT0oUJvqfV6wYIV6a74y5mp+J87F6goraCvx9CoPXeQ4gw8+aHkDvABPP/AEo5fIu5wS3vrivCGw4BiKRFwDb8rBp+1aANlmuk692vUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai0m3rIXulet1JcMeF1XzGHLtAR+Uq/m9H+MZLdSC5I=;
 b=kwWzUD92+1ztIhHhq3ptnOLfV10ovE66qMapJo3Bw6aZSiTE2njqQE8oQGmT4CH1J79QuSMN8yNHU8pfU7sBtYQpwJPHQIlWvTJnjOepiA91hBt2wJTget8cnLFppTX3y6XKjgQnFqQWJzMbOtNqhs6AQiulTn0+biF7FlBQFIAVBjhJPO7u661oPrLSk6oeJB1CkIzA+nFh5Tkmctk6nbqTPwGvfaDJc0eWBPEjESnLUP4fOcluQ6BDlY8sa6Sn/05LJrcGncxbW4vS5nJZTmTg/8SNqY4u8XCGFLEfTj2YyvdybT1lLiSOmXpPhqflGsKHL3jHdZIVcXlQMW40bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai0m3rIXulet1JcMeF1XzGHLtAR+Uq/m9H+MZLdSC5I=;
 b=HXfs9KVI1dGgl7GxD78nV/6/7fojEpleTL23QM3zQRFywJokyvTzpnZEz6TPPM6/hO49bsXNIUXhBz2jSamj6iK9+Yqduy+XqDpDwTmeVb5DYv8PjfFqjH4x1BInIyJ4JtZZMPrHmizxH9YHo1mSt+0/SE6B1PlBPPsz88QIVQE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6297.namprd10.prod.outlook.com (2603:10b6:303:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Mon, 19 Aug
 2024 23:16:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 23:16:21 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>, Dai Ngo <dai.ngo@oracle.com>,
        Olga
 Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Trond
 Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Tom Haynes
	<loghyr@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] nfsd: bring in support for delstid draft XDR encoding
Thread-Topic: [PATCH 1/3] nfsd: bring in support for delstid draft XDR
 encoding
Thread-Index:
 AQHa79nI8OZMU5h3VEKSAxjt3QjJK7IttuIAgADDuYCAABsBAIAAAXqAgABrOYCAAAP5AIAANZEA
Date: Mon, 19 Aug 2024 23:16:21 +0000
Message-ID: <B222389A-F6FA-4090-B420-A9DDCD454139@oracle.com>
References: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>
 <20240816-delstid-v1-1-c221c3dc14cd@kernel.org>
 <172402584064.6062.2891331764461009092@noble.neil.brown.name>
 <6c5af6011ea9adfd45abe4b5252af7319a3dbc94.camel@kernel.org>
 <E7E5447E-AD50-437D-8069-C77FFF516DCE@oracle.com>
 <f0ac4b0489da5f6198cb7c70f312e2889e97ea4e.camel@kernel.org>
 <3DB9A299-B55F-45BB-8B28-65F44F14F6A2@oracle.com>
 <b7d76076fe593b0c24ce983db9a0dbacc9fbfa5d.camel@kernel.org>
In-Reply-To: <b7d76076fe593b0c24ce983db9a0dbacc9fbfa5d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6297:EE_
x-ms-office365-filtering-correlation-id: 39ac7948-9a46-4537-a994-08dcc0a4eff3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WlhBUHlFNkplRkVkZnVXdm1yU0tXWlUrdCswblI2VnFGa29paWtWM1Y1Tm5K?=
 =?utf-8?B?YzVJcWNpN0IweVR5ZnRzeDdDVVgwaC9VRTlHaEZJenhoM0t1b3YxNXNFRTh4?=
 =?utf-8?B?cXl1OUJ1ZDQrMDJSRkpTNll5eTRLaHYvZFNjbDZHK3BhU1ZQR1lQckUyakdp?=
 =?utf-8?B?TVFVczR2NmJmb21MRzlJK015Z1o1SGxackxVQWhzZURLaGsvU0FmQUIzY2Y4?=
 =?utf-8?B?eGhEMFJuUjRRRS9xVU8vOTlFblJjb3d5Q1FFYi9tcDM4Y2xPSEtzZ1lEWjNB?=
 =?utf-8?B?Q2VhRGp2Z0tkM2lWZ0pBallLa0xScmZ2WnY5dDJGYlNXVkdVdVhYQ21GSkQv?=
 =?utf-8?B?SEp6OThhK3BCS3NSS21iZ3hvVC9QOW9IaVVKV3NjQjB5NTl1bENhR2Z3Qkhh?=
 =?utf-8?B?aC9ZNkQ0U0E2ZEJOWXA1UWFvWjVmMlYyMXV2TXpNeUlqN3RLcWJYeHFTWmZG?=
 =?utf-8?B?R3VxRUtabW5iR2dHMW9UbTNFekw3M2JsaXVaZ0RQdm1CUjBDdGpZdHhCS1pB?=
 =?utf-8?B?d1B2RkNzLzdtcS9LYm1neW1UTmdBM0ZaWWp2YnZ2a2xxNGJrcVFpUFhOMjVC?=
 =?utf-8?B?WWlVTFk2eGNDNnpFelo3dWJ6d1ZjV0I4UWdrblNESlZmWFVNdW0zdjVLQURH?=
 =?utf-8?B?dTYyd01QTnp5Rm9OY1BpS3VKdk8zb1JmUTE3SGVyRlJsam15QWxXaTBNdEpu?=
 =?utf-8?B?VENma3k0R3BlaDNYQnlWN2tHWjRUNlcwZlFtOGl3aStjeHlyM3RXdFpoWm53?=
 =?utf-8?B?Qm9QZkFmU3lLK3Z4YThVdDUxL1I5dEdZcC9uSXI5L09oK0hyaXU0MFU1Qi9x?=
 =?utf-8?B?Q2xCSG1hbkxmNmhKbE4rMUhlbGRCRVZuT3B4dWl2YTk4dUlaejNQRlJEMnBp?=
 =?utf-8?B?YWd0WE54UllsdDRDS1pIYnhsSUhzNWpxeDB6cU5sOHZFSnRoMGRZcDVpR1dW?=
 =?utf-8?B?Y3prbzZpMWN4ZXM5RUhMQzFyZnZ1NFpMOStheVJVbVY2Z2tjd2V6Y29RVjNZ?=
 =?utf-8?B?alVHYjQyT2FDOWdGZkc4N2dpMk94OHFadWNVVFBRdk5vWFhuWHA0YjdCK1k2?=
 =?utf-8?B?aXpJWnhTS2RJRXdPNWhkdnI1TkUxQWZPcmplTGJLc1QrMzlsYUZwSmNSamhP?=
 =?utf-8?B?cFJ2Qm55cTBJa2NBN1ByYW9HaGluekJwT3J3UVZNUnpWZ3QzVDVZUTRkVzhD?=
 =?utf-8?B?eHJwT0pFTitpUEx3ZS9vei9PdFRZenhsK1lJb3kzMER3Q0NVL2tkRHdRM1Bq?=
 =?utf-8?B?NlI0Q0lwSjF0UEV3OTYyZ3VicjZGSXBZcWs2d1pGZkdQMXZ4d2hDSVdaODZY?=
 =?utf-8?B?VWdKdWliRHBhMlZRclNkOVZOWDFMbWpOY25ldXBZVHFJRzBGanNUSy9hV3d5?=
 =?utf-8?B?VlhOM1hVbnlYNWxCaWxGOXloNFJMM1JzbURQc29QT1dvdjdGZkMvWXpuaWNS?=
 =?utf-8?B?SVBBMUU4Z2laN3gzd2ZiSWk0WndXdGZ4YkZ3S0xOcXVCWEZ1dXhET2tSbG5P?=
 =?utf-8?B?R2dWRkxFSFlhUDV3U3NqcjM4Tzc5MG5KcWlteXR3MWRCSmRpd1F2N0VRbU5y?=
 =?utf-8?B?TGpmcm9ESjlDcnl2NmZreUt6cWhuRVQ1Uys5cklqb0VTalZXTXRvMWpBczha?=
 =?utf-8?B?WkV5SFk4NWVmRE1SdWcyMW5sd28vaU9uZHJIMUIyRDhvV3IvTXhxT1c2anJD?=
 =?utf-8?B?OWc5MTZseDk2RExPY1FDcTBIRHFUVFlnUFJWcWpTdDlheUxWS09vUENlbGNo?=
 =?utf-8?B?ZW9vc2Z1cHlFU3VpLzBvdk1wVS8rbTRaMEhYdmhLdDZKYmhQRnJnQ0VZMUsy?=
 =?utf-8?B?dC9FN3I3L2hPQVZQd283T2xLbUYvQmR5NHh5cUtrQXBXK0VaNDRMQ3hDQ0lx?=
 =?utf-8?B?bklybkZoTkk2eWYyOGRPTlFSVzdBRXI2eVVWcEFqbFFXQkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZS9WaVZvUXZSZ3M2QUJCazZVR1pnVE1IanMxc281ekZ5YTlxaVZPZDdsN0V3?=
 =?utf-8?B?RENudEpud1huVExuUTlOMjBKaWVPUTAySDlkcmtabVZRZUFycldCTkM5OGkr?=
 =?utf-8?B?bUdWYjUwUW1lSzJmVFhUSkg5SnFSS3RGbVlya3FsMTl4TUpFR2wrVFhuaVJt?=
 =?utf-8?B?T001UFVFSUhCbUtVQURKVTZ6VEFBakY2eVA2L1M0cGlEOXpLN3JwZmV5MmxU?=
 =?utf-8?B?Sk9RYzNJVGFUNk81cDYzcFIzbWNHdk1kVVRseDRvZUMyUVR1L3B0SVB2SHZ6?=
 =?utf-8?B?SXNQYlF4Nk8rMmtlN1haMUNEcnFMUFliWlg0a2k4WlNKOWYxaGQ4ZlgvOG5x?=
 =?utf-8?B?bDFidjR1czZqSW9yV1dTakt4c1VFUXRndzk5V21aVkM3ekpieGZGOHFmd2pk?=
 =?utf-8?B?SVM2ZmwrZ2UxREFqMzNpVFVjcWRSc0M3Ty91SjNIeitvVzRhek5oRlI2Qm5h?=
 =?utf-8?B?UnRXTzNCRkVhZjErb21KYkxwWGorSjUxTEdQaVRwV0cvL2VSei9ocmc1dGdN?=
 =?utf-8?B?NktzUnlCZ2MxVEJhY0ZKMDVjMllJVEwvWktLcjE3QkgvOFExQzVyYmpiL1pU?=
 =?utf-8?B?dWNBQmFFUjI4UExGK0Fmdmk3SWlSNzYzdVloa2ZEUGtmRjhDYmhYYS9Ta2M4?=
 =?utf-8?B?d3Z1enhWc29GQUdxanhqUFZHZlJZYTd4UFVNTWQ0dnNCYzBnY2k5OGdJYW1a?=
 =?utf-8?B?a3o1RlQvb0JxNkpWZHVVZHloV0hOeTBWWjlyOGF1QjhxZkp2R3A2ZDExUmp0?=
 =?utf-8?B?UUQxWS81OWZ4S3ZGVGlDdVJnTGxaNi9FOEtFY21GQjRncTlrK1p6R05yejdV?=
 =?utf-8?B?RGY0akgwYmh5cFMxbzNTTzQrN0YrQmt5aGdYSndZeUtSWFl1dTBkNXV5WFNH?=
 =?utf-8?B?S3RZc1l0aUM3VjNLeHB0V2xWRGM4U1NGeTBqT0ZsUW1obzVIM3dBNGhuM0da?=
 =?utf-8?B?QmF6VkVMcmJsUnFCa010aytWRnFiS0IrOVcreWNSTGU5RmE2SFgyWkZmTFlY?=
 =?utf-8?B?SDRzVVNoU2czQWhwZW5rVmc0eENGUmZqUlhiWU9OQnBNRS9nOWJUWHZ4ZENJ?=
 =?utf-8?B?OUowald5ZXdqbGJVaW1HMXpqVWdrK20yU2V6N2lvNmJlWjAxQ2FLMnJVTHB5?=
 =?utf-8?B?WndtUjV0M0VhcVh2T1llYTZ3eVpFb1RINGdQbkk0L1k4bzc1a1pDRTdUQ3lw?=
 =?utf-8?B?WWZ3NVRINE5LdkE0UUZoL2ptT0dqYjJwTkVaM0dkOFpqUzFtVzF3ZmF4RHJO?=
 =?utf-8?B?TytSOUlvNlNpZ3VsaTFGbk95eUx0SEJCT28rZThDOWc2ZjFlREF1KzIvT2pm?=
 =?utf-8?B?UlJuaW5wR2h4NkJtWjB0RkczbkVxTHlPV2NOTU95Y3hqN0xSU2lQdEZodmZz?=
 =?utf-8?B?L1g0RnY4SCs5RlpIM2dtOVVSRkgzN2dtZTloWUxUY2dOZEFCNTlKTTF4elhU?=
 =?utf-8?B?NDdWb01GRDJONXRqNnZIaTczWmlkR1o4d3BLR1cyaHQzT0ZLR21OeHJrZkxj?=
 =?utf-8?B?dHNHbGRhM0FnTW1SbWd4UU1aaW5vQ0JYWlJERGcxbyt4TUFpblF3S1RCWE9O?=
 =?utf-8?B?MmxLbmJZcUlBbnJiejVCYnpmRWJQNXNRZk1XeWhDVmU0M0krSkpWVU03MWxm?=
 =?utf-8?B?c3NYWDI5ZmtMRzlEVU5oUFlCWXZFUUErUUlXR09lMk4zQ3RuekkvcFFETGlZ?=
 =?utf-8?B?NDNTV2lmb1ZhcURKZGo2Sm9sOXVRMWR3NHh3THJLZEJMNWt3MXU3ZHR4K2NI?=
 =?utf-8?B?dkVYS1JKOHgxTVRpdmlkM1VqektMT09XNncvV1lYMHkvMlhLeitCampUZjEz?=
 =?utf-8?B?L3NTdWRsMEZVWGcwS0lWNG1FamxUL1h5ZElGaFAwelR3S2M2UktNMHcySTdw?=
 =?utf-8?B?clZwd2wvUmxUVEgwWFJzQUVNcnZkTUM0bnRsVGkyTXpHNE9hbDNXekZYaWJU?=
 =?utf-8?B?OFRLYlZXQW9xRVNMN2RSK3lRci85SlBBbVgrN3hmZG1QUnJMODVsTytPZ1ht?=
 =?utf-8?B?RC9sdjlvZUt5SlhLeFltbmxjQkh5TFA4bUtFYTBWaXNYaFg1eElyZnQzVkp3?=
 =?utf-8?B?STlSSHhQbU1ST0tEciszd2crN3RSeU05cCt4UjZibWtmT3kyY0FVNUhaK3FD?=
 =?utf-8?B?dnB4RmJxMjdwUVplakJlWXdKaXkxY24vTGl2SzZVUUdJWVRNRlVYbm91cWow?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B31415FFBBC68D41A1864B5B90E95B6B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xmQz9X6DgWq/X0LttYMro8jZrMemfnHdU2eWlQuqoc54ecark5g26nRtHKtGqrW1P65V+1bfjoxPMWZzQb6RPQIkL76pPbs8FPnnCG8gZ3HWMrKvAwDHy/r+SuyWOyq4jMzNEQuJDw+tAG6vRs4DTKKuN/VYX2LRAdq7HK7XGgNsVITrPYsO9wZsfiXQSac9dSftW7u1J+YSoVSH0W1pUOKR0ka1FU67EcxpSHlTuvQ/l8gHwhSkaXhJkNM3VDmhiVwuEiVIbUxeBg1AcmPwrpI+CvZfRfD2nkQcACrnCtobn1zrlUpPaqbyKVB2tBK5IM03lURXxThCjzqG7UZhjZ3vTr+vYPoVJwMHbeg4IpxXz/hiwgQvrDrMFAWtdSVDilBzbbSwTnlLbh9Ol14RUAnnwQQrnAUo6ckZFLcIkIHe6vwSrWYenmO0hKT+zghAZwFM/iVfAo2I9TGwJyF9XRRc7d+KPqECYP5fwYnXS+P2IfKNwvcG2d1Bf0lPhe+PD6Bu3hN3FeEGX2mYaIqUqGDm7Ngj2J+k380z+n+sTB50VAnw2PZiQGpw2yEW2u4ehJa+gLjLGM9F+2xYBY6GFq+L/vUChxN7xbRKm0T1gD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ac7948-9a46-4537-a994-08dcc0a4eff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 23:16:21.2106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9ouvuHttX8ro9SBnrbrro1Vep3JEo2h0rRe1RHiwc65X05imbKs4OcK+4lroIBx3O75zaI7ZJspvytxnuMC1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=869 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408190155
X-Proofpoint-ORIG-GUID: oYTKobDhB-7HsSVmBBsC42s9R9PsRdON
X-Proofpoint-GUID: oYTKobDhB-7HsSVmBBsC42s9R9PsRdON

DQoNCj4gT24gQXVnIDE5LCAyMDI0LCBhdCA0OjA04oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCAyMDI0LTA4LTE5IGF0IDE5OjUwICsw
MDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEF1ZyAxOSwgMjAy
NCwgYXQgOToyNuKAr0FNLCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KPj4+IHdy
b3RlOg0KPj4+IA0KPj4+IEknbSBwbGF5aW5nIHdpdGggdGhlIG5ldyB2ZXJzaW9uIG5vdyBhbmQg
aXQgc2VlbXMgdG8gYmUgbXVjaA0KPj4+IGltcHJvdmVkLg0KPj4+IE9ubHkgdHdvIHJlYWwgYnVn
cyBJJ3ZlIGhpdCBhdCB0aGlzIHBvaW50Og0KPj4+IA0KPj4+IDEvIFNvbWUgb2YgdGhlIHN0cnVj
dCBzcGVjaWZpY2F0aW9ucyBuZWVkIHRvIGJlIHR5cGVkZWZzIGFzIHdlbGwuDQo+Pj4gRm9yDQo+
Pj4gaW5zdGFuY2UsIHRoZSBkZWxzdGlkIGRyYWZ0IHJlZmVycyB0byAibmZzdGltZTQiLCBidXQg
dGhlDQo+Pj4gYXV0b2dlbmVyYXRlZA0KPj4+IHN0cnVjdCBkZWZpbml0aW9uIGRvZXNuJ3QgaGF2
ZSB0aGUgdHlwZWRlZiBmb3IgaXQuIEl0IG1heSBiZSBiZXN0DQo+Pj4gdG8NCj4+PiBqdXN0IGFk
ZCB0eXBlZGVmcyBmb3IgYWxsIG9mIHRoZXNlIHNvcnRzIG9mIHN0cnVjdHMuDQo+PiANCj4+IFdo
YXQncyB0aGUgc3BlY2lmaWMgc3ltcHRvbT8gSSd2ZSBiZWVuIGFibGUgdG8gY2F0ZW5hdGUgbmZz
NF8xLngNCj4+IGFuZCBkZWxzdGlkLngsIHhkcmdlbiBidWlsZHMgdGhlIGhlYWRlciBhbmQgc291
cmNlIHdpdGhvdXQgdG9zc2luZw0KPj4gYW55IGV4Y2VwdGlvbnMsIGFuZCBnY2MgY29tcGlsZXMg
aXQgd2l0aG91dCBjb21wbGFpbnQuDQo+PiANCj4gDQo+IA0KPiBCYXNpY2FsbHksIEkgd2FzIGdl
dHRpbmcgdGhpcyB3aGVuIEknZCBjb252ZXJ0IG5mczRfMS54IHRvIGEgaGVhZGVyOg0KPiANCj4g
c3RydWN0IG5mc3RpbWU0IHsNCj4gICAgICAgIGludDY0X3Qgc2Vjb25kczsNCj4gICAgICAgIHVp
bnQzMl90IG5zZWNvbmRzOw0KPiB9Ow0KPiANCj4gLi4uYnV0IHRoZSBkZWxzdGlkIGhlYWRlciBo
YXMgdGhlc2U6DQo+IA0KPiB0eXBlZGVmIG5mc3RpbWU0IGZhdHRyNF90aW1lX2RlbGVnX2FjY2Vz
czsNCj4gDQo+IHR5cGVkZWYgbmZzdGltZTQgZmF0dHI0X3RpbWVfZGVsZWdfbW9kaWZ5Ow0KPiAN
Cj4gDQo+IC4uLm5vdGhpbmcgZGVmaW5lZCBuZnN0aW1lNCBpbiB0aGlzIGNhc2UuDQo+IA0KPj4g
QUZBSUNULCB4ZHJnZW4gd2lsbCBhZGQgInN0cnVjdCIgd2hlcmUgaXQncyBuZWNlc3NhcnkuDQo+
PiANCj4+IEkndmUgYmVlbiBzcXVpcnJlbGx5IGFib3V0IHVzaW5nICJ0eXBlZGVmIiB0b28gb2Z0
ZW4gYmVjYXVzZQ0KPj4gdGhlIExpbnV4IGtlcm5lbCdzIGNvZGluZyBzdHlsZSBpcyB0byBhdm9p
ZCBDIHR5cGVkZWZzIGZvcg0KPj4gc2hvcnRoYW5kIHN0cnVjdHVyZSBuYW1lcy4NCj4+IA0KPiAN
Cj4gT2gsIG9rLiBJIGRpZG4ndCBjb25jYXRlbmF0ZSB0aGUgZmlsZXMgbGlrZSB5b3UgZGlkIGFu
ZCBqdXN0IGdlbmVyYXRlZA0KPiB0aGUgZGVsc3RpZCBmaWxlcyBzZXBhcmF0ZWx5IGZyb20gdGhl
IG5mczRfMSBvbmVzLiBJIGd1ZXNzIHRoYXQgdGhyb3dzDQo+IG9mZiB0aGUgZGVwZW5kZW5jeSB0
cmFja2luZyB0aGF0IHlvdSdyZSBkb2luZyBoZXJlIGZvciB0eXBlZGVmcy4NCg0KY2F0J2luZyB0
aGUgdHdvIGZpbGVzIHRvZ2V0aGVyIGlzIHRoZSBzcGVjLXJlY29tbWVuZGVkIGFwcHJvYWNoLA0K
YnV0IGl0IGFzc3VtZXMgeW91J3JlIGdlbmVyYXRpbmcgdGhlIHdob2xlIHByb3RvY29sIGF0IG9u
Y2UuDQpIZXJlIGl0IHdhcyBqdXN0IGEgcXVpY2sgYW5kIGRpcnR5IHdheSBmb3IgbWUgdG8gYnVp
bGQgYQ0KcmVwcm9kdWNlci4NCg0KRm9yIGFuIGluaXRpYWwgZnMvbmZzZC9uZnM0XzEueCBmaWxl
LCBJIHJlY29tbWVuZCBzdGFydGluZyB3aXRoDQpkZWxzdGlkLngsIGFuZCB0aGVuIGFkZCB0aGUg
cGllY2VzIG9mIHRoZSBORlN2NF8xIFhEUiB1bnRpbA0KeGRyZ2VuIGFuZCBnY2MgY2FuIG1ha2Ug
cHJvcGVyIHNlbnNlIG9mIGl0Lg0KDQpJIGNhbiB0YWtlIGEgc3RhYiBhdCB0aGF0IGlmIHlvdSBs
aWtlLCBhbmQgc2VuZCB5b3Ugc29tZXRoaW5nDQp0b21vcnJvdz8NCg0KDQpTaWRlYmFyOiBXZSBj
b3VsZCBnbyB3aXRoIGFsbCB0eXBlZGVmcyBmb3Igc3RydWN0cywgdW5pb25zLCBhbmQNCmVudW1z
LiBUaGF0IHdvdWxkIG1ha2UgQyBjb2RlIGdlbmVyYXRpb24gZWFzaWVyLiBTb21ldGhpbmcgbGlr
ZToNCg0KdHlwZWRlZiBzdHJ1Y3Qgew0KCWludDY0X3Qgc2Vjb25kczsNCgl1aW50MzJfdCBuc2Vj
b25kczsNCn0gbmZzdGltZTQ7DQoNCkJ1dCBsaWtlIEkgc2FpZCwgSSBleHBlY3QgdGhhdCBhcHBy
b2FjaCBtaWdodCBiZSBmcm93bmVkIHVwb24uDQoNCg0KPj4+IDIvIHhkcmdlbl9lbmNvZGVfbmZz
dGltZTQgd2FudCBhIHBvaW50ZXIgdG8gdGhlIG5mc3RpbWU0LCBidXQgdGhlDQo+Pj4gYXV0b2dl
bmVyYXRlZCBjb2RlIGZvciB4ZHJnZW5fZW5jb2RlX2ZhdHRyNF90aW1lX2RlbGVnX2FjY2VzcyBh
bmQNCj4+PiB4ZHJnZW5fZW5jb2RlX2ZhdHRyNF90aW1lX2RlbGVnX21vZGlmeSB0cnkgdG8gcGFz
cyBpdCBieSB2YWx1ZQ0KPj4+IGluc3RlYWQuDQo+PiANCj4+IEhlcmUncyBteSBnZW5lcmF0ZWQg
Y29weSBvZiB4ZHJnZW5fZW5jb2RlX2ZhdHRyX3RpbWVfZGVsZWdfYWNjZXNzOg0KPj4gDQo+PiAv
KiB0eXBlZGVmIGZhdHRyNF90aW1lX2RlbGVnX2FjY2VzcyAqLw0KPj4gc3RhdGljIGJvb2wNCj4+
IF9fbWF5YmVfdW51c2VkICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICANCj4+IHhkcmdlbl9lbmNvZGVfZmF0dHI0X3RpbWVfZGVsZWdfYWNjZXNzKHN0
cnVjdCB4ZHJfc3RyZWFtICp4ZHIsIGNvbnN0DQo+PiBmYXR0cjRfdGltZV9kZWxlZ19hY2Nlc3Mg
dmFsdWUpDQo+PiB7DQo+PiAvKiAoYmFzaWMpICovDQo+PiByZXR1cm4geGRyZ2VuX2VuY29kZV9u
ZnN0aW1lNCh4ZHIsICZ2YWx1ZSk7DQo+PiB9Ow0KPj4gDQo+PiBMb29rcyBsaWtlIGl0IGRvZXMg
dGhlIHJpZ2h0IHRoaW5nLi4uPw0KPiANCj4gUHJvYmFibHkgYW5vdGhlciBzaWRlLWVmZmVjdCBv
ZiBpdCBub3Qga25vd2luZyB3aGF0IHRvIGRvIHdpdGggbmZzdGltZTQNCj4gd2hlbiBJIGNvbnZl
cnQgdGhlIGRlbHN0aWQgZHJhZnQuIENvbmNhdGVuYXRpbmcgdGhlbSBzZWVtcyB1bndpZWxkeSBi
dXQNCj4gSSBndWVzcyB0aGF0IHdvdWxkIHdvcmsuIEkgZG8gbGlrZSBiZWluZyBhYmxlIHRvIGtl
ZXAgZ2VuZXJhdGVkIGNvZGUNCj4gZnJvbSBkaWZmZXJlbnQgZmlsZXMgc2VwYXJhdGUgdGhvdWdo
Lg0KDQpJIGRvbid0IHRoaW5rIGNhdCdpbmcgdGhlIC54IGZpbGVzIGlzIC9yZXF1aXJlZC8sIGJ1
dCBpdCB3YXMgYQ0KcXVpY2sgd2F5IHRvIGdldCBzdGFydGVkLg0KDQpIYXZpbmcgYSB3b3JraW5n
IG5mczRfMS54IHRoYXQgY2FuIGdlbmVyYXRlIHRoZSBzbWFsbCBwaWVjZSBvZg0KWERSIGNvZGUg
dGhhdCB3ZSBuZWVkLCBpbiBhIHNlcGFyYXRlIGZpbGUgdGhhdCBjYW4gYmUgYXVnbWVudGVkDQpv
dmVyIHRpbWUsIEkgdGhpbmssIGlzIGEgd2luLiBJIGRvbid0IHNlZSB0aGF0IGFueXRoaW5nIHNv
IGZhcg0KaXMgcHJldmVudGluZyB0aGF0Lg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

