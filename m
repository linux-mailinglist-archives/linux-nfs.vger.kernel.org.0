Return-Path: <linux-nfs+bounces-3937-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5B690BB1E
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 21:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EE228318C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 19:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7894AECB;
	Mon, 17 Jun 2024 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dEd+WmpT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hOBijYHP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7511BDEF
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652678; cv=fail; b=ax9RXczuIwZpXl5LZJTWw08F/FngvgNK/TzOacEdeeeOLynj9HsdAzuYxWzCAp5aujQHrn2SbEq2DagO9eek1wn/kfFmGoZIkjVuny+YVvEgZdFcAiNaPQlOgceo31NzxVo32TsNHil8dHyiZT0DgkGrlcpa+aINVEqRsMEzthU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652678; c=relaxed/simple;
	bh=zAf74a061rlJBh2pT/na+d55k8gYObKOhP5pdrNoZ04=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Fv0JW6yWBMmNQJ7mZwyT56Z5e0x6oqJyu+olx7948Vmc7RwAAN0ZTYUreD/4Boo65Y/etAsowLAPTlq6LIkmBQcpg1AWgS2rK72khCv6l6ppKZ5NtbwAvV+RxaWOayxgbuN9hKgoVEbNk75HYbdt77NP8YpSDWpNBa2QTvfkAhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dEd+WmpT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hOBijYHP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HItSMm027901;
	Mon, 17 Jun 2024 19:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=I4DdOJ88qY5tcmfF/HEwGwQT6hoinE5alS2L8DFufMI=; b=
	dEd+WmpTM0WiZxrb7SKeBDybjN5xSFw1nJ8q4XhxVhCNR+d4HANJLhljp/ziAIyH
	kd1qi8ERBlwrBsfii09FXKFGa5kRAROwawpLGCgTx7b6AKAPXjtA3BWsmqnkaWLy
	29367G0Bz6KmarkixsMhbRIZ7drEf6B64ptxpRWOdDBfTtrutJQ72VyW3igpT2EU
	HB4/PiwNUlZvjSb/2kkJzwnMiPybm+0oT6YG4t9wYUtoVyxQ61whgptZcBipDMZ/
	Qoii0pHi13WxkcNmWZp/KBfhHXqZkt+21xhfUOkyByZv8yGj63s37Z22w9CCWgxf
	g5kzygp/4caZ4s00Jqw5QA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys30bkfws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 19:31:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HIG2rY007170;
	Mon, 17 Jun 2024 19:31:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ytp8de07q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 19:31:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGsGk++q3TPXZrrzu6k9lX/oMce/KZvIT4cvEjsaSQUWyW0AKoRLLyRdVMg9dygKS7iHnZXtDlCcJRooZxSKz/tywjjk5BN2OY+Up58HDJ+iZxY6aySASjoGExOYqYL8xxB0SccRwe5z1yK1QMabywf2sJM1hsdYgrXUA6Avbcxyy74pYS11S32UZZnen3a3wL4F2xCAiX863dC2iENP0Kge+CBmqrbv73oMECmFhtCGyQtSGLirKWWfHCOL1Y4pNSnYdE7aST8HiTUsNXfv2ExrdWuAh4ka2O3DUzkXQSm5D+LRPrVxkgPB0EN7YAJr7jwfvXYqxOgxF21peV/+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4DdOJ88qY5tcmfF/HEwGwQT6hoinE5alS2L8DFufMI=;
 b=OdMG4HIasM5Cr32a3CX1hFuX1DGBeDyLSAYrrRiAwTD7VyP6ElHpEoK9jYbvgH8DwX/9R+0LcUyTtbVFhIUh8YRsYsD37x6L9LRdE8g0hmqjre+ntiNa9V/IH1mzLnf0Wf3Nd7YY1kqVgahbcZ159gC+9So9yLb5HcJmj3J+CcaBMydCrWpH9vYZQ3tPxiADXT8kJOt0KE1jKcNGrTSQAf9ubK/XePOsDKJmHPUNoZRYXLYp+LBCCkSBmkCOTd53QcykD4GY/2ZF9hV/ir1UOsOKzmK6VSOiU3TiKQZv+49f9pamQ1vRDgHJPQcRs12F7cU+t7HNvjKlHVruMA7Gdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4DdOJ88qY5tcmfF/HEwGwQT6hoinE5alS2L8DFufMI=;
 b=hOBijYHPdkxze57Xm//UejjS+gXggdRuMAgzOpYiV4xzy2MSdXKa5Rd0SKGMM1/jgbirREYKwz07lAz2joK7ZsWxq0XPNRlFsC+EDJGijzVaAbQsNvTQUdhta9eA7ezExy8Xg5QAxymasjywoNKtY8O7jOIwbM09FrnIurlQdlc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Mon, 17 Jun
 2024 19:31:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 19:31:03 +0000
