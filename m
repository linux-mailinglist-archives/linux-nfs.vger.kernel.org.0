Return-Path: <linux-nfs+bounces-13882-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958A3B344F6
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 17:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7A65E5BF6
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 15:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E199C2FDC35;
	Mon, 25 Aug 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OzMEs6vd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BXxqNpzR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186902FB988
	for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133922; cv=fail; b=gW/YWYxr+wDF5ENiYX8McPFP8+1S1HyBT6xg9Z4oGIdBOYY7oL76CgHuFIMOHqrQsn2rhbRgGrT31pzf1sIzPdezBCmV9SNvUMojLLg01rrgeLrv/LtaDzT/IHyLKGAc/tWIpdYOPmI2se51U7XuO8juO0e5LiAi88ziZEt9jPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133922; c=relaxed/simple;
	bh=w6ICee4GUuTwIO4HxT1a/2IIarF3bJFgQwJWoP11bTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yh9ih+gGsd/MeY9befO9BLUV7HVHO1qPNONTNx5KKTy6zh0jcK1BqXo9jFTTm2edXRShpRWn4NNxshIcsHb6dXeI8066bioLwVS04JDuOHjgGnlu7oSP1W7mD//jQc6mVtHkyNBMiZkUD9JTdhOdk9VDpa4wd5DoC56deROIkXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OzMEs6vd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BXxqNpzR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PEWpGP030690;
	Mon, 25 Aug 2025 14:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=p+XDx8xcjYIRuR8eGu+UdX6HyI0Gn82ayAr5Yn76xds=; b=
	OzMEs6vds/yG3gHqZOyQqfFMbVyCp2CTdrk9M+dNSdtj2Hpx605ln8OQ4ZUTBdOH
	AlKR+x9nXTzLr8FB19th9ivDdE3zxx0qm1emUAn6EyECoYMxGCzKIwKEPQ94L5Yz
	EvTaI3ZLYmNQd6p+PoQ5wAUekVKV3BqEZpPKQQ6RVRa6ge9XNmeIMPCUe6zNCR/N
	e3z8X2j+YTklyZKTB9dWjuMmW2TVQuijKxjYnK+dRDQUxIYN3SoaiXJuv44ny8KL
	6D3AKV7bpXb6ZEEtsm2uxde+Xt2Lhgq54/ipAz2k4RnpRZ7ZiT30JyggNJjPE0rg
	Ph5I+WnC4mGtHNzJr59Rkg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q678tepb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 14:58:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57PEXSrc005224;
	Mon, 25 Aug 2025 14:58:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q438h96b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 14:58:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRQgQegyuOZwgTR5vVf6SD3bP7bUN9uGQgorWvjulppofWE9zqzkXcNLt9YiUx+dKeiukWtObg8uYPuf/Sh/wNA7PT0mcNTYl+90u8PfCGyQ/K0XgeP4tcouOeR3shWxARnOCEIK2H9cBH5zS2D0ks2GSE/5W+byE4xcmU1wbGyqQe+Lk5Z4FPk3snfLjrgugFQUfYCEOSjZZgMUBJ1J1MAMHkZREVBSZb7mpUJGqv3Ym9fDlvisivIBInZHtmgiJCqoxRol/FaupIG8wE6tuWRXZWNfEdC3VTUWuMP3fkLTv2ADvi1G98XvZjWckI6hCAkwM3xm4xPo1Uq0GS3upg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+XDx8xcjYIRuR8eGu+UdX6HyI0Gn82ayAr5Yn76xds=;
 b=vaw2dyL9VpfTmZ6xZ08RVsEzGJkGu7PNJbyCC8beKuctHXFTVuceensc1jnyz9hRcKiRueNnGFZwUzB2EQvxq0sMcRtD57RjBimui70j++RUVT0hTCwI7ct2fjw27IDtHQH3dXohQTMp04G5cLnHcrblAu+np4ZwIM9VJIlCHD9UPVx4mu+5BG+ehteagAVS5q/NLay5DLR23/aCclHoN7C2by2id8h1evdfX/8ONcwxHM0VcGV9saXLx1YGlKsLoJqDi2/lpov/D0+NN6wM+THx7KQ7qx8fCWCZlUvDIY6QgD3Dl1tBzkEKCddWCqixqvg/W7yx2qXvPMx7JSxWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+XDx8xcjYIRuR8eGu+UdX6HyI0Gn82ayAr5Yn76xds=;
 b=BXxqNpzRxOpxlP2TVk1KCQvDTHZNbGy7+yfd2dwYFMkt8oppLoVt1+XpOVWDa/RBQvD9xsE6t1Xe6hKmxTFOLi+jNTlwUM2wpILScEniJV4pmoU87pFi8p8473+NpQ0pMuFvZliLYg8sPbZWTp2mcBOLt+JniDhvXJR9F4QVLoE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7596.namprd10.prod.outlook.com (2603:10b6:806:389::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 14:58:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 14:58:25 +0000
Message-ID: <a86eeac8-2c00-4f34-a582-196cfce8fe37@oracle.com>
Date: Mon, 25 Aug 2025 10:58:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] nfsd: delay re-registering of listeners after
 listener removal
