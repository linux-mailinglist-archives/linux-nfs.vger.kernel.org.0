Return-Path: <linux-nfs+bounces-12497-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1E5ADBB31
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 22:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD4C175F07
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 20:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10236136349;
	Mon, 16 Jun 2025 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ATwDIMyb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dxd6j5Vj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94012BEFE2;
	Mon, 16 Jun 2025 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105836; cv=fail; b=KMtlklvBjS8THlCFgrCh1VBaY8elJaTFAJX86VU6Y2D1/tAOtEOfzPowzbuLEGVQnvr91XtP4JRmwuChkDgo6+ykQSo0nX/xKIjq/PFNlxzYCZ+uXkBc3nyLnxoWERWk7ozoKl1/PSQTzESfu5zhI/lb/58bURGTQ1Pot/Vme2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105836; c=relaxed/simple;
	bh=7BL+XAWf5tvfgvc2LyWSErVYOn/oCAen3hzi2TGj+5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E/4oij5J/MO7r//wwCNAULmBISMPlrPuKWruTWcI8vREwOz9YhC5vRMfyOd2+TCfnTN2km9D4rclQkRe+36pCkCdmxUt4FmVX/n8hZUb0eeLDoskBq+Drr1vZmPlww25HVdRcVbLIlYUyJ4Dh+zBUcw1kRSLX5ooJERC5ip6mig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ATwDIMyb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dxd6j5Vj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHuSxq015739;
	Mon, 16 Jun 2025 20:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AkzyhEikEAlDelWBKjjMUT63/OPbps91UHs72H1xfqk=; b=
	ATwDIMybmFaF6LB11AG4W3KXp3L2fjaJ/A2rLg3XcR5JMSAQRapSN1NiTqgrGarU
	rd0uzf/9ZKHrK+xmezj5ojGoEVRMSs0iBGxgxuRWvQStIZX4noSxH64DjfHmSKhs
	XJ4aBeqEGYs30UuiSWnV7dbfOgcC6paoHH5IL7PuXf5MaABmbD7C81NypWVp054e
	fqdKBI1Cbu787nSd1SrouYBxujBzB9++7F0I2bvSs+5Ig/+2ISwrjq+kJx1tLoUd
	EXCjoididNJo9H0N+E/SNE9WLPIWVbBT4frhcc5KCd+AmbKPD6mpLKGnWs1vO8a/
	E3YKr5tNexS6k3fa8aaYow==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv53tb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 20:30:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GJH26x031734;
	Mon, 16 Jun 2025 20:30:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh85bqy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 20:30:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRGd/sXKKNojzGFZTJz2JmA3VS2jF7auBX2ACZaKR4GtOAFmIU2u1uX1zd4agveXAkLJ10dPgidgY8oWIl5ho8lHxFBwo0gp8tCQpUzWkv5y8dPGt9Ton7rTBUt8s7wNST989HIyxoWlFO231cqeRYjYl43h6XT2kfG+uxzN1dtaWGPtpQ+GfCBH1cXyYgAENkOQGaQx/jwkYxcKOfUMDKDLIWodI7d/m+2zim1HZSYPiHU9cuJsdtQAzoLea7kJTjPh3P0KRxhhvHzHrQxCkuu+gA2kP6OKa9xy0UgW7EzPgjtvPcfcLCQ8T5SjT/FBIcBL+NTVerjrMULEYlh95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkzyhEikEAlDelWBKjjMUT63/OPbps91UHs72H1xfqk=;
 b=YxYP5YBTLBb6gaM3wa6K3nx3TwYe7rCyep8ZtgDk2MLKmDC9Z6MfsharNxs7Hjwv9zV0Jr5dwzKf6wdhtk8NkglPbP2iifY+/yRZBQL60vYqXVX0QZNaUQwQ9r6R5hWIVJZwh7kfzDiiQVGIyivu2VrDy/9YHYa3Zlt+wy9bVZ3PCGXuseVygqVFKgzN1ovKl6q6duCc9bNEoDxmRbKkstHthPR9lvVaKdtiUNc4eb3HCIvGq2VglJmndx3Nibys5BA4YQN6zaYB0wU+qgwumouVVKYgNFQHOrtT0PS9yBXImDXjFwl1zQREWRPWLt2kXRNKuohQ55BbKY11s31jdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkzyhEikEAlDelWBKjjMUT63/OPbps91UHs72H1xfqk=;
 b=dxd6j5VjccN3558HH8JrbHVLQINz3IB4iVcYqdiu5Rfjmzd0ZhRNWGB6qgzDwU9LRQtaqe8Rh7TssxA9sxCNilHNywEwL51itW+YJ5cxbg7IRGZhRkjMPUNjEXAXTJkB6SrpKSXyw6VvGEJRS1iRWmqHnoXUkH8n3ACoPXggYrQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5537.namprd10.prod.outlook.com (2603:10b6:303:134::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 20:30:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 20:30:12 +0000
Message-ID: <4bb48a2d-5599-4728-b909-bbbaba2b33ee@oracle.com>
Date: Mon, 16 Jun 2025 16:30:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] NFSD: Avoid multiple
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <aEoKCuQ1YDs2Ivn0@kspp>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aEoKCuQ1YDs2Ivn0@kspp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5537:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c508932-ff0a-4df4-e98b-08ddad14980f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VEhncGcwTEYxNkdoY2t6czh3T1FEbjZaNHhPS2Q5UjlVT0ZTenBGN01EUXdr?=
 =?utf-8?B?UEc4dWZmMWtWbndTUnB3WmhNdnBIVVpEM21FTit3OXVzMHVuSE1UY0h6RjVo?=
 =?utf-8?B?VERTcDRqNk00T0ViK0VxT0hrY2RDdWhwWXhSb2pqTDZXNkF5MkhlY2ZxbWFB?=
 =?utf-8?B?WXVBQnFzaXgyRTJrLzRxcEgxdjFSR0YvSjVvN202QXBuQzN3bWhNc3Q3RHVx?=
 =?utf-8?B?cW1DbEQzSVZRYXhrQjZta0tWZHluMjdEQ1lBclRsb21yZC9oQUt2Q2RQSVhP?=
 =?utf-8?B?MURjREJFa2F4SkYxSVFQc0JFTWhobHN1YUtlaHpHYWpRZm5lVUtJQWtGYUdx?=
 =?utf-8?B?NE9wZVlDV2ZGeWVaQTlNdmd4YWRJK0pqeHM5QkV6NXpzOTZOSytNMWRpU2xy?=
 =?utf-8?B?Y0tZR0I4OXdOcVVLeksxcTJyeDNDQlhsNTEvcXdvVGlXajFCL2pNRHlRZzRh?=
 =?utf-8?B?ZEN2YVBEa0xCRjdkaWlPZ1FTM1VTYVAwbnJHbVZNU0w1eW9VZThQVXFFVEJy?=
 =?utf-8?B?cTNNUlFjajd5M25oVVlKTmJoOThVZDZhNThKMGpsWm1yeTZub3NQSGJEdVlD?=
 =?utf-8?B?VmFsNUlhSE10eUVKbE0yajF1dzAvTnBNbWYvVmp4MHNaK1Q5QW1tOEtUcEZs?=
 =?utf-8?B?K2xKenJUaHJCVUFwd3NtMU1EYkdsak9iN3NLOUN3eW04ZVlra2YvcW5yZitl?=
 =?utf-8?B?b0F1bEJlOWYycUt2ZUxPL3JySWdVUjM0anZDYmVxUHZrSU8xQk5VMURaMmN2?=
 =?utf-8?B?SVhRNGt1NlZhMmtXSnhJNVUyQWVBYWFubEFLK1VKNWJySncrYXNsZUs1dzZW?=
 =?utf-8?B?K2VidmJ0L2hxNFZjb2t4aXg3Sm8zc2tQcFJvS2h3L1I2cnNaRFV6WjY3Zm1t?=
 =?utf-8?B?UWdINDJOb2NrdUhmV0tEbHpQcHFMdmxKMDRsRmVDakM4NEU1VE9oNWNPTU1L?=
 =?utf-8?B?eHJ6VHY3SmEwVjdlaG1UR2ptOVJjeFg5MEV1b3lHNGRKZDZVZkhtQ292ZHFB?=
 =?utf-8?B?Qno5VURYT1MwL0EybXN2TFRNWTRhZmplRlYzdVFXd3lJRjFLVGNkelBhNUJT?=
 =?utf-8?B?QUdLUG80aVVMY09lb1h6d1dpTCtyZmQzYVdacDVCMVM4MHJ1Vk1iUVNrdG05?=
 =?utf-8?B?eEtVamxmRkZTNDdQekQ3bXhmYk1nMXRjOTV0cHNDTDZUcGVDNlM3Y0ViQUYr?=
 =?utf-8?B?elhRbEVpNnBQSG9SZlpRN2JYWnEybHh3bm5waktoWXp2QUtTV1NzRUJxcTlC?=
 =?utf-8?B?bUkxR21NbkRVa3pUOUw0Z2w1NG5BM0xINm9IWWhKVWhqQXdoUG1EVnlrQlc1?=
 =?utf-8?B?am9lSnRjd05zOGJuLzJ0YUdLdDN0WDg0WkNaQVFWc1ZDQmZNckJsSmFMM1hZ?=
 =?utf-8?B?Ums5dFEzR1hxOE9DRFZBZm5kRHVtME1NVC8vU1JDdEljRFdNQ3pzYXRoVE5U?=
 =?utf-8?B?NndnQ3Aza3NVWDdMY3FDOEs0QjlYZW9JWllNeU0rVm1zVmFibS93b3JCV1lZ?=
 =?utf-8?B?MFlCNGNxZmI0eGl3WmtNM21BUHhyelp4TFIrVTJ3OU5UTngrOU5OY3FqYWpa?=
 =?utf-8?B?MkJNK0YvSXIwVlRhb0llNnhVWm91WkpWSEtna1FBYldEUjNpRktZMTNKOENM?=
 =?utf-8?B?N2dGZ2ZXYmhnYU5KOTQvUGpSdm5BNm15MllLTDB5emczWEFFYUxKUzVCQzIr?=
 =?utf-8?B?RUpIcEU0RkVGbllMZWMwRXpqYVJoVDc3NWoyejJsdjVPdGp5U2JCYTBUaDZI?=
 =?utf-8?B?bFFiQ083T25QRHFRMzVVcXcwaTU3c0FYK3ZRYVRzNVlmWm1lS3ZEU1cwRVhS?=
 =?utf-8?B?M1pGZ2xuazR2SnhLalZPSjBFTDVGd1orSDB0QVorNGx1TjZiKzkvS0FIb20w?=
 =?utf-8?B?UXljRXYvNTRsOUgwcVgyVmxOaDduMW5YZDVBLzZCUGVxOEJGS1YxUThTa0lT?=
 =?utf-8?Q?nFUFOw1ordM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VFkxSmV0SW43ZWRsbVUyd1c0SlRaaUZZMHlTYk4yVmNFdTZkaEswYmZ2YStL?=
 =?utf-8?B?OEhrNDZpMzBLNHBYdlNza2FCbk5nRHgvOThKNVRkbWd6cDlBTkJQRUcwaXNB?=
 =?utf-8?B?eFRnTVZtSitLbUFVSFlSbEtUNnJSYUxOekNuNjhzK2E0K0FBaGJaZGd3eU9E?=
 =?utf-8?B?dWEvU0tkUlZjVlp6aWhjVTRCZWVEdTFsT1lqZTdUY203OFQrNjUrYWN6Mjhw?=
 =?utf-8?B?VW9UY3dWWmdWQUp1cUMxVWVpTllHVDZYeGJrYTYrSFZtQ2tjZTE5NW5sSStF?=
 =?utf-8?B?TjhaSEpvZHp2MTVaeGsxd1VseU1qUXRRRkR4K2t6RU1tVnVDT1RqemU2NHV2?=
 =?utf-8?B?Nm5qdkt4SjFPb1VYSUxFYmxHeVVOQllLZWExQmhJb3d6alN6MFFub2lncmNN?=
 =?utf-8?B?ajFWMi91T0xpNDNJN0lGbFY5NVVrYVBHT2t3K1ROa3RQZm5DWEVHS1dtR2pa?=
 =?utf-8?B?RUJUNWQvRmVRUDRGa0lMTGM0V0pKWE9NdDZhM0V6Mlk1OXJlRDZXdkVJclhW?=
 =?utf-8?B?dHN0V09LcWRxRHViOUhJVm1mdE9YZDVhcDM2eEhGcmhzV1VKQkJ1R2RENmFi?=
 =?utf-8?B?MElwUUhmeDUwZzNFRlhhY0pCeTRjcjBoUk9CREZCSDZRN2tnVGgvUkhBUjcr?=
 =?utf-8?B?WEx5QllZNnVxdFlNUEJpbjVDUkZpa2Y5N0ttZk9NLzRSd1ROMkxvdW1NL25j?=
 =?utf-8?B?bkJRSG1xMlZvaG91aEgwSUV3RnlFMVYvTTlNSCtlc2NHbDdjYmppeXl0NUps?=
 =?utf-8?B?OUhjTkZQRnRLb3NKUFNtN25hV3hNZU9VYXNIbTRrSERrblJFdDFYV3d0M2lB?=
 =?utf-8?B?bDVJYVA2TThOY255VTNxelF0SWQzdkM1aFhkL1B5eUN4WVZvck9oNHZwVTFQ?=
 =?utf-8?B?ZzlkUlg3dnlEaWkxSGdCT3ZxSFFFNDV3MCtmNFl1WVhHUEpNbkNBSGtoSkVy?=
 =?utf-8?B?SFg5SGduQWkzYlRGWEhkQTlFNGd6SU5JZFdmdVc0WVhOREI3cDh2QkxEWkNj?=
 =?utf-8?B?blYzRWJ4a0t6TzhFQzNPajYwNWdxN2xnQ2R2bmhzK3p1WnZCVW1OS2JKbnJt?=
 =?utf-8?B?QzFHNlljOEUySmxBU2crUU41V1VscVVqcXJjYlhGZmZKT0hFQ1pUMHhVMlNo?=
 =?utf-8?B?dlBvUDI4S3ZwaHZpTlliK0tGZi8vbzN1bnl4SlczeWhKZk4wRFZCQUZBZDFt?=
 =?utf-8?B?eXUrVmdmVk5KRDFhL1dPQm9lVVplS0xGVWRsTlFvbEJMeGsvWFBnMGlvUVlV?=
 =?utf-8?B?eUZCejZyRUlaUUs3cC9odnlHU3p5VDN1aHRpSkFOOW82WXNXK3RGUTlqV09i?=
 =?utf-8?B?RnBXMFFGbVViQURVZFk0b3U4UUE1YmFveVpWUFk3V1ZzTXM5VjcwNXl3TThG?=
 =?utf-8?B?ZFQrVGtIdHJFdUk5dXhlRmhHY0VycTVIREZNcXQ5bm5BdzE3dWdYbWtrMjR0?=
 =?utf-8?B?YWk0M1ozZ0RPZUd0c0ZFNEtOVXlkTHF1cjBKcXczWXl2L1hMQ0FMUXZ6UjNT?=
 =?utf-8?B?ak9XV3hMbENTNDZucXNUOExpcUVxZ1hzZ2RXTVM0cHd0RmRJSml0QUFwNVRw?=
 =?utf-8?B?YXE4WjNFL3RNb2JLbThZQUV2azFNVmlVeFZzRXJ5enlxWlQ0cUQzV0NPbEtP?=
 =?utf-8?B?T2NTTEtVMVIwQk1pTFFNUGYwN2k2RGZ2VzVQYVJqalRGZ09DVk5mZGRQK054?=
 =?utf-8?B?bVdpd3pUSE5LQkRNbldpR0dRSTdLekcvK3p0ODNOcE1pNmFqTERDNTltS3g5?=
 =?utf-8?B?ZDZidHpZYlpaN3lxOGNkNTRRdlV0cVBGUlZxY25oeldlMFQ3eWhkQ2gvM0JR?=
 =?utf-8?B?dkZQcmtTaFBIVFJzQU1LQ3d6MWtBRzlnOUVKUUdpeFRoTjJ1N2xNRWRkV2N6?=
 =?utf-8?B?NmRUWnIyK2N4dWFBT2VTcjh2ZE9vVTJjNTFBQ09CV0lSOVkzb2RjaVF2Q0Na?=
 =?utf-8?B?aGcwK1BkVGhyNjhlLzlzRk8wYWp4OWpvckpXM1ltN0JnVnRXUXYxc1J2Tmhm?=
 =?utf-8?B?MnVtOEEvcngrckltbmFicW14YW1iT3U2bDhpWUJZWnZMWUphWUVDc2pZTkx0?=
 =?utf-8?B?YW5lV3lOUmpOd1g5bjBuR0p3d2M2NVgycTgrTEdLVmJ6SERPdlNiN0pwcWJY?=
 =?utf-8?Q?K0giUe2+8otl9kDSyfRj95XTj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cnrUMgUQ0KpuFR4Bz7YuwQwue+/Pch+aMfUYQp7Fmomx4es+erWzZcQOGdeE4zOJ2wX/iHmKF+N1FOD3lL9P4FX4JSKk76RbbOLzGwq7+rZqlEtMKg2ftX4Y2eQTgxfr/73mVl2DIaP6clTrjfBgLaHhMP/Mqx7IWNSFadJM3MclILezkrWlBX+IjdtbJZ2DUBC3VpZqhQxEFi96wvo2vHPgYByLznf5ITJoCoOHAYMuIUghYeST1jEZWzot9wQYvOIUeD46JVzuZY4AniHME+pLR3yiaoidH8UFwcsgVXV6EH5BOkPB99PBD0nxz1RtC2Hh9jb4u6npb6FBMfj4Z4OAaJKEixnHtDF24fcaV9W2iJ4kCA2g1QtjuyNM2jM5RiN1c1Wb6+OiGLWOCXHzm8mowXZRmCZUXxtqz+CV9SmQyB48Z1vQUqWzQkzOZ3JfX5UeBDl3+v4LTcUZWDaY9/lLVUxWgBoTu5AZtE9z/w7xxnjKOS1kIHP9pzkarlAptaTs+9S8u2Pjyz5ET+YvuOQc/bFSMFM01FokVBNzzQMzqAKNf9CMRyJj2xomVSxGi2b632elxnsKd5ScI/T4LzL+iCpQ9ZlNm0k0xT2u3HU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c508932-ff0a-4df4-e98b-08ddad14980f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 20:30:12.0855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ek2eey/5TN873wfoU0+X5z5VqMMviO+0389NSkHEbhb062kAsSffxOBxVWIiVtSq98lun6wOBx68/e8XlJlVgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506160142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDE0MiBTYWx0ZWRfX5tHTCJJTWpE2 TA+35hE7aN6eF+lHBScMjERDCMjEs349n8cuU0wXAud/LZOaZUL5oSwQwPEwy9mLSpamA6+NG5q YYW6IJkIQK5DUidNP1AE21Y5PMMeBBwkc5Ty9RJdXZKuL2BdZD9KNfUigM0kCviSHeY0m6/alFQ
 sgV4MJ+TvqZpFA1eivalLPDLXyeiGZrsD9GPmH4/CHR/zj6SzQK+xY3lYFbn1YpFwjIF6lmzF04 LPnWyzYf+zNvJsGaW+3lkISQ8zfMltB9XvwHVIDW+EnzKknaebWkugnzc/CitwlzDvsirX8Ild8 u45EQTgK+gFPGXsQ72nmpcaqUpSf7JBno0rH0zzxRSQu+7Yt2JmqCAI/coLHeGENvJDui/UoLT7
 DJTSd07X485rgD3MGsrRhLXaZHOv7UiSAJ1bQA3E5YyGrkoK+oop/Ayt6dWxUzoXHLbsMotV
