Return-Path: <linux-nfs+bounces-5417-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FA9954EA0
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 18:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E3C1C21687
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 16:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649251BF323;
	Fri, 16 Aug 2024 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mCkiZ5RN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P+pX0zTb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815261BF30B;
	Fri, 16 Aug 2024 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825035; cv=fail; b=lg7rjrw4MPIQcWPQrQXhajfl659A08LNwZ1QeuggUUdmRlradeAhGwNgrFgNa0g78VRDtJ3e19QIOfZ9pDn0p38a5Ql1Rjpk4n1mnUtZI/K2SIiqw0pTWRoQj/JBPHtrqBpYY37BvVeh7HkHjOzf0gDA3/TUFFgbZSAPv/Na9II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825035; c=relaxed/simple;
	bh=2i8IyKBJocV2sKH5AD+d7gzESuf1bbqzTIz9kb30lmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PO6uDOUMO7IcNkFwAZAfxUIk77UDLLbHWvgLVF15nSLRcjxMNpxzcGKYpXSyVVgY/bzGi4Zha6g5RkIb0jjj/WZuLA7epcDPOHXiuWRleYnwTlSSCbr5cMmj8WDMlwrfsWpd9h5Sgo31UG5o5yAWT6chim/cTWB2FqyY+lnxCoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mCkiZ5RN; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P+pX0zTb reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GFiTsg030764;
	Fri, 16 Aug 2024 16:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=VSKVX+kH63Ae+dPfx8yEcVWtbIIgCgqH3uSLBm5UKLA=; b=
	mCkiZ5RNzX+ui+KsdGlTdCRocmd+cLBdUt7FcOZKxt1mc9gRJYnDulZldVxIjOgK
	ldDUw3T8dpesRWcCJJ9Xpgvv230WNt35EDQIiEJZIUqwLg6qHaZkxmVlRF0zXznz
	/xHZ0kEDrNO66EtxnBIfIxxrBqaidI+ufViy9qXLvLj9QaHlk4I0RUkUbwfFGOPp
	jEDFs2EcPc1hY0gUXwVzZPFcj1cDxdauDohbEkI5MQkiVZdnvY6k2UPIxll2JigJ
	9lzTcThfTB1E95BzOuYaeWCHz9YSDBz9fyknqqipeOR7aIF49CW22OMWzf0w9QQm
	96bbe7YFkZMi92JYfih1MQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x039cnxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 16:16:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47GF6bu1003700;
	Fri, 16 Aug 2024 16:16:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxndk3nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 16:16:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUuVpfyv9iKRT8vbW6hbhY/Kkm3ipyhQMLpDq1Pvn6HP9eLEhZfrtmNEmduhRgApWELq/w9R6bwsQLHKCwMfkkC1vPdcE1eGvlHjyfngxsslGOsVN848/5LfouWk7Wx8oZvreM7Jzf5U8THraGy2SCS/vXi5QL6UthKRIE3n2k5YiI2tolwn6Wzb9HtilQB9ZSO6gctkaC9XBbceGmWB8nsL+ebFIOF614p46mfCgaj9PrCnH2IkFR74pmIX7OEfHMUNp2zlLqRTTzijsB5/dVMmujiuHmWgdLkzW1lsOhfpE0l2biQbrLXuXdruf5aCIdETEgD2KZSvkweiLvCGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+V0qQKsc8HxK3bWCVp1yD5dR7b1VJ+D90/LMTkhWKw=;
 b=JdWfd1U4OM2eGVWUt0aeffhVXYWramyDdn3XaC0pXAGcKEwQyfVo9QQ6bqEyDjP7Pl6ln5KgfZGAPMt45wxdaj90yRHYdiw4BEoNlUOyjZ3xJ1d9qnMw4nQrqVx0xaxRZ5XGVTEjfhL9WGxbQybndoKhgYnYtW7aAqMix9A8YC+inAlDJK/vOijHAPEEEX3j3TcVD8E1gEE3F1EnGOieeiYtw/l6uuqbZb6sA6hvLRZPlun3wj3nszIw8SBuBsTQiaNUQvXKoY22C7t4xqUqsFER2SPoOyFQ2snLUjHNGtkE9wAFqBBthBX1N8LLd4qRY3hkxKrn+xRVVThwPo8uSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+V0qQKsc8HxK3bWCVp1yD5dR7b1VJ+D90/LMTkhWKw=;
 b=P+pX0zTbCEFzdNE3YXV3dyQUfcVbnERtk2BOUjfbW+5iAVEQ5gCn+jkGhC9RkqZ+7+HLOHjrd/mCZueJU2TieMJ0Ck273YWSKQDEE1BfWwtaZCinCUrgJM4bOTl1Dn+t2qzQ5R7byzig10P70AZhT0LL7fEVkd3L0m2HTUU5ues=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB7005.namprd10.prod.outlook.com (2603:10b6:510:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Fri, 16 Aug
 2024 16:16:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.009; Fri, 16 Aug 2024
 16:16:48 +0000
Date: Fri, 16 Aug 2024 12:16:44 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] nfsd: bring in support for delstid draft XDR encoding
Message-ID: <Zr97bLdCvjD69yW7@tissot.1015granger.net>
References: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>
 <20240816-delstid-v1-1-c221c3dc14cd@kernel.org>
 <Zr9thPcPcqYQuXed@tissot.1015granger.net>
 <f51cc300fe6be795d8d77b39a0218317bf6f9522.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f51cc300fe6be795d8d77b39a0218317bf6f9522.camel@kernel.org>
