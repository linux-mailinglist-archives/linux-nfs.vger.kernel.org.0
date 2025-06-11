Return-Path: <linux-nfs+bounces-12323-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E850FAD5C22
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 18:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8035189D067
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89961A3154;
	Wed, 11 Jun 2025 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nKRSEIxI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iCzvKwcZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5782E610A;
	Wed, 11 Jun 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659411; cv=fail; b=M0uPx1kz4ToEV/Jl4D9w2D5kNXcQvCmaMaZGglw33mLTc8hs3qLpf31qGYOrGCwANn3ZOqBu/3RqVENUMtpurhxMdg0FV9AjAyVxFfW7kUwf0LTKOeg0y5M2Ih3fh5cTU1c5NKX2zcuD/aSxOA7ssmrtP16ZQIE7ywQ4AMrwags=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659411; c=relaxed/simple;
	bh=L075y5wXxU+Jb+yvTrY2chrnZYmBnO5zCeTZhDVqkWg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qtkUtgG+nxvs36bfnhefIgj9hcDncFs0nvV8O2UxwHx3HzwF6pKyD4t0ASh+r8MtXH9Y3tvFKlgucBUnUWdMg+7LU0ba8n5C5UhDrsD2ekptiHNNWl37LOBgdDAnQjvVVMv1fy3mNMAbkhnqFVvfGzn/LhYl+2ANmksyNbU0eUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nKRSEIxI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iCzvKwcZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BFW41E008873;
	Wed, 11 Jun 2025 16:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lCcDveqYxoJQFubWlH50JWhmjSLQM8XDW1SQI6JWjSk=; b=
	nKRSEIxIXHRf3VJxNvSpX+BITWP8JCkab68aM1HpB9/Jy5Nop7cMb11tGW2xS9BW
	JqS4vFT8KV9SgX1i0LXVksDr7KsqP6DPyEvQu6YCcpy4Zy9Fb4V93jggM77YicVh
	fhk3KwaNW2J82ISyrGtCTW+oUlfAbubloUUUTeRyufhgQCnzf2vyVPs5Yzmlkebl
	McusujDMQLvXsrcCy7RwKQ4Akq+ceBO55TwJ0zMksO+6zItnQqnbrOzpjkSzHqca
	gR2DRPvXcHllc3nx6tHMSXbN7ZYd/t7nYmGdo+n+zChw0kpy1GbURF2AM9Bu63r/
	FpnEajS+kbmWNDw0mqmG+A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474cbeg1gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 16:30:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BGMUW2007381;
	Wed, 11 Jun 2025 16:30:01 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bva6a1u-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 16:30:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGmuZCjXGYtO+lA5236qClFzNZZJzG9OnJChsQy5GiBeTj+6cxivF8ze7vNO2h4CzbGGcpy9AzlVtrxAGNGTNzK9GH6EPenaHj4CpuBhQeF3uFe+wxAZIsT+7Upi9A1D2PkcPVBdRpKtZ1CGQCECRzwKFVkw5EH6MRJVP+me5rZu5k0bEF7RW2M5v28fe5eABIwBwRgN8zc3VDC/YXviqB/IaCRe87LveBlFs7zc0xEmP+i0V0mn1ALJG9PgJ/tTVdRlMwucbzUUweTrhnwzQofC8a1xaFmCQ6ghJGkKBh4lEEE0jskSnkfXhF05NiW98vUXaqYUvlyOjaLIci3jAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCcDveqYxoJQFubWlH50JWhmjSLQM8XDW1SQI6JWjSk=;
 b=Fp/tODC+ssBAQ4P+dFEoM273yVcoRX4UplTltsahU0/Qq92cAZOf51NIUdY8kfXikp5yon6MSbp0nTG+iRhwuWcsCunFITGaUOglZ9+bGdB1wDyfbtmsXu3ForZF50MN9ipOjNWZV/SzQt41q6gRNubDuQuP+CTxBunBUqQ38371qgi8M5eA+yENY2hs1pBitxgXk8Gd/mLqZSx1DYXh8TRr2O/WD1yFILuU0XH0JQ/mRt+0wFhxCFJy7GfyctxG2ZLFvXyB1IrCNpOJ176unY7Y4xRk7Gvm0osJQ4seg9ykGYEWRIPsxwzeRXPtbSVDrkUFtWiPnlmUC+yN8ZXfeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCcDveqYxoJQFubWlH50JWhmjSLQM8XDW1SQI6JWjSk=;
 b=iCzvKwcZ+Bsin117AeiCNswReZSfct0wyoHnDFbR2AQSNV7ApmM6h1+wiQ1oiAQhWX3dZHS7oB0DQR2/Gn3qS+oziP/sI4t66lnvy9T09kWe5gWw9Gj9BcmIVWPDd/obNdHo2aTIsHlUUuDrhVq/RFJ/rw8aDx9MHWp2+z9Ii88=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PPFA3FC49FBA.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Wed, 11 Jun
 2025 16:29:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 16:29:53 +0000