To: NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
References: <20250821204328.89218-1-okorniev@redhat.com>
 <ab55513a-fff0-4907-98f7-716df23a1bb9@oracle.com>
 <175599312545.2234665.14336815607780207352@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <175599312545.2234665.14336815607780207352@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:610:38::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 14354b45-d9a5-4dd9-6cc9-08dde3e7d7e3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?djF6QnZHR1ZTdVVOcWpkMlNTRVMrYzRUUUo5ZzJJZHN2ZDMwRkVDVS9VQStE?=
 =?utf-8?B?M1dWOHdOcFp6MGl6Y3VCNllXaXdKV1l5c3owZnlqSjMydEl1MkJrR1hGUi9T?=
 =?utf-8?B?RnpCbDZoZm9lbW1waFczcWgwUGQyN2ZSVE81V2dQS1FaTFZSQjJmQlJZLzNl?=
 =?utf-8?B?OEJSS0UyNVdFdW91bGZneUxtSys2NFgrcFpKajNsMXRnN04zZGdvY1pmcWx3?=
 =?utf-8?B?dnZvTzhGeVp4R0lRVERYczl4OERUdUJQdmNDV0EvWGJLTEdOWldWemRSM0tq?=
 =?utf-8?B?WTZSb08wSmNydlRMZTNlUS83Rms4MUNTalhNRnFBN0xVZ0tqVTM5U1BVdUFz?=
 =?utf-8?B?eGRKQWgwTWZSS3FlVTdnSDFuQjRKS2hUUHdockhMYUtSc0ZENkVYa2k3dCtJ?=
 =?utf-8?B?T0NSdDBYa0wrSTF3OHRQZDljcWlPTzYrRGxyOStZc1p6TEw2cjZOZ21KWlpL?=
 =?utf-8?B?OE50ZHY0OHI0WGdPWEFHRE5pN1pFcnpKcnNYUnd2TDQ2azlWTXFXdUV5Wk9x?=
 =?utf-8?B?WWZtTVQxTG9OclM2UFpzTzhranNsdTlaVzBxSzZ1bGNZLzBkdldpOWU0U2dY?=
 =?utf-8?B?OEtCWDRFa0RHeTR2ZUc0bXhWUHNxdW41bFhjRk1JeHViZzNIK2I5RDgyc2ZC?=
 =?utf-8?B?dHdEbjBsRW1lZTdlbi8yeFE1dVRyWXp0U05BVk5PT1g2RG10bVVHeTBBQkdP?=
 =?utf-8?B?NkgxYk00ZHhPQmVZUitRb0xyeVJOVTVrNER0QlNaRUZsYUd0L2wyMXlRUWpU?=
 =?utf-8?B?WkpyTGhXaFpPdFVjem1STjRaSzlVYnNTbmpnYWs0bzQxd3cvRE5BaHNpMmRv?=
 =?utf-8?B?SVhyZ2NzNjMvL3l0R2gzRDl6YzFSTDQ4Sm9NRWJ1ZVpOdmVvZVA5c1hlbVNy?=
 =?utf-8?B?YjcwNlZITzhXcVJaak5qMHdLSnllZkRwYktrOFp3cExSaGJwUEhKL1dncjlQ?=
 =?utf-8?B?WHhvSlFmMmxpVXhnT29zeHprU2RzUTUwY2lnQUk1d2N3S1duZWN2NXVWc3R5?=
 =?utf-8?B?UStXV0QwVVE3K2VRNXhZNCtYWGZ3R1MzVGc3cEhEMTlBbTNhQkRhcVRNeWlB?=
 =?utf-8?B?RVlBUEFQSmFnWUdUaWF1RGp0eE50WTZBWUVCc25tT3p4ME42cU83M3c2Tk5B?=
 =?utf-8?B?bTV5UXV3UVhGUUJ2aUxtZWlnL2dGYTRXZ3hleWhIeXl0TVd2eGpzUXhsRHpy?=
 =?utf-8?B?THN2cnQ3WFVBM0tLNkFHdXY5VTIyYS94dUhQMGUvVGRZdlBpV2taWVpZVloz?=
 =?utf-8?B?WThTRnRFNG1qc2N6ZUZkbGpQUk94alI3THFiSjh0VTN6a3BoS0RIS1hqZTVu?=
 =?utf-8?B?R1UzN1VIVDdXY1k2cDhxMjY4Q3IvUldST3ZMZ3FOQSt4TGZYSno4SU9FVWNt?=
 =?utf-8?B?SW1RTlkyandBRTkvMW80QXlUTkJGb250S1BuVnkxMm10YXFieTUycmk1eWM2?=
 =?utf-8?B?RENpWnlQbW9JTFNSSHpFUnlHaUpOOTA5dm5jcXpJZGpZZlBreXNxWlVKWjFq?=
 =?utf-8?B?RHI1U0pYcXVjaVVvaUI4YUlHTzBKOHE5SW1UUE9MZzF2Zkc1OGlac0RCVFRa?=
 =?utf-8?B?UTlUcTNDbUlCVlNDWHJsT1RQYmp2UEFxcnE4bWdkNFlESlo4NWxwUkJHeVFB?=
 =?utf-8?B?bHBQMlJ1dm1mNk1sNXNCNmlYTkZDUTVUY0Z5TFhXVlNVa3RwamRUVjVIYm8v?=
 =?utf-8?B?QU13clUzL1VjTzBZUndRWjNNYW93TVBQTFFLMlNhM2tXWWZlOEtMdDFVdnI4?=
 =?utf-8?B?dVRuL1NadWw2emZlNHJLVHpUOXgwaXdscS9vdGdQb01xaGlHQnNHL3NlbGdG?=
 =?utf-8?B?VWF2WG5YNXFOT1o0bnMxcnBpaDRFVkN4Q2RIWTNmS295L3dCQ1Vydk1FdjhL?=
 =?utf-8?B?MWhCZDJpL0RRVXNFVGQvMGUzbDUyWlN1QitRbGZaS0h2SmU1K21RZExMOThQ?=
 =?utf-8?Q?qNKYomxDXOQ=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SnNjempZMjE5S2IyMHNFSy9JS29mYWM5MlpMamdTS1JqYkhDZmpBS2ZBY0pO?=
 =?utf-8?B?eTErZFpKaTl2U1A1MVovRHlRNkVDN3YrcndNTUdXc1N4RDQ0MDIvOHVFbndr?=
 =?utf-8?B?bmFnc1k2Mi9GNmNZN1FKeUVsUW9aTGVsOC9XTHowbU9iTVNxdExHNy9jS0x5?=
 =?utf-8?B?S2pEcEwwSk9sT051dk1uTWF6eHhYZWdLdEhQWVNSZDJjYy83TmdVcmdnajJn?=
 =?utf-8?B?dHh0Um54RjN5VVpONUErT1RaWGYwYVFWWGVBaXJqQ1hraGN1dVZVU1BkNFM4?=
 =?utf-8?B?Wjh3Y215UTFxSTFLSWQ5eTc2N011VjFvSHNwdGZwY00rQVJKY1BTdU1lVG9v?=
 =?utf-8?B?MzE1NWYwTlBLUFZkRk92R2dyakhmb0dEckRabFBQVWVvbktSQVNFQUJpQlor?=
 =?utf-8?B?SERDSUFSenVIcjlkbTlqNjRUMEhrWjZJdG4rbkNNbkIzR0kraU5rSnZTQ3Q4?=
 =?utf-8?B?SlBqWGtGY3N5UmlQUjdaTmJNTDJvUFhCZkltbVhKbmU1OE1JMnBOS0ZjRlg3?=
 =?utf-8?B?SlBKRk5odlZNSlNaL0JuWEQ4d3o4U2kyVlI1eE9MdG5hb1lGTjNZNkd0WE9z?=
 =?utf-8?B?cjBWeWp4MVdHdVRjdU54aDlJZjZTWU4yVVVGcjRvRnhsMUFJQ0sxbkRMRFFn?=
 =?utf-8?B?Y1ZtRmhnRzZlQXZNd0RRdGVidHJjZk1KQXBsdlMrTWZaQjZKcTRBNjNZNHdO?=
 =?utf-8?B?dDMzeEptWmpPeU4zckIwRVBqaDV3OTZ5cjYyVGlCdmJ0YXVVdjA0Y2p1anJo?=
 =?utf-8?B?Vk55YXMrWUhzZGY4ZFcwa29xMUJEL250RzhSNjZ6ZEpwK3ZJL1o0NXNyNXUy?=
 =?utf-8?B?bTlVK0c0ZURFSC9aY2VTeUQ5dGdIWE5HZk0wakZIWnhqU0ZjZ2tyVHl4L3d0?=
 =?utf-8?B?S0xFQmJCSXMzcG1iM2l4c0R4V0RBMXNPYUxPYmFiQldTb1UzVElVbm9uNmVE?=
 =?utf-8?B?UUR3cElYOSt4VlRjYXBLYVRqUmcvVWZWbHo4SjJLaHRjZ1Z2bDJrNnVUZkZp?=
 =?utf-8?B?WUxCR3liWmlJa29rUmQ0YmkreGRrTFZNNzk3bWxEWDJmZEJtNzUvOWc4UlQ5?=
 =?utf-8?B?RkF5NmdwdXVtQXpFR0ljTWpJemdpTFYzSHJtVU1SOGExZk05WmhwUlJ3QjV3?=
 =?utf-8?B?dWdIZ3V0dU1ic1ZWTTFZUHJkYVFxNTZ2T3Nxelp1THVGUjVGNFJBSkgvZWRN?=
 =?utf-8?B?MllLMHBwKytZVjFrZVZ2WTlUSmFKcFduVWxaQlNYS2NpRldGdEp3VlZhd25X?=
 =?utf-8?B?SEN1RjdGQno5VDVXVlFWQmt5MGRPODZ0M052c0IxNVFSR2FTa29GMm9wTDVV?=
 =?utf-8?B?MEhxYTF6ZUtoVWtsY2JvN0ZHN2N0Z1FycWdxVTExT3hVc1VpckFlcmROSGdy?=
 =?utf-8?B?R05nd1QvT1lKbGQyV1BaVUJKK2hGZ1o3aVR6OTlLWW5VUXBZVG9JaGMvbU41?=
 =?utf-8?B?N21VUDZsWk9TMGhOZVk0V1RrUHo4eHR0R1ptMlpvcjMxSkQ3bGIvc3pibVU3?=
 =?utf-8?B?U043Qnc3bGh5anVvQWZNbDB5Qld6RmpIWnFmcEhkTGZWbHVzVGpyMzFUSU1m?=
 =?utf-8?B?UUF3YU1nRDhCVU9VZytrcTNCRUMrd1RKSGQ0S1I0SGpoQ09pNytSN2xhQnZ4?=
 =?utf-8?B?YWRtOW9zVHVUVlpCenVJcnNWbkl4YzZJRkV6Y0tGRmhiS0VOcFB5eWNkcGxL?=
 =?utf-8?B?NHdaMGNmSzBsejdjVHk0UGlYZVV3QWwzbWU3d2lhc3IrWXhSN2VLZjQraWYy?=
 =?utf-8?B?RDF4YXZxM09kYUtrV2xCYk50eDNSU25nWi81YUVLb1d5OUo5Z3FvRGFzTEZi?=
 =?utf-8?B?WHlHVUwxL0tRdFpRam82VFNtdHZHUWdicTFoaVNxdFlYc3ZaOStZNjdKK21y?=
 =?utf-8?B?SnlBQURDQkF5bzJWV1M2RnhMVUNBaHZwOVJ4SklWVTRLM04rTXNlQjNMSzZC?=
 =?utf-8?B?akN6NCs1NER4RzRGaCtpbzlaOVVSSUNLSFdYbGxZdnBoaHpSc3hyajVxMndN?=
 =?utf-8?B?MUZkbEkwMHl2bzJENGhrWC92YTN0eEljeUo5NEhWK0VTcHJpNTJGcXNYbXc0?=
 =?utf-8?B?WDFKbFlBVlRFcmVibUtDcHRlRlo5bXN5UkNPTkhYZ1JvVzZQdW04SUdFeTRC?=
 =?utf-8?B?YkM5SmhqdnlVMm5ySWZRc2ZhNHJ0K2NpNyt2VFJEcWwwdlVaVWdHbVJaRFVs?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xX44p2yDk7kMBWSi5wfKfIQcd0w77e0PD2o9xwY78aTln8JqW77pLFlek0tdHzJIGSifmM+9NaG5voQlgdYQDI/8x92FwfgH9KVJdIneUzOpKSdaQURnQ72OSFQPlq7sxt5vxGqskS1UxO9Jirpde784MuksZIeRieqlk21lYT0+kuonsBgL95sJeIMX3p59/aEud5kHa+wE/jecbIcTgYobVeSzM4qt11TF5Eshk4oTO0TQ2BKjnsBcABB2X0fsReytUpA4lZ+eTw8EQU3b4DLtgHnv1Emd7eIulXDSgaU1jikxHw0VYFnkMqN62ksr20/r0hHKFMQBhKBoVkxAUa0A9TtWMfGfJUTehmI5HytOPKMJhpjoOXO9e8xJxXdfetxn/4mk8nNgf8HJKV0PCV65fBIOdkmCyVTCFwZeD76Jn2eduzEgOAjSyQcOnrqxfw6GlezM7PFj/ZN7opEwpoPyCb1bEDGuaN4TH5b7FbfsBp6O2192H6UVf5Cj5cciZAErKtg8D5JHC6LOpcZ0PORNdWRiymNBEPcZrQ9yJe2muUNGo7Kq3LidqQS8Hu2LN2R8G6m0+WwWi+xicZfSgLYFDl+qIQZb6c+fraYImXQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14354b45-d9a5-4dd9-6cc9-08dde3e7d7e3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:58:25.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsQfwoPEzS/g3HDtLdn7zI54TVfYK2VX2rnEb3AWwJO4ep6QfaCFJ/QH5C7THETJgXELpjEq93svCS35XSgivg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508250136
