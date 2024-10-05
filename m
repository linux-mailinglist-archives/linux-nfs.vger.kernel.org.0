Return-Path: <linux-nfs+bounces-6880-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA77991785
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 16:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855E81F22AB7
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 14:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4FA14EC47;
	Sat,  5 Oct 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AJaDwA18";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S4SzaHV1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC531B960;
	Sat,  5 Oct 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728140031; cv=fail; b=U/K25CL2TTGr5U8FZ6kwAIc6WHn80mpfH0DwuStEQiF298Dp+bWGGdR3nTfUsVcWMFCVpVtSbwnFuMX9+CpTFTprKOwFGVqqx4RL25sOFsgfz+D2LZtVyye/Fa9SgXBo+M/ri5JoKcGu/PeUNSBTWAXpI1xLcKNLPegHnY1Y2ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728140031; c=relaxed/simple;
	bh=MbHncH/AAys3+M85zuxUTtKLyAX263n1biJWAOuzfOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=He9nz8TMmYcjNdP7C2uE2wqmjVrqJBV7DeH77jCMsxWWDaROGbqHatWIcdAnKjOSnWsCYLmig/315soRY0Tw+rxAoQkz3C3oR9TVuZCSildhMS+IY+ieq+YArdmcRmfBiODJ2IoWXeiid9mRT/pMSSEfw4x7E429mUBYc7veQTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AJaDwA18; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S4SzaHV1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 495DW4oj013281;
	Sat, 5 Oct 2024 14:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=0mVlrdHFgRQTr4F0Kq
	EkOVaij2/X7OyscH6+VZWYIB4=; b=AJaDwA1860TiB1D7XsInSMUeQjWfizZ40o
	U6/f9yG15jOBzGj5MlpmnD+Ph+q8pEKWKLz/KwD2Yn1UhgOZoUHNumXSWw4oh/Tr
	dDfDdy1JGCIrPMa99BANcPhWRkMaosd2QANhy9azYdzeDuiUPo6CJYLtApzpbNQs
	0uEky6lrfTkqEFJtMor/KKT9V0QxiuCNfUo26H49Ib6DKeqZkrkeOIGZ/C3uuBZL
	RskaKpS4YO3Pe7srfTXcNv6lutxnr0d1GXyLq2/SGXXkSWw24ZOY60dkSQIYC6x9
	aQsCd1imjibGhoHFQZQv7C1Sbxl1QXbhRCwk0jD7diRJp833M2xQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303y8asg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 14:53:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 495BFFLM011636;
	Sat, 5 Oct 2024 14:53:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw4bbqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 14:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udT8C+7d5+n5Uf6JJh39Ebd7QK2HlfwOnKpl9elnWCEm1wdL3iF18diHPiCw6nmd0HSZ3XKZpGxpS6jLn47Kkc7lmZx53Kwm7DdEFjXTK1xnIqaf7hudEDWJjDcfu5Ag6MRtkA8RnpkxHOiDLo5lApVXMU1If1hZnH6lFUyOx00A/SWgEfW+w2a0BrXKheGSv5zkyr42FgKXqEdSw6jS8cOHM1up7//QtI7BQEDISA52v/dHOa7aQMktFQemcUO+zUbeR04e3YibUShgXlhmq3aubz/LElHHLvlpPKeV6TKy5M3wuh0+l23/smJ417CTk7kDfDebFQfaFclPzOhaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mVlrdHFgRQTr4F0KqEkOVaij2/X7OyscH6+VZWYIB4=;
 b=b4lVLStCu7ww2lp0H2t4B0ashWq2OWGuEhuRzwUr2kcz6jJJpgDWlFJ6x86qDUFh87RlofNbHhyE+lTBRGtyGyDiDamuwv/XqIrQczntfQFKnU9lUwtS0ZOIobS6eEFzLVidalLUi12e+UQT6E+9YGGi4EboQbzTbYOrH/KyCqa+BT5PecIjRkFaCLDMGBPdWlasfHCDQl3O48UxXf/cZ0H/0RwNcAhznUBI80GRel7gh4c4TXsXBgAlqaYTZGkrjO94GXhbg7MXA7Cb3UDuMQdCY5AYD/jC3kORL0ZvYpM/92uJ15OAzQW5g+jXNRhDlbile6/yGRwOrSGYb5xWzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mVlrdHFgRQTr4F0KqEkOVaij2/X7OyscH6+VZWYIB4=;
 b=S4SzaHV13OBthNMSVHIdIOJTKu3H98D0fKGlVyCT56yhnDYCB21cLmRjgfb3Phn7sBzNCYYWSHhK9RJdrCwNLGh5R2jpOUGfwoHs6jbpL+e7aB4vEu5e2evxYbDRkRy2ACIrbU4Y9cQrKsyd854IOh6mIfmNUaYcTRTxWn4QE/c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7941.namprd10.prod.outlook.com (2603:10b6:408:1fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sat, 5 Oct
 2024 14:53:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 14:53:30 +0000
Date: Sat, 5 Oct 2024 10:53:28 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd: fix possible badness in FREE_STATEID
Message-ID: <ZwFS6P3Ni7KdTyJs@tissot.1015granger.net>
References: <20241004220403.50034-1-okorniev@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004220403.50034-1-okorniev@redhat.com>
X-ClientProxiedBy: CH0PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:610:75::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV8PR10MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fed3e0-d217-49f3-6a7f-08dce54d7a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FbZp+3GjfVXPhWEyNbqk7uLUoJzHx9HHG1UsOQO+JJ/N6r0ETXG/zQI3z2RP?=
 =?us-ascii?Q?ktpamnrEiIHNhysFlt+zZFyYY1KdjNLmU0hVN7xWC7SwMeEAdnn3/ZA9DPnD?=
 =?us-ascii?Q?Y/tMN3vZN12dPInT5J9av+7MvknDkAhR1kNyvqS6y5FJlyOxOzo7DlcoZetI?=
 =?us-ascii?Q?Q8oLibgO+440K1wnQ9S+OSAj7pKbGd9JJhz4Thic7O90A+VbDH5bxQSo2gvy?=
 =?us-ascii?Q?fUV8omqI75ep/9+8clBlSpvsQECx1gQO0OEwr9i5m32++2hq0tTEjVQxbsJp?=
 =?us-ascii?Q?hGHwnCh02MGLeqf6qP1zbIV3RYroARLCX55GvN12g3pL8vk/uqOJd2TaiRWH?=
 =?us-ascii?Q?tM20NSAgPdnJXkkWYAJOOiFpbTdEam2pqq20/LBjvAdmiUTHc7lFmU1seKbh?=
 =?us-ascii?Q?I0oebGQednOhs4OZ1oU6QK1nDCQcgEwieOCFfSIOKLFg8+f3LPmAGJasLDTB?=
 =?us-ascii?Q?h6WgFU/hdEx52uD9qfbKK88KIGnBuG8b4iKKy92W6NRx4gfUOA5BUlSVCHdY?=
 =?us-ascii?Q?clXXL37qp6NMwCVoPCz1p9SAgToPpQm7gOmj+oKo2hOWFnDqLtByHTMJaxd8?=
 =?us-ascii?Q?i9HQraMyE1/vlWnCYuBllZ1nJs5ipUJtWxG6ipgQL3TBNmrdklQ+pHpV4nfQ?=
 =?us-ascii?Q?E6BuZIYlgeDkKJHKoDNLgsVKrc9+KRM6FuTYTm3efEaS30WX93085ya9oril?=
 =?us-ascii?Q?UL8LFMYlvJ5GuXeOo2wM8qnxePPd1+HiZmZTwABXcI9P6ON9YHTu7dK6xVW+?=
 =?us-ascii?Q?xb1gn7mpMdBA90GGHpMuoQvcn/eTG5qKff7PV9F6GPgtC0sbLQU0pPEOjBOe?=
 =?us-ascii?Q?uImBXEQBj3hvXpeSqiyghzksrRSoy8wMo/qfyqGDQUMJaWP6HxiZiMOhk9Bn?=
 =?us-ascii?Q?poKGgRtqTkyXnejUTHi/+Ex7WNvwfOgp3P1U1ERoVifwDu20cJRbZKnLhgnj?=
 =?us-ascii?Q?Fv13vWXIEw8/qgFrggD2UmG21t/pILsLghwoGol9OME+yl6EK6b8Dngse75x?=
 =?us-ascii?Q?P35WwS8w+kRAWUGjMw/s4/ooOBmMB8UXiTPyOPsvsjO0mkK9IM32m89rPmeK?=
 =?us-ascii?Q?eg5u8SlXF9dLcGqIB1lvV983t5ziFO93KPEfxi/H1w33nYR60RyZnMiYTNds?=
 =?us-ascii?Q?gQz6g7iFsik46BAJYTTKVFmziQ9yJtG8lszo5HNhQLtY/sEl1D1Ea3Mu2zyW?=
 =?us-ascii?Q?2w4z3W9Q5pKFnkkxWWI0hto5s8pXMIGQQBeUYl9XRksJxZC8oM0vk0eIb7xF?=
 =?us-ascii?Q?eBdprkEu9PJLU8LPiASocBsTWxZCNP8fMmyp7qfrJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cnEZadFfzfleosJ/fkUYP/iXyA7ICZ4thS/MD9TzY4bYJYKczH9+kl1gzEc5?=
 =?us-ascii?Q?SQeERFiqH69iJ8q8bLoPNZcbVf98pJuMfsKA1phULy+HspgIwS0NLNLpaDsf?=
 =?us-ascii?Q?Oj4T7XPgOO3ND+sjGKhUcMHzcKYfQCeKnUuAuhjlR3YEhJv05AlhlqG8qnXE?=
 =?us-ascii?Q?W469AGgQUxkob5n88hpEaMu6LdvrB5TtK3/3RwkP/g989SysBS00tdQDGTNz?=
 =?us-ascii?Q?daK2ACTYqYt1QCrtIu+C+UCbWQOC6/6zOjGOVb4RnOi0NSI6oq66hCOOFpxp?=
 =?us-ascii?Q?YdDKWKUdHkVEukA4fnR2H+AXeG6uQ2Hyu/OeuY221LU9Vin9Xslc/LjRUlII?=
 =?us-ascii?Q?z3RgHq5T9upTE8xT0RyCD2SR6g9nPHc0hst8POP+5s3ZHtOWbGESb5J/oLqy?=
 =?us-ascii?Q?qwxGKtiRRsYsAX4eb1klBClG9hOFVYTLdX7bLp4+cUvabFKRjmaXk76JD8wG?=
 =?us-ascii?Q?phPPqOLRqr6fYbk5GphMzMZcdN9Q7Z58Ael71sfcZbXyYL2nm3Oo8bXD9rFt?=
 =?us-ascii?Q?ulMcBPnubQZrtsGvkBBSkPJTTbG4Z4eY/ssrx0FZPG8ze6Qhr0E/9UHgK7H+?=
 =?us-ascii?Q?CO2VcdOZ1OXUJDKpRHxf12/Euam6Ovps9n0H+9us7je00KlTmVRzTRip5AmD?=
 =?us-ascii?Q?rqAsB0Hqnu657CJj7oaoU9pq0hDuTTAItJ6GOBvTGamVjxZryVd00WyqgO03?=
 =?us-ascii?Q?hC4XxFt3HkvVnHaM+RlDqb+2Pm1v8v0mdvRCi4EVzAbDaxsbb+B3TG6uhKtG?=
 =?us-ascii?Q?4It40+9WdW8SAjTm8Rq93+hsa008tZzLRvtHTJm9cqFfunJGrnA1V+UNcmhU?=
 =?us-ascii?Q?jXyYmn1hthdWA6HSdvd3xdHrCbLYe8F1svOWF32NGvHyh91VLMoERMd2BnYZ?=
 =?us-ascii?Q?2Xfkqr6wmDbR+vHoHZ97SGxyFWsloSnY1IF9SStwlbRt9tUITA3Zfc3XsgCu?=
 =?us-ascii?Q?QSDvZVK2kOZIvX4COl2Vu6EL1hVLK7kKH+eDJc4DakQKJ4vmC32SxVEon7/q?=
 =?us-ascii?Q?5VF4B+0gUaTS3JepTS+ND911+YBsozi4kURSPaD6lhYxBMe+ZIjFLMLSma6+?=
 =?us-ascii?Q?Jj16qp9gy8P+YWTezXhVuUpeQh2uTte1SGMFS56dnUm4/r5F2Nfmu0J2SyAN?=
 =?us-ascii?Q?5+6yh219x+DecBO5VlLeR12qJl30Q9cZPaE3LOIqIISefTL5phfwos20XpvJ?=
 =?us-ascii?Q?LO9sDaTUfszo6g9G63eTlhTus8tztdm3ZhWOC0+RGn3+ccjtn0duAv+QbtaO?=
 =?us-ascii?Q?uDhL3oMYK+pCoN4AUy3tpADiDuxsD5aPtXGve9cfCkzCrGvc+VG/fxOq41ZS?=
 =?us-ascii?Q?JQcqv+Dqo69FKS4eXFnUytUbC3UzkXMDyDBn8KUbtGQBH4x289sEb0JwHgxM?=
 =?us-ascii?Q?nquUQdKOxiZg9iuSIFFy+4fyAVpMUaFjw0T+e96LOVBGy3Ni59wPnbNWvIQ6?=
 =?us-ascii?Q?IdHJ7bzs7dGy8nvRGg05PNxY3p7ZDmW0HuigfsjBVg36YbJWTMVTEQNNej1E?=
 =?us-ascii?Q?rVAbMe1+9LE7y+Oh0trJkuYTXtxpAMBswxWRKR2zpdL4c91LhEDxpmVhB9B0?=
 =?us-ascii?Q?YX0+BBV+HCoqu8oOjDPfPmNf/nL43R7x79xKx6x9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kfDRdYMjqLPWhi6mlQSP5uXhToyDSqnCakYPnCPUjJw/Nq1ge+aDNZ8xuFNIVwMKKjpuW92MWFEp5cIzGDRmXPXKAdOaHs49DAg8pBwCMn2u879dv5mDt6JeNViBBwvscBl8CFvdKcybWbKd6T9eDxAfDpAN85GXzkTAZyvK8FAkUqm+/2u1XukQMs5yI1q9KIXCO2SwTu4/HdEdJL5UIDo43Y1FXUo/qPMwpXBljQdVe5Pvx3S0LJ7JPn/+clSFbQwWik0cbxXxLRRFStllScpepZJZ8NesZHqwZzbCr1Opo937A1n6pWIPaZsz5PSV3p8QlvyxMRl14gQpwlYZaSpJNL/yY3JzRcupXwYS/8moGKLz4SXYUHIhyYpBCnCFTJuXi3oHI+LCWzWBPCR1W8E0W69EdClxJkvuLqMLu51mkZcf4PaIScKlBjbT4vJdrjbbWGxmYH/Fcbgc4KRnjhf36RsFemSbBZMEm0Ov54yuR2pONj/XvKiV496UTK4xE2dHYvlz9GSAfXaByR1wP6+wfry051XYsSsaLKp5uzhqVFeUGejQzFVSo9Wp5vxyOGQEYhCi0Fl50jBdTH0cVCkmN5DbTBk38lHhEKc5yBY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fed3e0-d217-49f3-6a7f-08dce54d7a34
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 14:53:30.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49NWvK4gWetssJ9Mk9lMful1x1bsycbKwMuJEo3D0JtsofBhBW7wL+tYKOV6H8PKLVmK8lihG93VzLzTfUdWrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7941
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_12,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410050108
X-Proofpoint-ORIG-GUID: -JOeD5PjMd9zmCzzyZ-8MehecjjMednG
X-Proofpoint-GUID: -JOeD5PjMd9zmCzzyZ-8MehecjjMednG

On Fri, Oct 04, 2024 at 06:04:03PM -0400, Olga Kornievskaia wrote:
> When multiple FREE_STATEIDs are sent for the same delegation stateid,
> it can lead to a possible either use-after-tree or counter refcount
> underflow errors.
> 
> In nfsd4_free_stateid() under the client lock we find a delegation
> stateid, however the code drops the lock before calling nfs4_put_stid(),
> that allows another FREE_STATE to find the stateid again. The first one
> will proceed to then free the stateid which leads to either
> use-after-free or decrementing already zerod counter.
> 
> CC: stable@vger.kernel.org

I assume that the broken commit is pretty old, but this fix does not
apply before v6.9 (where sc_status is introduced). I can add
"# v6.9+" to the Cc: stable tag.

But what do folks think about a Fixes: tag?

Could be e1ca12dfb1be ("NFSD: added FREE_STATEID operation"), but
that doesn't have the switch statement, which was added by
2da1cec713bc ("nfsd4: simplify free_stateid").


> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ac1859c7cc9d..56b261608af4 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7154,6 +7154,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	switch (s->sc_type) {
>  	case SC_TYPE_DELEG:
>  		if (s->sc_status & SC_STATUS_REVOKED) {
> +			s->sc_status |= SC_STATUS_CLOSED;
>  			spin_unlock(&s->sc_lock);
>  			dp = delegstateid(s);
>  			list_del_init(&dp->dl_recall_lru);
> -- 
> 2.43.5
> 

-- 
Chuck Lever

