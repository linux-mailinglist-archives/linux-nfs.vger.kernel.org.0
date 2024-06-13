Return-Path: <linux-nfs+bounces-3770-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D119077A2
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 17:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D1E1F2212B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D79012E1C5;
	Thu, 13 Jun 2024 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HXUnNDA4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HK9his66"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86DA4C6B;
	Thu, 13 Jun 2024 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718294317; cv=fail; b=A/PCZeaZy1KT+CM61tL5oeNsDgB2jX/WO9VT0FLnO3k6PsmxdRsIv2r+nPJMSqsmL7xqZKupqAoKaXTgHXTG2SbL58XLeiy4PHPWEhhtT+kfx0SW+IW2YZsP8dBI4Pv83v5c1gRP2W0BpOB1V1BHZ/1TuRanP6f+PBAqn9H7b8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718294317; c=relaxed/simple;
	bh=elJ6FmfGtaeygeANkAIntJgCjgBuYUhhl2owCKr5uf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zw8mVVLJKO4CvxLYC81kgIxNKzeCeZmmLyU6Zh8K3Z63xyuLV2sM0ASnHLS+Moi6zO5WaygBk/wYXP1pi+un2COtN2vZFmEsXUCDpqUjff2HoIYdweW37bvLg6xYTVIt5Oc1KG17oGIGZlcH4vmSsI0uOCtk66psjdeOixg8DMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HXUnNDA4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HK9his66; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DEtT4V003173;
	Thu, 13 Jun 2024 15:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=TwCaUbbgajy0+Dg
	REIc1yIVvYL2Mfu8YfvvahzE5kq0=; b=HXUnNDA4ZXvdO5xs+3hUvsnsHPnz8FO
	Gr+0EwD7hxYjvckw+rAMWcyNtR6lUi59tJLp/ekrd4FbgeqWawDQsCVJjPjIBLMS
	+tIyfDCu3FkbG9FyaLhNPVdPb+s2nRr5auT4j5z1rdMi0e/jDtKBcrIuyf4Vyw8X
	WTuQ2Tm25lXSW1jj2bcGHJkMU+8Z5FL/2yVvJnLIzpjJBjpuap2d/f2AnW1hO4jr
	08qUld5UCtoRenN955x524Epo1PizSiDhVTU1SxhfIGl8ohuocT+ZTxgX6dd20cU
	uoLb/tpa9ktxaozxgPfE2skPJcq5XDG4U6uaAIJhcWDeGMLuCzP3pdg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhf1hway-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:58:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DFmXkD021184;
	Thu, 13 Jun 2024 15:58:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncaxpny4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:58:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoPeeHXTk3xKJgTH8XlkJWYUxnOi9Kibz5bHLrmWNav7pgVamypOT2oHZ7gjW8BLWcebHOk0296Gt+MP1tYEz2Keb0+/a2uPVrwye+1V85ZcavnFzzSdbByDJGAOz9S97DusQahHrgmAW5A7beb4fvxgetMIWnQLw3QMhZupyxBy4GFIN1WpLjXVczz34s+OZxPzbFS2SdtNcKUEc0b8qjLYmSDpzjf7gVgdy+KLu/+0HAM7iWS23JuKKMSZXBTLnYLxQDwB4lPhNMAbNRg9toLnrGHGbDoS2MqcmOwgTMxeTk7iF3sr7hEE+4xbjAj1AP/5/ZdmFxMSs2J8zpGUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwCaUbbgajy0+DgREIc1yIVvYL2Mfu8YfvvahzE5kq0=;
 b=Vr3765bzIkJduGSuJ3/DdF8xBYYNCIMor4vGSL4xAzfinOCo0Qs/vgN1WnixGOP0a2n/x/K5wKzE0Bg7WtMkUOydEw1iDMhIr0UZYdIBB/h8WHeb6LDHw60caCuy328RFNqf2xG6xiojL1ymSj170AsGASfvk382vZNuy6TMaAqApVfXXGrDNBXCh8mNP+nWX07jsTv/399nE/Fu3hYNV6dfokzYwd6ZJ7bMEfi5RBa6Baxwsj36669bcB3s/+1HncMJ78hG7mX4DMTf62Dr5VoFa/4IiAKvSONIwRuU4Mrf5++hbt/6AXtYZOOz1fM/jOcCLjc0BSNKgmp55QwJzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwCaUbbgajy0+DgREIc1yIVvYL2Mfu8YfvvahzE5kq0=;
 b=HK9his66Iy7OH4XYgpXHEGlMVokbWTvpeoLUEHvre8ITvePIl8j29GRa1kMoP5PJOs2bMBGphEX1pRP3uuNcLB1PYBQCfp9eewp1kij56kyb3nYMNHbq3x3Grkj/MWxxH71D6JvbGXVYbTCrTUGgSSaz3N2X2w6EqaAXRo1/e3Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6673.namprd10.prod.outlook.com (2603:10b6:510:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.23; Thu, 13 Jun
 2024 15:57:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 15:57:49 +0000
Date: Thu, 13 Jun 2024 11:57:46 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/5] nfsd: make nfsd_svc call nfsd_set_nrthreads
Message-ID: <ZmsW+kmUdtebrUcd@tissot.1015granger.net>
References: <20240613-nfsd-next-v2-0-20bf690d65fb@kernel.org>
 <20240613-nfsd-next-v2-2-20bf690d65fb@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613-nfsd-next-v2-2-20bf690d65fb@kernel.org>
