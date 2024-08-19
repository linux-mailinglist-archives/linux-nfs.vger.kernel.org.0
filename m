Return-Path: <linux-nfs+bounces-5443-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAE6956F74
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2024 17:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5CC1C2031A
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2024 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FD613698F;
	Mon, 19 Aug 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hWdFhSAK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pGVjMseb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D92D045;
	Mon, 19 Aug 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083160; cv=fail; b=jpoJ0b1DV9+sTJqBuH6fFi3Z8cLDFJgIIsXEmbikxaz1wO7aGcxLlrzkaDeougrrNU59AdxR4QEZLrIlE/VVjket0f5Z2YdAIVUGwc7BjiNVtmjmVbJjfXCepulah7FCMpbXQ5uoeCNARX9vm7BU3QJUGNbcG96iamy295A9gC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083160; c=relaxed/simple;
	bh=rFB1ujjvXQd2mqo2FUgWRcXz4P/O9OAJYMkR/AZ+1yo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dw2br49xVKcDyzBDVEqg8+w/9j1dCS9Yz8qn+kUXGj6Cs8N3WvDO0djmatBAff2EJt+5YYSJNTF9sjQ9ByTrrIYv9A1J7Hp2c0UzVSnmCdZvd2g/+eBKHFQ6s/VPYETZp3yg5w/qFSGqqooavdml/8DcY9z6Oqxha70ygp08mGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hWdFhSAK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pGVjMseb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD6so0013190;
	Mon, 19 Aug 2024 15:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=QqAIR2V86dsPL/
	5hjufp6H4anoJk1+69Uu+D7oyYFJ4=; b=hWdFhSAKV3fls0e3k5SeV4hp2JE0D7
	1I0L6xqpO6RsS2KF1UWnDjpuukLbjvS/Ilvq/mgrX2tqb0dQHdwCi6btTnntIM4I
	d0Bd+Tm6JBA8zUXg9E6G9GoeMFqLnb3WJwshsdD4uliH9qDfFr6BXGSQhId2P6T3
	ngKyNNaN+GlDXNALLh92GrRbd4e/AkjqoA/6l8sWJIoA9SnLWUFrydXAqzXoP8PF
	akrdMtXs5klJia/oiTZ/GLFhbo7V8hHWhB+JLba4qj60L30Mg69pbaqMAVinpmsK
	NQz9hNmj4mlMfiOvvC0eUZz3FbesZSEUJY1EGeUwLHxxgipiGz+BjoxA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67axp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 15:59:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JEbHjD018969;
	Mon, 19 Aug 2024 15:59:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 413h428msb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 15:59:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gwd9GARb+2dAlYAa+PGs0GtDHhWpxpD1P0we2LrShEtlP5wQ3mniFHlkhU3vRMaZgJ2nEz6cYfaoIcTaTOfqdi+HUS5pkZzm1GAMlRxi0TEyfKBcDZcWJrQBr2U6QmP66QU1coCuXuxeB6tswvWGQnow/fkUQ2kQ9njTuKGJa5Dwh4kw1d4e6iwVJ8PPgfGiaKrbQPOLaUjSkBaPlXgXHHx15TxFPAdJj/7l3gb8p3e8AABPa5t2GYe5QlPgL6uiuGXCvVAc0cpmGcmR7kuIwcU6M5fVOtMgZ/OpgChdglZRvTINIy0ne1VoF7H9+30z3zoesZQ3bOavhTI7kwcEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqAIR2V86dsPL/5hjufp6H4anoJk1+69Uu+D7oyYFJ4=;
 b=a3aFMXXHJNnSlH1KzuMLuOZSFdFffCaLxbnGk1PGgLRVBUoqKMgQo2AxN9s6IXTl9ZMpt6RTt7lPGXknnicLqe5wxaTBnbrwkcdWcknd32uiA+8kkJ/GPdoAg7Dx4u3vzpB/GXRZbqGlHqnNx7UPwIRUM4oHbSO/pSKcog9xYpzE7kTAdNDT2KNSo6pxffbHdXQRfS34uXOT7crZAYgYHz6pbMadcUmz674fBcNtMdbRjTiJLywWL2flTptnHFVj8hb8M4c9dR6GhWpwinae6GgnS7aIQohAaT2QVMptjPn5jDGvX7ZcS3m+3giRfsrEsM2mvG4NZElLbQjQv/pqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqAIR2V86dsPL/5hjufp6H4anoJk1+69Uu+D7oyYFJ4=;
 b=pGVjMsebK+9TCepmOEXxbtp8YIL94XwBycjHpptp1smhW8RpPH2QNjdzin2XKWMgwDDi87Lq22gjX62FoQNuYwJ270DTsMDvZLAQqjMVRfSvS4UyI6QkDXuLO4pIasjH75icFLhDVZb/6WoTHiGlIB9s5At2ih/avdAlMbzzVxU=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 19 Aug
 2024 15:59:05 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 15:59:05 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org, Tom Talpey <tom@talpey.com>,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Olga Kornievskaia <kolga@netapp.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2] SUNRPC: convert RPC_TASK_* constants to enum
