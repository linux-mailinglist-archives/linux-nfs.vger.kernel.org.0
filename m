Return-Path: <linux-nfs+bounces-7392-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4489ACE33
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 17:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB4A1C21C5F
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 15:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A776A1CF2A9;
	Wed, 23 Oct 2024 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CpVaHOQQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LmtVdYZ/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23C51CF2A1
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695850; cv=fail; b=qjEk78vtJMbCEpLeib03C6uYcG9T6zqQ6gc1zf4y1F8q3qAvpEUWz7bhzGohpwn81G/GoQRIoFXdiTW/PdkwkWdLQU23pV1CL2hkI3tN7fycRYKmqnIpRKIHMcITsAvSlQ0CbjYgi8wCmvCLPFIbyO0D61S9u3m+gCvQPNCu9AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695850; c=relaxed/simple;
	bh=e+P1QfbNYddp+jj8xnXEinCjbqCGMwR4hoq5fESelRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F5Ap1hMSZ9tO8aUIb/sZ3J5jA2JN/SHL+cgIAoYUE3Z2nO1cmNJwE4bxg0SnVpOdwVNbH6ygDXPRLeU6IDCbsZFWZsdETfiX6owT08OHVaRXySgvKqtkVRkvpXpZ2GkYuYnzMtSvy4EPzVTfCzmjoxapjPx4PFGi5mmf1u10CDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CpVaHOQQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LmtVdYZ/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NF0dnr024097;
	Wed, 23 Oct 2024 15:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Vm79W9pfEsMfAYm0Yv
	IWQhTvxDb1wzOCEJj2YEHyFfI=; b=CpVaHOQQLIVa65d5kjCmxZ6zEynGpxh4d3
	/HNbCZYZ4jy+9V1mXjF6sgOS0LJ+YoarGzCLVT0ymzMB46FWiAeNsEUsVOC520Zs
	hv+5Qsy3FdYHTxW+B07WG7/OH9JcaBcqGlq2beHXu5v3M3S7QMjxX0YC0ACbOsoE
	SJ0wnHeM6UX985yRPqsU6DKXsM/PBGyY7z67G4qOcuNCtIOxyrRVPj73pnFpHO0M
	TRsMZ3Y6S+YLEoFihlkNDNJEs16s9BtQF9II/Dmr8OQ1de0cLseb2ohjkbDGFQ8s
	isxs2a8fGBdAqH2OE0J19GVlh9izX0mM2A5lOgJcHQPD3ZLL0Uqg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55eg8vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 15:04:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NEi1jt031058;
	Wed, 23 Oct 2024 15:04:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh1n5cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 15:04:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4SiBoL16avmzr3bWjQ2E05KJDGBiARLP531qV59Bk8DqYnLPkhupqu6e16Rr0/0m9MybSqWh33V7jSyYo3MtrgHwFyujtVg6Rt6UpFlnHFZCXjIOJsa9nlCa5Fmmob8IzcOlBijRXLOZkMbhGUb9NK5m0zuI5MuFyn3TIjaOlJTd2b5gdJ5qFOrS8wDpu7iTQLD6iPJY/oFCWz+sh+ppptxW5+EkXNfw+5rw71VXRuYa5sW8Bh/K/p0DrqQMMIYF0VHle6L7BKXTapMXrYGxw4Vy3R5M3Y38xQiykbcETJg0vwy8z9zXz8C5RqOINK/xl9zfl/zcjKQuqNBW/AlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vm79W9pfEsMfAYm0YvIWQhTvxDb1wzOCEJj2YEHyFfI=;
 b=NpXnnWN8V3o6Myejhnu3VDk3Ge+KJYK+O9b7RC94Cv+jgA5VWN2hDGwaIg7wMdxvR/c5IQO/VZPtCYYRiB5XI380SAPvb+QF3FJW+8XQcgxsmFc2QtFTUSq02ifEfaqtgPvNW0BXlgPzQKRwZ1qIvr+g25AitmfIuBISYefvg+RVPwx0yl4s1VUc+RgR1PtKbAtU9nUOuL4y5DcjWsxG5m9obCTzimdn52xNIFhQSyfeUiXTEQBsbWFIlP5/o6uqo1teV93C727M0KbEQMQK6iN1M3mAceydro/hHuaxo2bwuO0YBRBh+tQbkCsv6JhdRkMBHoVoCURZ6dgjBpBwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm79W9pfEsMfAYm0YvIWQhTvxDb1wzOCEJj2YEHyFfI=;
 b=LmtVdYZ/FxoN466CU5v06K7DupiCmoTvF9E6dzQkwUJAPHhPamF7CzYPAZW/STG08aRNDvOHdDDbAsSqvfIobiwDmDyV3uscVd8qLmktF3SpX9l5dZd6IFLvhE/ZdB7skK3R5tx68dHddei+lUyYHuzQfbu0RgkzXFnHloa4DGg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5193.namprd10.prod.outlook.com (2603:10b6:610:c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 15:03:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 15:03:56 +0000
Date: Wed, 23 Oct 2024 11:03:50 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: disallow file locking and delegations for NFSv4
 proxy
Message-ID: <ZxkQVrsQdKCbHSOp@tissot.1015granger.net>
References: <20241023145436.63240-1-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023145436.63240-1-snitzer@kernel.org>
X-ClientProxiedBy: AM0PR06CA0078.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9c468f-2bd3-429d-8706-08dcf373ea63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z6nmFd0ge00UnEOhOvgJR7Zv/g9G67OO2obMzxLapG2PW7TTCrUx0NQkuC6g?=
 =?us-ascii?Q?EanSv7IJTtWTWpwto55RT7VJe/tKt2C1Bwyx79orekPErok9mK4cb4+VfKw7?=
 =?us-ascii?Q?TtX4S8MqoY+j33/88f60k/+ncX7n9Jmj+ZMb7cXPjLZGHrWGQ6WTtvraKp7D?=
 =?us-ascii?Q?vdMu1O88zK6JccpwRx1NIlQ4WmIeog1VqG/+tRo63LbLZdYuk7wcD980X3rD?=
 =?us-ascii?Q?3Tnrc+9nWQLdStMJdTZqNTCyB9t4oPeoASBQp8GWylVwSsaiWWVmqKhkO+RL?=
 =?us-ascii?Q?DkeRvx0AtGoVFYWKlOghija40My2mop5QkWpHpKIVcXlfkfJOYCcCdafcHT3?=
 =?us-ascii?Q?6bKtPy+4W6B/jU/+kpeKAf16YuiLC9Hywopdt2mCY/5nXIbCI+thoYqk3K1w?=
 =?us-ascii?Q?tKmCWJqKTxmipGU4pjKfMWTzx4IRL7OhQySEpe6AmaXwIur0LAjIHkssKMeN?=
 =?us-ascii?Q?u0D2Gc9MUs3YGSMmidN5UjfO72bFDAt/pJ/mtsJZzxRPKMeII1pCoFrg5zzv?=
 =?us-ascii?Q?tl0VbUqcCNRv49uS+NVSu/u7kR9iENv/yG3xPcIU4oFtZJbrHArzA43YgGxq?=
 =?us-ascii?Q?KUlA1xY5TLW2N43sRZnjdPMvS7gTutzPYEnn6GiFNw2Bk4hQR/6F8fEW5+3K?=
 =?us-ascii?Q?YhQuA2j2d6L5/xaQtTBvzfYbS7CZc4zVv2e9GTYuTFS1PUNvtpZUbEngR8p5?=
 =?us-ascii?Q?QyvV5pMeloA390v5cfjaQIOB1kgekE1L1nYZBHZjiGBg+3psMzQ/69bDTvxk?=
 =?us-ascii?Q?Vx9Xz6ICI6+u8Tt+8aY88yUGn+pOXz3H9rEkzBri0CiqtGzVkLwYmDHILwCE?=
 =?us-ascii?Q?+QFUjK8BBA7a7NiSZhyUupFlMbooGLw6oipv8CBsRnN92E6NRzQ6D+zDV3nU?=
 =?us-ascii?Q?RBgXHArqea2uvdy0l7H94XGmEP4kr8bsUnWwJ7QZ1qiUUNrWhn7t3DupUsLe?=
 =?us-ascii?Q?KUtUU4Yo6f4dFgD4eq/aMrGb60vb9ilVKHzZovW59OGuh+72EAUXa+n+ggb4?=
 =?us-ascii?Q?c9qScIAtD280CjBliBmcja9djnYYSvNRg8aUF819aWmkz6NejZx3YYs4iq4G?=
 =?us-ascii?Q?aBm1OlKTptsHmq+VMF0neuZBylg/xnazka8qFZzeYf+xoQjkqqN2hL30T7K6?=
 =?us-ascii?Q?P8gTOtEUDEXGMIrNx3QmWM5nImU2/yuZS42Oe/y+VyZdWfr45qw2KAGPF2hi?=
 =?us-ascii?Q?vfCIKH3GeF4L3gdy0+VNZCwWmk3MfwpNeI1lrq+97J9o3vH6WvPHTiKf/vMx?=
 =?us-ascii?Q?9OQUQ2GmiwNkzhEheawlCeHw4W9DQpq0UPtuV8tjqTVHeKL4BDrwoKQTF3Nk?=
 =?us-ascii?Q?uxA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1e4LgztwbpENnEtKm8NlDsN7qQRb/K1HZTA+hoCfq71qjFirkxXbwiWAE7tl?=
 =?us-ascii?Q?fx+PEBnRclUsC2XGFs2AH0sxlAPc2uMeEpbqsGlXx/lsP2IQPzBX8CrjfgUo?=
 =?us-ascii?Q?1PlPrOmEiJshlNTWyFDGvWvINC98fBONNVyH3qFwEdU1XzfcilaiJdIDq2Hm?=
 =?us-ascii?Q?VcP0IG6zH4yjSc3sOuEplELsatR+MRFCUJ+glD9v4EagHuukL9HqWUhKZ5Kf?=
 =?us-ascii?Q?TY2yHqZUTDOvNbrsMqQCKrqUWAoJl5DzyofnLBOQ4OhNhzoascK2dayaK779?=
 =?us-ascii?Q?q0lZ6zWPSYKpZ4779l77AsoTs5AWib9Nll8m4B+8H2WXqqQu1/GIl7GfLo7U?=
 =?us-ascii?Q?d+6AWCEPV0uqvtbDzF8ShCvzy72R9XDVf5OIT67X47I3OiAHfWJ2J8CmDuB/?=
 =?us-ascii?Q?dDO3nAlsiWdA70idWaLxxJlcvy1ObPrIrm4zHs8biibb2ZzUnUTvX8Nl1ZOP?=
 =?us-ascii?Q?bgZggcC0O5636gwnpfQ7/gkMr95ILww7hTx3FJ9dIrRkXsgmguYCxJ2EsM0/?=
 =?us-ascii?Q?hz+Sx1JRf1Yv5hM/W/XnIpBzY+0Z5eelAA+gXgNLUjXdJ1cob9uJnWST5iNI?=
 =?us-ascii?Q?WK5ePLaGJ5v2vccepRiYim9e4jZirDOFK7Ex7rRElQ8PLYJq1ULCDJJ1rhFX?=
 =?us-ascii?Q?Xv+216Hw4tiAMvofUCPr5GCtFD8iWRoY/BB5vaBRYYx3YiUbXZZdPUvyI+CI?=
 =?us-ascii?Q?LNkxB3iFb92AYY9+Nnd4QlQjyTr6N77pzkS5pBCaSrXg+bcJ+YZQsDZH++jg?=
 =?us-ascii?Q?MdXiEWlh+Uzcjb9LJuB1eAo4A8iweqXPfl7ApT2XYYKH78cB5ZIWns6dO7yx?=
 =?us-ascii?Q?WygTkgA/hbLIMDT6qZoeEGQz4haxvh45HOa9mtt1zK4yV+Mn/6mjwQHGg/dO?=
 =?us-ascii?Q?8mhqf2r2OnsiuPTsE4PCvaji8sVzwj0btANsUcoyohX9y02+qHMJdiVSfaVu?=
 =?us-ascii?Q?CeuxdL9qpNqbM84yz09C3+LrhDPO3cUhmJhVWBWl0aXNPsvr+ilqOXQHlwd2?=
 =?us-ascii?Q?kIA7Z0iy+pg6qLNiWuBgjhCzX76uSKk532vb3Eg4KwzjhSiB3qhx6cIyWE1O?=
 =?us-ascii?Q?Tyc9VVm54eDyUf9C1WlT6ySBoD9TcuPnzEO5wGRTosSVloXWp5tot0kA0l7+?=
 =?us-ascii?Q?QUS1jcd+8GRGN8Jwdky3f22e5I0LdiUHv6qbYJC6pdNZPFHvM7aCQljx+HE3?=
 =?us-ascii?Q?+NIBEfloDGfyb2PFEQKSpzXkGwA92w0O4+nM27lOQ0Rq21A2zMkF48BZ2Ul8?=
 =?us-ascii?Q?CbIRtaUJgpKUKYtXcQw8f5lV4aIm4i5+H/afmLzI7YcVYmGcweBgVnVW9QaD?=
 =?us-ascii?Q?8PWng0BsG1P6Sm6y/eKrr0eyTQqNqidbjvpiuyuD0O8HB/dReFwUxEjTzphQ?=
 =?us-ascii?Q?KH4uUrj8QrEEYxAmrYeCWJ0SJvJPyjLBxcNCwizAi9od43WzcDdjzHjYwFXm?=
 =?us-ascii?Q?XwCH+PruzN5AZS5/JYayG3gnmLxEzGvT9bQrOAHmbzEzA5jtUTYye+DUJnFh?=
 =?us-ascii?Q?EoyTkysIHhRDmHyWQ4LolgthAKfW7YcTG6fy7V32rpQO3bjCZGYtNtxVq13Y?=
 =?us-ascii?Q?tmZGx6k8HphoJKlhNKuiI2mNplApiH9XzARXjQ7EWIzS7maBeK90FfBzfbJr?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A4eGemeOrxG+dXuMs7nY1kC1aCgLtP3Li+8vA4nHArLi1lJd5UDg9t9rGaAFPuJVF+VE4pZh0hP5I530n0gm5Qjs7H5fgMAfsuxGObWIfd54LorRXxP9ueaVxsQ7qDZQs3AkoA7EWB+a5CzsBUcwdqyxRP1VfgRlJjhYHL46SXrebsnjTyt3piL8fw5wvS3ACCLBOe8U8YYhJMtNxuqB5zqgGsLXAcYdXQ4ByMWsRX5G1KALoWVbymQu4NBE7ERODJk+07sNPsg4MHDlhC7/PuNdwNMaMuPq8xCA+4YvoJUqmFSYipEl/hxEYEn3/DQgUXqGVRHbRGFdQ8Q1UyziWZcFoxudEdhf1sZsd4yYZPhPXTHovmqTcarPUpnTeQ5Bx6DzeRyDElch/lQYMyFMKoj/YMCg5dkBoEG2yiWinH2P0KO3ZwOuRr3OvYP3HyCAVNdiYG8UZlpvqFQrrwl8fFpHJnCIo08QcpeVu2XLN0UlSUvVBAqObifpnFVcSBKpfYwh//4CM5cfKT+dkVHylqmnOrAFe1cvs8GvaFlLx96kMpcMcWJH4P4qvTuo21bCq5dRDkiWRuKaIUoHWbuF+SlQaWbgHhVJBb/dC0qKiGk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9c468f-2bd3-429d-8706-08dcf373ea63
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 15:03:56.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3jyzDJUyrvv7XRx8YAWovSykroKbyscuAPmOJOG7n/bFbKBOGWO3UpAqRBW6hEO3qxzlTLTR54RmwoCrflQfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230092
X-Proofpoint-ORIG-GUID: V4LHwaZkOQpqtL09syglWjXRocZCA9YW
X-Proofpoint-GUID: V4LHwaZkOQpqtL09syglWjXRocZCA9YW

On Wed, Oct 23, 2024 at 10:54:36AM -0400, Mike Snitzer wrote:
> We do not and cannot support NFS proxy server file locking over
> NFSv4.x for the same reason we don't do it for NFSv3: NFS proxy server
> reboot cannot allow clients to recover locks because the source NFS
> server has not rebooted, and so it is not in grace.  Since the source
> NFS server is not in grace, it cannot offer any guarantees that the
> file won't have been changed between the locks getting lost and any
> attempt to recover/reclaim them.  The same applies to delegations and
> any associated locks, so disallow them too.
> 
> Add EXPORT_OP_NOLOCKSUPPORT and exportfs_lock_op_is_unsupported(), set
> EXPORT_OP_NOLOCKSUPPORT in nfs_export_ops and check for it in
> nfsd4_lock(), nfsd4_locku() and nfs4_set_delegation().
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/export.c          |  3 ++-
>  fs/nfsd/nfs4state.c      | 20 ++++++++++++++++++++
>  include/linux/exportfs.h | 14 ++++++++++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index be686b8e0c54..2f001a0273bc 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -154,5 +154,6 @@ const struct export_operations nfs_export_ops = {
>  		 EXPORT_OP_CLOSE_BEFORE_UNLINK	|
>  		 EXPORT_OP_REMOTE_FS		|
>  		 EXPORT_OP_NOATOMIC_ATTR	|
> -		 EXPORT_OP_FLUSH_ON_CLOSE,
> +		 EXPORT_OP_FLUSH_ON_CLOSE	|
> +		 EXPORT_OP_NOLOCKSUPPORT,
>  };
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ac1859c7cc9d..63297ea82e4e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5813,6 +5813,15 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	if (!nf)
>  		return ERR_PTR(-EAGAIN);
>  
> +	/*
> +	 * File delegations and associated locks cannot be recovered if
> +	 * export is from NFS proxy server.
> +	 */
> +	if (exportfs_lock_op_is_unsupported(nf->nf_file->f_path.mnt->mnt_sb->s_export_op)) {
> +		nfsd_file_put(nf);
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
>  	spin_lock(&state_lock);
>  	spin_lock(&fp->fi_lock);
>  	if (nfs4_delegation_exists(clp, fp))
> @@ -7917,6 +7926,11 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	}
>  	sb = cstate->current_fh.fh_dentry->d_sb;
>  
> +	if (exportfs_lock_op_is_unsupported(sb->s_export_op)) {
> +		status = nfserr_notsupp;
> +		goto out;
> +	}
> +
>  	if (lock->lk_is_new) {
>  		if (nfsd4_has_session(cstate))
>  			/* See rfc 5661 18.10.3: given clientid is ignored: */
> @@ -8266,6 +8280,12 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		status = nfserr_lock_range;
>  		goto put_stateid;
>  	}
> +
> +	if (exportfs_lock_op_is_unsupported(nf->nf_file->f_path.mnt->mnt_sb->s_export_op)) {
> +		status = nfserr_notsupp;
> +		goto put_file;
> +	}
> +
>  	file_lock = locks_alloc_lock();
>  	if (!file_lock) {
>  		dprintk("NFSD: %s: unable to allocate lock!\n", __func__);
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 893a1d21dc1c..106fd590d323 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -247,6 +247,7 @@ struct export_operations {
>  						*/
>  #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
>  #define EXPORT_OP_ASYNC_LOCK		(0x40) /* fs can do async lock request */
> +#define EXPORT_OP_NOLOCKSUPPORT		(0x80) /* no file locking support */
>  	unsigned long	flags;
>  };
>  
> @@ -263,6 +264,19 @@ exportfs_lock_op_is_async(const struct export_operations *export_ops)
>  	return export_ops->flags & EXPORT_OP_ASYNC_LOCK;
>  }
>  
> +/**
> + * exportfs_lock_op_is_unsupported() - export does not support file locking
> + * @export_ops:	the nfs export operations to check
> + *
> + * Returns true if the nfs export_operations structure has
> + * EXPORT_OP_NOLOCKSUPPORT in their flags set
> + */
> +static inline bool
> +exportfs_lock_op_is_unsupported(const struct export_operations *export_ops)
> +{
> +	return export_ops->flags & EXPORT_OP_NOLOCKSUPPORT;
> +}
> +
>  extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
>  				    int *max_len, struct inode *parent,
>  				    int flags);
> -- 
> 2.44.0
> 

Re: this patch:

I expect that this behavior will be surprising to users and
administrators. It would be great to have some documentation for NFS
re-export / proxy somewhere prominent that explains this (and other)
limitations for NFS proxy. Any thoughts, please share.

General comment:

We have talked about adding NFS re-export to our kdevops CI for
upstream NFSD, but that hasn't happened yet. I'm wondering if there
is any other regular testing of re-export.

-- 
Chuck Lever

