Return-Path: <linux-nfs+bounces-12269-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA29AD3C53
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 17:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5660A3B04EB
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 15:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3319123536E;
	Tue, 10 Jun 2025 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IU2+uzWn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aW2UAjBq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82F23536B
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567935; cv=fail; b=d3C0CNBuBH47BSk2dVXK1W/BBnoT/nClRTK6IiomDDvLbLR+nBq2t+6R7RtTtcmK2IFUiNuwK6cBfT4l4ly3opxdFtKJkjBwlRyy3BRM1T1CG9rtL+ogwMVYODxKbnfvhrguic3CebK6pb8AW4WKoIE+EZE3Vpw1q5lCwn+SZZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567935; c=relaxed/simple;
	bh=+zz8MX+IDLMWgL1kAAncRpoFYXinvCE2QcOyEQTj0rU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RZO+jQWhnugCqjFqiIOF8WfVwEe4I5oSnkCHXvbd6ZoofIl+O5PfVROnSa5DpqUiFEuAJmYm0KOT5jidApK9kVfxzDMkBaypgxZDnxmjwcSLkf4vxCFXp283Q+ObnrVNSTPKmFQdcVwUqBZVE2PCcEbP8SAjp3Xvt7D4n8cZ/9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IU2+uzWn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aW2UAjBq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXZfP006968;
	Tue, 10 Jun 2025 15:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JSSYG2VBNLDnEfKvcX5rJVnCeHH9TgYPn3kYGNPc9Jg=; b=
	IU2+uzWnnsKxYbC4DcFX+2bfluMiHmqHXeiGZqnPuXlPPsRnuU0ztWWf4Wufz+/m
	c358Pq0PG019q1OAx7u0Q1iLlh6TU9fcnpGR2kYTLyrlR7r3c4Yhj1ltMqmBfpLZ
	hLIzduQ4S5m0nbPwQPIYDawSfAoLTHIJ5BXbj3m3L3tOb9LJ1JrVep+VTTmQVMRs
	Yj4DME3HI7PibCGa2UjkFQkk8BIEM4n8f4vyh/3d23WTL3bebk5mpizS3XPQT5E+
	rMNCc+SvaI1rb/eW9QtCfHKXswZsAY16EqVws0FZ5amALyS7kRosQNcMjk8vlkj7
	RJZ6qiWE1dn+hyKyQQ21gA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c74vgfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 15:05:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AExM5c020725;
	Tue, 10 Jun 2025 15:05:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9jnsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 15:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIE/XnJsl2CCLJIW6JlBLiMHG8XNTuNj0bx5PyzcIns82Ef5/nuU9ULb+W9VQGKpI+M9qlhauAJ0PUYCScLFRIrjFDfum3Jl28EoAC9Gh5YGZGT9rgt1jpWWK2i1AEjYtC4jSsKPETYM1rHslcteFI2/fD5lPAyrsiXRdIrm1qRHvbSXaAqTnMx7cQO9lQVy3CMnY/g05C6ZMZJexHJlrTMQSH3zcuW2v9zWlrr7oyMELC7slUsArU9lMUvofLF57I28bvlYATDSF3T3KISh/pwSN15bc80Rg943PUH3eoYEz3/q5cHL6NgWGtUl1GU3fMZhj5eRHV9l/Mto6zbakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSSYG2VBNLDnEfKvcX5rJVnCeHH9TgYPn3kYGNPc9Jg=;
 b=ivWv5Yx79TuY7RYQWY1d4G3JhPkHzk7GFe3dcRuE2hz1g2kFfi1djIDdIHOz0/Cc0nHJpPyCRuNErGJD/jBQtje4aFqgBBuvVXIRteonrbIagmir9CbkBO/uv/T53GOe7VcEN+Q4gBzPaT2wnV/7Ina5IHLfX04jBC4Gwx8XhAYGP6BRiWIeDmPQweoxEbpGmTzTNnN/b3M15c16ff2bCMQZaBAtUIL7RR38H/g67hfxSHyLPIsVEAGew1DoSh8of6VMPk41x97u61XqoHvXXVngFAzpctQ+TLzbZJE2isj5CVMaCcJVmVzsk2gsuNmGs507NcV3Wx6HqwRqwrr96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSSYG2VBNLDnEfKvcX5rJVnCeHH9TgYPn3kYGNPc9Jg=;
 b=aW2UAjBqE4v9AqBky7oPOOhJFD30CuNq8aB2KXZaZ7/ZV9XpfCLe1jMimxAvmMuaCUs6fZAWL9Ot33kgVoFiyCAnPidvSYUITEhe4SuAR2vy53+mf0OdQ5gJuc2UB7OLh4BzJ32eqyVzZFizDfve6kEWhkWrn/xpVM4jpDDzEdY=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MW4PR10MB5863.namprd10.prod.outlook.com (2603:10b6:303:18e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 15:05:19 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 15:05:19 +0000
Message-ID: <03241ae7-7f58-48cc-b163-767cb348ddaa@oracle.com>
Date: Tue, 10 Jun 2025 08:05:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: detect mismatch of file handle and delegation
 stateid in OPEN op
To: Frank Filz <ffilzlnx@mindspring.com>,
        'Chuck Lever' <chuck.lever@oracle.com>,
        'Jeff Layton' <jlayton@kernel.org>, neilb@suse.de, okorniev@redhat.com,
        tom@talpey.com
Cc: linux-nfs@vger.kernel.org
References: <1749562875-28701-1-git-send-email-dai.ngo@oracle.com>
 <f580a2f30274ca61f44d4b8d4b5e9779acd84791.camel@kernel.org>
 <6bc66030-adba-48c0-a992-82f7bbb153f3@oracle.com>
 <7993b2bf9c38041f8963e9161aaa25984b50d3f1.camel@kernel.org>
 <c187763c-09a3-4027-9833-a78244a4329b@oracle.com>
 <34500150-e2b9-4b88-acae-aebeb1694916@oracle.com>
 <11364da2-761a-4f67-9bb6-908e9d718f5b@oracle.com>
 <09eb01dbda17$6e4f8610$4aee9230$@mindspring.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <09eb01dbda17$6e4f8610$4aee9230$@mindspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::30) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MW4PR10MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: e62c06ba-8f11-4b7e-fc3d-08dda8303705
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RFNIbG85T2ZIV0tZa0JMKzY1YmMrbmdnbXUwQTcxTW5rMnlhWHQ3bHZERkdy?=
 =?utf-8?B?UmxDWWZydXNqRlhJK0ZMalh1QkxaSWg0YWRweVFxMitPdDR1ZFg4WGhrWnBO?=
 =?utf-8?B?WjNUdHQza3FzQThFbm51dGs5bG1rQ3BQRUJOVklocXM0SzFySUNHUHUzQ2ZH?=
 =?utf-8?B?RituQ3FOa3dZTFl1cHo1R3cxYW0wblk0ZHFKYjJoZDd0QWxpTld6ZnQ4dXNw?=
 =?utf-8?B?RmphM0NDTUxhZ0xjdDZLdGFmM2wrT1hsS1ZqWmlqSmVQVzFibE80eGxqUkpt?=
 =?utf-8?B?cXlVMjF1SEIvWnI3SjFPQXdOcjNYdlRBb3ByTHdLdUh1a3pENGhHZ2R2NE1W?=
 =?utf-8?B?bzlNcXhwVlNocDJzaS9qVk5UbXd5NlE5UWxONmgrZlVxaEU2clFUVkVJdnU0?=
 =?utf-8?B?bnA1ZFJJN0tieUU4UUVRWTlza0Y0WHpETUhuRWZ0UVFHNmJlUUcySHZpeGgv?=
 =?utf-8?B?N3FFWittWHo2d3FTUWxBell6SVdzZXBjR2hxRUxoWVZ5MkhsN2Fjc1ZNU1Vi?=
 =?utf-8?B?eDNKbEtNZVZCWjJrMXd5dXJjYjRtWXJQVW85K2Z5U3Zab0ZrNHZhUEFwYjZZ?=
 =?utf-8?B?L3ZoVXBUSEt5SG1ENDA5Rjl3SUE1ajk5clN1bHFLZEFWUHN2bnBHcWZYRnBT?=
 =?utf-8?B?S2xUaFlVK0YxenBwczBGZ2lQc0hIeTVZQ01BWnJ2K0J4bzZybkFFUGJ2U1Iw?=
 =?utf-8?B?M0VSaFBxODBVczFRRjF4ZkVyb0pBeTk5bWxMR2k3WW5yY2wvb2hFQzFRLzBp?=
 =?utf-8?B?cHhaY0hYMVlFN0pHUERIaVg4N2hTK3liOWVQS3lMZ1VOTVZ1cWt3YjdJdktK?=
 =?utf-8?B?eGF1NC9aWmFPMGZXRmNwWGtMb3Y2aTRSb0hGV1N4YTBPRWpiWEZpa0lxQ2gx?=
 =?utf-8?B?ZUQ1WkJzWEdYTS9Sc1VzTXg0cXJpZCtKSW16OWo4bTFKUjd2Rmx6MnRma3Rj?=
 =?utf-8?B?WW1TTzNLcTdwYUh4L1pVZVJaMVBHUEF1U3h5Sm5BVmVOdmZDdGpTb2JKelVj?=
 =?utf-8?B?dUc4bXgzUWtpNE8zWVB6dEJiSUorMXRVbEw3VDRISUJlMGRsdHlISUVibE5P?=
 =?utf-8?B?TUFlNCtCcmpPbC9welppVmozVXZ6MHo3ZWVydE1qdlhZWWlvMmRFKzZnODNR?=
 =?utf-8?B?WlhPMnM4SngzSlNXRktXaXpybVh1Q2c2dWxiaEpncEpLQlI1K1FqY3JhdGND?=
 =?utf-8?B?Ty8vREFtRlNpaStINWp2UU0xWkdZbnQ0ak8wUmxVc1c4TzlKMlAxTzViKytQ?=
 =?utf-8?B?MTM2TktFQk9GTG1NT25FQ1lmMk5FVXI0TzdYelZjaHlUczNoYjZraWR2cDBE?=
 =?utf-8?B?ZEJzODJtM0xGcDgxU00yRFRkL2dPdTRYcE1HTENVMVh3c3NjdmRudDdxanZy?=
 =?utf-8?B?a3FxSkZWV3pBQk12SmlxMkhLTHVhYkgwRFBZTlBHZHoxUG1jb3l2TFVXZlJq?=
 =?utf-8?B?NFYvVlE1S0RlZ1daaHRKREhQNTgzbjQ2eXBWdGxVNFZzMmE4SzRYbkIzcXFX?=
 =?utf-8?B?TWpvSjlOdStqWXdDWEpOQllOUlBPU251NnQ4dzBWNmZTTUJPMzk5dXQzU0Iw?=
 =?utf-8?B?bllSYm9VREtRYWJ3MmxEV1BlZGJhdTNlV0UydW95MGxZTS9LUkZXQ3VETDQ3?=
 =?utf-8?B?MzRQQ3FJcGV0ZEI0L0treFRlKzhpaGRZa3dSelp4V0NOZ3kxSlZnUnowV2hO?=
 =?utf-8?B?WHBCQU1DTWY0anlSL2dLVGJsdVJXWlArQjZpenNDdzBaTUhqWnBkQ2RkL0Nw?=
 =?utf-8?B?bHZuanRTMWpQUndaOUsxdDlZN1RxNERTWTc1V0wvNncxWkZNem9WNmVicndV?=
 =?utf-8?B?Sy9zZ1Q2T1Q3VlhESWRMbmZvVzFXTCtSWDZRMUR2c0ZPQVhpWlRVdWlvNEJ4?=
 =?utf-8?B?RVdIRElGU2hOUHdYUDFiWnN5QzVDOERNbEZweXBJRDRzYnJ3OUlOLzdIcks5?=
 =?utf-8?Q?RFFSVtSp8+4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UGVFaVUyUytmb3huc0E4UE90OTBVUEJTanJZVlh4cXphRDRKczlCZ0tDQUxW?=
 =?utf-8?B?MURRNHhQcHBQL3NhUEtWaVhiMy9ldDZyUFBKM0dnY20rYUxYVnNaaVF1RXBZ?=
 =?utf-8?B?b1BDTGF2bEZqaVZEQzVUNjM3cVFwWkpQdGI1Y2FGLzE4b1NQZlJvekFhcm9G?=
 =?utf-8?B?MDZYVGJNdVlKVmdmaHhPOGZMQ0pla1VkcDJPdjdNbVVhNEV6R2ZwV2FqaVgz?=
 =?utf-8?B?S0k5SUluZHFhcmcrSUxXWVZBRVBlWUFzaUhCRWEyRGROYkNsQkw3T2Y1SExt?=
 =?utf-8?B?OEhndmQ2RW05NlQrRFl3M1lLOVNkQ2hsbUZzR28yTHNub0RxZmV3M1JMTTM5?=
 =?utf-8?B?WTR0QXF4ZDlOVkN1MnlCOEEyTHlIczlPVFpycGxOdGZ3Y0owN0ZSbTdNQ0lU?=
 =?utf-8?B?RUVIcmh6WWNFK0pTMVNJVHBOSDRJbld1QjN2SVpuNFJhb3hycy9JUjE5RWk4?=
 =?utf-8?B?WXFQV29QZnN0TldnTUxwdXZzQmRnQW1YMDJwbkJ2N2dpTEhrQnFtdlprUnhW?=
 =?utf-8?B?NXRVV1JaUlBseWd1SDk0VzlSN0VQRFowV211djZmSEhTblBUVW9UQ0dkeldW?=
 =?utf-8?B?aW50L1g0NEZoQmJxV1Vvc0JmMmdPeXVremlBQk00dW1RRjM2ZnRiOUZ3VTJ0?=
 =?utf-8?B?dUtQR2NvYmlqR1Y1Q1FzeFNjZVpyRWZTV1lmcjhzZVR0MitEaUVCeFlyVHZL?=
 =?utf-8?B?U2JWWkFTN1U1L3NnQjF0eERXWU1NZTFKUzdYZmNvS2FGTVhWVmVGL1FZUnNN?=
 =?utf-8?B?S3ZRbXlRN1pVUXM5Uk1iMmFTRFhBMXdTaEV2ZXBxS2xDcnUrRC9wdTA5WnBU?=
 =?utf-8?B?bUdua3RBNjE5ajlkS29Hdlloencyd3NNdXpKNFBSTG1JdkY5L0FDKzRNK2Nv?=
 =?utf-8?B?S3oxRjEzQW1kUG9OU2dPQ2lPaHF0QkIzWUM1WGZUb1RKVFgvTlUzL2dnLzgw?=
 =?utf-8?B?YXQ0M2N4NDZETW9EMHNjM3RrUVVTNklQV2pTdTRSTzNSWmJYeDlyZmVJZ3Rk?=
 =?utf-8?B?eWR3UTJyVlZzbDJLUGYwMENQUGhhUEphL2M2REg5Y3pGbGtaZURwVERHL1ha?=
 =?utf-8?B?THNxZ2RQRzBWcVQrRDE0MFB1MWVTZUdiZi85NWZOMlZPWGVld3E1Q291azNv?=
 =?utf-8?B?R2dsNkJ4cXdveEtDTGl2Q2d1ZnhiQVRGZzVsVC9NNmxrUjdiMWMxNlFoU0t4?=
 =?utf-8?B?S2oxZHdYblY2OVJ1akFnZGF0WlBYYUl0UXlmMTQ3S2FrSGVINHF2YzRReW40?=
 =?utf-8?B?RlVvRnpxQ1JRcE9YaUJpNXB6ZEwrSDIzODVIRjJjdk9NUnNXekVCalBxV2VB?=
 =?utf-8?B?NTZ1eVVoNFVqOUZza0RTNFU2QzNBUlhpQ3Z1QUQ1Vnl6Ykt5ZHQvNmZpMVI0?=
 =?utf-8?B?QXFYSDlvTzFlSWJxYUdEVERBTCtlYWdralFsVUFkdFFDT1VKZVNtTHF6VDUy?=
 =?utf-8?B?cXY3ZER0Tm44T2NYK2tqM1hMekQ0cDQzNHkrOFkxT2RMTFNKam1nMFo0a1ZG?=
 =?utf-8?B?SjdQcXRMK0JzYkxxc2pTOWZBTlY1SVR3WVh3bUdSdDNZdWxXWUw2QXQvOU80?=
 =?utf-8?B?TStxVU1lVmhSWTNsZDRiZFI3TGhYNC9ta0EyRkhmU25FMGRGR1ROTGh2bWtD?=
 =?utf-8?B?Vlg4RWROdFVka0g1SmJUSHFsUE1QVXVZWnVPUHN1Z3dKNTdGR3g1VGg4UXBB?=
 =?utf-8?B?UEtmL3hCRWxETDFhT0dWRVBvNm00VzN6dHRjdFdhaXZSUFlZNFVXUE5KRzdo?=
 =?utf-8?B?WVdYVjVQeDNqbFo4WFAxa2lLK1BnNDRhc3BZbkJJaUN3dVlhR2RSUEwvM2Yw?=
 =?utf-8?B?aytDYys0MEI5dm1iVnZrMEkvRm40cEtjMWRWYUUvZWpMSlgrbHFmT3dRek5U?=
 =?utf-8?B?MEFwRkFmZXo0b1FkZ2tKVEpZdkhxS0cxSnNJaVZ0bzhjbHFCN1pWMWRuMHVs?=
 =?utf-8?B?THp0UU1lSUV3SmRNMmRIMWFFSG1NQ1lldWxFQVltOXJVOXlCMkw0UFNSZ1ZD?=
 =?utf-8?B?L25FaUFJSzhmNW9VaklRT3YzcFV6blVrc0didEZmajM0alU4bFJ5a0V5bHVj?=
 =?utf-8?B?SWxHcXE4OUlKRFhEZElwVCtkeFBUbld6RUxhWlM1SVNXckFMMWNhMjFFV2Jt?=
 =?utf-8?Q?L/qJ7E76JP1sdw9HPFcBfI3vd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bECfpDxtmgnsP7C6AX1c+5NfZDTIVJ33HmHMFaUolPz78FBbrVuDXL9CV+C89j7jMHvGhEyEYMJBbIvl114ryA7q8TDNAJR98sOPlw+Egpkm5jY/LV0gRWeYFsG36vVByOERmbXu/81QFllOTvwbgoXHoqMo8f+9CFOuv88vuVBqbi7GqeDUKA1YT3GQfqPxsDI4p5WLcMN3uNVe9vMytLZCXS/e+7mNjrAAH6QAvKPymDe3txjDeZLz0HSpgc8SmtQQ4+FwiUXRmzKmQOxrZzyiGlUHXaBCmFw4RxzGrEY7cQ+GxCt2ratF8DYGc9pkEx8/PtSaO4y0wHmo2lxsUzAWiJce1sX9hjFR3U1OE808bAairzTTh4jMkwo4mvRdXVhy+wtpnN1EK9ooiQPt+Gz1AiWKARYHbZS5qLmDgDeQu+7WbAlGpsTpl2MQcJrqaEPnIi4l8Fumgl6LHM15w7x44gS1rR7TZ5/yF5o63nfX2f1qu0hO33tO5jQsKyOlSKKAWEjTLl5D5r4rLKEPOi9rnqHHYKhXY0MyoDRFUPgE95rcGvqUc8D+WxSTpqN2/AaBSTtbgDAjY3+5ZDMF4sSrn5ISadbQL/9UC8gmUbk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62c06ba-8f11-4b7e-fc3d-08dda8303705
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:05:19.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwHPARRentXaZE5T8XdbFdfGDrHudbbOhYZ3SCoJvl12gOhTZefbuUANmymPeg/xNwBtHyBOjz8OP38LwKM8Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_06,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100120
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=684849b3 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=0BfE72rrSiIkGaD-YzoA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: mw4XVId5I8PawFQ40Ujba8J1_sEt0VwW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyMCBTYWx0ZWRfX4uk57GuWXHyu o7G5y9gQQ+6A4AsS0fZuqNGU2UJc63tfllVLQUwL9gCC2jcDY5mJGdk2PEjI2IBKtUorEjMTKhy Jr20+30i3tqz7KVg1gQl6SYAA6ZjDUsCgC8nD9V5lQ99xzABzoD6J0ZNc/nNKQa/7MSUQ/wU6QF
 HWE4XFbbwXhOZO3l0nFM5LHFJk9TiZnNmLfnbh1hVuUSWrLoXLpwV0L+yC7/+Kmx5GiBxviaD+G /pnWgnyH/IcbGJzR5hhkdvJB9RuYf9umF9aRxwG1r/TiZaui3RUddpVJK8O+FAZDxYego2On/3y X2V8dm5DcWEKI8+g4b7s2W2IAMUtZtCt0Qdi8e5H5z/XQq2+pU/xyKmnrnIdcJE+tvPZS6TNUWu
 bToA6GSG/tbyNHTMCFRE0yvebg8zJXsNya/AI8wIPIF8x6eEK9HNixXulnz6ss7IKfeCAzfm