Message-ID: <b6ba7275-ceab-4619-9e5b-a886daf34689@oracle.com>
Date: Wed, 11 Jun 2025 12:29:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Use correct error code when decoding extents
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Evtushenko <koevtushenko@yandex.com>
References: <20250611154445.12214-1-sergeybashirov@gmail.com>
 <5c8c207c-0844-492f-99e0-48b874b5404a@oracle.com>
 <2eq26bzisytieyfvad46uz5lr55msw6fdzs57lp5lcjmguuod2@nr2aryd6qaau>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2eq26bzisytieyfvad46uz5lr55msw6fdzs57lp5lcjmguuod2@nr2aryd6qaau>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PPFA3FC49FBA:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e8f225-3a57-4804-cbaa-08dda90531a3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QWhjaEQrYlZyU3NJR00yQ01XSUQrdGNldi9vRVAxRjZLR0ZjMWd5Q282WmQ4?=
 =?utf-8?B?L0l1RXpIQWpidnhhakhzNUNraGJSTURKQ3ZpUGZGdkZsbGJzWHpDMzdtRW90?=
 =?utf-8?B?Zmk3RXY2c2xkbmZjUkV6TWl3Q0ZoRXU4cnIwb2dsVmM4NUg4V2ZtbXNGa2c5?=
 =?utf-8?B?Y3A3MWxlam5DWUh3UEdyWHNOVVdsdjNEQ3JEQjlGaGpRK1NCTHU0S3plZTV0?=
 =?utf-8?B?akV4V1RDdUZId1VzTklKZWFhc2xMclR5V01iQ1hZMzBHTUhwQUxGTVl4dHpt?=
 =?utf-8?B?RWJ3SGl1VWhnTVpiSVEzNzV5ZXJ1QTdheGFIbEtmaG9uWDJ1VjVKaDdBR1Z0?=
 =?utf-8?B?N0lPZjNXOThPVEFGL0JtSHZwUDk5RlJVT2JtSVRSMFVBaXByeFg2bzZMT0Mz?=
 =?utf-8?B?TkloSklQTlRDSmlNZEMzcWU2UmFkWHF0QWw5MUtpeE56enhmZWgzcVhZZktN?=
 =?utf-8?B?eXJaOHNzUTVEWmRXeXFJVzl6cWZwN0lQN3BxM3d6d1Y5WmoyU29QODR0N3NR?=
 =?utf-8?B?UEFuR1dYSDZjUkk0L1BqWmZNV0xrb2xrMWdMUldiTjlOanRkZWpxTFF5L2tw?=
 =?utf-8?B?d2dxQWJaTjh6UEVuLzlvRmJpVkgyek1hbzBla2tldThQakdvVGR4TlJyY1hL?=
 =?utf-8?B?ejJLcXN0eExyT0pYbTg5a0s3dEhFWTFHYVpqWmxqdzdNb0x6RUdURTdJd1I0?=
 =?utf-8?B?dXJrYWErWWNRTkJZSndDU0grMnNtTGxxb3VUcGhqeUx6U3IyeTlEc3NxQ0NN?=
 =?utf-8?B?T2xJNFMzQzJoT0VRUDZ5ZzdSZXpZb1hscjNlVVBkSmNqOFlTV0tnQ0VJa1Ru?=
 =?utf-8?B?QXRSV3dCd1dGSHhzOUdTVExWb21NRFRJRVVTTVQ2b3ZuNVJyWFBsWktBUHkx?=
 =?utf-8?B?VmtNWVVpSkV1cWNjR1RkbHdpWmtQek5ZSlk5TTRJWFRwRXQ1dWxPUFV2dVBj?=
 =?utf-8?B?cWx4QXhKYTUxQS9YK2FaZHg5ZDhIdmxOa01KRENxeVlhN1E3UURmN2FCZDY3?=
 =?utf-8?B?K3BHN0V0UGsvdmd0clpBK0N5ZkxxMVEwM3c0cVVNNy9raHlBdEgxOUx3SkdG?=
 =?utf-8?B?WUUxYllnMUt6cWJucFMrNzRvWjBNSUNXU3pjVFZBZ3YwSmdIdHc5bDI5K1k0?=
 =?utf-8?B?Y25qUHNyV2tLakthcXI0MGdsalk3clUxYldUYk5zQUZmb0RSMllKazZCWTNy?=
 =?utf-8?B?L2tLRnFhcmZvZ3I1eDk3OThib25oVHVQSDc2VkpuQTJEdGUzVXJKSHF5SDkx?=
 =?utf-8?B?SllnN2d4OC9oZTBORkpMdmMzV0VsM3ZzaDhaMUZuTWFvbmdXV01CODVDaTN1?=
 =?utf-8?B?bDJ2dkE2VitqNTdNV1FxR2pjYkQ5aUYySTJyKzRTbGs4cUJWVXk4UG5ENklK?=
 =?utf-8?B?YlZtWmczeFhuMXVWWERkbXJ6cE9iZEczNEZuU0QwQ0lVZ0k0N1Q2YTVTTDdk?=
 =?utf-8?B?REx4L3EzdnQyeXlnelBYakhNaDYzKzNBQXhiYVBqeU8zaTUvWFIvMFp0ck4v?=
 =?utf-8?B?ZlE1alZvUmUvZFFlRkQvT1ZUcldNcVJZQlI3YXJ6WTdnWHlOdk5kejZMMDNr?=
 =?utf-8?B?aEtpMXFTM3FtcHpWOWFRZDN0NTl1ZXdhWDduOGNCVUowMWRvQ0tGczRzKzFD?=
 =?utf-8?B?TkN4eUMzUWNFaUJvZG45VEJuZ2xzOU5ML1lBT2s4eUVYUnhPVDBqM3dxaGdK?=
 =?utf-8?B?bUQ3clplOW5jeXNBNmFqQnQxa3JZU2xudXJrMjVEUTdCY3dGUG9kTm41Sklm?=
 =?utf-8?B?akpFazlwdkJzNFJXME1vVk1SV3FNRHB3My9sQmsyL2VFTXcrN3cyTDFjNXF1?=
 =?utf-8?B?aEt2K3F5VXp6L3NuckUvck9lN3dTSExKMUtrMk16aTR6NlgxdVRGNU9IYkwx?=
 =?utf-8?B?bjN2NVlRdC83NVJoYVVpYzV3K0FNa09kQm1aalVhTzVxUi9XNmhRdk9hNG55?=
 =?utf-8?Q?aDATKXuye60=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aWE1SFlHL2dKU0pYSkg2OThYWk96SSsxV2xDUmc1OXZqN2ZKTENibTQydmMz?=
 =?utf-8?B?aldaYzh3TE1NSEcrRGtpbHlWdGF3U1RaWXdKZVpKVUVXVnRaMEY1SVdvZU05?=
 =?utf-8?B?aHNNZm9XTWhHd0IxTFZ1WmgvMzAyZEpsU21rSWljcjlyM2ZTTHRVdVQrMUE3?=
 =?utf-8?B?SGFCTW9NejlkRWthS2E5Sm9qUGR0cjZSZjZRMGd5NGRaZW0xWVNhajdUVjk4?=
 =?utf-8?B?NmNVQkxJZ0dkYjE1TVVGSmJoNWNvWG9ydUFJMUdNU3dNS1Y5M0duNS8yTEti?=
 =?utf-8?B?RGxiOUcwOHBmTG56c0Fud2pqSGh2RlFWYk9SeC8wSC9sNGJLc1BFWGljTmM3?=
 =?utf-8?B?Q3VtMTZwM3VaMWEwZmh3NTEyMFBKSkxXbFNoSGdDbTVUYXNUUnNVbERpVXNC?=
 =?utf-8?B?U2pSWWNJWG9zaG9mUTRvczRYdjFOeEhobGd4VXVzelo3cDVlQ0pZR1hZOE5x?=
 =?utf-8?B?YUdtUHZuOWJYc2hGclJKalpvRHZrNmtNUjllSjlzMkVNZXF1YWt4aU1IbEo1?=
 =?utf-8?B?VE8zK2pYSlBYZkVXRWlkaW4rVnB5OCtzK25XZmhZWXdYWDBEc3VyNk1KdU5X?=
 =?utf-8?B?azVIR1piREljZ3RITkdnSyt1NUpHS3lVbFgyaUpGRWpLNmJBUVZWVitIc1Nl?=
 =?utf-8?B?cHhGTllnVFFOMk9JZkI4VnQzOUVXRlNiVjRINXVQUnJOZHFDNitsdmFFL0tF?=
 =?utf-8?B?VkZ5YVN4U2hqMUVpWVByM2pYLzBxeGhIZ3I1TG1kb2hLOTFzZHNIK0g0R0c5?=
 =?utf-8?B?dXk5ZWtrV3htRytwQ1U1TVhHQ2dHUkxvTnJzdUgwdER5RThTVHcrKzhMZUc4?=
 =?utf-8?B?bncxYnJMZFJJWFFDajd4VC9rUW9ZNzRUSC95WlVSd2Qxa3dqNEpqM1pmK2Rr?=
 =?utf-8?B?bkUzTWpFaWpwSkhlWVJUdnhncXpSaysxUW5XWlZRSVpEVFNiWURZeDJ5VTFQ?=
 =?utf-8?B?MEs3OWR6azg2S0d2ZGRPTkluNXNkNFZrS2VBYldDZFBhUEpXTjBoNW5CR0da?=
 =?utf-8?B?TzBJcEpHS1JwUjRvbThBUE1LNDg3RG5vR0VwRU5MUERodVlFREF0MmtTZVNz?=
 =?utf-8?B?SG4yWFdpTHFRZExOdmJaQ2RiZG9vWHdPVHkrQlVvZU5STUY3R294MjE0V01S?=
 =?utf-8?B?VjlLeGF1c2hqRHlIa3RQbXZXSjlUem96ZS9QQkpOcUpHeEtSOXdvNTdkZ0dj?=
 =?utf-8?B?S2t4K0pYRkpXV0p3b0dKc25OeldDUmFESHBIYkxxRHRrVStLL1ZtVDN0ekNt?=
 =?utf-8?B?NlhxYTJDM1ZZNTBaYy9yYmVoektBdWZocmVoaFBraFJhOU5vbm9nK2dJWFFh?=
 =?utf-8?B?V0VoL2dCWGlFenlCenMvMzRmMzFCTCtQRWFTVGIxV3dNaW5ieU05d3JTa3BS?=
 =?utf-8?B?em8wWWhLa2kzMm5EVWIxdGpHdHYzSEd4RThsZmFQYmtIKzVzWEpTeGR5eFV1?=
 =?utf-8?B?RTJ2YTU1OG5qMjAwZHB6dkxvajlJNGxWZ3J4aGQwckVTb3FlTkJ6OHN5NEtJ?=
 =?utf-8?B?YWwrdWNNSkJ2QlNJdGdFWVYwNUdRek9SckNuSml4ODBiMzhYY2RYbTdWaktw?=
 =?utf-8?B?ZVI1RWJDZ1ZhRE9sTnB0VDBoZ1BMdlRNVEpNcnRJejFwcy9mWVI1SUlTVUNx?=
 =?utf-8?B?UlA2aEY4U1prUTZNU1M5SGdqd0ZQRXI2UW9jd0h4QzdKcGtMNGoyWW8zZDh1?=
 =?utf-8?B?QmprQjUwR3gxTTBLZVNDMjRUZlhvakg0RGVsRzhjNGdoUnI5NlloOExyTkE2?=
 =?utf-8?B?SjZ0aGhSSFB1ekNLN3VpSG1yVzZGWEhwazkwRStyY3AwSXNMRkppdDdhTU8v?=
 =?utf-8?B?S09mcVQwQTRXS3B2aHBMNzY4UTNlTGZxbUswNEJGWjlRMGZSU1J4bzFBN1dM?=
 =?utf-8?B?SGMva0xIYklxcU5DamFhQWdCU3MzMlFTV1NrclBRNWprY1NhSkFtZkoyOVJo?=
 =?utf-8?B?MG9UbVl1UWJhaThieHU1anZHRkVpWkhicW5NOEREY1pZWmtGZzFSbTUrQkpV?=
 =?utf-8?B?RmtENUtiWFl1UnI3NlFRbC9tZFVZYWNZc1QreVdNU25kTUZ5RmRlMFIwZ0hI?=
 =?utf-8?B?N0VzaUdDeC84dHVxYXduMko1ZExEU21nUG1FaGVHME85NE5XVWY1YmR2b0JU?=
 =?utf-8?B?NENuTms1bkNFWHAxT3dhdVh4V2VINWd4SFBuc1A5NERjd1Z5Si90Uk5Nc0hv?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AwyEzs3S4/KSiT+E8CtGC9rzyEzhD8yLYMTDKybM7vrjY1H1xrGyspTKRnh5tqiHDoGOX5OIe06ZzZQ7HaL8Nmt1Lx2D8/pLob+LIyRBXSLikCvN/0sI/BIMVMT532S84WhmWju+KHpj4Do9DGW0ccxe9YHFSxwtUmucH0zfR31GVBOZ2uvdopZGZycXLYeX6WWvfatqHshlpSqdY9i/VKn9VSXw2BQ0wWasAj7a72CmDI1tAbaqjot6X+R8niES8Bh446Ziy31CSViA4ItbT3FL7qq7PjWXzREpiXkfK02gpv/AeTwvrLolBFcf4eR/6JVcWbRu5xapRyGHvkC7GPyGOxBwJjZqSn3QL5VS72u+Bd59IbC4PE+JuGcEd55oFA6RgLDzFL+pb8slChP1dwmLfMyzFviJ9x7BBXhgf+A9Gr449SqGAiIj+3dRdHnXHLIKE6z/zhWf7pucnlbeLYsjrbeUpHH14BYKE/J/ydX3oN3ZUWQdxp6OnxTCRYJl5VmCChy5UnUjmHIpYydoViEDGZ/xYASaFYRo2rQgerFaXO5AqdhihtlxQ8+/CA65KunUFlgUjEaxHur5boqooRtQhxo9XmjS8QZP87FzyZs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e8f225-3a57-4804-cbaa-08dda90531a3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 16:29:53.1243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rCHdL2h8IbkCTES46S8nOVRSQm4z3EcEx+dvra2Z+s6ZPgCIBGLyjJdoxTwMiqNDJhMxOitnzjRGl/XrzsdwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA3FC49FBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=606 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506110138
