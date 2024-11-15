Return-Path: <linux-nfs+bounces-8004-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150779CE135
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 15:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C986F2825F6
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 14:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6FC1BE87C;
	Fri, 15 Nov 2024 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QUnnI6+5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lUZuTPZO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D291CF7AF
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680883; cv=fail; b=W/aETZTiiCWAuFPt0VAH1dxMBv7YIpiuNInOqoEnQTBv/akA3CZkCpAg4y2alphoHdX0XqAx3skAXsZ6ISy54epP+Bqt5Onq5sDvLBXREHRhGEEPUd69qJ7WxvcJHBxlQao9YpcbKNyTKeAuDz5prjFufoIR/1N9qt6Z/xltKQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680883; c=relaxed/simple;
	bh=QNDTlPV3zhn7AYWL/1LFZYXzbp+oNI5N6OavAmjwTqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gXAlU4ok3l+KU8Lt+ofVzCWN1h6/VjPH9nDp+NsDlu41dZxM49iqIjUOs5+mO+SLxvnFWfojbeFPuAvGxgxjR5IetZJBsPqLJNaSoXihHGpR6GVSEakr0SiIorddp8Yyw4kMfz88Qd3C+bwdU6z3V6p+RtvzbDWCyXc/5UqAW0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QUnnI6+5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lUZuTPZO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDCR8C030500;
	Fri, 15 Nov 2024 14:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=P2yaavi7IqAyjramTDYjoc6P+DhHQXa/aunPiXm8W8E=; b=
	QUnnI6+55HHNnMwTI/NU0pxgqAJOYjVHt9RxFilOnRuFcldPq9889nfAQJvBlmEa
	CV7G25S6Le6sGgwr8uUv4rYZJoWuCDAm6Q4hJOi6Z2+yLyhNqwBXCTomihrKvi/8
	QYE6EjuMfllfXUuq8Hy7TMwHYyv8FkB2etDlVegYjDhQ0MDiV3lABawwXcX50hu3
	Mnh57+a88Th++9LDbIE3kMQbcir3tSjGY16Vs2HHfX3byBoCORfiWQxAvQbwJNle
	D/RMla6xY5BNaezht1AtWbgWGf8jaoNXoDjYPyqUVIF5EAFlplXUZ1F/szWq31Jj
	vIE91vazZFsgYRAf2kSqOA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heucdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:27:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFCYSYI000429;
	Fri, 15 Nov 2024 14:27:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpbp098-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:27:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/FhhOkZWjO5y4wXJ6JnqclNBUfce3nwr1Wb2jbZtFI7WeAp9NdEFBpxvRWZ2XmaXwahxie+bEISbrid34Yr89yzceVuuWFHmSKqkYLxKeZxRXvuGnQKWGUfQ8Y4s4hdweF5CDrzwXTQ8KZnUkv+mlpAugCoz+6BlCy4NSSlwxC6P8GHjK7/Hrvnmsm1A/VqFOSuuC79jjXKAZlpqvXti6I3vbeRoSWX5sHIquM1jpwJJcdg3nKCm+Cf+kIBlleCEbkvroBFYKa5WX+3m3ql2yKLfu1/Tn6aBEb8/N0S0YJ2dJsnpOYS7VAkQEGapovHugjCBUMrSGQh06CLXeTCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2yaavi7IqAyjramTDYjoc6P+DhHQXa/aunPiXm8W8E=;
 b=nD1MCDpipAH9NClJNN4cXqWIVg9ZjtCJQ15Jo/6SSZyYQqdDgmNJ7BP2C7ma3vYvE9Lhlzile/lLoz/lzX3EUkJFG0i1bX5RrICc4uMNxC7+0bA7Pdklcj3uy/VaG8qbXJyZHL84IgheocZJvafL6SeF/MgFngOcLnTrkF0ZN8jwbd65Nvi17LZLALBFU8qovihmSaoxsNkhi0Ue25zy0JFaaUABM+IjYgOfzvHgziD8TRnIVKXCNXcwAv7gPrETcl+4VpBmKG+lL2pPHNn3cnoIwten8ShBm2HqjF8rFiAHczb1ecizQrPTaFZt+YvQ/QpOGAJ/APY6rdI2A1Kuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2yaavi7IqAyjramTDYjoc6P+DhHQXa/aunPiXm8W8E=;
 b=lUZuTPZOpx0lBxuZtZ/GEYHVNghAbJhKJlX6u5143HE4lijVX1HR/mWDq52O5TOV0rBDmp6hb8NZluH/vuV0wfjJWIHi1RMgeEmA1xOVSvZ8DvAkVfw1AcOhwI0u7MP7asKvK4ADNjeYZ+iDRme4cuIiPW/FeQ8g9wr4uLnHnlQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6492.namprd10.prod.outlook.com (2603:10b6:930:5c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 14:27:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:27:47 +0000
Date: Fri, 15 Nov 2024 09:27:45 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/4 RFC] nfsd: allocate/free session-based DRC slots on
 demand
