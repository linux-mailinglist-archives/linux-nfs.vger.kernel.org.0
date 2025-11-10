Return-Path: <linux-nfs+bounces-16232-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D75F6C482D5
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 18:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 055884F504A
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6533D2868A6;
	Mon, 10 Nov 2025 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pzplKZvX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Em6/51p3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B731CA72
	for <linux-nfs@vger.kernel.org>; Mon, 10 Nov 2025 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792900; cv=fail; b=AXj7pnGDnMhAntVNbHeyz+szHDHeBubH4wD//ukRGC0cenva/UaYKm7HEz3X+acFu/sMDU7JuViujtOM29HH8e7WjLVS0ux/6PCzoSJmgp0hhehYrc+KXjNNMZZ2MUJNmvFK3Oanp2w5HHsZTFdK53ooXDczLdLUCnjyU/qMhDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792900; c=relaxed/simple;
	bh=X7VTX5ywbH9P98Xp/H9MKBbvIUcv8LFFZZPkbxYsT7s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=avC4UC3HCRnGFFBuXdjv+jWtvEWfTtjuTi6FB0JQ2dqONngx0rm58X7SimShJBHKUGSgRIpzbA+Vof1+jFXAGxS6REk8+p8bshliOWGhCa9APKwpEwH5IeNmGct2Ya1/adoUzn12dQ/BXIX0xTJETCokKOCk7dVRd8vk4kSYf6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pzplKZvX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Em6/51p3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGUMt7030999;
	Mon, 10 Nov 2025 16:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jPNdAmy0gSsU0qpGI6wFrzlTzvZr9E9HYXI4VVmcxsc=; b=
	pzplKZvXezqS7LFiAYx3SrPiPm41WggCWLnBt3dFDa9cjXAQgusOgoEmiI0Nl3Uf
	I2yHUPMKDd92znYXAowSOhmwJXaOAg3utfTlWFrIbUJKmYmx9txPHas4p5fDlcUj
	MLuEqdSc/5ZckyPTW8DV/7eX6VC6LmqyUbC06pBgG2oVyH0Mi3hKmk+of378YUEA
	8KimsJ73mxjGAj08dWYLDIQYYANLPbyDn/qyifUh+QlYy4T5ZgPE32+CMd3WulOU
	QE0zNEcYP3E4VY2CsGyx3b7F8pd0bn0ZMaWR1nFQUsNT45etoE54UP/Jo/J4yNIl
	Q7wtGRUzWGlJVY8Rpkx++w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abkmjr14u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:41:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAFjgKl012547;
	Mon, 10 Nov 2025 16:41:14 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vabvey5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:41:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP9we/Le6J7fI6qh3gtltQiR7vEpP4fudmVGfxzUdwMZ3oNA3lLsM0ClegBF41aDhKps0VVpb1OTe9JwFQ00LgpP/d6ZQQJ1WsHjY63bgJOmUnRcRiQdZG1JFV772WrmOayuwXRe5Ar/YnsliGbsFGFVa4PF/E1GeDWih6gHXq64QKZL6+d6LfUL9g7oCTPRS8p36Ua232p23QUbOSKziQqsIBB4lEDV7CVkAxBAmllfejl3dHp1Cy1IxRapHWd3JyBuB2cj0ElRYeC+XmUnPKtkZ2m0U1i+jDxnk8lgRLJhQ6mFpSxKyhS0hunIvhWqoXhdiMsU0txCeZgW8OzNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPNdAmy0gSsU0qpGI6wFrzlTzvZr9E9HYXI4VVmcxsc=;
 b=iFOZ+rucA8HAa4DhNNnmbIL45F0DF8PvvOHc/6qI66zyQprWz5pMil+2/Qpn3WF4ubDlKec5BIt/Xs5QLk5bN9KUTABc96ARUNsagPGT2rV4RA7QTTCMWWo52cQlsViqYezAlWBOA5O0DawoVswJEU7fPQoUc4lDpEEg+7Dz2I8QXSEij7LusM1WDAgMH8Ot9n38g5tVbnmujBG7JfbykFEvPEeHWENa+b1GHxoDduEvDx8RPvOr2ZPlzQCekUp6FuZoyBsAIOxK/qCxdFyOURlS/pb5CixQVOL4N6p+ptjzLJ0wtp1MTsOBLAtfp29VgYF9wcrYwIsIY2SMsy2wCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPNdAmy0gSsU0qpGI6wFrzlTzvZr9E9HYXI4VVmcxsc=;
 b=Em6/51p3qYSxlK/zpPeLyo/WWG2K3mpFz7NmQSSAtfmnfxLComuWBGTQ/OI4YEScLSDof02m8eS4cgVSnjBKBYYxniYiBylPzhQTWq/zzwGdh8J+bIESustSjS34H545yMCJZ4/KvTm9D5ojFLfFSoU1O7odptye7ct54VSMmDY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 16:41:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 16:41:11 +0000
