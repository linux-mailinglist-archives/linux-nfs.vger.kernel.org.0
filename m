Return-Path: <linux-nfs+bounces-9384-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99123A15FE8
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Jan 2025 03:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D266F3A6398
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Jan 2025 02:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB96F513;
	Sun, 19 Jan 2025 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WpgWuY1a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t0RNqMbw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A61EEB5
	for <linux-nfs@vger.kernel.org>; Sun, 19 Jan 2025 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737252128; cv=fail; b=E/orJ1rVh1s+yHSmGHrWDXRoG7EUlDNojrYSLPfzisPVDYJ0UNxaTlmNgydin7GOrX0+xlc9t4NoUe+vlvsJT0THgLBflTcqH0GfTkHWGY+kgsdVo/5dXS75AHK0XHRhUy8n1j06Iwblfoad32rCmssz1/ioGQ8BYYVfww9FucI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737252128; c=relaxed/simple;
	bh=8TFuJwx5N2k9b0taKviatqHUM7jhgrybewV9QUqeBpM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uWzw7ojWTOa6wIrab6Bod2p2H63Od0CkLUIZbNjG7TcPJHBSS+pD4fBvxxI9eHcS31pWcG9omCrs9ilnXUfQ2hr3LQW9o1mdf5IwrgcLbi0zT/6Ye173Ei91AuIWI8JKPEb9NE3sqGSa0qowwtfOF+J7PuFzoKF5S9M1vwl9SLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WpgWuY1a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t0RNqMbw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50J1x2r7019535;
	Sun, 19 Jan 2025 02:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=q7uIJGPYQe7HI78wAVIA886m52Tx/bDaLW4Iq0BfUq4=; b=
	WpgWuY1aSjV/VTm2hgTa+6ta3Cyk8/mZCIPapwUgxOTmC10h1vAWNcB5RfjQv75o
	pCunzMj1py3GyUrhHkK2+ITBvBz3qdYuyIMbUMl9vDP7NWcKLCer8MDKExKX+d1+
	OuPMNyLC8Ak9b/3AjNQgkCDH5cnvbKGJTvRTJVuNlHwaAeB0hFV1+vtay8sxT1yb
	vLKNIzvrgFyckO3roGIbU8ToA1LIcGM6Ywt8aTdRCZ98Rq3aveZM5K1tPIwWuSl9
	+8qxXVMxyD+aOVfbb2kbKook7OcFmEdIIgSbO/zjnCTR0x+XrCJvIhGBzQbi4oJC
	bEUB1pNmRII+HUOMtkStjA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qahs40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jan 2025 02:01:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50J0v9Kf007522;
	Sun, 19 Jan 2025 02:01:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4482r6cvt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jan 2025 02:01:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qes4G5foqXqwc+1DMBJLG31arH42xwdXeo5OqyGSh+sdUr51E7NN9w3a2Hgwyb5KkOlH3zOd/KdthcovJd9yNYTMN0caN1Yae10sjZYAyEGs2Q2Xz5KdW7hUIAfOSxkPzTDN4EpQibEyKibg3BbuQFAAg73ULv4u6ScT5fwmQy7f2nOOGqDqdZBidEYx5z+Pq91LWEIMt0eh1yUwnNdDfEhOSr1u3t/jYJre7/BfcO1n8MKK1LmQPVM8IabFRZazaW1xMZttvgNpCXv2spGTSEpo3eP65QaNKWEDE4WTwHdmTIDyhy8kuIZR8DcsQcHBBUNBkDEYhH1UpQeFuTAIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7uIJGPYQe7HI78wAVIA886m52Tx/bDaLW4Iq0BfUq4=;
 b=EdDrtC+uom8Rc5h/nPr63a1LZiOCpvfQZmZJOVVnOBj+pjMnPo8vdKD4b6iit80Lx6p9+ZGARdln6/yX4oK3V+1Ajh+eX/uPqJRn5PFILKkPJq/Q7KQfYzxdq3mokS49/zPbEIM+zp/mVYU8gMRDIxVqhMcD537w/zsDzFVeey0UjZ6NJPMTa0KQx3MQ/7P7I7cpOCrGRAn+YGJ0pCPeN8bIKE1E+cITdiuGmYYvFAUwApzJEWil95RSFhiikOmgCkg8NVdF9PsojlWrGMcDaqAzBK26gb6gqJ1v9HL/1aRdRhJW+lkcLe/Ea1ccSvRjjejH1wgaQp1xlCf2h5AMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7uIJGPYQe7HI78wAVIA886m52Tx/bDaLW4Iq0BfUq4=;
 b=t0RNqMbwzBcG0mF3V+Ax1kNeLh56CCMmP3x7CKreO1LFt2lYNCjZlyFIOJ++4rDphoNx37tv+3vUWbkMd9qY65/wVJAZKQ9IbMtmzzk/mqH1z5L0Hzqn2BeJpIm2vNE6Pv0Py/xWsovUkrZrDKuCFxkafTrU2i+M5490l1SYvS0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW6PR10MB7659.namprd10.prod.outlook.com (2603:10b6:303:246::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Sun, 19 Jan
 2025 02:01:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.014; Sun, 19 Jan 2025
 02:01:38 +0000
Message-ID: <a961b220-75be-4ada-b548-a87f24566f92@oracle.com>
Date: Sat, 18 Jan 2025 21:01:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] nfsd: add support for freeing unused session-DRC
 slots
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jeff Layton <jlayton@kernel.org>
References: <20241211214842.2022679-1-neilb@suse.de>
 <20241211214842.2022679-6-neilb@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241211214842.2022679-6-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:610:4c::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW6PR10MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 143bdd5e-27d8-49b4-8501-08dd382d358c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TE5NUVlxNmZiT2FoY09xa0w2ZjUwQkQ0TlRWRkZjU1kwZTEyUjFHQm1kRlkr?=
 =?utf-8?B?S0wrYWx5TkZOaUpDTm5pYUc3elBlMi9obFQ1OFFXTXdPaTNLaDE4OHFoNWVL?=
 =?utf-8?B?N2ZRazI0SFhDUXMxengrcVBORDZjbFBtd1RNSjcxVXN4TitqaG5NWitvZE01?=
 =?utf-8?B?SFFESXRTT3JVcUJ6U1FxdXNpbUdFZGFQL3p4YlFjaDhPOWdZZ0JKbnFNd2pQ?=
 =?utf-8?B?S0xhRDNnR3VBNkdiV2E4eFlmK3lDU3RmdEU3V3d6cmY3NVJTRmR6dW1tRUdU?=
 =?utf-8?B?bGhpUWNwRjNEcXppQmNpWmtxUUhqeDN4aEZiVU02WTB5M1BuNFFrTERWOHBl?=
 =?utf-8?B?UzJHR292Uzcya256Tm5PWW9XWXRES1IvRFplNS93eElTQzlKMjJheHprNWwv?=
 =?utf-8?B?djVwaElIZm1Ecmk3Vm5qeGQ0cGNJb2VoYStsZmFPc2xQRFJXYUhVaWxaTVVm?=
 =?utf-8?B?eE1EWC9xd3EzQUhXT2ljNFpaVGNoUHdicHdkMnlUanZRelJIT3RyWjlWdGdX?=
 =?utf-8?B?SEk5ckRTeHUvYnZlYmNKTDBEakMyRkRUVGpDUE1kS0xtTnNiZk5kNE5CeW4v?=
 =?utf-8?B?TkxGQ0d2aEJYczlLaEJhUlVYYWNCd21lYWZBWWZOVk03c2pWRnBDRG9lUEV4?=
 =?utf-8?B?RVhFOGRPMU5sTGhhTTJJUGJPKzd3S2d4SExBMHNQZGpaYVQzL0pIWUZmN2hD?=
 =?utf-8?B?djljMlg3bFlDV2k0anRtVjdJZFFDbDZmWnN4cXlzNlc4K1VUWU5NbEQyUDRI?=
 =?utf-8?B?dnEvd3A3Q05adlE1cHJKS2JpRVpLWFFkVWNlaFhTOUpXTXdDcXA2VVd4UVFK?=
 =?utf-8?B?bkJYdW4xTy84UmowM3JMMDR2aU1PcDY3cWh4Sk03S1NnS3kxRXlMajJpeVg1?=
 =?utf-8?B?QWRHbU9sbzRjNnRXT2l2YXFuc2RYZ3V2aUtjOWxpcGd3ZUtVdVg1RlJmbmg4?=
 =?utf-8?B?ZFZING9yS2NiOUZQV3pOUDlHZWlFMzdFYkwwZU5ZRm5UMEZHTEpmdm9nN1VD?=
 =?utf-8?B?VTY0eUlPZUtpekhtUlRMamRuZTZBeEdtYlh6TC9TaHhaamJSUW5nS2luTmNz?=
 =?utf-8?B?Q2NiTWFvMDdmNUh2ZnRpcjRpaVF3YW5nV3daQ0FjV0pIK1ZwL2FsWmJCRFFO?=
 =?utf-8?B?VWEvZlh4aWZwVVo3ZkQ4MkkxQldhelpNSk14eDhJN2ZzMVBaa21uaG5lTXlG?=
 =?utf-8?B?Qm5BN09vdkpXZ09RNzdHaVlYQ2pFYW40dkZpWDUyL2l2UTMrbndkMVZ6Y3Vn?=
 =?utf-8?B?Q2pJTCthRnNOa2tPWTZpMS9ycEVMQXNvN2Z5Yjh0RWZ4d1YrREtRRmhEUktM?=
 =?utf-8?B?QUozT2ZyVmtGTGNhVm1Gd3lCMVM1Q2ovQ3dIdDRPdlo5Z0s0ZjdDUHpORjdU?=
 =?utf-8?B?UWpsL2YrTnBZMHlDNUpIMHhSeHRKTHExWUFtazVYdnBuajJNd0RwRFcxaWd1?=
 =?utf-8?B?QkVmZi9SL1lhVVFvSGR3cHZucWlIaDRDSjVQMFF4NC9sNUN5QVFXbytqSi9E?=
 =?utf-8?B?SkIyWXBHNFVoSHdDR0Z2RlJaWXhFbGFZbkFjdkdwYnZ5T1o1SXpRT0l3MGl2?=
 =?utf-8?B?UHRQeXovampvS3VwclVhUEdGZWpML3EzSW10dEdtQXk5cHR4M3lmVlkybG5B?=
 =?utf-8?B?NG9qNTFiWEVVazN2d1EwcEQ4UExBSll6TDZHSWpqa2RXdVAzenVabzgxUUlT?=
 =?utf-8?B?TTZrRENOalhzNzJKVmIxV2FXc0lMRkU4OEw4QkQ5WUV6TG8reXpYM1VJNEFW?=
 =?utf-8?B?emZXYWYyZm5ERFFXcVVkQ2MydHlzaVNsNTZmeUdnMktmcWt0L3ZSejNqaHc3?=
 =?utf-8?B?Z3lvQklZM05ZcU5hWnN6YjBVSk5vQ0k2QVhNbFRwbys0dzZYRlNjVzlIQXdC?=
 =?utf-8?Q?8QZ1U2ISp8/Tz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVRFSW5aNGprQ3dxTTBpemI4V3JhZDdxMWFWMmMwTEVPc3VGMnZqYzM4ZWJS?=
 =?utf-8?B?TmZqOE8vYjNRWS9BWXdnZ252b3RCd1JsS05EZG9pZHBkQkdzeW1sY2xZWFJI?=
 =?utf-8?B?eVcrNEZkN1pqVjlYR0tFSTFoTmFDZ0NudzRzOFk1b3haUFpGYTkvV0lmaHRI?=
 =?utf-8?B?K25oN2FZYjI2RWlnSlZtbzVQdzFEa3dFK3htOEZkWGlLdW4xRk9MRm1MQ1pZ?=
 =?utf-8?B?YVlvUWxSUnhMWks5aUhndkF3bU9WUVAwdWhDTjNCSkQ0Y01GaHNnbnVVZU5R?=
 =?utf-8?B?Nkc4ODBrbGFIRGM5ZFNCUkx6QmY1RVEwcmFTZU1pM1k1UnpHaGlWdDBZaksy?=
 =?utf-8?B?Ky96c0FEMnE4UDZLY2szeVZ4ODViYTFjSFBXRFZHU1hNd05wUVdTZ1BGbEZ2?=
 =?utf-8?B?bjNYRlZUbUFSYTVTeEdaSy9lSjFUUzRwZlpKditONkhFRVpkSzdMRG5GWWZZ?=
 =?utf-8?B?amhUUHllQVZVYi93aTVncE52NXZTMWY0Z2pYcnRyb2dzalI3bmJJUlVWTlFQ?=
 =?utf-8?B?b1puVkxzNmErS1h2RU9ieTZsR3BqclRXZ1VFY1o4VGVHZjhNekdBa2lqUkpO?=
 =?utf-8?B?bGxQdmg1NFQwK3lockQ2OVpsQytHT3dZejhwbHdkcElOWmUraUZlWHNEenZ6?=
 =?utf-8?B?RCtDeCtIZ3NhOVlqMkdseGp4OTlTeUUwNjFiM3MwM0pHVzViRkpibE9PWk42?=
 =?utf-8?B?dnhkaytlU28vK2RpbFNOdUpLbHR2RklpK1E0RzdpdHN6SW5oYXdMV09uTEdM?=
 =?utf-8?B?YlpqQnNoSDN3VkJLVzdVdzNodUdwb29vR1drUWJEVklma0F0YzZOT0R0NTRl?=
 =?utf-8?B?Ukw0czJac0M3WFJ3bTk1QWJPbEFGNWpCNDhjSzVsbGsvVm03UTM2ZUNPYnNw?=
 =?utf-8?B?ekVZYjMyNy9GLzRYZzYwdFFmZEtHV3cvQkxmQVhEMy9udlhsQ1RXN0lkVnFF?=
 =?utf-8?B?QjNBQy9mc3dHMDM2OVhScWVoVXdmbnBSbjN1Tks0RTUybDlQWFdvMk15QVZX?=
 =?utf-8?B?ODZ1TDRCK2N5V0JBclhQVGtRTzcrQUg4LzdScUp0bjhZczMyaUc5aE9GSXUv?=
 =?utf-8?B?WFlZZDNkaDFTbGVGamgybnhCU2IvTE4vVGpxUC9KUUpFSGNKZTNQRUc2Y0pY?=
 =?utf-8?B?b3hXSjZYRy9Fd1I2ODVnZVRTMmRWQUgxRWlRK2ZzWGRGVUtySXNKQU5oQ3dB?=
 =?utf-8?B?a3QzcW9WdFBHUC9nSHFsYi9yeWo0TGZhOFZsL0tNWlJPb3I3Q3Q5VWVSdk9R?=
 =?utf-8?B?R2pubmpQYWhERS9RSGJQcS94T1NxazIyMndlcytTNlkxNU50QWNWcGI4cWpU?=
 =?utf-8?B?SjA4VXAvVlFHZWRubG1pazRzdG9naXkzZDFCK1IyUTc2U0E4SXQ5UWoyS2ZE?=
 =?utf-8?B?blc3bGRVdndvT1RjSVExOVY3bTdGc2ZoeGdZS0lyTmQ1R3FhZGhNdnlWc0d4?=
 =?utf-8?B?K0ZmbGc3OUxZL0l0UXc1WkxsRGp3QXVaK3VaaUhMVzFDL1ArYVgyZHlRRWtj?=
 =?utf-8?B?MzAwb1JMdzQ2SHo1YjBEQk5nRzhWWitJa1h3ekdsUFJta2FmaDMxeVEvT014?=
 =?utf-8?B?TVBaWTBzSFRPTkc2bXVoaC9BU3BzZkJCbHg2OVQvd1FsTmQwTkNDb2p1Y1JG?=
 =?utf-8?B?dmd3ODlKeEJ3V202bW0wdllrSDRmd0ZZMTk2eUkzWVc3S0M2aFBuaVpiRStL?=
 =?utf-8?B?QVRVU1hrYk9GUHpSWUtYQzhjenBhYUpIMDMxTXJzOTVXUm9vUDFOckl2RGg2?=
 =?utf-8?B?eTMrOHpwVFAzcmR6SWwzNHhjUkJ6aXN3WjdSVklGemR1U0RnZFFZYTdWUmk0?=
 =?utf-8?B?T044bXRlUjJxNEdUcFdHRW5leTdGdUFPaUwvNEwrV2JUc2crd1ZINVJmMHZs?=
 =?utf-8?B?Wk5KSEJna2c4emhoR1h3bk9HWVBxam4xL2pGRmgyaGJzY0ZPdlpEMTMycjh2?=
 =?utf-8?B?cFZNRnVvamM0WXNiVndLOGhCTWV6aU1aUHV4NWFPZ1o2SEtIVEdRQllmZHd5?=
 =?utf-8?B?ZDl3alZKSStCZ0o1TElNaSsyZHFPakdZTDNlMFc4ZGtwZWFGVFdWTWtNbExn?=
 =?utf-8?B?M0QvbWpPKzZsTVZueGJ5Qy9Cc3ZJTDBvWlh2VUxhajFrbjl0NWJBNVlkUXRi?=
 =?utf-8?Q?xEe9n+UzZ2mbkeDagIQQIl/yJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tPESBeDrVyvqMVN8Mn583zTBaV0B+vQ3bMYIGCYzbEnlBAN4sztgF30bFwP1fpX4HA9u13MhYHm5PQNpSYSxMqnk0GYivQgUHH0kOy3I6p3T2po0DNt8fqE955DfJFkldLwhyKmscV/1N18QAhbmqn/U6yuczIBBUVmqSFBSmVHkvOiKonGF5A4aHl0Q9RGS6TOGeqqEiJ8j4dg9ZhwCGBLVxnakntx3cHfmPmDYHopElNA6njn4K/KR6reruQptXZ/JN2Dc1/49VTNFVL/t25ioMv2wJfVK9aXVX63hO/cwAj/fPWp2cVH4VA+q/8ZPfsJKpf5UZrkmCOuOD8mJC/tMGQlxVw469RIM1RM5ySF4f5h4iXXQ0I2Au/ct3bJJObwHedp/R5omT0PKcaFgw4NemRLDolkbj7gBLuLVghL0RWdCp7yK/87D0+M8fmg8mfCxRmCJwLlGdnb52x9M5J3DTy6D2gmCLPjpU9MBZ6msee2efrs7lvRxsMJJc395B2LTmmIUDQbGyjSp/u6TrBaiGU0qg0OSjy7DgHqF+YwgNSIDAevPm6ziWGdco6wRKv/BTA1QYtZ9ckmzKZJsR5NZdjmDhA4nU6mLlJEPU1Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143bdd5e-27d8-49b4-8501-08dd382d358c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2025 02:01:38.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgbGiI/nECYflbh99pITE1+6XjBnhgqMyAd2AgEr2yDEsaFXYE8gWwqWQ1vDbmtfopMXzbKtNAJBJZCLaFhjIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-18_10,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501190015
