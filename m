Return-Path: <linux-nfs+bounces-5069-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF97D93D48B
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 15:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162A8B21120
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 13:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4211E51E;
	Fri, 26 Jul 2024 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VyGNv7CT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y6Xsjq9Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C21E4B0
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001655; cv=fail; b=HGDkLOWhHHxCp6cGrRnG/b/IoWYT8EMkcGIAdIKDFx5dZSZ/JkbvTiZvIyCGknxQT5HfBqgRuWV0fslh1vDR6cfQClf5X61oCn3qYV9qzkRfBcvyJMY2gNKBqPQJQ1UYhY1rQu9hBjeRJVSqnp3n5/c0A0p30JQC6hGYjlG95cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001655; c=relaxed/simple;
	bh=156VUy1MKzXiW/ebRHw223xZg6/9JQUjggVwkOLtKFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HlDM08holhxp2utpCa4SV0REEfCMC94EIkmlckhIeELDLrwV8yqwLq2eD41LeomNI8/4s/3SchYZTtQBFLSaODjJhUwAqnaVF9GyxyB411Fb0vrz6R/wKVOKicTbipQPkkxwWBaHEObtuvCennxXhGrYf/R/Pa7BIIPyzeguErc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VyGNv7CT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y6Xsjq9Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q8tWtk026124;
	Fri, 26 Jul 2024 13:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=ppLWXJ8DOtb00EIK3steFyGLH+A5te/bTiH0izK8ATo=; b=
	VyGNv7CTeNv1NjOvROMif6ANWHhtcoHOyxoy5d04I/0kCDz9KjAXbRTZ4a4DdABV
	VQK8e2gnb95ZO67keujygdFc/VrSSJRqhoVJq/FN1dIi8dvom/K/XaSgi3i4dInj
	TenKxpWT8Q+TUg3PFDwN7aYXbOd0COGoibu4lpXc18mYKFmQ0YwyGfCl7IgRPV1Y
	RzfWfcd2NeNB4UiIMIlC+x3QBs4do3beJLCuQVzllyu/m0A8NJ4a9/Ck0frQVoj4
	T181kHyo+VGGGJhMlRfpFUGUsrURjs89eJ+iVJrJCJIqOLiY6ovVRG6uN/HhMxhm
	C5Qvr3jFlYRXFHN6FEEnjw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfe7nrqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 13:47:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46QDTJHd039002;
	Fri, 26 Jul 2024 13:47:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26rppnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 13:47:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqSuKXIv6NwgB30l12AXtdfuOyLfAzEDTmKiwqPzeX6n0LLljxnf+KdmizHzv0MtovWb3BgTNfOBSmrC4l+yWF3NH28PYDvDlVTmsjw63j/36Dm6R7EPOkKBjbtNOL9u80NhgIRNwPtCfyOV/NCWUy2yqD6BOnhtocucTKHug8psEzgdOuIhi936HhyKb0Wm7F3205d5HeZ+23J+g2etsh/iv+R9wdG1p7ZCnGBVeHaCZQnuYHFkbb6m3bOlgewD441u+Aw0oDtYhbi+RWvlg9wN1lc2zy8RCjoq9bjAu20+jimKYaXGOupEBqdFuW34yplqYqquP9XIIpy3NRBhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppLWXJ8DOtb00EIK3steFyGLH+A5te/bTiH0izK8ATo=;
 b=YzcecvUSmEXSBIkpysMe9gX2f7Reko0iD7+52ItqxQucWQaXtQyHjyKyXagD5N55+hIXaYrvTtgFhsa79L0efPhV93y2qCX4nDyxYQetefSOEUDRRu5cz5ZpH9HeN4aMjhw+KrBJ0zBVG0ZNC3FahugdfpTlLdUJ3HOYYyM+fHiJeeHXnZTq6jY6/u+e0VrnFEQGPzdklh3Z8pf778YyHmKW5U1+w/6rqPpimBkPdyoQ9k9BQHHkVepCEred7JUhlG94BvDYGNoCtZjbU9raoUjsJ087HZsOxcnzvRSKGNh+vbz7xxjJXfkxh8OmOlukn/QhFImmyPAqta8Ia2G/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppLWXJ8DOtb00EIK3steFyGLH+A5te/bTiH0izK8ATo=;
 b=Y6Xsjq9Y5TWKl7iZL6PWbYLTK4xOUZnhYdLtcyCFC3bG+kgDUDGViUeCQP35SE3aYau4rUcesWDG7wP+yT0rdQeTJ65pjHeI5Uk2ZfBU2jyAlrhDD/eAeCz9YONT1sNF90qSOJveUoaStEG3CYEDQ/SAapLNJUKKaYY/KIbIUiw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB8082.namprd10.prod.outlook.com (2603:10b6:408:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Fri, 26 Jul
 2024 13:47:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 13:47:08 +0000
Date: Fri, 26 Jul 2024 09:47:05 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Sagi Grimberg <sagi@grimberg.me>, Dai Ngo <dai.ngo@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH rfc 1/2] nfsd: don't assume copy notify when
 preprocessing the stateid