Date: Mon, 17 Jun 2024 15:30:59 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc: linux-nfs@vger.kernel.org, stable@tissot.1015granger.net
Subject: [GIT PULL 5.10.y] NFSD filecache fixes
Message-ID: <ZnCO88W37FXg5CV6@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR15CA0015.namprd15.prod.outlook.com
 (2603:10b6:610:51::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d85550-3bb6-457c-e5f3-08dc8f04065f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SS16r1HcJHXOUhi36zkePpp7bA1LJO3pPxBXKo9T33On4XcdsZVN5y1MBPER?=
 =?us-ascii?Q?TqcZ9bzK1vaxhTfgSr0pfoKqx41YI1Y/bDTHzxslyGuaGjU1Z+rX3tZ2wA4S?=
 =?us-ascii?Q?diUsvxseIGWwMZtB13dFrg1mPy7H2OydaEdMnitF8/sgnc5xZKNcc4Si9Le+?=
 =?us-ascii?Q?+H1k0T6jRDEagYLO3O8EAGzpCU4PxsciU5N4px1rnkLEatVqXlXorvB/aYpG?=
 =?us-ascii?Q?mU7WlbGjmG6WeGXB1SId/e2I4uYVZ/LVVOXID5PFNprHsSHiP0/GN8oB2GvE?=
 =?us-ascii?Q?/HApWq2dB7fXjYWmYDeOdlmQDhcTPIXp+y382ZqNY46DUNNzN0ghchjR0vyL?=
 =?us-ascii?Q?dP11rMm48WnLqgwD82/dA72FMPc6vUt6IH4ZxHvuNh7hivpnafykG141H1Ch?=
 =?us-ascii?Q?TMGWC6mB1WI0pi5p4wZwYR4qz6q9kAzIY4Xn2Lc0oQlrzSUJ8CWxTEPKfPHG?=
 =?us-ascii?Q?m/ScMB6QLvXlRKHFWZEWgR4JpXxlFRp0/p0d6ErY85sficz4595zZyvI+/pS?=
 =?us-ascii?Q?97gGGKoshm+CCPnAtFWBUvTcRpwqeURFgOiXEZyJSb3QqCLI9xjwPGf9Tyd3?=
 =?us-ascii?Q?twYttPSHbYYLoVScpXiKvWtxZzdejSvxzRd/Q2GclxNIQPvAQABzuvHramhv?=
 =?us-ascii?Q?s0h8usntd7+8Klu4rjKGLFKrkd8waTLyOjpdlHzbqVNJoPZO8P1IayGH8nEM?=
 =?us-ascii?Q?B40FDWYsgDFXi/zVmakuzNoXI+oC7k+PnEa3T/RIJo690nS+yIQCUa6ZVyN0?=
 =?us-ascii?Q?o1gS/6YCl3xORooHLSKZv+UDh/WeVtAH8o7w7gE8C9Z5N3kqLqoPBECj9Rua?=
 =?us-ascii?Q?gPRkA3ekvsDRrOhqwLwhwuzYJCmTDVS6mxvJ+5sOdTpg6MgLQwBVC+tfKw0k?=
 =?us-ascii?Q?mGSCMiqTYE9sIUudDQpiYeJJNmVEJBxuCJfxRghDtRxbq3AykpGrQtshqhSk?=
 =?us-ascii?Q?6vyz19ThpmNcM6zLzdsaptjWouGeKWbaMJp4Pj/KWYcqp01+T+RcWoEydgKm?=
 =?us-ascii?Q?hgGhIQnIinYxMnhlZeMrljGP+M/TcGKirYnpuNX1+bUAuAXZGlIbvYD3vqft?=
 =?us-ascii?Q?uUPBAH9EPm7rFxudUbRFSdGNuq+n8JBTluuJnIhuvfUXJ/LyFtrmtMZjav92?=
 =?us-ascii?Q?UOIi0C3Xpm69nG2eBY97AnxrOJSM2jzPYVkD06YPxhroclbUNO9G21cr+aiE?=
 =?us-ascii?Q?UftjWlxfL55lZOAdxJuWkDGtlMVO/9CNOYZL1gS2ZAgN7MaObmO/UEpzgm+q?=
 =?us-ascii?Q?mn2WSHK972icz6y2FqKf?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?apoIMHfCuKIfwiMnYCavSLf7uNS7wKYkS74sJvMXoVE3W5Rf0tAIosXxJGyk?=
 =?us-ascii?Q?VzhEXbV3KLh3yX2JJseqb6ckcx4LunGZPYga4cd5kuvgv6ARh14u8fdKsbm1?=
 =?us-ascii?Q?xWhAWcZx3kVWe4utCs2qjjA6OpdzqCZYNWkV/trcTTYuOYxDFzFt6YUtMrjt?=
 =?us-ascii?Q?KOt+o0fBx5p9FsCy2xXtwQXddSmDeCyJ6/l7hJHjzWqS6/zYZ0Imdah1qr+i?=
 =?us-ascii?Q?g3c+FrC771UAC8uRB1EyZwMhiupRamiqp/gnsb29wHNVLH4N5dBMEZ1qz/I8?=
 =?us-ascii?Q?FMlaGkCY8bpYgTey/eUxdbOwQC+xwT2CR08EDLcL1+eZQqYi/dNqtZEGKGqE?=
 =?us-ascii?Q?E97ifgC61Zf4/q4y5yU/v2tFF8UWGLDlpUX4aqE1+Hg88vvEK6TcycooLQ+/?=
 =?us-ascii?Q?ZBbYpJ+J0Y/JqTjrn8yhwwzXlkmsRNIG8hOC1ukaA5o6/nVEXqB9CafeECn8?=
 =?us-ascii?Q?fICWPtYF7ANSUNmCus4T3BI0Js9eEODjrYIKhqLR8kLRB+WqATfYNSMdc4Jt?=
 =?us-ascii?Q?NFaMS80YGC+9Xl0pYHlelqFO4vHHR8ZdLtlKhQkWywVFENsGtlx76JpEPpZ1?=
 =?us-ascii?Q?RnB75bbSDGaZ03wW6TtBjZdkU7y8RxHbKy0nwcM88kJpasBMZDlOkgUnMEev?=
 =?us-ascii?Q?Tk1IaDTA8ZJVmD72qNuqDHjIeY+oKyrMXltkHMdEDEfM/ysKDR2MaGOMI4hG?=
 =?us-ascii?Q?RcYGlRb2SXAXevz+quQ14fHvigKPWjrkEE5rx+NYgWnPfsRA+A5POd1m/BUp?=
 =?us-ascii?Q?5lczrXABxx6BXF2vteCQKm+MD7hSDauFBK5S74DtHB+6Hax/P1WwurcqP1pc?=
 =?us-ascii?Q?S2i7UdGWieiBZXhfT4dFGUnc7uzxK4Al56WH4tCMcOVmfN1HMgUvhNBOyA40?=
 =?us-ascii?Q?D8I2CE8j+0W+3YZwwIXwOUw086YcYExdkII+OF215l6/SY1L76LW4vXtoC5B?=
 =?us-ascii?Q?+Y0ZlB6cYCuRSwTocVishxXb8//z+4V5KOggiEk1JijscO+dmpeJ5qWGojVq?=
 =?us-ascii?Q?zW6M0H+71qqzrTyNvRuxgpmosqFdSEkCalfaKsHhAtJNfWwL/aE/l5lrejJI?=
 =?us-ascii?Q?8orgAM0EZN7WnhpFcCDdsdtvDEu03r+u6RM7pqV6zsNJE6vw7J2pPm6uNPOH?=
 =?us-ascii?Q?UcvIP4+Aj4nwO9uq42OiBhAcWJW0+xUOXM5BW9D+Rg6sG3G6nmdGJ9Pi70yk?=
 =?us-ascii?Q?9NZ50YBYeYx1N2aLKq6gNd0TUDvwn7D+9JjBgbflu5dADI1WGg87nRUaffog?=
 =?us-ascii?Q?cv3fdtXJp9oWmeld1C1pW5IJ1lN5wMfR4exe36QxFCmvvSRGDBf7XZeUJDy9?=
 =?us-ascii?Q?qyD3cWWM4felbm7Bos4T6UeiAJixdqU/2EXZXphIqva0Cesy1v7N2wxu+dBU?=
 =?us-ascii?Q?nph0zuXAZOWWhz7331QQTfvMfAEAiYyakbHN+MbhzgUa9gP0aNPKt8TmYrTR?=
 =?us-ascii?Q?nr1gWjHb6RvCxWGW+Fho/L7X9BpUWqianL9v17Xt0Om2FCtwnnXHBrxDxd0E?=
 =?us-ascii?Q?TqAl0qhby92sHqKHveicV67cK71fekUcKKEtlv5o+OeyamLh5H6F+/FMNFdG?=
 =?us-ascii?Q?uLtzSKqISYmVdbTNfxC26RRlKQ5DujwxFOLY/Z3+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2VMcPNSI9W3HVfLK1ACw1WqxeKk3qmBqC79j3d4tVzvZis/hMk+AEKrP+4yQ103Jt+Ea7XaN+Nnmj+LObYMIQf9mPkdiHGUChix5Fdq0T+7Z2PMep4+oJmMUesvDLULMpoC8bL80eIFccACubX7oujCPQVE3G3o4cetIlM3bhIYkABJ5Hb52B9PWrWqwAXq+cjQkIUb65eIbgXwNWoSMq8ycek0sZ4ip2Q6w9dRd6l89hj1xFOJWCw7ecmdwu4XSTFNjuH6xItzJhIcpUwqqWZKTh0SyyYYhgp0CYM+jr+KZl+8JvlC+RHtE0dd+K8EY455pFOVCZJdMQqPsPBYhMNBtqAbdweNfPmvmfWBfw30ruZUqQ7+zDlammg9KxwLlDXZCsS0zo88Bua6LW2vIDpbfoqBcanpAa+k8itXx/OOPHNUcb0kc5yECUEVWgyHJ4Wrzq8rjiZQQd9Fls3YyxWfBqG0xPGcuP8SCdeK4/jpY/6ztk3N4J5ypYlZGO8sxwx6JFeBiVb9cmPuAadW0p4UxxYj89+DK+X6z3iD53EvAEh8vKXTRPPldp9AA6THVPs3K3tFY3BVHyZob6dY+K4+RmbpgrUsCVgbDAA+vRYw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d85550-3bb6-457c-e5f3-08dc8f04065f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 19:31:03.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfVuGNxYV+vr2UgCZR80YcEzd7h4luVRJuxHpWl54U0dmhHP5em80MUO/CowaZ6FEtwp4RbGbC77LedrSs6dUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406170150
X-Proofpoint-GUID: OH7UhnLn7OpQ-h3kLRSZZF4vzBvMGYvi
X-Proofpoint-ORIG-GUID: OH7UhnLn7OpQ-h3kLRSZZF4vzBvMGYvi

Hi Greg, Sasha-

Here is a backport of nearly every NFSD patch from v5.11 until
v6.3, plus subsequent fixes, onto LTS v5.10.219. This addresses
the many NFSD filecache-related scalability problems in v5.10's
NFSD. This also contains fixes for issues found in the v5.15
NFSD backport over the past several months.

I've run this kernel through the usual upstream CI testing for
NFSD, and it seems solid.

In lieu of sending an mbox containing all of these patches, here's
a pull request that gives you the co-ordinates for the full series
enabling you to handle the merge however you prefer.


--- cut here ---

The following changes since commit a2ed1606213906ac22fd66bebb34b88f8e24224b:

  Linux 5.10.219 (2024-06-16 13:32:37 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git nfsd-5.10.y

for you to fetch changes up to 297ad218672e7f8d6e1f6af048c42a42760f56b1:

  nfsd: Fix a regression in nfsd_setattr() (2024-06-17 09:49:21 -0400)

----------------------------------------------------------------
Al Viro (2):
      nfsd_splice_actor(): handle compound pages
      fs/notify: constify path

Alex Shi (1):
      nfsd/nfs3: remove unused macro nfsd3_fhandleres

Amir Goldstein (52):
      nfsd: remove unused stats counters
      nfsd: protect concurrent access to nfsd stats counters
      nfsd: report per-export stats
      fsnotify: allow fsnotify_{peek,remove}_first_event with empty queue
      fanotify: reduce event objectid to 29-bit hash
      fanotify: mix event info and pid into merge key hash
      fsnotify: use hash table for faster events merge
      fanotify: limit number of event merge attempts
      fanotify: configurable limits via sysfs
      fanotify: support limited functionality for unprivileged users
      fanotify: fix permission model of unprivileged group
      fsnotify: replace igrab() with ihold() on attach connector
      fsnotify: count s_fsnotify_inode_refs for attached connectors
      fsnotify: count all objects with attached connectors
      fsnotify: optimize the case of no marks of any type
      fsnotify: fix sb_connectors leak
      fsnotify: pass data_type to fsnotify_name()
      fsnotify: pass dentry instead of inode data
      fsnotify: clarify contract for create event hooks
      fsnotify: clarify object type argument
      fsnotify: separate mark iterator type from object type enum
      fanotify: introduce group flag FAN_REPORT_TARGET_FID
      fsnotify: generate FS_RENAME event with rich information
      fanotify: use macros to get the offset to fanotify_info buffer
      fanotify: use helpers to parcel fanotify_info buffer
      fanotify: support secondary dir fh and name in fanotify_info
      fanotify: record old and new parent and name in FAN_RENAME event
      fanotify: record either old name new name or both for FAN_RENAME
      fanotify: report old and/or new parent+name in FAN_RENAME event
      fanotify: wire up FAN_RENAME event
      fsnotify: fix merge with parent's ignored mask
      fsnotify: optimize FS_MODIFY events with no ignored masks
      fanotify: do not allow setting dirent events in mask of non-dir
      inotify: move control flags from mask to mark flags
      fsnotify: pass flags argument to fsnotify_alloc_group()
      fsnotify: make allow_dups a property of the group
      fsnotify: create helpers for group mark_mutex lock
      inotify: use fsnotify group lock helpers
      nfsd: use fsnotify group lock helpers
      dnotify: use fsnotify group lock helpers
      fsnotify: allow adding an inode mark without pinning inode
      fanotify: create helper fanotify_mark_user_flags()
      fanotify: factor out helper fanotify_mark_update_flags()
      fanotify: implement "evictable" inode marks
      fanotify: use fsnotify group lock helpers
      fanotify: enable "evictable" inode marks
      fsnotify: introduce mark type iterator
      fsnotify: consistent behavior for parent not watching children
      fanotify: refine the validation checks on non-dir inode mask
      fanotify: prepare for setting event flags in ignore mask
      fanotify: cleanups for fanotify_mark() input validations
      fanotify: introduce FAN_MARK_IGNORE

Anna Schumaker (1):
      NFSD: Simplify READ_PLUS

Bang Li (1):
      fsnotify: remove redundant parameter judgment

Benjamin Coddington (1):
      NLM: Defend against file_lock changes after vfs_test_lock()

Brian Foster (1):
      NFSD: pass range end to vfs_fsync_range() instead of count

Changcheng Deng (1):
      NFSD:fix boolreturn.cocci warning

ChenXiaoSong (5):
      nfsd: use DEFINE_PROC_SHOW_ATTRIBUTE to define nfsd_proc_ops
      nfsd: use DEFINE_SHOW_ATTRIBUTE to define export_features_fops and supported_enctypes_fops
      nfsd: use DEFINE_SHOW_ATTRIBUTE to define client_info_fops
      nfsd: use DEFINE_SHOW_ATTRIBUTE to define nfsd_reply_cache_stats_fops
      nfsd: use DEFINE_SHOW_ATTRIBUTE to define nfsd_file_cache_stats_fops

Christian Brauner (3):
      fs: add file and path permissions helpers
      namei: introduce struct renamedata
      fanotify_user: use upper_32_bits() to verify mask

Christoph Hellwig (4):
      module: unexport find_module and module_mutex
      module: use RCU to synchronize find_module
      kallsyms: refactor {,module_}kallsyms_on_each_symbol
      kallsyms: only build {,module_}kallsyms_on_each_symbol when required

Christophe JAILLET (2):
      nfsd: Avoid some useless tests
      nfsd: Propagate some error code returned by memdup_user()

Chuck Lever (409):
      SUNRPC: Rename svc_encode_read_payload()
      NFSD: Invoke svc_encode_result_payload() in "read" NFSD encoders
      NFSD: Clean up the show_nf_may macro
      NFSD: Remove extra "0x" in tracepoint format specifier
      NFSD: Add SPDX header for fs/nfsd/trace.c
      SUNRPC: Add xdr_set_scratch_page() and xdr_reset_scratch_buffer()
      SUNRPC: Prepare for xdr_stream-style decoding on the server-side
      NFSD: Add common helpers to decode void args and encode void results
      NFSD: Add tracepoints in nfsd_dispatch()
      NFSD: Add tracepoints in nfsd4_decode/encode_compound()
      NFSD: Replace the internals of the READ_BUF() macro
      NFSD: Replace READ* macros in nfsd4_decode_access()
      NFSD: Replace READ* macros in nfsd4_decode_close()
      NFSD: Replace READ* macros in nfsd4_decode_commit()
      NFSD: Change the way the expected length of a fattr4 is checked
      NFSD: Replace READ* macros that decode the fattr4 size attribute
      NFSD: Replace READ* macros that decode the fattr4 acl attribute
      NFSD: Replace READ* macros that decode the fattr4 mode attribute
      NFSD: Replace READ* macros that decode the fattr4 owner attribute
      NFSD: Replace READ* macros that decode the fattr4 owner_group attribute
      NFSD: Replace READ* macros that decode the fattr4 time_set attributes
      NFSD: Replace READ* macros that decode the fattr4 security label attribute
      NFSD: Replace READ* macros that decode the fattr4 umask attribute
      NFSD: Replace READ* macros in nfsd4_decode_fattr()
      NFSD: Replace READ* macros in nfsd4_decode_create()
      NFSD: Replace READ* macros in nfsd4_decode_delegreturn()
      NFSD: Replace READ* macros in nfsd4_decode_getattr()
      NFSD: Replace READ* macros in nfsd4_decode_link()
      NFSD: Relocate nfsd4_decode_opaque()
      NFSD: Add helpers to decode a clientid4 and an NFSv4 state owner
      NFSD: Add helper for decoding locker4
      NFSD: Replace READ* macros in nfsd4_decode_lock()
      NFSD: Replace READ* macros in nfsd4_decode_lockt()
      NFSD: Replace READ* macros in nfsd4_decode_locku()
      NFSD: Replace READ* macros in nfsd4_decode_lookup()
      NFSD: Add helper to decode NFSv4 verifiers
      NFSD: Add helper to decode OPEN's createhow4 argument
      NFSD: Add helper to decode OPEN's openflag4 argument
      NFSD: Replace READ* macros in nfsd4_decode_share_access()
      NFSD: Replace READ* macros in nfsd4_decode_share_deny()
      NFSD: Add helper to decode OPEN's open_claim4 argument
      NFSD: Replace READ* macros in nfsd4_decode_open()
      NFSD: Replace READ* macros in nfsd4_decode_open_confirm()
      NFSD: Replace READ* macros in nfsd4_decode_open_downgrade()
      NFSD: Replace READ* macros in nfsd4_decode_putfh()
      NFSD: Replace READ* macros in nfsd4_decode_read()
      NFSD: Replace READ* macros in nfsd4_decode_readdir()
      NFSD: Replace READ* macros in nfsd4_decode_remove()
      NFSD: Replace READ* macros in nfsd4_decode_rename()
      NFSD: Replace READ* macros in nfsd4_decode_renew()
      NFSD: Replace READ* macros in nfsd4_decode_secinfo()
      NFSD: Replace READ* macros in nfsd4_decode_setattr()
      NFSD: Replace READ* macros in nfsd4_decode_setclientid()
      NFSD: Replace READ* macros in nfsd4_decode_setclientid_confirm()
      NFSD: Replace READ* macros in nfsd4_decode_verify()
      NFSD: Replace READ* macros in nfsd4_decode_write()
      NFSD: Replace READ* macros in nfsd4_decode_release_lockowner()
      NFSD: Replace READ* macros in nfsd4_decode_cb_sec()
      NFSD: Replace READ* macros in nfsd4_decode_backchannel_ctl()
      NFSD: Replace READ* macros in nfsd4_decode_bind_conn_to_session()
      NFSD: Add a separate decoder to handle state_protect_ops
      NFSD: Add a separate decoder for ssv_sp_parms
      NFSD: Add a helper to decode state_protect4_a
      NFSD: Add a helper to decode nfs_impl_id4
      NFSD: Add a helper to decode channel_attrs4
      NFSD: Replace READ* macros in nfsd4_decode_create_session()
      NFSD: Replace READ* macros in nfsd4_decode_destroy_session()
      NFSD: Replace READ* macros in nfsd4_decode_free_stateid()
      NFSD: Replace READ* macros in nfsd4_decode_getdeviceinfo()
      NFSD: Replace READ* macros in nfsd4_decode_layoutcommit()
      NFSD: Replace READ* macros in nfsd4_decode_layoutget()
      NFSD: Replace READ* macros in nfsd4_decode_layoutreturn()
      NFSD: Replace READ* macros in nfsd4_decode_secinfo_no_name()
      NFSD: Replace READ* macros in nfsd4_decode_sequence()
      NFSD: Replace READ* macros in nfsd4_decode_test_stateid()
      NFSD: Replace READ* macros in nfsd4_decode_destroy_clientid()
      NFSD: Replace READ* macros in nfsd4_decode_reclaim_complete()
      NFSD: Replace READ* macros in nfsd4_decode_fallocate()
      NFSD: Replace READ* macros in nfsd4_decode_nl4_server()
      NFSD: Replace READ* macros in nfsd4_decode_copy()
      NFSD: Replace READ* macros in nfsd4_decode_copy_notify()
      NFSD: Replace READ* macros in nfsd4_decode_offload_status()
      NFSD: Replace READ* macros in nfsd4_decode_seek()
      NFSD: Replace READ* macros in nfsd4_decode_clone()
      NFSD: Replace READ* macros in nfsd4_decode_xattr_name()
      NFSD: Replace READ* macros in nfsd4_decode_setxattr()
      NFSD: Replace READ* macros in nfsd4_decode_listxattrs()
      NFSD: Make nfsd4_ops::opnum a u32
      NFSD: Replace READ* macros in nfsd4_decode_compound()
      NFSD: Remove macros that are no longer used
      Revert "fget: clarify and improve __fget_files() implementation"
      NFSD: Fix sparse warning in nfssvc.c
      NFSD: Restore NFSv4 decoding's SAVEMEM functionality
      SUNRPC: Make trace_svc_process() display the RPC procedure symbolically
      SUNRPC: Display RPC procedure names instead of proc numbers
      SUNRPC: Move definition of XDR_UNIT
      NFSD: Update GETATTR3args decoder to use struct xdr_stream
      NFSD: Update ACCESS3arg decoder to use struct xdr_stream
      NFSD: Update READ3arg decoder to use struct xdr_stream
      NFSD: Update WRITE3arg decoder to use struct xdr_stream
      NFSD: Update READLINK3arg decoder to use struct xdr_stream
      NFSD: Fix returned READDIR offset cookie
      NFSD: Add helper to set up the pages where the dirlist is encoded
      NFSD: Update READDIR3args decoders to use struct xdr_stream
      NFSD: Update COMMIT3arg decoder to use struct xdr_stream
      NFSD: Update the NFSv3 DIROPargs decoder to use struct xdr_stream
      NFSD: Update the RENAME3args decoder to use struct xdr_stream
      NFSD: Update the LINK3args decoder to use struct xdr_stream
      NFSD: Update the SETATTR3args decoder to use struct xdr_stream
      NFSD: Update the CREATE3args decoder to use struct xdr_stream
      NFSD: Update the MKDIR3args decoder to use struct xdr_stream
      NFSD: Update the SYMLINK3args decoder to use struct xdr_stream
      NFSD: Update the MKNOD3args decoder to use struct xdr_stream
      NFSD: Update the NFSv2 GETATTR argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 READ argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 WRITE argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 READLINK argument decoder to use struct xdr_stream
      NFSD: Add helper to set up the pages where the dirlist is encoded
      NFSD: Update the NFSv2 READDIR argument decoder to use struct xdr_stream
      NFSD: Update NFSv2 diropargs decoding to use struct xdr_stream
      NFSD: Update the NFSv2 RENAME argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 LINK argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 SETATTR argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 CREATE argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 SYMLINK argument decoder to use struct xdr_stream
      NFSD: Remove argument length checking in nfsd_dispatch()
      NFSD: Update the NFSv2 GETACL argument decoder to use struct xdr_stream
      NFSD: Add an xdr_stream-based decoder for NFSv2/3 ACLs
      NFSD: Update the NFSv2 SETACL argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 ACL GETATTR argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 ACL ACCESS argument decoder to use struct xdr_stream
      NFSD: Clean up after updating NFSv2 ACL decoders
      NFSD: Update the NFSv3 GETACL argument decoder to use struct xdr_stream
      NFSD: Update the NFSv2 SETACL argument decoder to use struct xdr_stream
      NFSD: Clean up after updating NFSv3 ACL decoders
      NFSD: Extract the svcxdr_init_encode() helper
      NFSD: Update the GETATTR3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 ACCESS3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 LOOKUP3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 wccstat result encoder to use struct xdr_stream
      NFSD: Update the NFSv3 READLINK3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 READ3res encode to use struct xdr_stream
      NFSD: Update the NFSv3 WRITE3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 CREATE family of encoders to use struct xdr_stream
      NFSD: Update the NFSv3 RENAMEv3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 LINK3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 FSSTAT3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 FSINFO3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 PATHCONF3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 COMMIT3res encoder to use struct xdr_stream
      NFSD: Add a helper that encodes NFSv3 directory offset cookies
      NFSD: Count bytes instead of pages in the NFSv3 READDIR encoder
      NFSD: Update the NFSv3 READDIR3res encoder to use struct xdr_stream
      NFSD: Update NFSv3 READDIR entry encoders to use struct xdr_stream
      NFSD: Remove unused NFSv3 directory entry encoders
      NFSD: Reduce svc_rqst::rq_pages churn during READDIR operations
      NFSD: Update the NFSv2 stat encoder to use struct xdr_stream
      NFSD: Update the NFSv2 attrstat encoder to use struct xdr_stream
      NFSD: Update the NFSv2 diropres encoder to use struct xdr_stream
      NFSD: Update the NFSv2 READLINK result encoder to use struct xdr_stream
      NFSD: Update the NFSv2 READ result encoder to use struct xdr_stream
      NFSD: Update the NFSv2 STATFS result encoder to use struct xdr_stream
      NFSD: Add a helper that encodes NFSv3 directory offset cookies
      NFSD: Count bytes instead of pages in the NFSv2 READDIR encoder
      NFSD: Update the NFSv2 READDIR result encoder to use struct xdr_stream
      NFSD: Update the NFSv2 READDIR entry encoder to use struct xdr_stream
      NFSD: Remove unused NFSv2 directory entry encoders
      NFSD: Add an xdr_stream-based encoder for NFSv2/3 ACLs
      NFSD: Update the NFSv2 GETACL result encoder to use struct xdr_stream
      NFSD: Update the NFSv2 SETACL result encoder to use struct xdr_stream
      NFSD: Update the NFSv2 ACL GETATTR result encoder to use struct xdr_stream
      NFSD: Update the NFSv2 ACL ACCESS result encoder to use struct xdr_stream
      NFSD: Clean up after updating NFSv2 ACL encoders
      NFSD: Update the NFSv3 GETACL result encoder to use struct xdr_stream
      NFSD: Update the NFSv3 SETACL result encoder to use struct xdr_stream
      NFSD: Clean up after updating NFSv3 ACL encoders
      NFSD: Add a tracepoint to record directory entry encoding
      NFSD: Clean up NFSDDBG_FACILITY macro
      SUNRPC: Export svc_xprt_received()
      Revert "fanotify: limit number of event merge attempts"
      NFSD: Add an RPC authflavor tracepoint display helper
      NFSD: Add nfsd_clid_cred_mismatch tracepoint
      NFSD: Add nfsd_clid_verf_mismatch tracepoint
      NFSD: Remove trace_nfsd_clid_inuse_err
      NFSD: Add nfsd_clid_confirmed tracepoint
      NFSD: Add nfsd_clid_reclaim_complete tracepoint
      NFSD: Add nfsd_clid_destroyed tracepoint
      NFSD: Add a couple more nfsd_clid_expired call sites
      NFSD: Add tracepoints for SETCLIENTID edge cases
      NFSD: Add tracepoints for EXCHANGEID edge cases
      NFSD: Constify @fh argument of knfsd_fh_hash()
      NFSD: Capture every CB state transition
      NFSD: Drop TRACE_DEFINE_ENUM for NFSD4_CB_<state> macros
      NFSD: Add cb_lost tracepoint
      NFSD: Adjust cb_shutdown tracepoint
      NFSD: Enhance the nfsd_cb_setup tracepoint
      NFSD: Add an nfsd_cb_lm_notify tracepoint
      NFSD: Add an nfsd_cb_offload tracepoint
      NFSD: Replace the nfsd_deleg_break tracepoint
      NFSD: Add an nfsd_cb_probe tracepoint
      NFSD: Remove the nfsd_cb_work and nfsd_cb_done tracepoints
      NFSD: Update nfsd_cb_args tracepoint
      lockd: Remove stale comments
      lockd: Create a simplified .vs_dispatch method for NLM requests
      lockd: Common NLM XDR helpers
      lockd: Update the NLMv1 void argument decoder to use struct xdr_stream
      lockd: Update the NLMv1 TEST arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 LOCK arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 CANCEL arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 UNLOCK arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 nlm_res arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 SM_NOTIFY arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 SHARE arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 FREE_ALL arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 void results encoder to use struct xdr_stream
      lockd: Update the NLMv1 TEST results encoder to use struct xdr_stream
      lockd: Update the NLMv1 nlm_res results encoder to use struct xdr_stream
      lockd: Update the NLMv1 SHARE results encoder to use struct xdr_stream
      lockd: Update the NLMv4 void arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 TEST arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 LOCK arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 CANCEL arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 UNLOCK arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 nlm_res arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 SM_NOTIFY arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 SHARE arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 FREE_ALL arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 void results encoder to use struct xdr_stream
      lockd: Update the NLMv4 TEST results encoder to use struct xdr_stream
      lockd: Update the NLMv4 nlm_res results encoder to use struct xdr_stream
      [ Upstream commit 0ff5b50ab1f7f39862d0cdf6803978d31b27f25e ]
      NFSD: Prevent a possible oops in the nfs_dirent() tracepoint
      NFSD: Clean up splice actor
      SUNRPC: Add svc_rqst_replace_page() API
      NFSD: Batch release pages during splice read
      SUNRPC: Add svc_rqst::rq_auth_stat
      SUNRPC: Set rq_auth_stat in the pg_authenticate() callout
      SUNRPC: Eliminate the RQ_AUTHERR flag
      NFS: Add a private local dispatcher for NFSv4 callback operations
      NFS: Remove unused callback void decoder
      NLM: Fix svcxdr_encode_owner()
      SUNRPC: Trace calls to .rpc_call_done
      NFSD: Optimize DRC bucket pruning
      NFSD: Have legacy NFSD WRITE decoders use xdr_stream_subsegment()
      SUNRPC: Replace the "__be32 *p" parameter to .pc_decode
      SUNRPC: Change return value type of .pc_decode
      NFSD: Save location of NFSv4 COMPOUND status
      SUNRPC: Replace the "__be32 *p" parameter to .pc_encode
      SUNRPC: Change return value type of .pc_encode
      NFSD: Fix exposure in nfsd4_decode_bitmap()
      NFSD: Fix READDIR buffer overflow
      NFSD: Fix sparse warning
      NFSD: Remove be32_to_cpu() from DRC hash function
      NFSD: Combine XDR error tracepoints
      NFSD: De-duplicate nfsd4_decode_bitmap4()
      NFSD: Fix zero-length NFSv3 WRITEs
      NFSD: Clean up nfsd_vfs_write()
      NFSD: De-duplicate net_generic(SVC_NET(rqstp), nfsd_net_id)
      NFSD: De-duplicate net_generic(nf->nf_net, nfsd_net_id)
      NFSD: Write verifier might go backwards
      NFSD: Clean up the nfsd_net::nfssvc_boot field
      NFSD: Rename boot verifier functions
      NFSD: Trace boot verifier resets
      Revert "nfsd: skip some unnecessary stats in the v4 case"
      NFSD: Move fill_pre_wcc() and fill_post_wcc()
      NFSD: Fix the behavior of READ near OFFSET_MAX
      NFSD: Fix ia_size underflow
      NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes
      NFSD: COMMIT operations must not return NFS?ERR_INVAL
      NFSD: Deprecate NFS_OFFSET_MAX
      NFSD: De-duplicate hash bucket indexing
      NFSD: Skip extra computation for RC_NOCACHE case
      NFSD: Streamline the rare "found" case
      SUNRPC: Remove the .svo_enqueue_xprt method
      SUNRPC: Merge svc_do_enqueue_xprt() into svc_enqueue_xprt()
      SUNRPC: Remove svo_shutdown method
      SUNRPC: Rename svc_create_xprt()
      SUNRPC: Rename svc_close_xprt()
      SUNRPC: Remove svc_shutdown_net()
      NFSD: Remove svc_serv_ops::svo_module
      NFSD: Move svc_serv_ops::svo_function into struct svc_serv
      NFSD: Remove CONFIG_NFSD_V3
      NFSD: Clean up _lm_ operation names
      NFSD: Clean up nfsd_splice_actor()
      NFSD: Clean up nfsd3_proc_create()
      NFSD: Avoid calling fh_drop_write() twice in do_nfsd_create()
      NFSD: Refactor nfsd_create_setattr()
      NFSD: Refactor NFSv3 CREATE
      NFSD: Refactor NFSv4 OPEN(CREATE)
      NFSD: Remove do_nfsd_create()
      NFSD: Clean up nfsd_open_verified()
      NFSD: Instantiate a struct file when creating a regular NFSv4 file
      NFSD: Remove dprintk call sites from tail of nfsd4_open()
      NFSD: Fix whitespace
      NFSD: Move documenting comment for nfsd4_process_open2()
      NFSD: Trace filecache opens
      NFSD: Clean up the show_nf_flags() macro
      SUNRPC: Use RMW bitops in single-threaded hot paths
      NFSD: Modernize nfsd4_release_lockowner()
      NFSD: Add documenting comment for nfsd4_release_lockowner()
      NFSD: nfsd_file_put() can sleep
      NFSD: Fix potential use-after-free in nfsd_file_put()
      SUNRPC: Optimize xdr_reserve_space()
      NFSD: Decode NFSv4 birth time attribute
      SUNRPC: Fix xdr_encode_bool()
      NFSD: Demote a WARN to a pr_warn()
      NFSD: Report filecache LRU size
      NFSD: Report count of calls to nfsd_file_acquire()
      NFSD: Report count of freed filecache items
      NFSD: Report average age of filecache items
      NFSD: Add nfsd_file_lru_dispose_list() helper
      NFSD: Refactor nfsd_file_gc()
      NFSD: Refactor nfsd_file_lru_scan()
      NFSD: Report the number of items evicted by the LRU walk
      NFSD: Record number of flush calls
      NFSD: Zero counters when the filecache is re-initialized
      NFSD: Hook up the filecache stat file
      NFSD: WARN when freeing an item still linked via nf_lru
      NFSD: Trace filecache LRU activity
      NFSD: Leave open files out of the filecache LRU
      NFSD: Fix the filecache LRU shrinker
      NFSD: Never call nfsd_file_gc() in foreground paths
      NFSD: No longer record nf_hashval in the trace log
      NFSD: Remove lockdep assertion from unhash_and_release_locked()
      NFSD: nfsd_file_unhash can compute hashval from nf->nf_inode
      NFSD: Refactor __nfsd_file_close_inode()
      NFSD: nfsd_file_hash_remove can compute hashval
      NFSD: Remove nfsd_file::nf_hashval
      NFSD: Replace the "init once" mechanism
      NFSD: Set up an rhashtable for the filecache
      NFSD: Convert the filecache to use rhashtable
      NFSD: Clean up unused code after rhashtable conversion
      NFSD: Separate tracepoints for acquire and create
      NFSD: Move nfsd_file_trace_alloc() tracepoint
      NFSD: NFSv4 CLOSE should release an nfsd_file immediately
      NFSD: Ensure nf_inode is never dereferenced
      NFSD: Optimize nfsd4_encode_operation()
      NFSD: Optimize nfsd4_encode_fattr()
      NFSD: Clean up SPLICE_OK in nfsd4_encode_read()
      NFSD: Add an nfsd4_read::rd_eof field
      NFSD: Optimize nfsd4_encode_readv()
      NFSD: Simplify starting_len
      NFSD: Use xdr_pad_size()
      NFSD: Clean up nfsd4_encode_readlink()
      NFSD: Fix strncpy() fortify warning
      NFSD: nfserrno(-ENOMEM) is nfserr_jukebox
      NFSD: Shrink size of struct nfsd4_copy_notify
      NFSD: Shrink size of struct nfsd4_copy
      NFSD: Reorder the fields in struct nfsd4_op
      NFSD: Make nfs4_put_copy() static
      NFSD: Replace boolean fields in struct nfsd4_copy
      NFSD: Refactor nfsd4_cleanup_inter_ssc() (1/2)
      NFSD: Refactor nfsd4_cleanup_inter_ssc() (2/2)
      NFSD: Refactor nfsd4_do_copy()
      NFSD: Remove kmalloc from nfsd4_do_async_copy()
      NFSD: Add nfsd4_send_cb_offload()
      NFSD: Move copy offload callback arguments into a separate structure
      NFSD: Increase NFSD_MAX_OPS_PER_COMPOUND
      NFSD: Protect against send buffer overflow in NFSv2 READDIR
      NFSD: Protect against send buffer overflow in NFSv3 READDIR
      NFSD: Protect against send buffer overflow in NFSv2 READ
      NFSD: Protect against send buffer overflow in NFSv3 READ
      NFSD: Fix handling of oversized NFSv4 COMPOUND requests
      NFSD: Add tracepoints to report NFSv4 callback completions
      NFSD: Add a mechanism to wait for a DELEGRETURN
      NFSD: Refactor nfsd_setattr()
      NFSD: Make nfsd4_setattr() wait before returning NFS4ERR_DELAY
      NFSD: Make nfsd4_rename() wait before returning NFS4ERR_DELAY
      NFSD: Make nfsd4_remove() wait before returning NFS4ERR_DELAY
      SUNRPC: Parametrize how much of argsize should be zeroed
      NFSD: Reduce amount of struct nfsd4_compoundargs that needs clearing
      NFSD: Refactor common code out of dirlist helpers
      NFSD: Use xdr_inline_decode() to decode NFSv3 symlinks
      NFSD: Clean up WRITE arg decoders
      NFSD: Clean up nfs4svc_encode_compoundres()
      NFSD: Remove "inline" directives on op_rsize_bop helpers
      NFSD: Remove unused nfsd4_compoundargs::cachetype field
      NFSD: Pack struct nfsd4_compoundres
      NFSD: Rename the fields in copy_stateid_t
      NFSD: Cap rsize_bop result based on send buffer size
      NFSD: Fix reads with a non-zero offset that don't end on a page boundary
      NFSD: Finish converting the NFSv2 GETACL result encoder
      NFSD: Finish converting the NFSv3 GETACL result encoder
      NFSD: Pass the target nfsd_file to nfsd_commit()
      NFSD: Revert "NFSD: NFSv4 CLOSE should release an nfsd_file immediately"
      NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file garbage collection
      NFSD: Flesh out a documenting comment for filecache.c
      NFSD: Clean up nfs4_preprocess_stateid_op() call sites
      NFSD: Trace stateids returned via DELEGRETURN
      NFSD: Trace delegation revocations
      NFSD: Use const pointers as parameters to fh_ helpers
      NFSD: Update file_hashtbl() helpers
      NFSD: Clean up nfsd4_init_file()
      NFSD: Add a nfsd4_file_hash_remove() helper
      NFSD: Clean up find_or_add_file()
      NFSD: Refactor find_file()
      NFSD: Use rhashtable for managing nfs4_file objects
      NFSD: Fix licensing header in filecache.c
      NFSD: Add an nfsd_file_fsync tracepoint
      NFSD: Use only RQ_DROPME to signal the need to drop a reply
      Revert "SUNRPC: Use RMW bitops in single-threaded hot paths"
      NFSD: Use set_bit(RQ_DROPME)
      NFSD: copy the whole verifier in nfsd_copy_write_verifier
      NFSD: Protect against filesystem freezing
      NFSD: Avoid calling OPDESC() with ops->opnum == OP_ILLEGAL
      NFSD: Convert filecache to rhltable
      NFSD: Add an nfsd4_encode_nfstime4() helper
      nfsd: don't allow nfsd threads to be signalled.
      Documentation: Add missing documentation for EXPORT_OP flags

Colin Ian King (4):
      nfsd: remove redundant assignment to pointer 'this'
      NFSD: Initialize pointer ni with NULL and not plain integer 0
      nfsd: remove redundant assignment to variable len
      NFSD: Remove redundant assignment to variable host_err

Dai Ngo (26):
      NFSv4_2: SSC helper should use its own config.
      NFSv4.2: Remove ifdef CONFIG_NFSD from NFSv4.2 client SSC code.
      NFSD: delay unmount source's export after inter-server copy completed.
      nfsd: fix kernel test robot warning in SSC code
      fs/lock: documentation cleanup. Replace inode->i_lock with flc_lock.
      NFSD: add courteous server support for thread with only delegation
      NFSD: add support for share reservation conflict to courteous server
      NFSD: move create/destroy of laundry_wq to init_nfsd and exit_nfsd
      fs/lock: add helper locks_owner_has_blockers to check for blockers
      fs/lock: add 2 callbacks to lock_manager_operations to resolve conflict
      NFSD: add support for lock conflict to courteous server
      NFSD: Show state of courtesy client in client info
      NFSD: refactoring v4 specific code to a helper in nfs4state.c
      NFSD: keep track of the number of v4 clients in the system
      NFSD: limit the number of v4 clients to 1024 per 1GB of system memory
      NFSD: keep track of the number of courtesy clients in the system
      NFSD: add shrinker to reap courtesy clients on low memory condition
      NFSD: refactoring courtesy_client_reaper to a generic low memory shrinker
      NFSD: add support for sending CB_RECALL_ANY
      NFSD: add delegation reaper to react to low memory condition
      NFSD: register/unregister of nfsd-client shrinker at nfsd startup/shutdown time
      NFSD: replace delayed_work with work_struct for nfsd_client_shrinker
      NFSD: enhance inter-server copy cleanup
      NFSD: fix leaked reference count of nfsd4_ssc_umount_item
      NFSD: fix problems with cleanup on errors in nfsd4_copy
      NFSD: Fix problem of COMMIT and NFS4ERR_DELAY in infinite loop

Dan Carpenter (1):
      nfsd: fix double fget() bug in __write_ports_addfd()

Dave Wysochanski (1):
      nfsd4: Expose the callback address and state of each NFS4 client

David Disseldorp (1):
      exportfs: use pr_debug for unreachable debug statements

Eric W. Biederman (24):
      exec: Don't open code get_close_on_exec
      exec: Move unshare_files to fix posix file locking during exec
      exec: Simplify unshare_files
      exec: Remove reset_files_struct
      kcmp: In kcmp_epoll_target use fget_task
      bpf: In bpf_task_fd_query use fget_task
      proc/fd: In proc_fd_link use fget_task
      file: Rename __fcheck_files to files_lookup_fd_raw
      file: Factor files_lookup_fd_locked out of fcheck_files
      file: Replace fcheck_files with files_lookup_fd_rcu
      file: Rename fcheck lookup_fd_rcu
      file: Implement task_lookup_fd_rcu
      proc/fd: In tid_fd_mode use task_lookup_fd_rcu
      kcmp: In get_file_raw_ptr use task_lookup_fd_rcu
      file: Implement task_lookup_next_fd_rcu
      proc/fd: In proc_readfd_common use task_lookup_next_fd_rcu
      proc/fd: In fdinfo seq_show don't use get_files_struct
      file: Merge __fd_install into fd_install
      file: In f_dupfd read RLIMIT_NOFILE once.
      file: Merge __alloc_fd into alloc_fd
      file: Rename __close_fd to close_fd and remove the files parameter
      file: Replace ksys_close with close_fd
      exit: Implement kthread_exit
      exit: Rename module_put_and_exit to module_put_and_kthread_exit

Gabriel Krisman Bertazi (24):
      fsnotify: Don't insert unmergeable events in hashtable
      fanotify: Fold event size calculation to its own function
      fanotify: Split fsid check from other fid mode checks
      inotify: Don't force FS_IN_IGNORED
      fsnotify: Add helper to detect overflow_event
      fsnotify: Add wrapper around fsnotify_add_event
      fsnotify: Retrieve super block from the data field
      fsnotify: Protect fsnotify_handle_inode_event from no-inode events
      fsnotify: Pass group argument to free_event
      fanotify: Support null inode event in fanotify_dfid_inode
      fanotify: Allow file handle encoding for unhashed events
      fanotify: Encode empty file handle when no inode is provided
      fanotify: Require fid_mode for any non-fd event
      fsnotify: Support FS_ERROR event type
      fanotify: Reserve UAPI bits for FAN_FS_ERROR
      fanotify: Pre-allocate pool of error events
      fanotify: Support enqueueing of error events
      fanotify: Support merging of error events
      fanotify: Wrap object_fh inline space in a creator macro
      fanotify: Add helpers to decide whether to report FID/DFID
      fanotify: WARN_ON against too large file handles
      fanotify: Report fid info for file related file system errors
      fanotify: Emit generic error info for error event
      fanotify: Allow users to request FAN_FS_ERROR events

Gaosheng Cui (3):
      nfsd: remove nfsd4_prepare_cb_recall() declaration
      fsnotify: remove unused declaration
      fanotify: Remove obsoleted fanotify_event_has_path()

Guobin Huang (1):
      NFSD: Use DEFINE_SPINLOCK() for spinlock

Gustavo A. R. Silva (2):
      UAPI: nfsfh.h: Replace one-element array with flexible-array member
      nfsd: Fix fall-through warnings for Clang

Haowen Bai (1):
      SUNRPC: Return true/false (not 1/0) from bool functions

Huang Guobin (1):
      nfsd: Fix error return code in nfsd_file_cache_init()

J. Bruce Fields (41):
      nfsd: only call inode_query_iversion in the I_VERSION case
      nfsd: simplify nfsd4_change_info
      nfsd: minor nfsd4_change_attribute cleanup
      nfsd4: don't query change attribute in v2/v3 case
      Revert "nfsd4: support change_attr_type attribute"
      nfsd4: simplify process_lookup1
      nfsd: simplify process_lock
      nfsd: simplify nfsd_renew
      nfsd: rename lookup_clientid->set_client
      nfsd: refactor set_client
      nfsd: find_cpntf_state cleanup
      nfsd: remove unused set_client argument
      nfsd: simplify nfsd4_check_open_reclaim
      nfsd: cstate->session->se_client -> cstate->clp
      nfs: use change attribute for NFS re-exports
      nfsd: skip some unnecessary stats in the v4 case
      nfsd: helper for laundromat expiry calculations
      nfsd: COPY with length 0 should copy to end of file
      nfsd: don't ignore high bits of copy count
      nfsd: hash nfs4_files by inode number
      nfsd: track filehandle aliasing in nfs4_files
      nfsd: reshuffle some code
      nfsd: grant read delegations to clients holding writes
      nfsd: move some commit_metadata()s outside the inode lock
      nfsd: move fsnotify on client creation outside spinlock
      nfsd: rpc_peeraddr2str needs rcu lock
      nfsd: fix NULL dereference in nfs3svc_encode_getaclres
      nlm: minor nlm_lookup_file argument change
      nlm: minor refactoring
      lockd: update nlm_lookup_file reexport comment
      Keep read and write fds with each nlm_file
      nfs: don't atempt blocking locks on nfs reexports
      lockd: don't attempt blocking locks on nfs reexports
      nfs: don't allow reexport reclaims
      nfsd: update create verifier comment
      nfsd4: remove obselete comment
      nfsd: improve stateid access bitmask documentation
      nfs: block notification on fs with its own ->lock
      nfsd: fix crash on COPY_NOTIFY with special stateid
      lockd: fix server crash on reboot of client holding lock
      lockd: fix failure to cleanup client locks

Jakob Koschel (1):
      nfsd: fix using the correct variable for sizeof()

Jeff Layton (58):
      nfsd: add a new EXPORT_OP_NOWCC flag to struct export_operations
      nfsd: allow filesystems to opt out of subtree checking
      nfsd: close cached files prior to a REMOVE or RENAME that would replace target
      nfsd: Add errno mapping for EREMOTEIO
      nfsd: Retry once in nfsd_open on an -EOPENSTALE return
      lockd: set fl_owner when unlocking files
      lockd: fix nlm_close_files
      nfsd: eliminate the NFSD_FILE_BREAK_* flags
      nfsd: silence extraneous printk on nfsd.ko insertion
      NFSD: drop fh argument from alloc_init_deleg
      NFSD: verify the opened dentry after setting a delegation
      lockd: detect and reject lock arguments that overflow
      nfsd: clean up mounted_on_fileid handling
      nfsd: only fill out return pointer on success in nfsd4_lookup_stateid
      nfsd: fix comments about spinlock handling with delegations
      nfsd: make nfsd4_run_cb a bool return function
      nfsd: extra checks when freeing delegation stateids
      nfsd: fix nfsd_file_unhash_and_dispose
      nfsd: rework hashtable handling in nfsd_do_file_acquire
      nfsd: fix net-namespace logic in __nfsd_file_cache_purge
      nfsd: fix use-after-free in nfsd_file_do_acquire tracepoint
      nfsd: put the export reference in nfsd4_verify_deleg_dentry
      filelock: add a new locks_inode_context accessor function
      lockd: use locks_inode_context helper
      nfsd: use locks_inode_context helper
      nfsd: ignore requests to disable unsupported versions
      nfsd: move nfserrno() to vfs.c
      nfsd: allow disabling NFSv2 at compile time
      nfsd: remove the pages_flushed statistic from filecache
      nfsd: reorganize filecache.c
      nfsd: fix up the filecache laundrette scheduling
      nfsd: return error if nfs4_setacl fails
      lockd: set missing fl_flags field when retrieving args
      lockd: ensure we use the correct file descriptor when unlocking
      lockd: fix file selection in nlmsvc_cancel_blocked
      nfsd: rework refcounting in filecache
      nfsd: fix handling of cached open files in nfsd4_open codepath
      nfsd: don't free files unconditionally in __nfsd_file_cache_purge
      nfsd: don't destroy global nfs4_file table in per-net shutdown
      nfsd: allow nfsd_file_get to sanely handle a NULL pointer
      nfsd: clean up potential nfsd_file refcount leaks in COPY codepath
      nfsd: don't hand out delegation on setuid files being opened for write
      nfsd: fix courtesy client with deny mode handling in nfs4_upgrade_open
      nfsd: don't fsync nfsd_files on last close
      lockd: set file_lock start and end when decoding nlm4 testargs
      nfsd: don't replace page in rq_pages if it's a continuation of last page
      nfsd: call op_release, even when op_func returns an error
      nfsd: don't open-code clear_and_wake_up_bit
      nfsd: NFSD_FILE_KEY_INODE only needs to find GC'ed entries
      nfsd: simplify test_bit return in NFSD_FILE_KEY_FULL comparator
      nfsd: don't kill nfsd_files because of lease break error
      nfsd: add some comments to nfsd_file_do_acquire
      nfsd: don't take/put an extra reference when putting a file
      nfsd: update comment over __nfsd_file_cache_purge
      nfsd: allow reaping files still under writeback
      nfsd: simplify the delayed disposal list code
      nfsd: make a copy of struct iattr before calling notify_change
      nfsd: drop the nfsd_put helper

Jia He (2):
      sysctl: introduce new proc handler proc_dobool
      lockd: change the proc_handler for nsm_use_hostnames

Jiapeng Chong (2):
      nfsd: remove unused function
      NFSD: Fix inconsistent indenting

Jinpeng Cui (1):
      NFSD: remove redundant variable status

Julian Schroeder (1):
      nfsd: destroy percpu stats counters after reply cache shutdown

Kees Cook (1):
      NFSD: Avoid clashing function prototypes

Matthew Bobrowski (5):
      kernel/pid.c: remove static qualifier from pidfd_create()
      kernel/pid.c: implement additional checks upon pidfd_create() parameters
      fanotify: minor cosmetic adjustments to fid labels
      fanotify: introduce a generic info record copying helper
      fanotify: add pidfd support to the fanotify API

NeilBrown (48):
      nfsd: report client confirmation status in "info" file
      NFSD: remove vanity comments
      NFSD: move filehandle format declarations out of "uapi".
      NFSD: drop support for ancient filehandles
      NFSD: simplify struct nfsfh
      NFSD: handle errors better in write_ports_addfd()
      SUNRPC: change svc_get() to return the svc.
      SUNRPC/NFSD: clean up get/put functions.
      SUNRPC: stop using ->sv_nrthreads as a refcount
      nfsd: make nfsd_stats.th_cnt atomic_t
      SUNRPC: use sv_lock to protect updates to sv_nrthreads.
      NFSD: narrow nfsd_mutex protection in nfsd thread
      NFSD: Make it possible to use svc_set_num_threads_sync
      SUNRPC: discard svo_setup and rename svc_set_num_threads_sync()
      NFSD: simplify locking for network notifier.
      lockd: introduce nlmsvc_serv
      lockd: simplify management of network status notifiers
      lockd: move lockd_start_svc() call into lockd_create_svc()
      lockd: move svc_exit_thread() into the thread
      lockd: introduce lockd_put()
      lockd: rename lockd_create_svc() to lockd_get()
      SUNRPC: move the pool_map definitions (back) into svc.c
      SUNRPC: always treat sv_nrpools==1 as "not pooled"
      lockd: use svc_set_num_threads() for thread start and stop
      NFS: switch the callback service back to non-pooled.
      NFSD: simplify per-net file cache management
      NFS: restore module put when manager exits.
      NFSD: introduce struct nfsd_attrs
      NFSD: set attributes when creating symlinks
      NFSD: add security label to struct nfsd_attrs
      NFSD: add posix ACLs to struct nfsd_attrs
      NFSD: change nfsd_create()/nfsd_symlink() to unlock directory before returning.
      NFSD: always drop directory lock in nfsd_unlink()
      NFSD: only call fh_unlock() once in nfsd_link()
      NFSD: reduce locking in nfsd_lookup()
      NFSD: use explicit lock/unlock for directory ops
      NFSD: use (un)lock_inode instead of fh_(un)lock for file operations
      NFSD: discard fh_locked flag and fh_lock/fh_unlock
      NFSD: fix regression with setting ACLs.
      NFSD: drop fname and flen args from nfsd_create_locked()
      lockd: drop inappropriate svc_get() from locked_get()
      nfsd: Simplify code around svc_exit_thread() call in nfsd()
      nfsd: separate nfsd_last_thread() from nfsd_put()
      NFSD: fix possible oops when nfsd/pool_stats is closed.
      nfsd: call nfsd_last_thread() before final nfsd_put()
      nfsd: fix RELEASE_LOCKOWNER
      nfsd: don't take fi_lock in nfsd_break_deleg_cb()
      nfsd: don't call locks_release_private() twice concurrently

Olga Kornievskaia (2):
      NFSD add vfs_fsync after async copy is done
      NFSD enforce filehandle check for source file in COPY

Oliver Ford (1):
      fs: inotify: Fix typo in inotify comment

Ondrej Valousek (1):
      nfsd: Add support for the birth time attribute

Paul Menzel (1):
      nfsd: Log client tracking type log message as info instead of warning

Peng Tao (1):
      nfsd: map EBADF

Ricardo Ribalda (1):
      nfsd: Fix typo "accesible"

Shakeel Butt (1):
      inotify, memcg: account inotify instances to kmemcg

Tavian Barnes (1):
      nfsd: Fix creation time serialization order

Tetsuo Handa (1):
      NFSD: unregister shrinker when nfsd_init_net() fails

Tom Rix (1):
      NFSD: A semicolon is not needed after a switch statement.

Trond Myklebust (11):
      exportfs: Add a function to return the raw output from fh_to_dentry()
      nfsd: Fix up nfsd to ensure that timeout errors don't result in ESTALE
      nfsd: Set PF_LOCAL_THROTTLE on local filesystems only
      nfsd: Record NFSv4 pre/post-op attributes as non-atomic
      NFS: fix nfs_fetch_iversion()
      nfsd: Fix a warning for nfsd_file_close_inode
      nfsd: Add a tracepoint for errors in nfsd4_clone_file_range()
      nfsd: Fix a write performance regression
      nfsd: Clean up nfsd_file_put()
      lockd: set other missing fields when unlocking files
      nfsd: Fix a regression in nfsd_setattr()

Vasily Averin (3):
      nfsd: removed unused argument in nfsd_startup_generic()
      nfsd4: add refcount for nfsd4_blocked_lock
      fanotify: fix incorrect fmode_t casts

Waiman Long (1):
      inotify: Increase default inotify.max_user_watches limit to 1048576

Wei Yongjun (1):
      NFSD: Fix error return code in nfsd4_interssc_connect()

Wolfram Sang (2):
      NFSD: move from strlcpy with unused retval to strscpy
      lockd: move from strlcpy with unused retval to strscpy

Xin Gao (1):
      fsnotify: Fix comment typo

Xingyuan Mo (1):
      NFSD: fix use-after-free in nfsd4_ssc_setup_dul()

Xiu Jianfeng (1):
      NFSD: Use struct_size() helper in alloc_session()

Yang Li (1):
      fanotify: remove variable set but not used

Yu Hsiang Huang (1):
      nfsd: Prevent truncation of an unlinked inode from blocking access to its directory

Zhang Jiaming (1):
      NFSD: Fix space and spelling mistake

Zhang Xiaoxu (2):
      nfsd: Unregister the cld notifier when laundry_wq create failed
      nfsd: Fix null-ptr-deref in nfsd_fill_super()

Zheng Yongjun (1):
      fs/lockd: convert comma to semicolon

 Documentation/filesystems/files.rst          |    8 +-
 Documentation/filesystems/locking.rst        |   10 +-
 Documentation/filesystems/nfs/exporting.rst  |   78 +++++
 arch/powerpc/platforms/cell/spufs/coredump.c |    2 +-
 crypto/algboss.c                             |    4 +-
 fs/Kconfig                                   |    6 +-
 fs/autofs/dev-ioctl.c                        |    5 +-
 fs/cachefiles/namei.c                        |    9 +-
 fs/cifs/connect.c                            |    2 +-
 fs/coredump.c                                |    5 +-
 fs/ecryptfs/inode.c                          |   10 +-
 fs/exec.c                                    |   29 +-
 fs/exportfs/expfs.c                          |   40 ++-
 fs/file.c                                    |  177 +++++------
 fs/init.c                                    |    6 +-
 fs/lockd/clnt4xdr.c                          |    9 +-
 fs/lockd/clntproc.c                          |    3 -
 fs/lockd/host.c                              |    4 +-
 fs/lockd/svc.c                               |  262 +++++++--------
 fs/lockd/svc4proc.c                          |   70 +++-
 fs/lockd/svclock.c                           |   67 ++--
 fs/lockd/svcproc.c                           |   62 +++-
 fs/lockd/svcsubs.c                           |  123 +++++---
 fs/lockd/svcxdr.h                            |  142 +++++++++
 fs/lockd/xdr.c                               |  448 +++++++++++++-------------
 fs/lockd/xdr4.c                              |  472 +++++++++++++--------------
 fs/locks.c                                   |  102 ++++--
 fs/namei.c                                   |   21 +-
 fs/nfs/blocklayout/blocklayout.c             |    2 +-
 fs/nfs/blocklayout/dev.c                     |    2 +-
 fs/nfs/callback.c                            |  111 ++-----
 fs/nfs/callback_xdr.c                        |   33 +-
 fs/nfs/dir.c                                 |    2 +-
 fs/nfs/export.c                              |   17 +
 fs/nfs/file.c                                |    3 +
 fs/nfs/filelayout/filelayout.c               |    4 +-
 fs/nfs/filelayout/filelayoutdev.c            |    2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c       |    4 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c    |    2 +-
 fs/nfs/nfs42xdr.c                            |    2 +-
 fs/nfs/nfs4state.c                           |    2 +-
 fs/nfs/nfs4xdr.c                             |    6 +-
 fs/nfs/pagelist.c                            |    3 -
 fs/nfs/super.c                               |    8 +
 fs/nfs/write.c                               |    3 -
 fs/nfs_common/Makefile                       |    2 +-
 fs/nfs_common/nfs_ssc.c                      |    2 -
 fs/nfs_common/nfsacl.c                       |  123 ++++++++
 fs/nfsd/Kconfig                              |   36 ++-
 fs/nfsd/Makefile                             |    8 +-
 fs/nfsd/acl.h                                |    6 +-
 fs/nfsd/blocklayout.c                        |    1 +
 fs/nfsd/blocklayoutxdr.c                     |    1 +
 fs/nfsd/cache.h                              |    2 +-
 fs/nfsd/export.c                             |   74 ++++-
 fs/nfsd/export.h                             |   16 +-
 fs/nfsd/filecache.c                          | 1229 ++++++++++++++++++++++++++++++++++++++++-------------------------------
 fs/nfsd/filecache.h                          |   23 +-
 fs/nfsd/flexfilelayout.c                     |    3 +-
 fs/nfsd/lockd.c                              |   10 +-
 fs/nfsd/netns.h                              |   63 ++--
 fs/nfsd/nfs2acl.c                            |  214 +++++--------
 fs/nfsd/nfs3acl.c                            |  140 ++++----
 fs/nfsd/nfs3proc.c                           |  396 +++++++++++++++--------
 fs/nfsd/nfs3xdr.c                            | 1763 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------
 fs/nfsd/nfs4acl.c                            |   45 +--
 fs/nfsd/nfs4callback.c                       |  168 +++++++---
 fs/nfsd/nfs4idmap.c                          |    9 +-
 fs/nfsd/nfs4layouts.c                        |    4 +-
 fs/nfsd/nfs4proc.c                           | 1111 ++++++++++++++++++++++++++++++++++++++++------------------------
 fs/nfsd/nfs4recover.c                        |   20 +-
 fs/nfsd/nfs4state.c                          | 1725 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
 fs/nfsd/nfs4xdr.c                            | 3763 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------------------------------------------------------
 fs/nfsd/nfscache.c                           |  115 ++++---
 fs/nfsd/nfsctl.c                             |  169 +++++-----
 fs/nfsd/nfsd.h                               |   50 ++-
 fs/nfsd/nfsfh.c                              |  291 +++++++++--------
 fs/nfsd/nfsfh.h                              |  179 +++++------
 fs/nfsd/nfsproc.c                            |  262 ++++++++-------
 fs/nfsd/nfssvc.c                             |  356 ++++++++++-----------
 fs/nfsd/nfsxdr.c                             |  834 +++++++++++++++++++++++++-----------------------
 fs/nfsd/state.h                              |   69 +++-
 fs/nfsd/stats.c                              |  126 +++++---
 fs/nfsd/stats.h                              |   96 ++++--
 fs/nfsd/trace.c                              |    1 +
 fs/nfsd/trace.h                              |  894 ++++++++++++++++++++++++++++++++++++++++++++++------
 fs/nfsd/vfs.c                                |  931 +++++++++++++++++++++++++++---------------------------
 fs/nfsd/vfs.h                                |   60 ++--
 fs/nfsd/xdr.h                                |   68 ++--
 fs/nfsd/xdr3.h                               |  116 ++++---
 fs/nfsd/xdr4.h                               |  127 ++++----
 fs/nfsd/xdr4cb.h                             |    6 +
 fs/notify/dnotify/dnotify.c                  |   17 +-
 fs/notify/fanotify/fanotify.c                |  487 +++++++++++++++++++++-------
 fs/notify/fanotify/fanotify.h                |  252 +++++++++++++--
 fs/notify/fanotify/fanotify_user.c           |  882 +++++++++++++++++++++++++++++++++++++++++----------
 fs/notify/fdinfo.c                           |   19 +-
 fs/notify/fsnotify.c                         |  183 ++++++-----
 fs/notify/fsnotify.h                         |   19 +-
 fs/notify/group.c                            |   38 ++-
 fs/notify/inotify/inotify.h                  |   11 +-
 fs/notify/inotify/inotify_fsnotify.c         |   12 +-
 fs/notify/inotify/inotify_user.c             |   87 +++--
 fs/notify/mark.c                             |  172 ++++++----
 fs/notify/notification.c                     |   78 ++---
 fs/open.c                                    |   49 ++-
 fs/overlayfs/overlayfs.h                     |    9 +-
 fs/proc/fd.c                                 |   48 +--
 fs/udf/file.c                                |    2 +-
 fs/verity/enable.c                           |    2 +-
 include/linux/dnotify.h                      |    2 +-
 include/linux/errno.h                        |    1 +
 include/linux/exportfs.h                     |   15 +
 include/linux/fanotify.h                     |   74 ++++-
 include/linux/fdtable.h                      |   37 ++-
 include/linux/fs.h                           |   54 +++-
 include/linux/fsnotify.h                     |   77 +++--
 include/linux/fsnotify_backend.h             |  372 ++++++++++++++++++----
 include/linux/iversion.h                     |   13 +
 include/linux/kallsyms.h                     |   17 +-
 include/linux/kthread.h                      |    1 +
 include/linux/lockd/bind.h                   |    3 +-
 include/linux/lockd/lockd.h                  |   17 +-
 include/linux/lockd/xdr.h                    |   35 +-
 include/linux/lockd/xdr4.h                   |   33 +-
 include/linux/module.h                       |   24 +-
 include/linux/nfs.h                          |    8 -
 include/linux/nfs4.h                         |   21 +-
 include/linux/nfs_ssc.h                      |   14 +
 include/linux/nfsacl.h                       |    6 +
 include/linux/pid.h                          |    1 +
 include/linux/sched/user.h                   |    3 -
 include/linux/sunrpc/msg_prot.h              |    3 -
 include/linux/sunrpc/svc.h                   |  151 +++++----
 include/linux/sunrpc/svc_rdma.h              |    4 +-
 include/linux/sunrpc/svc_xprt.h              |   16 +-
 include/linux/sunrpc/svcauth.h               |    4 +-
 include/linux/sunrpc/svcsock.h               |    7 +-
 include/linux/sunrpc/xdr.h                   |  153 ++++++++-
 include/linux/syscalls.h                     |   12 -
 include/linux/sysctl.h                       |    2 +
 include/linux/user_namespace.h               |    4 +
 include/trace/events/sunrpc.h                |   26 +-
 include/uapi/linux/fanotify.h                |   42 +++
 include/uapi/linux/nfs3.h                    |    6 +
 include/uapi/linux/nfsd/nfsfh.h              |  105 ------
 kernel/audit_fsnotify.c                      |    8 +-
 kernel/audit_tree.c                          |    2 +-
 kernel/audit_watch.c                         |    5 +-
 kernel/bpf/inode.c                           |    2 +-
 kernel/bpf/syscall.c                         |   20 +-
 kernel/bpf/task_iter.c                       |    2 +-
 kernel/fork.c                                |   12 +-
 kernel/kallsyms.c                            |    8 +-
 kernel/kcmp.c                                |   29 +-
 kernel/kthread.c                             |   23 +-
 kernel/livepatch/core.c                      |    7 +-
 kernel/module.c                              |   26 +-
 kernel/pid.c                                 |   15 +-
 kernel/sys.c                                 |    2 +-
 kernel/sysctl.c                              |   54 +++-
 kernel/trace/trace_kprobe.c                  |    4 +-
 kernel/ucount.c                              |    4 +
 mm/madvise.c                                 |    2 +-
 mm/memcontrol.c                              |    2 +-
 mm/mincore.c                                 |    2 +-
 net/bluetooth/bnep/core.c                    |    2 +-
 net/bluetooth/cmtp/core.c                    |    2 +-
 net/bluetooth/hidp/core.c                    |    2 +-
 net/sunrpc/auth_gss/gss_rpc_xdr.c            |    2 +-
 net/sunrpc/auth_gss/svcauth_gss.c            |   47 +--
 net/sunrpc/sched.c                           |    1 +
 net/sunrpc/svc.c                             |  314 +++++++++---------
 net/sunrpc/svc_xprt.c                        |  104 +++---
 net/sunrpc/svcauth.c                         |    8 +-
 net/sunrpc/svcauth_unix.c                    |   18 +-
 net/sunrpc/svcsock.c                         |   32 +-
 net/sunrpc/xdr.c                             |  112 +++++--
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c   |    2 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c        |   32 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c     |    2 +-
 net/unix/af_unix.c                           |    2 +-
 tools/objtool/check.c                        |    3 +-
 183 files changed, 13910 insertions(+), 8823 deletions(-)
 create mode 100644 fs/lockd/svcxdr.h
 delete mode 100644 include/uapi/linux/nfsd/nfsfh.h

-- 
Chuck Lever

