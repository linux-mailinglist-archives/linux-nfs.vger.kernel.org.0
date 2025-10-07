Return-Path: <linux-nfs+bounces-15030-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB98FBC228B
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 18:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260D53E2D76
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 16:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB8A2E8E0F;
	Tue,  7 Oct 2025 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WVJyto4E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HrAu3s3K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF42E8DF4
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855769; cv=fail; b=dS9ouiBZpODyvzoHvmRPRsaQ4uwCPi1rKapYVru3RnpVnOXfwBterfNNr6mAUlkG0Mobip4F61h7PlHlcXXlK0j92oyUxHHDNNJIcTC5Q1qAu0vWmfuQMGOQlTjIWITZLujXyDnbjuEYh/iEnHbvP9lCp9LIJP+3id1e9NabliE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855769; c=relaxed/simple;
	bh=j1bWtqKiBElafRpiK3KWrcnpLb+dnnsLM23u3SVSdx4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=njR5auK7+Y2kKSGby9tJY/k00ytXPO55BiIM9nY3lRylbvFXoBzlYAnoOlJXJuirtjyxMuHzyu380M5HLpRgjmTs2NLi2UKxGIOp6cc20ZyORYE51IifibUYXPK3IHBKVxhvYemwsu9fYO09CcSf5DcHbi8h6VOdtefOovVwdxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WVJyto4E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HrAu3s3K; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597GiZ5S027025;
	Tue, 7 Oct 2025 16:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j1bWtqKiBElafRpiK3KWrcnpLb+dnnsLM23u3SVSdx4=; b=
	WVJyto4EVBt6sHFChHkYOufdb8ZhV/02VYx39SXCWNlTtDczA8/biEYGiHsmkiTJ
	PSAUDPbmLcm5c7SqLJufmaxwQMTsLfU+MMj8/PJDhggM8QbgcI5+7RkvYliD0Ke9
	rfngrDJwD73OuqhOmH+AdBchv8lgSpV7z6tPM7BaumKCsSNeyPN+7l930T1QKiT4
	1Dq/QBUJckFpg+lHijW+/EC+q4SchrCDEQYGmdZV/jW4rBc0gL01WVjcNd2EPsiA
	RUtytO0aEg2et4SOE10tVaL7uAenLXHzCSFHpWtXajHmgxY2pDKMqOnH7mJqsNn9
	Y83JbACaXgr2j/SuPTxv+g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49n6n6g0by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 16:49:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 597GQnGF021382;
	Tue, 7 Oct 2025 16:49:13 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49jt18q4c1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 16:49:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXlpisdmuWAi2bM32f9PL//kF2j2uNnfQRJqO2yIOYxYji5VhYNpkY9ytiT62+1Zu6yAOQwM1M5o7UYOgZAqxhohBuRq5D3qxbTR2Ly4Z125C6m1wb4jn8/1PdG84HxOaiH8b3AaE5TqROLCube8ZD/y9d+Z8niZ4FCNjk2ukYtTDwHVv017ewnekquf3Ihunm5XJzYfHNBB1vdJ7PC7d3yuooiyms61gREl8/RD9Cblb+fx+QeXFpkBxvkZFBwAbMRQs2i4iBjUPLEGZTRcKGXR7JBPaXuIZAFNaEkC4j6JrMqMnaEKXS9P9WCSIWlhwkPMDVy+RwcNRwY2crj2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1bWtqKiBElafRpiK3KWrcnpLb+dnnsLM23u3SVSdx4=;
 b=vPDVAgqGYtT2/NkLDGizAsqCQQqDUPNW/9K+yCmnWkVw7t4hsBWm6AFuWqArsNjdecNtV+E5/GEoVt6Tu8mEKaSoWJQvwVuxsiMZCSJKMGBNQR8EkiHCC/W8SpTdIz1s8iRbcYKMLrwUoUDsmSBwzTIAYhTmLWB8YI+ncHVUp2Gufxx2fxZDdrvemllIc0vw3xSmILAlW5+vIgYWJea7Pw4LhLaQdWa9G99mccUumg5snYfOuf7jtcts9qhiwMPdTYE8Eu8pClLe/XYAn4EN6lGHRCJZvihk41BvZZI5FewLB/gIZc5FKvIZGKaKoZkXo8J6JFuHvs2gLIn9OqjoRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1bWtqKiBElafRpiK3KWrcnpLb+dnnsLM23u3SVSdx4=;
 b=HrAu3s3KsTgHHvzDMooEI+UsLnWdzfcwG3djROcDMXKicWuPCFimUqMIFFP88eaBsYGGHl/zl+N0sY+d+IqJ38NLpcP+UHUqaTt/ZBu14HF5cs7ArENvO4+ZeIE1qPqJeRoxrobamy432SG1LuXEKuPgHbOtkV3JF6s1xX86VYE=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by IA3PR10MB8760.namprd10.prod.outlook.com (2603:10b6:208:581::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Tue, 7 Oct
 2025 16:49:06 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:49:05 +0000
Message-ID: <0f48e26c-4682-4539-a254-17c2f288b6b3@oracle.com>
Date: Tue, 7 Oct 2025 09:49:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Fix SCSI reservation conflict causing pNFS
 client to revert I/O to MDS
To: Christoph Hellwig <hch@infradead.org>
Cc: Benjamin Coddington <bcodding@redhat.com>, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, tom@talpey.com,
        linux-nfs@vger.kernel.org
References: <1759249728-29182-1-git-send-email-dai.ngo@oracle.com>
 <475D1227-CB10-461D-9EC1-A303B74A701E@redhat.com>
 <ddcea773-3d9a-47d0-b857-087655b2ec13@oracle.com>
 <AFF0E6AD-F593-4CCE-89E3-AA72E1650D99@redhat.com>
 <c0dced8a-29d1-4b5c-9fe6-47d065aa7255@oracle.com>
 <aN9xFsouIH6jlqv4@infradead.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <aN9xFsouIH6jlqv4@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::30) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|IA3PR10MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ef6e15-3323-401c-26a3-08de05c16d6c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VW1ZRjdFUGIrWGxEYVdieWIvNDAyRlhRN2d1NmwwbHZOYXRnaTBKU3d6LzBL?=
 =?utf-8?B?MTBFNDdGbjFsdCtPWDNGQXFzZlh3Z0NWQTVNY1NKOXl2MDE1WVFjRU42Sit5?=
 =?utf-8?B?a1lJSTVCd2VVdE9Bd2M4MzFiY3ZlWStSckFuRTNFaWhTOE1PRkMxbHBobTc1?=
 =?utf-8?B?T0tjNVhPaTlyTzdvWFJPM0djMXhUbkFwQTg1VEU1SGxqM0lTSHgzejNFYVdh?=
 =?utf-8?B?eWt2VU5GT0NDSlhrcnZ5NE94OUFUM1Y4Q1hSaGsvdU5ZOCttOU5uK3pVaUs2?=
 =?utf-8?B?VVUrQjFNekNOcUdiMy82cmRHTzNRa1FQV2l1dmlFZFJzeGF0aDdJaGx0aGlO?=
 =?utf-8?B?eHVEL2VoWDR0R3dlWk1CYlg0ejhLbWNXeTFpandja3Q3dm5VR0JWY2NyNnB2?=
 =?utf-8?B?S3hmelJIWU1SbC9zblZhNVhCRS9UMEJvWWdZL0RnRm5FSUkwN2VtT3NJRGc0?=
 =?utf-8?B?VTk0OFYzeGI3L09GUWNNME9CSFhxL2Ftb3BXOS9ONm1XdzROaWJpeFRWUWpQ?=
 =?utf-8?B?ZDAyVFdpNnh3Y2lPdkhmcjJUSWl2bjh2dXBGcFc5c1NiWEw2N0VyQlN1blA1?=
 =?utf-8?B?R3lGWDVGenFOTEYzZHZDTks4aUFqZ1lBQXdVaVlhQjNqa2cralBsR1JLZlk2?=
 =?utf-8?B?UFJDR1FxSFFpNEtBMGxTcEZUVVplUXNQOWJlWDA4ZmFiUmZZMFgySFh4UUN2?=
 =?utf-8?B?aytFdU5BcGY2QUtiK3IvUUY0OVlkeUJjMmdGUnE3RGt0Wko5ZklqWHNYVENm?=
 =?utf-8?B?ZUtkdEtEdEhaTFIrM2Z4ZUl3bWErd3dlWlFtbitBSm1rMjN1Q3Fqdk92VGVl?=
 =?utf-8?B?eTBFc1VjWFFUYlhTcTdXQVNRVXAwcVE3SDJGd3VKSHdVbFJJZHpVRlZFd1dU?=
 =?utf-8?B?NG5MQnpoSGRyb2FpUHIrNzhRM2FhL1J4bzNrQTZ1LzdNcjJ0dEFzbXh6bFpR?=
 =?utf-8?B?YU5KT2Q5L3ZKdzJGYzBKTjJiWEtHQzBsQnRHVnIyc2x6Smk3cEtoODYwa3BW?=
 =?utf-8?B?QXBGTFYrT28zVDl3dnpudVNHUVpjU3BGZ0NCbmxtK0RRbHhFeVA4ZDV0WXpK?=
 =?utf-8?B?V0dEajUzc1dhNFRZeUVPaWVVam1kQjhGeUFZQzcxTEJBV2pLemNxRS94b3ow?=
 =?utf-8?B?TlJuclp1ZkpBVTh6RUExY0VXcGVzMEM1ZDVaR3l3TGNaWFF4S1VPZVNlajdP?=
 =?utf-8?B?NTlBL2pVS29VRExmSCtDTEdCOUlseDlQWTR3dldtZVJER3gxbEN0U1VXN05G?=
 =?utf-8?B?S3pkM1BuK0N5OUl2dmlPM01LR0l2MWlUc1FPenF2NE1IV09QckdBK0dSUmM0?=
 =?utf-8?B?OFRSUy9IbWdXbGhKbFk2RTl1dXhBNnJZRDUxdXUrNFRrVDBsMnJscTV4S3Nn?=
 =?utf-8?B?TncyY2R5SGVGK0Rmd2RnT3FKL2o5SG9hSTIxTzhHbnZUU0UxTVhyTy9EMG9U?=
 =?utf-8?B?M2NQblRLWG9JdjIrOXJSSHp4Qkc3cGVBWlFmSUVva2RkY2NWL1dTblhZbTBh?=
 =?utf-8?B?OENGY3ZMZi9LcVJNdDVWUldRRnlBVDJPQ0s4RGdHNWVHc1NTdXpMTkNnMDZN?=
 =?utf-8?B?cGJIOFY5MTNxWWljTUxyK3ErQzBmVXRibWVVbkk4bWV6b3hhbk1lc0kvTXMz?=
 =?utf-8?B?K0grbFB5aCsrZjRIQ0RMYW8wc0kvRjFMSTZUWFU1QTNhRW5sQzU0QkR6Y2U4?=
 =?utf-8?B?YXVjaWFNU1FLckQwdFNhbGpDcWtJY05uaWtBUi81d21mbERYdTc4eHNZNVpF?=
 =?utf-8?B?Vm14QWN6TmJXMTc0WE53Y09vc1VDQVRYMUR1SDB0MWp3dWlCY2pDQVBJM2ls?=
 =?utf-8?B?WkpHbVg0aVNocll1ZHU0UXNvNjM2aEMra0VMYlFiemxTL2MvL3VXTHRQeldr?=
 =?utf-8?B?SE1vbzAwaE1YNktjanBHMDhBYThJQTNFMGRtdzB0TnB0TlZ2alZCRDdvSHdC?=
 =?utf-8?Q?cfdzHlezShDC1pQdfck4F4c/G7YaE0xc?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d3dLQU5lc21KajVic0IwQXF3WUZZS0dSQ3IrVlNUOURTZ2dyZkM0TWJtbndC?=
 =?utf-8?B?RERHamZtSnVwSUhKNFkxb1JVS0RwVmVEWGtXR1lQQ2VsYi9kbFBSMUNjUG8z?=
 =?utf-8?B?ZWM0Lyt4ekhJOUFjWE14Z0dEYnJTM0h3eHdPMGMvWW01bElTZ0w0VmJ4NVBW?=
 =?utf-8?B?SkR3TEJNa1hONWV6RUxkTlpmY1JoNFhWbis5N251b1NFcHRYY2JrWmtnRHc5?=
 =?utf-8?B?VTZJUzlhSXY0czVDRUwzTzZadVM0VE9Qa3NtWmk3bytUU0VhT3RqV3JIZ2NQ?=
 =?utf-8?B?Nm5LbS84bXdBNVMvUFd6aGZOcFFocVlhMTJzR3ZQbmVjdWF3aldyamtYOGUz?=
 =?utf-8?B?cjdOL1Y2YUo0SHNVNGdhQjQ5S0JuenVkcFgvbDQ3WVhqNWxqVWh5VHN1NlpQ?=
 =?utf-8?B?dWgrVndyL3BzWGdkN1c0U2doU0RrQVlNbjlCRUJCai9UeUdpTWU1Qzd3clM3?=
 =?utf-8?B?bElmWlhzTm9zZ3RseTRVR251VGgzNVVsSVAxSDY5eUpTUWEvUVlLN2JBd0hh?=
 =?utf-8?B?RzFNeE0xR1BRRXhjV0haUitSUG9Oc3pkUCthcm1kc2xDSXlnODVQT0Y0SzBB?=
 =?utf-8?B?Tllsa1YydnRhK1paR2FLQVZNMmovUUdSUWljMytMR1p1akVmZXZFcVUyRUZL?=
 =?utf-8?B?UWFCcldFZGkzTFhlZVoreVgrYjBqRWRrSEZ6NVp0c053ejJhRW80MVBEb2Fz?=
 =?utf-8?B?NGV3UnFuTmpqc0trdEV2WFFJNk5BbVRxK1RUcXR6NnhwZWxOLzBlOTUyZEZ1?=
 =?utf-8?B?RjB0czF0TWlJN2lzdG1jSWE4ZTh5SDNiZndUam1ZUXB2NG04dnVNQkdKdVZ0?=
 =?utf-8?B?QkMydVhpTHJqQkxUK1hYRFdENktSdkpDRlBIL2c3UHQ2bDhwS1c4czlTTmJI?=
 =?utf-8?B?ZUd4cFh0S2lGR3ljZGpqRVVzMC82U09uK3dSMk13RXJyaEpDY3E0M2xJdkJ6?=
 =?utf-8?B?YVpWM3FjMHhkcWZ2SS92S2tIVm5ZZjVpU2RqenJZU0FBM0J0ejVFN1N3MUVq?=
 =?utf-8?B?ZkxVTHVBdGZFNVA2U3pidy9QOURKNDByaEVlYXlaMlFwbmlhUkQ3VHNGZTJN?=
 =?utf-8?B?WTV3T010eE1tTmxmZDBEblJ1enZPTHZjdGNiWUozUW5PakpMcm5QUWdMQkJW?=
 =?utf-8?B?ZVI2bVh5NmJkQUpTTnR5S01QZGM2azdvZ1ZwREhqS3BqRUJXYkw3QlFudFRk?=
 =?utf-8?B?QVZwSXlTalBleDVDTkFZWTFnRDNQU0R4ZitNNlc3cDdPd2dkTXVOdTUyVGEr?=
 =?utf-8?B?eUlBYkJEU01iV0VndGVEMFhXQlBuT0pkTjEwRzh2L0Rodi9hb0doQVRCSisz?=
 =?utf-8?B?NzR0RWhFeFpCUm5oZzBKd0RHQnFyMi9lRSs3eFdZWGo2T2xqL0cyQ1VrblJt?=
 =?utf-8?B?Y2JaWGVnQ3BSZ2E1aUkrQ3k5ZFg1dXQ2L1I2U3JtT05RWHY1cE8vNnRLUjkv?=
 =?utf-8?B?Y1hxTHJwaU5RRG82NWd0dVNubnRaVzQ4amt1NkZoYjRQd3FacHRyUG11Tyth?=
 =?utf-8?B?UTNBNHRoUlh6OFlzWWM1QUozRk5KcGNLemVMYkZLUENtSk02OVY0ZG9ybUF3?=
 =?utf-8?B?VUhDSGdyRjVYRjhnc1pVZnNtaTBQbEVoVStDZjhZRmI0NmVYdzF1a21SUTdE?=
 =?utf-8?B?RDlkZkV3TG1xODZvRFNjY1h6YmJERXVRMnVDVUNiWUxLZ0M2dHNUSENkYVFx?=
 =?utf-8?B?TVlmVFdpV0FDcGVtVzBQUkNzcW84QThJVkdLd2ExUkZvZXZ1K2EzL3BLM3Ja?=
 =?utf-8?B?YUNwZnJoTmJnM3dXNVN2QjAxZjY0VlliTnVBNUJwQmJQOGhVWHhNMEJHVFN4?=
 =?utf-8?B?a0RoaENpdXZBSllDTVY4WmlXbDM2YVpZYUxGWlhwT05LT2NVRXZDNXJzUmt2?=
 =?utf-8?B?OHRQNDdYTGtOVDVMNXZocDdaSjBIcC9ySVVqaTRSdE94cXpCT0t0bFljRXBQ?=
 =?utf-8?B?aGYwc2xxeWcxZFVuLzJyYVdYMTRtNUozQ29ZdXNHMk1JOHR2UTJzNzJhZFdP?=
 =?utf-8?B?TVhmcCtsYVM2Y3U2WE1lWjA2NkVmK0xaY0syNU12Ym9qSmY3bUc2ZFZnbENu?=
 =?utf-8?B?VzlYT2VBR2EvRHBzb0FRRjRLazI3RlV3a3R2MmRHOTBSWDl4VlZMSTJTQ3FU?=
 =?utf-8?Q?wisGIvO87yoMutYGPv744G3mo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hu9djMSUTmMCfS6r9I8ph9M+Y5GCfHBsxYKw1kOJGlHVeNvLGj5DJlabBifmVUZOEP+5uFaB5xw7xQyyQO4md227gcbWGtVpfhqhZhcJCFE93iNK/GncojTXdPogoK8cbmH3CUmutwxF99SbvH+rqwfI3yaN2ryz3mrPCWSu7kOmAMzTCMfLfXVyEg8YMLdTvbaWVWDfjbNpuQpGqxGnDiLfACJ4ORLQCgFh55lOaPw0ZnZY8C9HcTLCADLRhDwWUaSXY1qf9bKfwFgF9MX4dzZ06ABTaDf05xtuvUziZV2VuDutgZPkkESSbfJdV0ObGsOFPGo46i3yQPEr0bkF2ZZNb0bnGmV9AddYxQniUEfdUXeipMe2cgI4XKy+wD/Ssk7cLeVavoX1DPGQ5FSnkceS2jmaXRqutRv2um5YgQgc/EbBmRwYG2QTaXtSuwEz0/T3p+upJVaAadN5DblvIt9fRAHa4dBRJ9/+yV1aMyVsn6KKrW4r1BC7jrCNTSJBBNuq9ip7HPNWSXNle3ImRtKj0iEG30gI0Q35/ihgpAtGCi4g379JZ7fgh/MgRauCywJh5rmNldcqSIG6hM5vdCVp6zEGrE514ntHbyTfjvU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ef6e15-3323-401c-26a3-08de05c16d6c
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 16:49:05.8275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3IE162ETKwukBRKIYhHgPaYVAfoA3JoU4Y3mhxTZAWXSz7mAFFTgFkUBXWV7LF2DecvPg6FBiQUrF0gFoPrVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=938
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510070133
X-Proofpoint-ORIG-GUID: k7B4gSzYZsIQMLJ9n1lIuM4QxYVvQGkz
X-Authority-Analysis: v=2.4 cv=E8rAZKdl c=1 sm=1 tr=0 ts=68e5448a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=cTMn-MkfAAAA:8 a=JdO6tjGMDeud4edAWk0A:9
 a=QEXdDO2ut3YA:10 a=07REm91lqynEFC2MfXjm:22
