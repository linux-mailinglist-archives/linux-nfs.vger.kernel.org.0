Return-Path: <linux-nfs+bounces-3515-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6C08D68A0
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 20:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6071C210FC
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF152F7A;
	Fri, 31 May 2024 18:01:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E862E63B
	for <linux-nfs@vger.kernel.org>; Fri, 31 May 2024 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178515; cv=fail; b=psSFyeY5Zg/4F5+s9/WhnmGG+RPNWZLOw/mQ2IsVQbmf5Q2ZYn3GgLfQ1K0lVZgxK7SRAdGPQpnzdBGXDvnaiV4/xQxnrrQsTzfJ61mBrsBGH1dQMDq83qf74hwW8GY/sf6wI7MaGwvc4KZXfihdQ+oJgmHFRj5eLPByrvydXoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178515; c=relaxed/simple;
	bh=rzEyNGn8linxCC9VsHCeso+LviC8gF0xFoPMRpuk5xM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AZHETH5x74KX0Wv+j5h+ZAbnvo9rF2P4P+ZI8q/H41vs5UieQKX6CmZ2Iz+vHQFumu0MQwIEJS92ib1XG9CMKjtET/a8YvfD14uIQqdzVqpheS/KHYtD+INe2xgWgFdnwP5HKRRhbIfjcaAhenb0F9CZbzR+MM6URbKIv5Q7eBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44VHpccE006930;
	Fri, 31 May 2024 18:01:48 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-id:content-transfer-encoding:content-type:date:fr?=
 =?UTF-8?Q?om:in-reply-to:message-id:mime-version:references:subject:to;_s?=
 =?UTF-8?Q?=3Dcorp-2023-11-20;_bh=3DrzEyNGn8linxCC9VsHCeso+LviC8gF0xFoPMRp?=
 =?UTF-8?Q?uk5xM=3D;_b=3DSbkoFbHHu/oxy3AiX8sQGTyhB5rz+0XLY65H7OpAR2Rlh0jUj?=
 =?UTF-8?Q?JTeYsqV5PwC6a293/YC_EW+46OwnJvgjdv7jaE61zssvbb4ZIlzEelAaJqLSs2M?=
 =?UTF-8?Q?I9mw9aGYF/9/oQTFQiq2kF8k9_pBX6Yyu0y9j6NzWYbnfx1aCiBnBoH3ReIdUUS?=
 =?UTF-8?Q?DusY9yq5M4SFNlYs6QToBQX3ab04iY6_yas9b/+1l0wm2JXgvkw14+/dpHnfzXM?=
 =?UTF-8?Q?3BjYNmy/HCyEEGKIVzweLYkUGJH0mw/69pDGV_j2qmV4QETKQG9GlqCsrIsNDZa?=
 =?UTF-8?Q?3fzwl0Y0tlSSLMnNbtDNygVxhudlwj7wLRN2DNU/DpC_ng=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9ux0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 18:01:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VI1GQG016201;
	Fri, 31 May 2024 18:01:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50u612r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 18:01:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+0RpQip1qyP623/nrab1WCX92mrURqOtVniaNvwC1dZlQlvSvWDt+k3+Ka8iO20WSQPOjDAAMToH/pVEIvij6YkBjfD6/i8AD8OMzaWIp/eHZVbcDJe6MhOphXRUB8uryPxsCo/3XbG+tOJ/ZnwN5sdwbdcQTB/QI1zXHxHsBAh/QtOlZQ1kanq40F5nTh4rB05eTVayHhIuw/QNrQSTKxrcnadv8OVXltzokAn11le+9Re56Ywtjw9yrx54UAvGypy9qCQoQECGH/FSMrkX8ptdUb4hp9qkWDoty3HtB+fSlN99XZpILmG9MYNyw6UqREpd3lN/4ORXDUvz8RT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzEyNGn8linxCC9VsHCeso+LviC8gF0xFoPMRpuk5xM=;
 b=mQqyPtaTfAaD59BJGtLQGJYzS/YzJyWkKH8WH9OWLN36Y/6onHFV0sBMltwYpvr7WdTd7iK//2NwmMLcVP3OjP/ZhQpG1/YGaMURmpPRYrvV0J6feDRrvVO1F180btswCHNqO2iKQzUySLSqhVgJgN7ERaGdb+hXYdFA3GjBMSm+wYUoPmbpdQqA4jIFGnlijhn4NyZpuKaqVyQsl0b+nCyjs3f9QzfGBHAsPD4uhzK5vkOZikg+3XXHStB5ITyJ94zYE8/5SuT0qbK+XqmCsv/opYksSpIZ9kLgogYl5aTgdy62nPSa//h5UR63/RWrrhFu5r955KKbyO1TqzZkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzEyNGn8linxCC9VsHCeso+LviC8gF0xFoPMRpuk5xM=;
 b=BKHYpV5uY3lVL2AyDq/FE+zlgJp5x5ycGSVwukb6d2eMwRFvqEFW+VQ3YLqqa472xEWJ3l7NHNs4ZUU2JzkfGe0JQoRQsjY/2NRf5yFcoUd0PpyZy+LPAOCycc82mFghaRc+V+pE5tboT8eb9VPsxxrM1zXQsuJsO+TQFtev2+s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5094.namprd10.prod.outlook.com (2603:10b6:408:129::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 18:01:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7611.025; Fri, 31 May 2024
 18:01:41 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: ktls-utils: question about certificate verification
Thread-Topic: ktls-utils: question about certificate verification
Thread-Index: AQHas39TTLvaQrkL9UiH4bHQ94G1GrGxmJ8AgAADh4CAAAX8AA==
Date: Fri, 31 May 2024 18:01:41 +0000
Message-ID: <8755F43C-61DC-4AA0-A163-2D75F195BD23@oracle.com>
References: 
 <CAN-5tyENK71L1C=6NwdB4mkxxf1qYZ2-4e-p8FQM=SmA3tMT_g@mail.gmail.com>
 <6A2D93D5-1603-4CB5-95BB-841163E20295@oracle.com>
 <CAN-5tyFcqZWEb0-LYvucr1nGho6LN6nUNhO1oZHZzZC4G6W2Ag@mail.gmail.com>
In-Reply-To: 
 <CAN-5tyFcqZWEb0-LYvucr1nGho6LN6nUNhO1oZHZzZC4G6W2Ag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5094:EE_
x-ms-office365-filtering-correlation-id: b8ee44a0-4523-4044-19d5-08dc819bb96b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZUlRaGpBcXFHS1ZKZi9iTXlOT1dUd3BlaHFVQjhUMEw0cjlNUWYwK1Y3VmtJ?=
 =?utf-8?B?bXQzT1pFd2tkWGx5V0pCRjlMa2tQL3RrWEl3Z0NEYUhRWFNJNkhLVnppdFBF?=
 =?utf-8?B?Y0RSb21aWWprVy9ZaTlUbVRlbmZ5OWJWYnBrc0ttY3ZKVVRBbGtoSUtMeW5J?=
 =?utf-8?B?TWQ0T05sMzMvS1JCTmpQZXcvQ2ZyMy9WVDNrN2h4TWIwMWl2WWJQUndreFlD?=
 =?utf-8?B?RG1XaFFwVUxnc3Y2VFVKRVN5a3d4NFFQNU1jZDZ1NVQxdE9KdTVzb1pjN1JS?=
 =?utf-8?B?anNQT2hhWUlDSFFQdXN1ZGhkcnlWT0hCRjhMVVJRQkFpTkV4empaUWYwT3VL?=
 =?utf-8?B?S3BocXJNV3M0SG9kSGlPdS9wTld0amN4c2IxYXpDTStZSEEvL2FadEl6U2oy?=
 =?utf-8?B?SmFmL0Uwd3BUM1o0NUFjMUF0RVNmMjh4aG1FejRwNktYRkdrcENJMU5zKzNP?=
 =?utf-8?B?UXBKZXlaQXhYdnU1NnR5bmxjdm1scjk4VkhLd2VIRG9iZ2hLQmtLU0U5SXJH?=
 =?utf-8?B?MUwyVWNLZmM5cjg5c0p0K0xEdVhGelh0dEduTGhBRnNzV1VkUTQwcUFaTHo2?=
 =?utf-8?B?Q1dIZjViM3ZqRkZYYlpNeHlNYmtYeXJXVmNYZy9oL0FtZXA1YUIzQjlHNVVl?=
 =?utf-8?B?c1pTWHZNT3F3MndJREpPMWpHRVUvajhkSThZRGhhaTRGc25xT0JyZXovenZj?=
 =?utf-8?B?Rm05RGRnckFRU1pobDlQbVFyRXc2N2ppS3U1bnZuZGdRTTYwQUxPcXAydXR4?=
 =?utf-8?B?TkRCbkYzMW04Yld0aGNKVjVRTTUyeXBTMitUL01XRFA4S3U4ZUJjUTFFVHBS?=
 =?utf-8?B?VkJJVlE2ZXJxZ1dIc1J1ZjNoTlF5TGZUeW9VdElPSTM4TE52NjhoUm9CeG02?=
 =?utf-8?B?NWV3U2ZxOXBKZUhpOFlhMkVhbkFid2lrQ3VuWHBtQ28wRTcwRjAzRjlIQkhh?=
 =?utf-8?B?dG1nYkxhSDl0V1U0aVdIMk1TbXhYMW84N3BrT1IxTTRSYW9Zd0ZIZ0dEeVA5?=
 =?utf-8?B?OHN5RzA4d1Zhb1VCMXFYN29MeGJBZ1lCckhzMHNIdzN6WTh5emVhUWFjelpV?=
 =?utf-8?B?YkxpbVkrZ1hhOTh1OWNSMXB5ajZEMnlTTjFzYmVTbDFreXczZkkxcUlYdDdo?=
 =?utf-8?B?SXRpMWk1SmlKTjJjVFNCNGdaalcxS0Ntc2VJcnFydlgza2wxVlVCMlArOVNo?=
 =?utf-8?B?bFJHY0IyV1ZwNFhLMWhoSDNodDBUa0xkbkt2TzNyK0tjbFdMb3RKd2FibDRh?=
 =?utf-8?B?S3lLVkJQK0xxZ0k0OU4vUVozR0Mwa29lNFdaSTJqSzRabk5FYVNIR2V0M0JX?=
 =?utf-8?B?cFhRdHFyQnJycHk0aGhPMFV4RVBMSlB6MzF1TklaRTNVZ2JGcjNYNGR0ZVNO?=
 =?utf-8?B?L1VvbjJ6U1QwMEpNS1hHV3IrelJ6YjdZb1MycHRSMkpCcFZGSGRSN2FXMHBD?=
 =?utf-8?B?NGtMYitSRUoyeHgvWTJxRFVRL2NnbkRBdzJwN0FqWG91cEppdUgwc0ROemZn?=
 =?utf-8?B?WEExWnlEMy9sdWZQVHRHYkMvMG5Ga25qTTdYbWVtVVlBZ251YnAwL29ra3VG?=
 =?utf-8?B?VG1Ic2NqNnF1RDY5RG8yRnNScmVLdnh5OHFSaG1hVGxYeUhBZ01PUWtCQ0E4?=
 =?utf-8?B?VXRLUko1TndGSDhwcjRUdlJOR2YzYlNqcWRzWURJV2FsTlpGZ3JDMG8zRkxD?=
 =?utf-8?B?WG5nVFRsbElZamNObjNqS0krNFR4aHhia1ZFRmZsNUdPcmN3bUZUeU03V1dq?=
 =?utf-8?B?NGI2UlJRdzV5ZDFtWTI5VlVPUERvQnRKb1VTVzR5OGZIUmNOR1JQaEt1MndD?=
 =?utf-8?B?ZThIMzRreWk3NElKQURjdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YmovOHNHb29JSUZoUnByTmNLK1NWYVFudHUrdU5VdnlNN0NyeUhCVkN2djRS?=
 =?utf-8?B?SElZRVp3QkpoQ1AxNHZCSjhrT3M5ajdJMHNJVUVnNVFNc1ZjMFVpZXRibUxL?=
 =?utf-8?B?K01uanZNaDMweWhJL3RjZVBIZks2ZWtWWTEzTkxSTkFPMG1YeTBwR2VyTnQ5?=
 =?utf-8?B?S3ByRmxsRTZiVnJPVWNoQjNENTVoVncvSmJqSGFuTWM0MU5IUVgzTFN3VVp6?=
 =?utf-8?B?OE9NM3lJSnF2U1JhVUY1bEVtWGpVV3d2WlhkN1pBR293ZDVXaWN6ZTRzNjFp?=
 =?utf-8?B?RG4vRE52aHUxM0VON0xkYXVDUVgzTW5EbzNQckNDOGQrbzZyT2FYZlVDYTYz?=
 =?utf-8?B?OEZ5SHhEMVd0QUhEajNuekZxczFNbUdWbG1ZUjVPYWNxbUNYbVdmb2wxeFZS?=
 =?utf-8?B?Skxwa2dSVDdwNTBpbGthcms4WFR6ZnlVRWR5bnkxenpGaitUNG9IaEc2ZTZp?=
 =?utf-8?B?aFBVWi94Zlk4OUMxUHVXRjEwSUFvMzBYdHBMYjluREU4TVRRTDVhQzVxNUZO?=
 =?utf-8?B?SWhqNkJMYm1Yd3BzSEpPZkgyYkkvRmNUaTFkU0N1QUZLTEhqTjRlTzJWYVZu?=
 =?utf-8?B?RFY2K3ZlZnlKVnVOSGl5Qzg5em1Sam1mK3ZEWDFxVUR2RFV1R2JqTjRUcTZM?=
 =?utf-8?B?ckVhdnNoUEhZaW1GOHRJb1NhbUIxWnNSQlljdENEMWk4eW16WjAwd21ub0Nx?=
 =?utf-8?B?UnVSeHJFS05GSmVJK0E4S1ljR0NlQWNFdUF4cXV2U1V2djFnMmhNRjJ0TzJn?=
 =?utf-8?B?d0VWRHZLT091RHFHSTNPTVY0T1VQTDAzQmVGLy9ubTViem0zQU1LdXE0MExH?=
 =?utf-8?B?OVJlVmtKbzZqdjdKMEVUNnJ5SHplUlpvU3NGU0xnZ1d0RmZ0dDdTaXpSRGp6?=
 =?utf-8?B?a0pORVhXeXVqd09mY3JnVEVGQXNFRHJoNlY3TE1JOVNOL3hYeGxyR0dRU0U1?=
 =?utf-8?B?djFmZFl4WnZXbWF1dzFJK1JUejAyWGFFSExnWUNhMm0vWFExd0RvbVVPZDVk?=
 =?utf-8?B?aGlCRG1ibmYyci8zL3pmOWllUTdzd0tNZDVva1ZkVzQzOExja09pbHVla09W?=
 =?utf-8?B?SWJjczRKMTdSZzlpYWV2Y3Y3YndlNkJ0SGdJRDZoaVhrcGQ4aHNTU0Fxdmlq?=
 =?utf-8?B?SkViZVlicmlEdUdWL2grd2d6a3J4YkFtNzZiNy9TNjBPTEJ1Z1NBb3M5Y3pZ?=
 =?utf-8?B?WjR5Z2dPQ3g0SDR2Z1U3UlpmbU81NEVhYXUycWJRV2xJQ25kSk83Z002R0ZC?=
 =?utf-8?B?cm83bFFWc0RSM21TU1VCYXhvRkY4SjRsSmV1emRlUnhxaVpmRGlWS3JXOHpP?=
 =?utf-8?B?NGc0K2o3ZDF1WElSTWYyVVpJcCtsVXl1MlJTTzFDSG9pekZsaHBnVklJUVl5?=
 =?utf-8?B?UU9YUS84NDRXQ0swUTM3VjlvaWlocTBPbzUyNFh6VHRkdFNWVm9pT0poZGhu?=
 =?utf-8?B?Y1A2UVUyaHZhdXVrSzQ0UGtSZGhBZkkyVDlsSGsvNVczYkFyUjFFNGJOdzBx?=
 =?utf-8?B?eURjRng4QWZEUDMvUGRLWVBUL1k0QmNWQ0EzalU3S25IVmxaYkFkcHFoMEtp?=
 =?utf-8?B?aGVyVVlydHNXcGxIY2lZQ1kvemh5dDgwWDQ5YzFSRDVvWDZSMDNwcHNrWXlp?=
 =?utf-8?B?OEhaZlhwSVRBU1RWVXp6azhqRHk0S0FjNGJMM3dMYjNyd09ML1VUN21RZVda?=
 =?utf-8?B?VDlqczdJRitOREl2MHlzZXkydVRaY0dwZVBqa0VmZGluUWE2OEdDWmluNXcv?=
 =?utf-8?B?RGQ1YkhQU1Joa2FmNEtwbVp6RG0vQlY2bG1MYkZYQzhhZ2xBN2dtTDJRbFJU?=
 =?utf-8?B?MzYvVDVsTmd2MFB1WStGNGNLL3NpZEJoZ0xkdlJVMWpneWNpaUdJZWdnMkFM?=
 =?utf-8?B?Q3FFa1VlbFNGY01rOStlbUxDM1czN1lvNlRQVnh0aUxTbVZNbmVYQUVnR0Iz?=
 =?utf-8?B?OTRWZmJuNTAzK3ZSVTZQNGtaRUdaT3pnZWNaMk5CeXUzQzFkdVNOYldxcmU5?=
 =?utf-8?B?ckg4a1dqakZnU2swcm11TmdPdm84OUFFSnFERm1vTWlyalFzSzg1UU1qWGRr?=
 =?utf-8?B?WW9wS0dpcHhyUDFGaXplVzlpNFpNWjF5MEZMZllYc1ZFMC9BVFhNUXY2UzB2?=
 =?utf-8?B?NllTTTdkSWV2MGZjenFIZ0VkNXgrUmxBZDV1RVJ1SDdwc3dtNkYyQ0pjdzg4?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <941C997492EBAC40B8EA4D973F5862C6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SwJpc+7XSYz5RxDVrperIKgSRhe/1B3lZJl1Yh780c8VNO+88HGsZfQG0rJa3O5cWYxYFm5cFbCzhwi+mq2RlGnH1HnN+wXH+ofpZt6KzUhOqU1zwu5mqQBNovriNEKJWVW50w2lRVG3TmnLgaXgUX664/tn99dgLCWsHsa9er2SPJo2V9Ctw+bLZbMJ3hNcZ0t8u7i3T9r3nJ/t2aEWanB3awgZMHAne+eQO9I28hlv9C2DxZt4g3kl6P4flSPpWU5g7+JV1gohpNHO++ydpSXtC3h1fgJJOj4RptPsffVFwFuupxJJMCHGIw8imA18Z3xdDj5VXb5B59CiTlYtI1lI8uuz/QOYRvvgDd0vWCq2LXAxN0T4VGf6AfO2jhFsEqm0a1gwOo90859rKpankfaLtOoYTXs92Ct25CyOL/ZNp0yzi7L195uunUUUWoR2AVbd4Ahi7LuZheeAH5bI060/rffrfvYtHQWz5xyiAUQZZZyoNnZ991pDJT7YN2zmK0hWwF/ZX/GXbagLVVpI0aOa6P8209hBC1rwLyjjIXzA/WtKDm7MqbSo32pO+gLoWOdwQw7Mkw68UnMfak96sIBC3TzoH8Z275dcjFeflZ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ee44a0-4523-4044-19d5-08dc819bb96b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 18:01:41.0105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CzWL9mTK8JYxJGl10rGKkDgq3U3lj1+L4YVqoqlVB3POAqxI9LG4d2TgbXOuflokCZmIFW9jWXIwm94V/iN+zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5094
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310136
X-Proofpoint-GUID: ArOHeVn6O4vNu0U_9c6hdErxRjEUMgob
X-Proofpoint-ORIG-GUID: ArOHeVn6O4vNu0U_9c6hdErxRjEUMgob

DQoNCj4gT24gTWF5IDMxLCAyMDI0LCBhdCAxOjQw4oCvUE0sIE9sZ2EgS29ybmlldnNrYWlhIDxh
Z2xvQHVtaWNoLmVkdT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIE1heSAzMSwgMjAyNCBhdCAxOjI3
4oCvUE0gQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4+
IA0KPj4gDQo+PiANCj4+PiBPbiBNYXkgMzEsIDIwMjQsIGF0IDE6MjPigK9QTSwgT2xnYSBLb3Ju
aWV2c2thaWEgPGFnbG9AdW1pY2guZWR1PiB3cm90ZToNCj4+PiANCj4+PiBIaSBDaHVjaywNCj4+
PiANCj4+PiBJJ3ZlIHJhbiBpbnRvIHRoZSBmb2xsb3dpbmcgcHJvYmxlbSB3aGlsZSB0cnlpbmcg
dG8gbW91bnQgb24gUkhFTDkuNA0KPj4+IGNsaWVudCB1c2luZyB4cHJ0c2VjPXRscy4gQWZ0ZXIg
c29tZSBkZWJ1Z2dpbmcgSSBoYXZlIGRldGVybWluZWQgdGhhdA0KPj4+IHRoZSByZWFzb24gbW91
bnQgYnkgRE5TIG5hbWUgd2FzIGZhaWxpbmcgaXMgYmVjYXVzZSBnbnV0bHMgaW5zaXN0ZWQgb24N
Cj4+PiBoYXZpbmcgaW4gU3ViamVjdEFsdE5hbWU9RE5TOmZvby5iYXIuY29tLiBIYXZpbmcgYSBj
ZXJ0aWZpY2F0ZSB0aGF0DQo+Pj4gaGFzIGEgRE5TIG5hbWUgaW4gdGhlICJDTiIgYW5kIHRoZW4g
aGFkICJTdWJqZWN0QWx0TmFtZT1JUDp4LngueC54Ig0KPj4+IHdhcyBmYWlsaW5nLiBCdXQgd2hl
biBJIGNyZWF0ZWQgYSBjZXJ0aWZpY2F0ZSB3aXRoDQo+Pj4gIlN1YmplY3RBbHROYW1lOklQOngu
eC54Lng6RE5TOngueC54LngiIHRoZW4gSSBjb3VsZCBtb3VudCAob3IganVzdA0KPj4+IGhhdmlu
ZyBETlM6IHdvcmtzIHRvbyBidXQgaW4gdGhhdCBjYXNlIG1vdW50aW5nIGJ5IElQIGRvZXNuJ3Qg
d29yaykuDQo+Pj4gDQo+Pj4gSGVyZSdzIHRoZSBvdXRwdXQgZnJvbSB0bHNoZCB3aGVuIGl0IGZh
aWwgKHdpdGggU3ViamVjdEFsdE5hbWUgIklQIik6Og0KPj4+IA0KPj4+IHRsc2hkWzI2MDAzNV06
IGdudXRscygzKTogc2VsZi1zaWduZWQgY2VydCBmb3VuZDogc3ViamVjdA0KPj4+IGBFTUFJTD1r
b2xnYUBuZXRhcHAuY29tLENOPXJoZWw5NC5uYXMubGFiLE9VPU5GUyxPPU5ldGFwcCxMPUFubg0K
Pj4+IEFyYm9yLFNUPU1JLEM9VVMnLCBpc3N1ZXINCj4+PiBgRU1BSUw9a29sZ2FAbmV0YXBwLmNv
bSxDTj1yaGVsOTQubmFzLmxhYixPVT1ORlMsTz1OZXRhcHAsTD1Bbm4NCj4+PiBBcmJvcixTVD1N
SSxDPVVTJywgc2VyaWFsIDB4NzUxYWQ5MTE1NjU5NDVjY2U1ZDI5ZDFjMjA2NDUwNTM4ZjQ5NmI5
MCwNCj4+PiBSU0Ega2V5IDIwNDggYml0cywgc2lnbmVkIHVzaW5nIFJTQS1TSEEyNTYsIGFjdGl2
YXRlZCBgMjAyNC0wNS0zMQ0KPj4+IDE1OjA3OjUzIFVUQycsIGV4cGlyZXMgYDIwMjQtMDYtMzAg
MTU6MDc6NTMgVVRDJywNCj4+PiBwaW4tc2hhMjU2PSJFZnp1N2Z0dmUxU0h4QlZBSXdmODFqd0Fh
c1EwTTNqNXFXYkVWdU04WDhJPSINCj4+PiB0bHNoZFsyNjAwMzVdOiBnbnV0bHMoMyk6IEFTU0VS
VDogeDUwOV9leHQuY1tnbnV0bHNfc3ViamVjdF9hbHRfbmFtZXNfZ2V0XToxMTENCj4+PiB0bHNo
ZFsyNjAwMzVdOiBnbnV0bHMoMyk6IEFTU0VSVDogeDUwOS5jW2dldF9hbHRfbmFtZV06MjAxMQ0K
Pj4+IHRsc2hkWzI2MDAzNV06IGdudXRscygzKTogQVNTRVJUOg0KPj4+IHZlcmlmeS1oaWdoLmNb
Z251dGxzX3g1MDlfdHJ1c3RfbGlzdF92ZXJpZnlfY3J0Ml06MTYxNQ0KPj4+IHRsc2hkWzI2MDAz
NV06IGdudXRscygzKTogQVNTRVJUOiBhdXRvLXZlcmlmeS5jW2F1dG9fdmVyaWZ5X2NiXTo1MQ0K
Pj4+IHRsc2hkWzI2MDAzNV06IGdudXRscygzKTogQVNTRVJUOiBoYW5kc2hha2UuY1tfZ251dGxz
X3J1bl92ZXJpZnlfY2FsbGJhY2tdOjMwMTgNCj4+PiB0bHNoZFsyNjAwMzVdOiBnbnV0bHMoMyk6
IEFTU0VSVDoNCj4+PiBoYW5kc2hha2UtdGxzMTMuY1tfZ251dGxzMTNfaGFuZHNoYWtlX2NsaWVu
dF06MTM5DQo+Pj4gdGxzaGRbMjYwMDM1XTogQ2VydGlmaWNhdGUgb3duZXIgdW5leHBlY3RlZC4N
Cj4+PiANCj4+PiBRdWVzdGlvbjogaXMga3Rscy11dGlscyByZXF1aXJlbWVudCBmb3IgSVAgcHJl
c2VuY2UgaW4gU3ViamVjdEFsdE5hbWUNCj4+PiBub3cgcmVxdWlyZXMgYm90aD8NCj4+IA0KPj4g
SSdtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZC4NCj4+IA0KPj4gSWYgeW91IHdhbnQgdG8gbW91bnQg
YnkgRE5TIG5hbWUsIHRoZSBjZXJ0aWZpY2F0ZSBoYXMgdG8gaGF2ZQ0KPj4gYSBtYXRjaGluZyBE
TlMgbmFtZSBpbiBpdC4NCj4+IA0KPj4gSWYgeW91IHdhbnQgdG8gbW91bnQgYnkgSVAgYWRkcmVz
cywgdGhlIGNlcnRpZmljYXRlIGhhcyB0byBoYXZlDQo+PiBhIG1hdGNoaW5nIElQIGFkZHJlc3Mg
aW4gaXQuDQo+PiANCj4+IFRoZSByZWFzb24gZm9yIHRoaXMgaXMgdG8gYXZvaWQgYW55IHBvdGVu
dGlhbCBpbnRlcmFjdGlvbiB3aXRoDQo+PiBhIEROUyBzZXJ2ZXIgd2hpY2ggbWlnaHQgYmUgY29t
cHJvbWlzZWQuDQo+IA0KPiBETlMgbmFtZSBpcyBhbHJlYWR5IHByZXNlbnQgaW4gdGhlIENOIGZp
ZWxkLiBXaHkgc2hvdWxkIGl0IGJlDQo+IGR1cGxpY2F0ZWQgaW4gdGhlIFN1YmplY3RBbHROYW1l
PyBUaGUgcG9pbnQgb2YgdGhlIGV4dGVuc2lvbiBpcyB0bw0KPiBoYXZlICJhbHNvIGtub3duIGJ5
IiBhbHRlcm5hdGl2ZXMuDQoNClJGQyA1MjgwIFNlY3Rpb24gNC4yLjEuNiBkZXNjcmliZXMgdGhl
IFN1YmplY3RBbHROYW1lDQpleHRlbnNpb24uIFRoZXJlIGFwcGVhciB0byBiZSBhbGxvd2FibGUg
dmFyaWF0aW9ucyB3aGVyZQ0KdGhpcyBmaWVsZCBsaXN0cyBhbHRlcm5hdGl2ZXMgdG8gdGhlIENO
LCBvciBtdXN0IGJlDQppbmNsdXNpdmUgb2YgYWxsIHBvc3NpYmxlIGFsdGVybmF0aXZlcy4NCg0K
SSBoYXZlbid0IHJlY2VudGx5IHJlZnJlc2hlZCBteXNlbGYgb24gdGhlIGVudGlyZSBSRkMuDQoN
Cg0KPiBCdXQgbm93IHRoZSBjZXJ0aWZpY2F0ZSBtdXN0IGhhdmUNCj4gIkNOPWZvby5iYXIuY29t
LCBTdWJqZWN0QWx0TmFtZTpJUD0sRE5TPWZvby5iYXIuY29tIi4gVGhhdCBzZWVtcw0KPiBjdWN1
bWJlcnNvbWUuDQo+IElzIHRoaXMgcmVxdWlyZW1lbnQgbmV3IGFuZCBkb25lIGJ5IEdudVRMUyBv
ciBpcyB0aGlzIG5ldyBieSBrdGxzLXV0aWxzPw0KDQpQYXJzaW5nIHRoZSBjZXJ0aWZpY2F0ZXMg
aXMgZG9uZSBieSB0aGUgbGlicmFyeS4gSGF2ZSBhDQpsb29rIGF0IHRoZSBzb3VyY2UgY29kZSBh
bmQgZG9jcyBmb3IgR251VExTIHRvIHNlZSBpZg0KdGhlcmUncyBhIHdheSB0byB0dW5lIHRoZSBi
ZWhhdmlvci4NCg0KSSdtIGFmcmFpZCBJJ20gbm90IHRoYXQgZmFtaWxpYXIgd2l0aCB0aGUgdXNl
IG9mIFNBTg0KaW5mb3JtYXRpb24gYnkgdHlwaWNhbCBUTFMgY29uc3VtZXJzLiBJdCdzIHBvc3Np
YmxlIHRoYXQsDQpiZWNhdXNlIHRoZSBSRkMgZG9lcyBub3QgbWFuZGF0ZSBvbmUgc2VtYW50aWMg
b3IgdGhlDQpvdGhlciwgaW5jbHVkaW5nIGFsbCBhbHRlcm5hdGl2ZXMgaW4gdGhlIFNBTiBmaWVs
ZCBpcw0Kc2ltcGx5IGdvb2QgcHJhY3RpY2UgdG8gZW5zdXJlIGludGVyb3BlcmF0aW9uLg0KDQpJ
biBhbnkgZXZlbnQsIEkgaGF2ZSBzY3JpcHRlZCB0aGUgYWRkaXRpb24gb2YgYm90aCBmb3INCmJh
a2UtYS10aG9uIGNlcnRpZmljYXRlcywgc28gaXQncyBub3QgYSBib3RoZXIuDQoNCi0tDQpDaHVj
ayBMZXZlcg0KDQoNCg==

