Return-Path: <linux-nfs+bounces-7660-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DBF9BBF0B
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 21:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B7B1C211CE
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 20:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD211E630C;
	Mon,  4 Nov 2024 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ID413bSD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0I5i/MgW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699271E3DCF
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730753543; cv=fail; b=Jo7hm7epJqpHSXJVU7Fx5JNU1utN0e8wwojkvfMKdZfcQYTn/v8A0A/nCVo7ZV4adb7YaEjE92+tybFsChFWEe4ItiO0REsV4I22j8wQITGiWLjaDeqIfZDZrIO21+tCDmzCO2PQ/o84UYqY2KcMZe8tiq8PtWpoNVfq8GQMEsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730753543; c=relaxed/simple;
	bh=1uNfhIs+2tISMcttYh3yXOykrfrYBVNaxUqqCy4LkFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p/aShIeSUDsnWHmTagDF0ljtyUK7dMWg/fqk2+G7pK7AZPKZf8nLFZMWHLhvC247okjRefGXguVmQmOOI2mBD50AskrIQdnxS9em0wDgGdHZpEwsyTnAIHXECK8Qm1WTW69PNQOSTVVcebrKsVNQI3/4hVsVGGaVPKafFyJT9xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ID413bSD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0I5i/MgW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4KMfs7001407;
	Mon, 4 Nov 2024 20:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=3nKZa5WiJDIo5eGN1B
	owTckt6nXxxsphoHpfshbtolI=; b=ID413bSDhzHWbDoYELsLEIOFSsK5++ASEW
	OvUnC7VbOffZF8thKf5NI2hy7KrWzkMbsaevbuh+xum4osrom+NTm6dDTVG2uvzN
	sIubDghDEy8seecgFpnuZDO4ZTWqJ5z6Wpt9TdmZKPcRna5veoPzuzmyd5A+TtJz
	ofqXwBEuBp6JLKqFljPqEersFB1lm/kl9W8RgXDWfcw9XAjRGC6E4uO5v0BOBdPT
	V3Bp07T90ipFJCQ27NvyYs38CP5ZSnK5HTy6xfdhf7R2xqYYyu9EGFrWBFkjya0z
	8ue180eq7nWtXhhJPpLTdzsWoUD7ZUc5cq4rp1KDNrmU8WVJH7Zw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nanyuv8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 20:52:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4JnQDV036171;
	Mon, 4 Nov 2024 20:52:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahcjhck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 20:52:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCnG897BW6lXki/MjVOjsnmtAWMtz4mQjfmS4QGYj9pjf4om0fcMoet/cNqkglB54TXIlidMTzWYbvxpqg5GQCNwjwZJA1R5MhVIpIyprD5g178NW1ar+RPBdxZY+7i4WeVdooj+KZRABS53dVPr/V4zdPzTgOSWxMDSL04IGIUTGKzr8bAMG2YuWWbHINy+aU7PHbQLDrxsBV9ZS45BiCslYv0TIvJ5h1k9t9gUUig29TeEphuJC/XBXq90IEkUA4iWcz6WipAzPmZSuK/0HzEF8CUCwUO1imhZkfQ6MMRSgKTdSPBs0vyl75cKXc+LNpvH8HF868FqHf4NgSfdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nKZa5WiJDIo5eGN1BowTckt6nXxxsphoHpfshbtolI=;
 b=OMIdyxVzPUSd6N1v+66Elnc1dpoIjjo8dz1njof3i7+gpWeVv7fg4C1wEqZH+JxdJC7UEM/bnlw57uieYfpoJpn9Tqcd2uZO7Z5tEkl2Ig0FuhuR5QRlJWml47VpDVQrQd+kAWXdB0w/NzPopWQTxa2Vb+ZVhgP2NpPAg077/xtC2Tms0cCT0YOEd0tdVxthM69IfkJ5B1onUtJBYRtnbC4gQ7o3OFPRQFjmPFyqFJ4PqHv+N7klTVN/MDX5fMRWO6f2q2JTlzic9Kmn+J3sxmGR/3q993SzFcWvlWK8ZJfLlssCzcq7jFEYXz/OYt60LejfgnYix2icW9/6Fe3SRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nKZa5WiJDIo5eGN1BowTckt6nXxxsphoHpfshbtolI=;
 b=0I5i/MgWLLBXpejLaB0jwhoOkmR+9EGMRH9BlduOxLu//kYJzcTSh8b+6RVunVmV3ICzF5KUuXl/F3dojshuRlwQTaJBZRvxR4BM3WUCytX3aYpQQK4oZitDZo58fiypjS8JnKw8xIQvCq48UIHEZow4COnMjf4OaGvfGSDa63o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6896.namprd10.prod.outlook.com (2603:10b6:8:134::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 20:52:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 20:52:05 +0000
