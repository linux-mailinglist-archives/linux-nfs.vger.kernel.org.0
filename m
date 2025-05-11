Return-Path: <linux-nfs+bounces-11663-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 934DFAB2C75
	for <lists+linux-nfs@lfdr.de>; Mon, 12 May 2025 01:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFF53B6C2B
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 23:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B921EA90;
	Sun, 11 May 2025 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qh1Q44i5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VmD8/+vj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A127886337
	for <linux-nfs@vger.kernel.org>; Sun, 11 May 2025 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747007203; cv=fail; b=UZ7cLeKWsCeimsnupVFWJ6hLCtAPAqg9SWcrMBbwaZlykfA902J6gh2vixT3YZ6gSYTbIWUq8mrebJ4oqZ2hMX8WBrgkZs3+SDkxtk34uOcmWEC0pvEvAazf0u0oO7wHc//KF7NBU6nKWx2DxxgMlAxltDKYNr1pGbxjG9MEXYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747007203; c=relaxed/simple;
	bh=arfSh1mUxla+2a7KhNctnDllE3/x2VfG5d/O0fbCZbY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nkDBqmiGM4gGwXHgW3FzwLyBEI4BHuqXe2S+JqyE4wn7X8q93aHOipZkNC+8escKQMKG0Dm/EJ9DV2L9cAjV5rdXxDmyACvQy9kgG5sYitZAb54m11yOyih6bWv2z4GuQzg5lFnUWq0C0SHdmCr9qWwxNbeXOCtTWJ2F4zRb7zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qh1Q44i5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VmD8/+vj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BMj6W7004074;
	Sun, 11 May 2025 23:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=b13ZfhQ/2gTB08Na5+JE/4+6VbcE3OmjHT5qa8l4JTM=; b=
	Qh1Q44i5T7fedfE8hbuOyuW+2DLLpkpTTgRf+oJNML6M+/E0A3Uh41LYTUi7PYj4
	bzxrhYw/QWlTnVVwyfHVabsjJQZ5BdYu/OGmfLK3ZGyR8Ye4fr/QVGDukaXT5tSY
	KtKtoGM9xtI3lSV+Y9gmf5YP65dOevZBKyAWOgNDYe+0FAGo/ndIVG8HePd3XRIX
	+mSugDxHkrNEFeZd24kUQ+lwp+PSE5l+YtvDpgfyLJYAdgHDMFA2biowwMX5TDUf
	0vN1TGkG+D9LK4fw5qFIs0UpbUerhfr1fFPIC4YJfbawXFRJ4rLqY/Pv/1MmMyoz
	5UZay7Q89CNUOIdhg05qLA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1jnhfju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 May 2025 23:46:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54BIZxR1022343;
	Sun, 11 May 2025 23:46:26 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012011.outbound.protection.outlook.com [40.93.14.11])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw87sgtq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 May 2025 23:46:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MckJBUnJmVNofVWHBcnpcK058WdPcOt2XTHJqAnG/66Bm6CfDFNCLqQ8Wp2Pg7R/sv3Eajb2jUpMFwSFliDD7K3ppXQ4LECYR8GElGNXCuiyQTIO3UGTuv83x5E4EPXvLmh3tdfXtTTBmBX5C5ScbSo/KCTDE+BbTWpSLZ1zz0I0+RynRy/kCs177scEC6aVzUONM4zjYwM/zLSbPjAcLIejJ1kpJkVgGwVSAfVIGFnhwrDnUQKGLXcUK9po4VddiAMQ0nuAlSiEEV6AJ7r90PlrUct6hxJqBqMwmbHsp1jH4a0vFDRr7+2sYqg4aaeLCiSt1n7DKTGU7VcTNdsSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b13ZfhQ/2gTB08Na5+JE/4+6VbcE3OmjHT5qa8l4JTM=;
 b=ajB8HLBc83dbeVqia0rKbtkXsemzeENDy7IJ1L5Qj4oQN31Da8Gyh42n0nASjMxeloQRuidVQVULayTyyvDayIWttW4aI4vzFp72pS0U4e5NS+mVQXeIzHpMwtJ3OEtrLqAsROSzFyVvwy2SZdLqJguDOZ7vAK+DS5om8lUQf3UCg/enfZ7jUxRGBpeYPPAfmYuUd8S438Dbdr+xoUeCfw3OvtbvisAx+60EaNgxGL1f0wXZ9IdXm8nX1ACkhliEsqJ4SikuxXvap623VvMcM8GbUj50qUToxhVe81cKVlWyRRikBJFi0AnY9ztNwtYv0BA0gkRrqocYR1xu4ktgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b13ZfhQ/2gTB08Na5+JE/4+6VbcE3OmjHT5qa8l4JTM=;
 b=VmD8/+vjg/WAI8I8BXNjA906WoxmBgYSUOl2VNhwIx3f78YLn/8EK9o8lW8d2Z7hOxOPSirIMzy6hDb1iTBAzZfoURVOClOJ9RXZO2BJ/wXi+qLbZrfkJZy7yFgb0/TInbpNkmz6MIKk7hdxjoMurspWKgS1iE/Y5mdMJMCbLBc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5166.namprd10.prod.outlook.com (2603:10b6:5:3a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Sun, 11 May
 2025 23:46:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Sun, 11 May 2025
 23:46:23 +0000
Message-ID: <d6fa2e49-bfbd-4452-a234-58fbeee60885@oracle.com>
Date: Sun, 11 May 2025 19:46:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 1/1] NFSD: Offer write delegation for OPEN with
 OPEN4_SHARE_ACCESS_WRITE