X-Proofpoint-GUID: lNryzy5WzlKG8_hiDYkJwRhJUUxUzhpm
X-Proofpoint-ORIG-GUID: lNryzy5WzlKG8_hiDYkJwRhJUUxUzhpm
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68ac7a19 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yeDn6MD7EJJ9rmbUO60A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfX0y8XVWknXedr
 pYEgBZSZ1AiaOJNd0JhlewZFRnj9N1Th4AsbQF2PKlSSM0Qg2TUb3of19oURIXu2mPdjv7zaWMS
 GEa562aimXYR8oU8Weg7Oabl9N2PMbFLhy3IWJ8g/T8ry5gnMtGFDG+wI9j+2MKpekfvx9PLguS
 N1zxU59gwQ4aoLW0lmi9jfDEmHzQLYykCvEE6CU0Wi9IrZKCY8ehaNetr6TcFgCXDZg2pE0f9Df
 zNscZP9TvUkC0BtZvwOeWttmd4I4W5fbv27h0ZyZDV/w0EsKHrKf18rBNiv8YNntTDzrzAnCe2C
 79/2k1vTpC+ZZRCjlfh0u/r2bKbpxqLqHDV4suLQKKTKGTfS/iZwX+0dW9moyZy/PHU5fKeyZ98
 X1sxufAf

