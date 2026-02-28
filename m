Return-Path: <linux-nfs+bounces-19437-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FTIBbI6omk71AQAu9opvQ
	(envelope-from <linux-nfs+bounces-19437-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 01:45:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFDF1BF7A2
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 01:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3519303D326
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 00:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493041EB9E3;
	Sat, 28 Feb 2026 00:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LVOq7PMv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C5kdwqCv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315C91A9FA7
	for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 00:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772239522; cv=fail; b=cx/o6uM94e1BKJrrYt1QAenb9YwsNVnl8IhOZ7P5b1K7va99GeiiL/XhDF1wEeGt8jnzv+zK6P1e66uJfgnc/KsWZoUNbzR3WmbYUQiZ+tHmUSqFXZ0HhTWFEuEGbiuL0OtffJbRdX7WSFnO9thgWjIttY08ePP3GDZSZGoqwFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772239522; c=relaxed/simple;
	bh=1WoTdC7p58s5yqKoq0Bx92vRH9BczuAk5G6hI2Es/ug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iNrW21aGZdGtLjdDjPeAHysI/7868+X1nFCbfqIwrB0+sSj88/+fZoKA5VRGck1IB2nFO7+bUk2Q2FFeISwP/ppOGcZ/1QOop8BYuc8wAaOEbmgHYy9Dij75kIACoCnj7p5sco3imkTbrPMmMK3Ltrn/DLDL3jH/BSQB/B9+VzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LVOq7PMv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C5kdwqCv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RJ9Cqa2721184;
	Sat, 28 Feb 2026 00:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ne/oNDWkMGbJmB7Ie4cBrpgatYJcru8sQTmR5yPP1QQ=; b=
	LVOq7PMvE2aoEMdojQIbGKoxDg0BD2oQZ1SvbK0WU7Bo0Q0kv3Z7fJVgqw1loaby
	anhPnRd8t7ltNkFB1DPi7lASfIB8SYccvpADFjODkHLjfL9ISD0XPn8vFtcwm3qk
	3Dir6SbCf7kAN2DX6U5fXfACUGAUBcS3YQnS7iNcUmshsNu0rfnPrm5PFellhjTk
	iaZdEqIzlTN+FqewTktY3NevjuLMx42DFgip5gfVBtxr14E5joqjSM2OEcxDV5dj
	srA3N/yuXKS3QGZou/zUc1AEU96Ut1l7hiVF9jfH4wdzMVlP8sd3xIG4nkigBye3
	o8wf1pfLh5wYAV6kshN2Qg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3m845kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Feb 2026 00:45:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61RN9QtC022816;
	Sat, 28 Feb 2026 00:45:06 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35ersv4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Feb 2026 00:45:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qutPp8Yg0/Q/k7wpZfD9z+yiIMBrzDYoULYdHO/LC+BRD2pB3FpyJI/XurJOjw6A4KWu+nb+9siggCDkmw7ix0V83phVMc5gNtteSFOr0Sex7UYDhS4X0zfnfDCTnUVw7nVgqtp4Vaz02TL/zRKLP244kE+/zYnfoWCWPlD8efFzTb3BGaAntx3ZYV1YgkuAupCN577EtZD/exKBy6gq8feUji7WuXWSWFw/mrrxZAxAR2GvNntyeorPSbu3KaLV0T2leZFt2LFq0FFWVG/GOrl6cIN1bGLPO6r78iIxoGVmNPl+dxt8Ug3YRwjRHIRkoIa5pXGWIWNmsxx/oNtayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ne/oNDWkMGbJmB7Ie4cBrpgatYJcru8sQTmR5yPP1QQ=;
 b=ETwACLA9ki8WT7hOVg9JjI2WHa3M7FHOPxB0K6FoPWYKyGWLn5+Svn0aCLg5dpJXHyzr01yfSxAG7tRTn14JalrrvDZGkWY8Jx5odIhOh9Jvl/+yGelYGq9ao44NeJDJAz68q8w8n0YgLIlWm1Js1LZICvCWJzpRsz74AAWe7WcYWCAmLNPs4TmHbj1Ngeztw1l36CUW9ken7G80HoqNf6xutzfEw6/k7NWNiy8hMBdjb8j+pPo8bnX6BlffsRTZQ4gAvtnfDl2fBUoRkU+9wxq/DWglJdTlC44Q1Q1oks7OpGodjl5zT83os2zmGxbZaA00ELn0SgRmptFvyIOoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ne/oNDWkMGbJmB7Ie4cBrpgatYJcru8sQTmR5yPP1QQ=;
 b=C5kdwqCv74TtD/P5Lbc1+6BAP4QR6A1xatf5K6QUPjbtFyezEDmAGg5Z9pUXo6vWBe00N5GbGOxyUSjVHO5b1c25fyyTXKKgyKrmcvHzM2BXkXhQ5Qsl7RB52tUmHbNrPJtE/gJ8zJl+I0SCm/jX2J2hNOrCl1xYymQFV96L7N8=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM4PR10MB6888.namprd10.prod.outlook.com (2603:10b6:8:100::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 00:45:01 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 00:45:01 +0000
Message-ID: <c04bd15f-0744-4ff4-92b9-4847e08e0174@oracle.com>
Date: Fri, 27 Feb 2026 16:44:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] NFSD: move accumulated callback ops to per-net
 namespace
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
References: <20260226193611.1038076-1-dai.ngo@oracle.com>
 <a4bf76dc-2805-415e-be50-5501ea1ebf9a@app.fastmail.com>
 <e4b79d8b-ff77-4e1c-b2c6-8408b8310c5f@oracle.com>
 <77566649-f3ea-445e-a85a-afa1235ac9e1@kernel.org>
 <7ce6c46bef16d20f6e8ae8da1576b1a765cea1ca.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <7ce6c46bef16d20f6e8ae8da1576b1a765cea1ca.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::22) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM4PR10MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0bca25-6809-45ce-b680-08de76629b0f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 0KfiZHiOccxt8BM9xoShpgn1TctFcDcHlfbiEtlrOCfU3QB523vklwRyHQup2qf5n4kE+IeCQ83nxHvFi9rffjtc7bvM2dBlULKUgEuAxmg1OOUw3j28MDWUF/7s0NvfxzqrQYEYBIYa35806WvdowsKJy1uHqOrCjq6oo0aWBa5RvhPbbyEZqnWhPe3ul5EQROj99rh5UPv+dQmHIyQRTp2mM4tWqKHbX7hTk3QNfQ2EdZaa3z/vDh2SOu6GfCedTK9ciCQtDTC5M9Tk95f9Co3ZwN7rLPhG9OoIRQw4n39jvv5ml04zhIk2MnW9Om1h29XpgjTFVhkTdmNURfoz2L3n3SqZctqxGOXERaFwXWvKa6pKyURhxmSX5GAX4jL1KlWBzBk78/mQ0ITGDydQ+03ukp4mOx7xdnByEybZmolg7LmO2QWZ+Gu4KwLzzzIfl5aO1sstxHJox7E2P3UgCJYAcl5YwfY10ZB30227iV472KR9yEXXco+5JlY8DIyQ3dAuIaDoBJZHe0xr2VM5ykkDuqjgMxQ3eU+OyS4j8pTJWPzo4awVwnNBT7qLXibEdXWRyPW2gkt1z46TrEVs4bUUvfmlDoiU3JZh8lQejXe/FUSrZtVJI/6+etxMByzDdSibhtq0Pmw8FknCO5fz7BY6Snk0wGH+CyY8l5dYkvY0QhFmqs3hd9W5eKPvjMLzIQsEVHZzUMjPH3Xj+JtBAgt2GJo9kYNQPVok5ovGVk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VHVCaWhIUWJGZGdrOE9xN2JrYTliN2xYUUVBVFhBTGVjVUFCd2R2NXV3SGZZ?=
 =?utf-8?B?dU9kakkxaDNENGpWL2tKY0xmbDBnUUdwY1lsNVNwYmdUYmpQTzlWc0l1NUR3?=
 =?utf-8?B?eGFIZmNuMHNXQUVJbzdBV2hnaENnY0QyWXFhbzd4SnF6TFVQWmhoaksyOTJm?=
 =?utf-8?B?WHJoWWl6UjBiQndlSFhkMnVPcjRuSGR5bDNTRkFmalJ3TFZwbTdCdlJwOFNU?=
 =?utf-8?B?M1NOT0IwekNTVTFKWjhrM2pUbW9wNmVSVGJzNytMcHFjSnVKaGpBTDFkUVNL?=
 =?utf-8?B?S05zZVJrQ25JR3BuK0JTdVNyNjFLYWtNblh0NWV6TDlZaWd1dXdWZVZ5RFRu?=
 =?utf-8?B?UjVCSXVEd0R1azF1SGYrWnJpVHZhS2JHcUM1WEdHU0ExRWtPRXo1SkZveGFF?=
 =?utf-8?B?OStKZWlqckd0bEpjZk1yUjhBWFk1QlN4RWRuR3lUU2R2bFNJbGlUYlZhR3Yw?=
 =?utf-8?B?d0o2OUsxTStYOGlGMjlOa0RYNGF0UjZmUUxwS2V0SVp6NHFmMm5VajUzM0dM?=
 =?utf-8?B?dEtVTUxlYUVjNTJKZlhWVGlVckJDbTNPMXMxdk1VdHBpWWcyUnBvTnQ3T1Er?=
 =?utf-8?B?TXoyZ0tzNzgraDgvN3NEaGJHK2lLUFQ1L2pvaEJpbytmOTFONmZ2clAyNTV1?=
 =?utf-8?B?WVlDWVdJYmRCazJHcFY5Wi9aUGVWOG82N1VQSkEvcFVpOFY4a2JXU0ppVHNY?=
 =?utf-8?B?RU9IRlNkZ3ZQeWlTWGFBSm5UK1dNRnJJb29oV3F2K2ExcEVjdW4xU3hnakpZ?=
 =?utf-8?B?KzhjVy9yVjRxMEt4cG5XaWI3NFFzM0ZQencyTjN1WU9uZU9BMnJobW9vdy9U?=
 =?utf-8?B?Y2NsQS9GWU5HRGcwdGJtY0FoYzMxbmpLQUVQcW9sc2EzbjFteXlpY0pvcjZT?=
 =?utf-8?B?RkdvOVJRbk11ZjQyaEJaN2VscUMvQ0x5R1lQdi9oRGNnekZ3NlgzN0xlYzRC?=
 =?utf-8?B?bndnNVRuYTFiUml6YUNOZGxZb0xQWUZvVlN0SkJzekFKcm0yWXhCVVNMYUtx?=
 =?utf-8?B?ckFnazBXWlpsRE1Oc2YwSFhsYWN3a1g1eCtxOWdrM2Q2bmFyWHRjMndrcFJ6?=
 =?utf-8?B?VHJ2OEFhZ09NczlzQm1SMzAwMjB4a2Y5WXV5cnZMTS90bDFCa2FxdUI3MFBz?=
 =?utf-8?B?aWVRaEZNN0srV2tGTHF4VVRyTy9EMFlabnB1dVNCMWNQT3c5bVRJOUs0eTB1?=
 =?utf-8?B?am01RGVGQmYzQlA3dFNWbDM5ZEFZUFRxbGRZWDFmdmRaemVyZWZrRHUwYlRo?=
 =?utf-8?B?RVZiMklGRndYNFZnTkplbUpzT0I1RldqNDJUcmI5VWJLdlMxN094R2hJNERD?=
 =?utf-8?B?NGRCZW8yVWxxUVZCL09vRExxUlpGWWpOK01tcnR1ellHOHRzQXlhNytxZU0y?=
 =?utf-8?B?eXNvRjNUMmlMaTg5MFJRRlBzRG10QnZhU3ovU1hMS0RnZU9sM0hJZFR3dTBv?=
 =?utf-8?B?eWlZNFVIaCtjNVN1TCtjU25wM0VGYkl4RWF2akZxK2NVdHFEVTQxeHJHWkRI?=
 =?utf-8?B?ZmtkUDJMcTBqbDBYOGlSQU1VTlp2RkNVTDlCWmpDQWZRdjNUTEtTdlZTQWty?=
 =?utf-8?B?VU9EZStNa3V6WEV4YUVCckxqWkJ5ZFphQ2JSWFFoajkvK2NLaDh3ZUR6MnZZ?=
 =?utf-8?B?K2JKSDljalFtckk2QU9KVjJrM294Ti9XME5zenlsUUVKaytCZUNBZG91VERq?=
 =?utf-8?B?Z1IwSFcxWWx5L2tqcEFtTnlRb2kvUUx0YjhycjA3VzBJSko5eEhXMExwVUNy?=
 =?utf-8?B?eFltcFVRczNKdmdnTldOMmRLb3laV1ZITWZmckdqU3NoZkFRcGxJYmRTWHVu?=
 =?utf-8?B?bWVhMUJVRjMyVUhTVWp2d29SWnBqSU55aDRJTnE4d1RjdEhJTzVPejBja0E4?=
 =?utf-8?B?L0xKOGhQNlAwSitHOGNNdHVYVndRdWR1RjN6cWlBMHpmNko4VTM2c0psZ0FG?=
 =?utf-8?B?alVEWFl3cjVsemxOUjhvN0lMSnRnV0FPbktWdnNYK0tVTWdFZXh2TUJWVG84?=
 =?utf-8?B?TVdQUGJRMVQ5SlBIRmtPRkgxcnZhS3lwck1YTGo2VVg3Zzk3TUZFK2IyMXBx?=
 =?utf-8?B?Zkc5UGtnQldYM1Y3UXBCOEx6emZDMmc5K0tpSnkvdTJ5eTE0MVJ2azVpVWdp?=
 =?utf-8?B?Njg3NnhWS1c3NExLNmRvMTdaT1JxMkR5cElIYlZUcVFocTF3Rko5OHZzaVM3?=
 =?utf-8?B?MHFud3hJVCtLbVZkbU0vcWVBZ0V2TXA4aVM2TkQ0R2hSSHJ3cEVsRHRtU3FI?=
 =?utf-8?B?aGNvbnM5VWp2bys5UlRnTXJ0WWRLaWFQS3hoeTNwd2NnWkRZVy9VWUlXaUhK?=
 =?utf-8?B?bmFNcHo4ZHVXSC9hL3ZUQzU2eWN1ZHRqNEtjTVNieEhVVVZidVpvQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DgDJFQ9SqITTe8yTHAS/V3yYBFu2vxaBMr3UAuqFUBiYXtf6pR8Cc9KEwm9/7PKvs4zylP900Hwbu/KJykhTkl7/jnxvy2XFAqmYAiHtHDY6C8MZbjNCM8bWD3asqjvabdV08lG1iCWJt7OMM2Id/qJEz5EMs4X6hQJkhST/mBvurBJIAQnkaGAMW08AvvFM3n+vr72GPC8Wpx50K2vvB6GwWlNJdBuEBOsnM858xn5gvCJT6JY2F2QtSi0cgKtrcXyPFELQErGn/2h99Xur1fau1S/csecJO4Vg556eWD635m13SO8e3r0TxrT6xdEdJDAYKHPQkJnIruhvwEATFcGtPTB//K/FY8EXv62YUQfXN+uYE3sVCawEvNz/S7mQu1JdLAkdeCkFA0nh5p/Qt0rzsbZ1ueEQJd59OfPanQX8I40XqaEleY3D5tGrOsRon1lHajC5OqrBruOTLC0NR8UKh28a46994GfPj939xXBiJtszLmGselCWMu9Ho/5+hXaXTkyUOpEuXxLsdph6ZR7EDraKsGBupv/SV/cfxJN9yzZrfVNDoznDa1kzZKshOL8x6Tj8wydc23H973dXkKtpNY5jfLxguAu2rJ9KOSU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0bca25-6809-45ce-b680-08de76629b0f
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 00:45:01.6450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygN7LmrTzsyUGOSQUmA+7iA9OM/IwCuUkGUOvhK3um5BrQjhO1McaQ9EflmAxHVwyg9pPFgybRhrLyzvlQ3pRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602280004
X-Authority-Analysis: v=2.4 cv=O5U0fR9W c=1 sm=1 tr=0 ts=69a23a93 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=eg4_Aq464P5N18Z4TeUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TRiRLvjOFUrDkTSWmw3KsEIe0DWv9ke_
X-Proofpoint-ORIG-GUID: TRiRLvjOFUrDkTSWmw3KsEIe0DWv9ke_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDAwNCBTYWx0ZWRfX5nQxyW+fYSvy
 5xAXUkz5KpYK/yrtv5qEZaAWiTrMba9TtEb7R0/UwapFk33QFpmOBtzbTOVKvYI3DADU5fZFRl8
 3L9Ygr4lg253ccSCPqMUFCSO7GfprNocEcoQPlvsP1yPzzjdBAzm40f8T+ikyEcQgKg5H/t/4zG
 BBFqhxlOmeh99jzS5P4YBFzwvpCie0FnVjxPtQsjyAM+DthSwaszJPTUCr2ese0gsr5ejJNIZYE
 y80MgqxBX8fjDX7b8PFiTbfWXEJIRYptsB6CBA7QH4aEeHKxJO4aWN4oFKnW+jLQxRCXx6TXokS
 NAd4I2C0A4WuXy74/iKi1gSuynCJZQKOD/CFMyPJmzW/hNKDbAGhPwOiGf661fh9oCdOKaxn0U9
 uLJqjvL8qkRCBRRYx8wGn26h/yJopc001v4fNdaXwY10fdrS8IXnuC/1hPMKYMKXfzA7lmwh4BG
 g6biEuI2No0ZDXtRa8w==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19437-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3AFDF1BF7A2
