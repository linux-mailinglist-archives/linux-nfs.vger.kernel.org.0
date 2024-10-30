Return-Path: <linux-nfs+bounces-7582-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900549B6A3E
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 18:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F271C22F5D
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7018C217464;
	Wed, 30 Oct 2024 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D9Zaa+Od";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O1bAKa5+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C985E217461
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307564; cv=fail; b=tzM3hWVJ+kLhov1JS53bTEf7Tt1FHOpVMrlj28noN27YiBcJ2AQqIuaapcCLx3ytB8iT6WG7V/A2sFgjS3RKCpWm92867lDG9x8OpD/+bqp9fi+4Q75rYnjyYFG0zlKZjPG+auAOMqv+qDvkhC+y7uJCTf7CXNnI4/SiwdNIQ/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307564; c=relaxed/simple;
	bh=qo+xrLuLDO7wwcUfQaA1iBBHASZTT+VLNiL51TbNPoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=arHnJOi041kdkRAiV9Juj+nHz5hremCq6UDgOeLTDr3GX4F000bm0bFE7ETdzNDX/UnsgSDkgmBE7ByItoNunCKej6KImeWEB1NNkTGnL9BSaPdRyziVFp42uB3L8BAZiSQ0l3XmFUWFMl8Go8+V9DBBmqF6B0n6/qb7psuTVLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D9Zaa+Od; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O1bAKa5+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UGXZs7017446;
	Wed, 30 Oct 2024 16:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qo+xrLuLDO7wwcUfQaA1iBBHASZTT+VLNiL51TbNPoc=; b=
	D9Zaa+OdJcKx3cRdfwlw6gC/ljMEtKZW5AqlZVYu+Ecf9uUAM4QIMwoQwZl7mG0R
	en/P+iHAoUkBn2qlImdCxslLbXYbDu0AJnnBZkUcoK63nH/KkVNzRYD3TvsxD5vw
	1SjqbZqEDbHgRIfAIwPfwXLZPzIt4pk1hbvVPRDJm/qDi+WPabN2nI8vV3tHIKSC
	2w9ocS1LRX8E5jaBpKIMQhL/Yz+cPJBjLLUucSix/Ij7286bnHVhh4Bvdwk1xHcm
	GzKO0vG4fKnz9w1U9WrOFoplPztv0Aln4Itv1BYxZhgqaYushkbXdML5YfMTy/0O
	LVA5F9NwQwtx6Hjjkh95Gg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxrhbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 16:59:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49UG6rHn004796;
	Wed, 30 Oct 2024 16:59:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2vyph3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 16:59:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atOkpEP2wS74AFXUpXNX7rt0p5FNAgZ1KhjigW21vtnMRWymyNzVlkn5OmHh+ULwUAs3QmRDuzc8tyysV7/TuB0YrcNlPi/XHr76ZBY4fG8Zxqpy0jFhsC8QGCw8RHB9j84yYchk5+kEGTeE2eK7jA8Kre4SOTnpL7V+VXhn6E7bjDSRCOqVAt/O1nAJxA8QohqnrQfRVgDO1F8OYluVQBmDXejtdKauZmce4ObeuuL8FmYWnx6Oz+1n1gLY2WMy9SHNMkQVk9Yhc+gZLYLBcwzM9iXr8rHlp0wQm7Lcas7UR8/Oc+XLzlPCGeKZxdFXrTrBqLAQHDSRDwMinvrH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qo+xrLuLDO7wwcUfQaA1iBBHASZTT+VLNiL51TbNPoc=;
 b=A9VFAu9lcBZ0+rjrj1Tdey0FvVT6n/CmuNBgl2MjZyLHDC+DgJtV4F3Ing0WjXo300mSnZZ3MvUHkmYWwFe9UFyhMMPuVYU0O1W+bBicVkstlAgOhPRqMq/qHzk8ATWEGTNvdGSEIdSqenDFwGdLt/KGUGObTTUiks1T0FyJHDAZdRx1IQyukohBafKOh8+4FPg5MJ3SsfCf8MkJwImdYUpvmg+kbcnaQsA0bLYGaVxNgy3uLVYt0rwrinU1iHoUcPwKLMzQ+baOo+jYuhpoc8dr0mfxWn4VQY8nZ1qqYb5f7yO4UDHJlCT/cwizO7SqY6RFGMdppTC8jeQ91KisMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo+xrLuLDO7wwcUfQaA1iBBHASZTT+VLNiL51TbNPoc=;
 b=O1bAKa5+RdgDDYX8cj3/Wfre5mLh+lRJJ9wZ0mm5jpwhrH47v06NWeGDnM8sOlNhOOHP2HVecS64NjiSY9jGFpg+1E0KLJNgNDFcGvhzFAdfgLk1GDqCOgHKzL6mpuqgfQzuVLXyIN5w9cJi0TBbdyaCYRASfXTzpBRupzA/8DE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5539.namprd10.prod.outlook.com (2603:10b6:303:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 16:59:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 16:59:15 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4
 reexport
Thread-Topic: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4
 reexport
Thread-Index:
 AQHbJWR3BlJOXtfJrUiYxWPBjvAIV7KdyhAAgAAD4YCAABzbAIAAAnEAgAF/eQCAABZ0AIAABiWAgAAF9YA=
Date: Wed, 30 Oct 2024 16:59:15 +0000
Message-ID: <2FAFA39C-09C0-4FCC-948F-B6D0518BE5B5@oracle.com>
References: <20241023152940.63479-1-snitzer@kernel.org>
 <20241023155846.63621-1-snitzer@kernel.org>
 <CANH4o6Pi13aEtQW5-vmuJiuCNzx6tjn1+v=pLUpVMuffX-WkPA@mail.gmail.com>
 <7FB2B261-48F9-4DA0-B4B5-E8E30EC31CD9@oracle.com>
 <CAGOwBeX7xw7cPRXGO5RmLQUgzOjqr-7Bh4EhV=hONpXCAqsX-g@mail.gmail.com>
 <91F0EACF-76BC-49EE-9340-AC60F641B8B2@oracle.com>
 <CALXu0UcAw7xkObkVFFTi6d-F69_qrDwf9pTE+8We3k14CvywmA@mail.gmail.com>
 <B67E796E-1539-437C-9F54-091D178E0171@oracle.com>
 <CALXu0Uf4DfcgOqExZ8RYeHY8-fx_fzqCsqAUJogV2Dx8DMgJzQ@mail.gmail.com>
In-Reply-To:
 <CALXu0Uf4DfcgOqExZ8RYeHY8-fx_fzqCsqAUJogV2Dx8DMgJzQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO6PR10MB5539:EE_
x-ms-office365-filtering-correlation-id: 26032bce-cab1-4095-656e-08dcf9042fdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUxjYjhFN1JFcmJNT0VESVRIUklyODI4R1ZuRTRUODVrb0ZJNG9nUkp4bkJP?=
 =?utf-8?B?VGFQWENrb1NzYkN5TmhqSVhDaDdOeEgxUE5lRmd5SDNkSzFrOVM5dFZWQWZS?=
 =?utf-8?B?UEdtTTV6R2dXSGlXNHExTlRQbjBrQUJqK1NOQXBJZWI4eHowT21PSzFJWnlC?=
 =?utf-8?B?NzVwb3M2YnduYmlVemwyY2VwU1ZlTU14RmhST3BXL2hkMUlBcEloL2UzT3B4?=
 =?utf-8?B?ODRET0JGTlBvSGdidW82WENqVk9RSDlBbGNXbFVaQkgzTjRmdWJ2ZEpDT0ta?=
 =?utf-8?B?dGdTcXlXQ1kwYVlZM05Tamp1MFBYakJFVjY0bElzUmtDbTNMNHJudXpLQW5v?=
 =?utf-8?B?aVpKcm9nNnladkMxcUFVTy9PckVwaE54MGs0UHBBelNMcUVuZjZNclFueGdq?=
 =?utf-8?B?blVOZ1I5UFFyUWdlYlQzWHZVNGRpeG5aTW9ITjRWSFZGYXZGdTNnZU01NnJV?=
 =?utf-8?B?eFVGV1MzTHdJcS9XTFc1NUJRRitxQW9FMTZNb0xEVUxPUTlsUDFmMks5UzVw?=
 =?utf-8?B?dGpuaEI1WEdqSEs2eEVRcjFrZG1DR3pEcHFzaitTWnBnK0I0MEhWNU1seUNp?=
 =?utf-8?B?ZVBQT2FWU0E2WG1qc3FsRTFoSEZBMlZsWnF5bmxRVndiRFZISTlxUm9vR0Ex?=
 =?utf-8?B?WHhFbnAreFNhb1lPaFRadVJQUHF1QUdlNFR5YkRiTHZ1WGhzYWplV3dEeHRy?=
 =?utf-8?B?RnVpYnlpZ1ZzQ1JqdXl4aXY4Z3cwTHVpKzRLdnpYRzNLcldtK0VhaTFxTTFW?=
 =?utf-8?B?ODNzYlNVWXJUZHdMTVJpMzU1NENHam9QUS9CaDdLLzZ6T2JqK0dTWTJpUjZw?=
 =?utf-8?B?VzZFSDNJUkFYYTROQnUxajUvLzloeW50VXA2R2ZxWkZpNzJDYnlpekZrbytN?=
 =?utf-8?B?NGZRc1pyMVAzaVdxeHAyMkxseXFEd0V6aTRSQUZIenEwcGhDWGx6Z3VXUkY2?=
 =?utf-8?B?QXRwUFNVTlQralpETDJWbXY5bnVjRWhoNDlsZnppZ1kxMTFWL1ljL2FWSitR?=
 =?utf-8?B?Nk9TQzVWSTZKTm5KT21oYW5EaENFdDRXdHZoQzUzUXIwVUVkT3NQem4reHFy?=
 =?utf-8?B?b1dnK3JHUXVSeWE1bUFMY3BVTy9YMVA2V2lOcnd3M05QVWpJdStTV3dYbFgy?=
 =?utf-8?B?amY1Q1o5NnBobnJBNlRtWDI4WHQ1RnBXQ3lUdkFrNXRubCtLMloxNWhvSFFR?=
 =?utf-8?B?OHh5Yzkvb2taUDlNL2ZaTWxNRVdOQWxKc0Zvd3VqOXZhTVdnWDVMVEpRU04x?=
 =?utf-8?B?MWtoSmpuYllpY0NydHljT1JMUW92cHN0MkNLRy9EREsyTzBLUWcxcnJSS0hy?=
 =?utf-8?B?K2ttSk9rQmtPekxVSkpiU1J2UW5xdElsUEhydGlxSVczVnFmME9pM0VyTUxD?=
 =?utf-8?B?aTZWV3duS1FNb0pWNFFQTC9Ea0UyNHVpc21IbzE3Y3ptRUNKbmg4eGEwcGdE?=
 =?utf-8?B?RHBCS01DREhQL1hVcmFNckIvYzdsVnN4Z3hBMkJjeFcrZ1l4Y1VubWViR3Fx?=
 =?utf-8?B?WXEwNkVXUWVXRHNYMWdZbWpTQndLYjFnOEI1OGxEL3Rjb0Q5bFZGS1d5KzBL?=
 =?utf-8?B?L29RdUM2S0Q0K0dsRGM1YWZLdDdJK0RjK1M1RWc1TjhrR2NtMlY1U2QwcG5i?=
 =?utf-8?B?R2FWWDVpWUxycXg5SmxUWUdSYjFJUjNxQkJnaFNiQm0yOTVGT2lTU2MxdjJD?=
 =?utf-8?B?bjRNc3RSbCtmYmFGbFlKSlpGUjFvUGNkQWlyOG1zM2U4dUFIOTBjd25md2ND?=
 =?utf-8?B?aWF6NFlVZTJlVVR0OFBKVW9BZjNIYXR6YU80VURkOTBPUWVqTTJYRUJ1MHdF?=
 =?utf-8?Q?q3D11ImiyaJSSxbe7WBeSIMhIt0iktU44m1ck=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEU1WndMVG5tR3g2eHFpbDhITmt4Zy9zdktmejlzUHhUK1dWK3RSN3Bjdzdr?=
 =?utf-8?B?Q3dyVFRFclBKYW5JR3U1M2ZJVG1ydVk5UklDUUtTbmZ4MC9MZEt4RUdjeWZl?=
 =?utf-8?B?cm5hZjZ2MGM4eXIwQlk2blNGYmxqVGg1WFYrcDBmZXNyWnc3MWZuNDE4d1dh?=
 =?utf-8?B?dVJZTmtTL2dKc3BTOTZoQWxOK3ZKQ2F4blBPUkhubnVDZWxvN3A1MWxtSnEz?=
 =?utf-8?B?anRPc0Z6cll2L1RYN0RucjRiVFhVUzE0a1NYdmFGZHYwV2t0OFBIMnljTDVB?=
 =?utf-8?B?ZGZZMW9vcUlGSFhEZVA4NUkzRGltbGpqQkUwV2hqbVhtdW9jaGlnMTZXMDd2?=
 =?utf-8?B?QUhac01vT1hwTnhSaUNjdnN6TUhYMkltY2dSQU5waGZaQ3d4M0FSdTYwbWt6?=
 =?utf-8?B?YWVITkhvaTNnNjJuNUpDM3dkRE44QlJRaDIyZnRPVStxOTRLTDJ0SDdoOW9x?=
 =?utf-8?B?UVArQUU2YkpmVEVQbjFtNEFGVExKL0ZUcjJSaWN0blJmS05xbmdZUkRlbHdv?=
 =?utf-8?B?V09zbmMxVHhvUFRWNis4NkFaTHAzZGppNm9hYXBBUk1YS2plb3MyaW9vdGEz?=
 =?utf-8?B?T09VNi8xS2FnUDBxd0sxZEwyUXV6cjQ3VDFYd0dkVy81NVVSWHB1TVkxa1A1?=
 =?utf-8?B?Zjg4ZHF4akx4NGdoZDFDUUV3bHlTaXhRMzNEVFNTYjdQL1E1U1FBS2licFFG?=
 =?utf-8?B?L0JqSnVaSlkrSEtGaEd5Nm5wU3Y1dmRTeHFrRnFWS0dmdGZ1TDAxaTlYRG5S?=
 =?utf-8?B?M1QrSXZ2eWwvQ29qUkFWa3lVbzNrdjZwbzgxOWZmZmVNNk5VMzRUQUhRVjhP?=
 =?utf-8?B?L3VMVmJSTGJxZzNjKzQ5VUJVTUx0UXk3ZU5uQkFmeEY0ZE5KREhaMmoxN0Jw?=
 =?utf-8?B?TXVXaGFuZ3NwaW9rdTZQSll4dnlpbHcrNlZqRHZFaEE3YVZFanc5MWpXNSs4?=
 =?utf-8?B?alNvNzlkUFB6RkExOFgyTlhwQ09pbTZ3RDFZWldQajRYa01CSFIveDY0aUlX?=
 =?utf-8?B?VnRSZ05MOXJha0VXNDRjVHFnUS85VlpWOHZSOFc5TEdUdk01WENtWW9EVVJi?=
 =?utf-8?B?RHRkRkNkQk1TWndQRkNVNm05dDA1NXZEWXhSblp6OFFSNE5hYnd4c1RER0ZS?=
 =?utf-8?B?R2MzVHJrQzFkcUJ5aEdMQXF3VGNGMVNZL0Q5WTlycUpmSTBTVU9zY3ZRNFhO?=
 =?utf-8?B?SXAxYTZ0Z0JkWUc2NGE1R3JwWTBBVDlXaVlVYmtNVWV3RzNYNUx4dE5UTnhz?=
 =?utf-8?B?eFhMY3A3SW5WU1doQzFWOFNpb09qWDdDVmNnNThTek8xVHhHb2V0S3d3Mlh5?=
 =?utf-8?B?bFZNeVRoVGQ0bVRoOUdrYUhPYkgvRE1sZ1ZSdUxjSFdkcVZXK0hTOHhTanQ3?=
 =?utf-8?B?Q21XM2dDT0FPTHpnTmpFbzJGZitwbmJ0NU5CblBpREFnbHFQV1I2dFdRdVNY?=
 =?utf-8?B?ZENZT2JncGtCTjh3Nkt2RE8wdmgwZnl0eks5VXA2VXFOU01zN3ltV0NHeG5m?=
 =?utf-8?B?RzYyMlZzWGxSc0RSYlpJZDZBUzZaVGc2MC9tZUlUVnFETEZDUE5TdTRQWUNs?=
 =?utf-8?B?TXIvRDRFWmYycVFWK0d6ZUIxTkZpaXFPajRnejhLUXI1alRCTGNocnAzL0Rv?=
 =?utf-8?B?UENBYU1NNTF1Um10SXdzUEtUOUhoWmxJN0FMZXhGNlhxY0Z6OWltZ3c4TTJT?=
 =?utf-8?B?RWhzWStYS2duMGZJamRSUkRxWm5pR0hHbXNla2NTdUhkZW51cDNiT2JvS0ZN?=
 =?utf-8?B?WTBZeC9CTThtMkJuV2IweGFLRmVRalFuSWZxdE53TEtHVDg0emF2bmtUQkVy?=
 =?utf-8?B?aVNLWjFHbHBaVi8zc1gwT1ZHSXlXaXJxSmE3WldTbEQ0amN4QUxRem1hb3FU?=
 =?utf-8?B?QzRpMFRvY1c4eWJ0Ky9CS3A1N2xGa3MrbGU3bU5WeEx0RkJSSXBGT0dvQkZj?=
 =?utf-8?B?RjZtQ1RmaHJuRUpvemZsUGFDOG9zektBbUdyQXJpT205cGRocm1yWVFXUEkx?=
 =?utf-8?B?WFpnbmdwWEU1RzBrZEpaenJUMGdHelRWelFnOXVjTXYvV1cwNHkxQUJSR255?=
 =?utf-8?B?Z3RqcUJ5NWo3MkhNeUtjNnlVU1RqZ3hLdlcrNU5XM0YwWTlWc1gxUk0yY0Zp?=
 =?utf-8?B?UEtOeXlRelZETG4zTDd3U3NBYVdtcEtzYWJxVEhzdHVwYUpGcm52UU1oSmh3?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1602F3B4F063254D9DD1A1C08AAF1529@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xaaVQupeZX7umtNQd5Eihb0YtSulUw+20VKEAcvGmhlHFBj6fsCEsgDREzWoMxhx/oXU4X2I8Q70lUR1JWywdX8tjvGITwQmZKyx9ZBjpwWWwEWOX2lqK4jdZKSpJI/C4PQ4fA6okt2bakNBYDuCZr3dmPPJs25AgKqOteRqOGvYnFSoDUymxeIq3mudAvWnpiEPx3PsvNo+qA3K+NyahGjtzxy9oH/hAcLd9N786+hOeKdmqAaKJZUW9CvczkiQEFMxupTaY3I7kU0ppSWsecZJMgqBkcdVTfqDmE5/5ts4zoW7CK/Ct0hgVXiX6hx1xy6J/l4ctA5rj8xJN2Tmjq+qLMgoTvtDGUcDFH32FGYoHNIuL9pTUi4xIdEyg5pgOC4olTL+Y+H+edSqSXhCEDRiyeoicUf9hfLtJmm4NaBV6MycM1mQn8hm4Q19IbnRccisd3lZQuA5+zmfS5/3wphAhg3VRd+0mYmDdYuw3FbNlsbWiSft4dhsEI/TFgTSfEgADnbMtUIl6z8s3FX26/YCZ1k31I9d6X0S4E4NnzXk63VpCf44nbZ6chBfcJDcemkvuQXL0zAkmfmDMzUsKMHfoYyExCJkq6cPKsdx7Lk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26032bce-cab1-4095-656e-08dcf9042fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 16:59:15.7773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtWnr12VnoHleKbr0SLjXpFsqyzcvsippsyPNbg0A1EB+Jp26ODJuiUXSmmjzd6KmgmsErEtU76ciRp/+txU7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5539
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_14,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300133
X-Proofpoint-GUID: 2rGZOfYslHl_4j_zsKETLiRCQ96W6_CP
X-Proofpoint-ORIG-GUID: 2rGZOfYslHl_4j_zsKETLiRCQ96W6_CP

DQoNCj4gT24gT2N0IDMwLCAyMDI0LCBhdCAxMjozN+KAr1BNLCBDZWRyaWMgQmxhbmNoZXIgPGNl
ZHJpYy5ibGFuY2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCAzMCBPY3QgMjAy
NCBhdCAxNzoxNSwgQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90
ZToNCj4+IA0KPj4gDQo+PiANCj4+PiBPbiBPY3QgMzAsIDIwMjQsIGF0IDEwOjU14oCvQU0sIENl
ZHJpYyBCbGFuY2hlciA8Y2VkcmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+
Pj4gT24gVHVlLCAyOSBPY3QgMjAyNCBhdCAxNzowMywgQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5s
ZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+PiBPbiBPY3QgMjksIDIwMjQsIGF0
IDExOjU04oCvQU0sIEJyaWFuIENvd2FuIDxicmlhbi5jb3dhbkBoY2wtc29mdHdhcmUuY29tPiB3
cm90ZToNCj4+Pj4+IA0KPj4+Pj4gSG9uZXN0bHksIEkgZG9uJ3Qga25vdyB0aGUgdXNlY2FzZSBm
b3IgcmUtZXhwb3J0aW5nIGFub3RoZXIgc2VydmVyJ3MNCj4+Pj4+IE5GUyBleHBvcnQgaW4gdGhl
IGZpcnN0IHBsYWNlLiBJcyB0aGlzIHNvbWVvbmUgdHJ5aW5nIHRvIHNoYXJlIE5GUw0KPj4+Pj4g
dGhyb3VnaCBhIGZpcmV3YWxsPyBJJ3ZlIHNlZW4gcGVvcGxlIHNoYXJlIHJlbW90ZSBORlMgZXhw
b3J0cyB2aWENCj4+Pj4+IFNhbWJhIGluIGFuIGF0dGVtcHQgdG8gYXZvaWQgcGF5aW5nIHRoZWly
IE5BUyB2ZW5kb3IgZm9yIFNNQiBzdXBwb3J0Lg0KPj4+Pj4gKEkgdGhpbmsgaXQncyAic3RhbmRh
cmQgZXF1aXBtZW50IiBub3csIGJ1dCAxMCsgeWVhcnMgYWdvPyBOb3QNCj4+Pj4+IGFsd2F5cy4u
LikgQnV0IHJlLWV4cG9ydGluZyBhbm90aGVyIHNlcnZlcidzIE5GUyBleHBvcnRzPyBIYXZlbid0
IHNlZW4NCj4+Pj4+IGFueW9uZSBkbyB0aGF0IGluIGEgd2hpbGUuDQo+Pj4+IA0KPj4+PiBUaGUg
InJlLWV4cG9ydCIgY2FzZSBpcyB3aGVyZSB0aGVyZSBpcyBhIGNlbnRyYWwgcmVwb3NpdG9yeQ0K
Pj4+PiBvZiBkYXRhIGFuZCBicmFuY2ggb2ZmaWNlcyB0aGF0IGFjY2VzcyB0aGF0IHZpYSBhIFdB
Ti4gVGhlDQo+Pj4+IHJlLWV4cG9ydCBzZXJ2ZXJzIGNhY2hlIHNvbWUgb2YgdGhhdCBkYXRhIGxv
Y2FsbHkgc28gdGhhdA0KPj4+PiBsb2NhbCBjbGllbnRzIGhhdmUgYSBmYXN0IHBlcnNpc3RlbnQg
Y2FjaGUgbmVhcmJ5Lg0KPj4+PiANCj4+Pj4gVGhpcyBpcyBhbHNvIGVmZmVjdGl2ZSBpbiBjYXNl
cyB3aGVyZSBhIHNtYWxsIGNsdXN0ZXIgb2YNCj4+Pj4gY2xpZW50cyB3YW50IGZhc3QgYWNjZXNz
IHRvIGEgcGlsZSBvZiBkYXRhIHRoYXQgaXMNCj4+Pj4gc2lnbmlmaWNhbnRseSBsYXJnZXIgdGhh
biB0aGVpciBvd24gY2FjaGVzLiBTYXksIEhQQyBvcg0KPj4+PiBhbmltYXRpb24sIHdoZXJlIHRo
ZSBzbWFsbCBjbHVzdGVyIGlzIHdvcmtpbmcgb24gYSBzbWFsbA0KPj4+PiBwb3J0aW9uIG9mIHRo
ZSBmdWxsIGRhdGEgc2V0LCB3aGljaCBpcyBzdG9yZWQgb24gYSBjZW50cmFsDQo+Pj4+IHNlcnZl
ci4NCj4+Pj4gDQo+Pj4gQW5vdGhlciB1c2UgY2FzZSBpcyAiaXNvbGF0aW9uIiwgSVQgc2hhcmVz
IGEgZmlsZXN5c3RlbSB0byB5b3VyDQo+Pj4gZGVwYXJ0bWVudCwgYW5kIHlvdSBuZWVkIHRvIHJl
LWV4cG9ydCBvbmx5IGEgc3Vic2V0IHRvIGFub3RoZXINCj4+PiBkZXBhcnRtZW50IG9yIGhvbWVv
ZmZpY2UuIFBhcnQgb2Ygc3VjaCBhIHNjZW5hcmlvIG1pZ2h0IGFsc28gYmUgcG9saWN5DQo+Pj4g
cmVsYXRlZCwgZS5nLiBJVCBzaGFyZXMgeW91IHRoZSBmdWxsIGZpbGVzeXN0ZW0gYnV0IHdpbGwg
ZG8gTk9USElORw0KPj4+IGVsc2UsIGFuZCBhbnkgZnVydGhlciBjb21wYXJ0bWVudGFsaXphdGlv
biBtdXN0IGJlIGRvbmUgaW4geW91ciBvd24NCj4+PiBkZXBhcnRtZW50Lg0KPj4+IFRoaXMgaXMg
dGhlIHR5cGljYWwgdXNlIGNhc2UgZm9yIGdvdiBORlMgcmUtZXhwb3J0Lg0KPj4gDQo+PiBJdCdz
IG5vdCBjbGVhciB0byBtZSBmcm9tIHRoaXMgZGVzY3JpcHRpb24gd2h5IHJlLWV4cG9ydCBpcw0K
Pj4gdGhlIHJpZ2h0IHRvb2wgZm9yIHRoaXMgam9iLiBQbGVhc2UgZXhwbGFpbiB3aHkgQUNMcyBh
cmUgbm90DQo+PiB1c2VkIGluIHRoaXMgY2FzZSAtLSB0aGlzIGlzIGV4YWN0bHkgd2hhdCB0aGV5
IGFyZSBkZXNpZ25lZA0KPj4gdG8gZG8uDQo+IA0KPiAxLiBJVCBkZXBhcnRtZW50cyB3YW50IGJl
dHRlci9oYXJkZXIvaW1tdXRhYmxlIGlzb2xhdGlvbiB0aGFuIEFDTHMNCg0KU28geW91IHdhbnQg
TUFDLCBhbmQgdGhlIHN0b3JhZ2UgYWRtaW5pc3RyYXRvciB3b24ndCBzZXQNCnRoYXQgdXAgZm9y
IHlvdSBvbiB0aGUgTkZTIHNlcnZlci4gTkZTIGRvZXNuJ3QgZG8gTUFDDQp2ZXJ5IHdlbGwgaWYg
YXQgYWxsLg0KDQoNCj4gMi4gTGludXggTkZTdjQgb25seSBpbXBsZW1lbnRzIFBPU0lYIGRyYWZ0
IEFDTHMsIG5vdCBmdWxsIFdpbmRvd3Mgb3INCj4gTkZTdjQgQUNMcy4gU28gdGhlcmUgaXMgbm8g
cHJvcGVyIHdheSB0byBwcmV2ZW50IEFDTCBlZGl0aW5nLA0KPiByZW5kZXJpbmcgdGhlbSB1c2Vs
ZXNzIGluIHRoaXMgY2FzZS4NCg0KRXIuIExpbnV4IE5GU3Y0IHN0b3JlcyB0aGUgQUNMcyBhcyBQ
T1NJWCBkcmFmdCwgYmVjYXVzZQ0KdGhhdCdzIHdoYXQgTGludXggZmlsZSBzeXN0ZW1zIGNhbiBz
dXBwb3J0LiBORlNELCB2aWENCk5GU3Y0LCBtYWtlcyB0aGVzZSBhcHBlYXIgbGlrZSBORlN2NCBB
Q0xzLg0KDQpCdXQgSSB0aGluayBJIHVuZGVyc3RhbmQuDQoNCg0KPiBUaGVyZSBpcyBhIHJlYXNv
biB3aHkgUE9TSVggZHJhZnQgQUNscyB3ZXJlIGFiYW5kb25lZCAtIHRoZXkgYXJlIG5vdA0KPiBm
aW5lLWdyYW50ZWQgZW5vdWdoIGZvciByZWFsIHdvcmxkIHVzYWdlIG91dHNpZGUgdGhlIExpbnV4
IHVuaXZlcnNlLg0KPiBBcyBzb29uIGFzIGludGVyb3BlcmFiaWxpdHkgaXMgcmVxdWlyZWQgdGhl
c2UgdGhpbmdzIGp1c3QgYml0ZSB5b3UNCj4gSEFSRC4NCg0KWW91LCBvZiBjb3Vyc2UsIGhhdmUg
dGhlIGFiaWxpdHkgdG8gcnVuIHNvbWUgb3RoZXIgTkZTDQpzZXJ2ZXIgaW1wbGVtZW50YXRpb24g
dGhhdCBtZWV0cyB5b3VyIHNlY3VyaXR5IHJlcXVpcmVtZW50cw0KbW9yZSBmdWxseS4NCg0KDQo+
IEFsc28sIGp1c3QgcnVubmluZyBtb3JlIG5mc2QgaW4gcGFyYWxsZWwgb24gdGhlIG9yaWdpbiBO
RlMgc2VydmVyIGlzDQo+IG5vdCBhIGJldHRlciBvcHRpb24gLSByZW1lbWJlciB0aGUgZGViYXRl
IG9mIG5vbi0yMDQ5IHBvcnRzIGZvciBuZnNkPw0KDQpJJ20gbm90IHN1cmUgd2hlcmUgdGhpcyBp
cyBnb2luZy4gRG8geW91IG1lYW4gdGhlIHN0b3JhZ2UNCmFkbWluaXN0cmF0b3Igd291bGQgcHJv
dmlkZSBORlMgc2VydmljZSBvbiBhbHRlcm5hdGUNCnBvcnRzIHRoYXQgZWFjaCBleHBvc2UgYSBz
ZXBhcmF0ZSBzZXQgb2YgZXhwb3J0cz8NCg0KU28gdGhlIG9ubHkgb3B0aW9uIExpbnV4IGhhcyB0
aGVyZSBpcyB1c2luZyBjb250YWluZXJzIG9yDQpsaWJ2aXJ0LiBXZSd2ZSBjb250aW51ZWQgdG8g
cHJpdmF0ZWx5IGRpc2N1c3MgdGhlIGFiaWxpdHkNCmZvciBORlNEIHRvIHN1cHBvcnQgYSBzZXBh
cmF0ZSBzZXQgb2YgZXhwb3J0cyBvbiBhbHRlcm5hdGUNCnBvcnRzLCBidXQgaXQgZG9lc24ndCBs
b29rIGZlYXNpYmxlLiBUaGUgZXhwb3J0IG1hbmFnZW1lbnQNCmluZnJhc3RydWN0dXJlIGFuZCB1
c2VyIHNwYWNlIHRvb2xzIHdvdWxkIG5lZWQgdG8gYmUNCnJld3JpdHRlbi4NCg0KDQo+PiBBbmQg
YWdhaW4sIGNsaWVudHMgb2YgdGhlIHJlLWV4cG9ydCBzZXJ2ZXIgbmVlZCB0byBtb3VudCBpdA0K
Pj4gd2l0aCBsb2NhbF9sb2NrLiBBcHBzIGNhbiBzdGlsbCB1c2UgbG9ja2luZyBpbiB0aGF0IGNh
c2UsDQo+PiBidXQgdGhlIGxvY2tzIGFyZSBub3QgdmlzaWJsZSB0byBhcHBzIG9uIG90aGVyIGNs
aWVudHMuIFlvdXINCj4+IGRlc2NyaXB0aW9uIGRvZXMgbm90IGV4cGxhaW4gd2h5IGxvY2FsX2xv
Y2sgaXMgbm90DQo+PiBzdWZmaWNpZW50IG9yIGZlYXNpYmxlLg0KPiANCj4gQmVjYXVzZToNCj4g
LSBpdCBicmVha3MgYXBwbGljYXRpb25zIHJ1bm5pbmcgb24gbW9yZSB0aGFuIG9uZSBtYWNoaW5l
Pw0KDQpZZXMsIG9idmlvdXNseS4gWW91ciBkZXNjcmlwdGlvbiBuZWVkcyB0byBtZW50aW9uIHRo
YXQgaXMNCmEgcmVxdWlyZW1lbnQsIHNpbmNlIHRoZXJlIGFyZSBhIGxvdCBvZiBhcHBsaWNhdGlv
bnMgdGhhdA0KZG9uJ3QgbmVlZCBsb2NraW5nIGFjcm9zcyBtdWx0aXBsZSBjbGllbnRzLg0KDQoN
Cj4gLSBpdCBicmVha3MgdXNlIGNhc2VzIGxpa2UgTkZTLS0tPlNNQiBicmlkZ2VzLCBiZWNhdXNl
IHdpdGhvdXQgbG9ja2luZw0KPiB0aGUgdHlwaWNhbCBXaW5kb3dzIC5ORVQgYXBwbGljYXRpb24g
d2lsbCByZWZ1c2UgdG8gd3JpdGUgdG8gYSBmaWxlDQoNClRoYXQncyBhIHF1YWdtaXJlLCBhbmQg
SSBkb24ndCB0aGluayB3ZSBjYW4gZ3VhcmFudGVlIHRoYXQNCndpbGwgd29yay4gTGludXggTkZT
IGRvZXNuJ3Qgc3VwcG9ydCAiZGVueSIgbW9kZXMsIGZvcg0KZXhhbXBsZS4NCg0KDQo+IC0gaXQg
YnJlYWtzIGV2ZW4gU0lNUExFIHRoaW5ncyBsaWtlIE1pY3Jvc29mdCBFeGNlbA0KDQpJZiB5b3Ug
bmVlZCBTTUIgc2VtYW50aWNzLCB3aHkgbm90IHVzZSBTYW1iYT8NCg0KVGhlIHVwc2hvdCBhcHBl
YXJzIHRvIGJlIHRoYXQgdGhpcyB1c2FnZSBpcyBhIHN0YWNrIG9mDQptaXNtYXRjaGVkIHN0b3Jh
Z2UgcHJvdG9jb2xzIHRoYXQgd29yayBhcm91bmQgYSBidW5jaCBvZg0KbG9jYWwgSVQgYnVyZWF1
Y3JhY3kuIEknbSB0cnlpbmcgdG8gYmUgc3ltcGF0aGV0aWMsIGJ1dA0KaXQncyBoYXJkIHRvIHNh
eSB0aGF0IC9hbnlvbmUvIHdvdWxkIGZ1bGx5IHN1cHBvcnQgdGhpcy4NCg0KDQo+IE9mIGNvdXJz
ZSB0aGUgaGFwcHkgZWNobyAiaGVsbG8gTGludXgtTkZTdjQtb25seSB3b3JsZCIgPi9uZnMvZmls
ZQ0KPiB3aWxsIGFsd2F5cyB3b3JrLg0KPiANCj4+PiBPZiBjb3Vyc2Ugbm8gb25lIG5lZWRzIHRo
ZSBnb3YgY3VzdG9tZXJzLCBzbyBmZWVsIGZyZWUgdG8gYnJlYWsgbG9ja2luZy4NCj4+IA0KPj4g
DQo+PiBQbGVhc2UgaGF2ZSBhIGxvb2sgYXQgdGhlIHBhdGNoIGRlc2NyaXB0aW9uIGFnYWluOiBs
b2NrDQo+PiByZWNvdmVyeSBkb2VzIG5vdCB3b3JrIG5vdywgYW5kIGNhbm5vdCB3b3JrIHdpdGhv
dXQNCj4+IGNoYW5nZXMgdG8gdGhlIHByb3RvY29sLiBJc24ndCB0aGF0IGEgcHJvYmxlbSBmb3Ig
c3VjaA0KPj4gd29ya2xvYWRzPw0KPiANCj4gTm9wZSwgYmVjYXVzZSBvZiBVUFMgKFVuaW50ZXJy
dXB0aWJsZSBwb3dlciBzdXBwbHkpLiBFaXRoZXIgZXZlcnl0aGluZw0KPiBpcyBVUCwgb3IgKmV2
ZXJ5dGhpbmcqIGlzIERPV04uIEJvb2xlYW4uDQoNClBvd2VyIG91dGFnZXMgYXJlIG5vdCB0aGUg
b25seSByZWFzb24gbG9jayByZWNvdmVyeSBtaWdodA0KYmUgbmVjZXNzYXJ5LiBOZXR3b3JrIHBh
cnRpdGlvbnMsIHJlLWV4cG9ydCBzZXJ2ZXINCnVwZ3JhZGVzIG9yIHJlYm9vdHMsIGV0Yy4gU28g
SSdtIG5vdCBoZWFyaW5nIGFueXRoeWluZw0KdG8gc3VnZ2VzdCB0aGlzIGtpbmQgb2Ygd29ya2xv
YWQgaXMgbm90IGltcGFjdGVkIGJ5DQp0aGUgY3VycmVudCBsb2NrIHJlY292ZXJ5IHByb2JsZW1z
Lg0KDQoNCj4+IEluIG90aGVyIHdvcmRzLCBsb2NraW5nIGlzIGFscmVhZHkgYnJva2VuIG9uIE5G
U3Y0IHJlLWV4cG9ydCwNCj4+IGJ1dCB0aGUgY3VycmVudCBzaXR1YXRpb24gY2FuIGxlYWQgdG8g
c2lsZW50IGRhdGEgY29ycnVwdGlvbi4NCj4gDQo+IFdvdWxkIHN0b3JpbmcgdGhlIGxvY2tpbmcg
aW5mb3JtYXRpb24gaW50byBwZXJzaXN0ZW50IGZpbGVzIGhlbHAsIGllLg0KPiBmaWxlcyB3aGlj
aCBwZXJzaXN0IGFjcm9zcyBuZnNkIHNlcnZlciByZXN0YXJ0cz8NCg0KWWVzLCBidXQgaXQgd291
bGQgbWFrZSB0aGluZ3MgaG9ycmlibHkgc2xvdy4NCg0KQW5kIG9mIGNvdXJzZSB0aGVyZSB3b3Vs
ZCBiZSBhIGxvdCBvZiBjb2RpbmcgaW52b2x2ZWQNCnRvIGdldCB0aGlzIHRvIHdvcmsuDQoNCldo
YXQgaWYgd2UgYWRkZWQgYW4gZXhwb3J0IG9wdGlvbiB0byBhbGxvdyB0aGUgcmUtZXhwb3J0DQpz
ZXJ2ZXIgdG8gY29udGludWUgaGFuZGxpbmcgbG9ja2luZywgYnV0IGRlZmF1bHQgaXQgdG8NCm9m
ZiAod2hpY2ggaXMgdGhlIHNhZmVyIG9wdGlvbikgPw0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