Message-ID: <ZzdaYRECK2MN81Gn@tissot.1015granger.net>
References: <20241113055345.494856-1-neilb@suse.de>
 <03805410-2951-4BF8-BAA5-544F896E6DA2@oracle.com>
 <173166138079.1734440.6966732313020344490@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <173166138079.1734440.6966732313020344490@noble.neil.brown.name>
X-ClientProxiedBy: CH5PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: 447f3af3-d84a-4ab7-bfb6-08dd0581ad9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEFpTFFEM3NLTSsrd3VZU1ZmemIya2t2M3FudXorR1ZTTmpXUC9pdWZwQjgw?=
 =?utf-8?B?VkExaTc0UkNJcUk2akpobWQ2YWRvVEwvakhhTG1nQnpvRUR6bkdGUE5aYk9V?=
 =?utf-8?B?L0NiRnYrZDRHSXRJK0Jpc0dIK2tnaUQxaWRvclU0M3FLT0FUdExEQ2Nvb0hw?=
 =?utf-8?B?emFOaCtzbGdsQ1h5b3ZLMi9KTHZ6Ly9xVVdLdnhxSzloZHBuZWZWczhIbnFh?=
 =?utf-8?B?TXN4bFNNMXFHenpnUXZDUVZKdmxLSHBvQnlJTlgyaTNjZUxIMThGYmZkQmJI?=
 =?utf-8?B?Y2dGZTBrVnRXMHBoZE80dnpjOW4vWnBMcHoxVzljUHlFaXBjZ1BPczVxSkZt?=
 =?utf-8?B?ZENDRlJVc3NSaDc2VUkrUmx3WTJhREJ5MVVwNDNVYTRRU2NrRlI5WlFGVWQ2?=
 =?utf-8?B?L0RUVzZ1SHd3aTNGb0g3TFRnNDFBRmZ4VkJQdDdzeXNGa1VXWlBqZHk2dWRx?=
 =?utf-8?B?UVJuaWpWMkgzVGdVaVJ5VEs5Vnp2QkdYaUVZOHI2WnExZTFWNktmL2Y0Y0li?=
 =?utf-8?B?d3NHaE01Wmh6Slc3cEE4NnN3enhqdUtiQnFsdXRSTUYxZU05NnArYzQ3bmtQ?=
 =?utf-8?B?aHpYL2tMSGZKZ0h2VzlUWjNMUWhFSHJobTc1VzNIQjJva3dzMk4vMHlyRDhu?=
 =?utf-8?B?YW0zK1QvNWFXL1JuMzFLamRMWkVjNlZaRHZXbGZQT3ZhYjhweHR1MUZ3L0l3?=
 =?utf-8?B?YW5PRFRhZ0dxbExidzF0T1IzR05yZFJDdHhObU03TWUzTlFycmFkNUgwYkJn?=
 =?utf-8?B?WE9FTkpyUzhqcWsydXN3NHBTMlNZR1NlWlhVdjBFYTRRa3k0bHpkK0R4L2JY?=
 =?utf-8?B?aFRUK1pZUHRGZ2VJZlpXajdpRVBUaHdpeGs3d1doQU5FZ3FhYi9vdXR0Z0ZZ?=
 =?utf-8?B?ZDFpSFJkUjY5UHduQmxQYkxLdXdBS2VQQ28wbmJHdXhadDZLSzlaS0FvM01V?=
 =?utf-8?B?YlV5Qkl4M1RDTG5GWU52TldpSjI2NXkvQ0FxenRYNHBpcFhndVhLZGlHZnVU?=
 =?utf-8?B?d0ZBT0lHRzVCdFc2NVByZ09ZL3pXcVM3TEdhRzd4dlFaRUJOc09STWt0UW1q?=
 =?utf-8?B?Wi9vLzFzOE9qa21VdFdTSEtmTndETmRxQUI2Q1AxelV0R2tlT1J1Q1RMeUda?=
 =?utf-8?B?TEZ6eElQUk9VWDlrdURDVkVVMllmdmZHS3hqU21MSDFpWlM3MXNKdjlZeGhj?=
 =?utf-8?B?NytlVVF3aEI3UmtQMjVRUkRoMjYyaHU4dkpwVFB3K0lUYS92Uy9vTndHWFF5?=
 =?utf-8?B?dGtFZjUwSll0TE1xSXYyWU9rZkpUeFQrMWpsL1hmQkxvQ0J3dk1WeE5panJU?=
 =?utf-8?B?U2NIaHNQeDZhWmpJLzlEK2FPcHptQVZVNHdMc1hmNStKUFZrSnhYUXlHcWZu?=
 =?utf-8?B?SkpNU0ZmS2R5Y3NHZ1g3VGdwVjJ6MWQzeFJFanFkMitzOVR6L2JuZEpmbHhD?=
 =?utf-8?B?R1BOOWtOZ1V5VFcvY3BHeUVhN0l0cUs0NmFNTjFpV00vbFVBR3VnQVRJVWVH?=
 =?utf-8?B?SlZjenkwRVUzcG5mR3lIUkhIYzlKTnlwYzR4MTZEZzBudFlwcjh0eER3cktF?=
 =?utf-8?B?VHVaUjBwaDV3aHJlUXpGM2VoZzdZNUxNQUpuOFUxVDdZNHJoaGhkMG9Bb0ZM?=
 =?utf-8?B?czZoTGJEaC9nY3FFeHc5VlJEckRJdjZybHNuVitocWhnVkFRVUorbVhVaU1K?=
 =?utf-8?B?TDdNZ3JoRlJObDFwYnZVd01iVjlsdDYvMEE1SCttSmtEYXJPYTcwV2hTdlBK?=
 =?utf-8?Q?TIPMIpYSmpGmHEOZ7Z1VV0G/Rbp4QBzBAa1x3qo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXJGVk16WkZKRVBNaE5INE05dHpHTHBEczIrUzl2cnlIMC80Q3dQS0xabVFH?=
 =?utf-8?B?R2h1SXNMaW91ellZTElvQ1FWc01pQjNVa1o5TDlrQlc2Tk1TbEVxMVVvQUxh?=
 =?utf-8?B?eG1wcUVOWFhZZGF1bjViVHdlUkxhaUJGVTF0bHJnaDU5NDVKMWZiekdjSzRH?=
 =?utf-8?B?SkVMQ0pGc3ZwOWlDR0d4alZmT1c4R2FLMVB1Wm91SnRSbWpEdW9ySm1RSlli?=
 =?utf-8?B?b1lwMG13Wkk1SlAzZ2FTSUxZbithTXBaZzdUSUJ2dEx2U3hHV2t6aHMyVXMy?=
 =?utf-8?B?OFhUL25pQ1ZqWnFGcWVzYUQ0WC8zVmxaSE5LWE5PTGRQZCtzZ2JzaWZxOFlo?=
 =?utf-8?B?TndxS282QUk1d1E3OGFHMUdvVEFZSFdhSVM4R3cxVk8vNWJWMndtR0RGRk5x?=
 =?utf-8?B?T2UyRGREUHVZc3F2ZVd6VDRtdVBqM3c3L0IrN2dIWFcrd0FseEN6K2FIUmFO?=
 =?utf-8?B?Mmxsd0swS1J4UUNaY3g1NGNhMHFQdHFDUnI5a3NZRW01aGJwVEY2aWprT1Z5?=
 =?utf-8?B?MzBSdVU1ZXRsSzRjZ2tkOEs0cm9VblZmTUZYMzZEc25MR3BXcXVjSTFRWGh6?=
 =?utf-8?B?LzZPZmtvd1Q3WGUveTNwejNYVk15TlFGZ2hObnRQbzg2VTVaTU56MjRreHVT?=
 =?utf-8?B?azI2bFcvemJ3UXJ0enRqbjlwemYvNmluNDVibXU1NkUwbEVubzJQazZZZkFG?=
 =?utf-8?B?SWc2RWc1NjA3NTlkdDNKUWVBNXZEMVViQWk0REorVmovelp5WW56UnFRcHhE?=
 =?utf-8?B?cExlTFUzZU1yRnRGSEErNWdhVk9zYjhCYzQ5dWE0VlRqb2F4NGs5YnVzbG44?=
 =?utf-8?B?eHBEUlhBYVZEeUZPbG11TGxHckM2QW9LZlp4K1hQTzR5dWRNVTB1UnZXR00r?=
 =?utf-8?B?NmcyNmlwaTBzNlp2Q1VUN1dDWmhQaHI1UG9RK1M1YlprWDU2UnpnYnpmdDJI?=
 =?utf-8?B?WlI4bkZSWDg4cnlseFYwUmNhT0lGVkRKaTJmSUh1MWl2dEllbEdwNy9CWFdW?=
 =?utf-8?B?T2lvMjhMWnd3Y3hGdktFL0tNTUJBb3ExMTQwTnY0ZE1sN1g0dXBZWTMza3VO?=
 =?utf-8?B?UWJaUjJqaDIyRGgvTnNydlhmeEtuSnhuek5aVEVLczI3b0lXOFdWcTg3N0VV?=
 =?utf-8?B?aEcvbFNQSytpQlVRYWdtQjJJQ3JhdUFMZnBLcjBDTmJKRUErUHZ5dko4UlJJ?=
 =?utf-8?B?Nlp1YURHQ2hUblkvdzlEa0dZSmo2aC9DY2pHT1c3VW9Sd1ZvaUxwQjZmZWpv?=
 =?utf-8?B?di9qMWJqZTFhOER2OThYU0JRcUtzS0VPQk1paFVIRlNxSHg5MVFrZGw3TXIv?=
 =?utf-8?B?WFFqZ1BUK2xCVkk1TVduZTN0SnVCc1JoTGhhOUpDSmthYUJDWHJxbzQzeVVv?=
 =?utf-8?B?b29BZEc4TzE2TzRveWUzYlAyaGtNeG5iMSs3Zkp4YUlaRGpuZTlqM21GblFE?=
 =?utf-8?B?OXdyYlg4bHN6UHljWG5ZbXloTG1MMFZ3bWorNjEyYkQ1RS9LRHlPcHFYc09C?=
 =?utf-8?B?VlRwWmZ6Zm9CVTVwTnQ1b1FGajdYMElwT00rVml2Z3NZekpuNHNzZ0Jaczc0?=
 =?utf-8?B?ay8yd1QwOWFBclYvRFVKQ0ZQMTRLS0pqelhPZWdzK0VUbzIyd1hROEhLcVd5?=
 =?utf-8?B?MkZ1V0FtdGNvSVlCOUdCS1VGVVBja0pnOXhKQ1BkWXNMVGJBVDBXd3Z0WGNR?=
 =?utf-8?B?MURXMXFnZ0paL3RBd0tKRzl1eGJTMXZKakpGdGNlN0ZhT2c2dkZncHFlaytF?=
 =?utf-8?B?dlIxU0lweExqTFFFVlVqQUFsbEs3M2tMVS85bUNrSUxXM25KOTJ0TDFyUi8x?=
 =?utf-8?B?Zm56VXNMQ0ZNZUpGSHdrYWlQb3lrYXJHcFFFcVlZNW5peHk5YW92YXdYbkFI?=
 =?utf-8?B?SVdnQmV2cVZxbTN0WG1vSU1lU1hqcURwaXlQVXpPL3YrQUtwNCtYSlRHaEh2?=
 =?utf-8?B?aHFKNlM2Vzl0OFBaa2JJclFPaHFBWjVEdHA5SDV3cFkwQm9McEdQSC94MnQy?=
 =?utf-8?B?LzdqZDZFdkRWY3hQdGQvZ2RWak5YSkVneG1uQ3ROekNUU081amNMZGd1ZGJy?=
 =?utf-8?B?OEdBaWZuelRicExzenl4R3RiYmNlV2pTN1Y3bFhReUROWWlNSHBxUkNWRTFR?=
 =?utf-8?Q?tSTyefxHfC0OUCAuUpxIMbX3Q?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1TuGz4qlJ+pUVVFzLQ/WOKBszfXnYy0ZyJW1VDVU2hF+TnfURmyuTUxP/FPuYw/WJqKiVowYhqo3QpVSMF5LSzX3lBq1ThTJ5NyGK2k6Q/tKw6VxbUIE/c4hgVRtC3WYfA06Trve4gzPovfzkG3fP6Kq4Bh7ISmaMCvoNhO6ywVUtC9Ch7osvoMsoYoprFcx2j0fdgbO5IXkRh04pqiLXbX3ickq82tbqlUzZbghoFigX7vM3I34ZJ6p9cpcLRvsTDL+kvQmYsts6rZpTj+To5/thEyw9kt4VK/azloSU8+S5jtrzidUbs4YNIulBNQJnqO5lgSr6ZdDvuLrUmNb8JDE9ER/rMW9rfxOCK97IM/GHXIHpqNxEgAh5RqJYe9SgKnGcX29YI+boM+OeJ/Fx3lfHqZ2CqqRjMnrrVmGqlGHG9FJgAmzgQViX9KDeySPM+EkhXSjn/VlwMokIN4sQQLVMyPSdoj+lKYyRffp0OYgzMPV10PHInM4AWWCz7yX9/0Bpe9yiAHYRVVdtMQnVzOROCr8VI3mAEthvmT2+ZCeENfPG9oFnSgXJCoNw1WPTtR8A4FRTYGbYZEq3BZFKikgzxFvqfGKqXOPZpZ5eGs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447f3af3-d84a-4ab7-bfb6-08dd0581ad9a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:27:47.9516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7AqbHD2pvWkhiav5u/ykuVOHs81awyYmbi+Vu2mRAwyyU8Q+dizNhg0SKFnvLSWigJ9qNoPFZGT0BRFu6BoeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6492
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150123
X-Proofpoint-ORIG-GUID: MZ6p-pHPBLvHgS_Nmy-Xe1spzp2HJnv4
X-Proofpoint-GUID: MZ6p-pHPBLvHgS_Nmy-Xe1spzp2HJnv4

