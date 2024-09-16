Return-Path: <linux-nfs+bounces-6502-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D072B979A2F
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 05:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09ABC1C2031A
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 03:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D178DF5B;
	Mon, 16 Sep 2024 03:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UH5SA2Z4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jCixonYD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC4C12B8B
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726458688; cv=fail; b=NmcwL7LTDarfzcboP4j747mWfl457r0EAJiIxc0uoLsWnKFezAFJdqlLGfywq9iuushAF/y6Sl29zYI0x8/WTY3SeexXGqSoye653D4bzQJtUUo++GFFaDl5HKo230dzwGHcX4VR5GCVm2pqHALM79BWSPhwAka8D+R7pF6KonM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726458688; c=relaxed/simple;
	bh=JK7XnqvYvHp9Iq/LltidjX4Nar7PeyWVQgRjDl9sap0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kD6xZvjFq3PRD5ufrd201QD5TRRImY5lq3N92N6UPTcVPLV7I/xgjm+DbBCogsfJts+/GJOHcuK7MkaiKlGlmBdkk9/DAcR3kg7eRBCOumgHrIK9DiCSvv4qE7sImtOV1TQWt6kELVU25WFX+VVuz9Lm3C3kwLlnwUzbWRG0Rok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UH5SA2Z4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jCixonYD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48FKxI8A015451;
	Mon, 16 Sep 2024 03:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=7jyKWx/XHR69KHk
	ssZ9lAaGR3ctEd8E/6ZRnq3PWg0c=; b=UH5SA2Z4PCMSkQLKNzEcCZ7W4L8aHQh
	GmevgSVg1PfIdBioxEXpOF41NmqxcmoCRHyycW+/0Zb5OhCT5nCmGDn0wzcW+TAS
	d8Jc44PRv4rwcufkY6nJPlyqQrsPAlHmTuLqt4Gp94how34RPJFQHaeikePQUOlf
	tP2CnmsKowMVEMA9m9LoH59X8tG4fnz7ZEuAVh3Enc/W936ODMlQIVYA2gBvEDkb
	aC4YndTTWUvg+sCFqiuNrNpt3yHMqpQZ2Yvs9V78fHbv850RrKs7Ygrw32Sh6xXs
	wyKl7jd/nwjCEbSzeWUOjvgIozSLEVi9DyPzBVa77xcsiHEwuf2zl8g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rjt7j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 03:51:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48G01giJ034179;
	Mon, 16 Sep 2024 03:51:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyceus3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 03:51:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0L6Xw4RU2BMOrsg31RubHbPBte1TPkQ7/DSr1mw/XtQfGlqVuaNwUkPUCQ0FN4qb5B+JTZ6IhtWH4QKccHHYDlbmCdUYa+mnKKK8FJZ/IWOTt0ClcDMVqNXq3yv1ACvN0jqQvYv/+C1NDerXrd3hxjKMPQwLgWojIoEyZdHHAMp1x5Y5unz9zCcx8NsXpx4qlIoMgxwQ6gEedDDaZ+0K9rpywrUJ/gRJnjBqPIPe+9pNvWGitokVAGRd1ML9i0DlXFY4Vim/C7wkUdHwrd5VVq1TLRbfjuMAehN8yTyAv9+LZRcpKYZU2/gqGDI4Oes0EwJ6O3/rj3VT/Q0XERUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jyKWx/XHR69KHkssZ9lAaGR3ctEd8E/6ZRnq3PWg0c=;
 b=MD2xKcPwYkuwfc2mmjhUPnNGyYia45CWyQU5Bg7TksroyiiQVvbdPGzlcSrtHFLfQGo35ZlW2gIfHMEnJvrjcRTAe5Ulco9xYMJ080X5IgSC7n6XxPuwM3S0nFUaFRdjfKWgzyozoVY5OSQbE5AMvLuPe4A/VI3RG7Zd8dkC+zSeYatv2UPS8elSVtoo7s6bituN+PNkoGC6H+UqAh1uDiT/54/PAQKn8L2F1mJFRaIdV1JbfzL3P5F0SX0k919yYW0AkHaj75+3nqe0wHdyl4Ktl8nAQDL8QEg6nPsgMUKlO8Ak893V0SdtbaDoFzr1fNtEB1i2iLUferIkzlrSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jyKWx/XHR69KHkssZ9lAaGR3ctEd8E/6ZRnq3PWg0c=;
 b=jCixonYDtkv1fdEzKd/CfjFHtqmOWbqXJ4KOsO3+GYXyTkBp9TUog85rIon9OEe80C2ULqcu+zE5SaUEhhz/kA0f1EhU+mpbfpkFQkWHTxhdCFPCRLdtK4LDh3HBCsAD1HLU771XIoio2y5q3BXisRyk9evPzZtd0HElZkaSEM4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4115.namprd10.prod.outlook.com (2603:10b6:a03:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.14; Mon, 16 Sep
 2024 03:50:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.012; Mon, 16 Sep 2024
 03:50:56 +0000
Date: Sun, 15 Sep 2024 23:50:52 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "Olga Kornievskaia <okorniev@redhat.com>Olga Kornievskaia" <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH nfsd-next] SQUASH sunrpc: allow svc threads to fail
 initialisation cleanly
