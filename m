Return-Path: <linux-nfs+bounces-7670-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AF69BCFAB
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 15:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10497B21EEB
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005873BB48;
	Tue,  5 Nov 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XVzzSRj8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iyOeDS3v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40AEAD2
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817997; cv=fail; b=b7uQvA8HijlbkKxQryD1+5VUw8STGMKxJw9W13ErCejdvPcMuhkMioBZn1r8GbucYShY/Uv7rRedw6lAzRupr252eLN6eOKN+1rABuTIjAsuen/AHjyhsy4BkU9OINgFG3+Hz4rWjiUPMv+7toC92o7JZufUvxdwkdiGrJLzUiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817997; c=relaxed/simple;
	bh=2UWG6q/AJCz7yftde67/x/7iU/7wlbrJdj0o18IylUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=omMaGk5QxCU9M+nIIPF7vh++O0uBjZtB5zCjU3OxlJmVI9fzxPi+kUkgeIlIqWrWNJCNcKTjfJLXA8lnsncQBHaln47hqQJIzbryeKbgl/um2fGTUuxKgL1pWGcvhhsUtCb1LYMy/0a1qR3xs7/XfmUyAdbbqJe4Klml8XtQrzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XVzzSRj8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iyOeDS3v; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5DiZBu030190;
	Tue, 5 Nov 2024 14:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=A/gTudL5cFFJ7IPVfH
	O02xmUpdoFCJvXpQ2VfUUX1DA=; b=XVzzSRj8dh6KtEHLKo9Wh53lvQrmKWXyoQ
	WJLxau05PgHf4THoW577DIrKh2MRvgatkWNTGf6QrBPV555B+zVIu1EPDGcUtY78
	ALXo8kGBzYI+NZlSFGgLnDoPj9jLq5ahrUe8tn8lm6h3YCVgwa1BtO7O6QIURMFv
	qya9ZgZAoEGfJ6t2X8qvaC2qeEZwGsZoma9eULh5Q9uQb4vXtJAu94dS2BvRV9kC
	QhTXr0u27clHjPERCQBhqhWPaRknWcvK30s4YKd/iyYSczs0YRg7Zf/7X7RXmPOV
	GQ430/RcOJpx0InDSgeopPsfTyMD5yKCACDWd1ZchkbIbuI9fbPg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nanywj66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 14:46:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5EHMvI008500;
	Tue, 5 Nov 2024 14:46:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah77pq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 14:46:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXl7PpmCpf1CXLbybA37jheTGs0Q75DVSZ3L1+S2VwoSUiV5jojEP9iKWj4X+Ca9msD5cP2j6n8GsJ9DloCYXOvCGhc8fNtD1bWVy91QXXy0xSPrkrHTbge/aApbvt4oIAeTpFzIBDyj2tZ4u/Brm2ScgvPWhcpEceKLyCbUN7iP+elVyp5g9XXcr4mCA7HUhmqD1mozF3cpDMKbVandd8SSljGOw4CPrTB0FYRBsLYUxu7WcGQDR2cGZ3fDhSlYkWdSk/IYcu7odxaWcKRBfAX2Es/ZvGNIE9UNgQsVedILjBygoqs2FnorSnpHq6t2DCfDttmU9Rfg1hIVdaIIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/gTudL5cFFJ7IPVfHO02xmUpdoFCJvXpQ2VfUUX1DA=;
 b=McWO/7oC28gYG6dt2bYpXNpjXMDMJX0nfxPxIVJ3r7RDkesKDxVdpRgVYjp5lgtuvuDo2kGmuvtcsiuW+IwlOGk2v23Z8WdetvkW5VIgoxwZrkyMpX+Zn+f5jAS5BrfZ3G/zJhtmD2jEKlF8OKhdllUQNpAVZhniJcUt6/LCC9PchT+UAK/w/sfL57iIiAL3Vj4T+kLyuGLQukijtcvXx+Bbv1X/i/SBOeX7ysk6Lpoc3hHul6JoJXZxY9KEf78E88zsMLqV9TrdtAGNla/mvStWUmuPS85hXTJopBFqzSzThIU1KTjCm23SvSSzpWPW4psy8fB5lO+r7SuOPJrRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/gTudL5cFFJ7IPVfHO02xmUpdoFCJvXpQ2VfUUX1DA=;
 b=iyOeDS3vci4v+WRBytPGxB3MYXF2AuE2g9jyxtvdAykTA5cdH0EjFOKSjF0OHdARJ8caOwrw927bHrnH5NjD6RR09JMp36r6w87f00lqweSX1Tm8tRvvzRp23RVZcymdbA9Q+0CxsmxlTRWbEmSAgpOajtom4JUHc+Kn33Oqd3s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 14:46:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 14:46:12 +0000
