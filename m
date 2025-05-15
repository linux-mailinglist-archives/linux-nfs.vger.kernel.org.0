Return-Path: <linux-nfs+bounces-11743-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1FAAB8663
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 14:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CE13BBF13
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 12:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F542989A8;
	Thu, 15 May 2025 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lZ8vSN9n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OxXFJseQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435E2222CB;
	Thu, 15 May 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312305; cv=fail; b=jsD51XItQtW+ozSmWPeSPF8ldjQio13s+qEcTp+au+Bdk3f4VRogg+VWQPTFPPASIBgOXF/jNv1tQUZfU6jd+yepAaDl6T/iASN1rjQEKYk3KItLOIkHLo6YYY5hbmYGStDpgcGHelCMmq+saEdX1uKDEFu8fC5fhoyJeZyJX74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312305; c=relaxed/simple;
	bh=FcfBnum6ia9Zrvqjf7Lb9qsvcsLyn/f7REs9AJL3eFw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XhL+SwzEd2PMdgWmmouegsXJYv9NWuBsBgbJ3SJy9OJJui2N4mGfBLfsZT62TV+BubBQHQnS3Wtb191t75LPqKrdMHyNftE2dUmHc/gEmMnxhur9hCYXqsCF36HKiNv0aJAPiGYX+bVjXv97W9yc8G0DTaptUZoJi2q08AtpX6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lZ8vSN9n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OxXFJseQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7CA9c012167;
	Thu, 15 May 2025 12:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bz9hDI4K3fPm7IYWTtsO61uqkZ34fEHzWjEeqgOTzCw=; b=
	lZ8vSN9nr1E2LbsOCZs5e2rStSf89uewKRzVeo88Vn8tYZ4+U3SgiQkjB0iDZauo
	szGpl7V0B1MampIjbQ3uJloRyrObJLP3i/q2YwV9fga7MYYMI9TuUlHt6MYCX4pu
	TgnFEsJc58MWPUWNzOeXbEIPxkSeNHnDba0PiWyEP5OqL++fTSwRk7w9rNfOLoLZ
	GSr7ui+EYsBDlKW0zy9sjMt7dvltHRX8Z3Dqo9PzOSHxgNYCTFZsrHGHTM72dx2r
	/GOwCxYydiAQpZv7wDrisiUpaK3ZxADg21HW8u4pFTAxwpL3TVJdjqRNKzd3ZX5B
	C9YsaEgftiHl2DPiWxgqMg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcmkv21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 12:31:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FC8IeB026189;
	Thu, 15 May 2025 12:31:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbt98cj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 12:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRMdqB5DAfiE1VNin3clEFqRf4B1F+nPf7Il26rO3Fa3H3iUWtiEFcJgKLaNHMSMLuG9frKMZxzvmcp9TqEzND/Ko4imL5Ncs4xh0GmyOYGd7Rnsn2wRCheI25ZzIrRWG/xXILU2aDN5fOMX0v18Lf/LjCTt4kpimwQG5c0ydCdyElScmBZQqCN/pzFi0FMAjgopd9suu/tBN8Nd//5yQuFbXI5jnLIpRpp26CasRmH0zm/mBBDDNhIZkUL//BYFQgEazgtRD3cTQqB9yssle7lObJn+JLf7JfCUR1EDY16BDexzCXbEL1viQklsJG7MvUnP5rFvVjj5XQsbe+n6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz9hDI4K3fPm7IYWTtsO61uqkZ34fEHzWjEeqgOTzCw=;
 b=lrp7dqsHbJEOTR9jJajY9K/brPyOOURh21FXDx2uij7bkQTpXQrkHHXdtvjmIV8WgW7U19lEUvfqsTbfmV+ZRJbDZWGAe6QjDfVHO28cTRrkhxvxefjqOf9FPrHtZzv/TJiIJ78KGCmBa2Kika6xQjxgnk9KOl9Sp7Ig+OzrrVfjJCAb8R7jew0PNVm/N7VrU2uf/QjWyImAz6MaR2FfqcOYRd8B0iSQhjYp2cH/uN/2wkcem3odV98c43bofX3MoRsPwn1fRu/XjQ+xaXkJuk53zJk4BIbLsgq/noi18ZRpnhGxY89n9PqJP4bHSICNe7lgXGSXWWOUZLOY11Erfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bz9hDI4K3fPm7IYWTtsO61uqkZ34fEHzWjEeqgOTzCw=;
 b=OxXFJseQiXontEta2zzcGmV63a6RkxDqI7FIdtJkQ47pN7lsEKPaaUsumZ5F0h7a+GFB/t3L/EFMjhm/FTHofSXUjwidWmjL6wSrUN0RY27/COa99MqCVMgIhIUuEvfD3s9l2CLq8AkvExTWe0YlnL8mSibF8T3Pe20QdYdIIN4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7575.namprd10.prod.outlook.com (2603:10b6:610:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 12:31:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 12:31:26 +0000
Message-ID: <79477eac-ba92-4d2a-9905-f5250e7e95bc@oracle.com>
Date: Thu, 15 May 2025 08:31:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: support keyrings for NFS TLS mounts v2
To: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-nfs@vger.kernel.org,
        kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
        keyrings@vger.kernel.org
References: <20250515115107.33052-1-hch@lst.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250515115107.33052-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:930:8::44) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 338d51b8-80e9-463c-7b04-08dd93ac690a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVRjMkhTN001a3F5bkRvVk4xZzV2bUhScmg4b0xmK1UxNm43ajEvamVaNTZM?=
 =?utf-8?B?N21zQmRKdE5GT2FTdC9nRTFCT2VRRy8zNXAxNUhIM01SNGl1N2lsTnBHd2Nn?=
 =?utf-8?B?TU9CanhGM0U0M3cxUlNWRnlaRUxNTVpPWnR6ZEZhdVNBbjI1N3YwcWZXOFdB?=
 =?utf-8?B?akRrWmg3Y1FnWkNmQk0yV1BRUUpDWWMrK0VsY2tMdU1aSlNVTHg3YkF1R3h0?=
 =?utf-8?B?TmJzUkJZMWQvaXFoVTJXd1VqRXdSUERnK2JvdW41QytPZnZSVXlkd3ZvcU9x?=
 =?utf-8?B?Q0hsVzZERUEvRm9ZeEdEa3ZRQ2RaUDVEaFlrcXFkSTVKSjk3OWFKTE5qbEFP?=
 =?utf-8?B?ZkZLSUgxSzVCQm1lcXBJdTJLVDlLTmphNHZobTFvMmNLNWppS0pJSGthazIy?=
 =?utf-8?B?UEZ3aXlZQ2xNbHJWZi9wc3dmNVUrUkhTTGVLN283Zkp2YkZiQldsUjJ5Uzl5?=
 =?utf-8?B?Z1kxMVlzK2xCMTFkRldIT0JMZjgvUGFqUGdFTFBWSkowajhuWVpSNWIvVU5B?=
 =?utf-8?B?MGZTVXI4cXpEMGhmTDBNSUVGS2paTlh6TWtkVkM2eWZGcmFOZTB1YVhkQlBE?=
 =?utf-8?B?S0lkNE5ZdUNkS2lyMXdaQnFrczJhdnpTeCtMRVB1a1NwWWRxN3N4YXEzY2Z4?=
 =?utf-8?B?WlNkdTBVODVLYkNia05MY0pwWDlBUUFvRVZ1U1Jackd1ZFdNZVJ6cWhsSTNs?=
 =?utf-8?B?d1N0bHRiL1VnNTVPa3ZqMHJFcHJLNWg4TW03bVpaSUUzYmNmK0hUSmcvV0xS?=
 =?utf-8?B?THA1Mklqa0E4UEsvd0dtWWR3VTg5MXVMQ1RSa3F0cWlPNzVZeHdBTEF4QWVs?=
 =?utf-8?B?ekFIZmF2NnZsUFNGaE5ma2RqVldYRWJtU0I3aG9MaUpFb0hzS1dXU1FDMDlr?=
 =?utf-8?B?TGlEaGNEUXZlRnN0aWpiQXhTTzkrc0prWDduUHdQOEY0RlFnV3d3VjdLZ0c0?=
 =?utf-8?B?VmxZUGltdkErRitrZHVEbTF3ZWJkYmI4ZGlZV1htQmFYcmxUOW5BUk9UYk1M?=
 =?utf-8?B?bStiYit1cXU5d1FtK1R1cXRYZUZMQ1B3Nm5EaEYrK0dNSHZ2ZXNnR3oydXJM?=
 =?utf-8?B?c2ZDdGVLa0VKZVhWanJHNXRHTS83NkxsN1JnS1hMeUh4TGZBdlI5TWVjUTBh?=
 =?utf-8?B?YmVKakp1ZkdrUmloZENQQ29ST2JiNE5nYTRCa2FUUDRxenZWcHVpWVoxVEJL?=
 =?utf-8?B?VXNoYkplOEJtRUZNcjRpUW5YYTVpQUxkbm04ektJeG83UEdSMXU2WTVDcHRX?=
 =?utf-8?B?MW0vNURJWWRWWWc3TTdWQXJWTHl5ZFRKTnJRclB1WnR2blVwMk1TTGRBcFYw?=
 =?utf-8?B?ZXRkTXU1NEtTWUoxVXpCVkdNcGdxRld4TnZ0TFNzT1IrUEJpcWhtdStaZjgw?=
 =?utf-8?B?dmJnakxnam1aOGV6Ylc2c01sV3lvSTlVS0lQdTFFYmVPWDNpbGdXT0l2eU14?=
 =?utf-8?B?YzlCTFJVVkRzNnlNcXRlYTZUblJZN2IxcTFHZklIZC8zTXJzczZveDl3K0Nm?=
 =?utf-8?B?SS9iY29lYzdnQTYzTFIzQUlKMENuaW5pRzBsSzNBVG5DZk5oR0dlVmpaRzFw?=
 =?utf-8?B?aUpHVFg4OVh5dXRWUGZLT3JVUWkwSVRlczVUODRQUUpSdlRXVytTOG02Y0Vz?=
 =?utf-8?B?ODRiZVVwQnZMTm9JUEZjaCtFRGZrK09hTnNnQ2tBSTlIZWJwZCs5RjRmQTNM?=
 =?utf-8?B?djZ1eVhXVmNZYjhnWG5OVkVuTm93Mkt6eTl2QWhmckMxOHhoWG9MLzVIKzMx?=
 =?utf-8?B?VTV2ZTdEd045Rlo2L0pjUGVCSG1nM1d3SUtOSlNLR2JoNVQ2MGpRWnJ4Smxp?=
 =?utf-8?B?ZG8zYVkrVGF4QnFmWnduN2MwYjFBWDJJWERCZDByYkR6MHo0YWYyNHdVWE5P?=
 =?utf-8?B?RVNwVklsMUFsTXJkdnlTUjN0UnUzNVRNdU0xYys5WWV5ZHJKTUQ5Y1B5MU9Z?=
 =?utf-8?Q?ziiQTOQWIZg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGorWldaWVhFMlA0TUxBa2U3dE01ZGJOT3l0aE45QmpzazI2WFgwRGs1STlL?=
 =?utf-8?B?M1BROS92UUNmSEFEdGVqNVU5WG5yd2pUWklqdmppdnFLbndsUGwwczBJeHMw?=
 =?utf-8?B?emtNc2Q5alVSeWFpd0FaNWVheFZOV0kvMjhTdmhIdlU4SGF5QTAwWFNXeE5P?=
 =?utf-8?B?UnMzbFprKzR2N3daWWZFYW1kcWF3N2ZKNWt6d3VBMzgxL2daeUNjaXpDckMw?=
 =?utf-8?B?R1lCTndEKzZyV2ZaOGVOZDNQRjE5Q2xpZm5mbWsvSDVUSjFvRnhGNmtObHYz?=
 =?utf-8?B?OE9XTU1wVW5oTVYvTjJ2YUlWdTh0L2VZVFgyZ2hvK0hCL0NyaE51dEFsZFll?=
 =?utf-8?B?cXo0WUFra1AxbHBzUGVoUitpbmE0cWFxR1lmOU5EbkRZSmZXbi9nZDJsZ0Va?=
 =?utf-8?B?QTRubVpTTkJCQmV4Zy9xZWtZTUUzSVV5VG1kVXdrTytKTGtOMDVjcGY3U0Rs?=
 =?utf-8?B?a21CWEpaUDFXOVhsS2FwSVZtTFVDTnByU1JTZzRkWGMzMU92emM4aDhPdE5z?=
 =?utf-8?B?UGdzSXJRK1NSY2dEOGlxbGRWcUNtSTFPRDNGSm16bU9ucDhaQ3N5U1YxUkVJ?=
 =?utf-8?B?b08rY0xJbGFxSHNRaDdEdEJVd1V2Z1dhQkZncVdwVUFkVlhGYmxzb0g3bFUz?=
 =?utf-8?B?T2NhM0o4b3dzK2ttU1hIOGhWQ1dVQWhBQmVHcWZacTRJdWRsSWFpeURqZ2s0?=
 =?utf-8?B?R2FWd0xqMHBaTngzTmtJRlNZUGRMbGJ1MXRlRzhHdU51MnN4MHN2TXBuTUNn?=
 =?utf-8?B?RTJpV3hQVkw2WmVzbHVzYURlUXpobnlHRFVXTmNhOWtTWG9mMVM1bU10ZDRL?=
 =?utf-8?B?c1gwc2lGVDFGei80ck9zdjkxazBqcnV4aFErQjIrcllrL2FMRUF3cCtuUmI0?=
 =?utf-8?B?REhsVWZ6UzVPWTVySlVPWWQ2WGVzZ3ROR2V0SzNVQ2x1SnUvZEpyc1pSZEFp?=
 =?utf-8?B?eS9aZWRpSUwxWlZ4VURCZVhnS1VpdXpxYmxPb3BON3YxUGtRU0gvUEdrMXQz?=
 =?utf-8?B?MisxaEhiTTNIYklWcmZhdWQwY0NFL1pBZWtqYk9FNFMwVG83eFdOUFlEZFc1?=
 =?utf-8?B?WGNJdTUxUGs0dS9mWnRLZ3E2WDlYeTdIaU93Y0dJRzVYM3ZzYnRsTjVhQkxC?=
 =?utf-8?B?NTJScDduOFR1ZHh2WldVUWJ6SDdvczh5MENDcHhxT2MxT3hrMXJIYmFteTNN?=
 =?utf-8?B?VGM4MGI5V2JqWmhtcCtBclVlMi9XNi9HWVp4bkg0RDNkZURIc0hRUXdQbVpX?=
 =?utf-8?B?WDM5TWhlelRyRWZ5RTR2a1p1am01NzRVMExENmgwUmRMSFkrVlFaem1ZRUJN?=
 =?utf-8?B?QjJPMXRpVmVsWGdBQmc5Q3Nkdk1RZWhodW9qMit2cm0zaHJ6eGpLc1doRjlo?=
 =?utf-8?B?M01yeFJmdkZFcUZ5YmtpQ0hZVTdlQlcrTHBRSGtkWWtWdDZ0ZlpoMVdyNVJ3?=
 =?utf-8?B?RU5aZnI3c1gvajZWdkJtT2t4WVp6blVxQ3NHM2w3U1hOek9VaEwycGdTajBU?=
 =?utf-8?B?ZVdVOTBrVFpXbWpwaUN2djBicmlaWmpRYXhNZnBKSDVZL1FJbHdpcTdjL2Zu?=
 =?utf-8?B?TzNyQ2JSMTZITkc1QXE3Q3RJd29tNFcvL1h6aVNwaVIraFZYV2hheGVza1ZG?=
 =?utf-8?B?RGhhQlh3WlRza2MyRWp4UTQwV2hyU2lOL1JTSGowY3RjUmhseG85T1NzN1Rm?=
 =?utf-8?B?Mk9nRytBMUVHdFEzRGVNUU9oeTdSNUs0dXREcGVKMVdZUzlReU9uSEw2dTRU?=
 =?utf-8?B?QTE1K0hjdmRoNlAxaEwrMDRmdWZBM285bTRxTXZqUWQrWTB1Ui9INUM0d1Mw?=
 =?utf-8?B?TmQ0TVdvSVVFLytMS0cyN3BwYTdtbXJwTFc0cGxHS0xEdGVYNHY4ZXBFYmJ0?=
 =?utf-8?B?UUJBeWNBSURLR052UjhjcGd1cnptRUFQNUNPRDFaeFhPRWFOOXAxSXRHQ1Vk?=
 =?utf-8?B?UGwxQkg4cFF6VGNteEkvQXl2K2FsVjRNUWtNSEdFcU4wVklxQThpT3l2aFZr?=
 =?utf-8?B?emtyUURXSDhTNjkxbUdEb3dqQnNsMGd2OTdVd1d6aXI3UzJWRTRwdXVkZXdk?=
 =?utf-8?B?dGxEQnMxN3RhenpMeVdOdzQ3S3lhTHZxUG96bVRJb09MejE0L2lucEpOeGFZ?=
 =?utf-8?B?am9Kd3BmYkc5WmpxWC90K0tWWW9wQ201bXphbUp3N1FLbGJkeWtMYlFDeWRC?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vPY38uffLDKTrLDjko4UEVZPBh95fsTeZWtSjx3BANwpYyZU3whg7Rq0u5KBS9ymdQa9nqAUpVPTxfK0biqT4hNOEd5wTiHBRssxM+q+BbLKpqe0jH6C7AZg+mua/McvCiv0CUHrBFElVISwwJxKgZFYzcQnS7BZR/+0cxm+oh3Ww/siiQ2hdLCtzSey4muzUmyxh0YzxahdmqWFdu2abgG+ji3P39g7O/P9xUKdkUHUyguMOmWKfig+itcrDB/VNWIFML4DmHX3uoUx4xdz5SlXhfLiMRhwD8oMQpYyQgqT+cyJae35jiXfpL4IVrLWo5+SVSE8JR1mQksUL46Eki7PUl3Pao7YB8eEWwsO3rYNdazRMaDtkREpfcqJZBmGD89K00IY3NRKFzc48xh2lp/rXuIDA/pjUxIT6DgQ7tlqXB92GVnBMpkzP9/daOwrePTqGo0vDHucsgmpsytq7G0UKtQoqC7dbFdeR7yNh5717o6hSoIlScdiVSfovKru0XmtTGLvbmbuhoxExsMil9afTI57a3HKXJJUL9DxpMdt22f9FQ/dkpdHyLHRwolNzLK+buzxUN1pZgC5mFcLyEyj8T31GqKl3mWOjU6ApYY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338d51b8-80e9-463c-7b04-08dd93ac690a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 12:31:26.3760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xolGpLCVO7eqg5NKXu4eoCQSU0QKs+mB2QcrBd+q/ZWFgPLqSHZZLkqOjEVXAZVYc+x4Pyp/Pwvk/JzrtClDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_05,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150122
