Return-Path: <linux-nfs+bounces-16018-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01812C32586
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 18:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577143A2957
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 17:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738AF15530C;
	Tue,  4 Nov 2025 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jx1EGjmk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fLrIpbwU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2442E2DC1
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277308; cv=fail; b=A52BHTaXrI4z1OVCVCU7DMEZFUVrFk+g95DRvGBpSN3FonuQQUe7U9krYnFxyGAdsaWqoz9YcxJ5FGB/hiC8otCvHSPW9s4RkzMsbLwj0iGPwMPMl005Q8O8FSdB8mddqOs33wN+enMXvezijEgeaOOc90qUwg5ApSDKqv5CMt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277308; c=relaxed/simple;
	bh=jIgzzTlXc0LKR/oIo0OTN3nLpyT+FUgW1ld2fFKUMVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KPoFZmgd7cWQbp8ymNDIUsO41/L/icxR12Fb8Mikx+BQEHFOtOcunrXZFgGTKnZByUcqMl3C+xMjze0c+aN+afaeWnLbnOEB3b+/yxjqryFBibLunR/C8jWCslpZN/IPhgzqCditiRKLHpEXkQ/gjeA/afKfGLssYBuzxO97dss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jx1EGjmk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fLrIpbwU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4HNOdM011494;
	Tue, 4 Nov 2025 17:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4QngIEfJEQrGZzw2eyePqBY5TWV9IWe0dLb1tt7J9yA=; b=
	jx1EGjmkxNaTbQ+gxJOzskTQPvCemEKgIhERDVVdn/mSWotItE+qcbzpjPgvpaSY
	G/6oPnY0CQMd+AXU2mOTnzzDZ4Dvyr6+NiJBJ1VCPIoalf1PqxWUwP9kpdb1c/W4
	9GTzRRAngcX0vWe9Rn/Qk2ivTATc/7Nvn1MrniHY00K6xh6j12fETnwHTfEOR2D5
	QlfbfOdlhHZ+aAL2A8B56bripboK9qfKQszIblmc0znQZmgeo2XcIqevWGijt/AJ
	lcyTu6k2g6Y9tfmWNhqJ+ER/UzHZqvqKaMFzq34gvuYbDRDJCnAqXXMOPHmtClcs
	x4uKpbcHyigzM3P17fBZXQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7nsjr1am-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 17:28:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4GhwOe019409;
	Tue, 4 Nov 2025 17:25:25 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012026.outbound.protection.outlook.com [40.93.195.26])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nkp3vm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 17:25:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyhJgruLQ20wMoKSTtwwQyHGImaSX8VAma8OP/CCHlxwLrDVgiUOvfxWvXNw6cpRd2QzggRYNsH6WZkuBiGah9pae0cT8C2ha7jWoWq4OMGBQbqo8KqKl5TR1xC7L/xhBH8Hc5LTqAAaBFlVqo1j2mcDbw9gak/0hNqUBZDANtyNWdAK+ZtRgJ8TLMonrky+CtYrjIVt1f8L06rNcKv3EGhyDmRiQd+bf9iz3qRysJVRThDw/v292dtg/xHNMaCmtgZE3eD53kU9ZX8LGDfzGbGQh5xs4y0XcC8k+quyoKMQDIZo0a+5eKiRVzE19wItlZQkzEazMpz/5407KCF0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QngIEfJEQrGZzw2eyePqBY5TWV9IWe0dLb1tt7J9yA=;
 b=q8xP5quBKJq8dx8PSxR+fl5oaJWQkTb2OBUHZtjb4WU4d9oiaG0UrRIp93uSSPOC3WICevr479SaY7KRAFbCk5uvQLDtuPg5DSdpBz6epr5xX3kQi4L92bVHlFYYZ4RFnk9ZrMn/iiUzTJib/svdDEL5pmYc/CD5dbb2423H0000TrsCZGcV2FjPQ/QJi+GEQJ+u/x1hb1mEWQCsQieyM+/DIb4Rx9OKLsy1oyxaNfJKNYD7Luy8dcOaRGWtlXbm5IacToiGaJGikiDtE9NO9ENHWdGCxQcy2CSKfZ823sXMxFEQkOyeOeQs8U6kv3Vfle25gkWpXZExOcJT5Jh2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QngIEfJEQrGZzw2eyePqBY5TWV9IWe0dLb1tt7J9yA=;
 b=fLrIpbwUT96digpNPtCKNKuIbph+Sukv5ibXRPUs3HvCvkIiEjgYeYk2RnD5oRRS+5IVO2tsrKRqLHi0kC7gI/Og8E1ukaK+mUG476n4k/sE+rv7V/GfVdK2vWLzY4n0DSl6oqeFr+eD3FrS54zG+1ZeLK/wS8xjVwmKSFLMElc=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by PH0PR10MB4517.namprd10.prod.outlook.com (2603:10b6:510:36::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 17:25:22 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9253.017; Tue, 4 Nov 2025
 17:25:22 +0000
Message-ID: <b7494620-6b89-4904-be7d-a8aee1c1f6b4@oracle.com>
Date: Tue, 4 Nov 2025 12:25:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] NFSD: update
 Documentation/filesystems/nfs/nfsd-io-modes.rst
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20251104164229.43259-1-snitzer@kernel.org>
 <20251104164229.43259-4-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251104164229.43259-4-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:610:5a::25) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|PH0PR10MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cba8c2-a61c-46cf-6472-08de1bc72240
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VWwzY3ZtRGdIaUU0VjNtbFZwYVE5WjNxNmhURFYvWkFQczZoRDQwSEZubVE1?=
 =?utf-8?B?d25YQngvNm1GNit6eE5lNS8zMFpDeGxaczJnUlhVQjFRZFk4QW9qRjFDc0dw?=
 =?utf-8?B?VG9jbDVKTGtaWm0xdzFFaXFFeHNqT2Q0dmI5aitnTklsTFR1NmhreWs5WVoz?=
 =?utf-8?B?WWdRVWgzUHdWdzFvUHZYMUI2SThFcng3MDhiWmFTT0FsU2VCQ2dtRE8xRCtl?=
 =?utf-8?B?dzN3QmtOcnVqREFha2pTRWI4WFBKRk5raFY4MjNyUGpYQWFvNXUwNld1bndN?=
 =?utf-8?B?QzlOQithNnhTY2NnNjFVU3FXNHhtZ2l2VFJVcDl2ck5Xd294ZEZJVnVtNldn?=
 =?utf-8?B?QnMwRDRSVSs0bytMOTRvdjNTMTlmNStNRzBQKzdFUFZPYWFydExhZm5rcG1v?=
 =?utf-8?B?NjdIaWN5UU1walFUc3dDT01ZMmZxdHl3ejlxMG9yRWhlaVZiN1p0WklmZ3g2?=
 =?utf-8?B?ZWVFdWExVmF5MTArTzNlK0JteU13UEU5ajBXaWFnNHJjZzhUTUNCam9XZTI3?=
 =?utf-8?B?ZWU1dE0vcktHYzF6WU5wRjZDYzlmT1R6Z0JqeTBUZDdabHBSRFRZVGdwak5Y?=
 =?utf-8?B?ZDB1RzdPcFBJelVnZ1YycjdJUXpFWmFkYjB4b0J0bG00QlR6bStlczJOZVRv?=
 =?utf-8?B?YjdPc29BblJHVGg3MlNDNVhMSkQyTUZyc3czWDFuU0NiRFZVTnZtZ3Nabi9o?=
 =?utf-8?B?WmpxQjRRQXZmckV0NWVXKzJRNkJ3UUNia1NIT21sNkkyOGxobXlRZS9aVmwy?=
 =?utf-8?B?UDA1blJ3NDhkSHRlMGx2cUhjV2J5eEZEaGFvS0c0STM4cDgxUmNvV2xJdCtl?=
 =?utf-8?B?T3FlRFFUQXdxMUxTRS8xSnBrSjNZSlhKNDRUWmh5amZLZ0g1c01LMmpLcW5x?=
 =?utf-8?B?dTBtYWZjWG0xOUVnREMvdUFidUFYcU40U3cweFNmZW5KYVBEYW4xWjREN3NZ?=
 =?utf-8?B?WGtHU1hNUFV4VE16eW1JbGd0OTRPVTZHT3RSbDJaQldKRUp2bG5mYXp4cC91?=
 =?utf-8?B?UDlHUlplVEZyZGxzbHgzRFliOFNTYW1oc1BUK1VDS3BtNWFWQW5IYlpqL1Za?=
 =?utf-8?B?d2YrM3F5Nmtzd0Z3bVFXUUgwMmFZRStzOWFFVXBzV1grZDIxOTEwdnMySFd5?=
 =?utf-8?B?UldHRXBIWG0wbFM3Qll0YWRLWmlHVkJDU2ZPLy9PYmxkSmM2a0gwd0loZEJv?=
 =?utf-8?B?Q2lJMEliRXlwWkZHd2tCM05GS1JTc2l2MUk3MlJoMXF6VGNCV1k5OXBSdTJ4?=
 =?utf-8?B?ZmYrZXgwMGx5SUVkQVVuc1ZKWEJpLzJZN1g2aTNlQjVwU1hSSlI1VlJGTVBl?=
 =?utf-8?B?a04rUWI3clRpTU5FTG96emNiWCtGS0Z3czNLQytDOHBFQlVtUnJiRWYyRWVF?=
 =?utf-8?B?Y2JIT1QyNTArZnl6WTExNGg5ODd4ZnpaU3Z5bEtyNHFHeTJoL1FFcWdhNjJk?=
 =?utf-8?B?TXRYc1BmNnhCak4reWlYYTlLOTZXV2xkTndTaHRRcVoxYVZPMTlmdUlMY2J2?=
 =?utf-8?B?SmVoNDlLYUhVdVBQdHZyd3VqMFZ1eHRRSm5aYUN1QXRFTjkrTk5FMTBML3h4?=
 =?utf-8?B?WktiTGJxZGRZUU1YV3JzbGlKVW9HUnFXb1F5Qld1SzVCc1VtdEJSakFVVlNy?=
 =?utf-8?B?NFA2MFh3SCtNRmdUVDdqdjNEWW8rYy9HRHAyK3Jja3FjSGc5QWJxOG16NWlK?=
 =?utf-8?B?UVgyUGtscVBhUU9oc1Zhd2Q5b2lEWUU0WDd1UzQ5UVBaZDR0UVZHRkdGOExw?=
 =?utf-8?B?RjBhMG11N1E1MktTamZWSUMrOUQyd3BPWjJza2Era2psM2V5MFAzZTRtTTBi?=
 =?utf-8?B?R3ZFRy8waHMzV0xBUlRVZEVkRzZvUkM3aytEeUpsSU1xR1E1cWdzQjZ6enRD?=
 =?utf-8?B?cHovU1JBTDRpcnBZdHVjV29qOGhITVlWL2Fubm5Ga2s5NkN6bGF1NG9KSWNR?=
 =?utf-8?B?MVovRFNFSjJLTGJ5Y1p4NlJJWkNjVHlkeGR4NzZjT3I5V2ZFbzJXQVFyVm02?=
 =?utf-8?B?UzM4c0QxK0Z3PT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TVdYbjRhWWtwbXg0MExyRWhXd3pvekdEL2JtS0N2YTNVbS9LZTEwMlZUTG5p?=
 =?utf-8?B?MHUvYnFOTUxZd25sSEdYMjcyaW5FVmFXd0Rpcys1cXFyWWxDTURlSjA5VFEx?=
 =?utf-8?B?V1E5dldjWWJDSHd2TWI4dnVkRjhhREV1cHU0dGxDUDBWTDV2Sk1LcmhLL1dy?=
 =?utf-8?B?blg5NnV4TmFGTERTL2lPYlVQMmJ3b1ZrN2NFYnErd3hVUDBYTU41QkhSbEdo?=
 =?utf-8?B?Mll2SENhVUU0cEtId1lOQ0xmM2dkdXVmSG9mQUtFRlpQRGZhOW5veGRCL2gr?=
 =?utf-8?B?T2R1ZkkwRUJvb3RHT2hEUU91U0JEbTl3eEY4L1ZScEpUc3dTd0hoaUo5Wmgx?=
 =?utf-8?B?ZFNhSkRwWXZadHN6dmwrcjVLUGJYdUhvdFZMdTZsZzVneThIaWtzZ1licDA5?=
 =?utf-8?B?YUl6dTYzZUdjL21teStOSy9pZVNEdmhiUUpTYm1NNEt3bEEzNHF6b1c4ZTkv?=
 =?utf-8?B?dmRWUWF3Q1JSZzNFL0hwUmtOc3R3UzNvTHJJUzJKS1djUngxWldNV1lhbVdU?=
 =?utf-8?B?OVJmTzZ2d21rSUw1V1ozV2JwYUJLRlpNMUhmQVlPNXp4NW1BZHMvVkh0OEVH?=
 =?utf-8?B?eExTZU9LK0xKalBLWVdvZHN4NEU4OE5YbFdzSDNDSmxoTGk1emVzOEJURjg0?=
 =?utf-8?B?cWs3QnhYYktGZmlNY0hBL3VoWHp1R292ODhvY2ZCMWlZZnZCTVZQR0dudkd2?=
 =?utf-8?B?ditXakMyQnROQWRCWGl1c3YrZWM5QkhjaUg0ZjNQQmVGQTZDWjdwdnY3Tysx?=
 =?utf-8?B?emdTbjB5em5jNHdCQ0FUWUVIYW5Md3FZcG1lSzBmVkpQaXozaVg5QjBpQVJn?=
 =?utf-8?B?ZFc4TTJ0UFhnL3NRODF5RC9KYWFwUkJYVXd6VEFJTS8yUUUybjNkY3loYWxC?=
 =?utf-8?B?UjFFeHl1YWhEY3NPNzR4ZlpwSlpobEprMThWTjlaUXhFU2ZXZ3JsbEplbytF?=
 =?utf-8?B?WlZuRkw0SHBMNDdBWDBJQ1M3aGFnT0MyVmhxK1JJLzhZQTg0RmVRaTdOa3gy?=
 =?utf-8?B?UlJXL2RGQVpHZmFISWF1QVQrQ2xKU0NQb0VBemtCcGN1cFY3bi8xVnFKRUY4?=
 =?utf-8?B?WnE4Qm1CaVNyZWdkdFhZcVNEWGxYR0dDQVUreEVDTU5zNlVLRG5uYm9YM1ds?=
 =?utf-8?B?ZmdFc1h1dEFTWm9GL3ExUDd0WUVQb3ZTKy9OY1NCWHYvZnJoMWVFM2MwYjVX?=
 =?utf-8?B?WDRzaWVUbkFHeDYwZCtGSUUwMjI5UlJhOGJvVW15NlNucklDcDcxL1ZQdTdE?=
 =?utf-8?B?dzVUeS9IdnlDN0s2OXl4Qnl0Y0QyWFJtZW93UDJjYk03aHVKYnRGR1poY1Jm?=
 =?utf-8?B?TDFuemFlbzRTOUdYNGhia1pjOFdyUFNsdHVsdC9aTmxtbnk5REhuaTNjaGNl?=
 =?utf-8?B?aUY4VlRrLzRXbk05L0tONTJLa1ovZlB3YWlvT2NxMzNxUkJJN2oyK3ZLZ21p?=
 =?utf-8?B?bDRKS2RGdnl0aGJ6aHZqM3hkWGM5NnRuMk1ueU9wdk1RV3ZURlpiK1NrM1Bv?=
 =?utf-8?B?RWJtUnRSZ1hyWDdsUWlzU3FuK0JWU3JlTm9ZVzYydURGbVBtRytGRHdic3Fm?=
 =?utf-8?B?Q092VHVGdXkxSUxXam1haG01enVDSTNHQ1pNVEsyTnhJUGFDeWU3UGNTNEQx?=
 =?utf-8?B?SHBxM1M5R3I3Q2tVYWNSdmg1bkhubzQzRWowTkczVzNMeTU0THhUcHV1ZnNy?=
 =?utf-8?B?RlhCc3VKTit3Q3QzYnNqb004Mko2QWZKb01PanVhRU1kR1F5MFNVckc4Z1lm?=
 =?utf-8?B?UTJneXQ3c1dTU1p2RDVxenZjSUFjVTZLYzdnMmFrTGtqUzVWNndkbnl5YkZH?=
 =?utf-8?B?Z0l5bGJJR3Q2YU80SDB1SytKOEVTcnhIVzk3SzFHN1h2UENkV2NhNmZtbHp2?=
 =?utf-8?B?TzlpcTZGalNpbjJPbjJPV3BUaUZxa2FqQi9HZkJFWmszWi9XUW5rdjdNNzRk?=
 =?utf-8?B?VDAwU0szd2NRWXNvUkpzUy9qUlo2UFYzZWVrTTZQTHNacE5Cbit3emh2ejhr?=
 =?utf-8?B?MkN3NVl3dWxKWVBVZmRNemN3RUI4RVR0Y3NRMGJ2SGNJWndWOXd5dXpxODRJ?=
 =?utf-8?B?M1ZRRVV4bGEyUkpiUVZmTE9wYzFITjNIVUhYTTVadGNVOWMyVGh6YUxaM0tW?=
 =?utf-8?B?NTFWdnZCQnppelZ0amJTeFJHeEt0Vm1FZ3FJVXJPS3Q1WnFRcG4zNUEyUzU2?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	87CWWIAivkHkO4FgI7YL1bSE/Z7AN6hwZsKk6vZH9mO9h0/FRNy6WLdQEQv8gFMOFg0aW0mZnxxe0q4xreD9Y7yUUl63wAsERScV53fchj6F4GbRz7Ag1Fs1ANDcVtDACrIHUl8fuycJe+oqxjLSu8qLSStVRWgVZgMycGB2lZXf0YiHT5jIhY+xx+P+Jsg2HnSp4SA9Zom2a1vrztJ7ca1d86mEwWt3jGRkl8kqdg+85XvHfdzyMeIzhTt8An8/K+ebDbuIgHrrLcc+WcpP15FD+/Y5mvbkZSdnECRvfgvg1ll3x8E7wF5B9AvaUUkfUNSv34sOS3qDK0ylJnI/5xcG0xf8NssgMynGutFdiy0PllqhyoUtRM4mHjQjVoGgD/ls6ZEdtejdIFPhCGxVDvpG3YCwMJ1ac7a3KXZ2A9x8LVCQYPKeehqd3gMQR7uL2PxAz8IgTmPnp/U8H16hFNR5dDiaVupwht3v1kktUEvvKhBL23CpCDdfMoMEhbnvvECcRJqqAFw2C5vSUWsNez9TpbYJZXdHyvxidCpWQfr/4MVqzC2blZMZ9iKN10G/LPi21hAqlcEDfVNRlSK1BAus22Fi8IqVj1JSzbd/apY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cba8c2-a61c-46cf-6472-08de1bc72240
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:25:22.7555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2G6E8vxt8Bl5SeRqfp8f2ywjjnoH4bTvpAPJdgP/syvBj0i5+owWl3dd37zA8PXV8tZXx+q6T2kw/dDbm/qPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4517
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040146
X-Proofpoint-GUID: Mnb6kLna2eVIMcetjzEDwYkbSxpPc3J3
X-Proofpoint-ORIG-GUID: Mnb6kLna2eVIMcetjzEDwYkbSxpPc3J3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE0NSBTYWx0ZWRfX4pdq2apFcHOf
 ig76IcmnhnJStOIGZgQTR0KEPsLp00PU82VRgXrK8uxmetD1TlULNizK10Ebn3baS6mMZL5HT8v
 bqvBChpd/Q3GwsxzAYCmBpYrZgqxJu4vVIu+RuHit99AUt/XrcVA7TOi5/ofDflml575p6oKrM+
 y4yWbvglzRMpH4D6UD8eMAZ401p3YIqEYbAP1Ss38KqzhIBLH3k1I36mezFPz5FgWe98EzCuuCW
 h4EOtDVkdphOyKpJqIhx61r2mEAhxDMjst/ELY0HXam2LW8n7A/wt+CfJBd2i0MC1y1qkrT69MK
 hPO9Knd0+6IsMCGtuQdemvWkv0UhP1/qajY0R7/dfDO/Tz/Gf9lHFnJlDPIYqr80qpKDetW4Dur
 Eoe5B+Ruap+9SKyAc+7j4/D+VqJFAl1RERHmQjR6yzogawm7/EY=
