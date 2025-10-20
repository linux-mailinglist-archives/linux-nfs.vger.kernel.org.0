Return-Path: <linux-nfs+bounces-15422-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59056BF3120
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 20:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79AF18C0759
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 18:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69A02620FC;
	Mon, 20 Oct 2025 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kt+ydN4i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="va4TPYjm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3AC4414;
	Mon, 20 Oct 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986700; cv=fail; b=BT1I9yCpr7m3B/RI1EtdkglxtlLEOXZ3UFjNbJSttRrGOz3DS4EHp5zdWyUqVHZw2HVVc9Yx19AxNmEDmsvZSOfNc7cjqeCt9KAavRS+cPgpoMPIUKO0ygPkjHQpb2BNQjnqhuP3eT58PGwKegOqt3/aagrdZjnjAugu7t0QHpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986700; c=relaxed/simple;
	bh=Jd1ox6F1yQMsSzcw1pucPnCjlSOygdktuqiFZ4EFWpk=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=G7aaXvqWhsDDuNQ5bPvUsSV//IPMg87zaZbYDxQXiXhdMdYdOFcVsiIG887mUNv7T52gqMIa1bncpG7aWY8nFLOYyApSDtwWBRa66FT3a10eRtQcZg8/4TvwJzJh//xirL9n8zyKc9Y8MX4d8yiiXWSSMJFTJJroWeKRu0QtWzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kt+ydN4i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=va4TPYjm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KFkAoo031786;
	Mon, 20 Oct 2025 18:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=PhC+VcJxzdblnQrR
	egZdtSaaJ6Crz/VZje2/ZX1pMPo=; b=Kt+ydN4iitdLq895aPqEM0bDZjydZQA5
	P2rsLNlW9hSvBBRGyDoiBKe8Zfbk6JQ6dnM6hADH1hvVh3yUD+iHvUbkGAVDaWew
	ET6ZQLNAMCYq7S2XqRdh+f/qA9JLG0y7v1wTDYgeZPCu4V1Y7dctpCMW7lxXnYx4
	E+gRB8enjI5TWlf520WEBX2LwMoRiUrjm2KyueUPUiQV77vwGxUHx8rHxYEf8S1s
	ECtIhWWdaJQrtDzJvBARZx03ViUMPJIkh1HevXpMLRcNxiTfxCmny/zy5H93xlcQ
	szhLjKa4RdK4Ss4fFP0gKw8mICyp9Q1zPfvE1/jhTBtFWOFpjsWhQg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v31d2xkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 18:58:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KHT56S009516;
	Mon, 20 Oct 2025 18:58:07 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bc9a6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 18:58:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qA5wEpJZ4E+oySva7Yy9Czmv8ihOUCLyJqFUn2/B+yz6mb5YnIBfmepFTgWk6CXkzxWFGQb2qlnBcenoaBPFV8168sS3ZUbegSFmiQ35cZ4lrr5J7uU1BrEpTzBNqiZDl1aoSFrFW78kA0KFM5IOimsXX99SrD6nenHAhf8a7x0tuWwiaR+swfLzKkMvtjF1a0xyFQAGl5Bwh0aSKN9NF7PKrwrofSA6mg1q325V4hvpg17Lyu8dvSoVr8405Vysm+WjPBOKajaTT9c7DdTeHgFLGsIMSOCY6rnirTd+GixameYiFc1k8z8Hf+LM3tFr0GznwTR933SUt7FC7LSwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhC+VcJxzdblnQrRegZdtSaaJ6Crz/VZje2/ZX1pMPo=;
 b=XUh7YJFvB1HPEtTkoo3AS2Mh9iekhnlGI/SKYj4PqR4RNxqQvDgmiXYeOixvY+LlN58+3HCKkEntkVZhroFCk4B+5xx3DPnDxp/dbIsWyJtYGGHBY0kn9SMcvDybj9mQzuQHVk25SltF/INPw3N886dR+2TKwvISJogODkFqjw+Nar+r6y2kdNXOKU/jaTrcCXAnSE/BrtsL9xOuiWKWtPQMuaIJL9Z8hwOcoIyX24m7nSITJCFbG5m4QUU2Gm9iB7SEcuCCDj0GtzJej4NP5CkXEMv1S5rqu7nzXC9tGta8cHxZxnB1rhFdLZvmoPJn+QqJlIflXRzji5cdyUaTOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhC+VcJxzdblnQrRegZdtSaaJ6Crz/VZje2/ZX1pMPo=;
 b=va4TPYjmwiqQp7NbEgDEjPulTZp3tJXAbkyJxqOGly+Y0H3tIqrUCiO5P89Ics4LXkYVlA/yLLDX2siBMD8c88hrwb/tTWNdyugFVsN5RS6VkCAiZeLjp2IaGiMtInITAcSi/FmxkZicC/4uRcPTdD8qE8VI7pe2KlkYVGrGkEU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7189.namprd10.prod.outlook.com (2603:10b6:8:ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 18:58:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Mon, 20 Oct 2025
 18:58:04 +0000
Message-ID: <ff56ddac-f08b-4f42-ac25-4a5015d9b1e5@oracle.com>
Date: Mon, 20 Oct 2025 14:58:02 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-nvme@lists.infradead.org
From: Chuck Lever <chuck.lever@oracle.com>
Subject: [ANNOUNCE] ktls 1.3.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:610:cc::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: e46d2ac0-85da-4b73-c318-08de100a994b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHljNnFBMnVXdEd5VEtPNGxsQWNScW9id2xhR3dlNkdBcjR4dVVoTUU2MVVP?=
 =?utf-8?B?MWpPanFvamYxUk9WUXVybDRVMm56dThzUVdiRkx2Q3ZGbVZPOFk1ejBTNlZp?=
 =?utf-8?B?RmZkaFIyNWJ2RlpVenRIbUtSK0NrTVZmd0ZWVlFpdjhQRUpoZVhzWkg5ZFVo?=
 =?utf-8?B?QzE5ZXRhb28wOUxMRVFuSGU4NW5VSHF0TTZZdTVlTHZkRGNEME8xVXFqRU5M?=
 =?utf-8?B?MENKQkFBWkEyNmxwanRXM2k4VnR3cmZTMy90NVBJS1lRcVNIVmlUQ2lCUzdR?=
 =?utf-8?B?VUN2YnlLYVZLbmtMckhFTCtQVG93YnRZc3F6ZFgwRmtjdWRNMnlVVW9MUVUz?=
 =?utf-8?B?cEF2MmdYNzRMVTJBY0ZEVWVNc3Ryc2Fxbkw3NFZXd29IYnZ0Ynl4dG5naHhE?=
 =?utf-8?B?aDFDd2NVZUxOdENhMVQxdk1EaG1ES3k5V2I0bjhzeXkxM1ZUYVBOc2dkUkw5?=
 =?utf-8?B?TE9qYUQ3eWVsMC9KUWpoREtBQmorWm1ROXhmMWRUeC9Ra3h0RENCUENHSUU2?=
 =?utf-8?B?bzR4RHYxL0FGRW1TWW9GVTBESnc3UFhSU3BNbHg3UVgvVnhJNWFPdXQyK1VI?=
 =?utf-8?B?dDg3TDF0aUFoRjFOWmg5SCtXcVVLWUdkOEFoTEFJcmVjb3dKZ3oxcjBzRWxv?=
 =?utf-8?B?d1JkRlIvVGk4UWpPSGlXbFpyVGxnS0liYnUvZGlhSFVTcjB4L0xCL0hSNXdJ?=
 =?utf-8?B?a01WV3pHS1VyUXoxTExjVU1Ya21DZjNhOGh3V05HNlJYNWtQeUZRd2I0U0JX?=
 =?utf-8?B?Umc3NEZEMllBMjRES2h1MTZhOWxHRG1YVHFqQ3RUdm9xYkNySEQ2L3RyU2FF?=
 =?utf-8?B?MlVkdlpEekpmMFRpYmtIZHJqNCsxVW1NeDJHMktFV2dyZk9PTWtGTEdlSERI?=
 =?utf-8?B?eVhIMk5VdmdlNjM2MklTbFUyVzd6cnNVVTBBMjN5SEthMlI4MFZ6V3MzVXhG?=
 =?utf-8?B?WmI4UVE3YzdhUzl4cEdOMDZLK2tLRjNQKzFPdFNKcUtGbXpZdUZFdjJieDgr?=
 =?utf-8?B?bDZ6c0VUSjRCTzBVUDhOajRndy9jMWhWM0FheVdpendRWkdtNFJQRVh0VXl2?=
 =?utf-8?B?U2gvOGhreFVMWDIxK3UydkdQRlJHRUxTbnJUYjh1Rmh2Vjkrd1pObWNkM2ZR?=
 =?utf-8?B?dGRmT25Cd0YzTEVyUlVwZ3Ricjd3UEpyLzduNDJNMWZyQmwwNnJqMXpUTkJi?=
 =?utf-8?B?a25kcjRaeHRKM0lLR2Q5UmZudENNaEFmc002R3lVRks2Y0wvNVZTdjdLeFUr?=
 =?utf-8?B?WTJFSTV3dzZiMlJRQVFEamdqaE9EcG9tQnRUMFBWb0hCT3ZCLzViVExUUFl2?=
 =?utf-8?B?UEFHSlRwdmxYaVZrT2RCWDV4NDZXRDB4U0ZTenplZk9qN212YXZTWU9Ga0Qx?=
 =?utf-8?B?eDdSU2hIQW1pY0JCL1RJOWovc25ycU9yRkFKZWJQMGI2Rkd3UVZFZXBNVWs3?=
 =?utf-8?B?UDR0MHdoM0M1REJCTXFMSHpBa3lUN2FheGQvL1dycUo2WlROUmd4QlpDTUhD?=
 =?utf-8?B?YjVXTUVrV1FiZ0tjUkpvT25hdS9qd2tzRGp4a1JDWGVKSmdzTXRRNEsxd0cr?=
 =?utf-8?B?SWcxMElSSHRVYnVBSFZkYzFMZXBReGNUcUQvSEszeUVaaFUwT3ZvTFhIRS8z?=
 =?utf-8?B?SXQ1bzkyemtTTzBjYVhYeUQya2x3MmlLdXdXV1AycWJOeHNTbFBMQ0NpUzNU?=
 =?utf-8?B?bFNodWxIVjR5dkpGS0dzL0R4U3lwS21rVWpTeWZUM2c1MlovM2UycmdWMUpx?=
 =?utf-8?B?cWwzOHJ0QVo0dDNQbmNZeXlGS0Y5U2lBY3FvcHl2SHdJeHZlTElSSDFXcm51?=
 =?utf-8?B?bjFWYXY0ZXAxdmxPQVVKV3dRdjF2Sms0aUQ3V1o3Zno1dDgrVGVka1dTaDRL?=
 =?utf-8?B?bDdLN0YrRkExQ0VKbG04WXBRS2tYLzJNRU50dXREdHdJSGdhTzc4ckV3Qk9R?=
 =?utf-8?Q?Izwb3jR1IHA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXJvL2lzQ2YrQW9TWjRDSzZmYzkrTHZvTlBqbGI0aHp6YWdOWDRRSGRCa2RH?=
 =?utf-8?B?TjdXRkJTaENWbS9rRStTdy9mZyt0NU81T2VBOGpSRzNySStQK28ya0hsTXdK?=
 =?utf-8?B?cUhEVE9yNnJ1SWoxKzY4bFdOMlZnVTJkSGFtdlA5WThFaHo0aHNFR1JiL3Ar?=
 =?utf-8?B?UmFmaFo4K3czOHBtMER6c0dtRThENEg2TlBUUXJVeHZnYklsMEUvenVhcDBC?=
 =?utf-8?B?cVJMcDVHVVNiSDlLTUJYTjQ1REt6NXNZZE8vcVMwTWppM2dnNDJlRnFZdnpG?=
 =?utf-8?B?SjhIa0RNb0tCd204dmJlV1A1ZGc1ZWtidEhMckh0RHZ1SkpmTUhzTTJpRnpP?=
 =?utf-8?B?d1V3dGxuKzIreCsxR3BtSmMvYWJBK2RJZnhWQ09rU1Zpdll1QTlzdWt3ZFlD?=
 =?utf-8?B?R2lrSXRET0lXL1RlL0h3K3J0bWR6UzVZOE5TT2hyVExwNndzMllpdW9tbm5W?=
 =?utf-8?B?a2J5SFBTbzFSRGMwWmEyMnJLYVNVeFBnWkZ2TGFRK2dIUk82dG9HbXRiUlFq?=
 =?utf-8?B?bzNUQzdWVnNOODB3a2pma2hwdjRweUQ4OGk4R2pUdDJVZWF5MkVNaW9GNlJx?=
 =?utf-8?B?dm9BTzMydDJtVnRHRklkaGsxckkvNDNWQ0NyUXFKblpsSTA2cWNJY0ZUbHhE?=
 =?utf-8?B?bnllMGFtODRHZFQ4K3VaZlN2MWxvRzBpOFEvYXJhei9aWWRGL3dBRDk5ZU12?=
 =?utf-8?B?b2ZZNy8zNkR5QjBRMytlc3kwQVBtdUN0SmU2aUhlWmNjK3VhMHpxQ1cwS3Ew?=
 =?utf-8?B?dk4yZG0xb0JzcHVDNlJMS1JrWGFKQ1lFQ0s5eUh1ZDYwMXBnN3VGTytsRGlH?=
 =?utf-8?B?YWcvZUtNUGZhRDhac1M0Z1JvSlI1dHR0dlRtNno5VXpDdmdOV1RnTFdCRzd1?=
 =?utf-8?B?ZnlUU0wwNVlXQTdIYUFtc0NGZTdxay9kYkJLQTh0Y3FLYUlsbHpaNnlwZ1Az?=
 =?utf-8?B?RWREL3JON1BidkFHZ0hEVjRBSDNwK1BZZ2NqN0tWd0tGTnNlTS9pTTAzdDVs?=
 =?utf-8?B?N2RWaDY4NlVKRnRITCsza0lMdndjbFZZeVhRVXZ3bSthTnlYVmw5TzVrQ1Zw?=
 =?utf-8?B?VVZqcEpJTzcyYmxVcTVxUXJkMS9RSUs1bFpBZFNINEwvbVpQODg4QU8vWEw2?=
 =?utf-8?B?RldkbytCQXdvazVtM2YrZTdpZjJpNVJNM3ArMDNXRmhiZml5dVNRS0N4ZENW?=
 =?utf-8?B?czJ0dDZDbXp4Q1o4NTlISDRpRDZMUXRZWk5yZE9qMzdNckptQ3lwbXUyZ1lL?=
 =?utf-8?B?ZU1BWEhETU9SRWdBL2VrSTJ5T1lUSy9HNEltaUZmVHBNR2FWTXkwMzB1N2lH?=
 =?utf-8?B?Z1g0RjlDb0UwaHRyaGNHR01ERDhydWg2S0FNRlc5RWFuaGorKytKN292emxl?=
 =?utf-8?B?bGlxOEJsVHpRb0FOeUFxMElxRnNKQTZKMXJQa1BXN1NtcHk3eG5IR1VXRlRJ?=
 =?utf-8?B?SGVVWnRTVWQya2orYmpIVzhISS9FUElEdzczc0dlU2ZHYXErZUZDRlJ5WWdO?=
 =?utf-8?B?NnVTa0plVnlPSU1QNzRJNUJQM3VUbjdUNllEVGh3cGxDOEpnWm80eWhFcnJr?=
 =?utf-8?B?VXowTW9wM3BueXNVdGRhYnk4S1R4QThGZU0xMlJiTVJWQzdHWnFZNlhINXF3?=
 =?utf-8?B?NlBCRDZuQi9vN2FQUXNyNTFTUnl2ZkhIeStWMkRGYTBOUVlHZnVCMVpsMGVT?=
 =?utf-8?B?SGFHTTFWa2JHTlluaWxIa3Vkc1RkeC84OVNqbmlhbEpWbHN4TjhUaHppa1NY?=
 =?utf-8?B?WnAzN2dvcncxMFJvd2NPQnJMNVdBQzd4VWwvY2MvZGdKTXkzT1dMbHpXSW5G?=
 =?utf-8?B?RWNaakdSbXhRbzlLWHFwM243NFc5Ly9xcXlOajRIc2puN281MWhqTGQ0MkZI?=
 =?utf-8?B?ZGRjakxha2UycEpZeCtETTFvWm4zWEVqbDdtcmJmVXV2RzExT29Zdm92NzhO?=
 =?utf-8?B?MktGeUVyQU1vVFZVOHlFcWRmNnZiek4xVlA3V1FMekJsNWNBQS9QZUJyZVJy?=
 =?utf-8?B?VUNOcVgzbk9qbVh5YktLVTFFYlIxRHBudG85K012NWhoRkFJdWhoMWJxVHRN?=
 =?utf-8?B?Y1RLVEJLM3BrNDRZRmVhRnc2aVhVckZQMFBDRTZHTmZkaSszL3BHbFdkeUFj?=
 =?utf-8?B?Ymo0YzVwb3YrWWRtZTJvdjMzd1dHR0dDU25RZU5Qa3JRanpGS1RaMXdWaTlV?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O3AqLHUBniYDtWUdFKM+TrB/oCIckVTUbj8DE7sj2qSf5WaQ9u8sPrweRsbuXWnBIlX0X3wQTeD7owWweYQAFmP58Lbs6RJ+f6AiBK/Ix+tIxf8yh8KyHB8AZHQZ8j603vOAPSOS5gU7edqRQ6drQJEX2jGxjuTZyueRScWzICOvARrSOCEp1eK2p4kN7yFYQIoaPbFUizQqCFLgkxawZrs3kA2UG06/1YwFHdZDIHUqu2ow5QMmlLIbul4Zdp32M4sK49Wk0Dp1Zc5a138sIXiWMGurNOTgEufIVGDTDWv3Ilt0bFCJIk7AB2LTtsXXvDsV+qpajBbUAYTP8vyOx/2SkAoHFvosODgn19r0FEceVAXPoa27ZuOXeJIjFqsvUAaixlh6XM9tnca8pFUFQ1jPE7EW3qL9F+YiV4V6HkWZrEOWKtLL4AuZ8wCvCuhqdkvZZ846hzbU+uTmAPUgWZrXtRBBEQKhRVuAvC6gUtELrzFMgd5i6I44lA/nbAq5U0HbYR06oDr0WEFJ1CNQhR+tbcTEuPYa2IbaykrJKrY5KVS9IysjhvUnF5vgqKNmLX5x9SPv8rJJDUSwBReowDq07Y1y1vb3bHuRSHLvDaI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46d2ac0-85da-4b73-c318-08de100a994b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 18:58:04.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fm+OZvyc4gwDHsfBvSzGLGfLglOikanHKZhWlfj/4iS8pHYlSldgBl7I19z++8w251a3So46EamSH7scNdVHZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7189
X-Proofpoint-GUID: kjwHbb97JD_lupPcSYSlv0KYOC8kU7Vj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE1NyBTYWx0ZWRfX/YMbKqCpyX+q vSu7YAiTS+9WFI2fNQBJosrHyNOo9JHU5nxHwIolA5sLxTz58STR9ypYOFcaNCC0wSeP0oa39Cj QLI1Z5DsPcHTZ81IRT8HCLtV7c7JvUw18yYY5sSJdvXWx5hU/LxRAIhUbkp6BQin3/DJ8mXrH+P
 eqpxMhpux6rzCM4ql8wgIrwK6ztwRBubdkIgarhQ6VzvhXbxjmLCyRmmmzU3cfiWG2VERTsnSLH tGT1satj6qp5XiWuNt8erWEV5N+LenVRiIL4nbeh7ydoR77epuag==
X-Proofpoint-ORIG-GUID: kjwHbb97JD_lupPcSYSlv0KYOC8kU7Vj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200157

This email announces the official release of ktls-utils 1.3.0.

The 1.3.0 release contains an implementation of tlshd support for
certificates using post-quantum encryption algorithms, moves the
configuration file to /etc/tlshd/config in preparation for TLS
session tagging, and adds new GitHub Action workflows.

Work on other new features is ongoing.


Official source code repo:

https://github.com/oracle/ktls-utils/


Release tag:

ktls-utils-1.3.0


Release artifacts:

A source tarball created automatically by GitHub:

https://github.com/oracle/ktls-utils/archive/refs/tags/ktls-utils-1.3.0.tar.gz

A source tarball created with "make dist":

https://github.com/oracle/ktls-utils/releases/download/ktls-utils-1.3.0/ktls-utils-1.3.0.tar.gz


Issues and requests for enhancement:

https://github.com/oracle/ktls-utils/issues


-- 
Chuck Lever