X-Proofpoint-GUID: JWFPwMq1AzW_a1_5l1M_oMab6U9d8fBm
X-Proofpoint-ORIG-GUID: JWFPwMq1AzW_a1_5l1M_oMab6U9d8fBm

On 12/11/24 4:47 PM, NeilBrown wrote:
> Reducing the number of slots in the session slot table requires
> confirmation from the client.  This patch adds reduce_session_slots()
> which starts the process of getting confirmation, but never calls it.
> That will come in a later patch.
> 
> Before we can free a slot we need to confirm that the client won't try
> to use it again.  This involves returning a lower cr_maxrequests in a
> SEQUENCE reply and then seeing a ca_maxrequests on the same slot which
> is not larger than we limit we are trying to impose.  So for each slot
> we need to remember that we have sent a reduced cr_maxrequests.
> 
> To achieve this we introduce a concept of request "generations".  Each
> time we decide to reduce cr_maxrequests we increment the generation
> number, and record this when we return the lower cr_maxrequests to the
> client.  When a slot with the current generation reports a low
> ca_maxrequests, we commit to that level and free extra slots.
> 
> We use an 16 bit generation number (64 seems wasteful) and if it cycles
> we iterate all slots and reset the generation number to avoid false matches.
> 
> When we free a slot we store the seqid in the slot pointer so that it can
> be restored when we reactivate the slot.  The RFC can be read as
> suggesting that the slot number could restart from one after a slot is
> retired and reactivated, but also suggests that retiring slots is not
> required.  So when we reactive a slot we accept with the next seqid in
> sequence, or 1.
> 
> When decoding sa_highest_slotid into maxslots we need to add 1 - this
> matches how it is encoded for the reply.
> 
> se_dead is moved in struct nfsd4_session to remove a hole.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   fs/nfsd/nfs4state.c | 94 ++++++++++++++++++++++++++++++++++++++++-----
>   fs/nfsd/nfs4xdr.c   |  5 ++-
>   fs/nfsd/state.h     |  6 ++-
>   fs/nfsd/xdr4.h      |  2 -
>   4 files changed, 92 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index fd9473d487f3..a2d1f97b8a0e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1910,17 +1910,69 @@ gen_sessionid(struct nfsd4_session *ses)
>   #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
>   
>   static void
> -free_session_slots(struct nfsd4_session *ses)
> +free_session_slots(struct nfsd4_session *ses, int from)
>   {
>   	int i;
>   
> -	for (i = 0; i < ses->se_fchannel.maxreqs; i++) {
> +	if (from >= ses->se_fchannel.maxreqs)
> +		return;
> +
> +	for (i = from; i < ses->se_fchannel.maxreqs; i++) {
>   		struct nfsd4_slot *slot = xa_load(&ses->se_slots, i);
>   
> -		xa_erase(&ses->se_slots, i);
> +		/*
> +		 * Save the seqid in case we reactivate this slot.
> +		 * This will never require a memory allocation so GFP
> +		 * flag is irrelevant
> +		 */
> +		xa_store(&ses->se_slots, i, xa_mk_value(slot->sl_seqid), 0);
>   		free_svc_cred(&slot->sl_cred);
>   		kfree(slot);
>   	}
> +	ses->se_fchannel.maxreqs = from;
> +	if (ses->se_target_maxslots > from)
> +		ses->se_target_maxslots = from;
> +}
> +
> +/**
> + * reduce_session_slots - reduce the target max-slots of a session if possible
> + * @ses:  The session to affect
> + * @dec:  how much to decrease the target by
> + *
> + * This interface can be used by a shrinker to reduce the target max-slots
> + * for a session so that some slots can eventually be freed.
> + * It uses spin_trylock() as it may be called in a context where another
> + * spinlock is held that has a dependency on client_lock.  As shrinkers are
> + * best-effort, skiping a session is client_lock is already held has no
> + * great coast
> + *
> + * Return value:
> + *   The number of slots that the target was reduced by.
> + */
> +static int __maybe_unused
> +reduce_session_slots(struct nfsd4_session *ses, int dec)
> +{
> +	struct nfsd_net *nn = net_generic(ses->se_client->net,
> +					  nfsd_net_id);
> +	int ret = 0;
> +
> +	if (ses->se_target_maxslots <= 1)
> +		return ret;
> +	if (!spin_trylock(&nn->client_lock))
> +		return ret;
> +	ret = min(dec, ses->se_target_maxslots-1);
> +	ses->se_target_maxslots -= ret;
> +	ses->se_slot_gen += 1;
> +	if (ses->se_slot_gen == 0) {
> +		int i;
> +		ses->se_slot_gen = 1;
> +		for (i = 0; i < ses->se_fchannel.maxreqs; i++) {
> +			struct nfsd4_slot *slot = xa_load(&ses->se_slots, i);
> +			slot->sl_generation = 0;
> +		}
> +	}
> +	spin_unlock(&nn->client_lock);
> +	return ret;
>   }
>   
>   /*
> @@ -1968,6 +2020,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
>   	}
>   	fattrs->maxreqs = i;
>   	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
> +	new->se_target_maxslots = i;
>   	new->se_cb_slot_avail = ~0U;
>   	new->se_cb_highest_slot = min(battrs->maxreqs - 1,
>   				      NFSD_BC_SLOT_TABLE_SIZE - 1);
> @@ -2081,7 +2134,7 @@ static void nfsd4_del_conns(struct nfsd4_session *s)
>   
>   static void __free_session(struct nfsd4_session *ses)
>   {
> -	free_session_slots(ses);
> +	free_session_slots(ses, 0);
>   	xa_destroy(&ses->se_slots);
>   	kfree(ses);
>   }
> @@ -2684,6 +2737,9 @@ static int client_info_show(struct seq_file *m, void *v)
>   	seq_printf(m, "session slots:");
>   	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
>   		seq_printf(m, " %u", ses->se_fchannel.maxreqs);
> +	seq_printf(m, "\nsession target slots:");
> +	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
> +		seq_printf(m, " %u", ses->se_target_maxslots);
>   	spin_unlock(&clp->cl_lock);
>   	seq_puts(m, "\n");
>   
> @@ -3674,10 +3730,10 @@ nfsd4_exchange_id_release(union nfsd4_op_u *u)
>   	kfree(exid->server_impl_name);
>   }
>   
> -static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, bool slot_inuse)
> +static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, u8 flags)
>   {
>   	/* The slot is in use, and no response has been sent. */
> -	if (slot_inuse) {
> +	if (flags & NFSD4_SLOT_INUSE) {
>   		if (seqid == slot_seqid)
>   			return nfserr_jukebox;
>   		else
> @@ -3686,6 +3742,8 @@ static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, bool slot_inuse)
>   	/* Note unsigned 32-bit arithmetic handles wraparound: */
>   	if (likely(seqid == slot_seqid + 1))
>   		return nfs_ok;
> +	if ((flags & NFSD4_SLOT_REUSED) && seqid == 1)
> +		return nfs_ok;
>   	if (seqid == slot_seqid)
>   		return nfserr_replay_cache;
>   	return nfserr_seq_misordered;
> @@ -4236,8 +4294,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	dprintk("%s: slotid %d\n", __func__, seq->slotid);
>   
>   	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
> -	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
> -					slot->sl_flags & NFSD4_SLOT_INUSE);
> +	status = check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flags);
>   	if (status == nfserr_replay_cache) {
>   		status = nfserr_seq_misordered;
>   		if (!(slot->sl_flags & NFSD4_SLOT_INITIALIZED))
> @@ -4262,6 +4319,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	if (status)
>   		goto out_put_session;
>   
> +	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
> +	    slot->sl_generation == session->se_slot_gen &&
> +	    seq->maxslots <= session->se_target_maxslots)
> +		/* Client acknowledged our reduce maxreqs */
> +		free_session_slots(session, session->se_target_maxslots);
> +
>   	buflen = (seq->cachethis) ?
>   			session->se_fchannel.maxresp_cached :
>   			session->se_fchannel.maxresp_sz;
> @@ -4272,9 +4335,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	svc_reserve(rqstp, buflen);
>   
>   	status = nfs_ok;
> -	/* Success! bump slot seqid */
> +	/* Success! accept new slot seqid */
>   	slot->sl_seqid = seq->seqid;
> +	slot->sl_flags &= ~NFSD4_SLOT_REUSED;
>   	slot->sl_flags |= NFSD4_SLOT_INUSE;
> +	slot->sl_generation = session->se_slot_gen;
>   	if (seq->cachethis)
>   		slot->sl_flags |= NFSD4_SLOT_CACHETHIS;
>   	else
> @@ -4291,9 +4356,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	 * the client might use.
>   	 */
>   	if (seq->slotid == session->se_fchannel.maxreqs - 1 &&
> +	    session->se_target_maxslots >= session->se_fchannel.maxreqs &&
>   	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
>   		int s = session->se_fchannel.maxreqs;
>   		int cnt = DIV_ROUND_UP(s, 5);
> +		void *prev_slot;
>   
>   		do {
>   			/*
> @@ -4303,18 +4370,25 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   			 */
>   			slot = kzalloc(slot_bytes(&session->se_fchannel),
>   				       GFP_NOWAIT);
> +			prev_slot = xa_load(&session->se_slots, s);
> +			if (xa_is_value(prev_slot) && slot) {
> +				slot->sl_seqid = xa_to_value(prev_slot);
> +				slot->sl_flags |= NFSD4_SLOT_REUSED;
> +			}
>   			if (slot &&
>   			    !xa_is_err(xa_store(&session->se_slots, s, slot,
>   						GFP_NOWAIT))) {
>   				s += 1;
>   				session->se_fchannel.maxreqs = s;
> +				session->se_target_maxslots = s;
>   			} else {
>   				kfree(slot);
>   				slot = NULL;
>   			}
>   		} while (slot && --cnt > 0);
>   	}
> -	seq->maxslots = session->se_fchannel.maxreqs;
> +	seq->maxslots = max(session->se_target_maxslots, seq->maxslots);
> +	seq->target_maxslots = session->se_target_maxslots;
>   
>   out:
>   	switch (clp->cl_cb_state) {
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 53fac037611c..4dcb03cd9292 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -1884,7 +1884,8 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
>   		return nfserr_bad_xdr;
>   	seq->seqid = be32_to_cpup(p++);
>   	seq->slotid = be32_to_cpup(p++);
> -	seq->maxslots = be32_to_cpup(p++);
> +	/* sa_highest_slotid counts from 0 but maxslots  counts from 1 ... */
> +	seq->maxslots = be32_to_cpup(p++) + 1;
>   	seq->cachethis = be32_to_cpup(p);
>   
>   	seq->status_flags = 0;
> @@ -4968,7 +4969,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
>   	if (nfserr != nfs_ok)
>   		return nfserr;
>   	/* sr_target_highest_slotid */
> -	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
> +	nfserr = nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
>   	if (nfserr != nfs_ok)
>   		return nfserr;
>   	/* sr_status_flags */
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index aad547d3ad8b..4251ff3c5ad1 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -245,10 +245,12 @@ struct nfsd4_slot {
>   	struct svc_cred sl_cred;
>   	u32	sl_datalen;
>   	u16	sl_opcnt;
> +	u16	sl_generation;
>   #define NFSD4_SLOT_INUSE	(1 << 0)
>   #define NFSD4_SLOT_CACHETHIS	(1 << 1)
>   #define NFSD4_SLOT_INITIALIZED	(1 << 2)
>   #define NFSD4_SLOT_CACHED	(1 << 3)
> +#define NFSD4_SLOT_REUSED	(1 << 4)
>   	u8	sl_flags;
>   	char	sl_data[];
>   };
> @@ -321,7 +323,6 @@ struct nfsd4_session {
>   	u32			se_cb_slot_avail; /* bitmap of available slots */
>   	u32			se_cb_highest_slot;	/* highest slot client wants */
>   	u32			se_cb_prog;
> -	bool			se_dead;
>   	struct list_head	se_hash;	/* hash by sessionid */
>   	struct list_head	se_perclnt;
>   	struct nfs4_client	*se_client;
> @@ -331,6 +332,9 @@ struct nfsd4_session {
>   	struct list_head	se_conns;
>   	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_SIZE];
>   	struct xarray		se_slots;	/* forward channel slots */
> +	u16			se_slot_gen;
> +	bool			se_dead;
> +	u32			se_target_maxslots;
>   };
>   
>   /* formatted contents of nfs4_sessionid */
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 382cc1389396..c26ba86dbdfd 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -576,9 +576,7 @@ struct nfsd4_sequence {
>   	u32			slotid;			/* request/response */
>   	u32			maxslots;		/* request/response */
>   	u32			cachethis;		/* request */
> -#if 0
>   	u32			target_maxslots;	/* response */
> -#endif /* not yet */
>   	u32			status_flags;		/* response */
>   };
>   

Hi Neil -

I've found some misbehavior which I've bisected to this commit.

If disconnect injection is set up to break the connection every 25,000
RPCs or so, xfstests running on an NFSv4.1 mount will eventually stall
after this commit is applied.

Network capture shows that the server eventually starts returning
SEQ_MISORDERED because the client has forgotten an retired slot after a
disconnect, and tries to use sequence number 1 for that slot with a new
operation.

I've narrowed the issue down to nfs41_is_outlier_target_slotid() on the
client. This function uses a bit of calculus to decide when to bump the
slot table's generation number. In the failing case, it never bumps the
generation, and that results in the client freeing slots it shouldn't.
The server's reported { highest, target_highest } slot numbers don't
appear to change correctly after the client has reconnected.

If I revert this hunk from 5/6:

@@ -4968,7 +4969,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres 
*resp, __be32 nfserr,
  	if (nfserr != nfs_ok)
  		return nfserr;
  	/* sr_target_highest_slotid */
-	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
+	nfserr = nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
  	if (nfserr != nfs_ok)
  		return nfserr;
  	/* sr_status_flags */

the reproducer above runs to completion in the expected amount of time.


The high order bit here is whether I should drop these patches for
v6.14, or whether you believe you can come up with a narrow solution
during the early part of v6.14-rc that I can include in an -rc update
for NFSD. I can't really tell if a significant amount of surgery will
be necessary.

What do you think?


-- 
Chuck Lever