X-Proofpoint-GUID: mw4XVId5I8PawFQ40Ujba8J1_sEt0VwW


On 6/10/25 7:53 AM, Frank Filz wrote:
> From: Chuck Lever [mailto:chuck.lever@oracle.com]
>> On 6/10/25 10:12 AM, Dai Ngo wrote:
>>> On 6/10/25 7:01 AM, Chuck Lever wrote:
>>>> On 6/10/25 9:59 AM, Jeff Layton wrote:
>>>>> On Tue, 2025-06-10 at 09:52 -0400, Chuck Lever wrote:
>>>>>> On 6/10/25 9:50 AM, Jeff Layton wrote:
>>>>>>> On Tue, 2025-06-10 at 06:41 -0700, Dai Ngo wrote:
>>>>>>>> When the client sends an OPEN with claim type CLAIM_DELEG_CUR_FH
>>>>>>>> or CLAIM_DELEGATION_CUR, the delegation stateid and the file
>>>>>>>> handle must belongs to the same file, otherwise return
>> NFS4ERR_BAD_STATEID.
>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>> ---
>>>>>>>>    fs/nfsd/nfs4state.c | 5 +++++
>>>>>>>>    1 file changed, 5 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c index
>>>>>>>> 59a693f22452..be2ee641a22d 100644
>>>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>>>> @@ -6318,6 +6318,11 @@ nfsd4_process_open2(struct svc_rqst
>>>>>>>> *rqstp, struct svc_fh *current_fh, struct nf
>>>>>>>>            status = nfs4_check_deleg(cl, open, &dp);
>>>>>>>>            if (status)
>>>>>>>>                goto out;
>>>>>>>> +        if (dp && nfsd4_is_deleg_cur(open) &&
>>>>>>>> +                (dp->dl_stid.sc_file != fp)) {
>>>>>>>> +            status = nfserr_bad_stateid;
>>>>>>>> +            goto out;
>>>>>>>> +        }
>>>>>>>>            stp = nfsd4_find_and_lock_existing_open(fp, open);
>>>>>>>>        } else {
>>>>>>>>            open->op_file = NULL;
>>>>>>> This seems like a good idea. I wonder if BAD_STATEID is the right
>>>>>>> error here. It is a valid stateid, after all, it just doesn't
>>>>>>> match the current_fh. Maybe this should be nfserr_inval ?
>>>>>> I agree, NFS4ERR_BAD_STATEID /might/ cause a loop, so that needs to
>>>>>> be tested. BAD_STATEID is mandated by the spec, so if we choose to
>>>>>> return a different status code here, it needs a comment explaining why.
>>>>>>
>>>>> Oh, I didn't realize that error was mandated, but you're right.
>>>>> RFC8881, section 8.2.4:
>>>>>
>>>>> - If the selected table entry does not match the current filehandle,
>>>>> return NFS4ERR_BAD_STATEID.
>>>>>
>>>>> I guess we're stuck with reporting that unless we want to amend the
>>>>> spec.
>>>> It is spec-mandated behavior, but we are always free to ignore the
>>>> spec. I'm OK with NFS4ERR_INVAL if it results in better behavior (as
>>>> long as there is a comment explaining why we deviate from the
>>>> mandate).
>>> Since the Linux client does not behave this way I can not test if this
>>> error get us into a loop.
>> Good point!
>>
>>
>>> I used pynfs to force this behavior.
>>>
>>> However, here is the comment in nfs4_do_open:
>>>
>>>                  /*
>>>                   * BAD_STATEID on OPEN means that the server cancelled
>>> our
>>>                   * state before it received the OPEN_CONFIRM.
>>>                   * Recover by retrying the request as per the
>>> discussion
>>>                   * on Page 181 of RFC3530.
>>>                   */
>>>
>>> So it guess BAD_STATEID will  get the client and server into a loop.
>>> I'll change error to NFS4ERR_INVAL and add a comment in the code.
>> Thanks, we'll start there. If that's problematic, it can always be changed later.
>>
>> Maybe someone should file an errata against RFC 8881. <whistles
>> tunelessly>
> An interesting case. Ganesha doesn't handle this. It would definitely be good to see an errata for it. Also a pynfs test case.

