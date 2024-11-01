Return-Path: <linux-nfs+bounces-7617-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F4B9B9177
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 14:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4F41F214FC
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 13:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4D2487A7;
	Fri,  1 Nov 2024 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BbOnayJ6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i/dBn6Zr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E8E15F40B
	for <linux-nfs@vger.kernel.org>; Fri,  1 Nov 2024 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466224; cv=fail; b=Nod0xVi2gUOOVQwhPSj2YjvS58//IvyktFsm9xIbVi8h65kGiAqc/ByqwpASjpoTNp4HKhO2OD7PeEvaJpyswjAQJO+m4qDmwTrl55ax7kO2UQQEiexCjIxCvZ2Ds/o0XspOprk1flb4YplGEAdtrvq1Msfn7SEfBX7m2JJMViI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466224; c=relaxed/simple;
	bh=0o4rNULIz1I/7RpaQRhhZ1FPyZhu2afT9s2ZsEvLOpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JcGWQqA0f5wwO9hv6Y2qdKxo07RhEwwULpCld3IxonrHfAEe8hh0fxrrah3auC78F6o6i7RZLiegpCXoqYxKnVkHBUkl2PD28s0XF/bdx1ru1Do8gI9xa4JMCEoKLzSYbw6sostTNhu/7vyz+eD4uUohemUjJLBUOfMIu8F9ATg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BbOnayJ6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i/dBn6Zr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1C3R0P011990;
	Fri, 1 Nov 2024 13:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=J3G1QZqLnIzxYw+RBQ
	IEQ0yzXX5R1KW1rUDvIrEw19c=; b=BbOnayJ6M6BGdi5mmlzKoAb2knDf9SGP6i
	Za+Pc4JJn8mifuq+x8QWMvnF0Czf+sxC/IT47ViYh+Pb8SbY3h3yimMbaCE9xLPC
	Rq97E0uTeE1wteW1W+U9ivmQ1WCa15GZHWXXzHjTrFhvR6fOM8IYJbllFOYmddJ9
	2yjwtOEaBMW6wKTW8HP5emr6g7/u4EacL6kaxV4dMxOWw8JGQDhwPmWFSmaNhEFg
	bdcfI1olaKJ9mDBWmXpd2qRV/hrFvpg7G2Jmd3zDNMvArcssgsngZrjY+XLiSa6w
	glV7pDJrh3M9JwT6bPGZgxVz3ZLJOwMPRHka1Th8Lchs38sWKD0g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgwm41w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 13:03:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1B4XMU004765;
	Fri, 1 Nov 2024 13:03:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2y22qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 13:03:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbOSTwV70ckf8yn8lKizt4ksh1qmIsh4757Tv+f6hN1hv0SRdWLe+PXlQBno+VlF2puvOZKU/05bJuPH4j3GAIDhRpEmLALZUeWUV0rlyB9xOa0T3R8egm44bm96elt7OBsvnMWh5GKKuXZuMFwUHK2YgNZzZJkSdwZoV90BOXsDIkKe+ABF1JzabpJy4VYd3w+SWkHAYlxy/r2nw21XII/vBKuh5/1S9NWuBr8Of/QKVqOmIWBVQ04lQQUKE05THVKxskC41aDJ9aFO0Sv75/7BiX0HL6uUJk2LSK04hqmKp0ZOfSoRwsf2fRhRXkszmKb4qxPKz1unAr5Me52kbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3G1QZqLnIzxYw+RBQIEQ0yzXX5R1KW1rUDvIrEw19c=;
 b=RjPMhMqeR5x8IckQfmxDSSqBxu+31soSMsgjUUfJq8euJLICnWE8AA10+4GCT9tduAZhb/c1WxKcgiYSZLUmBLY3gw5DXwowTOE1fyvdT9F+46pAbl1M2OcMoPx/cytatT95Dhi9lenC2gxFIDZbtIDgrnXzXP64y9ubBx4vjAF+DWR6nWwzFETJWWHN7v3pJJMzq4Xp+oY3Otf7m1Hhd8s2FAw+60af6WPx5bRB4Crzrp89RgA1Nl4/+TJX7qq1MEGL6+lbzBA2HgfsaBDuDLnelY+QOejmqgAxCnxCD+/qsRMQ2q1Nzad8HCEGXLv8YRN6CXIxg6G3PjyaK/c/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3G1QZqLnIzxYw+RBQIEQ0yzXX5R1KW1rUDvIrEw19c=;
 b=i/dBn6ZrjFnSOIyoeis329F3uJF9jrW6TJ8AmIMU1eEYRu7jI+g9o4GkoiOE9uTzzNsRT0/LI1omayWAUtCiOcvf9YDA/GxjzJm+bjDEZ/MZlmZpsaDkQIIJQerUhV+gfRQFw2rv+0Uf83+vGoy+J5/zMrtHntKQoIXi5SCkHRU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4958.namprd10.prod.outlook.com (2603:10b6:5:3a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 13:03:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 13:03:28 +0000
Date: Fri, 1 Nov 2024 09:03:25 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: cel@kernel.org, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 4/8] NFSD: Handle an NFS4ERR_DELAY response to
 CB_OFFLOAD