Date: Tue, 5 Nov 2024 09:46:09 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fallback to sync COPY if async not possible
Message-ID: <ZyovsQBNlmoSLWED@tissot.1015granger.net>
References: <>
 <Zykz8j7kTJd/CuF6@tissot.1015granger.net>
 <173076676896.81717.10653275466233824521@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173076676896.81717.10653275466233824521@noble.neil.brown.name>
X-ClientProxiedBy: CH5PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4769:EE_
X-MS-Office365-Filtering-Correlation-Id: ac314b83-11cf-406f-9dc9-08dcfda897d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h4GJLJjj/UeJuV7zXbJePjhl2ci+bIYHI5btRLkoLvlT7m7WIen5qn7odat7?=
 =?us-ascii?Q?Urqw80i0k+pH0WZFYrTfd7w2GrIl13tEkoF90ln/7v1pAn6LrwP1hgFf2Nfu?=
 =?us-ascii?Q?rkJRh0qWVEWcinEzJz4m4F38aQT/Skr7m3Lpm9ohFHqUtF1g9ze12wL7TqiE?=
 =?us-ascii?Q?Oi4GLJwV4z6t28MTCoUT43wjo54pGyiXkt+aYtjbeflOHoq9Yp4GKfd/dzWe?=
 =?us-ascii?Q?2O7XvkncIm9oFdhmjckB6Fmx4Lg6gym8X8gyrA4JHKzbilZzSKaWa0BUZ9o4?=
 =?us-ascii?Q?R9Ez42hF9cRSnNk71L2CGb1L8wiItI9TG4E4Qlpf1nwcH3ZuRNxqyZfTk0SQ?=
 =?us-ascii?Q?3DEQ6DyY3W+/yVVnOF9axu4XU1+JDwpZpGU2bNjPNNHmurOdwZeMDj1wAQ4s?=
 =?us-ascii?Q?GIclC6rj3EA7A5AfCVGRnVNyJiKv2JXNbDxYaXJsF5ttHJhbqv6245Rn/5dh?=
 =?us-ascii?Q?PvklkeqK3OHti5ppeJesMlEtjWkLUmIvnOsPutwFRRQ7fatEES/OOL620D/c?=
 =?us-ascii?Q?1DsAIjwhi06QdI7JPWZh2dbLT2eNxIObneBRPs/a+UGOMquOOXtQ4yjgIFoj?=
 =?us-ascii?Q?wxD33ZmtJPy0Jb2krWYP20kQTAgh8DxcX+Xc0lFvQOTp71M4QFhyXuKMH9pw?=
 =?us-ascii?Q?O8hWvDZrlHe+kY7aWlpkGR5BNhPPiBFQ7b02fhtgckHIBS+T9HkwIYy073tr?=
 =?us-ascii?Q?Tn7bc0M3TWRvoAoPMGwAXorbGVJaHWP/UZB43aYBEISP3/3y7M3/e8W/vPGu?=
 =?us-ascii?Q?x13TxeiVik6Urb5JsbU8BjKh01zVl0erihwRd1psglqVExTrmmcE3+B8zffy?=
 =?us-ascii?Q?X63j3lTyLx+0SwSgidDREzcIv89EB0o14V0Y1I0g0aUHLDDQk+XNwrjknkg+?=
 =?us-ascii?Q?DP5eOsFXLDvnXBA27d3+1vO/TuQwQunC9TZapA0DWDkNGjJTpuWzpXXIBD84?=
 =?us-ascii?Q?1RcDiU3U7Sw9peB8dihaphhim2zKU/cicrlbh+tSMjdvEZq94shkwiUOdi+c?=
 =?us-ascii?Q?NZeVOegNhCw9stUO+1Irba5+tD24FC/Ts8zLTV/4Rq80tvOcAW3U+I2xHtt4?=
 =?us-ascii?Q?9JOsCcIIgA4G0ujV25/c66L+O+oxeXNcYGy4+yUQkmG3atH4XCWRTagqc/Je?=
 =?us-ascii?Q?t9kfq1l+4EhL75dUOiPs6r5iV0mqpqCRrOA7WmzLmaoWIq4Ckz3vOXepburQ?=
 =?us-ascii?Q?CqUhZ1LpntLN6tIR++FuKWJ7Kl1PPTyDAwwu0CReW1BaWQ6JFBRBjpaPioLC?=
 =?us-ascii?Q?l249D44EWMthUvIV15fROrD5WWW+4lyXPmVJ9McW3m60tdsrXZh739drRuVQ?=
 =?us-ascii?Q?acys5Ay/0HYYwzjdUaAHSJPw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JLN4ZlqmRiaM285a/oeSLQNzUhGsDiLlKfqlePdjorxfuXkNgkm5KbJ7qPW8?=
 =?us-ascii?Q?5y2z46tisWka8AwwZ6iLDkjwMRtYFkZJrlXtySQb5Zk0USzDB9Oek4kHwM9P?=
 =?us-ascii?Q?UfLlvJvKgnJN5821S1WqdyJOTxafPlmK625cyp4rGOcAtC5fUQ/+1vmEQpfq?=
 =?us-ascii?Q?x0kb8J8MzVXBfXADJpUe8fyAZ2iuPF4BD2PQhBwF9G10L7eomjoamgS7koTC?=
 =?us-ascii?Q?Ne9IwtNnvC3PC58jHL87YLet8wO6GH1Mo/PrDubaRMG9Ofy+01BlJ3QtfTzk?=
 =?us-ascii?Q?Y09ZbOU/CfoMGsWjZ/290bc2SPh9Gvyzb3z/1gg+lvQbHpphmwzk91UT3C3W?=
 =?us-ascii?Q?lMGtF8a6ff/NSGKWmIo2Npsuko5Y9KpsYmQpcQnSVnHY+RyD34xWQBvmxM3E?=
 =?us-ascii?Q?u12EmbK0xcJTLTAFr0mJLdw2pfXaMbmV09AblYOOVsto3AZ3y1VqM3Gr5QyT?=
 =?us-ascii?Q?dGqmbQskYgvSfuCzzEDKcP7pwf8IaNaVjQLIok1+DCPJ/D4N87jHYsO0XSiG?=
 =?us-ascii?Q?ICyZWWcAdjo6NxFBt0AhgkxfvzEUpga7PfWfwILVlGwAl+3tzOVCsbupWb5W?=
 =?us-ascii?Q?+o2n+R+T55XiLF/Kzz+qgmChMtwknokilLN6D/KxmLwinQFNmaeA23ay4yNb?=
 =?us-ascii?Q?feZzKdNSuGiL6oCljroeSU4uNZKrTJirNxu8U2fZ2/uxznTZKGJkjb3qbcnU?=
 =?us-ascii?Q?o68XqJH6oM6cZqnP2vj0SpM037NKGCCw3qMAwsfXkeZnzMYNyIpDJSSvG4bl?=
 =?us-ascii?Q?EWW0lm95lnTdvDCtbr9ppZzy/UnspjCSVjg6TtH9MPkuZ/mneIzTxLOS4tyw?=
 =?us-ascii?Q?l+q5Bx8IsUhxeB23l5qKv2PvlIEN+Gudok04bcrZuuppvXaBceCYuuE2zkuR?=
 =?us-ascii?Q?r25TmG2WtH7W639Pl9k8yA7un0sHEYbwPI4U36jj31IYWARK/c3z0SVCb2IO?=
 =?us-ascii?Q?p4K8PsHYXKm+ihCIQx+wEG0skf2wF4my8j0dJ5CbDWxGk94r4eK7EB/PKbIs?=
 =?us-ascii?Q?Ht1TNWJIsg5i99z+TUqxN25VpVJ7JyOOOX1bMrEcSSJbtXVZg1SXbSNvlHEx?=
 =?us-ascii?Q?g6Eoumy45e4oIbK0cmt5qugPdAU5klDLCmzji0JdsR7kuY25VvkVD0pxY7Ky?=
 =?us-ascii?Q?9O7qGWvpZC7n1LIjBax7TT2eNF4xCuYQsx/5LWaLQ+OH2cBEVYS0cpx8+io4?=
 =?us-ascii?Q?BGrngOQNZ3NFe7/z7/1ai5KzKqLetXV3Lxs8B/uzSKNEusCwWooe+Dcac1dL?=
 =?us-ascii?Q?WN4poenCWhb2rqcJ1DOMbwpA/hKZWcgqn+yujbzrP2rRy/On3LkKNOmsEVqa?=
 =?us-ascii?Q?TC3z79RBKixTOUQ6oNAY41ESHWlfYYy6n/K9dofnAw2RCXfjWYgHNAR2zWQ4?=
 =?us-ascii?Q?gXemAo/R58WUKLt8uiMLu5gSSqyGQbFn6cw93R4lnOp72arOHD98Ja5Ojq50?=
 =?us-ascii?Q?WEmyMfdAqVt53HtIWPjS7DFG+oUEdc+WkZXcDxjvno1o/y1t4CSe4muk7oo2?=
 =?us-ascii?Q?agDW5FWRBLL0Uzwc5wxKq745V5a0CcwcObW/a9LoFMuYQKf3qwvSHKKnfJym?=
 =?us-ascii?Q?OEpcY8vdCuyt4vwq6P+K536TQSBLt7+Mzlc8H+hx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bF1bPkxmDKrRS1g25530DIJjGf42Wbl293HTA17HCH+soKRJCFnjyICW5HfWDDLs4Y+ChbCVorCM515K2wF0zLCdXKNcG1L9Z6ZB5A5UrLouTIF37i/bTHMLKhQ0zWV+YyfdOIYuOLMIvSVvzTM3dyZRyNZMZxJrzdr5818DGXmw6NH0JKuRVk77T4H/JbLrTz2W8wnoa6BBRWvuu0p7T4fYId1pL/Haj3ICU8YpWWAOu++f5IBtBcZsvdIPbVOqVP7dNUKvvNHj6zHo0hbAQwerJsv8mVK1LAvBwtCANRUQL2Wsvkbx+AexW8NGukjdWt46emfPCJoPJ7As6L30Q5blMRSNUheycam0oPK/c1QzucUSlQpl3EiIPRcYdsNCTESAwu37fbUslsPkPK9K6xQGtHnKsR0mN8XaAy7G73JcKNZ6ehDjlAtil2T98rI48OfyVN6wCqoANMkxt/NYAb979hi8o6zXHKHfxpZ9yDeCI3pUUAp6/LvKYpgUIYoDBXjfA7HLaYw4FFO/NlznTeO1XctcO/aMaXYyJwjEs1SlvDJNAhCU36my83TIr/gYJpYMQ4uhnbflYgpknRSVyuoxjprz59K07DiaB8XrLio=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac314b83-11cf-406f-9dc9-08dcfda897d4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:46:12.5337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqodn+dEFNHeoIRPFoniIgsEj8vtLGb2mjyVXYTzpaW8+rRUk7Nuep/q0ncSexKDNxNQCecNkj/e8Mfcn0OdNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-05_06,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411050114
