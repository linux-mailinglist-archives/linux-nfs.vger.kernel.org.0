Return-Path: <linux-nfs+bounces-3037-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601E48B37EB
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 15:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8122D1C223F6
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 13:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EF0145B21;
	Fri, 26 Apr 2024 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ehLac7o+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q6+vCuQs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8572A1422C6
	for <linux-nfs@vger.kernel.org>; Fri, 26 Apr 2024 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136592; cv=fail; b=nLXJqISNWfoLRl75B6AWuYgGbeRsTfjGNJbPGEOGEQX8ZX6iCem3hu1nvQYVM2HKzMyxBj5euF4yzCVHhkq2z2YH0agNfQKAlYLE6SWjEj13XCbilqW9oOkXpA6MCCUCQwWz5ZKo5Bv0CTo2MFwcBwZDgwoeLEXSr5E8Y+cHhe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136592; c=relaxed/simple;
	bh=6x/3U8kGCmczY+OL4/g4qA6vbr2HdfSkVBdQGvs5l8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iG3ofnNtLpoUAtj8x59bEd3flDiRyDPT2DWWR9MkhW6T7DXVWqdJuaQi5Ybw109rpu3GEkl4UO/jDX0+oCJN449BeyBtJWgOMlOqkCy5Fv3YTsaiV539p7VtYkGYstbRsQ2KqiVH3t0VUD7Ke5f6xOLeK30Xef448Vm1Dekeclw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ehLac7o+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q6+vCuQs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q8TkcB008300;
	Fri, 26 Apr 2024 13:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=CseDfCCUXVHQyJamfvx30WEZYmeN9FZDjHYB+GvRkbo=;
 b=ehLac7o+cygZCm5fe0b8yw3Ng8JhEZpmekDruOWHlzc1zb5icUgDXUDuM9/lBU/4rLm8
 OxFCtVd8A955QEeOkPg1KgM2iYMpJ73hp3dEtL1FUJOBWC57itVFEhiqvGtJbjW7RGiK
 uWg3GWTdKnMoBMaEojHiDhsUYaL4GJkvnpfAF/7h3q6gAM4LJ8GC1NUPjgqpEeo8J/ck
 FBO8VIbnmPughq18Yi5h4fbhWgMwS/BKQEKngNrGg2cgASiYFeZtlf/o0UK34Fi7jAb9
 KIwr415VyaTVtvc4lQETo/IkHP+UKiqBIwazygDGVnB9CCBprGchy7qRZ6ln+T7YR+tG 6A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbwtb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 13:02:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43QABJEf035637;
	Fri, 26 Apr 2024 13:02:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45bn2f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 13:02:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SW21vz9epFXgeBO2a+51+g8RJzakpf+VXmErHLkbDX1RHnlqf9diYeuBGbnp7ujACBHpbdVegA+u2QxRhzS6Zntcbc2TfNQFFAg01laQEY0r0nNaiyU6ZuNMnPtayn66pEBm3TrqzPAs8Qnvp0V8+oLRnLSLZ5ScRsPVxDmRvS6eP52kAH6DO/wDs+ObxUDSAkoqCijhvS/dc5rqiClaqWkOOuyEwhZLC4xpYVUOioTUCf15/mEHyjrmLRt+oswKZoT8JSYxftPK8T4rLoLvBTKMnYG+9kTZR81w2CPZh2xu2xoVwMHojQGjkrHw+AD7gjjvGr0fP9rJmfMvgzfQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CseDfCCUXVHQyJamfvx30WEZYmeN9FZDjHYB+GvRkbo=;
 b=bUzCQnsQc8SnNH/4JNXA76kn4iuWGxRzRzrwzMrCaCekWzCmaj9m1kdRZX52SN+eXggQnashw9xP9I3k9zKP9bcg13e0PYX9okMYiWsHPMGvxir9wsj41yfpHHdIf56PuPjYfA3yY2Z/WYMV7vIC3kzD4f+TjQrrHyJ2lZZ/pdROCHL4Z+as4iOPl/TSxWi2JHTcnhSDCBoFj1zyZdlEZzWiLpEI+Jx0o87bro7aAsL5QCH6L8PqjvEWropgA0TYmPYmu4wogZbPo1rDiyFPOf0QjL5hkU9lOcjGGjwH5Wo0Im52SUzjH3j2HIJBYaouDwy52qN4QunwUKGtRvwzhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CseDfCCUXVHQyJamfvx30WEZYmeN9FZDjHYB+GvRkbo=;
 b=Q6+vCuQswc+uFPd6vVmFgUOaDBOC1JcB8EtP8rj9ZLfW9WKVKKuM9MLZC1zIu/OIQyCOwboRhSBevlo78g6jlRSu+ApRxckn/X4I3i7vEzmlyFUJvvjHi55TdBNMOdz7KsIxOrsT3CtPKfaQUMg24fp6yEKxM07yQmt9CQA2cvw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4408.namprd10.prod.outlook.com (2603:10b6:510:39::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 13:02:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 13:02:52 +0000
Date: Fri, 26 Apr 2024 09:02:49 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Remove comment for sp_lock
Message-ID: <Ziul+ayuzihVx67v@tissot.1015granger.net>
References: <20240426034750.26945-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426034750.26945-1-guoqing.jiang@linux.dev>
X-ClientProxiedBy: CH0PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:610:e7::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e2d1c4-ed7a-4796-af21-08dc65f12e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vwrjCGxto4gjI71MlZOxINN/5DZJB06imLGl7VR1CeHr6vCyh7rx3vSjHM2C?=
 =?us-ascii?Q?cCshpZd+Cqhye6fOMRq5yni7FIpxMZPgKydrRXF7vul2ke8BOFsCmko8G+GH?=
 =?us-ascii?Q?3cmtmXYOxDBSrnIZCyLa62cVqrVMObfKMBXwyb+wd2ELH8ga+UT/Z8zz9Ut1?=
 =?us-ascii?Q?2T2EiM8cMExn9Mq+hN6ckeGgNEoTebBKxQvcELzgE+kFyexnQX1eOEvWvmSG?=
 =?us-ascii?Q?VDiyBmV5ev7aBLVUOef0FrBGDnPwvd54O+dkJlso4kTuiX68x0h1mbm1gh6M?=
 =?us-ascii?Q?nC4mwAU50AZvucm+7kr+lMHvVpN5m5jsH2ZvSFwWUGJby5MINRCqs8YlqUBD?=
 =?us-ascii?Q?nSiaqLS4Nzn3YjhvH4qQxpa43Jwoy7yPtr67XWN6lJoBQAbcj9YORKk2ImOi?=
 =?us-ascii?Q?upD/NR+UD/pvCY8RtcKm9zJSnphDaCOVXp+Z0XM7ZuthXq5VGmaKEKt4rxbG?=
 =?us-ascii?Q?/iU75hBDo8dqTxesE11IxJA0IoWdb/f8IK5ol+951M7asQHYbZYU7as4rXOm?=
 =?us-ascii?Q?kIlgJ4iOPgrTFkPZjW1JTn4ZUAE0uGXI4Vl29o1iTDnnSdzyxvIvO5kQPxNc?=
 =?us-ascii?Q?oRNJg85oGg4OpZlYbmxEmltsGPlW+qaDgC9kspZfSdBDY91SeiFKKMJu7yAm?=
 =?us-ascii?Q?KMDTK7aNuopYcIuFUnSsBwx69mhe73xKvfOeekXEQnyvHiWtIEn7oxqGiGRH?=
 =?us-ascii?Q?rzbWQfBhEcXOG8/l1vh/6OrYSaFvXDD3P0zUTsfe+55e7LeMWIABP/NHxGZ7?=
 =?us-ascii?Q?/yEl1fBCJrYl12+xM75zOS0wa7D5hekMbCikJ7cKDW8KeQAtnnUrDH0wDBDf?=
 =?us-ascii?Q?lm0kg+cJ8uC+Z16udIJajDxFIQYgFkpLsLeePsJy5vN7vXLjMvXd5hB2Q1OX?=
 =?us-ascii?Q?Y49mQnP4zZY02aK+UNVvu1myUVvNlt+B8NUk40BY8sZh+aqKBehFfnJ/VAv3?=
 =?us-ascii?Q?7SWLp1Unc9+zlkDEP9Pukxl3nRiWOX8nQqQ2IloAnHVHE0qoK4AEhOSdeBBO?=
 =?us-ascii?Q?uSVgZsxxvXXroBpths07Y0pFVhU2Q1od4fIaYZgg87FxiNe+xdTri5/d96Yw?=
 =?us-ascii?Q?mGEQ5ol8/NsQzlw2ZHquldp/dwLO/GOSVB9MudLjK/2SCerJ/zZjATyPHeFd?=
 =?us-ascii?Q?FoC2SMINHvQ3MSZPw2nMwnx+kV8ESHG2HTCt5TC7j1pg/U6SAPytkSmItGMG?=
 =?us-ascii?Q?msWEXUC531WO0JajxHwm7mL4euB/uWxk+cQHy04pUzC/OBnYaGzj4c1sr0jb?=
 =?us-ascii?Q?M4tnRVY2WFDY0WjmTw1yVw4nwWUtJDEX1EL5atbBFw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8y6NtDml6vK80TLVt2+yg/Fr9Vsns2s7m93onEUyImQVcYIhSAw9zL4yoX3f?=
 =?us-ascii?Q?Hi6MTZ3uQ2xQtseD41X1k2GAmdQddgpMZpMRpc9wyI2xLZY4022KTtqXaUVX?=
 =?us-ascii?Q?2iU29CqYkYGoDGjnLLuWk7eKkKwT0FloYyGcNtv7OE+Ft7juaLvHyBNw55HA?=
 =?us-ascii?Q?S9REBE22F0WoD8GcpRBD9yN8G+ZAb/kvl0a9WeLTO5myPranzBQLxN4uclUA?=
 =?us-ascii?Q?MMjsHTnW2GkT+ItkUIW+DzTy+kQkQiVk3Dg6sFzsLXOEzsWwHHJgj8CYomtA?=
 =?us-ascii?Q?IOV4izEByQFkdW3ygkZpJHAhwpnucXUXDp7wNSFbwtJAe/p7TyAFRztMHfb4?=
 =?us-ascii?Q?KLH5ypBk1Z0qGDy1WUgHAGkgxzwQMhYHfhYWhhZrZV0CKFM+ma6MtpN+Mqw1?=
 =?us-ascii?Q?exn1K8Txa1lQhf+e+kykXVoCr2AQSw8IrPeUW781igc13EfdUGWZsyoHM/wT?=
 =?us-ascii?Q?S8+LRI1BXVgbXJSuYwCnHwqGRBuD8ZLP9HN7TAElwumrzOOXDxB/LE4fSgqo?=
 =?us-ascii?Q?J2uybQSMcJdYo+CTb74nluCpY0gFc6QoMnEWOFa6dovRw2RgYpJX87gHzR6f?=
 =?us-ascii?Q?DEniCIwrGqeKm+Wb+/YNIeXxIhUnPs1xjZrjO9VQhC1zlYuMDD0EZZyL3xQG?=
 =?us-ascii?Q?mrulmBdeGRp9ty77maB7S66Qob/3XtPu6UcXSQuRD1U4JT6FBDEk4Var2FiH?=
 =?us-ascii?Q?zeFoM4AP0ccGC8Wl7IEdi10V/RBJDfwOW2wXRLqOuw9H5gcr2YEjiLJyjC7f?=
 =?us-ascii?Q?bHckCs/WWhWzxUjvSY4Prra5irGYU2pu1+add5eqgbYP5aYltonXSfnB0RZi?=
 =?us-ascii?Q?LHfIarZ4Qzr67Gy2gEhNEga+JOYdPElV1GpMC4bdsIi6bc5+045++s+tQuUG?=
 =?us-ascii?Q?bqtOgunZZtbEeMLUwiPy2U+TaBd0GUDSwVApcHaTP0TXIx6hVBkS1DQ+OWnw?=
 =?us-ascii?Q?RwLZMFEJKGy3IFDqA0Z08TL38gz/MIsxK35KvEudzdFA9F2YXIjVWo3isBkl?=
 =?us-ascii?Q?9bxir2rqWrfL9Ppszqp0ktr7yN3Mkzmvssmpf/4ru3hml0432BvoZvRxktAH?=
 =?us-ascii?Q?Y0MeQqB31l3VMPE2EYrGU2+u/r5otwxeSrJVXYrEpe/6pdjKfGuzEF+9rFQ+?=
 =?us-ascii?Q?RmIo0SddneslTYakVRrvUFMemvAHaugDlR1c2OnSn2Y0N8jOx/US9r6h59pl?=
 =?us-ascii?Q?yhLYoPcL7MivmioWStIUPc6zEeF4aLpGRDXeraPvU40O1Sf/NpgGgW0Pt3ah?=
 =?us-ascii?Q?x3R6g2zTXEEr+0+hf7Q2Xx8qiVqlciAMKLOn6LMZxhwRvD8+khqCmOnBuVtz?=
 =?us-ascii?Q?AOrZLpkWEeKOsKFndEuhcI9KK94kTinw93ybIWRiLtBqoazQ+0lwwed7++0x?=
 =?us-ascii?Q?JFGy0j12DboZeojxcu7BWguEYVIsF0jGmwLWubNZn/tOqDQ6I4E1FJzKeCiU?=
 =?us-ascii?Q?0rr+Ww3bBboUtyJvzMc6nfNan3ihl2H2Gu8bn2HAqxTxfT3JYJXWggpfNsCq?=
 =?us-ascii?Q?nyqP+ZrCxrAvvacykkhDUyZ/MbuLlKKcUpp46EsHjP6aPlftSE1Izm4Zh8Ng?=
 =?us-ascii?Q?Gwcq00q2v6/uz1PjsilzpXH41yo4/o+2vzER72adEEwG7AhmdpFl7JqwDvRB?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	R9Qi3qTmouCnqgpv6R1gOMFMr4/1e7cgXVcDVrcDT9kDva5zWeLcMiusp5+Pu+KJiqH7Cjsp0BlGYZo5KPCVJXQ/AjBMxlMoiW7LqP6hveJObg/5xGgoRENS29Xi6r09S0zQccdR/NmaHXrpuEpe597xPOT9FMJSjGh7AwD5aJLjL2GJT3UcuAQwAeUgeQMZmFxaEFO6QC5pyA6wzdj/BNGv4b+norH9tWo9W71tjo8wK/PzbG3UmLAxWKTwrCNlqS5J0MtPs9p2/ydyxVEEQGfZsXvpfG9/i6aKb9S04d7OCIY6+SVzT7KD/CH1inUJGgNANKiwQwel6N7q1ujEVoQ8QUW0YpkIZ/GsjpApcTxGYWJK6yLhtcDAWRSStOjA9K7t/FvCdQyTQku6+W3o8U3/iKBm9HNltfHP1UUs5y+rw2651meQXzYU+um/ClwUWbWyxRBcE86fpj64xBTrn/RIhYWYnX18ZR4zzVOozG1/rIbIFmTDey7uIeG1KtMZBDh1IQnETmEmMDxEMBu/HaOaq5KeVXsxejOGVRHHCWeSg3bXlB/e6LCeAkn30avOEVymfhh2UbbdymXcAIoKSioTx6zown78DRp2zyAz8+k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e2d1c4-ed7a-4796-af21-08dc65f12e5e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:02:52.0863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: retzKSrRSZCbGSsUhBZ7jCDc/H4kA9QMcCnHQispYPOrHCxzndAHUOOowTIKPWe0Nym4d8PM52E50qPZY9y1xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4408
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=903
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260086
X-Proofpoint-GUID: NeKsoGiLazaajRWuSZJ8Hha3UHoi-WBF
X-Proofpoint-ORIG-GUID: NeKsoGiLazaajRWuSZJ8Hha3UHoi-WBF

On Fri, Apr 26, 2024 at 11:47:50AM +0800, Guoqing Jiang wrote:
> It is obsolete since sp_lock was discarded in commit 580a25756a9f
> ("SUNRPC: discard sp_lock").
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  net/sunrpc/svc_xprt.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index b4a85a227bd7..ec78c277a02e 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -46,7 +46,6 @@ static LIST_HEAD(svc_xprt_class_list);
>  
>  /* SMP locking strategy:
>   *
> - *	svc_pool->sp_lock protects most of the fields of that pool.
>   *	svc_serv->sv_lock protects sv_tempsocks, sv_permsocks, sv_tmpcnt.
>   *	when both need to be taken (rare), svc_serv->sv_lock is first.
>   *	The "service mutex" protects svc_serv->sv_nrthread.
> -- 
> 2.35.3
> 

Applied to nfsd-next (for 6.10). Thank you!


-- 
Chuck Lever

