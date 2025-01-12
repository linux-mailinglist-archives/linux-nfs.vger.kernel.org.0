Return-Path: <linux-nfs+bounces-9147-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDACA0AB6E
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jan 2025 19:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E017A02B9
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jan 2025 18:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2C022F19;
	Sun, 12 Jan 2025 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DwVtb0xk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="njqKeAO5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9520622083
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jan 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736706651; cv=fail; b=Xn1uGIZnk+PgDhmuN8ydIsGSlk4YyAxnonaoQxhIgeiCXwPEQr0y1P8PysPKfXqbMOrldLVKt8biBMmkp/+4qjXm7baogzjOPn0WSSIVP4vL//dk06J6RkgZQEGGZjmt0oXMbAFf/fFAhrWqKBZG+O+k9BmHyGU2wIBGiD3rzrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736706651; c=relaxed/simple;
	bh=Rnk4sYGBkMXjcgsDG/lEseaCUTqPejVUHGKOUSkz+wA=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=U0lv8Y4cPCWxWYTt9REYbWTxVEDtgpXlomNpV0cRirCACqFnL3/gpoE/NugMnoVmWHTv+wevwwNcy6PFYjMBY4BLTEab6C4h2udkey/LMtBho4Arl2a+IAlLnJec9UlumrWBbWRXCyCJ8jpTqxsKXh7bNGUBL3xCv4ymnI+GxaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DwVtb0xk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=njqKeAO5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50CHe1ie012235;
	Sun, 12 Jan 2025 18:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FUwmrXiRVJ92VAayH37hnEKitmie99Qik4CcXX9ULQc=; b=
	DwVtb0xk2bI1Sc4DJj4tako7I9SQ0SoD1lCX40etllIbQ8TRJp7wUxSZc78merkU
	pB+FBt80kWFVfDKnId1NPwleuSz61UZ2qwbsDGuOhRy+H2lV9u8LSrN2ebjE0ZDr
	TmzCoIWnQOBbstcv7zdlrktTS6n4Ly86+8oTcR0qx0LYl3daYS0tBGvv4HPLR4f7
	0ke1U8B5d+GMOhzCEIUUoZrebjyqn0fRNSVdb9lD1Qa+IbYQKMILSzCAMgLeaBNr
	HSHx8LatFoHQi+d4XWg3JsdkB9nRPdwgJyjH4uXSo15NEhb40aUW62Rg1hMceukm
	uRHKibMIpPOELKkajHKm3w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fjajgy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jan 2025 18:30:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50CFOMqx040275;
	Sun, 12 Jan 2025 18:30:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f368ssr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jan 2025 18:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXc/Ot2MFW221X6JzMWLgjVXwObtY29XbJ9XJvIrwUVwAymVYZgVe2NGo0o/Frz9OjesO+yYF1jStjDCRLCG0PWLdYbOv6DcnpZq7uOdhIUuyBbhR78f3Jj4RhaPx0Ltz/j8XZ5l5eQff2pQ/AFO0xJwPCoY7VhKm6SmtIeZby2bMnX5U0w9E9rp2j/dcPD2Fsy9NcySmkShYdRC1qhmtEnrSWXyE+hwKB1yVARdMJQdEp7GtQE9/ZHaoqr1q2iY96CBmDk8Ptf/Imr0zpHQniLUUEmteOE8YlYflSti/Yzp4F8e9LwUrfwwX+F0Of+1FOF/15PPaojcRmIY4mdA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUwmrXiRVJ92VAayH37hnEKitmie99Qik4CcXX9ULQc=;
 b=qKrd9sfqQ0fVWosN5kJpSMDsgbRUuoGO25wa2fb3vULReirPBybpYhN8quG9qLUZUBPyUsrZnTLD/fg33J4jicRzcF73dBnJI+SUTPyk1sOdvwF5OBFpJUL8KWHyg6h/P1YoWf3FMQlOEmUgn+sZS/TvjH+3aRU1cnJXqWbz7JPqp3ve3A8xVVIP7P2wRZhkC7y907wuEIn3Hq0qAANEM6Y5vS4SapGpZsG6/HQDmA3irk0jmhOM6AUKrSHVTmN2y+4rxLz0abKJKhRqj2oUttdZQ4SPN4X1E2iS+Dj/+WpNBJf8CE9Y1qCTFNcCJpgovzwzd8+iGM38Lu+qRHObqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUwmrXiRVJ92VAayH37hnEKitmie99Qik4CcXX9ULQc=;
 b=njqKeAO5w+zUSGH53TTtjYuOsz1wd8iHarHArL9pwpxC0ennqcHZc+hPhlWUE28EuG3IxmHxkWawcJ+cvBCpymke3lajyuE8UD3eWQP+m31d79qIhDfvjYPO5AyIDG2faZfP4cn54K3n4YERP5QM+UFQalUYqRGnds3Qpx/K0ns=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB7450.namprd10.prod.outlook.com (2603:10b6:8:18f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Sun, 12 Jan
 2025 18:30:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.011; Sun, 12 Jan 2025
 18:30:38 +0000
Message-ID: <2f38fb42-bc02-41c5-968f-b3f6f9ffcdcf@oracle.com>
Date: Sun, 12 Jan 2025 13:30:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: Linux 6.12 nfsd does not support
 FATTR4_WORD2_CHANGE_ATTR_TYPE in NFSv4.2 mode!!
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
References: <CALWcw=EPJk3XFNfXG95v4A3Dq7=spqh5aLYru05r9Lm-eVep6w@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <CALWcw=EPJk3XFNfXG95v4A3Dq7=spqh5aLYru05r9Lm-eVep6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:610:53::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 484cf82c-67d3-49c7-ea6f-08dd33373610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OExncERsUHRhZzBEYWRoNHNIREhaTHROVms0Z3lSTXgzZUN1Z09IUTZRK2ds?=
 =?utf-8?B?eEpZZityN1NxT0tpcnljeURGZVpuZnRZYkZJTCtBVW5aOHpkZkdrb2FhL1hu?=
 =?utf-8?B?OFZGK2NwL3l6ZWJic1N0YXN4THcwNFNFakhuRk5vQmJVM094aHdzanlKdGZt?=
 =?utf-8?B?emFrMTJOVVlicWQ2ajlkVGZObE1jbHRYak5HNTFBNkdCMmtyeVVDWDJNYlBL?=
 =?utf-8?B?SmIxb09qc0NaR09WbVloS1lITHJ0MDZsamFBVGhmdVVPai9Scm5lQUhzVlFK?=
 =?utf-8?B?Mk5hd0Yza0FvTzBJMWZKOUF5WXc0WDZQb1JNb0Z0NFp4U2RYS2w3aHp2S3kz?=
 =?utf-8?B?RGhtdWpKbkVsTFBwLzEzUElVaTNmZit2czhSaHN3YUV3TWVpWkN0MDJmNkFW?=
 =?utf-8?B?S3c3QnBENWhvU0FSZXdqWElsNkJpY0l0Z3BoWUVGRXZKQ0ZmQlppN016UmRP?=
 =?utf-8?B?SWpReVN3UWk1ek4wd1FDa0t3RjlERFdudVVSMlJmSVRHZ1RQSDc5ejRDOFpJ?=
 =?utf-8?B?Y1p5STBQWjFUMEM0OVYyTnRTMmVweU8rbmF3V3FhdXNrVlNObktBTGNoZ0lp?=
 =?utf-8?B?R2E2NHhoMVdCVVdhTXF4SGlPRTZTWE81WHcrcEZvTHg1VHBUK2s0Q1pDYWxo?=
 =?utf-8?B?eHk4cUhEZzFQM2JpL0FVQk5ZY2VHWmVaSEFFb3dQWDc3MXlmc0dzTDhuSW9G?=
 =?utf-8?B?UmprVWo4M1RUZWw3U2FIR2EwcDBHbTdHSkRuSmJBWFFwZFJ5Vi9pV2QwNG5J?=
 =?utf-8?B?b0VjcysycVJZTFJoMU1PMTJnSGljeUs5dnFCbUk5R1Vua1Y2a05zKzNhN0tx?=
 =?utf-8?B?Y0l6cUg0N0cvOEJ0a21BbVJlanlac0FTWnRtSFh3MXJ2cG5wQ1Q3YUFCQ1Nk?=
 =?utf-8?B?YUpCTXIyY0M3Z1pLNVA5d2NSL1E3SVV0TnlEb1QydC90VFp0dU1TSkJzSDFK?=
 =?utf-8?B?dHZQQjFvQlhwK3NtRmdBTXZGb1Qwc3pJaHI1MGV5UjNiaG5KeDVxVjRwNXZh?=
 =?utf-8?B?cGN6NC9Cdms3a2NzaHEvTlpsY09XcWxJK0lrSU5HMjg0eThwdk0zOCs5UGR5?=
 =?utf-8?B?a3FqSUVocXVNdGpONWdyZHRhNmlnNDJpZVhqbWdLd0NYczZRSHJiM3Nka2pQ?=
 =?utf-8?B?SjlROHV5Rmd1eTBLQW1hZVhLTVVTWmY0UHVHUjdEdGRxRDFOK1dQTkJSSllp?=
 =?utf-8?B?TVZJUkFmMVNKY1ZLa2dyMWZsek9HMWdScTZWRTFvVk44NVdBL2JtWHJ5VUpj?=
 =?utf-8?B?SndNcnJGSkFzQzVkRHNVYmczSGtiaWF6eFdiY1FXVytKa1U4SmJ0TmQ5c1BZ?=
 =?utf-8?B?azRDSDhoUkJJU0g1ZjduSkU0bGVuNS9LQjFXZ3hpNzZScE9CeVRUbEQxZlR1?=
 =?utf-8?B?cndEUEF0TG1pWE5iaDR2V2ZlSlFtd2g2Yi9hbEs2OUZKRXFFeUpBVGxHRnhQ?=
 =?utf-8?B?bWNFYzQ2VVZFMlArRFk0NmxDWjBrMUdHalJJdG9zaXJQRTRBc0lGUjNDeURG?=
 =?utf-8?B?TVpPRGdqaUdhWGt1dXVXUGhkVUJCMFRoZlVGOEllQlkraXEvZWYvbmFiMHRU?=
 =?utf-8?B?ZlEyTU90RnBwMHFkdTF1MUltRnhzVW8vNFl0SUtuaHAxREIxektXV1RaazFn?=
 =?utf-8?B?am0reTdaeVFRdnZ2OWV1TTllQTU0TmVmZ3VQTThzdklvRWxBWjJyZjJlUTNB?=
 =?utf-8?B?a1JteXNTSFhMakVNMlNBV24xMzZpK1FWNHA3WHNwZkl4WHZlWGYyTDdUY3F3?=
 =?utf-8?B?VUtwTDV0bkx0Zm14cXRaT3NKdmtOMUo4aEs5T1Vxa21XNzEzd0R4TXRnNTRs?=
 =?utf-8?B?cUJNTEJsdTVHbkRwK1ZYWWtOd0VCNGpaSTZiK0NYVGQ5MjNJSFQrMUFMb1JS?=
 =?utf-8?Q?ZNgDD7aoBwzn4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjNTZm96VUhaaHJvNFN4Rkx2bWYrNUJ6V2paeTVXdXJmRUd0Wnl1UDA5eFR1?=
 =?utf-8?B?MExpdldVVjN6elk5c2FrUzhIR2hONmROSi8vYm8vRC9sczlYQnZJUDJzNVpX?=
 =?utf-8?B?bW5vQXJ5SFFxcTZ5MVdRbDczdnNJelVHRGRraFh1Y3VHMlJPZG9uSXhJNVJL?=
 =?utf-8?B?QXh2VUNtVU9RZnI3VGVDQkdEL1pOQktFa2hMT3FpdEFaUmhHOVVkTmhrTnJU?=
 =?utf-8?B?UThZcmRPNHluWUpPT3EzU0ZpRGpNckhDT2JWYmRZNVF0QmxIUlZFbk1tbGdD?=
 =?utf-8?B?NU4zRFY1SzZXQWVjcXJVNWVHTWx4S0xCVVhzZHp0Q0hOMDVDRnFWUDRIVTlY?=
 =?utf-8?B?ak5QMkJiNENiaW1kaFhoQmE0MEh2THpMMjkydHpxU081Vk1KRDFpUE5JRDVj?=
 =?utf-8?B?cnhKVnpZZ3Qzd1BEVHpxNUwvVDQ0ZjREaEhGMzYreUwvaWpjTWtUY1dXY3Zr?=
 =?utf-8?B?UTFyNjdkOW96M0swbzRZOXNxeDRCaEVLVHhOMjFGOEJhTE1NUWFRRjBlSmhD?=
 =?utf-8?B?YlBEdTh3SE5ObnAySUtwb1NRV3ZFYnV1WlpIM3cydGJWMDhrMk1seStXUFQ4?=
 =?utf-8?B?cC9neVRIbEhhdUwxdmkzQkZMNy9XVW44ODhYTFkxeGJXenJHYUJEd2VQTjlR?=
 =?utf-8?B?RU5oU0lyR2ZGVGIxOUJ0UFVHZEVnL3R2cG5WdEpBRWhLM2VBdHA4YTg2bXFi?=
 =?utf-8?B?V280VTdrb0dZT05iUWRZNVJMcmtzU2kyVUtFRTZKaWJ6N0J4Qkk2ZmVoUG1N?=
 =?utf-8?B?WE5NSDE2dFRVYVIydTk1dzc2TmFKY1lDMWVvL1JoUTdiR0Z3YU01ZXlZNzhZ?=
 =?utf-8?B?aWxWTFk3SkNlVW5uTjU3a0R4SllYa05HVk1ERE1VNmltT3QxbSt3QTduZVdr?=
 =?utf-8?B?aWdXYzVtZ08rL2tUd09jWkdGblR4YkNIYWJTQjh1R1JZVEg1bEtQT3FDV0d5?=
 =?utf-8?B?dVFaZEJqRGprRWlZWTlzNWtnRytsSEZNYXJqOWl4VGxJWTJYUmlkSDNSQzJM?=
 =?utf-8?B?a1RseFN2T0Y2WEZEQllMeXJnYkxTTW9rdXJlR1RFWkVqdjZOT3lwVlQyY2I1?=
 =?utf-8?B?TmhpeEdHbHZ5YXMyZXBzNmh5bTRkcS9lSllpSXl5c3podVZ3d241bDFvcCtR?=
 =?utf-8?B?RC9sUUE3WERpbVJEcE9MYXJwd1pWN3F3TkwyTkVJbTFQNVljSjQ5cUFKWHh4?=
 =?utf-8?B?bWw3d2tNdVh5d0lhOU41cUFhODFBWXJFT0Z2d1FrelA5VzUwOWhic2J1aWZz?=
 =?utf-8?B?OUtuakdpWnVSUmlheGRMMDV4VWFBODd4eXdKcWxKY2ZDeWVQMk43dmNMZEVN?=
 =?utf-8?B?K1k1dFRONmwxMlFZZE1pd25XY0lteTczSkNWQTBXckJUc0NoRk1YTWlnUjJO?=
 =?utf-8?B?aDQxR2N1STdnUytGOTYvMkhDMzRtVnl4azZHTnRGSjJva3JReXY3OCtqeWJU?=
 =?utf-8?B?S1lscTZpbzdOQ1JPMm11djMra1pWa3NIWE50T3RFT2RueEdhdG5aTGUxYml6?=
 =?utf-8?B?dEkrNksrV0NsakNvRWEwUU1vY0ZkWUVJV0pVOVBMQWJGaU5yd0tGSndnbzBP?=
 =?utf-8?B?Qmo0UHNkNjhsMk9OajBpREFZNkhNdzRWSWIyek0rSi9Ua2NhaXlCcys0RWRr?=
 =?utf-8?B?SUh4SENMMW82SkRVcThUc1FOTC84OXJtSzM3Z0w3WlIrcmc4MDJ1bXhCeU1K?=
 =?utf-8?B?ekJ4YlB3R2NrRjY0T01wQ3JIdHM3TnBldHI3b0k4bWhrM2gwcWlUVWFUY0c3?=
 =?utf-8?B?eVB0TG1XNTJGby95blR3WUtuRmdmSTB3empSRjB1cDkzeUcxVkxOOXRFak9I?=
 =?utf-8?B?Q2lxb1FoVHVlbVBSQmVwV0ZLZTBycHJyQ3FhRnVNWnlheUcxR3BHeU1mbWhN?=
 =?utf-8?B?YytBS1pzN0JrNm1aVnZZdFhYbHg0K05kM0Fxbk5HLzNqNTk4UUF5SzN4TWlp?=
 =?utf-8?B?S0I1T1VLWTg1bzRNdnJuUStJT0dJNmxDVy9ua3B5cWI5bjljcmFDbks2NGNm?=
 =?utf-8?B?c1BSQXJNREZrTklSU21vODQydDJOMzU2YVRhd2VSN3pMMTZZaEZndVJNeFkz?=
 =?utf-8?B?WFE3eFRDcFlUdm1VV3Q4Q2dqdUFmOERDYjVoV1RMVTlBRU5jblVRQTRQUEtv?=
 =?utf-8?Q?Gub3fVq1zbLw6ziV6kmlDGHvW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IAh3alXn9kCaonkR5L2iDnKQ/y6d4+1w88Lj132TtsP6LiI3wAyFYJLhIXePRES1OvWoLJkZEU7V+8L52z+r3G82z4gLcLAVfVNgg3Z8hMaEIFnNSNxzU+FdXZKAfaxGdEliij7ZwQ78XTrCy2FjkfDZcoONZGxhf2hS/xTvpVb9tajYd9wpvx04eduEKeiSM40xHfmGtIHRsacPKUiOsQ1sMQiPtjBgXCT4PVedGlTWM3ptT4MD1MGL7xJVT0qER3PzfmA+N55E+R4qD5PsqALRtf4JsrwFwul37aj36X7e+z+v1oMHBOEbG3up1znje8iVPYcUNvIwXUX3JRUeuUDgD7Wt33Pr1MYlpm9gGeEIdlVWrUE4fBhGgCTmsb8W92x8xkzlUyfE3OxyUG3JSUGEV5Dq/S6uDeNn8Holf39foLgtLMTORKeFRo/T8t60hl1fGIQLbHQqzcnsiQUODFvYeyiseo5l7sNEWrb3iTmHGcMnMCum2fRIkh9PgyeIdecXdXF6XJmhWVquA5A9i04wd8he181jRNFEUWfnm/YFi60YDTTOeyejC797AH8lfwpyLq57fjh4r9JkEHSerHtGWOMT2A9TtEv46fIF0/Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484cf82c-67d3-49c7-ea6f-08dd33373610
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2025 18:30:38.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qu3Endq4lKHRhihAHYEpyz+40U2BVSHZMJ98Q+5BRLoobL35bTIv67vvPrEfEH1GdQwKxHUacSmr5aSkQR9odw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-12_08,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501120163
X-Proofpoint-GUID: FA80yb2N_7xJUFPTLIxkfuC385fSUcxb
X-Proofpoint-ORIG-GUID: FA80yb2N_7xJUFPTLIxkfuC385fSUcxb

On 1/11/25 3:08 PM, Takeshi Nishimura wrote:
> Dear list,
> 
> We tried to use FATTR4_WORD2_CHANGE_ATTR_TYPE with Linux 6.12 nfsd,

Help us understand what "We tried to use" means. Which NFS client
implementation, and how does it intend to use this information?
Please provide more detail than the general discussion in RFC 7862
Section 10, please.

For instance, RFC 7862 Section 12.2.3, final paragraph says:

    Finally, if the server does not support change_attr_type or if
    NFS4_CHANGE_TYPE_IS_UNDEFINED is set, then the server SHOULD make an
    effort to implement the change attribute in terms of the
    time_metadata attribute.

NFSD could implement change_attr_type4 and simply return 
TYPE_IS_UNDEFINED.... that would be 100% spec-compliant. But how is
that helpful? I'd like to hear more detail about what benefit your
client expects and why it can't work without the change_attr_type
information.


> but the server does not set that attribute, while it is mandatory for
> NFSv4.2.

To be clear, RFC 7862 Section 10 says that this attribute is not
mandatory:

             change_attr_type is defined as a new recommended attribute
    (see Section 12.2.3) and is a per-file system attribute.

The term "recommended" here has the particular meaning "not required".

In addition, Section 1.2 states:

    NFSv4.2 is a superset of NFSv4.1, with all of the new features being
    optional.

This means NFSv4.2 clients have to be prepared for NFSv4.2 servers to
not implement that attribute. If your client is choking simply because
the server reports change_attr_type4 is not implemented, that's a client
bug.


> Could this please be fixed?

This is technically not an NFSD bug. AFAICT NFSD complies with spec in
this regard.

But it is fair game as a Request for Enhancement. If you can give some
more detail about how you think this attribute should work, that would
help!

(Jeff, this seems like follow-on to the multi-grain work. Can you have a
look?)


-- 
Chuck Lever

