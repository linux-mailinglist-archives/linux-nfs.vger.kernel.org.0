Return-Path: <linux-nfs+bounces-6165-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A52AF96A2AD
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 17:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2C81F294C2
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B606188A21;
	Tue,  3 Sep 2024 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B0WTi1AV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vNePd/zp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A56718890C;
	Tue,  3 Sep 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377308; cv=fail; b=TYHt0UZ5LaTxLMgQxu+RT7CNSGiClgtXBC8FAgmM8VJOxONwce3XD3WfqwXVYho/HbGYIe4KTp/yBowBiO1bQp26rsHVCrKTrtnQEBokzb+ASY5aBggdkRld9pEYhWfcNbnZOEK/y44Y1JLiaqp1hkN+9+2Kxuq1AZ63RcUMhKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377308; c=relaxed/simple;
	bh=Ze2TCUkJYWZ8HpTxWPhg4pubvYvADwFtQEuT7urtnCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q6eB4vp8BvC5+mGa3OQt02Nj7XblTvzcvUkINLPVsVT+mHKbp5QzddnDD3nwMPgtNgpQWryj8nVlGFliDhaLrwqoNlB/qYb6BpJFkM6BYixpQjfHjFE4srkJ1Cw+/TgvJZsEpJVf2y85KJm6K1AEEARMooHGKoKXhgJ6dQDEGX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B0WTi1AV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vNePd/zp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483EdRtv007949;
	Tue, 3 Sep 2024 15:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=ijkyU6TPhFeTXo0
	Trt5lZP1DpiALWZpBnaJijFQ8th8=; b=B0WTi1AVxk7jR6TcLD+w6WYi/AB7YED
	/ifvLKcFoXIzaIFuWDJIBvjiScKoh1Dr8tAozQT8En4inEYO9hPpFKUCHWT88x34
	oZp5IPB9UmNzpB/zAcsZOkmbKNhwq4n2hvbgzFUZZkw6LaHiHpXu/SMVcjkNtbfQ
	KGbZsqpEBOfApDUOJCwrNkrjVP7tSFO36zvzQAI/WgjUGw89nvsVQEdgNfZf+GRp
	RYs3azAFudrfE6h2Ok1e7PaTm8PKKxgLuLCW0F5twSPhOHQ5wkm+8a9QF4LNLhQR
	iymIB3iADFCe5+l0R/nEQVMIXaNl+gq163llk+y1rV8uM1E1I2hGFzA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dwndh3jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 15:27:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483F68eh023700;
	Tue, 3 Sep 2024 15:27:55 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm8c2rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 15:27:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYMIY9wrbH7Bn0udlXz7vGyQN6BRZ1fGwoQw9jtFRBXRhpa1wxqePYtu/V/rXFBNXIkry9g3f+FfK+DF+jT0rxWY37bs3gSbkHfJx9oqcnvmhoXhC2G1aeZgiAk0N4Fi/+TlmyUokDhtcczpQY0+GlKhf4ILcBBzr2WQtntXVl/AWCi+2YmimY99ChAbHLeIPDK29KK2ED7x2S7x3Tw8grnFa6zeZ9UkykZonxfDhfPLt5DhHy7daH3hFmFv7vO7PGkeVnKBqAB8j5nfdk23sfZrd0ncbCxQgskfp2BZ3quREO2rrHJ33mSOLe84nU+7WyDgXSrYDcPGLoN0cVcwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijkyU6TPhFeTXo0Trt5lZP1DpiALWZpBnaJijFQ8th8=;
 b=ANVlAvorAwSELbs4hF3u9eveLLdN3HE1QOSHgunGorcV6xfvytIi5zr8lV0Omn+IpiPaqbZ318jfBOk1U2HHEvB42p6S+QpsmHo/wKM1X1GLZu2Ddunzvvi/v69dloVBli06u7A/cmEp+rL7K/1UcHzcsxlSXbVPRK0pDEtKTsTJMycFe1BBBin0KBZQ141YNabZ70MP2eWwdvYmEQhJ2XhcOWUnKmuljalS8vMMrdNi9WlJjwZKpNvurB3qUf8c8cfKNzHB7oDaI8ZUBTwyNT3fRAiivgzYvvHLvBWjpXakBnpBXG/788IpKkt7vE426ogI3HTaRovFSH3zfN1yQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijkyU6TPhFeTXo0Trt5lZP1DpiALWZpBnaJijFQ8th8=;
 b=vNePd/zpvNZPJLGDRGt3sOCyKnRpwTZDAe5vUzDXVlPHjIuhMOyvlCuhfqyc8obKHnFwp1RjGBYZNLVjS8h737fMNKTYxHwlOfKw/nYSHzQK85LB9jCA43vMgZeCpqwqulZdmKUoq0UNs8pzFZwxu3PA5S+zXJNbmH8QH6ICxFw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7842.namprd10.prod.outlook.com (2603:10b6:408:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 15:27:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.007; Tue, 3 Sep 2024
 15:27:52 +0000
Date: Tue, 3 Sep 2024 11:27:49 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Scott Mayhew <smayhew@redhat.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, neilb@suse.de, okorniev@redhat.com,
        Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng@huaweicloud.com
Subject: Re: [PATCH] nfsd: return -EINVAL when namelen is 0
Message-ID: <Ztcq9RB6SPhxbDl5@tissot.1015granger.net>
References: <20240903111446.659884-1-lilingfeng3@huawei.com>
 <73d25d586d1306cd5820058f9062a79ca657d362.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73d25d586d1306cd5820058f9062a79ca657d362.camel@kernel.org>
X-ClientProxiedBy: CH0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:610:b1::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ca7e53-f78f-4748-f599-08dccc2cf9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IVEjzNOqcmHZ5q5Har0XP0SnbtKqfTm2uyIq4jo9/QkFuSPTB/Q3uxgKy2zq?=
 =?us-ascii?Q?Sc2Zvv4lrQZncOQ6/yAiRHmcakhUsCEPHwWQ7/KPY9JyxAMUvZbudgGznT27?=
 =?us-ascii?Q?DhkhgTNQQ1Mw92YyQASCBZ43RUCjwtViVJNHbNnsC8XQluOwXoJfH7lcHVIf?=
 =?us-ascii?Q?LO9XPUOwQ8UKxTD+jXqzUmo8MQmx+WhCvpodEBTZTfE3WmrhU0KHmBl5Sngh?=
 =?us-ascii?Q?Z3NyA9XKX/EXgajUFeMetwp19vjSLo1if6qQ+UeSs0wYZcya8YZ3UeODADEz?=
 =?us-ascii?Q?h84eJYNUFY3xOim0lY2XQnNtwVH3gNOnvX0+MtSBLSm76MUl4uE1vfffSJ29?=
 =?us-ascii?Q?0Ob5wBfIeMPqZ7ZMN57BTBJ9oqZ12xCWKMRPfRE/GJXp53F9GvaMpJS37Lx2?=
 =?us-ascii?Q?77AgKMoQxZCM5UNr44S9Qqu68o6SD3zkInGLp3AzCs0hHTcO/QGaBXfSDw4O?=
 =?us-ascii?Q?kKau35/tHCiz/qCKByORSbdCznRkUXEQ1jlhBz2ZIP4eE5F24y3lTmZDcVl+?=
 =?us-ascii?Q?wQibUO6s8DKiN1WSJ79ktDHYMNjhFOeEkbUJLi9at4ALm8R7oReOibnONvxP?=
 =?us-ascii?Q?2h3BJ10SNSA/Uxw0dZmI5J1BN3B+MkPuJE6D/szC5+6TtHf8zwPJPSRWgM9q?=
 =?us-ascii?Q?3WcwnDro84ylI31QCgWIRRdhz+5uPDUtDeBAKcHlcdGGqlnuB3OuUQdyNji7?=
 =?us-ascii?Q?HQJYILjJP4LOxqFFyq/351aRjK4VRSEuafYksXF0FimtQTDXEhcy3e+Bnkq/?=
 =?us-ascii?Q?KBSRiV/MdMYZqkgywvY5DHhFkjW8XOiss4Ialj9arjE+GQzviNN/MYJrzM+I?=
 =?us-ascii?Q?EhOUBaz4U36RPG7tVhUHk8tiSKbiOrzPNlCzpr3fS29N3dvkz0Ze9VBABTD1?=
 =?us-ascii?Q?Ikm5nQF7YzzIHBrp4CeqtSsRUGezGXXJ8jPN2Jt9MR1AODxpjTEKyoJe0fhN?=
 =?us-ascii?Q?ehPaVKzuS8Vz4dKJCUYsv1jDSBcbxja+oKVK4KPQA2BAw//jFWQOPp7pCZHL?=
 =?us-ascii?Q?+2R5+uRZBy0GSPyvzTNwXHs5ReeHraC0k6IuEv+6i6WXOM4mkP0pr1tfNDO8?=
 =?us-ascii?Q?0A7X8Xl4Kg4IvCU9GGXRt6yRASWvK7XzbTuKxkTBCJMjrKUQAjHxVz89l+57?=
 =?us-ascii?Q?IfWtboj/n3Nzb61RifR4+y0UHX2tdUj3wjOU4OrS3co8lc5tRTevTmxWx2YJ?=
 =?us-ascii?Q?YmnUHl2gTL0luCp26d8Sn22OdoK3IsRf7Nwpj06+5cx6dJEdK0dgr/c7BKiQ?=
 =?us-ascii?Q?dmEB+n4d9ghUBdaz8Pg1RxL9VDQaBM0oUMzlZDFb0YVYdUDYFSI++tMh137B?=
 =?us-ascii?Q?H3AR7VOlM/moNIOdVOQVa7Sv4f6SD+XNCgrO6LpklyVcUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3dta3RwuO+Jjg60Es9A8SuMFpwGWpqczkypBHvQLK19wjz5ECV/3LokuYnRc?=
 =?us-ascii?Q?GJ6Igo6ZafRj8JQtzHr9SA1N7Wd5GBRAIN+ynXotHGvxyvaA+pmNupofKawT?=
 =?us-ascii?Q?FFzmT/7k27yf0AWc487oDOFLssXswdVpvleEGKMS9Ha5SoEDgxRJeKtq0Z8W?=
 =?us-ascii?Q?48dKnb+qZUYjn1L1Dzsh73uclxMoGssS/EF4zZIGXatUVAyDhIjRNOA1r1zK?=
 =?us-ascii?Q?1vVOeKZP41HVdHuEQiAommqlTkMNe2s51hjQSPd6uk4xqNJlyreKdZZsrSth?=
 =?us-ascii?Q?dV4LwxdA4yM8QV6sVwzFD5SU11HAX0ESCoxRk0Fatet7Y0ATl09w3ii6i3sF?=
 =?us-ascii?Q?TACj0IrTq2G6V17IBFhNfe29DKDGcXrOUWvJAxTx0EKwR2fEYtMDg0UIHspA?=
 =?us-ascii?Q?QhGkzWQcwciFwb+fKshEdQbPH7ps0KScw2vQmVNGaN8bWzXlMMzZoui7Y930?=
 =?us-ascii?Q?2jHv+cADC57DjNvnM9tsmYPQKFPoVakzfPw5O1SlORFo0IpueaIg0OfswgrJ?=
 =?us-ascii?Q?DYpgQqTRkNcHycNsznwXUQgND9pJ95OURP602mUb1m9xomCFPAnL2wP2FrOL?=
 =?us-ascii?Q?xHpvZAKBGrThAa3PXrNKqAY0x6SemP1sYbcLa9TyTMfSw9ykPU1XQyFRt4ri?=
 =?us-ascii?Q?P7vYM7f+dmkbh1RchLvlr4rIaGLfXMvsWcIYFNyn4ymEwA/tL5ZrMJ3BZbCv?=
 =?us-ascii?Q?mFjnsdJjw3w3K4uSZtKYIekFWZzNPtNMcYen4153nK/bAIKJRzHnWlkFLI2P?=
 =?us-ascii?Q?GqGgVTsxarkXb9d343s0CM31p2oT6AUHSGPjiunnOBSPjHHnVRf2NYcYg8YM?=
 =?us-ascii?Q?SmVBmX1OaEM0C3kVvo6EUWszyoqWqPJ4CSeNf/hobAeKIim0sK1iUU+s/uOj?=
 =?us-ascii?Q?EJpKl1IAcXY6IEEJ8xCXoB5k9FGCNIQf9RaUlKUxj7oX87L++rq4sVaL0VGV?=
 =?us-ascii?Q?EaeC5D3wrRj7Jxpxb1CHee/pcDtPP9WAtsLmiey3ReDxpe9vKK7GMH8qLsWM?=
 =?us-ascii?Q?08bA273C5Z0L8E4kd6w2HMKu3bmlAdxQnCSIpnkMKNyqU85YQsdu2poAfk9h?=
 =?us-ascii?Q?KwmSDkGp6tKjybbAEIAVOmdk+Oj+N9aO9Lr38KoA9UbfeEf19+pMyaIrDDsI?=
 =?us-ascii?Q?X7CaQrbJ84q0oYZgB20dQc6XGRicB8fqCab9eLn1/wc2m7Mj58kvnIZBz7MM?=
 =?us-ascii?Q?dWzzOoPtBTNhT6EsdSpuRhQKvjUihKNsRrl6f95ujg7zvH2uTDJ02LZaP8rY?=
 =?us-ascii?Q?U8Rr9X+tJrYqv+xcf7Ki1+5SN2cj+fqIRabj+dyzFvlHKINyU1M1nLDCJenc?=
 =?us-ascii?Q?z7V0Tm5KP3lNSbxSuXYivrjU8AccHd3apgBKbigkfzObYkPn9jwR5F2d/reE?=
 =?us-ascii?Q?oITJAWQN7IaxZmBFGPPkysWXsbxxB9ZTkiXdxre/V2TH5ZPRXmNpHPePLocq?=
 =?us-ascii?Q?dePMnSHtV7IGlCoJ8SuT0Mxa3PcVe10NxxOOPpA6EYrSqyUBEMX1x9ek5cBc?=
 =?us-ascii?Q?KxSpZW7lrXyHnv2J5kDd9dACXKZN0xfuJOTFWbHVkFTDFG2TfxROzU2cnu0a?=
 =?us-ascii?Q?Vtr/ie2eTR2X2pLXSSV0FhI+WX4BOxCr3fC+pmgU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OoAnHDmlh4A2g8xjYqM6AUQMbYtpWBdEl9KtF4tO89E/8kTz6aY4t7qwXwtQXGiX6h72ebAgMierkzhP54blXFYGGM8pOJFmqeA2wYYmkaGUlpq7NjkG4A4USaR5oDx7N1ftQykgMgwEAUAtOjwADzt6TWVFqB98jQfPcHU45ewuIMd+H5FYOVaguCnuRE87q6I8bR6V1rFvhF0caTMnJvx/sG0wvqW7MlAOhBXNqicrTSU5PiH0VGVmEp7h335TVXOrFFbqrJq1V0ZQ442gQv6MJwpN2y+M2rXslFTH35IQ3ZBNFIDYrn2g9agjnXksq3USMsG7mugAJFBS1hujuZcBW5woYNoklcS7z3q0Wzr2mJDwYNPyXti8St2pbNtwvEGjNgU3e6J+yh3CuXAmTtn5V2d2edboGzhnHa8vkn/yusiAxtHjLs1S5EEORVSSfcBk5wGSyYsjxuVI1R8GqJFozlqyQuTVCDdkvIHLw9YjUL378fiWPDA8WbH/ZUNH2KqsqOsWRyH4PvvLzH0cqpXh2aiPbwBVsto7sw5R9kQKNEyisLZbHRc1h8062Ns7A6+L9nED9KgGbQGDGrln3a7+Ny1R2gwLm+nZgDTBnio=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ca7e53-f78f-4748-f599-08dccc2cf9fc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 15:27:52.6374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYrdTyimiTxVsM0s0qhJIIdMUjpUAnri0inD9pfQTeff0tpogOkbtfIiJaoPKMuBv90xTiL0/WhHWY4VWCEUGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_03,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030125
X-Proofpoint-GUID: J1-4mZ3p2oAJBLD_J832SuQHZxGmwN0X
X-Proofpoint-ORIG-GUID: J1-4mZ3p2oAJBLD_J832SuQHZxGmwN0X

On Tue, Sep 03, 2024 at 07:23:18AM -0400, Jeff Layton wrote:
> On Tue, 2024-09-03 at 19:14 +0800, Li Lingfeng wrote:
> > When we have a corrupted main.sqlite in /var/lib/nfs/nfsdcld/, it may
> > result in namelen being 0, which will cause memdup_user() to return
> > ZERO_SIZE_PTR.
> > When we access the name.data that has been assigned the value of
> > ZERO_SIZE_PTR in nfs4_client_to_reclaim(), null pointer dereference is
> > triggered.
> > 
> > [ T1205] ==================================================================
> > [ T1205] BUG: KASAN: null-ptr-deref in nfs4_client_to_reclaim+0xe9/0x260
> > [ T1205] Read of size 1 at addr 0000000000000010 by task nfsdcld/1205
> > [ T1205]
> > [ T1205] CPU: 11 PID: 1205 Comm: nfsdcld Not tainted 5.10.0-00003-g2c1423731b8d #406
> > [ T1205] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
> > [ T1205] Call Trace:
> > [ T1205]  dump_stack+0x9a/0xd0
> > [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
> > [ T1205]  __kasan_report.cold+0x34/0x84
> > [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
> > [ T1205]  kasan_report+0x3a/0x50
> > [ T1205]  nfs4_client_to_reclaim+0xe9/0x260
> > [ T1205]  ? nfsd4_release_lockowner+0x410/0x410
> > [ T1205]  cld_pipe_downcall+0x5ca/0x760
> > [ T1205]  ? nfsd4_cld_tracking_exit+0x1d0/0x1d0
> > [ T1205]  ? down_write_killable_nested+0x170/0x170
> > [ T1205]  ? avc_policy_seqno+0x28/0x40
> > [ T1205]  ? selinux_file_permission+0x1b4/0x1e0
> > [ T1205]  rpc_pipe_write+0x84/0xb0
> > [ T1205]  vfs_write+0x143/0x520
> > [ T1205]  ksys_write+0xc9/0x170
> > [ T1205]  ? __ia32_sys_read+0x50/0x50
> > [ T1205]  ? ktime_get_coarse_real_ts64+0xfe/0x110
> > [ T1205]  ? ktime_get_coarse_real_ts64+0xa2/0x110
> > [ T1205]  do_syscall_64+0x33/0x40
> > [ T1205]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
> > [ T1205] RIP: 0033:0x7fdbdb761bc7
> > [ T1205] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 514
> > [ T1205] RSP: 002b:00007fff8c4b7248 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > [ T1205] RAX: ffffffffffffffda RBX: 000000000000042b RCX: 00007fdbdb761bc7
> > [ T1205] RDX: 000000000000042b RSI: 00007fff8c4b75f0 RDI: 0000000000000008
> > [ T1205] RBP: 00007fdbdb761bb0 R08: 0000000000000000 R09: 0000000000000001
> > [ T1205] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000042b
> > [ T1205] R13: 0000000000000008 R14: 00007fff8c4b75f0 R15: 0000000000000000
> > [ T1205] ==================================================================
> > 
> > Fix it by checking namelen.
> > 
> > Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> > ---
> >  fs/nfsd/nfs4recover.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > index 67d8673a9391..69a3a84e159e 100644
> > --- a/fs/nfsd/nfs4recover.c
> > +++ b/fs/nfsd/nfs4recover.c
> > @@ -809,6 +809,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
> >  			ci = &cmsg->cm_u.cm_clntinfo;
> >  			if (get_user(namelen, &ci->cc_name.cn_len))
> >  				return -EFAULT;
> > +			if (!namelen) {
> > +				dprintk("%s: namelen should not be zero", __func__);
> > +				return -EINVAL;
> > +			}
> >  			name.data = memdup_user(&ci->cc_name.cn_id, namelen);
> >  			if (IS_ERR(name.data))
> >  				return PTR_ERR(name.data);
> > @@ -831,6 +835,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
> >  			cnm = &cmsg->cm_u.cm_name;
> >  			if (get_user(namelen, &cnm->cn_len))
> >  				return -EFAULT;
> > +			if (!namelen) {
> > +				dprintk("%s: namelen should not be zero", __func__);
> > +				return -EINVAL;
> > +			}
> >  			name.data = memdup_user(&cnm->cn_id, namelen);
> >  			if (IS_ERR(name.data))
> >  				return PTR_ERR(name.data);
> 
> This error will come back to nfsdcld in its downcall write(). -EINVAL
> is a bit generic. It might be better to go with a more distinct error,
> but I don't think it matters too much.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Wondering if

   Fixes: 74725959c33c ("nfsd: un-deprecate nfsdcld")

would be appropriate.


-- 
Chuck Lever