Date: Mon, 19 Aug 2024 08:58:59 -0700
Message-ID: <20240819155901.416560-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0447.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::27) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CO6PR10MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 683fb584-b44d-4c47-df92-08dcc067da39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fy1xlJGe+VjMTa7HoVa9Vds2x9JhBQMeW7WRqBFPEf1/BThvdgyeZT/KbyAI?=
 =?us-ascii?Q?Jg4bXpGkIAaVXrG/PClWs4QngXtKaHDZgfV52KmWoK0OLsV/Bb+McUnWITRT?=
 =?us-ascii?Q?E5sPfW2spzA4AuSKaCUwGUJ+nodakVdftrl+7HZPhsVCmSOJ6A2617bdz1q0?=
 =?us-ascii?Q?VbO+q+hJcyvOBp6/ZqAPyoeHIOF7z9Uy8JOPHhvmqpk3AfsYMfVx2pF1iJrQ?=
 =?us-ascii?Q?NVUjfwTfx/qb428N4wpq6/3RJMwPiUnJkws/wN3PebYfMdUyj7f1XF2ICKiK?=
 =?us-ascii?Q?0/yFSb8v9qSFJFPqGc7n7Bl/LN5Wc5bLa9tI3P/hPbMEii3OXTiA1z/llUp+?=
 =?us-ascii?Q?16hlnCmNqyJrkZofObAWiitv72OljcDh6dreCM/68VaGXqJhnudV0Jh/Ag0x?=
 =?us-ascii?Q?pANbDUJXwPm6ytE3QPHuzXTUJEhS2eb4hVGK1EqluZe1hoh4KwFSG/TfCJ1A?=
 =?us-ascii?Q?wt5d1l+ZbSCHCmAKr5prlCWKZQXMil13QCkBKGgF7ozz3Yt0YL6VThMUU4os?=
 =?us-ascii?Q?EXbQMKHXB5cB5UMjDPiECF+2vwBO4QBlWGdfJ0JFyh7Uy7JjT+pOGZdn7saF?=
 =?us-ascii?Q?PWJThWUYB2Zfj99uCaKMnNYUDfD6S2FvppC991xfoVi5PmbbFg9zU9Yfxj8i?=
 =?us-ascii?Q?boRKvwbYRCBlE0gOUy35tP8Dm6hjRGl8F8GXFfDRRY1XqPdNk51g/AgnodHs?=
 =?us-ascii?Q?VREYpIvnmncYVwPtsz0w44TXUutQY877d23BL77YSf5LYxefEXcPVBlWWwSI?=
 =?us-ascii?Q?uxntp+bFD/2TsUcpce+TMP3YaTJ9iToIIYvOUnE8u1YprznmrVCOS0m7vkYb?=
 =?us-ascii?Q?SBP+HLovLA8RmxZjE++if0erTSsXAylMujdO4+wjrLHRAVCjpOVRCZ8hoG89?=
 =?us-ascii?Q?mzrj1H84BLCoF88wsvFuuVSHmWmG5CiMzlImFM291bbR1Bgw8RlJw33MAK5f?=
 =?us-ascii?Q?6bK+qjVQDHboV1dDJXFBLA3Pk1NfqzYR8ng+I4CjcD3ZnWKSA9GO8pKseIb+?=
 =?us-ascii?Q?3Vi2pHwu346J2D7ZrSHcOxfxoeVQ028x0aS11yaCGDrOf8eXPcxvxa/F77TH?=
 =?us-ascii?Q?9CUPvoyFf5Wutz4rlQcn1wk3lVYACG0DkP7OQBNhpRJ9JRmM09rjnM58PlSC?=
 =?us-ascii?Q?J7FyyqSQjDVtNQxalvD8eoJDzkbFAzEmSm7s2Ra4s1EupD8i+xJCWaaAUPkE?=
 =?us-ascii?Q?P0SE1uZaJaBGumCiQJX0MngSvLi8KSDhE5EzPWV5DfsXQ7ilzjakmjASd7Dd?=
 =?us-ascii?Q?YADdFfGpdRAOmXQvmfQdx6RlQKByAvd4EYW0AIKiH1vgQNQ3rTzsel9T/MVv?=
 =?us-ascii?Q?kCs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O8P9fOUabWfBXlJoxNo5/rEg2mc+rKZe7mUIh5p1Ai4ZLHVwgrapBfgPiwo0?=
 =?us-ascii?Q?FbQSxoWEcutoxnKGwsC+pINx4uotpHKNrLcZgMUL074cdZeeBjbV5yBzIq/d?=
 =?us-ascii?Q?2dUUI8gNB/0LNLWX+WSTkLYxHDcQUvonidWc9SQSBlVjgZqyEEbfkADgygbe?=
 =?us-ascii?Q?w914++r1ssyWNgasrtQ8j+g4Xc1GNAWvYKif+ZKdDGaM1azvreO9lmYBW6oC?=
 =?us-ascii?Q?nmKzVB2IDLTxICF5iDTyX+iZS6tNL3gTHTdnwKHJPKYK6FosQFxwe0lGyGAP?=
 =?us-ascii?Q?EUW9fwORab7IrSQUAb+fQC8DVtEwnBNUA6NJIOUjyjEHXK6/govrq5uA2552?=
 =?us-ascii?Q?1VwVs7l+PgaouwXj25kBlQGZ+F//QH4Q6dGfi1Qb4FKwHMTacgB1CohUVpPp?=
 =?us-ascii?Q?eyIHMu+j8tRdrD0Lb2WOvEG3ZBXO4qMdp4i2ojq2c17iuWEPzzqxtKS3UbTJ?=
 =?us-ascii?Q?RgyJM6ax52OKVboxktztrC1QN54cRi96dH0EhvbK0H6VBZnNziDCSl3GkHKS?=
 =?us-ascii?Q?495kJ0jrD1UubhP98RQeyU+iaKy1m2IOQyr2Egm32OcPAiJlKRAFtsy0f9ss?=
 =?us-ascii?Q?knqcKa+Vf/k4GO8ev3HrcKCBUfuxoup0LKaIuynSWbnxnC8kgK8zSbak3W5Z?=
 =?us-ascii?Q?HQZzst+c7TsmDj8f5nWvTRaG/jJnkbE7Go6iRxOFIaxo5b1aS3AxQ7vmTCXg?=
 =?us-ascii?Q?f2JOIMwcVEyL16H4NLWxLtJSyqqa7/DQZDO+uJxm5qkOco3atackZPgrawgV?=
 =?us-ascii?Q?2wyw88bBY2QWPWQCG+PvyT2EbJiO91WgzdlaIRXqrUey/1YNrjiVKGg/knxV?=
 =?us-ascii?Q?Sun+iGiath7ubgRFsvWGK+3fSXSdw6V3heH6Mw2ZLXBvd5jP3yMqskNzlGcc?=
 =?us-ascii?Q?BEv6bKNOt8plkduNnaz6NlwAV7bA/JO+j3kS/RoHPE0U0HLqgShlWVE8bLkG?=
 =?us-ascii?Q?6fNIMF/6RPVBLPBBRS0jZvsppw0KXzxhC5909oOXYOiPScXbHeMUAGvYpath?=
 =?us-ascii?Q?woPJ0rz23mP9RA05rK9B5jgnH1SnsfZYSE7YNhX3qJSKzdFcPuOxWIqHQs9a?=
 =?us-ascii?Q?7b0vwzYFYYf9GmbKqGoQ9qhscekW0kFr7sUWEGx32Snt9g9wowhUKYEVwmeM?=
 =?us-ascii?Q?/mOAeEFetK60ztVVR0vmYWriNXDFqSTT7/LTVFKTd4Zjp03SXgMuMADPxAKd?=
 =?us-ascii?Q?5FFKrFZiyVGNqGt3LiHz0SKPW/qIU1Q2cYfri7tL7p1Z6JTCYGmrL7vsQWtC?=
 =?us-ascii?Q?2G1PBqGv0T6u1MiF42UvgIZonYC+H3Jx8+aktxz005BG4cHSJR5cnsh0+jpp?=
 =?us-ascii?Q?inl5tHXYN11GpZQ3eSGB2PnyuvFbhwTmyEAFbK0TZGftYpXyEH1txISbRujM?=
 =?us-ascii?Q?DzfJGUSMjC20ghYMoYXF4WehzvVzcDW04hPzKQsExjaDLP2bh8RSB4qwZkPf?=
 =?us-ascii?Q?CPE6UTLytod1kz36oPb5rRoDNmXTVRFam1BOH7yYzyiOP8Skl3nIn9Yzh6It?=
 =?us-ascii?Q?4Iz/ydCpSHPAwO8ZcRck4Bk8cWNorzCoTYCW/2BvQwu99VYbuO0ZK5bw+Qq1?=
 =?us-ascii?Q?mO1h7brBCOuwjs6OffJv9xlY0fBFhXYXXwcPQy1UWNDvf/GT4BL9kE5vBw99?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FsqSK4lRxpuw+V/IyRFZpfB/CmhwXL/UcLnl7wkhrEC/9EtmkBC7MtZLeIRzmFGDfCS+zevaJ2+pZX6sovxzqVEnRbmRNi5RB22+mSutF2n9H/nzYRaW0APsg4ca3izBX0c+D7yHbgVF5ugUoNg2CA2R1pO1wxpf7mWSXCN9VEsWFtseGYE3pT5FlLEq8C2JjW5TKQI8wH60ETN4krZiStrZ1rh3ZEyfSMgs2mg4sFvrr5OTvjR/3krt3XslQQ9dczCgwnE8oHUUryWvtTOFRozq8k7dxm8emMnEFiybNgMCCu0jqQepvTyZxPl0tZfOF+3fqv5q/1v5X/4WmUjSqDd3tDUKv4vgAQL+64FTgio2RrApeMn/unk65pskoeSBbTKF4eMMRekjKhUIiRYkLhH6tU++K8tnVP0aR7s3vSihko2i4xXa97W9WnTPeQ/lvqKPy9dDJmU60ksIf7RXmG2lRVJjgXTqr7NvQPC7YxK6nUHtwU5goGBXeZnmGHqSrWZry+7FOwDGOAlxma3a0avpHHEi7OgoYEHTpnMCVEtQoxfGRFDIELq74X1oxv6NV9rdL8AiHPxQFjLWzlIhQczAU/NrRrVaSQK5Ux5W1RQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683fb584-b44d-4c47-df92-08dcc067da39
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:59:05.7988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8wG2Q4urqechZgmFsbniWdn71vSXoLbH+fQ900aL2v+fQoB2WvozxNRAUYC8+aLe7JxxrtZhOLNzOkUhgNWg/vQviS+zAA0h2k/1ZJ200Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408190107
X-Proofpoint-ORIG-GUID: hfHFqGLb0AM9xBBV0FfsjE-CJsdDM9HD
X-Proofpoint-GUID: hfHFqGLb0AM9xBBV0FfsjE-CJsdDM9HD

