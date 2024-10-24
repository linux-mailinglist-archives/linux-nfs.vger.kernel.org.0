Return-Path: <linux-nfs+bounces-7425-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D7A9AE6A9
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 15:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882951C21D4C
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 13:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1611D90AE;
	Thu, 24 Oct 2024 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vtt51GdF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LwTB/W3q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0241E7642
	for <linux-nfs@vger.kernel.org>; Thu, 24 Oct 2024 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776693; cv=fail; b=HJG1u98djvwBV4bTjAcZYwHcNc44r280Bj8rqeXPt6hJ3UcFKYKfkB0OWz32Zr0qt1y3zg6tmTiyHQxvzTeFD8Ci/6ieVhT2kZWjKjBgd4gevObRo9oNzNCVOtnkGAsJ9ktlnilsyCNn6lZiMwE7yQ82OAcgSsGygCsVldltFGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776693; c=relaxed/simple;
	bh=tqkylEfMdz4Ov2aJXQnWHzxYk9E6tvDWKg2IELnJMmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F5oNYoBszfB1ZV3NZK6VI3aCh2U1wEjAn3BG050XybERb4z3Gh1AU3ykzpp8l+haiRCNyxcakRDHSY3XFXnmi67KofuUdvBwSMt7+ugP0stxByhp6zkw84HrRQjuCrMnAmnL07OcjqXs7qrd9aHlWuNgXU7TiE2QTMuHAHIPgds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vtt51GdF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LwTB/W3q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OC1Znj002333;
	Thu, 24 Oct 2024 13:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=GMWA7BshNkJ4+PnPvi
	YR1jZsICYb9HauqvGyp66fLCc=; b=Vtt51GdF2fO/rfhSnjMnIdUaHiIkPBhWll
	+1tCZfc4lOIcOmdYHOMEhnFCe5ajD4e7TsrKjHHfaDzDLBvt8Gg9129GZ806qGOA
	nLWgNegQpUNjbHzS0VNB2HOrmJjmIr4Hm4cASwFn4cntvGaiBRYGckqSlxcXMF3R
	C6GznZSgAG9SpbA5Px6lL/ixraXyENz3Ao8DD+PVMxMw8DntyzPikq/OFPowI9Ge
	4y1wFNk8UU9M/kctRT9myYsZgAOaF43c9HgU2kjE7sAErdTTTn5wHvI2m5EPtsuT
	cTzYoPqspXoQZI7kJC9K1rPGvK3KhI7Kvcdb1yOHie8M/+JAVpkw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v2kd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 13:31:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OCoXKN030951;
	Thu, 24 Oct 2024 13:31:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2xytq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 13:31:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gjsu4cEdpO5wLS2uSIjdadcssGWXmnkWEMa5Zv9cNxBSMXcDtP+NcOg8Gmj55r0LTurpCLqrXRGLE2sL6fwGwsYS/jJDgzMPdsCTmcM2+2oxJoA8ZIAUProWB/U3nq7wS3nofxS9hXpzncI78vln5sUD7uF00OvTtEUiRel9PedMxVyp47DXNFvhOgE6uQNNm1Vy8fa14QCbNlEhbz5W1rafWYyz75Uvrf2k83Gv06wRUvtLjYvSfwA9rvasDgiVWY0MU0jMB+AsIrjzpUi5yn/MP1808Ax8ubK+2bShjogWXuNjH3s2RbX5MHWsARRv/kU5ACFaAbnd6SlS90d2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMWA7BshNkJ4+PnPviYR1jZsICYb9HauqvGyp66fLCc=;
 b=AdnqAFQ+gBRVBmfqr8XAHVqOpm4TSKQ1VjjutTRuAsd9P5e8tyn93RFfHrDOGvPxcfkZNYzAds7CjKi4CG4MFwyV+AmzY1GDT2wuTZeguy5iQpFO/lERemRN1+SbSYkTZIkwAO1oBhAQ5hhmQT4Jh4Zbk3N0shkCTSBF5UoEzTwKSOAdZlF65xaFLASDQZlwSBnEoTFg7gnfhgtotm4U7tFAP9PMPyNuYEXyNAyWKrUalq7V1eZzv2yd9oMhObrMfMqj82RWKXX4Q/Lty5w7y4zL9IAFVIrBCE7ZVsxELzeFhM3+MS4ZVT5SROe+KZN4v7OaekwZHY0KNhYhQSTQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMWA7BshNkJ4+PnPviYR1jZsICYb9HauqvGyp66fLCc=;
 b=LwTB/W3qEAbNGdcqUU9Qeb+enPBkNPtZPk0HVs/ud+O+B2HtJvRldy/tzRZS0nLi1csPeJcR6k2QFm/MxypXb1yFPsZ5kkJ0w4lvAAEkuPPWJHdp1t77MgK2YnOYDDshmamuDvg2Te2KDOV3piut9fvy0NLPoIHqLu5zY8hTPrw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5569.namprd10.prod.outlook.com (2603:10b6:303:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 13:31:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 13:31:16 +0000
Date: Thu, 24 Oct 2024 09:31:10 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>, dai@tissot.1015granger.net
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        okorniev@redhat.com, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH v2] nfsd: Don't fail OP_SETCLIENTID when there are too
 many clients.