To: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1741289493-15305-1-git-send-email-dai.ngo@oracle.com>
 <1741289493-15305-2-git-send-email-dai.ngo@oracle.com>
 <ac9d076fb33f7ad5d536ac593a2eb6afd09015b0.camel@kernel.org>
 <2f2babf7-7d70-4c81-995a-1a671590b08f@oracle.com>
 <6330ee2e-eb2a-430d-afe5-1972d2da1bfd@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <6330ee2e-eb2a-430d-afe5-1972d2da1bfd@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0410.namprd03.prod.outlook.com
 (2603:10b6:610:11b::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: fecc97d2-d8f7-4a7e-6675-08dd90e60930
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?endmUWZ1SFUzbEg5Z2o0aUQwRGxxTW5QRWx1VjF5YzZ3dXlXdjlwRVRLRDBt?=
 =?utf-8?B?OWR4U0ZJQlA4ZlRVNXdJbkw3UGhwMGcyOHdjUCtHemVJTEx4NjNTcXYxV2pW?=
 =?utf-8?B?RGFqYlFMdEtGNHF6TWdsT0NDRm8veXBGbytueERDRFUrQm9qL0V4WjFxWUxt?=
 =?utf-8?B?ZUF5ZUZsVnllaW44eXVJK2FwN3ZmSERDcGluQTAvRmFGTTNIanp6UWRMZExr?=
 =?utf-8?B?RFRna0hRM3VIUDVZYmM0S1NkQ1FvWmpVWUlCOTRtSmZiQVJuejJpemlXblNu?=
 =?utf-8?B?UVoyVDVtaGhuZGdISzRkNkdKWmZqQ2pxeVlEamFqenhNa2s1cThqcnUwM29y?=
 =?utf-8?B?RENKRjVENUNzVytwbm5hZ3ZnbDdxVUZtbjRkemN2cFJxYVlRWmRtc1hsMWxl?=
 =?utf-8?B?Mkx0Q0dPZkVhUDViNnFxRlgvOTd6RXBhS1M5RDNOZm51WENHQmlHOUY2M3Rs?=
 =?utf-8?B?Q3ZwNGVqSVl4QmhXbDdyUU5sZGFFNlVTbi9ESTYyaFdNdGRhc1BLcmpqL1dR?=
 =?utf-8?B?bnBZdGxkT2lYd0krbmRmNUIxczlyR0tpUVNFdlRSQUw4c1dSQXA1K1BGNUtI?=
 =?utf-8?B?bk5xdGxhL0pyVk1DMkNuOEMyV2F4YWVmVWp4RDdLeXYxMFpEMDFiSjZCamVo?=
 =?utf-8?B?WWtkenVGZUlRYUVIVFNPSEZPY2s4UGRmZzQvYTdPbnRtUTg5eGg3NkhYS2hn?=
 =?utf-8?B?OW9YeStSdlJ6Qk9kZit3TUlIYk53clFSb3V6QnVIKzJYU0RtMkx5K0FnSWt1?=
 =?utf-8?B?RmdQSHVVQXlEL2FjM3FwWHZZZXpDWWhWcEhIRVc2SWRWSm4xeW42TTUyVDE0?=
 =?utf-8?B?TkxETjFROEJoOFAraEYvUXJ1UjgrVyt4ZTQrYjBhTWlFRk5DQzJDQWxxV1ph?=
 =?utf-8?B?Y3VYQXR5OERxNHRPR21Ob0dReW1seVN2KytIR1JOZEs1Z0JxZkFvLzV5WU83?=
 =?utf-8?B?VGZxRUNvRTFKYnNJa3R2bFNyNHNYM0NTUE4vQWl5QkU4SUwzS0ZxY0UxQmc3?=
 =?utf-8?B?dy91a2JoSjVjYjBEdHBDR1RpUWZsUnA2YzVxOGIwdkN0bHV1VGI3MnpkaFpu?=
 =?utf-8?B?TWlsVWJrRlIzM2xHdmVGeFQ4SFlWTGdZMlpVOUoycnUveXEvZGNaS25yZTJp?=
 =?utf-8?B?WVZTRHlORzJuTUFpYmxnQjBDNWhCNkIrNzJlZ2tvTkgxZlFvdE0wUUhBc254?=
 =?utf-8?B?anZ6RlVlN2ZHNEcxMnZ1NjdacXhCUVRCV2o0bzRPWmErM3cxY0FRVmNTSXNm?=
 =?utf-8?B?aEgwRW1TSGpMckwyeEk1dFZJRGZGVGliT1dqYkdIcUltK3ZuRGQzZXpiVitv?=
 =?utf-8?B?c0ROQ2pUb0xucU9PLzA4aUpOQmJtTmNDRnB1K1B0ajBxcnl0SVpJTnFGR01h?=
 =?utf-8?B?d2E1ME8yRENQRWFEc1FWK1RPQVNTa3Z1WkZoMHBwdkMxZDM1dzNIQ2U2dVg5?=
 =?utf-8?B?UXJBazcydkViQVhTUVZOajFGWTJ2SHpWUUVpWHB2YlFDdllWUGlBa3pHTmZI?=
 =?utf-8?B?bHQ4ZVFDam1uQm44YjVTbkxFaktmSDNySmlraXFpN3dhaXVxeUFxTC9oTkFq?=
 =?utf-8?B?RzJvWjh3RGZHUTdVSmlLOTgvUHZxd3NsQXFrUlg3RXcrQzBLZWFsa1hBZE1w?=
 =?utf-8?B?Y3BYeWI3eTh2WFFGc2phNnNJd2trdmtxVExtUkE1MTRHU0oyb3BNN0F2Z3Fh?=
 =?utf-8?B?aXR3eTM5aXJvN2x0RUVVRVRSOVh6blJjWnR4RUx1WlhPR0lZRy9INEJRa3VH?=
 =?utf-8?B?N1NtaDg4ci84VW1tVThxOERVeHFwV05EeVFYL3lzamxuR1ZoUVhiRWFyalhj?=
 =?utf-8?B?NU1tTzVVQzRnZjZHN09JYXk3TWlrWG1sVjYxSVZ3TWtsZzdDWlpHZWplZmhO?=
 =?utf-8?B?Vm1uNUgxWDZmRStGbitNTmZ1YjJLMDlyazdjR0s3WStFblhVSGVobHA1ejN2?=
 =?utf-8?Q?aI35ZjcQklY=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Q01pOHdVblY5cHRqU09oT3BneTdHQVh6bDUzaTZhYzZITFVzRXVQdFppNnJx?=
 =?utf-8?B?VkFKN29nekZsRXVWMFVxYWt6ZEFTQWN3dXRTVHZLd2hPNkgxUnI1RWlldDZJ?=
 =?utf-8?B?bmhoc2oveTF1VTZVYk9uTDF3b0VxeXRwWFlFMXpSU0czT3VnQVFQcDNwdXFD?=
 =?utf-8?B?RVRzQkt1amcxdUJNUGpRRlYzMDdvNnVjbXNacUc4d1RkTXAzcm03djcrZW9z?=
 =?utf-8?B?SHF6SWdzYnBrMFhyOFVDZFBpRXNVN0k5dHZFM3B5VmQ1eXRXK3BBMVdUWGg3?=
 =?utf-8?B?R1FGV0xCNDNhZ05xY1RhbldSYTVCNTZQTzJTbnNiakpNY1JLQVhLVHIxa1Zu?=
 =?utf-8?B?VVJ5dEExa3JISFJQSEhYMENhRjc1RTVuYlhZQWVveEFUR3Fndk9Vc3FtVVpJ?=
 =?utf-8?B?TkJrU1BZWjBoMTlFcmVVZGNLR3haUlV5azBEVzc1VWh1dmxxTnd6RnVHVkdV?=
 =?utf-8?B?bkg4TUxScml0cXkvdkQ4b0hYTXN5WFpPSytYazJxazBPVUtiK0lER2YyNGdN?=
 =?utf-8?B?MjZyeFh4cXFNdWNRanRwZVJVb1hTSnlLNGVUd1lleEhWc3RPb296ZnRFR28y?=
 =?utf-8?B?NUlwRFhrUDErUkQxNVFWOHgyQUF1V2R0MWp5ZDZlb3hBRkpJcUk3ODJKeTVF?=
 =?utf-8?B?T2x3SUE5Rmxab09WVUtHWm0rOGpZaXdWUHpwQXZsMmM1NFdQd200cG5LdmdO?=
 =?utf-8?B?WmV2ek5aTkVPbzVFUVpVWGtmbUxUeVliVktxeExkMkRzbWRxNmVMcC90WUth?=
 =?utf-8?B?SGFkUFJqeW9NUnQza1MrR3RJRmZXZE4rSXViU0VNdGpOT3lzbWxQdVZzdGpr?=
 =?utf-8?B?R21nNnpYNm9rOXREdlgrTG8vZkFEeFVwdEF5RXRzRTZRN3hrYnZndmU0dFhp?=
 =?utf-8?B?bERzNkpnbk1NL01BbFhST1NrcldXNHZ5R0thZnBkc0cxQWVoQWw1SWZUc2Nr?=
 =?utf-8?B?N3AvOGJCNU5sS3VINTdKdGRDSTFMTGlkeGVWQnlXS1lxK3A2TkdTbTV2ZWdj?=
 =?utf-8?B?OGFrZHZPSGlPdlZjbUhyT3IyRG1RemthbG5xSStQa3ZpY1FhRzJMZ3hKd3lw?=
 =?utf-8?B?OTN5UWlyWlRUazBlb3RqNXpuYlFkSWlSdGk5RHp6bmpZajdZY2xoaXExUXJq?=
 =?utf-8?B?THB0bG1xUXJvYm13RWJSc1hsUjEzN2R5UjNad0NySmh6czdENkIzMytDQmVm?=
 =?utf-8?B?TTcvQ1BkU240R1UvNkhKbEIxanpPbUlIOHlGcXJTcU1aSzF0dmt5VEJoaHVl?=
 =?utf-8?B?cUJjNDJmRVcyRTNkTjVnM0ROaGc3WmN2STkrU2kyWm5IU2FzTkphbktMWDZ3?=
 =?utf-8?B?d05zVWZWK1R0Tjc4Z2dzbkdHRk1OTzhIcUV5eklEM1Q0ODBjR3phdkpzYi9s?=
 =?utf-8?B?QVE0dzY4M2x2SlZDejVwNmtNSHg4dFBBZXhUWDZiZWRQVWp3VEZlSzJnZWNN?=
 =?utf-8?B?dWFISHhhSVV6V09RQ0w5MmJJZDBSN1ByVWZRUlhxWXcxcFVuTWpKL2hQclkv?=
 =?utf-8?B?MlhDNzAvSWlUUDEwNExYSXpMN0EzYmkwYks4N2ZnWWJzV2ZRQ3Y5YjB2WGlJ?=
 =?utf-8?B?RUgzZjhmUnFHdU1yYnZHMXpjVHhMQ0JydkFEK2JlSDg5SEhEQlBHakhxSm9H?=
 =?utf-8?B?VEVvTFRMVURTek9XWkN4UHZBcEtGeGM0M282NTVMYlNjeWNnZnltSXQwYjlm?=
 =?utf-8?B?ZndwbUNreHh2ZFZkaDhOalNnbE1LWmxXRWNlWDRhWCs0empOVmZjOS94MWRS?=
 =?utf-8?B?VS91aTBkK3ZJQ0ZOVzc1Tnk0OW1MeGtSdHlJc09Zakc4QkFqbEsxNExlVWhz?=
 =?utf-8?B?eTNaOTJLdGtjTWIyQVozTjU0WkJWUEFMRktKRThYckk1bmtBT0lYZDVqK1l5?=
 =?utf-8?B?bVdndG1zV1JSSU1MUW4wYVB3Qjd1ekx5L2g0WWMxUHdUUmdaeE5GMGVwNlJF?=
 =?utf-8?B?dk91SmgyQy9SM09FbEZscTVKQUw2QzlOVmRzTjdkMlpNRGhDMUNURWN2dVVi?=
 =?utf-8?B?Q3lPbWdVZUlNZ1pibUNYa3BITlVlKzhPWDR3WHRucXgvZ3g2ZXExZGVzMGZU?=
 =?utf-8?B?YUpTdHBTTVordzl4Y3dHdCs1MHEvOEJIamsva1Y2T3UzWmpMVDIrbnkwckli?=
 =?utf-8?Q?19oHSWYLGj9mIXwPMzE8nlYMm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lt25URbi35/0X5jwKA1TOdR2F0APNKwJ0o2f/a0MClKOG2JRPG264cvYCoZk5djS2BMNKDGiYMGXmz0WGsXWfyTwXkC7wNfRcpJEPXaUKq134NFLiKH++wZWoQ7TihNARwhZF/SwT8gLxMMIgOrjdyTE6V6TvyRaOTbTRUkCufSYUXOGrRfJD9S65ExVSgFnihAX/mSvj4sFaAqXJsEH78JqEclw0KPfU/thIQFAg+Cmcg0WzV6m/UKMDey/K71WgHAZrRbRiDYwXEO+zVGqUR0KcVXiEy+IjlE3n+hA9jPOlCb27RiPjC9DdhBxvj5uWqynOJyve1Qjd0hcsPdEjb0cNdlXDJV70kPdbnSEKDIvzuoCCOdxKWG/IIjx4rykrmlGFR5lrJT4W/N2RWDh04m+mnm3ZgZoKZLzT3quwC+2KIwXA8vuqoayjVxrGbrYwskzvwl6Ax6PqfmmU6wDLiwHs5OVm84VcGuGFp31mGUn5uK36CbTZZQPNjHE1mswzS9IBUVzSVhZ1mO7LlZOsM7E5t8ktOP130cq9he/W4Y1nQ0nRxVCrWoQnlji/MqQH0UKgrbZxRKf0YScQe8vjVcEzlSDforxCMdDdqrA3EM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fecc97d2-d8f7-4a7e-6675-08dd90e60930
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 23:46:23.0186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tg+CF5dFRTMDh23kdKrb/MxX8uZxEyV+V6Wctg3ex8m6NSQySKL/cW0NlxY0cVTAalpp9qmic+1en+zTl4YRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_09,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505110254
X-Proofpoint-GUID: jOolfTXKeAmoEC9dCDFh51O1KM2fWIPx
X-Authority-Analysis: v=2.4 cv=PeH/hjhd c=1 sm=1 tr=0 ts=682136d3 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=aF4jd-Ga_H6U_O7PMakA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTExMDI1NSBTYWx0ZWRfX2k26ouwIf8s0 qNJjlWQjySiDThEIJu7GVsJKMFustnHCceHtRRCWAhrDoMn3retzOfQnZ06mOq8sVBEmEzMCAIc BDhHLiu4r5y7QjEKr3ikEaXl4XH8ovfeJOCRtNDd2BuX2Jgz5PijD7fNg6/NPuxMRA3xbTtRqKo
 WgoM49+zz9PghSqaoC516qfsAbrazE/OoFOQ9qcBOVD6Hp2p/tQ0QJ1fQBFXlZyWYXJFXh+C8KD LJPvql3tWWbTNE0sEMqfzXKs7aiZfY3eaDtsrZ0jEVo4HCqeiq7BRqVFyZpGszkZ1M/vLVuF/6T McsrVhg0OuUulBFM9Ct3tMjKCg5y9Hd8gfOBXz+xLJBdi6oTOg7YCmd71nCLSrYx/Uo/j+uHBhi
 Ldj08ZkgZU7Fx2VCn5OvNd7lvo9gtPSavB66YfjNSdhrDWkv/eynSiXVZcW/Y90xX4UPKUkh
X-Proofpoint-ORIG-GUID: jOolfTXKeAmoEC9dCDFh51O1KM2fWIPx

On 5/11/25 5:13 PM, Dai Ngo wrote:
> 
> On 5/10/25 12:23 PM, Dai Ngo wrote:
>>
>> On 5/9/25 12:32 PM, Jeff Layton wrote:
>>> On Thu, 2025-03-06 at 11:31 -0800, Dai Ngo wrote:
>>>> RFC8881, section 9.1.2 says:
>>>>
>>>>    "In the case of READ, the server may perform the corresponding
>>>>     check on the access mode, or it may choose to allow READ for
>>>>     OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>>>>     implementation may unavoidably do reads (e.g., due to buffer cache
>>>>     constraints)."
>>>>
>>>> and in section 10.4.1:
>>>>     "Similarly, when closing a file opened for
>>>> OPEN4_SHARE_ACCESS_WRITE/
>>>>     OPEN4_SHARE_ACCESS_BOTH and if an OPEN_DELEGATE_WRITE delegation
>>>>     is in effect"
>>>>
>>>> This patch allow READ using write delegation stateid granted on OPENs
>>>> with OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>>>> implementation may unavoidably do (e.g., due to buffer cache
>>>> constraints).
>>>>
>>>> For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_WRITE
>>>> a new nfsd_file and a struct file are allocated to use for reads.
>>>> The nfsd_file is freed when the file is closed by release_all_access.
>>>>
>>>> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>>   fs/nfsd/nfs4state.c | 75 +++++++++++++++++++++++++++
>>>> +-----------------
>>>>   1 file changed, 47 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 0f97f2c62b3a..295415fda985 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -633,18 +633,6 @@ find_readable_file(struct nfs4_file *f)
>>>>       return ret;
>>>>   }
>>>>   -static struct nfsd_file *
>>>> -find_rw_file(struct nfs4_file *f)
>>>> -{
>>>> -    struct nfsd_file *ret;
>>>> -
>>>> -    spin_lock(&f->fi_lock);
>>>> -    ret = nfsd_file_get(f->fi_fds[O_RDWR]);
>>>> -    spin_unlock(&f->fi_lock);
>>>> -
>>>> -    return ret;
>>>> -}
>>>> -
>>>>   struct nfsd_file *
>>>>   find_any_file(struct nfs4_file *f)
>>>>   {
>>>> @@ -5987,14 +5975,19 @@ nfs4_set_delegation(struct nfsd4_open *open,
>>>> struct nfs4_ol_stateid *stp,
>>>>        *  "An OPEN_DELEGATE_WRITE delegation allows the client to
>>>> handle,
>>>>        *   on its own, all opens."
>>>>        *
>>>> -     * Furthermore the client can use a write delegation for most READ
>>>> -     * operations as well, so we require a O_RDWR file here.
>>>> +     * Furthermore, section 9.1.2 says:
>>>> +     *
>>>> +     *  "In the case of READ, the server may perform the corresponding
>>>> +     *  check on the access mode, or it may choose to allow READ for
>>>> +     *  OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>>>> +     *  implementation may unavoidably do reads (e.g., due to buffer
>>>> +     *  cache constraints)."
>>>>        *
>>>> -     * Offer a write delegation in the case of a BOTH open, and ensure
>>>> -     * we get the O_RDWR descriptor.
>>>> +     *  We choose to offer a write delegation for OPEN with the
>>>> +     *  OPEN4_SHARE_ACCESS_WRITE access mode to accommodate such
>>>> clients.
>>>>        */
>>>> -    if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>>>> NFS4_SHARE_ACCESS_BOTH) {
>>>> -        nf = find_rw_file(fp);
>>>> +    if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>> +        nf = find_writeable_file(fp);
>>>>           dl_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG :
>>>> OPEN_DELEGATE_WRITE;
>>>>       }
>>>>   @@ -6116,7 +6109,7 @@ static bool
>>>>   nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh
>>>> *currentfh,
>>>>                struct kstat *stat)
>>>>   {
>>>> -    struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);
>>>> +    struct nfsd_file *nf = find_writeable_file(dp->dl_stid.sc_file);
>>>>       struct path path;
>>>>       int rc;
>>>>   @@ -6134,6 +6127,33 @@ nfs4_delegation_stat(struct nfs4_delegation
>>>> *dp, struct svc_fh *currentfh,
>>>>       return rc == 0;
>>>>   }
>>>>   +/*
>>>> + * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on OPEN
>>>> + * with NFS4_SHARE_ACCESS_WRITE by allocating separate nfsd_file and
>>>> + * struct file to be used for read with delegation stateid.
>>>> + *
>>>> + */
>>>> +static bool
>>>> +nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct
>>>> nfsd4_open *open,
>>>> +                  struct svc_fh *fh, struct nfs4_ol_stateid *stp)
>>>> +{
>>>> +    struct nfs4_file *fp;
>>>> +    struct nfsd_file *nf = NULL;
>>>> +
>>>> +    if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>>>> +            NFS4_SHARE_ACCESS_WRITE) {
>>>> +        if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ,
>>>> NULL, &nf))
>>>> +            return (false);
>>>> +        fp = stp->st_stid.sc_file;
>>>> +        spin_lock(&fp->fi_lock);
>>>> +        __nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
>>>> +        fp = stp->st_stid.sc_file;
>>>> +        fp->fi_fds[O_RDONLY] = nf;
>>>> +        spin_unlock(&fp->fi_lock);
>>>> +    }
>>>> +    return true;
>>>> +}
>>>> +
>>>>   /*
>>>>    * The Linux NFS server does not offer write delegations to NFSv4.0
>>>>    * clients in order to avoid conflicts between write delegations and
>>>> @@ -6159,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegation
>>>> *dp, struct svc_fh *currentfh,
>>>>    * open or lock state.
>>>>    */
>>>>   static void
>>>> -nfs4_open_delegation(struct nfsd4_open *open, struct
>>>> nfs4_ol_stateid *stp,
>>>> -             struct svc_fh *currentfh)
>>>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
>>>> +             struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
>>>> +             struct svc_fh *fh)
>>>>   {
>>>>       bool deleg_ts = open->op_deleg_want &
>>>> OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
>>>>       struct nfs4_openowner *oo = openowner(stp->st_stateowner);
>>>> @@ -6205,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open *open,
>>>> struct nfs4_ol_stateid *stp,
>>>>       memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid,
>>>> sizeof(dp->dl_stid.sc_stateid));
>>>>         if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>> -        if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
>>>> +        if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) ||
>>>> +                !nfs4_delegation_stat(dp, currentfh, &stat)) {
>>>>               nfs4_put_stid(&dp->dl_stid);
>>>>               destroy_delegation(dp);
>>>>               goto out_no_deleg;
>>>> @@ -6361,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp,
>>>> struct svc_fh *current_fh, struct nf
>>>>       * Attempt to hand out a delegation. No error return, because the
>>>>       * OPEN succeeds even if we fail.
>>>>       */
>>>> -    nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
>>>> +    nfs4_open_delegation(rqstp, open, stp,
>>>> +        &resp->cstate.current_fh, current_fh);
>>>>         /*
>>>>        * If there is an existing open stateid, it must be updated and
>>>> @@ -7063,7 +7086,7 @@ nfsd4_lookup_stateid(struct
>>>> nfsd4_compound_state *cstate,
>>>>           return_revoked = true;
>>>>       if (typemask & SC_TYPE_DELEG)
>>>>           /* Always allow REVOKED for DELEG so we can
>>>> -         * retturn the appropriate error.
>>>> +         * return the appropriate error.
>>>>            */
>>>>           statusmask |= SC_STATUS_REVOKED;
>>>>   @@ -7106,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>>>>         switch (s->sc_type) {
>>>>       case SC_TYPE_DELEG:
>>>> -        spin_lock(&s->sc_file->fi_lock);
>>>> -        ret = nfsd_file_get(s->sc_file->fi_deleg_file);
>>>> -        spin_unlock(&s->sc_file->fi_lock);
>>>> -        break;
>>>>       case SC_TYPE_OPEN:
>>>>       case SC_TYPE_LOCK:
>>>>           if (flags & RD_STATE)
>>> I'm seeing a nfsd_file leak in chuck's nfsd-next tree and a bisect
>>> landed on this patch. The reproducer is:
>>>
>>> 1/ set up an exported fs on a server (I used xfs, but it probably
>>> doesn't matter).
>>>
>>> 2/ mount up the export on a client using v4.2
>>>
>>> 3/ Run this fio script in the directory:
>>>
>>> ----------------8<---------------------
>>> [global]
>>> name=fio-seq-write
>>> filename=fio-seq-write
>>> rw=write
>>> bs=1M
>>> direct=0
>>> numjobs=1
>>> time_based
>>> runtime=60
>>>
>>> [file1]
>>> size=50G
>>> ioengine=io_uring
>>> iodepth=16
>>> ----------------8<---------------------
>>>
>>> When it completes, shut down the nfs server. You'll see warnings like
>>> this:
>>>
>>>      BUG nfsd_file (Tainted: G    B   W          ): Objects remaining
>>> on __kmem_cache_shutdown()
>>>
>>> Dai, can you take a look?
>>
>> Will do,
> 
> I found the problem, the nfsd_file added for READ did not get freed when
> the delegation is returned.
> 
> Chuck, do you want me to resend the whole patch plus the fix or just the
> fix? I'd prefer just the fix to make it easy for review but it's up to you.

You can send the patch and the fix separately. I'd like to squash them
together when applying them to nfsd-testing.


-- 
Chuck Lever

