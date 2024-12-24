Return-Path: <linux-nfs+bounces-8760-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2209FBED7
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 14:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5F21611A8
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 13:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA14D53C;
	Tue, 24 Dec 2024 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iboiLhef";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y84QVeK+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68031BD9C6
	for <linux-nfs@vger.kernel.org>; Tue, 24 Dec 2024 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735047918; cv=fail; b=XfvoJp73BvjXg/CUWgrkaMAp4xfkVLTR3+GcPE3fNWZjSbv80sxCqmHJ5p77FwqJSE9q5hbPqsc2W2WhbxedezHycs36MtWfkFv3LnVf1Mjh+/ZqK9r0m9nTkFo4/M0eQ0KeOMQ/djuXDu/Dco3sVxqq1XjhOq71M4ddYH/DnVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735047918; c=relaxed/simple;
	bh=HQj0V73wMIUBiLu+VYsPtkGigYYTkIZy91RS87/95q0=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tqu6wFRGM9kVi5TBGPS3YZ2bblcgO4OMnLLLggCYDGevLxIAN4qBM+Cyyrz/AF29OIjJO6r3mRTxPgNZ1iuibqWn4Rn+XfRUWUk/ExkPVSIHXLhtUA23HIBm8T8k5dFyquCpQbdF+/lXMRwSjin16j9pEPib3+2id2vIafU6uKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iboiLhef; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y84QVeK+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOCBZ1d019281;
	Tue, 24 Dec 2024 13:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7ysPp6pKjZaMdy39a5MCS+b99uGxAUJPBWqki9pQ/jo=; b=
	iboiLheftDSCPnk3nbTNqs+jN5XTbCu/ZCwwPeGn2VsQT4G5fyB9+UoHAgYWmmH6
	OYR9OnICmiAdgW+LV+txKtTAgp0QUUFlZfZEHhY85We7M+YEgCoJQdgA9+ryZJ96
	gWgekw/N9q68U3liO3eB3BBrgEAilBjMxh2v8Fzn66mBlqDMNBGsqRSEj7Txn951
	gun8v521WSr68A42GLiMKTs26c1iWt7/2E97U/FyfACVqgKmpg/K+ep+CkeDKHZ7
	7HoxucZK4ZmlxvyRGP2AHoiiuSzrayDAsQ3AGvwRLc/5dtq/dIgxHjtrAhI8prqt
	jBnfupmbiG/0tMfdWP50jw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq7rm9kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 13:45:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOD9MJN004417;
	Tue, 24 Dec 2024 13:45:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43nsdgtjwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 13:45:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BduaQxAfLoohu9IMwdqCDy2O9R10Vo1IIZW+7qyoWVKiRBV1Y1xT1WVutsJ+DDyXcRRvGVJhB4pv7iY1hhKedudfOSMbecgku3RPjUR+4UnKKz8UkzG5psdlABo8m5oobKJFJUXjpoWHiRGRwHVRHePcAncrRf2nQLYeG5X5iV+YU0VvctoK8FQfUyTAgDgD4viBtpIyiyAILs8o4L9sk+3kfyC0aT11Cfm0LWww6f2lpR61wJLX1FTTtfzyUBV/QlIGbmy+oM1CY9n5+fSkxEERaYm8wPfw9EygXDfMNVA8mNX1qNR4iEAnYGVZ2qiGKvmQSvMNKwQEWGJQv+nFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ysPp6pKjZaMdy39a5MCS+b99uGxAUJPBWqki9pQ/jo=;
 b=ZPOcjJ/wgmzjm0BDmQsvfdFVCdw5NpLo0BVKJ9vIdLnWph3YmWVD6bkfUFUJSlzzxqm6EFRkYhTC0nfqrIcCT2scm/BMfd1lZbFReCOhhlIeYB9NRtMsReVLGGW3/4KkhajwOhKQRTy/lQ/3YjF6xAlUjL5XZV071G5DDLwu1qXbVib9hvQF0zEW9tJc3wnFfWwaxGKHQf4PwEriYsf5jxRaMN0fkLek7tf506Ujb8wPJoUOSELiEWvjgj6fUyINSiIH9Jix+hVxAVcGeU8WTD/+x3f/JBLpgpmrS7G2zJiLVGpYd2BaIVskjIUgxKYjvlLNDL2+XZMg1GmlCY1dXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ysPp6pKjZaMdy39a5MCS+b99uGxAUJPBWqki9pQ/jo=;
 b=y84QVeK++hbnkbz2Drwztk5un+WDVtlYjyspfNw2jy1xyAPuNKFm1G4xtjy+NDvVVnGo/6DxPKb24jH33vucJ0OqfmIUHX701CwHwJR23c2idiZbEq2u2CcG4Z9bbHqY182XFLe0bOdtt7fBb0tBEHYIdqqFs7yzA6CU95d4IwU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6739.namprd10.prod.outlook.com (2603:10b6:610:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 13:45:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 13:45:08 +0000
Message-ID: <7a414a0e-ff2c-4fa3-92da-9affe00febfb@oracle.com>
Date: Tue, 24 Dec 2024 08:45:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: knfsd server bug when GETATTR follows READDIR
To: Cedric Blancher <cedric.blancher@gmail.com>
References: <CAM5tNy4-SNVD+zqgaJTmLtAQ+kKV_Ce4tRr2zqgjTq1KPM-rfQ@mail.gmail.com>
 <4804ce6a-fa67-4b50-bc31-715689d3c766@oracle.com>
 <CABXB=RQn8qU5TZsWyBpWNaDQpaMPhdi4RYVJ0D1qJAWiFuBAHQ@mail.gmail.com>
 <e4853faf-0836-4595-952b-69f71150bede@oracle.com>
 <CAM5tNy6tR96WrCeoLEfoA5cGs0AP=mR3q1nmYrqbFTTQB=G=Yw@mail.gmail.com>
 <CAM5tNy6dFBgAhkX_mBzXyRyb+WfukZT0egpt75XRgCYKHPsP3Q@mail.gmail.com>
 <3998d739-c042-46b4-8166-dbd6c5f0e804@oracle.com>
 <CALXu0UfSYhcTm6TN28WU9+FCzQMQkKXMZxGp2PHb3kFi3jb6-A@mail.gmail.com>
Content-Language: en-US
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALXu0UfSYhcTm6TN28WU9+FCzQMQkKXMZxGp2PHb3kFi3jb6-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:610:20::41) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d3419f-ce53-4929-d263-08dd24212df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWM2U1prQVF4elg0Tm0rdzNvazRNQ0tadldrZVVtZ1ZnY0VYN2R4STFGZWVQ?=
 =?utf-8?B?MEhhM2daVFBtanRod0NjTnl1d3grUndlUkhCVm9OWldKRlhhcDZLTlNmamxQ?=
 =?utf-8?B?dW5lNWlyYWlablZjcFNpSWxLRmtBRnN3U1d0aEVMTE9LeG5OWjJucEJzTkx4?=
 =?utf-8?B?L2ZWcW9ML3I2ZzBMcnplSGZtMTNYeW9ndVVFTkthR2tvUkdWNEZ3WVVEdith?=
 =?utf-8?B?OFltRk16Rk9OZ09tZEw4WDZIWHVvTmV1SjhYbkNXYUsreG5GKy9xQTlHaUlY?=
 =?utf-8?B?aXZWaS9hR0NSZmIzWUt2OGRjbG9mNGluTnkreFdWSnFpWHdQaU5DSWxLNDlm?=
 =?utf-8?B?c21iWmNqZFJVbTk5TVplSVh3bG85Rk5WcVVLZWVLUVVxeFNFNWFkRlpsSWQ2?=
 =?utf-8?B?SUYxdVVDMXkxSFJ4djFXVjcyT2o3dTZzaWFwL3NsV2hBcHNvQUlyaHk5aHFy?=
 =?utf-8?B?b2NFaytvMmI4UGZrbmxvM0NMZE85ZVlsUytMaFVoaTdSODhva0ZFTmlPNlJm?=
 =?utf-8?B?aGF0WGI4cFVLSVBzVVJPL2JpNmNXQTROYWZZSHlRN1g0WnNRa2d2NjFXbVZr?=
 =?utf-8?B?N0I0U2l1M0REeU1QNFlZdEt1QVhpbzAxeU5mZG1aT25sc1J0M3R0SXZHZy8y?=
 =?utf-8?B?Q0Fod3NranVHM0hmdjA3eVpBd2E1TFhHZGhGRjhMZEMrYVRGQU9LMUxVZXdw?=
 =?utf-8?B?Vmh5dW1FQ2pSZU9UQ2RFWXNOODlqQ0dGNUdxRUFWaW5MVG5oVlV4WnRDUXdF?=
 =?utf-8?B?QVI3ZDkvck8zYnNuY3ZJQnFjL1ZaVWpQSVIveWhNNTN2eEE5YkEydnpZNDVS?=
 =?utf-8?B?VDlQbDNLWXkwTXlaZFVVUVpsZEhtUHFOaFU0SUNJbUZNTnpBYWhwdXRCdXZM?=
 =?utf-8?B?Y1puVkhIdVQvN3g0OC9kaE1DZkpQU2x5d3FKMWZJdGt3T2tyNm83WERBclE3?=
 =?utf-8?B?Mzh5TXUvTTVrdkk2UDY5YTJxbFFkdmo3OUxNYVh2RXVvRTZad0tWNFNQTW5Z?=
 =?utf-8?B?Q1B4b1pONnV4cXBDUEJJeGtVUGtpS3Y5WldPaGh1TEdicTR3aE01Mnc2WDRH?=
 =?utf-8?B?akxNYTdGbHF6aFZpdG1qRXdFcVgwdk9aWWNDQXpMT0tmZDB2SHJvUDBQMkMr?=
 =?utf-8?B?eWF1Qk9xN2xVcWNOMTViN0FSanAwUWdZMlVNNGVXNUIwMjlGRW92M29ib3Vy?=
 =?utf-8?B?MUQ5MStOZmZWVFNERThRWU9ybUNreEYyNk9NWDhjNml1R1RLVWRHcFJtZDVO?=
 =?utf-8?B?bzRNaUlld1c1S2YwSklJbEZOMGN0Rk9lRTB1M1g3V2NZM0ZWMVpRRE04WFNi?=
 =?utf-8?B?VE5Xb0k5Nko2WTVKSy9aaTZ4YjFDU01ETVdNRUJlTFFhSjhaL0ptVVY1cWZ1?=
 =?utf-8?B?MUNUbExlWFJESmJCb0R1cU9mQkl3Y0d3K05waStxcjg2dHJuQ0JhWTVxVjE5?=
 =?utf-8?B?RlFnS2EydzhJN3R6SWJINDFwU09WR01CeGxzVi9ESDgwR1daekQ0Q1hPRGFl?=
 =?utf-8?B?TGZqWUZOMjlFTmMyR1JwQ2Jwc0xvOTMrMVQyN05KQ296NWVsbzJ2eEludnQ2?=
 =?utf-8?B?YWg0ZWJCOWFrM2xjS1BxSHRIZVJDRVBKYzZodmdMTmFYQkNMaHNnV0REMnRB?=
 =?utf-8?B?QVZxWkFRWUc1YWVUUmpMUU11OVQvN3F4b3JLSHZzQzg4UjlvVllZemNYWEpx?=
 =?utf-8?B?VDBKSEtCUU5VdTl6ODdPOGJyUFBnNzZqYXJoOE5ldW1qNnhZemZCdTVFTGVX?=
 =?utf-8?B?Zk42V0JFUkRMamh6aUJBc2NnM25VRnRlZVd0TkRSOEladlBBRjdUTTlXNGVy?=
 =?utf-8?B?d1UyMUYrOGFwZEtVZHV1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEMya1VzalFJZ2gxbS9qa2xpaWFZSFcyVHdqREo5b2ZxUlBaYzR1dzREY3ln?=
 =?utf-8?B?djJOYXpSOC9tSlFBMjdaeGxGSEp0U0kyNytXNHVUajU1OFRRR3MxZy92RVA3?=
 =?utf-8?B?cW1HbmlyZ0x4Y3JtclpneUVyVGtWb2I3NVVZQkh0R0ZxWXUvT0lqRFp1aDkx?=
 =?utf-8?B?SEpjZmw0MnBDVHR4TElva28xNi9WMjJobE4rOE82WjgxYUR2dXlmWExLNjQv?=
 =?utf-8?B?bE40RStrR1ZscmwrVUFSc043NERCZjcxVGUzbkFSc0pUNWdZaW15cnBha2tX?=
 =?utf-8?B?N0twUGE3T3FBeE9WOU9tVnE3WkJXVjFhOHowME9YbXRvQks4eGpuYnZlU21V?=
 =?utf-8?B?a2J4ZnpWTXNlK1hxVkd2S2lFUVhidzJQUE9CaFZrSnExWi9tTDcxN0xzWkEv?=
 =?utf-8?B?aklnaGFkU29McVFlMVA1QUR0YVptaW9hYXJDRzBYOEVadjZNVGNuR1hDMVEr?=
 =?utf-8?B?OVJ1dnBwUWtaUnlJMDZQUHNsRE02dUdSWjFnVmoxOUpIVEpzY2VQWXcxa0hX?=
 =?utf-8?B?QURnTFNjaWRhYVZtL2lObGRjdU9ZeUdDU1pWMGhCaXZRNTRIOVJ5L3d2d2xH?=
 =?utf-8?B?NG5xcThlVEVhMkNja1Q0Q3Z1TlhIT25keFl0S3czMFhZd0V0WGN6QlQyalJL?=
 =?utf-8?B?TGxVa2NvRHZHRjBkUXZHQmw5T1VJYXB2UGJpUTk3eWxJREFmNDdVU05hazll?=
 =?utf-8?B?bU4vVWpFb0tNVVZyYklzanN3OHc1ODBZc0ZGblJhMTRWM3BYUzZzYzBhSmhz?=
 =?utf-8?B?UnJwYVI5Qno1eFZmeHc5RVUxc2puc2hsYllYZFA2QUlEMWExeTk3WlFRRy95?=
 =?utf-8?B?enNqYTRlUWhKUVM0OGpHN1N4L3BVd1FUNlpuNGRNcVp4UkZPTmNkMU9lY1d3?=
 =?utf-8?B?OWFSS09nSUtVL24vK09lNno5cXpSRmVEaGhoRE1ZV0RqOFFXaVlRcVNsbW9L?=
 =?utf-8?B?NFdVTlpKc3NzV1VUT3BsMDAvbktIQUU1RVJQZ3o4ODkrZk1HekFNYkNjbzl5?=
 =?utf-8?B?b3ErdEQvRHJCb25TbXVYRGlxRm12Q0cxK1dpRlNncWJxcW4xZ3ZxcTRwVVc1?=
 =?utf-8?B?ZmcrZ0JsMWlxd2UreklQZlNpREo5RGdBZjhURW9JVFZZbHR4UXNkSzkyZXBn?=
 =?utf-8?B?QkhIRmN4QXRXRGhpWFJFU25qRlkrMHFJamw1MDVpVDdYZWllY2xrUTB6cktD?=
 =?utf-8?B?dGRmQ0E3ZHVic1FDTmg0OEVRTGpDQk9KTTZuRi96WGd1b1hoUStTRFRsUHZP?=
 =?utf-8?B?VnRmYWtnanFwVW9nOFVNaUQ2UWdhKzI2M0NhMFVjNkxlNFZCQWpxRHVDVjFu?=
 =?utf-8?B?VE9zYkVBNElmTDRHaGNkcWduY3Y2bW1DRkVxR1IzQUNOaHo3cTFuN0dNbHB4?=
 =?utf-8?B?azg5Sm00MjFLaWxxTzVYWlFuSlJ3bGY0RnVVZUQraXVDeDgwWDhhV09PT1dy?=
 =?utf-8?B?aVhDZFBudkx5MHF5b2c3RC9aNVAzYzk3cVNYTEJHOWk1Wkl2L05uL3p2TnQ3?=
 =?utf-8?B?Q1p6YkRsQ2xvSlhOVHo2ZXF2VVFndkd6UlF6Z0hqeFppSXNob1RSVUpVY0kz?=
 =?utf-8?B?WHQvR1Z0dkFmcTk4V1ZZYjk3eVJ1UnlEQ2U4REM3eGtGVFMyeVNpSGVjT2kx?=
 =?utf-8?B?eG4va3NUUlZ5QWVuOGk1bVhDSlVEaTQvTlNML2lnVEtWQll2MnF1TEZzV0Iy?=
 =?utf-8?B?Z1ZjbWhkNE1YZ0FadUlsK3lBdjRCUEV3SENyYlRkMlJOZjZCZmllTUZ6ZVk3?=
 =?utf-8?B?YzVFaEppMllxV3l6QVgra2dVQkwxM21UcWNhKzhIVWVxS0xFa2FBVjFjM0N1?=
 =?utf-8?B?ZFZDeXkvTWJLNVhNdVNmbUlOaHQ2cGt6R2gwWWdDSVdhU05RTUprd3pUS3JK?=
 =?utf-8?B?eklOQTVjMXdYaTBhUW5ScUNRWEhTSUNnS3dsRU82aURPaDFPZnRIV3VUWTlP?=
 =?utf-8?B?Q09CK25lV0I1MEVrRXF6aVcvVEpSZlNKeFgwanBtVkprRk9aL3VaSk16b29V?=
 =?utf-8?B?TjMwdExxbmJnQXhUUG5nRUNhaExvbVNBd2RvMzZaSUxYRFg5THcrQ3JNQ25U?=
 =?utf-8?B?S0V3bHdzK0NUVi9wRTE3VzMxMGlJVUMvSlFmajNmLy8zT2RpcVh6OHh5di9a?=
 =?utf-8?Q?gP24cZhAPrMvrd0mvITWjhVT+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	75fq5luped4bjeSHy5BUI4xye+jczf36XpU1dUJ4eyJR0rNAYfLHBu7aisKl7PBZJEed5jZjjChZicJBv1xFs6SUf/+7TynJiVnJDAplYYx7FqF0vJbgPcMXAXHwncPKLHvRJKaCRNputWXXjmwW0OdYTF0/IwdOWsZTj7hWh0A8iV58CA24bcKesIcAXur7jkS0QvjoyLD57ytvjI81yIkRt490HPIK5LSp9gZA20AZ38mmgN0cQobHtbSVPEPZgZjai0kfFoBN05kc3d5OodsSApsRRtgBBkHIqzsufKtFv2Q9AXmItCfBE46W+WSavO5keoZln79kM17gqA5w7rSLhEXu4RnRiDC0qO4KHSpzrMlJCiTCVJhLuaxWkryPeSoz6PA7C8SkHhlHDuHjfaTPfGptQIFpFpV2pau1QMIcU2vO2KYAqOklognxG7YFNSTSkgA2g3nnrNWE/EGtfR+13DHuAeoTX8nybQ92BjvDNm4Uo/LL76jzVITz+U1V+Dybns/IKosL6eK9UF5N7tLDGqDPF9DMZ9K8gH4xBXIimOYBj+F+YOOemP3upTDp/aLw5XvlmWVeNeKACXcUfRp0j8aLMBwxvTMb8sloNII=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d3419f-ce53-4929-d263-08dd24212df4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 13:45:08.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syas0oYwca+O1lodThdOkqZVxXOSQqfcY29G9TWRh4l9GHBnPDyapzI46cpHGiE4Qpkt8KuXiYcMAVtycr088w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6739
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412240119
X-Proofpoint-GUID: v3mxr1tgms0_nWTZ59MHe-WVwU5zimG_
X-Proofpoint-ORIG-GUID: v3mxr1tgms0_nWTZ59MHe-WVwU5zimG_