X-Proofpoint-ORIG-GUID: kFC3_sYv3zdXdIBgr-yi5I1LQhaT1g3v
X-Proofpoint-GUID: kFC3_sYv3zdXdIBgr-yi5I1LQhaT1g3v

On Tue, Nov 05, 2024 at 11:32:48AM +1100, NeilBrown wrote:
> On Tue, 05 Nov 2024, Chuck Lever wrote:
> > On Tue, Nov 05, 2024 at 07:30:03AM +1100, NeilBrown wrote:
> > > On Tue, 05 Nov 2024, Chuck Lever wrote:
> > > > On Mon, Nov 04, 2024 at 03:47:42PM +1100, NeilBrown wrote:
> > > > > 
> > > > > An NFSv4.2 COPY request can explicitly request a synchronous copy.  If
> > > > > that is not requested then the server is free to perform the copy
> > > > > synchronously or asynchronously.
> > > > > 
> > > > > In the Linux implementation an async copy requires more resources than a
> > > > > sync copy.  If nfsd cannot allocate these resources, the best response
> > > > > is to simply perform the copy (or the first 4MB of it) synchronously.
> > > > > 
> > > > > This choice may be debatable if the unavailable resource was due to
> > > > > memory allocation failure - when memalloc fails it might be best to
> > > > > simply give up as the server is clearly under load.  However in the case
> > > > > that policy prevents another kthread being created there is no benefit
> > > > > and much cost is failing with NFS4ERR_DELAY.  In that case it seems
> > > > > reasonable to avoid that error in all circumstances.
> > > > > 
> > > > > So change the out_err case to retry as a sync copy.
> > > > > 
> > > > > Fixes: aadc3bbea163 ("NFSD: Limit the number of concurrent async COPY operations")
> > > > 
> > > > Hi Neil,
> > > > 
> > > > Why is a Fixes: tag necessary?
> > > > 
> > > > And why that commit? async copies can fail due to lack of resources
> > > > on kernels that don't have aadc3bbea163, AFAICT.
> > > 
> > > I had hoped my commit message would have explained that, though I accept
> > > it was not as explicit as it could be.
> > 
> > The problem might be that you and I have different understandings of
> > what exactly aadc3bbea163 does.
> 
> It might be.
> My understanding is that it limits the number of concurrent async
> COPY requests to ->sp_nrthreads and once that limit in reached
> any further COPY requests that don't explicitly request "synchronous"
> are refused with NFS4ERR_DELAY.
> 
> > > kmalloc(GFP_KERNEL) allocation failures aren't interesting.  They never
> > > happen for smallish sizes, and if they do then the server is so borked
> > > that it hardly matter what we do.
> > > 
> > > The fixed commit introduces a new failure mode that COULD easily be hit
> > > in practice.  It causes the N+1st COPY to wait indefinitely until at
> > > least one other copy completes which, as you observed in that commit,
> > > could "run for a long time".  I don't think that behaviour is necessary
> > > or appropriate.
> > 
> > The waiting happens on the client. An async COPY operation always
> > completes quickly on the server, in this case with NFS4ERR_DELAY. It
> > does not tie up an nfsd thread.
> 
> Agreed that it doesn't tie up an nfsd thread.  It does tie up a separate
> kthread for which there is a limit matching the number of nfsd threads
> (in the pool).
> 
> Agreed that the waiting happens on the client, but why should there be
> any waiting at all?  The client doesn't know what it is waiting for, so
> will typically wait a few seconds.  In that time many megabytes of sync
> COPY could have been processed.