Message-ID: <2b024928-e078-4414-a062-bbeedfeea5d9@oracle.com>
Date: Mon, 10 Nov 2025 11:41:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Mike Snitzer <snitzer@kernel.org>, NeilBrown <neilb@ownmail.net>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
References: <20251107153422.4373-1-cel@kernel.org>
 <20251107153422.4373-3-cel@kernel.org> <aQ4Sr5M9dk2jGS0D@infradead.org>
 <82be5f47-77df-423d-a4f3-17f83ddb6636@kernel.org>
 <aQ5Q99Kvw0ZE09Th@kernel.org>
 <fb0d6399-ea74-462a-982a-df232e3f4be9@kernel.org>
 <aQ5SSnW9xUWj9xBi@kernel.org>
 <176255273643.634289.15333032218575182744@noble.neil.brown.name>
 <aQ5xkjIzf6uU_zLa@kernel.org>
 <176255894778.634289.2265909350991291087@noble.neil.brown.name>
 <aQ6kkd74pj2aUd8b@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aQ6kkd74pj2aUd8b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:610:53::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4835:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b014f5-266b-4fa3-84c1-08de2077f4d7
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UXFrRm8yU2tjbTNrOGJpTVltUU9YRTFDVmFYQnRTR2xnbXgwaXdkdzg5Zi95?=
 =?utf-8?B?elpuNk9VUHkyL0diZitodzJUcjVmKzVQaE5tYllKOHNQMGRKZ0UrOXRpbzds?=
 =?utf-8?B?S3EyMko0TjVvQXdTV1grOHRFckNRa3ZYbzN1OVlCOURvNEpVQnVNZ05hNjRw?=
 =?utf-8?B?d2hiclpuQWtCWmFXOSsvcndqTHZmU2JrVTJ2UkVrNXRLdHUzQjY0dVA2RTdH?=
 =?utf-8?B?TVFFV1hlQ1ppNVpNYlVDblNVQkJQb2cvaHFYNWpvOUhzZ0lScEtMeTdma0Rw?=
 =?utf-8?B?YVpHRHowdk5SdC9hSXIzYVh5Z1dsMHFOSTd0amxJbm02YTdEVEs1RnF4TUQ1?=
 =?utf-8?B?dFBZdXJLLzFqMnJEdlRHZDRLUzBqd2U2aittUXVrSnBoeWhPZm5rSFVNZWdL?=
 =?utf-8?B?QXZqbFJCR2FVTDRpUjhtWHdVOVYzc0diVkFzUWRsRXNxbW9jYmU3WUQyS1Vl?=
 =?utf-8?B?U25UWm12enlkTEZBN3loMDJlck1KWUR1UUE1My85dE1RR014L3VyQzVPVWlQ?=
 =?utf-8?B?d0ZpRmwzY3RhMU1PL0twTC9hTnRia2ZKN0hhTS9mSitya0g2dTBZZTdlWkdq?=
 =?utf-8?B?QUJocU5kZllyaDFrQmR1MzZ0Sk1yeDFXczh6ckcvbk1rbmx2azZaWHJwMlZS?=
 =?utf-8?B?ampmS05DTGk1cnhXQWdLTkJZbVpBeVprWWNiWDM0WE5rQlY3OUtTWmczcytx?=
 =?utf-8?B?YmFBK0hndE5tTG1lSE4zTU1BNS9paTJFT2NLd2xreHB5bndYVkdaaCtaZzhJ?=
 =?utf-8?B?SGtPTDJTWHZZKzJBRHRteUlTVXluTFlka0lOVHlvNW5sQnVVUjF2Q3h6dGVx?=
 =?utf-8?B?ZDNNUGFJdnhWZmdxN3RNZCtoNXp1azk5TDVRbTNiTmZabE5UaDk4MGZVOGd3?=
 =?utf-8?B?QlIrZjdFNUVFQzVMVldncURvSlRaTFdabmFMcHcwQWRqdHFLZFdpQVZCWkl3?=
 =?utf-8?B?UUszcFdocUExWTBRWlJPNElKc2hqWXBnb2FDWVVBWm4rVUtkcDFZMjIvaHZw?=
 =?utf-8?B?TlAxa2xzUzEwMS9TeS92NGVOUWFLS3h2VVgvQWFSUWVhNWlDelMySXgyMFVR?=
 =?utf-8?B?NFU2Q24zdWpGUy9qRDVGQ3d0eHhoa0lZZnJ3MjJmYjBySWgzdGlKQUxOdCts?=
 =?utf-8?B?Ni9ZTFp1ZjBUQjc2U0tadE0xWEVGWEpEa2VDY0hjR09yd0FQSlBMc0hFc0Zt?=
 =?utf-8?B?VTJBRjgxYlc3MllZOEdiTFZkLzlSRU1wSHVvbDB4Y2VoMmRiSlhIQjJtTHYx?=
 =?utf-8?B?UUNERHA5TVZnemRaUUJ1ZFkyR2V5MDNpL0dYVFB2OE5QWmVETWpVcXMza3Z1?=
 =?utf-8?B?amwzN09tT3lDWXZLbzdYUUlzdUhXTG5JNUZCVTg3Vnc0RHUvK1BtMjBSYmZV?=
 =?utf-8?B?c2IwMlVzTU1pQ0pERzZKeFRkUU5CcTVGeno0ZEd5UjJSUXMvdnRweWZSQm9T?=
 =?utf-8?B?cmU1cEQyYmUyNjJYSndldDVtVFljWEhZeTljT2x3RytYZFJITTNsaEJCVHFP?=
 =?utf-8?B?MXRweGZDMWFzcGxPYkpHMENNclVWRFdMeGFDK1d6cE5JR0RFZG4xR2JxTjJy?=
 =?utf-8?B?VFNSLzJRMHRINlpxQWhkQnc3eUVLS1BqNmMyTnk2M2tVNVJldUEyNkNwTGpw?=
 =?utf-8?B?QUNqQlY2TlNiaHdRR0d2VWdqNUhOemV5VGRwQVdxR0R4RUVkOVBuZkZIeXpT?=
 =?utf-8?B?MlRMVkd1ZU5DSDBHaUJxRGVnMU50WGNMUDVTZDNLaW5RUWExOFJNZG5kcFNy?=
 =?utf-8?B?QVBwRWxuQWROVURzbDM2aFZNUHBPN2pzc0h6QUlpNHh3Q1doL0p1WEVQdWdO?=
 =?utf-8?B?cWV0Ym9mUjBlVW1rNnVnTmtBMmVrMDYrMS9jQmUrYzE5SE5KVENaRnpoQW1D?=
 =?utf-8?B?SWlBektFaGY0VDhGd2ZqRi8waGlhSXByWi95YXQyekxtVTJiRVNYdWQ1aWVC?=
 =?utf-8?Q?KjY0IdtoNrRbEJa19z7Brchw4gOoPvK8?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?K1M5ZDBiVHlnRUJkcDJRQlFaR3hZbDlyS1l4cTBiSkxYRXE4TGJtcDlJZXBZ?=
 =?utf-8?B?Y1ZpTVN2b29sZVU1OTdzVGVnRjdjZFFXa3FRWVl4YjNhaHpiSktINWV2ZnNF?=
 =?utf-8?B?czMvano0YnpkTHZOMWlCalBoTVg3OGd3WUFtcUdDa0w4bnVDY2VueDJrTnF3?=
 =?utf-8?B?emQzRmp2WFBldHBaMTdDTldPRWx1Y1B5M1RTT1FDTEhOQ21wYTZiekozWHd3?=
 =?utf-8?B?bSt6NUduWUNBcU1KbTZVQjg5UnBrTzBDckhIWFQ3a2hnVVBtWlhrSGpyOCtt?=
 =?utf-8?B?UFdGSU1jQS9Ea3R6TGVxTVBETS9NeWpDRG56UU55R055a2lxay9zNXNBemlZ?=
 =?utf-8?B?N2ZqK0xDYU11UFN3TGQyNEE0dkxtVlhwMDF1VmMwQkcxdTJRYS9Mdis4YUJS?=
 =?utf-8?B?Z28wTFJhSFVwV1Q1UXVtbThQWDFzRW16eEo2Yi96cmhZdGRvV2pBOGZ6cjB1?=
 =?utf-8?B?Y3dvQXJ1VFdZSWxDaXVNb25jVmxDbjMzbU1LdmQrcjhseVgyeWtSRlF2dncw?=
 =?utf-8?B?ZFIxMitYajJoZVg5QXdJK3ZMaCtKVzNqcUhRVG8xNldUeEV5eE05OHhOOWMv?=
 =?utf-8?B?QnRXTU94UXlHemlQMHNhZ0wxRFMzL2h1M0tVZXY1Y0xOMXBEYkgvZzZQR2lD?=
 =?utf-8?B?U1V5UENCb01rekRDMUR2Z3lZdGNCdHg4a0dMa3dnQzB5Tyt3aklQVkxYMDFn?=
 =?utf-8?B?NFlmWkJLcklTRDhRQ3R6VkNYcm1qQTk0emRrTXE4Ty9WMXFDUXZnY283Wjdz?=
 =?utf-8?B?cFlEQ2JCMzFNWjJqdVE1MjVHWnpwYWl5YmFLcDhUL2FBYndYdEtWSmY3MVNL?=
 =?utf-8?B?RlVOcjA1U3RjYkpQaTFJY1hpZGhzVE4xdlREWUpiUzd1bHJKbDRkRVZoS0hl?=
 =?utf-8?B?Y0MyeHpra29mNTAzMDhwVDduLzZyUEMxekVWYUJlK2FtUTRtSjBwd2dma3hK?=
 =?utf-8?B?bXIyL25oTlVaUDlTb2tjOG9aLzJuOW9xWFBWOFRlL2RFQVN0OU8wNTFESlFK?=
 =?utf-8?B?WlUrZFJqUjNVN0hFNGVDTE13OXlhOWEybFFOUWl0ekp2VnE4L3R1MkpQRWZU?=
 =?utf-8?B?aGZlaGU0elJ3MWUxVHFiTUtXSTJtUVBsUHVEeGNkWXBMYUF5M2xUWU93U2tX?=
 =?utf-8?B?d0VKcDA2YzBSRWZQYWlkZnhPSm84WDh5T0ltancwN0xNYWJ5cEFwVnZYZVRw?=
 =?utf-8?B?eUk1a1dZRCsybmp6ZWZsaDQwSGE5NWN3ZlNDelFrcC9qOEpmWW5OSTZicHgv?=
 =?utf-8?B?ZGVENG83dWVTdkVjZGZXeXkzQVV2RnN1aWdleFI0QVphTjB0L1VzeC9QbkRr?=
 =?utf-8?B?UWNhbk9wY09MeENDeDNtelVEaHIwZ1FQM3JUNjcvaS9ZMmU2OUd2eVhyb1pS?=
 =?utf-8?B?WmpyejBFQ0VNYXFCWk03cHM3VjR5MnBzdi94RmFKMHNpN0sySlYvYnlYUjVQ?=
 =?utf-8?B?Qm9BSnFSaktzMEMwUnd2Q0RMdDV3cXBxRkxEVjdQZFRmRmZkV0xOcG15VU5O?=
 =?utf-8?B?TzlLNzZBTDE3TzdYdFAxSzRkRVRiblAyaUExeXBSUlBxVDFSa2NWS3RPZkFL?=
 =?utf-8?B?dkN6ZHpGK0dlUS81dGhCSHRoMDc4SjZGcGhIYmM3QWVmcUY1aUFQR0VpN2Z3?=
 =?utf-8?B?Sm1ZTVlndForYmo5aXFIejRqd3pFck1yMHFUeW5SM25zYXQxRUtTck5zNGdR?=
 =?utf-8?B?QlIwc0dYK0IwR2kycm5NK0VuTUtaV1pFdlNHL1lqWU9aT2NhLytPd2gwOUU2?=
 =?utf-8?B?Qm5SYm00bFdUakYvL2VnNlhSTlRPdFE1V09PK05Sa2VQVlJZVUFJOTljNTlE?=
 =?utf-8?B?SG9EdUYwa1pJZDZHQU1XeER3bzk2N3BGckVwamtQZXZuZFdSQXA5clAzanNn?=
 =?utf-8?B?cUFGTGN5MXliR3pyRkxFRWdza2dRTjZvcWpLZkdBbUhlSHNjU29ta3VDM1E1?=
 =?utf-8?B?SG5Ia2FHc1QvUUt0bFFuM0g5SnVzekdYY1d1Um5CNHhINHd1OS80TVFsZ1Er?=
 =?utf-8?B?MGRLb0tCcFR3MEduM0xFU3VhSjhEZytSYjNncG4rMy9vNjVCUWlraEpQeVdH?=
 =?utf-8?B?N0FSbFZSNmRoYWhRcWtLUTBuZmh3TTdDVlV5K3FoV0dnenp6UTNQb1hIelNJ?=
 =?utf-8?Q?VjpZYzY+6n5t1ZyQmGlj7xUI2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VcbZj2Hyi9tne3LyAjKMUO8+zXyl44pzbq+DJX9KNbaUz2Cl/zYlm6b7RQYPN1C4+meQU4rVbpLHtfUZOgjPiMZhoRpsVhZC1RayNgzgYa3IpsyDfDnGKC5fJa0bmxvVGYE/IT4m5A6Cuq4W9peuv5+pmxRZpUuEOfarh+/zOjXajhmqvhwfHBJ8b7T+rxPO1wVUqeNbw1tJOcC0ajVnWTi4FeEpSIQTEtBeul5Xm+Rzl+Yzj6il9JU/7Jo0/uYvHEjkzMi3SgjwnQmezgO1luC79egol2eSf9mvJ9KE4O2dWqtIpyrYRPEmKSlabpQUhtAHFJ9NzlcInRfPEW50LwZn3rQM0JJr411oh2zZRU/B+LoMKZFf6gAJaHjvb2g5JQAoHdTS6MyFKae8BM3uDn64lZi14a/7NmNGYJNJ3cuS3nN21UrraghkKlMlihDP+KuzkQUwFCteFL1CESW2n3TNVESxkH/dLz1on+VzyXf//rAqXBqNGAgramTSgUmEEc7Tga/seO1DSozyBaDhAvWL3w02pagLh+3AsOdeJAZ2YR5DVoNpNLW0DHAVAAkC0uLNd9hkg3pVv3yYjsH/38xw7ArUq1Ky18qZ7zO/0aw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b014f5-266b-4fa3-84c1-08de2077f4d7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 16:41:11.5307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghH3KZtN6ixg6Wkumr3wqbzHlwBQ6Tx9F0R4RBAHN0+zKuGRbPmdT4hNdkioTi5UBw/sfrD347w5Ywa2+Sgi/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4835
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100140
X-Proofpoint-GUID: NcBwF7rHb-RBt1ufTxE_WksXD8cRNWAx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEzOSBTYWx0ZWRfX2+qYkQldSV0M
 t50gr30VlR3ymAd8mBclwNW/5246ufLnSv168dbIEmQy9cTzG7i56itvsRl1MUTtqJJXmTBxX0K
 zKtknBUbLcPDuH81g4Tsa3uY6Il+tqv7+9SEQvz7AzLg8zMqmJky8hLPhDKGyY4H22mwYmemTTA
 LYWcGPpR3hPhGgswo6u/aviNPUzNlh+1uk7vX3JGOpD4xprB9FqGsQWzX7sUwYJrWimurL2tSDa
 fpmGn/w1vMduo/bzU0r87TI+PZC97BlX1X6V32dvDUDr91NPJUDBP2JW0AOzhIz6Pdzq+GYFXsd
 79jsB9+t7QIMfKB2xeL/RbnXq9CrOq+350RVZqjYH4xrrKW0X0ZO53X109us4shUqkz4He/MqcF
 3NlCvPG4QkWBzfgWiGHi32OV895NsbzkHD5Nm/4E/OM+gcE5knM=