On 8/23/25 7:52 PM, NeilBrown wrote:
> On Fri, 22 Aug 2025, Chuck Lever wrote:
>> On 8/21/25 4:43 PM, Olga Kornievskaia wrote:
>>> This patch tries to address the following failure:
>>> nfsdctl threads 0
>>> nfsdctl listener +rdma::20049
>>> nfsdctl listener +tcp::2049
>>> nfsdctl listener -tcp::2049
>>> nfsdctl: Error: Cannot assign requested address
>>>
>>> The reason for the failure is due to the fact that socket cleanup only
>>> happens in __svc_rdma_free() which is a deferred work triggers when an
>>> rdma transport is destroyed. To remove a listener nfsdctl is forced to
>>> first remove all transports via svc_xprt_destroy_all() and then re-add
>>> the ones that are left. Due to the fact that there isn't a way to
>>> delete a particular entry from a list where permanent sockets are
>>> stored.
>>
>> The issue is specifically with llist, which does not permit the
>> deletion of any entry other than the first on the list.
> 
> That is true but not really relevant.
> We can remove everything, walk the resulting list removing individual
> things, an requeue everything we didn't want to remove.
> This is exactly what svc_clean_up_xprts() does.

The semantics of svc_xprt_destroy_all() is to actually destroy all
transports, not just dequeue them. It targets both listeners and active
connections.