On Fri, Nov 15, 2024 at 08:03:00PM +1100, NeilBrown wrote:
> On Thu, 14 Nov 2024, Chuck Lever III wrote:
> > 
> > 
> > > On Nov 13, 2024, at 12:38 AM, NeilBrown <neilb@suse.de> wrote:
> > > 
> > > This patch set aims to allocate session-based DRC slots on demand, and
> > > free them when not in use, or when memory is tight.
> > > 
> > > I've tested with NFSD_MAX_UNUSED_SLOTS set to 1 so that freeing is
> > > overly agreesive, and with lots of printks, and it seems to do the right
> > > thing, though memory pressure has never freed anything - I think you
> > > need several clients with a non-trivial number of slots allocated before
> > > the thresholds in the shrinker code will trigger any freeing.
> > 
> > Can you describe your test set-up? Generally a system
> > with less than 4GB of memory can trigger shrinkers
> > pretty easily.
> > 
> > If we never see the mechanism being triggered due to
> > memory exhaustion, then I wonder if the additional
> > complexity is adding substantial value.
> 
> Just a single VM with 1G RAM.  Only one client so only one session.

That's a good RAM size for this test, but I think you do need to
have more than a single client to stress the server a little more.


> The default batch count for shrinkers is 64 and the reported count of
> freeable items is normally scaled down a lot until memory gets really
> tight.  So if I only have 6 slots that could be freed the shrinker isn't
> going to notice.
> I set ->batch to 2 and ->seeks to 0 and the shrinker started freeing
> things.  This allowed me to see some bugs.
> 
> One that I haven't resolved yet is the need to wait to get confirmation
> from the client before rejecting requests with larger numbered slots.
> 
> > 
> > 
> > > I haven't made use of the CB_RECALL_SLOT callback.  I'm not sure how
> > > useful that is.  There are certainly cases where simply setting the
> > > target in a SEQUENCE reply might not be enough, but I doubt they are
> > > very common.  You would need a session to be completely idle, with the
> > > last request received on it indicating that lots of slots were still in
> > > use.
> > > 
> > > Currently we allocate slots one at a time when the last available slot
> > > was used by the client, and only if a NOWAIT allocation can succeed.  It
> > > is possible that this isn't quite agreesive enough.  When performing a
> > > lot of writeback it can be useful to have lots of slots, but memory
> > > pressure is also likely to build up on the server so GFP_NOWAIT is likely
> > > to fail.  Maybe occasionally using a firmer request (outside the
> > > spinlock) would be justified.
> > 
> > I'm wondering why GFP_NOWAIT is used here, and I admit
> > I'm not strongly familiar with the code or mechanism.
> > Why not always use GFP_KERNEL ?
> 
> Partly because the kmalloc call is under a spinlock, so we cannot wait. 
> But that could be changed with a bit of work.
> 
> GFP_KERNEL can block indefinitely, and we don't actually need the
> allocation to succeed to satisfy the current request, so it seems wrong
> to block at all when we don't need to.

Ah, that is sensible. A comment might be added that explains that
the server response to the client's "request" to increase the slot
table size does not have to be immediate, and in fact, the failure
is a sign the server is under memory pressure and shouldn't grow the
slot table size anyway.


> I'm hoping that GFP_NOWAIT will succeed often enough that the slot table
> will grow when there is demand - maybe not instantly but not too slowly.

I don't think it will ever fail if the requested allocation is below
4KB, so this might be no more than a fussy detail. It does indeed
make sense to me, though.


> If GFP_NOWAIT doesn't succeed, then reclaim will be happening and the
> shrinker will probably ask us to return some slots soon - maybe it isn't
> worth trying hard to allocate something we will have to return soon.

-- 
Chuck Lever

