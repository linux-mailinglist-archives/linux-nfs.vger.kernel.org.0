Return-Path: <linux-nfs+bounces-21470-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MYuJ0bmAWqKmAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21470-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 16:23:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3931510099
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 16:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE453300FCF1
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 14:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7787B3FB07B;
	Mon, 11 May 2026 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JTiZjcnU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nxUJ51QH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEEB3E63B8;
	Mon, 11 May 2026 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508537; cv=fail; b=If742UCg1GUxfL8VWimD+UidHTWvYIJsSXftkLmeQR0mnW09sgZBM6fzPRWDRdAluYR58li9hFz0xhhTlOAxahEJpATCJfzVsmVFTYCgqrFlCeDRzUs4sRm5GgY/Hij31fQwOvVMaV6wTE0i/KSN60JWvTbqAv77yAqEdFWMUng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508537; c=relaxed/simple;
	bh=blT6uVbi9NMS4Qze0nqZcoAXIJziLqcOzPxhOwPI5EA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dBq+LaaivIikITZOsJUNmO5yoCdRUT81z0Q8jT57pps9oJ7+KKdwoq8VIdkH2mx0TsbyyD4JwCtXezC2QViWIzrm6wFlNREeaIOHBcErprAeEpr1OfpEh48H8qYXHudMGRzWlYHQRNgYCScftlQTuY0LH4LfliA6TWdt6mZYdjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JTiZjcnU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nxUJ51QH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BCWNeb2281820;
	Mon, 11 May 2026 14:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YuyIRMIapXPMowHDVqA3paHY7Zs9Ksk85WX3AmTiJqU=; b=
	JTiZjcnU8K8cFMKxRqrtk/AvYOZHWQl+3wOOhHtK0sjiZlo3IovLzIisDfowhXWD
	VqKM+6ufmu4VZ7w3itMmcBITHG5NqxzNdD7XCd8U68jXxPVIORuF6Dq30Da1P2sL
	TGvi8LETcC1hyVjQNIbQzXF7QcFhkPaIrnSc6MfmCFPNB9WdEmQ2o4h4TYjsMblv
	FtxCMJlnXbglh0ymB0cEGO84gQk2qotn3a4JGlAxRW6fOCPfVuu+4O8rqTgwHA86
	l8EoaNTLjHtX0KZHblglxkY43JZ1IC01rTDcVCu1ceW989akLjHTRG7kU4dzkqGS
	djE6aXbBkux4gJ/SF6MS3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e1vt72r9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 14:07:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64BE6S5G010375;
	Mon, 11 May 2026 14:07:54 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e1uckhf27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 14:07:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKl8zBMb67tEcMIm01IgCqH1xx7/hBpleH5MBPOWa72K5ATATOEg/lUgM2NEkJZHHBmldrac7azEcxW1vmluQUxlflEvsWh2/zX3MM8U7c/1IMy6ptVwDLt4aFUmnO/3JjPztChnQAaK7rMwd+HoKn2crb15T1y5a8Lu2AHaLmLuBpSQJVd8OMgBz1+1p/xowzt495C91E57Qm3NnB47vyP6p5G5zT7QdQRliEBORc4y2II2jcWWEDIAFVi6gt4y1CAmif+BQ2bg8IGXLTd996Zx9iFLXbxPhhV5nmclbXkFHaLdVxTbLxUNk/T7EengrZ1G+rZFirtiAcZPlaxozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuyIRMIapXPMowHDVqA3paHY7Zs9Ksk85WX3AmTiJqU=;
 b=apRrYjp8gr6xpTUogwDcqnRtGBasnyP6WcFxpq0u25eUZQlF6QksNhUplwvGOSMPQVWwVD2Pfp+6qrcsIoNTbP9E8aO6ZDQkot0c4Y1J8r6jL+81BI6AnQPvok/j8ShtuwKeNiyWg/lzsrqINTMcS8wCoQNbjgdsSdZAJNBtJ5bT22p7+9TKvCDgOYxKT3cJ2INh95okRp5XiZuFwLkjbquBSb4HWnyJgSC+JI6hvGgoVBWd0iKIHj1zVjnFB/AW+2HxUFmUlsyzcMPP9MrTK17KEw6LlR1PRQwJfRNK3Yz/II31/PHq1rHmCn//MbgSrIi+zvW6aQmKnj1kaACo6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuyIRMIapXPMowHDVqA3paHY7Zs9Ksk85WX3AmTiJqU=;
 b=nxUJ51QHFSlIs17Q/ynwj7dgn+LcK6eeZkwyu48qiR9KlT/WIw3PHKcbuPrsY6bGOCkIHsuQOF6jV80Mc75rtCjL3jhlY2BWToKRoGJqLOWlTKyLyc2qbMQWfBzz+ICC1dbFRtQsWOmK3tAVlaRumrxcLdMb7pViHx0i1jWCJnM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6291.namprd10.prod.outlook.com (2603:10b6:510:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 14:07:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 14:07:47 +0000
Message-ID: <705e1769-6a5e-440d-bf50-5e5feec2b88d@oracle.com>
Date: Mon, 11 May 2026 10:07:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/15] Exposing case folding behavior
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
        linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
        almaz.alexandrovich@paragon-software.com, slava@dubeyko.com,
        glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org,
        pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
        trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org,
        chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Roland Mainz <roland.mainz@nrubsig.org>,
        Steve French <stfrench@microsoft.com>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
 <20260511-wertverlust-vorbringen-070f016f3bd4@brauner>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <20260511-wertverlust-vorbringen-070f016f3bd4@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cad1066-d5ef-4c2b-4265-08deaf66ae00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fdV2o7+WZ/5/4ov6h1nxS+qfLOno2qTLJzt+GZQF//ZgE4dm0GuEqdP8/x7nay3QrcCzRjyV/5ofW4keFfLpWJTxWx/lII0tIsz4CfrtSLO+T3jhKW+DBk9Xz5lWGa6gTxtooZ4hXPPn+AzHEMs83wbu+W60U/ksBQ6dcR3+0rfjjEOZXH/1owYaOHB7XJixD0FFoZj/OKNULvrwA8/vrtGr5QUIrrF2HmjvlmcdKjxiNcVAxTKi8cAeJNlrawANRlekioROSvEQ8p3AW3/J36UsR+Xhj+j1iuJKh8Yu5hZSiW7X+/kFG0DuNkVqp0+fb/D00QsCq7MaPcL/kVR62pbdGmXF1VMmRwW2npjGtZ+VBMk1JFGukhw8GppuxeuP0ecb8JzdHQfvpPAe1DGsEgoJDXbdxnokK5Ip8n6rAi8thmchquXLm3ldD5JIuGRSFj+z0Z+uUo8wt4Sywzi/9QHQTuTBfW3cjcBD0XFFQ+MbssgkOERp+islUeiZg1NnZp3D3DKrZXeAF8eLZdtbIbDsJjC/rNyrrL+YvlU7APGW3Tss2L2eQyWkIQSaQoX4gztVwyVYH0pQxv9oWgROlQY5JTqTeUbFL/NKQnItJG5ZmsHnIpo4W6PiQ0IZYxu4MCxE/a4TbU+xcvZfCZVOKA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU9ob3lDVGhodFRpNnAxUjBTYWFPMTMxWGZ4UytCamJFV2RwNUFLUTBXM1JL?=
 =?utf-8?B?RjBBbU5PaytFTmJIM2lBVjM2ZWRxcGIzRWpSZVBYSmJLSFVGNXU4YURIeHpj?=
 =?utf-8?B?ZGlIanJCWm00LzNMTlVCUWZWNks2Wm5Nd1JXYXNTamtVeVlzMk9IaWxyVnJn?=
 =?utf-8?B?b04xWUJwYnQyU3hFY0pzQWMyb0RUWHFuQWJHN0dCYUdSOTFJSDFKTVpORHlv?=
 =?utf-8?B?WktLRFZhak51TWRQOE9OSml1d0FQalhoODJMTjQ1dUVyb2orL0grWXVRSmxo?=
 =?utf-8?B?eFk1enkyRzVJOVcvWFlwRTdXQU50NWFKaDlLNFQzcGFka3R3OTdOTkhZdXVm?=
 =?utf-8?B?Ym41Sm9ZTFlZSHpodmlwK2psWEZLcnRHVzlvbHJuV3pMS1FTcnQ0SGxZeGFC?=
 =?utf-8?B?amZPMFgwM3N4Sk1lcHdZWktFRForWS8vZEpYdG42UktmVm42MzB4K2l3ajk5?=
 =?utf-8?B?VHpXQ0NRODltSE5CKyt6dEFXZDB4WHlxcWJZUy9rRWVtRVZmUHlTL20wWjI0?=
 =?utf-8?B?aE8rL0pCY2ZpeEt6UjJqMVZGb1VtZWxoOXU4L0RNdTZ4ZVdSNGcrTTV2aFZ6?=
 =?utf-8?B?NURYZzBVUzZCOUJxSzRGcU9Ba3oxRWcwU091UC9YRlhlMDdXU1FPTk1FVEJ2?=
 =?utf-8?B?SEpUWWtnNExDZ1hHTmo0NzBxRldQQXZqcWdWKzJyUUJlYkRUa1RGMk1nbW55?=
 =?utf-8?B?YlNpMytuelo5OTVHYktYL2hjRlpMeUJvbXdlZ2MvZVBpN2dHWWxnZnhwMWdt?=
 =?utf-8?B?bEFMRVViSW5iWitQV2c1Y0FTZ0xVUVJJN3RTVVBRZUdlY3czcENFUVlRdVJ2?=
 =?utf-8?B?bWYxeEcySEladEtYN0RaNXVJeVdkbTlGOXpuWXlPNU8xVmNHenQwbHkyWllV?=
 =?utf-8?B?cG44QUpReGJPUXIyNDZxRGpORzlxRE45SUttd0p0cmZmRlVqaG9Jb2Q1M0tJ?=
 =?utf-8?B?L2czSjBVNGM5TTlvMGRwRVN6RDI1QkQvbCs2czQ4YVdaRVdwUDhlL0lCeVNJ?=
 =?utf-8?B?aSthQ0pkZ09uVEd3VGVTS0ZWNXpaZmhKUDlJQjlsdlJxVlo3dEhDRGtaVVlE?=
 =?utf-8?B?dE4zNE1TYUVLMWZNcXVRZGl2d2swNEQrMWpXa2JVbWx2NTZncE4ySXZmUTZn?=
 =?utf-8?B?NVdySk0yRHY1T3lKUEcvQUM3QTY0KzJZemdwVWl2OTNWUjBVbzBQYnZHYW9a?=
 =?utf-8?B?bHFyMFpwSXFreW1nNjNvMkNyL0dnQVh1d1o3RFh2Lzc5RDRaZ2hlakg4NUVu?=
 =?utf-8?B?UzdqWk9zUFFVcmkyb3RqYlBjVzZDTVJsRk50V1hmWk15TTZxNlM4bGNTVTZU?=
 =?utf-8?B?QWoxVE1taTJaNDJaRHMydGx4N3hKYmZLdVZFV1E0NnFrOTlOemlmWjY0NmUw?=
 =?utf-8?B?NE5wa28yZ0lnUDB1dlpzSVp3YjMzZmxiSjVOcnZSeVZ4N1FBYUZ1cWkyZXd1?=
 =?utf-8?B?ZHJNdjhSSTlPVFNjNDFXVTNkLytvOXNDTXVSN3ZlY1JUMGVzaVNvTHZyOGRD?=
 =?utf-8?B?TU5mN3h5N2RpREFPQnFJNGhiT2xrNldUNS9RMG1VMDJEaEFtaStXQnBia0l6?=
 =?utf-8?B?VDM3ZE4yQi8vdWN0bmM5S0pwam9yYTBxL1YyNjRCRGxnYnVQcWo3cGVIVXVC?=
 =?utf-8?B?Q1RFTlBDcmFzUG15UDBXd25nSm9lTWpjZFpUSXBEdjRCa1I5MGwvaFpTNXVM?=
 =?utf-8?B?MllNeE9BT2hCWW9RSU5DNHBWeDlySmdDODNOUjhXL2xoRDNydmgzS1lJZndX?=
 =?utf-8?B?OFRMem1rVDBVNzU0cnIyN2hHMmkyYVY4TXJhZm85eGpKQURzQ1JYS1FtNU1H?=
 =?utf-8?B?R2hmb2pXZ3MydkRORWdqVVovTzlKUWNMdHBSMHRwQ2xvM3RsRmM3V01MQ2M1?=
 =?utf-8?B?WVdPOXQxVnhyRnlVMVZuSHllVVVrZUlUZWtNSW1BWnRxT0o0ejRKLzlJV20r?=
 =?utf-8?B?ajNJWW01b09PVFNKa2JtTlVJV2ZrQTlTRDlZSTNyQlFLaHdSUUZJdTVHYnM5?=
 =?utf-8?B?VklwcVJaVGRjTCtnUnZHY0JMTXcwUXZ5bk1EYTlEU3JXZ3NvT2N4SUZKMEhz?=
 =?utf-8?B?U1VXbGsrVVN0U2dlUEZIM2ZBS0sxWWxQK0pJVlcwM0ZoR3B3dXV6N3NaUldI?=
 =?utf-8?B?cFpKUFgxaXVuZW5KdHZqSlNNOXZ6RDNvUkhGb3VPMDVzb080TVgxSnkyam05?=
 =?utf-8?B?dzQvTzRrTjlGTFcvQ2paWGFFRFJvWlcwbWxQMGtGeXJXTks3SVU5azVsRTlQ?=
 =?utf-8?B?N3hxeXhBRS8xRjYvaWNMRFZOeVRJY2FzbHNLQitsQzRScnZodHZWTjlXTXY0?=
 =?utf-8?B?Y20wendKS00vOFFWL2tISm1RRXMvYXZlNGhGdzdwczNkZVlzbU1CQT09?=