X-Authority-Analysis: v=2.4 cv=U4qfzOru c=1 sm=1 tr=0 ts=691215ac b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=UX1IYdMKIA8IerRsMvQA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: NcBwF7rHb-RBt1ufTxE_WksXD8cRNWAx

On 11/7/25 9:01 PM, Mike Snitzer wrote:
> Q: Case 2 uses DONTCACHE, so case 1 should too right?
> 
> A: NO. There is legit benefit to having case 1 use cached buffered IO
> when issuing its 2 subpage IOs; and that benefit doesn't cause harm> because order-0 page management is not causing the MM problems that
> NFSD_IO_DIRECT sets out to avoid (whereas higher order cached buffered
> IO is exactly what both DONTCACHE and NFSD_IO_DIRECT aim to avoid.
> Otherwise MM spins and spins trying to find adequate free pages,
> cannot so does dirty writeback and reclaim which causes kswapd and
> kcompactd to burn cpu, etc).

Paraphrasing: Each unaligned end (case 1) is always smaller than a page,
thus it will stick with order-0 allocations (if that byte range is not
already in the page cache), allocations that are, practically speaking,
reliable.

However it might be a stretch to claim that an order-0 allocation
/never/ drives memory reclaim.

It still comes down to "it's faster and generally not harmful... and
clients have to issue WRITEs that are arbitrarily aligned, so let's help
them out."

What we still don't know is exactly what the extra cost of setting
DONTCACHE is, even on small writes. Maybe DONTCACHE should be cleared
for /all/ segments that are smaller than a page?


Sidebar: I resist calling such writes poorly formed or misaligned, as
there seems to be a little (unintended) moralism in those terms. Clients
must write only what data has changed. Aligning the payload byte ranges
(using RMW) is incredibly inefficient. So those writes are just as
correct and valid as writes that are optimally aligned.

When I hear "poorly formed" write, I think of an NFS WRITE that has
invalid arguments or corrupted XDR.


> Let's please not get hung up of intent of O_DIRECT because
> NFSD_IO_DIRECT achieves that intent very well

I think we need to have a clear idea what that intent is, because it
is explicitly referenced in a code comment as the rationale for setting
DONTCACHE. It might be better to replace that comment with a reason for
using DONTCACHE that does not mention "the intent of using DIRECT".
Something like:

 * Mark the I/O buffer as evict-able to reduce memory contention.

-- 
Chuck Lever