X-ClientProxiedBy: CH0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:610:cc::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: e7103d24-e02a-41a1-b75f-08dc8bc1933a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|7416009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?E4s3atdZ8xUknKVC3AekSuBDfaqQB3+K8joDw3N3BUCvW2MtJvYQUU+c3VUW?=
 =?us-ascii?Q?8VcwLk0UNzi8F6Z02oCmogDMghb7Uqb6RhBXv96JMxZhtkLE3k9TyohyexN4?=
 =?us-ascii?Q?uS2KfGxigP04WeSaihi6tlfvkd0JoqWmCXxmogluwYTo53lzS5QiD+E1/voV?=
 =?us-ascii?Q?ZeIiT7gbPITT7K/0ZdzjgStQQkYsgrK6X002TdUDTMymsVi6gYnQ5DbxXlZA?=
 =?us-ascii?Q?ZudF16dQS5uxIfT445QKSZ/TDniaPrmMPik/rKg4+Qw4kaEQfVBlaLBLT3w0?=
 =?us-ascii?Q?NUfu3c+CoAGYMMj5Tw6Ahd2oTZha8Xr9EOTY2ZdpgSlLyAuwV/vttgLGAtRJ?=
 =?us-ascii?Q?NfsxUSHsPzmX0YEFqi3X+uHvzxlQh5qu77Ei5h8MLpMZ0muXxAE83Kmw7GEn?=
 =?us-ascii?Q?cUk81zCUyh9ccJjpzjxgHVABBH/k/spq+sby8zQwd9Pw3G02bwOSZuaPVGKN?=
 =?us-ascii?Q?00IPqybMte4mSVtYX+I8mNjvJL3Xupmhg+SvzNU/NOlRudRB3mkxNZziJ+Vk?=
 =?us-ascii?Q?4KhP0ze/R74reTcNH45fvLC/7982aW9BVOeXsT4S3YOVYpkjNsXCd1W/RWVG?=
 =?us-ascii?Q?zB5Y3lvUT3oIPxQU7T/g1vAJJBaaFt0Zhn+1m9NIR8DP9nkjhsLOJNujj4UU?=
 =?us-ascii?Q?dWbh7mcMMNsnGby6JCNikBIEj7KQ7YXA2oRi5rtIwIXzEKII7kaeIJrT48rt?=
 =?us-ascii?Q?GyL1PMIK0gtas4mR6g67KjDWGV1I36mjsCxPuYQPIpySiq51mtZ8y8M8gAXG?=
 =?us-ascii?Q?+gXPTaYoSjsq1uFA1en7hWGizte2I6VCUzbEHFhZF8klTdx0n8x+55UWOkxI?=
 =?us-ascii?Q?O/K4g5oxTXG+P7XsN7Zs7c8MF0KxFUlODR2g+5LrTsVoSfx+6q0cHvG4zxUs?=
 =?us-ascii?Q?yOOzn1AyNoNKM6ZnUv3B+N5qp6koWOgJwm24DCPr0fQxFVnsdydOAvk52fP0?=
 =?us-ascii?Q?MNrEvl9qVw3fk5CGm9iwjE58PuEfHDTsBtP9Gprc2wOjj8bPQBBUhEIoVDj+?=
 =?us-ascii?Q?Olfo35RE45q1tnjpLEmLM5HHV5tc9O3RU8TT0x+WmMwgvGj5Kgfaey/g2XMV?=
 =?us-ascii?Q?RbCdyl+sb66lVxZlI0nyWozBmgnzPaG8dxj+dSt+nxHa9rX1Hvxtq1dMQJjL?=
 =?us-ascii?Q?4gVFbz5j7KUYC7OTViqYd4vFm5JmIati0RM1x76rmarZArpOoJfVJbYtFglE?=
 =?us-ascii?Q?Bhj58HCzPOtl/YKYd3mEj3C/9ABfx9htgZtgNjSNeUpOYkAKVhQcZvZubgvJ?=
 =?us-ascii?Q?eqpOXFouOU1tjBxYolprsGi09Q4K/0P1j4NAEL0ATJIfnUHZM3bnDT5Tc24k?=
 =?us-ascii?Q?cw13/Yv8muzW8gtSK2YJcpbD?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?04MUAUOT1saly0wEIx9KbbYNdlAKlBoSIldLlv9eM2m3lEbq/sLBBlGK67xZ?=
 =?us-ascii?Q?FsWS2r6bADo9BH/mcTa6IrmzaqGVcTkrVjGQXIIu7414xgdE4inRRvpHfk1Y?=
 =?us-ascii?Q?HSpcx9CwUJsUJXd4jKK5ChXOKG0Jc6m8p8WKwdTLdQ4B2BjexCKYyckdomse?=
 =?us-ascii?Q?v/CH7f8BRdNeiT/Nqcg/ceWYUDhtuQ8HuWMQSqCmdMYmCKsDyRi0K+CtSLKl?=
 =?us-ascii?Q?InCZrCawTnD0AifpDjnq5+pPr01/r5p5eW9AHqYA266N8Ccp9wJljUcuijmq?=
 =?us-ascii?Q?bHULMSD2iZNEkQwY3CTzvJ1DkDyArdCzOVfTrMUqHHPj46hdvwi6p8jLT6RZ?=
 =?us-ascii?Q?dIwWDKNNspag8jF0sn8xqJK3mKIJSobkGUlFEMR0lnOscoVo8nZoP9gQYpUE?=
 =?us-ascii?Q?W9JhrJaOWLl79jm1w5Qid7WtNPYpFdkWp0IrAcbx0CuzIURUlp8EBikJ0V99?=
 =?us-ascii?Q?QO3jitBlv37evUfcFStWjJEz3GyEV0vv3g7QPncxNXI0wK3VXBeSn9gy7ZCD?=
 =?us-ascii?Q?dLHxbGMfU+okr225fjILBJddYi6jCIhKLbCzQ/m+oVOh9/CCuBspqehKCk+h?=
 =?us-ascii?Q?etrvcFe1VVwj6uz4CuOw7VlP9bh+s4D1HpYSPrAbWKEg6KO6XGG7MsasdLFG?=
 =?us-ascii?Q?PC/n4HMDMPJO+DlqMt7pPkCrYOzvEJjkvzbr0IIEE9Dt2/iWthE97ibAWemf?=
 =?us-ascii?Q?8DGXdpt1jl3yu096+NevmYadVnbXyKt1UeMC3LzBNS3Lguqsa/leiFB42v5Y?=
 =?us-ascii?Q?3m83LY5V0i7ldnyPhs/Vb3sRtJpEbuMKMLoDyMJl2ZE2E97MAZskDhXzZ2P9?=
 =?us-ascii?Q?zzoyNPlx8RCVCessIMzjEDFzt1tXWx1cxU6Bv/68ZigETMxteKhixHt5cJpR?=
 =?us-ascii?Q?VSJc9CDjzdoD3orjTVh9t4zOi7zv6Vk3gA99Z22pxwqsB7pJ4gPYLbqu5us5?=
 =?us-ascii?Q?lWVePJp9EoNrtX9o+7SbBPEdmlZn4R9Wb2bkIyYJlrCEpNd18pcgmhWXxTgG?=
 =?us-ascii?Q?0Ex082U1B5mUDmUyrlBCa06JwMpdyNmvqPzoCOmdHlAH7E7x6u1lJCTuWz/A?=
 =?us-ascii?Q?/uvhwnFBT0Njay/cFmGoi9DNsdt6M+EH+uWMCMsCeF1XmPXiGfR+5rhoba6b?=
 =?us-ascii?Q?jJae8HYDdJK76R7w/NqteRVwWh9hZLYnczkccsr8HZ5OaWcMph5+KW1MZE6P?=
 =?us-ascii?Q?AeqLo6+p8f4lKpxXwgTc0gUw41sllaeSVmHXJmQEjPI7lBJQHnMAOv4EqWS0?=
 =?us-ascii?Q?9sfzZBUy4uw0BVgNalUIfx5Jkg6qA2k83Qlm9tOUnnlS2EK3m3U10mKWFkKF?=
 =?us-ascii?Q?POkcsEtxqAZ87fl/xsUHl6BxKflHQ2gverNkJN+PEoi7T3ba/OzXs5Rghv7v?=
 =?us-ascii?Q?6J8pczVd4ex1GkGtE8lOome3YjjI4kZU5kNVNnFw5x1B1evdaOzFtp2pBWsX?=
 =?us-ascii?Q?jkc/hMtGoHSnj4sWjDwP3lrNUlmPpZuc+V2RhJ+OFMUKbExpYnedwesdsyoV?=
 =?us-ascii?Q?E69euVFCZUF22Fsy22dHhwNmlcavmqqmvCJvZ7HhnQjDzEPi67/xFSUVRg2o?=
 =?us-ascii?Q?2cTSjZmVdO+JT0aCWPjaF3K3xpIv1m9FGAuT/qB9+D+oa1bNRoDdk61SesuT?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MZN3luBFhbSlm+FY+X+W6K6YlcpL8GMSG/xSFdZ2+2pJ9XLMTQXyaqxYM4JpdIa/MXEdDRRNkVNUn/BNTHmVPuDtGMAjXj/ruZIUfVjk2wpDp4o/Tb0qkruiYRQYOSECl6AzMwuJAb9zFN/VWVaa84vVac9x6dT6Ao92oAOoyiO8nGPH3JY9KEf+ClUHUjms5n/pzhF/tV2ssvuqjP63zMHa4/+O/jt4Z89QBIdaiu5V+Z9rT9DaMcHDA9+D0ySrqgxgkKeaduvajeWvQa6k8CZcz4WqqWmFKVfKOtfYjCjJqKu7n3unRNQwHkw/ZmtkbXqajCe9i9IHOvifqdJZjq0Usnm2WEZREEHtmok05Rbm5PiaqPprWkxJ4363AXNojd6zhpe58eH8LFx48kLwQI91lHTRi9Ow7FJGPITFBm9VNab7dgmUKywA/4sXKhHTMOiP2orOJSXcNCykR1pDyedV4T0sfAZwCa/YK0K/G/IXDRze5Zh0ooTU6sGd0JWv5OY97LA2WGrM6lFbAMr/jUpaX8uay5inlkrEGFD1blNyC7xiL4txuh+OlQmiAMdaWF4EDY3NSOWECvQTkX5Vrk1bASAu+ax6TvF42O8pDLE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7103d24-e02a-41a1-b75f-08dc8bc1933a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 15:57:49.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: as4pOUNfT5CDtmn93cEwMw2E58gJ2K8wlswSkf6RbsrFn5ZW2uEc4I48wzS6aXM9mp+IBORMI2s0f87IaOMRUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6673
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_09,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130114
X-Proofpoint-ORIG-GUID: 5kRKsijjts2_CotOFTP1JxRmWfdBntVh
X-Proofpoint-GUID: 5kRKsijjts2_CotOFTP1JxRmWfdBntVh