Here is the pynfs test I used to test CLAIM_DELEG_CUR_FH:

def testClaimDeleg_CurFh(t, env):
     """Test OPEN with CLAIM_DELEG_CUR_FH with mismatch file file handle
        and delegation stateid.

     FLAGS: writedelegations deleg
     CODE: DELEG32
     """

     sess = env.c1.new_client_session(env.testname(t))

     # create file-1 with read-only access (0444) no delegatation wanted,
     # and leave the file opened
     filename1 = b"file-1"
     res = open_create_file(sess, filename1, open_create = OPEN4_CREATE, attrs={FATTR4_MODE: 0o444},
             access = OPEN4_SHARE_ACCESS_BOTH, want_deleg = False)
     check(res)
     deleg = res.resarray[-2].delegation
     if (_got_deleg(deleg)):
        fail("Not expect to get delegation")
     fh = res.resarray[-1].object
     stateid = res.resarray[-2].stateid
     print("----- CREATED ", filename1)

     # create file-2 with access RW and delegation wanted
     filename2 = b"file-2"
     res = open_create_file(sess, filename2, open_create = OPEN4_CREATE,
             access = OPEN4_SHARE_ACCESS_BOTH, want_deleg = True)
     check(res)
     print("----- CREATED ", filename2)

     wfh = res.resarray[-1].object
     wdeleg = res.resarray[-2].delegation
     if (not _got_deleg(wdeleg)):
        fail("Could not get WRITE delegation")
     wdelegstateid = wdeleg.write.stateid

     # OPEN for WRITE with CLAIM_DELEG_CUR_FH using the file handle
     # of filename1 and the delegation stateid granted for filename2.
     # Since the file handle and the delegation stateid do not belong
     # to the same file, expect server to return NFS4ERR_BAD_STATEID.

     claim = open_claim4(CLAIM_DELEG_CUR_FH, oc_delegate_stateid=wdelegstateid)
     owner = open_owner4(0, b"My Open Owner 2")
     how = openflag4(OPEN4_NOCREATE)
     open_op = op.open(0, OPEN4_SHARE_ACCESS_WRITE, OPEN4_SHARE_DENY_NONE,
                         owner, how, claim)
     res = sess.compound([op.putfh(fh), open_op])
     check(res, NFS4ERR_BAD_STATEID)

     # close file-1
     res = close_file(sess, fh, stateid)
     check(res)

     # return the write delegation
     res = sess.compound([op.putfh(wfh), op.delegreturn(wdelegstateid)])
     check(res)

>
> Thanks
>
> Frank
>

