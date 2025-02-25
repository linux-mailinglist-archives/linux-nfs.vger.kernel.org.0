Return-Path: <linux-nfs+bounces-10324-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67B5A43265
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 02:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3E807A6F48
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 01:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319F817578;
	Tue, 25 Feb 2025 01:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NUiWLuJU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sjn+v0Ec"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A04E3209;
	Tue, 25 Feb 2025 01:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446513; cv=fail; b=lfIZHaDNEQpjYcABrtRFiMUk/kV8ZmAKeNe1CY2CWZVllTgmQ61PDSqJBkhJLKauc05CztDNHhLftofcJ6iUpznHkf7dzkUiFdoaMQBS/3Iq20tHErGNGe+aNs2rAnzb7C4sKE6v386n4sJ2+2aGc8mpZfHz+5HN7BprqU7TVrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446513; c=relaxed/simple;
	bh=GTJ+IvQDq3D3VWosqEeZPsP9GOZ28Za3eKvzaH1o0Wc=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=uoNpS8P0RYfYkjDa2qLMw53RAPFgWVu9t0CSPBiYeGiVHglPsXnw96HP3zBORKw2Fj6ClUOsnLcLVr/5kVKSjIuAhLDrVrEwwgW0T06pJg2//P+xcR4v3Z8FIjwmA5m3hs5+cPKuuUca8HyM9XW0biyTaAQT6t6wvyhMeMMl2WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NUiWLuJU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sjn+v0Ec; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1BeMd002662;
	Tue, 25 Feb 2025 01:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=D3ou3CKJeUWMFTmnUx
	zIt8rNTeyf8QBAfmz/p1XS2LA=; b=NUiWLuJUibQZAxIZ9+lzFPaSEj71GpXq1m
	Y/K+IZDxWCaYMrUJ9jTqXrGzQyX/eo5MQNJQNjtVlapvGuuOBl345nVXjHV8r2Ar
	P45OGJHyFjDBKEpSx3BRVov7PbqWYNkjbOCXTdvj1ZvhX2vngKfdCC/fy/LUXPh1
	foa7lvf+Lz92jps9HH09X1k2GmYRl6lhENdLiAx7F5zXSKwCWbId1CT+js7OSOXD
	jUBCNLFxMd41ZzQeNh6yCj0JFMgS/s+DehDtONtKUTxgpfgK7T6iZYOXUFG0oK6m
	F1TRVwMIluVVHBv4SNBrkfPbwfG49tVWd3/gfl/zhRv0Kxvx09BQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6f9bwdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 01:20:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P01SoS002747;
	Tue, 25 Feb 2025 01:20:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y518rrvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 01:20:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAdhwDFv0FuFzvbRD1raCbWqEmZPow1TlktVk2QhxcS0tNCsBsJBKt7lVcySiXJAYvw7fEcAICiL5xULkio44yD9e9h0BWpKVK4BQh/OuhxvgPSToCeSzRbIgwmULVofOhR5JWHB7v0S1C31gdKqJ7V61Hoz+Gnly4oV3HvudQmgzX1dV+wbUgK6Cv0O7kiFx+vgxb/1R4hzD+7y6Wnq8rCIcEVGkPHG99uF6Acmk+vq9NJJXRgkvNjUnhNUCZqgnYKakXFb449R74KtvE+YqpQOVILNhuCxEc+Kfgk+otBsi5xDJLtFAI7eXa5PnX1x+buvCthj7YLJMMaWAgGaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3ou3CKJeUWMFTmnUxzIt8rNTeyf8QBAfmz/p1XS2LA=;
 b=ZXnw84M65IhqSJUv5FImD7mwjQR+JQa16p3wGL+nkO3p6j0K4W6brh7VsfwadRiW4x+8bRnLbuaKSKwKozaZYxt2fYGjhLGjo7aLAvPsGyXsgyhGkCp7JJT9O9FwHo0WZzevwv9MW7xVReWX2EHjMleV3QAHWFT1WeyPYXhxflWSHDS331rfWnII6cqaswpfxCHRAnihk+uwzG6mScfns2KE6t+ZLeJnhjYYR1f0gyXuJKSetmN6m9OPyfNKNzZ6KmF326OogKa6ATtySneIOEqbIGcV9k9sEiuC3ce6rmNSVcUSkYgq950uHrSy7pKTO3UpeneuGL/Cj/DaKLvtkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3ou3CKJeUWMFTmnUxzIt8rNTeyf8QBAfmz/p1XS2LA=;
 b=sjn+v0Ecur+QLhSrGZU49/YKHN0AI3fzVXAhP02LYcscSloCUIkCTfRqjiJzU/iaau6kxebRkFNGV3ShlJaGj4I3AkK7IXOBWosaI557iMPLA3MqsmJ5PiZ2gYK7tosYcMObMU5Q6m0h3yDwjrja9CPbiUjlIqejXmRNfBtvptc=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MN6PR10MB8192.namprd10.prod.outlook.com (2603:10b6:208:4fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 01:20:47 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 01:20:47 +0000
To: nicolas.bouchinet@clip-os.org
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, codalist@coda.cs.cmu.edu,
        linux-nfs@vger.kernel.org,
        Nicolas Bouchinet
 <nicolas.bouchinet@ssi.gouv.fr>,
        Joel Granados <j.granados@samsung.com>,
        Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Chuck
 Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil
 Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
 <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Bart Van Assche
 <bvanassche@acm.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>, Al Viro
 <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 4/6] sysctl: Fixes scsi_logging_level bounds
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250224095826.16458-5-nicolas.bouchinet@clip-os.org> (nicolas
	bouchinet's message of "Mon, 24 Feb 2025 10:58:19 +0100")
Organization: Oracle Corporation
Message-ID: <yq1y0xubz40.fsf@ca-mkp.ca.oracle.com>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
	<20250224095826.16458-5-nicolas.bouchinet@clip-os.org>
Date: Mon, 24 Feb 2025 20:20:45 -0500
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MN6PR10MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 8080ed5b-6982-406f-7c96-08dd553aa238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WJJ15oQ8+GKpmqOypB2Bb9W6n6yHUGdyxcB0EMGQQfUHh5fgTrxQRQPhMrGp?=
 =?us-ascii?Q?++eyaFocClBXUzlLjBSUmjy+ppbwTP0gB3z7GRsa+UOJ7f34rzslVTT2r/hl?=
 =?us-ascii?Q?wgwqJr/rdDAaVDIkSHThwFzphO0taRk4ueqJveBMnnwomVL8zVWjvRw5PV2U?=
 =?us-ascii?Q?T5T00ZcHxOmRYz/0LpjfOwLWuya5POes5Y8BGNV3/Y2+1qwBkNC9wKMy8HVg?=
 =?us-ascii?Q?gmMq14CaDLWGZA3LQYWCpOWtBBSmQ3c59Ch46/am7mhxBbP5jDpmbjvYduNT?=
 =?us-ascii?Q?UMqIgBpUdLGF2mHc7WOQKcTiKhgIVVncssaVy2SuIM3gZyy983aFpExdEzxt?=
 =?us-ascii?Q?2kFoyL6qV2q46SKJfEjg1yt163PTnhjkYSJ+r3GK2lT680DjK99JmVwa8oNt?=
 =?us-ascii?Q?1+eKc/kvcvInUW6jL/4Dhjw7ROefwluGb7YruMJ2eYPI53Lo3q1BOf/Bavnh?=
 =?us-ascii?Q?KFDRMUse+d+vcWYWqfQHT8WQEU0RyH9MI9kkd33D4NiJz+gez7Ti8VqpjjrD?=
 =?us-ascii?Q?fytstfdDCId8irCDWCSZ7OiGu2mW2T0diDC8+H9eqG8jW+4AQvCX43dsj/NR?=
 =?us-ascii?Q?GIzX1KQv4EL/tz+VB/oJagh8Yh4lyX+8q5ZSSJLbN5iQHT2Xu+LG/KWhxHU2?=
 =?us-ascii?Q?9Ze+1PsgPZEfRp+RcVl0SGpMNb4ErbGULesAErd/VsxeAXbWv/TqilvgXSf4?=
 =?us-ascii?Q?SXAVwgIoDozSsBCC6mke4kXbnAp1tC+yuWQ3bv08/fDQa8voyL1iUg5ERfLI?=
 =?us-ascii?Q?utz1F8gKXauX2Vqe+tyXVyulHIUIZFfeeHALUn0MNCf27qUttHAYSo8g7Nlh?=
 =?us-ascii?Q?x6jgKI63GbxuP49GfkBs/v3cmxgp2nXA5RdfC7Eiu7511bFNr4VtA/P+qTAy?=
 =?us-ascii?Q?10vKKpQcY3BEQI79Kuqi1lPC9CB3SrbKF6inIGQAulB749afxdDxC6nkhmdP?=
 =?us-ascii?Q?CsNUlX8GmEsw2uS+T22TiJHN4MJHWXMZTk1qARZUU1dtWuhpjW8+dPvoVR3N?=
 =?us-ascii?Q?5ucV/mCB+BIzTr0KhDY1NGFNGTddGZu3ZbvSFTj1GEnDaCZBlzvu7Id3JInE?=
 =?us-ascii?Q?Y4PIbFGUMKzLMW1JOMy8OvMgmDXY3HfjlMCMThKIL/vwjKpvlvCl0XR91OXB?=
 =?us-ascii?Q?OAo5BHhZX4eGUlx9/HLCxGM784974fHC2McnDLKZqeb3bwNyo6YCrZJnBlD/?=
 =?us-ascii?Q?CH1G1/QFFfJPSkiT7BET29qBLSdkWUj2frarFMFDuZFkbXYQ+W42AlOchkSE?=
 =?us-ascii?Q?h20/QILnHkVjoTaveyyKIsrlmj/BwRdllSjO/fAI3MfXUl++tNQPWXPnQwAb?=
 =?us-ascii?Q?8hXyExxuJKAq0NTmczO52PmrSkhujnh4bPq2C+5TfhzNEG82D9BAYOfYpJXH?=
 =?us-ascii?Q?fnqfY8enjjFaUppVoBb0ihV3WwrT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+zdsrPkaxtAFhXvbWGmBZqhNF6Qil23S0es6S6n7aRQujqF5nWdrAL5v8Gkn?=
 =?us-ascii?Q?4VQhHey+t0RYhs1oG7Q+enimARHBRNbBbaJskqOfr8YvAWYEdnhafSSECrVh?=
 =?us-ascii?Q?GJ4mIIAM2rtRpbOc5WKhbIgTx6mNH/SwwatAWdg7M5Misvt9ZhTtDlUrMVlg?=
 =?us-ascii?Q?j1pqmIcCaqpss+fYK0cDSIbK5J7ENFHl6Mod8V26Qv1J/NX9b2jhBfctk7lb?=
 =?us-ascii?Q?GqU67pnDnCPV+v1IwEm4gJ82Po9lIQRtUHWLnn1v3eDXEaJgAm/eYWB8tFDe?=
 =?us-ascii?Q?KoMDvG72oKQEgVBl8rPUNbWewxruRQbhDi/9IF0889QBifxybZ3c4bzJnrYx?=
 =?us-ascii?Q?AvX1rmf+9QHQdMlY3zlqKAyCNkKDe3iRtJhv6AsRH6ILS6CRjW3WjfPwzS1U?=
 =?us-ascii?Q?T+quFHPoRcMSCBZ2o/qA7UWqEJoTpZS/PWyE1nt/anRa2PpGDPHSBD+Ce+ao?=
 =?us-ascii?Q?yvf7wY6U5+Ohzv2jYVP7zP3CwXI4pCV9LO2alk2OPTzbVaQ8dV0J5Woyh6fI?=
 =?us-ascii?Q?bHMJvDXQMclV+faQg5ph2ioc7L3pI3DW0weZbMRcX7aXgGQ0BRx9bma05WJ/?=
 =?us-ascii?Q?3EIBKPNJPFQQwgKeaaXCxUZybDjV1WDeKYFE0yECQhwYmKZX6MYvK863AjQj?=
 =?us-ascii?Q?0eVs1AjKJLjTxvl9xfAxWWHXK33EohtwWAk+xgdAxWohxknoKczEEeyUQMzt?=
 =?us-ascii?Q?MBYehEjVf+MABde68Vjq83CR/eyhPxIvwPd+U0YzMmFnxyLK/yAVoViA6qZC?=
 =?us-ascii?Q?d7EMoHzGEJ4V/OPyVwSjHiqYcIhAh20C54YJHWKkxfq9meCxJywe+RhD9HCw?=
 =?us-ascii?Q?Y/AEpY8etQgiqalpcags/PcLKDz76vpV5BvjFoKI/3r7MeYNyL19U+hfxQkW?=
 =?us-ascii?Q?3TynbRiwbGccz5sF1g+mLhWqjvKTDnzVBcLbJ8K6g96qUwPVaYyY89CDY9AE?=
 =?us-ascii?Q?AL85qNkkCjl1JJH6YDfb6jchqlGmdodhTTZItZaXO0wr0EHYYzrhdCJA5joz?=
 =?us-ascii?Q?Q1p+ucz/yiWvSBGr20F9nfCJlE20dAg8q17Yi84L62Z2ttCuNROk8n0uIKwi?=
 =?us-ascii?Q?wJH8RiTt7D8ic+sHLv4Z6FhGDvm6aWgREBHZJIRS0WO1Bcs/2z9t4YgTOPjS?=
 =?us-ascii?Q?SRhyuuvcQFJGBb2yehiCv6xqgFg2BQOLEEDr3AYpNxRipYzv5l2aVg2SsSx6?=
 =?us-ascii?Q?puANaahJCJFM4q0Ybm55gykuiPHG6fuY7+8iWLoHX6IcDsdUIiW2mPptanIu?=
 =?us-ascii?Q?k5467LanoJ+GyTyoQebYbFVzuEvjQlbcY9RBn61UYMoFRSvIxFiQKHH/3wYn?=
 =?us-ascii?Q?Q4gyIWt0Fj6a4AflYcXyyasPyTCP+A0RsKHs4VcCZhHuG24KnkIw6/hlg78d?=
 =?us-ascii?Q?DmTZEQngjDlHwdJtLIl3R4aIDlYGnvYFvNgxRj2D15hfD7esvhCnAch2/tGJ?=
 =?us-ascii?Q?0qOM5bNNQYDmBg9O9M9DCEgoQrrcNxoksVGK7dRVwZbGfO/SmMtVmVBdPVrX?=
 =?us-ascii?Q?khJ8DEplHCcLwFt3wZPrwaC13n40dtZVAijbDvCwrTC2XdSECS+L6x4jxPMo?=
 =?us-ascii?Q?FUeDFKXEMFOfAM4kF/YqqWDjNt6OQjachD6m3wMXf4+xh17jKsg1q2Zh3Oy2?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZBkdCxQ4BdAqWFReY7GYnlWFexv9+c/cCFTUKJQMQmGlPqyWF+GNrShi6jWRuHet78lgsuq/HPSpqKDvbBglsuqswHBiYfq4SlYtfqo1IaQd41Vf/sKHakCUFreOw2fs6NCqHz8XiQITeEG/Ru1mqink1dZN6ZZ7EP9yk01Tdcc0z1by6eKjGcPMBg34QFNI7/PwPjCcpuCgAmiKGs+TE5OlATuqXBj+3dgNuYdpbUllYXvMHyacIh6AZer0gaUzJnFn22BSwnddiuzWsA2y7tLJjqbugAPmjrrLtROidLZbWsrZ3r6LifDor0FmAgtZL0Yqbbk72b53s2nOznx+p4axHOMFl/fFKs/T6MHqikaEzGRdOgDxDbd3LHM1fWuwsIQJ5G6Sz1Ecif36DVaxY5JoQwi88fo2QAtoK7JAALN6bzspvc7Bvo4RzwEl5z7P41do06uiPoRjrSgvL6xiQ7dkQlCWWYJD3qCPNBZ2b38u+W1TvGxeblw7z+o9PLzHM5pp/xVWqnO4fFc7utbyAn46olAxWtNJLgII6UHJl6E1qA2pM2o/I6u5DdbLi3n+Sum2PRQoSYOUM1bobn2Yn2E7Ev3DlG5tuHuwgX4sHkM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8080ed5b-6982-406f-7c96-08dd553aa238
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 01:20:47.6927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hn8+fGaPIZBav0k1QJnwlQzqxZMsbxKuogJlkAiuCCauli5Tvj2EIjjr/qLWwuaIBYQHj9z2A79l2H4RpX+8NGMxLBKb4D81d+bKQhZrJkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_12,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=886 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250006
X-Proofpoint-GUID: LjZivRQTaH2NXTo6prAd1kLCXeoIUVjJ
X-Proofpoint-ORIG-GUID: LjZivRQTaH2NXTo6prAd1kLCXeoIUVjJ


Hi Nicolas!

> --- a/drivers/scsi/scsi_sysctl.c
> +++ b/drivers/scsi/scsi_sysctl.c
> @@ -17,7 +17,9 @@ static const struct ctl_table scsi_table[] = {
>  	  .data		= &scsi_logging_level,
>  	  .maxlen	= sizeof(scsi_logging_level),
>  	  .mode		= 0644,
> -	  .proc_handler	= proc_dointvec },
> +	  .proc_handler	= proc_dointvec_minmax,
> +	  .extra1	= SYSCTL_ZERO,
> +	  .extra2	= SYSCTL_INT_MAX },

scsi_logging_level is a bitmask and should be unsigned.

-- 
Martin K. Petersen	Oracle Linux Engineering