X-Rspamd-Action: no action


On 2/27/26 11:45 AM, Jeff Layton wrote:
> On Fri, 2026-02-27 at 14:21 -0500, Chuck Lever wrote:
>> On 2/27/26 1:20 PM, Dai Ngo wrote:
>>> On 2/27/26 7:56 AM, Chuck Lever wrote:
>>>> On Thu, Feb 26, 2026, at 2:35 PM, Dai Ngo wrote:
>>>>> Track accumulated callback operations on a per-network-namespace basis
>>>>> instead of globally, ensuring proper isolation and behavior when running
>>>>> nfsd in containers.
>>>> Where are the consumers of this information? "Subsequent patch"
>>>> is an OK answer, but that should be indicated here in your patch
>>>> description.
>>> Should I first expand the output of /proc/net/rpc/nfsd and then follow
>>> up with a netlink-based implementation? Or are we trying to avoid adding
>>> anything new under /proc at this point?
>> The current kernel-wide policy, as I understand it, is that subsystems
>> are to avoid adding new items under /proc unless absolutely needed.
>>
> +1

This patch does not add any new object under /proc. It moves existing
statistic from global to per-net-namespace.

>
> Dealing with file-based interfaces for this sort of thing is a giant
> PITA for userland. Netlink is a much cleaner interface to deal with. No
> partial reads of the file, etc...