Date: Mon, 4 Nov 2024 15:52:02 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fallback to sync COPY if async not possible
Message-ID: <Zykz8j7kTJd/CuF6@tissot.1015granger.net>
References: <173069566284.81717.2360317209010090007@noble.neil.brown.name>
 <ZykBKNcLudUySOXZ@tissot.1015granger.net>
 <173075220377.81717.4924074245134896523@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173075220377.81717.4924074245134896523@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:610:e4::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: d1501eb0-15ef-4d9b-6c49-08dcfd128a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6K7tp/IDvbc07w331wr99U7tWdhnm/sgfqeX4hPRDbVQk9AGv1txIUvSI/wa?=
 =?us-ascii?Q?iPgxISSenemIvvcE9M3BfyTPbqUU1bUfpb0GNSYGv4h9pN2AJ7kcRLjZtws5?=
 =?us-ascii?Q?ihE96Q24D8cVJmrC1fsNU/PV6JyPUsQuOai10D+VxL/ujBbO33pKNhKAOOdJ?=
 =?us-ascii?Q?utcQ2RDLF+D1EqGiknMPwVBDLZPz3UwYdn1wHpzu4q4w2BIsg4q6eHllDxJn?=
 =?us-ascii?Q?o/76kOxmGfo45g87KJleFiKLwp0mHGquhWjuGMUNO3EB65zD2H9jbSAaFuky?=
 =?us-ascii?Q?0Y29SY3IVAEPtXAau4ro0ed37UNhnPYQS35i5fGN+fyKgH8y8jwbFggdKynE?=
 =?us-ascii?Q?igmlhuTIB4kwOeM7s46/jalrnI3njEiJr2ZvXkyzE1mT7+yvkIBjtfrPcXUL?=
 =?us-ascii?Q?hhQsDOQ59zhrf6i6klTFSrnGnfxFt7SqCgwhx5muKr8yQStdLPaMmAqIGhR3?=
 =?us-ascii?Q?/f2oBM0sqY9KJYPkZ/HitQYVcTMyLRtVXRbZsYv3UtfKnvrm4r7UraO72GWD?=
 =?us-ascii?Q?7Tixjq2sTEVvPzm1jzCwkiI3CA0wHOkQ73uJmhmERNAWpiAcw3PlCXEV/Kl5?=
 =?us-ascii?Q?lxlqf0ed0OCeUz/IPS5hTTMTI8aSno1XjUQjKGgmXjdqbyhrDJHTLx6y79Bn?=
 =?us-ascii?Q?4ZzpB3UsiB3G+7huKM+QTIyAy1uNlSpHUHNoN1AjxdOP9V0qKqE9Yh0Jf1dL?=
 =?us-ascii?Q?doaiPMAy1NKWz49kJxH2unshqKm99iuGAXesQ7io01rrhB7ot1wSiF+/jV4l?=
 =?us-ascii?Q?4fO89megZ7tpzWTkhSl3WI3DXXw5T7/2juaL4WcuzNwx+lWf97z/+wvocSHs?=
 =?us-ascii?Q?uTGlKym33lnyuKYAFoVr/qR2El5bpTn42T1BL2S7CAPDXHVxPED91Qc1ZyZV?=
 =?us-ascii?Q?eVqWDNujIEB6cEokeDJOJhUQpQN0ziff2WqzyK9VgBB8n8o0XP5R4TWaJQP3?=
 =?us-ascii?Q?KQfkOU0ryjmyYYcSRRaK/mWv4qESYLuIAD6dsmvj3tHAtFHFZc/dBcoBqNiQ?=
 =?us-ascii?Q?BNfdAZSnCAV9+MWb2pv+ig4sU/8VyEhvrvLqXgFDVZY9SbQh0B1XYuXBg06R?=
 =?us-ascii?Q?seVIqClQN4tfffXCc4zRs/+iZYzuh3yP5JfpT8AJeX6hX9xzFuXnMJK1zA8x?=
 =?us-ascii?Q?c53W1Aj8T7AsV/0ygsi7K5ReH1fkpQ+ltljPEvfQDsP2425hzRrhVr5ew9to?=
 =?us-ascii?Q?vxAFzC4cQ5ydldRezddmFqdEC1V76Nj/3AhqJzNQxM+75o1o4nnvSPTj68AJ?=
 =?us-ascii?Q?ier+s5erJRmZdA7WgGrny+EO7rDFaMPLmqfzCfB/7mDKr7dFwWyir199yiOs?=
 =?us-ascii?Q?sACAJirwSXbmnv6r0b5A2vCU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cynh+NZFTa7RWOiyhmX0JxPsHVkAxAEnlpIyN+JtS7MmqUFFWGk/okmH0IQB?=
 =?us-ascii?Q?8nXYALChI6s2sggU9So/YhEe5eTm1T35jT7SU1iMDe0lGYyYQ+voc65AKR1h?=
 =?us-ascii?Q?LxEZxIqHAMmFUPy7AiBc3YqVD9qhxWwxqIp8CrSkp4YbHiMtRkQ18edl08o/?=
 =?us-ascii?Q?rhGjkm1xytQ/5Gt45DkTROcEokXB6DDAJ/VTfnGGIwrUshoOmEoXrhQsXM5L?=
 =?us-ascii?Q?OCVhDCeSAymDUciGcYCP5cB84pMo/YN1riuJNycpqnV5A62Uj5KouKTDfQJQ?=
 =?us-ascii?Q?lRNZP2flkbE/lQk888qfX8f1PnaAvvC2ahfx7jzBGEH8fCLQaLjRe9ZL112s?=
 =?us-ascii?Q?JL2NW1A9bGxl++UbrM+b1EgCnXKm0WEU+FNyV98F2UMrXp0BBVO/JN9/WMpl?=
 =?us-ascii?Q?8C4fZ2SSRPFKxOj8BvoTFPRsjPBJwBoyEA2PsfyuEh//WQAerwWOfNjk5WJx?=
 =?us-ascii?Q?mfjCCyM5iSB/jgrYRrMD0AGlXvxSx8gg0M+IX1jyYVR9dTwbpuJDS6YAwyaB?=
 =?us-ascii?Q?RyVpt38r9Ai21mG2gsHED2gLOZKRDuxCgxb81Od+PFSyOg3WgUyvYp5TLAbY?=
 =?us-ascii?Q?4pdGk9U1eGvi9pydeFKTwSHdlhCbK+JD3JQdwGlF/OBt5m/RcZc4YcWupzgP?=
 =?us-ascii?Q?S9Zym1hKt2TUQVwY30bFu+o2qtCNWjoqT1a44gn4SmwberRaJBYV9lBpwe8c?=
 =?us-ascii?Q?LPyUEAdaOKEcHfNI37C1mmrYp6G9XqC8Vv3ItEOA88wt9H4222rBv6GAsQvu?=
 =?us-ascii?Q?W+ebbrFI4SDpBVIOHRWAoWByu5oz1jtjw5DxN3wR/4h0/Mi4Bcn+GAVn9y4D?=
 =?us-ascii?Q?E0xH5WZ8q/ew+ikHpf5nWig/zSX4gwBwODnQecPoXxmvu7FYSZQMvZbehklv?=
 =?us-ascii?Q?ZD0YGbYiv8qJTd3wLte/dris0nhftt3FlUqejG6mbV1eEjJNrHgdaUG1XUAD?=
 =?us-ascii?Q?LnGPn+y9nUPT7XgfjqfnOAJPhOuz+FASJMzACWb97UMqB4uKlEwiktSx4qDS?=
 =?us-ascii?Q?vmJf054pQw+Jzzf+IDB2WjlrDnHdVXMMJUPp3jH5GRT1fTCRN5ey2qPPTfqh?=
 =?us-ascii?Q?Bj4MT080tcpaxCAirl1tYZs5hYtutuMoq/bzcZfnIghtLgfqHRehkb1ezxQz?=
 =?us-ascii?Q?AADIAmT3KTAhlWhOa1hemIbgJ2Q4DnYmoUkYd8coYlyf5ojXTxGZPtk8yyes?=
 =?us-ascii?Q?vMm7OfocjQcc7w/RHv3HdtGl1WNCXTMA3v5mt7ouGlJQw8Iz8UiT3cFNGod1?=
 =?us-ascii?Q?pQYhRTYhHDZiFQWtBXkV8S2ezdjf1+X9G2029Dt+OxQk7YjYeT0aZuZLUR1t?=
 =?us-ascii?Q?udzHYBLe3bPy6m6Dce2VbYRQN3NCgOlZIbIHHAW9/bBTnF3EDXALcYft3Huk?=
 =?us-ascii?Q?SZiwRyZ3Yo21ROA/R5cvJBXEmdt5lsjpWuRkTZ8h5H8P3OdEdGmlVaQ8NOsh?=
 =?us-ascii?Q?V/gdhBjI/ptuZwyab9s0Ew0FCwb1sikcOwCKhfM0G/ptbDP7BIm2BdFCyX8z?=
 =?us-ascii?Q?7RHqKQxQK9Rhu9d40zGlzadWaZYyIufh+5fWwXMPPfA0ZTkXYUfd7xERdnuZ?=
 =?us-ascii?Q?KV3kyvLour+EcSO+tBcT33a74nG83BzteBA1hfb9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GGuH0QqCNAZ8bOSbMJ9EvSR8arwu50G5425hsbRx1yw7okl09tP9IHkXh4jGKSc6olDkv4LzQ9/O9VH6IeJFrPw1AHufxLZwsk/GZVA++bPbPH4wo82FAkLxG3yj7g1gEhn9tKXCfNgjKVQuvHFBbWDXFu5dtLcjzuZ7z3kKacES3mrzWbQ3pIcSXguihP7e6bDodnzcXae4Ausidb3bbTgVS/+3u7iNIOZRAsChpsg9DP+gF4KIPe3LAjPeF4epvnFbqF6diySWguAeEP1AkecZIKljyq8S08mXl7trRWvQg4bDTziZiGMoh7sKpdUxKf8UI/Nhozmfe7BAAstrQ5N5YfHc/dVooyyhh/2J07g+wgYlkNHckoc9aDj2Bu9WAM537U4S8s1EKsbbswEDdzzGguKYtTAc8wIKLtlfGvYniY0UFbbOdEAhIxp3ADx9nHTjIsEMAnik9nVgVqaT2wMwoQ1Cwa4HnDcLI5i682v57bEkiFCyv5qytEr7C6T/fuglhcRv14YS6niyfiLWKmtPQtb2WzE95kMfOnR++FqeVaHLuqFMQR5rBabh9UiAqnPEUGRFN8KjM5Qjf44FrXtuPG9PlKg4/Jl4RNUgpic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1501eb0-15ef-4d9b-6c49-08dcfd128a64
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 20:52:05.4774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmrG7HnNIRpxaOxKMaQ1UOIy5arl20Kubkhvsvaz7ZrKeWVbPnsZu2Ie8aIEW/mW0AKqTbBcCxhfN71RSor+yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_19,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411040168
X-Proofpoint-ORIG-GUID: BtWL9cRAHEgy7nISzUW6C8i8NvAtUdkI
X-Proofpoint-GUID: BtWL9cRAHEgy7nISzUW6C8i8NvAtUdkI

