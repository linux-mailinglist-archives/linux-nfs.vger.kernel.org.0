Return-Path: <linux-nfs+bounces-7605-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1003B9B7DB5
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 16:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA451F21A67
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 15:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C901B1D65;
	Thu, 31 Oct 2024 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MYIfCW9r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v2FKYv/D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847F1A256A
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386895; cv=fail; b=etBvvVhSooOvm8WvZw/qJ1Tu9i22ViTjIg+WzqCoaXjvxGtlYlcB/kuRx+7O8RN34fzPf0X9KiUNj10kw0WvO8Q9rHbsbZnmFADhC3UBZHo1h+x7O1CN/820IiNa3THNphKLB2g3+IL+M8j37pLZlETRJEGwwMCiLeG7w/CkPsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386895; c=relaxed/simple;
	bh=JpQ7QdU/d1wtcPnfLmRM6QzbLswxkARt4S9x7r33UYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kmEbw37oFZ+xZCDqgLHgXNNikwAq6YwoJWcTTGoVezX1wXlKfBPcjhlqp6aKsQ1M3yn84GSR+aOrpCO+2yAO/RNpIEl5DjIexvA5Gdni4u94Td6IdajRQdjO6O/lskLtfQtFZOn/Awd1a5XUfWJjshA0OkiLvZCIVomEtAYqiwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MYIfCW9r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v2FKYv/D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49V8uFnA018268;
	Thu, 31 Oct 2024 15:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JpQ7QdU/d1wtcPnfLmRM6QzbLswxkARt4S9x7r33UYE=; b=
	MYIfCW9rq404pDlXmepzP7hRpKwlVPOjbfRfUBPxBcQZT3buYF/MdOqszCzw1C+0
	FEeDiMUTQI4ILOpcf7FBaP1VLsHr3ZQ/33ejwLRSHptptf5RDRuE5LhJxQMgK4AC
	OvScwSUduFazGRXHqiASjKcai73RrK+A33d1wjX4oS254441dxR7wmUzshUi4mKk
	gtQvcTMnWoNk+mit3SIXE3wkNItKvhPca0xVKc+2us55voYUZyDdzHRi9T+ybgGj
	WfIMPocsMA7WEc13xROrwCCEN+NPIgxpbSClD4RC2RTnZR221i0xjog39YoFdF2o
	d+ASjsf5A1wxfRB/zlmZlA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdpafe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 15:01:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49VDeSGr008435;
	Thu, 31 Oct 2024 15:01:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnecey8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 15:01:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LngznIWd5lVKDQGFId+MDZCSUMw7FmBq1oAdthKiVEK4Z1cAZsp80s4NdvlUoxvmBmbRGX3526PfE1xsiefCwu1Nr1TjGeu3WlNkeVZ14R6TX9BjBACsIPDdo5X8dRs+7nlifQbYLA1PGAhWQr/AJUW+gAvwhtJ5EmNLtytvUxoS9pvwcbfB7QM25nT4cEQLkL3WprYFv2E9CfNM2qE1PYBCj66FUbv8uTCnPqrBDzVtlIEzM19/5WyizFlOGwKVVymrsQOgsFnBgrrIDmHGSSBlBFpIGDblqzLnZ1cEp8CCVwexv8hr83yA7/wgA2Riyvw0g6CKzDuFYAN1wBwcwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpQ7QdU/d1wtcPnfLmRM6QzbLswxkARt4S9x7r33UYE=;
 b=Crxkc/uBbhwt01sGo8QOSG+ApF0mRO8d1NIgOwYA2xq9DtMx0xnJXSKk5kDTnorZ1tkfdZGIBCaelRJNcYwl2heP7fP5GQT8d26lByprpyu1J5m0+At6AWmw4fg/FxHq+Yg5On3n1HISbJc8WpEaKMsQ96aCgRwjPLoVOJAEXR4OrRf8Q606YsL9TkvtV4KWV5YsdIYDfervF1UsUWFuZiFgvp/OXzEq+/hvCXpxNNeHpY6Ezn/YDq05BJ9+8Bw+46kY/8vkqHrhdWiuMegzEqRVaDGnsPTqgfAqsuY+ETXGXHvb2u1XkVciW9vmVVf+F9CAmGCJFR09MShgYqmuvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpQ7QdU/d1wtcPnfLmRM6QzbLswxkARt4S9x7r33UYE=;
 b=v2FKYv/Dj6590wuFxz+F/gngfKqn3Oh+8u2cELj9t0dU8ev2TjaJ0za9DbhGr3sbBiCoyNKwjYKYNt2e0uR1zx/BhfkQ4APJMN/0SiKUqGyvHSH26iYm7KuGUPI7al42ZfzXM1qUn+3Se3b3Y2dEDfHwcxzTaT9Z+txQhmDoJnQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6737.namprd10.prod.outlook.com (2603:10b6:610:146::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 15:01:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 15:01:21 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Rick Macklem <rick.macklem@gmail.com>
CC: Jeff Layton <jlayton@kernel.org>,
        Cedric Blancher
	<cedric.blancher@gmail.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4
 reexport
Thread-Topic: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4
 reexport
Thread-Index:
 AQHbJWR3BlJOXtfJrUiYxWPBjvAIV7KdyhAAgAAD4YCAABzbAIAAAnEAgAF/eQCAABZ0AIAABiWAgAAF9YCAAGGbgIAA2IAAgAAzwQCAAAOIgA==
Date: Thu, 31 Oct 2024 15:01:21 +0000
Message-ID: <DBDD309B-BCEF-4F35-86FD-7B2743FA6084@oracle.com>
References: <20241023152940.63479-1-snitzer@kernel.org>
 <20241023155846.63621-1-snitzer@kernel.org>
 <CANH4o6Pi13aEtQW5-vmuJiuCNzx6tjn1+v=pLUpVMuffX-WkPA@mail.gmail.com>
 <7FB2B261-48F9-4DA0-B4B5-E8E30EC31CD9@oracle.com>
 <CAGOwBeX7xw7cPRXGO5RmLQUgzOjqr-7Bh4EhV=hONpXCAqsX-g@mail.gmail.com>
 <91F0EACF-76BC-49EE-9340-AC60F641B8B2@oracle.com>
 <CALXu0UcAw7xkObkVFFTi6d-F69_qrDwf9pTE+8We3k14CvywmA@mail.gmail.com>
 <B67E796E-1539-437C-9F54-091D178E0171@oracle.com>
 <CALXu0Uf4DfcgOqExZ8RYeHY8-fx_fzqCsqAUJogV2Dx8DMgJzQ@mail.gmail.com>
 <2FAFA39C-09C0-4FCC-948F-B6D0518BE5B5@oracle.com>
 <CAM5tNy5yyiE-e4gN50daU06xLjB8Z=SWrz1W9pMJ8am5vPeYCw@mail.gmail.com>
 <0f27eb1d81cefcb791f26ad8619deec6df80f94b.camel@kernel.org>
 <CAM5tNy78G02014XAETh0AB1oTHE6YQhF0g9UyXAC5_k5J7rhYw@mail.gmail.com>
In-Reply-To:
 <CAM5tNy78G02014XAETh0AB1oTHE6YQhF0g9UyXAC5_k5J7rhYw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB6737:EE_
x-ms-office365-filtering-correlation-id: df530634-dac1-4c83-3435-08dcf9bce1d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUl5M0ZGNGpWRUtvQjR1QWx1eWR0UHo3N3dvaXBIYUYxd1Y5OHI1S2Y3QW96?=
 =?utf-8?B?bWV6UGJyWVJML2ZZVE9pS1k5c0VaVTFoZkdTYTVRMEFmelRVQzQ3VW9GZVF4?=
 =?utf-8?B?WkJnaW4yTWIwalRYcDhQVk0rVXVNaEgyb3ZON0xKZW0rTVNNa1cvUGYwM0lZ?=
 =?utf-8?B?bFZpcDcwWUxOcTI4SStQdS93YjliYTEyKzcvd2VHdEFKcU14ckcvaXAvNmZM?=
 =?utf-8?B?c2pLeCtZZE56QkJTdnZBOEhGUW5MVFhPWTJHNE1WNFp5Z24wclJSYlZ4K2F4?=
 =?utf-8?B?RDNsOGliTUNEdS96TUcxR2FaWGwvU1daN2ZvbDhBOFlsQ01LL1YyUlU0S2FT?=
 =?utf-8?B?eTdpMlowWi9LTDhaczNYaXI4YkVReGtNTGQvUjdaY0VvcU8rL3NGVzJid1Ny?=
 =?utf-8?B?ODZrQTIyQ0JycW1OWUMxcHhOZm9udzQrVnNxT3ZaQTg0Ti83bDdlM0w0V2p2?=
 =?utf-8?B?RFc3MzMreERxWHppdVVxN1UxQzA0dkJDcUtHZXVNMjVrMGVtNFZmKy9OQWJy?=
 =?utf-8?B?ZzhyUjVXTEhyUkV3Q1ZUT2h3VUd3NzB1VDRRaVVrdlVRNkdrdmVWbWVOdllU?=
 =?utf-8?B?UGFhVkRtQTMyaGhRQi9UV1hDZDZHKzFDMTI1ZGRvTGhTMlMreW5iYnVtanJV?=
 =?utf-8?B?NzNETGZtNnFxMWxzOS9vL2pBYXllaWRCVHBkemNxVzFweTFXdkZWem45Vmta?=
 =?utf-8?B?ZE1SbnVCWkxBclpZWmFwYkYwQi9td2gyRUsyMUVmenZHS0M5Nk1ha2V6MlZQ?=
 =?utf-8?B?YTE5dndRTzUzcEVYUUdqT1NGQlUxZWdJenNhU1g4U09XTkcwL2JWNmt6bzg2?=
 =?utf-8?B?cFRUTkZMblNRYXdINEprdnJmM3hqWkluNCtNbG1SNFZnMDB6TjMvRGp3SlZM?=
 =?utf-8?B?NGkyYmxqL1VjZmM5dUVvT05JT09KU2Z2S3BvSHZpSml0Z0MvSXJYYktQZWhz?=
 =?utf-8?B?elQ3Y2R1YitIeWhQeXVPMXNaWFlyNDNIQTRJZHBBakJXenN1QzVJV1ZDUkdH?=
 =?utf-8?B?VWtKQnY2VUpCeHdOZkZ0ME02c1IyTFNrUkhnL01mWDh1cFUyb29oSThtd2xE?=
 =?utf-8?B?TFNrMWVzSUkxTCtOczF6QStYYzFnMFFQUm8zbEN5UjFZTUpaUGlxdmFKcGph?=
 =?utf-8?B?bmNLek9pcCt6TjlDWVNHa0Noa29QcFBSejNGNVd5TXF6UnZVVU5mbDFESS9u?=
 =?utf-8?B?bmQ0eWtJMHZOdml1ejFSbytCU3VKUkJWbkFWa2c3RGZIRyt5TGhjK0d1MjVk?=
 =?utf-8?B?RkhNamFldVhlOGNBNUhUTTBOVFMzNVNpTUlJMUg1R3VkaGlYM0dYRVlrSHFs?=
 =?utf-8?B?RVh2N05BM2p4YnpjbG81WDRJa01VY0kxZ21EbUNhZFFCOXhHN1d3WFNvQU5C?=
 =?utf-8?B?bWlWVnp0SlFvL0VTRTJyeFo4a1Qyc3J3cURzTk5PbGlIWUxHcC90eEthbVR5?=
 =?utf-8?B?ZEU2T0xka3N4aW16Tm5KVXBKWHlaNmIwaFBCdWltOEd4V2hNeHdramg5OG40?=
 =?utf-8?B?V1Q3U2dQd2FWd20rdzZEQTUyd0Npcm1DeXRHbG9XdVRkaDZSV1VmYUdoR3hu?=
 =?utf-8?B?aVZScVJuVVVjZjF1T2lsR09aRmxOL25GSGNTR000MzBjM2w0MzJBVVNlTFJY?=
 =?utf-8?B?aWNOMXhydW1xNVRqaEY4eFROOXB0U1BtOElhSGsySVJ2QncxMVRPNmtSZUp2?=
 =?utf-8?B?L1FEeEQyZXdYMFJ6QklXSlBjSFpBR3I3V3ljcWY0MW9pRzhEdEY5RE1ZQmln?=
 =?utf-8?B?RUREY09pUkpraU5wOTdVZlIvVXRsRzBza2taaGMxSmYyVDZKbHlmdEc2MCty?=
 =?utf-8?Q?oTr0XWENQl+JjXKJJ+GHs+fReRwHIpEcpMHCU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVh5Z1ZDanFuQWNDTFJpNVdyRjRlOURjM09qQWFtT3Y0bkR1SEtVcFBTanpO?=
 =?utf-8?B?NEVNQ1l4U0h1U0FtQmJmS3J4YjczR1YxVjN6VlVURTBySWtydyszMGowQzBZ?=
 =?utf-8?B?U3JKTmxtQUZuYUxoeHIwMlgrMXJYU2hPOStvNmVyZ05STWh0N0dqZWkyblhX?=
 =?utf-8?B?QmRSaE4zd2lqaS9rMzRSc0d3NUErdlJPbnBja2lCR3hCMXhnM29GNWJTRXkw?=
 =?utf-8?B?TDNlVDJtY2JGTXN1MC9laENuMkpWTTVaMmo3cWsvYUIya0xKRUF1ZVRySzJ2?=
 =?utf-8?B?ano5d0F4ZFdteW9BWEwvRzlOLzZTaW10TmVQa1RBUkpZM2oxRnhBZ3N4NkJU?=
 =?utf-8?B?TnZnbDljQ0tEOHFoWDZpQ25VQkxFcVV3OERPZGlMRHdCSm1pc1hlUEVVWnMy?=
 =?utf-8?B?cE55Ly9UaTVlSHpPUkxMY3FoeVB1S2ZiU0xhb0J3eWwrRkkrVmRSU1pJeGNX?=
 =?utf-8?B?TktQZFBmam1SVFAvQ0xNUkVJQWI0cUhjWGRkVmdXc04yUVU2c0VBUURqdHBS?=
 =?utf-8?B?Y3J0Y0FIU0VnRE44RUc1b0tIT3ZYOFpsWkJXUWpjMzBWRkFOd3Y4TlRjTU1w?=
 =?utf-8?B?c3pScHFmbHVRNlZVR2pkSUJub2dhbnFOczBZcXZoZ3hqSWdVL0dHSFgvZ2J2?=
 =?utf-8?B?cHlEdWdpWitXUGJvdG9sZEVPNE85dnJjUTdyYmN0dy84SEVjWWcxM25yZDR4?=
 =?utf-8?B?WnBQcC85aHArb2NEa2owRStqaWFSL205MENPV091dW9jbFpWenp1VDE5YjJi?=
 =?utf-8?B?Vk5Way85cWNXQUFpamxsUXlVRmN1bG1XYzhabGFxaFh1T1c1YjBvSVJyRkc4?=
 =?utf-8?B?ZlB4NVBGNlJtUnJZNXpMV0hrUDEwcHJjOXFYZ1JIME9pbldqb0FUT1pFNmNS?=
 =?utf-8?B?Qk9LZGNVY0NvYis0Uzg4aHdBTnVGclV5OE5CY1VzT0ZlVXBTMjBmVWMwbkZj?=
 =?utf-8?B?R1lpaHU2azBsK21XUEZVTDVZaHRTUkYzaTlYMjBCeEZXV0lBUWxSRitxSkNi?=
 =?utf-8?B?dTErYlZQWnZaQ0Qxdkx6QjZwekVNMkFuT2N0L1ltYTMvcVRhczVabE5TcWty?=
 =?utf-8?B?bDlrQkNjT3lwOUdHcCszR3cwZVVZVWw4WmtBOElBb0VPSE1SbDFtVFJXYmty?=
 =?utf-8?B?ZE9tbzIxbTJUamFad2lRT1hoUGhYalI2THVDWWJpUjNMZU5hM1VHT3pqMHBk?=
 =?utf-8?B?QkdGMGcxNEJBd3V4dk14dkJMb0tFZU1oMHJ2a2YyTDE4WDY2aG5zTkhvZ3Vk?=
 =?utf-8?B?bktjWTVTSnVmOStmbGxybVJFanlqcU53Q1AwNVBWSzlBZithOG1LWXZabDYy?=
 =?utf-8?B?OWVQRkgxdmZBeGplR1BqT1RRTGo2blVxOUlrdGNkdTFVYlYzYlBPUEZUeFk4?=
 =?utf-8?B?UFRUdWtIVmlnTFJ3dGl1RklUcm5CZHNIOThVWEVUMUFWWnZFeU1JSHBIcnhi?=
 =?utf-8?B?eGJ6ZWZoSGF6UmZ4UGUzUnZCY2tjSEZJTHltcHFQYktFelJFN09obUkzU3lj?=
 =?utf-8?B?T2Fuekx2SmovZ0NBZi9EY0pXNFBycmc1ZGxURFZ1cTZYcDg0YXd6VElCa0NH?=
 =?utf-8?B?N21xQ09VTnVrT2svdEpncElSUHNVZVNaWmRSa3NXM0JhT3ptb0dkbncyTlRJ?=
 =?utf-8?B?b0Z4c1VhL1l4RzZ5VENvUHh4WGV4OGhVdTR2WmZoRzg4cjZJVDJWa0lob1d3?=
 =?utf-8?B?Q0ZmTTdoNE9XSHJoT1BRakR1V1JvS1ltL1YwQTJpb1ZqMU1IQ3VNeDlrQXVy?=
 =?utf-8?B?RnR6MHRPeHUwZFNNSnpEUUdZWk50dDE5VGlseWNJUkl2OHFFT3RidWJtdHlj?=
 =?utf-8?B?dnhnMEthTm1VYzhEMXJldDQ2OTdybDBMckVMK3UvM0dzenJId2JUU1BnRFhw?=
 =?utf-8?B?SFM5YjZFbXpYaW5US0liRlU4MSs5aGwrQTg4Y0ppbys5UEFGbmZDUmdPaG9K?=
 =?utf-8?B?djBhbHVhS0ZqQU9Ld1VzSWc2T09MTVQ2UGZLeW92cElLd3pra2FPd09IempD?=
 =?utf-8?B?T0VlR0dBenNKMEd4cU0xZ0VURVQ1cXRxcUk1REp0VmhQdmtwSUJPYkFJYkth?=
 =?utf-8?B?ck9YNnpoMFp4cU9JbXlGMXF4QTdJc0NBbWtyQWdaSkdwbFhDaW1UVkJCeDFp?=
 =?utf-8?B?bDdpRDNLanBkN0NPL25WQ0UyMUoxaDY1aEVCTjdwTXpkTUMvSksxeTdVNXR3?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <530464BED9A0C244A3407B0D7274C995@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lGpCGG+DuZk+z8Vrf4eoJdmrTXTFJG2Kfbb7+0Zn3wrdg4i7ooiS9by6f8+uuGAI8wP+EmIBZPEu6wwBAu9lJISMmUsGGvkdCL9QmK4+t3kHMTU3Vn02jjFRcHGQGhkPUldZO+Mnaj5jmX/ASDiOIj9skKuk3SAuodvWmvzhkOc8YRRos0ZZGLr1gPo2wspKYnY67oAggo+TPFFR0opM2MUoB330GRYv2J5unziifELMcHpQjpI53nDQ67XkneaSRv9Doby9iVdzUB1EmvQiOpdbmd1b1Rx3iSPVhq9Y9LagQVmt1JHd5JD2VNs0KRXLz3ONM8C/l7kXxgVca4IwWZQV9Lr1VYi+sapaIqhbZOodzG0M6vjMMKsmi3uhqD+ZWLtfvJdDtJkyEESxReaM3sLMNHpCJMao6TqupTWVVZH1ZYdeQptb+8ktK5nnuWlLkZC0gLUIGvsBkakVnKq4zOWc14/24r7cXTbnlU+yWGdgeMqVLoKAgMlVWfmCshUPFOzfIsauJ3fAvnAxjN72864uxmj4HW3jPEfnsUhJ6V5tRomJXUcqJ8Ez72tQSp9wSCbDVhiRBNZiDotpQUNLV2FvJodkcXsTjMAgsPvmbFY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df530634-dac1-4c83-3435-08dcf9bce1d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 15:01:21.7399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRe5H5mtOKrlXGuat0zA7I5hjzlJCSjv/RZtflxOY3Sdzh72iKoDlvuf8es4MX1GQkCWlA59FqhdELVBIDiATw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-31_06,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410310113
X-Proofpoint-ORIG-GUID: uP7iRQNwe3VkgF9cO8VPAFrUXj-DDsey
X-Proofpoint-GUID: uP7iRQNwe3VkgF9cO8VPAFrUXj-DDsey

DQoNCj4gT24gT2N0IDMxLCAyMDI0LCBhdCAxMDo0OOKAr0FNLCBSaWNrIE1hY2tsZW0gPHJpY2su
bWFja2xlbUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBPY3QgMzEsIDIwMjQgYXQg
NDo0M+KAr0FNIEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+
PiBPbiBXZWQsIDIwMjQtMTAtMzAgYXQgMTU6NDggLTA3MDAsIFJpY2sgTWFja2xlbSB3cm90ZToN
Cj4+PiBPbiBXZWQsIE9jdCAzMCwgMjAyNCBhdCAxMDowOOKAr0FNIENodWNrIExldmVyIElJSSA8
Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBDQVVUSU9OOiBUaGlz
IGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBVbml2ZXJzaXR5IG9mIEd1ZWxw
aC4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNv
Z25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLiBJZiBpbiBkb3Vi
dCwgZm9yd2FyZCBzdXNwaWNpb3VzIGVtYWlscyB0byBJVGhlbHBAdW9ndWVscGguY2EuDQo+Pj4+
IA0KPj4+PiANCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4gT24gT2N0IDMwLCAyMDI0LCBhdCAxMjozN+KA
r1BNLCBDZWRyaWMgQmxhbmNoZXIgPGNlZHJpYy5ibGFuY2hlckBnbWFpbC5jb20+IHdyb3RlOg0K
Pj4+Pj4gDQo+Pj4+PiBPbiBXZWQsIDMwIE9jdCAyMDI0IGF0IDE3OjE1LCBDaHVjayBMZXZlciBJ
SUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+
Pj4+IA0KPj4+Pj4+PiBPbiBPY3QgMzAsIDIwMjQsIGF0IDEwOjU14oCvQU0sIENlZHJpYyBCbGFu
Y2hlciA8Y2VkcmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+IA0KPj4+Pj4+
PiBPbiBUdWUsIDI5IE9jdCAyMDI0IGF0IDE3OjAzLCBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxl
dmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gT24gT2N0IDI5LCAy
MDI0LCBhdCAxMTo1NOKAr0FNLCBCcmlhbiBDb3dhbiA8YnJpYW4uY293YW5AaGNsLXNvZnR3YXJl
LmNvbT4gd3JvdGU6DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gSG9uZXN0bHksIEkgZG9uJ3Qga25v
dyB0aGUgdXNlY2FzZSBmb3IgcmUtZXhwb3J0aW5nIGFub3RoZXIgc2VydmVyJ3MNCj4+Pj4+Pj4+
PiBORlMgZXhwb3J0IGluIHRoZSBmaXJzdCBwbGFjZS4gSXMgdGhpcyBzb21lb25lIHRyeWluZyB0
byBzaGFyZSBORlMNCj4+Pj4+Pj4+PiB0aHJvdWdoIGEgZmlyZXdhbGw/IEkndmUgc2VlbiBwZW9w
bGUgc2hhcmUgcmVtb3RlIE5GUyBleHBvcnRzIHZpYQ0KPj4+Pj4+Pj4+IFNhbWJhIGluIGFuIGF0
dGVtcHQgdG8gYXZvaWQgcGF5aW5nIHRoZWlyIE5BUyB2ZW5kb3IgZm9yIFNNQiBzdXBwb3J0Lg0K
Pj4+Pj4+Pj4+IChJIHRoaW5rIGl0J3MgInN0YW5kYXJkIGVxdWlwbWVudCIgbm93LCBidXQgMTAr
IHllYXJzIGFnbz8gTm90DQo+Pj4+Pj4+Pj4gYWx3YXlzLi4uKSBCdXQgcmUtZXhwb3J0aW5nIGFu
b3RoZXIgc2VydmVyJ3MgTkZTIGV4cG9ydHM/IEhhdmVuJ3Qgc2Vlbg0KPj4+Pj4+Pj4+IGFueW9u
ZSBkbyB0aGF0IGluIGEgd2hpbGUuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IFRoZSAicmUtZXhwb3J0
IiBjYXNlIGlzIHdoZXJlIHRoZXJlIGlzIGEgY2VudHJhbCByZXBvc2l0b3J5DQo+Pj4+Pj4+PiBv
ZiBkYXRhIGFuZCBicmFuY2ggb2ZmaWNlcyB0aGF0IGFjY2VzcyB0aGF0IHZpYSBhIFdBTi4gVGhl
DQo+Pj4+Pj4+PiByZS1leHBvcnQgc2VydmVycyBjYWNoZSBzb21lIG9mIHRoYXQgZGF0YSBsb2Nh
bGx5IHNvIHRoYXQNCj4+Pj4+Pj4+IGxvY2FsIGNsaWVudHMgaGF2ZSBhIGZhc3QgcGVyc2lzdGVu
dCBjYWNoZSBuZWFyYnkuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IFRoaXMgaXMgYWxzbyBlZmZlY3Rp
dmUgaW4gY2FzZXMgd2hlcmUgYSBzbWFsbCBjbHVzdGVyIG9mDQo+Pj4+Pj4+PiBjbGllbnRzIHdh
bnQgZmFzdCBhY2Nlc3MgdG8gYSBwaWxlIG9mIGRhdGEgdGhhdCBpcw0KPj4+Pj4+Pj4gc2lnbmlm
aWNhbnRseSBsYXJnZXIgdGhhbiB0aGVpciBvd24gY2FjaGVzLiBTYXksIEhQQyBvcg0KPj4+Pj4+
Pj4gYW5pbWF0aW9uLCB3aGVyZSB0aGUgc21hbGwgY2x1c3RlciBpcyB3b3JraW5nIG9uIGEgc21h
bGwNCj4+Pj4+Pj4+IHBvcnRpb24gb2YgdGhlIGZ1bGwgZGF0YSBzZXQsIHdoaWNoIGlzIHN0b3Jl
ZCBvbiBhIGNlbnRyYWwNCj4+Pj4+Pj4+IHNlcnZlci4NCj4+Pj4+Pj4+IA0KPj4+Pj4+PiBBbm90
aGVyIHVzZSBjYXNlIGlzICJpc29sYXRpb24iLCBJVCBzaGFyZXMgYSBmaWxlc3lzdGVtIHRvIHlv
dXINCj4+Pj4+Pj4gZGVwYXJ0bWVudCwgYW5kIHlvdSBuZWVkIHRvIHJlLWV4cG9ydCBvbmx5IGEg
c3Vic2V0IHRvIGFub3RoZXINCj4+Pj4+Pj4gZGVwYXJ0bWVudCBvciBob21lb2ZmaWNlLiBQYXJ0
IG9mIHN1Y2ggYSBzY2VuYXJpbyBtaWdodCBhbHNvIGJlIHBvbGljeQ0KPj4+Pj4+PiByZWxhdGVk
LCBlLmcuIElUIHNoYXJlcyB5b3UgdGhlIGZ1bGwgZmlsZXN5c3RlbSBidXQgd2lsbCBkbyBOT1RI
SU5HDQo+Pj4+Pj4+IGVsc2UsIGFuZCBhbnkgZnVydGhlciBjb21wYXJ0bWVudGFsaXphdGlvbiBt
dXN0IGJlIGRvbmUgaW4geW91ciBvd24NCj4+Pj4+Pj4gZGVwYXJ0bWVudC4NCj4+Pj4+Pj4gVGhp
cyBpcyB0aGUgdHlwaWNhbCB1c2UgY2FzZSBmb3IgZ292IE5GUyByZS1leHBvcnQuDQo+Pj4+Pj4g
DQo+Pj4+Pj4gSXQncyBub3QgY2xlYXIgdG8gbWUgZnJvbSB0aGlzIGRlc2NyaXB0aW9uIHdoeSBy
ZS1leHBvcnQgaXMNCj4+Pj4+PiB0aGUgcmlnaHQgdG9vbCBmb3IgdGhpcyBqb2IuIFBsZWFzZSBl
eHBsYWluIHdoeSBBQ0xzIGFyZSBub3QNCj4+Pj4+PiB1c2VkIGluIHRoaXMgY2FzZSAtLSB0aGlz
IGlzIGV4YWN0bHkgd2hhdCB0aGV5IGFyZSBkZXNpZ25lZA0KPj4+Pj4+IHRvIGRvLg0KPj4+Pj4g
DQo+Pj4+PiAxLiBJVCBkZXBhcnRtZW50cyB3YW50IGJldHRlci9oYXJkZXIvaW1tdXRhYmxlIGlz
b2xhdGlvbiB0aGFuIEFDTHMNCj4+Pj4gDQo+Pj4+IFNvIHlvdSB3YW50IE1BQywgYW5kIHRoZSBz
dG9yYWdlIGFkbWluaXN0cmF0b3Igd29uJ3Qgc2V0DQo+Pj4+IHRoYXQgdXAgZm9yIHlvdSBvbiB0
aGUgTkZTIHNlcnZlci4gTkZTIGRvZXNuJ3QgZG8gTUFDDQo+Pj4+IHZlcnkgd2VsbCBpZiBhdCBh
bGwuDQo+Pj4+IA0KPj4+PiANCj4+Pj4+IDIuIExpbnV4IE5GU3Y0IG9ubHkgaW1wbGVtZW50cyBQ
T1NJWCBkcmFmdCBBQ0xzLCBub3QgZnVsbCBXaW5kb3dzIG9yDQo+Pj4+PiBORlN2NCBBQ0xzLiBT
byB0aGVyZSBpcyBubyBwcm9wZXIgd2F5IHRvIHByZXZlbnQgQUNMIGVkaXRpbmcsDQo+Pj4+PiBy
ZW5kZXJpbmcgdGhlbSB1c2VsZXNzIGluIHRoaXMgY2FzZS4NCj4+Pj4gDQo+Pj4+IEVyLiBMaW51
eCBORlN2NCBzdG9yZXMgdGhlIEFDTHMgYXMgUE9TSVggZHJhZnQsIGJlY2F1c2UNCj4+Pj4gdGhh
dCdzIHdoYXQgTGludXggZmlsZSBzeXN0ZW1zIGNhbiBzdXBwb3J0LiBORlNELCB2aWENCj4+Pj4g
TkZTdjQsIG1ha2VzIHRoZXNlIGFwcGVhciBsaWtlIE5GU3Y0IEFDTHMuDQo+Pj4+IA0KPj4+PiBC
dXQgSSB0aGluayBJIHVuZGVyc3RhbmQuDQo+Pj4+IA0KPj4+PiANCj4+Pj4+IFRoZXJlIGlzIGEg
cmVhc29uIHdoeSBQT1NJWCBkcmFmdCBBQ2xzIHdlcmUgYWJhbmRvbmVkIC0gdGhleSBhcmUgbm90
DQo+Pj4+PiBmaW5lLWdyYW50ZWQgZW5vdWdoIGZvciByZWFsIHdvcmxkIHVzYWdlIG91dHNpZGUg
dGhlIExpbnV4IHVuaXZlcnNlLg0KPj4+Pj4gQXMgc29vbiBhcyBpbnRlcm9wZXJhYmlsaXR5IGlz
IHJlcXVpcmVkIHRoZXNlIHRoaW5ncyBqdXN0IGJpdGUgeW91DQo+Pj4+PiBIQVJELg0KPj4+PiAN
Cj4+Pj4gWW91LCBvZiBjb3Vyc2UsIGhhdmUgdGhlIGFiaWxpdHkgdG8gcnVuIHNvbWUgb3RoZXIg
TkZTDQo+Pj4+IHNlcnZlciBpbXBsZW1lbnRhdGlvbiB0aGF0IG1lZXRzIHlvdXIgc2VjdXJpdHkg
cmVxdWlyZW1lbnRzDQo+Pj4+IG1vcmUgZnVsbHkuDQo+Pj4+IA0KPj4+PiANCj4+Pj4+IEFsc28s
IGp1c3QgcnVubmluZyBtb3JlIG5mc2QgaW4gcGFyYWxsZWwgb24gdGhlIG9yaWdpbiBORlMgc2Vy
dmVyIGlzDQo+Pj4+PiBub3QgYSBiZXR0ZXIgb3B0aW9uIC0gcmVtZW1iZXIgdGhlIGRlYmF0ZSBv
ZiBub24tMjA0OSBwb3J0cyBmb3IgbmZzZD8NCj4+Pj4gDQo+Pj4+IEknbSBub3Qgc3VyZSB3aGVy
ZSB0aGlzIGlzIGdvaW5nLiBEbyB5b3UgbWVhbiB0aGUgc3RvcmFnZQ0KPj4+PiBhZG1pbmlzdHJh
dG9yIHdvdWxkIHByb3ZpZGUgTkZTIHNlcnZpY2Ugb24gYWx0ZXJuYXRlDQo+Pj4+IHBvcnRzIHRo
YXQgZWFjaCBleHBvc2UgYSBzZXBhcmF0ZSBzZXQgb2YgZXhwb3J0cz8NCj4+Pj4gDQo+Pj4+IFNv
IHRoZSBvbmx5IG9wdGlvbiBMaW51eCBoYXMgdGhlcmUgaXMgdXNpbmcgY29udGFpbmVycyBvcg0K
Pj4+PiBsaWJ2aXJ0LiBXZSd2ZSBjb250aW51ZWQgdG8gcHJpdmF0ZWx5IGRpc2N1c3MgdGhlIGFi
aWxpdHkNCj4+Pj4gZm9yIE5GU0QgdG8gc3VwcG9ydCBhIHNlcGFyYXRlIHNldCBvZiBleHBvcnRz
IG9uIGFsdGVybmF0ZQ0KPj4+PiBwb3J0cywgYnV0IGl0IGRvZXNuJ3QgbG9vayBmZWFzaWJsZS4g
VGhlIGV4cG9ydCBtYW5hZ2VtZW50DQo+Pj4+IGluZnJhc3RydWN0dXJlIGFuZCB1c2VyIHNwYWNl
IHRvb2xzIHdvdWxkIG5lZWQgdG8gYmUNCj4+Pj4gcmV3cml0dGVuLg0KPj4+PiANCj4+Pj4gDQo+
Pj4+Pj4gQW5kIGFnYWluLCBjbGllbnRzIG9mIHRoZSByZS1leHBvcnQgc2VydmVyIG5lZWQgdG8g
bW91bnQgaXQNCj4+Pj4+PiB3aXRoIGxvY2FsX2xvY2suIEFwcHMgY2FuIHN0aWxsIHVzZSBsb2Nr
aW5nIGluIHRoYXQgY2FzZSwNCj4+Pj4+PiBidXQgdGhlIGxvY2tzIGFyZSBub3QgdmlzaWJsZSB0
byBhcHBzIG9uIG90aGVyIGNsaWVudHMuIFlvdXINCj4+Pj4+PiBkZXNjcmlwdGlvbiBkb2VzIG5v
dCBleHBsYWluIHdoeSBsb2NhbF9sb2NrIGlzIG5vdA0KPj4+Pj4+IHN1ZmZpY2llbnQgb3IgZmVh
c2libGUuDQo+Pj4+PiANCj4+Pj4+IEJlY2F1c2U6DQo+Pj4+PiAtIGl0IGJyZWFrcyBhcHBsaWNh
dGlvbnMgcnVubmluZyBvbiBtb3JlIHRoYW4gb25lIG1hY2hpbmU/DQo+Pj4+IA0KPj4+PiBZZXMs
IG9idmlvdXNseS4gWW91ciBkZXNjcmlwdGlvbiBuZWVkcyB0byBtZW50aW9uIHRoYXQgaXMNCj4+
Pj4gYSByZXF1aXJlbWVudCwgc2luY2UgdGhlcmUgYXJlIGEgbG90IG9mIGFwcGxpY2F0aW9ucyB0
aGF0DQo+Pj4+IGRvbid0IG5lZWQgbG9ja2luZyBhY3Jvc3MgbXVsdGlwbGUgY2xpZW50cy4NCj4+
Pj4gDQo+Pj4+IA0KPj4+Pj4gLSBpdCBicmVha3MgdXNlIGNhc2VzIGxpa2UgTkZTLS0tPlNNQiBi
cmlkZ2VzLCBiZWNhdXNlIHdpdGhvdXQgbG9ja2luZw0KPj4+Pj4gdGhlIHR5cGljYWwgV2luZG93
cyAuTkVUIGFwcGxpY2F0aW9uIHdpbGwgcmVmdXNlIHRvIHdyaXRlIHRvIGEgZmlsZQ0KPj4+PiAN
Cj4+Pj4gVGhhdCdzIGEgcXVhZ21pcmUsIGFuZCBJIGRvbid0IHRoaW5rIHdlIGNhbiBndWFyYW50
ZWUgdGhhdA0KPj4+PiB3aWxsIHdvcmsuIExpbnV4IE5GUyBkb2Vzbid0IHN1cHBvcnQgImRlbnki
IG1vZGVzLCBmb3INCj4+Pj4gZXhhbXBsZS4NCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4gLSBpdCBicmVh
a3MgZXZlbiBTSU1QTEUgdGhpbmdzIGxpa2UgTWljcm9zb2Z0IEV4Y2VsDQo+Pj4+IA0KPj4+PiBJ
ZiB5b3UgbmVlZCBTTUIgc2VtYW50aWNzLCB3aHkgbm90IHVzZSBTYW1iYT8NCj4+Pj4gDQo+Pj4+
IFRoZSB1cHNob3QgYXBwZWFycyB0byBiZSB0aGF0IHRoaXMgdXNhZ2UgaXMgYSBzdGFjayBvZg0K
Pj4+PiBtaXNtYXRjaGVkIHN0b3JhZ2UgcHJvdG9jb2xzIHRoYXQgd29yayBhcm91bmQgYSBidW5j
aCBvZg0KPj4+PiBsb2NhbCBJVCBidXJlYXVjcmFjeS4gSSdtIHRyeWluZyB0byBiZSBzeW1wYXRo
ZXRpYywgYnV0DQo+Pj4+IGl0J3MgaGFyZCB0byBzYXkgdGhhdCAvYW55b25lLyB3b3VsZCBmdWxs
eSBzdXBwb3J0IHRoaXMuDQo+Pj4+IA0KPj4+PiANCj4+Pj4+IE9mIGNvdXJzZSB0aGUgaGFwcHkg
ZWNobyAiaGVsbG8gTGludXgtTkZTdjQtb25seSB3b3JsZCIgPi9uZnMvZmlsZQ0KPj4+Pj4gd2ls
bCBhbHdheXMgd29yay4NCj4+Pj4+IA0KPj4+Pj4+PiBPZiBjb3Vyc2Ugbm8gb25lIG5lZWRzIHRo
ZSBnb3YgY3VzdG9tZXJzLCBzbyBmZWVsIGZyZWUgdG8gYnJlYWsgbG9ja2luZy4NCj4+Pj4+PiAN
Cj4+Pj4+PiANCj4+Pj4+PiBQbGVhc2UgaGF2ZSBhIGxvb2sgYXQgdGhlIHBhdGNoIGRlc2NyaXB0
aW9uIGFnYWluOiBsb2NrDQo+Pj4+Pj4gcmVjb3ZlcnkgZG9lcyBub3Qgd29yayBub3csIGFuZCBj
YW5ub3Qgd29yayB3aXRob3V0DQo+Pj4+Pj4gY2hhbmdlcyB0byB0aGUgcHJvdG9jb2wuIElzbid0
IHRoYXQgYSBwcm9ibGVtIGZvciBzdWNoDQo+Pj4+Pj4gd29ya2xvYWRzPw0KPj4+Pj4gDQo+Pj4+
PiBOb3BlLCBiZWNhdXNlIG9mIFVQUyAoVW5pbnRlcnJ1cHRpYmxlIHBvd2VyIHN1cHBseSkuIEVp
dGhlciBldmVyeXRoaW5nDQo+Pj4+PiBpcyBVUCwgb3IgKmV2ZXJ5dGhpbmcqIGlzIERPV04uIEJv
b2xlYW4uDQo+Pj4+IA0KPj4+PiBQb3dlciBvdXRhZ2VzIGFyZSBub3QgdGhlIG9ubHkgcmVhc29u
IGxvY2sgcmVjb3ZlcnkgbWlnaHQNCj4+Pj4gYmUgbmVjZXNzYXJ5LiBOZXR3b3JrIHBhcnRpdGlv
bnMsIHJlLWV4cG9ydCBzZXJ2ZXINCj4+Pj4gdXBncmFkZXMgb3IgcmVib290cywgZXRjLiBTbyBJ
J20gbm90IGhlYXJpbmcgYW55dGh5aW5nDQo+Pj4+IHRvIHN1Z2dlc3QgdGhpcyBraW5kIG9mIHdv
cmtsb2FkIGlzIG5vdCBpbXBhY3RlZCBieQ0KPj4+PiB0aGUgY3VycmVudCBsb2NrIHJlY292ZXJ5
IHByb2JsZW1zLg0KPj4+PiANCj4+Pj4gDQo+Pj4+Pj4gSW4gb3RoZXIgd29yZHMsIGxvY2tpbmcg
aXMgYWxyZWFkeSBicm9rZW4gb24gTkZTdjQgcmUtZXhwb3J0LA0KPj4+Pj4+IGJ1dCB0aGUgY3Vy
cmVudCBzaXR1YXRpb24gY2FuIGxlYWQgdG8gc2lsZW50IGRhdGEgY29ycnVwdGlvbi4NCj4+Pj4+
IA0KPj4+Pj4gV291bGQgc3RvcmluZyB0aGUgbG9ja2luZyBpbmZvcm1hdGlvbiBpbnRvIHBlcnNp
c3RlbnQgZmlsZXMgaGVscCwgaWUuDQo+Pj4+PiBmaWxlcyB3aGljaCBwZXJzaXN0IGFjcm9zcyBu
ZnNkIHNlcnZlciByZXN0YXJ0cz8NCj4+Pj4gDQo+Pj4+IFllcywgYnV0IGl0IHdvdWxkIG1ha2Ug
dGhpbmdzIGhvcnJpYmx5IHNsb3cuDQo+Pj4+IA0KPj4+PiBBbmQgb2YgY291cnNlIHRoZXJlIHdv
dWxkIGJlIGEgbG90IG9mIGNvZGluZyBpbnZvbHZlZA0KPj4+PiB0byBnZXQgdGhpcyB0byB3b3Jr
Lg0KPj4+IEkgc3VzcGVjdCB0aGlzIHN1Z2dlc3Rpb24gbWlnaHQgYmUgYSBmYWlyIGFtb3VudCBv
ZiBjb2RlIHRvbw0KPj4+IChhbmQgSSBhbSBjZXJ0YWlubHkgbm90IHZvbHVudGVlcmluZyB0byB3
cml0ZSBpdCksIGJ1dCBJIHdpbGwgbWVudGlvbiBpdC4NCj4+PiANCj4+PiBBbm90aGVyIHBvc3Np
YmlsaXR5IHdvdWxkIGJlIHRvIGhhdmUgdGhlIHJlLWV4cG9ydGluZyBORlN2NCBzZXJ2ZXINCj4+
PiBqdXN0IHBhc3MgbG9ja2luZyBvcHMgdGhyb3VnaCB0byB0aGUgYmFja2VuZCBORlN2NCBzZXJ2
ZXIuDQo+Pj4gLSBJdCBpcyByb3VnaGx5IHRoZSBpbnZlcnNlIG9mIHdoYXQgSSBkaWQgd2hlbiBJ
IGNvbnN0cnVjdGVkIGEgZmxleCBmaWxlcw0KPj4+ICBwTkZTIHNlcnZlci4gVGhlIE1EUyBkaWQg
dGhlIGxvY2tpbmcgb3BzIGFuZCBhbnkgSS9PIG9wcy4gd2VyZQ0KPj4+ICBwYXNzZWQgdGhyb3Vn
aCB0byB0aGUgRFMocykuIE9mIGNvdXJzZSwgaXQgd2FzIGhvcGVkIHRoZSBjbGllbnQNCj4+PiAg
d291bGQgdXNlIGxheW91dHMgYW5kIGJ5cGFzcyB0aGUgTURTIGZvciBJL08uDQo+Pj4gDQo+PiAN
Cj4+IEhvdyBkbyB5b3UgaGFuZGxlIHJlY2xhaW0gaW4gdGhpcyBjYXNlPyBJT1csIHN1cHBvc2Ug
dGhlIGJhY2tlbmQgc2VydmVyDQo+PiBjcmFzaGVzIGJ1dCB0aGUgcmVleHBvcnRlciBzdGF5cyB1
cC4gSG93IGRvIHlvdSBjb29yZGluYXRlIHRoZSBncmFjZQ0KPj4gcGVyaW9kcyBiZXR3ZWVuIHRo
ZSB0d28gc28gdGhhdCB0aGUgY2xpZW50IGNhbiByZWNsYWltIGl0cyBsb2NrIG9uIHRoZQ0KPj4g
YmFja2VuZD8NCj4gV2VsbCwgSSdtIG5vdCBzYXlpbmcgaXQgaXMgdHJpdmlhbC4NCj4gSSB0aGlu
ayB5b3Ugd291bGQgbmVlZCB0byBwYXNzIHRocm91Z2ggYWxsIHN0YXRlIG9wZXJhdGlvbnM6DQo+
IEV4Y2hhbmdlSUQsIE9wZW4sLi4uLExvY2ssTG9ja1UNCj4gLSBUaGUgdHJpY2t5IGJpdCB3b3Vs
ZCBiZSBzZXNzaW9ucywgc2luY2UgdGhlIHJlLWV4cG9ydGVyIHdvdWxkIG5lZWQgdG8NCj4gICBt
YWludGFpbiBzZXNzaW9ucy4NCj4gICAtLT4gTWF5YmUgdGhlIHJlLWV4cG9ydGVyIHdvdWxkIG5l
ZWQgdG8gc2F2ZSB0aGUgQ2xpZW50SUQgKGZyb20gdGhlDQo+ICAgICAgICAgYmFja2VuZCBuZnNk
KSBpbiBub24tdm9sYXRpbGUgc3RvcmFnZS4NCj4gDQo+IFdoZW4gdGhlIGJhY2tlbmQgc2VydmVy
IGNyYXNoZXMvcmVib290cywgdGhlIHJlLWV4cG9ydGVyIHdvdWxkIHNlZQ0KPiB0aGlzIGFzIGEg
ZmFpbHVyZSAodXN1YWxseSBORlM0RVJSX0JBRF9TRVNTSU9OKSBhbmQgd291bGQgcGFzcw0KPiB0
aGF0IHRvIHRoZSBjbGllbnQuDQo+IFRoZSBvbmx5IHJlY292ZXJ5IFJQQyB0aGF0IHdvdWxkIG5v
dCBiZSBwYXNzZWQgdGhyb3VnaCB3b3VsZCBiZQ0KPiBDcmVhdGVfc2Vzc2lvbiwgYWx0aG91Z2gg
dGhlIHJlLWV4cG9ydGVyIHdvdWxkIGRvIGEgQ3JlYXRlX3Nlc3Npb24NCj4gZm9yIGNvbm5lY3Rp
b24ocykgaXQgaGFzIGFnYWluc3QgdGhlIGJhY2tlbmQgc2VydmVyLg0KPiBJIHRoaW5rIHNvbWV0
aGluZyBsaWtlIHRoYXQgd291bGQgd29yayBmb3IgdGhlIGJhY2tlbmQgY3Jhc2gvcmVjb3Zlcnku
DQoNClRoZSBiYWNrZW5kIHNlcnZlciB3b3VsZCBiZSBpbiBncmFjZSwgYW5kIHRoZSByZS1leHBv
cnRlcg0Kd291bGQgYmUgYWJsZSB0byByZWNvdmVyIGl0cyBsb2NrIHN0YXRlIG9uIHRoZSBiYWNr
ZW5kDQpzZXJ2ZXIgdXNpbmcgbm9ybWFsIHN0YXRlIHJlY292ZXJ5LiBJIHRoaW5rIHRoZSByZS0N
CmV4cG9ydGVyIHdvdWxkIG5vdCBuZWVkIHRvIGV4cG9zZSB0aGUgYmFja2VuZCBzZXJ2ZXIncw0K
Y3Jhc2ggdG8gaXRzIG93biBjbGllbnRzLg0KDQoNCj4gQSBjcmFzaCBvZiB0aGUgcmUtZXhwb3J0
ZXIgY291bGQgYmUgbW9yZSBvZiBhIHByb2JsZW0sIEkgdGhpbmsuDQo+IEl0IHdvdWxkIG5lZWQg
dG8gaGF2ZSB0aGUgQ2xpZW50SUQgKHN0b3JlZCBpbiBub24tdm9sYXRpbGUgc3RvcmFnZSkNCj4g
c28gdGhhdCBpdCBjb3VsZCBkbyBhIENyZWF0ZV9zZXNzaW9uIHdpdGggaXQgYWdhaW5zdCB0aGUg
YmFja2VuZCBzZXJ2ZXIuDQo+IC0gSXQgd291bGQgYWxzbyBkZXBlbmQgb24gdGhlIGJhY2tlbmQg
c2VydmVyIGJlaW5nIGNvdXJ0ZW91cywgc28gdGhhdA0KPiAgYW4gcmUtZXhwb3J0ZXIgY3Jhc2gv
cmVib290IHRoYXQgdGFrZXMgYSB3aGlsZSBzdWNoIHRoYXQgdGhlIGxlYXNlIGV4cGlyZXMNCj4g
IGRvZXNuJ3QgcmVzdWx0IGluIGEgbG9zcyBvZiBzdGF0ZSBvbiB0aGUgYmFja2VuZCBzZXJ2ZXIu
DQoNClRoZSBiYWNrZW5kIHNlcnZlciB3b3VsZCBub3QgYmUgaW4gZ3JhY2UgYWZ0ZXIgdGhlIHJl
LWV4cG9ydA0Kc2VydmVyIGNyYXNoZXMuIFRoZXJlJ3Mgbm8gd2F5IGZvciB0aGUgcmUtZXhwb3J0
IHNlcnZlcidzDQpORlMgY2xpZW50IHRvIHJlY292ZXIgaXRzIGxvY2sgc3RhdGUgZnJvbSB0aGUg
YmFja2VuZCBzZXJ2ZXIuDQoNClRoZSByZS1leHBvcnQgc2VydmVyIHJlY292ZXJzIGJ5IHJlLWxl
YXJuaW5nIGxvY2sgc3RhdGUgZnJvbQ0KaXRzIG93biBjbGllbnRzLiBUaGUgcXVlc3Rpb24gaXMg
aG93IHRoZSByZS1leHBvcnQgc2VydmVyDQpjb3VsZCByZS1pbml0aWFsaXplIHRoaXMgc3RhdGUg
aW4gaXRzIGxvY2FsIGNsaWVudCBvZiB0aGUNCmJhY2tlbmQgc2VydmVyLg0KDQoNCi0tDQpDaHVj
ayBMZXZlcg0KDQoNCg==