On Thu, Jun 13, 2024 at 08:16:39AM -0400, Jeff Layton wrote:
> Now that the refcounting is fixed, rework nfsd_svc to use the same
> thread setup as the pool_threads interface. Since the new netlink
> interface doesn't have the same restriction as pool_threads, move the
> guard against shutting down all threads to write_pool_threads.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfsctl.c | 14 ++++++++++++--
>  fs/nfsd/nfsd.h   |  3 ++-
>  fs/nfsd/nfssvc.c | 18 ++----------------
>  3 files changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 202140df8f82..121b866125d4 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -406,7 +406,7 @@ static ssize_t write_threads(struct file *file, char *buf, size_t size)
>  			return -EINVAL;
>  		trace_nfsd_ctl_threads(net, newthreads);
>  		mutex_lock(&nfsd_mutex);
> -		rv = nfsd_svc(newthreads, net, file->f_cred, NULL);
> +		rv = nfsd_svc(1, &newthreads, net, file->f_cred, NULL);
>  		mutex_unlock(&nfsd_mutex);
>  		if (rv < 0)
>  			return rv;
> @@ -481,6 +481,16 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
>  				goto out_free;
>  			trace_nfsd_ctl_pool_threads(net, i, nthreads[i]);
>  		}
> +
> +		/*
> +		 * There must always be a thread in pool 0; the admin
> +		 * can't shut down NFS completely using pool_threads.
> +		 *
> +		 * FIXME: do we really need this?

Hi, how do you plan to decide this question?


> +		 */
> +		if (nthreads[0] == 0)
> +			nthreads[0] = 1;
> +
>  		rv = nfsd_set_nrthreads(i, nthreads, net);
>  		if (rv)
>  			goto out_free;
> @@ -1722,7 +1732,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
>  			scope = nla_data(attr);
>  	}
>  
> -	ret = nfsd_svc(nthreads, net, get_current_cred(), scope);
> +	ret = nfsd_svc(1, &nthreads, net, get_current_cred(), scope);
>  
>  out_unlock:
>  	mutex_unlock(&nfsd_mutex);
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 8f4f239d9f8a..cec8697b1cd6 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -103,7 +103,8 @@ bool		nfssvc_encode_voidres(struct svc_rqst *rqstp,
>  /*
>   * Function prototypes.
>   */
> -int		nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scope);
> +int		nfsd_svc(int n, int *nservers, struct net *net,
> +			 const struct cred *cred, const char *scope);
>  int		nfsd_dispatch(struct svc_rqst *rqstp);
>  
>  int		nfsd_nrthreads(struct net *);
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index cd9a6a1a9fc8..076f35dc17e4 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -744,13 +744,6 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)