X-Authority-Analysis: v=2.4 cv=D/BK6/Rj c=1 sm=1 tr=0 ts=690a37b6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=nDVBkZEsgj93R_hh1rcA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12124

On 11/4/25 11:42 AM, Mike Snitzer wrote:
> Also fixed some typos.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  .../filesystems/nfs/nfsd-io-modes.rst         | 58 ++++++++++---------
>  1 file changed, 32 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/filesystems/nfs/nfsd-io-modes.rst b/Documentation/filesystems/nfs/nfsd-io-modes.rst
> index 4863885c7035..29b84c9c9e25 100644
> --- a/Documentation/filesystems/nfs/nfsd-io-modes.rst
> +++ b/Documentation/filesystems/nfs/nfsd-io-modes.rst
> @@ -21,17 +21,20 @@ NFSD's default IO mode (which is NFSD_IO_BUFFERED=0).
>  
>  Based on the configured settings, NFSD's IO will either be:
>  - cached using page cache (NFSD_IO_BUFFERED=0)
> -- cached but removed from the page cache upon completion
> -  (NFSD_IO_DONTCACHE=1).
> -- not cached (NFSD_IO_DIRECT=2)
> +- cached but removed from page cache on completion (NFSD_IO_DONTCACHE=1)
> +- not cached stable_how=NFS_UNSTABLE (NFSD_IO_DIRECT=2)
> +- not cached stable_how=NFS_DATA_SYNC (NFSD_IO_DIRECT_WRITE_DATA_SYNC=3)
> +- not cached stable_how=NFS_FILE_SYNC (NFSD_IO_DIRECT_WRITE_FILE_SYNC=4)
>  
> -To set an NFSD IO mode, write a supported value (0, 1 or 2) to the
> +To set an NFSD IO mode, write a supported value (0 - 4) to the
>  corresponding IO operation's debugfs interface, e.g.:
>    echo 2 > /sys/kernel/debug/nfsd/io_cache_read
> +  echo 4 > /sys/kernel/debug/nfsd/io_cache_write
>  
>  To check which IO mode NFSD is using for READ or WRITE, simply read the
>  corresponding IO operation's debugfs interface, e.g.:
>    cat /sys/kernel/debug/nfsd/io_cache_read
> +  cat /sys/kernel/debug/nfsd/io_cache_write
>  
>  NFSD DONTCACHE
>  ==============
> @@ -46,10 +49,10 @@ DONTCACHE aims to avoid what has proven to be a fairly significant
>  limition of Linux's memory management subsystem if/when large amounts of
>  data is infrequently accessed (e.g. read once _or_ written once but not
>  read until much later). Such use-cases are particularly problematic
> -because the page cache will eventually become a bottleneck to surfacing
> +because the page cache will eventually become a bottleneck to servicing
>  new IO requests.
>  
> -For more context, please see these Linux commit headers:
> +For more context on DONTCACHE, please see these Linux commit headers:
>  - Overview:  9ad6344568cc3 ("mm/filemap: change filemap_create_folio()
>    to take a struct kiocb")
>  - for READ:  8026e49bff9b1 ("mm/filemap: add read support for
> @@ -73,12 +76,18 @@ those with a working set that is significantly larger than available
>  system memory. The pathological worst-case workload that NFSD DIRECT has
>  proven to help most is: NFS client issuing large sequential IO to a file
>  that is 2-3 times larger than the NFS server's available system memory.
> +The reason for such improvement is NFSD DIRECT eliminates a lot of work
> +that the memory management subsystem would otherwise be required to
> +perform (e.g. page allocation, dirty writeback, page reclaim). When
> +using NFSD DIRECT, kswapd and kcompactd are no longer commanding CPU
> +time trying to find adequate free pages so that forward IO progress can
> +be made.
>  
>  The performance win associated with using NFSD DIRECT was previously
>  discussed on linux-nfs, see:
>  https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
>  But in summary:
> -- NFSD DIRECT can signicantly reduce memory requirements
> +- NFSD DIRECT can significantly reduce memory requirements
>  - NFSD DIRECT can reduce CPU load by avoiding costly page reclaim work
>  - NFSD DIRECT can offer more deterministic IO performance
>  
> @@ -91,11 +100,11 @@ to generate a "flamegraph" for work Linux must perform on behalf of your
>  test is a really meaningful way to compare the relative health of the
>  system and how switching NFSD's IO mode changes what is observed.
>  
> -If NFSD_IO_DIRECT is specified by writing 2 to NFSD's debugfs
> -interfaces, ideally the IO will be aligned relative to the underlying
> -block device's logical_block_size. Also the memory buffer used to store
> -the READ or WRITE payload must be aligned relative to the underlying
> -block device's dma_alignment.
> +If NFSD_IO_DIRECT is specified by writing 2 (or 3 and 4 for WRITE) to
> +NFSD's debugfs interfaces, ideally the IO will be aligned relative to
> +the underlying block device's logical_block_size. Also the memory buffer
> +used to store the READ or WRITE payload must be aligned relative to the
> +underlying block device's dma_alignment.
>  
>  But NFSD DIRECT does handle misaligned IO in terms of O_DIRECT as best
>  it can:
> @@ -113,32 +122,29 @@ Misaligned READ:
>  
>  Misaligned WRITE:
>      If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
> -    middle and end as needed. The large middle extent is DIO-aligned and
> -    the start and/or end are misaligned. Buffered IO is used for the
> -    misaligned extents and O_DIRECT is used for the middle DIO-aligned
> -    extent.
> -
> -    If vfs_iocb_iter_write() returns -ENOTBLK, due to its inability to
> -    invalidate the page cache on behalf of the DIO WRITE, then
> -    nfsd_issue_write_dio() will fall back to using buffered IO.
> +    middle and end as needed. The large middle segment is DIO-aligned
> +    and the start and/or end are misaligned. Buffered IO is used for the
> +    misaligned segments and O_DIRECT is used for the middle DIO-aligned
> +    segment. DONTCACHE buffered IO is _not_ used for the misaligned
> +    segments because using normal buffered IO offers significant RMW
> +    performance benefit when handling streaming misaligned WRITEs.
>  
>  Tracing:
> -    The nfsd_analyze_read_dio trace event shows how NFSD expands any
> +    The nfsd_read_direct trace event shows how NFSD expands any
>      misaligned READ to the next DIO-aligned block (on either end of the
>      original READ, as needed).
>  
>      This combination of trace events is useful for READs:
>      echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
> -    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_read_dio/enable
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_direct/enable
>      echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
>      echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
>  
> -    The nfsd_analyze_write_dio trace event shows how NFSD splits a given
> -    misaligned WRITE into a mix of misaligned extent(s) and a DIO-aligned
> -    extent.
> +    The nfsd_write_direct trace event shows how NFSD splits a given
> +    misaligned WRITE into a DIO-aligned middle segment.
>  
>      This combination of trace events is useful for WRITEs:
>      echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_opened/enable
> -    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_write_dio/enable
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_direct/enable
>      echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_io_done/enable
>      echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable

I'm thinking this one should be squashed into the existing patch from
Sep 3.


-- 
Chuck Lever