X-Proofpoint-GUID: PAP4Uu-_382Ta3_hQAT9jq-tKpOmQDQy
X-Proofpoint-ORIG-GUID: PAP4Uu-_382Ta3_hQAT9jq-tKpOmQDQy
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=68507ed8 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=LJKptfLA1XUEDOV_4G0A:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22

On 6/11/25 6:58 PM, Gustavo A. R. Silva wrote:
> Update `struct knfsd_fh` to use indices into the `fh_raw` array,
> allowing removal of the flexible-array member `fh_fsid[]`. Refactor
> related code accordingly.
> 
> With this changes, fix many instances of the following type of
> warnings:
> 
> fs/nfsd/nfsfh.h:79:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/state.h:763:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/state.h:669:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/state.h:549:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/xdr4.h:705:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/xdr4.h:678:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Co-developed-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Use indices into `fh_raw`. (Christoph)
>  - Remove union and flexible-array member `fh_fsid`. (Christoph)
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/aBp37ZXBJM09yAXp@kspp/

I prefer Neil's solution to address just the "flexible array member"
warnings.

The intent in struct knfsd_fh was that fh_fsid was to fill up the rest
of that arm of the union; it is not flexible in size.

Would it be enough to replace:

	u32	fh_fsid[];	/* flexible-array member */