Message-ID: <ZqOo2UJHfOF3UbDj@tissot.1015granger.net>
References: <20240724170138.1942307-1-sagi@grimberg.me>
 <ZqE0kTRdRAibsjm7@tissot.1015granger.net>
 <CAN-5tyGAm3LYqTaJvu=w32UEdRPhOCAMtdhnK0e0KacYzTw7Uw@mail.gmail.com>
 <cf9e9f1c-6e54-4982-a82e-9208a3979989@grimberg.me>
 <CAN-5tyHj2JNWxzjkKQCK=+AMic25E9vXLVH8iFvc1ur4C+AuEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN-5tyHj2JNWxzjkKQCK=+AMic25E9vXLVH8iFvc1ur4C+AuEg@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:610:11a::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 3119b7e5-7edc-4a40-dad9-08dcad79716c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2Niczg2WWE3RDF3N3R2M0hibGFQMnpjUHpvZ3BpemIvYWtYYkZXbDdwZkxT?=
 =?utf-8?B?aFpXNWdhZmU5MXFOWldRMXFOa0YvTjFRRnkwWHZYOXhDNFIrZHVSZi9LVVRK?=
 =?utf-8?B?WFFHSWxWeWtFaFo3bzVPTHFmcGl3djFGNjR0WGlaS0N4RW9JQ21PdFh5d3k1?=
 =?utf-8?B?d2g2ZGJOYW5zR1YvQk00ZktHcW54M0hVM1lBQjJsN2Z5b2c3MExaZ3NNZHp5?=
 =?utf-8?B?VjJ2RVdVQ1BtZHV3alVnN1FPbm9WYjVmcndRR0ZiUFRoQmNmM2xGNzRiVWx4?=
 =?utf-8?B?R1RXV0V6aUNwcy9vbkRabHlmRW9Dd1o3VzZuNXFkOGE4Q2VXK1VGTHFKOUZ0?=
 =?utf-8?B?VExOakJDS0wrK3ZremFIZks1cEZ5akFKNjNmOTg3c2I4cldDNlE1a0VZZC9m?=
 =?utf-8?B?MEtwOXhrK1NUSjJrZ0oraGF6UTB3cXhMR3NNVFhOU1dmVkNnSnBCTVJhMllU?=
 =?utf-8?B?UEZ6S1Vndmk1NW03d2hwZVMyQmRmTHBsbTdpenZ1UGF4bXN3Q2M2cmhWcVhJ?=
 =?utf-8?B?UjRJTkJkOVhVNG9FTmJwNkYvZ0tyZVFPZFZNYmxOREx2RllCN3J2K2FJZTdV?=
 =?utf-8?B?OTFwa1ZISGRJQityOGY5Z2JBbVBUK1RPdis5N2pUc3Qxd20waFR3RzVXTDI5?=
 =?utf-8?B?RTRCaks5bnJNcE9pMGliN01EeGRNYmIxQzNVV0g5dXAyWFh3M0Rvd2JLck1u?=
 =?utf-8?B?KzVaR2Z0dkRhSGxJR01JM2w2L2NMZnpOa2IyemZIeHVlRVpWUDRmVE8xc3Va?=
 =?utf-8?B?MHFBSE1YZlhXNEMwOE1kVXRBUVBKbXdKWHNVZ3BJK1ovSTM2YW91bmZzajFs?=
 =?utf-8?B?Z2p0WkFVbVhRNURkSCtVeS9aOWRFY1hsTUgzYVljcUd6WERhL3R4bE1qdytX?=
 =?utf-8?B?OVQ5R3dRN05xRWU1ek9tRjN4S094dzRaNWNhYWJGSjZuemEvM3o5cklIcUVs?=
 =?utf-8?B?RHBaMzB3Zk1jQTNCRFV1VEhnRmxZUm5pWlg1WlhkMVVDNDk1VUxWb1hBQWl3?=
 =?utf-8?B?ZHRsa0xGb1JkR09McHh2ZFl5NlhoWDZyS3RBd3RtQWdjTzdaRDg3c0FJelBj?=
 =?utf-8?B?czhhTThPb1QvaDBCWE5NNExiUEJ1d00ydUszOFZRNDBTeSttSWw3VXNTcElP?=
 =?utf-8?B?UWx0dVh0cEtBVGNZbzg1ejQrVGt2eU9BelZERWkxT0dIaStPbXZBVHp5ZElo?=
 =?utf-8?B?OVRaVDdUYTBzRGVFaVVzSk9PSmtjWFo1ZENWS1FPcnh5aVpsQ2JIQTJNVWtH?=
 =?utf-8?B?dkJpZDdTQkQvVkxXU3R3RTdMNnc3TWQ5V2J5bDJNemI0NWJBNk9WR0hmZ2x6?=
 =?utf-8?B?Y3piWnduNjA2WGlWcmYrdGM5eVFsdHdwZjFTY1VrbWRpZTJlYTRpRk9uMHcy?=
 =?utf-8?B?NWJuRjJ1MGdJUDdNTTIyS01xOGFoUHluaDRwNldyNHo1UnFHeG9vQWR3NUdF?=
 =?utf-8?B?OVFWM3R1MXdnUm9kVC9OVzdadU9IK2hMZ1NWdEdrc2w1SmE2VTg5clRaWlc2?=
 =?utf-8?B?ZTZzc0RiUjYvMlNXc05Pa0M2dVlOMXlSVzFYY1EvdTRUZXh1b3RVT1VRMVkz?=
 =?utf-8?B?czV5MDVrQkpuRzBUenJza2pHK2VmU2FUelh1ajJRLzlOeUdlWERUeUJKUGtK?=
 =?utf-8?B?b2FiYlFmeDdBMjFRYnlNWFZnOHhpTDM0T3VrV3BlQTk5SjNhSFJNU0JJcVFp?=
 =?utf-8?B?RDZ5aE90bXl1bURxV2czNlhBWFYzSnpkUVpKbjRRQno2RzdDQkpVelI2Z1dD?=
 =?utf-8?B?MW9YNFBFQ3FGU2IzQTNjdjEwd3M1L0Z4Y1hjZXNjZkFicUFicXBCcUxIMW84?=
 =?utf-8?B?OE4vNVlueFpHcmlINkl4UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0VWSHFzUWZrVEg2cXlCdHRHWmlwVXFhR0lYRDd5RnE0NlR6cUk1Q3NvREZp?=
 =?utf-8?B?WmdDYnBteUF4Y29pWEZpNEtxV1hSdGlvNXUrWHAzL0tTaXQzVzNsRTY3ekx6?=
 =?utf-8?B?OGxBNHpWMUE0MW9LVGJBbzJuU1VXWmg2a1ArRHNVNjVRSGJGNm9MTTlaNWtW?=
 =?utf-8?B?ZlVvRlNObzNCQ2EvRlZObVdXbW01R0tSS05jU2lyMlhHUlNML0xyeEdPSFNX?=
 =?utf-8?B?MEFXcm84ZFVITk9rQkxMZS9EU3BiMGlIcEd5UVdSaHJyZlFFdnJYN3pWQk02?=
 =?utf-8?B?VkFtNEZzRjdFbFR6UVM0czJsQVc4MFBsYVA1U3hJdUU3cVl2Ti94anYxZVpx?=
 =?utf-8?B?dU0rSFphTWVRTXJ0SmZwcEF6RXBVNmhGT0N2d1BPckVrOXRYS3I1MXJnU1du?=
 =?utf-8?B?TzBGUUZabmJXVVlnSHRaSkdTWkNoMFFmcnlHN0RlajdqaEV1b2FOaXBtd1Bj?=
 =?utf-8?B?aE0rK1YrVnZUVjJJeVlRcDNkZDkvSmVlcXRQd1RGWkZlM2MybFFyK3Vhak92?=
 =?utf-8?B?SWVMNzNlRytVSFg4am8rRGNJSkV1czhJOHNBUVJ1U1phWUpVU2thV25Nc1Bi?=
 =?utf-8?B?bVpWR2JqZlgwbjdpMjNhK3VUdmFTbDVsWG1PRjZtZTArandIakdmdFdBSkE0?=
 =?utf-8?B?WEFDcGN3ckFRSnpldE5LdVlFMGYvZ0dZZDZQakowMWNwYnlxbS9Vd2xNSXdY?=
 =?utf-8?B?bVlWL1A0SjdQUmwwSndhNFIwcVpiaGtyK01WZ1VSaVlRU3hjTmdtZjNpVmlB?=
 =?utf-8?B?eXJ0a0FvSXFjekQrWkJ5VEdCNnkyM1N0alBCakgxRjNMeVJRbWZVUWpFaDhl?=
 =?utf-8?B?dEJZQVd6RkJSZVRNV3hzT0c1ZUxYQ0E3UENDa2dxOVpyN2F2T1FVWFl4TVMy?=
 =?utf-8?B?S3NwYk54a3BPb1hkcmI2ZHhNNU9ZYS9vUnI2M3hHR3VuQUxBdjVRdloyOXFv?=
 =?utf-8?B?WU0wNjE3ejNBTE10anVEM2xlYXIyY1BJbUs3TzN4MXFta2IvbXkrUDZmNTdD?=
 =?utf-8?B?dGMzdGpubVFCMmNNY0djQXI5NWoxOVg0cWgxM1VTQUpkZ01FNWEvTm5vZmlu?=
 =?utf-8?B?czd2M05vaEZBWkdCYUNGU2NzVzRCajA3ZlVTSkl2WEQ1ckRwcmIyWkpQL3NT?=
 =?utf-8?B?a0tIU0VxNURad2RwVEZlc01RczZrekZ5aE52RFkrUDRtR3RyR1hTNFpQb09K?=
 =?utf-8?B?UlF0OHp3UmFXSzc1Uk5mYjlhalRiMVY3aG1EdlZJTDI0S2ZpODRQRVdJeWdO?=
 =?utf-8?B?b1hzTCthNmNrL3UrMDZGSlVPTmZPTEFLSU9hZG9tbWwzQUhxTlM3cUlCU0Ew?=
 =?utf-8?B?d0tCQUgxM0g4L2N5TnJESEZnYjhqRGN6TE5zcjhCbno4SWtqWmhQbHZUSCtH?=
 =?utf-8?B?UmtuWmsyOFhYdzR3SmpHbFczZEhNdFJpUDJEWXQ4T0ZvcHgzandXUTQxL0Zs?=
 =?utf-8?B?OElxMjRxTlZXSzBXNHozc1FnbEd6cCttODdzUjFvME80ZFdGTVVtajdIK1F3?=
 =?utf-8?B?bDJiOVBOMmZEeTl3U29BREpxbnJOTUc1d2txS0ppQVMwUTBmaDNwUW1pcHNO?=
 =?utf-8?B?Wm5USUNqeVhvaDd1cVJNZ0tHSGMydmppTzZXbzZpblYvSTVCcG5SSkpGc1pJ?=
 =?utf-8?B?aThXQTBDM0FQTEp0bVRxYjVPTDNxYlNMcnZwTG5NMnBndWJ0QTd6cVZzQ2d5?=
 =?utf-8?B?NnQzVjZDVVNNY0dPcERYZHhEVVRkL29yanZvekdXanZLUUR2TU1QQktEK0xk?=
 =?utf-8?B?dFFPcVpGOCt6bUx4QlR5ZDJGNVU2UkVhbHBDd1dRSURzRGZIcEtHTVhEcWph?=
 =?utf-8?B?TndabVNSOFpRTThuTnhOU0NkU1liazJFUzQ5MFNYSWh2cXdkNmdvT2loSFhZ?=
 =?utf-8?B?c3JTT2tXZzFJai9UdE5OcE55SmxzakRjb0x6d0Z0NEF2VzVyeEU4WHlkejlx?=
 =?utf-8?B?L2ErVk1uVXJjVUwrUXFQS3pXcnhUbnlkcVM4R1ZTblBCUzNWOHU0YTZheXpN?=
 =?utf-8?B?TUVzU08xTU1OdzlMNGJNV2ozOHJHQkd1MkxxZzZHT3NUNXhhWVI0eWcrcFFM?=
 =?utf-8?B?V3c0QXBUUmdEN1lPSmlKT2IyTlk1MmZncis3Wk03c0NXTDBzNS9sV1RqeWpR?=
 =?utf-8?B?NzRoQ01mbFZDbHNSdWtxY29NREpsSG1HTXFLM28ybG1FK2R6ZEVuQnlFTld5?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QcFN9LMdEmmydu10cdwizk2LkQokxzHYtsOFclJ3zEuiRAPWR3uMEFzLedBDkdasQ1TAAgJvqJKcdu62lryFn9yayLa7S+8bG7e7yTCVrnzM2u2MX4jvmA/RGQzX5eG9LnP7Asbjz526a5j1R7AfottGrQl7GXM/8ho+tGRUdm8rIQTeZbp4tUtj6LIdj/R9UYi5VdikyaHnZZB+54DWG3V31V5XkBUdaPwxGBub6Ig+HsVZbBgCjzDnoeYGAsEx0Zj+mHCyjb2y2/kPDvOVk8h5ygMjQddgXHnBEmmt6O+cZYi7VfuawK98VZ4Nwslfa2kyyoDJZAquYofRbxlo1dNC37HF2VTk8fIIrKy/BYuBQGuBacRQbarI2xezW8j7JEeVQQVO4NeAUcAD3ZUEoMbfMEJnsVTf5iOmyDvapFUi/mKHloWDWTYbOTZzxu/TQOXFtGYg93N2bH47tcOhlGFJwWzcK04glSAoVEd40pLcTIcTtIAODE7J0YQaz/pSnHy+KUYcKo3n4kBKngF7Qf4ZXbNkoRqBNeEl3mcvsn21YtVdnwihnzy7BldKNbf5klRGIeeGJgIXbO4vyesADx1Dnp+i3vuTUPZdh2gl7rI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3119b7e5-7edc-4a40-dad9-08dcad79716c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 13:47:08.6874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9WktP/KCk0ZAplagCdpw7HiFM1PP9MfUZiY0wGlMa550HF/9bW1vSY58dwlMhYQvtHvTIIKseTNuof4bbwhQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8082
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_11,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407260093
X-Proofpoint-GUID: BhM3Fl-TdcpvieF4VCMcfhwhdGF-EFyx
X-Proofpoint-ORIG-GUID: BhM3Fl-TdcpvieF4VCMcfhwhdGF-EFyx

