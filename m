Return-Path: <linux-nfs+bounces-6350-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A574971DBC
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 17:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA9C1F23695
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A95C1CD2F;
	Mon,  9 Sep 2024 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LldqS+DQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hUxjbzM6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C591CA9F
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894885; cv=fail; b=nEyKomuq7a2+2N0I5fLglEdOf6CnFiQzDpOOFCW0m4nOb+JtePa8hYKN9FxTlgvYyj6jOp5oJhl1dcG9uOPaP8a8HFzYhMHcusu7x4xECZgukh2u399yfL79C0f/5kGwb3ElThKIx8/jTYRv44++pimRp5IqsFfM0/YvlCfPcfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894885; c=relaxed/simple;
	bh=hRNz4msQbyeOBSww5jOdLSw/RyltZ5OmlfPSDTQGJNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hm94aD64cfM/AP9BV9s7Se3diFSbaPlYyOAx9eJ+NpukUyyTw8eiVJ9MVWnBOZlR70/I4OmrhfJ2YGKIcbH2wi5TKDV/Av3EJnpIbp66U9OBBfSLvCvBW99R6j4YB5BIF9rzPV2Kr24Dyls0Ei4TktcEjgGOVIPCO4weF7CMczg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LldqS+DQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hUxjbzM6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489DfZdn020294;
	Mon, 9 Sep 2024 15:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=hRNz4msQbyeOBSww5jOdLSw/RyltZ5OmlfPSDTQGJ
	Ns=; b=LldqS+DQB4D1v9F2h0RHt6KBak2FfGUutrY7HOxm0dH1FN2SXQRv+C+iV
	TMk/ltvp9QEMd53xhz9gGQJdf53iyz/PQIwC6TdIkjtwUDu4AsOg8t/aOt0dH5aw
	mt1HOPoYg4ifBjSJUTZPOctcf189BQ3jONEj72VNV43qpl9TxXQswGkBKd4PFbTC
	xebi+uULtYedygX9apOv3y/Bqft/esxDmpMhDORV40WNvV6cWG+1VWcE6i5H6ocY
	RSIcKdMz4QvZIt7UGs+Y/M0G7bflBU4q4Xrn9mnKTLS4OReP5KLrQboVcQja9Ya3
	AWsIq2/YQF67C1bgH9pVXhT8d1ZCg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdrb37mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 15:14:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 489FC35w032456;
	Mon, 9 Sep 2024 15:14:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9dkc41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 15:14:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bd2UL+AgGCqWiPaHoOXsDFzQ5ynKigEjvThzbS6B7esMzPxXIB1T1KdNecRkl+xaR1/qY4cpsuBczAY8laQNIYP3b2FYWeC2jlfPeEKYGhe5R8vCIyDEeP1rLoyKB3iWNBoAF6AXDb/z2diatAycmr7gY23mlO/IaacmhKSGElWIIlc5jB14IBw08zfMNw3uwKGprCHMUvzflKAYUxQF4KE6OSbkq/uUPMZdWgHrvWEF8QVaLjN+sX8VQBVvHpY1RMJS0eS8Z0t2a1+783+3syWkLv1catq/RCVj4yf8DjMh3uHfCI7w3eGaksKDQjX18VX9cxNQsSSHBEEdJPy6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRNz4msQbyeOBSww5jOdLSw/RyltZ5OmlfPSDTQGJNs=;
 b=LZOmclK7Nq11IbGH6/QBlacewFt2a7Ek7p2DKNoFltqyT7NKord/rX1ul+mEXGSZ32OEXjGywZbglOSyscnEp48ykfZXv0wI6xGqmGiFI7BJA+h2IuIkPSzqfV7kimZwjKq1BvAS7KD4Pao4xUvs8eywsR2JqmfYOYKseqq9raS+Rd3VHguXtW+nRpA8jHDjziIs9d8Vu8CdYS71aHN1Ci+Igh2oC/BBMy17ttGR/8VLEl8UIv0oF1mbf70Z7q/vBL3wslx3xqrB8NwTz1zx4fWBwL1KMxonGN9zQh6vJ7Wdh+uCSWryDZd7a4FNuwiUW1Wvv2RdVAfEcXQP1v6n0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRNz4msQbyeOBSww5jOdLSw/RyltZ5OmlfPSDTQGJNs=;
 b=hUxjbzM6ahaLj7uxQOoECpHETU5hPBmS/TKOj03g3NL1RiEQhGIoUT4dFBjbLzGhe2CmeMjm+yXlmU0ZikqbnFACDhuREbVPmAfQZ6olIKAPrKIjAgq962IrZ/Ln+vhvBpFHHOA6h/cTstv8P2sfRW02MWEP565LAcrH3QlXFUw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7141.namprd10.prod.outlook.com (2603:10b6:208:3fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.10; Mon, 9 Sep
 2024 15:14:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 15:14:28 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Olga Kornievskaia <okorniev@redhat.com>
CC: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Dai Ngo
	<dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
Thread-Topic: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
Thread-Index: AQHbAnYWzk/Hpp/79kCmPEQurBPxabJPYZyAgAAfiACAAAWagIAABvkAgAADPQA=
Date: Mon, 9 Sep 2024 15:14:28 +0000
Message-ID: <75AA1426-3884-48D9-9832-1B8B046BDECA@oracle.com>
References: <172585839640.4433.13337900639103448371@noble.neil.brown.name>
 <adadfa97e30bc4d827df194814e4e05aa26b8266.camel@kernel.org>
 <CACSpFtBYpQpAKVOmHLPUOr5LvoYq0-ea_NFMctqhMYSamUL_ZQ@mail.gmail.com>
 <Zt8IOQUF/VEkCPgO@tissot.1015granger.net>
 <CACSpFtCD-yBiO3Oe9m8k9q6Wug6MqgNQmjoT9K8DRAmc3bGLfg@mail.gmail.com>
In-Reply-To:
 <CACSpFtCD-yBiO3Oe9m8k9q6Wug6MqgNQmjoT9K8DRAmc3bGLfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7141:EE_
x-ms-office365-filtering-correlation-id: da48b3cd-2794-4449-142e-08dcd0e21980
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVJweHlZcHpIOG1ON0dMRFhpT0FRN1ZGZDRmalRrZUxBS05VNEJ6eVlIRmRk?=
 =?utf-8?B?VWFVSnZjeWd1azltbmtUZmVZV0VRTEFlYjlNUEZLZWFKbXhuYkUxNDV6Y0sw?=
 =?utf-8?B?dUczTzl1YnNodHNXeEt4M3AvSXhuMVM4TUI5MGYzeSsyVDBZcWhKTEtHc2dL?=
 =?utf-8?B?SnhzWXFPQkNoL3FTbWtHSkpseWIzTTU1bExHMmlKWnNiYnF4SVNTbjliOEk2?=
 =?utf-8?B?ZFVVRGsxQXl6S1BiRjdPamlIbnBoNFZvN294andRay82WW42T3JtSjRYZHp1?=
 =?utf-8?B?NnRtWmprV1lyVzE4Y3k2bnUyMFNiRkRaR2tMcXVYcWJSZGVKd2o5TzJpbG02?=
 =?utf-8?B?eEc2M0pQUlhpd09YR0ZLSjg5RVFDdnQyM09JMGI3UXBseUt1MDhuVlFLcWNF?=
 =?utf-8?B?Zmx3R3BzRi9qREtIU1l2ZG8zR2RvRElnUmZpZkk3M3VGOUgrdGt4ZDJ6N0Zz?=
 =?utf-8?B?ZDJBRDAxYmhyQXBUeFBmbjRWank0N0pyWUV1eWp2OHdlWXVPMEtsN2dNSEJp?=
 =?utf-8?B?bDY2bHdhNmFOaFpGSUhyd2VaV1pWdTlNNHRYWHoyYjdaaHY3R0pCMjRNaXhr?=
 =?utf-8?B?RVFEL0dRenAxeDZvZGV1TE5DKzV0TjN3S0IwRTZVb2NKL2FSQjZzU0FFdThJ?=
 =?utf-8?B?TnRjTERmTksrYmV6dTl4VG9JRk1Uak93RnFyaXhjL1lEZnIvNUlSMXpwTjZI?=
 =?utf-8?B?NWU3TEdISk43eDdLOTl1WVJTQ3h0Qm81cWxVdEZMNXJ0dTQyVS9iMjVhcmd1?=
 =?utf-8?B?dkoxSzFOalZxYzVQM3dVQjRCdDVhb3pKQWRGcTNFUGVPNWpFaFkrMkJTQXJq?=
 =?utf-8?B?K3lWRHE4VzhDT2o5Y3YvWkgrWHJlREJZZG94bUlDUnVHUkF2MGllbE9LVU1p?=
 =?utf-8?B?WTZTSVl2Q3BrbmNNaDN3ZHl3U0c3RWZFZVFTRG9VL0J1ZCt6OTcvOXBiZXo4?=
 =?utf-8?B?TUtqZHFqcFIrSFlmT1dGeFBwUUs0QVhUak93RnFBRThxaU14bVJCSndJU1pP?=
 =?utf-8?B?UnhSN3hOVkdvN3BQaENoa2QwZEVXYzBiNWplQi9iMlBrWk1nRE5nYXFESTZy?=
 =?utf-8?B?ayttRkhrSkZwL3JjY1Y3YkY5WVlQVFFWdGo5R1l1c1BhRTBVWHZOOXJJWER6?=
 =?utf-8?B?SStqVWhNcFFZR0dPSnhMbHZDNUNieUY3VjdiaDYwcDAwR3RGSngvNnVnemow?=
 =?utf-8?B?V05TVDVyTWFIL0ZiL0RaTXR2MVE5SWlpdnQ5bkY5Wll4VEN3RXh4TzhqdUFZ?=
 =?utf-8?B?TThYMGtGemJxdzFnNWZoMXpqbkY4WjNMMjk1cTQzWXZHYnlEbWdpSkJSM0ZW?=
 =?utf-8?B?bHp1anNTeXdTNGJTOXVnOVJIcXh0eHp3ZGk3Q2hTOWxlN2VZczk5cVhYaW9N?=
 =?utf-8?B?MmpLNXlZNkpheWtIMy91K29xL05BS2szK0lVcDZSNGdmaXJpeEt5Rk9UVHVv?=
 =?utf-8?B?NUNwUmhCTzcxODRsMTR4WG92ajFRdUkrYTZLLzVmeGcxUERNQ1pYMTFPakRm?=
 =?utf-8?B?eGVoTXkzb1RiMDV2akxYaUVFeXRNZDZTYjhXd0ZKRFcxU0pnWk54cDlxanNY?=
 =?utf-8?B?bUdjT1diUUg2N2ZpS00wb0FTZjEvRHJtd2RhZzZkMDRJMjl4UTBiTm5lTmlD?=
 =?utf-8?B?Yk9LVFNwRHY2aEpUdXZwYlY1NWNDV3dOVDAvZDQrUmR2NE1EeWFXeHA1ZnZz?=
 =?utf-8?B?OVlNcVg4THpGNlJud203WDlJdE1BWGlGUnBrMndUSmxiejYvUkxwQUJ2Z3gx?=
 =?utf-8?B?VDh4dUNOOEtOMitaMUZiOFIyOU51ak9DbnEweTZDT0dqWFBtYTdMTm5Sdzlm?=
 =?utf-8?B?NVRPYXlBTlBwL0lvUHJ2WXJNWjRuc0M5K2xyb2JJUWkySGhSdGYxVGF5VjlO?=
 =?utf-8?B?V1pBS1hvSEVRcXY3L2FjYkhEek1aY3FrczJrQUN6b2VsOWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0ZEYlM4UjE1cXhabGFQd2VSckl1bjNuMWhWTHkrbXhFYnpQVEEzdFNxNXFr?=
 =?utf-8?B?cU5PVkNJVlpmOHhpSDNyU1MwdWp1V3NtU2YwbTlFKy9EYnRxSHlqWnozY0g2?=
 =?utf-8?B?dlJ2dkNaUldoSVVsRHhJRGNNcjNENmJpalQ0TEhGNUQzVW1KZWxzNk44cFR4?=
 =?utf-8?B?SzV4Q0RHRVp3K2hWbFlYYllYcExsc0p4R29KNjZsQWpNTjF5Tnp6SHhzVGRK?=
 =?utf-8?B?bVZYcGhYV2RyZG4yRkJ4WE5GRlNlSnRpZERiR2I1NmR2T1F5MHZNMVNEZkZx?=
 =?utf-8?B?a0pHSXJHRGd1QmtqZ2l3N2ZvUjYvNFBNSWM4VDROeTdBbE8xQmhDZVpYSk1W?=
 =?utf-8?B?Uit6amVvRmF3by9RVEhBc2xWUFdGU0hKOVArQ1ZadkZDTnYxa3JmTElpMk5m?=
 =?utf-8?B?QWdyVndTU2prWDU1NTR3Z3licTdUbGV2SjcycGxmalVqVGNiR20rNENtcEhD?=
 =?utf-8?B?RnFGTkh4OXlMUVJ0NnhwZnJybVZSWUowOGE5djVMZFpHMmppRDJCU2JFTjJi?=
 =?utf-8?B?QnJ1UEV2UDJOcVhxMVpPNlp2c3dOcnhZK0IxU2NYa1NuWmtodnR4OVQyWUVh?=
 =?utf-8?B?SW9QUjE1dzdNaDh4VmFlcXgwazl3bXd6MTBQSGRRSXBuTDFYQnJYVGpkRlkz?=
 =?utf-8?B?aERnSkV2V212eVVOaGc5Q0IweEw3cG5BTCtidktyVU9jZURlcThKZWNTNW4y?=
 =?utf-8?B?ZC9qdVpQeHBoVkI3QzNWOW01clNKSCttRWM2V0hnUGp2L3ZEazUvbDJWa0hQ?=
 =?utf-8?B?N3VHUnlMOUxoL1lHSEozRTdjNHkzek1RUUZBTGtvcm9HSU92aktoR3RDWGcv?=
 =?utf-8?B?cXMwd29aaVZIN0kvVUx4aVk3cFFRcElDOGYrTjQrRFd0OGUrOHZNQmorbWFt?=
 =?utf-8?B?UlRub3N2YzFXTHMzbTQ1SDNYNklJMXo3T2pQT0x6a2tabCt6NDFGeXFxekJa?=
 =?utf-8?B?eWdWY2dweGx5eTc1amQwdGM1RW9waG4yWjA4RVZhUm5tenpDL2dyaXhtVVJn?=
 =?utf-8?B?Zk1IcTRpL1ZCY1VadkJBWmFsYkhSZDYrWmFlUFNWTEFMYzVlY3IvUlE4Zmp5?=
 =?utf-8?B?dnNMR2ZBTm9BVU1kRXN0cXBqVjBnZ0Z4NDljcmpiaFJOZ3RCZ0JuQmZiaElk?=
 =?utf-8?B?S01aY1FJU1NpblpaV2FTUC9EMjN3YnFWcTZkeTlhSHBTZ1pHZVV6Ly9GUm53?=
 =?utf-8?B?L3NBaGVZZ1BTeEVLVEp2cHF6TEJvVm5tamVyUUIzRTJ0aVJXWGtvSS9ER0xW?=
 =?utf-8?B?a0dHQUZ3SmdCSk9lT3BIbEZhT1gxYTQ5QS9LQVZpbW9qcEJpQ3BzNlRWbTZK?=
 =?utf-8?B?KzgrRXl3L3d0Wng0OWVjQnMzRE5pdEduWUIwcmwxRzBmNGhEcUd1M1BYT1Fw?=
 =?utf-8?B?NDdPQ1d4ZDcwVUl6NjNVNmsrcGI2dmRhdzNnN3pkNy9aTUpVTExja1VZRGhL?=
 =?utf-8?B?dDVnbFcxNi9IS1pjS3g0eGU5THVnYWtpTGxVRmdPZlptTjBaZjl3c1J4N3dL?=
 =?utf-8?B?eHBKa2ozZUl4bjhFNmp5eTk1d2FiOVlrN0h3ZGE0ZUhWbUNYcmErTVRTdzlx?=
 =?utf-8?B?cHBuOHRLamhoMWNDd1RMUVZER1dtMlVvR1FZYUxhSTBwUHhRZzBwOWV5bWJt?=
 =?utf-8?B?UVJQNWhOT1ZucUsvc29KVFFYZzErcHljeGdld1FQQzMzcEtFbE9QRFZONis1?=
 =?utf-8?B?blRRRGtYUUtiNlA2d2RFR0ZkSlJiZHBiYjlEL0ZuMVNlM0ROYk55R1FWSzd2?=
 =?utf-8?B?bWNIQTBWVmcxYjdscERhajNSTmNaY3NuUm1CVFB5UWVBekRTNVJTY1Arbncz?=
 =?utf-8?B?bndXaGxRSklqS2Voa3h3SnFkVWlJa0t6cThkc1R3Mk5mM3o2dXJnT2UweFI3?=
 =?utf-8?B?MzhpTUU5SW5MQ0JTNFpGWVFYVnhrYUNya2FIZDB3SUhXZGV0SllpZHZJd2hY?=
 =?utf-8?B?S0pzS1hOeUNjZ3MyV2E4UVROUjZOSExDVzdZdlhYSkoweENySktQVlhtTTY5?=
 =?utf-8?B?cG9wRUd3MzhRODRJREdVYUs4NjhRQUtLb0NPWXRiWFN1NHB2VHp0WUwwaVlj?=
 =?utf-8?B?WnFzZTFCYzJmaktveEZlRW50ZFd1eDdGSWVrRFphT0grRU9RdEJ2OG5KZmhV?=
 =?utf-8?B?UnNRalRPdzFnN2ZNNExITitvUkRMdkoxMHJEdlVEbVYycnZFZFEyWEdBVXdj?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F27E6581D41BCC46B338890FE811D1E0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iEs/ZRYKPl2mT70kG4qhmopQYbiFnqYrucxcFjso/xl1asXAQiAAq2NTD4P0HAwf4qIfRG9q983oJQr3iVS3eggfzcCqAkqhqb3Im5P/XBXum1h3kYBrhc9XWCByXz0tgmytT1Hv2YNmt1LhCO84GoSOzkVaEBn7gC4HaaBjGnKtDiFwyYMw2Ct5Oe55ZvMtxjy+3VEojjrsXGUDi+pWPCqyJ6kFa7x382m+6JGovrAZJo5XJNyrzNcxAhA0/5UU5cOD4ElcvQL/qnBLlzNBXV9on+R/orhO9algR3nhO8ay2FWWwEpHWGtRE7YRv8mJuCPQY7YCvCo1B1E4puBKgk/KEMctrw6YiXWRZZX/61e+pCAyraiIZ3Swf6BqvAHJZiTCm+sXMwyqhEaN4JZXtkFiXw80gntNSr4BnWRe6LePUtRQZngbkR+nt1Rw1YqbUHxwObx7uuYFfezgcq2CVQG4jTxw7ATN6YCzGxHH/gByolkiLqAu9aJAWoNmLALYIkTWY8TEZXmCDmitkDWCsKzpCxjwV8ENOjPlEjs6UMmiBE0Xttq2gsbVkrJJ9/BM1FJJmTuw40C6YH8PVCmztVJT7tU+UwngCoagW4Y/qWU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da48b3cd-2794-4449-142e-08dcd0e21980
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 15:14:28.8506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2R+SE5EEhW5qEvsoNW6dX3ki/nmsLWbDd64RXGoQSsTlU/SwGEKiLrPvfai6tQp0UBfXWb0S3XdciENdqczjdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_07,2024-09-09_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409090120
X-Proofpoint-ORIG-GUID: 2dAAfdpOe4k5X_FRt_fWHWKG7kzYvHQf
X-Proofpoint-GUID: 2dAAfdpOe4k5X_FRt_fWHWKG7kzYvHQf

DQoNCj4gT24gU2VwIDksIDIwMjQsIGF0IDExOjAy4oCvQU0sIE9sZ2EgS29ybmlldnNrYWlhIDxv
a29ybmlldkByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgU2VwIDksIDIwMjQgYXQg
MTA6MzjigK9BTSBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+
PiANCj4+IE9uIE1vbiwgU2VwIDA5LCAyMDI0IGF0IDEwOjE3OjQyQU0gLTA0MDAsIE9sZ2EgS29y
bmlldnNrYWlhIHdyb3RlOg0KPj4+IE9uIE1vbiwgU2VwIDksIDIwMjQgYXQgODoyNOKAr0FNIEpl
ZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+PiANCj4+Pj4gT24gTW9u
LCAyMDI0LTA5LTA5IGF0IDE1OjA2ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+Pj4+PiBUaGUg
cGFpciBvZiBibG9vbSBmaWx0ZXJlZCB1c2VkIGJ5IGRlbGVnYXRpb25fYmxvY2tlZCgpIHdhcyBp
bnRlbmRlZCB0bw0KPj4+Pj4gYmxvY2sgZGVsZWdhdGlvbnMgb24gZ2l2ZW4gZmlsZWhhbmRsZXMg
Zm9yIGJldHdlZW4gMzAgYW5kIDYwIHNlY29uZHMuICBBDQo+Pj4+PiBuZXcgZmlsZWhhbmRsZSB3
b3VsZCBiZSByZWNvcmRlZCBpbiB0aGUgIm5ldyIgYml0IHNldC4gIFRoYXQgd291bGQgdGhlbg0K
Pj4+Pj4gYmUgc3dpdGNoIHRvIHRoZSAib2xkIiBiaXQgc2V0IGJldHdlZW4gMCBhbmQgMzAgc2Vj
b25kcyBsYXRlciwgYW5kIGl0DQo+Pj4+PiB3b3VsZCByZW1haW4gYXMgdGhlICJvbGQiIGJpdCBz
ZXQgZm9yIDMwIHNlY29uZHMuDQo+Pj4+PiANCj4+Pj4gDQo+Pj4+IFNpbmNlIHdlJ3JlIG9uIHRo
ZSBzdWJqZWN0Li4uDQo+Pj4+IA0KPj4+PiA2MHMgc2VlbXMgbGlrZSBhbiBhd2Z1bGx5IGxvbmcg
dGltZSB0byBibG9jayBkZWxlZ2F0aW9ucyBvbiBhbiBpbm9kZS4NCj4+Pj4gUmVjYWxscyBnZW5l
cmFsbHkgZG9uJ3QgdGFrZSBtb3JlIHRoYW4gYSBmZXcgc2Vjb25kcyB3aGVuIHRoaW5ncyBhcmUN
Cj4+Pj4gZnVuY3Rpb25pbmcgcHJvcGVybHkuDQo+Pj4+IA0KPj4+PiBTaG91bGQgd2Ugc3dhcCB0
aGUgYmxvb20gZmlsdGVycyBtb3JlIG9mdGVuPw0KPj4+IA0KPj4+IEkgd2FzIGFsc28gdGhpbmtp
bmcgdGhhdCBwZXJoYXBzIHdlIGNhbiBkbyAxNS0zMHMgcGVyaGFwcz8gQW5vdGhlcg0KPj4+IHRo
b3VnaHQgd2FzIHNob3VsZCB0aGlzIGJlIGEgY29uZmlndXJhYmxlIHZhbHVlICh3aXRoIHNvbWUN
Cj4+PiBub24tbmVnb3RpYWJsZSBtaW4gYW5kIG1heCk/DQo+PiANCj4+IElmIGl0IG5lZWRzIHRv
IGJlIGNvbmZpZ3VyYWJsZSwgdGhlbiB3ZSBoYXZlbid0IGRvbmUgb3VyIGpvYnMgYXMNCj4+IHN5
c3RlbSBhcmNoaXRlY3RzLiBUZW1wb3JhcmlseSBibG9ja2luZyBkZWxlZ2F0aW9uIG91Z2h0IHRv
IGJlDQo+PiBlZmZlY3RpdmUgd2l0aG91dCBodW1hbiBpbnRlcnZlbnRpb24gSU1ITy4NCj4+IA0K
Pj4gQXQgbGVhc3QgbGV0J3MgZ2V0IHNvbWUgc3BlY2lmaWMgdXNhZ2Ugc2NlbmFyaW9zIHRoYXQg
ZGVtb25zdHJhdGUgYQ0KPj4gcGFscGFibGUgbmVlZCBmb3IgZW5hYmxpbmcgYW4gYWRtaW4gdG8g
YWRqdXN0IHRoaXMgYmVoYXZpb3IgKGllLCBhDQo+PiBuZWVkIHRoYXQgaXMgbm90IHNpbXBseSBh
biBpbXBsZW1lbnRhdGlvbiBidWcpLCB0aGVuIGRlc2lnbiBmb3INCj4+IHRob3NlIHNwZWNpZmlj
IGNhc2VzLg0KPj4gDQo+PiBEb2VzIE5GU0QgaGF2ZSBtZXRyaWNzIGluIHRoaXMgYXJlYSwgZm9y
IGV4YW1wbGU/DQo+PiANCj4+IEdlbmVyYWxseSBzcGVha2luZywgdGhvdWdoLCBJJ20gbm90IG9w
cG9zZWQgdG8gZmluZXNzaW5nIHRoZSBiZWhhdmlvcg0KPj4gb2YgdGhlIEJsb29tIGZpbHRlci4g
SSdkIGxpa2UgdG8gYXBwbHkgdGhlIHBhdGNoIGJlbG93IGZvciB2Ni4xMiwNCj4gDQo+IDEwMCUg
YWdyZWVkIHRoYXQgd2UgbmVlZCB0aGlzIHBhdGNoIHRvIGdvIGluIG5vdy4gVGhlIGNvbmZpZ3Vy
YXRpb24NCj4gd2FzIGp1c3QgYSB0aG91Z2h0IGZvciBhZnRlciB3aGljaCBJIHNob3VsZCBoYXZl
IHN0YXRlZCBleHBsaWNpdGx5LiBJDQo+IGd1ZXNzIEknbSBub3QgYSBiaWcgZmFuIG9mIGhhcmQg
Y29kZWQgbnVtYmVycyBpbiB0aGUgY29kZSBhbmQgbmFpdmVseQ0KPiB0aGlua2luZyB0aGF0IGl0
J3MgYWx3YXlzIGJldHRlciB0byBoYXZlIGEgY29uZmlnIG92ZXIgYSBoYXJkY29kZWQNCj4gdmFs
dWUuDQoNCkkgd291bGRuJ3Qgc2F5IG5haXZlLiBCdXQgdGhlcmUgaXMgYWx3YXlzIGEgY29zdCB0
byBleHBvc2luZyBzdWNoDQpwYXJhbWV0ZXJzIChkb2N1bWVudGF0aW9uLCBsb25nLXRlcm0gbWFp
bnRhaW5hYmlsaXR5LCB0ZXN0IG1hdHJpeCwNCnVzZXIgY29uZnVzaW9uLCBhbmQgc28gb24pLiBU
aGUgY29zdHMgYXJlIHNvbWV0aW1lcyB3ZWxsIG9ic2N1cmVkLg0KDQpJJ2QgbGlrZSB0aGUgYmVu
ZWZpdCB0byBhdCBsZWFzdCBtYXRjaCB0aGF0IGNvc3QuDQoNCkJ1dCBwb2ludCB0YWtlbi4gV2Ug
Y2FuIGhhbmRsZSBtYWdpYyBudW1iZXJzIHdpdGggbW9yZSBjYXJlLg0KDQoNCj4+IHByZXNlcnZp
bmcgdGhlIENjOiBzdGFibGUsIGJ1dCBoYW5kbGUgdGhlIGJlaGF2aW9yYWwgZmluZXNzaW5nIHZp
YQ0KPj4gYSBzdWJzZXF1ZW50IHBhdGNoIHRhcmdldGluZyB2Ni4xMyBzbyB0aGF0IGNhbiBiZSBh
cHByb3ByaWF0ZWx5DQo+PiByZXZpZXdlZCBhbmQgdGVzdGVkLiBKYT8NCj4+IA0KPj4gQlRXLCBu
aWNlIGNhdGNoIQ0KPj4gDQo+PiANCj4+Pj4+IFVuZm9ydHVuYXRlbHkgdGhlIGNvZGUgaW50ZW5k
ZWQgdG8gY2xlYXIgdGhlIG9sZCBiaXQgc2V0IG9uY2UgaXQgcmVhY2hlZA0KPj4+Pj4gMzAgc2Vj
b25kcyBvbGQsIHByZXBhcmluZyBpdCB0byBiZSB0aGUgbmV4dCBuZXcgYml0IHNldCwgaW5zdGVh
ZCBjbGVhcmVkDQo+Pj4+PiB0aGUgKm5ldyogYml0IHNldCBiZWZvcmUgc3dpdGNoaW5nIGl0IHRv
IGJlIHRoZSBvbGQgYml0IHNldC4gIFRoaXMgbWVhbnMNCj4+Pj4+IHRoYXQgdGhlICJvbGQiIGJp
dCBzZXQgaXMgYWx3YXlzIGVtcHR5IGFuZCBkZWxlZ2F0aW9ucyBhcmUgYmxvY2tlZA0KPj4+Pj4g
YmV0d2VlbiAwIGFuZCAzMCBzZWNvbmRzLg0KPj4+Pj4gDQo+Pj4+PiBUaGlzIHBhdGNoIHVwZGF0
ZXMgYmQtPm5ldyBiZWZvcmUgY2xlYXJpbmcgdGhlIHNldCB3aXRoIHRoYXQgaW5kZXgsDQo+Pj4+
PiBpbnN0ZWFkIG9mIGFmdGVyd2FyZHMuDQo+Pj4+PiANCj4+Pj4+IFJlcG9ydGVkLWJ5OiBPbGdh
IEtvcm5pZXZza2FpYSA8b2tvcm5pZXZAcmVkaGF0LmNvbT4NCj4+Pj4+IENjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnDQo+Pj4+PiBGaXhlczogNjI4MmNkNTY1NTUzICgiTkZTRDogRG9uJ3QgaGFu
ZCBvdXQgZGVsZWdhdGlvbnMgZm9yIDMwIHNlY29uZHMgYWZ0ZXIgcmVjYWxsaW5nIHRoZW0uIikN
Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE5laWxCcm93biA8bmVpbGJAc3VzZS5kZT4NCj4+Pj4+IC0t
LQ0KPj4+Pj4gZnMvbmZzZC9uZnM0c3RhdGUuYyB8IDUgKysrLS0NCj4+Pj4+IDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4+PiANCj4+Pj4+IGRpZmYg
LS1naXQgYS9mcy9uZnNkL25mczRzdGF0ZS5jIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPj4+Pj4g
aW5kZXggNDMxM2FkZGJlNzU2Li42ZjE4YzFhN2FmMmUgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9mcy9u
ZnNkL25mczRzdGF0ZS5jDQo+Pj4+PiArKysgYi9mcy9uZnNkL25mczRzdGF0ZS5jDQo+Pj4+PiBA
QCAtMTA3OCw3ICsxMDc4LDggQEAgc3RhdGljIHZvaWQgbmZzNF9mcmVlX2RlbGVnKHN0cnVjdCBu
ZnM0X3N0aWQgKnN0aWQpDQo+Pj4+PiAgKiBXaGVuIGEgZGVsZWdhdGlvbiBpcyByZWNhbGxlZCwg
dGhlIGZpbGVoYW5kbGUgaXMgc3RvcmVkIGluIHRoZSAibmV3Ig0KPj4+Pj4gICogZmlsdGVyLg0K
Pj4+Pj4gICogRXZlcnkgMzAgc2Vjb25kcyB3ZSBzd2FwIHRoZSBmaWx0ZXJzIGFuZCBjbGVhciB0
aGUgIm5ldyIgb25lLA0KPj4+Pj4gLSAqIHVubGVzcyBib3RoIGFyZSBlbXB0eSBvZiBjb3Vyc2Uu
DQo+Pj4+PiArICogdW5sZXNzIGJvdGggYXJlIGVtcHR5IG9mIGNvdXJzZS4gIFRoaXMgcmVzdWx0
cyBpbiBkZWxlZ2F0aW9ucyBmb3IgYQ0KPj4+Pj4gKyAqIGdpdmVuIGZpbGVoYW5kbGUgYmVpbmcg
YmxvY2tlZCBmb3IgYmV0d2VlbiAzMCBhbmQgNjAgc2Vjb25kcy4NCj4+Pj4+ICAqDQo+Pj4+PiAg
KiBFYWNoIGZpbHRlciBpcyAyNTYgYml0cy4gIFdlIGhhc2ggdGhlIGZpbGVoYW5kbGUgdG8gMzJi
aXQgYW5kIHVzZSB0aGUNCj4+Pj4+ICAqIGxvdyAzIGJ5dGVzIGFzIGhhc2gtdGFibGUgaW5kaWNl
cy4NCj4+Pj4+IEBAIC0xMTA3LDkgKzExMDgsOSBAQCBzdGF0aWMgaW50IGRlbGVnYXRpb25fYmxv
Y2tlZChzdHJ1Y3Qga25mc2RfZmggKmZoKQ0KPj4+Pj4gICAgICAgICAgICAgIGlmIChrdGltZV9n
ZXRfc2Vjb25kcygpIC0gYmQtPnN3YXBfdGltZSA+IDMwKSB7DQo+Pj4+PiAgICAgICAgICAgICAg
ICAgICAgICBiZC0+ZW50cmllcyAtPSBiZC0+b2xkX2VudHJpZXM7DQo+Pj4+PiAgICAgICAgICAg
ICAgICAgICAgICBiZC0+b2xkX2VudHJpZXMgPSBiZC0+ZW50cmllczsNCj4+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgICBiZC0+bmV3ID0gMS1iZC0+bmV3Ow0KPj4+Pj4gICAgICAgICAgICAgICAg
ICAgICAgbWVtc2V0KGJkLT5zZXRbYmQtPm5ld10sIDAsDQo+Pj4+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc2l6ZW9mKGJkLT5zZXRbMF0pKTsNCj4+Pj4+IC0gICAgICAgICAgICAgICAg
ICAgICBiZC0+bmV3ID0gMS1iZC0+bmV3Ow0KPj4+Pj4gICAgICAgICAgICAgICAgICAgICAgYmQt
PnN3YXBfdGltZSA9IGt0aW1lX2dldF9zZWNvbmRzKCk7DQo+Pj4+PiAgICAgICAgICAgICAgfQ0K
Pj4+Pj4gICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZibG9ja2VkX2RlbGVnYXRpb25zX2xvY2sp
Ow0KPj4+PiANCj4+Pj4gLS0NCj4+Pj4gSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4N
Cj4+Pj4gDQo+Pj4gDQo+PiANCj4+IC0tDQo+PiBDaHVjayBMZXZlcg0KDQoNCi0tDQpDaHVjayBM
ZXZlcg0KDQoNCg==