Couldn't that result in unwanted disruption of NFS client activity if
the NFS server still has threads and other listeners?

We want to be able to remove an arbitrary listener (and I will include
the UDP socket in this) while the NFS server is still operational. The
goal is maintaining server availability while enabling administrators to
adjust the server's network configuration.

I'm wondering why we can't use a simpler mechanism here such as simply
calling svc_xprt_deferred_close() on a specific xprt, after having
provided a reliable facility to wait for an individual transport to shut
down.

svc_xprt_destroy_all() seems appropriate for full server shutdown, but
it doesn't align well with deleting a single listener.


> To remove a signle xprt We just need to set XPT_CLOSE, call
> svc_delete_xprt() then run svc_clean_up_xprts().

svc_clean_up_xprts() already sets XPT_CLOSE and calls svc_delete_xprt().
I think you are suggesting a new API that does what svc_clean_up_xprts()
does, but only to a single specific xprt.

Is there also some expectation that, on return from
svc_xprt_destroy_all(), the doomed xprt is fully gone? If that is the
case, the API contract for svc_xprt_destroy_all() should state that it
is indeed a synchronous call that returns only when all transports
associated with { @serv, @net } have been released.

And in that case, the RDMA transport has always been a lingerer. We have
never noticed it because svc_xprt_destroy_all() is currently done only
on full server shutdown.