On Tue, Nov 05, 2024 at 07:30:03AM +1100, NeilBrown wrote:
> On Tue, 05 Nov 2024, Chuck Lever wrote:
> > On Mon, Nov 04, 2024 at 03:47:42PM +1100, NeilBrown wrote:
> > > 
> > > An NFSv4.2 COPY request can explicitly request a synchronous copy.  If
> > > that is not requested then the server is free to perform the copy
> > > synchronously or asynchronously.
> > > 
> > > In the Linux implementation an async copy requires more resources than a
> > > sync copy.  If nfsd cannot allocate these resources, the best response
> > > is to simply perform the copy (or the first 4MB of it) synchronously.
> > > 
> > > This choice may be debatable if the unavailable resource was due to
> > > memory allocation failure - when memalloc fails it might be best to
> > > simply give up as the server is clearly under load.  However in the case
> > > that policy prevents another kthread being created there is no benefit
> > > and much cost is failing with NFS4ERR_DELAY.  In that case it seems
> > > reasonable to avoid that error in all circumstances.
> > > 
> > > So change the out_err case to retry as a sync copy.
> > > 
> > > Fixes: aadc3bbea163 ("NFSD: Limit the number of concurrent async COPY operations")
> > 
> > Hi Neil,
> > 
> > Why is a Fixes: tag necessary?
> > 
> > And why that commit? async copies can fail due to lack of resources
> > on kernels that don't have aadc3bbea163, AFAICT.
> 
> I had hoped my commit message would have explained that, though I accept
> it was not as explicit as it could be.

