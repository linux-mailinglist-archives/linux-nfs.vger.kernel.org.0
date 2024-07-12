Return-Path: <linux-nfs+bounces-4873-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 557C39300A5
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 20:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7990A1C2080C
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 18:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6006814F70;
	Fri, 12 Jul 2024 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LUdkrWqu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uad+mT5W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08F1D554
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jul 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720810740; cv=fail; b=TZ+Jdpk/B3Uto+huxILjJsfoup7cnoZU18RRswFhLWujpW2edkqS2Tpn/KxtqB697RZBvtA93rCWZZVH+BsxzC0RUI28RR4Lt+KTw7wliIofUATtwfhY6jx8mYpvZvHU8P5Zw8oBFXtbRHlvs8+JhpOiCbZGhB2SNaqQDde2lck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720810740; c=relaxed/simple;
	bh=TCxLiOE2cci/wF6ijp94SycFjDc5C7nziVqdF8GCPd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ERofoLdZNpOZPyyFTi824QUL7yEZ7Fox2lsgJ1IzIQrqFvnIiis8B7DDysdEUWQGdsxu+6BxGV4PhjwpAp5us1FDdP3y6+fGOFv5j3dGLXBOWqOe6ITpkf6kq3Zc1aSUAedYmBWyFE9vVEM7iZQnOi+Wmpwl11VXiS9jMWp3Tvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LUdkrWqu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uad+mT5W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CIXWq1018250;
	Fri, 12 Jul 2024 18:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=phmdWJjjilrVvVcHZHhEVmL1I0yxLl1x0EPMLjcuUvA=; b=
	LUdkrWquNl9YJK6kwyIRdeZ1x2JtsaZ5bWuf3e5nFKeseqLYv+H8xOsZ8peoiz5t
	Waf563dH2hr/3FvigHizym2yQHCGSpCfMzS0xxFEtX9i92ng6hLiSB8HBsu8AUeY
	tcwu7TiKWY0ZB/k80m5R9n4Hb/l+3rtu8GmxJX/bQS3qfqaMS9DHtrYzO9IiuhuD
	VcqwBCp4PGlBu+IfrnZo9ti8zrFuxbP40A9QipqCSay232H4uymtTcTAxJbK7RAt
	rBcIYhbu+PWIWhhHBLxTsjf5IP6yWPvzoqGbTfPmdNVVY6FssacO67Nfyw0/67uR
	Ubtb1CB8Xz9GwN/1vpYaXQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfsvn0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 18:58:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CImo3i010924;
	Fri, 12 Jul 2024 18:58:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv7ercs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 18:58:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3tzraxb8x2AFF4o369KACAmtFHsuI3iiqpQzWxXNJDb20eqE5w1kliVel0Z5H0dfYFouMhJrKbnXirf1jqqDbvr4SAJrEitprS0j8AN/01hOztS08Q19XbS8COfjxz+vvPHeENIFhVZabW/tWUn5xAP4/wkaJJX0gT1lYI2mCBHwBqnCRUk1SBYncGUaifwT5wpXwLf4E+9y+djCbLlju+Mn3PW9umJL4sMd9X7Od2I7F2gmn0etSj/K3aIUn2xvtrT92heWWXPzoENVydMFNPUi15AswEXlVtVkmU39y4Qlr+Uhu9MXtdGz1sIZrAHO8Iq4Yq5lwlBezuh317aDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phmdWJjjilrVvVcHZHhEVmL1I0yxLl1x0EPMLjcuUvA=;
 b=FdzRQR46ygcY+nR+EYCiMqysIvsfyJA2Zg/T2I4AhvKv70kfnFlT9mpt4Xv4Hg4GDNuftWq/b+1r6RGSH4/ogeb6TNnMZPuZ3EKE3+y8vA3BO2LfhQn0ksgxsNcHIZFEN8VGo8F4WS3oXxfbtL6/fXTsg3mzWfA0vc0YsLAbj9WKypLkrWLFRaUn3ArirTsn0zihxWKDH9g4KMU890Z6A/EkLQfdE8YrGglfIZaaNiIRN4PD2jTLoxxd+8MbAGj+J/t9bJVa3n7TOLO9+TMjP2L/HdsUEma/utEGhtJa9aCFwXwgkaLp29CQkHFNjGoQuqBfc62z9mjO7R94H77Gpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phmdWJjjilrVvVcHZHhEVmL1I0yxLl1x0EPMLjcuUvA=;
 b=Uad+mT5WD9ujzHnaGsuw0/8++F5bKAkHHsP5LAwjOP8INZAwvhxnyw1j7VLDd0/Db8scxCC2fpRD2SfBcEJS0tSSmAsV9OB5xLSIG2cB53zQNgu7WFK9ZQjD864UPDg05simwW1vHZB0EMTyX9cuMO/PY6/kn+HRLZrlBNuxIoY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4904.namprd10.prod.outlook.com (2603:10b6:408:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 18:58:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.024; Fri, 12 Jul 2024
 18:58:47 +0000
Date: Fri, 12 Jul 2024 14:58:43 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Youzhong Yang <youzhong@gmail.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: remove unneeded EEXIST error check in
 nfsd_do_file_acquire
Message-ID: <ZpF84zVLmlC9W/Ap@tissot.1015granger.net>
References: <20240711-nfsd-next-v1-1-f9f944500503@kernel.org>
 <ZpEwdJuoPFRE+sJ9@tissot.1015granger.net>
 <CADpNCvaBr3J5w=SfUM50_DfvVhyJtgN4-xC+uHFTf_zwfvr9FA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADpNCvaBr3J5w=SfUM50_DfvVhyJtgN4-xC+uHFTf_zwfvr9FA@mail.gmail.com>
X-ClientProxiedBy: CH2PR14CA0007.namprd14.prod.outlook.com
 (2603:10b6:610:60::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB4904:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d049b95-8713-4731-8f6a-08dca2a4a8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a3dBRHB4MGZVb1BIcnJob2RkMDh5OEhKWnppM01aQ1I0S1JyTW5WQU03dHI5?=
 =?utf-8?B?NDFYUVVrUHRsMHEzNFAvVXdYa1V6RVpVOGRRenNsOTA4WnhSWXptTVg1MEIz?=
 =?utf-8?B?NHRabDJoK2pCZGZ5Zk42Q1ZvZWtUemtpLzJkdXRSUHBwcGhDbCtpRFVFNG90?=
 =?utf-8?B?MVZQL2xQeVZEanh4YUJqOUM2ZENQVHdsOEFYblo4OFRqUmRKT0tiZElodmNF?=
 =?utf-8?B?bU5ab0pLSVcveCtiZlNvc0drVlNueHk3TDRIV0RBL1BkbCtFSkREWFBDdDFx?=
 =?utf-8?B?c3N0SU90ckVtSVlpNi9IN29YdVdJREdKdytUNDd0TVppL1NUVzdBNjkybHRR?=
 =?utf-8?B?OFVwcWhaOVNveTBEc0xITS9Bb3RKd3p6SlprNXlZQmtFWElBbDM2NlJzbWs5?=
 =?utf-8?B?UHRDMnEyOGhkcHZ1RzVpbFBtV01NTm0wZ0lhRG5TaGtCYms3d0lWc3dob3Ur?=
 =?utf-8?B?MzVadjk1Zk9MSXVISlM5Mno5azJURWpjVEhqRHg1bFBZZGVLVVk0dVEwYmhS?=
 =?utf-8?B?OWhhRS8zZDdTUEEvK3U1NU50U3A4UXpZR1J2dzVxZ2ptaC9sYUZZRmJ6b1k0?=
 =?utf-8?B?Qmp0UVV6RXY4S0JkeU5ISHhkUHE1Tk1TeVFUNDc5dXBLS01vaG1LZHhrMzZi?=
 =?utf-8?B?dlZ5TExIZXBRMDN4b2RiUkxQQ0diVzhXKzVQNDRacm1lVXZwK0dCdkZVL0Z0?=
 =?utf-8?B?YjROUW5SK09qRVgyb3lkZnVKVmNmNDRKcHVuTUZiQi80STNRNjhvK0dxUG5z?=
 =?utf-8?B?VGlvSktuc0t4bGg3ZlNLczZGbVFoejlZSzZRRXlhektqOHUxS2h2UVM2cFJz?=
 =?utf-8?B?dUtBMlhidzE4ZVR2WDhTZU5wazU0ak0xalFDMGN2cTZnUDNWU24wRkdlOCtv?=
 =?utf-8?B?ajlhOUlRMC9QZnNGa0JWbFIzbVYyMi9ocTN3dzExMTh6UDZ2OU8vZFplYjl6?=
 =?utf-8?B?a29zdGwrTzNVdEh2MWZhWGJ4VTc4S0d6cTQwUmZhTDNzQkJ0Um5uVXU3cjAx?=
 =?utf-8?B?Vk5PVFVSREROUHptYkk2MmJOZ0paWTlTWEc0SkpwaVpFUkRnVFdiVWZCZUdm?=
 =?utf-8?B?WDFvUWVmbFBESmQ0UllhWmFyWXRqTm02UnpSenhNQk1xR3U4UXRPdDRKS0J4?=
 =?utf-8?B?MEhTbm0rSUxXM2xkVStLK1hYTGVVQmt4RFNobXJmT1JRd29rOEkxMGk5a3dn?=
 =?utf-8?B?V2g4Vnh1L1kyWitRS3pLekhiRFJPbGxNTktrTHZLTWtSUzg3SEtyNy96Mmxv?=
 =?utf-8?B?UVZaNnA3YXpNZEpwRW5aTnRiTWhaQkpjTlg3UkI3M3Z4aStnVTVka1ZDZldq?=
 =?utf-8?B?SElENDg0UGVGZ3RycWFrSG44S0piY1lMaXpFZG9EWmpDY3ZCN1dFWkJHYWtt?=
 =?utf-8?B?RFNaK1dKVVpEakdTOE1DY3U5c2Y2SlZLUEMraWxXOVdQb0Z3bmtVVURYVFNx?=
 =?utf-8?B?VnRBSTA5b0ZwOFNuMXRjc3I0eHAwdVBSTElrdEtORkpiQVBXWVNMN2NpRTFB?=
 =?utf-8?B?UnRPS3ZTcTRlUllsVURCK2NBRk9rSWc0UHhocmZNMHFsaWUyaU1DcW9RWFRG?=
 =?utf-8?B?WmJMaXJHTDUvWFFBSGlUZ0V4TnhkbWt0L00wYlJHSDZjeThwTDRvTFQ1UEZQ?=
 =?utf-8?B?VVBqYUhsaHpJVmwrYW9sQ2lvY0JXOVZGOHBQZnI4UTVEUm1uL0diWnBwZExz?=
 =?utf-8?B?K1kwcjFEelhtYkh0VlR1MHI4MDVzOEltV0pDbnlMQW9HRkkvQTd2VnJsQmpP?=
 =?utf-8?B?SVhKclBJUkdqMTJEUnpVQlhFMkRiVGZVWG1tUWdlY3NMcE9oczg0dXEvK3hT?=
 =?utf-8?B?R1VwRnh4Qko1MWJmcTJ0UT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZFFwVkFYSGRJd1pmRnI3aVQ5ZHcxbkppcFNIczZiaCtEOStGdjhYa2Uzcm50?=
 =?utf-8?B?VTJDZ0RBTFdSdkdzdDJ6aTNTcmRNalZhTEJrTjRWTWFhbFV5VDZCcmg1QnF4?=
 =?utf-8?B?KzRJZWQwZEpaK0I3YzBVckl5V2pPMnVEQWxQeVJScVJGOE83Vy91NUhwY1VB?=
 =?utf-8?B?SlpQSWQxTGpNK0pENGxIOU5MSXZyQmY2R05CUkdOTmRvNGIyZEZuWWNJd3Jp?=
 =?utf-8?B?KytsdW1OZlBxRE0reEJkTXYvN2RhcEJBdWlURFNEVEVCM3lHYWFiL0V4Nkw5?=
 =?utf-8?B?bHdLTlN1dE1qQzB1MlU2VTl3Q3U0TmlVNWRRWGZUWlBOMkd1anhmZ2Evem83?=
 =?utf-8?B?QUJiRHdwTXdnek1MT3Q4YkxqbjY2KzlEVytLbExPdERETmpQVTB0Y29SckQw?=
 =?utf-8?B?MnBCS0JzZVAvSVBMZElNa1BVSUwrdXc4SElVVUdQK2c1NVVWUmVjNlZQZ2JI?=
 =?utf-8?B?NWVhOXJ1NWRiR2cxRE5NL2RZaDllTVpvWlVzbk52NHlIc2hSbmFMOUt3Nlcr?=
 =?utf-8?B?b1dhM1pPbmlhT1FYaGdUc2xINWdsVlgyc2FEOTBxUjJET25OWHlmMjFwK04w?=
 =?utf-8?B?L0pieUJxZ1ZTamZQMzV3ZTQxdWRNTG9SbUZ4QlRmeFd2NHNuSDJYYk5IdXhh?=
 =?utf-8?B?c25Sek1sNnErdzVienRYV1hpbzErSEpZVWxEK3pRbEpyeUEvZWtzUld1T3BE?=
 =?utf-8?B?WW5PaWYvOUtMT2tQUVg3d1gzQ3poZnJDWmg5T1ZqL01zR2tqRVB0SzZkREx5?=
 =?utf-8?B?VnZ2OVlMTlZ2RUxFNjZ3MkJFdW1Tc2RsUTZwWUc5Yi94SFN6OCtUV3RDTFB6?=
 =?utf-8?B?dWlTMFV0VkM3dkplbyt5K1R4dTB4NjJuOWNmVENzenMrZy9jNm5FUksvUWlW?=
 =?utf-8?B?eCtMSnIvaDNNdG1zTVNSME1qSE16ejg5MlYwYTJZa21IQkZqT2sweStjS3BH?=
 =?utf-8?B?QmNQNHhuOEtCVkgrM1QxVUJSZ1E1SjhvSGhNemJlZVZ2NnBXTWxVQWdhbk95?=
 =?utf-8?B?OUt2YytlYjdNaDV4MG9BK2QzUk52K1BzR1VHbUtLSFY5K2wvU3JBV1BzU25t?=
 =?utf-8?B?V0lOTXFyZS83R1VtWm85bWN5b3dqcG03L3o0Ym11OWZyTktGYlZtdTN1Q2VY?=
 =?utf-8?B?T2VnRml3bWpJRVVXY2VZL3lVbkpSL1hPQmVXYTNJenlkampCYVdyOU5zRSs3?=
 =?utf-8?B?V3B4RXJNdzZobVRKS0F4bXA3SGZwTVhvN2RoTDV6TGFIckNJd1dMdkxYRnln?=
 =?utf-8?B?T2xVRUVUTm5sV3UrdDhBU05OMG9QZHdnWmdhZFFXcUhWK2JhdGRqblB6Zk5L?=
 =?utf-8?B?TUJqTUNCSXAyVEQvbk0zeGYzUXhsWU5UdGlGN2JXSDZqZnpFc3NLUXhLNUFy?=
 =?utf-8?B?R2dPWE5GQWw4UGpmWFdwQnRLSk9Jd1hRL1E3UWhCUTIxVzR6VEhRUjAwY3M4?=
 =?utf-8?B?MUIya2Z1WldoeUtiNjV1MzNGU3hseWJycGFtZG1sSnQvUU80MFgzMVgza1NV?=
 =?utf-8?B?RzJsazczYVFtT0JHV1Z4eVJNbjhtZ0plWWUyQWIzN3RZWlgrMEZsd1cxcEJO?=
 =?utf-8?B?ZnpKc2NMWW9OQmVleEFIZ1VqaHE1NXNmelMrZ1F3REFxdkFmN3RoekV2R1RI?=
 =?utf-8?B?d0xWN1ZPK0hKOXZKSGpjZG5tWFhvam15VUcrYXVaNnZHSUkza096OHdPY0N4?=
 =?utf-8?B?eFJOOVJwaDBOanEzOEkyNWlKVE92Zk5ZS2FHUnRGOXpwUkJMWkFuTC9nMGdo?=
 =?utf-8?B?ZU1wZE1HS3ZZWm9FT2NZcFJHNjB3ZTgrWDFDNmpoNFB4WVhGYjI1c3pYK2Nv?=
 =?utf-8?B?eVFoV2cvU2preGV3TkFMbWNGVGhGdlFtdXV3ZDd3c2NtYjFKcEZFSmlGWHFl?=
 =?utf-8?B?U21pck5idDFCdi9sU3lzblcvSWxZckJ5bFM2cXBpQkM3MDc1cysxU2IvSDZ1?=
 =?utf-8?B?bDJtOHNqR1ZTREgrR29xeVZxdFJBbndVVGFyS0VjQzFuZWpWUDc2VU1jTThk?=
 =?utf-8?B?Qk5WeHNjRW9xSGtybVRHcEVYMUNjRHR1UHpwbStiQzE0Tm9lVU1DNHVQbS9D?=
 =?utf-8?B?S0p2L2Fsa2I3R2Y2YStRbGZkOElLTkQ3MlNXa3AzWktuNzBBRXd0dzNTTEFv?=
 =?utf-8?B?OGdpeWFVYnlTMjFJUC96VG9aaytyTDRtU085TC9KczBhTVFLNG9Qd3FWTTB4?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IaF0I9WZz0TTZgyzPkkjRV6lidHIxPBg4X1MOCI3fGAX5+iPW3wDSnYP36KLa00Y46+BIJQo0tAeEpL435bWmHnCrbBh39gFrev7WPz2ao7pQRWD/Db7YPCfngFNQaiT1FivTKC187TWVmjVJK2DsufafEMQIXAdnRerKqPZnozkUh4hKPP2XJ3ABuNYj6PDq1XTNC+1rSNj59Wph0F1Ylqxj33pARpvt3ToDpqi/iynUmb9Wwb1x0Slmhr7HDdZ4HFgZ2Olq6qX7WnGSG6KF2TE1/tP8JiSJ25wKFhqtLysWYT7MMw2NqhCCwgqnw+3nDB3KQgHxbNapM7gBh8Gu/n/axwDzsGcRKALG1/j4v9V4k6a3zl5Jt3qMBNNBm3zbZJu+4WVRTMN101Wa7d5INoXfuKk7lXkUEofNfNfwJYntkPFCxWGprZeth6yAdnC+Wisz+Oaid2KPr+t/5pOuvpC4r/aAj++FQg10yonBhpIKuvJqqc8o0yFcQlMug9KjnJdQb4jVRTzqikmUOCHZ3cPBrTYBFOrIaJBLZQIHVDkRptNZp6Zx5Tb44YMfSxxgmF+uKa2LAXMgTVMaDmn2sR/4BeSzgCp3WHYTAQhkPQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d049b95-8713-4731-8f6a-08dca2a4a8ca
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 18:58:47.1083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BZE56WfrALU5X6Et7dAMjUy92dK0ansQJ9dg3rIti4SlDcGyCjFErX/MXcxSVqRz0MYLbIwk2BIpw13joDHcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_15,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120129
X-Proofpoint-ORIG-GUID: sLtwRFkM8UNCXFiA_ncru-8i5ypDhlzK
X-Proofpoint-GUID: sLtwRFkM8UNCXFiA_ncru-8i5ypDhlzK

On Fri, Jul 12, 2024 at 02:30:04PM -0400, Youzhong Yang wrote:
> Testing is done with this patch applied. All good, no surprise.

Awesome, I've replaced 1/3 with this patch.

These are all applied to a private tree at the moment. I will push
them to the public nfsd-next branch when the 6.11 merge window
closes.


> On Fri, Jul 12, 2024 at 9:32 AM Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > On Thu, Jul 11, 2024 at 03:11:13PM -0400, Jeff Layton wrote:
> > > Given that we do the search and insertion while holding the i_lock, I
> > > don't think it's possible for us to get EEXIST here. Remove this case.
> > >
> > > Cc: Youzhong Yang <youzhong@gmail.com>
> > > Fixes: c6593366c0bf ("nfsd: don't kill nfsd_files because of lease break error")
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > This is replacement for PATCH 1/3 in the series I sent yesterday. I
> > > think it makes sense to just eliminate this case.
> > > ---
> > >  fs/nfsd/filecache.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index f84913691b78..b9dc7c22242c 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -1038,8 +1038,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > >       if (likely(ret == 0))
> > >               goto open_file;
> > >
> > > -     if (ret == -EEXIST)
> > > -             goto retry;
> > >       trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
> > >       status = nfserr_jukebox;
> > >       goto construction_err;
> > >
> > > ---
> > > base-commit: ec1772c39fa8dd85340b1a02040806377ffbff27
> > > change-id: 20240711-nfsd-next-c9d17f66e2bd
> > >
> > > Best regards,
> > > --
> > > Jeff Layton <jlayton@kernel.org>
> >
> > Youzhong, can you replace 1/3 in Jeff's file cache series and
> > test again please?
> >
> > --
> > Chuck Lever

-- 
Chuck Lever