Message-ID: <ZyTRnT0CGPLAtge8@tissot.1015granger.net>
References: <20241031134000.53396-10-cel@kernel.org>
 <20241031134000.53396-14-cel@kernel.org>
 <66e92d1deb55da2a3cd3f72538fb245d5fc7808d.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66e92d1deb55da2a3cd3f72538fb245d5fc7808d.camel@kernel.org>
X-ClientProxiedBy: CH2PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:610:57::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f40cade-faee-46d9-8b7d-08dcfa7593f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3I5u2Khg4i3EFoxltvCwP00yat4SA7W0KSPu6watM7ib58NrNf+x4JTajb0a?=
 =?us-ascii?Q?1wpPk+oFMB8KOy6k/no360JhiCCy5S9yl53UInJOOfLABXJc0p9m07MML0F3?=
 =?us-ascii?Q?67Db4DmbL5QIV4fWVuAMwe1u37tLkiZyKtXQRvx63ISOukOtu0UuHZSjuc39?=
 =?us-ascii?Q?kv152ZvYjeqCu+pbyKw3F8upAiWYdh19wFMf/eO9aQHXqUn7hYdx8L1Bs9NB?=
 =?us-ascii?Q?+n61N+d4mSZwQnA2BEWawrHMFzZ8GR7PmZ+8zSD6cV92U7DjNkt1uPWGdUr8?=
 =?us-ascii?Q?xxA0q68fAWTP44gTXrANb2p9QwZKgmWgTz/xXsRxuOIlaZWuQMphZHowka6E?=
 =?us-ascii?Q?vtfBUwfudICtixyLQhsEP4SqSAwBYaSosqr0IpUmomH+0bbpMVPrAp1M56YA?=
 =?us-ascii?Q?xDqfxY9C6ju3QgXnXxlR87eU36S/2smNOzc0GbXTNZNCeltVub9kmjpi2w6P?=
 =?us-ascii?Q?Kg3GXf9fEuOVz4FT8VBo/TJBIey5OOcsAkrHYQCUeNa6DtVK1ZX9nAHTUguu?=
 =?us-ascii?Q?wIAI3UFdA9+meI1BlpH1Dtcdd9SuWvPzFMxr48oX/lMQsA2QGC9eeSScgv2+?=
 =?us-ascii?Q?Xu+GFSHOYPL5S1oL5biqBBooJc/AcCs5VRIHUjAD2Ub+mdr5zPaZuUKesuoG?=
 =?us-ascii?Q?5OP+zdlc1WrXJWGCk2Pr4Jk5Mv6R83CBevTi2YaVB0VxXBYOz9o6tFCZoRyV?=
 =?us-ascii?Q?+c+xNrUJRtecazuo8TDC/kZtOB7V5MILSdvVb08RSp1YLLf6/scQaEUQUf44?=
 =?us-ascii?Q?hv8pjnCk7LcrlKIgxES+TaypDLy4kRYz/SbVJB8Cd7MJtDzxi+4aJgl8H4nn?=
 =?us-ascii?Q?IVjLGcYtHssm5rwjygHg6bYvII2LjhD5JvKG9GsTdFSzM0LK7SJtC6Xh/GnL?=
 =?us-ascii?Q?68mtp2oZywLde+apYR84j/8IoC8fgZVjQdqppsuOf/LSNlcdjSlza2kLbUi1?=
 =?us-ascii?Q?Q9QZ2iTuzjSgFQFJGU76fVACoIrmMDUubUnCkglwkcovJPcRAmSQj3Gagdk7?=
 =?us-ascii?Q?OKM6dUPfMI1MGuFC3upspfWf8wtRvLq5IX/+/Km68Kkwbaw3VCrMYWq2ARCp?=
 =?us-ascii?Q?l8YZD1zEdSLQGLSzPxrQOVAGXAeiht+H4cya0nfkDuZgs0n2HZEmU5kVPnMV?=
 =?us-ascii?Q?Z+3Ejx2Ex8YZYQTIqLdyWbmJrgDFohGzP8R/zdNYwba+FBO+0O65dJjIMOQu?=
 =?us-ascii?Q?Vn3aaqcr3t6XxSLiP3RgmKvBhCO8pWvHJjwGhPuljnO4r9FrRvtzE9gr/sqV?=
 =?us-ascii?Q?VeEPqBN/esKnk2Bp65WmW+qX/UmDkA/xeXo0b1Su9nzHyfcJLcUCNmgjx5tF?=
 =?us-ascii?Q?ys4WAZ1x/ZQC5N095Bj+Q7ko?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rY49H4JKeON2Lm7pTBu/n/dSTmbjhNclGKPvZeOeu26DpskegmVz8aXjKvc/?=
 =?us-ascii?Q?c3eqertMBQygw/nS1otV//rr0MBzC8iHfXEIs9LI0cIUUxz5h3B5yIYQoKtd?=
 =?us-ascii?Q?piYcVzcChyfAlFA2GL0cx31xPOTwtsTC5schtlJffDi2bfZbdbx9qInN3rC9?=
 =?us-ascii?Q?AYO5RwwnFWirLuiFKjiiDHFiUo7n9KIpz4L+XkwSI17jJ11byXbWs/2dG3q8?=
 =?us-ascii?Q?Mbz8v+T8K77UkPtaui+C/nTU3RuAfcKBY3fcRB3e8urRJe9nvAs5jjLOfmRB?=
 =?us-ascii?Q?XV5rcdl4U6uChaeUWXcqDcyLgQW0o7wZvjfPyHpd4S73bs0gafMlW8h44A91?=
 =?us-ascii?Q?KLIRdl5/c0eGmZ7zfIWWuK6buZyl4/zrvtKz/cvSvAc82LwIdAqBAN54zTP6?=
 =?us-ascii?Q?+tsR6oAHxNw8Rx07YvUGX1Iupe/uZP+gfdR/Pb4WvpetxmkQOdKW9dwoIzk/?=
 =?us-ascii?Q?XqWnirRmp/6CY433Yi70umFWCSNO86EkDAztMADt2gTs4Mg5MD1bbXHPZVvm?=
 =?us-ascii?Q?JYCiTXJ8rTyqGwTIit1hGG0O8/0esfqvW+6ahWuDOc1d7UgWJiifiRB8g7uV?=
 =?us-ascii?Q?RISjdSNDlHQQgnQAGuQtKOjyLmxnULLu3W6rPLf2dBftyDDULj1SIAXqXFtg?=
 =?us-ascii?Q?ekfi2dlmfSaCprcLjPVaD/aTYjphwP8/XFlPtL1Bk0NVAt2LgHgEx/TInMvK?=
 =?us-ascii?Q?M72eAT4JXSiT5b+nEnNESfE5oJgoqAcsdzi+J+DOrih91SOZbBmqYjZa1hG5?=
 =?us-ascii?Q?yNrMhl9SMaNMtrxrqYMGn0JFXLL5+ui2TY+jZiY1ZmEVlDWbOtdxhYbs5Nbm?=
 =?us-ascii?Q?LbapCkXmCtEqW4dBsDY8Q6oFn0s6Gk1CvwOpoCvk0bcTERgcgR5q8KknWyfN?=
 =?us-ascii?Q?dKlAS73N7/fvmCEut2WIQoY4DArXW3XicSrqdwe3IddG+FGCVE1aPPWqKHl+?=
 =?us-ascii?Q?mZkiTpQ3b2JkHDqr7cp0h/8Qvnb1/EECPGXZc57v8zZD+Qx7/OdsLEq+GxI/?=
 =?us-ascii?Q?rghJTEBNYstDXhRBT+3otO883mBGNkoVQniTsTXakwyI2T4WLvvJ6tCQiwZ8?=
 =?us-ascii?Q?oVrcKaFD0PUnu6q8L1jhZbWGbrRhPfeIJtWh441aIwdrfsxZ0uGOSYWkL0V7?=
 =?us-ascii?Q?fubHcgDTbmx90BAY0Tq+RqAogQEROw/g63YQ3EYLK5vMRCw3gScgrC1DJ9h7?=
 =?us-ascii?Q?PN0s1+dO2SU5auTZxKW0faETh6JUpV/kq4schrQPIGKD5LH4rpbgC0A+iaU2?=
 =?us-ascii?Q?rHudVSbS0/IXmchDlzSElGLDYp3Go7gC2bFlfjCH0L/RUHuHxSHf/QDEm+pe?=
 =?us-ascii?Q?AIkhBvC5MKZovBqBI44vdoPFik16QLmh8CLsqMykCOM7+w9LfjC2ZZN0+s63?=
 =?us-ascii?Q?CfD/TlaqWTFfR8e5iXVNry0V8oy54mlZ8Me3kzy82QeNJU5hpBrTFfq0U9Hm?=
 =?us-ascii?Q?w3VyTtR8HcCC9KWbhByakFMV6DDFLusKOvci5lQlvI5HNBRYj+F4jV3umydn?=
 =?us-ascii?Q?V/ekfVMy5KPiBv67cT9gAWSWRTEWiF0oJm2H3fqD0/0Q85r71lJSXy0/JZn9?=
 =?us-ascii?Q?/EWWv/0c1HflJef6xY8Sz991DX+JqJGeliji1KHz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+gB0qCz0vdiGIT2itDA/awxBtuXubQNXpTig5BwSL4pj0KBfRZqIkU5bVeyEjg5Z9NGoBbCiO5u7v7wE1wx73iS0AazBxydhB9E9V9bb9wX6xIix2OrN8hpL2/sX5sihVG2fkJaE/Mm4xBOvBcZIvwH7iKG/kAcqN2ROyfBNdOU1cw+/YCZv+y7f02vmiMCq5sywt7LZLRMcKWa0N1wxjjCiz6jd+HWl+7LR3Bq+G6FbalnwsDv1hJGgW+shinVtxHzE4Zp16Q8Ld7ZCxgMCz9+5F0GEtYnKUSPUEYKvucU3XJylZ3xzgDULnX1eE6RpbFV06EFAf/Du8Zi9u75gpH8sp2YhSdsgakCA9kVBQVFvhK5n9Sek/Guf1mrc/hv9T6f+8Bn99MY3G1JFkbCf9lX+8xhTqNcD24XWmUlgjDLK/vJHUXZCYYy5EVgiEH6AuPw6xIWvofWVbo4UwBtIJrEmVPssskupuqhcEdcwwEmrPdR+RUw+RNeQJ3bH/l3fZvRQG5a0erChrssl5jyxVFnl5dB51G7HC9qzTgbm06VsybILDg7atl4HR2KnQwcNPp9VWcu43uzkVdscQKHfN6CKT3443GTdK/dD0qA8Zno=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f40cade-faee-46d9-8b7d-08dcfa7593f7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:03:28.1521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKPTpUSPATHhGERXTC5BxyDXENYfovK+PKiap9oPvwIDkGelNhSEK+2EegFr/lI17mcKjwlmnl9rArjbAyXWwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_08,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010093
