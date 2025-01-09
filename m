Return-Path: <linux-nfs+bounces-9026-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC1DA07C64
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 16:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94A33A31EA
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 15:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63122339;
	Thu,  9 Jan 2025 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kEd9DjUG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jSncBcbY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C8F14D6F9
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437810; cv=fail; b=f+RLdE/nk6mxPb7io3txxHaGkKXdRgURkCaEDRBtT5bpQ3usdzU4O79WjeNqWZ7TAe1mkufoUnQnr95o0SFCAszGaGPaxl2dngeXubgzBYjK0CXA5hwbEwXYWyHg4pWtVFWhA4Cy0ECMZvmKsLAC2BWZ6rvzj7h4EQZV9oU0mxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437810; c=relaxed/simple;
	bh=DB01e96jJ2XOT8wbdVUDzMk7gxYqv8c2QNTNrRqJo8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gbAbTSXLME4jD+Quu2UxTOpo4eymEH4MX7ljLhuFDTYxpFnEwdlGdd0e0Lag4sL2k9n4QKF/EMHZbvall4xhiJ15raU8Cn4/r4LTNe8MToXnMpkR7lERJrwVcrRGgR0KWQe0eZzq45SANfgeyy00AsZweNRFT+h5YFvsJLZoYTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kEd9DjUG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jSncBcbY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509FlKZs028216;
	Thu, 9 Jan 2025 15:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=W3YfKw6uOhB7iOMSDJlZc/wXvjwwCUCs48WphtdeHOI=; b=
	kEd9DjUG+bqElRZ2FWUsXRcYrAJj1ZPGJuK7gDv63UA6yYn7kAc7dZ8xPf3MFC0L
	hBouN/xSjSEqvYJsK3Dp5ZPzsX+JZm2tdgZX6UnOIKApG1f7QsDEnJdXOzrToXMF
	tDy7hjZk7cheOdqamJx6ZL+VyJUMxpieS3/CqACDlhf0d+TZcDft1/PZoAW7b6Ox
	ZNCKlOSdZcW92WwfPdJfpk9aqHezzOj2aKL5+0rdoTbdQoXW6K07Hf/gkPfiKqpX
	i6ITkQLH4eWpt6LJE5xdW5BthaNx1HycRaln8x6gyk2WUkd9TLJgOBc4XyY20xS9
	kRR5lPpr7skPOlrGsaHaSQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xudc9dgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 15:49:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 509ExcvS011050;
	Thu, 9 Jan 2025 15:49:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xueb2ynx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 15:49:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkhAHyZsktQE7nrPxRMc4JWIqjnTof7s7atJG/s2+25hAZStB9L9PDqVsLS7pIUlyrzTcydZvehD/7ah9GwE2ibaJgRkbwtVteAiYZ5gdEcsxYZ7mcPEg0N/m8HLq3nOAe08OJUdHGLnperRhmxxntzSFIKRnNaNEK/j8r0otVIlkczGQB+NvX3oaXUbWKe5dHTcWxMEyiojpUhx5S4U1YibxqCCmfmMGc1YqM0mzVHzOFbia53rfXg+jG3MPjYPB2C9j38kXNRhcVE3W3XP0w1EH64piV5uvgx3DIJv7gr5Nf7EM/92PvWCIE5LZbbqXshi9VjOCVGeh616NlHNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3YfKw6uOhB7iOMSDJlZc/wXvjwwCUCs48WphtdeHOI=;
 b=LCG1TTjxgAVtoi26Z1bBAkJbKEC2prURoJslLjvdIbUrXrinMVbOO/dTB0WBcby4gNTNLLFQwufmYJP6N3CqUi2Yac5Ac6AP8ccvorT/BGRrfXhnm8p4qhTIKCZCQ5NO6MZeP+cCUCkJkLchS1aoU8NHDEIKNfErVQXkWKQxZfWQMoeQhzIYht+xsed46NGdqjew0I0/pjJC00iHU6DUJBreCGP/Ub5ih8CiTdDAe3QZPoNLmq6v9EvwakiSJEk1eRfZuZi+OpNcU+5lMxg95U/uUoi3/ktlIzq1CBu7ZOogPmkL4mY9kWe6hKP91QrszkfaBIKJ1xTTBj6TZeguvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3YfKw6uOhB7iOMSDJlZc/wXvjwwCUCs48WphtdeHOI=;
 b=jSncBcbY/2+pJbcYxxIhZYDaZ+gLeu36AKEXOU3oCAYobBCT4RlvwBHp+6ndZfAqWdmMufdw5F0cuJpII3WrCxDm57N2e+RmHLg1LxmjfN/AcfMi9sya9yMunBqAw2irRALyp6rYcCyaVHibmO9xtQAOqcKhcCys0fIhGsrLV6M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5071.namprd10.prod.outlook.com (2603:10b6:5:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Thu, 9 Jan
 2025 15:49:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 15:49:39 +0000
Message-ID: <da2be7f1-3c05-4de7-ac22-fb4cbd4e52fb@oracle.com>
Date: Thu, 9 Jan 2025 10:49:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd blocks indefinitely in nfsd4_destroy_session
To: Christian Herzog <herzog@phys.ethz.ch>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Harald Dunkel <harald.dunkel@aixigo.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Martin Svec <martin.svec@zoner.cz>,
        Michael Gernoth <debian@zerfleddert.de>,
        Pellegrin Baptiste <Baptiste.Pellegrin@ac-grenoble.fr>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <Z2vNQ6HXfG_LqBQc@eldamar.lan>
 <ecdae86c-2954-4aca-bf1c-f95408ad0ad4@oracle.com>
 <Z32ZzQiKfEeVoyfU@eldamar.lan>
 <3cdcf2ee-46b3-463d-bc14-0f44062c0bd0@oracle.com>
 <Z36RshcsxU1xFj_X@phys.ethz.ch>
 <7fb711b1-c557-48de-bf91-d522bdbcc575@oracle.com>
 <Z3-5fOEXTSZvmM8F@phys.ethz.ch>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z3-5fOEXTSZvmM8F@phys.ethz.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:610:e5::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: 620b83c4-2f45-41ae-e6d3-08dd30c539ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUgxWGI0YmRxcXFjQzdBM2llYnY2eVZhY1VNK1lqQTdIQWpicjk1OERVQXpE?=
 =?utf-8?B?RDYxak9kSXZJL3BMNDRuUlpTVUFPcGZoRGFhVnJhSGxiakl5MG8zY2VWUmdj?=
 =?utf-8?B?Z3k1b2ZyYVJzd1NOOUF3aWJjTmZsNDdNTm82QUJyN200QnZXMkdrODFBaU1K?=
 =?utf-8?B?dkNqSk9RMmh2VW1HNUx1dzFUblBDcDB1QVlXb2N4RFNkSERucmZOd1hsN25h?=
 =?utf-8?B?Tlp0bnM1OVNJa1RwR0l3UUNjRFpuTG5QRHdyVWFScVIvakljV0lmVmhLNGcy?=
 =?utf-8?B?TW03d2ZCdWgvQWFTS1RFZGxvZWY2MDhDbGV4K0psK1NFLzBHY2g0emN0QVRZ?=
 =?utf-8?B?V3RyOWQwWWZmR2VUVjRPY1Q2dFR4b2pkV1JrU25WOEp6SStlSmY5ejVYZ3NX?=
 =?utf-8?B?TVU2UXhJMlBZb0IzSHdqNE9oRytUK0tiSGlVb3lyc0hOc3FqSmhiamFMYXlo?=
 =?utf-8?B?Z0xTMVJaUU43RHhTUWNZQzB2UnA1SHM1VElsOXdYbTgyMERONllWSFEyR0F1?=
 =?utf-8?B?NElaTGVSS3VWUEJTTWZ1ZzNkNVlIUDVCNkhKWmxUQkE5eE5uSEcxNStud2ll?=
 =?utf-8?B?MHNuWU1qc1NTRU9ZUUkzbFlqODkyeE4zQldxYkMweHo2R1ZmWkhtYmNLOWdn?=
 =?utf-8?B?NytzajBVSmpkc0thRjBhRk5yNXIzTjI2NGFvSHdvdHN1L25acHJKRWUyWDNm?=
 =?utf-8?B?dUI3OGtZWUQrWHUzbm15RVo2UFp2cGhwRzk3ZEtwd0pzb1VXVzdsbk1seVRo?=
 =?utf-8?B?U1lNNmphM3lqamIvZlpmSFlZLzdCV2djU29lTy9yMlpMRzFJVVZLeFVQS0dL?=
 =?utf-8?B?VWtEaGRYb3hUWHU5MmYxL3NkWDh1UmthcjFxdm1uQkVPcHVWaVF3V2YzcWZZ?=
 =?utf-8?B?TVhVMEp0ZTFnL0UxdkhVZEhXS09hWHBHcUVSWExtL0pCcG5UazRtaHJNQmhJ?=
 =?utf-8?B?b3lueFVMOXEyRlNxdDYySkwwSXozc3h0ZWNmajRwVFQ1bE0vTlUwM0xONkZl?=
 =?utf-8?B?RXVuU3FSc3dzb3UvWWxnK3Nnc2o3T0grWTVzeU1UWm9yQ0dnVVZzOTZXeEhW?=
 =?utf-8?B?b2pxVVZRRytvanVhY01xOHIyMzN4QmNKVm1CQ3o3T0lHSDdnNzFwN01RekVW?=
 =?utf-8?B?azJvRnNkWjBvVkRXellwU1drbzB3QktLTVpZQVUrai9nU21Hb0JNdHhPNHNu?=
 =?utf-8?B?MXVNNnNtU0xMT2E1d3FUdFhZdDFmU1BvcXJLU0dLSGhJNEhmQ0lxSml3ODMr?=
 =?utf-8?B?VkFOTTF5c29nay9yWnJqMEdOQlc4bS92MGY5T3VjRHA4SnozcEJqbzBEclMr?=
 =?utf-8?B?UzFnNTdVaHE4ZkVoU3pQNnljSkI5azhQeGI3cndLMkk1WCtYekFTM2tsU3Zj?=
 =?utf-8?B?YXpxRFJzY29DRkpUWi9nUzY2dmVESFZheEpBVXBsZlBYYkJrQnlIbjZiVDgx?=
 =?utf-8?B?Vm5GajlyQklMRzNYbjJORzQvb0VyZUFVbkF6V2RhWW9IMldDR0ZqMzRmQkNm?=
 =?utf-8?B?R0pMQ0RTOW50UUo1NGtLR3BMMDBZdWcrWWNWQ004RHFvVnIxR1FuQzZKRlFl?=
 =?utf-8?B?TkgxTXJFWEZJRTQ5RHZoNnRWVURjWS95VnhJUTRuNkZuTExnWDVWNHpvL1NQ?=
 =?utf-8?B?Q0RnOXJpV3NPZ09BRWFxNlVXOGtWZjBtWFdvSFZoNGg0N0NFTE1CbDZZZW5h?=
 =?utf-8?B?Q1JhSVQyUUliMmVLZmdPZmdmT00yK3dwM0pMbkVHbjdyd1JoSWxqcEo3QlI2?=
 =?utf-8?B?Ti9xZS9JTFN1UzJXWnBJZzJqb01wTFJJc0pZUVA0K2MyVi9LRmU1ZGZ1V2I0?=
 =?utf-8?B?akVpL1h5RklLOGs0QTVuUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGdLd2c1eHBjMWRvMzhaS1ExLzV2TVdSZEx4T0ZlWk1MczhKa3pJOEQ1Zk81?=
 =?utf-8?B?cElFSmZTd1BLYXNJN2p2VGdHaElqUmRyWGg0eFMrdHU1NFQ2UkN2UDhMamVo?=
 =?utf-8?B?MTNwcHF2b2J4NTlGeHdYOUtkMURtQ1RCeHIwZDhBMFRybkYya20wUEYvR2Zu?=
 =?utf-8?B?OUtwT3hVYm1vTXJaQVNuVExVNytqZldqTWxiZUs2QzYrZUFEajJvbys1aVU1?=
 =?utf-8?B?cEdCb0x2UGRqQnhDOHR4YjVndkQrdDVseVFMRnE4V2lOTGx3WTloMndTYjJs?=
 =?utf-8?B?b0daa2EwM1QvUXFJSFhEZElyRjRqOWFTSklna2k2TjhnT1hUQnprZnYvMGhW?=
 =?utf-8?B?OVJPQ09PNEdEMHoycUlmZm1KRzRFNkc4SnF0dVRmejNWWXd3U2NRMTROYzdh?=
 =?utf-8?B?d1FWSXdNU2hFL3lqVHRFOGdoZXgyeFlweTZBZGwrdW1TU2NLWFpvVnlWcm1P?=
 =?utf-8?B?NUx1RHJ2MlhCcitQbWk1cWV0ZVgrZUlHR1NCM0tQYnQ0YWZWZUNBUnZqejNF?=
 =?utf-8?B?L3lEVmxvZDFkcHBrblNDL3FDcWNsTkRCREk4OTV0bTFnU0tmbmVTOWZ0emdl?=
 =?utf-8?B?MGVGSGFrSUgvVHFRRGNtVVdWcXREeHRQb2lRelNMY1BWam5aTmhpQjZuNlUz?=
 =?utf-8?B?NGMwNm8zeVdIVC9OOHdlMW85T0J1RzVXamRwbyttTHE1cjlmdVo0YlhkcGlp?=
 =?utf-8?B?VDNDVTlqclcrT2NITVAyZWRteWllYWxXZ295eWZmWXJCYXg4MjAwaThmZ2o4?=
 =?utf-8?B?aW52czFNeWV4bEhkQ2ZmNTVtTWhid2U4Q0pKY0RrUmx2S1dIQllDQmZoWUxu?=
 =?utf-8?B?ZjFUWW5SblUxb0pGU1I2cjhGaDB6Ylo5QkpKQ2JNRk1uUElNeThka2FLaUY1?=
 =?utf-8?B?SHNLYXZFamNiVnFlTFRmTHI5a25UL2pFYUxneXV4SkJxOTgrSW5LaFZOT0Jx?=
 =?utf-8?B?VmVZcXJRSWdMekZqWDF4MlVPQ2xrbCtsK09kdjA1Q1NDdnV4UDd0NlRqRmdR?=
 =?utf-8?B?OXJWem4wZVhseURPRUplcVltazFNQXYvNkFJZE9kNlg5K1BkMklLM2ZXak5u?=
 =?utf-8?B?V0MxQ3Z5ZWUzTFJncXBDS2F3dFJ4RklRSTBvM1cyQmVndWxxRmNSSzlKeitE?=
 =?utf-8?B?MHV3dTJWOE9vQXUyOXdHd2V5aVN2RXJjZTBGK1c4cmt2Ym5KNFVHSUtSUnBZ?=
 =?utf-8?B?Vjl4cmpBRnRCZ0NyeURsa2UwL2lTb0V4ZkJSdVJsUTBRdlROSUVHc1pDZXNO?=
 =?utf-8?B?QW50MDIxbEZhWk0zR2xHdEhTRXNPa054NlFGdHBXNWdnbHdlWWpzVTl3TlFR?=
 =?utf-8?B?RFJDVzN2QThoSVdHL0JaSWsreUtsOWplZFFORW1UbUhQZUpUaFlLTXVUZk9t?=
 =?utf-8?B?UFFlRGVhWnljVHU5YTV5M3EvekdrSFB6V2JvT0VITTBZaCsrSWViYi9uUnFW?=
 =?utf-8?B?WmJxSXJxTG5iaExMd3hxSm1Ed3I3NFJrMjBRdHJJVlhUQUlkZTA4QnY1d0ll?=
 =?utf-8?B?eHZhNFBhM3FJWERIMWZ5d0Q5cXVoVS9IZmdES0VKRjdtelV2QU40UG15NW52?=
 =?utf-8?B?d0hnZWVNclU0QUwvOVJqaytrQUhtSS9zODllVkhCVUkvL3MwV1JDd0NPL0VQ?=
 =?utf-8?B?ZHZ3VVNRTzBCcDFRSm5LQnkzR1FXeFF1Q0F2S29KcmsxNmswRzlPc2NMbFdB?=
 =?utf-8?B?QTRvWHcvb1BjQmJ5NGtrNEIyUVNjSHRvL1lBcXFacWVNZW1VVXYvUTBKRXdD?=
 =?utf-8?B?VTQ0c3I1ZjVzQ3V5Q1Z6S2xpbFJJODBzcnY3c21NVE5zTEltV1RxZkdOazlx?=
 =?utf-8?B?YnZCV0lyUE9paU9wUU5aRkNmeFBnWnJmcThicjNvZDV3SktGRjMzbW9lbDNV?=
 =?utf-8?B?SnQydHRLanViZE5QZVljN1dqak5yN0dCeHl1WWphbU5QYXd5QVcvRXB4ZEw0?=
 =?utf-8?B?MG1Lb3NDd2pSYUVIeHcrUHpxbXRoQ1REN0ZnWHNZSERwNGZCRXpjOGRWWUpN?=
 =?utf-8?B?TWU4aFhvWkdKdWxtRGNaSW1xcWd3SXB0ZEhnU0JaaUZDNnowYk54cDJyOFAy?=
 =?utf-8?B?b0liSVVxbXdoSEFzNDV2V1c4L0l2K0pEeGZ5VjZ2YmVnQjZtN2QycnVqek1H?=
 =?utf-8?Q?ZNpIY7eIfHBiDiYChvclOPOfk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mptj0R+QX69nwiT/iENlsrZiW0dSVZIDqYhh4rDdaznRbFYf+4OlSpx6yrrV2cxl8d0WGEWDszXSan+gQtvXttRfZGM8TPDRYuE30uTKJhjz1/Y0buaj9C4cojfzD62l4V8ZLnrZFgyZXFOcia/E7MfjFPduP52Rjqhfbx5SEm/A/g05cfsXCWpIzR/iM4bqNj0DSrk+NSvqMk9p/ur96o0TeIcB19gb5bqPlvC7dbn/Ce8pKGpjVxixrJ7Z8J4XiPzc0vPn/uf7Fi4OyOsS2Ik+SOUIubmKrzrczIPRVhJgdzq5Usu78NYTGnDry1sfVb9e6o341fy11CdYqddNMdwdv+yFOkDn+bqa+j07dZs2pQWoCyXxYH7h1budigoVrwfHVgkq6wualGWNlrr0uTtPZipa/UTC6kGWBKktCON23yDL7/ZP8i0at1/vL5Zhhyn0nALDft7Ae75GzGICkkUwcPXb+7XqzVWDNsRMkKVconu2tfF594yOpXXMCGyXTjw4Y4p8KHfFWwAPZ9mxezBLgECj+tI66j/Ws5T8Ae+2BUFFPzaWQime5s7+9e6qpyWOIOzHinQEWuQQDZhuUUg1wnUl6rQg5XxXm4nL+JM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620b83c4-2f45-41ae-e6d3-08dd30c539ef
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 15:49:39.7278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdPxRuIjEzuVEVrUPu4GiKU6Q/0ql6CjRqG9t4p/Hl9dUuhKuGAFXGinaGf42I3KaESwWRyFo4vE+ySdTnRgRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_07,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501090127
X-Proofpoint-ORIG-GUID: lfBl84-4V3WBs5cGRxeCIETs8jYf_Qb9
X-Proofpoint-GUID: lfBl84-4V3WBs5cGRxeCIETs8jYf_Qb9

On 1/9/25 6:56 AM, Christian Herzog wrote:
> Dear Chuck,
> 
> On Wed, Jan 08, 2025 at 10:07:49AM -0500, Chuck Lever wrote:
>> On 1/8/25 9:54 AM, Christian Herzog wrote:
>>> Dear Chuck,
>>>
>>> On Wed, Jan 08, 2025 at 08:33:23AM -0500, Chuck Lever wrote:
>>>> On 1/7/25 4:17 PM, Salvatore Bonaccorso wrote:
>>>>> Hi Chuck,
>>>>>
>>>>> Thanks for your time on this, much appreciated.
>>>>>
>>>>> On Wed, Jan 01, 2025 at 02:24:50PM -0500, Chuck Lever wrote:
>>>>>> On 12/25/24 4:15 AM, Salvatore Bonaccorso wrote:
>>>>>>> Hi Chuck, hi all,
>>>>>>>
>>>>>>> [it was not ideal to pick one of the message for this followup, let me
>>>>>>> know if you want a complete new thread, adding as well Benjamin and
>>>>>>> Trond as they are involved in one mentioned patch]
>>>>>>>
>>>>>>> On Mon, Jun 17, 2024 at 02:31:54PM +0000, Chuck Lever III wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>> On Jun 17, 2024, at 2:55 AM, Harald Dunkel <harald.dunkel@aixigo.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi folks,
>>>>>>>>>
>>>>>>>>> what would be the reason for nfsd getting stuck somehow and becoming
>>>>>>>>> an unkillable process? See
>>>>>>>>>
>>>>>>>>> - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562
>>>>>>>>> - https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2062568
>>>>>>>>>
>>>>>>>>> Doesn't this mean that something inside the kernel gets stuck as
>>>>>>>>> well? Seems odd to me.
>>>>>>>>
>>>>>>>> I'm not familiar with the Debian or Ubuntu kernel packages. Can
>>>>>>>> the kernel release numbers be translated to LTS kernel releases
>>>>>>>> please? Need both "last known working" and "first broken" releases.
>>>>>>>>
>>>>>>>> This:
>>>>>>>>
>>>>>>>> [ 6596.911785] RPC: Could not send backchannel reply error: -110
>>>>>>>> [ 6596.972490] RPC: Could not send backchannel reply error: -110
>>>>>>>> [ 6837.281307] RPC: Could not send backchannel reply error: -110
>>>>>>>>
>>>>>>>> is a known set of client backchannel bugs. Knowing the LTS kernel
>>>>>>>> releases (see above) will help us figure out what needs to be
>>>>>>>> backported to the LTS kernels kernels in question.
>>>>>>>>
>>>>>>>> This:
>>>>>>>>
>>>>>>>> [11183.290619] wait_for_completion+0x88/0x150
>>>>>>>> [11183.290623] __flush_workqueue+0x140/0x3e0
>>>>>>>> [11183.290629] nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
>>>>>>>> [11183.290689] nfsd4_destroy_session+0x186/0x260 [nfsd]
>>>>>>>>
>>>>>>>> is probably related to the backchannel errors on the client, but
>>>>>>>> client bugs shouldn't cause the server to hang like this. We
>>>>>>>> might be able to say more if you can provide the kernel release
>>>>>>>> translations (see above).
>>>>>>>
>>>>>>> In Debian we hstill have the bug #1071562 open and one person notified
>>>>>>> mye offlist that it appears that the issue get more frequent since
>>>>>>> they updated on NFS client side from Ubuntu 20.04 to Debian bookworm
>>>>>>> with a 6.1.y based kernel).
>>>>>>>
>>>>>>> Some people around those issues, seem to claim that the change
>>>>>>> mentioned in
>>>>>>> https://lists.proxmox.com/pipermail/pve-devel/2024-July/064614.html
>>>>>>> would fix the issue, which is as well backchannel related.
>>>>>>>
>>>>>>> This is upstream: 6ddc9deacc13 ("SUNRPC: Fix backchannel reply,
>>>>>>> again"). While this commit fixes 57331a59ac0d ("NFSv4.1: Use the
>>>>>>> nfs_client's rpc timeouts for backchannel") this is not something
>>>>>>> which goes back to 6.1.y, could it be possible that hte backchannel
>>>>>>> refactoring and this final fix indeeds fixes the issue?
>>>>>>>
>>>>>>> As people report it is not easily reproducible, so this makes it
>>>>>>> harder to identify fixes correctly.
>>>>>>>
>>>>>>> I gave a (short) stance on trying to backport commits up to
>>>>>>> 6ddc9deacc13 ("SUNRPC: Fix backchannel reply, again") but this quickly
>>>>>>> seems to indicate it is probably still not the right thing for
>>>>>>> backporting to the older stable series.
>>>>>>>
>>>>>>> As at least pre-requisites:
>>>>>>>
>>>>>>> 2009e32997ed568a305cf9bc7bf27d22e0f6ccda
>>>>>>> 4119bd0306652776cb0b7caa3aea5b2a93aecb89
>>>>>>> 163cdfca341b76c958567ae0966bd3575c5c6192
>>>>>>> f4afc8fead386c81fda2593ad6162271d26667f8
>>>>>>> 6ed8cdf967f7e9fc96cd1c129719ef99db2f9afc
>>>>>>> 57331a59ac0d680f606403eb24edd3c35aecba31
>>>>>>>
>>>>>>> and still there would be conflicting codepaths (and does not seem
>>>>>>> right).
>>>>>>>
>>>>>>> Chuck, Benjamin, Trond, is there anything we can provive on reporters
>>>>>>> side that we can try to tackle this issue better?
>>>>>>
>>>>>> As I've indicated before, NFSD should not block no matter what the
>>>>>> client may or may not be doing. I'd like to focus on the server first.
>>>>>>
>>>>>> What is the result of:
>>>>>>
>>>>>> $ cd <Bookworm's v6.1.90 kernel source >
>>>>>> $ unset KBUILD_OUTPUT
>>>>>> $ make -j `nproc`
>>>>>> $ scripts/faddr2line \
>>>>>> 	fs/nfsd/nfs4state.o \
>>>>>> 	nfsd4_destroy_session+0x16d
>>>>>>
>>>>>> Since this issue appeared after v6.1.1, is it possible to bisect
>>>>>> between v6.1.1 and v6.1.90 ?
>>>>>
>>>>> First please note, at least speaking of triggering the issue in
>>>>> Debian, Debian has moved to 6.1.119 based kernel already (and soon in
>>>>> the weekends point release move to 6.1.123).
>>>>>
>>>>> That said, one of the users which regularly seems to be hit by the
>>>>> issue was able to provide the above requested information, based for
>>>>> 6.1.119:
>>>>>
>>>>> ~/kernel/linux-source-6.1# make kernelversion
>>>>> 6.1.119
>>>>> ~/kernel/linux-source-6.1# scripts/faddr2line fs/nfsd/nfs4state.o nfsd4_destroy_session+0x16d
>>>>> nfsd4_destroy_session+0x16d/0x250:
>>>>> __list_del_entry at /root/kernel/linux-source-6.1/./include/linux/list.h:134
>>>>> (inlined by) list_del at /root/kernel/linux-source-6.1/./include/linux/list.h:148
>>>>> (inlined by) unhash_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:2062
>>>>> (inlined by) nfsd4_destroy_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:3856
>>>>>
>>>>> They could provide as well a decode_stacktrace output for the recent
>>>>> hit (if that is helpful for you):
>>>>>
>>>>> [Mon Jan 6 13:25:28 2025] INFO: task nfsd:55306 blocked for more than 6883 seconds.
>>>>> [Mon Jan 6 13:25:28 2025]       Not tainted 6.1.0-28-amd64 #1 Debian 6.1.119-1
>>>>> [Mon Jan 6 13:25:28 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>> [Mon Jan 6 13:25:28 2025] task:nfsd            state:D stack:0     pid:55306 ppid:2      flags:0x00004000
>>>>> [Mon Jan 6 13:25:28 2025] Call Trace:
>>>>> [Mon Jan 6 13:25:28 2025]  <TASK>
>>>>> [Mon Jan 6 13:25:28 2025] __schedule+0x34d/0x9e0
>>>>> [Mon Jan 6 13:25:28 2025] schedule+0x5a/0xd0
>>>>> [Mon Jan 6 13:25:28 2025] schedule_timeout+0x118/0x150
>>>>> [Mon Jan 6 13:25:28 2025] wait_for_completion+0x86/0x160
>>>>> [Mon Jan 6 13:25:28 2025] __flush_workqueue+0x152/0x420
>>>>> [Mon Jan 6 13:25:28 2025] nfsd4_destroy_session (debian/build/build_amd64_none_amd64/include/linux/spinlock.h:351 debian/build/build_amd64_none_amd64/fs/nfsd/nfs4state.c:3861) nfsd
>>>>> [Mon Jan 6 13:25:28 2025] nfsd4_proc_compound (debian/build/build_amd64_none_amd64/fs/nfsd/nfs4proc.c:2680) nfsd
>>>>> [Mon Jan 6 13:25:28 2025] nfsd_dispatch (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:1022) nfsd
>>>>> [Mon Jan 6 13:25:28 2025] svc_process_common (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1344) sunrpc
>>>>> [Mon Jan 6 13:25:28 2025] ? svc_recv (debian/build/build_amd64_none_amd64/net/sunrpc/svc_xprt.c:897) sunrpc
>>>>> [Mon Jan 6 13:25:28 2025] ? nfsd_svc (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:983) nfsd
>>>>> [Mon Jan 6 13:25:28 2025] ? nfsd_inet6addr_event (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:922) nfsd
>>>>> [Mon Jan 6 13:25:28 2025] svc_process (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1474) sunrpc
>>>>> [Mon Jan 6 13:25:28 2025] nfsd (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:960) nfsd
>>>>> [Mon Jan 6 13:25:28 2025] kthread+0xd7/0x100
>>>>> [Mon Jan 6 13:25:28 2025] ? kthread_complete_and_exit+0x20/0x20
>>>>> [Mon Jan 6 13:25:28 2025] ret_from_fork+0x1f/0x30
>>>>> [Mon Jan  6 13:25:28 2025]  </TASK>
>>>>>
>>>>> The question about bisection is actually harder, those are production
>>>>> systems and I understand it's not possible to do bisect there, while
>>>>> unfortunately not reprodcing the issue on "lab conditions".
>>>>>
>>>>> Does the above give us still a clue on what you were looking for?
>>>>
>>>> Thanks for the update.
>>>>
>>>> It's possible that 38f080f3cd19 ("NFSD: Move callback_wq into struct
>>>> nfs4_client"), while not a specific fix for this issue, might offer some
>>>> relief by preventing the DESTROY_SESSION hang from affecting all other
>>>> clients of the degraded server.
>>>>
>>>> Not having a reproducer or the ability to bisect puts a damper on
>>>> things. The next step, then, is to enable tracing on servers where this
>>>> issue can come up, and wait for the hang to occur. The following command
>>>> captures information only about callback operation, so it should not
>>>> generate much data or impact server performance.
>>>>
>>>>     # trace-cmd record -e nfsd:nfsd_cb\*
>>>>
>>>> Let that run until the problem occurs, then ^C, compress the resulting
>>>> trace.dat file, and either attach it to 1071562 or email it to me
>>>> privately.
>>> thanks for the follow-up.
>>>
>>> I am the "customer" with two affected file servers. We have since moved those
>>> servers to the backports kernel (6.11.10) in the hope of forward fixing the
>>> issue. If this kernel is stable, I'm afraid I can't go back to the 'bad'
>>> kernel (700+ researchers affected..), and we're also not able to trigger the
>>> issue on our test environment.
>>
>> Hello Dr. Herzog -
>>
>> If the problem recurs on 6.11, the trace-cmd I suggest above works
>> there as well.
> the bad news is: it just happened again with the bpo kernel.
> 
> We then immediately started trace-cmd since usually there are several call
> traces in a row and we did get a trace.dat:
> http://people.phys.ethz.ch/~daduke/trace.dat

I'd prefer to have the trace running from before the first occurrence
of the problem. Even better would be to get it started before the
first client mounts the server.

But I will have a look at your trace soon.

It would be extremely helpful if we could reproduce this problem in
our own labs.


> we did notice however that the stack trace looked a bit different this time:
> 
>      INFO: task nfsd:2566 blocked for more than 5799 seconds.
>      Tainted: G        W          6.11.10+bpo-amd64 #1 Debia>
>      "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables t>
>      task:nfsd            state:D stack:0     pid:2566  tgid:2566 >
>      Call Trace:
>      <TASK>
>      __schedule+0x400/0xad0
>      schedule+0x27/0xf0
>      nfsd4_shutdown_callback+0xfe/0x140 [nfsd]
>      ? __pfx_var_wake_function+0x10/0x10
>      __destroy_client+0x1f0/0x290 [nfsd]
>      nfsd4_destroy_clientid+0xf1/0x1e0 [nfsd]
>      ? svcauth_unix_set_client+0x586/0x5f0 [sunrpc]
>      nfsd4_proc_compound+0x34d/0x670 [nfsd]
>      nfsd_dispatch+0xfd/0x220 [nfsd]
>      svc_process_common+0x2f7/0x700 [sunrpc]
>      ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>      svc_process+0x131/0x180 [sunrpc]
>      svc_recv+0x830/0xa10 [sunrpc]
>      ? __pfx_nfsd+0x10/0x10 [nfsd]
>      nfsd+0x87/0xf0 [nfsd]
>      kthread+0xcf/0x100
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x31/0x50
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
> 
> and also the state of the offending client in `/proc/fs/nfsd/clients/*/info`
> used to be callback state: UNKNOWN while now it is DOWN or FAULT. No idea
> what it means, but I thought it was worth mentioning.


-- 
Chuck Lever