On 12/24/24 1:51 AM, Cedric Blancher wrote:
> On Sun, 22 Dec 2024 at 21:19, Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 12/21/24 6:53 PM, Rick Macklem wrote:
>>> On Sat, Dec 21, 2024 at 3:27 PM Rick Macklem <rick.macklem@gmail.com> wrote:
>>>>
>>>> On Sat, Dec 21, 2024 at 9:34 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>
>>>>> On 12/20/24 9:16 PM, J David wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On Tue, Dec 17, 2024 at 8:51 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>>> If they can reproduce
>>>>>>> this issue with an "in tree" file system contained in a recent upstream
>>>>>>> Linux kernel, then we can take a look. (Or you and J. David can give it
>>>>>>> a try).
>>>>>>
>>>>>> Yes, I reproduced this behavior on ext4 with 6.11.5+bpo-amd64 from
>>>>>> Debian backports on completely different hardware.
>>>>>>
>>>>>> Then I set up another NFS server on Arch (running kernel 6.12.4), and
>>>>>> reproduced the issue there as well.
>>>>>>
>>>>>> Then, just to be sure, I went and found the instructions for building
>>>>>> the Linux kernel from source, built and tested both 6.12.6 and
>>>>>> 6.13-rc3 as downloaded directly from www.kernel.org, and the issue
>>>>>> occurs with those as well.
>>>>>
>>>>> Reproducing on v6.13-rc with ext4 is all that was necessary, thank you!
>>>>>
>>>>>
>>>>>> Additionally, I have tested every combination of FreeBSD, Linux and
>>>>>> OpenIndiana as client and server to confirm that FreeBSD client with
>>>>>> Linux server is the only case where this problem occurs.
>>>>>
>>>>> Interesting.
>>>>>
>>>>>
>>>>>> Does this count as reproducing the issue with an "in tree" file system
>>>>>> contained in a recent upstream Linux kernel? I'm asking sincerely; I'm
>>>>>> so far out of my depth that I'm pretty sure there are sea monsters
>>>>>> swimming around down there. So I can't rule out the possibility that
>>>>>> I've done something wrong either in setup or testing.
>>>>>>
>>>>>> During the course of this, I've gotten the reproduction down to
>>>>>> extracting a 2k tar file and then running "du" on the resulting
>>>>>> directory from the client. Doesn't matter if the file is untarred on
>>>>>> the FreeBSD client, the server, or another client. The tar file
>>>>>> contains a directory with a handful of random Javascript files from
>>>>>> Drupal. As far as I can tell, it has something to do with the number,
>>>>>> size, or names of the files. The Drupal project has three separate
>>>>>> directories all structured like this with the same filenames, but the
>>>>>> file contents vary. The issue occurs with all of them.
>>>>>>
>>>>>> The Linux /etc/exports file is just:
>>>>>>
>>>>>> /data 192.168.201.0/24(rw,sync)
>>>>>>
>>>>>> (The production case also uses crossmnt and no_subtree_check, anonuid,
>>>>>> and anongid, but I eliminated those one by one to make sure they
>>>>>> weren't responsible.)
>>>>>>
>>>>>> The corresponding fstab entry on the FreeBSD 14.2-RELEASE client is:
>>>>>>
>>>>>> 192.168.201.200:/data /data nfs rw,tcp,nfsv4,minorversion=2 0 0
>>>>>
>>>>> Out of curiosity, do you see the problem recur with nfsv3 or the other
>>>>> NFSv4 minor versions?
>>>>>
>>>>>
>>>>>> One additional thing I noticed that really blew my mind is that I can
>>>>>> shutdown both the client and the server, wait, power them back on, and
>>>>>> the issue is still there. So it's not something in RAM.  That prompted
>>>>>> me to try "touch x" in the directory to create a new 0-length file.
>>>>>> The issue then goes away. Then I can "rm x" and the issue comes back.
>>>>>> By contrast, I can write megabytes from /dev/random into one of the
>>>>>> files without affecting anything; the issue stays the same.
>>>>>>
>>>>>> I then tried it with all empty files using the same filenames. The
>>>>>> issue still occurred. Add or remove one file and the issue goes away.
>>>>>> I then renamed one of the files to zz.js. Issue still occurs. Renamed
>>>>>> it to zzz.js. Problem still occurs. Kept going until I got to
>>>>>> zzzzzz.js and it worked.
>>>>>>
>>>>>> Finally, I got it to the point where running this in an empty mounted
>>>>>> directory will create the issue:
>>>>>>
>>>>>> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
>>>>>> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
>>>>>> done; touch y0-xxxxxx.xx
>>>>>>
>>>>>> and this will not:
>>>>>>
>>>>>> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
>>>>>> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
>>>>>> done; touch y0-xxxxxxx.xx
>>>>>>
>>>>>> (The difference being one extra x in the last filename.)
>>>>>>
>>>>>> It works in the other direction as well. This causes the issue:
>>>>>>
>>>>>> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
>>>>>> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
>>>>>> done; touch y0-xxx.xx
>>>>>>
>>>>>> This does not:
>>>>>>
>>>>>> rm *.xx; for a in a b c d e f g h ; do for b in 1 2 3 4 5 6 7 ; do
>>>>>> touch $a$b.xx ; done; done; for a in 1 2 3 4 5; do touch x$a-xx.xx;
>>>>>> done; touch y0-xx.xx
>>>>>>
>>>>>> There's a four-character window involving the length of the filenames
>>>>>> where 62 files in a directory causes this issue. There's a little more
>>>>>> to it than that; it doesn't look like you can just create 61
>>>>>> two-letter filenames and then one really long one and get the issue.
>>>>>>
>>>>>> So I haven't found the specifics yet, but perhaps due to pure chance
>>>>>> this directory structure is exactly right to provoke an incredibly
>>>>>> obscure edge case?
>>>>>
>>>>> Well it's likely that this is a problem with READDIR, so file content
>>>>> is not going to be an issue. The file name lengths are the problem.
>>>>>
>>>>> Also, I'm wondering what the FreeBSD client's directory readdir
>>>>> arguments are (how much does it request, what are the maximum limits it
>>>>> negotiates, and so on). Rick?
>>>> As you'll see in the packet trace:
>>>> Sequence: cache this: No
>>>> Putfh: directory fh
>>>> Readdir:
>>>>       cookie: 0
>>>>       cookie_verf: 0
>>>>       dircount: 8706
>>>>       maxcount: 8706
>>>>       attr: type, RDattr_error, fileid, mounted_on_fleid
>>>> Getattr: same attributes as requested for a previous GETATTR, mainly
>>>>                 to keep the directory's attribute cache up to date.
>>>>
>>>> The session negotiates a max request/reply size of just over 1Mbyte and a
>>>> maximum of something like 20 ops. (Can't recall, but definitely more than 4.)
>>>>
>>>> If you are wondering where the 8706 comes from, it was an estimate of how
>>>> much would be needed to fill an 8K buffer with the XDR translated to UFS dirents
>>>> by adding 512 to 8K.
>>>>
>>>> I have not yet had a chance to see if I can reproduce the problem with
>>>> J. David's
>>>> reproducer. I will try that soon, and if I can reproduce it, I will
>>>> poke at it to try and
>>>> figure out what is going on.
>>> Just fyi, I have reproduced it. Once you use J. David's little shell script to
>>> create the files in the directory, the Readdir RPC gets the junk reply
>>> to GETATTR
>>> (the count of words for the attribute bitmap in the reply is 0 instead of 2).
>>> You can unmount/remount it and still get the failure, assuming you do not
>>> mess with the directory contents.
>>>
>>> Good work finding the reproducer, J. David!
>>>
>>> I will start to poke around to see if I can figure out what the knfsd server is
>>> doing.
>>>
>>> Chuck, I suspect any fairly recent FreeBSD client will be sufficient to
>>> reproduce this, just in case you are inspired to cross over to the dark
>>> side and install FreeBSD somewhere.
>>
>> I see the same malformed GETATTR result in the attachments.
>>
>> Linux doesn't trip on this issue because it's NFS client doesn't ever
>> append a GETATTR operation after a READDIR.
> 
> Windows ms-nfs41-client driver also does GETATTR after READDIR, and
> trips over bogus return values on a regular basis. Solaris 11.4 nfsd
> and nfs4j do not exhibit such problems.
> 
> Another garbage value that client gets from Linux nfsd is
> FATTR4_WORD0_CHANGE, which sometimes returns absurdly high values.
> Maybe add some WARN_ONCE() to Linux nfsd if unexpected crazy values
> are sent over the wire?

I prefer that we address these bugs forthwith. If you have a reproducer
for these behaviors, please file a bug on bugzilla.kernel.org under the
filesystem/NFSD component.

We can't fix bugs that we don't know about...

-- 
Chuck Lever