X-Proofpoint-ORIG-GUID: r5Kn9Y5A-fqvd9uCWLsLCscZmppPyN9t
X-Proofpoint-GUID: r5Kn9Y5A-fqvd9uCWLsLCscZmppPyN9t

On Fri, Nov 01, 2024 at 08:41:33AM -0400, Jeff Layton wrote:
> On Thu, 2024-10-31 at 09:40 -0400, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > RFC 7862 permits callback services to respond to CB_OFFLOAD with
> > NFS4ERR_DELAY. Currently NFSD drops the CB_OFFLOAD in that case.
> > 
> > To improve the reliability of COPY offload, NFSD should rather send
> > another CB_OFFLOAD completion notification.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfs4proc.c | 8 ++++++++
> >  fs/nfsd/xdr4.h     | 1 +
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 39e90391bce2..0918d05c54a1 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1617,6 +1617,13 @@ static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
> >  		container_of(cb, struct nfsd4_cb_offload, co_cb);
> >  
> >  	trace_nfsd_cb_offload_done(&cbo->co_res.cb_stateid, task);
> > +	switch (task->tk_status) {
> > +	case -NFS4ERR_DELAY:
> > +		if (cbo->co_retries--) {
> > +			rpc_delay(task, 1 * HZ);
> > +			return 0;
> > +		}
> > +	}
> >  	return 1;
> 
> Not a comment on your patch specifically, but when we can't send a
> callback, should we be trying to log something? A pr_notice() warning?
> Conditional tracepoint? I'm not sure of the best way to communicate
> this, but it seems like something that admins might want to know.

