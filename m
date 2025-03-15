Return-Path: <linux-nfs+bounces-10628-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C726A62F3E
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Mar 2025 16:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C378179154
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Mar 2025 15:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC41E1FECAD;
	Sat, 15 Mar 2025 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JCQ1N8jS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ppFIuqA3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BE61DFED
	for <linux-nfs@vger.kernel.org>; Sat, 15 Mar 2025 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742052843; cv=fail; b=HwONuGjGnqDQQWDUEu05RkYKTXYlKD5K5utsfNyS4SAHCyq5QL396GSo+kJmWiqDiTi8lXv5+hGgxZPHh0pgDt+x0b7Erl0SN3vitvjRu7SUSsIOCtvqNO8cU8u0IcPBaEcdVu/Y5OhNchiYe+xfEx86YBEkP9jaUaqshZR9lu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742052843; c=relaxed/simple;
	bh=9TMkz8L8KTTiohY0gnpm0+1frjMCPA2KhrHS96/+4G0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SQPZyhSJxm4oHPuYnCVe3npHz/NeZwOz6pQq44f8d1hzVHxvBha/bUQFz2UflGc8mxy/5o55yT4d6U32d5XkXxe3pgTpUNRqWHx3J/hrTTaX7cDwXgnHhBrvzYhvZdzPjkG3uOuXAQQVE9+Sww6Se9XeadwWh25qw635tGTULnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JCQ1N8jS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ppFIuqA3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52FAvAeO030049;
	Sat, 15 Mar 2025 15:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZULCXSiyh6g+J2OGk/xXDpnYAyOWMkzEJENPL+lYK3o=; b=
	JCQ1N8jSL/+kiWAysp33wrtZYlTx5HeWzLFDAIGl6HdjId3dO2RYiTd1GmOqz8p+
	S449MyCsYRR+6o6QYBC00Mk4I77h6nfpw94Kp4K8w0rOv/Oybvxh15r5G+PH/402
	K6mXkG8ANRstOouddF6kzXjQSrBnKR4o+CxT2RWeUXS6uhoCAraTFljrYhsSUREJ
	wDHcM7e54Z83/MuLg49o2oTX2OqBnPqGz5sqN8ZGvMikQf/KwybWizj9daSxz/Ya
	nDK3/V8DV0qShthAepL9twNQuw60NEIWeLbvAQpSJw9K4Buch1I+XBc2OTrvAWc+
	09BUpnnN0gxSubesMbXQIw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n88cf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Mar 2025 15:33:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52FC9QVi028027;
	Sat, 15 Mar 2025 15:33:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45d005v2wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Mar 2025 15:33:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lutioR0KcRGYoydrgHtx6J411IYFwaUVBSO80RE4xzen/U7f5a8Mht+bygStnQA+hJiOA27+YOAFuiU4wBzT/a4OqHy/Eo3n5IJi4dyKuhcWMKXDFLVnF3M01SBAoou9DHpwUqdUfMWs2ryD+YgzPEAcOvubSXeATz8rjbTwS/ii0zpMDaJAaXCqYmSfb5qDH99TrF0ajhFv+Z8ApZUPlfjpnQUilhPe3XBfdk+DbLVKh0NWpVa8qWk2BHo1l0g8hjJ8ggFllvRlcKotsO+XTZjoIBbCMZigQRNCufUB970u97Hv1bNzKDJ97Z/1bhcqG3rxrSyLCleMH8SD2GcUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZULCXSiyh6g+J2OGk/xXDpnYAyOWMkzEJENPL+lYK3o=;
 b=slnWbsWpIop/+ajI4/3uvgwIQUQ2w7l0NguPp1D0B37QcvOnO8GbrnkZGgjAst9QcaJb4MYQnrZ6303tC5g7dThNGWAUtT0ZEPGEBFSeB6EFwhrudBisgaISOuSDMJ67smHzxQo9eVstBUp4+Q3PpuLU5MZbbwmPI4XhqV/AxegYsWCE5FedWaFDUYangYh0FQj8f8RpHbwveLS7daRvYlMfpSskQneAtmoQlzpHO7AZHYziGoZIwqjaDto8hDXhgV5Uy3dxwuH/c1FebW/MyaWeLq6kVuqXo60kVCsUp0z3OrLaGD3hEL+xUI8+1bnXupJNesQZ7JbQV+LTKmEX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZULCXSiyh6g+J2OGk/xXDpnYAyOWMkzEJENPL+lYK3o=;
 b=ppFIuqA3ZcZysiQkCXMlapWHDSyVyVKYmlwjDdVVXLjymAX81ufTcc2AAu3tVZ1iRQZvNDEhIoAo8iZ8V0K4linAr3Jx2pmu0lLHafESwcvtFYwZy20Frp6h7lqd3cmpEeMq4llNtgBNmsy+GbvVkqaPIYTXkntOsBvLZWQRHYs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH3PPFB6E8A1B1E.namprd10.prod.outlook.com (2603:10b6:518:1::7c2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Sat, 15 Mar
 2025 15:33:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 15:33:48 +0000
Message-ID: <73d2d11e-2d3d-49e8-b8b0-b3387df459e7@oracle.com>
Date: Sat, 15 Mar 2025 11:33:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: GSSPROXY ( for NFS with sec=krb5, krb5i , krb5p ) is development
 still active or is it being depreciated
To: Steve Dickson <steved@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        "Andrew J. Romero"
 <romero@fnal.gov>
Cc: linux-nfs@vger.kernel.org
References: <PH0PR09MB115997CF2D7A117949CDDB375A7D02@PH0PR09MB11599.namprd09.prod.outlook.com>
 <PH0PR09MB115990D120B04F28C93F4014CA7D32@PH0PR09MB11599.namprd09.prod.outlook.com>
 <E11151A2-D253-4F26-BB94-5CDA22FEF1B6@redhat.com>
 <9e7f3d6a-0989-4778-a2c0-ffafdebefa87@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <9e7f3d6a-0989-4778-a2c0-ffafdebefa87@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:610:cd::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH3PPFB6E8A1B1E:EE_
X-MS-Office365-Filtering-Correlation-Id: 384fed75-c4db-443a-a24d-08dd63d6c7a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDZJUlZ0Q090Y0w1dUNnZU1QQTFPU2hrejI5dUs3bmNWM250aEMwemFBK3BT?=
 =?utf-8?B?SXNDbUZ0SG1VRWNjNFhobGlISXRFMTBSOVhOczVSdElXREJmS1RFMS8rZmV3?=
 =?utf-8?B?VzhXRFlrbXpsQ0xQQngxK3ZGbnZHV3pmS1VqdU9meTBhYjZNeERObC9NNVNv?=
 =?utf-8?B?QnJvU1JBeTZ4UGtkYnEzMTFyRDhpM1c0N2x0azUzN2ZqdStVUHZqQ2tPcEFI?=
 =?utf-8?B?dnplMHNCZTJzeG9NTWhPVFhLNVJ6T2luYllmUWtRajRMZWMyZ04yVkh2a3pl?=
 =?utf-8?B?bUsvNmZqbVcyaXdVRDJqSEppcWpqbkxhMGRsZ3JXeUlwSHp5UnIvYWVadHIx?=
 =?utf-8?B?S0RtcWRZQjVZOStidjRkd2tCdWlpT0poUmEzYkt6VitEQjNKOWc2ZXhsTTYz?=
 =?utf-8?B?Y05SR0hXQytSRUVkU2lrc01lOFUwYjVSZ0RqOEQwM1lhTENEREZFZWFQL0cr?=
 =?utf-8?B?RWpRYXo1eFBjZnZMb09ZMkhnUmd4TmxjQ28zUXFsdEhXNHFXU0l3UU9qRXZF?=
 =?utf-8?B?T3VSUVQ1S21yZTVOc2FjajZvYkU5TzVMcHNmSWdyWUVqOWo1NXU5NVVKY1JG?=
 =?utf-8?B?RDJuY1ZLam91bDdJd1JNdUloakdobGwxeU1kQy9Bc2hLTHhJZWx5MGRzQ2di?=
 =?utf-8?B?T1RIVGlIWTliQVpsQ3ZEN0hLbnZGY0k0T2FvT1FWUTQ5VzdaUXhnSnJCeU9n?=
 =?utf-8?B?WWZEeWxZcVVjTldNQmNBQ29GT0twOFNPM292OGpBQ2V3ZGppTDZ6bHBvNkxV?=
 =?utf-8?B?RGh1dks4OUhDT0hqbXBlVURPK1JwNWJPaisvY1hpT0o0OFlZNUdadm9pZzhy?=
 =?utf-8?B?MjBBKzVMR0ZDS1NoN3dVR0tFQkxETGwveGc0VHN3MGJUb2FpZ2ptRmE2cHdE?=
 =?utf-8?B?MVJHQnY4U2ZnZy94c2RxL1NLWFp6VngvaGpXcGtCUWZ5S3N6am1ITWc3eUJJ?=
 =?utf-8?B?V2Jvckg4WnBSa0NIYksxZFZzaHcrZ3RRUG1CNFVjaGpjQ3IrWTRHYUJNSGEy?=
 =?utf-8?B?K2hQNFNDNDMzYWZ4cGZVeWhHcU9ybDFZNG8xQWIva3UvUGhYaUpBWlgySkpo?=
 =?utf-8?B?a3A2Y3NsY0R3bEFJa09vVHBOcXNRTjZOejlrejBDNVYvL09mTk11WnhCeldY?=
 =?utf-8?B?N0JhNjhLMG9rVHFCT0hLUjhIdStKdTJwK1dSWlU3ZUx2M05CNklQWWJGdUgw?=
 =?utf-8?B?ek9tQnRKZDFXWi9BQS9EU0p1WEZJdXppbU52aVl4Wnd0UWNWWWVUMURUaUlX?=
 =?utf-8?B?ZFd6QjUvWEx6b3hOZWg3djNQMkd5b1RXWlZSNHUxSk9XMVp4MFJGc08xQ2pj?=
 =?utf-8?B?OGVESUp5dWtRTUVZeFhtRFFhVk9pSUwrcWovM05vN1hOWlhTaEdzQTJJYVFk?=
 =?utf-8?B?SG01blZFT2JQSGlkKzlYSGdIcVAyaUo2OWgxUHNyZjBZbldaVERaK1pXWjRE?=
 =?utf-8?B?RGRQa2RlNFhXQ2ZmRk9qYUVoS09acHJ4L1EreXhqNXRRbm82aEtxRXM5Nnd1?=
 =?utf-8?B?Umx0K2JZTDlZR2k0bmpPd1BEY0JCaHZEcU02a2pWZU9WZGdrM293amg5Z3lr?=
 =?utf-8?B?c1lSVmNJQzVXVDE4N0tWNDVndTZiZTNUaVNuc1BPbGVtS3BYTDlBMThJajdI?=
 =?utf-8?B?d3VOVkdIbzVNZzlkZ2pvUnI0M1ZRaTFKcTVzamlIQWVMRFVYbGY4ZGNUZXZK?=
 =?utf-8?B?eTRZc2NNa043QzlTNENnSFRnclJ6VHZIWmpmajc5SktsWG9od216aHF6b1Ft?=
 =?utf-8?B?SjBXR0JSaUIwaTJacHg4Sm1rVWlscXY4b1ZjQ2tsUFZ1cnNlQWR2VHFpY0Qy?=
 =?utf-8?B?bEZvV01UNnBkM0FiOWFnakVSWHlYUUVYS1N4YlFzcEs4eGJmWkVKTFlBNGdm?=
 =?utf-8?Q?lY2JB4oyJ8opR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlkvOEtaQkZWaHd1VzljeU9MV1RFaHpuME5EWVlXc1pIbWdOZUhjMGdESnZ6?=
 =?utf-8?B?SVpDejVtVk9zTUQxOTZWUDgwTUpaT3hNd0tYZ3FuU1FMMWNQblFHSWlTQnk4?=
 =?utf-8?B?RnJCU2RzckwyRjBPWlVKc2NqaFJDYmQyWFVYaCt6ZWRvbndXS0EyeHAzamlS?=
 =?utf-8?B?NEJERXBFT3o1VnliRXFNYlUvaTdXdEo5OUhmQ3dkMGgxb2trZHRMMEkxZTA0?=
 =?utf-8?B?OHJXZjdJVkNoWnNrY01NbDR3ZElLQ3JQNGJLL0NGQ1BmSDJiL1crNTZEd3J1?=
 =?utf-8?B?blE4T1VhS1p4Yk5MNjh0SVZNQ3o4Slo0ZmNaT01FL0lSdGdhMWlBYkZha1hi?=
 =?utf-8?B?d0o0YlVjY0dBOXBiUGY5NktKYjRvYW8wUVA4TW1STGF0dFoxVzh1aU1pVjhB?=
 =?utf-8?B?eFdWSnJ5NHJUS0FZMXR3ZkE1YVd0YjN3dUVLb1V2WEhJbE91NndHSTBOUS8z?=
 =?utf-8?B?emRoUHVRWXRYcU4wVGtqZmkyemlWK2VpUy9pbzdQUW9DVkN4cmh0WlM3Q2gr?=
 =?utf-8?B?V09XanBGVFlvbXVUbXRMeU9mTndNVVpJbEFJbEdXd2NCT3RTY2x4VjBteFdT?=
 =?utf-8?B?djJPeDFIVjQ0RFBHYUtDRC9VdnEvZUgwdU1KcFJlK3VvN0phQjBhdThHSElw?=
 =?utf-8?B?b05NK2ZVRUxBbEJLNzBlT2lIUXA4bUpyL1ZYU2hMNnlheWNwQ0phWEF1MTJ5?=
 =?utf-8?B?S2w3cFIycjRZVk00MER1UXFtalJ5WHJiZVhNdXF5RFVWR1pkbkI5UFNOUTc5?=
 =?utf-8?B?T1IrcTE5OVQxejVoZDBVK1pEK1lMdi9hRUg3cDdCQmdPcTdhU2JZeDNtYjdG?=
 =?utf-8?B?YWpMRzVvOEJHMm5WVjc1L3E0Y3RReDNlaVFTOUdYRXBpd2VvZjNoallBbC9H?=
 =?utf-8?B?ZFNJVG5aTTdiQXZJb0pNaWhVZS9YWTcwWUM4VHpmQzUzdy9sdmdQVGdlK3Az?=
 =?utf-8?B?c0ZkV1I1Y1l3MHg3Tm9BWXJwSFl4dWhMMkFoaFFRVDNUb1RXYjRSWTdTYWlr?=
 =?utf-8?B?TUk1ZVdWeWp4eFM1bnA0Rk1OUm5vV1Z3dUUwMnUzbTQxc1lyUXUyZ3J5d3V2?=
 =?utf-8?B?TSswTmNoYXFyWmFrRHliSDRUV0dEUkt1U0pqL3hmYWhMZnZPUEZtQXVHYzZz?=
 =?utf-8?B?dFdlSm5rS3Z3MUYrOGVjdnRXeXpxWHpkUW9FVmdDMGE2Y0MvaURZR1IrVTFk?=
 =?utf-8?B?OHZET1U5enFWaU1Pa1JRTjNhRGlOMEI1cTlwK1dpek1PZEtjNXRTUUtLNXcz?=
 =?utf-8?B?V2padGVQeWhncEJsNzJqR1Ezb1JSdWZPak5hcTgreHIyUE9nQ2pvc3dMNFZl?=
 =?utf-8?B?OG5TaDd2OFROQU5VVmRCVjZzbDM4NXRqblF4SEd1UXQzWVF4ZzF2VFV6SExB?=
 =?utf-8?B?UFNqVDQzNWswSXRaazUvOHloOFY5VU4xSjRyUjdPR0RycXUzRkVXTlRKTHZk?=
 =?utf-8?B?VGZ2NTFSbWI3NTZicUp3dWtMRkR3K3dvZ3RTbVRGbGhYZUFkdGpDTFQ0Tm9L?=
 =?utf-8?B?NEFHSnRDZklpaGw3OGtCbjJQTG94QkxNZmZhWW53QTZmcFdZU21CeDZpRnV4?=
 =?utf-8?B?S0NxQ3dMMGJRTW5yOCt2U3ZId1l3RDZ6aklZak9nU3phUEJKMGlqYWtlSTYx?=
 =?utf-8?B?UlZORUM4ZlNjeGl6TS9NM2xGUmJBM2pWZk1BS1hmYnNUM3BhZ3RGWFFsSWxO?=
 =?utf-8?B?bEIwUTcrMFg0Wk5HZUZ2c1E0aVF4WFpFWmtRaG0xNmU1N29RZ2x2K1JIUWdR?=
 =?utf-8?B?N0x1TEV5eDJ4aHVtN05taUpra3hvVDhUZFRNTlh6ZWJVQXQ0ZDBER2ZRV0Rl?=
 =?utf-8?B?dVNIeGtKZ2FqaUpBZzFMOUFIVlZhUEtiZm5oR1ptb0x1WklWT3Jib0VDdFN0?=
 =?utf-8?B?TmFUNDMyeUVXeWs3ZHg1T0tSU1dDbyt2N0dxdFNrVlRhb3gyL2dKNGtYUUkz?=
 =?utf-8?B?Q1lvZEdFZG84TVk1aXFwNVlzUEd2QmJ1TjhNWGZTUjJpTk9qOWpZYlBGbmdm?=
 =?utf-8?B?WWZrckpqK2RTTWZKUXF5UjRUcWFOOGRjRzN1cDRDdldaT0xVK3BRWkNBKzlO?=
 =?utf-8?B?Q1poMzBUZ2J4K1JjMDNvZXNnZTJOWkZVc2p3bmhpYWo4dnowMjZiRHoxOWx1?=
 =?utf-8?Q?auIyrHKJvSW1WRK90x3XtmHMk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5OsgNaOM+3iZzl3QCOIKBBlEiedDZTlad6tgFUhniy3ZVFUOr2RK6iIzbxhIXj62eJHzGN+cSm9dRP9Mtr2MamBTad95rr9GhS/B7mCE4bx+nrN57dRgzfzi4bepg6f9BJQsylZGBBPLxh0PzN3t8ftDWRVjZR9MJ+0JGd5Z78rgon7vUXh7F37L7yAajJZvfL/oq3oyumXbFrguKPNhlWzL1SrQ/+sZycIkN2rPnGVNtGGyhLMksf60Hz9xX49IfVPPLcOmvftfXtnAvog5ocfZax2YaFa6nwrHk55654IuFbekjjS5t6mAzZgGrikvymhGBOQ2BacUe/zKOOPEiz1JUH2KbjM4MEPfD+vLzpN/7LYvRWUW3JAIcN/1PQtZSHYY7xZYOX9xXRyKRqlQYH9uqy5PafUHHDn7Se/Vk2czIGVa2Fs1Mgnvrb7kaO/bvDfqTxM+HpSRTwIpyxCGnfnMwAkxpPyt8IMGz5KuNm4v45WdBkjuURmufwaE5vEramcwBx7TkoyLNCbnJ3we3ZBiGflCvycgQqZVUVHByAcRkPZDocyIe/yoghYyflO/ZAalpeZvlMcIsNQrMW146bnzTCu3pAmWpeckvIh3O8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384fed75-c4db-443a-a24d-08dd63d6c7a7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 15:33:48.1741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEXd/hb9K3wiuJT6ibTxrixa1YLPt5zPPHqGmSy+jeYNjJ8N+8x4EEMA5K35khTbM5zaBt6NFVh6n+Ycme4WfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFB6E8A1B1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-15_06,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503150111
X-Proofpoint-ORIG-GUID: rW1UczYzr3StwvXKE1PDX0Zrip-Kqx60
X-Proofpoint-GUID: rW1UczYzr3StwvXKE1PDX0Zrip-Kqx60

On 3/15/25 11:17 AM, Steve Dickson wrote:
> 
> 
> On 3/14/25 8:18 AM, Benjamin Coddington wrote:
>> On 13 Mar 2025, at 7:30, Andrew J. Romero wrote:
>>
>>> Hi
>>>
>>> Alexander Bokovoy provided excellent answers to most of my questions on
>>> this topic See: Thread: gssproxy  security, configuration and life-cycle
>>> questions on gss-proxy@lists.fedorahosted.org
>>>
>>> Remaining question:
>>>
>>> Prior to RHEL-9 , in the section of the gssd man page ( under the
>>> heading
>>> CONFIGURATION FILE ...  ....options  that  can be set on the command
>>> line
>>> can also be controlled through .... values set in the [gssd] section of
>>> /etc/nfs.conf ) there was a configuration parameter "use-gss-proxy"
>>
>> I don't see any git history of gssd.man with use-gss-proxy, but the value
>> does appear in nfs.conf.man.  It has not been removed there.  It probably
>> should be added to gssd.man.
> +1
> 
>>
>>> why was this parameter removed from the current man page, can it be
>>> re-added ?  ( apparently the parameter is still functional ... if that's
>>> the case , it should not simply be removed from the documentation
>>> with no
>>> commentary )
>>
>> I'm not sure thats what happened.  It looks like it wasn't ever in
>> gssd.man
>> to me.  Maybe Steve D can clarify?
> 
> My question is does the use-gss-proxy param need to be on
> by default... I agree that parameter needs to be documented in the
> gssd.man man page... which smayhew as sent a patch.
> 
> Does use-gss-proxy=yes add more complexity that is needed?
> 
> Personally I would like to turn it off.

AIUI it is always off on clients, but some NFSD configs utilize
gssproxy. Not sure how you would code that in /etc/nfs.conf ...?


-- 
Chuck Lever