Message-ID: <ZuerHCjboKWJ+qnf@tissot.1015granger.net>
References: <172644394073.17050.16376953609629336068@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172644394073.17050.16376953609629336068@noble.neil.brown.name>
X-ClientProxiedBy: BY5PR16CA0032.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::45) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: 32145aca-4236-404e-1673-08dcd602c4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZLKOzmk899Q6gd6Od9eiFQ9bHknQwKb1zibLvkOAUR0nCxsKbN4p117YUT2S?=
 =?us-ascii?Q?hxT3fd4u8v1PJhrMxYFwf+xKVlWdOqxnLEPhsCtXzzA6xydYbPaigsULaAcg?=
 =?us-ascii?Q?BtWOu/eZneGHjEGUXMQFJHyRsQw5sM8M+VH+thNhcVWc0e0AEUivAn2Gbz2c?=
 =?us-ascii?Q?RsWSuEMIudqtvytxoJx3R2dw+wXxL6Qgb1WL+iir8+YkeHplEQ9cV6Khj12v?=
 =?us-ascii?Q?v4PIDLNif30Y2FFj7uEpbveM0xOzGEck0LMgF30Fr3SQ3TBYtJbyAzC59YbI?=
 =?us-ascii?Q?1XRl7ewjRUySaFQLAonCduayAcYap9XTFzyo5bW4GVJccmHImXFqlSXPdV1u?=
 =?us-ascii?Q?PARGQ5OuLrnWBHbgJTQhlOJwWCnZZOB+NqqdJkDZwcuxBwESpacEFehdyKhw?=
 =?us-ascii?Q?JNt+ayBxOhuEWweLAGqcyJBqbHo9FdhFoS8ozAMHkSgLdcG83yo7AusGazXO?=
 =?us-ascii?Q?7STS29sOgUZBeOM+2TYESojNCowvwY3pKyCIiNB81CoY7IQ9bdeEUninQO75?=
 =?us-ascii?Q?w1Y9Yd6f2qEaFZRTXtB3r9+KT6/Exm2F2TRJT3s52gpWZTapY/fOi2eniMuB?=
 =?us-ascii?Q?6JUKZKb6Xa0/xX9s6oYjM62jr7jUtyIkmex97BpZiagOxib4jnkRtcbC2bh0?=
 =?us-ascii?Q?VE2KX2KHNyEOz7fhFjeSwFrtqzhA3U75CocxeN6aqZcnXj+OCoEjCIT2Xi//?=
 =?us-ascii?Q?xwle4uiv2nwXOdAB2aOCuYzvUPTwhc0ZVoSFKtOSxvz+HExOFq1JubC4dJbB?=
 =?us-ascii?Q?YYuQiU2bGhtBUtSo6wZfzhAfqNutzMArpks3EDb1hhDfuLZLqtBxMwOOtyKj?=
 =?us-ascii?Q?15gWW399ckueef3dQwqfvNx7w2M3mliHOQlEmJiOlupYVoQ052wrN+fWGy6s?=
 =?us-ascii?Q?nA8ApXvW6iSoOM6dOdjqv4OjGILINcNLR0RNupc1Td2P45IXgwvhveVI/+hv?=
 =?us-ascii?Q?2coE6MtZPaN0oYJI4uHcw+SN/QWy3dU3pEK4Z3LlMfkJCMcj2DhbXcsHqoHW?=
 =?us-ascii?Q?5rJZ23bH0i7YC9zsT/3i5HqW30I2RgKhf+pbwWlc2BhEKr9pTFl3JzTg2r/Y?=
 =?us-ascii?Q?n/NZXfMLHJTWqP9H8d5Ct/mnIeK4MHyRpYJqMhbwQq9i7fYw2V6pL+eewldP?=
 =?us-ascii?Q?F3lT9HXepD3RID2AxvdEAGSYzLazLqw5yVWcfOcfB6CxXlTKZ6ycSP6rYYxb?=
 =?us-ascii?Q?1n7+BQ3beviOTTvNBytz7V34cQWyRf30X4AfRqk108tKQFH1zB4YT1YW6AFc?=
 =?us-ascii?Q?mRs0zNn7tGxcsdU0tpH2K0oqHc+wJgnuqzy3R1Q6J+96G4Ael7QL0OTsoMKl?=
 =?us-ascii?Q?jCZ3D/5DgbYjQ8FW6yuadb39aaBU5WmLx1KlxI9wjCjulg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kB+FTtcF5mGcH8tXluw+O7L76a5tM22NF2O6K2Mky5GEVN8UzTlQaN3z/Oj0?=
 =?us-ascii?Q?GOeULmeGwtScFLnnr+HMMdnofzbIZvFNhiHd9w1O0ht7/EMIFUvseIdsn9Eo?=
 =?us-ascii?Q?n2YzhUQpnC6XQjxuG+CDVq5XNedc7kpYGByvW2AQ84nRqaHyT/TZ0rkaf/y7?=
 =?us-ascii?Q?mMKJnomutvrytpBibVLoxFv8iX4/1vgGxYijVKSLNvGnNQYkJRVLzlV4G76w?=
 =?us-ascii?Q?9W+ou4fPtR79oEDZ5pTauICOBLSw+banOgqPlYkTqvcaSYQVcu5FgHFhEeNv?=
 =?us-ascii?Q?8mzilawuATSnZebY5yu4ar8cPsFw9WVVnqjoSrlODi8ljVdhtv9t5UzSfusI?=
 =?us-ascii?Q?QyzjhUGtgCE+EWR8ooEeTtsySrkjZIIyCkJ8nZis9qgBcP2zORDb6PKErXLr?=
 =?us-ascii?Q?Qt+sTFe7b12HmE9a87wpAD0Z7/Kyj4HBtNb1Cz+rYlqDsR6oVPfrCa+vfvC7?=
 =?us-ascii?Q?RYvDi4JwqZdtt4ZvlBy7gmjIV1osVmcXTULDpAhz4CsCmlJoISPh1xjoxzjP?=
 =?us-ascii?Q?9LfWzB1cH7McqBwXXqz5IHackTN3zHf85rD+gL4cUgs6Qudi5R70+Tmz5vIH?=
 =?us-ascii?Q?XhoSEdRSvkkQ7dZeqBE/RGidZ9z9ujMsc7g0aYpJhv1oIQn3K40xE2ROSlyD?=
 =?us-ascii?Q?aFhmwYa4zZEbGsvOkfsj9/XaTorEbdUshcEIVul/2vqujWg4Odvl/Ipv+EoX?=
 =?us-ascii?Q?uDVD9Bxnc8fGz9PSUd0tiSrBpVu4dEPzD31ylx+GXlo78X6FkDK1u8adTDKF?=
 =?us-ascii?Q?L0pSld8KZloZ/TZ98V3MuYC768WHVfqdIwuVvVD9BVyib4msl414iGvDF47y?=
 =?us-ascii?Q?8YmQutTUPWyTrEvR8YojOTjqhYexPZKr/JrHJcBqu0qWuz5Hm2ISXqoje42r?=
 =?us-ascii?Q?dI5GS+04AR59bRuEEp6pKy4tGo8EmtgC1+GKvPy3NKdO3l2OzmsyLSCXyJ12?=
 =?us-ascii?Q?iUlxRqLOkFZaVhJv5MzN3XU5z93AUrZmKrvn7wiWWrjOaXpRQl5bKptbfJdG?=
 =?us-ascii?Q?b4/AHFKDs5J2oYuQt6DYqdyfpKpW0mSghPAJsW7fWq2yKGyscOvmv6IAeHka?=
 =?us-ascii?Q?UeVGgTMezDa5kK8UwbwgHEBTvUSROI+tgK0iubGTlJTcM5aPjmMkzScA291c?=
 =?us-ascii?Q?D0D5aENjJ0lHy29wgG9XsqZwkABXGNIS2m+owLVNwMKZi65+GbL/QbWqWDcK?=
 =?us-ascii?Q?cXbK6pQ7l2UxNB71ocU8am7AKxs6AjZ32c4Pk8AcpVTDq94Q02hV+4wSynPa?=
 =?us-ascii?Q?3dQvg9tz0v/+petjHDO6hPhZhJn7dmVROwQLQJk3/XKgpeJ+8qmlpBwbXCf0?=
 =?us-ascii?Q?646RgUwmKs3cZKkAkqTdR8naENTgki5FN0NfOTywJeHcDULdIXTgjjMkCNfi?=
 =?us-ascii?Q?vRmOlElRKiClXM7rKCAzijQop8e/BoeKI9JkYFS/dgaTqjq9saQUDVCax1/k?=
 =?us-ascii?Q?Rffvz2OLq3ty/f/oIIVlS4R6DP1+hnAxaigEtVSTdj0FJAdBdIHB6XegbF3N?=
 =?us-ascii?Q?1f4w1MPhLaEAfW45rh49xqNN8uDM1eTpwbyunzqnZHZq361dvMyhM078FGIi?=
 =?us-ascii?Q?7wjHVTRY1wjFb5wZj7/MjteNOWZ5yrLyEhOg9Rr9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ziZG++ikhRpI5Jf+8wMpOauWplq/ssdvxN8lgFLzBn3TB2xGmi2MbmF60owGhQ5ogbTkz+wixUq2ZfQlxcSzN5D/c/cvslGOs073N//FSA+eE9mzEXlKaUKhNbMWUv4HWspHwq9v5c5PDccgSMy10JrcREyb8TdobebYWn+EmrPnha6Ju/TOBDvBMh1JzIZGuythV8IH8TwFz7M0X7zcOrjHqP2dof0RzxIzKdSjRvK9i7dJyf3NCkxqulkdofHkQLLTSLpWb6NoHe6z9FZKZAxGGzv+/gjlJHPjTwIa75d8SHCmM+fOs/UYStOSbs/8UEZ3z01HVmVOjMmd0fHus7U4hFS7xqWQjFfYKROD0pn0NvGjlQQrMj3twdRIemv2pITKsO3KJqpM8njrE9xphNc35EAVL90yn1cdyOJGp9PM971TrO42/SYGxW3nuXMdw5zkgCY992G+4i6Hlvh3zk10YYuPMokYlzoNubJ35KrUssU0Wl2ko3xeaN96CB3ZwoiO+eiKR5HrzEO/j+HLxKBxFSWQZnZ1drq9zS3fN84amRXyHybBh3m4aAeN+IxFMtAZR6pTlY/mvnjLPYtgVzlzjt/Qpcw4+LXGVKKiOG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32145aca-4236-404e-1673-08dcd602c4cd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 03:50:56.6531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMTG707Q7iQRPYM49PR4LgKSr4CY3InmCWeQxXdA0uU5rQmSW6Mj6nRMMZnZMyHirvV1+trHXQqGfZsL0z4Wtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-15_17,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409160023