There is a tracepoint here and in every other callback completion
handler.

I can't think of anything actionable to report -- what would an
admin need or want to do in response to a callback failure? There
isn't much to do if, for instance, the client doesn't recognize the
copy stateid.

Also, DELAY is not infrequent and is a common temporary condition.

My sense is that the only time you want to see callback failures is
when you're looking for something specific. Otherwise, it will
generate a lot of low-value noise.


> Maybe nfsd needs its own trace buffer that could be scraped with
> nfsdctl?

The Flight Data Recorder can do that if needed.


> >  }
> >  
> > @@ -1745,6 +1752,7 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
> >  	memcpy(&cbo->co_res, &copy->cp_res, sizeof(copy->cp_res));
> >  	memcpy(&cbo->co_fh, &copy->fh, sizeof(copy->fh));
> >  	cbo->co_nfserr = copy->nfserr;
> > +	cbo->co_retries = 5;
> >  
> >  	nfsd4_init_cb(&cbo->co_cb, copy->cp_clp, &nfsd4_cb_offload_ops,
> >  		      NFSPROC4_CLNT_CB_OFFLOAD);
> > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > index dec29afa43f3..cd2bf63651e3 100644
> > --- a/fs/nfsd/xdr4.h
> > +++ b/fs/nfsd/xdr4.h
> > @@ -675,6 +675,7 @@ struct nfsd4_cb_offload {
> >  	struct nfsd4_callback	co_cb;
> >  	struct nfsd42_write_res	co_res;
> >  	__be32			co_nfserr;
> > +	unsigned int		co_retries;
> >  	struct knfsd_fh		co_fh;
> >  };
> >  
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