The RPC_TASK_* constants are defined as macros, which means that most
kernel builds will not contain their definitions in the debuginfo.
However, it's quite useful for debuggers to be able to view the task
state constant and interpret it correctly. Conversion to an enum will
ensure the constants are present in debuginfo and can be interpreted by
debuggers without needing to hard-code them and track their changes.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Hi all,

For context, please see v1:
https://lore.kernel.org/linux-nfs/20240816220604.2688389-1-stephen.s.brennan@oracle.com/

 include/linux/sunrpc/sched.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 0c77ba488bbae..fec1e8a1570c3 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -151,13 +151,15 @@ struct rpc_task_setup {
 #define RPC_WAS_SENT(t)		((t)->tk_flags & RPC_TASK_SENT)
 #define RPC_IS_MOVEABLE(t)	((t)->tk_flags & RPC_TASK_MOVEABLE)
 
-#define RPC_TASK_RUNNING	0
-#define RPC_TASK_QUEUED		1
-#define RPC_TASK_ACTIVE		2
-#define RPC_TASK_NEED_XMIT	3
-#define RPC_TASK_NEED_RECV	4
-#define RPC_TASK_MSG_PIN_WAIT	5
-#define RPC_TASK_SIGNALLED	6
+enum {
+	RPC_TASK_RUNNING,
+	RPC_TASK_QUEUED,
+	RPC_TASK_ACTIVE,
+	RPC_TASK_NEED_XMIT,
+	RPC_TASK_NEED_RECV,
+	RPC_TASK_MSG_PIN_WAIT,
+	RPC_TASK_SIGNALLED,
+};
 
 #define rpc_test_and_set_running(t) \
 				test_and_set_bit(RPC_TASK_RUNNING, &(t)->tk_runstate)
-- 
2.43.5