X-Proofpoint-ORIG-GUID: SXi2Jk7kow9dP_W689k-Q6rVKg7Muc2x
X-Proofpoint-GUID: SXi2Jk7kow9dP_W689k-Q6rVKg7Muc2x

On Mon, Sep 16, 2024 at 09:45:40AM +1000, NeilBrown wrote:
> 
> The memory barriers in this patch were all wrong.
> smp_store_release / smp_load_acquire ensures that all changes written
> before the store_release are equally visible after the acquire.
> These are not needed here as the *only* value that
> svc_thread_init_status() or its caller sets that is of any interest to
> svc_start_kthread() is ->rq_err.  The barrier wold effect writes before
> ->rq_err is written and reads after ->rq_err is read.
> 
> However we DO need a full memory barrier between setting ->rq_err and
> before the the waitqueue_active() read in wake_up_var().  This is a
> barrier between a write and a read, hence a full barrier: smb_mb().
> 
> This addresses a race if wait_var_event() adds itself to the wait queue
> and tests ->rq_err such that the read in waitqueue_active() happens
> earlier and doesn't see that the task has been added, and the ->rq_err
> write is delayed so that the waiting task doesn't see it.  In this case
> the wake_up never happens.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/sunrpc/svc.h | 7 +++++--
>  net/sunrpc/svc.c           | 3 +--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 437672bcaa22..558e5ae03103 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -326,8 +326,11 @@ static inline bool svc_thread_should_stop(struct svc_rqst *rqstp)
>   */
>  static inline void svc_thread_init_status(struct svc_rqst *rqstp, int err)
>  {
> -	/* store_release ensures svc_start_kthreads() sees the error */
> -	smp_store_release(&rqstp->rq_err, err);
> +	rqstp->rq_err = err;
> +	/* memory barrier ensures assignment to error above is visible before
> +	 * waitqueue_active() test below completes.
> +	 */
> +	smb_mb();

This should have been "smp_mb();". I fixed it up before applying.


>  	wake_up_var(&rqstp->rq_err);
>  	if (err)
>  		kthread_exit(1);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index ff6f3e35b36d..9aff845196ce 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -818,8 +818,7 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
>  		svc_sock_update_bufs(serv);
>  		wake_up_process(task);
>  
> -		/* load_acquire ensures we get value stored in svc_thread_init_status() */
> -		wait_var_event(&rqstp->rq_err, smp_load_acquire(&rqstp->rq_err) != -EAGAIN);
> +		wait_var_event(&rqstp->rq_err, rqstp->rq_err != -EAGAIN);
>  		err = rqstp->rq_err;
>  		if (err) {
>  			svc_exit_thread(rqstp);
> -- 
> 2.46.0
> 

I've squashed this into the already-applied patch in nfsd-next.
Thanks!

-- 
Chuck Lever

