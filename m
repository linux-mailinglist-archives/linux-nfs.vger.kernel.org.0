Return-Path: <linux-nfs+bounces-928-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CAC82438D
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 15:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09801C21576
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 14:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA96224E4;
	Thu,  4 Jan 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="og8KGvLi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PTeIGXyJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA21224E8
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404CQi7K010116;
	Thu, 4 Jan 2024 14:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=yVeRaLBAeEsD39ollgFLv7wDEkEVf6mAjfdQJgACkE0=;
 b=og8KGvLi/M6VifGUGH+0gvg/dw+BpmAQdNTyiI9/lNZnY6BXwcPF8hbUaSF+BHeOEdmb
 3jZAlWBNEIeI8F2PqHNXUEAP72SPGbP8QvYyWXixCw31k4mQljcTTpyRFZIyngjriRP/
 Vn6YudsOLmlcxhKuYN7rihV60wzT/co1QiSroA4waVwIWHgI8iBtWLFi+UU8MrO7bs9N
 dyA+n0yYeflEh40Q6yZKOxMKdT3+ehWRPmBQ/ChDUZQnR3RLhKZ5678CQXCAI/ivUyhe
 IL2WnFFKjCGinz+1kHUFvb6iToinovaTpe1kUtxN6vS8N6AFkygdO/2jXAGYqS49W61E UQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vab8d77st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 14:18:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 404EFMA8025851;
	Thu, 4 Jan 2024 14:18:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdx9006m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 14:18:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn5YMXgC2ldFd0gn+re2eL9Gqnj/eZHvbxLh2NJeTXRwaU/nHQVW4D9j6yMdr2/wCrBCJE6PVPV1NtF79JsJWkg+/Y0STQhqq7jjXvcBt4Ik9G+7KJ5G6LknGKuEKRDqAxJUtOCYYTAym2Druav+iva4SUVLTVETeS3IpSLM5DNQK0o0XO5yx5lP/ZC2OZA7GPXc9t4uzxhs4Y4C/x1mbELndVVGnHhvQr4s4bzBW1VIWKa0v4lNW+djuYrV6X2BsfH3MVwXU2vDrk6IIv+TOJUCSihD3hrelaeQ2JhEc7nyn3yxSFZiDCdMGQE6Kf2lCGRg2OZNzUn21s2fQu3PKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVeRaLBAeEsD39ollgFLv7wDEkEVf6mAjfdQJgACkE0=;
 b=RFpVnI9a9KcsRC9mg8fMz/CX+pfEuxGNQKT7EEyyHNlI8vKY3ogHaglLxgJr5Xnp1KlmEkMYJ8yw3jlWJRHOnyLVABf93BXMEQYaB3YtK28jfFkfYMcWq2zuLcqAQCog3tLg3Y21hlUcERLGnsG5kQDVQzPKFlFlCGHOsROJxd+fJjN6/1XE4OpaEnt5L1OkVe7MJUKi9w7UvuOVsxxD01VXTBsHjnbj8Yh4MsYzJauMtzHbR+9LOHTqT/lnhjRItpmyMf8B+FGRUuLq9CswdFHNkCSLIgAXs/bErQx28fMsWTRHpjqe1ngICPecTqurSNNWcLzRCj+QktWpzlxMxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVeRaLBAeEsD39ollgFLv7wDEkEVf6mAjfdQJgACkE0=;
 b=PTeIGXyJxbaL8ljOnwlNp9bsdY20oT83ZzgoxfMxUzz9iOtWe6dBzD8mCYhxCQkasDjOP/6+NLQ3eRYhMmrzJyDPJBiTl3DxitRWDDTGXjB6YsHI2tKOPgLGUXER6bo3hGmbszc9IkPykO51QF6qW6Z7QV+WwBTyDAlm7n7PcYc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5682.namprd10.prod.outlook.com (2603:10b6:510:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 14:16:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 14:16:33 +0000
Date: Thu, 4 Jan 2024 09:16:31 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: hangs during fstests testing with TLS
Message-ID: <ZZa9v3FQcwoZ7PCE@tissot.1015granger.net>
References: <117352d5dc94d8f31bc6770e4bbb93a357982a93.camel@kernel.org>
 <ABBA5E37-2E13-4603-A79C-F9B9B8488AE3@redhat.com>
 <D1091C94-9F23-47E9-A9CF-31CCEFE5EF8A@oracle.com>
 <AB421B16-F1FD-414C-A9BE-652D868F03A9@redhat.com>
 <DC58D77B-FC07-4B96-88A8-67F9ECDFD0CE@oracle.com>
 <8C3DFB5D-B967-4D59-BFC5-7B25315DB9AB@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8C3DFB5D-B967-4D59-BFC5-7B25315DB9AB@redhat.com>
X-ClientProxiedBy: CH2PR14CA0053.namprd14.prod.outlook.com
 (2603:10b6:610:56::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d04932d-e93c-414c-a98b-08dc0d2fc123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MQYjvH/ECCSS3uLzwBDajxdtCepW3qCSyCB96PpYM/PASO8J8Z8hpG1rGmK/alYkba+CtsqzhlaW1OYY8v8bTOqHq0qfAKDuu/5AoVHo2IBfRGkNqbIM2d7ifKeND7w1FhPjPpyeKVyiNj4JsKQxrlAYl6p021WrTDMDBjM1QRES8uODLoFHUZnSIN9Qr/u5kJOAoux67OGxayNKiH7GHLkgBRmoI9NzDmF8zHMKcY+KbbSLIR2W+4gPerGpARE9XgGdxEB7EyphtyxX6Tw6g7wmT4EyoVVFPfGztyP+gn7ZSOG6RdcDVSxyOFJ/2OptDUA1Kkr/ugEkp2YurM4rp6MIGJKCACQ6K7w74p4f7TwHbPDj6ivLNhXAmWm2wmgNQHT51NEhopOTlaaFtNh8T2tEwKnBtaDCT8JIWuXrhJH4biy/kncd2n5Pze3b+M/qm0ez+PduVChsG2xyFppkuIQYNjX68ZQe3Y24Ufa4FYZQ+dg5fUffVNhfnA71Ub95AtsmJv0Tm1Pt0TfnBZQGT0PcAMgdIakGvWp2R9N7AaE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6506007)(6512007)(478600001)(9686003)(53546011)(6486002)(966005)(86362001)(38100700002)(2906002)(316002)(41300700001)(26005)(83380400001)(6916009)(5660300002)(66556008)(4326008)(44832011)(66946007)(8676002)(8936002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Sm1rbGFYSi8vZjcxclNvTng1b0sxeWtCUDBSMDhYZVBGbmlCd1doYTcwaDNC?=
 =?utf-8?B?UG90K2NVdmhBcVRrSk9DbWdzVWxscmlYck5sSjcyN3FqTXpWVDZUakNVYzRZ?=
 =?utf-8?B?RjNxTjFHTFJVK0xCZ3RvNllTQVM0bG43Z2VLVEdBVVRJSEZlaDU4amhhTEhN?=
 =?utf-8?B?UGtaazRLbFdqUm1GdkJmanl0NmxsVVRMUlBTblZzRitURjNHM2pRa1RFenU0?=
 =?utf-8?B?THZqZ2VuNmpFdlNSVExWbUxNSGRleEFVaDhaUjNycTRxaGJaWEx3RUVUR0N4?=
 =?utf-8?B?U2E0bkRIRmM2NWU1RHgrNGo5Wm9pQzRwTXVVM0ZTaUk5WkJVSGcyRnJZKzRa?=
 =?utf-8?B?dmNGb3E0ejFtb0Y0UWM2aVdiK1kwbDRnZ3ErOUFNcFR3VWErS3VuSEZCS1Vk?=
 =?utf-8?B?eUpGbzh6SG4rMDFlbWVDa25QOThoWS9XZG0rSmZsbTgyRFNhS01jekc0VjMy?=
 =?utf-8?B?WnpwcmQvMTdkSTYrUmxaeHRwVTdIaUVqSUkzM2llM1NpNi9FeHd6RzkxYkt5?=
 =?utf-8?B?K2J3NldiRldQZnpiQkFzNXV3M0FGcVBYS3dHV2V2Znc3d1BWNnpYbkR2OU16?=
 =?utf-8?B?OHFBWUR3VzVBYVR0MEZkY2syRkpmS3hPd2VFbjdPZGJxWHl6NmQrcjNIRUZD?=
 =?utf-8?B?cGxxbVQzMkxYUmoxV0tjbkRPbzIxY0swYmdEMkZQV0FiWS9ab0RvWTlCTWhm?=
 =?utf-8?B?U0RSVUJ2ZnlibndWMERsc1JvRGJiTmFBdHNBTUo3OWozbWZ2K2c2ZEVQRlNj?=
 =?utf-8?B?OE52TWpxRGtnaWFLZjBad2MrRXZ3ckJHOS9McHp1eGdTMTI2MnFNZ1BXMkZS?=
 =?utf-8?B?b2VCS24zWjRkbnQrRmtiYlNmRXMzOUZBd0l5MCtJQ3B4SkhualF0TVNFMWww?=
 =?utf-8?B?aEp6NW9KcGtvbjVNTkR4Y2VVZVNzeVREZ25RbVhVaWlSclJyMVlQUWRnRVJ0?=
 =?utf-8?B?M3UzcHpkOHpzOFBiVW9SOG5qVnFvcTJZQVlLTkVkVTJ6TkV0dG9lMjdvOFNz?=
 =?utf-8?B?N3hJNE1iNDdkOXo1dWxyd29nTjZDSTBoVHVyaldFQmRqaHVjRUpqNEowR1Z3?=
 =?utf-8?B?ampZeC9Ibm83V3FCZjBQcVYyUE9ZUGd6Zk1FdmN3OG1MYk0zaXdSVldVN0tL?=
 =?utf-8?B?ZVg0YzhISDgwM3BRYVhNY2N3ejhrcjE1WUsxNWQvVVpCcXlRU0VCYWNqTnNP?=
 =?utf-8?B?Z3BETTdhRk1lMDFNWSsrYlFYWHNtdUhvMVQ5UXpoMjJwNVpBMDhCNEVGbldx?=
 =?utf-8?B?MzEzRnNUaVhzRnFjY21ZMDJSNW1WMVVFeW1RN0pBL2Z0cE5WSHhIWWZmMlBG?=
 =?utf-8?B?NVVBandtbXBwV3RSb09RZWNwdnZzZis4djZCazl0WXY5WU1uL3R3aGxKL1pk?=
 =?utf-8?B?T05iYVR0MUFES2g0d2JPN3I3NXRCbWE1cjRobTJZRlB4dkc3NE5Va1lSaDNZ?=
 =?utf-8?B?bjVCZlhDZ0htQlA4SVpsVzVxajZFUjI1MFN5S2hSUVloZXpTa0JIcE5qOHc1?=
 =?utf-8?B?VjlRcWtCTHJQcmRreE5aNXlveDJ2ZzlIdDNNUS9PSjhjTFRHeDdnQW5vcktS?=
 =?utf-8?B?VXA5U2VZS2tyOHFUTE85TGtPbHc2emVNVXRIK2JONE80YTNtVkVjMy9HRk1x?=
 =?utf-8?B?VzdjSllsQlNrU1BxSTVaNFNwdE8wUjZpdkF2cFJmS0xyMUxaQ0FaSmxlUnI3?=
 =?utf-8?B?UWQrR1lCbnU3bno2dUdxSEZ1Ui9MV1NBOXdhUzg0blBlcjYzcHp2aHpsYUZM?=
 =?utf-8?B?N1FzeGV5ZmpFU3o5V1FJamhVMXpaWE1sVjVJSU83WU9ETmhmUmVjdGxUU2dU?=
 =?utf-8?B?Y2NsZHI4N0VtZ1hoNDlKV3k1Wm1FNUduYXV1V2xpUFhNR3UrdHNwK21YRW9E?=
 =?utf-8?B?bC9wQzE0bitNNXNWTzRWazBockl2T1NYVlljRXdINGlOSUwwblBqK0xiSmdt?=
 =?utf-8?B?NWZEY0JudXEvMlJtSXNKOGZCMUU2ajUvTzg4RFBoRlJoS2lYMlVFSTZ4cVVR?=
 =?utf-8?B?eTBXbzV5TVAxamV3K05VQVdPSGFPRjJDdTl1UHkvMGlQb0dMN096ZUR2YlJm?=
 =?utf-8?B?ZFJvaTZ2ZFFuRTlBZkszZkcwSVZDbkZHekVwYjE4RDZ5WHMreGtuU0xSQU84?=
 =?utf-8?B?NHBPZVBvd0JKRlhLdExnOUJsaFpEeE1FNW9XK3NhZnJ3NkpWdEFsS2sraXJt?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CeWUyaamE+g/9g7hKq49VCq7G2PS/PhsHCjMqeywggiAb4gRnqyVKx0AIrOGs73H4hrNiMwpupdLd1qttxYAFSlaFje/BoiVl9cDjlkB8yoJt756OlP55P8k2K5Fgf29oPVJdy80U92zYQnrvMGc94W8jn038+MjsmhcjWcuYymt2V3S9d8hNMWlVeRZ/tmnj3x+69ckjItvQ7tw1BmC8TEu7BJwHKOfyHwYuCTNe4sZZhj6Q6+hT5suNPJbniI6uP1dvJG4LPbG/ZYGFIbl3KeS+jZpGfPchPBajPhYK/VgxiXCocWZLd+gWwOO2aeptcm6mTiX/tV3R5bBkhRVcZBau4obOv3NgsKV1K3cILJYjy8QaLDPbkeLINlCovyTeEuXhXJaCEB1OXDAqKJaQVkFnYhplRGgrjeijPU0NNQbOp5Xf2C0Pw6E96n3l1yWMSady0qefAJCz2AvzEeogXCjuESs9ba7jdnHMi8GpWH2vtXV4mfEnKV4ivvzaeypgWTmqhdgbcpRbyzUWvYrHiN2EHAQvZHDUPubk11fODAAdh88Ba4cyxqVGHIC9PSKi26WL5JJg2LVBAYdYVFkyMsdIV/nEfxiMVXiRbnX0Ps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d04932d-e93c-414c-a98b-08dc0d2fc123
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:16:33.6324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYsrFT4fF727Y3LajW+CimVkXxByZhFXfqpU6HsPiDziyU6K8IaY19c39uYZfClmf5m/7PCnU53PhvNjDKEX+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_08,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040112
X-Proofpoint-GUID: lSGrYBok1oDT8pwktsq7fe3dIbRBAFiI
X-Proofpoint-ORIG-GUID: lSGrYBok1oDT8pwktsq7fe3dIbRBAFiI

On Thu, Jan 04, 2024 at 07:22:18AM -0500, Benjamin Coddington wrote:
> On 3 Jan 2024, at 16:46, Chuck Lever III wrote:
> 
> >> On Jan 3, 2024, at 3:16 PM, Benjamin Coddington <bcodding@redhat.com> wrote:
> >>
> >> On 3 Jan 2024, at 14:12, Chuck Lever III wrote:
> >>
> >>>> On Jan 3, 2024, at 1:47 PM, Benjamin Coddington <bcodding@redhat.com> wrote:
> >>>>
> >>>> This looks like it started out as the problem I've been sending patches to
> >>>> fix on 6.7, latest here:
> >>>> https://lore.kernel.org/linux-nfs/e28038fba1243f00b0dd66b7c5296a1e181645ea.1702496910.git.bcodding@redhat.com/
> >>>>
> >>>> .. however whenever I encounter the issue, the client reconnects the
> >>>> transport again - so I think there might be an additional problem here.
> >>>
> >>> I'm looking at the same problem as you, Ben. It doesn't seem to be
> >>> similar to what Jeff reports.
> >>>
> >>> But I'm wondering if gerry-rigging the timeouts is the right answer
> >>> for backchannel replies. The problem, fundamentally, is that when a
> >>> forechannel RPC task holds the transport lock, the backchannel's reply
> >>> transmit path thinks that means the transport connection is down and
> >>> triggers a transport disconnect.
> >>
> >> Why shouldn't backchannel replies have normal timeout values?
> >
> > RPC Replies are "send and forget". The server forechannel sends
> > its Replies without a timeout. There is no such thing as a
> > retransmitted RPC Reply (though a reliable transport might
> > retransmit portions of it, the RPC server itself is not aware of
> > that).
> >
> > And I don't see anything in the client's backchannel path that
> > makes me think there's a different protocol-level requirement
> > in the backchannel.
> 
> Its not strictly a protocol thing, the timeouts are used to decide what to
> do with a req or flag the transport state even if the request doesn't make
> it to the wire.  That's why the zero timeout values for this req improperly
> resets the transport.

I guess I'm harping on this a bit because forechannel v. backchannel
is already confusing enough. The use of timeouts for RPC Replies is
just heaping on to that confusion.

If we're going to keep an explicit timeout when sending the Reply,
it should have a little documentation. I suggest adding this to
xprt_init_bc_request() before the new call to
xprt_init_majortimeo():

	/*
	 * Backchannel Replies are sent with !RPC_TASK_SOFT and
	 * RPC_TASK_NO_RETRANS_TIMEOUT. The major timeout setting
	 * affects only how long each Reply waits to be sent when
	 * a transport connection cannot be established.
	 */
	xprt_init_majortimeo(task, req, ...

HTH

-- 
Chuck Lever

