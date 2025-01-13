Return-Path: <linux-nfs+bounces-9162-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBCCA0BA4A
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 15:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8901016427A
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 14:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F5623A0F2;
	Mon, 13 Jan 2025 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XHZHtAUG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B4uZ1bmx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA59C23A100
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779576; cv=fail; b=KWk4sC+BIE5kEalG8RlrteH8HcMxeHD7R5GTqGrHi5iEb0O6oZ8Rn6XkO/hhV3zpYEQqLPcJbFKNyhHN0DYAvy6srAdDIn+dG8oR55CEEuctl5yYzrkCICGTH0k/wMMSRYPHtrnayxq8er3KjtNbkBPGPJgFDxdssszv0N553nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779576; c=relaxed/simple;
	bh=OSfXCGMvCAGzIREPIWXD7AMyUF9DhyVfYWmN7/lzZNE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J5mEtS+clCDeEpfhYdcVTleQYz0i7LDlb37+4q/6dFUMA4t7upAQVe7jGs2tYEgMzK8XDqSI/VgEBOvFSzL5nUREyUQgUvGhKOVdDOxwGjCKYc9TCGGyhc1eLdkmE9P6rIJ9WgCyhaww6vqrJtmyicMgnv914lSh8xe/UHuhWOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XHZHtAUG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B4uZ1bmx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DDi1RK003721;
	Mon, 13 Jan 2025 14:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8EBf9/eW1qsDaGNtM2xP4oH+5No3nDfJ0cdwFIhxl/c=; b=
	XHZHtAUGUZidHM6jZUcKb/M7JR/++K3B5s+djH8DHj1hfwbOaYkvU4RxuHsiMJ/d
	x2dxVFDW2wi4dnyym5GG5AVor9hjf4+xi2u0o3Qm2Po3q0WJGxeKWu2rumrrMBuv
	EOuBPAGvbNyrBDZ2PV3PdAvFz+mvKD6LYcxGIjmT63UFwTqCIdzeOq/jlUHRnfCB
	jhbeSOsMZ7w3Gi2JGQiVGxG1Wor9ro8G8VwA1DILQJQ43QIxsMuPr20O9FYwjncA
	vr8XALC58vfO3NWLaQLxhEevRLtKU8GsiBB2ZHoa2x+4NRf3jMgkHvZxu3jsl6QE
	MbEkVXzkD+AbiwyNgMpbDg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fe2bta4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 14:46:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50DCvaAs034845;
	Mon, 13 Jan 2025 14:46:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f372gkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 14:46:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqsi7GqS7KGAgPC5aOt1gg/Wc1/1vtBIe5R8jSpSFu276SCnNFoz+bZpjfkb8qUJH1kNU7otkReoK9kNBDfUITWkmUeuaFsqR3izD/fyOJHukkbfrRhZRveNSUcc+2gnsjSof0jhLoylPjEWxDsRo43STHtcQG6GZpSgqYfGC/QksYXAV0CZOGz2DuMyWHSB5EQH5kosokWH/cbEo6s3rB41VzQowGlBTe79abEIHh/C1Jq3q/bqsWnSUjD4Fs7YBl72aefcNtakxFFzHZpLHaLUqy+UCH5XuWuXxeI5EAWetRJyf5Nwu8hG72PviD466LKDQ+sFnmluG8O7STH3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EBf9/eW1qsDaGNtM2xP4oH+5No3nDfJ0cdwFIhxl/c=;
 b=TVVSA5FyNKuuDineDObSrJ61GSM7VxNC0f+dHeWe/oMPJnzrXzg3xB0mmRBmWpjvwIkB2N5cpUIWL/XpC/hAHJDDDrDYPYELEO87foeQ4LkyLaSX5iYlng3Q7rRdziw4J6w52Ez8h8Wv9TvZ89fs6ar0zCISejk6hQ17/a9R/I5Caxg+u0KmjPp7pOaT7kfhCt5s0sW4PeW5+QOpG3aZzPg/7lmabdtmYCplBkcj1EMzLFQmWBtNuSSZmwFyR15Xly3TPYyrwziIuYq4n6GHwl9TUz35zhLa8hi8JnxVhKjpzOWVChT0rdT+dil8nuzW6Ll/UMgohDxdvLXynsCcrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EBf9/eW1qsDaGNtM2xP4oH+5No3nDfJ0cdwFIhxl/c=;
 b=B4uZ1bmxzSs3y0XzpuDS2yu/WAKOHjCt9pLE0eF8hm9K5fWEdW5vqMF5CIPioOkrCSCU/RTxDIhCxoSCPQ0vux2rNTXalIpSf9H9NGGOD/kgqB4vQ/0JqTxaBDFe1bNz0KLmfedZW6Ki4R2FCk4jIKp6Tp0C55QeFoSBWdQsgJE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5644.namprd10.prod.outlook.com (2603:10b6:510:fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 14:46:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.011; Mon, 13 Jan 2025
 14:46:09 +0000
Message-ID: <b6e28487-ac25-4835-a052-c084db309648@oracle.com>
Date: Mon, 13 Jan 2025 09:46:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: fstests failures with NFSD attribute delegation support
From: Chuck Lever <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Thomas Haynes <loghyr@hammerspace.com>
References: <b00b609b-13db-4404-8bdb-4550195362cf@oracle.com>
 <49f7f3ce-bcb3-462a-b1e3-a99ffb85f10b@oracle.com>
 <5056f1a4-cfce-4213-a605-1803c387e555@oracle.com>
 <a2ffc62e7698aa4b40712e11cf766d964a7cc646.camel@hammerspace.com>
 <24c6c65e-4e6e-423e-afea-b9f3407be4d5@oracle.com>
 <afb9f3f0-0fd5-4b8c-b407-7676a9267e8b@oracle.com>
Content-Language: en-US
In-Reply-To: <afb9f3f0-0fd5-4b8c-b407-7676a9267e8b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:610:75::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 53780b90-e009-49e5-0a5a-08dd33e10445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmJaS1JyTHpqSjhMRU40S1FmRzdIdEVBdzVFT2RKWDk1RlhyTnRrRWxid3dG?=
 =?utf-8?B?VkhudElUYjlMWHVBZGl3cHlZOG41ZTFqTWNvL01LK2pNbGRaV3llZzl0aFBk?=
 =?utf-8?B?Wm9VRGhPQUFEclFzdVBOU0NaellPMFBiWGRBVjM1UjVUYXhmRDFFV0lwWklM?=
 =?utf-8?B?WE5IblRxaEhocDVTT0ZNbE9YUG9sOVlWQWxpWUNEeFJBemFISWlGeGY5ZWR0?=
 =?utf-8?B?Um1TK1ozMVVySmM5eGpRaWxKVTRYWGZRa3V1SDV1bzJmc2h2Z3U5czNUTEZ2?=
 =?utf-8?B?QWlxMngyWkE5eFZzNkw5dWprT04ySmZSVit2RlBkRG9IVW53bmpJZ3F6Zjly?=
 =?utf-8?B?ZjA1YlZWNlh6cTJueUczaTdTcGxPc1JHV0x2RkhJY2Y5S3BkTGJBS0tmcGZi?=
 =?utf-8?B?VEhTWkt0TG9SVFJoSi9CSmgzbHpyeVhGbjcxaW9BNmpLR3RzaURtRnRsbVJl?=
 =?utf-8?B?ZWFMRTFRUEplWnpzaVNoc0FwTlJPcTdzOURoZzV6VXhWNGNobjAxZmwxNEFL?=
 =?utf-8?B?UGtWQ3RmZHlMc3BPYzNXQWRRaDdmZVh6MlpvTndNK1NiUVROVlREbTRqVlhV?=
 =?utf-8?B?Q3hiMHFmOTJ0VkFadm1QaWxtZWJWb09ieDlNQS9MM2ZKK0JkU1N4eEtLREdz?=
 =?utf-8?B?bEdzYUpaWnI3ejlRZlhlRDJxT3lhOUpVUUl4cE11d215T0hmY0hyZW9MWTVI?=
 =?utf-8?B?SEtvNFZFNWI3QjZtc1RRUHlCeWtPSkM1cDFOc1ovTnFWNzh6ZUdLRVZMN0pj?=
 =?utf-8?B?U1ZtTy9LOGIvMzhLb0V3Unl2SHBac3MyR3RoTERQbkNZUEFCZ0R3ZzVZTWtJ?=
 =?utf-8?B?ZU1rZC9GVEdGZHpCT1pvL0JYdVVKRlJQUy9CcDBieWlCMGluOUJ6SVllazZ0?=
 =?utf-8?B?dktZNFdBZDYxOFZ5cDR1OVVJakU0QTBwUCtldC9jUzRvUU5oWlJkTTExV2F0?=
 =?utf-8?B?ZDYycGxDTEM4aGViU3RrM3JGZU9vc216MWF6YTdjQVk2dFVQNkw0d1hFY3VC?=
 =?utf-8?B?VXpNYXlGdDg0Zy9KZXVEWUg0U1RPTXZEMWhmb28xZTJLaEJxNC9EYWlFR3E2?=
 =?utf-8?B?WUw1dlM1amNwTm1mMXhKR2F0MVdubXpCVnovWXhWOEZSTk9ZK0twWE91Ry9G?=
 =?utf-8?B?QkpOdWpNcGptWVJtcHorZ0R2endGTUs2TS92aWpxR0pXaklqS3VPYmJvek5i?=
 =?utf-8?B?WlVYenBxMGpkaDg1dk1YQVRDQ29VMmNoWFJHOWYvMlJsb01EeDNJdXN0SWVG?=
 =?utf-8?B?dGZPOFh5dERJMnptdk1pd0JFSklOVjNWOWVoM2R2NGk0VVhKYTFOalBORVBm?=
 =?utf-8?B?NGFIdHRoOU9vNDdaTzM4QnNjQ05XSEFMWi90RVpSWkErcEFQamE2UnNDV2dq?=
 =?utf-8?B?RnZKeW5Rdm92WDdOMlRvS0pIeW4zMllpUXpZUm5JcUluOGkxWEpsWmp3Sm9N?=
 =?utf-8?B?M1FZVitGYkcyeXVRemFaU3d6aEhCK0ZyZkRBTThZVFR1TlF5NXlEVzVUSjZD?=
 =?utf-8?B?cnVCUkZVRUp6aUU4eEg0THlyd2YzZWp6VUZmVFpNOWF0Ry9admpIUytJZ0pE?=
 =?utf-8?B?NFJwb1RlbDJvM0dXQWc1WkZ3cG94UVFTN2NxVCtQdDlhY09OTnk3Yy9pNzFT?=
 =?utf-8?B?TzZPd3FNTmhNT0dpZEppTU5obmRjZGlnNzdsRUo2RkhDZlVlVzNCb2J3YlNE?=
 =?utf-8?B?OEd2S01xRDRIOUQwVXlvVGxrbFRlcjExazE5Ni8zdml4Ty9VOHByTjVSdThQ?=
 =?utf-8?B?MVU0b0IyODJpbE93VU1zTXdHV3VVVjNzdkpXVEQwVzJzS2tGdmRKdkNkRzNK?=
 =?utf-8?B?VVJoRXE2OHh4bmxoRWxPcnBLMFowd3BPR0ZxemRoZzlZU0hLUlNQNlR1dTJG?=
 =?utf-8?Q?iLntHUEmECd58?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjFwdWk1YXhnMXRpcmZNNUJycXRadXRiejBNbS82R1hiMnJSVFFzUlVGM1J1?=
 =?utf-8?B?YmVrV09YQ1Y2a2NIWWkxUGhlNUJZRTFzOG5Kblo3ZVNmbDh6M2RKaDJCaVRW?=
 =?utf-8?B?bzM0eEJ4RFlhWS9hRkNaLzFRWVIxT0FFMWtjMHhiR1lCZG1Ib3hkTmNNUTht?=
 =?utf-8?B?Vk5rb3A0MFlSK0lINnUrR3pua1RPcHdrWXNxMVVSUk1KcnRvOFFaQW9uYmto?=
 =?utf-8?B?cmJrcTc5aWlXOG5teXhXaTcrdjhUNWtoZDhqanNPZElsQjJscXFMODZnUXlC?=
 =?utf-8?B?RUsxTnZya2h6Z0NOWHdSaEVsMzlPckE0U3RtMmR0NHQ0bmp3eWtLcy9qT1lT?=
 =?utf-8?B?OWczOGZFV3Q0MFgxQnFReUc0OVdTWENmUlNQK0FSSTVVcXNPL1J2RUhpK0xh?=
 =?utf-8?B?aUVhOVFQZTRkbThxZzFvZnR5cm5TSHpxdVNIL3RNaHdDeUxGUlhhOWJ3dUU4?=
 =?utf-8?B?Yld1R1VEUGt0N2thMzVvMTRaZ3dDY2QwdlMxYy9IenEwTmR3U2hnSlp2U0JW?=
 =?utf-8?B?QUdGNjJ6Vk1ESHRmN2VWQWltMnRCbUZ1TzcyNXZ2SnQxakx1c05KdzhreDZP?=
 =?utf-8?B?SGNKTzJZTkdPdU9LZlhwOTQxWUIyZ1JwU1M1WFZyTHo0Nnkyb0xyRWlnZW5i?=
 =?utf-8?B?d0tCZGdOYmhwM0lwSXQyOVl5TmkzbzgzMnpYYklWZDdQSXh5bGF2Yk1FKzhH?=
 =?utf-8?B?ZW45dEl6L0JCbHp2WFd0VDdrWnVpMkpYN3o5UlJNNTR5T2FzT2FueTRHRS9K?=
 =?utf-8?B?dG4xWUx3cHJVbnBVRmV0UnBTOXZhSW1uWloxMi94WmZqNkEzNWRXVjJuV2RL?=
 =?utf-8?B?STgwTnJ1NGY0SjBDcUpLdnNxQVdBSS90cDZHMUNHbHE1S0drcTlkUVlVQnly?=
 =?utf-8?B?dzZWL1ExRGh0elVvQjFtZU5OTnN1U1ZSeGlUNUFRdlU0eXo5Qm51U0JSVXcz?=
 =?utf-8?B?UzRCMnNBKzNqZmJ6ZjMrYmFIU1ZaYnFiRHNkM1BkY1dURVpMbnlwTVplL1VC?=
 =?utf-8?B?SUdHcHViUUtCUFh1N1QzMFhDQ0NZNTBTNGJHOHpwL1lFdVkwOVVUNk5GRFA1?=
 =?utf-8?B?aG1EOGVpSlp2SG9qa3JkZG42bndVNU5CVWVSalVMWTlmczRlejhsMHNQZzBh?=
 =?utf-8?B?aE1CbmE3NDVKRXVkQ3pxTEs5OHUxQkRXYlNsYk1BK1VGYUlVV01kWklObGgz?=
 =?utf-8?B?eEdQKy9Tdldib1F1eXdZNEQwcTJuWTMvN3RzcWdmMlZtYWF6QWQ2SkE0T0dC?=
 =?utf-8?B?RmZ0aVNYK09OZlcrei9TSk9MVHd4cUYvRHRLc0VUb211cTZWeEx4ZHU3N1Vo?=
 =?utf-8?B?SUFJd0VQYXlqMEpURjM2eFYrV0ZMMDNBVzU5Q2NtTU81TG1VcnR0QmZ6eXdH?=
 =?utf-8?B?V0VvRm9QcHVUOEt1OVp6UkZyNUFMME9JTHRkeGIzYjM2b240cTUwdHdoZmVI?=
 =?utf-8?B?WjlLZmlOOUE3U2xmRVdza2RkUEVBeld2bzF0U1RCMEppL3VFOEZQRkc2WkVm?=
 =?utf-8?B?czhMTzhjMVorWEI0SEszQVgxakhBTlA1cFhiUWZnZEdxeDN4L1BzaXVIK1dI?=
 =?utf-8?B?YlRIRXFlWVFCTXpIYWJ1dzRaOTRSV2wrSVdQM0c5cGtFbWl6RU5heWp0clk1?=
 =?utf-8?B?NFhFNXpnM0lQa1o4N3BLQW0vVmFIL210WlI1c1dJU1lqNS8wcG1kVFM5TVJV?=
 =?utf-8?B?M3NWeVhhUEN2ODNjUEZ0STd1bjYwS1djU1hwYXgyOWllUkJXNERLSTF0RFBl?=
 =?utf-8?B?VWZaMnRIVzYvd1VCL2lGYSs2S1RNNlZaSlI0QkFDVUV1ZWpyMGtwUmlQRy95?=
 =?utf-8?B?Q2VxVytXNXNaQ2hEU2s0STlRSkNOek1sRzUrcXE1NE1WbkR4NlhMQTkyZXRB?=
 =?utf-8?B?eHZ1RTFZYldQY2p1YmVpK09KZXp6ZWR6WkdkMWRROWptU1pMSFZiTWQ2MlZ5?=
 =?utf-8?B?cURCWUEzTXdHMTA0di92NFN6OWhQemNsbTRyTzdZY1oxWUZ5VzdtYXZGQlI1?=
 =?utf-8?B?TXBFMjlmc1I4SkdGZTV5Qnhqa2VWOTR5N1BoZ1JaQStndFpRckZodmh5T0g4?=
 =?utf-8?B?NG5TY3ZXaHc2TzFSdG9rNTRSZ3dzWmNXNTJOc2Y3TWNTclRqM085V3Awd0pq?=
 =?utf-8?B?Y1h3cUJUai9YNUpMMDd1THc0ZGdFNGhscmdHdXhOMlJaVEsySjg3bUlaaDVP?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SbLxKJlYUPTO9yULdiSsIUnOS+gZ0urhcC/ZYHykBoR5//raEiYNBJU9rbjwqG9TBCf/9WhuNbwPp+sXm7YUyXnR2WYwTczKgrpQkfkEXwF6uEEhazdK2dPh0WMhuaIN6nj0doKE8uiIRECe13TAz0B7DqCdF7bGxOlFsQIYSbDX+5yWbxmQYHAiwDVWlhxKo59KmiTocomOsztyemlE1dGDVvXdTviPxsgdfd92sTSRojR86+bBVmx/+J1cTf8ke4bT3A3jsJhE478fxzoOu6BN5O8b/S7QElNT7Iqm6xoNtk3x//HeoVQE6DwwYSgyt/wwWw5FaGmHhkxMXgcs9rNE3DCGdm3RWPw66XFiBtjtyuuO+GBwVfWD39ZdW2LGi+jnKtWKgbL1VnZ7AyjcKHchb3q4Jt4N6cO1YXyAsAkXj8I5hsN80qlWmBAWvaVb1aBoVuatBCiCPQ2aDuP0JW+9bvyGiHbuY6A9YdDrBlUETNqRJJovELTx9o6Ey1mLVIGLkus0V4VZ3hAnF1XIlAzkEeGyyFTD+gOf48Wr7ZU5kVP25eZ74lzuSO5rN45tMPYr3AsgisDaaSglb24NiUdagvQsCI+c7FXJRK9AQUU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53780b90-e009-49e5-0a5a-08dd33e10445
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 14:46:08.9977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GlZZkkjsMU9XaUFCbG8Q+lSX6GxPGHbjzQFL9BRzSUM005kj3RSqX2NlZ2W3+BumpubsCxmJ09aViGZdmWHEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501130123
X-Proofpoint-ORIG-GUID: Docsz7pFDJPgi2homUMP2RrszQlCv4BK
X-Proofpoint-GUID: Docsz7pFDJPgi2homUMP2RrszQlCv4BK

On 1/4/25 5:00 PM, Chuck Lever wrote:
> On 12/30/24 10:33 AM, Chuck Lever wrote:
>> On 12/29/24 8:52 PM, Trond Myklebust wrote:
>>> On Sun, 2024-12-29 at 17:37 -0500, Chuck Lever wrote:
>>>> On 12/19/24 3:15 PM, Chuck Lever wrote:
>>>>> On 12/18/24 4:02 PM, Chuck Lever wrote:
>>>>>> Hi -
>>>>>>
>>>>>> I'm testing the NFSD support for attribute delegation, and seeing
>>>>>> these
>>>>>> two new fstests failures: generic/647 and generic/729. Both tests
>>>>>> emit
>>>>>> this error message:
>>>>>>
>>>>>>     mmap-rw-fault: pread /media/test/mmap-rw-fault.tmp (O_DIRECT):
>>>>>> 0 !=
>>>>>> 4096: Bad address
>>>>>>
>>>>>> This is 100% reproducible with the new patches applied to the
>>>>>> server,
>>>>>> and 100% not reproducible when they are not applied on the
>>>>>> server.
>>>>>>
>>>>>> The failure is due to pread64() (on the client) returning EFAULT.
>>>>>> On
>>>>>> the wire, the passing test does:
>>>>>>
>>>>>> SETATTR (size = 0)
>>>>>> WRITE (offset = 4096, len = 4096)
>>>>>> READ (offset = 0, len = 8192)
>>>>>> READ (offset = 4096, len = 4096)
>>>>>> SETATTR (size = 0)
>>>>>>    [ continues until test passes ]
>>>>>>
>>>>>> The failing test does:
>>>>>>
>>>>>> SETATTR (size = 0)
>>>>>> WRITE (offset = 4096, len = 4096)
>>>>>>    [ the failed pread64 seems to occur here ]
>>>>>> CLOSE
>>>>>>
>>>>>> In other words, in the failing case, the client does not emit
>>>>>> READs
>>>>>> to pull in the changed file content.
>>>>>>
>>>>>> The test is using O_DIRECT so I function-traced
>>>>>> nfs_direct_read_schedule_iovec(). In the passing case, this
>>>>>> function
>>>>>> generates the usual set of NFS READs on the wire and returns
>>>>>> successfully.
>>>>>>
>>>>>> In the failing case, iov_iter_get_pages_alloc2() invokes
>>>>>> get_user_pages_fast(), and that appears to fail immediately:
>>>>>>
>>>>>>      mmap-rw-fault-623256 [016] 175303.310394:
>>>>>> funcgraph_entry:
>>>>>>>         get_user_pages_fast() {
>>>>>>      mmap-rw-fault-623256 [016] 175303.310395:
>>>>>> funcgraph_entry:
>>>>>>>           gup_fast_fallback() {
>>>>>>      mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry:
>>>>>> 0.262
>>>>>> us   |          __pte_offset_map();
>>>>>>      mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry:
>>>>>> 0.142
>>>>>> us   |          __rcu_read_unlock();
>>>>>>      mmap-rw-fault-623256 [016] 175303.310396: funcgraph_entry:
>>>>>> 7.824
>>>>>> us   |          __gup_longterm_locked();
>>>>>>      mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit:
>>>>>> 8.967 us
>>>>>>>          }
>>>>>>      mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit:
>>>>>> 9.224 us
>>>>>>>        }
>>>>>>      mmap-rw-fault-623256 [016] 175303.310404:
>>>>>> funcgraph_entry:
>>>>>>>         kvfree() {
>>>>>>
>>>>>> My guess is the cached inode file size is still zero.
>>>>>
>>>>> Confirmed: in the failing case, the read fails because the cached
>>>>> file size is still zero. In the passing case, the cached file size
>>>>> is
>>>>> 8192 before the read.
>>>>>
>>>>> During the test, the client truncates the file, then performs an
>>>>> NFS
>>>>> WRITE to the server, extending the size of the file. When an
>>>>> attribute
>>>>> delegation is in effect, that size extension isn't reflected in the
>>>>> cached value of i_size -- the client ensures that INVALID_SIZE is
>>>>> always clear.
>>>>>
>>>>> But perhaps the NFS client is relying on the client's VFS to
>>>>> maintain
>>>>> i_size...? The NFS client has its own direct I/O implementation, so
>>>>> perhaps an i_size update is missing there.
>>>>
>>>> Because the client never retrieves the file's size from the server
>>>> during either the passing or failing cases, this appears to be a
>>>> client
>>>> bug.
>>>>
>>>> The bug is in nfs_writeback_update_inode() -- if mtime is delegated,
>>>> it
>>>> skips the file extension check, and the file size cached on the
>>>> client
>>>> remains zero after the WRITE completes.
>>>>
>>>> The culprit is commit e12912d94137 ("NFSv4: Add support for delegated
>>>> atime and mtime attributes"). If I remove the hunk that this commit
>>>> adds to nfs_writeback_update_inode(), both generic/647 and
>>>> generic/729
>>>> pass.
>>>>
>>>>
>>>
>>> I'm confused... If O_DIRECT is set on open(), then the NFSv4.x (x>0)
>>> client will set NFS4_SHARE_WANT_NO_DELEG. Furthermore, it should not
>>> set either NFS4_SHARE_WANT_DELEG_TIMESTAMPS or
>>> NFS4_SHARE_WANT_OPEN_XOR_DELEGATION.
>>
>> Examining wire captures...
>>
>>
>> In the passing test (done with NFSv4.1 to the same server), there is
>> indeed an OPEN with OPEN4_SHARE_ACCESS_WANT_NO_DELEG followed by the
>> WRITE to offset 4096 for 4096 bytes. The client returns this OPEN state
>> ID immediately (via CLOSE).
>>
>> Then an OPEN that returns both an OPEN state ID and a WRITE delegation.
>> The client uses the delegation state ID for reading, enabling the test
>> to pass.
> 
> The above is not correct. Upon closer examination, the delegation state
> ID is used for the direct WRITE in this case, even though an OPEN state
> ID is available.
> 
> But since nfs_have_delegated_mtime() returns false, 
> nfs_writeback_update_inode() proceeds to update the cached file size.
> 
> 
>> There are three OPENs on the wire during the failing test.
>>
>> The first two set OPEN4_SHARE_ACCESS_WANT_NO_DELEG. For those, the
>> server returns an OPEN stateid, delegation type OPEN_DELEGATE_NONE_EXT,
>> and WND4_NOT_WANTED is set.
>>
>> The third OPEN appears to request any kind of open. The share_access
>> field contains the raw value 00300003. The rightmost "3" is SHARE_BOTH.
>> I assume the leftmost "3" means WANT_DELEG_TIMESTAMPS and OPEN_XOR;
>> wireshark doesn't currently recognize those bits.
>>
>> NFSD returns an OPEN_DELEGATE_WRITE_ATTRS_DELEG in response to this
>> request, with a delegation state ID and no OPEN state ID.
>>
>> The client uses this delegation state ID for subsequent write
>> operations. The write completions fail to extend the cached file
>> size due to the presence of the delegation.
> 
> Here again the client presents the delegation state ID during the WRITE.
> But since the write delegation also permits delegated time stamps,
> nfs_writeback_update_inode() skips the file size update.
> 
> In both cases, nfs4_select_rw_stateid() is choosing a delegation
> state ID for a direct WRITE. In the this case, it's choosing the
> delegation state ID because it has no OPEN state ID (due to
> OPEN_XOR_DELEG being set).
> 
> nfs4_map_atomic_open_share() seems to be selecting the wrong
> bits to enable for this test... ?
> 

The test application opens the target file without O_DIRECT, performs
one or two chores, then closes the file. It then opens the same file
with O_DIRECT.

The problem arises because, on close(2), the client caches the open
state acquired by the first (non-O_DIRECT) open(2). It emits neither a
CLOSE nor a DELEGRETURN.

For the subsequent O_DIRECT open(2), a fresh OPEN is not emitted. The
client uses the cached open state for direct WRITEs -- in fact, it uses
the delegation state ID from that cached open state.

Note that this happens independent of the minor version. For attribute
delegation, the client's write completion logic sees the active
delegation and skips updating the local file size.

Seems like nfs4_opendata_find_nfs4_state() needs to recognize that an
O_DIRECT OPEN cannot use cached open state that was created by a non
O_DIRECT_OPEN ?? Or nfs4_set_rw_stateid() needs to recognize that an
I/O is direct, and choose only an open state ID. But that means there
needs to be a guarantee that an open state ID is available.

Guidance would be appreciated.


-- 
Chuck Lever