Since you are slightly changing the API contract for this publicly
visible function, now would be a good time to add a kdoc comment.


>  		}
>  	}
>  
> -	/*
> -	 * There must always be a thread in pool 0; the admin
> -	 * can't shut down NFS completely using pool_threads.
> -	 */
> -	if (nthreads[0] == 0)
> -		nthreads[0] = 1;
> -
>  	/* apply the new numbers */
>  	for (i = 0; i < n; i++) {
>  		err = svc_set_num_threads(nn->nfsd_serv,
> @@ -768,7 +761,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
>   * this is the first time nrservs is nonzero.
>   */
>  int
> -nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scope)
> +nfsd_svc(int n, int *nthreads, struct net *net, const struct cred *cred, const char *scope)

Ditto: the patch changes the synopsis of nfsd_svc(), so I'd like a
kdoc comment to go with it.

And, this particular change is the reason for this patch, so the
description should state that (especially since subsequent
patch descriptions refer to "now that nfsd_svc takes an array
of threads..." : I had to come back to this patch and blink twice
to see why it said that).

A kdoc comment from sunrpc_get_pool_mode() should also be added
in 4/5.


>  {
>  	int	error;
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> @@ -778,13 +771,6 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scop
>  
>  	dprintk("nfsd: creating service\n");
>  
> -	nrservs = max(nrservs, 0);
> -	nrservs = min(nrservs, NFSD_MAXSERVS);
> -	error = 0;
> -
> -	if (nrservs == 0 && nn->nfsd_serv == NULL)
> -		goto out;
> -
>  	strscpy(nn->nfsd_name, scope ? scope : utsname()->nodename,
>  		sizeof(nn->nfsd_name));
>  
> @@ -796,7 +782,7 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scop
>  	error = nfsd_startup_net(net, cred);
>  	if (error)
>  		goto out_put;
> -	error = svc_set_num_threads(serv, NULL, nrservs);
> +	error = nfsd_set_nrthreads(n, nthreads, net);
>  	if (error)
>  		goto out_put;
>  	error = serv->sv_nrthreads;
> 
> -- 
> 2.45.2
> 

-- 
Chuck Lever