> I think svc_clean_up_xprts() should call svc_pool_wake_idle_thread()
> after lwq_enqueue_batch() in case one of the xprts that we kept became
> ready while it was temporarily not on the queue.

> Thanks,
> NeilBrown
> 
>>
>>
>>> Going back to the deferred work done in __svc_rdma_free(), the
>>> work might not get to run before nfsd_nl_listener_set_doit() creates
>>> the new transports. As a result, it finds that something is still
>>> listening of the rdma port and rdma_bind_addr() fails.
>>>
>>> Proposed solution is to add a delay after svc_xprt_destroy_all() to
>>> allow for the deferred work to run.
>>>
>>> --- Is the chosen value of 1s enough to ensure socket goes away?
>>> I can't guarantee that.
>>
>> Adding a sleep and hoping it works is ... not a proper fix. The
>> msleep() in svc_xprt_destroy_all() is part of a polling loop,
>> and it is only waiting for the xprt lists to become empty. You're
>> not polling here (ie, checking for completion before sleeping).
>>
>>
>>> --- Alternatives that i can think of:
>>> (1) to go back to listener removal approach that added removal of
>>> entry to the llist api. That would not require a removal of all
>>> transport causing this problem to occur. Earlier it was preferred
>>> not to change llist api.
>>> (2) some method of checking that all deferred work occuring in
>>> svc_xprt_destroy_all() completed.
>>
>> Jeff (and perhaps Lorenzo) need to go back to the original reasons why
>> this was done and rework it. I think we were avoiding holding the
>> nfsd mutex in here?
>>
>> Complete shutdown of a transport always involve some deferred
>> activity, and there's a reference count involved as well. I can't
>> see how the current destroy/re-insert mechanism can be made reliable.
>>
>>
>>> Fixes: d093c90892607 ("nfsd: fix management of listener transports")
>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>> ---
>>>  fs/nfsd/nfsctl.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index dd3267b4c203..f9f5670abcc3 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -1998,8 +1998,10 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>  	 * Since we can't delete an arbitrary llist entry, destroy the
>>>  	 * remaining listeners and recreate the list.
>>>  	 */
>>> -	if (delete)
>>> +	if (delete) {
>>>  		svc_xprt_destroy_all(serv, net, false);
>>> +		ssleep(1);
>>> +	}
>>>  
>>>  	/* walk list of addrs again, open any that still don't exist */
>>>  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>>
>>
>> -- 
>> Chuck Lever
>>
> 


-- 
Chuck Lever