Message-ID: <ZxpMHtgXIUDgaLor@tissot.1015granger.net>
References: <172972144286.81717.3023946721770566532@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172972144286.81717.3023946721770566532@noble.neil.brown.name>
X-ClientProxiedBy: AM0PR10CA0093.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::46) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5569:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7fb845-6e71-439d-fb73-08dcf4302331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2X6rxZb8ltrdx0swMcRM2MgwI5JpKDuzV6LTYee445hgKhBmRhHd7tHkQxVn?=
 =?us-ascii?Q?LbrhOiwiCNSPPLnEtura2f42YcdO5jIpT0wu2c/gllQJ4N4D15HzSwKZQ0FE?=
 =?us-ascii?Q?2wyXeq1KSvaChBnmRP/7fqYz4kGyXuT2c/8GMp6upAuR3/+ncwUFRljIcytQ?=
 =?us-ascii?Q?sTgZ4QNspc10ZUsUtJBR3FvM2vQHJPlNLRJ4Hu8bc/u8IGcilBE/ijmsjP19?=
 =?us-ascii?Q?TpT8i+lH206FGYkp5v8giOwHP8woHYf32d5rEWfkmIP68Rfh0o1UDCv2LO+C?=
 =?us-ascii?Q?wp6eC5McQxwGF/c5EVHZ203ZRzf5vFUI5EHZUcIZFoVVG2UjZKQJGJt2MklQ?=
 =?us-ascii?Q?31bdvHUftsPQWfxbqpBXerJvVGsIi0HtK3gWBovh8IcSBe2eFQlQaSeRsuY7?=
 =?us-ascii?Q?lxlwWoxFVf0hkr9/56VOBjtKp1wDCzsZuN8MUiNVD9MMpjlx3ZwsnbKBBE90?=
 =?us-ascii?Q?8Rha1YTjXgXMRWpBXKg/JEh6t+0gSY6zp9JunWPWHlO7W4TuZcyx1Wtgv6oc?=
 =?us-ascii?Q?/XxnN3cUx0q8kbjgDkgjlbs8WOwEJ9a+SLZWZqDoTEXtyts7c0iytiEm3lUC?=
 =?us-ascii?Q?YvMqp189+cCey+xsrZrpraXSTAvMTYd3xa3VrOK7znGa+XIQkgkeAZWfRQM5?=
 =?us-ascii?Q?8GgK12Irpse1By72NdikP95R/Q3otuYmPoZuYt/sKWCQIfkosoR5nTgfXPWk?=
 =?us-ascii?Q?KDgTt+QAYkKez2RLIjQuKsP/b0gbLf/NvJ593KnmXQgjotBgqD8kvYx2Imnz?=
 =?us-ascii?Q?69ZZwTNLXcJxMTiKKeTLYiQJV5Nk03QWQRPHwDuy5H07v/jvZtlzhhCySG+c?=
 =?us-ascii?Q?+ZOrmeqPiZGww1De0CpbrSYKASW5vJUgjapRR8f+qwEbjGPv254Sepq5Yqd1?=
 =?us-ascii?Q?6DjkFhfTCbrAzKRsonDfTKkzm00uxJrzLlAnhGWBTYG0DygCbJzxO97fLUM7?=
 =?us-ascii?Q?Z+Tle8mGyTzyGJ7Go4tMt187w5oKCb9h4F7S7dP7DZ7t5ceLGaqwLmY1KHGW?=
 =?us-ascii?Q?cdg5imRcOgNMZas9vyTqLPZwjEYqUlZVocuwZvBB7SBeSO9l0/JvwJNGs6EQ?=
 =?us-ascii?Q?ndw2TAkCAy/0RPNdbyxMl/9NHXIiAxjOJAaQVWYBAuPz72O6sKgaaV0la/W2?=
 =?us-ascii?Q?X80v3bjqeiZEAxkvUIl+vL5BCg5RBh/hffnGJsVV5AMmyzeAKAI1xLX/LsKc?=
 =?us-ascii?Q?yDpXBvy5+Zp3upynEsQI5rFbx9VEFohY0UT0QdfTf7Y9twCVYuYb0me2AHXv?=
 =?us-ascii?Q?XIuAmsKEfxO2k/Lm96Tw//dYXDl4eJe3T62711pJ1fwwEJ0Jq3wfUmMHDxUR?=
 =?us-ascii?Q?TNo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ndyDuHZ1Q9WteukOWgbQlL//c/dmYkwxyHqbnVTqDPfmp2xQH5PzE5xBuCX?=
 =?us-ascii?Q?teUNxsgkZZQUL5BfRFLl41tMW2TKXq4YJf7LpBoBuEFvIjrWYtSqaDUrOV3n?=
 =?us-ascii?Q?aHZ9n2Jwm8JpIpAl+3TH7ncfQk+pGeGkmYr5/vGdJbvvDT72vx1MiIat59XH?=
 =?us-ascii?Q?YbdB+YotC02cWtQlXe7ebR12XBIMeD/NA/OpxZf2KB6IXNYEEjkEfNACAhEg?=
 =?us-ascii?Q?96xCR6SdgDZ0hEpKv+b+UPQIks/rRflwV29TS//AtW61O2yW4vy5pzpS/re7?=
 =?us-ascii?Q?FPnQp0Aj9yXkQ2DJtHzw3I84O+mDNkA7uD6Vdsj4nT1coWT20lTAgDZ4rgjQ?=
 =?us-ascii?Q?p0FmXd19UsvTp1cHTLdPHB1qC8eEvGBHFM4s1caBcrCpUCapewAXU9cqPF/X?=
 =?us-ascii?Q?RMVj7bYwrymZjL5RshBTlrh8VPhG8DpxkO81yL6PYo7guw2IuQyt3Sfj0Jom?=
 =?us-ascii?Q?OOt7B726vdWtQieFNBMxUgfNGxyyP3fS/G280exQ/0dmH0A4rzVdGdFmqqqU?=
 =?us-ascii?Q?gbPD1+li1HJQyQFcxRErOEW8fPB/4faqbwCWaLCMfBnFwqkEuiYCbQ3yRETw?=
 =?us-ascii?Q?c6r7Pd/vjZEzl8hDoyAxGfP1Su9B6Ua31IL2lTpbIUptA6owG9PNx7N/G2xc?=
 =?us-ascii?Q?k6PKBWZ6xPRmQb4a5NIBBqyVsh6Sr67sQTtqz/MgMeThFKZlHOwCh2YO2BKK?=
 =?us-ascii?Q?BWr8tmYjx4UkCk5qWTUwvIaBga+36y5Y99xvRaAxIpvz1DEGJPNbQYiFFNFW?=
 =?us-ascii?Q?nDwCZQ1ChCeYkh3uwIcZ7Ktim4ZfrIoTns9ng91dtkh1ImpsAe4jOWdiyL3o?=
 =?us-ascii?Q?v3lJmkswqvEGbi/RaiJFbcJb/XoqrVonskM4odrRU4S0q8UpsruZmuLWSH8H?=
 =?us-ascii?Q?4BaRtsSO06R0VO+s0OG6qyYnIV+NIvexSKIWKlC5fACkgofTNLs1702V0BPv?=
 =?us-ascii?Q?FO6r+2PrP/AQ2zxKx30gCfkVoEBHCFSKY3wyQ+ifoa0kvNBdEN8wiZiSAoZo?=
 =?us-ascii?Q?j0HVb8iGqavUNQD8qpMrX1GRBCCIIIOCWkPsQxCDeDWcPQUUOnGgN5cwIzV4?=
 =?us-ascii?Q?eLm1/H4yOqivKG1qoDGIAKoFWgBwYP25S2/PQwROkhJJQk5DrPfA1uvhGd2w?=
 =?us-ascii?Q?TQSCXXpTjW4yT7CMMR8weO7Y2k2JpX+bNm+WKrDxOWGsK0nbMgowr7l+fzzy?=
 =?us-ascii?Q?n0vGBELSd8RyG8uvj9HbfGBn+ywcZ4MQbm1xspu3n1sIXF7AjsM9F0H79IFg?=
 =?us-ascii?Q?vDaLEWNpdxWCFijvN/3l341LY4PH7q1xOAXAju+B/HjNQzscd3wTgkJDbgVO?=
 =?us-ascii?Q?TFYMnxw4a7eP7O93eJEcdMXhHA/0hEY7btuMWpTJrgFW+e22URdu6liqruM4?=
 =?us-ascii?Q?Ka1Dl11xufgf8ENyqhV8wWJLPz693TtjjgNC2A20Q3wBVJu70AwTZjx1JxOa?=
 =?us-ascii?Q?nV86KAwJVWvK5CZas6RENZA7pFE3g7N75cq968o2RhBuCvW99j8f5ijPFMBh?=
 =?us-ascii?Q?3yfpcq14/YCkplfbm+hLDxECCtHTvJptQI+3MN/AE+Z95UGUYk4EuNDuzJTX?=
 =?us-ascii?Q?7Gb3C+jAQGaojp5/UlJRAhPGxtfRoN0zulsf9aaHUcjTvxZV1XWTINNga+AG?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RMgJ7W3LAbL95v8dW0iVUysG2yJZ5zQnon9tr1vM9Rxy6keSj/vztKlBq7swZnU3RuHMeyulv6c/Ccz3OpEhDfgZICsYuLFARFoP38hmmoeFDglL7GeFom5f0IkavQYWSFxWP70lY4w2diBaVGZNyOePTSLSDcpj//cmZgVg9YxYT3J7xZ1EXOMToOtyctrt7ZIkMovlpZvZpYjT68hkeEg1Lfd7EpWv/5uLCzjoA/RUaLqckRDkwz0uQ0tTBIv6Dlel8K/2i3AltvTCLgk3VG8UBeZ9t0xpdee9e5wree+XYfDHAo7F7w7JJm/zMPHG+2MPSyF/m/fXKtX/YgLuqaiGfxdV0fbqA67JbR5wZnkiE9UPQkMC8+KTjLZtayBRDWy3q46/7QrTj1GlSiaaKt1wLkH+8/O8OmMY+ZRYsfXUEN3HHMHvrNrYPVlrB7SkuwzCJmfH+iyS+suX2UL3BcEz/NVMBo7Y9Hv/JedaSFa91mrF/0Bh8lWALck/wLFju739OnyIpETuGF5q0qdlK68XCZUwGdD+Hi9qQLNKhw0hV7Tu0gwCthRya9n+j+yoUKU0rt511EEEXjMHp9iIK78/vaqnvNzBBCkWVvsPoEQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7fb845-6e71-439d-fb73-08dcf4302331
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 13:31:16.7909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obOH1Xbs2TdWlOKnw4Z4y0XaLS5xrLH0oE5NT720MArBixoIBCvHGJNVRgdYd0nDCOFQBSiLzbemU4SWY/0wsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5569
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_14,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=942
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240110
X-Proofpoint-GUID: iW5cpX84Tb5uWRnQD1jgvGAtkRTOH3bl
X-Proofpoint-ORIG-GUID: iW5cpX84Tb5uWRnQD1jgvGAtkRTOH3bl