X-Proofpoint-GUID: b-OlZgAJdp2eoGL0lUoTwF1zyfZ-yhDl
X-Authority-Analysis: v=2.4 cv=BffY0qt2 c=1 sm=1 tr=0 ts=6849af0a cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=fLGk_LWdZYgPEUvhWcYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: b-OlZgAJdp2eoGL0lUoTwF1zyfZ-yhDl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEzOCBTYWx0ZWRfXwM8QmpR+eSq1 e2TQUauy13ia2g7yEZv3ZE2BEtdnvJGfMpDOXBXytsBhHfwrEO0Hf91bJTiOfVffz74iC4ThuF8 5kQOXQ0xsCgElHAzqtY3avJSnp7z912eFid6eoUfTLItn+xKiO9ECLldhM/BqONl7dofqlwsrOt
 cD/ddXgADdfhl04FZKrPds7SlExuCeUm763oeSfFcV/NBwTf8YB0OfvERlrXXpXIts33eZV/X9q HEOiUK/ZbB5O+kfuukGCjQiBEyI/aUcBIAqZ9VFt1S12vQtXEVuVOaXgVdKAwzWp3AdEHJtylZ8 dH+P6dHPTbCSSUpuZAPDfKt6ELGDX9ygHJQYQ7Dou31nvw7t8+EaT0FwVkwE73wFFQl+b/OUgMg
 1HUxi2XZgsiCMeUgETpBTW3Q8yYflQnlP9LudodXohJA6kYlIRii3xPUbyOvTNqemRfyR/8y

On 6/11/25 12:24 PM, Sergey Bashirov wrote:
> I also have some doubts about this code:
> if (xdr_stream_decode_u64(&xdr, &bex.len))
>         return -NFS4ERR_BADXDR;
> if (bex.len & (block_size - 1))
>         return -NFS4ERR_BADXDR;
> 
> The first error code is clear to me, it is all about decoding. But should
> not we return -NFS4ERR_EINVAL in the second check? On one hand, we
> encountered an invalid value after successful decoding, but on the other
> hand, we stopped decoding the extent array, so we can say that this is
> also a decoding error.

On first read of Section 2.3 of RFC 5663, there's no mandated alignment
requirement for bex_length. IMO this is a case where the implementation
is deciding that a decoded value is not valid, so NFS4ERR_INVAL might be
a better choice here.


-- 
Chuck Lever