X-Exchange-RoutingPolicyChecked:
	P7QmQw6QrkNSWn6JIkKgHZJJhteKymCfySbYUIDTdDwDFfDbcaLqHSEuFjjj7rwW44uZelzx62rXC8FXkptrQq0jgcNtNKku8Za6h5R4Q/GZoInSZ8mMnOh6cl7VfkB29GBVrEFuiPb2prerttxHUl69jMMCRP21/iAQbRw6h4bI4EaqfevOXgjJ6wSr7ElFJinPPzpiVG8s4fWiqmy0vvLrwWGEpxOruKqVF4iafOGAfmcxysvKypTUx/TtAJBIXvE5kUSOx3p+xLOrklWd93WYFp3E0V2xgM6Bqa2mIU6xrMeruaZrqNFcrrgyE2IiM5BHCDA8BAmj7Z5dYRE3aw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	120auTdq4zBhKLksz8u5RRF7jwy7vrVhpAykTIXkSdlwGuBrf8uGqkaCXvXLkiFm1DMTvp1YzyocXy9ABKKerJj3yZTUH0JTBUmZJ0tZat1/Y7/JEUKW5n7oAjb+3dIkuZ8KO77ksMklZgqAhb2taebh+Ti0onXPpZo5bnCuAXAy//hmx3GipxgjHHRW109ZqnHRGapNwtOtatBQbjxaSsX//5IMjPpVAPSJwSIooBYd9Srmy5mwmfOTzT5WCX/dBM/yopA6Too0RLB2elJy3z6W4YeD77F5xcbU7ns28DDvSAZkSwL/tr0fmCSQvNhr4n4dOiVhLXOpzHHywKimWcsH3udjzm/spili6cuh0Dccnt4dD1ZKtDKE032oseZFYq+PbdyQWvcIEhuwNck5pqRvYQqj2qjBTcNi7YIiJHHs2T1HKvJTb2yWHyDyvTKYns0QlSYhzb92+eeTr7I7vQmWpYo56DiJQ4DeCetNVvygtg+TRkE71PKvp56rdoZWjYI9tKaw8OeBqLAGdx3G6qq0upnVbPE6ElHifk94c7CKPoQvqWpPt5KCLWcd8r705J3vphZOx0SoSRJM9BrAeiK5MwxXRBAaQszOkcY0B+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cad1066-d5ef-4c2b-4265-08deaf66ae00
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 14:07:47.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chMuKaa5PZJFOgL8QRcdIfW2zLWjYOShHZ2Tdrt5pWeUAZ+ZX98guglKQD5HyY+2WMX6RfKlLIvD5fokuqRd5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=829
 malwarescore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605110156