Yes, netlink is a much cleaner interface but it requires userland
utility written to retrieve and display the data in a user-friendly
format for end users or administrators. I think the output of
at /proc/net/rpc/nfsd' is still useful for developers who want a
quick look of what's going in the back channel.

>
>> I believe nfsdctl and the NFSD netlink protocol does not yet have an
>> operation to retrieve statistics. Jeff can help you put that together.
>>
> There is a rpc-status-get command,

Is this in nfsutil package?

>   but that's a bit different from what
> this is adding. You'll probably want to add a new netlink command to
> get these stats and a new set of attributes for them.
>
> Have a look at Documentation/netlink/specs/nfsd.yaml. You'll want to
> extend that and regenerate the headers and code, and then implement the
> new commands.
>
> For this, it might be best to first replicate the stats that
> /proc/net/rpc/nfsd already provides to be accessible via netlink. Then
> you could add support for the new stats you want to add. Then in
> userland, you could extend nfsstat to attempt to use netlink first and
> only fall back to /proc scraping if the command doesn't exist.

I will look into this.

Thanks,
-Dai

>
>>> Also, is there currently any user-space utility that can extract nfsd
>>> statistics via the netlink interface?
>>>
>>> -Dai
>>>
>>>>
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> ---
>>>>>    fs/nfsd/netns.h        |  5 +++
>>>>>    fs/nfsd/nfs4callback.c | 75 ++++++++++++++++++++++--------------------
>>>>>    fs/nfsd/nfsctl.c       |  5 +++
>>>>>    fs/nfsd/state.h        |  2 ++
>>>>>    4 files changed, 52 insertions(+), 35 deletions(-)
>>>>>
>>>>> v2:
>>>>>     . free memory allocated for nn->nfsd_cb_version4.counts in
>>>>>       nfsd_net_cb_stats_init() on error in nfsd_net_init().
>>>>> v3:
>>>>>     . reword commit message.
>>>>>     . fix initialization of nn->nfsd_cb_program.nrvers.
>>>>> v4:
>>>>>     . fix merge conflict in nfsd_net_exit in nfsd-testing branch.
>>>>> v5:
>>>>>     . restore commit message to the original in v1
>>>>>
>>>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>>>> index 6ad3fe5d7e12..c101bf2c24c2 100644
>>>>> --- a/fs/nfsd/netns.h
>>>>> +++ b/fs/nfsd/netns.h
>>>>> @@ -228,6 +228,11 @@ struct nfsd_net {
>>>>>        struct list_head    local_clients;
>>>>>    #endif
>>>>>        siphash_key_t        *fh_key;
>>>>> +
>>>>> +    struct rpc_version    nfsd_cb_version4;
>>>>> +    const struct rpc_version *nfsd_cb_versions[2];
>>>> I know this is copy-paste of existing code, but can you find a
>>>> proper symbolic constant to use here instead of "2" ?
>>>>
>>>>
>>>>> +    struct rpc_program    nfsd_cb_program;
>>>>> +    struct rpc_stat        nfsd_cb_stat;
>>>>>    };
>>>>>
>>>>>    /* Simple check to find out if a given net was properly initialized */
>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>> index aea8bdd2fdc4..759f24657c34 100644
>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>> @@ -1016,7 +1016,7 @@ static int nfs4_xdr_dec_cb_offload(struct
>>>>> rpc_rqst *rqstp,
>>>>>        .p_decode  = nfs4_xdr_dec_##restype,                \
>>>>>        .p_arglen  = NFS4_enc_##argtype##_sz,                \
>>>>>        .p_replen  = NFS4_dec_##restype##_sz,                \
>>>>> -    .p_statidx = NFSPROC4_CB_##call,                \
>>>>> +    .p_statidx = NFSPROC4_CLNT_##proc,                \
>>>>>        .p_name    = #proc,                        \
>>>>>    }
>>>> Previously all compound-based callbacks mapped to statidx 1
>>>> (NFSPROC4_CB_COMPOUND); now each operation gets its own counter
>>>> slot (values 0–7). This changes what stats are reported, IIUC.
>>>> So bundling it here means a bisect on a stats regression cannot
>>>> isolate when accounting changed, and reverting either change
>>>> forces reverting both.
>>>>
>>>> IMO this should be a pre-requisite commit with its own
>>>> rationale.
>>>>
>>>>
>>>>> @@ -1032,40 +1032,7 @@ static const struct rpc_procinfo
>>>>> nfs4_cb_procedures[] = {
>>>>>        PROC(CB_GETATTR,    COMPOUND,    cb_getattr,    cb_getattr),
>>>>>    };
>>>>>
>>>>> -static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
>>>>> -static const struct rpc_version nfs_cb_version4 = {
>>>>> -/*
>>>>> - * Note on the callback rpc program version number: despite language
>>>>> in rfc
>>>>> - * 5661 section 18.36.3 requiring servers to use 4 in this field, the
>>>>> - * official xdr descriptions for both 4.0 and 4.1 specify version 1,
>>>>> and
>>>>> - * in practice that appears to be what implementations use.  The
>>>>> section
>>>>> - * 18.36.3 language is expected to be fixed in an erratum.
>>>>> - */
>>>>> -    .number            = 1,
>>>>> -    .nrprocs        = ARRAY_SIZE(nfs4_cb_procedures),
>>>>> -    .procs            = nfs4_cb_procedures,
>>>>> -    .counts            = nfs4_cb_counts,
>>>>> -};
>>>>> -
>>>>> -static const struct rpc_version *nfs_cb_version[2] = {
>>>>> -    [1] = &nfs_cb_version4,
>>>>> -};
>>>>> -
>>>>> -static const struct rpc_program cb_program;
>>>>> -
>>>>> -static struct rpc_stat cb_stats = {
>>>>> -    .program        = &cb_program
>>>>> -};
>>>>> -
>>>>>    #define NFS4_CALLBACK 0x40000000
>>>>> -static const struct rpc_program cb_program = {
>>>>> -    .name            = "nfs4_cb",
>>>>> -    .number            = NFS4_CALLBACK,
>>>>> -    .nrvers            = ARRAY_SIZE(nfs_cb_version),
>>>>> -    .version        = nfs_cb_version,
>>>>> -    .stats            = &cb_stats,
>>>>> -    .pipe_dir_name        = "nfsd4_cb",
>>>>> -};
>>>>>
>>>>>    static int max_cb_time(struct net *net)
>>>>>    {
>>>>> @@ -1152,14 +1119,15 @@ static int setup_callback_client(struct
>>>>> nfs4_client *clp, struct nfs4_cb_conn *c
>>>>>            .addrsize    = conn->cb_addrlen,
>>>>>            .saddress    = (struct sockaddr *) &conn->cb_saddr,
>>>>>            .timeout    = &timeparms,
>>>>> -        .program    = &cb_program,
>>>>>            .version    = 1,
>>>>>            .flags        = (RPC_CLNT_CREATE_NOPING |
>>>>> RPC_CLNT_CREATE_QUIET),
>>>>>            .cred        = current_cred(),
>>>>>        };
>>>>>        struct rpc_clnt *client;
>>>>>        const struct cred *cred;
>>>>> +    struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>>>> Nit: Reverse Christmas tree ordering -- this new declaration
>>>> belongs close to the top.
>>>>
>>>>
>>>>> +    args.program = &nn->nfsd_cb_program;
>>>>>        if (clp->cl_minorversion == 0) {
>>>>>            if (!clp->cl_cred.cr_principal &&
>>>>>                (clp->cl_cred.cr_flavor >= RPC_AUTH_GSS_KRB5)) {
>>>>> @@ -1786,3 +1754,40 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
>>>>>            nfsd41_cb_inflight_end(clp);
>>>>>        return queued;
>>>>>    }
>>>>> +
>>>>> +void nfsd_net_cb_stats_shutdown(struct nfsd_net *nn)
>>>>> +{
>>>>> +    kfree(nn->nfsd_cb_version4.counts);
>>>>> +}
>>>>> +
>>>>> +int nfsd_net_cb_stats_init(struct nfsd_net *nn)
>>>>> +{
>>>>> +    nn->nfsd_cb_version4.counts = kzalloc_objs(unsigned int,
>>>>> +            ARRAY_SIZE(nfs4_cb_procedures), GFP_KERNEL);
>>>>> +    if (!nn->nfsd_cb_version4.counts)
>>>>> +        return -ENOMEM;
>>>>> +    /*
>>>>> +     * Note on the callback rpc program version number: despite
>>>>> language
>>>>> +     * in rfc 5661 section 18.36.3 requiring servers to use 4 in this
>>>>> +     * field, the official xdr descriptions for both 4.0 and 4.1
>>>>> specify
>>>>> +     * version 1, and in practice that appears to be what
>>>>> implementations
>>>>> +     * use. The section 18.36.3 language is expected to be fixed in an
>>>>> +     * erratum.
>>>>> +     */
>>>>> +    nn->nfsd_cb_version4.number = 1;
>>>>> +
>>>>> +    nn->nfsd_cb_version4.nrprocs = ARRAY_SIZE(nfs4_cb_procedures);
>>>>> +    nn->nfsd_cb_version4.procs = nfs4_cb_procedures;
>>>>> +    nn->nfsd_cb_versions[1] = &nn->nfsd_cb_version4;
>>>> Could you add a comment explaining that slot 0 is intentionally
>>>> NULL and slot 1 corresponds to the CB protocol version number?
>>>> The original designated-initializer syntax made this self-
>>>> evident; the replacement imperative assignment here does not.
>>>>
>>>>
>>>>> +
>>>>> +    memset(&nn->nfsd_cb_stat, 0, sizeof(nn->nfsd_cb_stat));
>>>>> +    nn->nfsd_cb_program.name = "nfs4_cb";
>>>>> +    nn->nfsd_cb_program.number = NFS4_CALLBACK;
>>>>> +    nn->nfsd_cb_program.nrvers = ARRAY_SIZE(nn->nfsd_cb_versions);
>>>>> +    nn->nfsd_cb_program.version = &nn->nfsd_cb_versions[0];
>>>>> +    nn->nfsd_cb_program.pipe_dir_name = "nfsd4_cb";
>>>>> +    nn->nfsd_cb_program.stats = &nn->nfsd_cb_stat;
>>>>> +    nn->nfsd_cb_stat.program = &nn->nfsd_cb_program;
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>> New non-static functions should get kernel-doc comments.
>>>>
>>>>
>>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>>> index 032ab44feb70..5daa647ef0fa 100644
>>>>> --- a/fs/nfsd/nfsctl.c
>>>>> +++ b/fs/nfsd/nfsctl.c
>>>>> @@ -2216,6 +2216,9 @@ static __net_init int nfsd_net_init(struct net
>>>>> *net)
>>>>>        int retval;
>>>>>        int i;
>>>>>
>>>>> +    retval = nfsd_net_cb_stats_init(nn);
>>>>> +    if (retval)
>>>>> +        return retval;
>>>> Does this build if CONFIG_NFSD_V4 is not enabled?
>>>>
>>>>
>>>>>        retval = nfsd_export_init(net);
>>>>>        if (retval)
>>>>>            goto out_export_error;
>>>>> @@ -2256,6 +2259,7 @@ static __net_init int nfsd_net_init(struct net
>>>>> *net)
>>>>>    out_idmap_error:
>>>>>        nfsd_export_shutdown(net);
>>>>>    out_export_error:
>>>>> +    nfsd_net_cb_stats_shutdown(nn);
>>>>>        return retval;
>>>>>    }
>>>>>
>>>>> @@ -2286,6 +2290,7 @@ static __net_exit void nfsd_net_exit(struct net
>>>>> *net)
>>>>>        struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>>>>
>>>>>        kfree_sensitive(nn->fh_key);
>>>>> +    nfsd_net_cb_stats_shutdown(nn);
>>>>>        nfsd_proc_stat_shutdown(net);
>>>>>        percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>>>>>        nfsd_idmap_shutdown(net);
>>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>>> index 9b05462da4cc..490193c1877d 100644
>>>>> --- a/fs/nfsd/state.h
>>>>> +++ b/fs/nfsd/state.h
>>>>> @@ -895,4 +895,6 @@ struct nfsd4_get_dir_delegation;
>>>>>    struct nfs4_delegation *nfsd_get_dir_deleg(struct
>>>>> nfsd4_compound_state *cstate,
>>>>>                            struct nfsd4_get_dir_delegation *gdd,
>>>>>                            struct nfsd_file *nf);
>>>>> +int nfsd_net_cb_stats_init(struct nfsd_net *nn);
>>>>> +void nfsd_net_cb_stats_shutdown(struct nfsd_net *nn);
>>>>>    #endif   /* NFSD4_STATE_H */
>>>>> -- 
>>>>> 2.47.3