On Thu, Oct 24, 2024 at 09:10:42AM +1100, NeilBrown wrote:
> 
> Failing OP_SETCLIENTID or OP_EXCHANGE_ID should only happen if there is
> memory allocation failure.  Putting a hard limit on the number of
> clients is really helpful as it will either happen too early and prevent

Do you mean "is not really helpful" ?

I recall that Dai had suggested something similar in this area,
while he was working on the courteous server patches. Dai, do you
have any comments about this change? If not, can you send a R-b ?


> clients that the server can easily handle, or too late and allow clients
> when the server is swamped.
> 
> The calculated limit is still useful for expiring courtesy clients where
> there are "too many" clients, but it shouldn't prevent the creation of
> active clients.
> 
> Testing of lots of clients against small-mem servers reports repeated
> NFS4ERR_DELAY responses which doesn't seem helpful.  There may have been
> reports of similar problems in production use.
> 
> Also remove an outdated comment - we do use a slab cache.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d585c267731b..0791a43b19e6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2218,21 +2218,16 @@ STALE_CLIENTID(clientid_t *clid, struct nfsd_net *nn)
>  	return 1;
>  }
>  
> -/* 
> - * XXX Should we use a slab cache ?
> - * This type of memory management is somewhat inefficient, but we use it
> - * anyway since SETCLIENTID is not a common operation.
> - */
>  static struct nfs4_client *alloc_client(struct xdr_netobj name,
>  				struct nfsd_net *nn)
>  {
>  	struct nfs4_client *clp;
>  	int i;
>  
> -	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) {
> +	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients &&
> +	    atomic_read(&nn->nfsd_courtesy_clients) > 0)
>  		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> -		return NULL;
> -	}
> +
>  	clp = kmem_cache_zalloc(client_slab, GFP_KERNEL);
>  	if (clp == NULL)
>  		return NULL;
> -- 
> 2.46.0
> 

-- 
Chuck Lever