X-Proofpoint-ORIG-GUID: TPTZTgU-Rku1ydfCNCTZwiapULCQCEBj
X-Proofpoint-GUID: TPTZTgU-Rku1ydfCNCTZwiapULCQCEBj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1NiBTYWx0ZWRfX/do4bWghuwCj
 u0ucPyDw/uxVQTL4E5+faFq47FolEwqKX9gtowcReD9N2JX5k4z9GK9fZwaCFRJxTo0UBtub/xq
 MGbAt7yrxz0RiJE1GMWY4jTqn4Qd1SD/xJ4VsFqxajBE5g+O8WZOftp6ZQ89C1X3O4b/NDG10XQ
 MLLQJu7OCIOYir1WJCbL5kr7gHxFUl1YwHL0DpVd35oHg3ZGTFqVwu+wNrz/u0EmydVC/66GzBS
 iidcAIH8TC4ftBvFs8pSVro/1GH2UhOTmQaKlPitGBoAlVprf9GHW8rmU5kZc0x/aaaSudbFWPH
 pF7c4ddw+tahXz/zfhL3a8F4M16D8tlCRhcKAMDgQ/puFDZ1e5vgknUgyvPw1C699EvAVvX+F87
 loIdCIHKpqzra7AjtcoBgBlmT+B96dAeuu7oGEbib5hEUdWuYDlndeRZfCKLeoOTuSVMYYM/2nL
 v8PCm6QtWpHWO0P+1QLrC2TcUe2Rb5AkSublndog=
X-Authority-Analysis: v=2.4 cv=FcQHAp+6 c=1 sm=1 tr=0 ts=6a01e2bb b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=uKxZZzPa33Sla97EJX4A:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 cc=ntf
 awl=host:12299
X-Rspamd-Queue-Id: A3931510099
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-21470-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,nrubsig.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On 5/11/26 10:02 AM, Christian Brauner wrote:
> On Thu, 07 May 2026 04:52:53 -0400, Chuck Lever wrote:
>> Christian, let's lock this one in. I will post subsequent changes
>> as delta patches.
>>
>> Following on from:
>>
>> https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
>>
>> [...]
> 
> Applied to the vfs-7.2.exportfs branch of the vfs/vfs.git tree.
> Patches in the vfs-7.2.exportfs branch should appear in linux-next soon.

Not vfs-7.2-casefold ?

Fwiw, I was intending to rebase nfsd-next on the vfs integration branch,
which should have both vfs-7.2-casefold and vfs-7.2.exportfs merged in,
along with Jeff's series that implements the infrastructure to support
directory delegation properly. LMK if that's crazy talk.


-- 
Chuck Lever