The problem might be that you and I have different understandings of
what exactly aadc3bbea163 does.


> kmalloc(GFP_KERNEL) allocation failures aren't interesting.  They never
> happen for smallish sizes, and if they do then the server is so borked
> that it hardly matter what we do.
> 
> The fixed commit introduces a new failure mode that COULD easily be hit
> in practice.  It causes the N+1st COPY to wait indefinitely until at
> least one other copy completes which, as you observed in that commit,
> could "run for a long time".  I don't think that behaviour is necessary
> or appropriate.

The waiting happens on the client. An async COPY operation always
completes quickly on the server, in this case with NFS4ERR_DELAY. It
does not tie up an nfsd thread.

By the way, there are two fixes in this area that now appear in
v6.12-rc6 that you should check out.


> Changing the handling for kmalloc failure was just an irrelevant
> side-effect for changing the behaviour when then number of COPY requests
> exceeded the number of configured threads.

aadc3bbea163 checks the number of concurrent /async/ COPY requests,
which do not tie up nfsd threads, and thus are not limited by the
svc_thread count, as synchronous COPY operations are by definition.

I'm still thinking about the ramifications of converting an async
COPY to a sync COPY in this case. We want to reduce the server
workload in this case, rather than accommodate an aggressive client.


> This came up because CVE-2024-49974 was created so I had to do something
> about the theoretical DoS vector in SLE kernels.  I didn't like the
> patch so I backported
> 
> Commit 8d915bbf3926 ("NFSD: Force all NFSv4.2 COPY requests to be synchronous")
> 
> instead (and wondered why it hadn't gone to stable).

I was conservative about requesting a backport here. However, if a
CVE has been filed, and if there is no automation behind that
process, you can explicitly request aadc3bbea163 be backported.

The problem, to me, was less about server resource depletion and
more about client hangs.


> Thanks,
> NeilBrown
> 
> 
> > 
> > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/nfs4proc.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index fea171ffed62..06e0d9153ca9 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -1972,6 +1972,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >  		wake_up_process(async_copy->copy_task);
> > >  		status = nfs_ok;
> > >  	} else {
> > > +	retry_sync:
> > >  		status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
> > >  				       copy->nf_dst->nf_file, true);
> > >  	}
> > > @@ -1990,8 +1991,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >  	}
> > >  	if (async_copy)
> > >  		cleanup_async_copy(async_copy);
> > > -	status = nfserr_jukebox;
> > > -	goto out;
> > > +	goto retry_sync;
> > >  }
> > >  
> > >  static struct nfsd4_copy *
> > > 
> > > base-commit: 26e6e693936986309c01e8bb80e318d63fda4a44
> > > -- 
> > > 2.47.0
> > > 
> > 
> > -- 
> > Chuck Lever
> > 
> 

-- 
Chuck Lever