X-ClientProxiedBy: CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b989d4-c34c-4e05-1a9e-08dcbe0ed47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?RgT0/yEVgAY+P7cF1JwxLPHa7HbbBTaOSpau5IxaSONkmUXFspxZGyx4Jb?=
 =?iso-8859-1?Q?390PoCZeTL+4QvGOaw96MRQ6rrZdUUSW0IFbLwTDFvXFkgC/KkAYEwR7vf?=
 =?iso-8859-1?Q?spAf1M3LjQSroXRHPDRPdU2HYQxDjkMeIA+rYFsvT/KEBkGUS2eVnPCiqs?=
 =?iso-8859-1?Q?VPErLYiYRTuJnfRH9fEGckyINLmEUTFYvb1Y5cPItM6PT6VHthfBtxAUYF?=
 =?iso-8859-1?Q?0jEUlvPQkktCXVZfoSIK9JW/SZRSDxOgVO0htsV731X5JjEHbU6cnjcZEm?=
 =?iso-8859-1?Q?oueuR2FE011e4a1ryqsmt2cX/duWR1PnW3UJEabBUMc1a9eWE7+/S5nQC2?=
 =?iso-8859-1?Q?A3HqY9Q9czhlpKWfjOQeQRS/b4lchAxPE5UCKfIzwnt3MSf/D9FuibFAoP?=
 =?iso-8859-1?Q?NGtBVu8n8jTw98v02X3sUfm4VjNKM1KRn8SO0f+wI6Ex/3VXuJupjiAnNT?=
 =?iso-8859-1?Q?/MFjRhcmgDMacSBCxa1SSNLdEGsZ2H/6uQmfnbQft8aaDZvqIm7+XijAWW?=
 =?iso-8859-1?Q?e6nplMFFKV5vA1Zx0lstvOj77/0WrVWjMnbHp5SMg1cKHEZNOWlr3gkZkW?=
 =?iso-8859-1?Q?yo5jtN12TMkn0jHpiQXbUtYx2ZOO2yv7w1J45Hm5AFUwe+QyAMJRrAdQrk?=
 =?iso-8859-1?Q?0VXVDbe1jj/kRU9Tte7VQZ2yD2EbYzPNrq97HBMjHGoVqP4IAR3sE1vzb8?=
 =?iso-8859-1?Q?rGrHFFQqy5JuM8jW3KWrIpykvP6KZfScDiE4zXkJRTCu/zc/8+TSDYq/K4?=
 =?iso-8859-1?Q?+qPCRSeTz06cJjkd3HXOgaIeCbfxzf01Nu07C++zgzNvEv0isbD6OT/E1F?=
 =?iso-8859-1?Q?/UGqbsC0pe+RikfafCCH+e6F02uUbrboFJpmhrVWXwdWB0uQzgK9h53HhS?=
 =?iso-8859-1?Q?r8KBb8PoggNgl5ha3iRIW8ZPGuiUYVoo8fjs7yuTAi6OvsFCYiZs74wn6k?=
 =?iso-8859-1?Q?xXhHGYAaEF7XyAuvT2Lu0Mygho43rE+/7Ht2SBOfPnRX1Qmex7yJHIrSJR?=
 =?iso-8859-1?Q?MURVdzFrd/q01rgS3BB1o6YkwONiZukCDqZZNunaQm0+RUoCq8rpAiUKQS?=
 =?iso-8859-1?Q?tevtgi/8d3v3Ai1nTXZyjMrDpzqn8LPkIRAQBv8vbYlAZNMwcs87LnnfnI?=
 =?iso-8859-1?Q?y4lOAAQbtRMvGCBeNktE4dc1pkoe+jESi/I077LO1EMgeT9RBlrTnY5cfz?=
 =?iso-8859-1?Q?nhDN+4gGGch6B7wSa+T4oAN5Z26tlqJJnhktEeGEfnow14ScsfRaZGJTVP?=
 =?iso-8859-1?Q?eUqRuyqOuAVrLjjk7pQZdR1akc3rHOkn7nFZAXdncI7fH7sn/Croiq1ykx?=
 =?iso-8859-1?Q?fVyAMNGU1XOO36kZQ7aAR6H5iWteSgs9GRYpWjiEn50XffLCTOxkyzHvUy?=
 =?iso-8859-1?Q?5SAjJg4mmNu8HtMyunIk05A3n48qyGjvY0ncnTzance8GXr9kZluc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?MhrYg/25sdTJsxP+qY7A88zjZ2bA69Qhj/BUmvZpbdRaruv25qT1J0FLWo?=
 =?iso-8859-1?Q?yW1CnR1bXy4yghVcpZ5gvKBTqT4eKErnlPN+7IEaoomRzNGO773fJiDFtC?=
 =?iso-8859-1?Q?G9pqA/TokyRojtLcokSfQDy16Yq+4+4kJMUZH9DEGtRPEebzgIGPJAWV++?=
 =?iso-8859-1?Q?uxk8S56gfnTw2BGb5ma7+WDEbZ+5IoK5AlY9WYWTH0o3EUPcIAGznn1BsJ?=
 =?iso-8859-1?Q?3rmWt61t36n/TpxKd9sPNCXNJUiM7jMsIebiN3NY1l9OVcnMeBMyaEFwfq?=
 =?iso-8859-1?Q?/ATkmZ4FeAGB3WXbCkh98qgSYTgKpEG4443y72RwJ3QG0Tm58/7JJqy/Bu?=
 =?iso-8859-1?Q?CPQFHVjOWMJbvG8KRklXgM9jALEbWm52cxWHQiOt9YTE8mNlWk9X5Tu64t?=
 =?iso-8859-1?Q?0q99zUp7sJfQhE2xpyk0/PK9w9RlZDPMy/ou5/C0Pm76S2KVT/0l0jxwhh?=
 =?iso-8859-1?Q?f+IzWxDDxfzjXlFMCeX93qqEB1z3T2Z1f8s+KWnL0cGxLQ9+xCbxYSSk3Q?=
 =?iso-8859-1?Q?7E4mam81RLAfr3i7XrkEmYPxTq+4/OZFgOEShI/JIx6gPLJ/iTLKp7m8Aj?=
 =?iso-8859-1?Q?Xb8kwaFXU00qrMBPxmNPN13Jo40yJTvo4j9xJ9/3RhPDFRRJP5pRklFvS1?=
 =?iso-8859-1?Q?/aqS5g/dt3zV+vyZKkf3wWfpytLMuOig1ZRq2CC2dKEJz7Xzk/G5PuMJ6J?=
 =?iso-8859-1?Q?ZV5SIQR81ZkgHKeEVdFl3Em4RtWvJYBEstYlpHawxqSvqNOZBYYoEIz7iB?=
 =?iso-8859-1?Q?KGT9ae6D2+bAWmoTmULSzAtHm6rxFnFENa5q4qWBnGVG1O6fSJ3GM4DHPb?=
 =?iso-8859-1?Q?HrCt4hCkUluU3Peqv6B25h+TVaC3W1nRoGIgtS9JBejYcY281rsY+AjAQx?=
 =?iso-8859-1?Q?jtIkFiaXZMHlc2YuSPuh/8ABo6GQT4DtXdnDvCrI7xLY8IMbdfQ+ip2u3Y?=
 =?iso-8859-1?Q?m3IGJvk6KK2bTzu+TKzqpOKnvLsOBtyYXYizrbyaDH10FN44jMc8KBPTCI?=
 =?iso-8859-1?Q?1+7LyJmGYmetnFHUInPPRy29WnnwN6+J3hbk+4ePjdQGs6y8QgoV0geSEA?=
 =?iso-8859-1?Q?HcsIilv0bHkOZDHD17Zq6O4+sr0wax6czNfQoZ/Tg4Ju2wE5GEV85C7Gco?=
 =?iso-8859-1?Q?ZkT+b7RJg1ZQqPeAeea6b1V4gv+mtzUcHz8Ceo1AwQjE5WcJ7lhkB97/45?=
 =?iso-8859-1?Q?W/31v0RWc5yMQk9HN3Floi0bc07dujFTUjilromdknsrrVWu9CDQ1VBrDa?=
 =?iso-8859-1?Q?X2+Vr4JLVoVTKkVtBby41IXcoNwxh8e8R6kom37VWwSk+Z4xgDEvuG7FHm?=
 =?iso-8859-1?Q?yQPbXgP9UfCs2x2R4lyvA6vRJf9AwRwsYdL43hwsgElTwdz/G+qgencIZW?=
 =?iso-8859-1?Q?KxWmig/M6OX7HlPX7bZ82Q1ejoGNiXiVsCLfTz+s+qrM5x0VDN1B1RTCeq?=
 =?iso-8859-1?Q?fpViGXCJgloPe/fmT9vghHIhXf5rgBxPjUh8+4c0CrHUSEWb0VlR6iztx5?=
 =?iso-8859-1?Q?mzH25qLVaxjDNvoVuZv0u0vLcwx/rMpktA1w51vGOqOaSAWw4ydDpSieRk?=
 =?iso-8859-1?Q?db8bCto8sXAkzuoZ88ywvFLppnx4hpD4qdOKRtTPcrn+r52SLLygejeA7E?=
 =?iso-8859-1?Q?aJfr2tNyGaqtFP16zte+c9fdvAzsLspoHx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BmtYzvH6ituwq8YQD1L/XRSTaFaGFPsxk4kMCiNLO+5duCL+pCa+3+eS8/EqzwwihO8CJmcKF+MILfpA/lm0RA+1r/GxJa5G9auvba279fFu0aXBBymv3mvgVNHdrsRb1NOQmWjCJCSiDK/uWPhp7gRclyRzvZBYrG7jb1WrM7bFOs1FJJkasYkMhw42VnIt54+bgk2rRIx5u0VHzrkLySaowzW7e+ItMY1zqUe5ZmCXMy58XyyOhXO6cyP/BKafsQZrtnVv1JIFLzw2xvWtgrovgwdxzjHMDtN/7f8SXIBrT0zKfeT9+pmOXVmhYBcv40jOYc7ShOD5pGQEWCRlfCaztUzCgcqmdw6npUXv69lTvoIQeW77t5PJMt3CQTGjeND+EMVdo2OVJoD84a52wPIlmmwuM/Wrr4U+Uq5u3JT6DcqSzfsHT8YFm/hOkpjJEQ69LxYlVXNQO0mBkjQeKmtt0oBpBTUqDFf+90e6pb7Fm5GNDolaWzsbeAMfb58vlxwVsMsiO5wA840dDLHPF87etqcSmnLAUQor9Qup3Km+UpatR6zjTvwHFLRmatc4NcL80KIc0su0n4IvaLT7jyQXCWIkL2PTPWB1sYuQEME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b989d4-c34c-4e05-1a9e-08dcbe0ed47d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 16:16:48.5604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxxjG84WuL20Kszc6XhjyJboJo1G2UUA/0BZ/sPtkL7m8ow51/bZIK3SQ35oh/YaI/ng1orM+TjpS4Rv2Dzb2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_11,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408160115