On Thu, Jul 25, 2024 at 09:51:11AM -0400, Olga Kornievskaia wrote:
> On Wed, Jul 24, 2024 at 5:43 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> >
> >
> > On 24/07/2024 22:12, Olga Kornievskaia wrote:
> > > On Wed, Jul 24, 2024 at 1:06 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> > >> Adding Olga for her review and comments.
> > >>
> > >> On Wed, Jul 24, 2024 at 10:01:37AM -0700, Sagi Grimberg wrote:
> > >>> Move the stateid handling to nfsd4_copy_notify, if nfs4_preprocess_stateid_op
> > >>> did not produce an output stateid, error out.
> > >>>
> > >>> Copy notify specifically does not permit the use of special stateids,
> > >>> so enforce that outside generic stateid pre-processing.
> > > I dont see how this patch is accomplishing this. As far as I can tell
> > > (just by looking at the code without actually testing it) instead it
> > > does exactly the opposite.
> >
> > I haven't tested this either, does pynfs have a test for it?
> >
> > >
> > >>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > >>> ---
> > >>>   fs/nfsd/nfs4proc.c  | 4 +++-
> > >>>   fs/nfsd/nfs4state.c | 6 +-----
> > >>>   2 files changed, 4 insertions(+), 6 deletions(-)
> > >>>
> > >>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > >>> index 46bd20fe5c0f..7b70309ad8fb 100644
> > >>> --- a/fs/nfsd/nfs4proc.c
> > >>> +++ b/fs/nfsd/nfs4proc.c
> > >>> @@ -1942,7 +1942,7 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >>>        struct nfsd4_copy_notify *cn = &u->copy_notify;
> > >>>        __be32 status;
> > >>>        struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> > >>> -     struct nfs4_stid *stid;
> > >>> +     struct nfs4_stid *stid = NULL;
> > >>>        struct nfs4_cpntf_state *cps;
> > >>>        struct nfs4_client *clp = cstate->clp;
> > >>>
> > >>> @@ -1951,6 +1951,8 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >>>                                        &stid);
> > >>>        if (status)
> > >>>                return status;
> > >>> +     if (!stid)
> > >>> +             return nfserr_bad_stateid;
> > >>>
> > >>>        cn->cpn_lease_time.tv_sec = nn->nfsd4_lease;
> > >>>        cn->cpn_lease_time.tv_nsec = 0;
> > >>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > >>> index 69d576b19eb6..dc61a8adfcd4 100644
> > >>> --- a/fs/nfsd/nfs4state.c
> > >>> +++ b/fs/nfsd/nfs4state.c
> > >>> @@ -7020,11 +7020,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
> > >>>                *nfp = NULL;
> > >>>
> > >>>        if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
> > >>> -             if (cstid)
> > >>> -                     status = nfserr_bad_stateid;
> > >>> -             else
> > >>> -                     status = check_special_stateids(net, fhp, stateid,
> > >>> -                                                                     flags);
> > > This code was put in by Bruce in commit ("nfsd: fix crash on
> > > COPY_NOTIFY with special stateid"). Its intentions were to make sure
> > > that IF COPY_NOTFY was sent with a special state it, then the server
> > > would produce an error (in this case bad_stateid). Only from
> > > copy_notify do we call nfs4_preproces_stateid_op() with a non-null
> > > cstid. This above logic is needed here as far as I can tell.
> >
> > So the purpose was now special stateids will not generate an output
> > stateid, which COPY_NOTIFY now checks, and fails locally in this case.
> 
> Ok I see it now I do agree with the nfsd4_copy_notify() changes it
> should be still guard against the use of special stateid.
> 
> > Maybe I'm missing something, but my assumption is that if a client
> > sends a COPY_NOTIFY with a special stateid, it will still error out with
> > bad stateid (due to the change in nfsd4_copy_notify...\
> 
> I agree now. Thank you for the explanation. Looks good.

Hi Olga, may I add a Reviewed-by: from you?

-- 
Chuck Lever