The Linux NFS client's usual delay is, IIRC, 100 msec with
exponential backoff.

It's possible that the number of async copies is large because they
are running on a slow export. Adding more copy work is going to make
the situation worse -- and by handling the work with a synchronous
COPY, it will tie up threads that should be available for other
work.

The feedback loop here should result in reducing server workload,
not increasing it.


> > By the way, there are two fixes in this area that now appear in
> > v6.12-rc6 that you should check out.
> 
> I'll try to schedule time to have a look - thanks.
> 
> > > Changing the handling for kmalloc failure was just an irrelevant
> > > side-effect for changing the behaviour when then number of COPY requests
> > > exceeded the number of configured threads.
> > 
> > aadc3bbea163 checks the number of concurrent /async/ COPY requests,
> > which do not tie up nfsd threads, and thus are not limited by the
> > svc_thread count, as synchronous COPY operations are by definition.
> 
> They are PRECISELY limited by the svc_thread count.  ->sp_nrthreads.

I was describing the situation /before/ aadc3bbea163 , when there
was no limit at all.

Note that is an arbitrary limit. We could pick something else if
this limit interferes with the dynamic thread count changes.


> My current thinking is that we should not start extra threads for
> handling async copies.  We should create a queue of pending copies and
> any nfsd thread can dequeue a copy and process 4MB each time through
> "The main request loop" just like it calls nfsd_file_net_dispose() to do
> a little bit of work.