X-Proofpoint-ORIG-GUID: 51m3RnDV3WRjTjUu8mUdM7DbU2VFdKCu
X-Authority-Analysis: v=2.4 cv=f+RIBPyM c=1 sm=1 tr=0 ts=6825dea3 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=aBGhgjOQafkjOULVYY0A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDEyMiBTYWx0ZWRfX0gGdbew39HFZ eSeiHC8BsLRI2zoyWDWz5xBDljobR8QPi+mLs9nGDYWDuqENirWe9C1bFPzZCdRrIbVi6jfl3j1 2UVVeEk0QssHNqFaAE/pbk3Saa4JvmiLltXkpwvO1igONlqqjx6IlXKR4Kjo/HFTI36kzpDqrFs
 b521x4onw5e/1CRTr7zjkti90URfKhOE2wGYMg83AgXWLFcV7WC0U79zMRvuZ7YgiWWdlkkuH1i 3WslwybnFNipCEnAUbt+LdMsznufsL5DT1Z3OoadkPX5CdpKuxGXyuQAW5UEzvyEtcb3BCt6D4u fXEIkqKlg+qGxDCarEh0GCiIvApHTkynOOzUA530TKzhmUKiaFl3mT4rTuwxmXWJRTNb8bKZLcY
 MxOgZ1lnbd859gsY9/72J5oDsoneCTj/5OrHG9s4gNXrYImmxzoZZLFi69tfyH4HQ1CIxish
X-Proofpoint-GUID: 51m3RnDV3WRjTjUu8mUdM7DbU2VFdKCu

On 5/15/25 7:50 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series allows storing the key and certificate for NFS over
> TLS mounts in the keyring and be specified using a mount option.
> This way they don't need to be hardcoded in the global tlshd.conf
> configuration file and can even be different per-mount.
> 
> Note that for now the .nfs keyring still needs to be added to
> tlshd.conf, but that should go away with the handshake enhacement
> from Hannes.

Just curious: Is there a downside to shipping a default /etc/tlshd.conf
with the NVMe and NFS keyrings already added?


> Changes since v1:
>  - don't depend on nfsv4 for the keyring
>  - fix compile when the kernel keyring is disabled


-- 
Chuck Lever

