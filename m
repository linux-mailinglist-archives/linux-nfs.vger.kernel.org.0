Return-Path: <linux-nfs+bounces-10655-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A41D8A67768
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 16:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF8C18938A0
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Mar 2025 15:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2202B20E034;
	Tue, 18 Mar 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iy6GgxAF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nEXTcGjx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A04920E6E6
	for <linux-nfs@vger.kernel.org>; Tue, 18 Mar 2025 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310595; cv=fail; b=V5GxNnSJD9Xfiv3ynA8GQQsZRyhgzols/qE2LAJMlOkP/D/Nx6zUFZ1wfaI3X5ZFqrgEToKnqienDNNWpAY4xBdIdJqWmYIsHHYvv72Lsk5W+m+XGNf1CFUhKKW8tbbEYI0A8LgUFthaty5wQ9BgWPTiC2UQ93uz2X0sPpMjWLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310595; c=relaxed/simple;
	bh=Uktdluj28rW8u/y6syNJpclFPBILqGnLMNzemClhogI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pLpALJsw6OjOEpJ6hzBJLVbDS9GzakWfHpN+Ubaa6J5+xpovkjBmP8eZELUNtIRG94QynEI/pPHIRyWhotzoMlO3yrlPpFgtmmNbFmkZaWXE0wqPbi3KETNf/IObea3UZVoaEZq7EtwGoS/eubX9oubcnnA3oGER7XM1IirR30E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iy6GgxAF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nEXTcGjx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IEgaYC025386;
	Tue, 18 Mar 2025 15:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oKFHAdB1sHG+p1ly3/ubzPQZmSUVOsa07WGxGfeUjTc=; b=
	iy6GgxAFZtxxjv0NuVSoApbwDLJF+Vwd0O8RYdmCcNN1nA0KXxwXQ8npNUB9+JEC
	QCmG8FggxUPPD0lb+6Ce1jGLafs8WoW3g1sspgsu5H21p3/QaZm3Lvj5WrA1vv3d
	6xTgHj+ogCCxgh+SGvFU6B0OzQpe8WsYVJ4wfJKl0XkqDsDb94/I6nTwCd9kS0Sf
	o+9BwThrB0+m+UCVa59IkcDYaHI6Mr2wjNHNqgM4/FuPR5c2FfW+v06GvB66Yn2m
	D54c0thm4JAnN5DUXjFZDqh9lnWexT476xBjA4vPdBohPCTqke/A5EObZqC2fKSZ
	y9FneqIESQwvLOjcsi8F4Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23rwd6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 15:09:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52IEk2aS008930;
	Tue, 18 Mar 2025 15:09:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxkyrnt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 15:09:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRv5MVamPCne08DnEXtQUaF0gZexHXnrC/Iw1T0EMCOQOa+6wNaVVSWr3wPQOEBLrjBy1YhVOFV9DXeEOIv7ERKYD8KWmPLBngC2K632QtpGu068KIQ1V0o/xXIG3L9ryCyKsXIgksRcFLulEHhK1I5tYp7YSw/weQXcvT1+oAoektc8r4z1jAIl/MuFokQ5IxJOQLe8s64cwfYoYAR3WzjZuK4w75L9Ljl4aOdV3ifjXLafJyjWQsUPaTL+e89zWgR3sk+/EUT3iR0MQuJlTVlN28akumVrUsqB5oF2QUe/zznFer90g4k4Z9xvMLuXpQTetv50dVD5HsPMQr3iLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKFHAdB1sHG+p1ly3/ubzPQZmSUVOsa07WGxGfeUjTc=;
 b=lBxIJ6jpoRcW1Z7GzKhiioorvJIihzdSrf1qDDVEwtGAGqJyZeCONR51xpJ7JNlHsqmAqusw/MusQsX6+rL6OONcXJFh4PtltTQokMkooLrUs8oztMn6+kYB+8cRxFOV81EONg+EcBT67OaGrZrEYxsyaZX60qvXRZT/yu5wjxoU1fJ6Yn96B431dZ3Vo+HwUb5Eicnnkiq7oQ5C1Vk8IfuObds9i/MRDZtra1/ZRrAKAFCGuGBkceGjv5VpWmJ544WmPL+woQtbeuH1X1VuiR+zAYB3AnaKHiL0LsY66p/xOlLg2b1xLUMsWcyo+jsC93/xnlXfs4RGT5BuhQrxmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKFHAdB1sHG+p1ly3/ubzPQZmSUVOsa07WGxGfeUjTc=;
 b=nEXTcGjxhX73zYMYLge9WVy0iEB+y+yFI5DW8HfcQAOxhYj1BFqhQ+erl+Lv/SRFVlcupkrwqTP88c+Na5jPkurzLMQTxZpEgwmte0WjVeHIa2dfwz5CePV4bYQIvdQPd8cMsaLlF0pr53zcCSFf0njU4ZQR4kOY2ayjwMfDLZw=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by SJ1PR10MB5908.namprd10.prod.outlook.com (2603:10b6:a03:489::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 15:09:44 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 15:09:44 +0000
Message-ID: <0ea71027-c0cb-436a-8dc7-6f261f0d9e0e@oracle.com>
Date: Tue, 18 Mar 2025 11:09:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting FALLOC_FL_WRITE_ZEROES in NFS4.2 with WRITE_SAME?
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CALWcw=EeJ7rePwqv48mf8Se0B5tLE+Qu56pkS-fo0-X0R3DQ=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:610:e6::26) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|SJ1PR10MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c293c0-3cdf-4bda-2269-08dd662eea50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEVKVzdIWnBJTE5JZHMwQXhPYVR3blhKRjNFV3VZZG1mSkJSejMxd1JPempy?=
 =?utf-8?B?K0dDWE1RYmJRYUNZV2tlOGxOQ3ZHUEJlZXZISjBSRzV1VEwwdENvSzBEQnJx?=
 =?utf-8?B?N2NLbkMyNnNVTndaVFNuaXBaUTlVWldSSjc0Y1JWNjYyM1l0OHltN3FPOUJy?=
 =?utf-8?B?TXREdVpsSmN2SzMrTXR6QXpaZXVmUU5XQjIxU2w4dXY1dERMSmd5UTRRTDdU?=
 =?utf-8?B?bUswT3p0UTFsQkNobkxZb0xReUZvM3JwSXVzNFRpQVBtdnFTVzNpeFpHYmRX?=
 =?utf-8?B?YnZrNjVlbXdkdzhEQzM5NS9pcmUvSlFVQ3M2aU53ZGdYaTB5U1NIM2pWL1Qv?=
 =?utf-8?B?NEVPQTlzZzRnbm1OYVN5MTcxUGh3MThZYVYyeXNOcHl3d1VHK0EwcUd4WFdw?=
 =?utf-8?B?elF2MURLVUd6ZERicktuYk5ubEZDaW9SaVZZZ1VPcEcyWnE3SEFmeDZyQWI0?=
 =?utf-8?B?L0RXaUtzK2VRemdwcjVkVE1vNkZpdXdrVDB3T2JsTEVMZE1uTDVQYUI0NjBi?=
 =?utf-8?B?TkZDcGs0NHlkOVVBTUhNMGdvRXE5WXhRcmZicExlb2IyT3c5bXNodEMwMzBa?=
 =?utf-8?B?Mmw4YVpiTkRDMDFPMUdvdUlsZnMwL0hLZmhwN0ZZUnh2RWRFVWFLSVpBQ2cv?=
 =?utf-8?B?d3Zyems4MzZZZGNMQXVDVjVBQ1B1YnR6azBPWmgxb0VMbkV5eXpVd2doSldE?=
 =?utf-8?B?djBsMnVlOCtOWDJEZjI4eDNKZkppSzc2YlgwNkw0M0JKb3czamU0VlVyZGgw?=
 =?utf-8?B?eW1EdVdsWHlRMGZWT3VkR0lDVnBTMFl3SExEM2VQYjMvRmw0bUtHejI2ZnBj?=
 =?utf-8?B?RFBCbGdrYk5IUkdPc0xHVk5xQitLcjZHYUN6bTlHcWRadVJ5S3RiN0FHV0xn?=
 =?utf-8?B?UWdJbVpiM2IrOWVvME9SQWNtS004MEp5SmxtVFR1WThadERDN3ZYUm4vd0Z1?=
 =?utf-8?B?SFgvbkE5UnFVWVFKdURhNFFNcHllSGRVNldyWVFFdWhGL3NFOTVYQk9Jdjlp?=
 =?utf-8?B?TVdnQm51d1ZNQ2hJdG9Od2lZVC82b2xML004aHYrVjdBV3U5RnhXZkVhV2pO?=
 =?utf-8?B?bWd5TlNJUzUycjdyWC9yOVlLRzhCM1VrRUxVSWRtQWNzWXgydWFXeTNmbVpC?=
 =?utf-8?B?a2MwNmdQRjBBR1dPNFpDek9HSnRDWndzTjl0WXBoT0lhYy96QlAxWWRYSnRs?=
 =?utf-8?B?bGMwSkk5M0ZkendEVDFzbVJTMWsxd1JZenNnSWR6dDZZYkxMS2pvS3diazB5?=
 =?utf-8?B?cVI2L2Jqb1NNazlQeXgvOS9BVldnSnJBL0xUYXZNY2dxZXQ4a2VXUFRJdlFT?=
 =?utf-8?B?ajg3TytwQnRIVjQzVm4vbkpBdi9hc1RQOXNSUkp6UzljMVpkMVRWRDVZRlFN?=
 =?utf-8?B?SkFPWm5pK3JiL2xTQlZIV0FDSzNuaXNTK05wOThTWjhZZDdzZzVGTWxNaGxx?=
 =?utf-8?B?dzNqMFprR0JoM21YV3QvSDlkS0pwTHNTb25hTmZZZG93TTNzL3dOdSswcTBp?=
 =?utf-8?B?R1Z6b2tlOWVENkNVcy9kbWw4aGtjVzFPUzhiekRLaHdaNGFDMnlsM3d0VHpi?=
 =?utf-8?B?MVI0M29OUEluUXpNbzRsK2FTelRLNmY5YWxvU1RHbExMVEwra1JPaDc0ZUhU?=
 =?utf-8?B?ekRRMk8zenQvb0Fhb1NuRFRkWWwxMGFPNVB2RVhWZWw2aEpKdm44WUZQbEkv?=
 =?utf-8?B?Yldqa2dPN0ZWLzBuZXlOZGtMVWRCK0xKc0IvVVZsREZjY25TNUMzT3kxaVE5?=
 =?utf-8?B?Z0pLV3daNVFZVkJTOU0vV1AwOXVKbC91ZDYzUmJTcUdaSStKT1Eza2ljem41?=
 =?utf-8?B?VGJ1QWdvQTA3dkNIT0oxTW5ZWXJDUTM5WmY1SDBweTEvbEpFTEM1Umt6SFly?=
 =?utf-8?Q?3mdQQ+Pc77a1D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnZSYmQzd1Q0ell0RnFnSGwvdHFZcDh5Nmo0VFRSV2Ywd0ZZcnd6d0xjb0Zm?=
 =?utf-8?B?YTF3QXd1emkzU3RWdTd1RFU0czVpTjlmM1lVS3R3YUpHdG1zdW96MUp3K0Yv?=
 =?utf-8?B?cWwxV20rR3JvUFhmU3VZaFRlRG9oS2x1SU5zOFBiR1ZEZE5SQmE1OUs4MlBy?=
 =?utf-8?B?QWJVQUk5VFpXMzZDZU1KdXJQUGc2WGRyRjFKRzJ1Nkp2V1ZEajcrWE94OUhM?=
 =?utf-8?B?dHVZVTE5dU4yMDJXVEtGQUYwM3d3UDZDc1pWOTJZYUtyRGV0Vm1tcnpReWdh?=
 =?utf-8?B?ZVMrVDlkaDlHMEN5ODlTM3ZXakMxdEdGWnJ4YzkvT2xXdlNsZ1ZiVWtCUXc2?=
 =?utf-8?B?MzB5RkpSMVlsUmNHNG9rTXY0NlBLbmF1aER2bGxCQVNvYkJSOGFlRjVaa3Fh?=
 =?utf-8?B?Wmc3VXkyZlFadDBoaUJWMDYrdC8xRkk1bVNsOThVbFJ2OWQ2bm1HZ0RNWWht?=
 =?utf-8?B?WjNVK3oxcU9yd3ZkcEFQeW9YOXNaRDdGVTdtYVVtSmN1eFRXWGdGdnhqYzF0?=
 =?utf-8?B?WUZ5M1IrMGNnV0F1cnN0dm9JcEsySmEyQ3hQTzZFanRWL3hGb21EeGthVTF0?=
 =?utf-8?B?aU5rUksxdFpDY1pwZnBoZ0pvdCtieGcvODVXRGtmWGd1RmNiM2NmM1ZCTWJB?=
 =?utf-8?B?T3RhQzNtRi9sQVZaMVpmVlNkYTZYaUN0cjE4V2lJNHRlUUZ0ZWdDd3haVFhR?=
 =?utf-8?B?bUxaditQTCtOc1JtZDRrb0RXOHZzQ1NSTmtLTG1qMGFvOE5OWlJBVEJzeHoy?=
 =?utf-8?B?RzZNdTNlb1BkOWt3SnZCTzVOMmF6ZjFtRTkxeXVPOXd6ejB1aTgzWjcvNGs1?=
 =?utf-8?B?cmRnYVk3REx0MDRhWEhBUjUzNnZIY2F4dDZlY2JSZUdSU2t2S3BDY2diSFE4?=
 =?utf-8?B?SE1PdWRkcm1NYk4vVStzOG1pbjArUXRPUE5FZktwMGt2L2YwVUk5TmUraWtZ?=
 =?utf-8?B?d3BqTmhSVndxYWYwMzd1Tld2d3lKeGplZmR5UnVuZGxsMnIxN3JzZnVpdXhk?=
 =?utf-8?B?ZVFmNUQ5V2o0M3JMRytjc293RytDVXdYSURINEhqOWN1bXVHdEw1YlQ4T2NQ?=
 =?utf-8?B?MnNKU2FaWkNIQzBjdkt5SjYrb2oveFo2OVpnMnIvNUZEMUxtQjdQOXZGZ1gz?=
 =?utf-8?B?Z2FZTEd6bG5GNFcrcjBSL2VCKzgzR05vdHNZSFRVcDhaSzhUWElibFNNZXNT?=
 =?utf-8?B?ZGVDcXMzVm92TWJHSkNpMnZsT2RmclcvWGluQVdlWk9OekhKQmU5bmdJK2JN?=
 =?utf-8?B?dnpEY3ZDb25QU28rRHBxSkh3K3I3ekZ1Z29mTmtiZFA5S1Jqbkw0RDgvajJt?=
 =?utf-8?B?cm1GNG5EbHVOeVdoNWpVKzdRc2U2aFpsa2pRd29YbExtZEwySkUxZlhZRUht?=
 =?utf-8?B?SHR1bHlQbzF2eUh1VHg0Vy9DMUlYMDJYdkpNMWp3NnlYWGh0ZDFOaXRqUHRW?=
 =?utf-8?B?eDN1akVLNDhxOStKRng1NnpGUlMrVmlLenkrVGFPTEVRWjl4c0ZSeVYycGdY?=
 =?utf-8?B?RjJ6QXZlejd3Nnc4UXNKWi9VVVZXQi80K1N1WWszZXZSVjZaVnZzZkl1VDJX?=
 =?utf-8?B?OUVXM1NvOGplMlFuL3NveVZWUDV6TUFMaWoxZU1abG8xRlhOZXptaHFjd2xT?=
 =?utf-8?B?R2F2emRKUktvZk1RSll0WE4xZ254ZGlnR0oxWkFldlpYMzB2WDJVTUNHUCsz?=
 =?utf-8?B?dEIzam40MkFERGVwV3JQMXFDc0taeVVyajlFcnMxd3QzbzR2S3VhdXRjQS9G?=
 =?utf-8?B?NVAzT2YzSDJjQVJud3F4V1Q4aDMzeVVxVzZQdHNKRzlRN0xXYnE3bkZFWnZY?=
 =?utf-8?B?UzUvZWg4SHJPazlZNGFmMzhpRTdGc2NscHd2dGQ5V1VIM2NiNXowYkM2eHEx?=
 =?utf-8?B?c1loS0d1MU9xd1N2eXF5REJiK1NLUnBjYmFhMmE3Uys0WWx2UmQ5OENQeTFa?=
 =?utf-8?B?N1NjV0o1WkFOcm1WeVpvY05ySVQwM1h0ZnlJMGlNLythQ0FOdXNKTUhlUGdT?=
 =?utf-8?B?aW5GeHRTMmRqc0tHMk5wUTNqYmNDZ0diSjRvVStoaEdZSWp6blpWQ0RmcFJ4?=
 =?utf-8?B?MmlFMy9NZ0ttb2tydkVmVWIzRFNDVzVWN0hZSkZqRS9QWGZiN1hmNzRKUGp2?=
 =?utf-8?B?Y3EzaDFuV0o2dHQwUXlIZTNjNDRNRElBYUNpVk14UkFBQ3FhKzJWUjRMN0F3?=
 =?utf-8?B?elhNRWlqWnU3b1VjUi9ueHBJdXNRWUw5d25FcUs5L3RjWWxmbGEyeVRFMkdE?=
 =?utf-8?B?MnE2blFjVko0VFY5NmRhWFZraEZRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XLC3osm29UA4zqpLeIGdCf7LS1npplccO50koNMMmgp/DFyWHFFAUVj2sIimZ9h+tPONJOO8MG+P/PylYHpweqe4hm1pYMKxYEx5mY8wq4lyFoTFz0c12t4OxzA48waqNi3dCamG+705lMGGZQWP/zNqOYbnwcec9jE0mv81zRqeyWoZfgMIZ5bKc+rZCgIGOCSp79GYV9OdQpSiTXsVWX4sPiOYcCM8YnWaSaiDrBZ3KceVV9E676xy4VNfUtIwlgzO6XJlnGnsj/RUv4fF23Xbyh9n4REyEEdzpmVJCIK4hw5Ch6OPq9LeYvnrq/xn+EPk+fH3xrhiibR9iLjqJccXAyn7WGEUri7YGKwuExSRw2w9sMrqAwJVw+Pbxro7kfUJyww3En1D40Oes44O5aJNjLMMsELODigZ55iu4wWEUffo68Cb8/WBQX9+JNp62Wa5I+9XK8SO7FJTqZJU950abaiGkoW0JiajfExqSJTid2xntpXPjEWE1Vk0aI1iyDR7xSVKseP5aH12CFkO8/5NQchSEElOdQa8LR/00VoqV2CW4B1yTFhcVn6MHuEtFRm7PDkg0ap+27WjA6S2WzMkFpH0/BgddSPUlzrlma0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c293c0-3cdf-4bda-2269-08dd662eea50
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 15:09:44.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ginUkvbvDjdV4MdTiIelnZ9yJG4TunEFDhii1iqznI3z3IjHxPLTyq+o6E6ybtgcgrUybblzqS1MXlUcplwY/6xOJgnFWUdwp4beH5VYq5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503180111
X-Proofpoint-GUID: rSqKrgFYfxd01h2-VmGkY0Mm0t3nEZ1P
X-Proofpoint-ORIG-GUID: rSqKrgFYfxd01h2-VmGkY0Mm0t3nEZ1P

Hi Takeshi,

On 3/18/25 11:00 AM, Takeshi Nishimura wrote:
> Zhang Yi <yi.zhang@huawei.com> wrote in linux-fsdevel@vger.kernel.org:
>> Add support for FALLOC_FL_WRITE_ZEROES. This first allocates blocks as
>> unwritten, then issues a zero command outside of the running journal
>> handle, and finally converts them to a written state.
> 
> Picking up where the NFS4.2 WRITE_SAME discussion stalled:
> FALLOC_FL_WRITE_ZEROES is coming, and IMO the only way to implement
> that for NFS is via WRITE_SAME.
> 
> How to proceed?

I've been working on patches for implementing FALLOC_FL_ZERO_RANGE support
in the NFS client using WRITE_SAME. I've also been experimenting with adding
an ioctl for the generic pattern writing part. I'm expecting to talk about
what I have for ioctl API at LSF next week, and I'll post an initial round
of patches shortly after.

I do still need to think through any edge cases and write tests for
pynfs and fstests before anything can be merged.

I hope this helps,
Anna