X-Proofpoint-GUID: k7B4gSzYZsIQMLJ9n1lIuM4QxYVvQGkz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDEzMiBTYWx0ZWRfX/sn6YVonqrKz
 TIuMQ7LnIewj4GnOSApZebiJG5yGtGDsor0olV61mX/tPr+5J8YRNPFAy5FOcOv09vw6rmUxb4k
 srDHZdISsSjM86FGX09+yBdZ+6/pgxRlnbbyjnhgLILmoODjXhM2yvB2VD9rXe7ywjcrg2xK6+V
 14bS9ZRZPB3urEjU3vYQ5z6PCao8A1T/KKJmwztXIZGNZG0lTftQj1xrgsm4C4qQ34DCnZEfkz+
 BI+EzMeQu0pru6uxztxrmrzwegIofcE81e6T6YlbXfN9mUqN2p7ARgYIESZaPIuTyNZfX4FKoVo
 dmQXJKjh+T4jpH1VzgauoOvISeent7+44YelOz1sRbKy73Axc/z1g7GVbYmp8ZPUuK6grB4VTiz
 WZ+3FFMuZoSBTRr6sex6+67T4W5YbA==


On 10/2/25 11:45 PM, Christoph Hellwig wrote:
> On Wed, Oct 01, 2025 at 10:36:47AM -0700, Dai Ngo wrote:
>> Thank you Ben, I'll get the spec from the ANSI webstore.
> You can also downloaded the last draft form t10.org, which is always
> technical identication, but does not have the official blessing.

Thank you, Mike! A colleague has shared all of the SCSI specifications with me.

-Dai