Having nfsd threads handle this workload again invites a DoS vector.

The 4MB chunk limit is there precisely to prevent synchronous COPY
operations from tying up nfsd threads for too long. On a slow export,
this is still not going to work, so I'd rather see a timer for this
protection; say, 30ms, rather than a byte count. If more than 4MB
can be handled quickly, that will be good for throughput.

Note that we still want to limit the number of background copy
operations going on. I don't want a mechanism where a client can
start an unbounded amount of work on the server.


> > > This came up because CVE-2024-49974 was created so I had to do something
> > > about the theoretical DoS vector in SLE kernels.  I didn't like the
> > > patch so I backported
> > > 
> > > Commit 8d915bbf3926 ("NFSD: Force all NFSv4.2 COPY requests to be synchronous")
> > > 
> > > instead (and wondered why it hadn't gone to stable).
> > 
> > I was conservative about requesting a backport here. However, if a
> > CVE has been filed, and if there is no automation behind that
> > process, you can explicitly request aadc3bbea163 be backported.
> > 
> > The problem, to me, was less about server resource depletion and
> > more about client hangs.
> 
> And yet the patch that dealt with the less important server resource
> depletion was marked for stable, and the patch that dealt with client
> hangs wasn't??
> 
> The CVE was for that less important patch, probably because it contained
> the magic word "DoS".

Quite likely. I wasn't consulted before the CVE was opened, nor was
I notified that it had been created.

Note that distributions are encouraged to evaluate whether a CVE is
serious enough to address, rather than simply backporting the fixes
automatically. But I know some customers want every CVE handled, so
that is sometimes difficult.


> I think 8d915bbf3926 should go to stable but I would like to understand
> why you felt the need to be conservative.

First, I'm told that LTS generally avoids taking backports that
overtly change user-visible behavior like disabling server-to-server
copy (which requires async COPY to work). That was the main reason
for my hesitance.

But more importantly, the problem with the automatic backport
mechanism is that marked patches are taken /immediately/ into
stable. They don't get the kind of soak time that a normally-merged
unmarked patch gets. The only way to ensure they get any real-world
test experience at all is to not mark them, and then come back to
them later and explicitly request a backport.

And, generally, we want to know that a patch destined for LTS
kernels has actually been applied to and tested on LTS first.
Automatically backported patches don't get that verification at all.

My overall preference is that Fixed: patches should be ignored by
the automation, and that we have a designated NFSD LTS maintainer
who will test patches on each LTS kernel and request their backport.
I haven't found anyone to do that work, so we are limping along with
the current situation. I recognize, however, that this needs to
improve somehow with only the maintainer resources we have.


> > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > ---
> > > > >  fs/nfsd/nfs4proc.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > index fea171ffed62..06e0d9153ca9 100644
> > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > @@ -1972,6 +1972,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > > > >  		wake_up_process(async_copy->copy_task);
> > > > >  		status = nfs_ok;
> > > > >  	} else {
> > > > > +	retry_sync:
> > > > >  		status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
> > > > >  				       copy->nf_dst->nf_file, true);
> > > > >  	}
> > > > > @@ -1990,8 +1991,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > > > >  	}
> > > > >  	if (async_copy)
> > > > >  		cleanup_async_copy(async_copy);
> > > > > -	status = nfserr_jukebox;
> > > > > -	goto out;
> > > > > +	goto retry_sync;
> > > > >  }
> > > > >  
> > > > >  static struct nfsd4_copy *
> > > > > 
> > > > > base-commit: 26e6e693936986309c01e8bb80e318d63fda4a44
> > > > > -- 
> > > > > 2.47.0
> > > > > 
> > > > 
> > > > -- 
> > > > Chuck Lever
> > > > 
> > > 
> > 
> > -- 
> > Chuck Lever
> > 
> 

-- 
Chuck Lever