X-Proofpoint-ORIG-GUID: _G2DWezuv9XixFdWK89W08zSiMP0TXRp
X-Proofpoint-GUID: _G2DWezuv9XixFdWK89W08zSiMP0TXRp

On Fri, Aug 16, 2024 at 11:45:32AM -0400, Jeff Layton wrote:
> On Fri, 2024-08-16 at 11:17 -0400, Chuck Lever wrote:
> > On Fri, Aug 16, 2024 at 08:42:07AM -0400, Jeff Layton wrote:
> > > This adds support for the "delstid" draft:
> > > 
> > >     https://datatracker.ietf.org/doc/draft-ietf-nfsv4-delstid/05/
> > > 
> > > Most of this was autogenerated using Chuck's lkxdrgen tool with
> > > some
> > > by-hand tweaks to work around some symbol conflicts, and to add
> > > some
> > > missing pieces that were needed from nfs4_1.x.
> > 
> > I haven't read delstid closely enough to comment on the approach
> > you've taken in 3/3, but I do have some thoughts about code
> > organization here. I will try to study that draft soon.
> > 
> > And, I'm assuming you are continuing to evolve support for the draft
> > and will be growing this series. So I will hold off on careful
> > inspection of 3/3 for the moment.
> > 
> 
> Yes. The client pieces are already in place, and I read I get is that
> the draft is all but done at this point. 3/3 is probably pretty close
> to what should go in. There are really 3 parts to the delstid draft:
> 
> 1/ the OPEN_XOR_DELEGATION part, which allows the server to avoid
> giving out an open stateid when giving out a deleg.
> 
> 2/ delegated timestamp support (which is the part I'm still looking at)
> 
> 3/ FATTR4_OPEN_ARGUMENTS (which enables 1 and 2)
> 
> This patchset encompasses 1 & 3. Part 2 shouldn't have much bearing on
> this set. It's really a separate feature entirely that just happens to
> also depend on FATTR4_OPEN_ARGUMENTS support.
> 
> > First, I'm pleased that you found xdrgen useful for rapid
> > prototyping. That's not something I had envisioned when I created
> > the tool, but it's a good match, looks like.
> > 
> 
> Yeah. It has some bugs that still need fixing, but it was certainly
> better than having to roll all of that by hand.

I'm very interested to hear bug reports.


> > Here you add a separate set of source files for delstid XDR...  That
> > approach might not be scalable for adding subsequent new features in
> > general, it occurs to me.
> >
> > We might end up with a bunch of these little code blurbs with no
> > clear understanding of how they inter-relate.  Thoughts about how to
> > manage these are welcome: xdrgen could generate only header files
> > and then we would #include them where needed, for example.
> >
> > For now, I suggest folding the new generated XDR code into the
> > existing NFSv4 "open" XDR code in fs/nfsd/nfs4xdr.c, when you have
> > some time for cleaning up the patches. An alternative would be to
> > leave it and I can fold these together before committing.
> > 
> > (The long term, of course, will hopefully be generating all XDR code
> > automatically, but we're a ways out from that, IMO).
> > 
> 
> This is where I disagree.
> 
> The nice thing about lkxdrgen is that most of what it generates is
> fairly self-contained. I think we ought to try to keep the new (mostly
> autogenerated) and old code (hand-rolled) separate for now.
> 
> I'm not sure what makes the most sense for a new naming scheme, but I
> really don't think we should paste all of this into nfs4xdr.c, which is
> just a huge jumble of hand-rolled XDR code. 

nfs4xdr.c is a mix of stuff that I constructed by rote, which is
pretty clean, and stuff that mixes the "just serialize" logic with
"do the proc part as well" logic, which is more ugly. I had thought
that OPEN's XDR was in the former category, but I get it. 

So I still think there's a scalability problem with adding each new
feature in its own XDR .c and .h, but I don't mind keeping the
generated code separate from the legacy code. How about creating one
new file to collect the mostly- or all-generated XDR code?

I've been using fs/nfsd/nfs[34]gen_xdr.[ch] in my testing.

-- 
Chuck Lever