with:

	u32	fh_fsid[NFS4_FHSIZE / 4 - 1];

or:

	u32	fh_fsid[0];

?


I agree that packing the u8 fields in a struct/union combination and
then putting the octets directly onto the wire, as is currently done, is
asking for trouble. However, replacing the union, as Christoph
suggested, is a clean-up that ought to be done over time in multiple
patches so that it is done mechanically (perhaps via cocchinelle) and
can be bisected over if needed.

I might even want to see helper functions to access those fields, rather
than poking them by symbolic offset into an array. Using accessor
functions is definitely appropriate for the nfs4layouts.c consumer of
knfsd_fh.


>  fs/nfsd/export.c      |  2 +-
>  fs/nfsd/export.h      |  2 +-
>  fs/nfsd/nfs4layouts.c | 10 ++++----
>  fs/nfsd/nfsfh.c       | 58 +++++++++++++++++++++++--------------------
>  fs/nfsd/nfsfh.h       | 30 +++++++++++-----------
>  5 files changed, 52 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 88ae410b4113..654d54a7148f 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1231,7 +1231,7 @@ rqst_exp_get_by_name(struct svc_rqst *rqstp, struct path *path)
>  struct svc_export *
>  rqst_exp_find(struct cache_req *reqp, struct net *net,
>  	      struct auth_domain *cl, struct auth_domain *gsscl,
> -	      int fsid_type, u32 *fsidv)
> +	      int fsid_type, void *fsidv)
>  {
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  	struct svc_export *gssexp, *exp = ERR_PTR(-ENOENT);
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index 4d92b99c1ffd..9b2719d8a3e2 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -131,6 +131,6 @@ static inline struct svc_export *exp_get(struct svc_export *exp)
>  }
>  struct svc_export *rqst_exp_find(struct cache_req *reqp, struct net *net,
>  				 struct auth_domain *cl, struct auth_domain *gsscl,
> -				 int fsid_type, u32 *fsidv);
> +				 int fsid_type, void *fsidv);
>  
>  #endif /* NFSD_EXPORT_H */
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 290271ac4245..6dcd2c9ec15b 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -56,7 +56,7 @@ static void
>  nfsd4_alloc_devid_map(const struct svc_fh *fhp)
>  {
>  	const struct knfsd_fh *fh = &fhp->fh_handle;
> -	size_t fsid_len = key_len(fh->fh_fsid_type);
> +	size_t fsid_len = key_len(fh->fh_raw[FH_FSID_TYPE]);
>  	struct nfsd4_deviceid_map *map, *old;
>  	int i;
>  
> @@ -64,8 +64,8 @@ nfsd4_alloc_devid_map(const struct svc_fh *fhp)
>  	if (!map)
>  		return;
>  
> -	map->fsid_type = fh->fh_fsid_type;
> -	memcpy(&map->fsid, fh->fh_fsid, fsid_len);
> +	map->fsid_type = fh->fh_raw[FH_FSID_TYPE];
> +	memcpy(&map->fsid, fh->fh_raw + FH_FSID, fsid_len);
>  
>  	spin_lock(&nfsd_devid_lock);
>  	if (fhp->fh_export->ex_devid_map)
> @@ -73,9 +73,9 @@ nfsd4_alloc_devid_map(const struct svc_fh *fhp)
>  
>  	for (i = 0; i < DEVID_HASH_SIZE; i++) {
>  		list_for_each_entry(old, &nfsd_devid_hash[i], hash) {
> -			if (old->fsid_type != fh->fh_fsid_type)
> +			if (old->fsid_type != map->fsid_type)
>  				continue;
> -			if (memcmp(old->fsid, fh->fh_fsid,
> +			if (memcmp(old->fsid, map->fsid,
>  					key_len(old->fsid_type)))
>  				continue;
>  
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index aef474f1b84b..01ff91a28fb6 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -161,37 +161,40 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
>  	if (fh->fh_size == 0)
>  		return nfserr_nofilehandle;
>  
> -	if (fh->fh_version != 1)
> +	if (fh->fh_raw[FH_VERSION] != 1)
>  		return error;
>  
>  	if (--data_left < 0)
>  		return error;
> -	if (fh->fh_auth_type != 0)
> +	if (fh->fh_raw[FH_AUTH_TYPE] != 0)
>  		return error;
> -	len = key_len(fh->fh_fsid_type) / 4;
> +	len = key_len(fh->fh_raw[FH_FSID_TYPE]) / 4;
>  	if (len == 0)
>  		return error;
> -	if (fh->fh_fsid_type == FSID_MAJOR_MINOR) {
> +	if (fh->fh_raw[FH_FSID_TYPE] == FSID_MAJOR_MINOR) {
>  		/* deprecated, convert to type 3 */
> +		u32 *fsidv = (u32 *)(fh->fh_raw + FH_FSID);
> +
>  		len = key_len(FSID_ENCODE_DEV)/4;
> -		fh->fh_fsid_type = FSID_ENCODE_DEV;
> +		fh->fh_raw[FH_FSID_TYPE] = FSID_ENCODE_DEV;
>  		/*
>  		 * struct knfsd_fh uses host-endian fields, which are
>  		 * sometimes used to hold net-endian values. This
>  		 * confuses sparse, so we must use __force here to
>  		 * keep it from complaining.
>  		 */
> -		fh->fh_fsid[0] = new_encode_dev(MKDEV(ntohl((__force __be32)fh->fh_fsid[0]),
> -						      ntohl((__force __be32)fh->fh_fsid[1])));
> -		fh->fh_fsid[1] = fh->fh_fsid[2];
> +		fsidv[0] = new_encode_dev(MKDEV(
> +			ntohl((__force __be32)fsidv[0]),
> +			ntohl((__force __be32)fsidv[1])));
> +		fsidv[1] = fsidv[2];
>  	}
>  	data_left -= len;
>  	if (data_left < 0)
>  		return error;
>  	exp = rqst_exp_find(rqstp ? &rqstp->rq_chandle : NULL,
>  			    net, client, gssclient,
> -			    fh->fh_fsid_type, fh->fh_fsid);
> -	fid = (struct fid *)(fh->fh_fsid + len);
> +			    fh->fh_raw[FH_FSID_TYPE], fh->fh_raw + FH_FSID);
> +	fid = (struct fid *)(fh->fh_raw + FH_FSID + len);
>  
>  	error = nfserr_stale;
>  	if (IS_ERR(exp)) {
> @@ -233,7 +236,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
>  	 */
>  	error = nfserr_badhandle;
>  
> -	fileid_type = fh->fh_fileid_type;
> +	fileid_type = fh->fh_raw[FH_FILEID_TYPE];
>  
>  	if (fileid_type == FILEID_ROOT)
>  		dentry = dget(exp->ex_path.dentry);
> @@ -463,18 +466,19 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
>  {
>  	if (dentry != exp->ex_path.dentry) {
>  		struct fid *fid = (struct fid *)
> -			(fhp->fh_handle.fh_fsid + fhp->fh_handle.fh_size/4 - 1);
> +			(fhp->fh_handle.fh_raw + FH_FSID +
> +			 fhp->fh_handle.fh_size - 1);
>  		int maxsize = (fhp->fh_maxsize - fhp->fh_handle.fh_size)/4;
>  		int fh_flags = (exp->ex_flags & NFSEXP_NOSUBTREECHECK) ? 0 :
>  				EXPORT_FH_CONNECTABLE;
>  		int fileid_type =
>  			exportfs_encode_fh(dentry, fid, &maxsize, fh_flags);
>  
> -		fhp->fh_handle.fh_fileid_type =
> +		fhp->fh_handle.fh_raw[FH_FILEID_TYPE] =
>  			fileid_type > 0 ? fileid_type : FILEID_INVALID;
>  		fhp->fh_handle.fh_size += maxsize * 4;
>  	} else {
> -		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
> +		fhp->fh_handle.fh_raw[FH_FILEID_TYPE] = FILEID_ROOT;
>  	}
>  }
>  
> @@ -520,8 +524,8 @@ static void set_version_and_fsid_type(struct svc_fh *fhp, struct svc_export *exp
>  retry:
>  	version = 1;
>  	if (ref_fh && ref_fh->fh_export == exp) {
> -		version = ref_fh->fh_handle.fh_version;
> -		fsid_type = ref_fh->fh_handle.fh_fsid_type;
> +		version = ref_fh->fh_handle.fh_raw[FH_VERSION];
> +		fsid_type = ref_fh->fh_handle.fh_raw[FH_FSID_TYPE];
>  
>  		ref_fh = NULL;
>  
> @@ -562,9 +566,9 @@ static void set_version_and_fsid_type(struct svc_fh *fhp, struct svc_export *exp
>  		fsid_type = FSID_ENCODE_DEV;
>  	else
>  		fsid_type = FSID_DEV;
> -	fhp->fh_handle.fh_version = version;
> +	fhp->fh_handle.fh_raw[FH_VERSION] = version;
>  	if (version)
> -		fhp->fh_handle.fh_fsid_type = fsid_type;
> +		fhp->fh_handle.fh_raw[FH_FSID_TYPE] = fsid_type;
>  }
>  
>  __be32
> @@ -610,18 +614,18 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
>  	fhp->fh_export = exp_get(exp);
>  
>  	fhp->fh_handle.fh_size =
> -		key_len(fhp->fh_handle.fh_fsid_type) + 4;
> -	fhp->fh_handle.fh_auth_type = 0;
> +		key_len(fhp->fh_handle.fh_raw[FH_FSID_TYPE]) + 4;
> +	fhp->fh_handle.fh_raw[FH_AUTH_TYPE] = 0;
>  
> -	mk_fsid(fhp->fh_handle.fh_fsid_type,
> -		fhp->fh_handle.fh_fsid,
> +	mk_fsid(fhp->fh_handle.fh_raw[FH_FSID_TYPE],
> +		fhp->fh_handle.fh_raw + FH_FSID,
>  		ex_dev,
>  		d_inode(exp->ex_path.dentry)->i_ino,
>  		exp->ex_fsid, exp->ex_uuid);
>  
>  	if (inode)
>  		_fh_update(fhp, exp, dentry);
> -	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID) {
> +	if (fhp->fh_handle.fh_raw[FH_FILEID_TYPE] == FILEID_INVALID) {
>  		fh_put(fhp);
>  		return nfserr_stale;
>  	}
> @@ -644,11 +648,11 @@ fh_update(struct svc_fh *fhp)
>  	dentry = fhp->fh_dentry;
>  	if (d_really_is_negative(dentry))
>  		goto out_negative;
> -	if (fhp->fh_handle.fh_fileid_type != FILEID_ROOT)
> +	if (fhp->fh_handle.fh_raw[FH_FILEID_TYPE] != FILEID_ROOT)
>  		return 0;
>  
>  	_fh_update(fhp, fhp->fh_export, dentry);
> -	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID)
> +	if (fhp->fh_handle.fh_raw[FH_FILEID_TYPE] == FILEID_INVALID)
>  		return nfserr_stale;
>  	return 0;
>  out_bad:
> @@ -776,9 +780,9 @@ char * SVCFH_fmt(struct svc_fh *fhp)
>  
>  enum fsid_source fsid_source(const struct svc_fh *fhp)
>  {
> -	if (fhp->fh_handle.fh_version != 1)
> +	if (fhp->fh_handle.fh_raw[FH_VERSION] != 1)
>  		return FSIDSOURCE_DEV;
> -	switch(fhp->fh_handle.fh_fsid_type) {
> +	switch (fhp->fh_handle.fh_raw[FH_FSID_TYPE]) {
>  	case FSID_DEV:
>  	case FSID_ENCODE_DEV:
>  	case FSID_MAJOR_MINOR:
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 5103c2f4d225..26975ede465a 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -43,22 +43,17 @@
>   *   filesystems must not use the values '0' or '0xff'. 'See enum fid_type'
>   *   in include/linux/exportfs.h for currently registered values.
>   */
> -
>  struct knfsd_fh {
>  	unsigned int	fh_size;	/*
>  					 * Points to the current size while
>  					 * building a new file handle.
>  					 */
> -	union {
> -		char			fh_raw[NFS4_FHSIZE];
> -		struct {
> -			u8		fh_version;	/* == 1 */
> -			u8		fh_auth_type;	/* deprecated */
> -			u8		fh_fsid_type;
> -			u8		fh_fileid_type;
> -			u32		fh_fsid[]; /* flexible-array member */
> -		};
> -	};
> +	char		fh_raw[NFS4_FHSIZE];
> +#define FH_VERSION		0
> +#define FH_AUTH_TYPE		1
> +#define FH_FSID_TYPE		2
> +#define FH_FILEID_TYPE		3
> +#define FH_FSID			4
>  };
>  
>  static inline __u32 ino_t_to_u32(ino_t ino)
> @@ -141,10 +136,12 @@ extern enum fsid_source fsid_source(const struct svc_fh *fhp);
>   * sparse from complaining. Since these values are opaque to the
>   * client, that shouldn't be a problem.
>   */
> -static inline void mk_fsid(int vers, u32 *fsidv, dev_t dev, ino_t ino,
> -			   u32 fsid, unsigned char *uuid)
> +static inline void mk_fsid(int vers, void *fsid, dev_t dev, ino_t ino,
> +			   u32 fsid_num, unsigned char *uuid)
>  {
> +	u32 *fsidv = fsid;
>  	u32 *up;
> +
>  	switch(vers) {
>  	case FSID_DEV:
>  		fsidv[0] = (__force __u32)htonl((MAJOR(dev)<<16) |
> @@ -152,7 +149,7 @@ static inline void mk_fsid(int vers, u32 *fsidv, dev_t dev, ino_t ino,
>  		fsidv[1] = ino_t_to_u32(ino);
>  		break;
>  	case FSID_NUM:
> -		fsidv[0] = fsid;
> +		fsidv[0] = fsid_num;
>  		break;
>  	case FSID_MAJOR_MINOR:
>  		fsidv[0] = (__force __u32)htonl(MAJOR(dev));
> @@ -260,9 +257,10 @@ static inline bool fh_match(const struct knfsd_fh *fh1,
>  static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
>  				 const struct knfsd_fh *fh2)
>  {
> -	if (fh1->fh_fsid_type != fh2->fh_fsid_type)
> +	if (fh1->fh_raw[FH_FSID_TYPE] != fh2->fh_raw[FH_FSID_TYPE])
>  		return false;
> -	if (memcmp(fh1->fh_fsid, fh2->fh_fsid, key_len(fh1->fh_fsid_type)) != 0)
> +	if (memcmp(fh1->fh_raw + FH_FSID, fh2->fh_raw + FH_FSID,
> +			key_len(fh1->fh_raw[FH_FSID_TYPE])) != 0)
>  		return false;
>  	return true;
>  }


-- 
Chuck Lever

