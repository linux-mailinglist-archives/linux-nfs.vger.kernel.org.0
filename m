Return-Path: <linux-nfs+bounces-8007-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097D89CF0F9
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 17:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9BF28C234
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8F51BD507;
	Fri, 15 Nov 2024 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XUSYFDhS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PpWwpVY3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3827F13BC0C;
	Fri, 15 Nov 2024 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686711; cv=fail; b=ETqq36JHRrZe/ArrhcBFpVeejedQqVVh6/bbpKxxLLThAWWLLfa3+M/esOABvbh2sEF9xsIrQROl4tsW85T6sNRLnWs4Bw6n2LwRLthr6RyMDDB30W1KwkSwm1rZ+F+evwOmBQZlt0rMBIFCuBuIPIDhyowtBaoNcvhiz6j/utg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686711; c=relaxed/simple;
	bh=LgP3sKAnHbVJPB5LYoQNNeEMHqrJop46dwUSjfIXHag=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=JH9/hyZrJ8EhPutOxobYxq+K+uEHoqi4FwvSgZKjCkeYrqinATLKV0tDNZ95FfsbIRwTL9t2PeWFufqKU7Cos8kB1fEVLB6UpmFbRnpUbJw5TRAl8dr9UEiJwjYybIHwTSauLXBa1JXFXZOzed9CFJ4gkUQomq/H5RKGudaFhZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XUSYFDhS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PpWwpVY3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDDLO1030597;
	Fri, 15 Nov 2024 16:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2023-11-20; bh=glz5n7+KcORMeA3TnUeD4wCbw6sxFoLJjXRX0Mcw2NQ=; b=
	XUSYFDhSu+6mYk1PN5N0zyMO/OG5IPANdAfeVy9RK9oDWwY0gGckhQLkQdKoqgRy
	jXCdlI0ZYh6aaJWsLyzzbe0uiczlsNiEdHwi3cX8uNHrqtCp755UoOjEaYCzFw+X
	CbtkM7kBmdWHcy/CoKHca3USnbm54a3fYhLNpd41cNAVMHEbW/5dG6QOjCv9E8cw
	apXdESd5ShM0r/0BKhPn7j50S9pPdjRkg24MCvbscVbbk5Kc7u6ks8ZEpWBYrmN7
	B5bQv5EsRqDvYwrxBk4R+LLCGWpKfposhSqXcg0nTs2XyZNjumNGhr7Nar3556jr
	rBtmXEnE2nYOBiC8MiKolw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwuqxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 16:05:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFFAng4000346;
	Fri, 15 Nov 2024 16:05:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpbsmq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 16:05:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZ/gf3nwT+NPh5aLiFp00LvnKxu24hSBF2zQmjviuAFzp1qPDtqDmJIb8IdZUktAZONVQG/D1JmhtAbLCxfLujDStXljeLqsdZPT/Rh8XmqlRicKkVnWJiXoFQuBDG2qP56VbVWvteGLkHldrWOBHeZN2bRY65O/Uo1yRf9UgYqLPdtF1b/QhxcpKAVx/MQvP5PTt5UvDmCr0moi7CcWCpxnMzr3FxfLeKvoPaY9jP3aqliUp0t/phi+BoL4ekr28wEW8sPemPB6FjodKulcgcd8Jx6iqPFZtHrxxeAE4Az2uN8+02SzPUslIfDJzJagu/aauogDd/o+68eitGz+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glz5n7+KcORMeA3TnUeD4wCbw6sxFoLJjXRX0Mcw2NQ=;
 b=w5MZQpJyqVHIyfABL5iFFh5OaNLVMf2L4zUPUhJlRD3eF2a6ZZerlJajsRCE9UOOTk2izuQnPCd+LhPsgXv7ivJrmuRTmxsf7FuleZM5OLW4lsRIAAUXJDVMRZdJ+XFAoT0hcdqdJr1rAVf5vXLL65r6kBQjUmtU/Nj9DI1TVjiOf7bE1brPArmLDWfWzOaTGFC2gtW84KCZWdkj7744z/o3F/EpUEvKJlE7ZVLB4KXcwxFNYMwhIkjDeQOrMvv4lBubOhUzsLZRApoaC/VoKa5R2NtDJ5PDpdrZDrgqrWmczpp0Yz2mV2h87xe6KhjuQOP6AR55EpwPTBvWVh/XcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glz5n7+KcORMeA3TnUeD4wCbw6sxFoLJjXRX0Mcw2NQ=;
 b=PpWwpVY3j08enJ7eh1j7sKlixVMmONx0Fe4+gjrjhoyDel9IePz73hwVkxIiDOt4UuSl1fBKn1phwN9fguh9DDGiQPWRMPW4SH5vccMiK5rD8aCpQqK9T2jjIrnYfjvUXSxKVGuwhFa5REfAwivjQ4B46dAVryTg3pPiH0Df89g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8185.namprd10.prod.outlook.com (2603:10b6:208:509::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 16:05:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 16:05:01 +0000
Date: Fri, 15 Nov 2024 11:04:56 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: akpm@linux-foundation.org, aha310510@gmail.com
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
        linux-nfs@vger.kernel.org, hughd@google.com, yuzhao@google.com
Subject: tmpfs hang after v6.12-rc6
Message-ID: <ZzdxKF39VEmXSSyN@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9cac7e-06ae-4adc-85a5-08dd058f426e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GFOJLaE11o5oiQGm1CYpGfkhUhgCxXhknO0sjZg9ehcjeHLnCUzCYvKzmWQZ?=
 =?us-ascii?Q?KJ2Hvvg+VydtAtLFdxNzsvoMMZQDZWVoHoDBFW7V/DOouHE8uzuJB1ciqY/5?=
 =?us-ascii?Q?O+L+iv0cAYCHCTMa0O675xIMGyoCSb0grPs4IYQ3yPzu+WsVmS6AT9IZrw4N?=
 =?us-ascii?Q?hSYxMcmTUkX4ccXoQCgHSCKBOhxjSK1xWhUtpb2YHg7nw/0FvzPi5h0BPZR8?=
 =?us-ascii?Q?3BnGDUlhe+kW+ZwmSqpTZhJKviur8rZW6AdcjXrWTNXTCcyZsI2XLJFbnyVL?=
 =?us-ascii?Q?jqVNS2ysStjHPlc5hPpBFks7kM+ZFAtnSmD6s7e/CVbpgVR7zl/vAUSzk3w1?=
 =?us-ascii?Q?ZKZ552W2bAuKB9/kYwo5mmdjx/uhyUO/lkeU6TKSOpHswpMyPKUTlR+hBoWm?=
 =?us-ascii?Q?Zd7YqEgqD5cbpmTwt/nPzTWsfI6XMC2SBNu73l8yEFJJSU1BZ9l5AL72hToT?=
 =?us-ascii?Q?2bSeHX0jVUC7uDg9xH5Ouw5+WAgPyacf60njbAL2plMKQNa8q35EteP4KPqH?=
 =?us-ascii?Q?swNrc4F0ep+W5nVAD5HCfi0LuASr3wHMRJQ5qvnAs5sD+UAF9YKaq4o2cm1f?=
 =?us-ascii?Q?J+7b5Dl7f9aR1H3q3yDCLLmRTvhH1Bqw8zMIAGtuDSopSA1wENMJLb+q9DnQ?=
 =?us-ascii?Q?NrF2yItPO2gx4RWo+CCsnESqMLtJYZC3wCpVGV3kaEdxtiQXXxysdTtNqSJ2?=
 =?us-ascii?Q?qWJc+363LXpI1TrJ2XFInYy/vAMJ0nTaockBYOO2waAb2sDk8FrGbOFDNoPF?=
 =?us-ascii?Q?fUpwp6GU5eF9aXvqztdCERmmmYBdxr+sP0de6IMaAsBvtCC0J22ZnpldwTPc?=
 =?us-ascii?Q?HfwH7gLgkR/tRfG/vk77Jgjja81rKCNy1HbGuN9xAO9HFZKBb/RNcNejWLKs?=
 =?us-ascii?Q?XNNayjouRDwRRWUOFHD7sIaHJXAtTHsZDS4bNZ7ceAJFia7pX0YsLFbTKHII?=
 =?us-ascii?Q?QNDmKpcIuGSZYEs+o/eQSZba9Z7TFkci9/MKGljAwYBJdIIF3duDC3tYFXgg?=
 =?us-ascii?Q?GeKQsug53fBFh8P6qZZt74zmaAFu7Kqt376XINIoMvtRkCHRKn5z3ANQK9NH?=
 =?us-ascii?Q?Ffzks16sI8inhd1RJo8aORBKcrTPlEiB3LxURP5uZ7u+kX32hqEgaHA2wXNi?=
 =?us-ascii?Q?LV2UXDyWZqQXdPZHtw5DIGmyHAYuVPGpRDiB3voufPIirWopNuGX4gfk0p53?=
 =?us-ascii?Q?zbVrX+tZDbPooXI8iN8sOz2R1JnGw0ZHH9A3vM5d8e643xEYYeydMb+FhDbO?=
 =?us-ascii?Q?cGVCTelZ6BlVonQEEejohct/kZnNYy5jcahNGl2JnXcJGyhNEZny1alzhPla?=
 =?us-ascii?Q?5ylj5ah7D+TC7LF+1Qf4SK7f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iTJhut1HVqK3BadIYnYOQbatWS1neLKyx38nmR0KXKPucaIa79pxdAahiZ31?=
 =?us-ascii?Q?o+TGVyO/QluOYxvqhKenlQ/VhJI6iaBu+nXDPctGBM5+mgXwvpMt/K2LsVUv?=
 =?us-ascii?Q?nZSAGKVmAb86N2m5YpDj/S5yMITbNGb7QVcMinkaNX42IBgplObEUyBl0QSq?=
 =?us-ascii?Q?Wavf5sFDb2SKmQ4ENpNQtkK0S5gP1yNIrfL3QaQYAB8h+nf7Z3f8/kXU5d7H?=
 =?us-ascii?Q?7Os6F2MxYgWG3Ghf/8ieDK336EUzc/3Gg2k3G4PYj8F6qAzJoMs3freDRfue?=
 =?us-ascii?Q?cuBvnXfXGhkkBThoGZKfXO064/XG/6gnfA6rxYT8IP8EVVQEobMzbtHRVadA?=
 =?us-ascii?Q?idGO5NW2aUs9t1FkrBR0EOtRbX4D7rddkc++VBqzTLJ3TG1bo9BDMmn3Y9Gp?=
 =?us-ascii?Q?3Mi4s8YkgDy7qt7njsK/o2DL273HFCxdLggomZvXcvfa5pxnBhFwiOO5NjL2?=
 =?us-ascii?Q?gyZWzZBSYIFXsTCz6NdpSzmy4eHLXIAoYI2GIhaWHk/iIm4ys83qAdceyk/y?=
 =?us-ascii?Q?VsZKzG9/Yseojroglo+GVBjWCTxVPX/LXAje3cwrors6Vt/aDNnGa40DsrHY?=
 =?us-ascii?Q?OieQ3yjRuVkiGrZLxJCInQzaXyRppGfUsYNhNNg7G0aLP59BUtOdKkevMzIl?=
 =?us-ascii?Q?ZD4fIM1RLXJnkLpoKJIpxTBVjz0kZ1kD9dNJkpX6AyiNRddlYBFDxE3LplOU?=
 =?us-ascii?Q?g8+dsFE7AgMm7aO8af4o2cXjhrXpegse40+21Mhc+U/pftLLd5rw9YxLjWLQ?=
 =?us-ascii?Q?l91zD4utmwJIbk5RLXinjrDSdA5tqWG8mRp6PPSZ6gaENwU7eeEQpkZGB97s?=
 =?us-ascii?Q?Mm1s9Xr1yLTrh1Jnhrsj84tNQg345IBDK8rzxxvT16KjxVuZQPftHtY9G642?=
 =?us-ascii?Q?tQaijAAz3mbfXi60o0VjyCjVb4GoYihUeyzM6CaLWmjXVnEsIeiGQqsFBMSV?=
 =?us-ascii?Q?i8RxzVseDWRAldy+c2XAVtLxzbci7myBHV0dNqYMyFRz9dR+dTXQb9sGZg2G?=
 =?us-ascii?Q?VL7/KyeJd+X9WA+o4TDC08Iu5T+hZ5KSntZxceqfvfWEFS/yBN07n4mE9b/J?=
 =?us-ascii?Q?sxnNaXQY9dhxgTQEtO5BOvIs31Wb6Ii69LkNva3/rZoyEEMO/YIPt8+HwNbK?=
 =?us-ascii?Q?NST+rra9XF2HfWc1h0qk+Fqo+obptIuhOwx4LzfmYDZGYWN1L6hv/LKMKbzk?=
 =?us-ascii?Q?Qbsh2GkDa1HUWvXBQnr3+WelN+1cYyavdMLLRxQsMAnTg3SqXbhENxCnKJ0/?=
 =?us-ascii?Q?Pg0ycdL+JPiLqSlDoasX3FtPjlja3J1LeW0p/KqTX/OXTIaQ6A16tGGsk3k8?=
 =?us-ascii?Q?EPfyYbUx1GrfafCOVZhRrh9zHb2HKbv8wWWmIjABMy113mnuyS4qTnyCm0RD?=
 =?us-ascii?Q?8wOGCGRTL1ucA43KS+8ZYk9EnS41CpNs5sQ5/Yq6aQ7dT1RiL+dmZ+wFbDdX?=
 =?us-ascii?Q?UcvHkb58SMn86tHrSBuxINtCrH12fO9nk/qQpPVICH8SoFSqeHpsi4QCOSoR?=
 =?us-ascii?Q?COwF23nH4n7pdpAJ06U8wxUPZkrLPotvDgjcYplB4Z8rdKsQH8/rx/Ddhwvg?=
 =?us-ascii?Q?BZubozFmryBrPD4rcq5JRLNF3MiwgH+uB9YNZUNM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	81opOaePO72oMnU1pvcMOC8t7N6fFgM5RlVPCqFNILAwcd97khHM7mLIuFm2oIPA0YMkoQA+rUpDGbR8OvLa8lodNGion4LxT8vUmWqVcGgi+GLH/6bjsV7IypmAUC2pJ8r8BCtJof6mG9trDFldBm1vGKWuxzTIcPjM25abvR1mOLQKZAxigxkERGotPn08lGLyf3KTuq2sl3ucLvZtVt/2L9ivKOgVichzWE0ZhdLczFZPBeALAQ/K6XN3wKCLDsC90O+TqEi+J6170XwjHBxSCJNshy0WAfGM+u6n/v1dtV0QQ79bVDdaGLJdq1urwltEFBOB5DlnlREJ9+YEnyCdftFj4Hj8tiN0cdOgT9o/hy5/fbhknRxBwcd8NueMWnA+QiJMLB7PISfvoXVcqT5UpFTefGiH3JxDzb8JdwALFqmrGWRgtIeqKi3kwkcjptr38+Q2moN/W2OFe/JD4tn2WDCJnaW557doxc6c4Hl0EiHYdeInkJb+Ak0XaLYcmqJhZ/uTM6czCqSFbqEvMT0V2mx7PkjTah0F8Qsj2zHVZ4c1b4ShXXpA+Vhg0qUm3hox3assFbLV3HNns35nNiTXgv02lZeGs/NWsi2s2xo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9cac7e-06ae-4adc-85a5-08dd058f426e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 16:05:01.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXtmmvj/XqtW/Z4+u//I2xCLkpQ6TWQGzDtAP53wh1zWo8d5Ima1wsfHpwEJ7ff56IPKE/X1Di78+dkqOwEK0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-15_01,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=868 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150136
X-Proofpoint-GUID: D2DQWVwQT9iAzlahQTONmmEU79yHaLSb
X-Proofpoint-ORIG-GUID: D2DQWVwQT9iAzlahQTONmmEU79yHaLSb

I've found that NFS access to an exported tmpfs file system hangs
indefinitely when the client first performs a GETATTR. The hanging
nfsd thread is waiting for the inode lock in shmem_getattr():

task:nfsd            state:D stack:0     pid:1775  tgid:1775  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 __schedule+0x770/0x7b0
 schedule+0x33/0x50
 schedule_preempt_disabled+0x19/0x30
 rwsem_down_read_slowpath+0x206/0x230
 down_read+0x3f/0x60
 shmem_getattr+0x84/0xf0
 vfs_getattr_nosec+0x9e/0xc0
 vfs_getattr+0x49/0x50
 fh_getattr+0x43/0x50 [nfsd]
 fh_fill_pre_attrs+0x4e/0xd0 [nfsd]
 nfsd4_open+0x51f/0x910 [nfsd]
 nfsd4_proc_compound+0x492/0x5d0 [nfsd]
 nfsd_dispatch+0x117/0x1f0 [nfsd]
 svc_process_common+0x3b2/0x5e0 [sunrpc]
 ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
 svc_process+0xcf/0x130 [sunrpc]
 svc_recv+0x64e/0x750 [sunrpc]
 ? __wake_up_bit+0x4b/0x60
 ? __pfx_nfsd+0x10/0x10 [nfsd]
 nfsd+0xc6/0xf0 [nfsd]
 kthread+0xed/0x100
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2e/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

I bisected the problem to:

d949d1d14fa281ace388b1de978e8f2cd52875cf is the first bad commit
commit d949d1d14fa281ace388b1de978e8f2cd52875cf
Author:     Jeongjun Park <aha310510@gmail.com>
AuthorDate: Mon Sep 9 21:35:58 2024 +0900
Commit:     Andrew Morton <akpm@linux-foundation.org>
CommitDate: Mon Oct 28 21:40:39 2024 -0700

    mm: shmem: fix data-race in shmem_getattr()

...

    Link: https://lkml.kernel.org/r/20240909123558.70229-1-aha310510@gmail.com
    Fixes: 44a30220bc0a ("shmem: recalculate file inode when fstat")
    Signed-off-by: Jeongjun Park <aha310510@gmail.com>
    Reported-by: syzbot <syzkaller@googlegroup.com>
    Cc: Hugh Dickins <hughd@google.com>
    Cc: Yu Zhao <yuzhao@google.com>
    Cc: <stable@vger.kernel.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

which first appeared in v6.12-rc6, and adds the line that is waiting
on the inode lock when my NFS server hangs.

I haven't yet found the process that is holding the inode lock for
this inode.

Because this commit addresses only a KCSAN splat that has been
present since v4.3, and does not address a reported behavioral
issue, I respectfully request that this commit be reverted
immediately so that it does not appear in v6.12 final.
Troubleshooting and testing should continue until a fix to the KCSAN
issue can be found that does not deadlock NFS exports of tmpfs.


-- 
Chuck Lever

