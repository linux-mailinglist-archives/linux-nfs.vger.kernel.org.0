Return-Path: <linux-nfs+bounces-19693-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KHaLV0np2k3fAAAu9opvQ
	(envelope-from <linux-nfs+bounces-19693-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Mar 2026 19:24:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B99751F541E
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Mar 2026 19:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1546430308A2
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Mar 2026 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94243A6EE8;
	Tue,  3 Mar 2026 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UengMnH0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SAns4rMc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A9B366816
	for <linux-nfs@vger.kernel.org>; Tue,  3 Mar 2026 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562089; cv=fail; b=AKJAEyeAXQKRf2Bzg2lSquP3MHqQjO54dA86OR5P1AZUrLE6OfBUSO8G6SVVGaQm8E+EMC2cGXoR46Sh1MBkXR1xSnY6DeENBXNw4lK+4OAt+fp758iuxVCE8s8q+d/1ffXM0XMOF1xNajIrrkJ+mmfyZ0y+JtWRQB1dBQ233W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562089; c=relaxed/simple;
	bh=medue+skeH0uzEkejknzbUetakh9TyRdqaEufSlcyCk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OKXAQ8laxYY1swB38rupFYJ1fjCKKRdw3b5yPZdOIhL8IYn+AYT+6AgOMe21YwHsgV019uJ3BQYtV2N1qYoOGIOUwPLtgynI3dLIfNcMMgplxr5MDTWgDonUwDwL9oydOX7qDQnsBpPsj+RBLdIFyrRjq0+QhJVSAOw4BPKWScs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UengMnH0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SAns4rMc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623HmLwR929680;
	Tue, 3 Mar 2026 18:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OzDR6usE7buf+z87qwwUtbhqk8GNbBc4MVIjkqnWpfQ=; b=
	UengMnH01J85MThJLWS6M/HP+PNqL5oA5D4MCq5BI0rXIXmALj9Nxgg0vG8frJ1u
	JKvPaaMGqJ74mn48DfQIEGEJwzXI0GCPRkWh6RoVCxwKEcZ3iXYtKCme6Gtt2gUe
	8DLOIW9mY/bOiDlr7mbipGUVA/G2IzZUFm7rx5j7djG2rKpqmHwfBJ1mBa9yTmh3
	ILVa5RCCAvrcSskmmcuY8k4DfHBNBznydd3fPMsLMBESqBFjeXZyHNFw+Inb74GY
	r1KvXLiAjlCZqba94Dq6ZkeJj6MpACZy/6dXLdnAtchGdDFZZ7ADDMBPPaDX0lOb
	wuvC6HMe/qR5xxtzDlpdaw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp4c381vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:21:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623HoHjm023120;
	Tue, 3 Mar 2026 18:21:16 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpteyv05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:21:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1XuY3HU7sBVB9h0wwKuWwwgUUzy8Ym0LWmnlDsVBmyAL2+zRYQGRjx3DUB48nrzdepkx+w8FQgmBPkQA4PspC50TjeokmE5RLkBaJd+7i7ixltMFFk/jeFaaoWxKT+G4zxGEzQtdlqxzUpdL70vKOudQQys2jsu0UslzHBMWlZkxWqo0CdnXx9DHylVMp6DAsKbZ/1mTklINf4NEIVNSlvs9RoAUdspcDPa0Dr913jQ7Q9B3W5hz2hrixf0p02cn2V1F+qyQU5rWUY4KDf2gSfBNnx41vcUIZeTXtuTetoafpmFCn5RAdHIeiv6xU7UlBiLzY0df1gkFMqW3CtBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzDR6usE7buf+z87qwwUtbhqk8GNbBc4MVIjkqnWpfQ=;
 b=kdQ28uXuwCYPiBj+S9Iokcm7BB81mTog+9rDuWABaJiobmTcmKcG0hBd4IHDkd8HnLGLrlKLvtyAmgboR3gjQDhypUlrLHzRjPXEuclUQ6CN7JJ7p/Cpu6m/OtfHJqmS/DSs9U3MQ5c6mRHfA8XRjVMx04yQyC2abI5QBkIrmTyYzOaVbb4tgroNq4PA58/aatSIMz9B+sWknfzoXYQBT01N1kUGhfLnISHZTc8NlC+sbOc3YeazEjgsU33m+Ji16jL/qBDR0nutgKdAC2ShoY+QxGNhAfqPyF7yENxi5Hd4nEZdeiyU/zxuEd/IGv/jpYaqJeGJ1VdSm7DEN8d7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzDR6usE7buf+z87qwwUtbhqk8GNbBc4MVIjkqnWpfQ=;
 b=SAns4rMc+m+sCSzABHU4Ji/GBlhKwstT6m+9haDs2SJutuMz99UXA6aNhW9f+5Nk4G2WGLYu8Ul97ua6llmHaPtu2a23IqUJsJiidEufE72JB8oQuYVOlI66msVWkY91mpfWCEHKyQ0CVF862M9rvVkAxZa4EW7A67mZW0jKM3k=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CH3PR10MB7833.namprd10.prod.outlook.com (2603:10b6:610:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 18:21:12 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 18:21:10 +0000
Message-ID: <53291a21-4a4a-4f43-8f8d-73f9415d6128@oracle.com>
Date: Tue, 3 Mar 2026 10:21:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pNFS: Serialize SCSI PR registration to avoid
 reservation conflicts
To: Christoph Hellwig <hch@infradead.org>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
References: <20260302005138.1844156-1-dai.ngo@oracle.com>
 <aab_XbwjYoIPk2_a@infradead.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <aab_XbwjYoIPk2_a@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::25) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CH3PR10MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e4a667-bf3e-4b35-3009-08de7951a506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	2RJlB5neKfBNnWuBsobgAaknBeJG6wb9LOxDq8c8mlYZISE88daNqr+sInaoAx5U8f6DZtRp3X5M/dHW4xv7LepcVmAIaExjlkJDHL0tor6aLA+GBtTbcfbVH/YDsnLGitObZ48sFa9o1JEpyRQwWQoG80IlW3pDY9x4gAb3NqHrg3iGWNdBi2YbE+0Hpr5UiR7ds0wO8nFkQsjXytIx4+yQoMeLZJ5hVPnTY6RI8KODAy7tORh7BPG0Dg4P5hWH1HuDzqSEPVqOHwhlLi/6kaQCwLqS8pfy0ByjOtEf8T+3A7uEoeOIBMGR4J2/Lwg2SRh8fJ0f6n7/lRlHEMm51D1UfA0CAiL+mB1m0QLk4ahoJrRZEObJCZ0XWoTSuNAifKBG/+bWVsvEnvUIqOhq/jNi59q5t09pXCqgb3dgdV43gO4hoP3MCv2QM5wNLBt174iSsBDA4hh0A+vc5a59hM66eHrrsA7WlL9Mka7uBAJRpPdUpJYdBStmRwmKzusSs5sdhpyUQ6qZbpABz8aWp7RlfwZHdfmQbvlNmuyWXZyndORvJawu4p75YVuCzFB0r2k+Ds1eKqCGXXMY3Q/j1+3ZMYgIz9CAKdgQ3CJTjexbyic5VYNQX/a0hUAxYgvVDXzlG/FajWa4PlQJpOb0EIKRU0t0Ieb3KxhqQxRwITM/oxfUtMhWgqYmM6CD/2DtxIsE1R7KlbA8b7f2xsHZjQJuPSMELtUm2zzcwGjZMnE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG5KTXhpMGFSNmhpTmYwNjVDaVYrT0xNRDdrWjRrWGl1cEswOWxEdlZiRSsw?=
 =?utf-8?B?ejZMa1ZQYXlWbjVmaURyWHgzYXo1cnd6aFJyT0lDOTdZMCt2NjI0QmtGTUFk?=
 =?utf-8?B?dDBFMzUrSTdubjJ6MkRFSlU3M3grY2xMVThCZlI3NjVhNzE2THNIVjFFeTNH?=
 =?utf-8?B?UjhjWkw4Ly9nb0ZDMVJsUGxKSmRXeWhDSmtvdkd0OTNQQ3FDcnRVTVdjUjlE?=
 =?utf-8?B?d2gxeU9XdkRQT0p6em5XMG5lWGJCdVYxbURqOVpvZEI5QXZldEJvQittSFVN?=
 =?utf-8?B?NGxVcmprREZ3TWlrVE5vZ0xHeVNFa0YxWWdsWi9SME1uNW52Z3h3V2NiT3Zv?=
 =?utf-8?B?dkRvbjJvNlBrdHRqcERyQmVvdFZQUVBqWGRxSk0rOFhLU1d6eTVHVDkrV1pW?=
 =?utf-8?B?U2JlN2ZoclRXT0RhUmpyR21Ld2R5R1BwcExST1lrL2tMSk9tN3lMR21Cd2R2?=
 =?utf-8?B?MHpMVEpxQjN4RGtwakZacHE1emx3andWR1BxbGpPWFhXWVkraVZScGN0M0Nu?=
 =?utf-8?B?UWtSQ0U2M2pkOUZ0Y1Z0eVFZR2xPc3p6SUkxcnA1REt3dEswanF5RC9EeFRK?=
 =?utf-8?B?bEFTM0RBQUdZU3RLRjZ2ck1RejB5aTlvT2U5a2xYOEJRamRmZ0VtdzQxREJL?=
 =?utf-8?B?UWFHWDdnMmJ1dDJtV1BIbTE5Q2JMZ0o3U20rQzVrRWpzVElyU1FGRWsxdGh4?=
 =?utf-8?B?UG8vOVVrbTRvNWVjQnEzUGFIb1RxYVJDQTZSWGNmdXNYT2pYTDJhWW5KWk1O?=
 =?utf-8?B?UllidnVNY0dQZFcwSS9tTVNEbk9mYWd5WVBNMG5rb3NUTE52QnFRcklMZTJQ?=
 =?utf-8?B?bmw5MllhMm1UWXhnWVFFajI5NDVSMDFkaDlmMEg0NEFpSjB4MEZpWjFxQzhW?=
 =?utf-8?B?YitXcGhCcWhacnNMeDFURHRCS2hHVWpMNjdqV2VQVkhOeEVwQngrRTNMWTlL?=
 =?utf-8?B?WmtCa2V4T3Jvd0xvZkxOdnpDLzZra3NnaXFqLzI0UjdmOUZCOEFiRVRBM2U5?=
 =?utf-8?B?dVhZNnNkLzROeGxVOFZ3TVk1dmRKcnhNRXNNZitmc3ZTZmFxN09mTkRwZUEv?=
 =?utf-8?B?QVlCdGZKejd3eHhpcDlJcXNoSE5sY09VRHBpNDh4WWp0cHl3ZXNYK1E2cVpR?=
 =?utf-8?B?S3J2eXJiS1VoRDFvdUxkUFhMUXk4VHFJNU1NT2wzcnBkOWhRbHBWTUFSb0lW?=
 =?utf-8?B?V3JuOE5rRjVJZHROY1EyQm04UE11R01KWGhDMXhCWUVLM1dVV1IvQXFmckFD?=
 =?utf-8?B?OFFXeE9aUGtxbk40UUptdlNTa1pkZ2dmYVdtY2x3UDM3VERPQXhsQ0Q1K3o5?=
 =?utf-8?B?WTh1ZjU0TVRsS0tCejFjcjU2dGc5aHhiTm1GQytaNGN5T1Z3YlBwWldMbjRE?=
 =?utf-8?B?T2ZhZGFjenRsRDRwTlpKRkxwTFBVRGtCZUs5czRiK3FLZWhzZGFQT0Y4QTYv?=
 =?utf-8?B?WitGWHhhaGhIOUFnVkVrTFdvakhnS1ovV0VqU1RVYWVka3NmN1NqZjdpemt4?=
 =?utf-8?B?VFBHeTJsZG1vU2h1Vjg0SWpLUjFtT21ZWnc0NGpnUlQrVHlyd0wwME4vMVgw?=
 =?utf-8?B?WE5RdWhpWFJBeDBGZS9QWkJJVFZnUGJUN25nNThWSHBVVExaNWoyRFdyU29L?=
 =?utf-8?B?Qk51bzdpVUF2d2lrKzNoaVpDSkYvZUswZVdMaU04KzI3WStLNVh2Vk9hZGFF?=
 =?utf-8?B?R0JmUGw0WVNMNEZrN2x5NVhCQmdhaXNCTkdOOGFGaTJlUGtoNHVNZlAxVCtT?=
 =?utf-8?B?Tm8zdG1Ya1JTdVA0K1QycWg0aGZiK2gwUEwvMnp5ZEprbSszWDdNM1lDbzNT?=
 =?utf-8?B?MFMremJRQ1Vjb1J0RC8reHRnaEU1NzdtRGFFbTVuTEdNRzZHOE93akViblNE?=
 =?utf-8?B?bWxMbjhFK1RvUFlGTFZ4bEhQanJLMURha3J1Y2RydHZhd2ZhK2NWYlE2NXA5?=
 =?utf-8?B?aGhSbXZ1Ui9wMXBnbnNaQU9WSDFkSnFCUzFsMW9vWGVDSXRROUpOaXp5aC9o?=
 =?utf-8?B?dVVlZDRnVmpyOXB1azRvc3NYazFHYVlXOWxkU3d1YUc1T1daUWVFblVSOVdP?=
 =?utf-8?B?VnptMWtMa2RYTXBvb2I3MmNQWHJrazdYa2IyVi9oVjF3cGpjVWJsY1VvRlp0?=
 =?utf-8?B?SXVBR1NaQXplZ0J6VDRWS1pzVHdyQXU5dktjV2VSaHFTK2FPek9hUEYvRTVW?=
 =?utf-8?B?TjRBNUNzNWYzSG5Hc3JzSFpsa0pHNXdQSXY1STRyVFJrYlpqclcrT0FrVjZv?=
 =?utf-8?B?K3ZoSmlRZmFsRUNRWkh1V0FrU0wxdGg0UVVwaTFqQ09wYjBqTExJMkRKckxC?=
 =?utf-8?B?YUtJNTJlV0ZhY25sTVlpazdjUW00eTZCWjh5Tk1UNE5EVzNMM2d2dz09?=
X-Exchange-RoutingPolicyChecked:
	hCbTmfWl08xe6etcWC7VqQDnUsVsQQ8u5xpBa+q+olAmAuVnq18De5Nus9/VVPgkJloxvuLe+NoQcZScHWAWe4cn2byLnafMweUAbBBBtCYiS1JAQa2eHPj2zix3zqge1pYf98LrqDBbTicV2GpREkGXoMtqHg9zWmNxMlFjaeEuZ8Idafr2Ia9hmHJkNbL02JwmVfOJ9kL+T1jyViNU2uOk5fu5rmw5ppgxFv9Rtic2DDI/sf4ti3iXnUbGgBPWuU/u8B4HddL5T+Ilt/3Ut3qMz9fDjOIW6aOjnH9d2eM/B2zk+p7yXlxx6lpSFAcK+/oyA5alwpCl8JQUIai9Eg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5ej7o80eSalTtBMbAx1R0W53GJ+VZZdXi/meS2r51VoVtg/Gu/8OiPLGgAqUFa8ppglpr+WljGt3SVP93UHl/y3rGC6RnYFgzoPpNpcPlhH80eL8ll2ddJRgOZnf9jIJ9ewTvyAEyc7PxeMDQ5AVeX5BCSXApM/kYTw+M+ufBGcmj7zkgXMaUoGAoKIz0ioqWh2vAUudL1d84D5J68i1IGyiP+lPPfLdpLs2DVJRgPDdij6VvOFmv/SjW6DsRuU76YPiB+6M8FeCLBiRiJ3jByo4puEOBfrK6Wneg1RangH8znAueJ0G/IsTW0c/Z3131qcY8Dt2r618D1PAz0Bjv1jQ/P2eeOsK7BmO8eZ9LRf5SWry1/p5u71aGQ4buOyKHKZYRstfExo1PZVUhS1CFGg7GB4yzZyrXHgS7e9hKLePdMEViBLthYOrSPg0Wo7+WyO2+jIIQUnqamNAz1S+ay/QXGVXGxv/1ghwmJoX17P2/YpYi7od9AJVKzWyn/3Jznx2zjM6WML0hxWdlx8u9SkrCV/1q/JniLggOQ5Tw0AATq4rxdZoAQrhpAJyjnqqds8LwMM1K+sXTWmEzjwKu6gVUGX9qKLDlwM2pKkaefQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e4a667-bf3e-4b35-3009-08de7951a506
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 18:21:10.2349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvbgbxoiD0gyAYET+UYf9oqPrNVBxnGfcOpaFKhiOpmO4rUQ/RXUuUDrHNyCmNFnIhDqKbC6yymCmFmIs64s7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030148
X-Proofpoint-GUID: DITuiaNA57z-GJWPoUFU_g40kRQl8mHa
X-Authority-Analysis: v=2.4 cv=VZH6/Vp9 c=1 sm=1 tr=0 ts=69a7269d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=Gf6UsLn3RbM8zlqD3p4A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12267
X-Proofpoint-ORIG-GUID: DITuiaNA57z-GJWPoUFU_g40kRQl8mHa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0OCBTYWx0ZWRfX8+oyxU+jiTJm
 DInkmARglOcktjOVDxvk0aalaLvr3+n38Eo7pPymtBJTqaUXWhwmNyFsb8xYOq0+9+UPkkQ1hYa
 FQR+dblyuhEdOiW3N62nalwYNEcmPaVZPRzyuR8LQPPvo6WkbPkptSG4Bw5lN5s2g7vnP6ybIC/
 ZSQut5zTlYnw3rYxhdfa5+J+hf07FRLoE9hGLQuhALHwwETLNiJ2E61FllYZ0cDVuDW/7M8kr1o
 tQLi4fE/KPsXW51eaX6dTMtsCNOSku7K+8aiocFjAMmAVA13gn8JZH6dfTlPdG1CHxEWTq7uvhk
 X27xiD62pWSkoxJfUWH31r9XlH5NE116OtWPMs5bLhmqJZ1jLvTlXiPQ2G3iYskfbp5FPY7mezA
 66Tb6gaQmYDH8rFjnzbNqDSYQY5uEgcZYHTqAp2wRD98dwg53JWZSpughQZY8ug9oWsZ3o25VoR
 qUzfnbIh/l3zb5q8UzVtyBGQGA8pnKxv7iVgc4zc=
X-Rspamd-Queue-Id: B99751F541E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-19693-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.onmicrosoft.com:dkim,oracle.com:dkim,oracle.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action


On 3/3/26 7:33 AM, Christoph Hellwig wrote:
> On Sun, Mar 01, 2026 at 04:51:23PM -0800, Dai Ngo wrote:
>> This problem can be reproduced by running 'fio' test with this
>> workload:
> I wish we could wire this up somewhere.  Not sure what the right
> place for these kinds of nfs tests are, though.

remove in v2.

>
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
>> index 6da40ca19570..535db8b0e89c 100644
>> --- a/fs/nfs/blocklayout/blocklayout.h
>> +++ b/fs/nfs/blocklayout/blocklayout.h
>> @@ -117,6 +117,7 @@ struct pnfs_block_dev {
>>   
>>   	bool (*map)(struct pnfs_block_dev *dev, u64 offset,
>>   			struct pnfs_block_dev_map *map);
>> +	struct mutex			pbd_mutex;
> Can you keep this up with the non-function pointer fields?

Can you please clarify this, you meant move this mutex up above
the (*map)() declaration?

>    I guess
> pbd_registration_lock might be a more descriptive name, and comment
> explaining what the lock protects also never hurts.

Renamed to pbd_registration_mutex and add a description in v2.

>
>> diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
>> index cc6327d97a91..45630781f1a8 100644
>> --- a/fs/nfs/blocklayout/dev.c
>> +++ b/fs/nfs/blocklayout/dev.c
>> @@ -33,10 +33,14 @@ static bool bl_register_scsi(struct pnfs_block_dev *dev)
>>   	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
>>   	int status;
>>   
>> -	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags))
>> +	mutex_lock(&dev->pbd_mutex);
>> +	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags)) {
>> +		mutex_unlock(&dev->pbd_mutex);
>>   		return true;
>> +	}
> This seems to only lock the registration side, and not the
> unregistration side, which is a bit odd.

The reason I did not use the mutex on unregistration is because
unregistration happens when the export is unmounted and I don't
see any race condition can happen at that time. Besides, even if
there is race condition on the unregistration the consequence is
a duplicate SCSI PR unregistration which is harmless.

However, if you think we should also protect the unregistration
then I can add it in. At the very least, it makes the code look
symmetric.
  

>    If you fully protect
> register/unregister we also don't need atomic bitops for
> PNFS_BDEV_REGISTERED and have a more consistent locking scheme.

Even we fully protect register/unregister don't we still need the
PNFS_BDEV_REGISTERED bit so the others thread can check and skip
the register/unregister op?

Thanks,
-Dai


